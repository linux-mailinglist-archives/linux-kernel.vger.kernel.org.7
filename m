Return-Path: <linux-kernel+bounces-878522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C68C20E02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300A33B2035
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1FD364482;
	Thu, 30 Oct 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QKM6LX+H";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QKM6LX+H"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020077.outbound.protection.outlook.com [52.101.84.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC812363BA5;
	Thu, 30 Oct 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.77
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837420; cv=fail; b=Hq0rXQri6KTrfnoPF8rJl25ixwXLjIlXG3jdMUKB0biyt8PM4jctMD2LqOuaXLjZ4k2SSCDxpeW4FBR3fBcqY5nTWHEKGwDDJzg7S5yfRkGEmWETTBnPIy5044GbSZc/RYXNXrwEW469ojC/lfAM0vMEfvk/p3d0cRnpX0vvS2M=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837420; c=relaxed/simple;
	bh=/pIVTPUJx0TEbHZfOs1xtZcI+ZjvZ5E9Cjh1jLjdOi0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dmVrwue1UaQ2FzMi30WW56ZY5LswKhTdHJ1NJaXlhKXnLGqKUCEHSrPWut+cD+yqDFv+F4XJoqEth+onfoEn0yfw3g3wZVv0ZD3ER7VMoD7Ozn7j5eDuLOxsm7gV4Weo4F/zsNNNF5AhHtGZkAW3fhhMVL43TTPBE5TUGnKul3A=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QKM6LX+H; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QKM6LX+H; arc=fail smtp.client-ip=52.101.84.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JCuSuxrLEo8brUeuCGRzcfRC/GkeZCy1TcstTZs0xOkSP1nZx2ocDe7AtVE56E9ojgSSKKjLHp2HfBJKxPAyPYkAeqUVLTDp18D58pSQ3KYM2EdgZmiu8G96zkV/rdWDooj8uA/nyoPSq6VSnMSxtQmJhaTT3UoNSueUvRSlxz9J5Z+B/sBj3nfmfhmHEBAAo7t+NFIY61Ls+9n/BY1G6gGROyCNGT5B1R70o+AYwJEpIf7OhLdmKqj21IA++icozcAVblsV2q9LbwSXon11NC/k/t1FYY1YJpjZAXrijNqitUGgfGla0gfbsWE5wFO2BMzbMzGoMF08D0byOyjmNg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtjfknpPNSaok5wFwFlBjJjcBSiEdLAVvMEVK1K+5WY=;
 b=PRhVMHXHiFnG5uAdfLG+fgJQMgaoH+gMBhszQv13YRaq0g0aBib8o2YnpArUV2TbIDnRcorpXTJBo8nP1cauCN69i15GytwSWH1IoEi6jhjZ5gO0G6bmaJffVCSqsZD6MvpXzLXoHB1XKxG4is/+6IhKxzzXF0p0avBFn1Ty/94aHpghdj9ngs2C4eEmxQam1FszfeSPuS95+J8ImKtXGq5IMe+X9UknKAAY54ujwFQk+8Rkeszdvt/+83ypPe4syiFPGQJuTQsRHOBFtCywChsHLQbW6H1pw48YIKFA3Qzej8A2+PlPcvRFOw/ZqNyLt75Bt7whIn7GknHjqegcIg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtjfknpPNSaok5wFwFlBjJjcBSiEdLAVvMEVK1K+5WY=;
 b=QKM6LX+HPabHVG70A3u62Vk+yrTFTaLtSizFguGwmEeHqMH5koIp7ZTtwhSyLHF4rjTklGNzDTxo5Qrz1NBhq0UcChBYkX2dpzrRq4/ycFQt0D82UBncDmrwrSak+8+zwKXxo+3gibuLelnZ8u4Z3dFXN5HfEmqOuFv/DgGquSw=
Received: from AS4P195CA0049.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::25)
 by DU4PR04MB10936.eurprd04.prod.outlook.com (2603:10a6:10:588::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 15:16:55 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::3f) by AS4P195CA0049.outlook.office365.com
 (2603:10a6:20b:65a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 15:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 15:16:54 +0000
Received: from emails-5429912-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-121.eu-west-1.compute.internal [10.20.5.121])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 64E50806A9;
	Thu, 30 Oct 2025 15:16:54 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1761837414; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=wtjfknpPNSaok5wFwFlBjJjcBSiEdLAVvMEVK1K+5WY=;
 b=DXCkHtUsYL94Et4F292tPh/QvDHl2zsrsB2aVfWWs/+kz8xXoaLgG2HqK2UETl9W6GYDZ
 wQk7HMR8AA5f551IVo8MrKh68rrh6JmFcKHRBuzx426wJmu/yqlHM3i/sxy1CU4BAfJSPBS
 1jNOJ3yWJwk/T3Tl1LgVXvUYDku0YcY=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1761837414;
 b=Vyft0KZTPbjJEiijBvv35HALYYvzIYC011mwn03NCcP8zmLmCtSTG6IIu+GX6PW/EnlJN
 jadfEg59kFdWyDbnrnj8tUoRCoLwH6d2Tj+hsQPv8ub/JSGUis3TfIyI0npsJdTWq8c3te3
 n92sIv3f+/Do27i4O/eZQiPH1XsDbew=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ata5lMc6x5fHZAoSywdc9ZLIM2BsU0cuDMgEo2VtrJCpYtitjRLzpbFk5pFIpjuVYk72HLDCdfTm54HPc6pJiPK5LqiaLzx7cvIFzK45WH+f8CiylU0sJyk+mCGQHS0ML2EsDh0bXumUQ+APbBhdCj2c5E5pbDlQ6lTsjg+NimifktlqnM9tFaTsKgQkzECW4cXWSCv/EU1cD/+FEPni7bn0ZadfqcY9DHucc18KzuaPUsSUh2Nl3N1vZB0dyP0lpZmC61TIo4Gl9anmHC15JzHIVT+QzSoCKPFAyEGZA0EuWE9hj9FfxFb5DgQOwes3RvN3DyHcb3S5nj9k7DZo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtjfknpPNSaok5wFwFlBjJjcBSiEdLAVvMEVK1K+5WY=;
 b=Wy7iSbnbvUbPIRZfOYDYQ2zXNGmVpmtY1kE+0yVMgGy9quoAvk2U4bpN+GGvzFbv90uu5k5rWR3wVDvtUUhlJMx0uh1LhXid89JSqqqAe2pm9SIrKeTb3UutEeXFdSxmbgIQ3ezteVcDcM1QPs29tszdjsDayPHL0tPg4OI/kL8T2ei3hOPMcHMrcPTIsNFPPIDtcmciDOgvYNqfpn40NTGOcQ8pAR99GRx+KIoRUtBAD3m6AvyWdu7DewDLyjTWxBW/Z9vDI8TQAvItAYcxy19utrrJs3qcoYGdXATmJCRSBJNqgWg/8Y8dXwF5hw4q1sqdo7lcXdxOkRlMstsbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtjfknpPNSaok5wFwFlBjJjcBSiEdLAVvMEVK1K+5WY=;
 b=QKM6LX+HPabHVG70A3u62Vk+yrTFTaLtSizFguGwmEeHqMH5koIp7ZTtwhSyLHF4rjTklGNzDTxo5Qrz1NBhq0UcChBYkX2dpzrRq4/ycFQt0D82UBncDmrwrSak+8+zwKXxo+3gibuLelnZ8u4Z3dFXN5HfEmqOuFv/DgGquSw=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 15:16:36 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 15:16:36 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 30 Oct 2025 16:16:26 +0100
Subject: [PATCH 2/2] clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10,
 pcie_x11 & pcie_x4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-cn913x-pci-clk-v1-2-e034d5903df1@solid-run.com>
References: <20251030-cn913x-pci-clk-v1-0-e034d5903df1@solid-run.com>
In-Reply-To: <20251030-cn913x-pci-clk-v1-0-e034d5903df1@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB9280:EE_|AM3PEPF0000A79A:EE_|DU4PR04MB10936:EE_
X-MS-Office365-Filtering-Correlation-Id: 13487754-d122-42e9-959e-08de17c75c4a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?STBodFphZ1VyMEo3YXpDTGY3WnJXSWxJREcvNVNEd3BHb2lEYlBXc2lmL2V3?=
 =?utf-8?B?MGlIby9wcFF6QzZaa0ZxV2c3VnpuMWhLcGZHNG95VHcwZ1JhVlp4TGx6YnBn?=
 =?utf-8?B?NGdQbHVSWHZ5SzJaZ0RBRE5QbE1Vc3ZGdjlsb3RlZ2wvN0swbDdMOGpDb0xj?=
 =?utf-8?B?b1JpN3hHM1BVb21oK1hncFBLQjYxd3QyeG9wRy8ybFZlS21WL21XYkw2M3R0?=
 =?utf-8?B?cjhTUkFROEIvQzJ6dllvcHV3UHdPV0Z2UVBkbnBqL1E0YkVRb1k0LzVNK0FW?=
 =?utf-8?B?aFBmWUNUYS9abVJ4T09VdXczeC94YzB4cW12TnZRMGZQci8rVFB6Nll0dkts?=
 =?utf-8?B?OGZMcU5TNzE5QnR6WmRjWDVYeGVqMm9RaGxSZDFJbVVNNi9QVERpaEEvQkc3?=
 =?utf-8?B?U05aOUtoWUtUZnBjMUd6UUVJUEdseDdlbVhrRkNQYTlWQWpPWEN0cVBMcExj?=
 =?utf-8?B?YVpNZGJRay9GV2cvMlZKd1VhSVFBUys4VzdiRExVZXFVNnVwV2F2VnJQdXU5?=
 =?utf-8?B?S3k4T0pkWHpaRUprV2IxRVk4OTc4SWdWclR6U0RjcU4vWDQwbDlDN3I5Uzlr?=
 =?utf-8?B?dW84N0RaUk1rU1V0Z1ozS3lTam1uY0U3QWN2ZzVHN3VmT0FKWHpqWnhLTXRN?=
 =?utf-8?B?VFE4RXo0Mm9WVmNuMkJzeVY3UW9KR0lnK2sxVUkvMHQ2T0lZT0lEellQTlBH?=
 =?utf-8?B?VnI3bGxtRU1PbGM5YUUxWkZqRDRjRktpbTV1bE4wa244UWxnYmw4OVVKQlhB?=
 =?utf-8?B?TTZTSU1Ib2pNR3FZVy9ncllWWGRUNndoTDFwbmFhVkl4TXlSNnpyUkNUZk5N?=
 =?utf-8?B?T0NRaDdacEhYeXhDcUVmSllhSnNLMVMzNUsxWUNhKzJpQ1hpVzN3ZDVwcEMw?=
 =?utf-8?B?ODVxQTFyMEtYSlFPUjlKdWw1eHdnTDVlTG05UDhab1NKU3VxKzlyY3ZMRlJJ?=
 =?utf-8?B?MEFZSXRZOTd0c2R5bmJaVEt4RVFjZ1dZUUpmaFVINDBpWXNlWjl0bHpEcFp5?=
 =?utf-8?B?bkZwVy9HVWlFU3pXR21pOWs4S2NZZnlHT2MzcVBIRjZkNnNmODQydWV5ckxQ?=
 =?utf-8?B?U1hOMnhSc3hkSk9hNUNSZlM0UXdhNkFNTmN5WHlCUTllUjNvL24xaytERFhL?=
 =?utf-8?B?eExSYjdHZytKcG01R3d0M0V0VXFCL1haVmdTZTRsT0h4dXhwcmo0eFBvblRh?=
 =?utf-8?B?OUQyaWJDQnpUaWNIK0t3MElxWkNZVksxeHN4QjVTL3hhY2lmcy83bGxhejEy?=
 =?utf-8?B?VHZsSFVpVEI4cGluU294TlFycXhmRUVta1htM3F1aUZLVXdaY2l2a1VJVkZU?=
 =?utf-8?B?T1JjMU4vL1FCVGVPcjNhSVdhSjRiRHRGNUY5Q3lEcGdvcVJHSTVsL0hrcXlM?=
 =?utf-8?B?WDY5bklUT3JyWVNreUpybGlsaFpDVnNKUFJrRm1CTEZneHNhc0ZRZHh1ZzY3?=
 =?utf-8?B?K2FMd29wbkpwSkxMOEordjhtMUhjR3ZJYlJyU1pLUnpjQVMvR2ppcVg3MnZL?=
 =?utf-8?B?MUZyWUl0eVFiSE5ZU1dFN05oVmNyNDc3QzBUVTFJSXQwWWlrb0YzWEIrWUF2?=
 =?utf-8?B?UmdPMDVzNkpZZVZHNFlnaktqMnlrRGkwSDEwNDhzb3oyMys1RWdaVThybllM?=
 =?utf-8?B?Z1lhSkpPM2NDMkpqdTlhMHZSdytpZGNVa01pS1gvYVllVE85WE1OWnJYT3JX?=
 =?utf-8?B?K1BtZHd2NGtweVdhQ2EzTjV2QlNPRks3NmdZSnNSTG10WFo4WFdJVHNqak9k?=
 =?utf-8?B?bFloWlAzZytEYmJVajRFRUhwRnF6ZzlMS3IzVEw1NFB6R3l0bmFtZDBudVp1?=
 =?utf-8?B?S2d2dldVS3pzNytOaTMyTjhpb3dXWjdQcmZjYWJpZjlVQXZ5T0pYeGhER1F6?=
 =?utf-8?B?MUxUakVTK3NuL3FvS2ZlTHc2QzUrbU9VVDQwOHU5NDU0bk1BTWdwSWROcUNS?=
 =?utf-8?B?OEtGalZiZWpPVVpUK0gyWk1oMWpVZ3pyWGR2SSt6TDVmdW9XT1NCd2s3TTVS?=
 =?utf-8?B?UVIxYS9oUytXbTVSOTUvTmxjekgvVWZucWltcHUrS0MvR1BzUVhtU2paODhI?=
 =?utf-8?Q?UfJr0B?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: bf89601d455d4a95b99c2f4dc3288566:solidrun,office365_emails,sent,inline:4dfface508d283f6e9253e75a0eee328
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	374a8caa-0c34-4409-976f-08de17c75117
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|14060799003|1800799024|82310400026|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW92eHBrL3VaVWhjdkJuczNKOS9FTFpBUzJsZGZsWUUyQUJnc1AzNHNlZE1O?=
 =?utf-8?B?dWZ6ZFEwcVVGaXFQT25pNjNQRlBFall4SDhJTWE1NVNVenNuZ1dKSzJ3eXU1?=
 =?utf-8?B?OXFsaTZ1S3lLWW11TEJSbjlQVkVVUXZJQld2Rk40MDAyYkdXQVROVElGcFNC?=
 =?utf-8?B?QitxaDlONGlmUDVXTzlSckRNOXJwMW5zV1VNclVlVVk1dDNPOG9tNnkwSWlu?=
 =?utf-8?B?ZXRwbk9PN0JWaW9GYkFyR2lGaVlXcFNiZ3Z4bEF3dTdXNmJybDB0WVBOVk5p?=
 =?utf-8?B?cndHTmVDVjdoMWMxZmpTTTFkRTR6SUlpd2I4QjQ1ZkN0SncySFNlVjV1TzMx?=
 =?utf-8?B?UE0zRGtHWUNYZDUrQTZLNExRSUUvTHFZNEtqdW5vNmVWRVJVbExES3FVcnUw?=
 =?utf-8?B?YmQ3K2NMNndkaXpKQ0RlbEpUKzdHc005YkxXZ0NVR3JEQ2Q3S0lvY1E5V2gw?=
 =?utf-8?B?ZnBYVTBxd1JOY20xbFZDVndlTnBaaTV1VnM1bnlwSmNyT2QrNDkxTGd0RUdm?=
 =?utf-8?B?Mmk2TmZYVDI4cmxIcDhPSDJFeUFzWDZURno1Q2I5cWdneDQ1VEFkbVJwb0pN?=
 =?utf-8?B?bndxeHUwNGJrRjRYem50L0FsVVY4eHdPOTViWlBPQU42WFp4WlhFa1Q4dkxo?=
 =?utf-8?B?UXF5MlE3cUxWS0VGRThxbk9ESzBVVG1YajBwTC9IMElRbVZxMnl6RHViallK?=
 =?utf-8?B?aHJvM3BxRVZFN2F2Q2RsbGorcG04NXQram9xbmlaY3Y0cWtjVVBBaFZMUmtP?=
 =?utf-8?B?ejBhcEcvcWtQWHdUZnoyblhZSHAyVTV2VGhPVWFOaGdUZGd1TmIySGxyMnlx?=
 =?utf-8?B?TkQ4MXpGMTVJT1RhZC9sL0VXbTZSZ05wZEp3UnpBV1BGWUhCMW50Rzk5ZUdG?=
 =?utf-8?B?QTAzWjZ5bHR6aUZqRDNtd3ljNkdaSGdwQnhoVk1nckpGeTRwVkxYVmFmWjht?=
 =?utf-8?B?amxGVnlZaG92T0dtVEthektIWFkrL1c3SVQ3aWVDdjhkZzVJMWxTWWhEVXk0?=
 =?utf-8?B?MGVzM29uYXR6bWNGU0p6YkJ5elZWUFRnWHVMQ0ZVaVU5a3JqT2RrY3hidGRT?=
 =?utf-8?B?Sk1zYU0vcml2c1ZFdEw4S095eGpZZ0ZsZGwvYVU1Q2kwTEd4a2FaVFdzK0E0?=
 =?utf-8?B?YlR2VHRWR21weVFrbGFsZ3ROblZDb0k0Z0p1WUFhSFB5aUo5SWFKbk55UVF2?=
 =?utf-8?B?OHRpSS9YZnVwMktJbm1FcXZjc0hkSlhxNWZmaHA0Vm01dWh3QWVVbk5Rbjg0?=
 =?utf-8?B?UHNselI2MUU5VGFqclJxd0cxMk1CYTZVOXBIakljUkZrVHgzQjBNZ0t5Snk1?=
 =?utf-8?B?YXhXd2tLVXZjTmcvbHZRcGVGVUVVZjJxcTJkZHpBZ2pEQzRIUHNLbWhKbkow?=
 =?utf-8?B?dkw5L2RTbGdXM1VOb0FjVGhMNWs3Ni9hTFJnR2M1YWE1cFhmbWtZREFrZmIr?=
 =?utf-8?B?MHlydkppM3RNbnltZFJWbkNZc2R2cTNldnhUUlcyQll2b1ltaWhobXdOM0Rp?=
 =?utf-8?B?Rm1nT0crcmZsSUQ2b1pwN2lIRkxXNlArRXozS09HRDZsbHQ4WTRyTGtjT0NC?=
 =?utf-8?B?M0w3SzdzSDJZTFRxYlI3aW1jQUtHdFJlTzZLbmp0MURCSWlLZ2IxbXhNTXVW?=
 =?utf-8?B?dDBaNkZJL3h2MXhQS244cTNXWC9uNVRTQ1lGTWdPek5mU1ZOT1dvbnc0SlVz?=
 =?utf-8?B?aVhtVzdkNmxSaTIwOE9HZHR2M0Q0MVBUTjRkVDcrMWo4YUtiZElleE1SRXFv?=
 =?utf-8?B?NW9jQndQZHNsa3MvRFk1NUNFcThTZmIvYzdzQWFvN3FQalp4QVpPWVVPcXlj?=
 =?utf-8?B?QUxsL2YxV1M2ZHNsWmtycWpoSGxtbEEwQjRNS3BQYjd6SEtUNFFZUzRIQllh?=
 =?utf-8?B?VjNPM0prSHc2MFlnRGNkR3RuWENGZW9xV1M5VGh4aUNScS9uYndMRThpZk15?=
 =?utf-8?B?d2dqd1UzZ2pNZDczNFVRV1RIbWVQaUp1WTRycGJCZ2xHN3ZCaHRsSDQrbTN0?=
 =?utf-8?B?RXkxRFdCeERjbmgzc3VnQ2gvYzNqWnNRN0tzRjFia0JFdjBOUUZVM0Y4M2w4?=
 =?utf-8?B?RTdnWXNvVTJtTXJnTEFudkIrdVFJcjhPUWhOVVFLMlpucVMwSCs1WEZyT2do?=
 =?utf-8?Q?nlag=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(14060799003)(1800799024)(82310400026)(35042699022)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:16:54.6578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13487754-d122-42e9-959e-08de17c75c4a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10936

CP110 based platforms rely on the bootloader for pci port
initialization.
TF-A actively prevents non-uboot re-configuration of pci lanes, and many
boards do not have software control over the pci card reset.

If a pci port had link at boot-time and the clock is stopped at a later
point, the link fails and can not be recovered.

PCI controller driver probe - and by extension ownership of a driver for
the pci clocks - may be delayed especially on large modular kernels,
causing the clock core to start disabling unused clocks.

Add the CLK_IGNORE_UNUSED flag to the three pci port's clocks to ensure
they are not stopped before the pci controller driver has taken
ownership and tested for an existing link.

This fixes failed pci link detection when controller driver probes late,
e.g. with arm64 defconfig and CONFIG_PHY_MVEBU_CP110_COMPHY=m.

Closes: https://lore.kernel.org/r/b71596c7-461b-44b6-89ab-3cfbd492639f@solid-run.com
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/clk/mvebu/cp110-system-controller.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 03c59bf221060..b47c869060466 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -110,6 +110,25 @@ static const char * const gate_base_names[] = {
 	[CP110_GATE_EIP197]	= "eip197"
 };
 
+static unsigned long gate_flags(const u8 bit_idx)
+{
+	switch (bit_idx) {
+	case CP110_GATE_PCIE_X1_0:
+	case CP110_GATE_PCIE_X1_1:
+	case CP110_GATE_PCIE_X4:
+		/*
+		 * If a port had an active link at boot time, stopping
+		 * the clock creates a failed state from which controller
+		 * driver can not recover.
+		 * Prevent stopping this clock till after a driver has taken
+		 * ownership.
+		 */
+		return CLK_IGNORE_UNUSED;
+	default:
+		return 0;
+	}
+};
+
 struct cp110_gate_clk {
 	struct clk_hw hw;
 	struct regmap *regmap;
@@ -171,6 +190,7 @@ static struct clk_hw *cp110_register_gate(const char *name,
 	init.ops = &cp110_gate_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
+	init.flags = gate_flags(bit_idx);
 
 	gate->regmap = regmap;
 	gate->bit_idx = bit_idx;

-- 
2.51.0


