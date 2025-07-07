Return-Path: <linux-kernel+bounces-720194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D85AFB868
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13DB188BEBE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA536215783;
	Mon,  7 Jul 2025 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qjqQkNI0";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qjqQkNI0"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022077.outbound.protection.outlook.com [52.101.71.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC173224220;
	Mon,  7 Jul 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.77
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904750; cv=fail; b=C2ZfPa9mhdaM9lPLHFEsPQRmmQ1mfbzstR/ix+Y9bQN+J5eP3cwMYZXoxA0NHkwQ7Jyl6yz7irhA0S5l0O9zv8I+nQcZZr3ULBOjD/II0QkoEprRPRNnEz3ZRtI4rlbS0vIkAAFNCdoMJEV/U+rZY5ifyMsMJmWJxUSz8yBnKbU=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904750; c=relaxed/simple;
	bh=fcC0iXslH1KXK7Ft2KZaSBYJ3jWEZp1jbtGyCzmQyek=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gM0tz6T3Nu7TxXzV1sN/V3xt2FAYLnBuE89IxeztVLMnxTIyG7VRV0xA7PVP3dHW69Mkd8dAuTlqlcHfdrQVYFB8bmm7f1DsGrA4QlJPDbZEnzQAWRnmDHBKo5GWReeqqPnd9n4CFdHu9uKRUy/ot+OvXRJ1f+Jr5y1LPL5NqOE=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qjqQkNI0; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qjqQkNI0; arc=fail smtp.client-ip=52.101.71.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XvowsRJm7mioH+4MgATL9sWRxu+HLnhz6yjJs89b+uxzMkk4Cww9nZVdeeNJ4YVPoHCssu80FuGCbNdCLWxVZsof5/SHSlXqZPolXeu2YqJd7eo2USFg70A087aIHxaSrCtdy5BRBjlmYc1AlvgSJMNvdExsdbFAKM7aEt7zsPt1iAKA0BXkbovJf4XshnagYPLZFcelICNMZedLfVr+VQPd7eRcuu2GO0YwdzL3SAO4RnIqV9bOHMXTs7DOU/2b7uk6erNYhwps2Gge4f5H16yP0ipI8LH1kNUXVIkvObZ+vctrXCuSILSzLk+sR5tl4kcLpA4+hntC1QN64GMlhg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RGUqe/xD/Qx7cbKmYyCIgiQ598ENvp9VHSRVXfQ/dU=;
 b=lGRcnlGtqOU+1jqxnODPrJ7eE3OInKs+5I/2xjejyxR7MGqiaNyYwlWIMuzhBossw/IygVUD+Wx8cI986xcI5hDgh/kaXZbJkQjvYez2l/bT1PcQekAcal8q7ClnCz20vZtGZPXlO/42sCk3XAsBPbJyYU40eV7hdy1JQs3GyiHjtN5DdqBYnL1fv2rsnbPTwRU4QhiGSdZT3Fy2NB91wgymR7ViJIEjZ/GpjexitB7eChc68fd65MCL2vpOSmWZgamL0lT4WZPXu+MjsvJd7GaHdMSrE6cchCVxfC5dgX2y2N6I0jEnJ6h8l7PZikIdHZDIlif1GeIjfDBm43r5pg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RGUqe/xD/Qx7cbKmYyCIgiQ598ENvp9VHSRVXfQ/dU=;
 b=qjqQkNI02UIz2/e5dp2cCPnf+05BcnutzIPgVGb1/wCKc6xRdBZx7ZKNKCkEI8aT7tPT9y1prEg4Jrk/CQsxrQqF6gQzkPUkcbWvX076390znXIc5hP9SnVwf08pO87VyRyNEeXryX3GQzybQUg5xRwmvaj4ynoYFwPtWzvxElU=
Received: from DB8PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:10:110::39)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 16:12:23 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::de) by DB8PR04CA0029.outlook.office365.com
 (2603:10a6:10:110::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 16:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 7 Jul 2025 16:12:23 +0000
Received: from emails-4690254-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-22.eu-west-1.compute.internal [10.20.6.22])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1EBB6801BB;
	Mon,  7 Jul 2025 16:12:23 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1751904742; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=3RGUqe/xD/Qx7cbKmYyCIgiQ598ENvp9VHSRVXfQ/dU=;
 b=oXWgY50TVk1LzuKrE6d3ekmHDfRMGSZWna1GgBRrkr1NaU/24mpIVqSpGblpq+XRTZw1C
 gnt7OXJLxC5hDGsPzim6/oGVVLgnOWarkOWOlW1dN3Cj0TWjB/4aH/DHBpf+Sojt3hNQtyT
 ia1eWU5LZqofv0+3Gl6VC8pAYukncGA=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1751904742;
 b=iSzMYi4CkFbj/Sd0I23O/g5ckub6EIhw7wQNO5tOhv7KvOz10PRihLh6xQ7Hcsj1uGYup
 sl9sMpsdUAcpJRa4vZ/DYhXU6a6lLuAI/BWPmAKCPwXLsVuk0Hj3JVWaDVOHGVVLyxDhXIH
 GhOTBj4nZ03XRN9k8RDvqncc+uCkcuA=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u39sbLyXU40EMnwLUG1NdVIlqW+ZCuKLSHBNnjmJvGHNIE15vSfQcgOdZO5vf5ZUjoepLvQRKQCGXT5CL8K5FpEZWVwf3u2PDBHSIqCyzWdx4BDq6hJpojOgZuPTCUh1QixXjp+VAaOn5oa323drVXCm9z9iezgt1W05xIrh8ZF/OPCeSv5JPKtjKUNxF1va5MsPS7g1FpqXA96stuXXFeGaI+2EgkpFDcjnPrx8cCNp5Jc4KAi3zAeg/G4VhRt2iwTpN5VpyD3YWHP4Z9qPhHSQVyhZnd5yVOsO39d6m1eTKwzzHwLv41OE78BS90BF2ESY8p/++hOKRfd6Rl2gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RGUqe/xD/Qx7cbKmYyCIgiQ598ENvp9VHSRVXfQ/dU=;
 b=ShAIjziriXS4QlJsPVWUJLZO1Ohl/w+12cCETvB1MktLP1Hbg3+undgsdPpe4K30xkpl3HFu3ONr5fBfEPtA4L5uHGkzSYhwiKTxPQdp9LTQ1VFVSbiKMViXljVQH1e+BzcMNEutE8qaclh+Um0zTZL6T7L/kAPfkEHQXCXdi0NKm0fWhVUqt/vgxfjrkTVFyMKvK4pqtUXdGRkqqRW5GynoYLE9r6KW7B76WCE9/+6LIaxqTlmopQ84lqybVIGkF20hB0RFs8mV2QEJkfyMgNs+/QhKWWCcabWMFeKeP5x/gVeRE/jC1nG+tTT3kbUwsKZy/jiDB2J/Emg1mMDnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RGUqe/xD/Qx7cbKmYyCIgiQ598ENvp9VHSRVXfQ/dU=;
 b=qjqQkNI02UIz2/e5dp2cCPnf+05BcnutzIPgVGb1/wCKc6xRdBZx7ZKNKCkEI8aT7tPT9y1prEg4Jrk/CQsxrQqF6gQzkPUkcbWvX076390znXIc5hP9SnVwf08pO87VyRyNEeXryX3GQzybQUg5xRwmvaj4ynoYFwPtWzvxElU=
Received: from AM6PR04MB4567.eurprd04.prod.outlook.com (2603:10a6:20b:19::11)
 by PR3PR04MB7354.eurprd04.prod.outlook.com (2603:10a6:102:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 16:12:09 +0000
Received: from AM6PR04MB4567.eurprd04.prod.outlook.com
 ([fe80::6d60:a27a:fde:6c1f]) by AM6PR04MB4567.eurprd04.prod.outlook.com
 ([fe80::6d60:a27a:fde:6c1f%4]) with mapi id 15.20.8880.021; Mon, 7 Jul 2025
 16:12:09 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 0/3] arm64: dts: add descriptions for solidrun i.mx8mp
 based boards
Date: Mon, 07 Jul 2025 19:11:55 +0300
Message-Id: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMvxa2gC/3XMyw6CMBCF4Vchs3YMLZegK9/DsIB2kEksJR1tM
 KTvbmXv8j/J+XYQCkwC12KHQJGF/ZJDnwow87A8CNnmBl3qpmxVjey2zq0oAcU7NERTM9KkRrK
 QP2ugibfDu/e5Z5aXD5+Dj+q3/pOiwhIrM1S6vXRdZeqb+CdbDO/lbLyDPqX0BbZla12uAAAA
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
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To AM6PR04MB4567.eurprd04.prod.outlook.com (2603:10a6:20b:19::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR04MB4567:EE_|PR3PR04MB7354:EE_|DB5PEPF00014B9F:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cc575b-70ba-4e46-4f5d-08ddbd710ed2
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TnNBS044ZUYyZ01kMTg5L2U1V2hxVno3NFMwbWRFeWZNaEtaMmdiS1g4S0o2?=
 =?utf-8?B?cXFEOElnS3hGbm54bldEdTRBVHQwZnVrRkxkTjBaeGF0dHdlcWtpZ2xnYnho?=
 =?utf-8?B?OVVBU0VhYnlmY2JmeGZoRWtycHhmaTRRMkhyNTZ0MUZpZG01NEZ6eENiOFVa?=
 =?utf-8?B?Z3BTVWZkbVFyT1lZY2tMZ2dvQk15dThGanVLSy9NTG5oQk5RV29OSEgydXNt?=
 =?utf-8?B?ejBZaGdaa2NjQzJUTkI0QldMZWdSZDBXNnRpM2RUTWJqVklDKzdOSGVWMGF1?=
 =?utf-8?B?OCsxZjcrdXJqekdmQVJvQm1nQ0UreUNjdlVLT1MwYUdGZU9FQzlwV1M0K2pz?=
 =?utf-8?B?YkNYM1FVMlBtYnY4dFhTOWkzaXZTaldNL2QwNGlOVys0M3duWHVyZldpUDNt?=
 =?utf-8?B?Nm5pM0JWOXBYSHZaK2F5STFrNUlXU202RDdzQ1c1VGRsc24xcjZsS25wVHla?=
 =?utf-8?B?R3FrMEVsV3RRY0FabmVUemxuSUwrRDRueThxOGk1bWNxcFRVekd1aFRzY2hk?=
 =?utf-8?B?aEJWbkJLbnMzQjNnTGllYTYzdnY1dmxUODlkcUh0dEdmSFZOMVdGMmcvcGhi?=
 =?utf-8?B?YjFsMysxd0pnRGxhaE4yRkNMbDNxUnZHcGs1dVJGa1AxY0R5MWNWQnNVQjZW?=
 =?utf-8?B?OEVLUzg5Mm5wL0IvdkRDWG9wcTBKaERIMXA5MkRybnpCL2VUYVVCdjhxdVRj?=
 =?utf-8?B?NzRWczk0MUJMQ1hYZCt5RVJ1cFN4bXVwOE5ubWxpZ2hoeDlOcGh2NEJFWDlJ?=
 =?utf-8?B?UlNIUHRLdTFGS1dONCtRaEdPK3hpUGFOamoyOVBiNlVTaGF3WTJkWE9xZ2lF?=
 =?utf-8?B?OFBDYkVzVXVDaTk5ZmorUVF3K1hBQWtFVGUwelpvNlI3amVtUk5qZVgxelFh?=
 =?utf-8?B?N2JvMjVLNjZKT0E2VUlIVkU2UGtLRU5sU2Nhdi9qL2lhTXJhamthcGZWM1J0?=
 =?utf-8?B?T0FXd0Q3Q1FKd0wyYlFBQWJSRTYvOXc1SUpMWWQvOWlDcHpESlZLUzBiUUNP?=
 =?utf-8?B?SWEwNFFkcmJVanhHUDUvRjF6eUZ1OTE3VnpsV2lHeWl1UDV3WEU3Mi9kdi9s?=
 =?utf-8?B?dmVTUUpZbVloNFI5cWxRWGQzUHpBVktJTmRZYlVKOWwyaWZvUzIrR2V3WFJr?=
 =?utf-8?B?dE11MUVxdjlzVEtybzRuTlBuUXBhMFZkSU5vTDRtQjFvYW1CdWNuTWpsYncz?=
 =?utf-8?B?cCtQdDJPQWlueENlY0RMUWEvbWRQeHB6VElSSGVzY1VDTEhmYkg2Q0VmQ29I?=
 =?utf-8?B?QzYxenZXQlliSlN4Q1MrOTlyNmlUTlZyRmhBWVRKdTVQcXJzTEV1dlQ0NGtk?=
 =?utf-8?B?NmFMaG1iTVNBdFB0akp6RUJwRU9sSSt5dVkwOEdvYjF4dlVndjU3RUJSRXV2?=
 =?utf-8?B?cnR4VzVKaVdCLzA5TTBVKzBiQUREa3FQNmFaRUlxY2crYmRWVElFTXhzcnR3?=
 =?utf-8?B?c1Era0JKTW5lLytDY3F4Sm81bmJac3RoU0E1TkpYZnNHRWdTODVhc2c4RFBU?=
 =?utf-8?B?di91UWlXRG9jRSthRE1LNzBjQk91ZUJqdGRZaHhvdndzR0xQbU8yUjRZMjZ5?=
 =?utf-8?B?d3FnSzBVckFrZUs4Ukd1Z2EyN1NLMSt2SFh4TmpEZlREWWVLODQzREtaMEd6?=
 =?utf-8?B?QUVSM2sycjdCSGpnWkdqTm1raFpzMzk1eDJNLzVHakRRSTRsbUxhMndRQ09o?=
 =?utf-8?B?ekxFeFRlTGg3VlBBbXhMVXlObkZTYmpLK2xsMlNoc3ZRMnE1SFgycFBtdW9Q?=
 =?utf-8?B?Z05vUGxlbUFsNS9DQnNxa2o3YmZaVFFOVDM0WHg0Z3IrWExJMmV0MVZJZGx2?=
 =?utf-8?B?N2EwSWZtcitReDBNQXNsSCtjM2pJQ2lXZ2hXMllRaTEvMFpKejhBSm92WnBm?=
 =?utf-8?B?Rk1XUUhNclJCNUZ6VXZHOTk4TTBhUXJDNkozUmFMNnNEaUtBbmUxSlVnR3hL?=
 =?utf-8?B?R0oxSVZJdFNMUXB2SHE1c1R3WC95QmJWaUlmWkJBTlJ1aXNwMmV6d01obWxs?=
 =?utf-8?Q?xdbIFYFG1J4wyDLDrlKcxZ+zHKuAUA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7354
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 00297970c8fe416ba6d3998a2617ac1b:solidrun,office365_emails,sent,inline:9dc78d7a0aea7e94852b4c8673104263
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	088ef22e-7d80-45f4-7c67-08ddbd710631
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|14060799003|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDlnMGpZdkNDWmNzdTN2WWVjNFVrMnR3NERuR0grd2h2MWQ4dW1zQmt6NlRK?=
 =?utf-8?B?Z0NyVngvU2x2MVluQzVORUwraFhoODJKK1k1bkFNRnJOWWxGRDhtaHNNcDRD?=
 =?utf-8?B?Q0hKamJCYUJYRXF2ZnNueVR6WnZJMU1pT0E0YjFObjJqb3JINHZpQUNDdTlT?=
 =?utf-8?B?NVFLeEpGVmRWVEx4bll4ektWd2JNZURJQml5eTJOWFFBMU5rUTZEaXYxRjRs?=
 =?utf-8?B?dkIrMkd0OGliejNpK0RlYnpzaFFUL051V3hqNmc3L0J5Z3g3d2ppeWc1dWNB?=
 =?utf-8?B?am0wNko1T2pKbU1vNUFjdEhLdFpKaUtrYmlQSkVFbStWbnhWLzFBTFRwaU9V?=
 =?utf-8?B?bkl5S3JmTm5PNmp0dXlJYXVjVndCZXZ4aHlJUlJxaDVmREhldDJISFhlL0hB?=
 =?utf-8?B?TE1OT09rMTB2RmN6cTRGeDNBUGdPMDFibWw3eURIZjFIaDg5L2lQWUxBQWJP?=
 =?utf-8?B?NDNlekV3MVZ1Tk1kc1U3Rnk1R0tJYXdNZXIzNC9VaGY1MUhCRmVLdXhkWFpy?=
 =?utf-8?B?ZkFCT0FOZ2FzbVB6VXUyS0xhVlpZWnRsVG9GSnRyL1F2cDBLZnRUVmhtVy9C?=
 =?utf-8?B?WEVPWFZjN3lwUUlWTjlBd2VaQmFGQzI2K3AxbytzaFRrU01scmpNVmNaVGNC?=
 =?utf-8?B?TEg3MGpCZmVsOGtPcXBJMGlyamgyMW8yT0FTWm1QVG9hVEx2L0t5dTNCWERr?=
 =?utf-8?B?N0hPbzU0RFV6aXcwSExkQnJoNTYyWGFxcHRQV1pXS2Z3Y3E4eGhicEJhem85?=
 =?utf-8?B?ak5GaUx2QklGUEh2YjhpdEpQU05pV3J3QldEL3pXeW1SaG5uK1N1SlFYWGJz?=
 =?utf-8?B?QkYrdmRMNG9KZFZrVGNyZXpmdkkvVUhrNnRVTEo4ZTBjYllNUGNtMjNzUW9a?=
 =?utf-8?B?dEFpam94clRncDJ1cjVYdm1tR3RyeTNRdVRGN1ZaNUIxMlJNZlA3a2JJdEpi?=
 =?utf-8?B?Y0lyM3FabDRsNlBEWmpJRWk0MGdzdllFSFU1WDFYeFNLaVp4Z1BNY2JhanFY?=
 =?utf-8?B?WVlFS2NpMVlnd3gyT2k0SFdWZXNFUFhvb3poU2JkNWdYNWdXNU1kM3FLRTZw?=
 =?utf-8?B?bHdwVm96QmRpMnZRMnNVOXAydmlwbmlRelpJRmZmNTZFckZUcmhCeFRtcW1G?=
 =?utf-8?B?TGJUM0pKQ1RKdnRMaURzZTNJRWRPMkNtdHlMc0hpcmZCS2Z2cWpDWUd1Nmo3?=
 =?utf-8?B?TjRieStrTFdLbWlvZk9sRWMvNmQ4aThVOW0vOC9mTGN6OFJKNmpOaFdRemxx?=
 =?utf-8?B?Znp3N1BnTmEwbVJUbUlkdyt4ejJ0RjVKVG5CMks4Zk1VZUtqa0tmMTJyc0hU?=
 =?utf-8?B?QUtBd0svZnZHei9JY1ZVS3JMZStZMm9JbVNoV3orV2hhNlhocjdkWnB3Um1u?=
 =?utf-8?B?YzZNbWNFSEJPQmJTQ3Q0ei9YRStNd0Q2REVMK3pUWE1WWXp6YjNVT2tLQkFn?=
 =?utf-8?B?ZkRKVXViUUVDYnNRRkhjNkk3ck9zYXZvN05FbmpRODEvRDZsZG1xeUc5YjF0?=
 =?utf-8?B?R2U0R3lWSENBcXhOSjNJeDJJajBWdWZLSmdPZjFWd2ZwQ3pBK01iSWxJdXpy?=
 =?utf-8?B?K1lrVkhJaEYvY1h6YU0rVEovVDRPcjJKVTA1VDhsKzMycjhTeFNDYlk1Y1Zz?=
 =?utf-8?B?NnlHMWFlV0NhbEc0N050akRKMkRxY2hna3lsc1RpTStNOXVHNENzVGl1QXJB?=
 =?utf-8?B?d0N0VHZqeTBmVzRBN3dsM3VMdEUrRTVpbzZzalZ3amp0aHNOM2tkY1Zhamsv?=
 =?utf-8?B?OS9oYTVFcWRMSzVFMHZSQ3NUNzZWYkJ3RWpBQm5jMFJxWHcxK1ZqY3ZpWitz?=
 =?utf-8?B?MHlpNW1nZlZsb1djaGhGbUR6MWdHTVUwd3k0ZXRjMzlOVlFrY2N2cmFtYXdH?=
 =?utf-8?B?ZENXSVRNcWUwTnBoRjFpNGpSZEJFMFBaMzJnWkxiekQ4Uk5oWnlwSFkwdDgx?=
 =?utf-8?B?ZzdjYytHYUNZRTVvSG43RjFmSkFRVm05RnVMWjZFbERpbE1nZkJRODdmT0hJ?=
 =?utf-8?B?Yi9LSXlINHdXUnFqWEtCczRkMEptaE1xSmQyUzZaOUpIWFNzZEZoVlZQek9t?=
 =?utf-8?Q?RGpMss?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(14060799003)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:12:23.3670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cc575b-70ba-4e46-4f5d-08ddbd710ed2
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454

Add bindings and descriptions for the SolidRun i.MX8M Plus based System
on Module and various reference boards based on said module:

- CuBox-M
- HummingBoard Mate
- HummingBoard Pro
- HummingBoard Pulse
- HummingBoard Ripple

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
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
 arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts   | 224 ++++++++
 .../dts/freescale/imx8mp-hummingboard-mate.dts     |  31 ++
 .../boot/dts/freescale/imx8mp-hummingboard-pro.dts |  76 +++
 .../freescale/imx8mp-hummingboard-pulse-codec.dtsi |  59 ++
 .../imx8mp-hummingboard-pulse-common.dtsi          | 384 +++++++++++++
 .../freescale/imx8mp-hummingboard-pulse-hdmi.dtsi  |  44 ++
 .../freescale/imx8mp-hummingboard-pulse-m2con.dtsi |  60 +++
 .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |  81 +++
 .../dts/freescale/imx8mp-hummingboard-pulse.dts    |  84 +++
 .../dts/freescale/imx8mp-hummingboard-ripple.dts   |  31 ++
 arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi   | 591 +++++++++++++++++++++
 13 files changed, 1681 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250614-imx8mp-sr-som-ceef5bef1bed

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


