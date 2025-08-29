Return-Path: <linux-kernel+bounces-791088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9FB3B1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C90C3BEAEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFCA223DF9;
	Fri, 29 Aug 2025 04:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3Y/9xUC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8318EFD1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440412; cv=fail; b=uTFAA0JWy58XEWUZwCq22LxAgC5IOdAEZRpkC1heXXMQ5Hqz1D3gIXa2sDKpQgmMQclZvn60GKKW8P/tnnrNPx5nVuxOz81bzfJBTYzIUCfZzHmeMDRImti/c9b2h9/R991eMCNCr0u2Tm1t6eHvgJBfSWHbO6iaiQsfRM6yu7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440412; c=relaxed/simple;
	bh=APPlk67A3O6HO5lS5szAgZhhxjiU55BrtPQ6mtTa35Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lX+E3IKsULErOM/MQbTbTRbf565ONjZ0Skd2xBifyut+GYLXDy30xA1yhboaNIVFZLTXkKjCzCrMGemopHHNdVOWD17rRANv7a05ochAhs1meTdXpVNtoTPvNDgdIkIadr3/A9x0KlzxOryZxYZhzyg1FrOzsOTRX8WM0MJ04Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3Y/9xUC; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756440401; x=1787976401;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=APPlk67A3O6HO5lS5szAgZhhxjiU55BrtPQ6mtTa35Q=;
  b=D3Y/9xUCLWkg/I8YZa7h9BreBQM4MUuWa/S0nz2bI5X4NbaUdCJsool8
   xBgCOlMn3o+K0syl7yRV/6ETpuzM9q8YOg8+GvimPXeze0wf0Whf+4rjI
   79YQFaEymgudK9RKW1cZRDrEN5j4CpddBWHOqOF6zGA5vyCb+qn4m+QtO
   MSRfLCQkGcGhI50307Pv941SD4PPYI6Cwa488HKlhl+d/NN5eJoD+DrPR
   FCodjih1ZouO1CmwB4MUV0yWEOvwv7yQoBZpk+L4YOcGLp2WSO+qDA0BZ
   KAGNdin//SuY9gHbMNVKbHUZrLpDXhECEEyE4F8wH6ule+M57S+JVzbbX
   w==;
X-CSE-ConnectionGUID: 5Ul+O07rQ320CynN75ltsA==
X-CSE-MsgGUID: +GHtCKu/SneLbRO6O/2stw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62542067"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62542067"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 21:06:40 -0700
X-CSE-ConnectionGUID: L3jZK3yJRJqN85MQt6WUgQ==
X-CSE-MsgGUID: EsMlM3OeRBukV1sV0i9mNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169810956"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 21:06:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 21:06:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 21:06:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.82)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 21:06:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XynxHpVtOObBeUdWrVTuFWWCXaTH8Sd7lK2gGL7J6xb7eSSoSnz0vX2ztOM9QI9Ez6U5BYoDG9k0QC2Kd6VDjegHbMiCUtsXKryeHx2Nl/XnQPLGujntHh5kVDaSqbKcljAUJ+594rOJ1AgrXwX0scif9LjkbDYSJ0xn3rzYzFkQ00JaF2ag776sfZUqLYOznEUw0/AJOxlxSCm8fBYmV1UNxkGg5HKjPexZYZXhsZIB0fA+ZIX7CjUYcTx0doXWR6a17CCKBoInZks2SvdXK6lJSX4AxQeS5bfhLEXsoftmeFn8mEBP2b1NkwlGXKXv9LYP4PPks4O0E3BvuQBbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHjkw6bzQtHnZn/N5W7p/ix9W9/aT1TU1dj4+IGzqPU=;
 b=xCqQP/8aW2RslhRZ/CbSUHBUB3vOC3ZJ9APm7hdkkzLbbMSoD62qW/f6QZRjLI/22WmWLYZ+KhRsZMxE/xLXTu5ZebTp6Rn/l+nFC9NO7V2deBXciL3QCLuOFFOt9GXo722LYtNrokLv8NlN+MybuOUYoNQnBrDXlwJi0D1e0F+8EcWkNiBGSgxMmB71VXS+lALjnh+P0qZ+EvJpxBdJZ8GbFPoakEC8PulfHyVhnWmC+3CeHtUAK0chDzyk3+sXx/yIhhJ+qJgspsgdq528s4i0b8ePU+Ge7HGl318swRTqhDtb2WQrDct/2OdvGsw+vXE29BD4AksSQ2Qg/w/Mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF208195D8D.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f13) by CY8PR11MB6939.namprd11.prod.outlook.com
 (2603:10b6:930:59::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 29 Aug
 2025 04:06:36 +0000
Received: from DM3PPF208195D8D.namprd11.prod.outlook.com
 ([fe80::7aab:2a1f:f728:eb01]) by DM3PPF208195D8D.namprd11.prod.outlook.com
 ([fe80::7aab:2a1f:f728:eb01%6]) with mapi id 15.20.9052.017; Fri, 29 Aug 2025
 04:06:36 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Aaron, Ma" <aaron.ma@canonical.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nikula, Jani"
	<jani.nikula@intel.com>
Subject: RE: [PATCH] drm/i915/backlight: Honor VESA eDP backlight luminance
 control capability
Thread-Topic: [PATCH] drm/i915/backlight: Honor VESA eDP backlight luminance
 control capability
Thread-Index: AQHcFCfgko8NgNwlVkGoJILZvjU6V7RwL3iQgAjbapA=
Date: Fri, 29 Aug 2025 04:06:35 +0000
Message-ID: <DM3PPF208195D8DF8D9124C8D4AC48DDD0BE33AA@DM3PPF208195D8D.namprd11.prod.outlook.com>
References: <20250823121647.275834-1-aaron.ma@canonical.com>
 <DM3PPF208195D8D635C72DC9769044D0850E33CA@DM3PPF208195D8D.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF208195D8D635C72DC9769044D0850E33CA@DM3PPF208195D8D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: jani.nikula@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF208195D8D:EE_|CY8PR11MB6939:EE_
x-ms-office365-filtering-correlation-id: cf1bc9bc-cd8d-478e-35ca-08dde6b1727d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?Mq0ldCJtJpSl8m8Z1EHkXwiikpwha4ofCwbS1/UkEAS18TyFLj8fASSc8/bR?=
 =?us-ascii?Q?FZpc2xMexeBiU9niKLsp63DdUfx4e02QnoZLDnqLfG3NA5hJjHu76HJwrPuZ?=
 =?us-ascii?Q?b3laXjL3rMi5kAaGlFAKXhei1a7HHnTbqb5+kktdjAhq9Tpk1AAWZhMQRS2d?=
 =?us-ascii?Q?BgdeIe2D+nGAcCDovmp9lQln3LhuX5ImyaVD4UH9tNNvejqsKfNAgWiDNxYv?=
 =?us-ascii?Q?fyYC5mfaG32KFcMlDhz6o3ueADJJaLVoOzkPkZVPwlP/MGmfBDrW9P7Xa2G1?=
 =?us-ascii?Q?fYNLNgNHkM6I3GNyt2yU/YROT6BKzEObOmD6ug2nV1bbXd0mHYElzFfOhuN8?=
 =?us-ascii?Q?8tc2aUkjvZCnJZFCY7cL6UgcsQBRAZY5I6TbZ8DWQYRtNOI9Snw4ZvMLrML7?=
 =?us-ascii?Q?y3iQsiw5COcD86wKtCn0kF6R/zE6dm3E9aIGOH1aFCDpS6hU7AQNHtAHXkEB?=
 =?us-ascii?Q?NSc4SXF33jazygtxCB3KC94cO+MXCSItzQfNytllY6YBwTijyFhKcHJyZc/B?=
 =?us-ascii?Q?uKTLxD7P/8mw0ERdLZTqccQDTUt0T/nTNcjKlCELgY1OOlXzcjpTbmcXehuK?=
 =?us-ascii?Q?dbB36N47buw25/xZ2dkR2GvqMWUQrEHNPc91r7cPJH7cF+WLeGuhx6L/rtoy?=
 =?us-ascii?Q?IVu19cxhhiGzoPxlqal1yqasoKMwYkE7evX7RkggsFe5iDljqEGJPVaNHOMp?=
 =?us-ascii?Q?/hGMQxSL/mxgMuehwY6ovGVNyRGBu2Y15KaBiR+oOq7PK2tDPhc4B3vcuslw?=
 =?us-ascii?Q?dDN6EtAQ+lvXP1oLCDoAlzF2b6a5/x/P8PDpf6Qsi9RiXwVhydSfBS6+puM1?=
 =?us-ascii?Q?KqALHovy/sik50GrDbJZbSOZuPKYHcsRy6F3/J9rG2KUTQdkKXAcAO+0lzmY?=
 =?us-ascii?Q?OUGRSs94wTSnsgG8d1AAf+cIKSCNsPI+2NTa6+42y4jg3uE0KCsPtuJKDs3z?=
 =?us-ascii?Q?diS/pZ8/TF2QSE+ZOFpTZnGESGSor/wbUDjjqlat9+bwRVdjoZEFBHfgQcfb?=
 =?us-ascii?Q?RxjTCmXtKmah0yuTU3K7upbcVaTcaKRpZHyPzmDrzvuqSk6lscXRCSZgjL48?=
 =?us-ascii?Q?OIlumUHAo6TZoJRT0gi3Fre3HuhzZ/H304OmB80QI75hegstFUgeWXx9/Any?=
 =?us-ascii?Q?FoN/PkiXgaN0Ua1pGSTm3K10oIMA8DvscJNLIbfFDw/yF1p3OjhbfBKq0cEL?=
 =?us-ascii?Q?LxznuK2AboaLR+1CXk4533BG2wxR/OWkVi2SKoKoOUlUeWHyiY2bNZsgPFd5?=
 =?us-ascii?Q?L5DNOShzANTlDW8zCynIv+MT3gHkbzWk5+C9DhagYy+piaZBcXkeTAbiIvhs?=
 =?us-ascii?Q?bQCedHqILP0KolKrNCvVqA6eeDC3MjE+eeo0FU3mDZJwInH1JE6cOZObM/vV?=
 =?us-ascii?Q?K4hf8IRZP7DVYzp/HbdLvN92i5Yn3HzuaMyLjzUgYUbhgJOiNf9NjztUUR9i?=
 =?us-ascii?Q?DK1B3Jq8K1dqKXLmFOL9vI7LzSSg+Nnruc0TycPryyNBpmJ7ACH1ts32ySro?=
 =?us-ascii?Q?1vTDPew9sTHpZgE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF208195D8D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?np+6s2xJP+Mbn3qE5gdbz/6xBC/CzGTWYhxJxsa7AoK0CuDrerMvs9kclMDR?=
 =?us-ascii?Q?iZPIdcY9sErL+U4yZCdeBvNF4EVLzMyWIdxCqc4nYkqbaLYdg7GD3fz7QjtS?=
 =?us-ascii?Q?nrDDzVmOa88vlh2BxsFxbF1dHmtKCXKqQVlcgUZpIdrxompe3RqcC5GtDdoG?=
 =?us-ascii?Q?fNC3iMDTO/VTsyJ97zOXmkkJYJL23upx/c+0A8SPX8YW51KYSKf2+V5ZP4pK?=
 =?us-ascii?Q?0/Hfg/mPlfzE9SjtgYPnLXMlWa1X4Z1tabGoX9u0/jCcNmXwp2SnXY6IlCrF?=
 =?us-ascii?Q?htA1Jdh/HzhcEBw1KtoNTZ0gMzq0gN1dpJiNwQo874K+Vsp9FpyPJK284/s9?=
 =?us-ascii?Q?LGmb7bxebzzRLK/XYauJve8HyW3GhtbEqsg4kXTozJWSe4429vzDEGFrRLWw?=
 =?us-ascii?Q?t2v7jtgOhfVdwnUeJhcfLWbg560IBQn8ZXvSlxM09BoJbJoZJWzCXPMTIn/u?=
 =?us-ascii?Q?UdFQlSmiWBRYjYkgoaa6brNO/uiksb8mnxamyv0WfrF+fOeCT4NXAtrV4iEV?=
 =?us-ascii?Q?v7ZEsRa5bTKdXb9h8yH/jtD0rWlqfgAicilZ84OIqAVDRBAlA+cc76uZhip7?=
 =?us-ascii?Q?SVcLgggf064E4YbNQFeEZJs8iHqJZidi+JEMM741dkqSkcG/ywNJur30Fqh7?=
 =?us-ascii?Q?UrRfGKBbgtZPD298AMFdDheP2/7cZelMpCHR7rLz0TJQ/bsmcxg7Z2UQRdmn?=
 =?us-ascii?Q?RowzjLPpX9OVzAOpdDTb6TruyU35PdO69v6rqemrYZBuDN0Rit8Tjdb6dNEP?=
 =?us-ascii?Q?2MKAegeoQKmBirZAhQeu5oUie6Nw4x3xOm7BJB9GSa+M4COvLH7U1r4MFYZE?=
 =?us-ascii?Q?L0WjDXNDos2x6vp4Dc1JzlTD/bNTT/K7lEIlF3RohkgZ3nXLIzyzV9oETxPK?=
 =?us-ascii?Q?PMEDIPBySZP2MQKvxvcKSAU0h24pxqkoJcmdTM0/6/oZYjhWCvt1nGZmLjZz?=
 =?us-ascii?Q?mvH4oI+TRgW5YmEmtwonWumUqsPy0XyRoOxLJOmo6NsAWoaJTUx2whaUvTO8?=
 =?us-ascii?Q?Eh8nZez15V5phTCp3XlQvE4XMXjnrAug0Ucn+F9JpGMVN5JH3mZ7llHcAhkt?=
 =?us-ascii?Q?HIPTTtv/c9RvViZ68h2/sGuulnZGRatcmmVUg8UNc4ryzuXZa7EtEVXFMg12?=
 =?us-ascii?Q?aw7Nqxu7D7PrQihigxZVbPpzzekpGMcM/AFzqrHqLXswyFCJ6q8+8YKaK0j7?=
 =?us-ascii?Q?7LIITqHi/gsZnVlFR4Zea8vMuk+b/LDtnHWHJK/8Cy8QwqOQPRLcKJZRmRll?=
 =?us-ascii?Q?KucPC/NA4nAdiB5oWyutorwytVvfEBUHwJMGDX1eBmShZRj85Mnez6xElA1R?=
 =?us-ascii?Q?sSMtZ03wDLreL37KW95f8VZsl212Lu/gsB9TDj8CXmOqqUxMjhxUAnLg9MN3?=
 =?us-ascii?Q?FqtzmR+YpJINzKhLOQT1p8v+5iXUW951UvPYOk/dMvvp5PbYRqRkDfLPMO1B?=
 =?us-ascii?Q?RjFjeKUO32lNq4ffZpjQTyDxpt4QwBdVd3+axu01ynNZnWhmzZ8wA0wr+PgF?=
 =?us-ascii?Q?nyfMripIAVKuwVuayUYwvS725k1w7LWNIQK9vvm1R0W5n4/hvQK3giACTa92?=
 =?us-ascii?Q?tZ9Fcysf+3QQtfMVFarr6RpI8Zs6izJjQRiLus5+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF208195D8D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1bc9bc-cd8d-478e-35ca-08dde6b1727d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 04:06:36.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7NRX9iDCwcU+4A1xWTj/kYWopUZGZmKPiS+/RP7dye3nkhZX+EUxeXMmfwj+2qFS1zBgH7lhZ5cFLMFF4PqeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com

> Subject: RE: [PATCH] drm/i915/backlight: Honor VESA eDP backlight luminan=
ce
> control capability
>=20
> > Subject: [PATCH] drm/i915/backlight: Honor VESA eDP backlight
> > luminance control capability
> >
> > The VESA AUX backlight failed to be enabled becaused luminance_set is
> > false always.

Fix the typo on 'because' here. Also fix the grammar before merging this
to something like "AUX backlight fails to enable because ..."=20

On an unrelated note @Nikula, Jani the commits that this patch sits on exis=
ts in
Drm-misc-next but not drm-intel-next. These said commits were merged I thin=
k a month or two back.
Now do we proceed merging these in drm-misc-next or get a pull of them in d=
rm-intel-next

Regards,
Suraj Kandpal

> > Fix it by using luminance support control capabitliy.
> >
> > Fixes: e13af5166a359 ("drm/i915/backlight: Use drm helper to
> > initialize edp
> > backlight")
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>=20
> LGTM,
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
>=20
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > index 41228478b21c7..0a3a3f6a5f9d8 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > @@ -546,7 +546,7 @@ static int
> > intel_dp_aux_vesa_setup_backlight(struct
> > intel_connector *connector,
> >  				     luminance_range->max_luminance,
> >  				     panel->vbt.backlight.pwm_freq_hz,
> >  				     intel_dp->edp_dpcd, &current_level,
> &current_mode,
> > -				     false);
> > +				     panel-
> > >backlight.edp.vesa.luminance_control_support);
> >  	if (ret < 0)
> >  		return ret;
> >
> > --
> > 2.43.0


