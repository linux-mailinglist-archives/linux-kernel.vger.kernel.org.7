Return-Path: <linux-kernel+bounces-891092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362AC41CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 264524E6054
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DF2313532;
	Fri,  7 Nov 2025 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+rIdeuB"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12331327C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554070; cv=none; b=VnNZT2AamfSiOsI8iD0fgAhnLe5iUZCxJrEUvJGTEK/icUgXMA8U4Z4IUge3V3ZPrz8CbzBX6J71VkXQCJh5lq42zfMZG6v+VNDYt/lrwu1HVCohsRI21GXn3740BYdygWU1WjO8hs9SUUL1UVPm7+qQ634l87d0MMYESl3PLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554070; c=relaxed/simple;
	bh=WUqWR70IoFJFm2xG+9BjmEYbjs7hMs0yO7Awp4mKSeg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I9kzVqtMg1uRX3AGOx7Grjo4q9hD88lpx3GHtmWdlungEfCzxM255CPpTSoxPUg7gWWTg9Z/gDXsV07ZKoE3uZX+jah+qowPHXnBmXPNM/69ii2/WgUg0lrA8qV8GUBXbAypiB778MBeQrVOQyvNEn6qOTgnc0VaVTeo1jr1Mwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+rIdeuB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33da21394adso1404390a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762554069; x=1763158869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zuSF9+hfy+NMVL8N7Q7F7ZTFz7YXKcb4ealISCMjhtI=;
        b=u+rIdeuBtiE1GdBQEaII0asi7wkzEvgpXOhJPC7TArJoKAMZILScEXmf7lVw4DrjSC
         YPnZMEWpS+hgxESq1x7GAt/N5w1jrWdrWmIG/rXo3QQ0wnhp+bJgb5z2SefY+/vmI2Zy
         cjcAGDZebWW0SQojJv1t1nF9914326J7ePcXU1h4eFJv02b47se4gOMz1PhWf1tZKKap
         +oMoP6P3kSwy2TAorg1wE1Axn9k42DMVsiSo5MrWniO1ZMHAbCFONMZDXg23djqhIAVf
         tc3eOGj+oTn8UK3FbjJSDI0eudLV7aC1YVo3oT91GrqDMDLm6XFH6ZrgUimIP9fvR+mH
         DvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762554069; x=1763158869;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuSF9+hfy+NMVL8N7Q7F7ZTFz7YXKcb4ealISCMjhtI=;
        b=RcvHmP5xTmm416Wud7YpEnwf7LBY6rMDX4AY51ubhI3kTqGbsvaEmEK7KqjEzeCXSg
         UzLbvYsQSGR/8CxqwweUIy51B3FOuVWgU7wADpDM1f7oh2x4KnOxUm/0amz1WHSITPY7
         M6qPhtLBP9ZfIlVHUMYOLyo3yUULFzrfQitIRjkMR9uuVAFNmjoWP3C152fS3A5aFLLQ
         L0dkf8x1tK51ICxpem8D9hFG2y9wdbZdvwm/z1DdM0AuhcMXvBH6kmVFJihzdfLfV4tq
         ac86xO6zKHvzAU3TgWU8O4qdvEmZNtHqMckaStOoXdYIRfPJRcV/Q/v0w5r7N/1OPT1H
         h1+A==
X-Forwarded-Encrypted: i=1; AJvYcCWteEJsizgug9GPdRHIJh4DNB/tbV4PtID3Qju3ImTXQsDBls7NpJx3qsUEx3hPkfURwpwD1FfqZ81SJ78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7ejeKwANYqH8VtSaDtL0oIgSA10xGyvCT9CdP1I3aXHSlcT/
	IU4ZzT3ReSVeHy4FEMYgJqrnlA8GNc5h3ciiW9oN6bwPkav+wtjM3U++5U2QpV2Sx9PVBukU+Pu
	JlmHlkhdZP8Q1/w==
X-Google-Smtp-Source: AGHT+IEXQvyuUBBRKN1QeiIACDjnMWHrD1uj7W5TBwePpvwHJac5Du36S2WgUjA6zrrdDIZtsxvqBPbemHNQqA==
X-Received: from pjbqj11.prod.google.com ([2002:a17:90b:28cb:b0:340:cddf:785a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a81:b0:341:c89:73d2 with SMTP id 98e67ed59e1d1-3436cced914mr670238a91.22.1762554068725;
 Fri, 07 Nov 2025 14:21:08 -0800 (PST)
Date: Fri,  7 Nov 2025 22:20:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107222058.2009244-1-dmatlack@google.com>
Subject: [PATCH] vfio: selftests: Skip vfio_dma_map_limit_test if mapping
 returns -EINVAL
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Skip vfio_dma_map_limit_test.{unmap_range,unmap_all} (instead of
failing) on systems that do not support mapping in the page-sized region
at the top of the u64 address space. Use -EINVAL as the signal for
detecting systems with this limitation, as that is what both VFIO Type1
and iommufd return.

A more robust solution that could be considered in the future would be
to explicitly check the range of supported IOVA regions and key off
that, instead of inferring from -EINVAL.

Fixes: de8d1f2fd5a5 ("vfio: selftests: add end of address space DMA map/unmap tests")
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../testing/selftests/vfio/vfio_dma_mapping_test.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 4f1ea79a200c..52b49cae58fe 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -249,7 +249,12 @@ TEST_F(vfio_dma_map_limit_test, unmap_range)
 	u64 unmapped;
 	int rc;
 
-	vfio_pci_dma_map(self->device, region);
+	rc = __vfio_pci_dma_map(self->device, region);
+	if (rc == -EINVAL)
+		SKIP(return, "Unable to map at iova 0x%lx\n", region->iova);
+	else
+		ASSERT_EQ(rc, 0);
+
 	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
 
 	rc = __vfio_pci_dma_unmap(self->device, region, &unmapped);
@@ -263,7 +268,12 @@ TEST_F(vfio_dma_map_limit_test, unmap_all)
 	u64 unmapped;
 	int rc;
 
-	vfio_pci_dma_map(self->device, region);
+	rc = __vfio_pci_dma_map(self->device, region);
+	if (rc == -EINVAL)
+		SKIP(return, "Unable to map at iova 0x%lx\n", region->iova);
+	else
+		ASSERT_EQ(rc, 0);
+
 	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
 
 	rc = __vfio_pci_dma_unmap_all(self->device, &unmapped);

base-commit: a1388fcb52fcad3e0b06e2cdd0ed757a82a5be30
-- 
2.51.2.1041.gc1ab5b90ca-goog


