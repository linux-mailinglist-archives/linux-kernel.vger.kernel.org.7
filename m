Return-Path: <linux-kernel+bounces-774231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF203B2B023
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF58A681A04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3059311960;
	Mon, 18 Aug 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcnOrGkU"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AE311947;
	Mon, 18 Aug 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541234; cv=none; b=mmqel6w2CkJrd93dQmZV6WlZyV7HXxpFLRG7VNDicYUTsxuPyh8ncvYkf6WjFhsfLp9L8Md5kwmXWpTYoPNZjHPIj4MS331crDdS0wDufk3/MeZoix/y1d3cBTFEUJPxlBZk+ZbDgfbEqOsPGVyrM5xhz1+RBrjwutAWxVr1sOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541234; c=relaxed/simple;
	bh=PwIjObjNEXnILCG6Etqwvak9uZ8WrPCGLpoI1Xb4OBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHGVsrloCRrRKB31WcqriYWqyDOa6Uj8z34CXsso24Vljxqp4+xqLDTnQLYpMiinio4ZVtxoH4hp5vmp8Vdz21B9okwkCOaudD4iKZ3uI2b1ZRxv56Wid+pBc2ZvRNK9dpQH9COh9NzE9qaTCxq3c0X7KqUht+Jv/63i1+9NJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcnOrGkU; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109c63e84so47986391cf.3;
        Mon, 18 Aug 2025 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755541232; x=1756146032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nrSYI9QoQCti3KzYW07TUz+VPNm/G69l6PB9811/RbE=;
        b=AcnOrGkUoHW/0YGAc9i0/ceyxNKvmu5rPsnUBlvWaU6ODg6sZEHLBly6c3LTqavvNw
         Za1G7D5D89Z24L+uHhVp9YJTLTylXZLSHaTczlt/8xNaIXNs44dnvLThyal+bDrrYayU
         NrWgWBOyMzhNEZDVCOpt67tDQ/polzy4ZXzns8I9CuOkMCYr9aeTMAruyitmfuRaiOMy
         /v6lDN6PW/1B56sOBB0jyZBypHZmk7nfBhjWB4fRd8RmuttOjOgCGEJmCwVoGmjNQAUO
         s6s91ay05gXkPvKhPR1+flSmaSFzgITt4+rauUkX09ftOU6lklNw7/JOYfsV2HXNFX20
         Fgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541232; x=1756146032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrSYI9QoQCti3KzYW07TUz+VPNm/G69l6PB9811/RbE=;
        b=RXs+UXoFONl8UQP82K0sx4ma5EAiYciPpiDPUzCFVf/3BEFzI8VlLhRsR48ZzHLpVP
         jPfoAcr3SF8zU8Z06D+lChwOBgviC8amJoxAAnp5XT80xBquQDWaX5jj+C3sm9nAkQxs
         roCd53UYt00wXQxJLPWXdkw8JBWLmpherw5szOk7yGJ+AA8gHJdVMzfr8wa0e3bcTX4M
         zf+FCE4jScbFCVevPo3fYrTA1dITv/BndRFgQ17f6gzXnQcfHH/hmcBEezTVSdiNfYGW
         4a+CSwxPIuPelIH3WS0Cnl08SGr/600P0Z9zYtFUqfSsukm8vYhiQu0q7RBpG9eAjFul
         sUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZUJ2f9tayHXr55QauvYtXJMVFSw5bywUJw1sFzV7qh1ho1MiUJue/O7Jm7XY0IWf3g0iheOSjcEgKnGWE@vger.kernel.org, AJvYcCVteHywpdojjZzFr6Qbw3RMH8C1L1zun5uL8Z5wUwDL88mi4XNGXdsmeE9KF9Lt6d4zNUTIShuePak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4isB2oCWrL/e1hQ24wK68lwXYk3yqfsFItxs0ZttoKXSSoNtT
	SuGaCFVUU9g2/Q3j1Do5/Vcrw0Uy31E/t7R12H7D/zdF9HgUoK95CPQh
X-Gm-Gg: ASbGncv7jFive95E6/5pOCq3AVTeOOxNZDP7vyqzrxgptO4sVU/SPE10f4cT56332qD
	DPOmyah/WgmXp+Osq1mwBYQfKqxHkJewVlRR68RLGhniSj27l96p5Bh9/FnFyGO2sSAhU2/FJBk
	5n/si2Mz0bx84WXnUnmP5oPuHW6g3+GDNPMaKuCaPu85PUBW9ozjLEOB5YqoOHla6GPLzgeSyQ5
	sYafK+IOZvIaR5JppZJ1uqspV1JKD88vrD0fmlQA1CqWiXZgXxxruM/7ID0+WEs/WEoxrrkO4aA
	vN9SdLI7fJE7Dly+AIas9AvjPURbCpk386eZ22Kcz+3rNDbeYAYkly4FQ97U5SoUEs4THjC7nkV
	/GUQCplmgU0Asf9Fim0Vmh5WokLUioT/6/8mSQZ8G6Ic=
X-Google-Smtp-Source: AGHT+IFdCFoIWH+NW1tEJJiuqHiXqdPjwHco3+jsUBbyLhPEQe/utSV/NDFrs3kVmC/ukjigzg+GIw==
X-Received: by 2002:a05:622a:1246:b0:4b0:e934:6ff4 with SMTP id d75a77b69052e-4b2856f4c32mr188791cf.52.1755541231475;
        Mon, 18 Aug 2025 11:20:31 -0700 (PDT)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc188desm55994811cf.2.2025.08.18.11.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:20:31 -0700 (PDT)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	skhan@linuxfoundation.org
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] docs: fix trailing whitespace error and remove repeated words in propagate_umount.txt
Date: Mon, 18 Aug 2025 14:19:34 -0400
Message-ID: <20250818181934.55491-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in Documentation/filesystems/propagate_umount.txt:
line 289: remove whitespace on blank line
line 315: remove duplicate "that"
line 364: remove duplicate "in"

Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
 Documentation/filesystems/propagate_umount.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/propagate_umount.txt b/Documentation/filesystems/propagate_umount.txt
index c90349e5b889..9a7eb96df300 100644
--- a/Documentation/filesystems/propagate_umount.txt
+++ b/Documentation/filesystems/propagate_umount.txt
@@ -286,7 +286,7 @@ Trim_one(m)
 		strip the "seen by Trim_ancestors" mark from m
 		remove m from the Candidates list
 		return
-		
+
 	remove_this = false
 	found = false
 	for each n in children(m)
@@ -312,7 +312,7 @@ Trim_ancestors(m)
 	}
 
 	Terminating condition in the loop in Trim_ancestors() is correct,
-since that that loop will never run into p belonging to U - p is always
+since that loop will never run into p belonging to U - p is always
 an ancestor of argument of Trim_one() and since U is closed, the argument
 of Trim_one() would also have to belong to U.  But Trim_one() is never
 called for elements of U.  In other words, p belongs to S if and only
@@ -361,7 +361,7 @@ such removals.
 Proof: suppose S was non-shifting, x is a locked element of S, parent of x
 is not in S and S - {x} is not non-shifting.  Then there is an element m
 in S - {x} and a subtree mounted strictly inside m, such that m contains
-an element not in in S - {x}.  Since S is non-shifting, everything in
+an element not in S - {x}.  Since S is non-shifting, everything in
 that subtree must belong to S.  But that means that this subtree must
 contain x somewhere *and* that parent of x either belongs that subtree
 or is equal to m.  Either way it must belong to S.  Contradiction.
-- 
2.43.0


