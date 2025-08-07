Return-Path: <linux-kernel+bounces-758786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3AB1D3D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578E816A043
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F2246776;
	Thu,  7 Aug 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpeL1GzU"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4334244675
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553499; cv=none; b=SoHkd/CgwZVVhBeNlYHWfFgL0pWlEQmoykJ/i7mSop/0rOXIbKqdqXOYHMw53LzKmsagpTqgLcmLsD8rbMidy7jag4y7b7k+hPOWee0pxhW92H5yDPF6/NfUIbruCnQYTvf6XnH7qYczZF+wqdPIwsMszy8h4bi2XIu/a3z6IFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553499; c=relaxed/simple;
	bh=hKjTv87+Nr2Rn/nVC5Deq0ZI4g2Zr+VbZQrlCAsKSjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jomNy5rrHHEJiUDJt6NLXJERcDIazdDeo92aNMuVzbqii+cMaY/+yFgJ86tC81oO10C7TvXCX3hKvj3WNE4Joj+JySlmUCT4kOULcPrcQTc0LUuuG+bf1QF3dBUWgWTmfA+JAqURPbe9OJPs/MqS94zibXqPFKdCw0szbBET+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpeL1GzU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b797ad392so799326e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553495; x=1755158295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDFnf8EI4upo742I8wxwbr7SIwCoz9KqQtqWzVuCI6Y=;
        b=CpeL1GzU3kTb8BnTiTxvX3XlsARbReSXGL98knIsMoHPlYK8pCkxXRsFKgYw5DPkSD
         Xt1dIi73UQInpcYKDtrLebaNbmruUZtyfFnDI/TtU53Xu+4A6VPXfBNLJCFZvA9RRtvn
         YlOTR/oHcIMy2Pyi2X/1ogwjrZj5nSQThkP48jGbUszuodaR3SCGnS34FUhf+N3Fc+3N
         GM86ykWGNPij605eGTxf8cQGp8/VjjHqj9vF/W3jOaJRC3L/KZNW4AMS3Ow3RMWKpFkB
         qbCWmP2k8B0ZOEU1c1rSG7sH69qE2+t7evpWvmpa1b/4ep5l4cfk6nZq/V/EfVSLEAZ8
         IZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553495; x=1755158295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDFnf8EI4upo742I8wxwbr7SIwCoz9KqQtqWzVuCI6Y=;
        b=aOnOGSO36KuX4XW5AcsJN3OHzk63e0H5vLpkkj33XfaT1ij5W9xQ0nm72PHnitqvc5
         BfMVPp+V36ql10mz/KNJwCVNo9uB/XK7olErA/h64b9pcHAdTB68uMJed1+vh0k8Czte
         EXjFyL9fZA/5yhYu6Xs6hJ8J0Kn4yrGEaC4jbfreElV2xOX/9Vqj0JXzzdgszhew3V/d
         xHYvg8JhPGMDKw66oHEqPcm3fr/3YZ1pS9LJ12ZFlfIO4jiysoegAR8meJ4EBCtHUDpd
         nrJzPwwRoeVs31FywgdohsQGm3NH59/z7QWsbo1vYXBJKhH/YuhZbt/5bp+BKWnjLDW4
         zQog==
X-Forwarded-Encrypted: i=1; AJvYcCWvjP27we8Kan0ATht+zHkdgcb/ji589N721ekXOkwb0AdsZO7J8/+tbHGvLEi8bTXCtDGYGeMvu+5glW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOItv4aDP8qIZPiFGcM8umx2KAvgrLbUxfMF6WpXJwuFDQnotP
	hdOsjEX6NL2MaJR4oB2e7w4nEfY9GQo54DB5MISVtEFSsLjuDzH1DN1E
X-Gm-Gg: ASbGnctM0y8n23ls0oeOKI2QzJ8iWvFSkBuMHAwXNCzZdTfj/IPRQvJrWH8oL1nYAAZ
	9LAYtyGO3FPobodXLTd5DIAJDi5nR3vKLPV5ptv9fTVxM6qnRNEFYKoEVZVn+OoFsNbz1V5i6Yo
	dB280jyLYIem2pu5eBWzw2ilddAcuSJ6S6YLTn3X/TTPzd31mMu8N93kuj7gW13KKPtKCn8JpuI
	rOwqaYZRvh0iQyev94Mkf7yQQbaG2+x8cFrHCBFl9ybaddd9w/xn5V/WRZISxzvfgSpMSHBcUim
	Ggl2TZUS1b+Nq/OKlxK4wG7efQlgITszXcs3RbH0l608kB+c0iHaUMcRN0TUDtuLYJYDQBvPqby
	kpK3Wr3Ik/itlMit12A==
X-Google-Smtp-Source: AGHT+IGLrJfn07j+Z/Q1+AZhXJEZJx78Z7HhlZXmk3MvvjRB0pkrjJdAKWHTqR2XcogNuGRLnleTog==
X-Received: by 2002:a05:6512:3da2:b0:55b:8056:626 with SMTP id 2adb3069b0e04-55caf5fda96mr2199121e87.38.1754553494378;
        Thu, 07 Aug 2025 00:58:14 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:13 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 2/8] lib/test_vmalloc: Remove xfail condition check
Date: Thu,  7 Aug 2025 09:58:04 +0200
Message-Id: <20250807075810.358714-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075810.358714-1-urezki@gmail.com>
References: <20250807075810.358714-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test marked with "xfail = true" is expected to fail but that
does not mean it is predetermined to fail. Remove "xfail" condition
check for tests which pass successfully.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index aae5f4910aff..6521c05c7816 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -500,7 +500,7 @@ static int test_func(void *private)
 		for (j = 0; j < test_repeat_count; j++) {
 			ret = test_case_array[index].test_func();
 
-			if (!ret && !test_case_array[index].xfail)
+			if (!ret)
 				t->data[index].test_passed++;
 			else if (ret && test_case_array[index].xfail)
 				t->data[index].test_xfailed++;
-- 
2.39.5


