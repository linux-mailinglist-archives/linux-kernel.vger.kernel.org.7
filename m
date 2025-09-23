Return-Path: <linux-kernel+bounces-829607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F3B97706
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A06716BD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8650D30DD03;
	Tue, 23 Sep 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4jOnM9Q"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1E30C61C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657658; cv=none; b=bf0Zx9GLn/RuASr+6fl3NTDjlJ/7PtRnL/BtR8uYw/IhhTWC46AUOJeQbq/gmj199T3eHp1fuY0Iq6Ojjy3AGMLDctggaJII2m9WO0IWLrdlk4bE3l2veTJQhGvE5zewd9/FCc4a92SJ5/hs5ZuSer3RbezUZGRM5KvoqoqMY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657658; c=relaxed/simple;
	bh=za6eoflza+eI0daPO52VrArrXQQh9oKqLFL2yU7G4qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm6p8CfojwXez2r1shtwlqfnRt8NDsMa1WuBMrTZZFtRoaXqpAIT05LyBlNJJ/zDuiVcgs4WS2sqTr0q3K8Rgji1zg+nMEHb3/OtePkhj8s5sPcJpPCZTlsJI8xDbI9TLECq5zd2s+i9F7pMZO4dI40r7eu2av9nNk25x+mO9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4jOnM9Q; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b2a1a166265so49778766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657656; x=1759262456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvM5EG3LMIQuZITndtrZP0Eki684ON50PFEBay054lA=;
        b=c4jOnM9QEkWDqPrR+CsDuHhhX2WaAYDyMzb0l2y9LULpcKUAItkDpwx5lt6sjg4kE+
         UyPAFDmu4aR2C5snhubvV28QfEVemUgyCWRvisVCCCtw36vDRb/fgyIausDx0hNS7+xB
         57jqpD25HqdsXSXljGRYdGUfnjEXAFbQ7tRukTAtUzlFgb7gjcHlLxIdbLmijBrHhplW
         QXCoglWLdYwq97XzTljwFvTr1dlmJZse6/8/FGPS3aNtVUUL+cq8i55XS+mWTpYQcdLZ
         suuPqkJnieST71cj0UPW5T8J/XmqrgQFIarUYWIDiIAHpbJN4c6bRBxXmyh+4IEipQrM
         Z5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657656; x=1759262456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvM5EG3LMIQuZITndtrZP0Eki684ON50PFEBay054lA=;
        b=lgCO2IgC8eXMHrz9hwy7fHuRhb6WZ74NPU9aAFtoD/CvDLmfy/MzWJhFY+iPF5mNQK
         9lhmopMY9h1Ha5LyLSa7VujauqjlDW8ROTeNAEoSq1bUg3koqpabjJOvhMvPeoknpRL3
         AC+YrX1iazuGLI07lXzl6TVTDd3CKUUw5n6GNqQYzZZbAJXFjX/6Sp0K8eyjSYiYHnj3
         /P3Xk/2mbw0isg502xquTmRw9qX3lJUkHx1CmP/W95wRDjzZ56Q4rIadaKGXTUGhl31V
         pr1Qj8QfbLWm0p8hIWTrxfmm3nKnYs9KcdW7aPbFTR7zk+KWWpnIUhHS9mSuIDLUZDba
         C8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWP6PhenimrJrxYv0FHMv/J/ZeADJSztOFFb7yNVuDO7AnfWgvtANJ1HOlQ9MK5CB1eYK34KOt+P88rKIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUPE0HAJRMuhEX/Pp+YJJRCmhVfgQ/OEAV5yXoRDuGTIytGzq
	XzIgp+iBTPLZ8CaZ1Ry4HSeLeSQvSvVJL+Xgae9/7qSSg0G0hdpGocI1
X-Gm-Gg: ASbGnctCvNBEU6r3DOiG9chCxewhLPe0LF/uQxfj4j9asgEpweKvjdmxmqm8+Ui4kO2
	eR80jeoOM5hwiCv72hcH5T6D56GpeQw0LGltjiks1SDRtxP8WZJbDN61Uq7Vm4TeCAp2eFRaoBj
	tAOdcmjNFr6cqfvRbtUcMn/z+cyCnYq2bMAFye8kFjKqXq6lP3+1dY4ViidORrTD/0/Sl+OzOQ1
	Sst5qz3236VFl1dq6LJHfD8m7bWoMyhvmZzpR05hofPDYkFB7Ka7tlbMD6e3CDlvqKdgE8YA4qO
	MgHvWZOr0pSwiiVoQ3ciI26LuoBi3ncL5QNthohxEGNXucEo9uAoVItPuJ1kCETraRuP9qOQiDG
	Uyil2O3hfGGH6WZn1sFUlm3Z0
X-Google-Smtp-Source: AGHT+IFnbqnzDpvcF1npAo3gJlRiN0aWJNOZlV40ujMaGftot7QGowUdecTibpSbqF5TWABjiIk+nA==
X-Received: by 2002:a17:907:3f1b:b0:afe:88ac:ab9 with SMTP id a640c23a62f3a-b302c10a6acmr180708366b.9.1758657655543;
        Tue, 23 Sep 2025 13:00:55 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:55 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 4/4] net: veth: Implement RX queue index XDP hint
Date: Tue, 23 Sep 2025 22:00:15 +0100
Message-ID: <20250923210026.3870-5-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement xmo_rx_queue_index callback in veth driver
to export queue_index for use in eBPF programs.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..be76dd292819 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1692,6 +1692,17 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_queue_index(const struct xdp_md *ctx, u32 *queue_index)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+
+	if (!_ctx->xdp.rxq)
+		return -ENODATA;
+
+	*queue_index = _ctx->xdp.rxq->queue_index;
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1717,6 +1728,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_queue_index		= veth_xdp_rx_queue_index,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.51.0


