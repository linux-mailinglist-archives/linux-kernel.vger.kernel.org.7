Return-Path: <linux-kernel+bounces-797540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFBBB411C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5BA1B26E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30891D95A3;
	Wed,  3 Sep 2025 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZhNNU+s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAEB1D416E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862284; cv=fail; b=Q8syHhh9tRCul3X8JUNPy+b5/8dnlYUKLMtZR+bsfr0d6+qqGvhU6uXM+zUFGc9emvg7LgASCrbYB60nR30J1MrpZAYckmiPZUARUkpPFC9gvvvY33arMTewhY1GeQkARGIU2bLB0mAR+lpDtP4ycpcuPuWKH0TXA5oCWozMveg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862284; c=relaxed/simple;
	bh=9HZJQbsw6F3QMMOJG/gm/qZU6LghtAmfe5N9zfBjVmg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=t2RF1259OiAF77H2T9ptjcwGF2agaxs6YpW+9B8FTIVhul41/93RyyWA+3T7dHu47MQH0FHVfBGTiH1j3JEsJ/RKhsOi9hhMZxddM7aufNawgCciJhiPbxgwBdIyHwB2AT5QaFJwEgGFIzkT7PV154934S28dN/mRr3bb8LzwHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZhNNU+s; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756862283; x=1788398283;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9HZJQbsw6F3QMMOJG/gm/qZU6LghtAmfe5N9zfBjVmg=;
  b=gZhNNU+sCNBfTwb2x3I0k6j2EGGqS+gU175UTthgfwjcqNOLo/EuqwEI
   JVE+kI0IpNmLTptNOAFV1o8MMuSg9Cr6FkXRqMB5PI9xeIKK9zFKvjJf3
   DaWuiFd/tU41fF9CyVDdN6n35t94JjBVwcFi1+H6eDK+yyiABaBxKCXRg
   uL1dDE4r6pKPgQodeZAfbr31gLDVRO4Hs9TDZGekjYVe8PyaCGtCgRnoz
   IjQlpZG0LErgKvNv0f4dGjPxlvAjCYBZBB2KizlhNXcON/HQlBYNQdGAQ
   WxPGt5JLNiCcGDtl7d5nCSVHA9Ct8llD1seyBJ7svJ6DPQplaOGtNb5n6
   g==;
X-CSE-ConnectionGUID: xYZWyVs0TUyUwRttl7VfEw==
X-CSE-MsgGUID: FSlGwzyLSfq4djVUe3PzGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58861331"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58861331"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 18:18:02 -0700
X-CSE-ConnectionGUID: JVMoOpcESv2RV53dblQf/w==
X-CSE-MsgGUID: IX1JUQDlTZuWyq8oPOu3hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170995681"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 18:18:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 18:18:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 18:18:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.57)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 18:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVcoWUcHYv4OWD2oBRu2VHh9dAZTJwIEsprF7ss8RjxlprTA5fGHa+2yMOotEIO9gpMUH0zY9P7xKfN3M28DrFiRa6gdA32jiynq7RCccjArqaUn48nOIz2MNDNL4HBglHZVppO/Ufbq93NhEmuRTgR9QxZB3Wrx+dynGGyUnc5nSvv/AhBqoQ4V3BRgAjkxOcRtZIziBkZGfQFcEgyOEh6a+QJRqyn0NkHDf7sGF8baAOGPUPr37zo9odV48SIuAzxC50JXAekemSTRqz2HX4pv+hLc0ONUEDtwH178PgCMFAAEofABnWUgrOnORWZ1sAzNJ7dSA2VvLUFbkRNQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVgZKiTD+/46OKGa4OTMM5g+bwd0aR1zRZOizQHbObA=;
 b=JMDy9PlDAFPMQ//O0G6s7fplW8IQwotuTOduTGD2pmeAlKTjlC+wwVNvt4TX/WtVgRagNnHlp+DNTW1Q6qy+5gVh6m3TXAhIe/VQa3SCyjEDO0EUeOqodMEMIDxpmZQlqHLYAlGsSm/zI71co/rBdZdPb1EBePzmrNpT/VTT7pWWmG0UgvAGBiTxbJFMSDJGa2tTqS6BRxbt77dIjAXhhk0tTYPRylJq9Jvdhd2DFK5PU5u9XUHs9rZtHtSuc/vbhCEEO8/xQUIySiQNLTm/di43TBnG1pDH9zfU7Jh452+xa/1MVfwln+WAEWCvHQL655FyupoCdI2GNsoQRuYSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 01:17:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 01:17:58 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 2 Sep 2025 18:17:56 -0700
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>
CC: <david@redhat.com>, <osalvador@suse.de>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, Alistair Popple <apopple@nvidia.com>
Message-ID: <68b7974488914_75e310062@dwillia2-mobl4.notmuch>
In-Reply-To: <20250902051421.162498-1-apopple@nvidia.com>
References: <20250902051421.162498-1-apopple@nvidia.com>
Subject: Re: [PATCH 1/2] mm/gup: Remove dead pgmap refcounting code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: fde8bf46-3cc0-4c4f-2e34-08ddea87b7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG55b2tYekdVUnV6YVZVbGhFZW1ZMDNKcWpWZFhLNjQ4a0IyK3g1TC94UUZQ?=
 =?utf-8?B?R2tUMnJpbjF1MUtSSkFvRnFnek42Y0hJSkJuY3ZSdUVxWmZYV2JDdG1ZZzhj?=
 =?utf-8?B?cUNEcEVIOWhKelhvSGpxS0lkYnNnZVpVQUVHQnRINDlOWlZZdWtPM21Bc3p6?=
 =?utf-8?B?RDd2QmRBWnZwL3IraU5uc0VLRklHdzJCRmZsckcwb0pLWFoxY3FHRHF0NG9I?=
 =?utf-8?B?NVpaQmNZTFlWemI1Qjl4amZ6Y3V3SC9CTnQxV3N4cW5PZjZGU3Jwc3laZ1Ur?=
 =?utf-8?B?TVNscFBRaXJ6dzdhcGp2TW1GZ1ZwbW01TU5ZeTBQY0RKQVhuMDhqMldrcEsy?=
 =?utf-8?B?aDFaVHQyekczb3pOcDIvdjc4TFBrWklhWFh6ZWpXckhmQ3ZnNXpkUXduVDlF?=
 =?utf-8?B?dTBpQUNYV3VHTmVxOGpDQ0tvcG1jbnRNMElLQitzRVM0eGZ4S1JXK0QwWExa?=
 =?utf-8?B?VDVWbGxOa1VjaVB3c3VNcWdWcitINk5CRUh3SDBrY3FvcUw2NzRXdGtkZFdR?=
 =?utf-8?B?R0JHa2Nvc0hBY2dCRlNuUW8vMnp5ZVU4T081alIvdFZlNlV3SU1zajVuY2VC?=
 =?utf-8?B?RllIbkFvSWJpY0xKaFgyOGhSOVJwNWlHaVNzTklyZjhrODI3TWdycjhqL1Y2?=
 =?utf-8?B?dGE3TEkzMTdUK2xqakNQRG1DVFlZRzh2a2ZReFhzM0pneE1CKzU2NDVwdmJs?=
 =?utf-8?B?UXpVMlNldG5mMU5sVmhMNDd5SHVDS1dIU1lKNnZXVjh0bmVHK295NFV1MWNE?=
 =?utf-8?B?d0RsVFhONDFGNDl0bEZJL2dyckJoTkFxdjFjTEdlSEZxc29zS3NQbVE4cEJQ?=
 =?utf-8?B?RGNwY2svd1VZYUJWZGN4MVBFSkxZb0NUaDVKUEJzcmIxU2hIbTZxMVdwRVBz?=
 =?utf-8?B?anYrS05lem1mM0pvZmFLa3BTajJ4Y0ZldnVodVJnbTBUMHMyQkdDR2FIZlV2?=
 =?utf-8?B?bm9ZMjRRUUVLK1BzcTM0bHE4V3NveWJkNlhsb1d1eHh5dnc0Ly9tQTREeFlH?=
 =?utf-8?B?MHI4S2tld2ptZG4yYVJwREZHaGU3TVcrNFNUR045ZzJVT1JHbWZyVVhnNi9k?=
 =?utf-8?B?bXZFdUtoOURuSkFqVzA3SUZPZlhnNHFyMVNucllQY1dHUU11c2F3VFhFMCtB?=
 =?utf-8?B?SkVEd3pxK0VoRUh2R2g2WFZsN0dzS1g2OTFPZ0hERXNzcklYSk5WQklmSTc3?=
 =?utf-8?B?YVZhQVBxNXpkVHUrSTE0ejBuQUJuMExWNDdJckdYTE9iMXdkdnpWS25yQUox?=
 =?utf-8?B?Vm5IakRnWlM5eWdnYXRwM3B1WlkwanFtNStjTE94d20zMHZoMU9CSE42eDlh?=
 =?utf-8?B?czNRdmloUVNLOHA3aW81ODg4QmJaTmpsNEJGUVl5WSt0SUNqaElxMkFmSDk3?=
 =?utf-8?B?U3dGM254bzExY1M1aXcreU5SS0M2cFpCREplTGpIUmduUk1TRUgwV3BFMVc1?=
 =?utf-8?B?UXFJVXpQTTMydHovZHhReUU3YXBJV2x0VUp2SXhOQVVVMndPRSswT0NGNTk5?=
 =?utf-8?B?RzZ1T1d4KzdCZU83RnJIQ3I4MUdBb1NKV2FEYUplUVdnQmE4aUtxZzBMakVI?=
 =?utf-8?B?S1c2OWpKdEM5UVpUQkJyNHFYWW91bGpkTjhNUE5xcHJUektoY3FXTWxXUjJH?=
 =?utf-8?B?R3Z1YlpaNmNIK3hoY1NnWVdBREU1Z0pkQnRJa01LQkNpNDVISkRQTUpGWVVZ?=
 =?utf-8?B?RC9xMkpBeW1mRElEb3RGQ20zTno2dGwySG1tZExJVDFtRXZsU3pMNG9yd1JF?=
 =?utf-8?B?Q2g2a3dMWW1iQkcxYWJWeDlmSkhucjlZeHdSK2dsdmk3NHl6Ly8vcnl4TDJk?=
 =?utf-8?B?aTdBR1Nwdyt5N3Q1TGtsN2JFK3gxWWZKL0JlRVMxNytqckgxaVV2SFQxSEM1?=
 =?utf-8?B?MUVhd3hidk5OSExTcDQ0SEM2YjZTY3FtUjIwSzZtdUhidVJYb21TUnpub3M5?=
 =?utf-8?Q?QUzfH0HE7M8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVHQ3IwL3NkbkkwdTFlNy9haHlMaENRNzBsNEJ6bCtxT01XZVlvY1lxNVJO?=
 =?utf-8?B?VzhTdG1NakNHM1ZyYWsyMUdlbWdha3hGQXRJYjA0V2RWdzRQa1NORnV2cDM4?=
 =?utf-8?B?N1FyMUp5cllQZDlHaVVEVkhOZnVMR05lbVRiRE5POThIczJxanBRT240dVJj?=
 =?utf-8?B?TTI4L3hWTVVaalBUcENsdWMvVGlFN3NhMHkvbWFlQ0NrRFg0OHF1eUNYNnpK?=
 =?utf-8?B?eGhLZ2x2SXRKNzZoSks1d1FNMjhXdVpxMWJSRTE4Q2FweExhUTZKUXd3WndS?=
 =?utf-8?B?dUdLSE1WUFpqSk5jSnhXNnZjQzV1UTNqQmg0ZExGbzJxZk9ueXFnQWRPTzJX?=
 =?utf-8?B?ZVZoOTU1WVMxZTA0cUxoN28vS1FrZU9laEU2Nlp2S1ZWSk1BK2VIZmVzRjJs?=
 =?utf-8?B?OXgvUkhpdExmbDNjWXdtQkJmcW1sR0luVE95TWw5R2dnWFpBby9EQkt0YW5Z?=
 =?utf-8?B?THBZY1o4TW55Y3NMN1YvRlkydE1pOTdodVFVTDFNRmNiNVJ3cGtWajNqK2cz?=
 =?utf-8?B?cHZQZzRzaHRzOTRJaGp0U2VNWUZwYkdEcFhoY3BwNUZuQytMcGFsTXNRZTJK?=
 =?utf-8?B?Y2JQOWlsRVZoc3BHRDY1VjVzR256YzQwRWJSdEVvUEFqdW5iZTVHZWp5ZGVZ?=
 =?utf-8?B?aUhwNnAzZDl0Z1djY3BiVFltbFdScUhpRXd3Y05IK1Y5YzhseWllRXlmQktX?=
 =?utf-8?B?VnFvcFlCVnZVaXE2S0tob3VVVlNGaVRGb2ltWFhVMUNLUVhKZC91UVRPQTAv?=
 =?utf-8?B?MkdOcERIVmJUdG1pcVBZV1JaUm9IQkZuSis1NGR5TWhhM3VQd2taVmwwbStm?=
 =?utf-8?B?cnZrMENmRzZkVTcvUlZ2a3BCSUFhNTJvSm9XMmRDVlZHMjZ6NXIxMmxyYVhh?=
 =?utf-8?B?dEJWbVA3VXFEOFdJdks3ZmhLNEFtbS91Q3JsZ2RvNHd2bTZQY2NqdXpOVit4?=
 =?utf-8?B?SS81cUJ1WWJ2MHRTM3AyaFBJZTRDSkFsbitKQTdXeVZlNCtJV29QUk9NYklQ?=
 =?utf-8?B?cGp3aElVdG1xbnRYaDFlWGRyU09xeVV4UFVZZkZSTnlROGJvSHBjTFM0bW5i?=
 =?utf-8?B?eDdLWTMreEN2SWpqS3U5bVBBOGNSV1V2ZXFJaGVaQ1BLRDRaYlJmWnF5NEtO?=
 =?utf-8?B?bkkvcnZGb2psTk0xTm43NG5McXFOWU5UZm56ZjUxdGhsOS9WWllNYytYU1NZ?=
 =?utf-8?B?d09mMGMySEVpdTBnYVVUSVFrbmFyUDliaXRwN2dGbFpXTXE2ZzQ2d0pndTF4?=
 =?utf-8?B?U1NjenRTbVU1RytITnVwNEgyZnIrUmRxd3A4V2FwT2FybnI0V2gyTEFKWnJJ?=
 =?utf-8?B?NmtXR1lVMVZhQmJyN1RUcTdlOFVnVkU2ejR5K1dtUHVyelg4VmVWUzFZS1Av?=
 =?utf-8?B?YlN4dTNYTHM0SHlaTEpaSlU2NmEyR05oT2hLNlF3SE1SWEFGOU1ZQjI0YzZa?=
 =?utf-8?B?c0pyUmJpZW1ISVd2dHdId1YrdFlNU2lEaURjQldBckZxQk9VUU5TT1c3MWdq?=
 =?utf-8?B?WmVaN2Y2L3JUbnI1OUpJbVJwTTNJNTVUOE40MnoxaTJzczlnWnRZbllORklU?=
 =?utf-8?B?WXJ4Ymt6VTVUN1g0QU9hSjd5RjZENmUxTW9xNnNDK0VmMnFtS2p4c2N0YXBz?=
 =?utf-8?B?bGRaT0t3VkR5WG9iMEFnZFloakpjcUFESFQrL1daK1JVMFcxK1lNdDlWMDdH?=
 =?utf-8?B?K2tuZWtLSlRjUEVvK2hLdTJPOG5HbjBaQXVDcUFrZVRUc2pOaUpaalhsWEpk?=
 =?utf-8?B?aGRMVWc0KzdIVWJmTVl4S2MwMnZFSi93akNvbk1IOXBLS1YveDZRK1JDcjc4?=
 =?utf-8?B?TzRMNHk5K1pabDUrcit4SVMyajcvdFROQkxJUHF1d05tOUhHSlJ2ZTFyTjlM?=
 =?utf-8?B?bW5HZUpRMlNhWWllbGZBVDcwTGZETnZGSllwVm5WWm1GMkpGVWtidDdHaW9Z?=
 =?utf-8?B?Q1BTR2piZ3hrUlptVWgzcHBiWm1kSnlrVm9oMWE2Qkc2Qy9iMGtLM245elZB?=
 =?utf-8?B?VmU1R2VrVm1IdUFvendZWHZaaTBDUGZsVWY2Qm10dkdzR1pUTWNBbUVjbEdX?=
 =?utf-8?B?ZzlPUUx1RkluY3lva1NKWGdIWHdWVldDTUJZc3BGNkx1akFjYXVHMEUzWkFM?=
 =?utf-8?B?U1F5U2lVQ1Jja3RqMG1LODh4SStGYXVCZ1Jld1BrZktQUUdCSktTcXMwa0FN?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fde8bf46-3cc0-4c4f-2e34-08ddea87b7cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 01:17:58.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSYSWHJHoCLUKBgNH02ljjEosVsDgLzT3C0YqHRiRHCF96dp6i9os7jlVp8pU8PRveLm2F5HOWJQsyQo3zLwSwqtIzO0EGlNeZPL5h6mtxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Prior to aed877c2b425 ("device/dax: properly refcount device dax pages
> when mapping") ZONE_DEVICE pages were not fully reference counted when
> mapped into user page tables. Instead GUP would take a reference on the
> associated pgmap to ensure the results of pfn_to_page() remained valid.
> 
> This is no longer required and most of the code was removed by
> fd2825b0760a ("mm/gup: remove pXX_devmap usage from get_user_pages()").
> Finish cleaning this up by removing the dead calls to put_dev_pagemap()
> and the temporary context struct.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Looks good, thanks for this work Alistair.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

