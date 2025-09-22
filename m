Return-Path: <linux-kernel+bounces-826984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C07B8FCED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB12C18A1D81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02E2FBE1C;
	Mon, 22 Sep 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K41XHuHd"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500B2FB96C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534129; cv=none; b=SVRbUH/cY1oPe918Qd96nTnqBp8rbk2ZUJi1SndSTJlGAfAM4oxmKWqs5dKw6OjYBH60cejNn8Y2Ld5ydjqWMzOSrSmrPhZXUwp0PTEYvEV9iW8YK+qdhs7wiuLZIYAggihSh4Srz6wRebuynsI8x0BJIO6SkCniLt+qoAnZOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534129; c=relaxed/simple;
	bh=1fZ7uZviR12rEngACFAWSQEQQ2EujzRN08ukEAfB3yM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwJ9jh9DeVo1oVXcEprAXm/DYOHPVq4Iwg6zy52KrsN4UEagva+r9OvjS0V9fBkVGfZAUhlfjDeRo3Cn47XwHX83eo8FbM6IBceSo6kYHqhVsbx6nGqFu4YETDWN2fe4bprZHVGPYrOKbth1hbkek53njmlhhZoUxCKI3Xj+1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K41XHuHd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550eff972eso2380583a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534127; x=1759138927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knShu2WB1nekyCXSMkQd4YYY4q1/2M50bRHS1z1OFIA=;
        b=K41XHuHdO1kdod3v2kDZ6xADmhQyxvefbQjKSRB4OBC1QuzjrUlWSNAcCILxkF27vs
         AkTqsIyQalAXoWGadaWOwm1NSacTLnmCU9yMWgl2nKGarmeqSslJlf3S3Nh+RJCzVWeK
         a324n3thQ+u7UKF3pH0cDMg3MzdZQMRR2T54WFHCcZfgjJzLVXiA1HyxhH12d5vAAdtE
         ZYfjQh2nItO107Ab+Z1m7b7EwyCOuuQz0hIoXA5DjMf+GPSb7lxuYN2NBJAzxMSYeyWZ
         48I2xu8tKURSuLKg9QU/NTQuw6YGy+xolOlWT8s3rsHyNrF2MBY+WDZzkNXgJ1v+n7LM
         +zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534127; x=1759138927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knShu2WB1nekyCXSMkQd4YYY4q1/2M50bRHS1z1OFIA=;
        b=CDuxk0CztkhuDATs8quhRG4noOrGaZ4DnArxsLa5zLw49dLCQbxQDWSCZOhweY+DAd
         iLtfVQQkjrh1L76OyCSn9y/DjlfQj22Fa94w9AYzRXai5y0iicwPEHj71sdqWoYlAaEA
         D6c6iGbR/YzKeieN/j+Pk1/Nn8MewvcPjc5ckVDHCVaVisaSWtdXTKV8qQKjQzNFa8TH
         r9YygqOzJJy4/IcTJPPJbKqWWUCREvuF7W/LGS4LZdOnDwXcXfNwj35EUZHSpKMK/Ks6
         Xnbsy1uUzvlBg0WAJKHg/ltG0zP3eTXyM3Bg/UOsw8fhrJO8clQsuv0idNx07pkfBcOL
         HlLw==
X-Forwarded-Encrypted: i=1; AJvYcCVwiahA0xG127Sd9jx5piTHg7Fhl1QVSFtbLc+8KpaxepYmudIMvwB4ceOE2H9fYLArPOFVb3n6SF1wY0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjQnCK2cn7sDsP1H8sBmeXb4TUICEEqHsF1azoRKAVd9dMGm0
	1WQAIgqLTMSw+cPLbDk6nXeQ74IlNgkjP1mktE72PbyVwwS1Y/pW3sPTUZEsAdjlbDY=
X-Gm-Gg: ASbGnctbgZww2qWYk1c5aN/k5xMI2y1O7nCI5ResxYSuItS3mxpilesT2C83MdePX88
	hXBuvn30xkQgHnT1YnCh4xL6smhpwD0GMS14BYVQBppyP74TarJkz2L2Xt4J7d18sh669okSela
	wCrgQ/nzMXknOUPk+tStzTSHr7w+zcF3X8+AijYfkr4W98ic4MYHsEJ7DEBgO3RjnX76nZajVqW
	AdisXSkhC4tA3yh58MKjKqdBUrUGyzUIgJoE4zpK1WO6E22pgsCZt7b4GeDYtG4NkHmEd6WS0Up
	/KJnkMlAMQehvldUUl9GJNgjSonMSVkDwOsV5Ved9Vj7m4DMzqmeTEGcodSZdLNodsHxeLUsTVL
	DH+LdeHb52lpPfYLFjCa+MOntwxOQXwjOItwa
X-Google-Smtp-Source: AGHT+IEKQqaW75NwldMxFG0uIxBj1RxwlHvk40EHsE9KBkx/V3aCLEgpZJRJGmMKZpoisXIb1QsxfQ==
X-Received: by 2002:a17:90b:2681:b0:32e:38b0:1600 with SMTP id 98e67ed59e1d1-33097fd897emr15908772a91.6.1758534126690;
        Mon, 22 Sep 2025 02:42:06 -0700 (PDT)
Received: from localhost ([106.38.226.98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55268e73f6sm7544132a12.21.2025.09.22.02.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:42:06 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 3/3] memcg: Don't trigger hung task warnings when memcg is releasing resources.
Date: Mon, 22 Sep 2025 17:41:46 +0800
Message-Id: <20250922094146.708272-4-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hung task warning in mem_cgroup_css_free() is undesirable and
unnecessary since it does not affect any user behavior and there
is no misbehavior at the kernel code level.

Use wb_wait_for_completion_no_hung() to eliminate the possible
hung task warning.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..b7d9e795dd64 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3913,7 +3913,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+		wb_wait_for_completion_no_hung(&memcg->cgwb_frn[i].done);
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.39.5


