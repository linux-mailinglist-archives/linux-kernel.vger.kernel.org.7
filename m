Return-Path: <linux-kernel+bounces-844667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1030BBC274E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8790188D2B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3842EA736;
	Tue,  7 Oct 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ/uvhZV"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674C2EA72B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863361; cv=none; b=lS/ITyUYOqzSHlp+c+tmjOieBA6Xd2rr8nfe/SrOMjfvwTcx1mvBQj10Eb28IgGTL0tTNX4ndkc/8MhGgH4mVwRXwOHvdB2he8Mad2Sg+S1mrX1+FfpJ2+XGua+ZmsMdBstT5aE517SljaNZLQVjpsC/Wa9i3eKFwWztV7T7yWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863361; c=relaxed/simple;
	bh=7qc17epEtnYxEg2yWgO7/TgP9PveePfwhICF8dRD2Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGFe+9ipX/S8NJT+HPvb9WGkr3CxLNbbdtsjkxxJd6A9wIz89lD6XRWFf7FIpfIaGD18HBmDX+ZLRqlfplpIJqztfJuuPHUR/n2jGRCTzpf6dmwQ3zf1hCsdWGcPYzMCwgzWqHysCwWGci9Tq3k9QXV2Gtc1UMi7wBMA8KyfXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ/uvhZV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28a5b8b12a1so66384015ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863359; x=1760468159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th+qgyzrC6DFJ5YiHB/fxAmD0CanOMB/q/4DLPRUk/0=;
        b=mQ/uvhZV+AdtR+oQV+jbVkQ+WsfV6+zC0sQWLBFaimZAgMYfmD9H++mliz7BUqf8w0
         vKTepmfgRjqbbmvbiouA61QdqVwPkESWzhTCLZw/iUWju0AR7Jbj/nBcRLdUHlWolVD5
         OlYVCH/jhykaCz2ymcZhcZ0Cgo/qedlpOay+YzjbuNksZEt6RK3SOjiLA1HNqSyTqTE2
         S5XxdAVlS0fvdLllDU/xAKwwSPchwBwGfQoWjMt5B6nqqpd9Eb3v4sJK2xvIvUDd5OvW
         9CnPgf25BegxrslYLLzMruaLWU+bPmKXZuugIwTN7k4m2yazXXWLWV5p7Onr/RkhEV5J
         bH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863359; x=1760468159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th+qgyzrC6DFJ5YiHB/fxAmD0CanOMB/q/4DLPRUk/0=;
        b=iaPvryC557pdkqz0pUalyOi18294g+VpGcbgSo3arYJGX1hwlRKQbwl2uBlxuWir3B
         2hW68/96H1i86bY9OPSR84BTYPItNwHGbwvZlQCDUf5gmC3jvT5Pkkc2yUMq4znatZiI
         E/XQoLZSqcRka0T9LIVZxOcXQrnkNdC26+AT65i+8cvwEjGe8TK1r8+ISWDswYn2N5i3
         mrBz6nNZV4Db3Hn+oqdwvhXFVcGR6X27Wi1MD6vd6ihZtc7Zd/CaThQXbiF00UjQjRSl
         j3bB04uQBHBhNAP9RkyqICJZ42y/V7pzHLl3eAjAr0FcebRSZJ66vZvJ592GQrmknPFV
         GPNw==
X-Forwarded-Encrypted: i=1; AJvYcCUDe4nV7u7SzCh2oXHudDMoz/GSteFb+uJWVXCzZ4dareLXK5IvkE6m6RLD+n+fqrQu9Xu1xXVLUld3Ewo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrg7smOZgkSNNXrnMPYLPmCsEpv7xPXqvakCMbhonmgZ1CPvD
	OM9MuFkurGC+pEW+cqL8ddpfdavdDYanRXo69KC2D8gBmm6REnFn69If
X-Gm-Gg: ASbGnctmNusZ5vMzawvkA7/uBK4KJekdTmK2ZixdyZfNMz3nOLs8lBTXFH/Xtlts8+x
	EpZRXZhh7oe0cwoN4m13t/toHo6EKz4PzJcaR/6/kclQ7Ou2hU50rPMzmkqKWPSmqmr77LSOym+
	dkTkc2S1+WS/dtKf+MZrBBPGsMcgB6WsQ9sXCOzaoypwVvD7MCsodX9cuxGbAHS0Gaf2J3HUmfB
	Tj4Lt0ZWiIh5BWgRle2j205Rk4TyUx6gkjLUUGabqHpaMcB9ovQuYH454S4ftUN18KdlM7IyBJ1
	Hs3jNfMDKL7/oD62OaThLdpRO4iqQgpGVcBn8hF0fC34twZjU+3p4CiwJVOeM3VkJ494C+0cNAo
	FQwK4Xv7FgOOgtBjj7uRrdpEhvkkBwNZy5JZPIbccmI3osMArz2TFHpnNtYsBRyvblQ==
X-Google-Smtp-Source: AGHT+IGVJBbirPc9aOMKvG+rVBGZMOOpzMCZyulcVVdBkwZg3df1u62SnhBExhwRgvHQnIuMqy2w6w==
X-Received: by 2002:a17:903:1aa5:b0:269:96db:94f with SMTP id d9443c01a7336-290273ffec4mr9774255ad.49.1759863358733;
        Tue, 07 Oct 2025 11:55:58 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:58 -0700 (PDT)
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
Subject: [PATCH 5/8] Documentation/rtla: rename common_timerlat_description.rst
Date: Wed,  8 Oct 2025 00:24:54 +0530
Message-ID: <20251007185508.40908-6-krishnagopi487@gmail.com>
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

common_timerlat_description.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_timerlat_description.rst to
common_timerlat_description.txt to maintain consistency with other
common_*.txt files and prevent Sphinx from building it as a standalone
document. Update all include references accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 ...timerlat_description.rst => common_timerlat_description.txt} | 0
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 Documentation/tools/rtla/rtla-timerlat.rst                      | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/tools/rtla/{common_timerlat_description.rst => common_timerlat_description.txt} (100%)

diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_description.rst
rename to Documentation/tools/rtla/common_timerlat_description.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index ae1638bb9a99..61b5b55be96e 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat hist** displays a histogram of each tracer event
 occurrence. This tool uses the periodic information, and the
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 19cb5d203845..6f09f30c74f0 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat top** displays a summary of the periodic output
 from the *timerlat* tracer. It also provides information for each
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index e66d2588a416..ce9f57e038c3 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat top** mode displays a summary of the periodic output
 from the *timerlat* tracer. The **rtla timerlat hist** mode displays
-- 
2.43.0


