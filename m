Return-Path: <linux-kernel+bounces-747685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814DCB136CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E248A164404
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30A623534D;
	Mon, 28 Jul 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="iHO4WXGY"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75C1D63C7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691738; cv=none; b=eNuy838dF2t7IVogFUwkupgVfeEtLs7uwfbOEj7c8PY8EcGtgN4Thk+D6CPDBcK1oi3w/VWmT5Xvcn58QgnpBDuUvQwF0ogoeH1888p6w/uq776nuGDr7iJjh4QcugUTbTH7QdzhJ+zY3EECo1bbsnA/nzNn+2QVAUiNj6ghvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691738; c=relaxed/simple;
	bh=uq+ImxcXIDpT7koBCX+UcC0xIpCmcUr0MukPByOa2Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BgZ2NhacC1Zl3HRAbPkli8tdN3PoB+4WXcdMnx52tQo+ZaWzUauXs9GhIok4BwJDSpruLG10ZWAoVxj9tm3M9/rSOkeV9TT9I59ozkcocID3tTcG+69ivDHQe3NZvXrfgKLZi+TOjrCyISFLDJgHa5hGPfNxxeqDk8LGc8F24Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=iHO4WXGY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so9005263a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753691733; x=1754296533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+GMtvbjmv8Vnpzhp5frnyGTe3+Arr4kqBd4arPc9h0=;
        b=iHO4WXGY17tmTrWpKiCTGLB0bjUBddLJDr0B6lBJppd1FND0bmlXlIFlRHYNPjL63P
         M4YQ/ceoa2KK6x+u2Nr4KaRCd8ZyDpk/9NRR0l7ysOKUaZBwmVXtt4lzEKmm6ojOTO9n
         2uk4//BrhSc4jCSA2F5UtreHjuGO76NdbCU2hzAxRO49pHtcljQTc3ss+q4yNYDjwgdf
         xxiT7bfZD4gmiJ6qglL6OUHql5BUidfOyykhzo1X6ddf1eHJFLAvVVyIxVGwebxAtxFC
         px/xQ6YNoESAEQ2iq0+H/2C1flqfBRpLSX/ErTewbva/XOueJQIgDIQv21D3667OAEd4
         FBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753691733; x=1754296533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+GMtvbjmv8Vnpzhp5frnyGTe3+Arr4kqBd4arPc9h0=;
        b=FYhttbXFkEXoKjEdWtF8wX72PRnUeehRqV4k0qcgfg0wogtVWr8SAx75I55Tr/BhR8
         azYTdZXaTMURbw+NH/5z3Fh7kU3oR2wVDkiGwPugubkig5cZUfnxNG/UneeeC/96Rrzo
         3GHcaDta2s+k6xRycP/bcwpmBxeC/qfS88rAJKqHzOtSC4273ErTywBk4pltlKuhF7/r
         q6fS72mLiQS2S/lbRV3MnpAqOgfigTOQbeAT8CPco22RgO5C0uC5MJbfEhrH7nDowVHq
         mtAVt5HjCt0vCitMBZdgtkOloNnDutInLGIMZeEgZIOmbMTnt9W07dqOpcTf1kDMkwNC
         11ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7prJJ6E6OV9tXlmjAeJCuZLwp9qpJcEwFoUG2TB+Jd0MTOdxsnsjL8WaYkzmMnOjsgzCvHbGSckO6xSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9zRv0o0TlS3cwO1U/wouhut76ZT7N6+/ImsduWDyhJZYZQ7l
	JpE4uuP/8aQyEXeGC+72cNVGRw+Agh2IU0iU/R213pQTKlriBPUi1ZIiNGNzgYqUz4A=
X-Gm-Gg: ASbGnctXAbwaLWmmzX7/oZQsxobcQU+6J6BJIYD8YIjRyBZyl+2h1Jy86X+aepNYkO0
	0m1+ydZ/VcvPlqwiOJugSvIssH+gofzB9+R8e9qS3MhhM/50gn49ZWUdn7ue4T6RU09Q0SiGDja
	ft7mV3okeI7n+h4i+D7bi6nMndCgk0aoHs3+zpPqbDhSFjfaLGmuhBYy1xxjLHW6M/ApHF0Sdg4
	MHMTMb3QrgjvEKgh4AprmlfpciaLOBO33023Dz8epymWFZohNrgG/vG5dLUhg8YI3wqxKAZSLB6
	9KvKxqMzLoa1mY5Xxv95nmgr45wCpXaeWoHp4CQM/pfioDsyCQTaR4BHqV5ofj3PxOO+gxvE7Ng
	aLkc473bJ2TB++m8pv8W8NS7zotdYrUtspciyRBa43nfXd/l8BO0Z9koqJ1JYhnZgLhnF
X-Google-Smtp-Source: AGHT+IEBOjDm49OG5iajjv5/g2Kv4L9dOcAdyp+LmUUVb1D/Ep2oTi+pZ65JkiAVimwgzoOcYQbOYw==
X-Received: by 2002:aa7:c6d5:0:b0:615:3a2a:e14e with SMTP id 4fb4d7f45d1cf-6153a2ae3a0mr2467948a12.0.1753691733390;
        Mon, 28 Jul 2025 01:35:33 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500a5a014sm2968551a12.20.2025.07.28.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:35:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 28 Jul 2025 10:35:24 +0200
Subject: [PATCH] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAEs2h2gC/x2MSQqAMAwAvyI5G7CF4PIVEak2ai5VUhGh+Herh
 zkMDJMgsgpH6IoEypdE2UMWUxYwby6sjOKzg60sVbVtUA6HhCZDeLF+/RhPlbCiI6r93Ey+NQ7
 y4FBe5P7n/fA8L5RlE0NsAAAA
X-Change-ID: 20250728-ipa-5-1-5-5-version_string-a557dc8bd91a
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753691732; l=1189;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=uq+ImxcXIDpT7koBCX+UcC0xIpCmcUr0MukPByOa2Mk=;
 b=G2dTIgCPaZQDwhSQBS8d3RRhaJYTgThtBtF6HvSRKoozUXXxKyIRBsuhIuvD5vSc+6YhRgF8b
 69DChLOqCBiAHNo5Qr44J9qFsvTOU6dnTVrTZzCAhGRVB9PCbSuTTns
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Handle the case for v5.1 and v5.5 instead of returning "0.0".

Also reword the comment below since I don't see any evidence of such a
check happening, and - since 5.5 has been missing - can happen.

Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/ipa_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
index a59bd215494c9b7cbdd1f000d9f23e100c18ee1e..a53e9e6f6cdf50103e94e496fd06b55636ba02f4 100644
--- a/drivers/net/ipa/ipa_sysfs.c
+++ b/drivers/net/ipa/ipa_sysfs.c
@@ -37,8 +37,12 @@ static const char *ipa_version_string(struct ipa *ipa)
 		return "4.11";
 	case IPA_VERSION_5_0:
 		return "5.0";
+	case IPA_VERSION_5_1:
+		return "5.1";
+	case IPA_VERSION_5_5:
+		return "5.5";
 	default:
-		return "0.0";	/* Won't happen (checked at probe time) */
+		return "0.0";	/* Should not happen */
 	}
 }
 

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250728-ipa-5-1-5-5-version_string-a557dc8bd91a

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


