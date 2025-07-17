Return-Path: <linux-kernel+bounces-735891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68795B094E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7767587C67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F672135B8;
	Thu, 17 Jul 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVjHYAcM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2D2EAB90
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780114; cv=fail; b=V1Q7y4J+AUkb8gaLfL9byyYuAxvnJPGvxmlEmJmzR0lmiDdhW0Wa0oDoEfcnS8D5iTGwyJ5WgDww9y01QMFal0Gh0m3zvRVJ/KN+oDOO0+GZKImpRAu/Y6yW45agYaCZZtku1rPivh7+SM2e7Josl1y83B3PP4kBN2o9RXPWN5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780114; c=relaxed/simple;
	bh=306rkdamY0i1D+MAGOPYKrLRIEOUw7cZjtVT+7tU0M0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPVgMlU5wa9F1vdN0PE8gsjCYL7icSJmyexH3VWfjk36P+ZmP0JBR+IFNKalf86BB+CBDHp6gHAWDXa+1CZq72ilUcmKjiCeGyAzezxqFOWaXziS2A3uYStJP2PORmTm9f2ANHu9d/Yj/6j8abDwfwcahleA6s+BdZkZ726OKow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVjHYAcM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752780112; x=1784316112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=306rkdamY0i1D+MAGOPYKrLRIEOUw7cZjtVT+7tU0M0=;
  b=DVjHYAcM8kgDp/LtgARgUqulDqPSdISYFWpjWBIi0J5SYMVsepU7wMCg
   2QEiytKo5Pz/3U+4YKSsnrmTrjWvXb+n3tNBR3RFYnJDKdP8VDQR6TLSc
   kfNV3OD1eSnJEQOLuDtuPLDeT52olxl4AwiRFhZKsd6BV3YHjEiNVvpS2
   yIryRZIhgoxxUWOogXB0BBd/cMAB8jzwKc153mHNuYm08sfIChKInNzWQ
   4tBIBZ8MhmRX7Nj4tdX6qJAhL/bVtr2+8Y2YZtuvUkACYF7KkyW50oCyp
   wvEL4IMS4ag4oYY3n86eeOsH/aaCrkR8Mtdk1HjS1wJeSxlV6EAnrswER
   w==;
X-CSE-ConnectionGUID: DBoab7waQfiOSB94eer3PQ==
X-CSE-MsgGUID: pVStbGx3ReSiBXJtni+YOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65761178"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="65761178"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 12:21:51 -0700
X-CSE-ConnectionGUID: PV1sZVIIQh+vSB5agNFgOg==
X-CSE-MsgGUID: JZYOj7yHT+esGafyBUZLFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158569626"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 12:21:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 12:21:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 12:21:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 12:21:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAzvKUp1nRgoJmzcOb38Dy8S/aCeKxxVD9VZ1L0Ll4LpN+Oa4JsCXiHZnXtaizSlqcTHghkm3PM/CBLwljem8mtUKDSFhSjGwtfMcRDYDx0KkMk5iaZxsx50OphOrs7c2tfSqegmq5fzAcuUQnzyGwa7G1xgAc7sq7WZbuR4GRMJBGQ9014qBY9olF7WYYHrtVeqdg70XwTKTdmvlb2Rnw/m4Y40Zu42lgLTJj42TlZd/6mTCHr097IJ3EjrcBkVXTef8JuscXbbIb/ebwfy8k2To/j//dt186IOnIbqKL7jbRu6j8qc0BxXdl4z/WdHi1edACdERJ68LgBeSAlssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+Y/TaIKz81QCxXbQLpOLIDVOlEvujAmvJN9PdI7i8g=;
 b=qHVNf8Zni/Bw/0+qQIVcEU8tNwk7Vmb/Lhkd3awZhIytY7xjpICY4Z6Ys4QEuOQWo/v9V2AWoelhFxFboIJ0qRX/qhQJkL+N5unjR2KpMo6q65IwYNIWSW7AOINJUrkhZS/7p92F8rdVzFDumAtpM9dQVE234Q9UVbAaqCmu5KwQisfCO7rd58d8QV1OjqLgBGw/NSp9uxyND2bDRgJ6De9aRom2hRL2ZwOM8qt+rvpFGhSQ/hFW3Y2kHTUKHxDtZgG2zoKtZQBKRttiORr1Z3WKcOpeP0IQJ32mNUuasOtEzcqYL9Q1pDf9BKOz//Yqvp7WybST01K9IbOUArKJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 MW5PR11MB5905.namprd11.prod.outlook.com (2603:10b6:303:19f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Thu, 17 Jul 2025 19:21:48 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::fca4:6188:1cda:9c1e%7]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 19:21:47 +0000
Message-ID: <e15ff86a-d7b2-48e4-b535-2829a3c1f23d@intel.com>
Date: Thu, 17 Jul 2025 12:21:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Fix potential NULL dereference in
 avx512_status()
To: Fushuai Wang <wangfushuai@baidu.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <chang.seok.bae@intel.com>,
	<peterz@infradead.org>, <vigbalas@amd.com>, <aruna.ramakrishna@oracle.com>,
	<seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>
References: <20250717094308.94450-1-wangfushuai@baidu.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250717094308.94450-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|MW5PR11MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 1549c435-18b2-49e0-bdda-08ddc5672c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnFsbzVDekNTN1F4M0czbW40ODd2aU1GSlNOY3dnQmcxdGo3bmQ2Z1AyWE5K?=
 =?utf-8?B?YjZud1JMU0lmbUZ3ME1wd3k4dWM4OVJkY2NZQ25tbmRtejM2UHFIQlFwOSt6?=
 =?utf-8?B?VnMyRTdGT2RFcXkzbWFaTDVwc3hlZzFpcXRXa3ZhNUN3cVRYMWdrQWU1RWx0?=
 =?utf-8?B?SHdwY1ZhOTA4bklINThIcXJ1T09VYTQwdDBHcC9GQUcyam9Odkg4TW0xVWFE?=
 =?utf-8?B?NWZwb3ZMTUtrSUthTHlKdFkzd0p2ckFrMTRZOUFSTzVLNDdidjZqYlFBNzJL?=
 =?utf-8?B?Sk1SdGVHNnpEeURQNlJKTm5Ba2JIdm9jNTFMd25FUjlkTlY0WU54dFQvTzdz?=
 =?utf-8?B?eWsyYVlCbnUzWlZScWt4dEQ5TkgrN2habDl6U2Rub0ZISzdMY1dYTk9qM3Nx?=
 =?utf-8?B?S2hXUzhuRTh0clFocmJzSjZHS2lOWHRBdStpSWRoYThJT0FPekFqb082OXdP?=
 =?utf-8?B?Q25FSmZ4a3VHaS9PNzFZNU0yNnNBeTBUZVNPNWF2Z1VWRlUrVUNMNmxjazhB?=
 =?utf-8?B?MWR3V1grYkxXczBBcVlrQVU0cEx5aVk0cy9BeXlKMzZUWlJXYjV6d2tKMVZi?=
 =?utf-8?B?WmRxTjQ4bGd0WjBMVFhBR3FUOFV3eDFVVTRJVm0zbnlnYlNaNjQ4NzBtSlho?=
 =?utf-8?B?aDQwcVNKZnF6NUI4dy94bmVhUXBwOTVQUUVVRFVoWWJweVg4V0o5S201eFhr?=
 =?utf-8?B?UTVIbnNGL1VRS3lKenArWC9ENzMvaVQ3RVZwMkl0Wlp1MDdqemhzeUxSOHpX?=
 =?utf-8?B?TVNUcSt2OGQ2Q3pjMVpYSmY3aUszSlRrQlF0czVCcm41UUtPV2NFNlNtQXVL?=
 =?utf-8?B?NmsycWJabXhQM0xRLzRiZ0VaNDZoMFMvSUwvYWtVU0dxK21UcHcrQjJucFZu?=
 =?utf-8?B?azNYbFdGQXNidllqL1lNMXFVdEJhNVJsSVF1NStCdUtaTk5KOEFsVTV6VHBP?=
 =?utf-8?B?UW9YOTBPYTFvWjJnc20vSHRQNVRXMWs1VmU3NjFpUmtZNE1LZTFITEp6bnds?=
 =?utf-8?B?cU9Hem9FQ0daV25hd2lLVktuV2F1WEJvMXlwNlo0TE5uTmJOQ1VJWUFDOEFD?=
 =?utf-8?B?V3crL3Y4eTZPN294Qy9TNHM3Q3VXQmVuRjdDTHhCMEQ1K01wb0tTckpGbGR0?=
 =?utf-8?B?UjhoK1htL29BRlBvZ29lMnZjY0pmYlhONWhtRmV1WDFRUm4xcGp1OEd2eFpu?=
 =?utf-8?B?a0hYNUZUQ1czR0EwNW00czVaYzdRQURXbEtjUW9RdkxHSkZQWDNuQjExeEJE?=
 =?utf-8?B?OWxsNHVyaGt5RHh0MGFJVWNua3VSYWJYVWlvcXVSZVdrY1ZWdjNWaExQZWY0?=
 =?utf-8?B?eVR0UGtJL1VEUlBieUNZbkpubXU1Uy9rWWc1NHFTeU9CZTB3aVI0Vy9jN0Z0?=
 =?utf-8?B?SFBiOGpWb2JlTlJCdlpNcnlwcFBpczVPSWFSNm1hVnp3d3Y5bTFRUnBKQVdP?=
 =?utf-8?B?UTlKcHhCbEVHZndJajJnN3FMVXlWVTZ3UTdTR0hwZGpLM3lrS0tnbkhINGtv?=
 =?utf-8?B?ekdmR0NiOWdKVEhtRnFMVWc2K3BiSW5Mc0pua0xxWS9iaUx4dmJIVEpLWTU5?=
 =?utf-8?B?Wk5XVnFoTkEzREpneFpKNDl5TVJhM1I2MlBveFJOQWpKRGExQzM1a1luOVZ5?=
 =?utf-8?B?aHdwQXZKNWErNDRzVlFXRWNLSUFaMHBBUEZ4OXhxREhhMVBBZFI3MXdMOEsr?=
 =?utf-8?B?RjUzOFkzSm1Oc3llcC9lSnRpQ2JTZ1ZBR2hKWTdPNy9qT2E2b3NDcEdCRTRY?=
 =?utf-8?B?cGxhbkNBSEdVK2dQQlhlb2daR3VGbGFZaEc2eGEwQU9jbEc1bjFaekIyaS9S?=
 =?utf-8?B?K1gwTzd3dUsrZXU0bFo5L2tCQVE0UU5YWk9Jc3RhYXIrMDZLWXRjU0J2Z0F2?=
 =?utf-8?B?K3NwMFhIbzRvQW1tR3lQNGI0SVN5cnFEci8vcnc4S1JMMzNXaFJCMmQvalFn?=
 =?utf-8?B?cnlUSnY3eUpRak04RXZ6M2t1OWlMd1ZxNmMzUDFIS0FZZjVMZ2NWWG05WGxh?=
 =?utf-8?B?MHB1L20xaUV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHM1b0ZpWlNPaXo4dWJDZkdzMXN2Q2t0ZUxuTEpHU2xGc3lEOTF2c245eTNw?=
 =?utf-8?B?UlRPR09tRjBlZlJlTUFFK3J2UjFxdjR5M3grb3J5cVlZUy9MRXBnbDB4RDNS?=
 =?utf-8?B?SXlwUGtLcDVicnNCUFJzZUg5NzJ5b04zV3pXbmIzNkZRT1p3S3pTM3ZrUkl1?=
 =?utf-8?B?aUdtL1ZKMnRoU2wzc29rdHhiejV2MURWQ1VvYW1ZdTJUTnM1eTdlbW0zYlor?=
 =?utf-8?B?ZVRVeXBnK1ozdVJhU1drUW03RGcxNyswczIybHhPNllkOGc5R3ZOSW1QRm1V?=
 =?utf-8?B?NWhyenMwL3pDQmExSGNBRGZValVQRHp4Unk2T0l3N3BpcC9OTGdvZEdjUUo0?=
 =?utf-8?B?UFZxd1FlRm45eVFQSTQyclNrNG9tci9XclJiWFRmWnNqTXIwbUlOY0xBa2tN?=
 =?utf-8?B?VnM1c1Rpb1IwR0tJOFBic3ZpSUZrbVhlZ0Q4OG1yQ21XYm9PUlJMcGpmZ0Vw?=
 =?utf-8?B?RU43bXRxN1Z0cU1aRlNyS2Rndk52R2tRSGZRVlJCZ1dVclE1NkZXWVd1V1JG?=
 =?utf-8?B?UXc4NTdZK0dKOG9uTHVYcmNLSm5oQndHemJNbUY5eWVhcVJRT1IvUmZyTjJv?=
 =?utf-8?B?cVVGQUhSS2cxVnM4RXlRVEIzY3owSHRqVFhWYjZ3SDA4dWJuaUNibHlyT01N?=
 =?utf-8?B?YlN4THlpdXBIK2R4MWN4VVRlQkdxZVc3dmw0d1RRZmFiaTFmYzV4ZWlWb0dn?=
 =?utf-8?B?bSs2c1A5NWh6cENtb0hQZzRkd3lTVUwyOC9kUjYzSC9IYXhmVW5kNk13UHlS?=
 =?utf-8?B?RjgyeTFCRkN3VGxIeng5SXp3SkRHYnNENVdadUlCaVNjdWVJVkZOajhwRSt1?=
 =?utf-8?B?WGhIUTNnTm9zOWRqZ0NSWndnejJnVUtkdjBLQm9ydWM4Mit1bDJqQ254bTZP?=
 =?utf-8?B?bUttREtKMzZ5M3AyOE1qUVhMVk5wN1l4NE01V29FUzhUM3MxbmcrVUlSVXFD?=
 =?utf-8?B?R2NTOSt5c200NkcxUGFXTWUrWkVDbGJ5ajZjc0xBZDlKV3Z3Nmt2TkZXYUZm?=
 =?utf-8?B?WStFVzlHc3NnK25TanJ2OHppQ3J5TEoxY2dKc3ViTlA3RVNYVGhIbDZKUGo1?=
 =?utf-8?B?bGtlVzdPTnQzdElCN1l0MlBzY1ZIa2ttZ0tnclphVGFOQXFOZlB4M3VQQndr?=
 =?utf-8?B?YXRRV2VlM25zcldOaHNCUFVldGlJWkZjaXFvbjZDNjMxQm96SkM0Uk1QTjVo?=
 =?utf-8?B?SkxRN2lweG5lRmF5aWU5Mkx5bDJkd3huUjBxQytWTHQ4UXFVa281U0V3elFG?=
 =?utf-8?B?UjNqN3VlQ1RPUDd6ZVJlcXhFREVlTUd1YkFEOXpiRzhTUUpNU2cvZ0pNMU02?=
 =?utf-8?B?SDkyMEdwK1M3ME1UcmxsWnhyd3pldndDY1ovMWJ4QmthV2FxWWI4TjlEQ1do?=
 =?utf-8?B?MzZQOTBYRGEwN3J5RVdVeTNFN1hDcUdvazFOWlFBUlBYRFEycHJlUDM5Z2c1?=
 =?utf-8?B?RjRpeUFKSG1Td3h1VkhxdTdjSWE1Y09IaDUycjVKdndzZnNza1ZHQ0JkL1Qw?=
 =?utf-8?B?dWZFbCsrTXJBSEtnalkzQXk0eTIra2pndEF4bWZRUm9xc0VxeEYrRkRqcHdC?=
 =?utf-8?B?QmtUK1dqUzBjRVVhbDloYmhZQWRSMGdoWm1RNDNCMGFNVGc2ekt2R0twZTR6?=
 =?utf-8?B?Q2k2QVV1ZlFTMjYwV29IWEdEeStZa2E0SGdrSzB0QmlzazRHeVczb2I1L3FN?=
 =?utf-8?B?Y2ozSHVBU2hYS0lmdGJkSEduaTFoTm9yKzE0Y2VNZjdxZXZuTVJueEE2Vk54?=
 =?utf-8?B?UzY5QVkrdlgwVnVaWERVclpseEZNMUxkMFREN25hS2I1ZVB3d1JJby9kdTg3?=
 =?utf-8?B?c0RMb1U3VDBGOURWWjFSVW9YNzBTQTRpUGlXMmVBU0F1S29XRWtmM0pDRklI?=
 =?utf-8?B?Z3FwODF5T1V0ZUhkU2lEdmZpSmgyMHloWmdQYjF6WTBtOHZOYi9LNjhCTGw2?=
 =?utf-8?B?eHl1TkdVY1VDMG1vUXd4c3JwZmZWSUlldHVURXM2Tm1XdDNId3hkNFNyVDV2?=
 =?utf-8?B?Zlk1andUNm4raW1qOWlnUnNHaERTcjYzNXJEcnB3cFdPSDNlZWs2aHpkd1Zz?=
 =?utf-8?B?bXk0T2ZlYU9aOXB4TDBkOWZ5VFNEY1J2dXYyZUlVRGxhUWhyRkJwQ1U3VmV4?=
 =?utf-8?Q?XTxNnZvRnzhQ+r3jorqKwEz5N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1549c435-18b2-49e0-bdda-08ddc5672c86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:21:47.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2f09L/TfncL6a46c9IE1GmiJL6FFhy86g8+ZHLeBwH5pJW2Jf/g3lfHAKlqTDggIR69lDxEuy0vYVeP0iUnwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5905
X-OriginatorOrg: intel.com

On 7/17/2025 2:43 AM, Fushuai Wang wrote:
> When CONFIG_X86_DEBUG_FPU=y is set, x86_task_fpu() returns NULL for
> kernel threads. 

It seems a bit odd that CONFIG_X86_DEBUG_FPU changes the behavior of
x86_task_fpu().

We should probably change that behavior independent of the fix for this
issue. Maybe?

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ea138583dd92..04afc71a4993 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -58,8 +58,7 @@ DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 #ifdef CONFIG_X86_DEBUG_FPU
 struct fpu *x86_task_fpu(struct task_struct *task)
 {
-	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
-		return NULL;
+	WARN_ON_ONCE(task->flags & PF_KTHREAD)

 	return (void *)task + sizeof(*task);
 }

> The avx512_status() function would then dereference this
> NULL pointer via READ_ONCE(x86_task_fpu(task)->avx512_timestamp).
> when reading /proc/*/arch_status, causing a kernel NULL pointer dereference
> and system will crash.
> 

The kernel seems to assume that a Kthread would never call
x86_task_fpu(). That assumption is breaking in this scenario, which
causes the below issue.

Can you please share any other warnings that were triggered before this
Oops message? Also, I'll try to generate this locally. Any specific
configuration needed for reproducing this apart from CONFIG_X86_DEBUG_FPU?


> [ 8215.540977] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
> [ 8215.542290] CPU: 3 UID: 0 PID: 9285 Comm: cat Kdump: loaded Tainted: G        W           6.16.0-rc1 #4 PREEMPT(full)
> [ 8215.543000] Tainted: [W]=WARN
> [ 8215.544481] RIP: 0010:proc_pid_arch_status+0x30/0xe0
> [ 8215.545408] Code: 1f 44 00 00 55 48 89 fd 48 89 cf 53 48 83 ec 08 e8 e5 64 ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 08 48 8
> 9 f9 48 c1 e9 03 <80> 3c 11 00 75 7d 48 8b 58 08 48 c7 c2 ff ff ff ff 48 85 db 74 3d
> [ 8215.548456] RSP: 0018:ff11000194107b08 EFLAGS: 00010202
> [ 8215.549443] RAX: 0000000000000000 RBX: ff11000211a9c9a0 RCX: 0000000000000001
> [ 8215.550581] RDX: dffffc0000000000 RSI: ffffffff96d0d020 RDI: 0000000000000008
> [ 8215.551740] RBP: ff11000111792490 R08: 0000000000000001 R09: ffe21c002117d61d
> [ 8215.552917] R10: ff11000108beb0eb R11: 0000000000000000 R12: ff11000108a80b80
> [ 8215.554111] R13: ff11000108beb0e8 R14: ffffffff96d0d020 R15: 0000000000000001
> [ 8215.555323] FS:  00007f75c18ad740(0000) GS:ff11000e266d1000(0000) knlGS:0000000000000000
> [ 8215.556629] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8215.557880] CR2: 00005605184020f8 CR3: 0000000164499005 CR4: 0000000000771ef0
> [ 8215.559553] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 8215.560882] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 8215.562205] PKRU: 55555554
> [ 8215.563277] Call Trace:
> [ 8215.564338]  <TASK>
> [ 8215.565383]  proc_single_show+0x10c/0x1c0
> [ 8215.566568]  seq_read_iter+0x3e5/0x1050
> [ 8215.567787]  seq_read+0x24b/0x3b0
> [ 8215.569305]  ? __pfx_seq_read+0x10/0x10
> [ 8215.570509]  ? __pfx_handle_pte_fault+0x10/0x10
> [ 8215.571782]  ? __pfx_arch_get_unmapped_area_topdown+0x10/0x10
> [ 8215.573142]  ? __pfx_cp_new_stat+0x10/0x10
> [ 8215.574417]  vfs_read+0x186/0xad0
> [ 8215.575657]  ? __pfx_mas_prev+0x10/0x10
> [ 8215.576947]  ? __pfx_vfs_read+0x10/0x10
> [ 8215.578234]  ? count_memcg_events+0x1ce/0x410
> [ 8215.579523]  ? fdget_pos+0x1c9/0x4c0
> [ 8215.580737]  ksys_read+0xef/0x1c0
> [ 8215.581896]  ? __pfx_ksys_read+0x10/0x10
> [ 8215.583265]  ? do_user_addr_fault+0x4c6/0xb50
> [ 8215.584633]  do_syscall_64+0x73/0x330
> [ 8215.585773]  ? irqentry_exit_to_user_mode+0x32/0x210
> [ 8215.586967]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 8215.588137] RIP: 0033:0x7f75c17147e2
> [ 8215.589209] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 8a b4 0c 00 e8 a5 1d 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 8
> 5 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> [ 8215.592896] RSP: 002b:00007fffd6935ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [ 8215.594238] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f75c17147e2
> [ 8215.595551] RDX: 0000000000020000 RSI: 00005605183e2000 RDI: 0000000000000003
> [ 8215.596876] RBP: 00005605183e2000 R08: 0000000000000000 R09: 00005605183e10f0
> [ 8215.598187] R10: 00005605183fe000 R11: 0000000000000246 R12: 0000000000000000
> [ 8215.599494] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
> [ 8215.600807]  </TASK>
> 

For quoting backtraces in commit message, please see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages


> Fixes: 22aafe3bcb67 ("x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 9aa9ac8399ae..16f813a42f42 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1859,9 +1859,14 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
>   */
>  static void avx512_status(struct seq_file *m, struct task_struct *task)
>  {
> -	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
> +	unsigned long timestamp = 0;
>  	long delta;
>  
> +#ifdef CONFIG_X86_DEBUG_FPU
> +	if (!(task->flags & PF_KTHREAD))
> +#endif

The logical code flow should not change based on X86_DEBUG_FPU. The fix
for this issue likely needs to be somewhere else. Though, I am still
working on identifying the exact root cause.

> +		timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
> +
>  	if (!timestamp) {
>  		/*
>  		 * Report -1 if no AVX512 usage


