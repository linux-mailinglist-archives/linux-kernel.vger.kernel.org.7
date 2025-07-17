Return-Path: <linux-kernel+bounces-735209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2651B08C31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EC71A62787
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A3C29B227;
	Thu, 17 Jul 2025 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yqx5a6Ul"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10429B23C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753265; cv=fail; b=Bi4cFP3bn1HiLpsVgz2DFIQFUzBdBxwLx+tp3lTmUWsR8iC5vS/8apcdOf8SW5crNdMdTJGLYck5nZ30IR4bi4xvT+ht3uU6jJzdAR3FhgN8odAYAZ7jdGYR9lRNolhrLfEpDPN+xw5RS0LfpppEgAHCgVUsnWI499MPmmeBo4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753265; c=relaxed/simple;
	bh=hOxTtu+qY5q8ZjStHPOEfDlFtxz/GIaoBDdXhkJ4718=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CMS1vD5ADeeubKcfFD3hIAafnc7eiZgFMLgqvt+G2lpyhu8WoqoQUgFIZ8VrbpnU1iZqHMp/ZmmvNeXWTbkCr1hUGNovLul6UjVVOOCZYCn+b/AtOc9Z3TnANxDywlKsN7ZFbVebj7zPqJqYQK3D0oQ/IcUWr1Yofwwhh9vHt6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yqx5a6Ul; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752753264; x=1784289264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hOxTtu+qY5q8ZjStHPOEfDlFtxz/GIaoBDdXhkJ4718=;
  b=Yqx5a6UlIBfG3LHofotwv4Bf5jYtpzxlvWex4UI6jl+zi5yCGVniEpaL
   0pnxc5YmAeh/IcqTwbs8bqnMJVAeCHyIvbxhim7GhsCrbWVQ6KOrmrQTo
   I4iX6eSrTb9SN/NAibeo0EUmv585QGwSTY4PXYvM2QZyAqxH4QzG6l1eW
   nSVtStFQbGlfCiIHwFuHbVI2UrwnR5WvYXO0MtjtCgecjSYlKohd2FgeM
   dQp6LeKmr6hMpQ7egPFyrkYDuYeglyJY21kzA/THctAek+JZiHoP3XiGR
   At88GrD/zxHOkedgDlhqQqAaqD2PjMSCSifU9qli2DTv11ND338bPprZ5
   g==;
X-CSE-ConnectionGUID: cmqSoYaNSo6xOLBlHjgWcA==
X-CSE-MsgGUID: AdV9SzvhRlCetcQottiswA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="57638181"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="57638181"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 04:54:23 -0700
X-CSE-ConnectionGUID: v5hSNYyATfSQWx/+fPkwGQ==
X-CSE-MsgGUID: oFNL5bE7TGSVrA21rXWVBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="157873882"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 04:54:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 04:54:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 04:54:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.69)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 04:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSlOsGNDWw487fjsf0pRRbYJr+IJYAzhT0mx8XyxY3nv9JhoXOrBfvBbD+HiNeMdQrgFPLXdi2AIiVy4H5LrttEIwdGStdFxE/Ki2au0BpFltnDNAdj+WU4buNGMeN+wQhTrEVNhOashn3YqKtIdpzFQ6sP0TCtBOhC5KU4P2Dmdb5rpmCW2DnvHSLhLbNteuKRttzh6Z6lrXMM0MR1cbbqi/KLGL6tTH2qeBwD2FnNOTggppzL5QFnoLr+nX2TGq877MHhiIRd9pWFrO0JZ1eSeSjcx+qrpENYOXqB26y5Fv1Y0t94U5JI2aNUh0tn1za3ptlwixUY6gum7FqIuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOxTtu+qY5q8ZjStHPOEfDlFtxz/GIaoBDdXhkJ4718=;
 b=P6nI7FLueZ6biC9qev5KQbAc04Ux8QJYBdJ1mznAEfWmUQRmO2ok+Y5Ln5Jf6ofoBRo16lasz+Ua1SQTEIf2PuZw7Oh3ILeL8hQyk6Xjfj87QdpRvE3Ue8sHRRIaQOgfS+JvdoBd7CHsEFM9rpc3g3PbiBvQif0PgLrrUPnk/Cjc1FedBc0cRkqggjMPWJiU1Atin7kCCBDJIF7XPvJ+RGUt15yG4nhjhtB69HjZM4KgFKgD7Wm5LG+KwRFCctJUyIXTxU0KL9m2VXqYHniJIiPokIO/z2L1W0LnqYIilHzajhi9B27IOK7Ia3q+3XcEH8olwhK/a1pKRKrtEDcFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA2PR11MB4906.namprd11.prod.outlook.com (2603:10b6:806:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 11:54:19 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 11:54:18 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next v3 2/5] mei: make char device control its own
 lifetime
Thread-Topic: [char-misc-next v3 2/5] mei: make char device control its own
 lifetime
Thread-Index: AQHb8OXs8gW1eR6hYUO4QGSRsNtZX7Q0jW4AgAGvQWA=
Date: Thu, 17 Jul 2025 11:54:18 +0000
Message-ID: <CY5PR11MB636673873E2E74F55D46937CED51A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20250709151344.104942-1-alexander.usyskin@intel.com>
 <20250709151344.104942-3-alexander.usyskin@intel.com>
 <2025071601-squatter-lent-4260@gregkh>
In-Reply-To: <2025071601-squatter-lent-4260@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SA2PR11MB4906:EE_
x-ms-office365-filtering-correlation-id: fd5c60eb-1091-4ef5-e187-08ddc528a974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NFhYcFA0cEpyK05rODJHNjdpMGFKOUNLV3JaenZEN0dhcXlGaHFCOHo0YnBi?=
 =?utf-8?B?SXN3R1U4OGNjbG5uZmJMYXpsYi9uSXFqTFArVm01Q2p5ZlZvKzU2SUpySmln?=
 =?utf-8?B?MFFqNHVlVE9NVnJHK2h3cHh2bHBmMVB4WkpnLzdpYzk5QTNKTDJiYkR0VHZ1?=
 =?utf-8?B?MW5PZ040Nm9ocVBJK29pSnlhUU1jbm5nVEU2a05WNUppeC9sY1J0ME5CWk5G?=
 =?utf-8?B?YUZ2ejhPMy82QlhOSUs5ZnFCVHRQMnFKcWJJZVZZNklGVU5kSDdJeThMWk5j?=
 =?utf-8?B?dE55cXVUcW9aM2pnSDZ2UEU3dW1JRTQwdVRiM3JmaWIrTXBDQnAxdWMxK2tF?=
 =?utf-8?B?d2VKOFdoc25nU3ExeHFNVEJJVDAwOEo2czNob3FGZzUrSTE5YUFTVlFLVVg4?=
 =?utf-8?B?Ylh4dmZuZFlDa0ZFUGhIK3E1cjIzZ2R1ZHQ3U2hONkJsOXVnUnE2ZnZJYmNP?=
 =?utf-8?B?ZXNTclUveVpiVjUrMjJGR2JpcUxTT3pnQmxhTlUwQW9CdWdhLzhiQmxCdUZO?=
 =?utf-8?B?RkVqQnhGL3Z1SFg2Y1BybGl3eDRBTi9iRlVTTmhHd1dDeUY2Z2xLWFBDVis5?=
 =?utf-8?B?Rk5xTjM4VzdGVUdoSEppQXNvblRaUmJtaU1Oa1VhaG5PeDFaNW10L1VWQ1dU?=
 =?utf-8?B?dmNyZitjYXBDQjJ0ak5Ua2JRNll2QjByb3kzR212ZUc3QUMrQzcybTAvV0Zs?=
 =?utf-8?B?VmpnYzR4UUZYR0dDbDJuTDd5c3Fhb3c3SU1wSElPNjlpcWRIRVd2TWsxOFk1?=
 =?utf-8?B?ck5UbnpRR21lN3dNQTkwSHc2d0NPcktwazBnbG5WbXl4UzBpL0lpbXJjYllP?=
 =?utf-8?B?RUJUMVFGeUh3WG9scy9oYWNNYXNYSGdBeHk3N1c3L09xa21WdEZ5cFhNOC80?=
 =?utf-8?B?QTFLdXJ1U0dKWHcrdytDTkRjV29FVXpmZkNDdzVoWW9oNHFmOVpheVR4UVR3?=
 =?utf-8?B?ZFhHaTlkMThUZWwrd2VoTzkwQ1Q5bWtnK09KRUNYNVNtQ2I5VmtUV2FtWVZ4?=
 =?utf-8?B?TlVFa2pldHM5RUVBd3p4ZCtBd0FWS2hidWdFd24wdlVQQzVFeWxwZ2lQanp5?=
 =?utf-8?B?VzN6YkMrT1dOOEVSd2hSbmZyVkx6aVZ1RFZaQTRDNklVSkZVVDk5YkNBMlgy?=
 =?utf-8?B?WGYyVkJ4WnRpTHBGcHhVRUdJRHYzWGxsYnNzTWpSc3JWbHEraGNtUXlYQXpo?=
 =?utf-8?B?dktQK1Fua0RaNDRyeDhIS0Q0TUlYTnIvTzI5VmU0RjFOM3Vwc3BEdmRZMita?=
 =?utf-8?B?Y2FwdGg3WEtHbjcxY3BESllnWHpNTXlxM0VRYjZlTTRxbDdrNVNGRFRQMnVm?=
 =?utf-8?B?SUN4c2I2TnJwTGkvcEF2aVJCb3hMbjBkNFRIaVlhMWdYSTAyTWt5S29KSVF2?=
 =?utf-8?B?UVRDeG92RVRZNlFPUDBHRVRFREU3QzJXMTdES0FSd1U2bUN3SU9MdG5JU2Rs?=
 =?utf-8?B?cmZQYjN2TmNTVjlsaEt6Nzl0YTBuREpsVWduYngzeGVxNjFjdVV1M1R4cnJH?=
 =?utf-8?B?QlNYRXNLLzB6cXdNSDJZcUpBQitqSiszREhSNDhiakt0blpaZG15VjRpSWVS?=
 =?utf-8?B?VmJQWmFhNm4zMXA5dHhrSWFqMzJpeDVkRDN3aUQ4dWRuMWhRMkM2ejNrdWJk?=
 =?utf-8?B?aFB5Vm1lVlh2TXRrdjliU01DV1ZFL3ZISlFwWi9jMUhpNTdhZElKVDFqR0ls?=
 =?utf-8?B?OEtUcERuYzVybmZZNktRd2pUY0xNRjYyVGJsdTRxWUdhdWhkQjBJV0pJYU5t?=
 =?utf-8?B?akNrUWVVejBrcUpBam9pM2R5bHBlQnpSd1J0TGltWDdNS05TUVR3SkpuUWJJ?=
 =?utf-8?B?WkVGYnNFQ0YrVGhIdFNSRjVLQmpEVlVIazI2dEFFRHB6a3licHNGY3J0Ylk3?=
 =?utf-8?B?UlUxK0FzcHRRVUV4TlFtakJ0bEI2c2t4cTNia2RGTi9lb1JXWlFuMmJkczBE?=
 =?utf-8?B?TmlLV2lrSUpXaG1kU3RFYWo4ZzRLTFYvVjJ0YVFSZXVvZ0hhaDM2WU1tV016?=
 =?utf-8?B?YnNyOEM0aGRBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NExnNVhHYUVySTYxWTlpZGljNS92ejRFVTdlOVIrS24xay9Qc292Y21KZ1cw?=
 =?utf-8?B?TmpvdEtQUkJGM3FhT3h3WEIxOVhOaittOVRBVjhlQjl6azJKeEozWHJiZ3Vh?=
 =?utf-8?B?cWhLYWRqTERYM014bW5DclhaT09vZ2xIK1FQMjZzcWsxVVVUYTMzU1RBKzR1?=
 =?utf-8?B?RkVjZTBRNW9CTjFVVE9MZlUxOGtLWkRscU02OTVrSVdlNnVQVDJLME1Uemtu?=
 =?utf-8?B?eGtDNE90TDNwNkgrd2pPZzFlR00yd0pxbTZrT2dmZ1piKy9jVGQ2eTkvMlY1?=
 =?utf-8?B?S0J2Qy9uQkVQOU5lVkJjenR4VTYyTWF6Ym4xc1BnQW1meWZzVUY4aktUNHk2?=
 =?utf-8?B?RFNybWc5Vi81MElxNGlTSkdWWnhjUTd3NFArakU3Z0N5SVdFSHVvS25BMlVD?=
 =?utf-8?B?SGNxcEI3dFRadm1tMkZBcVc0WmdDM0RsSGlCeDJpWk9nY2ZzaittZlZNYWhl?=
 =?utf-8?B?NkdwUXoyMmsxRE9PYkovOHBpRkVJVmZQZGlJc2p6NjRLT3JKbE9zNVBnNUhq?=
 =?utf-8?B?Zi92Nm9FZUd0MmV1TkROZnAwSUJ5MW9MV3JEN1g5enpqeXNPakpsb2tsZXda?=
 =?utf-8?B?dmhxdVdkMmNqejVFQ0lCdTBvbnQvUFpEdmh6Y2xXVE5lSmhwNWtxaVdsRmdw?=
 =?utf-8?B?WGQrVFEyaW5yVlVIUjZXb2JFRjByVjFXNFErVC9pUG1Rc0Jsc2wwbGIwa0t6?=
 =?utf-8?B?ZDVLUnJPNm5sMkozWXQxbm5YUC9uRWhXa20zbFVVY1g1dytLNjN2cTV2MWVw?=
 =?utf-8?B?RmZIQ0srUVRWQll0OUU2NUtic3VtaGhIRTUvM0JrS1RQMEdNUGxDUjRDMmJP?=
 =?utf-8?B?UTNwbEJEYWpuWmZWY3lZaWpmdXh3RkRKT2JJZHJoeFJWTWIrS2tleDV2dWFi?=
 =?utf-8?B?RVdzd20xVS80azM3cXNKQ0lGWWM1US94dUZsVEVkV0phZlBtZmUvcVQ2N2R0?=
 =?utf-8?B?c0s4R0JSMEp4ZFhIaXk4QmFYVWZxQ0pibW5rNXR3cldTMm96akR1TFk0V3pQ?=
 =?utf-8?B?RjE3blRwQ20xaEo5Q05nclJSUzRjc1NCTkNMcmg5QW5rZmx6aXp2elYvSHZV?=
 =?utf-8?B?TVZVa205Y05CT0ZYYkJsM3doTE5DY3lXTWFNMzJSQXNoZUFyZ3dhOXN6dGp4?=
 =?utf-8?B?V3h4N1l5YTROU3lJcE5IRjQ3QVB0WXN2bHNTeXdaRUZXdjVNUWxobytjQ0Fr?=
 =?utf-8?B?WUphck1DRVFzYzhqM1pHdStzTWwyTHREMUNzQnJDd0xmVSs0ODVSVlpmdlhm?=
 =?utf-8?B?bmkwYlFWZ0JTTldkK0hwVThRbFlxWTBNL1VrTXJoZG1CdEZEcmt3QlhERCsr?=
 =?utf-8?B?c2ErbnI4QjZsZERod05FdUc2d2FLcmFsdXRCNkFFb0hnbkRTZy9YUTQ4SjAz?=
 =?utf-8?B?cXFReExETTdhSndYNVZtclM1bFRBNlcxK3dxaC8wMUVXYWJCT0R0K1Qwd1l3?=
 =?utf-8?B?clFKWWhVZWtHRG4zekNvQnA0VlN0SW1rRDF2bEpMaWpoQ2lIRFY3MWVFZDgy?=
 =?utf-8?B?T0QwY2lVVXFrNGNoamVnMDNlMldVK2RWK3RpN2xUYkVWZ2lqdHFxRFdnZTFD?=
 =?utf-8?B?eURFMmhTalZ6bitFSFZMWmlFVW1SekFiSHVoQmRmOG9SZGtJMVk5YzdpQnlj?=
 =?utf-8?B?VUN1VlVLV0xyb215SG1KNWlVMWk1dVNOM0w4MG1HdHVMWGVCT1FoNVp4WW13?=
 =?utf-8?B?TWMyNVRieDByamZiS01oYjBWQ3VpZDd3RENtQkRqY0NKVTN1ZXByOW40YlpR?=
 =?utf-8?B?Uk1QU2IzNk10Z3VhTC9CV1ZxSVFIUnBYVzRPek5wVEVYdWh2RzVLMHZWTTJk?=
 =?utf-8?B?eFlia3pBMXA1V0FObDNzY1pJakNsTXJyRzIvd1grYS8zQjY2SElYTzQ1d3ZO?=
 =?utf-8?B?Q25vWkxLU3YybUxaZTFNcjZiK1VjaXZjZVNOSmxZOE9BUGxCQlRjRXVnUUt0?=
 =?utf-8?B?aWo2ZW14azBqRWMrMFVOM0piUnVHcCsyTUVVcjR6VkZHcWpMSFFocGxUendq?=
 =?utf-8?B?OWZHeU5BWWwxWFA1dHY0Nkc0Q2YrYS8xZ3grVVFQQmVpVlJMZnNpSm4va1pY?=
 =?utf-8?B?dnByWStSMll2TDBmS284WkFCVEErYzZKbXlCT1gwOGZEaUtSRGxjQ1BPeHFS?=
 =?utf-8?Q?0c8BgFJVsaEHM+HQGfNZq4rJF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5c60eb-1091-4ef5-e187-08ddc528a974
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 11:54:18.8428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4d5L6goLzp1wZkdEhs5EuunSd9tbkhUVUBS1eietaijl1m7MwAcWBnxHDHl5FUFth6Rtopo/rEV7ndrl7pDGCm5nkcu5pCl0SY9717mMsOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4906
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYy1uZXh0IHYzIDIvNV0gbWVpOiBtYWtlIGNoYXIgZGV2
aWNlIGNvbnRyb2wgaXRzIG93bg0KPiBsaWZldGltZQ0KPiANCj4gT24gV2VkLCBKdWwgMDksIDIw
MjUgYXQgMDY6MTM6NDFQTSArMDMwMCwgQWxleGFuZGVyIFVzeXNraW4gd3JvdGU6DQo+ID4gQWxs
b2NhdGUgY2hhcmFjdGVyIGRldmljZSBkeW5hbWljYWxseSBhbmQgYWxsb3cgdG8NCj4gPiBjb250
cm9sIGl0cyBvd24gbGlmZXRpbWUgYXMgaXQgbWF5IG91dGxpdmUgbWVpX2RldmljZQ0KPiA+IHN0
cnVjdHVyZSB3aGlsZSBjaGFyYWN0ZXIgZGV2aWNlIGNsb3NlcyBhZnRlciBwYXJlbnQNCj4gPiBk
ZXZpY2UgaXMgcmVtb3ZlZCBmcm9tIHRoZSBzeXN0ZW0uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4YW5kZXIgVXN5c2tpbiA8YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL21pc2MvbWVpL21haW4uYyAgICB8IDM2ICsrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL21pc2MvbWVpL21laV9kZXYuaCB8ICA0
ICsrLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL21haW4uYyBiL2Ry
aXZlcnMvbWlzYy9tZWkvbWFpbi5jDQo+ID4gaW5kZXggOTVkNGMxZDhlNGU2Li41MzM1Y2YzOWQ2
NjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9taXNjL21laS9tYWluLmMNCj4gPiArKysgYi9k
cml2ZXJzL21pc2MvbWVpL21haW4uYw0KPiA+IEBAIC01MSw3ICs1MSw5IEBAIHN0YXRpYyBpbnQg
bWVpX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUNCj4gKmZpbGUpDQo+ID4N
Cj4gPiAgCWludCBlcnI7DQo+ID4NCj4gPiAtCWRldiA9IGNvbnRhaW5lcl9vZihpbm9kZS0+aV9j
ZGV2LCBzdHJ1Y3QgbWVpX2RldmljZSwgY2Rldik7DQo+ID4gKwlkZXYgPSBpZHJfZmluZCgmbWVp
X2lkciwgaW1pbm9yKGlub2RlKSk7DQo+IA0KPiBXaGF0IGtlZXBzIHRoZSBkZXZpY2Ugc3RydWN0
dXJlIGluIHRoaXMgaWRyIGFmdGVyIGl0IGhhcyBiZWVuIHJlbW92ZWQNCj4gZnJvbSB0aGUgc3lz
dGVtIGJlZm9yZSB0aGUgY2hhciBkZXZpY2UgaXMgY2xvc2VkPyAgRG9lcyB0aGUgY2xhc3MgZGV2
aWNlDQo+IGxpZmVzcGFuIG91dGxpdmUgdGhpcz8gIEl0IHNlZW1zIGxpa2UgaXQgcmVhbGx5IGlz
bid0IHNhdmVkIGFueXdoZXJlLA0KPiBidXQgdGhlIHJlbGVhc2UgZnVuY3Rpb24gYWNjZXNzZXMg
aXQsIHJpZ2h0Pw0KPiANCj4gT3IgaXMgdGhhdCBhIF9kaWZmZXJlbnRfIGRldmljZSBwb2ludGVy
PyAgSG93IG1hbnkgZGlmZmVyZW50DQo+IHBvaW50ZXJzL3N0cnVjdHVyZXMgYXJlIGFzc29jaWF0
ZWQgd2l0aCBhIHN0cnVjdCBtZWlfZGV2aWNlIG5vdz8NCj4gDQoNCkF0IHRoaXMgcG9pbnQgaW4g
c2VyaWVzIG1laV9kZXZpY2Ugc3RpbGwgbWFuYWdlZCB2aWEgcGFyZW50IGRldmljZSBkZXZtIGFu
ZA0KdGhpcyBwYXRjaCBpcyBub3QgZml4aW5nIHRoYXQgcHJvYmxlbS4NClRoaXMgcGF0Y2ggZml4
ZXMgdGhlIHByb2JsZW0gd2hlcmUgY2RldiBvdXRsaXZlcyBtZWlfZGV2aWNlOg0KLSBXZSBhcmUg
Y2FsbGluZyBwdXRfZGV2aWNlIGluIG1laV9yZWxlYXNlIHRoYXQgY2FuIGZyZWUgbWVpX2Rldmlj
ZQ0KLSBjZGV2IGNhbGxzIHB1dF9yZWYgb24gaXRzZWxmIGFmdGVyIG1laV9yZWxlYXNlIGV4aXRz
DQoNClRoaXMgaXMgdGhlIHJlYXNvbiB3ZSBuZWVkIGNkZXYgdG8gbWFuYWdlIGl0IG93biBsaWZl
dGltZS4NCg0KVGhlIGxhc3QgcGF0Y2ggaW4gdGhlIHNlcmllcyBtb3ZlcyBjZGV2IHBhcmVudCB0
byBiZSB0aGUgY2xhc3MgZGV2aWNlIGFuZA0KbWFuYWdlcyBtZWlfZGV2aWNlIHN0cnVjdHVyZSBs
aWZldGltZSBvbiBjbGFzcyBkZXZpY2UuDQpUaGF0IG1ha2UgbWVpX2RldmljZSBzdHJ1Y3R1cmUg
YWxpdmUgdGlsbCB0aGUgY2hhciBkZXZpY2UgcmVsZWFzZSBsYXN0DQpyZWZlcmVuY2UgdG8gdGhl
IGNsYXNzIGRldmljZS4NCg0KU2VlbXMgbGlrZSB0aGF0IEkgc2hvdWxkIG1lcmdlIHRoaXMgcGF0
Y2ggd2l0aCBsYXN0IGluIHRoaXMgc2VyaWVzIGZvciBjbGFyaXR5Lg0KV2lsbCBzZW5kIG5leHQg
cmV2aXNpb24gd2l0aCB0aGlzIG1lcmdlZCBzbyB5b3UgY2FuIHJldmlldyB3aG9sZSB0aGluZyB0
b2dldGhlci4NCg0KLSAtIA0KVGhhbmtzLA0KU2FzaGENCg0KDQo=

