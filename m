Return-Path: <linux-kernel+bounces-747082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFFB12F78
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382803A42AE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0078212B2B;
	Sun, 27 Jul 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REWzYAIw"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FC11185
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619502; cv=none; b=HTavrVGAsewiOS1vMia+y95u0qPFEuveAVE+lbtrgatv1+80TZgHOieut4TRZpt+PZ27xhp3qmJH3DKhKXNLx/7Us+trgyQYugMaELE0wRTInKuVSi9UTERSLYFmyJGHspLC2LcGX9QDQCXU+lD4YZkNqtrck1FZixHT2i44/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619502; c=relaxed/simple;
	bh=BwX+f6OvmUXCYCS6hwLlQqnr4JjkZ82M3Ns/Tm34nMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYpe7mvjjuj/vN5oDvbPYn52f3nC11uuJaLng7+sPfPtmVTQWvt+cPsXLceAbn81v9YZjfiEQg9t0b1Rx8reX2eMEpsMjaPtAzRyvhNUHCFjdH0xnaRcNJZcsK9vmlMieh9Z3j0VqAoSimfS7DON7RnKa815toSDW8MFlBIJ11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REWzYAIw; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ffa81b41d7so1497983fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753619500; x=1754224300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr1FlrqtvRl/pW2s+Bj333vaZiPeY5tHgHRPgBeIBrE=;
        b=REWzYAIw6YPRv4t8gKSRz7TX46Cl8QA1gUy0DCcpsFHHzVaH7zWgTqQXm9782VeNvy
         F+rC7r6Us7yCjWzjrHvqt3nsGeEsATdko2cbhif7cunwT8UbvU/7BQfunhgHGMkEyEO8
         Ocpxrymx6JPQUCBV2Li4mOXb5pHm0881gM+TOD9OpZn00pp7Cs+PWiFghBNU/IEmWaVA
         /9fbAEuNiBYz2XCr3khPLkWC4n0qIl5ih9LZqVYKNnxjMvTov7jQBQ/Zt4zhaQfGlCiQ
         DgCz41eu/g2WxiOLmwWU5QfAr3G+uLcA+CEIETK2qD0LxJI8NbTop6ifwTxP4kWL/p58
         Nzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753619500; x=1754224300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nr1FlrqtvRl/pW2s+Bj333vaZiPeY5tHgHRPgBeIBrE=;
        b=qrVucy8KgVHI84TFsYP5+kS5AYwiEi3i3S5AbGBk0epLckMyjLJKXFawVU/EffU+l2
         0S05DPZjXTZpl3ZD5y8BMk9oGl+ZvbaKUHh9UhhGsvc17M7EdPd7FkRhXzFhMrT56lDK
         LCYXAG/LmE3qZRvm0iEKs6FfW2hOp2nnBYg80HEnSTNmqoafbuQ2NWW6Yd6imBx8qce0
         u+kWP39qQ2qVdVibkVv6GzSqG0lEBwtsh4B3h9/Q+oKtoBu1nitNtEctzIIRX2l04HVo
         SzSIYdPGflUE0a5Nbt5sAX10B5MLsoIYgh/ynEA2OI4Oi0xtvuOv8ripJ9M4QCb7tHy/
         XF5w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6MKg1X9m8k1wo+Pi5A7jAPJwAxTg1jamPaVdxhKG9dU4++Dk1BL6D/WiUQOjbPLIkOFpf6AGNgFE3Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEO4MGc8OrQf0DDtFXucim+jwN6jJL0Io+7UnTQfMKwaXmSwBv
	N7SlBAA6tDv7akZcCSpro8z+CZ8DGCxTwTGA46BvlYLoW4hsKWiIzn+/N6PfAjYqkRAnrH7hRYg
	DONR41RZ5XvMlspD0WWb3bGxN5FyZC3H03S7wpNYPKA==
X-Gm-Gg: ASbGncs3QCM2Tlr2AN58Ny9gXs7EhLDe98ybV2xpQijkl2tWmRUMv9l/4aFpSluPzKo
	fjhQ49yPqPDLCZ3Zuof25Un0NCYiio8phZOkpIosChZpvocItihOqNPlba2reR86gA/dIZklUN5
	1OM/O0Bv5DTRGwjBx96fCZ/hBU10iHh78otyo6uHW88nm8Mmdl6KtzLnWRDiopFFm+P8s6mWuTz
	RT3Rvmvcg==
X-Google-Smtp-Source: AGHT+IFpuHK+r+RUZcTODiv1qZJM76ZiRuILDLgWk5mvrZ2hddpDeKAVit/CpJeJZ3oGkqKMAfiyzmpvtMO1w9FrH+I=
X-Received: by 2002:a4a:ee97:0:b0:615:d3d9:5d1c with SMTP id
 006d021491bc7-6190caa7013mr4571605eaf.8.1753619499808; Sun, 27 Jul 2025
 05:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726185432.162632-1-suchitkarunakaran@gmail.com> <acacadd2c1112e31cccbe8db504ce30bd8587852.camel@perches.com>
In-Reply-To: <acacadd2c1112e31cccbe8db504ce30bd8587852.camel@perches.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sun, 27 Jul 2025 18:01:27 +0530
X-Gm-Features: Ac12FXzcfqjbmuR7tctu7RJvCSwo18x0U4iVbHzoRGSt3SfrOFID559ChNL-Mws
Message-ID: <CAO9wTFjbD2qcVVCMYfLi3yKjT1cLtHto_Qzr=eAepg=8evbSFQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: suppress strscpy warnings for userspace tools
To: Joe Perches <joe@perches.com>
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Jul 2025 at 17:25, Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2025-07-27 at 00:24 +0530, Suchit Karunakaran wrote:
> > The checkpatch.pl script currently warns against the use of strcpy,
> > strlcpy, and strncpy, recommending strscpy as a safer alternative.
> > However, these warnings are also triggered for code under tools/ and
> > scripts/, which are userspace code where strscpy is not available.
> > This patch suppresses these warnings for files in tools/ and scripts/.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7020,19 +7020,19 @@ sub process {
> >  #            }
> >
> >  # strcpy uses that should likely be strscpy
> > -             if ($line =~ /\bstrcpy\s*\(/) {
> > +             if ($line =~ /\bstrcpy\s*\(/ && $realfile !~ m@\btools/@ && $realfile !~ m@\bscripts/@) {
>
> Maybe instead create a is_kernel or is_userspace function
> and use that instead of the test

Sure, I will do it.

>
>         if (!is_userspace($realfile) &&
>             $line =~ etc...
>
> and
>
> are all <any_subdirectory>tools/ always userspace ?
>

Yes, as far as I know, almost all of the code in the tools directory
is userspace. Atleast, strscpy isn't available for the code inside
tools and scripts.

