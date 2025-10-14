Return-Path: <linux-kernel+bounces-852449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA8BD9036
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DACF94F3A95
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465630C372;
	Tue, 14 Oct 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeKEGhA/"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED5927F01E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441212; cv=none; b=Jv1ngFfCOCB+rRnrn4ixbSpA9VH8mubMbBNhAz3ItCZF7kvPj6DXE5wetbf4u/P18mBqjdyEbBTRyBvhRTMhcFVYz5wltvNXQx4qQ7AFmmKyZ8qPJJJwRsTzZFB9bzga3O1hG6U/AAtBCKrQgOkQESPc9WUZ/0Hmk3HMP82aEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441212; c=relaxed/simple;
	bh=sNtAJxFaO1bpsJ7T3EFg6MpOu/5KWOLXMsJW6BF7Sqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZPOh28LuaDr3bqBIjE+L5Fnrapm4zpNnr1LJ8ylA8EtbPbH3MQ0laT6vQxpkhcr2E0HkVCD3DcYyDSzmWh7pHe+RgWP5vFFeRcx7r8sIfW/eDharMOKU9abjX00vWcTLlMr0SUafKV9npbia06rN9XPVGVtKBwxfc1d38lhJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeKEGhA/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-26a0a694ea8so37349785ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441210; x=1761046010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ2ZoM9E45cLB86EfukwjzrhhG8TE+RmWdJSk8qEjw0=;
        b=PeKEGhA/IfX5/RkTE/OapFrsy8wQfceTGaJBlFW9uHP5+NIWQH182VSX1mEJChC28h
         asK1BcEd662cPcTjp8tM7/fDQYfCaUf5B3NU0lELJw1GKMarMwJg1APbcmVvqfeBNbgd
         AJjBOEnt2ggE4f+nEvY4jqeS5AHtPLK67lxyw4rJ3+MOqz5kdXPoI5vg2TCfvpHB7MB9
         DovhyPxnp0XhSiqTepKh2UGA6PLlywTJdYKC3iznVasexvsGfLfW+nfM571vJ7oLhIKR
         OTiWGSgf4XXJcc67FVnLBog2vJ/MARka/IfdvlNYsg0XtDznLInZb2rg6fFwoNtcDfMx
         HNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441210; x=1761046010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQ2ZoM9E45cLB86EfukwjzrhhG8TE+RmWdJSk8qEjw0=;
        b=WuyPVt8TAFtU5uT/aiZaIMHZWDXo42arVD9Mk8HvsVwAKNDur4pjgEg6soPK0KSdF5
         oDZyj8nwudfbhRDTwMDb/Nwp01M/BGLWgfu+9IRKCD9u79lfRJaIiGhyEUvusL5ze5HO
         3LTRBR865a0ep8pcM2Iw3wZ4eN+5lDcyExCCmo5TmR8mq85Wipm/tLUiTzhQLEn3HNzL
         PuUsbjXqwEMTrmdozT46jExohqzTt/VDzk4T1VdRgvawNgHW/uKK2TuUTCCYWx5Uyiau
         zI3WfUQrQf7Rk84htJceZyC2pZrZDELejU2XdthfbKfC5RnuRPuX7zIKeJu0MdJiphSu
         rJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsLlUyfQI35T+cbHRS1ygMLlThQzWU7cW2Zv0WnErCm4da56HyKRU/bWvfJBdHbni+bAtHPQYwRpG7Pc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7K5u0kpe9GgU3I8Bnz74wrgkt1mdbY/bNRtrf+hDN4j/HiEv
	9m/uaxFNxAYwssD9SOVTupUlHaRUNKY+agDg/R4c0vI31jNzmQ7HtkdN
X-Gm-Gg: ASbGncuNpsIxc//J4wgrH/4ggSMEtsPVWHysGiS3q6FCqJ3IG1onHMfIDnzWFNeD0jt
	ofdL6EdS7cuJIaIJvifn0yLgLC2x5cfHU2e1pqJ0OHgFfdkkt3We32B3UuTxRB5wV3C7Whrp8V6
	+Jf5i3OzrU19uGKLf+p/gViMh4Ft3+RYSbp29kysyP8XzErMv8iq47UuzbnsZkkke1GCykJ+AHY
	sOdq+9kJzjsIFqabwCuLgZzwzU9Q5zPgJPyJv5zr4MF783LxTNz05PbZaAmuRSDScYK3AwQAAKe
	d9Opo/H5DeqUPkJV2ylSDtNpW20DGYBuzJ3a8s583xpU9xbTwHtupcZJZZyKhIJMFaJ6MGtwQ+M
	Ghwm1DlXrQamuvXirXlBYcO7JdCZgib0QhFZENwdJ3Q==
X-Google-Smtp-Source: AGHT+IEI2EG3hXVYjqyv3KTySouxEuLylIu1QpAbH6omychwoEa9DKSUCImhv1e9qQ23Bulue/Ky9g==
X-Received: by 2002:a17:903:1510:b0:27e:ec72:f62 with SMTP id d9443c01a7336-2902728b8a2mr307225925ad.6.1760441210407;
        Tue, 14 Oct 2025 04:26:50 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:26:50 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/4] bpf: add and use migrate_enable_rcu
Date: Tue, 14 Oct 2025 19:26:36 +0800
Message-ID: <20251014112640.261770-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we can use rcu_read_lock_dont_migrate() for the case that call
both rcu_read_lock() and migrate_disable(). However, sometimes they can be
called separately.

Therefore, we factor out migrate_enable_rcu and migrate_disable_rcu from
rcu_read_lock_dont_migrate and rcu_read_unlock_migrate.

And we introduce the function bpf_prog_run_pin_on_cpu_rcu(), which is
similar to bpf_prog_run_pin_on_cpu() but use
migrate_disable_rcu/migrate_enable_rcu instead.

The function bpf_prog_run_pin_on_cpu_rcu() is used in following functions:

  sk_psock_msg_verdict
  sk_psock_tls_strp_read
  sk_psock_strp_read
  sk_psock_strp_parse
  sk_psock_verdict_recv
  bpf_prog_run_clear_cb

Menglong Dong (4):
  rcu: factor out migrate_enable_rcu and migrate_disable_rcu
  bpf: introduce bpf_prog_run_pin_on_cpu_rcu()
  bpf: use bpf_prog_run_pin_on_cpu_rcu() in skmsg.c
  bpf: use bpf_prog_run_pin_on_cpu_rcu() in bpf_prog_run_clear_cb

 include/linux/filter.h   | 16 +++++++++++++++-
 include/linux/rcupdate.h | 18 +++++++++++++++---
 net/core/skmsg.c         | 10 +++++-----
 3 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.51.0


