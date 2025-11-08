Return-Path: <linux-kernel+bounces-891253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBCBC42434
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A93B7B36
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFCA29DB65;
	Sat,  8 Nov 2025 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0MGKw0l"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1767219A71
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566784; cv=none; b=mVhNiSYnPJIXaLftp1vEmdGVo+/a9grA7bEt0QbgvfyUkxm7wnQnnduged/9noqgiVF8iCEoSA1ijPzkGat9NZBAtcynZM9gsBJEu32kbTsCFqZ++uKm51JAzuAWXXPFnBmt3IFD+zhGyIzrz+EPTynFNndHexcokDgfKkTIj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566784; c=relaxed/simple;
	bh=erVa2UDjQU2ylsimvdpVTbdxk9leBi/ZIglzuJkjDcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWv2CsgEMT8rMUojfqS1llrr6NxVLg5K4XPxwnzFX3wynEGScYB4YcAoV4GOs5n7aA5AUeF2Fm2xcnU0Wf4XStK3S5j0TTaQLScvr6FpbnQaoy2eu1kRgUWdZN5X9CRmCwCq6Sn3cUxWcgRalB2JXEunOZuCHYA0YpAGXw9Pwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0MGKw0l; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295351ad2f5so1572855ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762566782; x=1763171582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erVa2UDjQU2ylsimvdpVTbdxk9leBi/ZIglzuJkjDcM=;
        b=T0MGKw0lRSU4rGzlZMcMwAy8oByc6cjsO+99iApS5F+1PtFeMHpOaAP+3P0k5hIJ3Y
         DhQ910OjhZPYFs4wt4j1zMSv/wWhZZoC81R5vqyEMKdm1dp1O7lX27byZA8Cmk/P0IlK
         ZXtMpmZPf97FDNxOI5xbHD3eJgJat8npANHLMacNBVWRC374TfI0JB66FwFeic0n+4xR
         rMHe0N2frYOvxTiNokH+GFRE5voZAn5+hoDsBr8DlOSnyetHgxpbhttlqFlrzfPynJvO
         wfOn5n+DKVuho0mUpV9fXs9jsNJNpEwLP+LPIP/laSfV2ftvHLnYl/UkCqpLZCgjhUJc
         9HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762566782; x=1763171582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erVa2UDjQU2ylsimvdpVTbdxk9leBi/ZIglzuJkjDcM=;
        b=bJFsPZ5bsFhX7EzVREGHpoxLXV4kkXKx/5iRf7DiDMcrOIjbvLAmVZJPrY7V1+LuTa
         coIi8rMrT5TxH+Aoq80LnUobJ+Qv8W5nyNjLLobWn9GH1KpjtH7dP+vPqen/nS9t2pTq
         8s6PKfRFKHfZo6CfudGN76Zti52knxyxGKc+kyilWcuc9jprKBjx9i5miEbSJxOrbY+F
         07j7Gt6W388PUFtnh9HUuvb/g1HsX4mjt6ArOdJMx0ycADzUHws0KKZKuwU/p5NweE/0
         UWgf64+Lqt2cMRkgh/lk5zwLG7tHUQ1uryqeTIWesyUVRFV4X7dOXD4qclOmd/1oWaJ7
         aPAw==
X-Gm-Message-State: AOJu0Yyb17EZvWMoTVXPVI/e1WO6+Bt5bEbwSzoGNpfPBnPokgiFfT5N
	qE7VYItyhTxIPXkNL8RrZg4a3sYikVFyNmQJJhIJk59UZ0Sx4pl7JZQN+pv83SV17guz4p1+w4Q
	RNMOnfTPBL4CZ8Uiz5dr0CDCkMvY1kYYI4zUKmIM=
X-Gm-Gg: ASbGncv2dizkiN8o4xg8kqkopJYiOVoKh+c2C2JtDKN7rceQmgH2Rzm6j6QyPg8Swyg
	XvBEErGPfE6Bdb9R9fzr61bVfHKrs9a7oNfnaJ9PqN6x6TEzPGnyDDzWlQ4eBAfCbPeBqllGxrd
	iQehn4c5iYKkrOa7T0DX/O2AoUL4vCdFGRoThX/zOGXJtYQYLPcGHwqrKE95/D4YIQPnAUBdMzG
	GT2lkgrSTMXBE1TYu9sUKMTb6TUyTs/8WisQkVejLfxmmLllqT66VtN1yXbRM/kINhT+T82mnxz
	6lJ7FSbQjZ8flgySi4P8n0MhRBmYQ8xXM+D3qvN2Hfce71vYadaNZOLkkuk20a4fRlNYQ1P/AB4
	tFyy3puZt/8kLs+uceNVW46Cg
X-Google-Smtp-Source: AGHT+IFNpDiIkZtW7HZJyMbM7QuZ39vXgLJiIQh9v28YA8UhmhRr1MAwqRY3tsdbfchx3hqRT0jm/l3zZJfGidykaEg=
X-Received: by 2002:a17:903:1207:b0:297:d4a5:5e01 with SMTP id
 d9443c01a7336-297e56d6744mr7096505ad.7.1762566781842; Fri, 07 Nov 2025
 17:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
In-Reply-To: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 02:52:48 +0100
X-Gm-Features: AWmQ_bkC6-Yu4j8Hx0JYNdM0AkAP7YiL4qBeUxmwM4YtHAuwBJ6vt_387TKc07M
Message-ID: <CANiq72nEHPhdedCu50A49orzE0sZo6DrfZe+JV+jvf3ToAsYhg@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for tool-generated content
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Dan Williams <dan.j.williams@intel.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Some nits below in case you send a new version.

On Thu, Nov 6, 2025 at 12:15=E2=80=AFAM Dave Hansen <dave.hansen@linux.inte=
l.com> wrote:
>
> + - A .c file in the patch was originally generated by a LLM but cleaned

May look better with: ``.c``

> +Documentation/process/submitting-patches.rst . Its rules are simple

Is the space needed? I guess it was meant for the auto-link to still
work, but I see other files out there with a dot after `.rst` and the
links seem to be fine at docs.kernel.org.

> + - The input to the tools you used, like the coccinelle source script.

It seems there are still some bullets with periods and others without,
but no big deal.

Also perhaps Coccinelle, i.e. capitalized, like in the one above.

In any case, this looks fine:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

