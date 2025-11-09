Return-Path: <linux-kernel+bounces-891828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D42C439CB
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BD93A31FB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0CB2765C3;
	Sun,  9 Nov 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5xkoYjS"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A32727EE
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762672416; cv=none; b=qX3rSh9gU/Az+nmpCLf7C2+dp7j+AFy+e1firnhpIM0F4FCVqgbAz1b9H2B/MRbwCIiS0XuzLJQ2WFhryuHby1MORQtn4EGc+cCqnjCKp3ah2g4TQGaQnsq6xSdBUVC9+ka5x1sixtdLltfgGnAQGLdOB1vM5bBxfsFYzcTS7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762672416; c=relaxed/simple;
	bh=LLot6pt5Wmhq41aBfE52tj3sPEDXX9voBssCmvBVx9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qqs9bO/+l5NDeM238Au3U+V/K5lrOXxGulU6/JmVOuMGHuy8T+6jXsXeN4ZBHV6lR5jGVxpzlIK7i0X4k9b+EzbPU6ZPVkPrZ5F5Yp47ACYD1ynPZvgzxCH1AM6jg45kPOoT/c4hjmOO8f0Rm6CM5b06vzUkulC5w+o7vWZjSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5xkoYjS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29806bd4776so720765ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 23:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762672414; x=1763277214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPG8lSWe7kDm/83Spm0cQcQQxsDcUC8RpeocgKFENBk=;
        b=Z5xkoYjSD+Ze1GN4qAl5Gs+G30tudyjvYDYMPm2lm/y5pNxplk7TaGsygdAo3TOHN/
         59tXNpWj4/xneVZVAuqJMmo1nnfUECF8NTylVud+pnR6EDEivLdLCWEmDTbzwtAjYoij
         WlRdKEbFJbGTux8xo6rncvazTk5UjUMhmm9DZZEhIXzbUYlFhNatO+qBMF2xaIDWrlZW
         wI10QlBb0etvswJKZi3tdGbUVsaE2BmKV5xlYh7//j2WFqvRXO7pc7AWyrrrZ8tbDJKX
         KPNigsMls+AMBMcq2/rLCBhXZcaHksPO2Yfb1YhIOb9JJg7zqHDcfZyW2Y/zTlwingFX
         gxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762672414; x=1763277214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPG8lSWe7kDm/83Spm0cQcQQxsDcUC8RpeocgKFENBk=;
        b=M/AG2NdtoRMsL4dUI3X5M56JVmP0y4W8kkBnHZiq71f+wye4fykn4vXhCpk4zmIgmA
         d8Q8+THMbdBPINQuJMyAWQyuXt3MlQt4hQmbD3WYUhsvYI5xkzLqd1R3vUrd6cC0m0yU
         C9m77rWZVPFlhWcTVl0A27QDfT6GxRCR24P6x1E0WywCUSSUKPgo+haITQ73zTwRk+tj
         N5xjrJcC+x1kF3uG1yCV4E9PzWkLi84PMEDHcrzSAjHdE8uB3e4sARoJTbq2YhQ7B2hx
         vpLwdSq0SPjlte3f2BEu1/6okaPQopIbtMWOvAN/zjC5jDXpuloKPnf2D1IoaK1EW1rW
         tA4w==
X-Forwarded-Encrypted: i=1; AJvYcCWQIN8FF/DQ5ijlIBbyeRJLbxNtA+sySMkFkEQgzd3s5Y9ZwtbVMYhDJZGX9rNyU1ma+5ZBDbGC3ZuNF7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbnw530/F5KMZZ5V4ftuM5Nq8nVksdCYt44NG11RFCNZnwDNEl
	rxYENjD8HtNBXOGykyzRYTLAqG3l/JDjzovdWIZK5jtAuaWm/c7Yq102
X-Gm-Gg: ASbGncvVw6awc0ZnoWAaeGIt86dQsFWOszgXmnIK7ZDns7LF/I6PJD1KeR2bW6I3zdq
	aS8546tvWqft5Kze8vLuTaNoBVKz+L+DZaTcnlVmFI+MkZNsOjt5Z1OMlr2kRgxncrpW1EZwkS3
	t6670Bk/ZFkzCxfEx5Pi/ELOV4epfwa94XtVgan2Lwg3vmwdupnDxP29FnGPX58uhiCHRNAeuB3
	bnf9pBaiDBci1PRfCDAZPjzcTj9h4wAD9/R4UA9ntoxV8AE16LoMRV8tfEkr5+F0sfnOnxn5Cjk
	kPD4JSfDt0vG0hxMBk/MjuDvI+jO5HBE0vjLd2/GUjscpvmkeMWJslAuLcwwK6DDZyGstMtvVQ7
	+iZYY0bBV3/8Y2d7pAFq2E6wv0BSTpW+l7+EwSOjZ6En6441oZmYKkos8o4wI66w6eDDjCtk5A6
	SizycTwEHosJIQ+Duaxw==
X-Google-Smtp-Source: AGHT+IET48aBLYXM2WgE4SXNwbfQ/VOKYL8lV7aiQ7bsg3ae4MfMOpcU4i8Zgn+mDIASK1OnC4wB8Q==
X-Received: by 2002:a17:902:f551:b0:297:d4c5:4c1a with SMTP id d9443c01a7336-297e56d6f99mr32754695ad.7.1762672414507;
        Sat, 08 Nov 2025 23:13:34 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm57287495ad.88.2025.11.08.23.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 23:13:34 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: jesperjuhl76@gmail.com,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH 2/2] samples: vfs: avoid libc AT_RENAME_* redefinitions
Date: Sun,  9 Nov 2025 16:13:04 +0900
Message-ID: <20251109071304.2415982-3-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109071304.2415982-1-nogunix@gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
 <20251109071304.2415982-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 samples/vfs/test-statx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..eabea80e9db8 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -20,6 +20,15 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/stat.h>
+#ifdef AT_RENAME_NOREPLACE
+#undef AT_RENAME_NOREPLACE
+#endif
+#ifdef AT_RENAME_EXCHANGE
+#undef AT_RENAME_EXCHANGE
+#endif
+#ifdef AT_RENAME_WHITEOUT
+#undef AT_RENAME_WHITEOUT
+#endif
 #include <linux/fcntl.h>
 #define statx foo
 #define statx_timestamp foo_timestamp
-- 
2.51.1


