Return-Path: <linux-kernel+bounces-791089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A5B3B1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF783BEADE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7E422422B;
	Fri, 29 Aug 2025 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMZBIYk7"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907D27453
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440573; cv=none; b=X2HlTfm3DkDY0OGDdY5zxxF+DIg5AfBD4qd2MVGV30QmHYO0DiWTMd24TP54MfhneCqdZqM/Dm7NsH7zI+masPR8gN1Fed+agMkleppq0/gXXniuc7Uy4UpuRLDOQOqqA3COAPDSU8IVGMeqTMt7uN44uFDYX/w6KY81rKsdaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440573; c=relaxed/simple;
	bh=VbLWMAa6acx5ejY6TBhR+uSr38oNnrdZTUIbkKIB8Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMUCLzm0pGKtWUCx9bikAa6dyuCbzk/qfutFGin6db5G65YZUIXuYSlxaLpLJzw0UyVNeK+teOT0FyOEODbg894hEv1K/NZNmNkEvq6K1ZizS6jzO4MBwzkJWkWaQXAk0KgnSBkthUw2ZRH/4HX0PNE6RsHBgA/TE/6qMI6wUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMZBIYk7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e5f058so1347584a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756440572; x=1757045372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juXpC95OIbgk5mWrCIY1LfWzcgsNmpuy8GKzhajuZfs=;
        b=bMZBIYk7Fa7v39HqapRFM2X7nv2wjvFDcY4wbvgGMWwvXo6NqvChyYPyawRH3OSw2z
         x/wzHpZaZNhNzr7Dr+klaO+GL2WJTjNcgC1e2Z8HSOF42Emaut1+wTa75cmh0BnwsPr+
         yH5oMS0IQmpeFgB9eMcb1/aBr616l5w2FZoJ4D2MDyn8niImN9QKSTHY8Ou7918a02q4
         YbBO49LZOWoml7M95DDNDadUdmZUYwq+0l2ALsJuubIYOBowijkICRGNZMtX/kFwOE8X
         UGaiZ5UkXN5RweCtZWIomPhmJ45a6hc3ZkjsiNbK7gLW+hWi93ZNFMY0za+W2RQ+xfKA
         Px3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440572; x=1757045372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juXpC95OIbgk5mWrCIY1LfWzcgsNmpuy8GKzhajuZfs=;
        b=JbIcDDgaDf4WwvGH6DmPYiXTeT1T8lCL1uOGZNnflTTsZZaDkQNSmYYSAV5JpRzCMH
         IOxPeIIWv9DPfKVmMBEdGN3vqxXigjtwo4x4GYCwbKS2tKeGPxV+zhfqEjVcsRuApQ4J
         k0MdGCveKp4MDwgIpHIrf1+YHYI5cyDr6haOYy6nPGgtx+ATcPD42wQ9PQEUslt+m9FH
         +RYHx1En22B0sE8lhB7TvRi+7kpvHvFrmB8mm7eYjow31ecyO3OymFj/1q4Ra7OjQFaL
         lImd2MfgdD+aDBxRq3kxkBP8iiS9iYMvGYiWS5n8i57JfaICKaX2YJZIP7iU4cyETB1B
         BaVg==
X-Forwarded-Encrypted: i=1; AJvYcCWCB2pxPADVo75KXrCGyc8XEIXF9UlzN2tWaACTDzuVkEN4LwZu2fuMVxuVpOBYkQStR//6q5Xig16ynQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhF0o8iF7gXKTd9k/9ImRj5R5MLcUapqPMc7JdgYnV7a7si5G
	gOspCAoponOkTCo3OZ65zUmpMOVntJuGC7zqewL+/U0uw0G27/MMnljE0EaTFqK7
X-Gm-Gg: ASbGnct+V4LBXJGekeMbYi3AseaCZa/l9R0b+pzxSUmE1GEMIx+A1irJvTkoJoe54RS
	xTpP9SVQCB9Th1uyKDaTs1L+bwkiVqwmLO1tw/wZvwCK/veGE0Kx6tjs6U0KPqg73hB19Pfmkz/
	bBrxrCDU61NqNJtifGeTAM/S2oNGxb049ejBQUE28s0es+WSgH1n4cXd4/6dNiht5aDHwSNAFyG
	PhYRZY5yU9eHb6PFOUaS1qz6TkDGPjfwxyyiWEV1zChDtZ4O/0V08vsdeK4CmKfo1WF8CSnaeC6
	z0eas5NWc5ps3xwP7vC37vmucY5hGZvz2QGQt2DTUPJRivMbsuOZHaZRBLmiYWoMVtL3jH/ZPP2
	bVYFEnD6Ms96+qB+UQGNsAVp8lA5joV9dV+WvYwKolppQo11XwHTbhPHRRVp6DjnxzWhJGBR22+
	694Si+IDd7lg==
X-Google-Smtp-Source: AGHT+IFzHL+8UdK9pyO62SKNANe8HY66WeLJkmilzlfwe3cWnaNsk52b08SVRY/6E17QYYmZpA/hsw==
X-Received: by 2002:a17:90a:d403:b0:327:add2:4f31 with SMTP id 98e67ed59e1d1-327add25000mr7600321a91.33.1756440571635;
        Thu, 28 Aug 2025 21:09:31 -0700 (PDT)
Received: from yingche.. (111-255-98-191.dynamic-ip.hinet.net. [111.255.98.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5921b5sm6771888a91.7.2025.08.28.21.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 21:09:31 -0700 (PDT)
From: yingche <zxcv2569763104@gmail.com>
To: dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yingche <zxcv2569763104@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: fix fortify warnings by using struct_group
Date: Fri, 29 Aug 2025 12:09:06 +0800
Message-ID: <20250829040906.895221-1-zxcv2569763104@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828094537.884046-1-zxcv2569763104@gmail.com>
References: <20250828094537.884046-1-zxcv2569763104@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix fortify_memcpy_chk warnings in rtw_BIP_verify() and
rtw_mgmt_xmitframe_coalesce() functions by using struct_group
to access consecutive address fields.

Changed memcpy calls to use &hdr->addrs instead of hdr->addr1
when copying 18 bytes (addr1 + addr2 + addr3).

This resolves 'detected read beyond size of field' warnings
by using the proper struct_group mechanism as suggested by
the compiler.

Signed-off-by: yingche <zxcv2569763104@gmail.com>

---
v2: Use sizeof() instead of magic number 18 (Dan Carpenter)
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 8367fd15c6b1..3d99d045f4b6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1363,7 +1363,7 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 		ClearPwrMgt(BIP_AAD);
 		ClearMData(BIP_AAD);
 		/* conscruct AAD, copy address 1 to address 3 */
-		memcpy(BIP_AAD+2, pwlanhdr->addr1, 18);
+		memcpy(BIP_AAD + 2, &pwlanhdr->addrs, sizeof(pwlanhdr->addrs));
 
 		if (omac1_aes_128(padapter->securitypriv.dot11wBIPKey[padapter->securitypriv.dot11wBIPKeyid].skey
 			, BIP_AAD, ori_len, mic))
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 8c6841f078b4..21690857fd62 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1209,7 +1209,7 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, s
 		ClearPwrMgt(BIP_AAD);
 		ClearMData(BIP_AAD);
 		/* conscruct AAD, copy address 1 to address 3 */
-		memcpy(BIP_AAD+2, pwlanhdr->addr1, 18);
+		memcpy(BIP_AAD + 2, &pwlanhdr->addrs, sizeof(pwlanhdr->addrs));
 		/* copy management fram body */
 		memcpy(BIP_AAD+BIP_AAD_SIZE, MGMT_body, frame_body_len);
 		/* calculate mic */
-- 
2.43.0


