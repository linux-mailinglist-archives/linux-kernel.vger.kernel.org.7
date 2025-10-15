Return-Path: <linux-kernel+bounces-854910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF6BDFBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2227501522
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE033A003;
	Wed, 15 Oct 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/v350UH"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665633CE9E;
	Wed, 15 Oct 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546713; cv=fail; b=rX8FumJk01WdLEzbNsqVQ62o3JuPKHPCgtKqksl51CPiNkx5CH/HzMmKWPe7kS57Bu+DezzLuknl5vzk0OAPqEdzR7txR3LyB4pnL12+AeTP7QBb7rdqYpMYozOcEQw4cany5vgFHYtjoEoWH+V8Upp8qZ6G6KFjAkzIL+sE6UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546713; c=relaxed/simple;
	bh=viq9nA3ofPon+PpRpfguphppP+TdNUaxHYTA6iGn7js=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GkwzDAp9lJupCbESLsKtIGNSdX0qCyiUQXTKndhOl9g9ckufcnrqQYayePvkYId7EMNCY77gjhcDUe3DMd3UdAhcrER8hi+L5R0U4luOENl3jYwX8Pp/WexQPxUa8GNM4w4Tm+KDHONlbimO0P8QkdjgF2mD2O2thGVPxwcEWzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g/v350UH; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icv1Y7+n8/I3u2z5UWbtSozw8JfAXGZFjWXpU+t530ElN6TJ0T8QNZXy7MhabEnRpH3MZVKErM26VGWJXRztZ4TRgVHrHmaCtI4+5SCd/ZoORWdBNfu/LEaHHuKfbW3QRm6J0CC/T3O7hUnPdcc22sRH3BDPWgh80EZLn7QcnKDx9bDSQyzXSSWc+vUzL5gFg4D5HRnA5Y/hyXY/F6wiWHWSJwOJgjSsV8mdcMUA88IUWZwB74AkzFvB1s0tal0c817oYRWU650CpNDoYN8k2/zFuLl+IRqMwawA13yNrtX6NZD24dPWkSfenbIP5OFdMgBIT4bG3rfgGrrgrWwL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5wfxwSym9BIlN2iOAgSRDT9iY0bTwuht62/LkUbdF0=;
 b=ya3svRgVm+mFxN1znBMktAgzLuAl/fkcE+qevcX1f2kCSyd+C6iwOTd9wrDzHoWthSLUJj73ENOwn7mxkcagb9ZiSqHb60tK7CgHYXzSTdTUqfyjs1W0eCErlkekYUyMqlvGBt9iTtSqhkfASpwtAXYxyQVCwaPXzh1YI+ZE2fvigoLn+EsjW+wUpcnmoDTX/WUIWhK61Yg/P8MOuvCsvs+n/XCAFOt1g5a8lNVsWhk3hgCud6bPJbgZVD25B3cF8NDdJhfHhls5qKjkgRlDeJ5kJrUwuam+OZwY1n3PyoGV3pGyaWGTy3j1LcTlUa/K5GWwyinkc6fb6v0+JHbAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5wfxwSym9BIlN2iOAgSRDT9iY0bTwuht62/LkUbdF0=;
 b=g/v350UHDQfqet7YvlxcRvyzV4zCmk8aVNjMrz4sA1+bYfJRcikAqQUpK0Y0E+TecZomq1B6m1DI5wvioJZ0bdykXFgzM1c8bWBwPXGj7LG8jprmhKuwsGVFmXyUzKHE/0UWXUz3PnhdsFze9nBATbKJErE6xffEPz/upOAvgIQWOk48/6X33Xz7FD9w9YUM/zi4y3mEiyKom2cRAip05BMk05cDmztmFtfEpb3UooYgTdbDxL8w7QCCQGEbi615lz4pQP4l3qBBjd3RdApBW1S5C8VonY7faYvSpo2lOVCcZ4vOnT4u1rvqZnpET0htyqIKe7H+17fbM03sER71kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:45:04 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:45:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:31 -0400
Subject: [PATCH v2 06/11] ARM: dts: imx6: change voltage-divider's
 io-channel-cells to 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-6-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=2194;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=viq9nA3ofPon+PpRpfguphppP+TdNUaxHYTA6iGn7js=;
 b=ayZvlQpf2oJNds5Ir1FXu4XQHCoT8nxvZBW6IQmIzTLG0BQb+9+E9ZjNsqnNgTyUVlXSYh2gI
 7nFUM7prP/gAHMsnNEJWrL1ugYFOn+ei/Uz3by7CnJLUw0tFO3HEOh1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb5b2e5-5b84-4b7c-370f-08de0c0a30cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTBCMEwrRlZibVlVUE11czl1VjdPNHBCYXdJOVlDOUx4c0JPOVhMdDdhN29a?=
 =?utf-8?B?UXdHZndNM3dPNXBOM1NtMW9ibjFvWVU1SmJGWE8ySGRIL29KU0o2andLMFNj?=
 =?utf-8?B?WjU3UEFRM2ZqaUlyL09xMm5xcGo2RTkxOVdFYzkwZVJnUis5a1dyRkZqU3pt?=
 =?utf-8?B?VjhLZDVEc0Q4VUZQUzMralhSVTRhNllidk9kZ1BGbE1SV1kxMC9Yc2NuZDNp?=
 =?utf-8?B?NzNlNXUrN1laS3h3ZmFWVWRGMXB6ZlFGRUlNVEZZc1c0U2pVM25uZjJEUmd3?=
 =?utf-8?B?WFNzdC9FSmp1SjkyUXloZHBybjFRUGVoNEUvQkxWU1VPamRNTWtKZmdTaUti?=
 =?utf-8?B?eFJnS1lCMlViUWtTbXdxN2UybXZkRXE3cHk2UE5aSXpudkRVUkFVNkJ6L3Er?=
 =?utf-8?B?WUdWRXpJT2t2Qm42a1BmRHh1MEVFM3BndmRzb1BLWjhzZ0pIbFN0Myt3UUtj?=
 =?utf-8?B?S3VLUnUrWXNGOVpxZlZGMW9BdTdubFpuTmJFcVZVbFc5Y2ZlMGwzQUtRdEJj?=
 =?utf-8?B?NSt4dmY2dEFRNk00TFBhZHVIVTN0MFExK1NrQ3o2MDZIT1ZnQzRlcHNQbTVD?=
 =?utf-8?B?RTc3ZFBPeWF5bU81Ylp5MW5PaWpqNDd1aTRjNDBiQlFHQkY1cXlYNUI4Ullj?=
 =?utf-8?B?QXJyWlpudWh2d2MzcXAwNm00L0F3U29xdis0ajBVZXM0U01pV0RHRVREcTBy?=
 =?utf-8?B?cUh6VHJrbDJIWGVrOWRaRUJRU1R4M3pHMDVwSEhxcDBVcS9NTi9yWW1TSnAz?=
 =?utf-8?B?TnVWR3ZML2VPTEkzQkhTV1Q0U1RZamlZMGo3aFU5c1BNNk9CTnZBVmFlUDJq?=
 =?utf-8?B?ZkxVUmRLSzhkTHNIV0ozb09XN01aVU03eU0zUlRMYWNNRXd6bXBRWk1waVla?=
 =?utf-8?B?OGk5bm1Jeno0Mm9PK25yeGVuRVp0S1BLME9kZUNDUE1Jcm95Sk0vRHBQMHpi?=
 =?utf-8?B?L1dhdmhobUcxRHNZQW9xVVdLWk9yYW9xeTgrbkxsczV4Y1I1ZHNTdVl5TVR4?=
 =?utf-8?B?alFpMVBiMjNNWHBKYnk2QnlxRGRJZ0RFUUx1WU1OUFp0Ylk5QkxLOXh6bzF3?=
 =?utf-8?B?SXRCcjV6T29yTkFZckxWZVQvZE00b25Md1lveVJCTVdtWW5XMDVxaDBuUlJi?=
 =?utf-8?B?WDJTMHBFdDNvbm1TTWt5S2ZqVkk2akRrRnU0WkhMYWtBY1ljL2kzNE5vU3Rl?=
 =?utf-8?B?aWdXNHlvanFXUFNTQkFvV2lxeUE1azBUYlhLYXgzUkl3UVcvdEZid2lkMFRo?=
 =?utf-8?B?Ulo2MXdGQTRhYzRNWVpOL3pPMGFNRm5xUWdXNjkzOG9qNGhxS3doRDFYeE1r?=
 =?utf-8?B?Z1g3b1NVTVU0U1VGSis4K1YyVHpPV1NSWjFhcXR2OHVLWXR4MTg4SDltdmZP?=
 =?utf-8?B?OGJYZ3B3S2c2S0ZYaTE4R0xGK0dPaGx0MGlvKzB5TDl5OEViVVpSZW8waHNY?=
 =?utf-8?B?K3I3UmhBQzdGV1NOM0NFV25wZzNsVGxsR1F6eWFyS0RWbCtxamJ0c1orOU84?=
 =?utf-8?B?Mm56SDRRTlhRWDMvM25DU0J0VVVsVTkwTXVBOEIwRXFhc2hGc3MrcDZLVUd1?=
 =?utf-8?B?MW9iSXNQTmUxQmFKSVYxZzdTakxsTEhYQWJyUkE4eEphZmFyeDVvaFNHUFdP?=
 =?utf-8?B?dW10WkpxNUgvRGRyUTY1WW42L09tZTgzRUplQ3RrY0k4RktPNjdURVExdkcv?=
 =?utf-8?B?eUxPTUdrbU40QjQ5OFU2Ylg0YXEzdjdhZDJBcFV4b2J5N0o3U1B1TytPL2d4?=
 =?utf-8?B?THh6NGgwenNZTVBaV2RaelJmQ1k3REdZU0g1a2NrazRHRGUrbXYyRkxQYnEv?=
 =?utf-8?B?RGlVTHozY1UyMDFxMnc1dHBTaGFYRUdJdzFuSUJWSnFlY2tvdVpjSmdCU21M?=
 =?utf-8?B?TmdGODJmcDhVQlhma2JjaHluKzRRSmJUL1pCZ2JDMi8zVGltOXlFL2VSaFR2?=
 =?utf-8?B?WWZRSXV0eXFPNFBvSERsVHZ6VzBuN3MxVmJ5MlhQYlB2V1ZoeFJsZ2JnbjlI?=
 =?utf-8?B?SlFNc2RNbytBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2srUXJZOUVIa1VMUGhrV29Kc3BPQWlKeGR3T0lSa1d6UnB4MHhRWHJNN2Z4?=
 =?utf-8?B?ZkJLdFN0cVNQc3llU29JQ3pISWZJQ1BhejA3SG9sbXkzNDcrb1FLOXlFOVJn?=
 =?utf-8?B?N0E5UzFyRkp5SnJBS2VIZWttdnJOWjlCWG5QNWVaTUc3ZEJNNDdDMFFzeXNP?=
 =?utf-8?B?MlZNaUpUcmpnbVJqUHZzeVMzZFRXK0tBeVdtT2gwakdibmEwaERYUWp5dFdT?=
 =?utf-8?B?eTEvdnlELzlUZFVSMTNRSEhCOXFPdHlBeTJMc1phZncxek8zekR0cVkyMkhM?=
 =?utf-8?B?VzdkblZkdUFVdTc0WUpNMkZqMytRSHAzY2FNci9Jd1poTlp3RCsrdDVFb1M4?=
 =?utf-8?B?VitZQzlvS29XNThkT0ppUE1vT1lScGVkRE5IRnRFbjYyOE5hN3RrV3djcEF1?=
 =?utf-8?B?b1ZJUUYxcHBtREdtZG5TdjZHOXdPNHh3K3RMTVNBVCtTSldRSk04a1pTK2hX?=
 =?utf-8?B?V3JKemdUMGNMaEw3U0xCUTFzZmdibUhham45WDlXZDk4V1FPV3E4NnBHb0h2?=
 =?utf-8?B?TnE1RGlUTmx2Ukx0RXdwV0U5L1h5VytFa2V3MnpHc0t6UXc0SDBEUG1YaEgy?=
 =?utf-8?B?d1phemhvc1ZBaG1nQmFVWmE1QkkxQk0zeHY5cVd0cHd1aFpMYjNpUm1JRnFV?=
 =?utf-8?B?KzMwZ3FpZjhWaXhLQnZzMFNNL1E5MGRKWWV4TklJdGpFWkM5N0VIMzVha1d2?=
 =?utf-8?B?bk10Nk5mNXdKRm9ROXBQTHIxUGpHWWh6bVBhZTdsWjRucS81VU9nOENhL29E?=
 =?utf-8?B?Um5nT1FSWk45SnRpa0x4M2kraExXYW5nbVY1TTllTU9kRHJQWjNQSHBQemJW?=
 =?utf-8?B?b1NLbVJjQ2dxTjZmSThvWHRJSTNPUk9wVU4rQWc2RUhvaFFySW05UEd3SE5E?=
 =?utf-8?B?UUY5cWI4clpOVks5SUw3TnhMTHBhOUpMT3dBODdYc21LWG1lTmZZYkh5Z2Jp?=
 =?utf-8?B?RU4yNi8yaktnbXhIeEd0TjhSZGZyYXNQYnpPOFpLQ2t5TExoMTllMUFnb2dm?=
 =?utf-8?B?aDE3OUd1U01aMUlFZTdybHROYnBSdGhvMnUvR0k5V3MybThUcjBiVzY2NmhD?=
 =?utf-8?B?SWtCMHJaRzEyeThlZE9RVUlWL1l0SlVwcUFZbXhUdGhZTTN1Y1JxeEtNMStj?=
 =?utf-8?B?NUlvNlBKR3FUeWxucDV1dk90R09FUjlMTGNxVTV5MTJlaG4vZ3hySHM4NC9O?=
 =?utf-8?B?VTAxRVczK0FnOFd2aFZTNHBQamJUcWIzS2c2YjJPMGxzZTlCWStnQ2M1bWVM?=
 =?utf-8?B?cElRRnVzblMza2hlYTROQkt1Q05nWGc1QTdpSEpISzBhcHhkaS9XaklkTmxa?=
 =?utf-8?B?WURZcEdISTBMKzlDM2Q4REk2anlZQVBKNVdjYytScUZROGRZa1R2TkpBUnV1?=
 =?utf-8?B?YSt0eXQ4ZjZPNHcrd0RISDlKY1dTMi9lTmFybUFlSlQ0cGdRU0FZb25IcnJn?=
 =?utf-8?B?Yk8zdnR5aUhsUXVGWTN3YmFYUkZXWUljamQ1WTVod0ZNdkNkdWs2eVdQWkRO?=
 =?utf-8?B?d2VhTXYzR1UwWGxKQnJtakJRTnlJRWRDNUF2WEJ0TlZoSjdFOXlndGxGY1Br?=
 =?utf-8?B?aXdpVVJiWVZLSGhSck9PQ2ZPelJ3ZU9INEhkRkhNNEdGaWVYSFYyMU0zMzFn?=
 =?utf-8?B?T3cxakxNbW5scmZtSEl1MUZHTGNBbHl3dmJRTWFZUGNpdGJqajZYM0ZpYWtR?=
 =?utf-8?B?aGJMN0ZiSk0rWSt3T2lEOWJkNTlkRnk4Ym9KSUFQNGpvOWJ6ZHhDVDBURkFI?=
 =?utf-8?B?Z0R1dkZkUERUOUtoZjlaMFlhd28rZ2JnVVVLblZ2eXp6bnQzNWFYOUF5MUxs?=
 =?utf-8?B?NndFaHpIL1dVUlNqVVhzdDdiYkx1aSttUFZQNDFoYjRjeHA1TGFRSEhXQ1hu?=
 =?utf-8?B?aTFSeFJQS1RvOEJGUWZrNHNsS3JBWk9EeDNZdVhvUHNJT1o2dWdFd0R4bkZi?=
 =?utf-8?B?Tzh6dUtrOC9udmRHRG1SZURISmJBRkVHdGZ2SWtaTThicGN2SzBjVGU0bEkv?=
 =?utf-8?B?NlZwZWxJTERWTjFqcmZqWDRvZXBralpkMEQySmoxaEpWODdTajhxeG1Ub3p5?=
 =?utf-8?B?elRnbVFQUHpoczZYUHNac1pNb1RBS3l0TlFHd3FTQlBGZUVDcDFyYkVqN0VL?=
 =?utf-8?Q?Kls8gwLtMLAD2bUSj+7H7gH1i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb5b2e5-5b84-4b7c-370f-08de0c0a30cb
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:45:04.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoF9p2G2gvlPbV4JOl6u0nQy/vbDzNlDC9gKykU2fV/tpv4jbilOpe71jWJ0+bo5UIYueQk8CwmJxAb8w9Y9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Change voltage-divider's io-channel-cells to 1 to fix below CHECK_DTBS
warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dtb: voltage-divider-vaccu (voltage-divider): #io-channel-cells: 1 was expected
        from schema $id: http://devicetree.org/schemas/iio/afe/voltage-divider.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
index c9dc48c1f9b1c36e33a55c64b9fa64262f011f8e..353f7097cb7e0256c7c89a36cb7568f229370f4b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
@@ -55,7 +55,7 @@ display_out: endpoint {
 
 	iio-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&vdiv_vaccu>;
+		io-channels = <&vdiv_vaccu 0>;
 	};
 
 	keys {
@@ -318,7 +318,7 @@ vdiv_vaccu: voltage-divider-vaccu {
 		io-channels = <&adc_ts 2>;
 		output-ohms = <2500>;
 		full-ohms = <64000>;
-		#io-channel-cells = <0>;
+		#io-channel-cells = <1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
index e258e7b3b3fe792d061002a6b70bef4b22c5e89e..76b0007d20ad22eee738ab40ed126435a8fd17fd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
@@ -35,7 +35,7 @@ key-enter {
 
 	iio-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&vdiv_vaccu>, <&vdiv_hitch_pos>;
+		io-channels = <&vdiv_vaccu 0>, <&vdiv_hitch_pos 0>;
 	};
 
 	panel {
@@ -147,7 +147,7 @@ vdiv_vaccu: voltage-divider-vaccu {
 		io-channels = <&adc_ts 2>;
 		output-ohms = <2500>;
 		full-ohms = <64000>;
-		#io-channel-cells = <0>;
+		#io-channel-cells = <1>;
 	};
 
 	vdiv_hitch_pos: voltage-divider-hitch-pos {
@@ -155,7 +155,7 @@ vdiv_hitch_pos: voltage-divider-hitch-pos {
 		io-channels = <&adc_ts 6>;
 		output-ohms = <3300>;
 		full-ohms = <13300>;
-		#io-channel-cells = <0>;
+		#io-channel-cells = <1>;
 	};
 };
 

-- 
2.34.1


