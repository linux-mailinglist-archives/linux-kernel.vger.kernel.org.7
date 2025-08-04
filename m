Return-Path: <linux-kernel+bounces-755278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F9B1A402
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D167E3A5CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA626CE2C;
	Mon,  4 Aug 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPccDVhW"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B0A927
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316064; cv=none; b=AOLI8tx4tGZ/jnIdDoj10wewRWG/AMJ34+e7+uNcw8tkVbve+p7WOGiovAhWXMtH5A+/xjnaC/ZoNSIhg47o96hPOsD3cu5QCKPNjMcUaxKJ01zoGv61tMVAe/dGHzHaY9EXt57NvXnAdNHF7PpE5hhnxwAmodt3uIest467HEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316064; c=relaxed/simple;
	bh=xj50R8mQAnC3oGaChPzaF3Zvfpm/dUSewHJdzEkPpkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oo+n1FSTdu2ngg6zsZMJhNPYBWW2zqzvHTtz834VeTv0pmP/nHr3FYvrrDMf2qkatDVBNqpcD2wK1wFlP0K/Hlu/B1sOJF74LFUMwWz6NnQz4Kn/0akKhN/0AIn0fmYSEzL0bq6FM6co3Z/WoOmmpuwOl83eDbMd2TysFD0g5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPccDVhW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b8de193b60so937031f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754316061; x=1754920861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHAJM8FSmnytalA1wMLubAZ/HMmqzJD/2hbTKluoKzQ=;
        b=sPccDVhW6QEy9awym2yIacqxD012cjYckZGwqm++41pMKdopp9Kw0KRZ49zh+Ut3rz
         qU+s1bgtX7YqYE+EowW/cd6JP0JTYrQT9w4SgtPobxZPo0z2WmUWE0E4F/1fHId4O8Pb
         EqNVtXoJW318Drb6pMGhCcBnfWVWtpkgGCItkesLpkfPoQBCxhO16jO52J3NbhqK1SOU
         fubmFj3G91IzH9w9r5ATw3XO4cnYOi1dMt040KTkOKoo9jsl80rm4dnVUH3THHLXQqC2
         kwAYsTrotvmj+gDk+3+OJaHBCTd3OS+6aX7QSsRCVX1ceUTab5jfOOYUEB06K5hfdvit
         8M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316061; x=1754920861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHAJM8FSmnytalA1wMLubAZ/HMmqzJD/2hbTKluoKzQ=;
        b=H11eAyBHmbGkgmaSKSglHGbj0rqKT6oGr7IVhbq+XVptFHpRe6HPIFjizmpe8Jlbz5
         DUv4qJopDESqoM8htKBjfs4BvF19mVnNF/5gpz6UOuvYdD2bSgLSaGktKmSVTTTBBcpl
         zN3602NliEct8J9smS/H0DG3dB1GYw2ucDlJcqzAg9CdLXYnM1bu+qJm6u2vH65/2+Pd
         8RFuIAdjoFEAl7ULh3mamMnHEMOpUFkQLslrbqT/34HgOMv0eDRDcrkAeb6tDNxsAlEb
         ACKfmuAA/gSHllrzCfO4PdAuMuxtgLcALMoztKB7LZU2i1U0sGHkHHpjrr+/x2m/lBC1
         i5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuCZEdh62Qdz2T9fvOFFuAxmiTtLcDT7CqdCgCFfVm4/FB1iqBVlj66sKGZjeeZMLtH+XSgpeCBeAPyDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBvv8VN/iE0UQQCgvBPQErfI8bA4Pki+Vahcc8jKw/IRHm3WF
	O5Yr1ZlE3qHdoDnT/FitlQMkbKaZ2mMux/et/YngL0gBgEuvNaaCy/PnPPakiwCNmA4sU2UDUGA
	9Bge69V2fuXp2/0CI+Dmv3XXOxbG7LSXMyHt6wAxG
X-Gm-Gg: ASbGnctRrJ8fkygHvlA93Y2X/74rwyyYQI9KL5ykQiVuFRdqqlCJO40bwDd2TFt8jeU
	qLCH3jLVMSx0YTC+QjmzEacCytBRpWztcq9hbArGKWaHg1NVWIWXCyh8T+FDzbBakOzNyJHsP3Z
	lL1V89XFQKruejBuD7v92GsBl2iHNCmzUv335JR7Impo0y34oTStgtpVE+gP84wj8hVhNzjeKuT
	mrjZerAmy8WQRLv8yB6sYcPp+hl/j9aIkII
X-Google-Smtp-Source: AGHT+IFUU2uJR3FAMs1rzBe7h/KQbUHKICBqcp27KBBBta/zTdWvcJkLu5KQlclilix6YlZPh1K/rMJS83c3Dckdneg=
X-Received: by 2002:a05:6000:4305:b0:3b8:12a6:36b8 with SMTP id
 ffacd0b85a97d-3b8d94c1dc1mr7155506f8f.46.1754316060342; Mon, 04 Aug 2025
 07:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154919.4132-1-dakr@kernel.org> <20250731154919.4132-3-dakr@kernel.org>
In-Reply-To: <20250731154919.4132-3-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 4 Aug 2025 16:00:48 +0200
X-Gm-Features: Ac12FXwPaFFtfKIfOtRFAm4bgGywLjC6Y0YkcsOWje9_NdO2yRdOYYS_hnAnRbE
Message-ID: <CAH5fLgh6x9FYdURedJJSB1nm9n7=HA7aK3Y741P=1g7cLKEQOg@mail.gmail.com>
Subject: Re: [PATCH 2/4] rust: drm: ensure kmalloc() compatible Layout
To: Danilo Krummrich <dakr@kernel.org>
Cc: lorenzo.stoakes@oracle.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	urezki@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> drm::Device is allocated through __drm_dev_alloc() (which uses
> kmalloc()) and the driver private data, <T as drm::Driver>::Data, is
> initialized in-place.
>
> Due to the order of fields in drm::Device
>
>   pub struct Device<T: drm::Driver> {
>      dev: Opaque<bindings::drm_device>,
>      data: T::Data,
>   }
>
> even with an arbitrary large alignment requirement of T::Data it can't
> happen that the size of Device is smaller than its alignment requirement.
>
> However, let's not rely on this subtle circumstance and create a proper
> kmalloc() compatible Layout.
>
> Fixes: 1e4b8896c0f3 ("rust: drm: add device abstraction")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

