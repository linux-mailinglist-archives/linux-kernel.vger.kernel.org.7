Return-Path: <linux-kernel+bounces-884885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22FC316BB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C321887844
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A932C318;
	Tue,  4 Nov 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b="NmlMPEzn"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021108.outbound.protection.outlook.com [52.101.65.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D75132B9B4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265198; cv=fail; b=AJ7QRe2n46Qz7DHunHvj6oHiKAwJSdjqlUYUYoBxdX6t6vTOGBGTt1UsCqCKJmhDdzdY20IyvBU+SmXqzjjDh9FFepjfzLf+dlwtJwOrtfKqE3g4glUiWki8ZRABesCjkPfpStD2dBYCve/POp26UmONaXCX89l8+QQHiRkHJQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265198; c=relaxed/simple;
	bh=2SgxYg1gloOjptjlFCf3DzTPJVhmTHss7sU+gK7KAmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lz4GHIgZVcAOPCtWAN4xppzSzn6NXJAjbKmpR8C5oTGitYdur72dhKfxtux+MqyazgfWKVPZSiqFflLiWPUwKHfdOyiBE0uBlLswMOalRm3OzHzuhiJ6Zpt07jppaHzAeYTNR8KkSqUEJQp4KPjoNrm3XTvM50dqzeBBFxtwXWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com; spf=pass smtp.mailfrom=htecgroup.com; dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b=NmlMPEzn; arc=fail smtp.client-ip=52.101.65.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3KQe1lRYLmfmCgDaU6EqHh2ODn2UM6YSmZOqKPUrtfBBvLpVXqgwvqlUB2NaqBlRQQvW4FXNXpj2x3niTT63ipQrxcw1ZSR0hfC3Lo9IvVn6TQemXu0g37SgyiRWjEXw/g/GffN3gW71CCC8vzjhqy1JYvAEB5Q8XGBfUTpxCSALAK4igaQrrVr8W+pMB8ZKVUVRYccLKoxSoaJ75GztPP7cO8OS58CBL4v/PdPCwSvqeXIMHDnYM8XdffrYGnI6vAOiVv87oJCtXkmPXjpoM+t0OsQ9dUhFjgFmjM0KkHdD6xLj8vHUACSDmhHjiLOKOKDuJxpZcTV/gPPeMhRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SgxYg1gloOjptjlFCf3DzTPJVhmTHss7sU+gK7KAmc=;
 b=ksx08R/oCRBmB3MTWIWiVWhjQcND6g/2I0GXAwxTl2KZ0OW0jPv6OuPFa+2tXUVpardpgxyi6OXu7YFQFpuwQ7B7TBDBjO6sI/RDQ252oE9rGqNZCCxlkWwIhrkz+X5fdCIrBpTGgdQsku53kU2FpQqlqMaHEZXMWH5bDnTqXsoXJ4CCYnpWmWQUNUc/6qD3BkVCP12in1juQVX2iLRqxe8UTboa6ofUhx7igagi2JW1Uzxbon9xitb2eLtzH3hRW797rUKHXKQwKNMuVESQ8pGreM4CUyX6aAMbd2o0SOC/STN7pCOx7TZJWddGcz3qQr7OUHDohQNF95gxI4dLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SgxYg1gloOjptjlFCf3DzTPJVhmTHss7sU+gK7KAmc=;
 b=NmlMPEznz9v3XfZTNdDx+8e+bytL78ZA3R5b8lWKYXwxtsTW1hp09jODrNOOBz41F/pCQbI3sh+Cobc1saGC8rED0UVM4a7nUwAKVXAD8H2ieeBmvOfpJrfQePbbyw7Tk786X6Z6/xUO8B0jmFT8YhZMmsWyiUZdMnQFnR8RHMinIbF1baFmFZmzJVI47nmxbn0RIJwsslkr3GaKsz9d2PkPQbxay5Bc7CtzTtDQ+PQqoQlBt65fCHbLtrOnkaXk5cruOSUiqNcPR6L01oUVklmRacvE3AL5AIyvoqTrazL/gzzKBMRngA/ZlKX4W/VST70HjbHOossUZBHw8jLObQ==
Received: from DB9PR09MB5685.eurprd09.prod.outlook.com (2603:10a6:10:305::15)
 by VI1PR09MB4176.eurprd09.prod.outlook.com (2603:10a6:800:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 14:06:31 +0000
Received: from DB9PR09MB5685.eurprd09.prod.outlook.com
 ([fe80::69d7:28cf:73b4:7552]) by DB9PR09MB5685.eurprd09.prod.outlook.com
 ([fe80::69d7:28cf:73b4:7552%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:06:31 +0000
From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
To: "conor.dooley@microchip.com" <conor.dooley@microchip.com>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Aleksa Paunovic
	<aleksa.paunovic@htecgroup.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "cfu@wavecomp.com"
	<cfu@wavecomp.com>, "conor@kernel.org" <conor@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>
Subject: Re: [PATCH] riscv: Update MIPS vendor id to 0x127.
Thread-Topic: [PATCH] riscv: Update MIPS vendor id to 0x127.
Thread-Index: AQHcTNNlUqzeKAlBlk2IdkuCz3mYBrThgu8AgADmswCAABekgIAADYIA
Date: Tue, 4 Nov 2025 14:06:31 +0000
Message-ID: <bb3a2237-6dde-4231-a016-faf190f9a877@htecgroup.com>
References: <20251104-iciness-ranting-29dd93fe6a7e@wendy>
In-Reply-To: <20251104-iciness-ranting-29dd93fe6a7e@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB5685:EE_|VI1PR09MB4176:EE_
x-ms-office365-filtering-correlation-id: 191495f1-02e0-4f0e-24ab-08de1bab5b3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3ozK1drMUoyZ21ob0EvV1RBbEoyNWpybW9rRG9KVlJ0eUJidE1hVTZ4NnZ3?=
 =?utf-8?B?Q1FPMzlqcnhOQlR4T1ZPQWRrU3BDVGcwUmVibUxMdisyWTdVaXhLQmxJanZX?=
 =?utf-8?B?KzJIcTFvSm1GZS9VajFySXpPUkdqTXJNWlRoTUp4YTlyNzF1M0NHaUZvYjNF?=
 =?utf-8?B?K0V5Mk1FaUtXanRiTCtNTHp6eDIyR29TNm1UUFJKVjJrYXArZkVOUHN4SVVN?=
 =?utf-8?B?Q1hZd2tybTBKbTJBMFYzSUpLWTY1OVNyTTlabHpidlpuZjV5cU9ML2tQWnZl?=
 =?utf-8?B?SWpPZ2cwNDJBSjJzbnV3dFc4VTNPdE1aVjVtaGV4T0FITXgzMWhFbC9WVVNt?=
 =?utf-8?B?MGJiTEU1S3BxRFU1a1hpOXVpVVlZNHRubHFJZGhRM0k5UjFiOFJMSkJMdlY3?=
 =?utf-8?B?T2xFbVltV1lBL0dYblp3VklGRll6L0dzeVV3YWNEMjlRcDM0YjBvODZNL3dH?=
 =?utf-8?B?NGNzWk0ySG5VSGswK1d6UFVkQUU0RHRvbjVlMllicjZyUW1RS0FNb1ZwS09O?=
 =?utf-8?B?Q01NTVJTaTRqaXM0dThWREg1VitUNUJaaGYxTWRWaCtiMU4wT1YrMElLN2Q5?=
 =?utf-8?B?ZDRqQXNXb0lGZC8zUmd0VzluS3A4dENsMjV5RzFIN3hIaGFweVBxSmRxRXBZ?=
 =?utf-8?B?SjFqQ0JNQmY2QW9YT1FMemUyMVoxU09ZbjhZcmhUcGlGK0RVMmpDTEErZmlx?=
 =?utf-8?B?djNkNGJtVWl2ZkFhakdyRkdmTjFTcEdRVVVyYVlPWjRUTW5Zdjl4WFZMYThY?=
 =?utf-8?B?RnFmbmFYYUVsNzUyclJhSjRvQnlWNUlxdXFLRzltSFFVODlrQThWQy90ak11?=
 =?utf-8?B?MU5SRXFKVko1Z21IMEo1MlZXWmxEK1NwZ25rZTZsRmJkM1NLUU9mMXhOaXpz?=
 =?utf-8?B?L2E4akhhWmhYTysyMXFYelJJMTQ2WTdwazVlK1E0d1hzektYbGZ5dXNOT05W?=
 =?utf-8?B?M04yTUFmNUlMdEIrZWRZRU44TnhoTlNySERsbHRsNSs3Y2lLaTFVUm1NNm5M?=
 =?utf-8?B?a3VFUmYyajMxY1lUZEdtUDlhZmh4bE9PdTM4QU5nTnVYMXRVSHlVWENyWjJi?=
 =?utf-8?B?T2NDUHRHcklhVkdiRFBjSFlJZEUwZTBPbFBRektBcHZVQmJWaGljSDJjVkJy?=
 =?utf-8?B?SjZsUVV4STNlOHFTaitNK2JPQjNXYXpnUHd6eDBpclAyTTh5eGtBTDdJT2tP?=
 =?utf-8?B?cUlta2VpK2RNZWIwTWtTU1Y4djYzY0pZTmJsWHJOdlJjQ3U1Y0lBN3JqYVFJ?=
 =?utf-8?B?SWhrd251Y1ExTHZKdDRNcG1YUUJvSStlR2ZKVG1lZEZlRDVpYmdOMExuN1Nv?=
 =?utf-8?B?R1ljOHJjSHVzdHlEcjJyYjZQTHBwbGFSU3B5QVl4VG54U1RCYVJaUjBLVFY1?=
 =?utf-8?B?UUJUdVFsK1lDYW5FcmVRcXlpYWRXZk9wanNXc3FnWkZmT1JJNFdMMEVxeTR4?=
 =?utf-8?B?UEFOZDVCYkdRZFVpVWo4R0ZyRStkM1NXSmUyK1JsdVFKZTN2YTZTSFVpYk1y?=
 =?utf-8?B?Uk56UTNDY3RYdlN6RDhoTkE0NGNXWHhML2lqRkkzMjFhVWlocmNwVVpuN1g2?=
 =?utf-8?B?TDFXT2VPWEpJNlhlOE85L25VK2pSOW9tQit5ellmTlo5eUQzMFZlQ1dZeTFp?=
 =?utf-8?B?dm01TVFCc01vOC9RVTdacGpyL2p5bzJWVlJHelR2akQwS05JdEJNTzlKV3JL?=
 =?utf-8?B?cVpMa21qUU1JcHpYMjI0STdBY0VvNWpSRFhONEx3Y1RWVEFldzkrUGtqa05o?=
 =?utf-8?B?M3FCY1daZy91LzJlMWRtZ3ZBS25NZ0M1eGlwelpxNUIySW82TE84a1crNVR1?=
 =?utf-8?B?cVU2VWxNeEI2OFpySW1sd05WTDlYaURvYTkrTHVEbE8xd0JZNkZSMnhvUUl4?=
 =?utf-8?B?TVp1WDkyUFdhY3ducm9OM01rS0JwTzlxSHFUQ09qaE9VVXdZOERsMUNFUjh4?=
 =?utf-8?B?bjVFRGNKdlZNT1ZQMktOQ0ZsNHNaRXdGdWNZR2NyVFBCd2d4a3lMdGZiWDFP?=
 =?utf-8?B?cUdHU0ovMGx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR09MB5685.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkJUYkJkd1grWEpCMkpjK0RlUXMxYXRpNXk4bnlaV0x5TU1nY09YU2lrTk55?=
 =?utf-8?B?eXFUZDBUdnVuN1RaQlB4MzM3bWVoc3pPa0FNNFdxZlNmUk5Tam5JSGg5UW9Z?=
 =?utf-8?B?RVIyZ3orYVRLeXVZWXIrWHR6Zzhqd1Vta1lWN2taekhNLzYyRzZlMHozczJJ?=
 =?utf-8?B?ZXh0UHRWTEQ2d2VaU3dsWlFYTW5ZLy81VWpHMEo5VyttVitpMlpoMFNUeWZt?=
 =?utf-8?B?WmxVMk5FSSs0NmRFM252QlRtK2hzV20wano5NzNzTTNuQTNRMzYvbnJGT2Ry?=
 =?utf-8?B?Z2lnSVBJMUp1OE5pdG9UNGJZNUVNbDdyN281d3BJbElXNnYyb0tYUStKbXBj?=
 =?utf-8?B?STBCTWEzaXRGUDV1YlpDTnR4SEVISksyaHdKYXR1RDRnaStVQ1g5M2x4Rlk0?=
 =?utf-8?B?WHJhNUJNVmU4SFdyTTlsTUdlTW5oUGd0TmZZQ284SjZyZnlMeEZzc21rYUVH?=
 =?utf-8?B?bldNS3ZsQ3BVZDlsaXFGTFJEbzJJLzh4TFZZaFhIdURpNHh4dnVWR3owNTZD?=
 =?utf-8?B?bUlZSnllYXFyUkhxQ1RjOGpVV0I4cXkxNlhLcDRjN2RkMTBaWkUxOEZBWEpE?=
 =?utf-8?B?QXBFd1hFbmNyZVRQMDhGdVc4Y3krQWN3NWo2KzlCdldDYlcvQnF4YTR1SElv?=
 =?utf-8?B?SjgwOGI4VmxoMDJEMlRxZ2ZIZ3oyRWpSYzlHbVhtZWFST0RkWERIekpOYTNK?=
 =?utf-8?B?czN1REY3ZWRVTytZMzBJenFLZ2thSTJZNXlSeTMweHFqdkN3ai9ZSkhrOUtz?=
 =?utf-8?B?Z1MzTHZHZytqbkZMQXNRYnkwWDJybldQWis0SDNhWS9ITDNZVStORkhpWG1t?=
 =?utf-8?B?Nk1WUHR1QUlCbkFYRG5yN2xxQlY5VmxaRGNRbXMrNTVVMWNZWVFnUmllVnlB?=
 =?utf-8?B?dzZudWRKOFQrUjJsK0hPbkprZ0RIVFZzVlFZY0hyY1lmbE1DVmowVHFTQUYx?=
 =?utf-8?B?dFRmaVkvQktvcUZUTmlvbUh0MmdaNTZ0bmhSMVhwc3J0TE0ySEZSZWd4U1Q3?=
 =?utf-8?B?Y1BITjlWd2NMWEI5cTVCT0hCMHZQdGtpalQzWXpBUTc5QXJ1aVVCMWwwUnA1?=
 =?utf-8?B?YXZiYXFLS2tseGVycm1Ka3B4dlBtck5xVjFJWERpZHpENVFUL3locEFtcVpV?=
 =?utf-8?B?UjcyMHYveTUvK0lwa2lDYndreU95dmNFMWZVaUtMNy92T1lEV2lBNHpQRzRu?=
 =?utf-8?B?UjJlYWhPYlE1eGhjcW1RbDZwMmxqcFhGUmxHODhoY3RuTERkVDZIR1MxM0da?=
 =?utf-8?B?R0NmZ25PKzdUemkveVBkQWpRUnpydE9oTmgrQm9FUExFcUgySGFjR2l4MlZq?=
 =?utf-8?B?aUhlaWx4S2xpbVB4WVkxZWNEZ0FYeWlpZ0Uzbmc3aE01THhkR3ZuUHJWWDlI?=
 =?utf-8?B?SnlKSVp2cGhYRkZ6M1VDOGZ1ckYzZk9uU2thM3YrYUQ1ei9qdXZOd0w5dXAy?=
 =?utf-8?B?RE1FeGhkVHpZY3Z4NU5tS1RFdHJkT2UzWjIxMFVZOUVtN1NoTUhUMDduZTFk?=
 =?utf-8?B?RUFvUCt5NjBhRGdiTG85ajVqLzFaaW1CK3pscERDSnhlZzhuNGdXQVA1Mnd1?=
 =?utf-8?B?UDI2ZzVhcjFMR3N6a1NuOWFpaHJNMyszd2YrZ2czT2h2bUpWMm9oYTc2MERm?=
 =?utf-8?B?L2dvaWJPWDd2SzN6Zzl4ZzErVTlkaFBRWUo3a3RwNlJYYk0rOG9IcGozckFs?=
 =?utf-8?B?SjN0eUVXWkt4SFVQUU84ZXI2VXl1T1d2Ny9aWVJaYlorM2ZhZXdmS3BObCtT?=
 =?utf-8?B?QlBIbktQb0xZdDUvQ0tMSFg3VC91OE5UN2xHdmFDZG9WMldZdmR3cFVYSTNv?=
 =?utf-8?B?V2RZZ1dTYUI0MlRqaDgxdFdhRjRiY2ptYzNhcThtVGRFVStkNzFJZ1JDWGZL?=
 =?utf-8?B?MGhweDF4VkNGZHZHbWlYN012TkZidm43NVJoS2E2Z1JDMTZrRFNKRDVvdXZW?=
 =?utf-8?B?SFd1MjlhUUVpWDJlUWtuaU5qSVZRVGtIZUFNMlF2emQwbVpPbXROdkU3K3Fy?=
 =?utf-8?B?K3FNMktkVFZPa2NXWFVRUDk1VXc2bmNsakxIMTFablh2WTlvRWdrclFIM09Q?=
 =?utf-8?B?YXhPUUVJWnMwL0Fkd3FBS3k2Tm5mMTREbDhkZk1ldWVjWlRnRysrK05nSFFq?=
 =?utf-8?B?TlhaZHJVS2RtT29IcUZSZU9lMmFVaDU4S0l2WitNZCt6cXA4NWdnZVV5OEN1?=
 =?utf-8?Q?9nKl+7MWZcwfOSGxQvg5QCI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90E170C31D8D6741A69E3074FBF1FAA2@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB5685.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191495f1-02e0-4f0e-24ab-08de1bab5b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:06:31.6829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnMcxAh3b1ZphfvO4hPU6ZjTFAGB+Vo06ZehpwsVHGaFjuQ0dAs6Yi4qaIo27XLVUpFW/7//xz5nO6AIYWrIQbDEtE/nO4nXNt1+nwHIy9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4176

T24gMTEvNC8yNSAxNDoxOCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KDQo+IE9uIFR1ZSwgTm92IDA0
LCAyMDI1IGF0IDExOjUzOjQ5QU0gKzAwMDAsIEFsZWtzYSBQYXVub3ZpYyB3cm90ZToNCj4+IE9u
IDExLzMvMjUgMjM6MDcsIENvbm9yIERvb2xleSB3cm90ZToNCj4+PiBPbiBNb24sIE5vdiAwMywg
MjAyNSBhdCAwNDowNTo0OFBNICswMTAwLCBBbGVrc2EgUGF1bm92aWMgd3JvdGU6DQo+Pj4+IEZy
b206IENoYW8teWluZyBGdSA8Y2Z1QHdhdmVjb21wLmNvbT4NCj4+Pj4NCj4+Pj4gWzFdIGRlZmlu
ZXMgTUlQUyB2ZW5kb3IgaWQgYXMgMHgxMjcuDQo+Pj4+DQo+Pj4+IFsxXSBodHRwczovL21pcHMu
Y29tL3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDI1LzA2L1A4NzAwX1Byb2dyYW1tZXJzX1JlZmVyZW5j
ZV9NYW51YWxfUmV2MS44NF81LTMxLTIwMjUucGRmDQo+Pj4+DQo+Pj4+IEZpeGVzOiBhOGZlZDFi
YzAzYWNlMjc5MDIzMzhlNGYwZDMxODMzNTg4M2FjODQ3ICgicmlzY3Y6IEFkZCB4bWlwc2V4ZWN0
bCBhcyBhIHZlbmRvciBleHRlbnNpb24iKQ0KPj4+IEluY29ycmVjdCBmb3JtYXQgZm9yIGZpeGVz
IHRhZ3MhDQo+PiBXaWxsIGZpeCB0aGF0IGluIHYyLg0KPj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
QWxla3NhIFBhdW5vdmljIDxhbGVrc2EucGF1bm92aWNAaHRlY2dyb3VwLmNvbT4NCj4+Pj4gLS0t
DQo+Pj4+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3ZlbmRvcmlkX2xpc3QuaCB8IDIgKy0NCj4+
Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS92ZW5kb3JpZF9saXN0Lmgg
Yi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3ZlbmRvcmlkX2xpc3QuaA0KPj4+PiBpbmRleCAzYjA5
ODc0ZDdhNmRmYjhmOGFhNDViMGJlNDFjMjA3MTFkNTM5ZTc4Li41NTIwNWY3OTM4MDU1YmEyYjc0
NGRiYTUxMThiYmE5MzViY2FjMDA4IDEwMDY0NA0KPj4+PiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL3ZlbmRvcmlkX2xpc3QuaA0KPj4+PiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L3ZlbmRvcmlkX2xpc3QuaA0KPj4+PiBAQCAtOSw2ICs5LDYgQEANCj4+Pj4gICNkZWZpbmUgTUlD
Uk9DSElQX1ZFTkRPUl9JRAkweDAyOQ0KPj4+PiAgI2RlZmluZSBTSUZJVkVfVkVORE9SX0lECTB4
NDg5DQo+Pj4+ICAjZGVmaW5lIFRIRUFEX1ZFTkRPUl9JRAkJMHg1YjcNCj4+Pj4gLSNkZWZpbmUg
TUlQU19WRU5ET1JfSUQJCTB4NzIyDQo+Pj4+ICsjZGVmaW5lIE1JUFNfVkVORE9SX0lECQkweDEy
Nw0KPj4+IEhvdyB3YXMgdGhpcyBldmVyIHdyb25nPyBEbyBkZXZpY2VzIGV4aXN0IHdpdGggdGhp
cyBvbGQgSUQ/IERvIHdlIG5lZWQNCj4+PiB0byBzdXBwb3J0IGJvdGggYXMgdmVuZG9yIElEcyBm
b3IgTUlQUz8NCj4+IEknbSBub3Qgc3VyZSBob3cgaXQgZmlyc3Qgc3RhcnRlZCwgYnV0IHNpbmNl
IHdlIHdvcmtlZCBvbiBxZW11IGFzIHdlbGwsIHdlIG5ldmVyIG5vdGljZWQgYW55IGlzc3VlcyB3
aGlsZSB0ZXN0aW5nLsKgDQo+PiBJdCBzaG91bGRuJ3QgY2F1c2UgYW55IHByb2JsZW1zIGluIHRo
ZSBmdXR1cmUgdGhvdWdoLg0KPiBTbyBhbGwgdGhlIGhhcmR3YXJlIHVzZXMgdGhlIDB4MTI3IGlk
PyBXaGVyZSBkaWQgMHg3MjIgY29tZSBmcm9tPw0KPiBJIHJlY2FsbCBxZW11IGRlZmF1bHRzIHRv
IDB4MCwgc28gd2VyZSBub25lIG9mIHRoZSBtaXBzIGNvZGUgcGF0aHMNCj4gdGVzdGVkLCBvciB3
ZXJlIHRoZXkgdGVzdGVkIHdpdGggYSBxZW11IG1vZGlmaWVkIHRvIHVzZSAweDcyMj8NCg0KDQpU
aGF0IGlzIGNvcnJlY3QsIGFsbCBoYXJkd2FyZSB1c2VzIHRoZSAweDEyNyBpZC7CoA0KDQpJJ20g
bm90IHN1cmUgd2hlcmUgd2UgZ290IDB4NzIyIGZyb20gLSBwZXJoYXBzIEkgb3Igc29tZW9uZSBl
bHNlIG1pc3JlYWQgdGhlIHZhbHVlwqANCg0KKDB4MjcgYW5kIDB4MiBhcmUgYm90aCBtZW50aW9u
ZWQgaW4gdGhlIFByb2dyYW1tZXIncyBHdWlkZSBtdmVuZG9yaWQgYml0IGRlc2NyaXB0aW9ucyku
DQoNCg0KRXZlcnl0aGluZyB3YXMgdGVzdGVkIHdpdGggcWVtdSBtb2RpZmllZCB0byB1c2UgMHg3
MjIuIFBsZWFzZSBzZWUgWzFdLCBmb3IgZXhhbXBsZS4NCg0KDQpbMV0gaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9RRU1VLzIwMjUwNzE3MDkzODMzLjQwMjIzNy0xLWRqb3JkamUudG9kb3JvdmljQGh0ZWNn
cm91cC5jb20vMjAyNTA3MTcwOTM4MzMuNDAyMjM3LTQtZGpvcmRqZS50b2Rvcm92aWNAaHRlY2dy
b3VwLmNvbS8NCg0KDQpJIGFwb2xvZ2l6ZSBmb3IgdGhlIGNvbmZ1c2lvbi4NCg==

