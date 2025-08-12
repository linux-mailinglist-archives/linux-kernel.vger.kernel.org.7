Return-Path: <linux-kernel+bounces-763830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02AB21AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279F83A8E58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978342DECCB;
	Tue, 12 Aug 2025 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUMhNaBy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039552D8365
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754965625; cv=fail; b=Yao12ZnqykB1DTnbGucrhirZkq1Z31EmuS3g47CiJdUEArpGOIONGonrEkAecuhHsMZSS8u7aKKelAnlcA/G9Hc1hTQtyEOMsRtQWQtFNh5ILZq1jC4zAyNutOYa67VwH2a6vv1T8aXjf9xJwo0mPALWQ18SsCsM8A/vKtluP28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754965625; c=relaxed/simple;
	bh=b+O0jn9q6d3KZu77el/7e9Q3P73Tx0OsEfNrdGP7QW0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UH03IW66Apv5vNvH+mhmqwscS90HFPL3jJNN4xX0HQm0vjxPgiePmBZmzAs4IEKwm3I9T2nKhjg7Uny4csH/sQUxeC2kNIVCTkS2rKIZN/4bpw0zoMYingY+fqFhA30iKkxfAEHZeJcrX0kEx8VZEaJ/JXQ/Zd5qRJhLxunR/Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUMhNaBy; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754965624; x=1786501624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b+O0jn9q6d3KZu77el/7e9Q3P73Tx0OsEfNrdGP7QW0=;
  b=eUMhNaBy/VCdbD2YRpbGxny6jgvHSYrsk0KhYjQ85/C6wmEyVLK/gilu
   vSWkUUR3580KdglC6Od2g57bSyXGG3mnCipVzhKee6eIggYRgqoNktihi
   +JaFtlVeDX/gTU4kpP3aaEQ4sX1m0WqEaRMA1HnUF0zWFaTvF5HXCdb55
   PFiDlNPOu4B2eJqeY0PvLxABAv7/YACQOnQLFzx3WEYN6nFkNP1zU4Slp
   74YmpAaM81l/m3iaMkRnZ2mdgO6IweA5C5owVBSyCc4M0gcS9SkJAfHZ0
   XajSN7XlJ39UoPDiJnkVoYjqy9UDscFzreV4t9jKqQs2ueNiKlQnrhdbB
   A==;
X-CSE-ConnectionGUID: ctAVw2iaScaSPVKfQBN4XQ==
X-CSE-MsgGUID: 7JquGzFtQcqg2Y9w+nu0wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="79801071"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="79801071"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:27:04 -0700
X-CSE-ConnectionGUID: MHIZKTIlQF+fpRI0qYvt5Q==
X-CSE-MsgGUID: Y0/ped6dRnq1GPhK/rrcDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166067070"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:27:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 19:27:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 19:27:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 19:27:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odkYC7jVCsEUZCGRbZzIdX5V4TV5iKa21MBTD84d1NRUJa4zZ30oxlrxMyJjd7/hvKA9ikBEcAUHaoIofSQaDGxDb1bIqgse/5Bec84UYayuxmPBe8D0KovxADiTPZnlZGUtOQeRJzYPkLQ7ItgZEImN8JQNc/v0r0vwLdeGk2bMykU48o5yBEnpQ0AbKhOgTOw8ffGRMqCBMw8mpT2P0o99kxAY34XBFNAvEQe48YKhEsQKn/IemVvOYcJZd2yLNApEjfUP5LPlqtNGY1L3DmFSFK5X58LPtY5WhUq8hzSaUiGlzxKVZXryi85dPPfQoKbLccdlND2O/LnNJNd0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KGSbrLS+1+tzvJtmMCUqakPgFSgs8ZigqXRydawiY0=;
 b=bdf51oKUCyXcCtHv946xTxo1yJ19rxr908MKjyrz3KJDvWmBAhR7KLeNmFNQCUcbTQjbhtZITSEmVHLaoVnlHu8+PRmnmM6A94wmPA0yEm1698nozia4PnY8sz8JfqCT6nmFQsm0xjuzQq8dxOharUdHNPrRARPWNTCoNaUaA1qBRgSWrTlavP22thykHXncQ2ru5nPoWxwNXujcQo4FS+CGwvc7EbuueXw9un0WqRxRKLhFAIj4xdsksIBBpwGQavXSVaDNYWL+yfV5RjRuAJKtjYw5hUaGq6D0cxfSTwSo6Pj94zdXbYHLw37uASFqJHoS/6aWXrU+LVZTQi8ZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS7PR11MB6151.namprd11.prod.outlook.com (2603:10b6:8:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 02:27:00 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 02:27:00 +0000
Message-ID: <f641cc0f-e542-45ef-bdb9-d8364860688e@intel.com>
Date: Mon, 11 Aug 2025 19:26:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
Content-Language: en-US
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)"
	<bp@alien8.de>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-2-bp@kernel.org>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250809094206.28028-2-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS7PR11MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 704e8950-93c2-47f0-6a2c-08ddd947b7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3hUK2oydzBncnQrQjgvQ0xvZ2RNTlFEejYrK3YvUUdTMkdFY1BSTDNwdVRK?=
 =?utf-8?B?eEFBQnpWMGlXVmpNK1NYWTN4QXNraGZ1QXhabGJ0WTc4YUlCMnpkc01sOXl5?=
 =?utf-8?B?dHJNMFdXa2xETW5PZVI0Y1ZHNDAyeGdCQmxRMXR5eGZWVWEzOWI4QmpsbnVL?=
 =?utf-8?B?azF0dVRXak96NVBZTDd1a2Z6b01wbHFNYVd0d1BUTzVndVMzN1JXUzhmKzli?=
 =?utf-8?B?SnlHK251Yk1INGZBb3diOE1jTHREQ0drZXdDQnQ2anBsOHc4YnA3NTh5OE8r?=
 =?utf-8?B?aGpuMUZFellYeXMvNWtma0oyeGNuU3kzdXIvRm1MR2hGM251dlBYVEFQejEx?=
 =?utf-8?B?eHEyN1prd3kzWnROMmRPNXE1eEZXZjlselA2S1Vya2ZvdzFzZm5tQzB4QUJV?=
 =?utf-8?B?Z2VSTzA2UzJmbGNPdllsc1dKb3ErRkREUkduSCt5VElaNHdrb1k0MUJ0Z3lx?=
 =?utf-8?B?Ukcrb0xXRWJOOGlVejJRU2VFL2tzRVR0Y3QwUmhsZlA5aWFJdGxGTjBQUWl1?=
 =?utf-8?B?dEhTUnhLWmcwZklFSG5qejA4eEI0MjR2V1E3dVdWSlFISXJpYmJSRERrYzhX?=
 =?utf-8?B?Y3M5S3c3eTB1WWFUdURsMEtOdXRHSVNJdEExeHRpR3dJcVFWeGVRcXhUSTZ0?=
 =?utf-8?B?bkRIYTN2T3pIOTJ2KytuQkE2VHhuZ1Y0cVB5SWVGQUF6NFRSNldxQXp3UFhx?=
 =?utf-8?B?Y2xtQXRHdUFua3BHS3NvOFY0b2FDeUJjR2ZaSGtLSVVpWTZkbDJRZS84RE1W?=
 =?utf-8?B?bDdneUJIeENua0NIUERGcmpjZzc5UEFRRFhaMXVpcUVFSkJncVdSclBpdkt0?=
 =?utf-8?B?NjVSMVp0WE9nNldDZTVyMy9jNDQzcXppcWRYcU56RVRrc2hzTUJUaDFNM29I?=
 =?utf-8?B?emgrekJJL3oxY0F5MmdHZ0tLMzVjeStlcTRUVXRtL2NoZHU5YndxU3dqZHBr?=
 =?utf-8?B?STBuSHFmN1Z5eDVXQ3l0NHdqbmhwWWxCWEU4YnJvT1JEM0RJM3FFbDByTHJl?=
 =?utf-8?B?cytIdzlnUWh5RFI3TjZWNXFLc0NTZUJuVG1nWlBMLzNvUXN1UjZUMGFwY3dE?=
 =?utf-8?B?VlpHbGhoa0NmdjBOdm44ZFQ2Vk5hbTljRXdGelNlK0V2YUJEUlZkRjBCM0xz?=
 =?utf-8?B?WHNab1V3NG50Q1dtWkdManFwQXNUQVFCWHYvWkhxT3hwdXQrd2k2eWpuelhB?=
 =?utf-8?B?WkJ2KzZ3MUFlcm85ODU5bkZNNzI1UFdjVmh0THZCK3hwOTJoNGNxWUFqcjQz?=
 =?utf-8?B?bzkvM2ROVWVhZEpoL3NhRHR2ZmUxUzh5STVDUU4yOUhEVVZnVXRSeDNlaGNi?=
 =?utf-8?B?UjJqK0NsUXg4Rit3VDg5SUJRRE5EWnlWam9DWlpienpQU2NhMVRpTHNqdnVH?=
 =?utf-8?B?bVBPREQ2eVpSejNpTkVEUFdBczlxRFEya3diN2w2RUxSeGlaQ0NSMlpLZHRz?=
 =?utf-8?B?VWc1ZVl2cE5Qa3pFWmFUWHlhVG9Va2dWdmFOVE5lTmV6Z3VZMk44Y1cvblU4?=
 =?utf-8?B?OUNJbFdKbHpwOEpZZXdqekorYThxazZiTDVWdHZMYUNNcVBDUXJjcm16OFYr?=
 =?utf-8?B?QzM3ajlwZWswb096TFlqN29HNUFYSFR2b0s3eXRNbzBhanZySHg0WUpKQnhy?=
 =?utf-8?B?VHNEallNSlJkMzBHT09LN0ZObGs3TU5rRnE3TmQwdU1RdTVuY0Vpa1g3VktF?=
 =?utf-8?B?TiszWnFVcjNHTTFSQ2dSSWYrcDhwUVFFeWMzeFhPYWtkcEdmUWlNNW8zQXAy?=
 =?utf-8?B?S09ZUTh6dEJkRUg2U2JDOTV6eVdqWUVKMlhHb2Yrcm9lNnFUYW03cjFVdWcr?=
 =?utf-8?B?NGY2YTN2QWpRY3BiMEVCWEY3QjVhMDZBL2ZVNVR6TDdVUnVRckwxV2pCdm9v?=
 =?utf-8?B?Wit0TWVULyt3QmRidkpualQ2QVVBajdVZEFiT0kycDE2V2xRUnJHMndrNmt0?=
 =?utf-8?Q?UXmyyYIb9/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFU0RHhnR2ZwQVZ5WVlEeTZMOXRiQzZkaXBrUC95T1dJRW5RVjJZOFc5dFZk?=
 =?utf-8?B?bEZZUDVYZHcyUCt2dnpyYmNZcTNDWW5Pb3hDQy9uS25Wby82RTU1cDFRdXBZ?=
 =?utf-8?B?NWFKS1Q4UGZqdVhuZCs1eis3R3pGUW9lZUt6cnZDQ0ZTcVd5VWJqZW9Hb1RY?=
 =?utf-8?B?V1ZCbElMc3VPQXRjQVk3anRVNy9RcVFicUFXaVFBRFpaY0VWTGFwRG1LTGhD?=
 =?utf-8?B?dTExZUZpN2UvRUNndXFSVk4xb2FZK1NrdTZmNE9BWGlrYWo2bTBPVDNpeDZG?=
 =?utf-8?B?ak1rWW4wOXpZRVcwRmw4TEVOaE1PUTBvY1g0TmI3YmNUc3dha1pvaUNJblVF?=
 =?utf-8?B?VFBqODVuNlJTb1pDRys0UzhDQWRHc1cwd0hUby9GT1oxRk1wbGhHOXlMZTMx?=
 =?utf-8?B?U2V2QXkwV1JlZEs4UUlnMTRRV1h2KzgyUWtiU29Gd2RiRlNtVUV2dkhsUjlS?=
 =?utf-8?B?V3R2d1lGOGtKMEhHME85enc5R3FDSVNkYWdKNVJEQUh6ODltTnMvZ0YzZU1z?=
 =?utf-8?B?Y0V3Z21pbWRYaktLTzNBTThDeEQrbU5mK3kwbGdqVnJWWS9WeGs3M1BjY2x2?=
 =?utf-8?B?RGowdEE3MDNVVnppcy9kTjNxRUlBRFZXalpxaG5wQzZiUUhOaW9mL2k3a01v?=
 =?utf-8?B?dWNEZkxZdFNkdDdWdzhoV01xMkJTZmIvMGF2NmcvemxWa20zY3p5ekIydVJt?=
 =?utf-8?B?SnFVUFRlSytEaXFXaDhoMG9iS1EyMThhSlJ3bDZzcjcrT3BneGt4eXE0Ni9U?=
 =?utf-8?B?amNPZTNKb3RVYkhHUVJ6SlEzZ0Z3NmZoWVlaaXJsSm9SbGhUWDJ0QUI5a252?=
 =?utf-8?B?ZzdNd0FUbzlEV0dJZ0huSWxRV1BocUF1OW40M1lDRjhTdUxQWVhFcElyQnZ5?=
 =?utf-8?B?RnVzMk4rRlQ2aXdKang3eVdoSkZTMW9hUXZxcFg2S2JOVmJ4bkxTSEUxUWtT?=
 =?utf-8?B?Sk9iRGhuZEVmUlROMTlPdGxNR1NZbnRrRGcxbTN3bld1ZFNuY2RJRVJxK3VQ?=
 =?utf-8?B?R093U0Z5MFlOaEcyL1hSNFpQY2pJV0d1V1FpL2FqTEFSZG5UaVpKQWw2d2VE?=
 =?utf-8?B?ZTQ2a0NIYy9lbGowd1NzOHRMMDdsTEYyZFFJeDZTYjBMdFo5bU5GRVh4UThY?=
 =?utf-8?B?ZkNUZWdWcWV6aTIvK2ZRTW1XN3NKSlp2bzc1SGIrRjVSeWNOTHlFNDFYSTVV?=
 =?utf-8?B?S2djRENmWHZES0djbFNJNkdJTkxzZGNHdDduN2s4MkloS0pFUEI2YThPZnEz?=
 =?utf-8?B?THk4MXh3VG51cXphWnFBTFFPcDg2TE5zak9MZDBRdmQ2dEhYNm1xb3BMTThi?=
 =?utf-8?B?SzZ1S2d1OWZ4Y1RlbEFMVzVoaUxYSG9ZZjFCcHpjZmFDZEUreEZMMEpla3ZS?=
 =?utf-8?B?a1hvU3p2QVAwSXhrT1pIemRUT3F4ZlNXMEJHWkQrdVVwYk1kaUQyN21FbGVQ?=
 =?utf-8?B?Y2JMMW0xT0NjMVhqc3JsV2RoVnJzQUxybU5YWVdkWGtSYUFxelh6K2R2SVlN?=
 =?utf-8?B?U0hUS2V5UHgyd2FNeW82aG1XVXEyeTcrdFVNMnVPU3ZwbzZNaGFjVHN2d0Rj?=
 =?utf-8?B?VUpLUlRjQWNiaVdDTTB2UkR6VjBSNXFWZytaYUNmQjI5UFYwZWpEUWZKTEZB?=
 =?utf-8?B?WGpIRDVSL2VNYTN4R0RXQ3BlZ1dYS3F2bmowaExLcWV2QmFPcDJEeFRzLzc5?=
 =?utf-8?B?QjNNb1RUWG1LMC8zRkxqVmdCME4wTEp2MHhwc3F5dEoyY09rSTZ4bDdpNE9Q?=
 =?utf-8?B?SXVad2ExZGJ4L0M5U3E5RzI2WW9adXJCempRMGZ2Z0h3dDlpQVFxYU1xTVl5?=
 =?utf-8?B?cGZzekUzQ2tkWk1ydFZKcGljT2pmekkwZEVCWTZSVVRkK0pSS09rcEtxdTcr?=
 =?utf-8?B?QzR0b0dZUEFrdm9VS0d1dE41eFRjTGVmdzZtSmJEelloOUtNTm82LzIxVEp4?=
 =?utf-8?B?L0tJOFFyWGZEM1Q3ZUduNjVaMHZ2ZmZDbWIyeHc2MCtZM1lnaCt2VEIrSWZL?=
 =?utf-8?B?ME1KeGJaSHBIcnVTZ25Cd3lCMW1FNWFTczV2d1dUVWdsd1lTMHN1YnRFNnhS?=
 =?utf-8?B?VUlONW0raVJWQ3RqVy9neUNjcFFJSnc5bWF0N1dVa3ovdk5KMHlod0xheFA5?=
 =?utf-8?Q?yayE243iRv2KKAWobsR3xmSoF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 704e8950-93c2-47f0-6a2c-08ddd947b7b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 02:27:00.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr4HQu7IR4OT9JgWFm0DunFDlzN/bZn6g7i3DjqztfWrz9H4vmJwvuboimcQZJFUWx0ffbMwKP0P8W11kOXpSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6151
X-OriginatorOrg: intel.com

On 8/9/2025 2:42 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Add a "microcode=" command line argument after which all options can be
> passed in a comma-separated list.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 +++--
>  arch/x86/kernel/cpu/microcode/core.c          | 30 +++++++++++++++----
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 747a55abf494..7c095177da85 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3767,10 +3767,12 @@
>  
>  	mga=		[HW,DRM]
>  
> -	microcode.force_minrev=	[X86]
> -			Format: <bool>
> +	microcode=      [X86] Control the behavior of the microcode loader.
> +	                Available options, comma separated:
> +


How about adding something like this to encourage using the new options:


@@ -1211,7 +1211,7 @@

-       dis_ucode_ldr   [X86] Disable the microcode loader.
+       dis_ucode_ldr   [X86] Same as microcode=disable_loader.


@@ -3770,6 +3770,9 @@

+                       disable_loader
+                               Disable the microcode loader.
+

> +			force_minrev
>  			Enable or disable the microcode minimal revision
> -			enforcement for the runtime microcode loader.
> + 			enforcement for the runtime microcode loader.


Unnecessary whitespace added before tab.


>  	mini2440=	[ARM,HW,KNL]
>  			Format:[0..2][b][c][t]
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index b92e09a87c69..351a51861f00 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -43,10 +43,9 @@
>  #include "internal.h"
>  
>  static struct microcode_ops *microcode_ops;
> -static bool dis_ucode_ldr = false;
> +static bool dis_ucode_ldr;
>  
> -bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
> -module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
> +bool force_minrev = false;
>  

Setting this to "false" is redundant.

>  /*
>   * Synchronization.
> @@ -126,13 +125,34 @@ bool __init microcode_loader_disabled(void)
>  	return dis_ucode_ldr;
>  }
>  
> +static void early_parse_cmdline(void)
> +{
> +	char cmd_buf[64] = {};
> +	char *s, *p = cmd_buf;
> +
> +	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, 64) > 0) {
> +		while ((s = strsep(&p, ","))) {
> +			if (IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV)) {
> +				if (!strcmp("force_minrev", s))
> +					force_minrev = true;
> +			}
> +
> +			if (!strcmp(s, "dis_ucode_ldr"))

If you agree with the above suggestion,
s/dis_ucode_ldr/disable_loader

> +				dis_ucode_ldr = true;
> +		}
> +	}
> +
> +	/* old, compat option */
> +	if (cmdline_find_option_bool(boot_command_line, "dis_ucode_ldr") > 0)
> +		dis_ucode_ldr = true;
> +}
> +
>  void __init load_ucode_bsp(void)
>  {
>  	unsigned int cpuid_1_eax;
>  	bool intel = true;
>  
> -	if (cmdline_find_option_bool(boot_command_line, "dis_ucode_ldr") > 0)
> -		dis_ucode_ldr = true;
> +	early_parse_cmdline();
>  
>  	if (microcode_loader_disabled())
>  		return;


