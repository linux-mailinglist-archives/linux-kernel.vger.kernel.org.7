Return-Path: <linux-kernel+bounces-771502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4ABB28812
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054653BD736
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB925F79A;
	Fri, 15 Aug 2025 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3JshFoO8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD1202987
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295164; cv=none; b=CaJ38gprRafT2nZl/Y8MarsQfkSDRuIgFZ0x0peicl5JhJw/C8iv5iADcnxnC4t+I7GEU9Qnz10yYy/RA7wyxGmp4pA9xXG7lYHUv+LapQIPO31wuBg9FTDPVWjljSjQ3qVyvccAjJdps6IB188Dws4qiM9qc92JznytbLQH/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295164; c=relaxed/simple;
	bh=eGE091K8LGGnRtF44qmFxvlXcYqYcB9LEN1/CrUs35Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qznf73lRlL4gFkM6XV1g9sEg2gTg+7do0cQ6VOp5c8Ttd8rwolFQu3HOqYUxt5ztuMuiNxk8fxdHlTzHiO9M6uXhnmI7GUSJaMr3fEZ/eiA7Z5nLF1+rOapoOtSoAlGWLY37zKoiDv8D+NbSfqh6gINl3xFyWu6NkrrMqz2EPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3JshFoO8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e1f439so2232325a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755295162; x=1755899962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DeW1hinUZFH5xo0Pcsfyi8Qr/5QxONJwH9+uEctWdNE=;
        b=3JshFoO8fBuAhYSanqtYfPXHCEAhR6R9NZUuEb67KG0RwfrmHIwFI8QQimUGaXW0ub
         lw7ZKYbtzJh9nqzAPbrTND7rg6vw+ImRuGNfFGmlIxKyyOLgSGUwJ6drKtXrjMjhwAPm
         NsoHtx7PXIORh2TglGRSvXWDHd0rb4yBU4GAuFuc2NQZWToZjptAsqR+enagt0nsZN7m
         i6WNA8tvsWdZZCtgmAeBbyv+kK5Mv3bp0bYAX3/IdlTnhbZcwk/SVCtCUvjKEp/d3Zii
         PchZ8oanrOM0QQvYnvHEsdLJHEXw6rw1N+PkjJYqP9t7jCtRQajcjBItFaOdXvrMTtLw
         mXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755295162; x=1755899962;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeW1hinUZFH5xo0Pcsfyi8Qr/5QxONJwH9+uEctWdNE=;
        b=ZFNXROXCPEqZ4GYEF0+buWx9XGpqP8dqnsaWJDKhEMj4zsFEvo7t9pALZyc/jKAKNl
         CYjARYJdmw2W18dgz+Rd5JJe4EpdNL3Yu9Ueeiz53AIZ62PHX4nz17zzCkCY+OfPBp1d
         2960MZD2SgYCw6UAKxY3Y6eBseTpAid25IvjIpOAzZamTvefKnH8uCP3Z/4CDU4sPAc3
         sYLspxAfUT4vsfTt/CdYu6Hr6sJ5AftzV9H1qidOTpyNTkpN05HRWcFhDPHICboxuXpJ
         /tfR3ehXJ/NKkdHJdXrO+28OiM+mhVTnK60pfBNpupGcjDxHF5Q/Jh2+pRpxMeeVOaQR
         vnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX33cFlcD2+wsMgyDUIptmFftrnrco86B/Q0YAld3vGdhIqwATiu872sSslk2y/fyZcZd0PLoVasjhVTPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12nr3DP7ESJ4L6qosucKOTE2uA9WAwH3f+54hV/fgL5MuROKu
	Y8SlIo2qJMfB/tWYG9PohKfeZSWNH8r3UwLBq6ohii/8aNFsuwmKIwQKRiH8OREzzX7Tcm9GpnO
	F0nP1NqkAnzeXSufu7CY7yDmiVYLpJm5x6g==
X-Google-Smtp-Source: AGHT+IF7W4Ic4QzDVW1k6cnS1X7CAqCEfRJLNt6vJbRlq09rPQM7OjZfHM6WC0Rg3oYE7E9w+5p83hp6sRXF9TOTaF4m
X-Received: from pjbli10.prod.google.com ([2002:a17:90b:48ca:b0:321:cc91:ad5d])
 (user=axelrasmussen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2808:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-32341ee3103mr5225173a91.15.1755295161789;
 Fri, 15 Aug 2025 14:59:21 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:59:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815215914.3671925-1-axelrasmussen@google.com>
Subject: [PATCH] MAINTAINERS: mark MGLRU as maintained
From: Axel Rasmussen <axelrasmussen@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The three folks being added here are actively working on MGLRU within
Google, so we can review patches for this feature and plan to contribute
some improvements / extensions to it on an ongoing basis.

With three of us we may have some hope filling Yu Zhao's shoes, since he
has moved on to other projects these days.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..8e987f2668cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16058,6 +16058,23 @@ F:	mm/mempolicy.c
 F:	mm/migrate.c
 F:	mm/migrate_device.c
 
+MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)
+M:	Andrew Morton <akpm@linux-foundation.org>
+M:	Axel Rasmussen <axelrasmussen@google.com>
+M:	Yuanchu Xie <yuanchu@google.com>
+R:	Wei Xu <weixugc@google.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	Documentation/admin-guide/mm/multigen_lru.rst
+F:	Documentation/mm/multigen_lru.rst
+F:	include/linux/mm_inline.h
+F:	include/linux/mmzone.h
+F:	mm/swap.c
+F:	mm/vmscan.c
+F:	mm/workingset.c
+
 MEMORY MANAGEMENT - MISC
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	David Hildenbrand <david@redhat.com>
-- 
2.51.0.rc1.163.g2494970778-goog


