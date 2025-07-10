Return-Path: <linux-kernel+bounces-725248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A0AFFC71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005DD6417CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1128B504;
	Thu, 10 Jul 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZ2AMr1j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9744233735
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136465; cv=fail; b=JcC+Otm+7wHiCW7rmlCWSg/RdTjio6/ViY9mIinLUPZsdoNPlDrFFC89fNLKIn2cKgRYkbJaaVGX4qzmRSZ4PJNncJSBHxAnr/lDItq1wwXBJKBsnPaTQJhxHTyJLX9SpY6jDrVRc66FiLWfRuzAsc7US9ksDn4AzPfVqzxL9CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136465; c=relaxed/simple;
	bh=HFm80iD/J38qsyQEvIash/zhYi73QkCBz6AQNQ5X4hs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JEx2ikkuhnB+JsjEeRVQZCj8xNkdDv3ZP6HweGPmVvA1HoO8xjJT4NeYlWOo7qg6xJXkuLXWsoR3FLZuMlzdDFornxYirBVScfqjZ1JqHnzUbj24yjp2YFqjRxQhSqx+WAZ6Y0Ejo9/YxmWbajMurdUGQg4cINn+rn7Z5BANrkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZ2AMr1j; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752136463; x=1783672463;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFm80iD/J38qsyQEvIash/zhYi73QkCBz6AQNQ5X4hs=;
  b=GZ2AMr1jE9O2zN3Mjag0y9ujZnPxrU3GXp9dYXky8g6rG7XNkjFwqNRr
   YFZYMvAIv7p3UlLmvFfUMKdLD538iDHX8t22mco3TfmjKWQcQfUfWigj3
   mBOnD+qWezXMDAEI2KQiKDCO3LCcq/xI3YjSiwgTnLzR2+CUR60AfU6Rd
   jT76Qx3DKYBO72C+hMbYOc6+vRZqbKnAywxkl9aVjLyuPie7o/8F0ydx6
   m+mIG9XNt1Ib+A6fjkXA8RIUPAsOVPlyYwy/cB2yFWXzgu37EMpoVtk/d
   c6Wg3y/5SYUpyJcNo7rJiw6Gdr4NXXTwTERH3ljIxaZ2x1wFVs5SMKYLT
   A==;
X-CSE-ConnectionGUID: fkLRJnKMQSmvxGCMnVwcCQ==
X-CSE-MsgGUID: 1WEKNdqeSyOAvwWICKfEyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="64989634"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="64989634"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:33:32 -0700
X-CSE-ConnectionGUID: 3c/+LIfDQduRl3tYkWQkNw==
X-CSE-MsgGUID: sDT6WLC9R0+aZhoTm3mEjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160551032"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:33:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:33:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:33:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9eE5nANRGlmlchdZSDahwjEdr7x47uiOOLgGi3irLcM96WptXoUZmwKm4YNR7YDM81E1f5RS+nGHO6DXhEJKqwSepg/Bj3WtMlsLNfm+FqSp7zx1nOEY+eTzOVgPJkTBC9MOITxRIrBApIbZfLk3XmjaTZUBcqYrbCHHEoZ61m1Tm3TZowjfPwTNlfnYJu5uhpu7JaKYqDsHzuoCHPabHwyJZuwgQigF7OyUMJPeNZZGJlB8OSvUCXVBK22BRGlJ4r8NvcqFxizTsKH1229XFgtM+q9xV8p3GP+SUzr3s+OQwe5knHnLIT5mCtH0dppi2cLuS1KD8Ss9PMhN2ymYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xE4fkBT8T2+6YwX4C3l1WQzBahWtDCRunbRrx1YHbE=;
 b=YGaItmLLAQuWOKTydap72KUUnVrUqubSBJyE8hC/TWo42mNdku0N0VYaYyC2Dk1CYwoWypvpYsA40ANuYj1KI9sUwqsGjSy6qq+L0wZYv2wVo3wjAtIjAbMx59C9rAnAp88ZXy1YNKB2gpRLyAHACCDcfO+zuR9ocTQDLNZlZUmnKRrPbq2puD+GoogLL3QUSGVHEUyCJFDnJfiQthNp7iB9WtzR8RvWumbSAhnGTLVCvFiE+u0OoVX3TFkQyr4avyj+5sFL681SWoWbpWotC8f5uyeqmePXVobAwqvmrHkP8sIYYH63Vfqpc9Co9x6h7aQhsHmbu7kTjliZFfsl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Thu, 10 Jul
 2025 08:33:10 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Thu, 10 Jul 2025
 08:33:10 +0000
Message-ID: <cf437def-4542-4b73-b62b-ae9b304d40be@intel.com>
Date: Thu, 10 Jul 2025 16:32:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/smp_processor_id: Make migration check unconditional
 of SMP
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar
	<mingo@kernel.org>
CC: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
	"Shrikanth Hegde" <sshegde@linux.ibm.com>, Steven Rostedt
	<rostedt@goodmis.org>, "Valentin Schneider" <vschneid@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, <aubrey.li@linux.intel.com>
References: <202507100448.6b88d6f1-lkp@intel.com>
 <6cf071f3-ff5b-4025-8ce7-2f2cceb03984@intel.com>
 <20250710062528.T-Obm39T@linutronix.de>
 <292e70ed-aae5-4f52-8f85-80cba7ff301d@intel.com>
 <20250710081114.5wnABNG7@linutronix.de>
 <20250710082748.-DPO1rjO@linutronix.de>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250710082748.-DPO1rjO@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2677c0-4724-4b72-5293-08ddbf8c66f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmRIN0dhNGZMK0UrZTBDcXQyQnZ0djNWQUVLSnBIdUI3clNqc0QrVVlKbnAy?=
 =?utf-8?B?ZjJEZStiTlJNLzJ4NWJrNXVPZFRUdzVMdnRsaXNuRy9rc3NDMFFUYkUzMGpK?=
 =?utf-8?B?ZGM3bDZ1L1NhUTNRV09kZGFXUlhtZWovRUFxUnNNQ2FQS2xCcUtVYXIvYlpF?=
 =?utf-8?B?Y1lCNGkweFVFZ3JZem5uVi94MUZQL1FTYklKS0FHdjBmcXF0QmJXWHAyZkR0?=
 =?utf-8?B?RzVORnJzL04yTUhkVjRrbW5UNks4dDFUTnhHMXA0NnFYVWdRTS9TNGM1THBR?=
 =?utf-8?B?bFFlaEhPdFB4dHhYZFFLZDhWMERJQVJKS0dlNysyc3FBbXZsMGE1YXYxUDlY?=
 =?utf-8?B?VXVuZGZRMmRmd2U1TkpnRkZhS3cxRlc0cWY5ZkNlUktGUVJsV1BPK3d3dkZO?=
 =?utf-8?B?VFVySGMwUVB3d1l6bFArTCtYQkhrSTJmY0tiRWpkbVN3eXZuc3E1SzJiQ2tu?=
 =?utf-8?B?aFVKY1hybDRXWS8veGhXcGdMTlN3djhsejdtbkRWTUlQWFo5TmZhL0pqaXJL?=
 =?utf-8?B?QWZ0K2VpUmpkc3J0K1ZMTVl0c2RnU0xQYThPMFhOQXFpNHNyeFVyTEF2Q2c3?=
 =?utf-8?B?L1BmMFNXNUdwZzhvNFRlWXR2Y3F3ZWcvaFVxWHAyTmhmWHpNdUM2ckhsemk1?=
 =?utf-8?B?ZlExWHFQb05kN0FDWmJoMGRNb1ZxeUxPckJUemFWbVlXSWJ5eTRKOHpoaWpw?=
 =?utf-8?B?UkdleXJwYXhYT2FIWSsvanNMLzZtNWdDTTFObS9kNThKMnlYMXpONkYyT3lo?=
 =?utf-8?B?Z3pmRi90cWZlWEZNbUpMdUJOTmhOSUc2ZFltUjJ1VC9zUkRtWThvNGVuZ2JB?=
 =?utf-8?B?a0hneXFsanN4MGc3OGtKZnVESlNOWG0zUEVhd3h4MHRVN0wrQWp3T1VUa2JQ?=
 =?utf-8?B?aVkwV1dRMGFORUZ3Skswb1VRY1d0cm9UeWxPVzNGRGpiNysvOExibk04WGxW?=
 =?utf-8?B?WkR2KzlRaytMS0VVWWxLcThjMFYwMWV5Q0hSWEhyUFJPNXpHSWFMUHpPYW0v?=
 =?utf-8?B?T0FlQ1d2ZG1ocEg2Wm92bzNGdk5jc0o1bEQwNXpQelo2aWR2bmxaSS8vMDlR?=
 =?utf-8?B?UXpFZ3lDVTdHRFJxNmRnRlJrOERudjIrbGV4U1JuMG9NcEovUTExemozanJ5?=
 =?utf-8?B?cGFYenh0ZWJQK0dMRVNLazRjZE1iLzVpdjJZbVQwL0x5NVZhUnBZRTBJUHQw?=
 =?utf-8?B?Q250WisxY1RjWVJ4NjRBZ1B2dXFCbnNVUnN5TUtuMHFpYitWc1JEMHROdnhz?=
 =?utf-8?B?TDVwQ1RXbS9iZWpSU00yc2orTXUrdnhPcU5RbW5BWGcyNnRYdk4yY1BKOHRS?=
 =?utf-8?B?aE12Vm5PVHpyaUVTVzl1anIxRDlKWklMa3o1ZGMzazIrTE4rZkoyUWxMbG1O?=
 =?utf-8?B?RHp2bHo0bTlkZVgxRVdGRnVPaDJCbHVYR0w2TmJZVzRmMXMvcGRaekU4TzZj?=
 =?utf-8?B?R0lDWkVvVzJrWExyVWhNc28zcUQ0a2t0UW9GNHQ5RXA0N0k5YXFUVmxPSVVa?=
 =?utf-8?B?Wit3cDZpVnNFTTZvNFhhUmNuMHg1MlArWSs0Nk5MRndxMEVuUWswYUVGWEpi?=
 =?utf-8?B?UUNrWWI2ZkcxcXdiYkxMelNwanlXS2dVU2VlVUs5Zm1LWnR6WHVGQ1VkdURL?=
 =?utf-8?B?U1BLT2c0NG1XQldaNW5Sb0gwTHVCSW1xM3FOUktzaUFkS2w0Wmg4SDFHcEty?=
 =?utf-8?B?RTRxSVhyTXNDSnpnczJESlovc2tKUjJQbzB1OHFwSm4wRlNXYUJPdnErZnpR?=
 =?utf-8?B?Smt3Zms1U0MzNzlFYnh3Wk5QdlZLQmxLaGQzYlhzaDBaM0VXUHZ6Q3ZyNjZ1?=
 =?utf-8?B?RmRZLzQ1MFpLdmVLR21CdG5mQ3ArclJoNjZZVnA2VmhvSVFndGRMeEQ4YzRw?=
 =?utf-8?B?dUJFWGNXS1FYYllJUDJzWXQ5VXVDeTNoZlFrWEdUbUJZcTlyZFRTajhIVVIy?=
 =?utf-8?Q?ejV8StLIUyg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVudXlzdXV4OWU3Nzg0eTZDSS95V1NFTzNXSjZMbjR6a2dHVkFKelhWb0oy?=
 =?utf-8?B?bGhNZnBOTHp5RkdyRHB0OWFMRFA2VmxDYm8xelliR24zdVptY05wNG1NRjll?=
 =?utf-8?B?U3ZPZmI2ZWNJdG1ma1MxSGNEQi9GbThuOTF4SUlUaHpCR3g5VWwxWUNwRmll?=
 =?utf-8?B?dDlOdHJpaDY1cmpTYU1mWlFsZGtVeWcyNXhOOG1EbWROMDYvT05kNUpkbmlp?=
 =?utf-8?B?YnlvN2w2bnVGTmI3SlprelJkMVlPQUIzekVvRnFpRUFyZlhPT0pTUWpHYWhU?=
 =?utf-8?B?MWhLdFJwMjFWR0tySXJYd1ovZHZKVFFMTUFEVU5nOVN3NVFjWnNPcnFkZ0E1?=
 =?utf-8?B?QVMzOWFabklxYVR4ZzEwZXBxa2JMcjJXajdHa3RDTzBjOFN6R0I5TEpKQVhB?=
 =?utf-8?B?WVFNaThBZUVUaDM0eXR6U1VzU1dEL0pwTXNiNUJlZVhITkQ0U0dwb01taUpN?=
 =?utf-8?B?QnlQYVZQU2FuNU0rWkRKeXFjWGFpcytxZVUvS2FObEUzeXlpMm11dG9SaDh1?=
 =?utf-8?B?NmpidHo1dElac2FBd044M1VyejlDaW1QMlplMVVHVUp0RklqTFllZlMxWitT?=
 =?utf-8?B?ZWo1Y0JCaDlqdExKV1BmV3hscHJnQlVWQkR5dUIxTTZHT2NSWkVRYmFTNXFs?=
 =?utf-8?B?MU1mR0hTaTZndm1SVG9uTFU1NnBUMXpuSG1ET3VpVTlvbzY2dGNMcTFuS28v?=
 =?utf-8?B?a1hxRGt3WXFTbHNqc2JsbG5zb3BsS0hCeU1WWkxtTmI5bTYxRWdDTDQ1ZWJ2?=
 =?utf-8?B?czRFN1l3eWdSSStSLy8xdkhyWHQzQzE2M0FJR2d5YkhvUnQwNS9sblpzcHZ0?=
 =?utf-8?B?WUlXMXZ5b1RFVEExZ056VmQweDRCRFAyVFp5bGprbDlDN2ZKYTBtemVPeXNY?=
 =?utf-8?B?UDQ3NXJsNFJ0aEdVWkNqeXhtU1VEN2RFc1Mrc3luVnlWeW9HdlZVaWU4aHlS?=
 =?utf-8?B?dWM1dEJrd1c4NHM0YllvQ3pYRThrb0FtRmgvWEpqSWdyZzZBbXpSZTl2N0Nn?=
 =?utf-8?B?ZVRMeCswWnJWQ2ppRVFLU1lKRTB5SDNDOUx6RnBRSGc2WjVBalRhcWFwQk5V?=
 =?utf-8?B?SE8rMWdnMStsY1V2OEhZSCtwWUUwdEtjTXRmR0I1NEE3cVFUQk1aRG9kVFls?=
 =?utf-8?B?c3pEbHlPS3hFK3ZwUkptUFBXanhsSUR0cVVTMXE5alJRU1lNWXBtcXpOall5?=
 =?utf-8?B?SlFWLzROU0kzaHpuWHZDbC9xNW5hQnFab2I2eU5KTkRaZzhaZlpYL2wwU3FW?=
 =?utf-8?B?dFc0MnpCcmJlMjdkeExwbENEMTh1REE0emRpVndIdnhZeCt6TDFvYW9RaFBM?=
 =?utf-8?B?cnFJMEE3U0c2VlRITGdNdkJKYzd5dkxlWTJzMUdrUktGd2lWcFFyNFgvdWUw?=
 =?utf-8?B?dDRKb1RlbG52NUQxNEIwdGhXUFRsZHhuazUwOGo1SEdCRk42bmFSSXU2T0c1?=
 =?utf-8?B?M3ZmN3dkcElHZGI2YklhR25UamJuZFNCQkd0WjFPNmt0MnpoRVI1QmtiWVEz?=
 =?utf-8?B?bVQ2T3U0Si9hYlB4RHpBWXhMWHZJNWM1WGJvUVE0U2JRRjNnaDdIdTZ0cGxw?=
 =?utf-8?B?UGpQU3pyVithZTJaZkFheUdiejFMUUZvcys4SW1CbEJxeVVYR280clFWV3FN?=
 =?utf-8?B?TTlyL1ZGeVU5a2V1cWJ6Y1VaaTZqVmJ5NUdCYUlvY0ttMWdsVUJ2VXYybUpU?=
 =?utf-8?B?dVdTbE90eG5rUlNjenY2VXlSNk5GUXc2TzZ2K1NGc01XOXVVSEVkM25IaWVn?=
 =?utf-8?B?SVIvVk5vZVlLMEtHQUtCK3QwVFRqRDMwRFl2WW84N1pKWnBKQWJ5ZHVHWnFM?=
 =?utf-8?B?SDBpRFJMN1hYT2xpVDlvVFJFR3Rlcm9GeERsS09lbXlFWWQ5VnFGeW9qL3Q3?=
 =?utf-8?B?NDVHaWZONk1pbERleE1pTCtUM0NtSzNLbWt5UmRTSDZYUWNJaTN6dWszTzlB?=
 =?utf-8?B?YURpV0ZyZVR6S0RnWVFhaklkbWw5TVViOHVIR2lxbk1LSVh4MVg2RUxLL255?=
 =?utf-8?B?ZlhaYzNqVjBoMnpvdDZiSTd1eVVZS2NyV0hYSEhOWHpLQ0x0bCtIMnlyRWh3?=
 =?utf-8?B?bEUrOVEzTTZOMndXT2ZBazNwTnBGQW0wT3NYNVg0UDlJRVk0TGtRL2hNcHg4?=
 =?utf-8?Q?RPbmR5rIRCeyblH+y8B/lnS8i?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2677c0-4724-4b72-5293-08ddbf8c66f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:33:10.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6svZAeohVY6s/kAxTcQ1XmJjK23YOGr6lG2ZBDgqljspLPA8C3/M1EWxo/fRvpg2KJRRIjVZoXGqowKaz5Mfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com

On 7/10/2025 4:27 PM, Sebastian Andrzej Siewior wrote:
> Commit cac5cefbade90 ("sched/smp: Make SMP unconditional")
> migrate_disable() even on UP builds.
> Commit 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and
> scheduler_ipi()") made is_percpu_thread() check the affinity mask
> instead replying always true for UP mask.
> 
> As a consequence smp_processor_id() now complains if invoked within a
> migrate_disable() section because is_percpu_thread() checks its mask and
> the migration check is left out.
> 
> Make migration check unconditional of SMP.
> 
> Fixes: cac5cefbade90 ("sched/smp: Make SMP unconditional")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202507100448.6b88d6f1-lkp@intel.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

 From my understanding,

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thank you for fixing this.

best,
Chenyu

