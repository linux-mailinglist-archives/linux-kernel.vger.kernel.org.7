Return-Path: <linux-kernel+bounces-881273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0DC27E17
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A401A20A6F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392B258CDF;
	Sat,  1 Nov 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBe9wCmT"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8D18A6B0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000497; cv=none; b=jvQ7PeEkPeNG8YQeSdQiTmFrt4kpuaHmMr1KPgzQEeHZJTgI8G9iO7TZCdhBdBZN0EEC+vpjzAT5iciZ06vVqQYqmL/GqHTEPmG/G5/nkx+709bz7Uiy8rPgwcnbX88GVsnJj54HJMOfL8tbfVvDDeFGs3rFzVbLXoZrFd7sqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000497; c=relaxed/simple;
	bh=3N1dsCetmnU1o0lxzDJboAKfOOCYeqJH56CJ4Tq3oQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kLZlRxe9u67dJsqAFzI7nHXTNnF1hz+drOn1XCOS613PA8J5KtFVHm+nCNRX8EaNXjgp8KlBSpu1r0hHzx+njxHDfpPZ5YDVqR9E8i6L9DZYWiquwaWaOn1ZT5Ji+S8lauP60QgK2lZfOpTUHhIUazcPTAeGvZFq+tbMManLa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBe9wCmT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33257e0fb88so513826a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762000495; x=1762605295; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnLS8JviTTntLU/+ScBcdjKwzrgQXoMGvPsnh1PV5oU=;
        b=cBe9wCmT8BLhvDttiMowy/mz5071YTzrMOJhq33ecDHa74I1dKTBOq5+cB5+7OwecN
         IbaKJEuV7YmE+Cdgglai6xTwrNrF4Qe2oKDmr5VmQNy2woQnmDCI61lxO2gQxXE2MLdt
         lgNvK3tVBFhhOpDnMRyKOMfCy56LQ5KdUVNhYq0/h026EXFwfdTI7XzPQw51Ckl04zVZ
         DlWhp8DIiB6jyJBtLl4Nai0Re3cl4Pu2qnqEXLd6uMLfmcYLykd/fnqWgX/T9VcNc+6r
         NGTI5RRfcYCFXIdEy0VoxrQCgyvZCA58F8Ya7mbNdO3zq4Tmm6lXX/bjm5QDclDMLBva
         L96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762000495; x=1762605295;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnLS8JviTTntLU/+ScBcdjKwzrgQXoMGvPsnh1PV5oU=;
        b=BTtXcTOV6UYo6GeX882sPBmrLtxAo5soc8l11KQUAIO37ka+vY0LNOmqCx7aGBuCxU
         KyXz056j50crC6D+iPeiAsWXg3UjvQDWdOleNZOJ0G4cGBERJ5brWuXsQJCANwOIVsnD
         /0F8XbCg9RA9vO6/qsndxWHvu9IdzzsPh1UDlG3pcvBv9Mi9ySubneiVqb/NAM2wGf7W
         3P8KP0EC1dUcqqUFYbSlBVWGfxkHDPOdKablHIIcFFgd7feiM0UdVvq78eGW5TgEPTPx
         5Ir2mi/Y8jBdmlp/Sv57m9VRwjgtEPtThYinP4hHTvyl0Tk7QbcVbuE+iIcaFR4+DvuQ
         5RjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAhvEair+s5ujFSWQ2P7JeDYICtNBvG/rUeo0YjqbTpcy/QlRVNW9C/m8RbcBIXM+nTCJ5RJ+4CZwybzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFS4TmN8LXcukZx9g7VigwzFqgN9UVjKs0abjXKXdyE0dguwgf
	gEmzbTPJHJ4O/mKsxxTKbesOJxCwrEitDcdQcCINU3618NRCrZRp+R/V
X-Gm-Gg: ASbGnct1Mmfl0ChR1sYkLNqWrGYFflDWJ55dHR60SUupauw7M5l9eYUCujc6ubzK/mV
	bOAo3U341ebcukdZl+ZZBITHCAwjRkoqq2su1pgf/BvQ24MreqHIO219TU7HolfliWzQ4Wo4ER4
	z/eI9p5GQ2EY3GWIH2gGyRr34qb2AywiRI6/YkHCh0osn4zdmm91Buj7rnPO6qgWXd/wRCQfmRX
	M/nggFMYKeSwXTF725cJcqCZ9CYZYBWXxj9JQUFZbr6ao5BFaKzRUKa/rI9nTdBIZlyb65Cj8AM
	SB3rsuWKT2xX6Bu9X3fcccJeh76pvTZKY7Z99eDV7jJlfCXqOIlHR4lb+3gfNqZX5gbiAjjVHQZ
	7KCxFcMX8m2tpcnwkWOAA1qoVXsc6noc9sTcx456cCNbSkYL8UcJbu5yCGi/7iqwaWZxi7GcBHv
	oC6NlA0cFirX8zyCG8Xw3vndKrA5uis0xq1V4NXKgLYeMtSAAjKOw=
X-Google-Smtp-Source: AGHT+IHAig69PR5yQbuLr7b/sEUjdvnUxJTs4WRxHvLapUYS6rJ7Dih5fdGfCR8hSxlRyr6KbOKqxA==
X-Received: by 2002:a17:902:e74c:b0:258:a3a1:9aa5 with SMTP id d9443c01a7336-29519983b30mr51352275ad.0.1762000495091;
        Sat, 01 Nov 2025 05:34:55 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:9fcf:a95f:918:2618:d2cf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm5214017b3a.60.2025.11.01.05.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:34:54 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Subject: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
Date: Sat, 01 Nov 2025 18:04:46 +0530
Message-Id: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGb+BWkC/23Myw6CMBCF4Vchs7aml2DBle9hWExgChOhNa1pN
 KTvbmXt8j85+XZIFJkSXJsdImVOHHwNfWpgXNDPJHiqDVrqVkmjBHsXVsKH6NBOdEE39p2Fen9
 Gcvw+qPtQe+H0CvFzyFn91j9IVkKJ3lndSiJjEG/zhryex7DBUEr5At3Fan2gAAAA
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 Ranganath V N <vnranganath.20@gmail.com>, 
 syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762000490; l=1285;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=3N1dsCetmnU1o0lxzDJboAKfOOCYeqJH56CJ4Tq3oQg=;
 b=O+QB/ScnRgMqKFitJ/sV6nRIc4x7T+s7/bpJgje2LlRN5UfLW68w1jqOzw+VkinVCn1+PNGit
 A+tGjqJO1PdDVQ4HIKFi3S48sUvMrpJQI2VejMaV/TNzuRGOk4l7hfe
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix a KMSAN kernel-infoleak detected  by the syzbot .

[net?] KMSAN: kernel-infoleak in __skb_datagram_iter

In tcf_ife_dump(), the variable 'opt' was partially initialized using a
designatied initializer. While the padding bytes are reamined
uninitialized. nla_put() copies the entire structure into a
netlink message, these uninitialized bytes leaked to userspace.

Initialize the structure with memset before assigning its fields
to ensure all members and padding are cleared prior to beign copied.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Changes in v2:
- removed memset(&t, 0, sizeof(t)) from previous patch.
- added the new patch series to address the issue.
- Link to v1: https://lore.kernel.org/r/20251031-infoleak-v1-1-9f7250ee33aa@gmail.com

---
Ranganath V N (2):
      net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
      net: sched: act_connmark: zero initialize the struct to avoid KMSAN

 net/sched/act_connmark.c | 12 +++++++-----
 net/sched/act_ife.c      | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)
---
base-commit: d127176862a93c4b3216bda533d2bee170af5e71
change-id: 20251031-infoleak-8a7de6afc987

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


