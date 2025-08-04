Return-Path: <linux-kernel+bounces-754785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE8B19CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB94176BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35023909F;
	Mon,  4 Aug 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RomulYfm"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2E22A4FE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293005; cv=none; b=ifNB8Lz0Tqqt+Fu8Jb2lhCyRVZNLrK9ghA7MnOVWsTWIKb9x3BvKAIl2eE+1vbZ289ErWhBcouv3ccBTp6nBGUv0mwJvZyvBGrMXzex06M04Ff+ODovlPGs2SBLs7AANqOdX39/T7x7Z6qb150tG78bmjVZWK8MPKnQrjZn9m84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293005; c=relaxed/simple;
	bh=3Y/eNwvB5ILZs5E+ocvhqUEyyEQJUHJ6l9mncbf4LIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzfP2pUKdAND8o4MYbRWM3OUpAigxx8AOEPU4+Kgff1iuTOpyRgeg5Tt8mjO4kCcPJBNUsEJMH7/XAWTBYhznN4Vk9o7yuL8z4OA5pV9hZZxuwaPNCIkA8v2KkV0421JyQJzKw3teKe/ooMUHRzKrxl3iCOZF/kMTGul1jtA4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RomulYfm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4aedd1b006bso40956571cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754293003; x=1754897803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ooJeoXgiNxmCjKQ3/NUiLCRPH/OBbBVxn1XceNIw4=;
        b=RomulYfmI35IjwyVZgiRfu6BIDfdWhbud076jZv7v3uLxOhPIHU75fiDPCCt5X01gT
         XkKntFUf3wN7czyhM3OXc9YttnxOptB+xA6iSwOEwt6CxnQIocMQX/BbRSa5QUeXUZqX
         0t21/UbsWGn8tBdOgN87j17XabVu9i2SnWCa7XxjHSIVlVuIP4Bm+fy9xmQzsbpKaFfd
         i1M/wxuDpLDqUMeJQahOsRdjqfHPrQ1/QhmfJF7YGAK3BSrhFE0bx0DTjnpEbBmlepBA
         qNPOkjLujrTxVlIBh8RxLt8dzPtlBCBBTPGZOMz83HPniSN7qExQQJpKyi2PynfjfDF1
         3E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293003; x=1754897803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3ooJeoXgiNxmCjKQ3/NUiLCRPH/OBbBVxn1XceNIw4=;
        b=t/GF3g+O9D8ga5pbGs9qsYDJS4Q/hPbY4nLeBF8fj5gjMnPKZrK5kUwQDu5u112Ish
         my1UzsISILZIAHUbfn+ewmnSR/EvcE7dx/e7ogVv8K/BSPrzJk4CjSLftubp8q5Aec4H
         hexRe7XWbA34qrqDaxoiu1mfkTfmxECWPGA2OfpD+oEuOIMFyMMDkaKgSPX4wISKA+Ms
         cwG9Bz9Qcd3iJSkWVACkgXMM9KGTj/1eBISVjHxp8KtoUVgc0DL0V5SMSvSv8OqNWxtx
         1L8FOssb3HJPkj7lgIWQk66o2oSmW87ei9EOfurHN5ZxdHJWYBVerjQD56VnPs4dNIIB
         JnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Cgwgpo1SiYumDyst5wSFxil1kxM1dWSatmtj4AH424QxVPrCk2Y53nQnL1PthnxV+7OegnDFUETXNOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFazKwlq6BrGKZkke3TOIL5Sef4sjH7Bg7vL9vkg2zJTTMbiYM
	7PEBk2klm48rvQntJtLu7QdLTuqIbnw/HXG5MAdlBHy5dPbthsKjsFheZfJKSNj7zl81mvdtuq3
	MA9Hj0epDzGZm6YHNVAhGnhcQ/m8dzt5UxIy8eB+b
X-Gm-Gg: ASbGncuNU82LGDT1iLMQsP7d4YW9vY0qxHYRTVFFuOyF2p2/NTb75t+vjgajEIzwAV5
	C42FgpyD5SMWlsfZXCd6vx1260VYBE1nFR5Q9owq0dtfRbSXvkwk9wI5qW9xvNoMCsu3TsDeOJP
	Pha+OgukYCcb+zrOS9KtDYogcNkP9A1RdqfP+obwyezII7pH9CDJBbmtBGH9kNAWXsrZsml8DHh
	7wbZTxmaJGju10=
X-Google-Smtp-Source: AGHT+IEoCUer5WNytH9wVW03O++C/FNr5V/5RS20GrME6Uk6NXfcgbALruaSrPF23gegV0XuKZHBdOlmBgO2ep9Ykx8=
X-Received: by 2002:a05:622a:15c7:b0:4ab:c00c:250b with SMTP id
 d75a77b69052e-4af10cf33f6mr122336581cf.40.1754293002922; Mon, 04 Aug 2025
 00:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804062004.29617-1-dqfext@gmail.com>
In-Reply-To: <20250804062004.29617-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Aug 2025 00:36:31 -0700
X-Gm-Features: Ac12FXznjO0BdtnALtDt-VPl7bSJs2FnxBEs7TFJ8fwttr2To0hldVsXZK8iBas
Message-ID: <CANn89iJ3Lau_3W5bJdmRWL9BFUf3a40XqNgfjr7nCEu5PQ_otg@mail.gmail.com>
Subject: Re: [PATCH net-next] ppp: remove rwlock usage
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 11:20=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> In struct channel, the upl lock is implemented using rwlock_t,
> protecting access to pch->ppp and pch->bridge.
>
> As previously discussed on the list, using rwlock in the network fast
> path is not recommended.
> This patch replaces the rwlock with a spinlock for writers, and uses RCU
> for readers.
>
> - pch->ppp and pch->bridge are now declared as __rcu pointers.
> - Readers use rcu_dereference_bh() under rcu_read_lock_bh().
> - Writers use spin_lock_bh() to update, followed by synchronize_rcu()
>   where required.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---

....
For all your patch :

Since the spinlock is now only used from the control path in process
context, what is the reason you use _bh() suffix
blocking BH while holding it ?

Also, a mere rcu_read_lock() is enough for ppp_dev_name() and
ppp_unit_number() : No need to disable BH there.

> -       write_lock_bh(&pch->upl);
> -       ppp =3D pch->ppp;
> -       pch->ppp =3D NULL;
> -       write_unlock_bh(&pch->upl);
> +       spin_lock_bh(&pch->upl);
> +       ppp =3D rcu_replace_pointer(pch->ppp, NULL, lockdep_is_held(&pch-=
>upl));
> +       spin_unlock_bh(&pch->upl);
> +       synchronize_rcu();
> +
>         if (ppp) {

You probably could move the synchronize_rcu() here, there is no need
to call it if ppp is NULL

>                 /* remove it from the ppp unit's list */
>                 ppp_lock(ppp);
> --
> 2.43.0
>

