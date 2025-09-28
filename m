Return-Path: <linux-kernel+bounces-835198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459E0BA67BC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10A517E195
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E72877D3;
	Sun, 28 Sep 2025 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BB5NQwkD"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E772857C7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759033701; cv=none; b=iByiV/U5SXi+dxn921/n2+SE7QdY1M5Hy2cpY4Y8B0TKyhHd9mbFOT1nkMAjENI/O8emKKRWIBBdciKESz8+6s6mF3w4gyK4JrFn7SBhAnDkEC0mtxrB+tqtpiC7f7nu/aVOjKq0vhHiYYmAkimzUcjSJr8DpcYMTL13VFlhH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759033701; c=relaxed/simple;
	bh=nuRR6zw90qB7SgrCrIDW+FhcmnpqZupfSWo58gy++mA=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Yyfj/mSfRDEh/Sshcl89iJRSXQgzhtRZuvETWB0qO/p5MAdUShCBmO2VMZ2+CBZaEZXemLi0sAocc2AA7H2X/X/5jAgqACqtzoXMR2V9FVhYOjx9rhnVNtYnXXw4L0wDfdg4HqCDDMsxk9AZ88xAOMwD8+KMJlVTKBwUUl8J8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BB5NQwkD; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-76c144b06fdso28594427b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759033699; x=1759638499; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6wp0fDq3k0/r9k12dCZGeSiwwlkTpuN3WtXOkQGhZJI=;
        b=BB5NQwkDMZSN41F4T2WEk/Alg/TPUCxuJ4OCW702TKm1XJF3a9T4u0ddtVvvW+8vJT
         Qbhgro6s9suOEXafR7DDNjY3LKB2G58fKeXaJ/8HBazT8dCTjR9zozIwubWKybRotmZ9
         WCQXIQpn9/HrHz2S/qeKpgCQOyout1+w5d6/xwh59cI9ZU4XlyDeL2w9oaMLB2XLx8CP
         3GYtKdseXI5iwZJQ4yH1p3Y5DUqMv8fY2GB9Sv3bgA6Z8KbrMUQAJ+36+Zc90ceY+myv
         FLLGouy2SWr6iph4yJ38mq1+F7CIUDk9gv5hB/JqebmekD1k99cPskS05D/JKfA8f5+e
         6F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759033699; x=1759638499;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wp0fDq3k0/r9k12dCZGeSiwwlkTpuN3WtXOkQGhZJI=;
        b=njLAkNrYL/7yfu7CEfLZm+kF10LgA+xrpf0KVhubfxARQL2RDoI2iDa2GZ93pl85ab
         yetyuP/jmzE5jeoJGR0A0qmSD4HfKVYZBME2RWXu1QI6iF6XAUCRhOZXNjC5aEflHKQq
         Qz0j6IhlCidDcMsW2m7uvhbyacyGYot7ncVt5MyrDXqDE8OsZeHXV7ASfuNvg6/7fOsP
         sMfy7THyk30czmrZm32GHaK+kHQeXS+5RUmr66E/Q+bhftqRoZLjpk6iRte3ODqlgU2W
         b3Gh8LQhh6GQ5VPsdTQMCtcQkyZOVO3Vga0G3tl0+OCawrzQ5tsSlfB+qpcMaHqGaXs8
         h8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWhCqryE6V76bSgJmuBTpOPRostdVw9h5s4G9uq0JG5/Sy6+bImZjoZkoVEfcYEYuDyfna1ca7MD/pdNGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaN4ofBR8NFz0m23Vu0iR0k7duY23YLj5BV/NhZsiBxB1+oTXH
	iZfBat/9v/btHOVxDEPGrUjQbdbhFYbpzTyaETyI57j3DOCVmSscElU6t8gp6uz9uqA5nef+5T5
	JD2pBZQ==
X-Gm-Gg: ASbGncserQfWaiXwmQcY9oMyxUEJ8LJSOcZ70Yp0Y7M2brvZDHqve80Kc+epB8b2nFs
	A3wv8P+Gh8vl/IW3J/6+QG4/Xszm6VZXtHwNct9oHeT70wsEB/qXhrBYbrY82vh3/v+oCc+Mct7
	i0MyDSXepEnx/4aJ1/Ll5MNV7QxD+L8MJytU8zFrN5Z4I4HI4kKuHaxg0ryU7csU+Xp1QDAioh8
	2zprZXyIFOZ0G7NLHtzcf9JJmfj2NP6XTAMkrhYspCqTfdzpqK9VjetlLjNKiMlOUs0uJIaPTJR
	BckrAc7xZEcmF4fnwIW2L/htt3tZdDNZCR/MMTPf4Qdj1rQfleiApop5jN5ocGqDLM8kOL0sph/
	uBaJK8LQR5W7PRj4G++7tM64h1kxYUlw0xC9JOSGFBB89yCUB/YLE745Rqsa489xT/kZBzwoxnU
	t3Fl/9kkuZoXdwzH/DjnQjh6BM5efn
X-Google-Smtp-Source: AGHT+IEmjdyhyqxy5Fj/p/NzSZeWCCbu4ozrAL8XK6jcYUIhMH6CwQ6zd7Hg4Kbpnan97DOGis24Tg==
X-Received: by 2002:a05:690e:259c:b0:634:7613:25a4 with SMTP id 956f58d0204a3-6361a73c57emr9911004d50.14.1759033698815;
        Sat, 27 Sep 2025 21:28:18 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb383929c1bsm2473845276.19.2025.09.27.21.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 21:28:17 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:28:06 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Nathan Chancellor <nathan@kernel.org>
cc: Alexey Gladkov <legion@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
    Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Shier <nsc@kernel.org>, 
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH next] modpost: Initialize builtin_modname to stop SIGSEGVs
Message-ID: <4590a243-0a7e-b7e6-e2d3-cd1b41a12237@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Segmentation fault ./scripts/mod/modpost -o vmlinux.symvers vmlinux.o
stops the kernel build.  It comes when write_vmlinux_export_c_file()
tries to buf_printf alias->builtin_modname.  malloc'ed memory is not
necessarily zeroed.  NULL new->builtin_modname before adding to aliases.

Fixes: 5ab23c7923a1 ("modpost: Create modalias for builtin modules")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 scripts/mod/file2alias.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7da9735e7ab3..b3333560b95e 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -94,6 +94,7 @@ module_alias_printf(struct module *mod, bool append_wildcard,
 		}
 	}
 
+	new->builtin_modname = NULL;
 	list_add_tail(&new->node, &mod->aliases);
 }
 
-- 
2.48.2

