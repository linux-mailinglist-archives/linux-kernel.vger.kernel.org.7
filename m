Return-Path: <linux-kernel+bounces-755603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD140B1A90B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B277A6F57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7128852C;
	Mon,  4 Aug 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="grwnZ6/N"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E6224247;
	Mon,  4 Aug 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331291; cv=fail; b=k+gSxuI5OaNR8gm8N37qAyAwQMLSsTER6LvUWKBcLTK99qgRZXqBD3k4k/JSEvvX/ahfCJ/SdXaZqX2cfp9gfumyBS25auwkRgXp2ToMtRYgj3OIUGyThjyuyR4eJPmvcTwaM5Vq9CVwWN8FFK+TqjR9xqrechXioZgGxUpWT6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331291; c=relaxed/simple;
	bh=GtzO6fHZSy2UrYT1oKB1F+h7fdp/G3tZoVOs7WsXkUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmNKK8V4B4WhykpyFbrjPGlK2l43MImqhGXHxZK3s9pjBfIFene6i+2YbHgRfjMiA1yAgi6HvKYPdEL7SK0tI0DmQ6z09wtFenGm1YCLg5ErRJ85LdsprGBdZBE3DH3d1deqI7EyOep01JJVz8usR5EXDqCkROSn+0urystRbMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=grwnZ6/N; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOanF1lZDd3yLUkKA36bB17xWnU99xkNu9lgLaIlUCU8rQAeGma6VVQynBlghW2EYr8aQBFi2fCjCRi4H/P5LiHheCp4WltZAd+kZle1ZMt/dsDDzGhwB9wEvfSKSv76VF5tJoWHds2VwuZH3UU84+UG0ZSVGYo4+SG2k3erGR0OL22NkqFtuaV+Cdv+D1Lmw9CyHom4b5FDxEs1R9BbVFC6R3tCU+lIZ8/LQSgi2m5hYK6yRvxdzfmWFxp6En0+ybJj7qZmZo0+70t1UVl9mCr769g0MifCN5878xkqA1T90dkVmTfIQ9BMUW1oq32l9/5nfoJbGvepEfoIvXfdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIOL7GYQIDr4MxDd5KB+g1oZZod8hBqHLKCRajPuh9E=;
 b=p2iboJtVhznk8qP+ObV5gs6rJfeakAWymjlmsWP00sqrzTVdnHQALJJIZe9bvE7OrZxrBwbJa54xr7ZpYiLhfr7PyCIfeOTVRngvQcmYs2w6rS/gpmyWv8BGk4BCwfMTnBKLLGV+J1yUPtd5ykhOXCJ9xJH04WaWiVbS7iXY+2+HWCLIfC+PqgMOSMU8XXV7lcpgYWMGgsPGOk0f0H9ZV9xh6/1M46/x6BT1C1dnTxEK29awrc2JDcbVsTZWo7o24qezr2zMTLtp9gPa3mfrCUZFytREP9DVC55x3SJlEmeADz2QUbLTm1GNWyBMJDrDrWJR9Z426fPY3ZMd5Mmzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIOL7GYQIDr4MxDd5KB+g1oZZod8hBqHLKCRajPuh9E=;
 b=grwnZ6/NaylyeaX2WKupQKlOlNYvUwEM85HGv3tDyoBptwqtUKakQI61yyeHyNRcdISAqoHB8Kx7IC6w5BCvfqr+nDjMjyWCNvtVDtc2C93bJgO2Zhg4RpVNHjULoP5QXr6b8vjWLygcLl9XPsNTCujoh+M1O6IVzAh5OtUD2T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH3PR12MB9022.namprd12.prod.outlook.com
 (2603:10b6:610:171::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Mon, 4 Aug
 2025 18:14:42 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 4 Aug 2025
 18:14:41 +0000
Message-ID: <4efddbf1-1e98-4ee5-8057-7b3ce5adbec2@amd.com>
Date: Mon, 4 Aug 2025 13:14:36 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 08/10] fs/resctrl: Introduce interface to display
 io_alloc CBMs
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <7ca0bdcc27d4033d04131e2feca5921f85df0ac2.1752167718.git.babu.moger@amd.com>
 <7050592d-6c2c-40ea-a3c5-3e7fcf76c3dc@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <7050592d-6c2c-40ea-a3c5-3e7fcf76c3dc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::25) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c5a71b-435a-4da0-1656-08ddd382c841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TS9YZVhteVFTb1J3VHFqa0gxVGFJOFlQaTB2TWx5ckJCN2EvNFJPSHFMSWZW?=
 =?utf-8?B?R0JmbE5YQkg0QnFRUk8wUmtEYS82MlFpVGgyNEtaMzZzckl6WnZZM3RuK28x?=
 =?utf-8?B?bUtQdDdFaUxCU1dVK25ZaVViL09za1JndGVGeXQxZU1KYUhERE1nNHpHM3hM?=
 =?utf-8?B?N2kxbkdNdWYyb1FHOC9QT3V0Y0l6R2dZckdzTUMxR1ZzTktNNlBsSVFnd3NF?=
 =?utf-8?B?QTVqbXdpbkF2b0xNT1o4R2RDK29MRDJuejVWWllzd3IrNENacndZcCtYSFY0?=
 =?utf-8?B?TjlDU243aUo1QVN1enIvWFRYeFZ5ZVlqenFuTVU3QnFuRk5Td0Rrb3A2Wkdn?=
 =?utf-8?B?aXpzSkF2RFNHeWV5ZGdEMUxqNzZkUzRPMklVUnVvdklxQ0FBVC94M0JNd0NJ?=
 =?utf-8?B?VEhncTNFUmR2aS96ek9STVpzRTA1dzRTc3Z0VndGQjIxVkRjL0FaVFJxcTlL?=
 =?utf-8?B?WXQvcW5FRGQvbExnZk02QnhFOGtGR3VhS21WU1VLZG1JRldyejBZQU0xM2Zy?=
 =?utf-8?B?cWhveldYVkZnRFBKbGUya3BOVklWalFYd0oxc3RRMERjU25ITmlkb1ZPZnhr?=
 =?utf-8?B?ZnFxWG03cVdndUJBVFl0ZGw3M1JaQ3BMaWtSeWwvUHAxRmxKSDZoNkZUbU9p?=
 =?utf-8?B?VXBhRVkzTUZJa1BObHlaTHhnQS80bmFuQmt0cGpQQUJoQXlodi83MlJOcldB?=
 =?utf-8?B?b2JPTkxrUnJNckpTR25Ma0pmbFRvRzYydXhlTHJQa0pVcWlKQVVxaUNkQ2hW?=
 =?utf-8?B?YzZNU0xwQVczZ2x3b01Oc0xhVGZMMXZnL0NFL254dVYvSUpGYXZYS1RKa1BC?=
 =?utf-8?B?eTZ4RXo3OWUzcGtjQjE5YWgvT2thUFZLbktSNmNvNzhldVFmSEdkZFBJaisw?=
 =?utf-8?B?dUpFQUp0UkFrQm1pWHBYT2FFSkU5NVAzY0dkWEF6aERMNERFRk00Y3paRmZS?=
 =?utf-8?B?MnhVSVFjejRhRnNZM2pMdFQrWHI1cmhQamNLMXZ1ZzFHcDZmLzE5NDFsejU0?=
 =?utf-8?B?cU9TL09nZjl6UUVCT1NWakx2VkNIdWdoeUJ1ejhwdGhNd1RhNXRTMTJjY3ZV?=
 =?utf-8?B?ak5sV2hiVmdRY0xpOUttVHh4NFJJaW1UVElnNklKeFluZTlreXR2NmlSSmFM?=
 =?utf-8?B?TjNlWjZNRjNmdWtOYWp0RjMzdjhIajAra0dCUDM2b1EyYlJDRi9sZjlMSFVQ?=
 =?utf-8?B?MlRuWlplQ2htQmxrZFFtOWdTWFJyZFJtemdVeVhhVEtTYncvN1JwK3ZWbTFP?=
 =?utf-8?B?OWFzVi9IRHRlQkJqUDNJL0xiTnAzcElqajAyMnJkL2Y2ckZiM3FvNDlkWnZW?=
 =?utf-8?B?S2pWR3lQbkhLdVhKd0JoUno2YnhWeHRId0ErQ1Bvc0h2YXg5SFRNMnZzcjJX?=
 =?utf-8?B?bjVwT0dHVWdzdEI2ZTh2K012aXZONXBpSGZkN1diWU02M3YzQkpyTy9LSHpn?=
 =?utf-8?B?ODEyUEg3d2pNdGhoM29GcGJ3TnJBQTBNemdpV003ZEtrSUJEZGExSExsYnZu?=
 =?utf-8?B?ZzByWjIyNFIzYXc5RU5aZ3hNVUthUHMwNk0raWxFblUzVEgxRVVoRm5xakJn?=
 =?utf-8?B?TEk2ajdDajZPRDU1K2tEWS9NaXA1cEVRNFNWaGVMZ0laWWVrcDZtR2M3b2Y4?=
 =?utf-8?B?WEFpZi9idnRuOFZWbVh2UEFPSTFsVVFIWDJGNDRsNGVwWE9CNCs3QVBTNU9M?=
 =?utf-8?B?YUFReWxrU3N4RGJ2aStHcE5tVUtzSUR0QXhVVWRtTnAwSGNNeENyOTBIcndw?=
 =?utf-8?B?UWJKaXFXLzVLSG5oNmx5Vmw1NzNSSzdOTWlTeUZrSzNzM3ovWUxaREFhWDZ0?=
 =?utf-8?B?cFBLQnl3SDNaM2U5Z3g1VlZSNHN2eitMMHUxdXNuTUg3SGFMUmFTbkdydDM5?=
 =?utf-8?B?UnhpNWpXTDRIMEhuRXZ0R05OY0VVN21vSk5BNmttcFBVTU1nWi9YTGk2Yi9L?=
 =?utf-8?Q?FlKhOtDh/h8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eERDdFQ5R3VJU1MvSVlCL0F1Sit6VTZqYXlmdDE5OUF1Q1NuNk90TDZGaUx5?=
 =?utf-8?B?eEtrTytUN1R6cVVUazhYOXdJLzFLZVJ4NmtQcU1DaEYzY053K0JiNy9jQ1lO?=
 =?utf-8?B?dEhMQmc2eVJkRTcyelNPc3NIWUNWSUJ0OTVncjZFVWVYK2I1UTJoaDZRQTR6?=
 =?utf-8?B?Y0s2ZHNFYStpMFM1bFBZN1FxaDZTcTRlSTdqT04wQWtPYnBaenJKeGVtUWQ0?=
 =?utf-8?B?TC9KNWVsMjM5R2p1OFpzcWdlMFRlWnladzBsdy9OM0loamNQaWFzZGlkOEIv?=
 =?utf-8?B?ZFgyUzRTT1A2Z0h4NFN4eU01a3YvNVVpcC83NDhzeFRvK0E5Q2k1YUdEQlNV?=
 =?utf-8?B?TUh2MzAyYzhpdmFvdVZqeU5vVWxnZUJ0Snd3WHA5dFg4OXpmbUZpU1BsR1l3?=
 =?utf-8?B?UDhIbWJKVWJ5OUJTQklpT1BGZTlRTW1iNkJSZXVWSllFYlRJQ2V0bEc3SGNM?=
 =?utf-8?B?MmY0M1JxdnRzcTJVTTYxcDQ0MVFJYnJhWFk1aFAwbU9IVFpOd3NtVHU5dzdy?=
 =?utf-8?B?bGtsREVSTnkwU1JYeUlFYzN3YTdlcnBvWEZwUzdFSnNnSEIyc0RjN0hZYWEy?=
 =?utf-8?B?MXl0blQvaTJHb0VxSjVyNSttSEtSd2Z3TDBRY2JOWWlTVWhsamlnejE2TXRG?=
 =?utf-8?B?SlBXWHQyaWwwL2hHRUErbHNxaW45NGNBSVpTNnI5c2d5S1RpamJ3cHIwSloz?=
 =?utf-8?B?cjh0VE13d25HcWtnRUVtd0pVb2Y3N21IcVRaOTkxYStITmpTeUFTMGN2ZW1y?=
 =?utf-8?B?SGhjL1pUYlFnckl4cHVrTmRic2VoallQZEczbURHRXQ0bnFMcUFwUUlKRytE?=
 =?utf-8?B?alROcEo1SnRFcllQRVkwNFlnTjJEUm1oSWhCWDdNWU45VWNGR1dOVDVWYTBB?=
 =?utf-8?B?SDN6dHFPZGhkVEZaUXdkeVpVVExvNWxNWlZqb3FyZWpoOC8rV0hOWmNyV0xT?=
 =?utf-8?B?bDRWUDJwY1NVTGU2RGszeVNtdlVUZUlCMzQvbVMvdUIzNkRxcHhpalVyWXR6?=
 =?utf-8?B?VDJQR0M1RDdpVGEyejk1N1lFUFJ5czZZd09pL040ZWhtSHMwaWpsTW8yZUJN?=
 =?utf-8?B?b1FkZzVvTU1BT3Y5ZS9FOGJEWkNEdjVhZzUxazhkWnVjQ1JrV0dnWlBEcVdz?=
 =?utf-8?B?TGxMQmRMZk5wd2ZrcXcyVi9COTl0RktuWitBZ1hGWTd4R3NUd3BtYlJXMVF2?=
 =?utf-8?B?NGR5cWNrOHorOCt1dzI3cEdoSDl0UjFoeFFrMHpOdkhKaDFGVHZleFRSS2M5?=
 =?utf-8?B?ZzlwZ08rRHF0UTY2cUZ0b2VNVUpOR3FXRjB1MVczRUJsM2VjQ0YzTStHbDVL?=
 =?utf-8?B?Q3ZzNi93VWpKUzRCNHg2eFcvZzliMW01YnhHRWxtZ3FYMGFaWmFJU3FjRWdI?=
 =?utf-8?B?ekhNK2laWXJaTGM5QmF4eWlXaDFGVzN2SnZRVkNYakN2K1FUVkIybVZNYmN5?=
 =?utf-8?B?S0lNZGVRTnphU29iNmRTRnJOSzBlRUNzMWFsWDBUOVF4dTdnekR0RFFiUmxX?=
 =?utf-8?B?eTJCNVN3R2FkaFBlL1ZCcnIrSFVleW0xVWdkaVRNRTBGVU4rTXRqQS8rckhE?=
 =?utf-8?B?ZCs2OW5JWC82L09aMU1VdE00cTR0QldlZGxTMUVPUTRkZGVyZjNhU245NlRh?=
 =?utf-8?B?ckFhbENQeWlrZ0dtZWlaRy9jVmE2R2VyVHN0Y2lnUFpaTlVQeDVnTHpiaGtX?=
 =?utf-8?B?dFJTcE9Ia0FtcEZGRm9ZQ2dtelFZYkxvRnhSMG1yYlIxcTRsQ1FUcy9kQldD?=
 =?utf-8?B?Tjl4c2toaURvZDFNMWNQc0JyMHY2ZngzY2FSdUxtNjBONFc0MG1PanFJWGw0?=
 =?utf-8?B?NS9yUnMxcHZVQm5aVHBlZnBYa05YUndLVHRJcWphZjJvR0w5bGdNMXRWQ0V3?=
 =?utf-8?B?SFJvYnFCd0dUTUFLSCtXV1lUU01PWGEvUmVySUE4czB0YkMwcnphazd1UkJG?=
 =?utf-8?B?QmtNK2J6cnZxSWFiejZzSGh3TjhGcGxhN1lRVEZVV0F1cURSemVZTndFcTlG?=
 =?utf-8?B?V0lqNXdUL1NQVUIrZTdITGlJZHN3OHpJN21ZRTBrQ01GcVdXK2ZJS3dLdDk4?=
 =?utf-8?B?T2ZJVjFtekltWXI2TGFNRlBvaGU1bW9SZ1VmZFdBWjU1N3F3RXZrcEFWMUVF?=
 =?utf-8?Q?6QWk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c5a71b-435a-4da0-1656-08ddd382c841
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 18:14:41.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLmzzqHf9NkS7PoS+5sGa+twrDTAtoQDo1oJOugYfQwG4m/iYY8GIwxemgnw+o9j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022

Hi Reinette,

On 7/21/25 18:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>> The io_alloc feature in resctrl enables system software to configure
>> the portion of the cache allocated for I/O traffic.
>>
>> Add "io_alloc_cbm" resctrl file to display CBMs (Capacity Bit Mask) o
>> fio_alloc feature.
> 
> "o fio_alloc" -> "of the io_alloc"
> 

Sure.

>>
>> The CBM interface file io_alloc_cbm will reside in the info directory
> 
> "will reside" -> "resides"
> 

Sure.

>> (e.g., /sys/fs/resctrl/info/L3/). Displaying the resource name is not
>> necessary. Pass the resource name to show_doms() and print it only if
>> the name is valid. For io_alloc, pass NULL to suppress printing the
>> resource name.
>>
>> When CDP is enabled, io_alloc routes traffic using the highest CLOSID
>> associated with an L3CODE resource. However, CBMs can be accessed via
>> either L3CODE or L3DATA resources.
> 
> Seems like something is missing here since this is motivation for a behavior
> but no mention of the behavior being motivated. Also please use imperative tone.

Sure. Added motivation for this.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  Documentation/filesystems/resctrl.rst | 18 +++++++++++
>>  fs/resctrl/ctrlmondata.c              |  8 +++--
>>  fs/resctrl/internal.h                 |  2 ++
>>  fs/resctrl/rdtgroup.c                 | 43 ++++++++++++++++++++++++++-
>>  4 files changed, 67 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 189c1ccb92d6..c22a9dd667cd 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -176,6 +176,24 @@ related to allocation:
>>  		When CDP is enabled, io_alloc routes I/O traffic using the highest
>>  		CLOSID allocated for the instruction cache (L3CODE).
>>  
>> +"io_alloc_cbm":
>> +		CBMs(Capacity Bit Masks) that describe the portions of cache instances
>> +		to which I/O traffic from supported I/O devices are routed.
> 
> "are routed" -> "are routed when "io_alloc" is enabled"?
> 

Sure.

>> +
>> +		CBMs are displayed in the following format:
>> +
>> +			<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
>> +
>> +		Example::
>> +
>> +			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
>> +			0=ffff;1=ffff
>> +
>> +		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
>> +		resources may reflect the same values. For example, values read from and
>> +		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
>> +		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
>> +
>>  Memory bandwidth(MB) subdirectory contains the following files
>>  with respect to allocation:
>>  
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index d98e0d2de09f..e78828b0408a 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -381,7 +381,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>>  	return ret ?: nbytes;
>>  }
>>  
>> -static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
>> +void show_doms(struct seq_file *s, struct resctrl_schema *schema, char *resource_name,
> 
> show_doms() can remain static within ctrlmondata.c by moving resctrl_io_alloc_cbm_show()
> to ctrlmondata.c
> 

Yes. Moved it to ctrlmondata.c.
Thanks
Babu Moger


