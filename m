Return-Path: <linux-kernel+bounces-875109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C40BC183A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60979350A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC62F5467;
	Wed, 29 Oct 2025 04:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0cbxIGD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B4170A11
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761711544; cv=fail; b=pCTO1GT5tswUK168Rbh7YeyfHakxhSkchrian+PG/Wb51bW3JFGj1kPUJHBteGM22HTpLNWJHi41dFQHws2bjZNxr7rXlpDAE52NMuoQrwiQXubu+Q0PrYN7ZGQQF/qriiiDQsZMwAoOVexIRcJ9fYBX1Qm47yZoiwF06Zkpz/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761711544; c=relaxed/simple;
	bh=VE+JSAut5e8JWF/v9sEt8hxF3GXt6SsZOfevGmYVTok=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DCorYwx2/otslY8fQXLu9sgFPPPrkB/alCp0VxZK7VPIUsvj9zpNse3Q9qlogoUlX4znbU0En2CeGw1tMGD++ITLSiZet+ui2HtUsQqE/esSIvRoFjuNzfqar137VbGeBnlxxKBbsoul9d8Lr4RD7YkaO1vTQh3d2Na5aG4Gvgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0cbxIGD; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761711543; x=1793247543;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VE+JSAut5e8JWF/v9sEt8hxF3GXt6SsZOfevGmYVTok=;
  b=V0cbxIGDrnoOiP8P76B2zEIScgFgL2PKLIfL5vFCXT+Iwre/unvRxeEI
   39kX2OnZe8+3vdljBTGo+lcsRP6Vmbdpma0rMsmvHyfdBf/1+xewjj0qd
   futGuDN15QMcmG+QzTu3/mm+dO52j4sPHYVPKx+5tfVDs2xvatQgyj0ja
   B25NvjtapT7av7X81pGDHZCf3Ymx1ODO3HCUPDiY5yNFaTCGWR+6fRMXP
   vAVCZkKOxVvILy1qmBbIK6jJsdbi7Od5vTAB7QodadomIke5ZrVwEXGIu
   bd9PC7xti+4tV6CpbzyMh9C4EPjiFWX77qmrz/sutjTiiU8RvLqJ0q8bj
   w==;
X-CSE-ConnectionGUID: 1ItklOFsSPC2LpOWzh+A/w==
X-CSE-MsgGUID: lE+KqyyUSuWPXdKkXr+i4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67660236"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67660236"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 21:17:31 -0700
X-CSE-ConnectionGUID: 6RdRunPRSXWWFpoqyc0mQg==
X-CSE-MsgGUID: jMpcNOdRQKCXIaSkfb1S/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186003259"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 21:17:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 21:17:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 21:17:30 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 21:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBwL8krLL0njnI8xbCOWiDlGeMq9ljcQbk7ubTRD48Pf5+H047idBWOQxWPP2OuNFubMg0u+ARG/7mNr9v/dLBGr+SSKA9S5cficyZFW6yt8ZBHWTh5SaNgfIMxlKqtexuak5wUT/TPQN48cIjais5GwypqVvmI/cDyI5cvwhPU028EmnlghamwSvtjOkht0ohynU0t6jlh0LUy3xDJCGnKMbpHulsQpBgyb0X548SrIw2nus1h+uf8x0azS83fmQBiGW62Zp+sCtCEDfbfiOFrih613skci3iFRiXr5Q/0Km6ucXOc0NW3uip7Shx04EGwfmZPLkOLqVdrL9n/IqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcGSpJeWN0e4xUvSSGompDTll0nrmNGo2pu9NXqHpew=;
 b=wyuW8l6mVCeQMBE4ciO9AErSpQmIvLofA9/vWKvxhZOsfXyL1kN3LAtaOtdSrt+tb+8etnNclmSptbvh5bq8orVAB/Eg0Jxj+7No+Rc0qANLfMYPfDIebhHK0AzuhKimLeDcRMqFVSc+TC821Z8ylSTcwGZTvjba3fpINVF6Ky+EhdgOax5s94OvReo0oIGwt2T87PxEwXjEhTZoJRLimRTgD1nX3wNjOPdyECo5J3qoPTeBO+1uofr3fe2ueEN9IlO7JYNaT1lpWBeQvr748dvBs16iuOaVdVICtssDWtUNhyG1BYZ+6iiU/vwnm3Sp+BAkLh7RKuBJU0tsTRHHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8839.namprd11.prod.outlook.com (2603:10b6:806:467::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 04:17:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 04:17:28 +0000
Date: Wed, 29 Oct 2025 12:17:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shubhang Kaushik via B4 Relay
	<devnull+shubhang.os.amperecomputing.com@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shubhang Kaushik
	<sh@gentwo.org>, Shijie Huang <Shijie.Huang@amperecomputing.com>, Frank Wang
	<zwang@amperecomputing.com>, Christopher Lameter <cl@gentwo.org>, Adam Li
	<adam.li@amperecomputing.com>, Shubhang Kaushik
	<shubhang@os.amperecomputing.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
Message-ID: <202510291148.b2988254-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
X-ClientProxiedBy: KU2P306CA0072.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d330573-06f5-40e0-eb3e-08de16a21232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lx6xRqQYwjg5qcDaDBSnL6CeTSCF6fPDWe+Lup2kmVyMKu2Dtwyk26ksKm?=
 =?iso-8859-1?Q?nCxeyWxxZc5A+YZEXzA7hmaWTPuxh56yBhuoJ9cfIMN4gPoFxZy4z2/Ysg?=
 =?iso-8859-1?Q?CtCHeQNNuEKWJ+tC2uQp5B1a8OhudywAd5SIQts4bY/q57AL7QufhZEwqF?=
 =?iso-8859-1?Q?RxORlLvTfCkfoyjgkuEa8Kup0VkvpbNE18kxYucdFSZfobG05ElJ5LPp/B?=
 =?iso-8859-1?Q?rV/DEhYuK4SWX9TkNjhoapB7k5BE0K5r0G7G/Qdfd4RwFtITir6SqnXXEX?=
 =?iso-8859-1?Q?Bt91xFby9bDxAGbVOhEInheIvdt16FzJPXi32ueHy7ipQVuiCF5GPnvkwb?=
 =?iso-8859-1?Q?Ba0zF/yaC2cpfDfZ3FvtgOX6kcvkC2poqpMlnKDugUDHf+3ZvXJWrW7IyU?=
 =?iso-8859-1?Q?qvMRskKg/xmjyX4ykvxaHDCmho1Q7dgE05N5Vr1bnrqXr0E566KM2bJKbe?=
 =?iso-8859-1?Q?hY5jvPRYYK/eZyVYvM4fWdKOKQJtsL1E6ffRjn8BxEZI8cRQ2KYT0HK8Zr?=
 =?iso-8859-1?Q?6o5WprdNhW8XAMjrnyvpzLduAyYNMqebZc6my1hkPB4r1xmNlLH/SQ+7xA?=
 =?iso-8859-1?Q?NoNb74Z7XQjO3v4HSR/TpyCnfyJygh/XGeLn826D2W+P5adfnQ2fKAb2ML?=
 =?iso-8859-1?Q?edNPVNIbzUGY548CrP47J2E7V0F0k1uWn01bqfvmfhTsufUv1oC9StdfcM?=
 =?iso-8859-1?Q?Gvh9MHQJGV2FxlXj3/Ym4mYEVQKWJYUMCnI4xoKl2fFOE8fXy+HSRLx8gN?=
 =?iso-8859-1?Q?EQNRA8Z+Bn3WmFL5KjTXT/8tm3J5MovrKS51s2Ckk2A/N2OlRvdR69QnBn?=
 =?iso-8859-1?Q?iSJ5W3I9DFbqiyKZKn0/1iXjbZJuKrsV0CgSd14ttJ3WN7Q1XE0iUT6UCY?=
 =?iso-8859-1?Q?kjUzmU/ca/tJSKmGsU7wbPMMk2xidUvQdVbeXU0+cBz9X1nlR17Wp7xID1?=
 =?iso-8859-1?Q?S7diN/Uj0nECJHbehJeqZbnSyHJsICWxT0kTmNZsQrx61jDxzuH77t1DYt?=
 =?iso-8859-1?Q?P07mFvzMiM0gLJ/H0VFv/QnaF41FgvtXr8ux2S79MVGPOjSV34B8Kgxqr3?=
 =?iso-8859-1?Q?72YAIIk4UtMM0tCY87PM33w5/YCWJ9zfOljKTEF4EtHSoujWeduVR8X3VQ?=
 =?iso-8859-1?Q?VJPZzbD6yr56K2z6/OdJ9GG5Miw1jZFvHVA/dvM62nFX8RJnhQipT8nT9R?=
 =?iso-8859-1?Q?MWIz7GFLgf5CuG+YXhjKgns3eMqCtEW5EzLRUdVNOIXdFkvHWBWWhfRtSB?=
 =?iso-8859-1?Q?LC7Ia+av05SQydc+FEPwAqJLEmq1M8EN/am5kbS50cDZNe4CfQDUBhl+6F?=
 =?iso-8859-1?Q?dyzlbquRj8SLtnd38dYPvkPCLG72qS+DwlS+H0j+f6xjo70IrhURdMjUg5?=
 =?iso-8859-1?Q?nlE+OPKp72uY1mTGw5XnrdNYmkyMFFfyUc9hX1ak9GfmPVcJNubVm8t5EE?=
 =?iso-8859-1?Q?q7UfQjQ8RtVEYjWMnurypZLZHYGy6gnihJOoSCVdKrNwuZzFP5E08XPdd2?=
 =?iso-8859-1?Q?Vq0KO/uASfxKKajBkFtz6uNN3EIIRYs+OLD/MKfuyn6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NGX8uXyeHHPyiCM4Qb4Q/F4gAU97hdT/ltg3zOOnpAVOsaz2niNN5pftVv?=
 =?iso-8859-1?Q?nVgPp3Ms9bdBn7yBMCyUFSNmhJkHY68h0aV6B07QxmDg5cB49aVzy4mITe?=
 =?iso-8859-1?Q?yYeBy/CdP0DnsLechCrtrsX7NtcFRBRJtvWGusFbykNjtoSGP5hfWycs6k?=
 =?iso-8859-1?Q?2LJl/ycUsmySHJxMRPD7rtjFt8pXSVYiHlFUiTNHUtL/YT2B4ZFxELkeq3?=
 =?iso-8859-1?Q?rLWIVV5B7NsKQvu84XXaAA+0Jvcy50rwapAHF1kaQSh5KG8PgI2xRozxMI?=
 =?iso-8859-1?Q?SqOwCKbeD5ceJNDvvMi5Ta7cOnoFscuzP4Ozm7y6WWnrvdYLHULs0Vsz5s?=
 =?iso-8859-1?Q?gYR0f9HhCyrvqvHkqLG7nZ1VDahPOMnXKp7WLPSs3dGk3ungwlFTiKaBDj?=
 =?iso-8859-1?Q?A35LFDtzFyknnjRPnvYyNbOI9SsXEtVFTFfD6ZElO7exedJT/b9UmGzTHp?=
 =?iso-8859-1?Q?8ZEkdLe3vrm5deW8gtg42pSPPjHUP3sQfxV0MUObO7Zi+vH4K7CsKooo/c?=
 =?iso-8859-1?Q?5IX7NBddObfppjx5zYqDO/F4eErjOVx2JrpdmLzS3Z0WFE6RH2LfWfQl8V?=
 =?iso-8859-1?Q?6M6Yz/lr89LogPidleKZR7SKtkO12GZuAPhoCSddy55C6W/pYsrPENDs4h?=
 =?iso-8859-1?Q?EN5rBR4VA1cXMBxu41Y0/8v5qXcpmflPYlvrmFz1hiqAl6uU2hRMRh8HKv?=
 =?iso-8859-1?Q?x0rVfs4fXfNSgOLQClPP9z2GMRcfTidMSimWwCZ66JB3VYkOUiwhUYThs/?=
 =?iso-8859-1?Q?Y0QVSjNWPHiRIyF0pPb7bx7KrqQqLMfQhHtgvO95SX0qXyGODbmVHKuj+I?=
 =?iso-8859-1?Q?cYz6WUiYjOMXDuTFK/tZopZ2/2F89Y5gXYdyYWwx5ZvuShyAK6IDmLCS5U?=
 =?iso-8859-1?Q?ZJedjp9qrC/ujJjriuUJZkXOq1qa7a6ohapz2UNgcpFVepIFwFk0vxdwqt?=
 =?iso-8859-1?Q?6e8fInL7vaZYsR1cQqV6JgETVlSfAnI6GXcNJMwszxy2npVcxt/AM6Qslb?=
 =?iso-8859-1?Q?5PNQGP8JTuZkYNkKb56mOAkkSS5GWF+KdjOtKSbz/UqCucCDfKdOv1pcaH?=
 =?iso-8859-1?Q?JM4nkOvSI6danobCD8qEj1OjeVn+il84jIVyM8hnW9NvQJ5YFHioQpxQju?=
 =?iso-8859-1?Q?sDc0J+BPpplDubd3yGpaB7C46moBM3iDvS38tgs4sxbeGicnsG0z1Ba8Wn?=
 =?iso-8859-1?Q?hJ19gDHOVwaARQdh/Jejx+fEPDSnLflEsfjcwBClRQNy1gHpkPKVPTnW55?=
 =?iso-8859-1?Q?kdodF6zIkaTJwjU48UI6QspAu+HmFPsv/p/Z2WAY9eVQ2/PIKCqzf1EvME?=
 =?iso-8859-1?Q?5sNQCOjakOMtJWOI21dgnNmTdDCM4VGXKxPgwJc3eBdvxyJspOnK8A2y1g?=
 =?iso-8859-1?Q?/I6l6ZRUooBusfO1ySXCqoffwUq4mjZo395kQfzWlvLfaszIXGmd06FlXW?=
 =?iso-8859-1?Q?aN/l9nS9zm3cXUaJ9qT++A3YB3eSmA0vxiik0dQbG93vU/GnyEgi8DAmxx?=
 =?iso-8859-1?Q?2XWk87Ga02iz8Ywpz5EkKhWRNRnlgGHtgcZazBN3PktmQd7IvQVgG2NxMe?=
 =?iso-8859-1?Q?OoHZF+xJzTElk486pW2mEtidcVVflKwZKWIiB5Srf1jfVbeWjCYfG4NULQ?=
 =?iso-8859-1?Q?xLT1FFtiCy384NZxjKtyEiYUxquy4JCAHQfCP4REPt+xerzZvG859T3Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d330573-06f5-40e0-eb3e-08de16a21232
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 04:17:28.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxueEvScHW3ZV2uogFaOe/gYkrt1PpthPcYybbIYMc1GpiiTbGcOa7aER+vsMi3nDxI8JENaq5gPOOifmyBfew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8839
X-OriginatorOrg: intel.com



Hello,

we just reported a "76.8% improvement of stress-ng.tee.ops_per_sec" in
https://lore.kernel.org/all/202510281543.28d76c2-lkp@intel.com/

now we captured a regression. FYI.


kernel test robot noticed a 8.5% regression of stress-ng.io-uring.ops_per_sec on:


commit: 24efd1bf8a44f0f51f42f4af4ce22f21e873073d ("[PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup")
url: https://github.com/intel-lab-lkp/linux/commits/Shubhang-Kaushik-via-B4-Relay/sched-fair-Prefer-cache-hot-prev_cpu-for-wakeup/20251018-092110
patch link: https://lore.kernel.org/all/20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com/
patch subject: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 64G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: io-uring
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510291148.b2988254-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251029/202510291148.b2988254-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-gnr-2sp4/io-uring/stress-ng/60s

commit: 
  9b332cece9 ("Merge tag 'nfsd-6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux")
  24efd1bf8a ("sched/fair: Prefer cache-hot prev_cpu for wakeup")

9b332cece987ee17 24efd1bf8a44f0f51f42f4af4ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  3.58e+09           +17.6%   4.21e+09        cpuidle..time
 9.276e+08           -35.8%  5.958e+08 ±  2%  cpuidle..usage
  48009670           -12.7%   41899608 ±  4%  numa-numastat.node0.local_node
  48122238           -12.8%   41981276 ±  4%  numa-numastat.node0.numa_hit
      0.89 ± 44%     +13.2       14.07 ±  3%  turbostat.C1E%
      0.67 ± 44%    +381.0%       3.22        turbostat.CPU%c1
 1.375e+08 ± 44%    +199.4%  4.116e+08        turbostat.IRQ
      4.70 ± 44%    +224.5%      15.25        turbostat.RAMWatt
    210.17 ± 77%   +1158.0%       2643        perf-c2c.DRAM.local
      1725 ± 11%  +10694.5%     186276 ±  3%  perf-c2c.DRAM.remote
    320853           -50.4%     159203 ±  4%  perf-c2c.HITM.local
      1320 ± 13%   +9462.5%     126256 ±  3%  perf-c2c.HITM.remote
    322174           -11.4%     285460        perf-c2c.HITM.total
     14.00 ±  4%      -2.1       11.92 ±  4%  mpstat.cpu.all.idle%
     13.31            +5.2       18.56        mpstat.cpu.all.iowait%
      1.48            +4.9        6.39 ±  3%  mpstat.cpu.all.irq%
      0.85            -0.2        0.68        mpstat.cpu.all.soft%
      3.51            -2.1        1.40 ±  5%  mpstat.cpu.all.usr%
     18.17 ±  4%     +12.8%      20.50 ±  4%  mpstat.max_utilization.seconds
  12518136           -40.6%    7432802 ±  5%  meminfo.Active
  12518120           -40.6%    7432786 ±  5%  meminfo.Active(anon)
  14791509           -34.2%    9726112 ±  4%  meminfo.Cached
  17016588           -29.8%   11943542 ±  3%  meminfo.Committed_AS
  19860760           -19.5%   15994452 ±  2%  meminfo.Memused
  11109813           -45.8%    6019207 ±  6%  meminfo.Shmem
  19916177           -19.5%   16031079 ±  2%  meminfo.max_used_kB
    104776 ± 14%     -24.3%      79337 ± 21%  numa-meminfo.node0.KReclaimable
    104776 ± 14%     -24.3%      79337 ± 21%  numa-meminfo.node0.SReclaimable
  11913809           -42.7%    6821430 ±  5%  numa-meminfo.node1.Active
  11913804           -42.7%    6821421 ±  5%  numa-meminfo.node1.Active(anon)
  11336225 ±  2%     -30.4%    7891392 ± 23%  numa-meminfo.node1.FilePages
  19000428           +14.7%   21787417 ±  8%  numa-meminfo.node1.MemFree
  11104229           -45.9%    6012466 ±  6%  numa-meminfo.node1.Shmem
 1.125e+09            -8.4%   1.03e+09 ±  3%  stress-ng.io-uring.ops
  18779554            -8.5%   17185210 ±  3%  stress-ng.io-uring.ops_per_sec
 2.353e+08           +58.7%  3.735e+08 ±  3%  stress-ng.time.involuntary_context_switches
     16880           -11.1%      15008        stress-ng.time.percent_of_cpu_this_job_got
      9702            -8.5%       8878        stress-ng.time.system_time
    443.21           -67.8%     142.54 ±  2%  stress-ng.time.user_time
 1.362e+09           -11.5%  1.206e+09 ±  3%  stress-ng.time.voluntary_context_switches
     26194 ± 14%     -24.3%      19834 ± 21%  numa-vmstat.node0.nr_slab_reclaimable
  48122182           -12.8%   41981349 ±  4%  numa-vmstat.node0.numa_hit
  48009614           -12.7%   41899680 ±  4%  numa-vmstat.node0.numa_local
   2981009           -42.7%    1707865 ±  5%  numa-vmstat.node1.nr_active_anon
   2836469 ±  2%     -30.4%    1975086 ± 23%  numa-vmstat.node1.nr_file_pages
   4747481           +14.7%    5444494 ±  8%  numa-vmstat.node1.nr_free_pages
   4714110           +14.8%    5411734 ±  8%  numa-vmstat.node1.nr_free_pages_blocks
   2778450           -45.8%    1505400 ±  6%  numa-vmstat.node1.nr_shmem
   2981003           -42.7%    1707858 ±  5%  numa-vmstat.node1.nr_zone_active_anon
   3131938           -40.6%    1860663 ±  5%  proc-vmstat.nr_active_anon
   1133648            +8.5%    1230219        proc-vmstat.nr_dirty_background_threshold
   2270069            +8.5%    2463447        proc-vmstat.nr_dirty_threshold
   3700155           -34.2%    2433658 ±  4%  proc-vmstat.nr_file_pages
  11441308            +8.5%   12408439        proc-vmstat.nr_free_pages
  11335855            +8.6%   12314183        proc-vmstat.nr_free_pages_blocks
   2779743           -45.8%    1507064 ±  6%  proc-vmstat.nr_shmem
     50620            -5.9%      47611        proc-vmstat.nr_slab_reclaimable
   3131938           -40.6%    1860663 ±  5%  proc-vmstat.nr_zone_active_anon
  99148879            -9.8%   89432077 ±  3%  proc-vmstat.numa_hit
  98893495            -9.8%   89168637 ±  3%  proc-vmstat.numa_local
     54203 ± 24%     -57.3%      23128 ± 10%  proc-vmstat.numa_pages_migrated
  99397243            -9.8%   89638031 ±  3%  proc-vmstat.pgalloc_normal
  94583491            -8.4%   86624034 ±  3%  proc-vmstat.pgfree
     54203 ± 24%     -57.3%      23128 ± 10%  proc-vmstat.pgmigrate_success
     39031            +1.8%      39717        proc-vmstat.pgreuse
  47196381           -31.6%   32305642 ±  2%  proc-vmstat.unevictable_pgs_culled
      0.08 ±  2%   +3468.8%       2.97 ±  4%  perf-stat.i.MPKI
 7.499e+10           -21.9%  5.854e+10 ±  2%  perf-stat.i.branch-instructions
      0.94            -0.3        0.62        perf-stat.i.branch-miss-rate%
 6.557e+08           -48.5%   3.38e+08 ±  2%  perf-stat.i.branch-misses
      0.70 ±  2%     +36.7       37.40 ±  4%  perf-stat.i.cache-miss-rate%
  29724413 ±  2%   +2544.3%   7.86e+08        perf-stat.i.cache-misses
  5.32e+09           -60.5%  2.103e+09 ±  3%  perf-stat.i.cache-references
  42032996           -14.0%   36140436 ±  2%  perf-stat.i.context-switches
      2.29           +18.0%       2.70 ±  2%  perf-stat.i.cpi
 7.916e+11            -9.6%  7.154e+11        perf-stat.i.cpu-cycles
  11062415           -99.9%      15481        perf-stat.i.cpu-migrations
     44096 ±  5%     -97.9%     910.19        perf-stat.i.cycles-between-cache-misses
 3.698e+11           -22.9%  2.852e+11 ±  2%  perf-stat.i.instructions
      0.46           -14.9%       0.40 ±  2%  perf-stat.i.ipc
      0.05 ± 47%     +96.1%       0.09 ± 14%  perf-stat.i.major-faults
    207.41           -31.9%     141.15 ±  2%  perf-stat.i.metric.K/sec
      0.08 ±  2%   +3331.9%       2.76 ±  4%  perf-stat.overall.MPKI
      0.87            -0.3        0.58        perf-stat.overall.branch-miss-rate%
      0.56 ±  2%     +36.9       37.43 ±  4%  perf-stat.overall.cache-miss-rate%
      2.14           +17.3%       2.51 ±  2%  perf-stat.overall.cpi
     26647 ±  2%     -96.6%     910.56        perf-stat.overall.cycles-between-cache-misses
      0.47           -14.7%       0.40 ±  2%  perf-stat.overall.ipc
 7.375e+10           -21.9%  5.757e+10 ±  2%  perf-stat.ps.branch-instructions
 6.449e+08           -48.4%  3.325e+08 ±  2%  perf-stat.ps.branch-misses
  29243806 ±  2%   +2543.5%  7.731e+08        perf-stat.ps.cache-misses
 5.233e+09           -60.5%  2.068e+09 ±  3%  perf-stat.ps.cache-references
  41341425           -14.0%   35549572 ±  2%  perf-stat.ps.context-switches
 7.786e+11            -9.6%  7.037e+11        perf-stat.ps.cpu-cycles
  10881167           -99.9%      15227        perf-stat.ps.cpu-migrations
 3.637e+11           -22.9%  2.805e+11 ±  2%  perf-stat.ps.instructions
      0.05 ± 47%     +93.6%       0.09 ± 14%  perf-stat.ps.major-faults
 2.217e+13           -22.7%  1.713e+13 ±  2%  perf-stat.total.instructions
   4219859           -17.8%    3469357        sched_debug.cfs_rq:/.avg_vruntime.avg
   7247589 ±  9%     -38.3%    4469027 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.max
   4013259           -29.0%    2849620 ± 17%  sched_debug.cfs_rq:/.avg_vruntime.min
    265810 ± 14%     -54.9%     119970 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      3.42 ± 10%     -24.4%       2.58 ±  7%  sched_debug.cfs_rq:/.h_nr_queued.max
      3.33 ± 11%     -22.5%       2.58 ±  7%  sched_debug.cfs_rq:/.h_nr_runnable.max
   4401036           -17.1%    3647494 ±  4%  sched_debug.cfs_rq:/.left_deadline.max
   1274751 ±  5%     -18.7%    1035958 ± 12%  sched_debug.cfs_rq:/.left_deadline.stddev
   4400687           -17.1%    3647059 ±  4%  sched_debug.cfs_rq:/.left_vruntime.max
   1274640 ±  5%     -18.7%    1035848 ± 12%  sched_debug.cfs_rq:/.left_vruntime.stddev
   4219859           -17.8%    3469357        sched_debug.cfs_rq:/.min_vruntime.avg
   7247589 ±  9%     -38.3%    4469027 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
   4013259           -29.0%    2849620 ± 17%  sched_debug.cfs_rq:/.min_vruntime.min
    265810 ± 14%     -54.9%     119970 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
   4400687           -17.1%    3647059 ±  4%  sched_debug.cfs_rq:/.right_vruntime.max
   1274640 ±  5%     -18.7%    1035848 ± 12%  sched_debug.cfs_rq:/.right_vruntime.stddev
    532.33           -11.4%     471.62 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1361 ±  3%     +18.4%       1611 ± 10%  sched_debug.cfs_rq:/.runnable_avg.max
    203.24 ±  4%     +38.0%     280.47 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    108.79 ±  5%     +68.6%     183.41 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     99.93 ±  8%    +144.8%     244.58 ±  4%  sched_debug.cfs_rq:/.util_est.avg
    154.15 ± 10%     +41.9%     218.69 ±  5%  sched_debug.cfs_rq:/.util_est.stddev
    585777 ±  3%     +55.0%     907718 ±  6%  sched_debug.cpu.avg_idle.avg
    257569 ± 15%     +30.0%     334947 ± 11%  sched_debug.cpu.avg_idle.stddev
    581651 ±  2%     +97.0%    1146052 ±  3%  sched_debug.cpu.max_idle_balance_cost.avg
   1334820 ±  4%     +10.9%    1479741        sched_debug.cpu.max_idle_balance_cost.max
    150290 ±  9%     +34.9%     202732 ±  7%  sched_debug.cpu.max_idle_balance_cost.stddev
      3.42 ± 10%     -24.4%       2.58 ± 13%  sched_debug.cpu.nr_running.max
   4900954           -14.0%    4212806 ±  2%  sched_debug.cpu.nr_switches.avg
   1872618 ± 12%     +57.1%    2941530 ± 17%  sched_debug.cpu.nr_switches.min
    -24.25           -67.7%      -7.83        sched_debug.cpu.nr_uninterruptible.min
      8.41 ± 12%     -46.3%       4.52 ± 14%  sched_debug.cpu.nr_uninterruptible.stddev



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


