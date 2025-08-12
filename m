Return-Path: <linux-kernel+bounces-765603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 939C2B23AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5DD7A53BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972732D7383;
	Tue, 12 Aug 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qElVVzuq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qElVVzuq"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8022F067A;
	Tue, 12 Aug 2025 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034086; cv=fail; b=Xm2RhPTIqm1+8XaB//6ntysREPA5n49kg/xqLRojavbaqg4b+pA6jQpgWy9aWL4ka2MHxLTtMU8LXGH40PILKY8Byb+ZeX96nQiz4fz9iFJlND3TiDslF14GpqQ380juzLVpnIUi049PgZ5OPgOy+8qCWp50T86uc1lIgFqtGlk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034086; c=relaxed/simple;
	bh=0JIAlrahIoJb7vyj3+4Bn+Rx3tUFGZvO3fHQ7vDOLPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TsBFIeikPhb7DpmPKl088q67/m4wiMez2BCrMVQEZCr6/nQueKQjomN5gPtKXNzEgk18yzSuWeOuAZEGBhxST1nfkIfp+TMktsllzAf5biten+cxXmvvXPswGLHqpN6p+2Ur+D9DU2Ao29ukGIq0gY8g+IpijJa8DrrCG82dH0U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qElVVzuq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qElVVzuq; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sactH41ffs2HHpqpTQ6tDSbWDSQeT8BMY/edLg6fEJPAza0PZlY1selk92fdMLi4bpo5GnhIiCuraXg5oW4VYAdnltgA4Eox2bQIvUqQi6d9r1WQ9QsPtXG4UWX9ulKgH39boBTdCdXu5nvWdvTKwoa07UO57mPYoopoG/OLIzt4u1HiNStXwBZ9x5BGWyUf0a9qt2JKXVtg4NxNTO6JTDsSG5l5ucw2chvuMsoTFES8bjoS9V6nKS/a1i/sTqAh4b5+SrcWR0XKSFu1Ehex452wEJSJT46f/xAlCzgNPAaYVvitOE4j+jloT/xNnoBxZZqK5/zUiIyW9382ZrQnqw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JIAlrahIoJb7vyj3+4Bn+Rx3tUFGZvO3fHQ7vDOLPY=;
 b=WHI8bB6NjIuTZZKAdoSHn4nKAUcPkVGkZSUMQN+XIjWU4FC40iHb1taQNVlv4oKQh/2CkiyDdXd29FAvgQGC1jSsh0AgTytS6vQTmte/9yMB3uxxItrTkUiUU3DizrJ26OneV8nZI+vi9ILJG/tCN8LKJEKoiBawuVgmNXgcQP8CAR02pVC7Bqs6VAmQMMR9rD5c6sRTPMoX7wlAzBhhwS19E+nSmKYzk1o4uNM06McHZMVX4TBXoLQPXAgR6DRYYWVn9tlVcNviF2mPkqjhMiDbNxecmhXpKBGIeomUqhXhs8Ixcgo0cYO79NMbZMxbO7lmf+WKYgO+P2nRzBVPFQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JIAlrahIoJb7vyj3+4Bn+Rx3tUFGZvO3fHQ7vDOLPY=;
 b=qElVVzuq1sdE28a2JJO8ztdnAm6Gdcly6ojxt+b2iWrDC+pY+lsP1/3Z8ccrRz6oo4HuBi7l3aJ+pKygVdH7sd4PWrbYenTK+Ol6kkUjszg7QsohrtsH0F6/yrcrTOogJt/w7Z3bRaJbJGImWNOk8eInHfQAFTWmfTXzWTsZSAc=
Received: from DU7P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::32)
 by AS2PR08MB9618.eurprd08.prod.outlook.com (2603:10a6:20b:609::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 21:27:58 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::43) by DU7P250CA0005.outlook.office365.com
 (2603:10a6:10:54f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 21:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Tue, 12 Aug 2025 21:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9iAaqlNao7VihahFm0lxi44+NORtmKvL69h6RPx6MemJA6CZG+n20xPvf+5+77uWjFSLxWkNRWSYfzKpCCa61j1/F6DRI/aXAvQGZrxEs4g7pKi3gLQu1igSpxmyxVnGDqpF5SfZUe9HDwIpEY/UE9SdhJI14Sc0bz5zsNgjc+Vh2woMwUZFwgmSWNiYKj6RfWrsDKUpjLz1nu4OZSp+OPWt4dc8WPBaPUmgpqzYrlRMO+C4w9PerCBovElW7s9DLe+8ztRXTJRjmkIBZIiauzDX9GbLjg2Xf4cqAiSUGIK/+SFahuFHFB5TVUFO3tp3cMFZrzl1IHv59BDVp/h2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JIAlrahIoJb7vyj3+4Bn+Rx3tUFGZvO3fHQ7vDOLPY=;
 b=UZ1DBYYlY/n3XuqKqfWn3az4AL9N3o7yrL3eLxpkZ39iFhwL+b5Oh9lKnGNVvWsQUFUaV4Gsb6JpAfQhRxoxVyXFcWaZ9cc+NreXOuogqgjqui7jA5tjnGWkyw6I2YmHo8FdSuHJht75dqyxHjB5ZKkemJd3q9tfpx4LL7gw+AbKyBq/RsVGRTLyKsrLp4Lr+Gd0hv1nScT6g6nX1dlAB1Uon1uSisTDMnKtyVpFNmT4y20ySvsp04AXtU3S7yj3SnMny93kmsM79OZ2gZIiuuj7j7VAPy9bxoVKN809yV/M1V2Sk3g4SZoebxAWDIJwjsC0rKHr3luZLXiyLKRwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JIAlrahIoJb7vyj3+4Bn+Rx3tUFGZvO3fHQ7vDOLPY=;
 b=qElVVzuq1sdE28a2JJO8ztdnAm6Gdcly6ojxt+b2iWrDC+pY+lsP1/3Z8ccrRz6oo4HuBi7l3aJ+pKygVdH7sd4PWrbYenTK+Ol6kkUjszg7QsohrtsH0F6/yrcrTOogJt/w7Z3bRaJbJGImWNOk8eInHfQAFTWmfTXzWTsZSAc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB8PR08MB5372.eurprd08.prod.outlook.com
 (2603:10a6:10:f9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 21:27:24 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 21:27:24 +0000
Date: Tue, 12 Aug 2025 22:27:20 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com,
	will@kernel.org, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kasan: apply store-only mode in kasan kunit testcases
Message-ID: <aJuxuKBm9qfpVkBC@e129823.arm.com>
References: <20250811173626.1878783-1-yeoreum.yun@arm.com>
 <20250811173626.1878783-3-yeoreum.yun@arm.com>
 <CA+fCnZeSV4fDBQr-WPFA66OYxN8zOQ2g1RQMDW3Ok8FaE7=NXQ@mail.gmail.com>
 <aJtyR3hCW5fG+niV@e129823.arm.com>
 <CA+fCnZeznLqoLsUOgB1a1TNpR9PxjZKrrVBhotpMh0KVwvzj_Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZeznLqoLsUOgB1a1TNpR9PxjZKrrVBhotpMh0KVwvzj_Q@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB8PR08MB5372:EE_|DU6PEPF0000B61D:EE_|AS2PR08MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d80ff8-cd54-418b-1cff-08ddd9e71b2a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?UBEVAalBsjrxdPVLcgMjSg3A3Ls3mUg1dGo2YV4pV9KFB/dNzNvqUK8Z5eag?=
 =?us-ascii?Q?CCpD/r7GM/reXXqdcfzddKaqLob08JLKeX1Gc1a6KaewVkdAqXOaUd2EsOp3?=
 =?us-ascii?Q?yKpVgJB0+LAF94CnJfpVwopnMn0/p9jl9DqBeyBEibrvLVafB3oUYat9Lzi9?=
 =?us-ascii?Q?+PlboW5yyPM3v8R3tF6ZyHiRL9Exitm4zZdijmjDyRibG9NHC3a7OCT+u8oK?=
 =?us-ascii?Q?7jqBCFDT56QbaRNqpO1kHPx7/srpjJdW575kB3GQRatg1PdC9cj1S/SN0dT1?=
 =?us-ascii?Q?oXX8XU5BepLrvBr467NFhUMMmG/0lbcjUeaP6kKJUIIvvzLdfUXq5nIMeAHl?=
 =?us-ascii?Q?lcwPfxAjQBhFD6DjXIIRr+1HSuPjbNH8Lx2HDtTiICoh6uHlwsTWoP66u9mS?=
 =?us-ascii?Q?Gv9iYhOL+P/08QzaoOlSxSXG4ZlYOv0eFNYaRwK/+xB+DDGIGUxjI66RUba0?=
 =?us-ascii?Q?KYxnvPEj57XUCmmXTK/4n6LPwJeGLRS9ps7yKIdCB6iWkQEPqnyeBzqSW9Cr?=
 =?us-ascii?Q?muTnQ8Yn2OgxJcVs4ryzYoFiP7CctFKmTZuDfeIXh3CLI2sL3QheIATDhNnU?=
 =?us-ascii?Q?aMB5dgWZryDv9GCa0zPm8/K/KkJisw9crdjQ5/aRRoQ6P7ZtaQh9aTGBDiGW?=
 =?us-ascii?Q?wk7f9zF4m9CJnHSc/SkcHUQl2NqxDP66qDwKTgaQKDJolqKLD0fwA4yoolaK?=
 =?us-ascii?Q?j19GtYi7m4QLndpEeLRQA8HYXEPwZstJablKY2MJVkoJLIRfIr09SQ6xcU8a?=
 =?us-ascii?Q?nuRiQwaT/4WkvAwYryFTA6ZdxvaqXZfj1ExBEHmlpQhVtEvAvBDnxQ4QaP22?=
 =?us-ascii?Q?aW1cJY9aepQKQdHtEDJCp5ltyWSilcVYrTqYnmdf/Nx3qVc85EXd0sZHjr+G?=
 =?us-ascii?Q?VQCaXhQ3Q4HeHKnxy053s1kJDrVdAJ8+Z0TDPYcl1NeK9OubmP/nlumGRN2I?=
 =?us-ascii?Q?ykvMIeMRXmskv+veOJky8wjqIhCBNrw6YQvMEJSPQn4rFIMOqJi8+OVjL9GJ?=
 =?us-ascii?Q?l4R+qv3XgIrY0PrxBG8cN0CNEDgQh+Wtf5eSdBDnNHeRH5Aqqx5qxPv7kOMv?=
 =?us-ascii?Q?HRcEOGvfUAhYAEnZklTtjQbFrIvcAWoAv8J66SuxbJ4N3BttkJFh9l3D5+2Y?=
 =?us-ascii?Q?pduIyHlw6xHnIORZWySnmW76irQrh79993lISc6hh7NylrDm571z9iGg5+yC?=
 =?us-ascii?Q?13eDgmhUWu6KrV8rf7dVY0munn7EyfPpo9Db9pVi95hs+Ibjp+qTtyuquUu/?=
 =?us-ascii?Q?jefIyg240LuGywBV8u3HG7VKItQZZYB3d6eBG3nnkGySAxVgG1AZFr9LT1wJ?=
 =?us-ascii?Q?K25+EkavAe2lkdbMRP1RNncem0CcNKxIetUpvt223kMpZuck2Skc0YRlSMG/?=
 =?us-ascii?Q?RP4C3ztLydD7+1HZxijUKwIvgeJFOgJ8Ct+QcD7kgg6na65ekfNeSUFJreV/?=
 =?us-ascii?Q?3t8YLeDx0ec=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5372
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d8123d43-a49c-4054-1cef-08ddd9e70727
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|14060799003|376014|82310400026|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?31zhvKgLcGkV9ytnAPiPKDt2w+LeHWdzDSF/vS8qa1M3cylfFbNTo3Sc4XzG?=
 =?us-ascii?Q?ePmLyN0iPLNBey9Y5WMK+WxpemV2SrQCiXg+CTbcbo1OG4Sv8mEL2kjj8GpR?=
 =?us-ascii?Q?Xidj90Xppx5hCo1V55YBk4PWYQLpcxbHoYSdFMW4lkRJa8wX9r/DO1ukRDbf?=
 =?us-ascii?Q?odu+q8FZHFDTpDV8EY/HqgwPxCRjHiZLYlTZZmcnydjTYO7GOnKCbDFWx9kN?=
 =?us-ascii?Q?S3YWCcYZVj9zuMuVsbOYHNo2G7M0hXZBw1rPDITnwCo1wKyLiJ8is6+ylapH?=
 =?us-ascii?Q?X7VZfNlWC6uaX2FAKzPo0jrFoAdlpLAWaUwwOjcowj9aqNa36l+Kbzvh5ZAu?=
 =?us-ascii?Q?z1xOMwlFu0uzN2AfcTU/XGx4VLlriCboHKLnvJzTp9bMrSNpwD5ybqgr148b?=
 =?us-ascii?Q?c4lxgLs2zHSDv86qpZKEYDrjk1jaTM1WTFOPvV7XVk/3PFx07LMgyMQZztL4?=
 =?us-ascii?Q?xhmq01PEH4Z65E1L8M/GD5Ptu1BDO5D+wy31MCLrC3hXikDWTij6o2sWOl8A?=
 =?us-ascii?Q?hYIY5PmrWC1Cn5WUz3m1olgLSEzd1C6n7gvzBCqqbAhcy9vNNB2bDPlZFLqE?=
 =?us-ascii?Q?7upGeVw3lyDwu64sR6QeWXgUd3JwSnH2MfmZYOWt5mu/zW4a1+HNXgP3Nzcf?=
 =?us-ascii?Q?ep+yE8+s5XBDDDEOzhyhmySzHHAiaXUunlYGoKd2Hlpg7RCx1hC5q3LmisUx?=
 =?us-ascii?Q?HQ8GYPoA55fYuA0HSpOBsCsGDmCHwXoWdEHs6qxBthK3yCjVK1qcgyEJ1abY?=
 =?us-ascii?Q?4zqlqto6Mfr/ZCSKIHkIh0WVOSpJFcpnz2HNdCe2SpD1aWy/XraCfLPDybpI?=
 =?us-ascii?Q?/uU8p7jlyos5NbC1M27Bp+YU16ILuvgpE7hvvT7i+9BaMVwJG9XFaVDi+Dxt?=
 =?us-ascii?Q?aer1ZASEtZviv3BSS6pLlkH5p6De34ra4txkz0nTw/zam9wQke5vLuq535aO?=
 =?us-ascii?Q?jCKFMxezx+FlKNsQ4IP4nKBYsxRJxfhCeKZ32SEvqqq8A0KFHsZ7qs/IUXKY?=
 =?us-ascii?Q?BMWHzcnj71PkNzfoMiCtf3muS8ckb6K+UyhSulz295wx9Jmn+JLuDLL3D3Ze?=
 =?us-ascii?Q?B9+u0Y3YFy1J2aZhulmQ4vwTWpeHMQYDagjPTv7+pOUVZZDN0eQb0fpsbvsA?=
 =?us-ascii?Q?LRYjJgbYa7W+KUsQ5C7IybivYbOVWB/3xHrt3Kq6neIO8Cnz82n+BWv2qCTc?=
 =?us-ascii?Q?3hVD4fjDPzKvFr9SE7SWLcZDhMOfb5wwydVe0RCB/EpObIvkEyKK2/wUyeEF?=
 =?us-ascii?Q?ylJWuv5tSGOQ/YgAUiqPE6nMW3Uweus/o4Nnghq8Jn8sLLY9A/WVFVnz7a5H?=
 =?us-ascii?Q?GquCZQ6yMqvbxdIacmupADm1CDb0qJG/KxFV7+PXQqekNU+M5X/yaTrdPFxg?=
 =?us-ascii?Q?WcLcwVAxP0B7ySLZh1MIM3+e4sq0BQp5iPjw/Ql/G9XhX1Ts9ZbQrdUKDJZh?=
 =?us-ascii?Q?lLQ2gyn2Ly0FfDIvgavFfEYRrnUnMie4IyECJjcvr7wSN0RGt2Pc+0pmju4e?=
 =?us-ascii?Q?MlWD2/PeDWJFoIRQFZfibQWdhK2VZR4FHSIP?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(14060799003)(376014)(82310400026)(35042699022)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:27:57.1824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d80ff8-cd54-418b-1cff-08ddd9e71b2a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9618

Hi Andrey,
> >
> > > Right now, KASAN tests are crafted to avoid/self-contain harmful
> > > memory corruptions that they do (e.g. make sure that OOB write
> > > accesses land in in-object kmalloc training space, etc.). If you turn
> > > read accesses in tests into write accesses, memory corruptions caused
> > > by the earlier tests will crash the kernel or the latter tests.
> >
> > That's why I run the store-only test when this mode is "sync"
> > In case of "async/asymm" as you mention since it reports "after",
> > there will be memory corruption.
> >
> > But in case of sync, when the MTE fault happens, it doesn't
> > write to memory so, I think it's fine.
>
> Does it not? I thought MTE gets disabled and we return from the fault
> handler and let the write instruction execute. But my memory on this
> is foggy. And I don't have a setup right now to test.

Right. when fault is hit the MTE gets disabled.
But in kasan_test_c.c -- See the KUNIT_EXPECT_KASAN_FAIL,
It re-enables for next test by calling kasan_enable_hw_tags().

So, the store-only with sync mode seems fine unless we wouldn't care
about failure (no fault happen) which makes memory corruption.

However, I'm not sure writing the seperate testcases for store-only
is right or now since
same tests which only are different of return value check will be
duplicate and half of these always skipped (when duplicate for
store-only, former should be skip and vice versa).

Thanks.

--
Sincerely,
Yeoreum Yun

