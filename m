Return-Path: <linux-kernel+bounces-741545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF7AB0E594
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64671C874BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5524285CB9;
	Tue, 22 Jul 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwTpxiYQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DB2F32
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220019; cv=fail; b=a4PqeOhsDict1zsWVjgX+3/QtQZx6PeLY8wOGONM+QXiK0EmI1i+2YjMd0NisTcMd/7fep1mO99F9rCTjYxCU94ljdffa07Ln9dWwyQbjC7VVt5VGLjMGlF8/CpVbKW9qOoF6SJRtIs6W5pLwcmxh4yZSowLOTJ2IbNPIV8yJ+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220019; c=relaxed/simple;
	bh=s36OVj/J8GrsjoaDhmg5l0PUPGApYC74BkI2t4UBZCQ=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X0KzoNAWNwTx9SuubQpNqmZ5Q39v5pYBuQkHQE+3b+LgtBRjh6Z0iXStqx0IJrFfFtY8WeFHoJX/zRSBJk16syXZr5m1Sr/ZzzuldTznImGW3gNF7q8y1Oyt+yzSvGWPBUjSVyaQ7wkglW+k2GhgiO4KlH+6kjDcoorrSHtCVIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwTpxiYQ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753220019; x=1784756019;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s36OVj/J8GrsjoaDhmg5l0PUPGApYC74BkI2t4UBZCQ=;
  b=gwTpxiYQ4+CuNhQTgW3PD7o1ZayRCN0qQbr9ro8o8I0Qrk8zm3WpP1CV
   eEnC2BhHjakG+rW4R8oy5DcL0da207rC+HSkWNj+17hUo0BtnqrdFRXVy
   TBRLhCDgXRp1vGJnD4rAEBqCtP5oR4a56uNCB4QFjVopTL17lBAxMeZLw
   zLfpJyFYaeNSJa+oLYgTNGMjmJb99zKCupuQtjpXrjMo+pbH6/hkbv703
   PF/ScC3nqseJuh8Qfjw/2KOCwRikaXSH4aANHlKu22RG55v9yIoudrTb6
   aDXM8kLcH/yOImFhal9v0NnnFsenIVw1/XkWd3URTAEq1q9DqtS9iXLJx
   g==;
X-CSE-ConnectionGUID: i7n1yvzGT/GrFlH3NZJ6eA==
X-CSE-MsgGUID: gkvk5YOiQmOmy9y49vhQAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55192061"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55192061"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:33:38 -0700
X-CSE-ConnectionGUID: nYw0o7CyR1i0l3POGekLIA==
X-CSE-MsgGUID: Fpe6BwiJS762MfOkbkMULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="164903269"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:33:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 14:33:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 14:33:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.63)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Jul 2025 14:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duqH1prodDnRuS+5loH/KTBOqs+lBgyDBosOzwipfwlE41gBgVttC9dJNzpPUjZ4Io+VtAyhGL7UB6IRxUhFTTAlcBQdKT8qTNSOzYVP8ZN3c3WgFVedThZixEWb11Nz+4g7xo81WqphFRhSGSF33xX7ZDcCjlAnvS4aliv1QoNUAoy+GHGO8tdH0THHtsWrJiw7K1pJ9pM3gsyFU8rlRks1TAKHpOrzG+aseYIQ7kt0G6Q6nLNK+bqBROJdcUQRxEwn/b3fc8wb0lw5xLTkotftHHKRvxfgLp20a+DTPMoaC3JS0Xz52OmZmzWLbf1RxN1G8FnOKo7r06gDoB2AEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQKNYupxB3iTwGeXb+Wk7dE/9HIolKCSy16o6QdZgUA=;
 b=K9VGjCwDuBZX+EQ4/B6SciUIXREuWa67P/Wl1ZD3uYHlCwXGLBIvrowIfzEx06WfsaMwFzWuGa2ovqnoiNQgVUF/Ws49hBxPDIOfh3iUFsUa2nBqi2f4ZEyGKM2LyKNunXSrogH757sU248iz5lW4krztrbIDYG6cT+MTTx2Gyw/o2suPCtFXEYuR933YcnXG0maBTZ7Ftoe+9cbWRg7cFHYfWFnJesnqPAjmJnm03+kZb65byASQ5rWqxjdtsoSXCai9DknMtHx5NowfV2iycOwUTCh5Uv55WCsaRnzWy+kQKSxDcHKXKqKquK/geoyBmQ+iAdGzqdF0b5X5YR1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 21:33:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 21:33:33 +0000
Message-ID: <d3c65087-c846-439c-8f46-ceb899809b70@intel.com>
Date: Tue, 22 Jul 2025 14:33:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: avoid divide by 0 num_rmid
From: Reinette Chatre <reinette.chatre@intel.com>
To: Barret Rhoden <brho@google.com>
CC: Tony Luck <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>, "James
 Morse" <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
References: <20250721180051.3645697-1-brho@google.com>
 <c4518fe2-dce3-46d1-8d79-cd63377bdcad@intel.com>
 <dcc38ba0-cbb4-494e-bc10-2df2b4aa2cb0@google.com>
 <2249977a-e291-494f-8c84-f16ec9fba10b@intel.com>
Content-Language: en-US
In-Reply-To: <2249977a-e291-494f-8c84-f16ec9fba10b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:303:8e::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f9b47f-ef48-4669-4017-08ddc967682e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFBtaWd2SHNSU1p5ekUzaDlGb2hTRmpWUUh6N1l4YXZqLzJvV0xqbDlNSXR5?=
 =?utf-8?B?YjhrZkxMYkJWQSt1N0txNzRJQlowRnZSM3lGZHU0TEZ4ZU1MMlY2VFFISFdo?=
 =?utf-8?B?eVpscmVhU0NFbDhXak1yMWRJUVBPOFd4dUczZjIxZGdYYk5lRkZQSlI1cFh1?=
 =?utf-8?B?VlVPMVUxV09mMkNNWVZNV0VBM0l3dVpXQWhuZEwrcXIvSElDeUdpMkw1R0FQ?=
 =?utf-8?B?eWt1cjJqekdVMHFONkh2SFAzK1o4TFBNTDB0OTl5enc4WTY1YVRKWGZZYVc1?=
 =?utf-8?B?M2tsT0h0cnlpS1I4UlBROUhPS1p1dGIwcHBkbE5kdG9mc2l3Q0VCaExFenVp?=
 =?utf-8?B?dWZRSEpoWHBwZE8xK2RaMmdlYUxaZkNiZkZHcW1zTERCZFJQR0FLemxSQnFw?=
 =?utf-8?B?OG00R0V6MjY2aDUwL1pyTXVJRC9Yd3U0c1BKc0YvUGVNNGNJV2JTenVoUzg0?=
 =?utf-8?B?T0IyOXduelYrMVJDc3k4QWRLd1BaVHBOclpRMTdOUDVtR3NOYnkrSVFLMndm?=
 =?utf-8?B?MmFUWHFXSjdSR0EyczROeXN5MzR1MURkNitMMHFxd2FOL3lwdVdBN0ZUeU12?=
 =?utf-8?B?NHpHMGc1emJCVmlKNzhSWS9zV1duS0xFOWtvTjRFemlhQTRKWjdTbFIrN2ZN?=
 =?utf-8?B?VHlnaDBuWXdPU3BDTzhXTlZxK2gyaVRTUlptZ1QyeEliN1B5b2NMMy9rS29v?=
 =?utf-8?B?M3l3K0kzc1BPeXIxRnNJN3hRMGsvbDNSZVBVME5JTk15SGdrSzlJb2I0S3Zi?=
 =?utf-8?B?OS93S0dkdEs3NjRGazhWZWtNcmp6aHp3eDhGS1lJa3hhTU5rL2hRYlZCdHI1?=
 =?utf-8?B?VUx3UC9FTjFveTcyUk55TDd3Mmk2LzRvdS9VMFBoQ1NyM3BzblQwNkxtb25r?=
 =?utf-8?B?TXdLTXkrTlNycjNIWXUvZThvcytyK2M5YTY2eDR1OHZUN3kwVlhZczJEU3Bj?=
 =?utf-8?B?cnRiUW1BYStCME9BWmN4UUx3Z2p4L2hVeWhOQ3pPbmVTRDFEanlVeTRqOUtj?=
 =?utf-8?B?RGR1Nmd5ZXJEeXRrNGhEQ1JuVU1SQkVnTHlDVDZ3NjQ5cnZJRTVRT1I5RWRW?=
 =?utf-8?B?RVpib1lncHAwZm1aMC8xTEdHUjlmWjhKd3Y3djlGNHRDMTlDZjY4akZQTDBx?=
 =?utf-8?B?bGg0RFlFT3pNUE56cmZLUHQ3eW5PU3BpY0RseE9YbFJYR2wvL1VzTXgrMCtw?=
 =?utf-8?B?RVY1dWlYRmVZcHBicXlmbi94cFRnVzZsZlBhUzNQVGk0K2RCZ2VjSWFrbHk1?=
 =?utf-8?B?SzNsZk5oVFVOdnhjcGI5M0ZTVEF2ZTFhbGx0bnRBbm5oWitTT1dIZWtxWmR5?=
 =?utf-8?B?MTZKZUNlSWxwdkNKQTlsOG4vcnIvQUZ0TVRXbG8rM0gwNE1iMFNFbkdFRkR3?=
 =?utf-8?B?NHJEUDRWcS8xeDRZU2pvb3FSMHZGeDQ0N1Z3SnFRRlJVTGhvdnhabm93czUr?=
 =?utf-8?B?T0YwZ0NvY2F6SldrbzFBOHU0UTlFRDVtNmxsc0NPQ0tRZjhLRkdGM0JuTmRW?=
 =?utf-8?B?eFpWUkNaekZFMUtRZjJrVDRaRUF0YkNiZFQ1aytkQU9XdDZjQVI5SEd2UDdl?=
 =?utf-8?B?RmlDQzBxR0dvKzE1NHpTSHhnRGcvOVdHUnNEc3FicmN4Z0NsOTZ1NHVZTVlG?=
 =?utf-8?B?MURtUnZtTUp6MWMxbDl1eUxmMzZXbnIxUzB4R3NYNVZRNUlBU0xENFJVVlcx?=
 =?utf-8?B?ZmZqdHpQREQ5UjBPZ3pQRnNyV0M1eCt1UDdQMzVhZ1ZWMWgzcGNUTUlac3VR?=
 =?utf-8?B?RFE0R1RYU3dVQnVaREtobTQ4R2JDZURJS2psWnZzdG0xYkx6TDFzcit5KytT?=
 =?utf-8?B?dGorblBudkRsWVVRUFpVc3QxT2o1MW1NcG9GajczandqRjE3azYzRzFlb1NN?=
 =?utf-8?B?bDNwdmpFMUhIODRkOGJZUEg3cEkyeldBNDJ0UlQ4MFVibTNtWTV4VWZoUFpv?=
 =?utf-8?Q?pJt6LYy8mQ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBvTXFvcGVIbVc0RzV4dmw2TzlYY0I3eVRzbGZtU2hWaDRES3Q5bmpLYS8v?=
 =?utf-8?B?Mm50S215R2k0MWRoYkMxZy8zYS91TC9pbEh0cnBLUFl1akZKcEoxTW1Da0M3?=
 =?utf-8?B?VUFONkdSZkdNRW5NWCtCcjZmU1JQWjJkSGMxMnJzblRMMHFGUytSUVJjK1k0?=
 =?utf-8?B?dzVCRnN1KzQ5eURRdXFjTFZXOTBjUVFWTkNIWVlsTUdKTVdjVDBMR25WVDVW?=
 =?utf-8?B?ajJ4TEkxMDBLZk1MNEIvMmdsb1VYbjJOL1dwRW96MThOSTFPVnJIb09JOFRH?=
 =?utf-8?B?NDBsRU1OaG4xcDVCV0oyVmk0Q1hFSXpvWVJxL2VNMmw0dVU5TDk2aERIb01C?=
 =?utf-8?B?MkR1aWFjZVZYOXhrS3ZWVnJiMkpEVDU5Y3VwSmU2NnUwTVVidXBWd1lVbjBT?=
 =?utf-8?B?dlEzM1pHNkpjNGNQK1hzbnFCa2ttcTBKc3NFOW5aeWg5ejdVa0JrL3JQM3ZN?=
 =?utf-8?B?clA4T2RMeHJYZDdjeGQwVjNTWEk0RStwU1NBSm1GTVNCd0JSVHFQSmkvMjRU?=
 =?utf-8?B?OWdNejRlclYweFB0ZGQwVkc1bjdOaHdwTGs4S3FaMjdoTUFMMFZ3WGhzRDc1?=
 =?utf-8?B?UHJvb2EyMWp2RFVPSjREdTFvYURpZVR6OFJpOXcwdm1vamF5aU9SWWlOY0RZ?=
 =?utf-8?B?UzkvNDdlVnl5WGhCT1ZVNlhQdCtFbVgzL01MUGF3VXozYmRjL0NIWWNiNnNy?=
 =?utf-8?B?RnZnQ054MEJTTHhDS2ZyQURKdVdhdG50aGdiR0lJYzhlTytQRzFvOFViK2pU?=
 =?utf-8?B?ZVlUOEJVaUNuRzkvV1R1VFFQSTVYaHE3K1owMzZFVFU3Sjk0SE93azRNMkpT?=
 =?utf-8?B?SXI2WC82Skwxc3BDZ0h4THYzU0FWWmRlSGlTWDRWTUVkNFF5SkUwd0Z6WDZv?=
 =?utf-8?B?Nk0veXVwQ2lOODZ2anVrT2pESzVWY3dwWmg0cllBQnBHamdUWEllOEdXQW1I?=
 =?utf-8?B?K29VRWMzTmFmdWhjNW9wSW9BbWxwaFkxbWN3TlE0V3Q2N0V4d3pHSHFCVHJY?=
 =?utf-8?B?d0IzZ1NaUDQ4ZVlsbGVadGc0UWltcmc2NER3NmJUV3hnajRTUFJzZ3F6OWps?=
 =?utf-8?B?UnhrQW9adythYXFXcGNZTUF2Z1p0UTV4Yk1wZ0U5eWdoanpFMldRRlg5K0ZS?=
 =?utf-8?B?NW9HN0VvMWpMTXJWVlFyVmgrbWw3TkFEc21oMm9oOXRmTkhoYW5PWURYeTFY?=
 =?utf-8?B?YitidDdHcHQ3ZnQ2ZFpQaHUwVXhKYUFqenM4bE1yTHYyVGkrM2xXaHByYjVO?=
 =?utf-8?B?VnN4OEN1ZXpheGEzSy9tcWNPdm9SM2gvTVVSbnlBYzVNRTZpOUpRajVCRVY2?=
 =?utf-8?B?SW5wNkdvc1VzTnBQNWF2WkRuQXlBdVZudG10aVBGREk2dTJxMVV3OWk0MUhL?=
 =?utf-8?B?L1M0aXdNZkpWOERKd0Y5MEpHMElWUjZwQldMZVgvLzNleGozbFBDTWpFTjl3?=
 =?utf-8?B?U1hramhvU1lFVFJHL1F1emwyc0RLSFZXZGJsUUlydjZhVUxTQ21PSG5tZ2o4?=
 =?utf-8?B?UVlyUCtmejJpQzM1QWYyTEtjcVhaekc3ZVpQUkh1MGR3eGE1NVQ3Y3pHWUhP?=
 =?utf-8?B?blhqMWUyVHBTZnlSbTFEWFd4WnZmQ0xvUWt6cmRYUUlaM0J6bnhXV2FBM3pL?=
 =?utf-8?B?SFZXVWl0QnhVZXQ0RDkyTC8rMEl5MmpoeTgvaGhuQXZ2eWEyT2dCT3BqZTc4?=
 =?utf-8?B?TTYwWVdvNzRMdmVtd0YvVVJvUmI5aTFYdnR4VERzVmdiTENuOU9DODBOYTJX?=
 =?utf-8?B?aTQwRTA5alFRRUhrWWs5bzhZYTRXS1U4enRhLy9ONHZYbWxWdzdPUTN3TlBR?=
 =?utf-8?B?ZG1MMStFaTh4eTR5WGU5aWVkeks0ZElHNm1zd1pJaHRCaWplNjNzVjFHd2xL?=
 =?utf-8?B?OERPZFI5RFZ2V0xTTjZzdGhocWNvWnpvKzFWays0MTBKWHNPdUtEd3RuMm9D?=
 =?utf-8?B?VzNzUGJ2SmtKTUJxMnZ6WUlKZURqZWR2akpQUWVobDVwTkRqaGd5a2kxcDZl?=
 =?utf-8?B?dURHY3JMQ1JSSCs0MXpUaG1SZnZ3OXVnRHhKa2NqOGhtcUsvZHRBdUx4S3FY?=
 =?utf-8?B?b3NoQmV3YXJtMUhjdHVlMVJVY3phSGJxUkxxN21nY1RuUjA5WUpwSFp6MDdM?=
 =?utf-8?B?NnFLckw4a2w4WEN5S1lhZDVaYjdSQngxRVdzRlJJZzNnMzZ5SUZQR0RRbU9h?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f9b47f-ef48-4669-4017-08ddc967682e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:33:32.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps2eGUMK1W2XU7/fE7cEmRBlf7vjnQi5wzq2IPWEuD1a2GHBTnwN7rc5yWgBcHCnXPWJ9db9nhv6A/jfGEg3oZMEy9MxlVdkEAWK1AP5e/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6010
X-OriginatorOrg: intel.com

Hi Barret,

On 7/22/25 2:16 PM, Reinette Chatre wrote:
> On 7/22/25 11:51 AM, Barret Rhoden wrote:
>> On 7/22/25 2:19 PM, Reinette Chatre wrote:
>>> Hi Barret,
>>>
>>> On 7/21/25 11:00 AM, Barret Rhoden wrote:
>>>> x86_cache_max_rmid's default is -1.  If the hardware or VM doesn't set
>>>> the right cpuid bits, num_rmid can be 0.
>>>>
>>>> Signed-off-by: Barret Rhoden <brho@google.com>
>>>>
>>>> ---
>>>> I ran into this on a VM on granite rapids.  I guess the VMM told the
>>>> kernel it was a GNR, but didn't set all the cache/rsctl bits.
>>>>
>>>
>>> The -1 default of x86_cache_max_rmid is assigned if the hardware does not
>>> support *any* L3 monitoring. Specifically:
>>>
>>> resctrl_cpu_detect():
>>>     if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
>>>         c->x86_cache_max_rmid  = -1;
>>>         ...
>>>     }
>>>
>>> The function modified by this patch, rdt_get_mon_l3_config() only runs if
>>> the hardware supports one or more of the L3 monitoring sub-features
>>> (X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_TOTAL, or
>>> X86_FEATURE_CQM_MBM_LOCAL) that depend on X86_FEATURE_CQM_LLC per cpuid_deps[].
>>>
>>> I tried to reproduce the issue on real hardware by using clearcpuid to
>>> disable X86_FEATURE_CQM_LLC and the CPUID dependencies did the right thing
>>> by automatically disabling X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_TOTAL,
>>> X86_FEATURE_CQM_MBM_LOCAL, not running rdt_get_mon_l3_config() at all, and
>>> not even attempt to enumerate any of the L3 monitoring details.
>>>
>>> What are the symptoms when you encounter this issue?
>>
>> Linux crashes during boot with a divide error, and the splat backtrace is in rdt_get_mon_l3_config().
>>
>>> Would it be possible to send me the CPUID flags of leaf 7, subleaf 0 as
>>> well as all sub-leaves of leaf 0xF?
>>
>> # ./cpuid 0x7 0
>> CPUID for Leaf 0x00000007, Sublevel 0x00000000:
>>     eax: 00000002
>>     ebx: f1bf2ffb
> 
> Looks like X86_FEATURE_CQM_LLC is off.
> 
>>     ecx: 1b415f7e
>>     edx: bc814410
>>
>> # ./cpuid 0x7 1
>> CPUID for Leaf 0x00000007, Sublevel 0x00000001:
>>     eax: 00201c30
>>     ebx: 00000000
>>     ecx: 00000000
>>     edx: 00084000
>>
>> # ./cpuid 0x7 2
>> CPUID for Leaf 0x00000007, Sublevel 0x00000002:
>>     eax: 00000000
>>     ebx: 00000000
>>     ecx: 00000000
>>     edx: 0000003f
>>
> 
> Thank you. Could you please also pass on all sub-leaves of leaf 0xF?
> 

One more thing, could you please check the kernel logs for any other issues
when that VM boots up?
I would like to check if it contains a warning with text like:
"x86 CPU feature dependency check failure"

Reinette


