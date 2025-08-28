Return-Path: <linux-kernel+bounces-790685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68280B3ABBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3056F566C15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A22D060B;
	Thu, 28 Aug 2025 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="KiP5QtKz"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDE288CA3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413450; cv=none; b=VhBNY4oVSJuD0c5qsc9qYlLWka22XstedTUbGeGNBUNXNPkv+KIMImINQLsZzwSuAhFWT9YnVagES3/+jCaXCmSO2rG+eTx+t7xAldlGtYzzghXviTT1rljvTZQK7x5G9DNG/mcBrObIVt7qwjnuUF685J9+HOb2QSRDnXFLKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413450; c=relaxed/simple;
	bh=eKyn8NXO5NCJnrd2nhmwYnVO8Mdw8+5kx8vCPpQpD2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lleehNlWTCHEkJbGKagtQDsr3GgTd5CAwoNPdtd0iMywuFK2PzVUy+YdlEqly5XObUPf/F0Res0PyRHWnqqkSjZrT/GOCvNehOX8+Re0Zb17hHsM0dylDiwVQFH10FYLjoI7Z/VxePg0rped+Tqh9N3flRxA+ER7xwzjnRR3tNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=KiP5QtKz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7f77c66f13bso137803085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756413448; x=1757018248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mH1moQqYEsSGxE3+UVMXsVz3NSOmj4LqAu+NnOGgb0=;
        b=KiP5QtKzCWkDmk7dSjMCF/anWbUhHIjXx9ueuJNFrmy0kAa6T3iatRlpstFbJWvqCL
         FOdUvwh2my5kxFG1qxqDQdnt+pcwNPEkqlTX+HQUqjaPS4pA0eA5M7dOhC8LJRq0VUcH
         14aJ+kUfX2JQJlDAEmsTLwWiS6eezvnTC2jqqY867x+3rCXFkmbUaZ3g89wlKUYg6n7j
         yXylh0fK61erDuZQ/zCt52Gx49bQ2WA29MVSmkayyNfG/U15XfhoaxRGLt03XkLVx4rO
         O+RASLj5wmCNjwkAf4Q9u4XHMspIeFnFp3/25rgTaYBOSXafV07xv6ar0ER1Agti8hsf
         94yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413448; x=1757018248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mH1moQqYEsSGxE3+UVMXsVz3NSOmj4LqAu+NnOGgb0=;
        b=DS5I2WalroUZmsdRVMDxt/+lMSRirxxKStzlW5NerAWFFk6xh/Bcg3YGzQ3qKUlS+J
         YIs1fnz2Ocmq/wBjAWuFGkESCKEOtHfMl77xOhTB4D1MBgnDDrkNRbsYBEdaA/4nLOoR
         gBTeMEtkFqY1SLZl8Xhx9OQD3eWdvqo/+N18AEimYxFb4u+JPIMe3O9UwV7tGkRIMjcO
         OiB0JfibprEv+/IAeKQsDOtgVXm/3XV1ZMaJZjidyhR3C0xKlUcNyOvwzavaRWgysch1
         Pa0yv1tmKL5DGHdlgVxmZ9AtY3MqIQ6e7kGreAJj/38pALB1P83U7TjxSJAm/YIAzS1C
         Lzdg==
X-Forwarded-Encrypted: i=1; AJvYcCXK5NJFw8NAeYou5o0P7nD3K0njfiCGCjB2K5ESEg/9W0qH+QBsUOWfRKG0YN38g4XjzR9lS47kvFwhwkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1GU3aKVLEf6YQnTupqiEUXY+HFq2jgLqWPPUqh2HBpedjYH6
	+7/u5gd0AhvN2olmPLBkesbx2j32G7qDw9Zu8frTiMIu+5bXn0BRxDFIgk/zD1qScLQ=
X-Gm-Gg: ASbGncsZv0oNcehMuDjEaNVkGMPWF6/kL217JiZN33EoC1ixiaZB3UGkro3Mpph6b85
	UhCpibXbnzp1IUEUFZX6MmCeebbKKqZbZqZCg0rUwbqjB1yl68eIODLAhzHtYbwFcb9fvpGG7tx
	P5DZZruvaecowlAl3QMAgY96Wf8Er0D+iw1ZtS/EmNzrMxaTLC+RkaT9rkkaizWDjDwvcthEz3I
	eWQdixym0yXpj4A2GxRXKHggabZirtRHcErm7uMcIg7YnoJ8ZHU+x6cs3cppi8vA5bQxmOF1hDh
	th+cRDEq6qgW+xkGAZintaHHW/yYiri7uxchgkmlxr6pAllIzh1UoObdMWDOtT1S9jurxl8iom7
	2JdyfE7v1LVFVFdGsRvXbyjMox+MdFYia/rMAj0vxAD/Lku4T7R0vpats5xQ=
X-Google-Smtp-Source: AGHT+IERVxha56qApbTM7KtcTfottUjnLoIFBt+FYBzEzeioMpqY/O4nfcNXgi1nY45nfmgmpUTZIw==
X-Received: by 2002:a05:620a:40cc:b0:7fb:423d:57ad with SMTP id af79cd13be357-7fb425bde6cmr282181785a.47.1756413447643;
        Thu, 28 Aug 2025 13:37:27 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc153de18asm45879585a.54.2025.08.28.13.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:37:27 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 1/3] ntfs3: transition magic number to shared constant
Date: Thu, 28 Aug 2025 16:37:14 -0400
Message-Id: <20250828203716.468564-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828203716.468564-1-ethan.ferguson@zetier.com>
References: <20250828203716.468564-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common FSLABEL_MAX constant instead of a hardcoded magic
constant of 256.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>

---
 fs/ntfs3/ntfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 1296e6fcc779..630128716ea7 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -280,7 +280,7 @@ struct ntfs_sb_info {
 		__le16 flags; // Cached current VOLUME_INFO::flags, VOLUME_FLAG_DIRTY.
 		u8 major_ver;
 		u8 minor_ver;
-		char label[256];
+		char label[FSLABEL_MAX];
 		bool real_dirty; // Real fs state.
 	} volume;
 
-- 
2.34.1


