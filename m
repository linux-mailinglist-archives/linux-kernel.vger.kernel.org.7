Return-Path: <linux-kernel+bounces-739890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8891B0CCB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9843B4DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5028246776;
	Mon, 21 Jul 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LWU8MdMq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LWU8MdMq"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B6241676
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133782; cv=fail; b=it0vHef/EThLvPfzVhNhLnK+hLhcFDr6Wes+zODfBaW+9HFUgFzl+SiJueS1ZSVYw+ekUOtPzMw7FlIPeToUzET0kKbPMKL7K8SWM6eXY2GqMoo8D4v6fvT6zchbLZZrmA6MAA9X2IDumVp+QM7XQ0s2wQmD30sJTDMbYoWVLNc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133782; c=relaxed/simple;
	bh=nIcvoA4m6gC+lh+F8QaTrlSGNHfk005QfRndWWnc2Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pxVtwdQ7FX5xJfna02JyOkVcgOgFKCX82T+w9be458NYakImBcUGNYObOqbSfF9U+hQr3lAqbsgyLDjNejtAYy61z02dakRg1Pfh+vk07GEfORr3GUefrJERSntzqmSp5g+JiQsGNy5hH99jHIeQE0nqD2QrZ4yvW99gDSZlHqA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LWU8MdMq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LWU8MdMq; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OJNyQota4Uu8wVh1xSbbcpoFljKG/YfGUfFKu9AC2Y956A9MnY8jQRL0iQxV0IoO4Y0qo3CKw8lUjq+du7snJ/58YN6ZSnmQFQRqYjtk8ta3RY+Yez5rTEiMXzsh/m0qlA7Mtmgd1E58JAuCTCHzATRffBUYl7h7Ql0NMhu+1z2LJ8O0uJu0etki0M3YEm1ZK6sdu0DnmvnLHIhPo0c9VdPFHl2U01+ILzfJnRTNkeayX1cHyJoi9H43AHcaZQVDcBKeU1G224eJd1R0iQP1W7pQwSHple3zSiyjGkYqc80j/IK04M6YOYLVW4mj9qER6dGE/CA9aRh6gbbysG73hA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETXsHPCqdHEXLeZqHnJ6k0Uzh4a65ev2efYeCUg5CbY=;
 b=fuouPr9vmjJCoej/HtmGo1GI63HyoafFRyCqYu8A0111js+r11V6uBI0Ux0hcR37RkE6soCtYbMbaJ6cN/PLbkhmOARiEc39enbNB0Kmw7E0HDaDxb01AHFNouTPhl/1PBNb1sbqzvUW3RpjVbl6uAXMf1NG3IHYif8V3xkCNkPz75qnV8x3sB5+cB+U/K0mW0yMN+smD76wmWFr1wGKxdMnJ9lTkQaf9ctiYn8ikI4h4Z1ck4kJ+wPIJ7xAMgadL2oPVupX3HqqPKU/yueDBP75Y02ZwgPGWELIZrR5iRWbnpso+rv91g8LuAP48eoNWosKaVyf9Ydga2wyoteaoQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETXsHPCqdHEXLeZqHnJ6k0Uzh4a65ev2efYeCUg5CbY=;
 b=LWU8MdMqdD/J9TJfFD6y6ZoQJp2+dBrA/xi/Hn9zm2Gg1bz/DnCP4e5sQUu9LBLUYraCero4yDd6s5QxPQEpo+HnrkCyrctWdtIjHCH/Mx9r3wqLtAtrNB1pD+izg8pJ6mFTX5bZ86zRMZvWBCHJvi2TWmclKi1kCUJ28DjSwfc=
Received: from AM9P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::28)
 by DB4PR08MB8054.eurprd08.prod.outlook.com (2603:10a6:10:389::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 21:36:14 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:21d:cafe::13) by AM9P192CA0023.outlook.office365.com
 (2603:10a6:20b:21d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 21:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Mon, 21 Jul 2025 21:36:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4k7nDNiyL44AcvF4rWzsbf4jJ2ofPZ9kpfPN8WmoEoulPGo/Vda8XXGI729qiJEW9D9OKk4egdyzEVKLpT5h9sNfCCmy1UM489tjMs/bm6QK6ijs0GJ4uGLQekKWjT8YfZSsiJK6AXCAddBg324pay6oCAldu/zIpWleeLsJrbP0tTF1db9LWKsUpsCl73qxXC/lEi7tXV+MOFxS4LBb2H2EzGSbt9pFx0tgz/UiFJhwoF6e2ZegxaT/YEF2sEKqh0q+mQoHIN8LnflZkED5g4cSTGVif9kdVWhFQf0uOY0J2O49xSYXewsrhqwQ8mRi1CaQxhwypiEqvLihcOe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETXsHPCqdHEXLeZqHnJ6k0Uzh4a65ev2efYeCUg5CbY=;
 b=exQJPL4+c5sC7s0fhWPfsICnfjtPMncMBHUuRUuZu0vRQ7AxnWnCNq8pOw4XERcblI4Pf3XuspAyjx7swCwx6t73vnSQDfKvy72JSPBJOwvniL6hzyuGG8WKx/FB9Y5v5zsuuAQaxoFRDqP9SSANmCB9JvWGIMSnleCJr1ME+1hdkbIC3Leag+UD0nNRZamXHR8tUY/TJ58MtziI9PF3yISGdDJSslTmxBF4/hqaM1uOfZLmMJKRyqWULPqySoBbMhmHC5+bbU10jRBgQ8GpC83wDpC/lBhINOrPFxF3H31THG7xD6xiMzM3X96EZa9bX9rmjGPqKWzxE6213nS7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETXsHPCqdHEXLeZqHnJ6k0Uzh4a65ev2efYeCUg5CbY=;
 b=LWU8MdMqdD/J9TJfFD6y6ZoQJp2+dBrA/xi/Hn9zm2Gg1bz/DnCP4e5sQUu9LBLUYraCero4yDd6s5QxPQEpo+HnrkCyrctWdtIjHCH/Mx9r3wqLtAtrNB1pD+izg8pJ6mFTX5bZ86zRMZvWBCHJvi2TWmclKi1kCUJ28DjSwfc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by PR3PR08MB5611.eurprd08.prod.outlook.com
 (2603:10a6:102:85::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 21:35:40 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 21:35:40 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/6] drm/panthor: Make MMU cache maintenance use FLUSH_CACHES command
Date: Mon, 21 Jul 2025 22:35:27 +0100
Message-ID: <20250721213528.2885035-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721213528.2885035-1-karunika.choo@arm.com>
References: <20250721213528.2885035-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::15) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|PR3PR08MB5611:EE_|AM1PEPF000252E1:EE_|DB4PR08MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f5557c-fddc-4c6e-b405-08ddc89e9da0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?M2xe41VCQL0nHo/XZCrOKhA1w/YPoUXgJpCn2Sk+JRUAlc1Wv++JQ8Hm12xw?=
 =?us-ascii?Q?RTxXDf+xc/JhBbn1y9O3ow2Ht4kxVnTrnMN9F4sgpm9SlFeHLS4jpaBrGnkJ?=
 =?us-ascii?Q?cxXFz6dTb1YcN1+v0DcgF3G5zenwVmfI08ZmegrlPCPh8VZaAAyE634jS57A?=
 =?us-ascii?Q?d+U+5eqpGsBVBn5BKlNvzXFaamiIGFCRBT0vAFd04L6gi/iY6XcniUH0PcxD?=
 =?us-ascii?Q?6I1cdl7rXWqxGIGLtFIgNKv/fvaq+OvgUER4C4rbth2zqtvRfeSESQ0LDpVE?=
 =?us-ascii?Q?PTUso+JgYOUK9pZU/KYIxA0MaWrJC9SaS0w/jpI2bdidHYa9O0fir9SvQlMu?=
 =?us-ascii?Q?7TIzWnkd8fNwH+oNStVZHtbaYpQLk75iU2wtEpq53XYv8GlRof5HJk7VCT5R?=
 =?us-ascii?Q?dpG2tktJZPfesMEaCMJ7aK/gbC7t6mHfZGMMHUI3hXrnOHAftqlCSD+lphwp?=
 =?us-ascii?Q?v5WKhQAPVzbGdfgQWNBXxn66iFa2fOhGBgzqPHES+D8cNIyMCXGeqvPhYBEg?=
 =?us-ascii?Q?26qCz1hrCmrSDXhd6UUpoWli509zCYnaHqSD+/eLXrzTD6L4GzJi8+1miapA?=
 =?us-ascii?Q?/Yz0mVrm3+b4DWGQi1DrF5vEcu4n2vCOfLTz1k0MtXaFN9AkmYxDfCjpKnwT?=
 =?us-ascii?Q?clGM+dZb8RGJ0fZSZ9fqXS0paqLWSABDeb/jiI+B8BTjEWOSAZLy4mcI9VVm?=
 =?us-ascii?Q?fLbPnHh7MncWyQOnpGV6VLVr3jebNW9lmZvPH1VGz/efP0/Jzb9eS6ydXGoq?=
 =?us-ascii?Q?mB+fbkiIi+cZXei+xqdO/gaxNEcx7jmHVldBKiy4UazgKr20dp5iKE/vFlQg?=
 =?us-ascii?Q?vfG4iHSbN3G7cappdLAkyuRCbuZTH0uAHm2olKnYbSwWSC/aAv8agWzOhWbv?=
 =?us-ascii?Q?KIt8Hg7YZgOV6jwbX4SMH1Rl3OsYdtlzvmRfWo+B78k569om6+Qg4KdDPj3/?=
 =?us-ascii?Q?kWg+0qAtYIlFU8Er7yLpi+DtoJ4xN3sNP4fX/4AL8LWO9Bqv8HAuV2MihW79?=
 =?us-ascii?Q?IGukPxsXTwE/bky0+3ibKST9JZpz77sPABvLyNPqNe61n8GldgfWrslpR76e?=
 =?us-ascii?Q?oSuh0fq74US5om3QHJGb4bm9YikazaR3UetiaI5ykv1GZfpruMECYW8v1ANl?=
 =?us-ascii?Q?fhSvTirWbgNjMfB1JGO5DdCblSo1Cxw1bH3q6TPYOVOBYsNaYHnn3Ols3hsN?=
 =?us-ascii?Q?K2SLZHJum4yW+A12OaqhZwPsXdwhhbqtuIJYvm+soOZCPPsUhS40FyoRxJrn?=
 =?us-ascii?Q?utjz+Pksy96r7hOuA3dF4I/X0AJeCdx7ToQ10Cg/yvOX1sXgRo/nCbJpGKh8?=
 =?us-ascii?Q?ScXfZ8r9GsaKxKwJR22q1RYj887Nkkffs8EqxucHvMRb94sJYxU7VOf2CGkr?=
 =?us-ascii?Q?XyLmOcu54kvYIZeoQU5AHHMEWkyNk0IDCnvzyFVaf5p5yiSoFw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5611
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e39b7fbd-331d-461d-fd18-08ddc89e8a05
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|35042699022|1800799024|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XrnQsk6MjV3FfPutZ5mg5kmaAiayrLxc+ghN377vhn+l4GlxQZCRv5ohdkpv?=
 =?us-ascii?Q?QVClSg41S/oEM2bjs2uR4l6ZIe/PBdooIa+SZKBtvgusyIj1FxCkuMbJ7wNC?=
 =?us-ascii?Q?gVfQC3BUr95BA4Se2BLHCz2mKvaTPXaK6CQXn4syDdzr3M5Gs1VcILXYoPfp?=
 =?us-ascii?Q?+RttoGUEj97Em8atHrWDhvH4v0H6a1NBjGkKjrzQA6k85h9tuWmsMcbmGOYl?=
 =?us-ascii?Q?DB+NNpJAGG0+g0+MIoZCQXJUimb9hQq0iFIJ58WkPxBPoQ2afqBBbG6Hljit?=
 =?us-ascii?Q?rwgdZJgCAj60WybIKGTZVmKbPCkSq1joZs9JNPtnxx3XMVda3s5MO5n1+03O?=
 =?us-ascii?Q?VB0C89sS18CWlCVbu0yNeYkZZ0L2a+8mc23h6hG2lqaGzzEvEsyPTgydlI//?=
 =?us-ascii?Q?uArmaC+rX0bLDm5VpPkkmXv0W1H7uCmUVSgVwSKy6ExqUmTCJQoJhb1R43/V?=
 =?us-ascii?Q?digfh9Ve2OCwdgWYAn4NVQhA6Km8DL1IIiHhNj/6BtrZlJtOtT3xI7dIWXMK?=
 =?us-ascii?Q?Rqm9gwVVl37rgY49DfZ5hRqTawacv2tWUu9k63ePUJfR4ilLBaDqmsOZjzEP?=
 =?us-ascii?Q?3l46EH0xeVodOzZCYkhVmqagqH6k86bn6wISqmNa7xBjgij0dabUKGBH3HSa?=
 =?us-ascii?Q?kgneCZVaoKcvOBt4FyqIZTnCiiJSL2AlFHEoHNMOJ+XEIO8asaNhbBh0nN8H?=
 =?us-ascii?Q?TmOj6DEhA7+lCz/81Xb/FJNj4RYiWBAITr39BEk1hCU8W2b1HHNwlR2q0JMY?=
 =?us-ascii?Q?Mxa8blYjeSVSYxHFatS0+Ao/5YwDfrJ+Fqr4flNJ5blSC0FIhQCBJXzwYrq6?=
 =?us-ascii?Q?o8cUTf6av2LbSNRhdDUZ0YyIU7yQD0nHgZnMDjI/LYEPNjFUH7c4TkKlKnlk?=
 =?us-ascii?Q?H6UGkDUOyraLv878TG8u8EyIx3ZudVHhwpl1Ho6Hrzuz/G855aNqw3d18scu?=
 =?us-ascii?Q?IeuphsaamxL99lHdyF5oqjuOkQ4q59+iyjzr8BpWHKPWDKU+W8nd9fSXg83n?=
 =?us-ascii?Q?ZswsjY/gB573wcahbmiy0RPiS8zDOV+Ml1Ir4MDwinw8MyCtbGBGYpQzqg7t?=
 =?us-ascii?Q?JJ2VCyjt21eoOHQzVPeHcM5Io5hsxUDsNeu+QHfJxzOh98zX7fLa5OjImaCq?=
 =?us-ascii?Q?9mEjENT0aNTVHUk46AV3wU0m+wN+jmdxv8H/BoI8znj+HHQObYnFga63/YsF?=
 =?us-ascii?Q?YTXctDTWXBWe5/KK6J127OUo6nH+Q7xrR4uOccXReMO/FZnM7t0C75iX1x5Y?=
 =?us-ascii?Q?kk77ZbdpkJtRI6sYz7rYYyHAa/dY2Gbwb97s8e7o/BcrZ6nxtoweKK3v8agl?=
 =?us-ascii?Q?GXBBHTIYA6lJBvhLH/6Z5+OdXHuMApr3X+iypektDFMbcW9HhuYGuv6OE+Df?=
 =?us-ascii?Q?htbXt+EfWoBH81QJCovU+6s9BRs3TMGMRGc3i0Cj6tX7IS3GTHciQz3IkUxJ?=
 =?us-ascii?Q?35+XrUe0D4QuM+ISZp7/+3Bg8MFlURDGy2ongW24VRlkTH7jzmhfBuyl9dRn?=
 =?us-ascii?Q?JrGZzIQw+4vkyWR3snNqziTlKHvH8PfiiXAO?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(35042699022)(1800799024)(14060799003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 21:36:13.0521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f5557c-fddc-4c6e-b405-08ddc89e9da0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8054

As the FLUSH_MEM and FLUSH_PT MMU_AS commands are deprecated in GPUs
from Mali-Gx20 onwards, this patch adds support for performing cache
maintenance via the FLUSH_CACHES command in GPU_COMMAND in place of
FLUSH_MEM and FLUSH_PT commands.

Mali-Gx10 and Mali-Gx15 GPUs also has support for the FLUSH_CACHES
command and will also use this by default going forward.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 4140f697ba5a..367c89aca558 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -29,6 +29,7 @@
 
 #include "panthor_device.h"
 #include "panthor_gem.h"
+#include "panthor_gpu.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
 #include "panthor_regs.h"
@@ -568,6 +569,35 @@ static void lock_region(struct panthor_device *ptdev, u32 as_nr,
 	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
 }
 
+static int mmu_hw_do_flush_on_gpu_ctrl(struct panthor_device *ptdev, int as_nr,
+				       u32 op)
+{
+	const u32 l2_flush_op = CACHE_CLEAN | CACHE_INV;
+	u32 lsc_flush_op = 0;
+	int ret;
+
+	if (op == AS_COMMAND_FLUSH_MEM)
+		lsc_flush_op = CACHE_CLEAN | CACHE_INV;
+
+	ret = wait_ready(ptdev, as_nr);
+	if (ret)
+		return ret;
+
+	ret = panthor_gpu_flush_caches(ptdev, l2_flush_op, lsc_flush_op, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Explicitly unlock the region as the AS is not unlocked automatically
+	 * at the end of the GPU_CONTROL cache flush command, unlike
+	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
+	 */
+	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
+
+	/* Wait for the unlock command to complete */
+	return wait_ready(ptdev, as_nr);
+}
+
 static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 				      u64 iova, u64 size, u32 op)
 {
@@ -585,6 +615,9 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 	if (op != AS_COMMAND_UNLOCK)
 		lock_region(ptdev, as_nr, iova, size);
 
+	if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
+		return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);
+
 	/* Run the MMU operation */
 	write_cmd(ptdev, as_nr, op);
 
-- 
2.49.0


