Return-Path: <linux-kernel+bounces-869459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CF1C07F04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E49B14EE592
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA22C0275;
	Fri, 24 Oct 2025 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KN2v8nc4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661B2C0276
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334843; cv=fail; b=qDB3//JsvmSDVjDmizB6RdFR1kcsMQHdzoB5CpUM2XaEDunOZirRYS/VUosSXUpNOODQrqpfkslMJC4KPGHhFMWxV1WgaeTM1fsz/xQRFk2QjicgjLatUHIgjjX5OBJgTacD5jSIPvJZCuAylxgZM+dq7rGVJZuOYnRkGSa9R4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334843; c=relaxed/simple;
	bh=PN/1oyENSiawx+hJazikecbWMaFg16p9iz+0bAD8xiY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WGUWOZAH070YXhOpHotC5CoLBLw3V25tHBMu+Rt2U8Cg3++7nX5vt2V8+sv6MoUIZqkiR8xKN/OyhHEZiGmRYGpcANHDgmgviNdjd9DnCFdY6QAvGZrTeecfXUvtBjfcJjNAClX14VrlelMx93/4g0IuEAUhbPwKziIjyjcReK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KN2v8nc4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761334842; x=1792870842;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=PN/1oyENSiawx+hJazikecbWMaFg16p9iz+0bAD8xiY=;
  b=KN2v8nc4VaHaY7SyhX5zlZxP2hjfmttc3yHUCdcoBq32QhMtuBX79FpE
   zejg0RPT2DkLAeLvFQvWb96FOva1J0BTkVZh75yXlBfYlbDwIjjQRZ1a0
   Ib9xCXY0w/rCewQFUZVlKsoyAJBnoGG9GJQ8AT3mEzf1UtGPY5bTZ/4zR
   OPdN+RIe9KZt8ET//f7weP7cx536WHFyN4TuUWbs80W5cG7Thm9CJEyxu
   OnIZ++D1WbztUD2dI17x5si8n3sZqqUkjbsRXP1m1H6VGsq7bp7M5mX3K
   5cpwqOO0OemaqvFyst2e7zPNI3iEffWCW89SxXc6Aw8RWlPfWUw5QHsSS
   w==;
X-CSE-ConnectionGUID: tRjX1hToROSOSqvgOqIHuw==
X-CSE-MsgGUID: +urnyMTLSW+W1It2OI5/7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62729155"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="62729155"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 12:40:41 -0700
X-CSE-ConnectionGUID: 5sGvCPs6SJe1yQTBDQqM9g==
X-CSE-MsgGUID: w3gYfnz1Rzy6zJJcv2D86w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188569355"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 12:40:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 12:40:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 12:40:40 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 12:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW7x9CpvgtMi3NtlTCSVElnl5Vzmy6kVx1yqhncZR98FnertE7x9bN1Cb6VY7furwIdqi0lB3iuLLIIGa2wCxWzKSa05F/LvEMhIe9Hg3Z/DBC/j3pJ4otvWNt7EqelwZfkGZu3StY1fK8PS0Q0IF3kR9O/vZ0NZjClpS+Y5xw0D+Bxit5rTgvqnXS2aBsObnMrZ/pYloVyKBAuILWJANomkkgOTRaCEHXxT7zRy6wkSlytvVKwJ/jxixVAb0p4nztEAry0q1VxGmWAwOoqHinLiNahNAsy73JfX70QrC4DRyztJO/zgKtGIvhcvFsjb6DI/8x8UgKOF8XyuVX1RyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwqBtAf3nBDdp+T5IT5SJVD+owQS44gZnyJu0gN1SUk=;
 b=D+DAEyXaxF14zDBSqrV8C1Ih68O6nz9ycjv+qrgz2gHIDbwAbVT3UmT/HpArMXs64pQlFDks6n1r32k9HqLYW1TFVDCjuOkVE0ixF1+a2xfDV4Pz5kmspnEb0ekyN6lBGerUhfyQZ7HMqVevX75IQykWrp2StuWBTj67e40B2Odh1QVHQRWLXqSWf0RK4Knyh4Z2LtKoEb1tEpDtrHKOefN61AM0Ha3Q1VdFb77dTApX7ITbj12eQDO+I96Do4lhO3ehIF6dIcm8ruB/i4L99CFrWJE7i10BaKX9LVZYT6i9TyVAiRi3Pn5YiXCIXt++vgz89iJspgqb3YF5VKAv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 19:40:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 19:40:37 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 24 Oct 2025 12:40:36 -0700
To: Dave Hansen <dave.hansen@intel.com>, Chao Gao <chao.gao@intel.com>
CC: Vishal Annapurve <vannapurve@google.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Message-ID: <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
In-Reply-To: <ca688bca-df3f-4d82-97e7-20fc26f7d69e@intel.com>
References: <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
 <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com>
 <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
 <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com>
 <aPsuD2fbYwCccgNi@intel.com>
 <ca688bca-df3f-4d82-97e7-20fc26f7d69e@intel.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: 8781310e-50e7-48b9-536a-08de133534ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGgvR29DR1MzN3BSR3RwaXVhTHM4amh5OGxMdTdQSlVja3lNcWZzR25UMFAr?=
 =?utf-8?B?ZlFsU3kwUkIxZGVTdExtSDJUWWRyNzRkL1psNHZYSUdTSjdXZGZvaFRLOTQ1?=
 =?utf-8?B?WkRMRE5aOGREdFNSdkg2dlYxZjJDaXd6enVybDNKejhmd283SldxK2d2VkRk?=
 =?utf-8?B?VTdHNWV5eDFVbW9TeE5vWkRibWdqTE5hYVAxTm4xU1JubE43YjI1cHBzaXpL?=
 =?utf-8?B?U1hYY2R4Qmx5SnBYOXpjbUJ4aTlIV1NWQUx6aEdNL0JFNnZQeVVHN2tZeHhz?=
 =?utf-8?B?STNPVWxleUNqc013T3dDMTRFcHVvTUJBVjNOYXFoZlRoV0N2NDlLR29aOHFv?=
 =?utf-8?B?WEhWdVhOMVUvZkpFK000RjJma2dMQkIyL2xuQnd6b29mSVdCZXJXakY4TEx4?=
 =?utf-8?B?aEh2VVYvSFJJNmFNcUx1Y2NUSnFGQmNxYjNoUUJPWC9QOXFBblkxdHlhbVpN?=
 =?utf-8?B?VGhsaVRRbklVZ2E4M2JOM0Y1dmVLQk5ZcFhFZVJ3TFRQYWJSZHdEUHlNYzZ4?=
 =?utf-8?B?NVE5KzFJL0RiNHppM1YzNlcrZC83UmZrRHZORnNyQ01rSjJIdDdwTHhIZ0Fm?=
 =?utf-8?B?ZG5CekxZRGhZV0VROWhINmpLRW5HTHQ2RnMvcDlxUDJIa3NEMG43cEIyQ1ZP?=
 =?utf-8?B?c0x3Y0JxMk8vQW5nczV2YStjd2ZDM3lMbTJWUWFvcnNPaENjQkc0SGYrc29l?=
 =?utf-8?B?RWR4dTBRdXBkZkVrL2h0UDRhMVJLenJhNzdZK2pjaWxoK2RiT0ovM3N4Q042?=
 =?utf-8?B?SkdMbmoxMUtrMDR3ZU1QeCtualQvVFFnb3pxTUtTUXlvcmVjUi9rQlUzQURG?=
 =?utf-8?B?Vm5VNEhkRlZNZkJlc1dJMEQ1SWlTL0E3RjFkR2JzTVJYYSt2NDdTcGZXU0ZQ?=
 =?utf-8?B?YVhiSGV2VlVsUjlJTmFTbkZEV3NYd1o2cWN5aXBYbnRhT0tMeGM2Um5aVlU4?=
 =?utf-8?B?NGplTGNZQ0VQdWNVWEJOU0c4TGEyZkM3c2tyei9xcUNGdWs5YktveE1ndDhY?=
 =?utf-8?B?RkthTUN3TXk2MTV2ZGwyelFjSzZ4STlUbjEyZkhVUWxidFpqNDErRFc2YzBQ?=
 =?utf-8?B?d1N4MjQyTUtHS2JuOGN2bkV3amxyOTJrZE02YjdUZ1RLVmNhVFVwM2lSMmNJ?=
 =?utf-8?B?dFlDak41TDE2V2VpWkVBamhJSnpIaGw3SU1TcktKMTJIZ3JsUzlKZTNVNUpL?=
 =?utf-8?B?dkkrRzJlUnhKcXZQQ0V2Nk5LbGRLSnV0MVRtRFJsSmtGTnRwRkU0MVEzanFt?=
 =?utf-8?B?SXU2Ymh6blZGN0RHVzBmSDlKa1FvTmdiYWFyejgydDh0WmM0R1h6ejJzdVor?=
 =?utf-8?B?aHkvVzVsZnJyZnFHaFRMd0VlaG5IaERNWHdic01XYjhFbkZBdTJFejk0c3pI?=
 =?utf-8?B?MlJ4cTVWMHJ0b1dRNFZERTRZT3Y3aGlVcXQrYitlZDhRMjZtbjNlQ3pXTTdG?=
 =?utf-8?B?aHZKczBmTlFvV2c3ZXJBUXFMaEdOQVE4aUdBZy9uWjBsTkRUcXdYZkgycklX?=
 =?utf-8?B?Q1FFaTlyT3FQUUlSNDZqOHI2YWszZ2h5YXJPb3BRck5TMnF0bVVHc3B2cFFr?=
 =?utf-8?B?SzhnNjB2VkEwclhkVFV2eFVhZlhQS3NPY1dqcGlhcW1GcDNjcnhqQll6dkx3?=
 =?utf-8?B?bEl4NGdydU9pekdWaXNyMmVUNWNhbE9WL1J3d0hsRVZsandzRHcyUDk5WmYx?=
 =?utf-8?B?V0FNaWtDRmV3V2xleVg3QS9UWGRHcUJ0eHNqdGhRMjVjL3ZCakl3UFlXbmF0?=
 =?utf-8?B?ektDSTBuOGgwVkgvRm5ISi8vclk3aTZOMmhlQnJsQXpBa0tiQmVzOGpSb21B?=
 =?utf-8?B?K0N6N215dnFuK0dnMEQwdDZtU0JCWTl0VFE4U2ZseGhwYWUzVSszV0xmR1A2?=
 =?utf-8?B?OWlkVVllUlZsS0tYcVpILzZwZ1NCUC9OVHppL09xSGcyQVJUdG5Db3l0WFJG?=
 =?utf-8?Q?ybnhxAOZd343QY67vaFfJtCvqq54iDHp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1zM0tMekdUNnBKRzRyVkFEZkdhMDIvR1NDU3MzNmNoa3NpMnY3eFp0ekdP?=
 =?utf-8?B?LzlPWVNtL3BBbXZET1VGL1lMTUlnWm9aRlplaTNCUFFNK2hFVG8vakJoUXJU?=
 =?utf-8?B?YUY2cHJNdWdxcm9nQmJWTnBHT0U5cDF0ZDZCQktvdWlZc21rcHdiRUJJdndI?=
 =?utf-8?B?NEU0cDJvU0grWTJ6dmVVOTlNeXUxajFGVkVUOU9qOHdKUFZLZStBZzVWNXpp?=
 =?utf-8?B?TnRUeUpFSzJEOThzMkNOQXdUQkhBZWlvSi8vSXMraXF4TjlONEhLeUNncUpS?=
 =?utf-8?B?aHVLc0tyTFV1eVN1anprU2JacG5yellrRWRrQjlHeEZ2YVdoRnhJeVBFeWZL?=
 =?utf-8?B?Wkd6a1Z2TnhYUGR5SUdjZlJDcFE5bXJwNUJ5SCtUbzRpekVzVU10LzZ5TkI3?=
 =?utf-8?B?VkY4UDQzcGhuSTQvR1Rqc2orUTJ5T3Z2ZlByZ0J3UE5OdHBkQ08ycGFiUHJZ?=
 =?utf-8?B?aFlsbTEwWjhTb2NtRHRyRU85c3ZNbEJlZUlEcFBpb1BmVVB3ZmhOR1c3R0tn?=
 =?utf-8?B?Q1lsMXFxZEF3RVVnKyt6RHFaT2JNZXlTMS94YXZWYVJ4ajdjQnBFc3h1WUoz?=
 =?utf-8?B?bjhmY2pObWV1ME9tMTY5TUJxdWZEY09id1ZjcUxpQkZBelZtby9CZHp6YjNj?=
 =?utf-8?B?OSsrL3JBemE0SG1xdzVMNlcrVzZURitXcXRKY2RCVndBeTRtdW9nMVZ3amtz?=
 =?utf-8?B?dnpxZ0lWK055RzNnR2I1NklQQk5oa1FvUHNIbzA3eVlRanM4YVlXSGFQRm4r?=
 =?utf-8?B?Nml1UnBJY1pZNEYya3BwQzkvd0gyNjUyMGpFWUpQSk96RklmNFVEQUgrakVE?=
 =?utf-8?B?elorUXdWVnArZE0zbGI5RDY4RGZWbWFHdGJqSEtBajMxTWlrbVpyS2tMUUpH?=
 =?utf-8?B?ZHVjb3VacElvRzJBL25YQ0d6TmJDT1JDRFpoL3BoTTBCempvNW41UEh6dHBG?=
 =?utf-8?B?T2hMVUVFZzJDaGxsd1NyVDI2bTB3bU04Q1dPQXVISElPc01wNmlEeXF6TGZH?=
 =?utf-8?B?bzJLdnlmQ1FBQjFRSHZnMXpJclhucTYwUXhJdFpTejM1dm5ZTmdQWUNxdHlB?=
 =?utf-8?B?L2svVVNTZys0NUE5U2o3c2RXd3lDNEZ3VzhhcE1kS1AvNGNJZTAvWUViSldG?=
 =?utf-8?B?R0F3Mm1RN0UxVUQxWGJsdFc0ZFIvY1ZySWp0ZjcxTW8wZ1U0TXNiazB3T3FD?=
 =?utf-8?B?bUJONDlYOFcyYU5ybWxRRXYyMHFSb21reExRS21hODFKemtOR1dhanRqRjZ0?=
 =?utf-8?B?OTg1R25LZUpaT0RNZEtsUXNwSnEvcVBVTzJXK3Z1N1lOOEtGWDM2cFZDbFo3?=
 =?utf-8?B?elZDaTNoZFFwcmdmcmhncjdjRFRhc2dFRnlsamcrdlNsWXpNZGgvSFdJTTRt?=
 =?utf-8?B?eHlNcHV6SDBnRktvYzNpaW5SZHBsK05wQSswZlkydm5YbDRKbjdWVWczSHJt?=
 =?utf-8?B?K3padTZnYjVzZUdoZDJESU9vamNjSnZCL05aYndHSEFWU3FuWkp4aGw1NFdt?=
 =?utf-8?B?ditFQjExdGJNWDNLb0toMkRhRllxQi9JNi9ESWlMUnhwdjlCVmFYWmRzMXVG?=
 =?utf-8?B?TUhLWTIvbFNYT0M5c3lYRno0c0JLRThXWmlmSlJuMFBucVcvam1QR3NDTVlk?=
 =?utf-8?B?em83MGpDSmxuZENXdDFBL0l0TjRJVGhWRFZYcXlKQ0tqSndaSDNJQ0pSREt5?=
 =?utf-8?B?amdxL2F0cEVaM2ZGU2JxLyswNXFHVnNwajN5MkNFVFR1bnJUWnllcVRLQ3Ja?=
 =?utf-8?B?VHlCbXFESWdiL2hBTmNTNjFoUlpyUTY4dk9BMkwrT1pxWWlOVmVwazZadXdn?=
 =?utf-8?B?b2NLOW9uVEJoTVd4TE4zbFphT0k0TjRZYklpcEhxSEFyT3NnbjFQUzlvVExT?=
 =?utf-8?B?OGphSWtCQ0xRb0ZVL09ISE9TcFpKSC8wRGdtRnRKYUVFN0tKYzZVNnU4K0Ja?=
 =?utf-8?B?QS8rSmhIMnVEQ3FIOVJKSHZTdjlMbnZQZFFKQ01YVUtaVHRlRUFRTW9CZERa?=
 =?utf-8?B?dGZFZUd2OWoyY3lQS1VKdUFFKzI4SUZRRDVlM2J1clZkVTJvY3g0S3RkRDkx?=
 =?utf-8?B?eERTMkIwQUNvNGlPQVkvc0creGdzVWNuTHQrT2VWV0ZjSmdMazNRM2NJVGlY?=
 =?utf-8?B?NlIyZnJic3gybjlTMTEvY0xPaUxwemE2ZDZSbTlrYTRzR0JHVWNyV1YwN3FL?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8781310e-50e7-48b9-536a-08de133534ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 19:40:37.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agY+3KYWuJdXbYp8Irky7cNE+RKLVFlydJqS+o1FtSAmPiTZe5NDBnIcokNBQrjX8hESwDy4k8sjJPZJoJESLts56xdeqJP/J8/wieMAlMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com

Dave Hansen wrote:
> On 10/24/25 00:43, Chao Gao wrote:
> ...
> > Beyond "the kvm_tdx object gets torn down during a build," I see two potential
> > issues:
> > 
> > 1. TD Build and TDX migration aren't purely kernel processes -- they span multiple
> >    KVM ioctls. Holding a read-write lock throughout the entire process would
> >    require exiting to userspace while the lock is held. I think this is
> >    irregular, but I'm not sure if it's acceptable for read-write semaphores.
> 
> Sure, I guess it's irregular. But look at it this way: let's say we
> concocted some scheme to use a TD build refcount and a module update
> flag, had them both wait_event_interruptible() on each other, and then
> did wakeups. That would get the same semantics without an rwsem.

This sounds unworkable to me.

First, you cannot return to userspace while holding a lock. Lockdep will
rightfully scream:

    "WARNING: lock held when returning to user space!"

The complexity of ensuring that a multi-stage ABI transaction completes
from the kernel side is painful. If that process dies in the middle of
its ABI sequence who cleans up these references?

The operational mechanism to make sure that one process flow does not
mess up another process flow is for those process to communicate with
*userspace* file locks, or for those process to check for failures after
the fact and retry. Unless you can make the build side an atomic ABI,
this is a documentation + userspace problem, not a kernel problem.

