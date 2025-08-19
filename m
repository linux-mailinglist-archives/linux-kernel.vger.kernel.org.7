Return-Path: <linux-kernel+bounces-776504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF97B2CE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E880F1C25119
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5AA3431F5;
	Tue, 19 Aug 2025 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfcYQNG6"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61330C36E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636434; cv=none; b=uBvP3rDFUR3nXfZ9nZrLc5yQICQnZDOxlRHe17n5DdyGfnl9/Q+XHjcjEB/LcyhZC0sleHaCCHd9bRe8jytFmLNhXqvDg8ZtRHQOI9ZuskTOdvm5gEvtNLZ6+hg3cMLsH8ZMwxWKFCMwYJwC9oV5k0HbI9mrhcR27c+OyvsUhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636434; c=relaxed/simple;
	bh=3CVZla1Amx81Jj4BMjLcKa0fUKigweYAFG3TWZCEowk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCqQ1Qh9A8v3H+0eXU2AcZcuYNLV4NoP2FstPkDKTeSmJbJupTigyRCEKlHPMbTookDtiWPhELZo+G9RhCH1UhdFWfeUmyOhobwG5GYarigtySi3gQ6gsjT8pU3FffvdF4GINhi4K3VHkfnUyFMApIywuw1TCphzPd7VKL7/70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfcYQNG6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109ac5c02so840671cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636431; x=1756241231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CVZla1Amx81Jj4BMjLcKa0fUKigweYAFG3TWZCEowk=;
        b=WfcYQNG6PRAgo5rJbShSk9CJEl32//65Rox+amNOE4gUnCkFdgajGNL0Df2RoVXmaU
         TPbbWSsTruJsr2/ECsW7QLKrN06yYaPEj5+Q4mac9sr1JqiD6QAP05jxeyJhYVSEHhAQ
         b3K2iQAw2rUITyGRgIQsdRFWem060cJXwlgPKsAVS6/pYiPNf9g07D7j/5h9+kLTHm11
         9tCgb8m2bohvsXVrU4BqdhCXD3N0Crm0AcZTw2eaV65QdaVHz/7ILASuUT0vUIo+i7eS
         2SJyIDqWZo0k5I9LsD00ziNyYlkqiAVaUgU+yZspE17Hqq6WO1ZL/ZA+JEN/WStirZCg
         Eqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636431; x=1756241231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CVZla1Amx81Jj4BMjLcKa0fUKigweYAFG3TWZCEowk=;
        b=hnYwifth5iwezKcP1GUB/w/g8PfqqV1RXO8B7m1i41nOalFnaK/ZBli4LiHB1dQFEo
         bf3g+Q/nOye6TkNXPmrCdszvIqGDhYPmqfqo9rZPkZvyGISo4FZJA+R/Tl6j7kkyCDM/
         6f9cZoqSZvp0nblgKZsYavjFbM+y4PpxdMaEmluuCyY0KPyvD6XjBfZamzQH6RVgdoX3
         xoNPlmegOm8je4zV5bo4M+0Y8dtFxgLHpinQuuxHxTYIDsOwb3q7oh/Ao+5zLNL8rUv/
         gRt5uLtgbuIgPhCDAGveUQU0rLA2a95mCSK2W0WXlhOvXDQfHnPmj63GDdoK8G9GFm0y
         4Nag==
X-Forwarded-Encrypted: i=1; AJvYcCVWRXdtYG0UxIV1cp4fLqceI2P4oocxUIX7N1UjFjK+GuhryYbf0iByOu1vTKFI0sRvTEY/SEHnqKnWufk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyweQmE3TtUDrXf5YIjPCxXvM0zgU2Pf9OFoyHA88SCpr1j259C
	5DTxEu2xnZ02nJsLDfAlHw/vfP+zoNtOwkEIH2iGaOFeNAkIN/BorSjVafdGI4bljl+VYhrlg6Q
	jkR/exmXb707m13HjXwmHNk/dvZHQl7A=
X-Gm-Gg: ASbGnctFB3Wsw06oraRWEA87pHuxrZAUe8rkSDxgMPTEU+LXys1+u6jlADRS12NozOv
	jPZrujURIuHbZyHwsxIzbi0VxjZ8uW4A4n/SUubk1Ki2jGErbyTDBzQAqiBnE0DBXq1jLFNL43W
	D1tWM6BoGJNsPdeadMzkYODpwwihc9Ibfxp5OxaVO+YMln5QgUiQg8tSXBn7/R1O95rGdnUPB5r
	is4lA==
X-Google-Smtp-Source: AGHT+IGizR9tAqGN0a9BKirrP1Gq/TZtzmYxUjt2HrNyAFG6baaw1liHtBpUlnC4i1gvgHaPjDn8zqqJOR2nMxzOD0E=
X-Received: by 2002:ac8:5ad5:0:b0:4a9:e326:277a with SMTP id
 d75a77b69052e-4b291a44033mr4971821cf.5.1755636431058; Tue, 19 Aug 2025
 13:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811120912.144720-1-miguelgarciaroman8@gmail.com> <1786903963.99788.1754916389068.JavaMail.zimbra@nod.at>
In-Reply-To: <1786903963.99788.1754916389068.JavaMail.zimbra@nod.at>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Tue, 19 Aug 2025 22:46:59 +0200
X-Gm-Features: Ac12FXye0SBJkc3pjlzx5bI4TLAbd2lVqY8mN5J-XFFy6LnzUflPjIW-IhMiHpc
Message-ID: <CABKbRo+3fA0gBuJg+J_fnNvnjkb-0QxZtxCUQ5BDAFV6VsTRaA@mail.gmail.com>
Subject: Re: [PATCH] mtd: ubi: replace strcpy with strscpy in mtd parameter parser
To: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 11 ago 2025 a las 14:46, Richard Weinberger (<richard@nod.at>) escr=
ibi=C3=B3:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Miguel Garc=C3=ADa" <miguelgarciaroman8@gmail.com>
> > An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.=
com>, "Vignesh Raghavendra" <vigneshr@ti.com>
> > CC: "chengzhihao1" <chengzhihao1@huawei.com>, "linux-mtd" <linux-mtd@li=
sts.infradead.org>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org=
>, "Miguel Garc=C3=ADa"
> > <miguelgarciaroman8@gmail.com>
> > Gesendet: Montag, 11. August 2025 14:09:12
> > Betreff: [PATCH] mtd: ubi: replace strcpy with strscpy in mtd parameter=
 parser
>
> > Replace the strcpy() calls used to copy the 'mtd=3D' parameter into loc=
al
> > buffers with strscpy() to avoid potential overflow and guarantee NUL
> > termination. Destinations are fixed-size arrays (buf and p->name), so
> > use sizeof().
> >
> > While this code is currently safe due to prior length checks
> > (strnlen(val, MTD_PARAM_LEN_MAX) and early return on overflow),
> > replacing strcpy() with strscpy() follows current kernel best practices
> > and makes the code more robust to future changes. The sizeof() calls
> > correctly compute the buffer sizes, matching MTD_PARAM_LEN_MAX.
>
> TBH, I'm not convinced. We're talking about kernel module parameters,
> not hostile user input, etc...
>
> By adding sizeof() you're replacing one foodgun with another one.
That's true
> If buf is in future changed to a pointer, sizeof(buf) needs a fixup too.
what about using the two-parameters version of strscpy?
>
> Thanks,
> //richard

