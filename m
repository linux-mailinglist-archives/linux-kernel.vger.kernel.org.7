Return-Path: <linux-kernel+bounces-818188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87BCB58E02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7905E5234DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB892DF6F6;
	Tue, 16 Sep 2025 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM/fyGzH"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52142DE70C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001350; cv=none; b=fTmKjwT5mHhORQccnt1IGc5XmgBeGfvVSxZ1Vet6zAliuccittLFgsjYtB2RFxgqVCUXOM8AGU6uF41C2NJGj+K1+hErVpih+BoZ+HDfF8S3I3G27rnlk5iMuGAnjvlQdL0/62JhVZt6h2ELQpEdqGGZvDPe6i528HqepwE8HBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001350; c=relaxed/simple;
	bh=GCQf+fSlRoXWlrGzxejOS59aSKVCoeuvh+mZuQCTo+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaGi4foO53RoMa1RX5AyAT2iO48dxq0EBvCUCHcTEI/IhmwzwzTJxpcKbZjCM15nqF+MKwgBJnh/fod6ir6Naopf3CFzm/WsrkpkksSW5HoySUd9GFkq5HCCAOeGT8R0ah77Lw7jusBFl3TMmtCP1wFurHEEMNPisVoZLBhRO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM/fyGzH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77287fb79d3so3797724b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758001348; x=1758606148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JEHaZ9jq/KrcjOhCPcE4D4fEK4s5Ukw4ZA9TW8oNXo=;
        b=SM/fyGzHXgmiYo8u4kQIBGF1zOunDjnHlB0OV1kto4pyb22PEh3TdeSjIBESE6lGGu
         KmtDez5WmcpwM6PL44HzTq7GcvBZNShAxgKpT+/siSPbxmH+AmF+mX9B9hoeKmHL9kKQ
         rjCEn6OSXkvHWCZoqnq/U8gCy3inXT8GkRB02vrMPMIYnwnYpvpuhICILA66JAmjiDxV
         AS8nwuAIEeKnHJBJh14O4J2dusk/UJ9Osy1lf/UlQWz+ohe/xw58zdrEP4m3mvwjaiF1
         O6fNHfNGGY1jLuJBGzMLAN/p7qKvLphEaSlnWYaHKzv6mzPe18QLm6/W+7w/ggC+Hy7c
         Vd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001348; x=1758606148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JEHaZ9jq/KrcjOhCPcE4D4fEK4s5Ukw4ZA9TW8oNXo=;
        b=AJmNLY+xc9EokhGexYJlwNJqgaxCElau9mcJ//gi0tFcNZ7+1DBYSFrLtiURocIPwk
         cnYSSkZS3ZjbMyOXdbKxsoktXMxZp8xQoM1aVAwNlIKOH0CBmQEqLOdQblud7Yg7/W2o
         7Qqv7i7CDg9ACi8f7yYS7wzgBTIHBT9WzQ8F6VnUChYJ7WG+R+Ns3FTg4j3D9brmO7an
         ZiOSIGcrJFm6V3vqjbizi7dSZSuZMpj7iynuZ4xMSKl2kajvwmbKfU66Mu/Ig76Iju38
         gju5BmZ+QwvexKjt0jLhB9Ip+1Iiadf3BD7PwU4NNEeYrk50Ca/uWI0tDrUMJbw9TAN0
         swrw==
X-Gm-Message-State: AOJu0YzNPlRWWgfxR1UItw8/0kyqs8HrHOC3ZrYgMZssuE7No8bE/mMf
	Xk0wv1UAJdaOrNuKphLAONX77b7wPo+QDMopS7mmj8Z5lVZsLeZ6XsN0
X-Gm-Gg: ASbGncvrS2W4yOzk8Vewt8jBm4sZDSkoNJwB+3zh14osK9W3e4FV/y5SvYa739md387
	lfkts5qCdrLVZlBndl5qmRVbAn3yDfxY/MdoBlJh442mUitA/icY7uDm/fzFlHF7sYGSOo0xqgh
	ITJH3BqcIYwSmhGSWgg7fgfeSW3h1ORCDi94rCovzItpGd8/jlY6U3ZVOC9eAVgyIT2dzWsJorh
	xvD5Z8d3cU1/uK/9l89uKwA6DyEAYh4rHQDIbyMnScvteX1AAz96lKjSI9o8fGa4c99eS7ZihGS
	UHVswKsuqabN6D+4alOvp4M9OIK9RK5kvzTSBIqhtXmRhebrF7jUS88BbnOn8KJqToYN0UfYMMF
	oJKAU6ZiFO0rT7XZ7Bkk7b7UUMQ==
X-Google-Smtp-Source: AGHT+IH2awkKQxguyzU/uwVtBqGOg3ZGaTcFUil9iVYCCLUicJLX7MvepKfcuJU+DXVC/gjlgfE9Zg==
X-Received: by 2002:a05:6a20:14a4:b0:262:1611:6528 with SMTP id adf61e73a8af0-2621611681cmr9714164637.29.1758001347998;
        Mon, 15 Sep 2025 22:42:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32df315f9dfsm11822877a91.21.2025.09.15.22.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:42:26 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 97AF54227237; Tue, 16 Sep 2025 12:42:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 5/5] Documentation: trace: histogram: Convert ftrace docs cross-reference
Date: Tue, 16 Sep 2025 12:42:03 +0700
Message-ID: <20250916054202.582074-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916054202.582074-2-bagasdotme@gmail.com>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=bagasdotme@gmail.com; h=from:subject; bh=GCQf+fSlRoXWlrGzxejOS59aSKVCoeuvh+mZuQCTo+Y=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknfpizHYkUTnk/IZ7D/nWJo3ycU5jjTR1Oo+W3/Tp9z j8UXlTUUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIsYMDI8rDyau8S8y1QvPens nXDVtwE2C3yYpl3XeLa3RdbnqPM1hv8FL6a/O23a1cgSsatpmhBnYYbvEf1Eb7f1mX+0951auIQ dAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

In brief "Extended error information" section, details on error
condition is referred to ftrace docs, which is written in :file:
directive instead of a proper cross-reference. Convert it.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index d158dadaa42447..340bcb5099e7a4 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -209,8 +209,8 @@ Documentation written by Tom Zanussi
 
   For some error conditions encountered when invoking a hist trigger
   command, extended error information is available via the
-  tracing/error_log file.  See Error Conditions in
-  :file:`Documentation/trace/ftrace.rst` for details.
+  tracing/error_log file.  See "Error conditions" section in
+  Documentation/trace/ftrace.rst for details.
 
 2.3. 'hist' trigger examples
 ----------------------------
-- 
An old man doll... just what I always wanted! - Clara


