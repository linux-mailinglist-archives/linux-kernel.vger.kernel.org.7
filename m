Return-Path: <linux-kernel+bounces-736237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 915C8B09A56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFC3564200
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D651DB13A;
	Fri, 18 Jul 2025 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5xdz605"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F81D516F;
	Fri, 18 Jul 2025 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810935; cv=fail; b=lETL0WtXAOt5Ar4eoWYFc7bbRXWT5aGTaUiF4vZ1Hv/iKlysIIjmtGNef/06RUUwy9i4ZRwXDUP9R9BQdhQ+mN4igqNiqukQMe+e7mNbQjdRrmjw8A506FWqUoJKlA/mqLmhQEiNDZR3oAFh/l8pxCbOvfAF0CgkVZ+RG/aQDf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810935; c=relaxed/simple;
	bh=fJKTJceBIMNsisWwfO4focK9U1lGwz+i1Pzkt1/5M50=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iYBh3dWOHE2cvujQ9p6IrcEH3UiEZiUFYxRS6AN2zwC98MIdDY0UbjFBqqx6WVi/CCUSKWDd8YzfqFRbq1IFkcEYLpIAVhCgTf3/JA7fjqVsDxU4w1zXy+At8UbmuyxfreUIcaWlMZN6+EnqBxKoO2THKXFNU8LJuqQpQk9aZfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5xdz605; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810934; x=1784346934;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fJKTJceBIMNsisWwfO4focK9U1lGwz+i1Pzkt1/5M50=;
  b=B5xdz605PvOE2So1vnXpXkRiGOxFiKOHsoTNO+MCAhCbmu9PL7lueQT5
   t8CsXOitnYUxBqAvx26USDsZZ56gFpnCQ6frUbp8xRp6Xnu6fSzHCAfa2
   xuWPWmTogc137YyKv3NEJWUiZ/pUcOf6ML4Eh+nAmw7acfprjY0XWnQ9R
   qF2lk3xl+4vlnGkZ33nEOeHdmKg5G3YAb9J1Kx+oQFEMFQpmBH+jw47kR
   GLCdETJeQU5wOF2ol+ojEFKuWG7/+jM2LUlkBiOzAqX5o09IItjwD1iIy
   3lstYaDu8prdqUlqkHZAXF5ZI+aKNAeNt8nnZ15P2H+ZGfqBmjIExrKPu
   g==;
X-CSE-ConnectionGUID: bUNVgvNGR2+MStFg4t93wA==
X-CSE-MsgGUID: cS+xpW5sQRCQdvK1GYDmzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55040778"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55040778"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:55:33 -0700
X-CSE-ConnectionGUID: PCMIdz6NQLWwqp5jaBruJQ==
X-CSE-MsgGUID: IorhK5GaQoy/jXOYkl36cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188941199"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:55:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:55:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:55:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:55:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeLYNdWvIsOiTuzYjBSUuHq7AGYj7O6PbpV8lUKCrc3ZV36YNZ3l0Ugy3uhCMD9pN5dJ8SpE+NkawkZdYUEfkkCfPEE9DEu5YwwsDuAA3V/G1k0WigmhdQsItBM/gb41zYcHDBcljiNMBv85ey0QHLbYcQW72kxN69jAQRD6aaKV5XZ429/XEWFvFi5liwUEr7hs2hps3Mhq86GUgRzxs3AN/5wUSRInaw80Nc6qx1ml/vv5aqb+0EqU6mwsV5FuHWW/TMGN4fSUITSqHyX1uDRUyzQyOCJLoaqqEbdv6FOMw+mTppAiDvz8qi2NboBirY2tZwrg0w7krB6+pM2qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xibbWYC5fEtPcM/jp4QwcRNmkFLxU2s9DfSVIMiMQNE=;
 b=MEIkreXCU+krdN+TJqmupB7Yw4uqmu/83yxCtHsYgFlczW0MCrSLhhhC7wbaZ1bMVEyNCK8PTPI72PzHAsF/Aw5YhhzNmf61xceNO5Uuj/JqCG2rEoC6WfZfkgXC+Bng1MaaPf+YvjL8pXOhAkNZZkC6qcNxWbpR9n22n9/myjH8APwwsvHv5sh8JYxRvop2a13IaOG+dP7hl4mPLGRPGrkJWlh4kDgfepspC6gznEHnVYFLbVR7UCiixNF8z+5/7XI8WU51gdm6buLT8q4kXKH6PEJRFa++ap/zzSOhVqxj1kXtkmDyrCQI+aUPbw9MheMFtih9SjZVbHAovOc33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:55:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:55:24 +0000
Message-ID: <e3a6e460-b7d8-4164-ad0d-894e78c323d1@intel.com>
Date: Thu, 17 Jul 2025 20:55:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 27/34] fs/resctrl: Provide interface to update the
 event configurations
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
 <8213746e89e4813e397043325520353ada56651d.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <8213746e89e4813e397043325520353ada56651d.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b4e4cf-4412-4ce0-da21-08ddc5aeecc6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUlMZC9TMHBwR3NMOGdkb3NhUFdLNFNkUTh5dVVNai95a21ONlprQkM5Z1pv?=
 =?utf-8?B?MTVqMFhhT3E3S3k4N0xlbDhIQUg3UTV2WTlNUUxRSmJUN05zLzQ5SmJYUnNJ?=
 =?utf-8?B?ME5wL0I5ZXNYbkozdlVkUjJRUVo0blArRXZuazNRRjhzdUlXR1QrYkwvREox?=
 =?utf-8?B?eTMram9OeDd5M3JwT3krRW5KOVkxUTZwKy91NHl0RzJKZDBndHFKazBqZ0Jx?=
 =?utf-8?B?aFBWSnhqcFhkeTgvWU9ObytKWWlLeGNxOCtPSnFLZ3hOZnNNbis3Vnl2ck5t?=
 =?utf-8?B?eHJybTdZZ3BYaEVOUEN3ZzlBN1pqVTN2UVdPWDJMSTB1eVUvY1R1aFV4aHh2?=
 =?utf-8?B?eUtST3g1eDVwZDVVMEpBY2lLOURZTm9OdThZejY0dVpiT0drTG5zYW5jaGJE?=
 =?utf-8?B?elNDZURMUFQzM1FORnR0S0tpaTZDM3pBTXcvUDJ3YkZNeFkrcU9zWGY2ZDVn?=
 =?utf-8?B?S0FGbTY0RmQ2aFBULy94UDRYa0ZBcUk0Ync5ZGh2ZHgyK0tPOVFiR1U5Y2h2?=
 =?utf-8?B?WnJvaS96R01nY0VkSkJ2c3dDb29ZNmwxK2plNWUyazNuejdSS1NkTFlBd2Ni?=
 =?utf-8?B?OGxkV3ZkLzFtS3FjTzh2UzB2WE92NVBhNm1NdS9xdURWR20rN29Td2xPT2Iz?=
 =?utf-8?B?bk5lV2VxbGY2ZVp4U0MrYXpwd0piOUlLeGJmVEcwTS9Nc2tDbmFBSzI4TTZD?=
 =?utf-8?B?Y0Q1QTJ4YitWU21wbkRMM3FWUFBlbkpMRURhVVd6dnNuTlYyKzEwN3VsT0dW?=
 =?utf-8?B?RmtwbmZKQnhqQmpERlF4enRqRlpNTUViVjJPbDJ0ZFN4YjByNzFzWEd4aGxU?=
 =?utf-8?B?VDJmOHNCcUxuMnNFd3d6VVNyTzRpNzV3MGV1aGJpa3gvWkJOY0M3bkhYU0NF?=
 =?utf-8?B?VXBrd1pCb0VBODVGOTM1ajVad201TWJLU2Vja3BCam1LdFViczBYMitqWXlO?=
 =?utf-8?B?dGhLK29TQmgrdDNWWkJTRjBxTW1Zc2ZRSzFkSHYvL1ZuUVN2SXNhZWVENWRr?=
 =?utf-8?B?UUdLZkY0Z1p5SWRoY1ZzSkd6aGwzNllDUzYrdG1hUlFvbzAvOUNpR3IxREUw?=
 =?utf-8?B?VURCYnZ3cU12TFFTTlpZR1hhVWN5K2hRckZYSFFINjBERmdIZmw5OXI3RmFO?=
 =?utf-8?B?VUdXL1VkTTFnSWdORytYRi91Q1RObHMwY29wTGpZdWNXaXFBS1U2dG5sWEVa?=
 =?utf-8?B?MUROWlRFRmJkYkhIT1dJRjI4RkpCWnNYSVFtUUZTZWFHTjl6M0VUYUdlYmwv?=
 =?utf-8?B?S2gzREhHbFRudzhpRlJJL1lFRUxjRFVnNHRMSGFReVgwejY4UldDL1dhMk9C?=
 =?utf-8?B?UkNuOXhKa2dBbTFvenRzMjY2c2x0T2FGOFdFWFBBUUthUU9adzBiQzhLSUtq?=
 =?utf-8?B?OGRZdWxKVHRuOXF5ck9SNEdpT1duQkFvcTBqYnNJTVA2eGxmRXNRMEdneVFk?=
 =?utf-8?B?YXBKcTJTWFdmSGR0VmtTQk1zbHZGUkFXOGlPYkdIaDdGQnptaWR2OHY0YlYw?=
 =?utf-8?B?Z2dmRXh3Q2lVOVZ2YkRZZjB1Y1NybjNUVW4zUVFJN2FSeWdkb2NycWpJY1NK?=
 =?utf-8?B?K3ZwSGs2UVBpU2hqSTVNZ0pwS2pqbzRvUm03WDZaSDZiTXRiSGVPUzhkVWhD?=
 =?utf-8?B?MWlDVzV2Q1VESlNkNUVJUVJ5a1hMbjc0V1A0cU05OUtQV3NMVG5TVDBhdlJv?=
 =?utf-8?B?UmhmVDZ2WnVnM3gvWWdGbEllMHdNUFNqbzV2WFlMZGpXS3R6ZmdWOGJUNGpv?=
 =?utf-8?B?RXhUK0dzeUFkQkRKTXVvS3d2TlM1NWpVb0hVV01IdVZHd1ZYTFUwYUh5Lzdt?=
 =?utf-8?B?ZXFxTUExazNCQ0pYK3BKQ3c4YXljRzF1NHp1NW5qeGw4L1ppZ0tMVHAxY0xO?=
 =?utf-8?B?U3FnWWhEY1hlS094cWdqVEt4RUlibjUraC9qZmtmMGdPLy9oYkRkUEEyU3B6?=
 =?utf-8?Q?Xj8VQ98SrZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmlOU2FSYi9iRVFSSjV2YWE5TXF2Nm5rMTdONnQ1Ui8yOGRWNjhlMUNSaXds?=
 =?utf-8?B?aXJNMXhuMy82NVZxeEx4dzQwVVI2Mzl1NGkvakZBZTFvWmRtOGNJL1g5d1lq?=
 =?utf-8?B?S0NseUhWSU01Qkl2MXRGRC9KRFZuaTlNUzR4UTVmclhsU040Z04wMW13d2Fm?=
 =?utf-8?B?VDlwaUFuYXpPc1BXZ21LVExOdWV4L2pLQnIza0tTMC9xak9vTjdwN0tZZSt1?=
 =?utf-8?B?ekg0aDE3UE5SaDJ0K3dQRW52SUQ2Ly9QWm9hZU5odHRtWXIweGxoS01sTitD?=
 =?utf-8?B?clp0R3JIWjN4OE1SQVB0RWNYTzhoWkdpbnlQeGtiOXF2ampaUzVSOTRJWC9p?=
 =?utf-8?B?WVJIT2dZT2Y2ZEdQcERCUm5sQ1g0SCtvTzk4emdBM2k0MklDSE9SaUtSL3hv?=
 =?utf-8?B?WmYyZTJFT1ZhalRhdFRJbldQRk4wVlNqZFpSeWtXREUvZGVSaU04MFZFSHhP?=
 =?utf-8?B?T0I4N0NSM2tCaStYVEM5a3YralhOMkxWRndkdGN4ZEJ0aUYyaTVaZkZsQTRx?=
 =?utf-8?B?S2ljZWhaVXpIbW1PWTk1bzVZcXpwbzBsWEFXTFJ3RERlcTBRMkFLZng1cEc2?=
 =?utf-8?B?OWN2Ujh4UU5JZzRDejFucUIxdHBsSncrRzVtc1c2Sk1IU2hSRzViYi9WWjNK?=
 =?utf-8?B?cWdZZDlxWVQrSExEVTRsUVFnOExJVDlEY1pJa0JDS1d5am94QmxUZkx1NWZ2?=
 =?utf-8?B?RjV0aUl1WWowbzBOVm13R2NrdFczWVc0NUhjdDNJdDFMZEdEZ1Y2bFEzeUZY?=
 =?utf-8?B?dXdsY3ZSbnk0dnd6TjAzdVFVK0JmMHdPNTUyczY1QWZUN3ZxaXp5eFhCWUpw?=
 =?utf-8?B?dXRFQmtYRXpHQWUwdzVBTHJXUS84NHFJYXFadEJHYTQ5d0Jja05qM3pNNlFB?=
 =?utf-8?B?WDM4VGdVZzAzNmFjL1dYQTIydXZtZ1E4a0g1YjViZXNlNk9qY0cyN1BCcEg2?=
 =?utf-8?B?MVZLdDcvVHJOR056M3I1SWs3dnpaU1NaUk85cm45ZUZnc0o2SlJGWlJuSmll?=
 =?utf-8?B?aWw4c0t1T0ZlSEVRbWVqSFBHcWk4TE5NQnFFNW9vclNBK0J0bW1FOUZSTy9Q?=
 =?utf-8?B?NDNiV1dyQUJzRGNEMGpTTVQ2RVI0anlqbWNmM3Q0cGtDbEVUdVRveGJkbGVM?=
 =?utf-8?B?Q0srQ1VmVDhGUFh0SWlkVC80aW03NlNkSHNVbHRFUGhyZGp4alVHdmpvSXNY?=
 =?utf-8?B?VUJxem9KMjJOY1Bnd25hNkFjZndIaHBOUWJUNEFUd0dLdWtqUkl3aEZpa3BL?=
 =?utf-8?B?d0RnakZqLzRISXN2SnhRdUhrSVRSVDJmYVdhc3J3cHBEMDBaK0hEdmxTb1Q2?=
 =?utf-8?B?MUJBQkdEMXJjeEFsZU91V0J5cTlZdzRLNUtZNktDVnpCelkvZ2pyaWNzVEJN?=
 =?utf-8?B?OTFhZ2hZQVZkOEhIUVRpRmRDeUNidWMwSDNUREg2ZHFneGM0bCtGUmcxWFlM?=
 =?utf-8?B?b1FRcEZUc2dGckZBL00rYVJ2SzBZV2VURUl2K2kwNTB0TXo0S2N2eVIyUzMz?=
 =?utf-8?B?ZTgxQld4ZnRQNDlHeDRabXZWVmlnNU5ISTF5QmVDQno0QnJDSnF3NEFqbzVP?=
 =?utf-8?B?YVV3YVVtSHRmZDR0UTEvZVY2MjRxTCs3dks1MWtab1hEMjVTRlVydVhITTdM?=
 =?utf-8?B?dGhvaXE3V0RMK1YzRUtwZFVhaEVtNGF6OTJRdzBUVGMwRVFrczNZcFZoWTdJ?=
 =?utf-8?B?ZmcwbnN3M3ZUWlBBNFBscG51VHNOUmI3aWdKenA1Tm5VN2NCL2RoSXM5OGd2?=
 =?utf-8?B?RHV0eitqZXJCQ3h6dFl1dGF4cGMrZjB3ZzVEcWg2cnlFb3lDTC9tbENheDdJ?=
 =?utf-8?B?WFo2N29IMG1DVklHaFErcEo5dUd2MHlPbVFrUVhENnFYaEMyQ3plVVJ0VzNJ?=
 =?utf-8?B?cWJ6WGVUMTNpRzZJZktFQVBiYks5YUI5OFJwYm9WYW05QWwxR0VldCtTZm9Z?=
 =?utf-8?B?dTNJSFAwMTJERWVtdVk4UlBkcjE3Q1pGNE9YaGZRQ0p5bFRLWWV3YUVjdDkx?=
 =?utf-8?B?SXNzeUVMeUhUMktpaEYzQ3pGZkdva2F6YlNnM0NmZGVHRXRTYlJ6NXpHYURW?=
 =?utf-8?B?V2c0OEdhcGdySjhiN1dDSWNIZFNZeE5XVytQVzJIOEUybENPK0VHWW4xa3Zk?=
 =?utf-8?B?dlhHd1gxL29EZFJKcjBpa0VneStNQjVnTVAxcWJaVmFnM2o5QUpyZ3pjWnZR?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b4e4cf-4412-4ce0-da21-08ddc5aeecc6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:55:24.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlb+7PcfoTJyGJA3OfK18yboCsOZVdVdtJgEfc/LXriNGCi0JRnF/h484SDy4gTR8V+K0aCCte80LN0AwMYIRIz78AoPz9K5l1D8TMfGpqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> When "mbm_event" counter assignment mode is supported, users can modify
> the event configuration by writing to the 'event_filter' resctrl file.
> The event configurations for mbm_event mode are located in
> /sys/fs/resctrl/info/L3_MON/event_configs/.
> 
> Update the assignments of all CTRL_MON and MON resource groups when the
> event configuration is modified.
> 
> Example:
> $ mount -t resctrl resctrl /sys/fs/resctrl
> 
> $ cd /sys/fs/resctrl/
> 
> $ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
>   local_reads,local_non_temporal_writes,local_reads_slow_memory
> 
> $ echo "local_reads,local_non_temporal_writes" >
>   info/L3_MON/event_configs/mbm_total_bytes/event_filter
> 
> $ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
>   local_reads,local_non_temporal_writes
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 12 +++++
>  fs/resctrl/internal.h                 |  1 +
>  fs/resctrl/monitor.c                  | 44 ++++++++++++++++
>  fs/resctrl/rdtgroup.c                 | 74 ++++++++++++++++++++++++++-
>  4 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 57fd12f0aeca..06c8c08d0341 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -342,6 +342,18 @@ with the following files:
>  	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>  	  local_reads,local_non_temporal_writes,local_reads_slow_memory
>  
> +	Modify the event configuration by writing to the "event_filter" file within
> +	the "event_configs" directory. The read/write "event_filter" file contains the
> +	configuration of the event that reflects which memory transactions are counted by it.
> +
> +	For example::
> +
> +	  # echo "local_reads, local_non_temporal_writes" >
> +	    /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
> +	   local_reads,local_non_temporal_writes
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index b107874407b2..b42890fd937a 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -409,6 +409,7 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
>  				  struct mon_evt *mevt);
>  int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>  		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
> +void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt);
>  
>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 787dce934903..0722e72f6cb1 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1173,3 +1173,47 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
>  		rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
>  	}
>  }
> +
> +/*
> + * rdtgroup_update_cntr_event - Update the counter assignments for the event
> + *				in a group.
> + * @r:		Resource to which update needs to be done.
> + * @rdtgrp:	Resctrl group.
> + * @mevt:	MBM monitor event.

@mevt needs update match actual parameter

> + */
> +static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +				       enum resctrl_event_id evtid)
> +{
> +	struct rdt_mon_domain *d;
> +	int cntr_id;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
> +		if (cntr_id >= 0)
> +			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +						 rdtgrp->closid, cntr_id, true);
> +	}
> +}
> +
> +/*
> + * resctrl_update_cntr_allrdtgrp - Update the counter assignments for the event
> + *				   for all the groups.
> + * @r:		Resource to which update needs to be done.

@r no longer a parameter

> + * @mevt	MBM Monitor event.
> + */
> +void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
> +	struct rdtgroup *prgrp, *crgrp;
> +
> +	/*
> +	 * Find all the groups where the event is assigned and update
> +	 * the assignment

"update the assignment" -> "update the configuration of existing assignments" ?

> +	 */
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		rdtgroup_update_cntr_event(r, prgrp, mevt->evtid);
> +
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> +			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
> +	}
> +}
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index bb28ef7e4600..4889e7556cc7 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1916,6 +1916,77 @@ static int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq,
>  	return 0;
>  }
>  
> +static int resctrl_process_configs(char *tok, u32 *val)

Please move to monitor.c and give more specific name. Perhaps
resctrl_parse_mem_transactions()? Open to ideas.

> +{
> +	u32 temp_val = 0;
> +	char *evt_str;
> +	bool found;
> +	int i;
> +
> +next_config:
> +	if (!tok || tok[0] == '\0') {
> +		*val = temp_val;
> +		return 0;
> +	}
> +
> +	/* Start processing the strings for each memory transaction type */
> +	evt_str = strim(strsep(&tok, ","));
> +	found = false;
> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
> +		if (!strcmp(mbm_transactions[i].name, evt_str)) {
> +			temp_val |= mbm_transactions[i].val;
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		rdt_last_cmd_printf("Invalid memory transaction type %s\n", evt_str);
> +		return -EINVAL;
> +	}
> +
> +	goto next_config;
> +}
> +
> +static ssize_t event_filter_write(struct kernfs_open_file *of, char *buf,
> +				  size_t nbytes, loff_t off)
> +{
> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
> +	struct rdt_resource *r;
> +	u32 evt_cfg = 0;
> +	int ret = 0;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	r = resctrl_arch_get_resource(mevt->rid);
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = resctrl_process_configs(buf, &evt_cfg);
> +	if (!ret && mevt->evt_cfg != evt_cfg) {
> +		mevt->evt_cfg = evt_cfg;
> +		resctrl_update_cntr_allrdtgrp(mevt);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -2042,9 +2113,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "event_filter",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= event_filter_show,
> +		.write		= event_filter_write,
>  	},
>  	{
>  		.name		= "mbm_assign_mode",

Reinette

