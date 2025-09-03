Return-Path: <linux-kernel+bounces-799382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4FAB42AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98818582478
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC136932C;
	Wed,  3 Sep 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iv3G+RXS"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706E372886;
	Wed,  3 Sep 2025 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930849; cv=fail; b=TjBl3iAEYNmBSrryXOSrk/QwZy9d+3n/nuVa2C6YdpsDh0AlOeTn7sUL0U7ebs1QvWOQLbXMTmz4kiWluaHTylFWmNW/LN7E/Ssyzf4yq0LF+u9i2XHX4fLzT0/DDwcmVCWjUZBLDfBWYc1cSd0AXC4MyZR/HJeN5XCykjEqupc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930849; c=relaxed/simple;
	bh=84T4Y9XhReH6AKZji80bJuf57kqGs+8rg4TUn69An/4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ID+5bvPoaDj4bna5spDx962K2s3QvFCYwy2b3QAXctYxehZbJeQEXrnTpHaHuoOtTIaTF+A5mLWpZzn1HLlieoLCeMwuK/wMQQlzdIa3bXWJb+gYpjEM3Jw8DVV1G9qBX8kmpjsY2PztO1eHNnETQJeuRofj1uOvM9vXdMiMFeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iv3G+RXS; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pATDkjX5zO1Cl+VgCU2V7PiMTVq+S2CqZVmpMhj0SaOndscBI2dMt3WYv0Ajkk+9xDJ6LoYtVq/0TG8Qi5Y0mWPEXwQYJrCAhZQV3Xv4aYE/MTPm1kG3aVXxRfd7TPOyNE7CcdjJTNmQ3D0VJ6tebJoYiNHgdbOLvkHHbm1vfYyo/PUyACbUtMkItEzfZe3ckAmF5mu75Vxbdbi6B6PoFqd6cbsuNWITRbXDrL29C/uBs5xkScIf0hvK0vrpg1cWzoxLBuZrEJLNwkSCBlaw+8F4OTndjywDl+BDsD2n0FpRYhyVValHOYv5d0Cm3+oZBhf92SfQ1qm2Jq28Pg/GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orTd4X7ZJfaZ7b4bvtbdE3/pgZudEHlz9XAiOhtam4U=;
 b=FJr2IQGZXP6c6X23IhGc2rDF06ZafxCPYrM0AMcQ2omwyCyeeW/6DzxxSDaSHjqyN1AmPgIPO4EEbbjh3hy0/EFlExNwRPgEJQ7sri5KImXecBtrBrTjIDQ8PFluRpog3PUTPY3F0m3FYcYWoX1NLdWN1bT/N2TPOvgWgx5Hj2YQvZrpDHTcQpCbYYOxgIMTVa9ZvgTvGcAf0OEOsqbLYbt5bEaO3URo0eeGspChPX51LTETZ8pGt011wXH0NmFgvFIsHsULoYJWu+xjg4pfWRRY4JJHlGrX4lNhf4gWegXJ2OAQnSuKq5XzpWodjzL8GbOoWdQZt48m+UE9i/Nn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orTd4X7ZJfaZ7b4bvtbdE3/pgZudEHlz9XAiOhtam4U=;
 b=Iv3G+RXSaSHq/KpZaR/JcJT2jKoVrya0Acq3adtxw0RTG9zVTZRmYzH9WSu7TKXkz8ylwDl3mlWNfEUNQwo1pgQO4dfIbty2NM+CucwGjHGvGKHQZT0WLeaJN7J/Pfwbs/t6had/u+X7ZzV0v03Hc6JroOW8XJpXswbjFsLgFmz3uIqSxX913/Ku3+Fp2hXDnIuy9Gn2MnRSJAOn0jzSoqEbxh7uLoz9wYxRpiOPJTkWbCoM7MmFaij3JoPlOdaOrHlCuRc4P1xndPGzxbfC30toBSGFP1zC/Kg60W4Rv5cd//uuFTn746gF03ywUQ0QAPUHSeZc/YhluPxhogN9wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:42 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:06 -0400
Subject: [PATCH 13/16] ARM: dts: imx6ul-14x14-evk: add regulator for ov5640
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-13-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=1784;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=84T4Y9XhReH6AKZji80bJuf57kqGs+8rg4TUn69An/4=;
 b=fTZRJqVgiVu/cEKBuRAiEwMFcAi11HQb8vYtkBWQLtnL0dK8+fPhv2FQFYZkoMpWyRmXRZCB0
 oHIzhzbM9EWDdmPwYx9D0oqkAJRB/BQ1EE8vVCuc+25RbOc+yoquTCA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 159529a0-c7d7-4294-f7d8-08ddeb275a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUo1eW1KbW5LMTJRMW50dk5kOE5qUm1VUlVDUUIrYit0YWpHbitBejFoSUZO?=
 =?utf-8?B?QWN6Um9yWE5YcS9yRGFaakxvL3ZVeHhta3I1WVdrWndBMEJ2S3FPRHk2UGZQ?=
 =?utf-8?B?NjJpdUhMaDdCT3R3ZnFHbEhsK1lMQVNaeS9MZVhZNURKWDBwZEFCVHZOb0VE?=
 =?utf-8?B?YTZyUTNva2llZkpSYzJSTnpmY1B0b2FoZS93UFVra0NLK1hackRWU25MUHRx?=
 =?utf-8?B?YVhXMys5MkNTNTAycjZtTHhwSTN1aG9hdXhKM21Nb0YzSjVpNEVNQzR0UG56?=
 =?utf-8?B?d0l4aDZsYjFxSnhPd1FzS3JiN3NsRnl4b3ovV0xWbUlqTEdaRHNqWlkxc211?=
 =?utf-8?B?TThhV2tCTlFLMGhsY1ZVS2J5RmFwR1AwdGQwTDQ5TkZUeFZqa3ZMaGlCT3RD?=
 =?utf-8?B?eEVFbWhKWSt5ZVpzQldyaVphN3JZM0ZBbS91ZzU5ZlJtMnpVYXN2OEgxd2Q1?=
 =?utf-8?B?U3lsS1ZLbnBnUE5SR2UvVHRVS0hGSlF5eXhmSjBRNGM3NCsyWXFReTNtQjR4?=
 =?utf-8?B?NEVyZ2hOTVBIVzJLZ0grNGxmcENPOVplejhMR21tYjg1cWxVTWlYclhXclNi?=
 =?utf-8?B?cFBtcFR1OENYcE1uaVFHcUR6YWVjUEtKQWM0Y25ZRTBuTFprMFg2Yi9DTXF2?=
 =?utf-8?B?VnRQbTlxbnBOTWRJYjFITE9ZVDV2V3QxenlWLzBEV0NxN2hxUXVoTVozNFFU?=
 =?utf-8?B?bWNkODlMUFNnQlE3WWlWc3R3MTlqL3pPL2xabk1hUnF0OHdFaDFKMVZReWNS?=
 =?utf-8?B?YTNJeTRQSnNVTGtmeFZUYzB6dXpOTXdGQjBUZStsbXQxZEMvbGdzWWxEUUZG?=
 =?utf-8?B?bnZTOHg5T1B1NTFvMjk3NmpnM3M4SUNTMERUaHBVZnhLTUZKbEVVcFk3cm9o?=
 =?utf-8?B?KzF2Mk1ISm5rUDZEendaUXhhcGlSMGl2aDZSczRDV0tidW0zVGYwcEZURFFk?=
 =?utf-8?B?bWRLcTFzbXRxY1o2eENLVUdUZE0rbEFXdUUrWDFLRjhhVmZkVHIzZWswNGx0?=
 =?utf-8?B?ZFluM1RKZ3ZhbmQ3b1hiMEp6TlJacEswYTNxbTlwYUIrUFJnUDk2WU5nV1VP?=
 =?utf-8?B?ZnVSOUpUZDgzODdhOHUwTDBHR3BVRVRxYi9ZckFqRFF0eldndkwwZE5PV0g3?=
 =?utf-8?B?TDlNMW1OM1RacWJqdjdZTllVNkZEQXRkUFM1TDlBb1JabEJ3Q2RCK1g4bEhv?=
 =?utf-8?B?bVJGK2RKM2VYdThydW9CdW5FMER1RkYzYkdoVXJLNTdUM0ZDRklEdE8rNWZo?=
 =?utf-8?B?WWphblRDYUUxVWxvRW9KUFV1VUJlQ2hSSitMNVMzaDNuWCtMZS9GcTN3WlB2?=
 =?utf-8?B?K1ZSZG4xTTEzQmhTWE81T1dhWTFIS2JYMGNabjRoMHlzWkxUaXA2Vk51cHNK?=
 =?utf-8?B?Q0x5YzdNSUJ0NjRhTGM5NUZ1K0UySDc4aFovaVNpNWRKZkUzaUxBMWw5UGsx?=
 =?utf-8?B?Z29ieTVDcnNadTJqUVdJa1hMOUVoQWRUeUxQd0dYVks2LzFFMHJFUHovZEls?=
 =?utf-8?B?YUU2ZzR2MkJaUkZ6RFA2K3Y1a3EvZzhHNjJtL0FueWM2Z1NlemtrN05UTEVp?=
 =?utf-8?B?OCsrQklNM0pBNDlkV01ES2UxUlhQbVg1SkduWE4wYkVQcW5uTFRPSmN6ZDVr?=
 =?utf-8?B?TXY5blh0Zm9rL2hzQ3FLRjd5S1BCUktzckNwN05mTW56UGgxNSt2ZDE4ZlZp?=
 =?utf-8?B?dDJlNSthSkJtbHNwR1RYMTNLUTFaV29YVSs2YUNXWHJaTnUxbDh6T1pzYm8r?=
 =?utf-8?B?SFg2WGtXOWt1NE9MNm52OFRuVEdJUFZZZHZRbGYzaE0xOC9Hc3cyQVZxRFEr?=
 =?utf-8?B?L0xZT1RRRWExbEV6NnZCc0k3L01QcGhldDBuOStIcmRGVHlGd1pmTEVlUzl3?=
 =?utf-8?B?eDFFdkFnNndQWVlrajI2bUEvUk5Qd3VDOXBGWWhWSVpaai9UU2dkQkM2MVMy?=
 =?utf-8?Q?fiy2aIQU54E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3lJWnJWekQzZ0pqeC82L2pGSEQ3b3AyV1YrV2RJbEREWDRwcHJheExQN2Jr?=
 =?utf-8?B?azVKZHJRT0lDRWdLNjdoczBJZUREMzdLSDhIWVc2NXRPRUV4N2pkWUhSTjlS?=
 =?utf-8?B?RUZpQllaSXg3amNBeHE3c2lMVmE1bm1RRWx6OW8yMVVncm1XMnE3MkIxQitR?=
 =?utf-8?B?c011VUJZQmxqSjRvcTdCVUJPRHhlMWhmenpHYzMyUi9PdXhLY05VWjRxaVJT?=
 =?utf-8?B?Mzc4ZWRaUEZBSTloUm44UWxvUC9VTkNhZ2lnYnFsalJQbjl6VitGaTM2NGZm?=
 =?utf-8?B?RkdTL1IzanNQcWVQamIyS05tTzI4M0pybDF3eEZDN3NNUkJ4WS93ZlZUSTUx?=
 =?utf-8?B?REVPcVRTdy80dW94aERteENDa3creFhxM05DRDZVSXdySldiekx2eW9kM2tx?=
 =?utf-8?B?Y1dQeUdsSkRhV3hiQU9UTkU0aEZUVTdmd0c1eC9mZGVaNE9zUHU0bElxQmRt?=
 =?utf-8?B?RkxnakxHbXlDSmlvWFN4QWw1YUVCNHRnaTNQNmVGdWdhUVYrLzZDdThjam5a?=
 =?utf-8?B?R2J4YUVSMjd5cGkyajJ5K1VoNldnNVFVQWUxbmxnUUdCakNwT2ladi81SjBT?=
 =?utf-8?B?WDZxUVZEbnUzNnFTWmg1OTNMOUlXUnI5dEFhU2hMN3VRdFFMVmF6NU1wNUxu?=
 =?utf-8?B?cmczRzdMQTFrZUl6MFYrR3U4MU82QzhDZ0gyaWFMdW5TZ2NxR0xuWjBVaHUx?=
 =?utf-8?B?UHQyV0pUTDU3ekVaUEVUK1V5VDFLVHRFeTBFK01qNU5CWGRnWGJkRno3bEtz?=
 =?utf-8?B?WGRzbXhrL0ZUYjltcUhIbjRLdkg5NDI4dWd0ZkR2RFIxcmo3UkVGSXFaeVVK?=
 =?utf-8?B?aVZqcUNndjZzY3JldzBBM1ZRSTgxRG9lVFBuSDV0ZkRGRmRPRkhZczV1aHZU?=
 =?utf-8?B?QkpCZ2xkZklFd1VEb1FQR29Sc3BiVEtqMTlHYzk5bkVvaXZOOGVoODhidDZY?=
 =?utf-8?B?RlpkSGxZSkg0eUYzYVVVcW4vWUhtTjhUUXhqeUJKajh1K2hkWmhBQitpQS9v?=
 =?utf-8?B?SXBERnorN3BsK1U3dmx3VnNkdk1PQTlMRXJoMTZsaXlTNk4ybkl3aVArQUlp?=
 =?utf-8?B?RHU2Qm1BK205NlFiVTE1NE9sV3JyNnZacTlYYjVmK3A4aERGdkxTV3h2eHNv?=
 =?utf-8?B?RmVLWC9BYUN0ZkdzcExkbnBqVGRpMk9qR0xsVGtwMnMzL0grYWhxQ2xMSzhw?=
 =?utf-8?B?ZXdENUxrWGdjRzIzdWtnaGpJdXlzUEI5aW91dzhJUzlyMm5xd0d1ODFKZSth?=
 =?utf-8?B?Z0U3QzhJZHd0N1VtbHNRQlFxblF0K3VhVTRlZ1NicURQM1Z1VjVDdGNJVk8r?=
 =?utf-8?B?eHB0L29PeXl1YXNvRVI1eG5MeHVpdUNsK3I2VEQ5V2U2Lzl1dnl3VE05bFZw?=
 =?utf-8?B?b2d4QzcyS3hBb01TdTNxTE5qUklrWi8rN29kcUx0a3l4dEhNcm5INnNxZDVY?=
 =?utf-8?B?aGhzd3lNOXE3WkJTYTFFL0FVZ1FodnhaRWw4ZU42Qzd6d29jVGZ6SmQxQ3Uv?=
 =?utf-8?B?K0Q2THE3ZmY3Rk5RMEI4L0YxTkt6bElOcWxaL0dCdGFrUGpycXBoSEpBeDJ0?=
 =?utf-8?B?ZEpQSmZIM3oxNEtmcW9JdGZrZThUeTdQMUIyS1J5enhSbmttdWo3akkrZUlp?=
 =?utf-8?B?dnBEdmJmalpmQ2JOMGtpWVhWejhudWVBL3o1dUtvQWh5OElYZGVNeUsyUjlB?=
 =?utf-8?B?QzlBM2lzRGl4L2t4bWE4M3Z6SlBsZkZ1U2ZBaWV6NWd3R2xEMEFnU3dNeTBK?=
 =?utf-8?B?UkI5TXJpYTYrZUVKL0NiOWdnY1pJNlRVR0xNb3VzODFmT0dUU2pXM3NLK0xu?=
 =?utf-8?B?Q3A0TTQrMTBzd09QM1lrcmsrcGQzd00yTmJqNzd2UWtWREpwditUNmM5Y1hu?=
 =?utf-8?B?VVI5MUFqcnl6K1hTU3E4VTZSMWpNZDdsSzhMajFSVjVGVGxEMWtBNUU5QXJx?=
 =?utf-8?B?Z3l4R0lpSnFhcDdYOTdlaXI0WGg3WVI1UlhTLzUrb2Q5UHV5WEo0OHhISmwz?=
 =?utf-8?B?UnNGTmsyYy9ORzNvNlVVUzdzTlp0dytaODBsNVY1VlZHbEFYRkt4ZTFqZ0pw?=
 =?utf-8?B?R0I1VFdvdHVGY3YvSnRGdjRrUlJaTXNsekd1ZElpTzEyMmpOaWphbFF4WThF?=
 =?utf-8?Q?T+8EUUH6IEa/niDj78l0+oX8P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159529a0-c7d7-4294-f7d8-08ddeb275a73
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:41.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfZrCmWSx4oBR/s7rSsxyc5dg+NDJLv4LBs8765n6+joWaSfAf32hI5rTXxr3iUKUa3Je9jkvUeSt+k61yvcfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890

Add required power supply for ov5640.

Fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtb: camera@3c (ovti,ov5640): 'AVDD-supply' is a required property
        from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov5640.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
index 17989e6d82e6bef95d96cbdc3545eaebf648367d..73c9cfbdba621c1cf42f56ef2e9d31574c4f8311 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
@@ -22,6 +22,26 @@ backlight_display: backlight-display {
 		status = "okay";
 	};
 
+	reg_1v5: regulator-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_2v8: regulator-2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "2v8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
 
 	reg_sd1_vmmc: regulator-sd1-vmmc {
 		compatible = "regulator-fixed";
@@ -182,6 +202,9 @@ camera@3c {
 		clock-names = "xclk";
 		powerdown-gpios = <&gpio_spi 6 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio_spi 5 GPIO_ACTIVE_LOW>;
+		AVDD-supply = <&reg_2v8>;
+		DVDD-supply = <&reg_1v5>;
+		DOVDD-supply = <&reg_1v8>;
 
 		port {
 			ov5640_to_parallel: endpoint {

-- 
2.34.1


