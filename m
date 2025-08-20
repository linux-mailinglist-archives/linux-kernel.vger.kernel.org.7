Return-Path: <linux-kernel+bounces-778199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FEDB2E27E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7FE1C83402
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002F334389;
	Wed, 20 Aug 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WxHQw+qS"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC93314DD;
	Wed, 20 Aug 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707848; cv=fail; b=DrBMJUFOJXqWQo0q5pwd2szQ/UbNzC5T6LGZpASOa4hTVxqvuqg97RXmdsmAf5KpzZwZ0Ud6qrR0OKlJTxxqdp83VQUBACa+jggp7+EEFEtoHG024U8XIE0Tzl2faxvcD3qpswsLky9xtee1tCbIsM8/DPkll687QX+V0u5q+W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707848; c=relaxed/simple;
	bh=4xYyKmqOTb/zDgc2xjVS8gWxDRzXcWtGplxTIjYX8pQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hwOEd91zR4/AsxLhmFhNg9LbNdxuYj7SdwTzrBvechN0sK0/x+vL7Ql8SHX6pGZ5Vo32yX/RIlhU5zVfIq+P+ncxuIqDJ0c0P0mInSAljO9KB1ZGobm9rgLFYAFATkoPubVRkkMiQxgOEIh950+Hl3R8H535/z0yNxu9Rt7Qifo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WxHQw+qS; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4rklxLtOH3GLOFuOSV/rON1hU8KQzKjD0bKpwvxCnNask+YPzJv8ZRAVnEjpEsSuL25pyRwRBv5RCroKE3A75W8cUAEn+suZqe5IFpofADW6QfMJaSjKw2/BUsgFzrcUJgQOmxkjYfQLnfw8eZ+QRphkJSF8UntwetL22lgJCdAWcyKsAobUymJjJs4NWtNkyW6lklZFh35j5p7I6bHryO06IkJRBTGedNGI7QKvh6cXSvVyPAmGSK0v3asNwzJZlMRxhyr5As9jmGPKO7UMbxow1OFw3o8F3F6W3xOaKgVlpojw9cUh2Rnu/Qlb0PtMFfTUoXL9MGqcZyWMAsX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4fhU+1byf/RWNiESEBEV5aV/31RVbgMgsgTXpjHiY0=;
 b=xmerywXzuP0MR06Jir84yenGx4QHXsh4uy995cQw5lXcklXHqwFq9QhXrhNyFw8EOBuPFO9Ok3EZ9mm0J72vusQYF5VIN18J7Ei/CFGbxOFLKZ4GMuEzNp8rVwdAlAr80Xdue7JNkDiG/jYVJeQ8TKOkOimu6KfofPDXUcngofgEjBnID3P9ByOl0Ot9saGvSUR647qPtvU/jOOxn+XfEtEGPAvs76q9tX11gUXi6P10B6I1OWEnqd3VhW69RyujNTtx4KcMp+7uHxM+nY8bGjkPucAyYunM5rXZSZ17+G5GAD43yfCNG0FX/31NXr1tob718YUA4T7l3JyxCynWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4fhU+1byf/RWNiESEBEV5aV/31RVbgMgsgTXpjHiY0=;
 b=WxHQw+qSo5xcXWlz24ZQdqsgrwL2eUWfBJRpfi+H1c8OlhKj3RcsyS4wx6CsxNq6+l2JNJfa8wEvr7fDGWb/sgt8GCTsZsWPHiq0w9tWcEbjlWtrvyCGzsxo/i0PhwXSFDXBe4jciEBMElUHM2YNEoJXy4nXO5h1bud5maG0oSQDChx3xSdrA4Qm5mLKeLkzQz8XhWLEQab+8/IfOM5DiE8sSlFOyEyr5nlW9iagnHSra7oYOgIC8c6HgU0v9e3qhZPw92fE3Vl9z5fwuSH8oxHQjt/1b7Vh3kZQTMmvu8y0N6TU23YdZcnuS6Mbx4/efzobC6EQQMael0HwlkpqtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:37:18 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 16:37:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Aug 2025 12:36:52 -0400
Subject: [PATCH v2 2/7] ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to
 'mdio-mux@54'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-ls1021a_dts_warning-v2-2-2e39648a32b7@nxp.com>
References: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
In-Reply-To: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755707830; l=1159;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4xYyKmqOTb/zDgc2xjVS8gWxDRzXcWtGplxTIjYX8pQ=;
 b=ht/hfnGX5Gf4vPSy8V/wTfQCkmpRtdINHkaIVGmPjtScc4FPlO2X3/lOvoKnzWZa4hkrjPt+y
 wXMahK/fYWGD2RMlVEOv8bL8Np4r/7aPfRLp4tlbiEu3MlPyfwaMHo7
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
X-MS-Office365-Filtering-Correlation-Id: 26b3d06f-f1bf-492b-580f-08dde007d404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NENJS1NtZE9sNlduZUxKWmdhVVEzakFja3YvbDF1ZTB4ZkJkd3dYYlJMamZn?=
 =?utf-8?B?OFVkaUdoaDE0OTgzNlJpTjIrLzAwQ0VxL25PYk5TSk5aZ3I5dGpKTVBpVStB?=
 =?utf-8?B?OVJJenRCMUV4dEY1aGhuUU1zRGRqeWIwMGFPZEtwemdob1htYXJ4Z2MyanB1?=
 =?utf-8?B?ZjJHazgyZ0tjZTlqd0FPaTFnWm9MK3F1VzBmYUhIVEpSaFBJcXBOdmsreE5I?=
 =?utf-8?B?ZjNTZFVZd0daTVhQZDdBd1hqY05ZQ2E4LzJNZVY4ckpPYVNQallkVVoyUVdE?=
 =?utf-8?B?MUhrU2o0WW9DaUgrZERKYlNKVFJXeTY2T2ptUGp5QXY2VFVFOVhtTkdZaWZE?=
 =?utf-8?B?OStRT0NuN0tDT2gvRGNmTEdxOTgzN0J6aFRJUXVNMXg4UURVd1BoN0FkaGpn?=
 =?utf-8?B?Zk9KRjBGRnkvZ3l2NzZFM2d1ZUlJU2Y4TEFDa01tdEZWbzVhQW5BMjlrQkF6?=
 =?utf-8?B?UUVSYStEZk9KQzRzSCtUdXVnMUxJeVZBYWdPdnQ0RkZsTkRYZXNDUk96SE44?=
 =?utf-8?B?TU1MODZXVVNVTVZNZGR0clFVRG9NVDBRYmI3WWVDZWZFTE02bitUMS9tTFc5?=
 =?utf-8?B?M2pJOExoaktsajhMT0ZVQUkyRlVVMzRMM0k4dlhpYThsaHZaV3pSZ0dzVVc5?=
 =?utf-8?B?eCs3aGFiNThxZUVMaHZxT3BwNkQ5a1RKUlgvWkViYzFsOUg0NGdVRHBsVTdz?=
 =?utf-8?B?TlYrR0w4NTN3UXJVTVVyb0ZwL1Q4Y2NJZm9TY3F1SlU2Y2RmYlZ4WEdmMTNy?=
 =?utf-8?B?SHo3dXU2eEJJN3U0Z056b1Rub3dWY1JEUllIL25NVUgxZndMNXhiR2FjdkJ5?=
 =?utf-8?B?WXEvQWJqUWNrNEhpVC84WXd4ZC9uRUU2S2VjeFBQaFVCbFFNQjVjRHBscWp0?=
 =?utf-8?B?dWxHQU4yTm9FUzZ6K0hSNnNqL20yeVFmbnFldnpqT0p5RFgxUU95dkdBTS9E?=
 =?utf-8?B?bzRPNUo2VGppKzI0ZmN0S1ZsTlc5MG1hcXFVeTlRYWQ1bDFDZWg1cE5WT2E1?=
 =?utf-8?B?TTBndk1pVDlZZ3k5OExqeDEyakRHN250UWJFSUo2TXRPYjh4MUhOV3dNRU9F?=
 =?utf-8?B?NDljVXBZTlpTeWZPV0JzVk5kZm5mTTlFdVdyODlmUG9iR1BFbzFvWlRpVzVK?=
 =?utf-8?B?NGR6UzF1YW05ZEpyU1NvVXhFWFJvYzdObExoOHE5MXdPMzE2MWRCdzZackJW?=
 =?utf-8?B?c3I3RW0wY3ZDM0s4Mk1DRnJZQW0xR1ZPTVpKbEF1T3czSDVxdkR5ZHYwcENV?=
 =?utf-8?B?RldYZzB3S2FSUUJWMEhiOEoxVFRPWlF0d1dTbkR3WFpscStRM1hqR25mcFox?=
 =?utf-8?B?UVR6ZHZtQXNwSVpaQnlDYWI1S0xiQ0pCaGh5VktPT09hWUtxcTFJQzNFWGkr?=
 =?utf-8?B?MHRZRzFDNVp0WUF5WGtrZGdqUTFTY2lIKzFEd3RqSGI5MW9PV3ROOHlyMzNo?=
 =?utf-8?B?QXhybHlBUnBFT3lYeGs2TzlKREdOMDhJS2tHeWpTZkZ5dXhtZDl3TnZMelhu?=
 =?utf-8?B?SGo2SkR6RldzcmI1L3FvRzNOazlBSnFYcndJV1Rielh1YlgxZ09uLzRjVXhs?=
 =?utf-8?B?K1Bsd29uaVZQRTBRTEdRRllFMzcyUmZMUFpLZkV1MzFUMGtGZXBHb2MwNWlz?=
 =?utf-8?B?TWgwNzJFcUhLS1lWdDlhbHl2amJEVkJwdk5CTE05aXFYUE5idkRqQTcxTWN5?=
 =?utf-8?B?OFVjZUNKM3JIT2xlZU9idFN2SEY3eElpaDhqMDE3bzlyOW1LaEplenVSYUVk?=
 =?utf-8?B?clNvMWg2TnBiblBPYXl6UG14bHZhOXlUVDdZU1BWL3hnanc1L202VlZZbWRI?=
 =?utf-8?B?OVFMa3VTZzhJeW4yRkQwZkQ5NFJYL2tIZGhINzh0b0x4OUpPZ1FiMGkrS1NS?=
 =?utf-8?B?RklEWTc5MG5wL0wwSk5IYUlDUnJLUWlyKzdpKzhzRnJHd1ZpRzhVS01DTVRF?=
 =?utf-8?B?Q2Z3Sk1vR0ZYbnhGWE8xOVJBaW9mclFBZGJ5YUlIS0orak9nM01QK3lhNHVB?=
 =?utf-8?B?c3RHa216c1ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHdjTzFueUpFTnhQREtOOGR6Z25XbHRpKzFDYlJhaFVzWjROWUx6OUhwb3VK?=
 =?utf-8?B?M2dpQ1NOaFNEbFN6SUpOYkJPTG9nQ2dPcVRLY1U4YlplVFJWSllPNjBUc1h4?=
 =?utf-8?B?RjlELzRCUHI3WnprTEtiZGRqQW1ML3M4cUFXa0hGcmlrcnNWSHNIK3BDZjRU?=
 =?utf-8?B?Z1Foc0JBSzVyeGgxMVdiOWh0R1lLbTJVTmhoVlREZDA3LytpUEtjK0oya3VI?=
 =?utf-8?B?WVdrb0xQT0pVeEN6N21pT0NtbjNlOW5QT1Bzb056MC8wc2t5OUVRN01rWDBt?=
 =?utf-8?B?OTg3SHUvWThkUUU1MFZoeGdRdWovVlI3NDIvVkRvRm9kUTBhbGZJdnhndWlN?=
 =?utf-8?B?YzIvaW1MaUtOU0JJZVdYeDdNd2pRZ01wbjJURGpQZlMwUmZuUUFsV2lkQVl6?=
 =?utf-8?B?YXlrWStuVGpIaVBKUFdHdWRwSk9ySThSOXowOXZzc2xYZGxBVWhHRlk2STN2?=
 =?utf-8?B?SDd1TzlOcHUvMGd4UnRlOG0vb3Joc1dSVGVQc1FWZmEwSkZkSHVoa0NMZkE4?=
 =?utf-8?B?Y0kxUUhvVHB5d2xOVGx6K2kySytuOHV5Q3NFQllBVzl2WTJOK3hxZUJHbDRs?=
 =?utf-8?B?Q2lGeUNJSTNiNmpRaitDV3EvSXFpSDBhK3VWTHI0NzJSQmRneWVVMnErUjdO?=
 =?utf-8?B?QXpWWnQ0WUd6ZXVVS3k5UGlBSUZHVnp5RE1Zdi9SMUdxK0wzSTdQOVE3RFVm?=
 =?utf-8?B?aTRRMm41T0tZVXRjZ0psTTNlNWdPN0lDWnBHWGNkclJKbStnVTJKc2FRTXNx?=
 =?utf-8?B?Yk1FLzA0T0J2UWJQQnVIdlZ1eitQcVBiVkRpU2Z1dEN1SVJqUGxmUSswdDk0?=
 =?utf-8?B?UkN5cmxBL1d3YUN6c2g0UjZVMnBjOG5BN2lFM2ZPeHJhRjM3UUxucEVZODFw?=
 =?utf-8?B?eWVsNnhoaVR3bWNpM1dWM1BYSEFRYWRFMk50cnJJeUpCcitmZGt5dnN1L3My?=
 =?utf-8?B?aWsybXdPNnhnR0VIR1VmRHQ5aXpsY2pCeU9CbVQrVW1tdTJhUTFDTStqcVM5?=
 =?utf-8?B?TTM0N2ZyQW0vTEJhOTAveWwvWWhwM3FGZ0JPSEc4VjRRTXdUMGgrekNhdzIx?=
 =?utf-8?B?V3dPbUo1Snl1MkQ0Z2xXbUtrdW40K0VXM2FGZ3BVc3JycGNWOVJuWCtkTVEx?=
 =?utf-8?B?ZWRxYm03aUg1K2F1V2dsZ1BRY3JxY1dxMUVwTnlja0U4Z253L0ptZzZiM1dR?=
 =?utf-8?B?aEdwZk5jcWk5elBSZTlzclEvMjRTeVNBRnplcW15TncxNVgzWEgxTTcraUV4?=
 =?utf-8?B?SGM0NFZtcUw0VmliN1JGNndLRmRPMjZNaHM2L2ErZUZrOHB1Y2JxOWZVb000?=
 =?utf-8?B?WWY2dmV1QnFaSmNzZzZLeURxeHhTQ0FQNHNobHpmZGtvd1ZibXJlRmJsUnhs?=
 =?utf-8?B?aU9tVzF1dmJVaUFUSG5ZdVVxUnpSa2IvRkoybFBveXZ3UUFCWXFnNytJVFJi?=
 =?utf-8?B?a3VBSTZBdEk0WFJqV0xDNWh3RWl6dHZJZ2RMbjF6cUFPRGhjTG9rK1g1d1Vw?=
 =?utf-8?B?L2xzWjgvaXpBM1hHZ0MwUmswWTVzMUJYYVR3UGNEdWVwaHlYSThnK3ZjQThY?=
 =?utf-8?B?NHoyYmViRUZmd29tdjAyQnJOQzlaTC9lREJsNGpoRlhEcVVFd1VUbzlvYmxp?=
 =?utf-8?B?dmlqNHhsTWM5a1oxOHFOL1craGJXaTJHeDB6aFhjWlJlYkRhWXRTSm0wYWlF?=
 =?utf-8?B?aE9VT0xSa0g5eTdHZ0xoN0JxQndZdEFtb2JpekozY3pGQ1E3NDNNbWtmcHRZ?=
 =?utf-8?B?bHZ4eGsrTUJlejc0NmRZWmZIOFVHelFHQjJxaC9qMFF3WU5FTUExd1NDWHN2?=
 =?utf-8?B?NTBrM0lxNHg3Z1U0dEVlKzNhUWUzK2d0dm83bTJwRmFYK0pYdDBkZkZMMHRC?=
 =?utf-8?B?U0M2UXI0bTRheUkvemtzaFd4RUdYS3BteHhUNm9KNEZlZE9MZ3h0VG5qYVU2?=
 =?utf-8?B?Y0ZxZzZPcU16cnIwdDNwWEhtQnBza2V3MFhQVWttTGkwQjlORXFCakVpUlNX?=
 =?utf-8?B?TUlqK0wyMDYzRXUwOWdWOGpVT2NmZnJ4eTJZeDJYcE50WnY1TnY5NlNWOVJP?=
 =?utf-8?B?Z01kY3N0SzEvaUJOaDFQS2FoaStEbXpqbnFVcnMvU0lzWkJJaFcrNlJ0UFFX?=
 =?utf-8?Q?RRIVlfrgz/JCuC6amYBvlwZON?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b3d06f-f1bf-492b-580f-08dde007d404
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:37:18.5090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnmozzNueceVDUrVZf1LhMU0GXT2QZBs4HlOYnBEXMcI+krDsTvrng0Y3FNw1BZ044Vwlj8CqFEv556Hyc0czg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

Rename 'mdio-mux-emi1' to 'mdio-mux@54'.

Add fallback compatible string mdio-mux.

Fix below warning:
  arch/arm/boot/dts/nxp/ls/ls1021a-qds.dtb: memory-controller@1530000 (fsl,ifc): board-control@3,0: 'oneOf' conditional failed, one must be fixed:
        'bank-width', 'device-width', 'mdio-mux-emi1' do not match any of the regexes: '^mdio-mux@[a-f0-9,]+$', 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
index 8bc8ff2e3b03d6eeb43d79fe0555842536ab735c..a880875ced83e10c37a4d49d9b9951cd3d458ff0 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
@@ -211,8 +211,8 @@ fpga: board-control@3,0 {
 		device-width = <1>;
 		ranges = <0 3 0 0x100>;
 
-		mdio-mux-emi1 {
-			compatible = "mdio-mux-mmioreg";
+		mdio-mux@54 {
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
 			mdio-parent-bus = <&mdio0>;
 			#address-cells = <1>;
 			#size-cells = <0>;

-- 
2.34.1


