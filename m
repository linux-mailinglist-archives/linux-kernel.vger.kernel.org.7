Return-Path: <linux-kernel+bounces-792561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98052B3C596
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F991C80892
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42930311975;
	Fri, 29 Aug 2025 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJ2y+9Oz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B120B22
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756509926; cv=fail; b=cpq1qBzpl1J6XvogLsbufeexAQ1IKnOKd2ebRv2WDgjs6SfmXQ05yImYMPVquCKZbxFZuMdZzRCtr7ZzMSS1UUqxV+N3PsUjFnhBHN53lz+x/4d8yhQYmXp3AtbocDpmRlnz87IhhtnJBVjhKSo/B0dXxNfz2nusGdjw+zQK4EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756509926; c=relaxed/simple;
	bh=vhENvpZ03ZdEakFHA4y+a7rQ7a+DaYWJ8oEm4Cti+Ws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NqcJwBVI56YVQMcIiyjKBT9xtc3XtsujswyEFPwC/TcnSzViU/r9GEFJCv39DixYE57JZjYryMvanbKwsF+aTCrElFiQ1L93h9zW8CEuJ7Mh8XwhID8dKUB477u22D2/uwd4l0+aODJCPpy8d8gd34h+xkkMJgstMOI9ZyFijj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJ2y+9Oz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756509925; x=1788045925;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vhENvpZ03ZdEakFHA4y+a7rQ7a+DaYWJ8oEm4Cti+Ws=;
  b=UJ2y+9OzwdPiJmmtMCAlyIk2Wv0e9NwK/tQoX6blGMabctvXeQMlhO9Y
   VBKB9FQYBaSaQ5Ekfg1nMpqbsJ7U3P5jO6/R5gjTMcHO5CB11xiYS59Jc
   hfR0HJhqek0g5ex5DLCX8cTptm6p3i9TUkGGbxceo/axk21sd6bi86p2A
   MDtS5O+IGG52ok/YjB6BcqxU3V5PxvSUNdtmxlNW/YhGbdBEGe/hoVfIE
   B2Q3uZ7dpeWu4zgPlAlyXKtMcK9xndiAL/qVOwWGjyY8kXjZ9Gwd09tov
   e1RAqq5cntW2DdprRTnW3CbdknPEt3RHR6+U+WHaeZUOELjbzyJAiFgCI
   g==;
X-CSE-ConnectionGUID: LEA2nwnySX279RchnFxd1g==
X-CSE-MsgGUID: aCwxz0xFSyKmG9y7V5Qt0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58657048"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58657048"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 16:25:24 -0700
X-CSE-ConnectionGUID: AdmbcagIT8uuBrsy5rK9gg==
X-CSE-MsgGUID: xufxDst3QZuLQZPfAh+FUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170062881"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 16:25:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 16:25:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 16:25:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.61)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 16:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+gfTDWOklwpEUFjJx72nPIcSE9C1OP0w2b914lYvd5CqF3UwEJ1Nq199HOKECvqInm2Z3ICVSSnE6N4kpchqSMHwjEaqPoflTUcqa2f+NQRc/74EAH0Lw3GyEWUzPXkXQtDPuJNIns7FRzs3l54KT0iTBjeqOOzohCRRsixNnid6zNn/8lnBeNKCkZW6kT40Ha5gVFiw2+XPUCEwxj4aYS/vKsxen9WTVGOyC2sCn153jSD+8EKXRAvDK5h9RzYZIg2QjBIIJ2szp1eJfuHBuSQbAv3fKj+aZZNaVQSg+liWrwp/B1uam7mT/6Kwahs7l8YS1OL/JU7RUvaXZND1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDS/jV5t0sFtKrdKt3mGArTUyw13Y1MUOLAeFMJPvL4=;
 b=yj0ey0LoSUplrOdb3gZxxoSamUEIsWuBHHW7dnjxXoLDWVaVq3ehCqHkDt8DpvAWRjJ0Clrmc3nJzySedLGtxODitS0QoLiRwODN1Q4In5YVqq3KxkwiB76Bph2ctTWvTQCs4HD3UAeSKUQeidQbzgEqrw6W8V/Wb/PZ12lYdgWc55+LP+lLgiuu/YRSyomVBJhZ44enqi3NYXx0kShpzxe/Ba2S17eH62GknF/VRUFHAjoA2Ndrjz6XgoQWbQRh3bKaD/x0zdmq3tz/5yNFXhbIwqKqCwxJodT2Xku1Ynj6Hwx7WMiVuI2iKlnx+S2yXVcOgfKW6gWy52S9ojwzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 23:25:15 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%4]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 23:25:15 +0000
Message-ID: <f0565436-fef6-4999-b878-f4d2d52c22f2@intel.com>
Date: Fri, 29 Aug 2025 16:25:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v1 2/2] x86/microcode: Add microcode loader debugging
 functionality
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, "Chang S. Bae"
	<chang.seok.bae@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20250820135043.19048-1-bp@kernel.org>
 <20250820135043.19048-3-bp@kernel.org>
 <2cd370e9-6fd8-4aed-8fe8-c8526a1ab97f@intel.com>
 <20250829094502.GAaLF2nkL2EtFlDGOB@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250829094502.GAaLF2nkL2EtFlDGOB@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|MN6PR11MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: c3df2ab5-e968-4991-526c-08dde7534f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blhLRzNaUExFa1dyeDN5VS8yYWhYNHRWcjE2NXAwM3JDd0QwYlZCWnY0OG9H?=
 =?utf-8?B?U2hkMldjWFRveWI4UFA3Z25uSFNOb20xcFJGQjcrQTI3ck44N29IRFBpcjBP?=
 =?utf-8?B?U3RsMnV2dTRGdktDa0dXOHFxUDRzZU8xRFJJbUswcTJ2ekI2Z05qVVg1OWJG?=
 =?utf-8?B?QlBSTWQ5aERPOHhKelAwWDdsUk1mVDNpNERHdHJJL1BMcVRDRDZUM1pvdldT?=
 =?utf-8?B?YTQ4SzNWSzZSTkFzd1VzR3hwNXpXRWgrbUJ5SGlyNzhBUUVJWloyZWdnaERw?=
 =?utf-8?B?MCsyZEdKc3U0cWxYaWpYcXdvQ0JhaFh2cUJiSFdsVWJ0czZLWm1Dd0I2L2ov?=
 =?utf-8?B?Yk96YmhYbTN5SjhUS2pxbEVPbm50dWljYW80S3BCMklLWHQ1UzZPTWgwS2ZZ?=
 =?utf-8?B?VnkwcHhLWDdZSjVCVzk1QXRFOE8wbTEvdm0xNy8xUmNHallyVTdkTjd0eTU5?=
 =?utf-8?B?elJyelVwK3VxRmk1SG9RcElXL1B5MGtxdU1JaTRJYnFHK2hhT0hzNWJKVDB4?=
 =?utf-8?B?WWdHS2JtZllkaDlHRzFyODlyZHVBa2xxNkR1TVFpZDkrcTJ2b0JhNmtVRytl?=
 =?utf-8?B?V1M1WlJZUkY1ZHJod2dUaThCcHBJSk5wWkF1a3k0eEEySU5LVlZHbG9kUDh0?=
 =?utf-8?B?WG94ZzBGcXQ1VTFkYUJNQ3hhQ1RhMU9lMGRrZGhBaHdXZzhmLzNHZjJVam5t?=
 =?utf-8?B?YnYzSlgwbUxxQUUzMmxGaWNpd3c5SThFSkRVMDJRYndHUkFlVXNnRDJBdmJN?=
 =?utf-8?B?NkJPcEpyalRwTFJrMTlZTWdHTlNRWkxocURFdDdhcVFXMTYyNmk0MGc5OVcr?=
 =?utf-8?B?ZGRrbTVlRmdpMis3VFBSTkVSTTRoTmdRSEVacUVPUXd2dFJsSWY4Wi9WYkEy?=
 =?utf-8?B?RDd0eGxrZnlIaWlYYVF5THNlbUI0UGVhUTlwVCtKa3d0SGJDWlF0RlgvLy9w?=
 =?utf-8?B?bzU1a0UwYm50SDVsTitLLzAraGJmZC9NbEVsVVIyUytkb0RVWURkVXRWMEdL?=
 =?utf-8?B?K2FoTWdzYnM3bUFFZnN3Mk1yVTRRS0g2TWlXQklaQ1h4SVpkdFFZOFZZc3Ay?=
 =?utf-8?B?Q1UyZEhDVjBic2FlSERGZkl6ejFvYTdqWUFLUWlaRVpVbUlsTW83aWo4bTFU?=
 =?utf-8?B?ekkwZTBBcyt5QUI3TW1rNTE2c0J2Mm1EZU9ydmJlMGY5bG84UWxaYjI3Um5P?=
 =?utf-8?B?dnNlYzV4SzRzVjk3TUFoSEdUbTJLREtxUjA2OHU2Zm9XcmRTY0tTZzMvK0pZ?=
 =?utf-8?B?eGNvY2ZlYlprMjZnVXpycXpKaFprdUVkYXdFM0ZwQzllSndiOE9va01wWjUx?=
 =?utf-8?B?a1dqNms5VTVwNmNuMW1FRmFudDNCVE00NzlHSkl2bDZMdW95bDR1Qkl5VGtM?=
 =?utf-8?B?REc4U1lBL3JrRHJraDc5eDhuT1ZzcW9ieHU1MGtvT0NldWpNRVJ3MkYvWnky?=
 =?utf-8?B?aSs3ejk0VjNQZHExZC9ocUtjc2ZERFQxTTBpUFVIY1AvbXVYMXpjN1ZkOGo0?=
 =?utf-8?B?RGExWlcrTEJaYysxalBqRXU5ZnNUaU5JUTJYNGFORjNTeFY1V3BOMEh2TFJ6?=
 =?utf-8?B?M2dtd0xjVlZMT0o0TGo1TXYvYlJjSWxQSGhkVHFaTDJxdVgzZi9UUjVtN1Q0?=
 =?utf-8?B?NEE5dDVOUU50eDFMcllTVWJlcjNJN1BTTnZFRTlUcDhFcW5wOGZyQlJ0bUpD?=
 =?utf-8?B?QzRDNEZVUjlpS0cydXlpK25DVXlvbmNaOWdpSC9vQmx1K3Y3NGo0dGJzS2lo?=
 =?utf-8?B?VS9NQVpMY0xjYTlGMUU1T2F3MTViVUZCU2dOOW5oYkxNVzFJalFOT3NJbHN5?=
 =?utf-8?B?KzdybS80eHplNW9JNldRVDhFRUl1R3ppUndscXNMWkJFd1JmYnRsblQ3OUln?=
 =?utf-8?B?Rm8ycmt5UUNqRk9LSHlOcTRWL0x6enRNRDFscVhDWjl3VkN2QkxOVGFxV0tn?=
 =?utf-8?Q?JGoxjDVWv8Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RElKdGFxMkpDYkU5dFE4cXA5aHZzeDRFOU4wS3hYWWYvYTU4WkFseG5CWThn?=
 =?utf-8?B?ZkFhUjVMbWp2aGJvUGF3RXhIR1dRaDJCMGN4NWV2ZS9vNVRnMVpFQzBGNUN4?=
 =?utf-8?B?K0JYS1E5bm5pU3pNbjZzekZXdk5vSDdReVA1VDl6d1phaWVmbkdHRmR0UEMr?=
 =?utf-8?B?a3VTN3YzSWpzeVlKWjhiRFlYRUdTak5FTWs0UHNwSWxyQ3NGKzA2S0pYOHlo?=
 =?utf-8?B?endud1Y4NkVmTjFlTzRSeTFLUHJGVklFVDRMM1hhZkNTNUh5ODB1K3pyVkt0?=
 =?utf-8?B?K3E0S1c1SHJSQi93NmJxckI3UWhrN3M3ZkRWa2x4ZHRPVFdNU01nbW93aWRL?=
 =?utf-8?B?VDl2VzJMeVcvY2Y5VUNVczlZckRneGtFTlhzZlBweHl4eXZDY2lvWG94VGZB?=
 =?utf-8?B?RitQcXY4a2ViMHE4TmpLQ0NoK1M1dytPQTdOL2ppeVdIR2pRRm1tOG5SVzNr?=
 =?utf-8?B?UW5NWFhiOUFISkxmSktSVGdORjdJbURrcmNzMXVjMkZnQmJCSC9CVTV0YllZ?=
 =?utf-8?B?ZGhRemw3N2g1anc1MEJzdlo0elA1SHA0dFlwZmIwUlpYenpHckZLYTlFN1R2?=
 =?utf-8?B?MU1mRjk2d1RHM2RjVXk5NjJSMy9MbEhhQTRmQWhPYllhUWtQdkV2VUxkYkd6?=
 =?utf-8?B?cGNLbWsyR3J6cStqUEJ5Ynd6RTc4N0RzN2Q1K3MvVnFRRURDY0V3SUZwdm01?=
 =?utf-8?B?V1p3T2pKeXREc3NiMm1NVm0yNUtrRGUwdDdGNHc5K094a3R2WmM5WEhuc1V0?=
 =?utf-8?B?WTRDbG50TG5KeG85a2JsWllvQ1BsWGFOSTJhR2doVU9oVnljSXVLVEZhcHAr?=
 =?utf-8?B?R0h6MWFNTVoxcVpIRzRyNXFCVEVXL2pwdTY5cmMyVFp1S2JiOG1xdXFOUHFJ?=
 =?utf-8?B?NlVZUHoyajRSVVBsclZoN3dNS2JhREJwc0gva2xRZE1SWFRaV083dkVPNURI?=
 =?utf-8?B?d1ZYQzFXWEdheHFtTzhobzVBZFRQWExPL3l5a0h0YVhqUjI0T2dQbEdUM0FW?=
 =?utf-8?B?QnlvMWFWQzlFRURhTkhmQmQ2b1lyL3laNWdBWGp4K2RkL0wwUUlWV1hoWmpD?=
 =?utf-8?B?S3lkTFErRVk1aEJlWkdPSWRjUXRjN0ZVQjdObU9COWtMOTBaV1VGWE5vd0Zr?=
 =?utf-8?B?clJTL1JzaHY5MHlNVGtWelBGalFkL1lIUzZJUDdCRU1VbGdlNHR6aTI4Tm0w?=
 =?utf-8?B?VytjQnJORGMyRjQxNEk3eWJPdENuU3dZUXZ5b2FkdmY0SE9CSWIzVE5sdGdk?=
 =?utf-8?B?R3cvZ2tCTkowaW05SUxEZ2w1SHkwditObkhXWUFIZTZqV3JUTnlLT2ZKVnRF?=
 =?utf-8?B?Wngxbks0VFhHa0Q1eDZ3NUpwTzhSTVJSRGZ0dXpOV1l4Vlh0TzF2WERMdWJn?=
 =?utf-8?B?bklqWmNsTThSUWFoVW9mWVhDdzlYLzc3N3RnSlN4dGVkUEl0QmV3K2NRMFh1?=
 =?utf-8?B?Q0RaejFob2xxdUZlZDBFQ25WNU1Hc2VudXEzQWo3Tk5NOURiRHQxZTF5bUZN?=
 =?utf-8?B?MjRMaFpDQWllUkFRR1NUd3lWakNYdjMwQTNqc2NPL0FRWWgzcHp0VS9sVVQ4?=
 =?utf-8?B?ZXVIRk1Xa1R0ZWdPSlZqZ05Yb2JtMHdMN1NVb3FJcFZXc2x1UzJQYlNVOU1r?=
 =?utf-8?B?QWlPMGZkKyt2dFhrZC9vaCs5ZUtmbDJMVmtWSmRkM2UvVEtZK1ZubmNPeWdp?=
 =?utf-8?B?dnVpdk5yMUZadHlDKzFTNGhwbUNJRkdzRjBvNVlDYmZuZERkaWxqdjNaU1FN?=
 =?utf-8?B?ZCtqM0d2V3luMXZzLy96U25OWXZZSGN0SzVCQnJSSTRUcU9RTk9GU2c0K3Vw?=
 =?utf-8?B?SnV5TlZXbTRFL2VPSEhUZ05xMHN6Z3VRNktBeFliL3lmdmRWTjQ0NjJGb0pX?=
 =?utf-8?B?cS9GOGhoV3lCNkQ1bEdQU3FZYTZqZFNlTThKYnI3ZWNOdTB4by80dDhFWFk5?=
 =?utf-8?B?RUtVaHAyODdVWUh4T1VXcWZDQ2lqRDlmd084T0JPNkhOckoxanhrb1BOaW5X?=
 =?utf-8?B?NEJCVHlzYU9VZWNXZys3eDlmSXZsamJRS0t0b1RlNHNyV1JEUkNFMHRkY2dp?=
 =?utf-8?B?NGNWTHRaVHpMbUFJcWhOZVQ3aExkaEd0eW1zVUxtVXBueXVmRTNDUkNSa0N4?=
 =?utf-8?Q?7KD5HHPZKzF8H7Pf4CQpFJM39?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3df2ab5-e968-4991-526c-08dde7534f29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 23:25:15.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkWPv6DvmlDRfG+A+Zd/aT1ZBggYD1XwVGXWJ9sSHRm+q1Z8gypja4NmJVe1FiH3lJ4lHX49e1oFny4Q68e+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com

On 8/29/2025 2:45 AM, Borislav Petkov wrote:
> On Wed, Aug 20, 2025 at 10:19:11PM -0700, Sohil Mehta wrote:
>> Does this need to be (IS_ENABLED(CONFIG_MICROCODE_DBG) && dbg)?
> 
> Both you and Nikolay have a point - we don't need both. So actually, dbg can
> go and can be added when really needed.
> 

My only concern is someone could easily enable it by mistake. It might
lead to unnecessary reports and debug. Maybe we print a scary dmesg log
whenever CONFIG_MICROCODE_DBG is enabled? That would be easy to spot in
reports, and hopefully it would deter folks from enabling it unnecessarily.

No strong preference.

> Right now, the debugging stuff is for in a guest only and will be build-time
> enabled.
> 
> If we decide we want to have runtime controllable and *baremetal* debugging,
> then we can extend that and add the cmdline switch.
> 


