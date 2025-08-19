Return-Path: <linux-kernel+bounces-775070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF09B2BAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600F717B6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF030FF09;
	Tue, 19 Aug 2025 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="mpmqGTwS"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021082.outbound.protection.outlook.com [52.101.65.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1D1FFC6D;
	Tue, 19 Aug 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589227; cv=fail; b=QEAwkhpvyNcbHiDThrmk1HxBsVT6+XXmUnVqQmaZp9EzSmeyYQ65qUtpB9C4ZBzSZlMm7eMlNAGq4pK2CgcLu8g2CXt9j3Ymu9gA8/1ksaWPDE3bHAEh/MZJgxiYacwKieoF4GIfkqdkZ+LRDr1BAOwBJ97SE6axvHattVECvtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589227; c=relaxed/simple;
	bh=zlrQyIyIloopDsE+IJ56hnd29edMSxaoMu1y/pJNNME=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WFzSKJ44avzKmVg/aEAeF1dbvYEpiIscJlukmdFr5ys0UV09rJ8Sqp73EFIE0MMheLXNdq1fWJ4iySAdntFbybynaRao6NNdcbRd/XRrn0JePwPcEYK7PmVD0/ogLXdrLvx9HwimivlWbA4QkWR6me1pQwsp02leX7ntaR6sXG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=mpmqGTwS; arc=fail smtp.client-ip=52.101.65.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMPnNUj/1tdlcQ6oa++pjVgbaBpieIPjGT7oefHkVmd23uWpuB8jJgzTlyH24DKvO4zy669o6SAUV4K8P1uxD7bSZtCcBr/bYSsKBEzr5r6GTkCDR48jQL2UVBvXzbEr2VBS0V0HRlvmNAk+iz0l0XyGeBTGXO8T3U5oGmFKqX8dAREH5Qo9x94jvvSJKbyhd7dx59KTfNANzXAgnclN05FqbfXPiuvCR8IFUw0gu0wSABn1TPAFrFYcUc77puJ9rcqGGI3MqGUbnJWtm3z5iE5alUmLVKkgDgjb6E2j4tslTsu0jGuTPyKs4xBZ3xH7WjIXR5i66krCg8NFWs6uBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MOjom4/5fZmxmR/NBot7PipvkHFR3xExtPWYWZT5tU=;
 b=ugaai7SRbA/wWiT8iNXYzNaGNzo5F+CSDZ7wo8qErH0Nzdk1B9R6WmugX+NoDf3cKXZG5VHIy4fM400lFv0lEbnQnwe7zYKGtj5XQdKLoCT3Zh764jaxsPOiorDy8w4lSxWLfcBj/WsrLAWSZE3eiIfdOgCdWfH5nPWnDPPLLVuAIZVwaSCoZ/XdpJOPfmqtfp0lv2leK05BaGGyY3ZvN1TwXQi1CIzQFhsYexaZMd3vsazTXGcyUYi5R6EyLod/7RfbfiWuTd+xLEy5H+aeR7KsEPa4NipLYAEele59klXomddKjMJXLNzCrOCYxK3v99wrgvnCUugnXEc48+tpIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=topic.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MOjom4/5fZmxmR/NBot7PipvkHFR3xExtPWYWZT5tU=;
 b=mpmqGTwS0m3Q0y0xoDJXP9DA/+0EmZupd3Wia1pQh/chx4R+fuSYcO1jPm4lksF5f01dPGxSkru8WMqMcY4mpQHPfwuliQcSjmgvo2E4GqdY4FWIUNoLvESBn9ozS4gBmXHqSrWcOOCR5FsuE7y0hQRsccRJydNuc9UpnyqZIgTxR6VXY5rYS0k1TDqXLOFf1QwBCcxf8L3HbFxMuDdgfYmQ+LVnPKH7erP3bqV0ZVBggHy/lYVOCeJTJ4AuaeN46u6blvDTH9ru0L8mvfyLsxyShanCpr6KYNy04Q0tZP80/llLYLu3uXn2klriN2+U4SLzZYpqjjbikz77cMVCsA==
Received: from AM4PR07CA0028.eurprd07.prod.outlook.com (2603:10a6:205:1::41)
 by FRWPR04MB11198.eurprd04.prod.outlook.com (2603:10a6:d10:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 07:40:14 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:205:1:cafe::cf) by AM4PR07CA0028.outlook.office365.com
 (2603:10a6:205:1::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.9 via Frontend Transport; Tue,
 19 Aug 2025 07:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 07:40:14 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com (40.93.64.31) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 19 Aug 2025 07:40:13 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8390.eurprd04.prod.outlook.com (2603:10a6:102:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 07:40:11 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 07:40:11 +0000
Message-ID: <eece57c8-4e84-4ed4-9377-85c449520af7@topic.nl>
Date: Tue, 19 Aug 2025 09:40:11 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819053205.9976-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f1878466-8551-4b5d-bf2e-1706e377d436@emailsignatures365.codetwo.com>
 <20250819053205.9976-2-mike.looijmans@topic.nl>
 <20250819-mandrill-of-imminent-hurricane-a3c6d8@kuoka>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20250819-mandrill-of-imminent-hurricane-a3c6d8@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM8PR04MB7779:EE_|PAXPR04MB8390:EE_|AMS1EPF00000047:EE_|FRWPR04MB11198:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fff97a1-15ed-4ed9-dc19-08dddef3a2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NHdpRjFVRTh6bjZ3blI3NFl4OTBGeEpjZ0RCa0hkc25zYUxwTCt2blZ4b0xl?=
 =?utf-8?B?LzRCZVlGWGthY3FmMURkcURUQzJ4T3ByRG1OSTVITVhYVjQ0dUNVR3JLQUpp?=
 =?utf-8?B?cStQWkgxQlBVYWpUR2xXN0hQRWZmRUhRME96eUhMalhMSW4rbHY3YXRibTg2?=
 =?utf-8?B?VWVYVHJGYjNDYllmaWRSRklKOUhtQXlyRGNZWmR1ekp2bTNieHAzZGdRN2hL?=
 =?utf-8?B?ZzVKWkg1MDBBRUtFK3EzelI4WXhJdm40SkRpdStJNnE2VThpby9zV3dzTGdY?=
 =?utf-8?B?NVk3UEdlMkhwTnNzcjBUaVd4SW1NTVl5b0lwdEttRG5PeGFybE5nWUd4cWF5?=
 =?utf-8?B?ZWZQZ3VFVG5NY01kWmlVeHVUaW1ZK1o2SnQ1QlByWXBjWEkreUZza2xtVnZS?=
 =?utf-8?B?RVNkRXlKTlVKTVNlMjBvL095V1hKN0dIb0tYeFNKQ2REZGJNMXpaWGlmN00x?=
 =?utf-8?B?cVF1eEpXbCtpS1JJL2I0cjM4V1k2b05HcndHSnVSaElib0lHWEpqZHh5S1RX?=
 =?utf-8?B?MExIWDE3dmNkWnpPbVNQWjIvWFBWamMrTW9WSTRUSmxEWFZDR3daZjZQWU9h?=
 =?utf-8?B?WThVZm9YY29qZ2hCLy8va1YzOFo0Tm5Yeis0c1JTdnA2MTA3dFk5QWdIYVo5?=
 =?utf-8?B?MTgvbHRIaUtCMlRpNE1wbmYvZFFJTUtDdG5ZNGJENWdOVEova2FFeFg1QWdk?=
 =?utf-8?B?VDdtdEY1M1BuU3pCUFl5bGgyRGphUU14bG4zbkFkc2R2b1ZGRnpJc0RFUGc2?=
 =?utf-8?B?QzJrMHhqVjBrZ2VFOU8ycFl5Ym1yZnIyc3I3dXZmTWJSSU8zYjhiTS9TcThm?=
 =?utf-8?B?ZVU2bklPcDY1NTFZVlNpM0dkQUYzL09VSE1CZVBPTXFTbzdpdVp5V25hZkp6?=
 =?utf-8?B?ZmdnU1BJRmhZNE9TSUVSVmFxQzlMVG4wRUxsOHEzY3o2WkV3dVRTUndqb2JL?=
 =?utf-8?B?a1NtVGwzbEU4V3Q0N2lYQkNGcllRRmpKc01UVVprU0M0ZGJST0IzRHkwRmZt?=
 =?utf-8?B?ZVFuMjcxVGxveS81a1UzZStKTTdFUGZTMFo5WkgvNzhYVVdBOW9hVXpZWE11?=
 =?utf-8?B?WUQ2eE9YQWhnYi9xVHJkUlpDbDdrVWp5V0lmQmlPWVFJQVN6S3hQQ0ZtQnFQ?=
 =?utf-8?B?ekNVTkVQdkk3SjhjZXFwd1F1Y0tKc0tRQzhOU1Y0NktkVjg1OXJxbFZGMHk3?=
 =?utf-8?B?N1J4NjBvMHNGNmtya21HMlBhUTg1WkFDa05vZDh6WTJ1QU1ueXRuUDd3ZmJa?=
 =?utf-8?B?SitzMGRvVkhSbmxLSEVtTDVMRzBqSzlmTUUyOE5HMUQ5OVV2dFBoUHVORUZF?=
 =?utf-8?B?YXlpeHhHY250Ti9lQ3pWYUZJMjZmM2xlaXBYb0R4RVhWVXN1djRuK1Aza3Nr?=
 =?utf-8?B?b1pYWk1lTW9OaUtmaVZsQjU1MndvaVczcWllOGVBbjNmOHJ2TEdLKzJWamlP?=
 =?utf-8?B?UGhMVUY0VGlLVFNqV1ZSR0FiWWJQam1nMlJ2MytkTzFiNU9uSDBFcXRjNDRZ?=
 =?utf-8?B?b0Y5QVk3N2JMK2s2NG1ndWRsVndZMUwwRGVkVUNNdURja1Y0OHlNa0tsZTdC?=
 =?utf-8?B?S1VrSmQxWlFkUkk1ZDlpd3p5Q0ZRUUZxdXlaM0ovNGlCNE5rRXRsUEtBZHli?=
 =?utf-8?B?S203eFE5eW5MRjN0M3o2cFpNWjBMQjU4WjkvZlhYdSt0YkVEV2NzVzJ3WStF?=
 =?utf-8?B?dXZ1R1dWQkpCdzIvaVpXRVZrUk5iSE41Ly8xRU9RVTYvVnh0N3Q4RURacWNm?=
 =?utf-8?B?SkREeUQ2OVRFTTVWZnhyTXZvMzhFOXYway83ZlRhZStXUURuQmtBTS9PWG53?=
 =?utf-8?B?SHdkcFYxc2NOWEhtSXBYSjVpaEhSRVNrZ0RsVzF2RE1TUDltSGdQelQ3OEJw?=
 =?utf-8?B?OENiRW5hdXJvKytkVEJiV2c0dnh3bnJZcHFSODBLOW5pc3NkRnFCRFZ3MnRX?=
 =?utf-8?Q?FltLh1rGM/Y=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8390
X-CodeTwo-MessageID: 976f71fc-a86b-4972-ba30-e6acb6806862.20250819074013@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	35cf50a5-60e9-431f-6557-08dddef3a106
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|376014|1800799024|35042699022|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFhUNWxCenpLMkN3Ylp6MGFUaGdhZURHaFNIREhqRWdUVWQ0dm9CcStMNXF2?=
 =?utf-8?B?eGFTV0RMcEtWRlZMRnkxejF6Rm9XQlIyZHByQ0Y5QkdoczVmMituUk1HenVL?=
 =?utf-8?B?Yzk2YWN0RXAxRVhCUlB1d2FMVkIwbVFpbE0zRHhRbUdTRkExWmlJelNpUkdR?=
 =?utf-8?B?NEpHR281S0dvaWx2dDhIdVJ4QTRsK2l2elllMFJZQjZ6QmxnSFVVT05Xb1RF?=
 =?utf-8?B?RkJmczE3cFVmZVp4ZDZuL2tTNWxRS3ZoOGhGV2czL21id3Y2OWJ1R3M1dTNp?=
 =?utf-8?B?eklzdWJMNGZDVVZXMG12MllEckEwTFNRcnI4VkVhVWNmdHViSWlmbllscjFB?=
 =?utf-8?B?TEdFVUFvaG4yZVJyZGVnbStZbXluSDBhbmgxMjRNcTlHVks1WE9XNVc3STVM?=
 =?utf-8?B?UkJEMUNWQzYxSzZwUnAvK0FJT2pCTWhIV3FMTm1CT3MvYjJya05SdnM1QjBF?=
 =?utf-8?B?TlE0Qm1uc2xxRDdpZlJSNmdmS0djQktvUXJOeUZYNVFLcWtyOGpGajM1aW1X?=
 =?utf-8?B?TjlPTFZrTWp6QS9IRVRWQzE5SkdZY2k0bkwxamx0VUptdXhVZklETm1zYzJB?=
 =?utf-8?B?dlpRcDJ5RHhnMTJadkswUU1BRFkya09TS2xRcEdXZWsyNGVEWGYxem5FSXhL?=
 =?utf-8?B?NjhxVmx1SCtRdGRNM3dPZXVTRk1vOHZJM3BGSUhURVQ3YjlMY0oxdnBCa1Z4?=
 =?utf-8?B?WDQvTTh5MEllNkQ1b3p1SEZxb2lQZWllM2NDZFpzOWVIbVdZdGdVVW5RalRM?=
 =?utf-8?B?THZteWo1NTF6WVBIL2NtRFZoVHFDck5wRG81YlBaU1VaOEZwaWxGY2FWYm15?=
 =?utf-8?B?azFhSXBIdkdwNzJiQXRVWWJ4QmM4S2NYWVQvd2hNbzdyb2pKL2Fjb05KVmp6?=
 =?utf-8?B?cXphL3NNb1JTZ3dqRXpXcjdFTkdrWmtvWGpDK25PS3czK1djYUpTcTJVaU1k?=
 =?utf-8?B?dlFpaFlMa2lyS1VjcTBFaXBWd0trZXlmSkFaMlFMVzVuYlBwREg0Ni9GQnpM?=
 =?utf-8?B?bmd4N1NEUEVFQkNyNkxPSmdLSU9xSm5uWmZmZHJDQ09yNVlUQmZPalJqZmpW?=
 =?utf-8?B?cmRvZEZrWTNOdXdRTHlHMHo0VS9pa0h3R3p3Nk9nVDJIczZacnEvV29ycldw?=
 =?utf-8?B?aytQS05WRnA1Zzd1bmdCcjNQUU94MDNkRVQxWitqT3BVdTV3ejJzRFZLcUVl?=
 =?utf-8?B?WjR1MUduVm11QmRnOXIzTmNtaVhKQkFQdEpQSTJxVDZaUjRSa1BRT2hYUVVO?=
 =?utf-8?B?VHdnc1JCMG5HTVRPdXlaUmxnRTRWamtBajVjaEU1a0pBS25XNjlwcmFuZmFt?=
 =?utf-8?B?cThEVm5mOGdCak9zaC8xa0ZTMzhseUNYN1hMVU9YcnlJQUlFVmxFcHRwUGxT?=
 =?utf-8?B?akJRTjhMeThuMk1CSHRhZ2lMbStKaVdFdmRva1lUcmYvdEVDRXhhcksxaTR0?=
 =?utf-8?B?eHpwVUI4V0tJMHhXV3RkaTI5TGdjcHMwVElrNm5ZRlRxNElGU0lUelh6STE2?=
 =?utf-8?B?bE1BVm04Nk9pLzg5MzkzeUlJcG5iRlZQOWs0OXo0RG1LdzBudkZSUytCYncv?=
 =?utf-8?B?VjN1ejROd2JkK0JZQjdoTU85cTFCWDlTaDdydk1nY1BBbWhyd2lodWtwakVW?=
 =?utf-8?B?VWdBRHZ6N0c2a3dNVmNpTUJQQ29MQjVoVkw3VHdmSmNSRkZKSWFlZ3dzTWlC?=
 =?utf-8?B?bWtoWTUyNmxLZlhqV3dYZWwvOXNwWEhGRGVUaGthWG1yR0VXL2RaMkJkNzE3?=
 =?utf-8?B?VUxSRmhzV3FHSTdPTy9sZ28vKzZXc2twa21yWHVIRXdZeHZzeHJYVlBFNnFs?=
 =?utf-8?B?bDA0T0QzNC9wSGwwdmN4V1Uwc0VKOEt6a3hPNy9BZEIwQkFZbm9IejdKNU45?=
 =?utf-8?B?cS9wTmEzMSttQ3A0UUcxREdxUDFZdEdJdjF1MXRKVXYxeDF1NG94dDRBQ3FY?=
 =?utf-8?B?NWpjNDVPYXd3czVjcHVtVjJJd2x6Wml3T1lpMTgvd1pWd3NvcVUrK2pKYnAz?=
 =?utf-8?B?NEtOemgvUmxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(376014)(1800799024)(35042699022)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:40:14.6129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fff97a1-15ed-4ed9-dc19-08dddef3a2d2
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11198

On 19-08-2025 09:03, Krzysztof Kozlowski wrote:
> On Tue, Aug 19, 2025 at 07:31:14AM +0200, Mike Looijmans wrote:
>> Add DT binding document for TI TMDS181 and SN65DP159 HDMI retimers.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>> Changes in v2:
>> Document driver specific bindings like slew-rate and threshold
>>
>>   .../bindings/display/bridge/ti,tmds181.yaml   | 143 ++++++++++++++++++
>>   1 file changed, 143 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/bridge/ti=
,tmds181.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tmds181=
.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
>> new file mode 100644
>> index 000000000000..816bea54846f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
>> @@ -0,0 +1,143 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/bridge/ti,tmds181.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TMDS181 and SN65DP159 HDMI retimer/redriver chips
>> +
>> +maintainers:
>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>> +
>> +description: |
>> +  Texas Instruments TMDS181 and SN65DP159 retimer and redriver chips.
>> +  https://www.ti.com/product/TMDS181
>> +  https://www.ti.com/product/TMDS181
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,tmds181
>> +      - ti,sn65dp159
> Nothing improved, you did not respond to review, you did not say why it
> is not implemented in changelog. You did not explain that choice in
> commit msg, either.

Apologies, my bad. I totally forgot.


>
> Best regards,
> Krzysztof

--=20
Mike Looijmans



