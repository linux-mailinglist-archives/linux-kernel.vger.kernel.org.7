Return-Path: <linux-kernel+bounces-855081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D4EBE02CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B608D355B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF53254B0;
	Wed, 15 Oct 2025 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="UM5C3ChP"
Received: from e3i86.smtp2go.com (e3i86.smtp2go.com [158.120.84.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3523254A9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552904; cv=none; b=BKi2c9EbS1azlyIGjM7UwAGSHh+4qNfthI9ZWOJk2PE8KF8qSXdRlOsmPrDr1ncIl9CxJ2Hfs/ixaPBVY8dwuIjZxH+SEy3R4drqT5+0nJhIgMoXmRR7eHDGvQstAoohUvvHuXX7T0CEorW3xOyhc6nkIjHxqDz+/CCFk6qzso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552904; c=relaxed/simple;
	bh=ffOfwsHr+yAGHRJuSai5LUwd6+m1hseyRwIcKaquC2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMWzU263+O3HtC+KvC+V/kbjjmHf6Cz9iFAwVfdGug2WLHO0xCvbisLMQgWNQT/+CStVaJZWucZtAmlzHqj8kvn30LWOyJaeGRr9yZh+fQQFJOd+8ogebzlcPkf4OC+ZrzA1v/SriIvspzypoeg0yCDgowsuwKpvRfZ0znALaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=UM5C3ChP; arc=none smtp.client-ip=158.120.84.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1760551992; h=from : subject :
 to : message-id : date;
 bh=anCQPHVE/XUDRso2Re9zB1kDzN+VIwg3s3BKvkkml14=;
 b=UM5C3ChPp+SWFm06mOj0nlrLw0MIuFWoql5JdUS4LroSwX/FGK23FyjNYkHTxNrFk04nx
 /ib0WzN1gfnqMLDz3Cg0KWadhA5V132cTBdO0zapsz2avDV2HTOjeGXNuL+6qzL4cw+w5wW
 B38a96sd71tv1oj1mqTF5808lE0JurlzbRZ76VO80Tas/Q3Tr1WWZ2wKQPrS5Rdq99feAkp
 6HfCeEoGN7/zxH1q4r/ZXoucVSDCXr9B8dZf1KeiajHQ6jdBvId5hZu/780I9WgXiokHFiL
 x46BtPWV2I1XnnZGYOefQim1TuTmf4k5fMZeWJtovvU9JtXJWo5VcElEBZQA==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1v95zl-4o5NDgrjPI1-gXZW;
	Wed, 15 Oct 2025 18:13:05 +0000
From: edip@medip.dev
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kuba@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>
Subject: [PATCH] platform/x86: hp-wmi: mark Victus 16-r0 and 16-s0 for victus_s fan and thermal profile support
Date: Wed, 15 Oct 2025 21:10:44 +0300
Message-ID: <20251015181042.23961-3-edip@medip.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sY5Hk5a1oa
X-smtpcorp-track: VPeCEv3IStAU.qAG_3ltyX70z.5k4jegF-qKv

From: Edip Hazuri <edip@medip.dev>

This patch adds Victus 16-r0 (8bbe) and Victus 16-s0(8bd4, 8bd5) laptop
DMI board name into existing list

Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8b3533d6ba0..a84343bf96b 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -92,9 +92,9 @@ static const char * const victus_thermal_profile_boards[] = {
 	"8A25"
 };
 
-/* DMI Board names of Victus 16-r1000 and Victus 16-s1000 laptops */
+/* DMI Board names of Victus 16-r and Victus 16-s laptops */
 static const char * const victus_s_thermal_profile_boards[] = {
-	"8C99", "8C9C"
+	"8BBE", "8BD4", "8BD5", "8C99", "8C9C"
 };
 
 enum hp_wmi_radio {
-- 
2.51.0


