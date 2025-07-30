Return-Path: <linux-kernel+bounces-751141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A786B165A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856FC580A75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DDD2E06EC;
	Wed, 30 Jul 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DluO7z0+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F62DF3D9;
	Wed, 30 Jul 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897241; cv=fail; b=U2DbpQbWX0KhZbipErUF6etCSlWOtz1KOli9WpF3VyO7lV+bJfgYSUBtWTaqPLX0/Z15WkV6R1myLll8PdGKHsfqRRWRfIE9QFx0kG/t0kny3JGzS9l4q6BjHfqqsv0s8WPqtbVvJMpGmzM2Pq68fHvgD+uL8KgcvbxGK27u5Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897241; c=relaxed/simple;
	bh=78994i68rtAh7nnuruBO19OgNfakj+2UEQJn047NO4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BXC31s4Yy8tdUAdwAbHLft78n4mqKS6AqOe9VB9cVHNY5n57Zve5dAZ/vzdmGPSaD50+oa/ONeJwrx//4vWHdMUqVOyVV8xqwyktxUyWrVDoxoxyvT3wnItp1eAB2cD5fFBsYrGmsyTAj3vzz/DY3TKpO6aDWWrG0c8cMIyTddY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DluO7z0+; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlV3vpdL3NFdmO6fdRA7TyOu5/d2qsRqE+72Ta6sJV3WZq/muCFXvvM5HpLR2c3UJUXOwIhwCKvNFheVZLpKuWw/iT+2olohICi8HZJYJmQF17LgKdJauNgo1THcUIMwoHjme1aq+E5dratvw9Y2exT2mSNTJLuaFm3sssMvOY9Vh8tL/RNy8j9tmB1Z41TStocOinA4YTYYO7E8kJGctHMY2t3bezLOrrcTP5/6HEXuqnD5Ks7QQBrv76IBqPprUc9k22RZQIIA3OqDWmqTWH2AhTiPjTlZSedH2KRkTIMICgxSfaAohEaosmIy13XqJAC7ElwhqEvkMCXKmOBvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq4vWyr0dEVKyVlzbkYkD1wkfJtZYD8Dqmg+X8YGunk=;
 b=foOHIrX0ZGIZSd/ceK+TPi4Djp38jSgsn5Lzg6qbgnf/i0dy/RBpmJm3dN9fFiljF0xd2eBA5g7kJQI/kzxcxC2R0FPWbTC7rfSz8ZO1324QSkdnts1SjTnEMuym8r/bsqkwisnj8ByBdGHttGK4q1rFBLLiIPs47BuAQQTmCeuw6prL+kWxYBVOO7qNlX07dKHJWuqcxaQxxlRUZHjhuue5qbeCa8MKG0lni6baSc+B2pl2CaqGF/fYSL5P6smS/audcSlUTEnohKWB/1H4GpixWbwTpLiQJv8UR81OtqsEx3SGwy8ge03r68o55W9nRL26Sbk1j2wxH1Lb5xIOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq4vWyr0dEVKyVlzbkYkD1wkfJtZYD8Dqmg+X8YGunk=;
 b=DluO7z0+A943IRmi9jlbHABc1mUKDkCmuwrAL0ykd/X3cq4vePIwuoqHy2fX2dLARwzV7BzJoL2FvhmcWrr8qLPW9ytJK3jeLcg60keOveMo78gcmKJ9mIIhU82vO4Frm1fzWOtPdJi1sWGFd/9SUTFLrUz2FeksYe1eQeZrwBxXC6oaCDHw0OBdHA1mXkGileTUe7oi8E0RMtE7PPAK9TsmetjLIjqEnAipxUE/uGsi/zMpFVuExbZ/roj7vBbe22mDVcJQJXpAmYtOkIn7NwErYenrxpB2iowfs6L395mjCiWS1TL/Tv6tq2NqCa2bzl8Sd8N3K/jJzSU2Mdo5zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 17:40:35 +0000
Received: from DS0PR12MB8044.namprd12.prod.outlook.com
 ([fe80::f250:7fd7:ce23:a0fb]) by DS0PR12MB8044.namprd12.prod.outlook.com
 ([fe80::f250:7fd7:ce23:a0fb%3]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 17:40:34 +0000
Message-ID: <673ee064-4f81-427e-a8e1-6796fdc53d5c@nvidia.com>
Date: Wed, 30 Jul 2025 13:40:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
To: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tejun Heo <tj@kernel.org>, Tamir Duberstein <tamird@gmail.com>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Alban Kurti <kurti@invicto.ai>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20250730163439.50753-1-boqun.feng@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250730163439.50753-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:408:ec::16) To DS0PR12MB8044.namprd12.prod.outlook.com
 (2603:10b6:8:148::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8044:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7d1b47-26f6-448a-9281-08ddcf90301a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Skh6dnA4amhxb2RvNDdYS1dYQnhuaWdYcFFTN2JZbnp1NHg3RTNtV0d2WTF0?=
 =?utf-8?B?N0RYMW5aclYyWmV4QlBLYkllUnRSZVN6ZjZ4OHIxSEtPaGplSDdEbHFHQmRN?=
 =?utf-8?B?aWNyMzZvbzVjRVNIcUkxUnhuQ3FhNUtNUGJJRUloeTIyMldRN1pvcDdVUVBH?=
 =?utf-8?B?Z1ZydE0wNjVxWGNJS0syN0Ura2tVUGk3d1d5MHpaMXFjYnlDaUJoOVM1eDZx?=
 =?utf-8?B?aUE5b1RXeEp5ZXBRcnFDRFlVc1Y3ZlZkQTJYUWU4dVhOekdiL3RHRnlBZlZ3?=
 =?utf-8?B?M1Y0UTlOUDNESDRmcXhacmRhUVN0MDRmYlhTM3M0Q2tzR0xhbTcwdUU3bTdu?=
 =?utf-8?B?MXcyMzFpR1Blb0FGaTZtVjV4MFNZRlg4REsxempQU20rYUl5TWVjcUhlTGgw?=
 =?utf-8?B?WDJiVDJiOHB1dDRpZWpUQ2twZ1Raemx1dldDeFU3VmFWZXhhaXNvQkpnYkJz?=
 =?utf-8?B?YWNDdUpEc1h1eGl0U2VTaCtVR3kvQklGR2JjeTlJQUtIZDcrcUI5bjFHcDkv?=
 =?utf-8?B?S1hHcTNCWW1VU3V1Z2xicVhUWnZ0M0pqTXcyM2lJZTBTYTdxSFNLQmpnd3ZI?=
 =?utf-8?B?TkFNeVhVdlZCK2FhbWZPb0RlMk5VcHNMSVRHd3VRL1ovdmlYb3V5cElFZTJz?=
 =?utf-8?B?SXJKR1pTaGppQjI5dmlwWVNWZUh5YmQ4MXhrMUQ0dDZvN216R0RlOXFraFFr?=
 =?utf-8?B?UTJCVUUzVnJLNm0xa0xESUZ6dlBRblZhMXlKQ09rc2JTb0dYOUIzWUxoREFX?=
 =?utf-8?B?Q2tucUE1NHc0RTVuTkZ6cU1VMmljTEQ1S0RTb1dvTkdZazRlMGRMWlZEclYv?=
 =?utf-8?B?bDcrTWFoUFBPWUx3M3A3Y2o2N043a0ZNMmxoSUlyWG1FenFPTjB0d2F5Z25r?=
 =?utf-8?B?U3orT1JjcE0xTlplL0orUzBmQklrK09Ib00rYVVRU1d6U1lBOGFXT1JEdWw3?=
 =?utf-8?B?K2hXa1EyNVlLcmRSajFZaE9nQ1RxTFdmb1Q1anAwaW80eGV2OHFtbTQ5dDVO?=
 =?utf-8?B?SjdISG9wNllpck9GWUI2b2pqQVVKS1NPam5GcStuNGdmRm5XdUlIY2pRSjlF?=
 =?utf-8?B?c0cvL3lJcDZwamIrNVQ5ME9ob254Mkpyem02MjQxZ3FtamFKNmsweElvMXJG?=
 =?utf-8?B?a1VrODR5aU50NjdRYkswL0pvNXU1RnljSzJ2UGluSWtQcnZMZERWdlh0T2FW?=
 =?utf-8?B?Vjl1WFB1MUlySG81S3YwNUxnU3BnMDkwaEdNSkNuanpPZVR2Y3paWllYZzZn?=
 =?utf-8?B?MUVESWV0L01oOUM0KzRkdGo2YkFQRytjRDlnaDlVWTduS096U255RUlrUXBk?=
 =?utf-8?B?RU50OFk5Nys0Z1JTQThHTTlkWkd6TTNZbm1IZE1wbnBlVjJZTTZXWHhLMVc3?=
 =?utf-8?B?b1pUaGhrQUZhWUZVNUdkQlVkMmJQVDhIZlBybkVyS1RXZ2h5cXRwWjArZ2sv?=
 =?utf-8?B?aStKWXdZdXd6ZEZ4YXlobWwwcXZSR3Z5SWg4bktGb0FmcWgyQndCTUdsL1ow?=
 =?utf-8?B?SUZLWno4TzV6c0dBY1RlSERVTU4rNnRYUjJNa3RYTG8vS0lFdStxNXk2a2Rp?=
 =?utf-8?B?cjBScEZpZmQ4dzVLSGprOFZSWHR2bElQa2hHaXYxNUdlSmpUYXp3cE9vN28x?=
 =?utf-8?B?Rm5RemQ4UWdQTVFZYkdObWErVFZMR1pRZCtyQUdNaFduRSs1Z0hvKzl2Y2xi?=
 =?utf-8?B?M3FwaDhweFNLbE1ZbG1WQVB6OVlTY3dFYU94TEdzVUVsT1JhSkRZYWM1Zjk1?=
 =?utf-8?B?NUpsaEpUdkJ0WUFXblErUDZJZTdPOTA1SkNZaU04VUFHbkJyaHJ5SFBqZUND?=
 =?utf-8?B?TEVaTzgzMWdYdTZIT0pvN25FVC9mRUJObVR1Q0V5Z0w3VkJGR01iRTNnbDBL?=
 =?utf-8?B?ZEdzWEtGb2pNMUNDWmhsUVRvakVUeEVkTEJINmdkTytDcHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8044.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzZ4K2NrQWFuSGZXWStoR3NVSWVmZkExdllrVHQyeFJlOHdzS1c1WlQvVzhY?=
 =?utf-8?B?N1RTdkp4N0N0WDA1d283MTczd0tmWmIxSDB5OVpWZ2JUMHVldXRyaXBTNWRq?=
 =?utf-8?B?LzJEeDFmMjdPeEZFamZ6Q1JFVWJ2S1hIb3BBNUU4MlFwTWU5Nk5JM0VFeFo5?=
 =?utf-8?B?eFlyUEdIWTRIbWdtMS9vMnd2bHZFWURvTi9zcmdieWxqSG5qOG1tSWQ5M3JM?=
 =?utf-8?B?QnZINGV2YmdDa3dieWsvRVkvV1RIdFovcWFKa3BhaFR1Qi9WMCtqd2VaWVI4?=
 =?utf-8?B?R0xQNmQ0aVNWdk1adkh3RlBpbTZvdzlSRWZvNm5KSWwvQ2swck9WNGNCSml1?=
 =?utf-8?B?T3pBTmdPQnd0YjBaWUJPNjV6RXRYbUN3eWxYdDQyeDRMaHhwY1V5clhrZFE2?=
 =?utf-8?B?TmYvYmRDcTl6eXlkTUdEdFhNa2dTYitUanVBKzA2bjd3ZTFzSmtHM2VhdVN1?=
 =?utf-8?B?T0dOZjI5TC90eEpyWW43WEFIOEVOWCtmbzV0MTlJMVBnOVZmV0FLa0hGMWhz?=
 =?utf-8?B?YUNmdHY1cVQrUTFSeC9sdS8zUyt3VHZrOUp4ditwb1BXdmc2RnFqdktPTUVx?=
 =?utf-8?B?NXJSWFJiWWd2eWdtbnlLY21iT3c4UmRzclBsMjJKZmZ3WDlETUEyWS9sb1Bx?=
 =?utf-8?B?RENJemZtdjBhK1NUeVRZN1hUNVlKUHcxZXlFZVp5dDBjSlQzTG5vS1JjcXhm?=
 =?utf-8?B?OFlVZWlRR3IwcldLakpuN0Eycm9QTkJ0UFNKMkpHL3UyVWRMc3duWE9YbTdD?=
 =?utf-8?B?N3ZXSHUwSW1HNlgwdlFaMlNoQ1JHL2Z3YnFxbzdIYnJnWGtYK0Q1a1FNS1RS?=
 =?utf-8?B?VUhBOHh4L3RZenhFdFRodFpzRGFIME02K0o5SEVzRTZtQUNQd2pIQTRrTmd2?=
 =?utf-8?B?ek1YWXc2UVo5eXJtRTdGQzdMRjdtSTlwdkR2TXQxaGJsV216bUtIY0lNeTZo?=
 =?utf-8?B?cmJkd3NVdE0zUDZNSk9PYUdVUUlaQS80SG5sRGw2bWU2cXZTakNudFVsRHh2?=
 =?utf-8?B?ZzZycW9IaW92ZDlSMS9vWFdoQTljRkhIWEd2NUxMUjhwMXU3QVhkVnB1T285?=
 =?utf-8?B?dXRZUW9VcjNrdkVLYUo3dzlUMkJTU05ZZ0hWRUhaMFpDR0xvQWJET3BTcTB6?=
 =?utf-8?B?VmdhdkdYNGhpTWs3d2QveHBLaUJWblpZaXoyWi9nc1h4OGI5VFVLOFhnNE9H?=
 =?utf-8?B?QmJCN0dVWk4zYmJXRGxXUmZKMGRpY0p1K21qTTgwOWJBYWdZbE9wSllWWHNQ?=
 =?utf-8?B?NnEyZmJvU2lKQmM0OEsxZ3pCRTNUc1dvdzZXc2pwZWtsUHQzVGszaEsrTEpq?=
 =?utf-8?B?YVdRUVQwaGppd0ptOW1VVndETklJNnA3Wi9obktURXNNNVMwaVcyRW1oN2h3?=
 =?utf-8?B?ZmJxMEJ0aE5ScnlvSUQyMCt6YnRRaVNZUE5zR0VQemdrRjc3b3E2OG1vcWps?=
 =?utf-8?B?RW50WWVtbC9ueFJGUE5IeDhMWW9udTdoU3NrampDWUNrLzRlRG5NMTE2YVIx?=
 =?utf-8?B?L0ZOS2lEQjh0QkpDeHVKRDlrU3BOWm9ma3JYdkpYWWN6Z2NYbW5yQnE4NSts?=
 =?utf-8?B?MHV6aEpOK0JlN0hodG5nTUNlTUZZK2JqNm05VlppL1cyT01IeW43dDA2VGNX?=
 =?utf-8?B?SXV3UnVwcWZGRDhaR2dMZnBCUk5KdHlmQjV0ajMwaHlVN3NJU1p0bW5rR0wx?=
 =?utf-8?B?bzZxYzNickhldXB5UHBVVmFPSmVKRkNRVnhlL0lqYzVaaHp5OXBBYTkvV0to?=
 =?utf-8?B?eUI3TzhvMjh5RG8razFOVGtYZVN0a25XRXpIM3ltV05oOW4rQ2dvcTBDTjd5?=
 =?utf-8?B?c1dKZzVJYmFybUV2Wm8rRjdEWUpCS0ZpdUZYSGZOWmFNVDlabG5HOWVib0Jo?=
 =?utf-8?B?eE5aM3ZvbGNhc3FacVNEK3JzVjFId25NVk9vTjhHVzB2ZWM3c25mN1lWMThM?=
 =?utf-8?B?VlV6YkxuS2FkMHB1bUN2Sy8vc0pTMVhDWnhEZ1U0MXlGRUY0bC9lWERwMXdV?=
 =?utf-8?B?QTF0eVpDVEJRY3FDVFBsN2ExU25Jdmhya1JZQ1Q4OXJXbjNxN2gwUmR5YS9T?=
 =?utf-8?B?TzI5MUhIOGZwQy9aV1pZY05LWVBRTndZM1NHLzFJQmVrZnMyaGU2L29kVjlQ?=
 =?utf-8?B?b1czSVlCQXAybXdtb0oyY2QxOHVjMzNHRm9yL1JFVUtTWitnOVNnMThYV1lF?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7d1b47-26f6-448a-9281-08ddcf90301a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8044.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 17:40:34.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54o/3q/UBvj2sIYdq3qQM5gO3+Yr+mcISC9q1MOOzI5faDN+8mw0lGK2jt4FrG7EehhK1UL2vwDX2XpWhTu7JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106



On 7/30/2025 12:34 PM, Boqun Feng wrote:
> `try_spawn()` could use an example to demonstrate the usage, and
> arguably it's the most simple usage of workqueue in case someone needs a
> deferred work, so add it.
> 
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Makes sense, LGTM.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel

> ---
> Miguel, Alice and Tejun, while I'm at it, should we also rename the
> function to `spawn()` because of the motivation mentioned here [1]?
> 
> [1]: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/topic/.60new.60.20or.20.60try_new.60.3F/near/529533317
> 
> Also I find the `{ <clone> || { } }` is really good if I only need to
> clone the Arc for passing to a callback closure, but I'm not sure how
> people feel about it, so criticism is welcome ;-)
> 
>  rust/kernel/workqueue.rs | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index b9343d5bc00f..59c1a5e14d12 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -331,6 +331,33 @@ pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::Enqu
>      /// Tries to spawn the given function or closure as a work item.
>      ///
>      /// This method can fail because it allocates memory to store the work item.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{alloc::flags, sync::{Arc, Completion, new_spinlock}, workqueue};
> +    ///
> +    /// let work_done = Arc::pin_init(Completion::new(), flags::GFP_KERNEL)?;
> +    /// let data = Arc::pin_init(new_spinlock!(0), flags::GFP_KERNEL)?;
> +    ///
> +    /// workqueue::system().try_spawn(
> +    ///     flags::GFP_KERNEL,
> +    ///     {
> +    ///         let work_done = work_done.clone();
> +    ///         let data = data.clone();
> +    ///         move || {
> +    ///             *data.lock() = 42;
> +    ///             work_done.complete_all();
> +    ///         }
> +    ///     }
> +    /// )?;
> +    ///
> +    /// work_done.wait_for_completion();
> +    ///
> +    /// // `work_done` being completed implies the observation of the write of `data` in the work.
> +    /// assert_eq!(*data.lock(), 42);
> +    /// # Ok::<(), Error>(())
> +    /// ```
>      pub fn try_spawn<T: 'static + Send + FnOnce()>(
>          &self,
>          flags: Flags,


