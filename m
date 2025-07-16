Return-Path: <linux-kernel+bounces-732719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F62FB06B31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B18563881
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247F2652A4;
	Wed, 16 Jul 2025 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3aSMHEx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461178F4C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629720; cv=fail; b=jWzg907pncYlJA5fFEVCn/ceXMEWhHXTHLZb8TyThcjncdC6jO1hTuY+4RjtR9EOPLWwOsqdMB5gbm0y/O2MG420izIt/pL6UZRx+kAVZOgkCpsR7WrXmP3NSi1e4e2UUSF9SOXDWLm8/4GzFZaLMCsXUWXUMNNcPt5mQKyEveI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629720; c=relaxed/simple;
	bh=6cjyyuQO4WejWsJkPf6TxcvHPPO2YR+1+naQ7ckqEiM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HgSw0JRu4LuNX/7mKutOftuNHI/Jio4BLx/9P3YcGVTYL6QRrBzNyQoKfw5KdfxRLLyPtVaWd4uw+ScxUJ45sgEQm+Lb/EcclkcruSDm5UYWTgFqHWb6jJ7A5Z6xLURPQnJ+rpG1+p3jNw9+4ktp7fZJ9otNlZJ0iY3g5UApU8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3aSMHEx; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752629717; x=1784165717;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6cjyyuQO4WejWsJkPf6TxcvHPPO2YR+1+naQ7ckqEiM=;
  b=N3aSMHEx3chEAvqq8DjmnL4vZpp4ePebdvLqFky1NmtdVfloQzGRYrEg
   3SWqJXi4ZOHtT/aN66nC4F7y0M7gkembTydrA9YGDFhKY95mrLzmWbvKx
   43iZ8UFIwvTasieoFJnjmWYnRfvtuQu/sGAdAz4L8m79x4mC5y3b1T4wr
   CXSz8X27POKpPduzSDa9eWc6+5RMDp+c+t3VTo14gTZ8l/vIQQmnAknar
   zt3pfwvFkkceM7Jy0hXDCm1x2CXQl/VTKoLJ27FfgcV+4qKhevSC9WYQI
   Wrj5B0Jtf1HgW4Nw4klHNBRosTEtMkIyb02rOqeo4pU+Dm09+IIEqnDYN
   Q==;
X-CSE-ConnectionGUID: ov84iPp/TTuefZP8X5T+/w==
X-CSE-MsgGUID: M/Zy2Os7S+OWpKDfTb3vLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65929232"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="65929232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 18:35:17 -0700
X-CSE-ConnectionGUID: NBBtNHxUSXqdi8jCI9ErIQ==
X-CSE-MsgGUID: mSXjk9m1Td2zAuL38Kn+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="194507076"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 18:35:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 18:35:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 18:35:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 18:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyvDFickZteCS1EU4Dv5HI+DLKYpBvPQY8dNKwrfysyK1g49TaJErKRspYN5CLxMrJV5EsznCQfDqFrEJidR6bI4mMl6nGjdsy7KsialGd8y79/YRgMH9FHPoNz1eF25up/np5giyN1KVfH8zUhisW8pyYSsmv/65j2haotC84TvZyuknN+IWIK5QhUjjfMEr99Ja0gpsmQXnn4ie30TOO+KDJwV7Lmw0NHgpq2IOtp/ieE8nCgKZe8E/uZgtQji97SJiV6adRHdWXsOuxPGWaNeYdH80gs1jLymKuXwQN3fefYy8nu+VQ8i6qpS7R+nLkvLimka1oSRU3tFtXPh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsCv25zFTtF7qB2Hwv5ClSvsYW3kf15qtquWueNpDgs=;
 b=acOFAYmrrASnP/xxSPPU9iqsJzZ1RFEYY4tmZ64ZP7cjr1Rpm6rFZx/z4Y52ribnpNCynJb8EaKnl7yBlRor9L6NR8L8jmfLV6+LQTVG8MZCW4Itn9ybwiN6ROg7cmUpDa3rdAFsDZVpcVqZZvdJfhGSCGPdogK86c6n2ofA6JdZ+U4MNCpiBDBGZcburN4J314jkGQueb8A0s/q62VUxmqr4kif2rhgGnwtUBuCLJm2sS1PCvNfmggtblI4OeUHidUzhmfD8hO6LsNPZMW+GTisyBK/p+S8bB/v7mgI8T9+w17DTKXYrOjvnmoIICsE8/R9gL0Dn1ZVM/D0lpfLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB7951.namprd11.prod.outlook.com (2603:10b6:8:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 01:34:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Wed, 16 Jul 2025
 01:34:33 +0000
Date: Wed, 16 Jul 2025 09:34:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Chris Mason <clm@meta.com>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Thomas Gleixner" <tglx@linutronix.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH] futex: Temporary disable FUTEX_PRIVATE_HASH
Message-ID: <202507160223.2a483e8b-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630145034.8JnINEaS@linutronix.de>
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e515019-ebd8-45f1-359c-08ddc408eadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?xO82hZYnEO8U7HXvzF7tk/cxOF/dJLpNnKQIKX8xFbn08/4CMXQmvoNW5H?=
 =?iso-8859-1?Q?5Yaex3m0uyJuOtlzCmwaRbNE/oSGIlR0JokN1g3oNlrvsAkPlRnHrN9J2E?=
 =?iso-8859-1?Q?JQA/Zy0a8SPNJQpDLou1oabZcc0q4P4Bsil4JC/NHOboT4+uW7BwA6T5ED?=
 =?iso-8859-1?Q?rCYhD+SdSemBX6+JYlTXtS8X159ElV3t5m5Vx717TvQcThf2FJ/Rfe4xWb?=
 =?iso-8859-1?Q?Atc7H8QqukrsgpDdPdAk3On1fEena7sKZL+SNqH5kQR+x3IG5ofiruu3ar?=
 =?iso-8859-1?Q?96gR0RMGOVjHXc76SbgAVsnLKO0p2iSdWFP6QLNcF+Vrv7G1fuF4lm+DFS?=
 =?iso-8859-1?Q?hp3V7WNlFp4e5330p9297bZZIMeIBMSl/5mXpOuyeg7Z/+P1/1skGP1kvL?=
 =?iso-8859-1?Q?LrzOhrLSGhv90x9KxZiTsyCjQKQyBRzfOB6Tv/n/JCEsBKZtuag3lBBEHZ?=
 =?iso-8859-1?Q?5KkiH8M74msjUgtZ4PbXtjftk6SHOoI6mQRvJYiWOuJj/TX2tkvc3xuD9h?=
 =?iso-8859-1?Q?Z/KH+n4/4UwyZ9SqJrLKJ2SSlDcNTH+/vdV/mUh6cYAl+oqw2YHMspQwq9?=
 =?iso-8859-1?Q?3vNpyHw/n05NnujQf9PExbk7a8KwvDGCUv72cyH9k/YrugUOekJnjAp6VE?=
 =?iso-8859-1?Q?mWEmWYcU/Lvfh65bzkz+A43+mjiJVaoL5YfVOt4rdESa1wjwHlh3iXvVIg?=
 =?iso-8859-1?Q?39IcGdYSG4M1HAiQDThAQwWZbaDCgkIrAOSyAzqwcCBbEk+y1QIm1ha/Ck?=
 =?iso-8859-1?Q?fPtWbltuSKa9GCg4x2C9nsj22ROTriLmGqC6nJkd+K+MyqXHEdodtCJYr1?=
 =?iso-8859-1?Q?mni04kqcEDsKeVIvEqaRf4dZFzlKMKjlB+YkAYkzsUxaiPhCPgQas74p28?=
 =?iso-8859-1?Q?zL2Wv/cPAomszjr06BxKTbFEVuu7QTLWlKm0G4TcTBOZSpFCBi07hzHEap?=
 =?iso-8859-1?Q?QedTIFpZh1Qs4UI45FhTjMyvy26E6OXg/S4Z1grQ48nTwfDH1ZItOdYyuu?=
 =?iso-8859-1?Q?7zEIna+vOKbl+Z0zN/+/ar/zahysqR0HXtImrPdO0W/4Ec399ngtiZDki2?=
 =?iso-8859-1?Q?b7vwcymmbom1daJsF9q2C09ThnYdTiOlYF18a9ftxYEHlYV4X81fLtZK23?=
 =?iso-8859-1?Q?UI8eewUp9VQmV8ZTMRBMIsUH409dqz8fM1qLSqHFV79re1wvk7JJ3ydZPn?=
 =?iso-8859-1?Q?2xEgDPbSIriMZ8C7tC8nQUH5m9Sx9Nb+Bm/W23lM9S/XQ3cagHKfjJAcGQ?=
 =?iso-8859-1?Q?rHCP86CUAchmUsCj3AEZwUW4kLHZJHhpR2g++BoUpf8rf1i0MCMnQE5xaT?=
 =?iso-8859-1?Q?+GhmciTBszhY3i5Axe/9A66ItoQBcN2k9lasIspHqDiz+4nkoiRDp3TP5A?=
 =?iso-8859-1?Q?DroSZWgWOS9kX9SGE45ZCDLwRAPWi9T2Npbz29PDcTJOIjBi2Eax2OCjyP?=
 =?iso-8859-1?Q?b1lp+0Y9RRI2w9oJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xUr6NefUhmprpZgc0vZCNDAdlkbKkyhhgdQn0B2q66Jp89LTMWyI/GjxRw?=
 =?iso-8859-1?Q?mq7bC2JbgB9msH/AMFJrOmbIkn0HNJQgYIdeztMgAfFPv1DORrvtVW59it?=
 =?iso-8859-1?Q?8WKMu5Q9hika2yETvGf4bi6/HgW+HNO2V3uSzvyZuk60XaIuFb7nxwmVhb?=
 =?iso-8859-1?Q?zkKRwiiQ3nqrriFjDDEpNifW44VAfO/N8+ulwMxB7xziyQtmI1qnftfLm0?=
 =?iso-8859-1?Q?oqXe8CzNiEb85hKCAeLWDudHLFB3Pp/K8CMv33cz5uT0akWb0o23MpWW7X?=
 =?iso-8859-1?Q?HUBiWgf3RfylmGwH42zA5/4uHxcwTbkfHgfjCGQsySxfy9V8KJe3BA9QeC?=
 =?iso-8859-1?Q?5CZZJUereoiZ9ZYMjp7lqQ0eokN+2D9jaJaV7eJuntMQnXQ37P7Sqn6yi+?=
 =?iso-8859-1?Q?wPWzuA1sRAcBOMOERIhyTAxN4WUP7Bx3XnlvYiuMOJ9Aet8oQboLSx26ow?=
 =?iso-8859-1?Q?OKUmk+ulo8jzOK+BRcIKTJp5Fk/T2Zk/OhPBhvvVjWigiVdqxWw2eGNhcJ?=
 =?iso-8859-1?Q?kE2DhcdjjeVMPPtP5tARCupEAbNTPxfjzxMpXwZ0LeA11LXcSWtnJ0PtXZ?=
 =?iso-8859-1?Q?SoJnlp9+kAIQ1SfT5IumvkfPF7gIijpEPwX62/XNa+nBBtT6rn8UslDV7Z?=
 =?iso-8859-1?Q?lsfPavQdmS1cprXXG9OyN4ZSqOzkhEYEG0ttonWwZuf6KkPzlguxNR6iUa?=
 =?iso-8859-1?Q?uzqfWXRBFb6MoYnLJCMU2VnVlhSM1xmkqs46u+3dylTQzUOFSIpx7oFEyP?=
 =?iso-8859-1?Q?N9U8PC132pX4ZaAnA4dixKv6PKlASgd+BnkOHG++O+POIGDejW6E5NhJIJ?=
 =?iso-8859-1?Q?0nlX/vrYVCglXNBFHHu2/3Q2kuraStnjscXEWYd88+T/91vt+2A2el3pVa?=
 =?iso-8859-1?Q?uZkoZTrETABh8d7SMJ5U17CvqtcyNSesP5dnb+8z8Q0/D/nSr26BdGAhMn?=
 =?iso-8859-1?Q?geFwBqt3lno5yWG7nptN6ORbqGO9BpwwcuUdLuqMAQAECiKwNTdsKcjdc+?=
 =?iso-8859-1?Q?kzJIGdY3Rz57AdkOCN4id3DHoUfK0SMuMqNYtQ6kG7q5kKpwA7rBKaDtUb?=
 =?iso-8859-1?Q?jI3IJql6rRSN68f8cAHYyZZbSD7vIrmYGUV0XRCe8cIcmM/9DqV4CMvtfg?=
 =?iso-8859-1?Q?cUpzzZhwmrO9J1xFN43X9zWtiVEiSrGu8nSOSMK2DvHqGbziAw+TkHw6H9?=
 =?iso-8859-1?Q?Wl3TITG9ZA7ee/voeePQc5b7lDsaxxN4n+bw8g8zQbREvwJekfINRzNzVi?=
 =?iso-8859-1?Q?XdBo1PyWJpnKsewob7/grBElLzVjoMNoTvXDaArUramKZSxrnt+pLZynSh?=
 =?iso-8859-1?Q?u/XZO5kt6yJpMcyvQ50SGPRM3lOGad7yfVGJOeUYhBc8o2urGHPj9eLfO4?=
 =?iso-8859-1?Q?/t+eL6gDGdf3+fkWE9ND0wYmA8BSiTQFHU7UVZxrmayQ8LToEKVR/5DdXg?=
 =?iso-8859-1?Q?fajqohFHnb3b/hIeISevd6IOm/+77zlPzhTQ9fbBB/quAvZDvMVwx9YQrO?=
 =?iso-8859-1?Q?qzSfvYzIwZgl0Mi80F5Du3fDo2DdvxBIX9Tuu0cu/qCeHeltXq2YskTs+i?=
 =?iso-8859-1?Q?6VWC00ttHG7LKGyO9EU0kbQxrV00nnnkROSmqq0XJ6dCYf2jHW4Y9TBuXZ?=
 =?iso-8859-1?Q?6ADY+iFpWZBEtAcKs4hiwWezRECKTa8QQQjULdpaDBAS7k/i1yVuXsyA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e515019-ebd8-45f1-359c-08ddc408eadf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 01:34:33.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMVsR5F21JJdx3K9OrkdY7eLjFpEi++9/LbKchF76mwkd0SjThIBbq8GS1K9w6Ws2BvPWa1FXrVWPY7NI8ueBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7951
X-OriginatorOrg: intel.com



Hello,


from the commit message, we know this 'temporary disable' is to address a
performance regression. so we still send out this report FYI what's the
possible performance impact. however, our team focus on micro benchmark,
so, anyway, just FYI.


kernel test robot noticed a 1.9% improvement of perf-bench-futex.ops/s on:


commit: bc1aa469e545fe16a62d501e095630cccc3fe1c4 ("[PATCH] futex: Temporary disable FUTEX_PRIVATE_HASH")
url: https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/futex-Temporary-disable-FUTEX_PRIVATE_HASH/20250630-225317
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
patch link: https://lore.kernel.org/all/20250630145034.8JnINEaS@linutronix.de/
patch subject: [PATCH] futex: Temporary disable FUTEX_PRIVATE_HASH

testcase: perf-bench-futex
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: hash
	shared: shared
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250716/202507160223.2a483e8b-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/shared/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/shared/lkp-srf-2sp2/hash/perf-bench-futex

commit: 
  v6.16-rc4
  bc1aa469e5 ("futex: Temporary disable FUTEX_PRIVATE_HASH")

       v6.16-rc4 bc1aa469e545fe16a62d501e095 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2249734            +1.9%    2291792        perf-bench-futex.ops/s
      6622            +3.7%       6868        perf-bench-futex.time.user_time
    115.83 ± 12%     +40.1%     162.33 ± 18%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      4.40 ± 19%    +343.0%      19.51 ± 64%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.15 ± 17%    +347.3%      18.55 ± 69%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     21.00 ± 63%    +121.4%      46.50 ± 11%  perf-c2c.DRAM.local
      4129 ± 57%    +225.5%      13444        perf-c2c.DRAM.remote
     67558 ± 56%     +66.3%     112351        perf-c2c.HITM.local
      4045 ± 57%    +227.2%      13237        perf-c2c.HITM.remote
     71603 ± 57%     +75.4%     125588        perf-c2c.HITM.total
 1.674e+08 ± 20%     +19.0%  1.991e+08        perf-stat.i.cache-misses
 4.096e+08 ± 20%     +19.4%  4.891e+08        perf-stat.i.cache-references
      0.36            +2.9%       0.37        perf-stat.overall.MPKI
      3127            -1.8%       3070        perf-stat.overall.cycles-between-cache-misses
 1.669e+08 ± 20%     +18.9%  1.985e+08        perf-stat.ps.cache-misses
 4.085e+08 ± 20%     +19.3%  4.874e+08        perf-stat.ps.cache-references
 1.622e+14            -1.0%  1.606e+14        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


