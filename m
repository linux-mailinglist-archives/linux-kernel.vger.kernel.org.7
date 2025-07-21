Return-Path: <linux-kernel+bounces-738808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8EBB0BD80
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4527ABC93
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05321CA1E;
	Mon, 21 Jul 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e2CifqFH"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E62820AB;
	Mon, 21 Jul 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082206; cv=fail; b=koigL1uqaYrEU+3Kfyniv9dvPSV15Pz3vxfwuAPvlrNP2x6HpmUjoHVYAgH3HRBIjUJvA+/ZSECtjgDOiV7tEbob1UVIU/FyZ7ltAwXfprcqkC65T6igbYPod7SnzWYyko6OMtsRY+n6RoiJ0CICAOyCzoi5hzy2S0mwoJqP6bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082206; c=relaxed/simple;
	bh=gaVv0dnoxbctE53aWkyDtU3oC1NxC5oo8zDKTiWcKxA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N0ugTBaavqZTbi4hH4gb9mnuCrf+AwBPSdE3ivyru5mnWQ+CO6rRlYFUPvHSGizZswGb7CynRfhuyWq5hGhCgFv1B38h1/78aRpc5pvBjNDrfgnvkhjBEI/wQZdf8vwBO6EGF3rhN+DyEX5Bb23F+h2U6N/wcwcepyUbMGrLv3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e2CifqFH; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+iE++xiIbSYb9cvnQkScupj+aoMcDRnOSOQw3onVyND5yBcP00fRF1gjVv9sx0d0wyGAWESFr8swlYuhUU5vrtz+i9MUkZGDgSQcQ+2myZPYVt5J18Be/8EJk9RR9zXezkwZCmG1qPVM8RtHSUF8KlDD6MLJSQUxXuWkZ8JhuL0anmmzswEeJovVlBlPPla3RJBPLreakSeJ1FDAbdVXZOezpog7km5JFTdbnEqeHiKxepoH5irVp7T7BvEWVHFvMGerLgijuxFZ4TlwCkk6SGe1vTymj/QB4HZUBJaU+HaGyGoxnR97BNAZKEPx8bvVjcmdm4N9UKuIt2HnLlPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQPOdkWafKHpn9uZFxSp4ndvnrck24k6mDsvLG5G6LY=;
 b=Igf7xwX+6yTGw+LOKkmNc5upi0EG7bpzKBe6oyfnnWOofGFODB92ZiZLNnQzw2CSY6hMNV21rWlUaepocRBbp+fRz7OU5mcWzgzWbm/5cC0NGyW9Fz8AVwtb+dkFMvGeYlq8Zu+M/0u49hBz5oqH8D9ms84G3PV/dLu4HUPLUH6UH9iX0ra4xzxV22+RgzyXSNTdRYl7zAl5uzr3X4gSTpxYPAtN3WS0D77DSxOhkNoKXAnS49e47yQWgbL1BY1CaFS+51395E9dsdnhljoGVMLF+PviYSppdRi9wG5EtGFWPKxFAeXvFjt7TBVWb0TuryaITk2hyBQMvb9EHW4s9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQPOdkWafKHpn9uZFxSp4ndvnrck24k6mDsvLG5G6LY=;
 b=e2CifqFHfptJbbhp0pNIIWTACyf3Tx1J/9ELCBWUMTfB9HLLBQ0MSeNmT7D1/4Vtf2rKGrQk4GMnGjDtZAN4K03a+t/IVa/deWmPNYDAmkELoHOQwhjCEHJXpd2sPfK8uM9Pr4qvBE33eYLzltL0+JLd7mn9PXYhPJbhuxo8/EdRyE/pJ2V3Y0gT3Iq9pkGV+1uHlh4a9MfbdSypJgtim6bIJRliOXk+S/28OwCLkSHUmDLk9rVjoUnLuYIg3k6HLnus+dWQmEKfUNfDZ4PF/EXzxPA8NKf4F8LeJIF7S0z9LclddaSCJbHwNfp4WwF658xlk29qIMYwGYrpjtkE8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GV1PR04MB10845.eurprd04.prod.outlook.com (2603:10a6:150:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 07:16:39 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 07:16:39 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Mon, 21 Jul 2025 15:11:27 +0800
Subject: [PATCH v2 1/2] dt-bindings: regulator: add PF0900 regulator yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-b4-pf09-v2-v2-1-e2c568548032@nxp.com>
References: <20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com>
In-Reply-To: <20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com>
To: Joy Zou <joy.zou@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA5P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::13) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|GV1PR04MB10845:EE_
X-MS-Office365-Filtering-Correlation-Id: 506ead6a-23f2-4405-5f74-08ddc826892b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFdTT29KYXhacEwxUGpXRkthNW1UbDI2RUJsbHpxeUVMTWQ1UVFKVG1yckZy?=
 =?utf-8?B?aWVOR1o5SUR0ZW8yaGVxanljUGNkOEJpYVdGVTFWQ01rZ2h6SnQvdEZHbE5O?=
 =?utf-8?B?bFVzbG9rYW1lcldyOTRvdSs5RHBIL1FHWTRiOHlDSHhhZEtwTlZaMEx5WVVz?=
 =?utf-8?B?UVcxVldhaWJjOUkza1pLSElVTXdNeVR2ZENhamFtY2RNRm9PeW1kUkgwL3Ur?=
 =?utf-8?B?aWJhbHJmTTFLa2x4QVU1TzdVRjltTVd1VVQrU2xRSWUyWEFLQ0pKQlErY094?=
 =?utf-8?B?LysrYzhtSWRKTHlacHVKajhCQk0rRHNPS1hWWXAvaEpzVzF1SWZBWkI0T0xR?=
 =?utf-8?B?dlY4U3lBRjZESW9CQ3FoWkROWit6S1UyR01oQXBJOG9MYTZqVCtLZUUwRG15?=
 =?utf-8?B?cUQ4TFJoOEc2K1pwMmFXNmFseEJPWjFYRnFvdC9HbHRGY3hxaldZTWFxRU4x?=
 =?utf-8?B?Z0pnc2cxVGYwaXVXMFRnY3RYbVYybk9wVSs1Rnl6NWZTaC9qMEVwd0hXRnEx?=
 =?utf-8?B?Myt1UVBPM3VoZVlncDZhbS9xSm44dXNRWjhmRmVIM0dOVC9BMzZWdW1SMWI4?=
 =?utf-8?B?RmRobUtidTc4QWVyeHhMbHRreTRKay9raGIrRTRaZ1RNb3BPbm5hY0oyRFo5?=
 =?utf-8?B?MWIxdUp6aXFnL3JHVXM0N0lqSVArRVJZMURYQU1ZZnE1K2FycE16U0lhS1FF?=
 =?utf-8?B?ZkozVXVpQUVHQm1LNmtvckpkQ200aGlUdTFXd0xyMjRnNXpNdkFER3lLdktn?=
 =?utf-8?B?aE5SNlFWd1ZlQVZIc0F4UGdTRzJhTFZFcFlqeFNDWjd5ajQ5SDh3Q0ZiMHpO?=
 =?utf-8?B?UTFlZ0x6OFRKRERKcXliL2dDYW9QQzFMY2pJSkoybHhtaUNFWGI3ekxrRGh1?=
 =?utf-8?B?NG85eUYvUmU2SVBpclFkc0lLYnkyTS94VUxFMktIUXVIbDQxd2RPbUJRQk1E?=
 =?utf-8?B?Qm9ZcklXR01hbjVNejVscWxkSUNJY21iM0duZ3ZraWJYNDNQQXFVYnlDRE9n?=
 =?utf-8?B?UDlLT0hGUWVudFEyekVpOUpCMHFRaDBvVjVZYWhaSDVLY2M1NW5hc3h6bHg3?=
 =?utf-8?B?YkpaQm5Oc2RKNnI3QmVDd2hZYnRXOGZhL29VUnNHU3ROMG53a0VhaHUxOXNP?=
 =?utf-8?B?QTNqREJUOUhmK0hPNHFNQ0tGZk5rajdqN09NN2FYS3I1bkVmN24zT3dpSkR0?=
 =?utf-8?B?MzVDcUt6ckUwWmFFOSs0c0dEbGZ3REMrRXh3aU8xUUpHU1M3V3dQdUVVREtj?=
 =?utf-8?B?bEZDd2c4Zzd6ZjRsTGdvVW5BeFpxZVBzb1JPYktiSys4enh3Mk02TVZJM3cy?=
 =?utf-8?B?N3l1Smp2Z1lhVC9qbDFuWUkyQjRtZEU1SjZERC9iTWE3SGZIVjZRVlk3OHh3?=
 =?utf-8?B?TmYwdTdhWENNMithdFFDTERnZEpkNUN2eHh6U0RFSG1wSHcrRCtWRVZXNEJV?=
 =?utf-8?B?dWhRbmxlTEd6OUJzMHFva0lOUDVEQzBSVitrdDNWSnFYZXB1UkE2UmpiUE5u?=
 =?utf-8?B?VWQ5WTBPM1VTT3pzVFpveUltbjZWd2QrMWpsTVR4TW5Pck13NnpsREZrN1hk?=
 =?utf-8?B?b3hEMERlQUVEV0ZGdWdnNkQ2L3ZNVVZmb1ZHcDhLNjRJRmRhS3E0OENUT0dl?=
 =?utf-8?B?RFA3am01S2pUdkUybFlhTzltL2xxQU8wY0ZXNTduK1RQMUsrT0xMM1Z3OVh6?=
 =?utf-8?B?YjZUZTVGcXJnZkVzcndmMWxEc3IxcmxiMGZuQ2tjaGlhdkNQRE1TNk11aExU?=
 =?utf-8?B?K2lSRTJ0NlgyNXRrWVRSc2U2NGNUaHdaYnR1akpmcStIcUdNUDIrNk1DM0M3?=
 =?utf-8?B?UzBQUk9ybHRTL1ROdU9WK3lHVFQ2Y3I3Y2o4eHpKOFh6SWVjWHN4bmJhdGwr?=
 =?utf-8?B?STVNOVpmYlZFT3ZEWnlwNkVkZ055cWFUNG1mNHh3b1lLUDd6OFlWSjhmQzdH?=
 =?utf-8?Q?21/5ktcppjk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDlZWXF6M3J3ZXhER1pQUkZETHpFQUxzUit2N3NVbFZWY3FsM3JBU29zeWFP?=
 =?utf-8?B?M05ta0h1RFd1VUtOYkpZR29leVhQUTBvWmNmNFNmSUxQMmUrdWJ6eWtPZHJW?=
 =?utf-8?B?QmR0LzZmenZ1NU53dzAvUFNaTldjV3BVOXVlaTlUVkZ6bGtBSjZrTzFveTBP?=
 =?utf-8?B?YUVQbXcvMG5pamtoSStTaXI0bDJPdWE3WWw5Nnc3d1JJOGhDelA2ZnFKNWJF?=
 =?utf-8?B?dGpXWHB5ZjVJUnpkaDVmd1NlTFhPdUtMYlFHRmdVN0RZb2IwY0g0ZkVhZ25U?=
 =?utf-8?B?S05ienVsNkU2dmpPcHVPbU5GNTRSQ0VVMUFJNkNyWEExc3NiNC8yaEJuZzFu?=
 =?utf-8?B?UWdyaFIvQVk1RGY1QVlqaldQQms2WFMvSk5UQWp2TkpsN0RIZlRUOTU1L1hv?=
 =?utf-8?B?U3I0aCtCNEdUZ3gvaFVoa3ViNXhIQzlzNnZMRkhMZGVGOEp5eFJONlptTkRl?=
 =?utf-8?B?UlEyaFNhaHRGdDE0b2tmdWZZU2UxTE1sRGp2RUxqR1QzT2d5eFRpdmhwcXk2?=
 =?utf-8?B?ZUZOV003cGdmbjYwc3Z1MDFSZ0p3QVJnM2FVYmdpd01jZzkvbXRJR0M0LzVi?=
 =?utf-8?B?c0Q2ckZETVBMdHdnekpkK3RPNHp5MjUvS3pRQ29wbytxbjdVb0NUYkFJTUdi?=
 =?utf-8?B?NTNIeXhPTU02MTRZb0tlTU0vQ3hsQjJ2SE8vajZ1eHVZYlpzdlpaQzg0N2Va?=
 =?utf-8?B?K0l6eWhHblhNWEJGamtvd2lCdzhTb3JvMldjV3RIVzF5alVSLzNaM3JkNWxv?=
 =?utf-8?B?VUVuUUgvb1YyNTMybG1OMUJRTmNyeUNlamNiQkdldzByQ1J4YjdQSTRaQ3JG?=
 =?utf-8?B?YVBvVENhaVBXUUM0c2M0cm1XQkxKdWw4N2dHQ3lvOHh1STdENHRrS1VnOXIv?=
 =?utf-8?B?dkdHcS9vbnJwaVE4NC9uOUtzLzIwRm5BeFkzcVJxSUc5TWFFTHlsSG1VMU9G?=
 =?utf-8?B?Z3RPRmJjeGhMTHZ5elRkaDdOWEgzbFJNWTJHcG1sVG5NTFY2cUpvSlJMUnNT?=
 =?utf-8?B?cXdpaFkxWENFOHNZMm9GVG1XRHVjM050Y3pZcll4YXVXRUd3ZkIzeTVYMlpW?=
 =?utf-8?B?c1FyTk1oNDFVMHR2T1llZVM4Qkw4ZVovSW9veEw5T2FjM1pKbElJSk5GdWVi?=
 =?utf-8?B?SXpJeGZiNFMwZGE0MUZYZURENU5aYWV0YzlvN052UzFzOU5RSmdMMXA2MG5X?=
 =?utf-8?B?YUMyZ1JaT1gwUnFjMHY5VDFUZkpqZnlzOVBabGtKMWVjSnpld0FoczlQNmZu?=
 =?utf-8?B?S2VkbzNBbzdKVUw0MTJGZHNXKzVjS0hIVlJRTlFZMStqZU1pSXBZWDBhaXFo?=
 =?utf-8?B?ZEZJK2RDWEVDSGp1eUc2ejgzWS9EcG9LMmhGbHUrRHZFN0NycW16ZjF0a0Fs?=
 =?utf-8?B?dVdUL1lpR0lJa253KzF1ODdZaEJjeFZrS216d3dxQkVaRjc0Njc5R2E2empv?=
 =?utf-8?B?ZEh5anlGRUw3Y25vUWFBckkzVzd0RnllSTRsaEZqNkNIU2VyUTg5aGdaQmFy?=
 =?utf-8?B?RUp3R0x0OU5rTTlkVk0xZndjT2dKUmJBOEw1UzR5K1Z6Wmg0WE5zaGFTUTZ0?=
 =?utf-8?B?dTFBeW5lZXdaV3hpNXZoWDR2b1JWa1huN1lHSURrRk5HaElHcXQxSFpYcVUz?=
 =?utf-8?B?dXBUZjdRWEJUS1FKMDRzRk9aS3Zvdk9KeFlQK2ZWUC92QnRhMDRCblpLVzll?=
 =?utf-8?B?QSt2WDRMT3doclRNOTM1bWF1b09VeDdEc0xoL2U1ZlhwdVoyeUM1RTE0TTU2?=
 =?utf-8?B?WDFEU21JcVdQbnVubURvU0QvTFBlUXAvaTVjdmpLVENSMmR6ZE9yQ2N1V3c0?=
 =?utf-8?B?UjFnQnJ5eTFnR0g4U3pTN0tEQ1Y1UUIxcm9lZUROK2lkUDBmSHRzRFNtQjV4?=
 =?utf-8?B?MFFpTXlvZ2E3Mm9rMm1kaWNHdEEyV0VjVTlKSWE2aFBaeUhhYk1YeURmdkZQ?=
 =?utf-8?B?Z25WUi9DaHhEbmNjZVR4bVVDOHhCMkg5NUh1VzVyT2w0c2hnZlpXK0w2VGVl?=
 =?utf-8?B?T0ZzYThCd2tMZlFOaFVIQXU4N2MvZWJYM29YWjRla1lQMXYrVTJUUE9kODhM?=
 =?utf-8?B?bUVlOU5FMXM0SFdac0o2WWhrbFRaZUxJdG8rdGc2ZElWcmZaczZnMXVZUUlq?=
 =?utf-8?Q?aED2+5pc4mBVm7jhgD0/DQyJp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506ead6a-23f2-4405-5f74-08ddc826892b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:16:39.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccYjNoE7aywpNE5cDp3jTGaR0P+rhGDQEP48kH6G3kIpVNMBAFQiNuNyH8VfYa/L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10845

Add device binding doc for PF0900 PMIC driver.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v2:
1. modify the binding file name to match compatible string.
2. add one space for dt_binding_check warning.
3. remove unnecessary quotes from "VAON".
4. remove the unnecessary empty line.
5. move unevaluatedProperties after the $ref.
6. move additionalProperties after regulator type.
7. remove unnecessary regulator description
---
 .../devicetree/bindings/regulator/nxp,pf0900.yaml  | 169 +++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..55cfe9ad5c5c24b47d5a806985e092e279755064
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pf0900.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF0900 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Joy Zou <joy.zou@nxp.com>
+
+description:
+  The PF0900 is a power management integrated circuit (PMIC) optimized
+  for high performance i.MX9x based applications. It features five high
+  efficiency buck converters, three linear and one vaon regulators. It
+  provides low quiescent current in Standby and low power off Modes.
+
+properties:
+  compatible:
+    enum:
+      - nxp,pf0900
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      VAON:
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+    patternProperties:
+      "^LDO[1-3]$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^SW[1-5]$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          nxp,dvs-run-microvolt:
+            minimum: 300000
+            maximum: 1350000
+            description:
+              PMIC default "RUN" state voltage in uV.
+
+          nxp,dvs-standby-microvolt:
+            minimum: 300000
+            maximum: 1350000
+            description:
+              PMIC default "STANDBY" state voltage in uV.
+
+  nxp,i2c-crc-enable:
+    type: boolean
+    description: If the PMIC OTP_I2C_CRC_EN is enable, you need to add this property.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@8 {
+            compatible = "nxp,pf0900";
+            reg = <0x08>;
+            interrupt-parent = <&pcal6524>;
+            interrupts = <89 IRQ_TYPE_LEVEL_LOW>;
+            nxp,i2c-crc-enable;
+
+            regulators {
+                VAON {
+                    regulator-name = "VAON";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                SW1 {
+                    regulator-name = "SW1";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                SW2 {
+                    regulator-name = "SW2";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                SW3 {
+                    regulator-name = "SW3";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                SW4 {
+                    regulator-name = "SW4";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                SW5 {
+                    regulator-name = "SW5";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <1950>;
+                };
+
+                LDO1 {
+                    regulator-name = "LDO1";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                LDO2 {
+                    regulator-name = "LDO2";
+                    regulator-min-microvolt = <650000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                LDO3 {
+                    regulator-name = "LDO3";
+                    regulator-min-microvolt = <650000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+        };
+     };

-- 
2.37.1


