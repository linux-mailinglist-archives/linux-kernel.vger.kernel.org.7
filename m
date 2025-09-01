Return-Path: <linux-kernel+bounces-795120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11811B3ED18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0906B3A9710
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424E32A810;
	Mon,  1 Sep 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYkXDswp"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B8324B24;
	Mon,  1 Sep 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746491; cv=none; b=h0O4DDRaigzFt1VOqj8Pcw41zJ6mhGsYulihP+JYFjMjoHC6PrSuJHctdBl6qkrJryL4uV82W8O/HrwHUzUH1hGQqlrCtOvYbJeKfp1FkuM1i34+voLlxD+cmCvd6VP+freDpkfN/TT+bg7Hk/1JPeotpjm0XEktIp03Feq4kkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746491; c=relaxed/simple;
	bh=ShWVHtfbSvKSp1Wzkzektxra6NA/4Icui6bqGQequak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTBboF7jz3dU//Q3a4rEBKhbqU2ZMwpLKcB/Mon+/8iEpzTpv4hWwg7bmE9Ow+/D5gknq0upA7L6cTcjiVEMBMWI6g5nyHezbJH0sEzsFGNJBoNZR73pdvd127j3YNJQ5IAJQh70NrZ4jX7yBCTRblzv1u5/kitEdyw0pdIl/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYkXDswp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6abcd26bso3386719e87.1;
        Mon, 01 Sep 2025 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746488; x=1757351288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIaHO+TwV8qrQZtm48sgkMY1UhviMFuJCLf3J1fvy7k=;
        b=UYkXDswppjuxOJJ2SLlzuRkG36UZQpwKPherfRWJZphou6lUGzCfDFoGT/9lsPgKqC
         VtG0T2Bs4TjaUR6U3cH3HzbgL5hDCwCu9xOamXhdGJSJqCgGaxEFpTtoQLcCSp3X4ara
         ywkLf5pQdScZBFEV5yB1PxuGBf6RibeCOQCSPtV76B3b70Cxq93F8Zv80p+7tjUaM7KH
         DaYi68y0RULuVQKsNKiH9cQRzCtvUdklb73EfjcrtYRu+whnGJ8Z9TYWGH7ZDTXQqNEx
         N+Si5H1hLg/S6jAVeCNbRDCAjap9fK1u32xiKGVQI+KJZgVdj+R/Pxm9w9nC9acFiqT5
         G9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746488; x=1757351288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIaHO+TwV8qrQZtm48sgkMY1UhviMFuJCLf3J1fvy7k=;
        b=jEH+I3ABpGtdd2/otVu86MyeCibIA0+5MhFRPqg7evUe7Vl0RyCoQ5apaw1XFZ+nkm
         xUEMaWbfPq61ln6GmO9ExB3BiVqM77spv1JkcTFzTZ4kU5mfKprNZMORR2/vlyxxvL1x
         DQlkqNsKAVLKF41qDNgfvpeqChEk8PXrVKWDE4fk6V9Th1JUeDfYHrg2OAk9BnmwTGsG
         rT7oSF115RF7YZy55bs+dQIhdUf6A2rAdeg2yHXZ9+4wkAjXvpWjqatD9/YUbe1Zc476
         4qB44WWSh8kb7DHTokoKOYeFqVQLu4yV2ZM8j2Zuh3XRyY2+tG4RZQf8xM/1/sCOuiyn
         BPQA==
X-Forwarded-Encrypted: i=1; AJvYcCUNdO6825wBCiPyEoOh8z5U6mEcQ1fFmSMUQVhokn8/eobO47ruxAcecosevuPq5NpzV5PfTuOkUCpMcnSt@vger.kernel.org, AJvYcCVDHS/jzNLKqnCnrgJ3Vl3wqKYeS+KbF+bf/Ne59G8aRv6Or+kFUh0PHBt/uapQs7JoSPtm6EMYKtVi@vger.kernel.org, AJvYcCXMJopwj7nGG9w8wZsZDyPxS2sGq6TxeSYUoSo5CQvjtMtBIXfNBiU8tmQGGN6Xe3z7IkjSIfQLu5ku@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhMqUaGdrtFhExU34KqNq4MLDY8D8IUmmx3ii6p3d7YnkgX7T
	1BxmlpRg+tsxLlTiEdFu+z3MpCixLAhz8I1svwbBF2voWJ7sRCuxCYqhJ87nkA==
X-Gm-Gg: ASbGncverQdI7omIX5PCsC8m7TiSiXZZBHZHZGToUPAqhq3YyPnF8b4xoLQzeOndAmj
	RwyFweN/crwTkze9KfI+aqZbGkOFm5EtTwPHlUMyp7HN2s6LphrgJc3jgVc7EvjY51oREJpuXRR
	uHg7Jpj5FINa5asSNF7NDLTM3uLar4S9BMngsXSXenFCo01nERDmngaF280MXj6Yiv7kAYpSItu
	ztXJHda6/XxQBEJmDHz7ZLGdwVsofjwXbWzLgkUAisQrWHkyC/1Dz1RgQeAK2LwaT9fI3w3XWjV
	zFOTjxMBlHdf+Ua1Au4UlnO2jgnXf4YbtDs5GBNXV5FzBCEkoW4eG9U0WjfAysI/HBXV3mUr/Qr
	G3tC/GrU+4SuJBYX4SLTlff+mcxd//WJOB08=
X-Google-Smtp-Source: AGHT+IHhwvId2J9pf7PVG2bGH41WlSGZXM5dvCtIJzYFDqjIQLhxbskjQn0gIORP7TnwsHy0EeM/aQ==
X-Received: by 2002:a05:6512:660e:b0:55f:49f8:3f98 with SMTP id 2adb3069b0e04-55f7092e871mr2218688e87.16.1756746488208;
        Mon, 01 Sep 2025 10:08:08 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:08:07 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:10 +0200
Subject: [PATCH RESEND v6 4/9] clk: bcm: kona: Make kona_peri_clk_ops const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-4-c3ac8215bd4d@gmail.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
In-Reply-To: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=ShWVHtfbSvKSp1Wzkzektxra6NA/4Icui6bqGQequak=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLJj+erti+mA0wQFFErI2hqrVeFvJTnwlybj
 Z6T74PABM2JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSyQAKCRCzu/ihE6BR
 aNNND/94vKJ73PSNDIrUkl9y6WJsjiijRS5IwyExi9xi/7Q9K2ZbazCdzkUGd5uOjZAy6Jc4eVJ
 k7Na9poxZ3ZaGLT0tDJUASoIiog9ZKoNZX731DvRmg1aIa8xIoUaRRztg/8+gmCcih1goKxMmF9
 3QiNChCQlmpGpw/FQ1OvyLGPT1xwVvgUipFJPelxrjaMi7E+jqHcXmriyfbaA6e9NYPvl7h+lVo
 aWA6SDdWOUWKID7jF1fPwn8+woYfoZY/f1qzpMTKgBLznchUTTmk5nLYQ819sLfOim2ak9QwVk6
 Ss03RTwFONIZ2kZCeJ6WmJfV43BCmqfWeozc26VR4tjKu1zxgHxcNargMuc5oR5ycXdIyImP90q
 v6PsbFIVYukBAkrA2f7PI0EmEoHVAtsMWqBH7noFmpw1dnLKglv5WkmfUuUal/m1K2rfuLUplZ5
 5rZzxvxCKQxBXmnzznRI6k5sVF0CTG1FyadpNOp7MtVzjvsxsvtpcuNhnCx5BYVsCqRKSl4h+Eb
 7ilD/wXreHgpkrEqoYN0JbUyDhAcDow041gnOqhaBAJJQ14K6qX/Md5s7CDnNu7x/ALYgwwOu3k
 aECX9VhsOInJRpyMqdPJsrN7ViEJLmoQuCtWxKiwArdzcidoiXbfSIhTlCpxToG1utWnCTAEL9s
 AilSZzVC8Scz80g==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Fix a warning raised by checkpatch about non-const clk_ops by making the
relevant struct const.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Add this commit
---
 drivers/clk/bcm/clk-kona.c | 2 +-
 drivers/clk/bcm/clk-kona.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 0171e6b2bfcad51a91adc15f41405aeeb351c260..2641eaa4ca52c2724aa1dc9b4bdcbee5bcac95e4 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1154,7 +1154,7 @@ static int kona_peri_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
-struct clk_ops kona_peri_clk_ops = {
+const struct clk_ops kona_peri_clk_ops = {
 	.enable = kona_peri_clk_enable,
 	.disable = kona_peri_clk_disable,
 	.is_enabled = kona_peri_clk_is_enabled,
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index d7cae437333c83e05b2960ba8d51e718480e6155..7064ce316981ef8f32cf20cd4cf674e5f0169101 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -487,7 +487,7 @@ struct ccu_data {
 
 /* Exported globals */
 
-extern struct clk_ops kona_peri_clk_ops;
+extern const struct clk_ops kona_peri_clk_ops;
 
 /* Externally visible functions */
 

-- 
2.51.0


