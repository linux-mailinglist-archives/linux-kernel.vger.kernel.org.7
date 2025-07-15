Return-Path: <linux-kernel+bounces-732625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB43B069B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C439B3A285E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EBF2D3A98;
	Tue, 15 Jul 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PY12zLz7"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7134A3C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620602; cv=none; b=ePgjOewttVLXSx0OEvA5rwqIy/SfCrAhy9rGlwr+raAWHJlIbR9XyCLaMJgfNXNXVCPpQnkeStdw37uXIk5R6SI06+qhhbMcAoxxBpPTjfHoMOe4DVTJAKC+rNG/XdX7v/HqTBc0WIJ4mcmD69hFJ3slkHrGL2cMOb5lQ15mrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620602; c=relaxed/simple;
	bh=ojsONraykAW73nHFhU3JR6gIK5F+2qzAE3NHVXM9K1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gg/cco9QsLiwGkaxS5KDshrbzVCgdOKJy3Kd4eVVCvqeVAUsFNV5Q/AQM/Wgq4NGgx8QKLOotauavLC5o/eC/ztvfEIVHKgV7H3TKLuakNzQjODPnjIYXTtkgnoJOQ80H5N3nCjRGHZesqRG932oLg1SdDQohu+OMKVQ4v4eG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PY12zLz7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-40b1f402deaso3214431b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620599; x=1753225399; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVPOIdRXltuwUh+ovIsPk+9c5IV4XN6F0lzLlze081U=;
        b=PY12zLz7XbgUIJ0jnzV4J+G4gATelRhx0W7ggppvUvzVRa88eAtija2wL2iDSfbdJF
         1o1YV+yJjeV0w5XBK0GX8cHLgkZoriJbzlguNAk4VoJWJNoKWkixN34UoP4oO+pO5ETn
         yB/lcEpOMwszSux5wXtPA4SqDwp84c4dGmYQ9QakeFu8m4xvkkxtmjQhSKvqJp1zb0x1
         VDA4EhQAaZULUVk6ixmiv/MBvlWo1eNCWHVjLPCiVRcobpGhE/1cU7RWpj6KsatsRTe8
         /O209DUhoxXARr7FS/HWif/XXIOqEobCTaDhpqHeOziX3iGHTBEZ1r5/tzdJxdwpnHsY
         4xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620599; x=1753225399;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVPOIdRXltuwUh+ovIsPk+9c5IV4XN6F0lzLlze081U=;
        b=ELVh9V1+D7tKPD0V01QtUvwXCkRONuMqVe0Z36pcogqXgAKqWOUd2h9Q1Y3+zALUcJ
         tvtpwAUnozhUzkenCMLwy1P8N2XOakB0/TXLV5zUYOGK8RrsVve3+aJ2KhMenPnyVI20
         F2SYA0l7HvbPWejwEOboXmB2rqRDYcAon8ISbHOsyzTQpULEQnXiwew+Cgung53QJnuo
         yx1zDUTy007RWPE0fCvJzaq7kKRvR8cePvrG4yuZpu3MjevInkGG1NTifIExjNTjCfkD
         b8v9rp+EzVE8XVSGNidGp6reFn8Kz9UZqkvoV3BFaGGiDaA7Mx8AXzu30q0W8u1UQwXo
         hfgA==
X-Forwarded-Encrypted: i=1; AJvYcCX4QxfRlcjNWyo3wX3dHg3JWysp6kkrk2LG8xKYz4DzGityoduoMXxRXoMMdG7CjM6rIjI8P/cVRacHRfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSgnK0M24XtXiZLOZIez5aB2avn2a32edB/XbnMXRM2jtcmq5V
	YNy+TCJotbbST0oDGzy99s9e/n5qNdyjVXAfDno0dJmowaEgsm+5qlrfJjzflXYCL/w=
X-Gm-Gg: ASbGncsZvvomQrNrE/9KOTMW12K1z2nXyaHB6M16FEN1l4TkYmvlsFGVANRNFCAeASz
	SnYGiOE9JK4ig3EPZpO9thn4/cOlcv4DqZ2QBYW/w6t+LV0PrCuR1cbc348R9UrCdWi8ju7BDDT
	h5kN02RRBr/9GXIdajmibADoS1dwPLjNKKiCnMposVDX4MB0RR6sXGAF+XReipYmUCwPxgv7NHu
	CMOfx85DWoJqxjEIkhPKEvIPwiqAf1BG6uhnJeaNRY1Gyz1E2uUxOjw1RR0NiGSNHHizjcJfqwt
	Ia+WfigMO0Jsx1AFs67WTSayCuH1M4nrMbSJ+GSVocAy/KyDttOGH54/5TLWhd2b7NTsySLf4wb
	7SEuaa+xj0Kh1TYsLHMIYRLfD2jeJ
X-Google-Smtp-Source: AGHT+IFURZ/gT+RRgf6lI5IpEJOCthv+wsSYmy36S+x0hFRqDxCmnWN11VfQnBagXrYe5WyxizT1LQ==
X-Received: by 2002:a05:6808:14c7:b0:3fe:af08:65b5 with SMTP id 5614622812f47-41cf0abe5admr693504b6e.37.1752620599527;
        Tue, 15 Jul 2025 16:03:19 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-613d9f14472sm1859238eaf.29.2025.07.15.16.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:03:18 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:03:17 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] fs: tighten a sanity check in file_attr_to_fileattr()
Message-ID: <baf7b808-bcf2-4ac1-9313-882c91cc87b2@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The fattr->fa_xflags is a u64 that comes from the user.  This is a sanity
check to ensure that the users are only setting allowed flags.  The
problem is that it doesn't check the upper 32 bits.  It doesn't really
affect anything but for more flexibility in the future, we want to enforce
users zero out those bits.

Fixes: be7efb2d20d6 ("fs: introduce file_getattr and file_setattr syscalls")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/file_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 17745c89e2be..12424d4945d0 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
 static int file_attr_to_fileattr(const struct file_attr *fattr,
 				 struct file_kattr *fa)
 {
-	__u32 mask = FS_XFLAGS_MASK;
+	__u64 mask = FS_XFLAGS_MASK;
 
 	if (fattr->fa_xflags & ~mask)
 		return -EINVAL;
-- 
2.47.2


