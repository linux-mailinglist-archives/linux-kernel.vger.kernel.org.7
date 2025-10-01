Return-Path: <linux-kernel+bounces-839426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05596BB197D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1061926D91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF473043C8;
	Wed,  1 Oct 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRC0hBIp"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A430215A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346819; cv=none; b=id3IobqOdRloOFFl3xt8JXI93ND1bZxJQiH86xGaqLpSHRMoG6lsiRYGILTn29K+dVzI4Hf7rs8w5Q0cNbbCIEgVhulXy8yCNXuflJLDsuW0BOaxvWXTDpmsOXza7pfSFV0exZPzpIq6pwsOiFfIME+u9UVqZQninDOb616nTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346819; c=relaxed/simple;
	bh=IK1bwSNtA4XxkG3lyr951pjs5Cd9+Svig987Fm4zdbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKR0Wh9MFaC5dFFp3bxal3OWFGhjWpbfaFUi2/BqjCGXmsJgoePT/ab9tnpUkCW597+AGqorPqdStFx7r426zwPAD+qYmdrwzaP0yCpLXBPNgadwN8FNDqiuxlIqmccgCHFRgUq7kdEeaehbLc63ffwwQqrtQU3Atikx/VDx/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRC0hBIp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so225524e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346816; x=1759951616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkBi4jfGKtCYgzp1QyKIde+SrLm3hIwzDlMhFP9SOB4=;
        b=mRC0hBIp+JgcHCGcdl7CAFxyLa+OGUB8JFxxQCwCEp87yHSiqj309stSS3fb26NBwj
         z8BFEEV/WvB/0iX/dVRar7XOZfkBibUza87BXcQnl20DujWldK8R5O4lwcnnzt3dXEvw
         D+OrMRHI7t5rjLBxQq1invc2kWwPKnxsDH5z/WOMT2GQPlNTd9/IEW4aX93bYPfwdPyj
         ozg1qMkI81yPHy/Ki6YkI5hfCxNOfsxnPJ8oQzTarKS4L0TN2WUcSmhYxkJ8rLMUKvRY
         y5M6ttleSxR1NsUVWn95mlRvf+g6scGEVcVu7w/0VhhfAh6cmpd21+CBmvqw0pPYOACy
         lYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346816; x=1759951616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkBi4jfGKtCYgzp1QyKIde+SrLm3hIwzDlMhFP9SOB4=;
        b=FPOL7AStjSeHOu+8tawQfQ0lwZqSCp07UaYnCvNMYs/tGhzadBkBum0LKbLLt9Dwsn
         6Pvvi7D1inKoXmNWss6DTUpmMQfxS89PbTuHYbloBLRyxszwePu8Tv0E88qfjl2YME23
         QiuNido5lhDPRw7tUd6uOmxUIfdWH2nbzgxfGlqysZKoqc1WjtcQTn2zNGrUaeWB5N0J
         ra1SogRCppKsO36V+P6G/rB0NpH19jcpsT5AxAtJrMe+6vf0mJnaIA7Yej0iq5nNpJBd
         tnZoVt+ntVPSHswQ1x+zHHdWerrYM99uiWaifZaJs8kHhdQYkuPCMXjOWG9H0F1Vc5Mv
         kSqg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Zwz7ZQJ824NB+hWFmJfZVarLeglNdbHWW5aMJMKUJ3tb984CPir4XLtsLFptbAcHNK/8eaDlWBdleQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8AovgFqOEzysXliBberDoJ3rI6Ngrt7l2s77NcQU7KmvT1HO
	+fH4SyzGa+3pM7fUO6KfX3MDGR7mM+N94g2fSFKMgGNnrzuLMO9rg4Xanj9hAhV4r7A=
X-Gm-Gg: ASbGncve6TeN2roi6e75rAfVASXyBeWNgiwaXValyx4Q6cghNAF+/nRy2Q5I7Bdr1Vz
	5Pn1OtuiDwVQoyz7WzWSNsrw+vMARaQUOXHZwORBHXLCxlKf8EtKj5HTfJrdjoOxJdseZqt78CE
	92kQ0MPtGpuxe33h8vQkIp3+1bX+9v88I8ozds5dY7MrTrN8clldZvCqieGH8AkssJFgN8vya01
	lyvbZELulqRXQmLO6JghYAx+8UAxPyoXundjOYoV4SlCLnzt7HjrGZdP80Kt2hFB7b4ZjmWI7F1
	/jGtkp8POKZkPsitsZS18r4MJS+LYLG7F5ILXgy9FhX129eoTzFwr4JHxS1lDKkGE2kBDhy7sej
	dMHjoB4RdrPpcqjatYtniio4lfAtUMsk8SWKJ2+CV
X-Google-Smtp-Source: AGHT+IEkQiFaaGHGhvMaMWZ16i+DpN9GfXJ09NHbrvk7y7MEplCQ54CMiAjG/D4d/KqWTkIk76Mo9A==
X-Received: by 2002:a05:6512:308b:b0:585:b05f:9459 with SMTP id 2adb3069b0e04-58af9f38cccmr1321362e87.27.1759346815828;
        Wed, 01 Oct 2025 12:26:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:55 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 08/10] mm: Skip might_alloc() warnings when PF_MEMALLOC is set
Date: Wed,  1 Oct 2025 21:26:44 +0200
Message-ID: <20251001192647.195204-9-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
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


