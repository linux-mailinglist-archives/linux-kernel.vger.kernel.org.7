Return-Path: <linux-kernel+bounces-747530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72779B134D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19213A62D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877821FF5F;
	Mon, 28 Jul 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mR63Mx0h";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mR63Mx0h"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002A86344
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683643; cv=fail; b=XCp6V5lxZjN8s9bzkM+u4eJzG/c6yepDzKvYDSBrffm8LdkP5B/kfaW0iMsv8ZTgoPah0TDXMEpwW9ghlvGq1GWNnHVmGzrgwr56daIlj2zdu2K0uzXLNh4GuGdS6TGyiI/bAHgJorZ2P1Qnhl183vWj8iQ54W1e+KNsjbWWMag=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683643; c=relaxed/simple;
	bh=WHFjX70hP+Ie6MzByd6GIP4tS8QNjroLty/oc1IybNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mbmVhXMz6Paab3KAtyTWpB/IuCZk+xFSBzkPnq5HtX/ORjE4Ngl+BmXtmaxJ7bMupL6UymILGwloHbm1CV20o3qm4j3be3k5wHa70oUfOiPH17IkSIdxo0TI9wQhBZbLUa8wtxq0clXh+qJAEetkd6DWI8k/lZrR6iZhdyG7KaE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mR63Mx0h; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mR63Mx0h; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RipV6D9qhSU7/X6CRpHDzied7l437A2U3CQgukSDE0Qw/4Pau2CFJ1K/dYj5CenhusfXzysGGwVMERVgn09+n3QT9DuueBozfID4xJjBVpbPPlbr39XUNGFaHExlvrZ8P+MlJPTtUlwUmXPG4u+yM5yT7Q6s1hJzdcjXtCQR9qBjUH0MECFm/9Sxqfji644fndTaWM5E3uC5IvyP1yc7HOwyPaDD8e/uQKi4Fvubcj4jHyvoB9DGu6ntGnHyB0uQ/hapsW/RoISCJuH4yF0tkbzynXPWIv9j++cp3xJy08p+BkRbN8g3NBvOGVtezP4LoLslFQBoBNOqtCQNDp/uKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHFjX70hP+Ie6MzByd6GIP4tS8QNjroLty/oc1IybNM=;
 b=FbMUoTMjVq+n52PdaojlODUg7CCVDshfqRMd2R1f4pVdECcdPnzKR3htcNbYbVUO5lldLnU0Ges7qCv7BFROtapomIUgc02JMYJafgzrFaqTitmsoIYedn0HCvW/ZUfpadRlyxdp3nczSiB1nida8RKB1siTv6AdGd8Xvv/zNGdQs8x1/g75s8nk5qOk822pohBQA8nwBXszXwQVM65ojJoNbnMoss1L70pPE4ZpoR7faKEkXKea+Dlw4nG83aDis9hCS4rlsMXu8S/6zNnY8z/zBWvFnn+Y0znYi8yeA6jep50y8/IF3pKxyald3Abof9sI2YjupslR9KrJz1+Hcg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHFjX70hP+Ie6MzByd6GIP4tS8QNjroLty/oc1IybNM=;
 b=mR63Mx0hgmBaNCcyZS8ATVgrAKKK68mxOCjjyuPuaqxx+ArJcVNfyynRvXAe/WDdRgLYqEtGVLWvxp4nXapMwyaGRhLd8o65eaCbUxw/1unEWzWLXD7uTfZbUOcocUJlrtWe9KvnZqhQ9EmGD1hARXgZzlwIJfMcL/v1vDIwYz4=
Received: from DUZPR01CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::17) by DU0PR08MB8397.eurprd08.prod.outlook.com
 (2603:10a6:10:407::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 06:20:34 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::85) by DUZPR01CA0064.outlook.office365.com
 (2603:10a6:10:3c2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Mon,
 28 Jul 2025 06:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Mon, 28 Jul 2025 06:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfMbvM6/gJJQFbf58CpapYBMPbfllm05rOy8HDqBbemDeVA9gN3uQ0nrTy6b10xghj68rDdX9QFsshhNm32btfu+GgTL+m14e2DY6WLfIUQDiPTdFmgRcvz5gmKl/CFhHLKNB38x32hJphGM+uwioxxN2upgfK16h4ZGhbdJjtoIecOxuoW6xXuCOLVdF7JqJjq8+8He0aw5F9E2uspXjD+gnuOp9Bx4lgNQbKcF4ZkmfUdWPVHMG4d5S8wC1Vmqp4pNlpKu6geBMNe8djDGoX6/6D1XxFNlBI86l/iH/+h51pXJjuU/O1c/690dhZgkmwsmdlV+nAdbS/Q5WQKqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHFjX70hP+Ie6MzByd6GIP4tS8QNjroLty/oc1IybNM=;
 b=VTiWxZXVgeVOAtEZ7V/dgUhtdU7PAyMuLxAD7CeOg2SqhnJKxCOFMFBIkA8kTRYLifhqjpqDHdbqCEdKdHpbX5yTMMx70HFg1bRWnU1u0ioUDpzoPbHClqYMuFfAAZZnsphsD4S0Ofmc1pzvLvA1DwCn70b2rQ7uKViBJOWB70MSfrG2NL4ke32BsBNfsLe45/FzubEaozrLdjeZC+Xy5aCGhKJqIp6DfVUqrLrXYyY9y61XmTKlCBVoqScLTbBIR9NCyG8fjJs1iKvNvSkdb1xhxzjnm+j+XfSB5E5nxYUIOqAv7WKeOE10Mz4iaAPbgkhBgCrJM9rfF/tCfyA9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHFjX70hP+Ie6MzByd6GIP4tS8QNjroLty/oc1IybNM=;
 b=mR63Mx0hgmBaNCcyZS8ATVgrAKKK68mxOCjjyuPuaqxx+ArJcVNfyynRvXAe/WDdRgLYqEtGVLWvxp4nXapMwyaGRhLd8o65eaCbUxw/1unEWzWLXD7uTfZbUOcocUJlrtWe9KvnZqhQ9EmGD1hARXgZzlwIJfMcL/v1vDIwYz4=
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com (2603:10a6:20b:605::22)
 by DB9PR08MB7649.eurprd08.prod.outlook.com (2603:10a6:10:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:19:59 +0000
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::5de8:31fa:51f8:29e1]) by AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::5de8:31fa:51f8:29e1%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 06:19:59 +0000
From: Justin He <Justin.He@arm.com>
To: Dev Jain <Dev.Jain@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>
CC: Anshuman Khandual <Anshuman.Khandual@arm.com>, Ryan Roberts
	<Ryan.Roberts@arm.com>, Peter Xu <peterx@redhat.com>, Joey Gouly
	<Joey.Gouly@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] mm: vmalloc: use VMALLOC_EARLY_START boundary for early
 vmap area
Thread-Topic: [PATCH] mm: vmalloc: use VMALLOC_EARLY_START boundary for early
 vmap area
Thread-Index: AQHb+r5e++uMC8o/TkqHrb6DSlITALQ9s7GAgAllEbA=
Date: Mon, 28 Jul 2025 06:19:59 +0000
Message-ID:
 <AS2PR08MB97864CC7022A8DB7BDB87952F75AA@AS2PR08MB9786.eurprd08.prod.outlook.com>
References: <20250722040850.2017769-1-justin.he@arm.com>
 <c185e160-1b82-41f6-832d-cef3938a1a9f@arm.com>
In-Reply-To: <c185e160-1b82-41f6-832d-cef3938a1a9f@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS2PR08MB9786:EE_|DB9PR08MB7649:EE_|DB1PEPF0003922F:EE_|DU0PR08MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe0e537-effa-41ca-c49c-08ddcd9edc25
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YXY0cllYczVTRTZzSmI5WTVTTDBqWklBWWpRc3BGbXpFS3ozSElsenFyZzVz?=
 =?utf-8?B?NW1WUE5aMTI0TG5MQVorYUtBR29qVWh5bzVGREhpdDgwNkEvc2k5WG9TUWl6?=
 =?utf-8?B?blZVT2JaTjBYTUpiNmo2MVVMNWhHa2pWUWtiZnJVbjVUMjk4MVowL3ZNdk5D?=
 =?utf-8?B?WXU0NTN4aTFBWVhYdkFmQmlNWU1TTVBtV3phSTRmaXdNd3kwenVwS002MGJ6?=
 =?utf-8?B?aTZGRU8ydjVoRGNJT2hBV1A5c1UwcXU2SDlKcFV0RTBQckV1dUZWYlN6UEhQ?=
 =?utf-8?B?MlVZY2xPUW1OOS82U2Q4TWpONDA3UmlUeGlkYkVnbzVlNVhVRlVmbDZlemd4?=
 =?utf-8?B?U3BwQ3VsWFY2WjVyVHV0MlZ0Ynpaai9taHZiVFRnc05kU1VjN1hMNnUyWHd1?=
 =?utf-8?B?RkkzVmRpbExNYm96TGJsNU5lQmVGZWo0NXBOSUM4dUFlZENIKzIrS1F4QUJG?=
 =?utf-8?B?ZmJwU1M5TFhmbU12MFRMNjVPOUJNM2xXekZ5NVVuRnEyUVgyUzFmeDl3K1Bq?=
 =?utf-8?B?Rko3M3IzOUp2S3Rla2lWNkt4N0JyeUI2R1pUN1I4QVhEUW4reGFDMG5XeE5R?=
 =?utf-8?B?ZzhjWEUxS09LZklnQTgwM2hjVHlLUzFJc211MUZvY0dBS3RpNlgzbWwzZW0v?=
 =?utf-8?B?M0ZyZklTSTlRU242bzRaeVcycElmbG9ZL3ZNUlpFT2p5djRTNGF6VGNQcko2?=
 =?utf-8?B?V1lPNVdoS3lCd3RTT2RWNTdOWHdlb3RzV1RTRHE4SlAwVFZST3VCdy9Qbm5l?=
 =?utf-8?B?Wk5ZS2tMUGw1b281TXZnOVE2U2Nld3JvWmpZbjBtNnBjVjF2QTh0Y1llYm1D?=
 =?utf-8?B?TTR2WG9hdzBPL0NUcmdheDRZT2p5OGNOVUc5cjRFNnZnL2JtWTQ4S2VmdUZa?=
 =?utf-8?B?QmdjdEZzazhFeHJvQlJqcytDRXViOFNwWjJscmhJK2hGWjN0WmlzeEdCcGxU?=
 =?utf-8?B?MDE4YTFnWjB2ZFFWWHI4eUxPN254Q0tzWW9EZ050MW5VRUFBTnEvcUlHQWY1?=
 =?utf-8?B?dVlIRDFsZXFKT2ZnUm1XYXJ3d2JXSkhwTGMxaXN2Yk1qeU45bnBxaFUySXhj?=
 =?utf-8?B?ZTRvQktsVGJ1YTUzNytGcitTY0g5NXVTWE9vRVdEVU1aYUl5S3FyYzZaVEJI?=
 =?utf-8?B?RnVxN0FaYmRHZVlJU1hFdHhxWHZtcnhlNzExTUZBOW5Tc0V1VTVrVWZmOUp4?=
 =?utf-8?B?bWs5YXUrSllmZGtucG1SY1RKN2FZL2hrd0xsK0JEWXNGL2xRTyt5VjJNUjJp?=
 =?utf-8?B?ZlJyK1lRVEI2WXMxanZnc25VZXhsLzd1SXR6R1ppYmFWbUFaUThBSTA2YktZ?=
 =?utf-8?B?K1NCdE1KeERHcW44OE9TUXk3UGxlS1FudGtlK251ZVRLZFVRZG1nVTRLQy9V?=
 =?utf-8?B?SjRyTXFPQ0ptK3VWMDRQYWo4UGMyZUVMUmdnUXhqczhzamptY1YvU0N3N0xL?=
 =?utf-8?B?dHJ3Qm4wVE1neUxENFpFRFV2bGJSelFnc3ZHRFpyTjFBZWdTYTEzc3hPQWJR?=
 =?utf-8?B?WXVyMUxKbDVvZXp2ZVFNNXkrZ24yR2JiYm1UaWExYWpOc09qSkpiS2J1Sksx?=
 =?utf-8?B?K05ZTWpicmoxTm5GbHp2bkRRK0dsVkM0aCtOVm12SysycTlXOVljRXF6UzI5?=
 =?utf-8?B?ZllvMnpEY05lY2M1YlFxUXJtdFdpM0ptMldoV28zcU1LeWJVL01FWDNMTVla?=
 =?utf-8?B?M0NqNWVqV0hoVkRPZVNmQ1BxK2hpYTBuZXlXYXJ5dVZoYTM1dUF0anlaNE1O?=
 =?utf-8?B?YUcwc2VrVldETEp4eitWaGFkY1oxaGFOWFAzZjNjVm5BTWMrTzRmOEJINUtt?=
 =?utf-8?B?QW1Ud3pid0p5TnhEbFpwaU14Qm1oNS9NRGg0WFVYYUUvOHBtMDZxV1ZiU0Fq?=
 =?utf-8?B?RmdUbVdVekppYk13dXN6SGdZRTBvRXBoeWZUdnlaaHVGaXl1dTlJUlRrNmJX?=
 =?utf-8?B?ZWRqYlZQWE9iemhkR2hwQnZpUjlKUGtaaGVrdkZ2azFLeHJqOW5Tb2pSLzR0?=
 =?utf-8?Q?9h6wpHNENz/qVgopv0iudXc0XF5yLE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9786.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7649
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5e819379-0a31-4ab5-63b9-08ddcd9ec7bb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|14060799003|376014|35042699022|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zk9wR29FZEV2anJSYXlPZ0FFdmp1dHkyVms5clQ1NUxmakFjMFJ0U2dNOW85?=
 =?utf-8?B?dlRtSkZaMnNtU0w1UFYvS3FrTEpZZWZWRFlSa2VSMDNKNWdwTWhHbUFPakcx?=
 =?utf-8?B?RFpTKzNUTXpwNCthM043R1pMbHJjc2ZyWUVhcGJwMU9iM0pzMnhZZnMzL2dP?=
 =?utf-8?B?YUFTS0RxQzFudHZ5amZNRTJLOGVCWmxCQnkrbWt3RUhjS1o2T1pESE9jTVEy?=
 =?utf-8?B?N1JjLzhpR05JRGQrSm1iRXU5VzhmbnhidlpsZ3I5cnp5Lyt1bEhabm5tRkM5?=
 =?utf-8?B?VStEN01LVDh6RUx2Y2F4UmpqTVR3WFdrSEYrdVRtaCtwSC9DQ0tnYWF6STN2?=
 =?utf-8?B?RWxwTkl4ZzY1TU03aUNoci9XZTZSc2RUaHNiSzRyN0p2aWkveFc4ZnRVNzN3?=
 =?utf-8?B?S2ZxS1A4ZU9BbFZzZUYvTkNGR25nOTIyRUlFVmg4TVQxaDJPQ2lNVm1IRDUx?=
 =?utf-8?B?dWhzZk5LdTUrcktwbklJa0ZQelhlRDAyTFVROHg1OXVXYmxDbFRNV2d1bFgr?=
 =?utf-8?B?em1hZG95cE84RzlOT0tVWFU0S2NxQUxQZTlSNFpGR2pTYmNzNjFmbmh3dFBH?=
 =?utf-8?B?ZndPNWt4M3BKQlY3bkdIRGl1ZDF5NEdIbk5ydE5CWW1WKzluS1dxLzNLc3ZD?=
 =?utf-8?B?OW8ySXErRVRLVnpETGFJR1JwZ3ZCS3Z2NTYwZ0xCUmhwcDlsbmxKTEFxVkM2?=
 =?utf-8?B?dTdvVHc5ajl6ZlJSek9yS3RsbyswYVZyMG9NejgyU3pRRzlxRE1Bc3oxNWJw?=
 =?utf-8?B?ZDd5N1JNbXBkQjVGMS9uK2lVRCs5MVExQmdad3ZGQldoK09ZNXpYVHRPUXVD?=
 =?utf-8?B?MlFIdTcvbXo3UkE5QW5GbjJmcFBpWVBRS05Zd05iT1NPb1hnQ3ZmUzJDUTNM?=
 =?utf-8?B?RGg3Tjc4NjEwSTZoQjk0MHpLTnlhK3pmUC9wZThyWmN0dWtrbTRHM1RXWWow?=
 =?utf-8?B?ZFg4M1RUeUNRYnZja0M0MklDMU1IQVJraU9ZY0FkZTZjZEpNYTN5ZlhCcm1S?=
 =?utf-8?B?aW9UbVBSdDNzQ01qZHNSbERRUmR2QXRJNkVURnNGUjkxR2RjbHlyWTlqaFZ4?=
 =?utf-8?B?QVNWdSs0cDNQcFVPWUtGWFpIb0RQVmgvRHdENVVsbG01L0xwK3BlVUh1SzNO?=
 =?utf-8?B?WnZtTzNiSFlVUE45aDBITEpZazVmdEtzeVdFeGtWQjhIdVJSTWpNWVkvdis1?=
 =?utf-8?B?Sk9kMWYzL1lULzdRcC9QTkdmUERVbkIvYUQ5a0NSYlJ2QVVZS2tCb0F3elVL?=
 =?utf-8?B?QUlXVnh6N0l2eWJNVmFvLytYVzNsN2tKQ2tLRExZSnA1T0R0K3BHQVA5Vnk2?=
 =?utf-8?B?TGI3UXg5Sk44bUQyZlFodURRcTg1MWUvL21ONkI4V2lacXB4KzJ0aUQwd0Rz?=
 =?utf-8?B?SnF2MDNyRmxXMFFCZ1R0TC9jSThOSjBQSDB0eFVIUkhJYkI1dmhtdU1vREMx?=
 =?utf-8?B?clg1bDVhNXBmblE2ODh6RUZ1eFlZK0FzempxTkRjaDFVSUNUUjIwVVFBbkVm?=
 =?utf-8?B?TERYUko1RkIxblNUMDhOYml1ays2LzBQVEhrTGpyT25JeENTRmhxdGwrNHkz?=
 =?utf-8?B?M0NkdU5QbVRLa0pEL3krMmpQVE9KbWJJUVAydXJpR1YxeUtNdU80S2xmem9i?=
 =?utf-8?B?elJoY1QrYTVIT0g0Vy9ERENBNkw5RVJzZXRpQy8za2hKWG9Lc2REMVpLVWVT?=
 =?utf-8?B?SGlKRzhwa0FHeGxSSS9Qd1RBM2pnTzNkM3c4MWJiSGhvcElFQ2NVUnpwb2FS?=
 =?utf-8?B?MkdpcDZCZW1VWG9uWE1KVDZKS0tkZ014OEM5T3FCTWxCUDFMWHA2QVcvVk1T?=
 =?utf-8?B?RDJybU5nV2Mwd0U5aVRCcDlIWEhoRmVJRGJZV0FRVXJWTkdNb2l3Yk54bXNp?=
 =?utf-8?B?WTdXRm9kZDBpMWdDMXhQRDRQQ0xEdjgrWWFaOS81Z3FBRmwxYnJRSXd1RHk1?=
 =?utf-8?B?enhTZmw2L251cmtMRlhmK0NRS3FZbjc1VVVheTRjTDkwd01zcnB1c2s0Z3E3?=
 =?utf-8?B?VDJqZUgxRmpXZTZ1Ull6VG0vUi9LcUxJdmNnUWZONDNkU1Z1d05QNzU4cW5K?=
 =?utf-8?Q?nfowQH?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(14060799003)(376014)(35042699022)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:20:33.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe0e537-effa-41ca-c49c-08ddcd9edc25
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8397

SGkgRGV2LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERldiBKYWlu
IDxEZXYuSmFpbkBhcm0uY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIyLCAyMDI1IDI6NDgg
UE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBDYXRhbGluIE1hcmluYXMN
Cj4gPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9y
Zz47IEFuZHJldw0KPiBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBVbGFkemlz
bGF1IFJlemtpIDx1cmV6a2lAZ21haWwuY29tPg0KPiBDYzogQW5zaHVtYW4gS2hhbmR1YWwgPEFu
c2h1bWFuLktoYW5kdWFsQGFybS5jb20+OyBSeWFuIFJvYmVydHMNCj4gPFJ5YW4uUm9iZXJ0c0Bh
cm0uY29tPjsgUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPjsgSm9leSBHb3VseQ0KPiA8Sm9l
eS5Hb3VseUBhcm0uY29tPjsgWWljb25nIFlhbmcgPHlhbmd5aWNvbmdAaGlzaWxpY29uLmNvbT47
IE1hdHRoZXcNCj4gV2lsY294IChPcmFjbGUpIDx3aWxseUBpbmZyYWRlYWQub3JnPjsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW06IHZt
YWxsb2M6IHVzZSBWTUFMTE9DX0VBUkxZX1NUQVJUIGJvdW5kYXJ5IGZvcg0KPiBlYXJseSB2bWFw
IGFyZWENCj4gDQo+IA0KPiBPbiAyMi8wNy8yNSA5OjM4IGFtLCBKaWEgSGUgd3JvdGU6DQo+ID4g
V2hlbiBWTUFMTE9DX1NUQVJUIGlzIHJlZGVmaW5lZCB0byBhIG5ldyBib3VuZGFyeSwgbW9zdCBz
dWJzeXN0ZW1zDQo+ID4gY29udGludWUgdG8gZnVuY3Rpb24gY29ycmVjdGx5LiBIb3dldmVyLCB2
bV9hcmVhX3JlZ2lzdGVyX2Vhcmx5KCkNCj4gPiBhc3N1bWVzIHRoZSB1c2Ugb2YgdGhlIGdsb2Jh
bCBfdm1saXN0XyBzdHJ1Y3R1cmUgYmVmb3JlIHZtYWxsb2NfaW5pdCgpDQo+ID4gaXMgaW52b2tl
ZC4gVGhpcyBhc3N1bXB0aW9uIGNhbiBsZWFkIHRvIGlzc3VlcyBkdXJpbmcgZWFybHkgYm9vdC4N
Cj4gPg0KPiA+IFNlZSB0aGUgY2FsbHRyYWNlIGFzIGZvbGxvd3M6DQo+ID4gCXN0YXJ0X2tlcm5l
bCgpDQo+ID4gCQlzZXR1cF9wZXJfY3B1X2FyZWFzKCkNCj4gPiAJCQlwY3B1X3BhZ2VfZmlyc3Rf
Y2h1bmsoKQ0KPiA+IAkJCQl2bV9hcmVhX3JlZ2lzdGVyX2Vhcmx5KCkNCj4gPiAJCW1tX2NvcmVf
aW5pdCgpDQo+ID4gCQkJdm1hbGxvY19pbml0KCkNCj4gPg0KPiA+IFRoZSBlYXJseSB2bSBhcmVh
cyB3aWxsIGJlIGFkZGVkIHRvIHZtbGlzdCBhdCBkZWNsYXJlX2tlcm5lbF92bWFzKCkNCj4gPiAt
PmRlY2xhcmVfdm1hKCk6DQo+ID4gZmZmZjgwMDA4MDAxMDAwMCBUIF9zdGV4dA0KPiA+IGZmZmY4
MDAwODBkYTAwMDAgRCBfX3N0YXJ0X3JvZGF0YQ0KPiA+IGZmZmY4MDAwODE4OTAwMDAgVCBfX2lu
aXR0ZXh0X2JlZ2luDQo+ID4gZmZmZjgwMDA4MTk4MDAwMCBEIF9faW5pdGRhdGFfYmVnaW4NCj4g
PiBmZmZmODAwMDgxZWUwMDAwIEQgX2RhdGENCj4gPiBUaGUgc3RhcnRpbmcgYWRkcmVzcyBvZiB0
aGUgZWFybHkgYXJlYXMgaXMgdGllZCB0byB0aGUgKm9sZCoNCj4gPiBWTUFMTE9DX1NUQVJUIChp
LmUuIDB4ZmZmZjgwMDA4MDAwMDAwMCBvbiBhbiBhcm02NCBOMiBzZXJ2ZXIpLg0KPiA+DQo+ID4g
SWYgVk1BTExPQ19TVEFSVCBpcyByZWRlZmluZWQsIGl0IGNhbiBkaXNydXB0IGVhcmx5IFZNIGFy
ZWENCj4gPiBhbGxvY2F0aW9uLCBwYXJ0aWN1bGFybHkgaW4gbGlrZSBwY3B1X3BhZ2VfZmlyc3Rf
Y2h1bmsoKS0NCj4gPnZtX2FyZWFfcmVnaXN0ZXJfZWFybHkoKS4NCj4gPg0KPiA+IFRvIGFkZHJl
c3MgdGhpcyBwb3RlbnRpYWwgcmlzayBvbiBhcm02NCwgaW50cm9kdWNlIGEgbmV3IGJvdW5kYXJ5
LA0KPiA+IFZNQUxMT0NfRUFSTFlfU1RBUlQsIHRvIGF2b2lkIGJvb3QgaXNzdWVzIHdoZW4gVk1B
TExPQ19TVEFSVCBpcw0KPiA+IG9jY2FzaW9uYWx5IHJlZGVmaW5lZC4NCj4gDQo+IFNvcnJ5IGJ1
dCBJIGFtIHVuYWJsZSB0byB1bmRlcnN0YW5kIHRoZSBwb2ludCBvZiB0aGUgcGF0Y2guIElmIGEg
cGFydGljdWxhcg0KPiB2YWx1ZSBvZiBWTUFMTE9DX1NUQVJUIGNhdXNlcyBhIHByb2JsZW0gYmVj
YXVzZSB0aGUgdm1hIGRlY2xhcmF0aW9ucyBvZg0KPiB0aGUga2VybmVsIGFyZSB0aWVkIHRvIHRo
YXQgdmFsdWUsIHN1cmVseSB3ZSBzaG91bGQgYmUgcmVhc29uaW5nIGFib3V0IHdoYXQNCj4gd2Fz
IHdyb25nIGFib3V0IHRoZSBuZXcgdmFsdWUsIGFuZCBub3QgY2lyY3VtdmVudGluZyB0aGUgYWN0
dWFsIHByb2JsZW0gYnkNCj4gaW50cm9kdWNpbmcgVk1BTExPQ19FQVJMWV9TVEFSVD8NCj4gDQo+
IEFsc28gYnkgeW91ciBwYXRjaCBkZXNjcmlwdGlvbiBJIGRvbid0IHRoaW5rIHlvdSBoYXZlIHJ1
biBpbnRvIGEgcmVwcm9kdWNpYmxlDQo+IGJvb3QgaXNzdWUsIHNvIHRoaXMgcGF0Y2ggaXMgYmFz
aWNhbGx5IGFkZGluZyBkZWFkIGNvZGUgYmVjYXVzZSBib3RoIG1hY3Jvcw0KPiBhcmUgZGVmaW5l
ZCB0byBNT0RVTEVTX0VORD8NCj4gDQpQbGVhc2UgdHJ5IHRoaXMgKmRlYnVnZ2luZyogcHVycG9z
ZSBwYXRjaCB3aGljaCBjYW4gdHJpZ2dlciB0aGUgYm9vdCBwYW5pYw0KbW9yZSBlYXNpbHkoSSBj
YW4gYWx3YXlzIHJlcHJvZHVjZSB0aGUgYm9vdCBwYW5pYyBvbiBhbiBBUk02NCBzZXJ2ZXIpOg0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggYi9hcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KIGluZGV4IDE5MmQ4NmUxY2M3Ni4uMmJlOGRiOGQw
MjA1IDEwMDY0NA0KIC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQogKysr
IGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCiBAQCAtMjAsNyArMjAsOCBAQA0K
ICAgKiBWTUFMTE9DX1NUQVJUOiBiZWdpbm5pbmcgb2YgdGhlIGtlcm5lbCB2bWFsbG9jIHNwYWNl
DQogICAqIFZNQUxMT0NfRU5EOiBleHRlbmRzIHRvIHRoZSBhdmFpbGFibGUgc3BhY2UgYmVsb3cg
dm1lbW1hcA0KICAgKi8NCiAtI2RlZmluZSBWTUFMTE9DX1NUQVJUICAgICAgICAgIChNT0RVTEVT
X0VORCkNCiArLy8jZGVmaW5lIFZNQUxMT0NfU1RBUlQgICAgICAgICAgICAgICAgKE1PRFVMRVNf
RU5EKQ0KICsjZGVmaW5lIFZNQUxMT0NfU1RBUlQgICAgICAgICAgKChNT0RVTEVTX0VORCAmIFBH
RElSX01BU0spICsgUEdESVJfU0laRSkNCiAgI2lmIFZBX0JJVFMgPT0gVkFfQklUU19NSU4NCiAg
I2RlZmluZSBWTUFMTE9DX0VORCAgICAgICAgICAgIChWTUVNTUFQX1NUQVJUIC0gU1pfOE0pDQog
ICNlbHNlDQogZGlmZiAtLWdpdCBhL21tL3BlcmNwdS5jIGIvbW0vcGVyY3B1LmMNCiBpbmRleCBi
MzU0OTRjOGVkZTIuLjUzZDE4NzE3MmI1ZSAxMDA2NDQNCiAtLS0gYS9tbS9wZXJjcHUuYw0KICsr
KyBiL21tL3BlcmNwdS5jDQogQEAgLTMwNTEsNyArMzA1MSw3IEBAIGludCBfX2luaXQgcGNwdV9l
bWJlZF9maXJzdF9jaHVuayhzaXplX3QgcmVzZXJ2ZWRfc2l6ZSwgc2l6ZV90IGR5bl9zaXplLA0K
ICAgICAgICAgbWF4X2Rpc3RhbmNlICs9IGFpLT51bml0X3NpemUgKiBhaS0+Z3JvdXBzW2hpZ2hl
c3RfZ3JvdXBdLm5yX3VuaXRzOw0KDQogICAgICAgICAvKiB3YXJuIGlmIG1heGltdW0gZGlzdGFu
Y2UgaXMgZnVydGhlciB0aGFuIDc1JSBvZiB2bWFsbG9jIHNwYWNlICovDQogLSAgICAgICBpZiAo
bWF4X2Rpc3RhbmNlID4gVk1BTExPQ19UT1RBTCAqIDMgLyA0KSB7DQogKyAgICAgICBpZiAoMSB8
fCBtYXhfZGlzdGFuY2UgPiBWTUFMTE9DX1RPVEFMICogMyAvIDQpIHsNCiAgICAgICAgICAgICAg
ICAgcHJfd2FybigibWF4X2Rpc3RhbmNlPTB4JWx4IHRvbyBsYXJnZSBmb3Igdm1hbGxvYyBzcGFj
ZSAweCVseFxuIiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1heF9kaXN0YW5j
ZSwgVk1BTExPQ19UT1RBTCk7DQogICNpZmRlZiBDT05GSUdfTkVFRF9QRVJfQ1BVX1BBR0VfRklS
U1RfQ0hVTksNCg0KDQotLS0gDQpDaGVlcnMsDQpKdXN0aW4gSGUoSmlhIEhlKQ0KDQoNCg==

