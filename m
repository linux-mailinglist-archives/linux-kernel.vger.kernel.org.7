Return-Path: <linux-kernel+bounces-735783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895A2B093D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059711C467E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3632FE337;
	Thu, 17 Jul 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N21Wm9PT"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABAE1925BC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776538; cv=none; b=k9spVZkLYPlzd9NS3axuQXOKLww0bXZOjcYSsxs27juSijDahglaQjESJjkjXhYxRXM9a+GEYO34pGHGyRbzKVfE55Uj1VraaVW0wC/PampGtH1qMvfZk6UJ3Qw/XSNyt1KHN+x9V9z1RdU+53TNW7AJBovTeM6mnjKDU+2T9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776538; c=relaxed/simple;
	bh=G3jL+wG+8NOo0C9q/J7PTimEdtDkh4rD9YQDFto56U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJIbPrLFePZViPLcOe+GisCUm68kwCqX9+vKQF0yXsMejscvuTWDtmLqcztoS1mmMl9S4l/NC7jWJCiUcviAhQdnKZz2KXQd3xL3PEJsHDQXh+8MnfDTPdByTc8s4koVXX/YU3YTrLp10neYVwj+OeOyHrkKaoERxNoGy3NUhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N21Wm9PT; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8b3cc12dceso885322276.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752776536; x=1753381336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj/cZu4K955u3WxbJO5Yyn51Gj07gNitENbpCqXBrlg=;
        b=N21Wm9PT616dOulvzkGsVasCVbVeqicWkekZa2o7Jwi6tNsB9ScbQOk2uCWrJ4BSgQ
         byQZpN5CcZQqZCfF6dv1uY3Y10LswZOOjDIh7iNF585cz8MaPb+VK4T1ZxOpP5MeBpdF
         gE8tnyZnY+O1DwXMOndAnND4Sam1fGlvwXn9rMcnKlOuJocT7ZCh9vFGp7nirLEIMhLx
         iHSpY8YCtdmbAOVhEznjsbwFgHt3ukCVD1+uCud1upaeTJhzmYtfasW7Foewh5npChNE
         mUiIpQEOfvtHtLkXVJ/bLu0e4cgf382HGv00YzcVAm7HMwyOG8NZRa3Oi/lH1JQby+0S
         y7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752776536; x=1753381336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj/cZu4K955u3WxbJO5Yyn51Gj07gNitENbpCqXBrlg=;
        b=B4edRu2oKT6F0j13JGCj/m5mbv1NSnYq8VZ/W0y4qMRaTigLDdTOT2KwuhcFMVwN37
         wPy2OiLB4Hv0e4j2YTCPSVheqtOclc9mGodypbgNaUqi2djz3c7cMo1OEqp5AF82iEa7
         i6LVMLjS8o2BDgr1Kbz9vpYbBIbCELG66QOVdhqT3ee9tgoKYn6UeoyQ4Pq/eT7Epxqn
         BY3BD9/LLOtoPrShdPN6Exu0svANaI8fSxEoYzrMuSw2TaPb546WgZd7T9SsMoCRlyxZ
         SXf4lOptud+lXaCiUlkMUNDgPz5UxI35/Vd84+eSASdz3pS8ULYzT7tn0H6chgM3DQ6v
         vYPA==
X-Gm-Message-State: AOJu0YyRFx/hmwiSqKz2+W3kvzRy/Lmac44/bkopTwjIErHRp3OPJcXp
	gasGu9n2+/G5PyTDCqiB484FJv2k5bWim5TjT0ujcz4ruz9lxmrSpICbVLTXZsEswuc9m0hhFB+
	EppBdkobuMd7fhoOicNV6EOZw85WokTn4WhOIEGTM
X-Gm-Gg: ASbGncuII9KkHm8i9QwmR1Wfz5Sj4gjwsguTlnE5Zhg1cJ5spQaVWvRoey9tx1zrq/M
	cf/aq3c4gcEuXxkuYoJVb4lEIvAvCF113KSds+fpzF01N5Cs0BlSqw4Zo5whUQ84p5LauDo0cR8
	ENrsdWbUuTvBs+/b7RFSZzXd98w6eHHoK261e5igT6ptnBjlrjpiqYs27omUFJiHiXbvYhsl5HQ
	LregyP2FvWalaywVw==
X-Google-Smtp-Source: AGHT+IFl6UDPpr/oWWaFnlHMWZyVT1LMOLcL/IIjAuyhHi/01vC0aMu35s2078tcgwodJEbgmu0BPGrHYuDoxJtxfp0=
X-Received: by 2002:a05:6902:248d:b0:e82:1f55:effd with SMTP id
 3f1490d57ef6-e8bc269ebadmr9165657276.5.1752776535732; Thu, 17 Jul 2025
 11:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Jul 2025 14:22:04 -0400
X-Gm-Features: Ac12FXxe4T_hN6jEbI53FNZzZFqap9jNRjhELwIEMsW3hFfT4g6e4hyRn79zWz0
Message-ID: <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Secure Boot lock down
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 5:29=E2=80=AFPM Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> Ping?

Adding the new Lockdown maintainers to the To/CC line for review in
case they missed it earlier.  For reference, the patchset can be found
at the lore link below:

https://lore.kernel.org/linux-security-module/1750975839-32463-1-git-send-e=
mail-hamzamahfooz@linux.microsoft.com/

> On Thu, Jun 26, 2025 at 03:10:37PM -0700, Hamza Mahfooz wrote:
> > All major distros have had carried a version of this patch-set
> > out of tree for sometime now, but with a bunch of magic (typically
> > sprinkled in setup_arch()). Though we can avoid those architecture
> > specific quirks if we call efi_get_secureboot_mode() from
> > efisubsys_init() and that allows us to have a generic solution.
> >
> > Hamza Mahfooz (2):
> >   security: introduce security_lock_kernel_down()
> >   efi: introduce EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT
> >
> >  drivers/firmware/efi/Kconfig  | 10 ++++++++++
> >  drivers/firmware/efi/efi.c    |  9 +++++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  8 ++++++++
> >  security/lockdown/lockdown.c  |  1 +
> >  security/security.c           | 15 +++++++++++++++
> >  6 files changed, 44 insertions(+)

--=20
paul-moore.com

