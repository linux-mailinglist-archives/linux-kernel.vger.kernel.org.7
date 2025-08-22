Return-Path: <linux-kernel+bounces-782055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8665FB31A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B46685120
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8976730507B;
	Fri, 22 Aug 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TISb21+n"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC705257820
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870914; cv=none; b=AY/JK/l58n3fOm1RKGhOWvbzp1Hf0lgSUDNCoSDzU5bqTL2LuKUVA5ARelH6yMeN/VWo+nKbfHKTl/vnyFee/VJeVbR9QkvpoBzOK1QS9NWEqgqBgP+ZdaYyKT427TOD8HuSwp9+rWAj4+Nv3dtuvlTjFMQddXNxOB86vA6kqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870914; c=relaxed/simple;
	bh=omUgS8Yqp2omTlRPv7EC7YyaMeOkk1VdjJAoSlVZVog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9EfKp9MVZuI8VmL2lqxtePyghSpN/8iTHNKnYIF7vy/5Boop2RHH2oaBiNB76Nl/M6WzSdqoAx76YPFLZCN58UAg0F1yiHDuin1FIULzzkhraT0tFG+kOWtS8euOCFzrhYa9nUPI+zj/KEQ/eUCLCmGUmmYVJ1g6hQfW3sKzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TISb21+n; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb72d5409so324952766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870911; x=1756475711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+i/BZ4RMqL70daqwvgERJaIFeycaTJmwAWOLgqc2v9g=;
        b=TISb21+nuFrvCEzeJ0gT9OZNKFhekCtZ/4wGQlP2qltWWuJwKMELvCD5zphq9VftWN
         95ebZBRu/8DIZ14oVLCZLvLKtXXIEk+s9S40oK5S23+4x+0zJb9XUnDSTnpbywHu9DSf
         Mt0u30EgmkHqJb1mwNBdZ/xQ8us3AwlqgmqYy/OxBflq2tqTAF/RqC5RTog+nQQ1jufP
         fIkdUXeR/ZJG/M0KyQuX77BbdpE5BJWwHJJgXmkGP5FabDLo8g8RWUPcVTWLOVDdTRvc
         CDqFzJUdXyVpPvIzvOkjzhY2nXOfbf/OcFuz0yGFZNEMlr7HrmgNlkt7j/xyKSJF8Poe
         KRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870911; x=1756475711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+i/BZ4RMqL70daqwvgERJaIFeycaTJmwAWOLgqc2v9g=;
        b=tBgi1pZMUVwSqNe7vNQRyp+7ToYgqOeLA8nZF7gWmHDMipWWCyXfsRcXdf44oa0bQD
         XrCv3x3vbRvHrCMcCKpZU4pQN76TjJF1yH6E7Dx6/VWNG0GwLr21ip1TbXi/7vY7uLl0
         sjwGsjAkpU7IcVXUc8pWc6q5TIj0fb+OFMubp248SonAjubWgfFvNGRy9sxyDDJtqa2G
         trESFhcz7YyjkvmXGHAZqkGevDu+9cLrrhuHAL8HihL3lPnPFsYLXgCqV/fIDvx2Hh2H
         TNOvyQV+ASd4IysbQo1KLdOvu+RdmxceZFjwWCtZfFszPKXT+qDiOWVljYDzGZOMrrQ6
         N+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8YfjBAI+iy/zhXvfAkKKWdFcYuExKphrbGdcOir2fZaQDg11L2y2x/XAzbRezO/GQqjQFCxfXZScoQd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFn18vSSwXZR6YXcDAAyu3SqvP4NefoZipWyOSuaOL5qPGzBT
	KE+RLsxu9PW319w8DCcl4bUIP72XBmtYpd33F8btAJIUgLzf/e5GbLfZ
X-Gm-Gg: ASbGnctSVJV2von0BYjjo9u2NKkV/3SKAeJbJ55VeljbdBkUEIXzJN6jZ3lptNN/C+6
	ehY5PN+M2vh46dW0Fsl2UmC2uOk67ajHMYQz2VEnuTJjLMZUCcDvyaqeAploLkPeaw+JNHi5/am
	TWpQvLrOAIYssQEiFBWoCvo4bGErHS7vm5ACMXdCYlASFiDWy9KgOv85G1jmN9YSomL2iEsHtLm
	wW2J9IsrXT6H8IjhVeVFDcQ6WAe62y8Nb1C6PfEfD3iX87SirU/rjA06fKJSPFGJcNiCtP9Fj9r
	uyKbkLjJZN08kDG7pc1uf+98YBLr9+MSJOVYnMnGt4ARQ50clq2gdhkhhJQ0cGDRr7Ywv3+XS8z
	Uzo3ZbfCPs5fVmyzapdAfKbBrXg==
X-Google-Smtp-Source: AGHT+IHjV2lpd+GIDQ3QFTXMtmjzan9Cn3jVvnnDSQyLnJNTiIo6GZsubevyigZZwWvQdae/6KDBRw==
X-Received: by 2002:a17:907:94c6:b0:af9:8438:de22 with SMTP id a640c23a62f3a-afe2958a13amr298510766b.39.1755870910955;
        Fri, 22 Aug 2025 06:55:10 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:10 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/13] staging: rtl8723bs: remove wrapper rtw_init_recv_timer
Date: Fri, 22 Aug 2025 15:54:06 +0200
Message-ID: <20250822135418.118115-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822135418.118115-1-straube.linux@gmail.com>
References: <20250822135418.118115-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rtw_init_recv_timer in os_dep/recv_linux.c is jsut a wrapper
around timer_setup. Use timer_setup directly and remove the wrapper to
reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c   | 4 +++-
 drivers/staging/rtl8723bs/include/recv_osdep.h | 3 ---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 7 -------
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 4d51e6993ca2..d1f6030799cb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -247,7 +247,9 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 			INIT_LIST_HEAD(&preorder_ctrl->pending_recvframe_queue.queue);
 			spin_lock_init(&preorder_ctrl->pending_recvframe_queue.lock);
 
-			rtw_init_recv_timer(preorder_ctrl);
+			/* init recv timer */
+			timer_setup(&preorder_ctrl->reordering_ctrl_timer,
+				    rtw_reordering_ctrl_timeout_handler, 0);
 		}
 
 		/* init for DM */
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 83330ea98fbf..ea0b58aa0ba0 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -34,7 +34,4 @@ void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *pre
 struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata);
 void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib);
 
-void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl);
-
-
 #endif /*  */
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 98d3e4777210..a507a29686bd 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -216,10 +216,3 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	return _FAIL;
 }
-
-void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl)
-{
-	timer_setup(&preorder_ctrl->reordering_ctrl_timer,
-		    rtw_reordering_ctrl_timeout_handler, 0);
-
-}
-- 
2.51.0


