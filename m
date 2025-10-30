Return-Path: <linux-kernel+bounces-878676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2A0C213B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C11A269D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE17365D37;
	Thu, 30 Oct 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEf1E4LS"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA752E6CB8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842119; cv=none; b=Z7vYsoXr4LOt6YSpXMmXN8tQfOdTHMAXdVHhSlvZj87hwkww57Yi21SpYHXBWR5tLV/0iBCnzzyrpOtD/CrZbZ+6TaBjRzQsXI4UHRu2dTa/yeGmvbtu54DcLxiQuTREFUTJcZlGyQ6XjxYH4IWRk5ix/cKgXoel9O/O8p+RzYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842119; c=relaxed/simple;
	bh=MGkUVlTZmVz9Vm+z7GQHP9RZBRcM8P4VQelHahlN594=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXJ/h+FAOXOUB6uGzr3oxIUMBWYBPn05y4/sBZEFWSUifvxm5JJlq1NK8eyFvLFAPeGcR1Q0XyYLFbCSYkFys3c9W2ln+7qhwMWYFdQcyV5nUQYltGHxI7Fr7nHjS9SAfqUHdF/usDLUFBXK5d8DlzVD/E3I+ryPi0un2CgPSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEf1E4LS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c4b5a1b70so2724637a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842116; x=1762446916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGkUVlTZmVz9Vm+z7GQHP9RZBRcM8P4VQelHahlN594=;
        b=VEf1E4LSJ9oGqAy3EJmY0G8HUp012WYASEDov4A4/doZ7r/p2K4ddRQhchhKkTz5/D
         NbfWWPIHMDy7K/WuJh1OfsZHwP81gVeaa+n1abUfAaUf6rb/6oee59TihQVpaWikoyxr
         SMozDkY1SD2iKvinRxV2MYBgrphQruMjWsKfYb/7K0cH5qWDBDFpbLeF/Lv6VINSWO36
         0ul4oZbS9gN70U0fnVX/jxcE39sSje+0I1sxsRPGoJ8S1pfmTZUgeS/5Z6hv7v6nMhNP
         n7t5/452WPgR2tRuzw3RhMKZiTQeyz+qqBNWtDlPYEHhIOFvVSg/vnzl5buN3r4Rj4d1
         NVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842116; x=1762446916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGkUVlTZmVz9Vm+z7GQHP9RZBRcM8P4VQelHahlN594=;
        b=glTrZN5Pl3PcAvQ+4VCejTUqlzhBgAalcBA89jAVnrjbg7b+lQsZowcac8lUmzUX6w
         1mL5E+oSwSqxtVXblJQ2cu/a+/g+XTGF6x8eK7SBnszt919awwmMFCEGdlHrN13DBgxq
         bGELJPxomeiQoByjJl5bFzn4zUolLNWwjmX8XEIMgxrfABqNKh7s84jQnnOVO3mb+Jqm
         RqQucpjUIXyxI7oOe3cxJohm/tDTBaIQcw3ipQ7qzeHXpx6znFf3eY4K43VXRA4kHzIU
         S5m8+GR0czDR1xqEjJytLmtULeZUIFUIH9Z0kBMAXDHkgJDZ/2tbi9rtAiu7KX9tWepS
         MB1g==
X-Forwarded-Encrypted: i=1; AJvYcCW+z0ucO5Mt/EnHdc5mM6rbAds68d2j7spdP++TVSyYg0+/sd6TpkI2InEh9VE70IphnnI6S+OMDi5pNlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnXucxC6zJuZyXC/9QMfVOs9aJApVBf13aP0YwPnPFu6XICNl/
	zVjW7zdusyQVwfMFLaPeLzRNVAQ18i7REwrcQKoBorVX/car8NLk/7MJpMrnQOwK4BLggPWDsck
	hIcVEZ3zvTXn4qDRBKt1H1WXqdMQ4WG4=
X-Gm-Gg: ASbGncuJCySbEt+28L251U3BqAbnrhdU1KfwqY1B1tFNuvyKFDOr0Ebytg0JRKc0PgE
	1qE5EAKsg9ycIgiE29BZ3dSm8dpQnSByZIqKTTkDMlcbMOXR3zax24A6An6BrjOer3O6ENar+UW
	y0VbA16rUV5MHdsTcDnchsaNRT6oUEM2mA9+s+8zGUBNOyQ0ICx5p4MBtCdEs7+a2SGudCz295A
	9aQsIBVThaXHrj7tPETyufVj+5ky3Hl8eMpFwl4x+YpXstHNg2oWEWS6X2dcBj4bAVdl7cecX6t
	pf1A24OVcHvX55BCOXLQet0ywQ==
X-Google-Smtp-Source: AGHT+IEI9jyntojwf1mHen/eVV6CP66LheXmeZtEuf9j/UlMHcx3y2EdePYB/I7EdEcMIu8jXCq3/T2L3K3kk2RO9go=
X-Received: by 2002:a05:6402:3047:10b0:63c:8123:9d46 with SMTP id
 4fb4d7f45d1cf-64076f78ca0mr68713a12.11.1761842115516; Thu, 30 Oct 2025
 09:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 30 Oct 2025 17:35:02 +0100
X-Gm-Features: AWmQ_bk0H66A4MjIr_4COm2P4YXtDHgN1JUPcsRB5KkYw_gDWY9N3WPt2xsKrLg
Message-ID: <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 5:16=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 30 Oct 2025 at 03:52, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > Should someone(tm) make this work for modules I'm not going to protest.
>
> Btw, that's a good point. When I did this all originally, I explicitly
> did *not* want to make it work for modules, but I do note that it can
> be used for modules very easily by mistake.
>
> > Vast majority of actual usage is coming from core kernel, which *is*
> > getting the new treatment and I don't think the ifdef is particularly
> > nasty.
>
> I suspect we should make that #ifdef be an integral part of the
> runtime const headers. Because right now it's really much too easy to
> get it wrong, and I wonder if we already do.
>

I don't know if you are suggesting to make the entire thing fail to
compile if included for a module, or to transparently convert
runtime-optimized access into plain access.

I presume the former.

Even then, there is the cosmetic issue of deciding whether to ifdef
within headers or create include/linux/runtime-constants.h which pulls
in the per-arch stuff and ifdef in there.

Personally I'm leaning towards just forcing compilation failure and
duplicating the code to do it within per-arch headers, for example:
diff --git a/arch/x86/include/asm/runtime-const.h
b/arch/x86/include/asm/runtime-const.h
index 8d983cfd06ea..42e6303b52f7 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H

+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif
+
 #ifdef __ASSEMBLY__

 .macro RUNTIME_CONST_PTR sym reg

Just tell me which way you want this sorted out and if it is less than
few minutes of screwing around I'll take care of it.

