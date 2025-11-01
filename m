Return-Path: <linux-kernel+bounces-881363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FCC28148
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF2E188F065
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A12BE633;
	Sat,  1 Nov 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks7WCdDl"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4928A704
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762009623; cv=none; b=MCfuQMHmjk/XooPabqo4//LQlrV6iQ6jeec/SH3/wxlls3tuIMmcBj8GPmcTqvdKlrvzPtBA3vjQhBU065aZdf+sYG7p2tXKiwsB3FmID1wqHhcggDMQzi9EzTRFsp0e2Io2XpzFtxe6f3Igpf2m7EBXcl/xtGYms9lAyxFprOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762009623; c=relaxed/simple;
	bh=becdGP2alRJ2u1AdEeRmaLP7ThHZQI0eIuX4AXNQ4Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuY+xizwmJfVCFwvdpws5tTtmVDTh/xnR1ejCGc/mc63LF0jHbz8+DgsnrMYRETDEBTTQd4Wra6cT4cc8moJEdNNZYzgpfHyLsUzmOhcedcZ4L95pzMD70SiQflNY+54EgC1Iz3Dp3CaL1YMWZbTUsG4tKX4K5Op5HaXBnBH+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks7WCdDl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a2687cb882so473876b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762009620; x=1762614420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YiAzuZ3UregSrMpF9J31H4Yx7ePy+2MOlCUjA8nJCA=;
        b=ks7WCdDlLigxXHjPcJDq7rRN4iM1gi975yI9wejfBe1LEToibzFS0ChatgRmyTzoae
         XLOCzoxzexqMKJkn+qf8/0Yri9P5qWy+4GjtuM4mzQIUZUryAiFUulQSlBda/Y5f8JOe
         gpMVz2vBi0+Ng9kDf9V5/cz+C9urIxoeSTWLcC4YP9N25m+cDDKDRcu01h+RLZK4ACZl
         2vCZ/v0mA4Y/W8Mm8/ycdSz8UhoAZyQmqMk6S80208QggdpnjVNDMGaC5AcNus78VzvO
         FO4xOVjC63QhjQxNfrMKdSOO65p4epi6t/YHvTtZZYp82MzVVN+gaoHfVfevoQMUINo2
         Y1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762009620; x=1762614420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YiAzuZ3UregSrMpF9J31H4Yx7ePy+2MOlCUjA8nJCA=;
        b=wMZZmjxp+ZK1gOvtC9bISbZit0nQNNM9SOboZWoNdwJ/6gvYKWH6u8uH3PWfQgCthZ
         7LKyeJSLJjwl5xwJSmEhLxMcYxzut+VROLzLYiKKv+WHt3SqgcHWXTBU6H/FXQUSw+2a
         xRsv7UcjOZkb/bnwrycmR1K0c3I3M6SLZxSlnrT1MgzfsjvIq8XqdRswhPnBY+6A9cIV
         Lm09pjLI5LS+N1X/QsWpEjSsVnb0Ykxyj5DrSM2vi/tOWG5VS7T8pnjpDr7geobwyCN2
         OuNhscp0YmgeqBdndcm02ZYetX92fkncIgwx4C6Sg8Ay0W1s06Jh72JRoc1NdfvZZUZk
         kUvw==
X-Forwarded-Encrypted: i=1; AJvYcCWSvdFMBrF/nJHLQn8zAaujDo/n9tuWncMXCjEiczomJ/mNeG09uLnxYF0uviQx1jEXvXawk/yW9fqLa+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAa8OoMvHMAwOVrF5nGn6idngqkndbymEHsx8Uwy36zibTPSI
	8eVxGqhGxZsyYpyami2Y4SUSSLGDS87vfSBRk9DA6SyEpQHibIwGW0+q24VOI0gmXrFWxDnFQy+
	26fWOFZwyFgPsiK/mMEeMGVmycloox8I=
X-Gm-Gg: ASbGncuaW9hH75rsTwWTCa9cvFgh53P8tThRnU059Q6p9k1KPbEiyLWqkZAAxpcuAqP
	W6aeR4seLB7kpArLSpMjfCjYsj/Lv4745SsK9d/0zlmHxd2UkCZi+9d/E/j2IeSn9Q4NlkfTjSO
	tBwf7iFRTvYtpmRRqdzHGFM0EJtPYMM5k6zEi79bD1zI+tlwxej1/TYELeGsEjjd6DFDcYBDfKC
	0HH71WJprTbVChAchHlomiPYLnGOU1/sPZAvPpq/aYUlGdajlNNuWx6KcByOksglrxvIx8S1Tss
	SlRZWF02MPqyacIXLvqgELdr+lIRKy0d2wjZ4NuadlxZ9rUzI7KsfCJKvdZAvW3s0dKABlMnEzg
	H3Nx2cj/RE4d13Q==
X-Google-Smtp-Source: AGHT+IGi6G3P46MnlLa6pHrqzoZMNbq5z4mcGHcJTxA29pvYP66KNHtzQiBAWUFWhhFhSjojWQFNPtYK8TTJX1H3rRs=
X-Received: by 2002:a17:902:d2cc:b0:295:6d30:e26e with SMTP id
 d9443c01a7336-2956d30e5famr6001545ad.8.1762009619849; Sat, 01 Nov 2025
 08:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
 <aPnnkU3IWwgERuT3@google.com> <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
 <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
 <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org> <aPoPbFXGXk_ohOpW@google.com>
 <CANiq72k8bVMQLVCkwSS24Q6--b155e53tJ7aayTnz5vp0FpzUQ@mail.gmail.com> <DDXFFQCZJW8Y.3GMX8666EJQ2I@nvidia.com>
In-Reply-To: <DDXFFQCZJW8Y.3GMX8666EJQ2I@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 1 Nov 2025 16:06:47 +0100
X-Gm-Features: AWmQ_blyOPSYdkZpX6T0yNaf0355JZzLQBA5jSJ7sUHzLUv-DNemVpz3bwTrLh8
Message-ID: <CANiq72=MetoQajmJ5Hwmopp32YZZmbNu5a5EtQve5rxP7z0uMQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 3:27=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Are you referring to this discussion?
>
> https://lore.kernel.org/rust-for-linux/DDK4KADWJHMG.1FUPL3SDR26XF@kernel.=
org/

I saw that one and the patches  -- perhaps it was in meetings, but
dealing with guarantees that are only true in the kernel (assumptions,
conversions) has come up before several times over the years.

Cheers,
Miguel

