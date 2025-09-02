Return-Path: <linux-kernel+bounces-797061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C001B40B57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212063B1933
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E2341ACE;
	Tue,  2 Sep 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO+ndM9N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532230F94D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832291; cv=fail; b=CuraqCsvRnWONLvNKHtKAgOYvMXtqvJyP057xz14ArrnBNU2oY+RiojUbQ6jKvN2/mYqRAonbT6VEJs3Q/ViV6PAAakpZ1qXKYpMi+gXzBIT6MmLI8POVba8XdTd+FoUca8p5WOxZCBFqMNi2FbQ74yjZ7wDJeBouwpv1uTjQYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832291; c=relaxed/simple;
	bh=GHy0kNJQW6X5as5U+SK7Csdn9mW+J/d9MHfHxTr8OFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qpb2XwFDBA5lPQ+ygXOSgtyILDvcY0a9uw9B6m8Luf6WQKc5U4Ra8b2r+Px4G8u8e/zXMntwat14N2ZcpFV+NLe9t/BdI/XhJJ02AZHw95M9z7CBzMriAB3RByY1FwrQhVXxPvJscpT3DOwl5EZtVdnmQa8l2ozr4Dqc2fzl+1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO+ndM9N; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756832290; x=1788368290;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GHy0kNJQW6X5as5U+SK7Csdn9mW+J/d9MHfHxTr8OFo=;
  b=gO+ndM9NVzsLAhon48itZW5+Eu19H9RioBAkucF8vWCuW8DnYsapxdx6
   y6cYVtQIGWkFcHiH417xVTwmIVKG92sKOGSgO+3sTdeSO+VBaeHwZ7ORU
   HlgVNYsVo7qvtIq4ckDYtnoOV/JrB2cHSd3I9BxqYioFnE5k7LCKCx0ra
   bOVwWCLfKB9uNmXVC9T3OaFptdxfm+OEbKvlwK2InoZi5w9WjsN2Ji2ev
   Sb1d8Fym02xfU80oAPc20jxOrrGEbI24IjY9Cd9QuOfQsAllB7r+baQoJ
   kOv+Kro3gaSF7zzE2qNPTKhnZgCqENW0xlPKHVu7gyi0myWak3YUdL7DH
   Q==;
X-CSE-ConnectionGUID: 0ZTgXvJHQHapH1sUlV22Pw==
X-CSE-MsgGUID: UL/UrKOBQoqhafuJNfbFZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58817854"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58817854"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:58:09 -0700
X-CSE-ConnectionGUID: kJ+T9ea3Rk6MDczajEHCGA==
X-CSE-MsgGUID: XJjEbxltSMqA6SLToXAPpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175698000"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 09:58:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 09:58:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 09:58:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 09:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhBsvJqN6wf9MTSFJsK2z7rwRluU1U2iad50pTAEXcKpU+2r6JGSxIflIDMCiWDZbWqhcJdmz2TgSMQYdZj2xML6w29Aq/ge948t6lB3iR0tjfbM96TLWeATty5QEvVDbKl80MUsGPlYdW5yJrEubDJ9jMSirZkSRQmN9BfAe348ecJZvzEEFfHE0WxKhC0tWuAgR0aFEkogbkEHJTMaFOKxeUZEqSq+7lqOIzEawPiFtT0QXDlFCAK2SZ80yNlNg03rxd/AMyMLwKtVYqV4ugBuHoNZQL8DrSLrg4IfZa/fDGo+YW8pEt1zltvR5Zr0lLlXa+YU1XhcwKc70U87Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wK3YXVQ1iGfQ9+6JoGOyrcFnQWwMv3wcLGkqDlFcqE=;
 b=uejVrH1aFCYHYLL54f/PCu3YX8jYZAJ2Xl2Ez9rvmYk2NWDGcu21h9raXvqJK/+ZwmwBnvqCbBpwAFuhnCgt4So66bcuwYif3bhJD6Sb/n0RsI22sOZY1/9DTKeXQjVhL+apy+fk9+aSmtT6C5c64zlGRPjsKgMpxjneTvtHJMPGI8jwLO9yTF3Cv0rhUok6jswErqe84dUIrjaOiaEqXzkzFGRPXQ5LV0GRsRgOoqEihQD0xTo7kRDnUqocJKlGDz/zHMyEn3EfuIiWDPXQOf8eQ2K51CIUY4tczfvrA3A1q+7n1vT3F9AsplXoIkODLmtirysOQaf84nG0RgoTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 16:58:03 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 16:58:02 +0000
Date: Tue, 2 Sep 2025 17:57:52 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Jann Horn <jannh@google.com>
CC: Rik van Riel <riel@surriel.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <peterz@infradead.org>,
	<dave.hansen@linux.intel.com>, <zhengqi.arch@bytedance.com>,
	<nadav.amit@gmail.com>, <thomas.lendacky@amd.com>, <kernel-team@meta.com>,
	<linux-mm@kvack.org>, <akpm@linux-foundation.org>, <jackmanb@google.com>,
	<mhklinux@outlook.com>, <andrew.cooper3@citrix.com>, <Manali.Shukla@amd.com>,
	<mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	<baolu.lu@intel.com>, <david.guckian@intel.com>, <damian.muszynski@intel.com>
Subject: Re: [BUG] x86/mm: regression after 4a02ed8e1cc3
Message-ID: <aLciEF5kNHDcRFvP@gcabiddu-mobl.ger.corp.intel.com>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-2-riel@surriel.com>
 <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com>
 <CAG48ez2ck2QaxZ6G1Qrp9p0brFecrnf+KRc7Uk8c9kMJqSOswg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2ck2QaxZ6G1Qrp9p0brFecrnf+KRc7Uk8c9kMJqSOswg@mail.gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU7PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::28) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|BL3PR11MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a5ece7-2c05-458e-d8f1-08ddea41e0fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWdVMjBQazBQMndEWDhsS2p2Q0p0SHlNZUhFY2F1bmU3UkZHZm1ORHVoU3U4?=
 =?utf-8?B?cDl1MERZMGRsMmd1b2J6VUR3anlmdUYxeTRDRVh4Z3VwZnFMdko2QjcwQ0NY?=
 =?utf-8?B?WW1ibkt6VUdXSUVFUFBVdGZ1VktwYitHNXBXRDJGTFlGZGJmZU9mMTdxVGFF?=
 =?utf-8?B?cElXQ0Z3YStnNUczNHhuMzI4WjlNQXlSYWwxK0ZuN25BWHRoRE9hazZGemFU?=
 =?utf-8?B?cDRrQU1LWnhoVUR0SWlCdzd4ZlBwbnY0SVhFaU0vM2pHV2E4VjY4S0RqdTFP?=
 =?utf-8?B?MHR3QUxna1hyMVlOclVnUnBQb0JxbVkrRUx6Y0dvMTBWVURZa0ZXSDBQT0Uy?=
 =?utf-8?B?djAwc3hrbFN1UjRBR0FiZXVWcWlzcGllbEM5MThVdnpvcHQ0eE1IOHlTNnpE?=
 =?utf-8?B?eGtxdC9SYnRFNG8rNTRJRFNrUkI3Yy85WUJLOUM3VmZXOUhYUWg0VTNPOUd6?=
 =?utf-8?B?L0l5WFVPUVdXLzNVbzJ1eHEwQXJGVDBqa2FtTEd5c1J6bnloTGx2UGxYKy9a?=
 =?utf-8?B?dVpsRVlYMHFaZmtWQmNQdUMwVXU3b2Jya3VoRXE5NU5HZzVST2FmejBNNkh6?=
 =?utf-8?B?VU1vUHZKYXZFTjFEYTA5WkEvVTdpUWRNSCtOMXMzaEl1MFB6ay9MMU9JRHpZ?=
 =?utf-8?B?SUlQVllvdy9GS001bjRHNjlVTUlrd1dmc0dUQ3IvNk1QYlBSOUZ1c3YvN1Bw?=
 =?utf-8?B?b3BmaC9STlNublp6UXVzSUV5b0RNN2VEcU5UeWtlenJYTVZxaXhGcDcxVWp3?=
 =?utf-8?B?WDNRMjIrY0RyYWdJamhIdUVFNWRSN0FIbDIvYldldnVTaldDTytuTUJwOHJV?=
 =?utf-8?B?TUwwVFhUUlUySUs3QjBWVWkzSStSMWpTR25yTEsxa2Y2aXMxUG0rWERLazIy?=
 =?utf-8?B?bGRIMjZpOVg0RXdMQ0FUbjZ6bkU1S3hub2QvdzJZVTAxT2ZlaGE2c2s2aGpv?=
 =?utf-8?B?MUdrNVVVMHlLM2pMY1BNK2lROHI3WnVXY2JTVGRhNWNlaWJya2ZZU21jaDhn?=
 =?utf-8?B?Qktlako3Y0dDeVBuWUQyT3FPRUJyNTVJeUNqRG1sZHB3dXJpaHV2cXlrM3Bk?=
 =?utf-8?B?a0ZueVgxM28rWW4yZjBCeUNxcDV3RU1DT0tBRkExeDRBTVk0QU5sVm00SDFW?=
 =?utf-8?B?RXJtWVRCaU1ER2l2dlJPL2QwRVlaVnpIaitUZGJBK3lPWmx0UUlBTmViZUpl?=
 =?utf-8?B?eVZoV29SSWdwNWZrZkxweU50SVhnbVR5clNydy9xMWNpNHVrY0VTVUhObXkv?=
 =?utf-8?B?dXgzYVA1bjhCb2QvbDZhR0I2a0hCZmVTL1VHU1JjKzlUczloeWVTeW85dlVa?=
 =?utf-8?B?Rmg4TjY5UmFaZVplNUJFYjhxTWRyZUdRMjZpQktpNW1PR0VjcUliRi9ZQ1lr?=
 =?utf-8?B?M2dMZ2R4ZmNhSzUwV3VXOUtEb3hFU3BqQ1JtTXhJU1dVRStTV25IVStaajZR?=
 =?utf-8?B?ZHl1WGJBczFOeWlxVk45eTM4WWZHL0Z0OU9MVWx3Z29LcWdaWFgxa3ZIaHJQ?=
 =?utf-8?B?aU1QSjZSNEFpNSthTENDeFJZMHhCRi9RK3R2TndIbndjNXRIeHIvZkYxL3Z1?=
 =?utf-8?B?NmZYV2lZWk5QMWdOM01yUHNVbEtQb2p4N1lyTVYrUnowRW5EOERMRDd3bkRq?=
 =?utf-8?B?TTRxZm5LQ0t6QlZhZ0IzczFITmJqOVoveU5McmgwakRoMEFQQU1XZFVydEJ3?=
 =?utf-8?B?Vlo1bGJBRFVUdlJ5RlJFdk1ZNk1CWTJVd0xGbVpLZ01mV2R1RSs3V2Y3cUxS?=
 =?utf-8?B?TU1idnBIOUVBUmlrbEtRVzdaNjdYdk0wUnY3OFh6U0k0MldhWTAySWZRbWFN?=
 =?utf-8?B?QzljNmRFbExubVBVQVFsUmwyNE0rZVVIK1ZnOW10eXNnUHBEWFlOc2hrRHlX?=
 =?utf-8?B?clNDMXRNVDNjNThMWVgrei9MeHVRcHdxbUpId2YvVHB2Y1k4VXFtVDN2blM5?=
 =?utf-8?Q?S3q7t/R4/jg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5PU1dZM2FzUzlzWE8ya1hoVXIwOC9UcUcxdkVxNDM4bXg1NlFGYTFVN1VO?=
 =?utf-8?B?cEpuQmIyWWw2SkRCd1dIZDNhOFg0eFZuVGN6WGlmZmR0VGJMZjRXN2lud3Z4?=
 =?utf-8?B?Y01IdWJJay9YNFcxTHZYREZEazRBR3hlMnNHY2tUVXprWmpZUEdUYVg5emhI?=
 =?utf-8?B?RDlTT0lZQmQzWVhIdGdsZDk4dkhVM0l3ejhyOElGa2t0cGlDaGtnbkdUWUVt?=
 =?utf-8?B?S1h6TzE4aVpMWXlQbExvdzR0aTVoY2NBamlSVnZXakFFMHoxL3ROUkNwUG9n?=
 =?utf-8?B?YXpYMXYyZFZTbW1XWGo2Q0wra1lTdys4ZWtRWkpCWWJKWXVoQ1lpaFFJRWUz?=
 =?utf-8?B?U2tpSW0zTExkYTExUjZRVGl5UEYwWFE2TWdFUzRiSkhzK0x3TUZyQWFGdWVO?=
 =?utf-8?B?enE2QmwxQm5rVW9TUGZJR0txZEFYWUZNTk1QcW5ZcWJDMXRJN2FseC82TVdS?=
 =?utf-8?B?MjVJSGFtOHRFcnFFUFloczVCQWFrdXFQRWpvb1hQYkRXZmNSWWdDSTAzcW1R?=
 =?utf-8?B?NlVQZVFMZnRGYkZoQ0NZYnpiQWNrTHBLS1QvVU8zU2RwcVdBNVg3aWxGQWlP?=
 =?utf-8?B?RnBab2ZjSjRlUjYxRUxpSUFrWElUVUJTUlRkclNtOWJocXRmVHJ1UGpicTNO?=
 =?utf-8?B?ai83UW9uUjdQMzU0bjVUdFRKNlp3MExuS0VrSTUvZ0NhejR1eVRVQ1NkWmZo?=
 =?utf-8?B?YU5PUzdXSlpnNW52QlJRT2FiL2dsbUtWT1NwaHpVcGJRb2MvbU9seEZwUXVM?=
 =?utf-8?B?OGxJOE1qN0xPMC91eXpCV2o1Qk1ZZS85bndGYlRoMXR6bXVmYTUzTEdvMmFX?=
 =?utf-8?B?U1VqcDlMa09BTUcwY0xJYVlsYkpSODdJUzNuZ011dWNsaUhKVHlBUzN6dllq?=
 =?utf-8?B?S2xzakVKN2Q2ZUkyWDVka29hRXc2Qkp5QzFiY0w0TEczVkxSK2NSdUcxNjZF?=
 =?utf-8?B?cFZJNE1KYzdoUm1qc1JIN21Za24xVjlKWDRhTmhyMHpqS21qNGUrZWpwM044?=
 =?utf-8?B?MkZ4c3Z3a1pPYkE0NTcxK3luUTlHMTNDRTFQZkJrOTBLMi9HRWVEL0xGMTlW?=
 =?utf-8?B?UGROejhuZktaWWJzVUhqc2RvUzhBYTBVYjZmZUowNVhJak5aNk1XMzZ4SzBL?=
 =?utf-8?B?Ri9EOXNOZUI4UWZYMWtnQVRySFRiZy9vRXkwbEQ3V09GRkV6K0pJSS9UbFJ6?=
 =?utf-8?B?YjJaN2p5V3NkeU5OMDR2dmQ4V2JUa0xzcGVMZVg4ZHZKQW9ScXUrL0VRMVJI?=
 =?utf-8?B?ZVVLeDFLMXc5OUZYb2dhUHlKK3g3anFZVmlqM2FsV3RKcU50TE5RSGRmRGp1?=
 =?utf-8?B?cFdUTUlIWGNCR1RKMjNLTWY2ZlR0Y1VlQ2xrM29Hc2JFSk11bnc1UlMxeUk3?=
 =?utf-8?B?Ny9pZVgzNXVsQXAweVpFTDR3WmhnUEZtNkFCSTdQdlRkSzBtOXpOckl1QnI2?=
 =?utf-8?B?TE8zNDI5OTRFQkltZlRSOG9FUUx5VG9qSHIrZkliVk1PZUlac0h5WXczc0dZ?=
 =?utf-8?B?MVRtNTQ3SWtTalppZWZPT2hDN1lPYmpuR3NPSHozaTk1RUR2SlVvbXAvUElo?=
 =?utf-8?B?SDFLWHdPYmZRWGdkTTMwb1lkOHhmV05nb1B4WGdIelFvSkwyN0NGRG1tWWNG?=
 =?utf-8?B?SWYwUWY5bXNiYXU3eDUrTS9LNEo0RGJiY1VTYVNsM0FWWTNlMmc3aWhzdzlN?=
 =?utf-8?B?bEJtelV4SllKT2tESmMyM1FRRTFjTUN0UGVTdlB0WEdPZVQramdJam9EeWhX?=
 =?utf-8?B?NVpMYUVmOEpKS1lYRHR5RlBQajlzaGdBakZpZnBUbnJ4UlU2UXV0QVl4UmlR?=
 =?utf-8?B?b0xsMmppMHhhNVlyOThtQUFYVjI2d3oxTUxCbmVna01JcFJGWk1Yc1dzQm9R?=
 =?utf-8?B?UWFJdkdhVHhhblpkYWJzQ2hlMlFORjFmZmxkV0F2VEQ3L01tUEl1TG1sRnlG?=
 =?utf-8?B?MUtCWFh6SjFJSldLY2YvUXM0NnUybEFYc2JJcWtUeFRyWWJ4dkhkN3dnYWRS?=
 =?utf-8?B?ZHhWb2tmQW5IdjVHZ3RRK2s2a3JqZ252OXlvL2M1UlFXSHBhNkJzVHVxZ01k?=
 =?utf-8?B?WFVOWkhmd2c4L0IyRHl2Uyt1QXhMbXpOajJIbGJsdFpmc1JlTmMzRmFFdVlm?=
 =?utf-8?B?SEFQVUVCUFBqcW5JZ2ZySzJNY0hlanRQN1JVbnZjeVV0SGF1Vkh2dDB6K2pG?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a5ece7-2c05-458e-d8f1-08ddea41e0fa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:58:02.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4AhNuXVGqnGvXUnl1s2TGQNUrjBW/AdhEDgh/70lDdyovFnwEJy4cNloNyDk1fwUtgq+y8eV6tkCWK1+RLPE+WV33f6YPde0zYwtvnREHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-OriginatorOrg: intel.com

On Tue, Sep 02, 2025 at 06:31:49PM +0200, Jann Horn wrote:
> On Tue, Sep 2, 2025 at 5:44 PM Giovanni Cabiddu
> <giovanni.cabiddu@intel.com> wrote:
> > On Tue, Feb 25, 2025 at 10:00:36PM -0500, Rik van Riel wrote:
> > > Reduce code duplication by consolidating the decision point
> > > for whether to do individual invalidations or a full flush
> > > inside get_flush_tlb_info.
> > >
> > > Signed-off-by: Rik van Riel <riel@surriel.com>
> > > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > > Tested-by: Michael Kelley <mhklinux@outlook.com>
> > > Acked-by: Dave Hansen <dave.hansen@intel.com>
> > > Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> > > ---
> > After 4a02ed8e1cc3 ("x86/mm: Consolidate full flush threshold
> > decision"), we've seen data corruption in DMAd buffers when testing SVA.
> 
> If it's not too much effort, you could try to see whether bumping
> /sys/kernel/debug/x86/tlb_single_page_flush_ceiling to some relatively
> large value (maybe something like 262144, which is 512*512) causes you
> to see the same kind of issue before commit 4a02ed8e1cc3. (Note that
> increasing tlb_single_page_flush_ceiling costs performance, and
> putting an overly big value in there will probably make the system
> completely unresponsive.)
Thanks. We will try to increase tlb_single_page_flush_ceiling before
4a02ed8e1cc3.

I'm not familiar with this code, but based on the commit message,
4a02ed8e1cc3 appears to be a refactor. However, that doesn't seem to be
the case.
Before the commit, mmu_notifier_arch_invalidate_secondary_tlbs() was
getting a modified value for start and end. After the commit it appears
to be using the original values instead. Was this intentional?

Regards,

-- 
Giovanni

