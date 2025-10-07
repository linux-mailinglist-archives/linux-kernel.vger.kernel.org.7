Return-Path: <linux-kernel+bounces-844020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AA7BC0D87
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7886E4F4053
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59732D7D59;
	Tue,  7 Oct 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="gE5SKJLG"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2852D47F4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829017; cv=none; b=Pt9WWGM9Ab4y8ccoPVSb41MCl+xRxuu1X5/ZUOBLGNdDt020D6KYOccqghmkRYlrlxEgum6tAXKCP9XwuFmi0RuWMRmeMM2nMWtkga3dxbwVF8fPVIfAoPk2j42uPO3BaQKF0kh56xpiebiZgNqKuMvif7rC1TgECcQTAlfNn58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829017; c=relaxed/simple;
	bh=9iwZv0wYDbzvIZ5Up6VdhboaKwUYPQiP3otc/vKRzu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckF7+GZ33h5EUnsM7lUlc7OwlVNKQRLn3G0b6WyXcx+nIAmP7a8DbcIAWw0k54W725QVt8QKWrft0XcSS32JDV8w4CLpYKdFvxu0+HcHRCtyBA06coFxBC0HzYEFzH6gXCO5KK3yX0plrjVbc1W2c1IQm4/Xf0/UqDubmtQ//uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=gE5SKJLG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f1f29a551so7617379b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829015; x=1760433815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHoR/Ijj1qmGQhB0Kza7UoCwZFMroh8xGGX2gtCM/3Y=;
        b=gE5SKJLGVH/i3oAd3vgZ2l4lE6mIFcUOI5R2GKIZfSoBRKmynN2OHzr+UtqHZz32FJ
         HU/3Da7z1g/b3RU5TqEFD8AZQ4h/75O5OR4838OyaI9R3pKWhSpWZO9SennjfzxGLB18
         8WpovOacGY3RllVg72IJmC2JcyqJNGLy8+59Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829015; x=1760433815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHoR/Ijj1qmGQhB0Kza7UoCwZFMroh8xGGX2gtCM/3Y=;
        b=GuT84QDKmZSoLIwzqEteeHuduEwSPSWysemOm93li8B90Wu0toOAf1eJDGPsotq8tQ
         +8U6RzmMsbIymrASoh+SopR/K9JfSn8jgWv+PTYenLUo2cRKD4PAKhioCs4AWy25d0do
         PTRiUmPK2g8+1CyIarczAv5wTofVqZ097Pp5Ho2y6cPgLKLfvZzISxQee7Vix9d6yn4/
         1kFrWifhSEH4DZ9bGhnJUYxwbxduhu6daKeBvJLNZHIZ7JX2VgekOWxzbJz0GR5QJtKO
         /NW1TZqIDGxZMR8kpOeBMpuCDkjRrEkKzgxCmGQbtvcjjTSL09yFS3DegqW9HgA/EblY
         WTFA==
X-Gm-Message-State: AOJu0YwXkRn+EXuqwUvW+d4UeP4JmSQn8Tb21UpnStfH6PW9wX4y03FR
	7gpIHGvz26AM65k2Nt1e91qm0UjHLKDlRj+Q9P2Nxknj4Jy5tAj9GfjtHOVzesQhgBk=
X-Gm-Gg: ASbGncvZhyzRJ8rkEO7X68/t6gp6SVs02pa7dNyu3mATJCb8qtX4Prk9YPGO/Vo0rsQ
	1+Kp+vK//G2z8vyAwN59uRHfMmltDozIXmWnfSnLtNX5lvsfQoI0AEw56FQzpwc0+hqcJvBKfnD
	zPcpFFP7qtXdf7fM+aSBzmGCNAkgD0eGGUVJqztpPAYUlcGUemr0vgMZeS7shXktMDjCcBS9fXk
	Z3ERL/c5Vqg+1eOXDZtt6RxtI1dx+2L35Auv5mKRlF+Pv+PNqGN+b+36wkH7Xh2rbsGofXPKFtU
	9cYRhB6MIR+3g7xBLr3kCiWDmaK8qsClEnzqlU9SIYH4RxaLB34OJ+Pb0vGjwU8gWnM5KnafGq0
	3rb88dgqS1JBa16056a4yhErhNBCKvqcf0peWdxmXygnKEMZiamdGQbe7jrYhuuqJg5S3mbs41H
	OqjODZsN1oISHC5fqiI9cMrfcYAvCh5vVjFg0=
X-Google-Smtp-Source: AGHT+IFnk9N3nmjAwGRshLDvnFpwhJw7i3iAyM8knml2/wxTG6hNzngkevih0ip64tDutgyq/DI8yw==
X-Received: by 2002:a05:6a00:2389:b0:77f:50df:df36 with SMTP id d2e1a72fcca58-78c98cb8602mr20357762b3a.18.1759829015059;
        Tue, 07 Oct 2025 02:23:35 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:34 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 1/5] m68k: Adjust the pci io range
Date: Tue,  7 Oct 2025 18:23:09 +0900
Message-ID: <20251007092313.755856-2-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007092313.755856-1-daniel@thingy.jp>
References: <20251007092313.755856-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the Amiga at least the zorro->PCI bridges are in the
zorro address space so currently the PCI IO range is not
big enough for something in the zorro area to be in there.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/include/asm/io_mm.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 090aec54b8fa..47aff2ba75f6 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -379,10 +379,13 @@ static inline void isa_delay(void)
 #define writesw(port, buf, nr)    raw_outsw((port), (u16 *)(buf), (nr))
 #define writesl(port, buf, nr)    raw_outsl((port), (u32 *)(buf), (nr))
 
-#ifndef CONFIG_SUN3
-#define IO_SPACE_LIMIT 0xffff
-#else
+#if defined(CONFIG_SUN3)
 #define IO_SPACE_LIMIT 0x0fffffff
+/* For the mediator we have io space somewhere in the Zorro 3 space */
+#elif defined(CONFIG_PCI_MEDIATOR4000)
+#define IO_SPACE_LIMIT 0x7fffffff
+#else
+#define IO_SPACE_LIMIT 0xffff
 #endif
 
 #endif /* __KERNEL__ */
-- 
2.51.0


