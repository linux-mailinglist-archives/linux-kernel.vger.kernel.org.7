Return-Path: <linux-kernel+bounces-856537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3C0BE46D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB4F580588
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11652329C61;
	Thu, 16 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X54YbZR3"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AF1C5D55;
	Thu, 16 Oct 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630424; cv=fail; b=EHJF8n0nX/aBzxMePlzgV1r50QtuYwhqgHGdJ5NVU1e4o8Nd8zQwMFtqcOp3zq9luhXYrJ2E0bpeDJs39XdPvGv7VK0rdBfUWNdnrgSfytuikuJplc7IfKPsCkaT/2Jm96Br5gbqb3RzpDPGOKu4ipXcopjEcjYtgrhfBh+IUnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630424; c=relaxed/simple;
	bh=SLJMwS98s0dE150j911idg8zNnQzcUe3z/XHkeI82I8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PhX//wgeGxKMoH+wY22QFM92thoJAtEOtWAJBLqfrJjVwdWFzjzfP4LkDZdw9w+ZLv3BKXjuRuR/QxyTjctvt0Nknc5dB+fd2hXWs6weX3L8wIjHrtQY1mBHAM/tQigK8F4CQdZTWyzsPvlVxkmdIB3wI4Va6kecOuaYTD1IlVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X54YbZR3; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWCs1DdRDt05PBl2RujMVDDK+LEtgT065IrVvJq8pMHbe8PmibQWRhfvD3vEI3wAciMecsNnda3EvST6OO/SDa4o/xr7jvx7Zccj2V8beuWRpviL7hwAkiDTHrOZ2GPw/EooP+P1okpnxS2ZcS7F5n84dgGuYpxBERiQZCktSj21KTR3Jrdn/DRmC28VqkQafhaei4j9sGFpLoSX3nY/CTTVZGiVeFkdTanyEp2O6VbsiYFyobHMNNigI7anHUki8ztGLEZcGCXHuxyXuuaQxFirNmbsRWE5kE46E1RqyEyv8XykVBhafN+r2y4tUmlK2OFEdjLICPuLVkLjDUaBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r7DE6GCA9gKwj6LLhE9/KJ7rGQ9hF7bw70QyLsJQ9k=;
 b=r5MXyK7R9DpfPItDDtr42RODoABP5RYN7BUmKyybctlO/jBpU96F/EgWW6dT6W1nvEJp0D7z35QgMpCEzQzsF22k3FMicKdl0VHZw6XLQ+h+OQKiVFStJgqob9xMnPT5m21FeiADZ4LPqbmCWcdQzxQup75Ue3L43JDOhnQ1A+ok4SX+AN/kwWBTWf/rJncaufkFbtx6/AI/oilWnNoQrvcwDVvh1uwOmssrWZSOTp2Wzr5T4dpp+AQGniVzAwm+1OcXpmqdpxFNIiwLs367c2BEuUpTwcTnP2nbOriD3DFH8moBcZ7j+/iobnGZcf4HwurUVV+OI0DOXuOBPfR/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r7DE6GCA9gKwj6LLhE9/KJ7rGQ9hF7bw70QyLsJQ9k=;
 b=X54YbZR30lrQ2fokQUF30NmwCNn+/UNUY1qsGIKF57Yxw5uE1e7WW0J5xB/FsV4xevHH4hhOOey2YAcKfNUtjEWASeRK7jrPAqgB1rrrml9RHjDa9nT9ojfefg2pRoGx6ryLc2fzZTqKvduVJEvnzVtulCCa2fBX93jGPEWxnrK4+1GaYG9EwBMgdxBrpmi+bNmlUXuEQJgs7rlMe3m9uW6qY9OR+P6GaA3/BmntD9V9nGbpmbQw6qP/Y5qczymX129tLhX2e9KTLVKkWjsdzp4Qr4paciyVrN6DRzMI4Ixfuzdu7uDjIPZ/pxMP3HhCPjnxSgacg4XQFwg98Yhn+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA3PR04MB11203.eurprd04.prod.outlook.com (2603:10a6:102:4ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:00:17 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 00/11] ARM: dts: imx6: trivial change to clean up some
 DTB warnings.
Date: Thu, 16 Oct 2025 12:00:04 -0400
Message-Id: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQW8WgC/32NQQ6CMBQFr0K6tqb9QCmuvIcxBNuPNJGWtNhgC
 He3sNCNcTkvmXkLCegNBnLKFuIxmmCcTZAfMqL61t6RGp2YAIOS1VBSM8yi0VNo1ANb+xypQN2
 VObJaCSBJGz12Zt6Tl2vi3oTJ+df+EPm2/olFThmtCplLpjXTAGc7j0flBrKlInx0zvgvHZJe8
 LYCyW+1VOKrr+v6Bu+UpG3tAAAA
X-Change-ID: 20250925-imx6_dts_cleanup-6edf53e09c62
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630413; l=2396;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SLJMwS98s0dE150j911idg8zNnQzcUe3z/XHkeI82I8=;
 b=2FzhS42Rhu7yMhYIJSSk2N5CpwQzyKaer8wvC3jB++roPih08tTLhJB2RGQ/bP9Muc3HtQK11
 yLkAMR6nfS4D+ub1dxWJiLnBpUTWOu2vKJJr5A2dr3Yl8n3Dd+ynOHU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA3PR04MB11203:EE_
X-MS-Office365-Filtering-Correlation-Id: 91094a1b-d9c6-4cad-ab0d-08de0ccd1996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3g1MUdZUGZlMkxTV3FCeGRNN3JDT283VFkxK2M1cDh2dkdSaFlmT1MxSUhm?=
 =?utf-8?B?aWZBQlJXWlFSZlF5cXJlTloxZ2djaFBkUVRVdXQ3STYxckh4TFpUVVNqbzZR?=
 =?utf-8?B?Y2lrNkRlMlM4TlQ2MHM2RllVUXhmUEJRdDhTVVJYd2RFRU5FdituZUMvWnox?=
 =?utf-8?B?RGgzV3lCc2x0QlNrQzhiQXFIWVdnVkVndEpTTzZNNkJBaUtxL2xKajJMUldL?=
 =?utf-8?B?bkMwSTgxU2hqWWVVZlAra1BDeFVkWW5rcGt5cmFvMHAvNFhKL1FsMHlyeXVC?=
 =?utf-8?B?b0xYSkNVSXRHUGszTCt2Wm0xTlRoKzFLa083OEthV1pSMEVzR1FEcVZybGRx?=
 =?utf-8?B?NXQ1UDkrRzNlWVhhN0szUHk3bXFMcERjb0RrZFRJSnorWVRwNHJiZWN5TWVn?=
 =?utf-8?B?amlOMnMyS0EvRWp2SzFsa3Y2aUVMY2p0WmZoQnBqa3REcllJS01lQi80eEJz?=
 =?utf-8?B?UGRmOFlGZmJZeENGSGdvRWVVVHJDWnJQQlVIZmhrdFN0d3FoS0t2RnU3V3VF?=
 =?utf-8?B?RHMxZ2JiYVlXdVhqeTNUZlFwZjJHdVFwSkFuQ0lmQkdmTmRtRjQwS2pVZEdw?=
 =?utf-8?B?MWdVUmlFRUlCZkU0MXlLWURLTDBuRFlJeVpQNlZpU29XTCs2aS92QXF2ZU1i?=
 =?utf-8?B?RzFRY29RVWI4QjAzRldTUUxGWS9mbFJwbTF0eUQ4cklWRHV2Ukl4MFpndFhQ?=
 =?utf-8?B?WFQ1akJIQ25DZEtMQ1d4NXJNYlZSZ1pkQUJXZXAyV09tcEFFUVdKUGJ6c2dS?=
 =?utf-8?B?SlRTMmRUV0ZXSFFPdFdTNmtTUTRURS9NV3hITVk2Q1RVN2JsY2JoczU2aHVu?=
 =?utf-8?B?b0hUM2xqMjlXQzBwVjJQTEovenlWWDhnQjJLcTRJWHhPZWJhWWdBVEpMd0pJ?=
 =?utf-8?B?WjJsUVUwRDlZQzM0RHRVdHUxQStwMFZOSTFxc2h0bW50L1ZwdTlTcHhEalRY?=
 =?utf-8?B?b1E2M004U24wUTVWVlZBM0l5M2FmMkZTbk1ma2szQmhXSm5NRjgzSURJWThG?=
 =?utf-8?B?Tm9JRUFsYXBOdDdQTzNpRjFRSWc0ZHp4eEw0STVqZ2VZYXVpNGEvK2JubkRs?=
 =?utf-8?B?ejJ4S2hmTG1CSnBTZUR5eVh6MWFDUkpXTnZHM3ZTRDVlWm1LdnlGcFBja3lH?=
 =?utf-8?B?d2lBM1R2SGNXaHVWdjlnQ2pzR0xhUmxPQkZ6VUN4dmxpcFZCaVNRQ3lzYkpF?=
 =?utf-8?B?WE1ZeXJ2ZXJndHZDRm1LbVFyRGk3bDJPZlJwMm14ZzByb0w5SkdqeEpHQmEy?=
 =?utf-8?B?M21Pd0I1Yzh0N0lvSDNGQ1YyV0xraC9XSGs2VkhhU1B6VEpMejZDaGRKS1Zm?=
 =?utf-8?B?L1hwbGJtUFNpSisrdCszK2FJZ05reVVtcGx0UEhlZE5IZFgwM3NvQmlHZVRR?=
 =?utf-8?B?WThpeWNRYk9ORFNlQk5xMXhIZEtDNk02YnRLZDFHZVFtNzJzQTN0RUs4bHh6?=
 =?utf-8?B?WWZLazcwWDJjbnRUMnFmOHN0aDRJU2pha1M3ajMzMnk3RzluRkcvbVN3U3lO?=
 =?utf-8?B?RGYzV21pamhiZDlkRnRNeEdObEY2NnA0eW42YVB2MzU4TDNBTVh1RTRDSU0z?=
 =?utf-8?B?SU5ZWkVLK2FNVnRtaW00eHIrUVFONkpUS3V3Mm1WSXArQ2g4VGc5amdHbzI4?=
 =?utf-8?B?QU02ZXN6VU40ZFdMQXhTYS95eXVwNHF6M1ZacHFCSTAzT2l1QlArWmxLLytq?=
 =?utf-8?B?MytoWjNVYjl4b1czT3JPNmpVdEFwemFqSmpjRDFaakoxNStId3ozY1NKRDlE?=
 =?utf-8?B?dGgyVy8zQlF3V3lmbGhyMkhLSk9icFJURTNPS2x1R01WbFZRbWRuZm5QUEh1?=
 =?utf-8?B?MFdWSXhLRVNMcU1HdmZDWkVrMEl2aVUrVDJjalpaMXdUWVFkSWV6VHR1MXJ6?=
 =?utf-8?B?UXlBZ2dKenBCYXNXSFRjM1p4VHVPRHcwNjlPQk9FSlpnZjZxNE4xUXRZSklC?=
 =?utf-8?B?Z0VRbXczcjFrU1dhQlpvd0QwNksxRXJRUDV1aW1aRmVUbWtsWS9ocU00Vm1K?=
 =?utf-8?B?RGtqV2J1ZEpzVUZ2OEY5VU1yaHBUQ3JydGI2b0MwLy9JQzlIV1Y4b0lwd05B?=
 =?utf-8?Q?x7Aki4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmFUdkt3VlZpNVZ4L3k2SnVvZzVUWXBQWW5iUCt6RUFBT0pjQ2pKKzE5cENG?=
 =?utf-8?B?YlBsTVlTbWo0NEV2a3BoTGY1RHNjNFdTZy91aSt1Q3lNRStzamhoK21hUWFT?=
 =?utf-8?B?WWZPYzA1Znpycnc0VGdjdnEwYUsyK25UaE5NNllIdEZvM1FzSDJxdHJCU0Ri?=
 =?utf-8?B?ZnR2VmRnVHR6eWR6b0xYMCtQeG9NZmkyL2ZPTlpMVXl2Vkt5aENCMXZxSE5B?=
 =?utf-8?B?TDJsSHBmSm0vQVdYSjhLdUNFTytRci9tOWlpQ0RqWGlwM1g4eW9za3E0eCt4?=
 =?utf-8?B?TUlpTXVYRDNsazZZalVDbkpyMS9neGZhbHFPaGlkYWRpUWJyRkFJSjJiM1pu?=
 =?utf-8?B?L0o4bEhQME1yVDZHQkNwUXZiTlMydWlQRWV3ZDJCaVE2UHU2TzFrcC96b1BQ?=
 =?utf-8?B?RnJiam5xdzRGTHY3WHVsYUtDcG50cDNzOGlkQTh3WDNkZ1doU204V2E3Y2Vn?=
 =?utf-8?B?TW1vU0tJcjJCM3gxcytuUUJIMGplVTRCeEVEeld3N0JHZld5RjJOeHRRdzNX?=
 =?utf-8?B?ZThZVjhOMzhhSjA3YkoxR3J3SXJ4enVwd2xQaG4weWl2bmhWLzA2aG1Rc1Mr?=
 =?utf-8?B?Sm1VTTkxQWZzUGJEY2VCSk1HVmxCcFpKMGlwSUlyRXRCZklTSmpGSE5BZ1o4?=
 =?utf-8?B?ZTBjY2xCZ1EzZkxIZXRpVXZiTmNkRWkvdUdXS2Z2UGhia09ZR2hpRm9Dencz?=
 =?utf-8?B?NlAzUG1DR2VNcFd0TTRoQ3daMTREZ2lpLzA5aEZtdmt0SmFmNk1aL3dnK01R?=
 =?utf-8?B?R2oxUDhTaFpPY0RCbkhFT3YzcTFKSmEwNXBLeWZubjBZeDU1Q0NZMEJWZDk1?=
 =?utf-8?B?V1VyZVI3aXRPSXk2N1l3NXYzbGF6SGxrbDBVVXNRejBaWmFZTksyMSs2N0lM?=
 =?utf-8?B?VjNJWVFxTVBSZ1VqaWQxRHdPMmtiamgveUhTblBDWnhYUm5DMUM2R3RmTGc2?=
 =?utf-8?B?MWFHVzNkQjdQblp3UWJoMzBJTmZUNVVFd3N2UUdIazNVMW5WZWRPNC9VeHd4?=
 =?utf-8?B?Rld1OWFnYUthNEVvRzV1SG1jOFhhRU4zbDB4andnSUdNNTNieCtPUnBpaUNP?=
 =?utf-8?B?RWg4N1gwZlE0S2x4K2h2TjRLaHZzK1FNS3lad3V2dXFicWRCWng0RStYRGpj?=
 =?utf-8?B?L0NOd3NxeHNPRFZRQ204a25OdlAvbEpDNUJQOE15WE1YeldQb29MemRhWWM5?=
 =?utf-8?B?ZWhYMkZtTUNsUGlxNWV3VFRuYk5pa3VWZ0R3V3pFNlA5M01Sd1V4Q1RLc0Z0?=
 =?utf-8?B?d1pheFh4enB6UnROdjdVbzc3ak1EK0ZRWFdNWnlDdHJpMmYrSno1cUpoaDl1?=
 =?utf-8?B?SCsvS21KYjY3eVU2bU5nSGRReVU1NzRTa0ErTVhNVDV4UWxkcXZRbUEzc1JF?=
 =?utf-8?B?T2dwL2JwNzU3T3phWXVTZitGVG5GOEVmZ2k3Y09pSFE0V0ZldGxuM2FqR1hU?=
 =?utf-8?B?bThJUHUrWmVNQzM2YjRUbVFUN0xIblIwK3A2a3ZJbDR2T3BCSmpHUG5NSnFP?=
 =?utf-8?B?U3V2b0RCb2FyelNXVXBMWnBDTEI1MmFDVWpld0JUYjNyMWtDS1I3ZGJXYmpi?=
 =?utf-8?B?REtjZzRnR3VCNGRaNWNpdnlqcWh6Mk02cDVnMXVvOTk1aFBwUWhhL05PRmtw?=
 =?utf-8?B?azNqRmsvRXpxYzNIT1BTZGVwOURyb3l4UUkxYXZ3Sm9rQnYrL3RveHlDTmtm?=
 =?utf-8?B?UTh0RzcweHptMXNDY1MxaXg3MTFpR0ZhVGNTbmlPNHZZM2dSU3FYTTF4R29Y?=
 =?utf-8?B?aVl1MjlYK0pkMmxqT1E5dXJRWGZvY2h3VlV4THpMRStGVFY1UFpDaW5VMkRJ?=
 =?utf-8?B?VG0wbkszY2ZrSnluS1lycEhrT1I3V1hvV2QvMkFNV2gwTUlkQWo2VmVsMmwz?=
 =?utf-8?B?aW1SMkErNWZvWmVYVHFFYmpYUFZzWXFDTzM5b3lSZ2o3djN3aFkwNW1EbS9x?=
 =?utf-8?B?T3lZai9FdG1scnpIbE5SR3VpQkxnZVRrY01iRThtL1IwM0Q4cFQ5bmNGQ0g0?=
 =?utf-8?B?clpzNGxJcnhUclA1S2xpN3dxTW5Sak5BcW9yS2tzWGdkbERvaGczcDc4V3M3?=
 =?utf-8?B?YlQzVlJjSTY5REE0bTZqaEI1aUkzOVUyK1hNbFNQVXNvREgvdG1TcXM2U0J5?=
 =?utf-8?Q?A8q5Pm9HPMtZIpEdkYZQ01O31?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91094a1b-d9c6-4cad-ab0d-08de0ccd1996
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:17.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FN25S4GGZjc7qa5yCBheXR83dDWFpjzbDrVy7nOseDocEkx+zmZUrah5F7HMHL9wSZ1hp8VxUpbSvVRyXfaFpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11203

Trivial change to clean up some DTB warnings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- keep consistent for touch-<n>-thermal.
- Link to v2: https://lore.kernel.org/r/20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com

Changes in v2:
- rename ir to ir-receiver according to fabio's suggestion
- Link to v1: https://lore.kernel.org/r/20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com

---
Frank Li (11):
      ARM: dts: imx6: rename stmpgpio to gpio
      ARM: dts: imx6: rename touch-thermal0 to touch-0-thermal
      ARM: dts: imx6: rename m95m02 to eeprom
      ARM: dts: imx6qdl-ts4900: rename ngpio to ngpios
      ARM: dts: imx6: remove gpio suffix for regulator
      ARM: dts: imx6: change voltage-divider's io-channel-cells to 1
      ARM: dts: imx6: remove pinctrl-name if pinctrl-0 doesn't exist
      ARM: dts: imx6-tbs2910: rename ir_recv to ir-receiver
      ARM: dts: imx6q-utilite-pro: add missing required property for pci
      ARM: dts: imx6ull-phytec-tauri: remove extra space before jedec,spi-nor
      ARM: dts: imx6qdl-nitrogen6_max: rename i2c<n>mux to i2c

 arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts          |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts          |  8 ++++----
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts          | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts      | 10 ++++++++--
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts              |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts        |  2 --
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts          |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts      |  5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi |  6 +++---
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi        |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts   |  1 -
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi            |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi          | 12 +++++++++---
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi  |  2 +-
 16 files changed, 42 insertions(+), 30 deletions(-)
---
base-commit: 2f331cf977ffb87638d3b6e534e06ad60ce32f4d
change-id: 20250925-imx6_dts_cleanup-6edf53e09c62

Best regards,
--
Frank Li <Frank.Li@nxp.com>


