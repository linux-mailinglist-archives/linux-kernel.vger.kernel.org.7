Return-Path: <linux-kernel+bounces-724897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDAFAFF842
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6E53A70D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED46234963;
	Thu, 10 Jul 2025 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGgog6EE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A802036FF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123407; cv=fail; b=AEABjw3bRBOILrw/ET/b8vmRwEhMkdX23hEt6oTxCk61LJtHQhRpkYVa8oa0MinZpprFgXCMwor5m3iiQFNeYCKguDG4es6yqzFNKpXwxUJEjnT+wDlSfXL5MjkjbkOJcJpWybz4mWXya1ghj1a6VRfvWqnqbqTngf6E5Y0ZX54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123407; c=relaxed/simple;
	bh=73FYtMg7W5cxNDUErQXIt38D351aJ9djFNiEF6z6aCA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u1ivoGPXwzQKKCjJvoI4cElDeCrVBfmOSKoiHY10yJPOdZB/FBMpb42JfDt1UcVslx17kq+g6iJH23WabNX3L4K1hkEXc9o/1Gnrofindkb1rinvG8t4cYJ4+5mHC9Z7TqpAbOdDM/Wmpwcv/+jWVsSHa3eLifUZAliUVRR6kf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGgog6EE; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752123404; x=1783659404;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=73FYtMg7W5cxNDUErQXIt38D351aJ9djFNiEF6z6aCA=;
  b=oGgog6EEOF7yQrJba6P5Hhc4TPybTuNJh1H1kpOpRD7xdUiLDXLjP2Iz
   ZF1qDk30EtkqyezY/Wicu/QYtCwcigqyVg4e8AOIPoIQitxO335PKsgmF
   M7tJmRbypDR/fopW69ww3ZQLVntVx4KeslUT21eDi/2yuLOMQ0376XVGV
   pKy+v7RN7ehs6y0qUU5ylBq9NziCan2LA8M90k1/tuluzdOrlM8Sv0D6r
   w2srvJ4lFX8LhtpiqRbzVN/yuCEbsAFQ52PTzStbYl3JEJyL81mf0SsXU
   C+Xlf3emm2LaukDhCNRZZTM5DLzDT0w9wMIObapqfPrnog4LXlaW1Tkjp
   g==;
X-CSE-ConnectionGUID: sPaYNNCyS0u6otkDm7c7kw==
X-CSE-MsgGUID: A1K//JqxSnSY7ZXHLLf3ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54364816"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54364816"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 21:56:43 -0700
X-CSE-ConnectionGUID: 5rH1xcc6SDKGfPnbXJ4VTw==
X-CSE-MsgGUID: 05yS6q6HRzaPNH/lu398gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="179674103"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 21:56:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 21:56:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 21:56:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.77) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 21:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTFDJMRiH5/l3JwPqoVzaqxb1SlY7g3rlrm8Szu1iT3bZRLPmZIDA3doAyijIdEnHw+QIdCGF+Q9GbeBdJHKcsyEcT/a9WQc6KwS/UoVEn/NqYpxyMxHXJNsec6caITIKX/hesi0ow0KaKN1H7c/DggT83JvH8UJc2unHLT1S1czmeRVAGOKoJkLGDMFG8Lu+ZoksWusplhIGShQ7QYR68lryJ7oT6WiX5nvB9sJYq5heiuzLrBGz7HMSHXUOTfueNWGXKwG+9F9w+/Gg2CjTDmB1QG+0Zgdwc6nUL1Atkz4+YcJvxFXSGKI11ByGlWWJrAq4bPk0GFKaEcY2jU6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc3UwRpagtbDoEnanQCcU2Vzt4cvFbQcvc7PgVZFcz8=;
 b=LW/Q46skod1+/834TM41OsAyujQPAo9qE1WvNgWGiLdDW5AJtUz0+shk24EzP+TQQzDT4SBWAtkw4NVOnKLhSVGXv4+2829rcjIgjUSdvHchVDfh/a4XxBdQoNXWUXzbzZ1BhRmoI9/0D4JN9AtomzOHCLKd9p3abZL+odiCeB3RGCPtZwiH0fCUk/3E306dlD6LGKXiQxSSAFOOH8WshZta/nrY28EBwSC6Dml80aQzTBAZf9TrOhy7Jf7WtUV4qckTmoO3huhiqkQckXwzWhzjEU1IjDoHmAQ33Z/7XT6BJjC6uqr8tW8NgV9UwMe3VtenbmsbogQjf2hYo5zvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 04:56:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Thu, 10 Jul 2025
 04:56:30 +0000
Date: Thu, 10 Jul 2025 12:56:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gabriele Monaco <gmonaco@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer
Message-ID: <202507100606.90787fe6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250707144824.117014-3-gmonaco@redhat.com>
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9fc94d-47bd-43b7-ea27-08ddbf6e225b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukjsD9dQ1+B1S/xoWCx2UMTBfCloRwd3yQOSIHwmCcNa7fY8xbAFPTk02jUP?=
 =?us-ascii?Q?Yp8iwUT3VragwXMqQyT7q+0v3xoR75yVa0bBpSUJC2Otf0TY6nkqLME4MTlC?=
 =?us-ascii?Q?rYopxio/rohvPS38NO3RnYUyg1k810ZXtG3o7E1EKKb4GjFFoPRi0mgVUkkK?=
 =?us-ascii?Q?gRe7ZoxPoMHJUPZgevxb5n2u0mg+5xfC2pGa3OdICUN50jXJ4xKARqKCf6QA?=
 =?us-ascii?Q?VOjK5nMJ2muPgbQmjOuhJoCMee1bnrtNIVW9RA3fZwbxkta7sg26LEQk4MRa?=
 =?us-ascii?Q?FuVqdy7594TfBL/35sXsH7ik7CmoVkG/cqWbqwSMesXBTW1VivKdMacJd5wC?=
 =?us-ascii?Q?S41d81GrKaPV9X4E3LYiUmqhfEMP3Q51p+p2jZ21G7oXyb0Vuw5uw6124BRl?=
 =?us-ascii?Q?Wayj7onyU8DRGKtGp25W3OYAC63Rtmel82npDzzWnrc3So8o43iVhZcweXQM?=
 =?us-ascii?Q?2zXi4VoRn/GYN4uxBwKH47tlNAxx2qzapesoXOYFpfRjlIcgZVIU5WBFshBr?=
 =?us-ascii?Q?ncPjv1Eo/YGsl86IaXSS9vRSXcFxcZuMJ83nuEJEFw6RaPfeEwdU/4jRBtk5?=
 =?us-ascii?Q?OwO9Yc7Fq9jhorhn0gMNJKlMjYCIeXRPzWUxVKJOAkIZisXD2bKSLcoe1CE+?=
 =?us-ascii?Q?hBRp8rCTq/V7qYJVNzBQi2WhhlFpAaf0EJtIPs6kyqHTqOou7VnwfdJNXvuw?=
 =?us-ascii?Q?bPfhzWKxQzhORRwSGsKf/hVzE1u9mR3kG/wJ/A9ecDZ23i49AbtCMpvUHJlu?=
 =?us-ascii?Q?f+3K2X/8BbogoM2LdsknSycex6FGTUp8PJG2GpWUzrV+RUUpMxFjKUoF2hX1?=
 =?us-ascii?Q?r80uzxMZV4/V01C36y/VAFDz0fhM4/Ozq+zKolitxa8RpbhgKN5vEp/3MxLw?=
 =?us-ascii?Q?tx8oTYhiT646WEg+qFb27/fjWglRYONGuY6ZZjjpdFP9mRnoGW9A4sf54jD4?=
 =?us-ascii?Q?4hdbnhRS/scGTBmJYHS6Qi1bDbjB/vwJf5VMmEDjSaK2PaE512+9PE3yZbMT?=
 =?us-ascii?Q?DRaFZfW2+NO4QD1KGgRz+enwWibu2bKN3+o/l/ClRlpHaSg0Imv+4tqb+VgQ?=
 =?us-ascii?Q?IZtIEL3gzNZM0cbJP4TtUW86inkjw2cxLDtficdeMjZufEUns8iC0m07H1kv?=
 =?us-ascii?Q?D4MiG0fpb0ArEJLtmFRT8l5WNjL7+BseAH0pPBr6Ygr0IQ+SOB+WQtMBV8cd?=
 =?us-ascii?Q?iI1MzTcBIC1eK+oy2NlNS6frrlvDZctQVjUOUHM2I6gxD0HYCw5dpAWT5jej?=
 =?us-ascii?Q?YmYT14wdScoWylVzjU08IMBN0dRedAXIKcntU6pdbATmMd7MG+qZRr7ShZEz?=
 =?us-ascii?Q?yS+q6oFnF5RCITRK7G3VpFpEs3hciRcaSoFeuWNVV83ATKKj/RIowZzNeTqK?=
 =?us-ascii?Q?f6zXLmcSXePau3UzPyR05dMULL6d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7p5syx49/iEE2g8W5OG1ndtsZpqMPu7jX97d/XAhsK9NtikgRv1SaMylfZkJ?=
 =?us-ascii?Q?4FxOJivvmIS82C+qVe05ypk/Z5FZFzV5HE8krLhci3hSNJqTZLQ+uaJfJj6q?=
 =?us-ascii?Q?zkBTynXMfZbApQ0Iy8Hs00MZxpDxpA2fxDo6+Zq5TNmwMBsAgqTBWNkQ3aA/?=
 =?us-ascii?Q?AzmCUwRSnDH0qYWdWR7XnNxOAfNQU7wP/az7VfotOHJacf+M5/RvBaN8UkpC?=
 =?us-ascii?Q?07zsQcaE/2+jHg9lGfpxmLX1PlvjDOFNfKGovbOMZoxIwPhc7HQ2tw+1q6r7?=
 =?us-ascii?Q?nVCBxLhGGT4aDp1PVrW2kNyakWU2hDpj3gqSfxpqzxhK0vKZp/MXajM5hdYg?=
 =?us-ascii?Q?CIy3nrUXtoN75cP9VosoNb66gnzzpKmKIjuBFKyZWocATmzgcg+9sw3tCaWK?=
 =?us-ascii?Q?6kFqcA7kS2iYJGuSxr03uCn8oRE6XmZYulqesmV9CQurgSHRDcXF5nEfkl6W?=
 =?us-ascii?Q?43FV4wMoQAR2KGTUv3imvgOYbu5i5HZrOxZrjvluVmQeu4LHHg8CL8FmNLdG?=
 =?us-ascii?Q?P5bc6jxyPXePsl1kOPlWfgCEQOBPQfKdclivAQ8WR8si/fh6Xs7iTsKlXZZn?=
 =?us-ascii?Q?xNrPp+zSAMs3sYgcUc63DeAfd0Dl8S440zhAbaMJ/od2S1YSheUyGm6LhqFI?=
 =?us-ascii?Q?335zWnODn4epb4V1548aa66cINA3Wbmiz5iRCoOqFmn219RTvDuMEYtK18EK?=
 =?us-ascii?Q?cjxLOTJF8lEUt3Oas44dxNJA2+FcVLf0rqoRYlUUp59yzdNbrhrjVWQN8vE9?=
 =?us-ascii?Q?gVtypPxItaeBr2rus8M5YdHWuIVSj2CcJVTtelYfAVnr3p31TH8FK0TZGydP?=
 =?us-ascii?Q?4TbWI7h/QCGxMZXidyrhN406gmoxICPIEmzK4kKbu8H1OLZAMPKk+cFBBWxI?=
 =?us-ascii?Q?WJzFf0REYhkcXSSSueBUNw+azkeG1dH6b3YLuoECDPkPBcngrU+SMOCVNHHz?=
 =?us-ascii?Q?+l1VF8mffgFrEaNMhfoTQ7RH+VuJM9bAApO9IaY57RpA1MLZBCCs1Jg8X+V0?=
 =?us-ascii?Q?tE/V7Zo3KHvT2m+8aPBs5H5aNjcbd/QbNaMo9EOGKM3A+ymEpHs/Ou4aGEXB?=
 =?us-ascii?Q?SMQTQOYK94l4Z7F3TEWCdeWQ1N/Qh7XLE3mLcEnYNmjaOixnhnvc7nuBQlgP?=
 =?us-ascii?Q?cfB560wFyS4sIxoxUednJajHe4szjxIbsmz2Yl5PdPjSZ0HL7UdfUFRVp1Lo?=
 =?us-ascii?Q?u5Wc5jZ9ZGR7SdaFeNsaXv0be4I36D54+8qi32OK09s0hbjFpiE193JhgART?=
 =?us-ascii?Q?SksDm7Wqey7j3Rrs3eqspypTugFbcI9syj3QC09PGjDaJ5iIspRC9nGf62R1?=
 =?us-ascii?Q?CQ3IVxjWd8hn9tFILfVIp+dJtoJiU5MF9quYOjzCBn1aLO/jByB3lSRuhWXo?=
 =?us-ascii?Q?08qJp1alSxz1OWWzJzft1bQ2URODaZMUCcXzXfcwIvR6QLvfG5yLwdC1eP7b?=
 =?us-ascii?Q?zHiipNRVDKv7FsY8mdG2oqJi8Scr/+tXPWg1rQlJjGXjaZcA/cnfvYnzXSl1?=
 =?us-ascii?Q?8d9vzKkxhCEzq5nD8m83yOa4yXPw+RyMUQ9/TZzVMY0GiQaa6g+5r42IfOes?=
 =?us-ascii?Q?mJOaz0DwqHOMTr2+C0gX06H91VFQc+77WboauGpLpaVDjBYWG47OCkwo2LyQ?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9fc94d-47bd-43b7-ea27-08ddbf6e225b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 04:56:30.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqcwwR0ec+DgXca7fh3yD+jeqjXiF64n8dfauGWPyNzbhIDOWix1fqeXWN2WQKqmz25rbtplIC1XSlnqzs9mCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:inconsistent_lock_state" on:

commit: d06e66c6025e44136e6715d24c23fb821a415577 ("[PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer")
url: https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Add-prev_sum_exec_runtime-support-for-RT-DL-and-SCX-classes/20250707-224959
patch link: https://lore.kernel.org/all/20250707144824.117014-3-gmonaco@redhat.com/
patch subject: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer

in testcase: boot

config: x86_64-randconfig-003-20250708
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------+------------+------------+
|                                                 | 50c1dc07ee | d06e66c602 |
+-------------------------------------------------+------------+------------+
| WARNING:inconsistent_lock_state                 | 0          | 12         |
| inconsistent{SOFTIRQ-ON-W}->{IN-SOFTIRQ-W}usage | 0          | 12         |
+-------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507100606.90787fe6-lkp@intel.com


[   26.556715][    C0] WARNING: inconsistent lock state
[   26.557127][    C0] 6.16.0-rc5-00002-gd06e66c6025e #1 Tainted: G                T
[   26.557730][    C0] --------------------------------
[   26.558133][    C0] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[   26.558662][    C0] stdbuf/386 [HC0[0]:SC1[1]:HE1:SE0] takes:
[ 26.559118][ C0] ffffffff870d4438 (pgd_lock){+.?.}-{3:3}, at: pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379) 
[   26.559786][    C0] {SOFTIRQ-ON-W} state was registered at:
[ 26.560232][ C0] mark_usage (kernel/locking/lockdep.c:4669) 
[ 26.560561][ C0] __lock_acquire (kernel/locking/lockdep.c:5194) 
[ 26.560929][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873) 
[ 26.561267][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 26.561617][ C0] pgd_alloc (arch/x86/mm/pgtable.c:86 arch/x86/mm/pgtable.c:353) 
[ 26.561950][ C0] mm_init+0x64f/0xbfb 
[ 26.562342][ C0] mm_alloc (kernel/fork.c:1109) 
[ 26.562655][ C0] dma_resv_lockdep (drivers/dma-buf/dma-resv.c:784) 
[ 26.563020][ C0] do_one_initcall (init/main.c:1274) 
[ 26.563389][ C0] do_initcalls (init/main.c:1335 init/main.c:1352) 
[ 26.563744][ C0] kernel_init_freeable (init/main.c:1588) 
[ 26.564144][ C0] kernel_init (init/main.c:1476) 
[ 26.564402][ C0] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 26.564633][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   26.564871][    C0] irq event stamp: 4774
[ 26.565070][ C0] hardirqs last enabled at (4774): _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 26.565526][ C0] hardirqs last disabled at (4773): _raw_spin_lock_irq (arch/x86/include/asm/preempt.h:80 include/linux/spinlock_api_smp.h:118 kernel/locking/spinlock.c:170) 
[ 26.565971][ C0] softirqs last enabled at (4256): local_bh_enable (include/linux/bottom_half.h:33) 
[ 26.566408][ C0] softirqs last disabled at (4771): __do_softirq (kernel/softirq.c:614) 
[   26.566823][    C0]
[   26.566823][    C0] other info that might help us debug this:
[   26.567198][    C0]  Possible unsafe locking scenario:
[   26.567198][    C0]
[   26.567548][    C0]        CPU0
[   26.567709][    C0]        ----
[   26.567869][    C0]   lock(pgd_lock);
[   26.568060][    C0]   <Interrupt>
[   26.568255][    C0]     lock(pgd_lock);
[   26.568452][    C0]
[   26.568452][    C0]  *** DEADLOCK ***
[   26.568452][    C0]
[   26.568830][    C0] 3 locks held by stdbuf/386:
[ 26.569056][ C0] #0: ffff888170d5c1a8 (&sb->s_type->i_mutex_key){++++}-{4:4}, at: lookup_slow (fs/namei.c:1834) 
[ 26.569535][ C0] #1: ffff888170cf5850 (&lockref->lock){+.+.}-{3:3}, at: d_alloc (include/linux/dcache.h:319 fs/dcache.c:1777) 
[ 26.569961][ C0] #2: ffffc90000007d40 ((&mm->cid_timer)){+.-.}-{0:0}, at: call_timer_fn (kernel/time/timer.c:1744) 
[   26.570421][    C0]
[   26.570421][    C0] stack backtrace:
[   26.570704][    C0] CPU: 0 UID: 0 PID: 386 Comm: stdbuf Tainted: G                T   6.16.0-rc5-00002-gd06e66c6025e #1 PREEMPT(voluntary)  39c5cbdaf5b4eb171776daa7d42daa95c0766676
[   26.570716][    C0] Tainted: [T]=RANDSTRUCT
[   26.570719][    C0] Call Trace:
[   26.570723][    C0]  <IRQ>
[ 26.570727][ C0] dump_stack_lvl (lib/dump_stack.c:122 (discriminator 4)) 
[ 26.570735][ C0] dump_stack (lib/dump_stack.c:130) 
[ 26.570740][ C0] print_usage_bug (kernel/locking/lockdep.c:4047) 
[ 26.570748][ C0] valid_state (kernel/locking/lockdep.c:4060) 
[ 26.570755][ C0] mark_lock_irq (kernel/locking/lockdep.c:4270) 
[ 26.570762][ C0] ? save_trace (kernel/locking/lockdep.c:592) 
[ 26.570773][ C0] ? mark_lock (kernel/locking/lockdep.c:4728 (discriminator 3)) 
[ 26.570780][ C0] mark_lock (kernel/locking/lockdep.c:4756) 
[ 26.570787][ C0] mark_usage (kernel/locking/lockdep.c:4645) 
[ 26.570796][ C0] __lock_acquire (kernel/locking/lockdep.c:5194) 
[ 26.570804][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873) 
[ 26.570811][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379) 
[ 26.570822][ C0] ? validate_chain (kernel/locking/lockdep.c:3826 kernel/locking/lockdep.c:3879) 
[ 26.570828][ C0] ? wake_up_new_task (kernel/sched/core.c:10597) 
[ 26.570839][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 26.570845][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379) 
[ 26.570854][ C0] pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379) 
[ 26.570863][ C0] ? wake_up_new_task (kernel/sched/core.c:10597) 
[ 26.570873][ C0] __mmdrop (kernel/fork.c:681) 
[ 26.570882][ C0] ? wake_up_new_task (kernel/sched/core.c:10597) 
[ 26.570891][ C0] mmdrop (include/linux/sched/mm.h:55) 
[ 26.570901][ C0] task_mm_cid_scan (kernel/sched/core.c:10619 (discriminator 3)) 
[ 26.570910][ C0] ? lock_is_held (include/linux/lockdep.h:249) 
[ 26.570918][ C0] ? wake_up_new_task (kernel/sched/core.c:10597) 
[ 26.570928][ C0] call_timer_fn (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/timer.h:127 kernel/time/timer.c:1748) 
[ 26.570935][ C0] ? trace_timer_base_idle (kernel/time/timer.c:1724) 
[ 26.570943][ C0] ? wake_up_new_task (kernel/sched/core.c:10597) 
[ 26.570953][ C0] ? wake_up_new_task (kernel/sched/core.c:10597) 
[ 26.570962][ C0] __run_timers (kernel/time/timer.c:1799 kernel/time/timer.c:2372) 
[ 26.570970][ C0] ? add_timer_global (kernel/time/timer.c:2343) 
[ 26.570977][ C0] ? __kasan_check_write (mm/kasan/shadow.c:38) 
[ 26.570988][ C0] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116) 
[ 26.570996][ C0] ? __raw_spin_lock_init (kernel/locking/spinlock_debug.c:114) 
[ 26.571006][ C0] __run_timer_base (kernel/time/timer.c:2385) 
[ 26.571014][ C0] run_timer_base (kernel/time/timer.c:2394) 
[ 26.571021][ C0] run_timer_softirq (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 kernel/time/timer.c:342 kernel/time/timer.c:2406) 
[ 26.571028][ C0] handle_softirqs (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/irq.h:142 kernel/softirq.c:580) 
[ 26.571039][ C0] __do_softirq (kernel/softirq.c:614) 
[ 26.571046][ C0] __irq_exit_rcu (kernel/softirq.c:453 kernel/softirq.c:680) 
[ 26.571055][ C0] irq_exit_rcu (kernel/softirq.c:698) 
[ 26.571064][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050) 
[   26.571076][    C0]  </IRQ>
[   26.571078][    C0]  <TASK>
[ 26.571081][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:574) 
[ 26.571088][ C0] RIP: 0010:d_alloc (fs/dcache.c:1778) 
[ 26.571100][ C0] Code: 8d 7c 24 50 b8 ff ff 37 00 ff 83 f8 00 00 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 74 05 e8 5f f3 f6 ff 49 89 5c 24 50 <49> 8d bc 24 10 01 00 00 48 8d b3 20 01 00 00 e8 87 bc ff ff 4c 89
All code
========
   0:	8d 7c 24 50          	lea    0x50(%rsp),%edi
   4:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
   9:	ff 83 f8 00 00 00    	incl   0xf8(%rbx)
   f:	48 89 fa             	mov    %rdi,%rdx
  12:	48 c1 e0 2a          	shl    $0x2a,%rax
  16:	48 c1 ea 03          	shr    $0x3,%rdx
  1a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  1e:	74 05                	je     0x25
  20:	e8 5f f3 f6 ff       	call   0xfffffffffff6f384
  25:	49 89 5c 24 50       	mov    %rbx,0x50(%r12)
  2a:*	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi		<-- trapping instruction
  31:	00 
  32:	48 8d b3 20 01 00 00 	lea    0x120(%rbx),%rsi
  39:	e8 87 bc ff ff       	call   0xffffffffffffbcc5
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi
   7:	00 
   8:	48 8d b3 20 01 00 00 	lea    0x120(%rbx),%rsi
   f:	e8 87 bc ff ff       	call   0xffffffffffffbc9b
  14:	4c                   	rex.WR
  15:	89                   	.byte 0x89


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250710/202507100606.90787fe6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


