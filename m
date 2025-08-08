Return-Path: <linux-kernel+bounces-760630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A36DCB1EDFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D44E3AF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B757D1EC006;
	Fri,  8 Aug 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNJW6EPm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C11E8328
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674983; cv=fail; b=Gq57ibgf2UQwSZujSOwhY91/NuSoYyNFxmgpmRL/PWyVZ3RAZdn1l9BgfbzSe0bQhLR7Ke11qiqsQ6nJLkdMjgCZQRgnmfFpsmVTZgyLN220UQA/dyCM1mhCMoE9v/UeEvu+cF6JaEkfD+bgoTkZO9oqIJXAyciszFkmsZUlxA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674983; c=relaxed/simple;
	bh=688AfsjQQIAjQCRN6tKr34SIC07KpH1367mfQV8DbRc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsmxkPH1R6vkf3edDrL5zqOeMzAGHs8PxOwES/ZqHMGKXLM7WRPB6sIJAA13Sgc0+NRQyptuX9mq5+M/FwSayI2Qvd8lyaZJWS2Px4tXXyBSUU0Vidz1W2o8TExFqdyf+a8+snBIB0B7JcAbos0GZeCcKlpUGT04yK7RIs5jtgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNJW6EPm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754674982; x=1786210982;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=688AfsjQQIAjQCRN6tKr34SIC07KpH1367mfQV8DbRc=;
  b=RNJW6EPm51CVTAwAjBFLifhhPocLaux7aei/kdMmGytU9nogVA8Jy5BL
   nMVskR1IYpfZnTMqOxT0ASnxQDFNuM3V00RJoJ/aGd093AU2UYPBZRftU
   jDRbyGfdB/uTxDjcdkAUpyQEAAdyWSh+T3/oDyaqimXRlPMC/58NgRztg
   zjSlsn+eY9w0uqA8ESnjzT8kdEf4o6/Qur8V5924GvpfwgGqsIovj73wr
   Rf9LpUjATMaeaUugd4aL6/cDP4ES4spRpwfK25DhtsbAOZI9/ykDpIfoQ
   xYV9kFkQwOmzIsycAyyw3OMkE0FutFzYlCEwrKyKDDKPWBAN0LoLOq+dF
   g==;
X-CSE-ConnectionGUID: LAB9JzwUSEaXAn8DfLNlmQ==
X-CSE-MsgGUID: ZIo9yS9bSpeuMtOY1s9GdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56063546"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56063546"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:43:02 -0700
X-CSE-ConnectionGUID: oUYnMs9ATH61paC8rLevfg==
X-CSE-MsgGUID: 4GfifLs2Sda5Mgyu4CzUDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="202566158"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:43:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 10:43:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 10:43:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.59)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 10:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZATS6h91eCQfeR5UftPCtfJrbAycLGA3clJEpN1LMObv5vo0BHv543zcHrEZkESA2qkgs013rYJr/e81g7Ngfok4Wj44J2fdJh8ElzMXADjY24S3O0Au6aPoC9xB/Z+n/bJ+m7CYRrYyvxyPk6bQEn19fj5a1dMJxRQtAzu4XnfR38OAtL5GQNAn32MgsW7TpKPzgT7/mHpSb+ZegCb15O+6BovwpATnTtD/OcP/zTd5b3kRHtcdRc0o7VHX/KuTXMuHl6KcKPtmaYdHTpdRypU5GgWj9jmVZiLV/NNhGo1wM/Xso9M36FtpT6mmWkoVn37i2xUjWlO9NdNaVApbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fumVsFbRoX8uJc+aHWG1ryCF9iBNJOzlv5BOe6diedM=;
 b=xMbXu/uTgR6Ol/qw+B2+YqclaQvMHO/pN2fT3ufkbR0vkjfly8WQvJMBuvYgz8OVsGPV0u69kXeojFKSWkfmO38F4+tSIQmAOo5Nc8lwcsAVs+k1OXeOFLvNr1Lj0EBjUnIn5HL/K2WTDI3zLMCGcXvXYNI8roAVWA9/uAxaw6n7sFxk5pLxKgC5Dwd1M0ZRh5loui/fqYXI3essA4LDubBCGCvvwBmTE30yIvkmKza4WF0IDKOPPHQhQGP8w7mIsb89TLgi9FomfXrIn058sw71BKWHqtLzoviZIOecXgvd/hTXkKyB60IXM+LImfK8qfbTrBLXdQLpcTa/yz/naQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) by
 LV4PR11MB9515.namprd11.prod.outlook.com (2603:10b6:408:2e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Fri, 8 Aug 2025 17:42:59 +0000
Received: from DS0PR11MB7903.namprd11.prod.outlook.com
 ([fe80::44f8:aece:f6a8:e42a]) by DS0PR11MB7903.namprd11.prod.outlook.com
 ([fe80::44f8:aece:f6a8:e42a%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 17:42:59 +0000
From: "Chrisanthus, Anitha" <anitha.chrisanthus@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Remove bouncing Keem Bay maintainer
Thread-Topic: [PATCH] MAINTAINERS: Remove bouncing Keem Bay maintainer
Thread-Index: AQHcCIrvG/u4gmAmUkCx4dDYtXx3iLRZBjBQ
Date: Fri, 8 Aug 2025 17:42:59 +0000
Message-ID: <DS0PR11MB7903850F31CF79B1FD2932EC8C2FA@DS0PR11MB7903.namprd11.prod.outlook.com>
References: <20250808173601.77F1A90A@davehans-spike.ostc.intel.com>
In-Reply-To: <20250808173601.77F1A90A@davehans-spike.ostc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7903:EE_|LV4PR11MB9515:EE_
x-ms-office365-filtering-correlation-id: f4f4e8ab-e671-448b-7d67-08ddd6a30408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Nbx+bWxHQjc4+V/c3n1Nk26AVl8x4i7KaEnA2/Ym3N+LFB0lbCLXkWePQuax?=
 =?us-ascii?Q?+a+qizaOv0XfWhS8JXaU5IELEA6RnacP7VcuHF3pUzZpEAZTejdAU+0Vntey?=
 =?us-ascii?Q?ClLeA9wfYwTAFbyQjmmMRGJDrV8DxrtgeuJAir2ktUViQPF9yJTwr5469eRb?=
 =?us-ascii?Q?NoZKuLYDlyF721by08dTB6ZNmQCOjRlboVcYq0rhkq/vgwf+79EQfADzSB9U?=
 =?us-ascii?Q?Z9lKc+REqLNIMiZdBVI4vKflJlRV+BsCnmzhpp4jsPWXF9Ch/p9ZV8OmqV4P?=
 =?us-ascii?Q?ZMKa+Ayi4cAsy0+Xlr/S0mQIeokxebdEC+AdEQwm6sdUTaPe74RYqs44bZSg?=
 =?us-ascii?Q?FxjHVrA+8kZqyPAj/JUdTYPiy8WRRnJv/9pgc1SnFHMsMEJ2Cn3QNIPSXyLb?=
 =?us-ascii?Q?uCjv3JqsxOX1tYBBk7Q6wr/rQiT2E1NCXPrwewumakuTSzHo7kjaIF1kDnRK?=
 =?us-ascii?Q?YE/gm4nctY2szpZOfbTrqDAWof3JmQaLannbVtRjnR78wGe2IN4lnGqUtvd4?=
 =?us-ascii?Q?Jaxv+cw/LzWWXocpPPd7CRx7VespESL5aoZOLLoJ3+utnqqtUGG4B97zjyvi?=
 =?us-ascii?Q?1g8eb6u4Loh3kdAuRhY89wNqxiGdjUAa7e8RgzgSk82W1gm95bABDjZkkeUF?=
 =?us-ascii?Q?XGZznN3sFBS2SgCMJzgIexph9FaYNIS6jubRvTs0jR0B95sx10bGwEKkEwdM?=
 =?us-ascii?Q?x/Yfkv5ORsS7rIsy2m8hQdLEUu4SfE0nbZEJOWFdhiIGBwstYwBo8jkXn22e?=
 =?us-ascii?Q?19Ozxwph6e9aJAJaI9c5zcev6OPa2U4fcvG21S6Ju9lZSOA3OYYRF6NS6Cp9?=
 =?us-ascii?Q?NfwVwurFj9kXvVQXrxq5MI7tdxA3qS/T/vqHaIzCCejnTjjhy1OY8MDHPJ8j?=
 =?us-ascii?Q?HqPc+sPRoZzSy7zhxN8b+aSceWiXL6TOQroJeHs86aMxPyuPblbvDQnqQ2m8?=
 =?us-ascii?Q?TEWfQg0dDfrIX+DXHGv9QR24qoKl3cNrtulATmHPcPiYh4HxP1u7yoExeHxr?=
 =?us-ascii?Q?ihngLtdjHvPcw0BDtCuqM5wo7HspaBHmeS9eopIsIr77Rjg76xGWY1sCuHcm?=
 =?us-ascii?Q?Nrw7HlVZBL0wC26wHHgJhcZ8H3aiit0AzbYOs8yspgFNgfsKoaXQ7kEv9gYc?=
 =?us-ascii?Q?hz++l5E2ABH2wp1ttww5sF5HgnSmySWj6l0ChUqZtj/YQyZ5+Kp7Cx1SSKsT?=
 =?us-ascii?Q?dFR4F8wUtCua7os4wtdaSpYUrW6GqqR5fxm3tmaDk+7BxJ/x33RDwH/AKT3R?=
 =?us-ascii?Q?aS5rOxTqJ0IbRfRgohKU6QnvE2lBaeue66CfRbvVK3oYswwPkkpBvlcATb1b?=
 =?us-ascii?Q?KKrtvgc1Z84uFsxMMJlZrixd8AaDeoKXmNp+BQw5FKewbsfKc0Kc1Ew3eJcG?=
 =?us-ascii?Q?KeErwJb1zZWZMhDj4LOgvCpUwDF2aiBeiJCtZFFNq3O+kRkRLHa8LrVtb+pp?=
 =?us-ascii?Q?FknK/ks+mYoiaaqoR8tUfCg2RDCcF3MwpR5LGYmi4LyFHeNZNJntAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7903.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NMH/TE67zAvXf7D+kxXUTfMlI5Ulcx4k5iTgM+93Gy9XDV9JtnwWoKck8qvs?=
 =?us-ascii?Q?5uvNignkMK1HO5X44AeafVg9D5VOZgw8s+Ch8agVZRSBCkC3kCrTvtgdET1c?=
 =?us-ascii?Q?hFvjRslgdy1v9WXZGVxhqw5GHLuEDIA/oy0J620+sYXUlQc6YRa8ItGxwYZW?=
 =?us-ascii?Q?/yITSoQ0GiAD2TGFdj41pXIuVZUFtnrFf8p+rqrlBAz1v0ScBlbs9jnYqfA9?=
 =?us-ascii?Q?2xQDmZwNkcgYqahm8Mv+23XGxQvaj+I6QGyY5nVmf5I0phDLUxvJp8x6LG2n?=
 =?us-ascii?Q?pUH1sBpGWNUiEWWAV9Ofabv/iZetWsLHeRh3WHKzntR3EehHbbDI/J5XK1Is?=
 =?us-ascii?Q?W5/DbfPjagMmrBlTGm8JJAMrQq5Jvx1Sbk4hvbpxyNX+mc3Dpdage7IB4Z+i?=
 =?us-ascii?Q?yzHk85ChEBwwkxTN28gtpXqLgLLiHfTo6icLYu5ep+u0qkeCORYBKlYqtvF1?=
 =?us-ascii?Q?tnIPtL7vPOTIUKazwqe1mgh/GyNeUMeBwmclNvD7Vjo3pxlPJi1cvZCWlLU4?=
 =?us-ascii?Q?SYqugBtprU0L7dGX2RMrCImSGuFgUx457fPAfHxjtrRutni93jH1Ry25noy8?=
 =?us-ascii?Q?I/A1vftnzCJEsTsNYfRFrQI9hpqNaXOT11SbQytWoKCRBbhaXYaxB3E2SFqH?=
 =?us-ascii?Q?O0plVwBPT6tnIK7DE2l06TKf1/3sX55PhWheoK68tVnYPNm8MnXZ3CRzI5ye?=
 =?us-ascii?Q?zHQg/TkVm9WxUsPeyALWRCMYOnIYQFfV5tKt905DxW2V7hg++T30/5K6q3rX?=
 =?us-ascii?Q?eTNzw4RzZgEoRAHjWq4uWj6nkMz/SL8XII0Mf+kzuA3SFCuZrVt+cVZ1ZMSk?=
 =?us-ascii?Q?FL6kFiNWx/7xlO0UJjYLjQfRfVbyWL8XNw3PVjjBczElBGyi8IKJjYd0iOrK?=
 =?us-ascii?Q?vCDuO/1CWE4zigCD5K8KhoEMhMPmue+MamvYJHL+IIO4v1QJn+z36Imi7GMu?=
 =?us-ascii?Q?DCqluiIGm2GoZW+OhIfvemxSfnsBjKaAevEJl84py8vien8VWKC2a/81iOma?=
 =?us-ascii?Q?mCnTBgmY4qgVmG4c0FDTeMqVL+e1at1eysuoFQhS4/LCducma+HnP7KMyQ51?=
 =?us-ascii?Q?QCct2JKHIMKES+Isp2S22QgOSk7mPso/WPekT5Uy6Mms3o+EFHxCx3MTWjOD?=
 =?us-ascii?Q?TWuv7si1jX+4y4SpL9hTng6mUwvOW6LWGdrXhD9cHcMLXPA6IBvjSQJB5P6M?=
 =?us-ascii?Q?L5fkqFg6VcMzvteafTbxue3zhf8UJtQZ+jdyaWd+CKIO1DSafI0R+JI2z3vU?=
 =?us-ascii?Q?5E4pDHEDlW/vzGpBgqy6+NZyNZNn1KPpcyE4iWniujV8qiQeAj9Su8BJyp4C?=
 =?us-ascii?Q?vhrKK1yWppeah1pOhw3+O07U9z1fzazQ5/0gpaI0KF+graSHdWAotGim5ave?=
 =?us-ascii?Q?Bo8Xh0bopA/qY351yYtLDYCzYVaXq6Y2natuIdn6bB8i2ICnOuiZNF0dPNmI?=
 =?us-ascii?Q?bT7wQPefVRvtQr3dFu9L5aNeG0F0g6xt6aK9n/1C1PJ0PQhMHniUN3YNwb6E?=
 =?us-ascii?Q?u5Bu1DviP9uJELCa9AmzlMEj+AyCqXvP+AJQB/6bItURzek54DRfQLlDwtwc?=
 =?us-ascii?Q?jtL0oCCjkZB1uZw/H40BrX2wCACJX68I+ukwEWHJ5l5vOzKHe885XVuwh3EU?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7903.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f4e8ab-e671-448b-7d67-08ddd6a30408
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 17:42:59.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVcxlb05O7yj6+1HceYYsxgwRNYhtmXzSfx3qbsXpoM4MH2J11ZpeSAj4ghku08WLNE/avAaofoVEGO3aG3W4wFSiGQllKqj2HGrgi4kKyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9515
X-OriginatorOrg: intel.com

Acked-by: Anitha Chrisanthus <anitha.chrisanthus@intel.com>

> -----Original Message-----
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Sent: Friday, August 8, 2025 10:36 AM
> To: linux-kernel@vger.kernel.org
> Cc: Dave Hansen <dave.hansen@linux.intel.com>; Chrisanthus, Anitha
> <anitha.chrisanthus@intel.com>
> Subject: [PATCH] MAINTAINERS: Remove bouncing Keem Bay maintainer
>=20
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> This maintainer's email no longer works. Remove it from MAINTAINERS.
>=20
> There is still one listed maintainer for the "INTEL KEEM BAY DRM
> DRIVER".
>=20
> Cc: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>=20
>  b/MAINTAINERS |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff -puN MAINTAINERS~MAINTAINERS-20250707-1 MAINTAINERS
> --- a/MAINTAINERS~MAINTAINERS-20250707-1	2025-07-07
> 11:02:07.348257231 -0700
> +++ b/MAINTAINERS	2025-07-07 11:02:07.364258636 -0700
> @@ -12255,7 +12255,6 @@ F:	drivers/crypto/intel/ixp4xx/ixp4xx_cr
>=20
>  INTEL KEEM BAY DRM DRIVER
>  M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
> -M:	Edmund Dea <edmund.j.dea@intel.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/display/intel,keembay-display.yaml
>  F:	drivers/gpu/drm/kmb/
> _

