Return-Path: <linux-kernel+bounces-836596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF0BAA1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E353C84B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB926ACC;
	Mon, 29 Sep 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPaYzQ+J"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268C30DD38
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166287; cv=none; b=VLr3DtcpGl1aTSrn8Tcv6han/lr50mOBZLbFXllCKW9I0ZcPz8pDjEqUWR84mF4GuqALI07yllh76AHknGmKkY5Ha49kAgcxYJ3PxutpqwUfvwreaMOoaPt/zTq9g3KhvLLq3bF/xCr5yNfNG/cES0rthEPQT5daho+rdsE8P1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166287; c=relaxed/simple;
	bh=0qSC4RP6/Kd/XegjbOpcMoXwRGlnjDzdhRP+zZoREGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5RcFydyblJ8JsnpISq1IjmQBlQ+KUOpOn0YqV86skvSaqco0+TqFBySb8xODx6kzlBZkPtaEmwr6wxZvH3KSwR4E08hOIdfSM19AIXgiItbWGlot53VKQaeVFLB4waUr+a06zB7KOpzegidr4EH3GpIbKWUooSs0j9iNcQVCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPaYzQ+J; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781010ff051so3366046b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759166285; x=1759771085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8N7+SRw+4fb7ms5sLEv+9Amp7wSRqL4B11xUAR7VxS4=;
        b=gPaYzQ+JVRzWpmz6LgVCQ4TtVzIpRJ1/4lUJamvGHJ/kzTcKLuAv7slhqsuKt2ZZLJ
         ug2N4SIpcOfB9Duekg2BK4GeOUmNrG7csxq02czZPIVQviDQabLbYNU9pcCK4gJtaCHh
         PQP4r+SFFs1dc0FQZvGE42iKE8GlubJaXVc1nWm66cbzOmxAoTTM73i1Ioa3cD6fJZTb
         GDsACPdZ3LHQr0aRR1sWTPYMl+0W65e1nJiGjEyRYbfV+fG0YmkLCB4vrtUw0eGXKiDc
         F2B13/nuJnUZVwoffUJ/Om6SUWnkmgOFIITZMs5wJYWiy+idhBv7PFE3z96tYlcmWIgE
         8kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166285; x=1759771085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8N7+SRw+4fb7ms5sLEv+9Amp7wSRqL4B11xUAR7VxS4=;
        b=BsT66Nig+FAoA30LlosbU8EtO7EUtRJ9viGFOUwUqHXqmBR8AQZ/jSgStPEQOqMbpI
         B0fvComyb/nkmBLXsrjkLyPhLTlsbazcgLzJEgmhS45oA+fw1xtVuFk+HtMu/J/9AJGR
         h9+4B5IvDdiYY5fnjOj/9AljTgtvhR5d39FLcumG3RViVkpBQrrSYQy9oOu/eIwewQlG
         fkV1uYGv4bz8oindnOnlUXMhuXIH7oWgJfRlowPtW1eEdAfl90BqkksMfbuID3eEgkrC
         oZ5Huf51DhjM6WkGZ70fNNy7tfvxwK0ofeZWkmQcZzzFtkMg2iCHOwbyP2vdzp8BFzM3
         cHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvRNR5kDa05QANM+nROipYI9Sm9j430sDqmUEHMLXW4Af6N6NI62j6bFFaAXoKeqk66eXpe/ouAaenHCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVEYKrGTmH1VmgidaBDBILo+5c2mKLjzDGED9Q3TzcNS4GWMv
	ZVSUdAOaZoW2HL60gUfxnby82Ba3oz5Dyxr5hkcRAeyGnSYgDfkDYOVs
X-Gm-Gg: ASbGnct3bcu27XXn12rwhnaafp7PRVEcaVNWwoupFaqXVVQ2Alyuj7s9EFZqLAKDKTQ
	LaHoN3hVH78eZSK2H3f1C/CTLeMz+R0UnQ+PxakpomFa45ta3K/Tr38LGq+P1nb9SXYmXcK+Rcd
	+J8fxu53nzCJYFLNPt5t+BHYlcKHLUcUFhMdwNhSkr6IC/6lWsBP9GXskTves63VAxNMQPypEEP
	JtVOI2IB1wAEIo+AlSckuniuVuKJCZEoCBYnA4zrPZ+1dVyrLAGjtYCUWBt5JDqRW3oFWjWJgZe
	MfVh/LFRlxiyH17LCzRmxt7OgNIO0NtdCrPtxD1pnnBWk9RzLts9ieGTL00gz/h+cRLW4raemv3
	qOEsSzbtBqfLGvYDVT/xVxxspkuD5X+K3weSjUd0D/xnFp+PeRXtrKBs3fcQlF2dPvvrv13u9Gk
	t87qY+qRqqtyMN9PSis7xGL1zDzQ==
X-Google-Smtp-Source: AGHT+IHL57hT26htgxW5zl6/HZ/kLPlAQmFjBSeDtQM6qgZ+ndu0fWXFlgK+6JXF9HYoIRwFSrojRg==
X-Received: by 2002:a17:90b:3148:b0:31e:c95a:cef8 with SMTP id 98e67ed59e1d1-3342a2e148cmr15480239a91.32.1759166285299;
        Mon, 29 Sep 2025 10:18:05 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be14601sm17629314a91.14.2025.09.29.10.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:18:04 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] filelock: add .gitignore
Date: Mon, 29 Sep 2025 17:17:12 +0000
Message-Id: <20250929171712.1161253-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a .gitignore to tools/testing/selftests/filelock to ignore build
artifacts. This prevents accidental commits of object files or binaries.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 tools/testing/selftests/filelock/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/filelock/.gitignore

diff --git a/tools/testing/selftests/filelock/.gitignore b/tools/testing/selftests/filelock/.gitignore
new file mode 100644
index 000000000000..410842f05f90
--- /dev/null
+++ b/tools/testing/selftests/filelock/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+ofdlocks
\ No newline at end of file
-- 
2.34.1


