Return-Path: <linux-kernel+bounces-765454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA414B2364A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F3816973D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAF52FF15D;
	Tue, 12 Aug 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQjWFFdl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE752FABFC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025078; cv=fail; b=e1TT5iFcTuSvDjKfa3/GVgUrHTfHss4ztlp1yNDteJVku+XQ4+3LglhrH7zW4ICG362sFkHFNO5f1kxk5vlXEmh0cM1xndgm1QWw4x9xqf8RrFg3z8jaUCpUWcutfMuC6W4iOVf3cR+iNadNVrMkB607US/AW7he/YrIi9yi6Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025078; c=relaxed/simple;
	bh=fhlDdNL3Gn5SW9eWA7NYo9HgVrFxYI6Trq7PR+ATfGg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EY5X6DdlTVmNdX9qeOBJA2Lv2qXcvy3V0kTcY60suUq3r3/APykK0BbmNq2Ab6Ehb3NV2it9Xdb5npuIZfIFjQnCy6uL7C+PSyUDX6JA4TIq7b/nrT5krcnfMUwHaxTVZNKFoSbtEHxJ2JK9gnlfMegEePsLC0ctTmZxR5aCHH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQjWFFdl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755025077; x=1786561077;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fhlDdNL3Gn5SW9eWA7NYo9HgVrFxYI6Trq7PR+ATfGg=;
  b=FQjWFFdlcIAbhZXzDfi3tymVGS4byPC37lCvEKDDuG++3LhMlKNLKS71
   VlE5+XEWZlnY3pj/xgTeYBxfRIfRRwW0aEcvZL/+p1IGPxxFWxsqQuyjy
   QrKuYkMHjkhcREfBwenpRS229Bh747sGzNe7AGdzHZwDFeqxVXOpf/gZu
   42+f6SdxOQ2T234VBDwfTevY84ziuvY4pj44oU77EJLqu2CaHNtpuagQn
   GIulQcng1brxFAuIYlENyI2ifwFK9bGFuuJ2VQnvSeCdLIm+2ws8aYqR6
   Y+svLL1M+UWfCt83Tw8ByZlgH9h3+2Pr+bRdwNWITijxOsJ0MYFDJnvjn
   w==;
X-CSE-ConnectionGUID: xpmfHgJrTkC9OwXK5l/6qQ==
X-CSE-MsgGUID: 6tncUZQxShKTEb1tNipRtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61153887"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="61153887"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 11:57:55 -0700
X-CSE-ConnectionGUID: hPf1AjXTR5C8JrrpRtFJkQ==
X-CSE-MsgGUID: YKm3Ss2bShe0gAbpMlIuTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166645738"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 11:57:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 Aug 2025 11:57:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 11:57:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 12 Aug 2025 11:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V27mIXtsOPpL0vTZ7PrFRSnhqmrj4WsUqQM/vuRVuETXvCZi19BlNG7qC7iE1AKXrTrxpM++4qA2NEM51YkgaK/xL4bfNBn5gB82Y3ItfEZibE4yKG76jbM0CpnFpC1nuExQ/pl7vLKG5UOSfhQwvCjZTwCA3LhD9Xztw8ya5UkF0rAYhF4E4nXwZ6EkQvoTyXbKXK/NVGLptOf7hjT65Xi7vWJSgGNGPI3szLu3Jr9+q7Jcwx996QqoobnW3PqeSob+hySa9CZbNOKR+yRGVklr4a1Jb8M2LLMxlLrL8CvOMLU5rQ6WdISziiEK53SRxD0BGoSx59JujPAwPOj9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZL1HsgWc+EfUnq3faDKLwIn87gkAmByEi7Z46CSK1Y=;
 b=tZUb8QM4v3gv4X+q568DPkIpE3i0WFwKPdOUM+Chr4zO1GMDBgn1fcYX1bgnbl4WL+ALT9lTYX3XH3PrQHAvrbkHFxl9W0O3mEA6c0vbBGlnTaLi/Bwpw0+JQ7brE0XzjbdViwwSuOqsIcaLvk2sw57DAzFFJtn9WOhjt79Kk944vWGAZr/NNBGPOGH+b3xETovcJq0SKpNZIQTKBPr9lQcWsSRqUC6GAr0sNLl8JAYWhLIaxnlwRyfIS2Xke6k+xH/3HtINF6FjLWzK/L/FmBp2y23QkE9rJP2NGUe4hRNCO3/8OBxR3RgWDwbrC+a5K3X7e1XVoAF824Fod7sYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CY8PR11MB7289.namprd11.prod.outlook.com (2603:10b6:930:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 18:57:52 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 18:57:52 +0000
Message-ID: <17938a19-66a6-42e2-bab9-345cfa3cb818@intel.com>
Date: Tue, 12 Aug 2025 11:57:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/microcode: Add microcode loader debugging
 functionality
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-3-bp@kernel.org>
 <82cdc358-3551-4c8b-a387-0e9da4668b44@intel.com>
 <20250812102645.GBaJsW5cJLYc90Fhhg@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250812102645.GBaJsW5cJLYc90Fhhg@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CY8PR11MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: ba42c58c-3a32-4352-ac98-08ddd9d2237f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDJRem1GSFhSRXIvdWVRUXF5Zk5ocWwzaHhEUy8vSGttdmdDcjZKQXBSZnlt?=
 =?utf-8?B?QUd5eEpqdnlHdU9ZZ0JLc09GVjdlZnBhR3A4enNnZW9iOFNjT1Z0L0NGL2lq?=
 =?utf-8?B?Szk1N3JycHVrd2hxTGlMUlAxTUhnMXRNN2NCeE9rSlNRWmZsaVFwdCtiNks1?=
 =?utf-8?B?cCtEbWJkQ2NLL25FdXd1KzN1Y0w3amM3WUlXSXlwMWo3VUM0UGE1Q2pNcyty?=
 =?utf-8?B?Ui9CMDZNdnJyZlc1Q05wZUVBU1lrdzVFbUEwQ1NFMEZ6QnM3NzFSTVJhNHdN?=
 =?utf-8?B?SEN4dExFVjQ0eDJ0QnZ3SnNwMjhsNXVQT1NjMFMweWxvYnYvTy9oRm9nR3lC?=
 =?utf-8?B?L05tOWc4dlhqdTRSYXZDTkNad2hBTXEvQW9ZcXhaZkgxUVdUZFhTeGpDdnlG?=
 =?utf-8?B?eUU1MTYvd3llb2lrMVVWb3RHOGp2MW9WZ1Q0dklldmYwQTl1dWdUN1BQaGNY?=
 =?utf-8?B?TDFvMDI0OHpGQUVUbFEzL1NKUjZiYjY1YUlTcU5nOEtLMnlmVWcvWjZ5RVI5?=
 =?utf-8?B?LzlwNXJHNi9oZG9KNEZCVVYwdkxtQzMySXc0SnVwdC9keDZrN2xaQXVkMHNn?=
 =?utf-8?B?djhGRCt6ZnpyOXJPdmRMM2wxTGJKU1B0VFVYeWRpazh5RFkyY0pCYUdwWGkr?=
 =?utf-8?B?cVVKelZReXZqeUUrMVpEZjRmRUNodGhaM21pdWtKZXE1Nms5Q3BNdU5RMld6?=
 =?utf-8?B?N0NnOWltOENvZmJ0V3EvV01xTFZRZFZ0Wlo4VmcwWGxUSkZtS1VrbnllQUVI?=
 =?utf-8?B?Wi9heFovdG9ubElzK0w3MW1XT0trS3ZDRmxERGVPSmNDdUMwOVhDbDduM2pI?=
 =?utf-8?B?ckg3SlhVRFFoeEdKTklQTWdRVEljL0hTQVltdDhWSFNjWW9nVkEvbnlnMXhQ?=
 =?utf-8?B?SXM2dHdXZXhlSmVmdGloc2xLek16TVZlVGNSczcwY2lXb2FoYmU0cERqaEtD?=
 =?utf-8?B?YjRYWlE4alN0TUQ2MVUycHJ3bTF5eEtyT3NITmZ5U0hhMnpuMGRoVnRxRWlS?=
 =?utf-8?B?QjB4SzNUL3dZQWFXTWZCVWNXeElJNkxXaW9ZWHBDWXBYMFhUVXNkMFB3YTVz?=
 =?utf-8?B?aGN0ckFvYkZFdGIzdnBlYkcxdWRwS3oyakhaNFhEUjhhN2xmdnJVOXUyamdC?=
 =?utf-8?B?NDN3UWJrTEUrSUo0eWJpRlFNL25wbjVnU2ZpL1FUR2pCdCt1LzFPcnN3Z0Jj?=
 =?utf-8?B?Uk0vbkZNWGtKT2xOZEZyL3BwZXI3N3FGN0Z6ZlMxVW9Wand4Nk1DR1VDQjRU?=
 =?utf-8?B?SlFYb0xsOFA5TVVlQ2VRWU9sNWNkVTNjaDcxTFljdmg4bm5HY1NXL3N2VUsw?=
 =?utf-8?B?SmJTN2dsZVpLZ0ExNlh0cmwvQTlCTHZhckxadWFpeGw3ZWxVbm01bFdXemx5?=
 =?utf-8?B?M240NG5wZXY2ek5lMWhiRGNsWjJtUUx2RUxVcDV4RUYwQkxrRE0xUUEwTllR?=
 =?utf-8?B?SXlYVktlaFpHZjM0bFhabDllRXkxTkJ0UE9JUld0UzRDVnEvQVgvSUZIK3VO?=
 =?utf-8?B?VkVuSjRDeDVpRFZlWHdnNXQwQ0R2SDNDRjVEOWN6YUp1bUZ1S3FobVB2YlJi?=
 =?utf-8?B?K3BleUtTcnZYZUFtTmlEQzVkRlpjQ0VFVFhESk8rSDhpVVZ1cEtlOFdJL3dF?=
 =?utf-8?B?M1dISTkyYlhaM292d2ZVV1N2VFhnMjRrMXhBUXVScjR3MG1ualNVQldvSHRZ?=
 =?utf-8?B?ZVdHRThHeFdXOWhldHJ5RHRBa28vb1E4NjZydTVmd0xQaHBGczdQdVFpMVBi?=
 =?utf-8?B?RktLN3dGemkvVVE2N1NTY2dFbUhYTjBiWWJxaHdjUDlvVzZock1CcUY1ZjY2?=
 =?utf-8?B?MW5LOS9kUnFVVGp5N1JXTERUSDlpYTBsZzFGa2JESUxzRGlJbloxVVI3dEdM?=
 =?utf-8?B?bUdzQ3kvRGFpRDRFZ040VHAzdzhrb2tvb1VjU0dtQ2pLclgyZTlDOUVrNzYr?=
 =?utf-8?Q?lgdQoTeiY4g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUJJak9vN3hQaXFWeFFCL2hJU2tUYS9XWWxhQ0NHWmtZSDJKYTJIaHpHaDdh?=
 =?utf-8?B?akd3RmZXWnFDMkpMb3lrcmhUOXdvd0tqc1piUDNwS21FMDM1VTZWOEdpYWI2?=
 =?utf-8?B?RFpGcG01V2dmR1k4Y1FZUS9makJvbkt3VTlYRkRtalgzWU52bjVaMVBkSkdo?=
 =?utf-8?B?QkNMc0J3OVo2SUhQcWJOVlVOMUdXYjNHUU5LOWhjSy9Ma2t6RUlLcGxRRE1r?=
 =?utf-8?B?MUxUWWlFSEgvQVR6NzN1TTFBeVZRT2wzVGxHSHVhUk9TT2o2RzMxQ0FoeDlk?=
 =?utf-8?B?OU85ZUlzTGVSNWhiUzUvK0k2QnVaZWMyMnBCR29qcWZYVmZIMkxKUy9YUVR3?=
 =?utf-8?B?ZU8xeWErQjF1c0NvYWQrVU1JaWhvbUZCbnpUdklCY2owMmlvZFZTQnpjcndR?=
 =?utf-8?B?SEo2UEo3UFZkWkxNTWlPeDVQUkZyUGVIOHUzc01YRHJwcGZNY0JCamlHbnNw?=
 =?utf-8?B?KzcydGptQ053dkhLRFpnR3R4VFJPNnlIT0tUcFBtZURnQWt5QXM0amZLaUJO?=
 =?utf-8?B?UGlTZVl3c0ZQZ0d1NnRMQU4yM3lhaWRNRVNoYUtDSTArdE8wb2MvYytiQ0hv?=
 =?utf-8?B?RytvNU5VU0lRejBVb2hsZ0hwYnJiSllQbWJtT2JqNFBneDM3T3l5bmh0WDRz?=
 =?utf-8?B?YWZNUXUveDZSdWpZdHhCVFhyZWVBMzNwS3p6K09TcXlaRGhtclluYzlwck5r?=
 =?utf-8?B?YjlZNGFrNjJuQWhtczdLZFNCeG5rZ2dsR3BTZERXaWRIbTg2cXRNVlZGN2tT?=
 =?utf-8?B?VGZKb3ZvSk1zK3VvQXpWcE5XbGVrSlU5Ui9vSjRnaEdadmFPQXRVck92Uk1C?=
 =?utf-8?B?T29ob2ZoLzZqTTEvMnd1MzgzdHIwVzA0Z3FpU0hWai9qbm1DakNvR3pwS05K?=
 =?utf-8?B?L3FVWkhVN0RaSS9yb3o0SXdYcm1JR3lxeGhlSElwNnVnMzdyZGcxV21wc3ZX?=
 =?utf-8?B?S29xaVFRaVdLU2IxaVBHRHR3R2VCaGwvTmp4aUdNZWdqQjZCbGhTeVRSbGpy?=
 =?utf-8?B?bERTZmpQYysrWEJmVGRTdWd1dHN5alVvVEtFdjVrN3J0YVVTQnRoSjZlNTBI?=
 =?utf-8?B?Tk9hVHFabUhZb0I5REkyOGNrSElscWh0bWEzaS9ubm0rUGIydS9lNEt3RmR2?=
 =?utf-8?B?ZHUrRUtjNEgvbEg5ZHRvUlFYVG1kaWlMamZqUVZ3bTJWb0Q4bG01Zml0OUZX?=
 =?utf-8?B?bVExa255Y29WQmRLTGQxRDNjR2tCM3pHMW5pcWU3S1NRSUU4T3NwQXBDUWI1?=
 =?utf-8?B?UGhvaytsT0ZjRnh3Zi96OTY3ckJKTy9QNjNNZDVxckdiSHhtTjByWG0vQ3dB?=
 =?utf-8?B?UEFLdDRRMUZ0Q1YrbExyZG8yQkQwQTBaU08wWWduSXhaWTc0SXVsdGtnZ0Jw?=
 =?utf-8?B?YXl1S2s5Q3VEZWRsTXB3b09KbmRkTXlUdnJnR3dqYWhXclNwa291dlJua0dq?=
 =?utf-8?B?ZlV2Qng5bE5OMjRGNzJ0WFVkMEtWbFFTQ3JDRkpUOHp2bzk1T3pMNm1PbDN1?=
 =?utf-8?B?RVFSRVlyVVE0c2tsaDBiSk01MkpZM2VyL0lZRkUrQ1pwMDNLM0V4NkRMQnJk?=
 =?utf-8?B?QS9BbW8reEZBQW9CN0p1K2JBZXVpb3dJQnBqQW9mbm0yckNyQ2p0NUZSMEdq?=
 =?utf-8?B?SjgzeVBsMzFGb3VpMFV4b0NOeXZDN0ltdUR4b2JqQkFPSHdKTXJKaWVacnZx?=
 =?utf-8?B?OFhRT3JCL2tBdzBMald1UlJUMWNtS0haQ3UxZEkwSGZoclpDZmpKTUsxZ2FH?=
 =?utf-8?B?bjhmVi9xMEdBV1NSem1wQlpmblJpVFdKQXF1c1Z3ZEVlbW8yZ0dYamN1VkVm?=
 =?utf-8?B?cXZBcVpWL2JyNlhuNWlNTDVLSnJnNzBqc1k4UU5vUDlaNWd3V3B6aWdoT0g5?=
 =?utf-8?B?ZFNTdFR3R0dkcm85WUJDN0dzeWY3Vm45eUx3bGJrYlpkTG9GVUdWZjBraTBN?=
 =?utf-8?B?N21QaWpvcWI1eTluRWIxNS8rbktIZHUreldIdGowMFNyNFdEam9OQlNETzdm?=
 =?utf-8?B?SDgzQndRV21Fa2JSSDJkSXdzUEI1SFA5cjcxT1NlWnJkd2hJemxIdkNpVUJn?=
 =?utf-8?B?UkdzTFlTd2ZFei9PN2NCaFdrMHhFVVJGSm1WbEVkVkpXbnk4QStXS25qMjNZ?=
 =?utf-8?Q?Fd2i81skFEulUCee2nK9C0JFW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba42c58c-3a32-4352-ac98-08ddd9d2237f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 18:57:52.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6n7GmcUkxQUvumxtw1c5ct6ZaJNDZt7lFpxQ873e5fE06yIXBBpeL4ZGbHxip+XLePusBALn4d9YiOaUXHN9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7289
X-OriginatorOrg: intel.com

On 8/12/2025 3:26 AM, Borislav Petkov wrote:

>> s/dbg/debug/
>> s/MICROCODE_DBG/MICROCODE_DEBUG
>> s/ucode_dbg/ucode_debug
> 
> No, because I don't want to type unnecessarily and "dbg" is very clear as it
> is.
> 

Yes, in this patch, dbg clearly means debug. But, are some contexts
where dbg is used with other things which might take an extra second to
process. For example,

	if (!cpuid_feature() ||
	    ((native_cpuid_ecx(1) & BIT(31)) && !dbg) ||
	    amd_check_current_patch_level())
		dis_ucode_ldr = true;

In the tradeoff between writing and reading, I am more inclined to make
things easier to read. But obviously your preference supersedes mine :)
> 
>> Should we also include a dependency on DEBUG_KERNEL?
> 
> Because?
> 

To ensure people only use it for debugging purposes similar to
X86_DEBUG_FPU or DEBUG_ENTRY.


