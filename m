Return-Path: <linux-kernel+bounces-813779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB4B54A90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41C81C2370D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC22E6CD9;
	Fri, 12 Sep 2025 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e8U+S3TE";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e8U+S3TE"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA942DC78D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675025; cv=fail; b=svc52sauVTbK6fShFdrhf17Q3UIAZMiPr/qBQqJQQppQWgB/GUuH8WwH3D9iPVdJI1j49hErGB1bq8EV4CocA/BxtWwFVmvPoWoZj0advZmALCe6jN7ei4ZAFygLesvW/UoEZRcJKxP0U5z7ZZMzPpJpCLGXElD90rot9Hxn06Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675025; c=relaxed/simple;
	bh=ocYzZ3snhV0eDmgS6fVX2V/f+HEotsQWE+ixdkqvNik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=shI/DJXyU/StUrULlv6y4NN50ZISvwo4acaLtCwL0olDxFAiUDF8oCNjCWSEIFxcr8n+a3jmwr6RvgbBFomfgqCHlM1L6C/XPkCcBS3PwNVZAoktUmV52ApwgO4PM9o4vcq1qHnjS0TKgzkQeieyg4AgGJJ1Hop0aAQVRidiVLU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e8U+S3TE; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e8U+S3TE; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=T0TMYJUyj9YgV2go5idmBUNyFnqSnQYH8ttoQn5zQRHDcS9pogMnQbamv60aTuT0OGZ+x+nJfSlyC0rWq+jY7nYMfkO7rpfxOkxcWCQH8Z6Kq7YzoXR3ETeWS0xeJB45y/4dxbNlcrN+d85/33Jk3Y/mH1gAkRj9uR2rLfhLr4juPCciJID6r9h1kVqXFSXS1qslqpXOleRtqoQMWYcy7jLmacSUfg2X5q0fbBDmbfQWX/RVbS4ANEvgEzRp4tINKj8fyhJHRI3BydTpI7Xqu55Ed3ZRiXkSOvp7Xuw9VPyHfM26GuIqQk9GtvWPtB4CHkjdh9MyRlWkM/3Sf8qvSw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocYzZ3snhV0eDmgS6fVX2V/f+HEotsQWE+ixdkqvNik=;
 b=bn1m65SRVD6fDQ5AeLqcL6gye8pQ/haGq6N5u+HVyN6lc38jNSBfrFwLgQj1pE1HPPr5uVUQ4nY62YTq4Pt7kuKHWcSecTySBjbLNZnE9vq+DIMlBRVs4CMsPYdOXH6Luml2D24b+3FOj78T5nR/ukQr/BLj+3lPk6/5ShiygtzuIowH4qKPhI7d5BT+kw1efej0ZgeBIL1z7jo4Qlw/NEIuS/SsCMvy/3VwJ9EpeCR0AGiwENaLGq7dsh91uicpSJg5hgaBQgab8/I74/7InLfD1d9AxqjR3KxAoM5CVW43oLhfjnuWVhHrHV+3hSlW/6ok3EQfKkg9slwTF8GAPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocYzZ3snhV0eDmgS6fVX2V/f+HEotsQWE+ixdkqvNik=;
 b=e8U+S3TEzyXmaFYA7vS0hiAuohYBXQdvr8ZZwPezzGbhwMLdBUYueRHNW5czr5raDhmPN0p8RXHEka0XHvZaxqKjhbEMvN6Mk3Ab9LhLVtfTIWgtPBYoLxFZ+imRPdCx06iQOZZBQOMyl6GfT15jK476iS8WMBuveTaPMRLHzjc=
Received: from AM0PR02CA0186.eurprd02.prod.outlook.com (2603:10a6:20b:28e::23)
 by PAVPR08MB10332.eurprd08.prod.outlook.com (2603:10a6:102:327::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:03:39 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::b4) by AM0PR02CA0186.outlook.office365.com
 (2603:10a6:20b:28e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 11:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Fri, 12 Sep 2025 11:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdWjOh1Iu/+SHQ/wqiEO3woAfGZrI6a5fiPoYzXhXcx/TkMHvUS2JLGxQshGI7ccmU9nhv6OQ92w1eF69Jx2mmNdMuR6BtY5zXmRveKPPz/3EVVhqbCTP2cjqrkGz6En3s5VLZl6m/Nn9rpU9iPiHRehcSSCTbNrAOzUKw3g1b4YdAPVgQ91IfKBRWSvaIJaqdR++m9HqvLRl6LxcclTpa9J1bn8O6zXt1dZiP9oepmtreccnwe962K7A7kMKZd3L1126q6iuLgYrZCWecnCTMe+ZepwbyKqrfVhDn6wrqdin68uVgFzNo4uOzXjLQ7mWE5ggtJOoGTasuB4WqO32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocYzZ3snhV0eDmgS6fVX2V/f+HEotsQWE+ixdkqvNik=;
 b=WFUdzPpepXvcdfPYTUyEhRUvxNCg0kgzjFaWjiiY4OzWr90NyPKuq0ZnEPe4yXNHFXr0cXz4o2UkOrUJUTgY9OC4exGktZWWGgfMH1CdIwQ+8LweO18WMxNxAgqpA3YFzZvxt1UeNAr3IFYqkvwFIcv5bT3Bl8USBCsFDZ+WK9UmJkqUegCxFVOGWBNiheoax7dcumMCs7vC2R6vKt9iUL0keAO92jyzBqfJEbOH88AY8JpUk8ppExlqZQwFbIPAbg48LULQNbllNE4cWFJ6YJtq+WUKZY4XJUDO/xojEQQXrQhJ4LCzMx52s/8P4GVEOyzNuqHstaQYUopvxfrJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocYzZ3snhV0eDmgS6fVX2V/f+HEotsQWE+ixdkqvNik=;
 b=e8U+S3TEzyXmaFYA7vS0hiAuohYBXQdvr8ZZwPezzGbhwMLdBUYueRHNW5czr5raDhmPN0p8RXHEka0XHvZaxqKjhbEMvN6Mk3Ab9LhLVtfTIWgtPBYoLxFZ+imRPdCx06iQOZZBQOMyl6GfT15jK476iS8WMBuveTaPMRLHzjc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB9547.eurprd08.prod.outlook.com
 (2603:10a6:20b:60c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:03:05 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:03:04 +0000
Date: Fri, 12 Sep 2025 12:03:01 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: Fix possible deadlock in coresight_panic_cb
Message-ID: <aMP95WqHyIQq8TcS@e129823.arm.com>
References: <20250911153315.3607119-1-sean.anderson@linux.dev>
 <20250912093534.GF12516@e132581.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912093534.GF12516@e132581.arm.com>
X-ClientProxiedBy: LO2P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::24) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB9547:EE_|AM3PEPF00009B9F:EE_|PAVPR08MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3792fa-758c-4d8a-1a91-08ddf1ec06e2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Mx3eFUV7KZKPGtLrpFeUtIecIubFwUhBz6p/pM7XFgKbifmz+1tKghaYSLK9?=
 =?us-ascii?Q?bCqO3zyjYHGyEksWQa2i5sNwRAV169tn3qYmG4rBcnx3J2OW+GRHzoAUaPB+?=
 =?us-ascii?Q?hfvcfQ8Hes6SfN23NgHv97PE3KhcxI2Rt/H8WUnApNqJtwja+DJl0ZDTw1mG?=
 =?us-ascii?Q?pUmEZBlYeJzS52l++qC7UBjJuRWnhncdc4Uqubn+rnemgh6VF5cX4po04EG1?=
 =?us-ascii?Q?9zjhl/dY9oLtuaqRY8OphSxb/wsaum7+3AKKH/Ff1yPrD2sDONImfp/MNV/H?=
 =?us-ascii?Q?mKoG7nZWuSUlK6tqg8mpbvZiZz3L4zl0YxX1MXMMVB49vx7p2LULb531mim/?=
 =?us-ascii?Q?gYFyf4lD7Gp+90p+tjwRK9CQZgkNxHWHSF1lfCW2q5HYy/WAujDyyT7W2xoR?=
 =?us-ascii?Q?Pg3zm4TbRwpfi5vY5GWD9ohL9nrQ0YJIf97oETNbKxdDr90ExTUhsALH939C?=
 =?us-ascii?Q?KBeYkFl2jcJWZ/QedKzk+iC7xHu33ITFodwIDmduNZCEMG0hj1JYVtbAOQhB?=
 =?us-ascii?Q?HtR4dwsIa7lImzSm5v4bDd9JQQ1W1ETJDFyqc3KP5ELdCcrR0MFnghkTKWFm?=
 =?us-ascii?Q?+rT9cQNDGLELgYQQMi6EraB8b3oPKIKWCFKdj4TmWJWlFgdlNvozbqI5MGdb?=
 =?us-ascii?Q?u3pY5+mLcY2HmjvHqIPYbxk2DriPX6c6nVR0drLsyP3vHRkHBGcf8xpFCPud?=
 =?us-ascii?Q?repm62EFD0FB7oGrz35FynNIu0iIaZWzC0nxhTNCDTqWMPNbkidcoTvf+8/5?=
 =?us-ascii?Q?3eaX3hQT4e6rWo6+tbX5bozXV+Y1hBCPzSni0jRuGoVqCieGxrxzGw6txYrj?=
 =?us-ascii?Q?iQzGg83/X7n9AvkrPo0quQQe19P21CtwTtpyFoLZeckJmK+ly65BFrHj8yqR?=
 =?us-ascii?Q?Dv3hZeTNxAh7MfsOTMQHePcMUsah9MOu+H6syYkDbjymyhsMCEvwB/mOahJV?=
 =?us-ascii?Q?0FIkTQB/0/fZJ0hTQMP2q5zz7orbufNdqWwD4Zsatzo0wST05H42oqkPALT5?=
 =?us-ascii?Q?dD6nIiVKKADdDizAd9KKAU4wq0G3gnR0QFynkWqdQJe0nON/COmGV2cRyhvW?=
 =?us-ascii?Q?FHWJatbZ3aXtHuzCjqDtVfNnLIs/tzuUC1oxTgllDSh0Ta2CSbGD/iI9gImv?=
 =?us-ascii?Q?MYlO4Zgi2wFO8G+MBiH0S+cHt/hUI550EBzwAbd8pg6CMpp/fu6g9mAk+olS?=
 =?us-ascii?Q?VhHue9KZU7dNowp0lSeNqRja4D6y+vmLtcPtaCHCfmfKUUojczbXS1Db1Upx?=
 =?us-ascii?Q?S2pjElRk9Mqv4hGARLCFvVhuvRIINZ2YfnrDlmnNOrlPlbeYWvG54dKNkLio?=
 =?us-ascii?Q?vOJWZz6o0hgrehLK33/gi1m1sWZQTb9jiVZQ+IOwa9AFlxPuDO6UaedxtwaV?=
 =?us-ascii?Q?nKh2/Jxqlx45dG1k23D5aKZxbg3csg3+NyF7ww8fJlW6/aq349yJfQmtL2jr?=
 =?us-ascii?Q?IezEE4n4t9E=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9547
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	deb6f23a-a3c4-4b48-96cb-08ddf1ebf291
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|35042699022|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O9J+0PnjmTlCBpwvZj0B+dcx9sjKO6uvKCFX1QgbSt7oLCdVkMSZZnVH1wQP?=
 =?us-ascii?Q?UAdAtUTiQ64VfHI88kR+RaHk+XY3MKgJp2MdYc5rnhbiW8om7kaQtuvqJYcN?=
 =?us-ascii?Q?ox99ZEwcAvv6yMZz0CS6J8cDbqnq5Q7+UvRsL3W/ryoKZTQ1pZb8VOLnVXbL?=
 =?us-ascii?Q?jPC8H/Wg5xgx+MXFdhbwvmA1EKRSAjREWmimoCjAF2UW2GdNTaQISYevzfua?=
 =?us-ascii?Q?XNuO8jtsLuVPvgDAbmCB9CoLddT0VEJnQQtwDbT/oj2XFZiMn7+xA7x/pXII?=
 =?us-ascii?Q?XsOAy2XP8wM0e3lZ78gc8ukahtCMMrOycYJs/QqoCWAi8xQPzVUQF/dAKvE1?=
 =?us-ascii?Q?dcqDofVjKqt2h9MJy62uWAA980fcLH5NnRoMKoKdWLs0c5OQdedkthK2Kf8/?=
 =?us-ascii?Q?yQp2yyIhcpB9hRlMTycZKNcIL7l9+QUfrKsp0iV+PpJzhV7sqT3g1vpqsXgw?=
 =?us-ascii?Q?m+BHoPdY169QgOOkC7CocTm0/Dw/8sZ3+9YqFp9KTLqxpFUi3HHbsEArPO+/?=
 =?us-ascii?Q?BpDDwjVeXYc5KfmTkcm4jy34sn6ks7JtmjULA6nbbdShbAHKknOUlheSWj2v?=
 =?us-ascii?Q?pS5aw4t4hkDH40ndFWq3BzNWi/sCAktAdFTiYPSbbU4M5dFyhy1p4If4NCp+?=
 =?us-ascii?Q?uSV25KhAZ8KKUdJuEsSPq4MDD9d84rufRZIn4QXf9H1KgVCZMVxc5CHXbIbU?=
 =?us-ascii?Q?W3M30K6P/f+qjMduMu5ZkwcnURy/IHaR0/dR+NUfK/kFZrkXj0cRiT3rNVxp?=
 =?us-ascii?Q?sNwGnQFbaXmeXfq7G2hTwufcxWZB9mQU8zloHKKc020oUKOlqbSOxZDKUSCV?=
 =?us-ascii?Q?jlQtKdEPM6A7sUvDyPW50z/jEOsuXtoYKSS5m0ThHf3bX8MP1pnfAAwj9xCQ?=
 =?us-ascii?Q?aqZLnkBQK2NnU+LFYAyhuAIBa8Tp2R7CZFOKYXwSnp/gR5uk3fQK9rTxqmMk?=
 =?us-ascii?Q?tFEjkAx6FupQ0F833/j7m1uRW6w3f7VEIqGCPLYp6VTLwFOJFKZi/mM2Hbus?=
 =?us-ascii?Q?uJ/D6pwxa0f7a5QosKgDYt67kgCKutmlzCuS6WrTBmBkwPWyzJ6jlN4qgvRy?=
 =?us-ascii?Q?zJ5rP5qphgj6idwJKCK2tXyYlAucW4dYT4fqDKUMZDZU9STUG6l6MlihRiTH?=
 =?us-ascii?Q?KFwM0RCTx5lFtN9O2Y2LmjVSNNf+8Xban5y432SVuIjV7FxkcGHuJ93Kyan3?=
 =?us-ascii?Q?ORFwmp51ellJjf5Xjl1Ham1HzgaqZ6Xt7vnf5M1fC8UuT7fGbP/WekzdLYSR?=
 =?us-ascii?Q?/SlXSDmwatIAnTPxuJ2EFHbL4OEPo/PemR/hB9W6mqtwVGBIuNiaH8fWLZnZ?=
 =?us-ascii?Q?Wlsi1p/G4VKV72LhmbRkdjtRKrhFR/EP0RmywCtdC9L9om1tWkHJcnXTrI2Q?=
 =?us-ascii?Q?46CbgAtAyr4k2IVPai/XhrKGBfeHNuXMkV7kDmO+WiORHFKnuBqeN5lQM9Wu?=
 =?us-ascii?Q?Qt1CeIzf9Zgc7eyds0YJ4raTget1eGXfU3MMekWuHKrTCddVQdES34rUmddJ?=
 =?us-ascii?Q?H1M0sPubhwu4M5+p2xTFM4s31gYHVRO7rans?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(35042699022)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:03:38.5540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3792fa-758c-4d8a-1a91-08ddf1ec06e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10332

Hi,

> Hi Sean,
>
> On Thu, Sep 11, 2025 at 11:33:15AM -0400, Sean Anderson wrote:
> > coresight_panic_cb is called with interrupts disabled during panics.
> > However, bus_for_each_dev calls bus_to_subsys which takes
> > bus_kset->list_lock without disabling IRQs. This will cause a deadlock
> > if a panic occurs while one of the other coresight functions that uses
> > bus_for_each_dev is running.
>
> The decription is a bit misleading. Even when IRQ is disabled, if an
> exception happens, a CPU still can be trapped for handling kernel panic.
>
> > Maintain a separate list of coresight devices to access during a panic.
>
> Rather than maintaining a separate list and introducing a new spinlock,
> I would argue if we can simply register panic notifier in TMC ETR and
> ETF drviers (see tmc_panic_sync_etr() and tmc_panic_sync_etf()).
>
> If there is no dependency between CoreSight modules in panic sync flow,
> it is not necessary to maintain list (and lock) for these modules.

+1 for this.
and using the spinlock in the panic_cb doesn't work on PREEMPT_RT side.

Thanks.

--
Sincerely,
Yeoreum Yun

