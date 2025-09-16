Return-Path: <linux-kernel+bounces-819265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C37B59DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560317B64EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138837C0FE;
	Tue, 16 Sep 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3UI8p7j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5537C0F0;
	Tue, 16 Sep 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040151; cv=fail; b=aLuKSlWx8P6ITeDl+pQiNpSwsPq3oqSfytUaqAdvmfeWGjUrv/so+LCTAl0F1724AU7aFG8uZ4khyOsIzMhrLHNuk60JCD0HREbKA8i+M60uYmLNTaFM4Rs2nmujUE/iQYU7FVnwliXrO0O8hd/KQA+lo3GDKW54KicvoRFFnBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040151; c=relaxed/simple;
	bh=Ydw6YAutcjpG7RyZcJ60KO1a+lu0apZ7b0EODiur7mE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kODLlSfuFiOeAUCIzIrZU0jYw2l7BLlhzUJWrnxAmcCqM4h7g99dYcdiZ/Mn2RpXUk69qLKvV32rsbwTA7ccarsD7ollrvH57dJooQLAdayzgjmKfUBKh6lAuyqHYzvCGhWcVJXLmYWQAgDfQLn+T1exNa0Hx7IAUbDvpdAPBYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3UI8p7j; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758040150; x=1789576150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ydw6YAutcjpG7RyZcJ60KO1a+lu0apZ7b0EODiur7mE=;
  b=d3UI8p7jQeSsr1MUM4M/y+1YvzQOdNeNaUkzi0tjDzwQFcxfFfewNngv
   lLvqiXIvr8XAmB907iLCn79OemlI7OKigLi/5cvpuPs9E6sHQ6/HWBTh6
   DLBIyawvlTnFyv3Itlf6z24iXIInmAagIDDq4zis3f4yRtnrBFCegyh7+
   F5qRUkKTDRFidnH3TKrSz8tHUILNKuWXz7TzoH2OvvurG3kc6uryRMtjP
   BirV5WOrjSP4TJhMip7BRxep3VHQmCGFcXygt+3YHctX4uRv5mL0s8Fwm
   /Cm3+vgQ5X9BSdVKOLxxSpeoKtevWLbQOemx0d6lWBaBHO9ci4r+PYy5/
   w==;
X-CSE-ConnectionGUID: o0bWllMqQWilVZiHYPgHrg==
X-CSE-MsgGUID: ZtgNguN+S+aENtC6SSrFzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60019745"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60019745"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:29:09 -0700
X-CSE-ConnectionGUID: Ur3Rv1wkQXyy4fmvQuXq1g==
X-CSE-MsgGUID: ZyhR8bDZRCajFtIS+dAJow==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:29:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 09:29:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 09:29:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 09:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emJinD6YbwXTosyJvBXdHzwcsXqhlvyYTHYtdiWSbaLcC0o4NB+1E7orXKfcnwiUnM7NLDnd88o4fP1/rJOU/zUJssvnmTWhPub3urXc5CFfPYcV3+n3ezrI01zAoPy9K6vTrV7uDZLfASpAQD6h4zbwfgvvrM9bRxPlw68yUs0YDfQmS5bmA9IIGGSJ01SsTp4iaQhSZTogugyUdAudKO42YEPKNrGNm7f5Y7Com8TVFt4f8BAuaMVN7ku6wUs6/GHvnWG7k/qHeQKQMJ6aT18bxza8HxbF259OR17Ioi5ZB55G6XG2W8uWVE9aWwDgw2h6lM+gDGoo3sha1qyhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X5QChNa/0s6DNIjuWQQe36wb6jlBcuc4HQtwhhlToU=;
 b=NufFFigWq7+w35xopi95h40txo1JGrYXoDuZdd0rxfD73XZxWW/4ps5krb34HISoM+DJU1GagmIqjpsNi9nBE+gLiHTP7/G01zk1ILyyGmK9ACPg+LK+Q8JuRLfjdZ2Z12rnNbQMbeb/Dlsci8dlJ4vw7//DKXSNlYH9dgPttPINB/EkpDbp5NOlLqcR5nwctBqBEr1GXd4qt2wITkeiAk1AZO+t0Di0wkHPa9MIh3bXgTxhbF419SXmzR/cLYNvZC5q1jta62ZwHRoElu9oNT9XVFyG6a5EFiqzvDPwCSW9ojJq9OrqnG43z0qH08Lpdk8yQh197EKHu2UioBwCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DS4PPF6915D992B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 16:29:05 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 16:29:05 +0000
Date: Tue, 16 Sep 2025 11:31:00 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Jaime Fine <jaimefine6@gmail.com>
CC: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <david.m.ertman@intel.com>,
	<ira.weiny@intel.com>, <leon@kernel.org>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, onur-ozkan <work@onurozkan.dev>
Subject: Re: [PATCH] rust: auxiliary: fix "initialialized" typo
Message-ID: <68c990c49ffb2_17e96f2947b@iweiny-mobl.notmuch>
References: <20250916124102.14182-1-jaimefine6@gmail.com>
 <2025091622-overlap-antitoxic-b8a0@gregkh>
 <CAL-mriLdm9NiNBvAqV3BEKVELJ1B1FsZtZL=NOsM_2RipoU0FA@mail.gmail.com>
 <2025091642-goofiness-camper-683a@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025091642-goofiness-camper-683a@gregkh>
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DS4PPF6915D992B:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d1a58f-7a53-421b-d9ae-08ddf53e2776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4rY99p0egy94iZZkpuDD14gTzlURWfr4+rNvsnJjQAxAQ9n3n5qJJTevROE8?=
 =?us-ascii?Q?qoa9MGrppanAaw4+RpiYp6P/b5VhBgWg1w43G+MzPqMvx0vC/lao4JZGFj+r?=
 =?us-ascii?Q?3iACrO1xSnaDwey+7LvqXOBoAR1/GJY60i50JTFIwIy1QoJjJBUUZEdZh4tu?=
 =?us-ascii?Q?K3uHTXh8C7HeOxge9ZI3RzaF/X9rAog2wDMaWNza1xsNZV78q3/+2YfjxSvo?=
 =?us-ascii?Q?mPsqqiVgkB/l/yESYYKNvN7G/WHoOUcqAkqgiuIdd9JQLSRM2B/+01eK1di5?=
 =?us-ascii?Q?XvJVHfS27VgJINO//oWcT2NVf8kAuRHVmkm3DUVE6GCcfkxMQyr2ZVAevb4n?=
 =?us-ascii?Q?dPMUHojkwlFPfMz1n+ASn9eHJnMuWXlAcR63S9xbGvdPu6i77IAi+DGl5WAk?=
 =?us-ascii?Q?O4gO+QXcIOp7sAMVonbe4g5jLukL0q+pIP41wyn2l8/SoUlauzBfi2NfuAjE?=
 =?us-ascii?Q?qbf6v0On5FeJqbYM6ZIZJC9jxqDJYQT5kKl6Vnz1sKHjlYPlJXb46jOGPn4p?=
 =?us-ascii?Q?W3gPa2ZukZceWD7nd8vF0gB7ytKNUsw6gY9WBd0yVjvMb8eK+SN3Y3kQXJlx?=
 =?us-ascii?Q?x/eC8Zyb+GGiGvTI+GHqmaGJwrF8ERgPOmIXt7eGNjm4co2daGDa9u+51jJS?=
 =?us-ascii?Q?hwWW5ciLNHhFLMXwbGoMCk9xLE6FKTyWRXsz8+OY/FD2dgTqrAiD/yQAR5RZ?=
 =?us-ascii?Q?AYu2gUUmEJF2hqd5RtKfwt6A1NdU33RJ1ENdR1Al7B/Q67suUPaGLGNQ8b3e?=
 =?us-ascii?Q?tr1vXaipDyNT+XRjew0NcQTsRme15iTMLABXYNVqHVTE9Yx7GCYHAUUSolyn?=
 =?us-ascii?Q?UTfiqHdkzT7IZPGBV62VcOpn+qfUktKOJWRYcA3+BD+ehr9EqzfHtDLNBHTm?=
 =?us-ascii?Q?qsNwP5D3YmNKuq1ABj39b85NQxHaInFYobRdLQKylXCbo3mKjoAfI7aKzcNy?=
 =?us-ascii?Q?bSN6OHLAFFrtJvBolqXUSm+su9lA7v8Qee38VTVVDlMV44Rux+PDwIE2T+x9?=
 =?us-ascii?Q?0GJxXylFA45VrM3ePFFkiGoaZZtJMrC9LTcWbowYHLMoY6cMhrxkTvJlmmmb?=
 =?us-ascii?Q?DzHjpf1yWcDccibvaOyraL/s1EdKNbTo/SWi7UTOUDuSjVR0KG8LWdjFeo+p?=
 =?us-ascii?Q?sTcAMLJRayIM8cP8cSbdyB5rGWNw0kbNAyxQYKLTfXMaoSOckUSfjx7L6dDI?=
 =?us-ascii?Q?Gc72akSHwVlUUSHEIlo/sKnqepVyyuOwjq6NygSNmeAZu5x5DSJS+CIFdQAo?=
 =?us-ascii?Q?cV2XSaN0WvDwh06N8Io0+o5RdNo6tZNqZeTPVenPrwMsETSnuqwzf0cNhpRR?=
 =?us-ascii?Q?04d3dAKwNUwGSAjL4MnTzWkLDz57Y3Jj8L+YY6ax95p+f6IjOnHzJgWN3XMy?=
 =?us-ascii?Q?0QcBPrIkwmWOQ7ZVsc2pmbPMdhXo+hT5jHhRuNU89vvuanDd4Sjnkd6fYf8m?=
 =?us-ascii?Q?68raeiC+sVc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DTShqb76Xc4Ckhe9ROzNV/bEdHBnwzbwHkQ8/cnLDTUTV8wx2ZdX+HQjGs3M?=
 =?us-ascii?Q?UymG3EDaouMdLnrk+nZe6aiYcvby1zrUxal+PdcsPJnr2rSFQCLF1bUVwd7X?=
 =?us-ascii?Q?ltgLXUSOqDk1SqiC8QjtlTCBFLuRi8AIBskPskdidwVke1nO8eSdxwXK8gZI?=
 =?us-ascii?Q?ppL14MfJMEcAvHOnFD7IfF/jWnzooJENWnZL5eOA6oJEVdMcQOn0ZaH/zdSo?=
 =?us-ascii?Q?K9cIaCEZ8ZMHoKzcla9bDCe+Nyqyobq1tTBQotI1Wbx1NA704nnO5RyS1CHV?=
 =?us-ascii?Q?6RohyX5RnkIhzm1dyLWcKiOGzcOdMxpO15xghuUvVv84JBAZnPJF9mKEHLdy?=
 =?us-ascii?Q?jYvpw8Byz2aRp3GnHjGFsTMoYwrqTPDRDPDb2frHixXysw2E6+Yb5ZojpIYM?=
 =?us-ascii?Q?aL+SXXrwJaGxa2eXFf0WHVsejymYdTUiR86e9PT4r8sM1SxSA0iMK9GUqv73?=
 =?us-ascii?Q?Hx2WPQBK2l3Z88tOuA6bw3okfnG5evp7XIqccNl8JjfZVi+pQKJOyJ/oreHg?=
 =?us-ascii?Q?4RuDV7c/XDsPABFnKlnnQbUKtlDh43LXPQX0IBc4BR2EXT6UgD03uaaNkiWS?=
 =?us-ascii?Q?S5VSBlcn1TD3moa/jPgn+/ixfZIYzkK6ke0WJK2AJtmH/U43k1gIdHdFX2g+?=
 =?us-ascii?Q?CHORRI5ouC2CHjXG9D0vZVZUP5/kJiAMHFizdlXaEFP7E2XP3xSdR/KNnX8Y?=
 =?us-ascii?Q?FSFEKMbT+hLLQ1L8IMWQltDYALlolGS+ZSiO9ZD8gsuvLZmEMkpS2OZJglpZ?=
 =?us-ascii?Q?2kz+ZYM4rBL8/XDNiY5cvyLW8BhXzquxHNXBFLsLmknIfeFcWoqft6tuOSCj?=
 =?us-ascii?Q?coC2vkqGCUWNsIwJEXL8A6eYSeHoGQ+wuyc7n3K5PYK7PiCGPKXCO9FxnfIa?=
 =?us-ascii?Q?kAN8py4sY+tKqYdpUVsQKfRpSotT76YHqQXh2ud7EAyyxmpRR7RGzyqvk1Al?=
 =?us-ascii?Q?yB30KAjuU8kemvimxz3KT669XAlay7s8t8lSuf9RoqjKxnOAs5Ze7n1fGp2W?=
 =?us-ascii?Q?P+cAcODFaT/Of48uR6iBt9tbc5Mbni/akCiNlCOlnKrHxuLVcuTJv9WfBFCC?=
 =?us-ascii?Q?0fW+h8iVj+y6Ilpt2lC/Fm3m/LD6X8zW/qPOWhFg5wCLW6V7XVv4J87bV0PN?=
 =?us-ascii?Q?Asn5Wrl/Tu1+735Yl4kJLS71ZE9ZagCFjd4E5pm6X/lRccv8WXgHQAcoRCpo?=
 =?us-ascii?Q?HCEyaxGlOPpnuN+FmIO2avClPFPdU+MGpljxYDYs3hudxaTmtXqb99L8NScN?=
 =?us-ascii?Q?xkrdNN2TYGwh3xr0DoqKiZvyH80zySDEs3Qt1+et94/4g0Pq0DmpVVLSbHzb?=
 =?us-ascii?Q?fobIaE+jeto4U7rnsMVSaE5eD5kZnZG71a9SUDjJpKl5yhqNqmo+Y3srztXP?=
 =?us-ascii?Q?9Pu0zUhH5DCgWbLvYNyfMaitjLSlIxJLrA6AnKuzvRCSYaFEWBBcrU0EiAie?=
 =?us-ascii?Q?S++r4aAGRiuinn2TJltm4uDUFmOU8+rURSGIps+6uNKfZ4Sxty5jUwjt76kn?=
 =?us-ascii?Q?qWP1+A0yarRcLD9axc3n2y0pzVEFFje6eH7rCcT1hC1OHpRqDfKU/7JK/iYn?=
 =?us-ascii?Q?9DhjnTGHHQmxFBlthbNtickOKRHn/uqNLmz/kgXM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d1a58f-7a53-421b-d9ae-08ddf53e2776
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:29:05.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKA45BEhyAgTlrLCgtyHVNaABLmKsHLtB77oYIAbnMVcldyR2tjqF6b98WRk4+3c0wHwh6NQNoHH8aR7NbHHzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6915D992B
X-OriginatorOrg: intel.com

Greg KH wrote:
> On Tue, Sep 16, 2025 at 09:01:49PM +0800, Jaime Fine wrote:
> > Fixed!
> 
> Please slow down and relax.  Take a day at the very least between patch
> submissions to fully read the responses and then do a new version.
> There is no rush here.

+1

And perhaps check out the b4 tool[*] which can help with tracking changes
to a patch set and help with patch submissions.

[*] https://git.kernel.org/pub/scm/utils/b4/b4.git

See the prep option.

Ira

