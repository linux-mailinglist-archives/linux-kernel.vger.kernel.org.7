Return-Path: <linux-kernel+bounces-760451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889BDB1EB5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC6618C58BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA312836B4;
	Fri,  8 Aug 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hulfyWcN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996C2749D8;
	Fri,  8 Aug 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665977; cv=fail; b=I8x8WgN7wsuLNKeAQkG5Rt80b9FYR7/a6qbm3IRRwkjl96kSmpKstMUbJGbhrKk5pfnwkOXPh4EpDUPcVnY7kjxKk6ql0gr4Cz02GF2DJ6novVez+PVSGHmcfzrM3er5uE4A3drvhcsHR20Ci14kzociQnrzPvTNKE/Tx5RRG0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665977; c=relaxed/simple;
	bh=M9zWFpLU9ZS+nbPov7s/cFyhvkYnKs8Ej73VJEjaekA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOXZ0ANZa0Jbbp7sFOGXwU4j4cPclvpzpiyUvY7C7ASlgf92mBMl6RHrsrJbEARDuBNCN3kplHYSA2R07FJBR09uSHUQgR5xThywTSdZT9AkKjvjRrY4XAqsMoeLAnHLqg9ZtFwKhf41teu44rYi7IpkGzNDATa8m+9kRSbiVEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hulfyWcN; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754665976; x=1786201976;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M9zWFpLU9ZS+nbPov7s/cFyhvkYnKs8Ej73VJEjaekA=;
  b=hulfyWcNi0NKGCHh+j99FoBW8YJmPJT2WvtELG6crmS+6Pvzn5oeGutE
   xS8x9IPwHCVzqS8kp5SDq66/lBcjjs15zsM91U2RvSd90Lf6v/c0cXXV1
   KEFKIB0j6khr6UExXurrjOaTbOmFtq03dBWRy/WOp6X3NCpZu17tt3+ZR
   f1vtcgWoBU4dI0JJ/P3E8eU72p80hM5b/4s5qEmrxiIn/RnjOukjibGnK
   B9qhznOBFeK/k5e8RVlGDoUehDmeI0Ae+Zv41cCvzdBX0JOqi7j8eEV5e
   UhJEexTaQYvIMbw+xMPFCg10GNX0Ljj355ViGV1Tpto/eSL+ABBX+I76J
   w==;
X-CSE-ConnectionGUID: ueIQgRemSDutWRGYUsGI1Q==
X-CSE-MsgGUID: jEV/FOROR76A8UQ8BKCyfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56917514"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56917514"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 08:12:55 -0700
X-CSE-ConnectionGUID: wb/hgWlzQK+/P0ffxp34nw==
X-CSE-MsgGUID: JNIlnH9kTkG2FFjHSswVyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="202522529"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 08:12:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 08:12:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 08:12:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.85)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 08:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0IWdZcbPXI9L+xseNjwlIBXkZa9A6bRd1ozkqDUbR81L/BJ7svaOFSfzzRLvICmuuqOj1/b65PQvMwls/eBR1uLd3RzhcNyiikQUSAeaa8xQS+WGt8+H4rEjHZLxs7ggDPjgrLcHc2/v/lfg8NvdDBERV8/mTNAO+RQ7u5agAUg9a3HSzsPIVlwN9AYVPhFIjbwFQfU0yAPWMResNUwoQRnwIT6tYY93C9n7DkJVvYt6y6xBASuLC85zbJOORWTqbo1dpruokLjl9NjowcJJF0hbyydQe9G8JWHHslBgWdMpMYt8p4hXb9S+UIV0Gre85qzYz0mEBaY65dNDuS1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL00UqbqOHStTqJ7Cb3w3Eaf7ATumraqMRjcDT550DE=;
 b=kcSwDadzBDUCGZFVunFL57xq9TKZWLOSUYykWsSeogsolermIVVc3XiIT7R1XDXhPGmaXB0AzWBNtXBQh+WzGlmQRqMTuBeJTPIohYEJb0c3O9w9nMR/crpxnLVWLAoVvjL23r0noCXJRr4ZF3o9OrB6q5K2yqglNeIbDu1Ib8qBvpXfRZWZmq/u8FguN5FVKWacN0IyxVDuUNk8y+N0JBoyU8FTlqfPkRC/hUUhBzU2glOKS/H9EWoJ9zQ/F2e+XlGCwcQoC4aHDtWOYBdBSETmqFgL+K0ZVo6qVdtMrSp0IL6sbICfUcHhrerBaVTGf5U/JWo5Is/7aw3F7VRluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7251.namprd11.prod.outlook.com (2603:10b6:610:147::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 15:12:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 15:12:50 +0000
Message-ID: <1a19e3df-2915-46f9-9677-c369aa31adf7@intel.com>
Date: Fri, 8 Aug 2025 08:12:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 25/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
To: "Moger, Babu" <babu.moger@amd.com>, <corbet@lwn.net>,
	<tony.luck@intel.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
 <99614342-b6ce-47ec-baf9-f5cdf42f77be@intel.com>
 <40d722fc-e08c-4543-973a-3fb7ee29bf2a@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <40d722fc-e08c-4543-973a-3fb7ee29bf2a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:303:8f::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2565858d-4a2b-499e-366e-08ddd68e0a53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTVKNzZjcUk1ZlNCb3lYY3hxeFhFTkNJSWgzNzUvV3RQTEhBZWdWb2dmMTlE?=
 =?utf-8?B?akRPUjhpOXJLWC9zOElVYUc0TnZKcExWQUpPWXJlODdROVc3TFlLam1iWFc5?=
 =?utf-8?B?cTNOYnlKQjZjamxMNld2VnlHdndLMjdEeVV5c2dxOXhSbnFVM3l2MGs5TU1O?=
 =?utf-8?B?a3dMUTVFRVRRK3dyRy9SYXhUdnVJUERvL3Q1N0ovbVoxcnlLMFpWVGhHQ00y?=
 =?utf-8?B?bURqR2ZtVmlqUlo2VDF2YTRsVWFISkhnM1pkTk1pM0N0enAwelYrTTVmVHI3?=
 =?utf-8?B?OE1vd2pEd2V0UFJxUi9wS2hCRXFjVmRCd3dnK3dvU29kRUNoa3g0OFkwQzRx?=
 =?utf-8?B?eFEwd2tNMHhvdDhnT0R0cFNGNWVVUzVSeGpvVklLV2ZWbVNyVjl5K3dMTWlI?=
 =?utf-8?B?RnBWb1BJcUYvMWZxK3B3UzFqbTNXYlY1Z3FqRFZVcmdZcVV4VVJZTlZBSWVG?=
 =?utf-8?B?WERsNXJ2WlJ4OHVsc0VFaXRzZzlBOWk4MVpNL091NTM3aEcxS2NKaFlWNXN4?=
 =?utf-8?B?cm9VcVZKQ08yTWVOUGZKZXpBOTlrcDVsMldYd3YzUG9IZC9GZSt4SzM4NGtr?=
 =?utf-8?B?N2ZDNjV6bW1zdks3VVJTTlU3TDNVakp6bFpjMUxDWWF5VWhzeVI0L1dMY0xr?=
 =?utf-8?B?V2oxWnRsS3poTVNIdmpleGdnQ0dEUEZSYTRZY2Zjc1hFZ3dOVlAvcGN3aEY4?=
 =?utf-8?B?aDl1K0ZxbGpjMkl2eGJ4SlBJQk1WL1BzYVdpWFRsNlArdlJJVmQybmxsVmdL?=
 =?utf-8?B?RjkyRXJrNkRZRDIvb2dLYlBOeWxrWk1ocG9TYkdnb1lLSGl2MHR6VDQrSlZG?=
 =?utf-8?B?RkFIbmxwTDFFSFpGMFptWnhZQ0I2ODdKYUNPMDUydk5DTU9lUXhrYjRQVXVy?=
 =?utf-8?B?aGVqbUptMDAxdzF2OUhIMloyYmhuUXNCZHBXRHd3ek1lM1djZnVPL2VNQWdU?=
 =?utf-8?B?a2hjMSs4NSt3dlhEZFFmNzlndHhkaTRmT0habGQ3bXdqeDI2SUZWS2lVeFc0?=
 =?utf-8?B?dS9HWUk3NDdhVnpYL1F6TXE4d1AzWkhPK05WRUViS0FSVTg3RkRPT0RvWHhO?=
 =?utf-8?B?U05VUzhUR1ExdytpTG9KOVhzK1NTQS91MXM1dDg1V2FGNi9KNXJyUVdoeVRP?=
 =?utf-8?B?UnhXc2JyTFB6OUxWMTlxT1ZyRnloNUt5alhBRllNYnp2MXBoWTkyaFhGZ2do?=
 =?utf-8?B?eGlCek5BTzhWcWgvQ01wUWgvNlcrWUE0MXlzb1FYWmx3YWhydVRCOGJOdFdE?=
 =?utf-8?B?eU9hTjd4ajNiOG40OS9SQUg2TmlYTHV1UUU0U3NGK3Uyc01rbzdDSlNuQ0t3?=
 =?utf-8?B?VHd1ODRxTndyQURCWnB6eG03ZWsxYlpvUElLRnUwZmJVYWk0enQ0Vy9TeTZD?=
 =?utf-8?B?QXNsWDFodHRiN2k5aXpjVkpBZGNtOUN4MzJ4SFVHQzJXS2RsQ3lyeUdSK01j?=
 =?utf-8?B?YW9aa2I3MW5ra0VZRVFkSWt6TFRnc09WcUNQQWxNQlJsMXJsQjBLWEV3c2sx?=
 =?utf-8?B?a3k4RGxuekhOVmJOWkJrcldic3hCSWNYOUFhakxJUTFLSTV1S1haVnRxdk81?=
 =?utf-8?B?WURSeVdBRUZKMXpJWW13VHNJZkR4ZDNvM285ay9XTldLbjVXL1RlSVh4SVBq?=
 =?utf-8?B?SE9QVUlFTEo3ZXduREZia0Rmb1FkcUt5SUxLQkJTL0VqVnpsc2l3cXJYMmFE?=
 =?utf-8?B?R081U3pvVk50aXJJTkJIY0ttZlRJLzE0eWp3RXJaUDUzWTd2NGRYR01oY29S?=
 =?utf-8?B?aGRRTG1TMyt4UENodzZPaFRBM0p3Sm8vN3RkU0VtMTVSUUI1WDVKa3ZBc2VV?=
 =?utf-8?B?dDJBTVpibmRZcEMvRC9yY1JQY01UOHQ2c1Vza0ZKNlMyemNFdFQxYkhqb003?=
 =?utf-8?B?QmpyWU1YMEM4K3pJS3I3bytYZVV2Q2pSOG5SSTFXMytQUmtqY21DR200SHVp?=
 =?utf-8?Q?z4juRctPTCg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emgrY1NhUG9LdXdTYWtJNDRoVk50bmhQUUJhM3ZhNkt1OURESkZuOEhET0tv?=
 =?utf-8?B?VWpUcWFWY2VtUkhMVzNBRWk1STVKd09oanI5a0x4UitTa1ZGZW9TdlhMN0Nr?=
 =?utf-8?B?MTE3N2xGY2ZncVd3cFJyR2tYeGFrL21XVHFDam5FKy9YaWdOS09WMzYyZm50?=
 =?utf-8?B?bjRUc256eVJGMjJSMHE4a3FOK0t1Q3NpQ2FYZ0VPMEdnOEllSFd0OVFiZVpN?=
 =?utf-8?B?RUdRbWY1Rm11UUNkY2RPRnNaSlBmem1uR01zbG1nOU1vQVF4OXlscVpJT3lR?=
 =?utf-8?B?cmtpaDBDNm1kOHk2Q1h4MnRyV3A0L0JZRzIxc3MvMU1tTG4xOUhsNXJxVGlm?=
 =?utf-8?B?RnljMWN2cG1TbDBkMjZmNHh6OGJkaHdCL1VYNUVjK0hGVGsvWGR6eUY4Yk9m?=
 =?utf-8?B?ZmYvT3pKeTNPNlZJWW9ySjNmVFRVSDJML1dmZmtQZWlxaDlJQ1lwOEpHUzlj?=
 =?utf-8?B?c05WS2xOanVPWnZNNXdNalpYRmJsWHVhSFNPM0dZNFRXRk8xNHVIakNpellu?=
 =?utf-8?B?dkxtQWJ5NksrNUdxV1gxa0VlOWdOdFFveTJSRTZpZ2t1eEdtakJtWm4xMnVM?=
 =?utf-8?B?RmtJUmdRSnY0WnFWZUlIMHU0eWxlNm5henh0VHpUblpMaXFZR0duOG9XOHM4?=
 =?utf-8?B?UDJKeG9iSWRaQzdwaGFaTXhJcUF5cUR2RUZuSGFpMlB0T3Y2a2wrTk42dkpt?=
 =?utf-8?B?NWpyK1h2TTlMT3FNVXBWeGZzdVFqSkI5Wnh5U2dubDRkM1JRbXR2cFBFdVVx?=
 =?utf-8?B?QjlCVmx3WHJnSUdQRTUzLzFaZDJpSVprZk1IOGwrdElmekdQNmZwdk5sUGR0?=
 =?utf-8?B?WXNJRnVCbnMxbFFsUGcxL2RWdFJ4TmFYeU8xaThVR0FSTUxJbzZMZHB4YUZm?=
 =?utf-8?B?ckhnbnVZZnlnaXR0eHJxK1FjNWM4cjhXeEdoUjR6Sm42M1NYNTJUbldxTERT?=
 =?utf-8?B?T25IRXc3Kzh4OTRuRVNxS0lhZFQ5djVFcE1pVTlOSXdXRTZENlVZRG1zNFJt?=
 =?utf-8?B?bGNOaEc1a0tzTlA1VWF3Vzd2UVgxRDJqNUMvTk5QSUR6dTM5WU9uZXJiK3kv?=
 =?utf-8?B?TXJJVjl0S3NadDZVSTZETFFGalZnTGZWS1BzNTNsMStEZGt1SHRDUkg0R0kv?=
 =?utf-8?B?eU96RU9NN2dFNU9vZ1RiQ3lVZktxdmRkckV1ZlFyWVNBTDl3bUwzcFNWRDda?=
 =?utf-8?B?VjhQdWpxbHZVNEhnTjlPOCt0VnlMV0tSekZyVm5CTlFaU2RtVjNqWlFydSth?=
 =?utf-8?B?ODc4a3BXeUp3dVJFWTJFbXFGdzN6RWFjTFZaNVNQTmpRL1JzbUtrT2tMZWp6?=
 =?utf-8?B?Y0hqVHhmNG4xSVRJR0QyeXo2N05ad0Fhd2M1SGh3endERGxQbk5kTHAwUlY0?=
 =?utf-8?B?Rjh5c1ZzRk1sMkNOMlFYd3psWFJIeHpINE95RDg5TWZ4RlNHcy9USHR5SVFV?=
 =?utf-8?B?RW1XWDYrTUVRRHlhN0t0My81NnlrdUtSUGNpdU0xZmp1RXVtdTlCbHo2MEpa?=
 =?utf-8?B?RWFvQy9vNXZLTzNvZzFoeG1jSExwQWttVVQvaFhsWU02cEV3UVJVRGFQWTBW?=
 =?utf-8?B?NW90dUI4K2FJRXJrL2lCa0NVSWdNcXh4T1o3cGd2NGJ0a09KeUVrVlN5Q202?=
 =?utf-8?B?VkNTKytEcDRsblZCYnByTzFRbktaUGpydGtLYTBWdnhZMUpOK3o1aU5uZ3hq?=
 =?utf-8?B?a3BtTjFxNHM0YmNtYXJOZmh6c3pXNlBwaU9WOVhJaDZiei9MaTYrZ04zS25S?=
 =?utf-8?B?UWF6V3NZZVFISVBndzQ4eGJsQ1dwODFCRUtUOGw0VmVNT1BOWThVMkEvMEdi?=
 =?utf-8?B?eGs1cDFPMlNYNmFxNFlMeGFtTndkOGtLS3hhWVJ2UUE4R2x6WDd5aXhnWXdw?=
 =?utf-8?B?VWN2SGh5dzh5aTJxWmJCbkFLTjVocFZSUktRZGxvdXRRK09NcEFuamdZbllY?=
 =?utf-8?B?Z1JIUFNsVmhPSlQrS1doWnB5SU9hbXYzMkJ6K1FBUDdha3Nxdm5MaDdzYnFK?=
 =?utf-8?B?eG9teGdwc2ducVYwUDJEOGQvU0t6TjBIdVk0QWpYSmdjcVRXVGVJWmsyM1ps?=
 =?utf-8?B?NVhKbGVhNGhBeHJyRVdDbjlGbWZzbllLMVV4MjNFM0oxQzJubTN4dldNNTh0?=
 =?utf-8?B?Mjc2YzZOMzVhVGZDbWFocEtML3cybHprUi83Tm9abWtmK3l3dnN2YWNKSWEw?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2565858d-4a2b-499e-366e-08ddd68e0a53
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:12:50.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIO3+KHLEKTjJp0h/0KysbXeuqecZnrYFfgvKKcMfdwVbZquMoZaY1zTC3fM9678AdLzLT3bmsFxM1tm8iUx08Z+rhOzNy69sa8A0rWXWUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7251
X-OriginatorOrg: intel.com

Hi Babu,

On 8/8/25 6:56 AM, Moger, Babu wrote:
> On 7/30/2025 3:04 PM, Reinette Chatre wrote:
>> On 7/25/25 11:29 AM, Babu Moger wrote:

>>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>>> index 16bcfeeb89e6..fa5f63126682 100644
>>> --- a/fs/resctrl/monitor.c
>>> +++ b/fs/resctrl/monitor.c
>>> @@ -929,6 +929,29 @@ struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
>>>       {"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
>>>   };
>>>   +int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>>> +{
>>> +    struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>> +    bool sep = false;
>>> +    int i;
>>> +
>>> +    mutex_lock(&rdtgroup_mutex);
>>> +
>> There is inconsistency among the files introduced on how
>> "mbm_event mode disabled" case is handled. Some files return failure
>> from their _show()/_write() when "mbm_event mode is disabled", some don't.
>>
>> The "event_filter" file always prints the MBM transactions monitored
>> when assignable counters are supported, whether mbm_event mode is enabled
>> or not. This means that the MBM event's configuration values are printed
>> when "default" mode is enabled.  I have two concerns about this
>> 1) This is potentially very confusing since switching to "default" will
>>     make the BMEC files visible that will enable the user to modify the
>>     event configurations per domain. Having this file print a global event
>>     configuration while there are potentially various different domain-specific
>>     configuration active will be confusing.
> Yes. I agree.

hmmm ... ok, you say that you agree but I cannot tell if you are going to
do anything about it.

On a system with BMEC enabled the mbm_total_bytes_config and mbm_local_bytes_config
files should be the *only* source of MBM event configuration information, no?

It may be ok to have event_filter print configuration when assignable counters are disabled
if BMEC is not supported but that would require that this information will always be
known for a "default" monitoring setup. While this may be true for AMD it is not obvious
to me that this is universally true. Once this file exists in this form resctrl will always
be required to provide data for the event configuration and it is not clear to me that
this can always be guaranteed.

>> 2) Can it be guaranteed that the MBM events will monitor the default
>>     assignable counter memory transactions when in "default" mode? It has
>>     never been possible to query which memory transactions are monitored by
>>     the default X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL features
>>     so this seems to use one feature to deduce capabilities or another?
> 
> So, initialize both total and local event configuration to default values when switched to "default mode"?
> 
> Something like this?
> 
> mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
> 
> mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM | READS_TO_LOCAL_S_MEM | NON_TEMP_WRITE_TO_LOCAL_MEM;
> 
> We are already doing that right (in patch 32)?

Yes, but it creates this strange dependency where the "default" monitoring mode
(that has been supported long before configurable events and assignable counters came
along) requires support of "assignable counter mode".

Consider it from another view, if resctrl wants to make event configuration available
for the "default" mode then the "event_filter" file could always be visible when MBM
local/total is supported to give users insight into what is monitored, whether
assignable counters are supported or not. This is not possible on systems that do
not support ABMC though, right?

Reinette


