Return-Path: <linux-kernel+bounces-843719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4CBC010B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D4A1899D92
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277D1FF1BF;
	Tue,  7 Oct 2025 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MqAiJ2JG"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1561F3D58
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806563; cv=none; b=CAmCO6e9Jh9r/hyw30c9CGTSA/ZHRm6lyzRfCs4FWypwrHQYHk9M+odkbna5NWMxF4ZH0Ixi92fblnFzUak8E+qgiY0zPQz2/CY+U2wSDWS6//0io+Taydz2O1zZ0kJPlA++IG+zUks05qZjd0czLU3CDdCCgmePcVHEeY55rZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806563; c=relaxed/simple;
	bh=lZj38OKkx+1/Ld1EteLv/YwogZEZ1ucSGqCfkfqjXDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ap10/r8gN2ecZbNGr7F4q7Oy41Rj9Fhd+Xb6zIGfMOuGj6Slyttk8buavOjL9cRXKv6TxLcR++J6CvqXg3eP9iMArxHywukLzATXMZRMPnmZ9beMXDe1FkDiz4I7a3U58TQ1FHXZ5iIJRLI5oi1Q/tODcNUPymmy2V+w+7AH5Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=MqAiJ2JG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3352018e051so6748914a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1759806560; x=1760411360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XffbB1BYJQjeKTYwuW/PPDpT+pJqNE/EDu7Sp9DXqac=;
        b=MqAiJ2JGJ8t5kiZiE/7AWmlyErQafFQc/r7GLhS94I85HPvAQXj/n8OAZELhID9V+S
         7v1phECGAZI7KEtkH5iR6qsJv5HyYygSL/Rzz5TuwNMgCIli3ek+xVCn9GQ/DhEur0/r
         pkWaKcPkzCJR+44pEp0vcFNptCdrqogRB1z73k/MsFfJ1KtPOdHAfkHM4+wRzlXRgXur
         h504mkF2/7+Msc2f7A2QzIQpcb/xd6SqDu7HytuFFW+WSwjfpqMoTAltHcYTAFdlA/M2
         p78yy6I8J1/NajwWEDw8d8Ny/padrKckdmCIwVgFERfADKGl8IIkotDvggkWbs+HU2kR
         CrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759806560; x=1760411360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XffbB1BYJQjeKTYwuW/PPDpT+pJqNE/EDu7Sp9DXqac=;
        b=XbD5ZW20MLPjh1JwIMVB94YgpA5toGd2S5P0XQvMC43B2hG1/cekrdeyvocnWEpdMo
         4MVXEKaBWfJ7vv9f7YGrJ0sKL03HmRMHjGzPCZfG+4quC0AIGqahVE+n9i3h8dndiqfN
         jaERnKkhxZnDG7hajLbawZYZ+nS7IwnkzJQ7Amf0ikAjhSNeSxpappLkvufh7CJ8QkHj
         t86I2SWTTypawFXzI8QPm0FPE84a2A9yShdQc3uO/y/eNUd+2g+a/k+ETCUteu+TnllC
         Vl/Cl3vwwUzOJrdTC7bDvWvqGIy3FiTAbK65NHJu7Gr9t4odcbS8Pk9HFGMTex24r8Mp
         y99w==
X-Forwarded-Encrypted: i=1; AJvYcCVcDDFuUKtOk30KJz0llMJSn3VY5OybltZF8uIbf65iRRaA0rQ4jrDV89BnARnNBTJmgf8kvl9xQYT6YJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tCDyjbgTrE/2xX5byPVsut9eZkT/5e3yFf6cLWTa1quCvan/
	yiCUR6bZvzTF+4hUPzLTatoEL38hnA7Gm4Trig7yDAPCNdQvbg7q1w+IFvpgSsXEH+MLjduNwP2
	5HFH77oZ6HzkD5ke7h4JyHAB9u/5/j63q7NbVybcD
X-Gm-Gg: ASbGncuZhezBCyPRObfMXl+36ulduNIP61aNhjNLlNn68hjXI0TtnsGWzJZGwrdRu6x
	8sG4PG0YEDh3vZUdaTQP4OG+xjre/ZKGKdeRQS/wuyfOstj3caaIVWltg0Hs0RNXcxtOzp/Iz0k
	O9QT9T6rLd/z9lu+i+l9dIJIdVOqpJzGb5pEUDjFGPlj3Xwax5Eg+lcsumNeYpdnQl3UBwDrfnr
	bjN63w6ZcyaguEL/SPQiuCuOw2ptgWQSMRwUcqD55IwMWy1uguwuLhhw3QfIyqTogJ4VC1QVxxR
	2MZwY0o86yH4/g4ct3vRm+pPMH6hebVVnwCgn9NEep3tRQ==
X-Google-Smtp-Source: AGHT+IHaIEffMrKfeTcTUgzGHSazsuwuu7lVlCYO+h2WNjR/W3jVRra3F+3+Cw45MDqEiW6xN4uYlma4f96TT98oLxs=
X-Received: by 2002:a17:90b:38cb:b0:336:bfce:13c9 with SMTP id
 98e67ed59e1d1-339c2786cb0mr18172403a91.20.1759806559955; Mon, 06 Oct 2025
 20:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-gen_init_cpio-pipe-v1-1-d782674d4926@arista.com> <20251007121719.45090b21.ddiss@suse.de>
In-Reply-To: <20251007121719.45090b21.ddiss@suse.de>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 7 Oct 2025 04:09:08 +0100
X-Gm-Features: AS18NWAhAB7vNo7AYIrC-NzBUTjNLPLP1aeLAtk5_788uAbnecrqxdiQZUrf6pE
Message-ID: <CAGrbwDSU+tidGxPUmKpANUTeCE+vEib5uQGG4DQSR9k-RK-WUg@mail.gmail.com>
Subject: Re: [PATCH RFC] gen_init_cpio: Do fsync() only on regular files
To: David Disseldorp <ddiss@suse.de>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:17=E2=80=AFAM David Disseldorp <ddiss@suse.de> wro=
te:
[..]
> The code change looks fine, but the commit message is a bit verbose IMO.
> Please drop the first and last paragraphs. The reproducer could also be
> simplified to e.g.
> echo | usr/gen_init_cpio /dev/stdin > /dev/null

hehe, OK, let me simplify that in v2.

>
> With that:
> Reviewed-by: David Disseldorp <ddiss@suse.de>
>
> > Fixes: ae18b94099b0 ("gen_init_cpio: support -o <output_file> parameter=
")
> > Cc: David Disseldorp <ddiss@suse.de>
> > Cc: Nicolas Schier <nsc@kernel.org>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
[..]
>
> Another option would be to catch the EINVAL error, e.g.
>
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
> @@ -112,7 +112,10 @@ static int cpio_trailer(void)
>             push_pad(padlen(offset, 512)) < 0)
>                 return -1;
>
> -       return fsync(outfd);
> +       if (fsync(outfd) < 0 && errno !=3D EINVAL)
> +               return -1;
> +
> +       return 0;
>  }
>
> It may be a little portable than isfdtype(), but I don't feel strongly
> either way.

Yeah, maybe worth avoiding breking compilation on some weird set ups,
going to use your version for v2.

Thanks,
           Dmitry

