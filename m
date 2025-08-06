Return-Path: <linux-kernel+bounces-757574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2FB1C3C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8073F6232F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E828A41E;
	Wed,  6 Aug 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dQsZCbzJ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1A288CAC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473745; cv=none; b=XZ5SncOnAt1wQJaImDouEpJT7jSZRseSTDFQZs/zgfuAmajGuH2i8Y3I1WUr0ENyOgZe1Oyb5y2YUr8MsQfy5JO203nEUYYXNTh+oR0jOmIYP20XXonoe2ElF4xbPY3gi/ZU40RFGm4Hz8ZnpuB5/3OWOlINxpiEwzf50B6+Jek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473745; c=relaxed/simple;
	bh=1YGQQ5oF6wdBoCReT6qqnw64tGjUt8KNamcQDHOlm4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXU5Wh31uBDLQyBnb3HrqQo8wDCWExQAyxDApgh8ozNsjlmkFdczEK1Ot2v+EPEiMpmsvCQZ20P54ZEElY0TcCchldbrWQUobwEtggaVtxBO4UdvtljfbD7k2DTfxDt3b5JYERHuqHSGjNBMyO7/jOCHC9SPPle9dUFSha6VN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dQsZCbzJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af922ab4849so971716766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1754473741; x=1755078541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG5PLhncHW4/uYRe700ffa/jWZYkRzoUW2i3d4oIBMU=;
        b=dQsZCbzJHqZo7u04UFrtYYvgoy1+yQRVNu3jophpgQtf51al/f21p7l6ULmvJqnSKK
         2NkiUZdOzcTZxnlZx1ZFYRa4oWeDXYhCkKjPKy089b3hFN0gZjHVWIf0rP4cM8eKygGj
         PkHKO24bca2x26gmgPcYe0c7H/ufamumM3aJOT0OvAc5so2b5wp3bPL3TzRlqt1noF+K
         AzzgshvACcvEaijCzj9RwcsIVRMcmt2/Kfl06/qHYtktKQyP+/zMGQcOhbO1taKiHQrg
         5Rlk2YOjdnKmKefXZUKK16q1pHLzIb1rupH0BKHG++ND9/T5GM8Kje2qKhwqz/ktioq5
         J/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754473741; x=1755078541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GG5PLhncHW4/uYRe700ffa/jWZYkRzoUW2i3d4oIBMU=;
        b=lcdO3RtElINnZaKchRhGXN77zs6Zr7IvytPHWjaJZMffMbZWMFTo3yGNd1U0QonZBg
         9NuPMVx0dgtAtq3ja+ZOiK5HKYaHACtQpIubMUw4T1pHHLYbqL7cwB9v3iuLa1gZgaxJ
         50nvqJ/M+jLPPo+WzNo/BrrGONV3BsKCv2D00ntL+dASX7xs56OfvqdiX3d6OpI5JrSX
         J1nFOgfo7w9ER2LTp0eaNPNvo6y9xb/6JlrM54fnz3/epk1DEzg7/b26KRkh/OKjHS0L
         m7klM07wL8FFN9mk8YZCXb+aUqY9IgjHjOgMDg/WOo22S7gvRy4XU7n8p2A3387uw9oK
         dctQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEprvWTWYRp1Uai00PxXqAt0qvbZB6F4a6Cp/czp0DAmKhLKhbzelpXEuRVjpfT0MzW1decAQsGXaJ5FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulEzgAJRSYXVoSpmBUK8YVWAeg9iWfVv3WNChWy1UIPs10iNO
	n3Qf4KNsEkMxsztNOMtTRxgcvWxd9kphLN2QID2Kh9gAwL1OpR3vWrk8w1RxDvqdBwM=
X-Gm-Gg: ASbGnctjBeiWBV2lHKz9b0lWo5DnOaKjY4mh9lqyKCD5INKOKWz7PtyNUnJbru/LLqc
	XwXmJnn5K7KCstLUB2v31Ghi7qT2+zFa1SOmslct/bc7tlbpUMkaNFPeeKe5FhRF9lCUybvdJny
	0K51BJXqRHiFYuCPujn7lia3OFEOuoUka8AiJe30o6w6s+3hCTH9B4Jizk1HcNWi59mfd4bzU0s
	4c9vO8P1p52QH3w1/EyeofEekVayWdIgFi2eEiNaxO4mf2xDGSPZLOV7Cc6Pt1iqgKgp1YIRM5I
	EkRv61SovlULYzw/+HOtiPTpUI+FCwmMn7b9dtbIkzS5fXblSs52KeDGSR8xP5YfVG0do1HfVIC
	Nl7FYWbW6KKqouNG/oKtK7bvdQOADrG3pE5YNaAZ85ugHzAuUxBi2PbCjhhFk4hSAvpN3ZX980Q
	sfCrEK4yZq9KOEfD7VAGMBag==
X-Google-Smtp-Source: AGHT+IEXaSar5Vg+LOV4tJVM3fSmFUEov8B5F8P/UBBCyNn8SgY7LaRxMuVf+6MM4Sqi4/YSucIRwA==
X-Received: by 2002:a17:907:3f99:b0:ae3:c767:da11 with SMTP id a640c23a62f3a-af990463606mr179892866b.50.1754473740927;
        Wed, 06 Aug 2025 02:49:00 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f12d500023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f12:d500:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f00247sm10139093a12.9.2025.08.06.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:49:00 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/3] net/ceph/messenger: ceph_con_get_out_msg() returns the message pointer
Date: Wed,  6 Aug 2025 11:48:53 +0200
Message-ID: <20250806094855.268799-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806094855.268799-1-max.kellermann@ionos.com>
References: <20250806094855.268799-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller in messenger_v1.c loads it anyway, so let's keep the
pointer in the register instead of reloading it from memory.  This
eliminates a tiny bit of unnecessary overhead.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/ceph/messenger.h | 2 +-
 net/ceph/messenger.c           | 4 ++--
 net/ceph/messenger_v1.c        | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1717cc57cdac..57fa70c6edfb 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -548,7 +548,7 @@ void ceph_addr_set_port(struct ceph_entity_addr *addr, int p);
 void ceph_con_process_message(struct ceph_connection *con);
 int ceph_con_in_msg_alloc(struct ceph_connection *con,
 			  struct ceph_msg_header *hdr, int *skip);
-void ceph_con_get_out_msg(struct ceph_connection *con);
+struct ceph_msg *ceph_con_get_out_msg(struct ceph_connection *con);
 
 /* messenger_v1.c */
 int ceph_con_v1_try_read(struct ceph_connection *con);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d1b5705dc0c6..7ab2176b977e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2109,7 +2109,7 @@ int ceph_con_in_msg_alloc(struct ceph_connection *con,
 	return ret;
 }
 
-void ceph_con_get_out_msg(struct ceph_connection *con)
+struct ceph_msg *ceph_con_get_out_msg(struct ceph_connection *con)
 {
 	struct ceph_msg *msg;
 
@@ -2140,7 +2140,7 @@ void ceph_con_get_out_msg(struct ceph_connection *con)
 	 * message or in case of a fault.
 	 */
 	WARN_ON(con->out_msg);
-	con->out_msg = ceph_msg_get(msg);
+	return con->out_msg = ceph_msg_get(msg);
 }
 
 /*
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index 0cb61c76b9b8..eebe4e19d75a 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -210,8 +210,7 @@ static void prepare_write_message(struct ceph_connection *con)
 			&con->v1.out_temp_ack);
 	}
 
-	ceph_con_get_out_msg(con);
-	m = con->out_msg;
+	m = ceph_con_get_out_msg(con);
 
 	dout("prepare_write_message %p seq %lld type %d len %d+%d+%zd\n",
 	     m, con->out_seq, le16_to_cpu(m->hdr.type),
-- 
2.47.2


