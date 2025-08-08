Return-Path: <linux-kernel+bounces-760730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BAB1EF56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A2A18C82C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BA324167B;
	Fri,  8 Aug 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FbQ72CmK"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91952232369
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684294; cv=none; b=l9QxQWURghgtz+OucLEy885hajJMPnsuzEmJN4q7a1HqAGy51Fn/tFVYUkWJOHzjXBFbddVZzVryes7LJa5WI4uRf/FfjM0vf/DkKZmtb687qNb3Wgc4O2whOQs6satdxNvJiR8585nPPP+KN9n6H1YSgcBp6ToXPTSx5IhH3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684294; c=relaxed/simple;
	bh=EZOsRx6ADKpX4dGzXjqHzAFI3ma9q/+tVtAqcixVW2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCdNagufC7yxOdIr2BW8Br9R8Z7HE/kujBjYLnXIIhP3FDqNXAVteOa6Uly/kKAt/5c2uSUDz2S5NFEvtusRSxiV0txgkizwxfDDm54X3Ha/zX0zKKfGz4vp7iRs5bDpE4wvMsiZCL5QVKSzfAMoaQd05YLiuPkvmT5Em5TD4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FbQ72CmK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b07275e0a4so29887691cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684291; x=1755289091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc1Ft/b3qye0Nn2AQUyZWguJ2koiO3eAJtJCginIFUo=;
        b=FbQ72CmKRH8iFcO6bUfdRn1kNeJMg/5VI4Ja1c4uxqykg3V4FYaUzmX8FwHomI8dQf
         D2C32kJ49jATPA93WNQrxTt3CvLbwH/ojM9BxG189MYX7oe4AykGnKmBwKnGGuy7atsH
         EEThjxkM341lt4qcalvoemAx4HwaM1rVB9tkbPsaeeijhQbgJyvZ2NF1DXN3aYCLFhnI
         024STp1hCucihfgEbIHDHxlBNjA4IU4Ovx7+0BU3Si5f7P4nFdgblzKLoUOhOiIx4j8f
         7vsOWuI5zqwnzvsa5GFWuOFO8u8iUrGNK+MtxUlxwAvfHU+Z7SQie8XMQkP8SKGwtKeA
         KnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684291; x=1755289091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc1Ft/b3qye0Nn2AQUyZWguJ2koiO3eAJtJCginIFUo=;
        b=g57J9a/zHfBFNacQ1YnXrueBgi1FPnAa6a7/2L24mtlVlEVumHY5uTsR8IVXXLGzOf
         pvfBU1Jb8rdlKNoXsi+/40mSjYZB4t3RNh3XqgWu4MBhqO2p27Exjffu5crXb5Ea9vlJ
         dsybm2BwlThBbRLT2RyJyzzCoFG5mIDeNp9ahbzjU+LHcClT/Qw8wUvF+UjcJAfn9j47
         VSb2MbXidPevw1GfVRddtMwb42/xfgp/Imtm3BHlfjtQYJjrVNmGwzzq6dgVE04QBIyK
         eQUuXLaEC4oK058W0dYC5mSumSPWao8oXlsCk9/bR/OdikElhhEt/nP8cO3FE1yyCOfd
         8gzg==
X-Forwarded-Encrypted: i=1; AJvYcCXzg09PL0/788x/UERZoKG2CKDvrUJwLNvHzvfsGW2WXtxJmK7h/pb3g6ZH7kvQ0OVToMnyKwU5R6fbe8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRW8iPXPHlrInFfkwUpVJl/27+T4NyBTXEa5eXzPDc5DcwNee
	Q5kj0DoK/03ipdYVjDYnqfxwDIJxlnAEzuI08sM9essbRTGshDTzgC0ECNZ3LXyLpIs=
X-Gm-Gg: ASbGncuq/u+7CQG9Uh3SelsRvTrbRV9zorQbQw3rT3CIGDjBkmddHigGs93IXwZ3ygS
	2R+fCi7oBH6tNMEpwfkBvLJsTjh98ZmnA2jLmEV6HbQLMSInXWD+RfYn5e7JLxZnGgsuSm8zyO5
	e28AIQcqlh6z0UtpKHZv6FHqOjawgeaQs5PeRyS6IZr2PXUXOgqhyJNzt90Y+sWkJXKdxeKmO9a
	8s+NEaz87RNvN1J+4I3jHOHMJ8wvOXEBQ0ZbQ7xIRlsszzmNkZ3jeI4ZsFjqXbpB6Z2NhotQ3xW
	YDEIFpBjR+yKzTnsW3BMTXjHf25tspTyMNnHwpTAjvY+Ce8XszmtC2WW2u/afsfv8GonDyGU88X
	2/P3iCl8p8/EbbNkbsts/XC4DlAkA6ke6kS2kbJ2YoV5Ve5TGg5MCRmRR9GhatlIi72w+hrI+o9
	m1dwGpMvkcekQNJWLTh+oic7w=
X-Google-Smtp-Source: AGHT+IEe17+1VnFzVVxjjjvnJD4w9EO7qMdCyqSXThf7XuoxHsa6VF4qQAx4towsxC8CogahdlN4Jw==
X-Received: by 2002:ac8:58c5:0:b0:4b0:8773:9b0f with SMTP id d75a77b69052e-4b0aed0f079mr63563811cf.10.1754684291399;
        Fri, 08 Aug 2025 13:18:11 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm59490131cf.57.2025.08.08.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:18:10 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v3 3/3] kho: warn if KHO is disabled due to an error
Date: Fri,  8 Aug 2025 20:18:04 +0000
Message-ID: <20250808201804.772010-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250808201804.772010-1-pasha.tatashin@soleen.com>
References: <20250808201804.772010-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During boot scratch area is allocated based on command line
parameters or auto calculated. However, scratch area may fail
to allocate, and in that case KHO is disabled. Currently,
no warning is printed that KHO is disabled, which makes it
confusing for the end user to figure out why KHO is not
available. Add the missing warning message.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Pratyush Yadav <pratyush@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/kexec_handover.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 65145972d6d6..ecd1ac210dbd 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -564,6 +564,7 @@ static void __init kho_reserve_scratch(void)
 err_free_scratch_desc:
 	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
 err_disable_kho:
+	pr_warn("Failed to reserve scratch area, disabling kexec handover\n");
 	kho_enable = false;
 }
 
-- 
2.50.1.703.g449372360f-goog


