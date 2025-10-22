Return-Path: <linux-kernel+bounces-864438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF4BFACE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F0D1899CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC30D2FBDF6;
	Wed, 22 Oct 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTbanoCv"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C433B1AB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120433; cv=none; b=gY+sYX7HLhDnjYE5GteirbfeLtoXCFSis82K0ayhNKmDg8eTlJNuWq5EMw2e2x3qB2Pvssk6WXZuBjzP//+2+mCCMeCPfUeLToEm6bh0uLJhfw+2cjoEznZu9PIZvht6yQzXJU27FkEVNkneKIx5AoiZo+kKBggufkBcwWDZD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120433; c=relaxed/simple;
	bh=z5aTq/b4M0UfRIna7S0Nhil0NVF8yO2tdo+MZwdKbY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjKJ8a3hQYgaAd1uVAsaxlCt/tZhKJkCCWdk7zex9OCrbNzy/vwEzLkcR/C9d2X9+Bih8509mOGQlAoMQHqptj2mhZPkaK2ZWLV6g45MQoeHbkSpflWzdaWwjwIaXByUiWxCG8uxvvOvPOXbEIduDdqYhY9zCX1ygbb3Fveoygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PTbanoCv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso5834891a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761120430; x=1761725230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVye5zs+1UdFAhZPVYZSif7IzMdgoQT4jHpA3BFx5Og=;
        b=PTbanoCvl05zGhT0wiwxMdzIo4efsVAvfpxl/lb7VQS72T1h2yNkRsRQOm+kNyc/n8
         7u+W0aJBnhFQCbxJSd0C5Vu9YNz/dtWiQaR3n7sS5ZBEQIEnSDu4msBtuzifeRwkdkpi
         nGa1+VgZO0JazAexpvuITIQATt5/ApdHVIMLflX/W1b/8eU3TMR8i1Hel0pfIaNGyWZa
         /6MDLRtCk2N+PzFFCV/0vxibmmfgXGllFXeG4TttwcobNmnXwBWcFfCTspmZMEAF5qK3
         LlxBUmSqJ4L2Inm1H+QtwMSms1jYxL3dIlJafVJxATlPVSi4Ob/sV2zNxCurtJXxVg8p
         Svbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120430; x=1761725230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVye5zs+1UdFAhZPVYZSif7IzMdgoQT4jHpA3BFx5Og=;
        b=HdthHjlBVH2EkQJyx63LJcqZ9LQGU+4NeZ7CNUvuTXF4hTwaX0ARR42Kcfi0LbzH1i
         vTe5Z3w4bSf8ymVjJcNBJbSVrIy1uik/omiYl211S3N/2Qiu75GdvNd0ZTY7nyTwChtI
         gBQVH6FkdScaz6xgQZi+3k72DgTE0VV3ZfNuOrCsqOtB2S5ImfQK07NE9GgB7RTc0s4v
         09ju6EmwdK3XMGsSYRsTbSrhcDoK/lQnu68CXhf/JZqhvMF0VW3KvdrZrFL/DuDu9VXv
         o3Z/AXoweIcoH+EnXfuuiZRfoz0hfVd61IUVTbkrpQ7NcXeyhgWWnhlxKJxG3XmjaGB/
         KEyw==
X-Forwarded-Encrypted: i=1; AJvYcCUEGANXhnc2vzRraz82SIr+P6MFejTjo6jO5CQQsotJeCx2DTUzvS9jucjmVvMwEwkjyWFJgnQPDgRBkI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHW9hzPdVJ3gDxamrxHFbCypQ9uP2UWAw7huktfQPaEq2JG3Y
	vKX9ir6JbfWsKcVGvSp9B76tQAGiefvCGpR+Hlhkm2YiayJ0GPZ7F3ZnLxEgjAwtI3wmgm5JBMP
	WpJy9
X-Gm-Gg: ASbGncv2ZcBy0u2eM1bx6Y6/bFbxoXohkIo66de4Z0e4YODw/T3Nj6a1asgLS/9vC0U
	nAaSdl7prg9teZAwDPKDj0xRlypQAM0BZnQ8+l51GPnFAwqrzcCg34xSuCiqVyQPZK8xfIqBH6m
	EbyeSZtxURGvxEO16oz3zruaIbBv5itzwot7/n9fzLG0WZra8OY2hkBGa3gocUt4tQR9sTIqzyZ
	Xr+p+NYWrh6AP6CdoTJIBSFTcY3geI3XVRFLiEHQaDFeTvKiphobItZYcChxo6ntItBYfYrd2l3
	AEKVe8pYDf9MYfF4eeq/DOae0R2whq6gLSIUJq/lr2SU3e26iVP20sIT76vWG3834AuE+FjKJTI
	+a6RyV9TaC7V1bLNBUqk3YXQyBSDLoCMUPvF4x4CqnG/ErT9mbe8cyPReK2sksqqCHxUknLwM5Q
	nRoF602R8Y7+v8TG+7FT7bf/5UzEawYbPoBJqqxoarh1rzhMKJWQ==
X-Google-Smtp-Source: AGHT+IG3hlOFcvWSP4lTtCTDORWoLEgNinA/eeF0Qje86Kf288ToBctAHsrKUmoZDuTIkRc+/1gxxw==
X-Received: by 2002:a17:90b:3e43:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-33bcf85ada9mr22062706a91.1.1761120430178;
        Wed, 22 Oct 2025 01:07:10 -0700 (PDT)
Received: from localhost ([2405:201:c438:503a:cad2:498b:1c6f:5102])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm12146711a12.10.2025.10.22.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:07:09 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: tip-bot2@linutronix.de
Cc: arthur.marsh@internode.on.net,
	jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: re: tools build: Fix fixdep dependencies
Date: Wed, 22 Oct 2025 13:37:05 +0530
Message-ID: <20251022080705.38771-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176060840507.709179.15363439615733763867.tip-bot2@tip-bot2>
References: <176060840507.709179.15363439615733763867.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 18, 2025 at 07:12:02AM +0200, Thorsten Leemhuis wrote:
>>On 10/16/25 11:53, tip-bot2 for Josh Poimboeuf wrote:
>>>>The following commit has been merged into the objtool/core branch of tip:
>>>>
>>>>Commit-ID:     a808a2b35f66658e6c49dc98b55a33fa1079fe72
>>>>Gitweb:        https://git.kernel.org/tip/a808a2b35f66658e6c49dc98b55a33fa1079fe72
>>>>Author:        Josh Poimboeuf <jpoimboe@kernel.org>
>>>>AuthorDate:    Sun, 02 Mar 2025 17:01:42 -08:00
>>>>Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
>>>>CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00
>>>>
>>>>tools build: Fix fixdep dependencies
>>>>
>>>>The tools version of fixdep has broken dependencies.  It doesn't get
>>>>rebuilt if the host compiler or headers change.
>>
>>My daily -next rebuilds based on the Fedora rawhide srpm failed due to
>>this patch while building perf:
>>
>>make[4]: *** No rule to make target '/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/perf/libsubcmd/fixdep'.  Stop.
>>make[3]: *** [/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/build/Makefile.include:15: fixdep] Error 2
>>make[2]: *** [Makefile.perf:981: /builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/perf/libsubcmd/libsubcmd.a] Error 2
>>make[2]: *** Waiting for unfinished jobs....
>>
>>Full log: https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/09700031-next-next-all/builder-live.log.gz
>>
>>Happened on ppc64 and s390x, too (and likely on x86_64, too, but that
>>failed earlier during the build due to an unrelated problem).
>>
>>Reverting this change fixed the problem.

The LKFT also found these perf build regressions on the Linux next-20251017.

Build regressions:  No rule to make target 'build/libsubcmd/fixdep'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error
 CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libperf/core.o
make[4]: *** No rule to make target '/home/tuxbuild/.cache/tuxmake/builds/1/build/libsubcmd/fixdep'.  Stop.
make[3]: *** [/builds/linux/tools/build/Makefile.include:15: fixdep] Error 2
make[2]: *** [Makefile.perf:981: /home/tuxbuild/.cache/tuxmake/builds/1/build/libsubcmd/libsubcmd.a] Error 2

> Thanks, I will post a fix for this shortly.

When you have fix ready please CC LKFT, I am happy to test.
 lkft-triage@lists.linaro.org
 naresh.kamboju@linaro.org

-- 
Josh


