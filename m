Return-Path: <linux-kernel+bounces-847681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002BBCB682
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1591A601AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7659F22CBF1;
	Fri, 10 Oct 2025 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRZNPl5j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA471DF963
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063057; cv=fail; b=Ez5uyr45x4gmx5PJB1c9NP4QY8lK12vE/FQQPDzo9e1qjpKvuOI5qPzytK6EmRx6rWpGi8FIjO5nHppAKR0L4YwwCWHCqwfxQD4B38r2we83+mIjN7jv0BbDG615jjtxOphhHuW0PlAT579hltkJxYiaM1nNau3Ilp/H1qJjoNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063057; c=relaxed/simple;
	bh=HdtDzDUIXZ35FLOr9TvhJD6BiYV3pV7qkInjUONGSfk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EO7GVa0bqMiQKmeOdsUAK1ApPffzAPENxC1NrArFGi8Urqi++rAyxMNVZmqrFS5DMKj7oSw3ujFCKqNCva1VwEBVg2P+S+VOQKUGXXj3BKOs05lFgAI63EsyFUwPNvTTMDY+wwfUtIB2D9zFUTWTU9Y1Kpy4DDbrbo8dZ/LfDWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRZNPl5j; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760063056; x=1791599056;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=HdtDzDUIXZ35FLOr9TvhJD6BiYV3pV7qkInjUONGSfk=;
  b=QRZNPl5jgCrzkWBu0OS9cC2wQZvWYDseES37dm8by4K61yQuksOkfztg
   uO0jyQ0q0R2c49OiFpmvGdlQKmwXMEO6M8nGRUQnx51409SSk/e5sRP+q
   y8CyusvY9Q5Pztqbg1Rs9wRqYP9cvFT8DOX6YSD3vQntJTQ+7QaYfmaRX
   WMHyh3D3nsW48Vy7fgeAQxPh1EENJnSlqzqUrRelBmIBLYe2UFf5nYSsn
   trajcpYEL0VObN3DLiLOyw1SGJwCCRkKdmg4GdlFrQToivIRjL183F99J
   eRiA1KHeHP9RddHBomBEFT3ap7WycBQ7L0SREz0fp7hlDyoHX90B2nGRH
   w==;
X-CSE-ConnectionGUID: xv312+0ISO+oJyl7kkX4Kg==
X-CSE-MsgGUID: h1AUI5HQSByaQHMpnx6RlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79725788"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="79725788"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 19:24:15 -0700
X-CSE-ConnectionGUID: GG+kLJZfTkakI7KFi3kLFg==
X-CSE-MsgGUID: ryPO/l1hSfCh+SBxQxUijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="184895125"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 19:24:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 19:24:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 19:24:14 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 19:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgPjnA6v0Ctgt+BuPbcAWhPGAZD3JKD5sHj6b88GmUViH+RN8GJkjexqC/xejDwIwLOeGYWr1ycwMpPivivGevZX9qmH1LXZvsh8WdTMhCC3hoOa+m1iDC3w93jTd5isL2GW+Ag7gQqN43g7BAsK6LX0XoJWdLQjflWyklHR4jYXVIBtSaUSLbE5zmyR/lfAtlBHOT5UU/xw0jnArIFIBh9J76n9kVTt0EgazntRHu17Y264MzhNM6yQLZeMkWl2cRXohUHoGlQzJwpFjih3/G/XnvMHhY6AU5YXWQc+TlxtPP6GRScTwDxDvmUZH+oyRLD6P+X++PgfZ+RKVQWpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc9gUCSuFfovuFbfHgn3qIjsxOqZ2OiWYe6mxl1SLmw=;
 b=a6RZlvf9P6a5wixb2BNGyAiHu9mvjomTyMf4lQYt+Vm7/RA1W9Irnp9aJDef/FJ5Dim4OUj162/TMK3T7sUjx+LPEZpm5JuKT2irwaq4ZtaAn5GjxJIo3LyAOI47CxvGWPHRCqFrQnWXZ3PdKiYd1ocGtL89JPN4O6W7YDW7exCmlE1nH3DXIyIK9VVqy2VjvuYfftuRlUoa/4AauduYx1VjTUWZ0AtSI5JIb/Cg/UYLOgTimsrkYtI9SFoTlydaU9OKnzDPhC6kSoZ+qOnENdCgbeY72IMv5j7H7TwCZnOqLBfb+Vuc0PclibryAuK+bOwP1Q+hftVw6yGGEfI2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5793.namprd11.prod.outlook.com (2603:10b6:510:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 02:24:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 02:24:07 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 9 Oct 2025 19:24:05 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>, "Gavin
 Shan" <gshan@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Jeremy
 Linton" <jeremy.linton@arm.com>, Sami Mujawar <sami.mujawar@arm.com>
Message-ID: <68e86e45599bc_199281005d@dwillia2-mobl4.notmuch>
In-Reply-To: <20251009113557.000053e6@huawei.com>
References: <20251008132758.784275-1-aneesh.kumar@kernel.org>
 <yq5aldlka6oi.fsf@kernel.org>
 <20251009113557.000053e6@huawei.com>
Subject: Re: [PATCH] coco: guest: arm64: Update ARM CCA guest driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: b52f4da9-af3d-4798-298e-08de07a41693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEY2czB5UHRoZHQ4RnJYWmpxOHBMNjI0VXl4cm0vaDF3d0VmaGk0R2tOc2lF?=
 =?utf-8?B?djhUS1k5YTBRdnhZT09PRVJMNmhabHNKVHllOU1LTmFQTGErL1ZPU1FCMzNK?=
 =?utf-8?B?aEpMYjBJT1NzcDlLRUVnTDRDZDJnVHVDUzFKNVNXdzREaVRQVzdNbHBtdnlE?=
 =?utf-8?B?bHpvdG9Ydjc0ZCszTlh4bFFaTGpaZlc0Q2JvSjRmMVNyOTBwTGgzV3lEN3ph?=
 =?utf-8?B?YmlKcDNmUUVhRlY0TUtBb1pGemxSWTNWSzVyMFpUblZEL1NoL0RGajdENXlu?=
 =?utf-8?B?NUN1aXBrYzFzUGJncHFEQ1ZEOURJdjRJaGo3RGZtcUQ5N2VoOGtHb2ZCT0Rq?=
 =?utf-8?B?N1hSN2FSc25TbHFuang2WVhSZlhaZE5oYXoxYjJXQUJTYW9uT2k3NHJTb2Zr?=
 =?utf-8?B?ckVRZjVoQWxYdFdiQ085Vk1TQUV2ZCt0U0hxQjQxMWg0TWIxZjNpa3Z3cWlu?=
 =?utf-8?B?WUxWSlVvSHdRU3dxMkFOZmxiWWVRVkRvV3hxdFZUZXpabDUxRUVxMW9pTlNX?=
 =?utf-8?B?S3A1OXgxUFVSdE5wbEt3WXZPdG5PbUZEaTF5ejVRdzdWLzVGaWdkMXdMMFRq?=
 =?utf-8?B?OTNxcUN6SWMvcG1xOXZjOFVRTGpyblJLdVM0WS9uUis0a0dnbit6MmtzUnZp?=
 =?utf-8?B?NEIzVUZiQ1Y3N3RCNjkrbVEraVM0ZU05WUxYcjIzVjUxdjlKR1hkT0hsVHZh?=
 =?utf-8?B?SXc2V2JxS3FITWlMSHNkK0QwNS92bExGVUpnMi9qcE0zRnJRL05BcS9VUnpP?=
 =?utf-8?B?UDlIV0FFTWp3RysybS9GdWtrVmxYdXgzLzUxUm1FdURVditWY2lmMmMxOU1v?=
 =?utf-8?B?RWEzS1V0b3RkV29hU000YXJ5aERRWCs0akZReU9NdHhNRFFZZko0em5LQnJE?=
 =?utf-8?B?VjdhZ1RHQmpqcHFtWkpxR3orYnppdGN2MWlpNG84QXJKalVQdXV5cnludVRV?=
 =?utf-8?B?NEpKL1o4VjI0SEM0TFlOUW1wNGFYcnEwQlVMN05UYW9WVExwOWJQZ1lncVFG?=
 =?utf-8?B?a0lYdnVpb2ZXK2w1eDZwUUNGbkVGWlJOMWdwdmprbmp6MlZxOVpNdmFEekZv?=
 =?utf-8?B?eklVVHZ1MUNGZWM0Wk5lenJsWEd5MTBFREFBMThibDhlMjVwM3I5Wmczdm0v?=
 =?utf-8?B?SU5td2hDd2FGeXZ4YlNzQzZualdFR2c1eXVxb1Vpa0lIVEM5YVB3SE9lNTA0?=
 =?utf-8?B?TW1kK2VPOE14TlpuTk83SjNxVjN3dVY5YUNNa2J5KzNsZDM0OG1UVC91dC9X?=
 =?utf-8?B?RVIvSTBxamdHMVBWMjJ0M0RrRy9yWFBHUzRrSWxud0VXTUJicTM5R3FFb0RV?=
 =?utf-8?B?c21sUlVOSm00YkdDV1gxSWVjNDBNN3dhMHZIM2ljWmUyb2V1V3RGdGExbEg0?=
 =?utf-8?B?aGNqM3hIc2dUZDdUMWl3T0M2T3N4WmpyWTBnalpRMFUwN2s3K1ZNRWtNZGxF?=
 =?utf-8?B?cFpEMU54QTZ2QTdpaW5LNmtLTzgxNHVGekhRdUVNdDRkdnI1a25BV1R4ZVhG?=
 =?utf-8?B?QzJaT1NqS3Q5azdtMjFieXZ1L0s4Mm5nZWZtWEl1MXJqaDNSVXdRN0xLdWdK?=
 =?utf-8?B?Si9SRk4zR1hDTkdxYkVaOXJ1dVZMOFpwTEV6MXppTWFsMjdVWVlrWlluVk1t?=
 =?utf-8?B?UDVYdVNqaitHT0FsY05QdGpGWVI2Sk11czlWeHJBV0lqQ1hmdjU1V3BTc2Zy?=
 =?utf-8?B?TWdMNE9uVXovZkZCeEc1UGwwWlZqUGU1cTdpRW9XQS9yUDJ4K0tCbGUrcm1x?=
 =?utf-8?B?Q1hTMndLNnlaZ04zYkdTOFU5eW9TSGJmVUkwWEZpUHBxWURwTGQxY1YwRGZ0?=
 =?utf-8?B?TmtyK2RnWk9UMVBoTTNRc1loS3ZYWGg2YkdBNXp1U0drRGxTZzVYckZmcFpz?=
 =?utf-8?B?ZUF4dFhhVWViZ0lRTExuUlVHUTdBaVJBaTdkQ1JFSG5iam5oYjZOM3BkSFBz?=
 =?utf-8?B?S2lWbzNKQy9kUnRPS3BaYk8zVXJIMHlsbDAvdUZJZHB5ZThxNlFZcUp3SjRF?=
 =?utf-8?B?N2UvK2xqUnFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVA4WFlSRmRsYVorcHZ3d29IYS9ONXpOOFludmloZjhuUmV3Z3ZLa2ZrbG41?=
 =?utf-8?B?aW9UUmZDaGlHcnBqbS9WSzlBRGZHNkc1NThjUTRVVnp1NXJjdERFcERzV3lD?=
 =?utf-8?B?M3ZyWXVLbHlrRlByOXpmZzYrUUI4cXR2L25TcTRvYjBaRklMVkpvYTYvS0g3?=
 =?utf-8?B?c2pnWnhxeVpCNzZ6MWJncXVaWkEwNjVVN1YrTEo0SmVnUkMybC9nbDZHZG5z?=
 =?utf-8?B?djZ3bDZvNmJJL0NXTmtzNnN4bXdtOFFqTk12dXErUVVZZ2JHcHVwUWc5Z3Iw?=
 =?utf-8?B?azFRS2h0dW1nL3FqVFVzRmpoM05RZEtmUGpZcHQ3c0tqYmVjRGVpa0F0eXpR?=
 =?utf-8?B?ZFA2RUovTExYZnJuMjhWdVFFQmNEcVdvTytWUWhFQmxYdXZpWlNMWnRXdkxZ?=
 =?utf-8?B?cnVqM3drM1hEVFFsTUVaZEZ5bUpqT1FJODZDbk8xUEx1S0R1Z01UZEI4Nlc3?=
 =?utf-8?B?SEpNaXR6b3NYK3ozOXdNU2JFWUxKOWhOVDFYNCtXWWpmQS9MRVhaSmc3Z3FR?=
 =?utf-8?B?LzY3TDZmL3J5ZmRkNnY2ZHlYbUtxYVluejN0dmx6LzVpV1VzR2Y0bGZ0c2VK?=
 =?utf-8?B?dnZYazEvQ1psZlZVNXFXR0RESzNUcmhVSFlGK3VPNEpBak1WUG1jVlNnQ3VI?=
 =?utf-8?B?YnlkRmFrMVlYUUNxa1hjbWdoVE13bmJqdHdCUGhRRVRWUkcrVkV3bjkrZXRu?=
 =?utf-8?B?aU1xTy94dmorTjBpekwrRTFGN1ZCU0Jpd1Y5VFRjVU5iMy9tRG9JblEyMXlI?=
 =?utf-8?B?ZFZiRHNyOUllUG9Gdnpwd2hjQlArNWJGYk8wRklpRFlvWHRPQStKbE5ZcmRS?=
 =?utf-8?B?MW9wc2RIeG5yMWVPUXlKSllRTTIxVnowaUh0ODc1TExuQms0WGk2ZzZQdkxV?=
 =?utf-8?B?RHFIWTJQTUNpZTVPMFhRWW9XVzFWbUJyalJ4VzdxWGRRMVRZTzJXRnhObjg5?=
 =?utf-8?B?WVE4UmNJVnM1YW9RbjBMQWUrSXczUTdoaDZtMlpGbkJqLzBzbDFXNW1FaDNK?=
 =?utf-8?B?cUlnNjhqbnR0aWJKWW5PSm1WbEU0RjFmUUszcERseUNFSzdkQWNRb1o2TnRY?=
 =?utf-8?B?MktRbUlnbU1XQW5MN3lWZHhldlJxeU1vcWl0aUh0Y3ZrRE1qQWJrNFo0cDli?=
 =?utf-8?B?TTExOUtmTGZvWU1uQmlqd2pBRU1GeUdYdDFlZDBES0xHWWVUc0JocERRTmFX?=
 =?utf-8?B?YzVXenRtbitMUlhiTG5ZNDJWbVFBdENheE5vL25OanhlNEtXb293Nk1sKysy?=
 =?utf-8?B?bzFGc3kwcEZLSjNPSEt0T0VsbDczNHFwZ0Z5alpmMzM0cjFsY2EwQUVob3Rr?=
 =?utf-8?B?dVJCT1ZNeFIvWlBCUnArNWVxdTgxM2h2anJMdUR6SjFsNXBNNnZsdGt0czQy?=
 =?utf-8?B?bDN4OEI0am5kTnIxNmxIM3ZWTU5ZZzRxMUxhZTNsR3VNM25ic21HdWRmQzk5?=
 =?utf-8?B?YkRTTVJabnU1cTVGVTBqYzY5UzNIek5TRFA1WXRSMFpLZjdSbld3NjFJVjRF?=
 =?utf-8?B?Qkl4ZXo5bnRJMm45T3NZM0FzajFDWHYwa1BsK3Z3MWl3WGczMTZYZjcyaTFt?=
 =?utf-8?B?bzhQaXhVTjVyYWwySkh6amdlVFM0R0NLQkN1bm9QU0xCQmlwdGp2ak9iQnhJ?=
 =?utf-8?B?VWJxZGRjZWhYaXUydXBGNlNGNERtdjliNFFvdVM4dDBySDNPZDlxWGVUM21k?=
 =?utf-8?B?SmZZUnJaN3BjUGoyNXhRUXB4M29hMFR1MUt4MEtvcHd6RzZKNjNsTXJrTkg3?=
 =?utf-8?B?WWR1M1c3NVN4UGRvWENBVnJmVkNrOGZ0SG5kWHpDQmt3S2VJMExPY09KRUVu?=
 =?utf-8?B?QTBhNmowRFFkZWtpZldzWDNVNHVCQ0pUM0RLczVabXZqK1FYZkF0UnlZMC9K?=
 =?utf-8?B?UkFackNoVEl0MGVCNUpacW9HZ2lrYmIwL0paaHlGNmpGMDZkclJFYTJkV3NI?=
 =?utf-8?B?Z1lOMEtnKzN0ZTM4NmhhSWRIMUg5d1VZekM3ODMwcVFnQ1F4V0Y1aTBUbjNC?=
 =?utf-8?B?OWEyWDZHWmtIWk5oZTRjNDJrRXB2NS95dzVNNkpEZHlFdSsxLzNKaTc3NUVK?=
 =?utf-8?B?ZjVQRmdVNERWZ05wekRmeXpkdTdBUUxadUpVWGx3WEFnZjdzQzBPeUxvZk5z?=
 =?utf-8?B?UW9WWW5qU1RKa3JJeDV2eDc0OGEzTGlvL0xGN3QyNkwwRWE5bzlaSzQ1UTZS?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b52f4da9-af3d-4798-298e-08de07a41693
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 02:24:07.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMHygRAT3MEsCHAL5DEmsPhpF9HepPaEOePYAkTiajlUvuZiN0DsSVSbzjgjJAfPhrI+dkZwyBrejX3JTkd5xuiE1meltfoHhvZKWgs5x/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5793
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 09 Oct 2025 12:43:49 +0530
> Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:
> 
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
> > 
> > > Make preparatory updates to the ARM CCA guest driver:
> > >
> > >  - Switch from using a platform device to a faux device (based on
> > >    feedback in [1])
> > >  - Rename the device from `arm-cca-dev` to `arm-rsi-dev`, so that the
> > >    host driver can register an equivalent `arm-rmi-dev`
> > >
> > > These changes are purely structural and introduce no new functionality.
> > > Subsequent patches will extend this driver to add guest device
> > > assignment support.
> > >
> > > [1] https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh
> > >  
> > 
> > I noticed that, this will break autoloading of the driver. 
> 
> Ah indeed.  You'd need to arrange for the arch code to call the init()
> directly (possibly arch_initcall() as before or maybe directly from
> arm64_rsi_init), which makes it tricky to do in a module as there
> is nothing to kick off module autoloading. You could kick that off
> explicitly but that's a bit ugly.

Does ARM64 not have the equivalent of MODULE_DEVICE_TABLE(x86cpu, ...)?

