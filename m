Return-Path: <linux-kernel+bounces-817728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0EDB585B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A8C1AA74BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FE228751B;
	Mon, 15 Sep 2025 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Slh5TKcJ"
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AF320F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966964; cv=none; b=I57BVAnO3/pg0UxVmmJ15pPuuqHT0qf3gs3qwKcB4Oqc5a2p+QRKc6gIuQcnIz+QVdyOpc/yjFG4LFqdzhSGCxoepU71hyz1nKj8qR4ZAOEZ2V4cPFpaxsw6b2JRUkdbl0BES/jcIf0mfXcflVbkaXPdjDunF7UFg2c1Cuyk9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966964; c=relaxed/simple;
	bh=Fobnu558txLFiN/zkoPZ8no7tLohQ5HWSoUnVfqVHKk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R//iWOGBtRPwn8bNsSndp37w67c+W3qyMHhHVqb4FStFJqDywop4zNnyFmfX8rKKvFfBpCSstmdHtBvDwQSdkxMajCLFstRQtBuUOsig9rw3EMmGurhISiorzjSCuOCjpiixn4iEPDigo+1zqdL55LbkDzgtYmezKg/FQjrOc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Slh5TKcJ; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-632d1b023d4so644390d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757966962; x=1758571762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmQFBQOU3sbSfIW0gfUABdqH2f/LLX/ec2YX0nMZUmA=;
        b=Slh5TKcJFkZ/d9cG1JJU74BBHfQ8kQep61Sv7E/vTiIrKYiukidafg+tnsWXnIh/TL
         AaJl/xGtwCYdebcyp6DTFm15gCxxgcAZiLDSy61eVOb8XryC08uhgIvWDNpB2JxcqQ6n
         5e3S2FTJJ4L4Ft7zYPJBBWvGAfh73n61qeHW0/E51lB8oihj5JbyxDZ/MJMkcG6+EI4+
         Lr2YeodX3Cni3VrBF70bug2uZNYMHSyh1cov4iKtJQtvc73Efyjz0O3JSdTx/EcBbivZ
         WUEU0W5j4MGih5VAGk0eHUSQtVhw9ZcOt4ZdJxHDUHTe0kz9Wdz25uml4woge27mHQv1
         MyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966962; x=1758571762;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmQFBQOU3sbSfIW0gfUABdqH2f/LLX/ec2YX0nMZUmA=;
        b=SvDorKCfzF+nwryV+ZnugxajLyQvfDEsyiOJYgYQDvmaVrT6hNFXiE7gZQbnkMK1xK
         4vewAO6t0wesi5mr7YQib4K/djb4sRRVtnLPv9Kq8mAv3a3XBaxffs5DnXQt/TPqCKzQ
         qTC7rA3b3BgTyLmGE4hcMubcCJgx7aMmg8fxmp4VDUHzx76ePJzVVKrXQpJec2exjiQD
         tqVDWxRWk3fdrRYkEJ1WE3Op41jvG7qw8BcDdYLGgWsJUD9O4v2ffNDR6D8TxpOoXKks
         nLn0wNf3Yl65T73gxjKFu1OKTyURkj4WNJEuaTmOOtoKX6+CR9+RBL4ytbfJEjHIHyvc
         P92A==
X-Forwarded-Encrypted: i=1; AJvYcCXT6bONwLHm3kGTTsCsY+P0PZpEW1wyH1V99e/5GYCRou5LUZ+vv1N/JOByk1bU0B7w1Na57j3S5cQ2ptE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywouwct1+tQkRh7Renv8q4n+CUK7CAP9K+P/WzdkWJoD3vGYj+z
	rMwVVzv5euRLIudT8eywZG50z34hDQICcbvYv96+ryBiuZvlI64jdD1Gx2XiJTFMafzHu1/lc9K
	HkijV6A==
X-Google-Smtp-Source: AGHT+IFfkDS+5yJa97rnpCK9X9oH9mDCgwcvJD7rMR+X3QCodaw6DtIogjSxErvfJVvIxP4SKHSMVtQ9WRc=
X-Received: from ywt8.prod.google.com ([2002:a05:690c:9a08:b0:723:ac0b:257f])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:1246:b0:62d:cb07:f098
 with SMTP id 956f58d0204a3-62dcb07f103mr6632562d50.18.1757966962125; Mon, 15
 Sep 2025 13:09:22 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:09:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915200918.3855580-1-surenb@google.com>
Subject: [PATCH 0/2] fixes for slab->obj_exts allocation failure handling
From: Suren Baghdasaryan <surenb@google.com>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev, 
	alexei.starovoitov@gmail.com, usamaarif642@gmail.com, 00107082@163.com, 
	souravpanda@google.com, kent.overstreet@linux.dev, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fixes for several issues noticed by Shakeel pertaining to slab->obj_exts
allocation failure handling in [1].

Patchset is based on mm-new.

Please route it via vbabka/slab.git as it's relevant to Alexei's patches
in that branch.

[1] https://lore.kernel.org/all/jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5/

Suren Baghdasaryan (2):
  slab: prevent warnings when slab obj_exts vector allocation fails
  slab: mark slab->obj_exts allocation failures unconditionally

 mm/slab.h | 8 ++++++--
 mm/slub.c | 3 +--
 2 files changed, 7 insertions(+), 4 deletions(-)


base-commit: 9a9318f95d63805868bd21e1381d68c3a75d03a7
-- 
2.51.0.384.g4c02a37b29-goog


