Return-Path: <linux-kernel+bounces-824085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6CEB8815A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28097175C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5F2C0F7D;
	Fri, 19 Sep 2025 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ThoeGiLo"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397D28725E;
	Fri, 19 Sep 2025 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265392; cv=fail; b=QWGMvzIt5LX5ms/gYsi7I8ivEeqUGj7i/V7VPubKuDlIjsZU7T9wbpPDF92PafUGk5j2SuGZC+p6C/PTPnyjZPKXlfJY/2If8i8XtekbIhyFmSJWCQKJ1bab4nXw/YjXfd+3JPQqkflS/dJrwuyXnJH/LcDb90rV8qwZ3yQ8fYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265392; c=relaxed/simple;
	bh=534AnPHfU++4meEW/NCzEip/X8zvLJtHlflOYY7w2rY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UyrRaZnpV57thcDaDV/PY0OjDo5tgfWSNiyZDWqqCi1kzkPzXL0VsIUJ1XKT8sy91y4PRlCfd9RghTiHyfF8LVqH5l8uibe1N32NKlR6pBGISOd3ad8txcPaROXXmKO/+qi0AWRZsY0XLpaFOJCmmsKZyLBIujZ9jYJLXGAvV5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ThoeGiLo; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjVtRB3ceRNmRIyCxCydiwWkxlLhl15QX9jmW7is3Wcty2Lo6mSIrCIOn3cqiVT0x3kkB12Xn5eBljbYDG0GutRjl+rkhl1adP1x4Wv9fUjdl6s6soFpQ3F5fprZorUP+4zhiaXuwI9defjsILSHLJFtKCHmB17rnqThNSqA7u4vwdnX4fKduERQvyow7vygkF8drdNZ7AwOTWMcKW4YLmRbMXTh6mfhTgRJzoKs8zt/oDHVzqtuBv1w8Tt0XHdlPbLumYD86N1cwcKiVe95XUH53aGV+jcOl2MISyNzdLllObjno70dYjclo83eSs1YqMiwvbVmk7BtlkXecxrNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dZcghlOw+PMvug7xjZJ9gIQEQL3C1IvT1TNxDzoP4w=;
 b=rYMb/UMAqPOtOll+FVYYnHHuNGjL9/rITNEmh0jolQATL2km5032WM5u+6p5foLXdhrQbIXLL6AOc/XkDUqdibShoU2aXbZpdgR4IDdC5q3sJDpVnClPCzCVPRzL3SZCoEpDIov0dpBM3NlXWejnFSg2K2JnixAkBu/N+TGatmzgpFYANhRwYu9M2BsF5S2JFIOkrEwb5fn/+qg+W0Ec8ly8LD3VoL/PPdbXtHe+CWDoMPztgvBL8nqsWVFQMzsixupklyMiUFR0sJTarKkmcA3tf44XXjaAdKyAxToEiAr6T5nRY+CgmSAJ/VTu4i+YwcZYMIvHXVlbo0BfnI8BTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dZcghlOw+PMvug7xjZJ9gIQEQL3C1IvT1TNxDzoP4w=;
 b=ThoeGiLoTc7XlrTZDL4r2ySOE1Np0vlnwaqcHmx0FbE2zGqpZSC6edUoDfy67RnJkrdpk5rzUGIrpD6chDRYsJ38ATcVxftiV/VyhLufqTS6TOApPy8u/P8ipxGZW28bjfr3uF5rJaLmxvxWywWTH2HzmrMtFXtfnuQZyFqChrerTW7ku76ln52Gc3APw+RxqLrAvxfVREPDaedI6zD82scEdz0KAxisIkDQnKhxdurHm3aNS5bRL3QDZCuUx2wwjhxpuwyL3nuTje5FstjvCfb4KdOVR+1hMg36oyO7rtar1LAW5hTsBVVruCwfntrLvktziOPSWO7CBxz9l3KQwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8554.eurprd04.prod.outlook.com (2603:10a6:20b:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:03:09 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:03:09 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 19 Sep 2025 15:02:57 +0800
Subject: [PATCH 1/4] dt-bindings: phy: imx8mq-usb: add alternate reference
 clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-usb-phy-alt-clk-support-v1-1-57c2a13eea1c@nxp.com>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758265397; l=1052;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=534AnPHfU++4meEW/NCzEip/X8zvLJtHlflOYY7w2rY=;
 b=rjRmya92OgbZlz1ZOd1xrmj3rO+x5nXbU3AN2phmzbGHUXFIczWwpU8+45cTviTeYBUkXJDtr
 uB4XzsZ1xCYCuYyG6FMZEkV0hqzjdNvhVjHywbhkokVGQHQi/bAzDjN
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM9PR04MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: db22d774-8c15-4700-7ba8-08ddf74a9741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjZJZ0xDTUZac2dXdHVrNkZBbDZDZHZsM0svQ0piSDB1bGJrYlVmUXlUUTNW?=
 =?utf-8?B?VWRDOXFsdjJ3R25hTU9tYlU2NkVNWmhOQkhidEp2aEV1LzJFL1BkcnhnOTJK?=
 =?utf-8?B?OVdKZTkzN3BWTTkyL0xuQTlIWks2Y3NGQWdPRGhZRnd0OUg4a0I2a0hCQU42?=
 =?utf-8?B?dVNLaUtpb0VkSWVtTlFxcTdWdkNMNnpwaXBiekY2c1F1bTdJMUNsLzNCajZB?=
 =?utf-8?B?bHNtOURwUHRUZHF4MDVJU21sT3JnTEhkSWVSczk5c3NZQ29abW5nWVdoREtE?=
 =?utf-8?B?TzVQZ3Zvc08xZUEwanROV0dKZU5qb0drZlJvMm1JVHpsRzBPeXdBQUN3VURE?=
 =?utf-8?B?UEI0Sm0zTzl0SEtYdzVsUDVRTmkxcEIxSzRTeEc2RjhzbWFONFRrd3RENlFo?=
 =?utf-8?B?eENvQVRVR1lraUtxSEs0Sk9vMjN2UGZWT0kxRzVoVlNuMWJVSzdPZnZTQktE?=
 =?utf-8?B?TUY3VmNPMzJuV3JWZjdZc2dSQm83dHhOUzBMakpTMWJVWFptdFRCbjRCTUly?=
 =?utf-8?B?SUgxYlovemwzQ0lINUVUQW5ZZEN6NkRvdEJ2OVBLK1NSbE9LbDArb1NHOGxl?=
 =?utf-8?B?SUZEVFhtUEJFRy8zaGoxTUlDeFJNWDJOSDUvVlYvcHNPWHJENFpSZFRpOExv?=
 =?utf-8?B?bDVKYUN6LzVaNFg3SmttaHNLV1NNV3BHUHl6VERyTFNQem4vMzZLQyt6a0t5?=
 =?utf-8?B?WVpld3lFeSs1K2k1M2xoSUlKWDF6WnY3T0FBNmUwZHhITEUzOEFuQTVNb3dj?=
 =?utf-8?B?Tml6dURPZXMxSUx5N1hhRk44VEJJbjNnY3M2TTNrSnlxSndDMjJBajl2Snlv?=
 =?utf-8?B?YVQyY3oxSFVYb0pyWlFDRmJneUplU1p3c2ZYUUJSYWVsdWtKR2hrRUFvSFEy?=
 =?utf-8?B?RzArZ1BPRlFyNWRJZXZZa3g3eXZCN1ZiWGNDTGVWS2JRZXFoNjNGQXo2a1RM?=
 =?utf-8?B?Z1dwV0RpRnlmRm9IRlhRU2FEWHhraStUVklLR3ltOHB1dlpPWHA3NzBoWmxT?=
 =?utf-8?B?eE5aa043R3A0Q3FKNlVLMUFMTG1PQWwyNDVyR1lOenp0OUdmSTFWcWVCU1dm?=
 =?utf-8?B?elQrT1dHUGxjWE1CeDV1K1RiM25tWk1ET3lEVkQwWkZWMnVmZnowTDZLZ0NB?=
 =?utf-8?B?OUhWS2QyOTRVUkJnazgveDhiVWd4THBmMjlRN05tUkxIQ3NiMmFuWWtHcmdI?=
 =?utf-8?B?ZkdoN3owWFhCWUZvVGlXZ3ZST1hHU0JyRjZhVmZrcTI3VjJqODdVREJmbU5q?=
 =?utf-8?B?MW5NRFZqMnVmNVRSVDY5WHBYUDFuVnNuUnYrR2tDS3U1b082Z25ib1BLc1BX?=
 =?utf-8?B?a1hEQ1owRzRFRWp6bWdoZnVqZVh2Nyt2UXduTkxjMkdiaDNSVjJXYjZFWlNN?=
 =?utf-8?B?aHBhK0tIYUszVldoWFdwd01Oa3ZGQkZhTkQrMG9jajB6ZGIyb3dxMVVBaVRo?=
 =?utf-8?B?Vmk5RDJ5V291K2NCMk92YzJrcytZVGZXWlV5OWwvdjdPNjN2Ylp3bFBTYmFx?=
 =?utf-8?B?OVB0RG1HNHdiQ1ZIWGFFdUcremZXemtuNk9SVjdjODl3Q2g3M29uOTZvZHBJ?=
 =?utf-8?B?dXRIWUF3T0xIQ3IrV01Ea2N4cjdmbVBDRXp5OWJLY2cxTzBuVkJwOGU1SG1n?=
 =?utf-8?B?YWlvNU12bU9PNHJ5WDJpOUJaSkNLQjhRcGZIYkZkMitQbUNKWEE0NHVCQis1?=
 =?utf-8?B?UkthSnZWcjNtZ2RrTnF1ZkYybWhXbXhMSXUzWDRCeG53KzlCMTM2MFRhOW1x?=
 =?utf-8?B?SjBXbGIra1A5UVIxWWgrYVp6eHFzbzBtYS8raHpyQTNjdGlxVThzN2ZrTUgz?=
 =?utf-8?B?NzdJNTBkaVBmVXNDTEIvQlFiY2czdXNFNWNneXY2U1B4UkJLU2Q3K2xRQ0dE?=
 =?utf-8?B?eUpvNjd3eFRYWUgzN0d3SmJLUHJMQzdDNGp0YTdoSCtuNEorcUpheGhaWEVi?=
 =?utf-8?B?cmhVV0RMOHN3ZEVtL2l6alJ5ei9KK2JGeVdxMTlYeWc1V2QrdERMYi94Z1Rq?=
 =?utf-8?Q?RewW6ukvXkmj7IKXJExfduHS7tINSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q251TnZhRE1qMXdmZEF5aCtiVjYyS21zL0hPR1Iwd1dEa2Z5Qmx4YmRXN0RX?=
 =?utf-8?B?NVhtYXlXTnFGdC92SW81QW1RTVAzS2pZSGlQNmt0RThjcXI1dGp4a1ZlSEhC?=
 =?utf-8?B?dEk0cmFyTFlZRzdhNk1mWFRUQy9ZTUFMNDRTdVhlVmVyVkVaTWVDVklXeU10?=
 =?utf-8?B?dFZORXozZ0FJNU1TTlhZaFczR1c3TVNDRXExRE1mdFNSZXNjbWZqcFFZR09v?=
 =?utf-8?B?K1Y5dklidklnSWVzeC8vYllZcmtEVnJzRzhrYjdxUDBacWh2S3RhQUJ4eFdx?=
 =?utf-8?B?MSt6bW4zWnN4aTBRS3hEeHZVQVltZWtvYzViS3BCZlh6YXJkZGxmVklhRVhX?=
 =?utf-8?B?bE82VGRnZHorTlVsRkQ2QzBNY2VZcGpYM1VtSEJldUxNb0RGaXJtZk90dmRl?=
 =?utf-8?B?RmFMVys4YzRhNzdWVXRXbVZ0cEdqL2dwandKVGhHeW4yMDN2SWpZQnpOKzIr?=
 =?utf-8?B?N1dueDl2bjFFcWpTTWNsS3hJeHhxMndoZGZ2emYzem5DaEo2U28ralBOcUdX?=
 =?utf-8?B?N0p2aG5xY2JMOUVuN2VLLzRIZ2lwWG0wamJYM3BQVkFLSWtxZkh4OEswNjAx?=
 =?utf-8?B?M0xxMStnVWFwZUh1NXJyK213ckFHZXN2QXBxeE1ad29saVovT0Q4TEpKdE1D?=
 =?utf-8?B?N2tzcTExRXczdFk2V1FtUXVma1AvdW5RWkJXOUF4KzRoa0dNamJnMC9hT0Iw?=
 =?utf-8?B?OHlQMDd2dFY5MTFyS2N5RStwdncxTExSSnR3YjZ2RURJQ3JkUG5zSVhhWFd4?=
 =?utf-8?B?ak9JU1l0UFdhN3pmYzdtb0JoTWVLVGdzZ244MXVpWHgwYzVSekp4bVR1ZTZY?=
 =?utf-8?B?VXZDSVcxcmNzM3p5c1M0UEdjdFpjU3VDUTQ3RThpbWVXcWVhUDlrY012d05p?=
 =?utf-8?B?VlRua1Q5bkVILytWM2tLUmRwaDFSb0FNMlU4ZG5KQnNDZVJYUzdoMHRvZkk2?=
 =?utf-8?B?eWYzNzhqTzFFKyt0eUoxZXhrSnM4Y0hBdXdjWkZkaFp6N2pYbzZzTzg2Rk52?=
 =?utf-8?B?TTFxaFdqMmhPbGRmQjF6bTRCdWFaVkFFZ2lCd0djeDB6ekNOekxOM1lCS3Ur?=
 =?utf-8?B?L3hmVTdTTjFJd0hrUHBCT21RTzdzQ2NBR2hJZGhueXF5SVMzTTE1bk9sUkJj?=
 =?utf-8?B?L2ZZMHhoZmpicDBwK2ZkRVVZb2h5SE14U0tQYjd6SFNWOGVIamJ5UEtCZzl5?=
 =?utf-8?B?bFF4czZReHB4VzZWTVR2cUY5WkF2amNZNS9PRmxtVTlsWUxCZnhSWmNOVEFE?=
 =?utf-8?B?bElicXNXN2lUbGt0YlQ0NjJGVDU2cmJOUnc5Mk5PajlUZ3ordnZ0RW0zU2tG?=
 =?utf-8?B?TEc0T2w4YVRjQ21KeXBaNk1JOEVweXNWaFBKcElDVXhac2RMYm5EMzNHMGxN?=
 =?utf-8?B?TDRZNUorSkZwc0RSOEUraEM1YXFNZy9rcjVnU1kxTVlZeTR0RGJ3bVIzK3Yw?=
 =?utf-8?B?aldHcW1oOXB6SnJDaklJS3pjL05pQUhFQ1Z6OG5kV2dQUzArL3g4am1PaEpZ?=
 =?utf-8?B?eXZIMytNQjJZVUdEbDFnNVM0ZjFPM3UzWGp4TFRIT05kdndyaUdjcFpnRzBW?=
 =?utf-8?B?MnQ5VlcvWUkxSzNhdDhWcjFCaEg5d1hiSHpuT2xISnprLzJ5OGYvRjVET3Mv?=
 =?utf-8?B?YjNLL1BRR2Y2NFRvK1FRM2JjTWpUUk1CTkc1dHMrSFpBSzFMV2FiOG5oU1la?=
 =?utf-8?B?bWU2c2xEUHNhNGdxTnlxVmpnVmwxTzV6bWRldHMwM0EzWVd1YnlCcGF4Y1dh?=
 =?utf-8?B?a1BwS2NHRUNDQzJPdXZFSjk0ZUR5Z2t6NGwzVXdhYzZlZnBYL0pUdlh5OFhR?=
 =?utf-8?B?MDAyb3hCeVpkZkR2R2VmeVB2dENkc3dacG5FcEszR2gxNHRMOEN5Y2sySWN3?=
 =?utf-8?B?SUcyL2VTWGE0LzhOTkNKb0cycVdnTDZxcUtOWGRsRDg5bDVuckpUai80anIv?=
 =?utf-8?B?a2tET25sTGh2MUNvMEltdHhFNFZ6cGU3T2NUdng2MTZoTE9JU2RpRVhucldT?=
 =?utf-8?B?dzFmNEQzNWVxRElWMWUrOHFTdENDbDRvR3YvWm1CblVGUXdoYjFSY0JoQzRY?=
 =?utf-8?B?UXFIUHZub1FoOXVNdmJRT3FBZkhEc1FNLzlLR203QjBhektBYUVBS2tVbi9D?=
 =?utf-8?Q?iBDtSeR86xPZhoTap/jHrKlVm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db22d774-8c15-4700-7ba8-08ddf74a9741
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:03:09.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75WRfjozxtEphJs95CJleNUU1q6Y4uH0QOcvUuIpD61kc6ZxghqZp+iC37Tp32JQRDfzo4DpXOqjxSc1H9DjZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8554

Except default 24MHz clock, alternate 100MHz reference clock can be used
as USB PHY reference clock too. Add "alt" clock and clock name.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
index 22dd91591a09428214afaa4c9c8e37aae9bd8aba..268f86b04ce88cb81d2c06ee507fe0483d713f8f 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
@@ -27,11 +27,16 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: PHY configuration clock
+      - description: Alternate PHY reference clock
 
   clock-names:
+    minItems: 1
     items:
       - const: phy
+      - const: alt
 
   power-domains:
     maxItems: 1

-- 
2.34.1


