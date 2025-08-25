Return-Path: <linux-kernel+bounces-785018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D2B344CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3572189802B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26FD2FB988;
	Mon, 25 Aug 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HEgdlVMq"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9F2FDC5A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133871; cv=none; b=QnLf1/9zHfQZoxvtntV5XMi8jvs8U1zIzRbr1P2kdA9kErqix4ODUwjTs83i/kPyvgp03AqaQ1Ki1qvoQomeCJsFnlUN6ySo7IqJU7fmTWnKH0ghQjsvAmfcjiZGlwBhojL3zkWfY4k3CGxomn04Q/m3AcRgMQzm2wpv07bdNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133871; c=relaxed/simple;
	bh=xY16xtdVzGEfaeQq9IN656McbF+sKB7TIBPK2joy6Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVdnyD5hPtEltzR4Im1yFGI8b52i3UIvx1u5lvw47rsGILgfOT1iiCXrIs3RumOBJpO/9rS/n2oxLoTpDZbETs71lV8s8OyeTyLILHcvRi7tYM09u+SSEDQk5TwOhWiYPvFty08zowiH6bQTDnjlWPtLPsdH9NKa2EiYsQeeQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HEgdlVMq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso4966884b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133869; x=1756738669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4tDabwrjUnjyF2pNuKY+D/uJFltgF7p2tl2gzeMXdU=;
        b=HEgdlVMqfcNzg4t4NKdp0OlF4jZ1GAzoEPjWfmG9Rvf+D3pIqfViiHhdzsH1mtENtm
         h4u9U3wR8XAYu43ObhQXaKjSveEE33r0HnQarA37yWFBDiA825aQ6o1KXzKBoRIfGiKM
         U/VVO7LUzKfxjS1+XgQfvkHKMCgSA9qDT++ZsHB88UlgODcvmrPj29T491X8ZshTHOzC
         rRUq2c9BJmVvWjDB9EWZXTfCHz4T9bz1mVNxGYBD2H0rr3jUekKlIhcGc+7xf/hQYlcg
         3ZuRQNNm5sPgOcGsAAoMbhX7fcGPnrZXLWfNZ5n5mJcG2jFVGdETbh6fcTKsN50lRrFv
         g5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133869; x=1756738669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4tDabwrjUnjyF2pNuKY+D/uJFltgF7p2tl2gzeMXdU=;
        b=nbpIJdR1wckOaGIEa/7fHciUc+20x9ft31HruMd/47leMkQonEc/QUnEd2lxbM0Q03
         g0z5YAz5sOLP1m42ihkKJ8xOu/g19f4ei6FwiGofUrdvjIgqkY9QCVqWf6ote0wq0z1z
         bxJ+mHT58k5HgFtLOr835It52J39/TSYQa9gmi95iMRX4oSN8q7zdn1K1Y+fo3O+cKQJ
         gDd3M7Geb/kmWlJa2vbgY9jqpFtbVyTkaOZwffNJhkXFStPoastUNpCD/iuzT6IdwobU
         A+OyJ2mqwNvvKqAqYCCAtp3J6Uxhh6sboMG2n1unFS2g9qjaWradnAh0uqR04vRO6RFj
         sz9A==
X-Gm-Message-State: AOJu0YwqZEs7ljTDN431Em1xiysuNpQIubnDgLhHTdlepd2jNy8oZtBE
	lb5oCh0ToAOL90RgdIQa+78vY52DIOlFE7Bk462DWD73lQEi79Fvg4fs1NkkFN5Z6smq8+A/fK7
	2FysHQFo=
X-Gm-Gg: ASbGncv8U0227pkLZ6b2rNOOMgc0nZVWLRX4Lmc/odmvUvwnhd3qGeBSo85qHNdVkJY
	iHeja+X94hIcmo6fYw0kdoR7cgfq52xu5FaTnO1KMUHTd+tW4PZzeuET7dr891luzjzHsV/91PV
	oj0pcDKDxuUGaxUvYSwcI58bPyNGq5gdZJb1QPL4a/lBy3EDFjvwZ002lGFxqdPelaKLu52F1/H
	ttmCd6dAJXVrqeAc5Ppp/vh/AboMQMzn8tTzjIVshtYFpe2siPlF0ZntBl3cNeVa/bgpSgVktEi
	JB7KXMXGgcG9MJkY6idN8wVLKBfEB7osOBypHnmwn1uIJKC0ZLmgROlLejrt4JozrK4qwa+zaIf
	Ju+71wVk6uW+9313CLrh1SouMuswZ9CxxLKBPAmJt6ggf/rXlTf7nOKHudNhd
X-Google-Smtp-Source: AGHT+IFQ75GZYr3N6HMX7zPn0dw0ZuYOLQe7vaWeVSJK+4VjzmhYfxDpWVGeXxn9RSIeBs/bIzorqg==
X-Received: by 2002:a05:6a00:248f:b0:770:34f9:49d2 with SMTP id d2e1a72fcca58-77034f94ca1mr11670084b3a.1.1756133868947;
        Mon, 25 Aug 2025 07:57:48 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:48 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mshare: selftests: Add test case ioctl unmap
Date: Mon, 25 Aug 2025 22:57:08 +0800
Message-Id: <20250825145719.29455-6-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case aims to verify whether the process with guest mm will
segfault when VMA of host mm is unmaped via ioctl(MSHAREFS_UNMAP).

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 2347d30adfee..16d1f63c3ebe 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -85,4 +85,24 @@ TEST_F(basic, shared_mem)
 	ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
 }
 
+TEST_F_SIGNAL(basic, ioctl_unmap, SIGSEGV)
+{
+	char *addr;
+	int fd;
+
+	fd = open(self->filename, O_RDWR, 0600);
+	addr = mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	ASSERT_NE(addr, MAP_FAILED);
+	addr[0] = 'M';
+
+	/* munmap vma for host mm */
+	mshare_ioctl_munmap(fd, self->allocate_size);
+	/*
+	 * Will generate SIGSEGV signal as ioctl has already cleaned
+	 * shared page table
+	 */
+	addr[0] = 'D';
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


