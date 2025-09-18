Return-Path: <linux-kernel+bounces-822745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AFDB84938
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B6C585EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0E303A01;
	Thu, 18 Sep 2025 12:26:09 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274012D94AF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198368; cv=none; b=FjcSOQMCG4Forw+goI92wgSIKx/O9e4ccYiWjJF8QObY4SwEJjSaoj7wIVXqvDjncQndMN3ItTGTCMV4uPczo0unatl7X3x5yZnf46H/1etKVXWLr+HpGZzF40/E4YyfwV20AXfTmFWF2f33r5SZZsv5MNj4S7BNyy4EsPQrHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198368; c=relaxed/simple;
	bh=VLreZAgyqdt4IbDGMWq+hXQwd3RALL3xojB4JGVGAs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKqZtt4uK2asMP/UfZV5diq1YLji4nTS9qJP8uweN/TKe0vWDSssCxUud/4HdUPV5Pw2OfqbD6lhs8uBvnAp3En/fyxEMfEvk9eKopRFQ1FTHoXVJlchtgeJR4NV/+TbMW+TCUM7T3+FMvfqp3TY69+3PoyBIDbYp7icm/poQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2350899a40so48737066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198365; x=1758803165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD1VaIvti5I+7WNRpeNj278YauNyi5qcRsCfkF8NXy0=;
        b=gTAW8MRdPBwIIeFdDmojWN+ERAAF8LcsFU3LOb+wLBdPdiP/oaVLEQ1bi0DXQ4UxDk
         ktH4gNDDCFMhb2h3WrBZ3SQ08w/9tSj04nROtYJNpVAuwZCrgzEm8aLkQys4r4sbNv08
         +5Y3Tk+4udKoNcbWBD9vr6H3K3wtOkZy9IW3j6jKwq3aXyhL6+3eITVAcTfqJwSVNJyQ
         A+uakubl1NVEGU/HLtVjJKiyuK/23AWKH7NjJhOYDtx/uVLBr4lRY/4lezG9hieq1HRU
         ww+bf9pO/WfvBA69mIY+c/WSyMiEDJNT9qjnTYOozRaX93T00kTB7jv33R/zWAAk9Qdf
         SYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwcdYuuT31qNnOQD2UJVBGVQduLjpEuSANXUN7bpkCIUEa9jzT4uVmQahhesmU1Io/4yZrS2EvaOph/oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRrScm3jabpuO2Kkf8hqBl7ipo8iet31vk20SPjYmDis20Xwf
	dZki5nHc34rgn2uEwmhRI/lBMJSalZdx9b5j+uQaNP4+2qi/JnCAjqsa
X-Gm-Gg: ASbGncvUtAZZ7CVhwBAxIP4xeaIAv7X7ahDIGR2t0g51bWl+KpRp/OpPMIOv2gkuAjU
	JO/G81yverj5N/1P/2AH/tixiZUTco9gS3A0z6iCGEBZASWz7v9VdLEWU1QC6SetSGhPfhas/Vo
	SxNLwzmQm/w3S9XcmqIvmHbsOtiJbWPd47HuwCFOgQVEK7VXb0UesdC6LcfR+hk7geTTuxE9VCo
	xr1taxmslk1mUzQSW+/vodmgiBhc2KLrKCNg3MogbcjnEPzeXvIxZT3M/gs5M93A4aPkF4A2+vn
	Gjcw50Rerqy09WYVSQURhILLGlMGeCvsKH7OpEvKgYs0j/cPcMVT+mmTAv1OVko7ZWso8dR/dhQ
	C7OE8rZX/bHiHMa17Ohq0udx0bC7qQCr+
X-Google-Smtp-Source: AGHT+IF9zGGM5Txf3w00xeQL7fGLKXH5vp/N0vU4vHKJkKL72AIxdJLQXn1U0lonSYohOi0T7w2fjQ==
X-Received: by 2002:a17:906:99c5:b0:b04:5e64:d7cd with SMTP id a640c23a62f3a-b1bbebb4f54mr644912266b.46.1758198365258;
        Thu, 18 Sep 2025 05:26:05 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd271eaf7sm178964166b.100.2025.09.18.05.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:26:04 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 05:25:57 -0700
Subject: [PATCH net-next 1/2] net: netpoll: remove unused netpoll pointer
 from netpoll_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netpoll_jv-v1-1-67d50eeb2c26@debian.org>
References: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
In-Reply-To: <20250918-netpoll_jv-v1-0-67d50eeb2c26@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, efault@gmx.de, jv@jvosburgh.net, 
 kernel-team@meta.com, calvin@wbinvd.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=leitao@debian.org;
 h=from:subject:message-id; bh=VLreZAgyqdt4IbDGMWq+hXQwd3RALL3xojB4JGVGAs4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy/paueKKm+EP1z+8W5G+3Mcn96G1lIfSZcB3o
 EZF+npCtiOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMv6WgAKCRA1o5Of/Hh3
 bR5tEAClbr3TKA4OeKmQktqQjjMU1FVn4CWfV1rLzztyu6Zpp4VaetdW9ON7AK65TqEYDoiKJhy
 7zqpPXgJ5/ItB7vlQ1Qw6LofkbsedUSufR5o4KQ1Nxj4jKB2UF3+HcXuaS6iLqFfLgo4izxWHir
 EyK0MEDDjSHudEdJwDTJb99SRHMvLkqNGdbUnijGIp6DLA2BOLUkrjFiQX8CK5B1+jl6n5UbvMD
 Vo57q5SqsPqT5wHmpmQl2vSWH9AHPQO2aLN0YEnO9gUgV0uFNnpUgRG+Wlj+7xHFlMTGR/IdBUj
 3plMrV2FyLOK2ToRWQvVsOtSyFWSI5ZZlwvYBBOAGOWftCPShFHFifEnO0MLZnxAEwbr3Cdj1ui
 2V35El+WpnTnID/xM8pL5TAfcwyswa3EwJizyv0mwfTJJRX7voKto5jBUIa6b+4Z8DBi48p3nMa
 hLX1tNZBvxMcnjn364FKU8Veg+u1QC/3GRX0n4IPu2TtD0GZqPZwi2xO+Iw9cJaqZkcmvLSMrDn
 yNqm712p2dOTFZtjbCMekTcaJTnPB36HFPPv2vbjWUU2IeEbIDnHf77JtSRt2l11nLEt0z1NiZW
 uLJ5cNBPq8d2u+MydrHcmsCpbM3F+Ds8wVpYGg1JHwoDUABOzTcnLdoAY/InPmXwFE6e6v5VsL4
 OFQXRU/VNqPuLaQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netpoll_info structure contains an useless pointer back to its
associated netpoll. This field is never used, and the assignment in
__netpoll_setup() is does not comtemplate multiple instances, as
reported by Jay[1].

Drop both the member and its initialization to simplify the structure.

Reported-by: Jay Vosburgh <jv@jvosburgh.net>
Closes: https://lore.kernel.org/all/2930648.1757463506@famine/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 1 -
 net/core/netpoll.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index b5ea9882eda8b..f22eec4660405 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -55,7 +55,6 @@ struct netpoll_info {
 
 	struct delayed_work tx_work;
 
-	struct netpoll *netpoll;
 	struct rcu_head rcu;
 };
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5f65b62346d4e..c58faa7471650 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -591,7 +591,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 	np->dev = ndev;
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
-	npinfo->netpoll = np;
 
 	/* fill up the skb queue */
 	refill_skbs(np);

-- 
2.47.3


