Return-Path: <linux-kernel+bounces-848520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86653BCDF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408D0542BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865872FC002;
	Fri, 10 Oct 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDUOpkRH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576482FBE08
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113474; cv=none; b=rsn8wzTfz5MiIw+vsZMursYDEqbkjFd1yQYC3kVCjj2lejwtdPwv85HDe8pDRzK1U/XCHQUARp5vFENR7RZoYp3oOrsqY4x0aTmij8IWvIJoRHV4cts4mtFUowUqlyodnrRQlAZJllNhgOtlnxXGbhVpZ/34dPIDK+qvtRY0mlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113474; c=relaxed/simple;
	bh=PxAoGomB/6W/ejWKyFYAfi4QirisgQyAtVNkWP21M5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXsEezkusK2PmA7Nx+cC5Yrr9sSQSGm6/z1ZEa6O/f7w3xhNok1LXVxo41RztiUAkR3j5836KcmfWcyzfKMbylZ7p5zalN53Z592xwVv/4V2YqzivTpZWPtvD6/HySNE1zv/iMNxBc9AYVLYXlh7hKz5DgvUMvc5z3qT+4ZqREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDUOpkRH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so422716166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760113471; x=1760718271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxAoGomB/6W/ejWKyFYAfi4QirisgQyAtVNkWP21M5E=;
        b=mDUOpkRHQ2sUhKRa/ldJy8cQ2uEDEDjn8iW9ldu+PP5fzUDa56nNhEFTUfy/IC5ySZ
         gRcLzSahuDz/GCn9u4A/Q22jI21yXmPNnys9qis4X00TSgOkJ0juBr8MywbUZo8OWpOU
         XFJLjtq9qfqY5Xidh9JcV0axVZ1OxcOp2/JtPZS7g7kc9+v9NF780tCDJLEE5DGBvzqg
         ES2X0NgbA3gGwdj6oNEzPWbKufBN5UonUVNiuO4LiY9c7Q/XVRdgNTlwJ6nIYsPk1AHy
         Mjv+rHCeZfOleuopAi2aeJjr20JBSll0pq7UHFoO2JQFOrA/yO0eJQdSx/6bSKP0ZIFG
         x6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760113471; x=1760718271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxAoGomB/6W/ejWKyFYAfi4QirisgQyAtVNkWP21M5E=;
        b=RAno3tNgUsb+VF9HIs5Cqrqi01Q5WM77xZL5yWq4JVhu57O1YyFv9qmcCOIFuFSdU2
         +NsAIj8wVI2vfMAHenrrQfg+qMmw881k3cZYmAOQ0myTJ9jf08c4RwFPaqowm+q+fZKp
         ru+ivF2IrMDohJ0DWzUYRkwwQ7fVzVWoV7qIJpPQ7CUs3o2zoQH/w8HcNcHEwvpvym+9
         YmqF/4gK8yqS1eVwwqUlUKRJa+D7YyIAie2eBhIGf5fj+31MCSCCflUFc9eiIhXo7KJO
         0ecpiQCKnjdOhBA6zSYBJ/E3sNPDwCoggErCaTNs4TnuU2fs7+SdZVyo4u/ola9YdCRS
         wrCA==
X-Forwarded-Encrypted: i=1; AJvYcCX7S9NTRUsm2qxXEoY59di746ziPsRSZztTcLkjueBnDzIY4FmS0G+UmqTZAfOaDY3W2Sp36RMjSmhHE5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMr++c97fi9qKq3XXw4Aays7IUkUX10jr0B+5ns8G3l4y0wjv
	MSvqyDBJrsPnRv7DjRScdeFOpkkWEm9LEaRRaeO+lZQhKWSNiZt04VlJFjOAJ8VxY1A7S/vMD+6
	rUiIXqBz8W+LPwPcYBBqpXQpUCIuy2Tg=
X-Gm-Gg: ASbGnctPmn/8WbtnsJgSEL5Lt7WK/Uyf1ZW3BHjKe2BsNYblmvzQ4SXh/aEfkQSVQx4
	LjjOw+BSzEB/wpkq60g55RY45AOCd2DWIkGVu1xBMjGpCFHEB80FNbf9YwsqBhAxrpVMVvp5U9e
	5Tw42lFN5NSgdRco1QONQlC5aKydJRZll/GCHF082kBBMz8imJqMA3RJKyN4uz7Ix16bBsE9odq
	tDywpQ1ASgHRUAlRYDiZVVE0Q==
X-Google-Smtp-Source: AGHT+IH3dUeu7u4Wcz7UH2Wk1ekmwG/avu6DuHXVWRwrs6DlnQ2d6HiPwADb3eOBXMAPPzLk4dKdm1qs6zcf+ex/P70=
X-Received: by 2002:a17:907:7213:b0:b41:a571:21b0 with SMTP id
 a640c23a62f3a-b50ac1cc421mr1177748466b.39.1760113470537; Fri, 10 Oct 2025
 09:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009173609.992452-1-flavra@baylibre.com> <20251009173609.992452-3-flavra@baylibre.com>
 <aOg3dg21aWNTF47x@lore-desk> <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
 <aOjAK9LRMCcBspkb@lore-desk> <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
 <aOkG-jBOYXxWy1z3@lore-desk> <007e87d2-92f5-417a-a6bf-1babd4c60c61@baylibre.com>
 <aOkysKyWX2hYEnED@lore-desk>
In-Reply-To: <aOkysKyWX2hYEnED@lore-desk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 19:23:54 +0300
X-Gm-Features: AS18NWDo_jfto-o10CvquEBrSCsJkhlBP7cCL6i324_1eBlCH6pZSxx8Pwp6wkM
Message-ID: <CAHp75Vd8MmDXm_OPooHC3B+HdHoTn-TvGbRg-C3-gjNSZQoU7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Francesco Lavra <flavra@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 7:22=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
> On Oct 10, David Lechner wrote:
> > On 10/10/25 8:15 AM, Lorenzo Bianconi wrote:

...

> > In the IIO subsystem, we prefer to include the units in the variable/
> > field name as well, e.g. hw_fifo_odr_mHz.
>
> ack, but please avoid camel case :)

Don't mix up a camel case with units.
Or do you have a way to distinguish milli from mega, please?

--=20
With Best Regards,
Andy Shevchenko

