Return-Path: <linux-kernel+bounces-859981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22078BEF12A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0871189AFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431C72580F3;
	Mon, 20 Oct 2025 02:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7ush6/4"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25D23D7C6
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926485; cv=none; b=fozVvo5fuz7v4kyk/gTsU+HC65UYVx5DrT8S5U2y4HNyHQgZvwludqICjSymHMPNhR1X0SkrzqsRvhKnm6cstXUTnTxhdnzx/1RGyYxRYq5+BkB+iqXvPMkOoihXFEBSnJWk75xjzQd6vX5zWtiBso0m+u1F3VXJvHKfaeIEg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926485; c=relaxed/simple;
	bh=8JfHOylAVVip2muOOt7ETieAPZo3QGzhMvbAFmkzR1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foA8AE4qrhlH5pUQu8Zag6wp19mQ2KMid3vIy0oV2Rnza29xAcbrrcNOK9VdfiYPvJ6KDv/QNc6Pn2OvLQfpDyZCoEe7qbWZClfMnGkKzga5AMOkEz46j4wulD88SrcXqn0KEjhsguNdp0MI6V3kVY9XypJGCL+qljjaC4zT2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7ush6/4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-269640c2d4bso7009795ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760926483; x=1761531283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVsG9Um499m4I5IEf6ueuZxgpEkoYUIuj1YcdEGnVKM=;
        b=B7ush6/4VZrKLHd5nScH8fKvA1ckixpBGBGUC+7rzSyQcFsANpgsCzSfXiixA8KPXj
         jXcv7DqIIJl04nWiwpUM5mw5E16DYTbaULepwzTvTLcSugerU7sJhNU9rZn9lxAATGqo
         pINUKXEywI3/A5v93uhswwAxVCUJ3ykQL1EkGh//ur8rCYNwxuqcInvHd8x2v464dWKd
         MM/zEBmgKiUx5DzJG3+2ESN2pJ4yx29yDj9xX1Wwzg5p1SSAhOGAdgYwIpl8uE79soiN
         51wo3yYZQf4GYtrNga5Bq+jiNXUJbjONKPRwVJ0wclhz6gDgHR9O6vxa9dxdS+Q5kbOW
         +E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926483; x=1761531283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVsG9Um499m4I5IEf6ueuZxgpEkoYUIuj1YcdEGnVKM=;
        b=LxYbwpESEKcq04n/g/FpEfQ1Epgg3s2Drz9QmSmiVnvB6Rmdw6q3gP222LUGvtq9Pv
         e3G8iEAwK1PtlmYywppU3yGAtzd6AMed6WhtyrtWbhh/JSlR8VrPkF1eXjr3646/jvVE
         j6JSHG2i0GB3HurbRlaEBwmK3IlJop4d4hKF0Odt2QUOq+JoolojQ9uMX3dE//EIVRsi
         l6ZbIpHGCpAhvg7izsyMVso3zzfqSNvu+j7K2LfmHun5gnSTFzZ/gEiv6efFhzGasCBN
         jXxq/7K5Ah2RfG48ZNtOA6uwvpqH+3yA8hXrJH1S3VrHV290TWa6iJpsynZpELpGch3i
         3zhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxOXBruwjiih4bg1AemUhaFfQ+bSc5KN2V1n0utdLbnd2W1911cT4CPw88AvnG8bS14ybGRYWLA29ZNW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFuc6xyIqURgyVhDhh7qdk1g7JzDn1RDIKrTvykGjntywpbdvd
	eirbBsSpZoBxjWWiWnhCQz4rLQlOMgsQNksYhsyuwNsbR49A2fjY1wxFnKh0Ejw8K04l2ZwCD65
	NHpR7TEdDrS4QFOXiSGCY5ztQ5dNpChZXp6WI
X-Gm-Gg: ASbGncs7h3Xw2ft6wfa8Es7y8XdxNekHoEvc0Ph4hYWDbFk0OlmztKrDcT6n7HzVELN
	pqg/lIpAoz53O7GGKFN0kDEq9NUM1bmHuhaBSPcpanNC/4cdb+58SmeqpcYjklcaThVODfwFQsb
	iLg34xqrB7OQbTPCZYlG19av4lwrJQIqCyJ5/GuIpWlLPrPfS8LtnxE1+6sRZhLyX+0MbB08X3u
	9ow+Hs0E0ZgAswrTpk+yfPrlnzheZRoO1H1xlVMHyFefuzq4SS8uJSJhyoxoeWIzevkDXnNZyKG
	7ugwkaZ8f06H1WYZDBkQE9xzFNNGFtxzqWhHSqF0XDTx1PNe4cS+SwunQTw5HonwOED3RRQwlkk
	Z1/yDD6K0A5/gjQ==
X-Google-Smtp-Source: AGHT+IFoTDHFumvg+2Yk2emYmQtucNR9NpaL+I7bbTkx8Mw5vZ+9U/yijmuyuLh6n8oOi9ctCSyePVKDkAY+eLSipNY=
X-Received: by 2002:a17:903:1965:b0:292:64ec:8f4d with SMTP id
 d9443c01a7336-29264ec9324mr31315655ad.8.1760926483145; Sun, 19 Oct 2025
 19:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020123907.13e15922@canb.auug.org.au>
In-Reply-To: <20251020123907.13e15922@canb.auug.org.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 20 Oct 2025 04:14:31 +0200
X-Gm-Features: AS18NWA3ZmGHFmBFe3-4nb8TG3BuQ8EUt4EFZAl0oM-rY9K-dBB0ncgrANro-v0
Message-ID: <CANiq72kHWgsvmxPYSAHpM5HaxCSf73t4NkPsBRXiPMTTe_u51w@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the rust tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 3:39=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> The following commit is also in the char-misc.curent tree as a different
> commit (but the same patch):
>
>   abae8f3c8374 ("[TEMPORARY] rust_binder: clean `clippy::mem_replace_with=
_default` warning")
>
> This is commit
>
>   7e69a24b6b35 ("rust_binder: clean `clippy::mem_replace_with_default` wa=
rning")
>
> in the char-misc.current tree.

Yeah, I added it at the top to be able to have the `rust-next`
Clippy-clean, but I don't plan to submit it.

Since you detect them, I will remove it to avoid confusion.

Greg: it would be nice to get that one submitted to Linus during the
-rcs, rather than the next merge window.

Thanks!

Cheers,
Miguel

