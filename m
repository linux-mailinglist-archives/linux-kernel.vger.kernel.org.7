Return-Path: <linux-kernel+bounces-845788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86CBC61AE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3EE19E5352
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1342F39C8;
	Wed,  8 Oct 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alqEeZh7"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F12E9EAA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942715; cv=none; b=TDJppRaIWHqiOvm8yrHi0vLNXlLU6zvH1IHFv1M7/9PjxnEEFFPVuqcg0aTY9mQ1s6oFrMWI4W7JjCTLfU1gMWVNOyG4wyow58UhIt5Yj3z+1FHssa2/YQNvtZiWsbbVOSlBIzZAS1PtF/ozS0JDcgt+/Ch953zKy48WfIrO02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942715; c=relaxed/simple;
	bh=sJYQ1HJnmQ5odfjaAz4LPznXnWsyKF0LcwZ35Z86QXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az6gW1+KjKIKkGwbAg49FGYTKOoYyZAAJaVrhfP6vVEN+9G0ORoejRKlBZQK/NewBwEv5rQMRuVKyj1BWXzc6Wk5daHcmCRdJsHoooINRiyggcvq9PgHOBUHdxgThRyvQ0goLWj56nZ3LOyvORVXk/4iRtwKDsgPcgAtVY0QWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alqEeZh7; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-79f79e37c04so50555a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759942712; x=1760547512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJYQ1HJnmQ5odfjaAz4LPznXnWsyKF0LcwZ35Z86QXg=;
        b=alqEeZh7l7T5NBdewUY7JFt0ZI3QCatAMiMTwPiyVB7cgiFKLeDPs1pXPOuMMAu1hj
         J1ZG3ad3ombChPQqmTfOno3jaxGn7UEUsvNVCN8RJdgwoMeAK0VXUul3oQ4ZOexDCmXF
         UFXnpSBFhSlDdvcbJfavzBKwOy0lVe/44ggGV3/Gfp0yMjfwz9AoHW7ofBg77Om0mLCw
         VNB1P6nAoY2irCJMz7a2TRfKN1pSA/lhW8ilfZ/alpTin6uWDhBa2sEL2G+5s1j07ot+
         PIggIDgzmd+EpIyod/fCnNtdBmxeLGVjkvvyPaT8wnjPY6fJl+5QF+6RbfhfsTeMLKvE
         p2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942712; x=1760547512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJYQ1HJnmQ5odfjaAz4LPznXnWsyKF0LcwZ35Z86QXg=;
        b=Vz3e1mhQkxgDJHHFYlazhUj8T3QyWBJxpMiZYoi1anvTQgjRfIxDoBnPeXQ4R46XN9
         xTDQRj+X7Q38NR/W3V7W7McwtYG/xdMI5ElTP5nJ8erj5c7o8yQntv3/k8eEwgihUjpr
         9C8gcE4gJBB+nNMpA8Bh5wiUkphwVWV9dyDWjqi74C1iyhKWl4ZT4lDWdSqoyVDxdYde
         1ckBOVwa14ZANDMahpPGDf0zoMxfGoAtkHxcp2eapH9N6htAhn4XEFZO5bqoYfgs7A9S
         FzHTxGj67T/Xjq4Fnlsajx0mPw0ofc9wn91JEaCnikSXpcTV3Es4gJzQOu+OH6suO/7M
         KDZw==
X-Forwarded-Encrypted: i=1; AJvYcCVEtr1jTvjpzqTsW2x9NVHNgwMB1EUoYlJwcuBoJOuCgXryI6uLkJgg448xNScqDDJgwB4xmjLiROa1690=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBjGNI8h9GcGtVxbzOkh/6hI7kThxSpKINoD6awr9M/xx/aOl
	ktG03oTb63apQ0rotZ6bJ+0w24tuA3dn3s+4I6zJc9lPGpvNVIZPTOWG0XNAjZGa8u01fCioX84
	b6wc813sfvE1sHGjlNMzngjYAdRlLbgI=
X-Gm-Gg: ASbGnctEfFZh+uSeQ7jLAI+mXO00gwcmeSTAT5/K8NTa9GJwTDuZuy/RWqOz8/M/6pu
	Olw9S3aNSOxhD5jnA0JSXz97zRdSqMXpeqBtfTF851Hsci8nEtGtZo3P+y8VMDUIRemKRSEd/Li
	QgzwchIusXea0RBDMD/baIPRTN8rF00FtY8ZCpo4NfFmEOzCT0mcuXE2YyEuIKDna2VfQRkYkUN
	tPFMpHrIbJFlpzv7sxQQ6EZYwOi3II=
X-Google-Smtp-Source: AGHT+IG2vvJj9wBrBgytS/7u2V7HiM4xVrVDuJl/IHxrxqkylGm+rIGdQByMnc/GkSWkP3WikChxE4dg0y9mSw8tzFc=
X-Received: by 2002:a9d:73ca:0:b0:7c0:e0a2:661e with SMTP id
 46e09a7af769-7c0e0a270b6mr1397210a34.3.1759942712413; Wed, 08 Oct 2025
 09:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008160452.1741-1-briansune@gmail.com> <53ba5ea7-ab5f-41dd-853e-2e39efac1321@opensource.cirrus.com>
In-Reply-To: <53ba5ea7-ab5f-41dd-853e-2e39efac1321@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 00:58:20 +0800
X-Gm-Features: AS18NWDxEqn1DXHD23DqZcU7_lvdpqATneJZ-9GotKJaV36ym9HlSG_tZkOI3DA
Message-ID: <CAN7C2SCwz1YwYnAD7n=t8hUxME=hihqeF8fYBtvadHVJqj1a4g@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: wm8978: add missing BCLK divider setup
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Fitzgerald <rf@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:27=E5=AF=AB=E9=81=
=93=EF=BC=9A

> If the _nearest_ BCLK is < 1536000 you don't have enough clock
> cycles to send all the sample bits.

If the inherent design follows the original concept of i.e. IIS.
Then the comment of not enough clock cycles to send all sample bits
won't even exist.
MCLK -> BCLK -> LRCLK.
LRCLK is always subject to BCLK by channel # and data_bits.
As for the BCLK is always subject to MCLK and oversample requirement
or codec design.
w/o MCLK rooms you cant do BCLK w/o BCLK rooms you cant do LRCLK.
LRCLK itself is always subject to the original clock frequency.
This is why there are no possible idea on not enough clock for bit load.
BCLK divided by channel * data bits itself must be hold.
Hence the result LRCLK aka final S.R. sample rate either is fasted or
slowed is what it is.
As there are no possible way to generate a incorrect divided result
when mclk is not supported by some S.R.

Then only result is S.R. is slowed or fasted based on the BCLK but not
because you are targeting a S.R. aka LRCLK.
Which result in BCLK is required to be faster.

