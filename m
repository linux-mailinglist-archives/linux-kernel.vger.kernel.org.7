Return-Path: <linux-kernel+bounces-759328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAF8B1DC1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB1F7E0EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898892727E2;
	Thu,  7 Aug 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dNeoZbhG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dNeoZbhG"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209702727E9;
	Thu,  7 Aug 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586088; cv=fail; b=bHYMrjDIxYvbRxRaP8jfvK6GjAQeovsQwI8dUPbmhVkIrGoUshn26VNMdckTUG8DoMa+7sat5GQU/xikr5zg9XqhrMHeg/2sNsrLt1voLzJoYGrCzImskRbc4qXxWFtdRTCc1W/WMZa9y8NLfFsqxkL59o8Uu1jvg0Lx8uzApdY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586088; c=relaxed/simple;
	bh=3oNWwCyfQvddhsQUAz5g4Riz+RW3cDPcIOKsOD1rBkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otaK6fMUbtE6ejG+rBPPdDh3R05SVlMPzZwq7IFF9RfFbtpAeF6Dgca5fSGik5AxO+kicOTQJFLxLdh92sgNonCbZdqPgwHii+HiuEnRc9KIylSyXM0TEUoPgyJ10V+mvbCNrKAXvxxw4HCnKqCDGwUaLQ6mUrMo51Zx2i8R5Z4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dNeoZbhG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dNeoZbhG; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bB1ljWkarSktO3sC0g7CCn4mqz8Hp34DqF1FymA1aayiUTMAE+jaxrmIhfuLrRZl9MWhttvypCEOdiRkNRiiFler0JlZYSmau0fR2/0or8eHCIEZ9zlEFHYjf5ji1bZ75pMC8huGf1pCixillBLZ5T5YWAxVSG68vJQgEGAn2rbWoWv6uzIy+Rgo99BVuG7CDJty+H5RJ6Qf0B+pZjb1ba30xfJr1cZankUDlbdkB547y92MRvbdqNupa3vinOx1lUHuz21bmc574kJLcFdm3MJt3ZnWK0kt6NlWi5NsS0J9rV8Xpz9DLLeFqYvZqdlyNWihdAvShwa6oWBHS+Sezg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtgPEWHCBizbfX3N1qD/oIr+8GyCaJzxXpiiSHsdu5s=;
 b=Ichc9A5fjWPIiomZdBfp18rZDGWYJptTSlfyFO22hbxQ/BKHWe6/UuuktED0uaXf7PttL5MZI8tjwTA0q2XsAUZTdSSEmNHStrNMoo8qyZl7ieomE6muZ0vO8oW7E2B4vHz26DmhjyVfEWtlQLJxKYrAc7CcLvDsLxJdmMT8EKy0wn40Eq8+kmnDWnSRp6uzfX8L50D6mjbtzzNdBB+RU5IWVuHvW9RvP7smtFPCixavJzci7hO5gRFMzcwSlSMAB8KR/ebd0B6jOL9z0jbFhPgTgy3emoE8b4IstNztbgwUr58uSmWyNlbw5rUFqLdyxOMYcztavvhRjF6+3N+Bhw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=sntech.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtgPEWHCBizbfX3N1qD/oIr+8GyCaJzxXpiiSHsdu5s=;
 b=dNeoZbhGXtt3V3xplmigXlF3ng+8CZDAPiq2G7FCfF8BuvI2AEn8mXFHIje7WKgl1ycTElQUeHfQ+5cWgTRkXI+sszkV7any/9mOxm/MZZ6Ng5W2wGwUiMPzgHaGZptv7g+O5Ddaexd35Brqu2+UQOv8WYsSMrB2VMT3qF2Nebk=
Received: from DU2P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::27)
 by AS2PR08MB9416.eurprd08.prod.outlook.com (2603:10a6:20b:594::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 17:01:17 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::a0) by DU2P250CA0022.outlook.office365.com
 (2603:10a6:10:231::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Thu,
 7 Aug 2025 17:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Thu, 7 Aug 2025 17:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDkKCdH/ouiP7B0K4Sw/dqce3nrN5QTD9cEQtf0VQoAOEjaO9DXOZrXxUYhCNiGbbBfx8xHWHsKqnragv3JHDQAukPWeFFj9xXgqWsDE3q6og2UYHKi+TETZVNoGvobAIBy+u4Ar2D5xmWO/+jZW64XYmrT6Y13ElamuwTQZjNEWHTpNW/I5B8rzgYMzFAKoi518Pj2ohjdHOqP16cOruZ0vrn6gP4S45UdLmWLchGz7UpEBtM9fIjDN03Dv7iN5wfXZ+Jzc+3zap9q9T4bY7gclNlVTzhbaAh9VQGOpidh5Y/Afz+F0UOYIpD+7J6lI5dkF6b6OLPzD1xv6gU+o8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtgPEWHCBizbfX3N1qD/oIr+8GyCaJzxXpiiSHsdu5s=;
 b=eQqXgschEaCisgUZKXQVZhxO425Ot91pX+W3OWISgL1y0hjgT7n+uyHxylNWGUviQcWPWxAxoWo2qTLOmmCEaOkerNdqeAlFLnoA8hXCQ3M+/Er+C9B3VVUkW4Krf0JozaEVdfuhoXdoNzdpdAHTxaihMqUct1dTgBTkC/6Ca+ofKHUAW1ggLdEjibLdqEszb1XDqCOAGX3BNDynOYKYw00CgY6HRoSNhrT2KiTBtVjOQnvMKnrVd28fLMFfrG3RuEyR6SmOZe2nK7zU0segG5lImbX8us86lar2GFZPh32UXwRKl5HXuVhkK5FS6xb8DdRzGgaFj0e4KayC55KLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=sntech.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtgPEWHCBizbfX3N1qD/oIr+8GyCaJzxXpiiSHsdu5s=;
 b=dNeoZbhGXtt3V3xplmigXlF3ng+8CZDAPiq2G7FCfF8BuvI2AEn8mXFHIje7WKgl1ycTElQUeHfQ+5cWgTRkXI+sszkV7any/9mOxm/MZZ6Ng5W2wGwUiMPzgHaGZptv7g+O5Ddaexd35Brqu2+UQOv8WYsSMrB2VMT3qF2Nebk=
Received: from AS9PR06CA0278.eurprd06.prod.outlook.com (2603:10a6:20b:45a::18)
 by DBBPR08MB6187.eurprd08.prod.outlook.com (2603:10a6:10:209::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 7 Aug
 2025 17:00:44 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:45a:cafe::2d) by AS9PR06CA0278.outlook.office365.com
 (2603:10a6:20b:45a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Thu,
 7 Aug 2025 17:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 17:00:44 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX05.Arm.com
 (10.240.25.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 17:00:42 +0000
Received: from AZ-NEU-EX05.Arm.com (10.240.25.133) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 17:00:42 +0000
Received: from e134992.cambridge.arm.com (10.1.196.71) by mail.arm.com
 (10.240.25.133) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Aug 2025 17:00:41 +0000
From: <anton.kirilov@arm.com>
To: Heiko Stuebner <heiko@sntech.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<nd@arm.com>, Anton Kirilov <anton.kirilov@arm.com>
Subject: [PATCH] arm64: dts: rockchip: Enable HDMI audio output for NanoPi R6C/R6S
Date: Thu, 7 Aug 2025 18:00:11 +0100
Message-ID: <20250807170012.88178-1-anton.kirilov@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM3PEPF0000A793:EE_|DBBPR08MB6187:EE_|DU2PEPF00028CFF:EE_|AS2PR08MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: f01fbe48-9733-45d5-0eaa-08ddd5d4066b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?pgujsEInAnvbW74k02BY0roWHcwB9zxgCry5fkXOGB4epeEEDzFKJgBRnlWj?=
 =?us-ascii?Q?ngSGmO7cDl4vDKKBZkJBEc88OX5Zj5p1dOX6S93nhI6r8Fp9JwcIxb9UkjEv?=
 =?us-ascii?Q?p5j+MoQPlmfLZ5OgfDu5duQmsZvn/y7Kv4/pWVFVgUdAq4fs+p5UoiRqjKc9?=
 =?us-ascii?Q?xBI+cqelBfpmJLEwP74Rf/eKvNtqk2OLT3Q8dS4IXo3O2iQwZsAkjuvjbTwS?=
 =?us-ascii?Q?FsdLaB4yvgiDcKphvy6rS4DXN9bDTKFEMCldjih3JPpbosHx324Qpf8dLwHj?=
 =?us-ascii?Q?f6qhfhQJbYCQF5pVaDGdBRY9ZmBuETpQQ6c2equ0jRmyvH2hdteep+QpvS/2?=
 =?us-ascii?Q?aMiK9c4iWqRRleAm3G3cbjUpj0rog8BCUYnsQC70PYsNCiKEBdCmpQtB+Ojo?=
 =?us-ascii?Q?G9BCH2JwYgwXBtFSj3kXgw/zw51imGK1cLCp9UgslTBvv3A6wp1KjXcUITvh?=
 =?us-ascii?Q?l5kIVP2g2kXw5cWlGVuWnkweAk9JpcZyvsPCYax5JW0PSip9On4NQaK0B5aR?=
 =?us-ascii?Q?28a/FeWTIkglj8vg8lmKlLrT1wuagJcqEIEkst281BWRNvMEegPqto/zaWy+?=
 =?us-ascii?Q?nW6gH8XSPXlm/kfZkGbLdkZh4sXrrtRAIlbE5fsQ9HvS7mGfKG93bn7GpPjd?=
 =?us-ascii?Q?BMuaOvYPdIyqosJ5+yb+HzGs8mLILZnB9Au8JiA6jPBWpl/JIOD0Ru+mh186?=
 =?us-ascii?Q?YkqAEZrD/++02+qSs3cJZ39ZBCWW8QDUJ3xASMLjoCbbvLcZHAlkcXqZQT8P?=
 =?us-ascii?Q?shvYHBr99ovaS9J6CPStP1LrN9FxQ/geY+8XIRcTBKTHUWhqDzWWvYozfSmz?=
 =?us-ascii?Q?h6WvZI4SUhmff9JavaPg4XTwMFIHIcAHjYnvQkWRkgdB2POG31f9Z2Kpweck?=
 =?us-ascii?Q?Wq+Dk+Ur/qZwPOiRPGZ4gTmlYAxhBJKCz8ZxGDbDY3KVcEmp4q6r2lds9kkO?=
 =?us-ascii?Q?Dm+HOYif3RRmdLGSl/EWorsOwjZ7IfDKkRh0AxqAPW+DR2wnD1NvrOekWEBE?=
 =?us-ascii?Q?Vftxu+6HH84zaZsjVww6+5cIlFE2Ujh8UhsioI0cwQ2ANjZT9ve6mwUpXDOs?=
 =?us-ascii?Q?WQiBle0ys2+w4XscwrM5SNGGytMRkCvRvMz3j3gGeRxt2mhW6EHGu4rxeSb3?=
 =?us-ascii?Q?9uhah8qL5IlL3GSHghMTuDS7S1jC+KAYH02NYPf4EYhjCIrTbgRuMM1aAKIh?=
 =?us-ascii?Q?yzMzsaRkzuDE+mnK8lvIUk0EdW+zGcLYhhcXt6pUcd4WKbn3cZCy3f/RxcY2?=
 =?us-ascii?Q?qViEQWCi7AteUtpnGn57sXV8EUMucqjPJO/I9Z7N0MqfLVerN6praEnu08cx?=
 =?us-ascii?Q?lDTBHzUqp3wDW0FNy3f/a7HzyosEk7XXbXflj+eL2HYeD8RIrJat7t7WvyVZ?=
 =?us-ascii?Q?pD30nUZSfg4WClZrtV7tmGsKl9fu/g321kRrTFL8pabtVwKCk4yvg4fu8Mgp?=
 =?us-ascii?Q?JYG9GnIjRCcu1uLXAgmzPhDfaZrYUr3KduW4/mzRixxXrUSOBxM/LfF2Bey2?=
 =?us-ascii?Q?P/azdOycBBLO29cs7P1pS4tcoTt96NbLZdks?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6187
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4607d350-ca00-48cf-6a99-08ddd5d3f290
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/xX+3kdV2H2Sgdt35+7P/19CZizyb0ODsBL+m0VkjHaWwX2kgUMw3fDcFl+?=
 =?us-ascii?Q?GesKBFyGvn48b+fy01Zq3oIpDpoOe+sFM1i7CNGRaCfrZ2xmep0qufxKtKW5?=
 =?us-ascii?Q?jB4060ZuN2XMcLT5FgKMCF9FH49WBfEeNSTb7XAwjojcw87otwocXw6G9kPw?=
 =?us-ascii?Q?FFtmNKtLL5Ptx5kZj3MLgbRiCyeIbHjy33s8Nk7vEsb+JTGxlGL6AEwtsLK7?=
 =?us-ascii?Q?d0F8hEBQo0wQq1drRqdz0mFh2lakl1Ep2rHd/h/lfbHRUjaLj5pawGt5m/7Y?=
 =?us-ascii?Q?05CO8H1tZ1Xw/2E7thv/d2R85sFtcpk6Jz4b/7O0zNig6En/v600na1BWp/G?=
 =?us-ascii?Q?Ko3IWqgr9WFD9fWHbPyF9Pml3YFmRBMWsB0AHQ7OWUsE6b2F9rV0tq+0giqV?=
 =?us-ascii?Q?t2MKiEdlyK0ftONkrP9L6KYGLvrAMLL/77thWyZiql/Koz7vSaWN91PhTsQ0?=
 =?us-ascii?Q?Ya0fKVTNe7RbNHNp2+YQkwCoh8P0YyR1JcAMXGQbk4ZhmNULoGCsN0qW3y96?=
 =?us-ascii?Q?/1rU+8JmDMp4RA8FX5X+tv0bP6bea08yF3QgXKLQvfORzXItAkOGP0jqhnql?=
 =?us-ascii?Q?qaJ9OUqd8eJB91GeBX1P67MV69iswQGuN/MGVbgRiYYoULUkxmGSh9cc8bwy?=
 =?us-ascii?Q?ASgtq7WbGbz23R+eYgocYhu1cR1Qtp5QUpc9K+uN2N177aBZBaATRGfv0r5K?=
 =?us-ascii?Q?JCYjNSpar3iTrVu/top/wDqCSIx32Xhmf2EB5e/Crl7zvUnnD8ubLjCWVOCu?=
 =?us-ascii?Q?mrgK5DFbbDJwiW0D/r9FGou6OQRaCPBXE77FT1BtSHOis7HieQ/zb5QPlMI2?=
 =?us-ascii?Q?K/lXxX23oC7L8jON4D/KzjhcLjyOUjK6ZWTClU8PcFhqS+asx1nUqiihVWPQ?=
 =?us-ascii?Q?XrVDFlDacS71Q6HTn6LJoZ9IMf+1ZYMRhqEiGd2WaKB9Z+59VXshPAq7RJJj?=
 =?us-ascii?Q?32502+AR28evlL2Z37sCfjNdhsJk6VXpa68S6Qc5nsa3sVIR+A4L5EvwuA6Y?=
 =?us-ascii?Q?BSzCQ9tyknOU/TRWG+LvmGDJ0gsGIbyh+0qBu7j06M7d72Lpfbl8hzNk9dt7?=
 =?us-ascii?Q?PxBbVubfNBL5wYAqn9iH2lxuhGeCmpNrbEtXutW0v2C4fXfstgFc923h4DiO?=
 =?us-ascii?Q?GwCWybhobzi966Sdfnk27smfiQTcH3GocFfzyQ7A/1/EsLFR9Mx6+ZnQmQeu?=
 =?us-ascii?Q?6KQXUnwVCzOA+ozAk0NBxR1DhUfn/D3/V1MCWUgF8OpSEUFq5AojzHEFEEQk?=
 =?us-ascii?Q?Ukr/e54IV8NEHuRVtVtn4nTiZvQy/H2XfMu8VIse5p53bWHnI5o/SNBSAE6g?=
 =?us-ascii?Q?pbLvcTSknZZDmljfAs5TafFf5487uJzFbzbRGN8KE4acRQEieIH0Zu7KRlVY?=
 =?us-ascii?Q?CAEmML0JdQZzDaBdyI/UwrqDsNe1EybthwzmSLqBaLprypda/CadzR+esDMn?=
 =?us-ascii?Q?DvAG5Kzl/TW/sB/RDyRHlGYMGdrFHsNvyQsDhrttEa3AJQ6KyT7lChtRWrjt?=
 =?us-ascii?Q?9u8+vMqEE2+S9LO6uDU18va9+04TjxMdHCsV?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 17:01:17.2960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01fbe48-9733-45d5-0eaa-08ddd5d4066b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9416

From: Anton Kirilov <anton.kirilov@arm.com>

Enable HDMI audio output for FriendlyElec NanoPi R6C/R6S boards.

Signed-off-by: Anton Kirilov <anton.kirilov@arm.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index fbf062ec3bf1..2e9d5143476d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -251,6 +251,10 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+&hdmi0_sound {
+	status = "okay";
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
@@ -335,6 +339,10 @@ hym8563: rtc@51 {
 	};
 };
 
+&i2s5_8ch {
+	status = "okay";
+};
+
 &mdio1 {
 	rgmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-id001c.c916";
-- 
2.43.0


