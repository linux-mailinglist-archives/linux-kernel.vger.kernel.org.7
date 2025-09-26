Return-Path: <linux-kernel+bounces-833684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D892FBA2AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A97384504
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E6286426;
	Fri, 26 Sep 2025 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xgy1FRMX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43EC276028
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871149; cv=none; b=MNe/deRnbgcGoWP+6cwXIE1da+AgbqbWzQRwqNePtXtVhSdlZoKSy1jgNYYYnZMSh2+qtwK0sYnOB0tniJxD4mHI7x3RWVxWD/Csm64ofb4UBB2ztG+SoXZe1gj8SGre7h15XkIOk6AY+oRWUi7daq1mVo4T7fr+HQ+IviDAE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871149; c=relaxed/simple;
	bh=FDV3uBNAbwFXT+M7fyNWH+HJ349lnbWYLaE+n4S8cdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AR4fNg4es95SnUOhoPAEnMcM3DZWPR9z/SxjUor+upQsPCLztpDEdjtefi/MUTYhefj64nBXwbRL3STQSle8GYryivGQuuGJ+Mxmzv9lNx4WHX1I5TAjDWRQ7nbs4HlRXwzYeHOOih3xRQsx5330KqALy+WjU3Mnki2b9qbCMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xgy1FRMX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758871146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tOPngMxA7p4GyjZLW1Z2fZxDxzYAemuo6fVS/hsRC0Y=;
	b=Xgy1FRMXmgtRel2xJLVU1BWeTsYDDjt97BNyRgiyWw1t32CpKNkna5CmDXjeWzM+kj87fi
	5q57v6WrxMh8Cj/CSuSv7ZL9nEELj7pJIZMGnFjkmUCNuxdUm5YvrirOv0b5jNOwhxphG4
	ILXlgXikl1H0Vx+MidpT4hOQAoUAK7s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-A609aPgdM46Qzjgj5KnFrw-1; Fri, 26 Sep 2025 03:19:05 -0400
X-MC-Unique: A609aPgdM46Qzjgj5KnFrw-1
X-Mimecast-MFC-AGG-ID: A609aPgdM46Qzjgj5KnFrw_1758871144
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece14b9231so1141988f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871144; x=1759475944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOPngMxA7p4GyjZLW1Z2fZxDxzYAemuo6fVS/hsRC0Y=;
        b=b82pRJUP87XyYdK3GP6Le6+2bje1+6+LPhnEsX3QqG7HRVsrR/NPLm6AwyxuaTupyi
         LFLLvy7x0ZmjF4FmuFPFn2C+L2wEbznhONu/KrANodv+Cgcs8m7gLfLmBGBBJlU3iuq2
         GkesEzs1A6I9kaDerbrwuWPh3AQCf4uE6lfgrTR4Os9Q7l3hlbMceHZOA2t1XqUF0gVt
         y8IGlCm5yJ5xUzOawS9ZHfNgTTg094PWiTRNqJHnrTtI9bZGyBwOS7wZsZtqVdGExRQN
         2VQs8PCZL2U0Ly66oLsCyJwp2ogUbkwMFGC7sd7Zb0ZEIMyT5Kh+Mo8hae9Kd0P27g28
         Jocw==
X-Forwarded-Encrypted: i=1; AJvYcCXGJLLR5EUmoFys5tWp5/f0y+kLZbluEVpx2ukk25kbqm6Exd14kbXFFpxIFTr7e8hk2+UBmj7dWcm445o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXhEhyD4Wnp1/s2X5oGoD6WRMjDHrSRIx790b3WZn3Pw2A06P
	UHkQMF4YXX7QrDnDwcn+ZqvESe/tz3190CsvpoMpIujLOm241oXxdA6KTXYokiG/AbgYM3XK1AA
	Zr4tM+xulNkkNIPxV3OmX2/4TCT8GrYVETlg8JVkGecGQRE1tgAfoFtfNd/mbSNBgNw==
X-Gm-Gg: ASbGncuy9Cmd1Koccd6HIEep8xQJuKXV/iIHeytveqktT15aydtIFZtHuau3AgpJO/D
	+3epy4IsgfemBMCDrtCK++KPnMPUOjwv92z77jzPe+6uhO/OGEZMRA3dxh2XZ8VvHBKSWoAj9rW
	ktiawGPh9cNuE72lM7Fs+nm0rdW0nMmQhkdCA4j8jOOg81epoIG8Afwldo3Ca3KP+jAS6kugCmW
	sa/EFJFEfuC6yOrCA9RhtTyVAfy1Fxd4Va/z2Qfb5oMlj5PToCuywyz4DDCcfCMzq321a044XPu
	nJNNwz6n1ZLTRp1AiDW1I4u+Bqw47wkuUBWYp3T3iEBhwk450VJXHY/yPN4O+dAuf56K6BlcSux
	NYHXV/FjoYI+Bqg==
X-Received: by 2002:a05:6000:310b:b0:3e7:1f63:6e81 with SMTP id ffacd0b85a97d-40e4a711565mr5936592f8f.16.1758871143695;
        Fri, 26 Sep 2025 00:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlb1Wb38trve2rzHq8pOF44+10uFK3uhKPrtJDVZXfjYr23BydS246rnVqWWs+QAxza2wP6g==
X-Received: by 2002:a05:6000:310b:b0:3e7:1f63:6e81 with SMTP id ffacd0b85a97d-40e4a711565mr5936558f8f.16.1758871143271;
        Fri, 26 Sep 2025 00:19:03 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc92491efsm5994003f8f.62.2025.09.26.00.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:19:02 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in THINKPAD T14S EMBEDDED CONTROLLER DRIVER
Date: Fri, 26 Sep 2025 09:18:59 +0200
Message-ID: <20250926071859.138396-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

In the activity of revising the patch series "platform: arm64:
thinkpad-t14s-ec: new driver" from v1 to v2, the location of the dt-binding
for lenovo,thinkpad-t14s-ec.yaml was changed, but the change of that
location was not reflected in the corresponding MAINTAINERS section.

So, commit bee278e18e64 ("dt-bindings: embedded-controller: Add Lenovo
Thinkpad T14s EC") adds the file lenovo,thinkpad-t14s-ec.yaml in the
embedded-controller subdirectory, whereas commit 27221f91b83f ("platform:
arm64: thinkpad-t14s-ec: new driver") refers for this file to the
non-existing platform subdirectory.

Adjust the file entry to refer to the right location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fcf4e34eaa5..b641b5e60bf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25466,7 +25466,7 @@ F:	drivers/platform/x86/lenovo/thinkpad_acpi.c
 THINKPAD T14S EMBEDDED CONTROLLER DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 S:	Maintained
-F:	Documentation/devicetree/bindings/platform/lenovo,thinkpad-t14s-ec.yaml
+F:	Documentation/devicetree/bindings/embedded-controller/lenovo,thinkpad-t14s-ec.yaml
 F:	drivers/platform/arm64/lenovo-thinkpad-t14s.c
 
 THINKPAD LMI DRIVER
-- 
2.51.0


