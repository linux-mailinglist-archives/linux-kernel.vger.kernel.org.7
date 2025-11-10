Return-Path: <linux-kernel+bounces-893817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC7C486E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4257E1886878
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A12E62BE;
	Mon, 10 Nov 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQL8oL+z"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5322BF00A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797125; cv=none; b=HPRPamaMhTA3H75ZDjPyNJTeiB8jQ1sQUT39qK8Ag28khCVv3grgmebnK3DUD4dxzh81eKKv8cWw02+Gpa+mTV/Tq/P8ZXITKawz57WiJ+K94e4U+SG03soMSVVPcUruuVDJTmsff/oY1JpfgfjtwmZqr/50TF2elEjxaio4zek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797125; c=relaxed/simple;
	bh=18iCxCQ3O0qRTg/t+FbPHrusaU1hdTgsM9+QofYy+2g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kQRJHR6bPvQcr8L5iNNB9fXHnaJ0pDKL636i6dosMvr8iRbiiL2bQflSwe958OUMGp1EIm5Dpb0ZvWSr3+Yjdw8WSZMUaODUVQJEh0Uw3bXglZhHEtgT7Es4f7UBtxoix+Gl8hfY/O+3Rt35waKJC3LYcy5OQoKfVTKNmAUCfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQL8oL+z; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7aa9f595688so6383914b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762797123; x=1763401923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VOdTjIkCGcjxXz668t416NZ85KBy/IPkSb6VbZHK7cY=;
        b=yQL8oL+zfamQQS5LtJzLYPxzRlIxv6kWNKMqcnSntgK4JllfZIhHu/wW+Q3pRIMRx/
         OqBcKXSzePF9IMDqBHv40mxjUmK3DAvDKd5+Ss0CMe6ijsHjq7pRayntlo1CVpCJDGTJ
         k4WtYxskGPe0BaQX7ZjU0M9x//FxRGUHqLNsyITZMGmYolCuCjjWxEeZHcl0ebn9XsUC
         TGtmPrRsfAPSmFPXfKbSPZV7KbsyIAYdsDuo1gRNy5pI3SpBTOYGpGUBJJnjz8cgm2q9
         8LqnW4zQpymgP3lNLE7alFoOO6hLGo39xz/WjuthxbuTIYsDIKwds6WTdzAvesj8XE4R
         fGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762797123; x=1763401923;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOdTjIkCGcjxXz668t416NZ85KBy/IPkSb6VbZHK7cY=;
        b=nH7tOzrYU3QTCZWTUSKac6v8wW8hYMxekDH3mdCsXmBvGIJsOHM3xjish9Yp+O2m2n
         dwhtv46oaaGvmqvkMApkZJTToXFJHoM1S7VdjoE9+2EH/dh9St4irc972CklVwi6leS3
         iIgnIsWoyQxiKN6PyTGqUWXOhNEw1YWHgizCMI/RsMUynN/u2RZIaUy9TKRtWeAhnUAm
         NLS8Bs1SUrij4EjSADOv/N97K8+bfwM8lVeJVjCiz6EfpusrTY2i7sHCq2b4tMfjkqMf
         f31FVVIO9umMpa+z2/PD3dGpNZrsg3jyldxbf4M4XQA0sj7qh/IfShEzS1plyPMlpkI+
         kvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKsanNmol61amYOZyMGgM5XyABNK/56KIlEiufBNOEbC+U8LYJR2u9ZZqwwjRRH4UHiGI0gySR6j656x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQlvpv52mUustganNvfCVWm3JWtEimy8VF76HWEG0IewxHyKD
	YirVWq7cBdhEt0U+DgeXkYv9ueqQMFCy0sK9560gaBlLrH3LvduV9dxwfV/A1Lb6dP8uwqmvJug
	FvA==
X-Google-Smtp-Source: AGHT+IHWYBTESQqB9OP6+smLsVWuqBi/TvADneKuVwr5HuxTOJDLAGYUSWDls+iD4ejGoWboD+KQ8QxyUQ==
X-Received: from pfbdn8.prod.google.com ([2002:a05:6a00:4988:b0:793:b157:af51])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2307:b0:7a2:7930:6854
 with SMTP id d2e1a72fcca58-7b225b61a51mr10573564b3a.13.1762797123012; Mon, 10
 Nov 2025 09:52:03 -0800 (PST)
Date: Tue, 11 Nov 2025 01:51:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110175155.1314757-1-wakel@google.com>
Subject: [PATCH] mm/selftests: Fix -Wtautological-compare warning in mremap_test.c
From: Wake Liu <wakel@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

The compiler warns about a tautological comparison in mremap_test.c:
"pointer comparison always evaluates to false [-Wtautological-compare]"

This occurs when checking for unsigned overflow:
  if (addr + c.dest_alignment < addr)

Cast 'addr' to 'unsigned long long' to ensure the comparison is performed
with a wider type, correctly detecting potential overflow and resolving
the warning.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index bf2863b102e3..c4933f4cbd48 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -1032,7 +1032,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	/* Don't destroy existing mappings unless expected to overlap */
 	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
 		/* Check for unsigned overflow */
-		if (addr + c.dest_alignment < addr) {
+		if ((unsigned long long)addr + c.dest_alignment < (unsigned long long)addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
 			goto clean_up_src;
-- 
2.51.2.1041.gc1ab5b90ca-goog


