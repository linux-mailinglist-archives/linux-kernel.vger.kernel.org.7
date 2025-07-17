Return-Path: <linux-kernel+bounces-735843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563AB09457
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF4A16A3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED8209F45;
	Thu, 17 Jul 2025 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRFbSbLL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5352F7CEC;
	Thu, 17 Jul 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777981; cv=fail; b=d3A4OrJrIkJDPOZUk/G0MOTthejRLLn05HQP3EliQUo66ta9uqlB+ZZdgADNhu+PG09XTVZNZvs8gTn7MDScYnzKIVNa1HxcbBP2tJ8cq7+1wIz5ZY6sE/WTOfxcunIOWqd6W5XmferXYpbXYgXwv5j6rWNP/7sjpSQUwm3JmH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777981; c=relaxed/simple;
	bh=3ua/SB8taoGaymf60E2ej8w+2UaihUSX1kcXvm0gmEA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qd9B+MXB+ko6oxOskINH8ngPT0ezo7M9xBY2Ir505D6KXhHz9GFhYx1vpGY8AF9Ui7JyhSpSwxwKMdwmxu3WwfgQ2UWcgADAcBBMH1ieOVtctN9FneNrWX6AgfY/Tn4YL1ynTxbhXhknT3UfcgdxQkVirExKcoY4rGi3G47w8aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRFbSbLL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777979; x=1784313979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3ua/SB8taoGaymf60E2ej8w+2UaihUSX1kcXvm0gmEA=;
  b=jRFbSbLLebZTlJYKbG9jvTqcmZLQ/qIMMoGwJS+o6nGgdpx8L4OTzpkB
   MZVWHnvbfLpo82hEQyp4A8+KH1ot6HvbRoYXOGjtOPINUXvbSp97U+1QZ
   UPXGzrN2FIbgCtgLTjID1U3TXmDYNJlM/dDFnAkd8E5wRO+8FCytMSJjG
   qo+jP0kzT954afBCWT3N1gzAhK3eLObXMHImaStpvTGAusWEL0vvnYNE4
   KhDiYqa1JPV7LwYG7mSGV2N1MLPqEhINRk+LvU4UK4+W8+TMUTP7YT8Go
   P++scLMCFwfI8AGU3d4sdYvPRg2uFWbaYpNC9t+/pkgOVVC4ZFoX7by16
   g==;
X-CSE-ConnectionGUID: LIQrM4dPSays0b/06Lhb/Q==
X-CSE-MsgGUID: tSFOdWkkSWyGHZc9uXeL8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55192148"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55192148"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:46:19 -0700
X-CSE-ConnectionGUID: ptuSY84eQ8uyQizDIe1EuA==
X-CSE-MsgGUID: 6pP66DqSSoSAs15p5TkWdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158440645"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:46:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:46:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:46:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ng7Qq1cvoFeW6xZa6HEtm9B77iW0UXsBu3T8dZruqHDklMa3q9LiOng3EZO0ma4O8RKZgzm7iPZah+Mz47NFIz7VXYQpnEaSmihpx4QUJe2aPAd9LxOOvNjfS2PL32is3PmJYLA4sJCrLpuIYzqgXZTQL1ve8KKcYdIu/33TVidJCNdYx2h8rTTplFdO7FASRkeJI/kCzA1rtVIa+hcBvmNrLA+O6HCGlLq6ITFu4tw1kn7xD0gc2AFmW5k5ufSyFNtqvkw505Q7VURhcYm1LXtltRDj+LzZbi6ThUKDLx1oamMfLwxKcjvlhQps/uAUnON9twtWpGQBHnr7PKtQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRku6iGk2GgS9D4wHFPQ5toIe3XhLspSzkomnoYAMRY=;
 b=XsBH135C3qi/TSFbhpe9PaBbupM+s+RighIGhwmQEiEBCWZ9IckJE14yptJD7kcsaFIvCvL4ikzjmlXKjz+b4dXP7iMd8um52NlYhWCvHvdX6pIfylvaWddS6HWEbcq7vGcQieoP8mj0hq7ca5gvHutCLUOnlduEpuZvR6yrq3myXRUk0uH2Z+A7NkOtFZvI3am5rdj9j2H+iT6I6u+dWJugdp3z5DIf4qN5qWeGp477bY2QKjKfvmXogt9DFDnEv3GuPIyIGNrCh1wZDAHmVIK8atXPX53sTQOLa2J8CX+/zC8dQxiFyi/oQJOMWCQvROKSN6GaYm6PzoELvkEiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:46:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:46:11 +0000
Message-ID: <259c8d15-1af0-49d1-b202-d68ef2a42cee@intel.com>
Date: Thu, 17 Jul 2025 11:46:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 09/34] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <1dd845e0cc1d7a771da1afdf65e799e4fde6b5ed.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1dd845e0cc1d7a771da1afdf65e799e4fde6b5ed.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 9543353b-7763-4d0d-d312-08ddc5623339
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmFNQW1ZTVltb3o4YTJ6VldxT1ZzSHIyUmx4aGhuMDdneXRoUVFBK2l5Z2dD?=
 =?utf-8?B?ekszMzRvazQvbE94bzdJM3dFTXRIVmRTb0JuRDQ2emJUbG9iaEw3ZTg5MzBw?=
 =?utf-8?B?UG1JdEx6S3BhRE5Rb0pCNFZkSURHUGlBMjBaM0N2MVNxM0QvV3FRYkQxb0xJ?=
 =?utf-8?B?Y0FjcHlrSzkrYUNhOWZFQkEwbVN2TU52a3pPcC9MOHVOYi8vb1d6TlFxMkl4?=
 =?utf-8?B?ODVxUVZoL1h0OGI5Q3Ribyt2bFV1NE9lZFdYSk5WSmtYVC9Yb3grRGowZXI1?=
 =?utf-8?B?Z3orQjBidkpjVy9OeXFaYmVZWE9UWmt4V2pSejdmamx3SzEzVXU4UVQ2Vjdo?=
 =?utf-8?B?Qy9YWUE0dUY4UDhQdEN1cGtYcjdTMldwT3dhaTE1Ly9hZi95TjAyQ0xybVh3?=
 =?utf-8?B?OTF5RG5YMS9mMFQ0dTNma0VIZjc5Z2gydGpndW5PRWVjRWRLY1RvRXFPemI1?=
 =?utf-8?B?NS9zWWJ0eklIRHRXTDNiOFo3dDkvczM3NC9aRzlpYi85TjE5Ym5ScmdzNDU1?=
 =?utf-8?B?SkhCTFlpYlNMcHI1a3ZZWmVOWjNtaGpBTlIrd1pYNzdWbGxzTWdLVFNWLyt2?=
 =?utf-8?B?cWxkQld1RnVlYlpwY1Q0aEhpVG42SXRBU1hrbnZ6NE1aTFFtTG9xbHpUdllv?=
 =?utf-8?B?QVBEY202V2YwR2JRaWhFcUl5bk10cEtpMGQrUWd6ZUJud3JMK29pYlAwTjFM?=
 =?utf-8?B?VTZmY1Zld1paWmdHckdKckUrdnQ2Q3Vhc25kaWg4N0hwSitnL0FQbDM0YjFF?=
 =?utf-8?B?QjB4RnNCV2xYSlJjTVhmcy8wWEdaeVQrWW5MbVJJOU5NSzZ3ajZZTVVyZVU1?=
 =?utf-8?B?V283QWdWOHBINlgwcGdjQkNCMDFQbnFaTTJaUDUvMlZhbUloYnVmcEtubXFU?=
 =?utf-8?B?UjFLOElsMGJkZUQzUjVSNk02dFU5QXh4UzVFNk5vM0hraVlrMGJmNWxYWXZB?=
 =?utf-8?B?bURlTTBibHY1R3BjSkRzMFp4K2ZielhrYnpzV01IT2dkTnluc25qbThLSktZ?=
 =?utf-8?B?QmdCQlFSOFMwSDg2S3pTa2xzVVJQeUMrczJaYVJRdW1xaEt2R3hVeWc0Ulpa?=
 =?utf-8?B?K1pwY3BzQUdSWHo4blI3NjZWS3lpR1Q1TmZ6aGgyU2wrS3kxak83RFNHeGFU?=
 =?utf-8?B?K0VaL1FCOVArNnE0dktqbnJOYlk2c3YwS092YTZxQThCN0tRK0FrMyt5Q3Jk?=
 =?utf-8?B?STVBUFE1Z3FsclNOTzhETFhqcGZDRTl2NnhkWndPWHQwUVcvR1dqblhMOXp5?=
 =?utf-8?B?SG9rUjdnbFh4cW1MRlhnb04wbWg2a2lVUm8wY3VkWEkzRXUxeklBcC9ISVJZ?=
 =?utf-8?B?Sk5SYkJOTjZJblhlZ05nbG90U2g4cjBiaGtVZXR5Z1F1MDk3cTUySnRXeEhB?=
 =?utf-8?B?ZkpDRnVFOEpSaEdUKy9jVFM3MitTREc1UEZmd2c3STIrVWNWMG5SaUZzVVhT?=
 =?utf-8?B?TVJtU01UbEgyTlJQODg4eGkxSWZKTE9LKzJzcFpkKzZhN05LRnF1ZnFuRmk3?=
 =?utf-8?B?czNYeVIwckgwRmRjVi9mb2ZsTEJrekR4SVpHbEhKbXh0amR5WEprcFdLZ0E3?=
 =?utf-8?B?cDFid0tQY0FwMHJ1RE1JdG1NaVJJN1FiZkN5SkgyWlJoS3FaMGE0ejdxeUNw?=
 =?utf-8?B?OE40T0c4MjBVVWR0Tm9lRUxIQWhXaW1kenovZDFLZml6SERZV2x0eGVycits?=
 =?utf-8?B?MFUweHRWK1AvWHk4dFVyR0FrZk9jaWVjSFJ5RWxzcFhXNy92cDNPQUtpUUtu?=
 =?utf-8?B?QXdUNmpaWGE3TFVqaVBnU0xlekxlamlPVzNnTkFDZHorU2hOTm1DNmZRc2t3?=
 =?utf-8?B?eDkwSFdmNkgyZGJjemxiTEtEbE82VERCOThPY2YzeWl5VG8vYmQ2emtsU2JE?=
 =?utf-8?B?aFVibERzazRXZkRJSk0xQ1V6T0R2bHkvclp2T3Q3M0RnMHd0UzhnbDNIY0pV?=
 =?utf-8?Q?WuK3ll/yRfc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTR2b1doeEIzU0RIUHJiOEJTZm5rTzd5VWxuV3pjQUpKMTNNcnQ4bmhYVWx4?=
 =?utf-8?B?djZKK3ZXMU0zakJNZXBvTCtTNnN4K1Zhb29vdVk2YVFTU08wQXBodVRnSnEx?=
 =?utf-8?B?QnRCaTdsTVMyV015NS8rbzdNbGJyQW1hb0tRS0JwTDhLYjllZWlaOFFJSzMw?=
 =?utf-8?B?SmduT0RJUzQwa2N3ZkhQRG9pU0JvL3BkdFh2L0ZrZytZUVdrc3cwUWx6Yndk?=
 =?utf-8?B?NHZYYmJWRUxiVUJoWmtPOUIzaUpmNkhxb1VNY3VOcWhaazFHb2VTZTBBUGpB?=
 =?utf-8?B?OUlJakRobUdESEsrNTBXaHh6MkpyTEVSckdXak0wQ1Y5dGw5VjJlWnJ3RXpj?=
 =?utf-8?B?dHZ0VGQ5dEYwRnNsNmpwUXZUajI4Zm5Wb1cwNG40M0RYalBJVmQ4OFVsMVFx?=
 =?utf-8?B?WkdFUDhjblhYYnFZcGlEUmVHcUVZU1htT2RFU1RiKzdjalVxNFVWRXBtSngv?=
 =?utf-8?B?QWJyY2RoZGt3MHN6NHkxa05yd2w3LzdlKzlxTkk2N3FHRU5MUk5aeVNLRE1G?=
 =?utf-8?B?VENwVS8xUjhleFVxMUxEOTJQNDdwcUM5SjNkOHFiSGFNcnlONkI5RlNDem9p?=
 =?utf-8?B?NTFrUjA1bjcyV0Y2aDhJdEtIdUdPU1duS0UzNVp1cnZaOUpiRDU3eTNDbkRs?=
 =?utf-8?B?WWRXajF2SGdJb0psTklRZ01TUkdrZXNCYzdQMGQva0x2TGl5NDUxb0haMU02?=
 =?utf-8?B?NXllV2w2MzhwODVnZVB3QkNsQURSOGlzUkVZZnkrUEpOTUFTTnJWNU10dlNO?=
 =?utf-8?B?ZGw0c2FkdHZtbXhuZHBCalRoOCtra2c0QmtCMkdUNi9UTDdrUFllRy9qdi83?=
 =?utf-8?B?SWFUVjRiYkR2TzMwTmhVaXB3Wlc3RkpBUzd5SUZQZnFnWjdoZE5sNWNoSG80?=
 =?utf-8?B?S1UxY0IvZGFBU1Flbm9XY0RmWWRjR29yQm5nYk54RFZyY3Z2ZXRQWkJBTFFY?=
 =?utf-8?B?dVZEMTdHbEYwTFladTYzczVhamhZZHNuYmpVZ2FOVEpIQkNZbnNNdHZrbkJo?=
 =?utf-8?B?b1kybUplUEliSU9weDlUb0c4UVp3ZXFDK2hXWnZNL0hJQi9rQ0Q2UUh6SUZx?=
 =?utf-8?B?R0dTUFk1dHJBejhqN1pCbmZueFdlSm8yazd4SWpzaU1ZdG9yVGtpVEVNVzc0?=
 =?utf-8?B?WWlLV2hDWGFpTnZKcGMvdi9KRHRuTkJ1SUZiVG1GNGJIemtxL1ZpcURoOS9o?=
 =?utf-8?B?WkhNbDNvL3ZHbVE1QWlHdXdLOEM1YUlOTnZJY04wRFZ6VW8reDUwWGlNaHVx?=
 =?utf-8?B?SUl2azRaSjVTS1lsYUJVdmtCNGQ1VmQ5cVFFUG56Q1dEWFpQbElxek85YWlF?=
 =?utf-8?B?cFRVS1ViMnpjTUpncWswMlhEZEF3SHpONE9FL0V3dmlQRjJ0cUpVRjRJMncx?=
 =?utf-8?B?NTJxcEhhNUpvUTR5Vm1uTWVMRkg2YW5RRERHVUw3OTlocjdOTzExK2dUMHR1?=
 =?utf-8?B?K3Q4a0dMVndSUHJKWGNBM09yV3loT3pCclN5aGswZm5KUk5TK290ZEVMZUZ4?=
 =?utf-8?B?TTdBbG50cDgvUVc2QmNjVUhXVDRqdm04M3poZmpVcC9FblUyR1FoWXV3MnpM?=
 =?utf-8?B?UVlNWUlMNlNZZXh6TWhTallPaHU1VXR2VHRnUmtYN1Y0aDIrV3ppZ3RoMlBx?=
 =?utf-8?B?Q3FlT3pmdnlLWmFUNkZRQm5IS1hsaEtDUnpjcHdpQWVzZFlvRFFXOWoxRDVs?=
 =?utf-8?B?SGl6VzRCRDRCVVNWWG1XT2hLNW45dmhyOEY0TVNEVXVSYjJxbjAyaWl2RW4y?=
 =?utf-8?B?MXB0ZVNNU0VqWXJvdFJKU295NFRGQzQ2ZmpDbkNwdks1dTJWcEMyeDZTWFhY?=
 =?utf-8?B?dFBHcXpXTlZZMUlLeWFGbk41SDNLUWdRb0JRUGQ0M2lmQVFYSG03cTJManF3?=
 =?utf-8?B?M2FTUjRvT2swWjBrOVpUTmNEMEg3cWYzTTJkd1BOZWNOZS9VRTEzRHZCVXNP?=
 =?utf-8?B?RGg3UmhoN21tMGpkL2ZQTUE4Sk5hY01KMEZUNnRBRmZWZmFzV3Rxc1Y3dWN3?=
 =?utf-8?B?MDRuWlNVSmtDNWhIR213YU8wNlF0b1dybzhEbkZ1SnJDaTRoUytRdFVLY1JF?=
 =?utf-8?B?V09nNEQvdjhDZG11MElBMHg5Yy9lcENDUy83MjljdEdYaDhpTHdUZVErS2k0?=
 =?utf-8?B?RlA4VklPdnM5Mmdpc3V5YWVxRkJuL1lycDdIVW5MdUZ0amwxUjRua3pLV1ox?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9543353b-7763-4d0d-d312-08ddc5623339
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:46:11.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gy8IzzaBbG/CJNahOfrVANJ26Ua7pWyKZ0/4mg85tTrPBxG27aC7qMAT49Zj9FwLavhisC3W/xBaWcn/G9VqIAOgEVxHZf7Hkb92znXVsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> Add the functionality to enable/disable AMD ABMC feature.
> 
> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
> L3_QOS_EXT_CFG. When the state of ABMC is changed, the MSR needs
> to be updated on all the logical processors in the QOS Domain.
> 
> Hardware counters will reset when ABMC state is changed.
> 
> The ABMC feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

