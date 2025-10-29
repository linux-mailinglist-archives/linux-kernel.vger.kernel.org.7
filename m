Return-Path: <linux-kernel+bounces-876942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC67C1CD24
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7357934B964
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A20357733;
	Wed, 29 Oct 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1K8PFzo"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6935772C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763580; cv=none; b=fD4gokck8pnBC+z1KTF2Lw6B0eo/QfadUbaZVokEtSePdVX2MzDB+oVX+T/qLll9srL8y1z4OUWIwMuhlz4hiNb5s6jop53vD7UN/pj9eVbuB8WtdnjkrOvTfCgYRI5ZOtyEP6wCeofWDh+Tt9RXY2HPNKvlBH7rogO0kWNXPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763580; c=relaxed/simple;
	bh=Hz1cW695wARv+9NNwYgilEM99jI1ucwDgTbPkgMEw+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kqUenzITpr4KDYYYj4N/ge8RNtV5ZjtviOff0a0j7HFfJtD/1FXmT8POM3waOhmLXe3Gzhxa8giMWBMcd6SpC9gL8JxXUy5PGIdYm8FTap0a991HhRYpgQumS0dXCrTIoPBuw/Fsu5jDHCJ1qeYzLWZRZ4qEnofmTPflNvu7qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1K8PFzo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so56589a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761763578; x=1762368378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9IwTcakLAgrwbK0/rUiOaLMeUNE4P+aCL2i5ar5nog=;
        b=p1K8PFzoXzpg+fN1+poLJELtDyA07pofMtNaKHDS2A0ndVF1X4s0eFOYuSUKABY8a6
         1LQZ6AwlYsHbA9yQP19lGhqYG7YL4vEgCIA572XD7DV3hQGCTrTg1ObgsgojU7046Uvm
         zVPVBpog6+lWUtB2R1wLAdZKgaza5DhyrOpAIYY2uob2TYPkGisN/YTTDakOtlTZuDa2
         AwkgQKiizjokL8ZXJjJ2ivbvkP2VRb9NKecT8nLyrXIBuUXpBPe6sZlcI+LXpJcCOZNK
         MQgDs7utbsQ4Rwd8gWjtDJB4aqdYU5I8ZkT6fifXsozPDkE4AUeanMN9Zfq3dwKbuypS
         V4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761763578; x=1762368378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9IwTcakLAgrwbK0/rUiOaLMeUNE4P+aCL2i5ar5nog=;
        b=Hpp8Iaiu8ZBrePXJDiELPyzUeaIqn7UM+6MiB6rZ96PpODbz4pZzJ4gQSd+vYGCpT4
         8h75ncLFzJ9vOhJxM9LMlcDSWKWZff/RyoW7bFaS+KCrEkS7OJDof8XNEOPC0tKZDzMA
         NAiNXuzhvTN+DUpmWacrOHrmYnLMk7ESbhrFGsU3DTJPHWn22wDeih5yoOFFF32tZnt9
         YzRgiUBsXI4D04G6FUsy0Og6NOhfAaBiVQUG1g/qFypzTDNqfdsoTW6vL1ZfM8tR6La6
         44PquLTBQPFGi0b/XHCVHrbLHdc2q2xy0RrstEzq37lSgYnLLq4ZxpBMiQierCFS++oo
         UKVw==
X-Forwarded-Encrypted: i=1; AJvYcCUYciIcHnPLNTY6Lwt3NfAZnWMmEgeO2jDz/+r8vJGgmh/IWoASd6XtrE0rsGVyw/S8JPi6AYQ4Z7pa6HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1xHU6n11U+YNrfcSk1a/tSlVkKut0OP1qbdcmFDS9Jxka5ZH
	7ruqH6MrOqf3bCKxAbjfJY95dTQnyyyF00gXXJtunYMmnPqY4YSz0/TXNhWwQB+wy00dF4afFaz
	kAW3sKMF4vkubnw==
X-Google-Smtp-Source: AGHT+IGBXn4UqDJBhNJF8Mu8AdNxT3YMrXSar3uJxtmQPCtoodVpYeYO9PeH5wdj9Ndf9qskRirxlFt7PN8v7g==
X-Received: from pfbbk13.prod.google.com ([2002:aa7:830d:0:b0:7a4:f01a:8bee])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1584:b0:2f6:cabe:a7c5 with SMTP id adf61e73a8af0-346531469acmr4427423637.34.1761763577596;
 Wed, 29 Oct 2025 11:46:17 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:45:39 -0700
In-Reply-To: <20251029184555.3852952-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029184555.3852952-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251029184555.3852952-2-joshwash@google.com>
Subject: [PATCH net 1/2] gve: Implement gettimex64 with -EOPNOTSUPP
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Tim Hostetler <thostet@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kevin Yang <yyd@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

gve implemented a ptp_clock for sole use of do_aux_work at this time.
ptp_clock_gettime() and ptp_sys_offset() assume every ptp_clock has
implemented either gettimex64 or gettime64. Stub gettimex64 and return
-EOPNOTSUPP to prevent NULL dereferencing.

Fixes: acd16380523b ("gve: Add initial PTP device support")
Reported-by: syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c8c0e7ccabd456541612
Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_ptp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index e96247c9d68d..19ae699d4b18 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -26,6 +26,13 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
 	return 0;
 }
 
+static int gve_ptp_gettimex64(struct ptp_clock_info *info,
+			      struct timespec64 *ts,
+			      struct ptp_system_timestamp *sts)
+{
+	return -EOPNOTSUPP;
+}
+
 static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 {
 	const struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
@@ -47,6 +54,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 static const struct ptp_clock_info gve_ptp_caps = {
 	.owner          = THIS_MODULE,
 	.name		= "gve clock",
+	.gettimex64	= gve_ptp_gettimex64,
 	.do_aux_work	= gve_ptp_do_aux_work,
 };
 
-- 
2.51.2.997.g839fc31de9-goog


