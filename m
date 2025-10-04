Return-Path: <linux-kernel+bounces-842044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC7BB8D6C
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 764F23468F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22AE274646;
	Sat,  4 Oct 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5PD8unk"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767261FF1C7
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759582837; cv=none; b=rSzxqAdyDk7mnNNd2HmAWN343hVFOvQD87UV0Z7vYOAMkhxiPYwR6uxa6lcp7pu0s/CYsjnrj7uxV4L/r85A7tvBNt/j9B00QDrOW+8Tx33EBCkMJ/Donrdr971qds/5lNgWTmxoqgGq45zsu49N264U38NZKlosbQYc5IVolTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759582837; c=relaxed/simple;
	bh=WOfQbqiLQi9ug8/YQkft29gfTq4eQoaDLobj1fyXQyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9XEi/zlIh+4dNQTYbge7UVFTBQx1zyK/cyM2UjvMVRFi8E64noR7hcpXZcm1ZEsjGaLYQfP4X812XeYp600ZLdcDAITFAYjIx66BeRLKzDE2rizB17Ay9WxZSuTbrILZk/AuqI6mgM07XmVPhphRytfY6YO/kog9xpvwuC+3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5PD8unk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so32869355e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759582834; x=1760187634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUSacOpwUkhYQJEzSIzuhZ2iBaIm5JbEgWtQG+WCBds=;
        b=c5PD8unkBngKFa1tOK+bMdTHslO0k/9coSbFAbZioSrZSEFrUWs7FKsuk36yYluARe
         WTDjVnYOXyNW1foqfVvhIWcOS0hxiex5ILgvjvhXN1B41Rw8Dhp7znkaLZI0Dov0eAhb
         deXiKfZjzlHBviz374jemFmQB1VUP6ZPQkt5vQJePp9pgRYG5pTpOUzWacB43vpKxUBo
         SRk5IdQj9uEmnv7Y/H5iqJr07y8qryWd3j7Tsp5+XoZv2okD22MSiPo9btoqNQeTL1E0
         wEA6KxJf539UaJp+GrQg9jNXibSBDGlqQ/BlmAepwseBM73aMe+nuVgoePlo2Up2hOVp
         9RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759582834; x=1760187634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUSacOpwUkhYQJEzSIzuhZ2iBaIm5JbEgWtQG+WCBds=;
        b=XNqEjAEofZSSq+GUBnXqsbBnl3OXMQrg4VWAXeY0Isd/D5HD8/WeAXyjCThbfrzXbc
         UilOONcXABFihRNB6L7cB/2ftxZbEhrCgY6DG3Fkyr7uSY8GMz4g0HGYES/Goxcf0JkL
         WTA9t38fpnyfb7GlDa0HHrjdYdpDUZ1wooMYtH8vl0/PkSxLyvLl9MBKoHHHeiEk4dsy
         FmCcOy4Y75VM0Wt3rdvPq37TOhacW/+j5f+JWO5zf3oic9UsqU2GJugCaUFoWwk6Hdzn
         oPebmDj4PNdZFi+BqorF+UeFfxKP0qLoHoIcGZ0D8JLslOM3iFzEfzKoRCqUMjxEqvvw
         UJTg==
X-Gm-Message-State: AOJu0YxGMsZ4CKqSFo6/6/IlmUn9vvGMcv5OVqy8Du9uKpjjcISoIMai
	vbDX+M+Yo6qZEvdez7Wa4BGiTWuNXgTcpb+MEBD8EcOZbsVhWvi2mNh29uBfzB0lwTY=
X-Gm-Gg: ASbGncvpZ/cQ0kzW0euVe4MblOXgfHjShjk3bExMSLmowYZ2T8mce6gRZB6hxIsu8xz
	CuhGUTS2VITGHKg4ejAhTgBb7jTjBZ5lUdEV4n0nbBz/ujfVfI38AfntwUgKW4taSAYDViuMQnx
	b/8ehk98/Zmc6y1S2QUZipPrhEDuh7GsEQ50ylg35+Gmo58um4SbeKPvx01nr0Z7YOGiQBELVgN
	iUhc6mqreEal5/sfVCenjdfyEKdIRzcJirD+I3EDDlZulc3dM1wmFktz8oCfaH/Iip/RicFCJld
	Ri+61WlgKXQXaGrdD/er2kjQlgRpQWnW5TYpMYS02Tluc4Kwm0ciMq8ZGRHW2yNsxdpYwZTRtDM
	dMYyE16xyaAZUOhfpHp4nEuA65sFrA0Lsvo5+gMLpXbnM2JaRB+Q=
X-Google-Smtp-Source: AGHT+IFZ/EV7PHa6pizueu5EVPvTjaqTLNqkpxUOwAYwb832MSFSJZcV+KGHkGs97t9Qc27EgHyU5Q==
X-Received: by 2002:a05:600c:19ce:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-46e7110c3d5mr55360575e9.16.1759582833527;
        Sat, 04 Oct 2025 06:00:33 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a4161bsm181597935e9.16.2025.10.04.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 06:00:33 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH] eth: fealnx: fix typo in comment
Date: Sat,  4 Oct 2025 14:59:42 +0200
Message-ID: <20251004125942.27095-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in a comment containing "avilable":
replace it with "available".

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/net/ethernet/fealnx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 6ac8547ef9b8..bf72fe6ca187 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -196,7 +196,7 @@ enum intr_status_bits {
 	ERI = 0x00000080,	/* receive early int */
 	CNTOVF = 0x00000040,	/* counter overflow */
 	RBU = 0x00000020,	/* receive buffer unavailable */
-	TBU = 0x00000010,	/* transmit buffer unavilable */
+	TBU = 0x00000010,	/* transmit buffer unavailable */
 	TI = 0x00000008,	/* transmit interrupt */
 	RI = 0x00000004,	/* receive interrupt */
 	RxErr = 0x00000002,	/* receive error */
-- 
2.51.0


