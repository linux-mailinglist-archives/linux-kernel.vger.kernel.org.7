Return-Path: <linux-kernel+bounces-897038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0210EC51D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D951899AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377B230AD17;
	Wed, 12 Nov 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BaTaY/z3"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC7309F03
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945511; cv=fail; b=QHoMD55o01b9ARYFMMiukwaxW0dF2bAuwDFbmQPyyA0VUnXrcDY82WmMTqUoYK3pBLqFi/KWg6S1wx6MRDqrX2/tukRGeKn26y3/KJ7k663ATn9mUS0FF9xOm9kyarMJjtQMywl1b73GtkfDELok381ldSH9RUpPpAYHVeWJQCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945511; c=relaxed/simple;
	bh=SM+ARwu3tWLUueEvcjbe4AknlOqtRSUPy4ZdW/TaTcg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RActAoietYtPG3Lil/XvAX8IEP7SG6FwiKUjzxfwTVLd0h2uRB2mzBD00TXuqzkj+SlRjwe53AdzIf7RnV2by570GKKPT+fR9fVdGNo/m7nENwNkvwqksGuvsvV5RDU2HxvoAK7jkVbzyhfTncH7ltw+QpwRY6IkOYfFsLgDx+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BaTaY/z3; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/VqaqdDwZxOq9PtPkLiYVUeCisUeOXDGWn2JIAcKKjLhyqp3QdepmvkIjV9ZQH2OAFaJMHw6JOWjoLKV/h7LLxn8tCcWvXF6iuO/yXizeEGALlmV+kmK9uIwOJ2EwTKmIGBwS1DWpKRXNFJ6QltNRW6xWghtNRe3PkkeCNQUDNrK0e2hjixRp6wNTVKpXXAplTC5HkmwE/55+uIteWZmyxWTqU22hUM8Q56kh2CPSCUg9Q2zC7LV6bg1Lpucleq1N8GhpW4y+UyZsbLwYJ/uaaAQJtDNbbgX2gUaX8W819FUoIquBoD2jbnBC0xouVwfOhm7xc5StSGdBSR7+hhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/UaVx79feLzt/kwGhD1/HTo9b4GEKUxtKNcavU67kw=;
 b=Go5J7o0n2JfAzqKhxBneQT5XduNHHdMkvLEMUyBUnaJpVQYUP+EpLI5BuKZwae2F1ZV0LfgdYYnO59OhX3KKJ8lqm5yOTuLkA1zeYgIbECeOPMqTiNk7fTNtOiaEto0aweGR+gcuZ8xD/wWRuZ11dEq3qnoNG2T9A59lOMWMkqkUwMCdAMyMhwY7Qn06pAT2R921graWy1W5vtBuKYsRGK3IFkIJVLQuVOqa/L+gsdJzlStH5H18gtVQpQYBiisJmq1ffY0MPLpOwBH1cOwPTbYXkz/FVXzu2sHnSLyLa1l4F3jlCjblb3ISwwNZ4L/eRKclPbV3Fpo/8z1uD8NpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/UaVx79feLzt/kwGhD1/HTo9b4GEKUxtKNcavU67kw=;
 b=BaTaY/z3LgKrd+Bi7GY52jy/RZeJ0NvOwgwnjJ+4pKjwQHg1gXJ7HpDlQWG6z35ayH4gfeRwtBw8Mj37bYiud30owY5JG71fPdgr/QHarDzZgTH2Wf0IB5nHggz3UE6wEnwT4toyJ2J57eGtGIdV4LegGlw16l1hINDKTjFxHlI4saiJau9abU+o9jf9N6OjYVSWEbMJ1IHOyOPPlBVX7cPN42r9GI7X8QDPP3pyn0uVRVU6FlBhnluIwJX+aU7zzzvLQvGoQy9rltFTetOfERPOPCFfFVDjFt/hFu0/oyXFZtLgV3EcI3fAQWkysk2tPrIkfsm/wEpv34ZRWWcpUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9742.eurprd04.prod.outlook.com (2603:10a6:102:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 11:05:02 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 11:05:02 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 19:05:09 +0800
Subject: [PATCH v4 1/5] mtd: spi-nor: micron-st: rename the die_late_init
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v4-1-e4637be82a0a@nxp.com>
References: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
In-Reply-To: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762945552; l=3812;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=SM+ARwu3tWLUueEvcjbe4AknlOqtRSUPy4ZdW/TaTcg=;
 b=LNa9IJricbjV3kBVSZ7fwaaIU1QW368RBQ0SwqZ5K/I+cyHyPLejEf/X3tPglh+UIx3udGwDl
 TV3y8kfOLkWCu7V3IY4rCjXUMYrf0ZWR8ZhHOdo0JPmcpA70FOjWLj9
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAWPR04MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 33974e1f-dca9-4922-77c1-08de21db536b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDAwenpmbXJqanFVSm5hRWNCMHBwdzAyN2ZvMU5wcmo2TGJ2dnBxbVp4YThP?=
 =?utf-8?B?YjJEU2w0SWJCOG8wZzU1U3BIdCt3cTRROGdBY0lGWGI4cGNqSndBUVVhUndB?=
 =?utf-8?B?SEdHVlMzR21MS2NHYWhBakxZSFZnWUtJY0h0NUt6UDBKMGlxNEh2amh5ZStB?=
 =?utf-8?B?RW41V21SbkNEZ1pBRWJCNm1ORE50VG1BTUw1N1JTM0Z0WGFUejFrQTcvMEdI?=
 =?utf-8?B?YTdoN2diNWIvdk1Td0hQL3pVaHdPRVNsOFphQWhNYjlnMkcrNCtXTjlnNGpY?=
 =?utf-8?B?RFJ3LzF3RmE0WmJFRTJ3bEpjcml5N1B4YmZLYXJESzhpZXFBejdWL09zNCtD?=
 =?utf-8?B?ZXh6c28wWHhUVUR4Y1E0aG9XUVFneFVVNEJFM1RsTkRqRFFhVWw2Z2hmcDFG?=
 =?utf-8?B?cVphd3pPYVJsa2lFMTZiWHpiMXA5LzJRN3hubW14VE82YmQwZG9qcHFsSDI3?=
 =?utf-8?B?cmZZUC9wVUxmNVFRSHVFUll3V0c0eWc0Y3c1aUtOOTVVNWRlNlF0VXFIbGRV?=
 =?utf-8?B?MFhZTDdJak85bE1QWFBuWjBzQnRWTFE0emtoeDFjZi9BakE3SFZNWDRBbVZa?=
 =?utf-8?B?T09oUTY1ekYvZGZEcVFPMkliS2lZTXMrSkhyZzlmdXpFQWtmb2RReElTaFFX?=
 =?utf-8?B?NFdpVlZ5ajZHVTh2ME9SVUVJdWE3dTlZUGkrSlY3ZW9ad0dWejBtWjFBU0ps?=
 =?utf-8?B?SVBUdEpacEhkYkdpa3VGOVpCWCtBb1FRVE5hM25pSUVGYnUxRmtmeTlCZTd3?=
 =?utf-8?B?UFJadWxJVDVKTUlYbTduTmJOUlJUdXlOWmNqa25DTytnNjk5M3E1ZnhUSldY?=
 =?utf-8?B?amt5U1ZLRjhzN2ZFNyttY1g3eVphcERKS3NMUWZRQWlsbXJSVWtNRnQ0YTBK?=
 =?utf-8?B?MzEzVGNjOVVzWlhpcnF4N3Z0Q3NBV09mbFNSdHZ5YUYzaEpPN2hrWkFnYzg2?=
 =?utf-8?B?OVQ0bTBLdzJ1UWhaNThPRnNOZmJySUNhaUhPSTRIc3hJRUdOTlp3VlF5WW84?=
 =?utf-8?B?SXZoMUV0Qk9xRHM3bUxRVHVDNDg5ZTZZNnd6NEF2MnZQblRubGtkeEVMNmtp?=
 =?utf-8?B?TlNOeXZ0T2N4NUVRWW0rUEhnY0NqaXlydGIwbCtLaGdJeHBCdDU2bysyb3R5?=
 =?utf-8?B?OEJkRWFRUkN6QS9KdG1DbjJONG1PbWVwajIwWktPWGRVVVFHUUhSZzRscVR5?=
 =?utf-8?B?Y1dWQTlERnV5UlVZSnRLMUhGYWtsRitQcWlSWFFHdEQxaGxpWlJBb0JSVTlo?=
 =?utf-8?B?bHkvcnpKbGJvVFliWEFsQjd6bk1hT3RiSlRaUml3STQ0L0R1Z1Z2Ui9JdzBv?=
 =?utf-8?B?cWgza2phaWtSbXhTV1RUKzN2bXJLMHpxL3pXaHZZTDdZemtyMi9rU2pjM1FM?=
 =?utf-8?B?cDBhdHVTNDBLMEVDTXRPMU1NOTdtbmNMQjBRWEVacWtnUGUzU3RkMnIwUUFB?=
 =?utf-8?B?dmRCcWc4TmtKM013UVVPRjA5V3pTY1lkeHQwdHFUVGFsSkc3TWN3ak1jR1hM?=
 =?utf-8?B?VzJ2SDByWGptZDNtKzFMUlRzSjlwOTBLSERaQU5tTUZFQjJNbW4xNk1lSGJv?=
 =?utf-8?B?VjZZTExDaE1rODJtazVGV1VNV0gzRHp2RHlHbnYzaitURUxkWjFwbEU2QnJF?=
 =?utf-8?B?aElUTHVZUFhjYXNmTzhUWVkrWENWdWh4Y2RZRjFSa3kzcWtSYS9jYnA5cmVU?=
 =?utf-8?B?TnhIaTFqaDJrYmxVZHNidGF0elFiaXdsSzArL1lSWXUzRHc2NWxoaGJ0STVt?=
 =?utf-8?B?UlNjQlc5YkRBNm5jL2JPa3hSVGVuY2dQRDluNmJJMTY3QWdCVW5DUzJGUzZi?=
 =?utf-8?B?NitMMEozQkNGMWxVWEh2WjAvTjVKWUJPZnR6M3NtbGY0SHAxbkhFNGtscmRV?=
 =?utf-8?B?VlJXK1hlV2U5KzNtUFJrc3JhUGxYM1AxbFZYL1d3S0t4bGxEcFM0dDM3eXR1?=
 =?utf-8?B?ZlNCZXIzTDV6UUlyWWhyRjR0ZDhqaEdGdGJHWSs0TGJGNEhVL2JCKzJuQXRQ?=
 =?utf-8?B?QWlqTmdBVUZoNWNNcWRzQmgyZ1hVVzhxOHhrY1NBc1NQVGlhVnJydmFyWTUr?=
 =?utf-8?Q?zRcWxu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGRmMzlqZENWa1RPTE5aeEVWZXdNQk5mejQzRU5zSW5DSE5kaCtQR3k2alV5?=
 =?utf-8?B?dE0zWlZGS3RXR0JYWEhlLzVEZHlBOGwzNStjRlVIQmhGSWZtNlBRZG5aYU45?=
 =?utf-8?B?K3BGQTh2RGxmNFhudXVyT1piSi9yYmdYeWlib0s1bS9QT2tWRGJOSnNxUEd4?=
 =?utf-8?B?YktPZWNJdkErbThVR2sybVVHblhHc3BLL3NTdVV4VDJjRHIwS1RvZElJQkxK?=
 =?utf-8?B?YzNhdUVweW1WS1pSTjlhWGx6ai9VT2ZtbE1MS0VodnZUNnF5UVJueXJHQi9G?=
 =?utf-8?B?YUNRd1E5b2lJaG5BT0U1N1VqblYraEdOaFJrdit5QXBKclZRaHF3a2NOb3VP?=
 =?utf-8?B?UDhWRTQ1aXN2VGo0M0xzaTZyZEQzYVB2TGU0dHlyejd5T05Mc3pCbTNQaFBE?=
 =?utf-8?B?STdtbWxlNXZCcm01ZjFodzhqTmZGbmNDY2JBMFMxZ0ZkaDlVWURZNkMxRDNM?=
 =?utf-8?B?R3NYRTNIdmY2aThuU2wwZklaRmc4dExFRlhPYU55TGdTNnJ6Rlk0KzdWZSsr?=
 =?utf-8?B?Wlp0c2FhMnczajgzdjBIWXYydkJCQkYvdVl2YVhwSVJTQTRDY2xHeUhJT2kx?=
 =?utf-8?B?c0NBeU5kSXZjMmxWaUNOYmtCNEtneHhvT0lXRnM2YnZQd1VPSGRmSGpTTjhP?=
 =?utf-8?B?bFNrTFluaERTcGxTcWhKRlJBd1Y4c2FjNXpDSktrQ2ZGZlJWOG4zdzVUYXl1?=
 =?utf-8?B?Q1dEK0xNcWlnV0xEZEQwUTVWY3Rna1ZSRCt1cWNKUVBOWDlodWxteWFzYzJa?=
 =?utf-8?B?WFo0a0txNlFLWVhvRVBoUmtWT1h2L0dFUHVoNkxPMjZFVEVjU0xEWnBmQkZI?=
 =?utf-8?B?WDMrTUl6Z0FodmVMVTh1Q0JiOU1mQ3gzdFdXNCtabkNQalhYR0lWQndhY25J?=
 =?utf-8?B?dUgvRnFPWFBjeUJvL3Rja3I5ZEZqL0U4YStna3pubDVWUWFSSi9VYTJpZmhN?=
 =?utf-8?B?VVJoVUp3ckpna2pCdDZ2V1Rpb1NqS095Zm9Wa3JERnpudEpEVmp5aFErWmFW?=
 =?utf-8?B?bVdZNXVXKzNhaklvemZGU0kwV1NTMHMySlhINnBLZHdCbWJLekljcnd4SDJq?=
 =?utf-8?B?RkJud2JLRHNxeVo4T3pIOVJLUnJSR0RoWGw2cTBNZktyeWk3Z09BZ1NxMHh1?=
 =?utf-8?B?Y2c5K2NmR21Sdk84d3lCYjA1M1BlNFJkR0dlVnZrbjNZeWpzc3N1dUg0NTBO?=
 =?utf-8?B?SC9DNmFaQnVGVjE3N2NKSW5NVmxWa0FSVDVmQlpTV3VSbXg1TzErNXlDbjA4?=
 =?utf-8?B?Skw1SS9UaUlHYWZqNk9NYSswZDVoZjhCVFZwSmtPTTBwOUJNRGNzcmFsdFVY?=
 =?utf-8?B?Q2tkK2tBVG5LdTZZdHMyUGhpNFY5eWZpYnRNbjRXNndWT3RVSDl3SE5LUUt4?=
 =?utf-8?B?OEdqOElyK3k4U3dXWENMeVFaTFlOYUE3TFY5b3JWNTdmNWFaQzhsTVNWa3Ez?=
 =?utf-8?B?NExoWW84ZjRqMm9pZ3VXUmR3eHB6WkJ1Yy9TamdsZytiaVpGaTlyODN2THF0?=
 =?utf-8?B?K3ZBMHE5d2laUDcrcDJ2SnQxN3I3TjFZV3NOOE41VzBacHhldlJ6MUJZNjRW?=
 =?utf-8?B?dzVzUXlpWTR0T2lBVTVuUndIbTZsUEdES1dZRjBheEQ2MmNOdm56aTRvTnNq?=
 =?utf-8?B?dHo1UEtjcEJObVZETkJCckRWbjYyMmw4S3VndDhjU3ZTUGxqUzNwbmQ0L3F5?=
 =?utf-8?B?UVJ2Z0d1RHNIbnJDYzVjMHdxbFhYb2R3RHVJVC9vWTkydWphbmNJdytERWZI?=
 =?utf-8?B?R0lLT3U3dG5JU0kvUWZEREFFeXlKVVBPUHl0dTgrM0Zjd2Zyc2NqUmgzOThm?=
 =?utf-8?B?RlhpMjhwSU9pTkQ4a2JETGNqcDdPMWw5L0NrcExNeWhlaHB4d0QzZU5XRCtm?=
 =?utf-8?B?T0FtNDB3TlJzTndtZllGRUFCaUw5YWttZjVad1hFT3UybVVOTjVqNWplNmNw?=
 =?utf-8?B?SXVINzdXWUpXeTFPTllQL1BEMFRxeXpmdkRsWlc3NHBlbnRjMTdpSms5emZ5?=
 =?utf-8?B?c0xqTXc5a2N3TzBYVjVNeG1OZUpkaUliZURRdkRlRTRuNVI4SXNYWlh4dmFu?=
 =?utf-8?B?aHl3ODI0WEJYcDJiM0xKcXF5TnVnKzAvaE1iRGNwTHRkRC9Cc1N5Zk5VUnVZ?=
 =?utf-8?Q?khFdGNaUkg4TVfHKAZpAqMsZj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33974e1f-dca9-4922-77c1-08de21db536b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:05:02.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: panOXagi6vgjXuPOyKmsNiZhtx3962JsQKVEqiLDV2c5YZKX9t2Ux7TXanFd3H9B3CBkrN07pGNTl/lPf1/w0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9742

st_nor_two/four_die_late_init() also suit for micron chips,
so rename to micron_st_nor_two/four_die_late_init(), and move
these functions up, then micron can use these function without
declaration.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 187239ccd549510c6e9a6eacf4ae41158287e077..92eb14ca76c57f29ece1edb3fe652c56d1c2888f 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -127,6 +127,38 @@ static int micron_st_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 			micron_st_nor_octal_dtr_dis(nor);
 }
 
+static int micron_st_nor_four_die_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
+	params->n_dice = 4;
+
+	/*
+	 * Unfortunately the die erase opcode does not have a 4-byte opcode
+	 * correspondent for these flashes. The SFDP 4BAIT table fails to
+	 * consider the die erase too. We're forced to enter in the 4 byte
+	 * address mode in order to benefit of the die erase.
+	 */
+	return spi_nor_set_4byte_addr_mode(nor, true);
+}
+
+static int micron_st_nor_two_die_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
+	params->n_dice = 2;
+
+	/*
+	 * Unfortunately the die erase opcode does not have a 4-byte opcode
+	 * correspondent for these flashes. The SFDP 4BAIT table fails to
+	 * consider the die erase too. We're forced to enter in the 4 byte
+	 * address mode in order to benefit of the die erase.
+	 */
+	return spi_nor_set_4byte_addr_mode(nor, true);
+}
+
 static void mt35xu512aba_default_init(struct spi_nor *nor)
 {
 	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
@@ -193,48 +225,16 @@ static const struct spi_nor_fixups mt25qu512a_fixups = {
 	.post_bfpt = mt25qu512a_post_bfpt_fixup,
 };
 
-static int st_nor_four_die_late_init(struct spi_nor *nor)
-{
-	struct spi_nor_flash_parameter *params = nor->params;
-
-	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
-	params->n_dice = 4;
-
-	/*
-	 * Unfortunately the die erase opcode does not have a 4-byte opcode
-	 * correspondent for these flashes. The SFDP 4BAIT table fails to
-	 * consider the die erase too. We're forced to enter in the 4 byte
-	 * address mode in order to benefit of the die erase.
-	 */
-	return spi_nor_set_4byte_addr_mode(nor, true);
-}
-
-static int st_nor_two_die_late_init(struct spi_nor *nor)
-{
-	struct spi_nor_flash_parameter *params = nor->params;
-
-	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
-	params->n_dice = 2;
-
-	/*
-	 * Unfortunately the die erase opcode does not have a 4-byte opcode
-	 * correspondent for these flashes. The SFDP 4BAIT table fails to
-	 * consider the die erase too. We're forced to enter in the 4 byte
-	 * address mode in order to benefit of the die erase.
-	 */
-	return spi_nor_set_4byte_addr_mode(nor, true);
-}
-
 static const struct spi_nor_fixups n25q00_fixups = {
-	.late_init = st_nor_four_die_late_init,
+	.late_init = micron_st_nor_four_die_late_init,
 };
 
 static const struct spi_nor_fixups mt25q01_fixups = {
-	.late_init = st_nor_two_die_late_init,
+	.late_init = micron_st_nor_two_die_late_init,
 };
 
 static const struct spi_nor_fixups mt25q02_fixups = {
-	.late_init = st_nor_four_die_late_init,
+	.late_init = micron_st_nor_four_die_late_init,
 };
 
 static const struct flash_info st_nor_parts[] = {

-- 
2.34.1


