Return-Path: <linux-kernel+bounces-786591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B49B35ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4DA68350F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F393090E8;
	Tue, 26 Aug 2025 12:09:14 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF82D320B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210154; cv=none; b=YO10VR5nlWmEPu1O2ApbZbuapuZnxYhtbtCX27pHFJdB46U4m3h/gZAX4AIYywYXzmyNpl+1vlJlRrqppWJF/glALYbOUjw5tza2TcAV/So/mNUsWBJ9D3mINfx2amejcwon3t43Y+4uHMMYCWs8q2TpSH3ML31k9ywHdgdZd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210154; c=relaxed/simple;
	bh=4v6c1/SuN2XBwZ50PJG6PxSplQuP+IBULqjkSZZ05mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uXXf5kYJn9HMK1XGtzbOZMBKeK+ByhZ0fbkwkEal+hOmuX6ueK/iL9c8kF5DvHSv1HjdrffF0zUBHinjrTvL4zjM1k/Kuene651tSlNFY/FAX+MMb72xlQcfJBSxXrgOz6Mntc9RIG8w34flR2pHgvjM2hIS4Y7CyuagElWYUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a0550cso959014466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210151; x=1756814951;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnZPQ9i52dF3KFBSw6s2UAOkbaudTyEedBQwR5Zwpl8=;
        b=mnS99S/cQTM3+uwQvE6EX16FOu1eKQLSSTkaecQajhNE+SYwRn0lTNL7KySaPsJf7s
         LMus44as6B0AELYVUMbvCnz2GkdofDdhFKuqfJoOlFGuHS8WwfzKTWDNLBRVeKgwLz15
         yVT1Db3eKq8l4aqVjqnUH6icaLaYhS9JWm9KBbKzjMIqaS0Wpygw04t+mIFAriXS1Gmt
         8IT2SHeORQ51cKrzFJVAxkySYwCPmYu3cEeApng9k/I79V0W95HI+ivgb+z1PeYNYWxQ
         E6X4n3HsrKAYHmjeZs9+KKIKED5DHB26SNxfQiIyHhw/J6DJmbdH5dL1j7VGnrjFCaEq
         YH4A==
X-Forwarded-Encrypted: i=1; AJvYcCUCi0s4PLG798vGDLJ8iMl8vS34t73TSeQWQLKJ50h417rcuwNJrd0Y+VO7mqW6SPj+gxo/gPcGKRXBGAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDQUFPDj8R9bB2mY3Vm5UUtsYlNyQ/Wo8ss6zmfR5tSVS9Lr1
	5RBaAKGsb++/kDykv4A9PKBNWjplI+VejrfZ2qu+V8WAME7XORtDOn7l
X-Gm-Gg: ASbGncu2TY7OdxE0qs+zBCvcOkh6cqdJWKqDj82057O8fpOVQilyi5kNmEVPAhi9W90
	2RtByN7oDH+zaY0IF1B0Vnf/BLj56UQTAh478AjR9KwoLbsSps/ngj4JgOcVLt0E7JlybwuS/UP
	zGn6aYvv7abRC7tM8upaq4HweFgkvZBx6CjbzC1312GD47oKiaUIS69tKi6TSha/mtALcM1v+9Y
	x3xqfV7sm+c1Iuxhh+tgb5ggj8+9i6BWj8XzoaLjDbAP6Q7dLHhBEbadxZND49ULTKuY2ayuLsT
	wLf3n2KNYgEtkLFT86suM/H7fclQ/+RugmKIuvl3z7M1Ap55Wg+Vq4laogxbgKb143sFLG3NjYZ
	b1OEymrwTCpVA1hZHFaKFYlj+
X-Google-Smtp-Source: AGHT+IFXfwKdwQy9L/iDhxQV4Dtj+nleX6usHo1EXmx4Rg1qgQ+BIVTWUPx0QHTGWZ24uy02cSt7dg==
X-Received: by 2002:a17:906:7308:b0:ae6:c23f:3cf with SMTP id a640c23a62f3a-afe28fc55e7mr1412861966b.16.1756210150317;
        Tue, 26 Aug 2025 05:09:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48e853b3sm788943466b.12.2025.08.26.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:09:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 26 Aug 2025 05:08:51 -0700
Subject: [PATCH] arm64: kexec: Initialize kexec_buf struct in image_load()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
X-B4-Tracking: v=1; b=H4sIANKjrWgC/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjWwMDLTTcwuyNU1tEg0NU81TjS2TEtR0lFQKihKTcusABsTHVtbCwC
 VQhH7VgAAAA==
X-Change-ID: 20250826-akpm-18a57e3a39fd
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bhe@redhat.com, linux-arm-kernel@lists.infradead.org, oxu@redhat.com, 
 berrange@redhat.com, kernel-team@meta.com, 
 Andrew Morton <akpm@linux-foundation.org>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=leitao@debian.org;
 h=from:subject:message-id; bh=4v6c1/SuN2XBwZ50PJG6PxSplQuP+IBULqjkSZZ05mg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoraPkzCMlrgJoVHjTxY6CWYJ4qnKJpiFt+KrRe
 Cxb9YW04tmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaK2j5AAKCRA1o5Of/Hh3
 ba6SD/wOd+iTOQspDn1FBn49r47VwUIch7D1WIFJN9Kbms5RLwJOT9Dj2U+ASaiz5A9miWo5sl0
 m960HatusN+DH2CMfzLArTbTAJL56rWacWrmT46wROXC1JnlyyxJ4IJf3BpXPok5mCiSlS7pA7s
 NtnbjVI/Zi01sYoQvEMfKolgB3EJPCP+J1maGWpvzKJX8aM0DnNcwXnMZwYMKMQcv9cjnEHytdO
 bbifs3IznmEWtBsa5g8GpIdyBXN87X9BUfQXRET3eWo7iSUv2rwdnQTwkAKhD0e9mCJk3t5U9Sd
 pV/b/PeH6PVhtGR+TKg1188qa/l/Nj2ytRyj35Ruz1KiD47USfFBJZfmQf/3JPNYFveB0XWtiAo
 MCVki0oFa9cCLq5+wfX1i3PxZlt1lDsK0/6mgbHHbYV9HIqOrFlo0adex1fOI9zite9HWVS8Q2p
 sKhcAkzzoBH2EtcEwAYB5S+e8aCZHWdhM3O7tIOG15dZFEN7WZbvdIZXmpfKgzMQFsRPAYqE4go
 /+uZRLDVuJuYODHoiqG0u6WvPQZzNA7rMI1yY8JeJ8n3j6/Vx63Yey39t9W6t+/KV/Ybg7lrEgv
 Jrt++eUrd802b5ogkawLHDGVTrRUYZTpO+ZaQvChhq9EiYnJnegG2M+n43XgsI8gyyt7BRxpnok
 5w04Hln/DSpiuFw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The kexec_buf structure was previously declared without initialization
in image_load(). This led to a UBSAN warning when the structure was
expanded and uninitialized fields were accessed [1].

Zero-initializing kexec_buf at declaration ensures all fields are
cleanly set, preventing future instances of uninitialized memory being
used.

Andrew Morton suggested that this function is only called 3x a week[2],
thus, the memset() cost is inexpressive.

Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/kexec_image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 532d72ea42ee8..b70f4df15a1ae 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
 	struct arm64_image_header *h;
 	u64 flags, value;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
 	int ret;

---
base-commit: 7a77c6b5ce68a71b9102760a988a4564ff6d4106
change-id: 20250826-akpm-18a57e3a39fd

Best regards,
--  
Breno Leitao <leitao@debian.org>


