Return-Path: <linux-kernel+bounces-852599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4408BD96D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A8C3501A20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB92313E20;
	Tue, 14 Oct 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GyyEVF0D"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA7313555
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445827; cv=none; b=EVPkfIq9ww0GLz0WwlXaD+S5DbTsYiYq2yUHGodfBw20mNCnAVEyblMawmGyJFH8D6U2yDcD1nSDpUSiJlZX5hBU5FfOaV0iiAChkzJGpdZdITBunYbzvA453g6Y177wqoO22jj3GHTqiDuc4yoNxJtZFJEG9WJYa0FuHxzXFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445827; c=relaxed/simple;
	bh=NCSyvzFqsRWIwdb2ZFV3sGd2UxItcJXGY/fYHe854rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkO6bhI1WYq6LSOM99mkMBAJZkNvaixnTOgYNZHoGuIUpMZVhZ5eunmpeQavRCxGsuvy/TV9/XMumix/zdRWD5jYMFIZKAzJlw1IOw09bb0Hnqv2kqQChiSSJVZExOhrwN5Ynb+hIhNenfafAnysacLF3+GpTM9/i/qovcR9hOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GyyEVF0D; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78e4056623fso70186746d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760445824; x=1761050624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zg5nDf1lU2Lu0yIBtEqem77SfqDoSZE4X/mwOikYVIk=;
        b=GyyEVF0DDTTdvwCVv2ibU3JOhpQM/aJZbAPC3UiWsSZxWYmRDXy51XwioW0slwzJhm
         nLRpOx1V8gDtZV7aBIZA57VWemRU4u0m7WRQlQNHQd3BZZAG+rk8EDrW47t/sdhyANQZ
         yviC40kJVb0oIusyexg+OlEYJ+M7FDOlfGYe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445824; x=1761050624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zg5nDf1lU2Lu0yIBtEqem77SfqDoSZE4X/mwOikYVIk=;
        b=dMDHDdPtUrjiS6onhAQP557uh0sQGHhW05EJgfotiZA2SkwVMafw1PxowKaDblu86k
         QoKLe0BoZotJFtRzJLBn8Pe/kNkJVwye0ieuwFrMAzfWhhcHOFvot+qwmI7vb6lA9ziw
         k8NKq22XUnru61EM9ZZCS3/AwUlYfYJtEG5NzMP9ajOM3md2PiGcvKunz8AQzbP8sogj
         tndLF3CuqL9UTUiOh1BRjpgf3nlwpLxYTwdQ+iOXkIDrm9VR78hjAmmjJVuCuOS1u2WX
         v4+o7tDCLBa+JurPwSXTcnAHkB28MfRTjMdzUSrq115pkMhHCPD28h+8NPS0XkPbxGYL
         vy1g==
X-Forwarded-Encrypted: i=1; AJvYcCXREndcEHP8Gx6sF72goUkjDaGIJiSUZ44mEMN6U+AgCZ8/JBjTuvZ8ylXhDy6rIBIv09XQuFb6frZBu8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFXF66OrVQfeSyVa7ntxpcw3eenhu8+Zm1D8hkh6aQHtUu37U
	4fu8Qc7nGFNktPeBVg/32rNNXbLO43wgfyibZETWzjC6FGFgvKgl61q1GUZP96ATVwDg6pFlmwG
	V7U1nTJkVo1nAEmPPODuSc4SgwD1wRPBMCBfbNkWAxSkleBfoUXcu
X-Gm-Gg: ASbGncvyQ5It07r1tAcEPhiPrxnWiWRCmL+PHH4yv9cO+outZJ4b+KJ/SF7EyzR/B8W
	RUc5lXzETAcviDKcclwjHvrGQNE+iycfjnvX2qfVwdXurINbaLQmLAwR0AqeDg3QLwBzZHJosAt
	tEbEvL3H187Sdh/IjCOfqaNs2F5Qwzag/pWfz/qMQVDAd1vwdupm+FiQv1SKZAZoqS+rW/rBwrx
	/TEZuBCee4aMbgat0/DlHhESYqbvC6ivlEx9L1oBeyGI0KPreY62seEMF1CLEN5xmtUVQ==
X-Google-Smtp-Source: AGHT+IFotZagUXmwunsrc6F0qIh8XxOAKfcZN39gGs0upydesG0aZnr0ML2n9PTQ8qPprd/tdeaQBA7Ie3ng4BHYjF8=
X-Received: by 2002:a05:622a:1e87:b0:4b5:e8c2:78d2 with SMTP id
 d75a77b69052e-4e6ead56981mr319904511cf.62.1760445824246; Tue, 14 Oct 2025
 05:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
In-Reply-To: <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 14:43:33 +0200
X-Gm-Features: AS18NWBEZq5lIkJh6Ip5P4ktSAZRhNTSUeKj8YqirfcTTiqThkysrWbf-5HPY1w
Message-ID: <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 09:48, Miklos Szeredi <miklos@szeredi.hu> wrote:

> Maybe the solution is to change the write-through to regular cached
> write + fsync range?  That could even be a complexity reduction.

While this would be nice, it's impossible to guarantee requests being
initiated in the context of the original write(2), which means that
the information about which open file it originated from might be
lost.   This could result in regressions, so I don't think we should
risk it.

Will try the idea of marking folios writeback for the duration of the write.

Thanks,
Miklos

