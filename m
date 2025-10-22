Return-Path: <linux-kernel+bounces-864310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1597ABFA7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BC23ADC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D732F49FF;
	Wed, 22 Oct 2025 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQ1C2kH2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0122652BD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117310; cv=fail; b=sxhn5cVUGIPE2tNpiC3JW7rXbz54jNtIl3qVDw33Tdc6bZ3l4ZoYLAKUDH1Y1D/dFu8eFEi/F+f3+jh+bnvx7ZxpfkZNbm0Z2//Bw4yWqbv0mlT1adnAmaiuNTwRgY0xt1nAaTeWo4erfDI6M+DYtiSPpmYmpxqcMWUoBfSjtLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117310; c=relaxed/simple;
	bh=F8raslYQ9jKboTlbBYhdKLVY6tFfqEko8JOWuSHORAo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sbcXVtS2HchEFIePLAk3my8h1Q28xcA5/L/siqLksQraTIpFzycFFW9TFKyRYI8leAY89OIJClGeahZUdRz06LrNrzQ9K5hX+3DXL3IFMxap8ifAgM82rjHhJbjvzRNCHW+7wmbWaDdwoYtd1Qt5l0LH+aqGO6d78imiCXI0Q/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQ1C2kH2; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761117308; x=1792653308;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=F8raslYQ9jKboTlbBYhdKLVY6tFfqEko8JOWuSHORAo=;
  b=TQ1C2kH2ObSvlZjRg9aRx934RV2ZNNPSRNiF+b7JfyQRxqnO8AuDXN7Z
   SETorqC+oVDQm2+Z5dJJ1VdVJe0tEtzsFpwgxn0QkoqoLwdjE7b21uT0r
   0slN8aiX48zyoHq2lA9+uag9+crseE3ScU5sLEXMlGRxTm9Yav6t48s6M
   ZCEhGhoNWk964HtFAAliaGpwFirNdd9zqYOOlU2RQRYtrFQfCLXYCnjRW
   wNapW32r0YbepE53NAoHAR3+vUthC0CTBFj1+twRmam4IfdUatJLa1nRC
   jLH7JOaYWf8+k2cvVozBrDRQEKvPTRLitnP66fVoFpK7DEQfSw5cUkaT5
   Q==;
X-CSE-ConnectionGUID: /o7oXmpoR9GMOrMgPue9Uw==
X-CSE-MsgGUID: BRM3OSGZREaaODaGg52gEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73925860"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="73925860"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:15:07 -0700
X-CSE-ConnectionGUID: WhAaC5gIQTe38WFG8lpiCg==
X-CSE-MsgGUID: PH/HvBOfT3aAF1No4xBujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183736896"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:15:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 00:15:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 00:15:06 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 00:15:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF7a7vbQkfd5WWOO/95udvD0BB72OF6d76eWHXFthUoyP9ztAm8d9/LOnHPzEc70KvKLi1gyaWETbTv7J1l22vpj8dU2kMU3ZpqLEI6WeYNnzNoJHJ4/Rbb5r9YB8xXaSA93cbipkW2rfb2Lhbz9EhBYNW0CTuNzWZ9tN5js4MgfyisLfxde2B+fBO/EwmZG1jkXC4iCC8kVYbH3sN9UyBcWblndRJtiGDan6/jOqC2CT9WzGeMf1RLtlfVxAenmWYOM4FcJErYUIMaaYzM/A1BrOaauXp+s5p+kp4IHrMRSUGEAleNBG/veJqjTdkbEPPDQJjDUfiM+B2qWmzt1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjFlJkRorD+bXCJy4goD7+AYdCr5BiG/uEYweCtttjA=;
 b=MeJ4xFEKJY4R8odLF8cngzjpU+an854PNE5osxMnr6OmeQ6GBZl7N0tFYLNknQ/5KkQILSSo4nBAPwqshhPiYmAwp6ePurbdjXCuhQ+UqNNYb0mRWeKw/vCRdY2DPj1TlpHNlkWpd6hT70864n/BPwgsFBB18UXUTHZLMx+WFSzP9aCYJoiTfLKjQcheFTpi7pPPo++XiU756GHZsCQ/kyxjvKBCvauwaBMCJSM+H1mpaMI6omGHpV3NRRf9KDqj7wDkC6Ai7lZ0+MK4A/90Qmk8ghxAcxfRYvZq8oG05ObZZMZGFLrGRu6XdZydxb68g78P94Xb+Ycb1fmQ+NXTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by MW5PR11MB5929.namprd11.prod.outlook.com (2603:10b6:303:194::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:15:03 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:15:03 +0000
Date: Wed, 22 Oct 2025 15:14:50 +0800
From: Chao Gao <chao.gao@intel.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: "Reshetova, Elena" <elena.reshetova@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Message-ID: <aPiEakpcADuQHqQ3@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
 <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
X-ClientProxiedBy: KUZPR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::19) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|MW5PR11MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f15c035-2120-4e23-f300-08de113ab888
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDB5eWV2RTBGT0VYUEN1WjIzclNKaGxEdkg5MTdFMS92eGY1ajdpcmpCRXJZ?=
 =?utf-8?B?Zjhya3hRd3Fjc2Y1Q29UNjdqOCt3c21jRVd6MEthYkhNVWp4dW5hWTNRYWls?=
 =?utf-8?B?YWtvVDRlTTdubUJuRE1qcVdOckQ2K2xUcEJEL0l1Q014M3grWExXcDN3U2tv?=
 =?utf-8?B?RWFRRlVCWGMzUW55UE9FRVlEWTZpbUt6UUpkU0dwUEtNRkZKbDNwbEpqdVAr?=
 =?utf-8?B?cm9DUFVYaTdFTWIzYVFydDRHNHdHdHM2ZERISVNPbWx5WC8vcThNN2lmcTRT?=
 =?utf-8?B?Qm9oREkxaEJMMjRjQUw3SXdjNzZCZS9OcWNqTTJiQlBlQXBiTTlKKysweFBs?=
 =?utf-8?B?OUJSM3RRTjE3aW1aaVBPY1pGNjF2bjNsSVVYOVZkNU5oUThMYnRBYVNGaDND?=
 =?utf-8?B?U3V0TWVWa2lIdTFGNGI2N01lbXdZeSt3TGhtUkdpUjR1WDdISXpHVm5aeGli?=
 =?utf-8?B?SUp1Q3Y4azhTQVMzbGlTQ082SUF6N1BuTjdqdFVSRFR6cmJoeDU1QzA2dkEy?=
 =?utf-8?B?VE1OUkozaU1aZUN1TDczOEI5cGI2VS9nYkxpMC9DdEM1elhVRDB0Zi9CcDVk?=
 =?utf-8?B?clJpbStDR3V1Zk5qTlRGZTZQZjlxOWlsajNpTHNSOUk5amx2RjMxM1I4YjFS?=
 =?utf-8?B?enZFUm1hdUhURVBRZTloZm5KY1VjSzM5ZzBackJHTkRQZVVPTTVlS08wZXov?=
 =?utf-8?B?Z0VKRW5LVkVKZjArWG1rUjdPNDdrSGhhNjBoS2JBTkhZYW44dnV4Rnd2cG1r?=
 =?utf-8?B?V1EwcENPdWhZcTdlT29RYWFBVHhxU3VpQjhwV3B0NFVueW5TMVJPZ2Y0OU5P?=
 =?utf-8?B?d21DdWp4R0ViU2JnUitMOWlkUkRyQkFQbXJEcDhOZk5zS2NRcXh6K2RDWDJ4?=
 =?utf-8?B?Z2FIamVUWmlUVkJld2ZJT2pWdVozUnNOS0wxVWFaSFA2eHc0UEZKMmZOZFBn?=
 =?utf-8?B?ZHFRRldRQWhPUTZ3MnBKUUtwRVhpSm1NQ0dWemNGZXhpckVSZml0ZjhpbnJN?=
 =?utf-8?B?M1NDM3JTdkxMd3JYL0MyNmhGTlRDZGZTWUZDaUZiYWdPa2ROTFdGbEpIUURN?=
 =?utf-8?B?TTg5ODVVZEQ1THhDMThpcU02eDAwUTB2cGJqL25ZL0hVVExXb084dkVyUlV4?=
 =?utf-8?B?Y0U2Q3dndlpLRVM0SmRyb1gxTWdDaC9KcXF1ZUdyc20xMFpEd09Ha3hwQTJX?=
 =?utf-8?B?ZU1hUjVYUlorOHI1SmFqUVBCVkdoZCtnMGw0ZytLZlZ3dDNRTndOaXB5VS8v?=
 =?utf-8?B?bjIrVUhaeW5SdHBORHJhVlZQY3ZIdlQyZHRvZlZ3YThsSHVESXdSSHI1VEFz?=
 =?utf-8?B?VFIzYjJJS3ZQWEJyVlRmT0loSWNkV2d0NVlrVXozL1Y0UUJCVWE2M3ByL01l?=
 =?utf-8?B?S2p4UDVhT1oxSDJ4UlZFUU9TUktzM09TMVF6eUNFckU2ajdibW9JdFBCRzUy?=
 =?utf-8?B?aHpkZzZoOWd0cTlDbXhEMGZlTTQ1OFhEK1UvajAveDVMcktsTlY2T2NsS3F2?=
 =?utf-8?B?SW1wVkJUVThxL1FWSmdtMEdwV0RkUmVBUE5VdEJRTEpRR2RHM2doY2VlQmpB?=
 =?utf-8?B?T1BJbkFmVnNEK2tSaElDOFR6TEN3cnZJUFBtV05sbGR3aXNkNW02eDZhTWRJ?=
 =?utf-8?B?UDV3Q2JBRE8zQ01rUXgvOTlXOTV6SEVPdUcrc0hIVXZtdmE5dkFoZG53SEIx?=
 =?utf-8?B?VTE1TkEvc1VqenNlWkVGeG9qVEtyVkhwVWQ5a0NxdjJ4UTlKdUxscU1QdWtB?=
 =?utf-8?B?UmZzTkhEbHB0NWt4M20xNXkwYWtucEFWL3Vzcm5WSkhtUGU1ZUpzc0doZTNX?=
 =?utf-8?B?UTE0K1FxR0JqeUhaNW1STUNFNzdHZG5ZdkRxQTlPaXF1TnBvbW93NHhTSkRY?=
 =?utf-8?B?MU9vK0tlcFE2cm02VHBXT2ZoR0JsTFN0NUNpQmFjOEtHNVEreFc4ckhQMisz?=
 =?utf-8?B?NTZMZ05jUFhpb0VwbUtueVBDSUt2SWlSREN5bWVBQk4wc2cyZXdFSWJUa0FG?=
 =?utf-8?B?WHBRTlV6TklnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJzb1V6V09SUVV0ZjZtNlE4MlhvTlFjNnIwSTFqWjRCY212T09tQlhiU0ZZ?=
 =?utf-8?B?eGVmTTVWWWUzdEE0bUZoTW1oM1BSTGNIZTg4cEFSWHpoMXNYWFJVZms4aEZ4?=
 =?utf-8?B?clZnUFQrV0VrOVh2QXVvM3B2ZnROeWFFY0J2dVlkRkVGc09GdzJQcXE4S3pK?=
 =?utf-8?B?Y0laMU0vWHpsV1ZTWXgwYm9LZG1UekU0cmtGTDhrUVV2WjV0NU9ITExSZ2tv?=
 =?utf-8?B?czJyMGN4MlY5dkpSclVKbVo5a1c2Rk1UKy95NHBJdFV4QVhNdEp3V09Ia1Z5?=
 =?utf-8?B?QVhDU1M0M0lQLzN3WkpJSU9ndHh2em1hczZyc2Q1WVViTGFXM0F0QnkvWVp6?=
 =?utf-8?B?MnozMDJkTDV3YmVEYXNlWGNTb1RKZWltTHQzQnRrNC94cjdESHU5NHZ4L0w5?=
 =?utf-8?B?MEd1Tk9kR0RNSjYyZlRpRVV6TXpXajVlZkphK2g3WTgxSVd6QzM1aS83dDR1?=
 =?utf-8?B?c2cySlBUQXhKNFduWnRjUkNHSnRQOVRQZFgrajREdGk5Mi96Vzk4YVRvRTJs?=
 =?utf-8?B?OXhZZ1FFTTFlY1BoY1k3MGcweFpOenNudEpCOVRobHdhYXg3UDhxMVpUVWJ1?=
 =?utf-8?B?TnVsaTdpTS95YXN1eEp6Zy80SDQya3NUbVdpeTZPajh3RUdHc2MxaGl2cjls?=
 =?utf-8?B?c1dkNWNzbDk2Qktza0VKQ2wzRHZCYURiNlpUWGlocWw4YU8yVVMrNHRBY1k3?=
 =?utf-8?B?ZmpYN2ZNaDhsQlVrYnhNbzdGRUxxdTFKeXFlbHJFdnk3SVhlWWlINHpWQjZT?=
 =?utf-8?B?am12SHdiS0VuVyt0cmlhNWhPUkNybE9Pa2I5MTZXcDhmb1Z4M0k3TGZFZWFG?=
 =?utf-8?B?ZkJNSE9tK1VLMm9kZExhZ0JKNmtCMUZrVWtoNWdHWkNRV2RGa2FTU1FCczRx?=
 =?utf-8?B?dmVFRmd3VEJ3cEx5MG1TYXNIQVA4eEE0OWMrbURmMnJnY2EyTlZGekdXemYr?=
 =?utf-8?B?RjFWbloxVkJIQXJyNWZXVmQ0WG5tOTc4SXAwNE5zTEZydzQ2a2RRZzVWWlEx?=
 =?utf-8?B?VkNPOHJYQU5GTjhWSUpId1FNTlJiZW5KTnVFVDVydUFOdEd1MUZ4czdYOGZH?=
 =?utf-8?B?aElUbkhtZ0ozRFhVQ2dMYnZPZmtNbGtqVE4xWTZ2dGd4bHFsaGlsa3VRUkFW?=
 =?utf-8?B?aEh4YkVva0kyZjNNVU1GU1F6ZGVwTXc4cFZ6eUJHczhNWUh1dDR0S3BGOWJT?=
 =?utf-8?B?L3lSa3J4aDNHM3JDU3JmckZPNmErZWtEcUNKVm5jQlZVYndSTzZXVWl5OXN0?=
 =?utf-8?B?NlNBNGF5blFlMzZDWkpHOXB4OXZONFlFK2RuUGNTb2w5em9laTdWV1Y1NGtt?=
 =?utf-8?B?c1h1MVMrdEIzSzJ5aEJ6aFhHRTRYYkh4alNqOGJPQXRoQ2hBMTM5enlLam8y?=
 =?utf-8?B?ZWR4WVdDeDlwK054WXVPZTFyUE5lOUNWN0UyT0FyM0pmNGxVb2xiVHR3MVJq?=
 =?utf-8?B?VFpCbnhMemZhTzdzT2NoMG94VVpKU1NEM2lqQnluWXRRL3NNL1l5K20vYXJM?=
 =?utf-8?B?RU9yUGNweHN6Qlcyd1dreUpUMEVQUzNDSExmbjRUVDNZRzZUdE9TRmJVc1VI?=
 =?utf-8?B?ZDVtbXFSSnZoWUtOU20wZ0pRMFI5WGxBRUFtZXhkT0dGMFlKWFM2SE9Ldm0r?=
 =?utf-8?B?M0REZldpVkViTEFKU2NocXpKem9XcGhYbkcvWnJacXJkbnorck5SWGtHb0FW?=
 =?utf-8?B?MXIrcSt2U2JGaGZlOHVOMzdRQjVjaWFYVjNpYXA1c3VmUUVrb29lUjJ0Sjdp?=
 =?utf-8?B?YXVabWNsSDdkZGV5RDNWcG9QVXlSeTFFaW9MTHV5NGJQUzZ0S3hDdlhZaktE?=
 =?utf-8?B?eGJjdkhWUENMN25Pd2h3emFaZ2ZVc1Y0bzNqb1NUd0d3R3ZlTDh2b2lmN3pZ?=
 =?utf-8?B?cGxZTXdmQno3YWgwZkcwdVBTdFJnN2tibFdZMGlIUUh1ODAzQmNXZ3FmRCty?=
 =?utf-8?B?Tm1VOHRjdjFFYnZPdWoxZnNRM2ZJQW05Y2NlR2QrMDUxUGpTZWpDTzVwaCt4?=
 =?utf-8?B?M2UrYkdCOXViWG44Sk50L2t5YjdiTHNJcnVQazlHcytKYWlVcnNlaVVaT2lW?=
 =?utf-8?B?TDF6R2sxMlIwQVBrWlpZRko3QW5seDZGKzMxSUFnY1NHWm1QdXdMK0h4OUph?=
 =?utf-8?Q?uq7UqqVmO+VKwFg3vKmU+phkJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f15c035-2120-4e23-f300-08de113ab888
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:15:03.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT16Ise2slMsuo7qYl+4T4wQ5SmBH943JK/Rodk6DqvTaQfySwWIyy6PtHMLOVwoDK7r3ByfNrJf7cKM5PuqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5929
X-OriginatorOrg: intel.com

On Fri, Oct 17, 2025 at 05:01:55PM -0700, Vishal Annapurve wrote:
>On Fri, Oct 17, 2025 at 3:08 AM Reshetova, Elena
><elena.reshetova@intel.com> wrote:
>>
>>
>> > > > ...
>> > > > > But the situation can be avoided fully, if TD preserving update is not
>> > > > conducted
>> > > > > during the TD build time.
>> > > >
>> > > > Sure, and the TDX module itself could guarantee this as well as much as
>> > > > the kernel could. It could decline to allow module updates during TD
>> > > > builds, or error out the TD build if it collides with an update.
>> > >
>> > > TDX module has a functionality to decline going into SHUTDOWN state
>> > > (pre-requisite for TD preserving update) if TD build or any problematic
>> > > operation is in progress. It requires VMM to opt-in into this feature.
>> >
>> > Is this opt-in enabled as part of this series? If not, what is the
>> > mechanism to enable this opt-in?
>>
>> For the information about how it works on TDX module side,
>> please consult the latest ABI spec, definition of TDH.SYS.SHUTDOWN leaf,
>> page 321:
>> https://cdrdv2.intel.com/v1/dl/getContent/733579
>>
>
>Thanks Elena. Should the patch [1] from this series be modified to
>handle the TDX module shutdown as per:

Hi Vishal,

I will fix this issue in the next version.

The plan is to opt in post-update compatibility detection in the TDX
Module. If incompatibilities are found, the module will return errors to
any TD build or migration operations that were initiated prior to the
updates. Please refer to the TDH.SYS.UPDATE leaf definition in the ABI
spec above for details.

I prefer this approach because:

a. it guarantees forward progress. In contrast, failing updates would
   require admins to retry TDX Module updates, and no progress would be
   made unless they can successfully avoid race conditions between TDX
   module updates and TD build/migration operations. However, if such race
   conditions could be reliably prevented, this issue wouldn't require a
   fix in the first place.

b. it eliminates false alarms that could occur with the "block update"
   approach. Under the "block update" approach, updates would be rejected
   whenever TD build operations are running, regardless of whether the new
   module is actually compatible (e.g., when using the same crypto library as
   the current module). In contrast, the post-update detection approach only
   fails TD build or migration operations when genuine incompatibilities
   exist.

