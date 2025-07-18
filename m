Return-Path: <linux-kernel+bounces-736301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECFDB09B42
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48DF3AD750
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CC1F0E55;
	Fri, 18 Jul 2025 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmT4ayXT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A911C861E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819705; cv=fail; b=ex3vI0aBtHUKvBt/5fpq94jaDLCsT2n4jY/3diFO4lopKju2vW3scP3wz3SNCI3IfM6oL33KTfxvRgOdQEvBGtpBRfU87Vt1pViTpjP51MetigfbhGGQT+KA5uiRrNiZML7tog42yGt3DmeTyZ1r+fV3B7J2Bhn0WT/YoxiUWuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819705; c=relaxed/simple;
	bh=4ku7IRj4D64/i/U253MpJm3W+ietCVg3TkVEympafBI=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PpVEdXkCMiEn6sCLyAOpY0ZfP1OPMRMNP6SwLscnEPYhCfcNk7a9j+myzkyT+CDhL0/OGzUFosZ8dRRUXGAjN3aE29F3PXnkJwkVd4VnMffDqQ/NvX5PgIJ0KIbSvqW8nj6Ka1xW4j6wK3GuR1qiAWFdlzNnFmZI+eL1TdXl7UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmT4ayXT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752819703; x=1784355703;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4ku7IRj4D64/i/U253MpJm3W+ietCVg3TkVEympafBI=;
  b=HmT4ayXTasY9XtwwVTkArijj5MdcPRgLIjdBYpJofJV8iWSx6BI2BTEe
   uajLILiP29g/tLPQntCvGckWjpT2q3L1m4KI8LgFk8WtwHmYHECSDx6G/
   cI15yFMrLkGQn5TaHBnJHIByxAWol1i3izZaZC4S+aDE6PUuqA/rW2vGt
   oBJgF7eeMs9FbS9obcHioJe9ChOb6z62kYONGrY3CMzoIpEIJUB5kUbri
   fGTlmklaejCUWtF93RgF2TES9tLt/VNGBWRQ9KCT2J5ZpWg9KGHgu/Oq9
   Zp+reexwavCuTx2sjuhHuRouRzwA07skKoi9NFinwYiR+WWILxjqvSzj8
   g==;
X-CSE-ConnectionGUID: lTQ3DbtUS22ysx8D2QEPzA==
X-CSE-MsgGUID: k/YIiHNQTEK2fonabfIaDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54211152"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="54211152"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 23:21:42 -0700
X-CSE-ConnectionGUID: IIo8MRxjS6GhMM6ffI7PjQ==
X-CSE-MsgGUID: fOixKBUYTV2JCjSjEHfL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="158336451"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 23:21:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 23:21:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 23:21:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.41)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 23:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGiJEJ+kWdjouNOd7Qd4I76GVVkaIDs8P62oV4eBm0Oa5MzqXHhx7p3GGTeaA574Dqm3zH2N/Cpn3CwO4JucC+dIx15vypkUzhxdMakHPqd9p99iBJJ4maNzNN6N1sv99CRWLNztVluYU/a7/F7BH1reSg+5sC1w49WrwBpftmLbAnZve4MI10/hYLb6RNYBOyVpflGuM3/iP8NeQsrCPhjYEE5IfzvQ7uGc03dV4ulf6i/EtOxjPafgbFOIwmtD26Zon3Id7Sc56WkuCbGKrt7THG4h+L0VERkjPnM06bVl40q6fi9UfZAmJhVz9yvmpCrTug8DU5iPyKHAMQBMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgJUN9xJidrWRJsEXCpuTjdlRNb/fOGgX2cxtgZXKd8=;
 b=N/Cbn9y/l/2eZ9UiubijbiayuAzzUJRUw6KgsmrBgEqfx17ZQXfbyT3DpX0myIVvG+hqPoioTnCSocnLopeth+WbcEITOEeyETVtThFIs3mauC/YStyhcvx4SPDAaPVCH9M4m98kpfn6B5ZwwGa6o8znQEifzo7DMgug2wbrC0QyFjaVjIDrKmRPn+MzFuS+UlAXKgy0GcJmIHwzmBapvngoW7t+7LGBvieLeAjs2xZIJ7JokLkBmaKNiHd1cOXYflWiGGEnS1slVBwahVUl426AGwuUIx7obtNe54/C2VpQGoLIuacyrDMnVrmIGjKEwy9JyX0/A8a8azG7rz1tTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ5PPF2FCF00E1F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 06:21:38 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 06:21:38 +0000
Message-ID: <89987231-37ce-4d49-a1d7-6e699e8ab0d2@intel.com>
Date: Thu, 17 Jul 2025 23:21:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Fix potential NULL dereference in
 avx512_status()
From: Sohil Mehta <sohil.mehta@intel.com>
To: Fushuai Wang <wangfushuai@baidu.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <chang.seok.bae@intel.com>,
	<peterz@infradead.org>, <vigbalas@amd.com>, <aruna.ramakrishna@oracle.com>,
	<seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, Oleg Nesterov <oleg@redhat.com>, Brian Gerst
	<brgerst@gmail.com>, <aubrey.li@intel.com>
References: <20250717094308.94450-1-wangfushuai@baidu.com>
 <e15ff86a-d7b2-48e4-b535-2829a3c1f23d@intel.com>
Content-Language: en-US
In-Reply-To: <e15ff86a-d7b2-48e4-b535-2829a3c1f23d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ5PPF2FCF00E1F:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ae3342-feab-473f-03c5-08ddc5c35a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjdDaE15UWhNRG1DWHFZa1B1ZEdCMnJBNmZBdi9MaWs2VXV2Y0M5R1RubXlx?=
 =?utf-8?B?NU5vQ1V6SUR6U05BdkJYdXlWSGl4N1ovUEsySVBkbnR3ejc1OWpueVBpZktY?=
 =?utf-8?B?eUFPblRnTjNrNnBET2FGZ1ZQdG1LSTNscnpwZ085Ymtod3o4aHozVVBPbWNo?=
 =?utf-8?B?clRhQWpMK2NTMXI4aUFtMFY0VEpqSEJXYzg0a2hRRG45d2lqWXh0c3ZWZjV1?=
 =?utf-8?B?QmlSbmY2UXZscDBldlYwNUFWUWEvUzJ5SEpnQ08rMjlJNDd5VGFqV2NIWURm?=
 =?utf-8?B?aWYxWlM0SFBTT0JyWnN5MHpCcFBNQVFhbFMxSUZiWFErdENNdnVLcGNRVG9B?=
 =?utf-8?B?RkFwZllUNyt2akdRckdnZjVLeC9UOHZsSDF0cm02M2N4U3JDL3FiN2M3MkFE?=
 =?utf-8?B?K2Rxb3E4RTN3WFBSS1BNTDhrN3ZWMFVpc214TEtxUStKR0YwbW5ydXRHelB4?=
 =?utf-8?B?Z1ZqTk9IbjlKQWcrdGxLVllSNUtJdVZ4WDBKaUpVR3pOWVM4aUNFby9mMzJq?=
 =?utf-8?B?NkxqMElQUDN0aWIzcFBybm1Cc2YzejM3V1MyUkFPZzIzSTVPSEh3OVJjcjh1?=
 =?utf-8?B?Vm11Q0ZMa3kvbnBpbWhpd0gzL2JtVVlyWCtTckZ0Yk9IU3RVbUxBR0hlNUZX?=
 =?utf-8?B?alNSaTkyU2R0ZllRU0ZvNzdMbThIL2xueHlyNTY5UDM1eUJWc3MwaUs3ajlk?=
 =?utf-8?B?VHJ5RmkwZWlYZG1QY2tSV2p2bFJxS2tKTk5PeDc0ZUkrMnBIN3NYQ0lMTitU?=
 =?utf-8?B?eHBETjZTOEJuVW1hbXBwVVVFUEcxM0k2NDd5UXJZZEtMdHdvWmQxckd5R01I?=
 =?utf-8?B?dW1tZC9ST0tJYWZ6SDE0U1c2QzJ0dTBoL1lWb0lKZnN2YnBRVTFBUUpNbnFp?=
 =?utf-8?B?YUgzUUNUSUpydDFweFM3eVlnZGVsR3J5QzJDNGpQbS9oSGg3ditLeURDbDZC?=
 =?utf-8?B?Uk4zcWdMUkNFNG1CcmZSNDZaejJMTEZRUWFxT2hUNGVQcU9WYzlMQjVvYnUr?=
 =?utf-8?B?czVJTHFHZTBHVXArdXFQSitoOCs0M3lJSGJTR0JxeXN6NityeiswNVNqekd5?=
 =?utf-8?B?RVc0eGdyaERNbm0za3d4OWw4aGNTT0k3enlheUx4TjJZSkNtQ01pNjRFVXZW?=
 =?utf-8?B?OHAxcnloZmtWVXNHcjZuMkF3ZmRzR2tBK1htaUxPaVVZN04zUFB0TzMvNVlG?=
 =?utf-8?B?Q2h3cEpVMjJWbXMvcFBDd2VoVm1IR1pHRWJsUk5qaTl5cml2Rk85ZExKZGtY?=
 =?utf-8?B?L0kyRnR4b2VYNHRvWUdmSlFiblZwRHF6UXZVOGRhbVhnb2RYckFYT05iaVhH?=
 =?utf-8?B?QUZoR3l4QXJTQVEyWWZnZVZ1azc2bzREYmRsa1NSYWpXMUpyR2M0THVQUHUr?=
 =?utf-8?B?Nk5IbjhQeG9XYldLUEVKeDl5dUZxY1BhS0V3Qm9QdlM3QmpIblk4cnZNUUNm?=
 =?utf-8?B?dlBsbEh1RmdKK1FVSExOMlRKTnlRZmVLZ3lLQWtmdnFTQjZ4bmlXRVVwRDA4?=
 =?utf-8?B?UFNReHB0MnpvZklFVTk2ZlR4QXE1M1NmUmlicHZNaDVTV0RqeWUvTStkYTcx?=
 =?utf-8?B?ZXFxQnhuWTZkZ3hOMkZkc1h6VWhSUUVYWDM0d3pkQU1kT2c4VjdCN2JFOStJ?=
 =?utf-8?B?bytRVlBZMmNKR1lzMVE2eDhOb2M1dmNHY3RLRDJ0M2VxVFA5NUNpdFZ6ZkZk?=
 =?utf-8?B?Qk9GUUYvRFkybUlSQ2w5Vzh1K1I3ejU5YnpiRDkvYTZSTFZCcmdlYStpRmkw?=
 =?utf-8?B?UFR4Q3cwQ3lhWFFLUCtjWnVmMkJZM1crRmFYY01rR0s1cmJvZm9rVms3MGp3?=
 =?utf-8?B?ak5lQUlnRkVIOUZlZStjRGhTSTJuUUpxN3Nad2tYRHR5Ukdqc0ZzYVROU3Vk?=
 =?utf-8?B?RzRwNzU3dHh1UkxkSG5jNXJ3K1pYS09RK0krVGIycGF0OVI4aThQeTU0RU5r?=
 =?utf-8?B?YnIzM0swdXRNem4rMkNkZjNSY1U0d3d4TlNZMjhJOFhlQXIySC8vbWxWcDNF?=
 =?utf-8?B?ZzZwcDJ1eXJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVZZzRNYXZubmdsNit3aUZqMGlESStwdlZzTmh1UFZyNlVHN2FZUlVmY3dl?=
 =?utf-8?B?WG1tdGJkUk1lcHltVStlazJNaStoOU9KYzA3WlNPWjhjbmxyL25MSU5KKzhP?=
 =?utf-8?B?d1FmRGxMM2s3bU9WaGhjdFdGY3pDT0dhaER2b3lrakhtcFpXbVd3UTV5Snpj?=
 =?utf-8?B?T1VFNUxoeTl0Y3FHQm03Z1FzN2svMFlpeDF2WkRtbnRyaVlqd2tTSmhCN0pH?=
 =?utf-8?B?YmVMajJkK2NGWEo2QnZiaVA1VEV2Q04za1pBaGhNcnhUNGtOMkI2L0x6aW5H?=
 =?utf-8?B?UFNzd0JJenJPTXBoTjUyeGFYb1FDNjVPeG9RNlhqeTZPYWM3a055clZiQTJx?=
 =?utf-8?B?Q1dvNC9ldWdRVHl6eWt6cWtLMTRHQ1ZLOW1DUGdqYkYxSUt5S25adkZsSTRt?=
 =?utf-8?B?dHorU2tuQkZUemh0bUVHYkVXUERqZ0taN01mQjN4WDY0UkgzZnY5aDVQMS85?=
 =?utf-8?B?anFIbnRmL3J3VnZzdFJNcnpnOElEQmJZR3YxZzF3dDIwQ0tWb0VRVDZjdGtM?=
 =?utf-8?B?djNmTzRYVmMvUHFnYVZpcEJ1R1luQTdNeEpWWGZBM2VqRHZhOW43NkhXbnhZ?=
 =?utf-8?B?OCszak1ZSW9pUytiWU9KU1ZjekgrSUdqK1VsdktUNE5QRkdWcnV1Nk02cVJD?=
 =?utf-8?B?SmQyaCtqTEJGRnZCMlpRK1ZscmFwdFVPeEVzaHVqczZSQXBKL0g5dzlFYUpu?=
 =?utf-8?B?UHF5Y0kxREtyaUpjZWw4TWQ1aDJOVklTWDVjZ2RZYlc0cmViN2RveTVKMWlq?=
 =?utf-8?B?TExIYjh5elFQWUlrQkRYRGJzQ29jT0RodWJmNWs0T3cyYzMyZGM3T1lHL1h3?=
 =?utf-8?B?WHlRdEVmbHc4SU42V1VtdDRDSWFVeW5BTzRTWEZVYXBvV09IdVFrMjdHVmR1?=
 =?utf-8?B?bDZ4anRYWEQ5bU5jalBSSmppQkZyK3d6dDB0YTdiNFBORmtuRG5xMDJUMDdK?=
 =?utf-8?B?UGtSVTNRcUpDL1NacjZXblJzSXpqMXYvOG5CaVdBWHpPMzJpblhjWHJIYmg0?=
 =?utf-8?B?dTYyOE5CaFdXNTBuZGpRbnBZVnNKa1luSkR4Y254TG5UOFV5REYrbG5xSitX?=
 =?utf-8?B?NlpKWE1XR0ZYOVlTL0dPUUVJc2ZQODdoYzZKN2hHNXJXMy93U0Q2c0M1c2V2?=
 =?utf-8?B?aUd0Z0JaZkJCTGhyWm55NHZiYTZqTkFSeitNSjdMWkJEYXd4S3BKNmtvbC95?=
 =?utf-8?B?WEhlckxDcWt1MGYzUmJoKzAvWCtNNHNRRmVEMjYzRDVHM25mMHUrZGxsNGxs?=
 =?utf-8?B?NGgzQ21aSUJMY2wxSTVDRFhFRnBWVEFLSFkvOHNZYWZkNDRMWWE1ZUg5Zmdp?=
 =?utf-8?B?UHJrSWdwWUxpRC9kTUx2Q1BsSU5GZXpoaEpvak1CY09SVFgybC80QUxUMFVk?=
 =?utf-8?B?NGEzVnVxZWZhZGUvVm00bXRjQmZBOThDNHhaRi9na1FiMmhFam9wVFZGRE8z?=
 =?utf-8?B?ZHJUR1ZVeHI3YjBtaWJ2bzBvWHJNZ0FIY1VLWWZSN1VJVDJoL1J4V3V0QVA2?=
 =?utf-8?B?Sy92VUI0d0l6Q1lwVUVDVldRamJWUk9NOWJRQlk5WkNnVTJkdXBtZlkxc1o3?=
 =?utf-8?B?YmF2Q0g0UHhJZWpuQm9HSHNZRForbjdVSTNNZzFVczIveWcxeTN4WDNibHZu?=
 =?utf-8?B?eWNGVS9kSkxkSVNtWVRhQmZ1SHl3WlFPYVRqY1N2L2w5ekViVnJ6eENTSWho?=
 =?utf-8?B?M1VFdjJnRW82RzBVT0ljV1BKOWtuam5PY3NvcmZuVXArZk5HdmdJdmJpbDdk?=
 =?utf-8?B?S0kwNUZWaUo5TmhDVDQwWWZGakxwY2xQZzkrQVJQNVZxeC9BbUJLR0t6TEpQ?=
 =?utf-8?B?UElsTjdLVnA5SlVkRVQyTVBtTnBNWlJsV0tHVktxREN5bFVLNmN4Y1VNU2FJ?=
 =?utf-8?B?QkJtdndNcE04dzVyZkd3VVpWZzdMNHVyYkUzc1BNL1hJN1ZNeGlkUCtaKzA5?=
 =?utf-8?B?a2VPQnk4eU9LbXBCaTYxZXZsQmw5QTJkRGx6YVhVdWticEVLUjR6ZHppSEJ4?=
 =?utf-8?B?T0d1dGxIcDVvaW1HMDB1VDExcjhacVBaMlpqMUhxOG1oeWRwczVvNGxOV1dw?=
 =?utf-8?B?UjNJdUNlMmRWUWNscFJJL08vMVdCZUxmc0VsSWh4Sk5wOW5Mc2V4cGFhUytV?=
 =?utf-8?Q?Dy8RHtzY/oBJLottlIYN50Faz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ae3342-feab-473f-03c5-08ddc5c35a2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 06:21:38.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6y/EnCzZ9nv9wE2JVHtNYfRawH7PAtko84CYzGk4HcVXJzdcbcu/R5+TXKPAu2CuVPN8bi+XbpfHkR3s3LuJ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2FCF00E1F
X-OriginatorOrg: intel.com

On 7/17/2025 12:21 PM, Sohil Mehta wrote:
> On 7/17/2025 2:43 AM, Fushuai Wang wrote:
>> The avx512_status() function would then dereference this
>> NULL pointer via READ_ONCE(x86_task_fpu(task)->avx512_timestamp).
>> when reading /proc/*/arch_status, causing a kernel NULL pointer dereference
>> and system will crash.
>>
> 
> The kernel seems to assume that a Kthread would never call
> x86_task_fpu(). That assumption is breaking in this scenario, which
> causes the below issue.
> 

This concern was discussed while adding the checks:
https://lore.kernel.org/all/ZmFziN0i10sILaIo@gmail.com/

Adding a few folks who were involved in the discussion that time.

> Can you please share any other warnings that were triggered before this
> Oops message? Also, I'll try to generate this locally. Any specific
> configuration needed for reproducing this apart from CONFIG_X86_DEBUG_FPU?
> 

I was able to reproduce this on a system with X86_FEATURE_AVX512F. The
issue only happens while reading arch_status on a kthread.

$cat /proc/[kthread]/arch_status     => NULL pointer exception
$cat /proc/[user thread]/arch_status => No issue seen

Can you confirm that you are seeing the same behavior?

Unfortunately, avx512_timestamp resides within struct fpu. So getting
that value for a kthread would mean going through x86_task_fpu().

I am wondering if we ever need to expose the AVX512 usage for kernel
threads? If not, then we can do what you currently have but without the
CONFIG_X86_DEBUG_FPU restriction. All kernel threads would always print
the AVX512_elapsed_ms as -1.

However, this would be a user visible change so we should probably get
more inputs. I tried this experiment on an older kernel without the
above issue. Among all the active kthreads on my system a handful of
them show a valid value for AVX512 usage. The rest of them all show -1.

PID: 2594
CMD: avahi-daemon: running [SAP.local]
  /proc/2594/arch_status content:
AVX512_elapsed_ms:      46032

PID: 2729
CMD: sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
  /proc/2729/arch_status content:
AVX512_elapsed_ms:      396656

To keep the older behavior, we might need to consider moving
avx512_timestamp out of struct fpu. Though, I am uncertain about its
implication.


>>
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index 9aa9ac8399ae..16f813a42f42 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -1859,9 +1859,14 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
>>   */
>>  static void avx512_status(struct seq_file *m, struct task_struct *task)
>>  {
>> -	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
>> +	unsigned long timestamp = 0;
>>  	long delta;
>>  
>> +#ifdef CONFIG_X86_DEBUG_FPU
>> +	if (!(task->flags & PF_KTHREAD))
>> +#endif
> 
> The logical code flow should not change based on X86_DEBUG_FPU. The fix
> for this issue likely needs to be somewhere else. Though, I am still
> working on identifying the exact root cause.
> 
>> +		timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
>> +
>>  	if (!timestamp) {
>>  		/*
>>  		 * Report -1 if no AVX512 usage
> 



