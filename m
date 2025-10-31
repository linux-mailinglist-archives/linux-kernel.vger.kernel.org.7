Return-Path: <linux-kernel+bounces-879295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 345FAC22C57
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1EC4E70A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ED951022;
	Fri, 31 Oct 2025 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NTXBzAuF"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FBE38D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869650; cv=fail; b=qHdQ2kFgU8Wxx0vs7Ehe7juV0TFHYvqm8AdCZrVGNN0HHBGT/XROUI/SHXmw53pXXzerjDSboQ8YSR5RiseASKLinNb9Mi+ObDruNDOrrqW3B3hxxPYIBtyy15G5POm8EtTjwOFmfsut8JoRsQMfdZ1EJjpFgAYVJ261ixdKWk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869650; c=relaxed/simple;
	bh=Ze29Sggupk739c3AjgeRmSGKXiKX4i0foX6H8FoZ+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZPmjdm6CcecuRUIz4eviTctgvzhZtKnwlU1Q9xyjrzY10LsFjUFZfYd2P5hHxMVdN9iGW6rJF9ioAWsnFuhXtjudI7KlzYxQ68J/dTBG27s+hth9ODPTWRtOq7sY6r05LNkHstypoAy4rcUPFtwsLJYOfQQkm61sM8NG+dUegs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NTXBzAuF; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVcK+o1EYDgF4R4QFp2FQat4EIV+56OSDwloGulVVNOQHHR0FEXZOW4Xv1N4uhGZGNbOurI5j0+OChrpRUgqkNUiGWD37phMmxxsU+bKA/wOKG/T4Q+UKLQh+r+AuC2Wh5lOyJzOdply7MpvAubnqHQ2xpAtVNglJ4un+9pb4xJf8zi5kQEIf9UpPrCAZCi5u9MK6AhPXBxXu3tLz2vhV/MvL+IzDSL3Wg48xMA4UIt/lx14eS9LulRltH0Nb/Qur0OzRN/k6sxO8mcekGUARimvPgSuWetCrOmdMmt1TwxzaI0yIzV5O1MCm1HPM+nZNV4Bgc7LOD9r3C3bIdsfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olRZfqBaFxyNIFGjsi2S4H3z4LZWtLCNSHqvmDz2fVE=;
 b=QdE3KpF2UNvuSpIq35X80FNppyuApIhilwNforNGDPWPLCzbZTiwP3V4UfIBsN8AHQZrxWQhVCyfKvfcy4Ma1g4+vls7hagDojC8daffW3e9AedxykmuBweRy8n3m94EL+0ulIy0pv9oc3/xQFdLeE3SqRL45CHJAalRBDWLWm1ZxGM5HTTmHIjujGum4GtQkiwmPxlkR8yo4gFSWAtVvUfeFE9R7GXOlh1Zi0Ec7thExfZvBAPdG1KSU9sIR44uqwIoeQGBeoI4hZuEs7ElYIspFs3X5wJwqrNvXt/yF38Vw9pFEn65sZElkT6Z/X3eviMl0an+xmuGCu6j++yAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olRZfqBaFxyNIFGjsi2S4H3z4LZWtLCNSHqvmDz2fVE=;
 b=NTXBzAuFNnGntuBF6Dio3B+DiJg68Fh5xkWHffe4hskYM0ISLSPNwXPyFgVBvtepa89vA819VEeKI20Z/VNOAUDmF0jBjWK3nLJPZ33b7mkPwOH4HYNKTKunAaQ2UQeadwd8eP+mQvvAuUlbwp8sdbAcC9Iaq58A/Wz1p/aW5ap+yI4ly2gJEcyWEoEC7BD3/7Na0C/gr7Mg0Kd5vW3XZSJa5zA+X0yUbuw5pe0zawpZePX6Qz/90/KVOfc8+2eYnvnqSaLOGhvt8aesW/Cu3smtdjrAE8HHoQTR7ks4brgcsabFnEJLQaDR310I/75OTlF4SxzhlbTw+Y8mziNwBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ0PR03MB5869.namprd03.prod.outlook.com (2603:10b6:a03:2d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 00:14:02 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Fri, 31 Oct 2025
 00:14:02 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: dinguyen@kernel.org
Cc: khairul.anuar.romli@altera.com,
	linux-kernel@vger.kernel.org,
	tiensung.ang@altera.com
Subject: Re: [PATCH] Some subject line
Date: Fri, 31 Oct 2025 08:13:55 +0800
Message-ID: <20251031001355.49874-1-khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <4e60eee9-5afb-4c97-8c05-96ab39da62b1@kernel.org>
References: <4e60eee9-5afb-4c97-8c05-96ab39da62b1@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SJ0PR03MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 15915fb3-b9a1-4616-b71d-08de1812648e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZZTcKU/PMTQxkYzajkiGiyu7PSNhqvOrvmVVT1fdqymNaYtQ9+OXPiS5Lp2?=
 =?us-ascii?Q?c7nsgnCHJ+qPGTsNr7E4S85XobxDXQfbXWZPWvDwmZqGfNzIDpAdfQetj5/L?=
 =?us-ascii?Q?5iDoZbmorh2uSswXs4KOkSbbKbnNKl6HitnaFluTAVKroOX8OtzxqIezXZh3?=
 =?us-ascii?Q?0oQNK4qUDWFlL5KiWn2R+2FjY/iHJHU3UmC+TJEMK7GKCNuf0I2gZJmCWJKJ?=
 =?us-ascii?Q?2oG2DyOsZYa0ttRcsmds+Wo0Vz4rSBOpUauMCe6nD6W6VAMy8FUNpzMcJuOZ?=
 =?us-ascii?Q?tWH4rzEKazCVLpw8MIohNSV97WYzmS3xawPu2T7K66k8RqYALXhAnKI6IFkF?=
 =?us-ascii?Q?jA8MBFE6gIkErqzCYMFRdfWwPDbKFb/Olj5ZkMhZYUzI6qXCcKgsKcytNhA5?=
 =?us-ascii?Q?QwAmWRxkXSLQVBfDTvmdfCoxPH9oTIG1dhxc/h8ZzwDqM7bustepJvWiwmdf?=
 =?us-ascii?Q?5X/CLOtK6AIfA+JQwN1AUEVp9C8U5F9hILqPnTUzgeNXnROnX2iKZRK5MnEw?=
 =?us-ascii?Q?8EvcC4VzxQySZhTCRXfGUzFoa5q5ocKu1UTtjHxAR8kSnygBuoLLAmRUG0bx?=
 =?us-ascii?Q?pfMyCYh1BvA5jOjx+7yZYnZ2JRQR3ay1axWtjbRx1hkBGFKtbZKZ80S2YgHs?=
 =?us-ascii?Q?LhwVJWE/M0YcgZ+HoeM6JgNOSoFTkFQMhaG85whc55lQ6mjft/ev3eU6ZDgN?=
 =?us-ascii?Q?ayAOA/bQLbAXuLjkw+WPWMLMH1vHxCSGPPGtid9R8/t5aTJG6Nxi0PHi7hnq?=
 =?us-ascii?Q?KCnxRBeapMuAxGs6fz8+fRF5JfkVPiF1wfM2cvNlIywr+fmbrfb3YCFKBsli?=
 =?us-ascii?Q?Wh4PbkzxBoPchHx+7IjOOQ+YNaCZfaMI1e3h9toxY3BQcZM5+XQmDx3Az2nt?=
 =?us-ascii?Q?c2Nh0HjnXR3SoWCTjTV0PwLiNuwrxRlGnTZ+BI4YPRARyenbgBNQ1Pfy366X?=
 =?us-ascii?Q?22d8TM4/X8aHwHwtYpyyVbZQUteH5HsLUUgDfAPxb6Ag74fhcOpsTjn5ZPZ3?=
 =?us-ascii?Q?7735ErzCu6Rsi5rIg/x79b/JBIveSKa8TRowIxQw1JLMUJjDBEkgWtWHCP0v?=
 =?us-ascii?Q?Fgj44DzeHHRaQKxn0rxfAn0dYGp7WjsbokBPMx44+M1W/amr6Pd88X0g6OvF?=
 =?us-ascii?Q?sRQ/mzsBXIjG6xJ/GtYVewArZNuPSP3mnyk8ARZyoFtf4rTNrypRGmkqSukM?=
 =?us-ascii?Q?N0+Z9M11KSyxgCW/mfylrnl2WPWvU8t5jVYSDUUNIgowBr5CtR4LacqRgt2h?=
 =?us-ascii?Q?u5w9qlEXXpbOn/JDgU2Q/y8KbrNoCw11VXCBWjjuYYnWc0da7D+VKm6poBIP?=
 =?us-ascii?Q?MR+ohOCgF4OkgjERnmibo6gCUoUKknHVTeFDjQfAJb6MdXKMoqPHP3cnS3JQ?=
 =?us-ascii?Q?ZnjD6YiEUQLfIpvXwDqB2ktUybbQEA27eiCY8+mW81uMdb895C9lW6vXczhD?=
 =?us-ascii?Q?DnGci4i6V0mPucK3jM9hlF+2/RIjCBV5FCkaEhaONtDaW1i2siBhSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mopzEPoHIGdgvAPBY9Ktu1xRIDzMC7HSmJh21eiZWoLQEwV8BDtSToiC2rSY?=
 =?us-ascii?Q?F66j2uvEOmn9I6wj0+KwnWsq5meN4bdMfS4JUYimvOb2sD18kaRooSFT72n3?=
 =?us-ascii?Q?QWkjxxbQ/ipxPSk0xpuSa2pLC1HozkIItu3EdL6bbgeOUPwOOqrShzcqjlXy?=
 =?us-ascii?Q?OhGAML4kFArW1iH7xS+EgpIlZjanV6MGia4DqTRts5dQHQxBzVrbURldqKJp?=
 =?us-ascii?Q?Col4oOYcAM0JQpkanjN7j6YcT6m8sr53DobOX+sGQzRdblpXtbzbHbP/GUzl?=
 =?us-ascii?Q?8H5QZh9PRXp1TWt2apcRPzMmApANgM7C7uNS0vMehEleqLsao5kO72GCuCTW?=
 =?us-ascii?Q?s6H+Q5HPbkZsF8aPSeE8RuNEj3S/P8UZiwU4nP22VD3jSuaXVUN2KtLx8ekU?=
 =?us-ascii?Q?0GSrBk+8X+w8rlNtLKyb0tEYzMTRd0s8F+wgBvBDJ1WCDjY2SpYJ5s8FlyCY?=
 =?us-ascii?Q?SCCF6ePyb1Su7X2mC+mBtIxzqRcSMFOyT+wW/mWSR2v6N9+V2/jv2MZVj39t?=
 =?us-ascii?Q?JdYfBXbIKY/sWXolaD54Kl4tGq9f4DZNsEkWGsy70UWdqwtm9u0CaAEOy9PN?=
 =?us-ascii?Q?NTMK2nPuGr3h6/zCFb/rZ+4Hhh3GJFrtw5VWxd+Z7Nqc1mkIXxWlsgA6dAzY?=
 =?us-ascii?Q?Go/UIbhwdXVYI+xoD8C5HU9FQ4o9ab8S6RKBbL8H31I4Zu6nvkzvbxkCyWlC?=
 =?us-ascii?Q?Zr7mDTGDZd/D9yqa5GO7aQoSj6V8AHhmd60pF/koBap7k1nFrQ7vvHF5rtYO?=
 =?us-ascii?Q?DFR8NrKRUxcbXbdcYZ+FWbu4zCUKh68gc7PWraf4cMUaUtdreMWZyzZHvQ4A?=
 =?us-ascii?Q?L0Syxecvau89yJjlU2+lzYqiU2t8elUfPI6bFUaXf+VSgp2Har8Fq1N7sitQ?=
 =?us-ascii?Q?2AvsvBTqWIgeFUO7PHH7dqZUXEOAfTXs/29DanIDkAsmdXS5FE9qpYUBd3eY?=
 =?us-ascii?Q?5oaOzkoC+4Ti5gRpD/KGHCJgoacW9pJl0Os8HDmZEqC4xsUPvjWOl3wtDNCC?=
 =?us-ascii?Q?U/yXYZvU0VHEI92JtWdldQWWZBhGREMyU/4JlQLH7RsESzI45y2KUAv9TEmj?=
 =?us-ascii?Q?RpdA6FktwTLXCxqdy3uYUMnRxWPbwHJrB8vK7OP5XEQ4skksm1yNoIuTee08?=
 =?us-ascii?Q?qOX114KGKGcsWo9gpZ0+ITBI+FkM9LsiEiEVY1LAs6yrO+6LUeF6cMuxBKWZ?=
 =?us-ascii?Q?SH+UUkB+sR4UjiWFUdDZIIGKtu3ooyMmE/T+f2/igFgvRV9JduWW+0jeHIUZ?=
 =?us-ascii?Q?JuOCGHXPmvqazO192aJP0z9E2Nz+NQcLPLG2MFzOKOMYyAamLfbPWblRb6qW?=
 =?us-ascii?Q?ac7zjtQ+eFn4wYvVL3VRh23taucIP/BcVpz0OuVYfc2ZQ99SAZzU2AKlPRpg?=
 =?us-ascii?Q?hD3zLC92W/mY9BWl85VAeOKeMPLJ8FvLAwRRXTYgCBzFLDUbl1ecv/HWq8Q/?=
 =?us-ascii?Q?UX83ngXkCzfHYTwwwoZQarrwchZSC+0SpT92IyJtdgVT0B1sxONFQPg3+bRJ?=
 =?us-ascii?Q?QTPohy4SLfiJweU/U0zv2umhMIG6Z/YKRmCMZzwSEtky4vSVz2HQ7ADvVZ2A?=
 =?us-ascii?Q?XaSZVZQj9r8QBRTAGJO17vBMailVU+DDqgSS4/pxiP1KKwbfGSJEX7RcQVrT?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15915fb3-b9a1-4616-b71d-08de1812648e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 00:14:01.9709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGEEbConeHV+ghQRMOsbt2hD5+oWczvlJNW82XvjCJIh7eNh0tKgOXGCp8uzfhTTZuknrKbykzHojNl1VIniSUxrBDr76GJs2Zi+RXTZv9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5869

From: Khairul A. Romli <khairul.anuar.romli@altera.com>

Re: [PATCH v2 1/1] firmware: stratix10-svc: fix bug in saving controller data

I am using the same approach for sending the fix to stable branch like the
I sent and get accepted like the following example recent example.

https://lore.kernel.org/all/910aad68ba5d948919a7b90fa85a2fadb687229b.1757491372.git.khairul.anuar.romli@altera.com/

Can you point out what is wrong with 
cc: stable@vger.kernel.org # 6.6+ 

that not comply with stable-kernel-rules.rst ? Is it due to the Fixes already not in mainline?

I rebase this patch on top of your svc_driver_for_v6.19. Should i use base v6.18-rc1 from torvalds repo instead of yours?

Thanks.

Regards,
Khairul


