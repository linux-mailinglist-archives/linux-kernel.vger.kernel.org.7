Return-Path: <linux-kernel+bounces-871050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E2C0C534
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24EFE4F0F12
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426A2DCF58;
	Mon, 27 Oct 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyLYAXnn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DF189F5C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554073; cv=none; b=A23pqA/Q7a0p3Ylc9iJXeLAKFABmY9Vh7epPxg/k2SUmAXVcfiY1qVyAmcaAA3kVBpfzFNFxrZbu3nHYkwOZZesMDSGHMmbbvnz5jd310iP8Vz34QG/NlzyQ6uz/LGcb/tJHdk4S76GeXHH50/R/9C1+E35RYBOXYR/CUvFDtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554073; c=relaxed/simple;
	bh=hZTN/tQMYZInh7JvxfdJgJoSNB55wm3j6jMjFgi+HkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnhGzAawR0odYiK35e6KMzcGtji2gSG/seS9QMerdD0w6XEDxS+uKApqnBca8puK5NAhmCgKbNgI4B9RnWtnz3hAYY2lGBaYJgP1UL2fwadqMjIhwwImpiTw4Ba4eBMA3Uqr/FfOHB8h2AeTNlIO4O//t8DHDrz/x6w+7mAEOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyLYAXnn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4539dddd99so934038766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554070; x=1762158870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXqA2AyYDwMAn5NeiBjETLweOL3QhYSqRjqxrljQDYI=;
        b=kyLYAXnni860iyXZipirj1ouWIpiOII1jtdMfjXMlErQ6dOum3GjUR1FmWlO51eCaf
         ooziWpmNBHa6xn87D336Taz6sYkrjM+ClNFD3FNo7aM/VUs1r7c6avi4YIhAVhgYCPEk
         uL+Mk4M1ARpwbIbbYlc1B/sof3Bf3eJ1buTuFf/xsM8AyBXsA3ZiIKmL46OkJpHARTml
         2HAt85RckGpaqPqYaU/Di8gBH8JtTf23CEqF4ZnQeJbtUdIbYsff5Psolv0MCInD2/cG
         NRdFLB9gqa+D9XoHOURy2+xLIVVp5QbP6845dopJzXbFaihzSDEeKmQo6nkMh3SSv4oa
         FRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554070; x=1762158870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXqA2AyYDwMAn5NeiBjETLweOL3QhYSqRjqxrljQDYI=;
        b=I/BEUCavvkY/9ZX6gTqE1BnNS9spGGlshhRaysZKfday7Nf7xhsITzNMfjDrVVW2si
         koVX43KNTw1vP6InJOPhZnq6Gyb4n7Qq17agjGtJ03HnKQ+Hgc5s89DbB6GtjsZUy2Gr
         ykFaoq/ThIWi79sok/YI450vuGdShMy2igGxym/JobKtOr53PMxyAT4Pfr+G/gfx8VaE
         zt97AMRIhe/+9wjvBWAFwOPjvGFoLrHzwfkd6IPobQTVDkQi/SNF1vjVrB3+4PcTHZwL
         5S2eW3pPrsnRGDggvvlgQZfRZ3H4l5y7vTujpQS6bIUWyg+OGEH1QLn2IAxV0+0fV5MP
         /7cA==
X-Forwarded-Encrypted: i=1; AJvYcCV8OYSDBQ27pjNOPrQ3R73tw6kVsfbsz76Cvxyn5j7smzuaVMNfnacgyrd//xD40fdMdM10QMufXvlKjZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8kFnMflv3kVXq3CsPZ2MSFX2/k+bpo8BJDYUHlLStc6EiDT6
	/ouuYh6piaDBbVAJVv4SA30zaKAR5fL3DCHxz5ky2RjNhjQiYBAifzJqzUfKXqr4f43svobTOu5
	6yK7Qrf79kK95BBuZyXY++sIhynlSv0k=
X-Gm-Gg: ASbGncuAaSPcV2DtE8Wa/UzIrNThhj2ksur4gJoDsv9l3IJAPK39aQ7tLUz7oSi4iiC
	nXGXiG0Z+IxiwIA5HWLufw3hu9f89DtpqrAEvtEqWfuq6W+Sxwoox/jMf8mGeZ+y5XV4XZlx7au
	XHD8BTJEpMWwWJVaCKVsQmJmKnA2bzMt+MXTZkbXwBobPAE1YuqEmFvmTgY57TG2z6RqXQp8o/h
	Jy1TZEBVEeVklcbVx7NZMxzYMyzL+LzaKeHumCha5rzqt31ePQd1JVC8D6M6jAcigGm5tO6YvRj
	w6YPV7QStefXQI1l831kmpAu/p754Q==
X-Google-Smtp-Source: AGHT+IF4Ku7VBi6Rz5YATQmMp4K6m21OtDlsrRJ8R6TX/Zwi0y9zuA5CLxTmowv0xMLnRyevU+7TIZF7WyaAwQdIbqQ=
X-Received: by 2002:a17:906:6a12:b0:b40:b6a9:f70f with SMTP id
 a640c23a62f3a-b6d51aefb9amr1645192766b.4.1761554069622; Mon, 27 Oct 2025
 01:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
 <aPvAm1E7CvQfOIuS@stanley.mountain> <81e6af8eea5b0399d1685797d0ea6a6ebc273270.camel@gmail.com>
 <aP8CxkXYAitKB3vx@stanley.mountain>
In-Reply-To: <aP8CxkXYAitKB3vx@stanley.mountain>
From: ally heev <allyheev@gmail.com>
Date: Mon, 27 Oct 2025 14:04:18 +0530
X-Gm-Features: AWmQ_blvkJ9ZtBmHKBSTV_q6E3sXqzi4cxX3zWvk57-nTx4mfsifVuvdEYK6e1U
Message-ID: <CAMB6jUGEJeOVKUEpeFosBFA3QsQk3kgdt_e1EAQJi_yqJp7H-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hunter <david.hunter.linux@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:57=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
> > General question about the process for my understanding:
> > Is checkpatch run on full tree by CI or someone and results reported
> > regularly ?
>
> Newbies run it regularly.  Otherwise it gets run on subsystem CIs and
> the zero-day bot runs it on new patches but it will report the old
> warnings as well under the "Old warnings" section.
>
> > My understanding was that we would run it only on patches
> > before submitting them Or we just run it on full tree before adding
> > new checks to understand if they are catching real issues
>
> Eventually someone will look at all the warnings.  And probably it's
> going to be a newbie and so we need to be careful with warning where
> newbies might introduce bugs with their changes.
>
> regards,
> dan carpenter
>
Makes sense. Thanks!!
---
aheev

