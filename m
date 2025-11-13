Return-Path: <linux-kernel+bounces-899675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9C2C58A97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2BAD4F4E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E02340285;
	Thu, 13 Nov 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGP+fXW/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB433FE23
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048189; cv=fail; b=mfFAv0433W/fV8mGt+wGISEAsJSkAMD4ehkO848lwtiucD0jcjm+E9q9gLyszcbEbfY5/0JnBDnYaC4LS3/9AJDiqkh1g227Cvbdbnb6y6ioKkwH+AnlrykhrEiR43GTcUxvM2rZojPqIXA8z7Xkq3VuZMVMjNVnO7YkpAhDTOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048189; c=relaxed/simple;
	bh=vv/gDGA8k+znlsUUy6J9x3zQ5AUZPkXCew0dwF5fQak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RAkpR09AnxRFWAxmIY0j+WFvt1BI89Su82Z5BWsSLjgmWv4XygKJvsF1CebxuSvP+oGqijEUdWXTpJiLokhzrL34bjm3+hiTz2ckoynwA3tTMsSQObvnvqUkaKgiZWRHPkiwkop6/XUfn5Ef92+j0DIC8pSkPeLITJrrzbcmec4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGP+fXW/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763048187; x=1794584187;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vv/gDGA8k+znlsUUy6J9x3zQ5AUZPkXCew0dwF5fQak=;
  b=aGP+fXW/9HNeReO8/gNuxPq2ukhAAik5q08XeYU0tPvnoADef9jvb1b8
   sYkt9/DFewgqp63xm30JC1CT86cYVuYyqraQspa2SCvpDHLfEZG0947+C
   b3TPlHQYkO+zYe9GPG7yuFH6nb9e8MccybEA0GJGDX5MqlEx+vDzZguwD
   lOjgWRN7+4swxSDFcoxO262TjuVlrmg39H3wwiozdOT1NeN3CORZoF5r/
   3I9mwYdsbNRaUGyZUZZluAgsAn/ooikp4ou1kDxVBudigMWoUhaYKFbQe
   FwEXdayMfxZcYEAKGDVdxm8wZfBdmfoeLTbcnxDz2Onn+SnIfM1l7pEdG
   A==;
X-CSE-ConnectionGUID: QNn2kpLVRROw22U9YHQtsA==
X-CSE-MsgGUID: pd0cvBHyQ3+nH48p4asnbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="67731685"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="67731685"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:36:20 -0800
X-CSE-ConnectionGUID: 32y8hf5+TYqLLwAdVTEAcg==
X-CSE-MsgGUID: F8OrNRL1RNSm36+0bxGCtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189959766"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:36:20 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 07:36:19 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 07:36:19 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 07:36:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4dG1KbEUyUUGKQvkv50kAir7Nlw18Q83hluKjDXMGc3IwOrCAilNCsyaTrKjei6e3dhO4//sLdoluI4v8/GHlLY3ZZGZSatV9U4AlecmnnLOgJii+tWDj6FaxitwmjcCHmMx3+8jmPOLR8qEGRPPpLSGXivLq9lHGQSyEp1zDQh52vGXX2gV7nQLDDAd6XRpFRndrKYAzsbFJcsXvCk+OoZeBD8tTu8I7Cxmsxw36bffThBEZVJdLT+T7YzDF0+rBC7mJEeigWCEry2mj88euFTFUo3q361Ro//T/eJFKjKKa/Qp4S6nxOZpSkBRzEIU/+c0EsIUAVJ9EdAalM8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrFKgjrFiSiMbUHTUrHQwCyfwC1D3byr3SevA3aSdKk=;
 b=iWyUHuqlnxzaiSP1BhG+bcKpg5UsQAPCvC0Iv5c559E7l5aFiG8eCS95xzmkG6jYw1HzDIuwCcWhGRwYJ8tokIM62BfrWUpkdRBh7dPvt5kaXwMsPtTQylzf/+fRWAK9atQR9aTwC8hrI0N/2mmWKnhZ6zpi1i/MnqooaLVgSPFsC5j47z9rxIz4N7MZlnEFn0BxMpvz2nq16THBNcj8074EIvnCX0IdamSVZ9npjaXTK++k5GVkGgNSEza1suQJyRTzrl9blLFzQFoGkdJFc5YknJHCGK+xNS12zMsLvbjRFafk1FRxGayFzMBMHM3ypFv7bt7VBkKUDbGyNP0C4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:36:16 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::5461:fa8c:58b8:e10d]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::5461:fa8c:58b8:e10d%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 15:36:16 +0000
Date: Thu, 13 Nov 2025 16:36:01 +0100
From: Francois Dugast <francois.dugast@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Zi Yan
	<ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
	<rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
	<gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
	<dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lyude Paul
	<lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ralph Campbell
	<rcampbell@nvidia.com>, Mika =?iso-8859-1?Q?Penttil=E4?=
	<mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>
Subject: Re: [PATCH] mm/huge_memory.c: introduce split_unmapped_folio_to_order
Message-ID: <aRX62SR8NLps2NWH@fdugast-desk>
References: <20251112044634.963360-1-balbirs@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112044634.963360-1-balbirs@nvidia.com>
Organization: Intel Corporation
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|MW4PR11MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 81359804-ae80-4c57-832f-08de22ca61f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9RzFNzcSYofRj4nWTxl3mdS9+maiWmV9of4uCxuZtCFMR84m/p7PxOXV/4?=
 =?iso-8859-1?Q?XpDWo4paCGwRS7lD5LpQMunszRHk5v8sQ6k1ci/QBR8+GfMgv7Uji3Ux80?=
 =?iso-8859-1?Q?xU7b7/CF9HhdTgYdESZbrQMhPfNQZ8al1hNuqcsMqZtGVxvhDX/e1QVYgS?=
 =?iso-8859-1?Q?DduDaxNYeFih9zG1+tPENwHQW9exLJJlnw6Inu7wwLcyaec3VM3JHB1VAd?=
 =?iso-8859-1?Q?WB6BGLr8kVF7Qq8gxQX7/YSa1LWszkZ9sYumj2VWEVWFZR5nHZ+iLvSq34?=
 =?iso-8859-1?Q?4npBG1fCBOCEmoBhdyJ6IuS1CpP9+QrFCK3Y9QeE8hcSGYlz2AcsjKH3tK?=
 =?iso-8859-1?Q?quhEPt7NUKKZh6VPGp8TE3PJ8xqs9fqINk/TnD9J2Jt20WSprfRei6V5JZ?=
 =?iso-8859-1?Q?LRLQ5oU4TuF1NCC2wVB5KgQigw+ErhIr/+SxgB2nCfAzJ7UwYNNul88o95?=
 =?iso-8859-1?Q?beh+AN97wJgsgzJacIx9f/51iCLELdUeUMfoe/vQYdq8sJ6qqLS8KDhMZz?=
 =?iso-8859-1?Q?bl8qVdRhuXP6WxZjdePJMszCaW+Vc8zm/e+2QZnKIVDX/2OMs/Yq2jLeAt?=
 =?iso-8859-1?Q?AUcFt7jSECNCLi6X56sPPe0uv7y3/iQstwGaFMKakTbX8/QffdkZrZd3et?=
 =?iso-8859-1?Q?qz3U3oFkkihjDUK6aTkwa/Qzw2enC/SMcWdzvC9Rgg4MHqnByK3dNryXUc?=
 =?iso-8859-1?Q?mYqYlMc4hcMi6asOYnMqscZz/EUvxg7X7zz6NIGaGqC6bHVdrE0o0PDhGB?=
 =?iso-8859-1?Q?pWrsvEOafjK3L5sQDw+3OH8RIg8GFtUkz9LIFL9PWXuTVHuKSqiW+Zki67?=
 =?iso-8859-1?Q?nOGNThRNjVtFCyrusnedJjJzqqEl8EiA9LODESROm0raQpHAGFPkaFVw+A?=
 =?iso-8859-1?Q?D6e5WHJbWFmnsotEFDNlobmOAvNtTN8YyBGwl1njkYlbQ3cH6E6eF/NsUH?=
 =?iso-8859-1?Q?Z6zn1cr7Mqfy0UrIUpT57ytBMwZQomv+Ph3fpbGClue7svEf/Fn82e1dC4?=
 =?iso-8859-1?Q?eWAnrzbyCQpSDVlGtj0iQNfm4tQNVZW0k+i9ndSbYVlDwDpK54e22abhKv?=
 =?iso-8859-1?Q?4DQ3lX4py5RB92MKhf1dAi2ZywZo2QOG06dsjxDYNcxQgr2u+jlmrhBtz0?=
 =?iso-8859-1?Q?G+8QR74X5BZ0KZiUFTjh/JWWG03G2PYY8PI1xNO2IlVZHdGw8MXPfYgvQb?=
 =?iso-8859-1?Q?lxM3ZLvJlHBx4rT+SlydSKbCBvVN9c0fDAWHDECD+sO+NAGsH3wB4smBW5?=
 =?iso-8859-1?Q?HbvNYUIeX/egwwreNooTfQ+QG/uKkvolHZR/qOsmdr6udPl8NaSWX6rKa5?=
 =?iso-8859-1?Q?ukEfroDno2/wibbdSpRHTb7eMk7haaM5UOqqa5p182A4D3NVzWViltqjPg?=
 =?iso-8859-1?Q?4b5NcYCwau7lz4heLxblSqdtU276QBN1qLYdWlG1s66PUzG74pzQ78nH+A?=
 =?iso-8859-1?Q?KjNmDjZeUzU3g8yJh88U+t+GHdJnfhV0TdneHeSXCvNf0h9pjNQWOuS+Tt?=
 =?iso-8859-1?Q?YNmx00Oxrb1ijHAw35Wnmg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7828.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3IVlQ4NeK7td+7NDpeMTwbNW4HmPssavUcEKKyTEuS8UJyISRVKIb5e4xF?=
 =?iso-8859-1?Q?wxAZouURShuCiLgRHhp4LF33rg2oobmLyuzg6eO5W6uvoMvGkdI8fpit9R?=
 =?iso-8859-1?Q?yJbEQDu+65Yj+fGqOVsUFeCnWSpx2eu8bRlqp4zk8EK4c2dsQtP+JVbh9h?=
 =?iso-8859-1?Q?drpTppfL4B22561qv4daPBwhWeXS4rQxcnUfQmaYripFBIlHPuKOGAkps8?=
 =?iso-8859-1?Q?kzVPYqwY3qf0qyWUj8mRy7AIjnzeEiZqFNxVhdKENk2zRD53B60/baVpS9?=
 =?iso-8859-1?Q?BYSDs/9gWY0F3CUEqyQoFFe/SNa8QsU3agdmPcgwv+WdAUEJt1VYsfCuqS?=
 =?iso-8859-1?Q?jOM696CMICg+0qdVK9r7Bwt3WujC57XE65tESCaSyldH4c8GDJ2UpgczMK?=
 =?iso-8859-1?Q?BMuQWrgwY3KWI1kDuW+BT0udqFsgN+PkqU+O+t59oElaZ+HkvzLiCWi3DJ?=
 =?iso-8859-1?Q?yYn+PeQxNZomAmXm2Ruvbo34jPYodsTrhx5ApV4t0BBebqeVqyxuIiE+4O?=
 =?iso-8859-1?Q?EKE7UxV/8eFChEjaK9qd2XXWdz83Tv+O8PA4JI/OUg4ilHnWUkwunjOcvt?=
 =?iso-8859-1?Q?Cg3ylWEyObABqyd0l4HAJeQ+fn/r/A5wmkgpQ2DBF9ykABu3iRfxzInocO?=
 =?iso-8859-1?Q?xPrSma9Dfe0a1Wz+Q9ZDcdYfhk6wfal/DePXW3q9K+VrMoKJIWX9lYcnEu?=
 =?iso-8859-1?Q?enoaBCnRhmYodIdoNE0vMSXJCJnTulOHQgblM5M0IX0NFWnLzNtVHGR/Tx?=
 =?iso-8859-1?Q?KKJySVFY5CPjif+VqHpAgD55zfstTxs6cU3kQpGCMNVmgxMAaMQZ0ASnd0?=
 =?iso-8859-1?Q?djXTDeVUELxtfvEr+ppPklKJCDuZvrQ0j1rfHtJHbBZ4EjH7BxfN4Tx3Gb?=
 =?iso-8859-1?Q?zAcQvi0HYdmH2qqdHGWYOM8Lea4Al4ssP84xU4XSgu8bcR+URf014Nd1xU?=
 =?iso-8859-1?Q?K6o7v0OrjJqeRSz+Xo8AjrCzPnozFneiCMpqV0q+7+MBK89LNskQo1HuHg?=
 =?iso-8859-1?Q?kf5iDD9KNhDvZu4hgx1+doP55eEmLjdigkiS9JbyikLxCCAKO6QDsPyqkc?=
 =?iso-8859-1?Q?KiOXj3ouPBtWq1Frm3Wp24wQHDDcTIqF/gHQbbZVPkraB9RUmtMJ0EgQOU?=
 =?iso-8859-1?Q?6/32KR25XErP71KZG60ph/NbqJ1AkgMtP3zTKlx0u1jEbXxOtcYYtDjMZW?=
 =?iso-8859-1?Q?8pjkSP6fA0LaljVF3TihPXsvJmeExPeoCGNOEkJhxRN31Y+TJgs05DrqeT?=
 =?iso-8859-1?Q?j0geBSVe4RkKB02KIpfPJ08jmwXwRQ6CG+XEi83ecDDhS8WEZJf8sHqMLN?=
 =?iso-8859-1?Q?DFoHh9ylnf9KIpch+10Mf/zbCuOHiN+gkI9Q290F9Fu15EJD+EDR3l+KSj?=
 =?iso-8859-1?Q?nLDkki0W556TwzhbtfaTxnbRPNiB77mBWEeZDnhTftb2hrM/SUN55q/Tnh?=
 =?iso-8859-1?Q?nvFhbtfgGSn47tjvXWoTw3Sjgo6xdvpswCIm5BEt7VP7ZO8Re80MtmZygD?=
 =?iso-8859-1?Q?TU2+fiGaQP9AYV64sCDUUoDvNzwrAQDNSiwBFOZSpjZzNUhbUPQnhE/x4p?=
 =?iso-8859-1?Q?PlqcJA+wXtUiH/+mMq5xCDolz9LvrL5fF5HizRVpTETNSRgYqwFS4KBhpp?=
 =?iso-8859-1?Q?XAAqmgjlUJ6kAwONA2Qfw2/bJ588O78BD+OQwVThIw/4kcHi93CaUSVA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81359804-ae80-4c57-832f-08de22ca61f5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:36:15.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgH8eKMPx2hjTvwW4T/H437oHxH8xI8pVi0CZJSY7aplUEBFgej5ugB/YxiS9wSGPj8ho5TAwY08rJMgyGcJy1J6WQCD5AObpkh7GIJO3A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com

Hi Balbir,

On Wed, Nov 12, 2025 at 03:46:33PM +1100, Balbir Singh wrote:
> Unmapped was added as a parameter to __folio_split() and related
> call sites to support splitting of folios already in the midst
> of a migration. This special case arose for device private folio
> migration since during migration there could be a disconnect between
> source and destination on the folio size.
> 
> Introduce split_unmapped_folio_to_order() to handle this special case.
> This in turn removes the special casing introduced by the unmapped
> parameter in __folio_split().

Such a helper would be needed in drm_pagemap_migrate_to_devmem when
reallocating a device folio to smaller pages.

Could we export it (EXPORT_SYMBOL)?

Thanks,
Francois

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> 
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  include/linux/huge_mm.h |   5 +-
>  mm/huge_memory.c        | 135 ++++++++++++++++++++++++++++++++++------
>  mm/migrate_device.c     |   3 +-
>  3 files changed, 120 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e2e91aa1a042..9155e683c08a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -371,7 +371,8 @@ enum split_type {
>  
>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>  int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> -		unsigned int new_order, bool unmapped);
> +		unsigned int new_order);
> +int split_unmapped_folio_to_order(struct folio *folio, unsigned int new_order);
>  int min_order_for_split(struct folio *folio);
>  int split_folio_to_list(struct folio *folio, struct list_head *list);
>  bool folio_split_supported(struct folio *folio, unsigned int new_order,
> @@ -382,7 +383,7 @@ int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
>  static inline int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order)
>  {
> -	return __split_huge_page_to_list_to_order(page, list, new_order, false);
> +	return __split_huge_page_to_list_to_order(page, list, new_order);
>  }
>  static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0184cd915f44..942bd8410c54 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3747,7 +3747,6 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>   * @lock_at: a page within @folio to be left locked to caller
>   * @list: after-split folios will be put on it if non NULL
>   * @split_type: perform uniform split or not (non-uniform split)
> - * @unmapped: The pages are already unmapped, they are migration entries.
>   *
>   * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
>   * It is in charge of checking whether the split is supported or not and
> @@ -3763,7 +3762,7 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>   */
>  static int __folio_split(struct folio *folio, unsigned int new_order,
>  		struct page *split_at, struct page *lock_at,
> -		struct list_head *list, enum split_type split_type, bool unmapped)
> +		struct list_head *list, enum split_type split_type)
>  {
>  	struct deferred_split *ds_queue;
>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> @@ -3809,14 +3808,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		 * is taken to serialise against parallel split or collapse
>  		 * operations.
>  		 */
> -		if (!unmapped) {
> -			anon_vma = folio_get_anon_vma(folio);
> -			if (!anon_vma) {
> -				ret = -EBUSY;
> -				goto out;
> -			}
> -			anon_vma_lock_write(anon_vma);
> +		anon_vma = folio_get_anon_vma(folio);
> +		if (!anon_vma) {
> +			ret = -EBUSY;
> +			goto out;
>  		}
> +		anon_vma_lock_write(anon_vma);
>  		mapping = NULL;
>  	} else {
>  		unsigned int min_order;
> @@ -3882,8 +3879,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		goto out_unlock;
>  	}
>  
> -	if (!unmapped)
> -		unmap_folio(folio);
> +	unmap_folio(folio);
>  
>  	/* block interrupt reentry in xa_lock and spinlock */
>  	local_irq_disable();
> @@ -3976,8 +3972,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  			expected_refs = folio_expected_ref_count(new_folio) + 1;
>  			folio_ref_unfreeze(new_folio, expected_refs);
>  
> -			if (!unmapped)
> -				lru_add_split_folio(folio, new_folio, lruvec, list);
> +			lru_add_split_folio(folio, new_folio, lruvec, list);
>  
>  			/*
>  			 * Anonymous folio with swap cache.
> @@ -4033,9 +4028,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  
>  	local_irq_enable();
>  
> -	if (unmapped)
> -		return ret;
> -
>  	if (nr_shmem_dropped)
>  		shmem_uncharge(mapping->host, nr_shmem_dropped);
>  
> @@ -4079,6 +4071,111 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	return ret;
>  }
>  
> +/*
> + * This function is a helper for splitting folios that have already been unmapped.
> + * The use case is that the device or the CPU can refuse to migrate THP pages in
> + * the middle of migration, due to allocation issues on either side
> + *
> + * The high level code is copied from __folio_split, since the pages are anonymous
> + * and are already isolated from the LRU, the code has been simplified to not
> + * burden __folio_split with unmapped sprinkled into the code.
> + *
> + * None of the split folios are unlocked
> + */
> +int split_unmapped_folio_to_order(struct folio *folio, unsigned int new_order)
> +{
> +	int extra_pins;
> +	int ret = 0;
> +	struct folio *new_folio, *next;
> +	struct folio *end_folio = folio_next(folio);
> +	struct deferred_split *ds_queue;
> +	int old_order = folio_order(folio);
> +
> +	VM_WARN_ON_FOLIO(folio_mapped(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
> +
> +	if (!can_split_folio(folio, 1, &extra_pins)) {
> +		ret = -EAGAIN;
> +		goto err;
> +	}
> +
> +	local_irq_disable();
> +	/* Prevent deferred_split_scan() touching ->_refcount */
> +	ds_queue = folio_split_queue_lock(folio);
> +	if (folio_ref_freeze(folio, 1 + extra_pins)) {
> +		int expected_refs;
> +		struct swap_cluster_info *ci = NULL;
> +
> +		if (old_order > 1) {
> +			if (!list_empty(&folio->_deferred_list)) {
> +				ds_queue->split_queue_len--;
> +				/*
> +				 * Reinitialize page_deferred_list after
> +				 * removing the page from the split_queue,
> +				 * otherwise a subsequent split will see list
> +				 * corruption when checking the
> +				 * page_deferred_list.
> +				 */
> +				list_del_init(&folio->_deferred_list);
> +			}
> +			if (folio_test_partially_mapped(folio)) {
> +				folio_clear_partially_mapped(folio);
> +				mod_mthp_stat(old_order,
> +					MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> +			}
> +			/*
> +			 * Reinitialize page_deferred_list after removing the
> +			 * page from the split_queue, otherwise a subsequent
> +			 * split will see list corruption when checking the
> +			 * page_deferred_list.
> +			 */
> +			list_del_init(&folio->_deferred_list);
> +		}
> +		split_queue_unlock(ds_queue);
> +
> +		if (folio_test_swapcache(folio))
> +			ci = swap_cluster_get_and_lock(folio);
> +
> +		ret = __split_unmapped_folio(folio, new_order, &folio->page,
> +					     NULL, NULL, SPLIT_TYPE_UNIFORM);
> +
> +		/*
> +		 * Unfreeze after-split folios
> +		 */
> +		for (new_folio = folio_next(folio); new_folio != end_folio;
> +		     new_folio = next) {
> +			next = folio_next(new_folio);
> +
> +			zone_device_private_split_cb(folio, new_folio);
> +
> +			expected_refs = folio_expected_ref_count(new_folio) + 1;
> +			folio_ref_unfreeze(new_folio, expected_refs);
> +			if (ci)
> +				__swap_cache_replace_folio(ci, folio, new_folio);
> +		}
> +
> +		zone_device_private_split_cb(folio, NULL);
> +		/*
> +		 * Unfreeze @folio only after all page cache entries, which
> +		 * used to point to it, have been updated with new folios.
> +		 * Otherwise, a parallel folio_try_get() can grab @folio
> +		 * and its caller can see stale page cache entries.
> +		 */
> +		expected_refs = folio_expected_ref_count(folio) + 1;
> +		folio_ref_unfreeze(folio, expected_refs);
> +
> +		if (ci)
> +			swap_cluster_unlock(ci);
> +	} else {
> +		split_queue_unlock(ds_queue);
> +		ret = -EAGAIN;
> +	}
> +	local_irq_enable();
> +err:
> +	return ret;
> +}
> +
>  /*
>   * This function splits a large folio into smaller folios of order @new_order.
>   * @page can point to any page of the large folio to split. The split operation
> @@ -4127,12 +4224,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   * with the folio. Splitting to order 0 is compatible with all folios.
>   */
>  int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> -				     unsigned int new_order, bool unmapped)
> +				     unsigned int new_order)
>  {
>  	struct folio *folio = page_folio(page);
>  
>  	return __folio_split(folio, new_order, &folio->page, page, list,
> -			     SPLIT_TYPE_UNIFORM, unmapped);
> +			     SPLIT_TYPE_UNIFORM);
>  }
>  
>  /**
> @@ -4163,7 +4260,7 @@ int folio_split(struct folio *folio, unsigned int new_order,
>  		struct page *split_at, struct list_head *list)
>  {
>  	return __folio_split(folio, new_order, split_at, &folio->page, list,
> -			     SPLIT_TYPE_NON_UNIFORM, false);
> +			     SPLIT_TYPE_NON_UNIFORM);
>  }
>  
>  int min_order_for_split(struct folio *folio)
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index c50abbd32f21..1abe71b0e77e 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -918,8 +918,7 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
>  
>  	folio_get(folio);
>  	split_huge_pmd_address(migrate->vma, addr, true);
> -	ret = __split_huge_page_to_list_to_order(folio_page(folio, 0), NULL,
> -							0, true);
> +	ret = split_unmapped_folio_to_order(folio, 0);
>  	if (ret)
>  		return ret;
>  	migrate->src[idx] &= ~MIGRATE_PFN_COMPOUND;
> -- 
> 2.51.1
> 

