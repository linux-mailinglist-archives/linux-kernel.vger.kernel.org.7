Return-Path: <linux-kernel+bounces-720669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E14AFBF12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33844A1F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA147464;
	Tue,  8 Jul 2025 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doP1SjiN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC59184E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933038; cv=fail; b=mxqF0BG1ZsKnFAcxnkaIa5CRGXtQsKrCqFtTjHMFSqmMAdz/DaLPKOYxUAU17end7S5rs9W+wDOebPoe+P/QOvagDrkkRoLK6Uoeix4R17DBVj3QGBI/xxkSHq744KKxhZjtEs7X62oBHgX5KD5wzdpZ0tZ6fVpn6s24OTsjvZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933038; c=relaxed/simple;
	bh=Wj9E/vw9+eTVyOcISwLN1l14zKuThs1xrs3CravZyxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCyGGjIX/Tdz+4UBMkYEkBMz2l/mrvZeB/BH7QAYiDjAm3zC1sxAXwRVKO7pIW1DCVN0NFKTgX1yPLkhi+bG7clSc6RwDI3YDo7ByIHoOzge/GRxJaCCmDB1EZWrRwDE5ao1lg12w64nS0arawhPE0pKrmaxBIw8O+cNWuS86UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doP1SjiN; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751933037; x=1783469037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wj9E/vw9+eTVyOcISwLN1l14zKuThs1xrs3CravZyxg=;
  b=doP1SjiNxqkw30J0cYTC60GHL7KPg0LX4GeUl439plVktwtRv5vLWEr+
   veyTKvOvdokTvQqaxLTCmNPJSvumqFrmR0o+sGICRH26WkrPNlZGWbtfi
   HI/kMI8nzxHV6FoE9bEvXZW5XI27/EWajfoX1vi0U1XU7AoYgIASJVHvH
   PmASjuRet0Rd5dfrSjL8IruuLFJcdh7kSBKf93CL38v52rMm2ZtiKAp8Y
   rq0nGn+Cw1a7UZesDMHAJeOaMGAvUDDz6gLipFRNjcIsPXhjKqHq5mJpg
   szQN0VDarsRaZ08/ssh65owudKyY3I+wxqCsgM//B1o+KqW5sqxvLwfJS
   A==;
X-CSE-ConnectionGUID: d6O7RYNER8KSWw9Kkm8SlQ==
X-CSE-MsgGUID: /HQsDqOdQs2WYY2qVj6Q2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54304509"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="54304509"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 17:03:56 -0700
X-CSE-ConnectionGUID: VFxVXy/SS/2cYYgVwCJ8AQ==
X-CSE-MsgGUID: FKhDL6uJSxu1yIp9xMV1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154976752"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 17:03:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 17:03:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 17:03:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 17:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtINQlZNDXZ0/FSCFXOFaUgsJLN+/EZvoXgvmFJRsOvLAKTf9e5IL6jgZUPT4KBVw+diNW69/lwda8WuPBM55oiv1dZyHY7gXEnl4s+ACwVfit8S+Ei+rIcR0wBljJ26BSO8HSDu54KE7IimIDRvi0FVEYe/fXhNjGeO/R1nYZSrvZso4d4755qVmw/2syotlVoy/2fZ360qj3ZBIrTnzddSUoS0wemMTcdIUKA+DSTmIij9pGP/3seoZNe3W/Lpu65y2cPpoyQqeLd+GNGr2c8GwVwJV9fcG6yMXFggFFClisZ7BL07GsNOAQkDU9skWlcyU2r8rJjCYgmWxBsAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEfG7pwrGqcOtmEb623MhrpVTmR/PXp0YXTcKGOJgBQ=;
 b=OhWBDJ2Uj5Xczqm242oPvnSUtPR+h5C2y7r83dk7fH7ZkAsWlnljQwJ/gcMVAF0XcqoheY6qdmSH/9czGoR5n4UeVpvEad2gZbcd6GC1k4QYcfZKTfSiCL4fy4zUcoEXfl39W51QtvQM+RZYTjXzlHSNsDTZHVqWoMDGczpjLk2Uf5TDzv6C1jVxlygNep1Zkf8zb+GCCVSckOmxXOnEgqX09zpdJDYqbi2b4JNpbRjG+sdUhigZgFxJLvdEMpXsfpCNemuV+He36bvX8zZM+Wspiyo/SiUlWU0RltyXIGy+k9OXiWLSRmtI6jP3l3UTspVarNwU+xxFGmzoMjBrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8121.namprd11.prod.outlook.com (2603:10b6:510:234::14)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 00:03:11 +0000
Received: from PH7PR11MB8121.namprd11.prod.outlook.com
 ([fe80::ec4e:64cf:cf1f:daab]) by PH7PR11MB8121.namprd11.prod.outlook.com
 ([fe80::ec4e:64cf:cf1f:daab%4]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 00:03:11 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosry.ahmed@linux.dev" <yosry.ahmed@linux.dev>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "ying.huang@linux.alibaba.com"
	<ying.huang@linux.alibaba.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1 1/2] mm: zswap: Per-CPU acomp_ctx resources exist from
 pool creation to deletion.
Thread-Topic: [PATCH v1 1/2] mm: zswap: Per-CPU acomp_ctx resources exist from
 pool creation to deletion.
Thread-Index: AQHb73ue+1h45F4SL06LS2CbuB2vR7QnN8AAgAAf0jA=
Date: Tue, 8 Jul 2025 00:03:11 +0000
Message-ID: <PH7PR11MB812181609A0EE53770D81F43C94EA@PH7PR11MB8121.namprd11.prod.outlook.com>
References: <20250707201315.9497-1-kanchana.p.sridhar@intel.com>
 <20250707201315.9497-2-kanchana.p.sridhar@intel.com>
 <20250707220616.GN1880847@ZenIV>
In-Reply-To: <20250707220616.GN1880847@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8121:EE_|SJ0PR11MB5940:EE_
x-ms-office365-filtering-correlation-id: fdadfb71-7dce-4ef9-68c3-08ddbdb2d3b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xD2iSkNfSmP2gIbYZeupng5T0YfetnXC7yzhL8TL5hfeq9UjK5f81RBT5WCA?=
 =?us-ascii?Q?HsldYEyH8ANx70NBU2e+Hv77eg7w+fLFrRIioZom+6Ay6Gp/iGdxCpyxL+an?=
 =?us-ascii?Q?zZcuU1OeFveXRu1WQGUUET+AJES2z+7K2Y5AW8qVOCSv/0O8H5ajHRV74ii1?=
 =?us-ascii?Q?eJod47ndwlkg6hGYNd2Z4aPWO5031ax//2fPyqVMhhiBejASjWgKgNjjtwmm?=
 =?us-ascii?Q?EIBNZDLTuNCF8FGyLKiwXrb5/FBGhN3MIqce7JhK6PocaCkZOh0fLZa0p4fo?=
 =?us-ascii?Q?7hmj6PIVnZOtBJafuTBktQpGZzIDTtVHXAxmGf3R2G50tQkvrVgvpZXDLqqw?=
 =?us-ascii?Q?Tu5n7WGMI4dC4ONJ39noeabWCSzSHDRnM++zcV7tCerBLnAC1InSb0RN3iFM?=
 =?us-ascii?Q?SoNc6/kiECTynuDTUXzc+f/v/wOhkOut4FFYzgEOBzT4VbvtFJldaHU1Pux7?=
 =?us-ascii?Q?dZiPHfIujMwRRjHUJqphLKxHTXFTtO7aW0PYJPiQXYt4yCZT1QmiL3uaGxwW?=
 =?us-ascii?Q?TcaV3Zi4/xa7OWYjW9mszA4YLn7wiMaz14v/v38Ui0yLlpVhxWarW9O/1h3s?=
 =?us-ascii?Q?nb7xOtadNPkFPqzA2zS1WIX5L5yOpIzB+ObTl4Hk3MxGdrV1E5QkRCogeAVS?=
 =?us-ascii?Q?PZwF1IPSwgcXwSjTAVIH1HVWy5/kSkLlOhSt1Es8XHWjo4CmpcFIlyUYB4hC?=
 =?us-ascii?Q?3SldLgfmeQX6IRjWLKA+Y/ckfiUFK9WbZaeS5PGjeZx/vxa+msPccBet2KEC?=
 =?us-ascii?Q?+BhBg1zU48KvjopSbk30Q50l/R+pO0jhr3syiXF3CEOhiPpUni+9iy42UJ1w?=
 =?us-ascii?Q?/I7/zOlHdUYxqJSgUYCjD7Ne+wfKw7apWVN7r1jd6pJ18jMU6tsMxylcqHe3?=
 =?us-ascii?Q?yW9IHxTyT9XwQBSvoY8z9Ob0/QIxIWtFZP/0af+h0v14Lwks3FJXPNRGskvX?=
 =?us-ascii?Q?z73CIuFngR8oAtgeFAL6LVohCCN2GH6B3C1nUHAhLKhuAus4RhyizuVdyxvW?=
 =?us-ascii?Q?hox6FqGhfqoh5DlGGtF8+mlrnI17oAqMzlMK/6Pv23G0JIqNip0fJf0XuJeJ?=
 =?us-ascii?Q?S4BQhGYi3ACVbcbxAp4c9iKma4iJPj0RBVm/4VrZsMHw5wHpeqLopZMY29yj?=
 =?us-ascii?Q?1uLWr5/wSH87zFccrMgiSydjbiIuJ7uLkInjXavJjPMlAuCHntHmlCij4hPd?=
 =?us-ascii?Q?fjXwl0CeWjJWEvhXRNaRdRkbeaKSXvZMyR2GAyDz0Mkbw4RQJJguoysVG+r2?=
 =?us-ascii?Q?TPwwub1dIIliayJukhyx2Nxm7i83xjJLNksxMMhQ7+hDNVx8puGNQyaiv5QL?=
 =?us-ascii?Q?n/KL13451SFZKuaaMYSlfGM+u5WsPA38zTDEldHl4m+iRnrQbRAeW1DoCN9/?=
 =?us-ascii?Q?nV5f+qyBpeebhhBMmraQavNDb0kG7VySjn8k63ZB7VHhoxAZpYjQ8WH224w+?=
 =?us-ascii?Q?/uH7nvFoCdZgyRCZiV7HUttpletHQDfrKPwiJG3dfddFzBGLpMgA2w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8121.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nTAR9Kspws5K08WUZDfb2LnY6Eh8+35LX4ovmEl2qmYqZazq6VZaLzJcdtyr?=
 =?us-ascii?Q?Np5bcYzwMEVV7wK9TXlng32/SpjpuAD3NWZfiGx3fkogroF8ElVui0umbl4n?=
 =?us-ascii?Q?GPnlyDpcAEYe2YGYWPQCFkZ3SGxqEt132OvMmtNXjuXpxZMftRnkoD1Dusl2?=
 =?us-ascii?Q?yibpn8XMSJXoQo7XyFtwttB2FdAlW1PthL1CwmQdHTTEqSPK46NaiZOO+hBA?=
 =?us-ascii?Q?8ZHHKdUjtAqRUdNakNfzTYHgjAlskem6RxexTznFl6WPjYCSK9frrAQRTS8n?=
 =?us-ascii?Q?UA2Ji+CwwLM+CxvDARVsTbLMMgHKYIabVGhDyJ4rVJfghJBsVbQVHV8oJ4zg?=
 =?us-ascii?Q?ai1xjQRrdfnGksL/X70J9FTU+9qH3LqPIghJa18myZEptLSXyB90rhH9YnjG?=
 =?us-ascii?Q?LYL+kSmIFkY9blcFtPn1CmGT8kGOCHqIhuWgXaUf3yUfpBhCAa3PxvfRewUG?=
 =?us-ascii?Q?tS/q1RJKlGC/J1fdNq8i6Sk4mr1kuzKvZc0RfYcZ28glgWm6R9idKuMxjdq9?=
 =?us-ascii?Q?9uoh2tpUC4rxJ14Gycf2mjcGvY+eIfFKNOquotFvfDsmuQ+BSBMP8bFebOob?=
 =?us-ascii?Q?1qoGolRxTryyE47OkzrgPxOXRHSpjdWUqHqMViErLWd7irMPAaFmvZEUlAtc?=
 =?us-ascii?Q?oKT0t7gquckIyd857EbxFk1WzpLldA7dqG4fZUwOfA/DiDQNUjxFMFolEkBr?=
 =?us-ascii?Q?CSc8Y5xpxVER0dUvj0ZtyWIfrcSwb7SscY80LBZtjxLa6vadAagFiWjNKkYS?=
 =?us-ascii?Q?rOlanqa4j5GsTmeSeTUjWZyHObg92rxmET8a3Ug3wjIp5WsDyZeN5Tvvmjf3?=
 =?us-ascii?Q?EMaEvEnvrEpXmEpualX+UMRBummQr/fZVk3EUepNy/MOoql0TrOQ4B+j4ePY?=
 =?us-ascii?Q?Le/C+hEt77I6OQB5MbRNaKKTvZYJ1z/Gwk7xqxtAuKVrG9QOmA2Z8l9KjTQT?=
 =?us-ascii?Q?HYHknQcmXwIt1QnGO5JTvF0czHPchRUEGWq9SXEOTbFAxU/qEhkg+hStwZQ8?=
 =?us-ascii?Q?hsAoIa1aOrpkF5QVfLWbY6ZBw+8sZXgMmibACWzkATDObH16U0LEtFRtfJVX?=
 =?us-ascii?Q?ptpEykaBgQU0Sp1HuTstpdr4Yh4NPljq054rAnUDpwS6RfWVoRxXr98Ekr90?=
 =?us-ascii?Q?of2f4klB7FOIN5qIo+Ylgy6TDAPiM/nsp640kJ0cKiuR66CSdRK2C4wduTex?=
 =?us-ascii?Q?Sjn6LZVFZeWsad5n8PqJ7Z7Vl+3tOCCVMJD+VeLustDCgcAZ3x3i4L5f/fHm?=
 =?us-ascii?Q?yASlfaFbBXp8c5ssFvBuvRmNJEu2x25/RCNSnjPw33hYJbeQ3vgOdUTnLKqE?=
 =?us-ascii?Q?Vz8io9YDps1Hs93bbw7zDHU9Hfey0w7rg+ywgA92hTg48/cKZbexL/T/HAZ/?=
 =?us-ascii?Q?DxLMVkBARCkfCPOifxGTVLgADc/eWaESTbdJNDW1PB3nymYpUN5N0mDQNHz2?=
 =?us-ascii?Q?FHjTPEQyqAnux/RliE/rlIp/jePsGiEPBGfArxYZrHnqF2Lh8qjWzpnE1dQN?=
 =?us-ascii?Q?Amn0r1a4T0SxGegIr4njjmjW4IkfsdGL93MgDuKiTLxblRw/2yxEf2i3SgjT?=
 =?us-ascii?Q?B7QfWs6Jiwaz7qBniNrNZG9zPMLVVqimPJHSnSE0Y++zPjfPbuLbWVRJE+Bg?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8121.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdadfb71-7dce-4ef9-68c3-08ddbdb2d3b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 00:03:11.0327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Sxn1agppLsLPoZ1xOxXQPhCivb/jW0LfktkIqclLEVbJ38MEnYZgnoj4O4/iidgWDM0+9ZHBcncL7MGL4a7EQffsrPDsfAckrp35Cfn6ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Monday, July 7, 2025 3:06 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosry.ahmed@linux.dev; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> ryan.roberts@arm.com; 21cnbao@gmail.com;
> ying.huang@linux.alibaba.com; akpm@linux-foundation.org;
> senozhatsky@chromium.org; Feghali, Wajdi K <wajdi.k.feghali@intel.com>;
> Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v1 1/2] mm: zswap: Per-CPU acomp_ctx resources exist
> from pool creation to deletion.
>=20
> On Mon, Jul 07, 2025 at 01:13:14PM -0700, Kanchana P Sridhar wrote:
>=20
> > +static void acomp_ctx_dealloc(struct crypto_acomp_ctx *acomp_ctx)
> > +{
> > +	if (IS_ERR_OR_NULL(acomp_ctx))
>=20
> Ugh.
>=20
> > +		return;
> > +
> > +	if (!IS_ERR_OR_NULL(acomp_ctx->req))
>=20
> Ugh.
>=20
> > +		acomp_request_free(acomp_ctx->req);
> > +
> > +	if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
>=20
> Ugh.
>=20
> > +		crypto_free_acomp(acomp_ctx->acomp);
> > +
> > +	kfree(acomp_ctx->buffer);
>=20
> Just what are those IS_ERR_OR_NULL about?  Is it IS_ERR() or is it NULL?
> Either has valid uses, but mixing them is not something you do without a
> good reason; there are valid calling conventions that allow all three of
> "address of an object", NULL and ERR_PTR(-E...), but that's not something
> you do just in case - there should be an explanation of what's going on.

I hope my reply to Nhat clarifies and provides some more context.
In summary, the IS_ERR_OR_NULL() is preserving existing mainline code in
zswap_cpu_comp_dead() in the new acomp_ctx_dealloc(). There is no
teardown callback, i.e., zswap_cpu_comp_dead() with this patch series.

Thanks,
Kanchana


