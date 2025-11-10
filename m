Return-Path: <linux-kernel+bounces-894317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E6C49BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576F2188357E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279FE30276C;
	Mon, 10 Nov 2025 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="bKO6LZGW"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB6263F28
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817193; cv=none; b=HW7k45D+OtsM54Wyqlia6tTZpSAdfho7cSQ16roPS08kczC3VsFY2pnr2C87FcWBYebjUnjxSbQYZRD/N9TvpVYtLGn9/CqgHK5NdxJNPOR4FwGKNIi1JueV5sQj2HKtBVbUj/w0PMrB7YSu8nYyWLm2Bp2w+VySoEeCVLyrXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817193; c=relaxed/simple;
	bh=VCB2ZMxLVCEaLhJ0PJgWPd2j0GgeMo+gFkURpClM/7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQqY+7/3gIIQVDgsJgBG4W6nx1xVgU120W1oNlSqD/0nIS697bbQ+X/KiqqmRt5YbblASIaU4uw/0ltfoA+f9SuBijv7LZy9WnRd6YQnPrv+ZBvQXXQfkXo6V3OQiZzT+brsIWWElmzaKLQD1Gm6G2eR+/ewPducT1OpusUpt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=bKO6LZGW; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-640f2c9cc72so748678d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762817190; x=1763421990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KipecrXhqUgdfrMDxFBmzG4ENSV0qjCiG+IUf6NbfOU=;
        b=bKO6LZGWGAg6N375Iq4fOW3QobxZhTa90eSkm+qsjV2EJd4XCpn/xWQopdCC69A5S8
         PLcwbFVaZB9/lu3qqynzPSWg0GgbTbYzPfSuxXtH3ZSkRdRYWykf9/zZRWZiE1xjZ9Ph
         qtSRHIRavoxnObV7ocGX8dZv3lOSreIqmVT82utARRtVoydL7iP7DEE9PqshikP+MJ/g
         Qez2yWXSgXgQzY6asF8IgntyYKRc1Cce1rIkrDXGBAQX8T/Wm9UbpVzxfQBfTDssnWA7
         9gT2Qt3spH/R51o8w93hXXudn/dfHiCh+MHyRNaaaG6voyfdGX0K8fTFqAFLOBhhumRU
         gX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817190; x=1763421990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KipecrXhqUgdfrMDxFBmzG4ENSV0qjCiG+IUf6NbfOU=;
        b=fdhcFGcVxo5f3hg5/ofZyUF98t+7JuN1JOQ0RJuxTzvDYJrT71FRZVh37/Pa/e90TW
         UBRsWNkfwkU56lA87TZZSVSUljW9vvkjv9PLJaxyRPCRAhKBEkSITPbeWF1Hik5oBEDO
         vO3MZo4GyAzBuCsHHpRLBTfBYQHabi8rpVP+jMLxvnf9k1VHi5ZU2qIX8t1z13ciL4RG
         fObvc5buOHitV2WVwkkllI2OV+5hpXzzD+/1odL6Pya9m8NM3NjzNv/ygpEoPJPUTaKV
         XMZvCgcV1NECZu+iyaWdl8UQO+7ZxypFGAyXIx0xuhjlz0f3G1ZcjiTZEnpO1USNM7oH
         7Haw==
X-Forwarded-Encrypted: i=1; AJvYcCV0ycZNhfxe6/1/A+RWIldcHB4HsP+lcdpn3kyVQv3P+av3vQjeFdXm9IRPZqutLmow7mGgSJgELaEfVqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EHzUsCchkdHXRe8zTrMmJa+50vorsh8fv+eWNCoabYodtGjm
	TPYipXiRKeDGBK0oUmkvqfLiWa1F6ggIQnazr9rb6+J1vZmRvYDo4PwlK4RMSYQX64E9xeaJAqY
	68XwQxgA0eXNgmQFIvQz5wUrNy/4v2KoijJEKkDvmrA==
X-Gm-Gg: ASbGncsFAuqfyrWJXBS0BZbSRdl0pc2Cx6t/pCQWknWJ42mJMRkwGgo7nP359ZnhXl5
	pxwc0nbRwbcpGJomLgKuP2HD+3mrA9s7ZILtdkTrA3ZQEBUvjOSPrwLe7gVylBvVqnxafOhjM8K
	i7NyaDQXOVvnNFPWq7xZ1HYcYhKnaJWHjQM1TZXkHWe8WBrG8Du5ywOvd6CK2ZH+77bn7DMeVzL
	3m+akuMl7DqL5cuVdgDYlRnlXl03hvUMvcxlG13s+D3qraqoHbZsC7+Pjx7DIpHyZnXHqvhow==
X-Google-Smtp-Source: AGHT+IHXBlAUFCR85xg+f0kdLjBezojNFyqd6xRE/D47CmRf5ykj9eoFr7t1LpF96qjxOpV6+cmjH5ejJYIsrZgrwxA=
X-Received: by 2002:a05:690c:6011:b0:786:4fd5:e5db with SMTP id
 00721157ae682-787d543a779mr176879927b3.49.1762817190409; Mon, 10 Nov 2025
 15:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-5-tj@kernel.org>
 <CABFh=a6rP08+vsK11Ubi5qv2o2yOYFSoiMMM8ZahSVy=LzXpow@mail.gmail.com> <aRJgTTiAnHzrMN8y@slm.duckdns.org>
In-Reply-To: <aRJgTTiAnHzrMN8y@slm.duckdns.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 18:26:19 -0500
X-Gm-Features: AWmQ_bn0JzQ8IqDTywdTWUHBnmbWv0P-aVwCXoPIRl2avHsOVuwvIbUg5a73Ys0
Message-ID: <CABFh=a6GNZSzrLzyonv5aYn8Rh06YquVoGHJfJnYL8rMOymZ+Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Mon, Nov 10, 2025 at 4:59=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Emil.
>
> On Mon, Nov 10, 2025 at 04:43:23PM -0500, Emil Tsalapatis wrote:
> > > @@ -1298,7 +1298,7 @@ static void do_enqueue_task(struct rq *rq, stru=
ct task_struct *p, u64 enq_flags,
> > >
> > >         if (scx_rq_bypassing(rq)) {
> > >                 __scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
> >
> > Nit: The bypass label has a single statement, and there is no fallthrou=
gh to it.
> > Can we just add the logic here:
> >
> > dsq =3D &task_rq(p)->scx.bypass_dsq;
> > goto enqueue;
> >
> > and remove the new label?
> >
> > > -               goto global;
> > > +               goto bypass;
> > >         }
> > >
> > >         if (p->scx.ddsp_dsq_id !=3D SCX_DSQ_INVALID)
> > > @@ -1356,6 +1356,9 @@ static void do_enqueue_task(struct rq *rq, stru=
ct task_struct *p, u64 enq_flags,
> > >  global:
> > >         dsq =3D find_global_dsq(sch, p);
> > >         goto enqueue;
> > > +bypass:
> > > +       dsq =3D &task_rq(p)->scx.bypass_dsq;
> >
> > Nit: If we keep the bypass label, we can remove the goto since the
> > label is right below. Otherwise, we could remove it
>
> This is really subjective but I like the fact that the local, global and
> bypass labels look symmetric. It doesn't make any different to compilers =
and
> I think keeping them so is less likely to trip up people.
>

Ack, makes total sense.

> Thanks.
>
> --
> tejun

