Return-Path: <linux-kernel+bounces-837481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD8BAC67B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE14E3A12EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC862F60A1;
	Tue, 30 Sep 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihZ/ygVd"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB978220687
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226711; cv=none; b=Vy2L1siq640ljsejwM72ZqIiXLGzoEH84DPNKQMzouVErVQ3Ecl3DpT3L+QXD0WsD+bE/M6gA4J5GJFApJWbHmVIcf/U7U0J0vbdcS/mRxvdcyuH9Dve6lo6eUVL/9GqdtZ1e5cWTcOQV6gKX1BmamNGCJ1MXuTXGvDL2iIvlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226711; c=relaxed/simple;
	bh=X9juzzfORJjmVkVgJzjLoShWeYViK7aCq/qnOB2dWjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6qEEZcTU2xKPFDpOST77QxNmeDQcsrI1EWvjQgQvw1q2lLlJA7d9Nzj+QvlyLQb2tE/KkAnMqwCDcDwiA5NgRki7fflTl7lnWqCBXvInr2bMw+7AeGclml2mEoalhEll2AN4IHWJe0dQ8dlKYTd2zx2PoYkibqW1b4SOYKcSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihZ/ygVd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3c73fb4aso2156135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759226708; x=1759831508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoqmnjzpIbUw9OO6iTSJNLFiIVbBFRgd5p6mNVJqWNE=;
        b=ihZ/ygVdp8YuZD7ILB2uvEe1X7ZTFimxLrZximf2HL+O4V11FXw7LPENr1jcKdeVzJ
         kdY+++CK90tvoNHAmK/tkgCAsIlvYP+uiRcx+ET2bc7zWfPzphX70dxJS8/TRfXqCQnv
         qfZpu5n0ZkNBfGqUNT71ds45NiRmZm80YNO36qw1dxhaDYL03wjA3kOV5+3e/cPWc37v
         ai72UaO0k4G0lp5ObtvrXlJ0vVGwCS2/OQQF+LnrIYa+lOqg70mN+aywE7dHToTdsGOq
         t4a5dOn4kdn5AIEsAuOSNBHhl3O6lFjHMuRSFB6QXD15cBccDhEfXPoOiRRadgEUxEW+
         /Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226708; x=1759831508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoqmnjzpIbUw9OO6iTSJNLFiIVbBFRgd5p6mNVJqWNE=;
        b=sSjN7zZ5kEHOHH+kAeRNBYRC/Y5jUZt12jETVV04zgzUin8jjGQhJdbajlJQAUC7P+
         vQzlI5Oi9fQ8xUKWD4goI6mSL3gPCIHfACgxKKmndUawAl6nPKmlMMRNth4GxNyFfT/u
         H7fhdZKAzTMJ6wtWjoScoRD2eqRjYW5E+jBkMfR/FaGmE69qiFmIvjNI5Mif05nf3r7E
         gK7FwNYCT2FG3MtOehb6AtTVI7+GrlOCWM2jSA9Qw6gqsOOlK8K1zpN4Zo5+vYG6R5TE
         f3WxpX39DT6afdbBpwmPKMXHBjqnrF8zfV6BO1yHBQA7SspY4qS5Na/Ya7s28zHqHMAH
         I0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWpZKRSg/1Cy4CZPWJLu788y2bBJ8/CrpVrrAoVX1IewD52LLk/IEGLpk+ycRl93z9EXUmz6gCIk7ZyeMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTikNNT8MwDYrsnwIW3IqttCtF5h22Uxb6JD64czBe+YYi0gw1
	3/qJUL3ntlT4+VXeu5XcujlhrBigRr6cubNIeq/FyvCqd91cfFta8lPk
X-Gm-Gg: ASbGnct8UcgW/N0j1KcSlYia8nNlCiw4IhN9Ja93WLtWS34mboZAccOFZ97/xnLD3k2
	SAFluDL+lywDpmbbJnSEJTKMAMhx5VeeOFjqGZWj/GIbVFnTScRIvHkas9cZcRFpivmnxPAji1w
	9prqcN4Ui8FfvmDrG01oga8UkSf5r5+/6ieltylqFthaGXD8EC2I1ShCjhCqfYsLZkMXf1Yj23r
	wy+CyVFSp2o37V7O7mNUC5fwssSjAEQv4ibOE/kEa8GBhBBfGZfKyB1omUMzWIlsUrF79sUwhnM
	Op354G6Mhcg9bQWr87hWAJ3p4R1MBdqbrBVXHTQ7kWR8qA8c/5/U/F9/Fb1Sqc8V+73xbAb0QRR
	KY4pM8VZmABG3xreZWKrVWKQLH7Fr3fsN5g+cnAFGQMpH7o1MXJFaR86I82/vxaoA
X-Google-Smtp-Source: AGHT+IHR/hbTJBXGa5MRxuyi8MdBLzgo/Zj0q4wKBPTP845/xVxCCZl9+I5DcBEVzfMW11gF3Ur3Kg==
X-Received: by 2002:a05:600c:1f0e:b0:46e:5cb5:8ca2 with SMTP id 5b1f17b1804b1-46e5cb59fe3mr7885995e9.2.1759226707885;
        Tue, 30 Sep 2025 03:05:07 -0700 (PDT)
Received: from bhk.router ([102.171.36.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-410f2007372sm21238137f8f.16.2025.09.30.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:05:07 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v2] btrfs: Refactor allocation size calculation in kzalloc()
Date: Tue, 30 Sep 2025 11:03:44 +0100
Message-ID: <20250930100508.120194-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap allocation size calculation in struct_size() to 
avoid potential overflows.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes since v1:

-Use of struct_size() instead of size_add() and size_mul()
Link:https://lore.kernel.org/linux-btrfs/342929a3-ac5f-4953-a763-b81c60e66554@gmail.com/T/#mbe2932fec1a56e7db21bc8a3d1f1271a2c1422d7

 fs/btrfs/volumes.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6e3efd6f602..d349d0b180ac 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6076,12 +6076,7 @@ struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_io_context *bioc;
 
-	bioc = kzalloc(
-		 /* The size of btrfs_io_context */
-		sizeof(struct btrfs_io_context) +
-		/* Plus the variable array for the stripes */
-		sizeof(struct btrfs_io_stripe) * (total_stripes),
-		GFP_NOFS);
+	bioc = kzalloc(struct_size(bioc, stripes, total_stripes), GFP_NOFS);
 
 	if (!bioc)
 		return NULL;
-- 
2.51.0


