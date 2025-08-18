Return-Path: <linux-kernel+bounces-774065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BDB2AE34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F07F7B59D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF082334715;
	Mon, 18 Aug 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maKHXxsk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E3254AF5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534658; cv=fail; b=gFTOsRuoYtPNBxB99jgMDVsRrXR3a21b4PnfF9rM0gyvehVkQlgNd1dLcnV3dzR7llLzrBLtT/hgNtUTKp3MQyMojCtHViiMwxROLwu6OPlV3z0x7mmUxsAkhaz4EpTXN28Q3AZKPNdePhxQkkqcqXmQoa2bA74tZRFRVpfzK+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534658; c=relaxed/simple;
	bh=HME+Lnzi9tv4lqRZ6zfGgc8KQ2Tm/eyb9uIgrJxDPYw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MHBsg9aSQhij+SURJbucwugfzOY1U9QDWAtTnbtWLtHua6lElBgDPZdbkqiRrbZMh71Y1raBi/hPDVSL1dHzEGVUQgqTRjw9TMrSTnDqUvld/mWODidIZC02K+Q4MbJoP3kuSHr19J5LBYa2kj/I01BUG2rEszzKAggmM8ShEIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maKHXxsk; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755534657; x=1787070657;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HME+Lnzi9tv4lqRZ6zfGgc8KQ2Tm/eyb9uIgrJxDPYw=;
  b=maKHXxskSHACWqcrtyz9RzcE6AfWyNL6jwAh9SJNF949owKoIN1JKpAQ
   W3+dob37kCDxVoZ0HwzPSww8Ii+NwVZJGcxh8IxZx7skFmaQ5YEKlbThZ
   BrSBQ2zfOVO082Mde1XmBP5cg4sVTrHtxX7AISVAUMNfxx0XDsMKm31Fz
   xXR4CCDHUwX6rHz+yk7vjKzZZAFPy+j77r9P8YrqUN82Ij+n/hK7xgOzc
   ctNJrWPCbOsxvUWknMMCQDbLFn1QqLpIX9k5hyy7QUw9XRGOFdW/WUekF
   VXMBQFwt7Jl3OZKBDe5iEj/J3vVP3YUlwl4qcetXodJVGVbgzKhU7tOBi
   w==;
X-CSE-ConnectionGUID: /KpT09oSSI2V65yf9VqYuQ==
X-CSE-MsgGUID: lyCD/pybQnuqkZXBh/Y2LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57836286"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57836286"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 09:30:54 -0700
X-CSE-ConnectionGUID: 79ySHAPUSzKafIPfUJhtjg==
X-CSE-MsgGUID: gCG1zHPMTVeBX9alhTp3yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167129088"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 09:30:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:30:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 09:30:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEqnajDhbeCnsqGjiOJS2NtrKXJ6wyXvGGArNkd3CsL/iZWLld8GCcxq20voIGbcWEF+1WlttvQq7HMFNU/O/yvKSNP1pgoYMDJ/n3wgBEF4j2kj+V46+qRZ6TG1W9C4pWx+InVDtTMY0WUlgw0T9mSrGZidJhtS9Ch9dmF9zDH+WVBR7CCWuoE1pMd0s8HcWnqPax9wyQaIhpcShDs6oH0dPBGPKef6xTeH1EVk83kFQEmwHreNiHOdpZGsM+zQh3zyAD1C60fml5pa+dRB0dPwuIWeV5Qkb+Znkq4SrKKQbumESDdQQqz0JY+yNGPxb6vQUFkvJDdkSPDUYPI+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJFdQsCFVEqmZrqUZ3wpUEowe/GrQ00m+vYCTjaQcTk=;
 b=aCRqGrU+rQFIw2r4tMK0+UhOGj29cR7d7uXBC6JRJ6JJCo36Eljaq5oBKz4ivPGClyNjVW1b+OLZ7sTptmEu+38KuK+8jVHVcVTCMbMNUcjkShu8O4biiMGaKOySl1WlvlAae6Y9oZM0DCD6LKNKG6B3sCdD1cHCbn9T8cOjGpysq44SmBI+sJ0jZ0rYz2w3BAeBdDpjIrE+72uaU0oQrdB8C7RZxms3ObSWWwKQ8CRyAOLiwXviGu4KvSlFyGKEZRIF97TsIW0Sqa2Gt+j3OuZJsCsJKFfjiPFCXi+GFDPQ3Pr/wdzi+NpsTRWE1T0VbQbQ6RdTUUGsLEn0Mwy6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by PH7PR11MB8453.namprd11.prod.outlook.com (2603:10b6:510:308::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:30:49 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:30:47 +0000
Message-ID: <d55b1341-1a4b-4f7f-8557-8d34fc275311@intel.com>
Date: Mon, 18 Aug 2025 09:30:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
To: Borislav Petkov <bp@alien8.de>, "Chang S. Bae" <chang.seok.bae@intel.com>
CC: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-2-bp@kernel.org>
 <6b345bdd-d5f6-4967-9f2a-15c2d371ef1b@intel.com>
 <20250815092025.GCaJ772U9p_UpEasfa@fat_crate.local>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250815092025.GCaJ772U9p_UpEasfa@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|PH7PR11MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2ad8b6-bf89-4fe9-37c9-08ddde74962a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Smh6WE5ScUJmdVhGT1drM0xyRlMvTXVmK1dqOEwrSjliS2x5ZlJVNEV4czk0?=
 =?utf-8?B?VVk0QSt6WGxDc3pDaW9valdyQkVYM1l1OU5Tc3pFeGlvSWt2TklpSmdVcDJm?=
 =?utf-8?B?VkhuNUpRVlV6NFQ5aUVKZnRGM0NOc1JocHFpSmpZbnhoemJwMENwYjZWV2RX?=
 =?utf-8?B?eUxmQzU0K1NOT05Jc0lnR1VUNWt4UlluMnYzZ1JsY3lIV0dpUllKaS90VTMv?=
 =?utf-8?B?QTFGVEIyeU1naTVGdEtUN1NrQS9hMC9HMWVaWnB4ZklqRmd1WC9aYnh6Y3Ba?=
 =?utf-8?B?eDRaazNlRERVRWZTY1JtWlY4QytKaExzT3RRMm5RTGtPZEFBNGE3ZzZTRzA5?=
 =?utf-8?B?UG96K3REVCtiNDdETGtrbCtPMFN6TWt5SldkcWE1TlAxU0Q3cDhWUEpyektE?=
 =?utf-8?B?M3FqR05acDMvL3dhVkhJSkNUQ3VpT1lDa3ljTmlWdzNBUHVISm9QVWhEUXZy?=
 =?utf-8?B?VXpMa1dYa2twM1VLWGUrMnYycTFxSC8yUk5tTEJKbEEzRk5ZT2hYWjg1dDZJ?=
 =?utf-8?B?bTVEN0luZ2p2aXc1NzI3SzYvOE5BRUFxRlN5RkNCQXUrNHlZQnRtekQ3bkE5?=
 =?utf-8?B?MnNJWVJoaVZwQmRnWTh1NTg5eTVpQnQ2dGtkU3RNL2xoZ0hML1Fkak1pM1lU?=
 =?utf-8?B?QUFwVFpGKzBKMElwUVdFZzcwazJSbWU0bVZtUURwWm41SnRxM0JuMFVxRGRT?=
 =?utf-8?B?TWt4cEVDc1dpMzdGMTFzOXlFSHhaS2xmRDBNWjh6VUZRUzIxL2RCeWkwZGF5?=
 =?utf-8?B?dlhGRG5VWEFmeTB1NE1jYlowVnozaTVQeVp5MjZsZk5HV0x4TTBJKzRXWWtT?=
 =?utf-8?B?cG1wU1Z1ZjJJRDQrMUFXaXdzZ1JQbnA5U29sdWFDV3dTWHRLYU5DUmhhMkdh?=
 =?utf-8?B?cFJ2UkV2QU5RbllHUlZyRTRmaW1xRXk5L1g1RGYxeDN4SFZFblZiNkFORmc5?=
 =?utf-8?B?SXl2ck5CVko1N0tYUEZoMGtvako5MjcvLzdrS0lPNUV6NnczQUY2SDdiWHRt?=
 =?utf-8?B?aTFBT1cxUHEvTjNHNTRrdEFwOGQ1NjV5TzhyN0JBL05xakMyRHhiSjNrRCtr?=
 =?utf-8?B?UVhlckJ6ZE0zdTlqazBxMW5JWXExdGg5cEJvamI3Y0JFVGNSUklZTm5xWFFM?=
 =?utf-8?B?MFY2eDlNK2JTTGo1cjh3QU9TM0lZRzVWNTdSNFFnY1lwdFV1MHR6UUZOWTN5?=
 =?utf-8?B?VE10b1YxakNLZUprRUhkYm0ySm9yTTNjYjI1MXdjSnNtTVhPT2VPMXArelZX?=
 =?utf-8?B?cVlzd0toZFV5Y3JiOUJmQktqK3c3c3doUGZnR2NzMmwzd29GSkJQaTFxY3FZ?=
 =?utf-8?B?R2NlMGt3UDFsUTVTS2s4Ti9lank0b0RwMWo1L0h1SXpjT3hWMHBYdWcyUnA3?=
 =?utf-8?B?WFhCY0lTS0ZIS2p6OGJvVzRVUHA4LzNVejNPZndaV2RVbnZkc0U3WVN5SkFx?=
 =?utf-8?B?YmJ4VlF3WVlkWG5EeGh3MmpmdlgrK0o5SFd2N2hJcGVyRkxJMkR3d3hZbDJT?=
 =?utf-8?B?ZXJwaVNtZGpVdVBFUXhVUGcxSWhRWXlRRTg4MkFFMndNNkFiUVJKTEU3VGpp?=
 =?utf-8?B?YmppcE0vVjdZZEJRZGJJcUdML0pDaEZsNUFUcWlxWWRTbHNGUUxrcSsrRW5j?=
 =?utf-8?B?SC95Tkt1Z1hHVS9HS25VRjlMcWx1Mmt4SStOU091OE1uNnByU3ROaUhqNXJP?=
 =?utf-8?B?d3BpWm5jVWQyeVBTejJJTDhGcGVYdzJ3M1N1SU1NM1pqcDBVWEJOYTRpR2lZ?=
 =?utf-8?B?WEYwcUhoeFBKYTcydXRab2dXalZLRlZpMHB6ZEw4RTljelBSR0MrT2ZBbFFD?=
 =?utf-8?B?cis0QXFGMWY1cmtsQUF3UkI0UDY2bFJNSEFtTENrWEJLaXRlUy82Mm1LMGVs?=
 =?utf-8?B?Vk80T0VaZ0l1cEEweUc1U2ttL2JHZHR4KzlOaFFNZXpMbmdZN202QnUrMk4r?=
 =?utf-8?Q?3Zu9xRPjLX0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0hwRWZJQTNJNkNEN2F4emgrckR1RExYNFBLOFBsRzZkUGVSVkdLS28xbGs4?=
 =?utf-8?B?TC9XNmJ3dmM0M3FIbk1hbmRmTC9aQUNlV0kxV0R6SXc3ME41R0hqNUpqN084?=
 =?utf-8?B?N0lSd2hOUDhOMkNmVTVSaVFvSzkwaGNEeTlHVXN0RG5uWFJvUkI3VVg4cFEy?=
 =?utf-8?B?d2E0b1JleU02aDNieHo5UFJacWxVY25GdDA1ME1LYktyRjdtSFpVUVRoZlpT?=
 =?utf-8?B?ajRlenJUM09jUmtXdzZrTVJCT0JHS0tMNmZUenZVNU5xTi9iWkJRdWdZM1F3?=
 =?utf-8?B?VW1ZVEwxcXNzM3lxMEhrMGJ5YXZWTUt6NHhoRWRqRUludGlJR0RBblpGL0p0?=
 =?utf-8?B?MFp1V1lQdmlsTkRKRFJ2ZUtWbWFFd3ZuRGNWTndaaGtRdnhZVFl6SkZIeEQ0?=
 =?utf-8?B?Q3JEeE1LN2dtZ0ZML1pUZHk0MXM2WEZWSGFRTTh5bmNHblMyVlVOMVpBWkNm?=
 =?utf-8?B?YjZENlpwamFGWFVGQmNQOHRCRXhqL0tmTUNteU9PamZXc2cyTDN2OFFuTVFa?=
 =?utf-8?B?N0tya0k1V3VhVWp0SEhnR3Mrd2MyMml1cHE4eWp0UHJjb0lkdlZML2t2WG16?=
 =?utf-8?B?U0VYMXo3ZVFlVDV4SFlPZG1FRzJ5K3BKbjNvMDZQV3RhVWE1ZzI3MGdMWjQv?=
 =?utf-8?B?S3Evem9WY1B3RTJ2Q1YxcEV4OTFvOERCSjVZRjFBdi93T1JLdTRsMmtmODNQ?=
 =?utf-8?B?cE5mWkRRa2JGK1hzaHp2NVQ3WjRsS0JMNVp6QkYwQ1pKczloTHAzVFFDdlVN?=
 =?utf-8?B?THRobGVZa0VlTTNQbEhpMXovZTltRkplblBqU3lpQlBvOElKK1NHeEY3bWhw?=
 =?utf-8?B?SG03QmNwVXVRVk5KdGlwZGdsQ0ptRjY0R0pmSTVucFA0Y0licisvZjkvWHZi?=
 =?utf-8?B?ZEtWY3NBcGk2UVpCTjNTd1Rvcm54MnIrWlRWY0k1WHdOVmUyWCtrMFJZS253?=
 =?utf-8?B?TXoyVzUwd2xjZ2xSY3pHSkhsTFZCM1dRTXcxa3Q1R1o3NEFYb08yaHhHR1lq?=
 =?utf-8?B?d2Zna2pDaDgybjFmVFFZKzdMTGVwSThhWmFFbXVzbFFUd2dNQnpyZTU0RDhq?=
 =?utf-8?B?dXl5aWZNK2kwS1FQSnZuWWZKSFQ1UVI1Mlo1RDJ5SjhKTk5HNTRIc0xVZ0E0?=
 =?utf-8?B?T1d1aTlrNXNyZWhBc2hyWnpsVytDK1Zub1pMS2cxRi8vQU1EVE52LytxN1Nk?=
 =?utf-8?B?a2gyMTY2ZFFKYWFXcHo5SzY0ZlBmbEU2cnE3UitZYm5LZzUzZkhHMStGczJy?=
 =?utf-8?B?ZE5PbWRYemFQdGEvcGJsREJXbWszaEhvSkxZU2hTYXFtTkV6bzV0VTJWTjZ5?=
 =?utf-8?B?K0FlZzN4ZFpCcmxxT2VBeU4rZTAxdElMZFMwZ0xvbnlOcXhBbUIwaTFrSnp3?=
 =?utf-8?B?UElKa0dmbi9mVCtKZzBzMmZrV2p4c0VoQkFtdmYrUy8wY2VnbHNNdkU1bjQ0?=
 =?utf-8?B?QzliY0lENC9zVzczSGVVWnJ3VFB2WFdWOWlZa2VZcmNpWlZVTHY3MXFUWTVN?=
 =?utf-8?B?cGFYdVhiZjVJRDdKNDk1RnhoblM0ZndZWlpPek1hVjBicFVqYXI2aHpkcVJE?=
 =?utf-8?B?WkRWZThaSWRIb2hhU0FJY0N3cnB2ZnJhQzNuMHVSTlFNRVUrSE5HOFd3NVdW?=
 =?utf-8?B?U1pRa0tkK29uQjhwQlFFc253MHZ1SUZoR3NCWElncjAxYVN4N0EvVXhPcTFX?=
 =?utf-8?B?d2tscWQ5QW55UThrdnhMRVJLaExPbE9uL2pkVFFCOFlnQnFLQWI5ZmJaRVlj?=
 =?utf-8?B?YVFXbnpTWkV3SEVSOXF6VWcyeHdJdC92dFhCNWxUSHN2bTdsTXBWY2IzYWtj?=
 =?utf-8?B?UDRCc0dvK0dvcE5wUGtlc3Zob1dpYkxSc2hwVExybGxFb3pZRy9wWlRxbFNQ?=
 =?utf-8?B?OG1pUGZUd21lNVp6QktIdGw0Q3U2eFpncFRMZTltR1hIODAwOFhLZGtXYW01?=
 =?utf-8?B?M3U3cWpFRGs2R090RWVRcWNzZDFhaXBZaFdlTGNhcjFOWTlRRW1vdHE0YTZH?=
 =?utf-8?B?cGt3NnRlOWx3Mm01UFZiSzl0dzFiUnFSemhhTmw0NlJ4N2dNbkM0ZGdObk5E?=
 =?utf-8?B?OE9CRytpalN1L1Awb2FieElZZkgvNnFLZDR1cGh2OW5UR2pPVjh1R0duazFR?=
 =?utf-8?Q?sVdvDwiRu80GyUMxR2VjtBkSi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2ad8b6-bf89-4fe9-37c9-08ddde74962a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:30:47.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HiQKyq7mnxKgMsPRUn2OgCgGxPdruwX58b9DNILY7Dxn8KHm5A8mNgKtMiBbYzqwavwdoVbs8oA+LtqVRkHRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8453
X-OriginatorOrg: intel.com

On 8/15/2025 2:20 AM, Borislav Petkov wrote:

> 
> Ok, here's a diff ontop with all the changes I've caught up until now:
> 

The updated patches look okay to me.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

