Return-Path: <linux-kernel+bounces-845964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359AFBC695C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE60419E5071
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC9299AAB;
	Wed,  8 Oct 2025 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSf6E4Rs"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03228E59E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955248; cv=none; b=la7OSoU9Pnl6WxqDkMSv+vnPMP++j6MXveR0U+wPH6RDUiBLj618/eHZ1+NmRtHa3ctA/aIvbX0VQ8EfKJLRT8OvtyrTgCzRdXhjmlFxYpZSfs051iVeA0f0k/tpBJkC2+TM0FuxKFtHqxyk04x29aOlR/4M4MfAl/PxdtXz7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955248; c=relaxed/simple;
	bh=mJR1IPlBUZmBwh6fQKyRf97cCknjaSUAHQjnhdD4aUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/h1k9RqTYUEkAQlRbw1AsJZrXpPcszU53QO14qGaXcjmnlRXlvtjj8NREG/5oehT2Hz+aaVF5HcH5EbmyWG6Z3E5tSsPUw81b84C4ntl4pkXsuAZufW/zHM9BSOJvsH+TsowCBFSXWaYbs2HES5NAewY3h3+wc+KdQ8C01+vx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSf6E4Rs; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7bd8909c682so170568a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759955246; x=1760560046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isCw8QPBufvNnn+xXpaO0+hKfXBnUa6iPfCajSX0U/Q=;
        b=eSf6E4RsFyXkNMNgR129QIefvA7yv9QUf4+NgtfBALsfNdqlAIVnF0QytCf81VwAb8
         3Al2IQlHlUV7D7j+1OhOJG1l9uKPXx0duT6Ch7i+XBs9Mlb6VO5fIH8aaperG+JNME7J
         tni56NKPNHQptPq4mF5EMrQNIRhNN1XS3eoaQV6e2URWcX+j6m+JWNfNeA/KVBIYIxHP
         3JKQfql94ttm9N7lbcoz1A4xl1as66N+a0w/nHpsjbY5DW+Bo4h1h1rMguyAFZcRQUrL
         XUUv3kxPoalhvGm5HN31IZuT8Fc2RqP2CnyHwNfg/ifHbwLi29FjgJLYpAKXmXt8n0Cl
         0xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759955246; x=1760560046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isCw8QPBufvNnn+xXpaO0+hKfXBnUa6iPfCajSX0U/Q=;
        b=KgQsIoe5Gm1cqZoyRjuOsiAkO4qnF/3bM89n9+Jipay9rR8qKqxaqz2o8M0BfC+oq7
         5I07FPkfCO/xcNrjMpRy7lavsfRzmxrVO17TIf/fjoipYs89NgRugIaEljYkifHu7kRh
         ZQ35syrVlV4B3FjVW3V08Da/yWe+Oyse4wveZYPcObFF+qHNm5kmgQq9kZyy3TIFnMkz
         x0UKIrEz539lw6kCIHlUUEue9A/AxqQc0aTxPrS0RU3yAUPNQ1F26ijuRUOLc8hZrJB7
         sETezk7TWfLz8cS3rU6cV3bLLemPDM1T8M9NzeSYlTbEKbQqWcC13hSzRiY5CAzpi6St
         XDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU+fZLlnUQcyzNyVSP9wYsZ5C1AkfPfgTvr/Cav2a+Kj1IyGrnecUzvF7Ts1HrkatZiSmYRDQovcyLyDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywit7Up1r/BQIwuHWvcCPITBmGHZ2RdqXGxYOX/1imBkSD/sQBa
	ObjMnNeBy7m81abcHiSvNC/JGCrqVDwcWql6+pWP1tApvcqoElmnY4sFkW36x37uf3Tssar9Z+/
	ccqu+N/mEMSieEthQMl9nan6EHzDo/NA=
X-Gm-Gg: ASbGncvUgaZR4/ysgk9Uad8gblTR5vQh9MpsM+r6s8hu3SegO2iM/CypUwWUVdV1SLg
	0XbaBWluovvBPafueggDrf6wD+H8L/qdUkVUpaMXE1TQFzgOenaJaLVelPlnmQh9MdF6X5AQdjX
	JMXigD26lyMG7xMUDhFr7Vo9mE2v90Dzj6D91uPjAL708FaWKRd967D75wdIyS+171ep+jSGFBn
	A1d2q0P/1IJfTXvOnGZFb0kjftuS4Y=
X-Google-Smtp-Source: AGHT+IHaD47yzjM8aJTa6jivZYQ9lx8Z8J5ZJOEfJYdipZlVRZ7y+YAtPumpkPRg95CFEQJJBbPSnztFz9H0815BBwc=
X-Received: by 2002:a05:6830:6507:b0:792:5c6f:1409 with SMTP id
 46e09a7af769-7c0df72937dmr3180866a34.30.1759955245938; Wed, 08 Oct 2025
 13:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008162719.1829-1-briansune@gmail.com> <aOacZAiWxG9XfWLS@opensource.cirrus.com>
 <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com> <aObHCq6JAHbtTJZ8@opensource.cirrus.com>
In-Reply-To: <aObHCq6JAHbtTJZ8@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 04:27:14 +0800
X-Gm-Features: AS18NWCU6ToQTO4_TITKhRt7wDvXDELe7ClSw4GTr1S9ucLTiS43kgjH1NwssuU
Message-ID: <CAN7C2SAzHkn=nb-FS8JbKgvvF9iDUssEszgnfpY7s4RsPwU92w@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:18=E5=AF=AB=E9=81=
=93=EF=BC=9A

> That said though, this part does somewhat pre-date me so I could
> be wrong. If you have hardware and an oscilloscope this should
> be pretty simple to verify in practice?

Have gear but not worth to waste time on this test.
Well remind this part is EOL far way ago.


> There are generally two reasons to run a faster than needed BCLK:
>
> 1) Because you can't generate the actual BCLK.

Then let it be as delta-BCLK that is minimum error is better same as
PPM concept.
There must be +ve and -ve errors on margin.

> 2) Because you are TDMing multiple devices onto the bus. ie.
>    something else is using those extra bits.

Is this device supported?
I am not too familiar on TDM things are series things on same IIS
sound too system deepened,
But of cause this make rooms for future improvement or support.

> That is absolutely your choice. The patch should I think work
> now, but could still use a little tidy up to remove the unneeded
> code and big warning for something that isn't an issue.

Tired and lazy to check out all these things again and again.
Every patch i run on actual HW before sent.

Brian

