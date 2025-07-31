Return-Path: <linux-kernel+bounces-751492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02E6B16A44
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C191562098
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3589D19E96A;
	Thu, 31 Jul 2025 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhtyFJpW"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1362019DF60
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753927062; cv=none; b=ZEFoqHZf3ZJTaPdMf+b4QhvBOKrwFJ14GvzXYe5LjwWnH7qppLBu16tQEy/PqPGwr0TDtlthAhA2Rdi16oRaYFtMYfdL8Fqfxtrj1tXPZks3P/LpKHShT++iWdHi6jyU33A4wyR5iCF/su+krLsJD1JCM3bCuUPKo25aP+vKgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753927062; c=relaxed/simple;
	bh=OlIrL6Hog/dZ62WUrRojLYWigmmMAaDAXzFUp5n1kYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncXznA5tk67cOQyMSG1g6Tar9hw+ljwqpjrMoLl8eXz2BdRlB10k75Wk36b8HSbcoxc9hkQ8hBwpo0Hl+w/EAQRA07JRCgaIu+tv+qdgzYdiYnCrTOswJQeR/SXJ9BguZHuRqtVqKlVtPpeFpeMoQ6C5FmwSHbcj7LPWtzxLzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhtyFJpW; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso5425386d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753927060; x=1754531860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7QTTqOawBYUYsYwroOVM1dcVFmIxvBI6lYBf0iVJfE=;
        b=OhtyFJpWJlAP/3c1U/SA4qOZO6sSHicVla+/k5KSO47efk6rVArYwj2J9yHFMCoCSr
         KgBheuacz60OYjXq2OF40RtGj5WPLdoiBryEISuwZ9ZOCMrLg7MsJ/Vd+JKsvbYIxNUX
         1Cxi6p6/s1Y6eymiG06SwUGSomvcI3cSxs/VcEKwMxz3GXDE5OyfKao/VGw9/LDdbTYV
         crJvs0TkVqAkUGxqvRkdu/YnRvX0V6ddR/de9HRfd0Ey5ibVQeG+CH+fj0gjD+mXHOqD
         +IO6V2iaJ9vgXzBKzpGdSBpIbzAuRiYesrLNdrDszGty3BqrCPCCaCd+AxODVrqfChnU
         sCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753927060; x=1754531860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7QTTqOawBYUYsYwroOVM1dcVFmIxvBI6lYBf0iVJfE=;
        b=gdDyjriVwgyYblBT26goF5kyVuGB0WzMf99inE40vTwim1pAEwW/r7hm/cdIGiD9Jx
         ZtMGbAPtV3BD702vwBBDSt4KGmJ1bianskLPiDzIpyRzfkhC6EjPqaGh6AwtNm8CVJk4
         FXYKT0/BOLK2fqlh7Qgk0HzOtNd0XHatCRyHGjOom9H8qTJqEu8kzDO5jaGnqo77ZRt5
         +azZWDR6mA5ayaY7hjwmW07TWYo/um1fPsdXdKo9bgSy9i6QOJAOaU+b20kpJM6iuf88
         D/ioud/KhOoPzGjeWEQh1Qx+tAnyCWGilA5pTHhwGRg+khM+tvW+mITpBS6Kl0RiUgUh
         Hn+A==
X-Forwarded-Encrypted: i=1; AJvYcCVmBQ8NBgVcadrner2IEjPrtK4IqL4Janq5qDipbrTx3cSvxDtBOWQV9YYOnH5CVaYhNkmveZAQvgk9bz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8LldnaRiTUZs7005d8KkPVrqx6LIUXKzJlCFacZ6xBIbH3dR
	mQlbDLqPdegoOW8v1MZLawjke2LBsuGJEAfAJnsIxMyLoOVSP8a1IVCo
X-Gm-Gg: ASbGnct4OBJGyST0BVQQQsZNwhwGPhVpit2oNUs5DCaPkzdDZ5Rx7r25N8crUt4VoU4
	t3Itn3nt4dxkav93eUbdDTKspLQQuqqGs00jtF8Yg6sofGLG3oSTuioDUesUDf3tjpY9xhqRW2c
	dsBjhHI4QP8AF6haSnErl/X3qNQpI/DDdlO5lVvjA5xMuTZuB4TZoLDqGGAlabt7nqzVfqGkgXA
	YkBzGR1GsLV4qAispplkP8DGWLbJfcxHsHcbreaV/cG4N7iGwMl8m3LGWC2TqMhskUQWkUwDGpz
	LcvGL3jQ/7DAA8qsRWvK4ZGX9fiQL2+6gXclKw333wt98TBw6gzZ7X2EF7kiUW2bs6K4DcdaYmR
	1b5UBGIgYSjInsQSVP/iQwm6bGzVRadSFqhQgnEklcAGZ0fYa5TI=
X-Google-Smtp-Source: AGHT+IGjMfT/cnEX10j+yG94taSRt9Nkr0BsX/6+hEgWyGGKuzSDLcKuHqrgx33PocGhmVFujg6VGg==
X-Received: by 2002:ad4:5de7:0:b0:704:f7d8:edfe with SMTP id 6a1803df08f44-707674ba71cmr73600866d6.51.1753927059737;
        Wed, 30 Jul 2025 18:57:39 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce6ed90sm1335936d6.89.2025.07.30.18.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 18:57:39 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Markus.Elfring@web.de,
	vivek.balachandhar@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Thu, 31 Jul 2025 01:57:23 +0000
Message-Id: <20250731015723.507092-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730080323.491138-1-vivek.balachandhar@gmail.com>
References: <20250730080323.491138-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove redundant parentheses from a function in an if-condition.

These parentheses are not required and violate the kernel coding style.
Dropping them simplifies the expression without changing its logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
v4:
- Clarify the commit message regarding the removal of redundant parentheses in the
  condition.
- Use imperative mood as recommended.
- Remove ambiguous phrase “around the function call”.

v3:
- Improved explanation of why the parentheses were removed as per
  Markus Elfring's suggestion.

v2:
- Mentioned the wrong version number in the previous patch.

v1:
- Fixed incorrect wording: the change was not around assignment
- Addressed feedback from Markus Elfring.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b8d72d28178b..7552f7e4d14a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -699,7 +699,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
-- 
2.39.5


