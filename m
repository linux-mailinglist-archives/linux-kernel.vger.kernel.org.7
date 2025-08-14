Return-Path: <linux-kernel+bounces-767908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F53B25A52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2205A4FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787791E1E00;
	Thu, 14 Aug 2025 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBnFoBrj"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA52FF645
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144740; cv=none; b=NxPfVJE+1kRuUxmKBYA9WMoFr7Vp+SwNejL5WL3CsOb12xEMb669cZrrVHjc0tjtQ3HaXlVQ3YNWZ+4S1NH8EHi6AEuM7rlOSSzKq0VaUxSs0ST4Huc64mhgROscBE6t9msmjlMZeWN+swdVAINKwQcE0zpKnc1ilwG4OmZEzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144740; c=relaxed/simple;
	bh=Ue+Vc2/S8+oENNXu4fD/LcXg5OnPpeJH5AzIv33HmYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhNP9qJKTaHhEoKqZdb4tqInXK1gmYleGM0EC88MUTSeYA5Z5/L7IrNNMWOiZMqlfBetzXtYS2rRVynBtbPYEbgJOWBqhxMu0c6WBzodHifkwBRKuJNZx+8e1sAeoU8Mw74cBjNdQHWQ7egTgUnKJDD/WzS/ZK5eSSk58w5Xr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBnFoBrj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55ce521e3f4so509862e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755144736; x=1755749536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0esidH034X1sxrJHinEHg6jy7kRj5cxC5tqpPotq380=;
        b=hBnFoBrjb2IfXWa0Xi9D0MkSOsfmtAQq4qm/nZnvQ/OSv8FPhAF+hw2NwfoKMrS/SA
         /WLS4HJpmQBzblLYyQicmraZOwSEFoLZBiRHU8/6ey5qrCrmERUAFLQjDRjKfDK3g6/t
         jXtgD/7112WD+JXRMz2oxLUmtM2UpaVL8r9tN0ujsDdxkAZAMcqDGCK/eVL703h5eQT6
         RKpmYwz2lBWjCo7z5YQDE8mB/oY4XaOiLTj9gA/Ib1Ed1cuprAisLt0WrE8gIZenKn2V
         E18KrcULSheX9zcouCviNJVwtzThdWgjoDiTtGrh+q/UeGIUfETnTSXrLKdK87Cunj0k
         QtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144736; x=1755749536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0esidH034X1sxrJHinEHg6jy7kRj5cxC5tqpPotq380=;
        b=jlrJrhU6IOenm4YMuciLSp2gz6eiBHgEPnHHMyMfn3t/3t3N95pC4OIO4F/JzQ7Xbm
         yO3mmfFwCrwL9mqJKeZ88Opw+1IPaw44WsffyVhcac5FvnPZNP/G0Ad8VtcrKaS115zx
         lv0Z1jPsimB3XSKbw1Q16has61ELjkztVvEAnKCcxH8oHYF6ZZS2TTpkuCwNUnNZS2n6
         Ovpxj/6/1olxMBxH03pYWiN2686qNFaEAw2Ymkv1yHBR7OaatgPv9e4O45gfq4DSW5Zt
         aBMKLh/YiAHDzng+pj1W9TZ/NkPqfk4B5uenR1tHfVi6KFFihXHMFxsrCbZPo2lkXBYs
         ZKqg==
X-Forwarded-Encrypted: i=1; AJvYcCUKVp9FOK8CnSovXMPkplxmSAj1GT737iVqCVfCUhy3IBW7+o7jO6GjlW+se2UFIpGuQkRchAwfSpDWZNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UthY/wGHlya6xVs8XHcBzqYCz5bNHmUdtyHDnKkGF74cm5rd
	WgE4CTvsHR4abHNA44pWYHH8698oHtwxftZIHLF9udA7xtk252/fE7YvF5m4RDR7Kom6JNs0dqf
	xkjEa4bUWRbowbvVHhv1IYNElVS9VhZO89OQAPFtDtbonx8b04NbhahpR/Q==
X-Gm-Gg: ASbGnct0y8WQylXq/yzHArvh7vNIPDPfeVVOAPqTCpJwh0tMgKZP6f/kolZ+S+Dpd9l
	3bYYb83T1nnQOFadNYYbQMJMaXGo9jZqk4XGabzKnMHM4LaptNRN9qC93/eKI2QwP9sV3mYdiQV
	b3mbmycmzEqfAGJYiKGmUqiJhqKTBns1PixmXa8Fya9T1g3LNOGGVvbr3BodcmfEgATWHCZ2CEz
	U1PuWDCq0Wqnzkfl3KMHuhK2+6K6Sjb1ixrNAH1bHs=
X-Google-Smtp-Source: AGHT+IH+r75EcKUSbh8e+BdQJJI+kAasDrchVOAazhwT9kWv8h/F1VxYqjUHgDHsgOq6+NwV4BY3n9yxhXtQVfMyYb0=
X-Received: by 2002:a05:6512:238b:b0:55c:e6be:d632 with SMTP id
 2adb3069b0e04-55ce6bed7d9mr302708e87.1.1755144735916; Wed, 13 Aug 2025
 21:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813180108.209096-2-thorsten.blum@linux.dev>
In-Reply-To: <20250813180108.209096-2-thorsten.blum@linux.dev>
From: John Stultz <jstultz@google.com>
Date: Wed, 13 Aug 2025 21:12:03 -0700
X-Gm-Features: Ac12FXym4KMPwK0N4zfSelpuL6ji2c2DW-6l5jPalkmH6saIUYeXiy27pnzCi5A
Message-ID: <CANDhNCqzTM4RMp2EEUp_cGTHhorDC3eNh+N9N0VL1KeL-xKq+A@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Use str_enabled_disabled() in hub_power_ctrl()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:01=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function and silence the following Coccinelle/coccicheck warning
> reported by string_choices.cocci:
>
>   opportunity for str_enabled_disabled(value)

Thanks for submitting this!

So "silence a warning" isn't really a great argument for *why* this is
being done.

I wasn't actually familiar with str_enabled_disabled, and initially
this change felt a bit arbitrary: The length of the function name
barely saves code characters - and it only seems to make the logic a
little less readable - so what is the point?

But after digging around it seems the benefit comes from allowing the
"enabled" and "disabled" string constants to be consolidated across
numerous uses. Which saves memory and makes sense.

So it might be good to add some detail in the commit message about
that, just so it's clear why this change is helpful.

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

