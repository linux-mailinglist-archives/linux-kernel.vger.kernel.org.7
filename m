Return-Path: <linux-kernel+bounces-844238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C7BC15AF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923F6189FE2C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB022E090A;
	Tue,  7 Oct 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeNjEbLI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C52E03F1
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839651; cv=none; b=reSN6/XIEOg4cm61hR9+psVGHUH60fJTV1iHvb6/XKlzJCWXdy8HGpm66kQFJEXxod1tYLdlXDOlCZVBYQicLa8XWjSnvzq8nitU4syZSJ/cb22NZDpU10eCmFv//j4hqB4L9MNpzmTPtVN6S7MKEaqIgXo7uNI6trja1JjQJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839651; c=relaxed/simple;
	bh=IoJEBGvjCVG71xgP3yeHFGDfoqh2ea/SvWbww9siMuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJS7g/LabbLcEpoecJkd+8dO2xMDr3v0fXeva2LI7r+IMGt6HinyisnO68UgYtyq72qTDIShRNUuOuuq8HMQJ3bgHkVSIWLvVU1RNjvEPPkTqBGsO0TGGqn8M7cw3AYyRAMXc+RPb2mLYRGssdJrRmavwnC77vYouVx6GPAQmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeNjEbLI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-586883eb9fbso1322869e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839648; x=1760444448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R30emTvkjGHkQwmiRSKLnz0Kds8va1dPsb/YBIausdc=;
        b=ZeNjEbLIBJWuXeqBW1pfC962eUOxUtPLFvZ8+TOlhnx5oEEY3ECgdKBH2mCpeGXAwK
         GgDrkgJo4VsUWs7831sVigea45M/bSfK2kTUAy+wUxpA9OFyDau3yKwZ+3UJrj0qKixS
         qYaFxtXJ7p+XIZBFchQe5tKaV8Gy5IM0RP5MgdjQSFHjiG1F7YuVSYSdvESdT77V6Ayz
         2V9L39+yEocb9JJpsuBy1p8+rjzk4LQuNsOkRrSv88gbDDbSQ/3PyW7ekQqVamZ9enZi
         FNtrN4DvhkDaUwerBK4C2Gnd8J+LWU6X9V/EkgBv4tlnMBvXPeqfO7UMR/+ifLS7KYgU
         O0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839648; x=1760444448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R30emTvkjGHkQwmiRSKLnz0Kds8va1dPsb/YBIausdc=;
        b=ge2rrVtfo0yLnAEjNHDjK2I3e/nxboKCD6Hor+v7W9pXf1aD6/RqUDTBnOy1nfXVx+
         0AqrLjUmTodgXn/OGD/GbYjyHrxuOcLLrDuR9/Gy+bcUr37yHUvuD3di565gQHUFgtu/
         xI+bsUMu7xHx+sztFBF3B3o/S/kaLOUtSKnEncGwSqA9COc7qcHnnswetDFGrpiiTvKN
         vC9u0p7RzCnaQi4w+HPSNzPccWwBEZJU/M962SP9QoVqUaBu5/H5NnrQR7miCvz1F9tl
         f096+1YAjS3AvVXmJlasHyG22Gpax55Rm8LTQwka2BDZEyy5fbV5wVJ/SehK5XrINwDy
         khwA==
X-Forwarded-Encrypted: i=1; AJvYcCXSxS0Z9WKNIIbmt8aK36Rg/gLA6q9Oa+wcnhdm9XXRkDyfJsRi0bz2tdBtgoC3kbrESuXt0PplO4Zla8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrzdz34GQa8GVvbV6Oa7Ht0Nt+sniJ21q+QfKbeiwPI8c7Fk8
	QZRJvjbTqnuAj0tz/qd1cw4IBaihaFgEsgBLValaRlr704Ic4xG3uMpy
X-Gm-Gg: ASbGncvIz0ROmBobjZ+BEzCnVEHczXjJVxEApqVKmv6y3nsB2Y6zzIUXrsVNTwUQqgX
	3j4RwS7CcZW+jcygDXg+b6CJx7RJi4PNLH/+1Y8lLrEInLKi6/92FFOqSzqFX833wTDBWwknkl6
	2geVJ30fj/MorqS76Zza5WVw9X3hTj5Ge9B2pPMgkbAtGffqBDQ4mC61E1JA8nPezZ+5hggbvZq
	LE6z4b9cjbnHNd4BJMbpKfreZsrxsgQCpoGXMdf+aci6uiRhY4u2Xh+haOxdSC9qdPB7kbKMQDd
	Hgsy6q3VbZ5p/setV3TilXmZDivK6WRYBJwZ0Jj0hfSSet/+t3ZrfvBtgKnuJRnZQNWfNG69JGf
	C8j1YbRN6XaNiMrFJ+FiHCJ4zEYDxQtvrk2u79KbV
X-Google-Smtp-Source: AGHT+IHNWqIDadjqab9EoR4kVdLbVq3cRBaYZCy5fG559MhSdkjgavwhNixv0glhEVeYH7Z8s5RdVw==
X-Received: by 2002:a05:6512:1089:b0:578:f613:ed9c with SMTP id 2adb3069b0e04-58cbb62b98amr5731937e87.43.1759839647876;
        Tue, 07 Oct 2025 05:20:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:47 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 08/10] mm: Skip might_alloc() warnings when PF_MEMALLOC is set
Date: Tue,  7 Oct 2025 14:20:33 +0200
Message-ID: <20251007122035.56347-9-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

might_alloc() catches invalid blocking allocations in contexts
where sleeping is not allowed.

However when PF_MEMALLOC is set, the page allocator already skips
reclaim and other blocking paths. In such cases, a blocking gfp_mask
does not actually lead to blocking, so triggering might_alloc() splats
is misleading.

Adjust might_alloc() to skip warnings when the current task has
PF_MEMALLOC set, matching the allocator's actual blocking behaviour.

Reviewed-by: Baoquan He <bhe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/sched/mm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 0232d983b715..a74582aed747 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -318,6 +318,9 @@ static inline void might_alloc(gfp_t gfp_mask)
 	fs_reclaim_acquire(gfp_mask);
 	fs_reclaim_release(gfp_mask);
 
+	if (current->flags & PF_MEMALLOC)
+		return;
+
 	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
 }
 
-- 
2.47.3


