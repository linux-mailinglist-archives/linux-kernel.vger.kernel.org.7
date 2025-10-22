Return-Path: <linux-kernel+bounces-865987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A74BFE81C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A228502851
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE730BF64;
	Wed, 22 Oct 2025 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGrS11gW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAA306495
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174828; cv=none; b=CwQnpptuABqGbRqwmV6OnX9lWkl8w0hBqSQUSDbnIRJdpP3Byh/uAfmUakRC0XPDIN3alVduxwQZRXsF/CIW6uIiN+hGiJVNzUmzM3BHL/glPuykbJ6EbCqvy12Q1CjOsLIMIWGz5NfoLT3vF6BxPjmFewiykC0uDdRts2XOtKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174828; c=relaxed/simple;
	bh=TGQodGtXgknIsWY7/3w2xJfTuc724moitZcuwddpmY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLcHsoNvowteZCjgiOl/RHT0+0TbnSf0RoormmV17u2x2KLGQJPUdUTY0n0kG2WKLyIGmRkIX8cplUnTNlxU/Ai+ipGjsTasTJDVj/x3UmW14/YMWggf2pWcViwduyvz+IU6VqRJoIxeJo/OWBe/Wn2mFjYrXdH3HEMUurMms3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGrS11gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF67C113D0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761174828;
	bh=TGQodGtXgknIsWY7/3w2xJfTuc724moitZcuwddpmY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XGrS11gWAYfTJ4IcV4LYcfELOjj70/e52+6oqPXPAqysk4uMmmWpXlQy4pWZIQDdt
	 AODo9iEUmqSojb8h+kZpkXsqn0TXwnAn8AT/JsnqzzHJic0o7/rVhs9BeRb49Wb2CX
	 bo0tfEE/vQ1Ac913vQjOXywRmK9g4SZ3COJPBB5VCmD363kDRr1byo2dgQv/aKRhAM
	 QcUkCm3w2hxWDPloyCjuUygwPIslgg/+LvGwQLjwqh2iCahmdnqCGjuurrmYHpXsL0
	 f3Z4Le1mhqmBNcE2jQ5kh/f0R2tTZ6uA78irauG9dDWtP8cPh6XPFmnzMt0ee0+7o0
	 UrWHV4eAssxdw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so275929a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:13:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+aYkhc7NI3QeVmCi/YaJBukxhbLrRLdYYcKZG2g5m5nqGIYysSO5ohSy7U+1eA/kdTiVNiY8kyUvNDWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAbwx+BfyA3NwmhJYW0mLDVUF/e9UP1jGisQoj6E4vztLvUlY
	2bfGs6tsjDbQ4VLL9iNOJ/JyfKe4xWIsdjntMG/+GKUFaphOxL1IVW6sfNDeQi4tF4KiLRfo+3F
	fCzTZdXvhuNTIedIZC0VzoA21tPvgqME=
X-Google-Smtp-Source: AGHT+IHa5nyuANlWVI4EYphccWVc09Zo1B8uBJqUhFVxvUaS+9LYu1uwl3f9ymu6svhKRlY1hkMC5RHo/C+TtCFRprE=
X-Received: by 2002:a05:6402:2551:b0:63c:295a:d516 with SMTP id
 4fb4d7f45d1cf-63c295ad6f1mr23462978a12.27.1761174825930; Wed, 22 Oct 2025
 16:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025102125-petted-gristle-43a0@gregkh> <20251021145449.473932-1-pioooooooooip@gmail.com>
 <CAKYAXd-JFuBptqzEbgggUhaF2bEfWMRXCSK9N_spiBxvi1v0Wg@mail.gmail.com> <CAFgAp7g52dJDvJyEoV7Ms-YofG6a2=G=N16ARNrBOiCSkLVLTw@mail.gmail.com>
In-Reply-To: <CAFgAp7g52dJDvJyEoV7Ms-YofG6a2=G=N16ARNrBOiCSkLVLTw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 23 Oct 2025 08:13:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-v9r0kKU9wO1ZZAtFju4H+OsG8RA3iYd15=eR6d5VEaQ@mail.gmail.com>
X-Gm-Features: AS18NWA9NqkARBQUm-jcxNp4I7v8U9iK-F28MdBbsUrCH4ZQBHXD6jTrQSJ5QII
Message-ID: <CAKYAXd-v9r0kKU9wO1ZZAtFju4H+OsG8RA3iYd15=eR6d5VEaQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: transport_ipc: validate payload size before
 reading handle
To: =?UTF-8?B?44GP44GV44GC44GV?= <pioooooooooip@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 7:45=E2=80=AFPM =E3=81=8F=E3=81=95=E3=81=82=E3=81=
=95 <pioooooooooip@gmail.com> wrote:
>
> Hi Namjae, Steve,
Hi,
>
> Thanks for updating the patch. I=E2=80=99ve reviewed the changes and they=
 look good to me.
Okay.
>
> Minor impact note: this patch prevents a 4-byte out-of-bounds read in ksm=
bd=E2=80=99s handle_response() when the declared Generic Netlink payload si=
ze is < 4.
> If a remote client can influence ksmbd.mountd to emit a truncated payload=
, this could be remotely triggerable (info-leak/DoS potential).
I don't understand how this is possible. Could you please explain it
to me via private email?
> If you consider this security-impacting, I=E2=80=99m happy to request a C=
VE via the kernel.org CNA.
>
> Thanks!!
> Qianchang Zhao

