Return-Path: <linux-kernel+bounces-788162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E2DB38081
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6141882F22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F334F48D;
	Wed, 27 Aug 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pm0xyv8A"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FF28C5AA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292693; cv=none; b=FMihckngqVYfiCvhLKt13i414XQE4pVfgXWB9jnkqZOn4e6+n7zyPVlF6h22nY14hXte+u/IA4uCm9KyYDIF4Mvd0Xy3OVKMkOs4W4ygtjrj1J+B5optvPMSbWlCkj/ii7aPq0pGbKJcpuiJDmq3P0MzIpsJ6oy6yuWofl50KXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292693; c=relaxed/simple;
	bh=u0Do1Knty1ZEIrnS/5ZXWaWcBKc4NUimqPyJICkQy00=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TMeR9kQZ9k/JE0WovzI3KjxunZE8P04yjZX45Xc+Bd0/in9I6duBppgFFHwEEFswOHfSsxtZPLrDnxicRWvLfxaM3P3tUzirfcEx8QPpWUyCZFYncMSvqSsxJU+RpI4Odz2Q8bg8wqXIFR+nB2uvlvaQsXVOqImJV2KHyxfXzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pm0xyv8A; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c79f0a5feaso2517568f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756292685; x=1756897485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nB1CmJyIyqxVpV0Pl3/V76Kj4yMDeN/qorkLS0QOWhU=;
        b=pm0xyv8AOwg36tmuzWHuaCOwMPRvek8+Q7sBcG1vUYAQAveKOHHm32UdNNwTTL9M5x
         tLrGOI80uZnLoo32IU/2w0MNxvBfhZPLeusL4BUGyGxe7dx+SH/kZBuKnZ7ltdIqRXy9
         UtO4OHo6UoIAiICp4Kj8pyizhUYqAh/hSgt9R6Tg461QWKt/+6sHhHzH4FB+vSeIgpei
         vzT3/3X922BmxZCQGgOHwdqRD18X2y5Ytivw86lDtCioQOYx/byHBmULAL2Mv8DwZA1s
         Ffv0Mw8z5S5hX9apfw6A1aKFHNgAo2U/Y67+Q+f3tv2frk64DdIDPBGripWt/XaO5Pwl
         99sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292685; x=1756897485;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nB1CmJyIyqxVpV0Pl3/V76Kj4yMDeN/qorkLS0QOWhU=;
        b=l/NJ/59byXJe3zMCEafsI6j/FHmzGoymMWfR8UluuT1NqmjpL47DU4XcPqOaHDONv9
         hX/OBDoQnBTQuTdNc4fkc84wbKOfhdOnH6mluHREZG0LUo5rto6dBpqXi4G4YwOdEpfA
         n2X0maZ9XiTkaYhLDgr4VwaekThXTsvU5v4ZEF95XhM4oPyuc+xaoFZwFtSbvGwskxv7
         iB8F3aCKymzCQUADA54Sq+01gZePRJ5v4PYsuCBqlcDgdlR2VmUmqbX+2u5RH7Q7GaiF
         VYDtGrcS7Bkbg+iTN7M3C/EM2f+uXSoSEa5KPu4wn++CYpSj3CNSmf/AXC4TKdYOV+/k
         FS7Q==
X-Gm-Message-State: AOJu0Yz+T8KbaUNTknTmT09dGylgb9L6rQ7WT9q6ffBJzy0HLRLTWF12
	GNYWCDatWATFMgCJrR2q3ZN9cKQM6xsQ8frrxv1nabsQKuEmVvH7KNa1tcZ2rLt/+Ifk9DsbjsY
	0pZIVLgZsMqdiYw==
X-Google-Smtp-Source: AGHT+IEd9aTPTeG1vOmcHudzjwY0uo766zrOkD71aEEMOUty/fhnuFFnG6BwWe3wjgjw7hkKGY7L+IqxtUb1Mw==
X-Received: from wrbgw10.prod.google.com ([2002:a05:6000:40ca:b0:3cb:e27d:1247])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a8d:b0:3ca:2bc7:e821 with SMTP id ffacd0b85a97d-3ca2bc7ef61mr7837430f8f.53.1756292684905;
 Wed, 27 Aug 2025 04:04:44 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:04:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEjmrmgC/x3MTQqAIBBA4avIrBswMfq5SrRQG2sWamhEEN09a
 fkt3nugUGYqMIkHMl1cOMWKthHgdhM3Ql6rQUnVyUH1aDVewWBMaM4U2OGO0g9knfKk/Qg1PDJ 5vv/pvLzvB4/5rLFkAAAA
X-Change-Id: 20250827-b4-vma-no-atomic-h-0f8ebc2fe4f9
X-Mailer: b4 0.14.2
Message-ID: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
Subject: [PATCH 0/3] tools: testing: Use existing atomic.h for vma/radix-tree tests
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

De-duplicating this lets us delete a bit of code. 

Ulterior motive: I'm working on a new set of the userspace-based unit
tests, which will need the atomics API too. That would involve even more
duplication, so while the win in this patchset alone is very minimal, it
looks a lot more significant with my other WIP patchset.

I've tested these commands:

make -C tools/testing/vma -j 
tools/testing/vma/vma

make -C tools/testing/radix-tree -j
tools/testing/radix-tree/main

Note the EXTRA_CFLAGS patch is actually orthogonal, let me know if you'd
prefer I send it separately.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (3):
      tools: testing: Allow importing arch headers in shared.mk
      tools: testing: Use existing atomic.h for vma/radix-tree tests
      tools: testing: Support EXTRA_CFLAGS in shared.mk

 tools/testing/shared/linux/maple_tree.h |  6 ++----
 tools/testing/shared/shared.mk          |  6 +++++-
 tools/testing/vma/linux/atomic.h        | 17 -----------------
 tools/testing/vma/vma_internal.h        |  3 ++-
 4 files changed, 9 insertions(+), 23 deletions(-)
---
base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
change-id: 20250827-b4-vma-no-atomic-h-0f8ebc2fe4f9

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


