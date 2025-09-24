Return-Path: <linux-kernel+bounces-829928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F89B98410
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9208A2E502B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5609821FF29;
	Wed, 24 Sep 2025 04:58:48 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BEA42AA6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758689928; cv=none; b=RSxOoITGo+PeGsKc33wfExakjDq7K1j194iLXA0hF9SUIluAfSfNYZnH+RiGymIgKFYuOfNqnsNNSOJ8UJqCm8p7xDbd27fj4JlSymC9eg5nhB1KMEz2HH/GA78GrQ0Wx/+NuqZmuFl4oPyV+q7I+GwDGuz0TTz3Q7vtoetr9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758689928; c=relaxed/simple;
	bh=8gPDqswbtwTeS/DcicJSF+KHq4cqOrOBtoX00SezrNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErYDisa0fswtLw/0etWT6qrdAvUWOdm9eZMKi9ZUOhgfToLXe9H/081NJrZ8Qa3zTNekAj3A1jnyoWZY2O8RWsSP7ceyotI0ohuGEQ57D8sebMRrHm0Gd1HYj62061qRh7nJLG9jXh0xYb4VW8dHqxd50y7dVVxKCEjPK6L3djY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46d40c338b8so21681515e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758689924; x=1759294724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vIg6XtSGSkO0XzH+aly3x0msaPeV3MFy+v+xHAk0bQ=;
        b=Gt5KJF8x8OAo5GcHBrXk2Qlzm2/x2JhKAJcUKAxd9Yc5N6mg4/wqEvM6szf8FSYLX9
         9DdprafXr8w2DO0MIdXQq5gLnwlzoCgi46Rxbw/2c3LlVxiWlsh8vwvGa0iyQLrTpXUO
         eDuJGMaNCDycyaHh0drEGWp4vW3ffOqNV0iPNZhSdiWK/6SWvHcCaTKeUtpjAfwt782W
         yHsILQiZy76sUrT29qLalRSM+vRuYVOeiEhdvZ/mOcgTEhnErCvNGQ3UJ7DxkSidPC60
         1sr9KGlSseMP0EUthWS2epSwF8aWgPlDE2S9lREJ1K//Q3PH5WG7aj5FjsbYWfrtDojb
         W6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd2UXXEnffsENOKItR/J3LyfT6oNZGSY5zi1annIEtvSphTKE+2xLtklZkScBMGGqDuOf+XVcpl3ieN5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1qZkLMepp2WoGJ/6Mj0cdxdu3CinMCTmzuhvDG7pXYEM228U
	Stwu8HYtKczExPPUIMeJFV1PxhZr3J+i7hSLl14cI7wBjtbLsTm9L68m
X-Gm-Gg: ASbGncu30740hr6WfemhG5UxHl4tKjZUg0JsJhJCh9SneMdVvlcAtsDKjhZKD7qFDjr
	EuMD2NSpkbZc/Hkg03x/DcWlg7PSZTYqPmfCWeJBfCPxTZXU+se0d/LKQsEK/AMyeowH0gSjAUH
	8SDdhzrOLyEb9edoZRc2mjLvW569fX8jsgRhgnGNhyywoe6zkKbJMwPaZyENO6msAhnzgXcwgq5
	Z0fNIJtAQKN2rjdMx2GayTr3HyZ1cqiLVU7G2IiucXCpp4fSG/Z6/Yt2UjZ0rAQcMu/q0fEVsIF
	Hue1480sLd1Co8eAHG3GNqExAnQtUzyDyZmTYpY1aLZbuLwUwQ+xTjjCdSF3+ilsxJ4Ex9N6Bq4
	Vb9tC+2kY
X-Google-Smtp-Source: AGHT+IHeiSxoEy6ldzX2Rzke52MCPXDJs+dThVKlNKM6eJIBMgy3M0v7YvvA2TJc93CzWlCycX+5YA==
X-Received: by 2002:a05:600c:3ba9:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46e1f86b296mr57881105e9.17.1758689924125;
        Tue, 23 Sep 2025 21:58:44 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f62sm13856405e9.15.2025.09.23.21.58.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 21:58:43 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: richard.weiyang@gmail.com,
	Liam.Howlett@oracle.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	dev.jain@arm.com,
	hughd@google.com,
	ioworker0@gmail.com,
	kasong@tencent.com,
	kirill@shutemov.name,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mpenttil@redhat.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com
Subject: [PATCH mm-new 1/1] mm: clean up is_guard_pte_marker()
Date: Wed, 24 Sep 2025 12:58:30 +0800
Message-ID: <20250924045830.3817-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Let's simplify the implementation. The current code is redundant as it
effectively expands to:

  is_swap_pte(pte) &&
  is_pte_marker_entry(...) && // from is_pte_marker()
  is_pte_marker_entry(...)    // from is_guard_swp_entry()

While a modern compiler could likely optimize this away, let's have clean
code and not rely on it.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
This patch is split from the series[1]. The cleanup can be applied
independently because is_guard_pte_marker() is no longer exposed.

The original Acked-by and Reviewed-by tags are kept as the change is
trivial enough.

[1] https://lore.kernel.org/linux-mm/20250918050431.36855-1-lance.yang@linux.dev

 mm/madvise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 35ed4ab0d7c5..fb1c86e630b6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1071,8 +1071,8 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
 
 static bool is_guard_pte_marker(pte_t ptent)
 {
-	return is_pte_marker(ptent) &&
-		is_guard_swp_entry(pte_to_swp_entry(ptent));
+	return is_swap_pte(ptent) &&
+	       is_guard_swp_entry(pte_to_swp_entry(ptent));
 }
 
 static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
-- 
2.49.0


