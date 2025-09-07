Return-Path: <linux-kernel+bounces-804800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F50EB47DFD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82EB3C1178
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39AB20E005;
	Sun,  7 Sep 2025 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VkVlqf/j";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VkVlqf/j"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023114.outbound.protection.outlook.com [52.101.83.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EF14BFA2;
	Sun,  7 Sep 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.114
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276338; cv=fail; b=CxKa/r9P0XZUoyLfF+GXCTheP9I41zwb536GxqHODWSEmAqXl5r2AloEz2mnOA5HrELaCKMmU3rOHwjnwoCfc59aGMgXuow9zB8DAsnrNtcl5pGLf2eMS2QTCQzTW7o9BGlwLhVhDjOPIUPE7wVd+VM/+jShXkOTvzYbqTWYv+Q=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276338; c=relaxed/simple;
	bh=wOfb5j//xTtHmRi/IUYFENg7P9WGYpgsyLWSgsd3RX8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=HUGDCbW9ksbLK9talJhmIJtmNTeltAuY4YHyeF8J/lUmwpduZ8+J3MSXHZKmPGhnWW9L8dMAuVMK+xlFYPNlc4uLx39kx81TrKhfLRnIxucU1lr7NtBwMK6pz7qo03+eEraiPlA+w/yBmmyM2iOVa4R3Jrnd7C7tibnG2LeQNhs=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VkVlqf/j; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VkVlqf/j; arc=fail smtp.client-ip=52.101.83.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KQsENs1gLubVlqATaAdR33siA/Da0h2lxWQWeqx88ELZe3GHrf3r0pIw5zcSBBRMIhMBbVkZiv0ap1lx570ENP9PVUocQLjegpekxJz2NZR8DNDP03YZBh+gVd7VmJ3AbbLOFbJ3Jq++jzHY9oKRBSODrbbwGIUBJXM0nxkvuzQCjSs5dgM5mXBZ6lviTNu5cLCchoiwx1uHDVVfeEhJNS/aOsWfoFCaKMHx2RnNVPUyWc6P7Rxpq+V6t7F6LXXPSr9r29tXEWiQbvU2jceNqnrS1SAtQ1f60nH5T3+BT0IDQK1pcZyjPBWVE61hG81pqtRpzCqeVDNCzUUG2MYYSg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AMM7//ofltDsL/kOThboBwUcibOjfKrJdy8du1wc2s=;
 b=Q/mlo6gKGQ8sbb1oH5ols6XfuNrMsdwvnkVgZ+56s7yEpYTMAYeGF4FSVTqwQQMjqXngV4Hv7VuQPQXnFbpXoVipZNIeFBh54pJj2tyUFke+ylRGozNceguWsyZuw8T04w9k1BrSYkpwgXUZ73bE9pqGQddt7pAZoKmDSP1GBqO70Uvv0ZUi+3NGBaXh7yKkGG/iJ0wngzNMF89d7KatelE6tE66sjoAsA2NH6A/jhCu4EBceuCmIH55tRUN/wkJpRfbzTRz7JTlM9Iz0JsvqwaIVTIDAonQ8GuZy4gIzLIObx43BR5YGNZ4AvdDMzLQd4bZI2XDq85jBvDtdoc+XA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AMM7//ofltDsL/kOThboBwUcibOjfKrJdy8du1wc2s=;
 b=VkVlqf/jQBNY2QKq/Kvrc/SSn8HsHiegjLDk1P4go2hEOgVKJCSiSSCHLEu61emnR/JD4wha9HvWIh4jl45sJRAx+nN+LxvTM2EekbeUM5fqhUICYa6Rw3RvoyGT09v7gbT/IS4Kea4k6EIEh485cm0oaGNptlIEgcff3wDVhlI=
Received: from AM6P193CA0073.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::14)
 by DUZPR04MB10016.eurprd04.prod.outlook.com (2603:10a6:10:4dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Sun, 7 Sep
 2025 20:18:51 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:209:88:cafe::bf) by AM6P193CA0073.outlook.office365.com
 (2603:10a6:209:88::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sun,
 7 Sep 2025 20:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Sun, 7 Sep 2025 20:18:51 +0000
Received: from emails-6817701-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-73.eu-west-1.compute.internal [10.20.6.73])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 331187FEF4;
	Sun,  7 Sep 2025 20:18:51 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757276331; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=6AMM7//ofltDsL/kOThboBwUcibOjfKrJdy8du1wc2s=;
 b=JgEl1UeudzAfL5f2/4Pe7BrNVyDcxmMxyXAHkd3nFC/sTNiw+B/HoJoSDaBQWyv3ifaCQ
 9tRmIrS+m2VpTbWpXalVjp8ybNKPrakSvs1Gu+axLtNAEE1vzhIAhshzQDIyD4f2g0kDujb
 GO5yPW56NIN1PHADwN/s2LRvzqqt4y8=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757276331;
 b=hthgYFfANkbxQ6eGg7FhghwSyxC0tdCxYDSdhiSb1vYAcEL9BqlpgrqB/BrzTl2QQqE8x
 IDWS5a4loS6NhHWF7VyPtz/KyusbmKT9qNtZRH7lamXS0owXJqjotcQ/8UgVJojCHyDQuBg
 TlvMgcbufIFJh82M0INS9MYR0X7xNGE=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSLbVwZKNQCBd4eanO2jJmnh2AaPlZvd4DCUOn8mXxR4qCLpH6d7OpD5/J2qwcDJmWQoD6vfaP4yul1KaU1VApTjs+BPQMwN0irDHhLxX/kSY83KdvLoiWEpjdvwvUa86fDVBtWSdFnw5QUQMnc9CfusUISXzJM/U8NnDI3BaCYfrWRYiNAU3hsmmioJrRJarvhMjSbsEctX0+5DFC0IZumR10OrgwVJF2NCAjHRf7FK+OR7kx6wSGI+e+KNyqn9Gf4qvxkg0dcaNIR9nxE1MMWFyUX5TcmEYl2SDFfcViAsBhrxOSrKEthmBgl8ICmtBB0rUcyB9+zeRF5PaSY2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AMM7//ofltDsL/kOThboBwUcibOjfKrJdy8du1wc2s=;
 b=nQnozE0MXl5SVsYjFOVqYfoIhmrHIWaEee5Wqh1U/hSh+SKaQtkKfEk9u3cuov3eiG40BOyQ3Flf1+Tw0PSq1WQxggqfR43NSARPIu1HyH0ALoCznp890LBsR9WINcZTc8zuk9hG+g+LCSmN4Jg00Ffuf3srmT2WjMYksfiiGS+TTISaeGgzdaReeULqQq2D4G/MwQDCgOIyV3c84s4Lz3vYx24c3JVBH2IaUsQ71zVwY9c2KZgUBn1CvLqeQUD72dUJFzOkYJ1Hwah+fssp84Xv1zla2+7iGWLYBeuCmzBEGEacyNZegUcZgbHbFKx9R94ftRbiPY5ha8nC3Ukc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AMM7//ofltDsL/kOThboBwUcibOjfKrJdy8du1wc2s=;
 b=VkVlqf/jQBNY2QKq/Kvrc/SSn8HsHiegjLDk1P4go2hEOgVKJCSiSSCHLEu61emnR/JD4wha9HvWIh4jl45sJRAx+nN+LxvTM2EekbeUM5fqhUICYa6Rw3RvoyGT09v7gbT/IS4Kea4k6EIEh485cm0oaGNptlIEgcff3wDVhlI=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DU2PR04MB9177.eurprd04.prod.outlook.com (2603:10a6:10:2f4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Sun, 7 Sep
 2025 20:18:41 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.010; Sun, 7 Sep 2025
 20:18:41 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 07 Sep 2025 22:18:36 +0200
Subject: [PATCH RFC v3] arm64: dts: lx2160a: extend 32-bit, and add 16 &
 64-bit pci regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-lx2160-pci-v3-1-bb66cc41b8f9@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAJvovWgC/12Nyw7CIBREf6VhLab3QqF1ZWLiB7g1LqRQS1JLA
 0pqmv67hI2P5czknFlIMN6aQHbFQryJNlg3psA2BWn763gz1OqUCZbIS4CaDjOCKOnUWsqVVtA
 IU9UdIwmYvOnsnGVncjoeyCWVvQ0P51/5IEKesoshfLsiUKBMSCbLupNGiX1wg9XUP8dt6+5ZF
 fGDc2x+cEw4qIZXUmiBgv3j67q+AVBepWbsAAAA
X-Change-ID: 20240118-lx2160-pci-4bdb196e58f3
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR4P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::14) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|DU2PR04MB9177:EE_|AMS0EPF000001A8:EE_|DUZPR04MB10016:EE_
X-MS-Office365-Filtering-Correlation-Id: f80f2287-d720-4d87-77c1-08ddee4bc2dc
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ekFYNDJCeTBkWjQ2Ykg3WFViWHY4c2I1Y3B1UUw1OUplUDIvSFNYWUltRGlJ?=
 =?utf-8?B?T1FzRzF2dE1Ma21WTldXaDdKREUzTGFUSkRtd0lDYXB0aTZFaUNza2FEWnRO?=
 =?utf-8?B?TDluZ2kxdmN3VmJuNUkydXRrRFd0cXBDMGN6QkJiRW1lNjdNM25ScExIZi8v?=
 =?utf-8?B?TWNjOHZLQ3dxR2txUjZuMDV6VndkeDNLT1dCdGFQVktlVVVvZkUvTlZycGdx?=
 =?utf-8?B?d0RFbUNtR1lQeU8zTURVbzZXYVRtS1A5L1p3VUprOG5kRE01YlNNOFFhRVV4?=
 =?utf-8?B?SFk4cGo0VFR5MGNxRnE1V0RvSHVncWJPdU5NZWVsQmh3UnhLOHVRaGNsbm5L?=
 =?utf-8?B?VHRvcUtzanhiUTRjT0M3MkJGRGFhQUExbFMwaGN3TjRwSUR1aWUxRC8zcjFQ?=
 =?utf-8?B?YXd6dXdML2NORnZ4aURGRkxJRDJhdnBINEw2dzRlckMxcm1RWVhQd21zbnBS?=
 =?utf-8?B?Njl1QTJQdElaRDJDTXUvOHA1QUF5V2gvaGVML2JkVlpETC9nZXB6Y3BZV2lG?=
 =?utf-8?B?N1d0dHZ2Q05MU1REdU5qT3VXbDh4ZUQ2azNKN1NKOFRFZWxVenJqTDNXbFZJ?=
 =?utf-8?B?WWxWWXZqWENMUnZqaXlxaU56TUdadjQ0STJlUldLVVJCODgxRm0vSjNEZkxn?=
 =?utf-8?B?UWdHS2RVSWJDdncrYVVjTnlFR2RSOEpKdDVqK3VQNmRNcVlXOVlyOXBmdHkv?=
 =?utf-8?B?SFBGRUZqbVRUZGNWaUd5NXhYbFlQZDR2NVJwbGdUMUFPN1lDVUJtYVpwMlcz?=
 =?utf-8?B?Z0RvUnl6L1hobDdOazBIWUx2ZmhkRjcwRm9qOFhqajVyelU0TFZ1TkIvb0pD?=
 =?utf-8?B?ZVdXdFVjSzhIc0EvT3Zydm1XSnVYSi9UT293ak9zdzNhd3VmTzJuSGZ6UkdI?=
 =?utf-8?B?T0JoY21XU2c1OXh4YzBrRloxN0pwZHFGNG90T29xTWt4dFlHSC9icit4K0pm?=
 =?utf-8?B?R01ucis0TjY4bFhOWThkMlV6M0I2VW0ySWd5YitFdUNXZHJVMVBBL1RBOHFj?=
 =?utf-8?B?WHJ4RG44c29PNkFHclRFM2VwTnc1c3hKcUxVVGh5RUFuMUpkVTRwdDk3Nlgr?=
 =?utf-8?B?K29SUDB0TEs1YndmeHdxWHcySURrakVxcGtQc2x6U1ZHM0c1bm91MnA5WVl1?=
 =?utf-8?B?VWMwQ0VjNFBVaGJuaVB0aFMxZ1oxRFpPczU5a2NxVDM1MjJIbFoyaXgzV1BP?=
 =?utf-8?B?cjRETnk1bWZ6SFZoSFNXbUpUKzBYQ1dhS0swcERKc3lQK1FFZ1ZsUXhUeURK?=
 =?utf-8?B?bE5hWnZqYnI5My9RSHFDakZZUThoSzd6SVRabGZhRGI5Z1RmUlNHNUE0ekx2?=
 =?utf-8?B?U1VmdVBaWkJPQ2dSaEF1UkplWm82ejMxRERhTDBORTZYYnpjd2JqTEd3QTJO?=
 =?utf-8?B?aEpXZHpEL0xLMVZXRjNpVTUxVEh1cHVDbEdXaFBJcTBmbkRYbU5DRFRhVm9v?=
 =?utf-8?B?NTFjd3JDMzluYzhnUlhONjVTZmViVEFwZjQ1c3ZxT0RhNWpSaVBpQnZ0TjNC?=
 =?utf-8?B?aW8vWkZIRVVpZFU3c3V1R0x3MVJrckdKVjNOZFJ2V0ptK1o0SCsxN1J3SWNB?=
 =?utf-8?B?NmY2M3k3QXY3L0dnaGtQRStsakd3NTNKWVV2TTcrRWJYTksrcytQTGdJVjZ2?=
 =?utf-8?B?a1J5UFY2TXIzQUFuS3BaeDhaS0VvMnZCTXpXNzVaYWVJY3ErS0JVNnhuOWtT?=
 =?utf-8?B?UFk0MlR0aGF1cnNWTUxhaFFKbjhDN0UyMGxSOGVraGhRbWorSHhEOEFqcXhx?=
 =?utf-8?B?eG1uZVI1SmlVTkdUcEFQZGkwcUZGTnBuS3drYjFMOWpHVUxVeXJnWGRSbFdt?=
 =?utf-8?B?VlgyUnRTb1lubGNwUW1LSExmTnpJUWVSdlBHb2pKR2hmSDBzZTVLak5jWi9I?=
 =?utf-8?B?QnpZTzZzVE9lRzJvOHl6MUhCSkdwV28zaTIzdFNVWkRzNHN4WFhDRUxyREw5?=
 =?utf-8?B?ZG1GMUtHd0ppSE5RaW1JNXVoSGRlaHlYVkR6RDA3RklmSTJyc0xsRWs1NSt3?=
 =?utf-8?Q?QGogt44fcSekNZ2JXOp5DdMtZokHVk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9177
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: e481261532554d8d8372fcc596f6f72e:solidrun,office365_emails,sent,inline:96641ec33b17644658fbd99a24c032c9
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	34c2a1ae-2746-42eb-f021-08ddee4bbc82
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|14060799003|35042699022|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVhGYzRCTituZ0toaUhweDk1N1F1azRPMGZnOFJXdFBaekVxY3Nram9FQWJF?=
 =?utf-8?B?Nk5US3BzclhFcXZ3TGxXU2hkTUFVNGh1Qis1QnlMNmRNSnRJbFVGUmoycGNp?=
 =?utf-8?B?KzBrSCtZakg3K2RZaUdkSUZLbjk4cWNNODNwaWEyZTVzWVdBeVNtanN5b0tx?=
 =?utf-8?B?cTJoNWNPSlV6b00ycStHQ3NzTjRDQW00RGM1SUpaMkJjaE9NcGt5NlhFOGd4?=
 =?utf-8?B?cm52M29CTWwyVzV4WExVaDhRNm9YSjNMZzlRa1B6ZDluOSt0RThCTDgxaTNE?=
 =?utf-8?B?dlp2OEJCYlJwek5acFc1azZLanBtcVN6b1hMSlpTTzBMYzRMRExpUUNXM2RC?=
 =?utf-8?B?SnFvQ2hMcG12aXFobzBFM3RsV2cxMEhNNVNFaTV1VXBWOU1nK3pvaGxXN2dI?=
 =?utf-8?B?d0FqdnluTUNFZEtmNnUrelpoeFFjRkhXRzgzbG44eFVxNnBUMTlHR2lCQlpS?=
 =?utf-8?B?Y3c0MGg3V3BoVGxHMWNrSVhJMm5lVFQzNlVwRjZCcTVlN3J4NXJERnRpaUtJ?=
 =?utf-8?B?M2tDN0xSaENsWHlMdVR1ZkxteThaanUvNEV4SHFvcjI5YVFsNXgzaGhsR0cy?=
 =?utf-8?B?Y2RmaGpRbWRpYnN6NGVPbjFBOXJXdjhmdFVWMGFvdTBHYjA0NWZwSUNCYUR5?=
 =?utf-8?B?eFBSaGdhTDFTdVdMVWtSWmxjYTU5ZDlGc0Q2c2V3TlRPRFY3TVovMU9yZitH?=
 =?utf-8?B?d2R2K0V6SzBTSXo4bERrRlZkZlg3ZE5OajdURG9wUnBoVVd6ODFLb3g5djli?=
 =?utf-8?B?WEptT3VWam5CUkJIOGZ6Z3lQREd5MzIySW1DZE5kNHZGWExyRkQ4NnZ1SFZC?=
 =?utf-8?B?MStCa0puMWdYKzZxM3ljRGxHbmVJVUJyL2krQU5jdGpxNlpsdHJjZ296dmp2?=
 =?utf-8?B?MHE2aUpjMlc2RExSem5uY1dMTndIcjFmLzhuRzRSL3FFeDA5NEFURVVqUEN3?=
 =?utf-8?B?M0RDcTdlQ3A1NGdnNUtFckVLQ1J0VG13Z01IZDc2NXd0Qjdody9aYVU4bnE1?=
 =?utf-8?B?bGdXUlc2S1o2Y01idTd1WnhjRTFDOThpTjJwaUlzRUI0emdrMVI0eElBckJp?=
 =?utf-8?B?cVRaQTQrNm9xWldNSCtkajEzWEdtMmg4MzBFYWYvOEY2YXBnNDBVWHZwREpN?=
 =?utf-8?B?OFVDQ1JLa3pmMWNtUWtBZ3IrOTM2SFpNa3RlU2Z1K1NwMmE5b2FxcDdMVG9k?=
 =?utf-8?B?Ri95S0c0Q2UxMjNtNU5NZmUyMHc4aFVhV01vNU01c3JmZFJQYnhGTGpITXVW?=
 =?utf-8?B?TVpOMFZmNUlNbEIrRE1DTTA4UUMxOFZPNkJUTUhVTHlpUnZTTFYvakxDdW81?=
 =?utf-8?B?R1VSMzRqN2NMa3pqNkNJL3d1WmVOQUlONG5TWUVLdFN1Szdjb1l4OElaN0JS?=
 =?utf-8?B?ekFZSVgxQWJnejJLTXBMRmR6TjB2N0lKWjQ2QXR3dUtsTUo1TEN3NTdqaWho?=
 =?utf-8?B?ek91K1BsV0llRzNDZndScDRSSGZWekZSTVhtWWVIMnkyQWN2Q2JIOFE1SHc4?=
 =?utf-8?B?VjZmUkRvUktFOFpreVdSRWxXek92THA0akQyY0JPejlqbHVjcVBWT09VYmNM?=
 =?utf-8?B?UGdXTmRYNkpCRnphdzVKeGhMTGtKeGtxeVFPbHFxS2tXVVNrd3J1M2IwQzEv?=
 =?utf-8?B?emtHOThmYnJOV1h6MnFZeGdSekREbjRTUk05VlM4MkhuN21wOCtvdEJqKzMy?=
 =?utf-8?B?a2pNKzZHWjVUT01BMjRVMlRGQjJlRTNMcmRNdXlWL1hnM1ZrdEhubXR2Vk1E?=
 =?utf-8?B?YjN2MHN3UlZ5aUEyUENCOVFYNXFDc3g1THdCbStrWFIxUk9iS3VXMkdLb1dq?=
 =?utf-8?B?N2VNUDRSN0doRTMzUlR2TER1QmcrZDFQTGFqMk9haW9DN01zUVp0WWlOYjZa?=
 =?utf-8?B?S084TEZ3ZXkvYkhwM2JqVEJma1o5UHVwSkxhR01CR0djQU5GZWJTeDJ6NzRp?=
 =?utf-8?B?ZndGWi84TThvaDVjQ0RGdS9TVjhiYjB6VTFUcUwwM1l3Z0lMVTZtWkxqUWs2?=
 =?utf-8?B?MWVSVU1MQkUwTXJ0TXRkUUZ1ZDdEMFc2cGJsa1ZMVWdDU2ZKanpBSTFqNFVH?=
 =?utf-8?Q?N8UV1K?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(14060799003)(35042699022)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 20:18:51.4756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80f2287-d720-4d87-77c1-08ddee4bc2dc
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10016

LX2160 SoC pci-e controller supports 64-bit memory regions up to 16GB,
32-bit regions up to 3GB and 16-bit regions up to 64k.

For each pci-e controller:
- extend the existing 32-bit regions to 3GB size
- add 16-bit region
- add 64-bit region
See [1] amd [2] for boot messages showing ranges before and after.

The 64-bit area flags are very particular:
- IORESOURCE_AUTO: ensures of_bus_pci_get_flags sets prefetch flag
  (avoids "Memory resource size exceeds max for 32 bits" error during
   boot, generated by pci_parse_request_of_pci_ranges)
- IORESOURCE_SYSRAM_DRIVER_MANAGED: ensures IORESOURCE_MEM flag is not
  cleared, as required bydevm_of_pci_get_host_bridge_resources to print
  correct resource type during boot:
  MEM 0xa700000000..0xa7ffffffff -> 0xa700000000 (with this flag)
  err 0xa700000000..0xa7ffffffff -> 0xa700000000 (without)
- IORESOURCE_MEM_64: pci address space is 64-bit
- IORESOURCE_PREFETCH: is prefetchable
- IORESOURCE_MEM: is memory (set implicitly when omitted in dts)

IORESOURCE_BUSY is dropped since it has no effect when specified in dts.

The 16GB 64-bit area is split into 4 pieces because the layerscape pcie
driver fails to program atu for larger ranges [3].

The range for 16-bit io window was defined by Jon Nettleton, and
includes flag IORESOURCE_EXT_TYPE_BITS to support multiport io cards.

Similar memory allocation with similar flags was tested with UEFI and ACPI
on pcie3 and pcie5.

This specific set of ranges was tested with nxp bsp versions lsdk-21.08,
ls-5.15.71-2.2.0, ls-6.6.52-2.2.0 - and Debian 13 (v6.12.41),
using u-boot:
- pcie5 with a Radeon Pro WX2100 with Gnome Desktop
- pcie3 with an ADATA NVME

This fixes allocation of large, and 64-bit BARs as requested by many pci
cards - especially graphics processors or AI accelerators, e.g.:

[    2.941187] pci 0000:01:00.0: BAR 0: no space for [mem size 0x200000000 64bit pref]
[    2.948834] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x200000000 64bit pref]

[1] example of new allocations (pcie5):
[    1.716942] layerscape-pcie 3800000.pcie: host bridge /soc/pcie@3800000 ranges:
[    1.724261] layerscape-pcie 3800000.pcie:      MEM 0xa700000000..0xa7ffffffff -> 0xa700000000
[    1.732795] layerscape-pcie 3800000.pcie:      MEM 0xa600000000..0xa6ffffffff -> 0xa600000000
[    1.741325] layerscape-pcie 3800000.pcie:      MEM 0xa500000000..0xa5ffffffff -> 0xa500000000
[    1.749861] layerscape-pcie 3800000.pcie:      MEM 0xa400000000..0xa4ffffffff -> 0xa400000000
[    1.758389] layerscape-pcie 3800000.pcie:      MEM 0xa040000000..0xa0ffffffff -> 0x0040000000
[    1.766915] layerscape-pcie 3800000.pcie:       IO 0xa010000000..0xa01000ffff -> 0x0000000000
[    1.776141] layerscape-pcie 3800000.pcie: iATU: unroll F, 256 ob, 24 ib, align 4K, limit 4G
[    1.880382] layerscape-pcie 3800000.pcie: PCIe Gen.3 x8 link up
[    1.886349] layerscape-pcie 3800000.pcie: PCI host bridge to bus 0001:00
[    1.893046] pci_bus 0001:00: root bus resource [bus 00-ff]
[    1.898525] pci_bus 0001:00: root bus resource [mem 0xa700000000-0xa7ffffffff pref]
[    1.906174] pci_bus 0001:00: root bus resource [mem 0xa600000000-0xa6ffffffff pref]
[    1.913822] pci_bus 0001:00: root bus resource [mem 0xa500000000-0xa5ffffffff pref]
[    1.921471] pci_bus 0001:00: root bus resource [mem 0xa400000000-0xa4ffffffff pref]
[    1.929120] pci_bus 0001:00: root bus resource [mem 0xa040000000-0xa0ffffffff] (bus address [0x40000000-0xffffffff])
[    1.939633] pci_bus 0001:00: root bus resource [io  0x0000-0xffff]
[    1.945824] pci 0001:00:00.0: [1957:8d80] type 01 class 0x060400 PCIe Root Port
[    1.953146] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
[    1.958369] pci 0001:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.964456] pci 0001:00:00.0:   bridge window [mem 0xa040000000-0xa0502fffff]

[2] example of previous allocations (pcie5):
[    1.716744] layerscape-pcie 3800000.pcie: host bridge /soc/pcie@3800000 ranges:
[    1.724060] layerscape-pcie 3800000.pcie:      MEM 0xa040000000..0xa07fffffff -> 0x0040000000
[    1.733277] layerscape-pcie 3800000.pcie: iATU: unroll F, 256 ob, 24 ib, align 4K, limit 4G
[    1.836220] layerscape-pcie 3800000.pcie: PCIe Gen.3 x8 link up
[    1.842186] layerscape-pcie 3800000.pcie: PCI host bridge to bus 0001:00
[    1.848883] pci_bus 0001:00: root bus resource [bus 00-ff]
[    1.854363] pci_bus 0001:00: root bus resource [mem 0xa040000000-0xa07fffffff] (bus address [0x40000000-0x7fffffff])
[    1.864892] pci 0001:00:00.0: [1957:8d80] type 01 class 0x060400 PCIe Root Port
[    1.872216] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
[    1.877438] pci 0001:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.883526] pci 0001:00:00.0:   bridge window [mem 0xa040000000-0xa0502fffff]

[3] error programming atu beyond 4GB:
[    1.716762] layerscape-pcie 3800000.pcie: host bridge /soc/pcie@3800000 ranges:
[    1.724080] layerscape-pcie 3800000.pcie:      MEM 0xa400000000..0xa7ffffffff -> 0xa400000000
[    1.732615] layerscape-pcie 3800000.pcie:      MEM 0xa040000000..0xa0ffffffff -> 0x0040000000
[    1.741142] layerscape-pcie 3800000.pcie:       IO 0xa010000000..0xa01000ffff -> 0x0000000000
[    1.750379] layerscape-pcie 3800000.pcie: iATU: unroll F, 256 ob, 24 ib, align 4K, limit 4G
[    1.759089] layerscape-pcie 3800000.pcie: Failed to set MEM range [mem 0xa400000000-0xa7ffffffff flags 0x2200]
[    1.769089] layerscape-pcie 3800000.pcie: probe with driver layerscape-pcie failed with error -22

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v3:
- dropped rfc label
- adjusted flags
- split 16GB area into 4x4GB sections.
- enhance commit description with details explanation
- Link to v2: https://lore.kernel.org/r/20240429-lx2160-pci-v2-1-1b94576d6263@solid-run.com

Changes in v2:
- adjusted flags to fix several errors during probe and bar allocation
- explicitly tested with 2 pci cards on Debian (Linux 6.1)
- still rfc because a limitation in designware pci driver
- Link to v1: https://lore.kernel.org/r/20240321-lx2160-pci-v1-1-3673708f7eb6@solid-run.com
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 43 ++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c9541403bcd8239a48d4ef79c7c4f9e3b607b556..1a399ca8572b7ca2707856d5a041e4e024248e7e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1,3 +1,4 @@
+
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Device Tree Include file for Layerscape-LX2160A family SoC.
@@ -1181,7 +1182,12 @@ pcie1: pcie@3400000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x42102200 0x87 0x00000000 0x87 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x86 0x00000000 0x86 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x85 0x00000000 0x85 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x84 0x00000000 0x84 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0x80 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0x80 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1209,7 +1215,12 @@ pcie2: pcie@3500000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x42102200 0x8f 0x00000000 0x8f 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x8e 0x00000000 0x8e 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x8d 0x00000000 0x8d 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x8c 0x00000000 0x8c 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0x88 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0x88 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1237,7 +1248,12 @@ pcie3: pcie@3600000 {
 			apio-wins = <256>;
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x42102200 0x97 0x00000000 0x97 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x96 0x00000000 0x96 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x95 0x00000000 0x95 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x94 0x00000000 0x94 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0x90 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0x90 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1265,7 +1281,12 @@ pcie4: pcie@3700000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x42102200 0x9f 0x00000000 0x9f 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x9e 0x00000000 0x9e 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x9d 0x00000000 0x9d 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0x9c 0x00000000 0x9c 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0x98 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0x98 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1293,7 +1314,12 @@ pcie5: pcie@3800000 {
 			apio-wins = <256>;
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x42102200 0xa7 0x00000000 0xa7 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0xa6 0x00000000 0xa6 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0xa5 0x00000000 0xa5 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0xa4 0x00000000 0xa4 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0xa0 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0xa0 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1321,7 +1347,12 @@ pcie6: pcie@3900000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x42102200 0xaf 0x00000000 0xaf 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0xae 0x00000000 0xae 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0xad 0x00000000 0xad 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x42102200 0xac 0x00000000 0xac 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0xa8 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0xa8 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20240118-lx2160-pci-4bdb196e58f3

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


