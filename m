Return-Path: <linux-kernel+bounces-744856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587BB111B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BC3586985
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C802ED847;
	Thu, 24 Jul 2025 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+EF0sCl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23262222D2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385443; cv=none; b=f1nZbMmKmkvBVWhFSsCkjn3841Sp5OwJin5CUoEW5hNyBMhdVKFZ2LRsTYc6zBlyWslKeOv9+EHwkzYMLjHJNI+Nh1SxfBDomFwMjMd2YtIpTJi8xGbWaupFiye5KJ9TuI1PtycXPsBRm9cDzGYAVUpGWo2oHPR/irIXEl+BRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385443; c=relaxed/simple;
	bh=Wl/MVrfadxWCvbcWuLboGbrjuXmRyvy0BBIFUzsNgX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhERcibhDsp9QciiZx7SQKB54p58ZX4vaKFo13Ohzo+RrhiKz7mzJ45beWlHZek6hIJdr9sCCa0Xzn5iGqpMX4x9V4W1POiJfeGApT5kg4EUe2J6N4I/LZXebjBpO3JVdJAel8gqz8HV0T7PSmzf7sLBNO5Gw6MSmFohqp2rUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+EF0sCl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0e0271d82so274334966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753385440; x=1753990240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjrrUXAL6KpzkIM6/6atzGF3H/f1YResH0MiZx9rdi0=;
        b=F+EF0sCl5cjxtf6FYXzsSgDgJeRSQ12wHhKLbElkGWHOa+8I9+7eUc+lulus93izH2
         0GGV+dkUsicsvAGc7lZ8iwVEC9JD20hYzzJqHj2x1bv6VzcnFMva0fBl0/soWtMUUu2T
         C8KS9rchIWvKPLsl+cc+v5+xRTnEBh50WDMt6VgHhKzPNuXY9Ihuuj6h0WBna9jcGwOs
         x20BQjPL3wBhlMSTKkeC0bEqeXFVtmoU45DihOMXcYs8wRv+mmyhUKWXf11AIFklMVyH
         7G0fbQTAsIL8F7oR1WVreQPWX7fr4ECTLMRioNJ6JFIZv0BB1R7CXSC2r0yejS1iOmEa
         T8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385440; x=1753990240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjrrUXAL6KpzkIM6/6atzGF3H/f1YResH0MiZx9rdi0=;
        b=Eu5p04TAjUmWrri62vT4OTO3qwrmzUbS2a9ufiHUi/4qagC7zKE6+EarNFECSAICmA
         +0pvcPBbxm4Eq1iJDtVAhNtuQEEpz9kOksq7AYEZ++2+EiWkZ4xnVlGX9zB+DyPeqvcc
         TxHghACK/5KdXQi+CdpVR8ym3alWuoakTe5NNE9aUILQVQLQDoKAm//GlP+uC7oeoSNp
         uC+JLodqNbUq8cHMaFXlZyJACEkn1tfuS1Bjv2NG3c/7HaPS6FAdwK4+88ewuWqTVV5X
         bH1svp67c+7eDaJoO8CqDp8PrCwNIFxezORgvn//7vZcwCsebisKDIBsn9K3ubGZqBw2
         c7dg==
X-Forwarded-Encrypted: i=1; AJvYcCW8HNooNuesUiBOXz0RVw8O3JLP56UolsP+L8mIXUPNdgGG2ckZUVuBogTuhrzwCHZkZWQZ+P38yTnNaLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMwNC6xCbD5QGnmdBdgph7+ApYcMetSiML9Cc9gJyeJz2OpKy
	aMaIR6dOgDRJtRq0DLV08B+gvl1IqnKexvu7/+z5v4jszAcxL+ERXIxI
X-Gm-Gg: ASbGnculho49yNObXvtYKJnVcTltsEXkat+QVPYVxGEyFHJTLvi1h2i224EwK8upeag
	zlHOgxAIycURNd1snSyTJr0Uknl/qfOWCjAZl8cH37leoo4fehp7vsqpIFcpvgrwMH4/vW0uE+b
	d7Gf4zGA7zJOdrxqnm20lRaIih+ZTbQ8nqFswpDi6PDxl9dgq8cbyixd7g/XezukBSQxgXOWzZk
	D6Rbmhx20yByfrDw1QYMP1BrIKoay/IUBpc8rr462eioGY62I/6flq+Kzrcda1GEr5DIRrymbsF
	pKlLSvQUKjJhtkqIlE+eS8LChZW7PL+PjXumS9OdttUuFfxc2A3aEvzUqua24UsfIz1oeszpR4p
	viUknuP/AfXd+R5z1LfryEUlrS7peXkCvbWNiOf9lnwcGXRvjYKSeX7vuHD4FBgbyn8ujgXY=
X-Google-Smtp-Source: AGHT+IG20VuhTwF5Qk3SeHna3sh3fNvxdOmTQGCORTJEgciTsCxNA/gIN+kcwVK+d2j5WSEPuwBMSA==
X-Received: by 2002:a17:906:c112:b0:aec:64bf:a393 with SMTP id a640c23a62f3a-af2f885df8dmr919246866b.38.1753385439977;
        Thu, 24 Jul 2025 12:30:39 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6b3e9sm149079366b.34.2025.07.24.12.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:30:39 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: gregkh@linuxfoundation.org
Cc: bqn9090@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c
Date: Thu, 24 Jul 2025 21:30:37 +0200
Message-ID: <20250724193037.23910-1-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025072409-promoter-shame-8105@gregkh>
References: <2025072409-promoter-shame-8105@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several style issues in a multiline if-statement:

- Moved '&&' to the end of the previous line to follow logical continuation style
- Fixed indentation to align with the opening parenthesis of the expression
- Avoided ending a line with an open parenthesis '('
- Moved closing ')' to the end of the last expression line (as suggested by the maintainer)

These changes improve readability and conform to Linux kernel coding conventions.
No functional changes.

Signed-off-by: Bruce Qin <bqn9090@gmail.com>
---
Changes in v2:
- Moved closing ')' to the previous line as suggested by Greg Kroah-Hartman.
- Thanks for the review and feedback!

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


