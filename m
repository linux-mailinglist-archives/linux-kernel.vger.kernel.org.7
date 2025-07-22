Return-Path: <linux-kernel+bounces-741375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A4B0E35C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F063AA129
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113227FB25;
	Tue, 22 Jul 2025 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/0iu1U8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67332267F58
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208366; cv=fail; b=CCZ6Q+4pVc6iWt5PqSgDBHqoBburGdx5FEl8I9yrPXA5+mu6RRz8zSNaDO0m6tZGbgbDik3DIwA/wbYioeyvPo9Fi2ZAixshPIlVZ2g/rh8+8nOiAAyTmrVnxZPKNZ7BLLsUvFQmFZylcJfpvgvVCPvC1aERDucLcuGHP6Wpqco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208366; c=relaxed/simple;
	bh=pEfocbGQh+DKf8lVi8WXLH5avIZR1M7X/ilMsesaEFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W7Wtny+y9tP3wvdTdCA5TKyfZdOdsMZFeWTqBf3JXoLrQoCq/JfNeBxmp5fxRDPUavFWSOAcCmuuNBSkWg/IgibdJLXPqkJjFIvFqyT2UFtW6T4PfVSa1F3elxERvSskjxkXjaw4Zs+e/GbEC96JZ2yUV65UbTmYgVRxJqMji/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/0iu1U8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753208364; x=1784744364;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=pEfocbGQh+DKf8lVi8WXLH5avIZR1M7X/ilMsesaEFU=;
  b=N/0iu1U8ZHUdqHDXjTVuX1vdPqdU1fOysYUhFw0u7jPAV0AYqb8kTA+C
   5FmoejcCotQ70YqL3wdg1gxWjV4FfBm96Kmkk6FVD54c8H3GX+raTqG+f
   iRFP2bGLKUOMT/a2XLQsSI8cDmS9eLLUHKMI1c3nQTHDHwkFBsQ+m1TYY
   syfo4iLnhIg8Fi2R0ch1M0qAaHzbzuB03jkJx4Z4pFA85u3tyZAj8q0OY
   c4NRBGrkls2cEz+lg3Cbr6AEeRyoGxvBHqF84iA+HQu3MR9aiUMHol3on
   fHwFK06N0iE+cTfVI5fv4FmSu5cbJ826qx5zPJY4VGTVFWKBRPPN6jgn3
   Q==;
X-CSE-ConnectionGUID: lR+0hulsShSNqfOf20uitg==
X-CSE-MsgGUID: a71E8hYyTQaOChUKkJ6TPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55179228"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55179228"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:19:24 -0700
X-CSE-ConnectionGUID: /DyFV7sfQGeJLel4MWnfIA==
X-CSE-MsgGUID: Do77ARVuQCGEdDgJiJZ+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158512466"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:19:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:19:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 11:19:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:19:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVEPNE4/OLRzAm5YSSY6DXlQUiDGYkRKaXanVp9o4+zHw15Xyz4+sdOFlZ/2/KM9yMasGTU3nQrapJ8AxeKTk4fp/kgYBywfrbkpevDmX9o6p2JleKSyvWFYFIDCAsld/PyVscWv9X9/u56qnqu3Z3tEfVjC4CU1lzSNAJrmx+FpPoktKTIv7XRLmjrczG1Oxaim5UJLcnpnRwyUXdpigYgYdV/qyiReN7KHVbfSOTeP2nUBp2TcosHzsrNEN66EAD+MxZE44hSImYhR1m62VlbPeAhvuNIA7uuUWm/xhc8x2V3DUa0j1A8jjomKWjRr05hmxmjPnY0fY6sCjjCd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB/H77TsmjcWk3hgODjBuR8T1jT5dhWMSL2CllSyPmo=;
 b=a6ufNA0wQoTOtfg0zDtp02Dm1Qq/h8tAPM/HxJI5jhq3q3unJJHnsqMpla3jRQ2CNlidL2ADjh0JgSnSKia0DYfNFKkh9e+8rZkRZQU8Oeotl4XIa/ctyj2M0wKGIi1GJcvhaBmJXiPAIDY5xJvtN1caHC3hXH2OUkgbzwO/Ja8sUCZaMZ3zkF8IktSyxgWb+NKXA0bYEUgLuDY7Uy1JLRLYsztoQfbBgoecxiODbCGjvyvjsVWqtUhCOv4O/YkO5Smxee/6BsrRWeu73kuCssgeo9jJQycj3cUPG8tFkcECnXQb8CVpCqaArzRLykF+P5/3uTP+VqaYNkMB8yaxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 18:19:16 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:19:16 +0000
Date: Tue, 22 Jul 2025 20:19:11 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Xin Li <xin@zytor.com>, Gleixner Thomas <tglx@linutronix.de>, Molnar Ingo
	<mingo@redhat.com>, Petkov Borislav <bp@alien8.de>, Hansen Dave
	<dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Clear LAM and FRED feature bits
Message-ID: <oniuohiub4q75xwflf2nsz32aackbt3yrdweg2y6wimbzz5nvv@yxf2xnl7cgcn>
References: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com>
 <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
 <A4EB1016-8CF7-4609-BBF1-9AEC83B52A4F@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A4EB1016-8CF7-4609-BBF1-9AEC83B52A4F@zytor.com>
X-ClientProxiedBy: DU7P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::15) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|DS0PR11MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: c2938469-696f-4bec-38da-08ddc94c4479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akdCWjBVL210S0JJUVFiVXJaaE8rdXpYQXNLdFZMUUdUZE96S1grMGg0MjVi?=
 =?utf-8?B?TWlHaVducERkUktVN1Z6WjhLdzVYNlZldU5vT3M2T1NhNENQeVBIMTBzUlQx?=
 =?utf-8?B?WkRmSThvblBwSnlkWVRVeTI5RVNOZXVEYmprRXp1NVlsTVJkeEJJdUlDR3JL?=
 =?utf-8?B?ZEZqdFNSK0lrOWhzUk5nUFlNT1F5WC96QWdkTGhLWWRHQUJXLzA5eGFlK29u?=
 =?utf-8?B?dXVBTW84bmZCdmhyNU9EY1FWNzdETzRPMGdnQjBWK0llUzdRVWZZcDVveE1U?=
 =?utf-8?B?TWVpZ1d6a1k2WStiREczNER0VjJUa3Rhd3orZVhRRGR3eGo2SXBwWG9rQ2I1?=
 =?utf-8?B?Q3plRWtaUmN4R01UZnVLZUUrd0oyamV6L1FVMUtxR1I0WUFsVkJPdDBXK1NS?=
 =?utf-8?B?aVdjRVZJSnZwSmxici9QKys2VDlnYnR5N2lkd0ZSWkJZY1VRS1pROCtEWm9r?=
 =?utf-8?B?Tkl1cmJaWVB0d1dKbVJlbCtKak5qSXBwMHJoc243NWVrRE40QmJHclRDc0Z0?=
 =?utf-8?B?Y0JUaXRmaWxhK2ljemU4MzhIUnlZN1NBTHo3TmFOUE9KSlA5WmJiVitlbEJi?=
 =?utf-8?B?Ym5lZVNkb2VtOVVIWmhIV2ZmVklnNVRqSVVKTk9nMVlUZFdpWFdIYnJhOHZP?=
 =?utf-8?B?UFpvU2xIdm1hdmc2dExwTUgzOGpvUFhwWUVpVERLSmh0c0dVZnlCYUw0NjhV?=
 =?utf-8?B?U3JlYlo2NTRsYnZDQ2NnajBrdEVac0N6MERaY2hFbW50WkNPT1h6Y2JCWUZG?=
 =?utf-8?B?SElZT0VJZDhDNlpkWlArbG8zUXNpbS9PbVk0MERDTEhiRVJSTUk1SEFUUGJx?=
 =?utf-8?B?ditaZjdoSkIrZW05Zzhwd2ZpUktURWMrMUtNU0dmcU1LczU1Z0NMZ01RRkov?=
 =?utf-8?B?dnNNSWF0LzYyanIydkxncVNJYlFHVWdtUVRFQmt1RWpLV3M0bldONEM4RW9K?=
 =?utf-8?B?RkZJSjhacDNvMW5RdGNaL2NOSktIcURNL25HUkpXcTZmdjJWYnVKckVyOFNL?=
 =?utf-8?B?engybUE2RkhqVmxvdnA2RkdwWkJleEp5OEowUXVzZXZBa0E0L3FUQm95ZG0r?=
 =?utf-8?B?YlRINmpMdmJOckVaaHk2NEJMRmVmckJ4YnorejJkOFdyeTlPUjRQWlozSTRY?=
 =?utf-8?B?Y2hLYU4xd1c1am9LMDBIMk96Sk5IdWVtMWc0cW44aFVkQWMxeWFqZFdvQUIx?=
 =?utf-8?B?YzIwSE1TN3kzVzcxS3ZJNzBNSC95c3c4bXlrK2VwVFoxYy8xUXEyMHZ2cDEw?=
 =?utf-8?B?NExKenJpYWNYcGwva0h0Nm5UV096Nm9wQ1hGWGx5RzIybFk3dllpRDlRMW15?=
 =?utf-8?B?WVd5dlZXSDQ3WUdScmhLSUFscE5hYlhoWEpZclZCcE93ajk1bElVaXZUTFZS?=
 =?utf-8?B?Z2JqODBKY2oyYkF4MEk1OWpNMFV0VmlwMjFnSWhiYjl6MU1OZkpKS0VGcS9t?=
 =?utf-8?B?YnpCUll5OVRvRWt0MGdtN2kwRFZEbHB3ZWlGb1Q4RC9VQ295Rm53bUg0eTZj?=
 =?utf-8?B?djQ2OXRoUm92ZjZXVDVNc2gySmNGRU9RYWhBQ3liRnU4VEtQVWlIZUNKNjZn?=
 =?utf-8?B?Ym5ya3dleWdYdG9iNTFDYzRqOFR1dWxmM1B0dWpUVEtxeUlNL2JRRVVCZ2VT?=
 =?utf-8?B?anNtdW1hQWFGMVRjTHQwREQ3T3VVZnVQRUlnZU5aMjNxclUrVVJGRFZPWFla?=
 =?utf-8?B?NzJPMzZQdFVINkU0QkV3enlCcExubDdwcjNLRmNCamYwMjJ1c1BFZWR2SnQr?=
 =?utf-8?B?R1JLZzZBVmpXd0w0RS9aZXFoZzBNQVRNVTVFV2R5SzlabkhFV3ZvZXMxRm5N?=
 =?utf-8?B?TDhHMFZ6QkVtNTNJUkZhMmJzeHQvQ3UzODJ6c0ROSElqQ3pFaVVuT1ZzeHdi?=
 =?utf-8?B?eU9IR3JuZVhicUF5VUtubmdkUFlWK3Y5K1NiUkxUWHB2QVRtWjYvaUFTY3pT?=
 =?utf-8?Q?9B//AtBF5s0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0Yrd1FKU1JMaTd2bVZFTWQvamF4TmNTbEp0ODkzRHlaNURIdjNhTWlma2dN?=
 =?utf-8?B?Z0FsVE5wN2hFaFZERVYvV3M1a0VxOStFZGtMR041NVdGaEtEZGxPT2t3R1Nh?=
 =?utf-8?B?VVlYVGRtOXY2YVhYUzVzVHpsdkVSZHdleFJNT0EzUFNCM0tuOGFySVVBQjQw?=
 =?utf-8?B?VE5qWWhDdEJGVVF5M0dUdFJtajI1ZjlOVkROTmhERkdyMVBmK2xVTUdMYXBq?=
 =?utf-8?B?N3E2TFVEUE9ySUg0a3lPSmErMnlhY0JPVnY5cjh5dE1MWFN6TWVybzd4eFFF?=
 =?utf-8?B?TkZFUlVWRkc2dFRqajNIeTlaTkR1bXFKR0ZKeUV0Z2gyWW5pT1BtVXJadjhL?=
 =?utf-8?B?K2k5S3c4QWNCVnFreThiZHl1ekpyLytXWGNsNjJERkZ4ejJVQjhoTUlIbG90?=
 =?utf-8?B?dW5jaTBoQmpPQTF6NWJ4WmZNTEhyTjRuS3FGWm8yY3k4R0FiN0tYVWRiVHR1?=
 =?utf-8?B?NnlVZmRxbGV0Um5TOS83QWo3NWMzcE1XR2s5Z2p1dXdQbUNWb3ZYWFBVdHQ4?=
 =?utf-8?B?T3J3UWsxRXN6UlNReWt1SkVvYnBZbVJSYzIvOTlJWWV5QXppdEFTR1RnSFF0?=
 =?utf-8?B?REYyMTZiSnQ5R0FvaEdaVm9oRVhvMkt6cmtvZGc4TGVBbFN1WkZNOENTMFdK?=
 =?utf-8?B?MGw3djJ4VXZBNjFpdkhWV01JUHZBR2lPU2JEZnBxK0ZvaGpNbDRUU0laeFRa?=
 =?utf-8?B?YXh1Q1FqVmdYamhmSjhwQmg5ay9TVGZrSTZrYUdtWVk3bXpFL3FHazlvOUZV?=
 =?utf-8?B?YkVzTHBYVXR0YUp3Q0k3aHdmQXNRNzN0ZWFkTktBZFkrOVBEakN6bVpWVVJq?=
 =?utf-8?B?WTFrRS83d24xaE5lUm9mSWhCbmlQNUY5RDBIdnNRVHpzeG90bzgrRzBaSXFI?=
 =?utf-8?B?YkNldXRMVUFBbUkweE5lV2VpNEVVdW5TeGRLQkQ3eTZhVGM2eWxBcnlVL3I3?=
 =?utf-8?B?eGh5aWJkMWY0clV4UUgxWUlSanY2bWs2c2VkOGd2c2ZUOXNPdDhCcFpZVS8z?=
 =?utf-8?B?cHF1VDQ2SVd6L29WVlZNZTRjTkNhRjQ3VUpMOGtTTnFWT1VqN0QvZjV6RFRt?=
 =?utf-8?B?bHQ5Z0ZlN2N2d2pLVXNXQW0rMkx4K3E4eEFrcCtkSDNWY2lWYzV4ZlRNL0Ra?=
 =?utf-8?B?ZER3VE5vU0tvM2dhS21VVHcxblF4d2FVdTFpS3hQanMydk9TM1kzZU50N1Nl?=
 =?utf-8?B?Y3dUK0JQdFJlWDl4M3l3N3R3TEFnNTRDWnBxbklvY3k0YUU1azhKSE5sZitH?=
 =?utf-8?B?K0o1WUhQb0pYbzBUeDlhN2t1VDgzMi9CVHhHUDFZelQrQzVzTXZZeTJFVW1r?=
 =?utf-8?B?cTRoU1FaVDBsTFJPNnZWbkk0QVUxNDViY00rNnM0U3VUeVVtWVBuV0pIN09k?=
 =?utf-8?B?UDd5MjhDd3RBd2dySG5DYVBvOUw1aTZOczd2R1lJcm5yUE5kbGx1Q25xWUZu?=
 =?utf-8?B?NXhSakQ4d2hPbWZrc1Y0aW1PT0wzazhFd1VOZG9nekNFdjdSRUs0d0J2RWwy?=
 =?utf-8?B?TU44eGNzVC9rNlVYVTRZSE8zSXVSb011Kzhub2NNdExoa0RRSWE1QXRYV2NK?=
 =?utf-8?B?dkJQUlpOWlVZcm5BcXAvOFYzSTF4MW9lTi9aeEhxQ2VFSk0xQXBoRTRFUWd2?=
 =?utf-8?B?MHQ0QzVmdmUrY2RKTVRlNGwwRUQxUHNKN2dySm1tQVN6Tll3UGNWaTdBaHZW?=
 =?utf-8?B?WUJrQ2t5WVdEeVpTR0hXdFJWTnlsUk9DRStUM1k3RUM1ZHN0RjJXYlJiWlFs?=
 =?utf-8?B?bWpzaEhNYnEycjBMeHZySldZbzUraHpWazAyeitxQ0IwL1NRSUIyamdOQkNq?=
 =?utf-8?B?RVlNUjk4dk56Tk4rR3F0YnQ0OWQvb2Zad244L2pXSFdpbWRyNjh6SzJyOFc0?=
 =?utf-8?B?dkk3dENFbjZ3NUNJcVdCWEFELzJSN3Q1bHpDU0dNRkVUMzVOVkFLWFNKb2pQ?=
 =?utf-8?B?Q0E5dmFoR2kyenNISjU4UVBqenFVRXkrZ2hMVERjL3Z3WjJ2V3hiZzU3NWZD?=
 =?utf-8?B?Yi9TY0JGTlBOUXUyVHUvbnl6UUIvYnhPeHZqbXpnaG05cFZ0eVcwajNLcEQ1?=
 =?utf-8?B?cEZaTUZXNWpDYmt2bzVxL1A2Yll3NjMvU2hzMlcvMEE5MW01bVRVbklNRUMv?=
 =?utf-8?B?MVRYeVRLT05DTmRMczh4NWJvS3plWjdEK2p5K0RCTm1UMml2Mzl0QTBHZ3Y3?=
 =?utf-8?Q?h6TIAnyrq1mVeld7Sy0uTwc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2938469-696f-4bec-38da-08ddc94c4479
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:19:16.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7oGefOw4H2TqZT26Wu0+J9cutssbUfLGZV7LE6EMmtk5oxSLKQoSGsQ6ta1RgoBls335RQ7AXj2MXjIfKRKrPA9M6GDhAEsFAAqGUZezVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719
X-OriginatorOrg: intel.com

On 2025-07-22 at 09:46:42 -0700, H. Peter Anvin wrote:
>On July 22, 2025 2:08:28 AM PDT, Xin Li <xin@zytor.com> wrote:
>>> On Jul 22, 2025, at 12:54 AM, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com> wrote:
>>> ---
>>> arch/x86/kernel/cpu/common.c | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>> 
>>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>>> index 77afca95cced..1c5af795cedc 100644
>>> --- a/arch/x86/kernel/cpu/common.c
>>> +++ b/arch/x86/kernel/cpu/common.c
>>> @@ -1782,6 +1782,16 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>>>    if (!pgtable_l5_enabled())
>>>        setup_clear_cpu_cap(X86_FEATURE_LA57);
>>> 
>>> +    /*
>>> +     * If a feature is disabled during compile time clear its feature
>>> +     * bit to prevent it from showing up in the x86_capability bitmask.
>>> +     */
>>> +    if (!cpu_feature_enabled(X86_FEATURE_LAM))
>>> +        setup_clear_cpu_cap(X86_FEATURE_LAM);
>>> +
>>> +    if (!cpu_feature_enabled(X86_FEATURE_FRED))
>>> +        setup_clear_cpu_cap(X86_FEATURE_FRED);
>>> +
>>
>>The following code will work as a generic fix:
>>
>>	c->x86_capability[i] &= ~DISABLED_MASK(i);
>>
>>And DISABLED_MASK(x) needs to be defined like DISABLED_MASK_BIT_SET(x).
>>
>>Thanks!
>>    Xin
>
>The easiest thing would be to initialize the setup disabled mask with the
>DISABLED bitmask instead of zero. This can be done statically; if it isn't
>already the awk script can produce the disabled bitmask in array form.

Oh, that does sound simple. I'll try that too, see what ends up with cleaner
code.

Thanks :)

-- 
Kind regards
Maciej Wieczór-Retman

