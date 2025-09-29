Return-Path: <linux-kernel+bounces-836502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDACBA9DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACF41C51DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9C30C0E8;
	Mon, 29 Sep 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TspEocWZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35C30BBAC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161117; cv=fail; b=Y3lHQ7TAoARNOV1Ia/yUrGiQRYDIyIjbPUHrxe8SNrxZmuNM33QUHho/R4IyYdNP1LT754rMlnDaziiNAre6/XdqeP2UvlEUz023x4gBbcrDavkZf6IbojtR09sOIW0bchpBk57f3drElg6ediYGaRYn5WmocDR9o9Jsc0UPisM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161117; c=relaxed/simple;
	bh=CdmNahQ4UrJZJIVK5kYs1Xc+EfC4V6YIKpp/e1OTUaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kec4zPIwT2t0Bz34mrXiYZ1WI1HXl2UMImaiupZltkoqFnPEj5q0bCUwSjx3cDflchGoqMSWZ2zE+jM7PBPJBO0K6FFyuX6W+3wpuBZ2R3MOO6bThRvIj4oglY191Turm6NfcYFdN10WUZo/+Wr+nV0PJq07M98dyx13Xtlgej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TspEocWZ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759161115; x=1790697115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CdmNahQ4UrJZJIVK5kYs1Xc+EfC4V6YIKpp/e1OTUaM=;
  b=TspEocWZ8tBr8IvvcKPOyTFmILkh6USXbBXxx+Oyfa1X3lf7IVZvbD3L
   SnQ++hWuv5J8RPPpxkEXjXNAnZ+TQi2gJUnMD7qPIwRBuGjdYlmv7rOrs
   g9Y5mg1Yo3+kO8wYRGWtAKnXAPq6vnhE+pk/MGoZGUgR641LSECe/bzrq
   O/lJw1o/37w1azQyi+DFdJfSSgA2XrlZcTIV7KjYuXIpmXprksekjb6Hl
   t9RF2ULOsDEmIlidRdSZsMK4t4vS2w4PthCV/pbc41VaYQ9li82wTCuq3
   eAzP6SLtbL13+PfSsd+EaJU9B6km6c/MzIF5ulXdVU/4fxNz8AjOq6TD8
   Q==;
X-CSE-ConnectionGUID: FFMcPzYyT2GPKDh7+zdbAA==
X-CSE-MsgGUID: IsHtnsUjRmuPGNi8YEg83Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61360283"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61360283"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 08:51:55 -0700
X-CSE-ConnectionGUID: c9ZCe8izTvqg/oPSkebPmw==
X-CSE-MsgGUID: CIRA7Ip0RBOlWne7CAiurA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182550490"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 08:51:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 08:51:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 08:51:50 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 08:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fsowi+k5+hEBjx8nvb0nvqegZd0A/YUXxj1oCJLk8d+lzgAHr7G/lsPCq+OKqXhcTKyfIgTILnIs3d9lmMch/L1k2cSkpNtv/CTctad9R2KTTDmgEsRW5IGi4x2KzZIJ1nzZdpmRtVkS140Bm8Gq4PMfBnsW8tSUHHQ/i42qrkVPEtk8xGHk/v3jwrWm5GyZPYs8PLzQVzGLQ892ouCZw2GhpRQXkK0RgCszuRmR2vLaoUllyKVLRPimM1aKZ+uBN8k9OLpqgxNipAH+KpH5jc37CWawEOUKU7HdW1ffMMyoufik4ec1anI6MOJndNdHNrp1ijCB8GVv640pFnZAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdmNahQ4UrJZJIVK5kYs1Xc+EfC4V6YIKpp/e1OTUaM=;
 b=BckiIKuT1nuJtINWFGnrUnGv2Qe2QySJd5Jxrfq1tBo1tF3lKWZzvJgKCM4lmJG3Y3lsVDmHrlSL46vXHbRp8sbBaNgmRFwKlqknXHwpNEIF+Utsg5ye/hpifrorBk+mHozsfNgvaDQATDrbl2OBTT8LQ3f/P1DB5N8uAJdC/N2pF4kM02PAaAnAr2jtdvQSsbE2+lhavgsm3Y9WnmUQ/1r9S7s0q4vlX9p2/RNooNGPO0ujIJbWlnQrik++qlQzN4sznRZ04DsvYoZlNrmelPSqxLJ6q8kntsMS5zvAyUqHpX5qoxzIPK4SLv2mN9ApVoNIWEN9p0dsWksmKnsD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 15:51:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 15:51:46 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Jiaqi Yan <jiaqiyan@google.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
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
Thread-Index: AQHcMChLppgCCg29YkOuttB3Zu2gW7SpJMYAgAEEnoCAACcP4A==
Date: Mon, 29 Sep 2025 15:51:46 +0000
Message-ID: <SJ1PR11MB608350E5169EE77F86A51E2FFC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
 <SA1PR11MB7130ABC25E060D2CC4749E45891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB7130ABC25E060D2CC4749E45891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5029:EE_
x-ms-office365-filtering-correlation-id: c9814278-43a8-44b7-de57-08ddff701855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y1FrSXpRVUE0elh3OFRMb1FSa2hlenZIbTUyd0x2bzVudTg1SjZXRVF1dm1M?=
 =?utf-8?B?dlVjZ1U5NUtJY3RZY1EzMGVUMUowci9KbHozQ1AvR2hEQ3hMVWJiaVBkZ3p2?=
 =?utf-8?B?aWxSUWZsRm9PMG55VEZQYVR2U1U4T3Z6M1BYUW1kVUNvNzVISDBHUmZvcFZs?=
 =?utf-8?B?eTB3VTM5bmM1YUFOU0FiN3NvcU1mNUplZTFsSDhNTWFvUnJXQVVoU1dYTThP?=
 =?utf-8?B?YXpVck9GK3hvZzYxcmRELzg1N3k4czN3eUZtaU1tNHhCeTltTUx1eEYxeFNj?=
 =?utf-8?B?ZHFFMUkxRFdUdmRoOGErcG40SFV3WGsyelhGdGd6R2JZY1B0WWxBV2RDMGxP?=
 =?utf-8?B?VFVidW5FN05memp6eVNjalBlYWZ5eFR2YnJMM1VsbkUyd3hpY1h2K1ZDMXVX?=
 =?utf-8?B?bittdnU2Ukd4R3BNN1JLa1lMdVZaY1JjMCt3ak9IbWxidXpadnJQU2U0dFNx?=
 =?utf-8?B?RGdJYnJsVHVTallDcGZCT3ljUXlJbWtmVlluVmpHcVlyWFVVVyt2aVZIaERj?=
 =?utf-8?B?SzM1c2FRZEFPa0tHMzM0N1YxS3pwYitHTHhpa1oyQnEwSGFNQUxXQzk1TkZn?=
 =?utf-8?B?Qmg2MS9YaElLV2NIZDYzajcyWXZGU0NaVVhaeXczbGs5VGcrMzlwNGplSzZS?=
 =?utf-8?B?U2dJbEoraFh2QVJ3Y1pNNGlpU0N0eFg0aFZFYndxWXF4VHgwaTNtVGM3Mmsr?=
 =?utf-8?B?cG9mL1ZtVWRrU0c4dnZ5TmhlV0xMN0tkWGNGN0ZtYzl5ck5Lc1VwQ0dnMXhE?=
 =?utf-8?B?eEljRklycnZxNHFpaXV1Y0tTZ3drQnRoR1RQTEYyNkFTMDc0UGswSnltZ1NZ?=
 =?utf-8?B?dXNzbjM1eHh1SkpKcEpRRHJKRE4xN0l2Qk40Y1VOWldza1NucE9aVzd4Wi9p?=
 =?utf-8?B?aEQ1anc3TkV6ZVFwRjlqRFJCNEMvT2FNY3k1ODRHZ1Bhc0ltNDBLZFhZdE9l?=
 =?utf-8?B?TDRIa0w2S2IxSWJ6eU9tUFpsc2tyTGh0LzAyUnhtamlxVkZOVUNDSFRSVTNR?=
 =?utf-8?B?Y3dpZUdGLzRIaDBYRHNTK01NU3NXWlpXdzBYbmx2Y1dJN3dvVER1U01vcUV3?=
 =?utf-8?B?VFdkajBud256QnJSKyt0Um1BbUkvL2h6SUliNTRNelhoNnF0b3NUNjcwZUd3?=
 =?utf-8?B?WUdTdnFJRHF3K0hEL0dkRFo2TzBXWmd2c2JGMndySUZZOW5idm9sQ29WZWpD?=
 =?utf-8?B?clJjYmdDRzFmcGx0dzdEZ3dva1lUWk43OCtVcTBGWWkxMUt0c01zaTd6YTVN?=
 =?utf-8?B?TzFrUzdGa1h0bVRmSDNKWjJpR2dIdlRyOFJHSGZaNURzMldUcHRpNXhaMFJC?=
 =?utf-8?B?QUVjS3k5YVk0QWZxT2N1KzZHSk1RUXZBOHVuTEVDbm9FWnBYYitLQi9lVldv?=
 =?utf-8?B?T2pjTTNHcFlhdjJoalNvVk5xL2RmN08zWXN4K1VTTmFJZTJLcGg4TVpZZU1u?=
 =?utf-8?B?TW1zMjg5M3FrRWhGOXY1Z3l4V1pJdTRuS3RpUUVMR0F2aHl0UkRsSUtzUXNC?=
 =?utf-8?B?R1JHYTlTZUVVQ0VKSU9OeWpENENTNlFWbWpabWwyZ1EzdFhOcDRzKy9pd1Bq?=
 =?utf-8?B?UmpqWWtEQ3BwWVRwQUdJQk90MUNHbjZkd0JJd3VoemNVQXUrenpyL0lyQm16?=
 =?utf-8?B?cEJSYmpYUnY4dGgyai8yV0ZBYzY0WE5HcnlMNlhFcXRJNXc1My9LTmw2Z0pn?=
 =?utf-8?B?d1NXR0JKdXZSUVhBK1REeFNRQ3c3c2tiUHhFNDBrWWdEdExPMm5ob3M0U0Ro?=
 =?utf-8?B?SDlMUEdzRkp3emNGR1ZsUVRXMWJPYkNwdW1ybm1BaVRaZTVQTTlJeC9zUjhH?=
 =?utf-8?B?dkk5djNoN2d1NThESWZsc3RLVUtPTk9rTVc3Q29yZGFadmk3MkI1RDNhRjBo?=
 =?utf-8?B?MktmUk1FZzVMbDRxNjFRTWIrMUZ2WHo0dWYzbGFXYVlwNjhRaGxLM3kyM2sr?=
 =?utf-8?B?dUJJSkhwa1kxWkgyQWtIS3RlUFFOWGpPYTdTL2NpTmpPUkJ3ekhsTng5TTI2?=
 =?utf-8?B?RmlYb1JWUXp6ZVArOWY2MDhyU3EyTitWWG12bkVwR2sxNkFpeFl4anNlSzRh?=
 =?utf-8?Q?hOglw/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFVWU1hCMXExd2hsOEhia1BENEFQbFdJTWppL0FRZ3lWZVNZWVh2QTV3VEZL?=
 =?utf-8?B?RDJHbVI3bkJHNmNTaEJMaVN2eHAzQkk0cFZKSDd2STc1WDIvTDlybUdKZCsy?=
 =?utf-8?B?bmJPVXVHaEFBY2gzQTRYaEQ1YzF1aTQvcGFuKy9lS1FkVDNBQ3E5VEFDU2t1?=
 =?utf-8?B?cmRtUzhrbjlYRzE5NUFMYlRCV0t0WmhoaE9xaFppYnZjZVNzbldqSVFEbDBl?=
 =?utf-8?B?R1dLUm1BbXVUaU5LbVV6Qnl6d0RWT1g5N0toL1JEdFhNOS9meDlzeXhGbTdl?=
 =?utf-8?B?RnZuc1JaVkJ2YmVOS0JSczhncHpVamY3eHRSUkZtTExpVmRjWFhwaFpaaGRt?=
 =?utf-8?B?dDNMeUpYdWw5d0dJRUd4SlgyQUE3NWdUeldwbW5ZazdZTGpLeWoxNWJCaWww?=
 =?utf-8?B?VWRDQVIvbm0yRDZRalZKK2htNUltTlAxYVJLdUNPNFNVeE15UTdENDRKZUow?=
 =?utf-8?B?YnZqT2tnSDFvTUZhK1BUcDNWMjB4QVQ5eU9MNVZKLzByeVRoaGZwYTNiVTQw?=
 =?utf-8?B?dk1yRG1IZnZPRmllbUFIRkxnaWlMdWhRL01pbEc3RFpkcURmZ0JyM3U0WmUw?=
 =?utf-8?B?SlJXQ0pNbEUzaXF5Sk5YRXl5U1ZpMEtCbTIrN3JvL3JWSTVvREZGclMxY2tU?=
 =?utf-8?B?TFNyQk9VMWtXd1E3TFYxYXZ4L212MGgrQWlSZENVS2tjVWd0dFJXNnJEV0Y2?=
 =?utf-8?B?STRiSHZvOEg0M2VpYWMzbFMyejY4VXlEbVowd3E5R1JhV3FIbHlmNFllRjN3?=
 =?utf-8?B?NU5iMTFFMlMxZEVScllhMWYrd09HN3Q0V3VCQzJRRHVkaHprMjVUVUZIb080?=
 =?utf-8?B?cVVSbmdRY0t6cFJLeFNqVFk1WFB5aUd5RlpDeHBmNUZuRElTZWZMcC9WM0lT?=
 =?utf-8?B?YXVvUzJpa0dhdEViZzRrOWhDeDVqRlRORFVhOWZvUGFaUVhGVkl6ZG51M0pN?=
 =?utf-8?B?UEJqWmpmNnh0QTFGYUM0Z05kMVZyQkxmRHYvYWtMQXpXVExpUW5laVNMbDN4?=
 =?utf-8?B?dk9hMVZGd0txVzlsa1pVRzNLWjdzalY1WU14Y05Tbk83K3FCZWdlRjRyRDFn?=
 =?utf-8?B?aEsrTTlwQnl3WW53SndZVkFEQUxvV0RnanMvYzV6NGpKQVZWWnZmRVhLeVgy?=
 =?utf-8?B?Q3NvcG1tREhicDI1ZytVSVhqdHFEZk02T1lHc3RNbVF0UDZZR3RvSDNqTm53?=
 =?utf-8?B?YWFGakNER0NGUTFOaDdBU240Q3lxanlFRFltRktSMHlrcVBxa1lXRkpUa0x3?=
 =?utf-8?B?MS9rT0cxU2NqVVI1UFBBcU5mODN2UFhoeTZLaGpVVjZ6UDl3cnJlVURmc1ZY?=
 =?utf-8?B?elJtNUVNN2NKN25jd09DNHpsbmQraElQNDVXL0Zod0M1dlZHc251MzFqNFMy?=
 =?utf-8?B?cE1PUXJha1hOdld1OVpoUnFibmxwQmxrditNRXJkNUF1ZElyY3BJRDlka2dM?=
 =?utf-8?B?RFBGbmpMbG1IWm1EWUdXZjNwSjlDVDhhaHdaSk4zeGpSTDFLYWhZbUVqeGNF?=
 =?utf-8?B?aXhSNCs4NDVqelBBbUxGNHVVUTFRdkpqYThDSjBDZklvRW9BTWtuSU5VcE5G?=
 =?utf-8?B?dG9ZdWlTaTNpMXJHd1lHRXlzcHF0ZEpXOTBrejFuYnJSamU0T3BvYmdTOHl2?=
 =?utf-8?B?UWc0bGUyOXFuKzYrbHU5ckZ3Z0gwUmw5Q29wTGIyT0dCc3BWajBOLytvYkN0?=
 =?utf-8?B?czBXOUZHNklVdnZuSkRBeUY2MnFKNVhSa2VoeGhYRWpmWksrZk5ldzV1WHVK?=
 =?utf-8?B?VjNKbkFGMGdiZG8xaUFWVklFT0JRNFdOMkFGaW9pU282VytkNXpteWIzMFhq?=
 =?utf-8?B?UTlucmlzVnk2YzVibEgrTlRZNkcyRzRGemJSazBLNWhRZHprM1hUVHRic3o4?=
 =?utf-8?B?Ry9pOVB5WHhGWDVxcDdhUGNxaGRabHhMQTFqTHBEZUFnWTVXaU5DK010QmNt?=
 =?utf-8?B?Vjhlb3M4SzNOVkpmNHZhWVllMjgwSG9JTmRsbmlHOU9TeTJnOGx3YVFTaG5y?=
 =?utf-8?B?a2hJV2xHZmZMV2ZZSjB1UXhVK3pjOHh5Z3c1bnVqcDk4aFBsODBNVmdyVG5J?=
 =?utf-8?B?a0pXUlg1Qy9McTRoM0VZQlgrR3g5VlhpT2xKQTN5QzIzck13YWRPazk5dEU1?=
 =?utf-8?Q?FyhN5X2cC9Q4jlRU6nK5L/fsL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9814278-43a8-44b7-de57-08ddff701855
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 15:51:46.5766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NV5i+2SJdGoenGYLjqnGietbowQyNW4QuDqd0YqGxhB0332N72nxIC7oYae05ug9i3ZGqjSRqxalaQ6uHsxrUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com

PiBNaWFvaGUgbWVudGlvbmVkIGluIGFub3RoZXIgZS1tYWlsIHRoYXQgdGhlcmUgd2FzIGFuwqBI
V1BvaXNvbmVkIGZsYWcgZm9yIHRoZSByYXcgZXJyb3IgNEsgcGFnZS4NCj4gV2UgY291bGQgdXNl
IHRoYXQgZmxhZyBqdXN0IHRvIHNraXAgdGhhdCByYXcgZXJyb3IgcGFnZSBhbmQgc3RpbGwgdXNl
IHRoZSB6ZXJvcGFnZSBmb3Igb3RoZXINCj4gaGVhbHRoeSBzdWItcGFnZXMuIEknbGwgdHJ5IHRo
YXQuDQoNClRoYXQgSFdQb2lzb25lZCBmbGFnIGlzIG9ubHkgc2V0IGZvciByYXcgcGFnZXMgd2hl
cmUgYW4gZXJyb3IgaGFzIGJlZW4gZGV0ZWN0ZWQuIE1heWJlIExpbnV4DQpjb3VsZCBpbXBsZW1l
bnQgYW4gImlzX3RoaXNfcGFnZV9hbGxfemVyb19tY19zYWZlKCkiWzFdIHRoYXQgd291bGQgY2F0
Y2ggdW5kZXRlY3RlZCBwb2lzb24gYW5kDQphdm9pZCBhIGNyYXNoIGluIHRoYXQgY2FzZSB0b28/
DQoNCi1Ub255DQoNClsxXSB0ZXJyaWJsZSBuYW1lLCBwaWNrIHNvbWV0aGluZyBiZXR0ZXIuDQo=

