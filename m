Return-Path: <linux-kernel+bounces-878171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31871C1FEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38C5A4EC5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FEE3128A6;
	Thu, 30 Oct 2025 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3e1eVMW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC822C21C3;
	Thu, 30 Oct 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825929; cv=fail; b=dlUzuZ0ceVlBD2P03C8chKXTUQIvIwd6dVMkaI/6cYDM92QJXEH78iM8wkS5zZ1bGq6e4dpvnQovoQz50xSLrLjZOk5SkKHaV4r3RoW076B68nKXNOBKnaBCzeQNgZfvD01XZw6BMXc6hsB4Neha2PkMPHdAPKK64C/N+8MljBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825929; c=relaxed/simple;
	bh=eXEbi240WvUCXGN2+jqdef4XiGW53e1tBVQc4ZVj8Ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E22t0iQmXiQssPwrUjkZKSAuxg7HOvBFNmK3iO7dEcXOPNh4OfxPaL/w5xmaIoTQufL4Dz52g4210vqRWPj+S0FcNDUawRj+tfpi8n64baXd60fQyycqzlMfjOlDwZgxiZ+geuqmWTWwKbXE7202YwKAqxpgNz9BQq4LcLvvAPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3e1eVMW; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761825928; x=1793361928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eXEbi240WvUCXGN2+jqdef4XiGW53e1tBVQc4ZVj8Ho=;
  b=O3e1eVMWw+Cecjox03m0WTfLWkvuSFtf5oaFPg7pWsJsndC7fEcvz9u/
   Xq4kP1qI02qp+D/r1Zxux5Vf20mRbc2YCYLU2Q+VOCerzg+Db5nL/Y4ZZ
   Yiua7ArEvkjSg0bBoVna4xkl7uSovyQZ35AuhMTZcAMWeNZf8EcKYB3Ia
   F0RSLvkNFtCVm2sDN+WNibL0ZWnjzt1Pp7dySiLLgu6P7vElEN597arH5
   Net55iChnOCK5gPeeOO8v4HhUpKbNE1wBCcmylnamPe6ilNMn6LpY4z7b
   zi8isOtoYivtivIGNiVNrWBThlq9FnNPR/1hwL2BCWdAOgh8Baniplr+3
   A==;
X-CSE-ConnectionGUID: rYkSfFyBRbqa1hYeMm/miA==
X-CSE-MsgGUID: SN1xHGpJSiCEpfUXajyVTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63849794"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63849794"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 05:05:27 -0700
X-CSE-ConnectionGUID: vDvhraKQTRGDtuGBkmXgaw==
X-CSE-MsgGUID: vYPhe0sWTFSDQA4jFDyQyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185596440"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 05:05:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 05:05:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 05:05:26 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 05:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkwoPpou34Rc/R1fJLPKrZMbO1rREAavsox63+nnnmz3SS5ID9IkjT25H5zLQFgCPOJrh8G5sQUm9gH6/ZpKPgPPoT8LmwmnLLvzo8dtEHMHM//gy240wWKwwvI0OW5CM3AFmFrvm3/EfWlV3zVm0+ddBG11hJ1p6RTStSfm8G+asnQNrLdiInsmr2+LDBosqsu3jgHbrpBKMhKYIMLTps3bS53YiEyD+q6cR7HAtAwGcTn/5YoWDCaW11c99ILBHnhwnXJvBV2kbXaX6E8W1yLYa5Nu7p2VZW2glCIlEv7MAmbDEQkXiI1jOIVEZNPgnf63zB+A8z6peVEg1Z6pCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg6kbZXQFOlvjOEK86Ho3HNgcAZUNzF94DdB2Opw1Z0=;
 b=i0ewe5reBY1Uv8AjkOiwq2sNRzhZk0rn7l1E85gvnkQ/fwG8Fg7VQWTj72S5TemKYgdetbyCW4lb340KE8zv7lRz69HfCOAdUxQBskmP6n9f54KCuT78zYtq7+TrmATkxd42j3G0O/RKqRp5uMD9VXM5m6pm05ofrffWi03n8a0qUx8q6mrpHgcPmAfaLXDPVd5ERic7epxtlWXsRB7SIP7QFde6BRd1BTUHdnqH9VXmIxkeyntOshxtnRpLXTJf+UIrAXV7NltUJ8xa46VxFQJRTS1/VP/Mt7R5VxqMWOXqsYF+gs6eMrtITeyvpgrg0g3AZ1kMovR25yUUGJBgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 12:05:24 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 12:05:24 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Mark Brown <broonie@kernel.org>, Bard Liao
	<yung-chuan.liao@linux.intel.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>,
	"vinod.koul@linaro.org" <vinod.koul@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>
Subject: RE: [PATCH RESEND 5/7] ASoC: SOF: Intel: export
 hda_sdw_bpt_get_buf_size_aligment
Thread-Topic: [PATCH RESEND 5/7] ASoC: SOF: Intel: export
 hda_sdw_bpt_get_buf_size_aligment
Thread-Index: AQHcSWthj4dqKz86pkW6LtGW0/eBfLTaipGAgAAM2RA=
Date: Thu, 30 Oct 2025 12:05:23 +0000
Message-ID: <SJ2PR11MB84240C3B09792E128D1D057EFFFBA@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20251030070253.1216871-1-yung-chuan.liao@linux.intel.com>
 <20251030070253.1216871-6-yung-chuan.liao@linux.intel.com>
 <fa2758bc-7149-43db-8dd9-610d97d86137@sirena.org.uk>
In-Reply-To: <fa2758bc-7149-43db-8dd9-610d97d86137@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|DS7PR11MB8806:EE_
x-ms-office365-filtering-correlation-id: 921cdc6b-cc00-4ab3-22f1-08de17ac9b54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?cZ2vkB2jF791oHqrW1oVjLGXHMZ0Pfd33/h/yV5/QyiXGru5HpNepise24V9?=
 =?us-ascii?Q?3BBdn+m2WgZpHPu9VyH1wG/u0LQX94IP7dluUB31BTXmT75NjD8YswTbdGLz?=
 =?us-ascii?Q?V8P5mwCL2ldtCfMG/5iAb5O67L3wBwaOdTsTjmqV6Aqe9TBHgyA7SieLpyS/?=
 =?us-ascii?Q?HQ0XgrxrrIHz4InygNa/09DK5ZOhKyUhI1FJNagrMDhP8BIxCkjxha2l8Y+8?=
 =?us-ascii?Q?R0VAXj9i2pGwEkTjam2+e+L8vC2hQGfi2kMOXDWUZl1L/ut5q+qvLDjOJ4zG?=
 =?us-ascii?Q?wg72qWOAM9Gf4zpHF2P8ww3VQ1ESveTPI4ydnCsKCv0tEYQC88TKPe1CErUr?=
 =?us-ascii?Q?HD0ntyYuPIaekuj8QO3mxJTve70S/n9HW1TzP846KTm9HdY//7rrIQkju62K?=
 =?us-ascii?Q?bdUWFGiiZ4YgL8jRAa2CnwzlhAxeMGhwGp9NlWTbu2ny6mWOsYHqjzw88rkq?=
 =?us-ascii?Q?gCkiW/ou8asoSunRrNzKbPVoxK864HM013vKxbLO7NIQvm3bDuONjFsvMCZt?=
 =?us-ascii?Q?McRn52sGgkIMa0ZFqOHT/oSzBQ4emFVakFfK3sHpsz7sx0HDYvRU3w41Umdx?=
 =?us-ascii?Q?JtWhBcS4QWUbWtLoHTOgIxbOkXT8SfYTUdbjsFsmibrN4auLLhj/FvTqy1Vh?=
 =?us-ascii?Q?l+lEILi4vagwBpYxndoHcIBH2XTaQtLX0rkHPwHG5U1C1MMAM+CFoTa6iem8?=
 =?us-ascii?Q?MDCy9/wa5mYckrRxQD1GE/t+Wqf/z0fIuYW0wvBADaakAW0g/yIxU5mc+pQQ?=
 =?us-ascii?Q?529iaWZ9dh2FwlCgSeMMogaCSE5+Eld2Nt/pRxJNFxK5l4Uj/VxI29ryj6XA?=
 =?us-ascii?Q?QCIMeivEEaGPMilOECl5vx5tXePhzLLMiaGKm1WnVSw5tl35t9zBrFzdkTlC?=
 =?us-ascii?Q?4W3Q/M800cygKOQB/zlLqz1nO3gucwYTW11h6t4bWRBTD3Qs7tW3yR58nES4?=
 =?us-ascii?Q?4W8tyTQSYqKuUlowhc65nJXS7pw89Fg+X4B2i5E3XS+02fGyHfQ+NYgbz7Cj?=
 =?us-ascii?Q?BX1w+km2/gqZAWjylyNihCP4axdnXJ2ZRp3SEEcWEQ8H4iv6Nwq5uVOzqHHo?=
 =?us-ascii?Q?hF/VtJ2TIHacanBXQIELBSjHaYShZdJtNRpnTGSEudnmtJQvXXTS6J2GTVds?=
 =?us-ascii?Q?VqnNzPFqhnXbIWrEmnwpnkRfMShomXtfFH7i9olf35Z57nLz0IjwRZK4S4Vq?=
 =?us-ascii?Q?ED26Keg5SjFyNTz13/L+szXkxp9SiLp+F24XR6Q+MMbZEDN8bGnnX0d05Ou2?=
 =?us-ascii?Q?bvOeZvTodEab+qfQ6JoRrtkVtdPgTernjk50BPMFcNKT8X6UiC9CHoT5jJtU?=
 =?us-ascii?Q?dySNmD2GTt+mVLbl39y9z4pylLQ4YmQT5ne/UwYk0YoU/Z0CnOncZH1uiGC8?=
 =?us-ascii?Q?+KqwKLYnGiugdXryJsgL9X4xdr919sH3hN8AsELyEf+a1hpMyLTAtHtgh8uH?=
 =?us-ascii?Q?cZTAHkiU8vNXM0GeoZ9SFoXE/FuWKSnwt00LgEPngdmUCsFrIryKy1zQEp0k?=
 =?us-ascii?Q?1g1G/nBdBaQLOxwB2ameRTk4rURx8buAk2FI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FqaJ1qSk6B+Q5QGQ2xqWI7owCeYrLn3PZw3arWPv1wj0klII3BRvJHoPdD9H?=
 =?us-ascii?Q?tdu6hQ+Ri0zM1IajDWVLtJrOC9Ig7Qk8JutO6VbtXEYXEKyT34jtEf5Z9vMY?=
 =?us-ascii?Q?gXVtO6XjI87V6qVvxp1JecUzOz1x6D6MQD6DSeC4vv9TIoazOd5QCdFIG+vd?=
 =?us-ascii?Q?9CanvjGVN0eOKP3H+PiP7IKvRfk4OiKRTCYmHjWPtkD7Gqzjvtn+9lawKL3p?=
 =?us-ascii?Q?Uv5NFKWpAMw888Ekj19BMe4sIn7GEqdrXPnMPtLwOWcqGNLaO6mPGkhNB09l?=
 =?us-ascii?Q?6HLJuODlLzra6Ie6Vd1w3VqTA7Kb03z4oPS+1DdZARX6ThweosV7d3LCZ/Tq?=
 =?us-ascii?Q?lC8viggkW+lpEDvFzNovThg3NpU3PxBzEds6YkoLdysDaemQmQvMv+dFf4nB?=
 =?us-ascii?Q?BSbOJLKEUlExZRs/WhfLNLS+a4ds1tIahQ5GJ2sULY7YT/SH6QHGCQuD4bcq?=
 =?us-ascii?Q?RJvnhLZrj98XHiBty4v3V7rCZ993Ca9zjCZsjwbUHn9miguqXzLe0BEDFcL/?=
 =?us-ascii?Q?gRYPS233cgHNDVOSR3b1SLWf7zzT2efFc93IJc/UsXKbGEwoWUFDB53K2FFv?=
 =?us-ascii?Q?CYKQsV56DN/k8CGDKTPBeUf6OwMGITjGYqb6w/qeDxo8ZOSssllvn/m6FSH2?=
 =?us-ascii?Q?7RFaZ+u7RlIk1MggBKSoK2gIjjatxDXMx9hW9nJ/tyPkS7rT8Z0QFcXVQ6sc?=
 =?us-ascii?Q?zXcscFaJQ4Qk4bIWnnbjHBVJVv1FUAiNcmQfJQEww7sZEx4+Ceu3OB8BsKBM?=
 =?us-ascii?Q?K+yvD6Fxf7DHZ1FhV/o/Uw+/QeKXJ2AaLgDxJ5MtuC3C3Y6obowdjqYKOGCO?=
 =?us-ascii?Q?P/eM3d2FyL4uJBi0bSnlPyUFYOs7F5bdsP29YpNk4ck6/qqm9Euzw74Zes7D?=
 =?us-ascii?Q?aoi2OhnZ9KLL0CO2GavIMisqfUW9wESZt6wA7F24cRUhxJIefVIdb0TAE0gw?=
 =?us-ascii?Q?e3COTLGCS+j02T74TMladIfhdCPwxNfPAZPEqwbBWqrJLdH75nyPgN6BdB/K?=
 =?us-ascii?Q?z5LzxKKuso71CN6SjcWGAFVHCAt4ihv/vpUuSgdq+NUCO5dVd1Lz2S2Ef+j9?=
 =?us-ascii?Q?tRvYXkHKO0d+KM3hZwEsE1nsveZTZxP7UNWmzlnvDWY/OO6DAE34wHMQtPSb?=
 =?us-ascii?Q?qr1H6GIympoHUZqCkPxvtYOmlOt1x9LR00hYQ4hQiRpUhUbKHgPM6b7W3qqO?=
 =?us-ascii?Q?jmfdMWlVl/j198FVv5GGAsKvziHKAtQ7smbBscVtMRVANJZw4w27bZjOlR27?=
 =?us-ascii?Q?nXtxgc5o1PsntAY32WiUVzrkq1OarWi4s0PFaIvKTsBLMDNp8EKPtoMLOzpH?=
 =?us-ascii?Q?YrsPnUgyqvRp577wjDeVWmQO4UUuhOw4duUTB1O3vkeR4W5U6/Cp7XcAXsbk?=
 =?us-ascii?Q?1ttyaYE9jmu27YySNO674u0dep6UcGXzEzqU1f8hLFmNnq6gHbwvpu8GcMox?=
 =?us-ascii?Q?zZp+yhP+CQ7HGVMkHsj9U3lZmy6/OlOVCz30JSQn3YiRVfkbtC8hMGCwDSWg?=
 =?us-ascii?Q?q/dD9WWAFYPQwIqkJYI7NoNVpd4VwdW2ppCG3X0Xi7V35krGXdc44/DgCK86?=
 =?us-ascii?Q?Y2HPYidb71/P3yjXnRiB3EFoADHlZS5ZtjCGMuKg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921cdc6b-cc00-4ab3-22f1-08de17ac9b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 12:05:24.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDUh0NjK0U8sm77dztrZVqYnv6BrOU10Yp1Dvn5awBjYN/UOJgXrYK4nVo9czkPrFypGOOyTVHBWs1Dwttkp4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8806
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, October 30, 2025 7:17 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: linux-sound@vger.kernel.org; vkoul@kernel.org; tiwai@suse.de;
> vinod.koul@linaro.org; linux-kernel@vger.kernel.org; pierre-
> louis.bossart@linux.dev; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH RESEND 5/7] ASoC: SOF: Intel: export
> hda_sdw_bpt_get_buf_size_aligment
>=20
> On Thu, Oct 30, 2025 at 03:02:51PM +0800, Bard Liao wrote:
>=20
> > +unsigned int hda_sdw_bpt_get_buf_size_alignment(unsigned int
> dma_bandwidth)
> > +{
> > +	unsigned int num_channels =3D DIV_ROUND_UP(dma_bandwidth,
> BPT_FREQUENCY * 32);
> > +	unsigned int data_block =3D num_channels * 4;
> > +	unsigned int alignment =3D lcm(data_block, FIFO_ALIGNMENT);
> > +
> > +	return alignment;
> > +}
> > +EXPORT_SYMBOL_NS(hda_sdw_bpt_get_buf_size_alignment,
> "SND_SOC_SOF_INTEL_HDA_SDW_BPT");
>=20
> The rest of ASoC is _GPL?

All functions exported in hda-sdw-bpt.c are with EXPORT_SYMBOL_NS.=20
I suppose it is ok?

