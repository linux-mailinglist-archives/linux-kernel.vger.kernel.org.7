Return-Path: <linux-kernel+bounces-896874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A26C5180F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7027B3A87C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38BE3002A3;
	Wed, 12 Nov 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsF0FxMS"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A622FFDFF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940257; cv=none; b=otGQ5ZGo1L14hNxpVuomUAjIyZ6qG5WGxAaasYuhIfyIMaTuKM2PAjhgpGPzY8Nyf/jL/h0fTOr/iC8/yooFLxgsmu0Uzy6FxH7A7P7qjYoOCTO39NHuztf9ZBFqIG4sl5ipArUwDVwp0ecUl13pzuT9SELDF+NBn6zq/Bpo1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940257; c=relaxed/simple;
	bh=hCDeVTqFeb8OCPymlEUvRNJIVTTjvVc1/ClAQBXXnOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZFMQjVtWbRx7y30CPo1dRLcO0WGAsy9VtAhmJdPhVoTKTxYVXu3ZLP8lLpVMcsKOS40I7lO/lRy0kEOKtrXPa3VnW2iId9C7jMGS3HRpAg/smx4+TNXyC+EbquTlGlJizJTGIhkWm0KCWegNZn3vvR30Qx973GrYbJ4glKhb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsF0FxMS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6a42604093so81266a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762940255; x=1763545055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfWmqteduDoVLqj6JdhBgBiH8a4Ayud5Tb7Bt0CJ/gA=;
        b=WsF0FxMS8mzXEeyWRR7r4qLWRZO3QGbSO39+9raslSbMBDM7uF3e3vgkocLsjZ278a
         BYAU8rBorVNKWsZHM3+I44i1OurmXTuWZ0LwgLNUXYW883h2R69L3GXXqe8g1lOiCJxB
         kyjv0K7P0ra9GSOpHWaJGGTHToKrOraFxDKibnMZm7LDj+0scKTDB/M0GKb292nJ3oYR
         meLuSl/C+Gt+QB7Xz2gharKc/e99nCXIyNXzO6K/lpA7dUMO66xjnCREecQTSquqa7pM
         xBfLuDoHfiwltF6xrNz8k5/hfD19IXO5+KB6pyMaq4ncy45n64VZipbXSl/YS0/UEbxQ
         qQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940255; x=1763545055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VfWmqteduDoVLqj6JdhBgBiH8a4Ayud5Tb7Bt0CJ/gA=;
        b=as7+sjM65pn1GTTmJxclXGPnWFYIvB8r3ioyvmYS8/L20+WJhOUT3Scl3utnWLAKqS
         G5XL6yL1ZWwhQ3cRVRXc3HijXvMzQb5F3eJYgQ4+Hw7/WCloxjxlwPBBPvG/GzodTC05
         n3r//Yrx2I7mzF6xQ2cNhYIlwUsB5CTm5NlPxYfFV7XlMbvOBg7l60LduamEbW5uhhwt
         /j0n/hZ2MGvsO6+mpjjS8H8fND1G8e4oAZtm30FxCTZpd/NeavnRm4qAbwdFlU9G3YLn
         TdeAbfG1dvq8bvniUHZ+AXHvqH/feFOAf3nlulBtN+scR8EZODf7lo48id5bzM0iMpQC
         8cqw==
X-Forwarded-Encrypted: i=1; AJvYcCUUSpm0JbSIT9jomkuKvgJpGatYcMhoDTrFnEzB4FCLJYymmEP4nkGO4+XW2wi0w36umKDRGQVQwBmAN98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqOmrdNRdBqouy/4/UgOWJuUSQqdse1snwg81hILkuvpeyKXj
	6MVt9edoLurhAOfD3vhfwKRCqGwAXeYhVKQNfYKMmwjbyXze6hCMdamQ+3dFrpqwzrZSH+pelrb
	Ux2SGuX6saDKcwW1l62EG0ivpdgmIiHk=
X-Gm-Gg: ASbGnctnbBNP8xYHBOFGU4Zptu6fW70oU9uigYM4QtMOTBES7mEGPrAJlk3214tUWj+
	lnB/ucqxEg+Yj4DLfWARHKeHnQpMZltH9FU1q1fQ9Njw8GhtjNw7+63mf8qpKGXcCURBFtHpvDX
	Wd5f6K/jQ/nuBQ+0Q/lt0Z3MjXE8GCPtnMQOiufG4BVzyKho6yroDh3K/VPcxdvJZDQmOIRbjEF
	lt/t8JM9Q2kXyRldkW+/sFv/ZOuLD2dtbPJpfPgHqvQtnZBThV1uuK7zemMkTZHv3idbtmLIGXD
	1o76bs/4l3maWn+OQVomBaRFzRnCxILNhCnIXz83aygBglShjE8q0vNSIHsZqoM4M/FAXcqL0aN
	EwKc=
X-Google-Smtp-Source: AGHT+IF7dXQUMFsuDu6yVFEy1qQhkvdBAqpDcIJQlWtpA21Ok2PTF3w0o0PHF/4blQHATl8xPBVAytdXYF1ksZ+cx+0=
X-Received: by 2002:a17:902:d507:b0:295:3f35:a31b with SMTP id
 d9443c01a7336-2984ec8c0d5mr19207665ad.0.1762940255046; Wed, 12 Nov 2025
 01:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101214629.10718-1-mt@markoturk.info> <aRRJPZVkCv2i7kt2@vps.markoturk.info>
In-Reply-To: <aRRJPZVkCv2i7kt2@vps.markoturk.info>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 10:37:22 +0100
X-Gm-Features: AWmQ_bmCvbaIgHZdY2OvUnghnEILgb9lSGGzpn6r-4k_0J9xQP5iYx7rCXgAVnM
Message-ID: <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Marko Turk <mt@markoturk.info>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 9:47=E2=80=AFAM Marko Turk <mt@markoturk.info> wrot=
e:
>
> On Sat, Nov 01, 2025 at 10:46:54PM +0100, Marko Turk wrote:
> > QEMU PCI test device specifies all registers as little endian. OFFSET
> > register is converted properly, but the COUNT register is not.
> >
> > Apply the same conversion to the COUNT register also.
> >
> > Signed-off-by: Marko Turk <mt@markoturk.info>
> > Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")
>
> Can someone take a look?

Your message was in my spam folder -- that may be affecting who saw it.

From https://www.qemu.org/docs/master/specs/pci-testdev.html:

    "All registers are little endian."

So this seems right. A couple tags:

Cc: stable@vger.kernel.org
Link: https://www.qemu.org/docs/master/specs/pci-testdev.html

Cc'ing Dirk, since he tested the sample originally.

Thanks!

Cheers,
Miguel

