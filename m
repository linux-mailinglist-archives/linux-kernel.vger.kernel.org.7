Return-Path: <linux-kernel+bounces-836353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E77CDBA973A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BEB1921235
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4C83090C4;
	Mon, 29 Sep 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghkSp9y+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA021A9FBD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154236; cv=fail; b=GSLu9J+SA6bVvc7dCOAIHfcXksjhf1CnxvTp8I+EbTvu7ASCZR3PZZQaN0uKsH7tteS+J4S9MHMtAowN0hRr89q0oGXWcvfZZfG5Z40i6qJMl40sZCg9RJ/2bRHhXN5SkswCeFBYNkW1uDIhjM87mnBB29p4Av89jmdLESUJVUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154236; c=relaxed/simple;
	bh=cUba1FILSUISUOHegsoKJE5Np7iCJxev5ojQrlQknlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kVwvgbeeMFhyQsDhS19NH3eVdTS8/d4K8Pf9feyf7rwOtYLvPpQej/0O93oEfIrEO9lglqZHVVUiYo4fPGJt0m9S4j2T9CRjo2C69CSgaT48SwiVAxQzf75epdTYwpXmGhnd2nVAIabcEebabjtmC0tdu9moM51Tf0EPOm1o2S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghkSp9y+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759154236; x=1790690236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cUba1FILSUISUOHegsoKJE5Np7iCJxev5ojQrlQknlg=;
  b=ghkSp9y+knwoBZNTiurEMvtR9MCg22OYRCczLSZ190k5TkIY2AihOQT4
   WoDW2BmJI1P2LUXIAAj+N5bHLWCZ76HAJB7MYVuDX5q/3WiaBwlwwBuuX
   oG/AyFqxZesCh8Ofzb+1ui+ElWxQfI67nIlRy5Xt1L+Pcrr4Mm8fhK65/
   5pXenJZZSsGyUylIKSkcA0RtnkcuSMB3FYHcfvBhdQp+PDcfbRdF8z5Tk
   alxmN9dTWSGwcDY3wANJTUWa3kMzZDLZeRarxK9QeCh4X9/0MYfA/20ZH
   VLIRFOGk4zRgdVUt82G1I5q5hLg/q+XiBqr8bPoX6v5ZcJ8pHVa50oXUS
   g==;
X-CSE-ConnectionGUID: colMT0DHRWyEOVX2HHN9Zg==
X-CSE-MsgGUID: 9DhBHKaGTsmhVtl7b1muJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61305238"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61305238"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:57:15 -0700
X-CSE-ConnectionGUID: KyQJjHvZTUqLcqbr1QK11A==
X-CSE-MsgGUID: HFxYEb7/RzmSttSnFVw8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="178622005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:57:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:57:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 06:57:13 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox893ud17ABU1El0F1citd1NK01/6Z1Ed1VWIAxNEpysXV0qBqKCwNSOO61Fc5QW0OI4iToNlHtlQSyPLkMlhWDHQ8JgtTqxw6423FtBwd1NBHX00zJDuA99xZBURnQPBFiTU+NqnGW0nCwOQhiAagDtpUEl/ty79sCU/Ed2Gfc1E8m1wfxCP4VpNQ5N0vbdCrZ/G/ORxA8ZjiR+1R8iwNvtllOuJAMeisBX5XcZBetaXh8Frqd6JKZapobAdgzGrg9PH3+e0KtK5swEL8yXrvZhA9lIuXGfG9CGoKBw6nmFKKAet4o3MeePD6o8x6s+O/a/IGAD5qCk7MPYoTNWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUba1FILSUISUOHegsoKJE5Np7iCJxev5ojQrlQknlg=;
 b=m9DSC6MU4c5Nc2IBqPOf4/RmHihDMItC7W8PvKfcILlKG+jx2v0fJIH8+LeOxIH0fYEGJVx+/4Uifpvl2EXchU8pXHKScPN5Gnc6MelQiKXLHej0YfxDpGjf+2J3H3uLkDQIC/2HVskkPf42+nRaKOwILN77qiqulXvKLaQe0VnzT420vOrOHnX90K4Rqy+7fmF7Aet3XJD9O07CfoU0rv2OQuh2PJUXHT7zgYwrqYY9owK1XgawvhR/V5B0yRsZNtiCs55aHBlxsPsI/uIG9P8UG/gMyUtLHfGW3ruG8Ld7UPAWwi7aqjxbV7/pXxXwC3K621Itm/kwQFbdw+DiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 13:57:10 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4%5]) with mapi id 15.20.9094.021; Mon, 29 Sep 2025
 13:57:10 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Jiaqi Yan <jiaqiyan@google.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Luck, Tony" <tony.luck@intel.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "npache@redhat.com" <npache@redhat.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "baohua@kernel.org" <baohua@kernel.org>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andrew
 Zaborowski" <andrew.zaborowski@intel.com>
Subject: RE: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Thread-Topic: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Thread-Index: AQHcMChLk4bOL1ruf0K10LKRmZ1XGrSpJMYAgAD0XwCAAALGoA==
Date: Mon, 29 Sep 2025 13:57:10 +0000
Message-ID: <SA1PR11MB71306ECC0662B9A952EA3534891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
 <5f117b73-8d7b-b233-a0a8-2a29ea6312a8@huawei.com>
In-Reply-To: <5f117b73-8d7b-b233-a0a8-2a29ea6312a8@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|PH0PR11MB5205:EE_
x-ms-office365-filtering-correlation-id: d1982e0c-a8e9-4cf3-5b34-08ddff6015c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bDRXVzlld2IwOWp0VEp6QWE1UzBQV2JEVmhlQnRTUzNwVit5VXpUNEM2Vngz?=
 =?utf-8?B?RE5KallGTWVqQ2J3WWdqL0hyNlE4QVBlaG1qcnF3b1hpL0VSY01vS21URi9R?=
 =?utf-8?B?eHQrcjR5elU3emtOOEdrQkc4eGtNQnNDY3I4RkhQK1RvUjY4dHJocGZZZmIw?=
 =?utf-8?B?K0NQclZNTUZiUTdTcGx1cEVuWFhIUEhBUS9YdVNrWUFXNlZMSFdwcE5GY1FR?=
 =?utf-8?B?VFkyR2F1UmM1ZEtWZUdpM2NYWWFxS2FzSDJqQlpIcWF3dTFBY2RBQXFQQW1M?=
 =?utf-8?B?TjZCMy8xM3VmY1dRdTZNS1BOdVZxNkRFc3ZJVStNakh5N1pzVXpWK2gyOEds?=
 =?utf-8?B?TWlab3VCL0pwb1FIa0hHaTlNMHE1WlVuK28wNlhPN2c2YVhhdE03T1crRjdz?=
 =?utf-8?B?MFJsZEdHd01HWE9kNVowb3d0Y0lLZ1dIZkxjbFBWZDNxWGszRDAxejJhenls?=
 =?utf-8?B?dHZDQ21BN1dMbTI5RzhneXd3SG1YUGNSSk02VTEvNkp0R1lqRE5vbkx0eDE1?=
 =?utf-8?B?Titrc1BkdHVUVnJ4U2RFWllKV1BNN2pkWWFMSTVjZFNoNnM1Si9LTko2NHVy?=
 =?utf-8?B?dVVpREl1R1d6Z1k5cWZPSTd1VjVsRThZdDBVekRUUFBocjhDdHQxWUdnNjdm?=
 =?utf-8?B?UHlhY1dXU3puazJ3NGloYWU3ZCtnQW1vbGZiOStVeUJ5UXlQNVA1TDZaUHlO?=
 =?utf-8?B?V2k1Zkc5eGswVjhIM25OMWp5ekg0aXpRSUJsUkdzQVJDYlJNNTZ1WXZ1ZUZL?=
 =?utf-8?B?UHNCR2ZIS2VIeXhQRjJNbTZoWVlhT1RSWEhZM0Iyd1RGVGFMTUdwZWRvTG85?=
 =?utf-8?B?bk5BSm9GZFp5eC9JMmVQNG52L1dMYVRtQ1VFZkJuQ0xUK1RxUVhNZGZQeUlm?=
 =?utf-8?B?QmdmczMzWnJVVVptdjc4SHpVdDBlcTdPUGZnVFBVb1FFeFNKL29id0hCL1Uw?=
 =?utf-8?B?L3hLTzZVYVlQWlgrT2NvTksrWXM1OFBLdHpqcFVCVE1YMmlOMjMxSUtic1o1?=
 =?utf-8?B?dXIwUEZVWjU3VVBrUmRHZEVtSTRFTnpKZHlMNDluLzBSM1JVZkZ6V2lxYlhT?=
 =?utf-8?B?ZkZ6aGR6U1FHL216RWdscnk2aEcwTkJ2RjBCaWpOVFZGZXB1cGxTN3Q3eENm?=
 =?utf-8?B?SW1qa1hESktrejU1NTRiZnUvZFg2Qkxrc0tFelN1TW45a2x3RmNteWVpSURH?=
 =?utf-8?B?K00yTmpLcHE4dTN5UEo0TkJmdGovNFlhalFjK1hYYlZiY1puamE3QWJUZjlL?=
 =?utf-8?B?NTFPNjAwUkdhU1dhcnlraGt1MHdLWktxM1dxNmpNUWpvaHhhdkRGNFVDekov?=
 =?utf-8?B?TEVRc0dxTk5rcEJKUG5EdXVzL2xCMk83NERMRnNhTDBVQnVhUUNTZG9CME5P?=
 =?utf-8?B?eTVzMW1sZWI2ejNYbkhuOGdSZ1pWcGNuamc1WG9iUjdLbnpxV0RLc3BMVTN5?=
 =?utf-8?B?djNhL29iYmFRQnJKM00yeGFWU1RLWE82Ny82Sk1xdjZha3g1bER2MHFiMzlY?=
 =?utf-8?B?Q1lrQ1k4bTdxUTBtdldqWEFoWGFTTVZvLzBEeVZzQVpPeEtUZW5DWUpHTDFp?=
 =?utf-8?B?VE53SzhWNS9SeTFCOWQvOFcrL1VLUStZN0lOSDBrTnRjUXZ0Y1l6eEtZRW0v?=
 =?utf-8?B?WW1EYnBMNG9tODZWWDZNTjZ2Wm9NamNKR2Vwb3BNeXJpcWtzdWRDd3ZQTWxz?=
 =?utf-8?B?ZGlPU3NpakpuSll5VW1HUHdLUGFTSENjd3VDWENha1BCS3ZhWWNMVWhiQUtY?=
 =?utf-8?B?SDVlTUZ4aktpeXkzb0czVDRPVlNXY2Jhb2xqbUlVNU9BSHNidTVyUWcrRlJI?=
 =?utf-8?B?Sjk3TEFEMUMxbzBkdGFTa1JHbjEzalFzdWdFMnRuQmpKZ2d6SnMzbjA1ZWtE?=
 =?utf-8?B?N0NxVm9KYmIwQlVYL2JEVnhIcEhPaVBVbW5xT2xZVGJWTXlsU2gyRDdaRnFB?=
 =?utf-8?B?TEZVVlo5Q0dNdCtQRlY3aDRiei9SZGI0c3FRc0JXQXU3NlRFWHpGR0IwMVVR?=
 =?utf-8?B?dDJBbURpdkl1WkUyOTFtVG9RUEIyODA3SklNT3JMVDZmUkg2bkZiS3daZVZu?=
 =?utf-8?Q?WfSp+q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVpMFNLM3NwYVAxUkFYNUUrUitDRVovbmlxRDFFRlM0aWl3R2JSMElhOWJS?=
 =?utf-8?B?SVpUdTVuUkVnb3pDNy96VGliYiswaXkxbW0zMlVZbmdYWTVUdC9aWDZ4clFL?=
 =?utf-8?B?QkQ5U1d6K0VpOXR2Z1N1VHhIbjNySmRvMjZQTU1OL1NrOU1JdzBaT3lZWDhZ?=
 =?utf-8?B?anV6Q3BqbmMySUs0azJTRTZNSm5YeHhaZWgrUjJKZjRmU2dSZzVHWTloeDE1?=
 =?utf-8?B?VjRTdGtOK3RjUVhCVG5yMFZqajFkL2RqKzJ2aG1NUitoM3ZsZkdTamhsN0Z5?=
 =?utf-8?B?M1RCMUk4cWZzUzBFTFpGbXhoRTVKcmNha3Q2Z0tqYThDQUZhQ2I4YWFWaGFq?=
 =?utf-8?B?VEhjdC9zRUx1YzJkK0lHUGg1bWMyeWRxeGFkcGFkVnFFdTZDVVhGbWtieHcy?=
 =?utf-8?B?a0lkcFVHSDR2Z3d1S3VONFFJd3dxUnpwaDdsKzhOTE5Mb3VMRHhOaXRjMjAz?=
 =?utf-8?B?aHM0Rnk0bW9BeGJyb3pQTktGV251MjkxR0ZRT21KMHBEVVozWmJvYlBLQWdy?=
 =?utf-8?B?eC9LR3BndUtoMFkrRFZaL1VuWUJ0RDh0T0JvMU0yNUQvbVVkMUxGbE1sY3BG?=
 =?utf-8?B?U3BvOXNrakdHOGNYdzRsMnMxMHZZNURLYmhSWENJY0luZ1JHRDAwSzd1RFVw?=
 =?utf-8?B?K20rZVVTU3lpTWtsdDNMRG9DM01rYjdTV0I3dnVhYmdOYUNTaUtIZ3JPVXJT?=
 =?utf-8?B?SFJJM09QazhOMm9vRVBQQXFOSDdDN0ZNYUh6d0RDR1huWkFKNmMzcDRUcVRx?=
 =?utf-8?B?cXlHeS9MOGFIZDQvcEpMc1dxQUtYVXpOUmtBOE9hQ211aU5PVDRYUGhuY3pv?=
 =?utf-8?B?QXVnSHZHNzFpTTRLSjhIMUlQK1R1Y0dRWGFvUFFLRldIREdTOERxYnFTRWRR?=
 =?utf-8?B?QWl2QVhGZmxpTWl4aHJTRDFBRktnSTVrQXNCZiswcTRqald4a2VNNlVTSmF1?=
 =?utf-8?B?WGZ5UVBPWXd0U0g1cU5RZ2FScXFKUFNpR1o1L3R1ckIvRFZmMlVPOVE0TFB1?=
 =?utf-8?B?UTNrdlgrMnlma0lEajl6enNZUmcyYS91aXNzRks3OWNqOXEvZkM3cUJuUzRa?=
 =?utf-8?B?WjZwVlhGL3VtQWtFV29pczQvOVJ2Z0Fsb1pYVEJ3M0tZT0NMc0tTNFNiaGp5?=
 =?utf-8?B?UlErelk4YUkvczJrbC9BeFd5Yk0yZGV1LzJ5ckE1VjhneGpYeWdpT0xSV3px?=
 =?utf-8?B?QmMvNUE3ZktRRXVSc1hpYWJVUG81NTdnaFlvazJuNkdRcUhGVkpXU1ZJNTNS?=
 =?utf-8?B?YnpTR012djFYTHErV21kYzFaVCtUNi8vQkV5Ly8wRy90VUVqSlNseHNndVdz?=
 =?utf-8?B?THg1d0JSRjB6a1RMY1dDQTlXKzNTVmxJeWhrU1o1d2hVSE9tWGVXNVNUcUVJ?=
 =?utf-8?B?Q3NldWV0V2xUdHhGSGN4Rm4vWnk2b05Ma3EwUGlSRWw4dkNqTHJGQll2eHlo?=
 =?utf-8?B?Qk4zQXdGYWNqUlhWSzFwNTYwaS80OXBwVmVzWitUaGtVWjNLSmJGWHNLVVRz?=
 =?utf-8?B?Z0wzdUZMbzhiNDYyYWhzWGl3WlgyaFRXcVFUNy8zNEZYQXErUVhyNXhtMVpP?=
 =?utf-8?B?NnAvREhRTHE3Wm11akcwM2tQdWJ2WEtDNXhpOFdaZko4SUNDMzhNTEQyNHdp?=
 =?utf-8?B?cWVRaHVTWVQrUTdPVnI3VGFBVzZ4WTJIZmZoa2F2eEVlSnMrOVp6ZXEwdHFJ?=
 =?utf-8?B?QWdUdk5DTFk1cVZtNzMvTHp6emZCRXBNenE5Zkw2MHdXeWlqdExNenk0cWNQ?=
 =?utf-8?B?dEp0dS9Bby9HcklUYldzUUdCNEtQOFZmM1IySi83ODh2dk5KcC9MNWhsNHBF?=
 =?utf-8?B?REZMRmNqTGEyRkd3cEhkc1lla1JmWldpVkFCV1hJcHhuZFRnNUxueGh1WXdZ?=
 =?utf-8?B?K1NSS0hQM05LMEswVFBXUTUydnI4L012WGVXRU1IVEduQnA0OWl0dWpmK01s?=
 =?utf-8?B?Y2FMNVlEM05rMFRubFVLcEV2UFNjZTZmaWE1OTRld2U5UGNpUlI0dE1FajlM?=
 =?utf-8?B?dnlLeWU1N0E2NExPekZwOWlSVXFjZlllYTVmRW9uMXYxMEhBbld3TE5GOUdQ?=
 =?utf-8?B?QitDL29rSXpZeTV5WlN0ZlZSaTRhdy9HWmo3a2lndENNWjJmMlhCSXNHT2t3?=
 =?utf-8?Q?o5/Bx6hCddeptJnYZ41Frs6ZE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1982e0c-a8e9-4cf3-5b34-08ddff6015c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 13:57:10.2717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1oOAwB3XwxcnfFRPMwXZc+oOmKAmsei4pPhwJ+fhcXXansf+7qH6mXBXvFgWQ+/YFjT5eqM9vGlE/Rs2jSBwAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
X-OriginatorOrg: intel.com

SGkgTWlhb2hlLA0KDQo+IEZyb206IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0K
PiBbLi4uXQ0KPiA+PiAgIEZpcnN0IE1hY2hpbmUgQ2hlY2sgb2NjdXJzIC8vIFsxXQ0KPiA+PiAg
ICAgbWVtb3J5X2ZhaWx1cmUoKSAgICAgICAgIC8vIFsyXQ0KPiA+PiAgICAgICB0cnlfdG9fc3Bs
aXRfdGhwX3BhZ2UoKQ0KPiA+PiAgICAgICAgIHNwbGl0X2h1Z2VfcGFnZSgpDQo+ID4+ICAgICAg
ICAgICBzcGxpdF9odWdlX3BhZ2VfdG9fbGlzdF90b19vcmRlcigpDQo+ID4+ICAgICAgICAgICAg
IF9fZm9saW9fc3BsaXQoKSAgLy8gWzNdDQo+ID4+ICAgICAgICAgICAgICAgcmVtYXBfcGFnZSgp
DQo+ID4+ICAgICAgICAgICAgICAgICByZW1vdmVfbWlncmF0aW9uX3B0ZXMoKQ0KPiA+PiAgICAg
ICAgICAgICAgICAgICByZW1vdmVfbWlncmF0aW9uX3B0ZSgpDQo+ID4+ICAgICAgICAgICAgICAg
ICAgICAgdHJ5X3RvX21hcF91bnVzZWRfdG9femVyb3BhZ2UoKQ0KPiA+DQo+ID4gSnVzdCBhbiBv
YnNlcnZhdGlvbjogVW5mb3J0dW5hdGVseSBUSFAgb25seSBoYXMgUGFnZUhhc0hXUG9pc29uZWQg
YW5kDQo+ID4gZG9uJ3Qga25vdyB0aGUgZXhhY3QgSFdQb2lzb25lZCBwYWdlLiBPdGhlcndpc2Us
IHdlIG1heSBzdGlsbCB1c2UNCj4gPiB6ZXJvcGFnZSBmb3IgdGhlc2Ugbm90IEhXUG9pc29uZWQu
DQo+IA0KPiBJSVVDLCB0aGUgcmF3IGVycm9yIHBhZ2Ugd2lsbCBoYXZlIEhXUG9pc29uZWQgZmxh
ZyBzZXQgd2hpbGUgdGhlIFRIUCBoYXMNCj4gUGFnZUhhc0hXUG9pc29uZWQgc2V0LiBTbyBJIHRo
aW5rIHdlIGNvdWxkIHVzZSB6ZXJvcGFnZSBmb3IgaGVhbHRoeSBzdWItDQo+IHBhZ2VzLg0KDQpH
b29kIHBvaW50LiANCg0KRGF2aWQncyBzdWdnZXN0ZWQgZGlmZiBpbiBhbm90aGVyIGUtbWFpbCBj
aGVja2VkIHRoZSByYXcgZXJyb3IgcGFnZSBpbnN0ZWFkIG9mDQplbnRpcmUgZm9saW8uIEFuZCBJ
IHRlc3RlZCB0aGF0IGRpZmYgYW5kIGl0IHdvcmtlZCB3ZWxsLiAgDQoNCi1RaXV4dQ0K

