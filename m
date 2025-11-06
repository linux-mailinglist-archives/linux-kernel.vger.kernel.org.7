Return-Path: <linux-kernel+bounces-889303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39777C3D3B0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3424F4E3D38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0D350A22;
	Thu,  6 Nov 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgxXgBir"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C834F24B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457087; cv=none; b=aD8Q/b3sGH/kTb+SPVuqbOZ7IrMnPwXPu2NczpZi80Dokj9ZE+G5PR2B+mA39S1WsdviVM4DBnr0n6NNnjderClHJ6JG4zNSeBaR+3UG69yBqiV36Z1JgLs95W2klyoqfaMu7ku+HeXCLsdTxpxTczPjz5syTK6OfauUPKk0KNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457087; c=relaxed/simple;
	bh=/8MHMjcZp40iywj2Jp6hNEOKJbwhIS2p+TLY8e5rxj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UKEQ6+QxWhBwOhLgCDeTr0HktB8zZ9Ku5+I5WsqKfEltpEgnI+rIVPHr/DUIKR00A+OwWZwguRYJEEciRKIXLXCLHRsFmqOrQkGSjcf4i59ZrwcT15JGp6E7lEsN0MP0hVBPzQ/xAZY/xJQA2Jx2aXBvSqoED7Ih2+jd3rWlcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgxXgBir; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso14435a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457085; x=1763061885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoGoAZXF1V/p8pqpha3Z5ljPEXFoXPfWyQqzTK9/QeA=;
        b=PgxXgBirrF7GezxGhtB22HTfIMdaGY1ZX0GXDjWCbUhrxYSK987UkUE19VxNPeKpTC
         pMqXt7E58o6fb0HtPiMRqey5FikNwf1w2tHa/XQMQezyxrtIISBesql9O84vAbF7y072
         g4nbgHDzuw7njFrQK3pd5A+vbFbq2+IzwCzs3kb8l6FQq2Q5RtS1TbNxMi1svV3HHjw3
         UoQiDTNB+efGMgKmp36sLUFz8/gp9pWWRaqTJvHTCA53XlEplj/raPXQqGvPHCdsXmWs
         pZqRwEsq7580XjBgV5MsUYsPlu2UkJZcl5r2XA+pfUBAolGWNlJtsO+dP5umDfA+vMxL
         R8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457085; x=1763061885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoGoAZXF1V/p8pqpha3Z5ljPEXFoXPfWyQqzTK9/QeA=;
        b=QWG3BvD5VRV7lWY+ygb6VECcLKfnosim1cXTidCp1UARczfwjESzWPEK7c9hq36sTs
         CjuEBSJuSiU0GeLNLX7N7ZwukDVCi/4m4DF3yEXkfR0xRzEKI7revuUenq6tMbI+/H2S
         PqTQKV2g0+Eqm8vKagOc5JdK+TxMiyUN4jnk1YkkPSr5qwGEW7vFRhHBJfcAZ8tEpe+L
         Jvp8F2SxjiCzSD+sCrpZZgsHEYO6+ho1y8NtDCOUpn2XaJq24wMFr6p0MlcXvoBJxLk1
         EKulG9XguXajM0HgCpCPu87IY6w6ToBB7vrKRhXFWS0NIff2KMWG0hhJURn1z6iJjvRE
         L3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdIjX229blYRtdfQ5IQq5bYT3nL54ZvAQx7yLd8cXVaCdDiyht8BvqVZm+hbLOD/uu0iDCgrLiSSYtotk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxshGFXUHv6bjeO3IJqu+/qbCuZaVU2isRsBirZavQAD/YgpHQ+
	iedvP0OHeJQrsuaAE5V5/US3AJRtTtbytlQ4YbvLBRyeaNbQTebdmBTC
X-Gm-Gg: ASbGncupdaAwwCNnTSSVrdc4oIw1n17zs+VfPCQMzdSck4+ZbcpzurLc5Oma4azStHb
	OWaf3w6rF+bh4EcKNpaQpk9cuI9u7Xqxw8tE98qng0HVPLaQ4G5b4J6bbOxIVUfHQrTxmOgA/6f
	V+GkJUEazacW6C9tTcxXdUAtRrMPUAEjcAxurFC+EJUcwuHaXR5TWJxfl92PKQ+tFVxUe2RujKR
	a5IJx4mIUCGvK9xsxrq/CL6Tqq2JehAEp1hnnv3/03wPls4eMHLeG/xjQ1eJu6ar34kFOzN+je+
	j1eEy5rNE/LwHhl7hpF9GvYuqgFqEtjI9vgqoC4o/5H+36//OeXg0nWlFLsKbeq1DlHupdKuh7P
	piTVkem/8z3PL4tWS4MOhlayV1MuMvIEd+PiAb8sgUZ09SaAFHgApsmu/vhP2cEGxnGrR0wiYcG
	Cvbu/QwQ9XESvar5RETIWo5p5CMWpI
X-Google-Smtp-Source: AGHT+IFsBPELqydba4uzpPfghv8+a5FHZ9eD5U/piy8KqflKlUwj0WVnszq4GjuKBbV4n8iz1qp8hA==
X-Received: by 2002:a17:90b:1c07:b0:330:7a32:3290 with SMTP id 98e67ed59e1d1-3434c5927femr318493a91.37.1762457085265;
        Thu, 06 Nov 2025 11:24:45 -0800 (PST)
Received: from localhost.localdomain ([111.125.210.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68aa1edsm6945964a91.1.2025.11.06.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:24:44 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	alexanderduyck@fb.com,
	chuck.lever@oracle.com,
	linyunsheng@huawei.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+4b8a1e4690e64b018227@syzkaller.appspotmail.com
Subject: [PATCH] net: core: Initialize new header to zero in pskb_expand_head
Date: Fri,  7 Nov 2025 00:54:23 +0530
Message-Id: <20251106192423.412977-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reports uninitialized value in can_receive(). The crash trace shows
the uninitialized value was created in pskb_expand_head(). This function
expands header of a socket buffer using kmalloc_reserve() which doesn't
zero-initialize the memory. When old packet data is copied to the new
buffer at an offset of data+nhead, new header area (first nhead bytes of
the new buffer) are left uninitialized. This is fixed by using memset()
to zero-initialize this header of the new buffer.

Reported-by: syzbot+4b8a1e4690e64b018227@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4b8a1e4690e64b018227
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 net/core/skbuff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..3486271260ac 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2282,6 +2282,8 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	 */
 	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
 
+	memset(data, 0, size);
+
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb),
 	       offsetof(struct skb_shared_info, frags[skb_shinfo(skb)->nr_frags]));
-- 
2.34.1


