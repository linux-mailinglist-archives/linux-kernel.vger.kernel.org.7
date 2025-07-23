Return-Path: <linux-kernel+bounces-742094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B2B0ED17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B35C3B3BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52208279DAF;
	Wed, 23 Jul 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2IXQHQ1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B325743E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258940; cv=fail; b=Ims5k5RZaB0M9PpJqzTIb5A9OehagbsZRrEhgMFQdj/JoVPSJO5a/2ymNWOsxvr0X86sAaBK2d+lEVpcbgZ8WMK2iEza4dLeTFGU7hPo3cQPHd4ZLoad6U18bOCuonzsPNxE74S5Su5ftlMkwY9EBuEdibgTSA9yIU4GozadwHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258940; c=relaxed/simple;
	bh=1USbomSoUl7UpKNT46xQob7Ur7GRIX3+vZ9t/RwiuSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VVIYuQxXooTBeYczlr98u9x6SHcuosH0uIh+zHghabhhxkR0eIEBlkIvNOd0IUWq2RrFZY3u/Wdvwm45e7pWhtjtT3ZwfDewt1dokqQrv5kIwghFD1ccAXcMGKuTC79+nqH52KdaIqgXcx93ZD/oXUuitr0UqEdJihyuibvVjSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2IXQHQ1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753258939; x=1784794939;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1USbomSoUl7UpKNT46xQob7Ur7GRIX3+vZ9t/RwiuSk=;
  b=Z2IXQHQ1WukLBeCI6TTQFnz7MemUmUlWseXXkJ/KkEUO8VRtTaeguPpJ
   tpTzIhfKWfVgJa5k5+LFa8kPdPuK2AG4eY0xQnBpVo+xEwDA8NcjE1eRP
   H8IvPrw09gkI2ZX8sOCsFqlLysHI+pmkUESD0NGbSHo+Sn1uC/ViIATfd
   NBtcNXoFqg0sWShzxW1p3hPaMLZulrEoL7jUbnyeI0QyNXkuXShcZTBTS
   5NAA34FmUO34OJfGzQ21mK7+NDWDQmWKta5bNdhRiTvKNOA4+GVcyoTap
   u2WAogMrmRUQo1mxvLen4QI2xFz5YqxX/RTS32yiuO2/iMYixT4SMEaFi
   Q==;
X-CSE-ConnectionGUID: +0olNwtZSWScPCEYNJdE8A==
X-CSE-MsgGUID: jlSvaa3AQl+957GVAUgQww==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55474463"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55474463"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 01:22:18 -0700
X-CSE-ConnectionGUID: SfomL8elSRG6tnU5rGNqEQ==
X-CSE-MsgGUID: tw6RfFCzSVaCMwnHzuH0tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159475690"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 01:22:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 01:22:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 01:22:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 01:22:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKk+g3znDSW6dmLFKNpL1lw5hOY+sKSsnd15cb9LSjEdsSN3WE8mSle5nLqtpJ8cMkjaK1eJQ4asoYFz7v8z68eZ3duRogZsSWLyesIXFAlkvMbLFI/nlTbBi8/HupuGxch+WdKiq8UX8eahkWq762k2kQE+QlH5+nPT0QB/770y7JTIegNiroT7JLso87eTpWvfYMmkDOaC/aOv4mro7fBN5TO01lgTe3hethaBDfQhkuze8tUhDjCyu/vW7Ut5tY/P7keq3FLYkU+F0/zUpBHP2j44gv21hZbWVPGoLJ708vTJtEB8j7UI29uslAkUVzxc8+wRi3wLngf2C7lt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHuyWOOtbbJmJCcX/ZkjjOjYmKsYzA64d4ScUBHL6zo=;
 b=xDyzd8rM+2j0+h+tWEBdDG5XRqkDAJA1AgMrmZcGffiXxq59Ae1Fyp9j6siDo3qEleyKzF2vtC016riHtCMekXrkJJqXA7wjuFbK1DRWBc1PTIfrePyWFUnntuvHZyq0WndgAAHQ43HxgCILlfobSOayFRGRZ/Zh+py6cI8WQHixgnOVlcuhFlmfOIiUgRonxqjAzMY3HE06ifk0LRQDfXDMjdlikrtEHUuGa0VOqZoBtD9EWEOs2ztK/4lCPIEOTX4P3dVyFDsjsEBvMg99YrkttRPRJ4RkBYxyHOAPaIcPxZqyBPJOw+nC/jKxKduYUugRq4aVpQpH94tZfjrAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 23 Jul
 2025 08:22:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:22:13 +0000
Date: Wed, 23 Jul 2025 16:21:59 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Aaron Lu <ziqianlu@bytedance.com>
CC: kernel test robot <lkp@intel.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, "Chengming
 Zhou" <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, Songtang Liu <liusongtang@bytedance.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <aICbpytNfGRRrqq3@xsang-OptiPlex-9020>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
 <202507162238.qiw7kyu0-lkp@intel.com>
 <20250717035243.GC32@bytedance>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250717035243.GC32@bytedance>
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ba6b86-9618-4580-ce08-08ddc9c2068f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qG/PEnDFvWHBFATXVTAH0ILtNBIPEJVBSUW8COHYUJwp0YiflACDuzxl7YzO?=
 =?us-ascii?Q?G9kn9lRGgEfR2j9ysfaporUixuMXV7FiCINE7tASxUMQqNHmm+zX8w+bkzWu?=
 =?us-ascii?Q?2SI2rmjlSTXUxUQKDHL0j60QtdOjJNaYp99s3XjB9+AC9vQjO1uoOS8zCIz7?=
 =?us-ascii?Q?LaL45Of+KdWQ3nedbr0FlhF6+QqnUbEV16CZXdTvyLbQZzRbFrjcubNDvIGJ?=
 =?us-ascii?Q?l9w00xJHXMeBZaB0VmdzXQf9RpNozuaP0fwEB2sQIHkZ99z3nVhpzek8pdGn?=
 =?us-ascii?Q?avm2JbwDdW1XxdCp7yah+fMuNBYpAknnG4KpC6yeFZbU+r3+w/+yIfMgzM5U?=
 =?us-ascii?Q?epEUwuRdn385G7Jp/xyIzqEbkdUcOMyVYQVDc2MFYyZUM5n6jr7UyFfmhuep?=
 =?us-ascii?Q?L/0wuwxF53PArvm5uYhibKxSDvyDpDrE74UxFmeGtK7VQqgZLmRXiTly6fRH?=
 =?us-ascii?Q?CwlhwpOcR6lg2g9q0oafzEqxyXR8o5CvdC7Rf2L/3PaCJAHK6vcLviR8/ICU?=
 =?us-ascii?Q?lCvJVmBwnSWV+AT0yAJ1IRZIdiqnS9rJa1Gm05lQJ7wNj5VC6X1aODUaicrp?=
 =?us-ascii?Q?RYcZyVafoCkVKeF/QcvK7C/39ecB8dX73lbTwqA+kovpqCdRsq+h0r42G6no?=
 =?us-ascii?Q?9J/EDRL0EPz0A5woUirjgjqlMBVIEgug3THeiNuJCVhPJ2nohb3/IKE3L1Qw?=
 =?us-ascii?Q?/6GgYZdVkfRBcQ5vnmWzxM+57sF7k/cGqrHec4JzhCPbXLmJCK/9FMqt9Wx2?=
 =?us-ascii?Q?WEtzPjSRZpAwLWmN79WhmWq6JGq7mVmgZ/TcXJ1gxf84a0y40FDb9WDVFsBd?=
 =?us-ascii?Q?J8YDy5A1ZqXoFXrosTjK84H/Y35QQXVvp3WnW9pAV8ah3vzI3zIcz4exmVgp?=
 =?us-ascii?Q?vh8XoEuQIbDpaSjh13A1YMn7d1ONFCETUJ+JZzTsQIXpVYhh4fObGgK/A+iC?=
 =?us-ascii?Q?RTcnXYJZKndCxJAHye82cdTDBeKRguK5Buz2o9oghXMBPCVszXxClxl4NKz7?=
 =?us-ascii?Q?Vo8s8VDXxUvxa37FkedosSZIR6RI6ERnff2Uup5jT5VR6cbAaZXkSJFPNd+O?=
 =?us-ascii?Q?THFzEfWh89Nb27g1fqZFhwy/pVUM3VMceFJiBlgcd4W1hp0M3TEcU0qIJZ1H?=
 =?us-ascii?Q?KS8V37Cg0uWDxcS/brl3mXNP0aQXnLB5jE/V/0PD/fcwK6+ktQIHSDvOhtBW?=
 =?us-ascii?Q?z6dOQ2EU/iJ5vvkf0t84jw0OXKZYsMtqLuIIGZb7SzuIQ36XL0vc3aXLkmMi?=
 =?us-ascii?Q?Kb+VwSnGCIiDj4xRSFb4bBXIJ78dS/VoQ9TsaJ6EE4pcBMcOtYuVzEuvENFE?=
 =?us-ascii?Q?lRzHiDdfGr8dUrCDBap1gHEONiIuRHRv7bnnp/yhxObQd4LAlB6uaN41aOjW?=
 =?us-ascii?Q?F1IQFQA86hyhWi4QaiYF2zarPdLN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9oxFIJmv7B8dk37lGNH94Aya6D2/ZBEOxEfIK8pqS/KjjoIcOozl+2sfMY8?=
 =?us-ascii?Q?DRnI/5NRHqC3tHuFdfckbBsO8osdPqkdK/ZrdiY7TVAK9XRmipsThKIi8wtk?=
 =?us-ascii?Q?9dJIwRJQ0yA8kXJAu5nfLJT1/UtKTTlKTKcBbedRoFdbCFTe1is14Gvu2JJ7?=
 =?us-ascii?Q?8gwL7H7+WZIH4pTXHrbi/ajxIdsvG2WlFRri1835LlH4B61D267O8cp16+uF?=
 =?us-ascii?Q?TsJDLojr5h4gX2KxnBZSqD52L86DP9PjEQnfnCy/QoQ6654swGOWht8Od1JG?=
 =?us-ascii?Q?xakLO6VHZeW0NfJznrzSVJTbWqu+NJfHhMx3gmyPawQgWmzT+i3lPPCMtypA?=
 =?us-ascii?Q?Y6/ca93+ThtO+yj33PLVEySa+ZnhMEVej5soa/sn+0qB7JPglqXQ6gVoyj1S?=
 =?us-ascii?Q?wRlNX0GZgxQ5xTUrZVybZswmDfTojct4/eJZ6I0Zk+VJGWAaGO4pIBRP3oHV?=
 =?us-ascii?Q?IJIszBWZp2gWE/JpNVEUxtQaMZhO7pp91ENE0bLzgh7V7k8gnq9e/nuDlgmW?=
 =?us-ascii?Q?inrp/hOoyVUnf4gxxSEBm9X3qoiOEKn7JWHCfNC+McPcs6bmUPhoSaeFl49w?=
 =?us-ascii?Q?0oxof+hlvlhv9gbreQUe2INEsPIdldYi6e092IWJMMrV1saVE4Fc65vmqeLc?=
 =?us-ascii?Q?u2JsrlyrG/HTvIj2mbTVNhxBhnl09hRs29NSRChP8gECxVnb5tY4Ln5+WPx6?=
 =?us-ascii?Q?t4kD9olocoIXJHyZvOmfHMHQJai/F4OeoW9Sq8AwKBnn8b6SOE22QX4BZzVM?=
 =?us-ascii?Q?3Eqe+DHxh2z6T/Zfy8Quh0dIYElYBbJh4VAA9PUGsZWG9Y7o2D6kc80Hr8Dw?=
 =?us-ascii?Q?B2Eolzxs3uRS1lHUvUOP/3Ua5wsrsNN6de8LjIz8Nzd/EOKMYFDzqA5LqBw+?=
 =?us-ascii?Q?Vd9b3iD4bQiWk7yp4zr+8xAimERij5su/JBD/kh5kdhR33Vvfx1F6Dc0WryM?=
 =?us-ascii?Q?tUoVOjLFUxwA/SLUEIxv3PFWkYR/VLhbIis7UW558gYpKsjf0+5XV5ucgCyz?=
 =?us-ascii?Q?TjdMAHddVamyvvDIAWpVigPTt3NZ8BW3hLYa4eOpMEZ9nONGMxDOkwYI+zSY?=
 =?us-ascii?Q?CsOpe2hs4r9nf4sACiBXvTTSa0QRyi8kaBoAKsPxP4uzMhJdR42xBuz3mHRS?=
 =?us-ascii?Q?7pWYwIccoHWgt2gdHOBayiDHhWYJMovByzlxtADZPtmgQ5TGBxOFNxDS70Zp?=
 =?us-ascii?Q?MM1ur/VfYoBXMom5StZT0YyVFC1AdU2t09ASXXDLjL1z38TIHkRjABdDoaLN?=
 =?us-ascii?Q?Ptob5tLFiIrbBiDhlkIEWdcTaVMM7GkcoJnQteCaO52z+NZUeyBF5O5Vk0P2?=
 =?us-ascii?Q?G39lYDXwvU5l2REeZRPIJSI6BaxZtVY0wg4/hoM9qvIV3kSKNvG5QQmCCxDD?=
 =?us-ascii?Q?PbmP16rdJqmiKJgF3UkjKD68C/pYNplJZgIRU0ErD9U3qpx7AVfbPr+Snqf/?=
 =?us-ascii?Q?TDtR2O4a6PP5TyARSbGZlwnySuuyTZCuDe/5wpD/84bCUPvv5NxK8eV4HV5t?=
 =?us-ascii?Q?4zeY8lR3OAABVkFSYSqt5Izukhs3D0HncndWvAmxlfZ2J3Hs4lwYbzoiwzwn?=
 =?us-ascii?Q?pvib1epmjHNDEPGB0eurCDlNLSLW651XJQIyNSPryZ187JRHqNAK00bufJe6?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ba6b86-9618-4580-ce08-08ddc9c2068f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:22:12.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xWFFisLi5FUP3+Ed2CWZ253v/fPHOcbYztoEZkENsGtsInyKIRzl+mR6bSVLOJHKbw5xgOpXobTHVpQ0qYuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
X-OriginatorOrg: intel.com

hi, Aaron,

On Thu, Jul 17, 2025 at 11:52:43AM +0800, Aaron Lu wrote:
> On Wed, Jul 16, 2025 at 11:20:55PM +0800, kernel test robot wrote:
> > Hi Aaron,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on tip/sched/core]
> > [also build test WARNING on next-20250716]
> > [cannot apply to linus/master v6.16-rc6]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250715-152307
> > base:   tip/sched/core
> > patch link:    https://lore.kernel.org/r/20250715071658.267-4-ziqianlu%40bytedance.com
> > patch subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
> > config: xtensa-randconfig-r121-20250716 (https://download.01.org/0day-ci/archive/20250716/202507162238.qiw7kyu0-lkp@intel.com/config)
> > compiler: xtensa-linux-gcc (GCC) 8.5.0
> > reproduce: (https://download.01.org/0day-ci/archive/20250716/202507162238.qiw7kyu0-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507162238.qiw7kyu0-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> >    kernel/sched/core.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/thread_info.h, ...):
> >    arch/xtensa/include/asm/processor.h:105:2: sparse: sparse: Unsupported xtensa ABI
> >    arch/xtensa/include/asm/processor.h:135:2: sparse: sparse: Unsupported Xtensa ABI
> >    kernel/sched/core.c: note: in included file:
> > >> kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield
> 
> Same problem as last report.
> 
> I've downloaded this compiler from kernel.org and confirmed there is no
> such warnings after using bool.


want to confirm, do you mean you can reproduce the build sparse error
> kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield


then after doing below change:

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3c3ea0089b0b5..6eb15b00edccd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -738,7 +738,7 @@ struct cfs_rq {
        u64                     throttled_clock_pelt_time;
        u64                     throttled_clock_self;
        u64                     throttled_clock_self_time;
-       int                     throttled:1;
+       bool                    throttled:1;
        int                     pelt_clock_throttled:1;
        int                     throttle_count;
        struct list_head        throttled_list;


the issue will disappear?


> 
> Thanks,
> Aaron
> 

