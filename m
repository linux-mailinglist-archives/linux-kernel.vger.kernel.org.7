Return-Path: <linux-kernel+bounces-771365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52096B2861C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3563B566D09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D2306D2B;
	Fri, 15 Aug 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfofBvPv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CC23A989
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755284372; cv=fail; b=TDkF7xej7ESVMhOPsk+yd2UJvSl3MVGLdoNZUNucrpxKVRJx9t5fluD7BqjirzwFi0bCx3j8iQoU7ELldVg+esTrmoQjCvPGaWdzbHqbN+VEWHMkAUoLX7yaFzBQQ8M6xzQnGbvcA9xoXASYr2oa8zUu7MFty/VvSFT4hseJ4ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755284372; c=relaxed/simple;
	bh=l9/wZAjNLQmP4Piui3wr0mLusSkpQz80EcNd8o2Q8hU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gynvo/ST5uBrWVpoCNCf7I7nKk6yWQ1HMrvsUY9QQiNkkFl9lZqALXunwv7zoFGfpBaSBmLq1wSKXLOzqf8QVQNKzLHa/qw/EEC4wOVFX5XOdUGGPcNyOYHz5Lh7Ovw+DrrHoWuYrAwxQYd8epiFwa+aAZKJHi93Va9lgvta0Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfofBvPv; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755284371; x=1786820371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l9/wZAjNLQmP4Piui3wr0mLusSkpQz80EcNd8o2Q8hU=;
  b=gfofBvPv4+ch2OccId4jpG5KzYuss6YMq1AJFRB1fAMf0bnyCg7lOV71
   w7QsVupXUxjVxX4Prk2b47cDdVHsifk9ln5J98k3CANMhIhfimD5ty/g6
   gD4GNAH1I3zQa3EI7GpVXryrjBxN4cxBTzvl4vKdKssCEPVvmEhh8WGoI
   WuCLZvS3HUyCNdzHgWWCgp3Z0P6uCE0v4KUvJr1t5WkzZLjdMDAkq8vOy
   PXugNfo25XsonMHISTu/zckosc33wu0qi9Hm5N/Wo9E9hE4NXQVldZ5Cz
   nC1C60ddk3EVOtCEy0vrFtUn/uyFsmMfgG9rmoNjMNdOVlpVLGd5gG7ut
   g==;
X-CSE-ConnectionGUID: 0nb4eHh2RnawmSddoFWtYQ==
X-CSE-MsgGUID: d+9DYJUQRxKwT6hQeptXGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68979175"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68979175"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 11:59:24 -0700
X-CSE-ConnectionGUID: UfVJDsafT0+wcl2dNULcoA==
X-CSE-MsgGUID: eUzHs+bOTaGZRIPJd5n9Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167424543"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 11:59:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 11:59:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 11:59:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.81)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 11:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKkrbL8nLvrGrCPhSUphh4OUxguM+oDkEyZIR9eS5vFvN8sjpEe/F3OHHA6HrBhCwfb8X3WHXkAgSh5jNkKtL8lA/affEtW86dCj03exA38BPqCQP5DpXjTXG9qhoTvPD6XljTpaU+PBVVUAdx51yHcF/ZTvGhOfkwB+uss6O3evKN0skuxkfr36oLPfIjgX/sVCk3ZVvLqDC4sW3/9ceDfao7DjjITbsLQRFActYxtD2DLi7yVXOckoCHvZKxzCJm482clDHPg8JE69OKxRkdX0LZJt5aNb3L2CsSnN7Nrcdw9tLsW5OwT7hLvkjxpLKb5RG8GdVvEXv+DwyuHsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jylgpdXMvSPz4XvcL0a3OBnxmnvQ0+X+I0lu45mAa3Y=;
 b=rpJwxd0wF5qi3yubs7IbeNK8rBkFIVqT3mEtRwjXFYCASzZbrFw/HLbFenAYRPbJ1Brao99Ne2ujAPUtglYGM8ZqZG4ITL9pqKFagHioZ61leBuPJ1wsIweoBZ94LXJZCD5kp3WBSlXiHX38hHXomHv59LJ1wBujECvXr5uSRAzfKoHn2mgT97Nu8OIAVANl6gRLqE8v8cufq+R2vn6BwpuELtu9dFBpfZnRYcqlIkgukPScHisQcNEdPY0dFwSE6qP4+vk8K/wVGm4ItbGam59lpYXvnPwMddju9lDfuX4SXE1fcAwCVKXrIPhxDtJ8Qo2SGDInGr1FCas/z825TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPF195D11F0C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 18:59:14 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Fri, 15 Aug 2025
 18:59:14 +0000
Date: Fri, 15 Aug 2025 11:59:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
CC: <saeedm@nvidia.com>, <itayavr@nvidia.com>, <dave.jiang@intel.com>,
	<jgg@ziepe.ca>, <Jonathan.Cameron@huawei.com>,
	<linux-kernel@vger.kernel.org>, <akhileshpatilvnit@gmail.com>,
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Message-ID: <aJ-DebbVy8-9cEt0@aschofie-mobl2.lan>
References: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
X-ClientProxiedBy: SJ0PR05CA0175.namprd05.prod.outlook.com
 (2603:10b6:a03:339::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPF195D11F0C:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2b4017-83eb-45e6-9d24-08dddc2dd3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEf3phSrKdjoD/Sp7TV5msp9ozE2px9vkwi1ILq/Z/eTIhP1nWDE+8HRx7qD?=
 =?us-ascii?Q?8KJK0TeUASfYLogcElVnO2LqKPb/j83U/9wGPfMnjT7bkQCBNG9LNRMVDzY2?=
 =?us-ascii?Q?C0YO7VAhk94EzmNPCDFj9FhHhvm23uDTlbkik3gvHfmEp4H0/pYS52NBCauw?=
 =?us-ascii?Q?1uihfeJ2WSmLAQW9hn1gUro7TkEiZ9I6caA7jl/tkAzgbCgRLl+xeYao9lSl?=
 =?us-ascii?Q?L8SF8Ov+wsgVYh/qgbpZ237MJrCR+QCoN7m9p05X9Pqe1UUO2redVFfFj6bP?=
 =?us-ascii?Q?ULAOiKLlgMWRVFK5joVQKbTGMvti0b4k5q3YpZAEz7qr9ejDNqIumXngilpz?=
 =?us-ascii?Q?mCOrzaR0QdiLdJq7dq+CQvPvOOHhhPUiK/RHUo5vAa+0JoqbsXBbKPx0xM/h?=
 =?us-ascii?Q?+rgM5p1OHEIVC6b0GvKrOAPqazwld69HgjH9m5b9MX9+5e+exzmTgRcha95i?=
 =?us-ascii?Q?QZWgunhvpfW+EipdyJP+8tp5NzO6q9HhefxAnqljUYu0XbjBZ0McDsyhKZx/?=
 =?us-ascii?Q?GjnA2hXz1faim0qZL74Pl9/mhFkjDv86oRA81Q5ALDJ1M1PTiLR8m+LG9WFb?=
 =?us-ascii?Q?Tj3GilCyP47/PxF70Yy6J1S+TNj8Tzk5vGGJ96xBaP40gzEl6HNOPow5rkBk?=
 =?us-ascii?Q?6icrwswY79o0Gu8+HswN9/ZNqxk0nSFRe1qtAtXI2XV1NUSRb/n8qdKNnXIZ?=
 =?us-ascii?Q?3ozeyGgAV2btXkQeECDHs+foHXOgpzbkMs6chFj6goN14nDgu1bl27U6gnSk?=
 =?us-ascii?Q?8sW3LT3jjmTN1FQSxhH+AMBaI8l2OByo0ZGH1MxX076846M3t+nuRkABhqDi?=
 =?us-ascii?Q?k7AJrW0GfYYH+NM4ln2sJ27Rz3Gx2FRcXWs0RE2im9AGJDdMsRVdEi8am1+U?=
 =?us-ascii?Q?dm+ooCkDzMCtsxT7iFY+la9FERY4Vf99IWvAoCBRWBEvwgEFhdB7PgqsmnuX?=
 =?us-ascii?Q?Uj/wPAznqobn86ptMuiupbqpWlUiiZJyLyHzVmnMoUsILWKwVObB86aa49Eg?=
 =?us-ascii?Q?KPwebykrVmGmkuTCiuSzW2aXKD+WYBF8wC5ZL0bMbZd/Xdidg9bRRzGMEgBk?=
 =?us-ascii?Q?K7XnLt8Bfc+7atA33DhqBAs6BycbYRLly604kwR9YLqmruMJRd/NsYt5+6kf?=
 =?us-ascii?Q?ju2QW7PV+ab5YNXCpuA6TSgNLVNEQ2dEmd6e17EKuDPaZy33PeZO64GhZIB5?=
 =?us-ascii?Q?36VCOgcy6AYkuA5vbbrMYBYxe1g5yYTD6HeQJMdxxrBw7WNAGHVnaRuyOJJl?=
 =?us-ascii?Q?8zjiwxeK6mmwsX1AtYwLbxWd/hKvL7XR+vEL31POZ9/IT0IT4Ly+WA5t5L0z?=
 =?us-ascii?Q?oL05ARSVuaXHV80/SYdfiWQ3ZD2y1Ezk5lTBTLOF3/EU5NCmYm2Fg8FmABw7?=
 =?us-ascii?Q?PYFfhZbSbQ9Exnr2B/epexCtuZaBr25oiWbWS+BplIaiOXx02WESQVDugPU5?=
 =?us-ascii?Q?CIWkhnelCwc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBSAz/vWCIvmSWwwMk+q3bIQZPUWccBfBe9YmEIndLqrQIXwqqG+ApCyWeJJ?=
 =?us-ascii?Q?BGVSAs1BN2SaylCsU1Lw3kGyaOqSNfBp1V+kf/7+zq3VFiP82wkM1E8Jp73i?=
 =?us-ascii?Q?Kr4Djc/ZB+KbQ+dLAockCGUjhy8VbWdYJOqTIZ6pWF60p8xz19ykz2YkCMLE?=
 =?us-ascii?Q?XfvH8XYh7etfa5o4bU/8GpIGcKYhOXFJgfMTlD5R18KSaOsGcCoSRKQ1ivjJ?=
 =?us-ascii?Q?+RbZJpNsoW/e3m98Xa+1cKyMHnGm32AOjCDUjEKwskyvyj3dMhg/M7LjFbkY?=
 =?us-ascii?Q?CFUPuRDf/7WAQTUK7vtP2hCrZdXw7dkp2uiecsMhXqn8N1Kg++AbzIZqCEI3?=
 =?us-ascii?Q?5qWgOfWfDrT0Itu+YXhd+NOuru2UiXDa1aNlIXI+wjdcS8NyLbyAIUzMvs+G?=
 =?us-ascii?Q?o2WUR884/eYftVBh/arXoHhsb1KUuuLs1VKHBzMwB4FVne1m61a/jDWLGTja?=
 =?us-ascii?Q?KhVn6tBMp2CUhg6wQbAWjy3m+5XX1qBk0GchPtxIdi3Fwm8qp8XSOLko5QGz?=
 =?us-ascii?Q?zZp6BSkmCaPw+RTputqkMC9BVx21J/TIhbavTKnhqbZQCNb9OT/jL41HinJX?=
 =?us-ascii?Q?aWY9mzokrBjPjyBRKRP4jbBTjYCHPJ8Mq8FiyU5k5GS7qEFu6VO8OtwoDa2j?=
 =?us-ascii?Q?iPzv8ApA0IzrSENmGSIfAk05zdp+RoSxibC46QZwIVa6zSvUlMhiBkpp+MTN?=
 =?us-ascii?Q?wgaLd4IWosYkBboBYQMc9FJ41S6sg/xFTcR03MSQwwPI6A089bxoRDbdBGEc?=
 =?us-ascii?Q?jqmecEiU6U714H9uyoCJWP6pKRhq70pL6WtVtUqUAseRiuQ1RCa4YsujHRTO?=
 =?us-ascii?Q?f6i2OMpcaF3kcZAXXCmf9hoC/PGpWxcqUEKE56EC6eAze9dRWCUm41i/dGFx?=
 =?us-ascii?Q?QTeROdAO0Dtix3Krz+LEediN6sYPnwi2C3fWhaHIlsDdw4dpvzjdeF36KGnd?=
 =?us-ascii?Q?ZgliWWjjQhsKFvT2JhlcELkgumJSkNPz5m++imCuJUUmBzYq/3uwAA68Ixyg?=
 =?us-ascii?Q?F3GkE0F3jJdr81cwrvmPfyzdA79bHBr55vPR2PfrcL6qu36G6FDkGs63M0pV?=
 =?us-ascii?Q?R9XQV1sg5FzQkLu7d8lHb7dOAoSf67xB853oWYRKrAx8zY/QbdBwWHVAM9Xg?=
 =?us-ascii?Q?lTM3fUewPJn8UlsOxSnxoCDwRo0SQ+xZ3jUMpxVgZ659Enoen4IHVUjW4Svk?=
 =?us-ascii?Q?hyc4l+BumY7ZVyRzjdQQpweTwifqyq9Lc7eEsSvR39InWYHUSP6Ho/RASeHQ?=
 =?us-ascii?Q?FyM9XAfaU2lrBzw4A4KDtRTuYLuvxCV/7Q0lOVhHqg+BpdoG4gUgw2Q6RXMf?=
 =?us-ascii?Q?jKqAKQLnJrPuohdncL3y+y/mYXRSjO/1S9ypVl80shdOPn6mDIhOtOtqqPJ3?=
 =?us-ascii?Q?5H1069pOCHBonPZRgJ62pVLTfj+pa5dU7BMlU/5U16ZChK3HHRZv86E7h4KH?=
 =?us-ascii?Q?oMwH1i5dl7ABWmMe5EUSRr44lAjFhX1n/2YSleJskMCCeRi8LTdajKO55O8R?=
 =?us-ascii?Q?JDEM9QUnCPBpWHURnxO/l8F2zZ+9cgT0fTVYvZ7qCdrW+s9jPG6bxPTjnQZR?=
 =?us-ascii?Q?qFOLunsVKu7gNsUBIjREQsPIet3l9UP73JGtmfkEWla4QOy+5VjBIzj2NqTZ?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b4017-83eb-45e6-9d24-08dddc2dd3eb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 18:59:14.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJQ/MyaVAwkZWIw6UOavBFpnAtedQV6Ds1royM351//SmSsyv+QQAP245L/NqEeCD72utEtOnNVqRhfxkYHlYm037I+YSm1/CAAaftKgg3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF195D11F0C
X-OriginatorOrg: intel.com

On Sun, Aug 10, 2025 at 11:47:42PM +0530, Akhilesh Patil wrote:
> Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
> Avoid potential memory management issue by matching alloc/free routines.
> 
> Fixes: 52929c2142041 ("fwctl/mlx5: Support for communicating with mlx5 fw")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Hi Akhilesh,

How about making the commit message more specific about why this
patch is critical even when no immediate symptoms are observed. Based
on the current description, a developer might think "this works fine
in my testing, so it's not urgent."

This type bug is particularly dangerous because it can pass code review
and testing, then cause mysterious production failures that are extremely
difficult to trace back to the root cause.

If this sounds like I'm going overboard on an obvious fix, I am doing
so intentionally. I am encouraging you, as a new contributor, to show
that you looked into how kvzalloc() works. I believe it can use either
kmalloc() or vmalloc(). You don't need to be a memory alloc expert to
submit this fix, but demonstrate that you looked beyond a report in a
static analysis tool. Also, that's where the interesting learnings
appear.

Similar to what Markus mentioned, a simple message stating how this
was found is useful too.

--Alison


> ---
>  drivers/fwctl/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
> index f93aa0cecdb9..4b379f695eb7 100644
> --- a/drivers/fwctl/mlx5/main.c
> +++ b/drivers/fwctl/mlx5/main.c
> @@ -345,7 +345,7 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  	 */
>  	if (ret && ret != -EREMOTEIO) {
>  		if (rpc_out != rpc_in)
> -			kfree(rpc_out);
> +			kvfree(rpc_out);
>  		return ERR_PTR(ret);
>  	}
>  	return rpc_out;
> -- 
> 2.34.1
> 

