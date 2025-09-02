Return-Path: <linux-kernel+bounces-796201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD53B3FD40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272E8486E29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D49128505D;
	Tue,  2 Sep 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="mPAyu8sX"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703F283C9D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810857; cv=none; b=pke+bSl6qfeMDF1Bo+PQ93OhcVnMkAB59LxpUBxVAM1NJEW0CE9N+J8AaiqViGx529ZoAPGTXbjHXDwbzqLXfP73CgsYIJuIjwXoqKt/pFjs+OsswLgqD+tsUIMakGLmguiLG/gNxs+R4pNbVqAs0y3dLzTLX2muSkPE5CW5/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810857; c=relaxed/simple;
	bh=TGflyUFEOFiUqx8BIfQsPKxLGuTGYKbRxXEMzKyG68g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mkc0PfhWgPg+qPKh9/zfWo7DCq8LHAFrkEM8Ul9PJtbbM0Jdgn42zL4AU8w6tMx/4pT2XKjPrqqep0oVe0YULm4u8NLnxv36kPozbUj48UO0W7r7tuV9t3E7Onuoccl8CXEV/Sao82DoJLz8XwdG2PuB8TB5JHym73u4NwoJnmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=mPAyu8sX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so2742289f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756810854; x=1757415654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hUXNYxsmPHfvn2ncRV+JurxIcEZ24THJsmI/NLywYI=;
        b=mPAyu8sXxX8dMXRDUYlp0r5QAxgB60I86Z9VMAwyIjRO0E4xhlAjrfhfJBk920YmIL
         MX+eFrffVzPUTCiSgmcStLMTiKdCfMOGFh4Jpaa0r2fSZflOXl48li/fF3z9J612npZp
         A018fg4rjbqsRSPn8y+ASnTEfECQtweJfJLLz6xj95a17lfz8mUkwZWUSgzGYRgqcZiC
         lamfF3cESeKWMCPDOudrWdqOkR8zggQN8LBU5XwLbbdUN8NqQaUqQuSgU9xYZFeTDG49
         olsqNOBF1cFgJpQJG3KctyKMXIijQhnjhJaGhyvWKri5/QvhCTK/R7p9Dje5gZnYs0Q8
         teaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756810854; x=1757415654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hUXNYxsmPHfvn2ncRV+JurxIcEZ24THJsmI/NLywYI=;
        b=F+MS5Isq9rE6JR+MDGn1yZiSzTT+od/ozuNErOYj+fmKKG/DXFsp7wanbxIfFwQWmK
         T8VhM39tETERHD5RMQ2Z2Qf9pmxb+EsJfjzFtBVfOgSh4oq0SpdgRa+q4xM8mr/28U8V
         1T3iI2Q9dhvEos+QrvfkN8qX+apafBg5VNTfH+tz7JioPlJp0PO1DUSbmpbqH+4v1Ueg
         Wjk5VhaDMOjA5x086lQn04LGcYGd+zKDCatZ7y3gzrAKqwKDxFik6g1i4uWd4+GiOOre
         r0hpZk2lx1ZSGA0iR5DfUZcP6IB9k2I3mYuvqDl9DFQwsvhmi8ss/EV6ZPzjHhBV1Dif
         /1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXqoKt1kjNz89+GlLeV0o+UWVgTIphzyzG4858k+tZlRyHuDRDErMU2JK3s4JJaTTWR9A1QSqYLm9gwQis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdIjzt0Si2GnsbY482VUBb2bb1sJEte0r3qkNufsO6vqgXfDjx
	gN0FFy4NpNBcixNvT+UJPUyA9A8D0PEfMX23Bdw7Hz6Y4Lf4/CPRwiRQV8btgaergF3VM9Iruo5
	wykkr2iLHzdGG
X-Gm-Gg: ASbGncuqU+ijIyLByAHLNHOl20c/AEVLSVGDDNJWwTm6CzUmuCBwu9N5+wgMFXUeBD1
	beGx/lPvsSSjPx5V5HOvZushswtSihQpEQ/EwXTDxQ57nboUlNucJPCqer3oNSzsWDuMPnRNxJn
	e4S/j7kmoF5FYXgRhRDAoGOzKZHyHh721XeJmnaKjq24e9UqSxz3UwWq27zXFNMGWkEJOJiAJlO
	FXqsqXxHP/3SupC9E57Amv/t7DBFaAubPEF3/ApxlSKQ1XmyU47Cbvb+L6X1j+4qw58lbQmGoxw
	sPtgMdHURf2Goob8TPTNERAybffbKJHTymEmr2ZEc8S0fHVOFcvhOh9Zhf+uKjS15dmTytjjEWx
	SL7GNgmBOQ81JxaM2y4EYEGk672Xwx3YCZMyr8AoJbq9uGsdByoYcLaP8nTOCijUckq0TuANfUk
	LaTaikjgicsyLrSL2hr8b+96LRse0meQ==
X-Google-Smtp-Source: AGHT+IHM3xDjBaDs993Sm3AD7Y8PW48gckpE6MbRpRa9a5y0fBrOMm+jxslbINuLX/D1S6JiqV9eTg==
X-Received: by 2002:a05:6000:420b:b0:3d0:9781:6e50 with SMTP id ffacd0b85a97d-3d1dc5a2b8dmr10911493f8f.13.1756810853911;
        Tue, 02 Sep 2025 04:00:53 -0700 (PDT)
Received: from localhost (static-23-234-110-88.cust.tzulo.com. [23.234.110.88])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-723a85aac02sm4211777b3.73.2025.09.02.04.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:00:53 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: paul@paul-moore.com,
	audit@vger.kernel.org
Cc: torvalds@linuxfoundation.org,
	eparis@redhat.com,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
Date: Tue,  2 Sep 2025 14:00:49 +0300
Message-Id: <20250902110049.4437-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a watch on dir=/ is combined with an fsnotify event for a
single-character name directly under / (e.g., creating /a), an
out-of-bounds read can occur in audit_compare_dname_path().

The helper parent_len() returns 1 for "/". In audit_compare_dname_path(),
when parentlen equals the full path length (1), the code sets p = path + 1
and pathlen = 1 - 1 = 0. The subsequent loop then dereferences
p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.

Fix this by adding a pathlen > 0 check to the while loop condition
to prevent the out-of-bounds access.

Reported-by: Stanislav Fort <disclosure@aisle.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 kernel/auditfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index e3f42018ed46..f7708fe2c457 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1326,7 +1326,7 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
 
 	/* handle trailing slashes */
 	pathlen -= parentlen;
-	while (p[pathlen - 1] == '/')
+	while (pathlen > 0 && p[pathlen - 1] == '/')
 		pathlen--;
 
 	if (pathlen != dlen)
-- 
2.39.3 (Apple Git-146)


