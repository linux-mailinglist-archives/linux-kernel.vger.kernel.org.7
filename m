Return-Path: <linux-kernel+bounces-892470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAAAC4528C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 804254E87FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B02E9EC7;
	Mon, 10 Nov 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiWk9vHN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAD22256B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758071; cv=none; b=Bv7+B6jzK19czXXHFXkt8GWra54cP+ZM6Ej/FxqiFWCPayomwDaNRt67YZqyGBZMyR7cxFyJLWiq1uDR63gNv5oCNfqQgMre6C70aPDyVYWRhnayee61ZI6Y9ERV2qagqLD+uCz9HvcANWG2qgvKJWEpfbmy1YvXgO6mravIhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758071; c=relaxed/simple;
	bh=I7oLFfHr3W/juqS+e9nd/H5d38cdKmwLQvTZUMrhpg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WL8/dq7ZGe3kZ4W3azJ3JdPojJDODACtSRKQGpQuUgs0q7sJqRrd/DIYw7rrLozcYCQsbTgDXGPMQ+NPYfYie0vthMS/hwHWzT/MSIucqZKR+gQR4Oe2xsRkuKDcUFpKcRYR3ntm9Eih/BAZtb+UMBvvthyRvPACeX9A+1UNWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiWk9vHN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762758068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t1lPCSB8D9sxSG1VrcsMcz7l5zR/N/8q2hHJ32M5StE=;
	b=FiWk9vHNPv5XAa/BUTiFKpHdvyGMbL6vWa3m6S+Od7p6q2+xdE7MNYbFQTdb/w47Lx5p3y
	TE4bggW/XNaaU3D36ibJusP/ei3Zs6aK8N2oc1HPCNII5TsF6GVywoH8iIQ94y6SdGLwT6
	yVIX4GkdDotVThUoCWs6ynN93v7eDhk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-lq2V7W2aMQ65dGxIgvtDeA-1; Mon,
 10 Nov 2025 02:01:03 -0500
X-MC-Unique: lq2V7W2aMQ65dGxIgvtDeA-1
X-Mimecast-MFC-AGG-ID: lq2V7W2aMQ65dGxIgvtDeA_1762758062
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B505518011EF;
	Mon, 10 Nov 2025 07:01:02 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.65.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1758E30001B9;
	Mon, 10 Nov 2025 07:00:58 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mrout@redhat.com,
	lyude@redhat.com,
	malayarout91@gmail.com,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] timekeeping: Fix resource leak in tk_aux_sysfs_init() error paths
Date: Mon, 10 Nov 2025 12:30:54 +0530
Message-ID: <20251110070054.9090-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The tk_aux_sysfs_init() function returns immediately on error during
the auxiliary clock initialization loop without cleaning up previously
allocated kobjects and sysfs groups.

If kobject_create_and_add() or sysfs_create_group() fails during loop
iteration, the parent kobjects (tko and auxo) and any previously created
child kobjects are leaked.

Fix this by adding proper error handling with goto labels to ensure all
allocated resources are cleaned up on failure. kobject_put() on the
parent kobjects will handle cleanup of their children.

Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
---
 kernel/time/timekeeping.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3a4d3b2e3f74..79019b25f188 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3060,29 +3060,37 @@ static const struct attribute_group aux_clock_enable_attr_group = {
 static int __init tk_aux_sysfs_init(void)
 {
 	struct kobject *auxo, *tko = kobject_create_and_add("time", kernel_kobj);
+	int ret;
 
 	if (!tko)
 		return -ENOMEM;
 
 	auxo = kobject_create_and_add("aux_clocks", tko);
 	if (!auxo) {
-		kobject_put(tko);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_put_tko;
 	}
 
 	for (int i = 0; i < MAX_AUX_CLOCKS; i++) {
 		char id[2] = { [0] = '0' + i, };
 		struct kobject *clk = kobject_create_and_add(id, auxo);
 
-		if (!clk)
-			return -ENOMEM;
-
-		int ret = sysfs_create_group(clk, &aux_clock_enable_attr_group);
+		if (!clk) {
+			ret = -ENOMEM;
+			goto err_put_auxo;
+		}
 
+		ret = sysfs_create_group(clk, &aux_clock_enable_attr_group);
 		if (ret)
-			return ret;
+			goto err_put_auxo;
 	}
 	return 0;
+
+err_put_auxo:
+	kobject_put(auxo);
+err_put_tko:
+	kobject_put(tko);
+	return ret;
 }
 late_initcall(tk_aux_sysfs_init);
 
-- 
2.51.0


