Return-Path: <linux-kernel+bounces-757193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2725B1BEED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 04:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FF618A3C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571931D86FF;
	Wed,  6 Aug 2025 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ia5yhXqX"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935B1A7253
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449136; cv=none; b=SRpxk24RppTGJ3A03r2mmwnFxtanCEG4U8ErHxj3U4CftRPRVGPsNolz3M712K9W62ciNJsOLFRoLgLiGk35+1X1LEAwfb3CuMhaFi3y5CIXmXdZAQLGUDOthW/6kqmDOU8p3vYtvkjc6U5nAkgoD05LKzdMIWKvSq6I/FPnRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449136; c=relaxed/simple;
	bh=t96KIHl3o8o/01DWmztfbOb1bGxRH3j7rU9fQFrfzFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIq6O2PuUM3ttAbpISUfGHooxN1s6WnrAlj+uPYsyNI7SGwLgGtnqjUS3wRXaasBPhljrgxHeLMMWYP05Bgq1rRaYWfy2wXAATfZ83gv99LEGyt9pP4g/7XiqJr5VgC8+UnzX542AMOtQL2j7LXoZu6md8oLbfGH5A11bFm/yZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ia5yhXqX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-321461ab4efso2064091a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 19:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754449134; x=1755053934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dfI2/EUStwEeHLBjx/Qw57TggouFa/RBsyWtj84i+Do=;
        b=Ia5yhXqXKkNBxN+obQcORUNAkXjiYFV1Fq5qfF8G+dEht6MjEx13Wrok18m1ihpzwD
         gbUxaOjWcKQ/UoGBTaIO1ft6yWriOHGHIvoZ2J2zcKhB8JUvHDpdfse0QB2zhmY8bUax
         aMGAtOYFLFstM1E6/GzR8WlHlb9wHwxVmOouI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754449134; x=1755053934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfI2/EUStwEeHLBjx/Qw57TggouFa/RBsyWtj84i+Do=;
        b=jfjauE57k/c5adx2CgIF4gTQavcOTJoi8+krYwrr4ucHZcFH0Y423kfEJHoEFLIlLg
         5l7sQ5zTl4Fmvpz7BksHzMziuu7E2Kx/dP5aokXZrYN/Gz587g2kQzu3z+Cp17KZ7Wt4
         4tSlbojZP2EmLd7Nvrk+srFgJsAnGBQMik12Px4XzWaLQYDbqRodHYIkc/tGF00HCM27
         JSAO14SSzlgSRkKgCyXwYQzsPqvtOZHh+EIBTqWbrtlQ3t736hl8+pmNtSqv/lLjdLG4
         375S6z8d2DayaksXv2GfTXiVO0k5EHJTDK/k6VzOmkZ0xN+1mdOr7oX7G0qIsDt5NGT6
         6J3A==
X-Forwarded-Encrypted: i=1; AJvYcCVF4cvKhsoT3BbyH8K552fG+MRaytsPB9fODYZJJbuf/SIXZqIwpdpgNBJPXIY10Wx/1YDN7J73zGkcuYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZcM5zVFF3t/01esvQtLvMzBQpy/RhRE736QlAPPVBuxA9L5/
	yKPXUVRJK5liEZViR5zdicClOZ4kB96JCMeHPK6DdtgH2WuYK1a+O1OvxUpgZp2fMg==
X-Gm-Gg: ASbGncvxNfGGsIWut0VXx4qHG7OklE2SJZaWBPiZ6Dw8ZwAtdccaKVcw+hvLEWbZwk8
	UUimtO2e6tqmiK7EyEVtdIyb2Clw0Xwdw0Rgkatxx+JAPUiSOpDvsM+bKzqoZ8arAmI8f+p7v59
	buVbjkvvDBAfMCCQfY0ChpwwsxwvkxNVwZnftrZ/L3zhqhZnojZssKOW8oG0bKEYJWPAyE1Sb0g
	dUKGE4P1INMnHjGW7rG1Z73Lm3qvt0l71v2eqq/dMf1wa3TIr+eLQbqHRzd4tR2f4hnnmDII0l5
	Ri6S7r0k6bhAwGy4JfButrThkeDo1bWbzgDW4OSHzNWXq3xpRHq8WYPMyX31gkc+EqXHoPktiuk
	sIlBxenlHY8WZL5P01B/Cntw=
X-Google-Smtp-Source: AGHT+IGw0u3Yt/rwI0EXQXBc2LWgvbdwvZIG23v14ikG4dlkYmTsPpd8+RNDzIsBOgy5fSED1HkM5Q==
X-Received: by 2002:a17:90b:2e51:b0:31f:6d6b:b453 with SMTP id 98e67ed59e1d1-32166cfc84amr1545302a91.30.1754449134450;
        Tue, 05 Aug 2025 19:58:54 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216129c8cfsm1438665a91.34.2025.08.05.19.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 19:58:54 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:58:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Seyediman Seyedarab <imandevel@gmail.com>
Subject: Re: [PATCH] zram: protect recomp_algorithm_show() with ->init_lock
Message-ID: <fm5et2vgfl5npfmivdpwj7lb5ztrgmvst4kbvxccisdnudyhhx@5szzuwprhmgw>
References: <20250805101946.1774112-1-senozhatsky@chromium.org>
 <20250805150323.0f5615ec97de2cc5d50b0b6f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805150323.0f5615ec97de2cc5d50b0b6f@linux-foundation.org>

On (25/08/05 15:03), Andrew Morton wrote:
> On Tue,  5 Aug 2025 19:19:29 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > sysfs handlers should be called under ->init_lock and are not
> > supposed to unlock it until return, otherwise e.g. a concurrent
> > reset() can occur.  There is one handler that breaks that rule:
> > recomp_algorithm_show().
> > 
> > Move ->init_lock handling outside of __comp_algorithm_show()
> > (also drop it and call zcomp_available_show() directly) so that
> > the entire recomp_algorithm_show() loop is protected by the
> > lock, as opposed to protecting individual iterations.
> 
> As always, I'm wondering "does -stable need this".  But without knowing
> the runtime effects of the bug, I cannot know.
> 
> Providing this info in the changelog would answer this for everyone, please.

Sure, Andrew.

The patch does not need to go to -stable, as it does not fix any
runtime errors (at least I can't think of any).  It makes
recomp_algorithm_show() "atomic" w.r.t. zram reset() (just like
the rest of zram sysfs show() handlers), that's a pretty minor
change.

> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Reported-by: Seyediman Seyedarab <imandevel@gmail.com>
> 
> And including a Closes: for Seyediman's report (if it's publicly
> linkable) would be great too, thanks.
> 
> I'm guessing that a Fixes: isn't appropriate here because the
> bug has been there since day 1.

Yes, also there isn't really a public bug report there, I just noticed
that while looking at some things that Seyediman was looking at.  So I
wanted to give Seyediman some credit.  I suppose I probably should have
added
	Suggested-by: Seyediman Seyedarab <imandevel@gmail.com>

instead.  Should I send a v2?

