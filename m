Return-Path: <linux-kernel+bounces-799383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10ABB42AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B4A7C28FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4723728BE;
	Wed,  3 Sep 2025 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UsEkb7a3"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB1372895;
	Wed,  3 Sep 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930851; cv=fail; b=qPtTXQG/Y77gbBhhFRiB0KJLprjqC30u3mGIs9aBgJ7BT0rpdWZNDsyzPybxOwm842Lt6aneZxYfCcYWGYLaZQMMWXxHQq/aYssHN6BIqaH7gsKVw6oGmcyuq0COcxr/JO0LjbJoS8oM/hjdey2IOJxJOeU1N26eZ4eVwWN6w3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930851; c=relaxed/simple;
	bh=1JqeIF+dz5Kv4yzfD7n+SUbC6EVUYkjvV2oxC7MafhE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=al9kBxzOs9RfRXO8YUDbaWsJamU3NrEvtEm/z4RvsJf99U6uIxyxFNSRmBO2yfzviYqBwnU/B25WchZYodygitmJ1JiziPYqe9fboi2TRklEBJ1iLXiT5ssKWIGUDJTgtBBD3/KLwhm/ulCPy8RiZ5t/IBVRYlEI603mt4uCFZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UsEkb7a3; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMdhdDJGIU/HEHW2YOmImSiJiDnXMIfSOTRkf+VootZ+r18aQis5BYu/PbrggmSHoDnEdCaI0+sBiXwAz3eP5zNcfbhezH3+PYByryP65R7ziIKAPjckzLg9RrUKNJ3XaYS4rilxpIHlB+kWK0zai2vfXDea0vND86f6TYzfuxVtC+qAAYSZgCw9Q6yFWC4RVy0PeegqPQR9Qiz+vUelIlsZTxKn1lo8y7AMLNMnVt3mN71rsBU6YdncYtN5aM7+sMowkF2a3dsStTsUSkgKNjCCIOBlMR7EZ0vf9u2TMJipJ9+ObtHwn+mDYAVqiNpa0JhXgd0Hwd991OsC09sbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w66GK7OHmCQlNq7c4C0gSdpuR7WuBmM0ujXC7Rrxorc=;
 b=JGHHAZk0kS9FsFzjwfPe5BLASB4/ZYeQVToxajz/UcfdgmZhiuZutnD9D7kYBssCqub1UM4I1uhZlkTfDoOXb+Am2FotTnqUXnyhR7OFM4OIlaQbnAyLXJCaVwEojm/acsHTqjnvThZqR1bwA6t0CD6q2Y1kvEuwKmtMdUqCY6w6xSioYPFNVT5+gR8bMymgZ+vhsvAsjxRXEYRjFk0USKsLhbWG7x8KZ0JLv8QEJaTWvNYyQfatRjuTjKJl8dqPSYD8G/sDvAHZv8W+enqRpvlhw7KHIlP9XTuJy34NMfCwm/zly3x+hNaP6cjEimOil8fqeEIKu2XRUlLAkWKaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w66GK7OHmCQlNq7c4C0gSdpuR7WuBmM0ujXC7Rrxorc=;
 b=UsEkb7a3DrB1BOnOrg/VUQbpiAfRcBiwEWWZb44uDS3QscjxMJc393NX7R8Pj7QwPlCLApZShGa4CLdImr1OYiUU0bgEaoHXf8iDTxMKjNgNY9KXtcxCgF8q1vpfH/TAMTtoTXz22sHqV4R3xWvFzjR0mmVaI+gn+XxCzcwpFBGEt4CA5F+2Y3Ik2lV//cvCNFg3Xbva8+EQtJSWnQT/eaydhsX2FNbX53khCzL7runOB2vyRmO/6zihxugwir2krzNx0MlIBdCRex8OdBbockIxOM/0xzSPA2rr91BNHZUyaOukEM1bDn55ozb3pL/yYyKGfSitaQZmhxFfnsL5yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:07 -0400
Subject: [PATCH 14/16] ARM: dts: imx6ul-pico: add power-supply for
 vxt,vl050-8048nt-c01
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-14-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=846;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1JqeIF+dz5Kv4yzfD7n+SUbC6EVUYkjvV2oxC7MafhE=;
 b=VTk5xzT5BP6rqYvUoI/MRqBwFFZdnjkXP5DW4VnjVZTm5kV3pm1Vb++sTNrA0qeGOiBuqeEl6
 UA7DR+tjjFJD0+nM2RG427+h/eE5Pgmv6J+iEfhpFx0vpnA9NCEJbcO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: d33b4e3f-8421-4bba-a6a2-08ddeb275bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emFsbytkeVBDQXVPU3VDODRCQzZHU09SQ2lPcEt2SUlGTlE3ak1LVndQQ2F1?=
 =?utf-8?B?N21ueDkrbTBVQXJGZXRubFgwQ3UxU0J6YUhlV0NFSDBSZWdVenRndmExYTFo?=
 =?utf-8?B?eE5CU2I5Y3h6QzJLMXl3RGVQRHRHUEpHV2hCQXdVR2dFcEl2ZDA0SmVFNVZN?=
 =?utf-8?B?RExHZmFEN29EYzdvTHdIckN3OWxVbUdUSW9NcldFaEFPNlVHQWtmSHlzWkRX?=
 =?utf-8?B?V2x6bUlpdU1ueGFwT2JlQXZ3QlVEZUNUV0tMMVBISXo0ZGsvRXZrSXpEalZK?=
 =?utf-8?B?RTBVS1IyTFh6djJJcmR5dFhyYWdYYlI1MW56VEF5UmtyYkRqM0llemdyVVhs?=
 =?utf-8?B?ZHhPN21UZ2xhZXRXQm51anVlZzNqMkkrc3B6SkRSQTNyK2dsb3NMbmxvWUpZ?=
 =?utf-8?B?RlF5R3ErMXV3NUlmYk9wL2NjaWE1WWVIUWxBZlpMWFFSNWhzVlpXMXBJUnBN?=
 =?utf-8?B?SXNuYVR3aDF5Tjh5RU9jaTZoaEN5N2NteFlXZ3ltby83cWlFWlJEUkZoZUdv?=
 =?utf-8?B?aW1namFOTnJySFJoN2RXVkhDejVzbkRDK0xLM3plRE5MbVZpd09QU3VMM0Vu?=
 =?utf-8?B?SGNRcW5iNE1mU1E2blA0L2IraGlLcVZTdkZlcWxoNVcyZVdTT2NVZEJ4OUF2?=
 =?utf-8?B?ZGYrRy9ZRi9zZURGS0JvVEhZeHJNYWdESzdwSUtyejcrS3JQRGxINDFPYy9E?=
 =?utf-8?B?b3dobXVpSUpQTVUyUjFRek9ZMkY1OFVhb2R3TXZxR1FRajdXYTNCZHphd1hW?=
 =?utf-8?B?amxJelNZajJtbTdYdmdMSjE5ekgyem14YVpWUVhmVURRVExlb1ZWcnFqa0NF?=
 =?utf-8?B?Y1BKSWVqSlQzaEk3Z3hKdE9hcHFFdTBkb25tcWFCNmI4Y1VNRGthOE54QVZW?=
 =?utf-8?B?TG9ZR2F6ZWtqSTYwWWhSVk4zOFliYTV3TG9UV3ZkQkZHZXhPVUphU0Y0SVQ0?=
 =?utf-8?B?MjFtVVhpTDlwTmFnNUxZLzErOWg3c3J3Q2gvNWVqMW9yTGkrdllZQjFBMFAw?=
 =?utf-8?B?TDhaTVRNRTBzak9NRzJGV0F3U0JqdzNlK1BQM1p3UGl1MGx2OERIckl0ZFE1?=
 =?utf-8?B?a0hqc0NETHBkQjRMV0tseEZiWDF6TXkyQng3SUVnYTVZMVdnY0p1YWJNMnBQ?=
 =?utf-8?B?NG1QK1NBVGIvU3RlYm54Wkk1UkhSSGZsbnZRNFZyWUlKZm9VdDl0bjJBbFc5?=
 =?utf-8?B?RkljTmhsaDN4YjgxMXJBTSs3a0Y0SGdWSFFVNDdNbkI3Zm1sYjY5QUV5VUsx?=
 =?utf-8?B?dEJCcEhBQ1BQbkVoWGt1cVRwdGtZWlRobE5xUm8vQnBITlMzL29JNlR5Rm9p?=
 =?utf-8?B?V1NDQXNWRHdYN3dRVmJDaCswcEF1UTM0UzkzcWxUTmFlbEF4M0o3WUVvajl2?=
 =?utf-8?B?OGhXUjVlcDBWRFhEZUIvOGFyY0N3MDA4U0VWZlcvY2xUeFF5b0tEd2huc3NV?=
 =?utf-8?B?TlFaOHF1SUV0UlcwYnN6RkxmNWJoTUVnRFhOT3llRVptTkhMakZyRktsTVpk?=
 =?utf-8?B?NzA5RGRHZk1WRGRUWEtzZEFXcUVnZHFNdStSZkdwRFpHanZJQlFoaWtTVHZ4?=
 =?utf-8?B?OG5ubytaYWY3RlVWTkJmMWFFWEZkUlNzMDV4M2ljWkp3ZDJldnE4SUxXY1Uy?=
 =?utf-8?B?aFNYbjNIVmFRN3ZJNzdZaDV4UVVwU1U3T2dHU0dXQUlyelNmL01nNldCNGRD?=
 =?utf-8?B?aEJKNytOQ25tRUdWUzdRcm5peVBFL01vWGtoUGFvUGNTN04wTFVIMTFzQWt0?=
 =?utf-8?B?bTh6VGZVY1p3L05OKzBwOHBOS1ZNY1kwUTJNQUtFQ2xhWHNhbHF0dkE1U05z?=
 =?utf-8?B?cXR0Z21FaDdrOXZMVnZSS3BpVFV6OU4vNUtqU3AvNW9NdEt1dVlqNnU1Q0Vs?=
 =?utf-8?B?RE1XMkxqSXYwVmN3Wk9KZ0Uyc3U1SEc0NFBibHBxcFV2YnRlMXpGOHVRaWls?=
 =?utf-8?B?Y2czQUlXN2wxY2VVdEhiY3M5cjFaYkdBOStEUW9tb1VaOFlQdHRHWTNoMlFh?=
 =?utf-8?B?V1d1OWorSEJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG8zeTJqeVJuTTlQWnQyMStYUjdVTnVvWjdGQ0FJMWNxcERUbE5wdWFveU4z?=
 =?utf-8?B?YXhWcEl5QUJVS1NUeHVnQ3BweEpWV3NKV00vSWM5bDl2dnYvakdWTVlPc09B?=
 =?utf-8?B?ZFB2NHpMdUpXQmNKcllWSHcrRmFkS2Y3ajVVOXhLMHlxcjBkWC9FSmRmK2FN?=
 =?utf-8?B?VzJaU1ZkYi9xNUpKMVVXelBaQjgySXowK21hcnJXSmlBS2RueWNQRTNvUmFS?=
 =?utf-8?B?Z3R1cHNLREhvK3crR0x1MmU2eVdqUW1sS25pVmp3SXA1YXZZYzJOTjhYMUNy?=
 =?utf-8?B?bVVtVDM4UE5SelI1TU45Rnd6b1RxSWxFcWZ4U21zZU84RTNscUdMSkIrYWJV?=
 =?utf-8?B?d0F1RUk1V2Rack9hc0xHd1BtNk9uMlZXcHFBQUhmSmowZFNiVEs0OXJ3d1FE?=
 =?utf-8?B?VkhDNEVsam1DMmxNVUt5bENTOE9rZWpER3hXem0vOElyc0pXZk11L203bmhX?=
 =?utf-8?B?SFVsNEFhTkgvZk1tc3VaL0ZIYm1HblZ3MXp6L3dpa1AxS2U0TDBjcGYxNlFP?=
 =?utf-8?B?YmdZNDZSYVZDN3JqSHhmeUgybHIvU3d6UkxaNUd2Z3BUdW0vZGF3NlUweUxG?=
 =?utf-8?B?OVBjL0lpbG5RNEhDWDB1YS9aRGlvaTZua2tBaDZadlN4dkR5NUFSMFVGeTZQ?=
 =?utf-8?B?dStjcUluTTM5eU1zdklBNXVYTFlLSjgyVUZOL0RSODlIWGpCL3BmeHpWMXR6?=
 =?utf-8?B?Z2krTVFKYTRYaVNHS3VqakZRRUFXMWh6aU10ZktoejEyejVxeDNmYzA5akJN?=
 =?utf-8?B?elFicUJSeHBPa0xSZGtYMUhsNDlkbTBKVDlvaVdidkswRWo4VFVBMEdzU2Nv?=
 =?utf-8?B?UlpPN3Jzbm1lZ3c1RlhuanJkMitrNE54K0dvUm1QczJzMHY3MTlUV0ljYzR2?=
 =?utf-8?B?RVRUU2NRY0pBOUJtTDlFZldJT3FOQVVqK3VCTmgrUEJCNUhxNFNnTmZoT2NV?=
 =?utf-8?B?K21uOUlER0puNlp3SWZkK2pFb2hna1JsZDZyeTExZlVjYzBuRTQyNTRmeHI4?=
 =?utf-8?B?bTFyd3A4SDlzdnlMNThSUVdwbHNvc2trNWY0OVpIT1lMUllRYXNMaWp2MW9t?=
 =?utf-8?B?RXFTQzdydHd0dDdiVUtpaW9tVzR2TWx5elJQVkdRMW1mVHU5cnU1cFFQT05O?=
 =?utf-8?B?djFnSmtMYjM5VHNhL0twWVJBRGQwa2QxdGxldUEyc3BjbHMwZFNud01PNkFW?=
 =?utf-8?B?S1N2YU1Xd0dXS0tiNDhCNkY0ZjE0bWR4d29lblBsQ2lISEFhQzAxZW16RCtR?=
 =?utf-8?B?SnpyZnFlejYwQ1FmRXJQUnJzbHFtcy9hZjdRZWtGQjVQYTFYWEJkSlNobmho?=
 =?utf-8?B?akNJWXpHNUh3N01aK2lzQU11VHRwSC9td0dMM0VETU0vZmJxSmNkZTRSZ1lL?=
 =?utf-8?B?NGh0dVlPRUlBV0lUR3lvTmlvQzVsSHZENGxzdDJzMGEyNHY4cGZack5zNU9j?=
 =?utf-8?B?VjJING41eGVCcFBVNlZHNU9IYlV6RFFDUTU0c1dzQ2liWDgya3VTWUFLVVRE?=
 =?utf-8?B?U2t6ZnY2ck5EL2tDKzFvSGN6TjFwbUh6SGF6R1FwaXYzaU9oTmdZeW5lbjF0?=
 =?utf-8?B?WHFUajhZbFEyRGlZZWYxUjhraUxxNVdnTm5BbFJnajdxZlBWanlkemJXeXdz?=
 =?utf-8?B?czM4dlBNNEtjbHBYdHJMemtLUEZ3cHlUMkJUSEtyZ003RUpCN3hUbFZ5WUxJ?=
 =?utf-8?B?UEd6dUY3U2ZkOVJSNG9vQUZjU09JWVpnRFYzdjU5dDFGa0FhUUloZ01FRnE5?=
 =?utf-8?B?TlFEUTFzSmZ5bGNUNHdFWG9vUmxjOGVTQU9NOE55MnpFZ2QyakN3ZFI5UnhD?=
 =?utf-8?B?dW8xa0ZMQVQyK1VDV2haYUlEQXptR0hqRi8wbVNsZlZQVEtvS1VCWHRTUVNq?=
 =?utf-8?B?YkJvZ2VDWkVra1VsM3VKWUwvdmFtd2tsQlNhNERMOTBJY1ZsNlI1Q2NwNTNI?=
 =?utf-8?B?aFBRYkorYVBkcVBCWUJ4WEVRMWVhUDhtYndRVmxvWm5sOE9PUmtWb0Z2OXR2?=
 =?utf-8?B?SXc5NmFGYk43WFJXWnQzUk55OGl3bW9KM2Y1MUllaXN6TnN5VGo4NC80amhI?=
 =?utf-8?B?SnRKMGVFU0hjNlZSL25CT1MrTkRDRFRjRzJJQ3BNVTBDck9TVDMyOFJxNXV4?=
 =?utf-8?Q?iiTW18uZqpYlXm8JkPOQTVXDM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33b4e3f-8421-4bba-a6a2-08ddeb275bf0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:44.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBfQKL5VjxuVf0dCTLNUwQlvuJRMztQUA5yp82nRJHupQIMJ0JBFFCuBuCEM6BnQiUV7DYiaRcWeWsgqMcLuSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890

Add power-supply for vxt,vl050-8048nt-c01 to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dtb: panel (vxt,vl050-8048nt-c01): 'power-supply' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi
index fe307f49b9e56794f538486a90cc0af6cfe3bd5e..9fa5225994e301ee46a6ff9b7f122e0444369aa8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi
@@ -76,6 +76,7 @@ reg_brcm: regulator-brcm {
 	panel {
 		compatible = "vxt,vl050-8048nt-c01";
 		backlight = <&backlight>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {

-- 
2.34.1


