Return-Path: <linux-kernel+bounces-868264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44382C04BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14D1B4FCFA0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390352E6CC3;
	Fri, 24 Oct 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L8+Wlv2X"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C92E2F09;
	Fri, 24 Oct 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291149; cv=fail; b=J3un0PPmao2lQT4CO+kTO+zpxjBVS3IDsr3eHU9VSAQYdlxy2TT4ic7izsXlRIOx/aWNcUiJ6fNxNOn5Tu5YL8PKqx8btSoUtVCMO+h87RkGOCqwFjcoxJs6Xtyd53wg9i2An29mVmyK7vX6k4/xN12bAmX7GToq+PWDIdHvlIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291149; c=relaxed/simple;
	bh=Xk4Eqil/qAqF7k0PCJvvl0nytUdzv29lYDVP/f39evk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aNle+3wc9SF7vtNrsVVBf6afDFM/SNkpBWPa25qw5jPWAC+vDnLxiK91IaTeCl8q7nlhtSVsg2zVZOdZKUh6t6MyDwE5nVKsyqDekZpIhB5dW7pS+mBHGRp5qI1lPKYw5xqvoq9Gb5rUQ/e4uEAT/p7z+W+vNoZBUyAYvx6mWX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L8+Wlv2X; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP5YWJDJAK5EL6smrZe+5DX0cGA4mKBl0RbYDeYH/DYJpeBXUBhY92TwJsBKcDkq0nu3YfDtFUj3hZ/QBnCG5z9gg4yNefxsLlD72QqvwPfijbPUrMXoWIpAqFAmnI+WGbXibXdnVmsfnOfiFbaNok40IEVZhdzKETRm5COVZ+EXXrrcKyrpHpeM5CLWNIdjCvDSSunRZbLx1X3nKsyRSRmUNXTb1mWdTC0QhdvBOPI+IQHqCy6ubCTpdWnDY7YIJu0xPT+NjvcgFcMJcs5v3q9K4y4U+15TEpAZ9WxRnt4AeP/B5j4fR9NKq/s92NnfGbYJLlILh+PE50+fieMM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqPKatkClxXwQWeXZbsnTjIf6gJ0PTHgSmXF8xeh5PA=;
 b=XjrNDAteJsdtfw+33H94pg8lVQmYtCszDMu8ET8lgwxgI19jwxSrS9VdvnIwJYqw1OnUgKuk/afEwDOBzLVjzQkbQuAiYdmevob8ZvSUh6XKLUMyVUPM2NQ23nn6PDSO8VXVidM8kk9PU9XqlhsglN+E8NTfVnd5h8MWqjMt8nycjCMkpK2QGpK4eaElBqzgrK/WaWJBqhM65wjN7vxEBqgI2vPw0UHMTuSFY8Ncgv0Iom/ZcO4A+k8h7MU3ENKjwg9mclsjzV+p6Snd23dLRd21QsWASnj3uS3BwTJVwoRNsIAvLiTgjm3LrEZZ/Je/ASFquPrOVIaY/eWCHcSkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqPKatkClxXwQWeXZbsnTjIf6gJ0PTHgSmXF8xeh5PA=;
 b=L8+Wlv2XRHRCCj9SQsxGd3TaT0VaPh7QPpMb+Lo6TUGe56AB9k6hQfUYpZaYwTzpsoOWdYuu1zlYqt9Imzm+QOr+k4At97m6z2GdWeh7BiUJSUoqR53G/mIJZBvrgxQ/9n+GuboHrRuFHfpQ8GitiGdqPVPiUsDQDtHUKHYT56y6RHRazkWmPkogv8uIthCFkNDYPRsEhp+Q5/SNnYZLNDLVemlR23G+DW58cTDKovbx2C1z2kc/2eNYdbRxcqYDM4MNwqE6sWpDjmDLcbSjlrG2ADFNUH/9rmrkSMwp+RzReuzkXzjPGBHJvKDByIYBSnYstt1yLloaYCyzqVJovg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:32:22 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:32:22 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] Add vpcie3v3aux regulator for i.MX PCIe M.2 connector
Date: Fri, 24 Oct 2025 15:31:45 +0800
Message-Id: <20251024073152.902735-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VI1PR04MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e676b4-8978-413a-54be-08de12cf7863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEpiTFpaNUtyQWlnelVLQ2tQS2hrNkJTbFFPUXEyV1RNNTVvSXM4TjFMdVRj?=
 =?utf-8?B?ajBzUk5ia3VvVXY3dGFWOW5kcEdHS2NrUzdMdnp0RXlGS0NwZzlVT3hoeDRK?=
 =?utf-8?B?eGltcGVBaVI5aFVoeFB3YmdWK1B3a1JvSmcrZE94R0pPQVhRVHp1QUxJWDNJ?=
 =?utf-8?B?aWMrYnphR1JJZmFnR1FJeTIyckN1N2hwUzhFUm9mTXErdTlZM1ZtcDczWkFs?=
 =?utf-8?B?NzdnOVJyMlJVSTl1dTI2YlBHOWh0MUt2ekJ3ZlhZc1FacWk5WUhNM055Y2gy?=
 =?utf-8?B?d2xsK0ZxQzFTNGV5ZmtndDFPV3U1R0RlK1RXNm12RitNSGM5cFhYZWd6OERI?=
 =?utf-8?B?SXIxV1NoTWRjL21MQ1FHQkJ4NjREYjZUTzBlYXdBM1l4a2dwNXE3TXd2R3Ru?=
 =?utf-8?B?TWU1TGErOE1yV0R3eXVpM3FjUFZvVzVuamZYMTJKYU9KM1kxTnV4TXhwY1NC?=
 =?utf-8?B?WnhEWWpVQ2k4TFYvbk5VNmpuc1ZCSTBNVEErQ0tDczh4MURTZmxIZUQvdWZX?=
 =?utf-8?B?QkVGcDBTMThPdk1ITk9HenVlSGRMSG5wc1dCWk15Nk04ZUE5NlE0ZTcxWHpM?=
 =?utf-8?B?dUxMMGk0WCtrUEZ0NGRxZHBTYzcvZEVOdC92ZlkwZHpYelkvczlEL2xRWWFN?=
 =?utf-8?B?am5BREZBRmI5dzVKbTFuODNhZUVGdnNLVUJlaGx5TnlKQlB4bVVsQUJuejhr?=
 =?utf-8?B?WXVrM3d5MU9aaGt3OUVpNnRQcmNIMDZrUndralFLdU1McjkwbjlONFFNS05l?=
 =?utf-8?B?S1pHK2IrK0Q2L1hzN3NqQTcveEwvQnQ3L3VmRUZZV2JKckdHU2gxa3ZPcisy?=
 =?utf-8?B?eWthWW9DbEFORHNCd1M2ZXZ4VFlvcUJxM2JpeEN3bjVyaVVFdnNkRk1ncUJ5?=
 =?utf-8?B?QWNsbStpMVMxOVN6TlVWQWVZV0VKL1pmdUFGRXVndFJCSWhnNGFnd0gxbSt2?=
 =?utf-8?B?MUhJVHR1czBXWGYyTVlIMEdsSkt6NFBRZktuc2JYcUprUnhudWExZ0QrTkJp?=
 =?utf-8?B?dUF2TmhudWhHenU4bHNEa0N2T2pseTFXYklqMUF3RC9IbzhDZkNjZDdMb21B?=
 =?utf-8?B?QUxoTE1EN292cDAzR3VYWkFPckhlbnBYcDU2VTZLYzkwVFEwQU9aeTRtY1pK?=
 =?utf-8?B?WEU5UHpsSm5zakdpQURwaEI1VVhiSHdJT212em14Z1BSUWc1U2g5MjZBOVdt?=
 =?utf-8?B?b1dCTUZmNmg4SDZhVXBLeGhOYStlcTVKaHJHanhPa3lKUEtTaGtObFk4QWZB?=
 =?utf-8?B?UGlxSy81dGR5aHJXZnA0NGdwVllEcC96RUlQRUJ4RWwxbUROdEsrTXk3YkNP?=
 =?utf-8?B?QXNxd1ZmYkM1Wmg2UmwrbENJWTk0Z2pHRVl4d1dsL3piSzR1RHFwditmM2pp?=
 =?utf-8?B?U24zQVMwbURnTXdMaGc0cEt0bHhFZEVQNEtVRjVLSHV3ajF6Qkl6bXdpYXZE?=
 =?utf-8?B?aHB3QVRlY0tlU2txR201TTZ0eDJ0eXZnZG1MMUEvVkxxSy91OFMrOFlpY0U4?=
 =?utf-8?B?MFFTZk5HbnZBNnBZZjVpS2pwblZwT29nU2syYWV2K016UFFUSnRsc1ZRY1lE?=
 =?utf-8?B?Wk9jS2VTekpjTVNvQkJHY0cxMkIxMzRvTmU1Y2tLdDdTWGo2VDF6UnlIRUVu?=
 =?utf-8?B?MmY1ZUU3WU04WTRvMDNjOXZRclcyRU16SVRaM2xFQThFT2pPT2dET0Flb2V0?=
 =?utf-8?B?T0I3dUdqQTg2RUM0R2l6WmJLa0tDeTVXRUpEazRzS09MQ2JzTGpXaFlIeVJY?=
 =?utf-8?B?MWlkRU1MQ3VYN3l5Rm1VSzZqUjBnNnNZT0lqM25xclpiTEkybngxVXNadTgw?=
 =?utf-8?B?YU5TRVc2WlFvS3dHVjUwdk82eGdkQ3hDbnNZdUxnZE83TncvUmFOb0JDV01V?=
 =?utf-8?B?RGNsVlozME5PdmVQa2xmbklRSjhWSTJSQmhVNGlwWUZSVndoMnZ4bWRIaVEw?=
 =?utf-8?B?eHRkZEpSTmhwSGVyMjFzSGdHRVcyNGtMQVZYdFYvcU5vNzRqek1IRjNkMHpH?=
 =?utf-8?B?eEk2YklROWp1czhRTWdGOUN3N3RsZ0s3b1daY242V05LNDFLeEcwbUFReVpL?=
 =?utf-8?Q?hobNN0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXQwZ2VNN3FPbjg2cFJkUXg4VDJxWnVmK3dtSjNqWlRpVXJzOUJJNXlLbmF4?=
 =?utf-8?B?MlJsenBSMVVaaUhZNVNsQzNpQXpyRzdvN1pCcm1NbzlBcEpnR1U5bEo5UWQ3?=
 =?utf-8?B?WFVzNUR4elIvTlZickt4RTBrMU5GbkVFWS9sY0l5UTRUMCt5dTlqNjNSRHpt?=
 =?utf-8?B?dS9jaEU1Z1pYdTY2bWNKK25jMjNqQ0h2VVpQdS9VY2ZMTm9sTEwybWxCSWF3?=
 =?utf-8?B?T1pvdkdJcDAwRE1UaURBTFB1UUl6dUVjU0FJUWpER3JvNWFmRGFMTnB6aVl0?=
 =?utf-8?B?aFZmWUU5ekVjb0xSSEYwc3lKM0dIRWRySHJwK1NRM1QxL29UTS9hem1ta3R3?=
 =?utf-8?B?SlVWQytPZGNiMGhEUFU4SjdVZEgvQk1lNjM0RVJweFpqMS9TajZqNFllS1Ja?=
 =?utf-8?B?OTNLc241cXBtNDg1eVp6SzZtV1Y0bUNzbmtpcnJiNlRtNlFPZVYramd2THc1?=
 =?utf-8?B?aUM5UEwrUmtSQVcveXpCNlhUVDVGRmNQWFFmL0xCdGhod0QzTVVVTFNUU3lM?=
 =?utf-8?B?eHJ0QTlHeTE5NDJqVVpoRDNJMkpkazZtS1JiN2pHTlo1NXFyektJMUt5Q2pC?=
 =?utf-8?B?UUlaL2d5R21vNHM0bk9LMHZWSnM3RFlNZFpUbXVIZGF5RWpzd24xVVMxOVk4?=
 =?utf-8?B?bStDZVlDMVdRSmxwUXN2ZEt3c0orbTNJdVhrTkVCV2dRSUE1OEJ1enh2eVJC?=
 =?utf-8?B?aDZEbys0eEhqWE1OT2VlTW1mRG1ZaWVCRnNRWnRURzZtS0Z3MFJqQlg2UVhy?=
 =?utf-8?B?V240eGJUdXVGeTZLRlVhQzVBSnF2K1ExellxMFlyTEQxSTZEZjcxdUlmanE2?=
 =?utf-8?B?WkRkZDFSZ3IwTWFkYTF6cFhDVUtiMjlZd0dMRGxzUVNTNFoxSzVNZFBhbWNS?=
 =?utf-8?B?NU5JeFVxSUVrcDNnZnpmYTFoOUhFY3l4UGtUTjhZR3pxVkxIZHNTUmR1OGVy?=
 =?utf-8?B?dENtUGJKZUhBamdzRFRDWW1KOVpxVWdtWGVlNi9qd0lJNHZNNmpVQ2FjKzl3?=
 =?utf-8?B?OURpUjU5MHhrNkdqZVI2YjduRUp2bXNxdmxCTktFdVIzaVhDWkJhbDFUcUpi?=
 =?utf-8?B?bW8zSTVnbHNnL2FTRFJ5dXhESkxLaTMyNVJDZTBqYnlZQ3BGNm1kak1tUEtR?=
 =?utf-8?B?cU1qUis4UlkzOTFNZDNCWEpKTXVCKzdBRkY3WWFWaHh2eFROb2xaZW1jSHp3?=
 =?utf-8?B?NXpjVldhSktKUjlwRDZ3TW1yMk9URFNoVEMvRlFqeVNGOGVSdkl2ZDZJZ2hp?=
 =?utf-8?B?L2xITEJYU3B6QlBBelhpTzNGUmdPaUE5MXhkSG42QmxQVjJ1VVlpNThuUnM2?=
 =?utf-8?B?Wkd6QVNOZmErNEp2UEdLVGRDVVFPaWcyMXd6Z1NVWGJCWGluV1JvaEV1SUVR?=
 =?utf-8?B?aXhTTFc5NStUTE9WWXh3WDNPQkR6T0w3bStWdVpNV2ZvMWtvK1lGT1FwOXc1?=
 =?utf-8?B?QllmVzVPWUdyMElZR2pYWnU4OW02bzk3THNpbVdGOWZiYUNNRlVLR1BhdjV1?=
 =?utf-8?B?bitDRG9ab1AwZmdscVZMa2hIMmxLWEdGalYweVFVYkl6dS8zUlFmR3ArOUFa?=
 =?utf-8?B?cytRUUh3T3gzc01VN1hma09nK21BVnZZcFdDUGxRVHBvU0tnNzlzM2c2MXJj?=
 =?utf-8?B?YTVhVW9rZ3BGVE5Sb2NveWVKUUk4bDZucjFJcldNQU1NVFZ1YlFIYXRZVnBv?=
 =?utf-8?B?eU4rZVJqT0UvNXdxMCtvd2xVd1RoS1UwSzduaFJNZll4RHY0eXlVTVFET0tT?=
 =?utf-8?B?RUNvTUJPUFd5d1BpemdDVndtUHZXUzYxYzJsVnlYbHFXYTFMUUgxK0NpdU9l?=
 =?utf-8?B?b3ZIaDhUZlFlK015ZUl3L1REeUVsRmtNTnpPQnZDNzZ3U2J6aldwTjJKYzhQ?=
 =?utf-8?B?TEo4UUZtWnRCY25BeERFMUdYM1YweHpqUGd1cDB6ZVRvUEN2bE93K0xaS0dZ?=
 =?utf-8?B?bHdUVEg5TWN4UnN1L09Jb3ROYUVGcHF6T2hiKzVRTzRzd0xLaWYwQVdGbWln?=
 =?utf-8?B?czFQSGNISExTckJocTZCTTVJTzFodkVpeG53RXhIanZhbjBHbzhFVk5wdnhi?=
 =?utf-8?B?NmNXQXJNekRLQjYvNDFoVERVeHlxempNVENDTkhITExZU3F0R2paQnE2ZnNy?=
 =?utf-8?Q?5PJSFeRtIRiLSmlZ6I5vPdb7c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e676b4-8978-413a-54be-08de12cf7863
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:32:22.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+RUtfWl2Cgko5EZ9SebpnEQvPzJr8Kd0somLl1nZNHMJkw2EkbHd4XfO7AgVbnu9aNz6LonLd+lwJxj1EUcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6941

Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
Grounds.

PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
source, 3.3 V, is expected to be available during the system’s
stand-by/suspend state to support wake event processing on the
communications card.

But the current vpcie regulator may be gated off during system suspend. To
avoid the DT back-compatibility break, add vpcie3v3aux regulator to let this
3.3 V power source always on for PCIe M.2 Key E connector on the boards.

[PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux regulator for
[PATCH v1 2/7] arm64: dts: imx8mp-evk: Add vpcie3v3aux regulator for
[PATCH v1 3/7] arm64: dts: imx8mq-evk: Add vpcie3v3aux regulator for
[PATCH v1 4/7] arm64: dts: imx8qm-mek: Add vpcie3v3aux regulator for
[PATCH v1 5/7] arm64: dts: imx8qxp-mek: Add vpcie3v3aux regulator for
[PATCH v1 6/7] arm64: dts: imx95-15x15-evk: Add vpcie3v3aux regulator
[PATCH v1 7/7] arm64: dts: imx95-19x19-evk: Add vpcie3v3aux regulator

arch/arm64/boot/dts/freescale/imx8dxl-evk.dts     | 1 +
arch/arm64/boot/dts/freescale/imx8mp-evk.dts      | 1 +
arch/arm64/boot/dts/freescale/imx8mq-evk.dts      | 1 +
arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 1 +
arch/arm64/boot/dts/freescale/imx8qxp-mek.dts     | 1 +
arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 2 ++
7 files changed, 8 insertions(+)



