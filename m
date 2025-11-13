Return-Path: <linux-kernel+bounces-898418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FBAC553FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4B474E072A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AED267B07;
	Thu, 13 Nov 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxHThxdP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FD2C181
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997107; cv=fail; b=dMOf8t35HvUXBUO+V/qmTyQseSBCj2j5ql4p+lJLiw7+zQSqDB85KOOwqjposUE1UjhSfObFrohGAubkAebM4OdJsE2y+LlSrdkvM6WOr9boSDxND+1y+j41Jxi8z7OcuE7g10VZ6UOCXRujCuLk5/NkH2sAAB41P1B491HL17I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997107; c=relaxed/simple;
	bh=YyTsQjQwDu8v00rswlywrSt12ZMuE6YFZXQMWm45FjM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOrIxiGrGyiZLJ/gg4VjLynznr73chqWGJxKoJCF1OaiUNx5dap9naDBX6o7RKuSciXOnYm+1SqXvrstXssPw6MMYkye350Q6ELOpuGhZ/TQXMSt1V4rQyTK3fRzHtJbIv2BrHnqRuw1OeWu+uzWaS0JzZMSsS06hLnis3VCUiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxHThxdP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762997105; x=1794533105;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YyTsQjQwDu8v00rswlywrSt12ZMuE6YFZXQMWm45FjM=;
  b=mxHThxdPdZBP245Ngu0OkkZOIq/DcyhinoDFC/MCa7JC+aNr2EZitlCR
   Yc72GwwInDZQ5LJCc2yjswhy9+OBxE8qRambA5AffN7aEiJXtoXOGYidL
   ZhV8ncqzkXrdMFmofdXtHKWvQ8b5tDeUEUv0PTIhzYma7QiCFXUtfgj7g
   ngVXujB2Fkl38jsvA4DG9eAFQC032hDSTy+qqUnXD5d4S8Tw5OshOmCDr
   lzyR/MZgk41+P15vv6rFAcH8cNqo8mp+222sO2g/AXBVNB/bYsI1quFEj
   AjQiQc7zpHqxCcWJfyKCmWqhi4dm55CwDj/n39ZxsIO6eU8Wvv5PvN+LT
   w==;
X-CSE-ConnectionGUID: TAUbRHn6RzK/k2w4RpSn2Q==
X-CSE-MsgGUID: 2pkXDMHnSkmPDbeetn/Pkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="52633986"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="52633986"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 17:25:05 -0800
X-CSE-ConnectionGUID: dnTiSoTvSPmAOjCSLnVpzA==
X-CSE-MsgGUID: xifSSxM6SQa3kiWGXMMl+Q==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 17:25:05 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 17:25:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 17:25:04 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 17:25:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OewlTEi//typX99vX6GsS8hSlJhrbQVxXMEUe4rycxU9qXvaQZWCuZeYgTUvLC18T6TRjhXKwQkY2uNrrlwLM6q9FE1pwH+dbziginYtjYhesUaYIHfIKHYvFtPCsqecJw8A7Yk8/kO9cG+++J5jTdpPT570lbEM/OsUKETzwlGo45x2g6RL+x/cToqqRml/oosjMbaz5O/BHc3+e/0pDuNJQgpYczeCXRJYWh75nYAoql0A3dkstM5gJ3Tzf7CaD0k+usk1B21Qtvrw0YwLbqsNiyX1rvPvlzMOujfBt1rcvYAaKZcbr8cSRLRfoOjXXVe4hYFk/FYdyRmnzI/CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvc3mqMVGUtUDUrtsA8lSjD2JsRlXHRnhrZhT7Vvqj8=;
 b=d+wQOz5KJLj9fpH3P+97dActmrLDsynZ+rL7lK8Stp0Y5AkbEJ7c4uJ3Noy3hZEBl5nVbbCknBVpCP4TkHqXuEtYLBpDRrCGfRvB//1r6bbgBNPOa1FjlX0SERO0w1bqVvzB51x1K28I4xQGfIvlFysE35bxXLw+jOnpUBgp3DtSi/L/A3GDFTk/iGBdDpipGXT21T4yfOj/Sr/OitXahzzSJJDRXfC52wHgqQVFSYL5ThJ+cjFmKn8GBHr3DtenwG6jTYdXT2gLvECvwhSAMHPvMLHTwYubpBq74D8vV47PWO8Fq2WbPVSJ5thhwPBwTIo5SYKNHvbuGFImYjgJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 01:24:56 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 01:24:55 +0000
Date: Thu, 13 Nov 2025 09:24:45 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A.
 Shutemov" <kas@kernel.org>, Kai Huang <kai.huang@intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Retrieve TDX module version
Message-ID: <aRUzXbIAcv8vOyBe@intel.com>
References: <20251001022309.277238-1-chao.gao@intel.com>
 <20251001022309.277238-2-chao.gao@intel.com>
 <934568ea-b9a0-4ea8-b62f-2edfd2e64f9f@intel.com>
 <aPiNy8Q3uPrlVlug@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPiNy8Q3uPrlVlug@intel.com>
X-ClientProxiedBy: KU0P306CA0048.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::11) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: d474191a-928b-4352-38d2-08de225373ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sMFJpg8ViVO3cEIfxnUz8e3ntJE23REecbBi1N/MJZP8jNlDbKhxo8y4FOJo?=
 =?us-ascii?Q?owdO7n+fRuT2W6qfnpl33CeTiVqJwPOno0MtcgOE7Gf7OvKUzQNqRJKryIvl?=
 =?us-ascii?Q?M1W9rU6ufDW4JmyyKwRmPzwqMOQYbSk5TIe87ZHhuJG3bM1yDIQjdO61Voc/?=
 =?us-ascii?Q?S7SYbitU61vjUWSgNGYuTH9jCcqmyTE1XbdPjxVCTWqVOb9kpLtwsjLCiJJ5?=
 =?us-ascii?Q?9BZCSPuBW7dkXaPZ7kcwCaRGh8y0EemVh1YvdZaeyewjoBxeJIPi2N9oKdxd?=
 =?us-ascii?Q?8pX+qXpWNrwW/fByoWcnWfJ/fi+WO2Ui4tMJTZBCPy4cLgLBp7ApnysRdh4K?=
 =?us-ascii?Q?ZLs2RfK9MHdnl56hkno5KKHicJHU4VVA9qNFh9YpykEeH0mMchjHg3sSyvxy?=
 =?us-ascii?Q?sFBIvqBjFWvDbRvz5v/vV+Y9UX5BgJxw9Z5h9bKCbxt5PN/pjsYNcniMjeaP?=
 =?us-ascii?Q?kwHElxe0Y0guJbiteK8OrqzCCjYN0FyZyBrewJQMZboRqCfJHuhmYwrw8XtI?=
 =?us-ascii?Q?x+Bhc0LveyQou3yXPv4NH0j+H1n6eGcprtOtKyuUZaMaUvsMe/EdNFb+n2cX?=
 =?us-ascii?Q?SWlfxF4JJorJVVPiNId/KhfLSjL3H6evdbA2U3OVV8vVIiuSrS0KsFpfKku9?=
 =?us-ascii?Q?LIkOC6vAdejXcBYaGAo6E73MkN3PCyt4GeLgjsrHy/ZJRjocL6pxBr0mswdH?=
 =?us-ascii?Q?t5LhWCDq8ZZbGjCfPmu4egu5L0mBcHKWTVW3i1p1ze1MfjPtEzlGpstGTvRb?=
 =?us-ascii?Q?3PV83cukGnKeM/G+5lnWaKCzhq/VRuZ/vx6ciKr8l4xC55owY2zc8W8b4okc?=
 =?us-ascii?Q?PKTah5XiE7uotwrlYOr/qAgpl4PRVBth/8H2sQX/oFPyDtBaJXpWvTcC4nx/?=
 =?us-ascii?Q?15sk9EFEsZZSVKS+AoErL4wlpUcKKRH+11Trm6PqXQD60N20BCS5qjEeOPlt?=
 =?us-ascii?Q?l8i3k03VEeIyW/gwY7dEezdXTBhFf+zxqIn6pS7EmE0Ul2rV+1zXig5Y9eAV?=
 =?us-ascii?Q?7lnkFpZhUrZx85aLwtqVD+E3cjqWpaSimRyItwMGutfgj3ywNPUCdZB1ypDc?=
 =?us-ascii?Q?HlvFdWed6nEalY2EywloGZWbGAwzknWVJ7+A0vwLpUM51/E4yXLrXmp+wdRf?=
 =?us-ascii?Q?6xCHxN2JvPNhEt5iWdJQQ97I74wfD9YVAumPQ4tPdj4vLwjoaZ1HeMk1zl2r?=
 =?us-ascii?Q?AzEn3NG4b/l8OynOS3MLn1IvvyYopaPT3loVFgg+u0CYv7uS2+vNSImMb1Ae?=
 =?us-ascii?Q?UNvbJmZp5Mh6Q8jiYMn6K19c12bMdDRUJqoHv7sIdsxrglNOZklqMVIi9Yc4?=
 =?us-ascii?Q?Q0sHs5cV8oz3EVel6Ew8ZbpSN7RL2FIkFsV23unJnsjy1lodzW6Njf0Mz1Ts?=
 =?us-ascii?Q?/lSrfL3ztBOqw7L56CX1IiEALeotky/sbeepNU2rGyuAblAZKXjkESIhSqGA?=
 =?us-ascii?Q?IGJIfbp3DbiFl9E2X/MFVuqR1XvHDSGl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZIDNlr8HBqf4MuRE9zLI33aZO7+NMUtStXuP+k+MyrofMqQHIX5lYqMmWVo?=
 =?us-ascii?Q?hRId5yl7QNKC6cgRrkmTV3Z5eySixLrzPHLju4nypEeEwYUAVjYEBFbr2XDZ?=
 =?us-ascii?Q?1iD03y3yte6OhRn19Pcd8w7FZTjsxdZEzApMUMGEJ0fNNB32abTXnji5pZbd?=
 =?us-ascii?Q?Nt9D9eMw/vaB0dyyVqmGQAsZHiQx6WJFkOQBLowP+7+eDrYDWTFeb4cFNUxI?=
 =?us-ascii?Q?/GfDFN8zS1w/uygbZ8KlslOfPrh97fyamOGfwxO5a+fYeMrdUnKTueKhsp/l?=
 =?us-ascii?Q?skZ9BGHR1RfP1gbXKLhZwjUonwUVb2uD7ZCqXF5HhtQ9zuep15a4pmXw9iXz?=
 =?us-ascii?Q?8zsCTGxGu2qVnVAMIREeWiFtyL5IysyKVyw12/XYWEnlkZw6MWi0rlq30Xzi?=
 =?us-ascii?Q?e1ElTyYNFMwrqxudX51Co1TCCwTsHWTsVcBFhumAUqVmIJtPKJHDZeLkyI1k?=
 =?us-ascii?Q?UmZE2ia4KGptlnIX7sANGMdbYX8yviq+3qXxepogWdHJngKh7ipUlgi6pS1Z?=
 =?us-ascii?Q?udKfRtPLWiTjPASttHuJUubCENfYb9YF9zu5VJw0GzYthVXHtcfbXlxSln2c?=
 =?us-ascii?Q?vPMkUFDRwbYO/eYUmZg+cEKVyi43Ola2UulrDRS2ztDVqcmM4dC2LzNHyZpE?=
 =?us-ascii?Q?eC84fRg+js2no9E0o2zbnIgjO0IsZWznSnG230/+dVcFzrHE0VVemBp7iRkf?=
 =?us-ascii?Q?EIZ0MrUtk+21X6wzN+6KsQixmVrxOVHmtsZKlslgLW36QPIvf1tJjeGdDlYX?=
 =?us-ascii?Q?sqdScNXj5ZCsPQXbHB+mMYHF3QAGWFRcsRegImTT7r27BkL9yS8acduSUdBD?=
 =?us-ascii?Q?AQKddSL97Iy+5EUhblcF8hTD94suaZ9en3HeYWKrDmTUZxJBmE8wr8KH5Eyd?=
 =?us-ascii?Q?zVlcvH+LWK6kcCY2l4c11ewlZ121jxRgsDkgmoRsFBb/XYVrJHrTbE2ymf/Z?=
 =?us-ascii?Q?rVUj+IMSJJ4kuNR3wqDbIg6nqUqhoqbIYHeChiaBpTXg4oO6akWekDeVzXbW?=
 =?us-ascii?Q?PK8IGt8+X4RqIWIs5mdJ/KpB4e1g6iZi7JwUQ+yD44fk4ZOiAxFjElbiiRSc?=
 =?us-ascii?Q?vgS3/qY4s2damK8/c8SIyznhuhMC4dcKWaXcjbWKh6T0RDLDiiHmtr5MITjf?=
 =?us-ascii?Q?/bVFotIq8HEeYZiM+qtUJj310pVnX4ml5EOEI2FnYF875x3iF/dQYcU2wB5E?=
 =?us-ascii?Q?DihNZum2HG3EJuIfyDw7PAfFt8IoDN2pUZfA5kmLnZqxE17wweRO/SPVFm/O?=
 =?us-ascii?Q?Swrco4OJ8ZWAvvUW9DqBV3mnEW3et5q6EXaQ1ewx4HX1KuwPg/xAFSxOg0dG?=
 =?us-ascii?Q?jNW1IIDwlUl58RaXqd5KyC0Op0l1aBR/vusXcoBaEwIDCr+ROeTRH4A0ZT7E?=
 =?us-ascii?Q?TtY5I0zSM4NzL8zmNHRMcXTA6rpEi1FIZK34re3g6LnbfHiONFjeoSLps7FM?=
 =?us-ascii?Q?zOr3dppfa1JuwHx3aXD/lXUvVd47+zBMkoeZGzvMX0OHsYcCtBUWStZtlN8I?=
 =?us-ascii?Q?8uzeSOOMkS1o+1Vp6gxZJ/wlL5Birt8/9dx5EUcWCDymhXUOJ9fRR25huTA7?=
 =?us-ascii?Q?ZL71aNLftsIU5p4E9vzyzGTuaBpU/lJJtVN3of9S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d474191a-928b-4352-38d2-08de225373ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 01:24:55.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaNvOxdJjVP9YqWHx7DZINQpiT5TTg9rCrhGcMZ+9w+5YtB1IIuu9RdnivIOLbkdjvK6AJFHLOW7UKxd7mpU1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

On Wed, Oct 22, 2025 at 03:55:01PM +0800, Chao Gao wrote:
>On Wed, Oct 01, 2025 at 08:15:46AM -0700, Dave Hansen wrote:
>>On 9/30/25 19:22, Chao Gao wrote:
>>> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
>>> +		sysinfo_version->minor_version = val;
>>> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
>>> +		sysinfo_version->major_version = val;
>>> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
>>> +		sysinfo_version->update_version = val;
>>
>>Heh, how long does this take in practice to get 6 bytes of data out of
>>the module?
>
>~8us. And the whole metadata reading process (i.e., get_tdx_sys_info()) takes
>~113us.
>
>>When is the point that we move  over to TDH.SYS.RDALL?
>
>TDH.SYS.RDALL takes ~16us.
>
>I'm uncertain whether the saved CPU time of ~100us justifies implementing
>TDH.SYS.RDALL.

I chatted with Dave and Yilun offline. We think that saving 100us for this
one-off operation isn't worth the code churn.

For the record, the idea of moving over to TDH.SYS.RDALL is:

1. Call TDH.SYS.RDALL to dump all metadata into a data structure
2. Add a tdx_get_one() helper to look up the data structure and get the
   metadata for a given field ID
3. Replace read_sys_metadata_field() with tdx_get_one()

