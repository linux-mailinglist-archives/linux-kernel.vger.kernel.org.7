Return-Path: <linux-kernel+bounces-818118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68081B58CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A45F521B30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5E22D795;
	Tue, 16 Sep 2025 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0jUWibF"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB6DD2FB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757997558; cv=none; b=pKCEGkpeu43PFY7BU6zg4teYeQS/2fQ67IDN1uzxKnW/dJ51BSEIe9fl3M9IG0DJBdi5RuDi+UEmLXciFsaDzQfwV3evwGp7KLIrSpuv2oyUMsPsUJGXefcNsZcWwF7vQnaRKs3CPShWeEODw2eJ+ggvJOTk5es6Ohvo1I2Wl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757997558; c=relaxed/simple;
	bh=G0Yqte3cJ9LC3v2woySXFGbt4cKJ9SByCvcaQ4vVEsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8jurlcV04x31kSTHY8x0U6iBBa+1U81wCJZBKRQbNo5zahqKc39py5pbVTMm1gUxNyMV72/RjMAeoFVM0Qmn9gUV9frho0npp9fUv2/2Ah6khWppytQmFqrBFZcZcWBlv9R7qoZC4A5Vet7ZNkF2Wlncl6hpJ13E8q4Ovib4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0jUWibF; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b78657a35aso101521cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757997554; x=1758602354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R6kQ9nEgywpeDIkgPPLCORIQ6RGJTSFvVt66zj4n+8=;
        b=L0jUWibFaWp0OLMO4qwUZNTZjuZ/2zQp6SDyf9BBmJjEUyLDci801X4NSPif0yOi9j
         6lFib6g/T2z4zJfxV01LC/eVmONQwcYHYXwLI3X1LiSuWFRhBD1TvjIhcrb//zm4mF5n
         Zhblj1UjBhuv1PKDlvolKesBtH3C9p4Bqk4DaTTj+tRdv871gxWNPo6CFBa83j3l9NiJ
         PK4U8RxwEKjE1+mzrluG9b/5Dfi98w93vpnKMQW2TAoK7KUTQqZ+jZImcuLomSt/jMvA
         NaQIHC/v0R0aEEqcMNi2tnn0Fa3hV5U5LdhuQNhCT1XgZV1YW8KbfPc5R5+fzCXl0drm
         ifNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757997554; x=1758602354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R6kQ9nEgywpeDIkgPPLCORIQ6RGJTSFvVt66zj4n+8=;
        b=E/2+uHR21u9NyITe1ifid+KBMGYfn+Om/6Qsi9iJQk8Ki/nKqnb7fKxkqLcM7ZkH1r
         RECeA6N0FGw4gchuDH2iOUfBvSennJ0bsthhe1BQCLaqnvFhi/EoUfKORM6B1FogWH1N
         +0MQCY9q8UfB2v168gmbaOo/xjcdiHp64dXTlL8NWD15Mjt2pHYESO6EabRLwGB/qDLx
         TrehBViA+w2wD9Va2kIIaMpXWYHRWb6B31Aa1zZV3OOqMNB+TB+qJnhbf7mkhtp3A8k8
         jM9smW3eSBWgS4HOOafSA/puN5PTbmfDl3OG4y23+CVKfi31nb2HRjL5zDhUH2Qj1fC3
         RaYA==
X-Forwarded-Encrypted: i=1; AJvYcCVUaBZYg18/HWnAMJEyVqagb+0iz5mNcksgeBZPvqMLcg2KRzLh+UQ48pyUSg6aE8YnRQbFPogMIlb5ANs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzicne6CxLOZBBSjWRInQ+YbXTA6oI/ljIBFwu7T5h6d3gMfd50
	AgoW+t4Q43GAhu+4LY3BbTWKgd+gUQPXoJt4l3UVmuEgUipJ2vkeYHRo68fSqDvYVZGalIYKoAa
	5kxDEwFpVVNEyJmOvvEY9T+7V5Cdz2cf4h9JXYBVo
X-Gm-Gg: ASbGncu1DK5UoioyF8hGBE6+k6xJ17AOgcmgzJGnax8hy0ef9LL2wCSUK0s+KFONHA6
	ESvtYJk7fkzUrvciaN+b8cfzFwGTvujmdl5oIt53Io0IEhJjm1HG8HRJyoHXrXDldvyZ6hGK9ll
	7bApZUeaP6VdQXe4zhi3PZ6psI8y0MX2/HKDy/cHpFU4TmrOoPXdeuy1wt4RCmFWbkvDaJp/Ses
	7sjCvpDzQ9m
X-Google-Smtp-Source: AGHT+IGy2zUeUVgUuFT4t7VWEdEjde2wG3xmJbbzOEgNSuq/gMX0RcKVbdjrWT5skjoaUgdj+RMigu48osKUGCiYUHg=
X-Received: by 2002:ac8:5846:0:b0:4b5:e600:3d6a with SMTP id
 d75a77b69052e-4b7b1d8295amr3905351cf.12.1757997553736; Mon, 15 Sep 2025
 21:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <20250915171112.f71a7606a7f9fd3054662bed@linux-foundation.org>
 <CAJuCfpFQCgQLSrzfVjV+J4tkYbOx_W9v-kWmoo-rmh5hs9gEXA@mail.gmail.com>
 <20250915195633.96236cecebd8777243a770bc@linux-foundation.org>
 <CAJuCfpH1JW8vwOFF2H2SOxZqoJHadXsTc6C=LUS_=twcf=k9qQ@mail.gmail.com> <20250915212133.de5b8522137a5ed30efe956e@linux-foundation.org>
In-Reply-To: <20250915212133.de5b8522137a5ed30efe956e@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Sep 2025 21:39:02 -0700
X-Gm-Features: AS18NWDHXLFv3lNg4PYk4Bb_peo44MLmDzNlQvZH7VM8bIBPMPrwoAZZ-W4no6M
Message-ID: <CAJuCfpFonUPE0FL5XGm0paYp9ZXeAKK6mjHO_8hUkyxfyduL=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 9:21=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 15 Sep 2025 20:34:33 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > >
> > > > could you fold it into the existing patch or
> > > > should I respin?
> > >
> > > A little fixlet would be preferred (by me, at least).
> >
> > Ok, should I post a fixup patch or you will do that in-place?
>
> I think the former, please.  Your intent is preferable to my
> interpretation of your intent and we get all the nice patch metadata to
> track everything.

Will do first thing in the morning. Thanks!

>

