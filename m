Return-Path: <linux-kernel+bounces-874623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91CC16B79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 501564F6CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63573502B8;
	Tue, 28 Oct 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHPlwxNQ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC895350291
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681811; cv=none; b=NgthHZLOiL+dmafekaCsbFrz5feMu+WuexxXAxUWG8SY+gUWeRxIZkctBgGduhho0w8atYk2LaEGLG9ZHzwkGv2sK2SdrRS1FqoVIRQd5nPPcHaK6Ow+sCQU1RH0YGiYRY+APDY6hvT641ULpmmLP9gbKpWfkDklF6ISv45Zn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681811; c=relaxed/simple;
	bh=BDUaSKODNKtMq7VQYWR0GriGBCfWmxRXz2MCLuAhAaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orve4FJmenVf6d3Vdb1co1kohwwZPrlANGVKbYEy/qOa0co0NFf5ALOwAjjSqJ9ZW04Bis8bgdIWNgT1KkI2MnOgh4TmHzvYZqFSJFals/xp3HEZw+xgEqFsNsNuR8pDvOe7SCCz8ap+DJuKEdyuWmrOUw8Xvqw4FIEvuVQ3p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHPlwxNQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so8452461b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681809; x=1762286609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8joGPkRS7NaA/SU5NP/PHmANMNfQZvGYAt78YOV8B8=;
        b=aHPlwxNQRBRywNPUb4gTzblnuwUeVxq83P+4+yTW27ZPaoxLsWxWTk8Ti5VhBjpE/j
         nJLqo3Rom+yWhjwnzWnewcjoTP4EAQaA+mCfUSu8uF8uxo0eTeaoP5Iqz+PRlEyBVhT6
         qPXPUexdCuK3v/wiCO9nbPWTjAJVdE8rZVLCjZMGIG1BNcsy4pUaJzft+ZyAwuALpwaY
         hwJldOrAz6938WESY/TYTKyrzVeBjiq1gGneTcuXraOax9bCchmwTMOUnCtRiL7igInp
         z5sVHyCOGHeOjjYdM2fZA+MJP3TKV8XVmSVfU+CthlqYfeyxxGNkjwqGOkLbsimvVwxW
         i1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681809; x=1762286609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8joGPkRS7NaA/SU5NP/PHmANMNfQZvGYAt78YOV8B8=;
        b=SNNQoanU2OmFtMJEAxWCsIBK3ZQOFEPflhsRc/166tLw/iRUPHOdNmLpngXrBVeOEj
         da68bCvxCd1WxlVxQAOmXlBdjlm01LE2ItjpfOfcIQuLyXJiLgK0k9ftN7XTFZPOc7CW
         HDsPmDPECdbaBNBgWLoXu7Squqnc6a3IcMEUuB4psiqHex2k0vCwAQRXpYfu9pHWOEB4
         CrxAhYfaiGxvrsLN006bbqQ7qdtZTfvTD6r+3m+YYimsSTZKcM5CFVn5MuYxpjC/yzIo
         7t/V6/ZRMMqliAHvxVhFWx7C8qNWQBj60aa6HbgxXVCtx7u/VxROeldmOHsvJxr8E8DP
         mrng==
X-Forwarded-Encrypted: i=1; AJvYcCVJmb7hOd+CBz5jp0Fs7yCVfu+/lhSqrD4Y8WMEZ2fzofOwaRmuUa8STc8vhaVSAEWRek/ZFxuI2TwSecI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdhJouQZuCqWLfZELy0Vq/wHXUfrdjmMit1ijWo909T5qtuO+
	BZHeMp8X3irNYWZ+ntvBlu/gnwdm0poGoCE3QVNoYa4TMMmHYP+hFBwm
X-Gm-Gg: ASbGncskDL4kplAq+pSmYIuC21YnQar26+ufGQ7xOxkoAI1L4KlND75cr/8RGEPh89s
	g7DucDUGZVfUQpfNEap4xxQAmCBeg1WcZ4Iz7ciisusdDgMbMXVgbYq1sWhRz1EBBOgvWPZQOpw
	KRr3dAn+0wDS6ItsdrRkI2j71aqReLP3T/jgNQCQUcXRBksXjBdQ3ENH3J6Jj/D1Yy0q/E1kgLv
	p640gzFZKRsawBr+3PcKlE5pGPoDTMr4r0Swwmm0xWXiRO2GP7EM732FZ+BGNeI9+vw8DL3YyH0
	JpqKIt+XjmBQikzExu94UQMEJg0Itd6jq5COWC7aMQwW0Tqof60hOjRgjf/KFWBgPTv5dTnci7j
	ibRSKGDm6FmcQQYwHew3WIrPf2WJ9RF87BwjCP5azqy4b8AV8nJ9dbkmm7rS4ITVJNEKo5vbSXG
	yHwVVOPpKjwpV1LNIBRUDNtGexqczVzf7XQKc9bA==
X-Google-Smtp-Source: AGHT+IFax4JLp6peVjA4GRSNGg+x5gUWORdeMvPmm1KtEIj6rMAl9UjikOCZ4H3Vmq+EX50VwOXgvg==
X-Received: by 2002:a17:903:1c2:b0:294:def6:bc1e with SMTP id d9443c01a7336-294def6bd88mr4468365ad.15.1761681808551;
        Tue, 28 Oct 2025 13:03:28 -0700 (PDT)
Received: from brajesh.. ([2401:4900:78f2:772b:141e:4f0f:8f8f:6f84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4254asm128996765ad.82.2025.10.28.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 13:03:28 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: miklos@szeredi.hu,
	stefanha@redhat.com,
	vgoyal@redhat.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	virtio-fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Date: Wed, 29 Oct 2025 01:33:11 +0530
Message-ID: <20251028200311.40372-1-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation in virtio-fs to ensure the server follows the FUSE
protocol for response headers, addressing the existing TODO for
verifying protocol compliance.

Add checks for fuse_out_header to verify:
 - oh->unique matches req->in.h.unique
 - FUSE_INT_REQ_BIT is not set
 - error codes are valid
 - oh->len does not exceed the expected size

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6bc7c97b017d..52e8338bf436 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 {
 	struct fuse_args *args;
 	struct fuse_args_pages *ap;
-	unsigned int len, i, thislen;
+	struct fuse_out_header *oh;
+	unsigned int len, i, thislen, expected_len = 0;
 	struct folio *folio;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
+	oh = &req->out.h;
+
+	if (oh->unique == 0)
+		pr_warn_once("notify through fuse-virtio-fs not supported");
+
+	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
+		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
+				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
+
+	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
+
+	if (oh->error <= -ERESTARTSYS || oh->error > 0)
+		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
+				    oh->error);
+
 	args = req->args;
+
+	for (i = 0; i < args->out_numargs; i++)
+		expected_len += args->out_args[i].size;
+
+	if (oh->len > sizeof(*oh) + expected_len)
+		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
+			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
+
 	copy_args_from_argbuf(args, req);
 
 	if (args->out_pages && args->page_zeroing) {
-- 
2.43.0


