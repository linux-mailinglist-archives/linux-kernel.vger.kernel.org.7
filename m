Return-Path: <linux-kernel+bounces-878593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E0C210FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3B65628D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4E37A3B4;
	Thu, 30 Oct 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="n9j7Pa9l";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="n9j7Pa9l"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023102.outbound.protection.outlook.com [52.101.83.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F32D97B9;
	Thu, 30 Oct 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.102
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839517; cv=fail; b=ixqYP0uxTNMqcnwLY4sNI3GkjX6wINb0IDernFA9TSUPdGofVfgn9eEIUJHOVYdBGv8X02qhx4zEINlD34y3A6k6d2vgL6Ti2QXJgQUkwKrIX4Dqk/9VAyRSLbmI1mNgLN+2i4cXXbT+Zeu04ddQp9UDreQ6LWZO9EOQgmSIFmA=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839517; c=relaxed/simple;
	bh=72bViCH+1Hha13TSbvgV5aZmzEGnwrX6/qHCONLP3O4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KdyiFRN3qr805UukJ7x+H2CYLteyG9uqtNc/eFEL3GI7Bjd4hTDzgmb2rMUv6ArdW84oT7yrXc0x2igRNOPsTBMuyDFajMiwOnydTBrJ5lEK22tkFKNcf3hD2b2U8z18X82R+EE2LTbel2h828xA3uOHGeXOauUT7Gu+cQFuTBI=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=n9j7Pa9l; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=n9j7Pa9l; arc=fail smtp.client-ip=52.101.83.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LGi1ZGH4ZT1z/h50ci/6GxHhYGQ2V5NCR5OrOERFT/Lq0kX8/g3yYlbr0xGx+GynElz69oYUJG2S2Z1dBryfx64IJ6q14YnqdigtK7dIFZ+SU3ES44YM7j7z5uXgBJQqOhMwcezKNwwqNkziAiobi208DMrJzIiz31fS1P2+XORNYAdogyTH6+UJAZw7kTD1jff5xxcc8rL8Z4ZEYObGq7qgz6LoA6cvNNAlpC8S4tuVat36WK7t46bcx6rRVgdSCC5DTRwAz8YJ0QOxx4EUeoaRyvD6vyblLKg31NL9qTdf3VDvFZ7lx6pwqzW3LoH40Rnh8nLKOX85JpqtwSiYnQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72bViCH+1Hha13TSbvgV5aZmzEGnwrX6/qHCONLP3O4=;
 b=jOFC2bP3N+Ml/a4XBCuxgpoovU3ssWpmdRI0kXo53/3KNEWJ/DSrgLcw2Tmne+NxU0qllKV1VKwF0XFlZ5az2FLN5PyafFvJTTpDDZwramuqeZJCp6Rp2lgbp7muZPuXoTrMIEjLxS5z4wb8zmuJbqSteZu3mkTnj9d/zji9fXVbJKxkyMOOhCRjw/U94domniAKS8La0iXwOAzdx37OlMfYJekHL7KlvS1L54s0H0+NMfpGVjF4yuEfr9ygijvTq5/ZK90qW9iL3lHNKwDlCUdYyJVxqXri6p26zNVlpzrC3tZwxGQdHNzQFXExmGA92uqNYUnIZW5ll0iXfw7SYA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72bViCH+1Hha13TSbvgV5aZmzEGnwrX6/qHCONLP3O4=;
 b=n9j7Pa9lOBa5NBt5PXXNmMoMlEQo4ETGltiXZD9XKo5mDdOZWyPnwojjRp/3aGsoJVx2jH5BWpZhAS+CL0FF8kZD9o+YpQiUVotYK3zmv/P9GcQAUvDnq+zWRLybtOo3cWnsJK9sL/0UMXulF3DAoCy7xUDBCL8G/l8uXZ4zOTM=
Received: from DU7P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::31)
 by VI0PR04MB10949.eurprd04.prod.outlook.com (2603:10a6:800:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 15:51:49 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::d0) by DU7P190CA0007.outlook.office365.com
 (2603:10a6:10:550::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 15:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 30 Oct 2025 15:51:48 +0000
Received: from emails-3143366-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-121.eu-west-1.compute.internal [10.20.5.121])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id B88A080757;
	Thu, 30 Oct 2025 15:51:48 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1761839508; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=72bViCH+1Hha13TSbvgV5aZmzEGnwrX6/qHCONLP3O4=;
 b=ogX9uYHZSe4UN/t+SEgOukKWfEJDVYoyYiXs7NUZugr7syiW6Wr/xN2s0eZmED7fuZ+Ir
 1cUOeKxdfT09NTnKpybxd/zlgYHL15M+H/YUUNeZxF4Qf4l2/3ecY4IOglSmgjbPRYq0fUB
 oGBjBbaPr4bP4uuMyrOGM0EVQc0DRXU=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1761839508;
 b=bmAhSbT6u0j4GKDi7wBzi7Qv3sYi2X8tSM5Rs9LksOpuTJZWfe+3EzrVkc1yc/mMMetfY
 2hHqTxe3/ff63CIe9MVPgLGR6zsn4iPQ+5oIf0RJac2r4eKkTD7Qe15qjS+7FOgRqt69SrM
 JYqOgSZ0P5gFTj/ygLILtIH7MO91uxE=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJe3Sc7NA2oc7SWk5p0nEdW9mxGuq0Mwqw2HBrlPR7oquRrmSY75AlZqgnUePO+ESuHsN4STOoXm/LvueRd4pJaX/8ahPqqe4YmMuaQHvlJRxsNMnBKbjLy0MBXhQ1CRdNI8ioO12t8eoi68lTY/Y5rG+1mvtRN0BSPOjXuz53VBp7DE+POZCDuS5gNKoc9Lxas12u1sfVn7ou2TheoCVmad+cxJf5wGWm1TBQzIdk5HQFOlUkzQXbzs6VZ6gVT97HvWJYzqSP17lUV+BJ7FIOae8VDpzwuWdxXn8L+3UGO/OW47i6KYiIgcg9Rnm4cG+lOM9RAR6A9OClgjpmly0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72bViCH+1Hha13TSbvgV5aZmzEGnwrX6/qHCONLP3O4=;
 b=LOD0g7xvl7l+5zy5sHyNrxkYK6PjwXdbjURJtHU52vJhZBRcdH1YAmIMBw7bZq0JZsRRWAfZsVAJ6LkCQGi/y16Ju5Y+Ai8XF3e1rmMmGFxI4ccHOKuJamF3JWQfUIosEb+SNcP880YbZNvvX/6mXzpF8cNLR/BBeqPEW/qiHM1H3JfvfsfMPM26QSc3jAa63hWKvi3bs/pAP3CAwvrWlbq/dqa+GKT7GEp01AJMhk32hvXuEgRzauPWYdGdSosGuvZdqGLGASFOsM3j5Z9XQWW2G7YwnIqNuYCWM4DNq1PwZXnzURBeCs89Ti8qeKkVBYDgJcTv2QoWCDgP9iAT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72bViCH+1Hha13TSbvgV5aZmzEGnwrX6/qHCONLP3O4=;
 b=n9j7Pa9lOBa5NBt5PXXNmMoMlEQo4ETGltiXZD9XKo5mDdOZWyPnwojjRp/3aGsoJVx2jH5BWpZhAS+CL0FF8kZD9o+YpQiUVotYK3zmv/P9GcQAUvDnq+zWRLybtOo3cWnsJK9sL/0UMXulF3DAoCy7xUDBCL8G/l8uXZ4zOTM=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS8PR04MB8071.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 15:51:35 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 15:51:35 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rabeeh
 Khoury <rabeeh@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Jon Nettleton
	<jon@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: Re: [PATCH 2/2] clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10,
 pcie_x11 & pcie_x4
Thread-Topic: [PATCH 2/2] clk: mvebu: cp110 add CLK_IGNORE_UNUSED to pcie_x10,
 pcie_x11 & pcie_x4
Thread-Index: AQHcSbAuiv7mDNK6B0OeSgxS412jebTa0cEAgAAFAoA=
Date: Thu, 30 Oct 2025 15:51:35 +0000
Message-ID: <481bf79f-0cec-498f-9827-f4c6dfd6c14e@solid-run.com>
References: <20251030-cn913x-pci-clk-v1-0-e034d5903df1@solid-run.com>
 <20251030-cn913x-pci-clk-v1-2-e034d5903df1@solid-run.com>
 <05d450d8-8df9-490f-ac53-3f45544f1c29@lunn.ch>
In-Reply-To: <05d450d8-8df9-490f-ac53-3f45544f1c29@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AS8PR04MB8071:EE_|DU2PEPF00028D10:EE_|VI0PR04MB10949:EE_
X-MS-Office365-Filtering-Correlation-Id: 7859f184-f98f-4721-6e3f-08de17cc3c81
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SzluMithUEVnS3cwRkpQS0c4UUsvdlIrZm5nWE9LUXR6ZVRRdGVycDduQ0xC?=
 =?utf-8?B?YkZ4WUhOZDZsZVRVcDZzL3BMOEs2MFg2UFVYQkg3UjJSaENGUnk4MThlWHhj?=
 =?utf-8?B?dHBKWmoyRXkrVGZuWWhXNk5YV2UvYVh0VEdGMENsREp5QVNNSUhORUZHNlpv?=
 =?utf-8?B?b0o1UjRMVjJzK2FoaVZxeXh1VEdwaURCNFkvZ0hCMElRb2RqRnJzL0ppeVJO?=
 =?utf-8?B?Yk42bFFuSXhaaldETXc1VENFQ0VKV2FOcHM4NEFWTGhOM2Y4dDZmeUFCVHMr?=
 =?utf-8?B?aFBqWWlSV3NGTnRITFZQbGpjWjQvdFB2SndxRy8rL3M4aWppRUJ1VUtQMVh1?=
 =?utf-8?B?cXhIRXF4bFg3azVrVHJnYkpjWTFOZG9uUE9WWnZ4Qm1KcVpFdVFOWVNHWTIv?=
 =?utf-8?B?NG9ydGdaN29JT3R1aHQwbWk1V05hVkZUUFpRM2JIcEtEc0x2THpwUUtzQW5l?=
 =?utf-8?B?RmZXR0huK2o5RkZwUlNsU1oyOVBsekxWNEJxOTBSNm1xQ0RFUUlsS05kUEE0?=
 =?utf-8?B?cmFMQ2YxNmV3RE5XaThIc3NCKzZSUmFOU2IrSjNkOVhCZ0FaSnhkZHNXRlRD?=
 =?utf-8?B?VFg1elBGTy9TTVE5S2gvMHZnQWRUK1FDcXd6QWhMVkNTZUFVZmc3eEpJeGF6?=
 =?utf-8?B?Q1BkUmdIb1c1ZEtxcks4eDFuTUlESUVWTUpxRHM2c3BFU0VYcEE2L3Z1MFlP?=
 =?utf-8?B?L2lUV0xTN1l3TnFzRTRUN0VscG9XL3ZTWWZMVm1CbjJESWtQaVFhL2Vsck51?=
 =?utf-8?B?OWNXK3ZaWS9obTJvSVBMMGFmMDRSb3M3cjhCMVEvUnkwbGd0Q3RmR0hlMkZ5?=
 =?utf-8?B?cW85RFpWR3NHenJwMGhqOWtwb2s2WFlWU3FqZW1nREtGZ0VQbVZIb3BRRHNI?=
 =?utf-8?B?bFhyNS9EMHppREFFTXRFbDdRYW42REZhTW9ZSlVYQzRUUHZ3ekZZK3J6TkhH?=
 =?utf-8?B?VWlxeDl3ZEczYWR1ZktGNlYyRnBxK1V5d2hnQXJKNDRaaHdkajdGS0tPSWg4?=
 =?utf-8?B?bjhBTEZwVllJVFBlaVJLbGtCaXMzUFZvRHlFTHhnMUhHVHh1WWlqa3l0YWwy?=
 =?utf-8?B?OXZoN3ZYclNqSmtUWTFCdWpoQytFaVJCUEJJUWtzZzV4SWRDd1ptdThJRXV5?=
 =?utf-8?B?U1BRK2psdVVuUlRpYjlCL0plZ2creVcrUXRQZ2ZhaWZzNVZqQmVTbVJ2eWQ0?=
 =?utf-8?B?NlVuQVZoclkrOFJ1T2ljYSs4Ym0zZnVGb05BUWMxV0E5RWRadDBWRVFSWVFO?=
 =?utf-8?B?MU8rUGVrUFRrYWpZdWZ1OWFzQkFFdnYxUW1oTzhYRjhTdGtYYXByTTIxZVlL?=
 =?utf-8?B?akJNTlEvWnBEVzdMRlBxZWV2aXpNcklYQ2lzY3dtZ2xmOFRBR3JJRlVDVHZp?=
 =?utf-8?B?YXNDQ01OeEsxbWFoS0JOU1NGZmw4dGtzTHRCcHBsUVh0bEJVcFQxQVdSRExw?=
 =?utf-8?B?QkpLMjVBajVaK3hmT1lleFRnWWh5R3ovUGZ2WlBTbTl0SThYeTUrSGgyc1Vv?=
 =?utf-8?B?QktDcUN4eUpCYnhjbVl1emlyUVhMZ29nWW94bEw5cnoxY2RoVnNDZy9hd0VB?=
 =?utf-8?B?b0hBSHV6all4U1pxRFIwalpGeVk4TTdjd3JvdERMbzVQNldlZW9qS1BSdmdF?=
 =?utf-8?B?UDBmZ3ZJd2o1ZEJHZTJQVUw3MjZUMVEzcUQ0K2NYQnZ6RXlVby9GaHV6aDZM?=
 =?utf-8?B?NzlXbThvZnJXekc4c25DV0xZeFNqQ1Z0Vi9FL3FibFN1dCt5bXpTdkVqeG5M?=
 =?utf-8?B?dURDcmMza0FzMVhobzA0aFkwOHBuRU0xR2ZOQU9CTmhhanczbyt6OEpOaVRi?=
 =?utf-8?B?b1VoM1J6bDdGRXQxbURZWWJVRHhBNG96bkRVeXNrNWc4RHQ3QWlWNjg5aXll?=
 =?utf-8?B?NHBkQWlETm1DWVY0bnJsTS9KZ0g5RGpIcEZMdVltN2tNY2pHc2hTSXI5Q0Ex?=
 =?utf-8?B?TWJ2am9NLzJGKzh5aUtUNzZVWjhXeElRTUZJVHBwTEY2SHhxRVcxbkxucVJn?=
 =?utf-8?B?Tjh2SGtobG1tR3o5SnRQTFVjTUNzdEdVck94dHJtOVp0ODcycXFqWU4yaG9I?=
 =?utf-8?Q?SiXGx7?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <38C5774B6E1F2F489E235402E574AD91@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8071
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 71ac3f8a657b4061a8dd1f00283802a3:solidrun,office365_emails,sent,inline:22fa641f50dcc64560e2c0473a3ff695
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b1270b63-1a2c-4a2d-944a-08de17cc3471
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|82310400026|376014|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEhUbkJ4dDZuUXFZanlDRUFPQVYvbGlwb041NXllTTcvdFkyYUgyUGh3S3FL?=
 =?utf-8?B?VGxQYy9zREMxdXdnM3Fya2o4dW1QWSt5aDBrVmVTamtjKzBuU2crUDZ1VlRy?=
 =?utf-8?B?clQ0VlpYMnQ0aEo3dEFUMzloZzVMNlU3dlVKRm0yYWpzMGxIbCtFMkhJbE9J?=
 =?utf-8?B?QWJxNEt3VDZCRzcwZk5jdlBKS0xXdzFKV3M0RXNFcDgzcUlJSU5ySlN6VjB2?=
 =?utf-8?B?L3NwT2p5Qmdna1lMZHNHUWwyUzlKazhpZ3pITmpSZkRpcVhQUE9mazRZdkkw?=
 =?utf-8?B?OUZGU0xQL1phdk8vT2gwYmJiNzZBckNMZDVGS3VrNlU1V0hpTEJ6KzRrU3Nn?=
 =?utf-8?B?TXoyYmhLMzc0eDFGdzZkcktoamhlbWtkdC9nbnFveldmTVJ3VE1HM2Q3VUVZ?=
 =?utf-8?B?UUV2ZStCRjk3L0dUeGpBNGdTQlF3V3dLSm5LNitMb1JTdjJoRUw0OFBFaURM?=
 =?utf-8?B?ek1HZWdYaGE2YlN1MmxmYVMyQjhBZkxhUDUwc0xFQ1F2cVdaQmdRb3d0a2xi?=
 =?utf-8?B?ZkxVRUprR3VQZXNYYXg4MWprVGErUDFveStFcHU3REhDRncwM0huOCthNStj?=
 =?utf-8?B?UTA5MkwxZm1ISFBEOExCN2JXTEpvQklud3VBZisxVWZsRmNNMUd4NFM4U3VU?=
 =?utf-8?B?YWNoZ0xLZnhrMHM5emxua1dRVVV3K0lBYlFTUGM4Y0Z3TElueGdhdU5BK1dQ?=
 =?utf-8?B?ZlpCV2J6a3RjSzl3TG5HQkd3SFJKa1ZLWjM3SFdNQldjSm5kOWJGa3cyT2FD?=
 =?utf-8?B?Y29zQ05KY244VWFZbHVGNVhBTXcvZHJ5WUdSYUJudGo3a2hQWm9TTUpSK21v?=
 =?utf-8?B?VHgyeklWK3ZxeWkxK1A5U3J6eStpemloVUs2T0VmMUhkb1libWtOSW9TYjJF?=
 =?utf-8?B?UnZ2TWN1bGYwWDF1enVldm9EdzBWbmZFSXlWUVVkeThWVnlIaXorTGdnTzBi?=
 =?utf-8?B?QWRXdm0xM0xGbzk2cFlJVnRjWGxiM1ZFY1JzZzh3ZzZmTi9XUGVTaFhBTU5I?=
 =?utf-8?B?UUtLSVNZTGZKRW9SZXE0SldCTEsySG5jSGZvQmd5UXlIbTU1N3lIYTlBSmVE?=
 =?utf-8?B?Rmg2S01ZZVlIcDI4Uk1kdVY3NWV2VEVtdXV6S0dsdTROSjBwam5JM091ejU4?=
 =?utf-8?B?ekswYXVoNE9ETkoxTXpNVndEOFU1WUd1T01KdG9yYUVFeEN5a3ZmZTNWSXEz?=
 =?utf-8?B?ci9qVzErK2txNXpoNFBsZVJoUTA0a2RvT3VqamdzeGx2TW53Z01BajFNWUNS?=
 =?utf-8?B?aStyaGFQS0hOanpyQ2QzYzY3eUZoV0x6RjUvaUxwQ1hHcldaejV0LzVFTC9o?=
 =?utf-8?B?SWRFZUNsRko0MS9Xc0VYTkZzbW10RGFmamFpNnY5WmtyYVpJYjdKYVBOcDBS?=
 =?utf-8?B?U2FCUk1Bck5xRlZsa2RDWFUvdzJaTmdrVUQyNm1yeUhVSlpIVTladTA1S2Vs?=
 =?utf-8?B?YmpWYkdTQ0xBRmJPak5iZ1BxanhCQjZpNnNSZ1lHdThsNEV5Z0tPOXZtRTlh?=
 =?utf-8?B?ZTZyd2d6NTlONGRTeHpFWGJxU2E2dmRENzdsaXhvTElTTy9Fdy9pN1lVK0tu?=
 =?utf-8?B?czRnUzNYTnl3b1BGVHNMc1hZejk2RUFlUHk0RkN3YnBBMnRLcTMvMlN3bkxw?=
 =?utf-8?B?YjNmNXlwN2lSS1BFUFNLWk5lTnVsUi9lUWV0QkR1Yk5EMktsOFlQY1pjbS91?=
 =?utf-8?B?TmFESi9LZFZ4WUl1Z0VlakVzcmtESjMvV0NGYkhldjVzejhUOEd0VFdhaU40?=
 =?utf-8?B?cU9ocTNvbzRQUHZWZWVDeFdESHN3czQyWjlBc0kvbVRWQ3dFZnlmTXpxQysz?=
 =?utf-8?B?R3BLZ1J4cjB6WDJ3c1RMNWczSEV6aFBQU1VJYkdZMlAzRnllOG5FZ1M4QWIv?=
 =?utf-8?B?WUtSeEZZMzB1eVh6M1BhWTRVVld6VllDYzJwUmVvNmREZGdqY1NTekxvaGov?=
 =?utf-8?B?RTJuTG1ZeVpKSGszd1ZCQ3ZjK2xhQ2FJaS8xSWkxSXljT2ZBMG1PSWVYczdp?=
 =?utf-8?B?Lys2WVdrbWZJOG9WQm9NblZOY3dHS29WbnVNMk1iZUZuZGJwa2FlQ0hLbWRh?=
 =?utf-8?B?Y3YvYmcxSTcvQmZsL3FtL2pXTTgvb1ZzSXpucHpYN090eG5GNTVzejdHT1pt?=
 =?utf-8?Q?tqd4=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(82310400026)(376014)(35042699022)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:51:48.8663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7859f184-f98f-4721-6e3f-08de17cc3c81
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10949

SSBtaXNzZWQgYSBjb2xvbiBpbiB0aGUgc3ViamVjdCBsaW5lICJjcDExMDoiLA0Kc2hvdWxkIEkg
cm9sbCB2MiBmb3IgdGhpcz8NCg0KQW0gMzAuMTAuMjUgdW0gMTY6MzMgc2NocmllYiBBbmRyZXcg
THVubjoNCj4gT24gVGh1LCBPY3QgMzAsIDIwMjUgYXQgMDQ6MTY6MjZQTSArMDEwMCwgSm9zdWEg
TWF5ZXIgd3JvdGU6DQo+PiBDUDExMCBiYXNlZCBwbGF0Zm9ybXMgcmVseSBvbiB0aGUgYm9vdGxv
YWRlciBmb3IgcGNpIHBvcnQNCj4+IGluaXRpYWxpemF0aW9uLg0KPj4gVEYtQSBhY3RpdmVseSBw
cmV2ZW50cyBub24tdWJvb3QgcmUtY29uZmlndXJhdGlvbiBvZiBwY2kgbGFuZXMsIGFuZCBtYW55
DQo+PiBib2FyZHMgZG8gbm90IGhhdmUgc29mdHdhcmUgY29udHJvbCBvdmVyIHRoZSBwY2kgY2Fy
ZCByZXNldC4NCj4+DQo+PiBJZiBhIHBjaSBwb3J0IGhhZCBsaW5rIGF0IGJvb3QtdGltZSBhbmQg
dGhlIGNsb2NrIGlzIHN0b3BwZWQgYXQgYSBsYXRlcg0KPj4gcG9pbnQsIHRoZSBsaW5rIGZhaWxz
IGFuZCBjYW4gbm90IGJlIHJlY292ZXJlZC4NCj4+DQo+PiBQQ0kgY29udHJvbGxlciBkcml2ZXIg
cHJvYmUgLSBhbmQgYnkgZXh0ZW5zaW9uIG93bmVyc2hpcCBvZiBhIGRyaXZlciBmb3INCj4+IHRo
ZSBwY2kgY2xvY2tzIC0gbWF5IGJlIGRlbGF5ZWQgZXNwZWNpYWxseSBvbiBsYXJnZSBtb2R1bGFy
IGtlcm5lbHMsDQo+PiBjYXVzaW5nIHRoZSBjbG9jayBjb3JlIHRvIHN0YXJ0IGRpc2FibGluZyB1
bnVzZWQgY2xvY2tzLg0KPj4NCj4+IEFkZCB0aGUgQ0xLX0lHTk9SRV9VTlVTRUQgZmxhZyB0byB0
aGUgdGhyZWUgcGNpIHBvcnQncyBjbG9ja3MgdG8gZW5zdXJlDQo+PiB0aGV5IGFyZSBub3Qgc3Rv
cHBlZCBiZWZvcmUgdGhlIHBjaSBjb250cm9sbGVyIGRyaXZlciBoYXMgdGFrZW4NCj4+IG93bmVy
c2hpcCBhbmQgdGVzdGVkIGZvciBhbiBleGlzdGluZyBsaW5rLg0KPj4NCj4+IFRoaXMgZml4ZXMg
ZmFpbGVkIHBjaSBsaW5rIGRldGVjdGlvbiB3aGVuIGNvbnRyb2xsZXIgZHJpdmVyIHByb2JlcyBs
YXRlLA0KPj4gZS5nLiB3aXRoIGFybTY0IGRlZmNvbmZpZyBhbmQgQ09ORklHX1BIWV9NVkVCVV9D
UDExMF9DT01QSFk9bS4NCj4gU2VlbXMgbGlrZSBhIHJlYXNvbmFibGUgY29tcHJvbWlzZSwgZ2l2
ZW4gdGhhdCBURi1BIGNvdWxkIGJlIGNsYXNzZWQNCj4gYXMgYnJva2VuLiBUaGlzIG11c3QgYWxz
byBwcmV2ZW50IHN1c3BlbmQvcmVzdW1lIHBvd2VyaW5nIG9mZiBQQ0kNCj4gZGV2aWNlcywgYW5k
IHRoZW4gcmVjb25uZWN0aW5nIHRoZW0gb24gcmVzdW1lLg0KQ3VycmVudGx5IHBjaWUtYXJtYWRh
OGsgKHVubGlrZSBlLmcuIHBjaS1pbXg2KSBkb2VzIG5vdCBjdXJyZW50bHkgZGVmaW5lDQphbnkg
ZGV2X3BtX29wcyAtIHNvIHdlIHNob3VsZCBiZSBzYWZlIGZyb20gYW55IHBvd2VyLW1hbmFnZW1l
bnQuDQo+DQo+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+DQo+
ICAgICBBbmRyZXcNCg==

