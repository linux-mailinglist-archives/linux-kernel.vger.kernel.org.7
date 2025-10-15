Return-Path: <linux-kernel+bounces-854753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD5BDF4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BDA189B183
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6676258CCC;
	Wed, 15 Oct 2025 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG9AP6KV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AA2F5A01
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541458; cv=none; b=q9jQFDH6e1QBEHClwkef8Xwv1qRv3yAwGdqsU73GpWDpDSGQ83yh3WO6iHY687z/lqYUXtZhOPX2h/w/pfyDCLJS12dFJ4nfXm0ykoYrmyxWL4osNMMSZunC23PmdWeiimKUT1uVgaVwexSVQaWnyLCb1CNn6Ii9FHKF9UbbiLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541458; c=relaxed/simple;
	bh=mtUS9WGjUwEXnaRyTThsRQOBT34zHvfK0KKXPaNYlA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VX2b0myg5WyvZWkQy1323hzG2e7T4HscPp/IZAyVuR+qv16a/pdQ2sXW/Iy9Yr8YEXoql7pQK0WrukAxQ354yopRvQodym/87GUy923/3MPQ/ZQDQrbybzageFafvTlYRH+octTHnp3pCQL2AaRTDZ2NAAx/f3JdqirXZTPZpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG9AP6KV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so42961225e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760541454; x=1761146254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtUS9WGjUwEXnaRyTThsRQOBT34zHvfK0KKXPaNYlA8=;
        b=eG9AP6KVy0wVxX184lOrwdDgFoCkFjI7s40bO7qgBa/pkS7OifkpfvA9uJFw/mIbS/
         uHS0NbwR+Dxk10eDGpO1r+LEfwN4+6ZNswgRpIKrPHfiKWl7ZAObUXSsb1Lcf/mnMXvG
         f2ZI/uI9yw35tu22dmaNhGbEi4t+VOUH8vSsWZ38rVcGgWujP+D60wIxb/9K0VlguOjI
         pGSHPTMD369eGJYJnrlEySw0wCcZENOBqrkIMSwvKi1BPsDi4HYpZUEkIVm8QHvjBe1W
         thVnBN5NlRmHtY7uh1gHyGPieS21130Qo9OUOGf0tLVfrxGte1Jyw7B562Yna98alIu/
         zKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541454; x=1761146254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtUS9WGjUwEXnaRyTThsRQOBT34zHvfK0KKXPaNYlA8=;
        b=E1p+sJvROgq3VXGmp+TTpPJk8Tjkhp8R/c/aBpF4fYO+62lSs+fN0FWM1plnMBMZcP
         uAfDaBmCO0GNjmolVAgl3kHKz1cRgghec+CKmb/e1rfrq0qXDLtRjuC6mRwZliUvfSyq
         p1uF5yqqbtj//aHaRtA7e1ercz77ZvGrrcTmB+onoaLOOXyZfPVfktZgSkJFaZkyyZPQ
         5hrznbDMzsU53h9QGIDJZ5bhxGrJfFshjBTfGa4KuHvzOTTlUKUWOBUIE5v5w3+buey3
         eNnSOeoCIS6WVdiz3CQ2Xmmz09Fm6taQioeV0ptfKwRznEdC9FFSZTr30zZZIB3yJ8L/
         QfEw==
X-Forwarded-Encrypted: i=1; AJvYcCWOh5PKcu+SNL4LxeJp8ePYClZ6K586yRVbj8eejZKOqBAxJ7TSBmZc5nlrm5phUlPNtEeVGjS3W7xiMqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdDIC0plmp3Pxjyp2ouW0aEkDENHfQUsRk8u09+sKjPSkHpHY
	rP5fU54Gw7hye31jDz6JHjdlhJGa8rwOBwnBUpCwsVo7HqiUqGv2/8GU
X-Gm-Gg: ASbGncvY7MzZeRmoWKj0hbLNAiWYWpPRHNJra1+na3MwVTF3YFPL9xjLLdO1inxFWL2
	bvOsCCV8NmtvCt+4s+82FJ2Yt3he+DytWTocSf4O3LN5rdkvUFDUxSQ5azjMdlYTCKoXfjFvvck
	7ilT97bfmaMae0dMcoDTyNYWgGLUVAQKeny15u8i7bxUULOAstKSqotU9y6pOEPR7nUnevIItUZ
	UBRHsMiQEX2avqF1UtGf/KpBUlJf21pupVaeYEwcOh1VWt9UAYxfFRsdeBxQvJGVgVLu9w20Nej
	FHsQjLhUUaj+tPxDjvOkrv5ZzH/wohBNy3XOtuQy5DCNmO2qfsdHasEBOPeM5RhGLlDyhKLef3q
	aBK0pkieU+TXfyluyHyXUovQ7TUMZbpJg5sShwyloADwkYkeP0JjB0dGw7MK8FA==
X-Google-Smtp-Source: AGHT+IF+wQ0w6icankgioapxTjYaSjA4++U1svpm0hH8LF2fSddRaHuF8XP0NW/LOO9XQwCj/mpkRg==
X-Received: by 2002:a05:600c:529a:b0:46e:3e25:1626 with SMTP id 5b1f17b1804b1-46fa9aefe15mr215181675e9.19.1760541453862;
        Wed, 15 Oct 2025 08:17:33 -0700 (PDT)
Received: from yuri-laptop.unina.it ([143.225.7.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483c7e0sm301897505e9.7.2025.10.15.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:17:33 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: juri.lelli@redhat.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org,
	luca.abeni@santannapisa.it,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yuri.andriaccio@santannapisa.it
Subject: Re: [RFC PATCH v3 00/24] Hierarchical Constant Bandwidth Server
Date: Wed, 15 Oct 2025 17:17:31 +0200
Message-ID: <20251015151731.31191-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aO-xNBHYIyu74aQF@jlelli-thinkpadt14gen4.remote.csb>
References: <aO-xNBHYIyu74aQF@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> I provided comments up to the last part of the series that implements
> migration. I will now stop on purpose and wait for replies/new versions of the
> patches I reviewed. I believe we could try to leave migration "for later"
> while we solidify the basics. What do you think?

Thanks a lot for your comments. It also makes sense to us to solidify the basics
before going on to the migration code and later updates. We have sent the
migration related patches just to show the end goal of this patchset and give
some intuition of possible use cases and demonstration on the provided
guarantees. We will work on your comments and submit a v4 patchset soon.

Have a nice day,
Yuri

