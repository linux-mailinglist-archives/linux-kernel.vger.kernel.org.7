Return-Path: <linux-kernel+bounces-756727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A5CB1B863
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A301823F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172D2989BF;
	Tue,  5 Aug 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXEuSu8x"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1829826A;
	Tue,  5 Aug 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410870; cv=none; b=LraK2Z+NEfE6yeiwprO4ROYduFO7wB2CO46UWQM7wW3InZbbBf+dqeRl6k2H9QJbm13KF03AoyEzD29piMUWm4Xf50GZSOZatbGZhFJ/gWXIdp/OFmHsCD0/eVdm3MT+5jGODsy/ysmaHYJw1tV62D4oYqV8qk5oQTpw4/5cIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410870; c=relaxed/simple;
	bh=5O6p11q/Cm+Ve3FqC6ad3rDEA993jGbgYys+cf11XNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5o4tAzMgmtkBshHJE7+OuFg5jqokDRA3zE4i11QZwtPgFSk/4WXt+YfHHudpafba2ednXOqQwGyA0DVo8uXOTyLhu9BfeIMTB6uumxheWKKS1N0+11rcdEWBOZ/9g2PnzY2dZP3sj74ll4hNahgxGFM2P4GIWGjoP71vWkU1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXEuSu8x; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71b52d6d1e3so58250717b3.1;
        Tue, 05 Aug 2025 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410868; x=1755015668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2I8Y6YCxsX4TWyWrlqz+OvW3M3f6/2nWl2bm4+fH+c=;
        b=lXEuSu8xiDzzZCNiEISU7lk1Uz0waaaabj5DFtF9TJntzD1L8tvlcXJoBatPL0pxLD
         Kh7GY5xAk42+/DJd5V3miL8tQVfpXDnwve1UGZPjnrG4MozJUxtQCW8ZJi46UOol9xN9
         dkvHRiAEta3AeNtVcAWq4GbwWW9cxGadxo+mUBzClJWavezld/BReZrPGqSjEBn/lxFb
         LOqMzjxXNaYDa+yyLXhZXswuxUjBszFrVl73d40vIveWeFwAERNRb8ACI9E14XoQS8RW
         Y5Z4MzABe+0e1E/LyBrMTaxDyEHh1NIBtY7OQI0f0XG724+3NTZDsFqLgRYHDqk58UGr
         lvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410868; x=1755015668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2I8Y6YCxsX4TWyWrlqz+OvW3M3f6/2nWl2bm4+fH+c=;
        b=GCRpgyR4iwfU5VzxIFOfQxM/8fCk5wM2SMkVA6dbJAqL0VjzKVgnTEwbdaGZkVsXfQ
         R3ye5kM4xIdeKx3uIFfvUpOJNHSdsl7qQuuRF//fmql92N+rg/QB2Hxn/xllb0RSUVCe
         fQxDp1rEQaByc7rrIdibHtCoLR4FFVJ9VNag4i73LRnXKNWYDac39mlM8mec3l7aPUG8
         w1Y8f06gXvE61mwCY/YNORdhWiMalXz7ScyTyepEe+mkKi/+UucCz5usCMCwvIxbooY/
         wKv6e++A8La1dcdGnXmwKLu1m6oSimvM4AYc5OteElZvroqKY0r3XJrOeZQOiomzN9FX
         75cA==
X-Forwarded-Encrypted: i=1; AJvYcCWfOVof+OL6am2XvW09x0jjEMjpVCA2tUwGII3TiFehyXSqS+s0snQy7mlFkvONx3e1MCvm8YLoS7SvCbxG@vger.kernel.org, AJvYcCX8cj2ku7l+nKGY3iYxwZKdRyChVdF/3ZeDpi0ISgxrvPzhkRVzQLiqIFEi0OeNuB0ZapBQJ+78w58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpQkfEMNTuh9Q+lzqxt4iqSmOh8QWImk59M9X9/jRL69pjqOH
	2zZJmZ8v06Rlt2ZnRG9Y8f0b2hgOztKasscKbkAgwa+NeB5K/XSMBaxy/GuwHA==
X-Gm-Gg: ASbGnctKsKRx5zjwSZ7NFe3OyPrYLtMDZqewadvNlOayvEsuG9uYKzb1lD9OS0AxwM4
	Rq1wMVNF3oGSNROcDAaMjThRJ5oyuWMJHEoibWiYQpk/uqM4ltL9tvELYmkltWSX2ZphaLBGDX2
	TXDKhIQgB1X7FWm90TEeIj5wSHFIQGMuIeITB6S4L0ww3dJrFhcJpICF4z5Cw6aKlljcgodV1gK
	NmIofxOKIkL0s6aUlmouvXH+QnBbeU08pCrqNDwydTHRy+6y3cMChAXvbeONgaxhnsBThSv0En3
	F415jiYMVWYBW+mKG3LjebDtV/T/HcZO/otkqxxiwAmFaLrGj3A+xm6wsx2aqkNxIBqPseXQWB2
	SRSj0V9FKbs5tJjVZdA9HdPz2LzUMhBokODtZ16JRe3c=
X-Google-Smtp-Source: AGHT+IGS4lh1JrnZOMCC7QWGY68gCUxCM5gOUlyEM6e/iXESyuVJbUue1PFdHnmYU2Ldv5Xe1WJeww==
X-Received: by 2002:a05:690c:7107:b0:719:a34b:5e50 with SMTP id 00721157ae682-71b7f5950d2mr163236987b3.21.1754410867586;
        Tue, 05 Aug 2025 09:21:07 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:21:07 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 5/5] Docs/admin-guide/mm/damon/usage: Document new DAMON commands
Date: Tue,  5 Aug 2025 11:20:22 -0500
Message-ID: <20250805162022.4920-6-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: <20250805162022.4920-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

Document the new commit_schemes_dests and wait_for_schemes_apply DAMON
commands.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index fc5c962353ed..46b6260855d9 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -142,6 +142,8 @@ Users can write below commands for the kdamond to the ``state`` file.
   for more details.
 - ``commit_schemes_quota_goals``: Read the DAMON-based operation schemes'
   :ref:`quota goals <sysfs_schemes_quota_goals>`.
+- ``commit_schemes_dests``: Read the DAMON-based operation schemes'
+  :ref:`migration dests <damon_sysfs_dests>`.
 - ``update_schemes_stats``: Update the contents of stats files for each
   DAMON-based operation scheme of the kdamond.  For details of the stats,
   please refer to :ref:`stats section <sysfs_schemes_stats>`.
@@ -158,6 +160,8 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``update_schemes_effective_quotas``: Update the contents of
   ``effective_bytes`` files for each DAMON-based operation scheme of the
   kdamond.  For more details, refer to :ref:`quotas directory <sysfs_quotas>`.
+- ``wait_for_schemes_apply``: Wait until the next time every scheme has been
+  applied.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
-- 
2.43.5


