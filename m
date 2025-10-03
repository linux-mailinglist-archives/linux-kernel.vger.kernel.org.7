Return-Path: <linux-kernel+bounces-841704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8846ABB8058
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431B53C854A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEB1E9B0D;
	Fri,  3 Oct 2025 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L2Sy1bdt"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87635EEDE
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521786; cv=none; b=TnLYMrl5j3h2tHX114V8/VC7zKn9VSzPoiJWu1un58hYkIbE1tCjkqi4RkaOvvIjfHWWGUQKm1eCEUIQOKGIEZxpyScDtlC/g7qtCVImQwE651gJC/7emcWWKAhSu1YbfgfOplkFez31wMjE8p6u1ki8FVRdaIccncZxDS6eD0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521786; c=relaxed/simple;
	bh=5GS8MhZ/ppKxfy+fuSZsShvCGZIOsA/58nGUwG4mQ5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rei703q/JOzSu1ysKEkyRcXDcepG/+zaXR8u9lopNXBWEfluA/lCdY9DVx3ZDhYD/OliIbKKDYWAlDSkfhbxb7wvKfbAo5dOXz+mW+z75gFscmldc5zzom/Hbb/GVvG8hw1tx3Yajk+Z66jLZ7z22fP2BBnaIc8724n3uQ4mJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L2Sy1bdt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b256c8ca246so573108966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759521782; x=1760126582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbpBU6Pr6wg0+zanKq2gcbiJR41DcWJOWgfowfisJWk=;
        b=L2Sy1bdtVG23gx68kYnlRtqOKZ8drghk+IrLjXHNggCyVZ7wlhg20/nm1ucvf6H0z6
         A6qYAHNdLXGRsy9iai0V432B9LhvgACGS+DdvV3FxNii95tpLBKRyETw6LlFiQqO/y29
         e8+TCtLgTwtdzVzeGJ5rH7pFpgd59mfVckfsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521782; x=1760126582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbpBU6Pr6wg0+zanKq2gcbiJR41DcWJOWgfowfisJWk=;
        b=gQSiGYGUdiDRh4EVN6/2Tz9NhPgFlacG3og1FYlq/C9FGHuDR7ToHy6bFTs9q4x2x5
         ww60RHTdQyOiH/kLBfVzjRQnktGIriJIth4uB4zCVqbWQ8OkZM6Fpu0Ij6TrhhjkK3jr
         Ky+Amlvjdc/lzJh+JPlkQRPmEvMo/+rxMgIW2fRr1tuvct7oN9LGeDFaER9jz0DiBuMK
         xDtG0bqSWSCYVlRz6ADge+Sc69e0eCErleiG0Sc2mSweJYD1nPeFfFNpb5f4cgfPRkSc
         XY1ZcRFEpQ3p9ZSD8iQlqWA+/umabtXqV/GiUP3HG9CXScGirKhHEXSGNirDVeXBhU1C
         TFbw==
X-Forwarded-Encrypted: i=1; AJvYcCXsJZcQPtd8KqTUN8xWfNk8qXLFityErDUlj/QikW7ge5s0cOlvcZ1Xai4BxsDCsv7MWoFfPFso53hQYtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8OOlv0+nzAUI/s5my+Phnrk5ngLdMXyvPJg1ma8aMfD0B4wJ
	k/q6BPZn2tzG6o1HFknVKgd+r5nMzRHIkZU2m0wXGYtyv34W8tuXs+K+KpwO9a8stQMr6SM2TT/
	sbHSgn+E=
X-Gm-Gg: ASbGncuNnBHxedrfK2e1LTxmRmPRUF6ntr+QD0AQ6toa60FcUMRMlB+dBOyC2fcjGIc
	wMVInyh8T/WAjmin/dzvw3OB63RToyLVxmd0WOR6U4g88xiwovYGDr18UbsmAH58Y2Hc75/JHU9
	DZP7c+whEEElsuWPobI8dar/7B8V2rr+Q3xp2faLaQSy2PRiYD7MjT+nMKefYRm5tF70DGLTuk4
	sEhHxRCtmfjS53MiKEGyFT1msGGgHc+qQedbwlgeatmIoXCaBFwZM3Q8V3CjXeTtGt2rn7zAEzY
	6DzlVSFHfnnj1xjh2xf2LANqafmFwwwS8M6BSwat+9I9sHoz5cOOvxQJvSLU+iZIEHH5HQXy/et
	F9w3mEjoemJJ4wAiQiXKSsgdfV9oM9m7FWFhlRtQYLQXfdyxxmsE9r6+WABlW0xwjk9Q5Bov1D6
	VUbtNqRvruSaVh4HMw6jp/
X-Google-Smtp-Source: AGHT+IGzE6VIWe1O5e1CFBne7/JbAuT3G3feWQUrSbjOMXFH7X8be3tPuIufvRqYLBGG36AWDtly4A==
X-Received: by 2002:a17:906:794b:b0:b40:b54d:e687 with SMTP id a640c23a62f3a-b49c3f7da07mr489351166b.47.1759521781678;
        Fri, 03 Oct 2025 13:03:01 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b56954sm513869466b.75.2025.10.03.13.03.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 13:03:00 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso4818866a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:03:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTaAX1uErvQQBj/T3pAqmiC8CGLpPR95ZssrfgxZlMpx6uRx4YW0QT08mup9solqhz0BssdX9Do6Bkih8=@vger.kernel.org
X-Received: by 2002:a17:907:2685:b0:b45:1063:fb65 with SMTP id
 a640c23a62f3a-b49c3936225mr545475666b.39.1759521780061; Fri, 03 Oct 2025
 13:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
 <CAPM=9txjNo==nMA7XcjzLWLO155+1bk2THwPs_BmTLu_5kU_bQ@mail.gmail.com> <CAHk-=wgR61VxiHyOKXBJv_HinoFVA2av1EuSHg5NcRGC1fNq3w@mail.gmail.com>
In-Reply-To: <CAHk-=wgR61VxiHyOKXBJv_HinoFVA2av1EuSHg5NcRGC1fNq3w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 13:02:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX-2+hH5fM344_wKYNZS5CSf4ispS4X+s5xkma_Mdu_Q@mail.gmail.com>
X-Gm-Features: AS18NWCnq6HDu3oiSAI0ER2urw2inCCpn6nPuTO_WRSrmKvOgbDj_M8nr5oEaqo
Message-ID: <CAHk-=wgX-2+hH5fM344_wKYNZS5CSf4ispS4X+s5xkma_Mdu_Q@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Dave Airlie <airlied@gmail.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 11:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you get pull requests from the people you pull from that make it
> harder for you to do a better job, please push back on them too.

Side note: this is actually an area where maybe it's worth looking
into just having automation.

I've actually been fairly impressed with some of the more recent
AUTOSEL AI summaries, and I wonder if it might help maintainers to
have some kind of "summarize this pull request" infrastructure. I'm
not so convinced about the code-writing side, but summarizing
changelogs sounds useful but also rather less scary.

And I'm not suggesting that because I would use it to summarize other
peoples pull requests, but as a way to make it easier for maintainers
to write summaries of their own pull requests when they have lots of
different things going on.

Adding Sasha to the participants, since he's been doing the AUTOSEL summaries.

(Some of them have been just garbage, but a lot of them have seemed
quite reasonable. So as a starting point - rather than as the final
case - I think maybe some of those LLM's might be useful for other
things than making amusing fake videos)

          Linus

