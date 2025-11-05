Return-Path: <linux-kernel+bounces-887108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C7C374AB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7791D18964BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EFD2BCF46;
	Wed,  5 Nov 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkkHmQ1n"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CA2989BC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367185; cv=none; b=Ud8539oWyNypi4CH7wInlBs7j7LT4hYRQ3lJN36VqEWvMk5hQn5HEwtsM5IjcqEcePgasw+siLxFifbDt+0J2Oa8gkLXEe4FhLISjmy5IdNlq6sQiXKtNoMO4V6TQbfzu+2Ckoz39zh8v9E0/APEXJQu4DKjcoAJGUZfu51iuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367185; c=relaxed/simple;
	bh=1Y+YpubDp1qb7oc7hg3w1PWoz9inIa15b2wdhzuZk9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WjwqZTRWOsfLU3ixnXtasmenmSiGardbnG3paH2jPbl0vxskO43UFAdoEUJaNmDJuoqyi266w/VYYhZ554/jzJvA8uxhHFLkhyk/z6XaLEfVFGFL/y1Z5QEsjpIVzqi0q4c77NwumPDB+9/t4yquepBST5ppIWCmLv/lwxLSQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkkHmQ1n; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295fbc7d4abso1384405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762367183; x=1762971983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3U2BLp1AgEXNIvYOhrj08jJ81pfESpJT+bWqtR6/KU=;
        b=dkkHmQ1nD5ZsNxlVSzNpy0wE/bOroBYIVCeM+vOSx3biPu4UDYc2EJRKLtfJrp+78+
         g4uHuQAhPA9OBfjnMEYi+l5oESfLmS1NVevE57x+U7Bo+JxLMaKcL6i/Yad/QznGvIL9
         nCxQdTRUj3L0aZN0DIFvFfzCK6LbsnwXBRHhqzxgKVKMdUpo/n+H6aoSxX2Pxz15kLDO
         LumHleiDyQHUzWHJ0yM6LnAE63pRfPWBvpDQLR3SL8djsgwdGSgx0pd3ue4c5xzvXNNj
         HTv+GtS7EKNZJ/h+ZX0HP61uevPBHKZ1cblsPe0EOUe7jGlwxazlB1vMPwRA4UeAg114
         sukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367183; x=1762971983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3U2BLp1AgEXNIvYOhrj08jJ81pfESpJT+bWqtR6/KU=;
        b=sfW1hDn9jmZSAQcqNifheYlriBoCZYFuGVBAn0a9NamOE7Kp1CSNMCAhcYVDhEpPr2
         WHgqnvuh6UUeXwzy2KZZYorghTDofAbUEjFEhg3VwSXCv71W59kiineAHBGdGAa4D3Zd
         YhJNQQowORaV5qPuuMR/UeQ6ivskb1NA2NKySPdMPCWFLTn3ItEkoU7DK6ZqApXlRmfG
         xwIfPMniRL8xQyWl/HmkMCcTJbCKiyE1C0RNPrUXdm0FLeYPSrqL6B3Z90OmkFX/kg63
         tbkVTscVwUuPlWgRFLkO4uz8ujq4FtJgH4FL8K5VL8VPdFAXEuVp1k7UjiPqqeaBdzov
         f2+g==
X-Forwarded-Encrypted: i=1; AJvYcCWwQdnfTrvJYez0cbQM2qd+6t3DrJ7fn2p7WGrAbNiatc924KxE9cBmPhh+QC9k+e65eM4K+D4JRTxRd5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQUe2AXBE9/pGNNGwpbmy1L3mOTEJ9OQFBF6Vg+2qCigZ6Y9z
	0t+syfAijzKVrdEVzFc4ks7UTfT4RIKNeryz52qbGULt3PzyCgejdkTnKpNmyN6sWc7i3t4tj1P
	UsrZs4c/gdemc/A==
X-Google-Smtp-Source: AGHT+IEdUAxa3HWekMEatlxH9Kt/FB0hCWCz5vzdSLG5I0UzRSXnc0Ih9uf0QxQgeyniEKJEai53BK+w8nYlGA==
X-Received: from plgm15.prod.google.com ([2002:a17:902:f64f:b0:296:18d:ea1a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da82:b0:295:8da5:c631 with SMTP id d9443c01a7336-2962ada612dmr64665275ad.42.1762367183511;
 Wed, 05 Nov 2025 10:26:23 -0800 (PST)
Date: Wed,  5 Nov 2025 10:26:03 -0800
In-Reply-To: <20251105182603.1223474-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105182603.1223474-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251105182603.1223474-5-joshwash@google.com>
Subject: [PATCH net-next v2 4/4] gve: Default to max_rx_buffer_size for DQO if
 device supported
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Change the driver's default behavior to prefer the largest available RX
buffer length supported by the device for DQO format, rather than always
using the hardcoded 2K default.

Previously, the driver would initialize with
`GVE_DEFAULT_RX_BUFFER_SIZE` (2K), even if the device advertised support
for a larger length (e.g., 4K).

Performance observations:
- With LRO disabled, we observed >10% improvement in RX single stream
throughput when MTU >=2048.
- With LRO enabled, we observed >10% improvement in RX single stream
throughput when MTU >=1460.
- No regressions were observed.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 4f33d09..b72cc0f 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -987,6 +987,10 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		dev_info(&priv->pdev->dev,
 			 "BUFFER SIZES device option enabled with max_rx_buffer_size of %u, header_buf_size of %u.\n",
 			 priv->max_rx_buffer_size, priv->header_buf_size);
+		if (gve_is_dqo(priv) &&
+		    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
+			priv->rx_cfg.packet_buffer_size =
+				priv->max_rx_buffer_size;
 	}
 
 	/* Read and store ring size ranges given by device */
-- 
2.51.2.997.g839fc31de9-goog


