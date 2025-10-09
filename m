Return-Path: <linux-kernel+bounces-846786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EBBC908A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E615E422097
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92C2E6CD5;
	Thu,  9 Oct 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxfF2qG5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BB2E267D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013044; cv=none; b=ii9PFO2YRylvp5vxe/Ctcdw62gTx9c8+U6jv22opnQLW+9o+I/ALtZ02YJNshykNO7BCjhfZ4FMVjK45/6uh/SuZqxngoxp1BvWa5DJm/4caSXS60nlFP9eNlE9VlmqKijS8xTk+jJPuxjYJn/WOKADol2ZWBBP4IcEP8fYMbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013044; c=relaxed/simple;
	bh=t9ylgHY+PljaKu8kJBcIBeNSsNWev04iThKtIuBpAP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rl82nhGU5isF18alE9n51oSP58VcBtOuRWjhsXJvaxsDQdSf3CEPDtDhD3FfLeHtjNLZLOIxk6M5F8BxfmiWZJ9II/UtYJ48WHXdb80b/YVqu/QCGmyoRs+4zJjyyMxwT4msqr2V3s5vbMrXp3tFF/3GWOvPFfaPg2eQoS//aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxfF2qG5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760013042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyzFZxJbO2L5avzgNukRA/OHc7c+vIBxWzW6CopjW/U=;
	b=LxfF2qG58XU55Lx3CEY7AxaDL+/Gqk6jF6+f9HpbJybSC/wpXzVsFi9DjE+0YJ/vkDtdxM
	fanpHD+NOb1yFZ4pan9X36uUgFGYUgIFDNTShbTZymotuRpHeyH11AyfVl62baprlLEDYI
	cNa9oYSx1afxHf16muKkaubwJCgQ5qw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-Ys3Hi_-hOVit_MVKA0Ie8g-1; Thu,
 09 Oct 2025 08:30:39 -0400
X-MC-Unique: Ys3Hi_-hOVit_MVKA0Ie8g-1
X-Mimecast-MFC-AGG-ID: Ys3Hi_-hOVit_MVKA0Ie8g_1760013038
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 027001800587;
	Thu,  9 Oct 2025 12:30:38 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9328180035E;
	Thu,  9 Oct 2025 12:30:34 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6/6] drm/panic: Fix 24bit pixel crossing page boundaries
Date: Thu,  9 Oct 2025 14:24:53 +0200
Message-ID: <20251009122955.562888-7-jfalempe@redhat.com>
In-Reply-To: <20251009122955.562888-1-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When using page list framebuffer, and using RGB888 format, some
pixels can cross the page boundaries, and this case was not handled,
leading to writing 1 or 2 bytes on the next virtual address.

Add a check and a specific function to handle this case.

Fixes: c9ff2808790f0 ("drm/panic: Add support to scanout buffer as array of pages")
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 46 +++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index bc5158683b2b..d4b6ea42db0f 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -174,6 +174,33 @@ static void drm_panic_write_pixel24(void *vaddr, unsigned int offset, u32 color)
 	*p = color & 0xff;
 }
 
+/*
+ * Special case if the pixel crosses page boundaries
+ */
+static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_page,
+					  unsigned int offset, u32 color)
+{
+	u8 *vaddr2;
+	u8 *p = vaddr + offset;
+
+	vaddr2 = kmap_local_page_try_from_panic(next_page);
+
+	*p++ = color & 0xff;
+	color >>= 8;
+
+	if (offset == PAGE_SIZE - 1)
+		p = vaddr2;
+
+	*p++ = color & 0xff;
+	color >>= 8;
+
+	if (offset == PAGE_SIZE - 2)
+		p = vaddr2;
+
+	*p = color & 0xff;
+	kunmap_local(vaddr2);
+}
+
 static void drm_panic_write_pixel32(void *vaddr, unsigned int offset, u32 color)
 {
 	u32 *p = vaddr + offset;
@@ -231,7 +258,14 @@ static void drm_panic_blit_page(struct page **pages, unsigned int dpitch,
 					page = new_page;
 					vaddr = kmap_local_page_try_from_panic(pages[page]);
 				}
-				if (vaddr)
+				if (!vaddr)
+					continue;
+
+				// Special case for 24bit, as a pixel might cross page boundaries
+				if (cpp == 3 && offset + 3 > PAGE_SIZE)
+					drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
+								      offset, fg32);
+				else
 					drm_panic_write_pixel(vaddr, offset, fg32, cpp);
 			}
 		}
@@ -321,7 +355,15 @@ static void drm_panic_fill_page(struct page **pages, unsigned int dpitch,
 				page = new_page;
 				vaddr = kmap_local_page_try_from_panic(pages[page]);
 			}
-			drm_panic_write_pixel(vaddr, offset, color, cpp);
+			if (!vaddr)
+				continue;
+
+			// Special case for 24bit, as a pixel might cross page boundaries
+			if (cpp == 3 && offset + 3 > PAGE_SIZE)
+				drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
+							      offset, color);
+			else
+				drm_panic_write_pixel(vaddr, offset, color, cpp);
 		}
 	}
 	if (vaddr)
-- 
2.51.0


