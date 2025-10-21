Return-Path: <linux-kernel+bounces-863013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC5BF6C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C03518838DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0B62E7BDF;
	Tue, 21 Oct 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="UY7WshFA"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248121494A8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053507; cv=none; b=e7y6nZvRgA0G3co4lg2VmKlKGm0ocMlTXvn8AXz2PH92SMiTDILnqyhRZiwpkJGThFd2yCvNLFpnSEzf6VPXPjqVPnH05ltbmRz2zwdOKnskyd6crckSy7bC4GeNZjH/eKVakdGuXcfP0R+IyhIA3JJYIT4iEKXMSky7wtOzvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053507; c=relaxed/simple;
	bh=n/akWYqLyInsYbbAw/veuE1ju4LFRwd3CBjP5nFQYMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XyvOj00mDBJqFtxgcektYcU0UcxIXeCRY7EowZgruDTQh+7lefLG6vHCG419CI6FKeYPrG/r9gabj0pN4FMovzYnzT/0TPMsaHRsv28x5ZUx5CtyoKUKlzF4/SAUmmQf7NZeNjmRGqaVCR5Bm+8V3Sxg+MZ2XyCvgcr0W4ATefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=UY7WshFA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso5673714a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761053500; x=1761658300; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bt+pEsVY8J/vv1ad/8DdKROF3Cs8nMg8bGxq+S7Ymgg=;
        b=UY7WshFAdKJlVDHOprXcicwHn7GI0ZEfwxV7vaNHzcTJxBLt3ww/bKDKDt5/BmMDQW
         Ao+wy9EBTi8Zhl86IqPbnvJqpPScOwhnNcgnccPD9PD4TXL4zZL4X3dotk0gyPOOd7Qa
         5bPVpTDv9ufjJKNNF1xueZxrMmHahQIdJlG0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053500; x=1761658300;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bt+pEsVY8J/vv1ad/8DdKROF3Cs8nMg8bGxq+S7Ymgg=;
        b=Sd1Vdse5/OzaTd+4D0MJT4Z+5fIf5sNMct98J0KXZ4fnxH6Xr4VXkgLZPBRQ7jc6K1
         Zcn/teSyGSk5WYK2n3Abs7xhRYmXludYvfZGJsV1sEyTYwPPmuxcBEFEOGjvnAuY+sHs
         NPh8AD2FwdsxzunAPTDYiWqF4EdOMC5kDBtvwWcmxR3wPZI+r/XKgHQVSfUDbJp1I01A
         iIZCX9KcwhqKU+QZOWRA6mTAeVbo8AVzHEUMFD1yf0hzcQ3c9NMCuaCBDxTFL3zie2A6
         C8PkYorOcnK9UL9jHAsZDAXEdDC03+d1OJQKSzkvRJWYOT5MdxbEmt+quXZpEcv+GXNG
         Q1lg==
X-Gm-Message-State: AOJu0Yw1z/ivpcCYly8xlCfnZmGMtLJ5DB3f7T6AIFGor0Kn/DUFkxv8
	BwP4yKIiV1J5cyvOBVTXO0kL74jqAUIQx9u6bMeoe2qhgo/6ucQJ0Avmw3UzqbMihyoDRYGtbfG
	MrP6dF34j6XZZB/J97LKJAYEs771aBBOcLMNxQMzNihENd1CgbaZoWcx0wx+PonOSDkDze0vtJr
	I=
X-Gm-Gg: ASbGncsSca05kbEWgIxtBCSezklkwLuBL4YthOO4SjsoLZc9khZAJH3n+toDxBFGwfE
	ma1tgZ3fv/EsJgj+K0uiOIBzH99Up4kpHThPzwUDC6apyQWB9VejlQvCYURHWAH+GVaecTpavDI
	kOmuU+t0F+EroKuHja7LqtGuuiD87t4fwX0c2NRYyGDy2JJphb5K0GiVfANy90dUGusU0XHOf9k
	N8pv1Kn/NAtL/2j4gz0GrQYXXb6BuFHyq+M04qPmKR6WMI/seUaDqc55uzsr5mtxN576TGxl51I
	ISyUYWwH3Gsy/zl4VjR3iIUf4At+oxh/xyQtKPuu+Uap9V4abtSKsFp3dullQCoHtNK1Iuh3lTA
	Lh+Gt/jjOXTJ5xWWlgFpKzrlstKmDXf/S9eRa0eY3gJimRCZGQYTNEiXntifR4RLQHAGZzFDtO9
	ntiuIhc+9QeFpxlHrWq3N/uuqbujGkrEwM4ucD3QvQ7BN9kPgQbTO62oSCmKcXIOAUzqxFX/7cm
	2FO
X-Google-Smtp-Source: AGHT+IG8HUHcS3y9/xdwgGSXLoI6vpeh+wSGM57XgBBR3qHHb97UMtZLctq6SPWp+bfYHygZhX1fEA==
X-Received: by 2002:a17:90b:4f86:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-33bcf91484bmr21064976a91.27.1761053499742;
        Tue, 21 Oct 2025 06:31:39 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de0b42asm11191472a91.9.2025.10.21.06.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:31:39 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] dma-buf: improve dma_buf_show_fdinfo output
Date: Tue, 21 Oct 2025 19:01:32 +0530
Message-ID: <20251021133132.29751-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

dma_buf_show_fdinfo functions into a single function
that prints size, count, flags, attachments, mappings, exp_name, and
name safely with proper spinlock protection for name access.

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/dma-buf/dma-buf.c | 49 ++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..1c0035601c4f 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -394,17 +394,21 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
  */
 static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
 {
-	char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
+    char *name;
 
-	if (IS_ERR(name))
-		return PTR_ERR(name);
+    if (!buf)
+        return -EINVAL;
 
-	spin_lock(&dmabuf->name_lock);
-	kfree(dmabuf->name);
-	dmabuf->name = name;
-	spin_unlock(&dmabuf->name_lock);
+    name = strndup_user(buf, DMA_BUF_NAME_LEN);
+    if (IS_ERR(name))
+        return PTR_ERR(name);
 
-	return 0;
+    spin_lock(&dmabuf->name_lock);
+    kfree(dmabuf->name);
+    dmabuf->name = name;
+    spin_unlock(&dmabuf->name_lock);
+
+    return 0;
 }
 
 #if IS_ENABLED(CONFIG_SYNC_FILE)
@@ -567,20 +571,27 @@ static long dma_buf_ioctl(struct file *file,
 	}
 }
 
-static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
+static void dma_buf_show_fdinfo(struct seq_file *s, struct file *f)
 {
-	struct dma_buf *dmabuf = file->private_data;
-
-	seq_printf(m, "size:\t%zu\n", dmabuf->size);
-	/* Don't count the temporary reference taken inside procfs seq_show */
-	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
-	seq_printf(m, "exp_name:\t%s\n", dmabuf->exp_name);
-	spin_lock(&dmabuf->name_lock);
-	if (dmabuf->name)
-		seq_printf(m, "name:\t%s\n", dmabuf->name);
-	spin_unlock(&dmabuf->name_lock);
+    struct dma_buf *dmabuf = f->private_data;
+
+    if (!dmabuf)
+        return;
+
+    seq_printf(s, "flags:\t%lu\n", f->f_flags);
+    seq_printf(s, "size:\t%llu\n", dmabuf->size);
+    seq_printf(s, "count:\t%ld\n", file_count(dmabuf->file) - 1);
+    seq_printf(s, "attachments:\t%d\n", atomic_read(&dmabuf->num_attachments));
+    seq_printf(s, "mappings:\t%d\n", atomic_read(&dmabuf->num_mappings));
+    seq_printf(s, "exp_name:\t%s\n", dmabuf->exp_name ? dmabuf->exp_name : "N/A");
+
+    spin_lock(&dmabuf->name_lock);
+    if (dmabuf->name)
+        seq_printf(s, "name:\t%s\n", dmabuf->name);
+    spin_unlock(&dmabuf->name_lock);
 }
 
+
 static const struct file_operations dma_buf_fops = {
 	.release	= dma_buf_file_release,
 	.mmap		= dma_buf_mmap_internal,
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

