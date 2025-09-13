Return-Path: <linux-kernel+bounces-815032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C432BB55E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6FD7BE8DF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 04:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1882D6624;
	Sat, 13 Sep 2025 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O5SFh+8I";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O5SFh+8I"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E02D5959
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757737896; cv=fail; b=hyyCuZfI8ATWglULbsxeCWixVqIWJI2ERhZKdZ67u60/Y4hCw/Wcrn/4oW2oLU1wP9113lIepas99VYGTUzhcffllJ8BBTEPJCj3E8T/EC5ju4/jzGFqnHls4zTMYdRVfvdaMBPiOu6iDyYf7F+4CxkHKi4Fevu3DF72kIv3Kwk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757737896; c=relaxed/simple;
	bh=+xvJF54fDWOkzxG4mj89k2pW0ejBexBxFQHZkrFoMX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfydGI57EfFvtGvRxOzU4nZMyLdXdpe7WWWQb5swK9CRbSAQYYfosJ37/dNCqYvY17Cd+4qp7SQvfi/iJhE0yYSg46uWTjFU/45GFZk7rXz41y+NcA2XHkuk42HaObUOhO7CQ5XsgkI++BkAaL3IhOj2a2wMEoR4ytkO5JCwpfk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O5SFh+8I; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O5SFh+8I; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qNjsB/IIEG69ueaF3bdbvdoxYuS5MikuQ7H9ARU+9qX64YK+JydELLpKErQ0438L+zk7feFCjQjWSk82RZdKkqy+y81Vcl9LFZzI2x0ZBIZhtJkFS/8cMnN5xVFUdd6mkEHqcHAkxx7dk8s/P7ixxYDJB0ircV0XtB9zDv5ikAul+T9EGaxOGb7UpRfpM9Ik/awgk1Z7Rql8CudfZGRp1uO3ckhxW4Bt/8bqAjziNKUnBWsEgtjb3X5cJB0NEIOqLjUrXmyM9hMOyhZOe/ePeKQhvRsO6lHdiGUvxuAG1KSQR+uVNj85PDcXP6+iVygKr4bIXUth9/1Xv86xvJIUYg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xvJF54fDWOkzxG4mj89k2pW0ejBexBxFQHZkrFoMX4=;
 b=ZjZt09EjY6u8WGmVUaZNPnLbGReVlA2m4PKVJXNQWasmr0jnl3O0FzSKPv0OeQxZr1T53PNHFYWMR+IgHyEJtcDpbTlCruWB2NmW8MmvbKxHfQYQaQmsQ6/F0zDxh4tyFvxH/EDP6opvIThR+UpLqKxeeY/zMhRHQy1AeqyQEVB9Lp0UjPxN2FywecSQmj+UZq/71kBhIVnztvODPV6+5UPnw/OwRBQv4xZC01veEJ545nWQXoG3C30kI7zbqo2WFwHE5qm1owH8Belwpn891heK/0l77/nchAezy4Bt7Xj/Zqq9ioDsQMWmNth4UFSrg8KaaI4CA4sjxhyeL4puBQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xvJF54fDWOkzxG4mj89k2pW0ejBexBxFQHZkrFoMX4=;
 b=O5SFh+8IirJFIAZ6cLhAghqDYBFuOpvIHrkHlx1mJ0cm0lgQ8rwh8juvli1eS2ThglrQQ5QBImog6efs2JGjmFJvzpOX6chQG3gUeKFbQiuzEQT+GRYm4Em3mtpHt84B/Xolmh7uM0qr4IaQCTMABU2HXcOgf7TbjoKi0vDBmeg=
Received: from PAZP264CA0251.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::12)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 04:31:28 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:102:239:cafe::54) by PAZP264CA0251.outlook.office365.com
 (2603:10a6:102:239::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.19 via Frontend Transport; Sat,
 13 Sep 2025 04:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Sat, 13 Sep 2025 04:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFOHRhjhqUuTeUnmqlhOvXmXv5Xutdy8fRu7wtoVt8mciBgnoF02y8vWoGszShM45c6LF2GcIk3PAq4LoQOLRcp3anxBCBWhhnPVL/e46ltti7q2DQHrjdQRyuFWcI46qrusLXRTZsBBzJ4envs912H+Q3zyilODPaCgj9Oey1guJuj1XSOY5qSs3jWcQXfeqUooU/9aS49wLZCHTbnA5GAs4Xfhj/yvHHyho/9jtyfrgx5Ep2DeAhlpmj+o5kA7Of3a/cudpiT/f1WDZJj/zNa1hedwJzvJz2egmsSGQFToeSQOOMUNig0HwgLMZCXgFZd+aLpGIhicBK1wpomw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xvJF54fDWOkzxG4mj89k2pW0ejBexBxFQHZkrFoMX4=;
 b=rC7QHfOWRlPBtzaLNFJUQ7DL5vob214bOqGdlNbcZ1uBs1B5k+4dcTIc+N2LsiHHgvSsd+uzFFlNuICCzDvNQ12K1dKNaigwRT/2qWiv0dHZAP19OIElwX6AS89uZkCtzRPle/MpQ0sN5NrL+1Mf1LpZvhEuf6onT2aHAniVF6iRBb6Ty+vfVvwydKnS/0ogVAE9wYHAIP6ldBnsgUpTth8naTy7qRfzMaZqlKCgH4VaxHubqptke1QhaQ4BWbJdYN414PQEuHumxdf3Ds1FaZNniK2xNsuXs+0R14r2PO8C39ykdsKHCqQUseAhqlWtEbLA0MtdtU1gC+oA/jY/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xvJF54fDWOkzxG4mj89k2pW0ejBexBxFQHZkrFoMX4=;
 b=O5SFh+8IirJFIAZ6cLhAghqDYBFuOpvIHrkHlx1mJ0cm0lgQ8rwh8juvli1eS2ThglrQQ5QBImog6efs2JGjmFJvzpOX6chQG3gUeKFbQiuzEQT+GRYm4Em3mtpHt84B/Xolmh7uM0qr4IaQCTMABU2HXcOgf7TbjoKi0vDBmeg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 04:30:54 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 04:30:53 +0000
Date: Sat, 13 Sep 2025 05:30:44 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: Fix possible deadlock in coresight_panic_cb
Message-ID: <aMTzdJRGdTCBZyo1@e129823.arm.com>
References: <20250911153315.3607119-1-sean.anderson@linux.dev>
 <20250912093534.GF12516@e132581.arm.com>
 <aMP95WqHyIQq8TcS@e129823.arm.com>
 <6d833ea6-328f-4743-abfa-fb09b168849e@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d833ea6-328f-4743-abfa-fb09b168849e@linux.dev>
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB4PR08MB9261:EE_|AM2PEPF0001C717:EE_|AM7PR08MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 7728036a-3b7f-477d-a6a3-08ddf27e67a3
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?qYoSlcaKlLP2SV+Ej6mWyTOea53/TOxxtC98HWLM/eZtWcgQdcOQPrh0BVqH?=
 =?us-ascii?Q?H+9UI7bm9OGr2VYruFnoEtNuL5eEXoSWHoh50lU69zhaERFRE92na1krMrw/?=
 =?us-ascii?Q?K84YdYaU9gWEenpIY1o5uvSKtaEvva/TfhsxF7aLdr7IvOl4Z9Ecki7N2Xn1?=
 =?us-ascii?Q?Bs2boqN9d0CWS6LnrWmsZA1Tf6+PyrvWGQor+S8uy4az7dAdDk1MMs06kQ+5?=
 =?us-ascii?Q?KGEXnCd2DM6I2JzMqlQtTQ6PGt6oTl6w4UFCyBSmSNl5mALiXsKpyxdXl13c?=
 =?us-ascii?Q?lcewK6HFGrkZpR2qVNpUf/wp5FfpOFjXiLhSJ5FBZywQSfD+teMAEHVB+ujt?=
 =?us-ascii?Q?9shVJ0dz5mfAQKQ9LYS+T2lPHpS7mB6Cj+ruKx/J4Wk2uOmV9UoAxAyXgt9e?=
 =?us-ascii?Q?KgKbLWhhH5kmVOnIqP8pll/cTG/0k1Kx1Vxk1vxtC5RKTMXGeftShkjyFGu5?=
 =?us-ascii?Q?lL3mAypY+YhepJLXUb70Ag5BtqLyvvK30PBMZ2RMLr3abvAJBR7EuH/P7R2s?=
 =?us-ascii?Q?7PU0iiFnVhVkV8ukvenH+1kFw3jVUVVeMIUoB0tNTnlVpy9/OJ6Kl+Izyosg?=
 =?us-ascii?Q?oBCJJo9xThuHv6ue9jUTZPVAsyd3w3t55GpgKTWZFa1rwWGwsmAf2mqGODUB?=
 =?us-ascii?Q?BOzrXwggHhaK9rUboNzN4DxgW8iq4DsqRjF6u4R1b/aDSOxpo+RTpnewKEOG?=
 =?us-ascii?Q?pFqYk2e/1zKy+yyDjUJFZl9luuqQnjFMkiS691AJUEVrFu2dNNgdUB0Q7nKm?=
 =?us-ascii?Q?OrIO6/3VttSsFR4gGuk/72Q0cf1JmOKS99VDvY/d1mDhY/Nw/wFUleB0Tteg?=
 =?us-ascii?Q?0Ns4lYIed/ryl7Pj35UF/T7bBx4gHuTAgbvk0aVYUuCl+RbwnpcRXwaXxw8+?=
 =?us-ascii?Q?juzTcVhBlTpZGDWbKNpbZWv5qneXQryBaaoik/2aht8NcdOddBmH4XdS07bW?=
 =?us-ascii?Q?bMgXU/gkeQ2S+SdZW4lCld6OwTBoe3/0/Df6F7xBs5FMTEsaXAl/YoW6Lrb+?=
 =?us-ascii?Q?yrNwmerCSKeEGD1Agh2imddva0fs1s8ijMVi3hOy3Zt1E7VqYfW2+TDazIa5?=
 =?us-ascii?Q?UobgfLfOezLO/ypYy1ABv7tVcMcDQI0oc98iw9o0Pu0BS94FVi2Jfc4EgAJF?=
 =?us-ascii?Q?N+kqRi9VaqTjyS2doWuEEQD2fDlwKvNiIJCNsuSmtPAuJfB/6iAqQwXU17ub?=
 =?us-ascii?Q?aPsDfed9dkdSupZ3T9h2x+xBEZD1+Tp75UeMj8n656cuLR+immxBzbsYVRtC?=
 =?us-ascii?Q?XFtIbHZt8HCUd6cb5QR4yO5dPuZHqYIuJxXn5rZLyDoFZhghwZcIkaKiibs5?=
 =?us-ascii?Q?z7DUDHbLwK9Ws/IMMxUbmF5EKHwEJ7cuakTXMLLiVWOjrC+i9SjXO5ppr0uX?=
 =?us-ascii?Q?G6+aiFJr/yYO5wRd5eRtRM+Fux5ZyZvPkcMB+ZsCK66NrK9NfT6IkoStXKx3?=
 =?us-ascii?Q?nYzGsvlGJ28=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f1cbebd5-ffcb-4ead-271e-08ddf27e5342
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J/PDxZEN+p1+U1fz3tkiVsf4Cdu7SHHjuvRJDfnkV+rn8N+YdRTR54i5rDxD?=
 =?us-ascii?Q?brH5QFZz6fcBXzaNBdAiM4i8Q3nyDPr0yoekt5hsYKZBMF7/zvgK2onzThti?=
 =?us-ascii?Q?EMCdVFLOU0xYOdKs/kJvjn/RRXJpX2Ycnuxq5xjz43kyZJ9U2wXz8/wTIEgb?=
 =?us-ascii?Q?4N78Wv5cv8G2uP5b3HUONhvvZ5izeeo0ele/8/3YhcH3Sg/Z0XMXF3M0bx5v?=
 =?us-ascii?Q?VtU91h97vLNN6FgucCVe20Mxn8Ih9UAmoOTCjuKyNg8Y0MapyRyj27aFLGtA?=
 =?us-ascii?Q?wxaDJLsiKiKg1JSgdjMPfTHUBtmuWR9xO7A2JX+z4pzyWE++yzjz5QXty6kD?=
 =?us-ascii?Q?9/XkP+VpdgauScDxNCv1g2ZyU6bUAecw7mDiJq6GrbT/96DTwC/NbeTNx0/v?=
 =?us-ascii?Q?vRUxwX69mj1X/MvysvSqiK6MyrpQjr/GDmLGZSvXlkCIGVUXp5f8ntfyi7kS?=
 =?us-ascii?Q?M0n/5x5GfFtmpi22MH55M1XpBHnuD0gNx0JQgzYGBls3tB45mTF86E7dXOgV?=
 =?us-ascii?Q?Ner7UL+VlZJKWR9Kkau96ix2NEK9+VOAlPJ2r2YSma1MKFwefHA6lwy9jYIt?=
 =?us-ascii?Q?3cSkid7GA9J3tMvURdMZI4AmRDBj9tWWvFhzSleCokgoICRGoxV5WjMKWAiZ?=
 =?us-ascii?Q?NoeFuZlBdwZyaXewfdJT5LulDVmLFod9hVvvl1UQU7Hi2N4k0rfudWjVXQ/I?=
 =?us-ascii?Q?Phfz7w66hiBGfgU5ZtiQM1aeEDIZ6bWryVoMzUqGpgu/SsmpuLRuYhs1PZQZ?=
 =?us-ascii?Q?ZQIg3gMpSiFuY/HGxCaInm0E4OCbrWBIeiiELTXAdWdMH+JQfLI4r/dpP6Du?=
 =?us-ascii?Q?tVz3W+6+iMlGEUcZnT6eGeeM0MWVdhY+PEHhdVxdz3KfVV/DvgtD7Hb+4sic?=
 =?us-ascii?Q?EY1vinJronLAhXZ+rtfAKIBSZELnytJCMLByrPl7GhGqoQELGjhKNrOi2Ibg?=
 =?us-ascii?Q?C87D2TV88enaYCg4i35O9Qnn65XzlKvCxVx6nQ+GPbRdfJVPa+9uQO7yGuXJ?=
 =?us-ascii?Q?kZ9Db793RYCrfS4d1v6HdJLdRw80QsTF9sBuz9Ehd4GaI+a+3VKxqa4CUAAp?=
 =?us-ascii?Q?2Svwi++Yu5PFdj1LfjkuYVjSGQqFluaeMKRi27SqcTWFg17t1PBqdaMlDOpc?=
 =?us-ascii?Q?tnCDyhcdy3fcnJlxJSdXA8QFDGBFDGTdRKS6eZiu8vER/xDvfXQtwHLJRCWS?=
 =?us-ascii?Q?+86q+iFZdSi3CWV/V+zjXJVZQS3KWrHWoz3i4t8LdVmwKqKFYjDk/jwuJEjD?=
 =?us-ascii?Q?XKbECJbWoWre/z7IDGx9Zu1VQAwnStBXbrx3/jCABuvfwRysXtAUFzO+DyHu?=
 =?us-ascii?Q?Q/xydjgUOG3aRaTpoUaZmN5sfhKG392AyvFirJi/bnEit8s7KwWqRFCwZ71M?=
 =?us-ascii?Q?FVYqFxeROJb41AsJIDZ/RhKnQOp9uPtbQn48mJTPRSQc1zM7nV9ybG+sqw4f?=
 =?us-ascii?Q?XZ2+lUdNS8lRudFHdN1LxyI4G2uVlG7vkd5CAvR0lnKHxW8W9sfikbGb6KgZ?=
 =?us-ascii?Q?51vWvcTF993+2y79z9IDS1BTdgYYnX2xDQJT?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 04:31:27.4157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7728036a-3b7f-477d-a6a3-08ddf27e67a3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336

Hi,

> > Hi,
> >
> >> Hi Sean,
> >>
> >> On Thu, Sep 11, 2025 at 11:33:15AM -0400, Sean Anderson wrote:
> >> > coresight_panic_cb is called with interrupts disabled during panics.
> >> > However, bus_for_each_dev calls bus_to_subsys which takes
> >> > bus_kset->list_lock without disabling IRQs. This will cause a deadlock
> >> > if a panic occurs while one of the other coresight functions that uses
> >> > bus_for_each_dev is running.
> >>
> >> The decription is a bit misleading. Even when IRQ is disabled, if an
> >> exception happens, a CPU still can be trapped for handling kernel panic.
> >>
> >> > Maintain a separate list of coresight devices to access during a panic.
> >>
> >> Rather than maintaining a separate list and introducing a new spinlock,
> >> I would argue if we can simply register panic notifier in TMC ETR and
> >> ETF drviers (see tmc_panic_sync_etr() and tmc_panic_sync_etf()).
> >>
> >> If there is no dependency between CoreSight modules in panic sync flow,
> >> it is not necessary to maintain list (and lock) for these modules.
>
> Yeah, I was thinking about this as I was preparing v2 of this patch.
>
> > +1 for this.
> > and using the spinlock in the panic_cb doesn't work on PREEMPT_RT side.
>
> What do you mean by this? I am using lockdep and it did not warn about this,
> so I assume that on PREEMPT_RT IRQs remain enabled in this path.

Hmm, I don't believe this.
When you see the panic(), it explicitly disable irq.
and preempt_disabled() before
calling atomic_notifier_call_chain(&panic_notifier_list, 0, buf);

also, atomic_nofier_call_chain() is rcu critical section.

As you know, since the spinlock becomes sleepable lock in PREEMPT_RT
this is problem.

The reason why lockdep doesn't report this problem since it was disabled
before panic notifier chain by calling debug_locks_off();

Thanks.

--
Sincerely,
Yeoreum Yun

