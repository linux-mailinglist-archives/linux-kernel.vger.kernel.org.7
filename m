Return-Path: <linux-kernel+bounces-851074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668C6BD56B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250CD4028B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16029D266;
	Mon, 13 Oct 2025 17:09:33 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521232C0F87
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375370; cv=none; b=t+AQS7qLAy69YzCD3eGJR+ksYMDniOQqnznqd4W2cqHv7XT9xT9UIMlYqPlcZKcC9v6K60/EaVKgyN/kVO46MSjSY8c0mpu3oybas/n2HwS6uhIbyJj4TIdetKpe4q78QTS+Ca/9Wjk+9851KcnRqaTCFzjEroRwoXpEP9Fh6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375370; c=relaxed/simple;
	bh=GcsJsmNR66TkTqTz1B+6YFyl+EAGJv7TFYbWgcNErZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=efDN8uJRb0d3E6X+L0xmZdp9ZQP7VSHvKxeyzwmXPmY8M+QtY2Rz2oosKVfZwUNQ/wtBEfU1kF9XMKipJ0EPKsHBn+Lb1uLS+C1ljrGoo3LnOQ1sI/WJomEwpS0iSpmeJM4SuOp1Kg+JaBrQ26Ub0hrihF+8Qr2Sk1731VE2IHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so808447466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760375365; x=1760980165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzbk+4Totk/9NHbsfjmJ9rzLfO5PvmO39iyLAhqUy/w=;
        b=QMvnMV+rTnIhpUaO3T8ZO3UphB7+FcpsIbgRZm2HfTuTfaxCo4xGjPTALwz2e6/p6x
         QDCkX/4ZCIwuutCVQ/92i5WWXIUfzHENS+FS+K4WaxH3wLRgY8HGQT5LrTEHP+8gubo8
         caZhVUxuv1Tqro3NrX0IQ0E6XSZHt6om2XoqDkuoirzrloy5puAGPDBKNlCg/iqQ3QG7
         IB/I+fh3SN2iwtB0OBBaIOL5hCb/pdEYUx86ZMMYDLc7G/QTgZ19Rl+3DpdWcDxjTSNJ
         Wby/AkiKd1sBV0ySfBRR9dVO6MuHhkL/GnW0GmgoT/JzNqrE2pHJezufRW5zc4dHWEV5
         7U0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDjqAds/WxpoKDYIB3SSeV8/3gRHmqHY08aw8TJJK2hoF4xgHPlHHQJkh6WM87sX9SqtJJd0GMTKtTtoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLOeEMcp2I6/ntRRWRFXRDwSARA2IfvrJbFzxUi0I7c6uedKy
	cksVXMxgOT3k/qweEscUSm/diQDn371WRdWP01RNCv6AuF+a1x5qeLJX
X-Gm-Gg: ASbGncuM6zZNlSIbJKa1Qq9Iv1fv8uqL2bVeTI9jjLm4V6RaD7zfifHZyWEwrABolEL
	aAqLdO0lMZ7skebYOTzKN4mXV+Z26MSkypCJwBlbw+qnuiqigeIIrskUjBxmUTv3QKI/1gzp4h/
	z+S5qTiBX9EYYzQ+Ft/IY1Vt8BLiT0Z9TwzH4B263l/++3KUQHct0uCfqs4xaO5GclWevemRs6B
	GMLM4Fw51fZ7C2mWrGuzwu3kKgYDfU+JJcDxuItKy9ksi22RTkNJYgTn+e9tNtB5VdG0oy5cbim
	qFTh39Hbn5Xxzy3NXx50H8JE9iBNnmvPv23iyIPWgqdd9TX3QSGPPuRUaOfmocYtvxgRRJAmRQB
	unS/tX9ZXQg2wljwPqvAE+Cor57uJ3CWp3/O4PbpAaYfie6c=
X-Google-Smtp-Source: AGHT+IGt5kR5F8pvKrJpygfr2pjUntgvPJaB47lL0nD0FC9FyzJ3Jztqt6mIq5PEXkSvc0BpQWVJcw==
X-Received: by 2002:a17:907:2da9:b0:b4f:e357:78f8 with SMTP id a640c23a62f3a-b50ac7eb031mr2337168066b.52.1760375364369;
        Mon, 13 Oct 2025 10:09:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61d04dfsm968072966b.22.2025.10.13.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:09:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 13 Oct 2025 10:09:22 -0700
Subject: [PATCH net] netdevsim: set the carrier when the device goes up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org>
X-B4-Tracking: v=1; b=H4sIAEEy7WgC/x3MWwqAIBAF0K0M9ztBe1FuJSKsxpqPLDQiiPYed
 BZwHiSOwgmWHkS+JMkeYMlkhGl1YWElMywh13lltClU4HPmK8k2eLnV2LrGVboufeOREY7IXu7
 /6xD4RP++H+ng1TtkAAAA
X-Change-ID: 20251013-netdevsim_fix-b9a8a5064f8f
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=leitao@debian.org;
 h=from:subject:message-id; bh=GcsJsmNR66TkTqTz1B+6YFyl+EAGJv7TFYbWgcNErZA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo7TJDW761SlNjpZNmbozNyChyMxtw+94H7IFC4
 YVqbKWDUeCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaO0yQwAKCRA1o5Of/Hh3
 bWtOEACdABdg97kR6gRbybCU2xqATK1KstssSfsOUrtyJ1FRnjIzSVX7e/gF7GVdfFmtyJzqD7t
 QO0+vcYxeGIW42+omO2ALE9lNopeK3EPhi/X5bvypiqLqSRaFBqNidiA2ZS4K4OZLDVBUrxoFRG
 slHsLHOqf0+GgDGvoF4WhM+4hNBsdn2UiTx77peuPME/QJsqkBtOAEars11h4sYYipFE01vOwTO
 u4wwHyeTRSu6oc2SsA4b8u0XRyejsQIRix75bJsjmnoRZoV68XqD7gmp3bbnzsBuvynq8ZF49Ez
 kNmx7KuK3GvVlRUjFpnd+pD/u9ZeK2aBawj11oTWKJne5j61Hwn4979RLM5zvfQ1iYTLgTVmwZV
 fJZWInQRX5+FDf/qhwDONGroVCpt4IoHcRZ75mDGKTHbFrJpEmtRbUu4+p6IXu7RzhToatBzUtj
 WmrKUiUYA4xIqKbjkkHWstGMfU/kK/CzXtWnmNJ5sRMuVhlrrmLQc8wO7FgWK8G6BhtJkELmn0Z
 ZCrlIxUAn16LKYT4IKCW0P+SDWnRodLAKfkwns7Zv/qDoxDNUaYXTfkNnjwSLOezO6Oa6doOEmF
 MNvYMWTCQhhJMrXs8diQ7oAW2z6FOaYMuOiLsrSEW0OqXZX5cIdEqkn46+yhgT7JxHbbD9Jl1hh
 J4ushMPWj2YQKIg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Bringing a linked netdevsim device down and then up causes communication
failure because both interfaces lack carrier. Basically a ifdown/ifup on
the interface make the link broken.

When a device is brought up, if it has a peer and this peer device is
UP, set both carriers to on.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 3762ec05a9fbda ("netdevsim: add NAPI support")
---
 drivers/net/netdevsim/netdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index ebc3833e95b44..fa1d97885caaf 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -545,6 +545,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 static int nsim_open(struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer;
 	int err;
 
 	netdev_assert_locked(dev);
@@ -555,6 +556,12 @@ static int nsim_open(struct net_device *dev)
 
 	nsim_enable_napi(ns);
 
+	peer = rtnl_dereference(ns->peer);
+	if (peer && netif_running(peer->netdev)) {
+		netif_carrier_on(dev);
+		netif_carrier_on(peer->netdev);
+	}
+
 	return 0;
 }
 

---
base-commit: 0b4b77eff5f8cd9be062783a1c1e198d46d0a753
change-id: 20251013-netdevsim_fix-b9a8a5064f8f

Best regards,
--  
Breno Leitao <leitao@debian.org>


