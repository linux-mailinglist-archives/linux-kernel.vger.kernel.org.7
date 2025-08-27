Return-Path: <linux-kernel+bounces-788454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE35B384D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E32F1BA6376
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330123570D4;
	Wed, 27 Aug 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tw8QaZdr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tw8QaZdr"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF6303CA3;
	Wed, 27 Aug 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304587; cv=fail; b=EOvR3Lbgu9aLA9hyQNuUUGmtvrCuPTFmjXig015c9IjrNV7zPQB42GspGkRCz4a1JYGieVUhxJZU1h3TfV5MO8dSbMEHSzJBG8rtOBzwHFd70WsuZqJ/UAeD34cqo07gDBN6NdjJ8Gmz2hmcQWO3NjU806nBNbmvjhfFB3EwoFg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304587; c=relaxed/simple;
	bh=Fxjq1UuCoNURxyQeFnmezXUdHmbjS+xMft43pBE4YSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yp93LmJZhjTDUY8JrJcc3W0nVVWv7tO3t/XrcbWXKcZvNeEokivKyuR95vlFU5OxusMs2Ma0riO9HyaXCK7S3NH4a6/L2VQLj+dgcSzYz/xgwbL8j4FE/R0qt4eGTbYV/1QF9eET1jPjPgPO99N2S54+CQSCU6oT2e7fQ7+RHRU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tw8QaZdr; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tw8QaZdr; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=l0l4DuK96lduUaEv82/Y/uuPyITH8zcw+/R2m4L7UVlrKoq0iZEXGzS77yQWTrfm0Vvn++jnNOl8D3N8QHePTrP4qSMj8cGc8XPv1LBy2SZ1NHu8ZXavbrgH+81e6lsKtV0mz46KJHs4681TvzwzrA4XpT+UN+jGvL06h8rW15vsw9wXCCpJDQjP9MPIF3KnEFqlO7Jb8vj2/5CmQL8xrv4iUonKcZ3kZ46FX2F2CEJJquuFU2oRJE9KwicpiKNK5+Ng+chMkCtUlO97mPeiY4oKihVQag4B4/t+ycgu0SelXw/lua5siwTNBbu0VkamqVPFZ+w21Ha/SxzLrYKCAw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC8Rq4O13ul6tQEc+DZhi1maEyzDmQkAOPKUfpIO3eY=;
 b=K+K4b/W49Co48OSLc6aYFkv90ORfagO6QZ2fTDdBUGCFElp/0Dkvv8YZTzCrOYjB1kZ2ietQ2PnlQM4AO1mh1Mr2gHhjd/hcLu85Un7bjeMI5SThWBUZPEfxYZYKsnbvSpYPXaamAVfPDZ1cva2vzRRw3byjnsswaELcPHtXvRIGVOC/7PsIYgTiag4Oge6vfy0H1ylZffxfb5dyQYIB+PhJ+fTwDRh1rOTHVTvXv3NgvFt0Qu7ugQY8hTivVtyOhNg2uf3wWfhj4E1y/jbYo4oSR4X969j3uncp4lCc0xxAacE4EendnzzUq0+N3Ypb7XqyDrop8C7RkbhdR7DjRw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=sntech.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC8Rq4O13ul6tQEc+DZhi1maEyzDmQkAOPKUfpIO3eY=;
 b=Tw8QaZdr41BnlQ7Hp4ML+I+ypOeXNdZT6d1x70Um28BGxmPpjVV9azPQVJ7po7EHWNdpXD5v9rWb8lKQCz1ylLS4OJpXyWgpy72kTucVp28F75rP0NHVo+fvDBxF6a8/ncoJOlK0mxP3xygoIWmqpzBc6piR1NwQ2OfV/13M68A=
Received: from CWLP123CA0252.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::21)
 by AS8PR08MB9388.eurprd08.prod.outlook.com (2603:10a6:20b:5ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 27 Aug
 2025 14:22:56 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::5d) by CWLP123CA0252.outlook.office365.com
 (2603:10a6:400:19e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 14:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Wed, 27 Aug 2025 14:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k12/1ovZeDcUQPqQOoXLzhXNQScCjZloHN2R/C5P6mk/zSbcGygmNLvPNf42BfLX40mHmqHLmPBgjFhqXIqXIR0hRTB6nxydgtixtiScf74N2PQH+VrVP6Kemhy3je0gHnwytIUYeR37OrY5RQ0N8J49OBLYXead84p3nlSh70ovDCMYJT+Ifbx1MtzgqP3UbPgRh2w3oztmBFriw6yjh6PbINcbo5Fvivyscyvw1jWbqmV5Q7CazxwEBYEvbdCQrjPBtUn4TPHytpQQ/kwqXDNzL2Za8z1FlCAUGSP5tFrdZtojZgWxuqiSTn/rptCr0vAuuri/7Ztmny4LWQ882Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC8Rq4O13ul6tQEc+DZhi1maEyzDmQkAOPKUfpIO3eY=;
 b=usc/cRYLFVVS6uKyMBLhPNVugbm6dOsWITa5urIKECPw9ip4E0RlAYM08+LH/D+GI9z0NQPzVF3l/GA92bU4C4WadPpYgM+9eWxfczvxG0gmVC9bCjTseVNjb/iqXGBlpcQHUgpkafpsnRCMGu5GnIZ/rBoIoypZ4m36dgcJI28SYvoXlGq05TEktbrsfFizjJJhLfTg0SMfL0ZHcTATTxWSQGa0L+oMzebkqC621+H8NnjC9q+otfzwz/xS/apDZX4KZlkXM5/Oz4ibULg8h6bNwyiM+kLdJz6NqfyHc5tXqW4Yo7G5yF2JfxrcXCVjWDPItAMkRUZSihXvsZ6M1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=sntech.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC8Rq4O13ul6tQEc+DZhi1maEyzDmQkAOPKUfpIO3eY=;
 b=Tw8QaZdr41BnlQ7Hp4ML+I+ypOeXNdZT6d1x70Um28BGxmPpjVV9azPQVJ7po7EHWNdpXD5v9rWb8lKQCz1ylLS4OJpXyWgpy72kTucVp28F75rP0NHVo+fvDBxF6a8/ncoJOlK0mxP3xygoIWmqpzBc6piR1NwQ2OfV/13M68A=
Received: from AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::37)
 by AS8PR08MB10195.eurprd08.prod.outlook.com (2603:10a6:20b:629::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Wed, 27 Aug
 2025 14:22:21 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:208:17c:cafe::a1) by AM0PR10CA0027.outlook.office365.com
 (2603:10a6:208:17c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Wed,
 27 Aug 2025 14:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 14:22:21 +0000
Received: from AZ-NEU-EX05.Arm.com (10.240.25.133) by AZ-NEU-EX05.Arm.com
 (10.240.25.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 14:22:15 +0000
Received: from e134992.cambridge.arm.com (10.1.196.71) by mail.arm.com
 (10.240.25.133) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Aug 2025 14:22:15 +0000
From: <anton.kirilov@arm.com>
To: Heiko Stuebner <heiko@sntech.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<nd@arm.com>, Anton Kirilov <anton.kirilov@arm.com>
Subject: [PATCH] arm64: dts: rockchip: Enable the NPU on NanoPi R6C/R6S
Date: Wed, 27 Aug 2025 15:22:10 +0100
Message-ID: <20250827142210.2221606-1-anton.kirilov@arm.com>
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
	AM1PEPF000252DD:EE_|AS8PR08MB10195:EE_|AMS0EPF000001A4:EE_|AS8PR08MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: ba54543a-e464-454b-0b2f-08dde57536d2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?IsVClAKvZ3bAtBKBzc7S3TAsP/B4Ry6JrhBeSMSr/cB1BaBXN1pY4RCg1xpD?=
 =?us-ascii?Q?ohX5UCaqJ1dS5UE1AfCZj91mX7uBBfpmqmKK5BUNBFxRib5JZWJzeYhnzwNh?=
 =?us-ascii?Q?m8X8pre2+TaShOWVgp50h7eEnyNuqdw+C59gY+1d0NgTdI5FD/mJiH0xqBiW?=
 =?us-ascii?Q?qxv+T6uZQL4U3yeCMis4oAW0OWyTil0tOnPLNxA9YaRetlkiYh2RLK+ih0mL?=
 =?us-ascii?Q?xwaOqx2glr+wvB/m7VkIlNjd+C+VPD1OJJlQndr5O1MbUfDWf9hASbSQYqJa?=
 =?us-ascii?Q?LQ1cj+qPU6DTXu86QaytgWhZkCIKcUN2kkJi1ASEVx4U5P71STQWbtM275Ef?=
 =?us-ascii?Q?JWjMk24kqpWZL+EFs05kyUiHcAjhn1H+CyfjALBtJOOC3cTnfNwkwuSIR7tg?=
 =?us-ascii?Q?DlbqsQiza3TM4ebbJLiCqkiM+cCyNWfdpKPkRkWCh6m5Lfs56OMRer55Iuj1?=
 =?us-ascii?Q?qeuJ47E6zOK/f/prKEDjClFga5Ywx+qFyu3p7zBNKCXaQ8ij9NgIWw2Vj/dU?=
 =?us-ascii?Q?HFjLRPyJ0olOhR1Tt0LH/SeoHoWs17jcdWa/l7L8jmsWlsMBodEczKtlYsl8?=
 =?us-ascii?Q?VMYgMXn7IqkXW9T8YMEhffYkZKaCXSZFhCq20vkF7umgwj3SZ/rSy05in10W?=
 =?us-ascii?Q?uTSFe4gpInFYNpk1l2t5ekG3QY8mAmdphVvbrFE0I+c2hfNrpRJaS1/U01VO?=
 =?us-ascii?Q?I3ozJ71wtyewoKc5fM2NvGck/c5q0JKXvnGAT8ortV1kGclLX02HQFYnHoJw?=
 =?us-ascii?Q?imwpbcx1g+uB0qNWiFB7QTrHng8cY17YvLfGC/RjT6ukJEW3Hkiqx6moPN37?=
 =?us-ascii?Q?vn96PUeIICadBAcViecY7MdOxkPsM1C1XmGo4t54TS5YEVbrT48foRQvAJ9H?=
 =?us-ascii?Q?zp77SHBbxWGsLfok/7rLON37bTQj2hfnjbNNndTBM9HQoo9qndLlMtJJsRZ5?=
 =?us-ascii?Q?t4lrYvYjKMwN99XmAkSup8uA7elwN3Z/RLudAunztOgpGFCKpNKFbOTZjUwC?=
 =?us-ascii?Q?TNOI7nE/VcNdBNMvW4e1KQm3eE0amMHwQshDRKHecAjSv/eNNN+rUp+gEG8m?=
 =?us-ascii?Q?MqK/rB8I8vkZrcaGPiDMIw3HuJ+ZUmtjca4944ksqb1YG0J0Lm2+WDPph+cS?=
 =?us-ascii?Q?XJjwy8s3hSiKa4rCtelDoyJpEprZa6lQg7HoJdMTXR7Pws+zfunbNZhMg6mC?=
 =?us-ascii?Q?selwJriVkD3DuIqYyMHPEu4QNxLlgkJ/w0ZYeFPfGXzvROrRqQQB4xaveSv7?=
 =?us-ascii?Q?Obtho4CyY167OFPDQ0vf9Wr4p2agqwAhgtoHizS8e5XOvatBVtXlm3GaHeBL?=
 =?us-ascii?Q?Sh2g7HKZWXkXrdL+y8+HOLCK6oGtEoy9BI/hhz3l579Sg61Y9ZduWOGCIkWM?=
 =?us-ascii?Q?7s42rGKsP3lpWQ5vKwUYsIsAL/X6gdozg8gZaxjE0kuS95rLH98ARYREREXS?=
 =?us-ascii?Q?x2BQh6bET5zWsvHjfNlwlw5uax9RF0nrhPJwKQFA9vmji7qm8EPawK9xX5ZV?=
 =?us-ascii?Q?sGHMaI94VxM01raCpNccRHgzBME+PUUqtzt1?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10195
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	71193588-6351-47a7-85b4-08dde57522dc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8p93HmeSI1Dazy2HjoaSrhvSLiBeVtdbHaV9rdyPM0yw0yZ6mQxNdhsdDwRN?=
 =?us-ascii?Q?XeIO5K2SZQpKB53BBiNGKm7fRcApWIalGufdzSJ//viMEedddgn3VMtVLPzQ?=
 =?us-ascii?Q?l8jpmSa+DX+LlV0WC0VAiSYv3sxDaqIHEGfpyGdXwPA/GdRqUKxxZ+S1JymV?=
 =?us-ascii?Q?skhjw7kCnDkxZ0vO336uf+HjT+VWPpXiFm6j1uzF5Ye0YWUsdQ76wl5RdKMB?=
 =?us-ascii?Q?3ZsqrcqfK/7raNLdLS925oYaMh1WuFSxko4r1QdTxKWZjHasdt9rUWq08dkO?=
 =?us-ascii?Q?igaNFaCemLLxCOyFBw2MUE7PlRZsPZ4g4iWAoHQ97fZrYIXdgryo5dpiwsMO?=
 =?us-ascii?Q?YTpWgsYF7HgGUv7H7b2Mlq70IZNRGUpFb30+RVc+yfUd07sOgczalzyPjOCQ?=
 =?us-ascii?Q?So+3rDIGICHzJVtBvjbIff9AfU0k4iRaHmy1Mo2rLct6JBssFa/UQT3P9oA6?=
 =?us-ascii?Q?iXqpVPZN42jUyT2t3gmXOui5sJh6wiTbvQ/xe5cvV2GIbKLKFU/qwR/+9wmh?=
 =?us-ascii?Q?0dg3GfTg8taLdclksgdPPh7NfyZs/vjqtUj235tarS3577p6UTPLCpOuNbQJ?=
 =?us-ascii?Q?yyCVQDFx8jUmdgx6orV5kGvk5LhExuGUJ7YjUQJR6hSzjFiLcr6LzEHM+y8Y?=
 =?us-ascii?Q?0BvO6Zvl5XdW13Qzff8ta+kQr83PtrdLA7G31Q8EnFpwpGyYwXgXzZNDnZpH?=
 =?us-ascii?Q?g0k+y6GofFpbk2sfbsNVS2BwvUWlp6KIRf8dWx72Y9EovT0KOzi0azC8cdWw?=
 =?us-ascii?Q?7HdpI0IiFqX2AsddOPFsEkrQlQYQ4o2DvtVsPccPxOt7UERm/CNlHpgdEKLb?=
 =?us-ascii?Q?/luhM0h9Gs/qbon66LX417qGYNcsbT+Jylj50Q0fbsPVa9o4if5+wePBxrvC?=
 =?us-ascii?Q?I3vP2+9pNEvVp7BJPUVLSu579qho0RRxbfLF0W4vos5ZDo1Thyw2apvWVKyB?=
 =?us-ascii?Q?Xd4LLJ3Zt77WKMAEAOnIm9SoarkwDIngXq0ZIxcUHUG0qyDVX6oIaPPzmXTV?=
 =?us-ascii?Q?wcfv81qRlaxUVirnvjmmGh4sTWQJDzoeWzKxVkiLD2PoIjvv8iPnSOAA+AHk?=
 =?us-ascii?Q?yNyyNvGxtshoyh+/W8JH7BOVMbP9lfOEMTT3UDWi7aYRhoYhWtX2f/4gZq/1?=
 =?us-ascii?Q?wqma2gdrbgT52nRjFqa25gL2y7FX0nsW7do6t9oIDIxcQkaqHAhrrLd6E4cS?=
 =?us-ascii?Q?B6bb3yGuhdEZo4nOBFL7Ox69v0/sOlMA4PIV+RnStEWHK/ZJIjaTrHEYiIT4?=
 =?us-ascii?Q?uE/3xbKnGuQ+dLTQqd0SMtkZe5SCsjg6xXkUmH6pi9Rs9Y803W24nFJMv2n2?=
 =?us-ascii?Q?iCkr/VKaaF8bhrTaC6AQ8f6/09vIEzDYWddoBqTugVrb2ern2RRI7LnKiU5J?=
 =?us-ascii?Q?MLOPepVdrV2kY16kmK2nUspsA1Qw3he/TFCK4V33lWQ6WdZ+hbYHGYMYm/bz?=
 =?us-ascii?Q?Oy1WjpTq3QC6Ln5nzJNoyXuMTid1i1XrPtrTsX8LdoZzAZM69WnedkWxxPUw?=
 =?us-ascii?Q?sDteQu9yOKNNHjOlvtVafxP5gmjZoicpMBLO?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:22:54.9338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba54543a-e464-454b-0b2f-08dde57536d2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9388

From: Anton Kirilov <anton.kirilov@arm.com>

Enable the NPU on FriendlyElec NanoPi R6C/R6S boards.

Signed-off-by: Anton Kirilov <anton.kirilov@arm.com>
---
 .../boot/dts/rockchip/rk3588s-nanopi-r6.dtsi  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index fbf062ec3bf1..5410fd35927d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -363,6 +363,10 @@ &pd_gpu {
 	domain-supply = <&vdd_gpu_s0>;
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	gpio-key {
 		key1_pin: key1-pin {
@@ -421,6 +425,36 @@ rtl8211f_rst: rtl8211f-rst {
 	};
 };
 
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	sram-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_core_1 {
+	npu-supply = <&vdd_npu_s0>;
+	sram-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_core_2 {
+	npu-supply = <&vdd_npu_s0>;
+	sram-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
+&rknn_mmu_1 {
+	status = "okay";
+};
+
+&rknn_mmu_2 {
+	status = "okay";
+};
+
 &saradc {
 	vref-supply = <&avcc_1v8_s0>;
 	status = "okay";
-- 
2.43.0


