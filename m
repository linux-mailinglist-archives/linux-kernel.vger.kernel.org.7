Return-Path: <linux-kernel+bounces-870612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B68CC0B476
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10A7E34941E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD12E0406;
	Sun, 26 Oct 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIZ5oJ3H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E62283130
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761514208; cv=fail; b=EbILyYka5wt80Ty+6h5DdUuhUBXC6KsQ0mnpgfJePO8DgxCHYMmcL1WqieEBMiaAiyhUlYgcT9BWozdNZbrjlqi0HaCT7ay3kiaMNY3SnZO0oEN+6O41WPR7yZ62RlT/ux8W3RHoXVbxcbPSYw5+Iwgyaz9OCxn8pI4I6WslJkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761514208; c=relaxed/simple;
	bh=lNMf9zNpG45wVAK4HjrbCSP6FcYiK36C2g3T9iT3g/E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=X8h6NrtDMxx5KSfEKIXL3WM8CwVSf1W0xENKYUsQgK2Wyj6tunr8mqLvSqoj14zP0T79rLAkRr2lHItN+0UPjBLn/3nLcYU5TLdXQ8LBDpfUweu92nivHtOMA6E1+H2K/Xc5MQORHeIRP1fja3ODbekNowg9I8qaa7dV2lqeFAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIZ5oJ3H; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761514207; x=1793050207;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=lNMf9zNpG45wVAK4HjrbCSP6FcYiK36C2g3T9iT3g/E=;
  b=ZIZ5oJ3H2zDMTLqugKa4Sniwni+gEEp9GKEBEFsMLEF0KQtxRstufmbR
   F60OHdWtde7rvWTTOyTDHuKJXF4CLHo/9o54OwWEdoSVfhPPKDzdMqJtU
   LxqTNT/5RFSi+izoLqgi0auyPXYOf6D7jMdyj9F9tB8mNobUuK6JTqlxy
   ADaJfMrANJTKcnkK/b0didzZSSOu369ASGHXjft4RDXYTG3E9RB+u64KV
   gtevL6FUtsss5wYDOd7/crqBAA5ADfW75SoqE84n2I+R15JYxhqBqvogR
   PAKSiGGgExV9shxKNmw/B9rr1L1DX//vA+4vBka3xgSguwdAcFGSs++ob
   Q==;
X-CSE-ConnectionGUID: oxl7LfcWT4uh8ppGKXh5yA==
X-CSE-MsgGUID: MwSlymYQSaynXoZGcbwxPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74719129"
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="74719129"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 14:30:06 -0700
X-CSE-ConnectionGUID: TwdAz7e/SsyVRrLS5KbdGw==
X-CSE-MsgGUID: 3FbJrM+8T92lU7SMJnuhgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="222087477"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 14:30:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 14:30:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 26 Oct 2025 14:30:05 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 14:30:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g93HirVytoEueXyNFa2k+56lNpUye41klFjHFUwcRGwjBVLOW5QYVP/7sOCzSdBUgOMvhQlMzbW0LOcg4ShZNFqbBFRVNeIAVuNjtyH0kaQuyYY+XkI1gIXuwth4MvFmZHcqBs7/KdFaRlLZ555a7PA3PWc1gSBZhomAXW7f1oJmkxCwmVbOXUZtb0rTrUiTR1UUUEhJQCI+QuRqiZjHyJZCGu3jDnGTqTMUF3/vr28aVsQVZcbhRSEWGlsqHhVwY9UxW+1u5kadpcEHuNsujhVzLrwMLW5kdUjATTbLXhswqB3PA4iWqtB3KJJE/2lRNpxzYtAbolvTeIhje0tuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8sS2ETxVyfx5Rx2stmcdKwIGMqXE5BhgCtsDBJRIlo=;
 b=AKxZGJE0WynN9KEN5LI70vCcuSMGMDzf79ri89U2KVvz8kOCAHaOqfE+CeyiB9NBfU4ETZvp/CO2nUs1sHIUanfBz873YuNWgHdzzHSgyDw/4h+XXOgDvE/Daidc5WC91ziHJ0Vr5dIvjMnKK49ug5139YRh0kZrIHjhE4Ph+nMhtXF3KPBfyWcXNdQ/0Ad0Wa0rwxadbTUACOgyC55J9R4Mw9E8sbEmA0xYpNqmIVfClgTtgsQZ0pnrGVdFsqTtrRmgBHr89gjv+s252zFSGR+qkeIMRkEBJspPPMb/Ot+S3AfSrsLTDnPvQVtZgiq4JixIzgdEhUBlKs52C1xZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Sun, 26 Oct
 2025 21:30:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.017; Sun, 26 Oct 2025
 21:30:02 +0000
From: <dan.j.williams@intel.com>
Date: Sun, 26 Oct 2025 14:30:00 -0700
To: Vishal Annapurve <vannapurve@google.com>, <dan.j.williams@intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, Chao Gao <chao.gao@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Message-ID: <68fe92d8eef5f_10e210057@dwillia2-mobl4.notmuch>
In-Reply-To: <CAGtprH8-UGFkh4NmuY1ETPYmg7Uk+bm24Er2PPxf8tUOSR_byQ@mail.gmail.com>
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
 <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
 <2e49e80f-fab0-4248-8dae-76543e3c6ae3@intel.com>
 <68fbebc54e776_10e9100fd@dwillia2-mobl4.notmuch>
 <10786082-94e0-454e-a581-7778b3a22e26@intel.com>
 <CAGtprH8AbW4P2t-wHVcTdfLwf3SJK5mxP1CbsMHTgMYEpLiWjQ@mail.gmail.com>
 <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch>
 <CAGtprH8-UGFkh4NmuY1ETPYmg7Uk+bm24Er2PPxf8tUOSR_byQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e921a7a-4a6c-423d-8f69-08de14d6d2ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkZWaTcydXRyalhlRDhpdVlHZjlHVnZDYWRtSWl0RnlzTEpSaktodUtHQXVH?=
 =?utf-8?B?c0ttbldBZmtLbFErWDRBdFR0elp6WnJyeXNWbDZDVkszY3VHVkhvOVJnb2JV?=
 =?utf-8?B?MlBYMG1UdjZuWENMdlRWOFpXbGhTWDdpRDRseEovWFVlaHJIdUNKTWQ4aGUz?=
 =?utf-8?B?eWQxbHduWFNkaFNHK1J4aW1SVDAwU1dhbUNMVXBkOEdnSFZ3WE9lVjc2UjZF?=
 =?utf-8?B?SnoxQUZaeFFwQlNmek5VQlNLamFEeDByL2owd0NRSGY1VGVIVk15RkJOWC8y?=
 =?utf-8?B?V3FDOWNKS1dYUnBBY3B1b0FabjQxYUhlYW9rdUR4THZTTkh1SC9OY1cvQ3M3?=
 =?utf-8?B?VnlVdmlLSjVlREhhSTZhNzZ6NnRac3U1TVZ5VlNkc3JqaEZyeU5uTzNMbm5s?=
 =?utf-8?B?WmQzVC84bnZsTWtOQVhDSVVSTGltZVVJc2EwbzNxZFdvT1JEQkRHVVkra1Zj?=
 =?utf-8?B?Ujl1UC9GcjBxTmxoRFJrUHlPRVRJeUMvZTdyTW5iYTlCWElsckpKMnY4RHh4?=
 =?utf-8?B?RHBISUxxZzJkaTlXV3FNb1F0cDRLbUN3TTJza045R3NzQjN4QksxVlJjN0RD?=
 =?utf-8?B?MVhtRVo5N0lmcE1ZNXpjcFFocFVRcGR0SmRwTS9ZTEhPSkJzQ0JJNG9nR0wz?=
 =?utf-8?B?Mmx4OTlER2FSVDVqSFN0MTAxaElucm9FN1dVSWdRaURGZW5UdkVtZ2JMVnJN?=
 =?utf-8?B?Q3ErdC9HQThJeVlFRGZhOXdJK0cydFVHaUlmbm53c0dZVTg5bDFmMExQYWRV?=
 =?utf-8?B?Z2lkSHVOdFNTY1dqanhzVmNGWlhYNWt2T0YvUjJlZm9SenFhTXVSbVg3cVlk?=
 =?utf-8?B?M1NVYWV0cmhXU2d0QTFWQXkxOFJidUlrd3RQTEtuV1VkY29VTVlwN3RTM29h?=
 =?utf-8?B?UUQwc284YzR3S1Z6UEZkdXBCZWd2bHFtRG1qNTU0aG1wZFVnVVg1cWFiaGtr?=
 =?utf-8?B?NG1aeXYwMFhrcGt1YjY3WDh5RDF5ZTcxeVhHbzd0ckt3d0g4bzhTOXJudGt3?=
 =?utf-8?B?cnRPTkRNMzBsSVRPSm93RkhTLzlLVEw2UXpoQys0SGxrN2pJNGF6K3JsOHVK?=
 =?utf-8?B?ZURiTnVoV01lOFYrUTJmUzVqYW4yQ2lLQXlWRXMxQWlYeEllcUwza0Q5b0s1?=
 =?utf-8?B?TWxDVUlVU3F0SGgzd2JScHJlb1FNVnJ2dXBuZ0hyWnE1MnNPbGRYaHQxSUFi?=
 =?utf-8?B?a2pMTUR3MWl4aHJ6SGM1a3hNelQxTkNXZG9WVXpVVWR5VTVDY3FtbHVjV0lz?=
 =?utf-8?B?ODlOc2hRY21PdFBnNmJOc2dRTmpmQ0I0bkt6Mk5hcTNnbHBWY1cwZVZFUWtl?=
 =?utf-8?B?allBMnFEQm9OVDRTUmZ5cHArbCt0bnRmblFrM2w5QUxCOE90QmpMU245Z3BH?=
 =?utf-8?B?Q254czhOSDRyUVZxTzhQWDZDWWJoS3lCOXd5aGkvbzFzOGlHdytxL3RBV2ds?=
 =?utf-8?B?QWVzelhITUpyRTFuWWhVM296Q016eVlvYkowODh3N3ZtYUhyWUhSdEJVSDFl?=
 =?utf-8?B?NkpkeWdhN1lmeCtkMFdvMzJuajdpUHlrejdMbGN6UVlqLzF0cmlTK3h2YWpB?=
 =?utf-8?B?eFRWN2FMc1UxM09xall1d0p1R3lnelRFNWhlSnhKYVpwSy9PeHNKTFZVRUEr?=
 =?utf-8?B?ZnhOYWpMbE5VL1VNUFBsMUZCd1ZPakJOTkwxcVhjK1I0b1REZ0s4QUZSV2M4?=
 =?utf-8?B?emJpNEttUTlZRVpWdVI3eEZuTUdiQzJZTDB5OGxqRTI2b3pvRmY4eUY0WGM1?=
 =?utf-8?B?Y2pUUWlWeGY1Y05xd0xzcGRlOGs0L0lnUVFBUU5ObXJlKytUUXg5K01mVyta?=
 =?utf-8?B?RmY3eXZWWk11SVJwcGEwN2lWVlVuTjdKWi9XOXhydUtZVE9XeWZUbzhoRzVQ?=
 =?utf-8?B?bTJlWWFXblJYM21tdjFrSzF3ekZIcUIzUXNEYWtRUG1YV3FUMEZJUzJPMUNQ?=
 =?utf-8?Q?CS6GAq9StnfxrOCUEmYoRX/K7efKN0aF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlF2ZWhPZ2Y0REJVeFpJa3RKalcwcFZXYnVrUjRtemFYcm9MeC9Cajd4TmtM?=
 =?utf-8?B?TEhybXFGeFBwa2ZJbmtENE9BeVZPaXdzSHBRR2JrM09iWHV0S3FITkE3SnFz?=
 =?utf-8?B?SEQ0cGlFdUVMaGd4U0prTnViQzJQclZjUWc1d3g2c2hIc3crRTB1OTFQRXBT?=
 =?utf-8?B?N2xSM3Bza3JwZVhDeHZRbnRIY3A2NU8xNjNDRVBEdWZFY3FISkNPbHp2NDRS?=
 =?utf-8?B?elAxb1lkVlVERjF5MVdEa1JCc2owazM2Z2drczZQRHBJdDJVZ3N0b2szMWto?=
 =?utf-8?B?ZjhwRHZpeks2NGNyNE9vc1VBNnp5WFhOTEVNUHpIMWhGM0U2ZFZ6eVQ4anRL?=
 =?utf-8?B?STZFM0toV1drdklrWDBCTkVZa1hucUI0L2JXUDRPMUFGbTdodFZjb0xuT0pW?=
 =?utf-8?B?U0JnNER0SDVtR2hONzhWKzZKRFlFV3k4ZnFaSFNwb29ncDZianB5cG5MWXE2?=
 =?utf-8?B?T0NnN0xRc1FCeWV2RERNUzB3MkcreTB6TEtmaEZRaGdyZGIyTUkwVlFtcmM1?=
 =?utf-8?B?d0pLU09lekpkRDVMTFpkNzdHelpBREtLZW9GQ00xamYxZzZhMEMyOGdYeWpa?=
 =?utf-8?B?OS8rMXBTeUlwcC9DZ1NlN0RNMENkMHlLWTc1T3lGUU1nd0dPK0loYXQrcEls?=
 =?utf-8?B?R0kzUjBCNzRrWnNVdWhIM1dGSkV1VHVFeVBxOHZGQlNralAxNFFWQzVkRy9l?=
 =?utf-8?B?a1hNZlpNL2VWWFB3N0ZpZzM2eDJmbGNzMmhJM2RBVFIyY0tCS1Q3a2p5RlRT?=
 =?utf-8?B?VGE2NTlvRE8zVWI4M1E4cWdlZTJVZkg2ck90WlJVMzlrZFAzZHpBV25BS0J5?=
 =?utf-8?B?ZmZXZXVDcC80aiszWldRL29LSXYweThmNTlMckRybEs3aW9RVWIxNkVZUFhK?=
 =?utf-8?B?M0ZVV09oblNwcmF6bUhTaTVRdzF0ZWRwVDhzVDlQTW5NMUxCSURiUUJQOUtI?=
 =?utf-8?B?SE1pVXJUMFdRUmh5RlU4UEFnbEFlNGJBa3ZCMzB0Rk0vQW9CUG5HVjcyTVZC?=
 =?utf-8?B?VEVhdWxLUjJiVzBCSytQcXh1YmJjcFFHNVVRdHY4eXFDSU5lZVVhNVJPRVJM?=
 =?utf-8?B?Ky9XVGFWTU9RZmNWQ1JyM3hjVWFPTXFVamxxbGxuVC9lNzBEcEtDQmpLZ3FF?=
 =?utf-8?B?Tkx3dGFFTWlPeGFVd3phNWhiTC9RRHRiYkNPd1Zrc1ZWeTAyOWZjczYwWjdK?=
 =?utf-8?B?cDFwMVhUMEpISlpwRG9tV1BEU3ROWW5TR05VVTlvSGdjVDdkcElyTlMxQnhz?=
 =?utf-8?B?T01YQXNWdGZsS05EUStzVHFSL1FvOTI4cFZsT3MrdytLVHcvTE45LzRwYUF6?=
 =?utf-8?B?K0FhY1YxdXJYbWgvUUgrTFFvYUl6a0hQT2xCaitORTc3bWM2enJSa21HN2R3?=
 =?utf-8?B?NEZzSjZ0dDE3UUl3SWZ0ZFE4T0xWalVkekY3bTJSMnFpT2RuOFhwWm9VelFj?=
 =?utf-8?B?LzQvVDB5eXFkOEZOeHZzUmRDTEhIcHdBTXl4cStpbnhOVm9EbExPU3p1TVQ4?=
 =?utf-8?B?TEVRT3dCcjJjMzdFSlNLbUNUZkdINUJhSDA0Nzc1bm94clB4VTdUb0lwTUhK?=
 =?utf-8?B?TzRLWkcvUHROL1FISExONTl2bnpaRDh4OFNsNUduaHViSWJlaXNmSVVLTmcz?=
 =?utf-8?B?S0J4ZHRrKzlQWkR2YnVlUG5qUmh6a1Z0K3F6bkdUVVFzSkJYdVo1MmkwWTJn?=
 =?utf-8?B?ZmoxdlFqV3ZWdjM5UGNCcVVtUUdmS1N1azFrdlV5amVJaUFBaGMvTXlKUC9Q?=
 =?utf-8?B?VmhxQTgzcm03aUM5L2t0QmJMOEVaZFZOemRZQnJpOFI0SERIc1A5bkl0c0NN?=
 =?utf-8?B?KzdiU0xLcm9DNGlGMEpFdFJydjJmbk8wY3N3ZmFycE0wbXN5R0g0WnpVR092?=
 =?utf-8?B?cnk0R2JIRW4vUmVEOTFHZ3BRTFprZGFTN0hKU2Q1U2M1YjdqRnJ1ZGJRTUc0?=
 =?utf-8?B?VnhCK3lTUUl4cE5aeitGRmtWdnhCenBCa2NHVUZJUndJekx1aW5BdWVXaWRt?=
 =?utf-8?B?NHY3dDZaZDJYaEkrbkZSby92aWNjaHZDNjZHN1lvTVN5clNSQ1RkeGNmT1Q4?=
 =?utf-8?B?MklKaFlSMG5BK3pXVEJ3MEE5c0tBR3FabndReDJueFg5clZGSUZ6MEhFSDQ5?=
 =?utf-8?B?bUVxTVYzWUMyMkRBSGl6NXBobVVZS1pkN1pLb2svNW1wMUdITUVLTFBsUlA1?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e921a7a-4a6c-423d-8f69-08de14d6d2ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 21:30:02.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkANK30PePs+ePQsR+0GIBhp2yxVlxcacfGnTaf+MxTFId2nSkfehSTVyPiOMDykwKPdgwyooJoEELqD0W4Vaa7DCKnT30bqfyJbSWDDVsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com

Vishal Annapurve wrote:
> On Fri, Oct 24, 2025 at 6:42=E2=80=AFPM <dan.j.williams@intel.com> wrote:
> >
> > Vishal Annapurve wrote:
> > > On Fri, Oct 24, 2025 at 2:19=E2=80=AFPM Dave Hansen <dave.hansen@inte=
l.com> wrote:
> > > >
> > > > On 10/24/25 14:12, dan.j.williams@intel.com wrote:
> > > > >> The SGX solution, btw, was to at least ensure forward progress (=
CPUSVN
> > > > >> update) when the last enclave goes away. So new enclaves aren't
> > > > >> *prevented* from starting but the window when the first one star=
ts
> > > > >> (enclave count going from 0->1) is leveraged to do the update.
> > > > > The status quo does ensure forward progress. The TD does get buil=
t and
> > > > > the update does complete, just the small matter of TD attestation
> > > > > failures, right?
> > >
> > > I would think that it's not a "small" problem if confidential
> > > workloads on the hosts are not able to pass attestation.
> >
> > "Small" as in "not the kernel's problem". Userspace asked for the
> > update, update is documented to clobber build sometimes, userspace ran
> > an update anyway. Userspace asked for the clobber.
> >
> > It would be lovely if this clobbering does not happen at all and the
> > update mechanism did not come with this misfeature. Otherwise, the kern=
el
> > has no interface to solve that problem. The best it can do is document
> > that this new update facility has this side effect.
>=20
> In this case, host kernel has a way to ensure that userspace can't
> trigger such clobbering at all.=20

Unless the clobber condition can be made atomic with respect to update
so that both succeed, the kernel needs to punt the syncrhonization
problem to userspace.

A theoretical TDX Module change could ensure that atomicity. A
theoretical change to the kernel's build ABI could effect that as well,
or notify the collision. I.e. a flag at the finalization stage that an
update happened during the build sequence needs a restart. This is the
role of "generation" in the tsm_report ABI. As far as I understand
userspace just skips that ABI and arranges for userspace synchronized
access to tsm_report.

At the point where the solution is "change existing build flows" might
as well just have userspace wrap the flows with userspace exclusion.

> That IIUC is "Avoid updates during update sensitive times". Best
> kernel can do is prevent userspace from screwing up the state of TDs.

"Avoid updates during update sensitive times" is the documentation for
the update userspace ABI.

> > Userspace always has the choice to not update, coordinate update with
> > build, or do nothing and let tenants try to launch again.  Userspace
> > could even retry the build and hide the tenant failure if it knew about
> > the clobber,
>=20
> IIUC host userspace has no way to know if the TD state got clobbered.

Correct, today it can only assume that both flows need to be mutually
exclusive.

> > but be clear that the problem is the clobber not the kernel
> > doing what userspace asked.
> >
> > The clobber, as I understand, is also limited to cases where the update
> > includes crypto library changes. I am not sure how often that happens i=
n
> > practice. Suffice to say, the fact that the clobber is conditioned on
> > the contents of the update also puts it further away from being a kerne=
l
>=20
> The knowledge of things getting clobbered are well much further away
> from userspace.

The possibility is documented as part of the update ABI. Another
documentation possibility is that updates that change the crypto library
are by definition not "runtime update" capable. A possible TDX Module
change to remove this collision. A menu of options before complicating
the kernel.=

