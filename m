Return-Path: <linux-kernel+bounces-749336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8585B14D11
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F1D54400A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544D28EA72;
	Tue, 29 Jul 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLnLqxjO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B4254841;
	Tue, 29 Jul 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789037; cv=none; b=L/J//XQeet+xFZoBI2xsZXoLz/EGVQ0vh/GJtDeDM4bX+f6Y8GrKWUGO6/TgZzeycZq5osUk0jvx5+VpKCt6eiWsYvGNkV0vaUKneweCEBjXjuB1Z8gWlhTTQ+tU8HYKw2SlWvRMZWTbjujeBXhWKEjO02rhftaR8kckU2rVLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789037; c=relaxed/simple;
	bh=/I/3lRQllP72A5X0WY0LzC9VCCzliPkA8YXx4zJGUak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ODNBh05dpViEMOCIGpNKYxs5LoxZoU7Pcmdf5kQgEeZTS1X4PF2j2lq3h38YnRK3t53nl4asNxoZIYunaCgx/c6GF0fU9cF0kGkZ+sp5HJViCnCXwfpuEgqGmDhy/bzeLS/1kotTm50jh6AAQS0kJ93u3wJc2YR8tRPfWVsT0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLnLqxjO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b786421e36so1630991f8f.3;
        Tue, 29 Jul 2025 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753789034; x=1754393834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=82PZg+jn8HogNdX1n55QmpWvuIVlwiMmxAyRaB0Qomk=;
        b=TLnLqxjOjwFWM9mwkQ/oRdrt1sgGJYFQNlNmzTJ1vfzrAIK0D302uSAwzJR9lKPAAs
         456o543AiYayxnMzy09btNeCsclX0rMrwGcDmtEaSr9YP9pCnJsVZ9t3K4RFkVXrSzGE
         nHOepmEl117Ty+BiKlA3Zzruqv2OpS+7bgiRH1xm8hxCQERnMwW18mTlkE6AAmUGd+BY
         6E8QHTGeGc4uV+onZLN9Qu+56tQYxBhqd1M3R9Ue2t08PdXiBaYK3agfGsaxi1ZsSxSP
         K7PRVYoPcz8H0OCHVaAMiNq8TAkLLLfnSJa/7vP9a9qF7mxzAVdeVxgpd9xS18ZK2w+G
         jWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753789034; x=1754393834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82PZg+jn8HogNdX1n55QmpWvuIVlwiMmxAyRaB0Qomk=;
        b=VbK777LUYu13lAWrMBnadBKjHgKmJo70raRMF/dgRcMERB9puWPiAyRAoFCW8e/8cH
         H58VAYM8AnZDEqV7hg97crvfoHJR/wve1rQHKs/HpaxN06d9HhJTOm1K3wpH4Onbljjw
         8EZEo3YR6FUyNb7KLxDVtONgggIfsFBTBcTN/qFn9Okj1WUsTlJTtRWhkkAmycSBpCPO
         /MAZQQsQvmWi3bi0YR2Xj2igpNmlwUz1DX68JlPf9tw+b0qztZ1G1N/By3l019art7Nd
         pZ4EqoB8lfdX8u6vEglQvpEMXBywoHpmmdNRhU0/w/QnExIa0WTK/rp6aI2odF8ALyFJ
         UwJg==
X-Forwarded-Encrypted: i=1; AJvYcCXDqBjwL0e8TulcB/5JU2j4q/TGMVNlD7ija0ZbDjxPPbRUZdXRl0D0Ik5fHmrH+j5YIIhR2BYY27CE33I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTZn3vdtLqlGUMIILGLPzFJm18LEAHtKkedeMqLNZr5jlz8Sp
	gkV3FrnqOQnTnnli7FmcbOujHhFXDbaP9PwwxM8NcvQC2cc9Gioog/pqgJrLmjLLnvo=
X-Gm-Gg: ASbGncsiXRF/JiweSIKbBxljValEPryI8ERtKH/qDktwszEQwEqzkKQBKcMNRi6Du/B
	yFx3dKRNnyUP8zsp9St942T/tRDpW06jbcHrtfuDA8bZxs6XWFlaGkyaqzsrCkYODxQpdIkZNf5
	zfdOEDaLgjyhbPV5+bSVjTczXYHgjdPduWMHdqUHHi6LdYvFowtrJ+SpZyuAoqlIZZZkJCy8UJX
	a7ssemhX1Lx9g2SQbWEqjSCfeSo/Qz+MzshwSqNDkfwT5b6iQJCZOGqSD8wg9DrQCk6586qQ2dn
	paBRLXarKPq+BZII+Sh/88cEl2LZ56dHPb4OKpHfrkFUbuHJLIJLTzCuP55FKi2N8pfaO3DIaoN
	5xqtbudf7dnY7SBZl+XG1
X-Google-Smtp-Source: AGHT+IEDa+buDa8F4eLuKsd3bGhw5GsImGtsI1qdvYCFJXRYtIm/Nzj869XsubZtjNbfKnoTVeiz7Q==
X-Received: by 2002:a05:6000:e52:b0:3b7:942c:5452 with SMTP id ffacd0b85a97d-3b7942c565cmr296610f8f.41.1753789033650;
        Tue, 29 Jul 2025 04:37:13 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b7887285e1sm6621429f8f.65.2025.07.29.04.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:37:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] gfs2: Remove space before newline
Date: Tue, 29 Jul 2025 12:36:38 +0100
Message-ID: <20250729113638.1925201-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a fs_err message.
Remove it

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/gfs2/glock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b6fd1cb17de7..09af1fe12503 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -733,7 +733,7 @@ __acquires(&gl->gl_lockref.lock)
 		 */
 		if (ret) {
 			if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
-				fs_err(sdp, "Error %d syncing glock \n", ret);
+				fs_err(sdp, "Error %d syncing glock\n", ret);
 				gfs2_dump_glock(NULL, gl, true);
 			}
 			spin_lock(&gl->gl_lockref.lock);
-- 
2.50.0


