Return-Path: <linux-kernel+bounces-749322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9335B14CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8AC4E2B44
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB828C03C;
	Tue, 29 Jul 2025 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiwMX1Tf"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611C1DE891;
	Tue, 29 Jul 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787961; cv=none; b=DM+h8Su4wuacUm37fays2yQMkJ5Lbo7G/gdKJjvC6JF/P6BAnbBYcscX3YIQpWSqJ5mTcr1sDzCl5UTzlg4by2TUZGUJjW0YRhjZedGuYaxT7ptrARGCzYG1kPdS3kb8MNPQHhhZPMxwYueKWGhTZ/9n/pNqFXzhXjcWoOOlsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787961; c=relaxed/simple;
	bh=+QMx8Xn5JU0mDdXdjTkiz+qzWbSdOkh8BEG6GfWt590=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwhLNDk6VKUAf6VDRi4fwtLg45Zyw63PwpYBSorbmWTvGGIDciI1jeCkVm973c/T4UoX6dyibp3exqSnInp5wfVQbXXnNiVxDjCp2l6L7EvOsDwCRL0DVnIuRFb7UV/XdoCOS4hKu0KOroZNvgXxn2nEmanjA7vVoXatq0wnYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiwMX1Tf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so35571585e9.0;
        Tue, 29 Jul 2025 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753787957; x=1754392757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7iuRz92HCVIT1exQjMnG0/dtwvtLcUKiQwnTs/Nc7g=;
        b=ZiwMX1TfBvoB5Q1iu6HqZ4TcziMRXieE/K+CVY2/ZGAbG/6pWFcGUOuJ3Ya4CSHSuw
         hTJJsuVANIgF87ujHn6YgxKqwTqP+eYEM9oVp8/suc2y/nqVKPRec4nYQDmPnRf0eaA8
         WgQzy7Jn6Tud2Hh1WxGgDq4Qupzdptb7iRI3akQv82KipFgd9q3Bl8ZgZxKKB1zB6fje
         4wyt6vbrKw7JSFmQbHymhqJa4jTW5o1izHQ46DAPAo7VM541es5NBsct9KIAir+zUPUX
         y3uU13SP2TB4Vvq/os3zyQ5fDerkxqIum64IfxiX0clpKPjjitvLYO8ejvLiK9NuiGIx
         obPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787957; x=1754392757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7iuRz92HCVIT1exQjMnG0/dtwvtLcUKiQwnTs/Nc7g=;
        b=HAwDNAK9HWUmUNQ+qRXk/G2rKNo8ep/zEMipTOK4jumSAD9p0HUmrjh1+i/vfr7Fo+
         mCUkL9Zq9wq5hvCh60TH22TrG9HxzhHO1aooIT8A71oPUEbFpiKslmVOaGI5tMepAvPR
         ruADVal/ElCSI0EgyIrmc5PehCgnAA5m9rMd8vp8lFMAl+6FXXgQw435bkq1BTDKmI+n
         u5hL4fiFjMrudOtBSL9HlcSe6wQARIW4xAdbyZD0paD8Zaol1eLCxavvj0RAgBiD22ZF
         krhOyU1Od3gpBdCVeDPtidFSaA+4T5T+rF4orOY1FGzgSBJy0yeXpVsus/YGSs3DVafk
         LsAw==
X-Forwarded-Encrypted: i=1; AJvYcCU+3hqXvrou0ftglWp5avzy92MEnj68LVNY+4jJTcyuwOhTylOpaUhBb2O1d8k6068mjrrQL/uroPX+yoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZScmVUuSk1s+S9KZ2A2P0uhLqEaMwpOYpN81izJrip1l2KPV
	lCWXEEfZMjTOYbxbODJk91vpP4HWUmsMalfc0ugeAwulSLHZaNrYRGR8
X-Gm-Gg: ASbGncuWzm6LbAFD7rMIrhd0hw0lFJL8ionT9OinZz7Rxf8xXkiCDBpKFy/X2XinqJB
	hpjIwIKBaOkmdQU7iZvaEvP5EUnekzfTrXPIK7ohklWYc8cCulv8KC508WViPEMkbs/LNtSs+8z
	86ZuwF5TisFBwg28S7HeZU8sVxpcSrWeVlgL/KynPt2fgi4Mm1inkkuWiZeiusbTlRgH4RiIVci
	p+hMo623wM2kq6EFk3Kf+hy8CKmkJmZ1E66s6ikzlJG1y1TJKFRYzqIJ03raYPgWiyWLmEVXUcL
	XQuawYtpqcDxo8A+JAC8nC4gHvyUUGeSMf2sEyBapmgQNZiFAHlEUAgw59qYo/y+ogM9F16HU2k
	uJSDkAHJZ3rjh7h+G66zKrMIJR6rYTao=
X-Google-Smtp-Source: AGHT+IEn8baAKkdjQiKjD+OkAvGRUrXrS2YdK0Poq0GfjeJLzaXTkGoyXCAUov55fzv/FaoSuH9ICg==
X-Received: by 2002:a05:600c:c173:b0:456:18f3:b951 with SMTP id 5b1f17b1804b1-458788a2116mr129642095e9.15.1753787956726;
        Tue, 29 Jul 2025 04:19:16 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588e5c2232sm23268075e9.13.2025.07.29.04.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:19:16 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mach-sa1100: Remove space before newline
Date: Tue, 29 Jul 2025 12:18:42 +0100
Message-ID: <20250729111842.1923915-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a warning message.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/arm/mach-sa1100/jornada720_ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index d94810217095..983988395488 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -144,7 +144,7 @@ static int jornada_ssp_probe(struct platform_device *dev)
 		return ret;
 	}
 
-	printk(KERN_WARNING "SSP: initialization failed, trying non-irq solution \n");
+	printk(KERN_WARNING "SSP: initialization failed, trying non-irq solution\n");
 
 	/* init of Serial 4 port */
 	Ser4MCCR0 = 0;
-- 
2.50.0


