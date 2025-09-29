Return-Path: <linux-kernel+bounces-836383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363BBA9890
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F5E3AEE01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6899306D5E;
	Mon, 29 Sep 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L+wUxLR4"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75069309F17;
	Mon, 29 Sep 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155879; cv=fail; b=Ox+EKVSpeCTbpU2kbcGKA1TyULDtzcXflK3ro8BUQWoamPU9ekRX7ElQysiQ6bWtzQ5fEGQRyP4B+8PK4IkR0CutarxSFgjxBbmGzQRKuwS1S6XG3+kqRMQ3Gvks5AYIDq/zmt+OiN3bpUYjhtzPGx9TL1GUIakKw2990Cwq9dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155879; c=relaxed/simple;
	bh=wZakniPJ/VL7P6jI1lKmGvReYmoD/Pd3cpnepbN1CKU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Txp6KGyk7Xl1Eb3KXSzn/HW5iODrX9LfiKguWpdRwgLn8VoToDTI1K8dMpwu4om3v2PF9zGUJ2n8uUIJukYOjosSGpIA38K6hNHGMVlus2QVtwsGbk3thlE7VJl1ismgAPz9G2pPaWM9MqRwfY01lcy291KMEAglQIkEcknKtJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L+wUxLR4; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX8Ec/boDYOmn9z35laeDKNJo/Ii42L6hdbzzqQxmXaNsdI92QRlMo/2imfHGy17jrg7LN3lRBMWVnwZjZs/SySTFBGbV4ydd6vOocsugh72awCxbqwR5T6WfVslq1WA+q50vTrv0jt1JGlzGSNnzUc4o0iRT2/jpC2+2SlqF1sy2FciMDKRpD3fUT/QHSbTdphSVpsH7ur4VNgFIm21OXJdICMFIx5eA5tgeCh/MRM7kHxNZHpavkmgVrwH+3a77pb8jtBSsc0+FBzDt/mLkamzooVE/SIYmJmX+VWOp/9n7cL3ji9/9Hw6HbAoP7s3lOOFwCS5A7tg71Xk61z6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vdIwTo4DlemL7xH2H2M7E75nBSRBE+stSgrR5SDf/w=;
 b=PmXr6GXFZOnCqjGc3EEE8CD+9165mIW2av1KnBZ4bpfPlL/8RvQ8gw26B2nDEwlHaGcpkPa1wYWYF2tsWpTIUSLmkFde+nJeRty3OK5oy/3HWblcXYWKBeht01jr9l/iMWuVa4jJSEI5hsROEtx7TsgOcMpdjOhNGtYj3H8kExn5QbS5yrdxGL1m8abZHpsPSmcvcqwP2kVQX7jzI57tN7SpsNiiGtArImJEbQ3NmOJ5guqvq4mDQdf7mZoXl3eDH4+G1vhzcZDwmeSyNbEmNC/saCbZaFcrCfXHkk1l9ACLgqp//N3Qim9ALjmHz2OaQOBUr6R/hDvH3GLm6SLWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vdIwTo4DlemL7xH2H2M7E75nBSRBE+stSgrR5SDf/w=;
 b=L+wUxLR4rEntAn6VV+lSs0eHMGiNJkmFBjaFmADyjWHR9IlCk0UTQ2XHk1eY/JhrKumSWbCMaNaJeMV2MHj2TUWn4URvNtdJAnF7qOwi+42FJk4uBEBoKA/rxngPu8X/WKKmdLwaHyIi92niUNRFQUsfn51C/JgG9bUTG6BzLG0UNGU423F6GOgZzdW+cR79ldRVtsjyms4HipE4TmTNbnqsKgksWdKs6NucFHywRCH1J0UJHtBbZwQxtFpd/NqO9wsKWGy8h0ITyk6xRLtiXD34e/WEHfcYV/OnA2nFsJQ2sJDboYARqgQPqnGeSGeqsyKc1kd7xoiTffVJ+NcC1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 14:24:36 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 14:24:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Sep 2025 10:24:15 -0400
Subject: [PATCH v5 2/4] usb: dwc3: Add software-managed properties for
 flattened model
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-ls_dma_coherence-v5-2-2ebee578eb7e@nxp.com>
References: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
In-Reply-To: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759155863; l=4765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wZakniPJ/VL7P6jI1lKmGvReYmoD/Pd3cpnepbN1CKU=;
 b=1FDnseHFCwI4txM/Lw7RF8A6GcBTAy0A4WkEpVd6pRc0QokWnHQcb7L1MVjbcTu/ArtxRnaUk
 QlbAkj9vKL6Btcu3APPsB2Fe+kzRd3OeEi4B+IFR4T3ugLwEncL5ugT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: d559070d-de8a-49e8-40dd-08ddff63ea7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXVGb1lONEpYdjB4end4a2dOaEcxaVZxSUFBenRTRGVFODdjaEFvVjN3M1Fz?=
 =?utf-8?B?NmI0bk1rT29yLzdzL2xLUGNFY21sZ3hlbGwzdldoSUZFOFU2YkI0N0w1RERM?=
 =?utf-8?B?STZaSVArL2M2VE5XQ3pZcGsrRFl1MTRIOVFLQzdkdVh4WitSMXptN2Q3M2lP?=
 =?utf-8?B?TDVoL3VCQ0ZpL3RxU3RucXg5S0ZQWG5uRUNlTHhjOEpBclpJVUIwTSt2Zms0?=
 =?utf-8?B?K2FyRVl4WllJSnY5dmRRMVExcmVMcFhIcDQ0Y3I2SC8xSHBvT2xwRGdPM3Nh?=
 =?utf-8?B?NWVZTWxSaUI1UXFGbDJFQnN3d1hubE1lbTQwVUNDLzQwSXhpa1lxajRibWhz?=
 =?utf-8?B?bkJtMGpmVkVZNzQ0QUl6NHovMTJZRUFXUnY5akNsMWI2aFRxU0prT2s5cEhk?=
 =?utf-8?B?aUlBS2VONHVJT2w0TTJDdjFVYjJIQ0FLZWg0cHBBRHFUMXA2UFpHQ090cEJF?=
 =?utf-8?B?aUUrUHVtY2RaejRBT2U0TTlDd2dITGZwWmVMYlM0QkM3ZHVBelFCVCtQdzBx?=
 =?utf-8?B?bUludU4vSjZiM2w2VHl1Y3drS2U1SnRuSUdBL3paOUxuOTZ5UEdKWmRNQk1I?=
 =?utf-8?B?UWE0dVpPZ2dqdll2RE1YaGtsVjJrV3Y2cWU4eG02aUJhdEtVVHhjVVczaWxQ?=
 =?utf-8?B?T3NaT3M4UWRkaHQ3aktOZDMvSHU3SkppZEptWWE1RWliRW8zS3NOSC8rOTZQ?=
 =?utf-8?B?UlhsUEtIN2FBUk5FVEszay90SWJ1Z1M0SW1YZStaSFRUZDBDak9acUs3SU9x?=
 =?utf-8?B?V2s2dHQzQUJlZnJrRHBoSFdKUitvV3EzLytieG9xckpBZzVGelo1RVhqRk9o?=
 =?utf-8?B?bHp5MDBZQjk5a3hidUlvWG5XcEVVemYvYkFxNlFXK1ZteGR3SGIva2YzMWJ6?=
 =?utf-8?B?Y3hnaTczVDdLbEhmVU12YW03TlI3aWVUT21NUWhHbWphVHErRDNTMjZaNFV4?=
 =?utf-8?B?NXZUcEU2bmgyM3NuTlRsczJ6RHArUjRjMWViUjRGbnFFY2tkZHRVV1hoZjho?=
 =?utf-8?B?RjZDMUpCZS84ZmVKdVZkMDV5cjdFeHpQRkhSL0Qwak53WHdzR050d2lJbUl0?=
 =?utf-8?B?eHdUVWEvVzNrNktMai9Zd3BKd21KdXl5VGxTbzZiUlk2OTFKL25xVVZNS3hj?=
 =?utf-8?B?cHNiS1p6c1ZwbWRBTkh2U3E1R3ZjdGJjaFoxQlpNR3JPMFREbWdlTjRtZWNO?=
 =?utf-8?B?VWdGREgrQXlrdnl6WVVpa29JaGhzSXJqVy9MdWg1YVJRajY2dGJIanVtUS9H?=
 =?utf-8?B?N0lYc1oza1JScXp3TTZFYk9aL1VodERKZFMvTHUvb20vYTZwOWFGNVlUN05x?=
 =?utf-8?B?YUltVTdhWUhXVHMyTk16Qm1DN3FEVTR4bkZuZTFiL2NyTG54ekl3b3hZanFW?=
 =?utf-8?B?WUNVMFJEcUNwK0xMNEhuNHdZOVlDeEQ4ZGlvNG1FZHFwejdiOEVLaE5KOGxo?=
 =?utf-8?B?emQxdW02ZldsekkxR0hEOGRpaUpkb3lhbkZncVRDNWluUWdHS29ia2lrQzJi?=
 =?utf-8?B?QXBLa3BSK3psYks5YjYwZ3ltVXYzZGhtYnN6M1hIVG5hSUUzODlJejY3ODBS?=
 =?utf-8?B?WXBlZUFyZDJWejhqdkVhVUZlakZRQ0pocEIxRnp6WFJ0N3lscElKQXhtOWlY?=
 =?utf-8?B?OHUwVWdSUVlPaGJ5VHhaTlR3Q3NSOVlBQ3NqcWJyeHJTRHZyR21sajNId3F1?=
 =?utf-8?B?dW1DUTRkTC9wWlRUUHQ0RmxzUkNVa2MxNzdhdjc1dk45eWZvaWF0ZUpmZlZM?=
 =?utf-8?B?M0xzWUpqc3hnRGtYN1JHQmlRTmpxUkpjOVVGTTNaeW8yT2k3WWZjMHUrZy84?=
 =?utf-8?B?TmQ5YUJrSE43UldVSEI4eXY5bEdKanBFZnVmbkt0cjdyejMxcnBPRFNLTW02?=
 =?utf-8?B?SDVzNExub3lSTGFqYVB1UjRaaDEreHJIdzVvQ3kvc0xhRkZsL01EVmlpaXdX?=
 =?utf-8?B?QTFubjBteVNQMXo1aXFXWkR4RVRITDVTaWFVOTFPbmt1T2tEUDNNemR2Wjll?=
 =?utf-8?B?UUc2b0I3MFJIeTVQU2tlVkErMVE0Mm9oalRITk1EODRIK0cwZHhHQzd5bGcx?=
 =?utf-8?Q?PBTC94?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzdjYzdpTDZ2TG4rV01lN3VwVmFqRzlBWk0wS1ZrbjRZZlVqaW4vanVtdHlN?=
 =?utf-8?B?WmR3NUlnSms2S0VVbTJmYUtLRXRuRVlLU3RuVTBaaHZmK2hPdWtLTzdqU3BR?=
 =?utf-8?B?cUxQeUorWEl0YXZ0T3pNR1VHNjA3c1Zvd3NqNFUvMC91SzRPeGtlMGljbk9X?=
 =?utf-8?B?WmR2eXJFV2pSSU96MXI5T0hNN2hsNFFyR1pwZ1pLQ08wZ2N0ci80S0VIVVlI?=
 =?utf-8?B?VkMxcFVabkNoQzlxMXFUc2hlRE1DQXBRM0JCQ0tDOXU0bTJEUXNtUGo5anAx?=
 =?utf-8?B?MDFjVXk5c3BxYjU4cmF1cGptdXg3SlpOc1BnNGJRTGFxMllDa2h3dTJsWU9j?=
 =?utf-8?B?Nm9rUnV4MlVObWJxUFk3MGJnQWhRcWFHbVZoem92YUxWYnBsNGxWRVk5c1ps?=
 =?utf-8?B?Y2V5c01DSWdha0VGc1NKWkFaVTNNT0t4ei9lY0d3KzBEam5mNndVdEw0VzBN?=
 =?utf-8?B?azB6c0xnNk82cjRBQnRkWjZzMS9KOHdxTXRqNVZ2Y2lKWm9yVkV6dlhpcWR0?=
 =?utf-8?B?OVU1ZDRtc2NQZy8wMzBGNHRPUng1b3ZnZmpWZjhrVVhQcXcrMkxtU1piMmk2?=
 =?utf-8?B?QzA3TktmNmVrT1g1VTEzUDI2clFqcnZCM2FiWUdqZ2U4ZG5zMXhiRStKY1pH?=
 =?utf-8?B?WFNGUFdIZTNRNnlQVTZoNHNuWFlVMGZYZzI3blIyYTUxeUZTSmFrMTVpTXhT?=
 =?utf-8?B?N2srNEFuY0RIcmlFTW8rb2ZNQzBFZXM3Ykw3N1RzQzJyYWwxUWdiM1hnWlNn?=
 =?utf-8?B?UTNsc3dIdnZNQmphczVhZVp6Nk1OOXFRZmo3OEhzOEgvRlhza0M3RWEwMWpi?=
 =?utf-8?B?dUlvVFVlcTF5UjJJa2V1eHh4cWdDQ3RzdjB0TUxwZnhOQVFGNXZzTUd6RnhK?=
 =?utf-8?B?VzBNdnVNY082dEVoTG8yUFUvUnVONk5zVCt5TFhjYmlzTzcyRlIzM1RDOFA5?=
 =?utf-8?B?OHBuVnQwUklJek9kYzRtQnUrd0JpM2dCQWRqcHhLVTRzTWhjVDMzQWlobXR3?=
 =?utf-8?B?RUh4M1BXVi8yejNjVS9OVnVCQ09UOUNNOWhqTkt2RnB6ZjAzOStyT0phN2Jy?=
 =?utf-8?B?eHpuVm9nL3pBWDlmUjZoWUZvT1puV0JhVXBPR05FdFN1NFk3NDBmSGY2NGZm?=
 =?utf-8?B?QnJjQmVMY1NIVktNV2NYN0VVbjNGcENZZS9kZEJuL2JRQlM5MExvV3VmVXpV?=
 =?utf-8?B?a25XNTVlb0ZrZk9aSnh2d21mV3ZFVDI1cWNIN3JYT3Q4c0xDVVo0WjVmWWR4?=
 =?utf-8?B?Y3crRWJoRTBFZWlRUklaYTZEbFAwUlJ1c1RQZnoyazh4Q3lWb0E2ajBFOGR2?=
 =?utf-8?B?aHU0WnhCaFdITUV5ZGZJV0plc1M5RlVLdlZjVzdJSlh2SDM5Q1lLd1Q0bjQ0?=
 =?utf-8?B?S3lrNjBFaVYvYjlHMnhpU1N6QjBQTU8xbEJQN0E4eS9LRGVwQy9BbXVVbFk5?=
 =?utf-8?B?eU1maUVyYTA3UUVCNHFiVldYeE55NDhjMDQ5M25aUmdXSlhQMnZjcXNOMFpH?=
 =?utf-8?B?dHJrSHlxWEdTdzR1Sk93RFBwZ0VBK2Q4dHFSTmltMnlDWFhPM0hQZ2FKeS80?=
 =?utf-8?B?T0QwS1hjNGNvVXRKWjZsQzVrT0s4NHZFSXRkcGZOT3RCVlp2d3d3UmhINEtl?=
 =?utf-8?B?eDFTeUkvR1BnYlpYUWwyeWpTNzNRa3ZQekdZZ1ViRkJuc3FwVEo5cm5sZGpz?=
 =?utf-8?B?c0hoVTBWczg1U1hZeVpWSUlKL0F6R1licU5Kb2pucXJOMXBVdC9ram5uZ2xx?=
 =?utf-8?B?V3dSdlN2NnJJZ0tueDBITTFqZVRQQ1pibFc1d3BmaExMQ0U2dUdVMy9TUkRk?=
 =?utf-8?B?aDAvdHpEdElOSHpLNTFRcDdlUHdjM0xLS0FGT2NlOXE4czhybEtCcDJqZXpD?=
 =?utf-8?B?NG1GREMzWENMUzF6bWk4SDRFaGE4MU5GNTVTQXBiSStmMHAvd1o4MTBjdjN6?=
 =?utf-8?B?TmZpbWduWi9FNW9NYmg0bFdmQXRHcjd0VnFNUWZqYmZQbFArZHp0czNTeVFz?=
 =?utf-8?B?VHBMcVNVQWtlNkhMUVQ4bGtsYU9lRUcxM1B1d1JVUVlGTnQzQ1ZLTU9iSkpI?=
 =?utf-8?B?akU1aEpqeGFKaWVCbFlwdU42UDlJTU5ndlJKZTA0bXJGUUl1ZUh4Rmo3RWdY?=
 =?utf-8?Q?wI+k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d559070d-de8a-49e8-40dd-08ddff63ea7b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 14:24:36.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuFAk4K83WRkH6ZHdUaOkNZ56N1vsV7//K3pvfvpPXSkDKKNLXxQ8AYSeOaS6OV1Cp/fvXAeFO6D0L2WOJ3ZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607

Add software-managed properties for the flattened model, which does not
need to use device tree properties to pass down information to the
common DWC3 core.

Add 'properties' in dwc3_probe_data and set default values for existing
users (dwc3-qcom, dwc3-generic-plat).

No functional changes.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- fix typo propertyies
- add Thinh Nguyen's ack tag

change in v4
- new patch
---
 drivers/usb/dwc3/core.c              | 12 ++++++++++--
 drivers/usb/dwc3/dwc3-generic-plat.c |  1 +
 drivers/usb/dwc3/dwc3-qcom.c         |  1 +
 drivers/usb/dwc3/glue.h              | 14 ++++++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 805cd22f42e0961252b0371da9b16cc804e49342..35f9c566358886c106d360dea84f2e6f1ac19688 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1668,7 +1668,8 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
-static void dwc3_get_software_properties(struct dwc3 *dwc)
+static void dwc3_get_software_properties(struct dwc3 *dwc,
+					 const struct dwc3_properties *properties)
 {
 	struct device *tmpdev;
 	u16 gsbuscfg0_reqinfo;
@@ -1676,6 +1677,12 @@ static void dwc3_get_software_properties(struct dwc3 *dwc)
 
 	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
 
+	if (properties->gsbuscfg0_reqinfo !=
+	    DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED) {
+		dwc->gsbuscfg0_reqinfo = properties->gsbuscfg0_reqinfo;
+		return;
+	}
+
 	/*
 	 * Iterate over all parent nodes for finding swnode properties
 	 * and non-DT (non-ABI) properties.
@@ -2208,7 +2215,7 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 
 	dwc3_get_properties(dwc);
 
-	dwc3_get_software_properties(dwc);
+	dwc3_get_software_properties(dwc, &data->properties);
 
 	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
 	if (IS_ERR(dwc->usb_psy))
@@ -2358,6 +2365,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	probe_data.dwc = dwc;
 	probe_data.res = res;
+	probe_data.properties = DWC3_DEFAULT_PROPERTIES;
 
 	return dwc3_core_probe(&probe_data);
 }
diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index d96b20570002dc619ea813f4d6a8013636a0f346..af95a527dcc27a7a14d38dcc887f74a888ed91e6 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -75,6 +75,7 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 	probe_data.dwc = &dwc3g->dwc;
 	probe_data.res = res;
 	probe_data.ignore_clocks_and_resets = true;
+	probe_data.properties = DWC3_DEFAULT_PROPERTIES;
 	ret = dwc3_core_probe(&probe_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index ded2ca86670c0bd7ceadd3cba3fa5ecf9e7e02b5..9ac75547820d978b4a32e570e5f59a2807be68a2 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -704,6 +704,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	probe_data.dwc = &qcom->dwc;
 	probe_data.res = &res;
 	probe_data.ignore_clocks_and_resets = true;
+	probe_data.properties = DWC3_DEFAULT_PROPERTIES;
 	ret = dwc3_core_probe(&probe_data);
 	if (ret)  {
 		ret = dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
diff --git a/drivers/usb/dwc3/glue.h b/drivers/usb/dwc3/glue.h
index 2efd00e763be4fc51911f32d43054059e61fb43a..cc6e138bd9ef2500215aba665300e7638f3d5214 100644
--- a/drivers/usb/dwc3/glue.h
+++ b/drivers/usb/dwc3/glue.h
@@ -9,17 +9,31 @@
 #include <linux/types.h>
 #include "core.h"
 
+/**
+ * dwc3_properties: DWC3 core properties
+ * @gsbuscfg0_reqinfo: Value to be programmed in the GSBUSCFG0.REQINFO field
+ */
+struct dwc3_properties {
+	u32 gsbuscfg0_reqinfo;
+};
+
+#define DWC3_DEFAULT_PROPERTIES ((struct dwc3_properties){		\
+	.gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED,	\
+	})
+
 /**
  * dwc3_probe_data: Initialization parameters passed to dwc3_core_probe()
  * @dwc: Reference to dwc3 context structure
  * @res: resource for the DWC3 core mmio region
  * @ignore_clocks_and_resets: clocks and resets defined for the device should
  *		be ignored by the DWC3 core, as they are managed by the glue
+ * @properties: dwc3 software manage properties
  */
 struct dwc3_probe_data {
 	struct dwc3 *dwc;
 	struct resource *res;
 	bool ignore_clocks_and_resets;
+	struct dwc3_properties properties;
 };
 
 int dwc3_core_probe(const struct dwc3_probe_data *data);

-- 
2.34.1


