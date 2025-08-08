Return-Path: <linux-kernel+bounces-759626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8760B1E053
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10C13A3D6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6B21553AA;
	Fri,  8 Aug 2025 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEnTF6N3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B54290F;
	Fri,  8 Aug 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617912; cv=fail; b=DY4mFRZNerJxIJcj0gK2HcVdB3VnT+KMr8DWI1F7kVLRkdiLuFltF9D+Lw1a+ZHOXPnSkz9PlpXs5gCfgzGLiBNwbTQLgg3pLilsbeGGETDgAoxoGBxkagg92DusTelD4zZCx5GhvlBC2V6+QAazNiDys1TH8c58jK9HO9dRteA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617912; c=relaxed/simple;
	bh=csJ2s7ipN3qSO1lCLWE76EWYdBJWpA/jkQhhXF3NfAI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OEMO93DuWWtrwrqG48Sk3dIZ7SdIZiB3Q9fUneA/2U+qw/jX3tzSI8YTjTLUUXGL4upNq//DVk3LRmeawGkqy04vfoiBMtBJv8JImWOhbp38POvDkC6DgmQvsJjDRinHA0hDBbCtsbyg6CNdRm+ndaVNzk0nqBDnDquXrlVZEKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEnTF6N3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754617911; x=1786153911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=csJ2s7ipN3qSO1lCLWE76EWYdBJWpA/jkQhhXF3NfAI=;
  b=YEnTF6N3z8LhwxymbkqzDRnKHIu7wUJvEhlJgX0gsIvDUT7wxviU7et4
   EUR4pvx/PV9b70zQLemg5KaVPZ90tMHI1+RclFCkvOuezOyyJJ76NJuQA
   t7MOqL7uTJODelctbZGzU33G8XdsNw++3mszstSbqnCFIA+540Pg9PD8V
   aK8YjZ6tEYLKC7lkfiKb/4SEO//q73IZpXIH1k0jgHzwumKa6JKWpxqVK
   KBEYqMAx7SlDMKBwLRqg3GTbuBumPL/g3+cw9wIfC8O1CBv2rBvA+LBRF
   COl6NvqQ+ZRZYhbhwKpYg38avsKZNOxgy4q/82PSGgGziC8y5RgJbNJyU
   g==;
X-CSE-ConnectionGUID: kDqydupMQGGCj8WOBgaxDg==
X-CSE-MsgGUID: 6hAXsJs7THWVqpQcx+mm+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60592244"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60592244"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:51:50 -0700
X-CSE-ConnectionGUID: 3Qdg3nECT0uqpio/mcQl9g==
X-CSE-MsgGUID: y3lRxWh8TcqpDRveggYOJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165226989"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:51:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:51:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:51:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Twpk1B9QGLEwN1N6p4pB+dAv1xo266E6dLhCG0/7hk0nG6tdbgKR+Dwv3I4BwnRB223kHnmjFbxS4xmNzHk4B9NhQSNLSWN1RumZETFDPTRnkXj+Oy0RP4hi7Ov7n71ZA0AxiPGJMJiwPPkKuaqvhyJrhbMarGu8kT7xGOrIqlrMoAoBwWXsoZG1H/On3k3L/6Hcxp5vc5LmLkVnp9WU5iCRpGM3tYQQ7RluyGT/85Gqv0JMJiweqkdu/HFSDgKt1H8u2VU0gZHLN9vfNqptqbOZQcQ3V/Pb+K/Yf0+smtXRfWhQjp8vFXaXEe7/Zn8Xni9G7gyR4c/pmsdgYTX0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4EGuUxSN4XGL1c6/OXHCSZKfTzlsCF2ri4bEDQyYOU=;
 b=UcX2yFdSd6BtmCYmLuoh9ejUTmvp0CgsbkMxp+ugrCEHHY9CcocruwyeRRMlFiAxEaWKskhoRN4oKMvP8kwziZZhs7pUY+dKAoWv+XRDBUwRzWyFjLl5hyGQ0kEn2zbA22EeGpLIhzQtfkt7+8yHHddOb8J7LPVGnxoHjqHHAzRKkH8BPmPUcXLZv2nyHKXFTWXp3bQyn5xHUpnuP1CfH8Qnn7dLKTRKellZuCjJV0US4szgrbdSjdun8dZVVY4kBvSjdHGcHRupaqFGjXYn1VO6auW0aatTv1ZrjElJj/BrdxycDsc88Ip1REvAAzDWbPxWvEPSQRqitF1msW0y0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 01:51:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 01:51:46 +0000
Message-ID: <63a8dd08-91c4-407d-8064-41d395d514bc@intel.com>
Date: Thu, 7 Aug 2025 18:51:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/10] fs/resctrl: Introduce interface to display
 io_alloc CBMs
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manali.shukla@amd.com>, <gautham.shenoy@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <a5bc5ecf27c229a0cf429dba6a174e39cf83357b.1754436586.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a5bc5ecf27c229a0cf429dba6a174e39cf83357b.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 28047729-c5ed-4258-c84d-08ddd61e221d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWkwQS9oRjdwK0xsUElLVEFaNG9qbmZFSnUwSlJSb2tpUXFuZXMxbnFjdXRq?=
 =?utf-8?B?am1GZlZYdnhFdHNYTUNNWHg1R3hNVzg1NG03R3BDTWlmMFZ3V3Naek1GeXFm?=
 =?utf-8?B?aTMwSzZWRm9OUHFIOXpoSjFkdW1OejBhODdpS05odGY2dnNtQU0vMDJrS3FM?=
 =?utf-8?B?b002bk9XRGVYdktGYUl3WFJTQlkwS1hvb3BLZ3I2S2pxckJKMVhsNEkxR01K?=
 =?utf-8?B?ci80Ulg4MkI3UkVwMnpzMGRwRWFjd2NIZVNkczNaTTN2emRKMUlSbVNzL3pR?=
 =?utf-8?B?U2I3OFpQQlNhQ3RIQ3FaTWRyWlNCYlZLdXZpa1FhejFZZU1GWHFKQ0l6c1lr?=
 =?utf-8?B?a0R5eTNnZWlwQXlOVkRCK05sNjdMTm01YWgvZnpOdmRYYVM0NXYzSXVRMmRR?=
 =?utf-8?B?cDVTYzNJZ3JFdU43UkkzNlpTeEdmNjhEMkpUYzhCUmxGTSsvZ1JhbkE4N09N?=
 =?utf-8?B?VXJPaUhCU3N3NkgxTEx0cUl6VmEyQzdoaE5ROGR1RFRsV2xybVYyNkowWGpw?=
 =?utf-8?B?OFRoSUo2dHA5TGcyVEJBWWorV3FPUFJJZS84QVNwQUZYWlRvN2dGS1R6cFNJ?=
 =?utf-8?B?WVBQNVFTeFZLMzlTU1Nzb2UxbjlHUms1VmtRTDh4VFk2Y29CR2dsZUtVL0xH?=
 =?utf-8?B?b1ZaYlVXYk9vSkJ1RGRTZ3NoUDNBSlJzcUV6RnRvc3QyZnNta3NqVHducWFw?=
 =?utf-8?B?ZkEzQWRiQ0pvbzUweEM2MmRpbzhaQnFxZzVQeGZxTFdFc0o3bXYyTC9LMXBB?=
 =?utf-8?B?ZDlzSjJ3bEJWWk5Xa1F3MWtnNXIwWmdvUHZRd2syUHlmSEU1c2UySkVkQTZM?=
 =?utf-8?B?cXpOeHRwc1dxV2xVOXVpTFdhZTN3ZzZRcWd4c3NGN2Q3d3l1VEIrSjR0RjZF?=
 =?utf-8?B?dGRBMmtLUmJIWVNxMis2ZjUrTDM2WmNQYzJKeHlpSHlLZGdWTFVuT20zTHh5?=
 =?utf-8?B?YVRsVVJNb0tsVkRwTy9TbUs1Z3NmV1dOV0xJRFIzNXdIWjVrWHdYT0dQWmFD?=
 =?utf-8?B?Y2VPSHowNGJ2eFVES2NLRmRZd3dnY1lBV0U3VkNNV1FwTlN5SmxzUkM5N21k?=
 =?utf-8?B?ekJ5Ui85cGY1RnpNZDQyQlNoTURJa20yNFFtbVNZa2k5Y0JwRFN2Nk83R2ZZ?=
 =?utf-8?B?aDFoRWxsZ2wwWUhZLzk1dmRETlZqbUp1TGwzSFhuT2RIZ2gxQ3I4RzJURlV3?=
 =?utf-8?B?MDZ4a0EzVVpEWlh0aURtTHYzMGo2bG0vbXl0TG1EdmpCV2gvbzNyMDBoeXBM?=
 =?utf-8?B?UjNndWh5ejcxTW5nQ2lTUkZPeVZjWWVQeVR1RmEveDJTNnFrcUVWT013NGpu?=
 =?utf-8?B?TXJWbEh2RUhYdmJzd1o4dW45dk4rYi9aeXpoZFMrS3o2T2VxRkVvQ1JsYmhG?=
 =?utf-8?B?UldxY0VQQ0dIblJvb1pzVEZVUkFuTmpGL1NFZjI5dFdERVQ5d3BkS3Z4RHJ6?=
 =?utf-8?B?MVJPeVpwZ1R4NHJrWjVYclNPZ1dzcGkvKzFVV3dqTUVEdTRiand6b3Rzc3Bu?=
 =?utf-8?B?NDlUYU52L3RITm1OQ0JBWHNNcEt1THcwRWoya25HbmdWOFBJK0M4MmpQVnF1?=
 =?utf-8?B?dTZLQUg5RjI2KzhSRVZvS1hKam1CU3U5VjRrcUlDQzkxYzh6b3NPNnJROGV6?=
 =?utf-8?B?ZWFlWkNydmpoTVljbk9OajRqbUlaWnBYN0x6V3VNY0Y4RW40dmtmMUo0eGR0?=
 =?utf-8?B?N3hiRTZxMkJmVk5XSDBZK0NLZzdoVEtrdU53UnNZUmVNOWdxclphZ2JYY0k1?=
 =?utf-8?B?aHduWklKejhxR2VxZ0luZEtYK29URTJ0ZFJOd0NxcFpKT0hpSkZHVm5sSlg1?=
 =?utf-8?B?TTBXbjFNdEZ3aTRIRWRpeFNlbjhGZ0FuSm5hSlh1Q1hSWG1oT3poWS9sdGRO?=
 =?utf-8?B?cW9oV0tyM0FkR2RnY2hTbnpQN3BrTU1aam80ZGNGM1JkM3ljQkp0azdKcDZ5?=
 =?utf-8?Q?QAjQEPFwtXQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE1zOFVBTHJ1RTNZUHljYmRXNUZuc1NqcHJoVnc4Wmg2R3pxcGlvOEY2Umkz?=
 =?utf-8?B?VndQYTRvS0VtRHYyc2xQbzh0eE85WVhxT0c1V1VhTDJIRW5KMzBWSVY2TVF4?=
 =?utf-8?B?RGQ4ZWRXNTRmZlVpNzljTzAwaFg5UmJwc0ZIK3ZJUEgvRGRlT1J3MUQyejlZ?=
 =?utf-8?B?aWNJdmQ1cnlodms5aFBTeklCclZCblQyWlV2MDQ3VHMzUmhqM3hlcXdiMk94?=
 =?utf-8?B?Wm1SR21jblJpc0dORVBVUFNGdnByVG01TDJWZXo0MTBHWVhnTXc0N1QrbTQr?=
 =?utf-8?B?dG85SnhOWmVoalg5c2NvVFk0d3VJTmI0ZnIwWTIzODlQeEY0TU4rWmIxbXV5?=
 =?utf-8?B?M3hkVG9vNUhKQStuLzNBc1Z4c1o0bnFVRFFCU0ZGNHdhVTk5TUJKQVo2RDh6?=
 =?utf-8?B?UG5aS3Qwb2ExYnZIWUlLWHM4L0wreDlya29MZGZBTmdWekVlS0tSZElXRXJW?=
 =?utf-8?B?QWVzTVpKY3FiYTQ2RjQxekdoNkwydEdCd2dIbU5JSWpOd29FZWpvL3RqN1VE?=
 =?utf-8?B?VEVGZnNNaHQrU3JDZ05JamNnd0VXSThvYTIwOFlHYmRXeHFSdmV1NGVWS3Fv?=
 =?utf-8?B?b3RTWU5zcnRTbHVnV1Qxa3BNS0JWNk9lN2p1UE5STTRjaG9vME5rbk9YaVl4?=
 =?utf-8?B?U2s5YVplVVpVMXdranhiejlrakQvWVZ5ZEpaaFo0TFVpWTdUVm03eHVrQzV0?=
 =?utf-8?B?QnFpUFo3MUpnamdxMWd3UEVON3ZYaE5qSUNpNmNRbmEyMHJDaEJMN0c3SklJ?=
 =?utf-8?B?SFBzbTlFbktud1p6NWFvSkNyMjNNZm5wbVM0TDFmZ3FPVDJZK3JNZmJvVEFU?=
 =?utf-8?B?ZjU4bGExRDM2SmZmM3Z4K1IrRXMxSzRXQ01NQWx4KzV0cU9TaUQvMXRnMmtV?=
 =?utf-8?B?N1Vka1J3eFpyeDd2am5MampMM1VqK1A3eVNsSE1ZK1doUDNTWnpMTEpDZ2l6?=
 =?utf-8?B?YTJUc0dvQlQrSGc0U1A4dE9FazBTbmtOWUV5b29tK292ZDdFYlorZVRXb0Zo?=
 =?utf-8?B?NG10ZHVMRTZpd1MvL3dNN2tSSitYdVpoTHI2bkYxZHQ5MHd5V0YrU01CWXIz?=
 =?utf-8?B?L1BUWTRoWnczbWtTZkl6bGRQMnk1V0MyOFN3TURGckFCZTV0OUkwcGxZRUJQ?=
 =?utf-8?B?eG9ya0FzSVlpbFd4S3dzTTVSeTA5czJVd2dtczJScXZjaVl5QkxKbFU5QTl2?=
 =?utf-8?B?THpOeERSelREUlA1YXRqWFdFcEpxaVNSS0JrdmtvOXBDRm5ycW0rNXZ2cE9E?=
 =?utf-8?B?TStSa1Z3VWxKL2hWdXBBOHRqNG12UldJT2drcU9tb1dsSUV0bVFiZ2Y4dTRi?=
 =?utf-8?B?Y1BTSGZiMDJwckJ4bTVOUGhkMkpJWHY5VXR1R3dQd1V3aHB3VVN4b2JQR1Nk?=
 =?utf-8?B?cnI2eHZEZktIQzV0V01rcFViQUhldTdQRTJpdjF6MEVDQWh1U0lxemg0ZjYv?=
 =?utf-8?B?WFUwTldNTDlUeUQ2YlNhR2ZibFM0Sy9NaVYzM1JReUlGV241TUgxWU92SC8y?=
 =?utf-8?B?Nm5sUlNrTUJ6MWZ3K0ZSeFI3dmM4Q0pJb3dITjlqd292Qk4vUEptLzZPbkFS?=
 =?utf-8?B?R3J0OTB3SXNkbmdXNzhlRnNuakMzZ2RuRTlhRTk0b2lralZCNGFDOEFMTFVB?=
 =?utf-8?B?Wmx0b1JUd1hEK0l6N3hHTkhHbSs1blpmVU94YUlPeEx3RzZod0V4RmdVYy9O?=
 =?utf-8?B?bXFhY3ZGOHF6dXQyN29RVmU5ZlNTZUNhQUlvOFpIMWpGYnNIbU8xcnhUTk9V?=
 =?utf-8?B?Wks3aGdTWWNTQU9IcWd5Rm94WStmK3Jtc3psQTlYbkpCMmhvRHR6TjQxZmRJ?=
 =?utf-8?B?WHJIYjdyWkx3Z3V5bCtNWlpuQkFacEh1N2NiLzAwaTRoUmw1K3NUcUp2eXBS?=
 =?utf-8?B?SG14NkE2VVlhLzVhci9RSVVtT2pGSUgwRHd0cmtzaTBYVTJCSEthZktONnRK?=
 =?utf-8?B?dTJUQW8vbllNRnBBUVVOaDJWalNHdlBXSjQySzJ5NFZ3eWh1azJ4LzFENVZQ?=
 =?utf-8?B?WGMxU1lWSUVXRHNOUzJIa29wSGF1bE9tVmlHMjdHMUUvMGZLVG1jbDRIYmM1?=
 =?utf-8?B?YjMraVpaRUFBWVczbzZWK3FSV0p1S1NHWmNidmVMbTNFVG9pWkxsRFNhdXdU?=
 =?utf-8?B?YWNiNkwwN1lsdGZVSktaS1FyVkV3YVNQUnd4MEUvaUx3Z3ZFODAwU1dxUjBm?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28047729-c5ed-4258-c84d-08ddd61e221d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:51:46.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmRvvzeCCLBgQYyLRHVGB0tztAefr6HH4gCxjaASYa50GXOOONQHfJwBYJ1wPA0gwfzNhy8TwaVlqRvO+SSnUjefbvMirEFiw7475UeeN5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Hi Babu,

On 8/5/25 4:30 PM, Babu Moger wrote:
> The io_alloc feature in resctrl enables system software to configure
> the portion of the cache allocated for I/O traffic.
> 
> Add "io_alloc_cbm" resctrl file to display CBMs (Capacity Bit Mask) of
> io_alloc feature.

This is a bit vague. How about:
	Add "io_alloc_cbm" resctrl file to display the Capacity Bit Masks
	(CBMs) that represent the portion of each cache instance allocated
	for I/O traffic.
> 
> The CBM interface file io_alloc_cbm resides in the info directory
> (e.g., /sys/fs/resctrl/info/L3/). Displaying the resource name is not
> necessary. Pass the resource name to show_doms() and print it only if

"Displaying the resource name is not necessary." -> "Since the
resource name is part of the path it is not necessary to display the
resource name as done in the schemata file."?


> the name is valid. For io_alloc, pass NULL to suppress printing the
> resource name.
> 
> When CDP is enabled, io_alloc routes traffic using the highest CLOSID
> associated with the L3CODE resource. To ensure consistent cache allocation
> behavior, the L3CODE and L3DATA resources must remain synchronized.

"must remain synchronized" -> "are kept in sync"

> rdtgroup_init_cat() function takes both L3CODE and L3DATA into account when

I do not understand this part. rdtgroup_init_cat() is part of current implementation
and it takes L3CODE and L3DATE of _other_ CLOSID into account when
determining what CBM to initialize new CLOSID with. How is that relevant
here? I wonder if you are not perhaps trying to say:
"resctrl_io_alloc_init_cbm() initializes L3CODE and L3DATA of highest CLOSID
 with the same CBM." 
I do not think this is necessary to include here though since this is what the
previous patch does and just saying that L3CODE and L3DATA are kept in sync is
sufficient here.

> initializing CBMs for new groups.  The io_alloc feature adheres to this
> same principle, meaning that the Cache Bit Masks (CBMs) accessed through
> either L3CODE or L3DATA will reflect identical values.

I do not understand what you are trying to say here. What do you mean with
"same principle"? The fact that L3CODE and L3DATA are kept in sync is
part of io_alloc only, no?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---

...

> +int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> +	struct rdt_resource *r = s->res;
> +	int ret = 0;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!r->cache.io_alloc_capable) {
> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	if (!resctrl_arch_get_io_alloc_enabled(r)) {
> +		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +

Could you please add a comment here that explains to the reader that CBMs of
L3CODE and L3DATA are kept in sync elsewhere and the io_alloc CBMs displayed from
either CDP resource are thus identical and accurately reflect the CBMs used
for I/O.

> +	show_doms(seq, s, NULL, resctrl_io_alloc_closid(r));
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return ret;
> +}

Reinette

