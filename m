Return-Path: <linux-kernel+bounces-739715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D50EB0C9F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46F35445CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E62E2F1B;
	Mon, 21 Jul 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JApIewKs"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3C1D63DD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119980; cv=none; b=rCu+CEHjI8U5bAH86YkYfphvRcORxbyI/ERF9hUyDcU0j+Msp5s0KFmFQB8RYAn/10ucit/rBN06aqbK/moB+tzH9Lveski2mONa4ixxTAYX4l/ZWsXSQlretshB8m1G7JrOeVzD1IshzxHPWBjp3q+0ZaCmTXODfvVg/ZSexkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119980; c=relaxed/simple;
	bh=VG2wzmevee0WfQHyvXWG2mOKD385wpS7AUm/tMug+5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DH1z1ohQYKPzlLecBLcLZ7N4Su0j4/hqnMMbeN/gP9fEfSmyySv2uoE/D5F9eg0TueQMb55mufB+V4I7d8LLrOINC98hocb44A0u9PXttOj0wLPGtsDniswxENJ64MNx2QPajX5YVLA0E3yageP5YEqWRHA0coSCIevX/l2u/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JApIewKs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ab112dea41so2726465f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753119975; x=1753724775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgw3RSPzbscvVKyiKcWT4fnqoMhEKUNE6q9sRAePU5s=;
        b=JApIewKsSSKNViioZFk3JqdVGAGOyGLreLfMTs00yAbIraKerjxXG3j70CBvRiLAVg
         3H5BXSZ/Rs7tHkPVZgmaRpzeQJpxbMp3z8MjTlGwD6IAIUAZlfNByLSBdjEnkVYtr46v
         Psf3dsYPo7xKvlX29dlZHQICODX7vrJKBaXcrZOaX196Pw1cbV1SN+DW0Fn380V/QeJg
         mhk1GZ01ngfpSQq5cHfmLwqkSCywQzggKR14DxoETSNrGHbdSX31qWnLffxvpORqiUn6
         6UavntGySRn5PKNH8xJdL+wA0ajZkdYlg/JUIXXN8ZWnTY03jbjsLhNmB9zHkGrpgVoc
         pTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119975; x=1753724775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgw3RSPzbscvVKyiKcWT4fnqoMhEKUNE6q9sRAePU5s=;
        b=Q2h8b99N0EJ0M6LFVIGSK6raIpL0UQN9MKrX4MH13QV13IAVor2atKPvfv9eoM8Pia
         8/tUbwwIP9hvmpVqLPkhjC/P/5TdZT7AqP/Vw8AI2SHb1lx3dLeUZyHD3XPBZzAbY7iO
         VgXBMOEDnenIT0ltMxeTOnPQ4H4pfBVJnnNWk4uyD0q879Zzf2U4xYbP/t/tKKAdE2YG
         xepeibUS48A1PjS6zUsC1VDcmWu3CW0OCIyUcpb53IBNYOtJ212r993ufr8dplH6pKX1
         uAcsJuljQ+3EpezdriKrAYIEmEG+KeWh8pbzIfo2xtAnzgMVeILxCuc72AX+5iaq/FFC
         WEhA==
X-Gm-Message-State: AOJu0YyEAglMIOJ2rDTMEY72HidiDY/y2SiZUKxbtMyKTbMenj8IAKK6
	jGIVC0TWO1c6N7keoFMfXKHrSeK8xQVW0wr/a0huwPApyqQCyxePn8Ta4PEO0Q==
X-Gm-Gg: ASbGncuGZJEqh3V60p4OK8fWZcmWLZkpfZyA13JMbIYwwHQR2s3s2awS9bqzKTaDKwY
	8LcLEniwWcc+4isrcus5xDs7nPSFXKS8hbMd1l/GT/a4YzXDF/FJ0aQeLUBuF7kRD56bVcKJ09d
	zgrePOu1F4EKeKjxymzJABSO5d7HrktcWpINEK7p0YNkX0zvinXRzf33RjJTPKiyL5KQBC/Y584
	eeAZtwJxDtOuLyvbm9PmQ/drAvpMuHuFJTHUrVX2XKVAisLs4ARjAvqtl0KFHSq1IeJgLNXDYs+
	EfCIAT/Ftmz2gvu2yH7oDy0b1lzbFaLlOVr4IUl8SBi8mXx2JpnLBGGTD53vdM+5ig/mtQnz7hk
	2A3uX/QB/NJVW0stBK2eaFA==
X-Google-Smtp-Source: AGHT+IEQGS8oNhBy8aSGhUbAsWFuXOGtfnhE3KzCmBDwPAHrjQbchcDCmkBkjM4tsg3R6C9L7TTkcA==
X-Received: by 2002:a5d:5d11:0:b0:3a6:f2da:7fe5 with SMTP id ffacd0b85a97d-3b60ddc6571mr16446785f8f.55.1753119974971;
        Mon, 21 Jul 2025 10:46:14 -0700 (PDT)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b6b020ddf4sm8819467f8f.87.2025.07.21.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:46:14 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	MengEn Sun <mengensun@tencent.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RESEND v2 1/2] ucount: Fix atomic_long_inc_below() argument type
Date: Mon, 21 Jul 2025 19:45:57 +0200
Message-ID: <20250721174610.28361-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The type of u argument of atomic_long_inc_below() should be long
to avoid unwanted truncation to int.

Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: MengEn Sun <mengensun@tencent.com>
Cc: "Thomas Weißschuh" <linux@weissschuh.net>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 8686e329b8f2..f629db485a07 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -199,7 +199,7 @@ void put_ucounts(struct ucounts *ucounts)
 	}
 }
 
-static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
+static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
 {
 	long c, old;
 	c = atomic_long_read(v);
-- 
2.50.1


