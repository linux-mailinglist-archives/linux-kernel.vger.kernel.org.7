Return-Path: <linux-kernel+bounces-747188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F357B130D2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966D3188EA71
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396B2206B2;
	Sun, 27 Jul 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoot60j0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2821D583;
	Sun, 27 Jul 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753635536; cv=none; b=FPiJomiylxzuTjgYtGA/5IwYEpKreu6CNPIwMCt37C1eVJLdUD49dJtb0BzXRXLvMcQBDBLBltFJarhNkJWZLL6c0mcGzu3DQ/ajmUH4WEzLgak9tBqUxBVodytsKU5QLHylHoIHEazKOOvP+mTSzZWctuN9K3GIeXAAqpik68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753635536; c=relaxed/simple;
	bh=VqG/nOq52UyhnrMAh2zpnY+2oHeecplEWapXivHfE7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpu/EcsAXWYN8gxu1YvuuFGixtcF07ywZPpgic4YDVDloavsTRYyXGTbwyDiCg7dzr2im9NATZgVQZuiIkC38ZL2e2JTRpNezPkY101uka/Lbu0J1ykfQxBkpp24aQYIxFEF2xKZUxZbm7aCZr+k1wLfYu66BJ/IHY31cXwx0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoot60j0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso3444171f8f.1;
        Sun, 27 Jul 2025 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753635533; x=1754240333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/kiDzvyftKmlvmgmzp66NSmD4VUsIwsnBr5sA9+BR0=;
        b=aoot60j0wVJ2vJwQW7YdzDa4uPAf+4mpQBYB9JUV2gAjmme3ktwhtY/5ES3upWrwu8
         LXXjUhkuHnB/hKdJu2nv700I11g3ROAbzaW70fx6Ez6B3Al5vFXkQC4amopkters2evT
         HwvmCljIUZDUYeUaAuJ7KRHkYDoLgZpqeNzoeAGOWrAnRu2lWFZgCl3DRElZiMFNNl4n
         7BMc2D+U91iOEWCMlTp1g6deKbLRuPzzs+a0UbrzkSY1wCeRjFaKIPPM6+5RbP5+mPRU
         j9Klk2QCFvZz2VeikT6wIZYFqdh24APvwQTfK9v1NIj4oulRpRqajzgRYnj5aWcjt0lX
         Zc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753635533; x=1754240333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/kiDzvyftKmlvmgmzp66NSmD4VUsIwsnBr5sA9+BR0=;
        b=nhEC6PllpknmsxzmHGhG0DzWD019oNUfqCY7IUGaGj9H34UpVJuko6WQCrDOioEeqa
         iMbAYu8e2rw0R8qJTsgJiUItOV5jk5hACrqBoE8sGVZuEN9yAW74kL2ZX+GdvUfaBjOq
         6RR2BKQ/lN4OC6yobXbJ+mcRHjiMeeOFREA8qlMVGodxDHGT8SE3BHXrVlz8/sKfmIe8
         ++68iZWRA0K1T3l1xGkYTu/Z4Nwvxc1bKLIeZYILPRevuubvFKMBclov8IhJW3eNCb0L
         K1/M/THNKp/8G6YyLwznyJz95pG0zT74JdadVMVCiodWI0oxHD2+El0BISpElUb1KKjf
         ozUw==
X-Forwarded-Encrypted: i=1; AJvYcCVARXZhwUs4ktBrDPd28Ji3IJuwTO29dbAEiTOAeeASaqfT5OtG8QEEyMPghTntvs9tlzTH92DzOBO7OPCZ@vger.kernel.org, AJvYcCXsOrJXK7z/f348mzl+XvB9qqIV/7CHCJ0KXT2FW0poUMyzkFL365j299LUiGtGY1lkOMsqRnYgvXMa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42XBHm51vNr79lRWvYmqDS/13sIbp0Won4hReY+EpIQWXHwvU
	BKCf1LsvB0AjX916PWt9JOr0MT+PxjbvLl/t2H9+1bj4NSSKqeuPaYw=
X-Gm-Gg: ASbGncv4CxLt8S0VL+AotPuzj2PHu4NBNoedrh74lg7RrJnIHBlyN/XTD0bcdm8umZ8
	zQT3eC96SZW99otjYpdZ34nrEoYJQ6gqbeX2A4MY1OsfadzzbFaTHzDOc550/qEWZ3SwqeGR2yO
	nFBv066DtBvZGQJvnGNo2jF7pbBI1rE1+8tglFF0Kfr7V0AGXSdxLQ6QIe1wpYcI/93cu2Jhnff
	4eWcHRnO6QqWWEztsFRZDEtbPf+0T75BA1DOEe7+Ug4gGpM9GSxisvB+11podeMNx3E+JhEqGxF
	B4832Cm6PzxykJdRsAMzaisqozDy/cMxgnk3MwjGjlBr1cprcq9vuy+EiG7RPXM9FRSnYlTrYT0
	ybtt08DylnRQN1L52CD3E7jV1/32e5NI1ocPtqYFiahyasSrE1As=
X-Google-Smtp-Source: AGHT+IFiFy0HoTKPsyrRmMVqfpprnRKLceLvittEYYUCTh9qJMlSsXMVnmfCRpsXilM43NrYJk4XXg==
X-Received: by 2002:a5d:6609:0:b0:3b7:82d3:ff90 with SMTP id ffacd0b85a97d-3b782d400ccmr1869031f8f.15.1753635533074;
        Sun, 27 Jul 2025 09:58:53 -0700 (PDT)
Received: from alex-x1e.localdomain ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458704aaf20sm128545745e9.0.2025.07.27.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:58:52 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH v1 2/3] dt-bindings: display: panel: samsung,atna40ct06: document ATNA40CT06
Date: Sun, 27 Jul 2025 18:50:25 +0200
Message-ID: <20250727165846.38186-3-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250727165846.38186-1-alex.vinarskis@gmail.com>
References: <20250727165846.38186-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Samsung ATNA40CT06 panel is a 14" AMOLED eDP panel. It is
similar to the ATNA33XC20 except that it is larger and has a
different resolution. It is found in some arm64 laptops, eg.
Asus Zenbook A14 UX3407QA.

Raw panel edid:

00 ff ff ff ff ff ff 00 4c 83 0d 42 00 00 00 00
00 22 01 04 b5 1e 13 78 02 0c f1 ae 52 3c b9 23
0c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
88 00 2e bd 10 00 00 1b 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
00 41 54 4e 41 34 30 43 54 30 36 2d 30 20 01 7d

70 20 79 02 00 20 00 0c 4c 83 00 0d 42 00 00 00
00 00 22 00 21 00 1d ca 0b 5e 07 80 07 b0 04 00
e1 fa 51 cb 13 b9 3d d2 0c 01 45 54 40 5e d0 60
18 10 23 78 26 00 09 07 06 03 00 00 00 50 00 00
22 00 14 8d 5a 02 85 7f 07 9f 00 2f 00 1f 00 af
04 23 00 07 00 07 00 81 00 0b e3 05 80 00 e6 06
05 01 74 60 02 2e 00 06 00 45 40 5e d0 60 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 b0 90

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index 5e2ce200025f..ccb574caed28 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -21,6 +21,8 @@ properties:
           - enum:
               # Samsung 13" 3K (2880×1920 pixels) eDP AMOLED panel
               - samsung,atna30dw01
+              # Samsung 14" FHD+ (1920x1200 pixels) eDP AMOLED panel
+              - samsung,atna40ct06
               # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
               - samsung,atna40cu11
               # Samsung 14" WQXGA+ (2880×1800 pixels) eDP AMOLED panel
-- 
2.48.1


