Return-Path: <linux-kernel+bounces-855103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F96BE03C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC5874F7B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF4B665;
	Wed, 15 Oct 2025 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxSNe3T7"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB46FC5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553962; cv=none; b=ZP2CFjv9BlOPIsNV2YNg3+lbndlClg86Ym53v1hERLiNlII4c1GIf47Dt7nmrsSNSeZ0SjgDoxJf5qFQA7nVN6okVf1Vnmfne2Je6SdPGmmpOH3ibsWq1xsldsvz+ZNbY8T3sEJ117Fhzp+vwv0Mjb+EqEYKtArQ4tPpCVaaaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553962; c=relaxed/simple;
	bh=j0dB+z1QJhokdFNrZJ4E2TDUIMNX6UmtknIL+sRxQg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uogSvMmCvdj44kQ+tjFQEm8beLJxgvoglP7MUKKmJKEbCov8bIAGxq1aTvre640ewAXlG/UbpL0wybf3424ZvN8c3bLgSV3vomDCgkFp99Bhuz6+DggA7bpuqzfMObGW46cq5KBHCmbYSmyziSBDUCGDALvx5zIm5vKnVd3DKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxSNe3T7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37634d352dfso57386611fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760553959; x=1761158759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/Q7+5bvyc+y+xZiQH200o3xNZSiEQX4GGlTPGcAOz4=;
        b=TxSNe3T7NP1QCopkMkf9WLGdc8jdENZmQtC5TpmmE1uY2ZC05kCXet1N18RNHFthPI
         bRP4p+IJsmWGtsgfC9ar7HTXRvk+EnJLiyqCHY0qDNo9hoZDVPL6hl0xXRBvS4F6XABK
         jAExM8nGify0l+2sikJavOlRSI+rV5HIWa5sndZUyHI4GeZSzzO2kry0QAkHgnqnlYu0
         SUXPhjn5sTCx7BAy57qyZ/DvMRHUICFBB2H/JE6duqGhM/dSuLQQZ0J5JGPS3EGm2eM8
         cI4flGJXt2uQNyT4SfW9ugRvXmza9GSmXN6ZYeQFJuwk8n+6/GYD5cAGdg0q1bktPmvo
         oWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553959; x=1761158759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/Q7+5bvyc+y+xZiQH200o3xNZSiEQX4GGlTPGcAOz4=;
        b=f0xAqi4Jq7q/q6CApk7hijfVGx/UpvqbVL0qQTn3TaruM6qg4YeONSQGyUtesQ3aI6
         nnPdwZwSSVG4wlO8itUlcv1GbQMVAYvckiXzBFH/RQF8lvDjGPOEqGjNGTrXQzx7lU10
         m2hcy6w7nueyRbYODhHwi4Rxy6jUMI1GujnqczwB9FEIpuHVfutJ3qMJXQx128Zev46a
         gaHNrllSsFEXfZ7wjOViT7J5GscYUjeGyZLpAcBiBTtQAD1VmT84Zk9gnKKwITIqMQsA
         ij7HgaHe5P0QtwFU9mAVJ32m299oKBG0PfyAllmQkOqBg7Pp23d/PwgyP1fJ0Xb0gc18
         cTLg==
X-Forwarded-Encrypted: i=1; AJvYcCWVBC0vQSXzNtGEY/8o5RlvLvVYPnjuFfv7ys9Ol/SC3AOVOV4u2Qhc/EnIlmTZjmMIlzN5Jiy7PSftjHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThsNQph40p06V6gvzpMblL91ZpOsmWgt2/xUfjyCfKZ089z+I
	zTVqmisXZ6QsDnSnrcJ1QppD06PxfGazQmXC9hMvn6HFzQga0yCn2W4Z
X-Gm-Gg: ASbGncv1NhoCrbgydyg+613uWiu5i54kCqRXYoWhbKsbSrErxRGIgdixMLJweLwCCHf
	gBd7OVU/cyO0ofSjMbLWNpNW8CI3Gf6jSVIwaOUpIL6P0N6BaAlgRJz9VsuiXDEyZyqVe/Om9oA
	J1XmvwgIPk/AnX7/Ygc7oq/wVHD9SuvFWUMhGDSi9KP8MkuMXmxRnH4iK6bRwPhVgOVORUDEFBz
	poa6WB6k4PtVKJP6ahwgoiZJjjZxjAYjkJgukM5s4KSSWfazrTrnTm09xtH2SPVJh7it4FxZ+rA
	X6jzm1BSE9vyJtgP1AorEyDynA+plizu7cwEfHA/SlJk95RyuxAeIZR3YNbmfYXB7fRxG7S+z3n
	CbY3YJ8aOcR1odN8cTJiURwtxJJ1LC+kB+3Ae1U2cd6pocaDJAExH1hzwkw==
X-Google-Smtp-Source: AGHT+IEQ8J7mN7zmFb/mTib/dJL7UdCidB0M0c96bKSMNuCRBOVnxZ/30d1D7ryje52tDGkLhm1OBA==
X-Received: by 2002:a05:651c:990:b0:371:fb14:39bb with SMTP id 38308e7fff4ca-37609d72cc1mr85265531fa.16.1760553959064;
        Wed, 15 Oct 2025 11:45:59 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e7b6cf1sm50005891fa.24.2025.10.15.11.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:45:58 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] sctp: avoid NULL dereference when chunk data buffer is missing
Date: Wed, 15 Oct 2025 21:45:10 +0300
Message-Id: <20251015184510.6547-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chunk->skb pointer is dereferenced in the if-block where it's supposed
to be NULL only.

Use the chunk header instead, which should be available at this point
in execution.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 90017accff61 ("sctp: Add GSO support")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 net/sctp/inqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..f1830c21953f 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -173,7 +173,8 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
 
 			if (WARN_ON(!chunk->skb)) {
-				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
+				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
+						 SCTP_MIB_IN_PKT_DISCARDS);
 				sctp_chunk_free(chunk);
 				goto next_chunk;
 			}
-- 
2.34.1


