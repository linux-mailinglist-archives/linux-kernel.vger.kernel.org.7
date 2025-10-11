Return-Path: <linux-kernel+bounces-849141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC671BCF48F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84343425C03
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111326B2A5;
	Sat, 11 Oct 2025 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HkTDo5Xr"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB2F23717F;
	Sat, 11 Oct 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760182460; cv=fail; b=TtA4JM4W3aUMhYVHBFAoSefmykrTTXfYJrkqaXcbTepjaTw3x0qAFZMeZvPeHtgWA491k9v+z9YG6wdedPANML2xymEXrFGY/NBd2t2jvInmaVT7XwKjNbEIosvPiLyaPu/5IXV9PWpT3Qq3wzt9NxvQt/JkRDOg36HNE2JuYZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760182460; c=relaxed/simple;
	bh=Tz2yhgq2IH4U3gEhZRqpgwNP9ng3E05fL2Ij5EVl5bA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QscRqyRWJ/3sSn69hYrz0vaGQBCqERMnR3Z/MS45Ac1h+Crjmuh8VNjzOuE8G+WzlVxt7phiE3L9XWnzx9ztdTQvaDvYjkJRWDraFbZg2UV5JxXvv3tu9EMjdw0gs8Tcz5ghyulYD5sVcl7lXjvcYsnq10An4qCPJqnSdZqXR4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HkTDo5Xr; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONS0uT/C/cxvsgp9oUBv8BY0Ew1AYPa2eBVPbCe640+VubU03VAdziEupZW5Wz7NBDft0qjGSfSXAnrtwGb5aQE+DQlzm7dsapIy8+URUaMVIGkNuC2Y1xwQbfwpk/1rkfni8EaLpEkVlkzFq3rcv6C1oKMBokw5PxuQaVLomdHHCchzFPhRfaRRq8PRmnoxNRkq0Ar2EVQ71ZJ2GPrZkpm3F6UKKSD65QhNZb8ZV5sDjnm1nTBN30zk9FYmHFCVQek9eGhk5FTdBqnpQJFCguVMArJVo6PagBvDf0+J5RrM0Fxx6Fb+iGbfBIVaRH9noY3LTkIeZIl9abQSaGv/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu/wKtlFCetiqa3GCS9Jt0RqHlzj8EgqU5uK7BhPKnE=;
 b=T8nmkntqGVPvnCKDoq5+2+qWWe16dpTweKrYIeVuZ/saa1S6GCa/ajUNYOeCMb7eWH5XUtayQm0pgdfnCRTZgVcNthWZCjx0I0JL/mLDW4+HT3hdGhjjZ+8irZR/SNOKVul2avPgfAX/auswI2KntnTkSrE3Fs2ddMKcqSGJPzYD6ltlWH3jQziGHVRWHpH+w8izIQijwJmaba7Fe6HRG3wtBFKm3umTKIKIyz1j8MFgeAduVLoAZVzkPLN2VPzryciOUBWmnpzuT8HJlS9vO9kzAghgVmNZ4no/sdXFTf3VQJGi49esSTpG+UCN0IxxMxumrZ4ISkbccNbAG0kXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu/wKtlFCetiqa3GCS9Jt0RqHlzj8EgqU5uK7BhPKnE=;
 b=HkTDo5XrPx/VafulmOUNWCoklXqtNyWq02A/pMUqBq2RcNusMEeTWTOjYehyW9zOD8tvdA8VA3BW9U+L4Y8iD1wm/GWzU/DidkXFDa4XHOxuoUREJ19eRAsgpzB9wWJeFF8R7NxDz2vub0TEjsrDQFf8G2O0PEZ54LxWfRyjsYkJ21fFi2kX2APkYPmEqJmL8svRNu9B1UdjaBzuD/nvvMaxFTBjWLmAGJ4OGcAVU95+79NFftze3l/wlT+gYG7C7BtdY9rv9VRapHHG3e/MdHKhd5rTXCzdYgIxGv7krWBH1/borcctlxsmsvgBhgTKg2lbxrlTsnMGoohzeXPjPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9181.eurprd04.prod.outlook.com (2603:10a6:150:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 11:34:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 11:34:07 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Sat, 11 Oct 2025 19:33:42 +0800
Subject: [PATCH v2 1/2] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-sm-syslog-v2-1-v2-1-f43a3f6b32e4@nxp.com>
References: <20251011-sm-syslog-v2-1-v2-0-f43a3f6b32e4@nxp.com>
In-Reply-To: <20251011-sm-syslog-v2-1-v2-0-f43a3f6b32e4@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Frank Li <frank.li@nxp.com>, 
 arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760182435; l=4493;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Tz2yhgq2IH4U3gEhZRqpgwNP9ng3E05fL2Ij5EVl5bA=;
 b=7WhfumT1q9x6KGhHHfc/o+MewtxLbbrWxInlRHWH+zZ5PlZ8Litg3DqVio5W8ZgydYGA3Fkd9
 6ItmldlVayxAeLx4wvpzF3ft8mllvcJDY2WyECde47tpmTp8BQeUPZ3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f141d88-9453-4b35-8761-08de08ba16a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmE2L1VoOVJNVU5wNTVQcFZGRXhFWDY2ZjhzYXgxaGFpQ0xFcEJJc2RzUFZn?=
 =?utf-8?B?M25rQUQvT05LcjFSdFVtdEZSTFZaTVlPMzNvNWhXQlJQT3dJS0tFZDJucmdy?=
 =?utf-8?B?S0tTSFdoZEtrN2x0VjY3M0NHNmp1aUxtUkFpeEFGZzZTOHY0Z21WUzhqUGZZ?=
 =?utf-8?B?eXpoY3pQMld3NHE1Wld0a0lpNzlSMXRQYnhVM1pJTG5rN21VTy85cUZvT012?=
 =?utf-8?B?bzRwcHFuazRuVzZGVkpkSkxzUjVWVjJxQ0lXUnRtWjBPNEY3bzgzTUpxQUFi?=
 =?utf-8?B?SHltaEt6clFqQUtWQXd4Q3NCcXJMNXJUa0VwYzMva3h1MHVEaFFCdXl6M2hp?=
 =?utf-8?B?dnM4R2djNUw4RGVxZnBja2xKNEg3RjJmZWpLMkZybXhaank3UWdSMHNFS25j?=
 =?utf-8?B?cUI5THBCdmU1aUx5WDBBK0UwMWJqMmtuZksyUElhaHZEbGhLVTVuQjR6MlVV?=
 =?utf-8?B?UEJyZm45WlQ2ZWNDaThoa0ppR0JFeEhHaE1NZCtDYmpPS250bUFKTUZNZUFp?=
 =?utf-8?B?KzBYbEhZWUN3OStmQmtGOTByQk5WdENvc3dULzFQTnE5SlBxMGpVN0M5Smtt?=
 =?utf-8?B?emhFV3RsaVhHZ1crYUlCc1dsQVpQWE02VSs2aWV1WmdMS21MUlpqMUwyK0Fw?=
 =?utf-8?B?bTRsNThJM1ZuWi84OHBhOFRVMGdYejRPVjllVXU5aHV5OFR0M1lDS3VRQ04w?=
 =?utf-8?B?enJob2J5T040WGRpanBwMDMzaEIvRS9UQjZVbVJCSE5CWUZWditxZW0yS3Zp?=
 =?utf-8?B?eTljekNRUXdhT1lScTFoTmdGQ29IOTNFekFRSXh3cHlUOXJSRnJvQVlock9j?=
 =?utf-8?B?cG1kVWFEMUF4MGZoV2llR2NiNXVsZFBGUGNaZlJaOE5wMXlxQ3F1bzR3K2JP?=
 =?utf-8?B?YUZDc2k1TERwdDAydVd4N3BRdkpzeGJ3M0c5RG9yekFBaXB1bTgwVmZBdnQ2?=
 =?utf-8?B?L3piVml6WmNuVm1tcTUzTGNKN3lydUFENG1xbzdaK3NKZjQvNmU4LzczUjMz?=
 =?utf-8?B?em1yRHBrU3pBdHZvQkY5d1NIWk1LaklodTAvZnUvTHZ5dG54RXFWVDR1MXl5?=
 =?utf-8?B?ZThlV3VkWnl4bUJBMVBQOE5TdWFkRDBrV24wdGFrM01jYy9KcnRkS0FsV2xl?=
 =?utf-8?B?Qk16WlBsQUFGbyszZWJhSTIrM2VSdEt4WDNMRHRscTBSdGJkb3VLWDl5OERl?=
 =?utf-8?B?cnd6VWRwR3VUVG1PZmRGb0QyVUdSNjdpaGFZcm5tekhFWVdYa0RzcmF6Titj?=
 =?utf-8?B?Vnk5ODJwU0RuM2V0TEpjYkVob0ppaGRrbWcvK1BDNUpuekUwcXBsa1FKbUk4?=
 =?utf-8?B?NDNxMm12cE9jT212WXBDY1dScGlZSlJjZ2RlVkNJaWpCTkZqUmQ0SThLbVRE?=
 =?utf-8?B?ZVA2RUxqeWI2NEw4QkFSMGw0ZVJvNmlRNGgrZ0c3eVYrWXRJNmFVbWNYQ3lh?=
 =?utf-8?B?dlNiazR1dlBUZE9GZFp0bytRZkQ2cUV3YXJ1TlhBdmNNMEZHbnlXb1hEMnFi?=
 =?utf-8?B?aE1oQjVYUTl5bjg1MkxCRy9LK09wS1haVUxJRDJ6K3lpcDNubVlmVXVwTDJ4?=
 =?utf-8?B?NVRkMjFva2RTWEdzNU0wQk9lOGNONzRaTER5UHZGbGNYcDFDZS9VcWtEaFY5?=
 =?utf-8?B?OWM1UHplNFVxK1g2MlRqSk5HTTJQRk5wQzc5bEFCbVcxVEFLK2FUUnMrMExU?=
 =?utf-8?B?M0ZmVVhsQmFpRXVmTDRzdUN2YkJySnArajAwaFhNOTluTXh4Vml0UXFOV3hz?=
 =?utf-8?B?V2dMejZBY1R0dnZ2TU1ZSksyVlprbDNuYU9sbWR3eVFRa2RaZGVDSnIrbUww?=
 =?utf-8?B?MHR2bDZ2aEZ3ZHI3TGZVeURSZ28yb3FTR2NELzd5cmlSUEllcHdBMHZBZTJz?=
 =?utf-8?B?L0dia3dROGpzQXlBeWI0T24xakxPNGNaOUVHSWJjVFNHRUVsWnppTzljcUNz?=
 =?utf-8?B?eFhiS1IvMmhqTzU2SW1Lbm1pYUxBS2ZYa0I0NkF0eEp5d3JaaFdBWXh5U3VF?=
 =?utf-8?B?MXVRRWFjT1FXNUxXclo2MHlSYmM4WUZnR053N3pwRnpEZkFiSUwzQXc4L0Rw?=
 =?utf-8?Q?xOKxFo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWVWemViNnozTkpOcjY4RmZieWU1bDdXWTluenh3WE1INXdjN1FqZ05ySmty?=
 =?utf-8?B?dCtiQWJLUktBKzVTUjRYOG9lMDRKZ3dFUWMxOWdrd0dSWjd4UDlQU2ZTNFBv?=
 =?utf-8?B?L3I3NE56emZYNE1SM3Q5bDNBR2F1RXNVN3dxR3VNZE11dGpZRXcvNnJlOTE5?=
 =?utf-8?B?SUZUUGZTa2srcmZCY1d1eVBlVFNic0J3SkVmNzBzbVV2dG11QkxRQ2I4RFpO?=
 =?utf-8?B?SkRHRGRBZ0wyNzRMREM0akpkOVdPRDlneDh0cTBmaCtLd1hWSFZSZlZieHBw?=
 =?utf-8?B?QzljaVp4bmJPY01yaFlacUdGd2E0K3FjUTRjbEJmbVFzWjNEdHFjVk5CenhD?=
 =?utf-8?B?amM2enNQcHUxUWpvV3c2UXZsQy9md3VCTmxYK0x2YlhZVG1zRjVaYXpJcEFP?=
 =?utf-8?B?S1pBbWxjOUhFd0FJbGRwV1RoTkEwc0VMeHJVd3IvK05MdXh1eTRFOHEyTEVE?=
 =?utf-8?B?TjVHeWlkbjgvSGZiM3hPb002RHFDUTRBTyt5YzF6OUM0eU9wOENvbUx6RnAz?=
 =?utf-8?B?ZVpIUFBPbHBKVmtkNXVwNlBJOExPVXZVbjZ6d1BNamYvSmtPQWdyWHZueVRN?=
 =?utf-8?B?SVN1VWdtMDdoWitQOVcrdnhnV0hrODRGUlRYa2dyeDVOVkh2bFVXV0Z5cjV5?=
 =?utf-8?B?aDFHZ0IrSkJyZitFS3ZzWXdGSy83a0oyRHc1TWd1WWUyZ2tyTHFpMmlnNVkw?=
 =?utf-8?B?aVM5QWNIdkR5WTJLWFB1Q0Ric2NhSzRkVjhHd0Uxb3JyZW5HcEx1dUl0WGRB?=
 =?utf-8?B?SnEyTVdNbFE0Y1NwanJFSTFzRzUwdjI2cTJ4d0J3STNQT1BuRjRJZ1VCdGMx?=
 =?utf-8?B?SnZpMmtKSDdjRVg0QzVZWTlZSnQ0Tk1vWUkxQVJVNjJEV2JRMmRtRkJMQlFn?=
 =?utf-8?B?VDlzalRuQ2dzUGI3c3B3dzN4eU5GOHFUcUJlU2tXR3BMSDl6TnZzbFMyenUy?=
 =?utf-8?B?M0l3cTNaQ1NNVUVzUWlCQ3hDN0liVWN6YXpELzk4UUlWMzk5SGQ4K1laMXNO?=
 =?utf-8?B?RHNmeDltOHNqdEMvNzZQZUVJOFBFYkNNTXNBcjIzY1h5SkdIRUZPWGdYT1JH?=
 =?utf-8?B?N2pDTWxZcGhwdm9jWGNSaDdMK0pZN09Jb0FVTXd1UjZmSnNLRUtXeWVCVG0w?=
 =?utf-8?B?YlRidVY2T2sxa3JLVEx6eVVIZXZuNHBMeHpnSzRaZ21tRnBMQ1JrWTZ0d3Na?=
 =?utf-8?B?ZG1QK0V2d1BVbDhWTkNtc0ZHeTBrUlIySTRtTGVWZEhvd3BBSGdCb2FabUE3?=
 =?utf-8?B?QTlseHlYZldWMUFsVUlpR0w0T2xIRmpkK3R1SWN4cXRoSGNjcHBiQ25XbXVI?=
 =?utf-8?B?VS9IZll3QkFCQWY5T2ozWEdFbThUekVDYUZGVi9TUTZZcXUvYUFpRnd5a1Vv?=
 =?utf-8?B?U3h0Nmk2R1dseVhrT3pVNXJNcWJHMW9lVDExbVU4dW9mMFJPYjdKYURTQkVP?=
 =?utf-8?B?UXZDV1FDRzVzT0V2ZEJBbVZMOHlPVEdOZ1F3ZlMxT0ZOeDBsUTh4RGF2NVcy?=
 =?utf-8?B?dUtPaVdUamFjT0YzVDFHbXhmejFVbjljTVdodjBCNng1ckpVR2JadGZkNy91?=
 =?utf-8?B?RXg4aDNQeUxTeGdkNmlMQm13MWVnQXcyZkVnOUJOMW9PSm92b0M0TWt2SStV?=
 =?utf-8?B?VkdkbGZ6RE1lRWszejJDUDlBMy9scytIRkRTaHNDQ1lOTXdHY25MUXFYUHQ2?=
 =?utf-8?B?V080a0hrWkRrakxuSFNpWjVPdWpLRkZPcEVXaEJSRHZvVG5SUW5SYjV0aWU2?=
 =?utf-8?B?VFRiNlRVekVFUmptc25aaHE4ay9tbFgrN095YWlIbVp2UlJSY1MvTUV0Y3BF?=
 =?utf-8?B?UDFFVjNYb3o3dk1pVDVRQWs2a2FPYlM2aVJLZjRvemJQWFp1VUdBdHQ1Wko3?=
 =?utf-8?B?UXJOYk5Tbk9FVUVWQWRXc1JOYWI0YTNpMU11VldORlJJUTRSRXRaWU9BTktB?=
 =?utf-8?B?Tkx1S2Y0a0hUQWs2eVVTUm9tam1yT21HWHpTaWIwSmMwQXRNSTRaZVg3Q2dW?=
 =?utf-8?B?NWRvektrN2thcW1adkNTYWIyNld1OElRcm5hNDRlU09mZ0hMQ0FUcS9hMkd2?=
 =?utf-8?B?WTBZODFjNVVEeDhUUUJ6Ymc0Y1FoN0Fnc0N1T3ZwRDhTdnRLR2tIS0ZlRUxG?=
 =?utf-8?Q?IfKZfpK/4MLHrPljyJF+F+WVi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f141d88-9453-4b35-8761-08de08ba16a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 11:34:07.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaMu1fboYLH0V6H+D8qMHucQeGpEZHa/4ZvfFU2HF2QtF/Qxjv/IoDVpCHnDfY7b0Z+I6lwI1nL1vNq1zygVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9181

MISC protocol supports getting system log regarding system sleep latency,
wakeup interrupt and etc. Add the API for user to retrieve the information
from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 83 ++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  2 +
 2 files changed, 85 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 700a3f24f4efc153ca4a9ef1a9e50a7ece492a18..eae0b0562f6cf1931be612852ba2651f60820e6d 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -28,6 +28,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_DISCOVER_BUILD_INFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 	SCMI_IMX_MISC_CFG_INFO_GET = 0xC,
+	SCMI_IMX_MISC_SYSLOG_GET = 0xD,
 	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 };
 
@@ -89,6 +90,19 @@ struct scmi_imx_misc_cfg_info_out {
 	u8 cfgname[MISC_MAX_CFGNAME];
 };
 
+struct scmi_imx_misc_syslog_in {
+	__le32 flags;
+	__le32 index;
+};
+
+#define REMAINING(x)	le32_get_bits((x), GENMASK(31, 20))
+#define RETURNED(x)	le32_get_bits((x), GENMASK(11, 0))
+
+struct scmi_imx_misc_syslog_out {
+	__le32 numlogflags;
+	__le32 syslog[];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -371,10 +385,79 @@ static int scmi_imx_misc_cfg_info_get(const struct scmi_protocol_handle *ph)
 	return ret;
 }
 
+struct scmi_imx_misc_syslog_ipriv {
+	u32 *array;
+	u16 *size;
+};
+
+static void iter_misc_syslog_prepare_message(void *message, u32 desc_index,
+					     const void *priv)
+{
+	struct scmi_imx_misc_syslog_in *msg = message;
+
+	msg->flags = cpu_to_le32(0);
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_misc_syslog_update_state(struct scmi_iterator_state *st,
+					 const void *response, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	st->num_returned = RETURNED(r->numlogflags);
+	st->num_remaining = REMAINING(r->numlogflags);
+	*p->size = st->num_returned + st->num_remaining;
+
+	return 0;
+}
+
+static int
+iter_misc_syslog_process_response(const struct scmi_protocol_handle *ph,
+				  const void *response,
+				  struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->syslog[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_imx_misc_syslog_get(const struct scmi_protocol_handle *ph, u16 *size,
+				    void *array)
+{
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_misc_syslog_prepare_message,
+		.update_state = iter_misc_syslog_update_state,
+		.process_response = iter_misc_syslog_process_response,
+	};
+	struct scmi_imx_misc_syslog_ipriv ipriv = {
+		.array = array,
+		.size = size,
+	};
+	void *iter;
+
+	if (!array || !size || !*size)
+		return -EINVAL;
+
+	iter = ph->hops->iter_response_init(ph, &ops, *size, SCMI_IMX_MISC_SYSLOG_GET,
+					    sizeof(struct scmi_imx_misc_syslog_in),
+					    &ipriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	/* If firmware return NOT SUPPORTED, propagate value to caller */
+	return ph->hops->iter_response_run(iter);
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
 	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
+	.misc_syslog = scmi_imx_misc_syslog_get,
 };
 
 static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..2407d7693b6ba1303e07629e45e2a7eaaa906fd3 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -59,6 +59,8 @@ struct scmi_imx_misc_proto_ops {
 			     u32 *num, u32 *val);
 	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
 				    u32 ctrl_id, u32 evt_id, u32 flags);
+	int (*misc_syslog)(const struct scmi_protocol_handle *ph, u16 *size,
+			   void *array);
 };
 
 /* See LMM_ATTRIBUTES in imx95.rst */

-- 
2.37.1


