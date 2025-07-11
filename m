Return-Path: <linux-kernel+bounces-726965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A39B01374
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF051C476C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECBE1D618C;
	Fri, 11 Jul 2025 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZytUhUt"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC5A92E;
	Fri, 11 Jul 2025 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215004; cv=none; b=Vw1j8xiHUMjDa52I041JmuiVqwKHTV4LK/SS8GiFXef1QwKRy2Cb9CBFsBJRzsPGmE5lESGPSpgWPsh7bl3cqM45cIXLCx/GksBwxn0qQU673yKj+YgopgSTjSnd6THaddvEu3uG4hPL7BBsw4VmcNg4Dgi7B099pEHRv0kG47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215004; c=relaxed/simple;
	bh=szAjdjboQ5FwGSMhN8orxJJF4cMCxbolT75MC3iNp5k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sBQoMH6q8Ab6tRdtJM+cVuJyTHO667299nuPzduHvnpw4YUDlDi4cWyGDEcimwl7lVN/93XHNPycLfyd6aG5OH7ETKwdtA8PCbkqDxBN9IBhLWEnzffZv8YWUTf3KKqsym2HlIpUP9/jL4Ngj0kmyslOvZyPEHNcG4Q5pEMrc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZytUhUt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so3272065e87.1;
        Thu, 10 Jul 2025 23:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752215000; x=1752819800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=73xlXjihTyB3gi8nwM7Cu3RHQ4fBs8QJHOkXmIfesdQ=;
        b=BZytUhUtnXqFcusbYukIMFyp/xBfn5L/ypHEz/gUpH2zZojg/gA5oE74ymwRht9tAO
         jnB9s2CrNbzB4GJEuQ6MCvSMNzZxi25nsjlt4C4JDJ7KyU6E1nv31xc9PuM49hx+bzpE
         2nEKdCpjgnWmYk6bJ7u27iThg8Nfq4zdnUyx+QDo0AdedMSpICWKDqxHdJKpW3S036CD
         lErjxXl3+TzIhRi1DUS+Gpv/SXCfOj9fPIC3+wkrPiSS/nCx/BcBlhlte0h3TC4V7d6b
         Lg3KESYVbwNnl2Ya02ajj1FdGkqFtYHdTOCn2uO9nqgw4Ed4kPEgeB+2au4fTojnBQc7
         gulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752215000; x=1752819800;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73xlXjihTyB3gi8nwM7Cu3RHQ4fBs8QJHOkXmIfesdQ=;
        b=CEQtCvVWPxeqeDImCcTEW2YQ/H6LB3yUtNBZVF+BicHlGXoyR2g6xZ3v2Jdwag9rbj
         cHoIJWT2w4RGGSRzwQL8sc6qXbhifJTug5pisnwU1d3z2MzNdfUhEsiDrsiAdbfuBtzK
         M1J5TRs6BCPmJVoFSRHZzDuLBYwgGaj/mpIwUXjSHkJaQLGFDXtlec5FEVPofs/MlpbO
         OprER5l82YREqq2bkubnL92CWDYuTpiBTyjU9cGYwxZScEw2RItlyIjGQHHpbIGFmIkQ
         IJELvbfJEPAwThxYBUYz4AP+ulAJzcuZqbPUKl4RR4hMWbCDSzfAJT8fq+WLkg6h3Msk
         Nulg==
X-Forwarded-Encrypted: i=1; AJvYcCWxAmmdf+XH6/n3WniIbby/MO8XYNBSn9DUn40fHzOdA5MHorEmkxUtZDSY5qf+MTkzsmCTzpCZ0FD/cXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqFBJFy6osRJYcWqF1FGhGhfv3u0VynWfz9OQK8iHcUjdUHfI
	oQSKKlJR0k8uu9lwmqOcnUhmbXcME1q9QWm2+KrI4v2tzpiZcqaCKSCF/v5AViHJ7Z/RICUpTUT
	fGnXLejKs/6poWEKEwzsk064xCOKQ4jnfBRXy
X-Gm-Gg: ASbGncu0+H2i2P+hH4wI3wzxJxaSB5MrnTf0E2YF30E775nPLh6D5CXv9n58s/ZPbJ9
	9sZ8HkHhJFwxsbQUp03M8sW85rwCOjrHBehE5zhpRzuT2rbdxZSuC9VpPLXHY+7vRFkmVPL1ADb
	SbqQdG3us/wdYE5uEv2PdsWawY1pEMt1aue2mgxwPPiYXmNTQgqVpy6PTclKtfJGLjLbb1HKNSJ
	sBCq7Qes8VXtUKT7KQ=
X-Google-Smtp-Source: AGHT+IF0Fa/eG1jKsN+7I1rnUtH4sziIRMdckfTOC3v5CP/wNmUpQQkJ6m0PQWnh0hliPOF/KzfH4WwOFkSAG78pyu0=
X-Received: by 2002:a05:6512:3f11:b0:554:e7ce:97f8 with SMTP id
 2adb3069b0e04-55a039bf0f5mr734133e87.15.1752215000073; Thu, 10 Jul 2025
 23:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sharan Kumar Muthu Saravanan <sharweshraajan@gmail.com>
Date: Fri, 11 Jul 2025 11:53:09 +0530
X-Gm-Features: Ac12FXytmDmkt6r0R3muScu3mvNULbCCdsKttqblHJ4F1VYpWmRd08uE-bZMTUI
Message-ID: <CAGo=CcKZOz=HHWQtM+GQEeyqGVEo+4EgWSET5FJzKTMEMtJDew@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP OMEN 16 Laptop xd000xx
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

this patch makes the mute led brighter since the previous patch i
submitted was dim

Tested on 6.15.5-arch1-1

Signed-off-by: Sharan Kumar M <sharweshraajan@gmail.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 060db37eab83..062d439e753d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4753,7 +4753,7 @@ static void
alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
        if (action == HDA_FIXUP_ACT_PRE_PROBE) {
                spec->mute_led_polarity = 0;
                spec->mute_led_coef.idx = 0x0b;
-               spec->mute_led_coef.mask = 1 << 3;
+               spec->mute_led_coef.mask = 3 << 2;
                spec->mute_led_coef.on = 1 << 3;
                spec->mute_led_coef.off = 0;
                snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
---

