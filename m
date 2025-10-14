Return-Path: <linux-kernel+bounces-851806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DED25BD753E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD6274EC6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F830CDA4;
	Tue, 14 Oct 2025 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BESm+cOd"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D0305047
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417700; cv=fail; b=RHzJ0Ok7z2iiwwsd6DgBoHrI+cj3GnSJKPnv02a61Fkg/zfRxvfcqCRZRErq87ceK2pxvnt8Fr4TS3uHdCYph37rbg2on7LF3MNufia2Rd5yfTAiIoTaUoJQTZqegiVpG9EktFEl2k074+Qwk9oO9MdeIExs1E4gvYKsmf3C+ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417700; c=relaxed/simple;
	bh=/c9OdGZKXcwcVWguXXs8XNofY+vlYCTCBIbdEdmhQN8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=C1FJgcelIsKte80H0H84DOruU/+0kYgROGpf/YZ8Fmlx0AgF1bj/vJ/FDCmJysIieEk4Utt3VkG0o2oe6FdJBr8l2NGjwHUfHKM2k1bK+W3Mt1I0KooclCjxaXUItZiV6/xSTxdbatIzNPE/C1VSGYZtY//0UdUCYuysnZZyX94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BESm+cOd; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItX/hCTkWP6UntTzDo9iAar3QD70OJfuAqBnwBbJA/pg+r3Z+QBnS9+KhXCgE28ZUh4YgnbNUQ9uk2w8+EcNLhIBwTEhwnC1yhJJIu3LZtBv/NGVaTKq95x7/JyODyNePSOpdIjAjSrrZbCCu+oew2VFU5L5NCxOvhtmcH19ioH3WO8JISpz2Q6Ja0oH95YiWZSerGYwG9Zqti7exi+VOqVi4c8FPSdIZlG0V6jc0UOyKiuKiaosp0urrlJON5ODhojHPoHXGpMQQfpUYJaUoXsv5GSzrzEGNgGxvxz7WRzh48OFI3clc9FfvnGHyBVrqcEZSwHyCmuoPm34+tCKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJfzR5OBwiYyQMlSKPtLS03aNcuEN0/tXq3+C0AeqcY=;
 b=LWT01DHMNQDk3bT9/8L1BMoASRL4fb6ruO99teEXCX4gGoTycq4Qd1HD9HHZ93sU1ekEFgMjG1qmOdfp5h56w8XNFGAhrFRGGXOwuFBxOrFd3IuyVol7g9L+pyB41CmOPhGtZz8ZAu3mYDNdtABLcrWQTUfuAElIgPSCcoqoBCXNIssrMWDLLhLaDKUE/yC2bHZLRE6W0P7M00dSqsJwdMdGc3I8UjnfctpFwjs/CD+gIuOvlgiM/OAGLFuFUR8/zDlMhhdRrgCq1BMBEzgfi8cogRISyPR3kiM+HNyWx+k+zO5ofoRVWUX2pH0sSZjnagRewOngQNmVaCfYR6MW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJfzR5OBwiYyQMlSKPtLS03aNcuEN0/tXq3+C0AeqcY=;
 b=BESm+cOd4ALOYc6h6XG9b+JHaWiVK2lLXtIfb/uk6YXjzXRvWRlmubhkcpkEN+M2NF9SCkYhsAGnn3f/RhSlpi/fNjPMsURECzeeL7Pg3iTJD3+PsT871cqTJgj6t2qBu1vEW91yrSKtnO9n9PV3LSulLeAX8oPDQ5UqXDB/4BTpM+Zm5GTh9cNXhA7WkeDwKrN9+6pO+3TG73vyHq/I++JhjIOd5bsD9/JaaVNdGQwdLShe7N8bkM3Hps4a6JZVj6oL0AE/zehAOadpLm3PA/gyGjfHOsDKH9XJ4o0/NaMj0H3wsVF6ZF+GwwfK7S0v6ZG76KVa5431ugFQfKdTTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 04:54:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 04:54:55 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/8] firmware: imx: scu: Misc update
Date: Tue, 14 Oct 2025 12:54:37 +0800
Message-Id: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3X7WgC/x3MPQqAMAxA4auUzAbaqINeRRyqpprBH1LQgvTuF
 sdveO+FyCocoTcvKN8S5TwKXGVg3vyxMspSDGSpddYRyp4wiO6PV8amo8l3VFsOBCW5lIOkfze
 MOX/XaspiXgAAAA==
X-Change-ID: 20251012-imx-firmware-492ba9230ef2
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760417688; l=1239;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/c9OdGZKXcwcVWguXXs8XNofY+vlYCTCBIbdEdmhQN8=;
 b=VvOIEFt7uE77YZzyJCRBzALeVdwYbw/hhtWCn5P8PVoh9M0K+TvIK7ElU5w5P0byCDvEAsxbV
 Q27TfWC7NnlBdR1SDe/f7FqUx851KJI1qZFtrEJqfqkAy7jnp3ZfdFK
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
X-MS-Office365-Filtering-Correlation-Id: 6ca91d11-2d71-4e57-22a7-08de0addd18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTZmU1dWZGI1QVdoZEk2LzZXdEpZVUd0bTNpQUZ6ekE1aW5OWXlyNzFSYm1B?=
 =?utf-8?B?d0dybE5HTGNmWVkvNnVTRzQxdGNVMDJQNVR2cjNMNEpaSEJESEJqUVFMNUVX?=
 =?utf-8?B?Zm1zWVhDV3BtZFk3YXJmUDVPTDNXNDFrQXlGQUZVMXVoNi9WRU5USlFVMEF0?=
 =?utf-8?B?TzFFVlFsbnhURXA4M2loRDlPd0FDdXZZN2x3OXRia0xHZFJUbTF2Q1N3YXhO?=
 =?utf-8?B?bytvSDNKak1wSE9KUUVNaHhWTDZaVFEwNDgyNHE2ZGdld3lBak1DTkJRSGxM?=
 =?utf-8?B?UFlmY1RZbUprcWpMODN1YVVWQ3JQTXlnUWNrNVovNmdpWmluQlZLcUFiSDUy?=
 =?utf-8?B?ZUlvWE9IVGUrUWdpck1vVUxOaXVHTnpZZlhpamtkQzUwaGUvcURVbmlVcjMw?=
 =?utf-8?B?aVR6MjV0Q3ZKQ05aQ2N0R0JObm9sVkZaWEthTkQ2ekRhbWwzVTlucWhHT2cv?=
 =?utf-8?B?alZocWRTT3pLRWJTVzVla0VPTVZsaWRNek9qUmd6RStBTUFVVG5aclJXMFlt?=
 =?utf-8?B?ZXQxbGxvK2tmL2hLcDBDTjJiV1VuRzIrbWZhYUpOSUsvVHh6V2grS2xxSi9R?=
 =?utf-8?B?RnRqeXNHUjhuRU5ycEh3aVllQTFtUVU4czNnK1BkWGFuVDBIalBDbjM4L290?=
 =?utf-8?B?bUNxZDZQdGg1RytBUFB6MTlqdEVBQnQ2V2dBVTJyeHV2VE1HRWNhU1l3d2dI?=
 =?utf-8?B?RWluUFZOb2J2KzRDa2p5dk9JOForNXVYRUMrTDVNbmY1NEtxOXNPSUIrRThs?=
 =?utf-8?B?cEJTT2JVQ0w1cm9lZHlGZy9XNGFaMWRsWkZ0QlJUcUFvSnh5MEo0QThWTENT?=
 =?utf-8?B?VnRwVEttQmNvakpnSzJnay9td0VNTFE5WTFrU1dWemFyY3J1ZnJMOFcvQmVo?=
 =?utf-8?B?WWRvYjljbkNINFBJdTE3N0Vja0JocXNHdGtJKzN2eklVUXRPdXZmWjJWbWt1?=
 =?utf-8?B?MzJFeWROU1hPcmlCTG4yOENRdEpJck05MnhGYnVXK2w5SGxJbTZSSWZ3TWIw?=
 =?utf-8?B?M252b1BEUTA1QWp2MHV2UmZQUHNnREVRcXpDY1NMQXB4dDVkZytTaVczUHRU?=
 =?utf-8?B?K0hEMnhJd2dCVFdGWmVwZ2wva01oaTh1WWNvcXFGSTVzRFY2cGhPTm1pSEpm?=
 =?utf-8?B?bWlGby91YWcyYkx1dmtsRFRrTjJRME5Nbll2MU9qYkFnKzFkemtGT25mYmFw?=
 =?utf-8?B?UlFXZnZiNEVIV013UXhxTnMyNy9iNldxb1NwVC96ZlpoL0t2TWg4U3ArR0lv?=
 =?utf-8?B?M1F4Q0Y5dEZqby9sRjJuTFd2V0RZYy9Fb2MvNndFMmZTeEZiMHkrNjgvd2ww?=
 =?utf-8?B?VGVRUnRtZlJjUEVacXRpd1Y0aU0xYjJpeUNSOWdzdEFNTENrNWZLOTR3VnY3?=
 =?utf-8?B?U3JucDdLMGo3d3ZudmR5RXZYQzl0UlJtbStVczJiZ2M5OXdtcFJ0WnB0cnBr?=
 =?utf-8?B?OEhKbXI5Q0srVVFMMnFINEJrdUZCQ1ZIUHdnaDVDUjhYR29remFHVkJIazBk?=
 =?utf-8?B?YzR6Uy9UdjVNRlhLWjNTSmdqV1BscEszS2YzZDFib3U2UmpqRklnMlcyM1F5?=
 =?utf-8?B?UTFHU3prZHFveTVscVpaSWxYRlhFZ0VYVG1hUFk5Vll6amRvelY4RDBYT2pE?=
 =?utf-8?B?QlNZM1EyUktNNHBGcXRxYTlvallqeFYzTHZCaGVQWjUwdDkvSmhxVnNrRHQy?=
 =?utf-8?B?MW54ZjFaLzBCc1JzbXN2aHpVejlhQWVxQUxVOUdXclpqOEh2dHNFVTR3b2dI?=
 =?utf-8?B?Qi9ZdGZuUldPclVwOGN0SW5PKzZ4UlYwbHhuckFkSVVUN0cxYzh5d3hhZDgy?=
 =?utf-8?B?TGJ0c0FYaFdUbXhkUHg3MHNDZ3FzNlc5cWZ4clAyVDdnd2ZBbFlGV1g1cWF1?=
 =?utf-8?B?RTBXT21MZ0pjS3UySWRybW1SaVE3cW5ncjZ3YjJibzdRaG9FN0JGZ3J4eEpR?=
 =?utf-8?B?RThMbXU5UVBkRjA1MGhyL2N3ZFNaRi90alp5V2dDWEMyb1hST3ArQVNQZ1lI?=
 =?utf-8?B?TUErdFVUeTdPN0tWODVpUTVlNzVsMzVsR29iQWNoQUFqRVlESUhNbFlTQktD?=
 =?utf-8?Q?hXtXlu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2UyaWVlM3A0OTVGajVXUWJpMWFCNzdkNTV3VU5vUUdvV294YzlOTUZpNDQw?=
 =?utf-8?B?R045MVNqR3lLcWI2QzBycWQ2STI0b3VIdHEvSFdob0FJdVl2ZFpMNElVdHdz?=
 =?utf-8?B?U3ZHeEROcDh1eVAwellmRC9rUjVpSEt1TEltZEsyME5mWjVBL1RZbTdyZk1P?=
 =?utf-8?B?SXBQQlNiUlNNc3Y5Yyt3bStHK2JaN1hGNEZhVFR5aHlkUmRTSXdKZVNlWEw3?=
 =?utf-8?B?Qmh1STdoRStkK2dldDBkUis4SGdFLzFlZUp0aUNTSUF0eHh6d2hRWGRXZEdV?=
 =?utf-8?B?dk5GdzEvMlcvenVMeG1FWWNwQVMrd3dRcjd0ZHA4TWVpZ2RNNEgzS1dzaVRq?=
 =?utf-8?B?ZlVvOXp4UUFnOStGMml5QmgwZ016Z3d6WnIrQzBXdi90WGsxYU5SZU9uOFZi?=
 =?utf-8?B?L1RXUjV2YVNtVEd3Kzk4bk8vS3VNcGFwSVpodzA1N0xubHNnbU9NNXNONUN6?=
 =?utf-8?B?SU1laXdpNzdkd3FBSUo1RDdlZ21MOGVLY3FhTGhyT0IyZ3kraVlvZzZ2b2Qr?=
 =?utf-8?B?Y09IdWI3M1FHVnpaWWJnZk5UTDFia0I4Ukk5eFFwRVJjVnhSRURneDZBSzJv?=
 =?utf-8?B?KzRDY1dtTmhRcDQ3MjFzcSsxbUlxR2ZxNVBRSFhoQUJFZWlCYmczVjlSTkt6?=
 =?utf-8?B?aFRtYkV0ZlBIa0lkN1Y3L1BLUDExaHdTQldXZWJYYnhDNTFpYkhVQ0ZaWEtl?=
 =?utf-8?B?enQ4eVlCZ0hKODYvdkM3NitoRUp6TGVwczhPNFpGMEFLTDJkckdDcmtISXBr?=
 =?utf-8?B?a3VZUVNjdk1QNEo0UGoxV3lLWlBvYXF3N001RitmRGp3WHl5YjYyazlDUnU3?=
 =?utf-8?B?LzRzRnNaOXFDR3g2T1BkRVFDQi9JM2cxODBWVFRiZVgzRmJvZ01Xdjc4NlBx?=
 =?utf-8?B?WkJnOW96Q2xwTVkxS25HWWs1VUhxalFjOEQzUS9jU1RMQnBVMjNSa2NBU2pC?=
 =?utf-8?B?YWVva3Y1MkVGTEg5Mk5YRHo0ZWhSb0pDdGdwVC9tQXdVVnV3YkdadFdzTlAx?=
 =?utf-8?B?aGRYVWljZVVVY2RZdEcvbS9YY1dZR25IZEprcmtUNFBFZG03Y0xCTGhkOFk3?=
 =?utf-8?B?SVBjeEFwTFJNVHNLdldNaFd2VlZGRWkyRXZaNDJUODB0NmNYWmJicFR4OHZM?=
 =?utf-8?B?R0x6ODlxeGI2dGZzNjYvSVB0V0NiUDB1RmozQkFjN3VzbGgxS2pyc1VLVXFq?=
 =?utf-8?B?S3E3RUNoVU9pY1JkOWVLTnFORlVuTm1VeWo5WENrcStNSldiWlJJVFdwdm5r?=
 =?utf-8?B?VFF6UHl5YjZjS0tkUWQwaGtMUXBLZE9IMWlTTzJmMFpreEFIeUVPaTg1ZGFP?=
 =?utf-8?B?ZTNXK1dXUUlTVUZsVVlvWGlyVGFYOE9hLzdWVjZkMkFsMUM1eU5WV211MWRv?=
 =?utf-8?B?NWtKZWQxUVdkdnVBK0xiSWdqTVNqOGhaOTR6eTNmTXE4Zkw4by9ydlU1NUtl?=
 =?utf-8?B?N3RIa01qRlNtcWFreVlKT1BRUGswenVaY2NLQlZoTmZGM0p6MmNmMWR1L0N3?=
 =?utf-8?B?ajVuc2k5UGZyd3A4ekY0M0JubjlwM1VoZHE2dENMQ1oraHVkb0ZLRHhkQ014?=
 =?utf-8?B?UFFPOTVacmwyUk5zYVQ4RHVUeUo2d2pDV1g3aDlFdHBRcEJYNFBTMXY3emU4?=
 =?utf-8?B?ZEFuQk1xNXc5V1JoZkJSS0Y3WDhrWXhxeFhtNlJBaGdRQy9LbUthUmN2RkFt?=
 =?utf-8?B?ZGFBaVFTVklHSFJQb3FnUHlkNG9PUEY3N21memkrZ2FSYlY2U1g1eEI2aHlp?=
 =?utf-8?B?bEsyaUlYK1ZpVUhRcC9ucVZwWUFxZWpTajV5UjJwU0I3REdYN3NTNzJrVjBj?=
 =?utf-8?B?Q0JUdm1wdmFDb1oyTFIvMVpqckxzeHVSbTlLY012bGV5NG1rRXNtV0lyZ2tp?=
 =?utf-8?B?Lzc4S0dhNEFxMllmL21tcTRnTWVZWG5rSjBRNzg1YzhNZDJPQ1ZoNTNzZ2F6?=
 =?utf-8?B?bDRqUWdWeUFGK3ZXZWduRmQ3MXNMOWl3UDRlbFc2R0djSGJabk92UUtYMUdM?=
 =?utf-8?B?dWRkbHdNUXpDdmxRcUR1SDgvZmFGOWIzUk1kK01LYTd2MUxURUc3enQ0OUpK?=
 =?utf-8?B?RDdOdVNtczBCaEFIclNOb1dtTWs4TGJOWDdFaGhDWmhOcWpPSENZaExWN2lt?=
 =?utf-8?Q?ro33Lu25LqNRyMdjlWCDOzOx/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca91d11-2d71-4e57-22a7-08de0addd18a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 04:54:55.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mab3WZpkjIoXNNiUsqpHSFZ6qc70jOsGvc1VPze3a/gOE47aMFMB9G09aS9Z3pF5iFQ2yV3/5moy+WubRpkinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

various misc update for imx-scu.c and imx-scu-irq.c.
Patch 1 is a bug fix, but not critical.
For other patches, there is no real issue reported, I just reviewed
the code again and see some potential risk, so patch 2-4 is to
avoid potential issues. Other patches are misc patches, regarding
error code update, use devm_x API, suppress bind attr.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (8):
      firmware: imx: scu-irq: fix OF node leak in
      firmware: imx: scu-irq: Free mailbox client on failure
      firmware: imx: scu-irq: Init workqueue before request mbox channel
      firmware: imx: scu-irq: Set mu_resource_id before get handle
      firmware: imx: scu-irq: Remove unused export of imx_scu_enable_general_irq_channel
      firmware: imx: scu: Update error code
      firmware: imx: scu: Suppress bind attrs
      firmware: imx: scu: Use devm_mutex_init

 drivers/firmware/imx/imx-scu-irq.c | 28 +++++++++++++++-------------
 drivers/firmware/imx/imx-scu.c     | 11 +++++++----
 2 files changed, 22 insertions(+), 17 deletions(-)
---
base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae
change-id: 20251012-imx-firmware-492ba9230ef2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


