Return-Path: <linux-kernel+bounces-764735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EABB22699
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE38E171311
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245C18D65C;
	Tue, 12 Aug 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V9VAWGwF"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABC14A09C;
	Tue, 12 Aug 2025 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001119; cv=fail; b=WR3qyow1CKe4tMEyCmPZCeOVUoF+JHY7cAB1tNFUyD1MOnJc+TuNhxYhmxV19ekFrPH2YC/U3jd8w47lRZZDab8HWaUnJ0tfYR5z1JBm2jjqurbZH0C8u3vXq3b5SVXnDOtg5dgFk67yEmPfKj1Bkg6qpNBSE3bAMULmjTLyuYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001119; c=relaxed/simple;
	bh=6JLh9rwynHClF/tGiCfiQNpPIuZrszzf2xHai83373s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=M5BiXS+i8x7smZ3EfQoSk6t8cz0jz3+bT8wJdKO+NYMf07IaqoYK37nUdkZ/Zw3j2y9jTXhQGuIIwCKd7f8Rls8hDNelXswy4OUzyM7iUH4mdT+JJya2VvXhLGCUEBFblZzsoQzRnTkKAR8qOiWXff9gdPyHyq03fk1nKdLh/Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V9VAWGwF; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufE1CsBSE51qwvopaU4x8/ltkpOOicO0Jpsjy6LXmjoS91oPbDcjbAdOOSVV8uzeAAqPIGACHnuxjR+CUbGwKqsZlJNF4SSi9vggALenT4/cEJel5E90wrbxF0kMJQnS+2S8nulfA5DlfR1emaUMBrBFMpSb8xDHB48EUWHD/D7HxsTHCd6yzxmhBQOR8Zk7BUxoMVFYlQejCB9Y2YLhKI47B7X0xnQnptbLRnBjdIJ1NGWQw3mgzcZG8/JoUiQm8Kx4+TrQI0UdMBCcY/01HprJ0aANu7Ozd8KCUea308tSFHR+mbVYj/t0MaLX9aq4zSgkXP2Ny+4Gzkf7h/rRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3Y8HRThzuSJRfZ793G6ISl6XnnAGNorWktNEfirMgk=;
 b=BjTUNq32vyerh20Y97YaUmiLwRe61xw2T7bMFG+HTDIbnL+NhqO4G57jRjjIpZZSkpWm4pOmqqH6ySgBYx8K+yiPOpr1VYKgFrr3px+3UDVoTKempWpqlRTJHtLPhJYpY7J39lQ7ij7IowYe8K+f7CGpiQ7Mnq3TmI/SYe0BIVFvLX38KgOIp5qyw7Z4FoGEN3Mi0WH5OjLbGtPoJ4u+oHqfSdiRPuRjRTzg23dP7W7Op9bhDvsd4PSJT8OuBPSzu2vs6e9r1SZ8f9ywhInnsdOiV47BGk7WtbdRyh2t/KkNc9KNAnLqSh8QGFwZi17Hj/N9obyTJxTRU8aTr+SPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3Y8HRThzuSJRfZ793G6ISl6XnnAGNorWktNEfirMgk=;
 b=V9VAWGwFu40yrVfZlJrwjguf1LrccBIdov1qaD64DNcOgiDB0UBu5MR8Kn8gYE6YuZEQ2UO6Sqivl410RXtJ3YqK5c/z1nLIzeSLNsrAOuE64x0Odr/kGACNQSgn2zsrHtgvPGMbS+qLJGqQxD1AhUXYi5fDiLWBZZOkjgJs2SyHbkr4Gb6OmaUD6m2lmKt54pkcCe1MAu6gTTXHqjx8RBNyHoBNUHaVzURkhmK/CWZO8dAss3PSwMgOrl2N7ssBZiEP4gurEWFyhF/NwYC/WeykxAp+Okmk0p0OPgpH89LD5aYzPw/e6p/L3URKVTtstHoyMKlAe9pXGKai6Yd9rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 12:18:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 12:18:33 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] clk: Support spread spectrum and use it in clk-scmi
Date: Tue, 12 Aug 2025 20:17:04 +0800
Message-Id: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMAwm2gC/x2MQQqAIBAAvyJ7biGFpPpKdChdayksXIhA+nvWc
 WBmMgglJoFeZUh0sfARC+hKgVunuBCyLwymNk3daoNu31DE4UXpczVOLthgKcy+s1CyM1Hg+18
 O4/O85jc5rWIAAAA=
X-Change-ID: 20250812-clk-ssc-version1-acf6f6efbd96
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755001109; l=1714;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6JLh9rwynHClF/tGiCfiQNpPIuZrszzf2xHai83373s=;
 b=wPut55Jm8oA7fBd68mgJNaeMGeuNGDikwL6dKgXbhTX4ql0cCELU89ogPThekhbhW8tVv3/c0
 dVbpcqrwUBOCb3uqcnL6nAd7sxf+KN5tgBRb0va4WiATkVIHNfEM82g
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 9890d8f1-c94d-453e-9b06-08ddd99a5afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTJXejFTR3greU0xcmZ0NW1jaFR0N2lad2FDWlowK1p0ZFA2OFJpUWlNbGp1?=
 =?utf-8?B?VU4yQVR3VlM1OVVVVWo0SHdKajRWQ3RseHhqSDFJUzJuVEVwRmhqY1lRN2JC?=
 =?utf-8?B?MzZRcW5hMndVZWpLMitXRDJJMS9SN3ZuZHZGMFdneC9vQjh3YVN4eXBxYWd1?=
 =?utf-8?B?RDhWRkRROXZiYlBrT0hwQU5XYmF1eWVSRFJMNTBzZVpRRzRJdWlrY0cveS9U?=
 =?utf-8?B?cjN2VVRmZE1YS05INVIvbVUwa3Z5aGhGTXlKYmROVjk5L1BvZFcxRWVtbEt6?=
 =?utf-8?B?R24yeC9mZXBvTDFFSlh5ZEZaU3lwekgvU05xZUg1VU9mK0JzdEc2dU5ZcUJk?=
 =?utf-8?B?RGpnRytOQ3o3RWlUbFNsSmxQNHo4b3ZZd1J5ZGNLYzlYYnVtTEVpWDZwVlIv?=
 =?utf-8?B?dHpicHloS1cyUWQzcUdJL0gwL29ubmpRWGxuR1lLck1LVlVabUlnTldTVm1u?=
 =?utf-8?B?MmNBM1U2RDYxMTg5RmcxTnM2eHZBUkk4TXovd2lHcnVWYnQwZXNoMVJNcitJ?=
 =?utf-8?B?Zk1WQ1YvcndwQm44MDBXUElNV3hOOC8ya2RDTWtXenpPSDZWSkRkRUJLeVA3?=
 =?utf-8?B?UHJOKzRVWHY2TWNOandhS1kwNms0QUZpNEZqTEYzeC81UmIrMC90YkV4VWYz?=
 =?utf-8?B?aFFxUGVrMm9laGhNbFBBR2FXTXRGOVFIdnRuRHd3QjA0NUNvYUxGdEJ3UUdz?=
 =?utf-8?B?cVNkam5qSXlsWW9aZDJ2bCtxeEhoNnozVzdEWjgreDFIeGdiKzhTWUwwTnpk?=
 =?utf-8?B?Z2g1VFlsVWExOFRhQ3RPdGlvd21jUVhDSGlESFNvSlpsREl3ZFAwNXgvVnVr?=
 =?utf-8?B?MVBhOURTVVZianpHUHI1ajNpczVOaWoranNsQld3YlplbXdvd294UWcvbGtM?=
 =?utf-8?B?STBEVDhkLzU1ZVFjSGJnYWcydmoxMGx0YzFZTG50VFNxWnIvWFVYYTM0ZGNK?=
 =?utf-8?B?Y0JJckxKbWgzdnJ1Uk1iT3dhNVVOVHI1R0p6UTRtS0lMQXd5c0cyM3VjMHgw?=
 =?utf-8?B?bFp2OERDMktkT3lVMnFMOE00RUFYUVAyY0s3aGVhcDRmaEhvRnFoSzJBUzhB?=
 =?utf-8?B?bjQwN2IvaURjYnptRHFnTVMrQ2w2RTV6aUJrM056QVRoTzVhM1NHNDltWEhP?=
 =?utf-8?B?aWlYaFFpOVUrK0RDQ0RMV3J1aWxvRXd1cFR2TlAzOG9sYkRCVVdDdDB1WmQy?=
 =?utf-8?B?aTFpVG1IWVBsVVUwUGVNRnhoeDVQQUFMNUNHQlVpdWI4K1FEVTV4OTJiVHZr?=
 =?utf-8?B?SlR3VE1iYlZSQUJrWDVpdUNYTEprcUR4ZWtJa052VTlqT3ZxS0ROV1l0MW83?=
 =?utf-8?B?eXJXWEJQV1I0SXZmKzVCQTlFcTI5L1lMUEEydnNxSUt4bXE4Wnlxa29ocGgy?=
 =?utf-8?B?MUtCMXFqU0tnc1FuemU0RDRGSGsydjZ2NW5TZXkwZVB6MlR3WWQrb3pSUjhv?=
 =?utf-8?B?ZXlZdGgwZDROSHJrT0NWbUdoQTFHSU82ZmRVcTlVNFNadDR6UlNSZ2ptaW9Q?=
 =?utf-8?B?NFZwSkRFUlFWYlhzaG5iUy9WTUZiMHUvcjUxdTBqQS9IQ04vVC8vNFh2aFAv?=
 =?utf-8?B?VGZnbDYvT1QySHlwOFphdVNGQzhnc2JaS1ltRDdaM0ZoSWVQeTBUd0t4c1Vq?=
 =?utf-8?B?bFNYSjRGazA5UVpIMFVLcWEvQUJlVksxdS9ZTnEvb3JmZXNjZzVtZlNHVFRL?=
 =?utf-8?B?dDRpUWlJeTJWUEI3RHlZMlFaM1Z3TEQ3N0IxK25oYnlwZzNMcUR3OHNNK1Bh?=
 =?utf-8?B?cno2YjMrSTg4QmZHaEhaOHg1YzNYZk5TWnFna3FmUnFDbU91UDd6aVRJMUpi?=
 =?utf-8?B?YWQvV244cDZ3TkJRRVo5QTF0UGdRVXRFTUpiZG5ZZlg2Y0JYVHBzeXE5OEsy?=
 =?utf-8?B?ZXNsYnc1eVQxUWVqVktDRlY0QTFwQ2tzbTB0RkpBU2JPT3BlWk5hbkdLSklF?=
 =?utf-8?B?aW1Ra1FiY1N2aGl3aDgvR0p5RDZhM05FTE5EeW8vUHUxZVI3MVdBcjM4TUty?=
 =?utf-8?Q?XovOchSSHkPD4ilV6UbRMUD2wwIgdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGEwRE40VlpyVTFaVTlnZHkwdmN5SlJ3SGlFVkU5QndseFRpb1lySFVTeTFG?=
 =?utf-8?B?ZFRRRXM4SkxkdVRYNlZDYnovVnVCK1V0OFBvVFFSaVc2S1ZQREZMWGQ3M2w5?=
 =?utf-8?B?MHZMVU5JbEd3MzNzUkgreFhYU0cxMmI2VHVrSlRuakRvZmJnakUzdVR4WHBQ?=
 =?utf-8?B?SUtLMlNYbkVsWGhwOG5GbGtBelBsaytVbXVXSG9LeDVaRUJLRGFhM3JhZXFs?=
 =?utf-8?B?OVdMUWhpOFNuRUhFY2hVcFlTZHllTTF3bDF3Z29xRVpiS2p2dDRMVmExZmlm?=
 =?utf-8?B?VnFGdHRIUk5DR29uTWhWdStvM2wzMG13K1FkaEk4ZWVrNXBJdFRKWDF1THlI?=
 =?utf-8?B?Z0NYZXFjQWFzVHBNL3pUNmJwaUJqcFJkY0daNnA2ekJSM2JwaUdTRXpxem5B?=
 =?utf-8?B?TkhsVVo4bTAraGNVUXlaQTVrcnpXQ21yL1dGdEFacnNEY09EUWxGLzlhQ3Nz?=
 =?utf-8?B?R29iSVNYb1BsZDd2L2RqOVpVOEU2c2plWHVSN3Jnd2R1WStyWkxqT2JkUVpa?=
 =?utf-8?B?TXA2R3JtMThHTEM1MHBVS3FmN1BiNk9xUC9tTHgwVXBxYndQZzFUZU40eVFZ?=
 =?utf-8?B?eVJraUVTb1hUZTlHQnY1WGFzZ2JnSzY5OUsybHF2NGdJbU16dm14MzhMdVpn?=
 =?utf-8?B?MUJuSFJVOWNXME5qeWkrOGVkOVIrLzU1cVp3TXpGcHJXOFZiVUoycGg4Sks2?=
 =?utf-8?B?d09sMzNnbXR6eTArbVpTNnNXKzV6VCtVdGlQVDRGSGpaVFVpN0ZnMjBzbGNt?=
 =?utf-8?B?cllqVG9zejV3WGI5S1JtMlh5emZmWVFHbmdmQUtXTEhYc2cvYkVlTTJCZC91?=
 =?utf-8?B?WkdxNjRtcllrbStrVTU0b1Y3RnRYRi94VldPWExMck5QWklOalBnaCtLdDlF?=
 =?utf-8?B?MDhCdGFvQXFOUUNCU3VSRDUycGJMRStuM0krVDNWZWcwdVRxcFdCRnV6WjBE?=
 =?utf-8?B?NTNEcTZYRE8rNUVRc3F5QVJoaWZBYTYyTS82Rnhlb2tSR2RyUG1qQlFSOWZ0?=
 =?utf-8?B?MWlmTXpkT0tuWklCcldZdTVRZ3lhVWVpMFFvdXArR0JtWTYyM1pxTnNpc3lr?=
 =?utf-8?B?eVdUL2dvK0pMR2RqVUp1VzNTbWhqQlpoL2FZalJkRVdEdTF1WjFQWm4zZVdh?=
 =?utf-8?B?WDh5cW5VZ1dBSzROaUY2d2ZIeURKWTk3U1BwRWNuVzVDeUVDV0QwRUJ5UklD?=
 =?utf-8?B?R0Z0YlczS1BQbnRCQXBndnhSUER4VUNVK2JKejVGQmFJVGxGS0NPaFlyZGpx?=
 =?utf-8?B?NE1lYXlLZmhUblR2clo0M2w1MUpSWTBpSFNHK2hPZGxMY3JnRFRyQkU5bWlU?=
 =?utf-8?B?T054OUtHeTVMNWY5ZXI1cDRxdUJicGVMTlIxSEMyaERFNzdWM2pCbnc0U05Q?=
 =?utf-8?B?YU5pU0cvU0E0dW5xTEVjZlBIMFhWazdoMjN5RkNYWGpiNmZQMFJsWDFHeDJF?=
 =?utf-8?B?UzdWc0RETUtENnVaSjdPckQ2NVpoemhGUkt4ODRNYjY1YWJ3Tk1Rb1RjRUha?=
 =?utf-8?B?blpXZGhCUmF6TnZIYTlOd0ExOWZQQ0w5VS9aRzdINFY3cTFOZlJRa3lSS1Y4?=
 =?utf-8?B?SHpWRGRVcGdJRkVsR21NWTF1UUtCMTJlYTJTQ28xaEVsdktVMUxPWFdJN2ht?=
 =?utf-8?B?cDZocytTdFROdDY4UFQ0am1NdU9DbEFNR0NsTHJXajRvbzQrOVR4d2lFbUk1?=
 =?utf-8?B?b2MxNnlrN3lscndYUEV0K0VWcC96OE9vN3pXaUdwVWZtM2ZManRESWtuYlk5?=
 =?utf-8?B?WnRUd0t5bDdrc1F6WDZoYjlDZG55Z3FoeXozcFU0NVJwQjlvMWpWMHBKMHhZ?=
 =?utf-8?B?TVVYYTNCdE1Nc1FTc2c3OG0wR0hmendxVmJxUjBPRmJjb21LQTRMendjSFZQ?=
 =?utf-8?B?MUVPWTZRTHg3SEh1aklhaG1QakQ1ZCtGaVVNdHova1BlUktUUUlxSmxCUHpY?=
 =?utf-8?B?aDBkQ3YwbnFQWjYyU28yaUxzb24zL2htUlJHR01rSmpoWWJsb1N2QURyU2lS?=
 =?utf-8?B?aXAwSGgvb0lTd1FBdmJxLzZTNFIvbWJLMGlHcHV4K0VuM05yNWFyZDVSNnor?=
 =?utf-8?B?Mm1OMGl5UGJ2b1RYZnpjVTBlT2tLV3RVakxDb3dXK1FpUFRLdmwvdGw3L2p4?=
 =?utf-8?Q?hYv5ZSDzag1lCmL1INI5NY8TY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9890d8f1-c94d-453e-9b06-08ddd99a5afe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 12:18:33.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaWsahIMZE2AoKjjv+tSSuH6K4wVnipxpDAkjwAmdZWN6/IAtd8KUhgtVgk4nLxMhuC6eMZXzxcF84FZ/9orVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721

Since the assigned-clock-sscs property [1] has been accepted into the device
tree schema, we can now support it in the Linux clock driver. Therefore,
I’ve picked up the previously submitted work [2] titled “clk: Support
spread spectrum and use it in clk-pll144x and clk-scmi.”
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
Peng Fan (3):
      clk: Introduce clk_hw_set_spread_spectrum
      clk: conf: Support assigned-clock-sscs
      clk: scmi: Support Spread Spectrum for NXP i.MX95

 drivers/clk/clk-conf.c        | 70 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-scmi.c        | 64 ++++++++++++++++++++++++++++++++++++---
 drivers/clk/clk.c             | 32 ++++++++++++++++++++
 include/linux/clk-provider.h  | 29 ++++++++++++++++++
 include/linux/scmi_protocol.h |  5 ++++
 5 files changed, 196 insertions(+), 4 deletions(-)
---
base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
change-id: 20250812-clk-ssc-version1-acf6f6efbd96

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


