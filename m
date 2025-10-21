Return-Path: <linux-kernel+bounces-862184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F31BF4A04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAB93AF0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81999234964;
	Tue, 21 Oct 2025 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwGV4HHT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB50D221F2F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761023691; cv=fail; b=pPADvCr9i10Y3O/z9aFUCL26g/CzJ0O/j6doVTXwezVpy7G2KZzp53BVheAUnAWYlXlC5c1REyOGnVLFi+tChEOCdcyr2JJqcNQlSLISLdZ1jLXEuWBFcmHT1UB7xIpm+/+zPRYfmYLTOHtHK25rfLJnlj2hcF5i2/Kfl3jnNjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761023691; c=relaxed/simple;
	bh=ug/FArH6I7i4MXJQ7WqgA+h67XxaqiHLhThLlPfZelk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QXZNzCLfUnZUtJLTgA8K5e4tc4FDfTkmG7YcTLx95NKq058mlzCJRsgD1CC9iWZUYbQoGBk+uNrwyUMwqAUftGnx7FjwmIMLz767cO3OkFYU/3Sfg3Smy+tXHiT7GgIYYvHdTqyMz2Rvs9yfJTV2iBOXI7MY9UeejhNZs8yJAI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwGV4HHT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761023689; x=1792559689;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ug/FArH6I7i4MXJQ7WqgA+h67XxaqiHLhThLlPfZelk=;
  b=MwGV4HHTjM35ZHsLLGK0okJ5CWYbC83vihaJyxyGtTBuMw7KGmZw1K3w
   5v7ZulHPf85LbLbl4BJwQJR8RqE1XffWXpJJqmp0EbIpfyJLdxLhyreMl
   dMZIXid1K3UA2qc+YZcEsjJLCsvEgERQ8XHkQrUgTfLzQ883RVqirRTAF
   kT4iB1q8JDBz6v3DgqK4x5x80RTm/tSqxBGO+PsAiaBKASkm94EMqcx86
   C84M1INi/GrKcRRBPAlVoW1kORzjvWDntk2Lx+76ofGQIOPGVyypJFtbV
   vwH7vfpeIbolyJ51aY+23bjjD6VFm1azShFo6yiEJKvMV/EXfHrwilJLZ
   A==;
X-CSE-ConnectionGUID: pRPrJEqlTi+0qOe7a66iSg==
X-CSE-MsgGUID: H85SQYh+Trax8PsTnUejEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62175788"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="62175788"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 22:14:49 -0700
X-CSE-ConnectionGUID: lIUdWG5AS1SxKnUDkTLavA==
X-CSE-MsgGUID: A61TWGojQgOzDPphARESTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="214131950"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 22:14:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 22:14:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 22:14:48 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 22:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy5VyyMsq5QDNSAxpF86u8hldW8AkaYjGFRVg1qmVWI886bpHAPMM3YgB0tN3Uwa7mP27uRc4LRHrL6tNht16RX66IXc5j021E1PkLDVKZZcBafCY/uhySBLesqw495g0gXcm/geodvB27eXIwamAWDTtiaCZy3vgRC0aT57DDWiWNaiFTgn6a/lnxBIqBDz4DHPslb5Av78ZhtQCFak/hW31YxcUgJib/4zui0Exhm8NsPIEGdxpYR6qiHWnBdOr+g9wOpVNJ6S00+TXL4465/ahCcwX+kPfh5+uWnqdd17wbDCZPihO/1vaXPCvXEX8NVCUIojZ8mIxSehFthfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qptRi+6AA/RQF+CVMzVaM+/JSlibYeFvieCiH6zj50o=;
 b=XRbWufNK/bLyE/Mu1tFTySBRD4TnVijV9JaCVUR/KMhEPU/AUAEcJlhNalen2ItXrw7VAc8Jr8fbuPghtSNYS0Uj/HPGY2h8+m4+0ibAT3unHOGAZyAtwwzgr+4arg/C4DdYkowEtcuwDcRvfIykN1levnYgYcUFAzSZNghoFxKT1EtUJhX/86D4YV4Z/mITWb7nrjJ2RFzHm9tgth7VZTcydHar0y0vrrkNYyXfJ9VFffbT4WFosYZL1kcP7Hvt/IsC+Odggo1oIzd7ghrpxVQ/jMqLjwr2mLQlPdkP7ZTo89K/K+Ul7cwf5dDVlKfrwqjzNN3BM2TFqVSRVcLe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ5PPF8F93806F5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::845) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 05:14:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 05:14:45 +0000
Date: Tue, 21 Oct 2025 13:14:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Fernand Sieber <sieberf@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/fair]  79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202510211205.1e0f5223-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU2P306CA0017.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ5PPF8F93806F5:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dc13e2-deae-4060-0c5a-08de1060bffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qVG75k1rPITTPCtFOENpbxZufCq3HP7FyXWqeaXC7NiLkoC1Kn4geECIdh6X?=
 =?us-ascii?Q?7TWdFHztXCaCW1uAeEHiijcTwW2yUtuAsq02QcCURxorAowBIjiyYslX12B1?=
 =?us-ascii?Q?VjYfjCCfpa6vUiSC2gVMbk2ru4zxSE3ssgrFDQIi3/VnhgtsPyPgQveSzx22?=
 =?us-ascii?Q?C/BenSHtrQ3fsfy2Ip17KD6dEL1/vIzA/4IMA/bgcJZaZe+lPIbW8sGo6hsf?=
 =?us-ascii?Q?FqD/c6zIwjUwdpz+YsuqP2llpx2l2+GawF1YAa9Z0JTFOp0NY0KzIv6elRbt?=
 =?us-ascii?Q?f/pjCq3HYfl+aqD3SRRfoywrT5dQU5dEStqb92vqiwxPUc0sfrcwBRsiGrDx?=
 =?us-ascii?Q?4trpDYxyz8n++m1aMQREbm9Fv+GLJaslO87t/uppISSLfq7uDmQxwEaXnKNL?=
 =?us-ascii?Q?//VNgjurb0N9S83JUDBUEXc1snIoxuyovHDtBlT8k6/vScPGyA3fr66f7Gcs?=
 =?us-ascii?Q?/fHZKsruuI3Q2imbI4MEzXIrOUfdAcZjJRNIPkWE/tDed2ZK5QCRWe+FOSQe?=
 =?us-ascii?Q?9xxno7aIjvnPjEYRqQY6kNte6renbJVWOMkujpB5p9gLG74E3ram0EwOiOax?=
 =?us-ascii?Q?TtNBMBqxWgzly18Y/9itIBeJFLMstJpNJ4ebPEE36KMr7nDs/PwbjimNocjy?=
 =?us-ascii?Q?yy88JUfgtKn5BIV8VNLoikZ3RXIjEVrfR9SSSk7zk5lPKEzP8KwWtFMGJFxu?=
 =?us-ascii?Q?BNhSUkmQB6kKLJ/pbRLGk6uA88DABRN8+zVBnQBgjAjMD9Cc0qB9ZwFt8vLr?=
 =?us-ascii?Q?PVzPPWLbXJt69b+8gIZAJQ5/iAMBp/Xjsx9NwVq/VCLdAX76/9lhexkTPAD1?=
 =?us-ascii?Q?isQNa9g1f+L0JBzL6xDcnKi2W57VeDydYqAgeY7FFbxMDoBEa9I1YjWTGw8R?=
 =?us-ascii?Q?a1b2woBhDosMUn4xd7RRhUIjf5HHPhcZoSpxobuWan4WPTdf7rbng8K8WcMt?=
 =?us-ascii?Q?1wCh6GuS6SRHHgmnRDEH3zbmybP15r+mPhV6f/kqcvuI4YcouLJY5O0gu40U?=
 =?us-ascii?Q?NpEP49StLw9+/+Nk5q63YBhK+gQYAdGBeGdpDfvnniHvqbLAJ653l9UFY97p?=
 =?us-ascii?Q?X/UZMOIcL18JMrB+t2xNDcOV6+2HChhbZwYvy70y+ogj2DeQn04R/T2gu3FJ?=
 =?us-ascii?Q?feZNOU61jdOjlrFydUCSdeyDDbkAhF2kfTKuW3yrTRYgkms/G142IxTMh5nT?=
 =?us-ascii?Q?dcSKMqKk29PSXZ0bNLaX5DjWZA30V+SXRbnednTBImjBEkoNSG+on8I1VZ55?=
 =?us-ascii?Q?OhNdqbKo3Qt6prgyZup8iY6aCiy1EZr5OpL/KlFFpDyJYumQZsmL4VxXE/QX?=
 =?us-ascii?Q?WnJRroqzPGwgPz+NHs0NbMPGB6iSUww/YJbkj3kxyMYoJfIK2WchOpY11EPv?=
 =?us-ascii?Q?sGF9c07MbVREeQbcMtSQIsCCUKgJfJATSsDf/rtAqI+wzXvu+WPIKpGJrfOA?=
 =?us-ascii?Q?pbMfpx1Oc8UJPaME9DcB3Kzw4953EvuvLxPhXwKV/33Rn26AQm5W9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VdEu13tMhlVsFKosSglbc9YiStnJldvdRlZqXpdQlkGG0E0wy7f7w7It4lx6?=
 =?us-ascii?Q?wdvP6a+Kg/UWSknleh2D7ZIHy/Ly1Agn4MjJC6+NKXp+qP9gGCTBG43fX5L8?=
 =?us-ascii?Q?ZEAierrwEcpuUgdkGgu5Y8lFVL27VjUKJcrZWjdwRaG2IXHdPBB2Sx8QO1IC?=
 =?us-ascii?Q?UqQwrQvfQ5w7/G0dupTlNbIK2PnZxqWgJFSl5nvfCQzQms4UZrve9GENloSg?=
 =?us-ascii?Q?BWX9okrMTOZzsf1U4weaQZVZmKcYiEX7N6tYpHURbL/1bkgY/B9jzydnfoUY?=
 =?us-ascii?Q?MoyZTacu8pqlcN2pf76H6XRyap4DA1gCNomaO7guqC99ylzw9fP1xdgFeMrz?=
 =?us-ascii?Q?2HDRt+eW2wE2MTalqvbbM/pKh0QNsRWwwQseM4TeyLWWDlHeCusDcElXpK4A?=
 =?us-ascii?Q?o9OgjxRpGso4F1yPORJY0YjgnFjg+t4bBSNRCtrg3aWuaCO4zr1elM+pgTvD?=
 =?us-ascii?Q?WI+hHm1RzwdeULKCpxQGHx1qmeak6BrQdEuY6Q3STFixqpmkoYTfDlhWbRQ3?=
 =?us-ascii?Q?sUbSSuDwY6RjcCxNzAuXk8KniKE7W6H+FRwvMOzUEhmClepcBZZLFW5UvdLH?=
 =?us-ascii?Q?rMznlfGWaK0aHNmU4mvRTs0VuLRiUl9Owfm7GJ/vEyeVXj+kiYwVsBw+sgwa?=
 =?us-ascii?Q?q0UFvM2XI6OoyTlo59vKKjbsRS8RzL26Dsh8ap0mbu81aiUY5Juzp5YlTH2f?=
 =?us-ascii?Q?iQL8sJTgiCvygwn0z2rhFxQWfczDlC7ssKm/tM3RD8oJvr5lPBtZTSMae6Tu?=
 =?us-ascii?Q?B2b0izRZ9kvt1uaw9VVKHopj+iJoP5NVTH2keeRVvk3WpPYKVULpvJjC6bLX?=
 =?us-ascii?Q?b4UPTFnc2/Ax0/01b9292l50fAWCzTTlSYJiKDr+c07I/MeU9TqqFsYhxsEw?=
 =?us-ascii?Q?Y3DkeAww+8q/hWKoYzwggxThVL1+9d0GL4iu/Xc6p30mUMjWiixe2yK6aguV?=
 =?us-ascii?Q?VyTLobiIc14+paJPYTAd86+oR+H+dK25iFpN6VD5rHTmTrDiCBRUI9gVkmjJ?=
 =?us-ascii?Q?Gp+Y4p108okxh1e+PHSg+HkimgwKSVxCE7pxY3FGfQM4MZCn/GokWHtGwOz2?=
 =?us-ascii?Q?e93WvRvSm2rFPfLc+icUV0Kzei5BQ2m60MzuJ8VVmgXgFNFxQfu1iMA5sSVp?=
 =?us-ascii?Q?hsN7d6jUpHl1rSnZxvd2/CDDNrBhpIMij6VvTm+7Rm4P6bCCdqA3fks6CTQK?=
 =?us-ascii?Q?ypb27WFQ5L/IKOWQi5tobhr5cv/vmgcAGEWg4mDo3b4wPZzk031a6p0c2trE?=
 =?us-ascii?Q?xEccot0hPD0jys2u15OBT3HZNsugR9IS7nJIwQuRCydm8dY8shhNyScRbW8d?=
 =?us-ascii?Q?Tr/z9wvJGFLxQ3ZqmxXdxn2YYEQvZheZOINfb83Mb4+OypEO+s8K5HK5926i?=
 =?us-ascii?Q?5fRMo5kTOTaL2bnHcqi2jU7ZugSkR0GNkolQMbSAHxMTemcKA1/7r0s44dGS?=
 =?us-ascii?Q?OTl7cser5mvFOanPXGv5xbRWs9Etna4ozMzO6GvIGUugN89OdGP6c7++v4u7?=
 =?us-ascii?Q?V7ZPRa8a2EvB8rLer2OhxoT+/oSN5J6HFW/S0SL6vnBWfSWJAo21SSeDO2nD?=
 =?us-ascii?Q?AvtxJT1p45cvZN/dGfVSisBPRLPAqS8VmeAuBqwg4Y6xRUzmG3DczPeD2Skw?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dc13e2-deae-4060-0c5a-08de1060bffe
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 05:14:45.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBrWVfnr+1E6x1jNLc7PX2k3b8JYRU81hljPkms57rnfnQgEmSz0KE4yBETmp90SiYEvLgGSahdMOAmJDNSd6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8F93806F5
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 79104becf42baeeb4a3f2b106f954b9fc7c10a3c ("sched/fair: Forfeit vruntime on yield")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

[test failed on linux-next/master 606da5bb165594c052ee11de79bf05bc38bc1aa6]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



config: x86_64-randconfig-121-20251020
compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510211205.1e0f5223-lkp@intel.com


[   23.486344][ T3682] BUG: kernel NULL pointer dereference, address: 0000000000000051
[   23.486846][ T3682] #PF: supervisor read access in kernel mode
[   23.487189][ T3682] #PF: error_code(0x0000) - not-present page
[   23.487532][ T3682] PGD 12b0a5067 P4D 12b0a5067 PUD 12b0b0067 PMD 0
[   23.487905][ T3682] Oops: Oops: 0000 [#1]
[   23.488147][ T3682] CPU: 0 UID: 65534 PID: 3682 Comm: trinity-c1 Not tainted 6.18.0-rc1-00001-g79104becf42b #1 PREEMPT
[   23.488817][ T3682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   23.489401][ T3682] RIP: 0010:pick_task_fair (kernel/sched/fair.c:5526 kernel/sched/fair.c:8846)
[   23.490438][ T3682] Code: d2 74 1a 4c 89 d6 4c 89 e7 e8 8d e9 ff ff 85 c0 74 0b 41 80 7a 51 00 74 31 0f 0b eb 2d be 01 00 00 00 4c 89 e7 e8 b5 fe ff ff <80> 78 51 00 49 89 c2 74 12 ba 01 02 00 00 48 89 c6 48 89 df e8 44
All code
========
   0:	d2 74 1a 4c          	shlb   %cl,0x4c(%rdx,%rbx,1)
   4:	89 d6                	mov    %edx,%esi
   6:	4c 89 e7             	mov    %r12,%rdi
   9:	e8 8d e9 ff ff       	call   0xffffffffffffe99b
   e:	85 c0                	test   %eax,%eax
  10:	74 0b                	je     0x1d
  12:	41 80 7a 51 00       	cmpb   $0x0,0x51(%r10)
  17:	74 31                	je     0x4a
  19:	0f 0b                	ud2
  1b:	eb 2d                	jmp    0x4a
  1d:	be 01 00 00 00       	mov    $0x1,%esi
  22:	4c 89 e7             	mov    %r12,%rdi
  25:	e8 b5 fe ff ff       	call   0xfffffffffffffedf
  2a:*	80 78 51 00          	cmpb   $0x0,0x51(%rax)		<-- trapping instruction
  2e:	49 89 c2             	mov    %rax,%r10
  31:	74 12                	je     0x45
  33:	ba 01 02 00 00       	mov    $0x201,%edx
  38:	48 89 c6             	mov    %rax,%rsi
  3b:	48 89 df             	mov    %rbx,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	44                   	rex.R

Code starting with the faulting instruction
===========================================
   0:	80 78 51 00          	cmpb   $0x0,0x51(%rax)
   4:	49 89 c2             	mov    %rax,%r10
   7:	74 12                	je     0x1b
   9:	ba 01 02 00 00       	mov    $0x201,%edx
   e:	48 89 c6             	mov    %rax,%rsi
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8                   	.byte 0xe8
  15:	44                   	rex.R
[   23.491525][ T3682] RSP: 0000:ffff88812640fdf0 EFLAGS: 00010046
[   23.491870][ T3682] RAX: 0000000000000000 RBX: ffffffff8306f580 RCX: 000000004d636517
[   23.492330][ T3682] RDX: 000000004d636517 RSI: 000000005572ffec RDI: ffffffff8306f600
[   23.492786][ T3682] RBP: ffff88812640fe00 R08: 000000000000000f R09: 0000000000000002
[   23.493232][ T3682] R10: 0000000000000000 R11: ffff8881264140c0 R12: ffffffff8306f600
[   23.493679][ T3682] R13: ffff888125cf0000 R14: ffff88812640fe58 R15: ffff888126414788
[   23.494125][ T3682] FS:  0000000000000000(0000) GS:0000000000000000(0063) knlGS:0000000008e97880
[   23.494627][ T3682] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   23.494999][ T3682] CR2: 0000000000000051 CR3: 000000012b09c000 CR4: 00000000000406b0
[   23.495447][ T3682] Call Trace:
[   23.495637][ T3682]  <TASK>
[   23.495807][ T3682]  pick_next_task_fair (kernel/sched/fair.c:8869)
[   23.496095][ T3682]  __schedule (kernel/sched/core.c:5969 kernel/sched/core.c:6488 kernel/sched/core.c:6870)
[   23.496349][ T3682]  ? raw_spin_rq_unlock (kernel/sched/core.c:683)
[   23.496640][ T3682]  schedule (arch/x86/include/asm/bitops.h:202 (discriminator 1) arch/x86/include/asm/bitops.h:232 (discriminator 1) include/linux/thread_info.h:192 (discriminator 1) include/linux/thread_info.h:208 (discriminator 1) include/linux/sched.h:2217 (discriminator 1) kernel/sched/core.c:7013 (discriminator 1) kernel/sched/core.c:7026 (discriminator 1))
[   23.496868][ T3682]  do_sched_yield (kernel/sched/syscalls.c:1361)
[   23.497127][ T3682]  __do_sys_sched_yield (kernel/sched/syscalls.c:1375)
[   23.497409][ T3682]  ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-121-20251020/./arch/x86/include/generated/asm/syscalls_32.h:159)
[   23.497681][ T3682]  do_int80_emulation (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:172)
[   23.497962][ T3682]  asm_int80_emulation (arch/x86/include/asm/idtentry.h:569)
[   23.498244][ T3682] RIP: 0023:0xf7f3c579
[   23.498477][ T3682] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 0f 1f 40 00 cd 80 <5d> 5a 59 c3 90 90 90 90 2e 8d b4 26 00 00 00 00 8d b4 26 00 00 00
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	0f 1f 40 00          	nopl   0x0(%rax)
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
  39:	00 
  3a:	8d                   	.byte 0x8d
  3b:	b4 26                	mov    $0x26,%ah
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
   f:	00 
  10:	8d                   	.byte 0x8d
  11:	b4 26                	mov    $0x26,%ah
  13:	00 00                	add    %al,(%rax)
	...
[   23.499561][ T3682] RSP: 002b:00000000ffd6080c EFLAGS: 00000292 ORIG_RAX: 000000000000009e
[   23.500032][ T3682] RAX: ffffffffffffffda RBX: 00000000edededed RCX: 00000000e16628f4
[   23.500494][ T3682] RDX: 00000000000000e4 RSI: 00000000c25418ab RDI: 00000000810000d8
[   23.500940][ T3682] RBP: 0000000000002424 R08: 0000000000000000 R09: 0000000000000000
[   23.501386][ T3682] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   23.501832][ T3682] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   23.502281][ T3682]  </TASK>
[   23.502457][ T3682] Modules linked in:
[   23.502681][ T3682] CR2: 0000000000000051
[   23.502918][ T3682] ---[ end trace 0000000000000000 ]---
[   23.503228][ T3682] RIP: 0010:pick_task_fair (kernel/sched/fair.c:5526 kernel/sched/fair.c:8846)
[   23.503528][ T3682] Code: d2 74 1a 4c 89 d6 4c 89 e7 e8 8d e9 ff ff 85 c0 74 0b 41 80 7a 51 00 74 31 0f 0b eb 2d be 01 00 00 00 4c 89 e7 e8 b5 fe ff ff <80> 78 51 00 49 89 c2 74 12 ba 01 02 00 00 48 89 c6 48 89 df e8 44
All code
========
   0:	d2 74 1a 4c          	shlb   %cl,0x4c(%rdx,%rbx,1)
   4:	89 d6                	mov    %edx,%esi
   6:	4c 89 e7             	mov    %r12,%rdi
   9:	e8 8d e9 ff ff       	call   0xffffffffffffe99b
   e:	85 c0                	test   %eax,%eax
  10:	74 0b                	je     0x1d
  12:	41 80 7a 51 00       	cmpb   $0x0,0x51(%r10)
  17:	74 31                	je     0x4a
  19:	0f 0b                	ud2
  1b:	eb 2d                	jmp    0x4a
  1d:	be 01 00 00 00       	mov    $0x1,%esi
  22:	4c 89 e7             	mov    %r12,%rdi
  25:	e8 b5 fe ff ff       	call   0xfffffffffffffedf
  2a:*	80 78 51 00          	cmpb   $0x0,0x51(%rax)		<-- trapping instruction
  2e:	49 89 c2             	mov    %rax,%r10
  31:	74 12                	je     0x45
  33:	ba 01 02 00 00       	mov    $0x201,%edx
  38:	48 89 c6             	mov    %rax,%rsi
  3b:	48 89 df             	mov    %rbx,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	44                   	rex.R

Code starting with the faulting instruction
===========================================
   0:	80 78 51 00          	cmpb   $0x0,0x51(%rax)
   4:	49 89 c2             	mov    %rax,%r10
   7:	74 12                	je     0x1b
   9:	ba 01 02 00 00       	mov    $0x201,%edx
   e:	48 89 c6             	mov    %rax,%rsi
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8                   	.byte 0xe8
  15:	44                   	rex.R


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


