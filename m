Return-Path: <linux-kernel+bounces-867555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1AC02F26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46832506E37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA76034C9BD;
	Thu, 23 Oct 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZluPI/AT"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFA34B1A7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244088; cv=none; b=ULYjR9zWwcF8merbnOghDXximyDKL4YlnPjH0Be4KoFjkZhL9wJ579A9kVPWHEXLu+SylPDdTN95iQYExaPsvfEZ4df6i0aBm2ZJAZmZHfjcJ0ljHAZuewQBbaVEnfxzV5SK6sAAKL2QxXvHRKacpuOMEIjDOlK+tFcERf6mHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244088; c=relaxed/simple;
	bh=5ZnZPrVDfdO+Z9/UM3e8BCikhyLuP+zNDA80rKqdbMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgkVFkbBePtc0lSwq1l4WfXwGbXGXErErWzlNgAZAB+ftTX7oREJNjHycoaAKxPwUSzSDgFWNH+ObnbFUdagNcvbeEWmlpyxaOdFrQzgc2+mKm4BXnmIToEClPC0Def6hx1Ni+PUaWhfXHX65MdTBpNIQsz0W+V+negXw/csBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZluPI/AT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-269639879c3so10484555ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244086; x=1761848886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=ZluPI/ATyLxWxTZnYtnR1Q+2uqTB8mTBDQVYynXfkdJqsa6A9Txt9/KjUi4mCfhZ/Y
         6XLP/aLF5CVY9ezJucDQCws4m1PpC0+ulGf2zweCjxbvf6bfEKR1MiMTRXJQ0wPXrTTx
         leva9rnWFR43CoZ2ATmAEOtOJrCAkQQ+pfX59nKs1bNb4NWM52FTWeXJLq/gLHHr+wFS
         5whdVdBitUm2RU7sV+qHkbRjyemuJ+TfwBgvHIITwc7W7uIkYNSSmWLUjjTPoQHSguef
         +1s1PKqKYefGRIu/7tV2+Gd61SpbNP06SvCt5aOZgzKxwzM4ARH1o65DylVHpdAR7/tY
         cbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244086; x=1761848886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=k66qlrI2gC62csoL4DBhzJnqZOf5nY125Sb+8g54zYCaxRcBhtm6S5Zk99ViEREclX
         Oq2B5iNbMM1zSWSbEnrq2VrjNKXbuLb0Te02RSBFNF66JBGnkOOJhZKmhR/pjSZqh7KR
         uQhU/taGw209SiAMsECEehvPab5SXwLQPVMbZcjBwPl5qQKDFGXSjbqqMV5q6BqOGYpj
         k02trOgfVOm8Ki6oqdwcQwPPwBEnI9vwf/5AYMrKWtfPprvhwkDUcKMBpo9n/5YZg7ta
         rjmlWwxP4BGJ1gSkfr/HVY7QbiN2s7+NDPjkfMETIS8KLBNN9l3TzVbze13o9PTFM0t8
         u+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqeMUpoMbYnkGYaR59YDzZIBnFar4Eu0cQjCyPmPvgbPwV7DrGnFgA1M/pYq0+St0t2hbGaUW+ni/nvZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPbF1t8vlD1PUwq+4cEsRMrfQFbFEKLrujRHhJeGbgZ2Hhem6
	hGEG4aMkURKZM98ZBwRo6rTJKfi7wssHs0BNqaAAtm5X9JpSPEXeXisr
X-Gm-Gg: ASbGncug7K+9c/m4nqfMpN8G7bH92J6MqXoGn3Ob4m5OV7AruPIPnhJA20lhJYZWmAV
	Ne3BPREjYa4pWMGrCkcbvfNt3/wsvuaTfkAFqTNmg9ddXpaUxDhQDrdSmTYPWK+X0FUE3h8sjZn
	b6imxhmOpWP/M96D00ar7F+Hj9Z5lP2dwTa4qFuQP1gocTcem0PNYUc13Wch3r93DaEptbdn3np
	8itAdNDV+KfOIBvd8rC0+7BMMBL5b6y+/2zTKerky/g8VKoTglznwBqIc/UoLB68yVsa/RuWrR4
	43hsh+7vLFvgm7L8uKD9AlqyFB0cUnEnOjY9b0z7JH1JLWjLW9M9NfEURmLUCMdzhT44dy2XcY5
	Vu9wba+7pcxyIFcXBVKADf6SoQINGMKelrSgDKe+tvuf/Lhd/dGCDYq5tze6LnSVIYBykXdle6X
	5cWg/ViK3E3TYpb1DEduA=
X-Google-Smtp-Source: AGHT+IHuF0nGiLuYIY7bEPnV/kWChQOzz0OHyllyc5LZQHhWV90GhBaf/if/KbPVYud5pvRswtc0Ww==
X-Received: by 2002:a17:902:ebc6:b0:290:9a74:a8ad with SMTP id d9443c01a7336-290cba41dc7mr337313795ad.53.1761244085636;
        Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de152e7sm30294645ad.29.2025.10.23.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:41 -0700
Subject: [PATCH net-next v8 02/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..87cf4dcac78a 100644
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


