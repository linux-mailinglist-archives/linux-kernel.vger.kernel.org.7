Return-Path: <linux-kernel+bounces-882085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69BC29943
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 00:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045953A27FA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064121D3E8;
	Sun,  2 Nov 2025 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcMexx5L"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF851494CC
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124511; cv=none; b=s9lmrfEHxG60TCVuEqHFDpdVDfTJ7N2uOIZvGyUtUw11qguhzuQ5jNaJ5qPuDjiDdHWyspwWINliDpfLxSE/ZB0b0ekIk5oXJah6gNSWcJ6SclpAeiJ8RkNaiathm+4ffYUtCNWVB1FgckwVKw+4PtzEQcru984eHeaWA1SBujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124511; c=relaxed/simple;
	bh=TLZKZNnITQFcd97o8fyws0ES3nNzbLGkdPJtuqGz5sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f1bsKuPJ6Fa59UnDBG+PKsE2JjNinAuqPFRHYmU00rfEwxeX0isPT12kq6IpGfKGv6+pveXwqGzRJXI0faXIRa0pSkrvEq2WIm3Z2cA8405bOnjhLOFtlxISW36/pKGfJjlLxpEsXBle3bLjLt1mhPLGlTznZMySl9HO2FxQou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcMexx5L; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-656a67c0762so76654eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 15:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762124508; x=1762729308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suckYxpxhS8tpm2524qw9Mw5oQrBRRr9u/yRv9LVIaI=;
        b=QcMexx5LR1PZSxEkWDknLztbCBkMo0IGDANf0xGvP945SFPldvjINnJ52WbH/E3OUl
         /sYxi3n7Hez96A+9jhU7AKqAnMKj5t1VlQ8sBXwx2fYCM7eMEeNPV3YpVcnSmLN/Ikl/
         jrqkIrVHzC2dYLeULsMau9OMt9lmQXt6eTbu9jU7CPkJOjLGEelbmRUBF3SUbsq/DNsq
         k+LClaQTEqbGj4ySenUmqH8GoyahZn4VFs11eoupW2KGhlvysUIksjtCiXDAGekq42ck
         ROjaa8cAScVaaIsj7nc+GmUsa4ZEJJxvxOEm5qFiNHUV4eEFBRmH9AxRn//iE27UXG9Z
         gp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762124508; x=1762729308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suckYxpxhS8tpm2524qw9Mw5oQrBRRr9u/yRv9LVIaI=;
        b=pVuE0gSxhltDsAgwvETg73N9dsozLjMS7QsWGliJHGSEhKDzYjHr11ieIoD2Qe5x6g
         zRcAxWYXlRyeTGCvvAZllLaC9YG4MHzdAx2aPRwSU7WqvXNUWkfZOBzW+nizVd67pGZL
         Cf3MeNK6o5/rqC8rMluEno/ZuUv0DW1DEB03XV8C8pc4thmEDq16MTZpGVdXbyAdER9n
         KDeqqQ6RYxyfllqs4waZrmngJhrwjkadGEGf3vfUpLzbAcN1v0AzFAusmDEAKQI1GoFu
         +6nHik/a+Ayfc56R1OmdMm7XMcAuhgmBA9ADdoCNRVF+tx/2KsxfBo+A96EARrsVTbC6
         ULsA==
X-Forwarded-Encrypted: i=1; AJvYcCVLXLQf173DhPeNHMqwD8F6LVbZwrKUVywM3MsC6Fdyt7Ant8uhiqxu4P3QGkF8b/rxLqRxXiQb95iQnfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+7YmU+No8h9/uakPxHgbq9c/53h2M4nO/ChP6AAxM0hXtICv
	8/1NBXnGqePu3//zqXtWOj6WOpg4aKFKc+kSppOuKA4PBLQ+1eXJWUhw5SqsEG3Mh+g=
X-Gm-Gg: ASbGncsLT3TJsGjtYzFgWQQbA/+kDk/90k4HVLTscVuuq/4ojRIjjpLtumNHRon00yC
	yU5ONdNyt8O6zd23x57zEchGU8Jvk5mAep5o3pnmtejtKTgVG5RZ+9i47vdOHJu27+dP3rPAWVQ
	3cUKPcj8lP/01RO2OOzMuoWH3d5rIyMO513cVxmsCitdLvWVCygj0SuGcpVpdLztLMggjZL3DLU
	UOkBCv0877+cjoXS1bqXNrD8q1ew7C8IwEQ72hawckFeVRC/yjy2iMrmpxo91nPGE8u4cWMOuGc
	gTYwy+1obAr9CzcDZ/SEIalBrMo3TR9qqoN5N3m9QpVhOfQgA//CENg3Sj3pr1DQoi2Sv8Ae4gz
	KDjDIFXHOvkKUu9kALr2g+twuS8JNe84AbssgspZVbvtSHec/mtxs6IgjVfsQCmUZCngOMO+9rD
	OQzRH24Rz9LV3Bq0gI/n2vLnMAkEejzfQ=
X-Google-Smtp-Source: AGHT+IHwr7jt3DaVtnfLsqGmmW7FFdKpHCSeTikP3CPRe2wVho/p0Ad6nhxEqMqv/Lasjs4QOtMNdQ==
X-Received: by 2002:a05:6808:3c4c:b0:441:8f74:f2f with SMTP id 5614622812f47-44f96029336mr4760053b6e.57.1762124507728;
        Sun, 02 Nov 2025 15:01:47 -0800 (PST)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dd9a924727sm1210628fac.15.2025.11.02.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 15:01:47 -0800 (PST)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: align sm750_hw_cursor_set_size() arguments
Date: Mon,  3 Nov 2025 00:01:38 +0100
Message-Id: <20251102230139.1720-1-cristiandelgobbo87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align the continued arguments with the opening parenthesis to satisfy
CodingStyle and checkpatch.

No functional change intended.

Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3659af7e519d..9740f2705679 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -121,8 +121,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
 		sm750_hw_cursor_set_size(cursor,
-					fbcursor->image.width,
-					fbcursor->image.height);
+					 fbcursor->image.width,
+					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
 		sm750_hw_cursor_set_pos(cursor,
-- 
2.34.1


