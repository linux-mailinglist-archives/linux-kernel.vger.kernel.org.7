Return-Path: <linux-kernel+bounces-854944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F828BDFCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECD7C4EB0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72A33CEB6;
	Wed, 15 Oct 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMv5tJCP"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328033CE93
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547749; cv=none; b=oLJn1CdIehme3NmZzU6fjdmigq0ymgeLbVV8U/8rtPjnyoYivXeawioEYv3dBjagYHB89I6dv8xJRf4qC/7VVT8UJc+reJS+OTVr95nXlrQXn8X2ByMghTrLT77ZrzU2h8co1P5N/XpTlUvHL3N4IbTYxiYBNPrvPOUAHw5IL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547749; c=relaxed/simple;
	bh=z7jbkJWCiHJzDsZp2daYSUCdawNKubcfe8rNVKzOBZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QA2/snqIVRnyuvQQNg2760QTIZ5AO187FF1DAltsWY4t6zOVIXTEYL8os0LCcI+v0OuS8166vjLf+Os2iZEiKWRJqBQrJFAgYH1n2y5zn0qbcZ+WBpAvUVUYnmxieAconkAk/tYBkOM27xZWSYkpbvAhHq+cBnjR9eDzTHBXWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMv5tJCP; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-426d314d0deso3105133f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760547746; x=1761152546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHQ/My45H6NW6pE8FY9S/15tlaPt8FNQ7uHm7Il0FNA=;
        b=vMv5tJCPJZsFH8/dGfay0bq/aeIdA98O86DRMjgS7gHEW3NJN3ktHDgopayy5/X6qh
         jX8fNaCSFH8Ym5AJN420JarURcpVu7P1KpnsKToC0kTxjSyIv4rONzFDrRt0mR86mRXU
         4FQRKkp07j0Y4ZwQrwz9oxCmTQO3pb6zeDT3ZVcTGqNNIMMtONjiamps3O7Dc9OtRvZT
         zpsxLVWfGxVfcewjBnxJ+91aHMd/7Jl/BBDR2YXQiCVnobiMCNEdK/rNBA4SZDFO4Kyw
         5JzJNh3uD9I3NvnO92d8elLtQowXo8CdrRAfk2kLMG8z4A70P+UGlf+U4gFSPfw8aBxx
         wzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547746; x=1761152546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHQ/My45H6NW6pE8FY9S/15tlaPt8FNQ7uHm7Il0FNA=;
        b=A+yE49yUHValpbdegl6iFMADBi8FH4UgOKoFLuOF4S2jDcDR3QQ6VeCY8crOzaRQ/A
         V0eZqNat0+hkwG6HRxuJeotYYinY/5E6Zuoxiysdbg1FL0pYB/JgfpLPkpzkfz99H0sp
         7jD5ZQssp9Ny8gEZm82v75zJy39lFk8LtoRCa2KtruqnelJ5C5ZU0yhhWJlFhG/7PdlZ
         5qpuJrZuehinIjSl6eYcFE0NYcuh7LaSl4OR6W7nQmSN/1Nt+rRbWiR6UFmUIyG/jV28
         SZ7nqbx2ok69MMMgXfwKAVB8xzQKwMfH5SqRyQe8o/fWm7AYEBrPJEMQPhn9dIIJ+lq/
         AQvA==
X-Forwarded-Encrypted: i=1; AJvYcCX0X2OQu2WwrE5ELr8AHTHUJufWN1y5nfLpnpSyfiOWoiIoMceFuMh9ih+XeuUaA5LShsDsMDVysLn5UVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu88yzuaN/xQ/FTOTxbqFgdwu7eq50DjBuGTvoEVXT0TN5VGC1
	rvfcSqwzrBPzIQIYKBOQlWd7yFdl9kympd7L2udj2MeFZE/3jc2hZvxi0NyDwrYYuPEfJSAkiW9
	3N0wlLHn2/g36+w==
X-Google-Smtp-Source: AGHT+IHR9hnAt3TkdZgTBDb3KtT9RID/f89jZOUFMT5Pu2QM6neA//FwvD/h9k3LegqwxIgWoIii48dZZ8xSlA==
X-Received: from wrbgw33.prod.google.com ([2002:a05:6000:40e1:b0:3ec:de41:d5be])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2082:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-4266e8de1damr21457560f8f.53.1760547745778;
 Wed, 15 Oct 2025 10:02:25 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:02:06 +0000
In-Reply-To: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251015-l1d-flush-doc-v1-2-f8cefea3f2f2@google.com>
Subject: [PATCH 2/2] Documentation: fix reference to PR_SPEC_L1D_FLUSH
From: Brendan Jackman <jackmanb@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Balbir Singh <sblbir@amazon.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

PR_SET_L1D_FLUSH does not exist.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/admin-guide/hw-vuln/l1d_flush.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
index 210020bc3f5684a4510792aad5d0fcec659ad7d2..35dc25159b28a280793ad147d25d582f31a77999 100644
--- a/Documentation/admin-guide/hw-vuln/l1d_flush.rst
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -31,7 +31,7 @@ specifically opt into the feature to enable it.
 Mitigation
 ----------
 
-When PR_SET_L1D_FLUSH is enabled for a task a flush of the L1D cache is
+When PR_SPEC_L1D_FLUSH is enabled for a task a flush of the L1D cache is
 performed when the task is scheduled out and the incoming task belongs to a
 different process and therefore to a different address space.
 

-- 
2.50.1


