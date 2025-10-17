Return-Path: <linux-kernel+bounces-857595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A320BE737C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2AD5E622B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E029BD81;
	Fri, 17 Oct 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="E9m0BOgI"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540B286411
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690251; cv=none; b=q2KkACIIE3KxuyRqc7u53ytKzKK3O4mu3f85Ww04ho+2iFhjuivQxHiZlJ1SeLDYL2Rar6TKBpviKqA8mdUkCnAZierYur8k7A8woCm4eQLsTt9WJgfjuYdGCtQRcAzjil/ED2E4LRZiwwG12qcd2wttgc7H8xDipkZqczKnAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690251; c=relaxed/simple;
	bh=4gBHm0hg/izrnX9TOrYcTxdW+FZhrbeI7DucFVe4NUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUn6dsWOTq/POxowzr0hhnZZL/+OVevvfxNUruzrobCWYNLhnlPFQSa/j8j7mbUGxq5hm0GiMeUyERzi2j7WASP3fChf4T0g1OsqDg07Y1vd0Xobhvnb7PQU3e5kjZP3BhgtXJj+rwrCFyydpxWNhgHkyqkqLEAsXGh18T+hR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=E9m0BOgI; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-781421f5be8so21388297b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1760690249; x=1761295049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEugzOHABBcNtf7WRv870XNmGYg6euUpqckoSgZhyIg=;
        b=E9m0BOgIYXjSnKst81q1r7r2jEEItDNv5NKuppLmZAwiU6rzYKTg+JvP5HgqXYGqbz
         9dUwaSq7draPqDx962qd8xKEUXVR3kMSjTWr5sfhTRxb3c0iPqlN1ujxzs6Vgr8UKzmf
         qwQy9uQsvprIPH2cUB8bKYIdgJdWUrY38Yy7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760690249; x=1761295049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEugzOHABBcNtf7WRv870XNmGYg6euUpqckoSgZhyIg=;
        b=gj+xHSzvUYs9Uk0A5A8LEeGq41LHqcjTP0eQsMZoSLdUfF7ZAk/CkJ11Ei4j+LDa3I
         ngQkjP5D06aQUUYRi1Gp01sA51x3cIgGrqHEeGd3XUK3vwhnrjYf2zHalA6j8OeZzubN
         xU+ghLYLKXLSJndXpMER3TSwot7Tvvbjhx4VqIFhT2uoalgvTKfyoi7s3qF3feoG4XAS
         ULG5goHfKsANI33L/MUMHBgU+AgD5BDHYPWgd5AvCR6j/+3NVyjTW29hioHqDE2iAWaq
         Es5nTi/u7MTXuAKihrRym2CQI6VFKL6V1CQwQ7338I8oWmtxpsT7JZi5QFFr/2bWafzo
         y5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUmqEr3b4HBbeaTNXH0pNS0H1E+S1gWyJNpAT6EtV2LJ0YjkcxZAtNG104RmVPct8aYD6SswyERcSqnJ6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoERhgTsMyOW+crxfINHzx03t6Xj588WtbX48xIwIK8GN3yhQ
	AfLoXMfjpCHzY13BKTqFRnBOYLSC/RB5msAAarpX4GQjIMhcbnMpDpbIriqDZNLndIY7t9qCyYN
	/y3npZzHrrkgu/3a4WvcsSrumbwK6aQblQ/SK6pGH/w==
X-Gm-Gg: ASbGncuykCNX2/MK6OlCQ5/RI3yxpVpZ3q6NAAui2//iUlTerEXg31Suwr0WUNGTCNW
	NPaoqb9Pl6SVY8kRiK76mPC5alhJxtXoY7FhXf1R3kfl0444uJrkJD8sfbi6kn3m7egfbVBWI4u
	j+sXzW+APAeJF7Jd6hrCxEOoPLLQOsICshuDxlfBRHqALVe1HWc+fiQednGUMjfq5s9uI0ggtIn
	i7tKcfyjfkis5Zqz84fs5cwYLPG3K+d95t8zXtCKWvy8LCT/aDd6APbCfj+XjITB7fgJN6qhwJ/
	w9kp5XE5jgCSnCfE85LwEfI4aC0S7A==
X-Google-Smtp-Source: AGHT+IEBawDSgiE20pPoTet4nKGmNqzWfwqDDZv+tdibV8JI2CAptyqGAH85n3YwH/kLHb1q2TIij4NCoDlZL2WIN2s=
X-Received: by 2002:a05:690e:400d:b0:63d:318a:efb4 with SMTP id
 956f58d0204a3-63e161f10b9mr2335639d50.63.1760690249015; Fri, 17 Oct 2025
 01:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007065020.495008-3-pavitrakumarm@vayavyalabs.com> <9ba77ca2-7b22-44da-beaf-dc66801252b5@web.de>
In-Reply-To: <9ba77ca2-7b22-44da-beaf-dc66801252b5@web.de>
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Date: Fri, 17 Oct 2025 14:07:17 +0530
X-Gm-Features: AS18NWDmYVv2zfDmUEDPEl-EPatrNn-j8Tww2-bbNu5S-jqfIjsD5sH7k8FMEBM
Message-ID: <CALxtO0kbD44Ek4mUoW-0i+5H6FUyzeOWru7Lqckj0j9Yrzv1=w@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] Add SPAcc ahash support
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>, 
	Manjunath Hadli <manjunath.hadli@vayavyalabs.com>, Ruud Derwig <Ruud.Derwig@synopsys.com>, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Aditya Kulkarni <adityak@vayavyalabs.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, T Pratham <t-pratham@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,
  Thanks for the review. My comments are embedded below.

Warm regards,
PK

On Thu, Oct 16, 2025 at 11:45=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> > Add ahash support to SPAcc driver.
> =E2=80=A6
>
> Please choose a corresponding subsystem specification for the patch subje=
ct.
PK: Ack, will fix that

>
>
> =E2=80=A6
> > +++ b/drivers/crypto/dwc-spacc/spacc_ahash.c
> > @@ -0,0 +1,980 @@
> =E2=80=A6
> > +static int spacc_register_hash(struct spacc_alg *salg)
> > +{
> =E2=80=A6
> > +     mutex_lock(&spacc_hash_alg_mutex);
> > +     list_add(&salg->list, &spacc_hash_alg_list);
> > +     mutex_unlock(&spacc_hash_alg_mutex);
> > +
> > +     return 0;
> > +}
> =E2=80=A6
>
> Under which circumstances would you become interested to apply a statemen=
t
> like =E2=80=9Cguard(mutex)(&spacc_hash_alg_mutex);=E2=80=9D?
> https://elixir.bootlin.com/linux/v6.17.1/source/include/linux/mutex.h#L22=
8
PK: Ack, thanks for that, this is much better, will update the code.

>
> Regards,
> Markus

