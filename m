Return-Path: <linux-kernel+bounces-881506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B7C28584
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 19:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699C2188D8B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97C52F9DBC;
	Sat,  1 Nov 2025 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCW4y7dR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864927466D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762022142; cv=none; b=qt3KJEVVBsXouBUHzl0pfN57fB1C7V1i8BFLkAA5uDyBQ5E6dndD7sANf9j3PPp+TDZ2/UrPB3bb6oQuFqyOTI2x7E2HXiHfjLwC8Zs++LQNfIDeufwiSSyXUjBSEROIL1WcskGJwiCu3FfTlLDiVp0wMqRM8v5XcCNM9h4LIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762022142; c=relaxed/simple;
	bh=4sUqxa80eDuptdCLV+9yUlpRXQVSwLs4Gf5XQWScT+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+mxWBqQuSMjgJFjKmKEZcUFZvc9jHuOd2KJBsNzlkrsBjZ7joeDA1imlLwnLVx3hyIYWibQafFM+qp6qsorvbsPpe0B/RzdksaY06zrdZ2eHZa8l+SvJ7BptxYYuchnZadfFrQ4VdD0Ct5BY1a9WPk5vgX0Iu9lWZKXWPkuADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCW4y7dR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475e01db75aso20158575e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762022139; x=1762626939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFcBnQWmGxUHkWuOHMhhl9sQofbkx4ng+ZfaT543MNM=;
        b=WCW4y7dRv2fMFk5KQolOvjP45emeJn8LXvKQUkBbPyl2W882te1oSPRPpLnxC3qXqX
         waU7vZ2g1Nx98CMpO72FHFDoVeY2GYOr47wUSXzSAr3ouhY1smGZhx2SJl47oWtKxFXD
         /wCPLw5Lha9Ucs4OKFHJ44RJewakowUuVt/W+pkyObPjyd3XQquuPlzB3KmLu6fG0pqt
         /eUfwrLtguJKDARBbewCVujxAnOBfAZEEZjqhEpRRtp2mkdlfqtuaheCYqm4UFtl8Mef
         Sv6PollxLXtLTtITTl6cAqe9PyX/cOq69j47v9s6rCwWeaRfDbRj28Uv99uljRTkvLOC
         QcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762022139; x=1762626939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFcBnQWmGxUHkWuOHMhhl9sQofbkx4ng+ZfaT543MNM=;
        b=nHsiEjS3cvfAv2r23ReBOs0u0wpJIhqM/MeEKsGsyXkdXaiHvKU0lBsF64jVDIpgNZ
         rYxrV1EPPCIuRigrJUH1nGIdOkD7VIah7uK2WrSdu01BX8ktX6m4GFe/uugPd2Bkn+sm
         nqlXTvAxLDxcTJfNOz7s8Uh/i1XWDXe4RNLs46G+NfsqhMJlJAoHTKnaJ2QNHpX5c4WE
         AfoRwLlfurVZUrnnGq3iAWMnjC85w+Il4ettVzOlpp32Wz6RmrMNvZY5w4nhFWGDnuuk
         YbC4XCGBCM36Ro9puWdNJxdvjwZcyz5tKsVMxSvyMurX24KO9q1T2hX6TKgPGBm+vC83
         z/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWbyrIBGY9IHHwrtq+oBrY0y3p2mpWuan6EVtNHnp77smvuoBwsOFsCjROF3NspCRW3TKVjpuumzDk6Ma4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8BIvZgcacnFZrqfIL07n9bHgYpJ3H/hucFnOprKWWgw5uRLl
	JCjm+qMrXCuVQbr1tLb9Tfh0/jqWkJ97E0FzVVHsioU3g0FYi1L14o6T
X-Gm-Gg: ASbGnctGHgJ/rjo5JOZ+onSRLtaplVZGGXsz7c1sJnuEK5mkfZVpk2P8dI1FJMTMGLa
	KTtz4++3im3TFIWXaJZqrc9wtEyB01B9j7QJ8ULiFoUgoHza0CXdE7bveelsmFmJzi6kD5Ea3au
	BWxQJ5XBToL7dUdNimAX80ZrAd+gIwsfkrC4k6idTWEFfWx9tFLvoq1mWzTINcW/KAKK0SB7zqI
	FN+XlZTWhCgnbZSV7iM5BO3LeqO0txL2ZwM0qOHwEmpTzr7c1ShzJPPBE3WSgSo0KQop/TMJTFK
	riLOdTpl1g3D3RJliJJEvKQj/Y5YvAOBZbf3JjQJAlfX93A7ndcZh2YgTac8XAxZH2PshrumjyM
	r5n5pJSnLR4ocBT++YYY34OCcJ1u64GtcFGcKG+MGl9wQblAgdVX2eAHKf5Ti/QZWG/KssLyjE3
	e3OyQK8mrx8Q==
X-Google-Smtp-Source: AGHT+IEv2HySmX9ZH4mesehdWb7wgnujM5Ajti5lbRw0Mrtv6PqNuhJysmW3Q3uyqD2pSUVf7SrbXA==
X-Received: by 2002:a05:600c:45d3:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-47730813642mr73186695e9.17.1762022138469;
        Sat, 01 Nov 2025 11:35:38 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c4a812csm68881265e9.6.2025.11.01.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 11:35:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: dsa: yt921x: Fix spelling mistake "stucked" -> "stuck"
Date: Sat,  1 Nov 2025 18:34:46 +0000
Message-ID: <20251101183446.32134-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/yt921x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ab762ffc4661..944988e29127 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1131,7 +1131,7 @@ static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
 	res = yt921x_reg_wait(priv, YT921X_FDB_RESULT, YT921X_FDB_RESULT_DONE,
 			      &val);
 	if (res) {
-		dev_err(dev, "FDB probably stucked\n");
+		dev_err(dev, "FDB probably stuck\n");
 		return res;
 	}
 
-- 
2.51.0


