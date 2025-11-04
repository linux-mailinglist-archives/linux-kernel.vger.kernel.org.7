Return-Path: <linux-kernel+bounces-884420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCFEC3022D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CBE1889D15
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19992BCF75;
	Tue,  4 Nov 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7ZooYB+"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE123A9AE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246634; cv=none; b=QVzkrnEGTUjKAHkVymrKyXaMN57fFaJeJD41u2I1bI1t0Nb/vIfAT1oQ0Q30ANr/QkqHhVtcNLadTcxwtRU1XfKgRXZlxQeg/UZbT14FZD18Siu7j89F4Gi/RWPPmWOgPEEEuIYkeYqQkGy7ASf2CIff8oigelsjv9RUXEzS7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246634; c=relaxed/simple;
	bh=w+jj3ziLRLynG+wa+K+2Apvi2QZl6via6pOPc6M9QTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WV6IbQ5hUMlTxsP/YNgvXvJ0iR/VrGm62GyF1PiIeEN2nYC6IpbuEurYFJ10mu6hFmkOkJYXH204vPmem62zFN/tEVmnC42YXb1A9NkNOFWuRZ17ZN2yVTjXrD34tFtMeG5t98HcxbVcBbrLBMCNey2QI1w2OIBPyaWQr0n8S20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7ZooYB+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso851057066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762246631; x=1762851431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+jj3ziLRLynG+wa+K+2Apvi2QZl6via6pOPc6M9QTQ=;
        b=U7ZooYB+TLZ2U2mSLv+d9MUNvpKaAm3HLw2QEQWr5s4UUjiuB276934Boz0c9arn+q
         JJ/r9reKNka8uv4GCaWmCjAghPCbgR0XMnd5ruvrgWMI6ZuVkxCmpTFh9fUbsdA37XQN
         +4cG20g2Vjtn8qIfhN0202ATuSZZAp2dlhiltvzIIRpTk+IgpDLg4V8sHapnW17v5SqX
         TR/zHsgPRLhhmvIThyADAailp5KTtA+CQTs4VGlrV5F8XFz8BZfCorWGJUgBDUyIUXND
         s/Oqvfi1tYvBRJ3bql9W71SnseiKzK5xLdUGuajpYOczIdaJwM2rz1EJWVDzJ25x/daB
         HTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246631; x=1762851431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+jj3ziLRLynG+wa+K+2Apvi2QZl6via6pOPc6M9QTQ=;
        b=wN1bsMWiP6cfkrspbSliVkJVdXHUzbvelQ9UgJA7K/pxkTstTnPNAgkBAdSIxou/WT
         OKB6SRCwUgdJ0SkXanCaajP6qu1KAUcxnMXLidF2+EgKFTw6XvuCDIgk8OB1+zCwJv/Q
         Ys8FJ0V117GT7lSXvBbBgzHcDqb9cBZNQUMjFKosmnle3zXXwVDysI+C6tsURjl1FcvH
         IQ1gY3fwddWpYkUXptvKG12VAscElHoPckSAEpwcJi8iMFx4xHqe3tfKyqo0YTEbzySk
         dgw1mdJQuHZtIoKUDZwrgfFdo1/H0lrE8FPdUOivEFEc+gp4VVlkxWVB8+96VmGjHey2
         bt8g==
X-Forwarded-Encrypted: i=1; AJvYcCUH2IMtlWUDUfHPEvsAEsuzxWzdshVk0lg9bTterY+g4FNEKSt5l1c95QSBtL3yQ0g5otuZ/d1zuVU3mZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cmHRQIsdfuTR2XgyE06SdMVB9lBqSsnamyCuvDOkxTGmCg1k
	Q5EF4jNb8uy6fBqXhM7OgeGrSAPZ/gerwj0n4eJGwZxYHPtEcqghm2c7+3rZVjM/7kS2VVsh9g4
	KtdqquIzpU0Y/WLLnOYh9/wOf4yT+frI=
X-Gm-Gg: ASbGncuZdA9mdRPTZYadhVlAmCAu5Jnn6uds58rTUq1RarADCpjrxRGxZA8TXikmpVG
	M84qiN4QYlEFd2lnVhpu7w8eAKOipufMeldqbDOhgVgtSWCUg8VhvX+x63gkhFtuQrD1CM2J6Y4
	OH2rJsxclznQSCQ/6jXUo78CBAGZElx7KaQpK+FyzJkhLV1LKIx+4440PeUdmP6yWUvIR6qq7Ok
	MmJG+EDuWHRjkcNoSixYVueE/fH6NRYMZCkontu8nhN2ZnpU7qDSkDffbBim8DHCuLjwoPXDSA+
	I09du5VghGEC3Ig=
X-Google-Smtp-Source: AGHT+IF6ueQYBNM1+RNhYOYIFnfLiX6oNuy4l48G1lx1VU0ywiXQgL6tqvYLuu3FO24uXys20ArxBAmkiPLr3hbeIKw=
X-Received: by 2002:a17:907:d26:b0:b04:6546:345a with SMTP id
 a640c23a62f3a-b707082bc03mr1630568866b.52.1762246630824; Tue, 04 Nov 2025
 00:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
In-Reply-To: <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Nov 2025 09:56:56 +0100
X-Gm-Features: AWmQ_blcze5b2JDvf6rk7zu8ZSgiylBvNU6Ne1vkeCMvYkjZxqkdx2SqKkvxo3M
Message-ID: <CAGudoHESYkHNdZZ5j1KfZ3j23cEvPZUNWVuc7_TTKds=qNWt6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:25=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Mateusz - I'd like to just credit you with this, since your comment
> about modules was why I started looking into this all in the first
> place (and you then wrote a similar patch). But I'm not going to do
> that without your ack.
>

I don't think crediting me here is warranted.

I would appreciate some feedback on the header split idea though. :)

