Return-Path: <linux-kernel+bounces-869622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF70C0856D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F57A4E8408
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1385030E84E;
	Fri, 24 Oct 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNNRYhyn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8730E83A;
	Fri, 24 Oct 2025 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349424; cv=fail; b=NeMbY1HP23uIICHdBvX6cCcswtycqDbtEY4tmo/WNcOb51zJwLyHje3E0YuN6KnxdhUbzD3405FyaSro4P8cEFmXb7FZ3p4MfeEP/n5DKcoarTiS37m3tku19EuG4GOvNBBDAAOSq5eAVkc6GpB95WJSMrLskKWA1i8MpiTvZIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349424; c=relaxed/simple;
	bh=bXXPvPjzStZBuBAP71SsLws1c074wfxO8+7VB2NksTA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b/l4sgKmZCFlgevlIItMQvPUEtHCuWAIF0woFxVLXy3h6iqUrSakkVz8/VBOC5/ZucAx9LVl1T0B8ecENvs/jB+1s8+AgOMbwlUiKhbMMqiBFtOEeYBvbyZB/rw6zuS14KdPynXUSfJ8gLKZ3+d00rlX2B+URdCTe6hPFay6x8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNNRYhyn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761349422; x=1792885422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bXXPvPjzStZBuBAP71SsLws1c074wfxO8+7VB2NksTA=;
  b=RNNRYhynUaMyZs/kP155vChvgqgWWBjVuUcv95FtImCiMlj/Ftqpe/d9
   Dke5cJCAMU22Bp79hqLIeRTPiXO6dPU+n0MHCgUnAI6A2SU0AcDE5muZ4
   z5lFKO6HB2pwQzf6PWrxi8pmD1lf/wycBVZlcMO5DzqfXgxHK8ds+YQc3
   BdfBO1cYFU7m2UzCTNros9zEVzSJjeXpZJW9IKupifh4jScvoDCxvn1lh
   DJz6jrnri6w8+413jN/eQ1KvbypD9JFr0Gi57kCETEQyTEZ/8yHVl4bzd
   3V/XA7JcwemI7lGUym11MeSTcbIMpAe0CNqV+zoqlrU3EHdj3wHEZ1EL7
   g==;
X-CSE-ConnectionGUID: xjh+gsiSTEOcDBBuHIRZPQ==
X-CSE-MsgGUID: Zd3nbX2BTM6lqs50b2jmjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81158749"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="81158749"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:43:41 -0700
X-CSE-ConnectionGUID: vZdw99EpSu+sTiwg17PRkA==
X-CSE-MsgGUID: cEKAzLUBT3uSrUy8AA2DNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="189675310"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:43:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:43:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 16:43:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrTU138j8oJ05kwKXbqZnMWLFBThHli/tinlbYDRTtmZzxhhV3lvjPUxMEDF4Pyysa11rKW/UjoNHSoZkzGDenP+AGc0T0/FLH1rm+U6Ybw2Ciiofsg4uzNaFYQQlo7T2YyAWCoIUH6Qny6hnaUQO6sT7YiAyV9WnhlV7q3bInntKYSrzw7Kty2lmE1rQugXX+NQX6+pH9TDH3i36tg6cCXFRt+8MYmG/a3SirBAeVpuHfQaCbCTGjvGv4FPyG64sbKZ/kp8vZaE/Vw5jVUOhoUNH66oa1G3cvtwyp2B1XjcDHbvUTmho8qL/lzbFXkeDp4g4nVWkkLpxSjeKDuLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES5t2XFJR/JW4YOyOfeb1KXALpMpCPAjD/QmI6tf/6c=;
 b=BzQnlOJgmSCp+PlTJcR6TAjrJM6MZrwWv2WWx7/0/oegFDo8stSlURDaqrfobhK80NNmJulH18Pdn/+/fygLq6shNxbvm7Ez18snkq7kONDST1q98n+1MkMlU32GR3Yrz1z7kTolZ2fZ/B5SZcoNugWmoQMbOM7sNcXJLAVWqz/zW50BlFT1e+cEovBPXm5QC19Vi7roUM4MjmGSW661TOnatOOx2EvcXV3FTI5vQytQ0IYyE5F6xAMD920GbQ6FUoWx4pvHvxgGLgf0KXXiqqNia+UgG1YY/TN/HENRIJ+nm53KK7bhhfVs6tauC5P4vKW69xKjRV4DSfimvJNl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8554.namprd11.prod.outlook.com (2603:10b6:408:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 23:43:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 24 Oct 2025
 23:43:38 +0000
Message-ID: <003d4e31-76df-43ed-ac23-9f6de7ca44cb@intel.com>
Date: Fri, 24 Oct 2025 16:43:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/10] fs/resctrl: Introduce interface to display
 io_alloc CBMs
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
References: <cover.1761090859.git.babu.moger@amd.com>
 <7aecf0ce36527b9c3b8b121272cb140a4fbf5658.1761090860.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7aecf0ce36527b9c3b8b121272cb140a4fbf5658.1761090860.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 774f9b59-9201-492a-a214-08de13572796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVpSYUI2TUZNenpYVXRlSDJGQlAvaFJmL0JpLzhEWlZYQWoyU3JuM1NQQVZu?=
 =?utf-8?B?MnNHM2JVZUhtaWk2RFJDbTM4VC9MLzI2Ymxjb0VBV2VoVUUzaUVaYWltaFhR?=
 =?utf-8?B?T0xpUnRzdmlGUmpSN1ZFa1ZoWmUzRGRhOHJoUnRmdDdlK3lOZ1ordkI5Zjl5?=
 =?utf-8?B?YjlhTlRjYk41NVFuTnNDakhvSDRjZXdLZXN0c25DSGRmU1VpYWIwZkE3RktO?=
 =?utf-8?B?MW5RTVdHL3pQYm11bS96cmcvZjdJRTRGMUMzVkZHQm5aUExxZmFyKzMzckdN?=
 =?utf-8?B?R2J5VDJ3bktDL1YzUW1ONXpzY1djN3YrTUJvL2hrTkpNQ1lFYmhPUjk4VkFI?=
 =?utf-8?B?cmRKZnJ1S3Bzd2VDN2lpWHh0cXRRSVUzdHdlYlRJclRaU0pXMk5JajQvU0Fx?=
 =?utf-8?B?VFBGeHJOWUMwREdsZFA4ZGkxbSs0ZDJmdEFVU3ZPYjNoc3ZTVnRmQWh0ZGFH?=
 =?utf-8?B?bUpuUHBFdWc3WVpJbHRNZmR2c21KUmtYOWJmVzdQSTAzdmFNcDJpRTIzdFdS?=
 =?utf-8?B?WjNrVk5la3lrSEhhZWthZXhDbFF1YmFST3dYTE5wTlFFVFMxSnNYSXh1NDdi?=
 =?utf-8?B?Tnd0WXlRRDcvU1hlTDM3OVpIYXdldDFVM0NVUG8yUDdDNXJCTkhvbzhTcWxQ?=
 =?utf-8?B?Qm9acTd2aGNFSlkydCtKSUs4a1Q4Nzd4UloyaklVdC94SnlhMjNCaVZkRFIz?=
 =?utf-8?B?SDVJL0YwOGVYTElBVDZDQ1NRU0o5S3ZuSWFuNnJ3MEFiNFpWZEJGazVabk5j?=
 =?utf-8?B?TU1Hdlk4TTZpdkRDdkZ6bVRhTWhGRVkrSDVQc2ZSMU1hQ1E5K0QrZy94UjlJ?=
 =?utf-8?B?c2NObDRLVWJvRTFKM3l2NzJhRjdJWi9HSGN4d1NXVzlWWi9XcnhCV3VxeFRB?=
 =?utf-8?B?NFpGWVRZWWVYc1V6M0R2RUlnSmtnbm5FdFBqaGlOSFpuZWRlR1ZFK2hjaWxs?=
 =?utf-8?B?UDhCb0Q4SnN1NlBUSDhSUTk2dGUzS2FtODBjbGlVYXhMSEF1cUZlSnM1MXlo?=
 =?utf-8?B?dFlnQnlwRVhTcm1yYzRlVWg1U0lKUXBuOEttL0lFZW1CaS9SQzEza1lOWUN5?=
 =?utf-8?B?SW1YbmJkSU9ENldhWUo1RFRoT3p5Z0hKa2ZCbnZ6RW9JdnVjS1hYa0gxYVR0?=
 =?utf-8?B?d1l2cGtZaWplczJ6ZVhtYW10RHR0VmgwSlZLNnR0bmNKT1V1UlJsbVNKNVh3?=
 =?utf-8?B?VzJ3a0NaYzA2S3pVZE1CTm1sc3hEOXozWDNEOHM0b0FQQUx3bkl3bjl1N3pB?=
 =?utf-8?B?U2c3WnJTdi85TTBXRm9JRGc2aDRWczVqWjNoY08yQU5rZzdoM1R6SWtYL1N5?=
 =?utf-8?B?YTdod0xSdE1qS0xOZGNyUVRPT2xYVEFYQmNnOHI1ZDE1RldFdE1uYmhGYUgy?=
 =?utf-8?B?SjlhU0FVSUJOajAzQ0gxSVF6cmV4dzVwOG9QaDl0c01EQXZ1L1UrVFF1N1NR?=
 =?utf-8?B?OEo5b2hMeHRpUmdxRjVLYTIzODhvd2lhakVmeUdNMU1acTFjVU9RQ3kxd2ov?=
 =?utf-8?B?akpQNXhYeFNGRE96UHBWMHBaRkJmSUNQWWJTVlNKclBRcHJVS09Hb3B3bFRE?=
 =?utf-8?B?eFdXUEtZbEtWRGJZUjB5TnpCYktRZ1Z5bDJPN3U1L0pQR0wxWFB4V2o3aWxu?=
 =?utf-8?B?UHZJMitYWW1DRmEzMTJzcEVEQXhGUklKTllnKytnU1NnMWllZnpKSlpIYjFh?=
 =?utf-8?B?UldqNWlRS0htVXJxMmdsckQ4a3pXamZFaUYvTVJrWU5Kdm1tM3gzUW9IUE93?=
 =?utf-8?B?VzRNY1drZnRDL2MwQ0J1eUk0MThKTytXQVpPaW8rQWJPZlRTb3VidUFpcDBD?=
 =?utf-8?B?dkVEbU55cDUwclhJUkVWd3NiLy9qTXp5U3RnUEtKL2pMdTJ2UGdzVnN3Qi9o?=
 =?utf-8?B?K3U0bkJESHhCeGRuNEN2Ry91WXB1QW5oRm5ORGxKV0FGQW1LSXNmSUhMclph?=
 =?utf-8?Q?prhj+YFOwPlYoNTzh3QFTHOviCZtRoxl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjhRSWlHL2dhUHo2VVQyczdtT3FYcUlzeVhiZ0xBMWdqWG05OUIzWEl3TUxY?=
 =?utf-8?B?ZmlzUnorMVRCUnJGeHZBZEJYQVl2Z2F5NFpLMjV2b0JOVFFNUlJvVEtmN3ly?=
 =?utf-8?B?S0VZUUVaYUFLNVFFQU9rZFRyQStqQThrNm5OejYwVmxYbGRUZ3lJaytBMjh0?=
 =?utf-8?B?cFJUeXRtSm9BcGQ0NmR6b3BQNGU0a3JaMk1oRG15ZjNZS3ZpMlFVUlk1R1NU?=
 =?utf-8?B?ekZydGlSQjB0NEppd0lNNlhGeUxhMEJkK1FuQWs0QmYwTTlNNTI5UFFLVzJj?=
 =?utf-8?B?dWZjbkVzRkZ0UmhaRjVZUk1ldWdjUUUzc0ZYeUY0V0Z0OU4vRXlvSm5YcVBz?=
 =?utf-8?B?cno3aVFYRDZGZnhkZXkrYWVzTXl2RVdFMGx5N0hONHlqQXFFYzlaM0lPc0Zq?=
 =?utf-8?B?OHFwdlBCUUpUVnRWcm40MDBBRTFSZnlyaVgyQklOV0VrY2lITHRic3FDMGdS?=
 =?utf-8?B?SzJkbldJb3hIS1JmUkNlTlNMWCtHMkU4MFNXUVIwYWpONFFGSFpib2RVd0Mz?=
 =?utf-8?B?S3pPSGF4cjVyTGZpZUlNTlkxZEFldTREMlh4WWZxVmNYaHlsVUdzeUFZeTcz?=
 =?utf-8?B?c2V4ZXJHT2Flb1l4Sy8rNnYydTFZYmg1R3EvLzZTdWt1KzZhQWJYeXJxckFz?=
 =?utf-8?B?SVYxS1krdm9xOTAveldJZ2wxdU9iODlybzRSNE9saE5SMzNXMXdyVUZ3bFo5?=
 =?utf-8?B?TEZPaFhjampBTUoxdDJMQ2o4aTF4WDdmb3pxWnIrSUIyNVdnOTQvMm1HeEk3?=
 =?utf-8?B?MU54S3RXVXJHeTM0SmcwNjZrMG1hTGtmZlRLM2x3ZVpPVytFeWVXL0ZIZHpO?=
 =?utf-8?B?NG0vdVRJdjgrYVN5Mkx2VmdlY2tXUWdKV3F5RkJSTzFGMzZ5TTN4YlVoVU9z?=
 =?utf-8?B?MlZKZXk5cFp6eWdLQXhLRE1WeU9VSVlCMFJacDVWSU54VUZRbHQvUjJDUDZ1?=
 =?utf-8?B?Wk8vSjg3dzU1TXdDZUdzVG5DTGR4bW1HS2tHREYycElMV0VSaVlodFQzekdL?=
 =?utf-8?B?NlpJYmdibHB5V2lFczJDb21VY1pwYVdrUGJ0UFo4c25ZejE4VCsxUzY4dGFQ?=
 =?utf-8?B?RGd1RjlmUThPTE5ZdFhsUHh1QWQvSzU2TnhETVhIWnMvWnphU3JhblplUGd4?=
 =?utf-8?B?dTFURDg1UE1BUXpwZG9HYkI4UFpxNUkxT0tIdWZEbUU3a2crb01ETnlaQzZF?=
 =?utf-8?B?NGJ4bW1UelY0Um9Td21DejVIMlZZZHRoR000WnFFRy84MDBDcVJMeTlzY3Rr?=
 =?utf-8?B?d1k5OS9oNmJiUi9FcDlNaE9MUWNJOWhsOTRiaE0weXJpeGJ1WG56bnBjaWNi?=
 =?utf-8?B?dUZvQXlZNTRRaE5wYjVvektpd2Z4NmhlN0Q5eUtUc0JRNllneGw1V0RRMldV?=
 =?utf-8?B?VVZTWXMxMEtGVTVHeVlzZTkzUVZrTXVhRFkrV01IR2N3aFNXQkFtSXRWNVM4?=
 =?utf-8?B?eHY1RlEvRmVxelJrQldxL1dSK2swZ240c1JVeEdrWDVDTmFmTmxMU1RDQkNJ?=
 =?utf-8?B?N0RENVNZeG1mMUplT1hNUWhNaFpIY1NUbURiM2tJU1lPTk1NZlVtRWxFUEV3?=
 =?utf-8?B?T3JLMTJDNGZreE1KQ2I1OTFZeUV0aG03cjd6dmF5TjNoS1VYNGNHNHVUeDFz?=
 =?utf-8?B?S0NKRldoQ2N0a212SHAzaUJEV0Vzd2FzMm5IYTVwRFhhNVhLVkh1YUx5MlEv?=
 =?utf-8?B?cWIvTXN2dFFVeU8ydzRDdkR3Q3A3em0xOVc4akx0c1h2OXFCbEF2ckMvMFlT?=
 =?utf-8?B?dFJEbGV0UDRFODZVT2xYcjdyYzVlWCt2aTJFSU1iU1FDMGZybDZac3laOFBk?=
 =?utf-8?B?clY5NVJLVnYyV1hDOTZQSWxrM05DSmVwSFIxMG5xWHFXbnV6Qk05WkZuTzky?=
 =?utf-8?B?czBmaXB6YWNzUEtYNm9ub3hPVUZhR2JseEJudUhJK0s0blRSaXVIZHVCYXR6?=
 =?utf-8?B?bmhNbHl0RXlzZlJIamIweTlsRS9aUUl3S05HZXFack9oVFNzVW9KS2doTnlO?=
 =?utf-8?B?RlBWV2pWTWMxRm92OSs4V0VFbm5ybW1wa3NjSVNqYi9BNURickw0S3VQbitv?=
 =?utf-8?B?YXpxa1RTaGFGeGcybHgvd1d4WkFoNUlKbThEbitDeURGZHFtdXp3cjhDaS9E?=
 =?utf-8?B?MGFkRUpYSndrU0d5am4vNFZqSUEwRHlKVzVWOENTZlhENEp2T1VNM2JRSmtx?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 774f9b59-9201-492a-a214-08de13572796
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 23:43:38.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sM8OG7ytpZs1nQrluDUWo06HzgL0PLIeQHGofrB8aW3v/EqJQbdHI6blrhZKqcm2hZxsDNViHx20/bw9nFfDJCWNJxyR04167pJt+rONIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8554
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/25 4:54 PM, Babu Moger wrote:
> Introduce the "io_alloc_cbm" resctrl file to display the capacity bitmasks
> (CBMs) that represent the portions of each cache instance allocated
> for I/O traffic on a cache resource that supports the "io_alloc" feature.
> 
> io_alloc_cbm resides in the info directory of a cache resource, for example,
> /sys/fs/resctrl/info/L3/. Since the resource name is part of the path, it
> is not necessary to display the resource name as done in the schemata file.
> 
> When CDP is enabled, io_alloc routes traffic using the highest CLOSID
> associated with the CDP_CODE resource and that CLOSID becomes unusable for
> the CDP_DATA resource. The highest CLOSID of CDP_CODE and CDP_DATA resources
> will be kept in sync to ensure consistent user interface. In preparation for
> this, access the CBMs for I/O traffic through highest CLOSID of either
> CDP_CODE or CDP_DATA resource.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


