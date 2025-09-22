Return-Path: <linux-kernel+bounces-827954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC20B9384B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028042E17DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F531B126;
	Mon, 22 Sep 2025 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SKL3cJ+T"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B33128B6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581359; cv=none; b=IC50na0/UovF6OsRBBgtenw8hGszBC17BPWR+e03lIFHMxRMXuccQmtzMQ11WO2u+B8PI8VyKYPxtqavr5DBzmycx4GxbBuUW1nF4k9FWcMH8TZD3ZuqSsigd+U6zyd0fGaNBSAVfyjAcyM49UsNBtEDBA8w+MXxUV7YcL83EUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581359; c=relaxed/simple;
	bh=/uU6aIX7NDAjGBdLVVA0eofl1nbX5mMBt7k9BzhZJHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqOCrSKIPmkWqGI5WRnApAiD93F+xLMqv/IDv2xbhCCBxjcDA2Zl5BKkdOUowcamTr47VVKL8HphQj4b/4Su3wIe3LsfabcndOUDhX6gkdRxbJ6OP3D1iE70CiCZkb+un/7wDROnxatTUfoyyjTwEdLxTT5kKo+wEmio88hSk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SKL3cJ+T; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07d4d24d09so838200066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581356; x=1759186156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0y8NZ6Fz+ZP+x8hvjDNp3A9p1CXuwruQFCOMqZO/X+M=;
        b=SKL3cJ+TSTSJvsnm5AvbjFNIzEU2sQmW5QgsAu4odnNnhAfxsuxDX0bp/x0fNiNzeT
         JNiG/hRitjJdQGjSEXSPNqSfLanEliX4JLOTKS5gp3GTjfEQSMzrSKl0OEEl8B2jq1zr
         pokbJXYtJnE7LstIZmdBKeLH0idYwAll77HEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581356; x=1759186156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0y8NZ6Fz+ZP+x8hvjDNp3A9p1CXuwruQFCOMqZO/X+M=;
        b=AF5uk/+gws8fJWImER7FsZrtertrHUNB3JJeMjNgfqD1DlaPOyrl5dGl7U6kUvUZzr
         EcS2/J5Awuv0z1KI4g65XDpK4UoMWC7oWKmJlx0+h/5y4Fi+n9UvxlYDkycsUoB0h2pd
         yCr9tUOrvpm70/L/Yt+GXRG9R1cOpPbSkSVdsc3wImmTV8SPA+2ZV/fVC0S4y7EtUuTt
         y74CjafJ8mGBoQuXmAb/rotEf0+EadReTCWom7UWRMNuUODXVqIujIhos0aDjX3HNzEE
         AA5dTiI5M2JxeXu5iCUJ0EX9pSLBMl0MeASUHWJ9C/LaN87O/z7WQlw0mHZ0iVuBhYbR
         7JPA==
X-Forwarded-Encrypted: i=1; AJvYcCV24IrtDuK1ZLdhIgDZkzO1WbInROdX/brAAYSFcFTTSStm7cNupDTFQYMhUFl6f4S9d/ehfLVqTITGnJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUj3O3JbKF4sSxM01ThbDCKuRvYiptyD17E2t9HdcD0Pc8su/G
	EQroF6602eq+qhcXohj6ZBleG+Z+7gF8CMsY0yu3CFj32ey+8iK4Cd0PC7e9f4cZWPUpBFkry9D
	16CJPSC2ddLsLyrDjEVtUV7O2lwjDxc+sVNsb5ggJ
X-Gm-Gg: ASbGncsGPNgDcDUdZn7Lk4qUa/6zQ7oLmkxHO5/hW6IKF684QfO98+R2pAgjc0U+Hlq
	QF5UH6kHdbQlGdDoBlHM2egSB4OKEhBlIASnrvN6eQerZ1P0PB7nBvqcT9RyIG5Z0hVPxDaeYsl
	uzsbrYYkAHUVttQNgffgDEhxfchLFdVQ1PwnLsiBIovdMR4FD0Tu8FFM5ww0y7x409dk9Araw+B
	pQ6Rxar
X-Google-Smtp-Source: AGHT+IEWOkQPrH0XLkRV5jCFJ5ZAGli0e19VbzBarVLJG/5ExptNdhJ3TP0j+pQbbEdu/F/OsvVoDT9daqzZ2flKjig=
X-Received: by 2002:a17:907:3eaa:b0:b1f:5b04:169c with SMTP id
 a640c23a62f3a-b302c6ec324mr24025366b.50.1758581355849; Mon, 22 Sep 2025
 15:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919211000.1045267-1-sjg@chromium.org> <9cafbc70-7235-4e49-928c-4d68a57b7d46@pengutronix.de>
 <20250922135804.GA124814@bill-the-cat>
In-Reply-To: <20250922135804.GA124814@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 22 Sep 2025 16:49:03 -0600
X-Gm-Features: AS18NWAXYVFuaz1ftJ8twGoiGrBZdB0PUcdFpS4-3qNPz-fRCez13rbumtGHdWg
Message-ID: <CAFLszTjURt-a9Y2+JsLirvK2mpP3hKZX52d0EKJaf0fiMgt5yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] scripts/make_fit: Support an initial ramdisk
To: Tom Rini <trini@konsulko.com>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
	Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?B?SiAuIE5ldXNjaMOkZmVy?= <j.ne@posteo.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Tom,

On Mon, 22 Sept 2025 at 07:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Sep 22, 2025 at 09:14:55AM +0200, Ahmad Fatoum wrote:
> > Hello Simon,
> >
> > On 19.09.25 23:09, Simon Glass wrote:
> > > FIT (Flat Image Tree) allows an ramdisk to be included in each
> > > configuration. Add support for this to the script.
> > >
> > > This feature is not available via 'make image.fit' since the ramdisk
> > > likely needs to be built separately anyway, e.g. using modules from
> > > the kernel build.
> >
> > AFAIK the kernel supports multiple concatenated separately compressed
> > initramfs just fine, so it may still be useful to add a target which
> > builds a cpio with all modules inside and the rest can be then
> > concatenated.

OK I will have a try.

> >
> > What do you think?
> >
> > > +        fsw.property_string('compression', args.compress)
> >
> > compression should be none as the kernel would take of decompression.
> >
> > Both U-Boot and barebox should warn about ramdisk compression property
> > that is != "none".
>
> Agreed. In U-Boot we've been handling this correctly since:

Yes, I sent a v2 with that. But I'll send a v3 with the cpio idea.

>
> commit bddd985734653c366c8da073650930fb2e9b5003
> Author: Julius Werner <jwerner@chromium.org>
> Date:   Fri Aug 2 15:52:28 2019 -0700
>
>     fit: Do not automatically decompress ramdisk images
>
>     The Linux ramdisk should always be decompressed by the kernel itself,
>     not by U-Boot. Therefore, the 'compression' node in the FIT image should
>     always be set to "none" for ramdisk images, since the only point of
>     using that node is if you want U-Boot to do the decompression itself.
>
>     Yet some systems populate the node to the compression algorithm used by
>     the kernel instead. This used to be ignored, but now that we support
>     decompression of all image types it becomes a problem. Since ramdisks
>     should never be decompressed by U-Boot anyway, this patch adds a special
>     exception for them to avoid these issues. Still, setting the
>     'compression' node like that is wrong in the first place, so we still
>     want to print out a warning so that third-party distributions doing this
>     can notice and fix it.
>
>     Signed-off-by: Julius Werner <jwerner@chromium.org>
>     Reviewed-by: Heiko Schocher <hs@denx.de>
>     Tested-by: Heiko Schocher <hs@denx.de>
>     Reviewed-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>
> --
> Tom

Regards,
Simon

