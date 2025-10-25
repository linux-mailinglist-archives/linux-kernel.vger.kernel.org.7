Return-Path: <linux-kernel+bounces-869918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B39FC09005
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776351883F66
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F12FB0A6;
	Sat, 25 Oct 2025 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0BMnNZp"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4531F5838
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761393933; cv=none; b=dKuTGTJVKXIm/3EFlda762C+bgYxA5R1moqhnooL1Hqes0P+xAaimnmJKZn4RccEaJOwwh+oawYEp2csLK3JZQGDL9p7phCgN26+4kphHP3b5yu4Swevz+bmZXDGKqXA72i8VdSYBFGgabYFOU3XsHiV+azX/ijjAwnfA30fsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761393933; c=relaxed/simple;
	bh=69y9OitDsvZG+ygITGh4xZyW20ZYYBCYMz7R434uZKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F7Idz3IlkG8eyxgk36WVoSg3j/XEUPLvvJd9ajo944h9px+FlvG1HnbouOw2pVXe8OLdFwarfRmDEcPSFDqJoKmUP8gnTUX4ekO+T63/Zy5XDy4Ygw3gN8fdSUQoluMjiEYrQZEBdBWB4Y0HC7ABWZ3zaYgxt/EaT7IyoMYkgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0BMnNZp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso3718533a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761393928; x=1761998728; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcJ3/FBKK2ajxzIkHMY6ixiVILAkehDzwnS491Vgj6k=;
        b=Y0BMnNZpfTBwABFCVZIAHh3td9Z7lLwIgQyaUc3ZUkYsaroN3L24Juyzynbgp9anyB
         7wTmZLv2XZB51rlipw8hM3Pg2k6DUYhktOy4qKX94lW5V4bJ4J2mnzQittGVcpo16omp
         rlWvs3fkLMRnTcTY5aveZrD94JYaGrSSbXoezvjSp34Vd+awO8NYENgFaZVPla51vWgG
         oUWgZJxBD2FQ/fUDT3ky1HWfgle15M8S8kpy7tehKII6MiDYsUE85tJlgIQEHCVUlhdj
         M4S+R/BZESbFvNGrFufTVrRqmSea+DoL7cTn8tosugPYk1cmW800n0SkeYbAG27t6cg9
         h7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761393928; x=1761998728;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcJ3/FBKK2ajxzIkHMY6ixiVILAkehDzwnS491Vgj6k=;
        b=FMvBRwRSQ6lxztxDStGYSuoNfuu/sf0uZLGsjNkeI694wexP12cjVNyNkR47xEVK6M
         3nHHo5eF3Fw3PALAhcUW6FJU9EwZ8pZM+Thuol7eTsDfhtR24IgRQAN4z2fzklKQAKWh
         eKIGlpzHvLbxWCWFIT6DubZnXJsqDZmUwQgLo4FrkZMNyAeY2lDEBXs1LQAAZc7uiG2J
         gbbvukwr9NaPq8IyV4ZxRUmtTXmjd2udHuLXtEm+aEtDEcRU5yWq8ewF7p8xkz7ATQh5
         B1NHJexahCDrK2ti2LHunyMx4MqxfY4/aa8p77ORlAvkUq+/ZBVI7SARstE7UtUVrWr4
         Yc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2wo38VUMq8RJPX4loTwuv8tamx+c/abRTZhdCWpf6Me0ZNDXZmopAx+Yp2CiVTXcIb4ZcRyJf7cMcGzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDT20j372QJQPJn6dtzeFV7netewea0f+jNH9D/p3AEZd32vF
	LJVYZgyhOi7wtHCpbG1KfR/PpucXFYduMftsdnCRbX3hLeC8oiLic2UW
X-Gm-Gg: ASbGncuHr1A1cqIjj/EhCzuMjhTqfYZbkm5/M+H/tz1m+F1lQWt+tEAzEsLg1P0NqZ0
	utZ8VGXmmhlEsY3NFcwxNj3tQfNSBrYdyX1NRvDrPdRoTFIeDe46l9Nn3o5lSX65r6QrtTjEMEi
	+wZ84NQ08Lw2jy7dPAOqzGoSX/dOE08B47hUliLo1BQC9Bl/RHxaXMXGlDP0W+EnceV6cbDXFlN
	Z24RyCgcwix/wm6lYVpvLB/ZfaE9h1OKX23GHDjIlwUJRORGLQxhdofLGiyYz6l8cnZ6QbyX5Es
	BXRPJiYdV2HXJa9HmW4hwYT5tpwbJuHHHY91F0fimgE2ftzQIHG+48GJXV1XAG8KRnKwD6RSId8
	8EYDHzLGnufw12/8Wo6n4Cs91waA00Qtq/MAevkh5tU8mwfwJ/uOMJOS7fhBq0Xt1xYBkhjt+8B
	wFzGPsgj0r
X-Google-Smtp-Source: AGHT+IEAK6eZag+MykEYgdavvPIK4g5Vlvg7NxyVKqzEv2FUkmjPRZH82E6BoaQ/fCmgKrW+V4J2Xg==
X-Received: by 2002:a17:90b:2690:b0:32e:d16c:a8c6 with SMTP id 98e67ed59e1d1-33bcf87d120mr44521355a91.16.1761393927422;
        Sat, 25 Oct 2025 05:05:27 -0700 (PDT)
Received: from [10.248.7.103] ([2409:40f4:2141:a037:1f2b:7d61:3375:68bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81ca93sm2150038a91.19.2025.10.25.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:05:27 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
Date: Sat, 25 Oct 2025 17:35:18 +0530
Subject: [PATCH] net: tcp_lp: fix kernel-doc warnings and update outdated
 reference links
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-net_ipv4_tcp_lp_c-v1-1-058cc221499e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP28/GgC/x2MQQqAIBAAvxJ7TkhRir4SIaZrLYSJRgTi35MOc
 5jDTIGMiTDD3BVI+FCmKzThfQf2MGFHRq45iEEo3mABb03xkfq2UZ9RW8b9uEnj5GAnBa2LCT2
 9/3NZa/0A7hvaPWMAAAA=
X-Change-ID: 20251025-net_ipv4_tcp_lp_c-1f7b4ad40c85
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, hswong3i@gmail.com, hlhung3i@gmail.com
Cc: khalid@kernel.org, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rakuram Eswaran <rakuram.e96@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761393921; l=2374;
 i=rakuram.e96@gmail.com; s=20251022; h=from:subject:message-id;
 bh=69y9OitDsvZG+ygITGh4xZyW20ZYYBCYMz7R434uZKM=;
 b=vWllaOOPUAH011DH/rlqhrvEcN8BOlGs5axrtJOP4Np2NxeVKvLN5ZCf0g8ypP6Mbq4t5lARr
 82IzpOkh3KjB8IKHqMHiKEAiY4dUTZicm9Bh/powGQO3u0qVtENBo7A
X-Developer-Key: i=rakuram.e96@gmail.com; a=ed25519;
 pk=swrXGNLB3jH+d6pqdVOCwq0slsYH5rn9IkMak1fIfgA=

Fix kernel-doc warnings in tcp_lp.c by adding missing parameter
descriptions for tcp_lp_cong_avoid() and tcp_lp_pkts_acked() when
building with W=1.

Also replace invalid URLs in the file header comment with the currently
valid links to the TCP-LP paper and implementation page.

No functional changes.

Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
Below W=1 build warnings:
net/ipv4/tcp_lp.c:121 function parameter 'ack' not described in 'tcp_lp_cong_avoid'
net/ipv4/tcp_lp.c:121 function parameter 'acked' not described in 'tcp_lp_cong_avoid'
net/ipv4/tcp_lp.c:271 function parameter 'sample' not described in 'tcp_lp_pkts_acked'

The new URLs were verified through archive.org to confirm they match
the content of the original references.
---
 net/ipv4/tcp_lp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_lp.c b/net/ipv4/tcp_lp.c
index 52fe17167460fc433ec84434795f7cbef8144767..976b56644a8a746946e5028dcb054e4c3e249680 100644
--- a/net/ipv4/tcp_lp.c
+++ b/net/ipv4/tcp_lp.c
@@ -23,9 +23,9 @@
  * Original Author:
  *   Aleksandar Kuzmanovic <akuzma@northwestern.edu>
  * Available from:
- *   http://www.ece.rice.edu/~akuzma/Doc/akuzma/TCP-LP.pdf
+ *   https://users.cs.northwestern.edu/~akuzma/doc/TCP-LP-ToN.pdf
  * Original implementation for 2.4.19:
- *   http://www-ece.rice.edu/networks/TCP-LP/
+ *   https://users.cs.northwestern.edu/~akuzma/rice/TCP-LP/linux/tcp-lp-linux.htm
  *
  * 2.6.x module Authors:
  *   Wong Hoi Sing, Edison <hswong3i@gmail.com>
@@ -113,6 +113,8 @@ static void tcp_lp_init(struct sock *sk)
 /**
  * tcp_lp_cong_avoid
  * @sk: socket to avoid congesting
+ * @ack: current ack sequence number
+ * @acked: number of ACKed packets
  *
  * Implementation of cong_avoid.
  * Will only call newReno CA when away from inference.
@@ -261,6 +263,7 @@ static void tcp_lp_rtt_sample(struct sock *sk, u32 rtt)
 /**
  * tcp_lp_pkts_acked
  * @sk: socket requiring congestion avoidance calculations
+ * @sample: ACK sample containing timing and rate information
  *
  * Implementation of pkts_acked.
  * Deal with active drop under Early Congestion Indication.

---
base-commit: 566771afc7a81e343da9939f0bd848d3622e2501
change-id: 20251025-net_ipv4_tcp_lp_c-1f7b4ad40c85

Best regards,
-- 
Rakuram Eswaran <rakuram.e96@gmail.com>


