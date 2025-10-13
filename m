Return-Path: <linux-kernel+bounces-851390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D2BD6571
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D23AD35A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1872E8B6C;
	Mon, 13 Oct 2025 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwUjPf0n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEC20D4FC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390195; cv=fail; b=Dsx6kNgwMK0ZQOjvPwzeuWJw4WMxHspVbW5z6/mDhUsMYEdZdygXa6RV++lT46OSa1zfC/UxOH6pgoDFUKt8qM4B45pBTKh67YRyAW9StdY+6nZBa/sxFNvyui+lm1HnGjXVU0JWd4cOrkSekZCoFiMFOrKD6tEiF5bB43W9iTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390195; c=relaxed/simple;
	bh=hHA88mpWDsjyNMe95pmBEwyZcFvkXVq72Hfs93mtXmA=;
	h=Content-Type:Message-ID:Date:Subject:To:CC:References:From:
	 In-Reply-To:MIME-Version; b=YvFJV9GxF9/pDMiF2jcRVtBFQkguyb0q5Kb7YIQ2SfSge5ktkTvfK8/AZBG+iepFZ/WZSb7KhqEknrIZ8BKX8OWqKxG3OOPUwyaI56HYm9d0QpA3e0Ts5Bgeo4F8FXcyZ+TSCRtef+Bl3anNhLpIODi13YnoPWgCNrpRtrotKTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwUjPf0n; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760390194; x=1791926194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=hHA88mpWDsjyNMe95pmBEwyZcFvkXVq72Hfs93mtXmA=;
  b=YwUjPf0n3gcNCjLE9gs7+h4+VbeXTgGxjykenvajIZyhLni1l2dQfGog
   CjgxS+a/Z/wfdPWXuf5JSs7J5s3HG4vICqAbKRV8NQngPYlHNGR9SQS2F
   BDKENYmH/wpXSSYnzZaXdvpc8B+OBihzlE8O+XNBztxlhcU+zy/k7UFfu
   3okpGbBY54u53ybX41+ZHNiM97/yTV3XYBUYn6t0/vzZ26QpMB1Sn7QuJ
   +0dSvMY9Ei+38rdMxWz1n5iAP0VWlTJ3zhmbnVnG/tzAkrjLu6tagPCDI
   pnuPocrMzz68oCNY1BWdmed1DwoaWNcKdpfE8HajmK5fjgIbN78OUDcZ8
   w==;
X-CSE-ConnectionGUID: Q3dUNdxjQTeM8klVOK/gJA==
X-CSE-MsgGUID: jsbsadG5SiaqG/FTsImJaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66195370"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208,223";a="66195370"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 14:16:33 -0700
X-CSE-ConnectionGUID: Wj5UTSvmRuS27nLSwlfmxg==
X-CSE-MsgGUID: xC1bAMvGTXGP7MXIKlsTmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208,223";a="186803547"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 14:16:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 14:16:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 14:16:32 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 14:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDgh8t6Xe6Hd98WwNU/pnnB2G91knTdOOSY+Kq7fIR3IvcLjYl7mWv+73NiUf2hYtAxVBTJf7fb3ocWUwPK8Jjpfd9OX0pMEMydQk3QGB+Mgdnc+MTw5emoP4i5KkpQU2MaRZ0MAxWZssuvU3jUI/q3Q2Mrk/2bX30zHaAoRBLOH9KSrBiZ1gDHu61WFBUu9jMCAyM9xYU9B9DYRQVFvLFHqqVf5wgG9S86CW1DDwzFE6G88XT94posDJBsrua7sKlbq6FEFkQ30vbzuRzMZqiAztw/io2lKJpUarUiTb6u5Cf7Jbx7yYxwnWXuQU7w99Q/brTufjGw2ggBN6/Pq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDciSGrZedLWRAG+UTEkTnkqMjPtGj9JRBDB7kJWkX8=;
 b=CSza8lMeOlb9ygyqm2KiY+A/d+rwopBE/UgXLoJ/72xgg5D4P7pVXmYDS0EIzPcRYWOJCQLl9oFH68YLD8MKXl2tZXPNpuCrQw0cd5IHksTQ6ZS0yALdFOeidO4ZfkjeCpO+ZSuk4pfpKCMBceu0Sj5o1TpUmfzk87wzopC5ynEHV/gXyaJYVlkHKi98J1zu7A52DL+FoZ9hf6nwxMkGZ8jQ97vzmFfrSVlAh6PYTukbEHP5AUlDg/g5kdasui0ospwL+duZArYMVWx77Tp8QYsOx/qOubIexPvKjXL7AJYKrGA8sF2B7Lsv0AlRXS2f2AztblhRtdfVBxYNipTLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 21:16:29 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 21:16:28 +0000
Content-Type: multipart/mixed;
	boundary="------------MP9tUhiMiB0RdswQAZs3z3Z0"
Message-ID: <faead017-128f-4d63-9552-82b536ea7612@intel.com>
Date: Mon, 13 Oct 2025 14:16:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] x86/microcode/intel: Establish staging control
 logic
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <chao.gao@intel.com>,
	<abusse@amazon.de>, <tony.luck@intel.com>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
 <20250921224841.3545-4-chang.seok.bae@intel.com>
 <20251013134250.GAaO0B2rb_smA83z32@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20251013134250.GAaO0B2rb_smA83z32@fat_crate.local>
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9e16a4-09df-42a0-debf-08de0a9dc642
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXRLNUV4dStBZE1DOWlUYXgwK3JSaDhqdHFTQTUyU2dUemVzL1dzbGJPMkRK?=
 =?utf-8?B?VG9Va3dFK0Vhci9Xa3Rua1NNb2dQanJLSys4SlBNZTRyMGxJUGJ0c2RieTRQ?=
 =?utf-8?B?NGxnKzVCUVZFRUxrMjlvTDcwSmUyeVJ4K2p0cW5RLzVabFVpeTBnVW5DL3M0?=
 =?utf-8?B?cWl6NnZwd2t6RU5BaUNqaGdQbHA3c0N5dSs0MFl2Nys1OHdxWDBETnB1SmVT?=
 =?utf-8?B?YllsZ1ovSFUyaDRTY1RZSUlDZ0pOS2c5aktqL2ZIQ2dnNllvc1pBNGQyY2xv?=
 =?utf-8?B?WGl6ZGFuTFlyTTlKbmNCTDBvR2FZT04waC9WSDkxVUY5elpJWGE0NGNIbGsr?=
 =?utf-8?B?My92ak1hektQeFhjNDIrL3FYTnZZZy9SRU81aUdYaFVzUEFQOGxMZnVEY2lk?=
 =?utf-8?B?TFJ0NWVzSTlEK3BtdWlwUEpqVHkvUEM2Vjk2WG1BMnpORytOWHR1RTQ0SCsv?=
 =?utf-8?B?SnUwdVdGclBqUXg5cFhHYXZXN241RTA2VDZmOTVuakRPa0lKRktPSHoyTVRx?=
 =?utf-8?B?SWV5Y2FIUDlmcDY2L1IyWnpaYUJSVjdIZVNOcUJJVXVIMU1KcFI0RmJBL2NX?=
 =?utf-8?B?Q09ZT2s1Rit2bGl3Z3laa0tlaE5HRFJXb1BBTEk2VGdRQ3NNTEtNZEhpTE9p?=
 =?utf-8?B?K1R4U3ViMDl6KytoMW9GQzQzWng5b1NsanFONitKOFUvUG5uaU0yU0tCeUJz?=
 =?utf-8?B?NHZYNkxJU2VPVXphWFpPRFp3NFlYbTNEdWhBUW1FV0hDQmc1VGxiOUloRXNG?=
 =?utf-8?B?ZDJlSGRrWmRodDdLSzNpZGdYWkc1WGNYaW5aQnlIU3pNOWpuaFFEQXhsVFlX?=
 =?utf-8?B?aUlwUlJESWYzSVprV0VhdGRtYk1ndGcxenQ1cUVxMnJkVTA0RStyS2E1NWxs?=
 =?utf-8?B?Qkd4QlpreU1VYmJFZFZRS0hDUUlNMVVLcXpuU2NlL2c2Z2JIUWtKN2oveTlz?=
 =?utf-8?B?aGdLOUJ0VVJiYTdXUjdzWUE1VWVSWkIxaVlkZlA2SVFKaHdyYWFOcnBCcStO?=
 =?utf-8?B?OG5ZUFBzdFR2TCtvcGNyb3FZcDVKZ25KaXUwVHBFcFVZc21WZG1oQUVFZXg3?=
 =?utf-8?B?MFNmUEd4K1AwMjg2NUhaRVdYMWZwY3U4Qk5jOEE1N0UrVDExb01xckN0Y2tq?=
 =?utf-8?B?NVRkWkM0dG5mYktBaE1IaVdUN0tTbGxoWlRXWGo0SktDRUhtcFNlUFQyZHpr?=
 =?utf-8?B?VGxRcXFaU0lMamd5cHFCdmpmSGFQcGdaZ1FHWk03R01HK0l0aWhiczE0VHQz?=
 =?utf-8?B?cHhqRGpxNWYzMjhzaWprYnJ1QmhpZ2tXSVdRbmlZemtZUnQ0Zk5SQkZJdFJP?=
 =?utf-8?B?Z1QvQjZiekxNakkwb08yNkt4QTc3dHhnT2hubjVaSDFrUzdVV05zcjVnVkZU?=
 =?utf-8?B?d0ZSOVpQaVlEWllzb045NDJLV0E3QzdYN3JyQlRna3lYU011OHJDdHpvUXd3?=
 =?utf-8?B?a3JEbklNZ2lIc0JQcERhb2xOamlTTmlCYkZkT0h0QkI1dFRNSS82b2UyaXNs?=
 =?utf-8?B?L1B2VG82c245VlprMDBZd2NjWGNQQjRPM0lxZE1oRndqNTRNS3kxczVGeXRp?=
 =?utf-8?B?d2pwbXFCdXZpMURsSEU1NzJlN3Z0TXJMWElUR0ErNEo3VXppUDloWTFUUTZX?=
 =?utf-8?B?MGc2Y3A1dXM5YllOTSt2dGQ3ZTY5b1hIRm5nR0ZFTjNVOExaWXEvc0Vjbk16?=
 =?utf-8?B?NSt5ZjFzS01iZHpPWTN6MHdlZDZZRmpPRXdLYlUra3ZaSTVXb2xOamZza0ZH?=
 =?utf-8?B?ZXFkRko3TVVOb1ZJc2c4Y3Jla0RFazBqMmFNL0lkQURaOGNCNkJTbDFlZFVU?=
 =?utf-8?B?TzRDRGlPQUhyckZyRkVia2ZjMUpIaFNrV0t3djAraWExSXJhcEhua3dwZEtU?=
 =?utf-8?B?NmRPbGNrU3NWM2VIUGtIWFlpSit5Z0E3NG03Njc0RWh4YTZFZ3JVa2Q4RHV5?=
 =?utf-8?Q?8Jzfkw3JloVJvS9mRXlKlMvUMmhFLES6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxKZTc3d2xGdjNKQk95anIrdU1INndYVy9tai9ObEY1akcvVTBDY2M0WXU0?=
 =?utf-8?B?eExnWWJ5YTcrcnJMaUFleGRUd1lIeGVJNUNhUnBsS3RXc1p3Zk9qcGFzbFhW?=
 =?utf-8?B?NTQxSXVHdDdBdDdacUtielZXTmpkSjJIQnNoMjRLNkRtell6Y1F3ckNkbXJa?=
 =?utf-8?B?bjdZTVNGMDZ6S0NvRk9USlUyZ2hWRGt5N2puTm1nN3I1aGE5Ni9nemtPclYv?=
 =?utf-8?B?SUFNNWFEUHh0SEMvQkhIN1JaUlN0dmpiL2hHaEZiZTJkVktja0tPWFJXeWhw?=
 =?utf-8?B?dnVDYndJQWptSS80dTdCaGpaaUpvTXhNWExhQnlTNURBVURFcFBnb2pqRy9E?=
 =?utf-8?B?eGl5c1FUWnpzMGtrbVJJcHZFLzZ5TjhBVS9EZ3FVZlpQcVVpRVp3dlpaOGtz?=
 =?utf-8?B?WEh4bldrU2FXaE9saURvMUlhcFpZYlBJUThOUTNYWkpwVzZxNlBTT0xnNFBD?=
 =?utf-8?B?WHhHSkNzVzluZHRpUWdDMnhiVUVMNENXVzZCV01IQjZvZ0I3dnRydmVYMVNm?=
 =?utf-8?B?VkJnUTNZeGJEdlJWRTRSOGxzWjc5eERZcUcrSTA5WGxSYTNSOEhOdGx3emts?=
 =?utf-8?B?MUhTTTQyKytBRTdVZHFyaXVQR05sSDdGcnptcmJDMWQvWFVkbFJzTkZvb0lx?=
 =?utf-8?B?UlowVFBNSnV5S21rYTdPV25iWnB3NGY0QTBCTksvUVlMK2F3c1pRWUlwSHor?=
 =?utf-8?B?a0lOSjdpY0d2ODU3aUpZdkE1akw1RXJlS0EvQUh0bzZCbWtMd1EzVnhGRzI3?=
 =?utf-8?B?RnRieklERHVkTERzS0k3WlVmMVowSXEwRXhyUHQyK3VsT01ST0kremNEbFdu?=
 =?utf-8?B?czVOQmRMZnFiV0x1dEwxZzhFVzFZcENMUGhHaW9sZy9aL0lLOHJWZ3dWQ3Bn?=
 =?utf-8?B?eTU1WC9ManpLUVpxVUhoY2hiWi9uUWF6aWpJQmkwUU8yOGRIYVFVaU5NRVd4?=
 =?utf-8?B?anB1QTJKRnJKYlVTNS9DVU1CWHl3UXR1Rkorc2cvT29kbGNiellEeGkySzRs?=
 =?utf-8?B?SkovUDRjd3FHbGVHTXV5YURheDFWRFlROGVwc0VUUzNyU2x5amxUNzJVUnU4?=
 =?utf-8?B?NUMzbjJpSjNRYVcxV09qQlo3RzF6TGJ1aGkrWE80VFJXdm80b0dOVU81aWF4?=
 =?utf-8?B?Z0Z6M2VSbC9wSWlwUHJDZVNITHEwdGF0cWRubmt5S0FTS0NCVXg4WC81Zlow?=
 =?utf-8?B?OTI2RlBFY25BemNQVXZQUUlLRmdEZ3laMksxVXFmb0RrdzRMVGIwMVhiVXpO?=
 =?utf-8?B?eXJDY3FpaXpGa3hlSlRZdEdHMjZ0cjhqb2ZsLzZCbWpzbXRlSTVOcDRjUnJp?=
 =?utf-8?B?ejB0U2hkYS93cHJ2QzF3VHVMWVFXVFkrV0daVDdSeTFYQSs0bHp3WG5hY2dB?=
 =?utf-8?B?WWwxQytZV1V5ZUJ4UExRYXJ5V2dWREpmSVJIMkdZc0s3M0xkSXM0WmNtd1hj?=
 =?utf-8?B?eU5mZWFueGpVYzN2Z3dhU3VHaVZzRElvOENSck1Oak9vVURQTXE5OFlDN2Zn?=
 =?utf-8?B?UGVheEd1SGFNL2FJYTMzKzhZWWk1YWlLblhDTXI1alMxU1FlUTljMGphbTAr?=
 =?utf-8?B?ZUVWWXZXS2pySWt0M0pTUlI5NG0yUEZ4TXgxWFNtb0pNTkd5NG1MRU0zZzRJ?=
 =?utf-8?B?VzI2UUZiQUJuWHAxVG1pem5rR1duNmh3V0ZjcURVRWN5NjEwTG8rOERUNm44?=
 =?utf-8?B?YUp1Wnl5YzVMWmxQSXBUUEF6aUxjKy9qcEdiU3NRakZpK2hGeDcwd2gzRkMx?=
 =?utf-8?B?YWhXSktkeW1WUTBWd0w4MFQzVjFjSzBUcFVPa20zbU1zcEZTTmFjVi9mbU9H?=
 =?utf-8?B?SGFralVhRVgrQ2paSWJpQzhiMTVkUUYraW05d1hhenRjdlh0Ui9raDJMZ2t5?=
 =?utf-8?B?TGtHU0hWamU4cTkrRzVoOU5rWkN0NU41OFE2VFUyMVhIM0xGVEVldXFXNHdS?=
 =?utf-8?B?WDBaS1NwdTJDUlZmTFpZWk9uSFBMR3ZJZC9WeTJrVUcyM1o4Qlcrdk9FWmV0?=
 =?utf-8?B?L05haFRrOTgzeHNqN0RiNHVBZnJjUTF5Z1oxa2hRMEI0czFBN2ZoRlQrNk0y?=
 =?utf-8?B?aWNVNkQwcDROT3NJVFEyeTNTalZBa3N0S2RYc3IrZVNWL0ZHeTNKTEJDcEhZ?=
 =?utf-8?B?OWdPWHZlR3BCdmlrY1FBVU9EdjBBM0JiWmIxbUs3SWFQNmhKK0ExS0EwcmJF?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9e16a4-09df-42a0-debf-08de0a9dc642
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 21:16:28.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wke1YyBqOvWHIa7FwfP+KoatRcYVOeiI3AjEHnRenLYeDyRUCrH+eSVu2jfeKfiAuK7fzW58SMqPsyfryda5srlmpvzOhRkaOBWy05jwnk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com

--------------MP9tUhiMiB0RdswQAZs3z3Z0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/2025 6:42 AM, Borislav Petkov wrote:
> 
> Fixups ontop:

Thanks!

> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index daae74858347..216595a45564 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -315,15 +315,18 @@ static void stage_microcode(void)
>   	int cpu, err;
>   	u64 mmio_pa;
>   
> -	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32)))
> +	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32))) {
> +		pr_err("Microcode image 32-bit misaligned (0x%x), staging failed.\n",
> +			get_totalsize(&ucode_patch_late->hdr));
>   		return;
> +	}

Yeah, need to keep in mind more consistent about emitting error messages 
in this area.

Include the updated patch:


--------------MP9tUhiMiB0RdswQAZs3z3Z0
Content-Type: text/plain; charset="UTF-8";
	name="PATCH6a-x86-microcode-intel-Establish-staging-control-logic.patch"
Content-Disposition: attachment;
	filename*0="PATCH6a-x86-microcode-intel-Establish-staging-control-logic.";
	filename*1="patch"
Content-Transfer-Encoding: base64

RnJvbSA4MDlmMTg0NWNmNzYwMjNmOTdiOGY5YzAzZGQ4ZTEwZmRkYTJhYWM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiQ2hhbmcgUy4gQmFlIiA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwu
Y29tPgpEYXRlOiBGcmksIDE1IE1hciAyMDI0IDIzOjA1OjM0IC0wNzAwClN1YmplY3Q6IFtQQVRD
SCB2NmEgMy83XSB4ODYvbWljcm9jb2RlL2ludGVsOiBFc3RhYmxpc2ggc3RhZ2luZyBjb250cm9s
IGxvZ2ljCgpXaGVuIG1pY3JvY29kZSBzdGFnaW5nIGlzIGluaXRpYXRlZCwgb3BlcmF0aW9ucyBh
cmUgY2FycmllZCBvdXQgdGhyb3VnaAphbiBNTUlPIGludGVyZmFjZS4gRWFjaCBwYWNrYWdlIGhh
cyBhIHVuaXF1ZSBpbnRlcmZhY2Ugc3BlY2lmaWVkIGJ5IHRoZQpJQTMyX01DVV9TVEFHSU5HX01C
T1hfQUREUiBNU1IsIHdoaWNoIG1hcHMgdG8gYSBzZXQgb2YgMzItYml0IHJlZ2lzdGVycy4KClBy
ZXBhcmUgc3RhZ2luZyB3aXRoIHRoZSBmb2xsb3dpbmcgc3RlcHM6CgogIDEuICBFbnN1cmUgdGhl
IG1pY3JvY29kZSBpbWFnZSBpcyAzMi1iaXQgYWxpZ25lZCB0byBtYXRjaCB0aGUgTU1JTwogICAg
ICByZWdpc3RlciBzaXplLgoKICAyLiAgSWRlbnRpZnkgZWFjaCBNTUlPIGludGVyZmFjZSBiYXNl
ZCBvbiBpdHMgcGVyLXBhY2thZ2Ugc2NvcGUuCgogIDMuICBJbnZva2UgdGhlIHN0YWdpbmcgZnVu
Y3Rpb24gZm9yIGVhY2ggaWRlbnRpZmllZCBpbnRlcmZhY2UsIHdoaWNoCiAgICAgIHdpbGwgYmUg
aW1wbGVtZW50ZWQgc2VwYXJhdGVseS4KClN1Z2dlc3RlZC1ieTogVGhvbWFzIEdsZWl4bmVyIDx0
Z2x4QGxpbnV0cm9uaXguZGU+ClNpZ25lZC1vZmYtYnk6IENoYW5nIFMuIEJhZSA8Y2hhbmcuc2Vv
ay5iYWVAaW50ZWwuY29tPgpUZXN0ZWQtYnk6IEFuc2VsbSBCdXNzZSA8YWJ1c3NlQGFtYXpvbi5k
ZT4KUmV2aWV3ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4KTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzg3MXB6bnEyMjkuZmZzQHRnbHgKLS0tClY2IC0+IFY2
YToKKiBBZGQgYW4gZXJyb3IgbWVzc2FnZSBmb3IgbWlzYWxpZ25lZCBpbWFnZSBzaXplIChCb3Jp
cykKKiBGaXggdHlwbzogaWQgLT4gSUQgKEJvcmlzKQoqIFNob3J0ZW4gdGhlIGVycm9yIGNvZGUg
cHJpbnRvdXQgKEJvcmlzKQotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oICAg
ICAgfCAgMiArKwogYXJjaC94ODYva2VybmVsL2NwdS9taWNyb2NvZGUvaW50ZWwuYyB8IDUxICsr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaAppbmRleCA3MThhNTVkODJmZTQuLjA3MzZlNDRm
N2M2OSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgKKysrIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgKQEAgLTEyMjIsNiArMTIyMiw4IEBACiAj
ZGVmaW5lIE1TUl9JQTMyX1ZNWF9WTUZVTkMgICAgICAgICAgICAgMHgwMDAwMDQ5MQogI2RlZmlu
ZSBNU1JfSUEzMl9WTVhfUFJPQ0JBU0VEX0NUTFMzCTB4MDAwMDA0OTIKIAorI2RlZmluZSBNU1Jf
SUEzMl9NQ1VfU1RBR0lOR19NQk9YX0FERFIJMHgwMDAwMDdhNQorCiAvKiBSZXNjdHJsIE1TUnM6
ICovCiAvKiAtIEludGVsOiAqLwogI2RlZmluZSBNU1JfSUEzMl9MM19RT1NfQ0ZHCQkweGM4MQpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9taWNyb2NvZGUvaW50ZWwuYyBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvbWljcm9jb2RlL2ludGVsLmMKaW5kZXggMzcxY2E2ZWFjMDBlLi4yMTY1
OTVhNDU1NjQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2RlL2ludGVs
LmMKKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9taWNyb2NvZGUvaW50ZWwuYwpAQCAtMjk5LDYg
KzI5OSw1NiBAQCBzdGF0aWMgX19pbml0IHN0cnVjdCBtaWNyb2NvZGVfaW50ZWwgKnNjYW5fbWlj
cm9jb2RlKHZvaWQgKmRhdGEsIHNpemVfdCBzaXplLAogCXJldHVybiBzaXplID8gTlVMTCA6IHBh
dGNoOwogfQogCisvKgorICogSGFuZGxlIHRoZSBzdGFnaW5nIHByb2Nlc3MgdXNpbmcgdGhlIG1h
aWxib3ggTU1JTyBpbnRlcmZhY2UuCisgKiBSZXR1cm4gMCBvbiBzdWNjZXNzIG9yIGFuIGVycm9y
IGNvZGUgb24gZmFpbHVyZS4KKyAqLworc3RhdGljIGludCBkb19zdGFnZSh1NjQgbW1pb19wYSkK
K3sKKwlwcl9kZWJ1Z19vbmNlKCJTdGFnaW5nIGltcGxlbWVudGF0aW9uIGlzIHBlbmRpbmcuXG4i
KTsKKwlyZXR1cm4gLUVQUk9UT05PU1VQUE9SVDsKK30KKworc3RhdGljIHZvaWQgc3RhZ2VfbWlj
cm9jb2RlKHZvaWQpCit7CisJdW5zaWduZWQgaW50IHBrZ19pZCA9IFVJTlRfTUFYOworCWludCBj
cHUsIGVycjsKKwl1NjQgbW1pb19wYTsKKworCWlmICghSVNfQUxJR05FRChnZXRfdG90YWxzaXpl
KCZ1Y29kZV9wYXRjaF9sYXRlLT5oZHIpLCBzaXplb2YodTMyKSkpIHsKKwkJcHJfZXJyKCJNaWNy
b2NvZGUgaW1hZ2UgMzItYml0IG1pc2FsaWduZWQgKDB4JXgpLCBzdGFnaW5nIGZhaWxlZC5cbiIs
CisJCQlnZXRfdG90YWxzaXplKCZ1Y29kZV9wYXRjaF9sYXRlLT5oZHIpKTsKKwkJcmV0dXJuOwor
CX0KKworCWxvY2tkZXBfYXNzZXJ0X2NwdXNfaGVsZCgpOworCisJLyoKKwkgKiBUaGUgTU1JTyBh
ZGRyZXNzIGlzIHVuaXF1ZSBwZXIgcGFja2FnZSwgYW5kIGFsbCB0aGUgU01UCisJICogcHJpbWFy
eSB0aHJlYWRzIGFyZSBvbmxpbmUgaGVyZS4gRmluZCBlYWNoIE1NSU8gc3BhY2UgYnkKKwkgKiB0
aGVpciBwYWNrYWdlIElEcyB0byBhdm9pZCBkdXBsaWNhdGUgc3RhZ2luZy4KKwkgKi8KKwlmb3Jf
ZWFjaF9jcHUoY3B1LCBjcHVfcHJpbWFyeV90aHJlYWRfbWFzaykgeworCQlpZiAodG9wb2xvZ3lf
bG9naWNhbF9wYWNrYWdlX2lkKGNwdSkgPT0gcGtnX2lkKQorCQkJY29udGludWU7CisKKwkJcGtn
X2lkID0gdG9wb2xvZ3lfbG9naWNhbF9wYWNrYWdlX2lkKGNwdSk7CisKKwkJZXJyID0gcmRtc3Jx
X29uX2NwdShjcHUsIE1TUl9JQTMyX01DVV9TVEFHSU5HX01CT1hfQUREUiwgJm1taW9fcGEpOwor
CQlpZiAoV0FSTl9PTl9PTkNFKGVycikpCisJCQlyZXR1cm47CisKKwkJZXJyID0gZG9fc3RhZ2Uo
bW1pb19wYSk7CisJCWlmIChlcnIpIHsKKwkJCXByX2VycigiRXJyb3I6IHN0YWdpbmcgZmFpbGVk
ICglZCkgZm9yIENQVSVkIGF0IHBhY2thZ2UgJXUuXG4iLAorCQkJICAgICAgIGVyciwgY3B1LCBw
a2dfaWQpOworCQkJcmV0dXJuOworCQl9CisJfQorCisJcHJfaW5mbygiU3RhZ2luZyBvZiBwYXRj
aCByZXZpc2lvbiAweCV4IHN1Y2NlZWRlZC5cbiIsIHVjb2RlX3BhdGNoX2xhdGUtPmhkci5yZXYp
OworfQorCiBzdGF0aWMgZW51bSB1Y29kZV9zdGF0ZSBfX2FwcGx5X21pY3JvY29kZShzdHJ1Y3Qg
dWNvZGVfY3B1X2luZm8gKnVjaSwKIAkJCQkJICBzdHJ1Y3QgbWljcm9jb2RlX2ludGVsICptYywK
IAkJCQkJICB1MzIgKmN1cl9yZXYpCkBAIC02MjcsNiArNjc3LDcgQEAgc3RhdGljIHN0cnVjdCBt
aWNyb2NvZGVfb3BzIG1pY3JvY29kZV9pbnRlbF9vcHMgPSB7CiAJLmNvbGxlY3RfY3B1X2luZm8J
PSBjb2xsZWN0X2NwdV9pbmZvLAogCS5hcHBseV9taWNyb2NvZGUJPSBhcHBseV9taWNyb2NvZGVf
bGF0ZSwKIAkuZmluYWxpemVfbGF0ZV9sb2FkCT0gZmluYWxpemVfbGF0ZV9sb2FkLAorCS5zdGFn
ZV9taWNyb2NvZGUJPSBzdGFnZV9taWNyb2NvZGUsCiAJLnVzZV9ubWkJCT0gSVNfRU5BQkxFRChD
T05GSUdfWDg2XzY0KSwKIH07CiAKLS0gCjIuNDguMQoK

--------------MP9tUhiMiB0RdswQAZs3z3Z0--

