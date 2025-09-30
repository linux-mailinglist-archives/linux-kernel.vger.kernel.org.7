Return-Path: <linux-kernel+bounces-837046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16955BAB28B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC5216D841
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294AB23313E;
	Tue, 30 Sep 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYbkka0U"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568B1E1A17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203128; cv=none; b=ugf1LNUGbkLNgmSx9HAC54U6l7Uje8pUkWFxMMRJIWYCFeYCwjX2S7jAaxHCfUFzhOFgdTCaPQDKxPt0W/V8zPeSo+5EU65xsuhoElLlE681Je2iic+oncvyMQhSXCUmtHb65yMYhrkypOW0MzLmhZTVRKtprIx3XKCFGi/zQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203128; c=relaxed/simple;
	bh=Y+lQgfVtEaVz7kZQiydB7t0gpe+2jiEEcUOe7R2jlA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juHbnfgTZmKt6mHssKiBJX+jRzLsXjl3JNVvfaDUgZ7GeooM5JI7UeSsNgWQ4u7m5AO8Ei0n4k4ZYif72HhPh6fOj24jMdIs8GAWwmXECPg6N6UGt9Ewh3HMLKzIfI7P/5EuzrJjDDFqT9EQ6JstaPVWgStQRI+FgKioOqMC1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYbkka0U; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781010ff051so3733664b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759203126; x=1759807926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipg2xSQ+y9eG+cY+ycWtarKVzuOf0KH86wwLmftXUAk=;
        b=TYbkka0UOXhpDbUmwAwR4fT69omLNHcYhshOIVdIyWzej8p7IoHNM5I9u5deo3vw9v
         18gKXoOFH37JIXSSOuNVzZve3092htk/s2qnw/YjReD4IHKML7LTwZX4BMrKK49Je/vi
         UC8tyTGiD4T1H8vkt0xaLcukFfZhWth1oWYHyi1s/DozsmIMDmdhwUCRIwKE33k3bxZH
         QMQ9KTT4JjPzPxe/+CjNcNNBezJ5R8b9ankxokyGwS7nxraF5Wgg7grcoKe70h1Sg8M9
         ERvvvWY9fDMnqDOZs/XdWxU3u39IcxZwAOJah7Ox9+JnpY+cXG1iH5D2PsCaU0EvnqLc
         rqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759203126; x=1759807926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ipg2xSQ+y9eG+cY+ycWtarKVzuOf0KH86wwLmftXUAk=;
        b=jSS1uMh7+8VR4rHYAtNd/zalZ7s3O24sF3wGRXchf01C4Y7pJoVqXDDltLdH8js7LZ
         RjTVlvw6lm9duH4am44ZtS5WthvLtzUVFHQTM/d82nWwyczNQXB8Ic+0/7I8JWGmPOE4
         k5JgDgHbsvo3buay1t4iP24UL169R5SGDmKpGp600NQTmPnS1VzhADD7e1EaW0Fdte+z
         BqaXIAwiWOaK275L6YpQ4hOjHuqshx4/lDM4mV3usFszsAAwprclQmUJoNC6M+Yrjeeb
         22/tWX22H17r+1ZhefXLeif/4ox4VmiVZ+hays6NMu0L2APAC4lk1e2fvKiZkZRDw9lT
         1gWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDRfftgdkcvuJruZPdFlSYGw5ivH9t204l1ZFMihzjCqSIaRru3TnafHKawevV2W/dQ/kbNQGk5JVqddY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyus/Owq9T2mlSchQZAfdur8gc8QecA1+FlKYBUVU0to8+kZB/
	B1aBfkki97womAF/lrbRwk9UDaQTaoIL5oVVj54a+muSaN+Z+Nbo5QJh
X-Gm-Gg: ASbGncsrf0amkBMwwVfY8Qb8BcWczN8Q6zP1ntD3wabg3w1ByDi00VuVwP5qmPddsTK
	UMaXYeij8ektlftPtRWg24C6u8jkAbrK0ppGNU54OmI72LjZXhtG6nC9sVlXfYJbI1kkUdmRAk4
	s5IGug3zo2tX+c/ZmCh1bMfvqSS9cr5y2JcUO1tR13s+2T73CUsVbhmaK+mbZm8i0EjWDTjVFEI
	64gATHnsiVb0a2P7U/3RAveSpU/7izra9oi9lEhSofWeRY/PEfbxKr8UvRkxWn8hjBbVEf3eE2T
	QpGQ6WMUiITWmAvhfksb8gPu7yV/rIQtSRgi80Uw7UuC4bcc6DG6V0rgynNN7hnktMM+YcCiCXX
	5loR8qQA6THttB0rAunWTR4EGhQghk9ZnTVpkSB4jvjEktXEoC85ALoiRT4bFtCQpSae8C/k3G1
	+17Kc=
X-Google-Smtp-Source: AGHT+IH6LhWbk9ue158EeoJf03eqT7m8bYm+d7vM0ErLdQPaLK8hlGYtsJv7ZK2fU0mzhBBLUHqIUg==
X-Received: by 2002:a05:6a00:b53:b0:77d:6a00:1cd1 with SMTP id d2e1a72fcca58-780fce27f29mr20086588b3a.12.1759203125932;
        Mon, 29 Sep 2025 20:32:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:7cd:1d59:4483:ece3:c019:40f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23634sm12557741b3a.66.2025.09.29.20.32.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 20:32:05 -0700 (PDT)
From: lianux <lianux.mm@gmail.com>
X-Google-Original-From: lianux <lianux@lianux.local>
To: sj@kernel.org
Cc: david.hunter.linux@gmail.com,
	hannes@cmpxchg.org,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nphamcs@gmail.com,
	shuah@kernel.org,
	sidharthseela@gmail.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under label
Date: Tue, 30 Sep 2025 11:31:11 +0800
Message-ID: <20250930033111.63465-1-lianux@lianux.local>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929172724.75108-1-sj@kernel.org>
References: <20250929172724.75108-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: wang lian <lianux.mm@gmail.com>

Reviewed-by: wang lian <lianux.mm@gmail.com>

> Fix warning caused from declaration under a case label. The proper way
> is to declare variable at the beginning of the function. The warning
> came from running clang using LLVM=1; and is as follows:
> --
> -test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>   260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>       |
> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

Best regards,
wang lian

