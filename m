Return-Path: <linux-kernel+bounces-787969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7014EB37E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945B11897B52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE5340DAE;
	Wed, 27 Aug 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="radSnxSj"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039A340DA4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285191; cv=none; b=qC9f+MQwOLh6lywNPXNJCd7KLZuYHae44zE/PVFoJWvl9UPa3G+59UHR1GttU6HRzzfYwPUvN6dcsBjblRH1lRWdyGZTZ0uYZSX+gPNx+Rpi+rzbbNx6SMXhAKCHj7U6b6HXnGJJMDNCMb6pF/TDLIuJIneEbPY+eGw/SsX1yJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285191; c=relaxed/simple;
	bh=G5RHcyAQhhynG+8D21Feb80SFmDzlYfQlsKBEaqLyto=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C/54H294A7FDS+Cl1DN3U0Bf5vwPUaPaZ3iIwqWGGTijuRSHxpIQgcHMyfMbmYGl2CkYcRNofhk0gdYHCM4zWP7sB58bXIHRSnzV/43FuKfK9CPi13fndUH3d6+AS7xNgteFO6PR+VNY3ReeXMU49Jh7ZH4yHqtCWvQVNmObg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=radSnxSj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so46873925e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756285188; x=1756889988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mCbvYqZ7Q+ZgN4xz3iEc7/nCTDhxbVjaEX6q4+sX7Vo=;
        b=radSnxSjSAxkiYJBw+MpdMkVxn/fLjoqnFPVQrhz9ySRtDTtfj223TyP5PUrv8gVec
         2y31DVKXEamlTKBbnHM/obLWISTNyvOqQBCnu/H9zh3Wt1TtEU2q7jAiJUzuGOuZ9In8
         ibqk1zQBtSanHfrcjTGjvNw3kWeLTj82KCqoyHVTdt8GYLBGvEc5MAxhtykUmgdogYas
         BkcPN9lZKwKd2MvTkIkuiO0xyFkDH0eLS8ormq+tI2dDu7G0k5+TrEYXCWwuZCjdxZw3
         6ZJYnzVe37S5dsnYxcfMhrz9/60L/1dyGdhsJOVXSF1fv8zzc9CKWH8RZ6Li/19Ahg4W
         pjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756285188; x=1756889988;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCbvYqZ7Q+ZgN4xz3iEc7/nCTDhxbVjaEX6q4+sX7Vo=;
        b=AGjHds2iHXVd5LaVfSxGPJZxcyvVx9U2euiQcm/0G5xGJcQB3IKVYokDjSFg8dt8xQ
         ZJBYDOE9D9d5aX6oN/0sTuZ7XqDhVpVwQ3BKK3QgJTHGAWoefskknJeUAgoPN/pBXICO
         2d4cYN1qsJ552thFkgOdKiRM0NDEb/EeZlyjwxUuMCxnTe8+ZohZ1DXEacakJlN+UwaY
         Ct8tQDcpQu8y/W06b7kdF7Fv7FxVtMtD8qDJqp1wSUjGKeFthWzIadWfdjFj2TJzBBzw
         TFfUpMWVbsZCHl8IubKAi5eNwtd4F04Iu5XQuUoJq7KrQhwH2Bi5rpG2pPoAsOBnF6xs
         3LaA==
X-Gm-Message-State: AOJu0YwalKaSMeMfC/lfDUOcB7RlhdCBPqhZceT8xVd398xhzROqF9WZ
	Hup2phhLtDb8dlLLCyngMhNOXR68X9c+nxzFLTg8TvyCrpMyWS/xbp0ZcCLIUHETBjRS3ca8RYp
	5k15gnjS1D2cM6A==
X-Google-Smtp-Source: AGHT+IFC3E/+dRj3XpK74Hc/BqhSS54lPq0I2RSkjwdKWfWuGOOUksaXYb0YFnepvi7Gl5iDWfEyn1t3jdZJSQ==
X-Received: from wrsm11.prod.google.com ([2002:adf:fe4b:0:b0:3cc:31a8:d973])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25c6:b0:3ca:4e3:6ea6 with SMTP id ffacd0b85a97d-3ca04e3768amr6875722f8f.46.1756285188065;
 Wed, 27 Aug 2025 01:59:48 -0700 (PDT)
Date: Wed, 27 Aug 2025 08:59:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP7IrmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNz3dzE4pLUIl0jYxNTi8SkJEMDoxQloOKCotS0zAqwQdGxtbUAjd7 smFgAAAA=
X-Change-Id: 20250827-master-23458abb102d
X-Mailer: b4 0.14.2
Message-ID: <20250827-master-v1-1-19f9f367219c@google.com>
Subject: [PATCH] .gitignore: ignore temporary files from 'bear'
From: Brendan Jackman <jackmanb@google.com>
To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	llvm@lists.linux.dev, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Bear [0] is a tool for generating compile_commands.json. For Kbuild,
Bear is not useful, since Kbuild already generates the necessary info
and that can be converted to compile_commands.json by
gen_compile_commads.py.

However, for code in tools/, it's handy. For example, this command
updates compile_commands.json so that clangd code navigation will also
work for the VMA unit tests:

	bear --append -- make -C tools/testing/vma -j

Bear generates some temporary files. These are usually deleted again
but having them show up ephemerally confuses tools that trigger
recompilation on source code changes. Ignore them in Git so that these
tools can tell they aren't source code.

[0]: https://github.com/rizsotto/Bear

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index 929054df5212d68a32a1f5ee2b267389fcd1c8db..b07c8c8383bd791e903ce985c14c231cb6928411 100644
--- a/.gitignore
+++ b/.gitignore
@@ -53,6 +53,7 @@
 *.tar
 *.xz
 *.zst
+*.tmp
 Module.symvers
 dtbs-list
 modules.order
@@ -177,6 +178,9 @@ x509.genkey
 
 # Clang's compilation database file
 /compile_commands.json
+# Temporary files created by 'bear', a tool used for generating
+# compile_commands.json for non-Kbuild code.
+*.events.json
 
 # Documentation toolchain
 sphinx_*/

---
base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
change-id: 20250827-master-23458abb102d

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


