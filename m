Return-Path: <linux-kernel+bounces-848143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61273BCCABC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FAF3BE9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D52EDD63;
	Fri, 10 Oct 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k/5HXGjh"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624272EF665;
	Fri, 10 Oct 2025 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094070; cv=fail; b=Rwe4IhKO0XY8xbSFgWIvCecs3+4yrxkInPa0G+hTZ8nNbPgjSrALTqyl0XNSkWID6qh6UliIWPXVfs0pp3dJ1YSkHsEox/1xKmk+uLtWv8U7cHqP16Vj7iS0GVB+WfJMa0fN0bGs+h2vpn5hFULFvCIkomuJb2T9oLV9ejTo7gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094070; c=relaxed/simple;
	bh=DJTvgoshGuMomu/7k2xNBQFUIDko3PuQPfk22nzJ6KQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q/6oxUT8g/HaoIdU0Twt5xwD/Bz/vCGeFiQ49CzkmfT+SdMOddGaE+zCoHjErZFkv4jN+cvYa4YV6HCCXoe9CD6sEn/B1qZAFQQpHgDtnbz2oQrh+jI1huDRT2NkLoydOZhTiWW3Vya75G0mgOsYWWEQCUnnXzLmPEAmONITGuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k/5HXGjh; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOuUDA97gdAUjVcwUNQyVta0YNw0RY9AfrV+TcJET6145Mu75HbYF0IUILJ78pjS2eyYID2tBoiug3hboBFmR6RSc20KWgQWeuQPN2ADYt5y3WqargqeEsSKCsT2D6jV438D1xylew6MZ34e3AVO8AzGdL5T8yh3+k56sQ/6r/+XscSsL3icR5n8RjjN5mz7FNPLD+gqMMspFEZ7wO/jIfKst51cVyEcOvTSVyqmiHHmPXMConnOc7SAJZ9N0MdwvNR82+27eTMRBDx0Q9sNikAcAhqz8NG5beZ7KTbZo7MeSShimN2Q1dpC6XxMLWmUEh1oz9SLnWylfUVhFGj+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsJaCdNT+EdUmKQmalX9OVP3XRIe2XxrY2DQwRvMPmk=;
 b=i6R8oT8TJ4ckqk357Vfv5898Thkqkq8Vt0jizXyMISmxkWGjsnAjgUTZcgDBqTEMCVXbDbrJUvX/E4G0Ih79DqZWvEzuqoGWwuPBw6L6rt0ztbh0CyLaQBK9Rrt/IIOhv5ho3juocCOb8+2wUQU0GvB0d7O7YH2invCBE52kzLIAVvMScV4XqP91NHNP7xlUeNSsXNAEMrg4ItuKtc1N49l8c/Q3txVVSaaUzPfOrEz7XRmGv8YLEjtY7D9SLA69lHc1DdP61tHfVS1aXBmsw/R0U1yu7MrCZu6pcVXPamj8+W6QCoJ00+g93/0BtY4VtJ4y9+dDEALBNBGFSp90Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsJaCdNT+EdUmKQmalX9OVP3XRIe2XxrY2DQwRvMPmk=;
 b=k/5HXGjhd/doalsu+1vJDa8xOGGRxRmJ3mJHQqywPmLgtYT7R9m8HqohGOn/eR14M+RXmkyh7Td5dUbcnTsmM2N0/xucAdVoiQVKN2wZ4KKoQILCGiOtjFVD6ubGnERnOPolHUmAelizrjq67bFAfhQZW/zjEo02yYOilCVWN2K6exZL+nfLUAbgRNILv7cBMRs80zkh9wYza95Ruk28gvQbg/2KbXtXnGniZ0EtL1Rymspx0Ys87IZlQUzVHJ6Ob1QUOelXYJRiQBYOxD+QV41fqxLpe2z8MG+R+VnRoYFb0IQq4ipY/AX3IWu/BHpz7ZqcddfQ8YIBsNBB3nu6WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:01:04 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:01:04 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 10 Oct 2025 19:01:11 +0800
Subject: [PATCH v2 2/4] dt-bindings: clock: nxp,imx95-blk-ctl: add support
 for USB in HSIO Block Control
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-usb-phy-alt-clk-support-v2-2-af4b78bb4ae8@nxp.com>
References: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
In-Reply-To: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
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
 Xu Yang <xu.yang_2@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760094078; l=1076;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=DJTvgoshGuMomu/7k2xNBQFUIDko3PuQPfk22nzJ6KQ=;
 b=e8EbBH6V1ZhmX+Pbk7zck3xpPqU+q5NHP20zWwVRYKWlMDz7ln47RAT4SB/qMpuCUPYYphRxC
 LYFuZ9zp9hSBjIBYxyKij4NWjiDGSrnrGAsHr+y6KeCU/AXsTJOAwRB
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 6baed65e-6723-4cba-d12b-08de07ec4e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVphWEVFVEVzOENRRnR0R1g1UW4zM0dveUg4WWl0dmttNTBFUG5IT0w4L2tT?=
 =?utf-8?B?eDNjUVZVNFJrbXFOdHVFMGtDc1g5RXVmQ1MrWlo3MmlnMElZMk5oVWg4c2tV?=
 =?utf-8?B?elh1MWJBOWRKbm1USTM0a0QvYjV6cjA1clU1aVNkZHJTM1YwbldWQ3UrdzNF?=
 =?utf-8?B?THlYYUplZXF2WDFNV29keG1MZE81UUNBMHZkb0NMeTdDeERaTVc4eWZkaHNv?=
 =?utf-8?B?cjN5RnlTYjZQVmxZREk1OTlIQ0d6RHN3bzVXK3VJcXR1R1ZRWmZUZkZLSGEy?=
 =?utf-8?B?KzlxVEIrMzB0TEJ5c3NIbTF4YzJXd29tSWlheUVDWmdNaU1oS1l3bHIwSWdx?=
 =?utf-8?B?RlA2QmJkcmxya3dMWGl6NG9pSzlvYmJ2WDV6MUZMbkNoaHU1Y2dTelJIZzdD?=
 =?utf-8?B?bVJjTkV3NVAxMnc1NElEVUI5UlJFVGFpckVKbDNJZlZtdEFsbjNOamRvSjZN?=
 =?utf-8?B?WGpTUndHejgxZ1FwVEdFdEZ3SVRqZzR1Z04wNGZsQ1R4bnJUR1Vsb25Sa3dn?=
 =?utf-8?B?QnJ5ZGZTY04ycGZXaUJEVWJjNFhxekhVOHZQRkx2UUtiNWkzM1FBTmFKb1Zh?=
 =?utf-8?B?emdrR0RTVUd2NVNFaGk1ZXVNTjlaM3REMmdVeGluOEJMenlPRWZmcFd1VEc4?=
 =?utf-8?B?MFVUSTFHWlM3anpsa2tFcHVDUEpVWmFhTy9LemQvRHdHVFRwT0VRMVlVN3hS?=
 =?utf-8?B?TXpGbks0RXdVcVRDSW1ONjBwQUlzQ2txTHRsU2lDYkxJRTdPUXJUd2lrZ1cy?=
 =?utf-8?B?MmF1a3NXdUg5clFLRi9wQWZkcHFFRnVNZElmdmxHV1ZuTTNBbmQ5VnVJNG1i?=
 =?utf-8?B?LzJJalhac3RFUWhZQlg4STRaSjRyT09xajBkQ203ekx4VmpkTElYNno5YWN4?=
 =?utf-8?B?MXVEUWs0a1Erb2JDU2psZEg3M2h2UjFWV0Izblh6SU51WEFWdGFMdVcyNDdS?=
 =?utf-8?B?aHlETXhJWEY4cWNYUUhMR0dFbmVXaGpBbU5oYk9PK09MRVNxZk91Rm5FSklh?=
 =?utf-8?B?Y0VlRnZnRDBlVXNqN1ZiMGovTnZqNEsrMlJkeUJRSkZTelJVSWNKSW8yTDM4?=
 =?utf-8?B?bS9NU05TTzk5ZEE4eUtYZVN5SEFkeWM3dklhTVd5clg2N3RscXU0ditxSEpD?=
 =?utf-8?B?RDRsVEN1NlJHUTJweDVGYTROcFkzVXFqVmd1V3VldERMcTRCaFEwOVM0dWJI?=
 =?utf-8?B?MllDRHVBMk54SkE2ZUhMNHFqRUtWemlLclFERzlreHR3V2lGR1IyclhMdldT?=
 =?utf-8?B?R1M1eXV6YXdtdk5YY3hvRVduTklNRElaWEdINTRLbU9Vc2EwTWhoY2V6U0hE?=
 =?utf-8?B?Z3lUQVVLNDRyT2ZwRm1ZYnRIQllScndscks3b1NhVnRIVWk1TGVKYWI5dSsz?=
 =?utf-8?B?aFdERExRdzRMMlo4K3VWQnZ2cXJHemFzZ2hvNStSRCtkOVN1MnE4c2Y2R3Yr?=
 =?utf-8?B?YkxHM0oxUjd0enRoVTFEdE1CNDN6QnloeDl4bmZCMlp5elpBUUJQVzFnWU9F?=
 =?utf-8?B?cXg4dWZJZ3ZmdTVsUElueWhrWUhWcE5RbzlTYlVaSHpGMUhHeVo0Y1ZOazhh?=
 =?utf-8?B?UXdnOHMxaTlZVW1NWkZNOWsvRnFmempSVm5oUHdVQ3BBc0FBK05lSmtsaWpZ?=
 =?utf-8?B?QnRwQktPUUNPY1RUKzhldFVLcXR5OFZKT3h0SVE3ekFrYTdLQ2l6Mitacm1a?=
 =?utf-8?B?WkpiQkRjMitrelZLd1orV2dVMzFXc2c3RFlzVkJWcy9yRlN0MGRtWFBSSnpZ?=
 =?utf-8?B?Q1JQNFl3dGVvcG9zbXJZeWRvak42SGZkY3c2Vzdwb0FSbHRBdk9CWTk5cnVB?=
 =?utf-8?B?dWRzQU9TRXVFcy9FdXA3enNmZWdJUnl4SnlKL2hNOHhiVE5xL1Z2MFpBc1ZT?=
 =?utf-8?B?cm9NS1hTVDNPUzlRR3ZVdGpIMnAyTnUvc3hRODFFZDkraGw3VWZEazFpS2pD?=
 =?utf-8?B?LzRES3R3SGpoWTNUNHFBcitGN0ttNmdEWHdCTlZielZtZlpSQVdDWTNybmdu?=
 =?utf-8?B?QkhvRWVXYTFFVnVPbmZuWjRGcFkrb2Zjb1VRdEI5ZDRUbUhSUnFCRkRkbSsv?=
 =?utf-8?B?dHBERjFDSVJPdEZJNTlTWG5kcEQ2MlNVaGloUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzQ0TE5VOWxVMStuQitMYmhMWjZxdVZ0T2FoTHA5MnFlQnlCQ2E5bnBUK3VE?=
 =?utf-8?B?TGdic3UvbGRRZlo0bFFjd2tSTVZxSSsvL3Bhb1FlUU90T0M4QTZRaktycEhC?=
 =?utf-8?B?aFMzRk5pYzcwN01VTk1MYjRGL0FRbW41eWZaSTJoME9lMlhXbjIvWlRvdUI1?=
 =?utf-8?B?VWw1ajE5UXhVd25heGQ4Nk9kbGZ0YkpLbndQcHRqOUR2QWVCZnZrR2h2M0lo?=
 =?utf-8?B?QXo3UEdSZWxUMkp5MHlCaUxaZFhSNG45YlRES0lHZHlMVS9XcU0zR0s2U1hY?=
 =?utf-8?B?cXN1MG1YN1EzVzM3RUNhbEk0M2h1WlFVbmhkanBtdUZRaEFjUnZpSTFxQ1NC?=
 =?utf-8?B?T2J2UlZ4VzRudGNvdXB1MlFuRG5jZ0dpSEc4U3hqTGthYVdhc2lZdGZKaHc1?=
 =?utf-8?B?SnFqVnVPMHZwTnF5TU52VjZZeUQ4WHVXUENQRHUrbmpyUjM1K1JkVFo4ZkpJ?=
 =?utf-8?B?dzRrbldXTndabUZldWZZYXp0U3BOenE5dzZoWHNFM282R2o1VWhBdGdWS0JS?=
 =?utf-8?B?blE0ZDdTMjR5alc3RFdqV0UvSWZxVmFjd2JQSVZFV24wRkoxZXN6N3A4ZnZS?=
 =?utf-8?B?cVpjcjhRMkw2cUoxRnJXNFhMSjdPUU1iVy9ieXptYTRuNll0QTRiYmRzMGc3?=
 =?utf-8?B?U1NTT1lVYk9UV3dES3N6THR3VDdvUUtmZFBOT2g2bkRIMkE1MnZkMS80dXhM?=
 =?utf-8?B?VUo0WC9kc3pneUxHR1lhZjV6QXExdFV3M1g4R1ovQUxTSFBOWDg4TzhscTNX?=
 =?utf-8?B?elI1NjAvQ0xrYWVtTFVmaUtEakJvQm5peG1mV2M0QkFuZEpLUTNITENvRWVO?=
 =?utf-8?B?cFlEajg5SCs5VzBuWG90aXJteDhEOXJaN0JmeDZrS2U4OWw1c2o2MEJuZCtk?=
 =?utf-8?B?NTlQSTdoZVdhNTNhWEViQkE3SEhoS01WTTRuQVZUSE1IVEh4TEhXZVZobFhq?=
 =?utf-8?B?cWVubkdKNDB0L29VNVRCd005Y2FqUDVtWlgzcEhyMUtqRlM0RWRLdTNRR2xQ?=
 =?utf-8?B?ajVod0xlcklrR1RBVG84WHBpcXBNb25XalFoQkJrSlh0RkZIcm9IeVkwMVha?=
 =?utf-8?B?dlZVcE82SU9TeDQ5K3lTb1crRnBLSi9hMzZ4ejJ3NGZCWHdKM0xKVkg4djB1?=
 =?utf-8?B?MFBaVm9EZDZLbU5VMkJZbGp4UDdMUkdTQnYyMDFxdlJjVEczWUtSdm1oZ2JF?=
 =?utf-8?B?VE1WZEtiWFJOUVhBZEg0WkJIMDNkZGR4dEt5Uncyd2lRR3cxQ3BPcTJ3VDlq?=
 =?utf-8?B?akhVU3NBcGc4akkyQ2YzcHViSldxR29qRDFuSHZjVlUvSlVmaWcyOFptYXgv?=
 =?utf-8?B?YUZTc0pJNkVnWm1LWUdkK0lCYzJXZE5oemJsa2J5QlRHUTJtL25uQ0cycVRo?=
 =?utf-8?B?UzRHQ3NMaTlYbnJsTk9pUk9ROWlPdENiUnRjcnV5Mmd3ZFBBRDNHbnpSdkxw?=
 =?utf-8?B?V3Y4Yzd4SEpVTkJDNmdNTzFROEJvV2hTdUx1TXBCd0JEeXlvR1M5eGJLaDVW?=
 =?utf-8?B?b3g5dkpSVmtNQThUb1RyQi9NenhJV0NibGR3ak9Ub2lrYStvNGpCaXE5QVRS?=
 =?utf-8?B?WlBFRW0yWFBGQ1NqcVlPUzQxMjUvc2tHVVh3ZE9WdWNmUkFoSFJDSjNveS9V?=
 =?utf-8?B?Q1I4L011dXkvbjdDbWduVkg4NGNFaUhCL2JxYU5qRUR2UHNlTFYyWldpNDJo?=
 =?utf-8?B?QVFZS3Y1b0dBTjlMa0ZySS9lREN5UXlKYVAxdkRWWTZodDl1TnN4ZFZwaWFp?=
 =?utf-8?B?TFhKSmNtc3hUQWVkTVZUbS9VUm9kRTZHUTBUdEV4NUFCY0tFbzBBVGNxVVht?=
 =?utf-8?B?b2RQUmhxZm9yR1VieWI4ajFORlR1TUs5R0dxaW50cGhjQktTZUlQeWoxSUFa?=
 =?utf-8?B?dDQzbmxLdGtVUzFta1lMUmlla0dYRisrdGRoOFRYN1JrNmNDL0NkMnpsSzVR?=
 =?utf-8?B?bU4yb0ZhNGJhTUptenByenRuSndWbENReHZXUFkyeDk3NWlwNDJmRUFETWo4?=
 =?utf-8?B?TmpYd3JlcVd6eFcyR0pSRUxoRmJHSEV4eUZJdmZBWElXSUlLVzZsSmhNcW9I?=
 =?utf-8?B?K1Y3QnAxck1kR09RdkJydVM5TEpORVIwSDZhNkJwK3VDZEJHZlg5UjVrU0NZ?=
 =?utf-8?Q?87bXyvW1WX69CXuV1bH8ZxsnA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baed65e-6723-4cba-d12b-08de07ec4e35
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:01:04.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mzd1/YSx/hcTz4/xclRS6EweNS7VqmXTEPU4eXOrZeXZ3n0q5tLdfqUAGn027dxOeoWIKTPYyG68LO5qoy5bFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270

Add compatible string "nxp,imx95-hsio-usb-blk-ctl" to support USB
setting in HSIO Block Control.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add Rb and Ab tag
---
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 27403b4c52d6219d31649d75539af93edae0f17d..aa452fb438a9cd5b9a8ad3eff6249abffe576a01 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -18,6 +18,7 @@ properties:
           - nxp,imx95-camera-csr
           - nxp,imx95-display-csr
           - nxp,imx95-hsio-blk-ctl
+          - nxp,imx95-hsio-usb-blk-ctl
           - nxp,imx95-lvds-csr
           - nxp,imx95-netcmix-blk-ctrl
           - nxp,imx95-vpu-csr

-- 
2.34.1


