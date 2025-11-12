Return-Path: <linux-kernel+bounces-897125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4BC520C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD161887529
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DB33128B8;
	Wed, 12 Nov 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZW9F/MHN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335443043B8;
	Wed, 12 Nov 2025 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947855; cv=fail; b=oOPQRg3dL1Zk34YRO3gYFdSUty0+zZwMX742/kXt+xQiL0o7sAFsLMyhsPCo3C6hpFtz+rnnlmPzuRzt43/pnrBIRsJXjTGyc8Gi4hoRnkcTZ5Wxayk+kHGKDO6EnXLoMAwk2ZVra4+V+P5YeNcyDYqaN2rCuneuN57eLfr3lS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947855; c=relaxed/simple;
	bh=QyfwnkkIR1bmBqpVmjYVmP7DsYwwT5PdZWaNUoZ+AMM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WhVEszsoWSqWeAWDbcZU+hkpimgG7U6ktUbq0QpE357XNzYFXaPzVoozDf8eUQZjCbA2oH8mBN7ZHHhGcCWZTsTt6Ov0NGTsDkC2ee+fcg6TO6lrMsVPFnhLSHSgQ7u5NBe1sjnECv+V2TbVGAQT9UdBQuYB5OjXbR2EXWmgZzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZW9F/MHN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762947855; x=1794483855;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QyfwnkkIR1bmBqpVmjYVmP7DsYwwT5PdZWaNUoZ+AMM=;
  b=ZW9F/MHNI1r0VoXQoKcoi4PSJHt7lKTTIoA6bF8bEdts5lHkYFa/XExA
   GAatrS0eoOIduV2WyjnjSWRsbLvwtOgHduT/MhPIJvIr1of1XbqVnL4oX
   VDGal220KuS3IfAZgQ/JNUhHqYR1LJc69f4Z8aX+m7o37bOxBt11jJ1Kv
   3fTd7n7OgZhwgU+M5rh3qxXacCx/hf1f3tbxh3Wsv3Tvci++RguGAlO2I
   2kDsF8dYDicD3HZHIkL6kMRQ9H3unGqMSfWr9f9vxUtxP+fxGpQNFsV41
   Ezr9Ms261gSeLjRYjC/C48iVWg2oK5jHVXSZqq7XyaF9mTEY3bhvMR66t
   Q==;
X-CSE-ConnectionGUID: zxTc8AEGRyG/kX0J6JIdOA==
X-CSE-MsgGUID: ySlJH59WS+yX1HeU7s1Hjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="87647494"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="87647494"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 03:44:14 -0800
X-CSE-ConnectionGUID: dX67qwc2RSWyb2SyOKK4pw==
X-CSE-MsgGUID: N2F3zb6mSQGKkYoZkFJ5dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="219930476"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 03:44:13 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 03:44:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 03:44:12 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 03:44:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0Mw1gD26Onu0ALxMiYkGzzpn/l76argVFW+3U3C+csh+2Bo6BGQe7z7T9zf9wsQNxevVyJxLRCjIzT7ZuQXCezu1mbh4mCaofnXn/wyKo6/Za5u4ymVWEMwkfBOz+bc90bnBbaTIGbtqYslKFiJB8eIrRkJrtNMksrR7UGCCWflY3CMAo1pp7wOVyTy53/3IvrUSxDUj3xvGBvbtMR8MDCmPD/oUoYcPEEfqbiJWmuEOfE3Kx13rEmr1zm89t26ryj5tJwQIPHqbvwdsdgpM+zuqYpsXJdnKMig9M+/Uz+pYMFnV5NM3Z987NwP5EkTfkMfKuZZ5/M6dG6Pj0Rikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJlAgtMdGo4OBKTqZ6a810lVuOdih1k7LVOxwMImVKk=;
 b=rWBY+qsV33VXO3/six131Ohuy3cshA8igL9oYhGL9oRfTeqhwp/dhLFf4vzqgcZTJvZ17m/cOW33SLaj+5Tyt8z+fddptrpGMrMHqhfnHJq5JCJOT25Ekd1TBpnfuvLVTZUNPYs5EULe7s7VbmrHg1R8uzidlAWb0FtHRuiZk7UT//dhITO3FtMGjqbLs2P0EtJBJb9RwhljucRm8dc4rKvXRr0VINsdOG9axaStfqiVqXSh38h4hau+ZdrAJTgyn5AgvLqrkzA3kfJ/i+OTpPt/OR8djKDH9w/Zw0cVlD2KFQIZcjRr92p/m7xqE8Rf84Npm3Oa6wsBPSdpGrFDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by IA4PR11MB9250.namprd11.prod.outlook.com (2603:10b6:208:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 11:44:10 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 11:44:10 +0000
Message-ID: <49fc19ea-4401-4f33-ad4d-5419acf6139a@intel.com>
Date: Wed, 12 Nov 2025 12:44:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: Intel: atom: Replace deprecated strcpy in
 sst_slot_enum_info
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Liam
 Girdwood" <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>
References: <20251111224706.87508-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251111224706.87508-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:802:1::34) To SJ0PR11MB8294.namprd11.prod.outlook.com
 (2603:10b6:a03:478::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|IA4PR11MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7a6d07-4538-4627-abf4-08de21e0c9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk0rUlhkNHZ4VlJDekkzcUpwc1pjbGo1TGg0TWZ4aFNyaFhsZUkzUEMzalVj?=
 =?utf-8?B?Y0tKaGhranhxOXZkbjBxZ1VEL3M5OVFVRVd6M3B1b2FsSnZhcmNuYi92SndQ?=
 =?utf-8?B?MnQwNHYvYVJia3RLakt1ZU5XODJOL3ZicCtKT0JQbW1FNFIxNC9UdGU0OGRq?=
 =?utf-8?B?aXlMSC82NlA5cXFPTzg2OWNLY01RakorYnhRS3lROXJJSnZieExKQW5kY1pa?=
 =?utf-8?B?ZGgrWFRjQm9ybWpOTUFwYmdBaFd5YVVWR1pyUndpMmlZeXBYNUhNSitLazdB?=
 =?utf-8?B?dDdCaWhBbllTZU1Vd2IvMXlXZ3I4LzRlMWQ2c29lWGFEVHVsVkRBRmVsN3Ry?=
 =?utf-8?B?Q0RFdkd4VXJldmhURzQwZklxanAzWEljWHptUkxZMm1mMTE0NGZFUlMzY2dw?=
 =?utf-8?B?RTcyOGtCUW5YS2R6d1lJU0MzcjRqRDVtc3NuOGRROGFuQ3k2M0JHMU8wbXFs?=
 =?utf-8?B?Ty9RSk1lRkV6NXFUdnA5QzJ1T0ZGNXNmUG9WRHgzd1RkY0c5NThudWpsVm1u?=
 =?utf-8?B?VDNYTUZDazROTTM4eHdKVXNpZGVPMTdzWEd5aVFnVStYOWt2YmFNVi94bjky?=
 =?utf-8?B?bGtmSkNZM3dYZzVBZ2l1K0dTcjdWTnlsYUZqTHlXbm84amNEMm82amJvTEZw?=
 =?utf-8?B?VjFuYjlXRzlUVU5BSC9CTlJjUXZCZVZXcEM3YW52ckxBVUQraXFITHAxcE9v?=
 =?utf-8?B?OXVHdkVLZEFOYllCSXJNYnJrUUNJRnRpR0R2MEVyYzY5MWloUzI5aWE0dGs3?=
 =?utf-8?B?ZWtCL1lpSDJBSytSMFQwUnppZ1BYRnJwWlN4N2U2QXhMMDlpMGhmaFE3emtP?=
 =?utf-8?B?cEx5VmJhK2tNODBsNmJzY0RvRTJCdTA1VVlKYitvTC9KZjFNZXdndHBaVmJO?=
 =?utf-8?B?b2p0cVZTaXkzSmhRZGo2aDF6N3hHLzNpek5hNFd1SUt4WktKOXlKeTNCNDBV?=
 =?utf-8?B?SzMwemUyNHRKZ3lmWklnK0NSMS9YdXluN0hZWmlXN0lmQW02eFlPanJyRnJI?=
 =?utf-8?B?RDFDNUlWcUtJRHF2TE5UaEpXb3VFUTJOWjM1Yjd2QnpwQXlKWStaejg5Ly9R?=
 =?utf-8?B?SXhINXd6TjY0U09TeU1Bd2dOQTBDOE1qOWVCOVc2NUFQYnZiR2JTdXMwNlpw?=
 =?utf-8?B?YTBEcHFiSnB2RGRPR3M0QkJ5U1ZjU3NUb09JWWxmUWlDd1VtbHRpcHhvZzVw?=
 =?utf-8?B?TS81REUzZWhBYzIvelJUU0F4VzhnZjJJRThmd05UMU91Y1I1bnBvblVsN1VH?=
 =?utf-8?B?b2ZsVmZwQTRTK0g5elB4dlJrSG5SWlF4N2NERWhNVGJPb2dwVHE3NFRzQWFY?=
 =?utf-8?B?K2dFbkNUa2dWaG44UGMzMnpFOVZqRFd5U2M1eEtlT0RjNEluYXZSazhHSldE?=
 =?utf-8?B?UTBSUGx1cHY0UTJZT1FBd0xOVTNsbjJiRkZRZ1VuMFhGVFBjNkJYOURQN3I1?=
 =?utf-8?B?d1M3Z254MnZ0SStLV2FCQ1RKaFdPdDZBZlZOUG9weVVLQkQ3TTJSbzVBZkZD?=
 =?utf-8?B?ZzAzQUZtYWEvMDcwVFYvRXNzZ2s4d3FqVUVaTlhPUmhMVjlNaUhoV3hEZHdQ?=
 =?utf-8?B?QVFwV2tWbWxlckxnMFJrWkdzTUQ0aXljWjZLVXdRMGdJN1VYNG8xTFlqTy9m?=
 =?utf-8?B?TDBuQWRQTzZCdUVNS25VMk45Z3pkVTRYL0NmQW15UENqaTFtMzhmR2pJL09J?=
 =?utf-8?B?LzNSN1dBb2VwbHltazhyc2hmbVJDZDd6V1JRUGxVNDNyK1pvUXNNT3JqQkFz?=
 =?utf-8?B?V2x6aWhKTUpWWlJ1Q2FkWUdnaVE1Y3VYVXN0dUEwaDkycEVIVkZieU9ZRjJS?=
 =?utf-8?B?RUtQVWc1cnJ1K0o3YUtLMWtORDZFTkhReWFSNUNJZ055MWh6Z3duMTlCam5r?=
 =?utf-8?B?MTNiNHZHT1lMZnRHSWJZWTB2dGx0bDhhbDRLQ2lmN3grU2M4ai9KT0pic1p0?=
 =?utf-8?B?cXZETCtGcUFQSXh5a1NIdzEweXNCZXIvVUpheW9ZVndNcnJnZk82VnBNYnFK?=
 =?utf-8?B?L29GbVdBQWlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTUwZ0ZsTlBRYmhLWFNsTUpaREJadEtsaFp3dVlqaE44TG8wZ01GVlM0SzJn?=
 =?utf-8?B?Ull3b0J5TDNZL1Y4WGVqSStUakpCd2h0L0wwclhvaGNweml1aEdZUi95ZUdP?=
 =?utf-8?B?ZkxNY0JuZUNtUWxJTGxMWXVvVFZpL2ZvZW5zQjI3Njdqbmt2RDhlTUF0SzVX?=
 =?utf-8?B?cXZibkxWaG1pdWRNc2ZzbVdkUmM1aWNwWlJybFZ1TmV6cGRCLzhuSUJGZHho?=
 =?utf-8?B?Z1ZRaVNJL3gzdHpYNDFEQnROME5iZXZkNzgrOVhObnRRbEZBdVNlQWJpVmE0?=
 =?utf-8?B?NzNKRm5kVEg0ejRMdHYvbG0rODZpUHJJNFBLTHdndkhsTzdOWFBIYWpNeXVv?=
 =?utf-8?B?WVdUU3ZFbGJ5b1VENlVNTHZRUHRnKzUraHMvWXU1bW05QkU2aVdRajlic1lY?=
 =?utf-8?B?WHZwaUZ5bTdlQWszSW53NGswMTBvend0d3RWVnZzOXZ2Yll4NTFCazlLRFpS?=
 =?utf-8?B?dkFjckJpZXRZTG50RVo4YVlLcTRxeHNiTW93M3JZV3JTcDVneDEzNzA0NGxJ?=
 =?utf-8?B?SnlpbUczc3BmTUdhYkZISkVHcWZjZUJMN2Q3Rjl2ZVlwYTRzc3BiMWw3Zmlh?=
 =?utf-8?B?MkZmUWtMekwwUUduQ0N4ckl6cVNjVldlKytnaHY3Y3pQZTAxYndBTklxZDkx?=
 =?utf-8?B?L2JVNVcvekZ2TStqR2N2SDZPTmRidWFNTlN6U1NoUnhpS3BFTVVjbkdXVmxZ?=
 =?utf-8?B?WGRkbHQ4VWk4LzNaVFBVVGxJOVhmc0loaUZZWWJJSnJ5ek9xL3RBYnkxWU9v?=
 =?utf-8?B?ZDEvVDlaSWNMdXJvdUhMU2lOU2tUaEJDTTREOXZrRFl5NHdTMXRQV09kR1Jp?=
 =?utf-8?B?eTFtcThJR09remtFNGtHVGo3Tkd6YkFYeGZCV2FSNS9ORDhZa2dVL2JBNENR?=
 =?utf-8?B?QnpROFlSdk9OM2hrWGtwb2o4MmJyVnpMalFCWm50c0hiY2k3TnVSY08yQTJy?=
 =?utf-8?B?TzBwTEpBd1BhemU5SU9mejVsQndRRW9RbFBNTkdmcUNzRHlCa3dHSWx2Mkhx?=
 =?utf-8?B?UmUra0xncVBPaEYySVFqYWhnQWltWGIxM3pGNUVMTmQ2d0FzNUpoem1pN2V2?=
 =?utf-8?B?ZnlkMUFLSkdjaXZxU1VXT0pocmIwNUZ1NGdtdnNNckkvdExuNzdhMDF6Tldr?=
 =?utf-8?B?dFVBNWhYd0VuZzNSNTcrTEFHRDczN1ROblVndW1DWHZLWVlkTlZ6ZE80K21K?=
 =?utf-8?B?WHcwWlZuMFFtR09mSWQrU0VrRjB5MkZDMytUT3VtRm9HRy90OVBhVzZFbUNx?=
 =?utf-8?B?UDJnYkFNZTA1MW1CU3MvcWZYT0lERHhkV0NPcDYwUWJWb2F6V0orZis1dWFQ?=
 =?utf-8?B?TXVROUFDTXd4Ui9GbFdJQnlkejV6bjV0dWx4WU5qaFl0T042RFRHSDVZdlNj?=
 =?utf-8?B?S3AxY1VRNDhoZ1JCNm1Rd1ptSXJGTk1jVXBpOU1LaDhHNFM4SytVVlVDZWFL?=
 =?utf-8?B?WWxQMXR3Y2JlY3FCVEtlQUlQMUVTcGdOMnQxUitrbnpLSU40bmJHR2ZvWnNM?=
 =?utf-8?B?eEpzd3lQVUR1MUwwS2Q3Y2VnVlhaajdDV0JFcnUxTHpnT09vSUhTdUtOL2JL?=
 =?utf-8?B?U0h6NUJQa0I3aUNBN0FHQUplOElXS0hQcXltOEcxbHRaOUxBVWVWYTJjTUZO?=
 =?utf-8?B?OXFDOWdKSGRCU1Vxd2xNTE9TTWhVUVBVeitHMkU2eHdCVzhTcHVUQzJaWEs3?=
 =?utf-8?B?ZWZxRlR2UlFaTUl6ODhwT3pmU0o5Umh5U0VaTlFmd0FHRWU4MU5YdXd4L2ZS?=
 =?utf-8?B?alFIRkFoT2tpRGdOWVpXWkVBVlRRTUVpeVErOVNPenljTi9RVzRXY2Fnbllv?=
 =?utf-8?B?cHgxQnVzbWVBTHFpTXZGMnViR2FUemdvQWJHWHpJVCtUVkV1cUtCc1doRGkw?=
 =?utf-8?B?bC8yZE8vUmdJbkpPWWJiaHBFc1d4UWkvUE1talBNRVBrWjFBdWltMzhzNVcr?=
 =?utf-8?B?NzBVRDIvQVhyQ0UyaStYd0MxQ1d2Rzc2bm94K1dBZWdXZ1o2NVlOWWdxamdn?=
 =?utf-8?B?NUFOODRIeE0reEl5dnpXd2FyQVdycHFtQVl4cTlmK1Y3UDQ3UGttRDhWdjh4?=
 =?utf-8?B?Nkx6eks0TGpEL1NnYzlJcUJScnR0TjA0TzZVWlJKWFhsUi9BNXlySFp1U0s5?=
 =?utf-8?B?Q09oVjVPZnVaMFFRWXFJL1lHYk1qM0ZHeGZpektEeDQ1d0FhVTZ5WE5qN09h?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7a6d07-4538-4627-abf4-08de21e0c9e5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB8294.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:44:09.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjJmlESi/Dqn9mMWK3JDR2J3h1677TUz/TZ8oFgDtxFfrDkLMDRTXH40FSj9TB0r5j8NJEKOvDsbYtk4yxjTou1xyoTbuiUuYwXJDw8wS/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9250
X-OriginatorOrg: intel.com



On 2025-11-11 11:47 PM, Thorsten Blum wrote:
> strcpy() is deprecated; use the safer strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   sound/soc/intel/atom/sst-atom-controls.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
> index 38116c758717..799d4f0881e3 100644
> --- a/sound/soc/intel/atom/sst-atom-controls.c
> +++ b/sound/soc/intel/atom/sst-atom-controls.c
> @@ -142,7 +142,7 @@ static int sst_slot_enum_info(struct snd_kcontrol *kcontrol,
>   
>   	if (uinfo->value.enumerated.item > e->max - 1)
>   		uinfo->value.enumerated.item = e->max - 1;
> -	strcpy(uinfo->value.enumerated.name,
> +	strscpy(uinfo->value.enumerated.name,
>   		e->texts[uinfo->value.enumerated.item]);
>   
>   	return 0;

If you go for one-patch approach as suggested by me in the PATCH 2/2 
review, the title should be: 'ASoC: Intel: atom: Replace strcpy() with 
strscpy()'

For this patch, both for v1 and v2 (if any):

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

