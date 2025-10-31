Return-Path: <linux-kernel+bounces-880667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A45C26475
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C91A34FCDB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3E130595A;
	Fri, 31 Oct 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGTANLBO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26728BA95;
	Fri, 31 Oct 2025 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930399; cv=fail; b=ZdKlSz1xdQrpaUTN0oYElwgiMJdcTFnA0vC0CILWO7z8+avKn0vJoEggZPN53lAOKj1G/jtJA7tzUQL4L6AQDVTzc2pefpVnWxf8JFVLjOAP7bv+02npf/VB2wrzM+zwbT6kHLrDwfPJpJZRDiuVQqO+3FiWdjXTS6+Yl3KfjFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930399; c=relaxed/simple;
	bh=U52toflg5i7WUZlqD6V7ZpmcpZnFWOAc0DqHK+rVGaw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uieuWRlqP/NU8pHyXECxQqXYNc+g3z/xPEolkimVEAmR4+1wKRWStY5ImfEa6zTNDuqOVRSPxKww9AOhI6BFkqTn0GAYlCkQX9qct+lW7h1kkr8ZIZOVr0RiAh+jCt6icQwqnnKTTKF2O4AcUJ5o4OV9POSB51pPyYdTNbIupK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGTANLBO; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761930398; x=1793466398;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U52toflg5i7WUZlqD6V7ZpmcpZnFWOAc0DqHK+rVGaw=;
  b=iGTANLBOVe3zoX13YEOCwVW6nSWSQc+yivjCoTEJ0RkZjNfYDzsVL2Sk
   iCzoaZTWWozd9K0HlPx3qgEg4MfJVwr2KR0y4G1uz5FUsXklyCtxp7wZD
   E9PS/9XIZArFpS0VJiuQVGWaj3gJZVbuQQ9M6pxZsbylr8BUeNGtAnz2r
   Hlti7n7YxoXCVOhleGAQmQCPQaK8c+G0EMCJOjGrRSGVh3MRkxZ4+s4ub
   1em/a6qhf3O4Pw5H7gMFXQKPxVXfF+6H8+KF3WmIEOpDW8py6Fd639DoG
   KfEtrSRrGOLHLYkW+eHzv7Ww9Nqw3rH98QfuImhOQu6IH9edxzbarV7DJ
   g==;
X-CSE-ConnectionGUID: o6lAp4mtSsKooqDa4ZY8MA==
X-CSE-MsgGUID: zoVmljWhSjq/GsTjJ95f7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="51667502"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="51667502"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 10:06:37 -0700
X-CSE-ConnectionGUID: AXUJvx+4Q4O5Ok3n3M0rmQ==
X-CSE-MsgGUID: bHFXoLd9Tgm3vToCGxIDVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186737209"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 10:06:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 10:06:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 10:06:37 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 10:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2AnvYfJ1fOVmMdK+sLpaiHUBOr2H2EchyG8upKXuuAnW0GlL6+6suyxzBisp+rWX7dyRmN5lD8eXzSK7zqmS6vNhNCF3zB03Cn2aUjIAKw9PL+ZZEs0GAhGera7UcwC+V7KxBoMMAAGGI1PpXGxhZIp7DqI5oLk3imYvTksOntxq0C/DPlxk4BVO2XcQ5P1yUzxrsdEUOG3dhkjAbovxMgjXgl/G+IU+GKgGAsRdMRqtzUA49aAp3ZUix7oOlNyjk2S3b6tQr+WWruWy9KmvIU2u9wgeWiyljjxJD7Zc1oLJOQpADh62GCpt2YxbzS5Xsrfs0likDDxdvXGFDVWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N30pkBQoJVHqiGWFi/ZnQcL8JG+p2For/iKCTZPl40k=;
 b=q6Qah4f1yvNTqXsxBhAhcx1BvORcRi84ctVR3Hz8ZlHvTgllWt1mC+s5ibOfKqerXXv4cpldp38KHM64Ww2F5Jwgg52ZoKeYo0tSRt890wICtNJulPIBI6J/p5k74+3+fyXVy7mbLqjZVDOuaYmRWK9ghqyxwT1DvorV5UEdPmacBZYGvtZzRrH2T1I8i7U7pC8NKTsyWGNns4wg7GTnPCqUIiE1DgmdBz9mdyLz/5h4duq6k385yhNwl4zpebe1pPrg/o6lSz/mteoZG+bXnhaeUJRigh3qlIlumrRly+qmrorgPQ2QrlgX0k5z1ikvcFY7ieR7Uw2t78X/nUxBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by SJ5PPF0F15BC42D.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 17:06:34 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 17:06:34 +0000
Message-ID: <2df37a13-450c-412d-a107-9e0183be0c7d@intel.com>
Date: Fri, 31 Oct 2025 18:06:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/28] drm/xe/pf: Enable SR-IOV VF migration
To: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, "Alex
 Williamson" <alex@shazbot.org>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Rodrigo Vivi" <rodrigo.vivi@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Shameer
 Kolothum <skolothumtho@nvidia.com>, <intel-xe@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
	<jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Lukasz
 Laguna" <lukasz.laguna@intel.com>, Christoph Hellwig <hch@infradead.org>
References: <20251030203135.337696-1-michal.winiarski@intel.com>
 <20251030203135.337696-25-michal.winiarski@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20251030203135.337696-25-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0470.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::11) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|SJ5PPF0F15BC42D:EE_
X-MS-Office365-Filtering-Correlation-Id: 54211052-0631-49fa-0fbd-08de189fd85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVZFSzd2bFRqelk1TE9ZQmpieXhjMzY3SDRKWXdxWHo5U2hnRURQQyt4ZW11?=
 =?utf-8?B?MEZLSnZoVE92UmduR1hZbGNYU0tzZFV6b3BNQUl3SmNqZE1nalJQaEgySjhF?=
 =?utf-8?B?bzZiYnRZRzIwWktzekZLTFlDdm0wZFloYjIwMjF0aS9obWplY1V2cGZ1eHBx?=
 =?utf-8?B?K0NkRWlIZ0Y3WEZ1Tk92TWRVL2Y2cDd0M01xL2VyZjlwZGJrMFpiSWxMZjho?=
 =?utf-8?B?RnE4bm1ISHFwRWZHYk9zYmtpUDhXSGQ0eGxlU1E5UUx0R0pPQ2xtejJpcXkv?=
 =?utf-8?B?WVZ0NHBxWGN3T0h6ekdEUTFPdGNkMWFqU1g0LzlQWWpZUmI5dmJJdndnM2Rt?=
 =?utf-8?B?U2lzNDdyV3NsMGJnYkFiTXdSRTUrSjhuekhEeW5OQnk3R0hGS3MrU2JQaDJ1?=
 =?utf-8?B?SkRJdDRpb0RxUkg4VkduTlVmNEwwdnJMNnBCOG1TbWV4SlpoendUUVp2eEVT?=
 =?utf-8?B?enI1UXQ2RmZFL09nWUNRc3lFUXdHVkREUk96UXRicm02c0JwenZ6N2FzZFRM?=
 =?utf-8?B?SzZZdXFPcm1YSGlyUTRQU0ZTanJPS3NhVGg1dGNaV21GZVRaSmlFb09YL2pV?=
 =?utf-8?B?ajA1dm1HY1ZhWDdHbmR3UGpLOGZJTkpOUThXc1J3NjhseVRLVUM0eGdrczkv?=
 =?utf-8?B?MWRnRHkxazhtcWpicE9WNEZQd0g5YjNad0pBY25mckh5SDhIc3RnVVJPMElV?=
 =?utf-8?B?d1ZEaDI1U0xDcEs5dVZHaWg4NTJxaVpSQzIrWThLaERoRUxQbEIrYmdiQW0y?=
 =?utf-8?B?OElXby9VaHRKSy83RHp4b29sUG1FSWhUSjA4d1RQSTFmclhDUCs1N290SW9z?=
 =?utf-8?B?L0hkblc1STBHZkN3NHkwZU8wVExqZDlGbTZNZER6VFdpT3JjUzEvUXczcVh0?=
 =?utf-8?B?YVFKeStycHFzcW9CNng4clpHcmNuUWRLKysrV2lTWklrT2JVMnltSUpHRzNj?=
 =?utf-8?B?dUUzNEVvaDZYQWhEc0s1TUFVUzdXT21DQ2N2QVF6QjdmdEZ3SjVuV3FhK05X?=
 =?utf-8?B?YWRSRlBmLyt4VXJJeEl2bVZpbTc0WWJUNmpRcW9wdjBucVczdGRnN0hyTzdB?=
 =?utf-8?B?NnFLRFlISTBhZjFsczRpVzhPQmptdkJ0WmFHVUNhSUp2T3FXU28xdXVOdis1?=
 =?utf-8?B?NlE5YUttVjVrSHNscEtEZnBIRStWZkN0NzkvSmE1VjRGZXgvNXlqWUlSNURB?=
 =?utf-8?B?Nm9MUXJJMnhOVk9YMXlEV29DWDR4K0lhTndlWXh5UUc1S0dmaXlHSGtkaGVy?=
 =?utf-8?B?REd1SXhBdkpTMUpFdXU0YloveFRrQlF3ZU5BWGFPelYwYVE2RzNUa1p0TzYz?=
 =?utf-8?B?bnFtNGZ3aWdERGRLSFZzejhyQ3pWWmRFZnBXNjQyaS84OXUyM1Rvb2VzMTJL?=
 =?utf-8?B?bUlYY2lZNUZWNlcwdlJVT2ZRZHMvNTl3NmRhclJLUktVU3I0OE1HYnFRZ20r?=
 =?utf-8?B?eGRIZmFoM3hiTzhOT2Jub0VKUTk3TjRnWURScEp6cDdXbTdxTjJyV1ZPbEtw?=
 =?utf-8?B?YjBORlk0L3JleHBtRm1LMDJCSVkvMlU2dTJLcTB5UWU0V3B2R2NsbkpkTGNK?=
 =?utf-8?B?M05iL0p3bTZGTkpoUEQ5dHV2U0tsZnF1ZjJYSWJ6Yk1yRGlKbElOTUJwSU8w?=
 =?utf-8?B?WCt0QnUxakpDazdpLzhXQUIrSUNxcG80ZGpiZWRUZk1HR1JtdFhXeUljSytM?=
 =?utf-8?B?NFA5aXY0Z0xsK2xXWWlOVkpQdXEwSGlFL0dYbmxQeFZjTkFCb1Nlanoyd2cx?=
 =?utf-8?B?T3dsVXVaWmJtaC85dW4yZDl6VHRlOWdGMWdaeVFHdzMzRnRhblZHamtzTGVo?=
 =?utf-8?B?c01ZcEszNE5sUEF3VWZHbCt2THBvWGlhSTBzZUZsWWExbW1XMzV3N1hTdkgx?=
 =?utf-8?B?NElsblgreHUyUi9QdzYyUlhycnFlcTlPZlAwWUxDa0NpcjBsTTNCekk4K1J4?=
 =?utf-8?B?L2tiTXZ1bWVVaTd3SFE0dDVuTzI1ZWROdWNlRzN5VHJBWGNvVVFuWjlKeVFN?=
 =?utf-8?Q?W3Nw+awq0V61TEhll2R7wfGXslTdYw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnhSdlFBUWpqa05aNlVva29FeVdnem1nVjgxUzJHUTlxN2tSbDk4bFkzTmc4?=
 =?utf-8?B?R2t6OWtpRXFoRDV4ZGtmY1hTT000Mlh2aVhEZkdyQkRaMXY4M0ZETnRubXFF?=
 =?utf-8?B?T3E1L2lhbytmRjg2VlQ2TDdSRkN4ZE1XWkhDZ0M4YzVRN2wzVmpKU3duTUYy?=
 =?utf-8?B?YnpOOFdNZEM2MWJxSlVaQjFUSEsvMVZqY0hXeXVJR1N1RXgxODRNN3phSEo1?=
 =?utf-8?B?em5XSTJjWENjZkRZaU5KZHE4L0xTbU5jbTBjbVpISTRQblg1b0duL29MY2Z1?=
 =?utf-8?B?Y1EwMHkzZGo3L0hkSmUzV01tcmZodm5VVW1VM3crYlpJOFF2K3kzc05BK1VG?=
 =?utf-8?B?SW5JRGVhbS90Z3V1QldnTUtycWoxSE1QZVN6bncxMnZEU2Nra1RBZStGbHFt?=
 =?utf-8?B?NXdoRENLUXRhU2hTeXFIdXlscmtUV1JPTytZWXltYUE0TTFXTi9ZRHIrbGdJ?=
 =?utf-8?B?MnpaQ29SeDJ3a3RiOEV3aGd0K1M3dmtlKzk1MlZLRnRtTy9qWitlQnZCQ0RD?=
 =?utf-8?B?QTVaUkN6RTMza0NaSDJOZGVleVphbUZkdGMycGczTXdxb3NQWHMwbmRWdWNx?=
 =?utf-8?B?Yi9PM1ZsTUlmL3pTdjM1ekdwYUJUdWJMZWFMU2VRa3lsVk90QThOZnQ1K2hl?=
 =?utf-8?B?amZWS0ZMQzN3elYzZGYwejZiSldqZGptWEJjMjJScWVObjB2eEN0YW81bllD?=
 =?utf-8?B?WlBSWStCb0E1UUN3WXoyTDBveHlnYTVuMWdUOWc2b1BiNUs5VmZ3VUR2cTJY?=
 =?utf-8?B?aWNiUGFwam4veFBLSlBXS1IzZ003azc0ZFNudm0ramJacWxvb05mNFExcTl0?=
 =?utf-8?B?eUhkZEp0SnFiZ0krdnI4MUV4REM4NUxxVjc0UFZjd0NyRE9rbUZhUitWbmlk?=
 =?utf-8?B?SFVjalpxelNCNW9kK3h2RE92M0x4ZjlQbkNmUFNjeEtRL0VCdkw3L3hXMjc2?=
 =?utf-8?B?aE1Ea1RuRjVKRTZxZVVCWTdNZHNWN0RkcnNvNWt5VFNVWG0wd3d5L1hENVRX?=
 =?utf-8?B?MWIrZysxOVhSRTZhd2toSG9mQnpMbnBFUktOZ3dWNVZLV1VZMUpkOFErL3E2?=
 =?utf-8?B?QVhBcGJhQmFWMHhuR3pRUGoxYXRXa1NKUGZGTUdFck5ZT0xxMFV5L21YWTNr?=
 =?utf-8?B?N0wxSmplWmZtWEhqOS9ISG9zRTVENFFtK0lMRkpRaXQ5WEFIdGR5OWxkN0xx?=
 =?utf-8?B?eEo3RTcrMGZqeGpjVTdQa2M1MldjSXBMdndqbGZEUWxHMDNhaksvWEhENzNV?=
 =?utf-8?B?d3d3bDJ1Tk1tcXRORWFnaVg5cE5DWDBCMU1LdndnYW8wWFB2K2xHL1RSUFg3?=
 =?utf-8?B?cUxrS3NoYVdxcEhlZFIxNnU3NjY1eHpIRytvRzU4dnNoWG1DckJxcnc4dHZ6?=
 =?utf-8?B?bWZyNm5tVHhScndZRzltSEQwd1JwMzMzMEN3aUQwcnpQeWFGTVlGek1ubzM5?=
 =?utf-8?B?Y1BJZlBoanFmWjU1Y1VDaUVkcVBScmc3YjdRV29kZURIYldHY3BtN1hFUlZo?=
 =?utf-8?B?SWRhb3R0TEo2OVJNajRJOFdkN2dNZ2pkdHFjSzZvN3FOaGxQVHF4bEx0NkJ5?=
 =?utf-8?B?Rmk5N05YUWtiWDQ1Mm1xV1NWcFlzVm8reDNZY0lLc3RhSDVQekh6Mm1uWE9m?=
 =?utf-8?B?WmNJYm5WdVdPckd6K2NJMUc5aWtEcWVMK3hoOTZPNkUwSFR3NnBtaHUyWGtS?=
 =?utf-8?B?SlplODdNS29yNEI2UTlMODZiVlo0TkVUMXZZL2pQditTTk5wVngvc2plVTMv?=
 =?utf-8?B?SG1GRGFucDhWdWt2bXpXblhRK2tJS3ZQM0c5SzAxUjlWODcxWDNlOU1NZE5j?=
 =?utf-8?B?TXFQQUZkWU5KUTV2QlR2OVhTS08vUW13YU5PSm5WditJRDM5Y3MzNVZGYzZo?=
 =?utf-8?B?cTlXaWhUaFE4bW1HNFNOandxN1RWVUlrUFFCSll4S3FBd3JnVW1kMWx5RDVO?=
 =?utf-8?B?ZXduYVNWY0Z5aG5KN0RVekFjTEdiR1lqZGhRbjJjVEx4NllBaGwyNWl0KzlH?=
 =?utf-8?B?Qkk1bVc1VDYvKzBjQmE1NXBoYzhObWwrUGM2dFVybjR4RElvMEI1bGUvTUxh?=
 =?utf-8?B?ZzFjWXFCdnc1dDhpNXFwZ1hWeTVucUJyYkc0akFWNUxLZG5jdFlOQ3A0L25i?=
 =?utf-8?B?ckF5WGlsSlkwR1Z1bkdtWXNDSnY3bjFjbGdBYS9vVTgyL09MK0tpSGsrdUt1?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54211052-0631-49fa-0fbd-08de189fd85c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 17:06:34.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bErIB52IC7No6y8q4sBxykB+qRvAgNU09EhAv5jh+oRbGaxKecdBafMaez/cr7W0qY+srijnW3rTqCHbn2oyPXiO++sItn90jc6N0+O73c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0F15BC42D
X-OriginatorOrg: intel.com



On 10/30/2025 9:31 PM, Michał Winiarski wrote:
> All of the necessary building blocks are now in place to support SR-IOV
> VF migration.
> Enable the feature without the need to pass feature enabling debug flags
> for those platforms and rely on .has_memirq presence instead (like with
> VF resource fixup).
> 
> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_sriov_pf_migration.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_sriov_pf_migration.c b/drivers/gpu/drm/xe/xe_sriov_pf_migration.c
> index 6992c227e5a44..c4e9b0ff5b3ae 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_pf_migration.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_pf_migration.c
> @@ -50,8 +50,10 @@ bool xe_sriov_pf_migration_supported(struct xe_device *xe)
>  
>  static bool pf_check_migration_support(struct xe_device *xe)
>  {
> -	/* XXX: for now this is for feature enabling only */
> -	return IS_ENABLED(CONFIG_DRM_XE_DEBUG);
> +	if (xe_device_has_memirq(xe))
> +		return true;
> +
> +	return false;

maybe simpler:

	/* all platforms with MEMIRQ should work */
	return xe_device_has_memirq(xe)

and shouldn't we also check somewhere that we have the right GuC FW?
here is likely too early, but maybe we need additional check in:

	xe_sriov_pf_init_late(xe) ?

>  }
>  
>  static void pf_migration_cleanup(void *arg)


