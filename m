Return-Path: <linux-kernel+bounces-800006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154E9B4325B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AFB188C211
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE22270569;
	Thu,  4 Sep 2025 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEDX2+/3"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E727702D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967019; cv=none; b=KkoCkHvnCJXtkErqwDsubGptjDa+lTBIhYDDQN+crfB0i3wAqMmSzPWlQ94LQ8KXFXx374eMgCPBXrqP8iB7q2laCDzd4YTHV94sNrE3a/PxJwZ3t+97HoEQSmnZ5vvY421OgFdU8yx/fyWesHn26nexb8JIW5+nJPcJt0nc4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967019; c=relaxed/simple;
	bh=/EnJgE7OJBZX59ejos7JhFpHDpm1x9yOWxaC8UYxIp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdjWv+K4PTM8/ew2B434TSGRkV/A537bgJYvFKHSQSiunDoJzG+9GEDZnGFu93SklZLjresVXLh+Uyk9g79lCzUq2u8wws2SQPU+uZqR7xpbAKh0edIdYj0Q3GGm14t7g0e8qHl8jmjcThIe/HkG/STUCcjhOYPga2+hXdbSOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEDX2+/3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4fb8d5dad0so52741a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756967016; x=1757571816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpJy0SmFfEmeoeaFkzFs+WVa2Vc5JdK+bPJTBjQhA74=;
        b=nEDX2+/3w6o88I1/2zC/XpxuU2gaC6xdL+klCPa6s70Zht9mP/9n7kqxkl7DbutD33
         TrSwS5rWj5xfHS8Pdts01JTrn3IpXmeMGGdO9AaGp/Bdybxo2pfQ793UaZzYPqSgRJM8
         3WYxy9KlJhsWbBu2smAVKGGt4RsPfxBZgO9nppnJacrAaih0K0cFWxIkdtZKwtl+VbvL
         jelQregH5bqPNh6OePYtBzl0hUF8o59mrhyX0rKEb3V+q4uOQdgsUxyDBhnsfDi7EOKj
         4bqAa6mFx919+1sqcHfRAo8Amwqe1LOdBGXi6ZiXMBI2EO986C2PHuR9WfzyfjLbw21R
         9iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967016; x=1757571816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpJy0SmFfEmeoeaFkzFs+WVa2Vc5JdK+bPJTBjQhA74=;
        b=E1UAe54eVakr9TgInZibKaSRJ/FWoVaNvTaSxjchhgB+O1V02lavo1urWW1+8eWaHz
         zV5xtAoV7Qs4NrmOh+VbXTWSAHx3iAmoSbzemRKoCjS4ICbvzw9asxxRDWnd9NPAcxci
         KpMk1ZnvRfanzKv2irs1O46ID05rdGpPrJJZfDHUK/gYH4fa/yWEI5EGJADTNJvx5gk6
         TXA6JTmMFAKA1QleeH5lphxzSqC4kZOGDt0O6v/ZM2g8+eG4n3gljkwMYNAsS7ThYB12
         r6UtVU1jTCnCnCgrGErZy0HlLXEHLv4Be+jZ/u04XChtHoACP8t5O3sZKsU7R4pZzuVx
         rfXQ==
X-Gm-Message-State: AOJu0YzeOaC5ZXleBBAxg7OFqUzsW6QMf7bKm4KwoAyUFvvju1/7R5qs
	Jv9P6/1XitQh2N0HX0iS3ofsIfa6iwnQ4UXnjGp9XdJYr54om05wj6TAKWXq2nQt
X-Gm-Gg: ASbGncvUPo107iXLA5T4BRFcraviRRC1fUjdNS6eQBZoekOMwJ9YKA0UJD6LBuq9M+T
	AfgFw/5tXbByxWwKPCE0KqOiThZsFgUvjClILD07ZEGMTtYv6YYIoVroNcMy/P+wFDeDW9VGvN1
	LhJGvbWdy9yrc3WyS9Q2pXH3ZMGvq088Nkw9XlBku/Srqt2UBbVtlbzzlRCE3fK7/pj5FOJijeA
	RI7y++IzriCOHL49Rzr0QPIQlxX4i9gns3d7i47lqK27MW02jN2dx1HNL9Pb09sizb+RG8Hoy6t
	ZxhsxO/ovZ1g94bg3RxxTs2R+uaCJBrJ8p/vGfdlu+0dmXpSisIMAzTqSlEepgZq35npQLq8I+8
	O9rnSoPQ/erp6M2a1ceAuKroPoU5OiKsWzABiIzZ+sqqqcpxC
X-Google-Smtp-Source: AGHT+IEBJZvQVehY2sHFoniuE6A9P1WB/bX16Yql21Kl7/uCiWvYj5gVnHq0ENPDwr3ALXi69eZlZA==
X-Received: by 2002:a05:6a00:1c:b0:772:39db:fa09 with SMTP id d2e1a72fcca58-77239dbfb77mr9444420b3a.5.1756967016264;
        Wed, 03 Sep 2025 23:23:36 -0700 (PDT)
Received: from hobbes.T-mobile.com ([2600:70ff:f833:0:8e07:c9e8:902c:6ffa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f0c4008sm10198397b3a.35.2025.09.03.23.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:35 -0700 (PDT)
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Cain <bcain@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 2/2] fork: change "a mm_struct" to "an mm_struct" in comment
Date: Wed,  3 Sep 2025 20:23:26 -1000
Message-ID: <1c468cd846ba6839fea08df36d8d6e9718625661.1756966290.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756966290.git.joeypabalinas@gmail.com>
References: <cover.1756966290.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct english is "an mm_struct" which is used everywhere else
in the kernel.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 kernel/fork.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499dcaa35e..9a783cd46d097a2d68 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1397,18 +1397,18 @@ static int wait_for_vfork_done(struct task_struct *child,
 	put_task_struct(child);
 	return killed;
 }
 
 /* Please note the differences between mmput and mm_release.
- * mmput is called whenever we stop holding onto a mm_struct,
+ * mmput is called whenever we stop holding onto an mm_struct,
  * error success whatever.
  *
- * mm_release is called after a mm_struct has been removed
+ * mm_release is called after an mm_struct has been removed
  * from the current process.
  *
  * This difference is important for error handling, when we
- * only half set up a mm_struct for a new process and need to restore
+ * only half set up an mm_struct for a new process and need to restore
  * the old one.  Because we mmput the new mm_struct before
  * restoring the old one. . .
  * Eric Biederman 10 January 1998
  */
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
-- 
Cheers,
Joey Pabalinas


