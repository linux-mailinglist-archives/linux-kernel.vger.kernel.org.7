Return-Path: <linux-kernel+bounces-841306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4CBB6FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD993B4514
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42119D8A3;
	Fri,  3 Oct 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afYp03vJ"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A29D83A14
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497439; cv=none; b=Zt3KeWjQCF8sOsEHx5m60fQjC88H8gbcgBccRmrdOsJb6RINjY4gy8hXunO71oqmWA8luxPOMO0Qui/KMFzq+4WG7M3TV6wkA97HlXztfJd//Rv2O5ZWIyagB+4bUgxn9rzV4x92281zJmk2Cu16lEhOsdCfxtYcBPO/XPnKsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497439; c=relaxed/simple;
	bh=9N3qKh78R8XZXrpeKRSpxQJ1Zg/mtyZj2V0dot6bsgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bITB0U0nScBNUZkTKU483OCSM+L1NKYMLMFskVLcuweuFi6bg/0glb/vyABykLE21K3k2bDVBcvrK1CwjiK5a/JhI01RS4d4p5hFBGCQZDs7l7cGoWF8CDj4nc8A3itQZxChEhv+2EAn8akWjlrDlEkMP3QWE7KXq5V3oExkL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afYp03vJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4de66881569so421721cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759497437; x=1760102237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHKBwm7NMk1wAiAxUu9pldFnkwOOCl4Cy9AyP1TphGA=;
        b=afYp03vJskJcgG2bjygwZpYRmRXXyE/XvxiK/COM+AVEFo/O2GTt8+b9oMvdhsrHdK
         zIwDFzbonXxv7SgUe2yxxIpoXZ90gxtblllbKp2oghJvqjhVcbwsCfTpETeJSLBGSYPG
         0XFs/4kX5vMpCWWOTnXmVKJwzR4sUHKAaj4pYA3RnQRG0HqEgz0dEdRtXJlZHZBDwsWG
         MgxEfQzyxy7DOPJ8pYccEPKTRKMZDLEZzj6dmbAzdQNaArYwauRGH2YrhGPt37TXfh4L
         5thNWnJXZvmCRvox+pQXMaOCSwtwk3p60GNQA7PGYZcyk6guSBRJ5q/V3UkDdL8EFKFH
         hNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759497437; x=1760102237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHKBwm7NMk1wAiAxUu9pldFnkwOOCl4Cy9AyP1TphGA=;
        b=PIp9xvRHzxu2SpDx0/0q0Q65YYk6xQMugb5/A15PSwR3L4YKs1HMG/sZJU9XSTBgcV
         jl6TTVTLwH0feHW/gAqldELIdHocYM6Vi/tJJSck8Rw2176HLmLxPpLXdqRggejieoWu
         4jR1VwBEtnyhMjqraujOglLqXJldtMux2cW2PqT2aPb9XwXw72ch6fNuEA+c5YhqOeLO
         SVSBkK0a+6oW5p242dy07HiZ3dxG4qdO2FxxdnokZIBFVAS8bMwZn+dMsc6wXIp5b3v9
         ShhTddMvaIWhRbglIa1MkgQllUEYEJUYZXyyldRpOMIqlRz6HHCmUrEA0TTTt/8/7M1L
         Jjpw==
X-Forwarded-Encrypted: i=1; AJvYcCWGTylW/0jzX/QMbTRSYJpGktUuK4sw17Ci6IbwbfaVmlNtUrP3R14gwYzjTGHOcKTdWw3mYadYqqF1Ccs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3asELCq1s3HT4MLwpJTmM8PKY3fUGnfQf3veNbDUiDa6zMBp
	7FyLn9p4yvk5E3GsaMa5/ckQLmf0EQQsJK+nIglOVar8iJiwCbg3rQ+OBojZMzjdwwqVxKXwStH
	5BtMV2gX/33FkNUc1GFB4LWZBG6YBzqmq3CUSoHbJ
X-Gm-Gg: ASbGncv18oqsU9+I8tQ2yT/MPRkHj0Lwp5zXVsKZBthiKlPlWfMW0+pbuSgltGj3XPs
	FqjbUM1R11n1aFQVGmCttEZAEDTI4sR55YbRSIurnjSE2MFFlRJHjaLjYRRpLg1xn/924iUjuAH
	Szy2sqWAAqCovja5RGiC2efTXDEINynysnP37O4tevPoJNBTl12Z53gRbILa0t2S48EmC2WJ2td
	SXfhH9OKTKyXahcd3/ahaxMVXEkRs6P6u+tD4imDiIeQgs2T2u7AsqWNkZ6a3jZefmDMBFs5G+6
X-Google-Smtp-Source: AGHT+IGE7+IByknaVWxiVR31VKxGd14F277kivObfOi7gJMj93c83sqsD1zVicMJpTqN29wJP8C6PN1mQCF/t55gEto=
X-Received: by 2002:a05:622a:2cd:b0:4b3:1d1:fddd with SMTP id
 d75a77b69052e-4e576ac8af5mr5570341cf.18.1759497436448; Fri, 03 Oct 2025
 06:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFgf54oYjUEg9KkQUzneYTZH1Z8cX56va5M0853eWPFaYT+Z2A@mail.gmail.com>
 <638b9565b90714f56caa9535b7b9b96cd86100d6.camel@collabora.com> <aNaq72xKS4QaNjwx@google.com>
In-Reply-To: <aNaq72xKS4QaNjwx@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Fri, 3 Oct 2025 14:17:05 +0100
X-Gm-Features: AS18NWAzGDKh7rPw80AiVMNesJmz-wqevOZz6iqXp8GuPpGGv1cVAqCeWYGrVWI
Message-ID: <CAFgf54r=0T=AbSm4BVOf6+8mHRxOPje+zSbfZbwb8d6u46HPyw@mail.gmail.com>
Subject: Re: Support for Rock PI-4b
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: devicetree@vger.kernel.org, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, 
	open list <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:02=E2=80=AFPM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 04:28:48PM +0200, Sjoerd Simons wrote:
> > On Fri, 2025-09-26 at 15:07 +0100, Mostafa Saleh wrote:
> > > Hi,
> > >
> > > I am trying to run Linux[1] on my Rock PI-4b, which I see is supporte=
d in
> > > the kernel in =E2=80=9Crk3399-rock-pi-4b.dts=E2=80=9D.
> > >
> > > However, compiling =E2=80=9Cdefconfig=E2=80=9D (ARM64) and flashing m=
y Image doesn=E2=80=99t
> > > work,
> > > It just hangs before any console (even with earlycon), I tried to als=
o use
> > > some of the vendor configs with no luck.
> > > I did some research and found that [2], which indicates that the upst=
ream
> > > support has been broken for some years?
> >
> > We've got the Rock 4b in our automated testing lab as part of kernelci =
and other
> > efforts. Upstream works just fine on those boards, so it's likely an is=
sue in
> > your setup.
> >
> > See e.g https://lava.collabora.dev/scheduler/job/19978558#L525 for a re=
cent
> > upstream kernel boot.
>
> Thanks a lot for the quick response!
>
> I can see some differences between this log and my setup.
>
> 1- My uboot seems ancient
>    U-Boot 2017.09-00026-g2431fa34678 Compared to U-Boot 2024.07-rc4
>
> 2- The board model in this log is not 4b as mine
>    Model: Radxa ROCK Pi 4A while mine shows Model: Radxa ROCK Pi 4B
>
> 3- I am using LLVM not GCC (I don't think that matters though)
>
> 4- I am using MMC to boot and not TFTP
>
> I will try to look more into the differences, and update this thread in
> case I was successful.
>

Update on this, in case someone have the same issue.

After updating u-boot the same issue persisted.
However, I was able to boot with eMMC instead of an SD card.
Which is strange, as I could boot an older kernel on an SD card with no pro=
blem.

Thanks,
Mostafa

> Thanks,
> Mostafa
>
> >
> > Regards,
> >   Sjoerd
> >
> >
> > >
> > > Has anyone tried to flash a recent kernel successfully on it? or any
> > > tips are greatly appreciated.
> > > Otherwise, maybe it can be removed to avoid misleading other develope=
rs
> > > (I got this board to do some upstream kernel development on)
> > >
> > > [1] base: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
> > > [2] https://wiki.radxa.com/Rockpi4/dev/kernel-mainline
> > >
> > > Thanks,
> > > Mostafa
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip

