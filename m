Return-Path: <linux-kernel+bounces-879147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334DAC2261F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AA31A274EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD971335564;
	Thu, 30 Oct 2025 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh4CdJL9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D234D394
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858804; cv=none; b=o5VXmZ4WdTaE0Sl9v8EUsjrmjVvTt7ixGJNZjJp9YC4pvwT3YBivjuB+pmks672dHyYt2VVLxLq8zTV186wOZj8iHjFIqyFBBpwprl/5vpD502p2wQTs8U6mc36VmMXSZworyhGUE2glI02ZBrh9nprtgupBmX8EXW3zusrFAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858804; c=relaxed/simple;
	bh=Ds10LqyCnxdrh0ZjTOtUC48GJJV0wJwcpwKLPS3durE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrDbl+CA+MP8mmuQKjRL8bvIsWvzauyd2LNt7X8fa/I/yI0qxPbUMPSH7ExGVqLgI5CMk1IGT5Gw4UpoOGRQhy861HNxSAPSTxPL+clFP/kofaSsI0r+v9s0PDKccHN5zQbaXutlMBLxZ+S7Wa7+AYEl5Isg1iIbHdrb4EmXTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh4CdJL9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso14227645e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761858801; x=1762463601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTFjyfM924ecEs5Bh5eIoT2AnXmgRLbADTYF0WurRYE=;
        b=Zh4CdJL9Ye4tgOk2PdxNL4xixD0FkiLDlyZWIud5Hia8Zs2K6t2cuCJrS6pPLz1NPt
         6i2LYEcnuOFXWX7xG2PgAhB9WUCChNRAK0Pq44uF+wXfWyFj2DLG6m+SWwOllx1pXDeZ
         hb61cTMaqZffAFwcQjZPG4GEhC/NAx+yyKDlgmvCZndxsJ41LsBp+JPuHO6/6S0G8GUR
         d0FPpP2CKwk7L8m9kEoq9n+oF6IIlcisCYDMbPaCxzehDfjmm9ijl7kOgVUekYjpZUTd
         JZiVs6mwnGbr7MOQru1cX5FpfOIHNxo0FQjh9HOma1Oomvc8kSs7qR6/zSZpxtRxpwEM
         FopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761858801; x=1762463601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTFjyfM924ecEs5Bh5eIoT2AnXmgRLbADTYF0WurRYE=;
        b=Co1aM1/lul9P+Tj+8FgjDD+37KER5oF7ADCC9DEUkag+V3bxBKIiy+XutzRcZdDKKZ
         w2KXmZpammq02hZZND3nntP8skirueO7aVFxZa6txdiUYE8ShHR5zuDewvsHx3LedtbD
         viLM/vjDIVMj1EEk0cljTnYstfiQikzUaLIG7tfTb91EUWXSFYnDRgq8khyeQDY2aT4k
         f/P5D6zhrVxX6Z9Ac+9p/uSZVJ8DoRsA+vDomh9puJmERJLcm6OXpo3dxs8VqDJTTz5H
         RePge4Frf3O6pv1m1WNvS0pKheThciokmgfqp/Sa+YhjHi/jU2Tjty/AmYU2cNgOKjf7
         vn+A==
X-Forwarded-Encrypted: i=1; AJvYcCU0Dvd1kopAQuUTAUww7nQD4wcDvDwdQu5cFHmy1sUiU+Pj+Db3PRrHooe9jxGCLhFxWb1FXoX5Q6jZZyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3M9+MD/itPX+G+pGYwxTwuSRMYNbG810RyhGh7PgLTOMOMmK
	jmbgCtK2tozD8l9uq2JzfP8VIaaIaG2Q1drKmgGehvrlpzFGU1iEgMx1
X-Gm-Gg: ASbGnctrzZZ0bhBGgiwXbqhkmTngnxCVyRjEL5ysFALdHTgBzvopUugP2Ss1m9LTs3C
	ev0j6tsy4CaqdXtANyIFCEmSMoDyBesLUYV71h1NDPN2k0cXHt7RMrpxP4TmA7KRemAlaNj6IO8
	T1nz5IXUUaBOXJjPe9ADXSsqwFH7G1FzqIkPQK2R+m4a5BbMHKmthjAXjOMSLMmUrVLAD/33Bak
	g4Kp96eeyrZMduC/qAgV/8+R50jZ690C+9gynCcd5UDR2ToazuxX5aDKcG2Yx0m40y/Li8FZuxT
	eAzFgfN1IhtpZvWPtwstK7UTlnt96QHPNlhTeKtqqJxWERPXzZMjg4DWUvqkSJ61MXbMED4k79a
	35NpDGZfN0ugpH6g8qp75TSqs27hTztz0bR503VYLtHb42ZXSg/xx1PlAlVAnhxV9G6yUenzpPm
	H6Z9Ad9eAuFv8jfSeeIpfPnv1yX2JHhMknAjN9WeJS1zYAcW23Q8+xKW3j/b2aIno=
X-Google-Smtp-Source: AGHT+IGHccmEm3OTVvfv1cl8GaVw3qg7Fan/QOWhxWwvh6yuV+lD+Cr5FA7Q1nAV3Zqiw6cVkBYCFw==
X-Received: by 2002:a05:600c:630e:b0:471:11a3:a6a9 with SMTP id 5b1f17b1804b1-477308acfe4mr10073295e9.37.1761858800991;
        Thu, 30 Oct 2025 14:13:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5773sm36299466f8f.27.2025.10.30.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:13:20 -0700 (PDT)
Date: Thu, 30 Oct 2025 21:13:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "the arch/x86 maintainers" <x86@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet
 <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill
 A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, Rick P
 Edgecombe <rick.p.edgecombe@intel.com>, "Vegard Nossum"
 <vegard.nossum@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU
 initialization
Message-ID: <20251030211318.74d90c3f@pumpkin>
In-Reply-To: <d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
	<20251029210310.1155449-10-sohil.mehta@intel.com>
	<789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
	<13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com>
	<d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 09:44:02 -0700
Sohil Mehta <sohil.mehta@intel.com> wrote:

> On 10/30/2025 8:45 AM, Andy Lutomirski wrote:
> > On Thu, Oct 30, 2025, at 1:40 AM, H. Peter Anvin wrote: =20
> >> Legacy vsyscalls have been obsolete for how long now? =20
> >=20
> > A looooong time.
> >=20
> > I would suggest defaulting LASS to on and *maybe* decoding just enough =
to log, once per boot, that a legacy vsyscall may have been attempted. It=
=E2=80=99s too bad that #GP doesn=E2=80=99t report the faulting address.
> >  =20
>=20
> Unfortunately, CONFIG_X86_VSYSCALL_EMULATION defaults to y. Also, the
> default Vsyscall mode is XONLY. So even if vsyscalls are deprecated,
> there is a non-zero possibility someone would complain about it.

Presumably a command line parameter could be used to disable LASS
in order to enable vsyscall emulation?

That might let LASS be enabled by default.

	David

