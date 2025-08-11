Return-Path: <linux-kernel+bounces-763536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7AB21650
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3C3AB6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247A72D9488;
	Mon, 11 Aug 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZVRw8az"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577ED72600
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943379; cv=fail; b=NBPcUuK+nJVvi21CR6DD8M2bUtRYV3wmzNJTZZVp8Z7gNdqCI/0u+9QemY+pzN1uKQb6pEJ1FVGd3uitrtIzFOyLX2AAxuAaLciblFzXg347rLVaqcSiQUD9G5/gWMh7aXfQiDY4EMR4w9P/qgVA1GXgr5C41V73kOlM/84AiaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943379; c=relaxed/simple;
	bh=KPHvBktJNbQalHbpnYXiLbP7YrDL0+YXCNV+ndMVxE4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MF9VNIVm0OTLm+oer3hq+cD2+3juwHLBhkcdOSW/k5Yyp0xYSJD/gW+/875t+8sfazPztaTdsS6q+Jr9Py2q7eDD9QFE2BLvOmH76/p81zi05/hWpJfVFe9WMryxUNUX04Rq6WIARybleucjYiRGbGpNB4ca7K17gW5NuRlOZ1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZVRw8az; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754943378; x=1786479378;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KPHvBktJNbQalHbpnYXiLbP7YrDL0+YXCNV+ndMVxE4=;
  b=XZVRw8azI/Q1OVIANPW13/amN6PoYfT4TVQCI3XnxyBp6/aMmOW/MCgk
   d7zjDZ7l+4gqhC25d2cGjp/dl0MgiteCCqzGENFXnf3L2fglN6O4rPHn1
   k7Mm5+Ey6/jMelrgxyclfu4sCNkAjUb1Xbb4Na61ClDh0eu+aK5zx1bSj
   DMPUTe7gZvtbXIgbyNVCL9augw57xv6FJu3rLSIw5LteXIIotG7/ZkvjL
   KZ6aTRvBMlFZe8wXm4Qz4o3Mt+ItgWdtYo2MzQcPXX0UIv/NN4Q7oGizV
   B3n3imDIqch52PAn6hl8IvIVbqxGLwSHAMOtfv5I0SXUZHTyzobeoZGjv
   w==;
X-CSE-ConnectionGUID: sArjajb3RIGf2a2JPWRXOw==
X-CSE-MsgGUID: LNVYfMf2Qw6Sdt9FiKvvzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57352416"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57352416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 13:16:17 -0700
X-CSE-ConnectionGUID: +MDtkQGrRqWQQaKvHPuz3Q==
X-CSE-MsgGUID: kMxw0YeVRH2tR0bGJBrC0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166396287"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 13:16:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 13:16:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 13:16:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 13:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smySAGpScFGN66u8lqxj07qjYo9Kw1znqYDMD1fylgUwH8wqvLWlcZ3j3IKPZd45C+YXG9qqeki6tHtlwUOP4tDerLUSO2UvggdeJTMXR/UMB3tuuADucyqA1BwHR861IY150fk6PT3Pc2/utCA/kIclygZgx08Wfoe/BXBPDsVVw/Y2T2OgAoBWAZWNL5x4U1P3083/zX8bKGV63fMPMofU6Y5VQmDADXWgZB5kRfEizKgmW0qrZ4re9fdbw5bxLYR1XkNssUa6fu6ea2IKsa4YrbGlnqD+zL7+8ZdGTabXMNyqOoty8JjuBJiMy2afpS+nSbwUB9Y8QoOV3M9xrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0KQvpUaNdGjiIoEPnglBv6bT2U9U7W5iDSpY6qEAJI=;
 b=Z7qpOshYLCH6zmcd2o+SKHj4osgybmu1FWMZfC+vaJQhM8uDrQkhVQ5mDYa2wORSVI3jBfUtNosAxYY+Tk1WhzStTH0T85C6bn5xflRrJcRri2YncGHLLBCy0PLASawJF4U8IYVgyEzwSj4BxhaIRxZSfoY/N+Ws+5Usnp2lZKcJ7/UdGlpWhsrLJvgy/9pEkPsWm91lV1EOu04NS4hKEkMTkZseggyIGpCF1iBmijpnKH1hvzAVj9C0bsltodgOSgCpPB1RE7rLBpge7WQRdazxbNO1CLxqDZlJ3g4RnBO+IFaZyyNeio7bT9d7jPLh72qgLQosPIgtuT2Fj+1Vcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by CH2PR11MB8815.namprd11.prod.outlook.com (2603:10b6:610:284::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 20:16:11 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 20:16:10 +0000
Message-ID: <f6f7a962-eae8-45e0-a8a5-ead0b9f37575@intel.com>
Date: Mon, 11 Aug 2025 13:16:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/fpu: Fix NULL dereference in avx512_status()
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Oleg Nesterov <oleg@redhat.com>, "Chang S .
 Bae" <chang.seok.bae@intel.com>, Brian Gerst <brgerst@gmail.com>, "Eric
 Biggers" <ebiggers@google.com>, Kees Cook <kees@kernel.org>, Chao Gao
	<chao.gao@intel.com>, Christoph Hellwig <hch@infradead.org>, Fushuai Wang
	<wangfushuai@baidu.com>, <linux-kernel@vger.kernel.org>
References: <20250811185044.2227268-1-sohil.mehta@intel.com>
 <6f8307dc-c3ab-4270-8215-c441f0e3f4c4@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <6f8307dc-c3ab-4270-8215-c441f0e3f4c4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|CH2PR11MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: cce2de88-9077-4fe3-533e-08ddd913e9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0xFSTFYaDRUOThIdjlsclNQUmNPaGVxNG9ZaEIvRjJGb2JERmlUMVROcVpt?=
 =?utf-8?B?RWxOZndkdU5qdXh3NG1jU3IrakFRZXBDa1g4OHlRTVB5d2dndmxidStmTVFq?=
 =?utf-8?B?aTJwcUxkYWVaaGJzMGI5OFpoc2xhc0FQc21vV0VpbDF6NXpOb241UHI4cEk2?=
 =?utf-8?B?ZGZWYkVkenBveVFwMEw4RFpqZGhzb0VLSmRxRnIwTXdnUUM4MGt2NEFBcGtO?=
 =?utf-8?B?UTdPWVF5VG9BK2QwVmxvRW9iekg3TWZXS2llaVBrU2ZzbzNmNVl2eGxwdHVR?=
 =?utf-8?B?U3pOTVVjVTJPZ2RZK21kZFFmVXhIMGtoMmsyVkZTZUJ5SlhTSGlLTTN3Rk5P?=
 =?utf-8?B?VjA2WHBLZHl2TmRyWnFoQnh2em9RTEh6ZFlmSnl4UWVVa3B5dmw0MXlOazh3?=
 =?utf-8?B?dTBWd0FWdm1qbnFoU29qUzM3VFBHY2FNNEZseEtxYkdMZjR6allLemRLNTFI?=
 =?utf-8?B?Z0lEZTY3OEVNeFI1MlpoSjZDdDkwbU1LSkR1a1JBR3JIR0l5aXhwUGNyNG1r?=
 =?utf-8?B?OUFVdHY4ZVR2RHkzbjhWMTZTSGdwc3pJQXg4QVp4bWkwczhMUS9HdnhpYTAv?=
 =?utf-8?B?QUNIZDl4OFEyTWRVbVNub1lkWExEbmFpVlNoYmh2eGcwVnhCU2FXQ1A4Wmoy?=
 =?utf-8?B?ZEtxay91Y281bUZraFJTZEZUVzNKSlJBTmkvclNGWHF0VS9lVUo1K2tqMUI1?=
 =?utf-8?B?NENFa1hvUHVRMFpZT3ZVWHJvYUVza2xyajVvN3BhVEhib1kwNGJ2bVlqamJ0?=
 =?utf-8?B?M0Q0djNxNWxNcXR0ckhoV05GUngrS1JsK2ZCSDVtbjJXNUNMdWZQVkhEcWg2?=
 =?utf-8?B?a2Q2eWRTcm4yUkF3K3oxZlY0ZGZHMVM5bzdmSS90cml6ZU03RG0zSVV0UEVE?=
 =?utf-8?B?eENUbmNMcEwyVUdGckorUUZKUXE1QThOZ0g2MCtVankxQ21iL1ZUOEJodUFu?=
 =?utf-8?B?aEN5TTlGbm92S2lYaVFWa0tUZTk4RU1ZUWttczNONFloYndmUlJGaVJ4eTRT?=
 =?utf-8?B?VTZlUi84dVIzbURyTnhldFpNZTlMZE1SSkRJM1ROVG9ybEo4clcxY2VWV081?=
 =?utf-8?B?L25ab1o0VzVleXdPYzErU0RNNVlXVDNQd21XdU1EMGt0NFhzNG5QQ1FxUlVi?=
 =?utf-8?B?aFg3dnRqbmc1aXFkQTlLVEd0anNsT1I4aW93SStNRXlJNFBKR1NpZmM2RlVk?=
 =?utf-8?B?dUUyTUlLU1ZLaERqQXpzVjlZTEQzTVIrQThHTEd2WVBaZGtsbHUvOGFHN3hG?=
 =?utf-8?B?TUpNeDRKLzNZamZTckxDT3RIVngyVnFvU2dNN0tTVkRkbytjOG44UUx5UEZ4?=
 =?utf-8?B?SmtRWXlnYmNIQkIyOTFELy91aXEzQ05DMDdFcVJKQThpVEpvOS9JSkFQbGNr?=
 =?utf-8?B?dXBmS3JHaGNxNDNWVG5QaVJURTRON0RkZmVDMTRTMzRpaFZ4NXlmNFRxaTgr?=
 =?utf-8?B?dlQ3RDNvNXNveFAxYjRtSUlLdzl2Q0c1THdabSs4VlNNbDhkWE9FcVh2VXpF?=
 =?utf-8?B?NDdZa2dBTmtCL2IxaEhsVmF5YkY5TFAwWHhNZzVUTGg4ZSs5M3FPNUtOdE9y?=
 =?utf-8?B?OEthQ1NJZE1pWU5HejhmTFllTVp0UkhGR1N4NUFpWFpSSHlKL0hlbDZ2aWxx?=
 =?utf-8?B?RSt2V3JLZUlERTMzSVZZSlBSZlZENWRkR1l6cU12d084NzUwT2VyYi95cUZK?=
 =?utf-8?B?OXdLbTFOTnBlSyt0RUNQNEJDUGY1WWQ5ckJEcExGcEU0Sm0zNytpbkJ0KytC?=
 =?utf-8?B?blp3MnI5V2JyU0FkRlRIbW5hUWZ6aUxDbS9sZENOTkNsb3hZaTFCZGFqUDlH?=
 =?utf-8?B?eHAzWkwydVBMRlYvT1VJRUVseTdtYWZ0ZXJTeG5BZ05vLzRCT0Vha2NMWTVW?=
 =?utf-8?B?MFRQY1hpNnB3RVh2dDRncEJmajFIdnRuZDdIK1p4UDJubjJSQVBlbkE2T3N0?=
 =?utf-8?Q?WnACk450oWw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFwN1RlRzJVL2xZNS9pN0x6QmhQTzU4M3VLZVZMUDJHNVpOMFZveDBGYTJG?=
 =?utf-8?B?cndBdTcrRmxmYXIrMGlpUUJEMUhkZStBT3FxNG5TQ1NTRnc0Y2JraDJXWndU?=
 =?utf-8?B?cnNoOGg2MGIrVUVmdktNUjFIc0lxVE5TTHkvR0lLb2VSdys0UTRxYkozRkVu?=
 =?utf-8?B?VkdLQnNJTGtaNXQ5V3RhTk53KzNyVUVwMmExTyszbWhWTjVqSFhmS1gyNEox?=
 =?utf-8?B?aXNyN0NHN1g5VDAwNjAxSzlLVVJTcElmemgrVDFJcENUeE5VZWFWVGMrbXJr?=
 =?utf-8?B?L0psbjBIcUxrT2wvUjRMbWxtL2p3T3Q0THZaMnIyeHU4VVp5UWxaMGhacllS?=
 =?utf-8?B?RzcwM29OdDBkbHBZYkY2UzBKVWhBOUJwTjVINGlZMENkclRMWUdDU1FUcE43?=
 =?utf-8?B?ZUVVVVVHOW5BbDJad0lOR201dVZ6ekhHdVlWcGY4ZkRZOGZtbElGLzIwbHdv?=
 =?utf-8?B?dGN3NDM1YkZ3NXJVWlpjU2ptMnRFMEJhU2xGTWZ3U3RjQUNUcktoeHlUOVFs?=
 =?utf-8?B?SDJURTV5bGxHRWtQRTlZb3BqZUd5VXpNK0VJZ0JIeHVnUFR2ek1rZERndGVM?=
 =?utf-8?B?MVgxd0xTdzhoa2ZVU0g2NWVBMFoybE9pVHpzelJqcU9jU0pKWllpeERGc1No?=
 =?utf-8?B?K0lTZ2ZsbU9POVV6elUrVDY3NDA1L0c1Y3hoUWNScHZqVTJjOUF5NlRubWIv?=
 =?utf-8?B?ZGFCWE5nVkZpSm1LalR0T1FFc3Zjc0xSTERlQ05kUkIrc0E1WXh3RWlGUDFV?=
 =?utf-8?B?VFB4Zk11YzVCVUREd3o0K01YalVERGl4Z3dKcWJCdjlKS09BUmZOWGxuM25r?=
 =?utf-8?B?ZE9jcnhyT0hFVkZUT1RFVnpRY3Vqa2VvN1ZQek16Q2Mzb3ZvM1Q0SW9WcG5V?=
 =?utf-8?B?VUlna2xZako0MXNLdy9WMk9SZTR6ZHJjNEk1SGpEOVVLWUx1SlN4VlVkdk9P?=
 =?utf-8?B?SEM3YUZNK3RXT2hubDBaZUppejRlWnRLL2MwdmlpWWpkQ3ZlZFBINFU0Z2E3?=
 =?utf-8?B?SkxlME1MaExDaUZhTldkQldzQXV3bFIvUHM4c2dYSEJMWU5COWNGbHd6Z3ZL?=
 =?utf-8?B?ZWkxTGsrQlBKWk11SmxVWkttOWlMVDRZNnB4OUJ3a1VxRmhUU2Jucmt6cTY3?=
 =?utf-8?B?aURRQ2h3QU5odTF1bk8wOHBSMFFXZjNnT29PQ09IcXlsQXBxZm1uRW1nTnJj?=
 =?utf-8?B?WFlGcGN1cVNaS1ozamFQa0NJNzROT3pLTW03S05vcUdrMHB5d2xrdmtDWkZz?=
 =?utf-8?B?dTBxWWU0b2YwTjF3WWNHQXNFMTV5NStPY1Q3THVITU0yVXZpK3pJWXU5SzNh?=
 =?utf-8?B?UG5aNDlyOUVrMmF2MUljY0gzNHBOYjlnYTBNQ1pPdVQzZXJXcHBYTmxZRlA5?=
 =?utf-8?B?cDcvaFZvWnI0MWgzQ21GRm1QdEJ5ZzlMZkxnYXhlNFB2aFMvNlExR2dSTmk5?=
 =?utf-8?B?TEhOaDc5Mk9xb2xjRUQwdHV1a3Y2bTU2K1orODAyVFJZbStjUlFYRmVub05T?=
 =?utf-8?B?OFdWUUNnY0d2RkdBT0R5bHM0VGFXS0k2bmd5SDFCRW9rUGRYeGtUVlM0NWxO?=
 =?utf-8?B?N2dyQUc4RHpmOWpaeUZVOFF5UmlrNEQydWdQTWcxRDAvNW9qRnBWT0lJanlW?=
 =?utf-8?B?K3dLeXRsaGJrNDJRa1FjdHZSSmswdEV3aVVXZlZCcTV0OWk3R2lTd3RDMDdN?=
 =?utf-8?B?SmZRUUkyenlEL1ZFcysyUmIwZ0tKU0pjeXVaSWpFaXdhU0RPYm94Z3lrcjJt?=
 =?utf-8?B?TTVoUnBIR3g3Rzk1Q3pQc045R0grdytZREhLUERkdUdudWx4cStiTDNGbklP?=
 =?utf-8?B?eENpL2pvUW9SUTRWNDMxbDE4OTI0NDMybkRYZmp1M0hNYkRqcUVnam02bEo3?=
 =?utf-8?B?Y3REUFRTMzl3cm8zQVUxbUdMWXNyRG91Zkh2LzRQSVFvR09oYzhRMnVPQjY2?=
 =?utf-8?B?bCswL1lTc1Z6bDE5VGE1M29DTU1BYUJJcXVSdTJEUWVRME1TazhLcWtaMUZ3?=
 =?utf-8?B?WGtpNHRWbnQ5MWdUanMxTUZ4WHM1MU9Gb2NuakVxWEtYMGRyamROUnVuTkR2?=
 =?utf-8?B?ZUNodGtnSUcvYXF3V0trOEZPZDFuS3c2NGdCV3REdVBDb2RLUHVZSEw5eUZ2?=
 =?utf-8?Q?bpzaxJCc4R4GTg18vcn/UEiW2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cce2de88-9077-4fe3-533e-08ddd913e9c1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 20:16:10.8531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxaoNehM0mX5qwLngR7vN1B+4qI+ItQqONxgX/oLauhcHaTH2jXb5NmiBVGkZfd/EusnkxEFNZCnFY3+YArh+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8815
X-OriginatorOrg: intel.com

On 8/11/2025 12:22 PM, Dave Hansen wrote:
> 
> The changelog also isn't really converging, so I gave it a go to
> rewrite it. Is this missing anything?
> 

Thank you! Your changelog covers the essentials and makes it concise.
The dual nature of x86_task_fpu() was making it hard to write for me.

A couple of typos:

> This is because the AVX-512 timestamp code uses x86_task_fpu() doesn't
								^^^but> check it for NULL.

Missing "but"

> If anyone ever wants to track kernel thread AVX-512 use, the can come
> back later and do it properly, separate from this bug fix.

s/the/they

> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/commit/?h=testme&id=d61828dcbcff4ac80b91f5071ba6d21ef6c97347

It probably doesn't matter, but the documentation suggests ordering
Co-developed-by and Signed-off-by tags a bit differently.

"...every Co-developed-by: must be immediately followed by a
Signed-off-by: of the associated co-author."

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Example of a patch submitted by a Co-developed-by: author:

From: From Author <from@author.example.org>

<changelog>

Co-developed-by: Random Co-Author <random@coauthor.example.org>
Signed-off-by: Random Co-Author <random@coauthor.example.org>
Signed-off-by: From Author <from@author.example.org>
Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>

