Return-Path: <linux-kernel+bounces-844670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E5BC275D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B452019A200F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19772EA17F;
	Tue,  7 Oct 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4Ky9h9W"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121512EA176
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863379; cv=none; b=ELk7xOlgG+67Md6cKaZO8xI0q7xv8jLbHRqhqf2hLr7R2i9ScyaflW/XHzeZxgCughyAA4rVekZLJSZDfxfBXVgdDU9vrVcnB9qMDME8NctHl7+O81W/XXr7oR7Gm1M3a5ZdIh3zmnpJSbYUkCmJu1hvJWY7RNXhwLQ3wR2RJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863379; c=relaxed/simple;
	bh=CloW7FhMBhnWY7ih3iN8vM0ZFn5kYPF7XeKW8uvATJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfC7X4neATG3i6VKuXWt3DA9Ju3ZOtU5vTpli+7bd/OlLTMMMdvXvEwLeFgFQdHKUaVP89RBPg63r04M3YIdb/FmZrzDIar/KvSa1fMeN3P9h85TddDqBB0sNlO9dn9oSHfSLDZiogtZw0p0Al72JJh92Yh1qsdJVbpqbUjXYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4Ky9h9W; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b55640a2e33so4947667a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863376; x=1760468176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMcgMtnQhy1DPy++ljFQ5B7lhaXeK21GW1cVMqM8xVY=;
        b=X4Ky9h9WDcNjF8cSIRN6d5b5X66n0vVJCtcNld6TIPkAjY5biZyMs08YBXlgo5b1a1
         /rc+1U85GP8WerYXsurZGjUBPJ1puo6fxY9HwXvroLUk9js2r/vv1UEICZFgLbDrtZbH
         gxeqJ8usCdp/AMuLjdTztUYmQjd2avCOP3HbXAEol6l1WV++JBnulZb+rEHXio4Zoy+q
         me++zmHBNitE7+nAkjEae1gHG7NEbenTHlZlNQX5twO4df2czDOM38bh/FzoT7Enk+9l
         3zJe2XX8g1pb46blmYti3VxLa6X5N9JaX/qvanXUXFwfA7o7A8rFNI4PEuYXPWh4aWkg
         I6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863376; x=1760468176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMcgMtnQhy1DPy++ljFQ5B7lhaXeK21GW1cVMqM8xVY=;
        b=sScXaGxbgY1sML/iZDNtqVDG59p/VwWJzYHR9x1PHaNFc7gn5+JRoHcMI3qLbw+QDI
         K+o0a4ijrjihINhOhSwdLpnc2A6DVEFrwTYnziqLOguhsn0JPIoizmRFEQKVAyHZ1Ybt
         Z/mOXFZ2qjKs6C8ryjf574/fCmVztw6OrOlZS4rRRtQO6LH6o4em/DxMwEXub5PaypAc
         desseIl0/wtIhVyAQe/gMjkw/8+sGVpGlwBbki2f1m0e3HQCqR4XsJU0YZm+Cg7a9wFQ
         ht5IQ0cBcNr+iHWOpOsfpAs33urs9PSD8NbGsk2d0cruYVHq+q0T42k//COnOB30u0JR
         iVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnBkGfNjOBmiNjEqpyUfSaxqDtuL2kf8c+4zWH8z8KGPJwzc//pCQJk4PdT4mCOvQ8BdwJCRs17uKfvBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpDRevc3zzPXkyLtew1FXju//xIyblzFDP7bCzWzqTaS5P2dY
	G/tOIuByjcDvphfJc1Sj4z0dxa2Zsyexje6c+VMAH1dmaTrFRVBeAewz
X-Gm-Gg: ASbGnctY1zoYj9ndilsPOrr4vSpr6SBuakpQI4kiUx7pj+bqWA8X3X+eAuudw8v9Cgq
	nJpIl1RxXxcyxwdmzyC1eGQnzBF1lE5PInOUrl7UoyCX/nwRhiQGuUrfCbyFvcQ0zhu3/GmPH/1
	4bbCJ/mojaTUgLkTZp8QI83bHGBns7VdozQ6e7SllKBYq5YyTuckMnSuEjZUP1pccRnuNCR5dfn
	pnM2b/Hxq00XVtMhlFPRtIXvnEqtaw0TQihIeZ40H27T3ksFdcZ1aF1TuzpuzfEKn8XFNFLBUvZ
	scIXWmmFWDnivNkb1QKBoPeldNYNf5ThOHs2SbuRL5DwTjsXp4tLnBy2MyZo48uwpf5rKPbEGfe
	j2XK5/5c4Z4U5+VNCx3/H1afj/4vA9+g+ihpw4RxtwB9+V+tpweJmNv7auwNPw0mHjw==
X-Google-Smtp-Source: AGHT+IFcXfO6RvhF3YXlYYvUUUIceGO4XmoS0wX/IMzMllJDL9x+dTFS2NyLyCwMy0EW7eslfVVevA==
X-Received: by 2002:a17:903:8cc:b0:27d:69cc:990 with SMTP id d9443c01a7336-29027402f43mr9430955ad.49.1759863376259;
        Tue, 07 Oct 2025 11:56:16 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:56:15 -0700 (PDT)
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
Subject: [PATCH 8/8] Documentation/rtla: rename common_osnoise_options.rst
Date: Wed,  8 Oct 2025 00:24:57 +0530
Message-ID: <20251007185508.40908-9-krishnagopi487@gmail.com>
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

common_osnoise_options.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_osnoise_options.rst to common_osnoise_options.txt to
maintain consistency with other common_*.txt files and prevent Sphinx
from building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../{common_osnoise_options.rst => common_osnoise_options.txt}  | 0
 Documentation/tools/rtla/rtla-hwnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/tools/rtla/{common_osnoise_options.rst => common_osnoise_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_osnoise_options.rst
rename to Documentation/tools/rtla/common_osnoise_options.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index 60a237de1e2d..26512b15fe7b 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -29,7 +29,7 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
 .. include:: common_top_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 55616085275e..007521c865d9 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -24,7 +24,7 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
 .. include:: common_hist_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index 8a852949df21..6ccadae38945 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -26,7 +26,7 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
 .. include:: common_top_options.txt
 
-- 
2.43.0


