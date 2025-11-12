Return-Path: <linux-kernel+bounces-896618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D1C50CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E21887DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C881E2F0C67;
	Wed, 12 Nov 2025 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXjGsGAD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575602E2F03
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930541; cv=none; b=j1LTQ5gEAiK5RaGZ/pACG37f61gcxTH2CIPZDjd84diAA2LIffXXFii6VfU8Co9bqz+uKvX3Mw3rycHKdkwuM58Zb1fdPWUx1Yq1x6Imz/DcbitNTIRlj6r7h9fcXRQWzQ7bhV/PIikDAnSxAL1w9hNJ2+qUNrRPEFGhzqrmvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930541; c=relaxed/simple;
	bh=5emprepJCkrosJM8h3ONRAh/VBEaqfFdtQYY3rXLh2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ullvFLdacHb7F1kZzdv4OdDWfCuuHaj+X5s/ebMGDWDii+YRezCN4/dj0qIvliQAE1QKYA7GalIh/VmM9PPRljMCYaDpOxzmXEskf1n1TK6O9Wi/wK8EnrX6q5UE01+QUHx4Ntt/3HA0ev5eI/iG2IXHgIL40XZbPVr1cQk7AF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXjGsGAD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298287a26c3so5666185ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930538; x=1763535338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfQ2Nx6CoFxjU6rBT4tiqTH+6eTbyO5fnFEERoP0vpM=;
        b=bXjGsGADzGCoIedw0cuDsmzCkFavQcBN8SX4Dez5eX+1Hy9nY4dUhBD0opyzTBrhNr
         LRjRpQtCYYbgOP0MTe7t6rvEmFKQiZu5Hczn/4zo4pz2mfQZrXYUQj1k0CifMEksP4vf
         kQofAyVIjfoUKJOyRsQTxAWWOzT3P9IzNPFT4YcEVWgB94eZdEhutn/jBTJj73D/Vzm5
         Tcp15aXGZkMwjkD4ItS1AcdB4Nwprkak+BV0oegH53/A5pUvFG0R/b5YOde/TnvdIpDv
         0uOD5NKRLUfbtbuatI6ZvtjXxbQjtvspHLtuto9r/OTYLToknfbHiNwpsbgKqBSFo9pg
         3jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930538; x=1763535338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kfQ2Nx6CoFxjU6rBT4tiqTH+6eTbyO5fnFEERoP0vpM=;
        b=Tg7C+OQSjTGxhi4LjwNKaIsoOndBvLlX7t5sEThK25SpJkutTKFqMX0cv35PxWL9Tr
         0wE7C+e/2Mp+tMwmCeje4X2z7ZBdCjsYqW0k6WfjRcWtDnw086jCgmLGZorh0s6mVmUI
         qjLOTRm3/KfPeOUxXhCHaIzNUtwuil/hbaW9kqACPr2U+SjO/QLmYamqMJ6OLcx2BWB+
         JOeVbibcZfYIoRzV48wmJFwqfXNihh5yLxaz4n+zzC4RLheTn8XOqS9ZcGb6Jsp16XWM
         21fLGD0YG1wi6yTkFSd/P4sAUdnTXt2tUWHmclfOChVFWMWADUrdvLTvQ/RbEubCZYSN
         74xA==
X-Forwarded-Encrypted: i=1; AJvYcCU+4J5p6efhtFFoJ7gO6zc/rwrOwCJHoIM6wbCU86EIlSCTj4AkPEVG0+lcUbIsMjFiYL9gpikR5hno7v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxhue4UQT+qp+0OnTwsdHMPdy+CyZNmhNnwyAlFb4tE19ADYq3
	W8+J8jde3GaCzGQu+1dButUFPBsVg8eCAMu3t8pERrVIk75JufMtC66I
X-Gm-Gg: ASbGncv+kkA+Ks1YlY7L0QdCV1G5I5Y95x00iA8QONg2nBZ0UN633aKt47sRjo0VoJ5
	/1g+3Oyn0cnzA8zz1mA3wxyBgIVKmdabZi4k9LgKrSl3ygiy+/EhC7dFo8cvogGmbfDaW4fM6ih
	BMb6x+0fJaNq7IO3REm+TsORZpsW1XTGgb2w83sgbOHRYD9t5pIASNa/2AKcC2H/d2qJCcW5imd
	g/8Ucs68dvrS9/FGCpYx6vSwZbZzVvO3QGVa+gAq+WqSSFV5isEb30x2OFDQSjhTJInP+AptU/2
	iVADSFNMFmipRArp6x5qUKDOefz+EdhE8mLaXjox3bA1a3NELxkJELlHm6k6jCqdJ0Y+PKo11xO
	MV0l0OpCF6iMK4eA5htGkizRwz8PTxecRBCsKMKl3n8ZI3fWdgiRiQCErBJ1OV2skeEEzA2/X
X-Google-Smtp-Source: AGHT+IF7DfsEqGvimsF/vV7xkPY5hQFPw6KbtZBzdnrAV5tW65XpvT8z84/9DJylmvZPMXLFyKNPwg==
X-Received: by 2002:a17:903:19e3:b0:295:21ac:352b with SMTP id d9443c01a7336-2984ed92f72mr26986205ad.15.1762930538514;
        Tue, 11 Nov 2025 22:55:38 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dce55dcsm18719235ad.97.2025.11.11.22.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:38 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:46 -0800
Subject: [PATCH net-next v9 04/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-4-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
grow, we want to keep it trimmed down so it doesn't exceed the size of
skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
additional two bytes for new fields at the end of the structure. It does
not shrink the total size, however.

Future work could include combining fields like reply and tap_delivered
into a single bitfield, but currently doing so will not make the total
struct size smaller (although, would extend the tail-end padding area by
one byte).

Before this patch:

struct virtio_vsock_skb_cb {
	bool                       reply;                /*     0     1 */
	bool                       tap_delivered;        /*     1     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        offset;               /*     4     4 */

	/* size: 8, cachelines: 1, members: 3 */
	/* sum members: 6, holes: 1, sum holes: 2 */
	/* last cacheline: 8 bytes */
};
;

After this patch:

struct virtio_vsock_skb_cb {
	u32                        offset;               /*     0     4 */
	bool                       reply;                /*     4     1 */
	bool                       tap_delivered;        /*     5     1 */

	/* size: 8, cachelines: 1, members: 3 */
	/* padding: 2 */
	/* last cacheline: 8 bytes */
};

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 5ed6136a4ed4..18deb3c8dab3 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,9 +10,9 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	u32 offset;
 	bool reply;
 	bool tap_delivered;
-	u32 offset;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))

-- 
2.47.3


