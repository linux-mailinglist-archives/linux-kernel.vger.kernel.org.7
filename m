Return-Path: <linux-kernel+bounces-771184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1555B283E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7501D03649
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872FE309DA7;
	Fri, 15 Aug 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCM5ZS4u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93853093DC;
	Fri, 15 Aug 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275869; cv=fail; b=UPqEZdJaKPvu2/MRZQtVcFB0UMXsVxu6AgsgQLdSdg5ntmgc4TRD8CXfC/l2GcOYccPB7OEaM9zZF+LkPn289BFZZF+jG3VahPLaCbGgfi/alg9XgtK6MzHdrwTQ5EBFAF2FL+MXqIvVO10kBiLsQJxNQ0REYBjU3dJ8AoBdzI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275869; c=relaxed/simple;
	bh=u7XpkmPl24HQaPtrMjEX9TqRM4pBjNP+sqLRlVMZbU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MYSmhOUQr+jy2C9wSgPC21pU5MakUPvr6PQth0MotQufpeAdQNGhUzs8SkESc0X29MA9v1IXaGy2Bf0ZoyVmxOaW6jFWAIRuqf79hEC1CQzQr68pzSjcUjO6wVW/EK45GfyhfNfaNX53QWI2wJNocxBPVv1Zdbu3WaLaAGU2mEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCM5ZS4u; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755275868; x=1786811868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u7XpkmPl24HQaPtrMjEX9TqRM4pBjNP+sqLRlVMZbU4=;
  b=HCM5ZS4uFqJ4jH+LR6qyA5+1Abde37+5QBjGwcFuCz5y+WvMg0wGD/BM
   5byGJ8j4+gOEd6uUjoO3GI6eO0qMA4uhntIyLNYFJCcZ2Pohbh6PHy+y4
   xJR1mQ9DjN9M4pFT9YAj+0wm5LogXp6A14NVOjgWc2o9XqVNWUR9lwKuy
   sGejLNCWdOzj8poL10atHkXDurzq0gozFX6s4quz30msijtvXyngIc6XH
   7ELyMglFeptDE+PJsFhXJLoAMA+Vc5bCmY9dnzLnWpdkXsSpQl7qymMlO
   9xdxBRAGu629Nyrj/nJDSOweOD2tANy8KdglNwvungFKqtFxuJxXfNT3B
   Q==;
X-CSE-ConnectionGUID: FJTk50bqQcGQJXTP0rzXDQ==
X-CSE-MsgGUID: FAYupBaiR828y9z2s1F55Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="75164977"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="75164977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 09:37:36 -0700
X-CSE-ConnectionGUID: p2TCECvuRtmz1IuUzGwcyw==
X-CSE-MsgGUID: j4HQi0F6TcmzGtG6SOFuEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171175143"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 09:37:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 09:37:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 09:37:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.68)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 09:37:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EePAtk6IczioWwCe54Dvqzv/LIOJbQ2drjxGy62M8E2h/wBXGK8rXtigew4FEblJTLa9tmSBkp39FSYV/Y7EUYAOoEx+cJ4wLZflj0LHzp8l+8iB34TzLfnkqYrfGcAxZS3uDUbW5vpBf3MsQd/RSCRs9yppxq8pekmqRq7LipFBbCgByYxnohiVmTL05qThbFAyDei4B4rd2NGHlL2CDUhfOzV+SscuaizSeKf9gx7rJOKnhYJF+eeKTbxfC6VpLOzPlwP6t+9P+3BDV/nxJIO8Or40POVBvBKNxxepmFoKutQiUdIQrGYmw0IRpaJ3AQdoQLzz4yDCDt4y64+nxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7XpkmPl24HQaPtrMjEX9TqRM4pBjNP+sqLRlVMZbU4=;
 b=sZIlxYCKqgAB3EXq987wBbiNLFT1COOLBV55rIaBZC8na0PNzYurz1Tc4OtzrxD4j4r7cb+TTz7qOt9prs8bs8PaWDlry0kdew6gLa1ELZG7ziIxBJcINajuCUF2bX65IVwQCEB6B0Um1ZBIvT2YgKNhvGOaaDQbCxyAdbQU4GODUuV4TUKHsii7cF2whZTaDANeSUrpFgzV57o8h/C00CwqfI1TZiLYzfqyDmYRTZjIK38nxJLvCWbynQnJca3I8KL5ljADouNmrTycB1eZGKrFdCEykn6CaukfzOZ3JrjWNLjrkg/5fAJgYjP504Cpi8y0Z++LFTb8CmUel/ecmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8702.namprd11.prod.outlook.com (2603:10b6:610:1cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 16:37:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 16:37:29 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC: "maz@kernel.org" <maz@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>, "mbland@motorola.com"
	<mbland@motorola.com>, "david@redhat.com" <david@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "joey.gouly@arm.com"
	<joey.gouly@arm.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "pierre.langlois@arm.com"
	<pierre.langlois@arm.com>, "jeffxu@chromium.org" <jeffxu@chromium.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "kees@kernel.org"
	<kees@kernel.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "jannh@google.com"
	<jannh@google.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
	"qperret@google.com" <qperret@google.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH v5 13/18] mm: Map page tables with privileged pkey
Thread-Topic: [RFC PATCH v5 13/18] mm: Map page tables with privileged pkey
Thread-Index: AQHcDcKD2qDmRtHYakOguSflBSorNLRj6kEA
Date: Fri, 15 Aug 2025 16:37:29 +0000
Message-ID: <616011cf17f1654ac3ad8757f0f33425b3af1ddd.camel@intel.com>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
	 <20250815085512.2182322-14-kevin.brodsky@arm.com>
In-Reply-To: <20250815085512.2182322-14-kevin.brodsky@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8702:EE_
x-ms-office365-filtering-correlation-id: 5160f726-b354-4c50-4529-08dddc1a069f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VC92V0FSY0FoU2hhUDluYUxaRjUzbzdkcmxtNFZZQUpDK0VjMXNMdXZVVHVE?=
 =?utf-8?B?TVZ4c2tQQktRd3hPR1dtcGVzTW9VTTVML1hFV2Rqdm9LbnRFS3dESHFqcXJO?=
 =?utf-8?B?L0NwT2VqQ0JaSlhueXdHcmtqRDUvaUZMWGE4MjkxQlZyVFVRZUZ0NlNsbU5O?=
 =?utf-8?B?RGZLek9sSXpyWS83Z3NkbUxjeURPaEprU3Y5ZFpPWFplTUR1aDZqdEtTSjkw?=
 =?utf-8?B?Q1NFNFcxRzBUdVZadDdkNGxoeE04Y0JUbG5tVFlqQjlnSzhKeG1hSERhNDRp?=
 =?utf-8?B?YzUvT3JnMUN1aWlzcmZOV0ZWQ0NVYVgySXZ1OXZRZ2VCNHZmZGVQRUw4QW9R?=
 =?utf-8?B?V3dMR0R1emZUajMySWQ2MmJ6czY2dVhzU2dmeVNKRW4wWUE0T0VqUnpuTk5k?=
 =?utf-8?B?RlEwb2xmR2hTSUZTN0U5eTBvSGR5a3JqRGo1ZXRCc2JlWVRsc205L2RFeC96?=
 =?utf-8?B?VVE5ZHNsQnBKM1VjbEF0ZUUveENRcnJqOVg0TFordWVLQ0oxSjNBUlZsN2gz?=
 =?utf-8?B?NFJWSy83VzJ0RWVXTXhndkNqc0YwSDN4aTNqTFQ5RUU2dW54WWY2YnBwZzdn?=
 =?utf-8?B?ZnFqYjVYL1FZelIvUWJmcDlhVVA5bnJPZ3M0RkNqbkNNbVNnNTVtb1A4c2g4?=
 =?utf-8?B?R3Z2WUlEOWQwSmJzWlAxU3NaUVoybnRzS256Z1gwWndVOXdock0vTlloZDc0?=
 =?utf-8?B?WXM4NWNWOFRKaFgyUk1pQktHbGZLdnZYTnJkcUVEeHV6QlQ1V2twYTlCZW5q?=
 =?utf-8?B?dHgzNElJY3FBLzcwaGt3Q2RFQ2dSY1d1WHp1SkNlZ3VNTEhLVTFrNXltVUMw?=
 =?utf-8?B?azYzMGlVTWkyRXN3Q1JpZkkrY3B3d3czT0xMeUdrQUNpUTRCdGJrOU85S0py?=
 =?utf-8?B?ajRCaUcxdms4SkI2bjArbFY1bGVBUFdwWEpFSlFOYXE3WFBwd2dzMWNSR0VV?=
 =?utf-8?B?V1RYZjBOV0Y2TmJvQy90ZmhVT1FIdkFKRmhqU05sbWh4ZVZKK3FSamdKM1RY?=
 =?utf-8?B?UmJNSkJ3WVlSenBzTnc4NEVRR0dMYkQxenJMQTBrRk82ZEtEVlcreG9FZGJD?=
 =?utf-8?B?SmU2TTY5eTJKcWNjdDhySDlRTnNDMmRMWUVzY2tLTzRXaUc2RzgwSDJZaG1O?=
 =?utf-8?B?RGhVL0xQbkZobHZVdW5wYnZ5OFBMNWJjWjlCQmNMM2orYzdzUVJPZXYzVnFZ?=
 =?utf-8?B?dDExQXNkMlRpN1ZhTnN5Z0N2dmxVZDYxL2oxSlpVYzhzRnI3SmZ3Wm9HWTZZ?=
 =?utf-8?B?WmM3eWdXS2hVNGpIWGh6TmZ4dTFJdklyZFF3cTJEL00raUtHV2NtQU9GY2FE?=
 =?utf-8?B?ZkFiQ3pIVnZ4QmI5OTIvbEpMZUZ4OXFlN00yRXllWmkzc1UrV1NyS1BKZDJK?=
 =?utf-8?B?eFJ6Rm05QTdiUDl2bXpUMVFUZjB1cVJTWlNBL3ZCZ2R6cWhaYU9sU2NvOVU2?=
 =?utf-8?B?WHBIYThrUlNhSFE3TDdFVWw4VFRrSFpkZU54aG1aMmNuM3VXbGV6MEdRNEdr?=
 =?utf-8?B?bjN4L0oyeWl4SG03TW9PWVJwNVhkaXZqaWp3QlhveW9mZW1vNmVJUEhuTHY5?=
 =?utf-8?B?eVlvWlZ3ZXpsOFluVXpMSzhPSWttempPVGQrMDhzNWdKNGxMMGRtUXhSbkU1?=
 =?utf-8?B?MGdEaHVobmJEK2hsM0tHdzlMVElZZ2ZZWEwzQVd5bnBsdXBnQ05zdzByOW5P?=
 =?utf-8?B?Mm1YQWlkeVc2dXhUS3Y1R2k1UHRjWTUySm9VYlVTOEd0RlNtZEVMcWJKNFhK?=
 =?utf-8?B?bXNKVFRDY3p6WHVIcEdidkN1aGxUenhUQzYreVA5Q3pVaHQxNFpabm83Zk56?=
 =?utf-8?B?aTlRMzhhYUdXenpIc3k4WHE1RVd1RnQrYUZiMEVVV0xQYkN0d3NhMXFQN2U1?=
 =?utf-8?B?SzMzRkRPNzB0U096dy9HQzFiSXNuL0puSlp1VnJ4alB6R2VCUDRqMTRSRVNi?=
 =?utf-8?B?UTBXVkxWdVFibTFrMXpoQU0zWG9jb0hsSmdYbFRwNktnV1NXNWt6RHk2bEQv?=
 =?utf-8?B?VHgvUTExU2RRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU5yOWd3VXMzdDVkNy8yY1QvYVdOWXVlVm56SVRPUDVna1Q1TU5hcnhHdDBi?=
 =?utf-8?B?MmhlN2lTbUpIVTQyUVNLQ2FkSFk2bVZndjFGejM2YnkzcGxoSWN4TDhQcFRu?=
 =?utf-8?B?Wi81NFh1QnBza1ZrYXJzZTc4bzJRZlp2VXljbUNOMk5tTW5GejVlUTFiNG9o?=
 =?utf-8?B?T3daaXBONFgrRllRMTBTRXFUTmRQWVlBcUN5djVMTTVMU0taWDBUMU1NY1Zm?=
 =?utf-8?B?bUR1QkVMOUNja2ZhOGtCVnl2UlV5dEVjM3k5N1JaYlRzdFFMZFBoN2VuQVc1?=
 =?utf-8?B?bVlNNnNtY0RqaHh6aDNQRkxzbkd6a25YTkd2YTZuZk84RHRXdzh3aVpUVEJx?=
 =?utf-8?B?WU1EbkRobHIwTWFVY2JNR1NkOWdNdXc0c0dGS25NdlNCUEc4eTlKZjBtZVEz?=
 =?utf-8?B?ckpCcENoNTdoOTQ4TWRRdVN3YUVDa1pDK3RhSVluVkpTNExyTlhIRmpiRGNT?=
 =?utf-8?B?cG5HNkl2eWNFTFhnNFRKVFA1VFUyNTYrQmJTV3JuQ0I5T2NPL3h2bU9yTGJk?=
 =?utf-8?B?VjE2MEdUbUgvS3V6L3JrQ2lWZVhIZVZ5cFEwaVYzRU85UTIvN0FBRWd2RTFq?=
 =?utf-8?B?MTVFbVBCakFjMHhKaWlwd2ZaTW9URlAxc1JWZzYxcWdPaGNGNy9ZRE03NE1u?=
 =?utf-8?B?RVVQamltNEt6d2FXQjFpVmRxLzhiNjRhSEFtUjhzQ1Y5ekQ3U1RuT3lYYmhO?=
 =?utf-8?B?VTVWZTFwK1g4MFc3dlRSQkkwMmZHSzhCNGdjQXduenZXV0F4bXhoTGQ0c01B?=
 =?utf-8?B?b3JYTVl4alZpUS96VVQ5S203MlhscTg5VURZZzNKODZ5VWVPa3pvYUdROVpj?=
 =?utf-8?B?MVFNRlV3YXAzVGRRYVFBeGhlZFVPTmNPRHAyNnl6OVJwUUtWYmtVVXdHRnVX?=
 =?utf-8?B?bXM3RXdMVTVsU1ZLdkV4V0JZcVkwQUxyZVp6Q1RNd21nY3VOU1M1WlYwalJH?=
 =?utf-8?B?MjBmL0EvZGtwUHV2RXNUcXpMYjc5Yk0xQ0tTNnd0RHVwVkpLYmJ0RlJPQTQw?=
 =?utf-8?B?S1Z6Qld5djNocGhrTldtWDBVamwzQ3BzNWhFenlRRlZPTC84VTUxOGsxdnBk?=
 =?utf-8?B?bUxvYkFoZ0xaSk5NTTI3THFreG9sZnZnUlpmZ25PaitwSzYzaTJFbnFyUFh3?=
 =?utf-8?B?b1lxazF4RzRNcG5jMUtrN0VJdi8yY3dYN2c2cjllUDY3ZHQzWGNkRzFpa3hB?=
 =?utf-8?B?cTFEZDhnUG4rK0FCYXBhMjIxSk15ZytZM1pac1NDc0EyT0RvUUdJazM1Q2hx?=
 =?utf-8?B?bmlpeW9hZy92N1ltcU1MZ1JDYTNsb0F1S0RDZ2UzTHhYS1hTS1Z6RHF0bXoz?=
 =?utf-8?B?QUtnZmxMYXhveWl5NWRjUURUdmJpRnNacTBVTk9pdVpMZHlyUElWN2ZJYTNa?=
 =?utf-8?B?cWVsV2xwNFVnVjN6OGZhTjduSFZEZ0hMaEQybHhVSE1RL1I1TStuUEdLOThF?=
 =?utf-8?B?R1g2UXM2elpSMkxrZ0t4T2s5ZFRrWW4vbnZtZlZYeVpPOVpES2xjQ28zaktM?=
 =?utf-8?B?eUdpMHYzUTlEUGlhM2dqcnhLTFZ0TW9nKy9yWjVpVGNNL3dYd1oxM05FU3pB?=
 =?utf-8?B?U2V5RmFCY1VtbE1samt0TEplN05uMndEQ29NcDBHWmxZd0hrVWRSSVB3L25a?=
 =?utf-8?B?MUpuVHl5ZkVjYkxPYVE1WGVYY3dwUTM4Rkw0bHEyQ2QwK0tFM1ZML1JFSUdw?=
 =?utf-8?B?cDViWHFZQTdjd01JZDNPVzJVYzNneFdZQXVISU5tU0xFNzhsbmVVR1Nubmgy?=
 =?utf-8?B?ZmtPNmVMdjljRFcyQWJQVE56bkpBTXVnRnZPaHFVNTVlaHJJaWFUU0toVDI4?=
 =?utf-8?B?dXRJVTErZTZRNEhTRmwzaFNzN3dYZTlNZi9WQytTQ1FuQkhUSUQ4Y3FhRTY5?=
 =?utf-8?B?R3dTdlNWUXl5TENPQzhDZDZTZEQyZGdxRzQ5WS9YUThuY2V6SDByelJRb21y?=
 =?utf-8?B?NHZ1Yk5HVkVMVjV4dFlZRWZ1NGUwZnhWRDhubEdxN3hGRC8zNnZLZytEdklL?=
 =?utf-8?B?Mk4vY2o1Nm9VMEhqNnRneWxEMlp5b0lzK3ZtT0Y5cUFVM3RrQStaTFhQWGox?=
 =?utf-8?B?QktPdmZDOEdRRTBmUDlCUWQvT0UwVmtZSWF2Q3FaeUJHWXVpbFdrL1MvaXV0?=
 =?utf-8?B?YlRXTVd3b21lSkhiYWdkWk5mYkVCUU5lUTRrNGNzT0Y2cXI2NTRESTFNbk0z?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15B9E694A0446847BAA8AB58AD562272@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5160f726-b354-4c50-4529-08dddc1a069f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 16:37:29.4782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z96Ck0OpEyUNhat6TuPyP2I35gWgLrN7eKfOyP9CooxZIFfnnktHQfrYR049l9D581gWpcjDJ2scHeM3LOZJAH3pip42nqOIwDSNVZCehWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8702
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA4LTE1IGF0IDA5OjU1ICswMTAwLCBLZXZpbiBCcm9kc2t5IHdyb3RlOg0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+
IGluZGV4IGQ5MzcxZDk5MjAzMy4uNDg4MGNiN2E0Y2I5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L21tLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+IEBAIC0zNCw2ICszNCw3
IEBADQo+IMKgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvY2Fj
aGVpbmZvLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L3JjdXdhaXQuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9rcGtleXMuaD4NCj4gwqANCj4gwqBzdHJ1Y3QgbWVtcG9saWN5Ow0KPiDCoHN0cnVjdCBh
bm9uX3ZtYTsNCj4gQEAgLTI5NzksNiArMjk4MCw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBfX3Bh
Z2V0YWJsZV9jdG9yKHN0cnVjdCBwdGRlc2MgKnB0ZGVzYykNCj4gwqANCj4gwqAJX19mb2xpb19z
ZXRfcGd0YWJsZShmb2xpbyk7DQo+IMKgCWxydXZlY19zdGF0X2FkZF9mb2xpbyhmb2xpbywgTlJf
UEFHRVRBQkxFKTsNCj4gKwlpZiAoa3BrZXlzX3Byb3RlY3RfcGd0YWJsZV9tZW1vcnkoZm9saW8p
KQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+IMKgCXJldHVybiB0cnVlOw0KPiDCoH0NCg0KSXQgc2Vl
bXMgbGlrZSB0aGlzIGRvZXMgYSBrZXJuZWwgcmFuZ2Ugc2hvb3Rkb3duIGZvciBldmVyeSBwYWdl
IHRhYmxlIHRoYXQgZ2V0cw0KYWxsb2NhdGVkPyBJZiBzbyBpdCB0aHJvd3MgYSBwcmV0dHkgYmln
IHdyZW5jaCBpbnRvIHRoZSBjYXJlZnVsbHkgbWFuYWdlZCBUTEINCmZsdXNoIG1pbmltaXphdGlv
biBsb2dpYyBpbiB0aGUga2VybmVsLg0KDQpPYnZpb3VzbHkgdGhpcyBpcyBtdWNoIG1vcmUgc3Ry
YWlnaHRmb3J3YXJkIHRoZW4gdGhlIHg4NiBzZXJpZXMnIHBhZ2UgdGFibGUNCmNvbnZlcnNpb24g
YmF0Y2hpbmcgc3R1ZmYsIGJ1dCBUQkggSSB3YXMgd29ycmllZCB0aGF0IGV2ZW4gdGhhdCB3YXMg
Z29pbmcgdG8NCmhhdmUgYSBwZXJmb3JtYW5jZSBoaXQuIEkgdGhpbmsgaG93IHRvIGVmZmljaWVu
dGx5IGRvIGRpcmVjdCBtYXAgcGVybWlzc2lvbnMgaXMNCnRoZSBrZXkgdGVjaG5pY2FsIHByb2Js
ZW0gdG8gc29sdmUgZm9yIHBrZXlzIHNlY3VyaXR5IHVzYWdlcy4gVGhleSBjYW4gc3dpdGNoIG9u
DQphbmQgb2ZmIGZhc3QsIGJ1dCBhcHBseWluZyB0aGUga2V5IGlzIGp1c3QgYXMgbXVjaCBvZiBh
IGhpdCBhcyBhbnkgb3RoZXIga2VybmVsDQptZW1vcnkgcGVybWlzc2lvbi4gKEkgYXNzdW1lIHRo
aXMgd29ya3MgdGhlIHNpbWlsYXJseSB0byB4ODYncz8pDQo=

