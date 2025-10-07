Return-Path: <linux-kernel+bounces-844669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D08FBC275A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5084403391
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D582E9EC0;
	Tue,  7 Oct 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL7u0k8M"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D652EACEF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863372; cv=none; b=iv2vp/XDltbCO1mKxTh+aadxsofrEleiHiyx1Q8K2jXGUittr6vuMA52ei/UYnqAPkyS8oSGt/mThDFjik3wG/PFAT9myQSwAM9M3gULArevmu5QtRFglKejBA78NH9hZGnCKbCuLlj9R91tEodkOxW4M05eIdU0iycm2e6P7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863372; c=relaxed/simple;
	bh=PjvGj/6WIMKxEW1Znvw9l4eMpfWYkHUzapNNIm/1GK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQjEGHPgJ9Z83vpeS/IPQyI9cxg6BDB1BnO9FzKsySZ1/kv1+xxBo4+1QULEPOCOxGwkhMCgtKbKkIC4bCY7TY+qfumbW2GHfkLV5JzmptBoJ9n1k1nNAUvAH93TyzzUsXjfqwq6FelMqrsgluldMCnjEAoDeJ+1+blN4ol0fzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL7u0k8M; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso4371836a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863370; x=1760468170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUZ9lhN//CkO8fifdX7p4qPCDwEbbiKFsiRCmbfFYRY=;
        b=VL7u0k8MY/miTHsAuDoBQIlUZ5G9Ua0t+W1qosCwOkITpvfJaNQev+CqomIImReXC4
         p1S/E92bQC0g0mhOY3a+D/ydFfq8HkrSx5mm2qtQdEh7MWRZNNSS0e39jX9hnNGr5SVp
         zdPTc/kNQ7TGdxLMYEQiKw2Wu3/WVF1PHhjwttsUt93jOeOUgzI0Gi1BtczmAv7Bjf3g
         IK8/V7wm4o4TrgpqxFpQK6dOH3vbDMHOy9yulq0z9gR54OMnQfZ6ThokGyGXgbtvwdH5
         QYts2ltpPg1h3UukK9FfmQYdC6qacHKOAvv1CIUIhQmMpB+AINUqF+fc/Db5T6tp2rYs
         YL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863370; x=1760468170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUZ9lhN//CkO8fifdX7p4qPCDwEbbiKFsiRCmbfFYRY=;
        b=sO3/EbqktEKcU0WJe7GvaQNF9eelBeUFlImb/sJngEri9W7MG4ebFTEd1h9kj/WqsI
         hzuGG8jyDFa/4dGD44Y5y7owOD9P7+tKCPD0JoDfhFE8UzpvLqW+9ZRqurbboz0aqBRn
         gsSserTWoc2hRvWsfacCdzrraTra5SiYH6yZn7Kn/FUMn0WWhOPlJS24+qGawI7rwQ1d
         a+QcehuOFTucsVWx6Ps1+9ocZEgISR+0ue3yIAQvBYoFLjyqfGiU5vOXaOi+/XuH/VSb
         LqYAG5ce1ElT/2FaRzgBCPLB4WGh4Vtwe4JujW1wDgvwe3y/5CKnyIGNyM0NQjjyDoR2
         sYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/AvxjWVhiPfWwVxSxAwEmNX6+BR5IxocwqDtEMrNVQqUOQMC+YcmhKvan6xxjfFGPiCymrkUKa6AanPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BluIhd0Hb0hbQO5o1A0dx9MjSI8rrHmqYV4TYBfOrKweM6Ct
	4HfdLh3uwCtfA5xRZF4mOqXIQfRTneRjcmnIOxwbR073wPm4MbzwvAlS
X-Gm-Gg: ASbGncuJpGphRJ4SFb6OkqMh6fVH/PySuVAGRVVlE/GyPZUfPogsA/YGfYkdQwrVSJc
	YNLnOo8m2C2GPjc+WvZraYPDy/IV6T6q52pu9WSNuhYT4/A3xD4d9liXjmHf/vQvq9btwH39d08
	1UpC/JWJIJzAAiP1/G+9Chgl3oTvAPO00nckFC64MSoZdfqi+Z3weZX1GimLp0tpNnS86nM/C+Y
	mXnB1Ek9uQ+Gd8+XRpOs3Hs+30giagI8A4+uLFpNtRiz5ek57Vjhsai4EvkBJ/bgarUq3M3+GAS
	kkZi/AQCdyq+/U10I3p+OgI2beQKGuBOzEE9fcRMBcGSg4F+DAMdmKbQ0HRpXMKqlX0p/deWkBx
	6StB94pb8uKOOt1e/oN+XJFAftTHFsC65IffSLrJSqb6pReRQKYP0azGPrTPliAz5GGyeIoTeTv
	bs
X-Google-Smtp-Source: AGHT+IEnYwwHsTgb8eOLfuclxtTGN0ot15Hmrmno3ONRkkOazFE85QNijokyUfk/dnUFfALD7cwZbw==
X-Received: by 2002:a17:902:f64a:b0:277:9193:f2da with SMTP id d9443c01a7336-29027356c8emr9333545ad.5.1759863370227;
        Tue, 07 Oct 2025 11:56:10 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:56:09 -0700 (PDT)
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
Subject: [PATCH 7/8] Documentation/rtla: rename common_top_options.rst
Date: Wed,  8 Oct 2025 00:24:56 +0530
Message-ID: <20251007185508.40908-8-krishnagopi487@gmail.com>
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

common_top_options.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_top_options.rst to common_top_options.txt to maintain
consistency with other common_*.txt files and prevent Sphinx from
building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../rtla/{common_top_options.rst => common_top_options.txt}     | 0
 Documentation/tools/rtla/rtla-hwnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/tools/rtla/{common_top_options.rst => common_top_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_top_options.rst b/Documentation/tools/rtla/common_top_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_top_options.rst
rename to Documentation/tools/rtla/common_top_options.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index 102654cc0c78..60a237de1e2d 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -31,7 +31,7 @@ OPTIONS
 =======
 .. include:: common_osnoise_options.rst
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
 .. include:: common_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index ea0e9f5a5c0a..8a852949df21 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -28,7 +28,7 @@ OPTIONS
 =======
 .. include:: common_osnoise_options.rst
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
 .. include:: common_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 32d33c792dcb..7dbe625d0c42 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -28,7 +28,7 @@ OPTIONS
 
 .. include:: common_timerlat_options.txt
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
 .. include:: common_options.txt
 
-- 
2.43.0


