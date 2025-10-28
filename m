Return-Path: <linux-kernel+bounces-874310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19DC16063
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8351AA5410
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88CE346E61;
	Tue, 28 Oct 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxtoXs2t"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F1346E59
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670632; cv=none; b=VPpyXmyYyAM470rxxF3v3eiW3p/yw0zbpw6wAzQgpLinWIbmeQEwOb+uLrNMxzmoNeUeff5sYF8bLAeiQe6ic3VcUrVeHEV6etudzD/aG1Pn5xlrlZqn56B75ctP5QzESCIYVH/rv9/yjD0noG6kBaLFOsW4zi5YRngNNQR343I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670632; c=relaxed/simple;
	bh=VWbzR5JJcNh9vxeY+++ECnRky78xd0PGd5/1QQmh4bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOIsb/8oygvrH++2oegX2QWEHcxV3MAhrVe94SpNx2rp0zHFtSp0oIPEzohJKCOOFZeH0g4juUON7xnarF0lBFQtm4tXfJIgERS+RC24Y2e/JWCxUIk2/C6SeIiKsfbLYCakSXnkISQnqe6jOJHIASbEjlSQm0emaRM/tKBKc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxtoXs2t; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7833765433cso7843287b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670630; x=1762275430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZSNxR68yHjL7zAo+Mv3sJfsksYIyvHAgD0mbxvBcYw=;
        b=kxtoXs2tyYUa/OnUAm9YuC+KkVYe+0j6de840pULz+2oZhsfrvYD8yiM79I0JDuy/c
         8SgBz4l9M8qRgo4zykYrvK/GqiYdgeGkG5uzx1RoT2fyd5RTgyqnb2oBXpSAlQqEQcc0
         2xPaFreEStUSZ7ErmrHNFaDrsG4iSNKnkva6FZjCxzqFeMqGc874KUoqTyIPy0cmyMzV
         oKvou+7Ha5Irg2H/6Dy68piW6Db0r7OzcIPu1+jo6ktS3sJlCTtFT30wLuRROpqHFY2L
         H4Zl2Lr7mbsTm5d5xENsjsKyJ1q++5akki3pESzFpx7LQjkAT36kz4J4NcIyeVDWxKjq
         nJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670630; x=1762275430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZSNxR68yHjL7zAo+Mv3sJfsksYIyvHAgD0mbxvBcYw=;
        b=wF5kTu1ww6T9kxRoYsb5is52I+YxUuVxQCdkQByBwtkJ+QbLA95BYpihyl6yCioRkm
         FrOjjm8eZwoNO4jVA2gNdJVorX1n1YjAmjFZOCLWCWCdwfeou6zEGmlJYs9DECV9eTdT
         rCy5dOrzM0fRbgpzM3pu20s5MDFHNc/AaXTbUoBhgdXoz6hbF5v7YbuQidyxDh80NX7n
         Io9qm6ORlXW8xHNsXGKiVSVlXgMgpGyM/+Gn/q2ZVSjHBc1BbtM4vv+IBCn5ThUhyG1e
         KIyFSHuQkoH1Ei5TyGq5u2E3FUYIhHeWl1YoVjo773lPhleAPh4IscDgEZBiIxs8hYVM
         0CJw==
X-Forwarded-Encrypted: i=1; AJvYcCUq20n2aodz5B0z5J099WmxrD3NYWC69+jQXsy9FyGouybKTBAjUJ98EkpgrsmFO6TA9medb2ZPDmvpbK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCl3zRB+qRZkkYVkYSfcinBaTZVJ4qVLFEEsxWKGlWQankPwz
	B42aXOdsJ97df7077wQcBnHiUmnbwTOM3r3TcbsenwAUauhrAVlpyYOcsIAKNAgk
X-Gm-Gg: ASbGncsjm1J8l8WTaIErl6rYHJiJsbfHuxX3mSDp0MCyrA0uBfpSWWyv34jUjr+h/bf
	66x1iq7dHxfoAwM/G6Pkap/R8vnb3LOf+YM8SYjhXFjsesCYp1+B6ng9h+OdHyTHMHeoqCPw9au
	A051TRaIRHUbaZP+cm/+vfxbqpLqGHVfkJXQBAIhvq9xTbWN1x1Th1cjJK01ueMgo+0ufa26XhT
	HaK4gLxBlPajrv7Uhq108yRJmILCGd3B9o1jGfUR6zXbsR9Feka16YYRQEkCk+BIAAlA/l6/fMp
	w6JscIDqF+wzjCrfYAaeRR+zRCzYOZ7ngVm+9YGocXfsS+JzcERwy37i/JwGCHxeAmG28XtPF25
	EoKVQ083bo5zMtAqrwr7pr2a0TwVxe/waw3WhakMFaTq3ahDr5fXfQ/31AUtcZiyspj1QiUzh6s
	T2Xaa9Fz9Eg3ynaHUZUpg=
X-Google-Smtp-Source: AGHT+IHYzX3zBX9m/HOdpIkdCjhBMv9C2sbByBuod4kCB2jxgbvqLV3QWhnzZ0epjRo8NPkrViDs8g==
X-Received: by 2002:a05:6a00:3d4f:b0:780:7eaa:938 with SMTP id d2e1a72fcca58-7a441bde268mr6351210b3a.12.1761670629662;
        Tue, 28 Oct 2025 09:57:09 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm12133857b3a.50.2025.10.28.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:57:09 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: andreyknvl@gmail.com,
	gregkh@linuxfoundation.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	snovitoll@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Subject: [PATCH] usb: raw-gadget: cap raw_io transfer length to KMALLOC_MAX_SIZE
Date: Tue, 28 Oct 2025 22:26:57 +0530
Message-ID: <20251028165659.50962-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit removed the PAGE_SIZE limit on transfer length of
raw_io buffer in order to avoid any problems with emulating USB devices
whose full configuration descriptor exceeds PAGE_SIZE in length. However
this also removes the upperbound on user supplied length, allowing very
large values to be passed to the allocator.

syzbot on fuzzing the transfer length with very large value (1.81GB)
results in kmalloc() to fall back to the page allocator, which triggers
a kernel warning as the page allocator cannot handle allocations more
than MAX_PAGE_ORDER/KMALLOC_MAX_SIZE.

Since there is no limit imposed on the size of buffer for both control
and non control transfers, cap the raw_io transfer length to
KMALLOC_MAX_SIZE and return -EINVAL for larger transfer length to
prevent any warnings from the page allocator.

Fixes: 37b9dd0d114a ("usb: raw-gadget: do not limit transfer length")
Tested-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com/
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b71680c58de6..46f343ba48b3 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -40,6 +40,7 @@ MODULE_LICENSE("GPL");
 
 static DEFINE_IDA(driver_id_numbers);
 #define DRIVER_DRIVER_NAME_LENGTH_MAX	32
+#define USB_RAW_IO_LENGTH_MAX KMALLOC_MAX_SIZE
 
 #define RAW_EVENT_QUEUE_SIZE	16
 
@@ -667,6 +668,8 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
 		return ERR_PTR(-EINVAL);
 	if (!usb_raw_io_flags_valid(io->flags))
 		return ERR_PTR(-EINVAL);
+	if (io->length > USB_RAW_IO_LENGTH_MAX)
+		return ERR_PTR(-EINVAL);
 	if (get_from_user)
 		data = memdup_user(ptr + sizeof(*io), io->length);
 	else {
-- 
2.43.0


