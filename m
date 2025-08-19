Return-Path: <linux-kernel+bounces-775902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4141AB2C638
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5863BABFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619D32A3C3;
	Tue, 19 Aug 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KVJLfMet"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D023C4FA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611420; cv=none; b=CWsYnd7wpAlxgdb+8TpohTeQnmF6CqicpQFL0Lefn3gf3HqHwlqugHT1CRBXVIvay6FiGzSGFN/vU85VdegYBGR9sYep9CYccH+1su0gu4nrmqtEH7zVZeobaGvu1Xv8B4KC/35bAvtVGWsCffR7YXJSJnHCIbPyWeOFaVn7Yjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611420; c=relaxed/simple;
	bh=mojxJAX6rsjDvV+Ih13ld8RxSce7odS8VaL6e3tmPUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QhcWJrGcCQpT9PFQ399Pe8SpZFy5Xw/HEcdVABJ+DIC/YZteH9nbmRUdJteQSmiwAf4RU8v/dYEvKUun/ytwxJwRqnw1BHvIxruqoJtfYz9Uo0JhuvL3aY/0iQx6VlAvsKr94uPjPhZ1Xq+6y3XU7VDJ043yPZV/vXhc1lSA92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KVJLfMet; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47174beccfso4480576a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755611418; x=1756216218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9TJ4yjgH6QJU6NhC4uJmmFxWtgzYAcw2NPkZcqPt60=;
        b=KVJLfMetfqk2lZU0TQ0zUYU1mdiMGOZRpe34y0tIbngs/ng3eg5OZeckWAfM8PkDg2
         LXWf3K8T6ya5OMCOkVwGO1BrsPucJZFj2r/UhayxEdunbirFwB9ZRchyBXvX1hwFHQJc
         lDQKNQvI0iKEqWaTfmHIPHScc2w67oVIxgdqSMTYnrUa+3B3bB7EqUbTOkl7XQh0AJKf
         1CvrwxjXaxoawzP4Q33v7eXX3NlKE5HbEr/P+T98BMvY8hMTgyR0tUrLiFbGnNfI7jtn
         Y0kna1QkC+f+N2VgkBpCFBJ5ehgJ3zmE2RtCHRUEomb0d07UwWuAiP+fdpzbN3LLpPK7
         uytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611418; x=1756216218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9TJ4yjgH6QJU6NhC4uJmmFxWtgzYAcw2NPkZcqPt60=;
        b=pG/j6VH8AJmkEQXjZymZ5eIF2pAwdekBTD6DBloFesYA3HfgxUk7/C5Mtfh7pug1Yl
         DbHagela7fiI6i6wuIRflyQ82moWt2RxkLygMcSbg4uZtbmXQ7pKKto/nxegamy4bSer
         wvx8Wdeq+VyuIfjm/B57+ynZbV2ksDi4+qkrzpl0cQwr9wsuCHy/UBrNcOmKHD6Cf/ae
         IfDdYAoL8n7xFtueHokWeoPNxChyRwKSBn9f88OBQHntr/WuUVshtJbRf9XGOqD8dnY3
         CCvH6L8Tl49mF7wpK16mR/DV6qtxT02EV1knW2WgKBa/ad2uPs6HWiIsQXGn0371WtzS
         7dqw==
X-Forwarded-Encrypted: i=1; AJvYcCX3zMXitW2ma87R9S2UD9aj9OjDghYc34YP33uXbx4jmSKeKCwQHfcgQvnHn2/1wrpK33wPjVI2nf4FSmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvw2J7H2zvQhRDjTboTrm4rPSfLlMLM8YVONBD6J4gIQEyKpwc
	vIcuchVEKztmK35woo4LG/fzgPEhif3ptrIS1VVGcf2dXPgQY23G1lcARyUu+stxYfc=
X-Gm-Gg: ASbGncsi4DRbjtebUc5ZqUrSkagod5DkIaaBPVIBtnuo7gzqs/fYlZNAGhq0urNUmkt
	FPPFgy5DrnIbZb5nzl2Tgw23/TzavfpoE//5azV0SOBfgLozUv/DRV4sKmf8ffIkNg7QpD7mUNj
	t9Fri7t03YDWci2emWQ/N2YWOqHWpvuHib66IcmnC0+i8ivCaINBWfXgCin2uXwwY1r6tB5EDCN
	gbYTvEUN9QGwkM1P/k55irX7S9NvbFM0bCaPrn+vH64Nd26XnVsAOyIrrQDmrVUCB3V6f1s0XUH
	sqLh2Xg+fuhJJYMGUVoWyJ8a5Gk8KVkN8fdBxU1WmYYiTI8u62NS21EoODZsfM48eXBvE/h/pN3
	fzduCy7a/b669NkdIwmwwNgCqabCF1KGv9RnwS1eHs2wh3RNmBRvJHXSK
X-Google-Smtp-Source: AGHT+IHZy0Y4108SytN6YUHUMh4gN5FYzipiyPM05e4guHvSQuE82DjG6I5AZlKeM5wR3Grwk8hS5w==
X-Received: by 2002:a17:903:2282:b0:240:a504:cb84 with SMTP id d9443c01a7336-245e047bbe2mr35948055ad.30.1755611417766;
        Tue, 19 Aug 2025 06:50:17 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5533c4sm109937815ad.140.2025.08.19.06.50.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Aug 2025 06:50:17 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	linux-mm@kvack.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH 0/2] riscv: introduce percpu.h
Date: Tue, 19 Aug 2025 21:50:05 +0800
Message-Id: <20250819135007.85646-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current per-CPU operations rely on generic code using raw_local_irq_save(),
which incurs significant overhead. This patch optimizes 32/64-bit paths with
RISC-V atomic instructions, reducing overhead.

RISC-V lacks lr/sc.b/h support; without ZABHA, emulating 8/16-bit operations
via lr/sc.w would require complex mask logic. However, data shows 8/16-bit
per-CPU operations are extremely rare (single-digit counts in boot and
hackbench tests). Thus, we let 8/16-bit ops fall back to the generic
implementation, avoiding unnecessary complexity. 32/64-bit ops use direct
atomic instructions for performance.

Yunhui Cui (2):
  riscv: remove irqflags.h inclusion in asm/bitops.h
  riscv: introduce percpu.h into include/asm

 arch/riscv/include/asm/bitops.h |   1 -
 arch/riscv/include/asm/percpu.h | 138 ++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5


