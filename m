Return-Path: <linux-kernel+bounces-785336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9283B34941
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04F317A627
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8987308F33;
	Mon, 25 Aug 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZW0FecF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368411DF73A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144001; cv=none; b=YZvejS7mdJ3K2KEURD5BI+bK1mQzwvDGME8rff+je3MzzSSGJs7IgvbvxvIYni8UOXxc+ylIZObv+r5Bwv2zQPlP0JP26CFbQNCdy1fnrsM3qUZOAmgX7Rz1oOaDzx9i/JLMNzOr7lu9sAWKgOkOrBQfWSFK2T4BNlXK7UxRUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144001; c=relaxed/simple;
	bh=JHRo3Ys0vYdPYFbQ1Ci/J0G93lq4r3wdSQYvMczWEfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oas/gOmQD6CJJCotWNgW6QHooOm1Y7Bwz4swIzkUlxohRiIHyYoKBugREPp/D9QJECARqlS4BxR2YLhxa20lXlIz9hULRXnMrVbgI/aNjm+02CujgGeI3RehFj/QNHi58dUbLBCCZtIZz6J0JU5RSYhL2m9soXEyC1hKdHd7k3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZW0FecF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756143993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MiixeCilftYmoIpV0gPAHyRcncTYmxBOtWSvOueS6pg=;
	b=RZW0FecFQGBiTHnFsNfSIRwYfj9SUnW7D7LE+HNbLvCgmyWf/XfSst/fMxgOg2VfATIlzI
	VIqVC25dLCtZv4sTmTGNHKaD6aCvy6/b6sHs+WinrJPjx872aYcj8/Q34afN+TgMiIc7wF
	Hy/Pc+cJMA30SfSvbg8mOHHkPH3BIeo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-rV5_G6HyO-WGO-rfOdzrbA-1; Mon,
 25 Aug 2025 13:46:31 -0400
X-MC-Unique: rV5_G6HyO-WGO-rfOdzrbA-1
X-Mimecast-MFC-AGG-ID: rV5_G6HyO-WGO-rfOdzrbA_1756143990
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28BB6180047F;
	Mon, 25 Aug 2025 17:46:30 +0000 (UTC)
Received: from darcari-thinkpadt14sgen1.bos.com (unknown [10.22.88.89])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CB4130001A2;
	Mon, 25 Aug 2025 17:46:28 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] intel_th: core: fix null pointer dereference in intel_th_irq
Date: Mon, 25 Aug 2025 13:45:54 -0400
Message-ID: <20250825174554.925679-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In certain cases intel_th_irq can reference a null entry in
the th->thdev array.  This results in the splat shown below.
The problem is that intel_th_output_enable() can modify the
thdev[] array at the same time intel_th_irq is referencing
the same array.  This can be fixed by disabling interrupts
during the call to intel_th_output_enable().

BUG: kernel NULL pointer dereference, address: 0000000000000304
Oops: Oops: 0000 [#1] SMP NOPTI
RIP: 0010:intel_th_irq+0x26/0x70 [intel_th]
Call Trace:
 <IRQ>
 ? show_trace_log_lvl+0x1b0/0x2f0
 ? show_trace_log_lvl+0x1b0/0x2f0
 ? __handle_irq_event_percpu+0x4a/0x180
 ? __die_body.cold+0x8/0x12
 ? page_fault_oops+0x148/0x160
 ? exc_page_fault+0x73/0x160
 ? asm_exc_page_fault+0x26/0x30
 ? intel_th_irq+0x26/0x70 [intel_th]
 __handle_irq_event_percpu+0x4a/0x180
 handle_irq_event+0x38/0x80
handle_fasteoi_irq+0x78/0x200
__common_interrupt+0x3e/0x90
common_interrupt+0x80/0xa0
</IRQ>

Fixes: a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: Jerry Hoemann <jerry.hoemann@hpe.com>
Signed-off-by: David Arcari <darcari@redhat.com>
---
 drivers/hwtracing/intel_th/core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 47d9e6c3bac0..c6f6153fcc88 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -715,7 +715,9 @@ intel_th_subdevice_alloc(struct intel_th *th,
 int intel_th_output_enable(struct intel_th *th, unsigned int otype)
 {
 	struct intel_th_device *thdev;
-	int src = 0, dst = 0;
+	int src = 0, dst = 0, ret = 0;
+
+	disable_irq(th->irq);
 
 	for (src = 0, dst = 0; dst <= th->num_thdevs; src++, dst++) {
 		for (; src < ARRAY_SIZE(intel_th_subdevices); src++) {
@@ -730,7 +732,7 @@ int intel_th_output_enable(struct intel_th *th, unsigned int otype)
 
 		/* no unallocated matching subdevices */
 		if (src == ARRAY_SIZE(intel_th_subdevices))
-			return -ENODEV;
+			goto nodev;
 
 		for (; dst < th->num_thdevs; dst++) {
 			if (th->thdev[dst]->type != INTEL_TH_OUTPUT)
@@ -750,16 +752,19 @@ int intel_th_output_enable(struct intel_th *th, unsigned int otype)
 			goto found;
 	}
 
+nodev:
+	enable_irq(th->irq);
 	return -ENODEV;
 
 found:
 	thdev = intel_th_subdevice_alloc(th, &intel_th_subdevices[src]);
 	if (IS_ERR(thdev))
-		return PTR_ERR(thdev);
-
-	th->thdev[th->num_thdevs++] = thdev;
+		ret = PTR_ERR(thdev);
+	else
+		th->thdev[th->num_thdevs++] = thdev;
 
-	return 0;
+	enable_irq(th->irq);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_th_output_enable);
 
-- 
2.50.1


