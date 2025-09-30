Return-Path: <linux-kernel+bounces-836874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E3DBAAC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635073AF54E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33459142E83;
	Tue, 30 Sep 2025 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moWNPIwY"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DFDDC5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759191580; cv=none; b=bmbNFrKIAvptAA4vr3ZgsalrNs03T8r876/vZn/SQhj1gtvXCSq+0SS5Y7DxRGX33H1smCD/UdX6eB6oDJ1xRmiuGiR9b5GnVrVdKD2XcQz3A7Dtzu3OT9paZWZTaWzaOL57ZZ1AQIDFAsfu0+RScbcDNb4gtFb8ozaLyy367jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759191580; c=relaxed/simple;
	bh=8iK+tN4D0izXVy+LVrIeR4VyKFqX9lz5pzaqb3RrB8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0+9lhUNUtWu9JnLajQArSKLoVowRabv9+AkucHSkZDxwIXoZyqC9ZiLODC8xvXGokOQXOT2KASS7UC3la1H81qFiqUyq9GxTLs9+ZAOVuguOyWQGjkyh9D4uyPM96PhSApdpkm0AtnNNddKHprbRAS8ZEtqPAtsmatixbkE1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moWNPIwY; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-43f935f8dd3so276343b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759191578; x=1759796378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrXHTeZA7VdvtwhZTAFAV/ylzGC1dykqJ/gmIE1UwAg=;
        b=moWNPIwYK32jOr0zdy0yosXwYIWnb8un6D03FIJdcvrnFXza6Owhl0cQDe3vwRYJNq
         lqeXBt7bLWOC5BAGLAsvPSKwKnlI1KDvgUKK+GaY8Uj9aWKZi8o7C4uFGQPwbDbX0VEa
         FXSY7nMd+XuSTN9sggkP/nfRQNiYocVDfRcyLAgKzAL9ILqfE8K7EGQ1BPIAzKCtdgji
         InVM6wLqzDE8LZg/8F8DGB0Rygn9aE3wiXB4y9UxtvuKl/tp0dKF3uasnuOE+R5Ho714
         ew7cedLi6qbtL3K5x5GMXuTkx5xzGhxyIgGnLkbQiFEX7e+kqkx8DTX0gkUDKy6GHZX9
         X4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759191578; x=1759796378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrXHTeZA7VdvtwhZTAFAV/ylzGC1dykqJ/gmIE1UwAg=;
        b=pBc+2ltjrd7yJ6chvYpwIciumbosCswQYuuWm16W9ikMM9g8dazAVQ7SiAYemo6X9r
         jnh9m6HaadrRO94IxTZuePPDrGecZDU+4tVR7ApF0g20XU4X9MzU+pAes/FIYi3D7l7D
         x0qiTK0b+trR5dgNViOMPnxNRqvym3ZqZpw9ZMcccy1JrcYLr/54EXYd6njUGrjvOoeA
         8dCfJwblg4gVkWFbxMwzuTqiZRzTxNPbvkcX68QAQyRZNcXoCVV93p+UNWJy6a6ilk3n
         MFP+RGcOzJEXzsjVpAyUZx6nqyMaj6TascCL2jrO8Xy5EYOL4O2xJNbXIQASdq69X4Vq
         y+nA==
X-Forwarded-Encrypted: i=1; AJvYcCXRujL4s0EmR7/EqvyfFsd3CVmkqPnb7PA0nMcZHRe6w+O7f2PN7pLB0FSrk252NO243CZpkai65xWeak0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7inAirluSQma5vy9rE55kHL1/9x0KPwWS95wCbaVw3/LLO46x
	2wygMAGOJ5YQhblJAutetiakcPQWcaqZL+FpXpu8cLnZqmK2P8BDFGOBthjEP4RPDX5H7DzRlae
	AtN+m9zcaYLmhEgBVZR+0SW0I/mkX64dTrapB
X-Gm-Gg: ASbGncsepl3wT63W6E1xU7tl5A7VF6/iqUt7GYQCWNZGoJgx09sSBQkkTQdQxqm1E8e
	D8It6TwZuUO4nTW/ICAcdjkaDmiJFbydRpQ/MxwAqYS4sOfMn3qEQv10MRFngTscFt4LAN2ukIe
	IPo4qQEwo6tCkYQAjVGbX2n2gTIeoDmURPc3Z2jkG1DE+eXC3ItyfvIn5Qf6f008vn/bdeNagvy
	WJ9NCWYuwH2cginVBt7BQsVFJsenSd3
X-Google-Smtp-Source: AGHT+IEoqCrxrSDtjeiwakcUeo4XvYHnkurteyUGsD+XZGiCOYn4WLrmwUbEMwit9w8V5MZ7NWhBL6FCyd9E1Ycu9YQ=
X-Received: by 2002:a05:6808:2209:b0:43f:228a:2098 with SMTP id
 5614622812f47-43f4ceb1890mr1941152b6e.42.1759191578178; Mon, 29 Sep 2025
 17:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926153311.2202648-1-sudeep.holla@arm.com> <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
In-Reply-To: <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 29 Sep 2025 19:19:27 -0500
X-Gm-Features: AS18NWAXTsCPF22Xk-8M1rm_I_ys9f1EVFIsNceI-O_ANRhki9_9K-pzSBC0jJM
Message-ID: <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Adam Young <admiyo@os.amperecomputing.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:11=E2=80=AFPM Adam Young
<admiyo@amperemail.onmicrosoft.com> wrote:
>
> I posted a patch that addresses a few of these issues.  Here is a top
> level description of the isse
>
>
> The correct way to use the mailbox API would be to allocate a buffer for
> the message,write the message to that buffer, and pass it in to
> mbox_send_message.  The abstraction is designed to then provide
> sequential access to the shared resource in order to send the messages
> in order.  The existing PCC Mailbox implementation violated this
> abstraction.  It requires each individual driver re-implement all of the
> sequential ordering to access the shared buffer.
>
> Why? Because they are all type 2 drivers, and the shared buffer is
> 64bits in length:  32bits for signature, 16 bits for command, 16 bits
> for status.  It would be execessive to kmalloc a buffer of this size.
>
> This shows the shortcoming of the mailbox API.  The mailbox API assumes
> that there is a large enough buffer passed in to only provide a void *
> pointer to the message.  Since the value is small enough to fit into a
> single register, it the mailbox abstraction could provide an
> implementation that stored a union of a void * and word.
>
Mailbox api does not make assumptions about the format of message
hence it simply asks for void*.
Probably I don't understand your requirement, but why can't you pass the po=
inter
to the 'word' you want to use otherwise?

-jassi

