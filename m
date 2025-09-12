Return-Path: <linux-kernel+bounces-813382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655DB54460
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915C51BC2D95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E82D47E2;
	Fri, 12 Sep 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="g7R5X4SJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="g7R5X4SJ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CCA2E401
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664234; cv=fail; b=aay7e5ToIB6BKD0+6ADnjgh+tOG+7Mq8GC64Ib0srkKUSCx5kfa9NUowqIeOFKwBLM7YK0Ff/6HUGRuZVHqv4YHhfBJ1eOVGPn1oqnftIF0mbw+a5kR12c9bGqw5wmyMwellpn47SWwX4F2XxXSnkWa99LXVkJl8Q0DHKQNpCrY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664234; c=relaxed/simple;
	bh=zVE1h8u0woWrRe85YaelJxD3WFeksJhMtV37hve9A8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LEfqvSMyGF4s09qobpagIyEfreHXTemBgZDaNthCWtCVNxUnGj5Z4VTRx0ddl1wcJm5JCuWk3lRfMEmukHFNvOPlRJbcME78M+h6z9t9OiHwqPEUsY7jpzHWr0VJVCsbSYZfM2eZ00g0gL4olpQLMJgRPQvRFzIcpYsf2+nRmy8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=g7R5X4SJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=g7R5X4SJ; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RLVBExFl6HCZnnrFCADT/RIM8V6owj1NBEKQ5EsnTaRivpyevb4HrVAG4r1FsFM+RRvdjfKnHdMjTIaDMqfkIpOWmAHO14qkbfTjointXxGjKfWq7W/nAhSfcBIATFhoABsZYKOOalf3KItnwcreyr7XOQm5V5wQnurKe8fF+DHka/49Kwr5TTOmjhrAyIPdZOR0d5TmUzYsQyvc+Wl7houbweBqeQmLXh+EdAmehol3eubN8BDNHgozkuvBjJraz5ZEMD7ailtECdP4pneis8R5bzSc0W8eM9Jr07/sETg6p3CnWOWZ5gv5/Sat0mwjc3QMnzsYT6KH/nWtcNi8+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0gQ0EYx6Z/KzcoWWirgejzRG5r2D/KpE9gEuk+s6Cg=;
 b=dOnf3enH62RRhmqEO+ZPaqQxr5AmWb60ooPqjUhHEzv1ufUwSm/LxYkEeNgyqz7rGWGW6QbO9xA+cSDhjuI0ucnggQMSL97DFyiCwExGZWEdymp05mJyZSRfc6vT7UQ5qzJvxCwBUvULEYQpisz0CbnogNl6m1c7tLcyCygAGmTmQL996LzUMJ5noDsXlEApHaVC6UPf7uneJC0d2T/ZbtnMX6zDqb12YtxG6owMRDUML8Wb2ZYhN/UxEEoagM8b87z76IhHWUjFxewilj0Q+b4+EpFO7jxsH4p6HQF5RgcPw0vCUXM6UlqhsXLwbGugMociGCL4zTHFSkrH9KDNBA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0gQ0EYx6Z/KzcoWWirgejzRG5r2D/KpE9gEuk+s6Cg=;
 b=g7R5X4SJSXQvIJxPN5MwJWD/TS0M3dRRr9/E0HCUhxQSTuLTU1aok16kweojF2DWeDIHtMjgSiZSaRNhpGcDFqkRuhyzFQ3/HG1vu4Cc3gBSvHDRHR2Zn7Zi+lj9KgttAebujDo3zaE8pElVjvYLPxvqRVN4ci+R2CYsnk2MbeM=
Received: from DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) by PAVPR08MB9140.eurprd08.prod.outlook.com
 (2603:10a6:102:30b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Fri, 12 Sep
 2025 08:03:40 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::fe) by DUZPR01CA0004.outlook.office365.com
 (2603:10a6:10:3c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 08:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via
 Frontend Transport; Fri, 12 Sep 2025 08:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcXPQ5FDHJ8y2t26sD/UYl9kOcnup/zS/gFiJ8dsb/n57bOPmti4HQNrn8hrrW3UM41YbdUbA7JH4poKGIjL2aZ2pAS6wMCR3RbM9BnQcbYej3WQmx56oljOPw6M2FhIYsKrtovoOCE0ViCqeTrzycKpb3KtLqSF8sbO6s3TgbO3SAS7Ue0ofAuHLfM3yNli8JJGYwZhTAdTNkT3nWu95KFkKnQbU9BNc4XGzfH55OKEqBVEabB0MERIIdRiGl9Gu1/BFEyb9mjvcy2OPD0WoFJamhcbkOCVEZ/BYoKqnAUNeXgoDSTVeKjqUgNgC6egYkG7EWM2QZD1k4ZUorL6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0gQ0EYx6Z/KzcoWWirgejzRG5r2D/KpE9gEuk+s6Cg=;
 b=SQFmYog0wl3/M7tqzaJEPWR7lvs+OyYhV2+IEFZNDDbTFAPSOitkgDGb6mM9Zokjk09Ve1cgvQn1CRMjUsSotokgc4uho9/cgbWb+BO/moOM9v2iViZZKDVfvlI+Q1KTGByuLk3AKvV0EQFqrqc1DE1YuZrUVDJ3cDct/Y8kDiTjPr1lxDZ1crkyKhutg+Q8N/X1vNxlR+ZiMOYjOeVBcYG+mVX587EMagvzK2MN8OoRjPHPJugfgojiCPCnM5uys4nXQE6v7uCMoWvMDD1tBzeut6nsoBvB+7AO3eBXeZT8wnH9edp0I1QOhkTPcboohnfZLM4r8zHMivynaPGiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0gQ0EYx6Z/KzcoWWirgejzRG5r2D/KpE9gEuk+s6Cg=;
 b=g7R5X4SJSXQvIJxPN5MwJWD/TS0M3dRRr9/E0HCUhxQSTuLTU1aok16kweojF2DWeDIHtMjgSiZSaRNhpGcDFqkRuhyzFQ3/HG1vu4Cc3gBSvHDRHR2Zn7Zi+lj9KgttAebujDo3zaE8pElVjvYLPxvqRVN4ci+R2CYsnk2MbeM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAWPR08MB11143.eurprd08.prod.outlook.com
 (2603:10a6:102:46e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 08:03:05 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 08:03:05 +0000
Date: Fri, 12 Sep 2025 09:03:02 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64: mm: Move KPTI helpers to mmu.c
Message-ID: <aMPTtrP07Li9uS2Q@e129823.arm.com>
References: <20250912073908.404924-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912073908.404924-1-kevin.brodsky@arm.com>
X-ClientProxiedBy: LO4P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAWPR08MB11143:EE_|DU2PEPF0001E9BF:EE_|PAVPR08MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 675ccc84-4477-4c71-5391-08ddf1d2e19c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?7Q43oivluXfg7+qg5U5bw5e7Xy3dyDd2CeAxO/WhCCUT4FTjxAMq/RE3k+6/?=
 =?us-ascii?Q?mWMAFsZ79j5r2OnldlQWKwJRRm4358+e7HE6AHocB0TNaB+fqNYi77qYg/Yr?=
 =?us-ascii?Q?Ygvd7C9VwKeT4MEItcAyXo0w5G9NOcJZ+8MR6BFuWNcJQcT4yXzx9/pVWjh/?=
 =?us-ascii?Q?eVZyQu8YWxr65sl+bpZBtfvzYfvJRS6RI6FSlmOOqRpiBitFf7/5KeF09GNm?=
 =?us-ascii?Q?fCTLFNgaTcQ91nJwlr7Ln4VjerzrfpymBlC87LlM3HWgnrBcUWH1dzVD349j?=
 =?us-ascii?Q?dybmcFEKJPWpNxMZQVltYLC1xZ5biH2SyrsbDh99ARow0CYr77P4Q0JaHZy6?=
 =?us-ascii?Q?ON6XpZoCY81sPHzQzJ6pj3/zi9auTqC2v7BIOMcsJmdnFkNfr0o4ELWi4gzK?=
 =?us-ascii?Q?PSlGE0+LqEkxQG/9ulYbkXT8Oa8x2agRnqIQohidSm7S+aXh+wnEDHOXhSMd?=
 =?us-ascii?Q?O7f3gh/WoZQQHPl9Y3as8+mbXRciiAMJ5hQoiDYJacZt0qb7b18bFokfTJ2f?=
 =?us-ascii?Q?etq1t9pa2zg6jDaxwJ8q0FH4DmIDOlgEaraN2rtmZIRGJ8ohBqvLqa8oF7Zq?=
 =?us-ascii?Q?d+N0QOgGoXcXw93VmOgoAB3S4qjVLlC/AJmbgdCC6xB0tB2Bp+P0dWHs0QbG?=
 =?us-ascii?Q?JiZsH6xDdw5UxP9S486iH3LgcrKFy5MHFk8HYW6s7gQhRPaa9f+U607lyA+q?=
 =?us-ascii?Q?aslKdNLd/6Abr/mi4dik1uK9rH2HZCnbWZYU72/o+i9sW9V871OxAtHmItBp?=
 =?us-ascii?Q?5On9n3a85lWGwV0nwErdjYf/VW1RQlGUpFcWXydxquoFjiDVefWLBg8r+YGj?=
 =?us-ascii?Q?VucVG3+ec13cZ4gipOS8/H7T6PbMFThK5Zc60RyzuTQYx+O6+uyuM6DvjbJU?=
 =?us-ascii?Q?KoXY6EI7noQwMQc7wzW55h4K88PuZzEDBDg1RYR8gNMsj9e10UAYRTqgiJpa?=
 =?us-ascii?Q?wRQylKwvNQsXkN7V1A4qTDx2Gt0pfPsK3Q7JEdQZKEtHSx6uty6Pg2j7nCKA?=
 =?us-ascii?Q?tf8S+V4JKtfNMJePsRNop1oCkaFUK51b86jrGXs0JyLfxLstLbgeXwv5rMcu?=
 =?us-ascii?Q?sdQjvCiAD/0ZsigSxMq2mAV2I9ZoQMHFguGfAuu16u8nP9qjgWRL707Jm6nk?=
 =?us-ascii?Q?KkPoT9qQAbbrkx+XOmkUT8g2fTNGWfghpuSmQfg2NHOHICB8XVKIXuOHBnwq?=
 =?us-ascii?Q?jrvh4PpY+KqqfUiKl0GOS0G2X7szlBciEizTZY+uM1cwj4gKuZtrjRa/4mG2?=
 =?us-ascii?Q?98OiUwdSmwUy2VxLgqW9NJiFQ0GnhQ76SBI/fnSarjqMP1A2ljHl/vqYw8k2?=
 =?us-ascii?Q?BSPxsdCOfNdMtUGvdcjkei48GRAsRi13mA7Ke73LcSOoLYwZgsF8Z1MCb+fT?=
 =?us-ascii?Q?+Ceml4NcULJnds70J1OoC0XHQFcBMLFiP6mi55ZpNa4IccyYF61ldBIp8ryw?=
 =?us-ascii?Q?+2IyYjnvPAA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11143
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d68d8307-3c9d-4a04-fb9e-08ddf1d2cdb8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|14060799003|82310400026|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ERKABau+RAvOgYEzUUAodjd9ctesCs6v7CaGvQMgK6fu2hehiXM7YqXmMg0?=
 =?us-ascii?Q?wsJyT7QgC0Bd1/OcMAuuulDtXquLTTzaBxaelEP3X/6nthQ7Trr+R7tIxdAA?=
 =?us-ascii?Q?+xTiIEtZ3cqot/lBs2OLTgZfQ3Oslc728WW3wr7q9Yld0ReKaRAd0owu/pzD?=
 =?us-ascii?Q?yejzE2CgdjvqUUTAfpbujn4/zTMIzmqN4x1o3V41J3OAVk1hF/O8ShJGoEJc?=
 =?us-ascii?Q?fj97tQeHletlmoOJwu4DAOzGLEAnlnHtEitIx4qaPsXekhspLMlU88qLQcS9?=
 =?us-ascii?Q?OjdzELPoV17Algc3mU2PM0vmE2KmDW0phacHRKzo5RXJBP1hz4QFC5HIAcvJ?=
 =?us-ascii?Q?ko3wiphS6xzddcg402gNXYpPkFzf4TgXlrrPNVknFNsVc5c/+ADPIVu9sStj?=
 =?us-ascii?Q?zun8DDU+vbIRjCy5oRRcwthUPR55OyqR/11vVv0Hx9vLkwJK9pW1FnX8oXJm?=
 =?us-ascii?Q?xhgavVt80n4uBe7GwaO3YrsBRRF2m4oUdK5lA+0Jk1NFoflkJZ18G346EjTj?=
 =?us-ascii?Q?JHZnAXepvBJz5T++U5ZK7c4FshXkRyA68YPNLe/eg/0unlJMcbvFikarXXk1?=
 =?us-ascii?Q?UGLImlz9NzXH4q0RIQJhh8FXBuhqCXOoOKtDEkQPXpiBCerVT/Wa0mAkkjDq?=
 =?us-ascii?Q?OSlRLUMg601/LcAAScYvjRzZ0V8ZPv4zfwjZADrLr6e3bZg9fpY+4mnaYwOZ?=
 =?us-ascii?Q?sbFbpZIWCROKMGtccvbCZVMwBG7BpSyJylSN7Yjp95To7M2gmc7xc2a56UeD?=
 =?us-ascii?Q?mUuDck4c1ia96GPQHasMqwjDOljWLQZg2bak9jakETposDQzAb0vrjZ5VH9X?=
 =?us-ascii?Q?0YnC9HcbIDqS9gR2DLs8MoLByJyXlkZs8D2GYfvHMg5b7cQ3cVj7+8LfD/wK?=
 =?us-ascii?Q?i4+HOfg8pinzQUtLRRN2sX4X6VqBSSA7ScfW9lVaztNYGF69pPgaVwNdcjwo?=
 =?us-ascii?Q?No1ibmwfjfjSjRG4uYrTEFTK68ypyhOd5jSa3DRf77Lth0O1rXoILR6+zPY/?=
 =?us-ascii?Q?OYeKlliCNvnGa7TP4QDYmlwrVT2/aVhvaoictWeMaD0nf6W6DdDX0zOtVA5R?=
 =?us-ascii?Q?u8YCGpmqUmDiW12fR8Wo6JdrLdetGZLV151hARpeQdMr7d56YvZVTTWHjzdV?=
 =?us-ascii?Q?4E9b8zltAMe40kgn0zUZ4D5PfDVIkzMy3XJFXBFrHIKaLirrrKSF92LvxCjH?=
 =?us-ascii?Q?S6UX68h1ZxPfgu9YIIhTrzDMnviYtRqZbLJ8l34zY8hkhDMTR8TYkT92nWBB?=
 =?us-ascii?Q?Ya+Qvk2Nn3r6zHWlXeE0THuNGIQWaEnYdp8pcWOp25alJ2OffSQr0gUiU6T9?=
 =?us-ascii?Q?GuZdtKuWCbMiK0gt+DCp8aTRBAg6q5E6TL1/5mHeC49N0GUmivp7I4ri0Zhk?=
 =?us-ascii?Q?x56Um4M+zCiAa9oqTCuyzXjLl6ny1c45qaxZiCOl+McLVt5LVnhNSusWAIJV?=
 =?us-ascii?Q?UQIFZc/KUy/BrBjYp5gXrUdp+LDNbxga0FUeD9LOGd7LGyLTK/rrVWfjk15Q?=
 =?us-ascii?Q?5iCfwK/wiLcydri+FVPJGQs7uclSokOUUG/q?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(14060799003)(82310400026)(35042699022)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 08:03:38.5934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 675ccc84-4477-4c71-5391-08ddf1d2e19c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9140

LGTM.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>


> create_kpti_ng_temp_pgd() is currently defined (as an alias) in
> mmu.c without matching declaration in a header; instead cpufeature.c
> makes its own declaration. This is clearly not pretty, and as commit
> ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
> function signature") showed, it also makes it very easy for the
> prototypes to go out of sync.
>
> All this would be much simpler if kpti_install_ng_mappings() and
> associated functions lived in mmu.c, where they logically belong.
> This is what this patch does:
> - Move kpti_install_ng_mappings() and associated functions from
>   cpufeature.c to mmu.c, add a declaration to <asm/mmu.h>
> - Remove create_kpti_ng_temp_pgd() and just call
>   __create_pgd_mapping_locked() directly instead
> - Mark all these functions __init
> - Move __initdata after kpti_ng_temp_alloc (as suggested by
>   checkpatch)
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
> v1..v2:
> * Removed create_kpti_ng_temp_pgd() instead of making it a wrapper
>   [Ryan's suggestion]
> * Added Reviewed-by's.
> ---
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/include/asm/mmu.h   |  6 +++
>  arch/arm64/kernel/cpufeature.c | 97 ----------------------------------
>  arch/arm64/mm/mmu.c            | 96 +++++++++++++++++++++++++++++----
>  3 files changed, 93 insertions(+), 106 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 49f1a810df16..624edd6c4964 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -104,5 +104,11 @@ static inline bool kaslr_requires_kpti(void)
>  	return true;
>  }
>
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +void kpti_install_ng_mappings(void);
> +#else
> +static inline void kpti_install_ng_mappings(void) {}
> +#endif
> +
>  #endif	/* !__ASSEMBLY__ */
>  #endif
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ef269a5a37e1..b99eaad48c14 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1940,103 +1940,6 @@ static bool has_pmuv3(const struct arm64_cpu_capabilities *entry, int scope)
>  }
>  #endif
>
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> -#define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
> -
> -extern
> -void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
> -			     phys_addr_t size, pgprot_t prot,
> -			     phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags);
> -
> -static phys_addr_t __initdata kpti_ng_temp_alloc;
> -
> -static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
> -{
> -	kpti_ng_temp_alloc -= PAGE_SIZE;
> -	return kpti_ng_temp_alloc;
> -}
> -
> -static int __init __kpti_install_ng_mappings(void *__unused)
> -{
> -	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> -	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> -	kpti_remap_fn *remap_fn;
> -
> -	int cpu = smp_processor_id();
> -	int levels = CONFIG_PGTABLE_LEVELS;
> -	int order = order_base_2(levels);
> -	u64 kpti_ng_temp_pgd_pa = 0;
> -	pgd_t *kpti_ng_temp_pgd;
> -	u64 alloc = 0;
> -
> -	if (levels == 5 && !pgtable_l5_enabled())
> -		levels = 4;
> -	else if (levels == 4 && !pgtable_l4_enabled())
> -		levels = 3;
> -
> -	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> -
> -	if (!cpu) {
> -		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> -		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
> -		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
> -
> -		//
> -		// Create a minimal page table hierarchy that permits us to map
> -		// the swapper page tables temporarily as we traverse them.
> -		//
> -		// The physical pages are laid out as follows:
> -		//
> -		// +--------+-/-------+-/------ +-/------ +-\\\--------+
> -		// :  PTE[] : | PMD[] : | PUD[] : | P4D[] : ||| PGD[]  :
> -		// +--------+-\-------+-\------ +-\------ +-///--------+
> -		//      ^
> -		// The first page is mapped into this hierarchy at a PMD_SHIFT
> -		// aligned virtual address, so that we can manipulate the PTE
> -		// level entries while the mapping is active. The first entry
> -		// covers the PTE[] page itself, the remaining entries are free
> -		// to be used as a ad-hoc fixmap.
> -		//
> -		create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc),
> -					KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
> -					kpti_ng_pgd_alloc, 0);
> -	}
> -
> -	cpu_install_idmap();
> -	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
> -	cpu_uninstall_idmap();
> -
> -	if (!cpu) {
> -		free_pages(alloc, order);
> -		arm64_use_ng_mappings = true;
> -	}
> -
> -	return 0;
> -}
> -
> -static void __init kpti_install_ng_mappings(void)
> -{
> -	/* Check whether KPTI is going to be used */
> -	if (!arm64_kernel_unmapped_at_el0())
> -		return;
> -
> -	/*
> -	 * We don't need to rewrite the page-tables if either we've done
> -	 * it already or we have KASLR enabled and therefore have not
> -	 * created any global mappings at all.
> -	 */
> -	if (arm64_use_ng_mappings)
> -		return;
> -
> -	stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
> -}
> -
> -#else
> -static inline void kpti_install_ng_mappings(void)
> -{
> -}
> -#endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
> -
>  static void cpu_enable_kpti(struct arm64_cpu_capabilities const *cap)
>  {
>  	if (__this_cpu_read(this_cpu_vector) == vectors) {
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 183801520740..6a8e831b2b63 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -27,6 +27,7 @@
>  #include <linux/kfence.h>
>  #include <linux/pkeys.h>
>  #include <linux/mm_inline.h>
> +#include <linux/stop_machine.h>
>
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> @@ -466,14 +467,6 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  	mutex_unlock(&fixmap_lock);
>  }
>
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> -extern __alias(__create_pgd_mapping_locked)
> -void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
> -			     phys_addr_t size, pgprot_t prot,
> -			     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -			     int flags);
> -#endif
> -
>  static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>  				       enum pgtable_type pgtable_type)
>  {
> @@ -735,7 +728,92 @@ static void __init declare_vma(struct vm_struct *vma,
>  }
>
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> -static pgprot_t kernel_exec_prot(void)
> +#define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
> +
> +static phys_addr_t kpti_ng_temp_alloc __initdata;
> +
> +static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
> +{
> +	kpti_ng_temp_alloc -= PAGE_SIZE;
> +	return kpti_ng_temp_alloc;
> +}
> +
> +static int __init __kpti_install_ng_mappings(void *__unused)
> +{
> +	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> +	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> +	kpti_remap_fn *remap_fn;
> +
> +	int cpu = smp_processor_id();
> +	int levels = CONFIG_PGTABLE_LEVELS;
> +	int order = order_base_2(levels);
> +	u64 kpti_ng_temp_pgd_pa = 0;
> +	pgd_t *kpti_ng_temp_pgd;
> +	u64 alloc = 0;
> +
> +	if (levels == 5 && !pgtable_l5_enabled())
> +		levels = 4;
> +	else if (levels == 4 && !pgtable_l4_enabled())
> +		levels = 3;
> +
> +	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> +
> +	if (!cpu) {
> +		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> +		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
> +		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
> +
> +		//
> +		// Create a minimal page table hierarchy that permits us to map
> +		// the swapper page tables temporarily as we traverse them.
> +		//
> +		// The physical pages are laid out as follows:
> +		//
> +		// +--------+-/-------+-/------ +-/------ +-\\\--------+
> +		// :  PTE[] : | PMD[] : | PUD[] : | P4D[] : ||| PGD[]  :
> +		// +--------+-\-------+-\------ +-\------ +-///--------+
> +		//      ^
> +		// The first page is mapped into this hierarchy at a PMD_SHIFT
> +		// aligned virtual address, so that we can manipulate the PTE
> +		// level entries while the mapping is active. The first entry
> +		// covers the PTE[] page itself, the remaining entries are free
> +		// to be used as a ad-hoc fixmap.
> +		//
> +		__create_pgd_mapping_locked(kpti_ng_temp_pgd, __pa(alloc),
> +					    KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
> +					    kpti_ng_pgd_alloc, 0);
> +	}
> +
> +	cpu_install_idmap();
> +	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
> +	cpu_uninstall_idmap();
> +
> +	if (!cpu) {
> +		free_pages(alloc, order);
> +		arm64_use_ng_mappings = true;
> +	}
> +
> +	return 0;
> +}
> +
> +void __init kpti_install_ng_mappings(void)
> +{
> +	/* Check whether KPTI is going to be used */
> +	if (!arm64_kernel_unmapped_at_el0())
> +		return;
> +
> +	/*
> +	 * We don't need to rewrite the page-tables if either we've done
> +	 * it already or we have KASLR enabled and therefore have not
> +	 * created any global mappings at all.
> +	 */
> +	if (arm64_use_ng_mappings)
> +		return;
> +
> +	stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
> +}
> +
> +static pgprot_t __init kernel_exec_prot(void)
>  {
>  	return rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>  }
>
> base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> --
> 2.47.0
>

--
Sincerely,
Yeoreum Yun

