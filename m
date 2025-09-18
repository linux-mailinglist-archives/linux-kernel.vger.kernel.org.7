Return-Path: <linux-kernel+bounces-822746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E19B8493E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05284585C77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C5304BCD;
	Thu, 18 Sep 2025 12:26:10 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AA3016FE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198370; cv=none; b=JYj+zCw4gavG7U6aaj7uggF7urKcv+IsnE4N/abFCo24YKksauRB3tSyPtACIUQlgK+RBY6DKNHcTbnTxYPAAAziQxrtrRuEOU8lsd6o79abkZYMoCp72xpLdbk36U/fng7SVhYTpnCbkcWdaPKrCCbeduZauu7ha16XyMczNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198370; c=relaxed/simple;
	bh=1ZyrXc5eguQ4nZOdpuBHcd9qz/QJUzyRk5wrrrTeEOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJGvxLocVHHyLd0Bh/c2fTtpDT/lNDgPKY5R7TAb+HQOMglyOhVnrHXwSgBzrQ0jf6EF+QYhFYlwm4WNYpmPkqh0a97k8o+PfX4FI7wnOzKinn2ZiiOlSUN7kZRivFg6z4yfzSeVmfUFgYdsP2VFP6/8EUSn1h6PN2LxGMt/i20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07c2908f3eso134678866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198367; x=1758803167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHgQrtaXA3CwQHoEgNdvwm+devLT6VoGzzYSteKI2z0=;
        b=gzXH+wTCt80qrOZ7CBjIKyKEuYLGNf938Vqdsiy+MCAfiAVKA/5L/ECbIdxyr4h+Xw
         Eog1sI4rtTTQee80l0x+16BfoEH5t1+Rk8uVP2NTSBzAnfR8fP1B0Sm0eFoX5NonUAbu
         /o3rk+ssq7SfBassVR794hBJL1KsG97KR+4+u7U4TDpHt/wfRupjnwZdlBf0sDKQ3FDV
         qCpRTaWOgop6ue+kv95jYVNHiGHNC8QTtuigsy3bSK4zhUAvUWye2dbWxg1sV8Un1+vM
         lGbLZXRvur9j5SaCLDXfUMEKRl3tU9HHflO6+Q3oMc1UifOfbT6P+0aoQQ/33efwGwa2
         UhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEm6VvNzGSEjj+Onhap+7gSvTyzFF0stpzQ6KC9vtV03T3yZj7o4VNDazx+1Znf0rbIqNJ9HmthJgsUZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRCeSMhFL3qmhqR7fFclx22tH2FD0A+Js7pbRUgDMxPdeItnT
	v88lSQh3pWlVH6JyjTxoAizufZAL3bl36e7R20pIeXYYnEitLcyii7vI
X-Gm-Gg: ASbGncsNXkwMHBg6IuTLAQdrhco+HPpZEYAs8Kux5E3LZuXBJUYCPgSm7ee54P9f8+r
	hhBQBYsYtlwGrDQnK8EXAX+afDEiUIXDfMc7CBCcqss2HGYV/PJOuIJ++bUEfxZOlObDywVrPCQ
	jGq2CmBsJapS5PrkVvnk7jWOp+VIUCtJqGDAof30GZbZZWnsU0Q8aY6Cm4xiTF7cFs11k9PD631
	RPemlpgxO6plP/HRotgDaDsUo2uA/rWi+10RFgRZh5/RM2IBkgzGmJF22A4aiFrelY7l5F6GUu3
	QZslJ0Ii7J+Z9J0oIOSjOALvhWJnx7JEv6HIbjHKq4ZUyniUR5OX6oJG2yDmTJ9+Oejksjw6cWI
	fZ9iPgHI1rFTon0NY8P3UpD7Orxx/eO6S
X-Google-Smtp-Source: AGHT+IHQbn9/m3ccJDFvWSaJoDeaFgApVbuYmutNfQ/dxYqND/Giu0MzmqpZxURl3wjAOffAbFRuJQ==
X-Received: by 2002:a17:907:3e1f:b0:b04:2b28:223d with SMTP id a640c23a62f3a-b1bb6048f2cmr589960866b.20.1758198366662;
        Thu, 18 Sep 2025 05:26:06 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc73bb6e0sm185376966b.32.2025.09.18.05.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:26:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 05:25:58 -0700
Subject: [PATCH net-next 2/2] net: netpoll: use synchronize_net() instead
 of synchronize_rcu()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netpoll_jv-v1-2-67d50eeb2c26@debian.org>
References: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
In-Reply-To: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, efault@gmx.de, jv@jvosburgh.net, 
 kernel-team@meta.com, calvin@wbinvd.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=leitao@debian.org;
 h=from:subject:message-id; bh=1ZyrXc5eguQ4nZOdpuBHcd9qz/QJUzyRk5wrrrTeEOQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy/paWSB6Fsp2/fITxY8soCELwCOwl8v0wjEV0
 H4HXZ1ZML6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMv6WgAKCRA1o5Of/Hh3
 bRh4D/9ado3wKgqC7kSdWCw/7N8jroWV1gnq7FDqlPy0XR/oGiEtEqrOlccvW8piHS7D4WfPEIr
 eOHdVZ3xaA8UUpvL3rJQvUxGMxmK5pv7eRTMbwpiV3qhszg9DczV33sRHgcza3HobBlgxNPYHQJ
 3R3ODo+f+AlixpSjKfO06p7NFtB7JLn98x5xVaas0l12U7mmpLuGIyqPtwOturZPeoHBshuMAce
 C7ahevhH7qsIAlXci44biqJJyjlbKLnQqT3thPhex3KszG6wNu9zuEwV6wBxGfMoPg4ETrS0Olv
 YsJi8vMGWCu90y5mShzrtOGSgVAmGWKDjMyY9uSnunisWOnLz1vXjw131vExdKTlXqnjyXAupFI
 hiqr5CrD2Dk4BD3RQyt+UMDSHzTyz5krtjBefnGpn8G+sAtB6Ow8551NfZ7sYwtVEB79VkbUlq/
 d8N9OJt71qmZH+NnR9v/CA8cxK8I5OLq70ox17PYH5Rz33w7M4z6fk77UVc4q9+8wjz6ToOhNZ4
 dM5anWbhf/5DoLWPZx6n+tyRyzeK4REvtCNKs4J/zNyouLdh+G5oZuYBqNrWqS+DIIP0fdxgRf6
 yXNHkfzEmgEP5/RYVAWh4SBfQdKQqKuVriLa9f7TPnljwwb5RVIyIBP7B4fvqterSlYGeShijTg
 3d0BPAtG2dm3N7A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace synchronize_rcu() with synchronize_net() in __netpoll_free().

synchronize_net() is RTNL-aware and will use the more efficient
synchronize_rcu_expedited() when called under RTNL lock, avoiding
the potentially expensive synchronize_rcu() in RTNL critical sections.

Since __netpoll_free() is called with RTNL held (as indicated by
ASSERT_RTNL()), this change improves performance by reducing the
time spent in the RTNL critical section.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c58faa7471650..60a05d3b7c249 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -834,7 +834,7 @@ void __netpoll_free(struct netpoll *np)
 	ASSERT_RTNL();
 
 	/* Wait for transmitting packets to finish before freeing. */
-	synchronize_rcu();
+	synchronize_net();
 	__netpoll_cleanup(np);
 	kfree(np);
 }

-- 
2.47.3


