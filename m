Return-Path: <linux-kernel+bounces-872944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9EC12AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992E71A6752C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A9A26F2A7;
	Tue, 28 Oct 2025 02:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWsVrpG2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47223C38C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618966; cv=fail; b=LKSVNfHrBfcFR76jD3+fxaNf8WqboaV83FyCuqcPNoZ2FZWEk+PJkK1nV2VnTL4kSUwy1qLe53pmNdKqRtwl239aRVu/zoDpLb2njGHsvfFSfJW8ZsEcFBQsfwpcWqeixTkBb45muybHmOKH8eTi7lYMC90QOV2+m5okvJ1RBg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618966; c=relaxed/simple;
	bh=4ck9Wam2wKHCzwech49PIAjCXV3/tEgllB81d63X3aY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fp5Hph68yglxhPZ929JG1C9KFDPCthn/fG4yaQyAA8+fGnV77RKTo6p6yP7TP68gqLbqlwiQNU7zSKB6VNrYo43by2E4S3Q/TnXEXq9LyIE6wITbNdc+V8L51KpQ07MOL2ncRvu6Tri+tjtmugHHINrKsRg4zfMeQjxVZB8WErk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWsVrpG2; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761618965; x=1793154965;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4ck9Wam2wKHCzwech49PIAjCXV3/tEgllB81d63X3aY=;
  b=TWsVrpG28W7ubOqv3Ac1KPgFo3vkZmDqjMCnM4m0nyl9y6ygI2Xu2qSF
   Cmhs+mIANh55C1ZNxuMJtZT0J+LruEiRtK0bsHr3BBkK+cQzEDlevvCrC
   Z8Bq5+xeZeV80jmVEmwtlB7DSwxW+eiBknO/seSiX1TuICFd/yXC1lDAV
   ixNaauLOIOXY6KfvgVsYxbNb2V82NAy3P2lUJD9+/VQoZVykrj8h5kB7z
   WqiIyWpbTcbVjwzgN/MTIRSGdTS2jv8SkoEmL9WaKmEUGHfZlsftXJEdd
   64PdIx21ZQPbwDBJOglkjN10Xw3m8eAoNBmvm/Yhl03n2e1exc5OO8RYc
   A==;
X-CSE-ConnectionGUID: 3TXwg3JWR5e9C9fABvEVXw==
X-CSE-MsgGUID: 2mdLAVhHSgWBxdpeKBPO8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67354234"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="67354234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:36:05 -0700
X-CSE-ConnectionGUID: LFM6xccpSfq03AlHALFFJQ==
X-CSE-MsgGUID: 3hQNdA89R8mImPJdJIUPWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185112152"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:36:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:36:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 19:36:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gugd2g7Lc64SOlN5ztQMSTC4t4XCzkJ+73iv/e8jGIehL6JCwCnfcSuYTty0NMzP96f6HXZUkpbOFJY5nFGUrriZYaOfJU5zUuOTrKB9bZmO8eB5LaWaR49GV31l6ZNJYVRnoEv7MOiC2le3cpvzGVkttKOjlCfkXZ2h04g7+1TBpzfRj2H0JHwbysfjxXfgWCOZue73TTtfEN+dTQIR0VNRH0pIaWfftqa88xGZVcqUV+aVL8MwZvB4s1NPMyQlPAvGeYqHNxskcziPYxydj4ubOn8XAXCjEbovNlF3CwuTNv88UaiQz7b8PNvr82rhIdr9ukfQbnNP/tzLaxK+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXM3vJLayvuwiayKN30uXr0rTLDdb+DqRZqGB8H9iMg=;
 b=OehJmtX4/92EsspK/RHjijFgb8zT2zlYzxTo9scoSx5C1+PZD3q0C3tnIPM0ZVa/L6LKsLeY8z+aOvDeT+orY08X1AFyMUkwor29zaiw5ROeuqPQ9QBazPFNwvs1Mueh3xLEd6OI+ClOIoblgDH2Abf9zZMX4Jly75Q5jQd9xGkF3Ibpvxags/sMZdVqYK3hsMcHjdEWe1wfbr2EepWN7S6YLc6w9//i3YeXTxtOFCL68fgwul6ZUxeQuklByYEqGEEluuvQvBzY3z2rPKnezKLyXA7EklTd5Q3Uyq7qgA6vEak5javOS/bDxk3IExoutSNSzodKHJlT4+ay7w3JHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 02:35:55 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:35:54 +0000
Date: Tue, 28 Oct 2025 11:19:30 +0800
From: Fei Li <fei1.li@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: <acrn-dev@lists.projectacrn.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Message-ID: <aQA2Qr2Z8UyaCLO8@louislifei-OptiPlex-7090>
References: <20251024044226.480531-1-rdunlap@infradead.org>
 <SJ1PR11MB615389E066F50BBB68686A26BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <213c918b-b4aa-4174-af89-a4d17e8c30dc@infradead.org>
 <SJ1PR11MB61536DC1E7A32387FCA400E5BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <8950bbb2-f1a7-4ae8-971f-7331c7eceff0@infradead.org>
 <SJ1PR11MB6153A77684F68B592851A32EBFFCA@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <be3819fe-c17e-4ce1-83ec-5ae23cfabac4@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be3819fe-c17e-4ce1-83ec-5ae23cfabac4@infradead.org>
X-ClientProxiedBy: KU2P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::7) To SJ1PR11MB6153.namprd11.prod.outlook.com
 (2603:10b6:a03:488::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6153:EE_|MN2PR11MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 81260867-67f2-4a9f-6d0d-08de15cab770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkVLclJRb1FwVGU4c2VOY1paL2VYc2lkYmUzQ2NhNHZWUmdtR0ZONXozVUI2?=
 =?utf-8?B?WlFkSVg5aEJRenptVlMzUGhuOWtMY3BLZUZWSUNJbnpFck53VWtqdEFUQVIx?=
 =?utf-8?B?ZE15aFJrbXhlNGFpWG9FNFVVckpJOUhRaDBqdUFJb0g2N0xyOVBoazVnY2Q1?=
 =?utf-8?B?clZXV1p2Znd4OTd1RmFOcjRTdUt0aFZ1aVc1UHRSYklzQXpIbE5wV09kbzZS?=
 =?utf-8?B?SkZWZVhjUmtTNzJTNFZxYUFHLzNVcHFPRm16dHNDaUhpQ3NKcWZ4Y3l3Z3gz?=
 =?utf-8?B?Y1R2eGlldG5WMjhaNml4d2pqenlNODJDb0JuTVRFZ09ZRGRvSU5CbjBHUXJ3?=
 =?utf-8?B?VXh2SzdVSzduQmZzUmI3eHI4eHQzbDBRekt2Tk92c3VKL2U4RmxXZ0Q5cWl0?=
 =?utf-8?B?aGUxU1VpdGs0WWVPQXVUUGxvaE93dnFOZFJ4dll1b2VScDRoZzJESDIwQkhU?=
 =?utf-8?B?SmR2NEpaV3ZwNjRjckpaWkJON1RCYjk2eG9HTTZqRXhzRVI3dzBHRTNaOEhF?=
 =?utf-8?B?a3RaS1NNQ0VJbE9VbGFibTdIZzlqRWExVGkzZTJHQ0dqNDFqSGNndjZKeklq?=
 =?utf-8?B?WlpoZ1pRK0tPaUwwaGVoT0R6c3phbDAwTStXMGRtUUtuY1ZFa0dKNnB3MFps?=
 =?utf-8?B?OSt0dk45YytCZzhZRVlZd0dDMjg1NlcyRitpU0s4TjE2R0F0TVJxWGd3Y0Yx?=
 =?utf-8?B?K3FQSTBxY3VIZ0lJWGVRNUg0VUJUZVNqeHJhR055NnhSeXdPOHNDTUpYTmNB?=
 =?utf-8?B?cHlHWjAwQ05GMHJmN1g4ZGtjT1I5eG1kekdhUHMvaTZZYjRUZTVwaGVCVDI3?=
 =?utf-8?B?YWdac0wzcmh0a0VqUFlrc0JVTHJhR0NVemFZUDd1M3lOL0ZOMzZXWStRbkZH?=
 =?utf-8?B?ejNoN1ZQeXdpMCtRTjE4NUJLdDhKRWNFa0p2SThsZGdNblNZNWo5T3piMk11?=
 =?utf-8?B?aFpTZHBxQUVPTjNSOEw2NGdZQnJUVUVYN3p4SFpFUlJlV1RFWFF4UXlUTXNW?=
 =?utf-8?B?WGI5dFlXaXBlNVBGdjRldSt4VzZHYklZck5LbVBwYi9zTHdIREdkNFFKOTNM?=
 =?utf-8?B?ZlhJUXNLTklnK3RsTGUwS2ZoOGlCUFZDaHYvUnRzWFlPZ0phRDlFb1pGQ2Rk?=
 =?utf-8?B?SkdKbGUwYkF0c1VYaUhFVE0wdDVBRHVjbkpRclF2WXl5bHFVVm5TcUQyeGt3?=
 =?utf-8?B?Z1ZvWlF1elpwSklUMXRjM3FTWDJteFpiZ3FGU3BMY3NsOS93OGdiUStRSWMw?=
 =?utf-8?B?WUNvR05IeUJnMGVPTTVEQ2VyZER5dmxkWkxpK1VlNVlFNllic0FrU0F1K3h0?=
 =?utf-8?B?Y0pZNnVPcGt1YVRXa0pqOTRvbjkxN0tkWXNqTXdMcWE3RlIzeTJHWTRrNXRX?=
 =?utf-8?B?UFZ3azVScmk1R1FLQ00wbGJVMG1hVWVWNmx0WFRVSkFvSnR0TXQ5bHNUQ2JG?=
 =?utf-8?B?TnNvazBnUGUzZlRYU29RbHFIak83eHd1NGlqbUlzVUdUcGJEMEdDMXMxakYz?=
 =?utf-8?B?WmhRWkVBYThxQUhQd0FvcC9HZmVQTWxSbCtieE1KaE1PWlBFdkN5bjFxcWpT?=
 =?utf-8?B?N1lMVUpUWElIYmtkeGw1OXBGWHZwSkJYTllXd21kazUxUFR0TkhWU21KWi8x?=
 =?utf-8?B?SW1hdHMyVjNrcFNDWG1yMWpqd1h4ZDJXTTFaM2EvV2l0L09sdXRlQmJSS1po?=
 =?utf-8?B?elhqamNJVi9RVTNaTnUveWlrU25QVXZjYys0N2lQblZuUXpuTUxoSU9kNmxW?=
 =?utf-8?B?MjFuaGUrUTFSYy9zV1YrWmRLelNqa2kyNVZuK0lWdStkbmxYVUpsQnE5dlU4?=
 =?utf-8?B?NHZqM000TmltTDhXRXJuWlhIbms2ZjBnamVhclNxOGEyMXR0LzRRZ3B4UW4v?=
 =?utf-8?B?UHdHbThBbHVSdXVMc3BZTFNRekJrUm5rMG5XMUE4LytvelE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZhalZIWnAxa0MyODRYczJIVVY3SE1panNwM2FWblVBM09FbEtLWW5FdFdQ?=
 =?utf-8?B?L3RGYjlrcG14Y2lEQU04VGlvSm0rNUYyUWhLZ2N4QitBY2FpVVlweVM4UjQr?=
 =?utf-8?B?ZXZkd0ZVcEVCRUxTcXJFVzF6RUliREhqTEZXTUxYUDdFWGEwSmlWZjJ1bDha?=
 =?utf-8?B?MDZoTmdJNDZGU1kvazJ5Z1ZKemM3dEtCK0RpRDB5Q2lIbGFYdXN5T0UrVlAr?=
 =?utf-8?B?NDN6aG93RzZrN201ZS9vYWJHZmNJY0Z3RVVkUUtBQk8zdDVuMGIyekRqWkJh?=
 =?utf-8?B?V3VjTEpaT3ErUWtaTUlwVWYyQW1Mc2k1TzJlSDNYWmEwcUV3SklZVGQwbjcx?=
 =?utf-8?B?TkFWa0NFYXdVRXF2UFBoWnIyYTZIbmZZbm12TTR6M0pPOHZzTTYrQWpOR1pX?=
 =?utf-8?B?K3VkUnRDcWkzYytSSEFIazhpTXlKMW1XZWhVQnFacEZLeXVqWGZLSnhLb1pM?=
 =?utf-8?B?UEFJS1pvaDliYWJQMHdWZGMyTkZnbDNMbmFEN3hUWGMxYll6NGp2T2tOd0dP?=
 =?utf-8?B?OG9qaDgrQzdPV1NGVkt5My84a0tQak4za2xlM3Z5bHozazhHTWcranBDOGVu?=
 =?utf-8?B?dVcxb3VVRkFDMUViWTFPdUFMemMwcWEyT1hMZzI1OHhyTXl5YU1xQ2ZoYk8r?=
 =?utf-8?B?alNFU2d5Wnl6SjVmY2ROa2hWb1ZVdEo4a29zZWYzbm85WkgzT3U2U0c2Y0Ur?=
 =?utf-8?B?WHBGNlNvUVpEOEFhK29KQnRoOGd3ZmpJYVl5bmVIUU5TM2M0Q0ZDbGtkUFl2?=
 =?utf-8?B?SUQ2NzRjczIzRkRmN3N2T1lZM2Z0ZG4vcXdMYmFTYXhtUitTTVZrUDFoWGVO?=
 =?utf-8?B?ZFB5YWRNZ3lHUU5CVitDR3plU1ZLbGU0ZUpFRERDZXBEUHBxSStmSEczT0hk?=
 =?utf-8?B?N1FmQWdhMkt4czRpTUtGWUVyQVJRR2VIK1NuaGZLUHdrSWE4Z3F3U3lYUEVE?=
 =?utf-8?B?THB0TGFnZkVrbk5oMmhzRWJMNGlaaWZjWGZCdUpRS1d5T2JhdXBsVkdnTlJW?=
 =?utf-8?B?NXFrNGVreWJnY2xoMmFmUVpHUyt0V01rYmVzaldXSU5BcmkyYTRQYmJyOWR3?=
 =?utf-8?B?aVFYMWlXdVVkR3NNaVhrbTZGaWFrQnN0WkNOTGNqUjRhaUZQOTJrUUxYZUFY?=
 =?utf-8?B?bCtNWnNTZnJ2ZUxOUWFuU25WMTFtNXhWRTZsQ1VCMUtlN1pHRHdSdmlnb1J2?=
 =?utf-8?B?bVhKSElhZ0lMRENTY0xaWWUrRHI1MlJBRys5eUtWcTNpRFNwbnJCeVY2WFRw?=
 =?utf-8?B?MVJLOTBPZkYzSFRYNVAwYko0TmppK1NLK0NWZW1BZjJwMTdHcmthSWFCYUVD?=
 =?utf-8?B?RmU1cWdFcVB1UFM2cFMxaXFBNUMvR2ZtbTdXOTN2Q0xuNnRlLzJ6SnM3ZWY5?=
 =?utf-8?B?Mzd4ZWoveUxHTkFFeFpZWHYzdnp2QzNBcjRTV0JVZkdFNW5lc3hIK1VkaDVr?=
 =?utf-8?B?ZVQwakZjVVVIN2lRanhNOTRuK0FPRjNFejRWWDM2ZDV3dWF0czlEcytCR0VB?=
 =?utf-8?B?NEE0UDQ3YVZ4dlFBbENya29rZGRUWE43ck52K0FIaUUyYkRBQ2tPaVJVNW53?=
 =?utf-8?B?S0xRVHRMU0oyaUhtYmxaNXprVGlROVlBRDNFNW5SUTdpQ1crN291R1ZXNnlH?=
 =?utf-8?B?L2RneCthQmMyck9VNjQ2WUxobFpURkFHa2tsamY2V3hpeTlqdjJFM0VJWXFx?=
 =?utf-8?B?R2lvY3p2V2pyQ09PNUFObEFtdm5pMnJDQUd5cnhyZEVLRmY5aHh5Mng1VFYw?=
 =?utf-8?B?S3AzcTgwYXFTVWlEV2htWU05L24xQjJFK0RpMGIxMldVY2RXQUw2ZDNxU3Fp?=
 =?utf-8?B?dCs0cjhTS1hXMjJlYnNDaUJ0NHBLKzh1MVBaTHRKS1FjTm1uQjZFUnozcUJu?=
 =?utf-8?B?WTF6aEVoZFEwL1VuWXk3Q0hVTGVjZFRKeXpNbnZJTE5MSWhWOHJSV3lDeHdF?=
 =?utf-8?B?eHpLYmduN1ZuQjErSjNwb09GRnduUWtjYXlIMnFpdmhnQ1ZGZHU1ODhRbHc3?=
 =?utf-8?B?K1F6SmJTdmNWNWNkckZLYUlYKzFMcG50b2MvYzMvaFI4NktOb1U1U0ZxYXZZ?=
 =?utf-8?B?T3YrTGEwdXJYc1pzUlhJOGkwUkd2MDgybW9tdElEODMxL3h3TXJQL1dOTUc5?=
 =?utf-8?Q?7tFzEyKKiu2i9q83EbOUXKydH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81260867-67f2-4a9f-6d0d-08de15cab770
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:35:54.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa6aJ2R3NaftsqbOOZVKbX0YFl8uS8Mb/yZudy6L1B3dJLPtRsMuH/PlX44ZMSbvJeQDfXJ0RFDI+LLhOpSLIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com

On 2025-10-26 at 23:11:07 -0700, Randy Dunlap wrote:

Hi Randy

> Hi--
> 
> On 10/26/25 10:54 PM, Li, Fei1 wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >> Sent: Saturday, October 25, 2025 3:44 AM
> >> To: Li, Fei1 <fei1.li@intel.com>; linux-kernel@vger.kernel.org
> >> Cc: acrn-dev@lists.projectacrn.org; Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org>
> >> Subject: Re: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
> >>
> >> Hi,
> >>
> >> On 10/23/25 11:22 PM, Li, Fei1 wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 10/23/25 11:00 PM, Li, Fei1 wrote:
> >>>>>> From: Randy Dunlap <rdunlap@infradead.org>
> >>>>>> Sent: Friday, October 24, 2025 12:42 PM
> >>>>>> To: linux-kernel@vger.kernel.org
> >>>>>> Cc: Randy Dunlap <rdunlap@infradead.org>; Li, Fei1
> >>>>>> <fei1.li@intel.com>; acrn-dev@lists.projectacrn.org; Greg
> >>>>>> Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>> Subject: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
> >>>>>>
> >>>>>> Fix the kernel-doc comments for struct acrn_mmiodev so that all
> >>>>>> struct members are rendered correctly.
> >>>>>> Correct io_base to io_addr in struct acrn_vdev.
> >>>>>>
> >>>>>> acrn.h:441: warning: Function parameter or struct member 'res'
> >>>>>>  not described in 'acrn_mmiodev'
> >>>>>> acrn.h:479: warning: Function parameter or struct member 'io_addr'
> >>>>>>  not described in 'acrn_vdev'
> >>>>>> acrn.h:479: warning: Excess struct member 'io_base' description  in
> >>>>>> 'acrn_vdev'
> >>>>>>
> >>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>>>>> ---
> >>>>>> Cc: Fei Li <fei1.li@intel.com>
> >>>>>> Cc: acrn-dev@lists.projectacrn.org
> >>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>> ---
> >>>>>>  include/uapi/linux/acrn.h |   11 ++++++-----
> >>>>>>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> --- linux-next-20251022.orig/include/uapi/linux/acrn.h
> >>>>>> +++ linux-next-20251022/include/uapi/linux/acrn.h
> >>>>>> @@ -420,12 +420,13 @@ struct acrn_pcidev {
> >>>>>>  /**
> >>>>>>   * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO
> >> device
> >>>>>>   * @name:			Name of the MMIO device.
> >>>>>> - * @res[].user_vm_pa:		Physical address of User VM of the
> >>>> MMIO
> >>>>>> region
> >>>>>> + * @res:			MMIO resource descriptor info.
> >>>>>
> >>>>> Hi Randy
> >>>>>
> >>>>> Thanks for cooking this patch to help fix these warning.
> >>>>> Could you just add the comment for `res` and keep the other comments
> >>>>> for
> >>>> the fields of ` struct acrn_mmiodev ` ?
> >>>>>
> >>>>
> >>>> Do you mean leave the [] square brackets in the field name?
> >>> yes
> >>>> If that's what you mean, that's not valid kernel-doc notation.
> >>> Would you please post the quote how kernel-doc prefer to add this
> >>> comments ? I didn't see an example in the kernel-doc.rst
> >>
> >> There is not anything in kernel-doc that indicates arrays so I can't post a quote
> >> that shows that.
> >> The patch shows the preferred kernel-doc here.
> > 
> > Hi Randy
> > 
> > IMHO,  the patch shows here is an example of `Nested structs/unions`, not an example of
> > `Nested structs/unions array`. 
> > For the ` Nested structs/unions array `, the `In-line member documentation comments`
> > style is more suitable, or could we just keep what it is for: (1) there're many kernels' codes
> > still use this comment style for theirs function comments, I.E., in kernel/rcu/srcutree.c
> 
> but that is not in kernel-doc comments.
> 
> > (2) the kernel-doc doesn't complain about this warning.
> 
> Yes, it's just wrong about that. As soon as it sees the "[]",
> it seems to become confused and omits all struct members
> after @name.  Here's struct acrn_mmiodev
> after I rendered it in man format:
> 
> NAME
>        struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
> 
> SYNOPSIS
>        struct acrn_mmiodev {
>            __u8 name[8];
>            struct {
>              __u64 user_vm_pa;
>              __u64 service_vm_pa;
>              __u64 size;
>              __u64 mem_type;
>            } res[ACRN_MMIODEV_RES_NUM];
>         };
> 
> Members
>        name        Name of the MMIO device.  res[].user_vm_pa:           Physi‐
>                    cal  address  of User VM of the MMIO region for the MMIO de‐
>                    vice.  res[].service_vm_pa:        Physical address of  Ser‐
>                    vice VM of the MMIO region for the MMIO device.  res[].size:
>                    Size   of   the   MMIO   region   for   the   MMIO   device.
>                    res[].mem_type:             Memory type of the  MMIO  region
>                    for the MMIO device.
> 
> Description
>        This structure will be passed to hypervisor directly.
> 
> SEE ALSO
>        Kernel   file   include/uapi/linux/acrn.h  struct  acrn_mmio_request(9),
>        struct   acrn_pio_request(9),   struct    acrn_pci_request(9),    struct
>        acrn_io_request(9),  struct  acrn_ioreq_notify(9),  struct  acrn_vm_cre‐
>        ation(9), struct acrn_gp_regs(9), struct acrn_descriptor_ptr(9),  struct
>        acrn_regs(9), struct acrn_vcpu_regs(9), struct acrn_vm_memmap(9), struct
>        acrn_ptdev_irq(9),  struct  acrn_pcidev(9),  struct acrn_vdev(9), struct
>        acrn_msi_entry(9),       struct       acrn_cstate_data(9),        struct
>        acrn_pstate_data(9), struct acrn_ioeventfd(9), struct acrn_irqfd(9)
> 
> 
> and here is the Members section after my patch:
> 
> Members
>        name        Name of the MMIO device.
> 
>        res         MMIO resource descriptor info.
> 
>        res.user_vm_pa
>                    Physical  address of User VM of the MMIO region for the MMIO
>                    device.
> 
>        res.service_vm_pa
>                    Physical address of Service VM of the MMIO  region  for  the
>                    MMIO device.
> 
>        res.size    Size of the MMIO region for the MMIO device.
> 
>        res.mem_type
>                    Memory type of the MMIO region for the MMIO device.
> 
> 
> > What do you think ?
> 
> Sure, if you want to leave the file as is, that's your choice.
> Consider this patch dropped.

Yes, you are right. The `dump_struct` in `linux/scripts/kernel-doc.pl` can't pasre
the `[]` properly since it can't tell this is for comment or for a struct_members.

So before kernel-doc.pl could handle the Nested structure array properly, maybe
define a structure for `res` maybe the better way to avoid the confusing.

Would you please help to define a `structure acrn_mmio_dev_res` just before
`structure acrn_mmio_dev` ?

Thanks.

> 
> -- 
> ~Randy
> 

