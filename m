Return-Path: <linux-kernel+bounces-898476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13202C555DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3963B991E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CFB3D544;
	Thu, 13 Nov 2025 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOW+ZxaO"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328B2877C3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998548; cv=none; b=coag4JGox7e7CaDIoNfMzt1tBPRu2fXHSJrlu3gDfsCGTZaH9whKO5o9ex3cojcAHHzyA7sK/bQtpAz/tdb/OEZ6uRmg5x3/TbkIQMfX9R6Eba+N3P+JUwn5KwbPQXq8787dsWxwaT3sR0cJxQ5KIi9vDYJwEwTYeIJ+4EaiO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998548; c=relaxed/simple;
	bh=/BXa76nBAYuWd/9wvqfbPPw7zbjbNNpN6F7iPGRfgtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXWeqMGuo5A5rWG8DH5Vo2MqpoF9T9HXeaUr/MqySuhoWOuIb3NCM+4ss840ZD0A/6SLfoT6KdOAlFbTvzBbXNFabEQIjxCVV2lg115GbXBiocMDLUFbEo4c7JvcMSzPQv/ALTO2AlwrO9cjG22edHWT9gOK4un0sv9ryFEaFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOW+ZxaO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso35732766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762998545; x=1763603345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BXa76nBAYuWd/9wvqfbPPw7zbjbNNpN6F7iPGRfgtg=;
        b=mOW+ZxaOIb1Eut2DwNyQaEOe+GAfe1E51sL91ZgLlHGt+PrA7Jd0l3bsFU+EVLYogf
         oyolsb4l0daYwhvV3B6YgKZzyahMhgwnBPkpfu8UerMk3fShYUiX4F/q1X1yi8r97oX9
         LtmjmOENZqCHCYszWQETlxHXk6CIuZhMe6l8TRwGJlSQZuzi9MMA8jJm/FEN3Gd/y5iD
         IrevKtM1Y7jvCe6ZPZX3BGUMWplUIEBPsZ8MWbF7WPZ2FR4D4FAWUQgVLkyPsXicJDhW
         HcL9dIDTwhRS7H0EaJvMKz5i/F456QZXKaxE8on2a7WgYYF9ussF48izj6KWKrwH+tZB
         mm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998545; x=1763603345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BXa76nBAYuWd/9wvqfbPPw7zbjbNNpN6F7iPGRfgtg=;
        b=ZFNi7eH1i+5o9wIqLlP1L4T6lyNnjXXDhXYjnlT8Ju3TZDMAX5QRtHJhsyGGu3/gH0
         1p7hxsRRqm5MJp3oupIcjnR6qB0ot9L0Y2Cs5Mvz9SNB6eEY6E1FMcpLF1qVfRwUwLX6
         UnM45L6L0S3yW8BzKq6L+j1AibNw3cWMPqoovYXm/rj3BFMDKHo9IrUZawVs78YOLqb9
         B9xPus1bHozxxpIZR1WoEA12NR0qSkiAhOXH7eGN+0lQI92Tump2RmW4XeW2d31xfHOx
         N1P0P7T99Z8Bg2AiXbjYbJ9XNYIj9juw9b3m5wlzYfm7faynF4B8DUfBUakXrPqG00rP
         Beqw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7WZO8wLUFxUM4ns51Z3SzgMjTtT8yIf3lu2qMpH51BY4qe+mr9ZyAK/8hR3dORxM+xMKqk/aVhRWVQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmiXvQhhdFK8N8ceRixRC63ByjVFdcR/LWSCoVrKiCItuBBr4e
	x5N0zsbKpFOSI5TkY+lt7fuFj/qwJSiVUoi1+KTF/K7/A6/KooIJto6OfHkXmhm2VPD2NraP20H
	bu6ybU2hXsQY+h9CYPWwLM5ThARCwFnc=
X-Gm-Gg: ASbGncu7zRfupN5fayALp5i3ZJbJnSN2TH4cpZ9/msqSFY+hdmLN6jxQ/sdGkoN+qrj
	UNg/jvzCasqVY26TUL5UmVTlPJ7AQEXoqQgPjEIiXqI3FyXaovA4B7PGDZtP3zFvKTnRiu2ruyK
	MFmqgDRls+MGg62LAv7odvnuOCc1I9FIHCwKSeQXrKilxKRvz3PmuZ6qDWHo4l5/qp4tdxu9LdJ
	atjzT4nbk3rPRL402qShi5669WKEWvFYQXNjlMBuiNdbvyHXzkPxOyrTSWg213yWYx+rQ1S
X-Google-Smtp-Source: AGHT+IHqPrXkwwUDap0ca9SLlYtO97n9ztGxu1x6wVw4xsLvIfW4MVbyJ3ujywmUi0PiOUwK6qabcxMBYdhHwV+o39I=
X-Received: by 2002:a17:907:3f23:b0:b72:b6ae:266 with SMTP id
 a640c23a62f3a-b7331970a45mr560470666b.10.1762998544691; Wed, 12 Nov 2025
 17:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
 <CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com> <20251112103804.4a43591a@gandalf.local.home>
In-Reply-To: <20251112103804.4a43591a@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 13 Nov 2025 09:48:52 +0800
X-Gm-Features: AWmQ_bmfsBpIDeSjzAUhCej7Cw2PwEc1ZTHTzRB4GUxjSqLSY-cAbHgULGIT7O4
Message-ID: <CAErzpmt8Dsq3f6ZUvtmc25hvy0NH6uRxBHPSxeZhkFfzkdJ04g@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 12 Nov 2025 17:00:10 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > I have a question regarding the behavior of the funcgraph-args option.
> >
> > Currently, when the funcgraph-args flag is set, the function arguments
> > are saved.
> > However, when the flag is cleared, the trace output still displays the =
function
> > arguments unconditionally.
>
> Yes. The flag affects the behavior of the recording and not the displayin=
g
> of the arguments. There's no reason *not* to show them if they have alrea=
dy
> been recorded. Recording the arguments causes a noticeable overhead which
> is why it is optional.

Thank you for the clarification.

I noticed that when funcgraph-args is enabled, it registers
trace_graph_entry_args
to replace trace_graph_entry. The only difference is whether a valid
fregs pointer
is passed.

To reduce overhead, I propose consolidating the two entry functions. We cou=
ld
maintain only trace_graph_entry and pass the fregs parameter to graph_entry=
.
Within __graph_entry, we can then conditionally record arguments based on
'TRACE_GRAPH_ARGS && !!fregs'.

Additionally, I've confirmed that trace_graph_entry is exclusively used by =
the
function_graph tracer. Other tracers like irqsoff and wakeup directly call
__trace_graph_entry with a NULL fregs pointer. Therefore, this consolidatio=
n
would not impact those tracers.

What are your thoughts on this approach?

Thanks,
Donglin


>
> >
> > I expected that the flag would control both saving and displaying the a=
rguments.
> > But it seems that the current design only controls the saving. This
> > behavior seems
> > inconsistent.
>
> Not at all. The option is only for the recording. Otherwise, one might
> expect than they could do the recording and then after the fact enable
> "func-args" and expect to see them. That would be more inconsistent.
>
> >
> > I think we should add a check for the flag in the display part,
> > specifically before
> > calling print_function_args, to ensure that the arguments are only
> > displayed when
> > the flag is set.
> >
> > What are your thoughts?
>
> Big nope!
>
> The retaddr is different, as the information is somewhat redundant to the
> call chain and may cause more noise then needed.
>
> -- Steve

