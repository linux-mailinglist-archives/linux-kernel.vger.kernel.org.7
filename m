Return-Path: <linux-kernel+bounces-756974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE8B1BBAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DB7622A40
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F784239591;
	Tue,  5 Aug 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihUgutbs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB121766A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428600; cv=fail; b=LsF5i/zsHX6k/RdMcU8H/kEGGB8OMhQUyp+qSQrkn6PZwsu8gKpy7UpeffRl7VpwTLTdijFk7xVXAIhTKPhujyRbfqH9ubFAp5UgRMTaWcYkjakw+vrugABd8sXMpxJ5L84cuWjQN0OfdP761VvVPcuTZYG+cgA5QZySl5fiEK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428600; c=relaxed/simple;
	bh=Njv2jaFOS7Vj5/+WS0rOtAW/cRqOa5jxImS09cnyq70=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OV7QLwHHIBx/6nZHFg68JWw4UrUb2jRAwhrHROZo2vbnyjh0VAHjN2Abw/WDIbnBNUlEtGjTzzTY2OGQPHwpD7xzWAMK218EjEIi8U2Az8sVLYgu6M4tti2lO+xT2d+6LkiDSzM+HbJHRm/4pSwa7klIIxWIJtx2Hw8kbyFvvQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihUgutbs; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754428599; x=1785964599;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Njv2jaFOS7Vj5/+WS0rOtAW/cRqOa5jxImS09cnyq70=;
  b=ihUgutbsXZ0Nk40GeKlikceougCd22jkY3NP0oprqV+6C9qnq33RPBqc
   P9B/WVK1nuVdqVsRWlicdGrbYCALRwDvxJ4v3cHRDe406Z+c72Yb2upo0
   pvErFPTFdBfld7ftxNL5o0kR55Cz2Id31ItAs/mVdh7cqune4uId0BWKC
   MCCz+6wjuVfOWaASQdb3OpKBtWQkMZsOsZ0VKCBJPl42JL3ARDp86O3de
   ZEA4KHCAPgLkh3Yc9xgUt0UCojJ8b2pBko2oL1Aw6piaMcoAvscwok+af
   OpQjxXf/AuFhFe/7TI6qzjgGg2hORhwzqVke1xAKXHkuf0TvZ9GtTWysb
   A==;
X-CSE-ConnectionGUID: IqCXprUJRtSBdHGs6TYC6A==
X-CSE-MsgGUID: FmPYSW3XTEuMTyScIpN9DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56451891"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56451891"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:16:38 -0700
X-CSE-ConnectionGUID: LI8betmnR1S8xGskJ1LEfg==
X-CSE-MsgGUID: Vnra1NDpTVmdRM3JWyfX8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="188273504"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:16:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 14:16:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 14:16:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.85) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 14:16:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR64GpvcO3tQPh4dp3jxTiuOewWLu77yPjB5LFhPECv0H+8VxXpFhA5wHkdRmp71Vo/MPMeoFOC8cJ6MTeHAkAGOxYRQ2j8RP53bpyRytgZHv4XN2n7Ypcclik944L7BaP6PlosJsipWOsIir0nOfeeH65qWu8XeoGiadfOkMVj0whKIcVvl4o62efItC/pGB0mlz+HYsiJjbzog3pJ07GHR8ytP0QpIVgQtDfc45Zuf7r7zqntRkQGA4MQskNwTSKd4zvFMSG8HyH3eNR64ejkhylpH0qH5g7lv+oZsat8k8n/6WI3Avk06gwu7Voj1ozRagO3Oo7t6ouJCQwV/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a1U0D84qebwUG08p3o6mshe5QkK+WFcWafkXKjAlzo=;
 b=dMQjRE1pEaliu9c59wLEeAHKrXLKD2Yzn6W3CD5dOlwJ1t9pL3MdeLzU9NvfnQcLLkqZE3aVmRcDi2DR7Pn/U0ubNvQ2Jrb1NaM6Bn35hkMqN5y10uJ2NGSuuivU8C59lQ6Z5Mfahm0W8Stan4RIAEEVg43kbT6dibwOGCJn3bbr+0pkPTZA6Msvv6Cx7eqUZuCfMlFaT4VMAcZ4sClAQfQRg/r04LCouaAF0KtHzBVyjpUoYMbww1I/c/4sN52GaxluH+Y7QW7Fv+cVWQobu3pwUgcWj7C/FyBEyXJNUt/ox2CtGrUGphVQRCRmTFcvXyKi2qumjKIEgEU96AEF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA3PR11MB7486.namprd11.prod.outlook.com (2603:10b6:806:314::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 21:15:52 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 21:15:52 +0000
Date: Tue, 5 Aug 2025 14:15:49 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: David Hildenbrand <david@redhat.com>
CC: Balbir Singh <balbirs@nvidia.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Karol Herbst <kherbst@redhat.com>, Lyude Paul
	<lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Barry Song <baohua@kernel.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>,
	"Matthew Wilcox" <willy@infradead.org>, Peter Xu <peterx@redhat.com>, Zi Yan
	<ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu
	<jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>, Donet Tom
	<donettom@linux.ibm.com>, Ralph Campbell <rcampbell@nvidia.com>, Mika
 =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>, Francois Dugast
	<francois.dugast@intel.com>
Subject: Re: [v2 01/11] mm/zone_device: support large zone device private
 folios
Message-ID: <aJJ0hTS52PVAq1sp@lstrano-desk.jf.intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-2-balbirs@nvidia.com>
 <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
 <1e307223-897c-4db0-9564-95d76bc3d260@nvidia.com>
 <98a30c7f-8be1-4b08-955c-724667971288@redhat.com>
 <9c0ad782-e1c3-4c7d-bb20-730d2f915dd5@nvidia.com>
 <da283a44-e668-4e88-985c-3e2805b556bc@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da283a44-e668-4e88-985c-3e2805b556bc@redhat.com>
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA3PR11MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac1c86f-7d53-431b-7915-08ddd4654237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LN1ZcpI4poSNuRMV0kOEgVaRYUz6V4rpGnc6UAXypBlDbQn+VnLvs6LaVAsD?=
 =?us-ascii?Q?4OHbb21Fcx8sAXn3K7JJKiB4hbKP/3xnxd2b2HtYzffxhayk1mFmaiKgSOkH?=
 =?us-ascii?Q?Vxp5gmqzT+jRWpOzbQUYRvt+yzNFNQG9r4f6eVTnN7ZM19qWLMOcmT7MTRoV?=
 =?us-ascii?Q?7+JTvnvCF1vWvDn0CH9wlEB0Rem7qydcaYZVLs07X/MD3bLUaxyDhCCrYN/T?=
 =?us-ascii?Q?pOd9rChw26ncAV/1SVsXWOx8aqDTiCJc7acW5JQcUQ4FTdd3FJZDkzd0/eR3?=
 =?us-ascii?Q?Wygq4eUQSKtqzOBsEBp1YVz0La/EFdhnWdv/3/VuTXiv2UUeflyz0Jvej67n?=
 =?us-ascii?Q?d4MgnqGf5DpfCoQu7Y4SYWk7XG4XeQJoldvYuRzOJ31EWEWZS1UylpKxayNu?=
 =?us-ascii?Q?lvrLLcUTah4MMhMVEATiMD8uKOfz2FoJEhFCpALY2RxbQegqXLUCJJpxxqV6?=
 =?us-ascii?Q?MtMYjo5tQwebCpWzwqw2UCt0GwIsgEvzkZ5Ov9Rm1xLi+fireSu13A7oIwWB?=
 =?us-ascii?Q?++FUQQ0UANHBm5+EY6d/ahP7fP/zYnzJkpb0CHKbCxY1lchmLyv04RwCWH2f?=
 =?us-ascii?Q?FcjL6LAp5UwenbL+Am0+NufHeHu2y4Qe8r0GyXxSOHGyrRU26TGe6HvauHKn?=
 =?us-ascii?Q?g20fIWxjshd1cK4saEdvHrjdz8uQJdeqiDqiBtPJicDlYeVCoFbyYyY53WtS?=
 =?us-ascii?Q?DR/ERr15eur2pbBRln3qdEP2BnBgOm+dKLxMUEaQRsWEM9U1IpBmUKDaKGvP?=
 =?us-ascii?Q?RO7y8OH6NJCfRCQ8EmEudgBNg+hj3VEgbAyASqI0K9X8+LY/BXdyImihlF1U?=
 =?us-ascii?Q?RwnYcUPQqR07k3oOmbMLpISL3c1Dhs/3Gt2TXtR08/TTLPQXU2JfDCS8g4j3?=
 =?us-ascii?Q?vfpUax8PJhCIs69M6nbsAjP4idCBz/EGel5SnM30Ei3t0psxRqU/le1TUTXV?=
 =?us-ascii?Q?ISuakOdZM3gFgU/f+Aeutchfx1mypTZQ+ulSBxAYUbYKnBTSbMJNPtTlvs2O?=
 =?us-ascii?Q?sl5hjwrp64U20r+snVoOTgvxbMeiH6L1Vm8Tctba5VbHgV/ILQHN+WBi3MjU?=
 =?us-ascii?Q?A1gXFCMb/yfhq7lcUugQbeqHfoYptohbCUHDqvx0kwE6DIsJ6OAcfAgG8Vln?=
 =?us-ascii?Q?8VpVY33QIBP7FZvQ4dFwscNclxz/f/AIlxmh2/kEnKWsmHKJepHcMpjh/13r?=
 =?us-ascii?Q?cs7H1X4T1sGJqLHSsLCJSVxSfXzKVlGwMYUUX22jtEZQpolrgg/rLGehdRwL?=
 =?us-ascii?Q?iVp6jP+pb8CO7qViDlhxsaxfqUgfRraCuD2s+YrFIGNEWa3jMVHuryYcS3I6?=
 =?us-ascii?Q?PtkDeh3SgZE1cDuaqfQRoqDt4SLTUlHjxggJcyYFBGCbZaFJokWx8flfu30u?=
 =?us-ascii?Q?HpJkTFX2IO729E2r2Xr2SVYfY2UTkmQbSMle53X01x7wnvkCvGVroWTdiyvM?=
 =?us-ascii?Q?HJFsvTCK1Pc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b+vUo52cExNfcOlSMK05CxtF/mGD65GrDLkpxQ5p0lrZss/ze+zKZaWFmfqK?=
 =?us-ascii?Q?Gqsv8O3NjU6ui+bhudiJtfDDXjGFw/A4a0ju461S9EsHF7OubS6RS0WPxdFM?=
 =?us-ascii?Q?zz2f4SciFMUhDzsr9WKkEITANSBjhJDJFBIb+o8iH3gbbqaV1+g5s3xRtFPV?=
 =?us-ascii?Q?K3sANon9NZuuM7n5l/VF96EYvJyauP0yGPglKj7HQRwX9uaI4gx6A6Mad/7+?=
 =?us-ascii?Q?YrZ/NA4jhnc2XoGYKWGTKxz3PIKRMpseiMUzji3qJXMJsHG6lJZr8W3Ya5+h?=
 =?us-ascii?Q?3RlMsHD0tUpb43M+w1a+UIm9UHU/S15lgQC0HtKXhLKmEFZ5e+9Tt1M5Vy1Y?=
 =?us-ascii?Q?8AlmAAZHDXbofHlplMCEbYCKDnXAr80Y3tHrKmJTE7DsBv2ekhb1y1f3PRxz?=
 =?us-ascii?Q?MVFjRkXKldePnlHIIwAOh8vn+qq0SZVrB/Un57ISg36pDJwIYx9nchztwB51?=
 =?us-ascii?Q?cpi/lfh3IeqbDAMzqboa6Oov+uCuRrQf3buy9+c7aPGmqIWdkLI9hw7KUdfH?=
 =?us-ascii?Q?DoaRCR78KJA5JBhTVYJZAZp4QebT2Da3Bd/ttCE3mFTSVJ0l81e5fIwLdl/y?=
 =?us-ascii?Q?HXLpjH35AV6G8imuN1e5obY6ph//sTn8RGgwKznBVEOvn0OxwbBJlZG+4KTV?=
 =?us-ascii?Q?mEFDTmM5Mzaq3GSVikkA8xxtJPDYWPjbd1F/KC9RkmY/i8yQ7IJJe+a+SK1l?=
 =?us-ascii?Q?kGhrLoGJliEzeJrNxsFbcrN/B/Gn8Bgaaw7Fq0QdaWL5MrYHkpiMY7pO58pV?=
 =?us-ascii?Q?qoepH3tMlDtQgOxMFgdRLmnNzYclJqryv7ubidrKrUaoMxAvQfqse0+qjg44?=
 =?us-ascii?Q?YlNo1QrpDFAyg5xW5zog8kdPg+dP/SQcWyuZi9rZOFN/8/VCKaMIPKBD6+4P?=
 =?us-ascii?Q?UtQF6yQJNdVfN0bwAUEknH1CrO4dvl++DRXUWaKBLpbKjleFiiHNKKN3Kn4z?=
 =?us-ascii?Q?hxyWNSf9bggcF6dYyvPYj6nU224SeMq3t4yLuIu+K6F3jgtrT/v173PMKtNw?=
 =?us-ascii?Q?pmCIcs1cBCGzZHajzbdgLLILqLi7LDzyB5LEE6hARMuLPZd0GTel4vMpSTjU?=
 =?us-ascii?Q?0jswykw646ppAO1L1VSIZnXj+FriyQ0/lxlR2YMmlACpskbZvci5Zy4uO2ZE?=
 =?us-ascii?Q?YrlqYTRTd/WTRzmyr/QeZObhnFxj9MDSf5tG7fXjhiCZiQLRxTAFZPnWBBcm?=
 =?us-ascii?Q?nihDHQACPBdLeqAiWdFxQRfV2W024ROV8u6nOGtmJjkdgYwXZYC98lqcZmry?=
 =?us-ascii?Q?XRgl1yDEc29lSWphuKRnw0NNC+XzoSp8VWpF+gu7RxPdy0oFdHIzRbbv4CQ3?=
 =?us-ascii?Q?EA01tJT+Uw8RYLVNX0O0ZtsmUqn/iHwkGUzVYlIYujqD1mCRYvB5gqN1flx+?=
 =?us-ascii?Q?6/K8aG6/j41AH0pAK7/7Nfp6X6WgKzHUUutnUGh1ICeaGaylwdb8vtgPTe44?=
 =?us-ascii?Q?XMSrTLuuRm3Y4etGk+beeQlamQmZezTWBPqtaPTAOgUjtwFFSOfUrZwI8t4M?=
 =?us-ascii?Q?8D5V94UqG/Bu+07a23S5ZQqz8a4Y6b+5UMFn6wOvsO/I52t3AZT0mil3iMCt?=
 =?us-ascii?Q?y6EGP6ybzB0t2qXT8APSGEFEzzaPZuEuK2to6ycwXXyj/FDCv9OghR55PB1D?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac1c86f-7d53-431b-7915-08ddd4654237
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 21:15:52.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMY2pDyPE5YeZC+JBCxO2qgm3pb8rO862LYqo/I7pENOoFSkgKy1o+fQurH88slgXddb1sqwhdkXvsbaqSXe7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7486
X-OriginatorOrg: intel.com

On Tue, Aug 05, 2025 at 02:58:42PM +0200, David Hildenbrand wrote:
> On 05.08.25 13:01, Balbir Singh wrote:
> > On 8/5/25 20:57, David Hildenbrand wrote:
> > > On 05.08.25 06:22, Balbir Singh wrote:
> > > > On 7/30/25 19:50, David Hildenbrand wrote:
> > > > 
> > > > > I think I asked that already but maybe missed the reply: Should these folios ever be added to the deferred split queue and is there any value in splitting them under memory pressure in the shrinker?
> > > > > 
> > > > > My gut feeling is "No", because the buddy cannot make use of these folios, but maybe there is an interesting case where we want that behavior?
> > > > > 
> > > > 
> > > > I realized I did not answer this
> > > > 
> > > > deferred_split() is the default action when partial unmaps take place. Anything that does
> > > > folio_rmap_remove_ptes can cause the folio to be deferred split if it gets partially
> > > > unmapped.
> > > 
> > > Right, but it's easy to exclude zone-device folios here. So the real question is: do you want to deal with deferred splits or not?
> > > 
> > > If not, then just disable it right from the start.
> > > 
> > 
> > I agree, I was trying to avoid special casing device private folios unless needed to the extent possible
> 
> By introducing a completely separate split logic :P
> 
> Jokes aside, we have plenty of zone_device special-casing already, no harm
> in adding one more folio_is_zone_device() there.
> 
> Deferred splitting is all weird already that you can call yourself fortunate
> if you don't have to mess with that for zone-device folios.
> 
> Again, unless there is a benefit in having it.

+1 on no deferred split for device folios.

Matt

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

