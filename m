Return-Path: <linux-kernel+bounces-778986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B528B2ED86
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B7D5E4A03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8732853EE;
	Thu, 21 Aug 2025 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bx3UgGfQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8062222B2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753561; cv=fail; b=C37D0oDQ6wtGMykcfm7+f/eG1iyRGvNpBuW9qF2HiXv5G+BpjU3Vj49Uf9xtjYSbJBoibWxbmU23L7xW2IkE/k7W7zURHav5GGHVuYV61vsDKiq5hduw157IJI4GiuEy3tbIRefzNtMESeMEYtNCtj8kMBftM7uZsH/U4/pI730=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753561; c=relaxed/simple;
	bh=ds2ZjUzQ2/DpunAwLphc1R/t2aYicG4gVYsXAOsS4P8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2NZcR3Gtq19hTNJ55OD0kp2djSJvP74vRRxuFVNZyr/0hYhQBRg40LA8puSrQA9dEJEwosSjEDj5E7+GrJH8FpQgrUy2Fbj18Fti7L9Ze5Lp2lu8IfePEoJd9vfon3WK+zqwFPMpzPmJQ50FlFH7LZi/uqYc+msDfpy2XbRL00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bx3UgGfQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755753559; x=1787289559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ds2ZjUzQ2/DpunAwLphc1R/t2aYicG4gVYsXAOsS4P8=;
  b=Bx3UgGfQGwLw6m8ESjTwjppBYfE0UvHd/us5oY2WGLTjg3Z9xukJlGkg
   FJkSFJLHM4tiHRksaznkNNbhU6Uq2p+jicr96/1iR/YH3puPOyx9mqkeU
   O/vaSzPlmz1Lv7J/W/7xzBJpTZ2dWAyTpDIpnBV1rDb/OqE9YLy+sA0p/
   lEk0rvGWplPKQc0hiu6F7ABoHc1eauo/3I3iNTyi35pUw35pArG+k6m0r
   O9cuM/D/116JcbdoYeIJ4dtNnx3vqFK0TwFkxOD1BrDvTtVm/G2mj81D8
   t4y/JEc9CZMw519pjN3KE82huUKTi+nSCA2nSX2oP5e3JAMnHy56+DrRh
   w==;
X-CSE-ConnectionGUID: ZL4YyggGTYeOk01XZjz5BA==
X-CSE-MsgGUID: 1B7bK+3UTpC7r7FbcTfF5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68735864"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68735864"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 22:19:17 -0700
X-CSE-ConnectionGUID: 0WhFQ74DTF+ogjwJbyOo+g==
X-CSE-MsgGUID: 5Nrhm+hgQt6dqZk7T+FaaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199301396"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 22:19:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 22:19:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 22:19:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 22:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJEP7W5weA5JSZzu2cGQFCbEzAUdBO53RtUDlkGJ391MseLBQjsDfW0Cvmv6QxxsmEe87r8AZ0V+y5rWYDjwuJqKdn8UEI+zk/JWJSBhvE/xKO2MyoIDSUzGL+OgpWgBluVJjxv/jzlI8P255eCbWp4mcVgbE/NUcQyl07MC0nqJ5xL4i1paC+ihN53kQqvdR4fQ+uoW8rQ6Ae2bzrmQvythor3lGFUNDe2w0Fng2tC9OOrfpOMpKJGdqH6TLmA7MY1nU669eXLJN2g3IfcjCg95ipuo7L8npDbvGJMii1UBRQfyN7HOvVxbUQI90G/HkfW27Lhy4PHcTt1thrRYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsGWkpwbxPabDJVpYMSw/u49pAdA0ja9sEDLsO+6fcA=;
 b=Nu3mb/0D4zij4bA3BQ8lzA0KUhYZI1utmLTfrjG42uZirWd+9S+KtE1Q1PebwVI71+/Of9D0nCUjQtYZC3ACfQRmT+FhU77OOCocE0CeVvfWA8z3loUzUMp/+zx8aAgKWefJMvI8pTQgcvuzFZbtCTAprfrR3E5q2ofgzx3Cp1No8uPhXm0kKfy6DeifQZKAUrTBhT1XDHkJGB2TSilpuKng3pnDhDYvvZsjA2idbhwmGT/iz0UmHjh+Lu5533NOOYuxCzr5SUV25GfGL3FcAM2KoTEZibXB8EvFDsC1FIZjehbxMNfk6f7evDz108ffOGv+reIy3DPyhXHCF3z8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 05:19:14 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 05:19:14 +0000
Message-ID: <2cd370e9-6fd8-4aed-8fe8-c8526a1ab97f@intel.com>
Date: Wed, 20 Aug 2025 22:19:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v1 2/2] x86/microcode: Add microcode loader debugging
 functionality
Content-Language: en-US
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>, LKML
	<linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
References: <20250820135043.19048-1-bp@kernel.org>
 <20250820135043.19048-3-bp@kernel.org>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250820135043.19048-3-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3cdc1f-2b5c-4b1b-1566-08dde07244ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjNhdnZoSU54bUQ0MEhpcHdPd2dlc1FKS1g3WkdLdjdhNU1HK2FTeGQzcjN6?=
 =?utf-8?B?dVRjYWhXZ2thN0JPb1Y5QTFrakJ1SDJJU2R4bFkyTUpDMEpJYVBRc0tvdTAw?=
 =?utf-8?B?WEhZK2JMMFk5UzRJRW9aVWNydnNRYVgveCtyaUtsUk9jOFl6L3dDazhYbE9D?=
 =?utf-8?B?dW5WZGFNbkVDamxyTlVZWTJNbHZDUEpNaHhaTlRuUERObnBxVzUyaDBSNHZv?=
 =?utf-8?B?TnloL3IwTjZZNXBaejVqUk1TVWJXRjJucm9KWVJzTjZrVEJDcDYwdGJKcEsv?=
 =?utf-8?B?ZnNDdzdoUGhXaWs1YW1GL2pZMUNSZ2RFcXJaQm4wck1DUWRNbnhiVGoxa3BV?=
 =?utf-8?B?U3NvM3duamFMZVQ1M3ZEdzF6NnRFMEFYYVE2Qkd3aldjSEJkWlZzbmFkd1J0?=
 =?utf-8?B?Q0trT1ZEYmZreTZDYmU1cXgxZzE0NGxKdXdjL0RmdnlYMnJoRGQ5TndSekF1?=
 =?utf-8?B?dHU0L3krRS9BTElVbVZTSnI3a3pOY05IQWFkb1ovZXlXbkh1ZCtSVitZWXMr?=
 =?utf-8?B?eW9aa2VIeHpleENtWnd5bTd0WWdldUJYMTZxTU9RVFlES2xmUU55SlZiR3Rx?=
 =?utf-8?B?NDZhR2dYemxRcjRNWGVVVzg3dlArRkdTNUl2Mlg5Rm5KM3FxdXg2ek9qSXhm?=
 =?utf-8?B?RGV2ck5zQTdteUl6YnAwazl6K0lNQlJBNnhsM3dYYk9jZmVrT2dhYSszMFNX?=
 =?utf-8?B?eVhCVDJ5WmFQUkVJTFIrQk1TTkNldnliZXR0cy9wVU9XcmtwaHdTSmpFMmMr?=
 =?utf-8?B?SkFWd240eHVlMW56S05oajZKNlhZaUs2eWNiTzk2a3hsYlZrdm55MnJUMEJh?=
 =?utf-8?B?RitjZ1ZndVpZRkp6TUlteDd5WG44ZUdSd0ZOMFFBQS83V2orUnBOMGpPRnY5?=
 =?utf-8?B?d0V3TWJvNS9OOUREUkVQSnhEb1JEOXJsOUZobk05dUQ1elFGbHg2dUJsTVR4?=
 =?utf-8?B?cW9aY1ZsK1ZsSnFOdTlkWTlPK2k5MzhzTWRxaDJvT2VzQ2FlU1VGTjVreTIw?=
 =?utf-8?B?REhVY0JNRG9uNVhqM01PelAvblZjVU9YczVmUlJTd0xwa1B6NHQ2bjFmNWR2?=
 =?utf-8?B?eTZITzdXOEVsYjVyWjc0bm1CeHhYSjZ1dXV2Nm13ZWRNQzlzVjFMV3IzejdS?=
 =?utf-8?B?Rnlvd1FQQmtOVVlWVTZFUEFXSDluazI5bEdZdjVNMTZHV1dPZVNSWXdlZXVp?=
 =?utf-8?B?cFNhVVN0VjhJTUduUHY2cEwxUlVqTkkwNTRpMjBSSlprbGdwNzAxSWhwWDJs?=
 =?utf-8?B?ckk2ZXVIZ1JZZnNHVUVnS3o4QWdlNjRybmxDQlVuQjdjT3NIc0lhL3IzeXBr?=
 =?utf-8?B?WHBLSytrendsU2I0ckVLL3hPWnlxQ3dBdkdmSXhqTm9lOWtNTGlZUEticmFC?=
 =?utf-8?B?Q2NDR3J2S2RwY1lPakU5YWlFRXBkdUwweEdrLzF3OFhRT3pZeGNoUkpCYUZX?=
 =?utf-8?B?cXNNNHdnT1FTR0JHa3pMTEpPcHVtSW13Vkc0aGpSL01TSStIbnp1ZXh0dW05?=
 =?utf-8?B?OWJEd2ViZ3VEUkkzMGh6R3lBZEhFTHVEdG4zNVJycjE0dXhabXVINVRXTXVE?=
 =?utf-8?B?czJPREJBM0drTEIzSWV3Y2RIeUpyTFljNlpGeHZGTWx3MzArK1Bvcjg2SDBM?=
 =?utf-8?B?elpPaEh0Sy9wR0U0c0o5dEErK0VYd1FoUmZKUFA1amR1WHU3MEc5MjNIOW5P?=
 =?utf-8?B?YVpmQStRcWhwRjlUUkMzaVNjLzBMaTVTdnF0YWd0ZGNXU1JacGI1OVRPdmZZ?=
 =?utf-8?B?NzFISmdQYkwyTUdZOXhsaURWMDN3WmNORWZnVDlTU2k1RXNiMG1KcTdSS21T?=
 =?utf-8?B?MFNqRUFxWlkxNENsK0hHMTVaU1dVckJpZG9TOGFySHQ0UVRUOVNLUmR0RE51?=
 =?utf-8?B?Mit0Yzc4eVYxeEUxWmQyRnZoR2FKV21rQ0tVUTJCN1BBZ3hZdmEvU0VKaXYv?=
 =?utf-8?Q?KDDK2HljJgc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3J6OVI0UHg4K1NnMlhiRTk0TWdURlN0T1owaUxXZG5yT1RqL2o2OXRCV0c3?=
 =?utf-8?B?QXVadWJ0UGxabFd0MVA3bFgxLzhlYjhkekpDSXYyRE5odEpaTDFwZjNCWWt3?=
 =?utf-8?B?S3pneWQ2OGk0cXdQTUtwdmNPVlJyWGlldVVtVG5wMjlzTmwyQTBPc0pML0dt?=
 =?utf-8?B?Q01QZ0FvUmlSZFY0N2p2UWJiUHV6STYvNTZEL2hia2FENDZpQUVNQjRWWjAv?=
 =?utf-8?B?ZUtXUmFkdHpIWEtFUXcxMUNYN1VJaklibi81YzNLUkRXYU9qRDA3aU54Tmpn?=
 =?utf-8?B?Nkh5TUZFZkZMV290ai9tVWRaRVJrL1NDN0M3U2NIUVVicndJMldlUjZsR0s5?=
 =?utf-8?B?Vk1obmtnSTlTdk80RG1memtqNGtOY2JySXlodmtMTjRqRVpRa3FOSzN5ZExR?=
 =?utf-8?B?aldIS3MvcVdNdjdISnhPc1hja1h2TGd4V1NSMW9xd0pVYTQ2VmRqbS9Fb2hR?=
 =?utf-8?B?NUZXa3FvZW52VmZodDhYRkxjMXFOU2xTWFY5bWFIdG9MeFc4VHRoWXFKYjRn?=
 =?utf-8?B?ejg1a040V2NIQzFVSU1QLzJTWDZBZzVBdEl0cXY4WVBkQVlVaVFFaTRjL2FT?=
 =?utf-8?B?aE0vQkE4ZVYxSTBoMXlNaGhqcUFhZDkwN1loenJJT2kwMHlYY3E5ZDlDRWh5?=
 =?utf-8?B?eVZCMnJocW5JOWJBMXIyb1NnSGJ6TGZZZ1crR3lrNjNzZ2ZaVy9pdXM3Yk9j?=
 =?utf-8?B?ZHk5UjVzcjZjWDQzQWtzdHl3WEsyVHRjK1FLVVZ0cGxCcWpVM3k4ZnRCUDdI?=
 =?utf-8?B?U0QyZHFGSXVPVzBtZHl6akpBanI3M2xqWm8xR3pjeWdhSDhpVm5DOVFHRWlO?=
 =?utf-8?B?RTlzM3oyNFhhT2wxYk9jWVdMVVFncW5GOGkvZUZLMHJack9NV281am9XMzdp?=
 =?utf-8?B?VFdrQTdjL0ZFSlR4UzM2anNqNXRiU1A3VEJGTHN5NGpYY0o0eHdDTkVLalRV?=
 =?utf-8?B?aEZQTHJ1d2ZTeHlxL0Q3MGNmdTd6RjRiazc0TGdVZjJuZTh4YmI5aGFBeEJC?=
 =?utf-8?B?KzArRkVVQ0ZVSFdXNDh3ek1TRmRjUXRzelA0VUVQS1pEOVFvb2x6VExlZ20w?=
 =?utf-8?B?SkRtQ2t5L1pjbHBQUDQ2M2FOcGxJdmw2T3l2VWMxMGt5dVJSZXkzYjFqSEsz?=
 =?utf-8?B?bC9rYkpDUi9Yek1ad0NGemJLeTB3UEUydWlSdVJWekM0bmxORVY2VTlHOTd2?=
 =?utf-8?B?cXltMU40TkVjSWlUdHluTkVxY2EyLzlMc1lrUzR0WHh3bjlEdzlhSWpMMkFt?=
 =?utf-8?B?ajBFYjIwWmVuSVd4cTNVZU42bFYvRGlDZDhtOHFyVnJZQnJEU0lPeVQ0R0dC?=
 =?utf-8?B?QTVDdGpxWFVMcmNuMGlua25MdEFWQU94SVR6bkkwblFDS2hFM1VtcVpVVXo4?=
 =?utf-8?B?Um51ZzQ3emY3ZWlQM3VDSklBWi84NFg1MlVhdi9JV1QvMjZwMXV6Z2tySmVo?=
 =?utf-8?B?bloxVHV6MGFYQm12MzlORyt1eDdsL1NSb3lCcmZ3N01WcStJUU0zRlFJeHdV?=
 =?utf-8?B?TURzdDBhM2FqYkxpT0hrTWozaXZSTnBBQ2s1OTZnTWVVVUY2RDFBc0VacG40?=
 =?utf-8?B?SlJBT2pLdW9ibEVseENQbHRtVXBmTmtSQjBDR2podnFtemkzT0N4dmlUTW9F?=
 =?utf-8?B?Rll6aWtjTkYza2Rtd1lkUWthVkJkckJaSjhXazFTYlZqb2MxMzhjSlRsb28r?=
 =?utf-8?B?UXBFMVh2dm9TNjZnb2dZTU5EckFtNlFYTkM4UFI4TWVUY2wxelVYNERRMDRo?=
 =?utf-8?B?TlRhWXQwb1puZGxYdnR0WUdHTHZyUWJTZWpFa0xFSlJhNTRFSmY5TlpQZ1Y2?=
 =?utf-8?B?SWUyaEpJNHoxTWlZb1hud0VSY0ZuRTFkTVhYdDRPMVE4bWVKdHY1TmNrR2tX?=
 =?utf-8?B?N3VmeVVTRmRZVnVuSm1VYngxSDRDbEo0aWxWYitKUkQ0bVMrSVlHRkpBS3F4?=
 =?utf-8?B?MXJoVmxkcmpYMURNRm14Wm8yQ3BFejQzWGE3dE45eVQ4aUlDTWVKbkpxNi94?=
 =?utf-8?B?WXJrOW1YRmRYOW51WStvYlltVDhQUGlsV2NqWjhVWmJLU3hFTVpRODgrR1RH?=
 =?utf-8?B?Z1dlTVhKYm5RMUxVeGlQSjJ6S2FRQy9uV0NNUmZITkVmcFNqSEY0c3huOHF5?=
 =?utf-8?Q?rSYGosNg8o9juNEFHLrlUeXHS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3cdc1f-2b5c-4b1b-1566-08dde07244ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:19:14.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvUxVhcJHOoMdQoFMjwFNOam9bE5Wn6sWMRKLHDz46NLQXHwqkSCeSbycN0q/L2RaejLnS7qv6zdgKmOq/3zLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com

On 8/20/2025 6:50 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Instead of adding ad-hoc debugging glue to the microcode loader each
> time I need it, add debugging functionality which is not built by
> default and when built-in, off by default so that it can only be enabled
> explicitly on the command line.
> 

I didn't realize this last time. It's supposed to be compile-time
disabled and runtime disabled by default (which makes sense).


> +static u32 get_patch_level(void)
> +{
> +	u32 rev, dummy __always_unused;
> +
> +	if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {

Does this need to be (IS_ENABLED(CONFIG_MICROCODE_DBG) && dbg)?

The base_rev description says:
base_rev=X - with <X> with format: <u32>
		Set the base microcode revision of each thread when in
		debug mode.

IIUC, the base_rev handling is also supposed to be runtime disabled by
default, right?

You can probably directly check for "if (dbg)" but that would remove the
compile time code optimization.


> +		int cpu = smp_processor_id();
> +
> +		if (!microcode_rev[cpu]) {
> +			if (!base_rev)
> +				base_rev = cpuid_to_ucode_rev(bsp_cpuid_1_eax);
> +
> +			microcode_rev[cpu] = base_rev;
> +
> +			ucode_dbg("CPU%d, base_rev: 0x%x\n", cpu, base_rev);
> +		}
> +
> +		return microcode_rev[cpu];
> +	}
> +
> +	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
> +
> +	return rev;
> +}
> +

...

> @@ -619,8 +657,14 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
>  			invlpg(p_addr_end);
>  	}
>  
> +	if (IS_ENABLED(CONFIG_MICROCODE_DBG))
> +		microcode_rev[smp_processor_id()] = mc->hdr.patch_id;
> +

Ditto.

>  	/* verify patch application was successful */
>  	*cur_rev = get_patch_level();

...

The rest of the changes look fine to me.


