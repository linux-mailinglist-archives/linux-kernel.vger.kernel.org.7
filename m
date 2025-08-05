Return-Path: <linux-kernel+bounces-756985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E5B1BBCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8961851F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D819258E;
	Tue,  5 Aug 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5BuTZoW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F4524F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429677; cv=fail; b=fhc1y1tFB1b/6CmlfxvJ//0dW0lpgIRkYTIqTJswI8TQjbHGDfCO40CSBksYQIboRDwecFiPkRaNuhQIQ3jpL8PTrc4ky5pvnxc+yGLriVAniTTPQ4uIQgBS+cD1daM6xAE3iEM+tAcAD1ZHUb4vpz6AePJ+EzRie6EG5Sl94GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429677; c=relaxed/simple;
	bh=fPIkVNDfnOSiBgHcR0NTmUtDW7TA6BbnFqZpYJV2e/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e5yf4WFoxQHvE9XYI9iZCqD4EGD+s9JEnBO7j8OrZIkZSmlt0m51FaE/4K8MaS9jgRm8pHRJk5lGo9wP84l9nd/xVzMz4cnLcvBZtxk8GiCMO8i+qFNPJEvdftUnb0i1Uu7YRnMs7Twts4LSpJi6VVWyB9flasE0hiStBphcXho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5BuTZoW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754429675; x=1785965675;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fPIkVNDfnOSiBgHcR0NTmUtDW7TA6BbnFqZpYJV2e/s=;
  b=Q5BuTZoWZIOQKHXWCIoWpVZGTjct26AZxpppLkmV8vw7GMJZr2F9Wk3h
   FPwk/Xjbrkd3Dr9/kMmb6p9Xhw5t5qGTijn0pZr6q1WMPFNX7gQSWh3Jw
   7YyBsZW9dpilvtBptRjeJwoqQx6GRBmUsQDnEfMQVn6VIGDsJ9n0ZhGF/
   gsT5Q4Qqo/hn8zMsTCJak2CNLBvMQv4JzDCer6FQrogR4wv1RxG+ZLaKT
   H5CZ2/BlUzYWpxCF90GpQftxSB40t1GVV5/ZdctJTuW5kGpGoou3d3g8B
   gW8QDABNJoBCQONGz/EhxMTg+l3nJgPdcolJ7pO3PYThX0+tnV3j+OnGN
   g==;
X-CSE-ConnectionGUID: 524Vnk0dRNSMfDmwt/FUxQ==
X-CSE-MsgGUID: yZqnmioJSuiK5VoEuGNK4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="44331971"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="44331971"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:34:33 -0700
X-CSE-ConnectionGUID: fVluEnjlSw6ZiHs/dckbDA==
X-CSE-MsgGUID: BdSbkmDSThqxmg4MegIe9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195433104"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:34:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 14:34:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 14:34:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.65)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 14:34:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4WSShtRRtU5WvAeSxLWDwVoszpByi9/fmMwictv3IaNZSi+gYalqr6ZoHlJb64q/X8yd+Inq19trgok0P85jzKgUfZo5+RiK9T4PCb/xtXBmaeguKd9boMvd5WaS7vHuw3n73ASlXd4v0FtoaWx9PW9eDVjuOs2Gw+DkVvIaRzzNGL/mVnBR4ocLQECf6IB5hw1Q8sE8d94qc7Ebg7I/saQoFpM5reQ/moofyBoxu+j4dGact8GrQqvlhY9lgU9+nyB6J2IvX2/Tjqkq0NHi8OO8ACohVcG5RBEmM0n5yjp65i6bt4MnqD9L5AO7nhSws5TVKP8y5UtHFv3I+rP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G08bhYqDX/+VeBc7fwTD1WkkFCrPDmGRd16+o5vxT+4=;
 b=UrjzyrSz8I+Ph7oINfKav0p1ROXBMgg0AAKqQ3RCmPTetFJckccrgx3ltjGInyhfyv+m3xZY9F6BtIjENwl5g2GtaxkSoFlweF8amz2zs6VxqsXbMmw/38n7nxf3Kf8hHrvWjnY6FFe3Jrn4XyKFlq/i+5PW4zyoXnF0vxFyFiWl0cJixJuolSQ2Y/FW7dqHx6x4mV4FkmahZ2cnOdKiRzo+Ov4wrzIA4iCF4d45UOQjPC48zaxsSps3RG5hMJvjjwwCwUuLKwT80E0dD3EoUngFNGvxangRZNjsPaHWwcdh0ba//YtY5mvcFEA/X15UjGJvh/a+aFSFodR472QPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 21:34:29 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 21:34:29 +0000
Date: Tue, 5 Aug 2025 14:34:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Karol Herbst
	<kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
	<dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, "Barry
 Song" <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Alistair Popple
	<apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>, Ralph Campbell
	<rcampbell@nvidia.com>, Mika =?iso-8859-1?Q?Penttil=E4?=
	<mpenttil@redhat.com>, Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v2 00/11] THP support for zone device page migration
Message-ID: <aJJ44cZZWqJVFLem@lstrano-desk.jf.intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730092139.3890844-1-balbirs@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ2PR11MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaa8c2d-78f1-43b4-c5ce-08ddd467dba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jIBNNexD0O9OY3Dn8pdi1XXKxErG1foYlDHeO2q0JKpoh1GlpO3rFKHomv?=
 =?iso-8859-1?Q?BBEWIMiV988qp5wqOEfb4cPzuVjcOHSShA1UEWyBqTPhej9C9IU2Sluhmj?=
 =?iso-8859-1?Q?8/itb/lM8zDt7CAHS1qXxfJidiUsrz+nrbSDgj/E/VeGpkCmPe976+vDWa?=
 =?iso-8859-1?Q?BmMIK+U3ojsY6XINt/7jjweYiEhmeBvrPYh7eWo3Q5V5SKAz+NAAL2zYMy?=
 =?iso-8859-1?Q?8VnXRkjoC0b6AjcbQNAMMNQkTtjTt4wwz0diTnGjr0lHTWpx9YKXIScWX1?=
 =?iso-8859-1?Q?nEe2Gd5d1Vby6GD8GLvT+HBwzHHQZV5gE3RCrmwKbOqQequJXwd2YRnb3k?=
 =?iso-8859-1?Q?8Oj0C/tK05sAWKjIBJdIwLp9BqCkBOCrmN78lOvSFVPqRQJe8Mm/NT5aGr?=
 =?iso-8859-1?Q?FBNXPOSpDvYqDVrRJcx3mNWIAWColwqF+Wp8b0NPGUAiHOChrMiJ3cwagJ?=
 =?iso-8859-1?Q?Z41KofjtmlFPmNHpVlWxTH2wh8SE7nGmKQO0ZDQOgYnz+8I6yRfqHGxl65?=
 =?iso-8859-1?Q?Bs0TwHR86nVFy85fMWp7MRiTtJf4Z/YnkGEy9KSLSWjeEMvIvoKO+vLCTp?=
 =?iso-8859-1?Q?echctWqGs01uxValpKKnnoI32SA5GRcqAyPaJ9vnq2e9EenJQorl+KlXR1?=
 =?iso-8859-1?Q?3J7uur8VZxw0OrzxAhizeBB3qKj1wd/9sLlfoEmt7JvjZvh90suut15MsW?=
 =?iso-8859-1?Q?ROGWQ9obX4oAUHfyzcDjPz5hdDVMfwk4yhUh4FOiKzkg62RyoV4Go6chkY?=
 =?iso-8859-1?Q?C/MFV6E60ZdAsYlEg9Ub0e6nPNJcFamaJmIlxbRZ5HQnXtBK2GrChBYwAJ?=
 =?iso-8859-1?Q?eEFQgTexhtcfDvAtHLQj1YP9CV8zohmC74pL8yLSS4WvJSKJfH9555BKxK?=
 =?iso-8859-1?Q?7T5IeSsB2Sy5HwZ9dqOuu3M3RlJHWPjJc1V9flhP+dNdA+qng4QWaMTSlA?=
 =?iso-8859-1?Q?441tfNTINSS0qUou1MteEUM8XUiyojqqSwHYF2Jtgh3qG0uByKHfH1EbsA?=
 =?iso-8859-1?Q?MmvnWsq0ytTBfmxgOoRKLgworYsF2y72ucYnAb4PeyNNyNvJGVAOj1JhWH?=
 =?iso-8859-1?Q?aljFPy0ZiO3MT9eI9c1xLzRJdIgPPNQKIxiHReSDjO7jeG3/sVXs+5ObVf?=
 =?iso-8859-1?Q?PyJ3mRecOmCYH7AakIfGFeITwijLStbQmAML9xMjb/bucTb6Hk5j7Idu9s?=
 =?iso-8859-1?Q?cOLZYfGJ9DnhOeZrMiBQO0DYvE5TwG9ZYDnknn+Q/IuzmxhPGWsDOF+qMR?=
 =?iso-8859-1?Q?8nY3QhA3gr2yt9cufDJRgYkimRgeZmBHUElB6xbqzOfpOCGucQ4a9DM4S3?=
 =?iso-8859-1?Q?0frKsXxkpGyQAXxOT+wIcKtF+XsDm2i+wepyuKCSOMPgY3gDdOGaHNJic4?=
 =?iso-8859-1?Q?L295Angg3pfNMfYLE2ydiUKqh4YIm/uRwciG415uZVFd9xP+6kJ2wi1uG4?=
 =?iso-8859-1?Q?HCt4k9A4R4FgkoMbj8yysQEUSujQDTTdzNfkuFZZ8DGEzcTO4putsD6pmU?=
 =?iso-8859-1?Q?s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fQT3yo+b3Bue4p+InrwK/ykvn9xsplaJCoGsmVQSdAuCEbXlneFjbmTiLZ?=
 =?iso-8859-1?Q?jz7JDvh935eLYeMJvl6oujAiJRf4DfdEaTqeJ9xwdLrRxks7O5l75lz/YJ?=
 =?iso-8859-1?Q?WKISMkb1RzZ/8YwVs19wBojSnh6U1q1sbsDh/CWhtfUF+zzS6Fp5RoPq40?=
 =?iso-8859-1?Q?CEHQqcFSdCqq5b58Oqh+H4AsxdYxXwmnTKiMS7/xFaqXh77FQdQ4m3fqqR?=
 =?iso-8859-1?Q?4UFsvgQ7QUdCmsMdh58xF+ORxcqAZsShZ3YKPUX5pBIEBtoeA+ZUiqfork?=
 =?iso-8859-1?Q?JBKVtnEHXrNB12eUvoH2kBNLIPCQ0IqHP39iVivX1lgymVSzksaWvMEizL?=
 =?iso-8859-1?Q?lqjDtIwAbXg8qImTK/QUpqSdMPU9cDTJ4dEaNQwy4nCQJE6eq7u7kVABFw?=
 =?iso-8859-1?Q?puuMHmqPROJqJ53RiwnjKH8/XhAsPfNjWA+a0JJO+w8Qkrqm7R+T6VsXPj?=
 =?iso-8859-1?Q?7NnrekArHNbnlQTGDM6PjlFzTsLeMWD6ztQyzYYdF0iLdNaPkPWHz0UZmh?=
 =?iso-8859-1?Q?C+pMfX35SFpxiA63L54ASpPiFxGcHhowUZ+6zK8EPbBsa8tRIOW1YkMMot?=
 =?iso-8859-1?Q?FmOwKzYHljOSFHwJjfVO6KNjvg8ksyNijhWPpJt0yotF2+0IgRPjIWy4Lw?=
 =?iso-8859-1?Q?bCzeX1LBDwpsDuaIH8iaxR/Eo0jKRLEuqbAwSMH+s33SxPb7dlQoH5pBq2?=
 =?iso-8859-1?Q?Ir5R4hTGmXn0l67MnUJtpYVXuUFh1PllPVmNhO/CxMwA8HR7id++ijIYCd?=
 =?iso-8859-1?Q?WCJtKkANpb22kWcgDMub9jyTWgQmNk+lm/XoiQrVUivnFqL+LuF/Zo1MDc?=
 =?iso-8859-1?Q?yy4h3Mn5eGL6PzCz0skiry0krQzmWtOu/hQ+V15epQQ2HOpYZ2NMYW92rg?=
 =?iso-8859-1?Q?5EQp5nMwV64NsRDRzZNiis/vAe+Rs4wag1vlGK9rmVTn4qt68SIRHkORQB?=
 =?iso-8859-1?Q?wrKDRqwieKbTWKXHQGNYl4hA+qNvQV/F686eWvTOVEADOT7ZvrA/FrIukY?=
 =?iso-8859-1?Q?FmVaRKWng0+wTa90gDtKed2mWNqstvfCwrBNfYTqY4rC/yukVTHgvESmC7?=
 =?iso-8859-1?Q?6HQRtWQP+LohxclR5HSYaVK3KdR++xKhFCxAFwiaz/GN93RGaDRpXwqH8r?=
 =?iso-8859-1?Q?nZxwYI6K4UK1P8cHMNVzmZzbH3dUlgW0It9AjQIMEPehHExNOxM+kyTwY0?=
 =?iso-8859-1?Q?vUjBB3xHEqBQpMdMLlZVgRnUZJs7vkZ0/7UrUf9WqCzdXpeZfPo16R5otr?=
 =?iso-8859-1?Q?zqDsTE0lHi24Q3UBVWcGDRr2cgHZ6863bBtevrvr/bqynzWFbHXotPFYue?=
 =?iso-8859-1?Q?iDJkiUJep4qhc+lP2XNt5CTdh0g2bMoUu8J5EIJEqhqIYj0FSRQzDJcGkf?=
 =?iso-8859-1?Q?XWANqqCMGrI1IvzAyh12vHmQgRMbvVNuU+0qVc5fVVDDgZ4sKG1+IOXcbK?=
 =?iso-8859-1?Q?nNax0gY4c8paV1TNaCGV0YuEZeeknJJ5Xkq0wGICxh3b+SqCJy+fTrrFds?=
 =?iso-8859-1?Q?TCCVJHeveg/1wsMk/gNrLtqKfK1+wxoDvUR5G8ZypsxN5cBSeODMgkEojH?=
 =?iso-8859-1?Q?tqbtEaMf4l9prBNnAMgVq/6McMzqdCoIkwymr4tOwO3buRSx+8rUVt93cn?=
 =?iso-8859-1?Q?i/OIAWVSScMdzdg5u4sCQiTisiRkgtrbgYXthioCQ9urgnhyRe1twDQw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaa8c2d-78f1-43b4-c5ce-08ddd467dba7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 21:34:28.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN4jhynXJp1AoND2ZeDppmhXoBm/1fp8a5UnfGv8iEZHyRwNuID7xI4IXQFKqWvCyipSIkgocgrEaDkEKvhGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com

On Wed, Jul 30, 2025 at 07:21:28PM +1000, Balbir Singh wrote:
> This patch series adds support for THP migration of zone device pages.
> To do so, the patches implement support for folio zone device pages
> by adding support for setting up larger order pages. Larger order
> pages provide a speedup in throughput and latency.
> 
> In my local testing (using lib/test_hmm) and a throughput test, the
> series shows a 350% improvement in data transfer throughput and a
> 500% improvement in latency
> 
> These patches build on the earlier posts by Ralph Campbell [1]
> 
> Two new flags are added in vma_migration to select and mark compound pages.
> migrate_vma_setup(), migrate_vma_pages() and migrate_vma_finalize()
> support migration of these pages when MIGRATE_VMA_SELECT_COMPOUND
> is passed in as arguments.
> 
> The series also adds zone device awareness to (m)THP pages along
> with fault handling of large zone device private pages. page vma walk
> and the rmap code is also zone device aware. Support has also been
> added for folios that might need to be split in the middle
> of migration (when the src and dst do not agree on
> MIGRATE_PFN_COMPOUND), that occurs when src side of the migration can
> migrate large pages, but the destination has not been able to allocate
> large pages. The code supported and used folio_split() when migrating
> THP pages, this is used when MIGRATE_VMA_SELECT_COMPOUND is not passed
> as an argument to migrate_vma_setup().
> 
> The test infrastructure lib/test_hmm.c has been enhanced to support THP
> migration. A new ioctl to emulate failure of large page allocations has
> been added to test the folio split code path. hmm-tests.c has new test
> cases for huge page migration and to test the folio split path. A new
> throughput test has been added as well.
> 
> The nouveau dmem code has been enhanced to use the new THP migration
> capability.
> 
> mTHP support:
> 
> The patches hard code, HPAGE_PMD_NR in a few places, but the code has
> been kept generic to support various order sizes. With additional
> refactoring of the code support of different order sizes should be
> possible.
> 
> The future plan is to post enhancements to support mTHP with a rough
> design as follows:
> 
> 1. Add the notion of allowable thp orders to the HMM based test driver
> 2. For non PMD based THP paths in migrate_device.c, check to see if
>    a suitable order is found and supported by the driver
> 3. Iterate across orders to check the highest supported order for migration
> 4. Migrate and finalize
> 
> The mTHP patches can be built on top of this series, the key design
> elements that need to be worked out are infrastructure and driver support
> for multiple ordered pages and their migration.
> 
> HMM support for large folios:
> 
> Francois Dugast posted patches support for HMM handling [4], the proposed
> changes can build on top of this series to provide support for HMM fault
> handling.
> 
> References:
> [1] https://lore.kernel.org/linux-mm/20201106005147.20113-1-rcampbell@nvidia.com/
> [2] https://lore.kernel.org/linux-mm/20250306044239.3874247-3-balbirs@nvidia.com/T/
> [3] https://lore.kernel.org/lkml/20250703233511.2028395-1-balbirs@nvidia.com/
> [4] https://lore.kernel.org/lkml/20250722193445.1588348-1-francois.dugast@intel.com/
> 
> These patches are built on top of mm/mm-stable
> 
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> 
> Changelog v2 [3] :
> - Several review comments from David Hildenbrand were addressed, Mika,
>   Zi, Matthew also provided helpful review comments
>   - In paths where it makes sense a new helper
>     is_pmd_device_private_entry() is used
>   - anon_exclusive handling of zone device private pages in
>     split_huge_pmd_locked() has been fixed
>   - Patches that introduced helpers have been folded into where they
>     are used
> - Zone device handling in mm/huge_memory.c has benefited from the code
>   and testing of Matthew Brost, he helped find bugs related to
>   copy_huge_pmd() and partial unmapping of folios.

I see a ton of discussion on this series, particularly patch 2. It looks
like you have landed on a different solution for partial unmaps. I
wanted to pull this series into in for testing but if this is actively
being refactored, likely best to hold off until next post or test off a
WIP branch if you have one.

Matt

> - Zone device THP PMD support via page_vma_mapped_walk() is restricted
>   to try_to_migrate_one()
> - There is a new dedicated helper to split large zone device folios
> 
> Changelog v1 [2]:
> - Support for handling fault_folio and using trylock in the fault path
> - A new test case has been added to measure the throughput improvement
> - General refactoring of code to keep up with the changes in mm
> - New split folio callback when the entire split is complete/done. The
>   callback is used to know when the head order needs to be reset.
> 
> Testing:
> - Testing was done with ZONE_DEVICE private pages on an x86 VM
> 
> Balbir Singh (11):
>   mm/zone_device: support large zone device private folios
>   mm/thp: zone_device awareness in THP handling code
>   mm/migrate_device: THP migration of zone device pages
>   mm/memory/fault: add support for zone device THP fault handling
>   lib/test_hmm: test cases and support for zone device private THP
>   mm/memremap: add folio_split support
>   mm/thp: add split during migration support
>   lib/test_hmm: add test case for split pages
>   selftests/mm/hmm-tests: new tests for zone device THP migration
>   gpu/drm/nouveau: add THP migration support
>   selftests/mm/hmm-tests: new throughput tests including THP
> 
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 246 +++++++---
>  drivers/gpu/drm/nouveau/nouveau_svm.c  |   6 +-
>  drivers/gpu/drm/nouveau/nouveau_svm.h  |   3 +-
>  include/linux/huge_mm.h                |  19 +-
>  include/linux/memremap.h               |  51 ++-
>  include/linux/migrate.h                |   2 +
>  include/linux/mm.h                     |   1 +
>  include/linux/rmap.h                   |   2 +
>  include/linux/swapops.h                |  17 +
>  lib/test_hmm.c                         | 432 ++++++++++++++----
>  lib/test_hmm_uapi.h                    |   3 +
>  mm/huge_memory.c                       | 358 ++++++++++++---
>  mm/memory.c                            |   6 +-
>  mm/memremap.c                          |  48 +-
>  mm/migrate_device.c                    | 517 ++++++++++++++++++---
>  mm/page_vma_mapped.c                   |  13 +-
>  mm/pgtable-generic.c                   |   6 +
>  mm/rmap.c                              |  22 +-
>  tools/testing/selftests/mm/hmm-tests.c | 607 ++++++++++++++++++++++++-
>  19 files changed, 2040 insertions(+), 319 deletions(-)
> 
> -- 
> 2.50.1
> 

