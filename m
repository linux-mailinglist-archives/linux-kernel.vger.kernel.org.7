Return-Path: <linux-kernel+bounces-838864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6391FBB04BD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785037A6143
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B623D288;
	Wed,  1 Oct 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UZScML0T"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77B27A91F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320952; cv=none; b=oXUQVHsM7nY62/t1YLJTDd7KPct4U+BteEm+xAdw9fUjQpbUbWRvZMw/fEIHjejndvGX8ldZXkAivZekhOSqiqMsyB0WjSSHcnOkSmuboM5dZc7p5WMFMmI+Tq/fRdm0fCqyw7ycJKGlKJCpANj4TGds6KiHJZQ3reK23vHtkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320952; c=relaxed/simple;
	bh=D4eS0UAXAhRPjmktKVXH1VzAfhMCPB15653jG3rSlEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HHDT+EXuym12wqKW3eLGLx/bmvcNT0u40JJJiIqApP8EyhJY0TnxbUQ3p8KQiy8bJJ8nIUyl//6x12+q8DWPnknL3ZAyCtGQ2q2niwqt5+/DLWZpNScNmkUdXsHnUuk2j9msf2RlWcrLEdRSa9Ee4z3vpINThVJhrQTMDJBCq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UZScML0T; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-917be46c59bso479325239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759320949; x=1759925749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzUgE3TaPel3Uu2CLo+G9h59zbRvmZ3+EiFyRKPP8X0=;
        b=UZScML0TgbME7agL604lXbm0HGVhop7tiNNM02sjGzu9tt+TzyNJJOZa3Zb/m7e7O/
         dS0ddam00NLdERpB1b9yFHraZdOaRiAL2Lzl0Ag8rMRwPq2OTvkQWqONNnhmMjVUQenn
         1pUnR3tQ+Ih1WvAXpN9y/ArrLedro6rtJIkilW05UecEJBcEemnjXCh8T6E1vSsp8P2k
         KrpD2mcMF4IlFWeU7vATy+Ws+9t/29OIhwSxbwQbl2Tfq3EBzb62J6pxmmEXjlvgtV4e
         vkSU30grWwKbBW3bWpC0dY1cHHQ1Obsr2RkqIYnMUqCdHVUaOjCwkikXVl11gU4h2B/U
         7htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320949; x=1759925749;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzUgE3TaPel3Uu2CLo+G9h59zbRvmZ3+EiFyRKPP8X0=;
        b=jwmv/KknJURjh43//H4MKXVloAXv4FuiXbI8lui2OI/IY1fh87f2MweqHHOmsI7XEv
         2Z2B8OqHySEhWqrbyweflJOwXTeARR5PYs5xuQFqLEeY+oGrfFXj4V1aH8AEPm1Ul0F2
         3Dl24Pr2mx4jZkvzc0LEsW7ICAPGzj5+8Y9EqKV4brEmwztDgJcnRdu34P2NWZ0vXZXf
         s8MuYmJiYBZWZinBfsDbL0OXem3UC8UgityJnt/UkQ9Cbtl5cutz8zrzO2SH7LFAyAD3
         DaOuyqrSfKLFCAlYqZV9YbxszLii81uFiiO2XsnQtzbpGcg+nywzMi4inrh0pzLaz9op
         4trg==
X-Gm-Message-State: AOJu0YwYggu6qm6DUQkLdAVabXa3dPKFMQ8BvM9jAa5NS12K7UyANois
	mzeUKC19QH7Aul8pU7Jte3IqpOE1DF/ickQFk7f5bysBqd2fKNAN+5BvUJwCz/Te9O4=
X-Gm-Gg: ASbGnctW0JSaq+KXXKwLF7+w4EjOeF+j/YG1fWTVUA4DqXIcix4LVcNWWcqHFjdEo2f
	X7drGS0s7BMyfME7aBxpN1G4MzFj6OgHNsfXzGjy13fqglK/oIQpyMZLXkDByPhnIcRlkdaE5cP
	5AzMmSy3GN4rxO368HhdsUnZmlGW4s9yCxHacSwO/l88W1Ro5npSEtqVEijA7aobSvq0cyuEVns
	lZVQos17zTWMx0NT5fnRPu7enS4cqzu58M0QqbeLDoRlY5OPXurwJubyvYXhzPplpw+mkm5OpaZ
	63YYMywAmuedWgpbDh7p7NmBkXYpB2uE5VtLWOjFfHzgW5llkC2olTVe/wsIu6fy7/+K4hKXE40
	D9hswM9NkJH6mLLJ3ScGqydiC2xl8HJMcf64j6nQ=
X-Google-Smtp-Source: AGHT+IFL5K6xEjxqKVxGyRG36i8d6MEqFnWhOoZW1S4U1T4IXlDjzCCFfh+I4DePyQIdd0W8grWLkA==
X-Received: by 2002:a05:6e02:1d8e:b0:426:790e:5cfc with SMTP id e9e14a558f8ab-42d815c6315mr52300295ab.13.1759320948876;
        Wed, 01 Oct 2025 05:15:48 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-574656e63fdsm2900937173.48.2025.10.01.05.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:15:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 io-uring Mailing List <io-uring@vger.kernel.org>, 
 Romain Pereira <rpereira@anl.gov>, Pavel Begunkov <asml.silence@gmail.com>, 
 Christian Mazakas <christian.mazakas@gmail.com>
In-Reply-To: <20251001103803.1423513-1-ammarfaizi2@gnuweeb.org>
References: <20251001103803.1423513-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH liburing] github: Test build against the installed
 liburing
Message-Id: <175932094792.1251250.7096571794041153549.b4-ty@kernel.dk>
Date: Wed, 01 Oct 2025 06:15:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-e5369


On Wed, 01 Oct 2025 17:38:03 +0700, Ammar Faizi wrote:
> When adding a new header file, the author might forget to add it to the
> installation path in the Makefile.
> 
> For example, commit 7e565c0116ba ("tests: test the query interface"),
> introduced an include to the query.h file via liburing.h, but the
> query.h file was not added to the installation entry, which resulted
> in the following error:
> 
> [...]

Applied, thanks!

[1/1] github: Test build against the installed liburing
      commit: f22f2fb4341afbe755870b0e7dd1b680dbb5bb8f

Best regards,
-- 
Jens Axboe




