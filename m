Return-Path: <linux-kernel+bounces-743564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B54B10048
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD231696A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2EC2046A9;
	Thu, 24 Jul 2025 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIooqi8x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADED51F37D4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336566; cv=fail; b=mGyybDZ12bc4WcuDQVBx2+yK9EtxVkYzd/XE2fyJKpIVZP6Ul+k1j4u1n0DP4CoVN1tP/WfrpmbExS7iFvWeuXCQxxd4gnbmH9wrV5CsKcGpNIpJlUNWNSCGi2/qG5qGQNe1eUIKlqxKVkFr5fBdS4LzkrnT+ujxB3ZGXVlv9hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336566; c=relaxed/simple;
	bh=u53YJHH/eub0bk2fNfCQgLTtkYgP/Tz9G/gU/aUL3W4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t2iFfB/8w22f9ZPwNZTzcfQhgH71FWjKUXtjmiS0/nq/Y3jKH4Y+HvBsBZSZkGFPg7jI7asNl1SqMEcbIpxU74OHyv8ye8IQKBIPLwAe/W2A+whS0rl63cB6rVs5HkomA1wgRhfQiUZVYN3dIDCB99wbC8iPp6aeRj4sLEk2PBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIooqi8x; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753336564; x=1784872564;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=u53YJHH/eub0bk2fNfCQgLTtkYgP/Tz9G/gU/aUL3W4=;
  b=YIooqi8xdMbMBp+DhLv69k1ssMje1WAg6594dwOGAnqA9SMAJxNV1LS1
   iTaxngcvAw8c+1So5/069abE/Mall51Xhsa8OGADeCHGqLLlHypZU5IC6
   ZFgBw8nyTauh40ec0dm5KhVQ4B3vh2Lv9jaXMgYftUSKWXZ/rKZykNRuT
   Wk//6NsxAMefZRGt8hozb29WjDzZpcYj8zRavS+RBHGdU3YufT06gUMYF
   6ZzIuMV9mQoMO+HTIAkH7mP4PyrVFtYklDehhB8xwAKw6ICw6GHnyYqN2
   bUPUePZlDwlbBUwGGoVi0usEeEs9NXnoE3GTqfrznE9PuLUhvPjcnBmr4
   g==;
X-CSE-ConnectionGUID: 45Pvy+UrS4ma/aM9zj/oMQ==
X-CSE-MsgGUID: HCmNoKpNTGubkVbnl98PgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="78172471"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="78172471"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 22:56:03 -0700
X-CSE-ConnectionGUID: O6mGvDq0Qvu/3FuzVcULPA==
X-CSE-MsgGUID: Zgq5LjMySQq8Tvb4F1MeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="160269438"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 22:56:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 22:56:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 22:56:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 22:56:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhs6S4ZRihl9dhtiDTH67OWGdXOCoVwsrLNmpsswbUIWcrZiDgzlodFrCsPiKROcSAMzFnY8JvRigcHgSz3/n9Ik+DZDz3apdpgptPkyfqSPMWxlhBRtypIkRjEAveV6NpU4VQLoJ070vgMEXfjCpV+1PboLxTTnJa2XU7HSRHzDjZoOW++4dPpugOW/6lOvhhbexWc8NSebm5yaI5WknAcnuKSLiu8Mz0DeQ715sCEolOq/to8ADEV6syZ4zuuo3vRAk7WDZ+ZNlSMI3EqV4CRjKd16UtjLC2i+t6BewvcSmzOIsQXELhoICaxMB5njhH4S6ahm5J+hnSw86HgHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPJa1X1VBsMLsfxwIUOg7tU9rpxj0Av5P1MrcPaKLIE=;
 b=bQLRL2aTj0UTOAihzMGJCe3KnSmyn8qCnPsgVjKAa693aO3UREpWp5gupkwKT28yYUXjV+/Aqh8n+ftPPDtaxj2vpX1mcwIFMrUJaEBOlgPuh2YwOzsOesD/p8GuRfaxR3TsWkjjOYPAllJW8nMC6PtBlvUBSuUL8lkWQZx+bsd8VGgEzRMiSl1FbcAv2aM18GUSJuQPJL6MkHd0uNSLIE5/LtJawhU/qp9eoa+PpPdWZ07zBHlvArAuB+gfn3Yn4d5gDQZhD2A8adlGGk3gliR4hAtvZEmdxuHsU4i3EpUqkMuzpQDgkc7qm1jMRjO/jE5djTn7/z+pyIMCDS/usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ2PR11MB7617.namprd11.prod.outlook.com (2603:10b6:a03:4cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 24 Jul
 2025 05:56:00 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 05:56:00 +0000
Date: Wed, 23 Jul 2025 22:57:46 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>
CC: Francois Dugast <francois.dugast@intel.com>, <airlied@gmail.com>,
	<akpm@linux-foundation.org>, <apopple@nvidia.com>, <baohua@kernel.org>,
	<baolin.wang@linux.alibaba.com>, <dakr@kernel.org>, <david@redhat.com>,
	<donettom@linux.ibm.com>, <jane.chu@oracle.com>, <jglisse@redhat.com>,
	<kherbst@redhat.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lyude@redhat.com>, <peterx@redhat.com>, <ryan.roberts@arm.com>,
	<shuah@kernel.org>, <simona@ffwll.ch>, <wangkefeng.wang@huawei.com>,
	<willy@infradead.org>, <ziy@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
	<jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] mm/hmm: Do not fault in device private pages owned by
 the caller
Message-ID: <aIHLWnjzKWma1NLC@lstrano-desk.jf.intel.com>
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
 <20250722193445.1588348-1-francois.dugast@intel.com>
 <023ab16d-f3af-487e-a7ce-929bf7b2fe3e@nvidia.com>
 <aIG+gqY2YRqBeKlh@lstrano-desk.jf.intel.com>
 <dad71615-0eba-4a8d-abfc-979fb815511c@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dad71615-0eba-4a8d-abfc-979fb815511c@redhat.com>
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ2PR11MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 145ad32e-a4a1-4c26-bda9-08ddca76c3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWZPWDNqU1FEcnAzZk9UNmhrOTJ0MGZsWlRkWXg0TU1qb3pXVHlkWlBVQnZD?=
 =?utf-8?B?MVVaRW9IZUdkOG9kbCsyQUo1N3RKTEJ0a1lESGo2L2FxbVJzK3VOR0NsYVVx?=
 =?utf-8?B?UDh0WGdiTERjNWtsVVVqa093SGJyMFdSaU4yVjJWOXRDUWhFdFdnNFpJMTI1?=
 =?utf-8?B?Zno3d29KS3VRK2loWUp1ajRiNUhNdEhNZVFxNm5IMDg5QmZMR2MvYkhlNjFp?=
 =?utf-8?B?L1M5R0dya3V6aWYzQytBd0MyREs1WXFZcTB0THFoY2lDMmFZZ0c2Rm5MWDM1?=
 =?utf-8?B?a25XVFpGUDNZYjBtUVArZzNBRU95OTUvdjE5VVlPNldEVHhZMnRXUGloMUt2?=
 =?utf-8?B?d01hUlZiY2lWaTd0VE1uNERacVloeWZtT29qaVRpRll1VlpJZHAybXpwa0sv?=
 =?utf-8?B?WmNJWTRxSytuNDJuVkNHelFValN2V2xwc1djUFNDODJPdG5uMnowdXpMbkRJ?=
 =?utf-8?B?T3pxZWw4MTZhc2R1VlV4c21WUWFLUVQvVEw5V2ZKQ0xTTnZXYTMrbzBRMVFk?=
 =?utf-8?B?TUJZVGttVDU5MkpPakpjeDJRRlBSYUJGK2xzY2JMVldjand5K1p2SGMvVW43?=
 =?utf-8?B?cFlVTmY5NUNhM2dXWTU0TnhzcFVOUUNHNGpJSTUvTFNPdHJYY0RQejdvS21o?=
 =?utf-8?B?UzJibTB2YlJ5WWVCU1NIUG4vZGVjRGFGOCtaMVpCSk9HMml5Y212c1hiZUV5?=
 =?utf-8?B?YmFiaS9qK2x5cWorYS9ZL3E0cTMzcWRpSFRZQ01YQ29wcnkvRmRxYXlpdEZL?=
 =?utf-8?B?c3NrY21lTDE4NXRQK3M5NlZSSEVoT0prMFZ3UlN1eTBXMlA0YzlkcWZVZEoy?=
 =?utf-8?B?VWxIdnFJaERsY2JkTW94eWxySVZOdWFmSFhRNC8vTmNxV0JhR0w2aXhCSnJo?=
 =?utf-8?B?aWlEVWxGVndLZlk2QldsQjZMT0pTckdFRVdySG9CNCtScWhuL1MyRkl0VXpn?=
 =?utf-8?B?NitWMmlDOUM1cjFGRWpBR3hVSUI0eTRwUFhLK0V1TmxCUDlKLzBvZ2I4WUdp?=
 =?utf-8?B?eUI0RmpBNlZwZE01dlRoUFlzTmwwVmFYS0h6SUpxU2MzTDBnZkMzb2NiTllq?=
 =?utf-8?B?RHVkbFBSK0dRbXR5S2M2NDBQVGowNWNlZDNGazcxOStiNW1VRFhDa2RQY3NP?=
 =?utf-8?B?VmVKbEpSUlV6RThOQ1F0WVlBN1c4SWRuano0RGE4K2JOVkJnNWJKb2Z2NjZT?=
 =?utf-8?B?SmRjZDBJQTg4RmtRZnZYc2gwTEZMS1RMU2tVU2w0TmtXdDhDSUYvaGQ2YTFy?=
 =?utf-8?B?YjFHRnp3d2Zvd0d0UjNuQTQwcGJtMGtNZjFRRndsRWFYZTd5NDZyZFVJRm5r?=
 =?utf-8?B?d1hmN0JCMXZ3TzBBbDNua3JUZ0lxTG5MaW9hdlRNMzNTZVc2eWp2aUQzSEt0?=
 =?utf-8?B?M1FOYVhza3FDaHZRUEQ5Njh3UmdTZXNtN1oxaFZHTE5MT20rV0tHd2lXOXE2?=
 =?utf-8?B?bzl2bWN4Uzg2R0lhR1paMUp3T1BzdkRFV2NjZU9iRFJQaklsajBIOHVXeE9N?=
 =?utf-8?B?R3ZTazYvcEtyVGtBRk9VTytoSGpaTnZDWG5VRThDVkhjc0Exc0tCdkpzVXNx?=
 =?utf-8?B?T25zU1hSUk9IaDh1cGFsQlVkU2Q4dHZ1dzM3MndZSS9VV3B4bm1taEoxVWFW?=
 =?utf-8?B?Y05aUlhaMkY5VTRMOVpEZUViQXcvRDdCSURacDZWdEMyY1pybkpFRkVWa3dm?=
 =?utf-8?B?N0V2c1k5YXVsVWJUMjN6UEdsalRxbWFIcFFQOFRqY3YxRUp2dmYwbFdKajFD?=
 =?utf-8?B?ZkxtK2YvaGNVM3hva2htSXU5ZElXb3h6dU5tSWs3VXdhVmZpSHl6NkI2eHJM?=
 =?utf-8?B?Vmw0cEc2WkpCRW0razdHZmhqUVFRdm1LdGpaRE84NXJUZC9MWVlYczQ0VVNj?=
 =?utf-8?B?Nk9xdzRCNXBkb0ZMQklEd3pLb0o3Vkl1cnM4bXBHMmd2UEo0K3FDRXh5aVIw?=
 =?utf-8?Q?RVq7ByUVwAA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFg3Rk5XaUNmeHA3czVvbUgrN1p4cHk4N3hpdWNoRmZxR0Rtdk40dHhROW1L?=
 =?utf-8?B?YUhjN3p6ZHRRbVh4dmRLcVdRSnZpU3A0WU1BSWxGR1BUTldGQ1ZyZUpQQS9t?=
 =?utf-8?B?V1VxM1dYQVNnMHUyRFhXZEd4dWR3NWE2ZlBzVmNZTHNjeWhPZW8yVTNrMjB6?=
 =?utf-8?B?M0FtVUc5bzZFbVJBZ1c1Wk5uYTJOWDlva0pucGw3RlhZdFlrUHBib0pkTEN3?=
 =?utf-8?B?bjVFcCtYMVpocXlrQU5LTC9ybEZBSzB0MEVPanQySUdBbzMrTmtIUisyRWlm?=
 =?utf-8?B?cTExaXMrRGRYZWNIR09ZYW85SGU2NkpLUXRCOGF5dFBFWnA1MUxIZnd3NCtM?=
 =?utf-8?B?L3BvTUFuZEdTT3VWZGtadHNwYXlhVDl5bWYxMFgrQ0V1TytNT3BkZDBVWXpS?=
 =?utf-8?B?VHd6c1ZTVjVrRnBZKzhKSmgzbEY4VWQxT1lsaWJjUnBZc0JqNDNQWmpQbWk4?=
 =?utf-8?B?ZzBBZmgya0RKVEo3UVI4UmRaWnpGT013MGVFeG9RRkZSc3YxUHFqZW5Wbmlh?=
 =?utf-8?B?TGtlYnQ3SXV1TnlwcUpldTloQzl4L3NEVjBOVFFKNnFPaktuUkhmZUxyaC85?=
 =?utf-8?B?WmZtUllRNlRib0hiMC9JVGI0bTlNYS8yTXRyVzlPR0Y4REgzUzFycGphcDZp?=
 =?utf-8?B?SGlBR3ErYTNzeVFFZGk0azhVOHU4U000cFQ2NnljZG5TeVRnSXcwTU1ZU0NL?=
 =?utf-8?B?VFR3VW5GekRoREwrb1VLMG90aFhFOTdQdVBpdkMvZVVqUFJ5bStEZEpJdEVJ?=
 =?utf-8?B?TlRiTHREemFTbVVPaEk2c2s1QWVPcW1tdGozOXpwVmxrOUdac0JzQ0xrRWk1?=
 =?utf-8?B?L2hkL2gvUUtYNzYrUTJOOW9Pd2dWd1VoUnRMQWRqRmMvNGs5dTE3cmVPL3BO?=
 =?utf-8?B?K2xYUWg5R081c3FvK1lHcWVkTG9uOXBEVFRvZ1hSU3cxTW9SOG5EcDNiMFJy?=
 =?utf-8?B?RHA0dVMrZzRxcVJVd3NtblA2cXJsazhIZFVsczdSaWNlckZjeVJVSDlYTXNu?=
 =?utf-8?B?WGhzNWlYcjFUMERsSldOZU53M0dROW5SM2tjNit6bW9OWTc3QTdiRFRYRFNW?=
 =?utf-8?B?U0M5bXlNSWRlRU91V2h6ZUk4RWRyTXV0TytxakJNVXZKMTZwWEZVNmN1RzJH?=
 =?utf-8?B?MDc3UkhONEh4R1VFM0p6bDlsb3ZYQTN0N1hrZitwbkRVOEorVEhNUXl3NDdM?=
 =?utf-8?B?MzdJNUxqT0hDeGNQZkxhbEFXM2ZMQlNSMHhvTEQyL2RzVmpNMGpac0E5bmwy?=
 =?utf-8?B?RlBGZy81Z2pRejNINjlIZ0VCZ2xwRnNtdXN3S0hxdWlNYytINUgva1I1UGJk?=
 =?utf-8?B?TlQ3MmlyMU41R3ZzVnMvQ2JhZHptRUFHaVptK0paaHZDRm1uMmRPeC9jcXN6?=
 =?utf-8?B?U3lJL044VTBaWFQ1THBkSUd0TWd0Zkxwb0huMm8zV2JKOU0zM0l6b212THhN?=
 =?utf-8?B?b0g1NE1JaWFCWEFqZVhTc0RxaFdWa1ZicXFpbjAxWktWY1hETFdSbmM4NURt?=
 =?utf-8?B?S0UremxZY005Y20wMUljTll0WWd4UFJpSUpRTXUxRVRzNmFOZVZERUoyYVh2?=
 =?utf-8?B?OWV4YTBEMExnNUxVZ055b2R6cks0Y21ISTdXSFRpUWgzdExLNFNZY3dzNkpq?=
 =?utf-8?B?MEpFbmJuR3huNVNiSlBKbGM4Kzl3c1FoY3ZPdmtSREFLY1JxTVJZZ1ovRnM0?=
 =?utf-8?B?TzJiNExwM3pNNUlSdDFVaGRuR01CS3piVFBUcXp4Zm1YZy9EKzlOZkpPbXQx?=
 =?utf-8?B?K3k0N0hzd0kwWkJpN21BT3Bpd2szbERGR0VKSmFCTlJaOXBqbmdncFJZWWFS?=
 =?utf-8?B?RzhHMUdBd3p3VFdKSjlsOGZIRm9Ya0d2d2JQMDdjLzMxTlBaSjJ3QzEyZ1dE?=
 =?utf-8?B?SzF4UWl0OUJWOHJpSFo4RzkvU3VNYmYrYjczZjRoOCtQL1VjNG40SkdxL3gw?=
 =?utf-8?B?SExxYmk4OUV1MlBCam5PM3hNWmgzdjJvRjh5TDBjek9GSVZGbzhQRXlhc0px?=
 =?utf-8?B?NytuWWY4ZzJNRTg3cUxrM25TbGd3OHFXSUltK2FCdzhnZ3RnMFI2b2xZVnFz?=
 =?utf-8?B?ampRWnhiMU92M2VqdjJmdThwUkI2RHJTOG1lOHUvVGcyM3g1RzkyK2JTS0V0?=
 =?utf-8?B?aDZOTWxDblpLVlhROTB3ZUJoeDRBalpVOUhyNUgva0E0NU0xNm00dkora1VB?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ad32e-a4a1-4c26-bda9-08ddca76c3d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 05:55:59.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EGYEh6nzUdno2kIVqznCp9urTBSiWVMvVgHbW7ZjJS0B3gNRPFqiovx+xi6KUgPiRsq71cH/XfIYHgZN5PbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7617
X-OriginatorOrg: intel.com

On Thu, Jul 24, 2025 at 08:46:11AM +0300, Mika Penttilä wrote:
> 
> On 7/24/25 08:02, Matthew Brost wrote:
> > On Thu, Jul 24, 2025 at 10:25:11AM +1000, Balbir Singh wrote:
> >> On 7/23/25 05:34, Francois Dugast wrote:
> >>> When the PMD swap entry is device private and owned by the caller,
> >>> skip the range faulting and instead just set the correct HMM PFNs.
> >>> This is similar to the logic for PTEs in hmm_vma_handle_pte().
> >>>
> >>> For now, each hmm_pfns[i] entry is populated as it is currently done
> >>> in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
> >>> optimization could be to make use of the order and skip populating
> >>> subsequent PFNs.
> >> I think we should test and remove these now
> >>
> > +Jason, Leon – perhaps either of you can provide insight into why
> > hmm_vma_handle_pmd fully populates the HMM PFNs when a higher-order page
> > is found.
> >
> > If we can be assured that changing this won’t break other parts of the
> > kernel, I agree it should be removed. A snippet of documentation should
> > also be added indicating that when higher-order PFNs are found,
> > subsequent PFNs within the range will remain unpopulated. I can verify
> > that GPU SVM works just fine without these PFNs being populated.
> 
> afaics the device can consume the range as smaller pages also, and some
> hmm users depend on that.
> 

Sure, but I think that should be fixed in the device code. If a
large-order PFN is found, the subsequent PFNs can clearly be inferred.
It's a micro-optimization here, but devices or callers capable of
handling this properly shouldn't force a hacky, less optimal behavior on
core code. If anything relies on the current behavior, we should fix it
and ensure correctness.

Matt

> 
> > Matt
> 
> 
> --Mika
> 
> 
> >
> >>> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> >>> ---
> >>>  mm/hmm.c | 25 +++++++++++++++++++++++++
> >>>  1 file changed, 25 insertions(+)
> >>>
> >>> diff --git a/mm/hmm.c b/mm/hmm.c
> >>> index f2415b4b2cdd..63ec1b18a656 100644
> >>> --- a/mm/hmm.c
> >>> +++ b/mm/hmm.c
> >>> @@ -355,6 +355,31 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >>>  	}
> >>>  
> >>>  	if (!pmd_present(pmd)) {
> >>> +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> >>> +
> >>> +		/*
> >>> +		 * Don't fault in device private pages owned by the caller,
> >>> +		 * just report the PFNs.
> >>> +		 */
> >>> +		if (is_device_private_entry(entry) &&
> >>> +		    pfn_swap_entry_folio(entry)->pgmap->owner ==
> >>> +		    range->dev_private_owner) {
> >>> +			unsigned long cpu_flags = HMM_PFN_VALID |
> >>> +				hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
> >>> +			unsigned long pfn = swp_offset_pfn(entry);
> >>> +			unsigned long i;
> >>> +
> >>> +			if (is_writable_device_private_entry(entry))
> >>> +				cpu_flags |= HMM_PFN_WRITE;
> >>> +
> >>> +			for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> >>> +				hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> >>> +				hmm_pfns[i] |= pfn | cpu_flags;
> >>> +			}
> >>> +
> >> As discussed, can we remove these.
> >>
> >>> +			return 0;
> >>> +		}
> >> All of this be under CONFIG_ARCH_ENABLE_THP_MIGRATION
> >>
> >>> +
> >>>  		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
> >>>  			return -EFAULT;
> >>>  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
> >>
> >>
> >> Balbir Singh
> 

