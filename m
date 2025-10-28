Return-Path: <linux-kernel+bounces-872955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F61BC12B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AC77354607
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611E3277819;
	Tue, 28 Oct 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7MFLhRN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4151EDA0F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620067; cv=fail; b=CiVOSwSMn1HMxp6xnUdBWfMrJ56tqEOqbmEu+Wr5pGqMtDyxKBu3/GLvxWSp9JtXN/fKX7ztoEs7hCIfdlU8dnULuRtav+V078tg80DfyS7I4dQbXnM3bxVwxfIFX3SNJWj6wD2ee1WE9H6sK6xx1L0XM9XgX5/h4fXx0KDEkKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620067; c=relaxed/simple;
	bh=/cMQFsNObkw1GSlSNr4nwc53u1W23U7ktp0ixzrM3S0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bu5MOzYQdAtkUQwke36KaGbXYd89uqWUF+ooQlMgoRQqOSEpLMb7BPjK0Q3i+gkBNpm4Psgi6JCrqUCRzk8PHufR9drR2RpohAafFUw7x+untNpLPhAfpE7hZbjDaXdUatGbSFmpbQYMa0oM3V2TtO2LLrHZrNBD2AoUmAM7nQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7MFLhRN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761620065; x=1793156065;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/cMQFsNObkw1GSlSNr4nwc53u1W23U7ktp0ixzrM3S0=;
  b=F7MFLhRNqJXhii+1kafDOQjOOnGnbYcoAGr21w/2QJ15dkPSfW3wzCgN
   /7iL4UYwXGTdIO7Uv2gFql0PXIh1hTemSZDCD/pamA8rIKWhuclV0BZQh
   s1dhYLz9G7i2ragx4ehMNlqqun7q4VElUByEhQiWS4BxNl7VNee3jcvE/
   mg8LquAystK+0W2lvuFOHZtV+WHbRtE9OCmXF/QSiFoSMY8rpuEg3RBk0
   eVRWwqk1WwWtgLYr1sGLMAsx9gps3Rsap/f4xiHNlsRTbxIOch0890hSG
   aGkXPCZeal4jzBAB5CCq+k2Vqd8heZ++0De+Jit0gOogu/4Bf8mXsNMJo
   w==;
X-CSE-ConnectionGUID: 8DyKLxGwRpiNQ6o3LS6a3Q==
X-CSE-MsgGUID: yhYj7w8USYyoMtfcg3gDuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63619446"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63619446"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:54:14 -0700
X-CSE-ConnectionGUID: Y+XshvYJRbmZi/YrFjHqDQ==
X-CSE-MsgGUID: OLVeZOCPSFur18pnJdM8dw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:54:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:54:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 19:54:14 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.60)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3o+F/zTHcinXPQ4pPQHuUkDW5jt9N7lBxEE0jSqHGs5veK36vad/LH68ygH3n0MubFwdtpAdfvqYdMk0CQRNord76f+lCXYKp79LA7K3sx2rLrQIb7MlP1G1F9cpLhmQRhVGntQ0wxlEthWSzcp5+NeupvjVM3/y6C9jhvA/H2IH/1R4DyyuW41N43+7C8uETMC0f5fKW8Iv2ZRibBaZBsx4GA2c5xJ1FpVM/fLZ3d8eIO0weqIsl6yXmYDI/LwSO3GkW9YZdehJZAscqikRnQ7bsyH1deSqcCbhFiaufxS0GJeozvFqrjGpaK6Uheb/iX5aDcdHR1i/lsxiSznLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OprGzfF5C59cmqti2sRgoAiUUJHW/Z6ybn6wXZXAHBI=;
 b=pxkQaKpeXiLWG2ntZi2uhQW6Z8X65bG1fN1RdH5xpf3OFsb5PG0aY3bo581UKvqxkMYu3KvadvbGZKn8Cclepp5xi0BaMZ9wVNmweuyyFEtPfYuQiX2857DGXN9RP31410OJf2S5nAevtPU2yDSuJQ2OsAP0UYi7ORywL9YtynHT11ZkmCx2M8q9EKE/pHQkRPnZIZZUIsmK4/usEHKPpHo4mcogA/CqexbZ1wUPm+6SJo9gKUX9ryO5IGG3Ux+QKJ9AaKiZY+1sGJrK2HOJUNtl7LVNSyyQfPjvV7ashMeJBJ1mkHe6lg3NveYDYaT3mMjfvN7h7R7gMfZWnDrGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS0PR11MB7902.namprd11.prod.outlook.com (2603:10b6:8:f6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 02:54:11 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:54:11 +0000
Date: Tue, 28 Oct 2025 10:53:58 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <reinette.chatre@intel.com>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>
CC: Farrah Chen <farrah.chen@intel.com>, "Kirill A. Shutemov"
	<kas@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 16/21] x86/virt/seamldr: Handle TDX Module update
 failures
Message-ID: <aQAwRrvYMcaMsu02@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <20251001025442.427697-17-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001025442.427697-17-chao.gao@intel.com>
X-ClientProxiedBy: KU2P306CA0074.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::14) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS0PR11MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea6b530-f248-40f8-bce5-08de15cd4594
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zF8RiAl5Aj2q3/ue1yhisiBBLQhp+29EpRaEaS5CLEOq0K2Y27Pe+GtIHm92?=
 =?us-ascii?Q?DgW1GySi5BjdR0So3SWleqrOEvWfSoDeJVEILxO7qQ7XScubDSPlBtQAe18z?=
 =?us-ascii?Q?5mDPLMY0sUi5rVZslTJ+gtdFGciDsGhuSCjT2AwK6m6OzFQohIAHm699L0YV?=
 =?us-ascii?Q?PFlRPdcwVN1kx0ovjQrIz3H69FOxyVKWsZuMAwdtePeK+GxJxoYu2nDiTTE3?=
 =?us-ascii?Q?SZ9VSSesdQy95TlcsHbI775tu1h6zXLR2Y4LITS7NKQqFw3EUNjT/4fFRS0r?=
 =?us-ascii?Q?sbbFq1q+FE8Dz+7c6mglgZPxKmmOmJ0PAK/2/5dQdXJziy1btYsD/P/uB19N?=
 =?us-ascii?Q?D4QJ7CA6GP8MlfN4j9dPinzsCCSc6CHUiddt+pPfzRyQeg9wf8dlWqRx0kC8?=
 =?us-ascii?Q?3mdbO1uwUKYgcAZyUHvrf0JdvlqiWMrkYn/sDtO55cKu6i5NE2oVv1U2Ew6z?=
 =?us-ascii?Q?o/VXYImZTXcY7Sb5ncvAuW7pJodTPKHIcHJalGr42gZhpJFWLUDDOLmzwF8I?=
 =?us-ascii?Q?0z+cTH6Vvhy3ZlfZvPkoCKmUG5jN0ynZmiA9Kwr3HImG+v45QAGQW9iyzKxT?=
 =?us-ascii?Q?iR7ArULLEpfN6XXzID5aTjPdaR6EDEtvmaT25TGiaZzp02RND0pZZRUHyQ5k?=
 =?us-ascii?Q?gtkcWlluxBgGnUFn8UADoUd4xtt420+jeCWGWk3CP3NERe7yKvakCE9f+W2O?=
 =?us-ascii?Q?ZS9y0kLpmYw9xNJULjsX8gXvIaewpyB0qUuZoA5ICsvEDZWkY4aVcL16Vd9U?=
 =?us-ascii?Q?BZiYEmHCSdKEwOYc5xKpTnJDY2dE+qpu6yholcxURW8UkYHfyF5z8RelYXQr?=
 =?us-ascii?Q?995OIjPXG507oMQ896JdDCt19Mc61lpT1KmRJPdbrr9j/fAFRoPAXQiYsN4O?=
 =?us-ascii?Q?7gwZI80dFlFf1LkhBtJoPvayImtTgMyXLoG1zhawImj4tWtkjUXaQRcgbEiN?=
 =?us-ascii?Q?2QWeN0R+OCJFUmehQ+xOJZFJh5DQpAZkEuYAWiXcFYGBghBJr1avAVeMb2zB?=
 =?us-ascii?Q?9WR6vSBWEXvu/DNhkn04TnrzuWHuIW8gTu6O0XWke2E5+ogIE5i/xnzhRDSr?=
 =?us-ascii?Q?kII2dZRzO/moEiUaaP/IvGrmkc6YBajXWhjm81Q+B8W+2B/jVBTSaPRP0evs?=
 =?us-ascii?Q?TrHsPhwQYUtSxXZhnfGFNdTBll/oFUM8bjlpNv7heqaka92cPELrPqsRv0WU?=
 =?us-ascii?Q?fKMSUVcxjg1qJCnMgGvxvr28uSoVSJrFJ9GuDXaVBIPsQy8pSj1LCxHT486C?=
 =?us-ascii?Q?NtvjzaSFfu1tGSQ+nw05glz0ol7iztEGvr0rik8i61ved6hFej32RCXD1GCL?=
 =?us-ascii?Q?rpdhOc/6o30Mh6YO3BgKx+pfEwTbI3yQf1MvjRvefDZBCbdQManG8n1P4dpW?=
 =?us-ascii?Q?+kzaQKZ72nC/EKKhp7P5tn98lmYCfxzbaHNH76nAOJi0MP8XlA1Ik37BybLs?=
 =?us-ascii?Q?jwbAVkgBZd55uVIF6E/ARU1WE3PH6sikPZ4DEv/O5EUQ/0JyRUkYNmAp7LBw?=
 =?us-ascii?Q?2ZO0HTyjLOtdyP8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecau5s75VgXYf0oKMifbw5ly6sCDfw5xXqLtR2j3CvF089CRz67f1T8EJSBO?=
 =?us-ascii?Q?RoHcG6+NAxV+L1LrelZPqJYrpFmLd4tM7ois7oWcsawTb3TVaNWqyu3H95vE?=
 =?us-ascii?Q?SdWKoPxPcegIBkd7d30QGvriF7PQjHSNoIsaXfEWj1yGNecVegd0tZIV1FqU?=
 =?us-ascii?Q?CkB0I3gDaggQyzBIvMFgXHqwp6ehyS+3EBSETdnDoQCt924dCsrOZGk7zS4y?=
 =?us-ascii?Q?xcaj9euCTMBQaIgGwFrNCcC0CeAvg0pz3SsGJfooPAt9bvOBSP3kdfa/Q7NB?=
 =?us-ascii?Q?Faaa+xPg5Lhp9pe4vlS041pUpfW1I6K6NH5TI+zt/0oTYocDII7rlnH6vmGE?=
 =?us-ascii?Q?IMCZX7U/nQxGb1FnDzRDGKUAWOowk+IY2JV0ZyOf124P+eWNT1PH95mWI1ak?=
 =?us-ascii?Q?/PEEVnpqS1uoYh86/Lw5LCxtwAVw/N9HcLYmvARx9IZ0l409LCoVEzhMh7HO?=
 =?us-ascii?Q?EnwVno/GoUCDiYI3MWMAwBh1qtyNOungcI6MYcaji/GmzOLd6xLPcEtn9nZJ?=
 =?us-ascii?Q?DpSiTaTxjllJpBXp3lRvGMgfxA6vOzOz2upVLZ+8cPT5kwlHV3+UfDEQGq+T?=
 =?us-ascii?Q?xd7c3yG+z+c5D/btPGKHHI+sVF4CqR7CuKF4KjcBFsTNKVvL6BzU894BP2+E?=
 =?us-ascii?Q?uxIFEsAuaw8TI+CUehhlszJn+TveqAu0COtR5rimIDE5PuE32Zfh+eFdhg/V?=
 =?us-ascii?Q?UbJH3XPWKf5NczoC8qZdLa7znz7q0t5qNzRQeJrmCgLUeCUVyxA4o2mqERW1?=
 =?us-ascii?Q?z4NrxA/+ljXrPs6vi0w/XLmBsllqUmCIhbIWdZ8rJ4aMl+xahqNIgH660ub3?=
 =?us-ascii?Q?p9N7nrk312hxqQARAUy2a1ythbzJeeg1u3bydaHVx5A83RvslHnw0BSCFNuQ?=
 =?us-ascii?Q?cvlqzyIoF1BPYUudrrRT0BuNxFBKWtskemLVixFlThDT59RvUGWEXz/Hvfac?=
 =?us-ascii?Q?M/hM7xYYV+/ZuLsz0R4Hq4FBPxJs4q5hV7avAqnReee4ffPF2DEQ0A42SQM6?=
 =?us-ascii?Q?1cMwHz72hxYg2u09HUwkwg8LyLjw+5aasqfxK/56BPvrIzTTmgAZeQz/tsX9?=
 =?us-ascii?Q?tROxCzrZRosOqeTL73YrDHteBsLLGPOJDS+M8E7isQ3VbiDyxqZHkxr713an?=
 =?us-ascii?Q?js7VAxliejBNGPSqgAZVS5GRg60ZWWaiJ+Nb2Nvz0akhz1C00trAwCg5iF5b?=
 =?us-ascii?Q?/TdTqqDfGMxorJSR8auVEF6iH9CpfBdhuVLwkEmL5wSGsDqBEbOPVGXZArBj?=
 =?us-ascii?Q?I4hNOrN2R8oy5/pPh269wJNQMjl67vaBxfKIByQvj/g5PDFz2Y2bBZhEY1+j?=
 =?us-ascii?Q?DxhIOjpqdjNx25VkW8Awd2Ud5G4A9S70wj5SeSpEKCvuQyCJFROzwZ/+oaDf?=
 =?us-ascii?Q?621eCSubWHAMPL1OXatyxLWOPjObnjlP/A3beK3ARnhObz8lu1Vtc6Uhx6J9?=
 =?us-ascii?Q?bjNzkGMiEcn++RDRZZndZtyUgqu/hq8av3FQAurjYxVSGreB9VQFcjCJ1kys?=
 =?us-ascii?Q?JOl9G7P7F4B+sfY/JALJ2D0GFPU3hVrrnXEWB1bdlr3URZjUWh2wpgDN61qy?=
 =?us-ascii?Q?iubtqVGXGgDJSYlb6rlXaCU0Z6+TLT6RtZQEIq06?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea6b530-f248-40f8-bce5-08de15cd4594
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:54:11.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EFWCtpPrpnQ0SW6H0ZbPY8gQ4SHTV6WEL+AK02HUcYGdVWwvcZKAOqyGTnpnzYNvzy+20ve0NfQ4cpJv8Vq0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7902
X-OriginatorOrg: intel.com

> /*
>  * See multi_cpu_stop() from where this multi-cpu state-machine was
>  * adopted, and the rationale for touch_nmi_watchdog()
>@@ -293,8 +301,13 @@ static int do_seamldr_install_module(void *params)
> 				break;
> 			}
> 
>-			if (ret)
>+			if (ret) {
> 				atomic_inc(&tdp_data.failed);
>+				if (curstate > TDP_SHUTDOWN) {
>+					tdx_module_set_error();
>+					print_update_failure_message();
>+				}
>+			}

I found a bug here.

If an error is non-fatal (e.g., occurs before shutting down the TDX module),
the TDX Module remains functional and TDs can continue to run. So, there's no
need to set the TDX module status to erorr or print the error message.

But, in this implementation, a failing CPU doesn't exit the do-while() loop in
do_seamldr_install_module(). Instead, all CPUs fast-forward to the TDP_DONE
state and execute the do-while() body once more. Then, the failing CPU reaches
the above if() statement again with a non-zero "ret" and "curstate=TDP_DONE",
causing it to incorrectly set the module to error and print the error message.

To fix this issue, apply the following diff:

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index a72f6b0b27e9..e525bbd16610 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -258,16 +258,8 @@ static void set_target_state(enum tdp_state state)
 /* Last one to ack a state moves to the next state. */
 static void ack_state(void)
 {
-	if (atomic_dec_and_test(&tdp_data.thread_ack)) {
-		/*
-		 * If an error occurred, abort the update by skipping to
-		 * the final state
-		 */
-		if (atomic_read(&tdp_data.failed))
-			set_target_state(TDP_DONE);
-		else
-			set_target_state(tdp_data.state + 1);
-	}
+	if (atomic_dec_and_test(&tdp_data.thread_ack))
+		set_target_state(tdp_data.state + 1);
 }
 
 static void print_update_failure_message(void)
@@ -331,7 +323,7 @@ static int do_seamldr_install_module(void *params)
			touch_nmi_watchdog();
			rcu_momentary_eqs();
		}
-	} while (curstate != TDP_DONE);
+	} while (curstate != TDP_DONE && !atomic_read(&tdp_data.failed));
 
	return ret;
 }


