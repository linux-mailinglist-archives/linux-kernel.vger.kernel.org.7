Return-Path: <linux-kernel+bounces-861672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DAFBF3504
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D053A600D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63C52D323F;
	Mon, 20 Oct 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHkfytmq"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48D238C2F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990442; cv=none; b=h9LB2Fy+y732w+FEULvrVlMelolvGw8zzqBs6pQ0CPIuwZR8EToYxkIwIrzA0NNHTFj+oSkolLPgjivHA3lYhtuxcSIIcLVThTarNJT3QgkUqPc1mDax/3jraV+KKm8BqfZoKVOGC8zHLMTgF44zyPhMmNgiaEK0vr75YjkpeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990442; c=relaxed/simple;
	bh=6jIq1uu6R1UZina/cqCeJq/VoqF7FD9lvsEWiuWaTHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0limu7ccnwtdYpOnkBzHHE3z5EzDjZohUWc8gkVVWPNyqVrx1Ssk7cKCmYM1cNs4rYeH4RnfUc+ci2XDM1ztv4383W9Yzo304ChrsWW6TlZpsMGU6wNmzieE38fe7EZAf5HrT6LBDXKepwwe4FqHYsgjrg9g2KOpB/i54/prCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SHkfytmq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so4362217b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760990437; x=1761595237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1p8HLu91anTDPH06cJiBTjgNaFIELg11LPgXWw+czA=;
        b=SHkfytmqR/ryky2vMpKmR4Z04HnB8QXiyhUPsOi8EKioINHJd62xBMSBTe6l6jI3L/
         cTM8xwbKpkhB/J5cXrpF2CDkp5CObPCDD9YmuiwiQRACJSSSAQBXr4GL3aOtlMuWVv30
         p9inBStivjYMci5565xjzNVhaDlSob+xqxx7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990437; x=1761595237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1p8HLu91anTDPH06cJiBTjgNaFIELg11LPgXWw+czA=;
        b=ohS2L/6ANoXlzjqKAwVGj5vfFLa47M5y5DsomXObC0lcExbFbQtPgnp20P0n0ylXNx
         ZTfOu5RT34zXFA4NfJNYECL/Gn4hoM6XQ+rbwFtOz3ccYZ1COZKqLc991+GUtB4/slrr
         5LuhSU46UpMm2G51h0AqRiFS4i0NqV0I3QsGu7/+HHOwrb7liCq36RKkLJrOzzqtrqEk
         hRDHgV50hVqF74clXJrHxW51s9iDecARKTZP2BCidiGDsJR75Lbe5ODPwxl9zmolKe4T
         Cr2TYdWiyr7/tiHs4O745Ka90hAuVWHLGdRzE3pbKPSulAzQdnnBG6XwKy1bii51D48Q
         CTxQ==
X-Gm-Message-State: AOJu0Yya050AodT6D1ScBDydyJ6pAGcGc0P5V0uZkboWCncQjRtfda8N
	G6MdiKFmF6PNBBBePCG8DglxtbgXd7dOVN7AjpWgoMbUrbOXWKAHuu2pjjSjqQxJOGSecpM4CvY
	OscI=
X-Gm-Gg: ASbGncvMLRN3IwzZjEiF/6+kP33p2tn1Ocy4aGuNGbgBdDpVQ+1Dz6Qgf+zO+BRMQsA
	7lvGBvod7UZ2HbDKsCoOj2OOEowrNYNXIECq7DDpSOOAsS5cW0Ohy7bjV5as5cDDxRWAucpZIFj
	An9yYWOT7ez4EdSh2ynzO7Xm6IN+Kr8k2GM2l+WRWbUaINcm61AG4RMY7WGyAkC+/MTuIsaJswZ
	XWHk85oRoE7W77zASfQyghFDFYSD8sTBADaShKxIALAe8IkXt3LIa6Ft8wlCU1+9AkXmRDIhtT7
	4WlD0l8DMFhhgXk27wp0ZBbTfeNwZRgxlQVXHGIpBIqqohDEUTYMsiAOG/W3UiH+HyDxluBHBn8
	7kwOyVPZEG4sACitSn8tSKiUlg58WHFDV9nts/9cmWXgc+m54+mEpE6dVanQ1BNHfTDYFuac55v
	TqBU+mZAkYEdg2RpvBevqEaP4RaZeJRryJaGqW/nrKDz9mosP4jUioXg==
X-Google-Smtp-Source: AGHT+IGH4g6ebfoHbE2x1dBrQDQhpzXP6kCQ1TWS7anuUFcZFS7y689KBnGrvNPkFk0qv2Du0ScXkw==
X-Received: by 2002:a05:6a20:3c8d:b0:334:7bce:8394 with SMTP id adf61e73a8af0-334a8614916mr17607380637.51.1760990437045;
        Mon, 20 Oct 2025 13:00:37 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22fd33c70sm9181185b3a.0.2025.10.20.13.00.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:00:34 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d3540a43fso51066585ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:00:34 -0700 (PDT)
X-Received: by 2002:a17:903:94e:b0:290:533b:25c9 with SMTP id
 d9443c01a7336-290c9c8ae4dmr161974425ad.2.1760990433930; Mon, 20 Oct 2025
 13:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <20251020115132.10897a599c8fbda4829b3f89@linux-foundation.org>
In-Reply-To: <20251020115132.10897a599c8fbda4829b3f89@linux-foundation.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Oct 2025 13:00:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uzp_Pi_q5YRbRi3FgdiCy1HR3g6P72d92dbqAdLyWuRQ@mail.gmail.com>
X-Gm-Features: AS18NWDXKk7-hVhBwWyIgRC_hE5nIUlVJkyA1FDI_4dOBReZq1cb7tvcR7gVq74
Message-ID: <CAD=FV=Uzp_Pi_q5YRbRi3FgdiCy1HR3g6P72d92dbqAdLyWuRQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 20, 2025 at 11:51=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sun, 19 Oct 2025 10:06:14 -0700 Douglas Anderson <dianders@chromium.or=
g> wrote:
>
> > The kernel cmdline length is allowed to be longer than what printk can
> > handle. When this happens the cmdline that's printed to the kernel
> > ring buffer at bootup is cutoff and some kernel cmdline options are
> > "hidden" from the logs. This undercuts the usefulness of the log
> > message.
> >
> > Add wrapping to the printout.
>
> Do we really need the wrapping?  That will confuse anything which
> parses the output expecting a single line.

By making the default wrapping size the same as the current truncation
size, I was hoping to avoid confusion. With the default CONFIG the
only case where a tool would be confused would be if they were dealing
with a truncated log today and so they were already in a bad shape.

The hope was also that the format was simple enough that tools could
easily parse it, since each line starts with the same prefix and the
initial lines all end with a " \".


> And the code would presumably be much simpler if we simply chunked up
> the printing and spat out one really long line.

I'm not quite sure what you're suggesting. Before my changes we _do_
try to spit out one really long line, but then printk() silently
truncates it for us at 1021 characters. Re-reading your suggestion,
I'm not sure if you're suggesting that we improve printk() to handle
lines longer than 1021 characters by chunking them up, or if you're
suggesting that this code could use "pr_cont()" to chunk things up.
...or something totally different. ;-) Can you clarify?

Thanks!

-Doug

