Return-Path: <linux-kernel+bounces-891971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0701EC43F32
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AA4188C6AF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7B2FBDF3;
	Sun,  9 Nov 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpULyxSj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564D2FB99F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696016; cv=none; b=pAMwALs5sCIya0/iogMhBy7ZsnGXhdK4fxR8MkXoQJpvbTirCbSOVXmWQmTPj8qPD+u/4uwQzAz0iamK9LxMwwptywriwSFaCW0N47Ri5+CJU3hwRa1Mir2nBG94RF12meIAG3b7PGq2gcu7zt4l4ylwtqjtftfCLS3ige0Wvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696016; c=relaxed/simple;
	bh=78sRp5/pEa3exZ9nnd39D16LidtkS04WArCUHi6XxZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFaUdiIhrcYq3/wnpmT1FRiyrsfoExgEhKpZaou7G2BXUEjekyfO5xZqeK25s8M+DcLCxexSJ1j0mtRbS4bkRPf+Gud5FnfVkrRz0WuTbEzAux0k1vEgZHrkcumFcuBx0E5+MRlOIPYpYJYgGXKTtfY+CLC0xY5kk88Jeno0ruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpULyxSj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4736e043f9so303680166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 05:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762696013; x=1763300813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOxOVz3OD8A8kOJ9jS3tsAyXqepvPRy5WhOjggMQTeU=;
        b=jpULyxSjrasurBovd3jqp64akl/RwadL36n1rGmyvjqM6Bd/80RLfhQGNxUOd/6RM8
         N/G8QxBCZHdYJIEULKpKXq1cra0PTbIXv/idbLh49wMaNAnjBETXPb6FnuFC6qKMxcGz
         5M0dYD7FKcE6ITAruC7kz7fO0+Hiv+5EssyBCVOr8RQSTNVvhZA31BF2oKW2A2dZxHJp
         BvbYE3nUyb5/wCEk1g9aTZKdKb/yUWCan9xehxVqepEWkVQPZ8R7WrRUfVdnCF5/uq3T
         VCqBEojf5Op2vMbZiKp3CA98O5BbIj/u9dHDqTcVAsW+4J0SF59+VyZQn8PevRKtr27t
         BsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762696013; x=1763300813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOxOVz3OD8A8kOJ9jS3tsAyXqepvPRy5WhOjggMQTeU=;
        b=Sfy2RRK7uclId7u/32ZggIcaLIH1MWLqbiDgapcqROgs4uXfQy2JQr+puEBndqZvDC
         dsKmD7YG4iKWTqxS7TEEve5HpcfwNGpzDvLd32NITlI0SV3Dgk5Sw3hKo73YCA+Z4zaf
         yP9XnKS3EHO5d4ov0lkcugJER1VGD2otM9iKlxxhGhYP8NSS7cs1Y6x2VjvPATGw7v9/
         TH7c7wav9UQVOMfm7uGYjTPhxxFu+FiV2S8qNkPkrqSRXgN/vubDWhB9bXE1jVq8iZph
         Teobh0BgBYc5x5TYxTw2racpM1w/FBNv8rNnnV99YmWIuqERZgcczrh+8sxjQW4Rybjr
         jqqg==
X-Forwarded-Encrypted: i=1; AJvYcCV3XOOwOosJJUY2dW4cWRWEPAhQ0+hbDao3N/aaeIjaWLs1Xk1mvZ08Y2gkGf8UhzaW40SE+VbsOdeihEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVNpqhK54socMBdP6S+zhoxAVSxfVwww7NKF9J23mo59QGs15U
	zw5+ln5tPjwPhbX3kLu2P/WqwHx275E4tdcE9PziVB2cmOsI97s0rW/Y
X-Gm-Gg: ASbGncsKAVbsm+fK9BDKz6aSqcRMYd5qwJDeHoTPwchIghurehJ2tIGLoorDz+cLMFg
	1W6Cj0NYiCyK92FwhYgBeOcbgYtUyRgbe9exBwTPEhN8r5I/Aw1ywFJwjFJXtIHMKiB7UPj/pKW
	OMs9rYakBSEfIVo4PsyKb6nFBnViTcj/7glbnxdK/ZVFxflI9oJF7E2W4+YP0MRwlwJ/3rhxUEA
	6pb/rcbgXCSTaNew/iu4nFsIb3B8syun9rcYJM/Zu9Kzv6CbKEKg8KShkawYPmJXRu0U0hsirnN
	KJD0PgqQo+vFQ4p/4e59rnb6GDyvDzPDm3pYozYUVX8vuaaP0K/DMj7FIz963F4QXFSSH3D4XhF
	icgNElLTNtm0Wn05QrAOknjS5HbkZYWTILVDg9fq1s3M6R5DFfXIe2ioibuVlGv5WhjAe5whUsO
	NSRy7JxaVDicaTx3F+0dPOtqd5QCbACEcgDYnotsX2VmaqOa1a0F+TJXmP
X-Google-Smtp-Source: AGHT+IG2hV7b23VcX9jieNe0izeHc+iQCgBkne69iwz7GrZJIKFtnUWh9WFnd5ZT0ZMVj1EktFc7Rg==
X-Received: by 2002:a17:906:f5a2:b0:b72:6f76:cf73 with SMTP id a640c23a62f3a-b72e03037c4mr554584666b.21.1762696013043;
        Sun, 09 Nov 2025 05:46:53 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d14sm804313566b.74.2025.11.09.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 05:46:52 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_brcm: do not mark link local traffic as offloaded
Date: Sun,  9 Nov 2025 14:46:35 +0100
Message-ID: <20251109134635.243951-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom switches locally terminate link local traffic and do not
forward it, so we should not mark it as offloaded.

In some situations we still want/need to flood this traffic, e.g. if STP
is disabled, or it is explicitly enabled via the group_fwd_mask. But if
the skb is marked as offloaded, the kernel will assume this was already
done in hardware, and the packets never reach other bridge ports.

So ensure that link local traffic is never marked as offloaded, so that
the kernel can forward/flood these packets in software if needed.

Since the local termination in not configurable, check the destination
MAC, and never mark packets as offloaded if it is a link local ether
address.

While modern switches set the tag reason code to BRCM_EG_RC_PROT_TERM
for trapped link local traffic, they also set it for link local traffic
that is flooded (01:80:c2:00:00:10 to 01:80:c2:00:00:2f), so we cannot
use it and need to look at the destination address for them as well.

Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
Fixes: 0e62f543bed0 ("net: dsa: Fix duplicate frames flooded by learning")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
I shortly considered changing dsa_default_offload_fwd_mark(), but
decided against it because other switches may have a working trap bit,
and would then do a needless destination mac check.

I used likely() because br_input.c uses
unlikely(is_link_local_ether_addr()), and that seemed reasonable.

 net/dsa/tag_brcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index d9c77fa553b5..eadb358179ce 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -176,7 +176,8 @@ static struct sk_buff *brcm_tag_rcv_ll(struct sk_buff *skb,
 	/* Remove Broadcom tag and update checksum */
 	skb_pull_rcsum(skb, BRCM_TAG_LEN);
 
-	dsa_default_offload_fwd_mark(skb);
+	if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
+		dsa_default_offload_fwd_mark(skb);
 
 	return skb;
 }
@@ -250,7 +251,8 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	/* Remove Broadcom tag and update checksum */
 	skb_pull_rcsum(skb, len);
 
-	dsa_default_offload_fwd_mark(skb);
+	if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
+		dsa_default_offload_fwd_mark(skb);
 
 	dsa_strip_etype_header(skb, len);
 

base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.43.0


