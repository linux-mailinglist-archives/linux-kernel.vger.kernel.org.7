Return-Path: <linux-kernel+bounces-794640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D918B3E4A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FD53B2E40
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6581323A564;
	Mon,  1 Sep 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VmE2FFWp"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013063.outbound.protection.outlook.com [40.107.44.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01E15539A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732880; cv=fail; b=OsJaR+dB95Hw1T5UFthQO0Pv2tx85ZRfFpOiy9m41OzEuIfmNb5Mmbc4F0nsmRqqs3pfUOvNCeyN0KzZIr+VYGXQ1YytzgBVQqB26Xtz36r25HdAgM4iJYpCN0CGX2ZsmLAe6n81rNfvIy5z03MzO1MdfDe5F7uvbeluRujZWQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732880; c=relaxed/simple;
	bh=/BsOHZDGJpQ1cgkjXqofMP2QfL4M49NCppajgNAuYmk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e86fR2fEYCwh9GvsLQUba/uumQxAZ4Ra8eM1UTqe30VQFX6MIXHynD0a2YN30Z9f7BTbBbI9tFvRBY/MqNQA2z3QX6XFLFK5B9nv4/WKKVeNDJjmtIA7ePV0MVY9IiFhtk+t6uIRvn/PhY+0Wb50+ENngWlsM6MtDx5LcWiZ5lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VmE2FFWp; arc=fail smtp.client-ip=40.107.44.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxtW4km6yLmtU5bAcXFGLJW/YQ8fdLzW+KTyUoBIewkayDbWSg1ZDOYDUkKeOmkt4j+aAfnS/StFvqIfciduDtKdvlVZh7iVgPhEBt9BexnkgvQnq0mdJin/iqDVaVYtaEokx9oAEA0zgMoOQNqBq6HkH2oqRBmkCulRj0Cz6847n+6DU0VEn/T+Bssg3oD+MyjD+tYd7LIwEGRmeS8tZsJm5AQjjecEVhT/+tUvVylcsKiVsjHxubTghIIteidbsFJHjY21Ueqwpr5RCXUfuaVvleq6XD/bCSzadfoVM3Ku5Q+U2yaaTPMT7qGVwzzLbkZIpeLCe9wGfM2OjKxM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYsosWLyUUXLmhGycs9H6ILRMxvA16RDUSb34hB0/Dc=;
 b=YGLRVKjfQ8xhXHfP5C7y8hgRQTYlTkR+33fgvAXIF9Qvy2K1Yw+ekaBW6VJhOFJD71JaLW0H1Ui6Uogko1q2AX3s3uDOvfCWSMHzbf3CGiuI+jf7fN1Hw030OYfz91AywIBZ8N1pXZCbWlR15dSgr7s+KgZwQ3ZV5PMUR5tOj6m5gp4kVW/ohBuDmyHbKClae4HZLb6lVkq+O7USSa7Lu+kK52v1AJ0Hut8NxhN6TN7l5buAE0KYnmpvkZ5QRfNy46zipFcXB0i95qhE31Y1A5nVHJdsFXPyXE4dLxIyvG3Zxj/xKVSWuGzA9NOH0sdKs7UR7hWsoGeiKTENw/+a0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYsosWLyUUXLmhGycs9H6ILRMxvA16RDUSb34hB0/Dc=;
 b=VmE2FFWpJx92CtvDqkC+kqWGumqMe75X+ovTaxLFt5qJ4/GJ6kZrS+8tUQ/yG5KrCURl35xC+MReNpKB5zI6EvxdwpQotMTiVELHjt80o61Uc8nREG4eKK1PsGEeJ9XdYCh2J3oPzfYyKFMmD9VJhd1ZM/gv+J/SSInCnQ4OaGQ/AjasExmFR39yt5Ba5yaw6NwDQKA6lXBeWHeYEHfr+XtMM1gg50q54E/L9LI9Yt+sD+RRolUHi7rKvFcNNnUvfKUXZ4hEodivB//QVUCnGgIJdfLsLslI6V0/aoappQ0qaTkIofLw7giWxsd/osZ5X7hNI/v/u1WXO3LkWgP8xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by PUZPR06MB5698.apcprd06.prod.outlook.com (2603:1096:301:f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 13:21:14 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:21:14 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] x86/msi: Use guard() instead of mutex_lock() to simplify code
Date: Mon,  1 Sep 2025 21:21:02 +0800
Message-Id: <20250901132105.649816-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|PUZPR06MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 216f1e51-4547-4292-0874-08dde95a6d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+xLa3PpcUPG3w61PXjbGjya80w4P6vtEUHyuiC9kzRU4omuNtjGBOQWBzej?=
 =?us-ascii?Q?j8Kqg3QBNqRzA7t71Bf0aob7Uf6lBfZrjIb+G0Ha7nuZuMn3vsBGtg9sZD6x?=
 =?us-ascii?Q?PHU9Wo0KYAPNBrmJqhXOFvYw1io1STn8lKdwkI7fqaSNYgeqNyuHZi+Z0MFu?=
 =?us-ascii?Q?HA2NA5iDtssujUzYf8B55kmIExTpXV5w6aPyzo3uZhFmkEO8Z7lEPcrPH11E?=
 =?us-ascii?Q?7Ea0JTR3n8uCa9+ISXdkCO9OpSXvxGB1aSaNBqC13Tvfjre4yQWtnO90MA6I?=
 =?us-ascii?Q?GUApPBpysfW2RTujBU0aBmUSSPdXK/m53kGVC7XSociLH1RM6jVxpf1iwvxw?=
 =?us-ascii?Q?aG/Ii2kmPmoXkVm/FBp/bTX0uNlwqAakHSw3Ri3l+QzD1ylLcf7AQQj1TDrs?=
 =?us-ascii?Q?UHD86YZaDtTJzBWlHAmid/LUT1q0L3yMYSHebJ7ulmBgp3uwnPotQFJrYYtP?=
 =?us-ascii?Q?b+UbbB0DfjlCPY3zkdOeL71cCYMDLpZLT3uJa5FC+cqqQjJJ3DDyVXnkgNsx?=
 =?us-ascii?Q?VAtTMC7jvZCc82x7772eQoaG770oUHjLQDF1f5LZAszxE74jiRsuE6lcU7OR?=
 =?us-ascii?Q?GynB++a38/XbdMPZUAoBGOFHLkwqoucM2sPWirm/iIfbpD9QH1uA8sG9bSen?=
 =?us-ascii?Q?aT7Fe4SIv9WyQhahojZXj7vxqImGPO2MMr1vYpNfJgiRMmDaS08Iy88upA2/?=
 =?us-ascii?Q?1lp1BKUy4je9xpfNC4CB1fr0uVIZgLlnn7ry3gdTMuoIZqD/03+vUsy7qSIC?=
 =?us-ascii?Q?JkXs6oTCOuuU24Patt3sQdyRxOBkzw+PPm/V5g3hpE/0Hd2/khsfGtpg1a+q?=
 =?us-ascii?Q?EisVe1nT/A8XPJdXWKNJ+fg5A+XQGtAw3Xf0Ci1BsSyYplGbapiK4Rcy53+/?=
 =?us-ascii?Q?XQuNLYXeiRQi32Xpr7AQ64/5aD72ZM3UihX4XyMBQvvM+rxU/qvyWGRmKTIC?=
 =?us-ascii?Q?df9WQaYbWQ3NsHK4+z3einXhs79hzpqGRpWiEwhHTfglxGqeqSAIslVbI35z?=
 =?us-ascii?Q?d9xqUCtqDz1AJGJ98B/j58ekkZDrFnQampv4JSigLBoSAwYO9aYqhW6ASPXw?=
 =?us-ascii?Q?wYIgXYitbSwaYZqS5H6mJP94DDYGx81ioY1eIUJ4XDpi4VXI2tP9VeH9zWKI?=
 =?us-ascii?Q?X76xDmDqdZasjUlxTND7v8elsPzelp3Ezlc1+pB0bUUYG91KUQMNntFKZ+A5?=
 =?us-ascii?Q?qS+XsSCj6yL+yfRFzUHjPVa60dXYMa9O5WOVLb+p1pqi5ymurcjZC1/uy+p8?=
 =?us-ascii?Q?t3GP0MyxtneHq7Qg4sZxfw+qW/myYmnAq+MoWG/qVIpEdD/Yr4beBaz7sIuP?=
 =?us-ascii?Q?PTG6JHawfTAxJpi47lJ0/o+/QuzGN+qY7QKPds26ONlrKeBFOXNbZlBiI4y8?=
 =?us-ascii?Q?2ZNT/wPw3cmBznoyNoO30uFpBxC+bgjKQbzV1NEa6dUZp3lw7r6fc/C9qMV5?=
 =?us-ascii?Q?1U5yn+rE7hS61edukPqk6AbS+I5d0tf7acq57oRfH0KZr2C+W7DUAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fFSy1d/8/7Pb4vJ5zR3CbwOY4Fp3hFaxXp3bNHK1R99NSoMVWPxAnbvXXNMC?=
 =?us-ascii?Q?dUl4QB9neOk6TkaSyoB4k9E5iFE1nqgxyRjyQreQS7Wivvh7ilxDr+yMr2Bz?=
 =?us-ascii?Q?GW5BNj0jdGExbAIhurEqUGdKG3lTEjWT9nePoLT7krht3IkKhldEfeS01Uvv?=
 =?us-ascii?Q?B1kDKTvtrGLlO9wSSpJUQeK7CpYT8xT4lY5ZXdwC89cZbzIn2uws81Sm55Y1?=
 =?us-ascii?Q?0108WvM7iPUMYsJYKjuHz65OhbhJngt/rJJfn43B5ZeZN8Z2lpKP0Uc1TBQ1?=
 =?us-ascii?Q?xO8Y1PpPGTNIvG1oeV3IDawgeRAUAaBTzU+IvihTuVGscSdeT4Z86msFZcxf?=
 =?us-ascii?Q?xEGqg6h+MYTCXruEEzFlozQJ+xDYyzDP9agb6y3nJVXhgLWVV7oqanVANXj7?=
 =?us-ascii?Q?/HuuIKEAQOy9+AGe0/UIrXw2LCEKsISrQULQNlD/OC0SuGPuPqvRqLilRPo0?=
 =?us-ascii?Q?HYy8DT19LaNVqcgQQekGN5d82nIcVP8tRDZl/GFzbsncirJDz/E8tkqr9X/8?=
 =?us-ascii?Q?H7RnckxzIqcaD8+qd9myUPIulpC2Z96uz8QCF3QolUmg13P3oQZHTZrLsAgE?=
 =?us-ascii?Q?0tVo11Saf4BuJYAlYn9MFRK7SA34oik4p5BumHxoVxCPLTR+iKqStIfyqcOY?=
 =?us-ascii?Q?IbKJa4dU1iqW5FJccPzdQ/6EHz+MfI+PBV8uUO6n3aYUDcSWw2h8h6rYT526?=
 =?us-ascii?Q?18d0B1N53XjRLzdd9uzDqM6owtGHgbeTW18vdZwlLb3IRft/+BvL7r0AqwVk?=
 =?us-ascii?Q?AUKo3y9o16rFRC5spwkRutD7uUUe7pgcC6jbpzlirpavk+KV1uOKRJ6uVLr7?=
 =?us-ascii?Q?osIJmnNjK1qQigHHAApcrrwIuPGEsLc0GUULRatXx/429qWK02Rg44QLSAKh?=
 =?us-ascii?Q?/nHqZIoxYZlFI3VUHEB77u2h+ePenFlYeXDJB2bjUdF3igUxY40Zudmr1rm/?=
 =?us-ascii?Q?EtSe9Q6qIiSLEpHQJ+6V44suzpDcBXxMScqvf/eldSHYI3UjM+eBzOMI7fnM?=
 =?us-ascii?Q?dMflTAWIF1WjpuZ3TGSlHHp/yIZ1YbQbyygXN5BVft2WBMWe0nhChaOuZn4A?=
 =?us-ascii?Q?nkqn55N4SVG2T6Da2sILsyXHI4WP9EhGFhJAIJ54v7NtJdcZz1VUpmp4L18m?=
 =?us-ascii?Q?NN4Uu2SnUq39Nc+6UlzVL0NwtTiA9+1oA2aUqa3187rQCGqCoB5ybs1KPePj?=
 =?us-ascii?Q?n69ihLq9ql3GmRvvyoIZgEK/v1YkFZhoHRXkKFjTqBO6TLgFa09rpdds2wdh?=
 =?us-ascii?Q?3uuLgdqZTOFyor2G3gmVJEcPtTjTxA4eEk2Xr75EUMNdGzLVWOJ5n3IiHgRK?=
 =?us-ascii?Q?aogcebC+D3DecQyFr8wVW954Y0iMoITRHdmSAqfpTadBIE8L2Ho6+eS2xECw?=
 =?us-ascii?Q?vL8wHkhe9U2sl9c79dh2i+/PzfbjkpHzthIE7/qfC1FGSaUSxT5ymttikWtt?=
 =?us-ascii?Q?Jzl/2LBSdzxh2/BMangeDjlMa7Acv181X25lhBM+fMcH4I3qr9DxjhCk1Z/4?=
 =?us-ascii?Q?UfDvo5Kb+HBRXOR2Ws1prJ35EHRr0c0+06YQTvQN40rfDgJxETZ4t9ToStrV?=
 =?us-ascii?Q?9c/I0Ok7uVgy4szWRxKStTgwlHaeUtBESq14VJtv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f1e51-4547-4292-0874-08dde95a6d10
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:21:14.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INtGBJRIoBVFlZDiAsgK2eh0pJV2ExhDlNDS7pcHpckFZHCdGxmUUKqjZ73eQJbGapXk485ZY4Ghq25xt7vP+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5698

Using guard(mutex) instead of mutex_lock/mutex_unlock pair. Simplifies the
error handling to just return in case of error. No need for the 'out' label
anymore so remove it.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 arch/x86/kernel/apic/msi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 66bc5d3e79db..e11523cfdbc5 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -346,9 +346,9 @@ static struct irq_domain *dmar_get_irq_domain(void)
 	static DEFINE_MUTEX(dmar_lock);
 	struct fwnode_handle *fn;
 
-	mutex_lock(&dmar_lock);
+	guard(mutex)(&dmar_lock);
 	if (dmar_domain)
-		goto out;
+		return dmar_domain;
 
 	fn = irq_domain_alloc_named_fwnode("DMAR-MSI");
 	if (fn) {
@@ -357,8 +357,7 @@ static struct irq_domain *dmar_get_irq_domain(void)
 		if (!dmar_domain)
 			irq_domain_free_fwnode(fn);
 	}
-out:
-	mutex_unlock(&dmar_lock);
+
 	return dmar_domain;
 }
 
-- 
2.34.1


