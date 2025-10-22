Return-Path: <linux-kernel+bounces-865605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35088BFD88E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67831A00E21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D328EA72;
	Wed, 22 Oct 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="kixgYPs8"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C22749D9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153661; cv=none; b=OaZXmmD8eNZqkmOg432wnwSyfb0exjiaKZv+fZCM33hyC6JudllAHigLymPJQ/oPb4PCXh7a5Hq83wk2ivD5cqC3VK10uAEeJn+iHqJhHHQtwK+UVEl5rv2mbwr72jT1Yy+0kYyLPjRqrMfS9RHwpTUgjqc8OJcOKiHwrCbzpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153661; c=relaxed/simple;
	bh=RDxBhDccQNTTmUuAIxDyt/eux6gk25H3gXgQVVgZ6NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rNOv6FATujaSgK74h30bvKbkZeEVAEKTz6GKjpbQCPrAUEApLdkwDflUpOJ/V/n3zMn2TR4wl9H0yPfwlnZ8vbvae45eMobnGFyTqcO5f2inxHnGHL4LZUBRlfi1wiNlUBHATVx+NhpbUIJJEiA+R+G8NpYkfkG5IwU+ve9R4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=kixgYPs8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so5810743a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761153654; x=1761758454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJlYAnYJCsQ5KZ0qHSI39aoyPXSaqMpg4SB26b2+5nQ=;
        b=kixgYPs8mdn6hl57T0NZDFEacJGf4SCs+7G2oojNpGhle1SiUeIfER8P28dYCx8Vg8
         xnkuJTDubH11d0FYKR79c7VmGDKh4QfWj3OuoQe0CgrprRniPNEFsBl/5F9vknbUevrm
         VwjwrkW/j+G3FGABVSZqUCb1nh9xIkEVjoPAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153654; x=1761758454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJlYAnYJCsQ5KZ0qHSI39aoyPXSaqMpg4SB26b2+5nQ=;
        b=GrCunKeRn2hEo0GwHTbuOwrK/NnmYS509aoKtR02Ay+TgB6ln6Ycc/AHwxonz+Uerj
         p98Rifccg+fLNwNXFgsMTXkObEUvnZHXbYfQw8qQNs940A1FysBy/XeQq1QTnYtvR9o7
         S98IHJj5cmww5qtYUjaXv1BnFDPWgVqWqY/21wGp6juHyowdJxJCOonemIbo6swpgml4
         FQric7zxJxNnPuiOEM4B/pQR9d0hBW9zGfhRiE/M4F73BnuaMTH+6zgxBBkIa4dy4DvW
         4GD4YGi41eX35ov5EqWCwMUdozVKLgnvHIRyAzvDELQ05ekhGEakoRg39I9tsUpFyoPG
         z2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHJYZ+piacLVmU9/ZQMMPTP0Jsx49FSgrOBN4sUCh9nM9D4Ube2It/IOCJgmxV9kCwfG5vPT9cTvvWZ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7k6cgz6aJwAYvJ78l3wOFB19Ig/SYF2+UoBBmCGeQIG1yKEuH
	2VFt8L6n244m+JgSTvLNtpJdUo1sieQsdqhiD/CuF2AuuHlMRn6BwAaH3kMaDiPIrHkruAql50q
	LvH3FcEDnXOYbP2tKxSRuFZxmLvBReOl7HPQVGRUyC1b468ZsWqI/IJ/n
X-Gm-Gg: ASbGncspeXp085eLkv0h6aw/rXft5tFhHK3YanwYqD2VtG4e9gNEvdEoU4vAwsVb4bN
	kiVBjfjQgXw1LUFQ7fz3sI6izm4fQ8awnKAZlMUgZAZUSHAeW/iLrdUZtu0giWPsjHcHjeOAZtq
	DnecT6KD3QKl2uWOE3+JP1wbXdbxHq/RIePrgjSBirPXNIBAA9zuqTkl80T1h71yyV3VFhzGjkq
	2gcnPrjjB0v3J13WGnedPmEzvJcmufj0LQ6LIBeNf/C1sZG9UB5cMhyeLPBtlMsAnqASqyKvW3C
	zALlPXGbnB2U18FPOOs9wFkeyBn1AvNV4cJXCEZottn03Cl6xW1G/jAPjvEVj8g7mhtnhfgNUh6
	RKl0rGIIc/x3jOhjuBnrsemiu7KrDNLSSdHLwQqVhmDl5HPE/vWVCPY/UzxRRyrNioKv+THaxzr
	SysMy2lxJMYiyoNYINnVvr6WYY6wlBobXoVec8NTkr0fWyGMSPoedjq++RVjO6uawa9F6sixKPS
	IA=
X-Google-Smtp-Source: AGHT+IGwPZD6AsalYCzJnHEYLUjuY21HqxLrzheuD67TroTDroqc/7a3AGzGedrnuVb1Tzxscx3Hvw==
X-Received: by 2002:a17:90b:4b51:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-33bcf9237b8mr23362914a91.36.1761153653245;
        Wed, 22 Oct 2025 10:20:53 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:e15:111c:b0e5:c724])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2c3bsm3133625a91.20.2025.10.22.10.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:20:52 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Date: Wed, 22 Oct 2025 22:50:45 +0530
Message-ID: <20251022172045.57132-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"

net/llc: add socket locking in llc_conn_state_process to fix race condition=
s

The llc_conn_state_process function handles LLC socket state transitions an=
d is called from timer callbacks and network packet processing.

Currently, there is a race condition due to concurrent access to the LLC so=
cket's state machine and connection state without proper locking. This caus=
es use-after-free, array out-of-bounds, and general protection faults due t=
o invalid concurrent state access.

This patch adds socket bottom-half locking (bh_lock_sock and bh_unlock_sock=
) around the call to llc_conn_service() in llc_conn_state_process. This ser=
ializes access to the LLC state machine and protects against races with LLC=
 socket freeing and timer callbacks.

It complements existing fixes that lock the socket during socket freeing (l=
lc_sk_free) and timer cancellation.

This fix prevents Kernel Address Sanitizer (KASAN) null pointer dereference=
s, Undefined Behavior Sanitizer (UBSAN) array index out-of-bounds, and rare=
 kernel panics due to LLC state races.

Reported-by: syzbot
---
 net/llc/llc_conn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248..c4f852b2dff5 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -69,7 +69,9 @@ int llc_conn_state_process(struct sock *sk, struct sk_buf=
f *skb)
 	/*
 	 * Send event to state machine
 	 */
+	bh_lock_sock(sk);  // Lock socket bottom-half before state machine proces=
sing
 	rc =3D llc_conn_service(skb->sk, skb);
+	bh_unlock_sock(sk);  // Unlock after processing
 	if (unlikely(rc !=3D 0)) {
 		printk(KERN_ERR "%s: llc_conn_service failed\n", __func__);
 		goto out_skb_put;
--=20
2.43.0


--=20
::DISCLAIMER::

---------------------------------------------------------------------
The=20
contents of this e-mail and any attachment(s) are confidential and
intended=20
for the named recipient(s) only. Views or opinions, if any,
presented in=20
this email are solely those of the author and may not
necessarily reflect=20
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form=20
of reproduction, dissemination, copying, disclosure,
modification,=20
distribution and / or publication of this message without the
prior written=20
consent of authorized representative of SSN is strictly
prohibited. If you=20
have received this email in error please delete it and
notify the sender=20
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain=20
ssn.edu.in <http://www.ssn.edu.in/>

