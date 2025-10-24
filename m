Return-Path: <linux-kernel+bounces-868268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BFC04BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2981AA00A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC22E7F11;
	Fri, 24 Oct 2025 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NrcKUZD2"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2B2E8B64;
	Fri, 24 Oct 2025 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291165; cv=fail; b=S4yQONhXWwFMRno4rriyZ3aD2MIOC1a0eSgvaA4ZH+J/cE4Bf8eDa/WPx1EpnlBjkGPYUZOIP4QcAQIr1TOjOlYHnMTxwrmuCnStvolvv5rNurlXcQGryMXG5tJqIMR7xOSpAKbvoRREK5bnFCQpbYICdIOFglk0JT5RqspOmBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291165; c=relaxed/simple;
	bh=6UJNUqY28v8D+Fa8ewqF/r7e8GfUcXL0ORRytjOP09o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bz1h13tpCkiR6fMaqk6wqxELJzpQ299J8E9Zt6zE2vkSGjuFbiy+GQc4i4dWsK4KU16C0yHhg/sP9StElveIFbWfeaHq4aCJWK3owGtuHI7mKBgSV6iE6wP8bigKSJQPh71fp/tBwoyoUhwQuDZFR6i8p9E67DVe23r18hpYG0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NrcKUZD2; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjMYugQk0UzeRWhMyqiPKptdEsT9fUrQy7XHRG3hIIvrJ1GKui/a8jJ6MFiVwNFqbZBksOxZBQdN0upUyz9mEdgWTam1q0+vOxF/m9oIFkfAP5MRGR3gSJzvZLR08k9VAqP2+0ZvIBRhSg8uiS9lLju+kh5fkKbf5jQbz0jzko3Fv0qDivvcFiyjwH8XkWQAorJFF+KJ29Wzml16k9pxdpU6fXSi0gvwZnI03J10r8x/msDMZpOLE8s/R3FRIHxOjlu5e3JsYoCtkGQmBh8wP2QRejTLf7HCacyx/qjRR1PL+UXWfwKzVm3lBltYTsHCz+NP5A6iJVA9Sa+uoOqlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Vzt+PIZwQT0qycQTPlOcSfpVCSgoRwTKLqBHC6ivP8=;
 b=n8gxRuxKw4srDYFdlfVwaST6fz+fJjqD2UxAMFU7OecBg8Kmj2qEOV2uXD5IPOnUcYXTHBQcFT1ML3i2RSdAhNGmjs8WqAen3kAAiUogwkRpFkMLcb0fbt1cQQsEpodEceda87ATHri/FEfPC1PYElD6h4M0FA3djRydISbJKOEt+ttOJBvfouXytzCyFfIxAF4F3IrLqOphO1evzTCpnQDx+pkADLztAezP6zNfps052akKP140AZRnWsHth+oYRbCz1c1M6FawNHMMbbcK9nS9rwekFaPARCxa3tEHF8kN9KzW50mfB6r/v0cRTxy9e2xaHmaxXxn50WBuWDw8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Vzt+PIZwQT0qycQTPlOcSfpVCSgoRwTKLqBHC6ivP8=;
 b=NrcKUZD2FYQ4MQrIw5oZqNRU8Oz5/mrt7TjhR0RPVwfj8/fpiOYrzx9lHO0vtuelJdGc1Lwrv1+AMi7e4EoBnc27fTD8/K2lwbXxP1a/HsoAO8MvyvktdmqMPAaRkaZ/qz3/9zGxrZf9FEp6HNPAX8mj9gqOfxqzYFzkmen4mzq/5kl9j83bqH31uXIFMvwYKGgFt5vXShP2rY6iA4TSiOGiIvHWxSBTH6r1WHKst58ptDNogmo4xTXLudKiC7VJspkkhSKScHcmxatcq7QPapN7mDPmVTT95tSh2T9RFALr1sHGSi9XP5tlAwFQXlqgn70fJ9gQMQtoUZUSIgOqig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 24 Oct
 2025 07:32:40 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:32:40 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 4/7] arm64: dts: imx8qm-mek: Add vpcie3v3aux regulator for PCIe M.2 connector
Date: Fri, 24 Oct 2025 15:31:49 +0800
Message-Id: <20251024073152.902735-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024073152.902735-1-hongxing.zhu@nxp.com>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: b879b063-6c68-483d-1742-08de12cf8304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3ZpajBnV2E1OEJqc3RadjdkYWI2RUF5aEhlamI2aExaVUUzaW1VUktJVDRr?=
 =?utf-8?B?alYzakFNVGF5dVJmNEtVZkZzNHIzajZMN3dqRjRYR2ZqeUFzR0xsbVVsem1k?=
 =?utf-8?B?MGFacnlNNjg4b2xHZFREQUNJS0NuUjdzc3VpeFVydzZZMjhwcFNjSGNGVDVC?=
 =?utf-8?B?dzdwdytKRDVlVm94U2pDUDFlQ3paK1JueXlBTVBITVlDTS9xZVE0RTF3NVRl?=
 =?utf-8?B?U3pTdEozS3IwTlpsL2pidHhBQlJKaWhua0dvdXAza1U4Kzd5YzVzMklBbUdw?=
 =?utf-8?B?UFVVbGc5TjBnWlJMTUlFU0p4ZkNyWHlTY2U1eGJtQXNDYU1ialBvSDExYnNi?=
 =?utf-8?B?SGRKZHZWTFlUL1FxeXJUZEJGVmlNT2oyV2JmVTViY3pvM2RsaHhudmRMdlNB?=
 =?utf-8?B?THlWOEl5MlFFNTJzdjhjQnpIWFlkMWRVeW5zSVgrd08wV2cxdXk4NVRKL25s?=
 =?utf-8?B?Uy9od0QxQ2hTNStmMlNOUVB3cWNPQ0x0Z1hod0UxZFVxYXU3YlB0dmpxZFFT?=
 =?utf-8?B?d2M1TTVLbnZtUkFmNWFHcEZXa1J1aXR1MVlVTDE2R2tBUE9TQ3k1KzRvVVNV?=
 =?utf-8?B?ZkJpTHd5WjdTeVRJdDdPWFQrdTV4RzlEVTZxL1hlU1FraXNkYVI0WmtUUmp3?=
 =?utf-8?B?TnJrNkY1ZElnK1VlNXN3T3RvK3gzU0dmNVJKeDdPL3gvZkpuZXJQWVpoYm5h?=
 =?utf-8?B?T2RFOUE3bjkxMXVMVThZSEZPZXNXUkZjT2owQmh5V2xjZFJOQ1E3VmdiUEhu?=
 =?utf-8?B?MmthaVVTTW80VDcrY3dJYVN3TXhwTy9xK3ByKy9VdFBCSWF2UzdyTUJEZkZj?=
 =?utf-8?B?U01UWjdwU0k0SGRKZFZGVjB0NklzUFVvcjJ6bmwvMTRQa0ZjNVpCb3dXZUQx?=
 =?utf-8?B?MEx2N1hqUEs2ZXBGaG05eUY0Rmp4bCtBQWZBTFN2MEtzMDd1L3BPeENRcWJk?=
 =?utf-8?B?KzQwT1NyYm93SjVpUlJrU0lLRVcraGtvMW1uRlJKYXN1eTZPOUtERkZuWEN4?=
 =?utf-8?B?Q05KcUxzMjJuZW9ENG9TOWNLRk9CWVpDMG9vM3ZMU2FwZ2V5RGpGYVd3aVQx?=
 =?utf-8?B?QS9uUGxFTHdtbFBRQ05CeEVIcDZxTHlEV0VOdW5uRTNhKzFUN3c5U3F1Skhk?=
 =?utf-8?B?c2VubTZjYnlocUpyWVpLemQzSVVwK2tmUkc2TXVGa25lRUVBMDBXTG5Ocjky?=
 =?utf-8?B?UTFDTVRqeDZXemxYTVNzVk9xMzc4V2xPNEdxOFd4bHBpSFlwK0pEQjZ2clRq?=
 =?utf-8?B?L2VwNmw1SlBIa1pBMHEwMWtOVXdNMmVVWkhvekFFUTc5RnNJN3Bkc012ZFVo?=
 =?utf-8?B?Q1hxOGp6b2Q0bmsrRFRBaTlGKzZuZnpadFZBbUw2Y08yN0FwWWJidDFxYVlk?=
 =?utf-8?B?MW12SkNySnYwWXhqODJ2cHdOc0RIeWN5a2VYVjRCQmlDNWZSV0pnUEpoVHZM?=
 =?utf-8?B?ZVoxbCtEdzNsMGttSkJLWjB5RjdHL2V1dmMySjlhR0xGS0ZFbHcxTzZvMjZm?=
 =?utf-8?B?YnB3THRYV0F6VU5WWTdpTGFLcWI4YXBFc0N2amdTQ2dDaVU2L0J3akQxZDBh?=
 =?utf-8?B?VVpEdGpEdGd3N3crWlowTm51cmpLOFdmc2ZXdGFzRGt4bk1OcjhWSHh1M3RN?=
 =?utf-8?B?NVZvcHgrS2xVZGtxU011OW1ZRWtncnhwNmZuOEZJS1pjRW5wQTh1SkVXNWN3?=
 =?utf-8?B?V3BsMzI5V2lyY2dpdCtRVHMra1pIc1FXNlMxaGFqWFBhQUlsc3QxOUxSMEI0?=
 =?utf-8?B?bGU1WlV1bnBMSVphLy9zMFdhN29kYmZ5TmtHSndmdFlBN2g3aGkzMUIyOFdr?=
 =?utf-8?B?UlVHL09TUEI3MFJTVVVCaHFob0RjMmxNWncxUGdVd2hibE14QnNSamtzRytY?=
 =?utf-8?B?dE9QT0hhWmZERnRRS3JqMWQyaVpTa1h1bUY4Zmxpa0lvdWl1M0Z5c3ltdDZn?=
 =?utf-8?B?RXJtMXVwcmdUTlJuLzFiUjFrWjdBc2pCUSs1MFQ5Q2lzbFJFY1FJNjBkamxy?=
 =?utf-8?B?ZlVnRTdscUNwWUkybWtoc05wZ3lrdnZjZURuc0dxbnJFanZTQmNyQ1JpMzNm?=
 =?utf-8?Q?fYANem?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEx2UG5PbXpFcE9JSVg5MkNwd0owQUZSUEkvTWxlcWp5Z3V3QUZMNU40SGt1?=
 =?utf-8?B?TjR2bUdROEtITmFEMDE4bS9zMVBhRGRqMFpVOXNWdWpOaUUyZXcxeHZzNE03?=
 =?utf-8?B?Z2Z1R1VNY1UvdW8vMnFySnBleGE3SlF6ZjZpa1AvM2gwQ0pWTGFzME1aTnBR?=
 =?utf-8?B?amNpVCtjRldCeGlnZTZRa0szQ0RYbVp1MWlmbm02TS9ueXNralhUV0lUalJl?=
 =?utf-8?B?dkcybEpuYjIvWmRYdWNuLzFVdkxGYVlLTW5lZzZlc3J1VTVCV2xiNlV1SGFX?=
 =?utf-8?B?V1BORVBtVkp6a1kxcmwzUlM4TjdWcC9aV1lOY3piMFZJYWlRMUoyQzJCZERC?=
 =?utf-8?B?MzFmK3RlQ2dBQ0FsVldSZTFGdmoxbVVMQTYvdTRPSEg5SjdDSlFBNG1RSUtP?=
 =?utf-8?B?TzRxT285K0RWcjZRVmVudGZHS3VrWW9sVUhGekNDc0VjbFBCbzEzN0Q1NUJT?=
 =?utf-8?B?aGhFYnlZbElGR3psNnRSNTc5S094eCtFYUNUN0FDSXhSQ0JRWHlkOWdWOEUx?=
 =?utf-8?B?YWkxVlV4dFlwbC9BZzNKMzduOFNYUnYrNnd5MXRxQmZNTEh0TW9adkFJNUQr?=
 =?utf-8?B?OE54LzBkZXFqSzJZTlNQOU1PZkc1blhpVHJ0dXFNZUp5bzlYdGx3bHVSYU02?=
 =?utf-8?B?SDEvRVZRdk55RFYyYUZUYU94T1dta2VxYXBnSThpUUw3ZmZoR0tNWFltbjBn?=
 =?utf-8?B?T3VZQjhXVVhjZ01jNC9DRzhkTis0eGhZZjczNjdXaTZyNGxWN25qRTFTdGZ0?=
 =?utf-8?B?UkU0VlRkcUpDVERTVi9PYTZFSk01RDFrenIrNG8rM1IxZnIyS2hlUkF3K3BB?=
 =?utf-8?B?ZEgrcUgzQ2JlazVBclZsZklIcjcySy9yZkx3d2RlMGNHam9PcTVKcFhzck5V?=
 =?utf-8?B?K0sydlpVV2loc3VwaHBIQ3JkbmM2d0ZJa1FtaWFpNHRuRkZVZDM4TExrMjhm?=
 =?utf-8?B?RWkybDhBKzBCYnFpaVNJWDN0UjJLaEswRUZ4ZlJVZ1Z0Mk1NTHpQWVVBS2VN?=
 =?utf-8?B?MHVNUHdqQU9JSWZMK25CVGVqcTdrMEdYOWtVTDhKNUxLQ0UxbGxjNkZwclRD?=
 =?utf-8?B?TzhUOGt3Znl6UEdGQ3M2NS9nZ1o2TFFvbW9namdaQVlnbi9vamJKeW9hUkQ4?=
 =?utf-8?B?NGZGT3hFZUVoTGxhamVzZ0hCUWdTblRDWFBGOFRqS3lETnExYzRnRSs2NzJM?=
 =?utf-8?B?V09IdTJMVzdRbHQrZ3dURjFEVXMvV005eTdLWER1ZFJNR0VadkxtamhGeUNa?=
 =?utf-8?B?SS9KOG02NlFucGFYaXF1a2xnYlpGR2dMSWNzRURYcFlJdVVRL1hrS2F5WjQ2?=
 =?utf-8?B?UWtKQUZHd2cyOXV5Y3R1UFFzanRNR1h2TVFDTys4SlluNTVCbmxvdGdpRUZN?=
 =?utf-8?B?VGg0NmFsdXEydHBvMXhNR0J6SUJJNThYZnNkbHJETFNxS3EzTWZHMVZnai9M?=
 =?utf-8?B?bkV0R2hicDNETi83bXRpZVdUVzBxL0pma3ZsKzRSbStSeHR5WnNvKzVBL2pE?=
 =?utf-8?B?NUxQOTIzbGpISGtsbVJXbk1wQzhndmQyS1JqL1k2RzZFYU9MakpxcUlnWGpC?=
 =?utf-8?B?aTVtUnVSWW5KZWl2M1ZBUWlWMEVQQlNVdkp6Y0FyYk81cDJLNHNGazhiQlRY?=
 =?utf-8?B?Uk9RMkZlWExxSTdLcVE4UXhtTy9Wd1hXUVJ4c3c5eHpTR0RKOXN1SE1DMEhL?=
 =?utf-8?B?VnQwS05KcVlzSERLby96aEVLV1VYb1JHWSsxbkFIQUNSdDMwdEJVSGh6OEFB?=
 =?utf-8?B?WlNTdmxoNkZJaTFySHQ4N014cTc3T0puTDBiTlVWazJSYUFMWUJTV1NyUzdL?=
 =?utf-8?B?NXNIM1R4czFlQVNET0tNTVJ5MTRaQkhqTVFpdnZYSmoySTRaN1dmK2JvcExG?=
 =?utf-8?B?THlBak05NnBmN3VUTHFYYWRyV05yL3o1MDhHc3RsS2FEQjlrdHhLcTVyanlF?=
 =?utf-8?B?ZWduN2psSmExa2JITGx3QkN1ZUt6YTErVFhFclkyYkJyZUhzaUQ5N3d6aktT?=
 =?utf-8?B?UXp4Q2h6cHQ3N0pVMDViT0Q1LzIvMkwzOThvMWp1dmRpMlRBTmpmRGJQV3E1?=
 =?utf-8?B?QTl6WXYwVzZQSThhRlgwQkgxMjJWalVxOFBUTCt3b1NEVjdCdmdoQ012S21X?=
 =?utf-8?Q?khnBMjs9lYgNzvVS/YqS704k1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b879b063-6c68-483d-1742-08de12cf8304
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:32:40.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQLGUf8E8NMSxMOJ6Uex84zSVVDGGf+JMdbEJUTDfwjmoAPi7NTrXOBHh5NNBRHnAfMsAcN0u3+ipszEIXH2gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
Grounds.

PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
source, 3.3 V, is expected to be available during the system’s
stand-by/suspend state to support wake event processing on the
communications card.

Add vpcie3v3aux regulator to let this 3.3 V power source always on for
PCIe M.2 Key E connector on i.MX8QM MEK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 202d5c67ac40b..6728e1236f4db 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -775,6 +775,7 @@ &pciea {
 	pinctrl-names = "default";
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
+	vpcie3v3aux-supply = <&reg_pciea>;
 	status = "okay";
 };
 
-- 
2.37.1


