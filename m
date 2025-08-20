Return-Path: <linux-kernel+bounces-778203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D2B2E286
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03D51C834B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5369D3375C9;
	Wed, 20 Aug 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QR6Gv70R"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75391334367;
	Wed, 20 Aug 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707856; cv=fail; b=o1bqr7oQpK++krXzy7cQmHoLZk6G0XJTe9IO3RIoLs+uHQ5cGRoINQlXC3ClqH0Yl/x0/w9bCPtVpkewcEnI2s/WBglkOP+MovdDDVSM90Ejv98e7m32HzyamQOhisc8IzsKMhHQ0jlG30geuWNsVyRuAczJXethyzByqjRsVIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707856; c=relaxed/simple;
	bh=u8KaPIg5WEbrrBMCxyVbENjWjCDwS4br2WKQxeAXjms=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fSLKOArSUuD5npV5KqVF5ScfqyKsK7nYDEkNEjJFeNf3A72/IpUm1uH+N7gcE4PZkj7PXCc/bEJwAo77aoiphV3SZYica2sq7SDXZhHCTwJSdDbM7cESFETnOpc05kjeNiEpuZNNbjLCqGoRDnZDRniwXIjkb1SAolrvJb0fY8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QR6Gv70R; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7WTGd2iPX6LMH+uT/O1uXqx8tlH9CsX5Pw/RAIdXNUmpgZ0xap43/3QjNbWOmmyAVnOFlUSma939oYzNaITekTShaPLv5z5EJE8hD4Q91QWj3OI/5cdmZmdCmP8yVYSGFSQ/ohuhuogpoO5dkRfUbdcHygJERbL6uBNz3zC6mOWlgtVlLaTOgT32A0BCxZlbXT3CwfNOFGje4P/J8YUz5y04Ph1LHofTL/gEYo2lfKCHSSpjB8bVeLP/qOUaBUZttgslJ/S7Q0RUwzItBtduzdF43VwAK9l3/Gfbq4Hq2k4UPmvhDfghfrdvp7hnsGMmsgtuEaVNYpePhgwFM49Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbJhogPXWV+l0PE8+VDWiLqgnaLDqe0J9oaTWmq/4Mw=;
 b=lNUBQjMjYt6BYkkTYnQoyMFyCCFxuZT6Jk+cwQJv3t6wNTGfeABiT8Fhhfx/SK1LJO/veABJFgPtSEGRWDNs6GIWU+SNSEOfciMo/j3SOZOFO8sVKC2L7qusUtsiXYyidmdWvj9NEGfekAXuQx50KlRWlh3gj9tVYkZJhzv2/ETK+F5xy07odUWbFhdgUHJutO07GmXqm/sHCxT+UKfIrgOS/MN3J0EGWHSJDsEYgon+4Au7V+8nuXEBn5lxPPzsNZ+WR3Dx0vRy2ohY5RWKZOTdkvwZ6ETxsbROO50BJohFh3WeJcbspd5zvn++yyutp4opuVZG34H28g9wT84pTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbJhogPXWV+l0PE8+VDWiLqgnaLDqe0J9oaTWmq/4Mw=;
 b=QR6Gv70RIv8tIMsLDP5CdzUgFQ1FOMuR9MiZd8vrwA/6qmw15+HOF+vfzBBdUw7+j5xMxHS6CqyMQCKS1oOLEoZYRGbeq9OBCfUr8UkaYeeVY78V8FTVOvZHMvutHMx7CoifL2c14KNhHCxYSaXfQzzQOSTC2ZqL/oMWPfbP8wAjYBOA23S0RlV9m9MfaFpFhKSOHcD2awhHznpC8tH80Qf7IlWieEOezg5hB+EjjxQNLuaHm8sMpeaaF6XCIozbYKcfhc7mHEvqQxiOAJU6I89SaJbACbK0nzhHhy9MIR109FeJz87WIhLx10NsX/PtO08W91o/TZzhfPlw1dYb3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:37:28 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 16:37:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Aug 2025 12:36:56 -0400
Subject: [PATCH v2 6/7] ARM: dts: ls1021a-tsn: Remove redundant
 #address-cells for ethernet-switch@1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-ls1021a_dts_warning-v2-6-2e39648a32b7@nxp.com>
References: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
In-Reply-To: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755707830; l=1081;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=u8KaPIg5WEbrrBMCxyVbENjWjCDwS4br2WKQxeAXjms=;
 b=ptyZqJ7E/V5VvbAva+8WxjdMIJCdBXcMkFYHwfmc4wJmys9x6nXCg0uM1FXdMumPwoIXJAwJ1
 Qf81SpRS+Y/BE2ltKbznxAHDxQoePz5AX4JXwNvPfSwptnESTGn8gFv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: b17967b9-30f8-4031-4fe9-08dde007da3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGJmankzdlBmcFZreHVQS2thbmFHUTArUGdEZWluTlJjUzJZcHFmQjFGL1dC?=
 =?utf-8?B?ODVGdzVUTG9VM3FuMXV1a1cvR1FEY2lkek1PVVdZNnk5eWl0MnF2K01nRGlD?=
 =?utf-8?B?ZkN6SjR2UWpuSG40WG8rOG0vM3NxVjBMbmQ0d0tyN1BqSER3RFJaeDRBRWIv?=
 =?utf-8?B?S3RCb3V0YWtnWW52dExBZ2Z2NTkrUjRnZks5Mnh5QlMzMVVuU3J0eWd1YU1h?=
 =?utf-8?B?OU9MckRnVmpQOHQxZE1IRno1VUlPTGxTeFR5c3V0ZmtkOXhDZjl3YitwZWNV?=
 =?utf-8?B?eVpBOW1vd2pZbHFyWk1RcjVBWm1ZNThBTXVvZ2pjUXg2Q0N2MEpQUHIzY0JN?=
 =?utf-8?B?Ri9sK0o1Um5kZ1pNR0lka2s2SkNBYU9PL1pJcnZBZEd0VEpFRmxiMVFyZW1K?=
 =?utf-8?B?TUIwTzFyd2tnZVJWNDgzKzREZ2NoQmxZd05GOUNtUFpUdE1HTDlBMUk3L0p0?=
 =?utf-8?B?ODUvenc1ZUJSTjdqSE1BdTNXQW1zQmRPbUM5N3ZiTmVGVGJCeTYxYXFHek5z?=
 =?utf-8?B?blNpRENES3hiYXZnb05yNERKOHNQdGYwdnZwRUpDMjNLaG1hSGRkQURrTDR1?=
 =?utf-8?B?eENsbUE5aFgxYjlIM3MzaXN6Q3hpMGQ3K1l3UUR3T3pFZVV3NEZKaTFJVXJL?=
 =?utf-8?B?RWJMYmg5c3JkdDhoT3d1U1pxd0J4Tk4xSmZXeHZDTXpYaTdpck1ZdGpiSzNU?=
 =?utf-8?B?NkFpb05aWG9yVm5VV1FrNTAwVEFNNjNmYUNmK3pYYjducG5tdFFsNVpuakRk?=
 =?utf-8?B?bFNOclpWYzFBb3NrRCsydVVOSTVwQ05vVkc1aWh3UmppNjkzb0RwQTJ0M1px?=
 =?utf-8?B?Vk5CMmovWjdKTmhXenBUKzF3SGdORkJ3T1lmTGR3dXJoYTk0Z1QvK1I3LzdH?=
 =?utf-8?B?ZmZ5bEdxeWhxLzFaUTRRcHovMmJaRXVHaHR3YXVaeDM4QWx1Rjd2K3pSaXZj?=
 =?utf-8?B?UTduQVhPT2s2a3hVMnZ6R2dsMUY4cHdHV1hwdTUxRXVZVmRxRTBpODE4WHNs?=
 =?utf-8?B?bmZUUThNOXg5QTZleTk3b280VXU3U0FtZHQwcWpHbmFIT3BqQnlFbzE3T3py?=
 =?utf-8?B?M2p4Vm02cGdKN3lKVmdwQksrQW82bW9xUmgyWUtnVGhsRWtySmVDek01cTZL?=
 =?utf-8?B?VDN2TGNib1lsbUJhRmkwODFQbU9qL0VQRHI1d1dlWjRCcmN3SmRQYVBzb1B2?=
 =?utf-8?B?QlR1MjUvQTM2WlQxYjBHbllDc3JKSUZsUXBBdC9jNlFFdVp2UnFVKzE5Z0wv?=
 =?utf-8?B?WWtPbUpkb1daWDBlV2V4eVNHakF0dVlSZG1kb2poRm5odHl2YmFCOTBJNTc0?=
 =?utf-8?B?NzJkeTdPTjBTWnUyMGNQU2Z3d0h1bkp6bU56Z0RpeDdCV0pURjg2Sk96U2hy?=
 =?utf-8?B?ZG1qR2hWVUlpaVRnc2phcUIyK3dkRHpVeUlQK2xWNVBRSFNGU3dncFVoZ2Fk?=
 =?utf-8?B?dG04WXQzMy84NFMrR2Z1b0k5SVdEYzdBcXZTRnVDZXZ0SmJ1RTNOVVlCdk8w?=
 =?utf-8?B?d2dFNko0Zlc0TXdIVGxNcTYvS3Rna3VrZDFvRWZ0djROVk5FLy8vQnZBazBp?=
 =?utf-8?B?UkhSN0RjeXVGeGx5N3g4eDFhWUVBalRFYkc2OS9FbjFmSTBBOFA1VGtCZkpn?=
 =?utf-8?B?aEwxYUxtTFZkclNsSXRhOGFqUGt1N3RQaXp4aWtkSVZyaDdqcXdUT3BMV1Z2?=
 =?utf-8?B?c1c4d1E2a29VVFI1c3FnYmZRb1N1NmRmRHhYcXRTOUVTTldFblNZQjBwdVU2?=
 =?utf-8?B?NUxoYlNDRm1IREM5WXNrY2gyMUdqUHgxMDVkaW1KTWhHTjUycEV3MXU5SnF1?=
 =?utf-8?B?clN1U2ZYN01YZ01NTFk4TmZHcG1JckluV3ZYbENsNnpzQ0N2KzlVcDg5dlln?=
 =?utf-8?B?akU5TXRURUJvb3JaZDF4UU1pTGtqbExTK1ZWVHdrZnZybnBsU0h1emNOOGpI?=
 =?utf-8?Q?zREwzfAiwdI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWVTMXNuZnBKZWNIOVVUVkc3bkZFNDZtWEhsQjJNbmdBK3ZDNURlS3lOOHVW?=
 =?utf-8?B?RjVXOEtkODlRUWpvajYzdlAxR2gyQXNOVHpEaW9QdEN6eWM2UlYyVUdKK0Ex?=
 =?utf-8?B?RVVzN052RDI4S0RqRFFJanNqZ3NXUm5GdHpzQTNvOHRiSHVZMnhrUlpkeHNL?=
 =?utf-8?B?NmlkZHBGd2U1REZ1U1BXb3ZGdyszeWdZUVVLTHRtRGs0bkpCblJ1YjBQblUv?=
 =?utf-8?B?Ym01dlpmS3c1TDNjVzlLNkpXbEoramlGaDJNMGc2dmd4UWtTNTVXSkkxNWYw?=
 =?utf-8?B?a1plTVNPc2x6aFQ1NjE5Vkd1MndqOUdVdnpQdHljL0JYTm1aTmt1SC9GK3Fz?=
 =?utf-8?B?N2JiY3RYbGp4ZmNONWlTdzd4c0tibDlNNDlKOUpqUEszTnNPZWZxMkRUTnFa?=
 =?utf-8?B?dmxwcXJTZkE5b1lsalU1Rmk5a3h2Nm9jamplU3g1Y1k0SGlJRG9XNkx1YWtF?=
 =?utf-8?B?K1dnbDdiNEpqSWk2aEFLTTFLSWxwU2V0cm5KbnE0NjkxU0NDcWdSYk9LZWxC?=
 =?utf-8?B?TWtNVTZKK252MDNkKytlK2x5TlZLeVNVRjN3cE9qeFJqS05JK3BOYkJvL2s2?=
 =?utf-8?B?aHdOWEFjK0pHZDg4d05JSzB0VHFxSmJISENVb1c3eEQ2WGFKM0ZESm9rUnU1?=
 =?utf-8?B?RkRFMmlMaXZ3TjRhZ2toU0pCMkY1Z2tLa0Zid3hia1hCa2RvaHcrU1MxTE04?=
 =?utf-8?B?a1VJb1ZENjdFUXB2Skg1clZmWTFQL0JSNUhpV3ZJWkJ3OVRJelluQ0xkOE9y?=
 =?utf-8?B?L1JhSGtwa0RjYXg2b0xxRFVjTkpTK1JPU0N0QVVBTDF5TE1Wb2JlWXB4TjhN?=
 =?utf-8?B?UC9ETVZhejVXOXRBcEdRaG4veHVIT0tla25yTDlGdjEwTnJBd0JPNzk5NDZH?=
 =?utf-8?B?eGtIZ3FRdjcrTUE4b1pLekJSYklQRm5Xb3ZRZklLWkpwQXdVckt1cHRVbG0y?=
 =?utf-8?B?MGJpdC9BNFVYZlFxSVNQNVlSOFZjVnBZQjNSdmJSR3pTakpFc0ZvNG5BaWlj?=
 =?utf-8?B?UDJWYTQ5NnFkODR6SDYya3M2MElzVWt5L3I1L3AyMTNwZUpGYmhkdlEyT09j?=
 =?utf-8?B?ZWZuTjExa0dhVHl6L2NDemhyc1QwOHFaOVJMQ3BUbUVRNGhCcVJlZC96bzZi?=
 =?utf-8?B?YkRIYXVKZjhmVTBFSlN3M2QvZUl5ZnFOblByTEZKcnV3VXlBRVR5bXFwZXlq?=
 =?utf-8?B?Z1N0VERzOFJKd0ZxQS8rbzlJN0poTzdPWjFUUXg2MklxMGl4a3RRdHIxTTg3?=
 =?utf-8?B?RjF1WGNOMnY4aXhhYm5xblQ0WmJweDVqREQxR1d0ODNKcHdjR056dlVrYm9s?=
 =?utf-8?B?T0dQbmRJYzFibWpQTjcyWnNJc0NuclYyZTZYZUVHVHNydkpRMldCYkxnaU1r?=
 =?utf-8?B?cEx2di9XOGQrYTFNT3A5RXgxd2ZWTmF5cFdURmhLRE9LSlBBNGh5VVc3V3BJ?=
 =?utf-8?B?aFY0UWx4K2ljVlN4MVN3dStHTjlFS3lzdXZVeVJDeWZ0SnlqSmJYWnJSdXJU?=
 =?utf-8?B?RFk5a0xuc2J0RXY3b2dXRG9jR014VnFJeVdwUTJvNjl5UWVuRlJLbnpidllU?=
 =?utf-8?B?YzhGK3V3a1JtUFFHOCtHdkRxakNSdklkSlpDUU8wUFA5eUxwVTJHMmlIeWZj?=
 =?utf-8?B?ZGg3M3ExWFh1YkFybERqdXJmMWVXRTFVTkh3SE5keW1VelhsRjBqQ0FjWFM1?=
 =?utf-8?B?dk41dTlyRnFoK1FNNlMzUW5DN0lWd0tWQ3dESHpqVnNYcGY3NXZNTWZOK01W?=
 =?utf-8?B?VEpwTTFEaWtObWorRnRsQkVnaFZ4S29tRkdHbkhtWlZMQlNCRzhoNWl3elVv?=
 =?utf-8?B?bUJLcUplcHhjQk9lenRHNDNzbnpLdkF1Z1IxQWVzaFlIaEhhSHJIZnI2RkpU?=
 =?utf-8?B?TjFybE16REE5MVpBVC8ybGtSWm9VTlVOMWdmN1RqaFVXQXdkUEdwVGtDaThs?=
 =?utf-8?B?UGxIZkJrTGFvK2M0UGhyeFRzbWEvQkYwYnZoRXpqcHVxTGlncVJIYlk1OVoz?=
 =?utf-8?B?Wi91d3EwMlhnTlhrRHZZVWhINGpndldsQVhVVkdCbVF2MkFJTEltdE5BZlBM?=
 =?utf-8?B?c2Nmbm03YUNFNExJUDk4dXZVOE1yWXN5NjZXOWtQVHZUeDdWeGZMb3Bia2pq?=
 =?utf-8?Q?RaQjv4Mc/h72SHD6U+MyIvfJQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17967b9-30f8-4031-4fe9-08dde007da3c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:37:28.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHEZ8ubcY9RyVLxKEN52xidLn3xfs/uqbkt/B96OKVEZKNYs6lG1Rr2v8rHXQFzuUi9JWTB7V8EXjFCDwHnuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

Remove redundant #address-cells and #size-cells for ethernet-switch@1
because children node have not address.

Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dtb: ethernet-switch@1 (nxp,sja1105t): Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/nxp,sja1105.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
index 1ea32fff41201b7a787dd116eef675318861ad19..da76566f3510ce866586a214b4df6992e5fc4843 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
@@ -40,8 +40,6 @@ &dspi0 {
 	/* ADG704BRMZ 1:4 SPI mux/demux */
 	sja1105: ethernet-switch@1 {
 		reg = <0x1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nxp,sja1105t";
 		/* 12 MHz */
 		spi-max-frequency = <12000000>;

-- 
2.34.1


