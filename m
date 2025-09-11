Return-Path: <linux-kernel+bounces-811721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6EB52D02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F351316C743
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7EA2E8E0C;
	Thu, 11 Sep 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="oFR6Redl";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="oFR6Redl"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023135.outbound.protection.outlook.com [40.107.159.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6F2E8E09;
	Thu, 11 Sep 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.135
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582433; cv=fail; b=f/Mom8J2xWG2el467ZsXUvmZPgsq/zIl2IHuPv6cSe2NFTnngQMaiH034DVsEeD/GjEqh3AaVAvQFaQWZ8KFJcjm+QdckUSzHi7wn0momD8DSyb6+1sVJhBSjp3AQy/0G+Rw4SD5uz0zwF063qPd11MNf7FQHQ62rRJhS5fBEYo=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582433; c=relaxed/simple;
	bh=IKjgOLO7sdFIlccpA43rckP8+5LZ8blcXIOP3qAr/TQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DHkbWlOzGak+dYFVuh8/42qD1vyWafKAsJHCHam0rtWfLBb7Mk5dIZD51FK51XBAVzag+Sylf9N0Clv7YXnzRxVC/T6kgSxmtPODRBL+yZj100XcJZfhhsdwSWMi8pLBQh8ieSrfEwBzm7/hmiHKRo/k9fczfDQYC8JoGzgPSfE=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=oFR6Redl; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=oFR6Redl; arc=fail smtp.client-ip=40.107.159.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yjO1zsg0PCoM6zfPYBuJkbeRecN96WkG+7Nec6sawrL/rHoZdJr7C6OV+054dyeV6VZ0n+rxEcjg4EgEv9VibTA7XWM5Ey406P6AlU3SmxhI0yVxkj8nOdtv/73Fqp0qAIET2U5Ir67e3WevmD7/46enal3qSkH/5D6NWDmIS8Zy7iVJz+gWOndh8ORs8FDa5XRsAtljGQAc2dR7a2WpBEeO3us2JM9NjGVJWTejFzh1hIYSSkhC3nMeeeXt0JfLSCeNSbDIH30WTw8BFycn+VJJ8VWOjMGptizwUG0DaC7ZqHbM86v8QLUfeMhwmM9YgRHVwB6yzNsesYzYTA1lHA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1fRLQ0niMB7ni3kQAvxNei/rUI91VMn6MGUpI0DZso=;
 b=JbP813WU4YhvnpkmeciOW/OtP4hut+wobMtO3MHZp5slgGa4CrC05x8LINBw0VaMbXlI68QTLoq+Y4LV2IbiTqzyvP4bHW1Uat9MFU8qqsCG32617A07K7ltWmWkdaW2mC3eatwSyHAIixXYuJFjYvXtqXPaoJjrqU1Hp7k+pwJ3RgJ3ljLplC23kCOca2oZ3EwjNXMxHk4uF3OQKB7L0L5wyzOE0L3sQBnfpS5aPZ32dgugAZ9chI3rxAf/RekcopdlGoX0T3lEGZ0jdYG/1jpfia04A6PZuBxwBwHWCPtNVC55KckPQwA/AF02raIHSAG5d9cOUrWovFEqU1MLeg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1fRLQ0niMB7ni3kQAvxNei/rUI91VMn6MGUpI0DZso=;
 b=oFR6RedlUaHA2qyE6BlRSfZAHNMDzUmaez8CsF1xk0kGJdZHEicZ4dDYAbUDx8o0A1lCS6koi2Dgc3T8/EMuOvwxoh/HdrMT8hXhWjcYuK/yHT5T0oDLu3VhNgT4h7ZTT86+AfzwRGeT1CWQ1LdKM5vjteTAOXT29OjRW0541xk=
Received: from AS4P250CA0014.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::17)
 by AM9PR04MB8212.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Thu, 11 Sep
 2025 09:20:24 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::ee) by AS4P250CA0014.outlook.office365.com
 (2603:10a6:20b:5df::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 09:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 09:20:24 +0000
Received: from emails-9609599-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-20.eu-west-1.compute.internal [10.20.5.20])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 6AC6F8054F;
	Thu, 11 Sep 2025 09:20:24 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757582424; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=h1fRLQ0niMB7ni3kQAvxNei/rUI91VMn6MGUpI0DZso=;
 b=MNFXE7A1BKGt1lqLKAMjGI7zLl+ygfS7ihmPdVZcDhQ/DDNZdce5t6bBJCzFJrZaSySo4
 FOIdRuqtoZ8xNsfVpO1FU0pqPIoFB8YIXfq1lS8hi5+JAzGZ1OfXHKM+SGxxKJIYdcxT83R
 rxV6NROUUMLJnrsfhvqbWT19NbjaiZs=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757582424;
 b=jnil2k4hKU3ArH0kCB9pgF6i1sm0USjz5uue5cbzxuCuItnU5Pn3oKsRQr+Th+8wqjka/
 wbiOBQiymW2q00N14nYhbn8y/Zx3UMBx2nqmwNA2owyng/2Oa6zCrRbzIU/ok1vkYsGZ8x7
 C7Ejepu5UqRU8qaefQAyjUUOYRu8QX0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbiBg1WkCOt3Zn8BrbZAbfNZCNCB/lncHk27w/NMz1w12DBcsbKZjQLQHwQhyr6Nk0oNscGuh+q7l9f20eajwuMG1xA4MmAj4l2KWYsdJDfjXJ4S/7eTznRbgLLnZO56viLf1705YpGCrQqYsXJfpLedEagNx+9y4KqFXet5J1x6gQSC6rCzVN/v5+a/yMXIUwE/WlDNkr/FzdV2kRP+V7v8kNo3LQa6JZmEiyQIjkKw5NngfnrXXEEekXuAo18IVN3Q/k8l9YNnnMgY7oQ6/46H2/SPUQJBwtCtf7Ts/pdGLrCfnadhBUucmnorEzY1AZHWhfnBZWc+JxzPXxhssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1fRLQ0niMB7ni3kQAvxNei/rUI91VMn6MGUpI0DZso=;
 b=H7ln/tK1rAVrt4VHIGP+uKvtGZV7yIg0g62b/9HIpdAmGYhAiALb8wSJGpjc5h5woUk1prq9g51GLEoj276SQOxB/hfwXQP41tAydTdcozXNXlAXaTFGjhtGOW+blv7ovPRTVYEoDbsraDInbiJ8zyj/Q97NHUR2LVy9mWMcmnxar9BXyh74TKsffsnD0E1mTZ/8iMtRGPWWcYccvpguuKdYtunu1qhhhp/TZIJWZVURz8ItliR/ehthGvECUkC9b2dh89lCSR76Ov+Uya16zLg+DNuzdK95egjd5ASojafYhO3fW+TgK5jU38QVpv4OEKa+FgtHqIhX2TAtRHzqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1fRLQ0niMB7ni3kQAvxNei/rUI91VMn6MGUpI0DZso=;
 b=oFR6RedlUaHA2qyE6BlRSfZAHNMDzUmaez8CsF1xk0kGJdZHEicZ4dDYAbUDx8o0A1lCS6koi2Dgc3T8/EMuOvwxoh/HdrMT8hXhWjcYuK/yHT5T0oDLu3VhNgT4h7ZTT86+AfzwRGeT1CWQ1LdKM5vjteTAOXT29OjRW0541xk=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PA1PR04MB11454.eurprd04.prod.outlook.com (2603:10a6:102:4ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:20:12 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 09:20:12 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v4 0/2] arm64: dts: add descriptions for solidrun i.mx8mp
 based boards
Date: Thu, 11 Sep 2025 12:20:02 +0300
Message-Id: <20250911-imx8mp-sr-som-v4-0-1b1fae6135e0@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEKUwmgC/3XMTQ6DIBhF0a0YxqXhT8WOuo+mA8CPSlLEQGtsj
 HsvOjEx7fC+5J0ZJYgOEroUM4owuuRCn0OcCmQ61T8AuzY3YoSVpKICOz9JP+AUcQoeGwBbarB
 UQ4vyZ4hg3bR5t3vuzqVXiJ+NH+m6/pNGignmRnFWNVJyI64pPF2L47s/m+DRqo1sF2pSHwWWh
 VqWkgqwpFHNL4HvgmT8KPAsKCoVo1aDtuQoLMvyBf08l9QyAQAA
X-Change-ID: 20250614-imx8mp-sr-som-ceef5bef1bed
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
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PA1PR04MB11454:EE_|AMS0EPF000001A2:EE_|AM9PR04MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 385bb53f-3a53-4340-4e45-08ddf11470a2
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dVVPRnhCUEhyVHZvak5aQjJDQlpQeWN5aDErdjU2SnliRUdzSFZvZlNVTXpV?=
 =?utf-8?B?YjFTWjMydjlMeGhZNFQwMzdqcGswSVZWaHlzTGNxaHRNRTRsVHF1RXpoM3h4?=
 =?utf-8?B?L3hsRnNhSXdsNlhsV2h1d1pmSjhQTkpSMnRqNGo2SkFMbm9JbjNqcFNXUjRK?=
 =?utf-8?B?VnpabzdSbG5sUnZHUVpHTzdzaVpZdmtNNHVCMG5xb3NlWmltZUkrbWMrb1VZ?=
 =?utf-8?B?TGt0ekdHZ2ZHdUI0S3d4NW0rTzJIYzZBSko3L2xKREFMTStoaWdoclh4SEFw?=
 =?utf-8?B?SXhEWGthUkZjcGo2NzdkbDI0VG1raGhRMU9hS09haS9KYkUyWlVrUXppM0F1?=
 =?utf-8?B?czJhc0xFalFRKzFleXRRZWVld2ZwOVlYZTBta0pnQytYc3hQclkzOUUzVHZL?=
 =?utf-8?B?Zm12NkNLbTRvWEMzU1g5Rll2aklrSmhKWTVESmUwaU9VRmRlQUZOUlVOTnJH?=
 =?utf-8?B?UzJqV1N1R2ZEMUk3UFdFS2x0azhGekFyNDh2WjU1dTgwdDZnNnE2UDFoM3Q0?=
 =?utf-8?B?R3VycGdDd2tZUy9ZMVlnVGVra0VScTFlT3g4Y2IvNDN2YlVUdGUrZnJIWEFi?=
 =?utf-8?B?dzI2ei9mUkd6bTRSMTRzSmF3RlhLN1VqVDIzQ2pPb3luaFFEeFNNTGV2aUhO?=
 =?utf-8?B?U1RNVzlLRkNsSk5zczBram8vYXFYTDZkZGJyd0hqQkJPZms1dU5TbmFrTSs1?=
 =?utf-8?B?QU9DNkxFQUovdENvU3JBQldSZ3labW1hVHo2NnpTVEVoSkF2SHZPYWQ0YWJ1?=
 =?utf-8?B?Z01lQzVhUVZITlVwV1Z6RzlraHd6cHJ4OG5HL1c4L0R0ekhRbjBoSXhrVEQr?=
 =?utf-8?B?SHR1eGdGczZFTG5UMlRRSWlXb0xmMmhqY3dQMjU0OCsvUkwzUVRYdVdnK3hP?=
 =?utf-8?B?MVFlMlJsWUdzUzlwT2x6WHorOTZsbjlQakEvMlEzSHUrRHNpZmQwOE9QSEN1?=
 =?utf-8?B?Y2dsaUNFS1gyUFRXY3M5OHJFeThTKzd0RFJiVVN0NmtZQU1aWFc0V0FkVktL?=
 =?utf-8?B?QWo1YVZ0a2JlZDBTT21lTTVjUkNGckdPYVhtY2RtTnhvMm5hVE43SkNQVml5?=
 =?utf-8?B?dFE2ZjlPWVRNZGRmMTY4L0ZjdCs2d043OHY3OHd4Yk1YSjJVcm81M3F0TFlt?=
 =?utf-8?B?Q2FmVG1SclV3UHA5SEY2YTVTVU1YMThPSEg2dE1pVXcxV2lVOVBQNWxaaCth?=
 =?utf-8?B?a2VJWDJRYkFyU0FZaDJOcVovc2VwVmplNk1zK3FqY0FSNGR4VldBNmN2Yyt3?=
 =?utf-8?B?WFNXTjdkMTJhbU5SOEoxZjRlT1JqY2tjUkJKS0U5aDdRK2hPbDBKYzZwendr?=
 =?utf-8?B?UWZsR3M2QTJNek10c3UxbUl1a0VLUnhMVCtGMWp5YXlrN0c3bVF6TXhycFJ4?=
 =?utf-8?B?cDRJbGk1bE5hcFJWTzB3VWw3RkwyTFJDOVZnVlBsWk9CSUc0dnNOVmsybW1w?=
 =?utf-8?B?cVdJQ2xVbGlVUkd0a0NQdmNHNUNHUlRQK0REM3RmaDkrS3R1cHF4YzBGaWk4?=
 =?utf-8?B?NUtaWmdEYjh6elJYNmJBQ25ZMmU0WW1oN0RzVzlBZjhFWDB3SmU2NTc4UDNK?=
 =?utf-8?B?MzgwZGhWYmpxek1YblA5eVkwZW5rMEpQTWpoWk5tVjFYSW1DcGdPWlp6QVFM?=
 =?utf-8?B?SEVzZVlGZXRoR0h3cm1rWm5POFZPSXNaNHNaaWp3NmZvOG94WmljZkRaemI2?=
 =?utf-8?B?T2NWL3BKeVRHMWVoc2J1Q3l5M1pFVG84WitWYThGbzhmeW02elBhWUpFVW5h?=
 =?utf-8?B?UTl6YklzOGFsVU1tNzFtQ3U5MENRbkFTaUkzYU84TFNWdm45RnIyT0xtaDZo?=
 =?utf-8?B?elZZVkJFSEI3NlBTdW9vVG5JdUprNlRUQ0hVLzNKQmltMk5nMFBxTEtjeHJm?=
 =?utf-8?B?aEpwWUw3eGFJZ0tQVDVQbDFjV3B3OTZDTWpKM0hDaU0vaHpaN3hqMVY2Y0tP?=
 =?utf-8?B?YXlpa05penVpaGlZaWJ2L3VqZlFTWW93MFV5Ly83MXpqcitPZnFzNHpOcWw0?=
 =?utf-8?Q?as6nOD36xz3mj34WvYDzZVqEsvZiJ0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11454
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: ef3d212c5b6e425e843bf50d2403781a:solidrun,office365_emails,sent,inline:b8d89f8fb7121b0514dafe3b1055ac44
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	52ab7e54-6804-428b-7d1b-08ddf11468dd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700013|376014|7416014|14060799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmU2UHZHSEdndm5LSVFFTWxnNG1jdjRnMm9LYnNpbE02STRrRVRqbDJRRU1V?=
 =?utf-8?B?eW9sejJMVzF5cEdtUThvd2g2dTRSaENya282Z25oWFRUeElqZ1BETFAzSU9p?=
 =?utf-8?B?aHNGZnladys1NWdxaVRPZFZ6RVN4TktSaWs0SVJxMFpUU2I1VlJpNFMrWWZX?=
 =?utf-8?B?NW9JRExiUGp6NUFtNElHVXlOQzNaRVRYYzJDY3orOHZDWnRIbTdrbnZkTXMz?=
 =?utf-8?B?Uk9LNEdld0N1Yld2YjRSdWZNNmtlbHVCblppb0Q4UDlKUVdidS9uQmVwdVlt?=
 =?utf-8?B?ZWdOK2Q4UUtQTDJjY1dXMkdpUEJvZHV4S2Z5bE50cmNTYjBJa29ZU3BPR2l6?=
 =?utf-8?B?K01mMW83YklaVnlvaituR3N6NzZhcUVxU0pPclhjSyszVTlTMHlTYnFOV2Zy?=
 =?utf-8?B?a0h4QzRpODF6a1V3ZEFOcWN5RERBQk9ia1VJNzFkcndIRHBtakY2MWJnYWpF?=
 =?utf-8?B?S09DdUhFdzVsclRlQ0trYmFrTDBwUU5QK3EzTkFkdkovclh4azNsdmxqd3N3?=
 =?utf-8?B?bzB5V1dzb29mMDFKZHQxQ0lLYjJoOUJZU3RsdktMN29FQUQrSFplSGlFRklO?=
 =?utf-8?B?bWd5NTBlTmxDcXFyeGFKSk1jWTY5Rm94THVjSnd3Z3VEYWF0QmFTNkxLdE5F?=
 =?utf-8?B?cDlCSk5OMk1USHNvbkIzL1dOYzBaNGh2eUg0RktNRjJrWHZlKzhnWHNjTUI2?=
 =?utf-8?B?ODM2MWIxRDVJZlhUUkFNMStMNTdobzhUUVoxcElVdmJsa2NMWW9LYit5M1Bu?=
 =?utf-8?B?bG1ucWFRVXVwaXo5RnlnRzJWQmJ1YlVZbElNbUswZ2NJNEppazF0T0ozcnN4?=
 =?utf-8?B?N3luMXVaVmVaTDA4K0lOZXpWVzhCZTlndTdUSENTTVRuY1BtM0hRS3lJK1hY?=
 =?utf-8?B?U1QrRVFkanZmUFBDaFJ1ZVlVN2JtSDZ0bW5Najk0Y3lHSXRUOE1yVzQ1SjhW?=
 =?utf-8?B?SWxiaHNNdnNsb09CQVArR1ZyWHNTRnhCcGNYWnRqaExtK3ZkM0k3MEZNTGJi?=
 =?utf-8?B?dklISFVONXozbTIwdytCOGJuNm1OcEZld1draG9VVXJ5ZjFqVFkxaGVYSmRL?=
 =?utf-8?B?ZDFaWkZ1cFBaeVlUb05KS1NtZlNQN2JYTURxZmx6NElqeG5uRzIvWDVLUm5o?=
 =?utf-8?B?MDRyNHdydGxNY3VLalNPcDZGZFU3VW5XZGNUenptNWhSN01lSUxzUTZGYnhh?=
 =?utf-8?B?VWJNZ3E0aTZiNG56RGJmaWZpZG9XVzBWM0dOOEdNRFVDeTVXVU4yVVhGUGgw?=
 =?utf-8?B?STJEWFFEOTFNa0Jra3JXeHVhKzQrK1ZKRHlMZTNIYno4Tmd4QjBXVEtoSEJa?=
 =?utf-8?B?TVJyWit5STQ0Nit2VUVNUVJ2RGVrQWJkR0trN05SWnQxaFhYZk81RXZTRWlH?=
 =?utf-8?B?NlB2OVVkUkhoK3VzRllXa1VWRUNlWDA2WFR0eWsyVTRUbHRlcVJIU2h1WUh3?=
 =?utf-8?B?ZmEvYlhyTmdKK2EzaHkwNTA5akxHVVE3WUZzek1md3dMRnNqbWRzMzBGeTlI?=
 =?utf-8?B?cnlGby85V2R0bHV1amtWODIzK1BrS2grRCtTc1ZVUGJGcm9rdkllTWJHamEz?=
 =?utf-8?B?UHpmVUxrVnZPNStKY1h2allZV0FUUkY3MGlhdXRsV2VzVDQ3YlRRb0tlSEJJ?=
 =?utf-8?B?ejAwK2lKN1pLZm43bG00Q2hiaXFnNjNSYWUvWmFpQlJZdVB1NUgrTEl0OWRS?=
 =?utf-8?B?cFRScG1rMk1ScVRkcFpCR3M4TnQ5MEZKemEwRHcwZlpidm1RMDhvY01aeWZM?=
 =?utf-8?B?bkFYNkpvWFE0VkVreGxLNWVwOW5zMURSazRHU09uLzJYRkIwbC9UTjlOTkdv?=
 =?utf-8?B?ZVRCOHlXcTM3aEQxNzNWZ3lhVHRpTHpyeG0rQTVaMkdyd1BCWjhLV2NWTzVp?=
 =?utf-8?B?bWtjamhyK01QVFJmMlc2UndxeUtNYzJDdU43YUxHUlNOV25NT0FGRmxvN2Zw?=
 =?utf-8?B?RXljNFMxemthcXJ4bFJsQXlvTzhTTVBWbFZ4L0toOXhXeGxwTmF1ZFRVUVV2?=
 =?utf-8?B?Tm1pNjZlZjN0RGJiUGdRMkRocnpzbC9kZWtJMk9CSy9JcXg5SFBTQVB3NDZ0?=
 =?utf-8?Q?dbjbtl?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700013)(376014)(7416014)(14060799003)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:20:24.6885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385bb53f-3a53-4340-4e45-08ddf11470a2
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8212

Add bindings and descriptions for the SolidRun i.MX8M Plus based System
on Module and various reference boards based on said module:

- CuBox-M
- HummingBoard Mate
- HummingBoard Pro
- HummingBoard Pulse
- HummingBoard Ripple

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v4:
- rebased on shawnguo/imx/dt64 (11/09/25 40ded2d12b5d)
- Link to v3: https://lore.kernel.org/r/20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com

Changes in v3:
- Dropped unnecessary status property, sorted i2c nodes, sorted
  dsp_reserved node, sorted pinctrl nodes, renamed audio-codec node,
  dropped unnecessary newline
  (Reported-by: Shawn Guo <shawnguo2@yeah.net>)
- rebased on v6.17-rc1
- Link to v2: https://lore.kernel.org/r/20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com

Changes in v2:
- Removed invalid spidev (rohm,dh2228fv) node for mikrobus header spi
  (Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Added Acked-by: Rob Herring (Arm) <robh@kernel.org> on bindings
- Added m.2 connector reset hog for hummingboard pulse (usb-3.0 only,
  pulled low from u-boot)
- Link to v1: https://lore.kernel.org/r/20250614-imx8mp-sr-som-v1-0-3ca3269883c4@solid-run.com

---
Josua Mayer (2):
      dt-bindings: arm: fsl: Add bindings for SolidRun i.MX8MP SoM and boards
      arm64: dts: add description for solidrun imx8mp hummingboard variants

 Documentation/devicetree/bindings/arm/fsl.yaml     |  11 +
 arch/arm64/boot/dts/freescale/Makefile             |   4 +
 .../dts/freescale/imx8mp-hummingboard-mate.dts     |  31 ++
 .../boot/dts/freescale/imx8mp-hummingboard-pro.dts |  76 ++++
 .../freescale/imx8mp-hummingboard-pulse-codec.dtsi |  59 ++++
 .../imx8mp-hummingboard-pulse-common.dtsi          | 384 +++++++++++++++++++++
 .../freescale/imx8mp-hummingboard-pulse-hdmi.dtsi  |  44 +++
 .../freescale/imx8mp-hummingboard-pulse-m2con.dtsi |  60 ++++
 .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |  81 +++++
 .../dts/freescale/imx8mp-hummingboard-pulse.dts    |  83 +++++
 .../dts/freescale/imx8mp-hummingboard-ripple.dts   |  31 ++
 11 files changed, 864 insertions(+)
---
base-commit: 40ded2d12b5d999866c2bc4122683355bb17c831
change-id: 20250614-imx8mp-sr-som-ceef5bef1bed

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



