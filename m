Return-Path: <linux-kernel+bounces-736022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E71B096E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF923B2AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41F423504B;
	Thu, 17 Jul 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSkAiURV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C42367DA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791020; cv=fail; b=ZVeNIuhskyVPJVoRGnyD6VShp/fU9ZiLNuUK4z5LZM8F92BKeQdwii86iWxbN55ZVClrekqqohw0cDUuPhGUWrczwRRh7JsoYqO5AZWQV/hA29UzLeWoPJQRWyf52Vl6aOxGFc+eYo1n8mMXfn5EEHqBEOtG/AqsSWbEi+XUCA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791020; c=relaxed/simple;
	bh=iUHMgoFzLHDJpUuxnHJOKU9ATOY13DEjTeAkuODXcjQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqsYxzrv/sjG23lR+03YCgcToRbCgKWUmnqcJ8KOA9mKo+mekds9d35rwtOmEb2C/44pP/TB8XkMms+yRCERWL19FOAjY4wlH1bs6DrRaq/43+zUMB1S37zb1r2VGGP80+6f/YEqNm3Iv50P1yR0aFyjftJSjjMQao5GoJ/Xllg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSkAiURV; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752791019; x=1784327019;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iUHMgoFzLHDJpUuxnHJOKU9ATOY13DEjTeAkuODXcjQ=;
  b=PSkAiURVkm94seGElWpd1tfWchvq+DB6nI6kVKZuWOZdQVGHrrkS9uGH
   IrkQsfOal7f6E6BDE759q1b8SVh2eJ78g5rbONIdG0Nrun3wEfNE9zlb7
   RUFTUYq84o/gH7bBECBbWxYJMMcC4MV/8iMr77/wxS3LT4YhOreF5sSkS
   hztnhgY93sxD3xXiWwoVFKoG1Rq6XKEM+0tVEjatRQcAqYsmSpkmJKu0C
   IuIYHWSlDqW71Nj9F1UwXvyYs9eIRZ5+6E+rG6HRvwcDdaVPAK1xKsLYT
   MmXb2HSZ86lokWie9Yre9eBHwB6DCNWXlUFHpEdLCiU05xOfKxsqdfanE
   Q==;
X-CSE-ConnectionGUID: gyvrhrZVQbeRW82P3vAe6w==
X-CSE-MsgGUID: vx4yuXFmSrK0bpgA30avLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54962779"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="54962779"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 15:23:38 -0700
X-CSE-ConnectionGUID: X/07k+pCTseOpGCHJs0tUQ==
X-CSE-MsgGUID: pcKAgBYeS+C2GAU6Yv1Kgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188891085"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 15:23:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 15:23:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 15:23:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 15:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKBpY23/GmPme59g9XBsPFzPZ+BypIzuIBO+YHonhDNN0YncjzJJakHNomjFkup2F1C5OaZgCvFkSzv32+PLxQCVPHRvLRGlY7eiplE1LhvP6lODNFG6+vHL5O6SZBObGfF8dkh/SkprHyIGiexjIu3h5SJgYOa08SGDn9aUMCfBIUeXmWHDfq6NVunrd1qGWfIc38WUJQBuQHbJk00a0cOARE7jzckzDcUADy6d7we0bsiJ65S7xVgUmdjKEUD4gVxXxXYvmVK2EOx/0sKy4dq1QlJoUAYtcKpadn2uM91r5Px78cFvmM4Y7vVwPdrODXG/l7Q3Sg3q0JGRgPoqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UmxGd0Sm+tpsLTmdr2wDeouOpxHAPAqr60Bg0fmAkw=;
 b=jj2qIIVZZ4jGDHyoHrw3GDv92SHE2PGsalH8CocAQlg5OG8WslRTiFwpf2eSGzW8+6lrWLI56Ls9WxaLVI/cmbPQGYizDkHyEalMOy5A7EulBTLXXEuXjpf6PuhNSBfey87YAHN3y/Uce6cpAYSCrvuTA/fqxpcXs4W5jKMnEdZNliZnPNUe1njigwSRkjPAA/GSxqhVkbX6sq8RX2wDsmV9S+yWf6cVNUAv0NRL3UkdTkRZZPkAfwIMUgiv2y/v+dWOdecGFau8gHoP0QoRKkIZM2fDu8gU0L2nkQMQW+fh+0iHIohIp5H4tGQ5KyqucGR3EdnWiel3xR/jqGcG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 22:22:51 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Thu, 17 Jul 2025
 22:22:51 +0000
Date: Thu, 17 Jul 2025 15:24:34 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Karol Herbst
	<kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
	<dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, "Barry
 Song" <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu
	<jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>, Donet Tom
	<donettom@linux.ibm.com>
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
Message-ID: <aHl4IuMlE9D6yaET@lstrano-desk.jf.intel.com>
References: <D129A3F2-D79C-482E-BC70-A26C781B149E@nvidia.com>
 <1a451d37-56c3-4d60-8e06-3abae72e6bbd@nvidia.com>
 <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
 <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
 <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
 <a7e8485f-e9da-4edb-a809-a014517f26eb@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7e8485f-e9da-4edb-a809-a014517f26eb@nvidia.com>
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 955b651f-0673-4cf4-c2f8-08ddc5807788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1Q2RSt3UHd6QWl3c0YxRVB6ejM5Zks5UjIxTFo5RHdFZ3oybTF2WC91cURP?=
 =?utf-8?B?RlRjV1paN3I1Y3QyMFh6ZDc3aGRwWjZGd2tjRkl0OTdhYXh4Z0pSRUFXb3Fa?=
 =?utf-8?B?SGVwWW1DaHJhSlQvbDZTN3VwamNYZ05rdTNpN3JaRUdkYmZoNzViNGRFUlIw?=
 =?utf-8?B?RXRWdW43UmsvZllqaGdObzVvNFVtVCtQeUJ4ZkVndWJUYXM0dS9IWTFCQ0t2?=
 =?utf-8?B?R24zMDFrQXZYSGczcHc0SUxlbTdEVG1GSVFjNis1eXlOZnBRSTZnZFhGSHVU?=
 =?utf-8?B?ZGo5a0RCVXBBaXp0VXQxbzhnRWl3elBYZHYyMk1MTXd4N0dIL1hoSU9GQjdp?=
 =?utf-8?B?SXB5amhRZ3I1YTN3ZHJoOGNXRi81akwybzZDdHBwNDVOQVVqTFRZYllidERX?=
 =?utf-8?B?Z0luN3d6RzBqcW9FeU93TCt3NEpiQXA5MHhvcmNtM1dCdy92S0NmaE1Cb013?=
 =?utf-8?B?UzhGNi9oWUdaMmJYZHQyeXcxRCt3OHpOZkQyNHJUT0xqSXpJeXdoR0RNZklz?=
 =?utf-8?B?N0dzVkg3SFdyUWhCUEdXMm9sc2ErN3l2NXA5MmppVW85Nmo0cG50L0orU21W?=
 =?utf-8?B?UzlTZHIwdFlaUVlQMkVoOE9Ed0RnL3dqK0gySkZRM3NySWthM1d4SC91bVI5?=
 =?utf-8?B?anNiMzdGWEJoNTFwRkNUOHdDb3h5Q0xhd1o3VjdEQ3h2UG5DM2FwNkpjcUxM?=
 =?utf-8?B?T3IyOUg1VmxTSEhzVDQ4enpqdnNCWU9vUUxzWUpjbitZUk92N0VneDg1QXU5?=
 =?utf-8?B?UXdmMlNTTXJBNlFRZVBoVHVob2I3a0lESytjNWE3S09aNHZzZGpaV2h4cGJN?=
 =?utf-8?B?TkpyVHRpcGtxdDZRWkduNE5BZHFlck4ySHNWVzc1cHNXNFh5M0dpVGhaMlZz?=
 =?utf-8?B?NitxSm1GSU9NSlhQMXZMS0NnRTVRc1ZteVl2ZUdUR0dOVjlBc25DT2djRmtO?=
 =?utf-8?B?V3lyWXJaM05obkNsblNsaUpBZkFJWlpRUzNsaHhOZjJoeUJaeVZQMXZicmw4?=
 =?utf-8?B?MDRnVDhNblMwVk5BMU90SWJXSnZQdHBuRkJma3RLbTJnZVBteUF5WnFaNit4?=
 =?utf-8?B?UGNtaWVjM2xtM1BaYlB4Z3NjVkliUjE4T0h2TnhnRVc1TnkzZEpCb0Fra29t?=
 =?utf-8?B?SWtrRG1IcFk4MytRTVRHT1JZZjZpMi9aTTV0QnRjVXlxc2lLUlRVOURkdFNB?=
 =?utf-8?B?UEw1OUhiU0pEc2RsMDRqUHQrOEw1bEVKOFBjdmVsSXN1STVvMzlNWVROenJE?=
 =?utf-8?B?MkNUYkxkTXBzVUNCbGpzVG1WTmUzVVdsREQrcmVGV0xXK3gwSTJneEREbk4z?=
 =?utf-8?B?SlVXakdQTktyWTRqWnJPYXlsRlF6VlUveVR5RzRIaXprRHZTaDRMVTlKallV?=
 =?utf-8?B?a0NHZUpoSnV1ZjlhVDFvZUlkV0NjSnd0dWt0RHRCdStqMk9GdHc1N0pOUmlG?=
 =?utf-8?B?MUVNdncvRndqVDcrT3ExWmZqc1pZbjJVVE9LdjJvbXh1TUJkeVZFM09CU1V4?=
 =?utf-8?B?YThkWnhFVDFCVVBRMGxTbFJWT2ZnbndhRjJsWm55VWRqU2hDOEhTdEpUNFpK?=
 =?utf-8?B?b1FHaE1BNVVkOGEzYm1Pb05XOUUxVW9NblgvMXBRMm8yYVJ2VGJIR0k5emxF?=
 =?utf-8?B?VGg4V2djeWppZ2wvTE0rNlN0bEFrT3ZEZitETnRYejVhQVBLQ3VOdVFtTHV1?=
 =?utf-8?B?WEpNa0hDOGc5MXZhd1p0bGl4ZDJ5Q3J5NjI2a1NSSWx2VlhqRVM4cXRBL1Nr?=
 =?utf-8?B?disveXhyc1phSVJ5Nm5uS3RYRGxJZVJsaWFuejlHSzFyY20yelhqM0UzZTJm?=
 =?utf-8?B?MGdqTUhtM0JsY2RlV3RldytCTG45RXJaajhkK1Y4VDhQQzZJWXVNcEMwSTJV?=
 =?utf-8?B?U0VGM29qLzJMZEUxd1B2eTlldjNiR2JrbGt4SFpBRHk5T0hkTEtwRmJyNWd0?=
 =?utf-8?Q?GkTxns2sY7c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlSWUtNZFJvZU5LbXFmRlozeFJtMktFV28xUW45azZRb0JrUUw2ZzMzbjNV?=
 =?utf-8?B?NkswV3ZCUHphRzh1MGpLOXdmSmRuSE9LWjQ5c2ZFMXR2UklnNTQ0SEExSndl?=
 =?utf-8?B?TDFESDY5ekNMZk5VSUQ5NmduNThFT1BRVkVqcXBiVmo0Qmp4aFg5SzhacGY1?=
 =?utf-8?B?VDA2SEkyT0lHUVQ5dVlHUm9MdUM4TDh2QTR1bzlkejR6Um1GLzBGekhjcVFz?=
 =?utf-8?B?UytENFhBVGpsRnlBdGtQQy80YXU1R2s5dmdkTlpxZlB3d0FKeDN6bFkyYkRk?=
 =?utf-8?B?R2hzcUNhakliZUNTaCtvcnJSWlRtS3BPSzlSZFBYcFpURTJPZGppSU5QSllq?=
 =?utf-8?B?Y3JpMkE1a2FjSy9HeTltQXFFR01rTUNNRVhGbkRsdkNHbU5IdDQ1dFV5ZUdq?=
 =?utf-8?B?VEV6UHBEWnlRaU5UUFd5RzYwTHRWd00vdzA2WGRrMXNXRVZUd3N1QXd2bFVl?=
 =?utf-8?B?eTZ6VHZCUThmb0RpT0psOUNXN0Q3K3NLaVMxaXNLbjFBcEEvS3FueHNQQnVL?=
 =?utf-8?B?aHdoazgrSk1EUGpMVmh2WWlWbittMXJLajZmcUZGODRsZ0h5NXJCMzNDU0FX?=
 =?utf-8?B?VThKT1hNUUJiMWpoODNiSURSUGZxOWhoQ2FWdiswN3IzVnZ2NUI5TFRWa0ZR?=
 =?utf-8?B?NWFYUlVIYmJSTVdJZXV5am5MeEFmaWM2MFVTcnJqcGs1bW90VmNCTnVuc1pL?=
 =?utf-8?B?cWJRVDIxNWFSZWFLdXZDbHBjTGxYbVdWOGZqMHI1aVZ5NEtGdEJYbDNvK3NU?=
 =?utf-8?B?VFJSWmhpNjFiQUhscTVkUWRwUFdGalNEWHdnSGs4amErTTE4NkVsR1U0bVpI?=
 =?utf-8?B?RzExRGd1ZUlFUG1iSFRXaVFJcDRUVXhjK3V0R0ErVDliQlZuTUh4dTFkYjZa?=
 =?utf-8?B?UDFMb2NwMDI1SEV3VHpZbkRaK3VkSlNnSnNJMlppUUpXSVNwQStCZDZzbjFH?=
 =?utf-8?B?V3l3QWVneElLenRqejQxb1hBUnpaRVhpQnJXdWg0LzBOc1ptbUpYeXNoZnpX?=
 =?utf-8?B?dmplY0NGOGJleGR0TTJpdG1IYUVKMDMvc2lLOWNEUkZHMnluMDFjT2FSQWt3?=
 =?utf-8?B?RTRaRDErM044bkt4L04zUnVqUDF0VDVGWHN4Q1VqUXhJZ0txT3doaGR6RmJP?=
 =?utf-8?B?Z0hlaGhvS1M2Ri8yV2RveXlqT0tCdERNUXYvV1RoNTFWVlVoY0JINklJazFN?=
 =?utf-8?B?QmRPTjhHbGYvQ0E1cXBLcE5uVHROMlpRa0FacDZHK0JLMit1VU0xSVhDaEZu?=
 =?utf-8?B?ZjRib3FJWENKc0dGdERDZGVia0xqT2RmZzBNSEpldVcvZ0g0ZUFnclc1MEFL?=
 =?utf-8?B?dU9FY1NIYmlhVkdNLzZNa0hKYng0bCtYRnBMbjNDU2pLSUFNQjluR0tLMG9z?=
 =?utf-8?B?Wi9zQURYaUdVNjBnN29EdTBlRStkdWd3anJkMTV4YXR3UHcxb2dvMG55OWRV?=
 =?utf-8?B?TzBGbWNTQmh4aG1KRFdaUGR6cmRCeEFwWFprVE9YVDI3SEdQUjZnMkU5c2d0?=
 =?utf-8?B?QkY5Nlcxd2dLVVZ4T3NmVDYwckZHbXZycWgxNGxBZ0E4bWxNV0Z2RVd4MXJE?=
 =?utf-8?B?VmQ4YnkvV1l2SiswSmhhTjdjMDhnblJjRFMyNCt4azZGODBmenU5U3JDb0Vn?=
 =?utf-8?B?UFpRRXNMaHFxenBzSUpLK2lWSWl1amxPaXhXVWxSdlBOZ01vTERCQUJoejd6?=
 =?utf-8?B?cmZqY0RFcHE1bDBPZ0VLZ2tQdC9xdUNpcjluazNZa3drei8yU0RRSlNONnBY?=
 =?utf-8?B?ZDdVbW9wYlJMQ3ZxTjZjanFxVlUrcElOT2IvUm9Wc1ZGaVk1VEZQdVBzQk5s?=
 =?utf-8?B?TTdIK05SM1VXWVZBTWtFWXZySFp5elh4MUtWL20vSGhlTDFmRVJpU05XTVhu?=
 =?utf-8?B?NTFuS1ZGaHNuU0ZxSERqdHVueG5pTERrZmhPY3FrL3lWU01ERjg2UXVIRmpL?=
 =?utf-8?B?UEZlakxpaGRPeWNXLzVqSWt5YlNsc1Q2dFVDMHhDaGV2OUpEdFprWlZKRi9y?=
 =?utf-8?B?OG9LQVFvOEd6Z3lwKzh5azlVekt6RUZ6VzVGZDZqNDlxZmJtazZsWWRxaUdt?=
 =?utf-8?B?TmRWU1d4QTRFc2VxRkJYV0Q1ZjVMNzNsZzlWQm9KaFZwakNNNlNScUVxQnVs?=
 =?utf-8?B?UXZzMmdNQmJscklwcCtJSlQ2YjBFUUh4Yll0UUxqdDcyVHZCd3dHOHlaQnJk?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 955b651f-0673-4cf4-c2f8-08ddc5807788
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 22:22:51.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23HGSeWzmuY1oOKZxAwnXrOay/X/OYZN2JWIRCYH+yW6i3Cfwa3LTLtPL/7zQV86kIcgqgLC0lp2kZ1Ebiat8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001
X-OriginatorOrg: intel.com

On Thu, Jul 17, 2025 at 07:53:40AM +1000, Balbir Singh wrote:
> On 7/17/25 02:24, Matthew Brost wrote:
> > On Wed, Jul 16, 2025 at 07:19:10AM -0400, Zi Yan wrote:
> >> On 16 Jul 2025, at 1:34, Matthew Brost wrote:
> >>
> >>> On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
> >>>> On 7/6/25 11:34, Zi Yan wrote:
> >>>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
> >>>>>
> >>>>>> On 7/5/25 11:55, Zi Yan wrote:
> >>>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
> >>>>>>>
> >>>>>>>> On 7/4/25 21:24, Zi Yan wrote:
> >>>>>>>>>
> >>>>>>>>> s/pages/folio
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks, will make the changes
> >>>>>>>>
> >>>>>>>>> Why name it isolated if the folio is unmapped? Isolated folios often mean
> >>>>>>>>> they are removed from LRU lists. isolated here causes confusion.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Ack, will change the name
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>>   *
> >>>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
> >>>>>>>>>>   * It is in charge of checking whether the split is supported or not and
> >>>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>   */
> >>>>>>>>>>  static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>  		struct page *split_at, struct page *lock_at,
> >>>>>>>>>> -		struct list_head *list, bool uniform_split)
> >>>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
> >>>>>>>>>>  {
> >>>>>>>>>>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> >>>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> >>>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>  		 * is taken to serialise against parallel split or collapse
> >>>>>>>>>>  		 * operations.
> >>>>>>>>>>  		 */
> >>>>>>>>>> -		anon_vma = folio_get_anon_vma(folio);
> >>>>>>>>>> -		if (!anon_vma) {
> >>>>>>>>>> -			ret = -EBUSY;
> >>>>>>>>>> -			goto out;
> >>>>>>>>>> +		if (!isolated) {
> >>>>>>>>>> +			anon_vma = folio_get_anon_vma(folio);
> >>>>>>>>>> +			if (!anon_vma) {
> >>>>>>>>>> +				ret = -EBUSY;
> >>>>>>>>>> +				goto out;
> >>>>>>>>>> +			}
> >>>>>>>>>> +			anon_vma_lock_write(anon_vma);
> >>>>>>>>>>  		}
> >>>>>>>>>>  		end = -1;
> >>>>>>>>>>  		mapping = NULL;
> >>>>>>>>>> -		anon_vma_lock_write(anon_vma);
> >>>>>>>>>>  	} else {
> >>>>>>>>>>  		unsigned int min_order;
> >>>>>>>>>>  		gfp_t gfp;
> >>>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>  		goto out_unlock;
> >>>>>>>>>>  	}
> >>>>>>>>>>
> >>>>>>>>>> -	unmap_folio(folio);
> >>>>>>>>>> +	if (!isolated)
> >>>>>>>>>> +		unmap_folio(folio);
> >>>>>>>>>>
> >>>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
> >>>>>>>>>>  	local_irq_disable();
> >>>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>
> >>>>>>>>>>  		ret = __split_unmapped_folio(folio, new_order,
> >>>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
> >>>>>>>>>> -				uniform_split);
> >>>>>>>>>> +				uniform_split, isolated);
> >>>>>>>>>>  	} else {
> >>>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
> >>>>>>>>>>  fail:
> >>>>>>>>>>  		if (mapping)
> >>>>>>>>>>  			xas_unlock(&xas);
> >>>>>>>>>>  		local_irq_enable();
> >>>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>>>>> +		if (!isolated)
> >>>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>>>>>  		ret = -EAGAIN;
> >>>>>>>>>>  	}
> >>>>>>>>>
> >>>>>>>>> These "isolated" special handlings does not look good, I wonder if there
> >>>>>>>>> is a way of letting split code handle device private folios more gracefully.
> >>>>>>>>> It also causes confusions, since why does "isolated/unmapped" folios
> >>>>>>>>> not need to unmap_page(), remap_page(), or unlock?
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> There are two reasons for going down the current code path
> >>>>>>>
> >>>>>>> After thinking more, I think adding isolated/unmapped is not the right
> >>>>>>> way, since unmapped folio is a very generic concept. If you add it,
> >>>>>>> one can easily misuse the folio split code by first unmapping a folio
> >>>>>>> and trying to split it with unmapped = true. I do not think that is
> >>>>>>> supported and your patch does not prevent that from happening in the future.
> >>>>>>>
> >>>>>>
> >>>>>> I don't understand the misuse case you mention, I assume you mean someone can
> >>>>>> get the usage wrong? The responsibility is on the caller to do the right thing
> >>>>>> if calling the API with unmapped
> >>>>>
> >>>>> Before your patch, there is no use case of splitting unmapped folios.
> >>>>> Your patch only adds support for device private page split, not any unmapped
> >>>>> folio split. So using a generic isolated/unmapped parameter is not OK.
> >>>>>
> >>>>
> >>>> There is a use for splitting unmapped folios (see below)
> >>>>
> >>>>>>
> >>>>>>> You should teach different parts of folio split code path to handle
> >>>>>>> device private folios properly. Details are below.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> 1. if the isolated check is not present, folio_get_anon_vma will fail and cause
> >>>>>>>>    the split routine to return with -EBUSY
> >>>>>>>
> >>>>>>> You do something below instead.
> >>>>>>>
> >>>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
> >>>>>>> 	ret = -EBUSY;
> >>>>>>> 	goto out;
> >>>>>>> } else if (anon_vma) {
> >>>>>>> 	anon_vma_lock_write(anon_vma);
> >>>>>>> }
> >>>>>>>
> >>>>>>
> >>>>>> folio_get_anon() cannot be called for unmapped folios. In our case the page has
> >>>>>> already been unmapped. Is there a reason why you mix anon_vma_lock_write with
> >>>>>> the check for device private folios?
> >>>>>
> >>>>> Oh, I did not notice that anon_vma = folio_get_anon_vma(folio) is also
> >>>>> in if (!isolated) branch. In that case, just do
> >>>>>
> >>>>> if (folio_is_device_private(folio) {
> >>>>> ...
> >>>>> } else if (is_anon) {
> >>>>> ...
> >>>>> } else {
> >>>>> ...
> >>>>> }
> >>>>>
> >>>>>>
> >>>>>>> People can know device private folio split needs a special handling.
> >>>>>>>
> >>>>>>> BTW, why a device private folio can also be anonymous? Does it mean
> >>>>>>> if a page cache folio is migrated to device private, kernel also
> >>>>>>> sees it as both device private and file-backed?
> >>>>>>>
> >>>>>>
> >>>>>> FYI: device private folios only work with anonymous private pages, hence
> >>>>>> the name device private.
> >>>>>
> >>>>> OK.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> 2. Going through unmap_page(), remap_page() causes a full page table walk, which
> >>>>>>>>    the migrate_device API has already just done as a part of the migration. The
> >>>>>>>>    entries under consideration are already migration entries in this case.
> >>>>>>>>    This is wasteful and in some case unexpected.
> >>>>>>>
> >>>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
> >>>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You probably
> >>>>>>> can teach either try_to_migrate() or try_to_unmap() to just split
> >>>>>>> device private PMD mapping. Or if that is not preferred,
> >>>>>>> you can simply call split_huge_pmd_address() when unmap_folio()
> >>>>>>> sees a device private folio.
> >>>>>>>
> >>>>>>> For remap_page(), you can simply return for device private folios
> >>>>>>> like it is currently doing for non anonymous folios.
> >>>>>>>
> >>>>>>
> >>>>>> Doing a full rmap walk does not make sense with unmap_folio() and
> >>>>>> remap_folio(), because
> >>>>>>
> >>>>>> 1. We need to do a page table walk/rmap walk again
> >>>>>> 2. We'll need special handling of migration <-> migration entries
> >>>>>>    in the rmap handling (set/remove migration ptes)
> >>>>>> 3. In this context, the code is already in the middle of migration,
> >>>>>>    so trying to do that again does not make sense.
> >>>>>
> >>>>> Why doing split in the middle of migration? Existing split code
> >>>>> assumes to-be-split folios are mapped.
> >>>>>
> >>>>> What prevents doing split before migration?
> >>>>>
> >>>>
> >>>> The code does do a split prior to migration if THP selection fails
> >>>>
> >>>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-balbirs@nvidia.com/
> >>>> and the fallback part which calls split_folio()
> >>>>
> >>>> But the case under consideration is special since the device needs to allocate
> >>>> corresponding pfn's as well. The changelog mentions it:
> >>>>
> >>>> "The common case that arises is that after setup, during migrate
> >>>> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
> >>>> pages."
> >>>>
> >>>> I can expand on it, because migrate_vma() is a multi-phase operation
> >>>>
> >>>> 1. migrate_vma_setup()
> >>>> 2. migrate_vma_pages()
> >>>> 3. migrate_vma_finalize()
> >>>>
> >>>> It can so happen that when we get the destination pfn's allocated the destination
> >>>> might not be able to allocate a large page, so we do the split in migrate_vma_pages().
> >>>>
> >>>> The pages have been unmapped and collected in migrate_vma_setup()
> >>>>
> >>>> The next patch in the series 9/12 (https://lore.kernel.org/lkml/20250703233511.2028395-10-balbirs@nvidia.com/)
> >>>> tests the split and emulates a failure on the device side to allocate large pages
> >>>> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511.2028395-11-balbirs@nvidia.com/)
> >>>>
> >>>
> >>> Another use case I’ve seen is when a previously allocated high-order
> >>> folio, now in the free memory pool, is reallocated as a lower-order
> >>> page. For example, a 2MB fault allocates a folio, the memory is later
> >>
> >> That is different. If the high-order folio is free, it should be split
> >> using split_page() from mm/page_alloc.c.
> >>
> > 
> > Ah, ok. Let me see if that works - it would easier.
> > 

This suggestion quickly blows up as PageCompound is true and page_count
here is zero.

> >>> freed, and then a 4KB fault reuses a page from that previously allocated
> >>> folio. This will be actually quite common in Xe / GPU SVM. In such
> >>> cases, the folio in an unmapped state needs to be split. I’d suggest a
> >>
> >> This folio is unused, so ->flags, ->mapping, and etc. are not set,
> >> __split_unmapped_folio() is not for it, unless you mean free folio
> >> differently.
> >>
> > 
> > This is right, those fields should be clear.
> > 
> > Thanks for the tip.
> > 
> I was hoping to reuse __split_folio_to_order() at some point in the future
> to split the backing pages in the driver, but it is not an immediate priority
> 

I think we need something for the scenario I describe here. I was to
make __split_huge_page_to_list_to_order with a couple of hacks but it
almostly certainig not right as Zi pointed out.

New to the MM stuff, but play around with this a bit and see if I can
come up with something that will work here.

Matt

> Balbir

