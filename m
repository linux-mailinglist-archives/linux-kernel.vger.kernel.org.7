Return-Path: <linux-kernel+bounces-828832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75621B95936
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6804A42D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061423218BD;
	Tue, 23 Sep 2025 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqYTjiRB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2A321444
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625692; cv=none; b=EiWkc5bbZxbjkvqHTK6Ctg2KGAWTguZDeuNUkJATfJUQsVBrTlD8mGrJbZzdyqlWjeSiP3MA9LeNTAycqJbwwf1XXR3kdd62k2uNtUCm8UGSApOndGmrolqOJTSI7fbLIz4qpOExC9xhSxPx3rwGM727tAt3Nja2rNpG10IV6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625692; c=relaxed/simple;
	bh=/XZsuYZiVJXloC6rrE97OTbLdirXXVYnP1HJQkVSPy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sth9/r+JXKdy32YoZ2tnUf3tQAJo9BLISQYAX0QvYz2++6XAdKVbvXfW+INcUQhW/fUF2vf6JLTizpMubjnnX143EXmYkiqOxR9cbsAlUqJOCBUf+chSKjaKz0JOUveZhuG7Av80nwhrY3WfPzd1uzYa2WpvmIbCPQAwCO66+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqYTjiRB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f9089b957so7975a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758625689; x=1759230489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2nNizs4EXcS6KdJvj0JrfZmsBGMOILUvFCRBf/9eF8=;
        b=bqYTjiRBUd6WehS77qKkZZ/Jyt+yuisivITRGxPEcCqprD88Ot1ZsMINk4JzeqeC5w
         Jiozv2UR//8SsKYs2EvD9lH+91HjU1cOS1I6hJ6wZS1hHtU53Y8u/iOwepdXE3vS0nE8
         9NqyheTgpoh42f6xaE7kFXIn0gDIxSMVlHR61p/rYLGoV+VJE6kXxPAAeZDU5W6PTtPb
         wj7I75TPH32wHLvcqKdRd+AAZiZx7DKaVIeS6K0V4Ahm6lHQSHMFRtrcs66moGU7KRdA
         KolPLykc25/JiweeQhABKQoUzBvgR0tgSP09xmxt6P+dSfN/Zt8+5fRtqhoze8NUrbDp
         zE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625689; x=1759230489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2nNizs4EXcS6KdJvj0JrfZmsBGMOILUvFCRBf/9eF8=;
        b=W7cpjzei/r3siazI8SVckhEpumAK1WoZWEMDzUrH8TXI2+wT9njsVkUgCAmMiGEU2H
         R2HotwU2Yk+KOPhaKkCGJH+dFiPF7NW1f720vmKZq+XMqay8hg8kwAARua9YgvypMguA
         WpxOj6LH26P0+l0e9FD8NyThFpoNcODPMjhohqesKpoHfAuq3ClNXJaF1SMNOHAF+FpU
         PDTFx1aGux1RU3aGQTP6Iqm3NOKjUPe93Yd3goa3E4pMMGoL79Uv/Tr5nhvf+m3FCqnP
         t2V3YG7Li/fmqp9BsCYhTjdexqfmXeMWtUA5GWyqfWQdMdZ1vSMzruj7fsswI0T3lPRl
         Qcqw==
X-Forwarded-Encrypted: i=1; AJvYcCUAFFxJRWwmR//6QkX2eEDDki4izTsKg/J3n/ZNHX/Z5r4OYl/pOwTZZCJxXAvOHNmDX4olQOKAYPSuLj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1yGiKb1ePYLdrPykis7BSiPrvw8kk9xXtFhvBw0JykRAxuI/
	GSeJv/edKGgA6AeWkajXZd9J+dZ5l4ENOBCFLcXjLGd/fnp2thD3VavYFL0s5YLAwm2IKQq5IGk
	ILsgJmoixJZcCsobLpY/32JbJp3b2TrlalCclAapK
X-Gm-Gg: ASbGncvffmJrON3CiNCtn8sQzTNTId3o61Qx9u6HfWDJrw7J0vdh5El4AMSy6j5+KGV
	/y+V7tT2UybHnZIuvWuLIvZ+sNpsgMgPnGrcFWh6cQ8lLAx5JzByhGAjqFIAGgZm/Z4Ll8A/y//
	eGVryG3XyNHV91vKi2xA/M+HxKcxWuoLseNwZwvRU7Zj2ZmY1EQNA8d6eAxgJ6VSQaoMpG1Q88h
	Dft7q9o1Er7
X-Google-Smtp-Source: AGHT+IHOG4WkpDAtV/b73oGn6Rwke1EUIyIWRMd8NKkWBm8ULAtIMX19l+qwsw2RlB89gRURbDqwg9zWE9ZKCbG8XBI=
X-Received: by 2002:a05:6402:1d1a:b0:633:2321:a07b with SMTP id
 4fb4d7f45d1cf-63466aa27aemr55515a12.0.1758625688454; Tue, 23 Sep 2025
 04:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330164229.2174672-1-varadgautam@google.com>
 <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com>
 <CAOLDJOKiEmde5Max0BnTBVpNmfpm-wwYLJ4Etv8D2KZKPHyFzw@mail.gmail.com>
 <CAOLDJOJ=QcQ065UTAdGayO2kbpGMOwCtdEGVm8TvQO8Wf8CSMw@mail.gmail.com>
 <CAOLDJOJ98EccMJ4O3FyX4mSFtHnbQ4iwwXsHT2EbLL+KrXfvtw@mail.gmail.com> <f74d9899-6aba-4c8e-87b1-cd6ecc7772e6@app.fastmail.com>
In-Reply-To: <f74d9899-6aba-4c8e-87b1-cd6ecc7772e6@app.fastmail.com>
From: Varad Gautam <varadgautam@google.com>
Date: Tue, 23 Sep 2025 13:07:57 +0200
X-Gm-Features: AS18NWDiaK8IssKPSakKKBWc2hagHQKHETrpRj1q8Sp4WHHDh4oDk9ZMPOZEQX0
Message-ID: <CAOLDJO+8JApK5_qjtn+DhCnQoF+Lp-x1KP_QQvJUqecp744T1w@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Arnd,

On Sat, Jul 26, 2025 at 6:22=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Jul 24, 2025, at 13:49, Varad Gautam wrote:
> > On Wed, May 28, 2025 at 5:28=E2=80=AFPM Varad Gautam <varadgautam@googl=
e.com> wrote:
> >>
> >> On Mon, Apr 28, 2025 at 9:41=E2=80=AFPM Varad Gautam <varadgautam@goog=
le.com> wrote:
> >> >
> >> > On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM Varad Gautam <varadgautam@goo=
gle.com> wrote:
> >> > >
> >> > > On Sun, Mar 30, 2025 at 6:42=E2=80=AFPM Varad Gautam <varadgautam@=
google.com> wrote:
> >> > > >
> >> > > > With `CONFIG_TRACE_MMIO_ACCESS=3Dy`, the `{read,write}{b,w,l,q}{=
_relaxed}()`
> >> > > > mmio accessors unconditionally call `log_{post_}{read,write}_mmi=
o()`
> >> > > > helpers, which in turn call the ftrace ops for `rwmmio` trace ev=
ents
> >> > > >
> >> > > > This adds a performance penalty per mmio accessor call, even whe=
n
> >> > > > `rwmmio` events are disabled at runtime (~80% overhead on local
> >> > > > measurement).
> >> > > >
> >> > > > Guard these with `tracepoint_enabled()`.
> >> > > >
> >> > > > Signed-off-by: Varad Gautam <varadgautam@google.com>
> >> > > > Fixes: 210031971cdd ("asm-generic/io: Add logging support for MM=
IO accessors")
> >> > > > Cc: <stable@vger.kernel.org>
> >> > >
> >> > > Ping.
> >> > >
> >> >
> >> > Ping.
> >> >
> >>
> >> Ping. Arnd, can this be picked up into the asm-generic tree?
> >>
> >
> > Ping.
>
> I'm sorry I keep missing this one. It's really too late again for
> the merge window, so it won't be in 6.17 either, but I've applied
> it locally in my asm-generic branch that I'm planning for 6.18
> so I hope I won't miss it again.
>

Can I follow this along somewhere? (I don't see it on arnd/asm-generic.git =
atm.)

The unnecessary log_*_mmio() calls are showing up on enough Pixel devices
as a CPU cycles wastage, and I'm sure other Androids see it too.

Thanks,
Varad

> I currently have nothing queued up for 6.17 at all, but I already
> have some of my own patches that I plan to submit for review after
> the merge window and merge through the asm-generic tree.
>
>      Arnd

