Return-Path: <linux-kernel+bounces-738356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B64B0B76D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9565C3BCDB1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48F221FB4;
	Sun, 20 Jul 2025 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcQzjK4K"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F0219A91
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753032890; cv=none; b=WWS6Z0DM+pt54xbL5t6HNTdk6LoN0sNB6fgbVIVD9O6fZLL/Q25M1I0v6INTfpHlyf8bmOB6a+vZnQm0fD0ksypTZbEBXi4hQxv8hq09LMPH4LF1VY4l8jPBZGaMkUB0imgSYwWmLDMPv9CSLo8YtaoYMPbUE/ddjqklJW3l8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753032890; c=relaxed/simple;
	bh=WYiPAll4tY1OAECznw8fHRxRO2Vrsqio68NfasHC/Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLuCusVxiRLTOpv8TXOoZ71LEYI9HijL2MuVcdr70xPVNv1mGTXES8sxyitni4CR+VBsL/RyZgj8pmxxycW8wuoO9qOO4CCHgzHDVtsnc64GcUnvyAZcgFRr013jG7upie9XNsj6CS4ygdVv+uqbpuotjndVCcc5gD8KooEjIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcQzjK4K; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aec46b50f33so637399666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753032887; x=1753637687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0rjwniYbLc2oomqWt/74DXQQMaXpZxhV3eVwursaB4g=;
        b=AcQzjK4KxXMSzz+ZLaHqjrkdiUDomULbRdam6YNqbROYAgQaEd7bDzA7Fp+Hmm/fGW
         dFepRiTZXzPEZtzYY6iGxEmbSt1cartOwqyBIf4J4C/PwdrKtSZh6RpwBtv6fQNyOs3p
         XB+bpaSC2b0/ez2zW/VheK8wGBIiW87woBKWHiwzmdSYAOi/igcv30YmuTa8sd2hPmyt
         8Ypfmg7u6xqeycWq7tuDaxKGZyAVQN00RoDRAGVPQjxL7QdHYHBJZ7GK7fjXZ4nr+RBc
         1IzoxK5pFHXQJVQUcA0gfZpAX2UnmbZ8eo1D3o2KVNkOy/DTEDNuxvNVsfDLt7SjsFBw
         CFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753032887; x=1753637687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rjwniYbLc2oomqWt/74DXQQMaXpZxhV3eVwursaB4g=;
        b=Z+4hTIvmNf2FhW9WFAfb/7OKf1djxiaDsbzqWtvspdwixbqiL3/psgrAmlBaoYJ1rx
         miv4WmVKHwzWHmAwWXj6xSTWH7s3gq+nR/OlS3qVTKC9pFwbNOdq+wMfo67zVKEmXq7f
         GhiY81MzdLLmfI4AM0NLYwfFJ6YFCGrMTorBoPDGQ5d6vXoOVfVKxh7C2oY8vmxdx4lT
         XEJSVC1hmXc927+l4rUBYEC3N7/VN6D5Dpc1RpHCQ/VP7wEo0RE97BgZEDrv6Kvoc27y
         r8WAxBPYn6a1RkbqCoi4GcIKPm941dNXYIU0iRHCF6WOGEc8R9T+mUhpB1S2fF6j+fjW
         NeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUOA1IDAcF7gEfMPPrX28I08a8+wWK0NSYBMBcJ5WNgY69gfWdQWeOr5OYezhMrcMzgKHVmXFe8qDUY9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5A6kdLic5Wg1fx5uBLdy1a+HPNUFQIcC4EMgG4rnjXF5xoAH
	1ZtdLReEVXZPKCAjghB3F2LOJ5dKeMAkV61j/FGQFxaluHCreW7p41qd
X-Gm-Gg: ASbGncstZ30jT+CSymuSlT8eiGq0LU7A9YhKsq3fy8slCmaITY3ZJF+rze5F4c92I7F
	b2hqZrlW4YMwff1mh9CbqAQOHfF2naTz5M4YYJ2lkKB4KtElUkHeO6s8jlOFs7rCUQ5an4BxhO0
	urhBqBqOW+WmOQCHlZlVIs4z3/M6KycwZge3Mou0o/l+DQc5Il+Bk3t3JxZQlFBNhj+HoIqTOZj
	vxO0nLjWFF7dV3JNU0i6dt9Zzgs4IWdCFF7yr/cpOHj+BpGa5F6t4en5rZu0HhqxdaATA/rXxqB
	8oBou2ctFhK2+cSGoqTyHhqjSZSTxHKgVG2mUtleer1LN1jB5WnjrbyZp2wvGTka+4G5TGAo1ja
	EmVvQr1uby1rwS9CItvWW6oVN3WYdZnTlCHDyljrXJRftDx3yNnHsA/NNCrBYX6K8R8nFmtQ=
X-Google-Smtp-Source: AGHT+IGXQK6jIhKKcIF11I3HgYglI/oR1jVmP6EakhyNay5Tui2wXSyGLl+RONdwe1CszFyNGexblw==
X-Received: by 2002:a17:907:7f18:b0:ae8:fd2d:44b8 with SMTP id a640c23a62f3a-ae9ce0778b7mr1737021366b.29.1753032886716;
        Sun, 20 Jul 2025 10:34:46 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d475fsm526842866b.43.2025.07.20.10.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 10:34:46 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bruce Qin <bqn9090@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c
Date: Sun, 20 Jul 2025 19:34:44 +0200
Message-ID: <20250720173444.33407-1-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses three checkpatch-reported style issues in a multiline
if-statement:

- Moved '&&' to the end of the previous line to follow logical continuation style
- Fixed indentation to align with the opening parenthesis of the expression
- Avoided ending a line with an open parenthesis '('

These changes improve readability and conform to Linux kernel coding conventions.
No functional changes.

Signed-off-by: Bruce Qin <bqn9090@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 383a6f7c06f4..838d2feed883 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -258,10 +258,9 @@ void expire_timeout_chk(struct adapter *padapter)
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to */
 			/* avoid running out of xmitframe */
-			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
-				&& padapter->xmitpriv.free_xmitframe_cnt < ((
-					NR_XMITFRAME / pstapriv->asoc_list_cnt
-				) / 2)
+			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
+			    padapter->xmitpriv.free_xmitframe_cnt <
+					((NR_XMITFRAME / pstapriv->asoc_list_cnt) / 2)
 			)
 				wakeup_sta_to_xmit(padapter, psta);
 		}
-- 
2.43.0


