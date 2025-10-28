Return-Path: <linux-kernel+bounces-873412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F4CC13DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328F85862F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E82DEA68;
	Tue, 28 Oct 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL6qyV9f"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202342C029F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644219; cv=none; b=GExn1vK2LLkvgGlNQT7svqoBa3r00fQ0kBEMNJTr+sGQVR6tqIeL9UPNJ6iUkKFPMtTKEaQGQlpTpzqH19Siljrw+TDsBdkRT0/e8iLZ0RbWEPjiTtn/fhsQGxOhliEMSiTd6ZDr9iYj4jrbXNXO1aZn791EbiRyw9MBlUX2Quk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644219; c=relaxed/simple;
	bh=/5SjHDf+g60VeDF7tKkxP5WygZLqUjkEHTHrJsfqiiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRegmFk7ylptR3pj7/x6PqwOAznVzN37aNYYKyRGJ8SuW3UuONjDnEyekGjnyoO3V1Ty8z3vldI1yh5HId7Ejpxj1EJwugz7yMfENOpMzuXD/YqSx8AdtGaRy1S7vxFasPvtN/H9mPUCOv5MVjKnsFjfSABYhq/Ykm227+16tBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL6qyV9f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290c2b6a6c2so59974615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761644217; x=1762249017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jG9v3PVJPIbaBd5kVxUl8s2RTs4/RBdrWqQvfRNMgQ=;
        b=SL6qyV9fyuwT/n4rxBfYCX5zs8fHpPP90jK3U4Vt5CsoZ2bMrJY8HphPYd8HSPWIew
         CqHK4aSg2tUYWrn7nhYIaF06oT4oA6UpQobpAstzci02/884Gvfsv6EHTI68pBk/r8kf
         ylvcC8re7p1gkVn5NEX6uFqLU4NH64TxfMzyVQNDSwM0897cLqlbrqeVIClVWWvkz6rc
         9zkuW2VEmqNPwvKUnEJ+RcmYBvzw6JJg17rectYf4+CCbZZvc0ZLSQTfQ1+32n3nSzly
         zKPFnkZ7JTzgvjK40fTAFsiXAavgAbEeIQ6Y8VqqnH2to5Y1Jua5yHEeRq94W80dOFzQ
         7PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644217; x=1762249017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jG9v3PVJPIbaBd5kVxUl8s2RTs4/RBdrWqQvfRNMgQ=;
        b=FkprTT78ZbbjowZ7NFMzjFU/w2LoRwJTD3iudCWsgS70reO1BtqCPWTCOpwn5M8uSU
         AVAnau0HyyVLvquClG2TG0kb9lO0r+72tGBhwkC6vj6HrtphQenFxVXXl5h9f0Avxi5G
         I8k1gLrQCDSXbuXAa44JBjyHm/6r2ONbDJwOMjYQWZ5VR6/HAmxeo7PBacP63uURnuJA
         0fN8tAV09cyd4GFmPatbm9OvNB/WJ7JkPQjqpiLA/yK+vkSANUspKRV9H1/DOjfEsebw
         5szAtFaSDaFHMTGo+lLghUqETE9OxTiQlidXFU/w/ksRUYrZ3U8gZ+4uNhPjRmWYqspN
         9UaA==
X-Forwarded-Encrypted: i=1; AJvYcCUMPoRR7fWL2+5OAhQ6FKg1nioFOxFzmD9M/NNvrTGTF7gddIiDuUvGwxUg01JNd3+2DADvGqALOe/PPVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC26DeYYSlNPRQd3LYkGROj6xUavsiaHrQBPnV01aHTxXe7sBz
	0m49mro1d5Bds19/kv7id1o6lWWVLGxsuTCS8/cdzjSqSN5BYHLqrV9EtIa6P9SaHu23kKFAV8l
	t1j0/iwCNvt3PHR16m7umkoqHySqNMxQ=
X-Gm-Gg: ASbGnctxpv1cUSVmj15Cyddmf80sTvCcqSXYaSSWAuXnUfr+cwBSAY2R0XP5rmW976o
	Du7jjjIUOYkXNDfAPJDX95z2aUilc1pcjAfjF6c/6ETnhET/IAg544Dow4PTpt81Fv/cgHNJJcZ
	pwK5cydmz9BVeZOoCWrMP7pzGYJT24ltn5gVjv7SMT8+uiNj6rTy2zGgVQGNByuIDNRqJtRGLpp
	lA5yXdpI5eUUMkx62FAjNzgqoTe1fdsQ1/eOOjyfx6BbUSaLItX9qWiwnF9qq1jSYCu518=
X-Google-Smtp-Source: AGHT+IE2gOBCubvPoKT3rGM6v15n2dbkd2eHauDGUIwO5XTEfAeytVe1qP5Mq5hcSyYkW09TvDxnGMeavjeB3G54Bl4=
X-Received: by 2002:a17:902:ea0a:b0:269:8d85:2249 with SMTP id
 d9443c01a7336-294cb3821afmr36873395ad.22.1761644215891; Tue, 28 Oct 2025
 02:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027092159.918445-1-kriish.sharma2006@gmail.com>
 <23069e05-82d3-422f-9af7-fc100d4d1466@baylibre.com> <aQCITnF4kft6g64z@smile.fi.intel.com>
In-Reply-To: <aQCITnF4kft6g64z@smile.fi.intel.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Tue, 28 Oct 2025 15:06:44 +0530
X-Gm-Features: AWmQ_bk4u-dbbnMYGRNeHJ1bkT0p71uvtHg2Ff8MalXPQTncpZhceKlNJkV7h70
Message-ID: <CAL4kbROq0ko9RT0VENAUsk5j621U8LNkQKz7CxQNk7=C23p7aQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: fix kernel-doc warnings in industrialio-backend.c
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, olivier.moysan@foss.st.com, 
	jic23@kernel.org, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy, David,

Thank you both for the reviews and helpful suggestions!
I've sent v3 now, which includes the consistency fixes (changing
Return: to RETURNS: across the file) and the other points you
mentioned.

https://lore.kernel.org/all/20251028093326.1087660-1-kriish.sharma2006@gmai=
l.com/

Appreciate your time and feedback.

Best regards,
Kriish


On Tue, Oct 28, 2025 at 2:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Oct 27, 2025 at 10:35:02AM -0500, David Lechner wrote:
> > On 10/27/25 4:21 AM, KRIISHSHARMA wrote:
>
> ...
>
> > >   * iio_backend_oversampling_ratio_set - set the oversampling ratio
> > >   * @back: Backend device
> > > + * @chan: Channel number
> > >   * @ratio: The oversampling ratio - value 1 corresponds to no oversa=
mpling.
> > >   *
> > >   * Return:
> >
> > I guess it would not hurt to change this to RETURNS: to match the
> > rest of the file either.
>
> Good catch! KRIISHSHARMA, please check the whole file for this as it's no=
t a
> direct mistake from kernel-doc perspective, there is a mistake from consi=
stency
> point of view and hence needs to be addressed.
>
> ...
>
> > > + * RETURNS:
> > > + * Pointer to the driver private data associated with the backend.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

