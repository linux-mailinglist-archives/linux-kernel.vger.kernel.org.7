Return-Path: <linux-kernel+bounces-740045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44441B0CEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DD96C285B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11618A921;
	Tue, 22 Jul 2025 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoYHXfYo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD113A265
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146680; cv=fail; b=Vx6b7sVb+6sYlLKWnyQB+UK3vMrn0ONBG+cMfZVtjvrsYI7VNNehk7Is2tH4NqWMRgYgC1r20+b2pw7BojH+hV502hZzcl6JAaxqp6q2mu9JmAMf0e3NVwHqO8LIBAcsZIRODqJQmFq4O160Ono0ca05AsvDPiDkkLAavReClkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146680; c=relaxed/simple;
	bh=8Xl1Pf1aVs9/xHmrk1esChYV63RMJVGdIPp0+Td3Xw4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kx6O/z1n1rz8N714i3mHQBC9ypujgXZD/WBIHu9aBlwgaaGD1eQ2ma3CJrZUCKVruiuEk04iZznvW06nfjlSPhK30cw8XC/GWof3AW84KHldDRhIUjNO6pe5YRj3iOapi8FHxbEJ+kwCFWoTadHpZzu5wJ/UEHwaLm8VzFp0aKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoYHXfYo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753146679; x=1784682679;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Xl1Pf1aVs9/xHmrk1esChYV63RMJVGdIPp0+Td3Xw4=;
  b=MoYHXfYoKMKWz3MNUGBHVXT4tk0iuSUQjKAqsWO8mR8m/Q2Sl/T0sy+M
   HKvU+7udCYm2e9WbdLAtdnhSsgG9ovF2RSSn2P+GHAv2afefPk+lxoD+N
   kTtx143pYkhQl0TWVLelWHXFvCcU4rXdSqP7wv+Dz/aKedEfG0c/gNSuB
   WTsCakgc8tvVAwAG708TPwceBskrWn5gByMYBTYZIQ+Rfav1sdZ21i7Zy
   XoV9rqKsm45uv3C812vVaiR5xrj0imCiyfiMqcYV6u8ru4eIBShZsmdZe
   qBD4VANVpt6o6Px/tCrV/k4B4V7eYHVVKYrNJFA60HZe0y0y7gX7hwQ6c
   g==;
X-CSE-ConnectionGUID: USznm71JStStOy0V4T1ciQ==
X-CSE-MsgGUID: +Xl2hBqtTuiSKu7uwNhtKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55537164"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55537164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:11:18 -0700
X-CSE-ConnectionGUID: /Mic1/9wSna2CAMNKQr3AQ==
X-CSE-MsgGUID: LFZxTEkSRSit43x5WUNL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="163045152"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:11:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 18:11:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 18:11:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 21 Jul 2025 18:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki1nJ8haJs3wANzMUjssFd2L9siROC4Q20hyetrex59C6SKiLT6mMXzroUjnS+THfcok+ToJQL/kH44B5ibqutO5fCkBIQgmvHgKZSTYuKITk8EEGYdDID2rO5n8uryQX+Y4DblMUDjmwA8ppX20kMHGy9wsmBAevWXtCLzexvHx+n1VO3hQN9pTX+aYcU3MdyptxPmNm/eRjeiErodgb5TOzYJOLhmQlLzxgyx1WviC0WW9GRLibC4wUvywAzt739WwaUBGO7yRGzC6g05kVv1LQEZ6ZnVVX4ekiSs9Kd0MODngjMFomxdu937sXAkaivSs1d6oZRIcZJ1LGu5XUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m94q8NrBE9dOcnSTeuYxUb0Au2DMG9OruaJl4cBSqhs=;
 b=jgNFn23mHVUubkj5TrD3X1/nxdIzi/mNtVtmKffUYrTb4C0zYFqqT2jhHX9Bshe7bH5pYyFXXG+GoUnWc8dmD20wlVy7iA+HShlvQiQW41yUGkpxK/XfJ0yHCSaXFjngbdNWPPjk8BayV4dQjCUASqVjoyPxlGP3UMr2XhvllDefW+BVkuu09ewzs22ePNmELk72GMgDjalBDjCVFymYW1pJgd3iFGqPryNldBE/dQkhMrKykf3XrkW3bxInL3AyztnNfK4kw4acnDZ9Vv218eVD4glxauxVm1tt0BdDsWSTJCzh6iazxP5c38xl71z35qcFv7pTxv83q/wjr9AYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 22 Jul
 2025 01:11:14 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 01:11:14 +0000
Message-ID: <fa4e5e3d-431c-4dcb-9ffc-b20e6ee66e43@intel.com>
Date: Mon, 21 Jul 2025 18:11:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/fpu: Fix NULL dereference in avx512_status()
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
	<chao.gao@intel.com>, Fushuai Wang <wangfushuai@baidu.com>,
	<linux-kernel@vger.kernel.org>
References: <20250721215302.3562784-1-sohil.mehta@intel.com>
 <9d02685f-5c19-47d4-8f7f-bb546c0c7504@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <9d02685f-5c19-47d4-8f7f-bb546c0c7504@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::10) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b29292-a5f7-46d0-6c91-08ddc8bca715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aC9hMm5zcjJWUFhYa1pkQXlOTUdhdEIxRWRJWGFxd1NDUFV3enk5TlVrV0J0?=
 =?utf-8?B?eWUreERiMElzRytHMksvQS96eUd5b2dsVFVZZHYvRjBIem5ucVB6VjUrZzBa?=
 =?utf-8?B?LzB5cVF2d0Fndzh1QzMyS01Gc0NNYkZNQ2x3NDJyKy9DS013VmIyekhIdEpZ?=
 =?utf-8?B?TmVTZGsvb0NtZ05ubTFTbmVNS3haOFQyVTc3TnFaSnlYd0liYnliT0xiUXNr?=
 =?utf-8?B?Q0xCRTdQNEhLL2xUNGFhTHFuTmd4aUdraSs0MkdSUGxxMTVvTW93d2RGZ3VO?=
 =?utf-8?B?cjhjbUZpcXN6clU3b3pwMi9aTU5Fb1JneUFDWlFTSjQrRXlmU2ZxTU5pY3I4?=
 =?utf-8?B?eEc1UFhYa2Q4QUt0dDd2UmhsYzQzU09jZ3RKcnEvZTBzWGlpck1uWUIxdjhW?=
 =?utf-8?B?ajN3SkZyY1gwc3RKMitMQWNhaDQ2RDRRU3lTaHJoNWVjcG42UGhFcHZKRFFS?=
 =?utf-8?B?cUdCZWJmV1FiQm5MeEZwdFd0dm80bGgxa1ovYVdvVXRtdGZyQXN3Q2lZZTJp?=
 =?utf-8?B?dTUya0pDMGYyOWV1R3NMZkRzQmxyOS9jMTJzViszYlFCV3Z3UC9YSUQ2Z2pM?=
 =?utf-8?B?LysvN1NsSTJ0Z1M0SWNKSkZndXVidnpsc0VkZXk4WTBjQ25QeC8xOEhVU3dJ?=
 =?utf-8?B?dFdDRW5zYTYrdUUxVHIycGUvb0NFbE82eVd2YmdqanZUUitUZHVaQUlQTHVj?=
 =?utf-8?B?WlhucGFvUzZJbGJFaXRpM3pVZGF3a0Z6a3RpNzYzY0ZWV3l1dnRFTThxbVds?=
 =?utf-8?B?bWNYelBNeXFybmM3RGdYMVczSk5CSndXemVZdEc1ZFRtTDV5dEllVFNyNlVC?=
 =?utf-8?B?Vy9yZkJPRFJmZkE1OU5hd0xtNVpUN2ZkVnRSL0RvZ3JtWTNTUE1KRjJmWFJR?=
 =?utf-8?B?RVhHZUVXbHFwZzF6ZnY0UVRIeGsyM3h1eU5aOTNrZVRva1FyM2M3SFZxVUtq?=
 =?utf-8?B?a0V0RDhXWUk1QXQvamd4MmtYSHVSQSs4QS85NS90dU1LRGFoaWEwQW1oTDIy?=
 =?utf-8?B?QkFDWkRNaWJVbVEzNHhaZ3FyNG1laEFyZzBqOHkwMHpkZmJRWEFReG1pb3Vh?=
 =?utf-8?B?TGswUzAvOFpSaWFyek50TTNDSWVZY2lWVG9DZ0h3dkI0OExPVStEcGN2MWNT?=
 =?utf-8?B?czU5YmFwU1BLTWgrc0ZJelFCTFRmWk1wUUpyZzRITGMrOFExWEpkN3Q5T2xz?=
 =?utf-8?B?eHcwblQ0TWRFU0ZVWmowaTZlcDFVVmR1R0xOOHd2RHFrVlVRQ2EraVM4SXlp?=
 =?utf-8?B?UThLenV1emZDSVBsN0hXeFFpUXlsUE1BS0JJbGlvSFB4K2RyUVhNU2JMZnJC?=
 =?utf-8?B?RjNmcjhEVWlTSkp6RjgzZ0p4aGE4UWlTVGNnak9NR2h1TmdVaG04cHo0amRM?=
 =?utf-8?B?ZFNOYlRhYnJ2eFRkaWxtZHBNVHZNUlU4NktmSHp1THFkeHVxb1VBdjdlakFr?=
 =?utf-8?B?RnRJU2xjRzFjdEVsWnNsVXBPZmRreUh5UWZHUXZDMXFib3Zucm8yWlJ4NldD?=
 =?utf-8?B?NWF1alg5b0xrWnBwczRlZGNRL2FZclB2YmhVMXZRQzIzd0xlUkZKRlFKdjY5?=
 =?utf-8?B?RmU1c1d5YkU4TE1KcSsrVkdyWXRrcXlNaDczQ25OZkFJMEMvK0xSZlZpemxm?=
 =?utf-8?B?cjlPbWx5d1lpUzdQMk8vUVZPYW03U2FXeEFXajRub0ZLQlZPbkh1bHYrTUxU?=
 =?utf-8?B?NFhZYkgrNzlCOHI5UnNzMi9jc25kNHdtZG14cDQ0QVBMV3pYOVZUWHBtbk5E?=
 =?utf-8?B?ak8yVm5VNEp1Zm9nbVpEdVhudURiRUdjV1BIWkdSWUZwU3BjZHMrVDV0UTly?=
 =?utf-8?B?RkdSQ3Iwell5Q1ZKZENBRW9oWVczbk5mTXZ1L0VZb1JBeWErMHliVGRiY0dB?=
 =?utf-8?B?N2JMaUV5TzhGOVVsWGM3QXM1QVRpZzBHeU9rTnMxTG9xRjcrVDVzR2pPc2lX?=
 =?utf-8?Q?OuRf4RNMdQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2grVnVlYlFlRVpBS2xrbXQvSEpKOExWeUd2TW1najg5dURpNWp5WjN6aUZM?=
 =?utf-8?B?RDlHenlFVkJRTjV1Q0xpLzlEcjU2UkI2Q0JQYjJMVHE4dXIza2NMMXFhT05z?=
 =?utf-8?B?a084VmxHeWVWa2xyWWdsSHg0ZFdYeTJsQjluM2lsMnhIT3ZncUlhcDR5QnZS?=
 =?utf-8?B?RWhjOTN6SmU1OU9sOUl2N0ZwV3BYV1htNzJpWEc2SlpTOHJ1b1FSQ3M3U2hS?=
 =?utf-8?B?aXQvS2taZFB6YVFjVlBVQkNTTzJ1U3ZrL2YxdWRFKzg3NnVRUXZrZlpXNE45?=
 =?utf-8?B?Zk5wbWJaUUVpSEwxaHc5MVNwZmdlSHZra1NhVWxPVWpNOFNHK1NUdEdxdlZp?=
 =?utf-8?B?eHNEUlQ2TUFDU3h6dmZEV0YrRTdGNUhFU0lwSytnWE1GYUQxNmptekl6ZTVm?=
 =?utf-8?B?R2pQSnRhdDlNZ3hTNXlnSU1VN1JvZUVqVjBzeFhhOGkrWEQwdG0xaVVxbXlo?=
 =?utf-8?B?N0VKMUJGSnNocUpuRkJ3NzhIWFowTWdCSXlLanVTM3dtbG5HeEo1WnQ2OWtF?=
 =?utf-8?B?TmRmSlNWRnBpN3FjaS9WdiswNUVnaU5oSmR0YkU2Y0Y5Mzl6OXVLMTlCdDFs?=
 =?utf-8?B?bFRjL0p4NDlGMHd6MlgwTm5DblVhNjJzWU84WGl2TUJzMWw2TWpGekNJU3lN?=
 =?utf-8?B?NW1FWGVNRW5ydlRWbDR6blhKcmlTWVFBQUFmY09FRElLUFdoUXZ5KytRMlhF?=
 =?utf-8?B?K1JGYjdNUXUreVh0a05NKzdpVnBzMmxnNXZmVXNBc0NtOG9TV0t2Rjd2OGJr?=
 =?utf-8?B?ejhjVlN3TklBcFRhanNmNkJrL1l5WEczZDRrOGhUamQ3ZjN4eXB4SmUvSSt5?=
 =?utf-8?B?UDBJbGxyeEFjeG1BZjVVOFI2M3h1YTZzUGpTbDBUdFkzTktuUjJJU0lFSWUx?=
 =?utf-8?B?OG04SUhkS3pDWDk4TG05V0N4cnNJOXNWUUZwcHVFRk9RV3ZGU25RbmJITmc3?=
 =?utf-8?B?Y1BCUnVTTXdLY1JyRDNNbS9ab3lkKzEveGYvekRqQ3hOTlpzLzJ4Nkd4WTZ1?=
 =?utf-8?B?ODlwYWROVENRMEYzcjZKakJSRlg1eHM0dFdJdkFHVUZCVHVUR0IzT2FLRlhD?=
 =?utf-8?B?aStSYStoY0tqSk5vUlYwVncxRU9lTW1MNTVuaXR2c2g2N1RadFJUSFA3WEto?=
 =?utf-8?B?dEZDb1psdzBKZkN6ZmE1eUMzdVlIbm5kZEVCWjE4TlpIT0ZMYXZmSExGUy9x?=
 =?utf-8?B?RXhuS245aWFFdTR6cTRIVE9WazZBUytZd2hkOVJxV3lxUnBKcy9RdUlyTExO?=
 =?utf-8?B?TzY5RWtyUHpucmx4L0MwOTQzbTBQTVFkM3ZGbVVFVTdrZU1DZEZTNkpVYk83?=
 =?utf-8?B?NWhxcFA5S3ZONWp0NEMraVEraGUzWnlwa3dKVjRxM2VMM3pVZnQ5RlpCV25x?=
 =?utf-8?B?Rzhyc3d6YnlnbDJoK1JpZElpQ25RdmV0WDlydkdYVG5KRVd6OUxQK1lRQUhj?=
 =?utf-8?B?RmdFRWZLbjl3MmdnWTRLWlkvZW8yWTgyQjd1b2UzR2JMNStaUGc1T2ZLQ1ds?=
 =?utf-8?B?bWdFcjAyNlNRZG5iTmFhaHZoMWdxbEE4STZPd0srU0YyU1djRSs2TkIvZFFo?=
 =?utf-8?B?anhFOGJIR0xHb2kzREY2WW8vSVpLK2ltTEt2a2lteHNmMllYcExnSUtKYklL?=
 =?utf-8?B?d2JhMVRFeDNxVkNSNnh4V05wSG5RSGZzaG5pUUFYK3haeGtEV2xjUGtKS0VQ?=
 =?utf-8?B?VGpsRWtTMlJFUDc1Sk0wYXJZU24zL1lNdmlUSk5yQ3dGYW1saVdHZDE5Vm0z?=
 =?utf-8?B?QlJUQXlXWitMMXBaKzM4YkVwK0Fpc0QzUjJDUmNpV3I5STAyOWxieTlwbzN2?=
 =?utf-8?B?RVZTUFRBc3h3dlMrODI5bnpYQkxSZ3hnMGdJTE5McmVWNFZQRmU2d3ZPcXhj?=
 =?utf-8?B?QjBUTFV4NU9GRjdDYjBXeXZPQWp1cGRYbGluUmVhOFpHeGppOFRUZk9uNnRU?=
 =?utf-8?B?RXprNTl3dXpVMml6bGQxT0o2dDdsVTA5NWFFaUNpR1FwSTVkcXN3TlduYlNW?=
 =?utf-8?B?M0ljWEZRcGRuaGpRR01jMTRFT0NRTnJBeEtTSjU1b2cxYTd4OEdNR3VES1lL?=
 =?utf-8?B?YXM1WTV6RGZrT0k1dEx6K1Z4M1ROdHZXY1haMU9xV0QwYmZkMGE1WHlpWmRx?=
 =?utf-8?Q?cHtz2J4uegwZ71I5F01ZyaUD8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b29292-a5f7-46d0-6c91-08ddc8bca715
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 01:11:14.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7KuKE5GZV3/3ej+EEUkHA0dglcn3qHFWC8UU7WybN4IHHRM2j/MCigg53/twNXNZFoaMOEOY6Khrcr12u+yww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com

On 7/21/2025 3:33 PM, Dave Hansen wrote:
> On 7/21/25 14:53, Sohil Mehta wrote:
>> From: Fushuai Wang <wangfushuai@baidu.com>
>>
>> When CONFIG_X86_DEBUG_FPU is set, reading /proc/[kthread]/arch_status
>> causes a NULL pointer dereference.
>>
>> For Kthreads tasks:
>>   proc_pid_arch_status()
>>     avx512_status()
>>       x86_task_fpu() => returns NULL when CONFIG_X86_DEBUG_FPU=y
>>       x86_task_fpu()->avx512_timestamp => NULL dereference
> 
> This seems to imply that CONFIG_X86_DEBUG_FPU _triggers_ the bug.
> 
> It certainly makes it obvious, but isn't there a bug with or without
> CONFIG_X86_DEBUG_FPU? Even without it, I think it'll access out of the
> init_task bounds.
> 

Yeah, there might be a bug without CONFIG_X86_DEBUG_FPU as well. I am
not sure. The NULL dereference only happens with CONFIG_X86_DEBUG_FPU
because it explicitly passes a NULL pointer.

Maybe we can just focus on the WARN_ON_ONCE(task->flags & PF_KTHREAD)
instead of the NULL dereference. For the init_task (PID 0) we never
follow this path since it doesn't show up in /proc.

>> Kernel threads aren't expected to access FPU state directly. However,
>> avx512_timestamp resides within struct fpu which lead to this unique
>> situation.
> 
> What does this mean? Most kernel threads have a 'struct fpu', right?
> 

I meant to say that even though kernel threads have a struct fpu, they
never access it directly using x86_task_fpu(). Kernel threads typically
use kernel_fpu_begin()/_end but reading the avx512_timestamp value is
the only unique reason, a pointer to struct fpu is needed.

>> It is uncertain whether kernel threads use AVX-512 in a meaningful way
>> that needs userspace reporting. For now, avoid reporting AVX-512 usage
>> for kernel threads.
> 
> It would be idea if this was more explicit about how this changes the
> ABI for kernel threads.
> 
> Could we make this more precise, please?
> 
> 	Report "AVX512_elapsed_ms: -1" for kernel tasks, whether they
> 	use AVX-512 or not. This is the same value that is reported for
> 	user tasks which have not been detected using AVX-512.
> 

Sure, will do.

>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index 9aa9ac8399ae..a75077c645b6 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -1855,19 +1855,18 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
>>  #ifdef CONFIG_PROC_PID_ARCH_STATUS
>>  /*
>>   * Report the amount of time elapsed in millisecond since last AVX512
>> - * use in the task.
>> + * use in the task. Report -1 if no AVX-512 usage.
>>   */
>>  static void avx512_status(struct seq_file *m, struct task_struct *task)
>>  {
>> -	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
>> -	long delta;
>> +	unsigned long timestamp = 0;
>> +	long delta = -1;
>>  
>> -	if (!timestamp) {
>> -		/*
>> -		 * Report -1 if no AVX512 usage
>> -		 */
>> -		delta = -1;
>> -	} else {
>> +	/* Do not report AVX-512 usage for kernel threads */
>> +	if (!(task->flags & (PF_KTHREAD | PF_USER_WORKER)))
>> +		timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
>> +
>> +	if (timestamp) {
>>  		delta = (long)(jiffies - timestamp);
>>  		/*
>>  		 * Cap to LONG_MAX if time difference > LONG_MAX
> 
> Can we just do:
> 
>         unsigned long timestamp;
>         long delta;
> 
> 	if (task->flags & (PF_KTHREAD | PF_USER_WORKER))
> 		return;
> 

I considered this, but it seemed like a bigger ABI change than the one
proposed.

1) We are already reporting -1 as the AVX512_elapsed_ms for most, if not
all kernel threads. On an SPR system with Ubuntu, I couldn't find any
kernel thread that showed anything other than -1. (But I wasn't running
any workloads either.)

2) Even if there are a few kernel threads that have AVX-512 usage,
reporting -1 instead of a valid number would only lead to slightly
suboptimal scheduler decisions.
But reporting AVX512_elapsed_ms only for some threads might cause
userspace to break unexpectedly if it isn't written to handle that.


> 	timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
> 
> 	...
> 
> for now, please? That way, there's no made up value for kernel threads.
> The value just isn't present in the file.

I felt the current one is the lesser of the two evils. I am fine with
your approach if you still prefer it.

I have now realized that there are too many unknowns for me to make a
reliable call. This patch was a result of sunk-cost fallacy :)

