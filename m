Return-Path: <linux-kernel+bounces-742803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB424B0F6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21443AEB36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141EF2F50A3;
	Wed, 23 Jul 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La7ETE7D"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A52F5085;
	Wed, 23 Jul 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283953; cv=none; b=ZiHsINpT6EYtOA2r6C60R3hTzRz7zE/yQS3oVuKs05uAa7HuZpXT/fcq0xHoQTTW8fq7GC6BcXE5up9KWJFHlUZ0l14D5vpgTQu+HhPilwC3QDYFJZB1EPZLOJ/znNW76A10GSvxrlLJSdQ2wJA0+SUuxOS2s6pv6BjDyADg7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283953; c=relaxed/simple;
	bh=aKYxJLq4l/0NHHzMLA1J8KQdNp/rHfNp1Iie2v3oYAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn2O5RUmxvESRGloyJItrJXtTOhhxdneiu57arJWv+Y63fAk3Qx4vNCssYjM+BH+xb68gd+yKPFd9oMRUS4kOFTnAtJE3JJiLxjDeofoiVH+V8ZidfxJgKBV0lHsddB/FdcgES0XkxUj7Q1LrWgoWoUqNeZy9Z5pu6UQ9y6p354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La7ETE7D; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso61019041fa.0;
        Wed, 23 Jul 2025 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753283950; x=1753888750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKYxJLq4l/0NHHzMLA1J8KQdNp/rHfNp1Iie2v3oYAk=;
        b=La7ETE7DNx4+5Au4Le2eQEpz3WjN76vVRlGZpvaPy6CaY20m160kRRofZqjViWFUnL
         l6M9OEBR2/rImQMUDMS9/nCwJW0vpZBJ06GjCo7ijdfGE+SvrT9NAViOJtVtCdmIlfoQ
         OJtHuw2NBz//7mtPJFsRhbIPum4+Qx9Yy55VWr/4AoHlNkYu/QkACyZ32QL/+RTOvHw+
         o9OqY6jnFNB/D6OIUnMRJ3AVrXbko38EFl9FEZLdBpNbNduXLE7nP/TF1TpBJv8OphP7
         mb3ow1LF4YdvIbr+t8BFlnYkrQ3G00D/04yl87rq0i1uedsxhcFjIkL+f058TgJ8lNJk
         xH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283950; x=1753888750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKYxJLq4l/0NHHzMLA1J8KQdNp/rHfNp1Iie2v3oYAk=;
        b=k+JHKHkynIqZnQHYCbI4O4qmS+ix+0aZ6dGXbDxmAcKg/7QVYty1Z/AVjCNNbCXCjt
         zHCdN8KjmQILzWfVD4fF0ZznDu8rbLMSt5wMt1ku7UaTPsrqfDAGhjO8nMpCTaU26uhw
         iheeXja8nZWiwYIYg6uOZOJ7ThQeoNYjKvbACW4JQ7WcCquIq7PiGxCO30sRc0D78UUf
         4JS2KMQPn6ISPXd4f3YO5W6tDnwAiGFZpfsKMU3wZgtBs82AXXIotKKnlKgaGL2srvV7
         2FagXFz/R7WWFHvHu5ROztk7eRs809n5qXuFEI9ic6Gz916NKdtc5DGC/sE0lVrengsj
         isOA==
X-Forwarded-Encrypted: i=1; AJvYcCU90x8LSHTf6hVb3Rs90ZZukRq0+59s3p6YjopwlRF5JX8iWxbp+YRUIxfL3ylcVLawMhC4KzEAJBy63nk=@vger.kernel.org, AJvYcCV9iuh1eWzMmDm2K5rICwKwWpZnxT2xRpixxtqaDk5Ib0lOn+EtLaZdO9hA1xB51VZhr4N7k21k7Rc2XRbjaD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL85R5kULNWDg1J45KRNVwVeDUenTA3CxlPU+7bTqviMX4vQJV
	A0c9B1if8SqVLpC0w/06kgAKgPOz/RR6v5Ts/MQtXKSTF8TcPVTwOnLCeqmnhVce89haEdw3O3U
	cCMGUCXqAA74bzGurICDmXzzDO2+TFVI=
X-Gm-Gg: ASbGnctoD5Kbbhvsu8qGxtLMB/pVZugJfnb/SMUGqTHxChRZKAVfIf9e7vzu/GUxj51
	RnAds0aoDK2qCHcZlLQuGMXtdiwBeFjhODfgwhtYyZRUgQH+hwIwFvVxRE1tHzP6VPGsPpCKucN
	qF78grhs6AzSowe6pMkDBHoEG5gEAp7AE0fHIXu5SdwQXmw/EhWtb6r8XARms+OI1aMxLvfWB8r
	5/oDZa9
X-Google-Smtp-Source: AGHT+IGJk+cnSNB5dmZjA4F277uweM9qQmlzoDKYZhZ23tSm7g4ZL+8uSgmn2lon8w/gtCjba8umd38UVFMHQbqvdlA=
X-Received: by 2002:a05:651c:904:b0:32c:a907:491f with SMTP id
 38308e7fff4ca-330dfcb6d4cmr9134451fa.15.1753283949057; Wed, 23 Jul 2025
 08:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>
 <CANiq72m=vYbZZPwF9u9PQJ7Jce0KPR7jPybk3AHV50U9fOmEvQ@mail.gmail.com>
In-Reply-To: <CANiq72m=vYbZZPwF9u9PQJ7Jce0KPR7jPybk3AHV50U9fOmEvQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Jul 2025 11:18:32 -0400
X-Gm-Features: Ac12FXwWBKGVYSeoUZtcO8393_I6OiMdBpRjfrnt92VkxrRDihDu3wCrwQiSyrY
Message-ID: <CAJ-ks9kuCTnmhJRJyuuyGST-W_9TDQkg8iWm3YoOtP7_d_NR0w@mail.gmail.com>
Subject: Re: [PATCH v3] rust: remove spurious compiler_builtins dependents
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:25=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Jul 20, 2025 at 7:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Remove these dependency edges.
>
> I should have replied in previous versions: this is wrong -- the 3
> changes each individually break the build.
>
> I guess that you are not cleaning everything in your tests before
> testing the build.

You're absolutely right, this patch is incorrect. I was indeed not
blowing away build artifcats.

Thanks Miguel.

