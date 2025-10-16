Return-Path: <linux-kernel+bounces-856724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A9BE4EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39F0F4E3A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA6B1F78E6;
	Thu, 16 Oct 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xegZljcE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7213346B6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636888; cv=none; b=eeNuSDB804cfBTHioVbw8l6+6fFoglrtiHv5W8ROfXPPQ2O0GpzMhVxcfCht4PDZuZhdhe4bbXfsdKmUqtmKv1ffByet9G9mr1SEEFiMOjAyJKbkwhrJ67HNLMfqxioCbs7gPs/JASTzLa1PfujBOfpZTdf5eBVM0X6GlM64Cjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636888; c=relaxed/simple;
	bh=XIQCpGHFTs8D7F3SIyvmjJUsyahbXveHC0UC/BYLDKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2DK7IjAq1a0BCv989or0wMFHf92ekdk7xJBrawtDZoJJ6jfywsknPoShm8jO6mao0gxqrI7qLYjLexS58//W5X4y2DawSRXdwNy3ihp2bQqtU6LvD5SzXPktuvv2sUsWDuYIJacN1pbEXTNyL9gtxoAwUYIqcL/rEPxlQPmz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xegZljcE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2731ff54949so15265ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760636886; x=1761241686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIQCpGHFTs8D7F3SIyvmjJUsyahbXveHC0UC/BYLDKU=;
        b=xegZljcELhymLOw5C+y8sWRXuS5VMhTRQlx5tris2D2Xmke0djnTGwuAuVcw8Mvyjn
         t2NPeynzcxbbBwshlKfM3RAJQa1OkBl/P+CSryO/go+P08CrWSQ9+RVDWp7i3Xu/64uc
         Dh4r0h7rwi/2OHuBvAW0uuTBQ9X/1JzFVsGU2UHF/pU+KgeOnFeDEEIDx2mAQy11FfjH
         ffW8ToxCBZjoYJ5jeYgdyRtNkZoJBENA9xo1mPvgk9v6jkMfr8YEFgU7qubGysyoDK9x
         KZk6dtHqXZkxDUi9+P+j6/6uq4gzP1Nv3SiNO+BnN2I73+RnpuJoc+ZISMgy5AvsekBR
         4X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760636886; x=1761241686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIQCpGHFTs8D7F3SIyvmjJUsyahbXveHC0UC/BYLDKU=;
        b=U98NVuul24TCHFGhQ46m06deIzIqtWiZ40tV6ev/Oq8SrAfE4xhsE96PDhBtckya7u
         YlGgrWYn1snl3N0aD9hR0kqn1LgwcSNTT4MYyptlOdv+5h30NHRTa2whf9+SZmyywq85
         bQZOVwnugrJIpVDedThC+ohnWWHqf9yJ3aUfmzY8dF26AjYtrVTx0fhkEgwky80vKsTL
         U+TacloQrc7wcfXP+E/Zq1aiC3RUp8KYJYAIcfx2cU9uwpZPxiCaHmsvojQYPtqIqXah
         5+v454/CPQfDH5uAe9SgrKmevS7vDPk71eeLSMwHVLtnpGcJzuUNO3pENilXTyrnA4FQ
         xtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRNtJQtwr5IilfJe0GF8+YpCG9D59Epb0qwto6DY7Wu4No+pPOVw/G/ZPLJ4rU2lxmKFX0/q58rshDiU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KD5GJGQ7a/q/x1GxWhTZfcukOfxa85Rm426zcTB0QufDvPYd
	zlsB8lzrJgfr8G5I2qUgPbtvcotH1VL5CWSZN0sPjjnM9UuaHAogCYIvSa39uwcgWq5PpShPPRm
	eA7/X0k4hvi9Xp9rmqEA02jR3QoabWtlZoTCvvKxC
X-Gm-Gg: ASbGncvVhKWGqR9eKp1IeNu/q/TPTlLEMfvkjKKiOl87rXfxnnuxpe2mhQ/QM+sIlUg
	N74rJpxEhR3gxW4xeWvKvfPU3uw9gqU5JvgFW0AKZ2S+52A4feqNya9gfLzHeG9dItdfe8fZ+QY
	f1b8YApMXKgCXWIzPT7ke+AS/LnfhVFjnv1r+0GBT628rxXVt2d4XN2Cmp9lQ23O1zap7pBHgN1
	C5z3orRrY8gahREIZ+h0EZoEE0as/IdX6eKG5XKYZfr+gZsDFjYyK49MuYWGVLzLBUJIcYVN03S
	q6CbfD5P7hl52Hg=
X-Google-Smtp-Source: AGHT+IHVcKL4wh6YEMgcfGrWaQIV27++i8BjLFUHYBK9dHzibsv5bCpUNLu+1lfFKvZaku1glcfoQfosqVGGAkS66zQ=
X-Received: by 2002:a17:903:2a8e:b0:268:cc5:5e44 with SMTP id
 d9443c01a7336-290879ec5acmr11967435ad.6.1760636885521; Thu, 16 Oct 2025
 10:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com> <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com> <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 16 Oct 2025 10:47:52 -0700
X-Gm-Features: AS18NWDlhMybkSceF2x0lM8xipUiMvCelI5ThZAWBI2ddK_PtsbHuGfes4sdQgg
Message-ID: <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>, 
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:46=E2=80=AFPM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
> > ...
> > > But the situation can be avoided fully, if TD preserving update is no=
t
> > conducted
> > > during the TD build time.
> >
> > Sure, and the TDX module itself could guarantee this as well as much as
> > the kernel could. It could decline to allow module updates during TD
> > builds, or error out the TD build if it collides with an update.
>
> TDX module has a functionality to decline going into SHUTDOWN state
> (pre-requisite for TD preserving update) if TD build or any problematic
> operation is in progress. It requires VMM to opt-in into this feature.

Is this opt-in enabled as part of this series? If not, what is the
mechanism to enable this opt-in?

