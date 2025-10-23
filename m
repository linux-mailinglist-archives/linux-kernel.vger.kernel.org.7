Return-Path: <linux-kernel+bounces-867317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E527C023E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C44F7D45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA67223D7E2;
	Thu, 23 Oct 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IVCet5yb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="YJBXPGjk"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA11ACEDF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234580; cv=fail; b=TZfrh8IGwz8RWfBSoQFWvbyYay37e1Bymgmduse01/TQzBEDEHRlRDawA9TEebr2IzgvRO+7xx6FK//LUlajn5vKkK05Yq70k8zE1IPqgnEnJ8653So2JRf5+BjN/dcSW8FcmHbRwYCz2j5z+PLKjJORQwH2B/gc4FZ/AfHXowg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234580; c=relaxed/simple;
	bh=wd2v+8QLAwKVKJozhbnDQY5wJ2Ld0ibXmAQr0rJKmpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+T/jD26VCcQxHRmeWJdvcsB5m8IDHWBcgkEVCidoeAxY6p9IRYO7dibtSzSeZzfJeXoglEK3UF6qLLRUpBU1HVmnyMepyJ/IyY5/2MoTvrAyzLYkb9xKx6hWWfisOu0gb0+//cJWb+gLv/S+SoJYoGmLIZd2fdeki6pYMlWXTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IVCet5yb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=YJBXPGjk; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59NFWx5V3660629;
	Thu, 23 Oct 2025 10:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=7gtUXHNLtB3jlsdSLjjKYllmtXchjjDwrkS76MsoQBA=; b=
	IVCet5ybUiAwtHaGjZEnxPRQJ0MccHfdqYnEZ6dmyCFc4CHJ+uyC24H4fPXmxgFl
	pjmgMvRmV39zPR4kBmhHjUXEkHfU8ZRD+ecq1avBUYkuNxaOCEX7a0Po2k9+MdCa
	sB5QE6E5eD6uR6yRWQZoM9Vg4WCiNk0nxJP+GvhxG0KizuWZN334G+Av1aJfMUoW
	J1aADdBrbknBiuiqKdu7SChQVZubozL1rawbWaj9B4Cwvv9tkhdDrZzE38VlD5S6
	8zGD3468MlMcJply+MMK5PxQGeUDhy9DZz/jDv+LV3GFXLlDKOZVQDdzMHVqIHCr
	HfCrDRQfNfU+E4t3xwAlWQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022089.outbound.protection.outlook.com [52.101.53.89])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqtfp7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 10:49:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3O0qHfGITRUBLhoWAEfxHs6v2xIkJWRRyKexvHD1g6kQSSfW9b3oadsaDZzHnl2l/DaBDdl8SBHUM08XCJ7Jm9WrqtwQ7pdgLVnBMjvZYRffIPQOsUvUD3qT3cgbD3L8hlJW3pmEfXZrX7omYKkwN8OkGobrBr92g/D6dBev8xa6mdLLWqlMEtNkp6lETWW6Up0kSJCf6QIWhUPx8iIOQykibpX5Tt1GHMaXzXYlij1fwEPt/bCCbbEaRKytTGswZFuE5t+LaKY893HZircvKksj9NID6BJNfI8FNMF8qlnE6S9Qim/D4DRpMvCYnInuDOrxutYfHAu3WAlDxt+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gtUXHNLtB3jlsdSLjjKYllmtXchjjDwrkS76MsoQBA=;
 b=VpoRWK5IQ9DIDwuNEM1rt2B2VJ+3IHpPfR2b/yaLHcipf+C/1hycz+GCCiG7pjUEW8VkbFJLsaLqeGNUqoDyqaMWwqvfzlF/2ZzLso2TKaCR39qJO8gOiTdUIy/2iNIbUf+PH5MtQShM0bKaLcgUtkY73vg82fW/X8BBR8fjbZawuVVjVhGjjfhhdNRq54E6VWf0iz/xA39LaiIRNcOixuIGgkeKJ59s43Ytqy7Q6CBofqz8dK+41TpH6DyK3EY3FALkChPFVIDr0MlP7OebeKNCaunr2tFyhAk8zdE0JIpuILJA8JH2yorOJ4f9BQh6i6fk4LiUOoi3FExRDrPFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=infradead.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gtUXHNLtB3jlsdSLjjKYllmtXchjjDwrkS76MsoQBA=;
 b=YJBXPGjk36f2o8JZBE90KjM2GgIvbtdmwbiRomnTVMpUZm3lVlbAMM/MuA1GML/cLpWpmIl7gHAUYTwEfP+fGwkTK/1XU372zqsDCoYAVl40R6cc0tuSHAfyHioAn75IFSL/IjLAiR5Q6Xtu4MeE4TDIz3t82qYGJn/uTlWyo4w=
Received: from PH7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:510:33d::29)
 by DS4PR19MB9001.namprd19.prod.outlook.com (2603:10b6:8:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 15:49:09 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::a8) by PH7PR02CA0010.outlook.office365.com
 (2603:10b6:510:33d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 15:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.0
 via Frontend Transport; Thu, 23 Oct 2025 15:49:07 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F3B0840654B;
	Thu, 23 Oct 2025 15:49:05 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E74AD822541;
	Thu, 23 Oct 2025 15:49:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: tglx@linutronix.de
Cc: peterz@infradead.org, broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] genirq/manage: Add buslock back in to __disable_irq_nosync()
Date: Thu, 23 Oct 2025 16:49:00 +0100
Message-ID: <20251023154901.1333755-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023154901.1333755-1-ckeepax@opensource.cirrus.com>
References: <20251023154901.1333755-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DS4PR19MB9001:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b79ebdc3-01c7-4ebe-4ae6-08de124bb386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKr3yJi9QH+bo6iioCv+UJdHBgA9BlT8FPnSDskXdICUetqLbuQwQtaMHSc/?=
 =?us-ascii?Q?5/gNsSUH+2TOMvGBNxxit5jSVWMmiotl2k9C4rQ3DSb+PSFgRN8VH7GkZSLF?=
 =?us-ascii?Q?1DAlchnSScZWR0GIC8yAJ5PRX/pToStLWKSAajYDPpcyuXhcXEsUahzHTkuO?=
 =?us-ascii?Q?FmrnamDlXxwz6nxf8ux2sojRf+FOgiiWwjNalmhqbetuDK3gkStc7fkieN5z?=
 =?us-ascii?Q?g3ImXmh4H+j2Brc0TM0Z4VJq1tQPhBkw8rUqJIoPppJ6dYGp8lx/Gj4hh7pb?=
 =?us-ascii?Q?8dBLppSjpXD+3YzR1txT8UNDTkTsgIlhUQq/QBVhBFC2jYRsQTV1tOLykNI5?=
 =?us-ascii?Q?YfAav8BJmqqgsPwtaAQP79uDKljGeyMHCUQXPD4B0/VAJc7gGzdRUA2bgM7m?=
 =?us-ascii?Q?iFV9TbYSa0DSUfKV+ijjEnYQVbKoowOXUajP0i4SvKastLzBJuZHhntN3B48?=
 =?us-ascii?Q?7fQLKPoSUiSi+BINLeIotLyYxebUZL17roPpaN2RSjpVCEBiOdiUgj9sfDf3?=
 =?us-ascii?Q?TuG7G0m/6JFMujtZBDGIiD3eHPiFlJ8hMYlXqRcvf7QlIbaLujucNVc3DdDT?=
 =?us-ascii?Q?9/Q9JnuvxvS1RUS1/Lp3bVS7Vhj9QcbacQnk2pinVYcBnu4Bl5cQxodX+GT9?=
 =?us-ascii?Q?CRF3K+vYOmOFEQMT4CnIY+MP0Fvlnm5j+WVfIwWHGzRVwhY4J+CZ3CV9NYy4?=
 =?us-ascii?Q?mZ20pfY3zRX4kZ+I3YzmwNbdmW/+qwbXUrgVzkX3fERDGiCTwIAtpPXD0vUB?=
 =?us-ascii?Q?NI18TZ5wWQ5J7SuwU0wv/PBeYJr/DqWxvyimHo5Ubbo/2kjurB4w5KewZ7d4?=
 =?us-ascii?Q?vFOnyiSFhIBdknwkcO2PsRIxjgvTX2qBuQoInEDcJDPdwMXlibqMzEPR8s+I?=
 =?us-ascii?Q?XXGZXABlsaPDSVy2h16DfZghWnaaBJZ8lSyy4tczENmxn0LcIdEs92MtCb+e?=
 =?us-ascii?Q?gvP5bCkR12kCgmOFzX2YiQs9LXEQy+JP84p/N6y8eqG4bxvQBLdRdOR2geY7?=
 =?us-ascii?Q?hZT4RxFeBj7lpkG0EOembcyos1aGQu6GUVCULNcTQG+hobPGZQnJd/dKIlqO?=
 =?us-ascii?Q?KqK+5Bvy1MC1CUN40n4+9sQ4yvzhwhbv6cGdW9Fd4YX+PZ3yTtwzl6WceK/U?=
 =?us-ascii?Q?mReyoMvsz5Aixomo9X+gmYdOYiMAs4tGZZ9HU7zGDjHFNyGzIM9jHOXu9FeF?=
 =?us-ascii?Q?dihDebcSPNySD1LaqOSUOcQY1x/QjB0kH/UkXxdqFP8YQWXakuZJPx4rC2kL?=
 =?us-ascii?Q?+DK9OgI2OJgYkV+KWvnn27wlDBWmdSIqvcveYwMY8XAgIP//I5JIyBGcki4u?=
 =?us-ascii?Q?ds+dpdKoG+VxmymAq32m0OpjrbNfWliZZyu5l0ph09k7vymK69OXor+W+S/i?=
 =?us-ascii?Q?3WbH4kFejhWZIYiJJjm+p8KAKE2b7UJPD8NFNcHbX62QhPifvtZ4HsnDF1KJ?=
 =?us-ascii?Q?AgwDgWSOP8E+OXssWAu4hA78A1ipeqxNnzYRCLu2K6K3rxNMLvXF/BqBhGCd?=
 =?us-ascii?Q?UsfyQJVDMRZiDeu9LcDIKw5CHeR2q+a1o7Rh49+Smbu6y4com0397SQV93PQ?=
 =?us-ascii?Q?uyrsYXZD88EW/eTr+Vo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:49:07.3610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79ebdc3-01c7-4ebe-4ae6-08de124bb386
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR19MB9001
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68fa4e7a cx=c_pps
 a=eNyQiorQ2xlxnIB2M60cKA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=QDk8zecZgZoI6ZYqeuUA:9
X-Proofpoint-ORIG-GUID: oYIvk90dxWsmCoOZkaAU0vQIJNrb4dZA
X-Proofpoint-GUID: oYIvk90dxWsmCoOZkaAU0vQIJNrb4dZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDE0NCBTYWx0ZWRfXymIc/LfUFUlF
 eRklbg8kag6DrhKJ5jCYGKZBUFCbEKxZEsjHQr0w5AueQnxCO6wbynYuUZjWxtHOgONU03m3hwM
 lJKmCmCBoYoSe0SoBvx0uZMmEYKjRkDD1RG4qhtS7ExI2C8E+KT25wAVKO8tw44N/weDAb5qlyb
 EH7755pvCMdbVY3EAr96yvax3+QFYXtCWwnYo0V3/6MYxw0LWhIK8C8ORnNxRvwW+w+OFC5AYNr
 otKiJiNQN3rguvkhO+8xy+aRxX8/uG0rVVKHPRX3/rVacEXwkE5tV7kakhPtP+xbHZ1ozYUIo9+
 SoXhmvis/oFY1lt7pjqi+gohhrV9YejFbNcL1ccbyLcBd4RZCRJFkFNDlkfoeXGmGbusOsmBzUY
 IrM+8y3JO7aQahImlcun3/ZXdBMnJA==
X-Proofpoint-Spam-Reason: safe

The locking was changed from a buslock to a plain lock, but the patch
description states there was no functional change. Assuming this was
accidental so reverting to using the buslock.

Fixes: 1b7444446724 ("genirq/manage: Rework __disable_irq_nosync()")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c94837382037e..7d68fb5dc2428 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -659,7 +659,7 @@ void __disable_irq(struct irq_desc *desc)
 
 static int __disable_irq_nosync(unsigned int irq)
 {
-	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
 		__disable_irq(scoped_irqdesc);
 		return 0;
 	}
-- 
2.47.3


