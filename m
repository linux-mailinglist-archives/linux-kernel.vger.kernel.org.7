Return-Path: <linux-kernel+bounces-843939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06416BC0A33
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FFEA344334
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFF2D4B40;
	Tue,  7 Oct 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoU6ZAZO"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938612D4817
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825960; cv=none; b=Uke0B8WbyN3TYkWab568qFp/uWc3rxHFZkkQEEsVNX42BWBDNwZtYJPPkBeM2k16CCkhsJxEWUxUvfy7085xhCyCaU7+pmuR/WWTUELBD/bJYX73UaziV3+RUYcyheC/cXIIiT2I4DNTd7HJLnajhtCD6TbtelWCCzvEPrq9N14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825960; c=relaxed/simple;
	bh=UyXS0YiulfoICjWKVbZLAuV+X0gt4aJvE3oK8qyJ30E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjOvDuUETMi6YC91Cl1dEA5hxCvejdA3BFJe3o1gLlK+4Y+ghkNnTOo7X+z5ylEHjoqB4cZ0FP3wjIXxgEvcnJ7aNz9N86+YogNo5K04p8Rnw3CRxYSNpKzyVLgUrDEA04WKEDOC9FNjf7o9syfZYFkjT5KAg3xJGovfQwZhsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoU6ZAZO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso3936225a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759825958; x=1760430758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HprILVmlCINZEM+NQvrClrUcjHEMUlllXqO7BPuLx90=;
        b=XoU6ZAZO2m49XN1+y/2A/M2ZAltddjpHTRHuEyzKt7SYujeDozV9R+lZtcXwivtS8Q
         aYX5GdTtVj5TkneEpWtZ4N3eBl7Ph2zOndVvZEQ4FSYV4OCdNVdQu0w5Gr9s8ZdQI0cp
         tpE15928EVab++85xjbhvN5da9Sx/rEavxisbqg5UyFGPI/pSG6W0suuxGlLOAZdoHGQ
         pGL7OrfwMNRzz/bgTqACZkRC76pS7oE7jxi3gvkWSQp9w+8srbzykdDWs4aJu29VRZNE
         MKcxunczgINFyogyfZRJySZFynh4YrV9PBRTW4agGAuHx1BCMS8zqh3eVud9E2ktXKvl
         NxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759825958; x=1760430758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HprILVmlCINZEM+NQvrClrUcjHEMUlllXqO7BPuLx90=;
        b=o/1E3ix5PXK3gYZSlYWxAbUtgmttxHWoOzrkx10jNf3648sZ5oFh+44nByPElSRLTB
         aIaRo6EUatmFDNWVoLWRffIlMaVcoaX9TEH+V1pcTYdL0xbB/FxPbA0tXH1TEgwi3GjQ
         hKHmtzxDzNLEgbCCrK2q9TQscRdHlFcfK7xEMz1gRVrGC3rd4O6kyP/verxy5IeUA8np
         DHurvGOo3D+Rp5fqXhDzTMWC+2tenOkhfVWVK15l0sia+1zvEHdTwgoHiFazlzyg5+Z4
         +9F+ZFqwMroG9bNPXkY9CVMDOzifw41IRGAsFh5rA5lR9sFeKfWsIHKQkVtEDzCTnlCf
         jZEg==
X-Forwarded-Encrypted: i=1; AJvYcCWexrDN3vR/srBrfohpht/T78UFVDPOGz8HWxsavKI1zvEkxXwDjima0Rc5ZeDTpmpG7vce1UlHB4aTVN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlbl70lreNhVfbMuxOMRgotsRZsOILz83qvEA1n1izSb9ZqVT5
	KDWQS2kVH83iyR/3Tn+7HXgGVa3FS9z4qb9lFrKA/3hrP9r+xKZbgV+H
X-Gm-Gg: ASbGncvrH0S9Wv8yzWo3VJWyseSc28CXa/Dvh4F0hXIEbHJWmVQwU7ZYHzTw61GMsrw
	eMSAUXXvQVnHjeAvTcK2xrwbijCkE6r/Itqeke7L1a2CogzWw/a5gWSt9tNANwnAL3CMQNEGTha
	FWzUVam9k8xyZYsvmNYjdwzSf4W+NFzm7NduExJBPGavQoWu3fcswJFTyyZ6n9bPFmjMW8NDryf
	WGE78oD6BZoUlfsGUSm91sFOktZhy4Mxmdqg11EYwonEB6ua4nzK+2dgC2VDlNghHh97TSORU1G
	9ujrEKxQlfgSmmlDSOSK6+X3pKFAboApbhUUl6NKYu1JHWmsTWRRxMx0fVW71YJRE+oHvkZyNWy
	vwtaJEexX/O0N7lH8CoILTK6In0/Mjj9PPnTa5szCxtym6CC8wXaYOpb3Dz4NH7wrlA==
X-Google-Smtp-Source: AGHT+IEQinegNp0eryTjEE/PSB7WT+WxKJi2rEkoILL6p0tSCG8SZofKeGirNv90BH6Yz68RvHxRpw==
X-Received: by 2002:a17:903:3c25:b0:28e:9427:68f6 with SMTP id d9443c01a7336-28e9a593d32mr183371865ad.27.1759825957801;
        Tue, 07 Oct 2025 01:32:37 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d24aesm157032525ad.118.2025.10.07.01.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:32:37 -0700 (PDT)
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
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] Documentation/rtla: fix htmldocs build error by renaming common_options.rst
Date: Tue,  7 Oct 2025 14:02:26 +0530
Message-ID: <20251007083228.17319-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make htmldocs" generates the following build errors for
common_options.rst

Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitution referenced: "threshold".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tool".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "thresharg".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tracer".
Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitution referenced: "tracer".
Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitution referenced: "actionsperf".
Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substitution referenced: "tool".

common_options.rst is intended to be included by other rtla documents
and is not meant to be built as a standalone document. It contains
substitutions that are only resolved by other documents, so building it
independently results in 'undefined substitution referenced' errors.

Rename common_options.rst to common_options.txt to prevent Sphinx from
building it as a standalone document and update the include references
accordingly.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---

Note: reStructuredText substitutions -
https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#substitutions

Tested by running "make htmldocs" before and after the change,
verifying that no substitution errors are generated and the 
output renders correctly in browsers.

 .../tools/rtla/{common_options.rst => common_options.txt}       | 0
 Documentation/tools/rtla/rtla-hwnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/tools/rtla/{common_options.rst => common_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_options.rst
rename to Documentation/tools/rtla/common_options.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index 3a7163c02ac8..cc2721315552 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -33,7 +33,7 @@ OPTIONS
 
 .. include:: common_top_options.rst
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 1fc60ef26106..a11c485f127a 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -28,7 +28,7 @@ OPTIONS
 
 .. include:: common_hist_options.rst
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index b1cbd7bcd4ae..c7bc716b2899 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -30,7 +30,7 @@ OPTIONS
 
 .. include:: common_top_options.rst
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 4923a362129b..547dfc7ace58 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -29,7 +29,7 @@ OPTIONS
 
 .. include:: common_hist_options.rst
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 .. include:: common_timerlat_aa.rst
 
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 50968cdd2095..3740fd386ea8 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -30,7 +30,7 @@ OPTIONS
 
 .. include:: common_top_options.rst
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 .. include:: common_timerlat_aa.rst
 
-- 
2.43.0


