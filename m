Return-Path: <linux-kernel+bounces-865525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C0EBFD6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD53BE9BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5735A952;
	Wed, 22 Oct 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="biyWKFrE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A735A92F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150672; cv=none; b=ssqAjdAVckqL/VQdcLIBCG7QQNyWW7VLQHBdMLx70xVW4S7wxm3+oVjYzHeTRgIxBaIJyG653CEYPfDSHIyXUbQOIM3kZ1sbabThw2rJfCe9YWWyyx6a3uJXyjoycz8+QNLD9+FihasmkN70q6FDiMD8AC4rvR6kWuPnjEtYCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150672; c=relaxed/simple;
	bh=1Ve63qQQtJTHWr0IdlfcTAeJ8TYnlB17r92eLwJlnzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+DxSTV1XQGuFUQ2Np6UMac0fCkRqvwMyFucR2jFNVKHNvM8OhdlMNAS7CwkqQgDMqYWPaoLwGeW/TOoWBf2YGX+ynpOnP83LY5RRbcPjfcGtHcW7QE0RGYxg2XqDtSkbCNxij/y+TcV0lrRsfzYfCXxR/Dctpf2ynI/XRapXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=biyWKFrE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e33cec8edso1714355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761150668; x=1761755468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHEp9WB9vT5T8fLttTR91P9LnN/VEPhBGDbotnJE0KE=;
        b=biyWKFrEusifvpmyoZzKIIlkpvxHg1anoxz8LUebE8m2Pko6nmPw3KsqkFCnKfgEh2
         q8cyD8BEURKnLXkjrRzYmOaRJv4fJVZrQ6ZMdlS6cOYJUdu/g4qPG2mAm8Pl+diM7AiY
         +qVr1Do+gQ5XQ88hmo1O5BooE8nO4QtgVPgTu/xsoeLuJkhhFmukO488WgA2xTU1tRfy
         OIw1LDb8vGr4xQABMyGvFy4TBoKfoSxORVP7UFERV2sde9ozk0VuNvuheO4vvPhxLJK1
         AzDP7nBtwLnQyCbyi2UHbwLAir+/kCdRa8i3kKWKKokdv7/Nn+atgSsbCFumAT0Ilc3l
         B2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150668; x=1761755468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHEp9WB9vT5T8fLttTR91P9LnN/VEPhBGDbotnJE0KE=;
        b=PauS9uTay7dAr2hp8gyLOXirouhwemp02y6udNowwvFj2QtlNhFfKXZZ0EJJheCx6w
         KirLeojp/HmWZY2ylKKk/9tfnSzE3FqgWovsQ7LjuGaSjf7tAsRtSiTqOti1csl6L68r
         tk9yC5k1yDj+rtyub4BE+DU51YvrH30ha7mpt7QIEeVGTFyFGy95Mou3be92ME8lnurR
         6J5dXnpFa2NfTI4Bl93izzWrFj1goar+06ZDLlyh4yEMVbMbCe/dhUXrScdRfbz6U1B3
         MxphXAp/YUv6taY/HhmL6+NKy4Uq6M8dUYrdT5aMDjKPzXbytwvHODBjtko+iWFhlYOa
         P3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM2PPZu6qgXySKd199lj23uz8D0fv3KYmXm0w2ro20HpGyGjixzQiR/Tu6NWm/TCgCY9qU2d7Ba6jVhkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCQMxqzZAk0r5cegWpsyXZgXLUwPh2X1AcW2K2GvvXvdV1yF4
	2mKhw8mBnk9GLUL883mmyXcOoCbn+8K3H1b5bFxwALHaKyHhJc3lWq+V3VemtW1yRGk=
X-Gm-Gg: ASbGncusJOXWs4h0lZ33X9CPSa3LRoh3rZZqhUPp6fPAQP/wVbu3peHK4txG6ZHBybJ
	+GG+nluzhnE2G/l/WlFWVUMQ151cfc98ZTFrDB/50ebYizTS+s5w8cnK/fMZmitdhBrlgpC2q0T
	8VdaQSwkAbGtBnoydIH0juNcQ1TYndwcr2Cc71oVM+vZoZmcQAv+UDdl/4VXngK4d0X91fWTCBF
	NrcqIkOL0o7rpM7RKs5aZd6agzHY60vOEl6BXjnvTnK0N7zgB+zWB8cNQNTOby+gJC6i8m1LcMF
	ZJJTWFYNKM4vKsgVhy9YzgWPYFIeWQyT4lvNMatlbWtg3PuJVnSDf+XRwcdtWl7+yYrkG02soJy
	nR/v0GFu4dRtQbg0wexCwWqmmHSkLyETgyUZKqRmm8NR6irGSg5UEuZfS7weJmNqIAGMsvW3rjR
	jiyt//Ut8EDGtkjFUhgDLYQBXafDRaEUF3OJBcSsHkcM91pYgr9nvQO+TdRNRP+DoNRq/TMnQjM
	cw8
X-Google-Smtp-Source: AGHT+IGAXSTFsjQMBishiaFUqXFYvCAQS2wDognzGk/7SdOuMULSGwPwFkVNrTAd8isSRRWBsQiFCg==
X-Received: by 2002:a05:600c:4510:b0:471:1387:377e with SMTP id 5b1f17b1804b1-4749439eceemr31709495e9.6.1761150668169;
        Wed, 22 Oct 2025 09:31:08 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3aesm26239823f8f.48.2025.10.22.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:31:07 -0700 (PDT)
Date: Wed, 22 Oct 2025 18:31:04 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter
 with early_param()
Message-ID: <20251022183040.5b5731cb@mordecai>
In-Reply-To: <20251008160343.146bd470@mordecai.tesarici.cz>
References: <cover.1758906115.git.ptesarik@suse.com>
	<63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
	<9628cba6-f793-4301-8620-8de46e0c5c97@suse.com>
	<20251008160343.146bd470@mordecai.tesarici.cz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Oct 2025 16:03:43 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> On Tue, 7 Oct 2025 15:50:02 +0300
> Nikolay Borisov <nik.borisov@suse.com> wrote:
>=20
> > On 26.09.25 =D0=B3. 21:01 =D1=87., Petr Tesarik wrote: =20
> > > Use early_param() to get the value of the tsx=3D command line paramet=
er.
> > > Although cmdline_find_option() works fine, the option is later report=
ed
> > > as unknown and passed to user space. The latter is not a real issue, =
but
> > > the former is confusing and makes people wonder if the tsx=3D paramet=
er had
> > > any effect and double-check for typos unnecessarily.
> > >=20
> > > The behavior changes slightly if "tsx" is given without any argument =
(which
> > > is invalid syntax). Prior to this patch, the kernel logged an error m=
essage
> > > and disabled TSX. With this patch, the parameter is ignored. The new
> > > behavior is consistent with other parameters, e.g. "tsx_async_abort".
> > >=20
> > > Signed-off-by: Petr Tesarik <ptesarik@suse.com>   =20
> >=20
> > LGTM, also could you include some rationale why early_param vs __setup=
=20
> > for example, or arch_param_cb (which by the way has yet to find its=20
> > first user). =20
>=20
> I'd love to, but I'm a noob myself, so I simply followed Borislav's
> advice here:
>=20
> https://lore.kernel.org/all/20250915143909.GAaMglDd5oRSPDDuqu@fat_crate.l=
ocal/
>=20
> @Borislav: Would you mind explaining your request to use early_param()?

Never mind, I have spent some time on it, so here's a dump of how I
understand it:

https://sigillatum.tesarici.cz/2025-10-22-kernel-parameters.html

HTH
Petr T

