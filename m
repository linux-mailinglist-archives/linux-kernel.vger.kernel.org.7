Return-Path: <linux-kernel+bounces-775965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D1CB2C6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06776188844A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62E26A1B9;
	Tue, 19 Aug 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lhzEBDie"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012035.outbound.protection.outlook.com [52.101.126.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5726656D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613121; cv=fail; b=ks8f8KuLSCe663Og132S9oc+MVoyDo55UUUmo63+WTifgjAyXCHDmyavBzlga+atqE3fLJr3nYWdNdblhFh1zWxpiOOFu5l2KhS9lCSaL8FIsBu6oWyjW2LEmG5rgQ6hxFGyJMokAtrF5Wz5c+IHFMvIE4MYeiVCn4MXKFXvvPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613121; c=relaxed/simple;
	bh=rhvq7JpDuEz+6kX0csRWuMaHnoV6Nfh6RC+VrjDJes4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atXAZSmMILCPF7l9Z8FKh7q0k/Xflzijvwgll0/MQhRVMCuZGKJ6nKUyfau4ElZCc2SdkVsl10YxckWP/PDJRL2ASD8YuDrPl6H7K4Y072ZffaqKF65LhOy5GPWjz3I1efQbZCHd5bcI2ct7HeOhbbgosI3zo6afmW79VVM3ris=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lhzEBDie; arc=fail smtp.client-ip=52.101.126.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW7Im7NpN5D3zOyQkv97lw3quO0ooHr5BFAKtlA7taB1kEp4lFHlknx8JF8gHBMV+p/CHtdfI7ojVQ3R0NDIlnNWj/zcPA1GPeHQ97bI13h94wwXYXCmgwa9LX20JO9MZaOVEqdOtExTrPDDzgmD15AgfckMcUOnNoihhnTiXRolYDpL3i3taDquiMhPQrfM2Ohpr/4IPVYeJFrK+WpBmHBoWhxYnSL+cZEU1L/g6qrBtpUjL2LCXbQXjLpwbDlegrmDcH3dtFWRgBPnoraRZ4AbvhMwFmlHMmN9hGsoPtwisWT7ht8HzdldbWd3m743EyD+G29UU1Fh5Ff8H06Sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYWfpzVJykkMr9M0AQuuFc1NY7xBbjS0txEJGncXy2E=;
 b=G3HpaAJ1PXNdZOJMDPsMW3zASDMJKxCsZ/T/WJHTRJKZ82QKUxb/DXZI5J845C1pfgzKX67fMu6ClB8MpTBD3eO9N/gDfWEk9DGnIfG5j3z6C02yrQQIYvFeUCbAtOMRNNk7XOrYLfmospcrWfjZ5r2gRLULIx8H+AgzA+zXhsGsw1HmuRmAnlegl79Tp3j3zfFGsVyZX9d0Wj60CNClQCI9r0vi9JpNOD1gF0WKVNJjjShOOb1lHVwPJIjzgFS19qXoHyDL6njHn3aYjqXj73oP59CUifXMIT0vU8cz6xZXPezsHmusYF7qxWba3cGvk6a1HauVl5yBq3Vduzm2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYWfpzVJykkMr9M0AQuuFc1NY7xBbjS0txEJGncXy2E=;
 b=lhzEBDie6IeXQZOpyWU3fSpisJCDFCi5RiFjuWNIlmIidiX/O1dI3nMd8zs0d3TjtsphHJmsQZKUX38bd4vsTJm+ZnqeY9wN/tFj2cKVhhNmwuH9nsFpKf7tSrfso2Lr3Oi7CmI+Qg9we/yaNBLIFIPN0q5a1ANBiEKGLfpSNtALpj6QIrDa8HvkyhsjbyS5ECt0oZsispi2+CEc1X5/FxheZZqXG+Qds7kUlvzjMxpvTzsq4bdtDOYwjBIBGhs0xXAhG8B5O+LnsTT1o0IYDJy7zwHSRYCH7ZWJJk7Iu4eLr+BT2gzZxrd31XmnTD8yHjCRlxn8VmAQRNkjyCTe6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB6863.apcprd06.prod.outlook.com (2603:1096:101:1b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 14:18:33 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 14:18:33 +0000
Message-ID: <893eb958-68f9-44f7-a1dc-4869af87c7c1@vivo.com>
Date: Tue, 19 Aug 2025 22:18:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/vsprintf: remove redundant header files
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Harry Yoo <harry.yoo@oracle.com>,
 Kees Cook <kees@kernel.org>, Sergio Perez Gonzalez <sperezglz@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20250819131330.153128-1-liaoyuanhong@vivo.com>
 <CANiq72nNnz5esQpGFsENUm4cgGOAkkkqCuHyNxfEPHUrFvaH8g@mail.gmail.com>
Content-Language: en-US
From: Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <CANiq72nNnz5esQpGFsENUm4cgGOAkkkqCuHyNxfEPHUrFvaH8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 114c3ea9-ce52-49b2-cec0-08dddf2b4767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW5IZ3pYVVp2bUovVDRtWjFZTWlLU0F0UkRQZkN3Wmx2QXo3VGJBVDhvWnp6?=
 =?utf-8?B?eURmcmJYMGpmam9ZMW9ZTFA5SHRqN1NNdHpDWUxKRWJEMGxHTDlvUER5TC91?=
 =?utf-8?B?QU02UHNmem1Cb0FzR2x4SnRCZXByYi82ZjZLcW9PTDRSLzNPVkRjbzhZOXhv?=
 =?utf-8?B?TWNZSjZva3NqSk52cHNrWXFjNytzenZWY2lOY3dFMnVveURGMGlWNFdpc3Vy?=
 =?utf-8?B?TlN5K0JsOEp6OWZQTXd0eEVnVTNZaVB2MXlzTTZHaGFqZUY5ZnNDZHlvY2tY?=
 =?utf-8?B?WWpxamFRd1ZPWVZwTXhhTTNUYnpSdXdQMG5Mb3ljek90YjNUcTgxSjBNSE5W?=
 =?utf-8?B?VmRndTVBQnpMdFhTT2RUUms4Q21NQW9hS0RDTlFTUFRmWGE0ZFRvZDBQczJw?=
 =?utf-8?B?Y3FTTFlUVHkvSzgvaXJXbnVxR3ZNelgyckFtS0NrQTg2RTc1MWs3NDJ1cEw1?=
 =?utf-8?B?YWhLWWtqempSWjl6clI5V0ZYZUhzc25ncGdFLzNnZTVUeElSL2xWMWVCSUhm?=
 =?utf-8?B?dWVqT2hNVHIrU3dKR0NKRU1yeGdxTEpyemxKdnBwWnExNUd4RFVwOXBpdHUz?=
 =?utf-8?B?eHNUOUJ4SlZHMDE1U1pJOFZlTklpcHJFeVpndGt2dzRwM3hKZ1p1T2N5dUsx?=
 =?utf-8?B?ZXdCc0drQUNxT1JUZTFuVXlKOUg0c0tzcTd5d2hiWVorNFJ4dmVHdm0wRGxh?=
 =?utf-8?B?TGZwQUVjbDhGeGpkNnRDa1pUeXhNaWZXMmtnTXdISzNST1Y2MksxajFDSVQy?=
 =?utf-8?B?V3NyYjJQeG1sQzUxUG43VUptNHlFRGMzL0NUVmtGS1VSZHZvb04vNS9DMXBL?=
 =?utf-8?B?cW5KaDZZeHd0a2xWOGVDQjNTSWFpclh6WjBpNTJmeUhXNm9JU0o1ME5kTHF4?=
 =?utf-8?B?TTJSd3QwUHEvay8wUGJicGt6U01WYUVqL1dRcFQ5OFNiQndEaWRER3hPOU0v?=
 =?utf-8?B?bU1PSlNhMEt6RlVUZVA5QUVMVGdHRW9VK1NzRDFEd2pIcTZWM2RQYW1HdGRQ?=
 =?utf-8?B?YWVVc25xbE5OM3hzSXV3bEJ6dXk1YkpJekY0Unh1V01MWEhJc0U3amtKVTFR?=
 =?utf-8?B?T2ZMTno1ZzVXWWZHNTJOWER0eEFDM2tDb01qYk5USHJqWjNtRmRFL0p5OWZ1?=
 =?utf-8?B?UEcwT09mR2hHTWp5akpjZE9jYnlGYmpRN0N4NXd0bHdFeHB3YS9qcGN6Rjkv?=
 =?utf-8?B?Zms4eHoxTnI5d0dlZThHYWlORXZGQVRELzRpWTI0dDd0dXdIbWJpaFpHcERj?=
 =?utf-8?B?VElNSEcyOWxMcm5HQ0lYbHJ5R0dGTTBjQytDNFh3Zkp2c2tpejgzSGU4S0Nr?=
 =?utf-8?B?Sy9zUlV3RExlVDFuRTYrZXdQdTlFYThoTURwanVhSDRDS3JLTmlyQ2NKSndu?=
 =?utf-8?B?MS82N3gwclRZSFR2Z2w2R3Z2SWl1VWRZMU5iM005UFFRQnZtY3FIaVhmSVhi?=
 =?utf-8?B?YlROMGYzb0xoaFZFMEltaFdlSFVrK2p3S3l2YnRqMlQrM2NZb1FQb3I2aHVV?=
 =?utf-8?B?VzlENlNJNDJRanJESks0Mm5EMWFGZi9GWTh0RkVjWm9ZVHRaSjRYUXZLM2tW?=
 =?utf-8?B?NFBXVTFsODhCTkxHSGhGbUUrMnVzUVZFYVl1UzJDd2dyQ053cTZQbEs5ZEl4?=
 =?utf-8?B?REtTNUhoZTZydW1PTFlRa0pXZDlBWVVIcHFGd0NSbCtlTWpUYXhWbXdNMEwx?=
 =?utf-8?B?OU5oQkViU3pqT0ZOVnZWK2pIQzNsSm5zMWx5MWxZRWVGWFJrOVE0OURwcXZu?=
 =?utf-8?B?T0IrSHhYcUwxYXRIOUMwc3docVAwRTNtZ2wvb1VtM1FFRkZTYnR2Yi9veDFy?=
 =?utf-8?B?d1hsR0c5NzllOHN4dUVQczZFSjlTYTBjOG9BUkZmM1ZlTEUyalZpYlp3SkFI?=
 =?utf-8?B?Zjg3VWxpVzNxQzFLTDFudFlhQzlFLzVHZE4vazNDZCtkZUxzZ1BXNi9yamZH?=
 =?utf-8?Q?0XklrMUN9iU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3UzOExyVzFFaFRxMnB1SDZ6alprdU4xSVRWM0QxdmxjZDdJRmxKME9qN09B?=
 =?utf-8?B?a0ZxaVdibGptQmpmZVUzYjZiQ2hiMkxMNlUrem9uaGFoYzFVRGI2OFdNOGJo?=
 =?utf-8?B?cTBQNXlTaVV2RVdCalhMeDdBdW9TV1NlVk14UXpNbThjdnpBd1ZzemVlVjFG?=
 =?utf-8?B?c0F4MnZKNUtxVjdMM2xPNDRUaHF6bjhKeitoN1BDbFFnQjBSek5rUkdVYkxW?=
 =?utf-8?B?UE9OSVR0ZkFoWStSYkhQdERxckJ0dW9DWXJESm9vRFJBcVNzdnE0ZFoydklX?=
 =?utf-8?B?NUtIa3hZVmNBbnVLUlk2Z0FOa0ZNQXRQTjBjSHNLTi9rL1dwTjRwRytZRDh1?=
 =?utf-8?B?LzdmZDdMVWxTbE9aUGxpbzJzNzJ4L0c3dzNDM1hBZy8xQzZBdkZiQnFzZXU4?=
 =?utf-8?B?Y0lJdnpOZmR1bi9Zakd4NkVEdnhWelZmcUhIOVI5YVRhbkhvVmVvWDExelVT?=
 =?utf-8?B?NXpyRVBYa09zUCswYjVxcjk5d0JITDFvN2JPanJQSVVWTGpOOTVpZXBLNHly?=
 =?utf-8?B?SzJrL0Jiem54N1ZwZ1pmL2dlT0NGeThteXNEbG92Smsvazd0TDFzZkxsUmVK?=
 =?utf-8?B?QytoM2haOXVzRGJmb2tjVDVRc0hHaHRURE1lVVNyaFBzdWx5bUpUZXduQjVO?=
 =?utf-8?B?S3g3YlFTNFhuSkNEK2kzcGxSclYrdWc2NFArSDMzN0VaYVF3V0tBWm01OEdk?=
 =?utf-8?B?YkNrMjd4cVgrRDhtZnNoMkFxMmwzRDBFK0d6Y3ZKdUFseWl2VTg0WHhlckVu?=
 =?utf-8?B?a3Y2RXI2dFZ2WVRzT0Q3aWZTK0NtRG5WRU5wWHFzbUFYWFhOMk91YXV2YWdQ?=
 =?utf-8?B?K2d1NEQzM2JoRmlOYnVxMXduRlZybU0wbW9hcHo0d0pUb0oybEdQcy9ER0xp?=
 =?utf-8?B?R0RHT3BIWEhOb3lCM0NHOHg5Z090a1d2L2U0WktHRWhqTGg0T2JGZUdQcVh3?=
 =?utf-8?B?SGE1ME9UTWZ1bHdwcU4vblhQSnNqMkM0TVBHY0xYMVZBa0ZYcm94U2h1VTRL?=
 =?utf-8?B?NEF2SEtZWXl0cDVDTjROQUd6TytQRHgxMzMzd0gxL2ZXdENNcW9RRVFaVjFh?=
 =?utf-8?B?QmZlYjd1RUhhcHJiOTJtRUNKN0Zyc3lrT3VQYUNiRmo0eE9MU3cyWlBTQ2pw?=
 =?utf-8?B?emNvWHJRYXR2NlJBcGhoOVU5M2JNT0k4SVhEVlJaZ25adngvS25aaXlVaXJF?=
 =?utf-8?B?b1NWOEVlemJvV1cxc1FmdDV4ak9PSlQ5eDR1c3NJTC9JVCswdU5QOUlnQ2xa?=
 =?utf-8?B?ZmNKbi8zWTBIbU1KZjdSZnZzVk15S1NwS3NXelAzdFhhV1ZtbmVOYnpOUzFN?=
 =?utf-8?B?aWttVlp0WkVxZlc5V1I2SUEwZjMrQjlKeUI3cE1WR2RaWTFGZ2RBd0g4WEw4?=
 =?utf-8?B?SHRDSnhtTG5mczk3bEM3VjJNczdMTU14YlZTNmxydkpYak5PNzJSNDFlY3VH?=
 =?utf-8?B?ejNPTlpqR0xjY2JnZ3Nwd3Bjb0cwV21WMlIwZFJpOG5pcVo4ZkVEVU81azRP?=
 =?utf-8?B?a2piZnF2Rkl2SGZLSnV6YXpBVHpGK3hDNEoyQnhqVjBoNVJjdGhYdXRtOWta?=
 =?utf-8?B?VjRiVVE5dmRUaHd3SmpQNUJVdUhuYTNha1U0NS80Q0wwR0ZXUEFHeTMydFRC?=
 =?utf-8?B?SGVTek5OdmRBMjdRYmVzdlFucUlDQ1JoU1BBQkNIcWYvY0FvNnpONFNRT2FD?=
 =?utf-8?B?OTlkZmtGQ0J0RTRPTnZCQ2ZJUTVWYU9aZm5hWjhoR1hWM0o0VjRacllXbndj?=
 =?utf-8?B?ak4xT1pDSWVVNHdwQkxOQkd6K3MrK3lqODFzZ0dkOVdLSkR1K21BWERxMGRK?=
 =?utf-8?B?QzZQTW5zbW0wNzIveFRPbmh1WTVkUG5id2Z2NW54dUcxVlRQRDVGby8vL1hF?=
 =?utf-8?B?Q2VyeCt6OSt3M0FmSXc3cXBocWZTcUk5T3BEUDFyS2syVndtN2VkR3g5REJG?=
 =?utf-8?B?aEFmR1lqbncvajFuczdBbXpjS21HZVI0TWloT2ZHam1jM25XbXBzZXFmV3I1?=
 =?utf-8?B?MVliMHk4a1F6bmhXUERsV3ZHaFdJN2drN1FyV0NHc3JqWk90UUV5MGZER2tM?=
 =?utf-8?B?azBxZ3VudmJQSGgzcW9ab3FmeU9lTkJRbytqVkdTMEtsc3BhOG5KQ1lQbnJ6?=
 =?utf-8?Q?1Z+F30bAXAIYxoFjwTFaP2ZTm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114c3ea9-ce52-49b2-cec0-08dddf2b4767
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:18:33.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEgeTgk9Ony5MTxCdZxE6IeZ6122R8CaOx2Kp9mwSxVVQOKbDxezHzRzj/YPjGMZ+QJvC4yqgZsoVDU3TblIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6863


On 8/19/2025 9:37 PM, Miguel Ojeda wrote:
> [You don't often get email from miguel.ojeda.sandonis@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Aug 19, 2025 at 3:13 PM Liao Yuanhong <liaoyuanhong@vivo.com> wrote:
>> The header file <linux/stdarg.h> is already included on line 6. Remove the
>> redundant include.
>>
>> Fixes: 0dec7201788b9 ("sprintf.h requires stdarg.h")
> I don't think this fixes that commit -- `stdarg.h` was not there back then.
>
> Instead, this commit
>
>      be06b53d3af0 ("lib/vsprintf: include stdarg.h from sprintf.h to
> provide va_list")
>
> also added the line, and I assume Stephen only needs to drop one of
> the lines in this merge resolution next time:
>
>      3f413b9a3770 ("Merge branch 'next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git")
>
> Thanks!
>
> Cheers,
> Miguel

Thank you for your feedback. Do I need to submit the v2 version without 
fixes？


Regards,

Liao



