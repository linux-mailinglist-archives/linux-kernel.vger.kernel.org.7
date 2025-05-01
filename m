Return-Path: <linux-kernel+bounces-628916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B1AA649F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 22:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C7C466FA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C72512C6;
	Thu,  1 May 2025 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivCLPNI9"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06021E260D
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130544; cv=none; b=j+h0yBu4fToPKECJpAvEfNhIQc6BTm+Lk4hLsuZFrzbtlUxtqvSFRkLdxTGciGQFjrPzTG5KLumEZhiGI1lW8I30scNNsFJBVYT5OcqCI7T3Rz/PUBYgwz+SQSgSjoF1XcwG8cGSG2lokSj7p2z/eB6gWkQZfKVEYYaEbnI9kVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130544; c=relaxed/simple;
	bh=FEQPFMqC2aSqAO0+LCL7aLTH7lQASLanG1HCrQJCXiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tC6hwudFqvTCosBq1A4trfya6IDRz5PslWp2OWXpO/iWABQoOAnRCVWYJ4zZBjF+an4PNTJ0KlaIA+MNggh3xHV5JOSGtm5MEzi1ubjX6VQYD6GmpMGSNkTQ39REOOlhz+iVeqOlyGWs2D6p9lDE9AYlWRGRZS2QFUe2YkroH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivCLPNI9; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d8c4222fc9so33145ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746130542; x=1746735342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsgFo/RejhPC8ntitgtfydngcD4MvQ2F4ZVpjB7CD0k=;
        b=ivCLPNI975WK1UN1npB5I6kKC/DarhCPbGwI8uW6AhCBQ9Z6FcxSeXsYpCHBsN5uug
         ys4CJ5LnQ/hFPosjv0B+wBH1nIcSYy+6IHxDWbyqMYFWs6TU4Id27QlkVkwyRb6O5LRI
         NtJR2d51+tGe6NFrvrs3yDJVw/MonE4amprIgX9qBwq/e6kxyrdfOBKq8087pq85u5k0
         GQs90qXfWrhrv8oNIxMFiJlqZE/xJejKbtr+dKvmE4NFq48qsLhgoixcwPKglEMw0W25
         YT2UriMydwTrBvfZnm3Vp78XBXwY2BYVq9Kqvuityc+x+cvDE0ZDWmrp3WTZLVYwTY3f
         scPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746130542; x=1746735342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsgFo/RejhPC8ntitgtfydngcD4MvQ2F4ZVpjB7CD0k=;
        b=nhMs+OsdH3NfhQTu7FuimFAAKMNshyUN1qjqcZlj2DPjYEuCzGLXaOgV0BUqxJMFIC
         vmJfkfFKCLwMqHRs53Sy/DSUv06aExwSVNkI3QFQmM1dC/3B/7aZGX1tupL34FsI5kk+
         RzEyJkIoj7jBYpYpwLII6tvQioJI2z1Ns7t8RownuQvlzyc5rk1+tdPLK3J5ja/zURZu
         Pnz5MAJckCudWGC6ZlRZEt470LEvMkDGcygMz3dXSHoGScl8Hv5lB8UxM2z2xwvxVCO0
         QdJNEb5Mgs6vmCvHLhgXmpEcjMpBfrEIbdKc3k4zrRfSOsIM1rcmSly8fX6kCuGDAU1v
         U4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/1XwNqxs8H9ikXW0sBf4Mmy1vVEz+8mvPz7H7p3yg1As0faZ8HwvkAu2xmblYoY/0MiL9TFj5dLZ80Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOIHmmy5PwLkvKaAwxq1cfruJzv4Tl9wG0R9OZHFp6Bg1fNUv
	d4W+9PKXclhq1RNw3HfVBILBBVFkU5tV8hkB2HVJDL6VO/5lBjTJuLV0B1deYDkMEuv/7gU2aMJ
	pGVIeZ+LzAQFM4td0gnDa49l/IGZEskI3lhnw
X-Gm-Gg: ASbGncvsTIEQj8ROg7z1LeVRlcH5EwdmZF6WaAgs4v9bjMCQAeHAFQVYe0s5cnmZo5I
	1OpBOD/1waQBqmcombUq0m+ErttFtZQmMK3jiO5GsFN7IT7XyN7W389g/oRWnJEVQvkqaLbPN3s
	e9K4DWLqsEZDoYEBQmMf4QyJrZztqhmfFL37Hbk7PYf5EV8e2Gc8Y=
X-Google-Smtp-Source: AGHT+IGexfc/fZhfpYElfZIWeUZ/mWRcKXSby/mukAKUwR/YGvuJbqqmXJrKBpRTecHo8TIfYhvpJv/OrpWwn+7OPV8=
X-Received: by 2002:a05:6e02:749:b0:3d9:36bd:8c59 with SMTP id
 e9e14a558f8ab-3d970168792mr3865215ab.9.1746130541633; Thu, 01 May 2025
 13:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430171534.132774-1-irogers@google.com> <20250430171534.132774-5-irogers@google.com>
 <20250501210729.60558b33@pumpkin>
In-Reply-To: <20250501210729.60558b33@pumpkin>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 May 2025 13:15:30 -0700
X-Gm-Features: ATxdqUGiib1N4S2UorD2RWA-lOkt4hHY0zEinkBd0HTa1nh7ilOIujgC_soxr-I
Message-ID: <CAP-5=fXrhsZYJwjJzqb-zMg+UoC-bKoYCjstq8yD9wHNCfbS5g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] math64: Silence a clang -Wshorten-64-to-32 warning
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 1:07=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 30 Apr 2025 10:15:33 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > The clang warning -Wshorten-64-to-32 can be useful to catch
> > inadvertent truncation. In some instances this truncation can lead to
> > changing the sign of a result, for example, truncation to return an
> > int to fit a sort routine. Silence the warning by making the implicit
> > truncation explicit. This isn't to say the code is currently incorrect
> > but without silencing the warning it is hard to spot the erroneous
> > cases.
>
> Except that the extra casts make the reader think something 'extra'
> is going on.
> For readability you want as few casts as possible.

Agreed except when not having the cast can introduce bugs which is why
the cast is always required in other languages. Consider in Java:
```
class a {
  public static void main(String args[]) {
     long x =3D args.length;
     int y =3D x;
 }
}
$ javac a.java
a.java:4: error: incompatible types: possible lossy conversion from long to=
 int
     int y =3D x;
             ^
1 error
```
Having -Wshorten-64-to-32 enabled for building with clang would allow
possible mistakes to be spotted, but that's not currently possible
without wading through warnings that this series cleans up.

I also don't really think anyone will be confused about the purpose of
the cast in something like:
```
al =3D (u32)a;
```

Thanks,
Ian

>         David
>
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/linux/math64.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/math64.h b/include/linux/math64.h
> > index 6aaccc1626ab..f32fcb2a2331 100644
> > --- a/include/linux/math64.h
> > +++ b/include/linux/math64.h
> > @@ -179,7 +179,7 @@ static __always_inline u64 mul_u64_u64_shr(u64 a, u=
64 mul, unsigned int shift)
> >  #ifndef mul_u64_u32_shr
> >  static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned in=
t shift)
> >  {
> > -     u32 ah =3D a >> 32, al =3D a;
> > +     u32 ah =3D a >> 32, al =3D (u32)a;
> >       u64 ret;
> >
> >       ret =3D mul_u32_u32(al, mul) >> shift;
>

