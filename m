Return-Path: <linux-kernel+bounces-876274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F01C1B13B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499401887BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0952BE035;
	Wed, 29 Oct 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afb8UI02"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4624BD0C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745802; cv=none; b=fvooiD3MLNgYlv/PL+XXm5cE2jtth3X9HgMeN/BBg6IF8FVjTb2ehlLJZksv65zV1bbX7Cy850uJftz5x4HcOfGnlKcZEyKUFbnp4mbJJ+Dlbfu8s+UXgkwK2SWWOkU2+BDwsYDV/bFYssoEfSLrPbo3neBlO7ac2cbTEOhX1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745802; c=relaxed/simple;
	bh=m5z8JwAcfPmz681g9ABLx9yKpNSDTqrw6F26lbhDvRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pB15/+R482zJoV6Vmp8j/9nHHYnBLG1JGjqMlZ1Jhrs7/D9SVP0OyjUqdd7mEahyVqOa0IKv4/sdtfRl5BGJFBebqmP/AibFk7s7rQbmA2njJI9jCqQnjVyXWPZk33XYg4irJGdOnfC2xjEHNYHlmtnxGNXoJyCmBtB2LNbVlm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afb8UI02; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b50206773adso209878666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761745799; x=1762350599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHRvKX7a1plwcuYKpnQYNjnuqWx3QMHmBPMlGSav5BA=;
        b=Afb8UI02AXrYVevWsAtuzoS7GiUcBDBvlbZ+CojX7oWf/w2ZNKOkEZEZEeClAP6IRR
         rIIPb0F160BD8pVIghA40fY99xPcKlU8Oa/EKu+IeCiPxqnsknPOt8yhybfsC2s3dIw8
         iVGZhUk/mU0kCL/I6tlqRQ1I2yFXEHvFEZUdrKoxOSSXpPEMCZzwDxZgbR+4LqZgWvsP
         IqW00AXXnl3bYa2cOBwlMlPzVv3njnZaL+tWlKDBUMMmmGcF+AqXZ1WWZOAIcf/DZBoi
         fa+dOiafFd9seuRMa1YYhzGBarptxNHkma8ZaKP8kf+LvuMc0YiXFKC8H+2j7pADimtY
         lkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745799; x=1762350599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHRvKX7a1plwcuYKpnQYNjnuqWx3QMHmBPMlGSav5BA=;
        b=aC1LWOLvnv5JKqLJQ0JsWJveZxyigjU83P0EyKrNkP882ldWlLgzU8AbbObyQ5juuo
         Anyqlt/Zd5dguPowvRQ+/p1C0DT/KDYM7DTwuOJLuiZuxFNer4RdQOBI6+AiwKb72yrJ
         5IAnQDSJb17U5jjoQYskRLlIcy7mrLDOJTF7y5ZaNYkPQ3Qu7JKh7nuNTx16qvkDgG89
         hI0fqrjQCeRx+HB0KTrQ3kZr5kr6No0XT3oXhwXrjmgMapVCV2WZ+68+N782Wpz2fo9X
         Sq8lIO6kRlsr9Zvj4m+F3oiepP8KUgTKfWiPns5FseCW0AHTaC++Nou3gcD2H95jbbnz
         iw/g==
X-Forwarded-Encrypted: i=1; AJvYcCXwMFP7tG9Ck+3z5kraok+uM5SM1ydgMxtWJYIKsbaAbSluIzIujsc0HpK/4SWcah1S2zvIwD0QjhvcYFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5sh/vw8UHxMljtAhtXYjiacZvxm7uEP3B5s61LFCtDvlkIq8
	UR4PK5DtbrVjYGxgz+p+tKkLjaIwrp1VoW2J4U25ys8lKvbw17sFGP28
X-Gm-Gg: ASbGncszzihWE+ZqA3AHl8Qw7p7O9kKPCSmKyyI1d1J7dnaOvj6t6g4aaFTF0F9tlcn
	ha8GqhahMjy6ZAExq/LAT9I7TE2nG//ywpLJ4RLK1gvE4BzaIRhLYgxF+AuYnWEThvs6btvUGs2
	TeeBhz390TxlR6+TxsvTXJGtASl5rNdEXU1mR8VpV7tpy+dS8szwTTywTivnHDcQX7aCu2p3/f8
	IUNIAlSJqLQklnhPrQ67/SLvvNMpzuglbX9hz+pmlGTvMe659rvlbkEHfua1gAB6o3djUX7j/sf
	Wk8BtvnJiI8uK5j0zVfAocrgfAdpWAgkrkrtxxx1ZfzVdt0ppa7FK9NN4yrSVAXCUugIIm0ZZDJ
	sFkcISNuR/jrJCqLTfdzRfxyha0NrJgyHOVzdC2MJsiMREADdnAoomrkJmb88z5sYvmoidiW2Nt
	CGLCyTsXyZZ51O1pD8bEtJ9XaSoEpBOy4naFqhyEV2BC2wdyeb
X-Google-Smtp-Source: AGHT+IEisyenenOnF/O/4pE9L/Z9/7BlvbLNLGDTC1ejEMocq+xGj3sGbfBlGXhWWmAIhGAmK+J0OA==
X-Received: by 2002:a17:907:7213:b0:b3f:f6d:1d9e with SMTP id a640c23a62f3a-b6dbbe71b02mr842226166b.6.1761745799422;
        Wed, 29 Oct 2025 06:49:59 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6dad195456sm900898166b.72.2025.10.29.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:49:58 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: touch up predicts in putname()
Date: Wed, 29 Oct 2025 14:49:52 +0100
Message-ID: <20251029134952.658450-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. we already expect the refcount is 1.
2. path creation predicts name == iname

I verified this straightens out the asm, no functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

random annoyance i noticed while profiling

 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ba29ec7b67c5..4692f25e7cd9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -282,7 +282,7 @@ void putname(struct filename *name)
 		return;
 
 	refcnt = atomic_read(&name->refcnt);
-	if (refcnt != 1) {
+	if (unlikely(refcnt != 1)) {
 		if (WARN_ON_ONCE(!refcnt))
 			return;
 
@@ -290,7 +290,7 @@ void putname(struct filename *name)
 			return;
 	}
 
-	if (name->name != name->iname) {
+	if (unlikely(name->name != name->iname)) {
 		__putname(name->name);
 		kfree(name);
 	} else
-- 
2.34.1


