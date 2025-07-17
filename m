Return-Path: <linux-kernel+bounces-734561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA390B0832A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A90189AB39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1D71DC9B1;
	Thu, 17 Jul 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WECOfVE8"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47811187;
	Thu, 17 Jul 2025 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721355; cv=none; b=neINnNa6dgVMGMdOpfOAhDhIrXCHuWlsuiF6/56HleGztP4oDQHH6OfqhldhMscqec8GnuSlCETk8eahhZSM83g7GOTDytZ8pmIQeuHY5c1fCZskuMfBZ3eWHu1sonw3UI3Z1iGJEetiKylxF3PnjYh2ukA1RIz7NEnCJsF/0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721355; c=relaxed/simple;
	bh=UEpzZC9VADx8AvKH0J47c0cuHbkzOYtmuPcF+qTpFLk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NIu8rXhzBG7Gw0XGYBh41WitiQykDAdH+EQNVoEq59yZIvPEzA98ENABjol3hofUmkCoGIOn8cchnT5ATYQ203mDUKUyTY9XLSnhHfScu/mk01bbnFc2+xKEUjWBDPR0H1HRKuXH3sQZ+YpMDsr8vG+1vY+hWlc8TY1YdhNaBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WECOfVE8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553d771435fso585105e87.3;
        Wed, 16 Jul 2025 20:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752721351; x=1753326151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHzOES08CFS1i6HY2KzHC2u6PbLGiIQuDSZPFpe4kew=;
        b=WECOfVE8oyfgbxfxgAIxdUAbCVZk0b9oyqJECGpUqMVVsrSh0u0odbDxAtwqsNCY72
         osxyrn+KMegZjEUNpofKe1vypvYtc1GrVMpNf30b+u6ytrbEdLMttMQISOSVRDli+fBc
         8Nxew5HbIIH8ugXfS5cKNSaeB5v/f93hvSzSIJuAL55uETvNczNVszo7iyYLXfyPm3i1
         QmgsBLhh3RWT9Tumvo1h4+vysQ9zlnZR4cXjwweTr+2634l/KnUc0bUOcjSxvVUWqB85
         9zmw7+oSP6BxXSH7hVUHjpibIRG1Ev5VhOFVkw7HGdqii4GHkjVehQ35S2VCb4YlMLB5
         o2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752721351; x=1753326151;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHzOES08CFS1i6HY2KzHC2u6PbLGiIQuDSZPFpe4kew=;
        b=rf9K6Qwkp8qaGxwiFle6ZmtycCbD82JuK2ljedE53/SSLIqysC7x3TOMxjQRR38O6g
         IQjVqKNlUnmqde6zHV8Kz7QAXaiJyO5O55m2XyMddYrCTraPWEPxJsuny4D2wRNo40NC
         rxq/AtLjJC03QGMm9PegY3WSbfcyAkDeUGVBO93uJ2fIycClQqnkdW79Qxx2uQxZSpA0
         4FzHlvTMHf903wlyx2hOLR9Q9PiNDIIwoF+3uBmYG1gWRT4+7i2gRSyo3PopwMwiBayE
         0vup4lIRwRPbOJoxFPb8BjJcO4Tiarj1wNb/67AZXkr15U9J2TkGd94PpQRJ2A2fMuen
         0TZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrtxeF4Xwx1khYPdMYWtnyVu/E+Tw8ybmnFLWiZ5RSH6aDmJ9MKfy6+JKdJHgL+ENR2cSANGQLQqS2s9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRW4K9PSqAxzvyNvAGv1/o+U/kfcFVyKAvpytG/oBgi3F5qEzf
	AXDJKl+F/Y0MZ/B+sCv/BDiK/KZzoINDtLu76ArV/QebaJdnIggRuFN5n0bKSm0iYXRCI+8iURD
	TC8WRquV2oSF4eW1naGZBieF+IiGh8KzBuGIY
X-Gm-Gg: ASbGncs00J8vekaMrkcMZI6WCI89wezLuuu0zLbA38cmRfpfdFBx5vCqIJshekySsGb
	Fk+dprFF1rPm2XPRugDjgHjpUYCXqjAfneymR0AKMpxTH7GP9K9WcpTIbbUVA+GlAZVnGu1S0YU
	qTZBL9mXOMrDPNc9i0gFNDf0952ADmqE45L+mYzhLan99lWIo5xaw1V1uZg1mRHYY4PCNAtqo1W
	bMqGqlqCI3axVf0LA==
X-Google-Smtp-Source: AGHT+IExhmDbi7SwzhDqgYL/YMoffgjLn+7bh1hxnf2EkqE7s+8AoYP2gGa5GaNbaKU9eNhH2pfx+ETriO1sWdTifEM=
X-Received: by 2002:a05:6512:3042:b0:554:f76a:bab4 with SMTP id
 2adb3069b0e04-55a233248f6mr1806560e87.15.1752721351038; Wed, 16 Jul 2025
 20:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sharan Kumar Muthu Saravanan <sharweshraajan@gmail.com>
Date: Thu, 17 Jul 2025 08:32:19 +0530
X-Gm-Features: Ac12FXwBYURCqdmZm8PzstRl4vhuG8SR4XQKrJ1aQsrlmsxcCxczPrR6dFe2JIQ
Message-ID: <CAGo=CcK+aHAYVv=tS4frM07D8MCar1CHBy3r3eg1An16YCqk6g@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP OMEN 16 Laptop xd000xx
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

this patch is to fix my previous Commit e518230 i have fixed mute led
but for by This patch corrects the coefficient mask value introduced
in commit e518230, which was intended to enable the mute LED
functionality. During testing, multiple values were evaluated, and an
incorrect value was mistakenly included in the final commit. This
update fixes that error by applying the correct mask value for proper
mute LED behavior.

Tested on 6.15.5-arch1-1

Signed-off-by: M SHARAN KUMAR <sharweshraajan@gmail.com>

---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 060db37eab83..062d439e753d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4753,7 +4753,7 @@ static void
alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
  if (action == HDA_FIXUP_ACT_PRE_PROBE) {
  spec->mute_led_polarity = 0;
  spec->mute_led_coef.idx = 0x0b;
- spec->mute_led_coef.mask = 1 << 3;
+ spec->mute_led_coef.mask = 3 << 2;
  spec->mute_led_coef.on = 1 << 3;
  spec->mute_led_coef.off = 0;
  snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
-- 
2.50.1

