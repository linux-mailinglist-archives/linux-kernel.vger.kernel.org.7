Return-Path: <linux-kernel+bounces-818915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFEBB59811
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E9B461A67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58E31CA65;
	Tue, 16 Sep 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFk/nKl1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184A31B80F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030323; cv=none; b=tJPrys8OHfIPlhT6NhkZSy5A2SrbnDl24Q0i/1mBVUzBktX+ooMzcePp1AqZ4WSL389XiAvM9ZK/gUF4/66aw1aDh+pQloH5++Td8gkIJl1P9X0G37PNpP1rAtyvAE2QrCcani+y9B6kYhOw4kdIbPGKpc0Drx6NLHpmYtJjKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030323; c=relaxed/simple;
	bh=I0s65qDgowOOSGjJfE5946fkY4IW8WBrWqqfNZeJx30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ss5sHe9vf0vX6vcZXDy+uVApbhOQEirR6WyZrA+B2z0cjllSaxbKuK1A9eTNVRASJR9UiOZ0huXiP4suCwjV+9qKrW5H/ttmwPNqJd/UHsRYucracRmWfVRsyxHq0yxKt7ja2LhwkMb3CLhGwwDGrBiAOXjrf0SGEnjxeIRKq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFk/nKl1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-25e5e1cd536so7492095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758030321; x=1758635121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0s65qDgowOOSGjJfE5946fkY4IW8WBrWqqfNZeJx30=;
        b=HFk/nKl1AmP1c2SeSLEf6JqGrRGVzBZlYA403wUQt+oePoRDgA8df/HTeKL8nLkK/q
         HsEnoouOoIpQxx+gt9RUWvQEHXPnKt4CxEsFRj7UKf76bX1LsmsTONLbmIhGtsmXlAy7
         3U6SX6hGPsA4qSc85/teb9QwFN2ZzmGWz2ftZRK/Ap2H/u0gL3MZ7gny+OvryTrPqb7H
         250rz0aOZDoy4fmIBt/3eWGrl7Qzomhb0GW2jMFSlNJUdtubfECf0VujXhEhwxFvthvz
         6NJn+N0IAYcpaVrMfYoyzPKkMttiGluLNfUbO/As875H9oiBMuQqYQBqoLCu8hUEGX7M
         wKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030321; x=1758635121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0s65qDgowOOSGjJfE5946fkY4IW8WBrWqqfNZeJx30=;
        b=oTvQFDNBuoBuaNyhFSLxuyOdCpBUTJ9MYL8HXa/RQwF/as/OQ3sC8Gyjcb7IoZq9Vp
         wBHEEUjI0GM4G5y/40pdWwpPJTMN4pf8aidHeYxsj/uePFKXwEXWr0bXmrLchCoFAbpx
         BDC+G2nbTkGtc92zqIqUCdBZKBdSxxlLe63QNRUmLtzj2fOnx4gpGAS7sgjnI5SVHVrm
         bIQQv6Fpl1Wmdj6WsPDfW9dKoOk/H/SnQetZr/QpORqYXO2811SZNpm9EHoatGXNIoId
         6LRnU8iF/eptXe2+Mb2gAykqQHc1W5hMESDSCaZdsEtJc1lFy6v5ELzGmUvUT6n9WwEZ
         qgHw==
X-Forwarded-Encrypted: i=1; AJvYcCVPslawTQweSEWIsz7vhIwhJvWBeFFxCMzGF75J5WlErPZUVrqsrCHpu5C4Pp/NDmTPjpx6CJx8sqf5eVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwR4XAL5WIc4SED5O2ugmNbsI+HIpOzSVOFcBAz1wiwewutJe
	9D8Yz3BvR1ATtgrWHXQAJ1Nfbrnofj1bFgU7Lh4YpErAqHEluXyP/zCSS+Tzwu97mgOKSLT+USc
	vFBgiaRPIVZCkcILHobSgoHxnKsUV89I=
X-Gm-Gg: ASbGncvjpQURXuISARGbTNxRjD9GVCm3jyQbZzsRJ95XQERMA4BPtQxKkS4Y9fgHOAP
	gnEyFEy0leTW/4djRKimEoX6UN7d9/lKZvfvmTbHIKi8uS5nz+A3+UagpcJhPtwZASNeFqni/+D
	0k4CeveatG2rFipqdWkg80Asupl7Kiq/W00E7ILXFrz8ggDfZKM9FuT72jNlRwq81nHPRdRcosP
	X4V5M69XXLVvUHMw8AabVACJBLRYFhCTH8P9axDItB6voFHXg6AR2quFd559j4vG9zHutLeXnCj
	K24V2C/EZc1777cPaYlOzKsDOw==
X-Google-Smtp-Source: AGHT+IHPLqw0AIyLnHcYCRTMF/ApKTmwBc5zMDhb5jtN/lV+nldHeK1DvNtke7/9TGrkHZ1QaUkr4x3zM5ESSIJ5CuA=
X-Received: by 2002:a17:903:110e:b0:257:3283:b859 with SMTP id
 d9443c01a7336-25d2782cb52mr108934005ad.9.1758030320734; Tue, 16 Sep 2025
 06:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMlmYa5UjLe_ATl_@sirena.org.uk>
In-Reply-To: <aMlmYa5UjLe_ATl_@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Sep 2025 15:45:08 +0200
X-Gm-Features: AS18NWBP211A49aVaEolds3E2GGLOIpvDbK089X6BZlvKoeEt1Gp-RB0UbsEPNI
Message-ID: <CANiq72nyVk98nw7L0vukZ1fE+Sj6Eh5RzYpUsOqUVPuRE7fHKw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the vfs-brauner tree
To: Mark Brown <broonie@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Shankari Anand <shankari.ak0208@gmail.com>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:30=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> I fixed it up (see below) and can carry the fix as necessary. This

Thanks for all these Mark, and sorry about it.

(I may use these as an example for my proposal to have a chance to do
this sort of "treewide Rust cleanups" late during the merge window to
avoid this sort of thing for Stephen/you and others.)

Cheers,
Miguel

