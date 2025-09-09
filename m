Return-Path: <linux-kernel+bounces-807339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACFEB4A32C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B941BC6CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE1A306B33;
	Tue,  9 Sep 2025 07:13:14 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108333074AD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401993; cv=none; b=H1tbDsM+qXGKFUlZDbwDBhX73rvOd5zt+wA1yETQoxLmUknfu5ANh/gcRUXC31kJjjw45Z9eLLyKvVuivr/gVbEzPs1ES8dPj7V2sBUj3rQ4F3tKI8wH3zLxuPCzHeQhBjcOTVzLgnq+QK2uGXYWtCKIg+JQyYMqsRthpBRzizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401993; c=relaxed/simple;
	bh=8UsXHnbkZ9Q6dr30czoTDR0JzOYoJQiyrQa3Hb9+4C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XObh4x5t0vj0bRZ0HI4GZFN/H3DEd1bbAuMhRm9Hkzvm2k0yYANrHCHsQ/YOP7qvihT/paOye9eLaOUahyZo6U6xTLCYWTHBpt8fJrrpjRx5hIVtIHo7zTYHsCjsQr/NUIqaxgskBC87Y+XpymmV2mmGkAwEIbRDZB0Kx7QaZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-544aa9b536eso3874626e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401991; x=1758006791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ62va/ZZRlPICIZ7sjQCyrFeKO9neZKpvCI6L9xzFk=;
        b=rTcrE8V8NksAfZws29qD15oUCtQ+BTXBFsMk/icMvz+eoja4AcfT948FakYZUCdhds
         znvyuTAfmzCf0JWRlHDIrt6E60ipCH+KnjanY2mkvusKEZFNj5GYCCMT12tfDiqUuhAY
         3P8QpXjDH8vPKzHo2Dd7L6HQfQUmpOqLWr23rTBDw8AvpEmuZXgp6QSzFA1IPjhy7jh7
         fF0iqoblUMuQCbcQdAWVuTVC3D3a/Etl4AWmC4wLsTlhOs/5Xcsdjyq7vCiwVQLg++Cu
         zG1Suw5TLz6zotdX+LwwX13zp6bP+fw+wk59Ki/w8AFHa0pakmCiv6uZB6M+tkxQdPna
         oSWw==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZQDIWysCRfuhiltTmweBhc5DdKdADbhj1pAKbKfPkp2HyWgzsxsDOeuTDPdJ83q3+SSnZrINNd7Bv2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDeiOU9LFMUhdNyMX/PrBMn7dzPm1Cby3ZKYJSXDATHT9zuVY
	fcqpOQ0/g52kEHsZGaZyvQq+XBDjckcVCTyXMX5e37+oOm9ghVFedAxdAz0nqpgp
X-Gm-Gg: ASbGncsRTGX33GFOfBYljigIkhFtiSa4lILWPlcCo5A5QcPCFKhl2mVEdQfNcHPpNOf
	lwK+QkCh7iaILQNRuDywQa2P9cPMGfiUj7ZYFItYNbS7w7Q3oRH13sGEwNnhiUr5B3MSC3qiN8H
	MNrXCg+BR3a+ESm+sbo1Hx2SkgYfQ7IECZB+Bhecn+2q3IpCiYyEye9thQ9+BfuIwHYR+261Y+x
	4H/g7laxjHoFVl5neHJrvF8+zjbG1mJR69QNS2CJ/an1NB1cQ7Scen0tVJQZDZLtuwA4D1uZqQw
	oZ7zoH1H/Yd27GcBWGgWTirOzsSIZLZRdYAsn4TYYw8bWdARG+5TnUjwOwZFbWqmJdkBX+lyZpM
	zGBcn258xmUroVBM/iWelLv+QM8dgbv/CI4hKzhlkCYlCjCq1Fr0YYKIHNVUw
X-Google-Smtp-Source: AGHT+IFO8CZe17LizJ29ll83AQJ8rJBqS/TKG+dIl3Hb0G8m2wGkvd0oDOEMhbloJxs5xF/zJYopCA==
X-Received: by 2002:a05:6122:3128:b0:539:4097:794a with SMTP id 71dfb90a1353d-5473caaf29amr2975650e0c.12.1757401990756;
        Tue, 09 Sep 2025 00:13:10 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54491318ecbsm12802582e0c.11.2025.09.09.00.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 00:13:10 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89018e9f902so3024169241.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:13:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXowZK+bw2ViEHrgCL4kKNWfoP5W7H36S4Ezcv9qZPl0Qgmm1TBK68wmLPef4ru34yFkyGGrNccjRL8cLE=@vger.kernel.org
X-Received: by 2002:a05:6102:2910:b0:536:7bfa:22bc with SMTP id
 ada2fe7eead31-53d0c7958femr3979296137.4.1757401990302; Tue, 09 Sep 2025
 00:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901020033.60196-1-jefflessard3@gmail.com>
 <aLbOU0vIXX22uVvf@smile.fi.intel.com> <F8CD496B-97D7-4C69-926F-4137F3006AA1@gmail.com>
 <A8F9D18F-7C12-42B3-A9F5-AAEE1AC29C2C@gmail.com>
In-Reply-To: <A8F9D18F-7C12-42B3-A9F5-AAEE1AC29C2C@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Sep 2025 09:12:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4wn5F6K6MHheQqOqb933v0JAVaRP1gaK=FW+bTx8A4A@mail.gmail.com>
X-Gm-Features: AS18NWDYispOvcd3F_GwPLSnd16ldhUSiqVP9-dZeJf6op1KA0U5NB5KO3Z6CL8
Message-ID: <CAMuHMdX4wn5F6K6MHheQqOqb933v0JAVaRP1gaK=FW+bTx8A4A@mail.gmail.com>
Subject: Re: [PATCH 0/5] auxdisplay: linedisp: support attribute attachment to
 auxdisplay devices
To: =?UTF-8?Q?Jean=2DFran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Fran=C3=A7ois,

On Mon, 8 Sept 2025 at 20:50, Jean-Fran=C3=A7ois Lessard
<jefflessard3@gmail.com> wrote:
> Le 2 septembre 2025 13 h 44 min 45 s HAE, "Jean-Fran=C3=A7ois Lessard" <j=
efflessard3@gmail.com> a =C3=A9crit :
> >Le 2 septembre 2025 07 h 00 min 35 s HAE, Andy Shevchenko <andriy.shevch=
enko@intel.com> a =C3=A9crit :
> >>On Sun, Aug 31, 2025 at 10:00:24PM -0400, Jean-Fran=C3=A7ois Lessard wr=
ote:
> >>> This series modernizes the auxdisplay line display (linedisp) library=
 to
> >>> enable seamless integration with auxdisplay parent devices while
> >>> maintaining backward compatibility.
> >>>
> >>> The key improvement is adding attach/detach APIs that allow linedisp =
sysfs
> >>> attributes to be bound directly to their parent auxdisplay devices av=
oiding
> >>> child device proliferation and enabling a uniform 7-segment userspace
> >>> interface across different driver architectures.
> >>>
> >>> This series introduces attachment infrastructure for linedisp devices=
.
> >>> The first consumer of this API will be the TM16XX driver series.
> >>> See the related patch series:
> >>>   auxdisplay: Add TM16xx 7-segment LED matrix display controllers dri=
ver
> >>>
> >>> Changes include:
> >>> 1. Encapsulate container_of() usage with to_linedisp() helper functio=
n for
> >>>    cleaner context retrieval
> >>> 2. Improve message display behavior with static padding when message =
length
> >>>    is smaller than display width
> >>> 3. Add 'num_chars' read-only attribute for userspace capability disco=
very
> >>> 4. Add attach/detach API for sysfs attributes binding to parent devic=
es
> >>> 5. Document all linedisp sysfs attributes in ABI documentation
> >>>
> >>> All existing linedisp_register() users remain unaffected. The new API=
s
> >>> enable drivers like TM16XX to integrate 7-segment functionality withi=
n
> >>> their LED class device hierarchy while providing a uniform 7-segment =
API.
> >>>
> >>> Thanks to Andy Shevchenko for early feedback and guidance.
> >>
> >>Overall LGTM, only one question about spin lock vs. mutex. The rest is =
simple
> >>nit-picks. I'll also wait for Geert's review / Acks.
> >
> >Agreed. I will wait for Geert's feedback before submitting V2.
>
> Do you have any feedback on this patch series?
> Or would you prefer to review V2 instead?

Sorry, I haven't gotten to reviewing your series yet.
Please don't let me block you, and continue with V2.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

