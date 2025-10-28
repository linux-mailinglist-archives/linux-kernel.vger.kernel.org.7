Return-Path: <linux-kernel+bounces-873001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEAEC12D03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6634659D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3F427CCEE;
	Tue, 28 Oct 2025 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCiW8wd6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BA23AE9B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623572; cv=fail; b=TyxDTDNyifW7zyiSy15XJEpgIHm8jiuWtIn6FBGm2N9HKiurI+FYaPgTWg8Ol+TADfZEOeWaqbHmq5AErS45UuEMak/+QwDxcCf1PikbqRdgwBWenMqM9ApCiR5lp4Sq3EhQ54RPsIHTVuQYjvYqijTC34NHKyZ1tsCvRc4qmkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623572; c=relaxed/simple;
	bh=/IuHzoOKYgutPqrMlTcOHToRqmz3vmyK9hRojlF1Rh8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eutKonrGcqQot/v2kLKt9vnBh/e9prhgIP9g8Hi2mlJclLW3L/yuMNxoEsQ1bs6BQE1M9oYIxSk40boojBL75zI0NeSHGRXoPP9nuNgTJi6M7XplAmsKYmhQDwJxEgVn90MNnmn7Q5/U/9hO0ROGc17oYNfcVOmvLxFekwNyAqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCiW8wd6; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761623570; x=1793159570;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/IuHzoOKYgutPqrMlTcOHToRqmz3vmyK9hRojlF1Rh8=;
  b=GCiW8wd6dobgJ6pIOTkVjKaQ70GpkzmNLztmannakueRZyV7eYP7QExM
   GV/V70HhCTfhroWY15x1JvKxTbY7QPV7wG6h4NGsPZ4Kpr6ALeFiPkPd6
   7QSoJsF0T1QqkybfaPDLAQywREPqDA939jx2MrNAvqLTslmBav4y9NnX4
   EYzvHimQ6lsxDgDa7aqm+5iLGTRvfeGmg7nCb8tcOuJ+b9ZhVAxHphV5B
   fZijLVEaa0oDfTl0kvRSEh38apz7WskdEXzT1tSEiq64opckfaTLLZV8s
   BlPIx/HD6G/ese4Mdmgid0RLxggtGY7Utof9/TYpAuxI/h6fhqVkW8EII
   Q==;
X-CSE-ConnectionGUID: 5KGCNSVcSMaf6MCpv3DHjg==
X-CSE-MsgGUID: rU3z9EIPRL+7y/UhRu7zoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89184429"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="89184429"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 20:52:50 -0700
X-CSE-ConnectionGUID: nWSRehXuRMuq7eXxcgNv5A==
X-CSE-MsgGUID: bEyMAHIjTUuWYgZNDmBfgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="184460069"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 20:52:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 20:52:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 20:52:49 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 20:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9Qj3RydWiCv5cemQW3VXtoYhIzAFi9l4mbWoNbQJaNZhrqiy/gwr9MfOUm5Npjqw23E1/XGkriFuHDjBzHke8pKoWpFIZc4e8EUbG80nYrDwCaXFdJJYKM4/x6RFM6mz3VyyFFI94Uerx/UjgwN0jRPfNqy+t43hl+AzFo/E3765yYwRbpQmKYKvx0HmYZigVZVaA9xRJC68hK1+UdO08Cu/+AJR5b94KT7t/1t+OqNJBe+cDI5/NE1lPlwCnfF5Ch2zZEFW2aguJyCZiR4uvfbMHHKbXD6Z1MR5L7OpHmldVVltxm/YDSrkuOfKW4QZMBpKJO3nrKcE7BHBfH44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH+GMAjhlojvB8VzywFPh3NvsRqGB3tw7wQF3ZZMNKE=;
 b=ppkhLtAY3h9HwRuGrn7eH7VhXmmF8Ab35QkiEwViPl3Oc68LFuBxDgk085cIwsvM+Jd703ix1FIpV+hBZDSxbARUCdA/9WbI2CJ7xNk68Df2teckWPqZLn+4lTiEsqkxLGTdlXPFgwzsbtSIT3/0AC2PImDAyM+YWse27OeFyzsxozZxq7nrKQjGgHOzJ+pHeHD/CFGo2AjAIx0ZByoWjmqxsy8OFlUKrsYXccMXNA1EpuaoFTNn+mrwcp+OeIzjCoGOLcRMVaz630uAdlwULipZOfeRD+e2Q2g5avgWyfMeCWP8VJDqHEx8BRMbB9e2xHaQO2TRFZyyoAEwZ41lKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 03:52:46 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 03:52:46 +0000
Date: Tue, 28 Oct 2025 12:36:26 +0800
From: Fei Li <fei1.li@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: <acrn-dev@lists.projectacrn.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Message-ID: <aQBISp9Bz++enU/o@louislifei-OptiPlex-7090>
References: <20251024044226.480531-1-rdunlap@infradead.org>
 <SJ1PR11MB615389E066F50BBB68686A26BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <213c918b-b4aa-4174-af89-a4d17e8c30dc@infradead.org>
 <SJ1PR11MB61536DC1E7A32387FCA400E5BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <8950bbb2-f1a7-4ae8-971f-7331c7eceff0@infradead.org>
 <SJ1PR11MB6153A77684F68B592851A32EBFFCA@SJ1PR11MB6153.namprd11.prod.outlook.com>
 <be3819fe-c17e-4ce1-83ec-5ae23cfabac4@infradead.org>
 <aQA2Qr2Z8UyaCLO8@louislifei-OptiPlex-7090>
 <2813380c-f5d1-4472-a0a8-78215d9c656f@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2813380c-f5d1-4472-a0a8-78215d9c656f@infradead.org>
X-ClientProxiedBy: KUZPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::8) To SJ1PR11MB6153.namprd11.prod.outlook.com
 (2603:10b6:a03:488::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6153:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 2258e83a-91b3-4596-46fe-08de15d574b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU4xU0lyTTRkd0k1MW1BeEpwZysxTWt5Q0R1dXAxMlVDQy9LRE54WFVCc3Bx?=
 =?utf-8?B?UWNOdVpqczBGaUhLNmhKT1FHUVFDQk9yRzgxNTcrdXFadG1MaHo4M0hldjRr?=
 =?utf-8?B?V1dLajJUQ0lMY1AvM0doMWRHdXBJZmZsb2pxMHdIRmNQSktXMVBZSDVmTHBm?=
 =?utf-8?B?emc5Y1pGRzhPUUsxYWpRR01uRjZDTUxHR2VyZzVGRHJkWldWUlRqVG5leFFI?=
 =?utf-8?B?TmRIN2dxT0tOd01PSFNua3orNUU2cFhHYzlWYTJsalZPVS9tck9yUzZyOHBN?=
 =?utf-8?B?dTg1VGdiVFR1OTdnNEZyMmpWd0hETkZFeURLajNKK0pLUUpVUGtzNEx5OTVR?=
 =?utf-8?B?aTJQZU84VUVDUE8zK3Q2d2FBVFYxUWFSUkNkUk84ZFNmQkRxamFRSWUrL2dJ?=
 =?utf-8?B?MmV6Q2NKSGswdm9idXREb0gzeFJhWTlheWhwM2RXOXBlY0pGZVJTTEdjVFBj?=
 =?utf-8?B?bUwrSnplRWtQMmE5YkF5aTJuVkI4MmZKZXVPWFdXVU90RjJpaDMrbEV0Mm9D?=
 =?utf-8?B?QnNoVVRsRVEyNGRXUHZZTUdqOHFSRHFXTzZlQ2t3Q3RmYjhkSEtxSStVQXhM?=
 =?utf-8?B?K2lsZ3JTaGlyeEl1TFNNZks4ekdiVjI4M1JQd3plSzRGV0h1aWRmVVUwMDRn?=
 =?utf-8?B?Q3BZRnEvUzJDSS9jTUhselQ1cGdCV3AwcU9BVUZkMktPNlgwNVhXM1dhTzgx?=
 =?utf-8?B?bXhSamdOT1FGbDV2QkZsYmYxOWR3SFNNUHNweFlQT0kxdnJJOTQ1YThqM3dZ?=
 =?utf-8?B?OU9GbnRzclhQUkRlNGg2NWtnZFlOQ1htR0xFOCtrL1RuMEI0cm9BbkxncG1B?=
 =?utf-8?B?VlZYU0FoMmlmMlVicUFESkFqb2YzT1hzMmhQYXVTcUh6bU9PeXg3VzlDVDlP?=
 =?utf-8?B?KzZTWW45Sm5nNFhGN1JBT2ozVytiMkhyU1JvZVNudWRlM3JxM3ZuMXh2L3U2?=
 =?utf-8?B?dXpSN3FDYTM1ekVsT2kybDVkUlZ4bUVnRG43Q1NHR2xnNDR3T1VZbjF6ZjFF?=
 =?utf-8?B?REtYcmlTU3lMTTVncEwwdElvQkxiYjdSRXMwbHh2dkErbS9NSnpBVUJZSUlY?=
 =?utf-8?B?TU1GUFY5SFMwc212bDNuc0hTNVpkN1RrR2JpZmtIYkJrbUIvTWxMTnIvbk13?=
 =?utf-8?B?cWJFdzRmSXZOMzN2WDJMaWx3T09GdlpCQ2I4RXVXMHMzTjJVT0FiOStkREhQ?=
 =?utf-8?B?UVZuT1JwKzV3VmlLYlJnbkE2UUFRSzErbUN6aTkyVzlVN1pOd0pJYmF4cE5r?=
 =?utf-8?B?OEhZWms1WFZCNUxFNzdwQk9mYkZXMXcrQ0doSFJ5Zy9Ocjl4R2J2Z0FwYnpp?=
 =?utf-8?B?UlhvVUFndFNRbUhXTXpOaGJqcjNFcldyT3dFRGVCUDlVdXRtczhLdW1XZzNp?=
 =?utf-8?B?ZlVYZWFCbG5Mb0xHUXNGd2pKUk01WTV2VGV3QVdLUGxTWFNaZ3ZiazRzUzhz?=
 =?utf-8?B?WG1iaGJpdy9qditHWVJOOEkzM0lKdm5PMDhlTXFvSGxIZ1BNaXpKdXJJNWxU?=
 =?utf-8?B?aDVobjBNVEt5VzhKeFM1RFlWNElSOFhxSFdtczNReldJWXIySGdwazREZXdS?=
 =?utf-8?B?V2dhdVFQMlV5NkZnaEpmaWRmK2JXSzZDMjU4Q0oxVjNHY1VON2E0UFphTUx0?=
 =?utf-8?B?OEI4N1dkSjIyQUFxS1h4eWxLbjFvWEJxbm4zdW5RRUVURlE5KzV0eG9DTGlX?=
 =?utf-8?B?dEZvV2g1VXhmNnBYUFVOWUJLL3A0RTdBRUtxdkNSaFR1TlNTMDR2R3dZbVZx?=
 =?utf-8?B?cVVTc0JBSWxBQlNxVytHQ2M2SklGZUJ4a25UbWh5d0R4U0h3T2FRcEY3TTJU?=
 =?utf-8?B?Sk14cldid05seFBIaTZMblAwRnRudW95MGdZZ25qN0NNSktXMTROY013ZWha?=
 =?utf-8?B?b0lrcGQ4dXRNYzhxZm5TVEpHWUg2d2VudmdUSllOVjFYYXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHVLbU1QN1BuWnBYMHZzZ3Q5T2taa3RENTZJNng4bEp2ZVRuTDdpWnN0L3Zr?=
 =?utf-8?B?RkdwaDdyRHQ4MEFDQlZEekN6SkxtU1pOdFg0M1JaaU5pZXJsMXJKWjEzbU1Q?=
 =?utf-8?B?NHllWExnd3Vuc2VCeHNTTktzUnhvbG1PSUxZQ3NWYU9oWjZMY0FrZktIL0FL?=
 =?utf-8?B?dkZORFRWSVhHRW1jRTdrTkU2OFpqUGlPN0lTVFNOcVlNcVBjUXpwVFpqclpQ?=
 =?utf-8?B?aUhVM01zYytoRnFES0x1RFVvV081VkREelBqaVkrODdKQ0xPaGpVdGEvZ2Ra?=
 =?utf-8?B?dlNzbVhXQUNRQjBZOWVUU3A4a2l6WklpZnhUUXhWWjUzVDNqay9MQUNMNi9l?=
 =?utf-8?B?c3BJQWJJV3ltTVJtdUFyOXJtWFVENGlpVFB2UEVPb3NhdHROTFdKb29EUG04?=
 =?utf-8?B?SlNhR2lIR0FLOU9vcDROQTgxNmo3UStzTWlUT1B1NlZYNWJtNFU0Z2JtakIy?=
 =?utf-8?B?ZVUvWUFvRGpVWkVTRGlTY0NtYVpaRzN2enpuZTNsMkxZUWFYYU9XZTFadk4v?=
 =?utf-8?B?aXV2WkFidXhxQ3N4NFhrNkIrYVBsakw0WVB4UndGOHVsSGZ0TXlsbHZ3bXB2?=
 =?utf-8?B?OVVLci93MU5qTUZUYlJuVG92NlY2MVZsVVBPQlRwbFNINkwyc2pRRGowRzlF?=
 =?utf-8?B?cGNlUXBWODhRK2tlN2VpMWhpdWpoc1BmOWZMd0hLbTRFYkhXSG9KUzFSdGd0?=
 =?utf-8?B?ZWltMHhiM3M5cXd5TU83VlRnaUFldjEremZoSlpadld3dGozQXUxSDY1MkN1?=
 =?utf-8?B?SUUxYnZCUm9FUExxaVoxM1RWUm5rTzhXa3htcjRNdldXOFhwV3hhYWdveXJV?=
 =?utf-8?B?YTdER1dSMG9uMm1UdmVDRkRKRS9rQjMwSlBNVFFLSWhFcldHTzM0Y3FNTGt1?=
 =?utf-8?B?cXlUbEV5NHpmcWN2ZmE0TldIbFdVVDZZNzFNWThXWWVmbzk3QXR1WjFTUEdU?=
 =?utf-8?B?R0JUdXVCK3dvUExiZVVzdjBmUTZkN042UUN3cEtYTVNMcFBjc3hoSFhzUFoy?=
 =?utf-8?B?bSs1VjBkUVFxd1pHcGpMVUVabE1FSHZyQ21PelRxMGJ3S0xROGlMdms1YzJi?=
 =?utf-8?B?NWF5R1EzdEM4UnJFZkJFSlcycUl1ak5ZbGRkdVFRM1MvQlBQd3ArRm5iWTdw?=
 =?utf-8?B?RURsc0drRS9sVTVlakdqVUFoTmNLcUpSOHY3WlVtV3Yxd3Y3U203TFRhaEFL?=
 =?utf-8?B?MERjamt4ZmhSNkIxVlFicmVjZS9yVGxObURTcStnVkRpYlVPaFdBdlpIR2U2?=
 =?utf-8?B?aE1CMTdHa3g0UUR3cWVlSHpzQldUQW5wbXZidHVObGozbkE3WC9LSWN1bGxk?=
 =?utf-8?B?VDVXTSs3WW5sUGJRYVhqQVpLT1hDQXFTZEE0blRTc3lFbkpSc1B2L2pBR3Uy?=
 =?utf-8?B?Y1pjbXRHQlR5bUVyVXJMSU1FTWNnM29xTVNzbndCdFNPalM0NTBwUmpsMlJi?=
 =?utf-8?B?TzhvRWhpZmJ6cHpKV0hBbkVieC9LZ3hOS3M0WDh6UUEzN0pBWW1vUnh5OUxQ?=
 =?utf-8?B?L2M0Q3I4VkdoODZqYk85dzJ2bGtyY29ZeFhSQzdPd0dOSDdENDFPVnFhY2RO?=
 =?utf-8?B?V3ZJbWN6UldFNzV0QWExVC8ycERDa0pWNkkrMlhqZ3VFZmo2bXIzMldnNGQr?=
 =?utf-8?B?WE52Y3cyaGpIUmtpMDdBczFyampqWXd6RUN0NFBtRXpIbC9QTVJuQ1VjYm1n?=
 =?utf-8?B?NU5VdmpjcEIyNWJITndxY1Z4WTJIS1Zac1UyRmlxOEZ2Zm9zeU9MZjBaUmYx?=
 =?utf-8?B?ZThXWitzaDBtSmp2Vy9ySVdQWUNhRXZGYXU2MXM3SHVvN3h6SDVaT09rK0U0?=
 =?utf-8?B?TUR2eWlPWHFPTkhHRTExelRET0lTNTZwZWgwekE2TWoyQmFseDY4UE5kRGtB?=
 =?utf-8?B?d0ZObysvS0VIb2E1Q1Jpc1RtZVd6K1Q5N0plYVhGR0dZSlNPenpmN1lWb1ph?=
 =?utf-8?B?ZjBwRW1zcUVpYi9mVE9YK2FzaHFXNjF3U3UvS3dBYVRBSjVjekRYRG1XNWRk?=
 =?utf-8?B?NTRBc1pHSHZVRld5bzhJVi94WWJpMU9aWGFDQ0tLa0lmQmxxUlE1Smd0Ri9z?=
 =?utf-8?B?VFRHMlRUandLN1FPUStLU21BN1pFSjJKelJScFBHVThGRTRrSVo0cXlHZi9D?=
 =?utf-8?Q?/APS/cxWYkXP+dEa2oXsfQc9C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2258e83a-91b3-4596-46fe-08de15d574b0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 03:52:46.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6kxdUmScs8MzB1L+znOe5oTBYYoqyDC+lJ+DkRBF5WGykqSxuRy7kXnw1xlo1jXhR2FvryxC47CZzOQWiL5nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com

On 2025-10-27 at 20:45:27 -0700, Randy Dunlap wrote:

Hi Randy

> 
> 
> On 10/27/25 8:19 PM, Fei Li wrote:
> > On 2025-10-26 at 23:11:07 -0700, Randy Dunlap wrote:
> > 
> > Hi Randy
> > 
> >> Hi--
> >>
> >> On 10/26/25 10:54 PM, Li, Fei1 wrote:
> >>>> From: Randy Dunlap <rdunlap@infradead.org>
> >>>> Sent: Saturday, October 25, 2025 3:44 AM
> >>>> To: Li, Fei1 <fei1.li@intel.com>; linux-kernel@vger.kernel.org
> >>>> Cc: acrn-dev@lists.projectacrn.org; Greg Kroah-Hartman
> >>>> <gregkh@linuxfoundation.org>
> >>>> Subject: Re: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 10/23/25 11:22 PM, Li, Fei1 wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 10/23/25 11:00 PM, Li, Fei1 wrote:
> >>>>>>>> From: Randy Dunlap <rdunlap@infradead.org>
> >>>>>>>> Sent: Friday, October 24, 2025 12:42 PM
> >>>>>>>> To: linux-kernel@vger.kernel.org
> >>>>>>>> Cc: Randy Dunlap <rdunlap@infradead.org>; Li, Fei1
> >>>>>>>> <fei1.li@intel.com>; acrn-dev@lists.projectacrn.org; Greg
> >>>>>>>> Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>>>> Subject: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
> >>>>>>>>
> >>>>>>>> Fix the kernel-doc comments for struct acrn_mmiodev so that all
> >>>>>>>> struct members are rendered correctly.
> >>>>>>>> Correct io_base to io_addr in struct acrn_vdev.
> >>>>>>>>
> >>>>>>>> acrn.h:441: warning: Function parameter or struct member 'res'
> >>>>>>>>  not described in 'acrn_mmiodev'
> >>>>>>>> acrn.h:479: warning: Function parameter or struct member 'io_addr'
> >>>>>>>>  not described in 'acrn_vdev'
> >>>>>>>> acrn.h:479: warning: Excess struct member 'io_base' description  in
> >>>>>>>> 'acrn_vdev'
> >>>>>>>>
> >>>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>>>>>>> ---
> >>>>>>>> Cc: Fei Li <fei1.li@intel.com>
> >>>>>>>> Cc: acrn-dev@lists.projectacrn.org
> >>>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>>>> ---
> >>>>>>>>  include/uapi/linux/acrn.h |   11 ++++++-----
> >>>>>>>>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>>>>>>>
> >>>>>>>> --- linux-next-20251022.orig/include/uapi/linux/acrn.h
> >>>>>>>> +++ linux-next-20251022/include/uapi/linux/acrn.h
> >>>>>>>> @@ -420,12 +420,13 @@ struct acrn_pcidev {
> >>>>>>>>  /**
> >>>>>>>>   * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO
> >>>> device
> >>>>>>>>   * @name:			Name of the MMIO device.
> >>>>>>>> - * @res[].user_vm_pa:		Physical address of User VM of the
> >>>>>> MMIO
> >>>>>>>> region
> >>>>>>>> + * @res:			MMIO resource descriptor info.
> >>>>>>>
> >>>>>>> Hi Randy
> >>>>>>>
> >>>>>>> Thanks for cooking this patch to help fix these warning.
> >>>>>>> Could you just add the comment for `res` and keep the other comments
> >>>>>>> for
> >>>>>> the fields of ` struct acrn_mmiodev ` ?
> >>>>>>>
> >>>>>>
> >>>>>> Do you mean leave the [] square brackets in the field name?
> >>>>> yes
> >>>>>> If that's what you mean, that's not valid kernel-doc notation.
> >>>>> Would you please post the quote how kernel-doc prefer to add this
> >>>>> comments ? I didn't see an example in the kernel-doc.rst
> >>>>
> >>>> There is not anything in kernel-doc that indicates arrays so I can't post a quote
> >>>> that shows that.
> >>>> The patch shows the preferred kernel-doc here.
> >>>
> >>> Hi Randy
> >>>
> >>> IMHO,  the patch shows here is an example of `Nested structs/unions`, not an example of
> >>> `Nested structs/unions array`. 
> >>> For the ` Nested structs/unions array `, the `In-line member documentation comments`
> >>> style is more suitable, or could we just keep what it is for: (1) there're many kernels' codes
> >>> still use this comment style for theirs function comments, I.E., in kernel/rcu/srcutree.c
> >>
> >> but that is not in kernel-doc comments.
> >>
> >>> (2) the kernel-doc doesn't complain about this warning.
> >>
> >> Yes, it's just wrong about that. As soon as it sees the "[]",
> >> it seems to become confused and omits all struct members
> >> after @name.  Here's struct acrn_mmiodev
> >> after I rendered it in man format:
> >>
> >> NAME
> >>        struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
> >>
> >> SYNOPSIS
> >>        struct acrn_mmiodev {
> >>            __u8 name[8];
> >>            struct {
> >>              __u64 user_vm_pa;
> >>              __u64 service_vm_pa;
> >>              __u64 size;
> >>              __u64 mem_type;
> >>            } res[ACRN_MMIODEV_RES_NUM];
> >>         };
> >>
> >> Members
> >>        name        Name of the MMIO device.  res[].user_vm_pa:           Physi‐
> >>                    cal  address  of User VM of the MMIO region for the MMIO de‐
> >>                    vice.  res[].service_vm_pa:        Physical address of  Ser‐
> >>                    vice VM of the MMIO region for the MMIO device.  res[].size:
> >>                    Size   of   the   MMIO   region   for   the   MMIO   device.
> >>                    res[].mem_type:             Memory type of the  MMIO  region
> >>                    for the MMIO device.
> >>
> >> Description
> >>        This structure will be passed to hypervisor directly.
> >>
> >> SEE ALSO
> >>        Kernel   file   include/uapi/linux/acrn.h  struct  acrn_mmio_request(9),
> >>        struct   acrn_pio_request(9),   struct    acrn_pci_request(9),    struct
> >>        acrn_io_request(9),  struct  acrn_ioreq_notify(9),  struct  acrn_vm_cre‐
> >>        ation(9), struct acrn_gp_regs(9), struct acrn_descriptor_ptr(9),  struct
> >>        acrn_regs(9), struct acrn_vcpu_regs(9), struct acrn_vm_memmap(9), struct
> >>        acrn_ptdev_irq(9),  struct  acrn_pcidev(9),  struct acrn_vdev(9), struct
> >>        acrn_msi_entry(9),       struct       acrn_cstate_data(9),        struct
> >>        acrn_pstate_data(9), struct acrn_ioeventfd(9), struct acrn_irqfd(9)
> >>
> >>
> >> and here is the Members section after my patch:
> >>
> >> Members
> >>        name        Name of the MMIO device.
> >>
> >>        res         MMIO resource descriptor info.
> >>
> >>        res.user_vm_pa
> >>                    Physical  address of User VM of the MMIO region for the MMIO
> >>                    device.
> >>
> >>        res.service_vm_pa
> >>                    Physical address of Service VM of the MMIO  region  for  the
> >>                    MMIO device.
> >>
> >>        res.size    Size of the MMIO region for the MMIO device.
> >>
> >>        res.mem_type
> >>                    Memory type of the MMIO region for the MMIO device.
> >>
> >>
> >>> What do you think ?
> >>
> >> Sure, if you want to leave the file as is, that's your choice.
> >> Consider this patch dropped.
> > 
> > Yes, you are right. The `dump_struct` in `linux/scripts/kernel-doc.pl` can't pasre
> > the `[]` properly since it can't tell this is for comment or for a struct_members.
> > 
> > So before kernel-doc.pl could handle the Nested structure array properly, maybe
> > define a structure for `res` maybe the better way to avoid the confusing.
> 
> We no longer use kernel-doc.pl. It has been rewritten in Python. The new
> script is scripts/kernel-doc.py.
> 
> > Would you please help to define a `structure acrn_mmio_dev_res` just before
> > `structure acrn_mmio_dev` ?
> See below. Is that what you mean?

Yes, that's exactly what I meant. Thanks!

Acked-by: Fei Li <fei1.li@intel.com>

> ---
>  include/uapi/linux/acrn.h |   36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> --- linux-next-20251024.orig/include/uapi/linux/acrn.h
> +++ linux-next-20251024/include/uapi/linux/acrn.h
> @@ -418,26 +418,32 @@ struct acrn_pcidev {
>  };
>  
>  /**
> - * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
> - * @name:			Name of the MMIO device.
> - * @res[].user_vm_pa:		Physical address of User VM of the MMIO region
> - *				for the MMIO device.
> - * @res[].service_vm_pa:	Physical address of Service VM of the MMIO
> - *				region for the MMIO device.
> - * @res[].size:			Size of the MMIO region for the MMIO device.
> - * @res[].mem_type:		Memory type of the MMIO region for the MMIO
> - *				device.
> + * struct acrn_mmio_dev_res - MMIO device resource description
> + * @user_vm_pa:		Physical address of User VM of the MMIO region
> + *			for the MMIO device.
> + * @service_vm_pa:	Physical address of Service VM of the MMIO
> + *			region for the MMIO device.
> + * @size:		Size of the MMIO region for the MMIO device.
> + * @mem_type:		Memory type of the MMIO region for the MMIO
> + *			device.
> + */
> +struct acrn_mmio_dev_res {
> +	__u64	user_vm_pa;
> +	__u64	service_vm_pa;
> +	__u64	size;
> +	__u64	mem_type;
> +};
> +
> +/**
> + * struct acrn_mmiodev - Info for assigning or de-assigning an MMIO device
> + * @name:	Name of the MMIO device.
> + * @res:	Array of MMIO device descriptions
>   *
>   * This structure will be passed to hypervisor directly.
>   */
>  struct acrn_mmiodev {
>  	__u8	name[8];
> -	struct {
> -		__u64	user_vm_pa;
> -		__u64	service_vm_pa;
> -		__u64	size;
> -		__u64	mem_type;
> -	} res[ACRN_MMIODEV_RES_NUM];
> +	struct acrn_mmio_dev_res res[ACRN_MMIODEV_RES_NUM];
>  };
>  
>  /**
> 

