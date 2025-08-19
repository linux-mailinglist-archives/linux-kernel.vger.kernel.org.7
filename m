Return-Path: <linux-kernel+bounces-775973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0DB2C708
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD49174178
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A1225F798;
	Tue, 19 Aug 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iGgPddC9"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013033.outbound.protection.outlook.com [40.107.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8E2EB85C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613616; cv=fail; b=ktG1499O2EKo+g8X14JBP1pLGWHDWxMoSiVV6WZ0h7cMfgELkjOt+zeHhwjaAvKsT6M2H3/fn8J5XFjSSRBwx3H5r3E58NePJ+apLLP6zEGlxwEL/n9Ck3W7u3lqg9u1+F4CJmANuybleo2QC/cefaOY61+11NOILl55Fi2/NCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613616; c=relaxed/simple;
	bh=w7Sg3OTyuRyaRiQvG4N+JqRxow347KotcJv6S6oFuqw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mLgFKmp8wtfHljUm+vYzsASUlW2YAtg5+XyuEIPE2XnzwpJXi3WLuLGUuKkKepX3t/gt90crsm+yYYRqJBapF861RvE8PR12a42Z5ghPk8nGYHnGOwwjeUHvjQq1TLe1cebe9uTFPIcPtL7C5Hw4TJMNj7BsHMSRHvjOI+8BEus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iGgPddC9; arc=fail smtp.client-ip=40.107.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHPszLvPdZ5Wuv6gsmXQ3eVGGJoHnkMYIARYFvfSkfJWPUEoQAVAq/Rxr/uf3v8eq44EyGIzR3HZeZ4jLTMetOJuvpAaf9TwZAZxBRdlZ89MCFEZm7ovsPXu8QVbNqiYDQdbOmWB69dwt79RTEPdFb3b5np+hIzflyXJjKSAGUV1P3Eyh0U+P4lVNfGUyW91skZobGRvlhySeO+WZi3e9mxMkS6Put8UM6YqaSqCII7V2FZT09F9rd8EPJ+/U2fVV16OkWFwuFfe8CSu5mQt9lSOzG86PXq7qZi80/DBqhKzfLBe68+kSGoKCx0jD8CLgJxehJaCHzDnKhLqC/rEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9hjlhEm2zpW1jYHawyyd8N75zcj67v1+9nXvZqywpA=;
 b=sbezyDyeAg7U/2CHpXdxuAMJLAOMiGRrUx+jwWbTFuQThBOHwVJ2jodzORIrLxz7ho5w9zWSHwjkvgd/ZcQRNTe/yLMunfe/gWZyOujk5LWBGA7I0YSkeYWBuDUXPc3nGlTPXP5ucfJbbW3dJaL3eXfSbP1GZwyaNCiIUsw9GG0E3rat/kTGcXBwBSJOFqT1PSFR27OgZeTxjkAHctIm6JwJ7lzATqzEJAn6GWM0UdGJUHM6vBeuQ+e+XZj0hmQ/yTbtHRh1ebt5WaJ4iUU2zMoRwdWuFHNb6R9UBoCrLMmUPg2c2wFPpUKMq4aY6aGg0pfGz5Mdpr5mFXEqKlDn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9hjlhEm2zpW1jYHawyyd8N75zcj67v1+9nXvZqywpA=;
 b=iGgPddC9exYyNqtWksq8ly5nFU5G1XKwit1RXkvKtwpXUli8Ol8efyzMWGXDAMgJbzTVTE/QB1dpLZRMySVxp6oXMw/0IK4nibCPH4RPPo4HgADBhEwaA2DFOBEYeD1Rs1diZZrgLwLj2XqPhS4l64bwj41vYnA+zy4shU9IxkLoJp/Ta36YTIdY3iDvcX2+mF8ils0tG0dbn0PfU4nc5Gb5wj5zgPTGXnIxQ2QXWK3sA12A/FCvmQdxeVIQRRfdr3b6e/23Pcy47FrqosMHZwnq/weMNuHDt9bqBsTr9OoEIZ8mn8M9u3uS3zV6T3rqjL4Dnyw1qzNmU0jvcQ4VaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 14:26:51 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 14:26:51 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	dri-devel@lists.freedesktop.org (open list:DRM GPU SCHEDULER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] drm/sched/tests: Remove redundant header files
Date: Tue, 19 Aug 2025 22:26:24 +0800
Message-Id: <20250819142630.368796-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 0631c2c8-590f-418f-75aa-08dddf2c7031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VD67bn16nd0Nyn6WzPZlK+IFAuQG6PRb6kLQKHguXzhOhpWi+HDtBvsreFMW?=
 =?us-ascii?Q?dAvjTOe4GmKWQ2wPTxU/S+WKe34yv9xTgel4lGFuiKhMiMnRhbrVjfvrgInZ?=
 =?us-ascii?Q?KSLRMlszDXJRLE8CsNzHjgwIw06cMg/MdFbGiGq/AOHotmZoMwRBtM6LNBZc?=
 =?us-ascii?Q?6UyHVdY6kRG4P06ZytP4UAtvPvT0evG5nDl2YM1Yt0x/9KTYdccKBD2rPjZP?=
 =?us-ascii?Q?/hT1XO47n/+pLtxdHPkorqO5Y5RbR1QQhf3OKnDEhsZvBxvRT65xcEoq7Ogz?=
 =?us-ascii?Q?zC+jIiVQVa1avaGpbX39uuduC81zGV2Bj5M5RIXAcMSHTLCeJMYiRNcaFQ08?=
 =?us-ascii?Q?RBd/CaWRYBSg8yT6x0fMlFnPqITF5dmnrVU/BsfwwTi0iTWEZ4Le0zs1/INk?=
 =?us-ascii?Q?qkdPM9BpTfEew/WiJSQJo191sneawllLzUn/7iN5jcfRRa23UOarQCJsDKSX?=
 =?us-ascii?Q?XpDjTKQFv/vCM2LSfnm20oguWUQnaUmjBT+aetMJ0cU/EYGyNu90tS4JPdZE?=
 =?us-ascii?Q?PTS7RsxDPQw3OAKF7NIko5PRM+gsaZvV0jii14hprfsbCjQkqwatP2T0hx4M?=
 =?us-ascii?Q?2vVe4fQ1Cabgg1eGbM6wgoKSNUYdtNznyxeCcK4WxeDJXVpq6GQKBuAot0DB?=
 =?us-ascii?Q?JiTFQpYhi6hS/lWnDkOw7Y05o+TNbLJMfJXme4nRlC02mVHtBjvPnt0kznKg?=
 =?us-ascii?Q?gBFI2nBAuIq3QMNYbdoLhex5xQLFKfQA0Qk6YE9tG0WjOxcIrgmW2z3aOs9j?=
 =?us-ascii?Q?BRh9vOPKAPcEarjpkOyNjSNfApVn9cwytrkWyS3WSIdHGxrYrMVspUQyVxgm?=
 =?us-ascii?Q?bVUmF00UR1/g52GgVahEmIO3esFztCCDRBD9N/MNDAstt5udMZfI3AwlMM/n?=
 =?us-ascii?Q?wuJomTj4GgFgSOn0yTzvxqv9ooHOxnfKsZBhJRmuIRH80GUikgQS+9wlKd4v?=
 =?us-ascii?Q?KDvRBMFx5iDj3YplrZIDfeNfPXlNxNoSVhmRqmHxEJmflcNI9Z0CqBei0/2d?=
 =?us-ascii?Q?pWDG1l/dEj8lU/8fm7LLf/3k69ZYGLJCFixWX9Nd9h+H73QDAQSCXTmymJ1/?=
 =?us-ascii?Q?51gdUCpxWpmh6DDGaWcRiJ27JCtIi49ZYAubpZ4mQa6NLeC2cbmqWr0Fz0RS?=
 =?us-ascii?Q?nWHG35sanotvPctk6FiKDhtmZA+4Ve8XtliL8QJwZWP/yKRww2W7RdfMne9o?=
 =?us-ascii?Q?xgONjq80y4c//3SrGlcmx/QtrYENVTzbJMLlFGnEL+ZmnOF504+jXQLByTU7?=
 =?us-ascii?Q?exota+XjkGjhCVjOq9oifna9iTMGcf8hcGSzCbXeSuGn8QbFCmSd8FY4th8Z?=
 =?us-ascii?Q?N0ANJVe76mVPVj6jlM54zO3XnANtLXkgys6BpJ2zeVDOHuTtN/mzTUvS2mPa?=
 =?us-ascii?Q?dPT80CtAYkG+yk196/ju6lfvu3NLwZn7PzcR2xJKXNoEwgWtusZISgAsnffL?=
 =?us-ascii?Q?G+WVafiU+9soxLtri/ieknrKFJSZV9LNoH/NecazZQflaWfc+jXtC/sklVfT?=
 =?us-ascii?Q?JRJQ2SzK2C3l964=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q6s7mnNaeXnUp8A221WzvO7oesvBWpbSfHYmv2mZHqGVi/boxS/ZEAjZQNqT?=
 =?us-ascii?Q?I8tLT3rCfhAGQhAVJGuvrpSomE3DV25rzztiF/vHB0InLv4KObY1vCoeKNKQ?=
 =?us-ascii?Q?UQ7Slg54rTbY1wMWg2exQ2qVEqbYT+F1bwekrrdyo5c5vniKfwzTsanr3qEd?=
 =?us-ascii?Q?kCNE9V7JCtp89vsjeXdCkfj57e+wYVJ2pLMcyl4dNnPWzN41CzkCPrO03vzJ?=
 =?us-ascii?Q?hyJxiHospfOn7ABXpifNyVgKSN3rootWJlxnJgf2oeRDIoXNRTrBRDnvElzN?=
 =?us-ascii?Q?sb1Q6hOXbgGADAs5UYn5U26LQFj08ghldBaZmDVrzJM2EUgIIM/1LbPaUwTk?=
 =?us-ascii?Q?Jw3ih0cAS4msGSaLH7F5iGRoOwOZhBldqmI+4VCtLpQ2IkFutarhN0mDexSo?=
 =?us-ascii?Q?GLlgn06LvfTJdZ2dq5oFzqhPQFPS9MvYi8qpW9Bb4eyZgjuB+RX3LPfP0xot?=
 =?us-ascii?Q?lXJK1ap+Bp+ycImuPVg7xOry0hVqlcduJW/DfNDt30RKPI6+tNCOzqnNfrNo?=
 =?us-ascii?Q?uLty7RnRBzrL5Mu2FBHy5ygoX8LcMMtjmISH6+HR/3eFGkvo+wQgCRs6J36D?=
 =?us-ascii?Q?V1gafLb3a+l0b7mRs0SI1s7y5GVIU1oWFpsFYLTQwrp/f1Da1EPq63A42Y/h?=
 =?us-ascii?Q?a8qK3b5OFglMQ5ahWY7LXtPcM/bcUwx86Rizw1ZM3TkvuI5OA705CfATF+6y?=
 =?us-ascii?Q?JPxpt01MDrb4/WrzjA9yArSA9dd7ktcr+Nd1PaypxG73BLFsznRP9aKAxjdH?=
 =?us-ascii?Q?VJ5tdf/A2V7qmLMtUSYd9M2VqQbr3mx5OMY2W6dbu4YN4nDwOY6BT+ad0vIK?=
 =?us-ascii?Q?oM/94baRTELNlyS0MMD01jDcc+/cbKq5g/ZDYoaq6FYhrMjZiJzadTrkM393?=
 =?us-ascii?Q?ylaibzYpmjXpdqgDFuPBGOoy5bbCmiVhM5X1XIDY2/A8ZLdGYqBbRcRRAd9U?=
 =?us-ascii?Q?zlhuWoKJbg5kcrRtx0qaXhzOR64nz3z5MM6eRMCWYC27tN3OhfwYZ5MQ9Rda?=
 =?us-ascii?Q?QHEI7xh1M5WTYz6Lt/N7o5o0v2uiYfPHNbH6p9dAzTjlgwX2iptSwnlrIcz/?=
 =?us-ascii?Q?YvqUVLVrsQn77wx5uHbwT6YdAoKIGTItB0jtBQPs3gVtnJJ/6WNXz+5IvyVE?=
 =?us-ascii?Q?6ZWIMbKzP4BLRpHF6zoTZA0vRfFyq/mg6LkfPqVcAkcKdknK99l5eJt7vXI5?=
 =?us-ascii?Q?bE8YWQW72Rdgy2Y8Bds2euSq+kb0NRz0RhUQrHD/i4q3GG1XvX6dYda1u7yC?=
 =?us-ascii?Q?qk6DeAAPxEjC/fHUFwSzhJSI6Hnlqfb9eZUEgiDZJL2qDqsZ3dl8enWSKnDW?=
 =?us-ascii?Q?3+SaNqvVwGdExogu1KifsncHCXaN0v3X4+t4/k1x6PT/JZ3CWL/O4TDthde4?=
 =?us-ascii?Q?gUynHAdEAbqgu2Wn7Y0N3tXslXuyLMJYPTBej/apc88AnhG+ETfByWHGENbR?=
 =?us-ascii?Q?vsfgnTxpahP3DIv/AUsJ9bcJxY6gdvDgHV6Y5HY7KiYBKMADa2sKvhxvit1y?=
 =?us-ascii?Q?yKQic0Au+ZHgLVIDazEH1hpbj0wLykFdt2+6gvSvl/HPNzxhX0wDvvgWe5wi?=
 =?us-ascii?Q?qXVW+dsLLOmkTdsWhMRPajDxlnzvXc23cenr6oe4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0631c2c8-590f-418f-75aa-08dddf2c7031
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:26:51.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei8t2mCMvzw86FEIPP+oAJZRNncQGJU0Bf9Gx/XNUpxpcnHOLbzzchD3/q+Q6S9U/dXo8VlgDVwTubPX5q1wWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5134

The header file <linux/atomic.h> is already included on line 8. Remove the
redundant include.

Fixes: 5a99350794fec ("drm/sched: Add scheduler unit testing infrastructure and some basic tests")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/gpu/drm/scheduler/tests/sched_tests.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gpu/drm/scheduler/tests/sched_tests.h
index 63d4f2ac7074..e25b8b9b80eb 100644
--- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
+++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
@@ -11,7 +11,6 @@
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
 #include <linux/list.h>
-#include <linux/atomic.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
-- 
2.34.1


