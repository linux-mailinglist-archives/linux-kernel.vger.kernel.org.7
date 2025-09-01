Return-Path: <linux-kernel+bounces-795215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B522B3EE59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A04488128
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81923320A12;
	Mon,  1 Sep 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNxZcUlV"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF961FFE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756754203; cv=none; b=GKBNWtV7/yn0/4y/L+JJRwC0IA4sVlRc1LIKm6d53XlRBkjEyQHcspunGRNehwBT+cmneR1IePruCPq7lG9xMnRYeYwwTXGdCtyZaKjyHFZ94NnPgmw+AWrNyZutLnwh3Tv5ULM6HHzB+oFvPJRGxKmymrutzhcTAV1ASY0te4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756754203; c=relaxed/simple;
	bh=emVQb/nP+lLVWaTB9qb8A8fdBisYAbLIpQk8DA/49xs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V471jnmiRngaYxD0zMjsh2T6/BTsyDBiSrhMeiVoJHgdFzCBfWmgrznnC/0laQPXb2NcjgVgMU9fVVJSWKB7w+OSN0qC7l6OsF9JH6VFDWDe67gsijAr43CdtFe4NPDbhsI4OWq9Imcjq34O0Gfq1WXGClEHWjFgjVKdchOKkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNxZcUlV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49da7c3ff6so2671429a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756754201; x=1757359001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/cDOfjJq1EkYmNa/Gbni2L6YrspyG8pFR//2Lc47Gk=;
        b=SNxZcUlVfVCpRt4aGA65Vr6PKbvjvmT+2T+WLD6+LnZM8MCR6dxq3kwwKewLlHCOBF
         CvlE3dOsURUzWqF/NtNl0nnlpQaaO0y2uikPMMX26f2kDky8g/Txh1ll30pOIEpKbEdq
         OHlao30jwb3GUc3pYCL3e80xR/iWAky5dbOqNLmejkYrYKHLUQL0BZf5roLq4+OrX4+B
         BxmfpOLaW293d1rFlo/GY4uT5AwIc0b1lYsm1cq1/I4J0Bq/OXGltwAwIkM2TXO5dghH
         x31jjBItGn8rrnfEgN9Jh/tEmykJBbNnpGiCytpNkOeUfjrWAgAGeQD515+nnpFohLb/
         n4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756754201; x=1757359001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/cDOfjJq1EkYmNa/Gbni2L6YrspyG8pFR//2Lc47Gk=;
        b=iVOvrn54VHulB8AoNw06EZE+uowRGxBfsFIaEDkk82WyOzVRey5EkTDn8kvbwMwnrV
         HYuW2V8Q6cMPGbUqWec3eHzOcXOK4YQrQelbQqwuOX1zlDWyKTFWoiSQJL7XVygi+gy0
         fjYmf9wA+4TiuIqSi+z8XtBYyOLlXvaF9cwV72AFdJm1iOWyMMt1/SIbzxTOexc/aOKW
         kTSwNqQLJQT3Ym6CRnGWaeBTDXb7yhlnu7cpl5U4uOWuMSFP3vE7olZraJoQkjSZfhDe
         pPv+RiEowv9zJA4uaQMa3c06ZUQ4759U2AESaGb0B5bckbmGNEZTgpChxHdlqd1iyjwK
         pTbA==
X-Gm-Message-State: AOJu0Yzjw3Saal9aXfgUU98GnA0aGVboWt9YUevGU5J6tHIAf2iK5q1n
	HjcQjiVrFU4yoAvHKxQ9I3AhEKuk4T+GLBduxEiWf9XYpJmTsGcx5lYU3lg24jcbWbWhXLjAvAF
	DfaDlWij1C6zEYdGCuE6HCl+1xJHoAyTr+GNpQMDH7vjAj8Jx1jgjPwAuFSWtzOLC/3RRTBL+Ce
	3F6ekw1Mm8274LvU0E5vwNilwv+V9BqgRZwOV7nJ0=
X-Google-Smtp-Source: AGHT+IFBehxccmY6P3WUNdAudSMYMDls3w+IAV/u6ENkFf1eu/6U3mKHoh4N54IqPGrSeQVbaHCKLSaL6A==
X-Received: from pfbih20.prod.google.com ([2002:a05:6a00:8c14:b0:771:f406:9f46])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d97:b0:243:cc87:f290
 with SMTP id adf61e73a8af0-243d6fc0e1emr11733424637.60.1756754200767; Mon, 01
 Sep 2025 12:16:40 -0700 (PDT)
Date: Mon,  1 Sep 2025 19:16:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250901191619.183116-1-praan@google.com>
Subject: [PATCH] MAINTAINERS: Add myself as VFIO-platform reviewer
From: Pranjal Shrivastava <praan@google.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, clg@redhat.com, 
	Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

While my work at Google Cloud focuses on various areas of the kernel,
my background in IOMMU and the VFIO subsystem motivates me to help with
the maintenance effort for vfio-platform (based on the discussion [1])
and ensure its continued health.

Link: https://lore.kernel.org/all/aKxpyyKvYcd84Ayi@google.com/ [1]
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 840da132c835..eebda43caffa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26464,6 +26464,7 @@ F:	drivers/vfio/pci/pds/
 VFIO PLATFORM DRIVER
 M:	Eric Auger <eric.auger@redhat.com>
 R:	Mostafa Saleh <smostafa@google.com>
+R:	Pranjal Shrivastava <praan@google.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/platform/
-- 
2.51.0.318.gd7df087d1a-goog


