Return-Path: <linux-kernel+bounces-720195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ACCAFB86D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FB5188E2BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954122A4FC;
	Mon,  7 Jul 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KPcj7JMI";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KPcj7JMI"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020082.outbound.protection.outlook.com [52.101.84.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4642264AD;
	Mon,  7 Jul 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.82
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904752; cv=fail; b=pCB4j6VyR2IMZuUdKEJG/kcdmYdribxGacMouiRmmEoeC145EkXcnbiNFE8ATLSJjxLC7JGkfWcdL01Yg6gvwy3OTFACzOtJJH9E5y5FkC2Ktz8QD3uksKchfbOFDh1UxOs6wY7ZjUeNgy79JVqdhi23BdDh7yqIviLqGjgj9Bw=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904752; c=relaxed/simple;
	bh=oUjhUTa5kPgjDqSsyrKh1E0gsz1+z8AejyVHw2KyERk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gZGsCerZ/x++XTP9SKIaeZvVXrbjOle5dJ7e/ff3Rx4VWZsa027JWqpGBnkF3aYOJWH2NQjKOuj8GNJ4s1P/EF8EUPy/FFiY+3BxMXxW138tWkgLpE1nADvzOvtMLZAaxlpP+rAlk4feXt+JosLSdQoSsdF3sutGzGaxZ9DAqQg=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KPcj7JMI; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KPcj7JMI; arc=fail smtp.client-ip=52.101.84.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Mg5rZxTM5OB3Ns8gdYdofQUD+R7qh6TkBd29WBsZ4Qb8rmQi7E1FX9t2kgo9i1dkloKZCeJJT8EwwvYNOc4pawQCMZHGWe86O8c8GYd/uJMMzzx4DtT/zbWnzKx6qIX+oxlaABlWJuuvUF2UUFAZh38TszW14bpxWF5avvMWREp9cIzmwrnlPttAySFnR6ZNG2n3jBfxHiYQDWliFNty4VlFbEvx4M2FwiObStgTL/0s1QiC6LawWOZAh1j/9Dtj5nV5TPIc5a1M3gBLvsX1IWp1ugBPTN9uj4tIUhXwP1JaZHiZXMGT7n1edKy9roPPm15Y+44ay+Is5OZnme56BA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2k3sBkaGu3B/cF84YO78zo+BOduDJaqmET/YTERird8=;
 b=dXBvWPtRnHrJYs6OBRyBwTnKGC6oejld6QL+1GiTwEKLTUdftpQoT5OLbW1HKkifiAr11Y3YMHv72b+U3uMfwSQOGLHzXEz04p6x49GKv1GY5dzCoFAu9eBczyABHzfas2tF1bZKuqi4OpJDllzTpGHJD+IGjricqzP3gkTphUEvePH5TyDH+b1HPXT6ecAQ/1b14WNkyAqinW1k44x6iAsgDaZjw/3wdRdVxolpwSKBpSTeaS5ewkZIkRDRY09Qu46G0mbpMbB2Cif6b6h5O3L1gdfksj5L1oQ37C3J+kyqy3bUz/EucCSDZ7BlcQIXY43Pwyc/S7K8vuKsLxfjLw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k3sBkaGu3B/cF84YO78zo+BOduDJaqmET/YTERird8=;
 b=KPcj7JMIdNIOmZJi1g9zN7m9CqNb8MtqwWu+/3qQ++Z00xy8R4R2zjikQiBHJFhU69lILlX+1SfnOSHYxBgr+KH68C1b5plVf9PwFfSUo5u36n/QUirXyF2UW1LvAgBXHnJtBA3VQBPZFjHAWo48XLyRaipUJdjUH5BlWA73VB4=
Received: from AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::19)
 by AM9PR04MB7508.eurprd04.prod.outlook.com (2603:10a6:20b:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 16:12:26 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::d5) by AS4PR10CA0019.outlook.office365.com
 (2603:10a6:20b:5d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 16:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 7 Jul 2025 16:12:25 +0000
Received: from emails-6403107-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-22.eu-west-1.compute.internal [10.20.6.22])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id C03C7801D1;
	Mon,  7 Jul 2025 16:12:25 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1751904745; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=2k3sBkaGu3B/cF84YO78zo+BOduDJaqmET/YTERird8=;
 b=CJ59xKItX12eUYnh6QFmxfM3Z5Vi0s74CS3O6EeCwdeAsDaGePkGtsN/em0ui9ANquwQf
 t0c4oqvzjx+Fz8G2xIsfE96iCUVp2805kG/LyFUlHy0ow0e0OL5USwMv24x81El61PUrBWs
 Q3JvjEHYTeTIrSPqQTi2hEEHLB03nSA=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1751904745;
 b=Im7Azy+9HliOEdMwPoFW5taPkNBGbojcrBgRIIOsDsRPRJVA0QaiU6zfurCY2Xj+M8iUt
 SvAI/I8YeOExeWaGLn+VAfJf3aaWiP4hbY2vRNmGwJLhpmFBb8b+2W/43QcfDD7f+RcPxLS
 5jyBs3PNpN4K61qmEKQrymt17hEEnkY=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLrt6wgubFgCbeQ/XGSBfDs00r2Q3tPIEVazBX6OUKpgW4UW4VvwX6DGT2HbwQxMRy5m1TEaH45N40LKpgoRQdEd0FStDbEIEn2fbWODzsZfNXSXqmKaphNZuDsB9COQDfAf6GI6vAjYpt60/Ha3KiXWxS0cZiI9Fr6wdkS7RkmaBFK9xgcKwxVKS74SKc5+4C3xDujgzXNlWbnN6Ue9QuBFmzAkGmNERUZBJpkWcBYMHQPObuAL/62QVH8Pk0H9iKpypuXYE3BXnH5FAO8Q24JyQfefoHy2WHIbu5y/EzoWYNn+PlamUDWvnMu15YLLp/gBDfdyGeS1bNk3AaZ/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2k3sBkaGu3B/cF84YO78zo+BOduDJaqmET/YTERird8=;
 b=gxNnZhqk66NYZXXfGan+qwVdNehpzYTy9UVFAZc9CAsEnRJVP4E1l/AO4Mk8FWs3W5hPZ7hQg1UUMPsiOyUW8NRU+GQyQ9kiIv+hXE/SURmycHktAIjQmxB0vkgf8NWPpeUayDgFhmGt23Hu3K0CvAvwaYL1+300jn9bwGJKXRVAUBAUAUF6dD6tMY2J+vfJ3fdyX5fb4mAtkkIz0x1tQDiTvjOq9sKOBd2gQ6naV3mj6LFSprJuzUkKHfAdwxnz6FLKe8rSdR5IP1nbQuuYUHZLPe+RwMNJd5Pfh5TpctzJcYyNcGs1XvXJnIyD4d8LdHCuagJJFM9ILcAoecmroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k3sBkaGu3B/cF84YO78zo+BOduDJaqmET/YTERird8=;
 b=KPcj7JMIdNIOmZJi1g9zN7m9CqNb8MtqwWu+/3qQ++Z00xy8R4R2zjikQiBHJFhU69lILlX+1SfnOSHYxBgr+KH68C1b5plVf9PwFfSUo5u36n/QUirXyF2UW1LvAgBXHnJtBA3VQBPZFjHAWo48XLyRaipUJdjUH5BlWA73VB4=
Received: from AM6PR04MB4567.eurprd04.prod.outlook.com (2603:10a6:20b:19::11)
 by PR3PR04MB7354.eurprd04.prod.outlook.com (2603:10a6:102:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 16:12:14 +0000
Received: from AM6PR04MB4567.eurprd04.prod.outlook.com
 ([fe80::6d60:a27a:fde:6c1f]) by AM6PR04MB4567.eurprd04.prod.outlook.com
 ([fe80::6d60:a27a:fde:6c1f%4]) with mapi id 15.20.8880.021; Mon, 7 Jul 2025
 16:12:14 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 07 Jul 2025 19:11:58 +0300
Subject: [PATCH v2 3/3] arm64: dts: add description for solidrun imx8mp
 hummingboard variants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-imx8mp-sr-som-v2-3-785814ef09a9@solid-run.com>
References: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
In-Reply-To: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To AM6PR04MB4567.eurprd04.prod.outlook.com (2603:10a6:20b:19::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR04MB4567:EE_|PR3PR04MB7354:EE_|AMS0EPF000001AA:EE_|AM9PR04MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 955fe459-0588-470b-a131-08ddbd71106a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NVZ6by9PWnErRjNWVW5lZDBXK1pLc1hTRWFpZEY3YWx0UXp3b3FxZGRYNDIw?=
 =?utf-8?B?bUVUM1NlNjNYOWRwSHhHT1hGdkQxK1JDc2NMQ3VEZTVtYklGYVNyRGFEb0Fu?=
 =?utf-8?B?a3R2aXJ6Y2JzNnJVZUpBVjhhVWR0ZHZ4YytQMDBGMEFTWUlqU3QyQko2VU5H?=
 =?utf-8?B?T0o2cEQxOW93emVzZ1VhemdtM1VpektKVFhxY3h1V0VoeXR6dDlsd0gzNGtr?=
 =?utf-8?B?bXYvWnZvbC9pQXVLNzdRMTVxUlAxTnVBVk9IQ1RodlhaUDZFL3ZYVDlCTnEx?=
 =?utf-8?B?VzROaytZdVlNVUc4N2twd25Va1ZsL0hQRG03Vk54OXdISUF4QjlkbS9JclVq?=
 =?utf-8?B?MXJuOWVha2FKNk82V2pnRTcrVkhiTzlYNktES2lseUJFL3VYcW5ORVpoaDE0?=
 =?utf-8?B?eEdpUmRHTDJqODlDdGc3NDA3aUJkM0ZVQXFnQVI1enRrdjJJL2NiTS9Wa0lw?=
 =?utf-8?B?OUptTGFVYjdJdHkyczZDUzJ6QUxoRGJEU0tWUFhLdDBoK2Rvb2VmK2Z6VTIv?=
 =?utf-8?B?NVVnNGtBQ2VUSFVDWFpLa2p1VmpwRFdmMkxJNWtwSlVTTDNzZjFjV3o4YVF4?=
 =?utf-8?B?a3UrQkdlYlpxenJ2VWdWOVJqTWRFZzVTNEtaVVBkblJ5cTd2S1RMelI4akd0?=
 =?utf-8?B?V2dxN3p1WWNpa3BodEcxSCttdzVYS1ZkQjNRWGVvV3ZaaUpCc2FrUHcxWFlO?=
 =?utf-8?B?SDU1OFBObUEvKzlEWmlXS0NVZ1d4Sm9DN2txYkpibXhWUUFzRDNRb0hTelJ0?=
 =?utf-8?B?YW9sRCs2LzhSczdzem5YcGozcWdRNHBIRFlWNGNMeTdMbkl2bXdsNTJRb2E2?=
 =?utf-8?B?L0E4WVhMVDFRSVlzdGRzR2dRaVY0Z28wRS90QWxualhNT2dFdDBmMldVMEdx?=
 =?utf-8?B?Z0xBcWQ3Q1ZneXg3M0pXYWcwL0lQZjQ0aHVPSHNRMlhLTkdpQURhck9haE45?=
 =?utf-8?B?UjZmdWZWcWRjeWRMaFRCK2VDcVJWam1lYmFoUzI2QWlYazVYLzU4OXh0OUtR?=
 =?utf-8?B?bzdXVjBBZmhpcFptQzMyVjNKN3dKSElpS1FCeGc4eTBxY1A1Ti9uUkErRXA1?=
 =?utf-8?B?akJlUHlVNTRTbFFGcWh6NWVyNHFoc0lsT09idGlhV1A3M3FZYXBEaDkrNys2?=
 =?utf-8?B?eGJLQStaU08yNTcyZHh4d3ZmaDRnT3pscENXd05UQTJUQzFEem9BK2VGZk1y?=
 =?utf-8?B?VnoxaklWZlBTenFDMldQVHVOYnV1clZkZG5tbmhLT3BhQkROQ0JYYnJXN2Zu?=
 =?utf-8?B?YTFWdTJTYjF3cVRnWGp1em1obkZMdWdYLzVaUlpLdEZ6QkR6TnYwL2tFN091?=
 =?utf-8?B?NmN4MUM1elVPb3JEcWZlUDBCWmMvdDVXdDU3a1MxNHAwTnRoUDZZSlpMbS81?=
 =?utf-8?B?SWxGSmhRbkUrN3hxNFlXcXBiSkI5dmF5eXFMN21qL0c4UDdUTVo5OWNHMy9G?=
 =?utf-8?B?Y3d5czh3WVBRMmNBRUFJYVZLTTgrclVhVE4rVnJIeDMwWDN5bDhBVHJVa2Vm?=
 =?utf-8?B?enBNZEVGb0creDEwSzRwajFnQzFCT0V4TjlCUmZtc29QMGxPSDFlSUxJcW9P?=
 =?utf-8?B?MTNXVlZ1V2pwbW1ONnFTYUFMeTBuM2FQZ09GV3ppSXN3cFBLekJMYm9LVCtX?=
 =?utf-8?B?VWt2M1R5bnRpSkl0ZWY5NldLWndCWnR0WUZuUmtGMzhsOGJVVG9rYTJaSUJX?=
 =?utf-8?B?cElCakJKTzl0VGN1OG5FVFRvOEdBUHhqQnRCb2JBaVhjT28yN1BrU1dsZ1l0?=
 =?utf-8?B?UG9UV0pqdGZKUk9PeGpxWmdSdFFnUWRPaDJBUG9KcWx5a3czQi8zclpVUTc4?=
 =?utf-8?B?bDY2QTJXTkZzY05FU3JLY05SYzY4SXdmVkhLb3JRWlM1eEJWYS96VTB0dUFX?=
 =?utf-8?B?emtIZEV0bUVWdHh6Ykx3bTVxYWM3Y1dGT3k4ZWVJb24rbkFLQ0VYMm9IeHJo?=
 =?utf-8?B?K01ONEhxd3JJVlRGeHlJZ1d1R3Q2NEREdXhsQ2ZQNGt6UGxyWlh2ak92c3Jv?=
 =?utf-8?B?WG5mZjB4Ti9nPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7354
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: cc4fb993940a4d04b93cb1c0fbd5acd7:solidrun,office365_emails,sent,inline:9dc78d7a0aea7e94852b4c8673104263
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9e82f9e6-a062-4214-640b-08ddbd71095d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWNyQ1dhaFY3QjFtcFlSR3R4UGFjS1l0VHNrRnZwdXZONUFGQlRHU1JSQTBh?=
 =?utf-8?B?dTZvWTZIN2Q2VHh5Y3lHMGNhaVFUa3NLUDNoWDhMdC9OOW9YczBmdzVlYXgz?=
 =?utf-8?B?UVhZSTN2MHNKbE1EclJqZ3BMcWRMdFlxVHZJMmdhWXk4NGMvc2N3ZDdvanF5?=
 =?utf-8?B?T29vNjBnNWlMN0d6Qm04VnZJZjdOZHQvbFpCZDM0REN0Q2ZaMURVUnV3VkRM?=
 =?utf-8?B?YitmbEpCOE8zWjVOZm9WeitSTE5mOXZxbUtJWGhTYk8zMTdBM3VBZE53TUZm?=
 =?utf-8?B?Nzdrc3I2MFBQWnRsd2dieCtaSTZoNTFHT0VRNWczbG0yeVpzaFkvQXpkNDNp?=
 =?utf-8?B?VjRtb1FNTEtOemtCUHBJdjlxNEJ4NHRYaFNnVGU2NVVWSzFPRGo2Y0N6bm9o?=
 =?utf-8?B?MDRLWWZGb05NVm9ESUY2MDlVLzhpRGFveXAwM1NOQXoxZ1dJZUgvUXFObEsz?=
 =?utf-8?B?MEY3YWNCbXlWNGlKVzdWYmtZSTEyQzVYTHJRamMwWFlvQUg2UTBLNjJGZGt2?=
 =?utf-8?B?MS9nRHkzZW1MNTVVUnhvWVBQZ0pMK2lFZXM4aXhwbC8xcDhtbG1mZEhDbVY3?=
 =?utf-8?B?TFk2Wm9VcEFQVm9ZdEN3WkFPL1JQcWp5R3d6NFNsRVIxVmF0SU1naWNYd2NF?=
 =?utf-8?B?SkF5d2ljRzNXU1p4YzYwNmZoS2FreW1yOE1rSVZ4dEREZkszU2EvVFcrWTY2?=
 =?utf-8?B?REt0TFpmMk11ZjdEQmgzQXE1SlFyUWVzNTV0UXp4STB1aDc3TUo3S0JMV3Ft?=
 =?utf-8?B?M2kxeVpmUDg5Q29ncHdPellBbjFvQlRkWmtRWmZxT0RObnVGRFpkdTlCUWd1?=
 =?utf-8?B?dzg0YzVyWDNQVW5LeXgxOGxxV2VvTzcydUdpRjlxRDJlc3BsMTBZcEpyNVdj?=
 =?utf-8?B?MXBjME5ERkF0UzNGb05KUjFiWGxQSVhRbGZDSGU2RDFQbWwzamduQlVDSGZI?=
 =?utf-8?B?S0tVVkd5cnJWb3pDUU9YZ21LcGM4SENYRFhzejNDSVVTdmJwYk94SXdBc2FU?=
 =?utf-8?B?OW9rZXZXNHhoSHU4WWxWOFJMbDVGUEVqWCs2WHVTcGQwTkxJdU1oU0lQRFdn?=
 =?utf-8?B?VHUyUlo3Wm5SbHR6bW5tK1RsREVraGx0bHFRUjE5UGl5aGNiVzlxSXkrOXZG?=
 =?utf-8?B?YVhUb3AxV3ZYdjlQRUlGNnhXclFNOFE4ektYKzNTTy83QTJ2WHphYTdOb2lX?=
 =?utf-8?B?eVZhS0VRZXdZMWZMbW5ETlZ6Vzd6ZXljU2N0Wkh6YzVuZ3E1ZGI0SmduV1Nw?=
 =?utf-8?B?Tjg4eVhqU2N2REFUTjdNSk16SjJISWE1UzV4NG9VVzlBTlVwaUtsTE4xREhK?=
 =?utf-8?B?TGZlZUNub245Vmd6Q0F0OXg2TEFoTTF6MndOLzJVKzZZN2hyTEdYMnh0Wm9v?=
 =?utf-8?B?Y3hqTTBHL2pzR0JzN0lXRWl1U09RYjYxREg2cEs4d3JjWE44TVhlcE0yZkM2?=
 =?utf-8?B?VjZ3bEg4Ylk2dXBPMmhhbkdGUG85Tm1Uakh4REdCYXNUVHZGUW9Ha1cxdzdm?=
 =?utf-8?B?UG9kd0pQOUc5SXZXaEdDL0phdEdlSGtaMXRpUzh6Y0NZVU41V0VBdXRJYXRQ?=
 =?utf-8?B?SXVjMkZhQWpTbjRRTi9qNmhvQ3Z5YXRnVW8xY0M3UHY5NFhneFRUeXB0K1ds?=
 =?utf-8?B?WWh0NFM3Q2lLNitITWlDek5Ra0lQTTFZTWljYk0vUlduNEltbXhBZEVMcXo3?=
 =?utf-8?B?WitCMkJVV2l3TkJ3WC82MHpjSU5qSlUwZ09Pb3I0d3VqNmhXZUJ2WXVMU0Vk?=
 =?utf-8?B?Rko5T21UM21hd2I1WVJQeGhmNk8xbUtibi80ZldIdmNQWWR2Z01XVUQ1ZGds?=
 =?utf-8?B?Vit5azBhL3orVm5HUzJHeEpkT3dibjF2NmkyQ1F6NzRGY3FBK2d4dng5QStX?=
 =?utf-8?B?elhQeHRuay9TZVFsM3o4VlN4TGRSdUQvT1hqT0RBaXZzWExUMGR1NGJCMjN4?=
 =?utf-8?B?UGxEQ0Ird3Q2dWI2NTVzQ0oyTHBiQ1JFTVlDSW93TjliMVowajJJSVkyN0V1?=
 =?utf-8?B?RWFJTVhVU2hQL2JPd0xaRFNOWUlFZFJoUHJxY3c1ZXRDNWQwangyQllnczhD?=
 =?utf-8?Q?GkAni1?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:12:25.9961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955fe459-0588-470b-a131-08ddbd71106a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7508

Add descriptions for the SolidRun i.MX8M Plus System on Module based
HummingBoard product-line. They share a common designed based on the
"Pulse" version, defined by various assembly options.

The HummingBoard Pulse features:
- 2x RJ45 Ethernet
- 2x USB-3.0 Type A
- HDMI connector
- mini-HDMI connector
- microSD connector
- mini-PCI-E connector with SIM slot supporting USB-2.0/3.0 interfaces
- M.2 connector with SIM slot supporting USB-2.0/3.0 interfaces
- MIPI-CSI Camera Connector (not described without specific camera)
- 3.5mm Analog Stereo Out / Microphone In Headphone Jack
- RTC with backup battery

The variants Mate and Ripple are reduced versions of Pulse.

The HummingBoard Pro extends Pulse with PCI-E on M.2 connector.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   4 +
 .../dts/freescale/imx8mp-hummingboard-mate.dts     |  31 ++
 .../boot/dts/freescale/imx8mp-hummingboard-pro.dts |  76 ++++
 .../freescale/imx8mp-hummingboard-pulse-codec.dtsi |  59 ++++
 .../imx8mp-hummingboard-pulse-common.dtsi          | 384 +++++++++++++++++++++
 .../freescale/imx8mp-hummingboard-pulse-hdmi.dtsi  |  44 +++
 .../freescale/imx8mp-hummingboard-pulse-m2con.dtsi |  60 ++++
 .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |  81 +++++
 .../dts/freescale/imx8mp-hummingboard-pulse.dts    |  84 +++++
 .../dts/freescale/imx8mp-hummingboard-ripple.dts   |  31 ++
 10 files changed, 854 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index e98c15eb949957a193eb3a7612f3f0f2b04790af..ccc1d6f98495589cb6a55b198d1933bcf076fcb8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -203,6 +203,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-mate.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pro.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pulse.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-ripple.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-bl-osm-s.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts
new file mode 100644
index 0000000000000000000000000000000000000000..00614f5d58ea9de51aad9a5f36212dc3d4f3ecaf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Mate";
+	compatible = "solidrun,imx8mp-hummingboard-mate",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&mikro_rst_pins>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts
new file mode 100644
index 0000000000000000000000000000000000000000..36cd452f1583987a1e826d33798d9aecaaf21568
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-codec.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+#include "imx8mp-hummingboard-pulse-m2con.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Pro";
+	compatible = "solidrun,imx8mp-hummingboard-pro",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &fec;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&hdmi_pins>,
+		    <&m2_wwan_wake_pins>;
+};
+
+&pcie {
+	pinctrl-0 = <&m2_reset_pins>;
+	pinctrl-names = "default";
+	reset-gpio = <&gpio1 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie_phy {
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	status = "okay";
+};
+
+&phy0 {
+	leds {
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		/delete-node/ led@1;
+	};
+};
+
+&phy1 {
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..fd16916676db4ec6f0e66d9c52355c37fe06b971
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	sound-wm8904 {
+		compatible = "fsl,imx-audio-wm8904";
+		model = "audio-wm8904";
+		audio-cpu = <&sai3>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"AMIC", "MICBIAS",
+			"IN2R", "AMIC";
+	};
+};
+
+&i2c2 {
+	codec: codec@1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
+		clock-names = "mclk";
+		AVDD-supply = <&v_1_8>;
+		CPVDD-supply = <&v_1_8>;
+		DBVDD-supply = <&v_3_3>;
+		DCVDD-supply = <&v_1_8>;
+		MICVDD-supply = <&v_3_3>;
+	};
+};
+
+&iomuxc {
+	sai3_pins: pinctrl-sai3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
+			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
+		>;
+	};
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sai3_pins>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_IPG>, <&clk IMX8MP_CLK_DUMMY>,
+		 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>, <&clk IMX8MP_CLK_DUMMY>,
+		 <&clk IMX8MP_CLK_DUMMY>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..3a43cf3e2ca00741fe15cd834df0ac7c9119ad09
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		rtc0 = &carrier_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		led-0 {
+			label = "D30";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-1 {
+			label = "D31";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-2 {
+			label = "D32";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-3 {
+			label = "D33";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-4 {
+			label = "D34";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+	};
+
+	rfkill-mpcie-wifi {
+		/*
+		 * The mpcie connector only has USB,
+		 * therefore this rfkill is for cellular radios only.
+		 */
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mpcie_rfkill_pins>;
+		label = "mpcie radio";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	vmmc: regulator-mmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc_pins>;
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <250>;
+	};
+
+	vbus1: regulator-vbus-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus1";
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus1_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vbus2: regulator-vbus-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus2";
+		gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus2_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	v_1_2: regulator-1-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	vmpcie {
+		/* supplies mpcie and m2 connectors */
+		compatible = "regulator-fixed";
+		regulator-name = "vmpcie";
+		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmpcie_pins>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+/* mikrobus spi */
+&ecspi2 {
+	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_spi_pins>;
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-0 = <&mpcie_reset_pins>;
+	pinctrl-names = "default";
+
+	mpcie-reset-hog {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "mpcie-reset";
+	};
+};
+
+&i2c3 {
+	carrier_rtc: rtc@69 {
+		compatible = "abracon,ab1805";
+		reg = <0x69>;
+		abracon,tc-diode = "schottky";
+		abracon,tc-resistor = <3>;
+	};
+
+	carrier_eeprom: eeprom@57{
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+&iomuxc {
+	csi_pins: pinctrl-csi-grp {
+		fsl,pins = <
+			/* Pin 24: STROBE */
+			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07		0x0
+		>;
+	};
+
+	mikro_int_pins: pinctrl-mikro-int-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x0
+		>;
+	};
+
+	mikro_pwm_pins: pinctrl-mikro-pwm-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_MISO__GPIO5_IO08		0x0
+		>;
+	};
+
+	mikro_rst_pins: pinctrl-mikro-rst-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXD__GPIO4_IO30		0x0
+		>;
+	};
+
+	mikro_spi_pins: pinctrl-mikro-spi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SS0__ECSPI2_SS0		0x40000
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82
+		>;
+	};
+
+	mikro_uart_pins: pinctrl-mikro-uart-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
+			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
+		>;
+	};
+
+	led_pins: pinctrl-led-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22		0x0
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21		0x0
+			MX8MP_IOMUXC_SAI2_RXD0__GPIO4_IO23		0x0
+			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24		0x0
+			MX8MP_IOMUXC_UART4_RXD__GPIO5_IO28		0x0
+		>;
+	};
+
+	mpcie_reset_pins: pinctrl-mpcie-reset-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01		0x0
+		>;
+	};
+
+	mpcie_rfkill_pins: pinctrl-pcie-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x20
+		>;
+	};
+
+	usb_hub_pins: pinctrl-usb-hub-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x0
+		>;
+	};
+
+	usdhc2_pins: pinctrl-usdhc2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_100mhz_pins: pinctrl-usdhc2-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_200mhz_pins: pinctrl-usdhc2-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	vbus1_pins: pinctrl-vbus-1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14		0x20
+		>;
+	};
+
+	vbus2_pins: pinctrl-vbus-2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x20
+		>;
+	};
+
+	vmmc_pins: pinctrl-vmmc-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x41
+		>;
+	};
+
+	vmpcie_pins: pinctrl-vmpcie-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x0
+		>;
+	};
+};
+
+&phy0 {
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		/* ADIN1300 LINK_ST pin */
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+/* mikrobus uart */
+&uart3 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
+	vbus-supply = <&vbus2>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	vbus-supply = <&vbus1>;
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_hub_pins>;
+
+	hub_2_0: hub@1 {
+		compatible = "usb4b4,6502", "usb4b4,6506";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&v_1_2>;
+		vdd2-supply = <&v_3_3>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb4b4,6500", "usb4b4,6504";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&v_1_2>;
+		vdd2-supply = <&v_3_3>;
+	};
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&usdhc2_pins>;
+	pinctrl-1 = <&usdhc2_100mhz_pins>;
+	pinctrl-2 = <&usdhc2_200mhz_pins>;
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+	cap-power-off-card;
+	full-pwr-cycle;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..d7a999c0d7e06a8c47a61632a59eb97faea9e3d4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		model = "audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+	};
+};
+
+&aud2htx {
+	status = "okay";
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&iomuxc {
+	hdmi_pins: pinctrl-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
+		>;
+	};
+};
+
+&lcdif3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..b879ca4ed21428b8d4c6866f9a827bcfbef1caee
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_gnss_rfkill_pins>;
+		label = "m.2 GNSS";
+		radio-type = "gps";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* M.2 is B-keyed, so w-disable is for WWAN */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_wwan_rfkill_pins>;
+		label = "m.2 WWAN";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&iomuxc {
+	m2_gnss_rfkill_pins: pinctrl-m2-gnss-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x20
+		>;
+	};
+
+	m2_wwan_rfkill_pins: pinctrl-m2-wwan-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x20
+		>;
+	};
+
+	m2_wwan_wake_pins: pinctrl-m2-wwan-wake-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x20
+		>;
+	};
+
+	m2_reset_pins: pinctrl-m2-reset-grp {
+		fsl,pins = <
+			/*
+			 * 3.3V domain on SoC, set open-drain to ensure
+			 * 1.8V logic on connector
+			 */
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x20
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..46916ddc053355b6708629898fa13e55c6493cc2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "c";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	hdmi@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3f>, <0x3c>, <0x38>;
+		reg-names = "main", "edid", "cec", "packet";
+		adi,dsi-lanes = <4>;
+		avdd-supply = <&v_1_8>;
+		dvdd-supply = <&v_1_8>;
+		pvdd-supply = <&v_1_8>;
+		a2vdd-supply = <&v_1_8>;
+		v3p3-supply = <&v_3_3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mini_hdmi_pins>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7535_from_dsim: endpoint {
+					remote-endpoint = <&dsim_to_adv7535>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&iomuxc {
+	mini_hdmi_pins: pinctrl-mini-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27		0x0
+		>;
+	};
+};
+
+&lcdif1 {
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,esc-clock-frequency = <10000000>;
+	status = "okay";
+
+	port@1 {
+		dsim_to_adv7535: endpoint {
+			remote-endpoint = <&adv7535_from_dsim>;
+			attach-bridge;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts
new file mode 100644
index 0000000000000000000000000000000000000000..e0d6f281837f106bb0b4661d8fe54eaa2cafc3c2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-codec.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+#include "imx8mp-hummingboard-pulse-m2con.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Pulse";
+	compatible = "solidrun,imx8mp-hummingboard-pulse",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &pcie_eth;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&gpio1 {
+	pinctrl-0 = <&mpcie_reset_pins>, <&m2_reset_pins>;
+	pinctrl-names = "default";
+
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-reset";
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&hdmi_pins>,
+		    <&m2_wwan_wake_pins>;
+
+	pcie_eth_pins: pinctrl-pcie-eth-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x0
+		>;
+	};
+};
+
+&pcie {
+	pinctrl-0 = <&pcie_eth_pins>;
+	pinctrl-names = "default";
+	reset-gpio = <&gpio4 28 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	root@0,0 {
+		compatible = "pci16c3,abcd";
+		reg = <0x00000000 0 0 0 0>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		/* Intel i210 */
+		pcie_eth: ethernet@1,0 {
+			compatible = "pci8086,157b";
+			reg = <0x00010000 0 0 0 0>;
+		};
+	};
+};
+
+&pcie_phy {
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts
new file mode 100644
index 0000000000000000000000000000000000000000..4ce5b799b6abc514ca00e2e2134d5ff1606dc87d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Ripple";
+	compatible = "solidrun,imx8mp-hummingboard-ripple",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&mikro_rst_pins>;
+};

-- 
2.43.0


