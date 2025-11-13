Return-Path: <linux-kernel+bounces-899049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219CC56AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37147420193
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1A3346B1;
	Thu, 13 Nov 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chCJS7L8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGDB1rIg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36333373C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026492; cv=none; b=Z52I0ds7/w0i/f9xkhElkzW2oufMBpDfjpNxRf7OmlBz3Ng8ZPXpnqaDZVo/NvxzPlACG/NNq3NkFXIi0uZp6R0CgYWmJ/EgcT5ZkMY52Oy+kQQlDIm9IjdOleQRqfY1FR3svsow+5mGb2qJmNgeJlpeZRLPcU9+x7P1O8NWrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026492; c=relaxed/simple;
	bh=S8gYLmvc/Q/yblUy9qjW/klwunvJSVCih43kuC1flV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBjNWf8J2SYHCPooHcz6Rc+u3EiyyzLVpVDfoS0aGdnfD82KDTgvcgl4tig4zrPrdD9Y3R0PIZUx30kg7DM2OaiCMIP8VPZQuRA8NQ8XiildTUWhmPflTZ/uj6qYHA2N1tdDYiJHnhML+JuycWI4RbJSJbWsK+RikHsMxyK8c2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chCJS7L8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGDB1rIg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUTTnvYQgb1XUViqIygb3agldGtgy/h7adkhliwQCV8=;
	b=chCJS7L8kC8TtxiuhA7uvlJdkw5MJNa9ZSz/z2hdJHhujltV73Le6yHnw0OTJ/DI0savMS
	b1XCIPWH4qEQBM4dd8UlmDMc6fGMsXjxAJtgphh0xBE3y7ehAdxf04nzzntlIdDFbfXVnk
	G0blUTbXP7xFj3aWs3mm2eL9hNiBIMc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-mhSYRuG9Nuui0grGcdretA-1; Thu, 13 Nov 2025 04:34:49 -0500
X-MC-Unique: mhSYRuG9Nuui0grGcdretA-1
X-Mimecast-MFC-AGG-ID: mhSYRuG9Nuui0grGcdretA_1763026488
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775fcf67d8so4744235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026488; x=1763631288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUTTnvYQgb1XUViqIygb3agldGtgy/h7adkhliwQCV8=;
        b=VGDB1rIgrC2GZKkZtkS6/FlTGqyfFYnwNMsDN0OoJhpX780NZEiM/Uij00RmzXkvF9
         V/iF/YvEHK+8ILwGVxKcAwj1m3Lwu2MNKrl73Y3gkPNOYIt7jWD7fN9KcS5bpqKdoqej
         omkfnoRR5TZkyi0n31Cm+NKJuvbh4LTKXmfCfLl6qLb40yMTkQ6OY9GNa2MOOHZ77VOR
         w/CqV/rnA51xhJVHZgDJ6es0jUEhiJj/Q9VGUErKPbpd/Tw9UG1R3i29z0AD/25ah/Cy
         sOfhWDTnzliQMKuaSMm3hbuV/Obq6a7eFwazfozuZuNEMrq8sR/LXYFHWuii8FZ422xp
         6alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026488; x=1763631288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUTTnvYQgb1XUViqIygb3agldGtgy/h7adkhliwQCV8=;
        b=X4GupbEQa1fdLVHXwJP8kUtV7oazY7iMGVzF/s3Vh4dm7Qrc1ajwusrwEMxXoSIdG/
         la+K26KmPO32g3wTyXEo9oEFcs0y8j6261b3VosSKAOM6K5x+Aqym7w8QcJcn9lzN8q4
         +GJ8MemF2EH8VBHssZIkwURz+2vFl7Lu2w9LPQf6wEKEpQJLcoe3jJUyiW+EK3e+Ln2O
         HqKVYkGVZnsr9SwhWZ4aqHN0RWOx0MbGPoR9qh7GFnxd+zQeWMdZzxv/Rn2tGxAMpkjK
         zkhN0RsDwiU89t2GUFYzVDYJDuBmYj8iuUt8ZXqo3zbm4AwIPNe0lbWNfjj9vhOWQku5
         zdxw==
X-Gm-Message-State: AOJu0Ywa9cUusukX2jrY87Ves4x60K2xt2+t4s589zoQf0O7Q0SrisIv
	8rowupZ4nPLulpd/S327SwvAXIY1zaqMnjZoixMrN2HSA3RknKLudEX3HAheqt6OtJeHvmoKR/k
	ZvbuJMramZh6qg7iqHgs4ZbiGpvfnODFZxLit30L9ZonIWfslOFNFsb9LWo1haldeZoQsFN2IeJ
	YjLA44QZS4BAh6TlsUrPvqk6NQKCxYnSlmFUCi8Sc4ghswsg==
X-Gm-Gg: ASbGncuIpd+6GZkMcMNJcWbo4IUWIB5DTpwGuGriluCO6MXU3q4Jv2jdJnxC1h1Od7j
	nTz5En3pq93VU8er3BYkHV+lnhPv7qk6CSkTT40NPe6J5hNrrWTH4EzYmip2hI7cYkdjJfIOu7V
	DPcKMONse6i84ucfj41LwqzSs5CR/SwMiW61xHs0rl/HaP3czJlM7KBH/qeujH5fvXgdMfs9cG/
	d2biT+Ql/GQyZwMLp5+5znvF/0Mw6nvUj6aSLQdzqCUNF9EkNI48YhdHCz0ic0dU/a0yRaL1i1f
	LBD7d6q76lmTQEjqXCn0ny+oWueJSun6iF1h0Bx6J/gWf8wHxVA4byYVvIThNxatfxgqGkLjHZ/
	R1V6zClmXJFyunFM4aeo=
X-Received: by 2002:a05:600c:4695:b0:477:7737:5652 with SMTP id 5b1f17b1804b1-4778708e277mr52156895e9.20.1763026487711;
        Thu, 13 Nov 2025 01:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKBrYwFSU0SavZSQ3g8QVdoUiCVlvcnTMxvHwgjRjgdqSpBYRq4SNYNmIIu9mrYUf+MxT+zw==
X-Received: by 2002:a05:600c:4695:b0:477:7737:5652 with SMTP id 5b1f17b1804b1-4778708e277mr52156445e9.20.1763026487144;
        Thu, 13 Nov 2025 01:34:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6a1sm77800235e9.11.2025.11.13.01.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:46 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev
Subject: [PATCH 6/8] virtio: fix virtqueue_set_affinity() docs
Message-ID: <e317e91bd43b070e5eaec0ebbe60c5749d02e2dd.1763026134.git.mst@redhat.com>
References: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763026134.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Rewrite the comment for better grammar and clarity.

Fixes: 75a0a52be3c2 ("virtio: introduce an API to set affinity for a virtqueue")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index e231147ff92d..1a019a1f168d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -384,7 +384,7 @@ const char *virtio_bus_name(struct virtio_device *vdev)
  * @vq: the virtqueue
  * @cpu_mask: the cpu mask
  *
- * Pay attention the function are best-effort: the affinity hint may not be set
+ * Note that this function is best-effort: the affinity hint may not be set
  * due to config support, irq type and sharing.
  *
  */
-- 
MST


