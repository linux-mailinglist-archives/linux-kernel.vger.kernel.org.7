Return-Path: <linux-kernel+bounces-741786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971BDB0E8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89A154740E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FC1F1909;
	Wed, 23 Jul 2025 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6AuazlS"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C711EEA5F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753239783; cv=none; b=jjb2CSZbKrGUS0+YyS5AhwmSypTd+vOQKB8vu9v8r6co63SL31VTNnHpNWFwCVCppdEKKmotnyABirt/gILMR/c6Y752G6CsY1gUScwWNvazgyicQMVwPwNRZa3oy/RGhspLNG0gojiqXt420ZnKVTBEDmwjnzu5gWQG9wy7KAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753239783; c=relaxed/simple;
	bh=zBmn8fBwQc+fkVoKGITUaO2t7WvaUtdqQKXxg2jeqa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWFtIM/MpFeSgCL54OiD06uJzl3Xsf66z7cqiu+fq+PYho8tUK3meIJ2hbB3qHLexy5DzAAFIzj2n0mFHhQadc8jrRpTZ0IVLdJDCWx7/w5rTQtn4CVoscQPJq/G2/PJuuEeWP0fG7/Xhg4PJhQbipuhhsXiei0BsZ993C5D3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6AuazlS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235f9ea8d08so53085355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753239781; x=1753844581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suwRHxvAp32UjeYtpI6vEG5GQxMmR540Z5089pHTHDk=;
        b=Y6AuazlSku5X63XW/LkXrHKWdEAjBj5RVH0KNgKRMOXdynBQoyN3qNUncs6My2kPLL
         XhouTfpI4J1dc7WIPWgxnnayi3Q6pXRIHEsdz3xLksipJVBz9s8mQxxW0pVeE4eQjmcu
         RsJptckmUmGIqUSKCTNaKQNLXv28+HyBbEWNAvP41/lhqVU4za32disonXvsvFa7m5RC
         UmfdKuB+lX2jCPTfyttBKuvAzahpGMvnJRGpeZsajopYIRAaLlH/aBC3tDWo3gXkF2zs
         zHnbe+haUplZN+d7ZpzeRfnpLhof5K40/QDmbylNINDOqk4cnBkXHgPgBWd0ktza5OMu
         sFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753239781; x=1753844581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suwRHxvAp32UjeYtpI6vEG5GQxMmR540Z5089pHTHDk=;
        b=dEEl1UuncCQqMsv99Pz/DnzDEy5FRt4EmWHJHOAEk3WFT9yeoeMV+O3zm/gOheKX3t
         AQB9XQI4LOqNYkbRY+VXyzVRhmyphHlMh/tQKe6YlaW/+kDgz7SJKdHmKxLht7OqsLc+
         18PKQ0njkfXXlCviNo8MQZnIs9GXFy8bmU0YryGCQpItDA7Dk+6oZWZekb2W9Pdr/7MS
         V+aoWekdvxvTN2zLUTZfy4iCxos3hAmoiskXUnnMTGMvEy2J0xMIKohDdLK70fPzK6ev
         JLNXgRzk0S6kKpUD5N4C21XldfHy7C49zwy2wkhPJ2oqiDXoHNwLIeDBQwpVyToWfp/U
         sq9g==
X-Forwarded-Encrypted: i=1; AJvYcCVAf9Xi/3efqLtzu6GnBYgfFomfDGEEya/Q0gmywZXp9tOqcMMTryeJRQB0JPgpa38qJHg0KP80sGwLgtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCA6OcKwXqqqfoq0X+Hrsx7L2haof/G4kJXYq+aju/EMNYoyW
	+B4ZzMqPmInp4sVKrOpQ8LbqR6+EJY7m803JodHtF8Rq4/K4c+wFlCSdxr4pa21Z/Ow=
X-Gm-Gg: ASbGncsoI/JPYmisKCjNVyYLlUIkLBp0bLiFT0jv3J1tuFT/pEipTrbvkvUDcfHBNCX
	weeVQ7OjM3HqzjUm9HDEd9dgANR0b7NV1oUBE8Rl0CnxGhH3LVz2z+3sV/mGyGiN6vhN1gGLqgy
	Xx4mriY2olCMKJeh/ClAdYC4TD3z7glLCC3YIHwJitS9j9OJurd4USp2WAebeWVEiBUwlrwvozN
	9N0JM5HWU3bNOAA23akbWeiP7YQTk5loXasjLvWC3wloMc/vJJ5ET9gj+GkAdOnLbWnTSS7dWin
	/ieZrS9OChCprI9LfKv9bNZ/agHh2CTE/NscPIe4Yks77wVDTTOWUXCo7VNT0jddrDybLjZgqGg
	/8Mv5E+fPWhMeYFTQjec+vboiHMvvPqBaPv4oMUY1VHyhVzwu1fwVP3rG
X-Google-Smtp-Source: AGHT+IFolaE9t5RxsEEiYN2eMqq4Wdm3H04nI/h3rT/4nVcyKqorzqZ2uWJZSmKAIzQArQhGuMcpyw==
X-Received: by 2002:a17:903:1b68:b0:234:a44c:18d with SMTP id d9443c01a7336-23f98152403mr21344255ad.22.1753239781035;
        Tue, 22 Jul 2025 20:03:01 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d9504sm85546055ad.179.2025.07.22.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:03:00 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/2] checkpatch: enforce 12-char SHA for Fixes tags
Date: Tue, 22 Jul 2025 23:02:57 -0400
Message-ID: <20250723030257.66560-2-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723030257.66560-1-ignacio.pena87@gmail.com>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
 <20250723030257.66560-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel documentation recommends 12 character SHA-1 hashes
for Fixes tags. The current code allows 12-40 characters but
we should enforce exactly 12 for consistency.

The regex is changed from {12,40} to {12} and the warning
message updated accordingly.

Link: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6953ad515..ea7b6c69e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3242,7 +3242,7 @@ sub process {
 			my $tag_case = not ($tag eq "Fixes:");
 			my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40} ($balanced_parens)/i);
 
-			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/i);
+			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12}$/i);
 			my $id_case = not ($orig_commit !~ /[A-F]/);
 
 			my $id = "0123456789ab";
@@ -3252,7 +3252,7 @@ sub process {
 			if (defined($cid) && ($ctitle ne $title || $tag_case || $tag_space || $id_length || $id_case || !$title_has_quotes)) {
 				my $fixed = "Fixes: $cid (\"$ctitle\")";
 				if (WARN("BAD_FIXES_TAG",
-				     "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) &&
+				     "Please use correct Fixes: style 'Fixes: <exactly 12 chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] = $fixed;
 				}
-- 
2.50.1


