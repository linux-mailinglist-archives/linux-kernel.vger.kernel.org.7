Return-Path: <linux-kernel+bounces-807092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD0FB4A01B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200A23A9083
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A7291C1F;
	Tue,  9 Sep 2025 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sIMwVqrh"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E310277008;
	Tue,  9 Sep 2025 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388905; cv=fail; b=jYY5hN7YGE4OSg/2MfrlqWnYit2IegbgCMCtNRxQKXzESSLtSF9hZWjsQ/Uzz5VRle4AzDg0GhD23dj+YBG8WXPal7pqHvr01zzSiEkkUOcy2JB/0oXpy1ClSbsSKtTdbi31g/e9Ck+fLbSrKj+J5OuPeRqDR1sClvC19sdiqX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388905; c=relaxed/simple;
	bh=Lt50a9eIEq029pwcyrxzIFjwjmiqwp9ah/CSoJ0EAIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KZyLw8O2ujTeflAeWfmw4u7PQVn3IoB/N6Pkr3OOCpIHq0NjhUtlWeAi6RuGs7x9kc7BZSvCovuFTHEdUhq2dd+4GQ8R/Mq+EGwjuAGaKlj8RFRkfIOdqSjtxdK4VsE+9u+XW68zTvKLtj2uZECleYo85fpekn+zKdRuxJNQbXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sIMwVqrh; arc=fail smtp.client-ip=40.107.236.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5MkWiD3sswb1zBfclFtfzSCdDge25NveJMzqKUG6N01zSsA9+TXvpDP5E5iCYYmrKdwSvqUa98LReXaGzMt12+6uPVfov46ijGUWLq/3yQ3hiNKDow6pY1qzBsqpsm2F1fUqD5ekbsunDoSYMUgekSppNeoQ/mOQqEfUDQyqsbKt3OtZfWmpj6ZJfoN3121hV2rZx0XL2agVHJ18PflnVdVYhPjaDw7cgmR+Sku859Dco6daI8MFvBFquEmVfV36ORj7mGyMZQIgU2tVxoNDml3CPh3Kk8+aSvc1SrxIwrSJBzUD/f4DuV/LbunXyQ6cArAeDFdTGoaoisSe19m+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYGOzG2F/Rr8iD5vT9877uN6NVosCYaAnGLlyJEn82I=;
 b=ZoYyZpE/D5cn7jQRpn22/nNbNp6eVPViuMAKRk71ANjq2DufOXtECmEC58Lxp+22XNDpXElsJQ4hgb4/lMKtJPXCDrPJjBRGp2J3i62hfYuQJ4wRuwD79gSoK66rd8QQm5ka28dcBd6H2IvAxLtGa3EDDkO/eTb4bzDMULXc25iC8CpmRkcYxqSiZElFAx+8ucsJVVc0oZ4GCyCLQep1LcBbUCQd1238tW/pfSlvdc8cZu6jN6l/yGUq4fMsHtk0hcUXHnHnfJYbZi5/ICcRKWCxk5p6l9kwkLwNlNGTbnyf7l1uknncQUAmaUZUBMT6AGVQr5VjVe2PVawQSFC/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYGOzG2F/Rr8iD5vT9877uN6NVosCYaAnGLlyJEn82I=;
 b=sIMwVqrhmWNBGB0XN0P98GC+dCp/8ffJ4o7Km2CMpeU8Wr5oX68qE0dxnQwd3GksOPPRPqwOx2SnwpeDnRNkTpxv5IEGaP7qzE73nxYLxWuimpbGmIgr3Ved3KxY4GWfjHRVJRMu0KzH4HO3/c/YNRtODcTPi9WeG2qbJXcWFLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ2PR01MB8128.prod.exchangelabs.com (2603:10b6:a03:500::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 03:34:53 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 03:34:53 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: patches@amperecomputing.com,
	cl@linux.com,
	Shubhang@os.amperecomputing.com,
	corbet@lwn.net,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	Neeraj.Upadhyay@amd.com,
	bp@alien8.de,
	ardb@kernel.org,
	anshuman.khandual@arm.com,
	suzuki.poulose@arm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rdunlap@infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v7 1/2] arm64: refactor the rodata=xxx
Date: Tue,  9 Sep 2025 11:32:35 +0800
Message-Id: <20250909033236.4099-2-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250909033236.4099-1-shijie@os.amperecomputing.com>
References: <20250909033236.4099-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0375.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ2PR01MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a33f833-4612-42c4-6514-08ddef51c9ef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H52nMteO4M08yNZxDL7NzpyxJoAA9Jv4CYytMiclfFYJDg+5yPux8JeQnsD8?=
 =?us-ascii?Q?WSUHADdPmqSQeEFNG3SzdNeAUXWAwI4jhDYICXz5JkDvibm4DgVh7vP1c0Jb?=
 =?us-ascii?Q?rVRETEtJ9K5BNKAVDL/zzH3AjKIFWmOqU2S1DmqAMu5bWE3+biG83g+ya6c9?=
 =?us-ascii?Q?lMK0WryG5MpLfnj5JCS5TuAVieZEEOFmwOqpV6A0y2l7NzcAtZWUHZtRlz6/?=
 =?us-ascii?Q?8XGJlM7zR8lJ96lthRlVFtmaT7YAI87cME2gSDlTB54DZbZNe+MtaaeS2KHu?=
 =?us-ascii?Q?pzN43zUp8HfXN3cjQ0VW3ninDk47LAChVIRJsYpbYDEGbQCQJL26PuBs87+5?=
 =?us-ascii?Q?sSaxAiNt78HTjqVgoaeLaGwkGS1laXnhqNLtaA0y87ofqDVSwfo7ONLR3jAn?=
 =?us-ascii?Q?1bzMFVEMS4nrXaHDZY4hvdPigEVDgpsSYJJ+KkM5OMwBdiiOENfQ/52aPXBt?=
 =?us-ascii?Q?E1BHRPYBLyxDe0AFJtzLOnBRUSA8tdMl5rwhEk3Kux4YplhE3jI02ACylbik?=
 =?us-ascii?Q?IhRtSZXs3Se/NQvZu5Zm1z+xHyM82XPoyNEj1elaWWVgyqkVI/gqLnZcBTuQ?=
 =?us-ascii?Q?ozpz4+BtI2nLzK710VD8DJF7FPuhMlF7Q79lBm67IQYXxoykQAyQfGghRc2v?=
 =?us-ascii?Q?47LHADtFaIGgXn1AVr+JWjmmLcZapNKoNg4+oCeuoTeUUuvulkRZ3vsDgB5p?=
 =?us-ascii?Q?P7lR4vLx/zwVyDHSyM/Bt9KB00ATh1I1Z7xpmpe254hivIpHfCjXInq6EV8T?=
 =?us-ascii?Q?vvkEKaDsehC17vK1P4eCvjtyhpNiDMpY6l5kSnktWb6TFvOtX5VyqcKBxFTG?=
 =?us-ascii?Q?BDYIE3/XOWqTdw1kLAB0MqXFluPmpzeHi/80a8FRn5DMDJW3fPLZm85RCDQt?=
 =?us-ascii?Q?BoO39JZ97kWg8kAgAOMljArre45UZCEMDhxqFfGxjd9MUORFXzYa8mzdZEKa?=
 =?us-ascii?Q?AAb9tbkM4M7HQdwgpqYB/K1nOqkxc8UvIBHwK2yQh3FYOGRFSWHWCWTao1FA?=
 =?us-ascii?Q?la4cjzsUIu3PSvlUQKquXf2NEl5gYHMAME9SDu0U8fCegctHjq5l/XmbPMN1?=
 =?us-ascii?Q?JiJg78jySonw32coTFEa9lWyMPfFwVm+aC96kP7p5pQLrNCRUxJ20BpWpp6t?=
 =?us-ascii?Q?kInj4GPD9dBaGGNUKR61pCKVW0enB/cZPWv6FQ0hOoGZulV5qWEFlUmaxBiH?=
 =?us-ascii?Q?BrB2p4IgJkRWS+0HtPOkImWO4KDHA4oyJxU68+wNGMIN+oiJVDinj2+7Sr+U?=
 =?us-ascii?Q?A7sAAbEcSOG2Esry+4iCVu9dMsxabcNyU8LyVr6TFbppSbCGtgvZWoFgCXSK?=
 =?us-ascii?Q?EkzeK/08e210Om/q5yc0/cYN7jo7paHH4FfUNGdfFNSqOGyxAkJAf5vVaUw3?=
 =?us-ascii?Q?GNE/fvDsJ+/B/Y0nkCCHzFXcgBOiWV6LTHhFsQEeWwhPerIANoPTm5pS7asY?=
 =?us-ascii?Q?W+JgXhNV0+z67aTWQJm+F39PnKeBX21r8SoS9HM7JOGrJPzTzfqN9A2NNpUI?=
 =?us-ascii?Q?4UQPJ3eUola2rWc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uM/CHA0N67YHS5drQRmYkdBaiVXDPFd/4RyHqPXfknO36AJYpKqAncUK3Mko?=
 =?us-ascii?Q?qydlJiLG/CLIvrYHVZQoYtUoC1DvNL6xQQLDWbjawTj/a1S/zWwndgGdYqal?=
 =?us-ascii?Q?vW04IdphC/hfupnCQ+k5eqsFPWIJkVhMvbpcMoRdFd9IcQH452zKlVJio7Wb?=
 =?us-ascii?Q?fGg7WEBLVSOKx0KhbjFRNMZi71xiCwF697jT30pyj9djoH4HyTeguQ34bYXM?=
 =?us-ascii?Q?A76BhqHjqtMYEmlSDJRBiUPt9QSOE/WsGOh1te39kD1sMya7mseyatl8xPo1?=
 =?us-ascii?Q?6MUOmbb7JNL6b2Ew1TO0nI0XB5bfqJbf06z5s6gE+KoIlUbQTE8mZ1yhzjvJ?=
 =?us-ascii?Q?Ik+VRYzITFGXceYjXNoQHgmmidQkH1Zsh8V7dDeGCYEC1+CSOG/dI2TjBg9x?=
 =?us-ascii?Q?kNwKoJW1mPHLOrw6xGL9axrJGtIizSmLkyT/zNkyliyANElUS6DQ7ZmgDH07?=
 =?us-ascii?Q?iDAA2Q1LqEeiUvCmXxJtseQGJ9X0WXnVny/ZP6QJZj3EAtIGXMndmP9b90XY?=
 =?us-ascii?Q?zMorRSxZcPzOAt3jElpbpDSzuPCjTZMJlctTz+cmyNYen0XIKPsu4qg2ooch?=
 =?us-ascii?Q?1LLQsi42cA+jYCwlSzmDtBtfkdiBgFS2W5PYHubS//ZD7MvcBkRvajRkFYbL?=
 =?us-ascii?Q?xHIYNaehUjr9ECNG+4KQUmKbYf9FaN/f5EklfbU9dPv5fDQPdnUuq76msTEs?=
 =?us-ascii?Q?wFi599ZyTBLfrbk7BnIm763rE5aTQKpz1YroOgvdBXlCXyu+Cj3riuktJowl?=
 =?us-ascii?Q?XD7FANXpPR8ke38IlJ6+UZM9axX/aqQhzO4E0ZbGjNHTa21bV8yMLZv63LXb?=
 =?us-ascii?Q?YBxFRIV05oFsyr0aScGpHQYkQOyXt9K1btXicRqAfzba7YivSnXABFD0/czw?=
 =?us-ascii?Q?BKpiS2xcdNzSpHrCP//a/d8x/JFtK/tQHfh6Q1IKoary7wI2NFAv/yahwC6i?=
 =?us-ascii?Q?QMQkSdkYAQn44Btqqde4sCxDrTuqsoMenD2AmxuS6faBnqPerNHusk6Ttfbs?=
 =?us-ascii?Q?WATOyLw4FfKbYdtXaPOS5Ybo2BGAxPdtfhvxanFmKy0Mlvtp4bB2/7wXptIy?=
 =?us-ascii?Q?Si8+hDjEE/AtJ49US/bLj5MjOZ6hISxEufHgwkynxgxWLM4ncj5Gpki9B1ko?=
 =?us-ascii?Q?wL+Nbyci42/73V0j5Go2THhaRSmXhNfKb1rY+cVGEnybMbw/3JsoQR4o8LUu?=
 =?us-ascii?Q?nMxOBzPhrqbGDItuyC1FIBZyC/YQRCiO3d2i3lHTeBd5/Cpqmhy+44CLkLC4?=
 =?us-ascii?Q?UhML7b0BROF0INRnHDZs0WE/eERP+FYqTNPp412x8bOvBHSPXGMSRV5UdMMx?=
 =?us-ascii?Q?y/kxqW9ka5NDG175BWm79HSTMDYt1B6UIOOjmM8piTwM3If7ZRtWBUJMr+UX?=
 =?us-ascii?Q?D9FhlCPs/fZU6sWzOi/8HwL1OTUhnHb9LRFWhgsxjq6glTIVF6JdXtfg//+v?=
 =?us-ascii?Q?zI76qqIBSOxzsuTbncu1qHsMdogzH4QRW4IaZTVO/z65zBeWBcjmnHPHoffz?=
 =?us-ascii?Q?MsAHO7TFhr0DpRfi7AhaDtrMc5L5f22H/kRkAgxKmeDjoaVN5X4W2M2EFy8o?=
 =?us-ascii?Q?oMjVOTLzKoO4kKzc8DEQfQ1pHTqJWbZPL5hEx9bJoYdDXRwILZNDH/ssDr9C?=
 =?us-ascii?Q?MGfVkYFRB8nNtbMaNROdjoM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a33f833-4612-42c4-6514-08ddef51c9ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 03:34:32.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTV48RIGPQU4VJ5cNfUxi2FqoH1vkWavaJuL4awcHp3g+CBBWkyXT0VeXrnzcgJMUl1OmiMAf9dUMxGfx/QSHQUFcp+bqkS++f18fx530320+XpXfcHaZ8oRCEftuxDy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8128

As per admin guide documentation, "rodata=on" should be the default on
platforms. Documentation/admin-guide/kernel-parameters.txt describes
these options as

   rodata=         [KNL,EARLY]
           on      Mark read-only kernel memory as read-only (default).
           off     Leave read-only kernel memory writable for debugging.
           full    Mark read-only kernel memory and aliases as read-only
                   [arm64]

But on arm64 platform, RODATA_FULL_DEFAULT_ENABLED is enabled by default,
so "rodata=full" is the default instead.

This patch implements the following changes:
 - Make "rodata=on" behaviour same as the original "rodata=full".
   This keeps align with the x86.
 - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
 - Drop the original "rodata=full"

After this patch, the "rodata=on" will be the default on arm64 platform
as well.

Different rodata options may have different performance, so record more
detail information here:

 rodata=on (default)
    This applies read-only attributes to VM areas and to the linear
    alias of the backing pages as well. This prevents code or read-
    only data from being modified (inadvertently or intentionally),
    via another mapping for the same memory page.

    But this might cause linear map region to be mapped down to base
    pages, which may adversely affect performance in some cases.

 rodata=off
    This provides more block mappings and contiguous hints for linear
    map region which would minimize TLB footprint. This also leaves
    read-only kernel memory writable for debugging.

 rodata=noalias
    This provides more block mappings and contiguous hints for linear
    map region which would minimize TLB footprint. This leaves the linear
    alias of read-only mappings in the vmalloc space writeable, making
    them susceptible to inadvertent modification by software.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 arch/arm64/include/asm/setup.h                  | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index db84a629f7b1..138e0db5af64 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6418,8 +6418,9 @@
 	rodata=		[KNL,EARLY]
 		on	Mark read-only kernel memory as read-only (default).
 		off	Leave read-only kernel memory writable for debugging.
-		full	Mark read-only kernel memory and aliases as read-only
-		        [arm64]
+		noalias	Mark read-only kernel memory as read-only but retain
+			writable aliases in the direct map for regions outside
+			of the kernel image. [arm64]
 
 	rockchip.usb_uart
 			[EARLY]
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index ba269a7a3201..3d96dde4d214 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -21,7 +21,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 	if (!arg)
 		return false;
 
-	if (!strcmp(arg, "full")) {
+	if (!strcmp(arg, "on")) {
 		rodata_enabled = rodata_full = true;
 		return true;
 	}
@@ -31,7 +31,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 		return true;
 	}
 
-	if (!strcmp(arg, "on")) {
+	if (!strcmp(arg, "noalias")) {
 		rodata_enabled = true;
 		rodata_full = false;
 		return true;
-- 
2.40.1


