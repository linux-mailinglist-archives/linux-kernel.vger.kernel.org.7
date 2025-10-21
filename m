Return-Path: <linux-kernel+bounces-863204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8BBBF73C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F89B3A91D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9B342155;
	Tue, 21 Oct 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xw9LOzOv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4EC341AD5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059020; cv=fail; b=aP8Qdnq8i/7Bsn9b/t4xHw5Ios2zKqyNJakwTjSebCPHRn7ACRtuh5Wnj0Vd5fZ4H5PksK6i57EnB+17Gj0IiKOyNczg13u5vxrHeUQfI5+vJXgSa5DT/5fTAIMltjqs80gut0JYGJerXHklEHQlHbXFtKXhbW4lb5+Gkxfpa6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059020; c=relaxed/simple;
	bh=SrnW76RdAFdaTMi9OkViFf/AJAyGOzkGORqY9xpXatk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eXw/XtY8qgY7mYXghBZU7I9yGptbrH+UhMncrOF22JJhvtgeLaH0+0gbiRk5USl0CIb+1HD4t35P5LW6AjWcBDhQzh9F+zAH4/Z69XtCrijVND15ckiYXGQDMKiS4aq/L+GxnlDfG9v0f66C9L1YxyweaVyzwiqivnYza45170w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xw9LOzOv; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761059019; x=1792595019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SrnW76RdAFdaTMi9OkViFf/AJAyGOzkGORqY9xpXatk=;
  b=Xw9LOzOvdSPWEhS0GjnQAjnjc9hxPZQv8RAvA9p4wUknzspgBizDkgpY
   ADVdwvVjJqGSMl74nfth9Hb5OjmuinzWkwIE/gS/uCbsBhbM0x6fTWKOg
   jiFuRep+3uYZ2pOtjav2bmSQGW1C+bR16vvG907qiPyVQoJmK98p8q4RC
   GBfqx5BEQklXXxcDjuMRvrX6stHkNCOin1uwZ9ZBOCqPmNZs+lj3cbv8x
   5F7DXnYh0HezuM86Es4Vua1samrK43THoOZRGW/QtXp802L/79R7Jp9aJ
   8p970GBWj/SyGsszqKkYj34mwh8LMAbGBH7OzkN1sy0eB0cNIqKaq1jkc
   Q==;
X-CSE-ConnectionGUID: l8LHqRvDTimWXjsY/k9IYg==
X-CSE-MsgGUID: HtaDqb4zQNmk1oLRqLH6wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67050550"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="67050550"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:03:30 -0700
X-CSE-ConnectionGUID: 1Ys4PmeFQASLAqqRQGiQvg==
X-CSE-MsgGUID: seE1wq8aS8uuV/UZpscVMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="220780967"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:03:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 08:03:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 08:03:29 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 08:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGyoyEmOoyJNqjJw9399uocDJtc45zcHjEYFb5v3DEtLi4bw4uMVpz000PJcJyBTkGuE2Oq1fSANHLaXhae/dvL/ore0+vrMwaPe/cZlgwi2zIbvfNT+4MYtd4Y2B8W6HEGxiXgc3rZLBQ7F9RtLI00e1LlhWFUVMhMAeqUZ3jY7s4Wx7DVrFU4oUgvr3eLisHQ7LFEoWXEqcbmv7pLQxcRrvBvglMiZd4usH098l6TWBjrmDiJIsmh4dX72dOYyDXQlaE6ln6oYyCs4t/A+IIz2x8sTYLfsLl2PwJ7/NqrH9Wv38GOAB/TtobjOQcpiAQ8E6gxLBsFepSEM2qvfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/wU/Vpe4vEVzymspFgQu7zNXCKvaeN/JHtn3g+KyHI=;
 b=F3GwD4ZRG3BAq7fn+tToLNg5oIdvHZsv92Hnqa4Uu06GrIWP5bwX59qCpjJB5xgoN/i8/3vgU6wKO2beE/BAw1BB5y4Nv100LLCtcaGQxdNQd5Lsz0gXY9OiyELjUdOEOCX2FVEbH12tQuWJWaG48yErSI3kJcfGVmr1ndmsxJjpu2yGATmF4OBn3Nzmqt6ib8LTXZJx7zsJOU/yeKGhdkE/15wagx5SeFMwg7x2YNKZmDHT91oNS/thTM5p3ZrfstJfDiaMwtH0PYAtDlWvBLnl86r8m21lCT6lFvnv174vWCVf2TqYdpw2PSIpY23ZG7vjc43A/z15j7mgDnTW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ2PR11MB8515.namprd11.prod.outlook.com (2603:10b6:a03:568::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 15:03:26 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 15:03:26 +0000
Date: Tue, 21 Oct 2025 10:03:23 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Abliyev, Reuven" <reuven.abliyev@intel.com>
Subject: Re: [PATCH] mtd: intel-dg: wake card on operations
Message-ID: <mrnepuygncvslqg4mxxedsyiujdw4wqp4ofvykagwzycnn3pda@jzockckj55tt>
References: <20251019150145.3228079-1-alexander.usyskin@intel.com>
 <aPYKRvCenwnrFXcb@ashevche-desk.local>
 <aPYKfhTDF5kXulz9@ashevche-desk.local>
 <CY5PR11MB6366D892E7B6FDB112751306EDF2A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <aPebJrWsqMCKmMpX@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <aPebJrWsqMCKmMpX@smile.fi.intel.com>
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ2PR11MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: ae232b4e-4c5c-4135-dd96-08de10b2fc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c27v+K0KRcgqNYRXj8qZgLGH7u/Pb/2GRq7ae9RP3iDC5P9K7o3DvO9mct11?=
 =?us-ascii?Q?sNM4NrtzxBU8N1hp1jt18fo0ISG2y+Q64KrmbC0n8glkCHJbtXHEUdjPs4Au?=
 =?us-ascii?Q?/83R3yKnQNHWnv//ZX5ZkXKd8b6kbhImGJs1UA+06NMouD8fCScInnhKnfhZ?=
 =?us-ascii?Q?1wmL8iDD0M2WrKC3Zp6zTWgHQDFrvmi0P0B0wePyhqhuah/B7nLKq2VSpwyd?=
 =?us-ascii?Q?lDNmVzJv51myP24jE8Ys3bnaiIn7wdywO+8K6cl/CR/hp5QYOOAxuLtFxMx3?=
 =?us-ascii?Q?CUK8636Wvjv4iP7biY4TpPmGCiTlUuf8R3cy7U57lOxX+Szs8QlgHh3ay73q?=
 =?us-ascii?Q?CeSPC9pY4hBs2NF6rUNpNM39KODqM7803r3xPeeNWbjNKK0Jrw8C2+CK4wv/?=
 =?us-ascii?Q?CK8htfW6cslKt8r/OrkPzTCK7ZxCciplg9QzxIbRSPaimqz+mB5phzyjfz9U?=
 =?us-ascii?Q?tSe6NJ/p6Ta1r5QARFsRX3Yghhtw3FBwe9jlmm135krdDf67ZKUUJ5qX991X?=
 =?us-ascii?Q?XB7l94u3Pg0dVJI5N3iHRRt8SXcMzqk4z6ZWUSdK9Mf6eSBE9jNev38wsxjT?=
 =?us-ascii?Q?6Z5t1Wa3skCMwlIZCOGozsO/ZU5yQroC6q3ava7orKIQmcGGK8ge/rouMsro?=
 =?us-ascii?Q?XvpX4IECtF0j0yn92loIzO7h0R2BW5suRM/+r/kz6wayhPgfwRsQ/zkmbgP6?=
 =?us-ascii?Q?Rki5dzkz8010WMdAUY0mS/+duKBcSad+XxD255up23qpnPDftZb87HXpoipR?=
 =?us-ascii?Q?cjaRqvmFk2vdLpVId6rVzCfSK+gVKkZwjE+BwB7Qnvi2c+hdeLODPff6xJPG?=
 =?us-ascii?Q?8i6JWhnKI1Tfa++BK/fieiTX41F2LN7E+FuKGr/jup1gdYwp0w6zhAJVpS3F?=
 =?us-ascii?Q?Shm/dEMDU+eIjLJ9jYrDv7XY8Pia1ikHKMbSpFE2ZZ3FotoUIzAh6joCXhMk?=
 =?us-ascii?Q?CE6Jjn3oAX3t/7thWDvvhIt8UY6zPdgxIFOHjZANQ1n/uKOhkINCfjWH9Xrj?=
 =?us-ascii?Q?QTG/FFv4aYjLWRWCBVXev3i8YfkbvgeyIgxTtTwyHb4sX81ga7BH6Uwarrjn?=
 =?us-ascii?Q?RRRBZwfd+Uz9KxTqo0pboeGkPSvSY7nQUFgZIrg8DMoYIeCcuqkJMCUWoTkB?=
 =?us-ascii?Q?ZyBAFrMsi3P531VHPYPDFvvckga+tvZ1kGzzJcpuYesIDDitGsc76U5WdXOH?=
 =?us-ascii?Q?c+3z3YWLk5RH/4t6ysPV3amQ1HTYxth6H1xn2lUjTyJlfTFjtcflpCfoP1bc?=
 =?us-ascii?Q?EOYLIzDjyXhfZN+RiLB/gJWfYzg3G6Tm2dnVa9OijiHmfT5Unb0tgIYaYPaK?=
 =?us-ascii?Q?fTgI0fAHrqsRfKvD4kWMsW5xNtFp5JC0xrRvJI7/cgyHTANuh10KYrbuhya3?=
 =?us-ascii?Q?sZiA51QDaG6mgQZHPJm+TScbVv2YpiuoDpaoJRYVo9T7HqHENqXuTHKd/Gkr?=
 =?us-ascii?Q?jp2rGdr4Go7ZpqEeJ9PU4em8e24L9tyC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/qm0FQvTyDYQQRHOxcsX+aHQQF32dM2J2ZsueW8i26dABmDIk/p0jFEi3ex?=
 =?us-ascii?Q?3DQxyMDT9WZyPOOWZTUhiLWU1dtVCsNPwuCb4z6JxY+gqfMnqcrwPi+RmhYK?=
 =?us-ascii?Q?Zs0A0UnBFrcflvwgNcy5sHnduDb0caJw2g6d9gc2q9+4nk7hgWSH27fKYXyh?=
 =?us-ascii?Q?jizon1FnQ4PINeZBPkqywa5tcjPkOQjk2+vfcDodAojOS5cogZOFNVK/8oCT?=
 =?us-ascii?Q?br7r9Vzd0YGhevFVTqrfUST3yrf7CawR+N16SWvTqMVOKyvy/UXGWb1MXjue?=
 =?us-ascii?Q?z2mIt+Q0cuWT+vM6LZyeA+Re/QXTW4KqUGnEodYlQiR/+QgRoWQ2Y1ZUHuQG?=
 =?us-ascii?Q?TNEIBa9059rrKn/H6HOHE1blG+7djxu/OkfdDi8USX0szgqGgq3HHUs3dF3Y?=
 =?us-ascii?Q?L0aYGn3RiItcDw/L8E9Vg3Zlvvy84B7O3Ik+JR0l5r3fKgETIrfsLIEVzYM0?=
 =?us-ascii?Q?nDBQXYL9XPJJcbmfe82ObNIJ5F/sLvQZnSBCG2jWh+r61sTFf/ANjQgXtz75?=
 =?us-ascii?Q?x+wu8SW47xh9ePRWTbcWM18j8ZvpjpB56HbrdrzCS6NFN3Whf447oJRtx/aX?=
 =?us-ascii?Q?nL4glgD5pNkLVmAxJDB2bK8sTPMKhh38LfM7+J+Ip7LCxrKO/opAoo9eCh0Q?=
 =?us-ascii?Q?D01WZd9NW7lLmBMVMbwQETONlYvD98si4hVUHN7i09R95N67x51oSh2SjwVI?=
 =?us-ascii?Q?6BpNqWkhVufgDcU7JfJZS/tBJIXbKr5KQC5FGuqYTaN4EpZ7ZQf4+E8C3Lzl?=
 =?us-ascii?Q?/72q38kW/RwkfEiJV10rOvBuPskLAO2dTbs5UCLgpaZ7prMUFVlDBdAWqWuf?=
 =?us-ascii?Q?YZ9omhBE1faHccLaIdIhXbtN9kZROCaxscKBcNZTHFkrXVzg9bGDBn8TzAaz?=
 =?us-ascii?Q?z7dl4D3iZazRWuh4r8THdv8+r9o6CZU9z8Tya0w3tpvv/u97xas3v0Ex9xw/?=
 =?us-ascii?Q?2q7j9GTgOjKEwX2g+YS8wIjlbfgA9iagoaHhcxRIKKLpDc6InSW6RHK5v9zJ?=
 =?us-ascii?Q?5Nty6pL04aDrSppORn3Wjx0W6LJRwHA4R3TOmgvFuVToXSw5Xy3rUe3FQesY?=
 =?us-ascii?Q?qpGx31/BLnIs2B+FNRb2L5tqienE13/JFBtrbsUakrNxz/bpzcfM0qjcQsHX?=
 =?us-ascii?Q?xjKoTKXxE8UWRTJw8E46xk7VWydaYrW6bRPpPVzbdB4o3P6kqxtjxJuEX4C8?=
 =?us-ascii?Q?XiQFqXb6eg9w1z3U44BUyAC0Y76XUa6orBIhCEQnmikzhvrZ1n8XzDDXXhxp?=
 =?us-ascii?Q?8ow7l28SC1WaR6iJ6oZtl/IppI9jo9DmNRkGxruvbEFeYEpHHbbdo7qKqg2B?=
 =?us-ascii?Q?mibU0uPUh54eD287pyXIlaVjAzRiVuvs+P96KjCiPIJeKvbCbuAIMjIsvL+N?=
 =?us-ascii?Q?cn54afIM+jnUjFEpK+7R6HJ8ZfnXtylNmDSkp5gmNbqIml7aiHLfyHwWqqZA?=
 =?us-ascii?Q?cRb9/vLFcere01FD61mbl3w2+zP1eacZmoPFUOlUwCyBY8xdD/v6F4tndCAU?=
 =?us-ascii?Q?hPK5amm2G98CFcIsDr2pEoxMW3jGuBx+h1OpsQ6ILQZ4knJwgEz/JPxEM+/D?=
 =?us-ascii?Q?NB9brg03uaiX7TPZ6p8Wob3EIcWLJ+n4D4Nb/FIDAepISggX6nJsMsFgwVS4?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae232b4e-4c5c-4135-dd96-08de10b2fc6f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 15:03:26.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4pBLhK0pArmkw+H6Wm3sr5dlw7fPIDjvys1kbx4tn1CFWSI0AkMvykNrR9t5/el1PaC4ZqZtCse9Klr/N+2lSHwZZ1w1UtyrxVMGIGOMqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8515
X-OriginatorOrg: intel.com

On Tue, Oct 21, 2025 at 05:39:34PM +0300, Andy Shevchenko wrote:
>On Tue, Oct 21, 2025 at 12:51:30PM +0000, Usyskin, Alexander wrote:
>> > On Mon, Oct 20, 2025 at 01:09:10PM +0300, Andy Shevchenko wrote:
>> > > On Sun, Oct 19, 2025 at 06:01:45PM +0300, Alexander Usyskin wrote:
>
>...
>
>> > > > +	devm_pm_runtime_enable(device);
>> > >
>> > > Please, justify why this code is good without error checking. Before doing
>> > that
>> > > think for a moment for the cases when devm_*() might be developed in the
>> > future
>> > > and return something interesting (if not yet).
>>
>> We should not fail the probe because of runtime  pm enablement failure, I suppose.

not really

>> There are other ways to keep card awake.
>> The pm_runtime_* functions work without runtime_enable but have no effect.
>> Thus, we can ignore failure here.
>
>Using devm_*() in such a case is misleading. It incorporates errors from
>different layers and ignoring both is odd.
>
>I would suggest to avoid using devm_*() in this case and put a comment on
>the ignored PM errors (however, personally I think this approach is wrong).

Agreed. We should not silently continue on error. Fix the cause of the
error intead. If it's something that can be disabled in
runtime/configure time, and it doesn't return success, handle that
specific error code.

If there's a reason to ignore the error, it should be intentional.

Lucas De Marchi

