Return-Path: <linux-kernel+bounces-857162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92EDBE6118
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EF84258FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D83238C08;
	Fri, 17 Oct 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLYy6XZg"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397443BB5A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666209; cv=fail; b=Knr4RVkmZ8lOUdEelQFBGCc+Yf2fKHw0eE6twDFzK02p9Xk0RjQgpl8z37WNx1+KILX0AKbnjmFTN6Z6Su88FwT90Jemsm+f1/X553ip1YcSdDLExU9dn80Gv9aQ+kXzl2LGy57PD7T2orfdxW5BLKBmKBFYnTLjP5hhXGmdDVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666209; c=relaxed/simple;
	bh=Z8VYWwlmT+aWUX9P6o2i+Ts+M3Pemljm6R4NnJKUSuE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WeeL5lMfuTzr8r11KtfD4dBRORe49YVh+kqfHRWQTvgCZltSRn1ndJhJyG/1JeLe2FigJAx5zomeh70Y8cAyhWGREJ5U/rUKuNYA5IgtzHXtl+wvIdkGASXDJzY4wPDihstwiglRKd81d0BbI4GHG0Zsi+BKpJJ00X5EpBmwPPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZLYy6XZg; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBanZCBGDpku8nNeTW19j6ArnVgnvBpfE15whERUukMJdfhbuk42vXz7NE0qB5z/cmCdrXoqgAABZUN1uG7qQkA28yLkI2RfBIaF7NCMklmVu8sW5YQmxwHx+tb2zUf9A5NExDlYVXTFs6FVfcIJg3XXlcVnBgOQExOH8iFj8d6V/gqwnGiKiWJSXOPqYLt5kVrtldF6NmjY8U4yNhd8mp1wHkBaTr7luXHr2ZJlKgY08bB1h9IxP1FqtlJD+5idZd4KYwm75D4GcRZd1hW4vWXslCIT41/ZYwNoqRUQCJ+Rt6zJpvP6hi5Bw7vCZFWJ+QznOvH9Pvv5kqX8Rvi6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROKKQ5gZNxQBern016wyGT3TxP4MULYbziCc17KqBFU=;
 b=Xmg+AblU/rLkRsNQD/+CDH4WdVGEGcU0HeQavUSmFhHzr53P99zOu7DdBGh+9y7jU23MdnsRUDfOsjGPHcpXUF+cNG3hkgG//JJBL0tMyoG1DKJLqVyNA8iqwhAn7dhOh8qWkEcR58RddTlwaY4UAhychHg0ItSdMwAvj7PV2IQePEabaaQwHvk+EyMcSjK0eO9+IQxarywY/sQ6iradsZGvjUU/7/dQ58G9yJ56p0CTlTNvKxqo//4LhJeqHujpWbV/nPGgqfsn98WtGXAB6EsY+f7GEvoBQlfQPJfVyWwYZiiqOXiBhEVXmT5j5hhe8dP2nOoV5HeA2Qw8+3x2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROKKQ5gZNxQBern016wyGT3TxP4MULYbziCc17KqBFU=;
 b=ZLYy6XZgWDNP24lSWZfMxFlpXL72NIxioONH8h8HEykP7wAbamGcZAFQQiEXkuctVM9C0Nv/zoctTUYgSJOJlajRhwLZC//xRsky3LyLTMCqBvUZnRqNAkx7zQFYyGv8F4+whAbLc3GgAaOTJRlniErJY362iWOPOT/qNPQcW2qAIKEzOBUyUA1R+Ps3Za7a4UiI2o//mY4YzmWBo0+zXhpTKhBipFejlkiHuFuGREvxE/tSVGvGjsHqPF/2jV7DZAmRpMzE6Vk+V/AwKAn/rWPax9RhTf0Roj2+LF5CMor+r9Eb7RdfVbtIK5qxvJOhlOeOyoSokgYUHvOC5YVZJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 01:56:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:56:42 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 0/8] firmware: imx: scu: Misc update
Date: Fri, 17 Oct 2025 09:56:23 +0800
Message-Id: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEei8WgC/1XMQQrCMBCF4auUWRuZTKtQV95DukjjxM6iTUkkR
 krubiy4cPk/eN8GkYNwhEuzQeAkUfxSgw4N2MksD1Zyrw2EdNKoScmclZMwv0xg1fU0mp5aZEd
 QL2tgJ3nnbkPtSeLTh/euJ/1df1D3DyWtUI0GkQjPurXmuuT1aP0MQynlA42iE3OmAAAA
X-Change-ID: 20251012-imx-firmware-492ba9230ef2
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760666195; l=1509;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Z8VYWwlmT+aWUX9P6o2i+Ts+M3Pemljm6R4NnJKUSuE=;
 b=dRIzzhQycXPD4ene9mxe02kXd36hRFgTpS1rFMWtWSJKrknsBSN+KsEJEkqpIwA5uoj6BYKIe
 epgPiJ1EQo8BPBnxrhiwEqDfVvA5iDo2+xoBp0+MxdG0wgZB416VNUv
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c0e566-7923-43ea-053b-08de0d206b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkY4OHBEZFV4cEtwQm5PdnZ5Y2JsS21VT1JhQ0tjYWxRNkFMWUxXNHdJbnFG?=
 =?utf-8?B?ekl5bzU3bElub1dpT0ZwWDBGVU9xRFBtZkcxR09KYVZURTNOc1JmYzkvWjRS?=
 =?utf-8?B?M2IwNllLTWdYRmt5aElJc3BjUkllc2J5ZFo3bitTWmsrb1RrZW1sZ2diZ1pp?=
 =?utf-8?B?UlBBWndBZTRxS2FHLzM1VzA5T25kSTBUWm5sd0tKeXEzUzV0MlVKMjlIUzVy?=
 =?utf-8?B?aWhrWFN4L1g5aVo5RW9YbzBOaUhab1o1Zm9hcHlwZHhBOHBYTzlsU3h0RXNB?=
 =?utf-8?B?eWhOSTQzdTFNcFh6V0NIcmhKWXFMemREMm0yTjVtVTVyOTRvZFNJamoxVS9U?=
 =?utf-8?B?RnNqMi8raXZHTndSbE1UTUJvZlVJQzhkWElmdDFwck54eHVuckZ3MjNpQUFi?=
 =?utf-8?B?L3k1aytweFgyaTN0TlUraHNyUXdKcFBlUGFVdU5Wak5HM2xjODZGS0JHb0hO?=
 =?utf-8?B?MXViVlNSTDVmTjBZWVFZZjk2YzcwOU0rZUpDb1VVY3lEWXdhc1JqcitseEx0?=
 =?utf-8?B?OWhidEgraytQYjFncm9EOXhad2dNSStkZ2RkMkFSVUUrSlFuc21TNTFBQmJS?=
 =?utf-8?B?SUFsTjRjZmRSaDRwTSs0anVYZjVjZ1RocXZ4TjhkV1owdHpnbWZWbTFWUWV2?=
 =?utf-8?B?R202S2F3L2ZvQjc0em15YUdPU3NsN04yY0UyRkV6NC94WExFdlBkeEE1bjYy?=
 =?utf-8?B?Um11ZmpKSTFIbmJMampGRVBvZkJ1N3ZYbWdBSUxZSExmZ3N5ejRaRzVSaURl?=
 =?utf-8?B?K21GOE9jL1BSWXNtQ3JmTDlac0RDU29Ddi9RblJMeUZsK2h2c2FNbk8zU0h4?=
 =?utf-8?B?ZkZNZWFjckMzSUpjNlBuMWp1V2N3Nkd2M1lFYXJIODl3aWtEcnYyS3cycVV4?=
 =?utf-8?B?RU4vek5BZ2l6ZnFYc3JaY2MySTFmYXpoOFZ0MUlwaUZLVHo0bWZiZTNLT2E4?=
 =?utf-8?B?SkcwbndZdk5IQnFWZDVZZDBoRG9ZamRRNGVQMXhiWU9UWEVIVzU4VHdUQ0l4?=
 =?utf-8?B?TjVVMGV4bGl3eWl1eVlSaU8ySE5teU9nTVkxZXVoUXNOUFpHQkVzUThuQnNn?=
 =?utf-8?B?cnNDZGZBbEVBY2VaT002dHRRUTd3cU5pSTN3WnFpMWkyMVBkR2UrQUMxUVBW?=
 =?utf-8?B?MFZGZWxmcXZNcnNiMWw5dFdsOFdwZklmWFVFNCtwYnI4RVk4VHkzUE56eXQz?=
 =?utf-8?B?d29IOXp2ckorbENENDdwL2hCN2dFVlVzYmw5ODNSNDNZVmN5Z3VpS05yNmpN?=
 =?utf-8?B?Rm9zdFIyaGlzaVo4SjNreCtDamFRZWovS1NHVkUrc1FCaTdaUXJNUmg2RUN6?=
 =?utf-8?B?SXpnS2E2cnlYVDB5bS8rdGVYNTlzTXlWKzd2QTM4QkJBYjdYcnpqUzE2aHE3?=
 =?utf-8?B?YlZlb0UwM0RPT2UxWkpYaGlZLzk5Q2w5UEtPQmdtVnU4NzBGeTVOd1lnT1p1?=
 =?utf-8?B?VE9uTlgydk5kYUJkT280aC9nMXAyNlBBVWtmNXpLR2hST0V4dXljMzRuRHZ3?=
 =?utf-8?B?VVYwdjg4UFhjazlPZ2tESHY2blZxSXkyTnNXdHhVN2tVWVVGWDhSY25rbEsz?=
 =?utf-8?B?ZWFCNDZaVDFBR29DZ2tyOU9rRjQxODVpR1Q5REN3Uk1TNGtKOUs0NVhkbGdQ?=
 =?utf-8?B?TUFNR3NINGtSQkdqNm9RMHJYbVcwQU1jTWtFRElKU0tMR0doa3ZkaWZHcHlh?=
 =?utf-8?B?NmIzb3NnUnZSWFdkaGd2VDRwVnVMODFZNjdydDZlajdWM1FjYXFnTkQ4VFl5?=
 =?utf-8?B?R0Y5aU9DOEEwZE5jdkdIS2F4WEFadmpYMExGRkRORWtTSklMQ0QzZXlqNVZh?=
 =?utf-8?B?alZaVU5RSG8rM2JSOHVwRWxTNTVMdllGajVEMGJaRU1PNENFdTZxM2dzazhp?=
 =?utf-8?B?OUFZcUFwMTVLckxHTUdIbEZuaGUva0I4U283TmhpNVhGTUNNc3RnN29yeVBQ?=
 =?utf-8?B?eFNrSmFqL0NuSWZQZzR4M0hRb0Q2SnZSNFJ2TW1RaCtpZzdDVXBuVzhUbVJ2?=
 =?utf-8?B?NCtWaEQzcWgxTGVZY1gwOHBjYTRJUnJOZmx1M0pleGJLdjZZbU9OYklYMVQv?=
 =?utf-8?Q?AaLDcW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXgzMUZkTGxRbFZvMkJDb2F5ZjBJTU5ZYXQvaVhEMk5CM2pNaDRZTUhuY2pj?=
 =?utf-8?B?dXVwTStXNStHKzU5VmlHaHRHbTFKV0tqRlFqcHRhWkgxVklCS2NpUW4wbi9Z?=
 =?utf-8?B?Y2ZEaXNTZFVVTC85SmhnRDBpdDhFdXQyUTFUUUhrOWcwUG9ZSkdlRk9KaDJH?=
 =?utf-8?B?bGVXV20yTVA0OE9zRkI5MGhiRFcxYU5jSmtaQjVDQU85dGY5Nk9IZVpPeWxQ?=
 =?utf-8?B?OHNRR21FVTNCUUREKzBtelBFbHhTR3ZNSGhMS3dEelZRMGw2QzBuVzRxOUVu?=
 =?utf-8?B?bEVYYVN3NWsvOEMwSWxMSVZ2NWhDZmYwdE9paXY4MFRzOUk4cXRpZ1RiR2Er?=
 =?utf-8?B?WWk3Rmx5OGpPa2ZwSndPZEJPY3RycTRlcHl6dTArVThEdVJhT3ZxTjFwQXIz?=
 =?utf-8?B?MzhvellIbmY4bVVaaTI4ZzYxSXZldEpzNjBlc1poZWk5SiszaDFWcVEyU25I?=
 =?utf-8?B?ZUxNR1ZjdENhSWhlVEE4MUFDZGl4Ky9YNVJOdkZLdVg0MzBlRytJcWE3dXB2?=
 =?utf-8?B?LzNlZFlFOWNNQ2RIQU1yZDVabDBkMFJ3aXRST0pSelpMaEh2S2NHN2tQRW5W?=
 =?utf-8?B?TVFHYVQzcjBaNVppZEkzUDVCL3VJbm9XeXh3cENVR1lVWk9ZZlkzMWtQVjdU?=
 =?utf-8?B?M2FZOUpWcWttR0FKTUFEVE81bDNteXZzWWJNS1k5dXJXc3JuTGFwOG5NbnBH?=
 =?utf-8?B?MkJzMWV6SzdFKzBYWWpBYlJJRVI0SDkzbDRUWEQwZVI2UVFna0hRL2Y2a0ZS?=
 =?utf-8?B?UGZpRVpwNlg5YjcxT3JxcUtmbVVLVjFPWTNWZWFkY2l6NTViUGxQOUVZWTFk?=
 =?utf-8?B?TnpBSVNnT3lwQ25ZM3JVN3hYVzgvRnpUdkNNWlJxWE1XVDczekttbWJ5S2tW?=
 =?utf-8?B?aHVGakhrY09oTmQ2R3FTMHhlemh5UE5oTk1CUXRoL3o5ckJBc2JGdmdpdGdL?=
 =?utf-8?B?TU5DdThwRTE3b05ZNmZ5U0ZySjltTEVyQWhPbW1oRUhhQXNlYjZZY1U0R2hi?=
 =?utf-8?B?REIxSk5UVjFTVW44MTJPc2E1NDJSVVBCSUwxcktHdC84OXVkZzVKMGpKdWhM?=
 =?utf-8?B?SEpSZVg1bDRnaW5XQ1RtUmdOMWZJS1FDWDVIOVd3amFCVG9lOHRUekpieDlt?=
 =?utf-8?B?RHdTMVB3cXdzVVdlZXRDbjhFK2hmcXRhaHVva0VQYnJYcjI5aVFLYlJNY0dC?=
 =?utf-8?B?TDZsUFcwNU9JT0d2b01uam0zYTZrVndwRHFqK2o2Q1ZOcEFpQmlIdDhUa3ZX?=
 =?utf-8?B?SUFTMXhESVBzZS9XTVNiSjZROGlHbDJTZ0l4RCtURXlxbEk1WnEyamFGd1RY?=
 =?utf-8?B?b0g2U2t2Y2k1eUxTYUZ6MUd0Y2tmeW5WOHc5WWNlc3diTEVmMitSdEhNV2pZ?=
 =?utf-8?B?WTJzQ3A4aGdIekJTZ3NwRUExWU5FNGJxOHR0cFE2Q2h0U3VoS0FNdW1wVDAy?=
 =?utf-8?B?UjhPZkpxemlaaXd3UkNOR0JhQVJMUXFJU2NBdGZBZGhrRmN0b2dGeEZkODFG?=
 =?utf-8?B?cHBoYXZHZHk1d2ZBNHVuN0NBcVhTdmVtZjV3QkJDUUdIVjNKN0R3dGs2MTAz?=
 =?utf-8?B?anM5VmxWc09ySGNUN3ZhYTdqVjdYTUQ2M0lkbW9NS1Q4eU5uVUlIZTZYbUV0?=
 =?utf-8?B?aGpJOGdWcktVS2MzRUlDUEhUMjBEamJQSm5BVVJsSmFJOG00VmpJQVBXWUc4?=
 =?utf-8?B?TzVoM2ZIQnBtajFIV1dUS3pWaEVqQWp1WkFnWE1pSlM1S08xMWlGdEcvaENx?=
 =?utf-8?B?MmMwMHh0SE84OGFKcW5EaDdMY3BIaDh3dHZqNkdBZ1pQdlVwRWZWMlJraExl?=
 =?utf-8?B?ZlgrUmIrR1l6aENWSmhxWHQraG5ETUhoa3Fjb202VFFPdzl0MjN1RlBsMko2?=
 =?utf-8?B?dm9PNUFHRC9ETGc2MjRBREtQNzFXS25iNjdLSkVwS2RZWG16L0ZBUHZrcTlZ?=
 =?utf-8?B?dFUxMVk4ai92T0hDakV0S2VYalhjdUhDRjMrd3lTMVRwVGdMeXhBckVkbzEz?=
 =?utf-8?B?bjNXVmlsUWV5Um1peEZPM2k2dVVYMUVtd2NYdVdVN2hjSjByZURNTnpBN1Jl?=
 =?utf-8?B?U05JZUg4MjRPUzcvUk40WlY0L3hQZ1RjYWhweE5PMFpwS2IxWllncit6eUMv?=
 =?utf-8?Q?63XSCrXpHTJinjQ0cHn2xW4iC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c0e566-7923-43ea-053b-08de0d206b4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:56:42.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ua0l5J7m+s49NJUSj7Lg3YIYxNEaPiM3s5tMJ15qxJ/O+p2Q1CosMjti8yPulKBJ5hQKBtCt68BBXIFnvFb6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

various misc update for imx-scu.c and imx-scu-irq.c.
Patch 1 is a bug fix, but not critical.
For other patches, there is no real issue reported, I just reviewed
the code again and see some potential risk, so patch 2-4 is to
avoid potential issues. Other patches are misc patches, regarding
error code update, use devm_x API, suppress bind attr.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Update commit log for patch 2 per Frank.
- Keep free at one place for patch 2 per Frank
- Add R-b from Frank
- Link to v1: https://lore.kernel.org/r/20251014-imx-firmware-v1-0-ba00220613ca@nxp.com

---
Peng Fan (8):
      firmware: imx: scu-irq: fix OF node leak in
      firmware: imx: scu-irq: Free mailbox client on failure at imx_scu_enable_general_irq_channel()
      firmware: imx: scu-irq: Init workqueue before request mbox channel
      firmware: imx: scu-irq: Set mu_resource_id before get handle
      firmware: imx: scu-irq: Remove unused export of imx_scu_enable_general_irq_channel
      firmware: imx: scu: Update error code
      firmware: imx: scu: Suppress bind attrs
      firmware: imx: scu: Use devm_mutex_init

 drivers/firmware/imx/imx-scu-irq.c | 32 +++++++++++++++++---------------
 drivers/firmware/imx/imx-scu.c     | 11 +++++++----
 2 files changed, 24 insertions(+), 19 deletions(-)
---
base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae
change-id: 20251012-imx-firmware-492ba9230ef2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


