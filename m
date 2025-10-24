Return-Path: <linux-kernel+bounces-868271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB5C04BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66501401894
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E62EA16D;
	Fri, 24 Oct 2025 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NXOicEls"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49F2E973A;
	Fri, 24 Oct 2025 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291178; cv=fail; b=gXgXTBlK8iQDaXKlTF6IlfqcYQjRosuRWcKtb49O9afzyLCNNf7Y3EH8DUCJSQXPI8Qbv+zz1E3VTdyh/KZ10XuzzyFi8eJWCbXvVqIAvE0oz24nr31pQVmHupbd2venKxGtWgoXRflMuIDP9fal73wIA9anHYqW3LA5WnWvp3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291178; c=relaxed/simple;
	bh=j829n/iL7KKje/WxZ5cD+/eGKz7W/cEF/p0K9GuFcn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d24bLz3nHrP97jt4GZyPeRpflT4CWfFn1el6IHmrRMeoiGTq9lV0yuInRlqlelSsE5r32vOQMdwmBX+TBn3S0Ng1obzm3daKJveuRuLu7ELoF9ML2sq2tCRbolfz8O80XourUhqyR7QwgmUwO1/2KyM5275+6sajtwYkEem89rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NXOicEls; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S++K43BvNaudUgAOkueJpAsAfVLGbzBK1xIFb9T3WkBPrmlWULWcH8p8sXHMvD7TueX7l4GZDKPXSF6jJo7j1tEuep3imCBygfQFuA6V73ceqNX5K2p2Aj5ZaIrsOhQnJOWogCmG3z9hSRNJWNlnvWvGJIQat5pSqlqLZFsLIWLFNYIIBEjAW1LuEC1lLaTqdIvGM3BOYV7hz9p3vrmJvuRbvI1xP42/Ukjq2ohIq3os0TGLQd9ZFn6ZctG2MkSh+0ty5GU850/rKsb0p2vdZ2X6INdSfEk/QuucAPLQm/njneVBkTbCazrqEYGiY05Kw+ZMuxs9IYezhG0qnIU3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsEQPz+/dHEZWtYB8vBJjhqTiQT+kkWMDmz0N/P0its=;
 b=q4f2mr+Cuc2Gr1Kz/Vk7QSJZlfwU4C/yEJJKeMLI7T94PJgj2fNq/eWk3r+WoMdWzVbqwW3cqV3qyVJmHRwW8mLgeEpuep6SpzcSU93H0B/DywiO1Rsq7SMkl0g6ZveWKTuGFbjoA3CsfQcBH3aVLXe8jYPFwaixjtPRRsDgy6UlYkfaarLqvPkHvuU72GUniiJTzxTsi6SzzlZMGnLcTFLlkCIvJuQBzk7EWSoEa/Y9RO5/r4zA2oNdeN4jW4pg6SCgz2mwT2awPU6VIEFmjVt+wRvdzE7xuM+UAdD8cffapOkJCLVEg/FJU1T8iBo8CuBtS1AbCH8WJi+hVku4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsEQPz+/dHEZWtYB8vBJjhqTiQT+kkWMDmz0N/P0its=;
 b=NXOicElsT4rJUzS9Q4VrI00OtlGwlch6VFDyWmWG3ELhllqyW3Ohufy5Of7ldk2FXl3E4E1ybbhyTMZrd5cDCnkfXYEXsrzsnghIyq4hkZhxilU0Gm3GdN+Pr+iEoawkcNYGiNydw5jE4Pg2EuESInBFi6yOtXkDiDRg848vga2lfvz29sTZVJeN431FBK4+44zvcdAEgO7S38laNmxX0j+yVP75lp+V885H+KYwtSYzuz+Oaa5Ef2dr6i2XYwKMxmEMS7hxEtA8kSAKx0bJ78+XhOrZXz69QVdBWqvbOT+pzuQA+5viSgdDHalK8ZNQjaZgPWgmJn4F3cHKF8J9+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 24 Oct
 2025 07:32:53 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:32:53 +0000
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 7/7] arm64: dts: imx95-19x19-evk: Add vpcie3v3aux regulator for PCIe[0,1]
Date: Fri, 24 Oct 2025 15:31:52 +0800
Message-Id: <20251024073152.902735-8-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024073152.902735-1-hongxing.zhu@nxp.com>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dbe309-56ba-43e1-c6fc-08de12cf8acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHQ3MHRlbU1aejFYaitxNGNXT3pDNEZvVzd1bXJPSTlSOTU4c0ZjRkpGZ2tl?=
 =?utf-8?B?Qmw4SFFRUWxLdlJnV1gwaFZZd2lxN1RPWk1GWTZ0ZjBhbDZvSml3ckMxc085?=
 =?utf-8?B?TDdja0JGMFNOb2t2Rld1Ym9PVXFDVnNQM0tSeUpxQXVyckE1cEtKaFNwc1Ja?=
 =?utf-8?B?L2J5M3YzM24vcTZyMU5uT21DcnEzdUJRSHNBaXZrZGxHSVgyb1ZnNGkvVjFm?=
 =?utf-8?B?R3JsZGhiZ2ZXa2NOTjJabUJWVEU5S0pJNzhDa0xTRHF0S3VzZTBhQzJqdlpS?=
 =?utf-8?B?SERFcnR5MWRJK01VRmltSzU5NHY3Zm1PazNmQktQVE9mZmM3eHI3cXRKU1B1?=
 =?utf-8?B?eEFqWkZ6endyVnhlUy9OOXcrcFV2ZThmRlJQZUVkMVRwRFNPTmFvTEd5YXM4?=
 =?utf-8?B?SVE3d2VlTWNFRVJ5RkVnb1Z0YlR3cWVqUGJOZW41TFo4TXdDRXdPZHQvbUNX?=
 =?utf-8?B?WVN6aFA1MlMxWkRXZTVlWCtOek96bS9jYVdNWVBLNW14ajRjQzE1emRkTURp?=
 =?utf-8?B?aUNBVXRIVE42WHRYeGpoMmUzRFN6VUFoMEFRZWVWaWRnSlNIR1VIemJOMkdK?=
 =?utf-8?B?akdsQnhCcFI5Rkk1cFRELzhlakQrZFllVXAwMmFiekw5eFRQRHhYRnNDcFli?=
 =?utf-8?B?bi9nRGU3V3czUUMxQktkb2FmSlREajFjM05jSnFmbStvTUdNYUNkQWQ0Y2M0?=
 =?utf-8?B?WEtjaGlCQUIwQmUxK3l1L0F5ZGZNOUg3V1c0TFhIbHRPelJsT0hBdHA3bmF0?=
 =?utf-8?B?QWU3bkJWbTdUeVFUeVFRb2VFSDVKWDYwekJ1VFRIMEYwOXorb2RxNEQwWmdP?=
 =?utf-8?B?S0l6N3dZSXhPZlI0STR3TTlsN1B0SEl5U0Z1SUg5RmhKK0czVDhiNy9sd2Zu?=
 =?utf-8?B?aUVPYWhhR0Q2SU1nWWZpV29lbnhTQUZUMjBHdmRSKzIxQzQvODdpTlhjTjJP?=
 =?utf-8?B?RjNzVTZlWUwrNlZUMkRyb0pDbitCN1Z3TjBoMzJNUThMdzNTeUdZdmlKQ1py?=
 =?utf-8?B?bGh0SXp5aTRLZEd5eGVvS21CUHVIM2lreXNLVmxvL2lQVnlYdjhpZ1Z6S09C?=
 =?utf-8?B?K2NqcXhFeUpMdk1RSGZ2NFVyeTFicWpHQlRtWnMxNmxlNEc3a05LdEFOZFFZ?=
 =?utf-8?B?VE42SXh1NzNmNlo4dUUvR0hKZzQ4UFBwQ2p5azc1MHNjZEhwUUpBSGJqVW1r?=
 =?utf-8?B?dEZVa09hOFl3Y253aEpndjR6SDBQTmNJMzhpcjJwT1I2Q2JuVmVzQm5lVkJP?=
 =?utf-8?B?ZXZtRWxCQndjS0p2VXVVdVJLdnZtcTN1aHlhaU5KNnQxdlI0K3c5SSt1cWp1?=
 =?utf-8?B?MklVRkhHVDd6QTVnS0hUQmRWVDJjOW5ldUpxelVCU2g2T2VBenBBSTdLMUNV?=
 =?utf-8?B?OG43bU9iUEQyZmlJZFYvblJMSWtzL3I3YXBaKzRFZ0FIREZHbXhTM0YraU5Y?=
 =?utf-8?B?VkZLb2xHalpQanBUUWJoOUdtNlk5LzE0R2wrdXpGY1BUbkxBS0lnRHlEbEFS?=
 =?utf-8?B?bm9HOVJGQnQxbUVsTGNJZjZGdk9YUHJzZWpKMVMvangxU1BsUTM4WjNTeldp?=
 =?utf-8?B?VTVnRUIwOUF0UXJhRC9tKzhDcGs3UlJBK2R6S0ZxU1NHUHhiWGFZdUdCR1k3?=
 =?utf-8?B?UmVJdkk0VVByRmdWSjJ5Q3YxRXNlb0drTnRvTWFPU01YZk91R1Zjc1RySTJD?=
 =?utf-8?B?dGpQVENsN29oYWhvK1dmSXpRVnoxMWMyRlFadDRRZmRJZWcrRSs5TnVXR1Zk?=
 =?utf-8?B?NDZGWHcxL1RTWWhjN3loYWRTejgwS1NnYVJuUWN6K0cxejhWVE1vbGNZcHJv?=
 =?utf-8?B?blNzR3kxSkdYZkxvY1BiWG5tb05pM1haYmo3ZERpT2ppN0tYSUJ2amJER2to?=
 =?utf-8?B?cE9yOTBzNXhLUUdBRGp0WjBoRTVEeWZkMmQ3WEhBdWp4OC91MHR3NVFrMXNF?=
 =?utf-8?B?Nmg2UW9LTzRGRExGa1RrLzllTGdNU0hVVWtYRkNQMWR0bCtrYzJYLzlwMSs3?=
 =?utf-8?B?Rm9nKzUwdVIxUTBBT01CT1QxN2QwY2NPL09oNTNwbnpiMklGSmVBdjA0L2tN?=
 =?utf-8?Q?3S/6/K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWw3YXhUdjg5bnNzR0daYVJod3B3eGtRQk5XdnpPaXVtWW5RSk1Fb0R3RW9v?=
 =?utf-8?B?eDBkeE1waFhwR3Z1U1JNNUt3SDkyalhjUTBmOFY1SkY4OHpaSmxsMzloelo5?=
 =?utf-8?B?Um0yZlhEUmNvRmdsOUJPYktoMEpBdUZoNFR5ZE5neHlpem43Y0JRc0E0TzZW?=
 =?utf-8?B?ckowM1FtOHhtc2xHQlRWQmUzU0dLVmErTkxTUGtKVUNtZEUzUU8xNytsSHg5?=
 =?utf-8?B?WDlUYWszUWlnSkd6bXlza09WMmlidDM4ZngzdWMyTjc5ZW5Td1BaRjcxVllD?=
 =?utf-8?B?Mk9iV3B3WCtqV3JNZHl3eFUzcXhGWmtnWkZEaDB3b3dJUndpQzdCUGxsZlFn?=
 =?utf-8?B?MTIvUlMwbGh3a29OeGxTSE1DRE1RYTh5K0xYbEVDSE03TndHRDJ6aS9PZnJz?=
 =?utf-8?B?dlZ3ZE42TllMaXdJSjEwRkhrbU5uV2RnZEVlTmNHaUd2QzU2am1scTViZkl2?=
 =?utf-8?B?NFZsNFowakRYTlRxeThrQVJyM0pjdDRza3YyTW4wWWpORkJnZzltMUV6YURy?=
 =?utf-8?B?OFIrTm43UUJCb0pZYnY0NGVTZ3ZHUUlrRnBHeDRoTWhyL0JBSlR3ZHY3ZnN5?=
 =?utf-8?B?amtmakxOMU44NDZrZWJ6d1ptZFZUdWVweG14elVQOE54ZjRtZjhkSFpqKzJz?=
 =?utf-8?B?bWg3TlZzdVpHeFk3ZllqcHpOSElyZTdzY29nNWdjRmV6aXZuZFdOT2dhNGZS?=
 =?utf-8?B?Q0lmV29tS0Y5NkprSE81TTBMYXBCMG05V05INWJhR0hlaWJESXhDdHhHQzhT?=
 =?utf-8?B?TWdRTHM2TFFnYjRyalZYVEgwaGpWWk9KRitubzdjd3VKTGF1emtjN0pYUUxT?=
 =?utf-8?B?alBPMGNIQkkrV0VySHlOU1JDSzQ2NWNBUHltWnhmaGVnSTNlS1RPWUcyUkE5?=
 =?utf-8?B?d2VCdlE1ZFR0bWJ4OGtiQkRlaVdjU1AxUjFKNlg3SlBGYVpseDRCNHpWR0pO?=
 =?utf-8?B?V0VOYytQK1MvVWxHZnMxbnFrVXZjenhoN3QxQUNObTFJQnErWFNBT2R4VUE3?=
 =?utf-8?B?aGlrNHJtNWlZblprbTdHd3hJK3lOVnV6S2IxZVR3d01zNTQ2U0wxMTdROUZx?=
 =?utf-8?B?aHk0SnEyNEdKTHd4dE9MSkZaNzhSOVl5RGV6b1pCWjhDT0dSMGJMeEV3Y1pL?=
 =?utf-8?B?MWNxV3BrWkRRc2Frai96RW1sRGt6Wmtpa0NOL0Vlakp4RzNSc3NzeWc0ZFdD?=
 =?utf-8?B?dWF6S2RTWm1ZSnVsRmllQWtNM2xyMFFjQXAyaGVQck16UjNyZ3UwaEN2MnV3?=
 =?utf-8?B?N2pqWkpHWVJrTHh6YitzNVE1dW5wN3M0cDdVZ2Y3b3Y4c1gwdVZ1Uk9wY1Zw?=
 =?utf-8?B?NS8zVUR5U1ZWekdFZWUwRkNzOFN3Ym1LNkM1ZjlOT2QyaXQ2WFIxSkF6VjVD?=
 =?utf-8?B?NnJ2b0FUeVU2MDN3cnlaVDBlaS90TzJjYnpsR29PSmFHS2pvL1Z4cmdRZWtH?=
 =?utf-8?B?RzJSSEFMRXZpSG41U3dDMWpUWXdSSGtkWFcyUS9qbUN4K0hvNkRGR01NRXlO?=
 =?utf-8?B?d3ZwWm9UZk16TnNaNVlOVVUvVStqNUVMREIzdWpkWHBPRnYyWnFTTEo1bnkx?=
 =?utf-8?B?MUJhdCs4ZGhOUENCY3RoN0JrNG5CdVI0WHVDcFVwalpsakFWR0xWSWhJSVRz?=
 =?utf-8?B?dlBvVUNtNDdLemQ4NzRHbE5rYWlWUjBOOFdjT2JPQWtBRFVSWHlHSDNFeDB1?=
 =?utf-8?B?OXB2eG5SL0xLZVUzaGRqNGg1Y09QS1dyRUU5T1NBMkw4YjhONC9zaEhjdGhn?=
 =?utf-8?B?R291V0c1NDJFeWFoYnhvUXROdi9UdFdVTzI5ZXJOVW5TWmo3Tko0RDZNMHBn?=
 =?utf-8?B?SHB6SEVQWTExbU9hSEEyczJTa214SHdwQlIwQkQxUU02QThIRHkzY1dhOGlY?=
 =?utf-8?B?enpKVjg0L096WXlDV0NKOVJwT1BjT2FvaEQycEFRRE1KUUovRnB5YU0wV01o?=
 =?utf-8?B?UVZVaGM5RGhHZi9qeG43NWFKWEFteTJ2SmZEb3p2UTRPODY5LzJtdVh4M2VO?=
 =?utf-8?B?Q2Zkc0FrQU1QdXBueG8yUGFReEFIckpDS1Rzc0xQZzVIQzd2b1YrV2p6T082?=
 =?utf-8?B?bStWY1lETEgwVnkyRzhQOFFrMjBLUE80cG45QSt1Z2E0ZHhsYnpVaGdXVHZz?=
 =?utf-8?Q?oyMV6OvyTa9a/EY2zpqhkk0rn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dbe309-56ba-43e1-c6fc-08de12cf8acb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:32:53.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7s4Nb0yobJXA+dUdca8fb/N7GgOhlyzkkFV8fjZxGFqT8SK3xo/cESzn+H8rHsTSBmh4IrLUCMw97KWEnP1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
Grounds.

PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
source, 3.3 V, is expected to be available during the system’s
stand-by/suspend state to support wake event processing on the
communications card.

Add vpcie3v3aux regulator to let this 3.3 V power source always on for
PCIe M.2 Key E connector(PCIe0) on i.MX95 19x19 EVK board.

PCIe1 uses one standard PCIe slot connector, but combines the +3.3v and
+3.3Vaux into a same 3.3v power source, and intends to let it always on.
Add vpcie3v3aux regulator to let this 3.3 V power source always on for
PCIe1 on i.MX95 19x19 EVK board too.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 9f968feccef67..65d1a48906993 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -542,6 +542,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 	status = "okay";
 };
 
@@ -557,6 +558,7 @@ &pcie1 {
 	pinctrl-names = "default";
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
+	vpcie3v3aux-supply = <&reg_slot_pwr>;
 	status = "okay";
 };
 
-- 
2.37.1


