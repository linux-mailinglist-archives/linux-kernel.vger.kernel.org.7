Return-Path: <linux-kernel+bounces-779354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18451B2F305
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9371C8025C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B22EE60A;
	Thu, 21 Aug 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxD9TlRC"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A52EE604
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766454; cv=none; b=JI0gUzhO+PMfr+/dRMlMDiPH6VVhmxBtZeyBsSGcPbFjy1m8F+C8zUh0WFPkt4KjMLPWCsqCoPyNoMm2k4ET0GGl9fxSZiuB4WgKplaZzjoH3u1RLbQJ/YyMMH4/jZeeF+EsLJOFiAUxo8HnI2YVFKSHi9U+2n9mrAk8aufr/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766454; c=relaxed/simple;
	bh=GIrYS0OmlFt9LKTpoCymctnhQ+44IqZBFk1EpEs09Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Olr0DbsogdVRcHla+FeKJ3ewrcq0HFuA+mKbwYiZyoiA862TUVZCH5qoHyJrRwqjai9xqEoqsZu7ty3Lki/juSd7niFsxcxB74NM43GyFmlXw+GnfDX6j9LX97/c9Yzicjl97H1AL8ZkyF1DGR1tsUNo25F06VE7iIgJOliv+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxD9TlRC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24458263458so7180185ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755766451; x=1756371251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PDwM7xFUlPs+9+76w2+0oYaXgXFtT0j/TV/VcSqIHPw=;
        b=KxD9TlRCA0A4ZXAR8Okitj5EU4UFjLrjRCn6OrHRKyS9gOqo0shoSjvaOvmu2w12iH
         alzvpbSmmNpzxL8VQsTXcPD7nPK1qXolRgAJyPLiglhlueISHLEo8ItCM6QjfzzrkOe0
         85El6+zUOtsfmbdVSIzqOT1vx0vS9a9N/snvIjQ7mVhEmmb8uyRefVPjjOQSUy+ttTSo
         n0hVUgS1gkSt2xZZsxCs6orUuYe8jj+e1BA/OuiKF+v3FwS9pL6DEW4rTUbCxYEJYvnA
         5cNnqDZ1AIIwIqNbF9avj2IIOp6N1ilwkb0wG/KD6RBlPG0pQ8Jn4b49kRutvR4rh9Yi
         HO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766451; x=1756371251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDwM7xFUlPs+9+76w2+0oYaXgXFtT0j/TV/VcSqIHPw=;
        b=BZOFTb3eCrHTpR6g+Zfpo15BRb3r0UCqs38CW1v42eJwxNfKJ9DoljpsiBg4pKf+VP
         zs3u/H2LIV5xxROhIzNUh1Krj4S1/viom0dNzqZEv7dqmPEGTzBGirv+wd4BnbI2horn
         NaVYuAyYnWfEfUJBhQZcPbj5xJIUlQAdNLk3mzo9EKikPMU7Dad463UCWxV5WaLBOymO
         wVvTpCv5K7wbJ3X1qXM+p9SLRMaGen5xTscgT8Tg+UbPvq+LqGZTWQieZF1XfJrXLkld
         GvIdVyF22yEU6Iq/CQFOBbQ5MZK1heiJQg2HpFvhrypFKZm27K1BqK+AXj0cgoSjbxZv
         A2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXzbsbFhMEuKKBD8LP7FMyY+CVKafeNh5j10CIH3dNqaX1gXXY0ilrZ2nfEMrLljMbrxWcfk+Uf+KTPfos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrqGlDzsRPtEkU0krgoTZxZLKaanwGGYa7SPaMH6ve746MVZ8
	hChQlaeh+t8/G9Bvgx6wLGKqWhfXjrmfzK5sawOJvQY3xO2gNHWVfMblZ2inMmFcJc7YpTdtfuG
	iCXyKcTBVAc9PeOVR2pTmm6bDFRMfRw/x99Oe0gAu
X-Gm-Gg: ASbGncuJrRLMKB55a9agvWmUouC/FlirKFBaLeHSStXttA8Fhzh/EYp40CGN4T7UMLq
	ABClmH4Aw4uPrXFJpg4PWgzvaRYktCWxs345TPaQ9KxLUi54u0WfY9RbNj5O9P6sG6uFOCMGmj3
	6gaHPSzl6fjRZfgRCzeMckVO8xHdb4D5mtbYfqOvNY+OXPShj9fmKu8qBuExnlQ9IttGWmJiX5/
	ihosovbvrFhVwT8qBpJcm15
X-Google-Smtp-Source: AGHT+IEOJ+GiHnoM0xXwePeIaKaKu+bZ/GYxKzuA6yTE5qBa74SEtPQ+etUTrmOlcSdW9xiNKjgOpyr6oyET1zwx1W4=
X-Received: by 2002:a17:903:46c3:b0:246:570:2d93 with SMTP id
 d9443c01a7336-24605703276mr19916595ad.59.1755766451273; Thu, 21 Aug 2025
 01:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801092720.1845282-1-verhaegen@google.com>
 <20250801092720.1845282-4-verhaegen@google.com> <aJGNgphPCTuE7FFD@vaman>
In-Reply-To: <aJGNgphPCTuE7FFD@vaman>
From: George Verhaegen <verhaegen@google.com>
Date: Thu, 21 Aug 2025 10:53:44 +0200
X-Gm-Features: Ac12FXzXjgkmnFwjD3_zb-Ps1Osi-BQvLWpKMG84-DK22RezOWC3UFnJT0qOukE
Message-ID: <CAAntYmKu_tsm1D9koxCZmHpBMQYhrt-HxNBYFeWz6rCqdMZqPg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ALSA: compress_offload: Add SNDRV_COMPRESS_AVAIL64 ioctl
To: Vinod Koul <vkoul@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Cezary Rojewski <cezary.rojewski@intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Srinivas Kandagatla <srini@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-arm-msm@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-arm-kernel@lists.infradead.org, Miller Liang <millerliang@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 06:50, Vinod Koul <vkoul@kernel.org> wrote:
> >  static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
> > -             struct snd_compr_avail *avail)
> > +                                struct snd_compr_avail64 *avail)
> >  {
> > -     struct snd_compr_tstamp64 tstamp64 = { 0 };
> > -
> >       memset(avail, 0, sizeof(*avail));
> > -     snd_compr_update_tstamp(stream, &tstamp64);
> > -     snd_compr_tstamp32_from_64(&avail->tstamp, &tstamp64);
> > +     snd_compr_update_tstamp(stream, &avail->tstamp);
> >       /* Still need to return avail even if tstamp can't be filled in */
> >
> >       if (stream->runtime->total_bytes_available == 0 &&
> > @@ -233,32 +230,47 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
> >       }
> >
> >       avail->avail = stream->runtime->total_bytes_available -
> > -                     stream->runtime->total_bytes_transferred;
> > +                    stream->runtime->total_bytes_transferred;
>
> Lets not do formatting changes in current patch please

I'm happy to revert the formatting changes. Are you only referring to
the alignment of the subtraction operation (avail->avail), or
something else too? Note that the second line of the function
signature of snd_compr_calc_avail got re-aligned by clang-format due
to an actual change (type change to struct snd_compr_avail64) so I
assume the re-alignment here is OK, but please confirm.

> >       if (stream->direction == SND_COMPRESS_PLAYBACK)
> >               avail->avail = stream->runtime->buffer_size - avail->avail;
> >
> > -     pr_debug("ret avail as %llu\n", avail->avail);
> > +     pr_debug("ret avail as %zu\n", (size_t)avail->avail);
> >       return avail->avail;
> >  }
> >
> >  static inline size_t snd_compr_get_avail(struct snd_compr_stream *stream)
> >  {
> > -     struct snd_compr_avail avail;
> > +     struct snd_compr_avail64 avail;
> >
> >       return snd_compr_calc_avail(stream, &avail);
> >  }
> >
> > -static int
> > -snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
> > +static void snd_compr_avail32_from_64(struct snd_compr_avail *avail32,
> > +                                   const struct snd_compr_avail64 *avail64)
> >  {
> > -     struct snd_compr_avail ioctl_avail;
> > +     avail32->avail = avail64->avail;
> > +     snd_compr_tstamp32_from_64(&avail32->tstamp, &avail64->tstamp);
> > +}
> > +
> > +static int snd_compr_ioctl_avail(struct snd_compr_stream *stream,
> > +                              unsigned long arg, bool is_32bit)
> > +{
> > +     struct snd_compr_avail64 ioctl_avail64;
> > +     struct snd_compr_avail ioctl_avail32;
> >       size_t avail;
> > +     const void *copy_from = &ioctl_avail64;
> > +     size_t copy_size = sizeof(ioctl_avail64);
> >
> >       if (stream->direction == SND_COMPRESS_ACCEL)
> >               return -EBADFD;
> >
> > -     avail = snd_compr_calc_avail(stream, &ioctl_avail);
> > -     ioctl_avail.avail = avail;
> > +     avail = snd_compr_calc_avail(stream, &ioctl_avail64);
> > +     ioctl_avail64.avail = avail;
> > +     if (is_32bit) {
> > +             snd_compr_avail32_from_64(&ioctl_avail32, &ioctl_avail64);
> > +             copy_from = &ioctl_avail32;
> > +             copy_size = sizeof(ioctl_avail32);
> > +     }
>
> Same comment as previous patch

As agreed in the previous patch, will leave as is.

Thanks,
George

