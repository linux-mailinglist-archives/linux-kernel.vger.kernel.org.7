Return-Path: <linux-kernel+bounces-741909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB45B0EA89
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482BF1C27B10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBFE26B75F;
	Wed, 23 Jul 2025 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MH6HiCvS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D48185E4A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251828; cv=fail; b=nWBR4mwKmlks7/BQmxPrRJwt3ugBhk/FMRxO+JtaGrWzLdnWhWDTWM4GRG97VFOEGIReZxgWzpQyRxD1te5Ji6J9Jb/SK7BEyovpXBf0ikn9gy+jjsoOBI8I5EZgxl5DMlghy0HiLfO04oEFtCcNO5GCyikTrmdIIdd90/myQzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251828; c=relaxed/simple;
	bh=OU6Cf5uXCWwlZPYSebKNr1WEEVXXsVjLn5mruTFrQAE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dxDRXSMC9399KzoG6wi5hsgTIX2yXw4RpReGBOC1Z5qfMszj8qJEADipNKEX86B2xzn3D2gYv5TE2RlZHR1akfqxt3nOEahPdcBx+4sQ4ugxPcByluTZICxC9tNY8972SpyACCtclD5EIwqOO3taiXecDEX56AILQARDjRPyH/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MH6HiCvS; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753251823; x=1784787823;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=OU6Cf5uXCWwlZPYSebKNr1WEEVXXsVjLn5mruTFrQAE=;
  b=MH6HiCvSozu/RKopoOdir+p7ang8qs/mkRJ8PAv+r/I8hgtEV9I9f2f4
   cHU7yf2Af4pd41msw0jC1eP2D0g1Sc7ik0C70+mGIgnDwfIP7aADrzRKY
   mM6rvcKdY6+ouGln0oa+uocapdqxQJRfVXlxV4xmjRvKbpAnI+wxihNVO
   K4/VzekWZj6irUqKGfXvPN62QU0mf/kFXhcDRgn6R8cbwud7Yc+7AlKWz
   J2ZnGIeG9KBcA9mvlMSBQvPGZl89xaM07DlMajjikfXkilsukfkDrYcu2
   11CwwbwHWez2qIEJWISq50X2L04w8Q1HL6ctm0BotN7xgqAM+dc7s/jbS
   A==;
X-CSE-ConnectionGUID: wSfesFbkRc+rNCywkIKpGQ==
X-CSE-MsgGUID: Q12RbwZgShu//S080dLfFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="73091819"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="73091819"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:23:42 -0700
X-CSE-ConnectionGUID: RsVJqNR5QZWPxoqLWj8ERA==
X-CSE-MsgGUID: 42G6YuqWQ6Cy+IrLnPbcTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163616037"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:23:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 23:23:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 23:23:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 23:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaDN/6cD1qfCdQgLxdG4hUHH0XeAv+iqwNAfeCiF6VIeva7HyzwjJXAw6BHJUW82354DE+8KxaRnesO1ovD4br7s6dgR8+h2QyLoK7+0tSogSCRm/u59k2GrZVS7ZEorO3c9ZIGaKUa54MsVckK03ZJ6x9xe6SL0h6WFBqegMduQQzhA5MwV+KnaBg2xSshPqLYyymVR8GGJlbvqrJJvLhoIH+YDmYHoOymJRu+uOzLroAk+7qyYxVNJuh57oMplvlmBjVsH924JG7f685//rap3n5EP7tdbSW5Ih4nGhhfZf5rxZnbfbseL9pxuI90hZbnrXtjCcj9ueTpZv2Pm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVUUbwZrJQ7L8OvErnyJkaLnNWWytYof8CU4D3UJWZg=;
 b=NsIlA2/lnapiLYZX0gYobZAtPpWlWrX09YJpc6xPFJcsg8gzzubAw4P6Mw3wWqbsG2RtVQymA6M0+OnXPni9r3LrK/ENFTiMxddT6hM7f+Zqp6eCgbvw9YNmGJkTXxHrE7WpXu3E8sIuGYR2S0FLBlfhdZrIRU4hyCFTsod9obglimpqmeWHBZA9vmIk96URGHIOE1+RxUVCZn8eQGKHDF2u1BLPU8X1aM5AyyxbGr8tNIZ7IX+nUK6Ftkc6UJequtVpixmiJli9sThGORbVUOo2dxxhDbqXPNvcxRr/rnr4GmELbC6Ycgim1Nrv7g5qlcJO19ZgorjGwzKlf9TRag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 06:23:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 06:23:03 +0000
Date: Wed, 23 Jul 2025 14:22:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Chris Mason <clm@meta.com>, Juri Lelli
	<juri.lelli@redhat.com>, <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
	<oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/deadline]  cccb45d7c4:
 will-it-scale.per_thread_ops 36.7% regression
Message-ID: <202507230755.5fe8e03e-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 613615e1-fe7a-45e6-d2dc-08ddc9b16115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+Q9MPS3YHwPNiMy0ERYx7LUVAXtjEKCWofWMBBzFd7itkAVTUt7o6V3zUU?=
 =?iso-8859-1?Q?xj6iE0mjxwIuKFbX2qKoEtenVaH+1kaucIwHNHftCOaRv4ZogyFpRe4PCO?=
 =?iso-8859-1?Q?qDhtdwS3TrqFWWG/y6ZGUpmv/yoa5bOhoRC8sk6ZbCcIzbXQZPAknX2ck5?=
 =?iso-8859-1?Q?laf7qNu+cTfRkdnd2USjYAsu0O2syGx1mcEkWKcW64QR8afbc3IxPIvLp+?=
 =?iso-8859-1?Q?eTDpTmmYvPWzJP414Sac0bCZGzmXPiV+ESFwQPSuMYC+z2sJ50ZSUTe0BR?=
 =?iso-8859-1?Q?RJ0JQYbYYs26aY06BMmt1dg04th0umo/e7FFEmWvwb1N5VqLavL+7JhM6A?=
 =?iso-8859-1?Q?ihNrnfxiKz11DejxM6TUkp1ncMS9QRrq+fi+j3Oa7AYGg5Nlvx0nOsxLtv?=
 =?iso-8859-1?Q?Y8TE5FHfAIQJi/B9m20Cp3G7WtbMvUnKewr1g+dpXbZ4JMKDXTdcSE87BA?=
 =?iso-8859-1?Q?VliYhi8lspvAgnQ+A8sFWJIhfBvcqnLAACGTY0temijnrtG8QR452Lmyfs?=
 =?iso-8859-1?Q?wo2mZTkx+LEc/q34xz4qbQnkGeRMbGPTWH45rQnO21e25xsIFn9aftHiSu?=
 =?iso-8859-1?Q?gsYBZikrS1YmGkU0Th4LNGDouv9E7HXy4oYOBuvz7OXX/MAU0zOJDiCzJJ?=
 =?iso-8859-1?Q?hwJa5nJDq9J1Y4zmk11l3HdJlPewOItkH387CaBzV6Ru1y1TFn/eZ2abj6?=
 =?iso-8859-1?Q?1bOz9WoysrcrydDXZ5qk98GZEaJGL52J+GvQK3ngPyYIDI+rtNbJEk/Wl8?=
 =?iso-8859-1?Q?r/H23wtj+IUab4XlLN34baeBC1/x+Eox+ipcDyGjx+DeoeARXa2iJ7gvb7?=
 =?iso-8859-1?Q?HLoiOK3KKR1Xp0wiqPTKzf2/Er/5yUxkuQOJLF08zdArBL66RiekyO8vgQ?=
 =?iso-8859-1?Q?t0yJRPCI6INiGJG1zMoNP/uPs24AKroOWqeNsIGYbwNN4GSKH9MWPvIVIH?=
 =?iso-8859-1?Q?xkWHth41z0/l0b0l/q/qdWTQ3Nz+w/Ac1vZCpDFl4nDvMovzZC/Dk5tSLY?=
 =?iso-8859-1?Q?Oky+dO5jdrPAjEVw6tj0aaOF5onDCevg4QRAfCfHjA0IQcDBS9S2tfWZVN?=
 =?iso-8859-1?Q?VfjPvrmQ5E5J88x7qdmltOBR4+600lqUi60YEfIEbqu3GphtooKpLvH6DJ?=
 =?iso-8859-1?Q?RSSLL1+TK8K71U0pGWn5W1/9z62MbCDKvh673wJ8faehTRuX7baXbCn4X9?=
 =?iso-8859-1?Q?Anwt0xPQNqUt8BTm4SLigSl9cJoaA+CAcNK+O1S/pUE1RMmwlNW7AIWylS?=
 =?iso-8859-1?Q?DYqawHfqn1rDqfkOg4j1f15G20S5FZWJIo0khF75l/w+DZeRRCFYXGZ6tf?=
 =?iso-8859-1?Q?IJ18MTpcZxI2JrfM9urtHaN8BTGFDQa24d2CiF+4nbM/nsBK+y7eBTO9IU?=
 =?iso-8859-1?Q?WBqulAO1uFHFLH+SNW+ectmcFFD4ZqIln0n4BV+DmH59Yk+5D5WZNIXQPS?=
 =?iso-8859-1?Q?MH0xMTLGA+ndsuaz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?W3OL7EYAvDfPvdkrAXvavP/CGpuq9gueIihUYHIJNwnQMhF2sEM/4LnWPV?=
 =?iso-8859-1?Q?/4WkmLiBdB+GB5m6/NlC42YS0VcfDSQ367N6OBiBSsOw/huFv0hZ3dPI56?=
 =?iso-8859-1?Q?1QiMCbfeGXNs4spRgN78xSKPxhUwMv1MG6opC1FMV5kRgvNZEmWFlNK1Yo?=
 =?iso-8859-1?Q?u0S3poH3U6oxX2DuAq1QdY3FiXpNaui4Nqlp/w71/JaLcUuZzVhpJ7sX61?=
 =?iso-8859-1?Q?yU1tYFZw3gwYLfKRK8schKYKhXF1Sl3Ml2Ud66IOSmhdutQQH5QOHb01/p?=
 =?iso-8859-1?Q?Jy1Vsg4mY1kNt7FKzbdjhkLiOaYOwuQMPLc5QrWlgflm0Goa9xJ3sMmoO4?=
 =?iso-8859-1?Q?NzTEysSRUPv67bApf/bTYxAvWijc4u+HrQRlf2eTs5poND/nqJbyhNHHT1?=
 =?iso-8859-1?Q?veLYZ8IuZy0be2dVzK2pb8uO1+ViTvVk/MCr+UAvNKGUX77sdntDVEbdot?=
 =?iso-8859-1?Q?+KWosTugwX+/R0sllfr5UyRRDtGJl82v1vc6Cq8eGaAm0EKXN07SvVgy48?=
 =?iso-8859-1?Q?kyYj9YkSfwQRg67+gLcHweNH/DbluzwSCgfZWL26M34T7aP/DTuz644dOT?=
 =?iso-8859-1?Q?OaPSebEZXyMcd+CjnXFFF5es2QuE4NZBKbJB8lX7TZOHQO341lAHMBbjRE?=
 =?iso-8859-1?Q?9mTmhoCnabD1WFCpFKf0ITfH1DVhuhAgbjDPNZvZfaQ3j2UmQ6hAyCD+6x?=
 =?iso-8859-1?Q?ud4CInrK+gorkaPbNJPJ6DHgAvTp/SxtH2DFwK5TlE5+qdzgZ/wkuwikpZ?=
 =?iso-8859-1?Q?5PND2niLHWx0jaeogTWpEWk3I5eR3x5fFc/PXecGq9Qqv7kHDsCJtwVIF1?=
 =?iso-8859-1?Q?KhH/i9m8clSg01ZAhAgH8p7FBfPEcxssMdGJjgyeCsA4QSskGAMVjP9Vlt?=
 =?iso-8859-1?Q?ZfesxfAfOTpxFvBZpU0xpy+jzCHGh0fny+DUGl9lgB/RXu5jIvHl87YsNx?=
 =?iso-8859-1?Q?UAm0jMV2nho8+XWIfWCzhVCuKJkhDjk8OO9Dr67nXwb2xSjBtjJyj3yAKV?=
 =?iso-8859-1?Q?xuhYP2VYbDT7BZgN5lqJhyZI+fmHj49vZzeSDikr4/fvmM2Ck04ltSGGLp?=
 =?iso-8859-1?Q?GqYQY61yi1B6nOLks18t+NNBhPlbBaRgohEstbmUf2dU3UzN/oSrTC0PMM?=
 =?iso-8859-1?Q?a8klcrgLjQ3eK6LDSRR46ASU5kv2/p0mOYAFLw0MesJkMkm9zEvnAoXcsD?=
 =?iso-8859-1?Q?ZwCZLNDhd0yaagJoYX2p1Y8bBzYeGaSQ8rBf9SqYnb/JnqnFynJqpkHlNm?=
 =?iso-8859-1?Q?ErZ2s6Vvuz+6Rfir283h/viaM8U+ecv8qtM/oOLlqo4kQMCwHupv+zJcV9?=
 =?iso-8859-1?Q?vMIUE/NLbz1YW9WgDrRK2hyrSpDySJNT/cu2CIJCz4vjlOMQaMkgDOA1vO?=
 =?iso-8859-1?Q?oQDHiObQMQ9DsTD7oEVnp58KYah8q7wWhcmwtfsYcsMAcNkWYnJL0oswwj?=
 =?iso-8859-1?Q?u2CiLbXcCPwYtgsRfRv6V758HcOO80ioygYbM9OMHnxCVppQj14OiXY2Bw?=
 =?iso-8859-1?Q?eP8X9UOOT/46C55gZcnVUjWXe9z1GmPkhg2HAnQpE3F54IKOWQmTxXk6Uh?=
 =?iso-8859-1?Q?EH4DhKpJDF1C93hS8u500Xohb+JqHBJl4NexT1ZQibs/uqiUz8vLtcQ79O?=
 =?iso-8859-1?Q?ZmZWyCBgRMTIvPczr66JJBtkfFyTF/3iWldfkUP0WgAHbqMua0oTcoIQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 613615e1-fe7a-45e6-d2dc-08ddc9b16115
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 06:23:03.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKk1ckDkl62miES5d1KxEhbqBI6Jfg9ewOP/7OUbZS0Ii4paFOjxwugfTJueUSZ18WtTZqoxwR5MC1aTNTaIcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com



Hello,

we found various performance regressions/improvements by this commit in
different micro benckmarks. FYI.


kernel test robot noticed a 36.7% regression of will-it-scale.per_thread_ops on:


commit: cccb45d7c4295bbfeba616582d0249f2d21e6df5 ("sched/deadline: Less agressive dl_server handling")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

[test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_task: 100%
	mode: thread
	test: mmap1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec 8.6% improvement                                |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory    |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | nr_threads=100%                                                                              |
|                  | test=schedpolicy                                                                             |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.netdev.ops_per_sec  61.6% regression                                    |
| test machine     | 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory  |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | nr_threads=100%                                                                              |
|                  | test=netdev                                                                                  |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps 7.7% improvement                                            |
| test machine     | 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory  |
| test parameters  | cluster=cs-localhost                                                                         |
|                  | cpufreq_governor=performance                                                                 |
|                  | ip=ipv4                                                                                      |
|                  | nr_threads=200%                                                                              |
|                  | runtime=300s                                                                                 |
|                  | test=TCP_MAERTS                                                                              |
+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops  60.6% regression                               |
| test machine     | 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | mode=process                                                                                 |
|                  | nr_task=100%                                                                                 |
|                  | test=pwrite3                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.timer.ops_per_sec 270.9% improvement                                    |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory  |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | nr_threads=100%                                                                              |
|                  | test=timer                                                                                   |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.min-nanosleep.ops_per_sec 2.3% improvement                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory    |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | nr_threads=100%                                                                              |
|                  | test=min-nanosleep                                                                           |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.switch.ops_per_sec 10.0% improvement                                    |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory  |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | nr_threads=100%                                                                              |
|                  | test=switch                                                                                  |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507230755.5fe8e03e-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250723/202507230755.5fe8e03e-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp2/mmap1/will-it-scale

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     48929           +20.7%      59075 ±  2%  uptime.idle
 9.128e+09 ±  2%    +111.7%  1.933e+10 ±  7%  cpuidle..time
  19232045 ±  2%    +140.2%   46190322 ±  3%  cpuidle..usage
     96378 ± 38%     -64.6%      34164 ± 96%  numa-meminfo.node1.Mapped
    811324 ±  8%     -38.4%     499711 ± 10%  numa-meminfo.node1.Shmem
   1829489           -17.8%    1503275 ±  4%  meminfo.Active
   1829489           -17.8%    1503275 ±  4%  meminfo.Active(anon)
    138153           -37.3%      86582 ±  2%  meminfo.Mapped
   1041324           -30.6%     722167 ±  8%  meminfo.Shmem
    736805 ± 12%     -22.8%     568536 ± 13%  numa-numastat.node0.local_node
    842124 ±  7%     -21.1%     664384 ±  8%  numa-numastat.node0.numa_hit
    950209 ±  7%     -24.7%     715976 ± 12%  numa-numastat.node1.local_node
   1037055 ±  5%     -21.5%     814163 ±  9%  numa-numastat.node1.numa_hit
     16.03 ±  2%    +104.7%      32.81 ±  7%  vmstat.cpu.id
    153.43           -17.2%     127.05 ±  3%  vmstat.procs.r
    108965 ±  2%     +83.0%     199375 ±  3%  vmstat.system.cs
    270608           +12.1%     303291        vmstat.system.in
    123587 ±  2%     -36.7%      78248 ±  5%  will-it-scale.192.threads
     15.05 ±  2%    +115.1%      32.38 ±  7%  will-it-scale.192.threads_idle
    643.33 ±  2%     -36.7%     407.00 ±  5%  will-it-scale.per_thread_ops
    123587 ±  2%     -36.7%      78248 ±  5%  will-it-scale.workload
     15.53 ±  2%     +17.0       32.50 ±  7%  mpstat.cpu.all.idle%
      0.41 ±  2%      +0.1        0.49 ±  2%  mpstat.cpu.all.irq%
      0.04 ±  2%      +0.0        0.05 ±  4%  mpstat.cpu.all.soft%
     83.91           -17.0       66.90 ±  3%  mpstat.cpu.all.sys%
      0.12            -0.1        0.07 ±  5%  mpstat.cpu.all.usr%
    841246 ±  7%     -21.1%     663460 ±  8%  numa-vmstat.node0.numa_hit
    735926 ± 12%     -22.9%     567613 ± 13%  numa-vmstat.node0.numa_local
     24387 ± 38%     -64.3%       8695 ± 96%  numa-vmstat.node1.nr_mapped
    202834 ±  8%     -38.4%     124853 ± 10%  numa-vmstat.node1.nr_shmem
   1038433 ±  6%     -21.7%     813183 ±  9%  numa-vmstat.node1.numa_hit
    951586 ±  8%     -24.9%     714996 ± 12%  numa-vmstat.node1.numa_local
    457393           -17.8%     375837 ±  4%  proc-vmstat.nr_active_anon
   1145415            -7.0%    1065562        proc-vmstat.nr_file_pages
     34923           -37.1%      21983 ±  2%  proc-vmstat.nr_mapped
    260363           -30.7%     180507 ±  8%  proc-vmstat.nr_shmem
    457393           -17.8%     375837 ±  4%  proc-vmstat.nr_zone_active_anon
   1880864           -21.3%    1479470 ±  3%  proc-vmstat.numa_hit
   1688698           -23.9%    1285435 ±  4%  proc-vmstat.numa_local
   3234094 ±  2%     -37.5%    2021950 ±  6%  proc-vmstat.pgalloc_normal
   2859422 ±  2%     -38.6%    1755130 ±  6%  proc-vmstat.pgfree
      0.06           +63.3%       0.10 ±  8%  perf-stat.i.MPKI
 1.924e+10           -20.2%  1.536e+10 ±  4%  perf-stat.i.branch-instructions
      0.04            +0.1        0.10 ± 11%  perf-stat.i.branch-miss-rate%
   7139830 ±  2%      +8.5%    7746733        perf-stat.i.branch-misses
  22682520            -3.5%   21885670 ±  2%  perf-stat.i.cache-references
    109943 ±  2%     +84.4%     202695 ±  3%  perf-stat.i.context-switches
 5.202e+11           -19.9%  4.164e+11 ±  4%  perf-stat.i.cpu-cycles
    259.66            +3.7%     269.38        perf-stat.i.cpu-migrations
     97159           -18.2%      79505 ±  2%  perf-stat.i.cycles-between-cache-misses
 9.606e+10           -20.2%  7.665e+10 ±  4%  perf-stat.i.instructions
      0.19            +2.5%       0.19        perf-stat.i.ipc
      0.07 ± 26%     -73.4%       0.02 ±101%  perf-stat.i.major-faults
      0.06           +26.6%       0.07 ±  3%  perf-stat.overall.MPKI
      0.04            +0.0        0.05 ±  4%  perf-stat.overall.branch-miss-rate%
     23.94            +0.9       24.82        perf-stat.overall.cache-miss-rate%
     95666           -20.7%      75866 ±  3%  perf-stat.overall.cycles-between-cache-misses
 2.344e+08 ±  2%     +25.0%  2.931e+08 ±  4%  perf-stat.overall.path-length
 1.915e+10           -20.8%  1.516e+10 ±  3%  perf-stat.ps.branch-instructions
   7105457            +7.4%    7633217        perf-stat.ps.branch-misses
  22609904            -3.5%   21824261 ±  2%  perf-stat.ps.cache-references
    109413 ±  2%     +82.8%     200048 ±  3%  perf-stat.ps.context-switches
 5.178e+11           -20.6%   4.11e+11 ±  3%  perf-stat.ps.cpu-cycles
    258.60            +3.4%     267.48        perf-stat.ps.cpu-migrations
 9.563e+10           -20.9%  7.568e+10 ±  3%  perf-stat.ps.instructions
      0.06 ± 26%     -73.7%       0.02 ±101%  perf-stat.ps.major-faults
 2.895e+13           -20.9%   2.29e+13 ±  4%  perf-stat.total.instructions
  24168770           -48.0%   12569759 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.avg
  24397767           -42.1%   14114188 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
  23131295           -88.3%    2698143 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.min
    129414 ± 12%   +1811.9%    2474324 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     36961 ± 53%     -93.9%       2249 ±135%  sched_debug.cfs_rq:/.left_deadline.avg
   7096695 ± 53%     -93.9%     431832 ±135%  sched_debug.cfs_rq:/.left_deadline.max
    510824 ± 53%     -93.9%      31084 ±135%  sched_debug.cfs_rq:/.left_deadline.stddev
     36961 ± 53%     -93.9%       2249 ±135%  sched_debug.cfs_rq:/.left_vruntime.avg
   7096632 ± 53%     -93.9%     431793 ±135%  sched_debug.cfs_rq:/.left_vruntime.max
    510819 ± 53%     -93.9%      31081 ±135%  sched_debug.cfs_rq:/.left_vruntime.stddev
    347.47 ± 11%     -37.8%     216.06 ± 23%  sched_debug.cfs_rq:/.load_avg.max
      2.61 ±  4%     -54.3%       1.19 ± 14%  sched_debug.cfs_rq:/.load_avg.min
  24168770           -48.0%   12569758 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
  24397767           -42.1%   14114188 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
  23131295           -88.3%    2698143 ±  7%  sched_debug.cfs_rq:/.min_vruntime.min
    129414 ± 12%   +1811.9%    2474324 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
     36961 ± 53%     -93.9%       2249 ±135%  sched_debug.cfs_rq:/.right_vruntime.avg
   7096633 ± 53%     -93.9%     431793 ±135%  sched_debug.cfs_rq:/.right_vruntime.max
    510819 ± 53%     -93.9%      31081 ±135%  sched_debug.cfs_rq:/.right_vruntime.stddev
    406.31 ±  7%     -72.5%     111.89 ±  6%  sched_debug.cfs_rq:/.runnable_avg.min
    123.61 ±  6%     +43.5%     177.42 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    399.81 ±  7%     -72.4%     110.19 ±  6%  sched_debug.cfs_rq:/.util_avg.min
    108.91 ±  7%     +61.9%     176.29 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
    968.69 ±  4%      -4.9%     921.42 ±  3%  sched_debug.cfs_rq:/.util_est.max
   1356108 ±  4%     +15.5%    1566412 ±  4%  sched_debug.cpu.avg_idle.avg
     13.33 ±  4%     -10.9%      11.88 ±  6%  sched_debug.cpu.clock.stddev
     84211 ±  2%     +76.6%     148687 ±  3%  sched_debug.cpu.nr_switches.avg
    374937 ± 12%    +424.3%    1965825 ± 39%  sched_debug.cpu.nr_switches.max
     49563 ±  7%    +472.2%     283616 ± 16%  sched_debug.cpu.nr_switches.stddev
      0.06 ±137%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.01 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.02 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.01 ± 11%     -94.6%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.force_qs_rnp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.03 ± 37%    +591.7%       0.21 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.01 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      0.01 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.anon_pipe_write.fifo_pipe_write.vfs_write
      0.12 ± 57%     -94.0%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.66 ± 35%     -99.3%       0.00 ± 16%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.04 ± 19%     -85.7%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.01 ± 38%     -87.8%       0.00        perf-sched.sch_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.08 ± 76%     -94.4%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.07 ± 42%     -85.5%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ± 37%     -87.2%       0.00 ±223%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.30 ± 31%     -83.7%       0.05 ± 43%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.18 ± 32%     -97.0%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 20%     -59.0%       0.00 ±  8%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ±  9%     -72.3%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ±  6%     -37.8%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  4%     -47.0%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.29 ±165%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.02 ± 89%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.02 ± 14%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.01 ± 16%     -95.6%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.force_qs_rnp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.52 ±  8%     -77.6%       0.79 ± 27%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.01 ± 52%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      0.01 ± 93%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.anon_pipe_write.fifo_pipe_write.vfs_write
      2.96 ± 32%     -89.3%       0.32 ± 72%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      1.75 ± 63%     -99.2%       0.01 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 35%     -45.9%       0.01 ± 39%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      1.78 ± 67%     -99.6%       0.01 ± 12%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3.05 ± 35%     -96.8%       0.10 ±185%  perf-sched.sch_delay.max.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      1.79 ± 48%     -84.7%       0.27 ± 90%  perf-sched.sch_delay.max.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.38 ± 85%     -98.2%       0.01 ± 21%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.04 ± 49%     -98.8%       0.03 ± 38%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.44 ± 83%     -94.8%       0.28 ± 93%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.15 ± 86%     -98.9%       0.00 ±223%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.20 ±105%     -98.7%       0.00 ±223%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.13 ± 61%     -95.9%       0.01 ±154%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      3.71 ±  2%     -78.6%       0.79 ± 24%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      2.98 ± 21%     -99.5%       0.02 ±  6%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.17 ± 17%     -99.0%       0.02 ± 31%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.54 ± 84%     -95.8%       0.02 ± 44%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     11.05 ±  4%     -28.7%       7.88        perf-sched.total_wait_and_delay.average.ms
    238376 ±  3%     +37.9%     328775 ±  3%  perf-sched.total_wait_and_delay.count.ms
      2293 ± 13%     +88.4%       4321 ±  5%  perf-sched.total_wait_and_delay.max.ms
     11.04 ±  4%     -28.7%       7.87        perf-sched.total_wait_time.average.ms
      2293 ± 13%     +88.4%       4321 ±  5%  perf-sched.total_wait_time.max.ms
      0.41 ±223%  +31852.7%     130.74 ± 43%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    107.76 ± 32%     +71.6%     184.90 ±  6%  perf-sched.wait_and_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
     23.89 ± 20%     -43.6%      13.48 ± 11%  perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     98.40 ± 10%     +63.9%     161.27 ± 27%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.39 ±  4%    +513.5%       2.40 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      0.32 ±  3%    +637.8%       2.36 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
    442.42 ±  3%     +39.0%     615.10 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.17 ± 25%     -83.8%       1.00 ±152%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    403.50 ± 35%     -45.9%     218.33 ±  6%  perf-sched.wait_and_delay.count.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      1234 ± 23%     +69.2%       2087 ±  9%  perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
    130.50 ± 10%     -35.5%      84.17 ± 20%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
    100155 ±  4%     +57.8%     158055 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
    126802 ±  3%     +28.3%     162742 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      3720 ±  7%     -50.6%       1839 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1048 ±  4%     -23.6%     801.33 ±  8%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     58.08 ±223%   +4522.0%       2684 ± 41%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      2166 ± 20%     +95.2%       4229 ±  8%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1994 ±  5%     +98.4%       3957 ±  7%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.53 ±121%     -97.5%       0.14 ±149%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.12 ±128%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.02 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      4.39 ±  5%     -84.9%       0.66 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.force_qs_rnp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.04 ± 18%   +4190.5%     130.53 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.01 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      0.01 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.anon_pipe_write.fifo_pipe_write.vfs_write
      0.74 ±148%     -99.5%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      2.86 ± 79%    +420.4%      14.91 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    107.71 ± 32%     +71.7%     184.89 ±  6%  perf-sched.wait_time.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
     23.89 ± 20%     -43.6%      13.48 ± 11%  perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 59%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.04 ± 93%     -96.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.02 ± 80%     -89.5%       0.00 ±223%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.11 ±163%     -95.4%       0.01 ±154%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     98.10 ± 10%     +64.3%     161.22 ± 27%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.38 ±  3%    +524.3%       2.39 ±  9%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      0.31 ±  3%    +651.2%       2.35 ±  9%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      0.88 ± 10%     -32.7%       0.59        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.45           -10.9%       3.97 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    442.40 ±  3%     +39.0%     615.09 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    224.31 ± 98%     -99.9%       0.14 ±149%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.45 ±136%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.02 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      4.82 ±  7%     -86.2%       0.66 ±223%  perf-sched.wait_time.max.ms.__cond_resched.force_qs_rnp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 52%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      7.36 ± 16%     -41.6%       4.29 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.01 ± 93%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.anon_pipe_write.fifo_pipe_write.vfs_write
     12.34 ±136%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
     20.81 ± 11%     -20.3%      16.58 ±  5%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    836.03 ± 44%     -79.5%     171.53 ±216%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 73%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.86 ± 98%     -99.8%       0.00 ±223%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.75 ± 99%     -99.7%       0.00 ±223%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
    167.42 ±223%     -99.9%       0.10 ±138%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.09 ±103%     -99.5%       0.01 ±154%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      4.85 ±  6%     -52.6%       2.30 ±  7%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      6.99 ±  8%     -28.4%       5.01        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2166 ± 20%     +95.2%       4228 ±  8%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    333.80 ±141%    -100.0%       0.02 ± 44%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1994 ±  5%     +98.4%       3957 ±  7%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     57.59           -10.2       47.34        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.do_syscall_64
     57.93            -9.5       48.45        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     57.94            -9.5       48.49        perf-profile.calltrace.cycles-pp.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     58.16            -9.1       49.10        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     58.17            -9.0       49.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     58.17            -9.0       49.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     58.18            -9.0       49.15        perf-profile.calltrace.cycles-pp.__mmap
      0.00            +0.8        0.83 ± 17%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.00            +0.9        0.86 ± 17%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.90 ± 21%  perf-profile.calltrace.cycles-pp.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      0.00            +1.1        1.08 ± 23%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +1.1        1.08 ± 23%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.1        1.08 ± 23%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00            +1.1        1.10 ± 23%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.1        1.10 ± 23%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.2        1.16 ± 23%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.3        1.27 ± 22%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.3        1.27 ± 22%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.3        1.27 ± 22%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.00            +1.3        1.28 ± 22%  perf-profile.calltrace.cycles-pp.common_startup_64
     41.04            +6.4       47.39        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap
     41.28            +7.2       48.50        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     41.29            +7.2       48.54        perf-profile.calltrace.cycles-pp.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.62            +7.8       49.41        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     41.62            +7.8       49.41        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     41.62            +7.8       49.43        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     41.62            +7.8       49.43        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     41.63            +7.8       49.45        perf-profile.calltrace.cycles-pp.__munmap
     58.16            -9.1       49.10        perf-profile.children.cycles-pp.vm_mmap_pgoff
     58.18            -9.0       49.15        perf-profile.children.cycles-pp.__mmap
     98.64            -3.9       94.75        perf-profile.children.cycles-pp.osq_lock
     99.22            -2.3       96.96        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     99.24            -2.2       97.02        perf-profile.children.cycles-pp.down_write_killable
     99.83            -1.2       98.63        perf-profile.children.cycles-pp.do_syscall_64
     99.83            -1.2       98.63        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.05            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.get_jiffies_update
      0.05 ±  7%      +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.update_curr
      0.06            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.vma_expand
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__resched_curr
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.schedule_idle
      0.06            +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.mas_store_gfp
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.osq_unlock
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.12 ±  8%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.vma_complete
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.downgrade_write
      0.07            +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.vma_merge_new_range
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.05            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.unmapped_area_topdown
      0.05            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.mas_rev_awalk
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.06            +0.1        0.16 ± 17%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.06            +0.1        0.16 ± 17%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      0.09 ±  4%      +0.1        0.19 ± 18%  perf-profile.children.cycles-pp.__vma_start_write
      0.06 ±  7%      +0.1        0.17 ± 16%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.00            +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.10            +0.1        0.22 ± 18%  perf-profile.children.cycles-pp.__mmap_region
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.sched_balance_rq
      0.00            +0.1        0.14 ± 17%  perf-profile.children.cycles-pp.__pick_next_task
      0.13            +0.1        0.27 ± 15%  perf-profile.children.cycles-pp.__split_vma
      0.00            +0.2        0.15 ± 18%  perf-profile.children.cycles-pp.handle_softirqs
      0.02 ± 99%      +0.2        0.18 ± 16%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.2        0.16 ± 17%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.2        0.16 ± 17%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.2        0.16 ± 19%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.2        0.16 ± 21%  perf-profile.children.cycles-pp.up_read
      0.00            +0.2        0.16 ± 18%  perf-profile.children.cycles-pp.wake_up_q
      0.00            +0.2        0.18 ±  8%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.2        0.18 ± 28%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.2        0.19 ± 22%  perf-profile.children.cycles-pp.up_write
      0.16 ±  5%      +0.2        0.36 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.01 ±223%      +0.2        0.22 ± 20%  perf-profile.children.cycles-pp.ktime_get
      0.16            +0.2        0.37 ± 15%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.03 ± 70%      +0.2        0.26 ± 17%  perf-profile.children.cycles-pp.schedule
      0.00            +0.2        0.24 ± 15%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.17 ±  2%      +0.2        0.41 ± 16%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.2        0.24 ± 19%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.00            +0.2        0.24 ± 16%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.04 ± 44%      +0.2        0.28 ± 16%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.04 ± 44%      +0.3        0.30 ± 21%  perf-profile.children.cycles-pp.rwsem_wake
      0.06 ±  6%      +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.__schedule
      0.11 ±  4%      +0.3        0.38 ± 20%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.20 ±  3%      +0.3        0.49 ±  4%  perf-profile.children.cycles-pp.sched_tick
      0.06 ±  7%      +0.3        0.38 ± 19%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.4        0.38 ± 34%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.4        0.39 ± 34%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.30 ±  2%      +0.4        0.70 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.32            +0.5        0.78 ±  8%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.33            +0.5        0.80 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.30            +0.5        0.83 ± 17%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.32            +0.6        0.86 ± 17%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.40 ±  2%      +0.7        1.06 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.41            +0.7        1.07 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.41            +0.7        1.13 ± 19%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.45            +0.8        1.27 ± 11%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.47            +0.9        1.39 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.10 ±  5%      +1.0        1.08 ± 23%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      0.10 ±  5%      +1.0        1.08 ± 23%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.10 ±  5%      +1.0        1.08 ± 23%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.10 ±  5%      +1.0        1.08 ± 23%  perf-profile.children.cycles-pp.pv_native_safe_halt
      0.10 ±  5%      +1.0        1.10 ± 23%  perf-profile.children.cycles-pp.cpuidle_enter
      0.10 ±  5%      +1.0        1.10 ± 23%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.10 ±  4%      +1.1        1.17 ± 23%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.12 ±  4%      +1.2        1.27 ± 22%  perf-profile.children.cycles-pp.start_secondary
      0.12 ±  6%      +1.2        1.27 ± 22%  perf-profile.children.cycles-pp.do_idle
      0.12 ±  6%      +1.2        1.28 ± 22%  perf-profile.children.cycles-pp.common_startup_64
      0.12 ±  6%      +1.2        1.28 ± 22%  perf-profile.children.cycles-pp.cpu_startup_entry
     41.62            +7.8       49.41        perf-profile.children.cycles-pp.__vm_munmap
     41.62            +7.8       49.41        perf-profile.children.cycles-pp.__x64_sys_munmap
     41.63            +7.8       49.45        perf-profile.children.cycles-pp.__munmap
     98.21            -4.1       94.08        perf-profile.self.cycles-pp.osq_lock
      0.05            +0.1        0.11 ± 19%  perf-profile.self.cycles-pp.get_jiffies_update
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.__resched_curr
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.osq_unlock
      0.12 ±  8%      +0.1        0.20 ± 10%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.09 ± 26%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.09 ±  4%      +0.1        0.18 ± 18%  perf-profile.self.cycles-pp.__vma_start_write
      0.00            +0.1        0.12 ± 25%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.13 ± 10%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.2        0.18 ± 31%  perf-profile.self.cycles-pp.pv_native_safe_halt
      0.00            +0.2        0.20 ± 21%  perf-profile.self.cycles-pp.ktime_get
      0.10 ±  3%      +0.3        0.40 ± 20%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.00            +0.4        0.38 ± 34%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.40            +0.7        1.10 ± 18%  perf-profile.self.cycles-pp.rwsem_spin_on_owner


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/schedpolicy/stress-ng/60s

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1590744 ±  3%     -10.1%    1429682 ±  3%  meminfo.Mapped
      0.44 ±  6%      -9.4%       0.39 ±  5%  sched_debug.cpu.nr_running.stddev
    398430 ±  3%     -10.5%     356666 ±  3%  proc-vmstat.nr_mapped
      4780            -3.3%       4622 ±  2%  proc-vmstat.nr_page_table_pages
 5.916e+08            +8.6%  6.427e+08        stress-ng.schedpolicy.ops
   9861019            +8.6%   10712524        stress-ng.schedpolicy.ops_per_sec
      3085            -1.4%       3043        stress-ng.time.system_time
    655.33            +6.8%     699.99        stress-ng.time.user_time
     20.70 ±129%     -99.8%       0.04 ± 59%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      3.89 ± 12%     -31.0%       2.68 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     20.28 ± 34%     -52.5%       9.64 ± 24%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    700.01 ±130%     -99.9%       0.60 ± 66%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    258.83 ±  2%      +8.1%     279.83 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     58.67 ± 10%     +20.5%      70.67 ±  5%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.70 ±129%     -99.8%       0.04 ± 60%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    700.01 ±130%     -99.9%       0.60 ± 66%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.25           +14.0%       0.29 ±  2%  perf-stat.i.MPKI
 4.879e+10            -1.5%  4.806e+10        perf-stat.i.branch-instructions
  46494984           +10.3%   51292475 ±  2%  perf-stat.i.cache-misses
 1.416e+08 ±  2%      +8.0%  1.529e+08        perf-stat.i.cache-references
      1.20            +3.5%       1.24        perf-stat.i.cpi
      4741            -9.2%       4302        perf-stat.i.cycles-between-cache-misses
 1.837e+11            -3.4%  1.775e+11        perf-stat.i.instructions
      0.84            -3.4%       0.81        perf-stat.i.ipc
      0.25           +14.2%       0.29 ±  2%  perf-stat.overall.MPKI
      1.20            +3.5%       1.24        perf-stat.overall.cpi
      4736            -9.3%       4295        perf-stat.overall.cycles-between-cache-misses
      0.83            -3.4%       0.81        perf-stat.overall.ipc
   4.8e+10            -1.6%  4.725e+10        perf-stat.ps.branch-instructions
  45737759           +10.3%   50431677 ±  2%  perf-stat.ps.cache-misses
 1.393e+08 ±  2%      +7.9%  1.504e+08        perf-stat.ps.cache-references
 1.807e+11            -3.4%  1.745e+11        perf-stat.ps.instructions
 1.111e+13            -3.5%  1.073e+13        perf-stat.total.instructions



***************************************************************************************************
lkp-srf-2sp3: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp3/netdev/stress-ng/60s

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  3.63e+08          +643.3%  2.698e+09 ± 13%  cpuidle..time
    204743 ±  3%   +1975.4%    4249334 ± 10%  cpuidle..usage
      4.97          +341.0%      21.93 ± 10%  vmstat.cpu.id
    184.63           -22.2%     143.65 ±  4%  vmstat.procs.r
      3473         +3085.4%     110658 ±  8%  vmstat.system.cs
    408964            +2.0%     417266        vmstat.system.in
   1113721           +17.7%    1310862        meminfo.Active
   1113721           +17.7%    1310862        meminfo.Active(anon)
    177366 ±  2%     +11.0%     196822 ±  4%  meminfo.DirectMap4k
    298665           +19.2%     355990 ±  2%  meminfo.Mapped
    420393           +45.3%     610884 ±  2%  meminfo.Shmem
      2.96 ± 20%     +16.7       19.66 ± 14%  mpstat.cpu.all.idle%
      0.26            +0.3        0.61 ±  3%  mpstat.cpu.all.irq%
      0.00 ± 20%      +0.0        0.03 ±  5%  mpstat.cpu.all.soft%
     96.53           -17.1       79.47 ±  3%  mpstat.cpu.all.sys%
     14.83 ± 61%    +238.2%      50.17 ± 20%  mpstat.max_utilization.seconds
    100.00           -14.6%      85.36 ±  3%  mpstat.max_utilization_pct
   9547602           -61.6%    3667923 ±  4%  stress-ng.netdev.ops
    159180           -61.6%      61151 ±  4%  stress-ng.netdev.ops_per_sec
     67355            +2.8%      69256        stress-ng.time.minor_page_faults
     19016           -21.0%      15021 ±  4%  stress-ng.time.percent_of_cpu_this_job_got
     11432           -21.0%       9033 ±  4%  stress-ng.time.system_time
     35368 ±  2%   +9542.0%    3410177 ±  8%  stress-ng.time.voluntary_context_switches
    278515           +17.5%     327222        proc-vmstat.nr_active_anon
    995358            +4.7%    1042520        proc-vmstat.nr_file_pages
     74999           +18.3%      88740 ±  2%  proc-vmstat.nr_mapped
    105146           +44.9%     152305 ±  2%  proc-vmstat.nr_shmem
    278515           +17.5%     327222        proc-vmstat.nr_zone_active_anon
    826913            +7.7%     890858        proc-vmstat.numa_hit
    629070           +10.1%     692863        proc-vmstat.numa_local
    873883            +7.2%     936679        proc-vmstat.pgalloc_normal
    418067            +2.9%     430228        proc-vmstat.pgfault
      0.10 ±  3%     +37.8%       0.14 ±  2%  perf-stat.i.MPKI
 2.248e+10           -22.9%  1.733e+10 ±  4%  perf-stat.i.branch-instructions
      0.10 ±  2%      +0.0        0.15 ±  4%  perf-stat.i.branch-miss-rate%
  18947128           +20.6%   22857416        perf-stat.i.branch-misses
     35.42           -17.1       18.35 ±  9%  perf-stat.i.cache-miss-rate%
   9364646           +11.9%   10482390 ±  2%  perf-stat.i.cache-misses
  27205535          +125.0%   61210467 ± 11%  perf-stat.i.cache-references
      3273 ±  2%   +3392.2%     114320 ±  8%  perf-stat.i.context-switches
      5.35            +3.8%       5.56        perf-stat.i.cpi
 6.028e+11           -20.1%  4.818e+11 ±  4%  perf-stat.i.cpu-cycles
    327.85          +343.1%       1452 ±  9%  perf-stat.i.cpu-migrations
     68905           -27.8%      49741 ±  2%  perf-stat.i.cycles-between-cache-misses
  1.12e+11           -23.0%  8.626e+10 ±  4%  perf-stat.i.instructions
      0.19            -3.5%       0.18        perf-stat.i.ipc
      4316 ±  2%      +6.1%       4578        perf-stat.i.minor-faults
      4316 ±  2%      +6.1%       4578        perf-stat.i.page-faults
      0.08           +45.3%       0.12 ±  2%  perf-stat.overall.MPKI
      0.08            +0.0        0.13 ±  5%  perf-stat.overall.branch-miss-rate%
     34.42           -17.1       17.28 ±  9%  perf-stat.overall.cache-miss-rate%
      5.38            +3.8%       5.59        perf-stat.overall.cpi
     64384           -28.5%      46017 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.19            -3.7%       0.18        perf-stat.overall.ipc
 2.211e+10           -22.9%  1.705e+10 ±  4%  perf-stat.ps.branch-instructions
  18642811           +20.5%   22455956        perf-stat.ps.branch-misses
   9210208           +11.8%   10296398 ±  2%  perf-stat.ps.cache-misses
  26761745          +124.9%   60190009 ± 11%  perf-stat.ps.cache-references
      3220 ±  2%   +3391.4%     112425 ±  8%  perf-stat.ps.context-switches
  5.93e+11           -20.1%  4.739e+11 ±  4%  perf-stat.ps.cpu-cycles
    322.54          +343.0%       1428 ±  9%  perf-stat.ps.cpu-migrations
 1.102e+11           -23.0%  8.484e+10 ±  4%  perf-stat.ps.instructions
      4239 ±  2%      +5.3%       4464        perf-stat.ps.minor-faults
      4239 ±  2%      +5.3%       4464        perf-stat.ps.page-faults
 6.771e+12           -23.7%  5.169e+12 ±  4%  perf-stat.total.instructions
   5992277           -35.8%    3846765 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.avg
   6049811           -19.2%    4888185 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
   5847973           -63.4%    2140155 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
     30248 ± 13%   +3774.5%    1171963 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.53           -21.2%       0.42 ±  4%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_queued.min
      0.17 ± 10%     +99.4%       0.34 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.53           -21.3%       0.42 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_runnable.min
      0.17 ± 10%     +98.9%       0.34 ±  3%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      2696          -100.0%       0.00        sched_debug.cfs_rq:/.load.min
      2.50           -83.3%       0.42 ±107%  sched_debug.cfs_rq:/.load_avg.min
   5992277           -35.8%    3846765 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
   6049811           -19.2%    4888185 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
   5847973           -63.4%    2140155 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
     30248 ± 13%   +3774.5%    1171963 ±  2%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.53           -21.2%       0.42 ±  4%  sched_debug.cfs_rq:/.nr_queued.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.nr_queued.min
      0.12 ±  8%    +185.0%       0.33 ±  4%  sched_debug.cfs_rq:/.nr_queued.stddev
    588.21           -17.7%     484.36 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    489.25 ±  6%     -95.0%      24.25 ±141%  sched_debug.cfs_rq:/.runnable_avg.min
    136.65 ±  9%     +70.5%     233.00 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    585.65           -17.5%     482.95 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    410.58 ± 29%     -94.4%      23.00 ±141%  sched_debug.cfs_rq:/.util_avg.min
    117.24 ±  7%     +99.4%     233.84 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
    520.05           -32.1%     353.31 ±  6%  sched_debug.cfs_rq:/.util_est.avg
      1139 ± 14%     -19.1%     921.17 ± 11%  sched_debug.cfs_rq:/.util_est.max
    387.58 ± 45%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est.min
     67.01 ± 18%    +283.1%     256.74 ±  2%  sched_debug.cfs_rq:/.util_est.stddev
    669274 ± 19%     +60.4%    1073556 ±  6%  sched_debug.cpu.avg_idle.avg
   1885708 ± 21%     +44.0%    2714848 ±  7%  sched_debug.cpu.avg_idle.max
      7213 ± 87%    +597.3%      50301 ±  5%  sched_debug.cpu.avg_idle.min
     16.82 ± 12%     -35.5%      10.86 ±  8%  sched_debug.cpu.clock.stddev
      2573           -21.9%       2010 ±  4%  sched_debug.cpu.curr->pid.avg
      2303 ± 12%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
    448.26 ±  8%    +220.4%       1436 ±  4%  sched_debug.cpu.curr->pid.stddev
    235851 ± 10%     +17.7%     277484 ±  9%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.53           -21.5%       0.42 ±  4%  sched_debug.cpu.nr_running.avg
      0.50          -100.0%       0.00        sched_debug.cpu.nr_running.min
      0.16 ± 11%    +108.2%       0.33 ±  3%  sched_debug.cpu.nr_running.stddev
      1673 ± 16%   +1028.2%      18878 ±  7%  sched_debug.cpu.nr_switches.avg
      2564 ± 67%    +752.3%      21858 ±  4%  sched_debug.cpu.nr_switches.stddev
      0.00 ±111%   +6575.0%       0.12 ± 14%  sched_debug.cpu.nr_uninterruptible.avg
    -31.42          +179.6%     -87.83        sched_debug.cpu.nr_uninterruptible.min
      0.03 ±  7%    +349.1%       0.12 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ± 99%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.08 ±107%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01 ±  8%     +78.1%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.79 ± 29%     -99.2%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.60 ± 65%     -92.2%       0.05 ±192%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ± 70%     -71.0%       0.01 ± 36%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.23 ± 26%     -90.3%       0.02 ± 36%  perf-sched.sch_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.50 ± 42%     -86.5%       0.07 ±120%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.05 ± 45%     -83.5%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ± 28%     -73.9%       0.02 ± 35%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 10%    +136.7%       0.02 ± 46%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.26 ± 29%     -96.0%       0.01 ± 85%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.30 ± 40%     -95.2%       0.01 ± 21%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
      0.31 ± 41%     -95.3%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
      0.20 ± 39%     -96.3%       0.01 ± 25%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01           +73.3%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 32%     -39.7%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.21 ± 22%     -96.2%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.27 ±139%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.58 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01 ± 21%    +204.2%       0.02 ± 75%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.39 ±  8%     -99.7%       0.01 ±  7%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.08 ± 55%     -92.1%       0.16 ±210%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3.41 ±  7%     -90.9%       0.31 ± 97%  perf-sched.sch_delay.max.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      6.55 ± 39%     -91.8%       0.54 ± 56%  perf-sched.sch_delay.max.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      2.46 ± 39%     -98.1%       0.05 ± 73%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.88 ± 49%     -92.6%       0.44 ± 88%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 21%    +433.9%       0.06 ± 78%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      6.90 ± 37%    +311.9%      28.44 ±  8%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
      9.31 ± 16%    +223.8%      30.16 ± 11%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
      3.20 ±  6%     -97.0%       0.10 ± 75%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  8%    +174.5%       0.02 ± 47%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1.83 ± 20%     -95.6%       0.08 ± 21%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.67 ± 38%     -98.4%       0.04 ± 82%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.18 ± 37%     -91.7%       0.01 ± 18%  perf-sched.total_sch_delay.average.ms
     10.22          +205.5%      31.22 ±  9%  perf-sched.total_sch_delay.max.ms
    108.64 ±  6%     -93.1%       7.50 ±  3%  perf-sched.total_wait_and_delay.average.ms
     12100 ±  7%   +1924.9%     245027 ±  4%  perf-sched.total_wait_and_delay.count.ms
      4980           -18.5%       4056 ±  8%  perf-sched.total_wait_and_delay.max.ms
    108.47 ±  6%     -93.1%       7.48 ±  3%  perf-sched.total_wait_time.average.ms
      4980           -18.5%       4056 ±  8%  perf-sched.total_wait_time.max.ms
      7.85           -92.1%       0.62 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    589.78 ±  7%     +28.3%     756.97        perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      1.16 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    500.89           -74.7%     126.73 ± 19%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      1.20 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      6.80 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     47.83 ±  7%     -22.6%      37.00        perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
    109.67 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    602.00 ± 48%     -93.8%      37.33 ±223%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     24.00          +438.9%     129.33 ± 15%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      3099 ±  8%   +3753.2%     119435 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
      3170 ±  8%   +3674.8%     119693 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
     86.33          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    712.00 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1707 ±  2%     +48.8%       2540 ± 19%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    449.67 ±  4%     +20.9%     543.67 ±  5%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4980           -96.7%     166.80 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      5.85 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.96 ± 35%    +145.9%      34.34 ± 34%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
     18.63 ± 16%     +81.2%      33.75 ± 25%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
      7.17 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    479.50 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7.82           -50.2%       3.90 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.25 ±140%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.06 ±147%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
    589.55 ±  7%     +28.4%     756.94        perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.20 ±151%    +304.7%       0.82 ± 29%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.10 ± 31%     -70.5%       0.33 ±  9%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    500.62           -74.7%     126.72 ± 19%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.39 ± 43%    +156.4%       1.00 ± 17%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
      0.40 ± 39%    +150.1%       1.01 ± 17%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
      1.00 ±  8%     -41.3%       0.58 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.21 ± 24%     -98.1%       0.00 ± 38%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      4980           -79.9%       1000        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.15 ±108%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.44 ± 96%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.41 ±152%    +306.1%       1.65 ± 29%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3.88 ±  7%     -66.4%       1.30 ± 27%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.36 ±  5%     -61.1%       2.09 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.67 ± 38%     -98.7%       0.03 ± 71%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open



***************************************************************************************************
lkp-srf-2sp3: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/200%/debian-12-x86_64-20240206.cgz/300s/lkp-srf-2sp3/TCP_MAERTS/netperf

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    306685 ±  2%     +21.9%     373719 ± 12%  meminfo.Mapped
    244930 ± 10%     +37.3%     336267 ± 13%  numa-meminfo.node1.Mapped
     61246 ± 10%     +37.9%      84450 ± 13%  numa-vmstat.node1.nr_mapped
    167630 ±  6%    +620.6%    1207890 ± 20%  vmstat.system.cs
      3.72            +0.4        4.16 ±  2%  mpstat.cpu.all.soft%
      0.79            +0.2        0.94 ±  5%  mpstat.cpu.all.usr%
     77063 ±  2%     +21.6%      93738 ± 12%  proc-vmstat.nr_mapped
 1.337e+09            +4.9%  1.402e+09        proc-vmstat.numa_hit
 1.337e+09            +4.9%  1.402e+09        proc-vmstat.numa_local
 1.068e+10            +4.9%   1.12e+10        proc-vmstat.pgalloc_normal
 1.068e+10            +4.9%   1.12e+10        proc-vmstat.pgfree
      3050            +7.7%       3286 ±  2%  netperf.ThroughputBoth_Mbps
   1171565            +7.7%    1261877 ±  2%  netperf.ThroughputBoth_total_Mbps
      3050            +7.7%       3286 ±  2%  netperf.Throughput_Mbps
   1171565            +7.7%    1261877 ±  2%  netperf.Throughput_total_Mbps
   7775337           +40.3%   10907917 ±  3%  netperf.time.involuntary_context_switches
      9436            -4.7%       8995        netperf.time.percent_of_cpu_this_job_got
     28543            -4.9%      27151        netperf.time.system_time
     81.34           +47.4%     119.87 ±  8%  netperf.time.user_time
  16720953 ± 10%    +928.6%   1.72e+08 ± 21%  netperf.time.voluntary_context_switches
 2.682e+09            +7.7%  2.888e+09 ±  2%  netperf.workload
   3412907 ± 11%     +52.0%    5189109 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.22 ± 12%     -27.3%       0.89 ±  8%  sched_debug.cfs_rq:/.h_nr_queued.min
      0.98 ±  2%     +11.4%       1.09 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.90 ±  2%      +9.9%       0.99 ±  3%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      5114 ±  8%     +21.1%       6193 ± 14%  sched_debug.cfs_rq:/.load.avg
      6126 ± 95%    +197.0%      18194 ± 52%  sched_debug.cfs_rq:/.load.stddev
   3412907 ± 11%     +52.0%    5189109 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
      4874 ±  2%     +11.5%       5437 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    773.27 ±  3%     +15.1%     889.83 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
     93.93 ±  4%     +17.0%     109.92 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
    638.98 ±  2%     +10.5%     706.28 ±  3%  sched_debug.cfs_rq:/.util_est.stddev
    635.15 ± 19%     +79.5%       1140 ±  6%  sched_debug.cpu.clock_task.stddev
    131209 ± 10%     +20.6%     158279 ± 10%  sched_debug.cpu.max_idle_balance_cost.stddev
      1.22 ± 15%     -29.5%       0.86 ±  7%  sched_debug.cpu.nr_running.min
      0.98 ±  2%     +12.0%       1.09 ±  3%  sched_debug.cpu.nr_running.stddev
    144909 ±  7%    +571.8%     973498 ± 20%  sched_debug.cpu.nr_switches.avg
    521657 ± 15%    +739.8%    4380922 ± 24%  sched_debug.cpu.nr_switches.max
     74844 ±  4%     +48.0%     110781 ± 10%  sched_debug.cpu.nr_switches.min
     69526 ± 17%   +1338.8%    1000330 ± 12%  sched_debug.cpu.nr_switches.stddev
     49.95           -15.5%      42.22 ±  4%  perf-stat.i.MPKI
 1.105e+10           +21.2%  1.339e+10 ±  4%  perf-stat.i.branch-instructions
      0.38            +0.0        0.39        perf-stat.i.branch-miss-rate%
  40500273           +25.6%   50848366 ±  5%  perf-stat.i.branch-misses
     57.26            +1.6       58.84        perf-stat.i.cache-miss-rate%
 2.854e+09            +1.6%    2.9e+09        perf-stat.i.cache-misses
  4.98e+09            -1.1%  4.924e+09        perf-stat.i.cache-references
    163743 ±  6%    +636.8%    1206409 ± 20%  perf-stat.i.context-switches
     10.67           -16.8%       8.87 ±  4%  perf-stat.i.cpi
    788.92 ±  2%     +14.7%     904.64 ±  2%  perf-stat.i.cpu-migrations
    215.18            -1.4%     212.21        perf-stat.i.cycles-between-cache-misses
 5.724e+10           +21.3%  6.943e+10 ±  4%  perf-stat.i.instructions
      0.10           +20.4%       0.12 ±  4%  perf-stat.i.ipc
      0.22 ± 32%   +2720.2%       6.27 ± 20%  perf-stat.i.metric.K/sec
     49.87           -16.1%      41.87 ±  4%  perf-stat.overall.MPKI
      0.37            +0.0        0.38        perf-stat.overall.branch-miss-rate%
     57.31            +1.6       58.90        perf-stat.overall.cache-miss-rate%
     10.65           -17.4%       8.80 ±  4%  perf-stat.overall.cpi
    213.53            -1.6%     210.17        perf-stat.overall.cycles-between-cache-misses
      0.09           +21.3%       0.11 ±  4%  perf-stat.overall.ipc
      6443           +12.7%       7263 ±  2%  perf-stat.overall.path-length
 1.099e+10           +21.2%  1.333e+10 ±  4%  perf-stat.ps.branch-instructions
  40255640           +25.6%   50561552 ±  5%  perf-stat.ps.branch-misses
  2.84e+09            +1.6%  2.886e+09        perf-stat.ps.cache-misses
 4.956e+09            -1.1%  4.901e+09        perf-stat.ps.cache-references
    162829 ±  6%    +637.3%    1200587 ± 20%  perf-stat.ps.context-switches
    780.07 ±  2%     +14.8%     895.36 ±  2%  perf-stat.ps.cpu-migrations
 5.695e+10           +21.3%   6.91e+10 ±  4%  perf-stat.ps.instructions
 1.728e+13           +21.5%  2.099e+13 ±  4%  perf-stat.total.instructions
      8.03 ± 18%     -68.8%       2.50 ± 86%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.__sk_flush_backlog.tcp_recvmsg_locked.tcp_recvmsg
      3.67 ±  6%     -12.7%       3.20 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      6.14 ±  4%     -31.8%       4.19 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      1.10 ± 21%     -32.2%       0.75 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.75 ± 12%     -30.9%       1.90 ± 23%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4.24           +28.8%       5.45 ±  8%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
      5.44 ± 65%    +370.0%      25.55 ± 46%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.31 ± 61%   +3846.0%     367.32 ±131%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.27 ± 17%     -37.5%       5.17 ± 22%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1027 ± 67%    +167.7%       2750 ± 46%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     16.86 ± 18%     -75.8%       4.07 ±141%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.__sk_flush_backlog.tcp_recvmsg_locked.tcp_recvmsg
      7.98 ±  6%     -16.4%       6.67 ±  9%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
     12.79 ±  4%     -31.7%       8.73 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     10.53           +20.0%      12.63 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
    162.68 ±  3%     -17.5%     134.19 ±  7%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     21026 ± 11%    +102.8%      42630 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
     97720 ± 35%     +60.6%     156896 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
    168.83 ± 11%     +94.2%     327.83 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
    513.00 ± 71%    +241.3%       1750 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
    378227 ± 19%     +49.1%     563802 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    708.83 ± 46%    +169.1%       1907 ± 18%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    216494 ± 11%     -35.5%     139689 ± 11%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
    196.65 ±128%   +1011.1%       2184 ±101%  perf-sched.wait_and_delay.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      8.84 ± 19%     -58.9%       3.63 ± 61%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.__sk_flush_backlog.tcp_recvmsg_locked.tcp_recvmsg
      4.31 ±  6%     -19.6%       3.46 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      6.64 ±  4%     -31.7%       4.54 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
    338.36 ±139%     -99.3%       2.40 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    143.60 ± 84%     -97.5%       3.60 ± 36%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      6.30           +14.0%       7.18 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
    162.51 ±  3%     -17.7%     133.83 ±  7%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    339.75 ±138%     -98.5%       5.09 ± 67%  perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      1755 ± 41%     +79.6%       3151 ± 28%  perf-sched.wait_time.max.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read



***************************************************************************************************
lkp-gnr-2sp3: 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-gnr-2sp3/pwrite3/will-it-scale

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    495.17 ±  6%     +52.6%     755.67 ±  3%  perf-c2c.DRAM.local
     62494           +29.1%      80709 ±  7%  uptime.idle
 2.241e+09 ±  7%    +817.5%  2.056e+10 ± 28%  cpuidle..time
   2486747 ± 22%    +433.5%   13267360 ± 26%  cpuidle..usage
      3.32 ±  6%    +691.1%      26.29 ± 27%  vmstat.cpu.id
     19982 ± 29%    +299.7%      79871 ± 41%  vmstat.system.cs
   2202934           -10.2%    1979216 ±  4%  meminfo.Active
   2202934           -10.2%    1979216 ±  4%  meminfo.Active(anon)
    174250 ± 19%     -29.1%     123491 ± 13%  meminfo.Mapped
   1358971           -16.0%    1141476 ±  7%  meminfo.Shmem
   3646055 ± 40%     -41.7%    2127009 ± 71%  numa-meminfo.node1.FilePages
    151686 ± 32%     -54.1%      69581 ± 54%  numa-meminfo.node1.Mapped
   1225823 ±  7%     -20.1%     979942 ± 13%  numa-meminfo.node1.Shmem
   2420190 ± 59%     -52.6%    1147007 ±135%  numa-meminfo.node1.Unevictable
    848825 ±  4%     -60.6%     334391 ± 21%  will-it-scale.256.processes
      2.34 ±  9%    +987.8%      25.40 ± 29%  will-it-scale.256.processes_idle
      3315 ±  4%     -60.6%       1305 ± 21%  will-it-scale.per_process_ops
    848825 ±  4%     -60.6%     334391 ± 21%  will-it-scale.workload
    911634 ± 40%     -41.7%     531686 ± 71%  numa-vmstat.node1.nr_file_pages
     38323 ± 32%     -53.8%      17709 ± 53%  numa-vmstat.node1.nr_mapped
    306576 ±  7%     -20.1%     244919 ± 13%  numa-vmstat.node1.nr_shmem
    605047 ± 59%     -52.6%     286751 ±135%  numa-vmstat.node1.nr_unevictable
    605047 ± 59%     -52.6%     286751 ±135%  numa-vmstat.node1.nr_zone_unevictable
      2.83 ±  8%     +23.0       25.79 ± 28%  mpstat.cpu.all.idle%
      0.49            +0.5        0.99 ± 11%  mpstat.cpu.all.irq%
      0.01 ±  4%      +0.1        0.08 ± 34%  mpstat.cpu.all.soft%
     96.56           -23.5       73.07 ± 10%  mpstat.cpu.all.sys%
      0.10 ± 17%      -0.0        0.07 ± 25%  mpstat.cpu.all.usr%
     99.44           -20.1%      79.44 ± 13%  mpstat.max_utilization_pct
    550559           -10.1%     494873 ±  4%  proc-vmstat.nr_active_anon
   1224645            -4.4%    1170439        proc-vmstat.nr_file_pages
     44178 ± 19%     -29.0%      31350 ± 13%  proc-vmstat.nr_mapped
    339576           -16.0%     285368 ±  7%  proc-vmstat.nr_shmem
    129664            -1.6%     127553        proc-vmstat.nr_slab_unreclaimable
    550559           -10.1%     494873 ±  4%  proc-vmstat.nr_zone_active_anon
     19739 ± 61%    +134.0%      46184 ± 19%  proc-vmstat.numa_hint_faults
     12532 ± 64%    +220.6%      40178 ± 20%  proc-vmstat.numa_hint_faults_local
   1799418            -5.2%    1706194        proc-vmstat.numa_hit
   1535263            -6.1%    1442214 ±  2%  proc-vmstat.numa_local
   1929792            -5.6%    1821092        proc-vmstat.pgalloc_normal
      0.08 ±  2%     +28.2%       0.10 ±  5%  perf-stat.i.MPKI
 4.292e+10           -22.9%  3.307e+10 ±  9%  perf-stat.i.branch-instructions
      0.02 ±  2%      +0.0        0.03 ±  3%  perf-stat.i.branch-miss-rate%
   6247563 ±  3%     +14.1%    7127517 ±  5%  perf-stat.i.branch-misses
     20048 ± 29%    +302.4%      80680 ± 41%  perf-stat.i.context-switches
      4.17            -1.7%       4.10        perf-stat.i.cpi
 8.963e+11           -24.2%  6.798e+11 ± 10%  perf-stat.i.cpu-cycles
     58005 ±  2%     -24.2%      43965 ±  5%  perf-stat.i.cycles-between-cache-misses
 2.146e+11           -23.0%  1.652e+11 ±  9%  perf-stat.i.instructions
      0.24            +1.7%       0.25        perf-stat.i.ipc
      0.07 ±  2%     +30.9%       0.10 ±  5%  perf-stat.overall.MPKI
      0.01 ±  3%      +0.0        0.02 ±  5%  perf-stat.overall.branch-miss-rate%
      4.18            -1.6%       4.11        perf-stat.overall.cpi
     57130 ±  2%     -24.6%      43086 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.24            +1.6%       0.24        perf-stat.overall.ipc
  76432035 ±  4%     +99.7%  1.526e+08 ± 11%  perf-stat.overall.path-length
 4.277e+10           -22.9%  3.298e+10 ±  9%  perf-stat.ps.branch-instructions
   6226439 ±  3%     +13.3%    7057144 ±  5%  perf-stat.ps.branch-misses
     19983 ± 29%    +301.2%      80169 ± 41%  perf-stat.ps.context-switches
 8.933e+11           -24.1%  6.779e+11 ± 10%  perf-stat.ps.cpu-cycles
 2.139e+11           -23.0%  1.648e+11 ±  9%  perf-stat.ps.instructions
 6.473e+13           -22.9%  4.989e+13 ±  9%  perf-stat.total.instructions
  36927349           -42.7%   21166906 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.avg
  37069728           -23.2%   28469387 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.max
  29889816 ±  5%     -84.5%    4642664 ± 27%  sched_debug.cfs_rq:/.avg_vruntime.min
    491905 ± 21%   +1883.7%    9757910 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.77 ±  3%     -18.4%       0.63 ± 12%  sched_debug.cfs_rq:/.h_nr_queued.avg
      1.75 ±  7%     -27.0%       1.28 ± 14%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.25 ± 13%     +48.8%       0.37 ± 15%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.77 ±  3%     -18.4%       0.63 ± 12%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      1.64 ± 10%     -27.1%       1.19 ± 18%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.25 ± 13%     +49.4%       0.37 ± 15%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      3852 ±  7%     +20.4%       4636 ± 16%  sched_debug.cfs_rq:/.load.avg
      1.64 ± 14%     -59.3%       0.67 ± 20%  sched_debug.cfs_rq:/.load_avg.min
  36927349           -42.7%   21166906 ± 18%  sched_debug.cfs_rq:/.min_vruntime.avg
  37069728           -23.2%   28469387 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
  29889816 ±  5%     -84.5%    4642664 ± 27%  sched_debug.cfs_rq:/.min_vruntime.min
    491905 ± 21%   +1883.7%    9757910 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.77 ±  3%     -18.1%       0.63 ± 12%  sched_debug.cfs_rq:/.nr_queued.avg
      0.24 ± 16%     +57.1%       0.37 ± 15%  sched_debug.cfs_rq:/.nr_queued.stddev
    790.52 ±  2%     -22.5%     612.40 ± 11%  sched_debug.cfs_rq:/.runnable_avg.avg
      1511 ±  8%     -23.7%       1153 ± 13%  sched_debug.cfs_rq:/.runnable_avg.max
    411.75 ± 19%     -79.8%      83.19 ± 50%  sched_debug.cfs_rq:/.runnable_avg.min
     96.86 ±  4%    +220.8%     310.73 ± 16%  sched_debug.cfs_rq:/.runnable_avg.stddev
    787.67 ±  2%     -22.4%     611.05 ± 11%  sched_debug.cfs_rq:/.util_avg.avg
      1218 ±  8%     -17.8%       1001        sched_debug.cfs_rq:/.util_avg.max
    341.69 ± 29%     -78.0%      75.06 ± 53%  sched_debug.cfs_rq:/.util_avg.min
     89.07 ±  7%    +246.3%     308.43 ± 16%  sched_debug.cfs_rq:/.util_avg.stddev
    738.25 ±  3%     -22.4%     572.51 ± 14%  sched_debug.cfs_rq:/.util_est.avg
      1316 ± 13%     -25.6%     979.92 ±  4%  sched_debug.cfs_rq:/.util_est.max
    223.31 ± 15%     +60.9%     359.21 ± 13%  sched_debug.cfs_rq:/.util_est.stddev
    491.62 ±  2%    +187.3%       1412 ± 28%  sched_debug.cpu.clock_task.stddev
      4763 ±  3%     -18.3%       3892 ± 12%  sched_debug.cpu.curr->pid.avg
      1464 ± 15%     +56.2%       2286 ± 15%  sched_debug.cpu.curr->pid.stddev
   1225968           -39.6%     740896 ±  4%  sched_debug.cpu.max_idle_balance_cost.avg
    689300 ±  8%     -27.5%     500000        sched_debug.cpu.max_idle_balance_cost.min
    195813 ±  5%     +47.2%     288179 ±  4%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.77 ±  3%     -18.7%       0.63 ± 12%  sched_debug.cpu.nr_running.avg
      1.75 ±  7%     -19.0%       1.42 ± 13%  sched_debug.cpu.nr_running.max
      0.25 ± 13%     +50.6%       0.38 ± 15%  sched_debug.cpu.nr_running.stddev
     13387 ± 25%    +238.9%      45364 ± 31%  sched_debug.cpu.nr_switches.avg
    114155 ± 48%    +174.0%     312755 ± 72%  sched_debug.cpu.nr_switches.max
      8431 ± 20%     -80.3%       1658 ± 11%  sched_debug.cpu.nr_switches.min
      7889 ± 43%    +872.9%      76756 ± 60%  sched_debug.cpu.nr_switches.stddev
      0.07 ± 32%    +194.9%       0.22 ± 35%  sched_debug.cpu.nr_uninterruptible.avg
      0.01 ±  9%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.23 ± 85%     -96.7%       0.01 ±145%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.36 ± 49%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.30 ± 52%     -97.7%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.71 ± 56%     -98.8%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.05 ± 50%     -81.0%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.01 ± 60%     -78.5%       0.00 ± 13%  perf-sched.sch_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.26 ± 57%     -90.5%       0.02 ±158%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.08 ± 44%     -85.2%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ±158%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.02 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.36 ± 30%     -89.4%       0.04 ± 71%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.21 ± 22%     -96.2%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 18%     -62.9%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 13%     +50.0%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 59%     -71.9%       0.01 ± 57%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.02 ±  9%    +240.0%       0.05 ± 13%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 16%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      2.14 ± 77%     -99.0%       0.02 ±143%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      2.29 ± 56%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      2.48 ± 45%     -99.6%       0.01 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.16 ± 55%     -99.3%       0.02 ± 20%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.62 ± 41%     -98.7%       0.03 ± 26%  perf-sched.sch_delay.max.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      2.57 ± 19%     -71.3%       0.74 ± 56%  perf-sched.sch_delay.max.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      2.83 ± 31%     -97.0%       0.09 ±145%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.71 ± 28%     -98.3%       0.05 ± 48%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.67 ±161%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.07 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      2.85 ± 28%     -82.0%       0.51 ± 91%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      3.34 ± 11%     -98.3%       0.06 ±104%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.16 ± 17%     -97.6%       0.05 ± 66%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.93 ± 78%     -86.3%       0.13 ±172%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     27.34 ± 17%     -48.8%      14.01 ± 18%  perf-sched.total_wait_and_delay.average.ms
     62576 ± 18%    +137.2%     148418 ± 18%  perf-sched.total_wait_and_delay.count.ms
     27.26 ± 16%     -48.7%      13.98 ± 18%  perf-sched.total_wait_time.average.ms
    133.01 ± 28%     +58.5%     210.76 ±  3%  perf-sched.wait_and_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.95 ± 17%    +224.8%       3.10 ± 19%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.shmem_file_write_iter
     15.33 ± 19%     -90.2%       1.50 ± 74%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    333.33 ± 32%     -42.5%     191.67 ±  3%  perf-sched.wait_and_delay.count.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
     54177 ± 20%    +161.2%     141513 ± 19%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.shmem_file_write_iter
    633.67 ±  3%     -66.8%     210.17 ±141%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1948           +12.6%       2195        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    477.50 ±  3%     -41.3%     280.17 ± 12%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1.85 ± 22%    +185.4%       5.28 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     59.14 ±179%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    132.96 ± 28%     +58.5%     210.75 ±  3%  perf-sched.wait_time.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.08 ± 93%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.87 ± 15%    +251.6%       3.06 ± 19%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.shmem_file_write_iter
      1.03 ± 16%     -33.3%       0.69 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.04 ± 65%     -82.7%       0.01 ±105%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.02 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     10.21 ± 23%     -27.4%       7.42 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
    525.30 ±141%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      1000           -99.3%       7.28 ±  6%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.46 ±104%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     11.93 ± 16%     -27.6%       8.63 ±  8%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.shmem_file_write_iter
     17.21 ± 67%     -84.1%       2.74 ± 10%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.93 ± 78%     -86.3%       0.13 ±172%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     98.85            -2.2       96.62        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.down_write.shmem_file_write_iter.vfs_write
     99.22            -1.4       97.82        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
     99.28            -1.4       97.92        perf-profile.calltrace.cycles-pp.down_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
     99.64            -0.5       99.12        perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     99.66            -0.5       99.14        perf-profile.calltrace.cycles-pp.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     99.66            -0.5       99.14        perf-profile.calltrace.cycles-pp.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     99.72            -0.5       99.22        perf-profile.calltrace.cycles-pp.__libc_pwrite
     99.72            -0.5       99.22        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     99.71            -0.5       99.21        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      0.53 ±  2%      +0.8        1.33 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.osq_lock.rwsem_down_write_slowpath.down_write.shmem_file_write_iter
      0.43 ± 44%      +0.9        1.31 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.rwsem_down_write_slowpath.down_write
      0.00            +0.9        0.93 ± 43%  perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
      0.25 ±100%      +1.0        1.28 ± 11%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.rwsem_down_write_slowpath
      0.00            +1.1        1.05 ± 39%  perf-profile.calltrace.cycles-pp.up_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      0.00            +1.1        1.06 ± 12%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.17 ±141%      +1.1        1.28 ± 11%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock
      0.00            +1.1        1.11 ± 11%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.1        1.12 ± 11%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     98.87            -2.2       96.64        perf-profile.children.cycles-pp.osq_lock
     99.22            -1.4       97.83        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     99.28            -1.4       97.92        perf-profile.children.cycles-pp.down_write
     99.66            -0.5       99.14        perf-profile.children.cycles-pp.__x64_sys_pwrite64
     99.74            -0.5       99.23        perf-profile.children.cycles-pp.__libc_pwrite
     99.72            -0.4       99.30        perf-profile.children.cycles-pp.shmem_file_write_iter
     99.74            -0.4       99.33        perf-profile.children.cycles-pp.vfs_write
     99.82            -0.4       99.44        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.81            -0.4       99.44        perf-profile.children.cycles-pp.do_syscall_64
      0.14 ±  8%      +0.1        0.20 ± 18%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.idle_cpu
      0.05            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      0.06 ±  7%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.get_jiffies_update
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.06 ±  7%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.05            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.07 ± 10%      +0.1        0.15 ± 10%  perf-profile.children.cycles-pp.copy_folio_from_iter_atomic
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.kick_ilb
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.update_curr
      0.07 ± 21%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.07 ± 16%      +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.19 ±  6%      +0.1        0.30 ±  7%  perf-profile.children.cycles-pp.generic_perform_write
      0.09 ± 20%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.wake_q_add
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.update_load_avg
      0.13 ±  9%      +0.1        0.25 ± 14%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.12 ± 34%  perf-profile.children.cycles-pp.handle_softirqs
      0.11 ± 17%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.writen
      0.10 ± 20%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.write
      0.10 ± 19%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.record__pushfn
      0.00            +0.1        0.12 ± 30%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.1        0.14 ± 22%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.14 ± 21%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.15 ± 20%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.00            +0.2        0.15 ± 22%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.00            +0.2        0.16 ± 29%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.2        0.16 ± 20%  perf-profile.children.cycles-pp.sched_balance_rq
      0.00            +0.2        0.17 ± 28%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.2        0.17 ± 19%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.2        0.18 ± 20%  perf-profile.children.cycles-pp.__pick_next_task
      0.05 ± 45%      +0.2        0.23 ± 18%  perf-profile.children.cycles-pp.try_to_wake_up
      0.06 ± 11%      +0.2        0.26 ± 19%  perf-profile.children.cycles-pp.wake_up_q
      0.21 ± 17%      +0.2        0.44 ±  6%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.pv_native_safe_halt
      0.20 ±  6%      +0.2        0.43 ± 10%  perf-profile.children.cycles-pp.task_tick_fair
      0.22 ± 18%      +0.2        0.45 ±  6%  perf-profile.children.cycles-pp.handle_internal_command
      0.22 ± 18%      +0.2        0.45 ±  6%  perf-profile.children.cycles-pp.main
      0.22 ± 18%      +0.2        0.45 ±  6%  perf-profile.children.cycles-pp.run_builtin
      0.22 ± 19%      +0.2        0.44 ±  6%  perf-profile.children.cycles-pp.__cmd_record
      0.22 ± 19%      +0.2        0.44 ±  6%  perf-profile.children.cycles-pp.cmd_record
      0.22 ± 19%      +0.2        0.44 ±  6%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.00            +0.2        0.23 ± 19%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.00            +0.2        0.24 ± 17%  perf-profile.children.cycles-pp.schedule
      0.00            +0.2        0.25 ± 25%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.02 ±141%      +0.3        0.27 ± 17%  perf-profile.children.cycles-pp.__schedule
      0.00            +0.3        0.26 ± 20%  perf-profile.children.cycles-pp.start_secondary
      0.00            +0.3        0.26 ± 29%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.00            +0.3        0.29 ± 24%  perf-profile.children.cycles-pp.common_startup_64
      0.00            +0.3        0.29 ± 24%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.00            +0.3        0.29 ± 24%  perf-profile.children.cycles-pp.do_idle
      0.25 ±  5%      +0.3        0.54 ±  9%  perf-profile.children.cycles-pp.sched_tick
      0.00            +0.5        0.46 ± 51%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.09 ± 15%      +0.6        0.69 ± 52%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.39 ±  3%      +0.7        1.11 ± 12%  perf-profile.children.cycles-pp.update_process_times
      0.41 ±  3%      +0.8        1.16 ± 12%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.42 ±  2%      +0.8        1.17 ± 12%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.15 ± 11%      +0.8        0.94 ± 44%  perf-profile.children.cycles-pp.rwsem_wake
      0.22 ±  7%      +0.8        1.06 ± 38%  perf-profile.children.cycles-pp.up_write
      0.50 ±  2%      +0.8        1.35 ± 11%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.50 ±  2%      +0.8        1.34 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.52 ±  2%      +0.9        1.39 ± 11%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.54 ±  2%      +0.9        1.42 ± 11%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.02 ±141%      +1.0        0.97 ± 58%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     98.34            -3.0       95.31        perf-profile.self.cycles-pp.osq_lock
      0.07 ±  6%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.up_write
      0.14 ±  8%      +0.1        0.20 ± 17%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.update_load_avg
      0.06 ± 19%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06 ±  7%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.get_jiffies_update
      0.08 ±  8%      +0.1        0.16 ± 14%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.07 ± 11%      +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.copy_folio_from_iter_atomic
      0.00            +0.1        0.10 ± 20%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.wake_q_add
      0.13 ±  9%      +0.1        0.24 ± 15%  perf-profile.self.cycles-pp.update_cfs_group
      0.06 ± 50%      +0.1        0.17 ±  9%  perf-profile.self.cycles-pp.ring_buffer_read_head
      0.01 ±223%      +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.2        0.21 ± 25%  perf-profile.self.cycles-pp.nohz_balancer_kick
      0.02 ±141%      +1.0        0.97 ± 58%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/timer/stress-ng/60s

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 8.839e+08 ±  8%     -34.0%  5.835e+08 ± 18%  cpuidle..time
    374076           -22.0%     291744 ±  8%  cpuidle..usage
   4380694 ±  5%     -37.1%    2755939 ±  4%  numa-numastat.node1.local_node
   4513772 ±  4%     -35.4%    2915575 ±  5%  numa-numastat.node1.numa_hit
    831.83 ± 48%    +357.4%       3804 ±  5%  perf-c2c.DRAM.local
     50467 ±  7%     -94.1%       2992 ± 10%  perf-c2c.HITM.local
     51333 ±  7%     -92.2%       4001 ±  9%  perf-c2c.HITM.total
     58.62 ±  2%    +195.9%     173.43        vmstat.procs.r
  14909196          +289.6%   58088357        vmstat.system.cs
  17927003          +261.9%   64878409        vmstat.system.in
      7.56 ±  8%      -3.8        3.80 ± 15%  mpstat.cpu.all.idle%
     74.80           -49.3       25.52        mpstat.cpu.all.irq%
      0.12            +1.0        1.07        mpstat.cpu.all.soft%
     14.42 ±  2%     +46.7       61.14        mpstat.cpu.all.sys%
      3.10            +5.4        8.46        mpstat.cpu.all.usr%
  11720320 ±  3%     -36.0%    7506290 ±  5%  meminfo.Active
  11720320 ±  3%     -36.0%    7506290 ±  5%  meminfo.Active(anon)
  14500482 ±  2%     -30.1%   10137930 ±  3%  meminfo.Cached
  13718912 ±  2%     -31.9%    9341814 ±  4%  meminfo.Committed_AS
    890402 ±  3%     -15.3%     753873 ±  4%  meminfo.Mapped
  18655774           -22.5%   14456476 ±  3%  meminfo.Memused
  10939477 ±  3%     -39.9%    6576917 ±  6%  meminfo.Shmem
  18813194           -22.3%   14611140 ±  3%  meminfo.max_used_kB
   2878970 ±  3%     -37.3%    1805638 ±  5%  numa-vmstat.node1.nr_active_anon
    145499 ± 16%     +27.8%     185994 ± 13%  numa-vmstat.node1.nr_anon_pages
   3426306 ±  8%     -44.5%    1900170 ± 18%  numa-vmstat.node1.nr_file_pages
    218920 ±  3%     -28.1%     157490 ± 19%  numa-vmstat.node1.nr_mapped
   2733686 ±  3%     -40.7%    1619835 ±  5%  numa-vmstat.node1.nr_shmem
   2878963 ±  3%     -37.3%    1805632 ±  5%  numa-vmstat.node1.nr_zone_active_anon
   4513028 ±  4%     -35.4%    2914516 ±  5%  numa-vmstat.node1.numa_hit
   4379950 ±  5%     -37.1%    2754880 ±  4%  numa-vmstat.node1.numa_local
  20328031 ±  3%     -79.3%    4210756 ±  4%  stress-ng.time.involuntary_context_switches
    122804            -2.7%     119428        stress-ng.time.minor_page_faults
      3225          +291.3%      12621        stress-ng.time.percent_of_cpu_this_job_got
      1682          +300.9%       6745        stress-ng.time.system_time
    258.08          +228.2%     847.00        stress-ng.time.user_time
 4.978e+08          +274.5%  1.864e+09        stress-ng.time.voluntary_context_switches
 5.565e+08          +271.0%  2.064e+09        stress-ng.timer.ops
   9278066          +270.9%   34416857        stress-ng.timer.ops_per_sec
  11504678 ±  3%     -37.2%    7230485 ±  5%  numa-meminfo.node1.Active
  11504678 ±  3%     -37.2%    7230485 ±  5%  numa-meminfo.node1.Active(anon)
     23268 ± 62%    +349.7%     104639 ± 96%  numa-meminfo.node1.AnonHugePages
    581787 ± 16%     +27.9%     744372 ± 13%  numa-meminfo.node1.AnonPages
    677481 ± 13%     +24.4%     842680 ± 12%  numa-meminfo.node1.AnonPages.max
  13694251 ±  8%     -44.4%    7608213 ± 18%  numa-meminfo.node1.FilePages
    872038 ±  3%     -27.4%     632983 ± 19%  numa-meminfo.node1.Mapped
  15974582 ±  7%     -37.5%    9978910 ± 14%  numa-meminfo.node1.MemUsed
  10923766 ±  3%     -40.6%    6486872 ±  5%  numa-meminfo.node1.Shmem
   2932299 ±  3%     -36.1%    1873947 ±  5%  proc-vmstat.nr_active_anon
   3627304 ±  2%     -30.2%    2531584 ±  3%  proc-vmstat.nr_file_pages
    223399 ±  3%     -15.3%     189137 ±  4%  proc-vmstat.nr_mapped
   2737051 ±  3%     -40.0%    1641331 ±  5%  proc-vmstat.nr_shmem
     45179            -5.5%      42672        proc-vmstat.nr_slab_reclaimable
   2932299 ±  3%     -36.1%    1873947 ±  5%  proc-vmstat.nr_zone_active_anon
    170124 ± 10%     +36.4%     232098 ± 20%  proc-vmstat.numa_hint_faults
    145600 ± 12%     +47.9%     215383 ± 20%  proc-vmstat.numa_hint_faults_local
   4945216 ±  2%     -30.7%    3428845 ±  4%  proc-vmstat.numa_hit
   4710249 ±  2%     -32.1%    3196862 ±  5%  proc-vmstat.numa_local
   5006509 ±  2%     -29.4%    3533388 ±  5%  proc-vmstat.pgalloc_normal
     31295 ±  2%      -9.6%      28276 ±  4%  proc-vmstat.pgreuse
      0.13 ±  2%     -64.8%       0.05 ±  7%  perf-stat.i.MPKI
  3.78e+10          +167.0%  1.009e+11        perf-stat.i.branch-instructions
      0.31            -0.1        0.18 ±  2%  perf-stat.i.branch-miss-rate%
  1.08e+08           +50.1%   1.62e+08 ±  2%  perf-stat.i.branch-misses
     10.00 ±  3%     +12.7       22.74 ±  5%  perf-stat.i.cache-miss-rate%
  25169188 ±  2%     -26.1%   18610547 ±  9%  perf-stat.i.cache-misses
 2.052e+08           -66.1%   69542808 ±  6%  perf-stat.i.cache-references
  15495581          +292.9%   60874742        perf-stat.i.context-switches
      3.39           -63.6%       1.23        perf-stat.i.cpi
 6.179e+11            +2.9%  6.361e+11        perf-stat.i.cpu-cycles
     32444 ±  4%     -58.8%      13369 ± 10%  perf-stat.i.cpu-migrations
     48598 ±  5%     +32.2%      64230 ± 16%  perf-stat.i.cycles-between-cache-misses
 1.853e+11          +182.2%  5.229e+11        perf-stat.i.instructions
      0.30          +171.0%       0.82        perf-stat.i.ipc
     69.14          +293.0%     271.70        perf-stat.i.metric.K/sec
      0.14 ±  3%     -78.8%       0.03 ± 45%  perf-stat.overall.MPKI
      0.29            -0.2        0.13 ± 44%  perf-stat.overall.branch-miss-rate%
      3.33           -69.5%       1.02 ± 44%  perf-stat.overall.cpi
  24822910 ±  3%     -40.2%   14833984 ± 45%  perf-stat.ps.cache-misses
 2.018e+08           -72.4%   55793889 ± 45%  perf-stat.ps.cache-references
     31979 ±  4%     -66.6%      10693 ± 45%  perf-stat.ps.cpu-migrations
    422827          +586.9%    2904535        sched_debug.cfs_rq:/.avg_vruntime.avg
   1494052 ±  8%    +167.2%    3992568 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.max
    106476 ±  2%   +2450.1%    2715268 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
    139865 ±  6%     -23.6%     106906 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.45 ±  4%     -22.9%       0.35 ±  7%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.31 ±  4%     +11.5%       0.35 ±  4%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.44 ±  4%     -23.3%       0.34 ±  8%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.32 ±  4%      +9.0%       0.35 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
    150427 ±  6%     +73.4%     260771 ± 28%  sched_debug.cfs_rq:/.left_deadline.avg
   1011330 ± 32%    +201.1%    3044655 ±  2%  sched_debug.cfs_rq:/.left_deadline.max
    207464 ±  5%    +294.8%     819064 ± 13%  sched_debug.cfs_rq:/.left_deadline.stddev
    150380 ±  6%     +73.4%     260748 ± 28%  sched_debug.cfs_rq:/.left_vruntime.avg
   1011176 ± 32%    +201.1%    3044403 ±  2%  sched_debug.cfs_rq:/.left_vruntime.max
    207402 ±  5%    +294.9%     818991 ± 13%  sched_debug.cfs_rq:/.left_vruntime.stddev
      6671 ± 10%     -62.1%       2525 ±  9%  sched_debug.cfs_rq:/.load.avg
    115596 ±165%     -82.8%      19918 ± 13%  sched_debug.cfs_rq:/.load.max
    422827          +586.9%    2904535        sched_debug.cfs_rq:/.min_vruntime.avg
   1494052 ±  8%    +167.2%    3992568 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
    106476 ±  2%   +2450.1%    2715268 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
    139865 ±  6%     -23.6%     106906 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.45 ±  2%     -28.7%       0.32 ± 11%  sched_debug.cfs_rq:/.nr_queued.avg
      0.27 ±  4%     +24.3%       0.34 ±  4%  sched_debug.cfs_rq:/.nr_queued.stddev
    150380 ±  6%     +73.4%     260748 ± 28%  sched_debug.cfs_rq:/.right_vruntime.avg
   1011176 ± 32%    +201.1%    3044403 ±  2%  sched_debug.cfs_rq:/.right_vruntime.max
    207402 ±  5%    +294.9%     818991 ± 13%  sched_debug.cfs_rq:/.right_vruntime.stddev
    243.60 ±  4%     +73.1%     421.68        sched_debug.cfs_rq:/.runnable_avg.avg
      1043 ±  2%     +15.4%       1204 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
      1.75 ±177%  +13161.9%     232.08 ± 50%  sched_debug.cfs_rq:/.runnable_avg.min
    165.57 ±  6%     -14.7%     141.26 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    188.04 ±  5%    +122.3%     418.02        sched_debug.cfs_rq:/.util_avg.avg
      1042 ±  2%     +14.3%       1191 ±  5%  sched_debug.cfs_rq:/.util_avg.max
      1.00 ±165%  +22908.3%     230.08 ± 50%  sched_debug.cfs_rq:/.util_avg.min
    163.44 ±  5%     -13.9%     140.64 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
    362.91 ±  3%     -18.1%     297.06 ±  3%  sched_debug.cfs_rq:/.util_est.avg
      1212 ±  5%     -23.4%     929.25 ± 12%  sched_debug.cfs_rq:/.util_est.max
   2932116 ±  2%     -44.9%    1616135 ± 22%  sched_debug.cpu.avg_idle.max
    351856 ± 10%     -36.7%     222709 ± 11%  sched_debug.cpu.avg_idle.stddev
     68743 ±  3%     +11.8%      76828 ±  2%  sched_debug.cpu.clock_task.avg
     54408 ±  4%     +14.8%      62434 ±  3%  sched_debug.cpu.clock_task.min
      1299 ±  5%     -18.2%       1062        sched_debug.cpu.clock_task.stddev
      1737 ±  2%     +49.0%       2587 ±  2%  sched_debug.cpu.curr->pid.avg
   1026070           -26.7%     752086        sched_debug.cpu.max_idle_balance_cost.avg
    663991 ± 11%     -24.7%     500000        sched_debug.cpu.max_idle_balance_cost.min
    138202 ± 11%     +81.9%     251453 ±  4%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 10%    +147.3%       0.00 ± 60%  sched_debug.cpu.next_balance.stddev
      0.11 ± 13%    +273.0%       0.43 ±  2%  sched_debug.cpu.nr_running.avg
   2070582          +293.3%    8144031        sched_debug.cpu.nr_switches.avg
   3165060 ± 12%    +180.5%    8877583        sched_debug.cpu.nr_switches.max
      2619 ± 10%  +1.2e+05%    3246312 ±  9%  sched_debug.cpu.nr_switches.min
    299563 ±  3%     +78.0%     533152 ±  5%  sched_debug.cpu.nr_switches.stddev



***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/min-nanosleep/stress-ng/60s

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    798405 ±  3%      +2.9%     821573        vmstat.system.cs
      2.86 ±  4%      -2.1        0.73        mpstat.cpu.all.irq%
      1.10 ±  3%      -0.5        0.65 ±  2%  mpstat.cpu.all.sys%
      9026 ±  2%      -9.5%       8166        sched_debug.cfs_rq:/.avg_vruntime.avg
      9026 ±  2%      -9.5%       8166        sched_debug.cfs_rq:/.min_vruntime.avg
    212.91 ±  3%     -10.0%     191.61 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
      9680 ±  6%     -70.7%       2832 ±  6%  perf-c2c.DRAM.remote
     25889           -86.5%       3500 ±  8%  perf-c2c.HITM.local
      6625 ±  4%     -75.7%       1612 ±  7%  perf-c2c.HITM.remote
     32514           -84.3%       5112 ±  3%  perf-c2c.HITM.total
     72248            +2.3%      73879        stress-ng.min-nanosleep.ops
      1203            +2.3%       1231        stress-ng.min-nanosleep.ops_per_sec
     51.50           -14.6%      44.00        stress-ng.time.percent_of_cpu_this_job_got
     25.69           -22.6%      19.88        stress-ng.time.system_time
  25427905            +2.3%   26004874        stress-ng.time.voluntary_context_switches
      0.01 ±  8%     -30.8%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 11%     -20.0%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.00 ± 11%     -55.6%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 10%     -42.4%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ±157%     -77.9%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      0.01 ±  7%     -36.4%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.03 ± 24%     -59.1%       0.01 ± 35%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.21 ±202%     -94.8%       0.01 ± 25%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      0.00 ± 11%     -55.6%       0.00        perf-sched.total_sch_delay.average.ms
    210.45 ±  5%      -9.4%     190.66 ±  5%  perf-sched.wait_and_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
    331.12 ±  9%     +16.7%     386.42 ±  7%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1087 ±  5%     -15.5%     918.33 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3884 ± 13%     -23.1%       2986 ± 17%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    210.44 ±  5%      -9.4%     190.66 ±  5%  perf-sched.wait_time.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.05 ±157%     -77.9%       0.01 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
    331.11 ±  9%     +16.7%     386.41 ±  7%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.21 ±202%     -94.8%       0.01 ± 25%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      3884 ± 13%     -23.1%       2986 ± 17%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.23 ±  8%     -20.1%       0.99 ± 10%  perf-stat.i.MPKI
 2.343e+09 ±  2%     -11.2%  2.081e+09        perf-stat.i.branch-instructions
  47874283 ±  2%      -9.4%   43364196        perf-stat.i.branch-misses
     23.05 ±  6%     +15.8       38.81 ±  6%  perf-stat.i.cache-miss-rate%
  14180414 ±  8%     -21.5%   11128252 ±  9%  perf-stat.i.cache-misses
  54095888 ±  3%     -59.0%   22190233 ±  3%  perf-stat.i.cache-references
    829020 ±  2%      +3.4%     857028        perf-stat.i.context-switches
      2.16           -25.0%       1.62        perf-stat.i.cpi
 2.267e+10 ±  2%     -32.3%  1.535e+10        perf-stat.i.cpu-cycles
      2865 ±  4%     +55.4%       4453 ±  5%  perf-stat.i.cycles-between-cache-misses
 1.126e+10 ±  2%     -10.4%  1.009e+10        perf-stat.i.instructions
      0.50           +29.2%       0.64        perf-stat.i.ipc
     12.95 ±  2%      +3.4%      13.39        perf-stat.i.metric.K/sec
      2.04            +0.0        2.08        perf-stat.overall.branch-miss-rate%
     26.21 ±  7%     +23.9       50.06 ±  6%  perf-stat.overall.cache-miss-rate%
      2.01 ±  2%     -24.5%       1.52        perf-stat.overall.cpi
      1608 ±  6%     -13.6%       1389 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.50 ±  2%     +32.4%       0.66        perf-stat.overall.ipc
 2.305e+09 ±  2%     -11.2%  2.047e+09        perf-stat.ps.branch-instructions
  47097166 ±  2%      -9.4%   42662359        perf-stat.ps.branch-misses
  13943941 ±  8%     -21.5%   10946497 ±  9%  perf-stat.ps.cache-misses
  53209541 ±  3%     -59.0%   21830983 ±  3%  perf-stat.ps.cache-references
    815603 ±  2%      +3.4%     843028        perf-stat.ps.context-switches
  2.23e+10 ±  2%     -32.3%   1.51e+10        perf-stat.ps.cpu-cycles
 1.108e+10 ±  2%     -10.4%  9.927e+09        perf-stat.ps.instructions
 6.878e+11           -11.6%  6.081e+11        perf-stat.total.instructions



***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/switch/stress-ng/60s

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    743461           +12.7%     838242 ±  8%  meminfo.Mapped
      2.12            -0.2        1.89        mpstat.cpu.all.irq%
     10845           +11.6%      12103 ±  9%  uptime.idle
    186621           +11.9%     208920 ±  8%  proc-vmstat.nr_mapped
    858832            +5.8%     908319 ±  4%  proc-vmstat.pgfault
     24656 ± 11%   +1747.2%     455454 ± 77%  sched_debug.cfs_rq:/.load.max
    122.86 ±  5%     +17.4%     144.19 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
   2649501 ± 10%     +16.4%    3084791 ± 11%  numa-vmstat.node1.nr_file_pages
    136293 ± 21%     +29.2%     176049 ± 22%  numa-vmstat.node1.nr_mapped
     18637 ± 25%     +46.2%      27244 ± 18%  numa-vmstat.node1.nr_slab_reclaimable
  10586514 ± 10%     +16.7%   12354729 ± 11%  numa-meminfo.node1.FilePages
     74512 ± 25%     +46.3%     109039 ± 18%  numa-meminfo.node1.KReclaimable
    541917 ± 21%     +30.7%     708183 ± 21%  numa-meminfo.node1.Mapped
  12771253 ±  9%     +13.9%   14550141 ± 10%  numa-meminfo.node1.MemUsed
     74512 ± 25%     +46.3%     109039 ± 18%  numa-meminfo.node1.SReclaimable
    267327 ± 12%     +21.0%     323424 ±  8%  numa-meminfo.node1.Slab
     15650            -9.0%      14241 ±  2%  stress-ng.switch.nanosecs_per_context_switch_pipe_method
 8.583e+08           +10.0%  9.438e+08 ±  2%  stress-ng.switch.ops
  14311754           +10.0%   15738006 ±  2%  stress-ng.switch.ops_per_sec
  68162389           +10.3%   75160292 ±  7%  stress-ng.time.involuntary_context_switches
     14828            +1.0%      14978        stress-ng.time.percent_of_cpu_this_job_got
      8284            +1.1%       8378        stress-ng.time.system_time
 1.484e+09            +1.6%  1.507e+09        stress-ng.time.voluntary_context_switches
 6.215e+10            -3.1%  6.023e+10        perf-stat.i.branch-instructions
 5.429e+08            -2.6%  5.287e+08        perf-stat.i.branch-misses
  4.73e+09            +1.5%  4.801e+09        perf-stat.i.cache-references
  40304510            +2.1%   41144079        perf-stat.i.context-switches
      2.01            +3.7%       2.09        perf-stat.i.cpi
 3.101e+11            -2.8%  3.013e+11        perf-stat.i.instructions
      0.52            -3.0%       0.50        perf-stat.i.ipc
    218.21            +1.7%     221.87        perf-stat.i.metric.K/sec
      0.11            +4.4%       0.11        perf-stat.overall.MPKI
      1.94            +3.6%       2.01        perf-stat.overall.cpi
      0.51            -3.5%       0.50        perf-stat.overall.ipc
 6.104e+10            -4.3%  5.842e+10        perf-stat.ps.branch-instructions
 5.329e+08            -3.0%  5.167e+08        perf-stat.ps.branch-misses
 4.645e+09            +1.2%  4.702e+09        perf-stat.ps.cache-references
  39587505            +1.8%   40301573        perf-stat.ps.context-switches
 3.045e+11            -4.0%  2.923e+11        perf-stat.ps.instructions
 1.867e+13            -5.3%  1.769e+13 ±  2%  perf-stat.total.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


