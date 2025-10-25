Return-Path: <linux-kernel+bounces-869937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43502C09093
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DED2404EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDCB1E0E08;
	Sat, 25 Oct 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8wvdelT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACE111A8
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761397240; cv=none; b=SLnyxm97w/RO5HntbEud9RqcXY3JHqS2ZGk7JuI2kK6RrPktzn7JZgQvF/4MwtMVWArfXKjQh9u0/Bth/F5+a0PJO0L95n2i3k0XoXFMIzzw7yt9Lf3Xsd3fJLbNzXEHtGNByPloFWO28KtWMLkZE741osvmH/TYGKfmo9N05gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761397240; c=relaxed/simple;
	bh=EASrkkWI0JBpW6t2iVSbWSdDzPlBVsOxlTbS3n8qIx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRLzsVjsk4mNXewkiU79RwpZymeLKu18ikF3vyllixsTZTGXuw0ksgO1kY8NYno3POOTGKgFH/QduDB6+8bJHWZz7KOAEB2UXz58983vyBaUumMrqjS9RKMZj32o3dz0Q4c4SabtIuwdpw+4928p6FxNhqIsyW92fMbCIvF3Zcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8wvdelT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290a33bfea6so3933305ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761397238; x=1762002038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TFesFsglqC08jCidE73APHCSjqIZFDJA83IY2oNpTM=;
        b=M8wvdelTi/zVnVycWMTSNZQ0yhybu9RiJwgozMHICWYL3Rs09W4QGpcQzVpk7sgKem
         KHktEGICq4Qj/1KczZCrBLlR/P+uv1d0X0GhuWAcAbVJV96R98Ql2Ys8UWmLchJymW17
         Q+nKYNGWzMMljmNzRJFv3npTRyN5E6vVM75+XmScCPQqpn5izLBAZcH1aRNQMlCEW5i/
         KEEeLICKgEGCJjORe8nxyuAowSL0mo9dpMjuJB+b7WiMbaPQJCfc+1OKEQIQy7mWNfmX
         KqdobCeaMHtJKtoJ8oX35MukYEkNHh26nETVGDOVRxFnGfFihVBVVunwT+OwkjcDOhV5
         qiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761397238; x=1762002038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TFesFsglqC08jCidE73APHCSjqIZFDJA83IY2oNpTM=;
        b=r5B1qyS6+AYls//OpLoy328K304WZD1QgGe/1GDycaGl/gGrxIuUBtB9FIud3J1N2V
         DjtciwEu7inw8nVFvifZ4U/maSZACyn3DqraxuIoOEWvby1Hvct+Jx8PmB9E5CcGgHB3
         zGZpyOu2kQ4TAD53iGw3mu8nHLmog1Pp2so/RoIR65hE6N1pqvh24WxPQJCVz5fovPrc
         XCfwF1NGRNSIvNk/kSSXtm3Ql8MSsNarhvUQNHhnLqtG/3BVRGmumPdJ1+q3xnUvRl5V
         znSbvsC8JD3H3wtFqSl4lHCpu2ylZ1/5nR6+a2u/42vt7GRnG//uJHBHeHslwHXT7IV5
         0MZg==
X-Forwarded-Encrypted: i=1; AJvYcCUuhU682TQvqJL7+qtom1We8ger7+iQCFDN0o25OrfyUVMQnvzLSIkuHqPYP7qYELfYlSg9iBOaZOCm6oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIzZ4hyaxHl8aouXaReXlZeGQAOr1/+ml6U7aiJLvfdntLU8b
	IMJEGVQ5Qun9q0gAnFeKWKXLpzJT4rZIcZQc2BW/CjskXLLmF6ZPt+2/uhaZ/b4YriNwB97XVjX
	RYx3EC9gAw32a475fJuuIApQkY1qZrPM=
X-Gm-Gg: ASbGnctEcO2vRe5NQlZLLGB6eltlnUmvUuVfBS/ujwe7RsaqNnCl/+1Q7z+O0OQin/S
	BvoygCrSCnm626QHxH2FCcs/Fpm6Axg1aSC+QGXzGsZ5rb0eaNsVIkp6pIYay0kAQ0FeoKsj7C4
	/q0JQ+3mFtZp2IhynlLMXjoO2BroXoFmNAB43+JJ8DmJmEtn2Ruf8Tvvh3CYAfeS9oxoQoHQpZQ
	uFHJjecCn908qba0DSYzFchjg/Tjcj2XdV4c4ZkgJpJEfDYlOenTx06IlH7FsUny4jJAiuPWUYs
	SVReO1VcWxijh0W60TTaUI3lOGZ8E6up9lvVcMP0L7Im/3m4O4flBOT+9JFMJkw43G5BNtwX9s5
	OtfuW7XCqKw2pKw==
X-Google-Smtp-Source: AGHT+IEbLNoUs/7TUmb7QhdPzsK9jT8ZWrQxkiWqqM8zlucYBhznBt9a3wsSN3HfQJ0dcN6G5T51p7iEwBJO4hkdeVc=
X-Received: by 2002:a17:903:1965:b0:292:64ec:8f4d with SMTP id
 d9443c01a7336-29264ec9324mr156200135ad.8.1761397237982; Sat, 25 Oct 2025
 06:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025124218.33951-1-sunyizhe@fastmail.com> <CANiq72=d0zXWAryVXHUKLUkcM_dPoC_uPM2drMXAVB7kh1YSjg@mail.gmail.com>
 <68b53c52-9834-41f9-8e40-ad27f00436a4@app.fastmail.com>
In-Reply-To: <68b53c52-9834-41f9-8e40-ad27f00436a4@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 25 Oct 2025 15:00:25 +0200
X-Gm-Features: AWmQ_bmJOsQ0f363KiSb1YhEOetWFbn1bZiw_EvFWfI2HmZUeHb0IvCaFzOzsSs
Message-ID: <CANiq72mfjbiJDSz=n3BR1quNwbzYB1ZZhADDU5P3b0bDmGEk7A@mail.gmail.com>
Subject: Re: [PATCH] rust: phy: replace `MaybeUninit::zeroed().assume_init()`
 with `pin_init::zeroed()`
To: Yizhe Sun <sunyizhe@fastmail.com>
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	tmgross@umich.edu, netdev@vger.kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 2:50=E2=80=AFPM Yizhe Sun <sunyizhe@fastmail.com> w=
rote:
>
> It is. He requested to have his patches re-sent because he didn't have ti=
me. This is my first time participating in kernel development, so please te=
ll me if I did something wrong.

I see, thanks!

So it is this one:

    https://lore.kernel.org/rust-for-linux/20250814093046.2071971-5-lossin@=
kernel.org/

When submitting a patch on behalf of someone else, their Signed-off-by
tag must be kept (and then add yours too), since they are the author.
You can read about the procedure at the end of this section:

    https://docs.kernel.org/process/submitting-patches.html#sign-your-work-=
the-developer-s-certificate-of-origin

Also, what I would normally suggest is to indicate that it is a resend
in the part outside the commit message (written right below the first
`---` line), ideally including a link to the original patch (i.e. the
first link I added here).

By the way, ideally patches also have a base commit with e.g. `git
format-patch --base`.

And no worries, it is all good, getting these details right the first
time is not trivial -- welcome! :)

If you could please resubmit it with the SoB fixed, that would be great.

Thanks!

Cheers,
Miguel

