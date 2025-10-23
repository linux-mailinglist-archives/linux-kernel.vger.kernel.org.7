Return-Path: <linux-kernel+bounces-867781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A42C037AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DE23A2B41
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650042D5938;
	Thu, 23 Oct 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3FdWqpU"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1A2C21D4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253237; cv=none; b=YNCGuJnUnH+3hKvkdtuCaU6O5H1LhUQtqoimIrCxlRh74EqP9r67jBKZkvn4kj7G8f0iiCXWa5wK+nTeecNVtx/4NRlaGaEsHnXfuf9XkEsI+aDJiotgBgGp7UfmiWdG/Bepqiw8+SqIejGbCwMMr9L2s4nXlycR6GxobIUIJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253237; c=relaxed/simple;
	bh=1YaM8Gl2RC8oqmYjWIDWFTPbTKaqfIddmif0TMp102s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g001mfqZwhYomU8FMvLnucA1MJMG8zizJfgeg7UMNEm0XwPeizkkWTTBUysIrlzYNbp8SFc+yWUqmIcSxWGFfH1bbC6K1xt6B1Ratity7Ynn7HysiclAKzIFa1uLO7mN5RR6U5fc7Q8qWQFag8JHR9TRPm40unYjm0Oqrrt++2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3FdWqpU; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-783fa3aa122so17446677b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253235; x=1761858035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwlreoE9kQbwjOXFtM8S3Npqc7qKt2aCVWyGonuNkt8=;
        b=I3FdWqpUj7+feu6qm2JSxV5+sjT0xb+6YO32dVbt5i36hBclfQ2hjD7QnDsSv3Jx6y
         KTeucP7EB3TRMf3/NVQfvv883opG2fdq08oQ0W7WZlKnTk1eLGvppC7Pud1iwqhjTgbD
         ofyQei7h7CJwyRycQyQwxbDqvN+ZoVHTXQ5NBnUymoiRMZ1X4WHPdbwW//wm1kTU+3FL
         gfQURzmDGlAce3nT4fSqcnkct3fDQ82ho+HT/f1od2Wf8nNcw/MBG8xt2E3Jtyiclg2a
         K+d0WU0iNvcizVskMfRlU35jHaXJeHYRXo4vBzmkShTTDQBoivr94SAsqvqzKekWXxqj
         gBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253235; x=1761858035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwlreoE9kQbwjOXFtM8S3Npqc7qKt2aCVWyGonuNkt8=;
        b=AX5etn1K5nsrTrputeosfCANCykH/hNXNmfkwMYnqUnxEVal2sSQFYHr+Eot6wsx4v
         j7+0IHK+7i3L182F5t/22N+dluEE+rSfKBdKSq7MyHE6n2OTqHUoO0aIv+mTqkt+9Y2n
         fgBaX/F3VhSIBGBzGEVj8cSwRTV0qpqOMXzhQj7LGPxb0tNKk3Odh1tQFyytXUrbUqgH
         SLVXvimlLr3q9xvf2TddMlHeKH12D8lQJ12XPXJAVhzJQvrgJlXc6jn/Xy0ajLtnQQJZ
         k+0YQljoZ0Xz9Q9Jlux/q0mi1nul2auIsWg4/9KBkMy+OrkWft/efv2RT1dNVsUxkutP
         69Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVXla327BCuhAliNn2NxUlLokzJIdf1S0GDLBirRcbZHMkuU7nZhRbT7gbpt1cJpbcURSur2IryCxEdKvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mvigeT5AO4ln/F7Lse5WlyXFPQHNHAN5g4DqLxKz9ii+CmyC
	QagzPVuy8uhzOqLoBnmL1FeeZQRondTvsMKEFI6nJQ9bmYTFHNdR1nTy
X-Gm-Gg: ASbGncukqWS0ugKDksdThqKFNqTUq8J1yYXkgoHZWXb2hIBbtiR06C66QDFRuRh08a7
	YtHZUC0KGsooyb/0kL3AUOon/BgUipOoU0qhQQk214QAWgb+OLL6pga0M1X3iHFXA6J+wZfIOhR
	bKartS1uz5ZebewJCwv1row3iNAU5H5fGMm6WaGeZNMwSgS4QSSf1O2eYWWZQxugl+WKFDSSzeZ
	3boJVAd7EYw2O6NytGc3bG1gwMWD5WDG7WYNaRmRezXaBE6s5Rhc04kwydX1d4BtTI1JPPlG/zx
	q/MYJ9KGmq6hHJMcqdztgLk7jLCFo89tPOre6z1hwA82fQw4IZlPGmC6N5f4PTym3lADl3IYDPk
	sC51XXdpmL1tI1MUjLiV+CqLyhbTs1+CenP6Jlw5TL1hMgNJX1aCFdaugFr+BPvjf5wCTzVGWoJ
	6xMkrCAH6Y+tc=
X-Google-Smtp-Source: AGHT+IEBIum988zCRistEInnTerl8FyEqMWMxIcD25ZwST/CVAmNRsjUTKijGwb/OAf3K2YfFky7uw==
X-Received: by 2002:a05:690e:150a:b0:63e:3bd4:9db4 with SMTP id 956f58d0204a3-63f42a57a2dmr264565d50.0.1761253234759;
        Thu, 23 Oct 2025 14:00:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f378ef9d1sm967513d50.9.2025.10.23.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:00:34 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 13:58:23 -0700
Subject: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem
 autorelease
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a new per-namespace sysctl to control the autorelease
behavior of devmem dmabuf bindings. The sysctl is found at:
/proc/sys/net/core/devmem_autorelease

When a binding is created, it inherits the autorelease setting from the
network namespace of the device to which it's being bound.

If autorelease is enabled (1):
- Tokens are stored in socket's xarray
- Tokens are automatically released when socket is closed

If autorelease is disabled (0):
- Tokens are tracked via uref counter in each net_iov
- User must manually release tokens via SO_DEVMEM_DONTNEED
- Lingering tokens are released when dmabuf is unbound
- This is the new default behavior for better performance

This allows application developers to choose between automatic cleanup
(easier, backwards compatible) and manual control (more explicit token
management, but more performant).

Changes the default to autorelease=0, so that users gain the performance
benefit by default.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/netns/core.h   | 1 +
 net/core/devmem.c          | 2 +-
 net/core/net_namespace.c   | 1 +
 net/core/sysctl_net_core.c | 9 +++++++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9ef3d70e5e9c..7af5ab0d757b 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -18,6 +18,7 @@ struct netns_core {
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
 	u8	sysctl_bypass_prot_mem;
+	u8	sysctl_devmem_autorelease;
 
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 8f3199fe0f7b..9cd6d93676f9 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		goto err_free_chunks;
 
 	list_add(&binding->list, &priv->bindings);
-	binding->autorelease = true;
+	binding->autorelease = dev_net(dev)->core.sysctl_devmem_autorelease;
 
 	return binding;
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index adcfef55a66f..890826b113d6 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -396,6 +396,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 	net->core.sysctl_tstamp_allow_data = 1;
 	net->core.sysctl_txq_reselection = msecs_to_jiffies(1000);
+	net->core.sysctl_devmem_autorelease = 0;
 }
 
 /* init code that must occur even if setup_net() is not called. */
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8d4decb2606f..375ec395227e 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -692,6 +692,15 @@ static struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+	{
+		.procname	= "devmem_autorelease",
+		.data		= &init_net.core.sysctl_devmem_autorelease,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */

-- 
2.47.3


