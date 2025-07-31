Return-Path: <linux-kernel+bounces-752470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE4B175F3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5115D587BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6113D22F774;
	Thu, 31 Jul 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RPkMRlFJ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C91DF25C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984910; cv=none; b=CV3OMANwuS2v+CdvpgNmuh2JnKLHK4L11f6YD3mNhNTGs101pRmfFBgdvs7bwKYtKiMJ7r9fpIsCHoXlr4SAtHYJR66aO9q/4xF/+IiXd+uf2pTY3wNsYATb3bcjrrmDLv5AQO383MXaPWrYlr1NxnqlrL8w34MFbg3TKHEKKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984910; c=relaxed/simple;
	bh=fFn7nQn1Gh+6FAS8gvppiYFutYNcjMdggP0jz5pM/k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/g+Nv9RYWFtm2jFNRCPCaT9fAMUC7mYO6uSzpioXt2tlZTD5JmlZJ22JgVWWYHsaHUi3UlUMSIfAqgU664QY8wJz9XsOCmK+ezSQzNyXb9Y+Mla6xbptSEKzeqfI1JlIJJT/mvkBh0KIvYjhJ6haHz9KHJs0xFwmglq2wKUMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RPkMRlFJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af910372ab3so274532266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753984906; x=1754589706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBdevn9NOXbIq7sAbU9V62KbXTYr+p1IlAZvGXkRgm4=;
        b=RPkMRlFJ9AHAaZn+CDsMwCwIpGYUx1SDJVCl/upbVOwVQ/iLAMcfAS2M8rVokOZ+ZA
         PPRSPAHyolDcburCuDfKuqEUUXqJyimLyN+fJpTOfdPFRovW1vESCwj1BK8QTivPKtg3
         muTTl9LF2iw/t9YGTp3Ok4a2j2m6Hp9TC1OYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753984906; x=1754589706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBdevn9NOXbIq7sAbU9V62KbXTYr+p1IlAZvGXkRgm4=;
        b=Hova4kGLerJgzZLcquxBMZLbz3rKJAmagF/ioHksMh5MYPCRhNE4D4zKIpP078ISBJ
         kYX4Zpt6dlVSmN7Gm28goS+CmUHp2w8aZDwDnBqDOsieJlmxSX5q6awbnyBRL+2+4CrU
         z0662v1b/T7kgfbWFJiremJOZrIGIRQ6hp3xe+s0wqSC+EcJBaycM5d3fuV/uSvx0wJp
         jDxNk4F/1zpfZbk7Zjz3r6AFwOJloThskEHgXT1nVNOyJjCd0vv8Xn9jR+0zov5bI3lp
         f1LJMZhgXIGK/0PGMNOEn5EKNwXVgMmdsHKZE0mhQnp4pErgRuBMGrZbtrNPh9uL2SK4
         hztw==
X-Forwarded-Encrypted: i=1; AJvYcCUtmMGuo6lG1ui8tyw2/qvdiIsL6TzBtUINJBCulb76yTfNwaG6ATl1S08BaN2uOKepIKIJZlm1jCaXVLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2IEAZckV7U+4A99YdyEcO6Otk/dhvDkZ9eVt6BYMhnWvbfyi
	cYZJjR+rlMl4/GWhTseDH92ZAyGDYguSzvVJX5fQflvGjx9C9AFWI+FqxssGyRnS5y9T+TwNdSk
	hXpYfnzw=
X-Gm-Gg: ASbGnctCSzDtVlMl03H3uGNU2KygbriLpxqTadVBuNbWA37Dn40v1c4FuI51DZPr6Gn
	U6XtLF8d/zPtqAxsv3VKkaEyutKP8X+7FE9OIaEckCPtHUOAePoOWoC0G7NFTqr19lqjKs+2ii5
	WBX8rXJ00zIBC7gvJYiDXy9QZ0jkuBZdMvG9rR641jiv0pU7wWcWOkHTpa8Zc5/8MZ6f51cYN1V
	KMrYBPWunV7n+BJm6I7m8S0DfOdYX7axwi6kS9vYJkykcIfQzeJfeu0OjuIsNthXanwp8ysfJAt
	jBvb3fHjMz3wNiebk5SpScuSVNWTk0h/SynSBbFaM9s5Rsmd48xeaymdED9Sf5iPxiEMLbl+q8n
	wpEz7MS4CTiR6CwGzCzzdqQfpHkzSuLoKuhQuL4frXAMG7NHBXiVJKRiEGCUTW5bcQVxcQV+bnv
	2DOx6yMto=
X-Google-Smtp-Source: AGHT+IFQaVjv8bj5HU+LmPooqoMccLqE9ezjLdXf26rF7j7/evF0yacz7ruWfpyOjzQw3zS1Z0e5OA==
X-Received: by 2002:a17:907:7f26:b0:af2:5687:c088 with SMTP id a640c23a62f3a-af91bd8f54amr342789866b.14.1753984905914;
        Thu, 31 Jul 2025 11:01:45 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e833dsm147746966b.64.2025.07.31.11.01.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 11:01:44 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af915e625a8so177227566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:01:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnazhoJ9Zhgh7ZMgglNgJ3GDQrKDw6OKwFQlNDlDh6he/ziVR8m4SKbE+jkW3asKo5Lv/gG+MfHIyTFxM=@vger.kernel.org
X-Received: by 2002:a17:907:2da2:b0:ae3:6dc7:1ac3 with SMTP id
 a640c23a62f3a-af91beb8135mr381488666b.15.1753984904167; Thu, 31 Jul 2025
 11:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
 <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
 <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
 <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
 <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com>
 <CAHk-=wgEGn0azq0n5BfWg4ZStrZYanLCX1a+quug7HKmjimhpw@mail.gmail.com> <CADnq5_NBM1Kso==+N=1xCjF+xiS7Vy4g47uvUN7sSWs8bontZQ@mail.gmail.com>
In-Reply-To: <CADnq5_NBM1Kso==+N=1xCjF+xiS7Vy4g47uvUN7sSWs8bontZQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Jul 2025 11:01:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiN+0FBwxwj1UiKsfHgW=C_aWy20F6PPt5M_ACnfukehQ@mail.gmail.com>
X-Gm-Features: Ac12FXwl7rfbBqibQ1OmSqpipidlA-BS-3rGgWDujbCXe9i_iXdTe6-DKoidTfo
Message-ID: <CAHk-=wiN+0FBwxwj1UiKsfHgW=C_aWy20F6PPt5M_ACnfukehQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Dillon Varone <dillon.varone@amd.com>, 
	Ivan Lipski <ivan.lipski@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 06:09, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> I think it may be fixed here:
> https://patchwork.freedesktop.org/patch/663973/

Yes, this patch fixes the problem for me.

I don't know if it's due to the pointer validation (ie this part):

-       if (!dsc)
+       if (!dsc || !dsc->ctx || !dsc->ctx->dc ||
dsc->ctx->dc->debug.disable_dsc)
                return;

or whether it's the divide-by-zero that the commit talks about.

Should I just apply this directly, or expect a pull request in the
next day or two?

          Linus

