Return-Path: <linux-kernel+bounces-851807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9BFBD7541
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C68318A7907
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E2130CDBB;
	Tue, 14 Oct 2025 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OsAtEWVc"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AC30BBAB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417702; cv=fail; b=JJ9D5kXZ+gGezRPhulYOn0N/lEEGM8qi6bhV/6Cf8QPuQc0fmX9vgtytrf+dqLGNyO57r8dJr5tZDn1r9/xH9iSsuZmgmQTTXEBuWufefk8jUcMLu5cg1HGT6zXIlLRljQuTwJ7JMVPiPuVjtJWslBGV4vnyz3XNeMaQQmVH2HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417702; c=relaxed/simple;
	bh=iSDOmlMIcdFsZqbrmwpCLaOJhWOjkdAIsc/nbJUQN14=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iFd70mcirn+1cbiZ+uWE4yk7xFXq7HJO07IqUh55qPeuB8Qju8aGOLUSHk8Rxd4LgbdvYxLkIwmaQmVze6GbBfq3S8QcnJLG8sYi6ZrhMS/3v1ZAwSVuXV3yzfSo9jEVb7LdKz/+FsU7E5BqNjafsrbGss1oPghi9JHy7FQ0d+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OsAtEWVc; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2Nt62oH4h5mpG8+wbQ2iwK4DgDqcVA7EChxozxjNQCYWgW8IqcU3Pk3AKVIA1Y3N6T6ppCQjkXgfnC6biuz70aYQYHzorILqyTgymp1duuCDKOPNGbZc1iqlw3kETOWBumFz44b/+aN5wFOvwEAWF57ejqYiQryP1ZbsoVqRxNPfNY9pQXiBMDlL9T8SBt7EPaR7G9WTLu/vxlwZ8CoGabQXrY7ZSmFw12wiJul5Xk8ID1KjUctXHxIC+hcKq1JLCW8R9wa8LiJbKmFTJhLEW1bZb0YOX+uCaDjwND9Pk3B45HgPLo2AcMYwIjebHxP9XpW6RPEUuZwZ5+2QIOW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbU7tfhh/HzZUXemzbMuKFdhGGNKSbULMyvcXI3NslI=;
 b=OVG5/slHO+ZvB5qbgazkXxfVpd3eWFNl6dsHzSPt+QTGy37lgEoj7VhSL2KMZy/kelRQYbsR2a4ZGgSiGr/7DwjiBHQCNsbFFWBD8hu8cyQhDnxD3pC1kfcIL15s2DuTKLGK1WoJSufGJ0VVD01U4lrlqvMpWl1Qeyd5GAqSEN1FzpHcE9UtYve627Pad1mI9PIN5V85bKaOIKFpQf+7y2YiksxIyrZLd6eVBR4WJc1arV0DKjpN8V5zLM4xIpytXkaQxMGOPk71rNKs6vtbxQ2Ea3JXYYL7JS1sR+cpIYa3J/0Ptf4ce39Sn82cLGuqKWHd1IE97qPmE/eh2znVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbU7tfhh/HzZUXemzbMuKFdhGGNKSbULMyvcXI3NslI=;
 b=OsAtEWVcMr9oLWun7j1Lk6uyYSchFQsCI23e4KBSLUKceDym7g+uVVyaKZMiG7rA1jg4+/V1O6wdhTjNo6IwitUgGUkBvDTbyZ3OMkz8nj4juGVbjDQZvL+26lg97pAZ+jn5a3o1H0jUGsGcKz8x9oUuR5wWb5S9Mr7zGgZx3dtgBBDpHD2Z7k3aORm788KexpTIfhm015vSjqshPP7Ht1LKd5xzrCVoTVV1mKh1IRVqZq+mumnP3PCUouTwhBzV3TFryllt1U7Y0IIQAkRBykXaQsxMVC7snCX+ho1wLW2ewB+7tKVSLAESld8TQIQmPnXyziPkWBFLD927nc6oYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 04:54:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 04:54:58 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 14 Oct 2025 12:54:38 +0800
Subject: [PATCH 1/8] firmware: imx: scu-irq: fix OF node leak in
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx-firmware-v1-1-ba00220613ca@nxp.com>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
In-Reply-To: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760417688; l=1099;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=iSDOmlMIcdFsZqbrmwpCLaOJhWOjkdAIsc/nbJUQN14=;
 b=cS+1nCF0ioEbPXo3yztlEXtFmTglMZ5W7Jjnp214PpT1ezw4L1CgDpbvK222kiAE1k7Xc/+CW
 iT2GpCBTvRpBTqMFzC8a3VqEPUyXF0Awb0jWZZw/OWZw+4S3WTQIQWe
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: a02dc053-6ae4-445c-c88f-08de0addd36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUlQV01YOXAyU1ZQd2RzYWZibnBaeWozMy82Q1Frbm1jWnpFemNOMzg1ZmUr?=
 =?utf-8?B?VVlFczhwS2dKWXI1WGFDSjU0bXVadkJGR1ZxUjF4U1VvelBJVW8rV29TTWxY?=
 =?utf-8?B?VUtwbWdJRWk1NlVLcnVTQWJBeXlzRlBLZDhMbWFUTGNCTERteWhsdVhZVWY0?=
 =?utf-8?B?Q1B2UUpDTUlPaXJabk5xS21FTkZJUDlCNWx2UzJ6M0pPRHBUUjdXZ3dCV0RM?=
 =?utf-8?B?dDlleHFrRDJiQmpnOWU3ZFV2aEhBSDdWbmw2SjJQUTBXTE8vWjVIUFN1cnVp?=
 =?utf-8?B?bEFROUVpaWdWL0lCTTMvZWRvaUFtb3p0emtmT3NnQVRiL1NaWEp1K1dNeDV3?=
 =?utf-8?B?dTM3Nys0bE85cDFjNSswVnRRZUZzcDB6RTN6WWt4WEdtZm5WM256UXFqTStZ?=
 =?utf-8?B?dnkzOTBVREllZjdqOGhaQW4raVNEZTNMMC9XODN4YXVXcUZxdXNwbk9VNXAy?=
 =?utf-8?B?YU9WbXd3Q1BoRXd2RmluSkM1SXg1aW1yWFppekQzNDJPMlg3cHlXM1lSYW5p?=
 =?utf-8?B?SU96SGN6OXlMb3RKVEIvVlVKYzIwdGt6SitEWHFlVnBnc1ZTS0JMLzlYWXJE?=
 =?utf-8?B?V3JLS1pJOGVIVmtlaG9vNTBwOG1EUkxyUTl4SUhzdTZYOVFIWDZ5ZGpKMDdJ?=
 =?utf-8?B?R0NUR0xIUjgzNlhjRHpWa1lBV293ald1ZkduZ21TWnkyYjYwcFdiRXN6Vjln?=
 =?utf-8?B?ZG1YMFRGejBxM0VVRkVOR2pNeVdPUkN2VnhDa2krL0VVNllaT0JMNnoyY3Fh?=
 =?utf-8?B?UWlwd0dma243K2VRRWF2NDhPcnNaN1NuWUdWNE0rY0hsSk5GbCtFdjhPdGJw?=
 =?utf-8?B?Uk5GOWYvZlJ4cUFndWd1TGxBaU4weElOYmJXWVNRUG5kQmxWNTU3RXE1UW15?=
 =?utf-8?B?TVd3bm55Vjk2dGNhbkZXM3EycDFBMmtRbzBEeE4vWjR3b1hrajlNUnlvOWti?=
 =?utf-8?B?ZGRaaytnN01MTDRYV3V0bzN2U252RFNXRXZIWCtNTVlxcVJMempQK0FiakVv?=
 =?utf-8?B?emFjMzJoSEJMb291SW8xUFJkRzdwbjd2UTJ2bGhxUnV0bHFRV3NyY3ZOdjNC?=
 =?utf-8?B?dTlDbTVFYWRBS2pRc0JON3ViUklLcHJuYjlNREh0Nmp1T1k4RDFkZzloRXdH?=
 =?utf-8?B?UTEwS2tyd1Vyd2tScE4xY1I3YWJiQjJyTlNtSjdKYXplUE1PTGNFSVB5RGlX?=
 =?utf-8?B?RTV3Rno4dzRyTWlkK3dMRjhxY0JVWENNYjUweDMyQTNodWlMaEU4VzR2Q25Y?=
 =?utf-8?B?SzFSUFJ3MVZOKzVoYVFrOXhmOCtSRkJkNmhuT212d08rUVdyVWxRaFR1T3Bh?=
 =?utf-8?B?OUlNR3NXUUJmcXluNEphaXVpSnRIL0FXK2JwRVRJU0tsSEtXc3hoVndxMHdX?=
 =?utf-8?B?QWZiZDhIWElsaERNSVBwSE9vWkZzWUhyRzZBeGZ5S05pd0hIVjhyQTBaL1h0?=
 =?utf-8?B?ajJLQjF2SE5DKzFVZ3NUY3hnQ0pxSWpLSS9aRFlydXh0Z0p2REY3OUNGYmZn?=
 =?utf-8?B?Q3A1dVZGR2pxcVBwb3NiRGFDaDdmWWFRNDRCU3RPb2FuclNxYXpTblpzVVJi?=
 =?utf-8?B?b3Zuc0YxZkphUzI1cVU0dXVzVDZRZWV4QTJVMjgvSUZjR2V1cEIrNlpoYTVM?=
 =?utf-8?B?dVI4a1p6VWp6dm03Z0Jwdnc3TnYwNXdmQXJmUnVvV0ZOa1F3RmlML3BvS2p5?=
 =?utf-8?B?eHEyWFhnSU9kenpqV2pEenNBU0RoUDhLN2VnMnowRGplTlY4V3UxWEF1dzFs?=
 =?utf-8?B?ZUUrTVFiQW11cHVVREY5WndoSUpOaVA0N1dMc2hnaXErbjV2VTQ0N1JPUlNF?=
 =?utf-8?B?WThoSWZwbHlnYVBmQmZnNnBScFBSNWxrYnY4SzNMYVQ4K0k5NGVhdmEwU1hO?=
 =?utf-8?B?dERBeVpJYjJUWHU0SVNxV0ZhSHp3cUlLTDg5OXY3ZHNsbllFNXNzSEJOd1ox?=
 =?utf-8?B?RklqT1VhdThXYVdxZkMxVklkZWkrZE45NDhPcEFXRm01QlV2b1RrQUNpRUpC?=
 =?utf-8?B?Z1Q5S1U2QUJFWVNrNWNtaXh0NStKM3oycDJVcUFBWTBsQUhNU2tEWWpwaVJY?=
 =?utf-8?Q?xIoK1W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUdUcFN1eGZwWEU5bjlhNEd1aVlYUXJ1N3BaaFdUTE9iR0JQYU9rSGNkVUJz?=
 =?utf-8?B?TDVOd1lncVhEMzhMZGJabnJUaTJnMk5YeTNQSFd1M0VSVDd5OE5PaGFuWVpo?=
 =?utf-8?B?SWRBamtXbFJVVC9WSlFWcFcvTnZWS0puNVhnV2RIQ1luY2luMkxNNTNSY1pD?=
 =?utf-8?B?TlpNazFFQ01xekhPdEdDaUtsRVQwc0JzekJjalBhOUYxVzRMdnhGQUwvazl6?=
 =?utf-8?B?aHdWUU82NVJiMXUzZzdFOVB4L2ZES3E0MkR0U0MyYUQ5dG9qQnU5TmZiU0E0?=
 =?utf-8?B?V1lXcmxjU1Q0alNKYkduY2VyajU2Mlg3QnozWnU3czhsRDc5Z1dId2JsQzkw?=
 =?utf-8?B?NzZvVE0waXdQbmcvTDAvWlovMEh1Y0JlbUFSTTZPRUxHWG15VC83OUtLQ1Az?=
 =?utf-8?B?UTR6SVRTYzNKbUJvTFlDY3MyTVhFQmh2TXlHSTQvU09IVCtlblhZdTkvdUpu?=
 =?utf-8?B?elg4Zm04cnVJeGM3QXN0UkxmcHdHRmdLMGtuMEZCOEZEdnNLWTJaNG9Uc01C?=
 =?utf-8?B?S1huOEU4S1FNaS9HNFpEakdTWldVV3hnWW9uY253b09FTDYreit6Mnd2LzQx?=
 =?utf-8?B?c3RvdjJGNUtkZGcwZGZZVmthaEtnV0Y3ZU02MlVnZzdwd3ZQemZsdEZWTWND?=
 =?utf-8?B?bEJHZHN3NitBRy9uemNQSnBYTzN4dWtQV3FhNWJxUzg4MmdhSWlsZXYwNlRo?=
 =?utf-8?B?ckNrUUVPYSs0T3JNazlWcUZyb09zcFFuRTU0V0hpQU5iSGk0V2J0UUlwRzZE?=
 =?utf-8?B?czR0RDU4ei9TUjhSNXFXMEg0blBpMTFpTmZNR3JpKzZ5VllQcHdtamRRZjZp?=
 =?utf-8?B?UTFOZ2diVUdoQ3VTbDRQdGc1N1FVem5hbDFXY3RLcU5VK0IyWUtxMEIyNUhm?=
 =?utf-8?B?bkRaWEY0cWdGU3NGYkd4NXBKYm9lSDBQbUh5RkIxeDE4eE1uQ3U3YXQvdi92?=
 =?utf-8?B?OUFWZURiK2dBWUhVSDNUeUNOSERnTDQzOGN1ejE4bEhUQUJkaXU5S25lWGV4?=
 =?utf-8?B?WFFZTGQySE5SYmV6TXhSVkZRMFF1ZHJBc1B6L0FNeGVrbDdWZ000Z1VLcXV5?=
 =?utf-8?B?MDN1QjZTUXNxOXlucGJUcGhoYTNxblA4akhDZk9PY2pxY1RraFRFeEszWmZW?=
 =?utf-8?B?WnhqcXJKWE1EcVVPTjFnUkJuc0szdVJRMzBMNmNGR0FRa2FXTHdxc0NmUzEv?=
 =?utf-8?B?VHJLbkVOMmlOUUlEdHdIdk1RRmpqbW84dnNubHZnMlpQWUpHKy9Jd2EzZG94?=
 =?utf-8?B?Tk9KNlNRci93aCt4MUJFTHRPYlVEQ2JXSVhWK3RxYmFzL3RjcWtPQjJZdENO?=
 =?utf-8?B?VmtnbkZsUVZWR2dhZ21mYlh2c2xPR1RVY3NnWGJuck1sR1pUVUlIVEtTc2or?=
 =?utf-8?B?eDZneGpqQnRyMXd2d0lRbVlCamltc0hnaHRxQVhGZVpSbjBVYmhHajdhZnBH?=
 =?utf-8?B?T1hPT252UUJkZFF4bmtXcFd2S0lJckhOcmhUUVBqaC9wR1dDcGxzazl3VFdi?=
 =?utf-8?B?TzNtRS9ESDFYb0xndnQyaGwrS2ZOVlhkQVp3MVdmNDJONlVnQzR3M1Q1SCtH?=
 =?utf-8?B?L0VLdEdia0hGeEkvVWJDZzVrYzN6WmNGNU05ajV0citndHRpR21VT2dtUno5?=
 =?utf-8?B?bHdHZndzYytxeG9sRVJMcXRFSHVqckk2TWFaanFVWmVEN0x4eWIvQnhLa3R1?=
 =?utf-8?B?Lzd5KzY1WnpPQ0Qvcms1MjUyMlIyOXpGeDRKZUlzempERmpYeTRpUDRXbCt5?=
 =?utf-8?B?bWovTkpZU1k4SVBPanJ1d2daejMwTkFjaEZTMlZleWRQYzNQZXpQQlRTQmhy?=
 =?utf-8?B?dEJmMERLMmNRRGgreFJhTmxGblR6U2hMdzhmVEFxbjFWSFlubm5QWnpDbUhU?=
 =?utf-8?B?UWpiVW5HMlRUVUVEUzdzc0N1Zit5NTZDRER0NFZxWEZpcDZYTmpyQjN3UUFB?=
 =?utf-8?B?SW1ZdHBxSS9FNzJwWjJUa2k1bDJxZVRFR0xTSW9waFFubnhMaDdUbUtjaXFJ?=
 =?utf-8?B?V0IrV3NXK25ZQk1YcWlVSy84TytRYlhsMGhSK2JkbFNtOEhwKzk5OWFwVzhr?=
 =?utf-8?B?YzJZUUNQbXppakVTTDNmbWNoN1lnNzJYd2JKZUpRWm1iN0lzSzd6anhNUi9j?=
 =?utf-8?Q?zlz0RYiSwdXobPJjazz2aI1uP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02dc053-6ae4-445c-c88f-08de0addd36d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 04:54:58.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3dhnwYvmacbT4h9nA0CPNHQNmMeqKRCQs3Y35+V9rhRZCkPhZxvWqaJ0OvCGOODrm3L4PaYB7dhRexYvpyZzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

imx_scu_enable_general_irq_channel() calls of_parse_phandle_with_args(),
but does not release the OF node reference. Add a of_node_put() call
to release the reference.

Fixes: 851826c7566e ("firmware: imx: enable imx scu general irq function")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6125cccc9ba79cd3445a720935b5c0b276c83d73..f2b902e95b738fae90af9cbe54da4f488219906f 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -226,8 +226,10 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
 
 	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", 0, &spec))
+				       "#mbox-cells", 0, &spec)) {
 		i = of_alias_get_id(spec.np, "mu");
+		of_node_put(spec.np);
+	}
 
 	/* use mu1 as general mu irq channel if failed */
 	if (i < 0)

-- 
2.37.1


