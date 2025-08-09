Return-Path: <linux-kernel+bounces-761167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27DCB1F530
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16990189EA6B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D662BEC25;
	Sat,  9 Aug 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e40j5O2M"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271862BE7BC;
	Sat,  9 Aug 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752804; cv=none; b=qjR1PurWJ1h7Tze5W3PASGGexZCUvbee+8M5rkzkjTkDBwicCEr/qPFUl9ASnJciMOhUh7SxR+WzRsQrCcWK1q9d3ZT6lJamknrZWuYDqnSgCwUPY7nYp5A8g3tvGbSY/Xi6JGO72qnoIP3pm6gWXe/9i7AoibBTZiLeygMYbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752804; c=relaxed/simple;
	bh=E1WeUDSwyIl9iI7BwPhOBt9jFVluY6T5CNY+ZnovgEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDwaxtRFmtkbEF81pRZ9gZ75lEwxi1LOadJBFbi9VnwGKimuA7AAl/gSiPxSjID6BJEDutTXM0KVjq3N3IaRNydoNZYSOG2baVpRbQW//GS9qffN31GgUnyuRmrrme8XujwFQ4y3jUrWBL97R+EhoFEkHptOYi7l4NgI0meHKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e40j5O2M; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso19614695e9.0;
        Sat, 09 Aug 2025 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754752801; x=1755357601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKft3vN/bPiCSDmYFyRvZdVd+7m3lzvyNOgqIIC9a7s=;
        b=e40j5O2M0Z8XnrhVaJ7KClRUD7SR5CCaxui0YpW3xhdJ4HYfgt8bWX9/7WglLByZ+a
         DwaI2nCyGOx+DunHkyWk00Sbvz5pbqq2EHyw6AzXPjk3zlyV/2Fa7ZV4DMo5XBJGjHQq
         PpKdhNzoO76RhWnQzAenYtt71IhH2K451y0tQMnlgHdt4SCnfV6RC5vOg+iUrhxNdGxv
         yOpOcaSyRqAX2xBpc3+foZwkxwaFGlLM/Cskk49Doq/m+d+54U9MMlOoEaul3BfXQ0fa
         3KD3MJnwRJ0zz/1tv7/9fcRtTy0Ee6YSQbBmsbJisZSWhtT5PT/uodaKQmavw2Fhr4dh
         vHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754752801; x=1755357601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKft3vN/bPiCSDmYFyRvZdVd+7m3lzvyNOgqIIC9a7s=;
        b=mJ301ijTZSm4Qo0ReDk2f8XWvxfYICi9MoANNwBkcJbN2XitrOELCO2JXf6B8/lXed
         X8dnPUGgVEpdFsId0UFwceEv61AvXqOrU3zVxGXE0baUnn0vTYytIATPJuM5IgVpe4PW
         tLsAq9r4811RwsN4nfk12j4kJUkt6QkuWuYQNcTugRc1heknQ7I9od11+lMXARWZB8Jr
         KOjJrdgssc+9vtLZMn2kK71CupcUnrXppVjr5GHLnLAVcVYf66cgSfvtMf207M6fHyPB
         /7FZzAkFS/TZwJv0OFDQgbJev+4u67irbqrGwpxuGCQHbT+AQ5qh1UjSDd+HhAtym4sm
         JGNA==
X-Forwarded-Encrypted: i=1; AJvYcCVR+P+fGTqDdOPcsDzo2m/UHX9Z9Lhm1F+v/bCUNkp/ryr/g3qgfBe9mmr11Cb2OpqGsi3JX4o9E60v@vger.kernel.org, AJvYcCX1eb4LQG2QCpPJ9C9aUBYuy28ioQUYsC0+P2pLphmasfV/Z3V7y1WRpL6THT2ZslT+konfd889NDHPJgbV@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2jOTW8TgD3RIYLVBwVTPbj/wghg6dbr9M2FI6wOkJ637gUki
	qps2CAbEGSgnmRzcUnEJ55ZqEujHmpWyVsoYJHxs3iQEPwJj9NdjthMOy3ZNV2o=
X-Gm-Gg: ASbGnctCIkZXKE2k6K0JSKnicSVgXZYPtkiPzy2tNjC3Z+SPDKy9WGgnhihNe8Y1/Hb
	lKblW55sx4Fym01HLiZApGDawH6sEzyu4Ffbh5L/En30XtGbphd7GT/zcGN6crHNvwPonZJcQUQ
	BmxFaMGChXIJki8qME49yjmu1/hI7QRz9U60/tvX6/ZL1FcYt7aKHHlbsMYe8jZPag9nCfFCI/x
	hZfm1BEuAV/JVPlCv/8IrxFP0p7LcYJZO+FnDQzvUzvJV+oRKalWzWgjmjADVB/B1jPpRQBoHwJ
	hW056eLGwpHxqF1hikXI26bDweWf1zbtSNCEVNcLgXaaNnwBK++BknM5/x6E5IGbSEqq2uFDOsA
	sAj52XDWRWz8inmFY/dpejjjL/andcAudeuej8LPpLIqSxrk=
X-Google-Smtp-Source: AGHT+IH1rGpI0BB4/akEwTukJA+QWyZ5KPP8BOoF9oC41Ha9wM14LjCiYpVbdqnRpjMdC04qZfRP/Q==
X-Received: by 2002:a05:600c:444d:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-459f4faf68cmr54366885e9.23.1754752801040;
        Sat, 09 Aug 2025 08:20:01 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:156f:b6b0:b8c7:9296:47d7:b0cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583ff76sm178748185e9.5.2025.08.09.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 08:20:00 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-sound@vger.kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	drake@endlessm.com,
	katsuhiro@katsuster.net,
	matteomartelli3@gmail.com,
	zhoubinbin@loongson.cn,
	KCHSU0@nuvoton.com,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH 2/3] ASoC: dt-bindings: nau8825: Document routing strings
Date: Sat,  9 Aug 2025 17:18:52 +0200
Message-Id: <20250809151853.47562-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
References: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nau8825 driver defines several DAPM widget names that are used for
audio routing in the Device Tree. However, these strings are not
documented in the binding file.

This forces developers to read the C source to discover the valid
names, which can be inefficient and error-prone.

Add a list of the input and output widget names to the binding's
description to make it self-contained and improve the user
experience for board bring-up.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/sound/nuvoton,nau8825.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8825.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8825.yaml
index a54f194a0..cb1c82aa3 100644
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8825.yaml
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8825.yaml
@@ -9,6 +9,18 @@ title: NAU8825 audio CODEC
 maintainers:
   - John Hsu <KCHSU0@nuvoton.com>
 
+description: |
+  NAU8825 audio CODEC
+
+  Valid routing names defined in the driver for this codec include:
+
+    Outputs:
+      * HPOL : Left Headphone Output
+      * HPOR : Right Headphone Output
+
+    Inputs:
+      * MIC : Microphone Input
+
 allOf:
   - $ref: dai-common.yaml#
 
-- 
2.39.5


