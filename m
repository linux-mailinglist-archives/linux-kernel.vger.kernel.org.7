Return-Path: <linux-kernel+bounces-824238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F9B887A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187E67A2CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FC2EBDD9;
	Fri, 19 Sep 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acVJ5C55"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F1191F6A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271961; cv=none; b=lb1wJHXxfQqIgY+oM9ErcoCsGlI7zZSsubz+2typSWIGyHFI76NXNf7NHMR2nF+sn2jwzJ8NDF9Uae1Ge/3tQItet8I0lEJcEjgR4Bikw+vls3tsdLnhqLEx48efzz0EDFxtPhCOThSl/SP2KU42icVLFCr69ezb3Q8jDEVKX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271961; c=relaxed/simple;
	bh=q82iAOnsb0m6DGs+KumXaLQLxgxxLlYfD/Djj4RV7Kk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nTlqNweB4DVy6ku4jTySLRPiH5YXqoqADkvkPb6RdJFVXh7c6xuS1P6UKRT70M9M9sbMeh2L3lpJXzuVRS/xVypppBnx6+/Jtd2+DmiUD4FkdK3PgqBf9aQKmyCyrqcWusadCXuyvGL0piUE5Hmczw8NaGjaiGD4QP5TcpPR6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acVJ5C55; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758271958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q82iAOnsb0m6DGs+KumXaLQLxgxxLlYfD/Djj4RV7Kk=;
	b=acVJ5C55ixH9f9MQHUFbrRkhLiAKag9GBQWqeOlEO2jyi2FsmU3488wzyhhNNq/k1utiIO
	zUeHCoNOq52kZUwezdmrokDKs6n6LOd+5pLZhtfU/++aKV9o5Yi/kxLOSfTtYgzmd5iV0o
	hvO5nhA3OWxkdUbB1SxYKF+6HK339A8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-yU5TYhvvMqS-Gha9Oo_YDw-1; Fri, 19 Sep 2025 04:52:37 -0400
X-MC-Unique: yU5TYhvvMqS-Gha9Oo_YDw-1
X-Mimecast-MFC-AGG-ID: yU5TYhvvMqS-Gha9Oo_YDw_1758271956
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ed9557f976so1785483f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758271956; x=1758876756;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q82iAOnsb0m6DGs+KumXaLQLxgxxLlYfD/Djj4RV7Kk=;
        b=ZTHFnxfh6SYetDYIXGYU7e80859oTuiYxoMvMxGqgmRkNo8W9Ao9K5VLVGF0UtImuG
         qb/EcLvKnfN+4sv/zJ1ig5Y8gUym3izxXOkr0MxHITTTwagD0fKeO/HBJpRyfkYddz46
         LhhZkWJQaGQ1sfj3/a1HajkX1+MWjJ/0QJrAPTNKlzbqFULo2HCG5fNwfB+ZdbaY7UTQ
         eS7LfWFfMs2yNI7ASlDQ+lwXzjTmR901lFHYNwRyH+9zfkGl1syDm0jNl85LCw65kMbY
         NckieU2fA52mO0yXzKy1ocuCGKxLnJmeW2MuiikiZrsgOXgdfW8PNX5ckV32JK5lGx40
         Jslg==
X-Forwarded-Encrypted: i=1; AJvYcCWP4x88JxoC44VecN0x5tum2tBVnuipnkpK1UuMsigpQKq1k9eS1fx+3GSbu6R8HpSod5wkt6VUt6UToj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrE+rigqtDcErZtaQ0L7mro6em5O6sIMj5pzwqPBYU6UDYipy6
	O9X8w75iJ+oKs1/OVV9AK4TPEjD6eYGc2ln0pZyZ542Qwy5adPrrXfFigavdO83REFVfqrZCKwa
	g8ehpV3I8aCeOwMINx22EYfLw0nMGQUwgKrTJIJ25/RJeXKtSwmmRydG1IF1fz7vkZQ==
X-Gm-Gg: ASbGncsJl/+RouZX/L3zqrx9d2VqM2cGye2D9EkbXNEtOCjE2q5jadnT2+NyXOUsj8v
	a2xK1M9hpJ8uVDSZ8qAFhhn9w8YcnZt09yIgovSljzb70panyCxwVTPskOgskUR/JbR5EyRvha7
	pTZdIDOEv2W2LkvOvbvOnwWGtGQk62+2ir23UgU0bteMulVE0RIDAlovlIbo1Zmlpzva5sG2N6u
	1fudxYMwJ+c8gYStsluUJPJzcrAZZHUpS2r5h/7kt5V8AW1l/q92YyHD0XpPPsxR6avBArD9TVo
	JDO/nGZgwiyluZJxBJYrksskRM3r7mQ7+yyw2/a+3pCMzmxSY7vE2O/M4akiirmjpA==
X-Received: by 2002:a05:6000:2002:b0:3eb:2d8a:4fca with SMTP id ffacd0b85a97d-3ee8a5bf2cfmr1585730f8f.63.1758271956322;
        Fri, 19 Sep 2025 01:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH54T9EErR+ZPtUNWiKXoi49mi9mF74SmM+4pHr2LUVOY5k0BhASnSakJmqeHVL+twmlH6Nqw==
X-Received: by 2002:a05:6000:2002:b0:3eb:2d8a:4fca with SMTP id ffacd0b85a97d-3ee8a5bf2cfmr1585712f8f.63.1758271955872;
        Fri, 19 Sep 2025 01:52:35 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f320ff272sm75720175e9.1.2025.09.19.01.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:52:34 -0700 (PDT)
Message-ID: <e7ed86066c53078ca55c1ec5c47da7b57cf2ffdf.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolas.bouchinet@oss.cyber.gouv.fr, Xiu
 Jianfeng	 <xiujianfeng@huaweicloud.com>, rostedt@goodmis.org,
 mhiramat@kernel.org
Date: Fri, 19 Sep 2025 10:52:32 +0200
In-Reply-To: <CAP4=nvQubUmOVivgzOtYRhMmZaq75WRmRdBnsn0HYJfHHZhzmw@mail.gmail.com>
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
	 <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
	 <87wm5x18bf.fsf@yellow.woof>
	 <4e8bae6a0ada1d52893381e7542220973f0367fb.camel@redhat.com>
	 <CAP4=nvQubUmOVivgzOtYRhMmZaq75WRmRdBnsn0HYJfHHZhzmw@mail.gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 11:48 +0200, Tomas Glozar wrote:
> =C4=8Dt 18. 9. 2025 v 10:36 odes=C3=ADlatel Gabriele Monaco <gmonaco@redh=
at.com> napsal:
> >=20
> > Yeah totally, I have the feeling that with the kernel there's no such a
> > thing as a "theoretical bug", kinda like a good consequence of Murphy's
> > Law.
>=20
> My understanding of "theoretical bug" is that it's code that is
> semantically equivalent to a bug-free code, but becomes buggy after
> doing an "innocent" change. The bug might be more or less
> "theoretical" based on how "innocent" that change is. Of course, in a
> codebase of the size of a Linux kernel, this tends to happen quite
> often, and is not always possible to get rid of completely...

Yeah good point, we are getting philosophical here :) . This wasn't a
theoretical bug then, just something you don't think will really happen (a
failure creating a sysfs directory) ... until it happens.

The fact there is a way to make that function fail on-demand (kernel lockdo=
wn),
makes it just more "real". Moral of the story, better get the compiler chec=
k
things for you (lock guards).

Anyway the fix is now upstream.

Gabriele


