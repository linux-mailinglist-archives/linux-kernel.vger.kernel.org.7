Return-Path: <linux-kernel+bounces-822657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E10B84693
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78915525D51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB82FB603;
	Thu, 18 Sep 2025 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUTOyhZU"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64299302CB6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196127; cv=none; b=OeL+CIFNG4M6iegddmCS7cPpHxyDAR2hHY1Twz5kQTyJaKy2rbgrrJWX2xL9o6aEWgX8ZZGU/0g8m3HYjAXYa93jdALgCS/ROTJ6+TO1e73bo7xUWfdDsq+VEncP9GyqsRyXrXWXPgo+RKBuT7gbOErA4a7554BdivLuiaxJGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196127; c=relaxed/simple;
	bh=r0CpiwUKL2QvqtTVBu/vkf6gOH+5nGv/WLO8R4158+o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PfSPzdX397KKMonQkBLGePu6eIm1jSmcJtC3f2PO2S0Fyo9rbs8VUV/1bBIx+I6dlPTgh1ExpwrUCAH+3YUpelUTHsyB4sHj+YUAckeK4cysWAWR8M6UpVAEuYPwCZ/P0Y/fKTiSq29eHrkx5gCiUMSkPUR8Ag/4hC74iP5KX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUTOyhZU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f29c99f99so5180575e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758196124; x=1758800924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjTjhC0GXxWOKnWXxPiVFKHc+WCcUAZ7VMt/DJBDKtg=;
        b=gUTOyhZUbouLnbUoNORMzmdUPVYMmRKE9ljDinQ95+T5mVZb4NkWGsO0xOSEouG8m0
         +sIG9v02e4K+umerQ1/RLEpcdPGdb1owKyKEDAmz2mHgF8/qgM52EkOm22EV8U5zkmA/
         Rw1zYJNu6a2Y5QP5lPuxC+1/+q5By4zW+nNz6bduV77n/HJZeBqfHAoQRIDfCON1wpAD
         xTLEb5rPmnimTCFl7wrRWBLh0HL/styTGUwOAnbyOLUaXojf8FQM0vnlfkZ+LIC/z0N5
         3FDdqnMis4t+wObImsecDhHVp7nsuNwPVzFMx2gVL+BTTbzTflFIcNsuBTkCf6+T0stk
         fKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758196124; x=1758800924;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjTjhC0GXxWOKnWXxPiVFKHc+WCcUAZ7VMt/DJBDKtg=;
        b=urGRdpr8N9eUW8ndtS3qdAwBJ+PcnY1/cnbaD1PdljN268fF5MgyA83rV0qI/IQRvX
         6MwzmPHcpSx4Y77wTtIo7Z3/G3eLjzwlpKL0/Y16CiHUKyWPMQ+g2t9x+35lh200kuYQ
         nr5bLZFwuccg0Srjhq+nYYsF7Geh7cd1Tg7LrFBVFVd/5JX5/p6QBXAGzU6vphhDWpdU
         f+w8yH78ynjtux7FEiVAYQdTNWcIMk8d5C2Lyhn2I049Y43R6YX02CrHU0IzGv+sBWqe
         l2YZwAyJkTY/tO5Om2TeEmXCTjggVsELSuOOttAtkidI3SGEV0G/W7b3GX+wCaigEJQr
         AnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXLCFAGFONcU73aT38oFeOCHodn5lmNKavkAB8bOuw3Y6t/5WTG6yeaO/A31APCLuuVvmFVYoZkFjYR1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPMuwGLr/9WNA7AZzJiF1GwkMM9+dpVVMy4YgfUoXU4mz9HvO
	2kOH65DUlU/FLMURW3hW2uWFJ0d6CvF2S3+j9vOmNatwQyO7hyKQ39SBlkoVSJf8lu1z713Wxin
	a05AsIljlpA==
X-Google-Smtp-Source: AGHT+IEFRqfe/nIo/PJ9WsmrZAu5LFESQ/y9pacPFCfYMGNYUfu2hTf1tc2+XxV1ebQiySb1OZphgejnjUUp
X-Received: from wmmu8.prod.google.com ([2002:a05:600c:c8:b0:45b:890a:14d1])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:350d:b0:45d:d2cd:de36
 with SMTP id 5b1f17b1804b1-46202a0e76emr44220295e9.12.1758196123627; Thu, 18
 Sep 2025 04:48:43 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:48:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918114840.53581-1-abarnas@google.com>
Subject: [PATCH] arch: powerpc: ps3: Make ps3_system_bus_type const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the ps3_system_bus_type to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 arch/powerpc/platforms/ps3/system-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platfor=
ms/ps3/system-bus.c
index afbaabf182d0..c5b880c411ef 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -465,7 +465,7 @@ static struct attribute *ps3_system_bus_dev_attrs[] =3D=
 {
 };
 ATTRIBUTE_GROUPS(ps3_system_bus_dev);
=20
-static struct bus_type ps3_system_bus_type =3D {
+static const struct bus_type ps3_system_bus_type =3D {
 	.name =3D "ps3_system_bus",
 	.match =3D ps3_system_bus_match,
 	.uevent =3D ps3_system_bus_uevent,
--=20
2.51.0.470.ga7dc726c21-goog


