Return-Path: <linux-kernel+bounces-848141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDCBCCAAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F9E3C272F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367492EDD63;
	Fri, 10 Oct 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HSCms/pk"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988146BF;
	Fri, 10 Oct 2025 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094057; cv=fail; b=gsSoAD+o71hjx0bv3eGoDu7p0d5SrCY0rTbyh+UyM9Ny1OxvB6AbuThgLU1ei+AR6lXUYw7jqeu2DBjNbIAVrkMfvjUnbkrK12vlCCVMuqp7/za2MaZiYq5KFtU5dUP2Dy4z5iFJOvATpveil1tciu4TukZit1E3IA3uy/63Re4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094057; c=relaxed/simple;
	bh=fSQsfz37NYGH5jqljGQcBgjlvSwc9kfApH+2qm18NfI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Ok93i2c+H2q+t9rxKqTmnWfWzrQjGj3pbr8E5v8xI3t/od8/rkklPzfwHJimiYw2cxrmRzPYSkDfx3vuEnwltBPObLedo6t4KEh7bv6FhvXr+TuG81A9sAQ6KgR5gGSvzIJ2Ntlreor+bSiu9QTZt9OLqiPsNa82lbvqBhdg0l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HSCms/pk; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDqHknN4UzRTKX6uJAzfilGXeAhuCaHgugm9XTAHlmaAS90crw2GkRiRnvaV381uyYnTH8mCVg4V+JeQD1/xJP9DzyEx/HyAWvg3TOfo3YFkAYPWDoeHMSgCj+K4ik3BBLKuiSSd7WT7MILwiK+aCOCEMNhzHNnQ4OM8M8yUuytVdMmtG3H9Df+V9UP3rJksPS8GXfgoQ8+29Pwk5fDyKcuFyxMz77h8sOLz3AN9RS6CVCgkeuzDFPIC5WLDfSy1ZbvIK3PhRs/xcsbPN/68bOCTMNMQvh4RtnNtaUWXlL3ufsKqUSdhkKLaxPld6Nu/LHjrzC3XHvsqtJJQ4UfSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSkGJKg4K+gmVnd1+HRmY8KRegGGlz0EvEy7n1NJQIE=;
 b=mrH2sPdNpz1JB8HJxOS/nA5H43GTzQ2HVfLfRlrlRtmRQ6QpIy7dVUm2J9PXwS8OQ8HjYnCA44I8DeLdYVpLq9570cFAbvOHfUVQUVUN56wVQjQqGAQGEMkCxD/GVSGzWMer3KUEiHMBRNjPArx+LtKYoL9iSKWOV5Mc8IAWLpe9rXBppm0MS/SlFUtYoRgCy9s9B/HggMhf86c04y656qlRB4bzYGmKVK72pmdaT2fkW+BitgRPxPPN/9pfYZTGBkVMECQJD404hMRAg0TfGkY8LrDWufrTF+cIHUzgIjSpaK63YPyY5Z8ueYqRj1uXRHWxYX4sr0Y8URuHFC6WGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSkGJKg4K+gmVnd1+HRmY8KRegGGlz0EvEy7n1NJQIE=;
 b=HSCms/pkXqJAU2R7W384SKQNEMAwWD5HHmQZgOEtZcTp5jtcv4hsW0NvmdafRiBrtSKjlOcM6gi6TgImjLSSN3Fa554j/sH/y/c1iWrIpPOYhYHFUY2yZLsLctoC0dIYCG9i4lFG5Sfby1TZblTgrifikOZuG5BsiEvQ3NJGeDF7cqCmSjVL4FeAFhOt6H/KtDNgNykOS1wkW8yK7iBo64TAlBVsMl7oreiu98LDdqWuhycRp/+O3DapGGIJ1Qaks+b9WtVnyass7X2Mc7F1/cWL4Ol5QGzYbtR6g+oNhI2hF3V811yS90KQJxHZt+ACud1tb0jDWNl/nmghaxjdOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 11:00:51 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:00:50 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH v2 0/4] Add i.MX95 USB3.0 PHY alternate clock support
Date: Fri, 10 Oct 2025 19:01:09 +0800
Message-Id: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXn6GgC/4WNQQ7CIBBFr9LM2jGAYq0r72G6QByFWIEAbdo03
 F3sBVy+l/z3V0gULSW4NCtEmmyy3lUQuwa0Ue5FaB+VQTAhWcc7HNMdg1lQDRn18MY0huBjRpJ
 HOnVKs/bMoK5DpKedt/Ktr2xsyj4u29HEf/Z/c+LIULZaKH4gUlxf3Rz22n+gL6V8AattPtS8A
 AAA
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
 Xu Yang <xu.yang_2@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760094078; l=1429;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=fSQsfz37NYGH5jqljGQcBgjlvSwc9kfApH+2qm18NfI=;
 b=GybszyezN04euptksasaXXhofEoj4mQjGH6j1vSvm1mu3afUFtjNm4pTFPbB7hiM5BDP3y58v
 aAtTKmmQj2JB+isQG2NdW0O/7H3fHNLNXccrhreigiKwWNI8q2mHBQw
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1cc9c8-16de-4b8e-3d1a-08de07ec459f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2hqcFB0Mm5HcTYzTHl3OXRqQ0pSL2dNQTlmdGd6dldxdVAzcEw5RUlRRS94?=
 =?utf-8?B?SEhGcGZsMWliNWFmVCtOK0JzY1NHVXgyTzZPOTZrNUF4SzNLS1JJTGlDVFdF?=
 =?utf-8?B?enNVUEhaNHFwbG1vN0hqVVBkODh2WFhHV3Q3WWx4bjI0a3h1TjFlT2d2SFBw?=
 =?utf-8?B?Vzd6SmZvTmtrVjZWVTdYZE5Hb2RINVo4VlREWGJsZUlsZTJyNVl0MUhZRWUw?=
 =?utf-8?B?a0NXNDBBWklHeDdoeDVzNVZqMTcxU0p6S0YyS1FmZmxCWFFhVWhRSnpIYnZk?=
 =?utf-8?B?VVJDb0huKzE3ZXNvS3dsdWhzVUlhSkdGSVVsam5yK292dnQxMUYrSUVmRnNE?=
 =?utf-8?B?S0VQcWpLZGhTRk9XR1R5cHpscnJwTGxPZmw5NVJ3bXJwTjA0TlFUd3FidENQ?=
 =?utf-8?B?T3dKL0VMTUJvd3Z1MTI3cGlzTFhGRW1aM3dUNWJONHRXZmUxOEp6ZGRJNXVR?=
 =?utf-8?B?N0FYLzZOdnd0RTZqeC95YkRLK2ZuQTNyZkphekFkazN4UzkyRExqWWRBVC84?=
 =?utf-8?B?Uy9oWE14OG1uR0N2c0RzamRLKytyQW5CU01Qb2oyOTc0cFI5bUkrdW9PTXRO?=
 =?utf-8?B?TEtGbm1qVnQ3alhlMVUwUjNuTmpZd3ZsaDlRUzdJVlZ5R1VleUJqczMwRlZI?=
 =?utf-8?B?cmNRelpnRWVzWENYQlFSWWlodnBXNktKYi92L0tWK0w0N05pVks5djU2NlJB?=
 =?utf-8?B?YzVUNkhGY05nY1VzTHZ0Z29TWmNucUM0bUlvRy9uQ0YrTGJsZ3R4eittdDY3?=
 =?utf-8?B?T0w1UGsvaXc5aUs1dGlRMHNxLytlelhOVFlsMGFaWW4wdkFEa2NmMndCeGl1?=
 =?utf-8?B?WkxYWjFWNDhNNk9EdU4yRmhudmdRcDBzWTNtdXlmQm9KcVoyNENNZUt1TlFl?=
 =?utf-8?B?TlBheEd5RVkxbVRGcXFHSVhLL3lWVmgwUEZ3TkVqbSszS3d6bDBuNUdUdisr?=
 =?utf-8?B?dm9HcHNPU1JWQzZwYXlMVFNRM2E5NHpDSTR1WC9vTEJKRTJlVDV4cGY0R2Ey?=
 =?utf-8?B?ZTZoOGhncTNacGtPZ0tBSlFXZGZpaVpheFUza2pmeVVpWmZpaWRaYVplVkty?=
 =?utf-8?B?VFdvLzMyM2JMcjFXVzBta0NvMG5DWnVwcWpaZjRBODZiazVXVlVNR0FBKzBx?=
 =?utf-8?B?c3R2ZURLaVdMZE9Zc0NvNTJMdTB1M3RUaFNnSmdMSzhlK3ZjL1liSXJOR3ZF?=
 =?utf-8?B?b2hrNWlEVWUxY1dRTHpQb2prRVBqWEpUTk80aENuVWxqbXc1cm41MEc1RjZn?=
 =?utf-8?B?ZDlmZHowVGNhS09CYU91azdmaHVJTHE5Y25PRFhBclFKbEJGV0lTZ3o3eitK?=
 =?utf-8?B?d1hhMDZGVFJvNVBKVWE5MXdhWm9RczBWNmpLZDhUVThGaVhBMUpEYTBzQ1hW?=
 =?utf-8?B?TXAzZy9oOGlOWXczOGErTDM0VENlUHEyTHBOTVVhWHBCTVVnRE9RbGRhRDR5?=
 =?utf-8?B?bVVGWGlGZ1Z3N0tjZGQ4YjJlSWwzL25FTDN5THVVTUlNMm55cGFUbW9mVzl1?=
 =?utf-8?B?OXRMd0hkTnZWRWMwTDdHcGRnaHQxOGZFYnArbjU2QlV0OVRLM1JYMXd2aWQ5?=
 =?utf-8?B?bTA1aStNbmR5NnI3YmxDeHhXSW1seVluOXFhMVAzem5UcHRpUTlrcnpEK1Ji?=
 =?utf-8?B?aFZSRlF6ZXhSbFZNMkUybEtDcENJVjJicW5TMzJreGFCcHFuUEkwbkxEQ3hM?=
 =?utf-8?B?TXNUU0JiclpDUU1kOWFSa29LM3Z0V1hRa2xrU1N1YnVVVm0ydWUreEFjZmFq?=
 =?utf-8?B?VU9pS3kzYUdQU1hZS2lESTg4Y29CZjd4NTQyMENRdi9abmxrYnYxQWh4UlJP?=
 =?utf-8?B?K1VteHcxMWhyNDgyb1N3UmNJNFUrNGF4WDVVSnRwTnpxOXFuWlY0bG1YcjUr?=
 =?utf-8?B?MGdWT2RhVFMxT1VMVmhsaWVOZ0tSQ2pJTjQ1MTZ5ZzlSa0Z4MDBZM204cTdl?=
 =?utf-8?B?WmVnR2tYS0djeHh0QTE3NnVPckxLWng1TDIvNFBHWUhUcE1tMkdQNi9IZlFJ?=
 =?utf-8?B?RlNDYWVSL29FS3NMWkIvbHNsWGZIbkpVV3pkUFJPc1ZQOG5FWkFnWmkwZHJw?=
 =?utf-8?B?ODlhUkFscUhTUXJ0OXVmU1ZRYjhNd3Jtb0Fpdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhDZUJZSUI1RmF6dnJXWnJJSXFwZTJ1TVNpUFdSbW8rS3FpN1kvNTk3cjI1?=
 =?utf-8?B?MksySkI1Ti9mck5WNjZuOXZMRGt3NDZsekt4TjVBNy9XcDVjQ2VnVERxeFFK?=
 =?utf-8?B?ZUpINlBJdDdzeEllTnA4RjRMcVNURmZsUWNlUjc1WmUvaWcyL1dHcGFzZVNz?=
 =?utf-8?B?SFN1RjFKRHEyWmFGbE5rMFRoNThqcUtMMVB5UXhRMm16Tkt0dERHdmQ4dzhq?=
 =?utf-8?B?Lzl6QTJveFZHNEdpM0xzQ2ZPSjNYS3BnZnk5UnlGNXJoK1NKUnpqTVJXSHU2?=
 =?utf-8?B?N3hod2RnamJVZk9KWjAyalJDNDFqeml0L25Vblk1cUVyY3lLOEFuWVcrNmIw?=
 =?utf-8?B?d2hlQTZBUDFwOG96cGJlUFVSeFA5YmVycFRUZXlhci8xWE9JZ2VCektjVldw?=
 =?utf-8?B?M3Z4Y05HZWVkSTdwTXpUKzlkS0xSeG1DOThhK1c0d0JvL3JQdGIzaFFvd204?=
 =?utf-8?B?MWRma29Od3RmVHhZODN3d3A1UUFkZW9MU3JERkpTZVFaRXRpRElKdHMyUHBW?=
 =?utf-8?B?d0tPbC9nRDh5azVkYllza0ZMY0l3SlRiOFRKRW5EZ2VmVGhSbUhCZ0xXdGdX?=
 =?utf-8?B?QUdDVDdiN0VObHc4SklyL0ZnUEVqSDJFWHNEaldwQ21QWitPT0QyOUt2bW0z?=
 =?utf-8?B?aWVEQVUyd1hDSktxM0JlZjU3RkVONUtlMkZuZExPcFdmNUluSmV1RlRnc25B?=
 =?utf-8?B?Y3pYaEM3WGF6b2kwdkhsaGN4ano2TjBObm5xU1BBQ0NJS3ppczdBVUpiK2py?=
 =?utf-8?B?a0Y4VC9HZm41cXR0RzFzUW5XYmplcXZJU0Z4YTBPQjhidzdjanRzR3RvREVp?=
 =?utf-8?B?VEVxTm1qc3QxSXRmbkVKU0xjSGFjcE05ZVg5REY0ZmNxN0htbit0K014cklE?=
 =?utf-8?B?eXVnTExCMXIwNU1hWVpOSU81R2ZJSUZvRlRRWkJXUWtpWFEwM3lKTENDclZF?=
 =?utf-8?B?RENsblo3bDZKM2h2QStLNnp3ejEzT1c3dEZxamVzRm0rZXV0WExXY2RxZVd3?=
 =?utf-8?B?bzRyZDJYQit6bzRKL2lqMnlhYkcrQm1qVnVxQWZyNE1QSXdoNi9WMklndjV1?=
 =?utf-8?B?V2hoVng5c2I4bHYwdWJva3VsMER4b04zRFJVVjVlTDU2SEVJMmRXZzFoS0E1?=
 =?utf-8?B?K05Ocnp0WFJkdlJFN2pJdndxZjNSbmJNOExqQ2dKWjY4dlJVYjRFMXhQVjhG?=
 =?utf-8?B?dnlZVDErREd5SHBJeVdXdFpsZFNMT1BiVThPdEpWNFAxaW5zS05Ic204SkRC?=
 =?utf-8?B?bFhSNGsxQXpScC94eXZzeW9mQ1RHNVBFak9LaWxjbFpTbzZ2NFoyN2lPT2xs?=
 =?utf-8?B?UDNacURjZVpSMDEyaU5LYU5OQnk3YXI5c21TWHdyUVZOU3dGV0V3TUIxelBB?=
 =?utf-8?B?azNrRGt2REJmblJzRnkyL1pGOWFobldhNmgxVHVyajJIZlRBdlkvdDYzZnhX?=
 =?utf-8?B?emY3SGlscjFJM3U1azVrWDNmRHR5OGdnb3RpWUIwOGZ0UjZwWXFWT3BqenRM?=
 =?utf-8?B?Q1Yya0ZDVUZBSzdlKzI2dXlPS2N4SVJyWjlMR0x1ZkRNVFFMVCtpMk96TVRz?=
 =?utf-8?B?K2VlWlpxMFdEZ1hmeHBheUEySWZodUlvd3JIVEpQMTQrKzJMTXZqT2RSOGhy?=
 =?utf-8?B?dU1TcnE5U2k0eFovN2hvT1YrdVZ4VHJNN01pMkliWjlic0FWZW15NGxkNXJF?=
 =?utf-8?B?R1pDQVF0ZERXSGRtSWlxMVlVa2ovL0pmZUpzMGY0UFBQc1A4NGpOSUVwSlV3?=
 =?utf-8?B?Mi9saDB0dmRRcVFrQzdNUEs3K0xLL2pDRjNvSmRVdkd6d2VGby9leDA2RSt0?=
 =?utf-8?B?UmdkSUwrNjd5bkZLdkFKK1N5clFqMjZvMUZYVXQwRHlYY1ZkSUxNVGoyTnhY?=
 =?utf-8?B?U0s0eW1GOWFXYTQ5cDNwYVg4VVNvbnYvaG9nYWlaU0VjVmk0R2R6ZDJPMUtp?=
 =?utf-8?B?emJqdW1FejBneEhFalpnQ2dqbjdKRXdWektxQUpQRkprRmNYOGsyS2F3elhT?=
 =?utf-8?B?bWtJbzUyQlJZTU9XSnVYYjlFNVcyeVpGZU1mZEJvQlZjRWJwd0FZeDgxckRi?=
 =?utf-8?B?ZkE5ZzA5aUdrS2xVaU1ydit4NHg1L1hTVnRZTExTbFhBU1BqL3FoQ2pBYWNr?=
 =?utf-8?Q?aMizJ+H2vuYxNLVuzJnFvsAF0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1cc9c8-16de-4b8e-3d1a-08de07ec459f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:00:50.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rTBfF05FeLVYAVllFp6tmnKV/RFjbwOoKVRos8dJrgoJeaDIeRlEXLsMf1g7IvbTjhWk4rmjUEZxKyIF7MrKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871

The i.MX95 USB3.0 PHY supports XTAL 24MHz clock by default as reference
clock and 100MHz clock as alternate reference clock. If the default
reference clock brings USB performance degradation in bad condition, such
as the working temperature is too low or too high, switch to alternate
clock may overcome the degradation. This will add alternate clock support
to enhance the function of USB3.0 PHY.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
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
base-commit: a2f12b1cbec103a836e3ddfde57084661591e4f3
change-id: 20250919-usb-phy-alt-clk-support-e54e69ac0780

Best regards,
-- 
Xu Yang <xu.yang_2@nxp.com>


