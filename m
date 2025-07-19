Return-Path: <linux-kernel+bounces-737915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C963B0B1E6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21D67B282C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84D21D59F;
	Sat, 19 Jul 2025 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxLEeSUF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D267FD
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752959279; cv=none; b=otDAus4ySsqyvXNYhAAUtM0GrYqZq6F4+37GYOXpnPzzJk1LKvaKMe12bkMgUqmrokHNgQQNTVXO4ugEzPGtEEwaVkEitG4UO5zyW4TUmNM+//V27mgyQLRMNUfb39XJCsCCcZ6BjzYcWehQY+yXi4RURUUNd5VyRbFExqcoib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752959279; c=relaxed/simple;
	bh=ArmlKBfZxNbUFwEW2lqId3JtnhwJvHXQ87OQu/EuWOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8uBJnW6fI+AMjzskrsyrWeje5BXOtTlFjlsq21SGysKmo3AxYZXi3UJ8IRe5v8Oz7vupM19Kz//AS/FYyjnwi4fGAlgMV76vS0+X/U8Oq63omNUDug9IWjFppCo1IML2hivtZs8RGD3FsLWk0+bdo0dgfi3uXQWzhVIsy/MzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxLEeSUF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3203834b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752959276; x=1753564076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mVvefwE3oIc/g0ArxrNVtUMZSMmqcbF63rhOC+xvOF4=;
        b=gxLEeSUFUPvBysO8Kmpu4F46dEsOwQqOEYLRlmTOcsFCYDJLsIud8/CUPVGV7vYKd/
         n1GDogzs99RHbfC9bA76/0uNlXP/oQlyRW+57nchsWVz6jtwnpcoL2o6FQD46mt2eoQO
         LNl4teUvtY6vpr3A4+a2VuGe8Uf/caYi8+V8YtwV0IL5t+XzlkMhSveXwmfg8uPVMSkD
         3919R0wSqv9vXD87R+6g2JI+AZMh1014rGbS3zHDDwI4dEZZegt02N/HVw3XmPjGL8bQ
         sJljk5/rmiXujWaNMV6i02tfbxKfdEZgnTac/G5+VI62DJd4UElmIaTCM/CH53hoHcJU
         1EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752959276; x=1753564076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVvefwE3oIc/g0ArxrNVtUMZSMmqcbF63rhOC+xvOF4=;
        b=J9yImzmmw4c54rbW7iTz0mueL3ND0ITEHKXkUNH+WhaPOJC/E3AxiM/EZGcLMHSgHd
         IyS71eaO3daR6wFQst/Y6wKw3Evf/qQl2Pm/pavEmKJbvRgdovQ/Cmt+pC4b4Kup04B3
         5XIJCdKMvZTdrhNmQKN9NMom9JP1spuySRfIAfd8lWNEg3fRpYrn4RMJhr1BuLxG2hq9
         +CCPCh82q4srp7T88ig69DmYI7mtBzZh+7kY0wZN5qNQEBNc/DDSLR25GiKDyimRzA9B
         vEHnMdV1jXwcTjOHgIwtmTV2XhqR0qFJ3+obow8Rx0FswU26f3LKO5C1G0hH0PamvKtJ
         XMew==
X-Forwarded-Encrypted: i=1; AJvYcCXeGNyTN1Y6ljpsZfvojV65SM0xHqXwoSbWBnCw7USxoj7ebI/b+lurSGQVhHyeQxzFZTJIDLkgwG/j/04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEYth1B4BmTratRr3ZlfLb2dISbVUbuHyrAq/4+lf2/DbwDmty
	MPpyZ8Hz6CsU6UEfkuwi9VuJqN3RINwb7dJ9MIu43BGDPUY8QQPABgN5
X-Gm-Gg: ASbGncv7vzY1IPzUgF8cxucKThpoz6urwPFNk7pZ2I0TvTDvuaYr0QQvHECHmvkW8Fe
	YiUVOrI5sJMPC/SwnbiZhlSXdsYDhUAZWa5lI0QYfN1uaYy17SzXXJoMl7Gz3nEBw2Bm4NFdHdK
	7Ynkdk1CkeBX9jB5neIzdPDXAap1CvzbcbTgooBZBOyhFSBuTVX7qpNA003JlXBIfBAx2ngUpC6
	Yl0I82F0Jp9STueawf1Kvc6ME2aH1GXO+hIkdeNlve3ucbC155p0KviccETv8ahPQaSOlp4e6yA
	uzA0ZPHNCZFNL7Q3Xkccz0drIvlp3Podb6ye5ZOsgZIGGXhXC4KIlB98eqP7LPyj2fvDcBarWGJ
	sI0/E3Tx9aWbMuw6uphtWZED+7CEb3Z3e
X-Google-Smtp-Source: AGHT+IESZ8LjsFQjwuooBZVsZ2XSPU1XbY+rDgrL6H+xeC9sOe1kpRwLu8GR06VaM9m2guRutS8obA==
X-Received: by 2002:a05:6a20:2450:b0:220:1843:3b7b with SMTP id adf61e73a8af0-2390c744f29mr19156111637.4.1752959276328;
        Sat, 19 Jul 2025 14:07:56 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2727sm3195849b3a.33.2025.07.19.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 14:07:55 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] sched: simplify sched_init_numa()
Date: Sat, 19 Jul 2025 17:07:51 -0400
Message-ID: <20250719210753.401129-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

The function opencodes for_each_set_bit() macro.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b958fe48e020..7dc3c79aa480 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1932,10 +1932,9 @@ void sched_init_numa(int offline_node)
 		return;
 	}
 
-	for (i = 0, j = 0; i < nr_levels; i++, j++) {
-		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
-		distances[i] = j;
-	}
+	for_each_set_bit(j, distance_map, NR_DISTANCE_VALUES)
+		distances[i++] = j;
+
 	rcu_assign_pointer(sched_domains_numa_distance, distances);
 
 	bitmap_free(distance_map);
-- 
2.43.0


