Return-Path: <linux-kernel+bounces-799720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394FAB42F88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A11F3B7AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2C51F0E26;
	Thu,  4 Sep 2025 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw/wnIry"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60B1EDA0B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952107; cv=none; b=SM6wJNw66Dinp4Ejk7ri4eKa+3mucP7DGuge3iYVPoG3X1sRenHZM4WsnEufb4wmbUI/r19Y8K24KvzfxkQNMaaReqEDeKge8Ad6SV7DFoxIWMghTmxtTVDKEraelAT6GD4xhlzKinXRbimgEu9PSWX7P/8rlo3x7bYzj774XNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952107; c=relaxed/simple;
	bh=dr1NHuHnEvzKxM4NCMXIbI6L7kEzlrhuduejp3z9nr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aHQXpzHKejx//VcC58obyQ5EiEoluzKnY6ENg7MsN3fLyFvYoNF98Ts/5isn971zgweDjeW27FzZmr5MhyJ+l1NA/kLqcRZYyh1oaMPLkowUWli1o+WVyC/RtZ6rLeqRvLHY1KUnNxbbp1n8zj4FkJEJMEJ+ffjRFb/i6RBDJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw/wnIry; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b338d7a540so8283681cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952105; x=1757556905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjLPKVYL2fqcNwsEtvoyIStMoXdYJapAZuhAuAsk5ek=;
        b=Yw/wnIrypXvT704vE1QwUo/pNiZXXgc44oHHwREqKrqQKC6+Vr74+EFS3YQtm1ZSsN
         kOZrJl/NTtBFywGbHPO9J61XqQhj398B1WnpQ/bU8RiTwBAYHoFFGlRo8c8vIcIcDS1a
         5pWjJb3PbU8Ks9483PPShwsY/JUBy0y2tLurLX4X/BzSIboScQclUn4rV8mymzzaBgU6
         SUCjrZxE/38fpVOOOON/MngIMzYbL6lYZ9zAhUu8L8o4bk3+073pNT8IDoRIsMu2HZoz
         Watki5JBLItl/iP+0u4Po2wTF6x+585Lfc4mY+OVvkHz2DOdg3RTfglLAYanI/1RpSlt
         l7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952105; x=1757556905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjLPKVYL2fqcNwsEtvoyIStMoXdYJapAZuhAuAsk5ek=;
        b=Fz17Cvy+7Hl9crlST0OC2rVXPiRUe2/EFrw2+7/peXflUOBbN34uEoHFmSovnCFHC8
         v3D3pOQhUDJqiE3yYwDC3Y9qmqrMPureeO9hPyvxtrkffsEduORP3b3Jwh1J5WcqNlAV
         Ep3JlpzkL6gYxmHRA8aJyPoqwXCLLDKHzTWGCxVjmNlOA4sH19SBj6rAZeclidwCX9IW
         s9sNKxKhz95L88GZZSQ78N3ke/PxgZlloLH7ZS2K8ZmMwzYYBx+/D5lM2h/nGNYrYmI8
         yZToX8/+j7+NPNIaYs22xshGutbh7tOiWNPCB/V+ts1HaM6LYfj4/GQDi/5IXaz46GrT
         WC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWywYP623N9UJyEbOLKDi1WAZqNjFLbiiCN62EMSQpp5SBVqruifCfrtMmKXFCxibHbJufEU1aSevqubic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvZJ7ODbqqbE38SfeEvVLMCkg8WEvFopeiMNx8phmNKW3L8vQu
	5Jk01wWJPE0yxSw8UTNHJuYFo0WTdN5xMhPJrtErzI/N92+aXvhHtGTW
X-Gm-Gg: ASbGncsc6lqI3/7IcXq/tgbmHp9kQ5qX38RmTgALO9mg+USL+aFYD01baXa1+yxQqgb
	XMzla+2ENeyffJ5M2aU8hlkroAdusmXJBUW72edZ0cwVngxpFLeNU2oX2WE8Df7iuUclPhGtqit
	8J/Nw1scnhkmPtLXaIpZ8HhXVItDekiEIZdshSC3Wj6VWG8w7jhlVMYSOtGL5LiwMF4bUS1iZZD
	WPK/KalZK3p6R8nZwlMCD9GKYOE02PkJC1DhAy+JmOondenTtOIuiCi+clF+ziBKn/hzTfcqkDn
	k5/5MSDblN/HuGXG8ZFefg5Zi1MNo9z2yZNbfn+gaIPiQFGpDnIJupIB++Kn58SQ5hFgCwPWNMg
	oH4mAEQxek640phMR2OhrysqdBWde02unMftj/WkjowTzhZTm+ZiIXkeM4JGZ5g==
X-Google-Smtp-Source: AGHT+IHHZwqjGBH+gVrv1uqdsL5o0HYi0fqBPQZogImnszYScoLfA/gc+M4UxD3AhjbaRC/XGpVSbA==
X-Received: by 2002:a05:622a:124a:b0:4b3:ea6:e0ef with SMTP id d75a77b69052e-4b31d845107mr219283871cf.12.1756952105135;
        Wed, 03 Sep 2025 19:15:05 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:04 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 00/16] rtl8723bs: cleanup and style improvements for better readability
Date: Thu,  4 Sep 2025 02:14:32 +0000
Message-Id: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes 16 commits that clean up and improve
the style and formatting of the rtl8723bs driver in the staging tree.
The changes address spacing issues, indentation, comment formatting,
blank lines, and minor code clarity improvements.

No functional changes are introduced. All commits adhere to the Linux kernel
coding style guidelines to enhance code readability and maintainability.

The patches have been tested and are ready for review.

Changes in v2:
- Resent series as one properly threaded batch
- No content changes

Vivek BalachandharTN (16):
  staging: rtl8723bs: fix spacing around operators
  staging: rtl8723bs: remove unnecessary space after type cast
  staging: rtl8723bs: fix overlong lines to conform with kernel coding
    style
  staging: rtl8723bs: align asterisk in block comment to fix formatting
  staging: rtl8723bs: fix logical continuation style by moving to
    previous line
  staging: rtl8723bs: fix indentation to align with open parenthesis
  staging: rtl8723bs: adding asterisks in multi-line block comments
  staging: rtl8723bs: remove space before semicolon
  staging: rtl8723bs: fix excessive indentation in nested if statement
  staging: rtl8723bs: fix unbalanced braces around conditional blocks
  staging: rtl8723bs: remove unnecessary parentheses in conditional
  staging: rtl8723bs: remove unnecessary braces for single statement
    blocks
  staging: rtl8723bs: add braces to all arms of conditional statement
  staging: rtl8723bs: fix line ending with '('
  staging: rtl8723bs: place constant on right side of comparison
  staging: rtl8723bs: merge nested if conditions for clarity and tab
    problems

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 421 +++++++++++++---------
 1 file changed, 252 insertions(+), 169 deletions(-)


base-commit: 5141ae32d4b8971d7b689854fd47a200e695bda3
-- 
2.39.5


