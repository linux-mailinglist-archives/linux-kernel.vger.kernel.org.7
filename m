Return-Path: <linux-kernel+bounces-885482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F18C331A2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3401F426B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D3346786;
	Tue,  4 Nov 2025 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jzJWPUOo"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022115.outbound.protection.outlook.com [52.101.48.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EF2BDC29
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293006; cv=fail; b=aTOiuQOkpm0aFyXNxvFsiDSVzmoNJRuIOWikPgNpW4gjmdmmqb1QS9jdI5LoZZph0U07G+6Cl1mKqxsLyDFt99YLUleSU2b7/dU3RxRz4X9/+J1yiTAs0rVIiIdqdOKVyf6Tj9ZwzU7nPIV2AIbh8b3+Mv8LLQI2CFxJn0IApD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293006; c=relaxed/simple;
	bh=MOnlF5+cbYdolQ45A4UxL9EsT89iqVcn4RPzoUBPnEs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c6hVZnogJnXu2uU5BgyJ44BX84zG9Vwxa/7rZsvQiCezRb7TU8lb9n1KaTjHtGoBbsuFs2jAyngXSdaqO40MjgHrNolwrKZVPEfJFdnHSI/qrWdT7REyhIoufV5D9JUbPULm+hYzQvcR8gvKaes2FDXKm73AAPb34QEGA3XNx28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jzJWPUOo; arc=fail smtp.client-ip=52.101.48.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbZVNAgIj+Z8r7VbE6b3UfN/svLPYBnv1Bzu4Vvz/ba5YZ9lncSRZZPqcvPFkdh42a2fMxYLQ6646D3+vGrxm+XmHfuRr7vYqlE6P13mBJ9pQnZqhGIgP+3KIqSOX5GVOvay3LjGR7sYuyvjtp6E4GLfLaalWKu2NPAifrRrYprab6fs7Rc0hl3/C0q37uicEs+cz7hPNbIxE9B7ft6h548DTXsGXjXF1r2VA9/JzQcxciOCZUsdsNG0WL12KaD73bhPGc51xoibAmAOd+M5Od/lHyHNjUyDOB4ph2Zp7Wm2vYINpSstfUmsE923gjtB+UyT9RgLlsvfUGgACAhwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP4RwYz8oJZ7WGOMlw2jvJXCq+XY3Dor6t9LWHZQL+A=;
 b=yyaSyKetjYO79QiaDIPNsELG5Zry20qlVxszf3Hdnfzt7qPe5KlRwKrCoO7CcEJCqbrmFjYIdZmhV/A+mIW5CcfknjaxOayxeGu9lKRFZiT2VzsgWwOaKqaCNVNrXb8XNGELmpwpE++pI15OYUiYlDFQAPRbUYs+lw9Cspc0yH0AipKkTvWe2J3oIUkHAHuadgDdrzQR0hx5yq7neoIgHMOPzHYo/jjJJ987v20Ish4mzVjAuV/w15VkeM6aYyaQenlkHWmuam+jZgc1upMV6E3WlGfwC3bhIAwXdSOPUO8K+/kRBDjtTnfF9E0UfulvgXOUl0UvLSmp2ABZQOx9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP4RwYz8oJZ7WGOMlw2jvJXCq+XY3Dor6t9LWHZQL+A=;
 b=jzJWPUOoiMK0Pi8jxYn0INpB0xXedMQx8kvdRV+m8P2uETaBQ65AiPkn7A36P96KaI4zs7nbpvsRyrQMymNUn20Hrir02k1bTQ7n1u8idL618RhxL9gaulHDcxIQ68J4oh4dQ1Qo/rt6XGWgja2PgMwsDRmeq1vt6ktsASgl864=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6691.prod.exchangelabs.com (2603:10b6:a03:354::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 21:50:02 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 21:50:02 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	punit.agrawal@oss.qualcomm.com
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH] arm64: kprobes: check the return value of set_memory_rox()
Date: Tue,  4 Nov 2025 13:49:47 -0800
Message-ID: <20251104214947.799005-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0089.namprd15.prod.outlook.com
 (2603:10b6:930:18::35) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d257159-40d9-40f6-cd3a-08de1bec1b65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f8qoi+qEXEkzS0TYD2EaxOh/bwEUNeRQDvp9bOnyrTv0CDG0Id4uc+QSO1Nz?=
 =?us-ascii?Q?bnd/k2DrjDO3RK18kugfaJ3hkcXabIHATD9biGA2fM9gg/nvNxEuXLdScBZ1?=
 =?us-ascii?Q?yth40o4sfRmP2NxAorYRTvQy0fCr/+lwF/UfWoap8NP5LMVrt5gEcxMdduOG?=
 =?us-ascii?Q?tSahQ6um8V58U0/0g4Vaa80zaXVvLwb3d5uwSJbx4kHjeeeXk+Wk15iXYvPz?=
 =?us-ascii?Q?8EoiCP9A85Fals/6zR6Xxl5+dyFpDSGYNFT5lDzwAZ2Dse0I9V3a943UqCvD?=
 =?us-ascii?Q?hJ6wvjSjzL0TjC9I7CWf2ADwwFwTKwqODmrnaLxxtfaxq5TvFOFmL22oRvB3?=
 =?us-ascii?Q?fYetPat/Mn0VlmIdsPH9otfF1s4dJ0L3eefKNS06mpZjcezg8OIUUe1Sgyls?=
 =?us-ascii?Q?4DPTFaxWKZfK4CbFh1+Tf8kWc6zn90ivW00x2jtxSHXSaUGnPzXzkf8a0ZOj?=
 =?us-ascii?Q?1X4d+vrV6MgZxNwJYGukkmy9w6wfvcYNAaYOjwMLatT0byicyJ6yTYKPDAwk?=
 =?us-ascii?Q?901uv0M/pwq9i5mL8mYwPvvgidvV+NoWigiWV/CBu3CF7BTEWCOsXNryvdoU?=
 =?us-ascii?Q?SyQo/S2cHxNH7X/M4SgNcAGtgjtqETjCHkndDBexhwDYhG9kv4Xdjbc22eif?=
 =?us-ascii?Q?tr5lISCbtFlN1xLnVfCeS+XOTASarXnQIQzU1XSl2FWPm/9laCHPhGw2SP85?=
 =?us-ascii?Q?G/6hb9htTULvXW8nIzTpVryymSUnR1Vt7qjChAZOEsSS6yhKIbHyHGE76GbL?=
 =?us-ascii?Q?vlxkEEYTJUk8DkzuSw6y5ImkAs9lAebtv/g10jMf7VN7N0vSFZxC9zsAjzxe?=
 =?us-ascii?Q?VXagT8SFUZD6oUWNoupNXQ0STyTtblPcgP21uO9bW8od8YA81w+8/5uYH0lQ?=
 =?us-ascii?Q?aiOB0s5kRR1soDUvaVQk4hOdw9OgH2UPSO3V17QnuA7T800IebOJ4g5sqry3?=
 =?us-ascii?Q?NV6bFerz7/kszvgYj5YDdwe8lhRjsmsgHaP5sW0QOYseDCsQHWsg8DIoVJdX?=
 =?us-ascii?Q?/CooQDwxX2/1A/gZIWvdjY7qBsuMceD78EGglsNcLdZJD7+5kU8vlR6y+K+e?=
 =?us-ascii?Q?EKUvOrLopYYSrNHkx6oimNB/a2Kwn1Mw0gfWBXWnd1HX4Cky2jIZRO9Ee9LM?=
 =?us-ascii?Q?KPe6rp3N61Yi+Y5h5KSWKn9stTo1X2Rx2I6Bq+m6Dv58tmyUJv5IvINbeUyj?=
 =?us-ascii?Q?FSO/ol3PpuAIIPq8FCbV3RtTVC84V+IjJG5ECL594PREzVmukdimAW80QJEP?=
 =?us-ascii?Q?mNgBCb0/MDnMOkbHuU1TZKTMj9nJumrIODIQq4dVe8eCwMgywAMV1+vHLpWG?=
 =?us-ascii?Q?u+JmsIYC6jpNrczM5w2NW6tTZRi6O7fG4oPCnluxGFcyhdHJsUsgL7eudB5D?=
 =?us-ascii?Q?R60HPLnxYDnhwMcY4Cg7yus9XPiGnKLFTrYdUFjalyAOlF5nkJEZLWnOsI0Z?=
 =?us-ascii?Q?tDIb3syHL6jnoUn9DNoyj50XkY/+27gNxWjXWhlWmpgFSuAlzOJzAf2NIW88?=
 =?us-ascii?Q?rSNF9c9D4accbgTZ9EqDkvK1avY9PCQa8LeP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ol0wML56aq/S4GsySN/V8lu+0p7dq8rVRv5Zc1aNXsJkKcx+B4bOIA3OhGKn?=
 =?us-ascii?Q?zYd4NVjvZAbxWXS74nW4pH4PJwWY7tx1RpeoK49/7RYghdRfQmxt4i2qznrM?=
 =?us-ascii?Q?x3aGYBfgoVA9qPewD7/4UMXQKIXOPu13RjMq9NCvBACDusTr7/8/0BG+DQ1G?=
 =?us-ascii?Q?ofv1Xbw/An16cJM9V7d7iJhIfRCc/nccFxRBD7aFOzX6SiraFJEusAonpw58?=
 =?us-ascii?Q?eAOMnfQZcXYt5kAzcZsw7hO36COWA77KbdD4A1ZUSQyhYh8JHcu2VW63Wr7h?=
 =?us-ascii?Q?7EnZdfwOE0F6jhCtYMrCjGXi75Vt/eYKEaieE0Gi4WuaXHZDv4ApPucVYnp1?=
 =?us-ascii?Q?QB8yVEzkAUsL9/DmVOfDA1EOEIaOpse5csQZPhRN489kjghm2HGZMTcViL+W?=
 =?us-ascii?Q?AXZVpowpp36tnX/w7a29e3xl75sfL7UMzwTt7OXaq9VfcLijJ5snjLah2+ax?=
 =?us-ascii?Q?pbQuregT/JL9y3ncNYUDaJpnGMeUU7e+dNUeqO7yB8BAqYeNuQMmb8Yvmh+M?=
 =?us-ascii?Q?RDShW0AgjwMwjIVCBUBy5zsjRnnPooIllOO/bm0/SJfw8o4KQcmyIvZq3wrw?=
 =?us-ascii?Q?3B13tm2JLNxUPapc12ED7U6wC8Oyo/Cd36nkkrG6MYeIadK6IbBHKPjTFwRy?=
 =?us-ascii?Q?h8NJzFXdC4Y10Or3hfG2j9FCKaIsjpMX+3EO2aMqjJplEogdEEGQownBrPws?=
 =?us-ascii?Q?eRkpP+4tdzw7kjxotjPQu/RvUXtfAJjK9QYpcQaBCkxnw0pUdT+xXLrhs0KF?=
 =?us-ascii?Q?AQPle7v5GW0MwRjrCfRGDfhUAs6KqvD3Mvi1L0YkxcP9jM02AfLP4zVBRnVf?=
 =?us-ascii?Q?Uqtx8FiP3RJYN4p/cs4BHIdrfs5EhS4hdLYHJ/das2By0vefeTsrFn4D+IWn?=
 =?us-ascii?Q?SSxw4nS5KEPUm38nHpksT10uQzr3hGQqXEANyrXR4EXa1nZkewDeB2UgSPwZ?=
 =?us-ascii?Q?d+xSqtGe+M2u8oYVWT8H49z0n8ldMmE/zumVdz9nrMlzg4b8JE8r1VOgNk89?=
 =?us-ascii?Q?cCcu/RAQa3H+hzq04qNciZbAb3tvGOBGn07+0Kgt2j2iHe5L2yRmHlfXojqK?=
 =?us-ascii?Q?lPvtVO7qZWqYk8nVPjG9CUnmBJWdahqnOeRbNqGLZJnyVfFgRNaiL7KdjIiA?=
 =?us-ascii?Q?1atEPoRc20uytTXTtN850zcRMVi/zi5o21VTbhTvndAlY6VF27+NEjg1eTHk?=
 =?us-ascii?Q?FqRp+S3uU/Z4edZ4tUNRNx/J0gMWgsJX1iQNtGMv1LqfGVbNehEggARzV2Vh?=
 =?us-ascii?Q?sam3p3DBsgmLUpdWah23cXqdJ1H3XsdQ3aAmqtqgRGDebYdWVYUGAOZwwQSv?=
 =?us-ascii?Q?OG4FTK0l6i0dd4vIPJzw2MH3mYpfVHYmpSeffEzBqMmANKhebPU46z/wabIL?=
 =?us-ascii?Q?BaqNXxOJglH782rAGBW2QnzTS2B9A86xtSEMsQbnJ4ind8W7bkUyFmBm0lxs?=
 =?us-ascii?Q?fARdm6MNN+am+xIlEwK/yp2rQ1imSaERo1fKrv9DSv70dmIh/NlQKhi54Pge?=
 =?us-ascii?Q?WZPUWIZLdoiCZGe7jIwlWlnYv3jBDo54rXJbV92E58PCccxPX6qoaDQTUZZR?=
 =?us-ascii?Q?MXkFeIH5IMCR+GsTgFdxWR5i7fn353as4dlXS7k1IVehElpuVOFXh1wG6vTP?=
 =?us-ascii?Q?pVy3L3mcLPJkpiut7NfKGV4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d257159-40d9-40f6-cd3a-08de1bec1b65
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 21:50:02.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUb8EN4ZQWtIaHQ8mhZQYwtXmg6JzeSCot0wmT6JcG8Ni2YJOjNBsuOKkabm2ZsdPB2gBavFF8ioszS8cT19L0QY44jLpeXiG0YfFynKwsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6691

Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
rodata=full"), __change_memory_common has more chance to fail due to
memory allocation failure when splitting page table. So check the return
value of set_memory_rox(), then bail out if it fails otherwise we may have
RW memory mapping for kprobes insn page.

Fixes: 195a1b7d8388 ("arm64: kprobes: call set_memory_rox() for kprobe page")
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
v2: Fixed the typo per Punit Agrawal
    Collected the R-bs

 arch/arm64/kernel/probes/kprobes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 8ab6104a4883..43a0361a8bf0 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -49,7 +49,10 @@ void *alloc_insn_page(void)
 	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
 	if (!addr)
 		return NULL;
-	set_memory_rox((unsigned long)addr, 1);
+	if (set_memory_rox((unsigned long)addr, 1)) {
+		execmem_free(addr);
+		return NULL;
+	}
 	return addr;
 }
 
-- 
2.47.0


