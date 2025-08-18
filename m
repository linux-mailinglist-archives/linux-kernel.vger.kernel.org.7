Return-Path: <linux-kernel+bounces-773878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F5B2ABA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E515C2A72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D2535A296;
	Mon, 18 Aug 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4AIWgoz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8535A28A;
	Mon, 18 Aug 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528136; cv=none; b=m541qftepMe9/IKx/UcM0em63adni05KoxWFiEXyhpMjX6l/6cwIHByuZauAVNOjd9RpMGEV5ZGSu6hTr+8ErsSrE1QmRUOIOJKGBkGRV5km2COyglD2DjOvj86UvWyFk6bLQZwi+tyLnYTnlg7wEQmndR5sSSHpN1FT4c5/gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528136; c=relaxed/simple;
	bh=g8huDsrE0kNMAJ4YeKQeYZ+Jxmi3wLlT5sYTAM6ravQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0BKnInuiff4QvAqQaa34EbRCSVZNJLu9pcTLBAA9bM4Ai/U1UU8yMdNBICEz+eBZdLUDC5n9QdIXXL1DgC3+XQ5TOaYzhleKImcOFKR6wnwQMpHNXFrUPQudxhVKJmDC/+Jqx1b1hC/SWNq1R05XtyuSFoa9E+4UnQ6SyVI2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4AIWgoz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so22026875e9.2;
        Mon, 18 Aug 2025 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755528133; x=1756132933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VylDR1oWkJ0EiX1c8eLC+dJ8zDkBar7+OrlY7elEsc=;
        b=V4AIWgozUCxGMK8sf5iEQS/UR0LICoxh7TFSjDC7N/iUl78cVJpAXoZ7oYu8gZ75Q/
         WWmw2GJnp0jDuQW4or3crBczSfqC2kFeYZ6fRABpa2eJisb/0Cc/bcykKwBD0POUR2Dc
         GEhDIqTlAXKDydfjQpvytCaJilJmPA0OIQYxcmVf7Xkk2MSxIN6HSIJ7/NZMOmwSOz5Q
         IoB1z4wDPAFD6acwmA8l1VgH2RoE2tLibBybIvrIOTezmJ7wnYTlj2Zzm6rlhYEU8btW
         7+eunoFu3VPX/lflPKcSl5HUts5Y0cMFjkUdA+2UdYDgDZcXlfCF885qg9JVxHuu7tVC
         7FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755528133; x=1756132933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VylDR1oWkJ0EiX1c8eLC+dJ8zDkBar7+OrlY7elEsc=;
        b=jnkQrX5joVQuy3hOepCAyUWaO7OGEi4kPyC0ahbw+GagZdrEK4v8NwC9JPH3vC858m
         3bK1BwJg0J94nEK00s/rIEU2r9ZI0+rx7nZZTKKrNjnvMicVR32Q8ngUh5n+bK0I2/V2
         wre9OmSvuI20mnBdNnYSxek7OTFnC+rMZiTSKUGonZr7xmmCd3shf7cwnJJ8qKzpfrne
         PNL9fz07xYlmA+Uajpwj8UDnHNITkc5+ct/0luW+bYBBpI4kdxtaSXbdhPwdzVxn9Wdu
         ysi0JPD1J63g+4rQKpLDxClK1Z8nv84F4OTvIDL4LcSQ6pHLN1U/FEbqEyZeaiVqo2dQ
         5rjA==
X-Forwarded-Encrypted: i=1; AJvYcCW9/v4fjTmVAnXcrINa7ar9uM3W2ZNz86fvsYL2FQUPJWh88FD5HIakvwWQ06JS5ocHIswMW7+vWO6v@vger.kernel.org, AJvYcCXwBsRFiAdihL5EKzxSJAJzN25epy6xvUodSSSqeCTv/IS69RZvVA2LKB9yH4FJa5x58OEXAosu+6BgemlY@vger.kernel.org, AJvYcCXwsSDXrJ2kTouludwQGYRoWbAKUKk0HltiihC7KnP5XAn11dtnFtHCRjBMxEc1FcfXZWE+zwgnrH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQS/PFGAwqQPWEpNA5r/fNli+Zzn9GyNhQB5mglH5FsMsFgWj
	RhLG3o+SnMuhZvh+BXPTMKaQWclbUe36I2q4ZOuh3jMx6Kg4l0X1wUliJkZxL26u9nR0Me3dPtD
	8Kr5THrAgAYr4nNrfI6NKk0+vnCcp9kW4lyuRCZFxNw==
X-Gm-Gg: ASbGncsk0Zj3t1BZ6oLiJ7U3HuxjvNpM5f5VD4Pe5+/dhviZENLJoF45n/gowzaxcda
	RMzDQvFs3Tl9LPwBkNKgZn6kL2C90lSywprMHYXz4w5jWCAc0t80/d2sXeXTZZSAnn+aNISaxQp
	5w0DlyfQh/Rl87DFb+Y6fEdJXVFU9u5wBHMuo5kmjXhIjBYkB6uc3d7Ye0w9sD9ILFOhf8aaxr3
	xFEENUTvg==
X-Google-Smtp-Source: AGHT+IF6uyFUGlyDCHbyGxLbiebW15nl1dAN+7KqllTQkgQUSLDjBnckdQ4PrtuCjAiIJxTGaqJ/sn4x3b+8l/vlLUI=
X-Received: by 2002:a05:6000:24c5:b0:3a4:f50b:ca2 with SMTP id
 ffacd0b85a97d-3bb6636cb19mr9221513f8f.8.1755528132931; Mon, 18 Aug 2025
 07:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818075051.996764-1-yeoreum.yun@arm.com> <20250818075051.996764-2-yeoreum.yun@arm.com>
 <CA+fCnZcce88Sj=oAe-cwydu7Ums=wk2Ps=JZkz0RwO-M_DjfVQ@mail.gmail.com> <aKMmcPR8ordnn1AG@e129823.arm.com>
In-Reply-To: <aKMmcPR8ordnn1AG@e129823.arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 18 Aug 2025 16:42:02 +0200
X-Gm-Features: Ac12FXwekbsyapeljRABB8AE1hyjZDIfFB0HZbnsKW56XSmgXNqVbJdHAoiUZKU
Message-ID: <CA+fCnZd9m3WBPimikuxSMNar-xbDaNFNQEJ9Bn=8uCMe-uYHeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kasan/hw-tags: introduce kasan.write_only option
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com, 
	will@kernel.org, akpm@linux-foundation.org, scott@os.amperecomputing.com, 
	jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org, 
	kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org, 
	oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org, 
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com, 
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 3:11=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> > > +           hw_enable_tag_checks_write_only()) {
> > > +               kasan_arg_write_only =3D=3D KASAN_ARG_WRITE_ONLY_OFF;
> >
> > Typo in =3D=3D in the line above. But also I think we can just drop the
> > line: kasan_arg_write_only is KASAN_ARG_WRITE_ONLY_ON after all, it's
> > just not supported and thus kasan_flag_write_only is set to false to
> > reflect that.
>
> Sorry :\ I've missed this fix from patch 3... this should be =3D=3D to =
=3D.
>
> However, we couldn't remove kasan_arg_write_only check in condition.
> If one of cpu get failed to hw_enable_tag_checks_write_only() then
> By changing this with KASAN_ARG_WRITE_ONLY_OFF, It prevent to call
> hw_eanble_tag_checks_write_only() in other cpu.

Is it possible that the write-only mode will fail to be enabled on one
CPU but then get enabled successfully for another?

What would happen with the current code if the first CPU succeeds in
enabling the write-only mode, and the second one fails?

> As you said, kasan_flag_write_only reflects the state.
> But like other option, I keep the condition to call the hw_enable_xxx()
> by checking the "argments" and keep the "hw enable state" with
> kasan_flag_write_only.

Assuming we keep this behavior, please add a comment explaining all this.

