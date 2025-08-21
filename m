Return-Path: <linux-kernel+bounces-779865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2732EB2FA76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2506017FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284E335BDE;
	Thu, 21 Aug 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4spp80R"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AB334392
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782832; cv=none; b=KhPVfrq5rf0iMy4tQL7ulOKHYpQcwyNlORdKHt8zwXBZl1gOzU9IEISmAGsTB08gJGzlDh0Xsm6/RoML+YLfz0DKhnR/sIf/0yNKsCx3WHK9LW8BiICrgocLMgePIrKqwWkdt1Ir1HwIU/uCB0NeD1wgUCnnt9LTNX4GByVlvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782832; c=relaxed/simple;
	bh=7wm2W8BdjxtMx0zQmKaAvq1NAERm3m272ZTgG+IyrPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYsYSebVSSn2I6B4wKgt+NvWl+aJtBv6dfRXBo/5mM+kgzlm+rJAGeY/vqgusoUmH3Zs+Rnegr7R/AGQitU8Hun+B2k22bdgLLsus/1TQzhFhsSd5EK89WmK2m3Y9xCT4mi/naFJa3q8ORP3u+b/VSOzXQpzJzCsxan2Ko/V0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M4spp80R; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e94e40fd473so782573276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755782830; x=1756387630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wm2W8BdjxtMx0zQmKaAvq1NAERm3m272ZTgG+IyrPg=;
        b=M4spp80RizxkKWhudgP7/pg/zb7cRJHzvJfRdyWE3uvfpbCbdUKO22InPbELwWyyvJ
         Z/+mS9+K1N54hwVHfPt784IGXP4icgznEobawSD0jwNxkRJP5X+8QONVqj+4kAPI+kBQ
         iYLTmXgZovDfw1jvOMI2c0bv7wOi6gcluWZPGBBg5zDTswLGJXkszU5qbdeBYb1VCOG4
         7CcqHwoYgizRsGZDPvJjxGhkKXjrNihHNd31ZL/vGyxl1yKXappHpPc/Sm6mcO6jLM2l
         zs8DMa0wM9gufC5J1Jzp+YX4BNQtZA1bto0XmaltLVnLsP9J2dfEnS7X4Xgc6YvIy3uB
         +yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782830; x=1756387630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wm2W8BdjxtMx0zQmKaAvq1NAERm3m272ZTgG+IyrPg=;
        b=pF7wU1OtOZHztyQhz5pJk3EN6+nf1AkN1UXkbhnVS48fZmS1AuOykmLNTjbL5AaAwQ
         z7BqVdQGBYzk4iUMS50IGkyEaOnFdCg920mBslbTOeAIi4YUY9QxOql72w30lAfYRSS5
         v0NLoqP4EC+Hxh2Hk3uN2n4F7AVIoo9j6QkgZ5AywSci4fVWCeeHMlQt6ugmh4Srth7C
         i7iCE8Jvf93zfJFonwqd1PcvodVuV8wJFVBE79LyIBaziaosWLQD/dpTHTuJ6Q1syHBw
         HFcYKXteEM2MmWz4wYucbOCOJamEFgXwLyIlt2RJ9Or/LdRpXnITn1U90FG8oI+OoCSO
         /yGA==
X-Forwarded-Encrypted: i=1; AJvYcCVkPrM+gI1J62K23DU9+4rphwCao5xZ2CwMdWH/SaxJ7qrr6F/4fC5F2S5FIIZR7I/a7CSEz2VRr0GN30A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcM2/90XKzk1b/+r4nDLYuTlQswt8wXZ7oc/tiihzJOgDvG2d
	sXKWB69dUFTeW8Ks/q2GLKn4ghIOoC7tARtmOlMfJdbC2Myozs0y0ZR1owSOvUCSEACh5tvJfjV
	HcSod43WmAa3XDVBSLcVMbbUyrMtOjtxUnJ804UJY4Q==
X-Gm-Gg: ASbGncvdE41AR98+Hzg2SwT0XrNXDIzUIFxhczirTUPPyG1+v85sGGqTxcnX8DIm+RO
	4atHPybCRrV4vbZFVnyNe2tANmE0UPV54pgIxgzBFj7Vyxh/AMwbvUGaJjogmqj6Zs3X5yZ2eFr
	dTmV4k5OZl8kJ9ywOobItrMkHLI0UHCBfNfOaMcTDHy/s6y4HJeOfcUecSHq2MmmrCxT17TeJL7
	UYxWnuQJbdNWBj7fRXzS+UrApMgpRqRuBxO7dPY
X-Google-Smtp-Source: AGHT+IEj0h/LwZOxGTRuKo85/IJqDM49Kxictjq1uzS1PpYHjDIs+ZTlaJVAyyLzNrazr70KAnjmjUib9T5ZdeFnFMQ=
X-Received: by 2002:a05:6902:5404:b0:e93:3ba9:9e45 with SMTP id
 3f1490d57ef6-e9509a6de27mr2684091276.43.1755782829678; Thu, 21 Aug 2025
 06:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755285161.git.jan.kiszka@siemens.com> <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
 <CAC_iWjLMFGp3wg=59PruJQb7heds6CUcy8FMZ_cdT0b2vC5a3g@mail.gmail.com>
 <50f7f2fc-2c6d-4ae1-bbce-e132b1d9c9fe@siemens.com> <3a9eb8eb-3420-4232-8259-3b33ed45dc66@siemens.com>
In-Reply-To: <3a9eb8eb-3420-4232-8259-3b33ed45dc66@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Aug 2025 16:26:33 +0300
X-Gm-Features: Ac12FXws7T5AEBgk39TXNjCs8naGRTEnfry-l4q5CDOLsbQ6YRDbnIK3SKhYQik
Message-ID: <CAC_iWjJ5bogQwhqGRVBB59=J6wcB0q5h5B-LkiTkZOmwN4z-2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi: stmm: Use EFI return code of setup_mm_hdr
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:00, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 20.08.25 16:59, Jan Kiszka wrote:
> > On 20.08.25 09:10, Ilias Apalodimas wrote:
> >> Hi Jan
> >>
> >> On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> If a too large payload_size is passed to setup_mm_hdr, callers will
> >>> returned EFI_OUT_OF_RESOURCES rather than EFI_INVALID_PARAMETER that is
> >>> passed down via ret. No need to fold errors here.
> >>
> >> Apart from not folding the error here, the current code kind of
> >> violates the EFI spec.
> >> If you look at GetVariable, GetNextVariable, SetVariable, and
> >> QueryVariableInfo only SetVariable is supposed to return
> >> EFI_OUT_OF_RESOURCES, if there's no storage space left.
> >
> > And with storage space is likely meant the persistent part of it. ENOMEM
> > is something different.
> >
> >>
> >> Should we also change setup_mm_hdr() and return EFI_INVALID_PARAMETER
> >> always? It's still not ideal, but much closer to the spec.
> >
> > EFI_DEVICE_ERROR? The "hardware" is has a problem by not providing us
> > enough RAM. Yeah, not optimal either. But invalid parameter is clearly
> > described, and nothing fits.
> >
>
> If there are no concerns, I will switch to EFI_DEVICE_ERROR and even
> drop the error "ret" argument in v2.

Yea, I don't think there's an ideal scenario and the EFI spec doesn't
cover the case where some allocation failed, but please add this info
on the commit message.

Thanks
/Ilias
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center

