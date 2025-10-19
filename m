Return-Path: <linux-kernel+bounces-859575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F628BEDFE5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 649FA4E5EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010B22E3F0;
	Sun, 19 Oct 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBECEz4w"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615627483
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860568; cv=none; b=Jj3J3hu4m1LHZUtNRUR8fDkDlGaZOU2M/VxfYCxrKavcNrigrohZHf8PX9+nb43Dsnvu0u6rfhMiQ+h0skqe9ULwJtQUpcYpHHGU3ZVo1AiosolV25r6bVKZFoLQfTAniAGueweAK26EBNQvchLT7d0MQ2j3PVWYWOSdabk0DjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860568; c=relaxed/simple;
	bh=mVLXF4lEwtvDzcwn7LlkjBNH+v+CCXpaS5jhlxOHKcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJXiEO08rYaEA1o8GUvHOnJiEvOndLsf8BkhBsRP49RRLtuV3tFoq4xciLE0tzKTJB0XENWKOwyLksBHCqKSme63YK3gYxDz1OWGSiiP62XWn7KNFqAkTIoqP6YxwMdjy+fUfhPCBQpAdiL7X4ADvR420zPDadfrwYtetpuVYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBECEz4w; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b556284db11so2895356a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760860563; x=1761465363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3F6oM9Agr2FPxSXT/W3lN8s7vDqk89rfSGq18riZTFo=;
        b=eBECEz4w9T+cIjgDerVnQBr0k5C4LzWj99rHH8Z+hKBm5ABca75K4ZKBOKrAHpVn1L
         pom4hQ1+JfK8i/HNaEz6KwtKjVUj50BO+ljUVd1EtZO5aO9e7Zo8au1wnZgDnEkSA7yx
         c+xLE/9z43IJaebBweYQJMyw7H0i5iPEnFfOGFsS9QM6Mk0aBum5gnsN2eXxOmoy8nNu
         3OE+/rOEBu1vBg/cMJIGObNJ4fYcsW1Vh86S3e6kSLAxPeVk9dd5xzpl3lLnon3fScgg
         S2RsfYJVQCaBgblTMluiHld5jeCQhh4u5gk+ZEhXla8Oa75b+L5/ASLWlpOXSlAckkcf
         ps8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860563; x=1761465363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F6oM9Agr2FPxSXT/W3lN8s7vDqk89rfSGq18riZTFo=;
        b=cyO5XIelLZJcBCjkhSSn1KfYBXeNN8L9m5zt9D5X1MT2dPM+LSuM3MRSMOTOOBc80L
         EaP2Z0bchw+A5otfoEWovLkMMe6f0s4Pmz7+JOzDYyhrhY3z/JA/h4crD0OVktCaiADL
         z0NohsTdLuC37RcJTkEmLtRThMxzx9scMlpPPNcj4CenxYj7DAVWEfj9Y0xr6mktwtr8
         HdxOnFSW/X7xAdbQO+87iRKvTu41Zr5xhLfGPw3pFRnuQHNHDFpLtgd6DA5jrluS5blT
         46gvFo6N4JJlQmyij697AwYrkrUvvhz/oo1ydBCt4xZ0SjWoWdfq7LTStQAoknqLa8Gu
         iuBw==
X-Forwarded-Encrypted: i=1; AJvYcCVdhZ71mcpvWbGmSz/IcWAqxCUHIO6aGUfChGxlXKckqNHhNbmzMapwVjY1Wx9CgjHikhWolYpVvN/96Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsmM1vWJZ1ZrQs202exCIAxS1dnA9gkCVRnof0rCV2d5+GizH
	gG4FOjFx0UXQSzuEkhESxCGaDVwxa4CaA2PmIwdoCHIVFJfAQpBVPvBb
X-Gm-Gg: ASbGncuBukPpJtyYULLIfPv/Kf+OTaYOLcV4jA5/e7Uf8RWzQtCsNBg0QPRvkwBa6H4
	0bCqQu5rPsMezsxHw46DGY8zsP7Vx6Z5GAp/ALG2C7YlF4XM3y2fjLaDRcYrDVCOkUqFMjal7Hd
	B+7C70Qu9YGifOuI97p7d0/tQopPNY3+Gdjm6R2l+HIupIG0tjtgxSgcl8IgfosqTl1rnNJqiNt
	Q+u134/gbt3IiJI+NtlpaZXUQMuPK3cu7AMkORNR6dzSwTFDqbc5PYzpbNDGsh5Y/lGFAf/uKp0
	4uTsFghbtHO+pGmqXepR0PgupRa/Q/z+AitZzldWx6fhzLH/gJy1EN7v0f0RkUMW+3fzXjGtZFZ
	ZiTfBppNmQ+GscCQ3W4P/MNmaJS2u3XckghieAOUz7YbZkaovYqgVQuw6X5r7fuiY3U3OxN4iSq
	HekM35sqi+3GRPB7azJYe9Vcg=
X-Google-Smtp-Source: AGHT+IHp7GBC91IZMRt5+CX0l2Khc9Tjxa3JtCmaKfz/d0LS6e0hmTCYCeXlwhSz8nZBUUiCPbUPuw==
X-Received: by 2002:a17:902:ea04:b0:269:74bf:f19a with SMTP id d9443c01a7336-290c9c89fc5mr123658105ad.11.1760860563331;
        Sun, 19 Oct 2025 00:56:03 -0700 (PDT)
Received: from mythos-cloud ([125.138.202.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm46200955ad.52.2025.10.19.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 00:56:03 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: dlink: use dev_kfree_skb_any instead of dev_kfree_skb
Date: Sun, 19 Oct 2025 16:55:40 +0900
Message-ID: <20251019075540.55697-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
which can be called from netpoll (hard IRQ) and from other contexts.

Also, `np->link_status` can be changed at any time by interrupt handler.

  <idle>-0       [011] dNh4.  4541.754603: start_xmit <-netpoll_start_xmit
  <idle>-0       [011] dNh4.  4541.754622: <stack trace>
 => [FTRACE TRAMPOLINE]
 => start_xmit
 => netpoll_start_xmit
 => netpoll_send_skb
 => write_msg
 => console_flush_all
 => console_unlock
 => vprintk_emit
 => _printk
 => rio_interrupt
 => __handle_irq_event_percpu
 => handle_irq_event
 => handle_fasteoi_irq
 => __common_interrupt
 => common_interrupt
 => asm_common_interrupt
 => mwait_idle
 => default_idle_call
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => common_startup_64

This issue can occur when the link state changes from off to on
(e.g., plugging or unplugging the LAN cable) while transmitting a
packet. If the skb has a destructor, a warning message may be
printed in this situation.

-> consume_skb (dev_kfree_skb())
  -> __kfree_skb()
    -> skb_release_all()
      -> skb_release_head_state(skb)
	 if (skb->destructor) {
	         DEBUG_NET_WARN_ON_ONCE(in_hardirq());
		 skb->destructor(skb);
	 }

Found by inspection.

Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 7077d705e471..6e4f17142519 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -733,7 +733,7 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
 	u64 tfc_vlan_tag = 0;
 
 	if (np->link_status == 0) {	/* Link Down */
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 	entry = np->cur_tx % TX_RING_SIZE;
-- 
2.51.0


