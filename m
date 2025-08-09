Return-Path: <linux-kernel+bounces-761015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED1B1F305
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B8A175C89
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87529225A32;
	Sat,  9 Aug 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="ZrO0BGTM"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8481F8725
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726429; cv=none; b=h59h9EfMR3v1vmtDLrCRx2WlTyZ+2wa75VSsNICSxLzh7rPHg9A1YutRlTAJ5CJ1MrmP9+vZSJkYH1vzfe4hysPBZeUflEEaRZMakasmvDHWdHg+EVmQPtJNAbbcUSacdQ6RZb2LnMo689hPVQf2Tgo3F4h11gjs39RO0S8rqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726429; c=relaxed/simple;
	bh=zisvSLce1+aXq35EDvfK2Fr8uFmjstmeaklYSS/7hDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f/Y/b6S67tt/gV2LY3o8FDvhwEb+XtvWryjUqEd2CQFd+J+n4GlvvODAGDkkPannY5kUrBaX5S546iNML0LQmYtWuA/JKtno0uIJLXLoP5+kBMXjiLl9Ny6BXN3Wez1nVI9OlXQBUjwJr/JDJs9sh/G4HBlyj2RtWuvBG0jUado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=ZrO0BGTM; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 7D17D104CBB5
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 13:30:18 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 7D17D104CBB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754726418; bh=zisvSLce1+aXq35EDvfK2Fr8uFmjstmeaklYSS/7hDw=;
	h=Date:From:To:Cc:Subject:From;
	b=ZrO0BGTMl4F1Qy/Pq0xjwIaCEW6Guu3oqd8gyl96uLkGcOyg+Xk5P2jEI3P4PmTWa
	 8fS1xT93Pt6HlnaPBgEgHNHej7qTy5H8+4PmG5AnvbighmHPtaydAbQbGCSiyIrsOM
	 2lTztwO/YGwZfKvzkkpqS1hb9R3V1rp0MXerpusc=
Received: (qmail 21441 invoked by uid 510); 9 Aug 2025 13:30:18 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 0.653874 secs; 09 Aug 2025 13:30:18 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 9 Aug 2025 13:30:17 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 25615360083;
	Sat,  9 Aug 2025 13:30:17 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id E483C1E8138A;
	Sat,  9 Aug 2025 13:30:16 +0530 (IST)
Date: Sat, 9 Aug 2025 13:30:11 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: lyude@redhat.com, dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	bskeggs@redhat.com, kherbst@redhat.com
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] drm: nouveau: fifo: ga100: fix null pointer dereferences
Message-ID: <aJcACwrvcjCq78eH@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix potential NULL pointer dereference in ga100_fifo_nonstall_allow()
and ga100_fifo_nonstall_block() when nvkm_runl_get() returns NULL.
Fix CVE-476 as reported by coverity tool (CID: 1660771)

Fixes: 55e1a5996085 ("drm/nouveau/fifo/ga100-: add per-runlist nonstall intr handling")
Addresses-Coverity-ID: 1660771
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
index e74493a4569e..a441fb602f28 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
@@ -520,7 +520,9 @@ ga100_fifo_nonstall_block(struct nvkm_event *event, int type, int index)
 	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
 	struct nvkm_runl *runl = nvkm_runl_get(fifo, index, 0);
 
-	nvkm_inth_block(&runl->nonstall.inth);
+	WARN_ON(!runl);
+	if (runl)
+		nvkm_inth_block(&runl->nonstall.inth);
 }
 
 static void
@@ -529,7 +531,9 @@ ga100_fifo_nonstall_allow(struct nvkm_event *event, int type, int index)
 	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
 	struct nvkm_runl *runl = nvkm_runl_get(fifo, index, 0);
 
-	nvkm_inth_allow(&runl->nonstall.inth);
+	WARN_ON(!runl);
+	if (runl)
+		nvkm_inth_allow(&runl->nonstall.inth);
 }
 
 const struct nvkm_event_func
-- 
2.34.1


