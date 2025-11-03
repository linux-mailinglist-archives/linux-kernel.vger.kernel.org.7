Return-Path: <linux-kernel+bounces-883325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3DC2D106
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 102F44E40D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED88B3176EF;
	Mon,  3 Nov 2025 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP7ygsWI"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F43161A6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186804; cv=none; b=DcamDHcQqn08aH/hwtZlkFHhB9HupTDUW7eBrjHW4QChHj5v+oSM5Tf7m/KOhuHDHQAHeaKc7s6vlOTdOFXuYNkCnK40VSd0s9faP80LNvp9b/H3S2pBxVTxFAuFjMDkpxx4CXONR6a6TPeu93wDn3CECfQBkguoMBl7wJQBTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186804; c=relaxed/simple;
	bh=mNCO7bKF1YLZWJUvv6QucWgagnW9KRRy5Z/VQ4WsXkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV7/G373JAsfW60KXPD7gRQBBuAjisZQbANiFlZ5WRPoEuWH9Rh4QLrDS+5CHKH+PUU3DLsPydF6JuxwW/WhpKmMu5chGSb0pSa/aRzlzW5PetSaNt2EOa7UIS241Pcyq3zmVVQGw0ChT97mprtwbaZFDp6EFhl07X/d6DEAmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP7ygsWI; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eb9fa69fb8so62845451cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186802; x=1762791602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stkcD7bp9eEScodaC0wp9S9uIOMbzo7VYqM5npEhDuo=;
        b=YP7ygsWI4uYnEBFXIWSJReTo1vPTr2AmE3ku8YVokpGmde+rzBe42cA8nU5qjclEwR
         qH4Y1IKSb/KKmuw5YJGeO+rVdUpm8FZR3GWBRXcKwTWSxL00JIFFH6lY3c4aTvxw8fZk
         TKa/MDue6XsPkJc5jLicI3U1QjvVjsfYfYagi2W7hzj8wvbojBbBNkK6C/6s0g8C93x+
         nixx86mERz42qzzxDxV0sbHPEV4KFuS4rOAlT4bF+fgKkBm987UcpSWLolgBTHB0eVYj
         K9R3Fz1C5P/7lXcF6JHXPjHi3VjlqNx3ZAPgIq5VFTWkQ48wXqqpxCNYQf0GoyxmjceF
         1jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186802; x=1762791602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stkcD7bp9eEScodaC0wp9S9uIOMbzo7VYqM5npEhDuo=;
        b=KkuXPz/p7MTWp1rzWuyL6xgIE4zxDqYMMfQwH2mJNCjVZJlUCujSAbPyiYcA9DQ6Lc
         l4g015QNJUrMMSTtwLdBKj0ffat3LfG0GpP3Acdo5jEbQCqPgwhYlajqRKx6uBHWA6Lo
         sDhBX7Oei5g01u4RAhcZDpwFAOMM9DoSDS+agtnR0w4fk+RCJtru3FVX6V0Q37LaIcch
         EVkT7zGyoxYu1PDmEueF3w6jDtA69BADsFC1eqdc0lohgXoTEYzvgOY+RWEpiIpODcYI
         cGX693p634xIIDkZXq+FUhFFQIiYX24/FJXwHyF26BulXZBxEx2ZccN7/CX5J8nD+m28
         gH0g==
X-Forwarded-Encrypted: i=1; AJvYcCWnSMkNOaubkS05oQlSbhZNIo+bsjtXJ9bfAUBYBGK7h1brhkm8H7lD/IDuZwJh0btz+09SVTFD2aPYofA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNC288L0SBOuGbbkWmvcM8PrXqZYFP9pZ8U0/FJnosQsbBF8wq
	p90fVQD5ELXTV9iCW4kBVZmaO82yfMnNJ/NjSqznwz6llpCW0g+1cWN2
X-Gm-Gg: ASbGncvGWFZYGTFalYeqlTqtK8XIdyRG9SYtWcOQt7VpgBSm+a3j12Sk7k7/XHTBfSJ
	05pORRYEJODBPavlazHt75vYkgrgf+mRl+i6+oq6KR2DM4s7jtKQM6OusgXkW57PDu40Zdk01Vb
	+Oa3u/tjSZ+pWuZr3dulVqW9m+PMu/8CRoE7EyB3h4oaJRld6eH0SdXqWI78okp7kG0hwPRpBsi
	8gb6fHkteXQjkrEYLUx3hkH5Dt6oaey+OGEe6NfD8UE08zgXagnE6i7Wjd2yHGwHMeYoU7VBkQX
	0h80JkkeQCpvXIwp2cculsHr1h/UtqDRktiDu4SijESZHQHWdalZe2VY25JWxX3JFKc32+bhCFw
	S1uOG2kgnxZW3BQePNU+Gf7ITbxMrkGPGFbObaOSSTG7Sh1Dt7Z2HmQ8h0xTcVn0HTLstVa/OVP
	kp1qD2hHrg5NYr1WQ=
X-Google-Smtp-Source: AGHT+IGe1q09n9Y3T70y+bZseDCq548mz/zlbtRlwZW06qsqGJ+EAcKCvfGCZuP/HMHl9AMMVlN6zw==
X-Received: by 2002:a05:622a:989:b0:4eb:a33d:1f45 with SMTP id d75a77b69052e-4ed30dcd062mr185924351cf.33.1762186801557;
        Mon, 03 Nov 2025 08:20:01 -0800 (PST)
Received: from ideapad.tufts.edu ([130.64.64.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060eb3332sm4273556d6.60.2025.11.03.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:20:01 -0800 (PST)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v5 2/2] rtla: fix -a overriding -t argument
Date: Mon,  3 Nov 2025 11:19:08 -0500
Message-ID: <b6ae60424050b2c1c8709e18759adead6012b971.1762186418.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1762186418.git.ipravdin.official@gmail.com>
References: <cover.1762186418.git.ipravdin.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running rtla as

    `rtla <timerlat|osnoise> <top|hist> -t custom_file.txt -a 100`

-a options override trace output filename specified by -t option.
Running the command above will create <timerlat|osnoise>_trace.txt file
instead of custom_file.txt. Fix this by making sure that -a option does
not override trace output filename even if it's passed after trace
output filename is specified.

Fixes: 173a3b014827 ("rtla/timerlat: Add the automatic trace option")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 3 ++-
 tools/tracing/rtla/src/osnoise_top.c   | 3 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 3 ++-
 tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8b12d8803998..ae8426f40f8f 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -557,7 +557,8 @@ static struct common_params
 			params->threshold = 1;
 
 			/* set trace */
-			trace_output = "osnoise_trace.txt";
+			if (!trace_output)
+				trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'b':
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 0be400666c05..6ae7cdb3bdc0 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -397,7 +397,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			params->threshold = 1;
 
 			/* set trace */
-			trace_output = "osnoise_trace.txt";
+			if (!trace_output)
+				trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'c':
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 16416192e432..311c4f18ce4c 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -878,7 +878,8 @@ static struct common_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case 'c':
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fe4f4e69e00f..3a3b11b5beaa 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -628,7 +628,8 @@ static struct common_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case '5':
-- 
2.48.1


