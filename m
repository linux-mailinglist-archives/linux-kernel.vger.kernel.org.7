Return-Path: <linux-kernel+bounces-725258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5EAAFFC85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF20B426BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0328D8C2;
	Thu, 10 Jul 2025 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l2VKAvAc"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012014.outbound.protection.outlook.com [52.101.71.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654B291C1C;
	Thu, 10 Jul 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136551; cv=fail; b=CmkjYvQB0IimO0S6e5YjXgAUSmfgeBNGsWSBDylkr87ZZhdR1y+44qNhjFSXubs9i5RPRSEWiM25lLCH2emgl1yybdXpwsSw9A7z7RdAc0jL7vMJo6JO/DAmPxXXfZj5ZT/nc8/ylCf30tF/OOUHsXIbo7kWsttazuyKlqabU4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136551; c=relaxed/simple;
	bh=F42zugqdkXRZPE31cdDymSqzZsVuQF1kzXGOJRfbIKw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aj/urz+U7RNQ9e4szOMGnGv/oeSK7o5XaFprg/JRw1apBaeUNCFOfqUZ4HFvnESXIBWiRQulYCl04InWegJwsfE49wIluvxWmljuZaXOeMhCrZzmcaUkaWXEAB4yg0w79NeKQ55ZtQbt7ClHp6ocIhlrHkeszdmJ2djf838inpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l2VKAvAc; arc=fail smtp.client-ip=52.101.71.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMRUYKBvtZAZDxtXgirhS0Opt8TJeGZ1zOMxIrvIiJk96C4dDds7jitOi/DyVMPle99eZUup0+II170cGM2hoO0DcsKJQQbbiplLrX9i6CCW+dlSy/P7NBUMNqn7U25e1KPafwo9AG7YqFIMFP4rzuPwHIrKiSIjalx0eq3ZdRhfN2oe8JvZj34ctFd1L+f/6CDoe4mit5WK+R73pRwlCQRRqz+m7TI8QPnvX8sYs0DHOl+vQbFKyUPyO1ApMYMoOkF8d7k6HaXhteAyxGzFQOx7u7KJFMz7SjQgMl3q0BblGh2U7w7hlfIKi+HjX8b9itAYqLRTsSDc2ew5G2qIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWJ+23LsuFrZ91ZhUzNt3s+kwcXAo2DOq5O41QtbSng=;
 b=NlpE8DugwMqrkI5fg75mE+CkEQUcoPmS9ESlRwheWDpv+5pDx8zp3M1/re86LAIvWLMF8vaRvT/zWGO9oz7/nsCPeFqwzQHH8ibm2uODtoMIwOpiEf+/1IbSA4MfSHrapVrM7xu17+4HMkOAM7flTHAjnjxNpiTHoSHDj1GCDnHLWQextep6txK3N33nOQd7EU11E6xUJsbvi+6EHI5Tfl1RlCODq4W2YNQyRrlcJogHY6pUCKZIWyXwOWAby4xkh7aBdlELWNGEol7B37NsWrxAFfq7vOc038JqMopCTTBynXZU134NacQrVNVKoIbj5x5w+vrpFMJLx3QmbthrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWJ+23LsuFrZ91ZhUzNt3s+kwcXAo2DOq5O41QtbSng=;
 b=l2VKAvAcEK6RDhFmiFXTUs4ckx5eprvLpMPgxWfMlTS70CCrzcFVggr6TL2gIlh/vf0QOhxM0DSQAE8P+Eoy4wYw/l8xiG7pFyhljJGey9PVbBhAspoYxewaSpbqtEzbtW1e+s9h2k657RY6NjXhI2L7PN9HWaz2sNFmZ9B4fJ+p+F40DeUKuRpy8QOiFDAC1AlzjSP2BglQK2gB1YCPblAVj4xXeFiGonUtzPBgU1GrQuKV3xPaA9qo6HML2LSy2JVvjmnqNvKaYhRYdeB+NgVsrkYJBGAtOspbBcrYf2cRCbXGT2Y8vkr468B4yQ0Tjzn2w9wqvLM5VsleOAnNmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:35:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:35:46 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 10 Jul 2025 16:33:31 +0800
Subject: [PATCH v2 6/6] firmware: imx: sm-misc: Dump syslog info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sm-misc-api-v1-v2-6-c3e953e34be6@nxp.com>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
In-Reply-To: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752136418; l=6080;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=F42zugqdkXRZPE31cdDymSqzZsVuQF1kzXGOJRfbIKw=;
 b=yWjRYGjiRhc+V6BWchG/rlaDpJCWo3UAtpa0o8XXpFW6ngi2VOsYcYPnfzQdLEfPUgu7Mtqnm
 h0fOU1vNptHCfsF9vyViO5aWwuhKJaT5Ce6gtYVRQmjsNrnQmEn4Tp7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: b11be75f-7c45-4ac5-c18f-08ddbf8cc3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmYxUkw2SVhuS2MyZ1NPTlpzOVUrV0s4THB0OFF3MDkrOE03b01JZ0xlbHdR?=
 =?utf-8?B?THo5emFTY0FObWdDS0gvUisrcnc2eWgyR3VNeHo4ckZzUUxMT1gxNjlWeU9I?=
 =?utf-8?B?Rit4MFRmYmRHUmRFRXNKUjMzYW1vSnFUZmhwazdZUWh4alh5cTIxTHBLVlJQ?=
 =?utf-8?B?QitkT2l5ZXpIS080UUUzVEpHUnErSnBXOFFzNFlNV0VOd2txbFlITm85ZS8x?=
 =?utf-8?B?VWRZS3FoSWpxWmVIY3gyZTRLMkFhMFp3UndiQ2g4VFY2ZmZrUWJMMUlpQU1F?=
 =?utf-8?B?S1NxMTd4OHFsa3cwbEtVYnEwN21tR25PRnZvSnR4Zk9ETC9nRFNlQWNWU2tn?=
 =?utf-8?B?Q0NnY1NFZFB1WWsvTGFuTWtQQk95K01pcjNMUUlaZkhxQU5TZWRZOFNTR1Ir?=
 =?utf-8?B?OXZMVWoxNEoyVUthYXN3Z3ZCWVJOQXhCOFk3d3VaV202ZWhFVnU1ekRZM3NK?=
 =?utf-8?B?czhrNXROUHNCbDZPSm1YamhKWDlsSUxrVDlVS0M0RXNpS3l0Q21VODJDUjVN?=
 =?utf-8?B?YnU5cGFaYkdMbXB6Y3U3ZHlCbUx0NmFFc25DZ2ZNRWlKT0hTZUVpdFJvOXlV?=
 =?utf-8?B?d1hoNlduNDBXcTNvWnJoWXdyYUVCTW5lMEFsdDBqSm9GRi9ObW85UkFNQ0hI?=
 =?utf-8?B?cnFGUC8zeTZpVjJEN2cvYVJaVk55NnpoZ29HWHhmL0NWRDRsSHFsSlMzd0dO?=
 =?utf-8?B?QTBZVi9zdkZPdFJkQkl5UDBZb1dZQlV0UXNMRmtZUlZ6TVVFUm5LSDcybGpl?=
 =?utf-8?B?REY4MEwvU2hvbitDWlNTK1pOQ1V6dzJHcDg0WHh2VHg2c1VnSFJrUEJIZGFQ?=
 =?utf-8?B?NVV0TzdGV1pvWTNiUW1GeEo1aFZ0Rzl6NGdpakdZbEtIWE1Zd2VUMWpRaUFR?=
 =?utf-8?B?K2NJcy9qNDE2OW1UclYwdW1acHl2aWNJaTVxUzM5SGh1a3QrRHh3K05jVEpO?=
 =?utf-8?B?RzBDNUxPYXFYU2NreC82L0JoR3NyT0UwS1lQODdXZEkrN1ZUQUNoODEyZVpt?=
 =?utf-8?B?KzFqQlFKb0VZZ1IxemVXeDNEVzNUYzNPVWVCSVFmdGdDazEwaVBwOGk0QlNH?=
 =?utf-8?B?dXBzWFBqTTZaNFFtWHFDdk0vY0Y1MDVreEREbWpmamhxeTdtR3dPWTk3T1JM?=
 =?utf-8?B?eXBneHpkRWgwSjBtcE0xMEtacTd0MnBXa1dnV3F1cm5jZFYvMHhpTjRHUmxh?=
 =?utf-8?B?TE0xb1dESGF2TEJ5dTBlcnJiRHBzR0FQSXE0NEQxT09pTUIzMXlMMFlNRkFp?=
 =?utf-8?B?Z29CZFhHWStPWHdOUEdKcTQwa092aWIvTGxWNTZMSlJWTW4ySlVCVi85cXFm?=
 =?utf-8?B?a1N5YWlnSm9zK1BFWncxQ0IwWENHS2RMZlZYcmV0eVNKY0JoTFBLWS91YXRn?=
 =?utf-8?B?YXlRZTNWY0c4aUxkM0d2SlEwMEtLckFVeDFidzA3MHBsTzVLTmFmWEFPWkc0?=
 =?utf-8?B?TWJFWnJ5RkxudnhsY2IwMXlMS2VPOWl6aVdLWm4wT2FjT2FMMDNDbkdYZUVx?=
 =?utf-8?B?NEZjUC9iSExHWXNuS3NydkIzUm1sWmNxRTZDSVJPK0RrcTd5MDRQVnY1Mnd4?=
 =?utf-8?B?UDd1S1QzaFVCcWcvZWVkOTRCUy9NMjZuRG9uTkZkK1l0c1NLYWhvbW4rNVZD?=
 =?utf-8?B?LzlsR0F6cUZLejBpWjNzQ2dqWXgrUGtuM01waU5McDNLN2ovVmdIS1NIUHVQ?=
 =?utf-8?B?ekcxQXlMd2ZqV0VvN1o0MEpEemV3K2lVc2Vjb0d6YVFucFJETmtsdmFCUlZL?=
 =?utf-8?B?VlN0V0VOY2RnTi9Rc2ZLSzhwYk5PRjZkdTkyTHZmVDdiTTZJNlZwZlc3eDRi?=
 =?utf-8?B?VHdycXRKL1QvdkREZWlZNE9nOWQ1V2ZrQ040Ny9pbFZXOS9CTm5nUGc1ajh0?=
 =?utf-8?B?V3BTbmN6QVpqcFVWYWUrUEwwNGZaZEVGRUVrdGZ3NkNyUnozYlFmclByVi9t?=
 =?utf-8?B?Y3prZktQd3M4ak1xaVUxb3RQZFpUSDdJZUl6N0pJbjg4MXp6bEwwNUFZckk0?=
 =?utf-8?B?TTNuN28rT2dRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVBNRWQxaTM5bFZMeVJOREk2L1ZLOFh2VFNpVDB2TEpLQmJ6K1R2cGw0Q2JD?=
 =?utf-8?B?QWsvU0NoaWorTnRlallKZmRvQktYOVRHZ1VJekVUamtrK0R1Yk1FVTcwNGNJ?=
 =?utf-8?B?RHcxdyszRndQSE5nakVYcThqSGNQcHdYek4vbCs3dFJGb09rYnk0Y1V1ZVNa?=
 =?utf-8?B?RzZpU1pGOWVMRWxoK1Q1MWhRNGtrVURTbm01TjdRYzhQNlVyVGt6T1JRSjJL?=
 =?utf-8?B?YmpQNHFVTWIra2JyZkxrbUJBaU1mc0xLZEh5NHNCcUsrWSsyUXhEV0FrVTdw?=
 =?utf-8?B?eHZ6K096U1BiVENWZFc4ZzkyQ3VDRmtodkd5Y3Z3SS9NZkpzWU9hWlJRakty?=
 =?utf-8?B?V3FMUkNOdEZxL3FDM2c5V2tYZWVyUEdKOWEzdW92RG1yK05mN0hrQ1MzRkxP?=
 =?utf-8?B?M2VxZGN4WEVaQzFWL0VtVEJEeHdxaVdOS1oxdm5zalU1aWpBdzR6S1NtMEg4?=
 =?utf-8?B?SzhJUEg0WWRLVEUrMjd2VWdCMzRPNlJOQmZSYU80YVdmejQvQ2M4ekFybUlL?=
 =?utf-8?B?WDNHNWg4dDdWaEdoNndoSXpIWE91WEFuc1FlMFA3dVVVUnViYlhZcGtMNWNJ?=
 =?utf-8?B?L242RnRMdWhQT2R5WXZCT3hvL295N2gxa0d0bTdyZE5BekcvTW5oeVd0STQw?=
 =?utf-8?B?bktFSGgrcnY4dTI2SklzNDZLdHVQS3pzdXI3SU0wZ2FRaVlSNXRiSTRLVUhJ?=
 =?utf-8?B?YTVHRnc2NWJHbGFianZDeUM1VXNOaDNpQ1BlK0paa2lXcFYvSUdYYVM3OWRS?=
 =?utf-8?B?R3FZM01XOUJneWhXT1QrTUkvRS9QT1EzYlpqNUV0YmZvZ0tUemVmU1BsTFFY?=
 =?utf-8?B?SXJFa0lnVmZDM0NCck5rbVYvYVptYWl6a08yemEvNWF3Z24vR2MrTGFxd1pt?=
 =?utf-8?B?RXhINjVLdFhzMmtaOTlxYVA4UHdZZEovVm1iUGpMLzNWSmJqbHJZZVdYRUox?=
 =?utf-8?B?WXdES2xxTnVIZlFlUi9OaklXcDhqRk5ZdmJTaXR3QXNaZUlha0NBMklDckpF?=
 =?utf-8?B?cnhxT29OYzJMT3pyY1VXNGoySVBuZ09KSHoyLytMKzhkdktvVk5uR21VT2xT?=
 =?utf-8?B?bGpVQjh4K214QUdSa1hDWm5oSjAwaGFqZnJzcWFROURlSXB5djRHc2xiTnRK?=
 =?utf-8?B?Z1NGVE54d2MybGgyQit6amQzdWs1ck82VngwMytXNFkzUmMwa1h1cGM4dXEr?=
 =?utf-8?B?blR3QnNVNTcvbE1qL3ZYM0drZk1yeFZrNjhKQmd2L1d6UmxlM1ZkOER5ZmJ0?=
 =?utf-8?B?eEM5cGcvSEtaWjVIL1lGN05lSzR2TDd1bERFczRIbmhrWlRKT2pzTitLNXRh?=
 =?utf-8?B?TXF2ZVdpVFZpY2h0cE9UMERxZXgrUjUzTkZyNnpTSTFzRHNjVHd6ckZkNXVP?=
 =?utf-8?B?bVA2Wm9qUk9iK0tvOEdrRnpCTFpqckpmUUxLOU1PQ1RjVkFXUGRwUTMxME9h?=
 =?utf-8?B?bHVnSEdaYm4zS1RPL2V6dFlqWk1yeGpRZlJQRWNLeDlKczlOdzF5cERhSEhz?=
 =?utf-8?B?UzRMOE5uVVhGRmN4ZStoNXdtb3JaNXB0ODBIclI2MVhTVVYyTjR0ZjJYaUdR?=
 =?utf-8?B?MVUzMHFIS3RUR3Z0OXR0all4QllReFpubGJTMko1OVhRYTBlaGRuR3g5VnFr?=
 =?utf-8?B?RlV6SmNnaFp3cFlLSDExUGxZU3FiYTJuZlVnVlV5dVRtR0R6LzFSRG1Sa1R1?=
 =?utf-8?B?c1BXN0hEd21ZNXp5OWR6dnhFeUp6am1OekQzT05sM3lycHo3Wm9rTDBncWs5?=
 =?utf-8?B?VGJaZDd0UXpDVzN1aXVFVE5aNEZSS0hpOFZ5aUR6OVZjOXcxSHY1eC9FQmxj?=
 =?utf-8?B?Y2xqbzNGTkw1VHFUelYzWGJzaDdIUUNncmFMU3h6dXI4cGZ1WGxxY0c3ZFg5?=
 =?utf-8?B?WGtWdWxCVldPVlZjckwxaGtsSDQyeHcySmFONzBlWDlMdjlHaUdGb01nRXYy?=
 =?utf-8?B?TFloZFRjOUhmR2s5eVA2YThlaXFiUGJKUHlRUHg2THltbzNFS3ZmZ0dKUmto?=
 =?utf-8?B?RUVFWm5rWUlRZ1RSVm9xa2RuTkZ2OHl4VUJ0dDQwL2RyZHNQNm1pK043RzF0?=
 =?utf-8?B?QVo2MUNzenV1NUNWa1RRMjhyNVdNeFJGWTU3NTlQalBydWoyWmZrdXByazJW?=
 =?utf-8?Q?mbE119qZbaPUxQhbrFrCvrXW7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11be75f-7c45-4ac5-c18f-08ddbf8cc3ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:35:46.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5wmsiEHVbwWsa4NVRCE38sx2NeUeu/NejHautqO0fogDYUAbkDxrKuWpLEmwGifQEOn30/68XzK+itulbFgOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514

Add sysfs interface to read System Manager syslog info

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/sm-misc.c | 178 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
index fc3ee12c2be878e0285183e3381c9514a63d5142..10aab5b127f65ecc57db9ab6c0c2c2b84d1dd864 100644
--- a/drivers/firmware/imx/sm-misc.c
+++ b/drivers/firmware/imx/sm-misc.c
@@ -3,6 +3,7 @@
  * Copyright 2024 NXP
  */
 
+#include <linux/device/devres.h>
 #include <linux/firmware/imx/sm.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -44,10 +45,178 @@ static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+static ssize_t
+wakevector_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.wakesource);
+}
+static DEVICE_ATTR_RO(wakevector);
+
+static ssize_t
+syssleepmode_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.syssleepmode);
+}
+static DEVICE_ATTR_RO(syssleepmode);
+
+static ssize_t
+syssleepflags_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.syssleepflags);
+}
+static DEVICE_ATTR_RO(syssleepflags);
+
+static ssize_t
+mixpwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.mixpwrstat);
+}
+static DEVICE_ATTR_RO(mixpwrstat);
+
+static ssize_t
+mempwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.mempwrstat);
+}
+static DEVICE_ATTR_RO(mempwrstat);
+
+static ssize_t
+pllpwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.pllpwrstat);
+}
+static DEVICE_ATTR_RO(pllpwrstat);
+
+static ssize_t
+sleepentryusec_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepentryusec);
+}
+static DEVICE_ATTR_RO(sleepentryusec);
+
+static ssize_t
+sleepexitusec_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepexitusec);
+}
+static DEVICE_ATTR_RO(sleepexitusec);
+
+static ssize_t
+sleepcnt_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, sizeof(*syslog), syslog);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepcnt);
+}
+static DEVICE_ATTR_RO(sleepcnt);
+
+static struct attribute *sm_misc_attrs[] = {
+	&dev_attr_wakevector.attr,
+	&dev_attr_syssleepmode.attr,
+	&dev_attr_syssleepflags.attr,
+	&dev_attr_mixpwrstat.attr,
+	&dev_attr_mempwrstat.attr,
+	&dev_attr_pllpwrstat.attr,
+	&dev_attr_sleepentryusec.attr,
+	&dev_attr_sleepexitusec.attr,
+	&dev_attr_sleepcnt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(sm_misc);
+
 static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 {
 	const struct scmi_handle *handle = sdev->handle;
 	struct device_node *np = sdev->dev.of_node;
+	struct scmi_imx_misc_syslog *syslog;
 	u32 src_id, flags;
 	int ret, i, num;
 
@@ -63,6 +232,12 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 	if (IS_ERR(imx_misc_ctrl_ops))
 		return PTR_ERR(imx_misc_ctrl_ops);
 
+	syslog = devm_kzalloc(&sdev->dev, sizeof(*syslog), GFP_KERNEL);
+	if (!syslog)
+		return -ENOMEM;
+
+	dev_set_drvdata(&sdev->dev, syslog);
+
 	num = of_property_count_u32_elems(np, "nxp,ctrl-ids");
 	if (num % 2) {
 		dev_err(&sdev->dev, "Invalid wakeup-sources\n");
@@ -108,6 +283,9 @@ static const struct scmi_device_id scmi_id_table[] = {
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
 
 static struct scmi_driver scmi_imx_misc_ctrl_driver = {
+	.driver = {
+		.dev_groups = sm_misc_groups,
+	},
 	.name = "scmi-imx-misc-ctrl",
 	.probe = scmi_imx_misc_ctrl_probe,
 	.id_table = scmi_id_table,

-- 
2.37.1


