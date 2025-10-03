Return-Path: <linux-kernel+bounces-841524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C7BB794A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01D143471FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56092C17B3;
	Fri,  3 Oct 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QwV36q7n"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16EBA3D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509590; cv=none; b=qLc7cB9r/9bWp/Dc754K2hnpr3g+3TUz1XnT4oWnSPitEsJHD5mODh7/pNyb5k9aPoI4qNRaRhqO9NHBOTL3VgfDWj3v4rUY34XhiMBnnTWCqoS1iBfcuqPJAOvaxR3N6DXfhXB6fFOytiB4kTaO1H9GUDQsp68PpTrUz0JvhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509590; c=relaxed/simple;
	bh=XimERl0WTKsgsOP98bsK7OKrgcJSsKYFvtW8JgIIQG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2B2zW5Q5L5A5pzMeqU8Hd7A4nXY30Kka73F3RzRaQHHwH6YRP4HVUG9pSOFYvCyDGPqFwCYwNbmHtPzaSUOBUn/G23xuFSJ1KrgAco2lBO+aq1V8BFGze/VVy2Av+6zFeXIA1GRIIxXEeBHRjNlk6MgDqhVyJkmnS/br8fhyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QwV36q7n; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550a522a49so2153337a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759509587; x=1760114387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJMtllFi1zVk+JAOiwqLtgaBseyeNZFxDAwdyexpj7I=;
        b=QwV36q7nOMuG6sG9838PNysBqi2RwKP424WI+V+Ug9VaYYHUkiG9FlvoeydvnGKgzT
         E8CbzoeS2bXLZLrlcHfeCr8DDGSxf4dTChP3Rz/VBEdZ30Vj++oYfW+gQPRPIbgARN1D
         L4YtIKd9w6MFTmwnoiPo+UqNGAqQsknhOVmRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509587; x=1760114387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJMtllFi1zVk+JAOiwqLtgaBseyeNZFxDAwdyexpj7I=;
        b=BP1cMngu8vZDlLatM9fDV/MR4UjEw1pbvQT3k1tBa0xNiDQaBt/B7HijggwiEzcyw7
         OsX4X8ZquFegEZ8s+X6U9S6qW1MrJ7vj/lWGRSAne+9HFBS0OhrO8sSK+Cp0B5R/79uh
         UX9Fh8limzU6HfUcGQlP5MgyHWoENx0yufbgAN9UlIHERIfo/Ly5ZJjSRNePJ/ENlmJn
         ukbtvYHsAPD5NPUDld6bBb3MSOT1/Hmtoqgu5Wn86EMJf1M4735JfIIZ/6Rw2T6lX7nV
         vS9h8a6YA+GIdmcnPwKFlESWwwrJ8c4CW0X81QDWsnklsPKIACHx8qrOW+l+XcM3C8CE
         +1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVVz26OwKpSjVqIWj2vPbXKjvnKETd4+nDmA4x5n81NfisrlEx5hsKfZk3eArGwODMvmw7pClQ+VGOOVPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KEfRsKET9aVDw2O3ObI2bbsClT/b+N87cfNEXr5XiLz3Wx8d
	o1sUhYDjn+8TlLOPwND4+YSZnqhb6JxO1q6fdceTjmNyk2p3tnc+ppBXg/+/9c8QEqMYCw30UaI
	A9GQ=
X-Gm-Gg: ASbGnctO4QuVca1cT5YDHyBfdF5AfGSn8a6X6Afb1WiE4POF9+e/3HZx9BRZ8S9p7rr
	Io7kM8mOSTRQUiWI2SIJxPGaTutS0YVTaiSE6DVJLqZDsYUWGxZpsHQQiwey2rhVahTiTOdh5e2
	7YRx8ELwUXL69T3X03i1BNTzu06fTibY661qouNYYeVxqZxdNK92PPWV3YMDG5qwR+3yEyiHPSR
	V3VFdBOWk4jORyUxCeJH7GB9x87ESQMESLcMy3tTeojEoGA/PpvL1KD2edVuhFhj3KQhcirAjSO
	0aX2vZ8KhVpB5GJftPfoXoxX1LJUhfY/7fjO+DGY6dI3ffpCFLpO2lWlgpqIiKS73P8uMmDote6
	yen9P8r8wbAs6OCGcBaoxQt2JtHezjlvmMuM6Ksmx8fgork6d6ORFpvtTic6hexRiSxPskRInZL
	4Kz8/Ec/wgCqDynw==
X-Google-Smtp-Source: AGHT+IGY8jlA1VpvlCHzuPvcV8T7InEZOrCfXrjkQvCVRr1ySO4P2WkXLd39xt+V7NTqeGoVDlDNSg==
X-Received: by 2002:a17:902:db05:b0:267:9e3d:9b6e with SMTP id d9443c01a7336-28e9a6740ffmr38971725ad.51.1759509586844;
        Fri, 03 Oct 2025 09:39:46 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b9e4fsm54796185ad.73.2025.10.03.09.39.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 09:39:46 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27c369f898fso27579635ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:39:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYjWblVfnJEniPAK5zE/ZGeiZQ735HW79H182eBAoQr2OSjk5KfQW2vmUcoaclig1uvltpAbrw6ygESm0=@vger.kernel.org
X-Received: by 2002:a17:902:f64f:b0:274:aab9:4ed4 with SMTP id
 d9443c01a7336-28e9a693ae9mr39060205ad.57.1759509585162; Fri, 03 Oct 2025
 09:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003151220.1580-1-matvey.kovalev@ispras.ru>
In-Reply-To: <20251003151220.1580-1-matvey.kovalev@ispras.ru>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 3 Oct 2025 09:39:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4hRA8WnvxYNgXsULrzOTCdXZ9JMHgZ=XxqpVZz5DNOQ@mail.gmail.com>
X-Gm-Features: AS18NWAd1qH6YrlVAYnGRB92B_bLv9XoV7lowG4JApAcaOoF75jMCDzEP5Jztnc
Message-ID: <CAD=FV=V4hRA8WnvxYNgXsULrzOTCdXZ9JMHgZ=XxqpVZz5DNOQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: delete unexecuted if-block in kdb_get_kbd_char()
To: Matvey Kovalev <matvey.kovalev@ispras.ru>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 3, 2025 at 8:13=E2=80=AFAM Matvey Kovalev <matvey.kovalev@ispra=
s.ru> wrote:
>
> Bits of scancode are dropped except 7 low-order ones.
> So, scancode can't be equal 0xe0.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
> ---
>  kernel/debug/kdb/kdb_keyboard.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keybo=
ard.c
> index 3a74604fdb8a7..386d30e530b78 100644
> --- a/kernel/debug/kdb/kdb_keyboard.c
> +++ b/kernel/debug/kdb/kdb_keyboard.c
> @@ -145,9 +145,6 @@ int kdb_get_kbd_char(void)
>                 return CTRL('F');
>         }
>
> -       if (scancode =3D=3D 0xe0)
> -               return -1;
> -

The same patch has already been sent and was landed:

https://lore.kernel.org/all/20250507104337.201695-1-colin.i.king@gmail.com/

