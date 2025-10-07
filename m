Return-Path: <linux-kernel+bounces-844666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAFFBC2748
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BD2D3505B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552DC2E9EC2;
	Tue,  7 Oct 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8ZvPoTl"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE82EA475
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863354; cv=none; b=eHjoqey4biHJJzGEcEwhnN0Y7KkZkLZCyhBN7kxZkQnLeIir7epiNhyiUuTvW4hPslnoPgYXjJduZ0kG7yc+Jz+HowwdcZ6u5I3pXJQak35ApIh1VzPZaIRt9A9LBBJP0USHvHDrhnk6DpFQDQfOLvg2N+AfNITp/cv+9w7D8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863354; c=relaxed/simple;
	bh=Rho7sTxAMEoPP252qGZTMQFycx1DLensjGuRyl7y578=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZFzm/FinP7hv07ssqVB5N9vYhrMmVnwqhKYkXVuKbeBnK7vREkPXFoN8XT7cUqIyM04ZBUW9S2SBsiddsr5kIW+VBJ3oYRDN2kOeMkWtsrD8q7ya7jYeUHke0ZL+2+IBIeKtNaZ1giodxq9pM64NkUaaYeGXd2jtNGDxdqZXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8ZvPoTl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-269639879c3so61158155ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863353; x=1760468153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gegn0k8zkFLs9RL1dCuvg0v6JbgbJ0VquvE3LZNQOk4=;
        b=K8ZvPoTlD2nNJbcMBseFZSSyHDaLsb/mT5TLmKmPJLPXmOWqLmbbiQF1WhUqokUcH0
         doZmZkVYjJ4QGtbqx1eUxVvQCU+IHH8zPA0mgp0rrbw3DbB8GFvRyp7r+g526RpQjpFx
         7a1hzV7X5/uu74WUQ4jLMeS192OJFaiWIxI3VwiqBXkgULwHn5Abd90DKXijTuST6oEZ
         FDZJf2yuKcOlxoQ/1f14J/m55bub/Y5Dt0Yk+PqJUaF2PMKgeoWL2TFd/5tcKOF5lD4+
         xQUZZ8wwpCDsjdIWE8/Ve7l/6qhpBLnYwwQQbOoJ04z0pHIKoJnBkByjgZBQ0l39/w18
         OcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863353; x=1760468153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gegn0k8zkFLs9RL1dCuvg0v6JbgbJ0VquvE3LZNQOk4=;
        b=RvdVFXn4nM9Dg9KAj6Nx6lEKzp6PP2q3MTIV1TpCQk6RqWwmNi8gbVjPsR+SJq+VFN
         IbVSJFU4Bfk+a/t77ofa11RjLC02THgwoQVaHb9SndBRjJae5FsIdoyyBcoVpAKiuliR
         C6FEKqwr9B/9SaGRq5F5bbrwmARdiI4mawUbnZJLSgqGbOjcaYdi+pNKRZFBX5295pu+
         gBr73HTrBqG1VUZyvY3x7KXW5saTjPeNderqFiBHTCtAqRRjbZVzSxCH9JaZaVRS3uqq
         esdfUJPp/DFJW1+WWtkjUZwn8iyMHR7Q2x1XBeuG2W+EG89H00v0eaqgIZF0AY8kGTsQ
         kSWg==
X-Forwarded-Encrypted: i=1; AJvYcCX9DGeMikMXeT2BIBem89Q9/f1xJfZPh4/TUFyy67y8p+kyfnt10vzAlDtikXX43yt13h/orMJtULh0rj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIMcl5HjMAuX/Yy5OtD1uLP+AfpAQ5vjWNyJcg1DhuginHfiY
	rPSpGXoO457TX1Q792nYnCxADdPJat+ujxM2TJg+byJI5Wr125QrufIs
X-Gm-Gg: ASbGncvncjhkdMe0l1y/0mbUnRITApE/rqpgUxrUg7DCKIovGauo92RfsNltV149S3C
	SarmtXwAdihJQ/ov3ObsBzt3Kn4mjBzF3Oz6kL1veLhTZzNvYeDZ5XE1fj8on1AtgXZVbr0+402
	HLbbyV8dg7vyr28b8WrgYtK3fZhBy9hdRKjzKPynrz3iwHd+gYrUdmUzxlsoFmTScamNmSPCRen
	6lUw6Qpku2IhdXT535qPbKlW+X1w19BGEZvGPrNlpn4TVMut5VNk1no77K6q4jphFAoOaSONLIt
	/7rhv2W7AP3iTY/KtJoBGngXCH3wWZMIfBkCtGGh9KkxSEVdzAK6hnrHvcWArqZX5JVZ/oj+I5w
	N2jmkpefKOl3Mrolv0QPPajyhWwnrnPoIWQcMhKIM0EppcK70svD1t9nZL2UPPSPL+w==
X-Google-Smtp-Source: AGHT+IGZN1Y9M2N/Vee1Ssvvb0MHNlIZBYsHqgiNh9gBqOHOlpsRP+9huQ4wVymhKKzzErwqk8uQ8A==
X-Received: by 2002:a17:903:1a8f:b0:252:5220:46b4 with SMTP id d9443c01a7336-290273ef076mr7414175ad.37.1759863352634;
        Tue, 07 Oct 2025 11:55:52 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:52 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	crwood@redhat.com,
	tglozar@redhat.com,
	costa.shul@redhat.com,
	jkacur@redhat.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 4/8] Documentation/rtla: rename common_timerlat_aa.rst
Date: Wed,  8 Oct 2025 00:24:53 +0530
Message-ID: <20251007185508.40908-5-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007185508.40908-1-krishnagopi487@gmail.com>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common_timerlat_aa.rst is intended to be included by other rtla documents
and is not meant to be built as a standalone document.

Rename common_timerlat_aa.rst to common_timerlat_aa.txt to maintain
consistency with other common_*.txt files and prevent Sphinx from
building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../rtla/{common_timerlat_aa.rst => common_timerlat_aa.txt}     | 0
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/tools/rtla/{common_timerlat_aa.rst => common_timerlat_aa.txt} (100%)

diff --git a/Documentation/tools/rtla/common_timerlat_aa.rst b/Documentation/tools/rtla/common_timerlat_aa.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_aa.rst
rename to Documentation/tools/rtla/common_timerlat_aa.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 43f99bf0f1d7..ae1638bb9a99 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -31,7 +31,7 @@ OPTIONS
 
 .. include:: common_options.txt
 
-.. include:: common_timerlat_aa.rst
+.. include:: common_timerlat_aa.txt
 
 EXAMPLE
 =======
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index c620ab16f849..19cb5d203845 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -32,7 +32,7 @@ OPTIONS
 
 .. include:: common_options.txt
 
-.. include:: common_timerlat_aa.rst
+.. include:: common_timerlat_aa.txt
 
 **--aa-only** *us*
 
-- 
2.43.0


