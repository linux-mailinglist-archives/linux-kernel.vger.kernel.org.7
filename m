Return-Path: <linux-kernel+bounces-750366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FDDB15A93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBC15A2D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BCD2951B3;
	Wed, 30 Jul 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hf8HJnm2"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AD292912
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864109; cv=none; b=Zq6lKj23yLSu+uf5HFV8gLtXgKd4B6Xwwgf19DLwYKt4856vb+UD/KV2xTfBg+l4vmA+1f+dGXIGeHgz7P+7TBzrtYEl8XmcC7FIHX22deu4ViCMSBIumtDc4HVpRueenVcupQCLXLvgwu16GgLchVFS2UvFzbx/5ILIRP3qtT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864109; c=relaxed/simple;
	bh=Ox0mffAq7VFxjLAQ00uA0Jp408fW3ZGQroAD694ufgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOgG5oXzsHp204XVCt6ISVo3jsXQplJl3R89ZA5EOUI9dXt2EgJZrvh4gPliAqvBaG0sWeM7Fuyi6Ur2sZZme16LA/D8BcirX3ZSuVgyWfoPnF6yBRHTicNXkStVTn5MmuuhlXck3wrmWsMWo3sP1gN2qWeDrCmf6aIS4JFSscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hf8HJnm2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7823559a5so353194f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864106; x=1754468906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpZCEzRp6axYcNR29ZqHh8YXgG+TKuUWU3bsudMRByw=;
        b=Hf8HJnm2lV+LHnmcrf5CCosuC+THz/617zHOHPythEQ7eRWUaRB07QhCy/cjjcfaVt
         DoJZ/s/WfFfzXcP0hs4uzZJKJw6hcQkQ7xuOS3ZCBBO0kLwF+d/eBD6rEtQnLDzRUjiY
         7CUP4vgkQHo7TL0lo8aTBE1ZUMVMiMEqIXinzIoy+36f1Od+0j2K0OVheO30fookC5Ka
         micKlAI7ZD0YoKv44A8DXQCrNhqmgAXenq+Q65uWvEEKVKfmJY7nSQp+6sPRZ3S44+jW
         p/mDMyHeoM2adCUEUQzCCKdQaUS27rjGa8GEdbj+wi2d/lffCVW7y6fmr3xMzalrye5H
         pcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864106; x=1754468906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpZCEzRp6axYcNR29ZqHh8YXgG+TKuUWU3bsudMRByw=;
        b=ZrccrPlk3FQFTYj1tKtoyYbnMZUNttjulVaaX3yw6Xpm4gxjpzezRHzs8k3K5PnP0P
         cZzNMxNoYWBywv0F5sE4VH/J+nG+fnhyChV4xVQWWd2s5t9J9j3HHFst1OaCVgBG4wP6
         zUZU1isWUl7NzFY3Rc/SHUAhMiN0B2xw5VAMZ1Wo9DBW6WeC87nkF1aqkn3gGxuhxGVm
         fi9UEw+gh68H9Vv6AKdggGQU2YDpHnZjmBmNcGwzLbgjFGME8YXjsrx59h9LBjxZj7Je
         Ig6SX9KnHeK7Tfy2sU8y39G/PJMQU00i+dKcW6O8Ux4FJeU6/A7y7xs4SaBrgenAXeSg
         41Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW8S75ZQbxUWofGlWhk66uzstURB8/KgeSywY+n79dwXUB1BGhc+fVxs+nyyvk3YiMGbFjmmbeQ/01mFoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BjEbZBAlXICkYd2xn3PtfgIAYIPW3z3c69i0FHrQkglRseCY
	oh9W2Vj75xzmmgDBcN6sPUA+WSUnooaE2okY5wLj6XAgjIf5CiPZGKbrBqe+33psZ4E=
X-Gm-Gg: ASbGncsGGq8ThKo6KlUgVi3nbMZX/RG63LwptSlsFz+ogp9UF8PVpKHTODS+SrGd+WI
	9xSJp1MI4nHc1rp39nktvRUReBt1rTAHMunSw/NHm14xjOfJlaVmm8WyThmgNG/opYvlvMl5w8O
	YxAGTlcfIiX6eaELJJkGoqrpbBIY7cMbeVgo5XqeKEU3xaRIa6IoLcq03Ys5kToHAKVtV2IoJZA
	9dKUn0UnJBDFjF8c2FAeTwXPp7cJLjJsBcL3ysY4nY0NZ3cpwUJvcHT7+mno85HWnPweDMfxKCf
	aYCvNm6EfdIbRq+F/G+AXOpmulBWPZu0UBhnawNb4JLpVIg0cCVlY07zQJObNE7amInF30SLuNf
	JkKjxG8mwQGedR5/DmbYqHfxB+7j31QByKOTYng6qY/vHLXK2
X-Google-Smtp-Source: AGHT+IFcsW1fgaqwmbiJOolfAUYytGVO7laPI5dFSFNlWd8LwhyGe5y9YLwst+EEHQ9Mvr6QTTy1iw==
X-Received: by 2002:a05:6000:1787:b0:3b7:82a3:fdf7 with SMTP id ffacd0b85a97d-3b79501e5c3mr1801649f8f.36.1753864106376;
        Wed, 30 Jul 2025 01:28:26 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:25 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 08/20] clocksource/drivers/vf-pit: Convert raw values to BIT macros
Date: Wed, 30 Jul 2025 10:27:10 +0200
Message-ID: <20250730082725.183133-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730082725.183133-1-daniel.lezcano@linaro.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the BIT macros instead of the shifting syntax.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index d408dcddb4e9..d1aec6aaeb02 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -21,11 +21,11 @@
 #define PITTCTRL	0x08
 #define PITTFLG		0x0c
 
-#define PITMCR_MDIS	(0x1 << 1)
+#define PITMCR_MDIS	BIT(1)
 
-#define PITTCTRL_TEN	(0x1 << 0)
-#define PITTCTRL_TIE	(0x1 << 1)
-#define PITCTRL_CHN	(0x1 << 2)
+#define PITTCTRL_TEN	BIT(0)
+#define PITTCTRL_TIE	BIT(1)
+#define PITCTRL_CHN	BIT(2)
 
 #define PITTFLG_TIF	0x1
 
-- 
2.43.0


