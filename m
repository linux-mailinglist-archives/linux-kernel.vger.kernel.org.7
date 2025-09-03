Return-Path: <linux-kernel+bounces-797624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131CCB412AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888AA1B62BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBC2BFC60;
	Wed,  3 Sep 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/FaIEpf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7232BF3C5;
	Wed,  3 Sep 2025 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868490; cv=fail; b=ZPTAlsU5fSlY17Q2KojFm0SgcYaoEQw9cbdCMEJ8hdZVV/G8jNt8bji+BJ7ej46q/NOoyg7jPbU8RuZcSaqCdvizIwzBq6gFCVWOhP3n3O1T7NvtB9MbOk1l1FXg5wTeNWVvWpUCdGXVtZ6q4CIT6VJG+KHhnQ9OSLffCC1ReiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868490; c=relaxed/simple;
	bh=DvMR8USxNpbIE3J3di+0IdjMjduI7AikJCVYtJfhI6M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B+2y1BIH4k12w/juowNZqP3UTdr2GDbqGIl2JtPeo2a3klv0VVGBitrS7ZuCcJ3BwlTZEN8dkMQzN48A+IB/0MYWHt874Sq2Caw73id6xuskyeRsiwSiEuA7VPHqKeFExIks2SpMXddE+dhYHHTujIRLGFohGHgm543PhMPre9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/FaIEpf; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756868488; x=1788404488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DvMR8USxNpbIE3J3di+0IdjMjduI7AikJCVYtJfhI6M=;
  b=L/FaIEpfZRPeKgrHwjI4kBYpk34LWFo3yxSCSxZf+yFkRp9+0igYtr2g
   32e9QoXJCzrilM/t0nl7n49d0K7qiErT2A/AngWq7ocwGWgxQ8mTgjQSu
   hL8rdjpk/o3Af3f1506+jep9b3aBWX7JB6w95aWcw2v5iun+Py6V28OBp
   MWyTCilK66C9DYnE9JKPsvPgVP69YzZLor2xaAddOym3RD40FXk2swKvy
   RNCOwFQt1uwqI+sn6zM9AoGxyZtrLubiB5no9Vz6loqOotGpcviRpf1Qn
   7tYNv1GvwfaSQahr+98HU1JPcVJoVbRQq6MG3W6kpAQIX7Wn7Tif7x/Gy
   g==;
X-CSE-ConnectionGUID: dQLGu+6oSbCPGWGS1KA2/Q==
X-CSE-MsgGUID: YKmiegCbThGNFhsUdKpkqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76771122"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="76771122"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:01:26 -0700
X-CSE-ConnectionGUID: osmDrin1SECw2iWZPV+gxg==
X-CSE-MsgGUID: H7p3fLvtRK+uSNjckL1hXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171345214"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:01:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 20:01:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 20:01:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.75) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 20:01:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgdchrQ2wZMhuNdwy7+YXjARTUIzLwIG3nKVYSOw5BpKg4ZmXJuZ+X73vk1Y+r5i685VggzvEI9OXnbhQSnbTOaGrUyZnPIGCq/Lrh8sacRRdOfX9t1d6iLbWE3eG2EL9Zil9a4fylk7OZw1KISyBOHtIe4umcMKtYW7E5QP8T5vOgPYhFYewpqZNUE+jMt4VXiZzMvROzD9/XxAQBHIDFQovT413xVONQremCMTPRe+fvh8vfPlETV4mMfj+Rw+Zuyf31TACaANlz1H757pFxEeyTRLaMeJ6Z7yAFYIWgedT8yFaIRjllbYa67Ag0rclSrti7s1Mpl1TGJY++04qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt1kpBBDqevMg5oZeIcw3VZtSgjmCF07UjcHEQ6qQeE=;
 b=CtgmOl5Yzlteq4ihzOv2116DE7Uq1CZdAxOx1Sf2/DleSkm7Ps19lBi5GIb6Vn5PQD7NwTXFXe+pxX3wfhrVjm0MV0sTE0IF6t6cNnYVcUmZTqBnW9GqXOWJjBS7fXVVph6rJ0OI4N14VOE2tpGkVH3yoiOSoFxVzWPTmi+b6Fdf0gDBkFUYk1ZsmJKFIVvmDTjGBlYcrQWeGfNyKy51xZFq38r8Wi4dVpw1T/HKXvR5921Y88HSiiXfCHT/q1x1M7T4WOPq5Slxr5IAKELyiMOoeNmfr7PDxuIr8lfUC7vPg9rvXxLWvmBkgFFnBQabwB7Z8gRN6KsqO0ysbYwjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 03:01:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 03:01:00 +0000
Message-ID: <a6477afd-16dd-4cac-8215-e0cf52246a94@intel.com>
Date: Tue, 2 Sep 2025 20:00:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 29/33] fs/resctrl: Introduce the interface to modify
 assignments in a group
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <281e3250d5fd715adcf734676c0e68f17a00fb59.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <281e3250d5fd715adcf734676c0e68f17a00fb59.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3bedd1-18a9-4ed5-0dad-08ddea961c9a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzlYWHN0djl2SGc4aEhXd1hJR1ZyOTk2V3JQRmVtMmVDU3YrYkc2TTgyV1dw?=
 =?utf-8?B?dFFlbUQrZ0lBenJEeS9nOXgwRjVyd2VXUWlVOVFCYTJzeWZDeGFCbmxmYnlZ?=
 =?utf-8?B?U3hSV1pqYUdWcXBvMjd3VHhFL3Jsd2h2YVJDNnlqd0JGaHpRSTM0REFuY1pB?=
 =?utf-8?B?NGRyTjRTNldzK1FwVlB5cWlmTURFVE1YTVBLaVdZcGtYNi84NHBDMzFMZURq?=
 =?utf-8?B?OENvazBUWks0SmE0eEl3YVMxWUErWVBFVnVxUWRuTUFYVmVWbmdORm9rQ2cv?=
 =?utf-8?B?Yk82MFZmNjNnZDNEck5Fc0hQWDRDcHc2aStXclpTZDQzaTVDWTZHV3c4QjVL?=
 =?utf-8?B?emNhS0xLVVhLdHdwMTg1Vm82bVBseUwrTEMzcWZ3ODE2RjRKK2RoMkROYUtk?=
 =?utf-8?B?anp2dU1XN0JBVG9od3FNczhsS01TWFRMSGZjd0NqRFd1NkhwWVU5V3ZOQ0Zk?=
 =?utf-8?B?WHdFczcxbkY3cEdSNkxHMzhROVBHcWZRSGR3M3RTRjVuV3RRb0FRdklLa2hq?=
 =?utf-8?B?aEs2bFN0UEt0aEJiSkNIMFZlbmlCVkdmT2RwUzdzWGxXYWR3VG9MbnlqVytw?=
 =?utf-8?B?bGJzQTI5eHlObTJTSXVaVDd0MU1lc3g4RmdDWG1UVUczUkR5MVo2d05hSzlu?=
 =?utf-8?B?cU1GZzRMNmtVMmpRZjB0Yk8wMzByOFBKRlVnazBQSlk3VW02WUxSOXJGTlJL?=
 =?utf-8?B?OXNFcGtuOUV0elNhdUdhV2d5VmtDbDk0Nm9DV0FWbVczaFNpUHB4OHFNUVhC?=
 =?utf-8?B?MTQrVEFrQWVmNFVOVVpMYTZsc0xLUlZMY3ZvODBHM3BuY043NUpaWVp6NmR5?=
 =?utf-8?B?S3NZTzFubXNuRHByZW5HREV6VWtMa1RjdVZCNXNCaW1HbjRnRHpPb0FGWnpu?=
 =?utf-8?B?dmJPTy9VTkZYaURiU1hDejA0WnFLSFpDdVR1dXY1QTJjT0w3R1d6d09JV216?=
 =?utf-8?B?WEpTMXovQkVDWEtvQlpMT1RVcTd2SDMzdHhzK0xsNHM4QUcwWm9ZZlBLdWZE?=
 =?utf-8?B?ZVBXNXRWa29GK2lYVkNsY1Y4RmgrWkF2RzVyb3Y5SE9mSlpkQ3dKU05LejJ5?=
 =?utf-8?B?NFJWWFJuY05Va3VURjFCenNrS0EzTUovZDJidzZ6REptYTkyM1RKV1BDRTZO?=
 =?utf-8?B?NEFRQTFCeWNYZzhDSitMYWZVR05IYWRmN3Jic2EyYlpDWjBqeHVyRlJ5WGZ6?=
 =?utf-8?B?VmYzSFhJY0xINHpQcDlQNWZ0blhlamlraGtPVnU5U1BoRDk0TXpVV29oZml6?=
 =?utf-8?B?TGFKTHpzMTd5NE85a3pMdUdGazVNNW5jVXRVWXhMV0xDclZUSFlhU3FqOXEv?=
 =?utf-8?B?ajZYTWNQZ0h5NzI1Wi9hZHowTThrVTdIdWdVZXQxc3NWMDJlbGxpNXcvL2hz?=
 =?utf-8?B?Nm4wTms0enR2UXNSZ1U2VnMyRWRTZ01aR2ZwVUYzdjJuaFpJTE52OXQzNUR5?=
 =?utf-8?B?VlQwZHBQWXloUmpOTk9FVXZCS0ROZlZ4ajhIY0ZGR3hsQ2t2eFBYR0NNZk5N?=
 =?utf-8?B?WWw2MkNrL1pnZlo5ZWk3VHFWNkNsQ2ZQT20xQmxKM0thY0pRNElXK3hxakNH?=
 =?utf-8?B?OHptRlVtNFdkeFUvOGxCS20rYytTUndUUlN3Z1R5Z1h1dVR1MnpaLzFIbFZm?=
 =?utf-8?B?OTM5ckVMTzRyMHlXM3piK3Vzd2hvVndBcUNiTTBCaG92UXBmMzNTTHF1OWZX?=
 =?utf-8?B?WnRkUCt4RnpYdGk4K1NEcXlzeXc0eFMxT2txenZNZFBtK2xmRFF2MXpnRFlU?=
 =?utf-8?B?bWg1TmNTQ21TU0srN09waXVYYm1JdmlFWUxLeWhGYlozejExb2R5dE0weUdu?=
 =?utf-8?B?WFlab0Uzdm51RGFKZ3ZXeS9HQWJCTTBBaGFDK1pmQzBQbWh4REdiQkdnWG81?=
 =?utf-8?B?YVhlTEpySHdQTEhpcXdHWnB6ZWJyZGxwQWptbzlEWVdZQkFVTzVYMjF1Ymd1?=
 =?utf-8?Q?FXEBqnxVJQk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXRGNG80MVQ2WHNMdzl0TkhSL0wzdXZ0dmE5VVI2d0xGaUNsZm40MkYxQlc4?=
 =?utf-8?B?bWV4UnlPL3B5Q1JOM1daUDZpUUw5OGNMN3dxQUlyc2VnTnNxblRUWlk0aExH?=
 =?utf-8?B?WWNNUGxsdXNSN0lmaDUzSVVQVTNMZHYrakNRWkt0YmgvUEVyWk80UHMyUXZy?=
 =?utf-8?B?dExPa0dTYjlWaXA4UmtRcEE5ZFRNRmZ0dGJzWlRGU2k0YnpiTVlkNVhuZ09M?=
 =?utf-8?B?QUpncElNUjRQK0I2L2dPb2NZcDkrUjY1dVgvS1huMHQwL0d2TFcrUHhQZTE4?=
 =?utf-8?B?Um9ISDd0aVlxM054YUNHbmJGTUVSKytqaXRBSkpSRXhLcGpKeG8ramRXZ1ZV?=
 =?utf-8?B?d1RPeHlnWXlmT2Q2UUEyQks0U2NGa29GcjdjRGl3aFp0YktHUkRZdkEwcGla?=
 =?utf-8?B?WUs2MktNNjJsQit1dVMreHhLYU9pbjFMdnB1bWs4Y2pjdEZSb0QvK0VBMktS?=
 =?utf-8?B?eXpQREZXempqanVBT0R6SFZKcHVQZzkxNWJzQWUvRjZlTWsvaG5NYUFNbURS?=
 =?utf-8?B?V2ZGSEhScVNBZStObDRVOWtvUUJlN2FmbWpnR3JFREw3TEtLL25uQkxkTkZn?=
 =?utf-8?B?emtOc0ZBYUdJc3Z4ZUFoNlJYY2xDbzR0eWp3YjhMbVBJMUljZGY2ZGNnU05s?=
 =?utf-8?B?ZkJPYzJuTEdMZFBqZEpzdlh6TVhpUFA2TXRjUy8wK0o2Q0FCUXhKYTBrSmFT?=
 =?utf-8?B?S285cC9oWjVqSCt4dm5ZaVVkUWN1K3VCai8vd2MvQXgzTDdjc25VWk9xdGE5?=
 =?utf-8?B?RVJsdEo2TmpkenoreXVhWEh1NGdBNEFNamNjSU9ZU01sTUtUNGtGa2Z0MHZF?=
 =?utf-8?B?ajRZaDhFYnc3Y0RlRjgxTjJuL2pHUGR3TkxyOERCMllkRnFWWE1aWHVESmdM?=
 =?utf-8?B?TnhPOWEwWmZYbVk2eFhIc29yV1Z1QnFxU3RTdW1SUTFZcTMwWkNHbXhqeHNv?=
 =?utf-8?B?ZFRDdWRMYlcyRS9xMzZoRlBBQm5vSUVSdW1CblpwRDg4RHFrVk1EK2VubG1p?=
 =?utf-8?B?S3puMGxjTndZbi9MeFRlaFp2NXFsOWxWQlhiNVAyWjkwSmZhYjYxclVwdC9r?=
 =?utf-8?B?aEsyQ1ZJcVNOQ2VpTkhiWWw4MTZNS0dTWlBRVm03RXJnaFVZWmc4TDVhQ0Vo?=
 =?utf-8?B?SXhFU2tTdkY1OHFUbnVRcDh5OHlPbDc3cTIwS3ZKa3V4TUxBZGYvNGV1QTdj?=
 =?utf-8?B?eDVYb3VKT1N1NTRITE9rMTMwN1NmUGNvQkFta0RnN3hSbUZLSGYvUmZLMXB1?=
 =?utf-8?B?SW5tVFFJdHFNUVFTQnlNbWcwcWxLa3QybVViV0paZERST0hMTkpZTVNVWUNI?=
 =?utf-8?B?TG50S2MxTmZ4c21NUVBNcXFRTjVZbVVJekJXREdIMWorZ3c4eXNnL0VjK0Nv?=
 =?utf-8?B?Z1YzWVlzaTEwN3NHcWJwR3Ayb1VNRjlQZFRSUkQraDBzajB2NTNsVEMyaUF1?=
 =?utf-8?B?TGN2S1Y2WXk5OVZ0NnAwSFJyQWFjWitwQXVYdmIvR3RNZFU3Rm9hY0t5NG44?=
 =?utf-8?B?MllLSEZwOGdYV3R6czNXcGZENSt2a05LZVpuczR6MVp3dFUzeGxkaFg1M09q?=
 =?utf-8?B?ZWcwLzl0WjhFZUVRQU9KVkwrREdBak1uT3ZnOHN4aFJCNXBWSkxVbmJrb3Ux?=
 =?utf-8?B?VGlHU2QvdFh1aDUyd2ZpSFFFcDdUb2pXc2Izdy9NZUJFY0xPTXlUT0RiVTdi?=
 =?utf-8?B?WVBmVThydE1VUXJzT0hheUU3V2NGV1hEaE51Wk5BTENDekNIOFJYM3RZWEdL?=
 =?utf-8?B?NXJPZ3ZVcVpuUk1vTGwyNUJnRkVnQmtrL3ZzMnFqaGJvck1RU2d6VzZlSmRY?=
 =?utf-8?B?MWRKSFZpajI0YTFlK3o5QWFsWWhISGUyNlRkN3NXV0V6dlNSMTV1akx1YTVn?=
 =?utf-8?B?bnVIQm13allhRFFQdjMwQWRWVkNTZVJPUXNPdmFNV08xaURGNStmdEYwcysy?=
 =?utf-8?B?M3lubzBPUUwwV0cyQlQ3UFZzTkZyV1o1UitiaDJYeE90UGhrUHREckNzNFk4?=
 =?utf-8?B?OTZhYXFzemZ4VXpQQTVtVld4dTFORWpLdWdHb3hZSUhhbGZwNjU1VE91cHNo?=
 =?utf-8?B?RHdKMTZsVXZKUG9oUW92WkFQTFNFM0FMZUlqRm81WlZSZk1Hb3Z3aEVGVk80?=
 =?utf-8?B?bHdubVpHNCt1OVJ0N3VoQXUxYTEyMzdCSXAvclhxZ3RFUFpZcVk5U2h5d1Y2?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3bedd1-18a9-4ed5-0dad-08ddea961c9a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 03:01:00.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTC1tV5rrx6D37iiG9JgCoQQDuxBDZPXNkLNje98dG3wiVQUJGhsbEyzebJ/c6LpWuR0Q3QzzPW22lcKVPmv/j+wge/GYQ0KJar46Rg/T0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7410
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> Enable the mbm_l3_assignments resctrl file to be used to modify counter
> assignments of CTRL_MON and MON groups when the "mbm_event" counter
> assignment mode is enabled.
> 
> Process the assignment modifications in the following format:
> <Event>:<Domain id>=<Assignment state>;<Domain id>=<Assignment state>
> 
> Event: A valid MBM event in the
>        /sys/fs/resctrl/info/L3_MON/event_configs directory.
> 
> Domain ID: A valid domain ID. When writing, '*' applies the changes
> 	   to all domains.
> 
> Assignment states:
> 
>     _ : Unassign a counter.
> 
>     e : Assign a counter exclusively.
> 
> Examples:
> 
> $ cd /sys/fs/resctrl
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=e;1=e
>   mbm_local_bytes:0=e;1=e
> 
> To unassign the counter associated with the mbm_total_bytes event on
> domain 0:
> 
> $ echo "mbm_total_bytes:0=_" > mbm_L3_assignments
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=_;1=e
>   mbm_local_bytes:0=e;1=e
> 
> To unassign the counter associated with the mbm_total_bytes event on
> all the domains:
> 
> $ echo "mbm_total_bytes:*=_" > mbm_L3_assignments
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=_;1=_
>   mbm_local_bytes:0=e;1=e
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

