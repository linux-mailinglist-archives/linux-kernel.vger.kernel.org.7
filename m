Return-Path: <linux-kernel+bounces-826417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A88BB8E7C9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786DA7A8E49
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20CD24A058;
	Sun, 21 Sep 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GruyAGKO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F812D7804
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491786; cv=none; b=EYQzDFnd8QzeoAM9JH6UVjLEtcSmYKUo2IDuHWK4MlKRzuLuhmAXZxZfLlGnj5ejhVWbWIbytFIJoVu8/wgBHqh+0YbnzcoYhe+8Kp2Omgggw9plJcp3BP25oHENwafEoT8laxxrl13y5AdeqTZLtxwXkYnWDdDQr7odQYDpSa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491786; c=relaxed/simple;
	bh=yUxPsW1neulTDSc12DrjlnnLI2RxeIiDkeTBPbs2djs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1z84+6pHKVVBSeo58oEdq5pY1YC/a0oJDlsAj0mZ/pLJ0PEV6PSuHa077gNLEZ5g6xyFjFlp5cPAzwt7Q74IAFRpKUzGpluVJUbbndzQL2GfEpahDmR+iyEg7FpCKjRaIAlQrIjlQa1JkcMIezAhM5GGGTzH7HhtIssNjDAzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GruyAGKO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1764486f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491782; x=1759096582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOfYi+evOXJssk3GreSh96Tr6S4alFUvF1o54q0ZtXY=;
        b=GruyAGKOwZLIpP4Lc160v/7prT9B6kNgcOT4tIIhXx6TFVygu2OwKIu3ZUexPLXQE2
         wnBrv2LSC7d56narxHMSRFXDQbiXNJhuFQRPSIYdhuE649cwYnE3WWiBqC9jeu5fCi5v
         9LAdWS3kwIwpesjX98q4k7XLMfltwC/NFa1qhl17L7aw2mLiA8p4Qo3gbs4O2RTd34Uw
         7H6KmJJey2+WbzA3kcY5IslW6vVEs2wE3k8qQkdUm74zb+TP9z7k1lF5q7iam8yC7Dnb
         Clwln0EVjJMrEwfXYBANadSP7vadMOccdVYSJpbuMVBcBQ344jqdo8QKapUBYjEZu0Kp
         qEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491782; x=1759096582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOfYi+evOXJssk3GreSh96Tr6S4alFUvF1o54q0ZtXY=;
        b=gjrg0kI9BSLmW7/29Zkz/q1SaaR5rgttodS4pI97p210efNa8ZqWuhIf/o4aP+uVMa
         ATDmJof1HoBCOLPnWF20YsNslI5c6jj2RU4f0bcLFI3QjYaD5Ul0TsBJOS36Kfn1gPFz
         djG2ikCso/S9Z4eSCvTygQJD1Zdm5bsWmn1hKmZHrPJA3InCiKqXgxIKlVmjyXZp4585
         6chlm23dCKeo7GYhs4J76BUqTHt0WNDaOVQIFHJJCBk0lv5PAhAUpvsKUbsFwnAyRgsl
         a7750g3T8KyrEHpRSD6lxKZwx9vB/CsBjAIeSwefimzoUpMqeYda5JMCAdKNvmfQd7V4
         uhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOaX0NTbjkKdvYvupMiztr2/MjquzU5iM/4j8xUcgGkM1gWjXlqdnJ8BB0lP7lYShOaJsmPHWfOZMgSyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dnOAkGhvaqFQg3O+4wi1hFAVrX7hhurum1Z1lJiCj2dFAYk+
	cdh6k3V/Of1emGLIsRKAfnJALvEsbK0RqdpYUscORgvCkfnwZ/O6jlLEULhPYW3J
X-Gm-Gg: ASbGncuGddCRFbw9wj0htaapiY68FuC69zmHgLsgXV2NZhZkJSMdZruaeFrkl1dyYju
	GQXJTeSy5CJdxYnyFWozRBy1bL+9fdVuFdbXF1gyT5WfF4RqN9Il8YGdIOtnLq+CJ0f/obq6Quy
	Kn279ClHcTvNZupRQryOmgZU2MwoL7PXMjmwTUUsaRmD3z8p4DC6VuddbVi/YufA3plZWPz3fb4
	UH5TKaK1PzcILamELYGuLHFaHMrgZ5gS7Kh+hA1A5zBoWuuUov+hyheU/ZX4AXrlAgDoJFSweQv
	ZHyD3F5Vo/l2i43vvB8N0PuqJEo4H4eh0n9rOEvjBGsZfmubi0PKiCWwLlCK2QUrUKcdUuFMrm0
	JBQ7m9G+GsDvd63mcYm2kfNYopSw=
X-Google-Smtp-Source: AGHT+IHkY8glqJbAdbx/HQxL8P57QDbgpjHvW7djVIuzTEhF8v7QKu+VXWTwdbbHVgsscAGah8UFmQ==
X-Received: by 2002:a05:6000:1acc:b0:3fa:2316:c21 with SMTP id ffacd0b85a97d-3fa2316187bmr2371046f8f.17.1758491782460;
        Sun, 21 Sep 2025 14:56:22 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:21 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:44 +0100
Subject: [PATCH net-next v2 4/6] netpoll: add wrapper around
 __netpoll_setup with dev reference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-4-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=2309;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=yUxPsW1neulTDSc12DrjlnnLI2RxeIiDkeTBPbs2djs=;
 b=d2nNT4dGAA6498qUFNrx4Kp0pt0EnCm5K+QmHqWERTvkBThp1hPs+jdrh+xminlvQ1/FIh9Nb
 JRvwqeiYmuhAx7pLVrhPxTRorXRAuN2SpVG5juSaJuNj+g9+5QnxmXi
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce __netpoll_setup_hold() which wraps __netpoll_setup() and
on success holds a reference to the device. This helper requires caller
to already hold RNTL and should be paired with netpoll_cleanup to ensure
proper handling of the reference.

This helper is going to be used by netconsole to setup netpoll in
response to a NETDEV_UP event. Since netconsole always perform cleanup
using netpoll_cleanup, this will ensure that reference counting is
correct and handled entirely inside netpoll.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f22eec4660405eaa654eb7746cbfdc89113fe312..345e741126748c0ee8d55dba594d782bced4eeed 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,6 +69,7 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
+int __netpoll_setup_hold(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c2491096f79ea6cf82eeef222c3eac2..bf563c4259f6cb19c31613ff277eb5a0e2165e43 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -608,6 +608,26 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
+/*
+ * Wrapper around __netpoll_setup that holds a reference to the device.
+ * The caller must pair this with netpoll_cleanup() to release the reference.
+ */
+int __netpoll_setup_hold(struct netpoll *np, struct net_device *ndev)
+{
+	int err;
+
+	ASSERT_RTNL();
+
+	err = __netpoll_setup(np, ndev);
+	if (err)
+		return err;
+
+	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__netpoll_setup_hold);
+
 /*
  * Returns a pointer to a string representation of the identifier used
  * to select the egress interface for the given netpoll instance. buf

-- 
2.51.0


