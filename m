Return-Path: <linux-kernel+bounces-882619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B52C2AEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549933A9F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB12FBE08;
	Mon,  3 Nov 2025 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OYZtZ3UL"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDB2FB09C;
	Mon,  3 Nov 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164485; cv=fail; b=qy18cgc8rt06gcie+I6GOgpSxktZmrD26p1npsvTFVf47cSXZjqQZZYvuF4m5uFlZjnmg+qfe5mCUVMVVMONFXguxWnfM5u2Ur1iFZCB0DKcDscWA5pt45jKGkufryvb4xHtkrHbq2reh7K4wFmTNKQ8tuxFesMtDqlvnyDTb7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164485; c=relaxed/simple;
	bh=5bqW2WdwzYM4Jdk0di1BuBB/q9/ukfjEROuxY9UA5uU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Cr6hBzNRi7tJbNT+aIVMIGcMnZWICdoxOJIWdC2UmD8pdhpdFa+vVWdFlkhYTOGzbwDNhawT3jSE9yNQny2mkSZUfHiFSAFYRITDqmnmC3AGNQWLmn3ELg4x91C2idpR93ggwLgEIhhrH1tb5a7xdpB0pwM1APwz8caYby3gBuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OYZtZ3UL; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO3sheB6UI+sUfmCoIuMwmnbSh/Xj8/55GF0md7Q6BEA9bjJE+EdrJzyK9PTyg1LIOn7CpiAHHcuVOChowLpsqqkHT6CJAa49G58zenHYj61PiwfxnTUg8XLLX2Rlh6qBb0+A3lHtNhJEkB1HWYjvVNOqkBhDWo6kWWxky/eu7PxJuvE0Sx/AcncNs5EhMAUAtWw0+JUEddrYjrgWjbyrGUVk8x/HTW7t+IXHLRwiKA/LPdYhD4npSexJMahzpbm+RF54G6y2tDZT8qvCn/KZUWbU4UFjcfZmlga3lISBQnyBSwYmqfkg3s6s6OjTBxjsBTLikOPHzC7fvrVGo49Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNXtGZ/I+As9r8q/e17Fsh50K0suyShfVZGKKvR+OjI=;
 b=VWQOivrZyDFJR0L5+gE65d2gIC2so9l7s4ky2TNDe9zN5O2S11ZjrmaKpTqJHM8i+IoxGWC13B9ZGU8f6xaReX4rBort/8MTJG9YRGWKg8/9bWOebFViRDuC4QjWlsLk8bfTQ8uwWvpaMVclFbsRt1keWQfgKhINUqBVuZQtsOtvM2rU5JFQD4Zo0Hov8aU9C01hjhOnmIVf41wcjlXCkfkmGY6jMOuuiFT6g88zSKUCRrdGwAS4eP0PhE9FYr+BDfYVUviwK8Trev8l6rkz7PS3vJH5/rUFCKRaPBP+Z3nckBJODl79PqhZTM1qXLyz+4YGmM8A8ZjiOEY56J9gBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNXtGZ/I+As9r8q/e17Fsh50K0suyShfVZGKKvR+OjI=;
 b=OYZtZ3ULasloi6srHmmXBCbgxDNVoU7smpDzOqjXqcjQ9aRerb6cTiXUltZkvYsWQ2dkQCXML69nwzDLuEAIQj9VWZjggfpf91UXwHG92b3+PHwv4Ku2oqNB+q8ZLLOfVxWZqeKsbz67fkGpYi/B1oEVVQtoljTRfhUnaxiFeu6xJGDfrOaLhUomDCHAmy9MBgdEgzq4SARFMhul3NW05YWNUPLoq/cqWC6HndD7LROuDJip+Hr7+ZF+NkWfkbIP5KpTFEDV8GazE5xJARJ997cAXibWg/QD3bSQbGQlpMfPPf8hjFxivVKJmQHhLrt7H3p23vYawD63T6puFuaZCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DUZPR04MB9872.eurprd04.prod.outlook.com (2603:10a6:10:4dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 10:07:59 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:07:59 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH v3 0/4] Add i.MX95 USB3.0 PHY alternate clock support
Date: Mon, 03 Nov 2025 18:08:31 +0800
Message-Id: <20251103-usb-phy-alt-clk-support-v3-0-18b8bd4f01b0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB9/CGkC/4XNQQ6CMBCF4auQrh3TFhBw5T2Mi7YO0oht00IDI
 dzdwkJXxuX/kvlmIQG9xkDO2UI8Rh20NSnyQ0ZUJ8wDQd9TE055SRvWwBgkuG4G0Q+g+ieE0Tn
 rB8CywFMjFK1qStK189jqaZevt9SdDoP18/4osm39b0YGFMpKccFyRMHUxUzuqOyLbGLkH4VRR
 n8rPCmiLWRVS1kIrL/Kuq5vnM4OnQIBAAA=
X-Change-ID: 20250919-usb-phy-alt-clk-support-e54e69ac0780
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
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762164524; l=1533;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=5bqW2WdwzYM4Jdk0di1BuBB/q9/ukfjEROuxY9UA5uU=;
 b=zx/K/yIIMBBmRir1DRsgXre12V8upPNt0ywr+Y8FTuDPu2oLXOT+U6mCLlOAKD7GrsVzf9Gvy
 uOApRYn72KGCb85lltFwTmILX1p9ne9BxUzgDdmNnwLyzbFUZCYQjhs
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DUZPR04MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1e8903-0c24-4bdf-a22d-08de1ac0dda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGpOQzhQSUp3V1UxWHB3cnMzQjNnMU51TXI1dTlldU5YQkYveTBJNlpOSElq?=
 =?utf-8?B?cmpoR1Y2M1J1Wk1xKy9pQmJWZmpqOHEzWkw1RlR4QkJpOXFUZ3NKS1lWMmtt?=
 =?utf-8?B?cnZ0WWVuV2NMU25qczNoYm1hd1BJTlkvQVFTQjJ1SThnVTNkZVg5S2JOSXp4?=
 =?utf-8?B?ZCtNcE9GT0x1L1hxS2hLZ0x4QWoyVWN2U2RyTm40SVR6N3puS3VkY051NHdF?=
 =?utf-8?B?SzBnOVV4MkdJTjRUM1RweS9jQVBHWEZNYjUwc3VIMHp0c2Z2T1NDTXZCT3l3?=
 =?utf-8?B?RWhWY0dTSTZ3a3pvZXdqdGNjTjZiSy9mamI2YXlVemU2U3o0WFNRekpXSDlr?=
 =?utf-8?B?dUdDVTRpQzd6aC9USzlLTTFNejJOQktjRUFsOXRrbW5QR25GM1lUMkFSc2o4?=
 =?utf-8?B?SGtKVmlnS1FKdDQvd1cvb0dkZyt6bGZ3TlNSdXpIcmR1eWs1V0pkTTBLcEF2?=
 =?utf-8?B?SUhBWTZWRzBCYnV6MytUcTR2WHVPb1JGVE9QYzJNMmhYSlVsUDhoQ1ZSc0NN?=
 =?utf-8?B?OGFKNEZqM3NVaEd2dVNCNUJrd0lpQTZvZHdDL2hyUHovazF1enc0Snczalht?=
 =?utf-8?B?RVpsdVgwS0tXd2pwQTNKQkFscDYxVThtdVpaWlh0bm9nMmxGRGppdkMrcnRp?=
 =?utf-8?B?RXhGa0J6RWsxY2wwNHlWc3VoUkNXWHdKNHp1WEdjeEFDenFYcDRJVXBlNG9S?=
 =?utf-8?B?ck1PVTgzaXV4aFNaaFB4Q29jRmNoNjVEWnUwK3FLUHUzSnh1anNDS1pSZm1u?=
 =?utf-8?B?RnhpZGdyR0xLYllxWTB3QTdHOWdUN2ltWlFYSWVnK2g5cVo4OHoyTW81SDAr?=
 =?utf-8?B?d1BzdDBsVDl6R3lvTnI3TnJLbWFITFhFWkdGU2w2UkxoUWVpWEVyZVgxQ2Jn?=
 =?utf-8?B?UlI4aDQ5STN0bzZuZHFLS2VnVUVCUis2TGlVdndSMG1nTmJuNWxKcEplWkpD?=
 =?utf-8?B?L0J1a0dLZ2w0ZTB2cW5WZ3BzYmdmZ25CWWdVVzM2M1orUll0L2NubFd5dk5I?=
 =?utf-8?B?d3NHTDFOOXZvZ0hDRXlFaC82TFpvN1R4b1hCM1ZNUGtBb0d3OFpnVjBBVEZp?=
 =?utf-8?B?c0N1WVlpR1R6b1c5R3ZKZVlqcTBVUWRUanF2cWUyZ01uejJPQ2Z4Zlo0UnNj?=
 =?utf-8?B?bFBjaEJxU3ZzT2dKODVPQTVUaVArRUFIR1psdGx2aDY4b0x0M29Tby90VFcz?=
 =?utf-8?B?RzRpSWlSN2lISzJ2Q0N2cENZS2Z5WGlhK3hvRHRXa1hRUUFRNm90V3p4Y2l1?=
 =?utf-8?B?ejZFN3RZWnZDREpHZGN1L2JYdUg4SCtBSXUzUjFQYUZrdEhQNE85eDUvZFNs?=
 =?utf-8?B?RGFiSDVYdEZaMVVLdEE5RzhnbmR6V1VVNGlVNFlLL0NMMTR3MjVnQ0pNOUsz?=
 =?utf-8?B?aE12V3Y0Y05QajBhei9WU2p3QXV4blFROFA4VlJmWkdEb2NkR2Q1azY1K0N4?=
 =?utf-8?B?bDNEd0Eva1lGZ1V3MktjRkRteUc1c2Y0VFI5S2VpVGUvZWEwL05OOE90NkNI?=
 =?utf-8?B?NDY4NkhCaTV0RUQ5SDRJZUtSNXd6aHNSZkhDTmFKd1Q2bTgxWllJYSs2MG0r?=
 =?utf-8?B?QmgvdVh2Q3pzSTZZYXpncHkyOTM4bTFIRW4rNTdDSnZ0cUxDRTI4REFDVlY5?=
 =?utf-8?B?dGNBKy82L2phNlFvbmlycHdmM1hYaHVKNHNJMEtMc091bTU4NEl6clBHWlV2?=
 =?utf-8?B?K0o1NTFIZEF3Y3RHdzBmcWhVSDNVSzZYM3NLN0hELzlYdDQwUTRLVWpOYnB3?=
 =?utf-8?B?WjI0Z2RzUE5NbTVYYURTemoxdC9JN3dLdXY1b1hteTZIQjdJZHdjRHRVdyty?=
 =?utf-8?B?NTc4QVU5VTF6dEpEcStYSDYydXg5NmpKc2RsekFtVGVhQ2tLZkF3UEZCSGxq?=
 =?utf-8?B?OVhiOEVCNU9YVXNJNVNEWEh3TXUxWWNITWZwUGx1am9vdmorY0o3Z0tJVmVt?=
 =?utf-8?B?MHlncGREc0hGRURWK3JBZmZHanJkWkN0RlJxWHczWXJMWDF2QWh3c3cwMWRX?=
 =?utf-8?B?dk54S3BsajZ5VUJWZTJqcUl5RWJaNHFzS3JmaTVlWmhoWFBsdzUvbDhlUXV1?=
 =?utf-8?B?dytvZkpnSlRVaTBvc0wyZ1J6RGhuSHcwdDRxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTFoOUVNZFpNb1Rnb0pkZzdiT0t5SnQvOXdwYUx3YTJPRXpBLzdURExQWHU5?=
 =?utf-8?B?UnRTU3dnaTBMSlMzZVlIZmZpalZEMzhQU1pMVlN5YWFEdWQ3MDc4SzJGY3NG?=
 =?utf-8?B?bG94Y2g4djFaQlprM2pLL2Rqd2kzN25EMS9wOFJKNERBNlR2Z0ViSGY4Ukc1?=
 =?utf-8?B?NTFDVUVYTldoRVB4MnF0dGJkNjBIdk9uTnIyakg3a1Q4NEEvT0ZBdFNyakQv?=
 =?utf-8?B?K1VYUnI1LzAvZ3dxako2WW8wRlM0M3l3TTNSTzFDdUVSTThBR09vUUpScncr?=
 =?utf-8?B?NjZZQm53Um45YzRpWjV1WlRhTGx0VWtmSk5wb2ZyQXcrWVZZUzI3eG5melRU?=
 =?utf-8?B?N2dXTTJDRWlPLzkvRGhWMDBWYnBMTzZvbC94ZFNzNDBzMXNDM2NBVjlTcnZO?=
 =?utf-8?B?bmdZWWM0ZDVaRlcrTnpNMEZIK2dRZ1hZcVlpc2JzeUtVc0x2TS9CNU5XK3Jk?=
 =?utf-8?B?SUYvQVQ0VndHRGRjM3dFaFZvK1VtVEJzL0x0V20wQ0FLUWJyZ1cxeTg4MnFW?=
 =?utf-8?B?Sml2RVl0SEpFVndQOFl1a1RiOFArT1hPdDdvdVBlaHB0ZGlqV3lTMXVuckF3?=
 =?utf-8?B?UEtLODVQdjh5eUowWXliWlNIdFhwREZYdFFZSWQwN3VtSEZ5NDlnV2hzb3N5?=
 =?utf-8?B?WlI0SEU4Nzd4N3ZnL1U0OXlicngrcHBmaTgxclN3aVN4Tk43c2h3OVEwWm1y?=
 =?utf-8?B?S3NNWlh6UHJVL0ppOVNYeGp4ejgxSVVseEt0RjloYm9ETEVzdTV6VGxmY0Y4?=
 =?utf-8?B?eXhVTjVROGRUaDJwaFhlS1htdk5zczRyNTd0WVlCb09IeElzMWVFbEVmV1NO?=
 =?utf-8?B?dDc4OWlsZ1lJbXNWYzBBakc5V2pBbWJ0R0s3M3RTU3BGSm91bFVZU2Z6SDNp?=
 =?utf-8?B?VGlObG9JZ0w1QkZPTmlIc0RWaU1mdlV4Tm0zSXVQbHYxWDRoa2JYQzNSSW5Z?=
 =?utf-8?B?RDdTRGZ6aERxb0F6MjJaRXBUTFN4eU1oL3k3cHd2U1E3Yk54Qy94V3N0LzM5?=
 =?utf-8?B?cFRkVFNXV0xoRWRiOE5vZVpUdEJ3TzNndHh4N1B3ZHhZaVdXNy9FdkRmb3RJ?=
 =?utf-8?B?MkJubmZOaHNaTFcwa3BNTyszZ202WVhiSVB6aU1SUVVidXQ2RlUvaGVPUm5O?=
 =?utf-8?B?RW5YVGYwNWEyVGNNVmppdEZGYTVBN29qaHVMbXkrcVRmajF1QzBmQW51Uzhj?=
 =?utf-8?B?U0NhUVNpcVRtN2pQL3pBWUNhZkRtcG1LQWcwY243ZTJhczRleGpIcW1DZEtU?=
 =?utf-8?B?R1hTQklhSmxtTW8vYlhXTEt0SFRVUkR6L3Q4V1dsU2N4dDc5elpHcUVUWG9S?=
 =?utf-8?B?bmZtTmlaQW9iSGJoZ1FJUGlTck91ajFGMXU3R2p2V3lIRW5pU1lsUlN2VDJL?=
 =?utf-8?B?YmMweXdta3V6WXZsb0lMbEFoQjAwZ1k5NXpkaTVmdElOMGtQNk5RdkluUE5t?=
 =?utf-8?B?NnJWQ1dMNXFRN1NZR2pwdXpXUWlpNVp1TVdRQzREcTJnVlJnbUVyZWMyUGJ4?=
 =?utf-8?B?WjZvWG5MNG1QNENVakt5cndqV3RpLzNyS1ZhM2dGT0krWVI0WnlFb292bFJs?=
 =?utf-8?B?dDNjS2JVdzViejA4R0k0YitkYTVscnloSC91MzhnQTZZNWZEdXNFaXpOL2pn?=
 =?utf-8?B?d0RLaEdXdDVMS3RHRktrODU5c25idlhQMFlkbU1leVYrZVVHM1BnaEFIOEtZ?=
 =?utf-8?B?VFVNVVhWbTdHVjIyNSswMWdjWGVPK0JoZkJhMXd1WDlxOEJKRC9uSHV2WVNM?=
 =?utf-8?B?d3FtcVB0M0EzR0ptcDJwOWcvcnFGeUZBUHMrMmw2TERTYjU3ZEk5UDVpM21i?=
 =?utf-8?B?NTBOQXdTdFFKQm5aU3RJSHNrRHI3L1JUbHBZbUxDY0MyT0Uyanl6cU5kUzJu?=
 =?utf-8?B?M2RWY3Z5SVFGbWJuZWJLaEZYWURZUGlVMXFsTFBJNGRhNkExZENjdEgwNENZ?=
 =?utf-8?B?R2piUDN4QU81NFJNOXpMWDFVc1pYMFBRQ3E0clNLckF1UmIvbEQvYkozbEVk?=
 =?utf-8?B?clBCcWxCbWxNMmZYeFc0UGw3T2tQL0lSMWltbmYzWC9kMForWmR2ZGxiT2F4?=
 =?utf-8?B?OWp5SkRLY0JiUm05RTBRVEhWYnZtczNOZnYvU0ZTTzEvci9VNkxNUFY1by9C?=
 =?utf-8?Q?Nbg/HoBunYDuCaml/U1cE03J3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1e8903-0c24-4bdf-a22d-08de1ac0dda7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:07:58.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h64pDcOOI3GVKqFYmBaPCNRCZXGppcr0l737XDMNR2enMo3c2kBFC81BHSinRoSqO3FabWMJpn1iaSc94xxzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9872

The i.MX95 USB3.0 PHY supports XTAL 24MHz clock by default as reference
clock and 100MHz clock as alternate reference clock. If the default
reference clock brings USB performance degradation in bad condition, such
as the working temperature is too low or too high, switch to alternate
clock may overcome the degradation. This will add alternate clock support
to enhance the function of USB3.0 PHY.

---
Changes in v3:
- collect some Rb and Ab tag
- Link to v2: https://lore.kernel.org/r/20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com

Changes in v2:
- improve patch #1 commit message
- collect Rb tag
- Link to v1: https://lore.kernel.org/r/20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com

---
Xu Yang (4):
      dt-bindings: phy: imx8mq-usb: add alternate reference clock
      dt-bindings: clock: nxp,imx95-blk-ctl: add support for USB in HSIO Block Control
      phy: fsl-imx8mq-usb: support alternate reference clock
      clk: imx95-blk-ctl: Add one clock mux for HSIO block

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  1 +
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |  7 ++++++-
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 19 ++++++++++++++++++
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         | 23 ++++++++++++++++++++--
 4 files changed, 47 insertions(+), 3 deletions(-)
---
base-commit: 18514fd70ea4ca9de137bb3bceeac1bac4bcad75
change-id: 20250919-usb-phy-alt-clk-support-e54e69ac0780

Best regards,
-- 
Xu Yang <xu.yang_2@nxp.com>


