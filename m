Return-Path: <linux-kernel+bounces-846227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC1BC751C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1464F2F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5564F23D7CF;
	Thu,  9 Oct 2025 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HSgofrY2"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3086323;
	Thu,  9 Oct 2025 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981719; cv=fail; b=mRhFcR5fllWCOJa9sJ9qOK0snPv3kqj+mpAlMzdEb8ILlldIq6nWRPBRXqNFUa4soqeYjLSzZ0LiRAJQHfhNS0EQC2GRNCJkBsgmAa7wVCBejLjThowishw5YZIfh0HSqnzktOwb2A4M2il5xNGUFOnDSfJsjUOxaB9YWkUfpmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981719; c=relaxed/simple;
	bh=MDVrngp0Vzs/68Gf2UFvVRfCh5binUrnWN52ZuGts9E=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PmoketeZD0Z28MnoYi2uu81NHNJW1pBf+As0QtIhr+orKPzQbJ7w3Xvts6bp/0dTzrWTSVtoN/UKVi/YLr83taAe5sr4bkjOuqYuGdL83P4/HC4FC+LivTFdmFi/i1FcRQyLmaLLealbV5p5Fqn7VoYbKnYCN3Veryb8hiXK0Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HSgofrY2; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlkXNJ3laGp75DdwEhazdskJ5NSn4bZg4O1cdE+IstdeKV7Isj6cX+1cER+9Gw6jHbXtFrs6F3YM68qWczkIG10KVQKJH6w9erogaaYy711RdNj3/MG+SZ7nE89NqsIg3QsjFmQ2z/gk6qsXsUNf8XMSYhVS42ljkqcSD1MYmvUIYjxdwyvfB/cQodeK/2bpi7Dig9CACJ+4a9pxGsEMfdZxrFuAbKyb2iRoallTv3cQ98zQiKrnB14oOgSTbZxUKiCCKT0utpcWxbMYz2Qv7RclKe0IV0Qfj0H0RV58ntPdo6S3rX2rwRuSiNYy4JdEZYCicvxQBQWoKDhTom1ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lz3Cpf5mjrmYUIQA3GwwtV4ujl1gYywZvYWRrY40eU=;
 b=j9BCeDXIgZBqygv3FISDMq/gFw1U1LLlbmtccR04QW0Y/y6MEarsotP2seLsDehcdYByre65W2fL13vfZz0glhjBU7QPSLzVs4KZM90ROtRZkasUGj6CTRGCeZz9IS++HkG+r7gvykBJ3MEI1wC/vj9tNtrqE6xIiTRPYB6b32t4km902MFjiqGBxdY/X4ZGvWwMV7wLhHHe+egw6lpXH58352VALqE0A/J/yVNMbaSMxkz0W1K/LPDDdFTve3PKSSzB2daUJKJKdJkAdbeMUrhtSGuU6yHqOM72uz5ZEZLzqKk+QR2mEnW00wMdnGPiYj3qDDz7W7k6H0YdgTMAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lz3Cpf5mjrmYUIQA3GwwtV4ujl1gYywZvYWRrY40eU=;
 b=HSgofrY2Kwub+UkVrRu7qs2zo60++tM9zBBhLR7ickp8lBlgtdT6AYkoQ3cbuxA3mEBqa0jqbHfesTmcR/NCJuceNUk5RppT1VPCdq3mjbZl5SI+5xVT2pMQrbB3gvnr1zV+OOkeESQUioP3/GvgTlZy4jgXnm2O4m6CeqnkAUthO3hDFiPx3+5zeps/E6MNbjhVNMHKRQdS5ELNOhSNfH7S8lnsBaUsjxbrMsqyIDjNdFMAa6nnDYVENfg5bEjjh0hc2y8cRzwVZKPM8kcHRQW2/MnnC1CfCMwPL7LmVQIBm2I9cHXWGaEelskmMaYfLnpBgtgu3W1Rk8+8ox/ZlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:48:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 03:48:31 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v5 0/6] clk: Support spread spectrum and use it in clk-scmi
Date: Thu, 09 Oct 2025 11:48:13 +0800
Message-Id: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH0w52gC/x3MMQqAMAxA0atIZgNtoaJeRRw0phoUlQZEKL27x
 fEN/ydQjsIKfZUg8iMq11ng6wpom86VUZZicMZ5a0yHdOyoSvh4tOgmto5COwffQEnuyEHefze
 MOX+eg4TnXgAAAA==
X-Change-ID: 20251009-clk-ssc-v5-1-2ae12cf8bf56
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Sebin Francis <sebin.francis@ti.com>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759981702; l=4486;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=MDVrngp0Vzs/68Gf2UFvVRfCh5binUrnWN52ZuGts9E=;
 b=dcNrOupA5wKn6LvgD9obQZoFW5F50ndIIrXwPqPGsEQKi2DLf/lB6j1P+8xq64UNexTU8Rfbr
 Y6UO9yQ3gxPChA1KWLby7qDvreJS9n29lV3RVnkvdh5TqYVDaTLb/9x
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e08bfa-faf5-4e2c-09ac-08de06e6b6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0ZZWTZFWXNiV1Y0QzU3bFJlM1dDYmtEVjFZU0g5NzlIeHRjZ3JTQ0JDK0E1?=
 =?utf-8?B?cFlhQi9kYmF1UTRnVFVYdzIrN3R3YkVmQk5nTjNpdVdiOFp5VVBxUVQ2UmIw?=
 =?utf-8?B?QWlqRXYva0FncGVOQTV4NnRJZUZha3docmU2V1l3T2pXamp1ZHhYUlVLNnNm?=
 =?utf-8?B?YkdSeDdYc1lTbEJpeHdNaUswUk40bllHZGIybjVtSVZzQXBoeEVQQlIwZGtJ?=
 =?utf-8?B?TlpkZFJ5WDlZaG5EOXowR1MrM1lEN1R0b1hjejVzaVIzNlgvR1V3UGM2N2Z6?=
 =?utf-8?B?akRyRHFlWlFySExqZXZlYnF4ZkpWYVN0bW9sSnUyNUR4V25sVlVYSURPbE84?=
 =?utf-8?B?WHZ3dlZqV0tISHhNVFE0bkxlSitHR2xtS1N4amJDM2pXSlA3anlrb1N5UFFK?=
 =?utf-8?B?eXhiblROa21EQnorQ3BNRTYycmNFaEIrYzlHb25NSVR1bGlLUXp3ZlVMMlB2?=
 =?utf-8?B?RS9iTEw0VEhHSU1vWXNuaER5SzM1eXoyVDduaUtRZy9RelY1aXQrall3ZnlK?=
 =?utf-8?B?WG1hSUc1TERpOTJhZXlOUjdzamVGM0l6UHpOMzRoVFlsVjgrZFBJOW9xdmJS?=
 =?utf-8?B?NVV6V0hHdzFTOXJEdHppNkt3eG5kNVUrdEhiRmhYVlAyempXemNPUkJWTWJk?=
 =?utf-8?B?SnZZdXVYNlEvTG5xWHlXZ3lJZEh3L1FoVXVJL1UrcTZhcmo4UWd0MHYvQ1lI?=
 =?utf-8?B?YVRPZjFXT2pDOVRvZkoyYlErSFl2ZjIydVhkOGFhdkkzZk5yN2hKbUJ5dTkr?=
 =?utf-8?B?RTNRM2FyVytidTFLQ3FVd1RKbjFTWXNTd0JSTHpiRWJkY01SYUl4RmZNVVJs?=
 =?utf-8?B?TEtsSG1NOUZRV0lsR0tRNDk1R00yY0ozTXlLbXpvQStZbldLZ3FLLzJwTW84?=
 =?utf-8?B?NDhqZEZDdWRMNVIzcEVtdkxJUDQyN2tkOVdGUjBXZlZjcnU0NTVwZXBMQTJw?=
 =?utf-8?B?OU5wR1M3dmR3elJLMFY1d0N1aFNmU20rSGhmRXY0bldPa2Z0RGdIV0pIWUhv?=
 =?utf-8?B?RTI0Tmloa1U2bUx3aS8vSGErT0g1eWkyVWJnWHRNdVhwbzNwaWs5ZitvMlQz?=
 =?utf-8?B?NWhpQThVNHZjM2JxV24yMnhiUlVhaFlBQ2w1bFFuZElqMmhZb3pDSFlkWmVr?=
 =?utf-8?B?ZDdIaGhpdmJFclMyVVJPME5paVF1MFFDVGlxM2RGR1VSbkVNYlZPNjBYMVlU?=
 =?utf-8?B?ekIwckhqWmM2TWhtRDdoR1k1ekx0MVJJeCtpUmhqNEt5UFg5c2FueU16M1BO?=
 =?utf-8?B?SEQ0UXhoWkQ1czFTYkNMNjJkSnV5ckxBb3ppV0tkMDZ2NnZqdEQvaFRpK21y?=
 =?utf-8?B?a1pwc042L2loR3BlKzMyVzJ3VmVTU2t0ZGVGOTNrajc1dEd6NVFCWGpIOHlS?=
 =?utf-8?B?Y3hzTGtYb2ZjbVYyZzJNUkc1dEtkY05xcVFEdUJtbkV2UGhMWTNNeHVnaDdP?=
 =?utf-8?B?RzAxUUIxY2t2YWpOc09xVm9ON21xRXR4TVhhd2tCdVhKYWFPV3VRZU1xMCtM?=
 =?utf-8?B?UUVhaWp2dzkvVGEwamYyV3R5RWRVTEw0eWhhVnR6amRHOU9wOWRLbUFKYjd2?=
 =?utf-8?B?TEpkM2ZWcThNWFpzUnI3V3FRand4QnY4YzVkZTgvZDYzN0F3YUZnS0tEWEFq?=
 =?utf-8?B?SXkvUTZLd0lXbHk3d0dEVU5aRHl5T0IyQU1MWFByUTQzZkNhL1dsbHh1VE1Z?=
 =?utf-8?B?MU55bWZiTkhJcE5yYjVpS3RRZ0JTdWI0OVZPQXdKSEptbGJSdHJpWjMwN0dT?=
 =?utf-8?B?bDFPb2I2Rkp5QkFVOVh4cmdyZGRaWm5qZlludkdSNm41bU9Ec3Q4V3ZVd3ln?=
 =?utf-8?B?ZVVkbW4zb0RBMkdSc1hJNmxOdEZKbTNxa2ZXY0tBU3QxRnlLclUwZTdyZHQ4?=
 =?utf-8?B?RG9kRkcreUpPLzRwNWRKQXBhczBCQ1JNZWRzNm8reDR2MXRsaUZHVEFyMWVx?=
 =?utf-8?B?d3N1d0ZtQWd0bHRmam8yeGxsZ2pNNTFJYjNyaDAreXo3TjhrOUpJeSs4TTdn?=
 =?utf-8?B?b2JJWWZ5NEFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUNiaXBaRXN4dG43dDQ4anRReUEzOUlCNUNUU2MrL0RlS1lzcVFidDhkVlFv?=
 =?utf-8?B?cFhkNXJRYXZjYzV3MEt6QmdzenEwYmNXeE5vZVE3eVZ3NTlFaDVzdTQzdkVF?=
 =?utf-8?B?SlZySys2RkRCUXRaQXluSi9CY0p6Qk5KUlNmSEtLZDJvT2MzYmhpZ2lmTWYw?=
 =?utf-8?B?U2tlQXUwemNKc1kySTZLQXoxalU1WFFtRTZmemtHQXVCeTdDQkVXd2pwMmhT?=
 =?utf-8?B?ZVZFN2ZGUU5kWXhzZmlvZkViN2M4cVhrYU8wMm5kQjQ2Q21LYkF4T3E0UXhs?=
 =?utf-8?B?RmdpeGU1TUl4SERCMHAvMWxZSURRZXhpVkRldDYrUmY1cXpkZUs1NTdQaG9Q?=
 =?utf-8?B?Y2pUZFZBL0lRUlVXejBVcDBEMWhTcTdlb2NWaEUxVm0yRUtlNitRNWxUNklG?=
 =?utf-8?B?Qk1PZUJ5MjZIQzI5eGNqMXVzWkdBakRoQW1jdWRHOXg0emFKQWFGSkM5SzlN?=
 =?utf-8?B?bk9CZThSN2d4R1gyRURHTXl1UTROckdCWDhuR05VdWxHWElXQ1VWNTJSQ0Vw?=
 =?utf-8?B?MExycy95WlVXem5kZE92M0tsb3JKTlBiWTVES0RIMGNMVXpmS0NobkF0azVW?=
 =?utf-8?B?dmhIRkhCaFJMMXA0eUVsRzR5dytOcHNuL096cEYwU1VlWVpZRFBhZXpkVVRs?=
 =?utf-8?B?L1JxWHZWK3c5ckZDcmZhMGFPN3l2ZkZoM0dVZ0tNV0c2Wnp2OFFvZ3BieGtr?=
 =?utf-8?B?YUYvaUlGMFJtSnZhTGNGMFRabnQ2NkVyb2RYRFdoa3V2a2UzeWpvUk96dDYx?=
 =?utf-8?B?L3JGcURWUjcwVlRXVzdVS1A0c202aDdVUjhrdGgwRm11cDZ1cTJURWEwTHJS?=
 =?utf-8?B?OUwzRWJmRFBOSEhqUVU3Y3h6VjBUVjNUN1NiMURieVdoVUx3NlRQQlNQWThN?=
 =?utf-8?B?RVU0cUl5NGZqL0l2YnpNbnM2UE1QQ2g1emlNYkV1QVp0UE9WQzdLcWIrb0pN?=
 =?utf-8?B?SDJtNU9kUk9NUlVWRnI4dW9STzdBdWhHWHNhUTdycXo0MWpVMWJkanNibFVs?=
 =?utf-8?B?L3F0V2ROdmd4V1Z2UWtKcFhJck1WUS9mMUl2eGF6ZnpraCtWazl3d2FkeFFi?=
 =?utf-8?B?Zzl5OVB2OG9Kd1hiNC8xdkViTkt6cVo4WGhoVG45QlhPQUNac0VoSWo5TmE4?=
 =?utf-8?B?cG4vN0VBSWVRa3pKT3hYcFd2dzJIbzlOaDFJZFJtVFJyZFNPZWpmZ2pBVjBF?=
 =?utf-8?B?bnlVL2htWitHWjNpTVB5dTR5Q1hPRTIrczdKZXJleGduM1g1UDkyK3BOUFlT?=
 =?utf-8?B?dnk0RC9wVXQ4YmdLN1pHRmEzeHUveVlLZU5RSTAzNkE0a3BzR0dXWDBoNThx?=
 =?utf-8?B?c3lZeEZjQUhNRDN3NW54OFphR05LYTdnMlZuQUs3d09acElMYjRGRTFmZFZi?=
 =?utf-8?B?eGpYNlczekdqL3BCUXFIRHVENUM3ZnJzS0g1WExQbDBRcjRCTUhLZzN4UER2?=
 =?utf-8?B?Vy92NmVNa2Y0RHNnanFPeWNlVW9PNWIvckdLQXd4bnl2UFByZ24waWxWTTN5?=
 =?utf-8?B?MXNtZktxSmhGQmcwK241UmcwMEkrdUFTNXgzaHJjOURGOEVXMTVtdDcveUZh?=
 =?utf-8?B?bWpyUkdkUmRMcHBobHQ0Z3V6aW5ESjA2VkJBMkVyZUNEYkdWeGkxSzAvZE1F?=
 =?utf-8?B?QWhVOFNSditZekRSSHRpZlNDT0lHcGo3UGZmdTVIV0xyYjNKV2NCbXpMMnRY?=
 =?utf-8?B?Z21OdnVJZXkzZEw5NXlPUm9SU0FJQTU0bnFTWHMySDF5blFSOHQzNEdpUkxp?=
 =?utf-8?B?LzZCQjhnSk1pWkRlVTc0MlRoS1gvV0JJWENKcnNhV2Y2U3RMM3QxaEtBbHRP?=
 =?utf-8?B?VGNEd2FPcWREbXNMdC9MSXRvcDJZZzlxdTRqdUx6NXl3ZlFVTWlzRTA0TzVu?=
 =?utf-8?B?R3REZUhoSFE2WEkxVmQ5bXlsYThhREk2NjZGZGRrNVM0dlhTSFJTdUI2N0ov?=
 =?utf-8?B?Lzl0L0J6MFFwUG1qbDA1dFFvVWRLdUJDZlIvcEdPbElTMlR5SW9ZbmpRVTh5?=
 =?utf-8?B?U3Ayck91RExaOEU5RDNGNlNrZURseEJ5OTJoOFZEcGc5d2lJZ05kMnZPOTZH?=
 =?utf-8?B?UHM5dlVOWjRWNDRzTVQ1ZEtTNFpQdTVHd2NCSWVTNmoyTGNWeDg4TzhwSjFI?=
 =?utf-8?Q?6x02A+dtnawU4dYyQ+EHSZjEL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e08bfa-faf5-4e2c-09ac-08de06e6b6b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:48:31.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+OSxPRwX62ds1PcC7crBeTcSLDbzm9GKfzRm/8etAZTdXjUs2njYolsCDOz3o5bAusUK114d+CV/UWvXG/DBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

Since the assigned-clock-sscs property [1] has been accepted into the device
tree schema, we can now support it in the Linux clock driver. Therefore,
I've picked up the previously submitted work [2] titled "clk: Support
spread spectrum and use it in clk-pll144x and clk-scmi."
As more than six months have passed since [2] was posted, I’m treating this
patchset as a new submission rather than a v3.

- Introduce clk_set_spread_spectrum to set the parameters for enabling
  spread spectrum of a clock.
- Parse 'assigned-clock-sscs' and configure it by default before using the
  clock. This property is parsed before parsing clock rate.
- Enable this feature for clk-scmi on i.MX95.

Because SCMI spec will not include spread spectrum as a standard
extension, we still need to use NXP i.MX OEM extension.

[1] https://github.com/devicetree-org/dt-schema/pull/154
[2] https://lore.kernel.org/all/20250205-clk-ssc-v2-0-fa73083caa92@nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v5:
- Per Stephen, export clk_hw_set_spread_spectrum, use enum for method,
  add const for set_spread_spectrum and rename clk_ss/conf to ss_conf.
- Per Sebin, Cristian, Sudeep, I added clk-scmi-oem.c to support vendor
  extensions.
- Link to v4: https://lore.kernel.org/arm-scmi/aNQPWO6pfA_3mmxf@redhat.com/T/#me81231bf286e2a8e4e00a68707ed1e525a2b4a3d

Changes in v4:
- Add R-b for patch 1 from Brian
- Drop unecessary change in patch 4 Per Brian
- Link to v3: https://lore.kernel.org/r/20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com

Changes in v3:
- New patch 1 for dt-bindings per comment from Brian
  https://lore.kernel.org/all/aLeEFzXkPog_dt2B@x1/
  This might not be good to add a new dt-binding file in v3. But this is
  quite a simple file that just has four macros to encode modulation
  method. So hope this is fine for DT maintainers.
- Add Brain's R-b for patch 2
- New patch 3 to add Kunit test per Brain. Since Brain helped
  draft part of the code, I added Co-developed-by tag from Brain.
- Link to v2: https://lore.kernel.org/r/20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com

Changes in v2:
- Simplify the code in patch 2 per Dan Carpenter and Brian Masney
- Rebased to next-20250829
- Link to v1: https://lore.kernel.org/r/20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com

---
Peng Fan (6):
      dt-bindings: clock: Add spread spectrum definition
      clk: Introduce clk_hw_set_spread_spectrum
      clk: conf: Support assigned-clock-sscs
      clk: Add KUnit tests for assigned-clock-sscs
      clk: scmi: Introduce common header for SCMI clock interface
      clk: scmi: Add i.MX95 OEM extension support for SCMI clock driver

 drivers/clk/Makefile                               |   8 +-
 drivers/clk/clk-conf.c                             |  69 ++++++++++++
 drivers/clk/clk-scmi-oem.c                         | 103 ++++++++++++++++++
 drivers/clk/clk-scmi.c                             |  44 +++-----
 drivers/clk/clk-scmi.h                             |  51 +++++++++
 drivers/clk/clk.c                                  |  27 +++++
 drivers/clk/clk_test.c                             | 121 ++++++++++++++++++++-
 drivers/clk/kunit_clk_assigned_rates.h             |  10 ++
 drivers/clk/kunit_clk_assigned_rates_multiple.dtso |   6 +
 ...kunit_clk_assigned_rates_multiple_consumer.dtso |   6 +
 drivers/clk/kunit_clk_assigned_rates_one.dtso      |   3 +
 .../clk/kunit_clk_assigned_rates_one_consumer.dtso |   3 +
 .../clk/kunit_clk_assigned_rates_u64_multiple.dtso |   6 +
 ...t_clk_assigned_rates_u64_multiple_consumer.dtso |   6 +
 drivers/clk/kunit_clk_assigned_rates_u64_one.dtso  |   3 +
 .../kunit_clk_assigned_rates_u64_one_consumer.dtso |   3 +
 drivers/clk/kunit_clk_assigned_sscs_null.dtso      |  16 +++
 .../clk/kunit_clk_assigned_sscs_null_consumer.dtso |  20 ++++
 drivers/clk/kunit_clk_assigned_sscs_without.dtso   |  15 +++
 .../kunit_clk_assigned_sscs_without_consumer.dtso  |  19 ++++
 drivers/clk/kunit_clk_assigned_sscs_zero.dtso      |  12 ++
 .../clk/kunit_clk_assigned_sscs_zero_consumer.dtso |  16 +++
 include/dt-bindings/clock/clock.h                  |  14 +++
 include/linux/clk-provider.h                       |  31 ++++++
 24 files changed, 580 insertions(+), 32 deletions(-)
---
base-commit: 7c3ba4249a3604477ea9c077e10089ba7ddcaa03
change-id: 20251009-clk-ssc-v5-1-2ae12cf8bf56

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


