Return-Path: <linux-kernel+bounces-866759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C6C00954
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1E11A081A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D2930AD03;
	Thu, 23 Oct 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mClKUORF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15C30ACF2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216802; cv=fail; b=iwKz0XX0vZsrIjQKY1pLSZoUBbIXzLmSWnwfMo9zjjDgSqC3S0WqXXKyhJNV4QNudf4TWo+hULMUiEPMlnsP72fqad6zjvpsWhqw+ulxICndE1Ai9g6Ev7GM7abfEnP6kdVj3E5ogEriaI43iBmHVRQXjkc2VClEGVdIODSgBVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216802; c=relaxed/simple;
	bh=z5aX9LS8OQmv/UevHkv6X+Ghixsm0ygoNCFS/M/RvsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LzKCb9fr+p/r3HfVGLwYUh0/uwtcvZ/yXDGAXKf+hqXtm9vTq5G0BOFufY/tteNJOlJQetTOb74ITqm+0c+/Um33ca0jxPRIit+3RQzRq3nZC/jBcngICJAzvFkaJAlbTzsb5ap74/RBMFZGOq/C/x9PIfKKRgNU2uYN77/JNoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mClKUORF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761216801; x=1792752801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z5aX9LS8OQmv/UevHkv6X+Ghixsm0ygoNCFS/M/RvsI=;
  b=mClKUORFJJ7sAzkHcQMvB4/YgnW/Jv3l8VG1e3evoQJA9vIhNT1Sslx+
   W8tMooHKRRyJEJ9h1vyoqaSX4zJk8KnQeklkN/xQyEGQZZA5g6ZLo4TYU
   k4pAQ2D2R9SKSJSAGaSp2YjCkRr2B2TVaYNo5CQMHWDO/LWLO93cdW3h+
   dQyFuS1ZEfd3asmbw/PLso/+2mrFlriAswQsfyji3PeQODpexXNjX3flQ
   z6mj64suFH8ofqeHSxXAF7qzDcr8axO82Bnp5Qg2XHtTWAFT33LtzlddK
   cRQ714pSi1WL6JfS+X3uy844G+8UnhvyIgHUwXRFfvbK4eBTbszBHuK8V
   g==;
X-CSE-ConnectionGUID: Gk1PzA96TTKBzFGvkpcHUg==
X-CSE-MsgGUID: HhUmRHG3RpCX4yroW1IX4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67219503"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67219503"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 03:53:21 -0700
X-CSE-ConnectionGUID: c64o4cE4T8iBrnlJr0L5iw==
X-CSE-MsgGUID: NSb6yEhnQM+pmEPsY2I33w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="189259216"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 03:53:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 03:53:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 03:53:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 03:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUPuItgaUf9KLxR53xm8v4hP+WIXL5CSvrlOGLvsY6lgpaqD3IV2SCsXV3H6uXWOc05x5s0nhBwAy9eiMzbceuFzk4A5d9iqWV/8PB6/8SKb/0mSPGddItP8AzQYEV7LfWvjWUu3o5V89m/kMxt9cvzHzPwFGN9V76YcmgTpYDEmx9OsrpCv+5MHjhoZdB0R5RkwsYnXIHvk96SqyGX/gC5NvcmoKlrL7NLb7LbRvEHjO7EWB/yxZoufETbMiJ67zXVaWBYZnaIiZzx7P7YqAjxpgesg4JY/ebw3/3mz62O0Ku/V7zYHQqF8rw5EJ7HTr8cmQrNU0UCfxRqw/HJOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5aX9LS8OQmv/UevHkv6X+Ghixsm0ygoNCFS/M/RvsI=;
 b=X4xrM3IPneCJ7i3/N10IoQssujl0IeO9IzXe5CcSOwg4yiQ0kNd44PBUke/qckirS7VtfTUyfIHD9a6TMSHkAAzkWtVCjcriojeIYl24JpYUSyWocYiitTfgHYw3abmrmBHCVn92q0+mfQt3rUOgwwZrrorj85zp1n04aA7JOJ9ghKYYkx2Cm3I3RMq1l5CY/peRqMhfhbtRw+/9GLklCnGdern5PfE5YZIpcop/vhN+ioannmM6VvV6DTI7wpyqdb/op3H+D7U5Y2m5hCWz7O6+jqLHFT/qSXs7oD14OfsjNeP0TJ74n1zVP2XQVn8FCLtKqZTuW4gA/cTgM9FDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA1PR11MB8839.namprd11.prod.outlook.com (2603:10b6:806:467::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 10:53:18 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 10:53:18 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Abliyev,
 Reuven" <reuven.abliyev@intel.com>
Subject: RE: [PATCH] mtd: intel-dg: wake card on operations
Thread-Topic: [PATCH] mtd: intel-dg: wake card on operations
Thread-Index: AQHcQQvroNhSaCIfh0abEtSYk7POBrTK0Q8AgAAAQwCAAY4gcIAAT38AgAAGp4CAAt2h0A==
Date: Thu, 23 Oct 2025 10:53:17 +0000
Message-ID: <CY5PR11MB6366DA1D185F4FF2C01EA3B7EDF0A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20251019150145.3228079-1-alexander.usyskin@intel.com>
 <aPYKRvCenwnrFXcb@ashevche-desk.local> <aPYKfhTDF5kXulz9@ashevche-desk.local>
 <CY5PR11MB6366D892E7B6FDB112751306EDF2A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <aPebJrWsqMCKmMpX@smile.fi.intel.com>
 <mrnepuygncvslqg4mxxedsyiujdw4wqp4ofvykagwzycnn3pda@jzockckj55tt>
In-Reply-To: <mrnepuygncvslqg4mxxedsyiujdw4wqp4ofvykagwzycnn3pda@jzockckj55tt>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SA1PR11MB8839:EE_
x-ms-office365-filtering-correlation-id: 79a82bbe-3e23-4c29-a12c-08de12225fe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WEU4dWZPRGNvWVhCcDRHWkJtWFpvZ21ydlN4cXRYWW1CdGlZU1d3WkFma3Iz?=
 =?utf-8?B?cFJFVVlBejN6NTlQQ0JoNnhxbjJXUDJvVi9CTWNPQ3BtT0F3RElJR2ZabGJD?=
 =?utf-8?B?aXBHT1UwWFJWdkU5UCt6UkR3QTZXQ1lDZkNyS1RrQW55TGJiS0RRRVFaaGto?=
 =?utf-8?B?bjc3N3hZbXJmaWFzczAyaERiVXdPaGNOZ1NENGk3VzhJMjFyTWVQKzlIdXRZ?=
 =?utf-8?B?ZjVwaGdtRkZEWGxoa29ZTmFVTGd5TWlQK0daNXhUdWE1T25ZMmg2cjBSbkp5?=
 =?utf-8?B?YytRaDMrRGE3eC9WSVBpMTlXaFRTSmdheGJWQTV4TWhHdzYrRGFaUFArdElK?=
 =?utf-8?B?Wjl6QzE0S1ZCeHZTT0VONytlMkV2NGNXcmd5NjdMdDZtQUl2dXplSXRDZ0pt?=
 =?utf-8?B?WXhTMlRSaXFvZ0N2NWV1TWIwMWthVFpnTmY3N3JUMHBQblFtUFpyejVOSTJu?=
 =?utf-8?B?bGtPUFRVOGg5d1hzM3VIRUFSOGYrYytKVHp3eVdPbFM5S1NJMmttQjBBTnNs?=
 =?utf-8?B?T0MxQWlyQmNicnkvWGo0am1FbXpuWkVKQ2QxU0Uxa1dWRWI1ek04T09jU1FT?=
 =?utf-8?B?dmwrNi9mM3g0a09SeDlSRDh6alZBeGY1YWxjOUVzemVSWERBLzBKNTQ2a3VV?=
 =?utf-8?B?UkFRa2Q5WE9HY1BqcjdQNHRtYWhSNlBXam1wWkpXbzFoVUIzenlHY3kvS3Nn?=
 =?utf-8?B?RGpmeVpFTEoySXNEUEJQVXhBczREYUxxYlRDYk9hUXRQbTR1UlloS292Y1M0?=
 =?utf-8?B?REJacEg5Tmh3NWsrVWt0OXZHNXdkaXRqZ1o3cDcvZWYxRkt4cFNqYkxtemVi?=
 =?utf-8?B?TU1ZSFFYN0dSRHZlZjB3MncraFNEeTVhS240ZXQ3WjdxN3BnUUUyWExQejhm?=
 =?utf-8?B?Ukp5clEwYnlxZWF2N0hjcW4xakFkZHdFcUllQTRIRmI4WTlTZDVJeEl2cWUx?=
 =?utf-8?B?Z1QyQVg1Y2FSUHdDK0xkRFJNbzZqSk9wZFhHVGZzRUFxVEM0a05nS1UxemFU?=
 =?utf-8?B?L0tZbllQenV5NUZ4UkxCWjRVN2J2VEd2SUJpMk91aTd3eXRJYnNodTQydTgz?=
 =?utf-8?B?a0ErOW0rd0c4S2xyam9Lb0hqR0VHaDZpclR0emViSEJkTWN0bTdUNXdGc3FP?=
 =?utf-8?B?T1lDT0lZbUNBa3E3YXY5L1h2d2N2NVF5ZGhFRGVESlp4NXNCbFQvZkVzRXdm?=
 =?utf-8?B?UXF3ZDdmV3htbHllUHNnRys3RmhxZUZCMXdGdnc4ckQrWDJmcTZLS2o5Z2h6?=
 =?utf-8?B?eXh4aXo0SU5wMWJmeXd1S3NweG5ETktxTnlDUGJXbG50UXdGWUlyQlpFdWZP?=
 =?utf-8?B?Rk9rcUN2NzJUZlA5V1JJc2RBY081ZnZFaTduampjTWlDTUI4VmF0KzJOOXFI?=
 =?utf-8?B?dW8wUnBHTHdHb3hrQWYrQzEyMVV6ZkpXOUxGTnEzazBLY3pSK3JmK3ZuS2ZW?=
 =?utf-8?B?cTJXcXYyU0xNMDVHeElJWkJWeldIRW1lUkhGZCtDdnAyejZoVExGZFMvOUlt?=
 =?utf-8?B?VmNxcmV1VDBQS05jbjFDajV2bDVPR0lFYmFkNTNuMmtRSjl1Rjh1QTlHM1lU?=
 =?utf-8?B?SGpZQy96a2ZtR01scnVxRjRyTUN4V3YyYkx4VHA0YW1XOFBSMnZWeC8xZUda?=
 =?utf-8?B?cmhRbTJqZ2YwT3J2OVN6UnNXOENGdndlZG84WnU3RTFpU1pmM0p5OHBvWWNO?=
 =?utf-8?B?amFnSXd5RGRML0xVVDdwSW04TWplSUhHNHFjblYySldUTDlFRnBwUUQyKzB6?=
 =?utf-8?B?ZlhrSmFGeENuSURQR3pBMmV2eFdEYm5uaWNjYlVrc0x5dFg0eWEyaC9DZGNa?=
 =?utf-8?B?WVZhTjNxTDJLZ09rUU15bG5HNDZTajkzUkdWMmtRMUNqYlJWajhZVFZwYmVC?=
 =?utf-8?B?TncrdW9UWDY2cnc4aGtuZ2FYRUJOT0FJZURiMDVBSndMODFwaHAwNzJMQklj?=
 =?utf-8?B?ekJkNzN5ei9YYTdIU3RXWFhKMVhENlM3RkM0YVZFby9Oa1RLRmZqbVRQSUJ4?=
 =?utf-8?B?YzdlSUZScXoydXBkajgya3JkYXRoaFNFamZoQWkyYXhLWWJUZWRUazU4NFlQ?=
 =?utf-8?Q?PLScZT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXZja25ZSGJkSXhmL0ZWek4vaURZL0NwZHR0WUJIQ1hMNzBGOFpWVnYzRFNo?=
 =?utf-8?B?TXl3R1IwOXVVVFhCY0xWdDMvNHh3SlovZ3c4bS9sbUhkSGJCQmdRQU4xeDhP?=
 =?utf-8?B?WXlvYldsVldiZkg5T3ZIdS91NDRkL1hHV3lvQkxjN004OENNLzdKcC9JY2pP?=
 =?utf-8?B?Z3dsdmh2bFdjcysvODFFaWJXZm9ZcS93TWpCNHpFU0xpSFBOeS8rYlJ3K3FP?=
 =?utf-8?B?V2hwUy9rSmVES2E2NjRuaHZOMjV1eVkxbHVvYlpVZGFFNlNUNWRVaEtjV2lJ?=
 =?utf-8?B?VVlGV085blJsYzA0QS9aMWxsZWh1d09pV0ZIaURhbk0rWUsvRyswNDczQ0ht?=
 =?utf-8?B?M1NBZUxBcWlLdENkblVNdm14aGx2UUNIZXRSVGE3UWhwMWhwK1dLZUNMVW92?=
 =?utf-8?B?Z1djWEtZUEd0VUMydklGWWVwcUhnNEFqamFNSlV2cWl6Z2VzYTQvYWVNVHM5?=
 =?utf-8?B?TDVIcVYxMUxGTXAza1daMTV5Wmw3Zm1RMmFqVXo2Y1pGeWpNaldFbXNSenBG?=
 =?utf-8?B?ZDZHdmFZd1lxRzRsRnprZm1GS3NkcTZRdyt5V0EybUFYTjlQUjAvMFVkT1ZM?=
 =?utf-8?B?RWQ3WXBSLzJrYzVDdDhkQXlZOUh3UzY4OGxKU201UkVqWDA3VHloRTNURXc0?=
 =?utf-8?B?WXM4bWlsSjFJM2pwK2FnMzlyNEEybUFBaVVzUjA1cVFKRngwU3c4RWtpN0tD?=
 =?utf-8?B?Uzh6S2FBM2ZST2xxOWE5NllzdERZNWdTNjNHb0ZmRCswWDM2YjZIUUh2NXMz?=
 =?utf-8?B?UFFUa1prY0RmajN0N25jYm9yQVBoaC9LS0JHYUhnM3l0dG1sc3dHWFl6UVpj?=
 =?utf-8?B?VlBIa2N4dDQ1M0xhU3VQNUNkM09qRFNEckpQeWpDNHM5d0lVYnFBbGNOOFJr?=
 =?utf-8?B?cTNwRUE2bmFpQjRyV2pxVjhiakNUK3hEOFh6VjNZdkNSUkJYc1p1WnJuTGlD?=
 =?utf-8?B?MVpLWGUxcUprL00wOU43MkpJTWVNTUNxSm9vMkVhSnVWWFhnaFJNbHRBVWkz?=
 =?utf-8?B?VjFZdmtoSzdKTkNHWmxYUy92ajYrR0wycmIrV2pBeHk2ZWI1enhGYlZIaHRH?=
 =?utf-8?B?cEJMdlhPbmZaWHFVb0lKUytMcUxUajU3Z1NLT1AzaVY4TkJiaENUeDlnWUoz?=
 =?utf-8?B?NWxRZ05STlgyU1JsUS9EVkdSdFJ4WWo3bGkyYlZMZHhlNzhUTmNSK3JTK01I?=
 =?utf-8?B?ZHRYdFl0L1FCMmh6U0p4bTJNS0pKOStNbHNsY1BDcTJ6Rm0rY3FaZW5uaERI?=
 =?utf-8?B?ZEd0R0lhL1JuQkh5MXZTMkZzUDJSeWExdGJDbzNvczgzeFBLeklPRlpwYysv?=
 =?utf-8?B?WEFSYUlMcEIxSjh0ajg5MHNydkFDMmk4aWc5R25JUVloajRGaXN4WTJPcGNO?=
 =?utf-8?B?N3ZacnVhL3l6SldreTZFaFQwUkp6ZmtpQzRLVUo2djRCZU1tOUVEemxkQXBz?=
 =?utf-8?B?SVZDejVzZ3Q3VVV6VnlMQWJlUTE1aFoxR2VJK0hncVNHNVpGWUNwd213ZG1t?=
 =?utf-8?B?MHlTNlZCdnFvM0pPc04wN0ZTZkVXMlh5YUxBdzhqem9jWUVoQjlXV1BzUXB4?=
 =?utf-8?B?SXRmekdrQzd6L0dFL1JEdnN5ekJ5VjJUMFpnMjdvd0x3YUIxSUhpeG5UOVAv?=
 =?utf-8?B?clVPb2toZ1ppTnYvWTN5WHJpMWpQMGh2NEtISnh1MC8wQlRtNWlQQUxwZTJE?=
 =?utf-8?B?QU5GQWhvMHdLM3RtdDZiQlJWREhLNzNiMW5ZS2QrbkJNRGQ0dVljcFdITEFs?=
 =?utf-8?B?VWZmcDdBM05yYnNMd0F3SEh4b2tKbzJBeWluMFRBK1hSNjY0SXZzd0RUUnhK?=
 =?utf-8?B?N3dWY3VWZzczUmRhV0FESWNmcjd1Nk9FYmwzNzBGNzg0aEREbThpMU1TRWNr?=
 =?utf-8?B?emRjMnNITTdBK0htQnV4T1ZYbDVEbk1pbjFRU1U2b2dES3ZkNkhRNWl1WE5R?=
 =?utf-8?B?eXhucUljaVBDYUZ2bndZU1J4UUliQ0t1RkNidzkrYUpUcXZMK0RKUUlZMFhY?=
 =?utf-8?B?V3A0MmRvZ2VjK0tYcXhXWHVSeE9HQlZ5c2FHL2Z4ajJ1aHRZK01oYmZMcS85?=
 =?utf-8?B?VXFmcWllT1dqaDJXZUhxTW5QeGh4cEU0NVNIeHJhanNSR0dSZjhta1kramhm?=
 =?utf-8?B?Z0hOaXNrVGt3WnUxSm5QYXh1WGxraFQrdnJuM0JIcWRtNCs4Rm1HcmY1TWZD?=
 =?utf-8?B?RVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a82bbe-3e23-4c29-a12c-08de12225fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 10:53:18.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CBmjTfE0/NoY9oKQrFTLyUIFRXxaw1rlC1YEEcj1qjkX4nDu6q3ARVKpsKykZuhHRw0+wYvUQScRayz/YA+7iwIuapdvzQn5Q55Mzf3jXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8839
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBtdGQ6IGludGVsLWRnOiB3YWtlIGNhcmQgb24gb3BlcmF0
aW9ucw0KPiANCj4gT24gVHVlLCBPY3QgMjEsIDIwMjUgYXQgMDU6Mzk6MzRQTSArMDMwMCwgQW5k
eSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+T24gVHVlLCBPY3QgMjEsIDIwMjUgYXQgMTI6NTE6MzBQ
TSArMDAwMCwgVXN5c2tpbiwgQWxleGFuZGVyIHdyb3RlOg0KPiA+PiA+IE9uIE1vbiwgT2N0IDIw
LCAyMDI1IGF0IDAxOjA5OjEwUE0gKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPj4g
PiA+IE9uIFN1biwgT2N0IDE5LCAyMDI1IGF0IDA2OjAxOjQ1UE0gKzAzMDAsIEFsZXhhbmRlciBV
c3lza2luIHdyb3RlOg0KPiA+DQo+ID4uLi4NCj4gPg0KPiA+PiA+ID4gPiArCWRldm1fcG1fcnVu
dGltZV9lbmFibGUoZGV2aWNlKTsNCj4gPj4gPiA+DQo+ID4+ID4gPiBQbGVhc2UsIGp1c3RpZnkg
d2h5IHRoaXMgY29kZSBpcyBnb29kIHdpdGhvdXQgZXJyb3IgY2hlY2tpbmcuIEJlZm9yZQ0KPiBk
b2luZw0KPiA+PiA+IHRoYXQNCj4gPj4gPiA+IHRoaW5rIGZvciBhIG1vbWVudCBmb3IgdGhlIGNh
c2VzIHdoZW4gZGV2bV8qKCkgbWlnaHQgYmUgZGV2ZWxvcGVkDQo+IGluIHRoZQ0KPiA+PiA+IGZ1
dHVyZQ0KPiA+PiA+ID4gYW5kIHJldHVybiBzb21ldGhpbmcgaW50ZXJlc3RpbmcgKGlmIG5vdCB5
ZXQpLg0KPiA+Pg0KPiA+PiBXZSBzaG91bGQgbm90IGZhaWwgdGhlIHByb2JlIGJlY2F1c2Ugb2Yg
cnVudGltZSAgcG0gZW5hYmxlbWVudCBmYWlsdXJlLCBJDQo+IHN1cHBvc2UuDQo+IA0KPiBub3Qg
cmVhbGx5DQo+IA0KPiA+PiBUaGVyZSBhcmUgb3RoZXIgd2F5cyB0byBrZWVwIGNhcmQgYXdha2Uu
DQo+ID4+IFRoZSBwbV9ydW50aW1lXyogZnVuY3Rpb25zIHdvcmsgd2l0aG91dCBydW50aW1lX2Vu
YWJsZSBidXQgaGF2ZSBubw0KPiBlZmZlY3QuDQo+ID4+IFRodXMsIHdlIGNhbiBpZ25vcmUgZmFp
bHVyZSBoZXJlLg0KPiA+DQo+ID5Vc2luZyBkZXZtXyooKSBpbiBzdWNoIGEgY2FzZSBpcyBtaXNs
ZWFkaW5nLiBJdCBpbmNvcnBvcmF0ZXMgZXJyb3JzIGZyb20NCj4gPmRpZmZlcmVudCBsYXllcnMg
YW5kIGlnbm9yaW5nIGJvdGggaXMgb2RkLg0KPiA+DQo+ID5JIHdvdWxkIHN1Z2dlc3QgdG8gYXZv
aWQgdXNpbmcgZGV2bV8qKCkgaW4gdGhpcyBjYXNlIGFuZCBwdXQgYSBjb21tZW50IG9uDQo+ID50
aGUgaWdub3JlZCBQTSBlcnJvcnMgKGhvd2V2ZXIsIHBlcnNvbmFsbHkgSSB0aGluayB0aGlzIGFw
cHJvYWNoIGlzIHdyb25nKS4NCj4gDQo+IEFncmVlZC4gV2Ugc2hvdWxkIG5vdCBzaWxlbnRseSBj
b250aW51ZSBvbiBlcnJvci4gRml4IHRoZSBjYXVzZSBvZiB0aGUNCj4gZXJyb3IgaW50ZWFkLiBJ
ZiBpdCdzIHNvbWV0aGluZyB0aGF0IGNhbiBiZSBkaXNhYmxlZCBpbg0KPiBydW50aW1lL2NvbmZp
Z3VyZSB0aW1lLCBhbmQgaXQgZG9lc24ndCByZXR1cm4gc3VjY2VzcywgaGFuZGxlIHRoYXQNCj4g
c3BlY2lmaWMgZXJyb3IgY29kZS4NCj4gDQo+IElmIHRoZXJlJ3MgYSByZWFzb24gdG8gaWdub3Jl
IHRoZSBlcnJvciwgaXQgc2hvdWxkIGJlIGludGVudGlvbmFsLg0KPiANCj4gTHVjYXMgRGUgTWFy
Y2hpDQoNCk9rLCB3aWxsIGNoZWNrIGFuZCBmYWlsIHRoZSBwcm9iZSBvbiB0aGlzIGFwaSBmYWls
dXJlLg0KDQoNCi0gLSANClRoYW5rcywNClNhc2hhDQoNCg0K

