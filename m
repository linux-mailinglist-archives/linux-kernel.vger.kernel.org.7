Return-Path: <linux-kernel+bounces-816367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC7B572E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF73517DD70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB592F0669;
	Mon, 15 Sep 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZsBG073u"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A602EFDB3;
	Mon, 15 Sep 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925026; cv=fail; b=kdD9gdMuG/eG9pDkUZTWyLd76qRDrwg2Xk+faC1jXwj0T1xI7gbu1JzCbJibcC0RxDygGFGfy5WhzkNA2Z/1QVOlTmC2dh35XF8Kbe4/h+AUxjiP7X5SOvgxdQTsxKfuD2tC17cYKWKyCgl4O8RIygHeIrSus0ISj1SHTXK8AlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925026; c=relaxed/simple;
	bh=I17Xb29VcyG1oCK3pFyzRbdd71w9Np9N5n6LjhrfWaE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hEZ02TUmmIcZ/Rc1Fl6NjnjI0kSd7WUNslf9fj/XVooQdi+tJHxVH0F2O9AlqU06atHXEi9I+yULsjfUtT8Ar37OvIgVI+9uRgKwYLTyJamPh4NX3s7UxaPRXk1Dqhcgzq0mqKuu3TyOOXyZdluVYaefXoPPsQqyxo3QUx8BO/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZsBG073u; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVzZ7tHQfMNzlrGE4GqdTSKmgjpvS4RVCz/FsZsiNqWxMRDmKVbtxqzfCSlRv+qfWnEH0b6A3G6xpKK12zyhL3A/9E5LsIwdu/3gTHXG58dKH/nJQwO72n3dI4q/BPs06g1LVUstifUEzQeloviavgcx9HuDT9VdnGly6zolLTOi2kF0IRWzaKKqWY69d+G8oNgYV4qAFdQ+FTIZNK2OrcFVxHFv/su5++Mf4fn0UQh/KjhUb8Wk8izcXBH6uKJcl7pMkTlSLMdVMskxvezYAFUSr/ipqZ3XOsv1Eq/oJfIge+ngMTT4VtAh/MhYzTMYcK9Dwbhakh4Zcyk7ucFcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weyMYf6SsoI2Ue9pRNfYZJGFm3D+kjesDnqv6gnMlRM=;
 b=LUp8ixVqN9oBPyv/nR2mCGWw3iHnMI9i9vWr7fLqpQFykJAHm/b0jFISp0AFtNcTi3B/kJQAdf4OdhT/Chq7h5fEjokWmby5OOq+jz0wG3viVYWmiFaSs6EGmiSycqpCHJ5jOYkEeO7ssloAUwE0w6EHGPj9P4iEtTGm81IFPu5P7PP6HI6HEGrYrQKrsFqYzwP2xkbUEpjJ8amiv/ybv6qnNUpbtHEAbPSPNR4/UmrcazgNsnzEqhkkqYtAqApdnxpb418t4y6BvD2ajVlA3nA82tlz7jergjUbsE6g1zELFntuSL6rjk+TNoz650X6gbnUw0QcIOCaBkjm/t6kbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weyMYf6SsoI2Ue9pRNfYZJGFm3D+kjesDnqv6gnMlRM=;
 b=ZsBG073uiVRpf6VqhwLPjVxtJQepKNpCJg2alLFN3ENurOZAeBIAEJYByFVd6D6L6/2US7j4WioBpdKYFdA+TqPU4RmVEzcYQ9jU3/jx9IV+ez5eZ9E69G6rXxpVvnI813L/x8C+HVzbdxq6XBjgd2fyG+Tmg2p990knksRXIdHaHoJa64UmTxtgZ3wCIkX2fLWD7GCgWjg+gVHsNWUQ2qiGKGMfQiuWlMDqLojsxmJ5Xoi/rfyZlbrKK9u8VALNggI+y+L4h22xhObLKAcnh/57tiXGIwsNLrFMcyiJWxAiDOCQdSOR9ylDnwtzRN3CBMCDWbBlnO/hmiSWLfZmPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 08:30:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 08:30:21 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 15 Sep 2025 16:29:36 +0800
Subject: [PATCH v4 2/5] clk: Introduce clk_hw_set_spread_spectrum
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-clk-ssc-version1-v4-2-5a2cee2f0351@nxp.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
In-Reply-To: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757925004; l=3530;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=I17Xb29VcyG1oCK3pFyzRbdd71w9Np9N5n6LjhrfWaE=;
 b=7g8uq84J+3n2iGC89xXdOaqKUg/KG1eXkcxtM+jtqoCh9hUNIdjhowTZUcW38Ryofl2EHo6TM
 /N/UrZclfDCCaH1jsjzc8hKpNZUdoZWzB6J3CCdBpaWiBIH5TCcuWS4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fa31c0-7c34-4fe2-ee1e-08ddf4321be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXJtaEJMV1l0TXIyMUtUTm11d29aL21PMG9oQ0pFSGxWVHBzbXVtcW83NUZy?=
 =?utf-8?B?Tk1HTktHU0plZVExU2xldTNXVFkxeG9Vd1NaQWpzUW5PaTgvRWgxclRuSmdl?=
 =?utf-8?B?Zjg5UFUyYmJONnZ1dCszTGJGYW45UldSeTJKeXNVNnBQZXdxYm9tTkR0U25E?=
 =?utf-8?B?bTlmUCt4K1I4bmJBemdRRHVZeGVnbUovVWNjSEJ4YlBFcWNkRzBjdTdtZlIx?=
 =?utf-8?B?UlM4QXlNM3RnTXpsWmZSRkFFY21WQ1VsR1ozQ3NLMHh3bEVKa0JJcGdNbWdE?=
 =?utf-8?B?UjFMYXQ5Y24rUk1VYkxXME1RY3VwZEtmK0pLYmdCTXE2V1ZGbjlYVlM1c1Uw?=
 =?utf-8?B?Q3pXMDMxY09FNE1vQXBXR1F5Rk8yQVVOYXRxakFFQTlQOG91aXBXNjFMNWpl?=
 =?utf-8?B?dWtpMVRnbFpJWEgxRUpFSmlTS0dlL0hQL294cG5GcVpDUlBsRTgwMkY1cHJQ?=
 =?utf-8?B?ekMxQ0JZUldYbWZUK01ueElCYm1tYkRLNGlaRWpIL0N5ZE9jbGg5SE1FWnRj?=
 =?utf-8?B?VkFBem1QVm9rei9RMFBlbWRXLzBCMUNtL1FTT0dHZS82MTI5MkVEcFVtQkRP?=
 =?utf-8?B?N3lic0NIS213QUVUeURuL09JdFAxUXhiV0VXYzZlcE9SWFI5ck9FdkpFOGMv?=
 =?utf-8?B?YlozYXR0bGVzOUE3eXlnNUZTYU5JdWk2dGJVT0R5bXB5V1dsWDRkMDUvNmVB?=
 =?utf-8?B?M0dpektZTjZ4TnUzZ3JSWTlrL2k0cWx3T2RoSkY5QmxmYVJDR214OElkUW8z?=
 =?utf-8?B?SGNPeGVOcFg5YjlRWitRNG1lcmVEZUJ6RmNzY0N0cmgra3FHMEFBQUJyeUdD?=
 =?utf-8?B?S1RpaGg1b21UbWxrcHovZk9lRXo3OUJSMmRXOHhQUE1FMVlSL0xzSGVHNEVj?=
 =?utf-8?B?QnlWM2M3L3VRVnR4WjFQR3A5NnI1WVBweUpqWEgza3FMSG1sRlNQVzIyMEV0?=
 =?utf-8?B?WCtURC93blBodERsbmFZUFh0Y1JFYzRXdVBaY3dUTEFJNGV6WkdrU1RaUmwr?=
 =?utf-8?B?RU9UaUhtN2ZwdUVuRkdiejVRUUpoeEJWU2hadFEzMmlaSEpKMmgyREVKUTla?=
 =?utf-8?B?RUMvU1lvYW8vSkVEaW9HK2pYSzl5WnY1SzZoNDREcHU0WEorMjdRM1MzQXp3?=
 =?utf-8?B?M0EvS2hGWUxPeHBCR0hVQkw4RlgvTHNxOFdaZ3RUVFh3a2tDOXJSS1d1VUZa?=
 =?utf-8?B?dk1IWjZBUG5xR2o5ZWtoUldaK3JhT0FVSXEzejFxd1ROQ1IwSGtSLzNPOFFv?=
 =?utf-8?B?cnNyS1pxRU91QTliQ3d3Wk1ma2VFWVcrYTJwbDZ4RUtqT09kbllEUHRwcWV6?=
 =?utf-8?B?Sm5aRjVDcHFuNm5ka3RyOHNnZ0wxa0piNWtjQkc1aHZqZzdwZmNqQXNadUpm?=
 =?utf-8?B?YUdKMmdBUGJJRjlaNkZPVU96b0pIdHZmV1pWWXRuVlBXYk9qWjlqbHVwL01G?=
 =?utf-8?B?QmVlTXlseTFQbFJ3QzhLRDlRU2tjVDdqdW9Qa1V4TVNJQng1Z3RLQ2VJbyta?=
 =?utf-8?B?YnIxREVDbGxQVXFKYXdTRlBuSVhnQ0pHZ3dmekJ3SVdtWi9HbDl5dVB1NTlj?=
 =?utf-8?B?Njkwa3BUUk12bmpDYlBFcHJiRFFFTFNGRTlYK1ZmQ2w0dEMwQk1hWUhpZXBp?=
 =?utf-8?B?cDZWUG9kWlNZc2d0MS91MzVaaWtlaXg2QVNKMkREeW5TUlMrUjRVV1Q0bWdl?=
 =?utf-8?B?cmdxTkQvUnlMZjZDdUltZVRPcFIvWWNMSU9QL295S05ORGxtc1BHelc4RnVY?=
 =?utf-8?B?QXU3MzVHaFNsdlAwUUVHQTkyZnIyVlZ0MExyWGtvK1ZkVVBmNnhpZkNGNnVO?=
 =?utf-8?B?d284MEZmT0JUWGEvbFpaclFhMXBDam45MTlqN1RES2tyR3ZMdk94b01zQzNx?=
 =?utf-8?B?MVh6M2t6YllXdzZsUGNYQ1h6dDhDNCtOL3hyY2pIa0k4U3YveWdDbGhhbXg3?=
 =?utf-8?B?NERDWVV0bll4NWJUV0I2WGQ0a3N3cGtBbXloNnRZMEZzdnVmWWtrUGtzMVhu?=
 =?utf-8?B?KzZHd0Y3WDlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDBPQndpTlJNT0oxRm5RTXZzU3ljLzdBT2oxeTIvUER4Z1NxdmU2RzFiaWsw?=
 =?utf-8?B?dTBnNmtaVERUdnRQYjBsTUtEMThNWFp5V2hYeitZYmRJbnRCNEdLVWpOYkxa?=
 =?utf-8?B?bmFlenBHZ3RmOXlIL2d4Mk5DMWxsR0RQT1pOSHhnTSsvWGowSEVqZXBXeDFv?=
 =?utf-8?B?MVRRN0JwS0dhTVRIY3FYVzhPSkpqejV0dDE0OTBDdTQ1dWtCNHp3M0c4dzFF?=
 =?utf-8?B?SnB6SWlxUVRWa1lEb21KcmtZK08vUGZvRDBKM2M2NE80R0Q3YVpXaE5TWm1v?=
 =?utf-8?B?L0x1R3dCS1B6cW00c3pTL2FraWx3Qk5VUEFVejZ4bFo4a29BNmRvU3JYY2Fu?=
 =?utf-8?B?dGJ5cmlqNHpSZ045REk0OUlYOEMyc2Y1WFljaHNTN2VaY0MxUjZ5a25XOXU2?=
 =?utf-8?B?TktqY1N1bGZxbFZhaEVNME4rcm1kTGJYaVBNT1V0UGk4MzZBSUNVUE9GenFw?=
 =?utf-8?B?TURTaHNkS2xnSHRLOEh1WFIxdXlMWDNiMEJkczRnazFPdlNFS0RZZW84VVY1?=
 =?utf-8?B?MVRoNTlSc1p3VlVwcWc1cHgwMjJPUlRrL3RtZksrNFZJMnl6TmIxaVVoSkxH?=
 =?utf-8?B?VG43djZnNCtLdnZPVm4yamZ6bXIwYnlaM2NDbjFhTEhIbEszMzhQZGRHVmJN?=
 =?utf-8?B?eHpwbzB1RjhRL01OQmVIWDFRbjdNaEZMam54TkY5c2hhNzNJODlVdWM5bFFN?=
 =?utf-8?B?ZTVIVkh2V0VXRTNFdHZVbThUUDRxYWFZcWlVVDBsUWVZYjgwcm9xUGhMQlZB?=
 =?utf-8?B?SHZqQ3ZmRDR6dG85eFh3TFA0TjFEYldwQ1gzaHNxcFZjTWl3T0c1amNLUlpi?=
 =?utf-8?B?SThPenIvR2p6allWVWNUT1hWK1VYMzdaU3AxNXIrcGhwZTVxZUlibnlXMUNj?=
 =?utf-8?B?ZGovY0pBaEw2bElGOWZYeGJZTk55Ti85dDdjbFVKRXY3cGRzUjhRSm5KTDNX?=
 =?utf-8?B?b0pCRkdSTGRJRTdyK1ZCU24yR3hZMnltY3g5am1qWmJqakErTkN3SWMzeDJD?=
 =?utf-8?B?TDNJTFVXMXNhVWNQK2lIOXczRDVCTHIrWDd4TUdDalNkU1FtTVhPSStabmdM?=
 =?utf-8?B?ejQxb0svVHYvZWFIMVJ4bkRNdFl4VVEwNlZVL0FTUUVON3Q1OXNvY0EzZlo4?=
 =?utf-8?B?K1VxR3gzMHNCMjR3K3BOZEs2NHBqY1I1eS9RcnR1ZlgwZStvbmgwcGxZeXBa?=
 =?utf-8?B?Z3RBOWZ3WjlZaXZtWUpjMnNRMEhVaEovU0I1b3NxQjRPQTNiTkhOenpNZVhh?=
 =?utf-8?B?bHdhLzJSdG9GVnB3eGhMWWdnZFJBYlNXUEYwTGs2R2pQRVFTQ2Z2MEE0YWNq?=
 =?utf-8?B?QWpmY3lPSVNKalpzUkFwRGpxUmFmNTg0YW9sNWQ5MkVXZVliQ1Z3TnpRbytp?=
 =?utf-8?B?UGh1cGdVWGhTTUU5SEFCU3h2dThaa2NxN1gzbFJhVWxnRVVJckc1dnQ1MnEz?=
 =?utf-8?B?bXNCdk5VdnpwMDBFVDhkYTJjT2plZWFYTTBMa1ZPVmNaczRsZnNzVHlDOVYx?=
 =?utf-8?B?VExFZFRIVk84VzYzZjNVTFgrTENJR2R5WWpNeUFRbnVCcGt3QlBOOFdrZW9k?=
 =?utf-8?B?cDVPeGlKNis4OTBSUlRsbmRxRTdMNENER2RTaThIUllwZVBjOUR3MWcxVkxt?=
 =?utf-8?B?a2ZkV2g3RTBTQ3Vubk54bG5lY0U3OWhqaXpmVm9Tc0VYbE1vMU9WMFpWemht?=
 =?utf-8?B?UnNmdmJMSE4rbDJmdElYVTNheXJrYWlvdkxveFZEWnlkK3grUFdkVHFWT3o2?=
 =?utf-8?B?ZUVOcTg5eHIyODU5NloxdzFNTjRFMi94VGx2aE1ZaDVvQ0lkcEZ5ajdocXdD?=
 =?utf-8?B?akVWbHQ1R0hPYWJVOEl5S0p5a24yUlY3U0pOOW9Md2dQK3RmQkx5Q2VvSnFM?=
 =?utf-8?B?VStGOFRKRkFQYWVxUVRZZ2E2VXV5OFFPY0s0eWJ5Q2Z0VDFMRURFeDBMUW1C?=
 =?utf-8?B?RjlyNGhmK0lTeGZTaFFYVkFJV0tpU25ud0hXMFZQZ1RpM1VFaHBuRWpKaEtE?=
 =?utf-8?B?dHFKeVdZNkRMeGdtYTlvaXluaUFlaFMzWDd4azdjaTdlWGVsSmNKa2pBRzdr?=
 =?utf-8?B?TFFwWFlMQjBaUFRpelhEZWNER0NNUFRNUkpyOFZyNWU3MSttUlNsaDhHM29j?=
 =?utf-8?Q?ZcEBJa5EjMUmKv4b1QXvd4zBz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fa31c0-7c34-4fe2-ee1e-08ddf4321be0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:30:21.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOJjSD8gzoUOWVtSaHNwzahQBYqBoKKmgLjqcBCttSTTBfNpIDymeEuqw4IdAJowsImvxViSagjE/qgAYWExOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181

Add clk_hw_set_spread_spectrum to configure a clock to enable spread
spectrum feature. set_spread_spectrum ops is added for clk drivers to
have their own hardware specific implementation.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk.c            | 26 ++++++++++++++++++++++++++
 include/linux/clk-provider.h | 22 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..06db8918a1b35e3280e565272bc4603a88295a92 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2802,6 +2802,32 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_set_max_rate);
 
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf)
+{
+	struct clk_core *core;
+	int ret;
+
+	if (!hw)
+		return 0;
+
+	core = hw->core;
+
+	clk_prepare_lock();
+
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		goto fail;
+
+	if (core->ops->set_spread_spectrum)
+		ret = core->ops->set_spread_spectrum(hw, conf);
+
+	clk_pm_runtime_put(core);
+
+fail:
+	clk_prepare_unlock();
+	return ret;
+}
+
 /**
  * clk_get_parent - return the parent of a clk
  * @clk: the clk whose parent gets returned
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 630705a47129453c241f1b1755f2c2f2a7ed8f77..4f48a4df95a1c54638a0e91e0a449fcc8aa40b80 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -84,6 +84,19 @@ struct clk_duty {
 	unsigned int den;
 };
 
+/**
+ * struct clk_spread_spectrum - Structure encoding spread spectrum of a clock
+ *
+ * @modfreq_hz:		Modulation frequency
+ * @spread_bp:		Modulation percent in permyriad
+ * @method:		Modulation method
+ */
+struct clk_spread_spectrum {
+	u32 modfreq_hz;
+	u32 spread_bp;
+	u32 method;
+};
+
 /**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
  * be provided by the clock implementation, and will be called by drivers
@@ -178,6 +191,12 @@ struct clk_duty {
  *		separately via calls to .set_parent and .set_rate.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @set_spread_spectrum: Optional callback used to configure the spread
+ *		spectrum modulation frequency, percentage, and method
+ *		to reduce EMI by spreading the clock frequency over a
+ *		wider range.
+ *		Returns 0 on success, -EERROR otherwise.
+ *
  * @recalc_accuracy: Recalculate the accuracy of this clock. The clock accuracy
  *		is expressed in ppb (parts per billion). The parent accuracy is
  *		an input parameter.
@@ -255,6 +274,8 @@ struct clk_ops {
 	int		(*set_rate_and_parent)(struct clk_hw *hw,
 				    unsigned long rate,
 				    unsigned long parent_rate, u8 index);
+	int		(*set_spread_spectrum)(struct clk_hw *hw,
+					       struct clk_spread_spectrum *clk_ss);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
 	int		(*get_phase)(struct clk_hw *hw);
@@ -1430,6 +1451,7 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 			   unsigned long *max_rate);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {

-- 
2.37.1


