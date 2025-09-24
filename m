Return-Path: <linux-kernel+bounces-831073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B7B9B6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14830166A16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB4D321438;
	Wed, 24 Sep 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Xj6GohKK"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022105.outbound.protection.outlook.com [52.101.53.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8731D727
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737936; cv=fail; b=q2e+CNaPBXlLWsf3ex0SVQ0haBh5e8w6ZhQgIWjlK/gYzkydEJOxYdwTiI7s5A9dglMueSAPRNlISHpeP/D2mwE9lqkwKOz2Mhc1uuf0JF+HTbfaWB+IuaBKHJt1eQL2Jq8Cy6IGYmvDTgITUn5gLQ2CKMTwGLDD4ZHKn2MVoCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737936; c=relaxed/simple;
	bh=aoo2CFKElR/t/sZycuzhNjyZEbSTYFzhQnVJj0czIe4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jwtsNqxE3lEoOZ+GRNk/l+0R1q2Pzxanbh1plKDOpqEPNCb4BL1OFcseIkLjz72zVYeIwak8StDc1Ur5z3qboxH5bYVms8L203iypw0Rbms8Bvj+kn5V/zY2ZSMquIzkNgTib+qNH+24A3TkxRyPBD4a016sZEbcOicTr6q1QcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Xj6GohKK; arc=fail smtp.client-ip=52.101.53.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+oXx8e9swOiaXJudcpKrdCotQL3ZPT01m0bjGTc8l3qypg0FII3enQnKCRUwLtEdeluzlCXhbXDzxS6lm8Syvi8BIbpRdqfdwuDdf688WO54RENnoiFBpC0TkpkMYy2K6aCEvFMbPKJihPANfjLI2SBYUlb4Zfsu3f0T7eBw4pdPg+ynfDRGh4p++2xXLExlsvXDGLrzyQwA+DlNqQYw7nNYx2v+uixLe4/UC409MQHQgQE/xB9WhEr6V0MP6ajWVwlZaxsXPsZcIwTY44AsNnC2cMfAVVgZ4Xcq3reOc1aePPpqeYC7CNM3zLs2pFFPFxRVm8rC/FyD/2hJ1efig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxUSSygi2Y0hssBDACdA9pllIXnq6nIcFS16XMhTtu0=;
 b=EgbJjyIHnEq18pCGnolh5XV0pmRv2KLxtmrgeVm0guWjUEuDMCrhxX/cepx0Duh+W8HAND1T2b4yXpkzGqO50tPMOo0zxpvipX5hBF5jEngj2fPJZFefLezsSnDxELxpim2Oc2WC31M0yazDS23GghrkDZek6lvV0ZnCWPSL5UWlSX3n13UDuibrT4HGt3hwnexTZ6EXz9CVOQlE1MZRH2sSrJ0DlBtxtnGWxyas32Vo0ZTzg+ymxejJqQ0OTq5uUN6JjkZ6WhT29z3IXdal66liGjyv8IyuARIKcq+iucXxCFGR+yoy6o5QeDpwUBJ3slyRBzafvnZsKrRlmLgaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxUSSygi2Y0hssBDACdA9pllIXnq6nIcFS16XMhTtu0=;
 b=Xj6GohKK4X/GB6xZqdqNqHiBRnasmlMUVYPpKqPI24TBBPO3EXvLelPhxssPVf+Yg2GjGVPNhHKlyul7yeDdYvDHhCTSJNivGinE8ltil02SA2F9RvyhMKQQp5enmZqKq3ZsmtPinGmsJ+yOP00Ez0uK0f0Ii5NM493vAHkY2LM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BL3PR01MB6865.prod.exchangelabs.com (2603:10b6:208:350::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Wed, 24 Sep 2025 18:18:50 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 18:18:50 +0000
Message-ID: <6ec322e5-f22f-4115-ae1e-e3ad0ee7d3ee@os.amperecomputing.com>
Date: Wed, 24 Sep 2025 11:18:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] arm64: KASAN + KASLR may cause reserved page to be released
 during module loading
To: =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
 =?UTF-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
 =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
 <chinwen.chang@mediatek.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "andreyknvl@google.com" <andreyknvl@google.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dvyukov@google.com" <dvyukov@google.com>,
 "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
 Will Deacon <will@kernel.org>
References: <6065525d47bf338646d53182b9bbc4a25ccfda82.camel@mediatek.com>
 <cc9b8e02-e287-40c8-ad9c-34efd5e5e3f6@arm.com>
 <cb9760e573d57072a28a45014f2c7938c083cdc2.camel@mediatek.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <cb9760e573d57072a28a45014f2c7938c083cdc2.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BL3PR01MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: a328395e-c568-4429-ad52-08ddfb96cf41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkJjaWlEa3drWll6dXRwNWk4eFpvS0dhaUFKWEEzMjFpNTdKVE9WUGVKTlMr?=
 =?utf-8?B?UDRkSzMrWnlLVWJCa2JHNzZxL1NZSXVwWFZXMzNoUVBLeWpwT0ZQR1ZVaXpm?=
 =?utf-8?B?RnJYQnFMUzJnM2VqWFRPYTZyNnBSNEdHK2Q4U05rOXpxTzlBR21YM2xoMDVs?=
 =?utf-8?B?WUxCRS80bFF2QW5vMTByeFpCQjVjZFp3SVVBdXpIbTBQb2JTV3k2b3M3bTlU?=
 =?utf-8?B?SmMzbXVJYmI4YnVoQkR0R01kdnB6eElBVyt0MFBvZ0dJRVdrSkdGZTBZVG00?=
 =?utf-8?B?VkJPTW05VS9WM0RHRjNSUDhBMXk1VEl2SWRML09MSWd5UTM5dnk5TTBtL3Rn?=
 =?utf-8?B?NjVqRm80aDRoaFgvOFQxVTR5U0ZpcDh2RTRzb3dsem9MTTNXQ2w5RWlMRldQ?=
 =?utf-8?B?bkZjOE9QSjZjNDBPL1g0VTUwcXc0Tzk5Z2FpWVMvK042WXRPVDExeEVSM2tq?=
 =?utf-8?B?cVI1VGpvQU5EVjlLNTVCbm5YL2dHRXRaS09tWWltSUEzd0JIUU9TYVh3ZzFS?=
 =?utf-8?B?eXl2NFBYNTRmMEdoUFJQdk5rSmZpbVZwN2JsVmNiVi9kR3FVeDRXL0UyQXVX?=
 =?utf-8?B?S1ZxTG9KRWFKYUlENElOS1FpZU1sNkp2WWRIVVhqeDMrVVpFVGFxVHR6NlRN?=
 =?utf-8?B?c2lWMFFMUUpvZmkyT09TQ1FDRFhSekVJMC92aDAyTTdkamtGZkN5clVDUTRU?=
 =?utf-8?B?Tkh5eCt2c0hSTFdIL2o2WVRqcVFraFZwQ0pUNFl6ZTdUVEpFU2ZOWWRoaWlh?=
 =?utf-8?B?M1dxc1FncFdWR0FKSDdnUjR4aUkrQ2lMZkJLN1lCNzF6T1NmTkpvR2VZWFRn?=
 =?utf-8?B?K1pxd0x6K1dKQnBNTVZpVnJPcDZ2dW05cDREUWYrT1dYK3F5RXlIU3FiTXBz?=
 =?utf-8?B?bUdKOU1MZlNTNHNLb0ZKdGVZQWc0cVBZSStmMVgzY0J4eFZhdGhMUFlQRWty?=
 =?utf-8?B?eGxwV29ROHIyQ2d2K1RJQXJBZjhtKzNVZCtCS21pTTNaWmtIMFQvY3VJcTVP?=
 =?utf-8?B?VUhENmg3UVZiMXlZZGZEdUhwRUpLcFhaQkZGL2gvT1FpUElpMnZkc2VDdDBj?=
 =?utf-8?B?MGVVWWkyb0U5eUV6YkhvOXJHR0Uxc21FblBYaEhIbkdVL25PVEMzQlJYSmYw?=
 =?utf-8?B?UVFYek4yNUxDWGIwUkFrUU44RkNzOUVsL1FRVlBJOGpNRTBrK09YM2o2aWt1?=
 =?utf-8?B?eExOWnMyUlBQTHBVK1ppVDRaZmtxRE9IUkRQZnVtaHZpakQxU3pVVzJYYkZT?=
 =?utf-8?B?MllSMkJZRVgyZVp5d09pWktnZ1R4QmF0TDg2bXR0cHhzdVp6Y1AzeGFuell3?=
 =?utf-8?B?TldISGxPdWtsZ1lWN2VPNi9qTWJVSWNFdzRmNjZoOVdxek9wWml1d3pOTmhi?=
 =?utf-8?B?ZVJ1c3dSVEhJdW1MYVFXMWt5RklsbzNVSUlWWmY5d2FyaTBrUHBXQUpCWlVO?=
 =?utf-8?B?djJVNWo3Sk5lcHFkVWNYdHhNT3VScVNFbEJZQWRHYkN6UXYyR1gxVFF3RkNY?=
 =?utf-8?B?NUM2b1VTWmppVnFzUk9hYkV4VTdMTjFSWWlTM2tybFAzRDBuNjRtYU1SeFly?=
 =?utf-8?B?YWQrTktsWWRxalpqL2hJaGxWNVRwS3lRNS9yZDJqNmswMWZMS1YrSURVTHhz?=
 =?utf-8?B?NjZQcjVRME5hN3lLRkwxQ3YrWklLcTNUQVdYQ1lqdFg1dThRTnhqV0VVSUxF?=
 =?utf-8?B?K3FNQnVNQkRRVFVrN2cxWkdmTWplTjVLNVZFZVpmdVFncGlrMWV3RG1KS0pr?=
 =?utf-8?B?dFFSTnJ2RmdRV2F2T3BoRk1sYXltaXRibW1jeWNzOFdGbWR6NVlOcExhdGhr?=
 =?utf-8?Q?DIUSsyER0vUWswMRHCNG+NrQ7dzk/lMRngHCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGFHQnQyUjNPbEVlSnJ5OEg1QnI2ZUEvRklhZUJwUEpjS1Nld3krWE4xVHF0?=
 =?utf-8?B?eWRrVFFZS0ovUGFMb3luSldkWDg5K3IvY1NIdVhEVGpRK2ZGSFN0TTMyYWhy?=
 =?utf-8?B?ODhOWTREc2t4Zi8rU3JHOHJLNUxma3oraC94THdRenAzNEVzYmtwRE85WUlQ?=
 =?utf-8?B?NVRoSFY1SDJSaWRzdExsWTF6S1VmMm5sUEhrQ1pnd1REM2QyaXY0aG94MzJx?=
 =?utf-8?B?ZDZCTWp5RVR2eEkrdGt3SGpBZUJRQ242WlB3S2t4eHE1ejBSajMrei9DSVhr?=
 =?utf-8?B?TEtRRUlzbWE4NWxqL3VRbTUwTUJFODBOdUkycUxQWUloUUxwTEljeWg4djhT?=
 =?utf-8?B?M1BCaG81cGQrV25Da2RyeGlwR0didjRLUlAyR1puZjFscnpuNFhteVM5N21m?=
 =?utf-8?B?QTNLQWlLV0R1dlBzSExaaE4vRUNNQUsvMWJSNEZlMVFqRXJpZm5DTFBCTnJi?=
 =?utf-8?B?aVdaam1Mb3lUbHZXTkIwclhzWUNFMDA2LzBtL0ZHck9GbXpZS1ZUU0JVRFZi?=
 =?utf-8?B?NFpEa0VGNUZwUzRWclZCcEd2UXBwV1M3ZXZMNjhqcDJQYUk0ckFoZFpzWlBl?=
 =?utf-8?B?a1h3eGhDenFSMk5TMjkzOFVxK2s0VDgyYWFHN25Rbzh6em9jSVNTNWxaZEJJ?=
 =?utf-8?B?OUFTdkhkTDNVRnllVlpDcU5vajR2VkUydytGT0FFKzYwWElzQnVNcnNBZmZE?=
 =?utf-8?B?MkJRSmRjd0Fra3lleVlLb1pOK0lXOHo3U2xtM3BXZkoya04yRHEycG9FdFo2?=
 =?utf-8?B?UHZoR2tMb3cwWkFSZXBmM0EvTW5nQ2l5eWhaWjZPZzVoamZXR2NxajE3ckF1?=
 =?utf-8?B?WUw4ZVdPNXM4aFN4Y1Y4dEFUSSthVnlGQzAxdlFkRTh3eHJSSkhEejNzOUEw?=
 =?utf-8?B?TGJaZFpLMVdtNTkwYTBHVEQvTGR5Rzg1RnQ4NmgzNUtmYVZQc0swWWpTZXB4?=
 =?utf-8?B?TzNBNWN6NUVBLzBUQ1VRZ3RzemFDUFlEbnFuMmp3bFJ6Y3d6YWkyNXBmMkU1?=
 =?utf-8?B?RnJQOENva0VwMzM0UEo3TlBrQzVPemJwUGh3L3JaNkVTQWhSN25NdkFGUkov?=
 =?utf-8?B?eDZERWdYMkVhelJSeCtxZTRUc2V5NmxkOXJLMjRKV2c3S1FJa3FOZDVXVVEv?=
 =?utf-8?B?ZHlqQzk0cksrYlNEdFZFa1h4U0hLWG0wTjZYWnovVSs3YytlMDNkZjVxd0sv?=
 =?utf-8?B?VXl2VUQrL1FkeW9kQmdPVTc4ci9mc2pKb3Mya1BCN0c5U3I3ZU5yQnlIbEE0?=
 =?utf-8?B?N0FXV2luTzZDbktFMzFXT21PTUNIV0Q1MG9pTFovWm1GUXZEQmx3eWhzeSsw?=
 =?utf-8?B?R3RzS01OTzhKRzJsRHBSeFpNUis0UFIxckI1NjExY3hielE2Zjl3aHZ0VVRq?=
 =?utf-8?B?RnlKb1VPaTFhVEZFYVhXWVprODErZU9ieVE3ZEwrRml6SmU2M0pKWWRqSFhC?=
 =?utf-8?B?Q2owYjZyWG54aktWRmhDNWdBaHZIVVIxYTBLZ1NqcmdwRGxRbm1zWmVNanYy?=
 =?utf-8?B?K1E2c3BTVEQvZ3VFMkF1ZS9QQkdieUtUbDMrTENULzRUdFZHOUhNSWIyT2FC?=
 =?utf-8?B?eDRTMVhnWEtBR3V3aHZ3Nkt4Qm1DbW4vc3pyWnRLd1ZRcllINEpSeERHbktq?=
 =?utf-8?B?TXFuVDBYa2NIOXhOc0E0dnh0eXo5NlFieSthakxZc2NuSDV3dENQaWhTd2Vh?=
 =?utf-8?B?NkJFemxBYW9uK0xDUTl6RVlHOEU3TmZXc1FCUjhxWUp4eEN4VkhVVCtHdnlr?=
 =?utf-8?B?Y2l6bFpKNGlmWFcrWmxENHNOYzhOSlZNOHE4MmsxOFdqajQ3b2pSWnEzSkNV?=
 =?utf-8?B?Y2dVMFZOMjcxNHNzQ2Q3UHJ5QjhSQnB5MHV1ZjFpL2pSa2t0MVFKbVdKZVJy?=
 =?utf-8?B?bGxSUmloMVlUdW5EdTgrVEtRMXFhaHc3ZXFNRXdhT3I1anc1S1VjczVWNlJj?=
 =?utf-8?B?NEVOa1FKQk81SWt3RGx3VWdMK0tBaFdMSENxOWJJbzJURlFvNnlRbVo1bEtj?=
 =?utf-8?B?UXk2cmdPdVRZOC9tUURHNnp3U3MyRUd0R2NiS0pVU0xra2dKaGpXN2FNZEky?=
 =?utf-8?B?c3lLQXExYU5jUUo3MUJYZE1HdGhHY0RudW9RL2dpTHRQSGJYM0RqTmgvMHJC?=
 =?utf-8?B?a2RjNGlJRnZkZVM5eHhoa21WL2RZVFV3UnYvbFFVWEpvZGFwWkdCcDNjRGY2?=
 =?utf-8?Q?aftfNwC6aSKfA2m4S+ntxs0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a328395e-c568-4429-ad52-08ddfb96cf41
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:18:49.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaX/HZpGs9QVxC4q6h0i4vHFoKRIafkRbZACwZM3jRRM6dBgRUSfbqxOD1UZFPBWE+L1cMCna7iKAZn2umsSTq1Sj2y4mavaKyibUd5Uh6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6865



On 9/24/25 5:41 AM, Qun-wei Lin (林群崴) wrote:
> On Fri, 2025-09-05 at 15:30 +0100, Ada Couprie Diaz wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Hi,
>>
>> On 04/08/2025 15:03, Qun-wei Lin (林群崴) wrote:
>>> Hi,
>>>
>>> We have encountered a kernel panic on arm64 when loading modules
>>> with
>>> both KASAN and KASLR enabled.
>>>
>>> Kernel version:
>>> 6.12
>>> (also reproducible on 6.6-based Android common kernel)
>>>
>>> Config:
>>> CONFIG_KASAN=y
>>> CONFIG_KASAN_GENERIC=y
>>> CONFIG_KASAN_VMALLOC=y
>>> CONFIG_RANDOMIZE_BASE=y
>>> # CONFIG_RANDOMIZE_MODULE_REGION_FULL is not set
>>>
>>> Reproducible:
>>> ~50% of the time, when loading any module with Generic KASAN +
>>> KASLR
>>> enabled.
>>>
>>> The kernel panic log is as follows:
>>> [...]
>>> Comm:kworker/4:1 Tainted: G          OE      6.12.23-android16-5-
>>> g1e57f0e5996f-4k #1 eee834a579887c0f97d696d30c786233f4fbfcdf
>>> [...]
>>>
>>> If I disable KASLR, the issue does not occur.
>> With the context provided I was not able to reproduce the issue
>> when testing defconfig + generic KASAN on the following kernels :
>> - v6.17-rc4
>> - v6.12.23 Upstream
>> - v6.12.23 Android[0]
>> - v6.12.23 Upstream, compiled with LLVM
>> - v6.12.23 Android[0], compiled with LLVM
>>
>> (I tried to match the version that appears in your trace)
>>
>> I tested on both QEMU/KVM and hardware (AMD Seattle), by loading
>> and unloading an out-of-tree kernel module repeatedly (an APFS
>> driver[1]),
>> with no issues on either for all tested kernels.
>>> We are not certain which specific patch introduced this issue, but
>>> we
>>> have confirmed that it does not occur on the Android common kernel
>>> 6.1
>>> The problem was first observed after upgrading to 6.6-based
>>> kernels.
>>>
>>> Any suggestions or guidance would be appreciated.
>>> Thank you.
>> There's not much information to go off of here, my questions would be
>> :
>> - Are you able to reproduce on an upstream kernel ?
>>     (Be it from kernel.org or a "base" Android kernel, like [0])
>> - Are you able to reproduce under publicly available emulators ?
>> - Are you able to reproduce with specific, public modules ?
>>     (Something available in Debian[2] for example)
>> - Which compiler and version are you using ?
>>
>> It is a bit of work, I'm aware, but given I didn't manage to
>> reproduce
>> the issue, it would be useful to have as much info on the context
>> so either we might be able to reproduce, or you might be able to
>> pinpoint the source on your side a bit better !
>>
>> I have not seen any other reports since yours, nor did I see any
>> patch/fix
>> that seemed relevant, so I don't have much more to suggest sadly ;
>> others might.
>>> Best Regards,
>>>
>>>
>>> 林群崴 (Qun-wei Lin)
>>> Qun-wei.Lin@mediatek.com
>> Thanks in advance,
>> Best regards
>> Ada
>>
>>
>> [0]:
>> https://urldefense.com/v3/__https://android.googlesource.com/kernel/common/*/refs/tags/android16-6.12-2025-06_r5__;Kw!!CTRNKA9wMg0ARbw!jdaUX7F85FvZJqXX3Uhv5JtUbBtVS1J1KG-WY6odDcKfDjgJEGyCTDMUIN1DVh8uTJn0-ve1n2EjTAA11nsLXit1tcia$
>> [1]:
>> https://urldefense.com/v3/__https://github.com/linux-apfs/linux-apfs-rw/__;!!CTRNKA9wMg0ARbw!jdaUX7F85FvZJqXX3Uhv5JtUbBtVS1J1KG-WY6odDcKfDjgJEGyCTDMUIN1DVh8uTJn0-ve1n2EjTAA11nsLXmUUvNiw$
>> [2]:
>> https://urldefense.com/v3/__https://packages.debian.org/search?keywords=-dkms&searchon=names&suite=trixie&section=all__;!!CTRNKA9wMg0ARbw!jdaUX7F85FvZJqXX3Uhv5JtUbBtVS1J1KG-WY6odDcKfDjgJEGyCTDMUIN1DVh8uTJn0-ve1n2EjTAA11nsLXkz_teg4$
>>
>
> Hi Ada,
>
> We have root-caused this.
>
> The issue is caused by an unmapped gap in the arm64 kernel segment,
> into which module allocations occasionally land.
>
> 1. map_kernel() leaves [_text, _stext) unmapped [0], so this gap is
> still available for __vmalloc_node_range.
> 2. Generic KASAN initializes shadow starting at KERNEL_START (= _text),
> so it creates shadow for that unmapped gap using early memblock pages
> (PageReserved) [1].
> 3. The module execmem region is about ~128MB; the kernel image sits
> inside that region. This means execmem_alloc() can return a VA within
> [_text, _stext).
> 4. __purge_vmap_area_lazy() depopulate the shadow (reserved pages),
> triggering the BUG.
>
> KASLR is not the root cause, but it increases the hit probability.
>   
> I was able to reproduce this issue on upstream kernel (Linux 6.17.0-
> rc7) with QEMU (version 5.2.0 (Debian 1:5.2+dfsg-9ubuntu3.3)).
> The key is to ensure we allocate the execmem into the [_text, _stext)
> hole and then trigger __purge_vmap_area_lazy().
>
> Reproduce the problem:
> 1. Temporarily hardcode execmem_arch_setup() to set module_direct_base
> =_text, so module allocations fall into the hole.
> 2. CONFIG_DEBUG_VM=y is also required to make the error report visible.
> 3. Then insmod & rmmod (any .ko file) will trigger the problem.
>
> I plan to send a patch to exclude [_text, _stext) from
> kasan_init_shadow(). In our testing, this fix the issue.

I think this has been fixed by this patch:
https://lore.kernel.org/linux-arm-kernel/93a6f8e47cce118493e250b719a927f517be12cf.1758316750.git.osandov@osandov.com/

Will already applied it to -next tree AFAIK.

Thanks,
Yang

>
>
> Thanks!
> Qun-wei
>
>
> [0]:https://github.com/torvalds/linux/blob/master/arch/arm64/kernel/pi/map_kernel.c#L81
> [1]:https://github.com/torvalds/linux/blob/master/arch/arm64/mm/kasan_init.c#L309
>
>
>   


