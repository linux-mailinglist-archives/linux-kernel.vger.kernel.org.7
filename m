Return-Path: <linux-kernel+bounces-810368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490BCB51959
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FFA1C26F04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA432A83B;
	Wed, 10 Sep 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEdbHdHp"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965A3277B8;
	Wed, 10 Sep 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514526; cv=fail; b=lH44W+G1klz9dNmPvGag4FHB7CsCZ/ix1KMuxejiizSDzEtdcD6g2XO61seWGftdMOOpYXzb2urV2W0n/RXgjm2Xr21iNyZmfM2yz3lM7iAnT6RDP2gPDZAVT6i8z4AfW4tX2t4UHDxULfDtKaN6Z2fJvSY74KOj/VBMfwCa+Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514526; c=relaxed/simple;
	bh=BXvXDZX710LlHL3VhMdCOhHWftt+UpXXVRCAilK67Ks=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XWZB7f/DNInMmsPIKWvwKFs7Q2wGnzY6rMHDEpYoWYSil27m1kr+VjjCWtMUmFfZAzuvuMVNr0s72wg0U0Hmx2LfQIEr9n1OSx7hxdnPYSwAdc8NaFmSo4PVdF4DDfZsWWRqNoZ5+Z0ZGnuxDQJlU+VXDvkG6HUryFqXk39B+8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aEdbHdHp; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAkUY8WVNHtLiv6j/s0XIjAh8RhwLJdr7fiq4AxigoeX1Nefb9+ehMjSqGPL/DiUxHEWq19gRXfgSPjOFvNkoOR3M4QNsTN/hxaSCQASdMMKWnlwHeTJ2v4aaYdqOROT1fnO0OfU2+p+Jfxr042esfIq11bCrcliuvdBmTtej9PcpbR4iyJbhx+66+wTQYC0IEPj+zndL6Bdo3RxfG3RQq+l7zKRWDsiclBzv5qTBzA/aTSmmVOQRgjLmM5FuFrvZ3P2dWzmFF2Ads3nfgN+DCI0OjpwD1xRXPPw4yJzLCsMnc1C7MVnm1MTv9qsX0RTRsgVp88jOEXXLByQcsGb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nh1lxj9PCsSWVMkkIZBHi0r10FeHPkfqbANyAJuRWQ=;
 b=cbIOUn4vEU111BABgScyg5PJK2jWRD9EunGYLdOL/oI7BfeAIdpSCo8FBfUuYuAU3R5Y5Vs+VSDP9bzmQrTAdztZDNRUgrPnQxwLnomLI9ogLPJuVbkcZSmsiYML9Ol6YRa5G4rVFeNoHefoRmOtDmNqtB4YsCTvV61QsLD0oCYxk5/HlzRR4Lkb0k31wbYVZDEPoxDatUMG6bJZ5Wg/IBSQKy9hYuWG0Z3W1mXR5R/LAU7QSZg4pEq/RwlJiBmBGNsLixZ3dcAur2hFbWlfSVoJng8kTRK0ovPvNcZFI6UiGozNMCWObOClN4E2liyCKGglXhrm+P4S7oGRrtJxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nh1lxj9PCsSWVMkkIZBHi0r10FeHPkfqbANyAJuRWQ=;
 b=aEdbHdHpJolAKD6SBHvFJr7DZkY8OzKp8Z2iuxaQ+tStVzvKe4XW2D171PwfGEQsj7swBD4RcJDWMWgYU7eAbaYfGj3fb2g/YlIpg2a82b3dbfVI0bQcr0nphdU/+YdhdJR5otjU6U3OON0V2sLP+zoQao6wub5id70fKP3ITX7Z7sSnn5J1mU2J7zAit258vv4SsVLQcqzrY++7UzgkXMhH36p9YQ5uG4rUkldymrcrlHakWR1MugWhofFQcG7qDpu579ITR5hb2hvlotJdsIcFSW+NRQcWPVUepDy5wlWfKDj72vVowEhsPIqupfgfJqhHXBR07bjDO2vtDnhtsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 14:28:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 14:28:41 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 10 Sep 2025 22:28:18 +0800
Subject: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>
References: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
In-Reply-To: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757514509; l=2471;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BXvXDZX710LlHL3VhMdCOhHWftt+UpXXVRCAilK67Ks=;
 b=9zDrD/AwqVUmmoJAclcKw+kOURqgrmFVFpWJgLl8jMeyB/8o88rRaUhn2MZ+CCmWHnje9ZtfS
 i08ZcMv4xtsCpdQf7M4u0s9eDgHce0MuMH9CqJ+nEgdxcry3rE3+tWc
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: 602dfaa0-262c-47f6-c8c3-08ddf0765701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU9Mc2RkT3NDbkRkeDR4ZWNvU1c5SW5vVFpmaENSL2V3RzFmanRvakp1WVU1?=
 =?utf-8?B?WmhpcUJFNlNSL3dGakVMbnl4QUhsdXU3NTFiVG5KSWk1SDIwR2VFblhXVG9t?=
 =?utf-8?B?WUJOR3RGWi9QV1ljNWdTa3dxaHowRHlocmdaOWRZajhTWXR0Q1FEZExYbzVD?=
 =?utf-8?B?WndpaHh5ZzVsY0I3cnhiSXZlbnA5NEpkOWpKS2dzUnRvSXRodTV4N2hSTGZn?=
 =?utf-8?B?UktCUS91dTNyNHA1T1NaNDljVXJlTWJERkhBVlV1ZDlPeXhRV0NML01IdVZN?=
 =?utf-8?B?WmxxazI0aWR6ZFArTVhua2F1R2FpMHdPa09VZ1h6eUZDUnhSZmlScDJ3bHFx?=
 =?utf-8?B?QjltNDJ6dDExU3lPV2lydVV5SXZKem0yN25jbnIxeXZkSzVzVDkxanBXSGZN?=
 =?utf-8?B?V01NaDZhUFQ4YnVFYXVObGtkVUZ5Nk9YcDZUWGNWcTkvUVYwMGJiYXQvOGZa?=
 =?utf-8?B?bzI4VEU2NUwwcWQ5c3F6TjFYY3BZSHJLSWRsaXJCZC9BRzUySnNab0RNZklI?=
 =?utf-8?B?dzQwbUNrNnBDWENvd3hQdVhEK2ZaM3YrQ0FhZjVYem5OYjg4NG5iYzBKdzc3?=
 =?utf-8?B?Tk9qaGh0UEplWCswb3lnOTMyS3ZrOGdOZTYwRENCeUNqTzJ2TFE0MXk5Tmpv?=
 =?utf-8?B?dXVhRkZLbDhHUHpkUTRNOVVhM081YmZLdDI2bk8rTG5pRDVjcVpGVFo2aTly?=
 =?utf-8?B?K3VUZ0cwS2R1SjVFcERQRUk2b1VXMEZoeUU2RXBPMmphU3pUM1pmMFRhWFJ3?=
 =?utf-8?B?ajZvem8raEJhVUJvdzR6cklKK21FMmpWdGR6eEk5V3NDV1pnU2UvcjJaaGRY?=
 =?utf-8?B?dkJibzFJOTFQeFVXRU5kWU44R1dRdjdRV1ZWQU94QjNnRnhjRm4wY1Zhdzlh?=
 =?utf-8?B?MVdKWVR1SWJpVmN4bTJzWFQrNEh6alpidUpLTjViV3MzSUZFK3hnL1YzaUUz?=
 =?utf-8?B?ZXZPV0tKN0xtRVROdG9hYm1WMERxbk1iVlJHS3B3T2Ezc0RmaTF1NVp5SGIw?=
 =?utf-8?B?SVBEK25pa2ZMNVpER2M1dXEzOW5Nd24xMFMyK1ZRdnFBM3ZQdm1FS0swWUVC?=
 =?utf-8?B?UHZiVkQwZ0ovYXQvVkJWYzYyL0FMMU4wNCs5UWs2NVhEQ2lLZ1NDcjQvZ0l0?=
 =?utf-8?B?c2VZQ2lIa0VjYkMvbzJIak94eUpQU1gva0txQmhjQnNRcUMzV3hqMWxoV0lT?=
 =?utf-8?B?OEtiS0dWN1l6WStnSkxZMkU0ejNCSCtQaXhXMTd5RzBocTNUWkF0SHNBVkFW?=
 =?utf-8?B?NWxtYTY3ZXBMNlBMR3BOTFB6aTd4YlduU3JaWVNnV2NqMTVsS0xSK3g5dEM5?=
 =?utf-8?B?L1Y2U3lFQ0ZYSzN1bXkvUEVVTW81OTJ0S2VJOXZ3TVNDT0dtMmFraUhqeTZa?=
 =?utf-8?B?S0pmVVFxbkZNNUc3bFd4MzhlOVB5UlNnUjhLQTBiZ3ZmVVk1QTFpVk0zRktS?=
 =?utf-8?B?SlZGYk5CMkJIR05Od2RwZG9xN3c2c0N3WmxHQzJWSWFxbG95L1ZvWW1vUm9U?=
 =?utf-8?B?RTE0RTcwZ3M0RFJvUHBIOWFiUGQwaGo3NGF5SXJQazZKS0tEcHhkZWtmNnFh?=
 =?utf-8?B?SnU4NWNUbUphcjVtTitUVUV1SE93VkNtQ2syTmo3V1VpRThISTdDK0lKYXlk?=
 =?utf-8?B?SWpaeFJKcng4azc3R0I3Z3RxaXh0K0NzSk14S0k3NXRJclBqZGx0Qit0Zjh4?=
 =?utf-8?B?djEzMGF4ZkdLVUZZeDU0Y3hZYVd2cEtIajNEL2hQRm1nUFE5TlhYUHVrRlRS?=
 =?utf-8?B?ZytmcG02MTNOc3lMKy90UTVQclVPeGhVNEl4WXRYODBDVEFocWR6YitsdVQz?=
 =?utf-8?B?ZW9pSlc3ZjY5cTlDdVNjbUtCVmhjSnZmMlpzNm1YUnlsR1VqODZaRGxmRVF6?=
 =?utf-8?B?Vk5Xcm5jaGUvSUlBU1kyQTdXZGRDcUJhVXp6a3AwWHhpMXFWZkZHelJSbS9z?=
 =?utf-8?B?OXRZeHYvQmErN3drTXVjWVBrM083N0hqKzVaaGpOWWNQQ3IvRDYwQWg0UDFV?=
 =?utf-8?Q?WnVoA42uBxT6J7h3bKM55QAe2RxofE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzFVUEdZYTVsSHIvS29EL2dGdkFzeTFFMEdmT0hXWlRhejg1dThXeWI1d3o2?=
 =?utf-8?B?eENqRUp5ZTN6RDBVZ1owbFliczJYbS9hWGFha3NRcmZuelhVbU5HYTFtT010?=
 =?utf-8?B?djdkdXkzN1lTREM0WURGb3RtNTVmVEtYZG5oR3AwYWk3UXdRNHlPdTlmTGNj?=
 =?utf-8?B?cjhsYW5peE5YQ3paOVArYVpmL0NPSkoyMlhDbExiSmdDbnhvVE9SK1VpQlV2?=
 =?utf-8?B?V3d0MzAwRXc0N0xkNkNvV1BGZHlkYk0xNTRaNkZxSzdQK29qR0VtNzIvMDFt?=
 =?utf-8?B?aVpCcTJyQlJqOURvQ0JVcVcyVWJqNm9OVEIwSmZ5eWlCcVFBRSt2L2hwU1dE?=
 =?utf-8?B?LzNTb3QvVEpwcnEvRjVmWHZQZHExbkpYOWQrcHY0Y1E1aDBoS1ZkZ2JlSm12?=
 =?utf-8?B?TDVsd3V2ZTB4SGU4RzFEWkdIdkpUVVhRcCt3aWlRUmRPKy9ReVEySGFuMVhm?=
 =?utf-8?B?b2pQYlkwenhlaXMvMWdNTDN1T3pmdWZKbE1oUkpuNndwdXB4b1p2c0hlWXBw?=
 =?utf-8?B?cHFhcnorbGpvaWNOZkY3TVdIaVNqUlNzOUovdnhRZ0lIaEo4L3lhNkw0RDdy?=
 =?utf-8?B?aEJxSUVlWVUvTDg0d2tpSEFLYXZsZW8vVmZFczMrOEN4TXdNOFdaZ2dNMDkr?=
 =?utf-8?B?OVdxQkxTV1h3dzRmT0lkQW9WRFZZS21ibUl2WmdzSjZIWVdxc3ZsNjdSUStT?=
 =?utf-8?B?bEZDTnZrUmh4bjloNC96cG1LTjNJMlpvYlpPN0IvYjBhdmtJMTZFQ003OFZE?=
 =?utf-8?B?ZGQ4U2ErOEJCRnRHUWN4Mi9PbENpK0xXcmwxR09RTUdjd1FiMUY0SUFXOHA4?=
 =?utf-8?B?ZGZJb0Z3bjg5aVdWNUVPSjZpSzAzd2xzRzh2Mms4VTNvalRtRVdWK1F6NVhm?=
 =?utf-8?B?Mmx4NnlLQXNEbjhiSy8wSlI3TnlmOXJrc3J6RVBJcEIxd25QZEEyMDJlR3A1?=
 =?utf-8?B?djl6aHBOeEU4NnlIK1psYW5QRFEvVlMwVE1xUjVQZ0czY0NkNm5nSlZKUWNh?=
 =?utf-8?B?cUUzczFhUVg4Y0tlR0M0YUdrWVpCbVN4d1pHRWdLcEhVdDRja1ZWNWU2ajJD?=
 =?utf-8?B?MzhFNnJrS2ZPTTdrdDRtVEwzejNxemdZU0lGV3kvSThzcGZtenhzQ29ZMVQ2?=
 =?utf-8?B?elZzc1FDaUViUGsxeFZaeHRFTUVMZy9kOEF4R2wrelE5UlU0emtoTmM5Q1lY?=
 =?utf-8?B?cnF4QnViSzlNV0VkWW5wOW16ZTNKWVp5RlZXWDJESHN4OU8wazJjQjlxYUJK?=
 =?utf-8?B?Q0d2MmNtdWNWQ1lIcVpjaGpwMTVZVkVCZDZxUEJEVE92NEthb0JMd3gzWTVF?=
 =?utf-8?B?NTgxWnFZZ2E3dGpqYW01L3N3U1phRG5USHdhR1QvYzMvK1BUdmlHUmE1eWFa?=
 =?utf-8?B?a3VHMkdScHE0N3BSb0M3eWErSytDQ3h6aXZvcnhLM0E3dGhhTjhFUG5ITEIw?=
 =?utf-8?B?dkJocHVkMlNsRGFmekdJSHVkWFpOVEczd3ozREp3bWlMbllNREZydzc2OWlw?=
 =?utf-8?B?M2tCSTlTUjhPZ2xkcWFSc1lTUmdVT3U4YkI3cW5GbnFQSjJwLzFza01DN2Iv?=
 =?utf-8?B?WmJyU04yQ2tISUl4MjNQQ3M4LzEvNE9wT3paYzMxV0ZKTnp3NElTRTJnU2hD?=
 =?utf-8?B?QVlWcTlrbURtWlNudWw4eHhnb2pZaUxCUEVaMUZtR3pERTc0aFZTOGJzNUZL?=
 =?utf-8?B?azZQNGVpM25qaUZMYlFZRGEwTjBkNU9JWmVBa0M1Vk1ZQVBUZWJFQ3hkWTZS?=
 =?utf-8?B?YUgxMFRrVVBra09ON2xQSEk3L1g4MDNCNzhlL2hCQ2RWcW9BYlNkemxWNGxJ?=
 =?utf-8?B?emJBWVc0MUFTM28wZVlMTCtKeXBaSnIrT3NGQjRDUVdzREU4MTBnV2xvdjZV?=
 =?utf-8?B?aExJVTB0cldXQ1NYdmlkTnJZYTJCa0hSMXlIR2wrbHNyL2RCcUsxRllYRU1F?=
 =?utf-8?B?MjJCOVJnZXZUeWFzYnYwVi9jSXBrUjA0RTU5NkJoMGt1U0xiekJoZmFmRFdq?=
 =?utf-8?B?T2Y3QUIrbUw1Q0s1N3ozU1lFcTN4L05odzhjOFRpb2xoNzNoTzhRNTNmRjVF?=
 =?utf-8?B?TWV2bFp0eitkUnZsa0RCSTQ3Y1JwMW5jNUJ4Wkp1NEZMV3p6NkpjajgzNEln?=
 =?utf-8?Q?7U3NUnZxNJVwxe1xgvf5VWHKq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602dfaa0-262c-47f6-c8c3-08ddf0765701
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:28:41.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10u6vJoBR3ULZbXMACEdWe9xvbsL/QzLF2/XoaBYMgWmCOJexAT99FzQ8Yl2HrVS1KyQ0NMGePjqFt6RnGMi1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441

Add debugfs interface to read System Manager syslog info

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/sm-misc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
index fc3ee12c2be878e0285183e3381c9514a63d5142..4678d76b7dd6907533b5131c15ff0edcb66f43b2 100644
--- a/drivers/firmware/imx/sm-misc.c
+++ b/drivers/firmware/imx/sm-misc.c
@@ -3,12 +3,15 @@
  * Copyright 2024 NXP
  */
 
+#include <linux/debugfs.h>
+#include <linux/device/devres.h>
 #include <linux/firmware/imx/sm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/scmi_protocol.h>
 #include <linux/scmi_imx_protocol.h>
+#include <linux/seq_file.h>
 
 static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
 static struct scmi_protocol_handle *ph;
@@ -44,10 +47,43 @@ static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+static int syslog_show(struct seq_file *file, void *priv)
+{
+	struct device *dev = file->private;
+	/* 4KB is large enough for syslog */
+	void *syslog __free(kfree) = kmalloc(SZ_4K, GFP_KERNEL);
+	/* syslog API use num words, not num bytes */
+	u16 size = SZ_4K / 4;
+	int ret;
+
+	if (!ph)
+		return -ENODEV;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret) {
+		if (size > SZ_4K / 4) {
+			dev_err(dev, "syslog size is larger than 4KB, please enlarge\n");
+			return ret;
+		}
+	}
+
+	seq_hex_dump(file, " ", DUMP_PREFIX_NONE, 16, sizeof(u32), syslog, size * 4, false);
+	seq_putc(file, '\n');
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(syslog);
+
+static void scmi_imx_misc_put(void *p)
+{
+	debugfs_remove((struct dentry *)p);
+}
+
 static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 {
 	const struct scmi_handle *handle = sdev->handle;
 	struct device_node *np = sdev->dev.of_node;
+	struct dentry *scmi_imx_dentry;
 	u32 src_id, flags;
 	int ret, i, num;
 
@@ -98,6 +134,12 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 		}
 	}
 
+	scmi_imx_dentry = debugfs_create_dir("scmi_imx", NULL);
+	if (!IS_ERR(scmi_imx_dentry))
+		debugfs_create_file("syslog", 0444, scmi_imx_dentry, &sdev->dev, &syslog_fops);
+
+	devm_add_action_or_reset(&sdev->dev, scmi_imx_misc_put, scmi_imx_dentry);
+
 	return 0;
 }
 

-- 
2.37.1


