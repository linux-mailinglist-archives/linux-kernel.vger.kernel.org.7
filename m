Return-Path: <linux-kernel+bounces-741648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C379CB0E734
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8081516431B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22F628B7C9;
	Tue, 22 Jul 2025 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edKeZaSA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB0286D7B;
	Tue, 22 Jul 2025 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226906; cv=fail; b=Rdn9IgRjU8S9Pns1SBo9eM7k7NPUjpHqYpd7/EcWDLTIZ0Frzl8RPHOR6nWR6iVcHEUbtm6GOTnFXiBeUYderkPJ1IEZOOSGs5Zj9vgfjjaPN+fdSbJ/R3oLQ0DjC2mHrHjRwllLjOniU6BKOQlpOdNAF/7ocmGr+YAqxJloL6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226906; c=relaxed/simple;
	bh=EyDSQ8LqhaeElwgEQivrCui2HcABWB/uuFCULU+B7c0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oydrYh7X7zYOQuknIGROCmXDi/iPsAbL4rDpL/w5fpp+0gvb0ORaQO/rd0zdxhmM9cqJqyYUEpUwsYNVHWQP2vl1mxIO6ITo02uFpeGorvmn8bwBuBTUNIimZCnx7ur9uYV+1te0vEWlHOJL/eQ3iYTi24BErsSaYW7pDmN/RdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edKeZaSA; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753226905; x=1784762905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EyDSQ8LqhaeElwgEQivrCui2HcABWB/uuFCULU+B7c0=;
  b=edKeZaSA1hmwj7Yq2Sc8UPKHkahPyBfPrZ9MC4vtr/z56vq0MR5bf3uX
   HIHGS2UCq95oHzNnc2Bzt/kuG86hnyB0xiKo7oZ2ymUuYCmXI+LtkkJlr
   WEdvlOP7C7ioFdeQIQcIcqXfgrI0c3mv2jar5CPxvIaPCzh7kZbj0tLYx
   Cy7tAqWjbxMZZU0nA8ddCIsl21ZjIU5UrKL7um9eOyHNgPadmdE5B7Iq7
   AKbnr0hu+49WlljNQJyY1SVNDWMsocpShIIGoDW3aPHJGw0Zbgc7gVefF
   6RJ4fChQ347YUAi4N5OnwDe6o+pL8JIyuHKt8LKpt6ash+EocK+H3ZgmU
   Q==;
X-CSE-ConnectionGUID: 2hTpUsaXREOMvP8R1Dmt0A==
X-CSE-MsgGUID: 42ejuek/QT2CLRsfm3ibUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="73064764"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="73064764"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:28:24 -0700
X-CSE-ConnectionGUID: 2k7ArxIVSMOyLMQQ0//Rdw==
X-CSE-MsgGUID: D+F70ez6Qk+4fIMF9Qxi3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158570066"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:28:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 16:28:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 16:28:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Jul 2025 16:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t719lx4E6rjRAsxo7PdGU9kpoiLUnQMdAFID0BK5Ufs2y/MxcDEet/+TqETMZvAutDM0C226/6MwbdB40I/jOlbBgSIjWT6or01IkUITdC1GUMiS0lxh/zUj+4BuYyLiHH5F1AhJ+XFOK9jj+hOgLch2YoqsPO9sDg2bLDFGAFpl1nvBVu6DNfthOyjr4xJpr1t8OAVjRIys3OoNekUTeZ35EhwXoHXc1J3PSy1GS7ohhGipw1YGTiCJosTsho4X2mOM28dEtLKjvCxF7Esfmv9OcogFSNMdCvf9439fgtiRrAJWUpejhcYinuPojWweLrgeD2XzFIb7e5GIeEHV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaYsO9gySAxeoNZiT0xVluwebk0KjOKIslliBOQVScc=;
 b=oBt4Ep3xORMRRfjwirhehp1ZyLR7wNDQQbnXO4CR1CwRVP7Fpf8yGRzmfIK7AMrnoOxkNp8+IxAdom6Qrxa8cgmzy0RGJE7VsQ2nsPGRoEBZFiypVV5oj3Ibo9Xy/cRrARWWqZ9Wm+NxmSYluVptv/5b0ksP48mi3+iLypP6t49TK525gKxWgXqLCLifeR+PCPC0doyttoEjn3v2SMz/KafrQeVfsOBUgrW3bPWt9oipk2eaQVsJk2Gbd5tKXvJUwocrwfpMb8ricJuR6DYtBvasxz3hQ0eojSpEjxo03jegnsXGV/+sI5jiGuiTX5x5f3ZykyajbfpyHC1GuBRYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH3PPF496D5EAB2.namprd11.prod.outlook.com (2603:10b6:518:1::d1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 23:28:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 23:28:20 +0000
Message-ID: <791ff5e0-dcd8-4bfc-810c-b085bc4ca543@intel.com>
Date: Tue, 22 Jul 2025 16:28:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 24/34] fs/resctrl: Report 'Unassigned' for MBM events
 in mbm_event mode
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
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
 <296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com>
 <4b5eef45-9110-47f7-8e1b-a59028d66c52@intel.com>
 <1a7e2a89-4006-4180-88c6-aa7cad76fba1@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1a7e2a89-4006-4180-88c6-aa7cad76fba1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:303:b7::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH3PPF496D5EAB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbc5408-36f7-48f8-3e0f-08ddc97771e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVd6b2NVZGw1MXZxWTlVZnpsRnVpT3paYUtyL0RXcEROMjl6WXZzN2dsQUM0?=
 =?utf-8?B?L1FueFVveVNwTGg1ZWtWenlMMVZxdTJIZnNVazRmc3NJOFg0clhHUWJzMlRZ?=
 =?utf-8?B?K01HWEJQL1dqcjJhUVVEZlZjZkdrMUx3MGwwS0F0WENQZER4L3QzTW9IMDgv?=
 =?utf-8?B?YVpueDZ4cVNqYm95eUlJU0FmWndIVE9Ec0p0TFRVMWZEcmRwNmcwRWVna1ZG?=
 =?utf-8?B?WFJET0hOK083VzFtVG5pZThWS0tkUXFGNkxya2xqU2M3Mm1meEJJV1pjZlFm?=
 =?utf-8?B?YlE5RHBKZ0o5UDh2cUlWWkpFa01LK3A3ZjU5UDhQT0dYeU9FTzNnS0FGcHJO?=
 =?utf-8?B?a0ZQZVJGUEtjalJ4YzZFWmpNZGdjQ29yVHYwZTAyWFFFWElmNlQyclhqYzVE?=
 =?utf-8?B?V3prZjN3bWM2OUNEQmRYamFhUVVjQ01IZXNxL1MrRnpzZ0p4RmUzeE0zR3JS?=
 =?utf-8?B?czlUSkpXbUxaRnRzbXNtMk1PMU9xZGpXUXB2U1NUa1JBcE9QeU9hQncwbHFa?=
 =?utf-8?B?UWRETGdVYnUrSVF4ZTB2V05VSGxFbGdDODB4ai9rK2FWMVlpSDV1N05JcHg1?=
 =?utf-8?B?MDlnZWlXMkJFc2RXaXJqQ0d3eTcvZzBtaGVKV3NRUVd6UWRVdUkycWliUi8y?=
 =?utf-8?B?Z0FyY2lXTWQwckt0WnMvZldYMHNKYnpBN1l3anl0QXdseGIwbmIxNGdRVlp4?=
 =?utf-8?B?Zzdtb1RxUTg5M0VjRnFqTHNNMUFHZmdIVnV1WW10MWtLNjBuTC81NzJOSytU?=
 =?utf-8?B?U0NETzFiV2R1c1JFc0FaUUpXa09BUlJOQTlvTkw5RFgwdXJtbVBjWmFOcHBq?=
 =?utf-8?B?VE1uMkx4eC9QY2tzS3dIWWxtUDB0NmhMVnVCbjhFMFVjMklkeTh5MytqMFZy?=
 =?utf-8?B?YjdFWm1vSzc1V3ZyV2Q1UHg2dWhkdUlMeldxVDhqRFpDcFZEekY2czRNWTF0?=
 =?utf-8?B?TXp6elhqUm1UQ2h5Mm95V1JKb2hzLzVTK29ob21QVTEzTGZRZ05PaG9YVUhq?=
 =?utf-8?B?VTdlRXFDSGV4UExlWHozTHI0bDQ3bS90VzExVmc2eWxKQ0ZiZ0NRc3lrNmVD?=
 =?utf-8?B?Qjk2UTNxQ0lsZDRuclc1MjRTMkxMRnJ1SjlVSGVMbzJOQlYrWlN2SVhtclRr?=
 =?utf-8?B?WVdKRHpsN3JZY2NLM09xdzhTdEJPdytONHZaZnJ5WTBnR1RzS1N0V3hFV05I?=
 =?utf-8?B?eWtlQTNDZDFXN0FBLzMwU2M0UlJYdUFvdUdUblV3S1RjdHlTQzhxeGtaSzlp?=
 =?utf-8?B?KzluTlpMMVdTcWgxU2N5QlJ6c3k2R2ZwZUN0NnRPeEF4NkFXSWNId2lnUDRp?=
 =?utf-8?B?ckhsL0oxd0ZGdEhFUGk4NkFZUWE1Q3ZDdTc5RjhmQjB2TG0xSWxtTlNXbVlW?=
 =?utf-8?B?dkpiOTZFNXY0UWZyUnp0cGVmdm5XVjJSM3hndFhWTElnbzUxOEh6eEJjd1BX?=
 =?utf-8?B?ZVgyTWVXanVTekpuVjArQVp6aTRvR2NPVGpJZ2VWMGdWdm1kOFkwY0hncTlV?=
 =?utf-8?B?VnlkTGoyNUluV1dldUZaUUV5a0RadXJrMjNRZmUxbFpZNWd4RFJYcGZOdzVR?=
 =?utf-8?B?UURNb1g5K0RlREt4UHkyajU0L0J3TEhUNWxoWnRVZXlTaTBEUmNjenlsNER2?=
 =?utf-8?B?cjhxOWpvSEZqN0RGNlp3WDBWT0U2TmMrUWk2bU1BV0pqMnY0NUxVT0tuTm5m?=
 =?utf-8?B?ZEU5emY4cWtXQkNhNnp4eDVqUEpwenJyTHBYbU5pZ3ZwWkRZSHROWHRJN0hI?=
 =?utf-8?B?N3lKa1JKZWhiODF0MldoU1JCWlVaZFFEdHZyVDJwdzFHZ1ZubE8yNUF5TVNx?=
 =?utf-8?B?VXlNU0JtbWpBQ2pXNU5EZUthRGRmSXNqcTNHVHJRU2NQa0lRcnZTaGdiNWJN?=
 =?utf-8?B?RXhNTlJSMXVOeU02ejBLdVpSZ080NnRneWM1bkhPV0pkSlZPT01ZOXgyYnVG?=
 =?utf-8?Q?ipt5ghHsDHU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWVsK0ozd3lQOTZ1ZCszZlZYYlNwMmM3bURNWnNPdHRCUnc5TTBUQ1N6QjNy?=
 =?utf-8?B?ak5ZVDlxNEk1Z0Y5N244N2NzdDFONjgyTUlaeXRnd0g5a01wZGNrb1JqNVJV?=
 =?utf-8?B?MU51Z0FmcE00L3F1dGlBRkROUjhxZXRFcVVldlVLczJsLzFXYk03QzFJeVI0?=
 =?utf-8?B?TWw1YVdoemhCT0xaUENBTVZaS2dIVThSM3JYcjQ5cVVMSXVqa01uTmpxY3BB?=
 =?utf-8?B?a21FR09sQ2RxSHpQZkVKNloyME5mdWRua0xKZ1JvSXNUQTdkdVVseFVOZWM3?=
 =?utf-8?B?TWtDTTluUEY1eUZzYzdDalg5MXlQWFpxZDlMZkp4MFRIL3FsSS9pYjlRSTUx?=
 =?utf-8?B?Ym9pMFd4bFU4c0ZTSnhZUmptOW44M1R2RmFvZVREWC9ld3o0MjZrL2Jqc2RE?=
 =?utf-8?B?QXZkWFd4M3RoRFZhSi80ZkhxNk9oT3JOMXh3OFpkbEhEckkyVEdZOHhFWmdv?=
 =?utf-8?B?cTBubGYyUmtDcjJaNnJzRlhySktQVEF2cEE1cVlRMi9qbjAvZmc0eWZEUkJy?=
 =?utf-8?B?WnpjYVVNbzNqQlRMTG1nVm85K2w4TGd0WGZuK0dBOUUvOHpyRW95VUF2VW00?=
 =?utf-8?B?WCt0OERjM1BiR0VUMjd1L3VLWks5RG1Pd0tuaEgvSmUwTzNPaDRxeTB5OUNu?=
 =?utf-8?B?eUZWRjJzaHBUOGlRMkVtbTE3Z2pTZ1IrK2NXeCthTFJZQTBsMmJOU0xYczg5?=
 =?utf-8?B?R2hCc1paM2p0UTVjSWZqRjRjTk9xU2dCdHM1cGdZNHc0UkptVDAxaHNtR2lR?=
 =?utf-8?B?Ti9EbmFZVU13V3UwZmNyT2JmRVJKc0g5anpGZ1o2cUhXNm1NcUxsOE9FNGVL?=
 =?utf-8?B?dWRtSXNTNzlqbzNJaVpBNUZIZGZYWmt2ZFlmS3R1SWd2WWl6ZWdiNkVqQlBS?=
 =?utf-8?B?WUpGbWEyWUtmb0lDZnRBLzRxaW5MT3c1d2RMeU5MaUFaNktmSHpxS2FKRHhh?=
 =?utf-8?B?b2FWeFM2a0RqemNnNFJJRHE4Qjh3NXhPM3ZhOVJvL3dpZnJDMzVsWFJnQ29X?=
 =?utf-8?B?OXlQUWEya3hsU0NGRGRGOXQxaW9yNzRYdVJnYzVObVQwU3hiVWJQbGlHd0VW?=
 =?utf-8?B?eXRtMWxPVm0zbDNIMUd5OXFRbUZsR1VWOGExbFJpdWgvUUxvUVhHU0U1UWdl?=
 =?utf-8?B?dXVyU29GL0NKY29SRHRtYm1IU3puZzFaRUEyd253NUppSVpvUFZWdVFjbVpQ?=
 =?utf-8?B?WUJYWU1PeVptMTVKL2VyRVlGOFMwRHgzRVpobXF6U0YzSkxOUjlLMnJLWEF4?=
 =?utf-8?B?VCt5L21aOFhwNG1TNkRMUWRXSkRKdFd5bitnZzBGS0lHazQzL0VrTmthZEtE?=
 =?utf-8?B?NUFoQnExS1ZRQ3ExVHNZYkFpbnU3S2pJajhpN0Zad2piUCtveTZRNmsyZzBi?=
 =?utf-8?B?SWpURGdCb29sZzJiS093UURBMlgzSUF6eUJPMS8ydENHRmhTbTZrdUpERzRn?=
 =?utf-8?B?SWU3RFpKa3hMTmRyS01GdFl3L3IwNGh0cE16MERrOWZXOXpHekpFSTQwUE96?=
 =?utf-8?B?d2tCemFXelFjMmp2RnRFQVBreitya2ZxVDJhaFIxQlIvZ2ljR1NLTEdsVUV1?=
 =?utf-8?B?MmVqK2VpaWgyQVQvM2NYV1dHUUUraHlpYU5OVzA2aUVUOWlJRkc1cVdMdHc0?=
 =?utf-8?B?ZnFRK2EzWjlmcU03TGp2UitlZWRnWFJaZXl2OTFOeG85NldiajJ4THZyZmNW?=
 =?utf-8?B?em9Uckh4ZVBaSG5lSlRjSWhIVllzQUllcUoxekxyR29YZmU2V0ZKazNZTHJR?=
 =?utf-8?B?aElTbitBYjR0VWp0cG1ZdGxkZkE4UHlxR3d5djBuSDVNYjhCM1hKTjF6ZHdt?=
 =?utf-8?B?SE1HQ3lvQ1AvWE9xcDdpU29EWmtoS3dRTGtGVCsrYWFQeHJGRGpYS20waC9S?=
 =?utf-8?B?cHA3bytna2lLZDdVOW5MWjg3bEs1K3VDZWxpWFEzYkNuUFBSSG90YXdoRlMw?=
 =?utf-8?B?LzBDUDIyTVBqNXRzdERnc0xHblJvem1uZndjaDFBWkR4VG5KRVZueGJHeHNQ?=
 =?utf-8?B?TkRVRTBtYjJjdEtLWktCbTZ1U3dJZk4waFVoYzZyZzZKdGZMYlJEV1Fpcm1U?=
 =?utf-8?B?VTB0OTFtYTF4S25kdnhXTnVnTTRUTElGS0VmdHpxdk14UzVFQ1BWK0dFSGdv?=
 =?utf-8?B?TDNSMk5hUXZPVHBITVgvRFdTQnZydWVPNEtFcXcrQnlLVy9oa0VtVmhhVUNG?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbc5408-36f7-48f8-3e0f-08ddc97771e7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 23:28:20.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSd4vcRlJ3gqoog/dmRpYKFxdGCxGfXBVw6V5CSdCRHlRczJaoMi0uxxARL9w+SQfEV85WZ42j12NavFZ17MDopv2j80Ph+BAlY4kQhoUQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF496D5EAB2
X-OriginatorOrg: intel.com

Hi Babu,

On 7/22/25 11:15 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 7/17/25 22:53, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/8/25 3:17 PM, Babu Moger wrote:
>>> When the "mbm_event" counter assignment mode is enabled, a hardware counter
>>> must be assigned to read the event.
>>>
>>> Report 'Unassigned' in case the user attempts to read the event without
>>> assigning a hardware counter.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>
>>
>>
>>> ---
>>>  Documentation/filesystems/resctrl.rst | 8 ++++++++
>>>  fs/resctrl/ctrlmondata.c              | 6 ++++++
>>>  2 files changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>> index 446736dbd97f..4f5eb5bbd4b5 100644
>>> --- a/Documentation/filesystems/resctrl.rst
>>> +++ b/Documentation/filesystems/resctrl.rst
>>> @@ -434,6 +434,14 @@ When monitoring is enabled all MON groups will also contain:
>>>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>>  	where "YY" is the node number.
>>>  
>>> +	The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
>>> +	counters and allows users to assign counters to mon_hw_id, event pairs
>>> +	enabling bandwidth monitoring for as long as the counter remains assigned.
>>> +	The hardware will continue tracking the assigned counter until the user
>>> +	manually unassigns it, ensuring that event data is not reset during this
>>> +	period. An MBM event returns 'Unassigned' when the event does not have
>>> +	a hardware counter assigned.
>>
>> Most of this duplicates the "mbm_event" description added in patch #10. It should just
>> be sufficient to mention that this applies to "mbm_event" counter assignment mode
>> and then user can look up the main description in the doc.
>>
>> The last sentence is related to this section and need an update to reflect behavior
>> when a CTRL_MON event is read and it or some of the MON groups do not have
>> counters assigned. The paragraph that precedes this does describe how the sum
>> works so this can tie into that.
> 
> Just added following text.
> 
> When the 'mbm_event' counter assignment mode is enabled, reading

Not sure how this will turn out ... if I understand correctly it follows a
paragraph that already starts with "The "mbm_event" counter assignment mode offers ..."
so there seems to be some redundancy.

> an MBM event returns 'Unassigned' if no hardware counter is assigned

How about "reading an MBM event" -> "reading an MBM of a MON group" to
distinguish it from the text about CTRL_MON group that follows it?

> to it. For CTRL_MON groups, 'Unassigned' is returned if none of the
> events in the CTRL_MON group or its associated MON groups have assigned
> counters.
> 

Reinette

