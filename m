Return-Path: <linux-kernel+bounces-746079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACCFB122E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E8E5847FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FCC2EE975;
	Fri, 25 Jul 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLfeMeOs"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376B2749C0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463978; cv=none; b=m/2pBZXzsMym3IxyBp6rXBQ0hbTMZitt6cr1rhl4nxZ8EDppgp6VNffQ2sDMazBfvVJtnRbIC1+G0rxC6DNjI2Shg8qT3XPYkyQBJfOgW4fByBAthqsIPnY7Y8UQ72cVP6G/G2Jdqi1E8ZWFeEIX4IuW3e5SQjjm0UvqojDE9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463978; c=relaxed/simple;
	bh=Y1KSUYsyaE6HbJs2IIuCubCrplcn/uqjWMb9Oub3kMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMKMC/bMiyFN5+GmOPoi34xlah40nJT3PKff0YfleDIUfZv6e764kC8YqoZCrqrr2NlVa+1NOmkUDLccT0CEu0vsZJp2hdnU2yWPKn+qV12vhICUTgRMsOtMjyhtWZQNLKxSz7as924Wr4Vg2jE/JW054Nmo4W63dlDKekdkf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLfeMeOs; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6129ff08877so5438307a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753463975; x=1754068775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMKeCN6G97kMJOA2iye1JNWo2RzUVGDnYFn5d9NsQ9g=;
        b=GLfeMeOshPnSRKo5L/dIZVR8pqyU3ImNfOmOjNjG2h0JVraGcBJkR0nnm2TmVVmx4Q
         zKYjMwP5vukk57YdEZOXFB+0jMh+6tvEe4TF54ReiCb/xuRjipr5It+EUTLhGzt1qCnQ
         0ZNnLzlEqve56vAJqo5fUkWjCu9qBxH3jpGcpxrzexQpBc6whNix455HoI4Upp/FM8s4
         VhAzr+gS5VlDay3ImEOXw3qE57SYfBLcl2dJdldEEWx89UjcqOJgiXjuYvW4WuBsDojW
         T3uJ5XZFBJ+Y018JzbmsD+gj8eWkLF1Af+8LyZeggbh1Ohx/vCxxkgp6MWblc7QOAP4n
         +tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753463975; x=1754068775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMKeCN6G97kMJOA2iye1JNWo2RzUVGDnYFn5d9NsQ9g=;
        b=Ttl0i+TCVOYenUPZgnyKDnbHSbxRT4eueYaTKmpmInnBhlek1FO5nkzoPbXvGsMWQV
         fddH4fc2HlU2oIKXWPhQKiAMPF5uaojVHLXxX1DXgyuFWy8ytUGUelKKeVYGNyMGCcHq
         BM4jaUZsowYeYidNTNBJUt2CuEapKhZCekvOcGdKZQfXqXMTsbXJzxMBgsKJ3DAR36pk
         E8LSwP86YJXhA83fvH0Dbh8ylxPmJJNy60jIlTU3WGyPr4Ldror+8E3yP13AaO37P4wS
         yyqnOqUMxwE+RdrmKUwqygP+9irk9CDmMjAOalSUnhlym48zd+nhc7DzxUhByC/frN56
         I7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVjMgVHec4MY+UHxLVW9w8PyrbkjChkNRs/N+lYkKRyufXg/+/hf52mkIUlbeDQ/dMe5XemwPQWcHif+qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmqRJBpzgARVIJFUDyjhBp1lpQ8fZblFiRcjM8NlZBWQqZ+90
	6ycQDm+RncgcnbsACUSZGbDFBb6d2R8Of/Lpq/mTJfYHPODVRNBQDLEe
X-Gm-Gg: ASbGncvjhjcQLLX2akkQRipS6AbO00xKFsGenHtVwRU+8DtuDL7oWLAt6DZiMd8jv2l
	9aLtqwijl6outzS94+lUgTtj/25HGMzcJtiOGO1d1pQ1JxHpie4E1phmkNL1jA60+ZUVKqPTklM
	2rDEpvdjzd/PT7LfxcQBPpiq25wBxrKS5Y6ZXHF8UzA3FNWJut1Bwppm+aJS/hZ5FpCV2G/wAtx
	dxvr8CqZ/xJPSOXBs2GvsJr9wb2NNZTJq2jV2ujg6D8pE+e1TvLYYvUbWvw6Z2pRZRG5pGI/iIy
	uLjmF4lmgJek0GeTS+DNjONL/7VoZ7khuKnwynwbVoV32sBkk5exg0m1Hmjg69kOizOs9Tz7Tu8
	v5JPSCjWiV3h/hLGFt0xPCFwSS7LlAq4Co11iOykZJti55OR+Fx1eCj8FYvaoGA3DtJC/YlUSj/
	zzlqsnKw==
X-Google-Smtp-Source: AGHT+IEaEmCiIoGrZas9PLfSl62sSWOiTuZrFdkBEM7IJKU/GlPZfysTiUH5h5P0uHyk7NJHEItEiw==
X-Received: by 2002:a17:907:3d46:b0:ae3:52ae:b0d2 with SMTP id a640c23a62f3a-af61df5289dmr370816266b.18.1753463974809;
        Fri, 25 Jul 2025 10:19:34 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a61103sm18857066b.70.2025.07.25.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:19:34 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: gregkh@linuxfoundation.org
Cc: bqn9090@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v3] staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c
Date: Fri, 25 Jul 2025 19:19:33 +0200
Message-ID: <20250725171933.10027-1-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025072552-filled-glacier-1e9d@gregkh>
References: <2025072552-filled-glacier-1e9d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several style issues in a multiline if-statement:

- Moved '&&' to the end of the previous line to follow logical
  continuation style
- Fixed indentation to align with the opening parenthesis of the expression
- Avoided ending a line with an open parenthesis '('
- Moved closing ')' to the end of the last expression line
  (as suggested by the maintainer)

These changes improve readability
  and conform to Linux kernel coding conventions.
No functional changes.

Signed-off-by: Bruce Qin <bqn9090@gmail.com>
---
Changes in v3:
- Wrapped commit message lines at 72 columns (checkpatch warning resolved).
- Ensured only one copy is submitted (per Greg's feedback).
- Carried forward the fix from v2 (closing ')' adjustment 
  as suggested by Greg).
- Thanks again to Greg Kroah-Hartman for the helpful review!

 drivers/staging/rtl8723bs/core/rtw_ap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 383a6f7c06f4..c652e0cd35f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -258,11 +258,9 @@ void expire_timeout_chk(struct adapter *padapter)
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to */
 			/* avoid running out of xmitframe */
-			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
-				&& padapter->xmitpriv.free_xmitframe_cnt < ((
-					NR_XMITFRAME / pstapriv->asoc_list_cnt
-				) / 2)
-			)
+			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
+			    padapter->xmitpriv.free_xmitframe_cnt <
+					((NR_XMITFRAME / pstapriv->asoc_list_cnt) / 2))
 				wakeup_sta_to_xmit(padapter, psta);
 		}
 	}
-- 
2.43.0


