Return-Path: <linux-kernel+bounces-846134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C77BC71F5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A757619E4734
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF2185B67;
	Thu,  9 Oct 2025 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRUBcHKv"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12BEEC3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973927; cv=none; b=TBZS9LrJ8nuNtp4BTIxQPUke3uOg1q0+OJB2cv9BmefeQFRKqxgKgLaaXi3Sw/2ELhPe6eEobjQA98tPv5GivQd67o1j14FnXaIyVzf9+MwztMEPAZI/fz6HwHXcZQRWUynlgDS/3cHi+iPuC9vLDOc6Z5mDCcRW4bCW8SEURtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973927; c=relaxed/simple;
	bh=6nrMOtELpBLmErAHhpvH82Oyr1lIyTdGtpID2+/TO4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+FAnkRcDdYsJEQ3ol6ETlZYkmJQ2dScOTA5MpWkQzW15ne3Yi1TgtgTP0HihrtS0wxjCPuTpau9xUA44nchU95wclja9nm2ORXGekdSmiv+eEb42HKjabhxpFo2R7vmq1gCv//OkJUuYyM03UYlMZExzAgquzRgR0wmyuDj7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRUBcHKv; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43f5ec02724so122516b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759973925; x=1760578725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4OU+6d4XHNyYe2vaJ5HulojqcfOOX6yJg+zBKOwOLk=;
        b=NRUBcHKvdojRU9zvreLo6dbEvydIgO2z0lHNqHPTWnyxP5/+HnM6apXvHfnSRii//l
         J9edXS8ilHtd5VAs9nXqbSUgDnV025uucHgu66ovcBX9RHaA5v7ShhqqAsqBidrprFGV
         902LCc3SOK0Zxn0QS9yHBDnvDhwqcDqsdWfcXfuFARwkyD06ZlsBiqUURX4h2H8tG+vO
         pvc2zQA+T+mSPQA0Tv4dnBBkGHX0jmB8bFPaG+T++4DrAgwaUIHhoNE8uvu445Tcs4ts
         De8aij/HmF3M9S2f+rt3gP1lfzchSY+HJ/dtTvkPm/7UwfyNGK/6dMJT6M4mEVIM16be
         dqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759973925; x=1760578725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4OU+6d4XHNyYe2vaJ5HulojqcfOOX6yJg+zBKOwOLk=;
        b=qoFJum/15ifiE6LRkhKYi2nLmROlZs6+GfJkhRdD/ov5c/hVTzbbliD9ieZgl2MN9k
         NZwh0ReJ49a71thlRYkW0T0hw9Br/ZFqAel5uZISv4VI0Z1P0kgDUBXzEezXdmtiwrZH
         v5/6lD+6HBiZ1wXIj7Arz8d+FB10OVyP69x6zk+vQYbodOE7XXT455aGVKinxtHHY/GF
         Oh1QbQSav5FGC2Zf6NGKh7PP6VuAw4KzYCZXRYsDwIDGLoiqiLziAiaztD/twTKooc3n
         TiQryXveZqaaJZSzYPW1zmGaoagR8w7I026L925naN2AlKWugccfFevPFfkzqTjlPXs/
         CF1g==
X-Forwarded-Encrypted: i=1; AJvYcCVxLuVHwHviEs3qoppQp1/mTqvKsZnrmKUPmd0zdErqsqYQdve7EeU8ah+1UnTXqS9ovYQwsg9Xr+/kn4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgVRaNVf3d/5dMJFvtHXekjPkc0skArASTUb7HOrdEPsL8FyI
	VopZxqUCJkaA/snwBASH2dYgc5rvskcRD0zvTH8pJXcwRdxJEhV/nVmQwK7S0uinatC5v4r28eg
	wWGL6E4xstCPn7HM7jTcp7H6PEI++D8M=
X-Gm-Gg: ASbGncuQKaOe8wRmB5DNadtBaKkdzxd8QdalqhJZV8ngBV4ytQ82kLs79Hty8ylkopl
	B2YGtvVc5+L6S8Oqj3KYT/RUOwCe/3ZBokrqg0PIkVSemLgYk7pH0iwJMQvS8T5kR19W84PJjp/
	ppaUNUp6dcZ2VmUBJKO41c4wpMLMFH+CJfPs9OigXsbXNcFvM5wPr2UvA/bNmGJox5UA4sxmjD2
	MhjnI7jR8F+qvn/KeiUbFmoXaYdzIU=
X-Google-Smtp-Source: AGHT+IEoA4Bvx1E4ZcP6qArxORWElQD4CExZH+e7IkeOBTHua4YCh9pjvgZBR17pP7bTL1f6rCYOx0ouIUFlq8ENpj4=
X-Received: by 2002:a05:6808:1909:b0:441:8f74:e81 with SMTP id
 5614622812f47-4418f741a75mr130795b6e.59.1759973924521; Wed, 08 Oct 2025
 18:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008162719.1829-1-briansune@gmail.com> <aOacZAiWxG9XfWLS@opensource.cirrus.com>
In-Reply-To: <aOacZAiWxG9XfWLS@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 09:38:33 +0800
X-Gm-Features: AS18NWAU7au0dqPFWIf36aNFX-XQyhsxQx8vzY3DKLyxxYLexG4DEIy-dDxCkNQ
Message-ID: <CAN7C2SDa2WXKVw6XdR+2K0nAjkjy3JH6e+h7d0i9wDNyoXEyBA@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:16=E5=AF=AB=E9=81=
=93=EF=BC=9A

> [1] https://www.nxp.com/docs/en/user-manual/UM11732.pdf

At the end of the day. After refreshing myself a bit,
I want to cleanup what this document trying to proposed.
From beginning I am very clear on what I am understood.
Along the discussions I am been mislead  by this parties
as well.
What the standard about extra bit is ignore is not because

1: BCLK clock rate allow faster
2: BCLK is not relayed by MCLK and LRCLK

Explains

What IIS inherent design.
1: in order to form a 24 bit counter 6 flops is required.
As such then counting 32 / channel hence 64 bit.

2:To divide BCLK to form LRCLK then this 64 ticks are
ran. As such when a 24  bit data format is used, extra
8 bit is ignored as such division can form proper bounded S.R.

3: With this ignore bit method less die size power on VLSI.
Simplified 8,12,16,24,32 data format while LRCLK vs BCLK is
bounded.

4: As such, this is no the concept of overclocking
BCLK to fit all those how argue about BCLK is faster to etc.

So agree to disagree. I never accept the concept of
overclock on IIS. And this is not what bit is ignored intended!

Brian

