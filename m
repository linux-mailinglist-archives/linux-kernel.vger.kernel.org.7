Return-Path: <linux-kernel+bounces-612313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29EAA94D72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49263A4E24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452EF5FB95;
	Mon, 21 Apr 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DK/Bb5OU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0312B63
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745221521; cv=fail; b=SmqqpoSXsBCohFxFJSa6c1Q5yo+5ORg/dk/eLqkv2koM16HgRQAX+0ysyXqTjZ2UP7jzuypB7H1wmPDqDbtU4/3wH7wNz3hYw8nv/99of8iyljx0oyNVr04qW5XI+rICh9QB0emjThGcOdHe35JcZAjsaQFNbiCPhhrQfJEkIro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745221521; c=relaxed/simple;
	bh=xqMCSJnp6EMBH+Nniptj50OdT2TaOvv7QrJ9cTZZbaE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PI5Tm5f6AWaHFF5mCc039HN6q+fb1F+VHF9jU54xs5+NPKTVWcV7UWVHNZG9fqpgFHFF2wGj2/ISSwRrwOengswEQm3nnclwotFYeQT6F66iXfVVkwPcBH9MXVw6bmeo8obUmECxGUTPononOZOw3yB16fWwepj14RZmWKhXJ0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DK/Bb5OU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745221519; x=1776757519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xqMCSJnp6EMBH+Nniptj50OdT2TaOvv7QrJ9cTZZbaE=;
  b=DK/Bb5OULz3LzKQ1r6lT4Bsv6jXRj6k8ajiUf4GWhO9nZS1UCnCmeJ0t
   9alqYoEo13YF8CtRFz0ZX6/ynvh1Tdib4wa1dsjFr+CxfBIHuAJkunFcw
   Qh3HKBudCF6uWLLmo72lud1Djz4NrY8TlbyRg21bGrNv3aI+UaPn7q8rv
   6TtvVzbMf78YcEqz5LZE4VJjdetsKfLRQ1PIZQRkDORaNhjevQl6IKX4f
   8SSB1CRFIrD/bzUN6Xfe9dV+SwYAF3I3UzHqHK96TZ7HKrMR/J4NEoLFJ
   6atbf9WUWwCVMFJ17xf6rZxYtir1e6+6bjI5Fhnl9lCs42SWzCVj6Naiy
   w==;
X-CSE-ConnectionGUID: dfRWdotrSbyzVHchLaI7lw==
X-CSE-MsgGUID: kIc2Cp8ISPe5aybMjbSxWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46921256"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="46921256"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 00:45:16 -0700
X-CSE-ConnectionGUID: IJac5EfITf6UBt7CpftTtA==
X-CSE-MsgGUID: O1xIkiwWT0ubQgkgV7KWLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="168856761"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 00:45:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 00:45:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 00:45:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 00:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB4XQU2+aHnWCUtlzLY7AkREfHcEOcsLkVbMCbLHHyvxUCbDmq0eaHywk6Jb6tg1RJbnStvrPIWc2bhJMlVz2kE3ufVu/E0BZhXNeoWcmdVOdeAGDPhnUeNju4bokjfGXVdIjXeYxb8VQy2ovCrNsBAO7LGJZTVvGs5BxG0sv8ZvW1eUp9DpztVwUG51B7fDPOhxmBsyD0yvAxDRYknoYj32ERvLWUP6/LsqxKg+7KgsXwV/1utGE4wNHq5LxkeQktJF1s1Q5WHXYPeM3AMXsW5t10ybO6EvlvFcgilZgncU/IzBMsWXi3rjgDPdaTR8RsWCrJ67I1R5alq/tUorSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEJ7MV7Ly6koydFfQmtAxxFtww31k6884n7A55T8V0c=;
 b=iEZOL0ONp0Uc/Q9kpjgkMtGJk5UfjMUjIWqCR3R4kNAIT3ofKd9Icmdki9e+kjxvvcBFvvE4U80bcFwlB+R6PH9Gt4ABu8Iy/MyTjHz+xsg42hMjtQ8rTJdkWnu4NxK+p5ahSnnapxGULC/RvmnT0yoBN0SjJsHMKi3k8c6fHnMO5Vkc3XVFw9/FNzpthe/QTkQsUaYZPRvHICmKCKsYn0bf9vyr6jBjrRFXRAWa0mZLRGZfqjkwRbMQN9ciRkH1Okk/Uir6nI7yMwZo7zwOKp1LhaY5z7ZpZpmSph0eZ0zE6DPI4vly1TVAj51N+8W10x8XIzi3LVmbv6fwwpxTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SA1PR11MB8425.namprd11.prod.outlook.com (2603:10b6:806:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 07:45:11 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 07:45:11 +0000
Date: Mon, 21 Apr 2025 15:45:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christopher S M Hall <christopher.s.hall@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Corinna Vinschen
	<vinschen@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Mor Bar-Gabay
	<morx.bar.gabay@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <oliver.sang@intel.com>
Subject: [linus:master] [igc]  1a931c4f5e:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
Message-ID: <202504211511.f7738f5d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SA1PR11MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fa0ce3-a8a3-4c5c-466a-08dd80a871e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?alK0IFzM6U46L5yATFRiUUYwuZ2xIyTxMkmFeQeavvuUfvcMYrDh9PKMCwJP?=
 =?us-ascii?Q?YYZfOYEstjo8roAUHPfGtN4FVM65Z3YzJgKsBAdCcVYXEvvJJYSrozzOxJ7i?=
 =?us-ascii?Q?4Ss7SGnLxg5azU4ljSQ7iKzMVgbJwETe6vCfXfSctRUrS4VtJ9wgoS7s9nR3?=
 =?us-ascii?Q?CzW5uFZYI/YHgnupXtrh94faV5mTGEiWDMRBRBgHe+psIRSN3gh5E/6iyePE?=
 =?us-ascii?Q?se4kwt65kUzr0UzUKzeGpYZWxKrmhwaYlYXbd/XZyREVt8Z5IsoSw6swbtor?=
 =?us-ascii?Q?aeBuVK7b2x7Hi/cYluj/M3v3Zdzcyew7FxRSwkyQnTBBUvIYnr6r+IkrV8lF?=
 =?us-ascii?Q?v8lVo34qsE8IBk875JqcCvqo0ch5qoUCV6NDFzv/ccOzwPI1fU60x7i6oj/6?=
 =?us-ascii?Q?gYz/0g5Rnz6cCi4I9XK+RYOZnPv3//AFcu1VIgjwhjsxu63eVGzR0AUhJjCL?=
 =?us-ascii?Q?yS4xyLGpLCzPt+P8w0/y4JcQdD01AaT7ht9gG1bDz387WQpGJqOfZ3x7t+it?=
 =?us-ascii?Q?1MIlcw9Fe2vg9rAnKHyWq4TD4FBHJJSk4YvknoKwnobQvH/1kMk39Q3k6BPa?=
 =?us-ascii?Q?0oytWYzgQLAZGm3Ld2nQUgVIkVIZ7/KqqUDWu2HuoE2CzOrQaQu/0dJGged1?=
 =?us-ascii?Q?0bnAuSsOKPdH5AN3O6KbF/tyoaNORIPwAsPWYbBOC3fdLRnGPWfUK30XmZ70?=
 =?us-ascii?Q?X3bZoSSQqmK9JeABQmOn4wUw5vK0A86jBKaVAhnwgvbZ/5MN2EAj19g13d5N?=
 =?us-ascii?Q?NX4uPRR2+pymQQYtRa0e3b+wGzxs7w5JpDrdfmfS6J1VufiePIm5CzIf6DNG?=
 =?us-ascii?Q?hnFouiTbcblGgpis8yLTFabfuILnLgB9IaKaUEHTxSWkXjQcIidM2zx9AtW7?=
 =?us-ascii?Q?OwzmxnREyDkMzgutZYYWW2ar5sbWn62ve3W8G8jE7qGyfvqLzMBJIWKginl4?=
 =?us-ascii?Q?9+IFpV+vylB3P7VGqLyXrGSxDFlRr+NdcHcYIrolknLEEy0GLoN6+O+743Li?=
 =?us-ascii?Q?aGa/hCZUzFiJm504tUnGa8wILfp2+wSkyZHC4ty3k+lN/Lm9q7YdN0bcFAcr?=
 =?us-ascii?Q?uhyMPSizyy3U0QF3v05C4sk5mxfWOGD2+CGs4Fh/Q/8Lz7CS2EXw4cvVGq6h?=
 =?us-ascii?Q?TyPJesXlL/uU5TavH9wy5/LHn/Fbw8XGZfe2vLSAlSpkVEtAsVvyfqRL5CEW?=
 =?us-ascii?Q?SkzUSJP34CJXUUtJlXKPGZUdh5kX09bFcL7TPsr/2Im9LMCitzzQzAhSbtXi?=
 =?us-ascii?Q?bOGvLPimkNChRhlBlEdrH1iy4Ra3N2fBfqKS65+1Iwmt0XXYt5FUEj6/MXzf?=
 =?us-ascii?Q?KxzDqkVRV/EtGfcswPUQRck419/HddnyI4zU1qQB8TmiSGRV+m2oy6hBu3+T?=
 =?us-ascii?Q?BaCw+6Fi1acbqYMyAVhCISTFpNFQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+TEYo38Cz0+OwjBbe2AHnoNugoTSumFdGjugZWcyf82XraURgrQ2zFbBm6g?=
 =?us-ascii?Q?Gr3Ls6pKxuop65oLxjV71LV5lW9xJekBXcdUW2TcViWlltv2XxjUqf0w+1DU?=
 =?us-ascii?Q?IHNuoo6XPtw/9QDSotTyFXq0mW2VKNwu7CoT5LCBkvxk4wYJGPwl4j9ndHsr?=
 =?us-ascii?Q?ZLkQk9l4ZKpjfuWDpW9hEiFdy77nFA4eWmhy0lVlSf1VvZvklyf9nWwE4OXh?=
 =?us-ascii?Q?YvYcO2YnERLzYBib8pYyiQ1ThQT/89NdqYLtA6cl+DxuUvZ4sBhw+XrscVP4?=
 =?us-ascii?Q?R2fA+0g/g3qxk5Zx53AU2Xd9uy4vJRy/WzC21DlxV8PwviZ8IkIkebSDxoLz?=
 =?us-ascii?Q?AgAst5p8+Z6BR4XdHg3u8u9Fu4rNvJQ3BQ4H0l0WyoWAbKI0N7fGiXzlH9ny?=
 =?us-ascii?Q?o2E+ko+iiTHcznb0eVbKeWDDavIluXqRiZnZODbEGOsziCth5Xx+xjMYpUDp?=
 =?us-ascii?Q?kos0Pc5IMvBkkB9TDAC1sQRmmSYspaPwvQpdynPmMoqbf7IdqC+tsM+mt4CR?=
 =?us-ascii?Q?r7gDgowcEUAR/9JJQLMCVvV7/OziNwpVCLgPu1McfX6d4PPfaamfagnT1cVR?=
 =?us-ascii?Q?Z092IQtLHqn1rg/aCPZh98hJuZH/Tw/Pa7iMk7pPMcbaNGqFYhcMZ+M+1lT9?=
 =?us-ascii?Q?VuOaIVhIfFzDzkyDxKUS4dbgSjlU8hWN/Ms2qHj5IXfxp3YU0w6zz9cJCyeA?=
 =?us-ascii?Q?4Axor5VYj4ZPXEJk0E3J0gFTRG2ShOBfpxHUdFMfHOqBfX3WRvxXLGgi39cx?=
 =?us-ascii?Q?Q/RjX+9yyRswo+6l/RbxAH2Qkw2hkc3z3xXRdcEdEmVdvknkyFi7D2YMFpd8?=
 =?us-ascii?Q?zvJBG4+a1hbrijyoN8o4IPg7K8JwIILZ8froVtBNOLdra+N9su5bLCZ/s2+L?=
 =?us-ascii?Q?gCp0DkJGpAuGtMablZEw6B430c33/1HmQRbbGf4eObvWx3N+7rwiDEed4kpa?=
 =?us-ascii?Q?dChNEiybeZH5scYysB6sCTWEoIHDUgdFK3+cLDQ2EYF64uJgCOzr1C/0vK1t?=
 =?us-ascii?Q?Aztbeh+6dCIrkUVVNUsX4/0hOyVSU0uLB6+jo40hy4BFr2JPNOXFC4X+7iaj?=
 =?us-ascii?Q?pN/EMjNmRSNszHqagC8WFLJxjKrwqvbcjIu+sbjdl8xIYI+ZWO5sXDM0q096?=
 =?us-ascii?Q?8fgkcve/2baDZdFw7NVKTyx0A6KLSbo/6SgvhMDNJvhKlcfg8P6BuYBbh0Az?=
 =?us-ascii?Q?ri1Y3PAFSf8D9j/kXUEKvLruFINmZnVaZT/iln7yRglMsyWMAFl3XWWl/nOa?=
 =?us-ascii?Q?NeRXSu0pJ/gz2nd97VeKdgXwubEYgtOtTRBkjikSdcN4WvZX+RlT2JwqVEEw?=
 =?us-ascii?Q?1AVwAkxLnAEeVXkwFkpUOVyaVYLQx4xLDhtFhB42FPCN5S2/Trwug7OOD12l?=
 =?us-ascii?Q?SQlZVvZH5lzt0DA1NmqGuEyyHG6MMHoeRnFON9rZl49dAUOgCjgrHcxrz19G?=
 =?us-ascii?Q?WfQyTmFN/IwAVKSfB+3lErJIMWZqzTcK7X868XjuNrNANnqpbjG3A+Rm3By1?=
 =?us-ascii?Q?piFCamV4EisO4ZrDPbyFivbUAvTqm4YWKc03HVo3b1KAj0wKqKeBQMm7qgci?=
 =?us-ascii?Q?F7aJS5CiqYS7TMtHOJq06ST9PVq/LksbewsAA+z5jE0xIRSVA9lq4Dfm656J?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fa0ce3-a8a3-4c5c-466a-08dd80a871e2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 07:45:11.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cJ+GySgVLlnFOHPEP1LJQdVU8Qm15QDBr+yzOrrvuFYbOvo+GStN8T35mgoLmf/jDCKTiwUX2VzYP5QdLHyRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8425
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c" on:

commit: 1a931c4f5e6862e61a4b130cb76b422e1415f644 ("igc: add lock preventing multiple simultaneous PTM transactions")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2]
[test failed on linux-next/master bc8aa6cdadcc00862f2b5720e5de2e17f696a081]

in testcase: mce-log
version: mce-log-x86_64-ad244c6-1_20250220
with following parameters:



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504211511.f7738f5d-lkp@intel.com


kern  :err   : [    9.448408] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:274
kern  :err   : [    9.455977] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
kern  :err   : [    9.465972] preempt_count: 1, expected: 0
kern  :err   : [    9.469972] RCU nest depth: 0, expected: 0
kern  :warn  : [    9.474983] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc1-00147-g1a931c4f5e68 #1 PREEMPT(voluntary)
kern  :warn  : [    9.474983] Hardware name: Intel Corporation CometLake Client Platform/CometLake S UDIMM (ERB/CRB), BIOS CMLSFWR1.R00.2212.D00.2104290922 04/29/2021
kern  :warn  : [    9.474983] Call Trace:
kern  :warn  : [    9.474983]  <TASK>
kern :warn : [    9.474983] dump_stack_lvl (kbuild/obj/consumer/x86_64-rhel-9.4-func/lib/dump_stack.c:123 (discriminator 1)) 
kern :warn : [    9.474983] __might_resched (kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/sched/core.c:8819) 
kern :warn : [    9.474983] ? igc_rd32 (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_main.c:6896) 
kern :warn : [    9.474983] mutex_lock (kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/kernel.h:73 kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/locking/mutex.c:274) 
kern :warn : [    9.474983] ? __pfx_mutex_lock (kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/locking/mutex.c:273) 
kern :warn : [    9.474983] ? igc_ptp_set_timestamp_mode (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_ptp.c:520 kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_ptp.c:655) 
kern :warn : [    9.474983] igc_ptp_reset (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_ptp.c:1312) 
kern :warn : [    9.474983] igc_reset (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_main.c:123 (discriminator 5)) 
kern :warn : [    9.474983] igc_probe (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_main.c:6887 (discriminator 5) kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_main.c:177 (discriminator 5) kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_main.c:7199 (discriminator 5)) 
kern :warn : [    9.474983] ? __pfx_igc_probe (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_main.c:7003) 
kern :warn : [    9.474983] local_pci_probe (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/pci/pci-driver.c:324) 
kern :warn : [    9.474983] pci_call_probe (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/pci/pci-driver.c:392) 
kern :warn : [    9.474983] ? _raw_spin_lock (kbuild/obj/consumer/x86_64-rhel-9.4-func/arch/x86/include/asm/atomic.h:107 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/atomic/atomic-arch-fallback.h:2170 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/atomic/atomic-instrumented.h:1302 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/asm-generic/qspinlock.h:111 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/spinlock.h:187 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/spinlock_api_smp.h:134 kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/locking/spinlock.c:154) 
kern :warn : [    9.474983] ? __pfx_pci_call_probe (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/pci/pci-driver.c:352) 
kern :warn : [    9.474983] ? kernfs_add_one (kbuild/obj/consumer/x86_64-rhel-9.4-func/fs/kernfs/dir.c:834) 
kern :warn : [    9.474983] ? pci_assign_irq (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/pci/irq.c:149) 
kern :warn : [    9.474983] ? pci_match_device (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/pci/pci-driver.c:159 (discriminator 1)) 
kern :warn : [    9.474983] ? kernfs_put (kbuild/obj/consumer/x86_64-rhel-9.4-func/arch/x86/include/asm/atomic.h:67 (discriminator 1) kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/atomic/atomic-arch-fallback.h:2278 (discriminator 1) kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/atomic/atomic-instrumented.h:1384 (discriminator 1) kbuild/obj/consumer/x86_64-rhel-9.4-func/fs/kernfs/dir.c:569 (discriminator 1)) 
kern :warn : [    9.474983] pci_device_probe (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/pci/pci-driver.c:452) 
kern :warn : [    9.474983] really_probe (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/dd.c:579 kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/dd.c:658) 
kern :warn : [    9.474983] __driver_probe_device (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/dd.c:800) 
kern :warn : [    9.474983] driver_probe_device (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/dd.c:830) 
kern :warn : [    9.474983] __driver_attach (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/dd.c:1217) 
kern :warn : [    9.474983] ? __pfx___driver_attach (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/dd.c:1157) 
kern :warn : [    9.474983] bus_for_each_dev (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/bus.c:370) 
kern :warn : [    9.474983] ? __pfx_bus_for_each_dev (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/bus.c:358) 
kern :warn : [    9.474983] ? __kmalloc_cache_noprof (kbuild/obj/consumer/x86_64-rhel-9.4-func/arch/x86/include/asm/jump_label.h:46 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/memcontrol.h:1696 kbuild/obj/consumer/x86_64-rhel-9.4-func/mm/slub.c:2182 kbuild/obj/consumer/x86_64-rhel-9.4-func/mm/slub.c:4161 kbuild/obj/consumer/x86_64-rhel-9.4-func/mm/slub.c:4200 kbuild/obj/consumer/x86_64-rhel-9.4-func/mm/slub.c:4357) 
kern :warn : [    9.474983] ? klist_add_tail (kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/list.h:150 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/list.h:183 kbuild/obj/consumer/x86_64-rhel-9.4-func/lib/klist.c:104 kbuild/obj/consumer/x86_64-rhel-9.4-func/lib/klist.c:137) 
kern :warn : [    9.474983] bus_add_driver (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/bus.c:678) 
kern :warn : [    9.474983] driver_register (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/base/driver.c:249) 
kern :warn : [    9.474983] ? __pfx_igc_init_module (kbuild/obj/consumer/x86_64-rhel-9.4-func/drivers/net/ethernet/intel/igc/igc_main.c:7706) 
kern :warn : [    9.474983] do_one_initcall (kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1257) 
kern :warn : [    9.474983] ? __pfx_do_one_initcall (kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1248) 
kern :warn : [    9.474983] ? __pfx_parse_args (kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/params.c:168) 
kern :warn : [    9.474983] ? __kmalloc_noprof (kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/kasan.h:260 kbuild/obj/consumer/x86_64-rhel-9.4-func/mm/slub.c:4331 kbuild/obj/consumer/x86_64-rhel-9.4-func/mm/slub.c:4343) 
kern :warn : [    9.474983] ? do_initcalls (kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/slab.h:909 kbuild/obj/consumer/x86_64-rhel-9.4-func/include/linux/slab.h:1039 kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1328) 
kern :warn : [    9.474983] do_initcalls (kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1318 kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1335) 
kern :warn : [    9.474983] kernel_init_freeable (kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1571) 
kern :warn : [    9.474983] ? __pfx_kernel_init (kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1449) 
kern :warn : [    9.474983] kernel_init (kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1459) 
kern :warn : [    9.474983] ? calculate_sigpending (kbuild/obj/consumer/x86_64-rhel-9.4-func/kernel/signal.c:194) 
kern :warn : [    9.474983] ret_from_fork (kbuild/obj/consumer/x86_64-rhel-9.4-func/arch/x86/kernel/process.c:153) 
kern :warn : [    9.474983] ? __pfx_kernel_init (kbuild/obj/consumer/x86_64-rhel-9.4-func/init/main.c:1449) 
kern :warn : [    9.474983] ret_from_fork_asm (kbuild/obj/consumer/x86_64-rhel-9.4-func/arch/x86/entry/entry_64.S:258) 
kern  :warn  : [    9.474983]  </TASK>
kern  :info  : [    9.717837] igc 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
kern  :info  : [    9.726709] igc 0000:01:00.0 eth3: MAC: 00:a0:c9:00:00:00


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250421/202504211511.f7738f5d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


