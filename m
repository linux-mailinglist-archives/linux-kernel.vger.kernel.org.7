Return-Path: <linux-kernel+bounces-687375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7ACADA391
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 22:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D323AE1A4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E828137C;
	Sun, 15 Jun 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drVlCNEw"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4B280026
	for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750019724; cv=none; b=CXiRuALsFvrqwo43jIFAC4zWibKwGdTHzeNlt1pVuROIsW1u0jAO8/WxXZFOL9PN34btWKdGGiXJcUaXJHPP9DNQ6q5gQWGQg8s4FtWyjU66PpRMEAKHPeP+NGge9nnw3f4LUl0JYRoZeOROvwERhEQCXmNLPj14ztKCNPvPwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750019724; c=relaxed/simple;
	bh=eefalO3G4OiFpVeK1OhrV+zsNM6sg42ryjlzlayMM5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u/uJw98GywScgdOxhg1tA21QUtKVB7yQUbyt5PJaXibYCqL+LWYr/hxnfR2A1dshyFSAoPpe6hXuY3QwxJzeuUno7fTVVciKoMh8Nd/dVaC0Ziq4e00apC6n/PP4K3GiMHrpK3nSUbQKlJyENqreqkvKqXCx7k8bcWywQXmeI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drVlCNEw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c37558eccso2765499a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750019722; x=1750624522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9bzv7JyOJ1NSTMXlUhkU8Ue0cotpcV0fiBdvuBI6fY=;
        b=drVlCNEwi+aYMU3RtEU8vAfLv9hy77IXNTlyCUuyTUC0Ud+f0agJHYSkNecNI440qo
         sv2EmLPzUkwBVAzgbU+O5FlwG+UR6QSgK6rZfVTBvObPSFWC7lDWyYKVtRfhv7i98vUx
         ZAOynYmeFYsBX8MpDm2GeqLICj92sMOKQWfliJjRn4JVi+SF4A9G6JgGUfEYt/7UmM/X
         kVlXG40zYaiSxQMUR6TryBH1L+5wkNWTO7u9sCTW03BA2ONxZHs5cQAyEY/HKHB0MQFn
         MSCu9iemzu8RH0cDC8vunU13AFIDYqW6zVILby2M3b8R3PJro2j38KeEO2VUhXOHUjKr
         wf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750019722; x=1750624522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9bzv7JyOJ1NSTMXlUhkU8Ue0cotpcV0fiBdvuBI6fY=;
        b=kBaXaXHaHh3RBoliIe6XtXWLFYtYk5jUohIQrl4vGo54vEC/iMea1kpy/RvolAzInw
         iXmB5SmCx9l0a1B3rw81+10EFCyMvProXnMDKWMMw2ol5t/49m22qL6J9X5xOvh20PTf
         pWszJZgCl+Ho9gWeko0K8ofg0t5jymufJb7B0Si7nC8RZvwhwSDinj5CpG+2YHn6iLHm
         q/SdObEhdSa5jMSPfAUwR/o6flQnc0EphXKMPkMCOashW9AbQXCwX2zCKcAs7rLOFusl
         F3hiJOtP8/9bPzq33pM0dditKOlWtLpXhI00povzR806KUdKsi7DS7SVfNLqcBTsl2bb
         o6ug==
X-Forwarded-Encrypted: i=1; AJvYcCXsitcCZ22nqSJrREb9N9XlXgHtacq3A1+ZNP5oBlVqweML/R79BzDkfHhsgNP/1JEsYGmCm8RvuMbvQyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXR1A1BvwX5B6+1FsE+9g5YDPd+z3p0QON6xb4H7aMeoZwsHNF
	SzN8BEHPtRWBhhQ6nU6BXwXCvsEG3cnfuc94sfAoFcPUO0RZ44XRJSks89idnSwLU7SNxdvC7Zg
	0ByGv0HLBJpIxMCidQ7k79lcO9A==
X-Google-Smtp-Source: AGHT+IEt/qXb9jMNJY8IcGPlKUWlFpMJOPx3Fz4X3s17m2n9/LIeU/6tW+VwfxsFfR76tm79sgQHIjNEQ26ycUgA6A==
X-Received: from pfbhd18.prod.google.com ([2002:a05:6a00:6592:b0:747:adac:b0dd])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6e4a:b0:21f:5409:32f4 with SMTP id adf61e73a8af0-21fbd50a6a9mr10345731637.8.1750019722372;
 Sun, 15 Jun 2025 13:35:22 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:35:11 +0000
In-Reply-To: <20250615203511.591438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250615203511.591438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250615203511.591438-3-almasrymina@google.com>
Subject: [PATCH net-next v2 3/3] selftests: devmem: add ipv4 support to chunks test
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"

Add ipv4 support to the recently added chunks tests, which was added as
ipv6 only.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 tools/testing/selftests/drivers/net/hw/devmem.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 7947650210a0..baa2f24240ba 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -51,15 +51,14 @@ def check_tx(cfg) -> None:
 
 @ksft_disruptive
 def check_tx_chunks(cfg) -> None:
-    cfg.require_ipver("6")
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
+    listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
 
     with bkg(listen_cmd, exit_wait=True) as socat:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port} -z 3", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port} -z 3", host=cfg.remote, shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


