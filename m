Return-Path: <linux-kernel+bounces-881077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582E2C275BA
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 03:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0E0421AAC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 02:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE7E220F5C;
	Sat,  1 Nov 2025 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOBFDoK6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911517DE36
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761962760; cv=fail; b=DRHCaRRM2iRT0lm2Mi/vaZsSMeb+ehx/8kODq1itW1ApuaTpBRL4erbX4pZekgXaWu/Zi2HejHN1pEQ0ZoFkO/jq9iaWj8yK3zCQkU0Rs1y9Zv/qCGCa+BpuWjBj/x3jVwDn8B9pOboRG4hGvXFK7BJKRglCu7jpTUgwESO3TXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761962760; c=relaxed/simple;
	bh=CHAKLMMMS/Th68aMuPqQFTOIUnTb4FDE0iRVJn8odKk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FDRjRP+tcV2BsZtIQjBupmd1rT2ZoT60SWuisOOZ3ICUfcAHkjqrHgVb14yy8z/O9EfpED22nsQpnT3NexC4SImQ7Nrpn3d7mrMZ8peewAsHIGeyf8hkpqXVlBWiNONFkLrf/r/rBfBWS3Fnt/wPAiIn48CSWPJfVae+7+VuJc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOBFDoK6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761962759; x=1793498759;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CHAKLMMMS/Th68aMuPqQFTOIUnTb4FDE0iRVJn8odKk=;
  b=BOBFDoK6FCBDlbqSIh3L830zRd3fqKr9I1u5vJ7UJTdWW0dh2yPxAuoE
   jgHu/pgrjNyMb2hF1K070lGP0aL1pdpMt82ieq/JaZdhDuQhN4VnX8l6t
   ERoa/NDSYlrOKBcSnklQqDwdJx8qTATikAru3cg/Caz3C3bVGjg7U/eI8
   SDBXj2FB6NLinZsjC25C8n0N8utTPwrLK9tcUwND/tcxvR4oCWfTN3MM6
   zzDSncy1bORclDmNEJcvQdyRLLLxtviCVPa5hBZovnQRPd/6gIssEwe7F
   OuF5HM+YeqQok9NaJ5uwcorg/49JF9K1pIeV9azWsavpTxx5aCpJCRp+4
   g==;
X-CSE-ConnectionGUID: gU/gxOeXRaGdEmJ5PBuVxQ==
X-CSE-MsgGUID: 41OEe1g4Rc6cPPGkY0Mvog==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="75478624"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="75478624"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 19:05:58 -0700
X-CSE-ConnectionGUID: 9x0uwvo/Twieasw0/HRsPA==
X-CSE-MsgGUID: wwLFsRR4Sjem4cbd+m67/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="186251438"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 19:05:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 19:05:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 19:05:57 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 19:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKRWQw1mZ70rRiD0I4X9vEbL/rF17+BZ4iSB0dCG3GE3TgoRkL7z5B1LBc2p80IM2VfFYgYQZL8KOwYTixQirhCJjC774VVFVlGJTedMGiIvUJrCG9girnCMS0fwim2RCyjmj04KPmPAJ5Bj6RKILZV5M3gfh6FDMmfyHkNAqX2cvSZQ3rxgf50wbFNMkYjdiuqeRREsVp9v0aZzEo5Ybhx/x0fDs9XgG9CVEfX66Dp8Eo7gYaAfnW0L5Mon9JKPDJC4KQuEIMF9QG3wiFsxQ1Lt90/XvfxDNz9YyiXf26lBSj1erCHWtL68OjhIfNU2jz9oKeeL1QLxKVKs2vuFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbFJxZq4mH3d5frX2PGIt66jPLSXAcm+MFLXx7PmOJs=;
 b=uyB+TlIurOVQQdoLtgUwxbQ+D8SrmALVC5xm9WukG2KxFc0J+TPQQuFOS3VXlcZGTetuc77cdMgV0MiTyGixyNb41jtSqogV4HIxfa7mDy0307MN1JudgOZmU3vE3N0jCixTScfur37Uh5mRjtn7nZUJaLpCpEKjWzKp6zsE21lhQwU5ic+k4rBXGkpRCbyGwQIxEGfNuYyQAjB1rEfHAVTZvVjxNw2vB8ased21g6QObYJIzeLkvqOb2/CYD3aDnf90cVHuRu6dbBz4h0+HmB/YOddW0ljx6ou487ZDyELVV746iUsKAZUdOVVFJhO30LEsYmbtQu8+DuR/EUnnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Sat, 1 Nov
 2025 02:05:55 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 02:05:55 +0000
Date: Sat, 1 Nov 2025 10:05:42 +0800
From: Chao Gao <chao.gao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <reinette.chatre@intel.com>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <vannapurve@google.com>, <paulmck@kernel.org>,
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Message-ID: <aQVq9tzQ1McNi/Mx@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <CAAhR5DF74PhX_YpMebbqnZOJom-sR=1s7xbhrk5WCTS8jn7U7Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAhR5DF74PhX_YpMebbqnZOJom-sR=1s7xbhrk5WCTS8jn7U7Q@mail.gmail.com>
X-ClientProxiedBy: PS2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:300:5a::18) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 63afea3e-0f07-4dcf-d774-08de18eb30d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aXJqSfR1rqD9aXqpv8MNFrq2segbZIxJrIp0Ki7KVFKv8Nxhhn7XhOdkC7YA?=
 =?us-ascii?Q?4TZG8Tq8PmdO4/xwC1z9QggwvAcVJuUbFclQZvxoPjH6cNqpYI7ypsM3c5go?=
 =?us-ascii?Q?+U1cwE1qqpPMF9FZuMj8yH+HxOiP0jDDgLIoNcfuDgZRsxpoqXdRl7f72TRe?=
 =?us-ascii?Q?P9Km6yzunnL2dxMpXDewspw12NwyDUSLYvESZNiSCZoGtdl6eumfDR2fHvwN?=
 =?us-ascii?Q?Eg/ynht5rN+FRqZMFYR3AYxVlospX1wqr3F5n8abHR82uHl4Pny5v+PJkSq3?=
 =?us-ascii?Q?MyC6pOYXvAoHmHdPyaM+Gi6DDQ3Gm0m7pOUlLronfGBCqaA8oSEyibdLpWLB?=
 =?us-ascii?Q?4V6L6VuBP3pvFj7g0sfjo9lKs7Rqj9t4doJ1ZvjcXYbBqmF0bO/UL8AJesRs?=
 =?us-ascii?Q?7PQMXHjj0M7fddlJjldLMHfvWnjmwW7bZCCwUgj4mfScS9qVTtutKctqPRw0?=
 =?us-ascii?Q?H2bqgrNX74fu1l+hgR9qX8k5tuDzO7+V6qMe25Hk7XbLzVMKf3JgvVHTIUfi?=
 =?us-ascii?Q?A6hnzjK9XMWd/N/nkMKxr+UGMwpMvW34SD6eVVwoqtx/1H6Rb0ziMSYPTC56?=
 =?us-ascii?Q?HZ5LV1dDwI2byNmiSplV9NwpbHTRaM7ZqjRcpER4P09QAnYKXPAUt3juZx5w?=
 =?us-ascii?Q?8zSe2k7raskOKAc9OFoCKdfF+IYFwcNjygVgWb9sguW41fEBk9ouvAyf+ftV?=
 =?us-ascii?Q?gVsF72e1LmP4n0PBnkzvOm0q7b2LIK4kNB1yeF1D4OB3+GkyqCYhDak5PMEU?=
 =?us-ascii?Q?hWrAk/lKjIfTXXnpll04Le4u+OeI8pWMcaMx0ayzdMf2xhTqXvh5fFdrz/yJ?=
 =?us-ascii?Q?WwaEbcwRpWBc4CiTEeXu3nvLyLHH5y47WuYSdN1POUQMjHpNJRvUDxI8YaUL?=
 =?us-ascii?Q?j3/zFZ4Iw814KnVd7tVdyDiDo93QjFv8d4mLlhI0wfbXbsOiDzaacbB1Ny+X?=
 =?us-ascii?Q?tU/TJ2ERDQgE0Fhs0+3zb5pYiABVXTPtXrUf3YwGrFAt8ooSqT584yi1lp7D?=
 =?us-ascii?Q?yZ3Pt7cxLUaYWEH15yJ/ZK4YTRBYctFK2OdpDJ/1+ziLn8HKqD9IzGnPHWXQ?=
 =?us-ascii?Q?9BzPaOZD4nLkChJYp2Pk+JUTACpzcp+7+BnjtpiFfZY+cnuVagilKfUbcX3p?=
 =?us-ascii?Q?UypCrvoQUWUxDr1zEvGwukr9ZCjT9lRDWgyV9NGWfkuwsEreUh8+oTN+v3RU?=
 =?us-ascii?Q?pL9RT6JgJRA/drJ2bH+x5uza+36NbeDPJUqYnhQeNjos2Xh/Cstmmz4/RAe2?=
 =?us-ascii?Q?ttL1+niDpo+NgxObUg5TUt6H+lpAJwWpd0DAPtqw9xXJD3WWOLoNMf7/yTks?=
 =?us-ascii?Q?KrFlUsQ/ZJfX0o73DRYgS8ffEbqNvxq/cordC/u+OeaPxS3tfsQ7QzUAjlyR?=
 =?us-ascii?Q?IKlLQFCB7PYh5Cqq0nlr2rCUUQO33b0ZzXXMIALz3Wqmn2hmKiwHUnFkSGjj?=
 =?us-ascii?Q?Z0VnvMQoUrx4DbCExmrmZDsh9HDzzKq68ggqYFkSyxqxksVPBOheDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/1/Cjkgc9biUOTofrpkNgs/BJ1WbTZDRMDLDRow2mXZgu1wJrOh3nJi0APG?=
 =?us-ascii?Q?ZI240gVxcWaZOCsSfddc4AD5AXhzglehWcIkVR/s+NJn0sNqIVtw8gbtxsmZ?=
 =?us-ascii?Q?mPmkfk9rcNi3NcfueDyqXP3puQYa/VUnsAodhSgOpyawRan8jKKeg4f3enbK?=
 =?us-ascii?Q?y6AsbFdmgmpCiD3njxDtVk3J3AJQRFn6p9Nt4l3VyXQS5/EakH24BmTDdjzU?=
 =?us-ascii?Q?8eAZPNVEyCBfacEw8ziY4qRIVWszi5PTH4IcQLfTHqHeLcdjL4iEIfShFDO8?=
 =?us-ascii?Q?5km25itrIs9WlcxNIgXkq+21Si4dqtujwq1GkvRvhkoDQWi5hnJVr/c+lMxz?=
 =?us-ascii?Q?NIU43lItatxsvXCsds6BySYJxhYkrdssWDShnDr1/e05giMbX8gxNQueyyPS?=
 =?us-ascii?Q?AlKo8dOLECar4D9gn7nrZ4yWLDDctWdw/80O5I4xJQ7Y50bUuNfftRZTllxt?=
 =?us-ascii?Q?R4PyOyzGL3vIqG1PJNlmJ9CO4Qg+MBatlMFwzcavdxWOMoo9t9yWvcH6x5LM?=
 =?us-ascii?Q?qJZwYsAIgcXpVpk9aLAGi81EQO2N7P6HJ6CEwAGgScV4a/X2D05JKg9rICg6?=
 =?us-ascii?Q?O3Ifqzyr1PVfxfbRC0d7juSgKYXh2qgWCqv52wb5y5biKu2CMlbyApVSxJK+?=
 =?us-ascii?Q?raheQD71Ty1BJcyH8sKpIU6miRq9aiqUZd/MwQdNZ2ElM7CGU0TcIM+up0QC?=
 =?us-ascii?Q?ocuGgEJmFCjKoYSyJoAYDAfSjmUS0FgzKcfNmsdxZCjHm1RM4jo+cFpF7yuL?=
 =?us-ascii?Q?Qp3zRIdnjaetjiUieMio44VefEtIHYd+jCO6Q+WWnBAHrN0DLVDpC1ZjUCzd?=
 =?us-ascii?Q?0njQ+2zQJaOZ1h76g2JiWPHAPn9NMA8Q/7pRwD8BvyXhSx7D80f9/1axsZI6?=
 =?us-ascii?Q?yifTrVeoD+ML0JEfu2BklrmqR6V4YCjTZDR7YKg3dJ9ZsPY5ljpQX3sC/9Mg?=
 =?us-ascii?Q?97czFdmTDe/0s5M7OX/wpIbB/LG9vNtnyU1LxNAo0a+/da85nPRueGQyTOEO?=
 =?us-ascii?Q?5kJaiqrDcwGQ38g+edmB4Oj8+//f1JegOLIm7Pacrv/H37Jaft/1JuvdHPdI?=
 =?us-ascii?Q?DLAtHSNuGxh6IUz+qxHeuloDeQF+VC/GX2PeMANcXC5PBMhaQOSmb8vkNH7k?=
 =?us-ascii?Q?wENuL9dpUSbc9Hxobn1DYFatm2JlTx6sEu1foqme7VKz+321P3RjkarAJSKS?=
 =?us-ascii?Q?ZJL9RIR2XMSX+8O+QXqvM6t0KhGHC+7026Zz6Spe1RPCT8VhvvwqszfymDQK?=
 =?us-ascii?Q?j2YGz/CqJ30sPowgig0msR1KvS+MHtBVqG44aBFarpuQDcSGdN/ervf+skbh?=
 =?us-ascii?Q?DCH5stZuOuT1WS0RGsdV/NS36JKd0P14LRyPvdbi1YdW0kuRSuXnDuPDUotK?=
 =?us-ascii?Q?h9lMN/rQbcvyOTM0k8Z3THLF1X4KcW8S6L5RoI/Ee8FsY1cfH/nQW7aizbug?=
 =?us-ascii?Q?+ZK1OpbethBkE5rfOlkIL3vxgjxGIuDDEN9yXQPmQXuPIHOZzTlx/643vAm1?=
 =?us-ascii?Q?H8CflVjCJhga/cFwxjWXqqswEMPZIkTJnYdTCle1MeEYPpHyOTABjajyI7+o?=
 =?us-ascii?Q?Scn9VQgoNQA3VGQpBwmeCBwpZ8sYbnN6sBHKHjJC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63afea3e-0f07-4dcf-d774-08de18eb30d3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 02:05:55.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmXZOzqXXyM6RjgOeqAs0BBGO0rq21Nz+G4GXWkRTBEpwK/5zWc5YgdO5E/P6i0QMnH7UCFi+c0a9nBcDweLfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com

>> == How to test this series ==
>>
>> This series can be tested using the userspace tool that is able to
>> select the appropriate TDX module and install it via the interfaces
>> exposed by this series:
>>
>>  # git clone https://github.com/intel/tdx-module-binaries
>>  # cd tdx-module-binaries
>>  # python version_select_and_load.py --update
>>
>> == Base commit ==
>>
>> This series is based on:
>> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?h=tdx&id=9332e088937f
>
>Can you clarify which patches are needed from this tree? Is it just
>"coco/tdx-host: Introduce a "tdx_host" device" or is this series also
>depends on other patches?
>
>More specifically, does this series depend on "Move VMXON/VMXOFF
>handling from KVM to CPU lifecycle"?

Yes. I meant checkout to that specific commit. both "tdx_host" device and
"Move VMXOFF handling from KVM to CPU lifecycle" are needed to apply this
series.

