Return-Path: <linux-kernel+bounces-762891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29569B20BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA54116ADE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEDE2459F0;
	Mon, 11 Aug 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gtjPGBtQ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B72459D5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922439; cv=fail; b=mtniIMcwrZqY/OJwAEhbHwVO0g46EzyguKXzFJm0iKYeyTQWehHNwmdaRqWCWnK+UtcmWvK1zt1KiMc6oV5sTgwLDkIiHXZnYl6Yey0HR9hnGcOM5M3tnrc3W0N5TiOgtMuaSoxo/rK+4wVTZsxloNRNpU+A4YvFzFpOhM4uaAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922439; c=relaxed/simple;
	bh=rrHc6oHXzMArmAK1b+/w2mP1MbxLQ5Gg6O+2/fjl7nU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a8N/Ew6aJcLvvVEzAOVhU7LU5Z2c5b0BwqrfuTPQNbs83liWUm0z+5B/YrcUmBnTTPYqe6t2q4APE9yMJeWo+z5MuGqlFzUhQTniaKrCTSZ85c38n1qaT35NUK+QmNmoie1F1rwO83sqjP3OajTpuhakQmvPvJN6iefxg1Pjrkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gtjPGBtQ; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z89T+T8ZLdPU9dbMlaZ1X3Xe5SGDrIubcenFusYjp8VorCr/xwraVCgbpAJUrTpk832gfu+Mm4878d7/zXsNSdlw8H7Y5mQadLoj0VPQ7gpc/21jmh2aSJwq1tzp7556jI/t4gfDrBnpLeTiFClu4Oa/iO2T/hfsrMjt6AeNDY4S86cABXvOqglQs7xIys6FYturiY0xJC7dMMjRfvdxqWI7bc0UjpKO0jYvsWISeQWO6C7tinJ3Z9mB2rJkERcogyHp7MNB/6ZiV1oFStZle1Q3pwx3Ep9EQtTy4DYwfGu0/NptECyTtEG6mtdrSBD6al+LEav5CV4I2phBGz2TXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1uHmLY252ERoCMnCiJEHIlSvCkXpu4CxTjXcGuwP6k=;
 b=hMftjWe5NzotRMe62Z5KLjgviBxZYrng7wDm6Rps/EN7SdwVV4DTTM2aN7bBm+JQBmkn8jRMdx5SGGs+L7QT4iqxglKNAouC/zU5YKDbDSTJXxnonE2frdsUWq9t406vO6dvAmZGbyzH64S65NQdRv6PMNJFJYnfM+rFrK5DTFf5+vJydqm9/AeooYizbxrpzHEfroX74vcZ4J7qa34qCeopIPbeYnBHdGPcJIYNfpSR4ccYsT20BokYv34roqgF8IE7YmDQQROGx7WV2GiI9K9C2yX501OGDKR9wRaRy7LZLffHmezHiskz1wteWd6Rct/CkPjHs5wyxTtku1aY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1uHmLY252ERoCMnCiJEHIlSvCkXpu4CxTjXcGuwP6k=;
 b=gtjPGBtQIc/Wl/24CCH1wziXfkuW9U/gmFUvADt6qCAV9rcY8lwCyWkf5P3gx84lvx8CuqIzBc+XkGVRgkjDfROZh02QQt3sQCHPq8O9LZ+AnK7sAB/aN2OQvWkDuZ6v8R7avVZ25VO27OiXVIeCf7IgqIrX9+3ubyDYLPufwys=
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 14:27:11 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::6f) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:27:10 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:27:08 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/bugs: Cleanup parameter parsing
Date: Mon, 11 Aug 2025 09:26:56 -0500
Message-ID: <20250811142659.152248-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a00a48b-bd1e-4cb6-1a76-08ddd8e32878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFLRAz3HQ596GsjLaIcTQc0spoKhI2VsIgF75WCPwjGoxRBIPhKYJnoqVxFc?=
 =?us-ascii?Q?uIhxUixWUSlvxeajJba8B7+uoGlhyBVu0x1B1gRbP0ztzzb47wJUq0GsQpre?=
 =?us-ascii?Q?/i3A/0N7x94+ZG9jUs4G0iQPqcLH/8whb+sGfgoNf24ehBj0+8V52M5Y22zs?=
 =?us-ascii?Q?AxhuSng7kVu5TRKBOkJosV9I5kU5GAIaUsndQDLm6mnwmSZlTswhw03hwjfd?=
 =?us-ascii?Q?DAa6gLlY7RJFxXK9jCakrYfdePCQ5YDvElz5RizXCbyiSTH1wGoHURHV5ANs?=
 =?us-ascii?Q?7NocYDdGVX68mYclmjj1zwH7I9VjuHKl1MTWiPwlfPOU4gSzzOuFhKi8mz7g?=
 =?us-ascii?Q?os6u0dIamOC6Kk9ElTA/VVadZHIJvCZzMpAJu7pFoiJs/AT6sybvkmDY0Mqb?=
 =?us-ascii?Q?CPYh10cfwhAEZ+QT5RLQOIXESBZZI7dvOZvdhetqWm3O7ZUQvwv8KnhHQJeb?=
 =?us-ascii?Q?S7RTzNkn1FiQ0ZNI8huF53Zng/uRfo2KzIFRozH6CVAiKxG70hBZYeBzgyfR?=
 =?us-ascii?Q?MGDUzSd9IyQJpu5W47eh9hDdfDFZXoHrmkbv33GwvK+I8mNPSgS19GyiKZK2?=
 =?us-ascii?Q?2odHX8EYCU6EIgp2bBJnvnkzBJM0m3qGYcx0VB04Kkap5AuJvR9vbzyQYlIi?=
 =?us-ascii?Q?uFQYx21O9hOJ2cE4OeIQS41KlRBvEw0oUezcNi+Zk8vUAE4v0lpcUkq46XF7?=
 =?us-ascii?Q?hH2lhzFxlSZkUdpylemsW2mQaT6WhNkMvJW2OA4y9StLIHCUE527w9FUqQuM?=
 =?us-ascii?Q?4vjieAEImv/B6EyryWc12x8P8MrTwdsIG2libkSamsAdHtDMFNPY1r0kP6pL?=
 =?us-ascii?Q?pxL+Do0XAC2O8j9QGFR1Q+9wsFlstLK3D1H5E+7YVZqe7R2nXf+JnOfyzlLk?=
 =?us-ascii?Q?0wQ0Fv4GJUCquJHT5Pn3vM2yfFb6+hPo7jJOdN66N/MCPt5SdsJ3M6xeuqpo?=
 =?us-ascii?Q?NlcoByLlaa05jdnTgB2irVTldn6PRNHF8EY0ZZNNR6p/4oNvlsfqgjd3iA4Y?=
 =?us-ascii?Q?k9B3djq7hf37uSRVJM0cgTkoiXzxQzr7XN04nmY4Q6CGCtCsRrR2Rah4vsku?=
 =?us-ascii?Q?Gt6Q9u66egbcoTcrVwcN3jZXc4xEhH1iKMYYeuGxCM13vVA9upXuqvrrxNk6?=
 =?us-ascii?Q?6vX9bgGqOvuDZ1dH2yH7peV27IMJTBXtiAmTvpC83ux5E3XfGNZEWfPT1fhB?=
 =?us-ascii?Q?ZIgAryPE+rtAbvFXS8SZA/2bi9zNGVnrCgg3zRTe5OGZmYbBe7f7nhc3cANs?=
 =?us-ascii?Q?EUZtpq5ra3TYVeF5jxIPmyVdiMcU/UmH5hSk9ursKr36LxVf5g3Zxp27NeB6?=
 =?us-ascii?Q?5V5r5K3Nf8OHR1YhE86jB9ZGTCDnnmZZV8wCiIu+9USC9u0JA/P88nmQN2Of?=
 =?us-ascii?Q?fd8S0NdFtR7uBsZ7PGVa/hY76uQYLRSLNGrPjK4reYXM5iKchb5tcy8Ghm5s?=
 =?us-ascii?Q?7kApXLqlYiVD01c7hyFMo9ayc648M6zQjRKKVM/51MM5Ub+cRtOJ6hsV6ie+?=
 =?us-ascii?Q?BTIMgkLGnFyMc8+2r6sFuU4lqSNrrKMX4Kv2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:27:10.3727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a00a48b-bd1e-4cb6-1a76-08ddd8e32878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505

Most mitigations in bugs.c use early_param for parameter parsing.  A few
older ones do not and look at boot_command_line directly.

This series modifies those to be consistent with the newer ones.

David Kaplan (3):
  x86/bugs: Use early_param for spectre_v2_user
  x86/bugs: Use early_param for spectre_v2
  x86/bugs: Simplify SSB cmdline parsing

 arch/x86/kernel/cpu/bugs.c | 331 ++++++++++++++++---------------------
 1 file changed, 147 insertions(+), 184 deletions(-)


base-commit: 4b6b14d20bc04dcab6dd3ad0d5a50a0f473d1c18
-- 
2.34.1


