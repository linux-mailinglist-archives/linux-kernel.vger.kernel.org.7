Return-Path: <linux-kernel+bounces-845845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA625BC6462
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891AA4061C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C492C031E;
	Wed,  8 Oct 2025 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT0lW4ZL"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3392BE625
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947789; cv=none; b=tgjfOiY2WoWKvKozhV9skqhvq46TCh9cBL83vj0yMix4IcrFRCP0Oc0WUzSuK2IVlZYHk+99Wx0CaGEA0+ZPx5vecSU1K72vKUETwwjdiv75s0FxLy4vRFa0dzXjiAlntqHXDUs+gwlKw7li9teO//LaDF3ADV92I9jM4P7SB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947789; c=relaxed/simple;
	bh=8o0ERizFXg9tQ6mp45Z9VNxyn6R+iU06p1tWE7GjXvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT8WY9XSckY7eNRGeT+MXEWnK+mB95hfVhlS8aYWbgvyd5wVSe0uhXrPSXPLxMwijl+/spbyI6tYD9cw5Im4CkO1QF+W5LATI65o5EklIA6kXVaDPCa1L5IeGIcaehFOAbhaunKvyFHX2JVWUB+5pPCKAluVfsX33od7M4gaEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT0lW4ZL; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7b4f7a856acso65536a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759947787; x=1760552587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o0ERizFXg9tQ6mp45Z9VNxyn6R+iU06p1tWE7GjXvw=;
        b=MT0lW4ZLCdzc+cO6dFvodTG52xFgEBlZG+XtX2XuZblr0JRoBiBMVQVyyUL+g7VE2J
         1kSaC15MK61VCD6A2+chPlHYOdN5kfVUqO4vfLS6GMgwXGiCcRSAJ7uvPFte5G0+H5dA
         WDB7vpU3186MCE6LH437zA98sm8qYMfjox70rscqRCYEXZ8HTp9goPqUVTfzE0yyE8Mq
         cRLYGkkhFSbNVClSzSyv/y2eMz9Q1sS2wKwC3iROzaGnFvxFPK7a5FctF5RHKA65A/DU
         84lBwrHorNWxzz0Cw6Fnk7tciOdPAPDaM8/HYjtbPRXDhawElW5/Ij8RQT5dYhgrJdfG
         ElPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759947787; x=1760552587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o0ERizFXg9tQ6mp45Z9VNxyn6R+iU06p1tWE7GjXvw=;
        b=PUJoe0GStlzHFCJt85gqOBJqkYmnw9xPdv37PoeiAqHmqVsR2uf5HVE0pwyph+OgvG
         zEW5IFqm4VBsIOrj79k1wSovOWqkwADDa3wLqtemlRFIeryPXajy21HfbLajiTHCGdzT
         qbG7XpUcI0AFEomCKbW2VkbEkoAUDry1hcPjo892s55DE8W23AX3iRtQofrhAz+CT4Nr
         4c8GuHeJeW2vWzAtO8HYTs3LSNtV8yTfiE8fucwmIesB94ZrtdmE1bOqnzLcXsxf3YxQ
         GEynBYYf7qPToOS5JGNprIWNSQhbCpg1cgfDnFXDfJ5Lfy7hbGDzuwXpjMhxAfjH4B0K
         +pRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGpQM7rQgE6B0WELnYCQnRrU4ktdFEkN2cxzWaOBq4gvGCnElg1PZgj21Dt6fq/zPEUSU+G/hje2xTrQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7A8pSK4YaLX/rhWr5dwvjxQVQUf5A2JwlIBy4Txi7v139S60
	tTbOJqfVwc0lqDOqxIkTCGgtXLSz82VcdI5jcyqXh6zH0Zn05qXOUGEcVyqkskqfIwtpO64wnHN
	Vay87qO5Z5PcRdZCmiZGM347oeNCFx/A=
X-Gm-Gg: ASbGncu3xNekG4ZlBEuZc/ZxOzGqy936VrDzH0aqzhoeGfV/FJfaVdRvrxEBLHSYaAF
	UbK5Kb0xx7uONERTtilVOu8RSTylNBp7Vw7tr6HCZMLptRrYcBobyUE1o8SJYiiYOcNAtlF/nQx
	CcY4E++tLJLjOEBxhxrYY0xeA4uXAir7VqcwVVFS8epV5TjxR3NllSyTF+s+28p6DaK/j0R4+5P
	fpawT9q8T6PPn9zfDbiMlA2w+vC+AyOZ24+2l8jBQ==
X-Google-Smtp-Source: AGHT+IGlHWF7SenOolgvsMcipgRUTSyamM1J9Jst18pLHT6HdfO958LFIthCYm7fbyHNpY/bgurjNU6HYb7Q+CBLUr8=
X-Received: by 2002:a05:6830:82e5:b0:758:71cd:895a with SMTP id
 46e09a7af769-7c0df813c44mr2742922a34.29.1759947787358; Wed, 08 Oct 2025
 11:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008162719.1829-1-briansune@gmail.com> <aOacZAiWxG9XfWLS@opensource.cirrus.com>
In-Reply-To: <aOacZAiWxG9XfWLS@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 02:22:53 +0800
X-Gm-Features: AS18NWDdtLMMhTyVBTTV_Mr2TdJ4PmgJO5yITqcq5HAgWp8Jw6ulyIwi6f2zZ1E
Message-ID: <CAN7C2SCXibPFB50TfNLxmwf--wPVUewNQ1LM4T4fEy2Kioo=sg@mail.gmail.com>
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

I am curious. With this codec WM8978.
Can you set a LRCLK rate that is not relied on MCLK+BCLK ratio from
first place when codec is in master mode.
Can you request a sample rate that requires the concept of extra bit
clock arbitrary higher in one extra order?
Very curious on such idea.

If possible maybe some examples can help.

