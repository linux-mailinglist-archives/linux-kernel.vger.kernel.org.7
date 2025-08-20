Return-Path: <linux-kernel+bounces-778508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E9B2E69E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D645A2815F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE772C11CB;
	Wed, 20 Aug 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fffWNqU/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312842D375D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721880; cv=none; b=Ue9cLbMUBZcgmbLeFQAyT+eQVrrQk1dZH7pOxBFY3pC9gdDFaymRS5jGrAhfLvlbb+/+eHtoWAcb51pIaVvbCIzfyhvC1nthUo2RXedCX0OKWuK4+6xyQokhwPI7WOvvUgOlGAEuRPqiXL0C/tU2+U58V3YiI4D5hpa/RTYPfLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721880; c=relaxed/simple;
	bh=p0wORNFPcgtTIQruWF7qHHMAgbrx3h1utzh60JxPzXU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hsYndRMOw9qKdc6WQSHZj007bWJTzn8hTYzcZ6sJwweNpb2OmYhBdgTkZgP5+RaUXqCFMSFbdpdJ00Yn57Z+G6uqnVYdzbJqfwIpEsHqsUiM1OVr3oE8EgpwLBbBgIo1Z2UgFx/ISCAL1nQCj2bHyqTn29+Sd83+Yu1ZGQuqE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fffWNqU/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0514a5so1175355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755721877; x=1756326677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3peP7Zh3maJKyMPmiApr5AT5nQviFK0IHw+wb9yUIYE=;
        b=fffWNqU/lZF8wsF9QxMBtVEVAt5DtiTY8HEgqohfgwBBUoc6PQhYMCa/uZM68KhUTX
         lvUwSNTRDwjQK6+urzjdGqdwGrpmxKVbomRmiIa6qit3kG6+muPlEYOcgDcR330Wz9PE
         +OnJGG9cwP8VBg+cRLVTLhPMGSqfIWNaIutTFaw/yYQzJJpr0HQ2qX5rnC2b1rp/p41k
         /Imtzjcj+k0L+Xc92VvWLHNVaNSubu6Z51KG5N37YOWYnqlbjlmuTfLndUcxGENNVd0T
         6r5nx7/DNUtromhPRJy3ikVcI6v83ikHndRgyNFjOJb393YeF/3kWQriDm2s9iYJy5Pi
         1jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755721877; x=1756326677;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3peP7Zh3maJKyMPmiApr5AT5nQviFK0IHw+wb9yUIYE=;
        b=CBhr0qpbY2a0p42m8iOB1Q8iBjT4fbtfi2Pm1XWpV4A8VFU/nfPzZTTTvh2pXoEo11
         upBKLdvxmCPV246XcmRae2biIpT+075hKRAjcY/aVansK6Vi4JyTIGv+isAiWz7f7Gmt
         3oCKzSHpgmFBDlHccJpg3esy5WrJfeZFlLF480+5CiQwsZ2lJ3ihMwarIv53PEpIsGGu
         brYnlOzBYz5TSi4iuz/kyupzzQuDIPLL7OK2QjcdfnxXrLr8sk1XmYosZxY3k8nL7pIz
         Pja1s0Bl3XUtWQBvwNdb2Qx8Qxvj9OHSEHSZhjSf137h0oH9SEj1M+/Nmz0ifGb5NJyx
         RCxQ==
X-Gm-Message-State: AOJu0YzjArv2OA5mpqH8+7MzzFqvuVVLy2T4N3RF8qDMv2ntt8LmJN2t
	3PsT1GGraLb1R4nzVTi6nbpfB/HkIozLQUcvlnJ0D9AaR0CroHbn6rlThyDCU3RxYzGxBFOHgOa
	rmdk9BE/f9SriYOKEUZ7PDjUajK79VZ3vwHItYBIUEp6ch6fWsk6fH4w9Nq9W4NPLTvYeGdaEVs
	LpUm4ozBk/XWj/7FZizanb3g0ZSgojd+ayUY56EEosJ8/FrK1D9EbV7y4=
X-Google-Smtp-Source: AGHT+IGmqi5rV6a1OH5BcnYXAGtTlTBZLJEb+z2OAuoaeMEryJb7aYQaoZO8+FHe09EcsPRvT30MEssnfppJuA==
X-Received: from wmbdy22.prod.google.com ([2002:a05:600c:6596:b0:459:dc99:51e4])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1e:b0:458:bbed:a81a with SMTP id 5b1f17b1804b1-45b479ab128mr37375585e9.10.1755721877594;
 Wed, 20 Aug 2025 13:31:17 -0700 (PDT)
Date: Wed, 20 Aug 2025 20:31:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250820203102.2034333-1-smostafa@google.com>
Subject: [PATCH] MAINTAINERS: Add myself as VFIO-platform reviewer
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, clg@redhat.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Based on discussion:
https://lore.kernel.org/kvm/20250806170314.3768750-3-alex.williamson@redhat.com/

I will start looking into adding support for modern HW and more
features to VFIO-platform.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..840da132c835 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26463,6 +26463,7 @@ F:	drivers/vfio/pci/pds/
 
 VFIO PLATFORM DRIVER
 M:	Eric Auger <eric.auger@redhat.com>
+R:	Mostafa Saleh <smostafa@google.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/platform/
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


