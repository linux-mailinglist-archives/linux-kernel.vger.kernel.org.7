Return-Path: <linux-kernel+bounces-884588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD05EC30895
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE433B268B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11E2D47E0;
	Tue,  4 Nov 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDNtMli9"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428729B764
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252536; cv=none; b=B1Ks4w8phV21+t86zbOVXngrB9hQptkryjooCajXMyP42dnvQASJtTLRchZhv8TFdC8Nv5ulE+eqkFmIz8Ld4ayDbvWjFl6o3FyZjN7sPYE71sb1TTfNy0VTFrv4Tys0Zix3TIzX3UN47Z+Op++1yWQfsX1cyh4OfJGzInh1kQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252536; c=relaxed/simple;
	bh=bbqVmDXrDhnX6ettu/wb1DLbLCvmOaoS8GeEhUZpDzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFEa1al/9SEOaC8+SaZTgrmIeScej9cAvfQWX//9s1Q0ejoqvNld1SoQbILHnatPFbmpJGxrow+gpQcpCD6lm54FnIrOVMU5Z708AggetGa6t+MvOW3NATSTjcPO34DUTA4SAlpZT7Ie6jiM6WXiuOMaAQTLANN84ER+kscRE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDNtMli9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a34702a20so19584321fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762252533; x=1762857333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCqV11fTwKqIZc7sHV3bdN9NOfZmBeeP0YyuW6jyL3o=;
        b=eDNtMli9C7dNVglvD6aIHOf+yUZ1T72ZZAxDQcefOZtNQf4q4isfjtPSFDHulrkCRC
         cw+fAqIZ3SzPGZnJCnbuxhZIfJkRn+4yBNhD+vkS0zN+H6ZzXtqPXKLfJfTMGZXmMbip
         gt/BiUWyVDVfG8b1cBKPip7XXF8UEBY5dRyh3j+2CJAkZOayykurD33t+bpfyYMYbOVP
         80zNBdO4X3nGNOxmh0EI8lHCpeBKbo+kcfSlkE58erL7zdfn9uDYu/I7G3dae81SJvCH
         WHguDse81U/TnXyMl5CN1S753M+2LIj/VeH5Zv82lZgFW5KfnJ/dmqp5jRjJcMk4WlEi
         uD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762252533; x=1762857333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCqV11fTwKqIZc7sHV3bdN9NOfZmBeeP0YyuW6jyL3o=;
        b=nbtxT+nsFCXd1aOuIpUf5OZ8XzFc8/iRYcUf1oemYabDDdrX/baKfQvBJ2PKtoDh98
         SrQxbaqNRjFA8klGuvy/h0QP+S6NZEgqiKcw1+d+sjp3NZwhqFQ/VHPSnHeSGeWD7KrR
         18q9qhPwGqeHPnzlCh37mKZmaB0+rbkoVy37OX+RvaEQItGAifDjo7C5dsMHJohKWYc7
         8BcT2BvSVGgkFjBRmhc3216MyuKF+FtshZPPDtiLNG07gn6I+3HVIiJum3u/Yr78K2wl
         MSVgks9ubvOzAxVa8takWXtiLshhRc+7BRDRRPXUxhy9j9Jaez0jzmkYPjoIprC6a7ZA
         zmZg==
X-Forwarded-Encrypted: i=1; AJvYcCU5MY0gjef41ZDNKOdjBMx7nUppQC2p9mftuA3qm5ShnSfi4o8n17we/ieCcNJ6CRciXsqHcaYld/jbKnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQIKrH6QaoVSBQvdyBUbJBiUp2UnTbioX6h7X6dsoAJjuYjQb
	9EOhRd6szvDohhfVCglzs6ItmC1bv9sdFmuNeWr9ILxz/MIPFUyrbkEJ
X-Gm-Gg: ASbGnctO6ZbQZI11GYW5bg8NB4vWRhhxjcTvEMeLDo2tb5eqhf0HRshHJK6TYpyU2v+
	tYIlNEbONkoWAcZMtimkKyRr0cil9CFkbqYf16ryz1c4j4Akbn5cojE8KsYyjpBIfL0ynvIqtoU
	8U0wF86lC2czMt5ilHRtXOzywivQudT7c49Qz2GKzE1ChYgJv4+0HtvmiFemd82ATFESLzQshec
	uG5DRNnCK3Xkb67j98IcVTVvpN0ozX62lhHl5yV8+XTJkI30SXHQJ/ZLKs7oBPXLX72iFjy+wHr
	Frbf/KpSd5SligZEHqlwXGXEqCKlkmDnwGdMkK5/DZFtD+aAnwOSNOn3RM30+C8cX+Me6j70nD9
	C5E4lgF/Jl76gv8YdynQEmkGwpzBa3SuHuo77Jxr/K1h4QDrAn0VFo+M7/IK6MlpDRoXmQIHMxC
	o+TMb5thq1JR5eAIhVPhtYBDVfg+Jo4ED7aZJL7dbT6WhvvF0XVUmw
X-Google-Smtp-Source: AGHT+IGupWEQJSdIHTXfxGW2ZOZI7jMD+5WKyN4jC9KnhrUC7Pl19L+uPfMiiPVvBDHacKh80RBFrw==
X-Received: by 2002:a05:6512:3f29:b0:58b:63:81cf with SMTP id 2adb3069b0e04-5941d577dc8mr5490335e87.55.1762252532486;
        Tue, 04 Nov 2025 02:35:32 -0800 (PST)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59434456732sm627685e87.102.2025.11.04.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:35:32 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v2] Add Magnus Lindholm to MAINTAINERS (Alpha port)
Date: Tue,  4 Nov 2025 11:33:43 +0100
Message-ID: <20251104103525.26410-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Magnus Lindholm as maintainer for alpha port

Changes since v1:
- Rephrase commit message and email subject

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e033042..49ada25357e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -915,6 +915,7 @@ F:	drivers/staging/media/sunxi/cedrus/
 ALPHA PORT
 M:	Richard Henderson <richard.henderson@linaro.org>
 M:	Matt Turner <mattst88@gmail.com>
+M:	Magnus Lindholm <linmag7@gmail.com>
 L:	linux-alpha@vger.kernel.org
 S:	Odd Fixes
 F:	arch/alpha/
-- 
2.49.0


