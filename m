Return-Path: <linux-kernel+bounces-768672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBAB263F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7476E5A6241
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3652F83C0;
	Thu, 14 Aug 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="haa/r3Lr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="haa/r3Lr"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02A2F39C3;
	Thu, 14 Aug 2025 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170074; cv=fail; b=IevbXIm0Qx+uPNGMZeLTfxedNZnQb3yL9jSkbQrCOdfTNYdejDlNYqht2p7Uujwi5LpGfWrAAkowmAWw6ra8WV32LWICY79qRZuLy6GEFLq3I4MOvi6RjU8OZSHCeDugNph7TJCQ1yRZv7AAcDH2nwvCFMpgR8p0Yqq3TIgYFjo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170074; c=relaxed/simple;
	bh=hxrlnrRB+XbxEapS5yj6nZtDqKuwSMeLBMDjFlPpSu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qf7b8ZYZkP25bdc+vkeixh0iF+c4pusMv218WOQBf0xqqZ0hi69vofjz74ZJz/a5X01aRZvpDNFBkr0L2+iMTiZE29Uu3PfYUaifrzj6dEl9Y2n4xvQkaHG9UJvqsGNvzNi/nT7zMkIXSST8sqGL7CPWNjwLmLH97o6TStiYTJc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=haa/r3Lr; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=haa/r3Lr; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=D8YWKMgO8wfpoRUuas2vVGS7rR61aiynLZIi7h6fb4g5XEaCU3kLZQ+/Rj165fcX9bPrnvzONrDsF+hvPbpy/ua+j/6BeBDbvkN7vAj0/Moaq0oSc2bFn4kp4IGL9HLzknOmzYm/h7+Idpqh6TfgwcfYvm2PlMIxkSvAPqAtNad2wN1rm0qJlXPPHelDuexdQclyxcFjV3SQZQn3bLSohDYUYwA9fRyfLCU9YwWCzRSBpj3aXHr+Ki86phYUfTRXEu2MXjC/+OzB51ZfqkOMwKQz/xPBYSmmFDdG3zHHuWiDZ4b81zJggIgWaVZ08ypPjIo+60SywgeLjlb2iTS+5g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9J3eVZGDKOeoY9cbAY3Hjhn3XatreutjqL/MSPVjR0=;
 b=exKmEVIKmnf8rDFqWmH148q3Hy0yh5K2OmVUKBZjufihlca9FkUFcIr5459ufeDnX29xKu8AuLqFntfd0WWWTN3xX0JX2nN8LaJ5Lb04pvK5TSF6QxX8irzhTkFTROij/fkN40br22X1UsRY9OvYQhitTg4GlI38x1qPScJluPkVsbK2e9OwOMsDpCzf6ihXadM3Xg89CP6rB5QlOAKXDXJ9dEGCGZbmpHyXp7n99NnpZDod5N4cMvnX06Ge8n+woPUbQZhLcm8jyFwmxNOxfXlyHkncoGxwbSP9HYo2UiHlmyQ+igcfj5WPqN8Iknf9Ban9YI74hYZpiZOaQrd6lA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9J3eVZGDKOeoY9cbAY3Hjhn3XatreutjqL/MSPVjR0=;
 b=haa/r3LrXK4blMcJTzrqGuIUe6VUl66I+/huraU1AxgnhK/7/OWPsRBJQWIYSc1MFbe/faRiZLGrBAKF15g0c5GcKll0sbYSJgOxg888DpSkyLgakHgDAJUQnqGkfdtGhmYxeilLlWBuSroYcufJ3g/rWdsVV/9ryavJ597DPXs=
Received: from DUZP191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::25)
 by DB5PR08MB10235.eurprd08.prod.outlook.com (2603:10a6:10:4a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 11:14:27 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::79) by DUZP191CA0021.outlook.office365.com
 (2603:10a6:10:4f9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 11:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Thu, 14 Aug 2025 11:14:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDTb+GVJl1QrICW0L6dcf/4Rq7w2VrBN5/sOOqobV/4r4nhGQYUhi+iSf6l5a/YObJ9PvNGBAduOHxZot9VQNSScXmzsEyggHAOF76aKwUw9ltr3mtyfz+YZJK+K7IrKKHUo+YnGSLr0kf3EhCOP5g2Y6Srt6wdtc9AJ4P3sIxtde5hndzFCPwSPm8iuMLoy/6Vbl1UmzmfawcWXhcY1RZw05gqO5hnpnd2Fd/f6lNqsd1wxt7tmtvuc9nSd6K6vQ2aGUgdJAPgDvKpOIrOydGi+fSlXLZDtHSykFcNtoc76Y+kJ0DMf1eRJLblEh4ltEFG9iaMAYEixPo4YaqP0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9J3eVZGDKOeoY9cbAY3Hjhn3XatreutjqL/MSPVjR0=;
 b=K8B5h26EK2Ay9883jJvGBm1f1Vag1dT4xa8JEPkRtLxtMA08/4VWu2t/vIN0isGignyGyvrxuX5FHho5yHFPA65K3+emY+uh0He23vGz7lKkqulPgP6qODmdcfeoa2gP76cHCe+/ycAWUC+r3Sb3K6VXqAULjb3Xw5cFGFAEyJy1cxsR9LAc6hga7jM+/lsywzof+g1RtC5PS+dmg1npdUnyaVhM449cnMjW0dag7UakIDnZIOQLXtcoe2drWmBD8A2hf9E4DpNmaRyNhIDe6AryU6OscxeUcQWK4KoNpB4dON6+L+JW7UuPgQXBq54FzEddjzKsGYlX/BqsoONFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9J3eVZGDKOeoY9cbAY3Hjhn3XatreutjqL/MSPVjR0=;
 b=haa/r3LrXK4blMcJTzrqGuIUe6VUl66I+/huraU1AxgnhK/7/OWPsRBJQWIYSc1MFbe/faRiZLGrBAKF15g0c5GcKll0sbYSJgOxg888DpSkyLgakHgDAJUQnqGkfdtGhmYxeilLlWBuSroYcufJ3g/rWdsVV/9ryavJ597DPXs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB5617.eurprd08.prod.outlook.com
 (2603:10a6:20b:1dc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 14 Aug
 2025 11:13:54 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 11:13:54 +0000
Date: Thu, 14 Aug 2025 12:13:50 +0100
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
Subject: Re: [PATCH v2 2/2] kasan: apply store-only mode in kasan kunit
 testcases
Message-ID: <aJ3E7u5ENWTjC4ZM@e129823.arm.com>
References: <20250813175335.3980268-1-yeoreum.yun@arm.com>
 <20250813175335.3980268-3-yeoreum.yun@arm.com>
 <CA+fCnZeT2J7W62Ydv0AuDLC13wO-VrH1Q_uqhkZbGLqc4Ktf5g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZeT2J7W62Ydv0AuDLC13wO-VrH1Q_uqhkZbGLqc4Ktf5g@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0231.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB5617:EE_|DB1PEPF000509FF:EE_|DB5PR08MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: 078dfe8b-2b48-41e5-b47b-08dddb23bb15
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?kJG2+MUZJRx2SZoO81LPwWgRl44Q6RdAQ5vy5nqFzcG7WGNi+gngocoW+Aij?=
 =?us-ascii?Q?pAc1VLRs/YBBeLFcx09FB800BgtVVoApLJBBKPABSHWHbuYpaQE4M3SApoFi?=
 =?us-ascii?Q?At6qyG01gsYpGLXSC8/C4khSaVMIJRL6uIF+gtmQX9VHZJ31r8O/sEMdJEfi?=
 =?us-ascii?Q?ir/JkWeuIRgtJfh5NboauNGRMpZgxs0JhYS9YnHce/G3RR8SVzYhbyaVVdEe?=
 =?us-ascii?Q?5Y5WXyXbGJa13oVevOX3GWR5WFSy9lVVTxvxBvBPm/2hrCBh4/dDiMIZBAdR?=
 =?us-ascii?Q?zRoncIhOJcau/gipeQ2hf/sPnfRUgmCLRyKT3/WY5CKnW8b87lclmKYVAEFw?=
 =?us-ascii?Q?BrKYG/zF3bnrgSDp0mmPNzEWaiWyL2pbwBpD6Zsmca9RaEjM/3W3/dm0PxFO?=
 =?us-ascii?Q?TGy4dH70XuqcdVxlgFzYtbSuhUjVmsaaw4B/4lkJITIXDyOxrr+gcJMM1fSG?=
 =?us-ascii?Q?ZWXTTONVgqUoHnB+j/sp1KMoJf0zK9RJo9bAMVHtst75Kry6JzivHPpJ50xZ?=
 =?us-ascii?Q?WA2kgxArm9RVGfS4bxXH+BmjBRsaazNu1QLMbrmCuUbCMG58chqE3eEYX1Wm?=
 =?us-ascii?Q?ndv4fnAGQDGMoU4tcCYqSKbaYsxm3/PyRemsIJ7omPFysczvgYV+xEkna0kV?=
 =?us-ascii?Q?aDZYQZVov34l+kVSQB3gTQIl1W7DosL+sBfulMbraE8xcMdh+2yuZo5P8OaX?=
 =?us-ascii?Q?/R6FaIx+MxMkQAiczYtyoT83CRHsIBLcXHTrwQiRJNx9+KsdutXPRwxXMcXr?=
 =?us-ascii?Q?wrMkJFiWuBgAjtk90ppgMBeT21x5HTxoTA+4CRapOR/xipOi6v4CIRoT5ZgO?=
 =?us-ascii?Q?CBi5Iapbc6Ln3jipOOw76XNd3NOJJGL2s/oZ7CsGewQJ9S2B2qulLRp7WlVm?=
 =?us-ascii?Q?TCyXt05HvAZ8RcXp3IXJ+19gsWRNlV1oKfqNBuGWJzk1kZvVkb/LXM4EWHUn?=
 =?us-ascii?Q?ZPxn78lKtlzRJo0IJggwILcoWImI1A8On09eDeC3RkrA13rSFX3ji+6AgaoW?=
 =?us-ascii?Q?2nuHntzWLuckEjv1GfPpsdAMbLXGruawQ25gn7+JypLRqVVIHY1RJquGfnTj?=
 =?us-ascii?Q?LP0Q1BSNQq1CeAVOI9SqDsU/mk+garJUBgsEyoeuYo3iYlYnttnBUJqyNRRx?=
 =?us-ascii?Q?z96wFgvpdQ/mt4UYfpFSON/dlxxIR9RkMt6Oii218ZWZI+ZiWy/YbIJWE2qe?=
 =?us-ascii?Q?ndNSZ8e8vYwTJBmFmyBPMPvEQHB6dT2N9/llfQiHl66XzAUPt3pJ5iLCjrNX?=
 =?us-ascii?Q?w+e0LmhcJZKjvwmW7E2WP5ffavrSN33acrEf9JLgZN9k8MZsUqfTn7dT8Qn9?=
 =?us-ascii?Q?5jaKPFoyCCFKqxtlkP6WoyAFCeqN+MHCSd6+M+NWjRQUOIqluGiNCEWtYoBj?=
 =?us-ascii?Q?z36n93Riy5hP6DilPpHQihEmn1Gw4zl7CZgYCPPiZ8tvIkv9nmGHJnBv2yt/?=
 =?us-ascii?Q?Sd8BZmFsdXo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5617
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a13f3b03-860d-41c5-b37b-08dddb23a79c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|14060799003|82310400026|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5TjXR7/3jTJyQYgPmsEayn9j8kX+KKLeAF7po6SdT3xscQHIke1tQnMq5qVe?=
 =?us-ascii?Q?E2n+V2woXK1mgMwT+uGp7zk0IPRTsY8mnm230QgKDGTee+qWqpackOYCV4iN?=
 =?us-ascii?Q?08I4acph5c8Ddp7dQ2dlfqyQkPi9EAYRd5ZLLDTl3GmemtBfKqXKsEtAb3+k?=
 =?us-ascii?Q?9Tsto6OVU3hdzoCDSjwBVMOYppDmMx0Ez6r45dzkydgbpHzbFN9yP7S1ewa8?=
 =?us-ascii?Q?dqtm9sebD5mix0ICHb5U1av2Q7/+IC6xoC9XgKnipzS1MHVA77hUp3mlTmZv?=
 =?us-ascii?Q?TcTDrYiz6X8I6WWHCieaIxAqdwKKqrhrEnee8Ctoy+KCjMyE/0DiCRfXcBeD?=
 =?us-ascii?Q?jtdjeT9v0GF6GfY9ekc6jhfegalWgYH1Pao+5FOjmEcj4Y7rZuj3GfmtnqMW?=
 =?us-ascii?Q?GpmLHCUvRP8yV2lk3aJn2uwarMhqdh/fyY4LiWemeFbG0B2hUMEBFoZaLAg9?=
 =?us-ascii?Q?YGOpHXhFxXbrfP4Go7Yq55cog2A5BN8qFDDMCWlgPoHXmQuLcgM1M7cQA7bf?=
 =?us-ascii?Q?KJ6DrcstEuXQpmZG3+oMtb82kUN/2zt/GCEl+P5zMJKFRX8DfF0d7zBqS/tR?=
 =?us-ascii?Q?XbppKIkbS3Io6QA7XBJpOL7Y3LcHM9g9Db/+Fp72PHEn9hEIUxSIRqcc3bwW?=
 =?us-ascii?Q?NLTPr2JQMoHeSQisR3PIM3ZKRUxMJB/1qPXddA+csiv3Irslp1zrUgBGCfC2?=
 =?us-ascii?Q?PVz8kiMgnmMj3yj+JidSIeWjfnS6mSZnMVGxezNozmCo10hhScciH41kFK50?=
 =?us-ascii?Q?dtlrWggM+w0wQlizNRC9P7vr8dkwkhFjVbvKpod9zUYeMFUqxI/qSj82qgrT?=
 =?us-ascii?Q?a0lFRoih/PPSfO+whFrYtPfuOH2FY3iSu1W0J3MqSYufm0/XKXz/z0WtfC5I?=
 =?us-ascii?Q?jLCk+itYJuct93zs7+3lHksxAIDr8MPXMZD/CQCzHOWDghfMaereFxiXUwfU?=
 =?us-ascii?Q?cDJeT+dAbXMNDih3gOavYJ4q96oeB8mrtRJfGx/37IWpnTgDexXXnjitlaKX?=
 =?us-ascii?Q?aHmbVUR0UHJOaSrjLOhNl1jCSrugZTXiWFtLY5YZ2YNW7ep9NuFVFozkdov6?=
 =?us-ascii?Q?cTdhgyVa9vzVHIyEnyUBk2++P1jKOpV+fRqHi0sUPFxE40Avt1Sat5rKtx08?=
 =?us-ascii?Q?fYWDf+2afENFy1CdkkJ8DEXVhV9HWgWdi8XLDLp2jpb4TsH89zjB0aJhMV0H?=
 =?us-ascii?Q?1hbvky6zRoDMAHR6OYJb1OJV6wir5VaNl2gtlDnJNDTpAokuxP/E56LURYHa?=
 =?us-ascii?Q?O9IEAA439OJPsrMqRmZ2RftZUEi5cIDBemHK7/CL0MoyvPFGiQlxeNc6PArB?=
 =?us-ascii?Q?B36pkwHe4tafVrSlOOLUjySygQO4YICvfLf+B3pDlVedJdz06vHFsHpz6EWK?=
 =?us-ascii?Q?9ZgLODT4Y4fBFDSDGyd19GgQxT2ggO56ZqZt15vVKv2cvPyN5RzECButY/VU?=
 =?us-ascii?Q?G5YCzjMLC1STF7ZF7s57iH/XDXB1A0JgQGCsF430IlOOgLOGBuXegF4RcyHW?=
 =?us-ascii?Q?9X3g9MlxTiI9DzNB4YgfIyD/2OYkipV8atDJ?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(14060799003)(82310400026)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 11:14:26.4490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 078dfe8b-2b48-41e5-b47b-08dddb23bb15
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10235

Hi Andrey,

> >
> > When KASAN is configured in store-only mode,
> > fetch/load operations do not trigger tag check faults.
> >
> > As a result, the outcome of some test cases may differ
> > compared to when KASAN is configured without store-only mode.
> >
> > Therefore, by modifying pre-exist testcases
> > check the store only makes tag check fault (TCF) where
> > writing is perform in "allocated memory" but tag is invalid
> > (i.e) redzone write in atomic_set() testcases.
> > Otherwise check the invalid fetch/read doesn't generate TCF.
> >
> > Also, skip some testcases affected by initial value
> > (i.e) atomic_cmpxchg() testcase maybe successd if
> > it passes valid atomic_t address and invalid oldaval address.
> > In this case, if invalid atomic_t doesn't have the same oldval,
> > it won't trigger store operation so the test will pass.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  mm/kasan/kasan_test_c.c | 366 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 286 insertions(+), 80 deletions(-)
> >
> > diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> > index 2aa12dfa427a..e5d08a6ee3a2 100644
> > --- a/mm/kasan/kasan_test_c.c
> > +++ b/mm/kasan/kasan_test_c.c
> > @@ -94,11 +94,13 @@ static void kasan_test_exit(struct kunit *test)
> >  }
> >
> >  /**
> > - * KUNIT_EXPECT_KASAN_FAIL - check that the executed expression produces a
> > - * KASAN report; causes a KUnit test failure otherwise.
> > + * _KUNIT_EXPECT_KASAN_TEMPLATE - check that the executed expression produces
> > + * a KASAN report or not; a KUnit test failure when it's different from @produce.
> >   *
> >   * @test: Currently executing KUnit test.
> > - * @expression: Expression that must produce a KASAN report.
> > + * @expr: Expression produce a KASAN report or not.
> > + * @expr_str: Expression string
> > + * @produce: expression should produce a KASAN report.
> >   *
> >   * For hardware tag-based KASAN, when a synchronous tag fault happens, tag
> >   * checking is auto-disabled. When this happens, this test handler reenables
> > @@ -110,25 +112,29 @@ static void kasan_test_exit(struct kunit *test)
> >   * Use READ/WRITE_ONCE() for the accesses and compiler barriers around the
> >   * expression to prevent that.
> >   *
> > - * In between KUNIT_EXPECT_KASAN_FAIL checks, test_status.report_found is kept
> > + * In between _KUNIT_EXPECT_KASAN_TEMPLATE checks, test_status.report_found is kept
> >   * as false. This allows detecting KASAN reports that happen outside of the
> >   * checks by asserting !test_status.report_found at the start of
> > - * KUNIT_EXPECT_KASAN_FAIL and in kasan_test_exit.
> > + * _KUNIT_EXPECT_KASAN_TEMPLATE and in kasan_test_exit.
> >   */
> > -#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {                 \
> > +#define _KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, expr_str, produce)    \
> > +do {                                                                   \
> >         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&                         \
> >             kasan_sync_fault_possible())                                \
> >                 migrate_disable();                                      \
> >         KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));  \
> >         barrier();                                                      \
> > -       expression;                                                     \
> > +       expr;                                                           \
> >         barrier();                                                      \
> >         if (kasan_async_fault_possible())                               \
> >                 kasan_force_async_fault();                              \
> > -       if (!READ_ONCE(test_status.report_found)) {                     \
> > -               KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "  \
> > -                               "expected in \"" #expression            \
> > -                                "\", but none occurred");              \
> > +       if (READ_ONCE(test_status.report_found) != produce) {           \
> > +               KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN %s "       \
> > +                               "expected in \"" expr_str               \
> > +                                "\", but %soccurred",                  \
> > +                               (produce ? "failure" : "success"),      \
> > +                               (test_status.report_found ?             \
> > +                                "" : "none "));                        \
> >         }                                                               \
> >         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&                         \
> >             kasan_sync_fault_possible()) {                              \
> > @@ -141,6 +147,26 @@ static void kasan_test_exit(struct kunit *test)
> >         WRITE_ONCE(test_status.async_fault, false);                     \
> >  } while (0)
> >
> > +/*
> > + * KUNIT_EXPECT_KASAN_FAIL - check that the executed expression produces a
> > + * KASAN report; causes a KUnit test failure otherwise.
> > + *
> > + * @test: Currently executing KUnit test.
> > + * @expr: Expression produce a KASAN report.
> > + */
> > +#define KUNIT_EXPECT_KASAN_FAIL(test, expr)                    \
> > +       _KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, #expr, true)
> > +
> > +/*
> > + * KUNIT_EXPECT_KASAN_SUCCESS - check that the executed expression doesn't
> > + * produces a KASAN report; causes a KUnit test failure otherwise.
>
> Should be no need for this, the existing functionality already checks
> that there are no reports outside of KUNIT_EXPECT_KASAN_FAIL().

This is function's purpose is to print failure situtations:
  - KASAN should reports but no report is found.
  - KASAN shouldn't report but there report is found.

To print the second error, the "TEMPLATE" macro is added.
not just checking the no report but to check whether report was
generated as expected.

>
> > + *
> > + * @test: Currently executing KUnit test.
> > + * @expr: Expression doesn't produce a KASAN report.
> > + */
> > +#define KUNIT_EXPECT_KASAN_SUCCESS(test, expr)                 \
> > +       _KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, #expr, false)
> > +
> >  #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
> >         if (!IS_ENABLED(config))                                        \
> >                 kunit_skip((test), "Test requires " #config "=y");      \
> > @@ -183,8 +209,12 @@ static void kmalloc_oob_right(struct kunit *test)
> >         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + 5] = 'y');
> >
> >         /* Out-of-bounds access past the aligned kmalloc object. */
> > -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =
> > -                                       ptr[size + KASAN_GRANULE_SIZE + 5]);
> > +       if (kasan_store_only_enabled())
> > +               KUNIT_EXPECT_KASAN_SUCCESS(test, ptr[0] =
> > +                                               ptr[size + KASAN_GRANULE_SIZE + 5]);
> > +       else
> > +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =
> > +                                               ptr[size + KASAN_GRANULE_SIZE + 5]);
>
> Let's instead add KUNIT_EXPECT_KASAN_FAIL_READ() that only expects a
> KASAN report when the store-only mode is not enabled. And use that for
> the bad read accesses done in tests.

Okay. I rename the KUNIT_EXPECT_KASAN_SUCCESS and integrate it
in the macro. Thanks!

--
Sincerely,
Yeoreum Yun

