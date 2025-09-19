Return-Path: <linux-kernel+bounces-824800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F027B8A2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AC41CC1F95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C962A3148D3;
	Fri, 19 Sep 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrsxQaBU"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990481A314F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294373; cv=none; b=jzBRoM2oTRYLYhOUVDVJ9osOcmERE+LCdlGHKFfZ53qRQrQeeKMouwHFVG5SjQzfF2MdiMGS5/BKtzNIKXMZOjK8mGYSD58V9xMtJKaYuAvYafoo74Oi70tU3eDXhkaKd/nAb39eCr2Kke8MR9bLk20BzjZNkFxPlNRj4HXYW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294373; c=relaxed/simple;
	bh=wdojHUk/IaswjOXNhFweViADqPcfNEDUvrpmqOD6T84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdHPJLn7qBuDDiHy61Gi8R87YM2pc3dqzZUgQzhgVbfsauJj7mBfxrAkoWy/2b+6OwFjD6EczZ9an0I0vB/+MUkExDCcnXShrBZ0BkP28mCD9poxQxLZyHyhPTUrsf3pQop4dlgg7XeHkU18JIRCN9h7IawlWkV5TVZf4on9paQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrsxQaBU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78ea15d3489so21872346d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758294370; x=1758899170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2StnNKxKVl/rGS0fAgoxWZPalUwZSRkr2jKpUk0esc=;
        b=XrsxQaBUoAzDlaVC2qo327eDnsB0qVHV3qKzQ4XsbuYZU+zzFZbVnwoELn7t3qon4G
         At+HS8deqXMDM3w+VcAJYS7SuOzONXdzYyYBjZh6DYUsmdDU1VkIy1GIMgLyfdpdcIm0
         qLysFY8v9aS8akIHeyLBK8SMB9eLq5dIjM8Q58T1KahckVXaKUkJu9qAcFnmJdd5AmRe
         TwVgmIoySQygVlJspzO933T7mYPLzU0W0NcSyN97SPVo+vHXXnoizKgRTwVzhf/f5Ppc
         /5yTK/e+gUP/OjXbD5/OCIQcjpx5Iny/4MIlBdMZi6Njz8yjfR8AAgFWz9wRdd6P+xjs
         b4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294370; x=1758899170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2StnNKxKVl/rGS0fAgoxWZPalUwZSRkr2jKpUk0esc=;
        b=gMbWMwNXMQbpkK/h3DcCwuYv/o50pXJoY9oW4lfkWGxNstFjtClMbpLyihI38E96eX
         fr1Ngejsz8QvXcZiU9dmf6AvVVwNUzGHHr4pWM5oc76Z0VrBek6sqrnxdYQn8eCfW6D9
         IsYXDkrnCShBU27qGXsOMARdDq4BmjJdeF88Dz3JUbwVMIObKenhpzdGavA9+3kzsy9s
         zoaW3vXPXHgBBYzVk9gLs+MqXKuT3cO0nsulboksTtNqio5T9hV5ikBGEyEnzCkFDONy
         60tA8cSyejXe7wg08ulGXVva0S8kZfswKuHvrapAujuR5UdPHlh927BywvKrpB9/91tp
         GyHA==
X-Forwarded-Encrypted: i=1; AJvYcCUhqA8uBExaWjL7g5hhyTYParXPum9/VlQ1z2zoFyT+oMoV2f37XLNYoMGHsvbDYvcDKyn1AT2DCLQ2NsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgl+o7WYP4vK+HuMD76zOayjXpM8zA6v9Imw5Q71pOnvichAcZ
	dV4emvyhK/RjaY9A6hAQaYHbHRNBA7uqIvnkGQykaiY0LFsRW5uehkVEaTZV0SUNX0qyqxX/rH6
	7y9rJSNqd2mvJBVMrINZmpgHcSAtvf+cTClbkSvbb
X-Gm-Gg: ASbGncshDvJ76uH4aCvUCF5lJBcpBVxHyxtxo7FYk45P8aX2vkjNaatt1W2BZs+K/9s
	qo8AyyhWiln0nFMmCuCXWYduVXstgfuRp6RxBK57oVm2VQu/XDenQg997buY17FpxjMXsVhPGnA
	jdj5JNsKc8/6H8J7sN/jejtL2WOx9+of2Im6gU+EX3jO05tuy7PpjgCSUB5J6qJ/Sz7tnzl8OJ1
	lV4iIl0oHo4FC1BHRN5CP5p/1f/ndCAqmR+VQ==
X-Google-Smtp-Source: AGHT+IHfnOEj1gMhyVykBwx/odq4LWyP4tOsK2JQ1CQRm3BPJztFNuuL5zFmF2mdOG0LX/4UQZju33b9dOCcFbl89Gs=
X-Received: by 2002:a05:6214:2aa6:b0:787:68a5:51f4 with SMTP id
 6a1803df08f44-799139ccbe6mr37966906d6.26.1758294369549; Fri, 19 Sep 2025
 08:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com> <20250919145750.3448393-4-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250919145750.3448393-4-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 19 Sep 2025 17:05:32 +0200
X-Gm-Features: AS18NWBlYb6i59Bt1eV3KacTLjZoCQjcTTUaAaIGM2IX6otsVz3ln6Zi77bGuIg
Message-ID: <CAG_fn=Xd07FvCp-tU_kSyjeJS-4gruaO1x5iowrQQ7zkv2cLeQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] kfuzztest: implement core module and input processing
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	sj@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:58=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmai=
l.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add the core runtime implementation for KFuzzTest. This includes the
> module initialization, and the logic for receiving and processing
> user-provided inputs through debugfs.
>
> On module load, the framework discovers all test targets by iterating
> over the .kfuzztest_target section, creating a corresponding debugfs
> directory with a write-only 'input' file for each of them.
>
> Writing to an 'input' file triggers the main fuzzing sequence:
> 1. The serialized input is copied from userspace into a kernel buffer.
> 2. The buffer is parsed to validate the region array and relocation
>    table.
> 3. Pointers are patched based on the relocation entries, and in KASAN
>    builds the inter-region padding is poisoned.
> 4. The resulting struct is passed to the user-defined test logic.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

