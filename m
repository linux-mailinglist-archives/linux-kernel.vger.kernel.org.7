Return-Path: <linux-kernel+bounces-783083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FFB3292A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58563BD16C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A525B1D5;
	Sat, 23 Aug 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VAE/boav";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VAE/boav"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021116.outbound.protection.outlook.com [52.101.70.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468F2580EE;
	Sat, 23 Aug 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.116
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959392; cv=fail; b=tbinO8Y64IkAJSa76Sf3BAdBt8Lgmt2jS/dbvb86zoJFwX2sGmqt9rWGncLMugGka9OAanU+k1Z2LykFizg88ID3HoDRxmaX6+hhIRQlzQlgT1RQ+Z8qK4Iwr+siRkpPqRPg1Ov6Vy7b7udZ2RQpvhGXOpY049v4ixTnynry2Jk=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959392; c=relaxed/simple;
	bh=Rg5L4ONSP5YtIwijKDEy1gyaGHPNezoyRZJtpfPF2nQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sJsxYTV7nkVDdphqzqUx7kIaAg85selyuRDCHAfZ6MWEoGYXYurUbfdXB+yp2DKVXhwH/f8TauZwUXDZDTxe5Fbb0lLw0gvpO9/j8S6mEBUWWjYhyKCP9cbkmq2qT5ZbN3SpjCf87Cand1x9EeeOP3vDJb+iQw4+PO1YkjhQ+Ps=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VAE/boav; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VAE/boav; arc=fail smtp.client-ip=52.101.70.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Xq1Xn/GSxIxivEMeMzHlUpEeIb8WCBrrbwknMju6xgmDfC2XNirXkakUL7S+ela1bIb+DXhKhQd3MrFr+VEdBOeuFp5l216nNVNHJN7cEs5yzCvm3QXyj8Q6KMRUGKc3ff9E8Ih3Ms5rwjcmlRR8S96CI2yhQ/kfpDPbADREvYYaHlwESFW3pXADt40wNzXNAVAQViQrFlKfzLw7G9ZOmt8Vtz+i3DoeN2/p+B9Jtw/p8DpRHiJ7dfvp7sr9sczc3wNMTedMg0yfk+et2sfbspOuTyLbqA+xZJ34yLKOn7FdfIfj7So9SQeB1M/FrvxhsRKqQTau4O6QUAHJTKwmqw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i49PLLar1h/ICaadY4yuMr7lUjEUvuCAWl6Ck8hETWM=;
 b=NHnFR73FU7Vz92xuUQBZN1ev7n8spxCiSmu/gd0r1+9Z76cyF8nxRxOCn57kUZx8msK2bKD+GKkE3/0QY+S7MdHMkYoPl7ejpuQe8g/XnCeBt0LV8otgMjtYtQVwXk+ztfAQPJB9z4nYp2dEqk1Z/UCG0l0RrQGaG5FXY1Sl5Qcq2YDqhcpZxI6QI4BPSBaxvvhw9NeRIXDS4LfjrEIzwV46pWDf6zCoDBG2AGZovXgg0WJ7E7HHBCkYCoVE72awZKYRBcHTz77+0TStuxhdeH/1kjttqp8p5X0hCnjO/p8Vs2J6mJG09FRq50aNh+p32L1y5MXx7gr10oueAu8ucA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i49PLLar1h/ICaadY4yuMr7lUjEUvuCAWl6Ck8hETWM=;
 b=VAE/boavfKy84HSbmjAA8rHm9KLeGmPAsiYX8dD2HW/Yq9o/B5c+7+Og/DSPqppBaPLrKqTc9FqyoDjNMtMa3oUEwCQOzzIL5EhRaDWqNdiIg6bGqeMy4gYYB3XvqAQ6YqHAxAqkKEhzF11CYWMSk1qKFkW2G2kHkVlZiKTldf8=
Received: from DU6P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::14)
 by AM8PR04MB7857.eurprd04.prod.outlook.com (2603:10a6:20b:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 14:29:48 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::d) by DU6P191CA0028.outlook.office365.com
 (2603:10a6:10:53f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 14:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Sat, 23 Aug 2025 14:29:47 +0000
Received: from emails-953117-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 2A39B80043;
	Sat, 23 Aug 2025 14:29:47 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1755959387; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=i49PLLar1h/ICaadY4yuMr7lUjEUvuCAWl6Ck8hETWM=;
 b=VcZYjwFNdrPPFMLNZWtoY4QaqOpM5lbQSg82avIdQmPcnLtisrNAnqMuyL9Q/6hBdmYTd
 uBYHjXpckWz2oyIIoVJlfdMeY/78C2q/BclhcexA53Qunc+6j0Z5b6eZCWAt3qlezcHJ0uP
 wRsKUVwjTv9u21vxD8HoY8jAffbPezY=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1755959387;
 b=obS8HlBygsxEHzsc+1Yog02K5QQgb1fpSM8SGXc95Zops98WTjK2J8Q9+Il9AckhPP445
 drBCibnOMZw1vjIOwWDhWj7adrv1hw8pNyzEJ6olVWqplvhElbbu+UmS3Try/EI5e+eun/g
 U2FYsFjBC/uVof70TFTf3s779FIdsBY=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feWw9cYB049zbZ0AB44ch/39W3HnxOAeVeIAsqoE8pVTJTfCwi1smhOwjCP/YGdFCICJM2rlPzalZBUyrp4vhzpTsFNLPT1oJRi0MZs+1Ltt+k7+feGPn8/eOMHWoTVXqTp9j7Nnz/F1V/l2jRH6KkDshhN08x96f2rQKjUf3UJ4Wzas0dUXn3Vu1mcTp/tS3GXIF7geijvwsUcrmgTvqwtzyFT4n12ZgcJ7aXR///2VlxMcKYJl7KcSnJHGvFrm4HjiF+u45RJvCuH7V49qEzsSw848ueDJJuGqlh3W2bSn9urd7c+JdgTVOtdkIE3IkNFs3USEY8a4aCjGwBAHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i49PLLar1h/ICaadY4yuMr7lUjEUvuCAWl6Ck8hETWM=;
 b=ScCIskeNEKiqzijV0GO5iJfhTXL0RsEOztne6fAWGjbB4rXhuDlqXmBJ8qE1CqBGOjDe8DHQqlCoC5AyNRIEy56+qBNvIlXLg+ZtPkG9um0p3OZdCbueMSZh9Q6xFsvNRMu1SDmlznIreGGcDxRakNAmJOpGhGvlrTKCQA128Kx7OMoxNBNPhel/LyS0DStLAoGxTLAgFwT4rtGROz1fJwoTGsqTmn/ObLSvngQnz0lcUBuMvp4IyQB1A8viKmFXvoc6Q90xjyQxicBdahDh+0t7HJtcxAbpGgSvyc2CzFJMnrrBtQEiHWk5hFKnIcd9pu05Lr5+11+kBw3xe4Z40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i49PLLar1h/ICaadY4yuMr7lUjEUvuCAWl6Ck8hETWM=;
 b=VAE/boavfKy84HSbmjAA8rHm9KLeGmPAsiYX8dD2HW/Yq9o/B5c+7+Og/DSPqppBaPLrKqTc9FqyoDjNMtMa3oUEwCQOzzIL5EhRaDWqNdiIg6bGqeMy4gYYB3XvqAQ6YqHAxAqkKEhzF11CYWMSk1qKFkW2G2kHkVlZiKTldf8=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB11146.eurprd04.prod.outlook.com (2603:10a6:800:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 14:28:34 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 14:28:34 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v3 0/3] arm64: dts: add descriptions for solidrun i.mx8mp
 based boards
Date: Sat, 23 Aug 2025 17:28:20 +0300
Message-Id: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAATQqWgC/3XMSwqDMBSF4a1Ixr0lDx+xo+6jdKDxpl6oRpI2W
 MS9NzopCB3+B863sICeMLBLtjCPkQK5MYU6Zcz0zfhAoC41k1wWvBQ50DDrYYLgIbgBDKItWrS
 ixY6lz+TR0rx7t3vqnsLL+c/OR7Gt/6QogIMyjZJlrbUy+TW4J3Xg3+PZuIFtWpQ/oeLVUZBJq
 HShRY6W1019FNZ1/QIfQVEy8AAAAA==
X-Change-ID: 20250614-imx8mp-sr-som-ceef5bef1bed
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB11146:EE_|DB3PEPF0000885B:EE_|AM8PR04MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 310d71a0-8d6a-4469-6405-08dde25182e9
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cGE2Qm1MaEwwdHFrUmVCTWN5UEwyM1U2TmQwUUFLNStiTDJhNStBTHlRZ2Jt?=
 =?utf-8?B?WFM5MGpvSWcwaUtjYWUxTXR4MlRFeHQxcFJ0MTNPdGY5RTRXNUlYdkIyNXVC?=
 =?utf-8?B?OXN6a0RJQUYvOTJMUXVXKzRJU3crUW9USksxVSsrM3FnQk1DSytJSW1ZNGhC?=
 =?utf-8?B?MkN6N3hodTlUTWhVM2QzSmE5RHVEYktYdmFoQldLSTgwK2xlSG9Rek05TlEy?=
 =?utf-8?B?QSt1WW9RYkRzY09WQTB6djk3bmt5NzNyQ1ovNmZ1UnljQTFyT3RzdXQwMXVW?=
 =?utf-8?B?UWt5QjdPS3ZDOFBXNzdMR3RwQytTOVhzb3U2K0t0MWdNOWVuT3czc29tbEtG?=
 =?utf-8?B?VW5JUmd0MzFCcEsxM3YrK0RYYmdWT0Q3ckxTbWxUZXFHUGs1aVpVcWVvcWFH?=
 =?utf-8?B?aGhXZ00yUEpUcDVCbFFRNi9VbDNQMDZXakJoZlhhYmRXY0swV3N6WTlrRjM4?=
 =?utf-8?B?UnpWaUFvSFp4dWNGemVqMnZJdGFldHdBSktLK2pUWHU2STRnZFRsN3hMQk5m?=
 =?utf-8?B?TVh1S1BrTkhxTHI5S3V5ck1MWE84blNocXdzdWJXR3JzSzRLNWc0amZQRmVX?=
 =?utf-8?B?cU5ueUFOZFFoS3ZvcEo1VDdXTGVhOWYzOTRITXlFRERzWDRtckhzUURMeDFz?=
 =?utf-8?B?ZXlqa2oxbzdnVmZBY0dlaWZCcXVESEZTQTdjL054R1d5cTlWTTdEVmMzZlZW?=
 =?utf-8?B?Z01kSUFCS2VYZkM2RDB4KzFMeUZibVZqUXZWUnVqY1RZVHp6VEtraXozYUJi?=
 =?utf-8?B?akdZUHREQk5BWjdMaElFQ0x0VkVucW1MSks1QjFwUlo5MEMwdHVzZHRMMU16?=
 =?utf-8?B?RnJiZ1pGKzZtOHdQSlV3NzFiZzZrR0Zvd0EwdkI3YUZMN25nR2NQei81TXJ6?=
 =?utf-8?B?Z08raVNKaktVcGdNck9UZjNJWEd2TXE0TGF4a094cnJCVTNoRUpvSGNoaE1K?=
 =?utf-8?B?Y0x5U1BNcTY3dkdXa0FiN00weStNa0JqSnc0dWRYWHNod1BKVVY5T2d5cCtv?=
 =?utf-8?B?SXFhODhCSFNLVmxzeGNwNEJvVnFNdlY3TkpnS01oTW1PbUxmM1BUTnRCRzRy?=
 =?utf-8?B?TE9XOXFDMVhRditRMnFqMUlFVitONTJOK3JoNG1WaU9hRVEvK2NvZUVpUXhv?=
 =?utf-8?B?aXcrZWZJbTRJaUwzb0VkL0RtZWNEc1ZldjRqUk9CUW0xV1RUb3ZQUkMyOTI0?=
 =?utf-8?B?ZzNJeHhOODA3MHFsZ0tMcjRWSU9NZlFCQS9WK21UQ3BxWU0wY3I4RHhMeHBH?=
 =?utf-8?B?MWttR1BvQ1FtRU1LME1yeTJzY2tqNTlqeEMxUUFpTlhHTzJpMncweXJDaGRB?=
 =?utf-8?B?bHU2T3dacTBpQmVReWc5SjM3S2JRWWlVeVFhaUR6K0JwUjUwTlEwSENZS2Ri?=
 =?utf-8?B?M3dqL2IvNy9KWmcrcXpKUCttTXJKa1JWVTBwaXRUZ2dyOG5pRUNNM0JhQisv?=
 =?utf-8?B?UnY3YUhyU0w3cW1QcGtPSjlqdXk3eGM0ek1RdnZCZ045M25KSkRReEg0VzlI?=
 =?utf-8?B?QkxkNlZKdUJwbGNIOFMrM1RDL2sxS2hVS0x3dVBxZ2JkaTU4czBkT2tqSWNP?=
 =?utf-8?B?NkZqVlB3RTJvQ3BKOTVNU1lrL0JjSjdOekxrNkZPeWZ4NWx2MFpuZGNQWjRx?=
 =?utf-8?B?R3hyQlRBMHd0czNoVlNrZkJnRVJMbzVMQjdGdTlucXpIK1RRQWJWcW82MGtu?=
 =?utf-8?B?ZVpoVDZUbkpwQXF3MUZ1QjBEbno0RkQxdXQyUXNRWHozU2pCNFVyQURLSHh5?=
 =?utf-8?B?a0JObGd3RjZndmhLalQxbllnbnFudTBURlhlQXJibmNqM00zU3l3M1hLYlY4?=
 =?utf-8?B?RCtKcWM1SjBrWWRnZ09NNE12MDhMNmV1Y1dmNmdhdFFJakV6TmNNOHhBc3Y4?=
 =?utf-8?B?enBGZ1NqZmY3RlIrQ1EzQ25RQVFrQmlzako5aDhCZnlGdys3dDFmY01EZ1Vo?=
 =?utf-8?B?NzJjaGN2TDJySjN0b3hmakV0aDBDS1FDZ2cxRlRxRVMxN1BRdWF0R0RFWXdH?=
 =?utf-8?B?OWI1TUlhdHNnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11146
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 9611f162a99f4b9780d300b7ac1ebc1a:solidrun,office365_emails,sent,inline:a9cfcf818f3381afc2c17a6361a4db5e
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e3d42099-e0d4-453e-a580-08dde2515765
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|14060799003|35042699022|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXU5eEVUMmZJdHY0Mys5QVY3RnNxVU9kQ0tuZEM5aDZwMkNyYWFKNEtMWWdK?=
 =?utf-8?B?dWMyc3REbnBlQm8yR0FsSkUrdmpNY2VBVDBHUW10Nzl1NGpmMUR5RkxDbDgz?=
 =?utf-8?B?VmQvR1NhZkp4L1BYS01yWGMzeXd6UC9jZ09nMTZ3Sm1IUXpBTHI0MWhNRE5S?=
 =?utf-8?B?RjdrNlNHd1RoTEsva0lkd1h3dTI2RlFHSlNlcGRLWGMvQ1B6S3VLRUcyMjhJ?=
 =?utf-8?B?SFgvZU1RMTB3aVc2U0dXZ0h2b09sanRmT2dpODJOa0dHekNYcTFIbEdzMHIy?=
 =?utf-8?B?Y0ZzTldvWkNmVXU2Ull6aHkyYVpxQlRhTEc0ZFlCVmlOa2N1UWpaa2cwVG8x?=
 =?utf-8?B?c0tmQzB3ZzFpUjFZNjZhQWI0dmtQakxQa25wTmYzY3RwUE1UTWx4YnMvTUZn?=
 =?utf-8?B?VnBPZVVwTC8xYmptNEtGY2xRTFhndDBrMGREZ04rY1FXaU9MY2xoWkhBS2p6?=
 =?utf-8?B?Wm41VEF6MXFWd01GdC8wN0VOczBBa3ViWDc2dE5CQ2E1dHpab254U081OVB4?=
 =?utf-8?B?UzVzbk56SFg0M3I5RG52Zy9YN043WklSdGNqeit6ZXl1UzRKRGlMV0NVUWI0?=
 =?utf-8?B?Y2psRmNKK3h3Q3Rhak8zRGN4OTlqT1pKWFlYZS84bURFeEw5SmJxckF6SlZR?=
 =?utf-8?B?eDkvT3poRHd3MldXMEZjaTBDdzhSNXRWM3puU0MxZ3ZlaDZFaGVOZmVDYXJ4?=
 =?utf-8?B?bGQwNHc3SHNoRWdwMDk3bW9ZdDMyUW1ES0JsOXc4dEFnUkh1c0ZXdHBabUZQ?=
 =?utf-8?B?MVoyUW1SWktvbnp2a1h0NnozbzkwM0RmY1hHcVcyV1JnZEMrcnczcXdxSkph?=
 =?utf-8?B?c1Nrb2RXUWFkQjRPaWI0Z0dOS0UxV3JMdmt1c3U2MmQ5UjJMTkh0bmJKUy81?=
 =?utf-8?B?UXRSb1hLK2V5ZWFYZnNxeUQwMmxsbmxHOU9KZU90aThLN0NqQ3ZwS3VvWWJm?=
 =?utf-8?B?bGZNdVg1UmVYVHU3cnRpTTd1RUlDVk8zcjhDd2ZtSTM1cjk3MTd1WWJqUzd0?=
 =?utf-8?B?eU1kVUE5cjgrN0JWTGJwTWpMT1kzUnF5NTM0ZmdMcksyV3QvT0dPdFJrbGI1?=
 =?utf-8?B?Q0xFZUF0MTAzaXN3WTVCa29peFRKdWFzTGQrRkhGWFV3c2l5ZkZtOXc3Ukh6?=
 =?utf-8?B?alRTcDFyWXJpblJZbGhudkUwUUN1Tk1BWDMyUDRpTDkzQ0Fma1Zqb2g0eDNS?=
 =?utf-8?B?NGp0anBGSnBOdVhYbkdqWkdRaWxWV2hFemowZGIvRW90VU8wSzd2b0ZFS3ho?=
 =?utf-8?B?Y1hMaW1JRUswK0xpZnE2aUJ4dU55UlNBbkZ0bDRYRnJpeklYczBtZEExWUln?=
 =?utf-8?B?d3U2dC9pemdVZk5kZVdLVUV6S1hGRnpVUlNYbVNiRGxJZkh4SEE1ajdEaG9E?=
 =?utf-8?B?YnpNWFVFUzhIWDVWd0ZMV01hTWMwejMvOSsvSnRrc2ZtT212bUs5ODlsdWUx?=
 =?utf-8?B?Sjl1RWdQZm5aR05tcEo3UTkxMjg0bWQvZ1JrTURLTjM0MHdTaWlKMzJpSUNq?=
 =?utf-8?B?TVBQN0lUZ0gyQlFLYVZ5U3o4U2drV0xvbzhuZ3dGbC8vZXBTdU4vYjU1czJz?=
 =?utf-8?B?bG1ybkNTcVhNUVFzcjl5YndVSzdlTk1BNTg3dU5memhMVjgxWnk1cEg2Rk5O?=
 =?utf-8?B?VmV5S292ZElZc0sxQjc0UytLR1praWw1TWhkc04wVWgvWjZjcjRwZjZDc2Vp?=
 =?utf-8?B?emNMKzlRQWRVT3ZUVWJOYlo0YzhtVG5veXJSdDlEL1FjWDJCNkNuNVNXdHVy?=
 =?utf-8?B?REJiNWVDTzJhYmRBSEpDc0lCdmdreWpSRXF1ZHgwQjQvOGc0UzVZVWxxUEhM?=
 =?utf-8?B?Q0pNQUhxMVhsTWdFNGFIVFVUMXdBM1JQVHdwK0dwTThnTHU4blhiMHhneW4z?=
 =?utf-8?B?SmRzUEFCN2UxSkZhRy9WWlFGeHlFQmJyNkRuMGlkL2E1b0dlLzAzd0RqMTBT?=
 =?utf-8?B?Z2ZzNEp3anlGZ1ZjUVphQWtESVg2WEYwY0JTNWJWNTc0QUVCQ0RSZ2RUTmhi?=
 =?utf-8?B?SUQ0NVJTdWZmbnBuZmhNeThkYUZRUlJmaGYrYisxemFkbmZBSk00OTBjamZu?=
 =?utf-8?Q?jGghx2?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(14060799003)(35042699022)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 14:29:47.2634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310d71a0-8d6a-4469-6405-08dde25182e9
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7857

Add bindings and descriptions for the SolidRun i.MX8M Plus based System
on Module and various reference boards based on said module:

- CuBox-M
- HummingBoard Mate
- HummingBoard Pro
- HummingBoard Pulse
- HummingBoard Ripple

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v3:
- Dropped unnecessary status property, sorted i2c nodes, sorted
  dsp_reserved node, sorted pinctrl nodes, renamed audio-codec node,
  dropped unnecessary newline
  (Reported-by: Shawn Guo <shawnguo2@yeah.net>)
- rebased on v6.17-rc1
- Link to v2: https://lore.kernel.org/r/20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com

Changes in v2:
- Removed invalid spidev (rohm,dh2228fv) node for mikrobus header spi
  (Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Added Acked-by: Rob Herring (Arm) <robh@kernel.org> on bindings
- Added m.2 connector reset hog for hummingboard pulse (usb-3.0 only,
  pulled low from u-boot)
- Link to v1: https://lore.kernel.org/r/20250614-imx8mp-sr-som-v1-0-3ca3269883c4@solid-run.com

---
Josua Mayer (3):
      dt-bindings: arm: fsl: Add bindings for SolidRun i.MX8MP SoM and boards
      arm64: dts: add description for solidrun imx8mp som and cubox-m
      arm64: dts: add description for solidrun imx8mp hummingboard variants

 Documentation/devicetree/bindings/arm/fsl.yaml     |  11 +
 arch/arm64/boot/dts/freescale/Makefile             |   5 +
 arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts   | 223 ++++++++
 .../dts/freescale/imx8mp-hummingboard-mate.dts     |  31 ++
 .../boot/dts/freescale/imx8mp-hummingboard-pro.dts |  76 +++
 .../freescale/imx8mp-hummingboard-pulse-codec.dtsi |  59 ++
 .../imx8mp-hummingboard-pulse-common.dtsi          | 384 +++++++++++++
 .../freescale/imx8mp-hummingboard-pulse-hdmi.dtsi  |  44 ++
 .../freescale/imx8mp-hummingboard-pulse-m2con.dtsi |  60 +++
 .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |  81 +++
 .../dts/freescale/imx8mp-hummingboard-pulse.dts    |  83 +++
 .../dts/freescale/imx8mp-hummingboard-ripple.dts   |  31 ++
 arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi   | 591 +++++++++++++++++++++
 13 files changed, 1679 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250614-imx8mp-sr-som-ceef5bef1bed

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


