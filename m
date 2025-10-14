Return-Path: <linux-kernel+bounces-852450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6802BD903D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CADD3A7CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7BF30CD93;
	Tue, 14 Oct 2025 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa28oB77"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4330FF28
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441221; cv=none; b=NubbK7OsGYFAuYWr3b081KYKo2+ehAGlk71jAgvPnv1nkIhcicIdLziH3t/+iCedDYt4IJ0h2i3cKSJa/KZ0ovWsYlXEKpw1dq7DLcyfrCexcuS9McSAqOWhq0Og+sHGYhD8oghUEK7M8gVVwpG/r6HgaZTktyNLFM2UeHBI8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441221; c=relaxed/simple;
	bh=9UBTPaJM795jgL9QFzpBm8/hFhK0/nTuD4q5tVTvhPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuVe27w/+71PDf+t80VNdN6Seti50YX/urVFEc55sN76oEmAeDaEtjxrQDG2u349XYWFQnYWbGIqRImZ0To+dzVuKv37RwNyfRogyMRGkcEqiq5MstzWt2LsQOGgzSrzWdjeSnSBEIN9GQC3YCAJmq7JBuX/6pysyHvt9dVDTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa28oB77; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b63148d25c3so3427432a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441217; x=1761046017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUUWsY7ufR6oqn2huC+LiTtkNemBc7wwNq571Svxhxg=;
        b=Fa28oB775qTKKYLCutJH9HB1NJGHWdnuHe8YyZEzlnCGkAtNn82UtCSnR2bpes+Y2p
         qce5MNCf/qhajwosxaXhIujakgaD1Kx3eVqAjX0kKVc8wrb0epRpBh8i6xkd2wQcJFkT
         ppUBAzEGdfgOhST6vKBb4/Y6j6/2p8gHzCufzRMwFpE4B+PaLsEVC6GZMwhrzdqz/ufG
         e36eKh0FZCOxnqx5gRIaiJLgR4wytTJU3e8U7G1jfCthQac7geQYJdXfi9C6juJFvx+N
         Vy07JN9+NheSS/d5FpAuLFkSw5bRx1Zdinb4jF3gHu1UE7/LGNIRhSAEDGaPb4mYDGIQ
         FwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441217; x=1761046017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUUWsY7ufR6oqn2huC+LiTtkNemBc7wwNq571Svxhxg=;
        b=xEnd0KlFfJ1dJHkvpcbk7MzBLa7hkyBkip1mWWAUUWtxj3MNEXiSeRj3GT0b+cEtoO
         VYRPCo8SA6hjkm8v8229myrDu80cIadX3GWwUYwkX5RpVhmziMB1RkOpYWqzlY9TRYQQ
         ZsvaMFmiTR545vvUJPKbTz3/968/nwcl6NorJTTfblyo/NiUe6kjBjKM89Wnw3Hgg610
         hVYlsNKcLTSD0KdU5omactANAE5Ib/8SYxVsfSJbyy25p4sOF1K3q6/EM6yu70okR1bQ
         f6ZsOJNmZZrAMVyK73ykP6PNtfwHLwk8QHXfFygaVV33tzWLipUZXz6/0VBnYmy6g9Yq
         Tk6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv1Cy1DlcknrM4ssKmiQHmVmlphJd3G4IXpmH4wBaP2c7YEMmpNQaqL4T/g8npkg8PBRZnOcTclDRj/iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT71e/pEdtWUAWs8h2gl7pygjofEStXTf4n/guaj8M9NIh18Q+
	DTtggP7S9Fpf9AdDqSzVau3UeHQhmBomObYmMxUQuBP23gllELRGIaFv
X-Gm-Gg: ASbGnct9E3rG3q9jDclNRNhjRmvTzZYzfjlEwE+apnRZtwsvZdjoDvmR5aTKaC3ttf1
	Rv6Buy9W+jzOcxcI63Oqk/O1ibn+3es0gAzNDkeiOnU2+RxIY+viuxOTD2FSwfqN6x0pi6ErSB7
	D2yPEWLOHM+JZ9MEBGsxkR/A7ubbtgf2QqKy03B8XuT76A2Kzp/eKmlbC7P8yEx6EMZie5GpQz4
	vu5hpjKBBa8wvLZd7aGAwZfNAiJWvJKRAydc3iz44ZnHAM1lRRgf+TpBVSiNZd3uaMuVhks1ouZ
	fqtufYceuaQ2qwGqMGpJ8Dg+hUsEUQavTc+37k7g8TKOOMKQGv26DbSjGmQhUTM+K2N4Yx1L5C0
	iZibRLJ1p8p6Uzr+NjvctYhqIw6azV8hRu4IQ+tTcrUWVAkEwASOH
X-Google-Smtp-Source: AGHT+IHwj+Dz4L8DnGND7olSFpVsnMTn5Lw/TEHpx72gcX3uQG8ce7dMeM/FZb/y/sUkqHY1JHLYcw==
X-Received: by 2002:a17:902:f788:b0:274:506d:7fcc with SMTP id d9443c01a7336-28ec9c0c7e1mr394581375ad.6.1760441217252;
        Tue, 14 Oct 2025 04:26:57 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:26:56 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/4] rcu: factor out migrate_enable_rcu and migrate_disable_rcu
Date: Tue, 14 Oct 2025 19:26:37 +0800
Message-ID: <20251014112640.261770-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014112640.261770-1-dongml2@chinatelecom.cn>
References: <20251014112640.261770-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out migrate_enable_rcu/migrate_disable_rcu from
rcu_read_lock_dont_migrate/rcu_read_unlock_migrate.

These functions will be used in the following patches.

It's a little weird to define them in rcupdate.h. Maybe we should move
them to sched.h?

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/rcupdate.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c5b30054cd01..43626ccc07e2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -988,18 +988,32 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 	preempt_enable_notrace();
 }
 
-static __always_inline void rcu_read_lock_dont_migrate(void)
+/* This can only be used with rcu_read_lock held */
+static inline void migrate_enable_rcu(void)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+		migrate_enable();
+}
+
+/* This can only be used with rcu_read_lock held */
+static inline void migrate_disable_rcu(void)
 {
+	WARN_ON_ONCE(!rcu_read_lock_held());
 	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
 		migrate_disable();
+}
+
+static __always_inline void rcu_read_lock_dont_migrate(void)
+{
 	rcu_read_lock();
+	migrate_disable_rcu();
 }
 
 static inline void rcu_read_unlock_migrate(void)
 {
+	migrate_enable_rcu();
 	rcu_read_unlock();
-	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
-		migrate_enable();
 }
 
 /**
-- 
2.51.0


