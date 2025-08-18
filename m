Return-Path: <linux-kernel+bounces-773419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E687B29FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3528417D20C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07B310648;
	Mon, 18 Aug 2025 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewRyiijY"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB83101CB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514527; cv=none; b=myR4lrSX2NdZHrWhKeb2a3QrRU2L9BunVlZvAPctQ6texAKjNnoZLPB/Qm8DAa/VURfqg5Z4A+kDq6eXMdL3yKaHmSsG3FeJ6MYmSq6yrbsRCCLIxLC4o4+fo/vbUFHdgRC32aRGANfdvpLThaW+B4Xwl+Q5xTWr+zov3J/h9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514527; c=relaxed/simple;
	bh=8v8TvRlAn2uDDJRIPEFDt6WoHdfXoTTVsusiQAdG50Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU/gjSaQ45GgJbkuRm5X32uZSVDqaDaSplQ3bY+UVE2k3PO3ZryCJ0n6jox5EVbpjIpIyeYRXzBb3Rm8YjJDOXDHE6grUikVeueSo55K1Il1N3KCoU6C7Cp3S1aOXqxWyaAEYA+XMyIXGqdq0gi2K3bZO3zf88THGEhtjQddwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ewRyiijY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d608e34b4so31815887b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514525; x=1756119325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5UfZNE0DRarpftqobVVVHwkS2MsbGM6sleGxn/cdL4=;
        b=ewRyiijYTZMMAwf6ga/lpPtwuDM+tQg9+coHGUV8hbAFABbNQPJgNv6Si4g/2XgiW7
         /BDYeqcMA35G/B508hB/JZJCRPEZ/MD11c3DLslCi5Mm1WdQYsQb7Z357VdHQ72EOyRk
         b2nqCKHJVX/KXGEV8u00TYpKyJmyIuZbaozKjZ13fNKk8/eUZ1PApNohCRw46V3v5kYZ
         IB5Fj0P+QEBeNQNGhClOCPkkC8BGnNRclnXaav7+D7Me8das38QFqNb87C3qGwyV5ojb
         tyxqkt5R1cJ/MzG++GlFTeSoR3J6nRZhzgzc5DBXL3rNnHt6xCqt5E69njC+yspnoi1I
         ulDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514525; x=1756119325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5UfZNE0DRarpftqobVVVHwkS2MsbGM6sleGxn/cdL4=;
        b=WdvOHjAEQxaunSmTMgp8P9JZAdS60VWz5P7susGemtxRitHNYqJ2qzXAxnVAG0N1u0
         400ZRiQu59W5J5tsmVFwmMyn2OrQx3TrbHgcQC8krQo93nIYoYChX2gGGNDp8jAViuD0
         pTTwJ0trD58g5nxNi8sUvS3+RuxsKbN9WZ2eyl7hXbBQPMGqQhvmHnCOqdJCrd8j0phe
         x3JyfZbOLSydJdpTjCVB12PwfeDV+Xx1iouRqfvjBxKgFfxfserc6RWUk4C2pZur2YZp
         qxOtcVyBCrZcpkUmMw/ufVSH5o1XaaGJLDwsZLDsFBQoxHwZv6+F4Zp2vHrgPTqQbv9M
         PsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD/GPzdyJdBE6zq5KwAsMfd9qUZchN3foXN8BYsf2SrAkkksHYMYWnmRfCr0QPBVpqqhV2FEF31O6Km6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq43XCgtfDv2gnDJiKHmuO68slmhEJ9ZGtCmHW72zBh468yhg/
	fPX5DPJTCumc8pjEUzEuRwgTdFSa1YbVD26D6+fHRrPqCL1ezPbCYNEmvYwJE/OgULj2kWzKZli
	CQTvmDdRp0nTqUmYZyGUDWWVB4UeMpmZxVAIQD8642w==
X-Gm-Gg: ASbGncvKhIsVpYSFIghbJhTOfsWH2QSxLa5gsatyGmL3fr2ovlJwBjgpHRumcCXrPGX
	6gRGhDehopfTIZgrbODZ7wqovZVHEQTaW6C1tkFzDv5wR79CAfKtx1BEQGDyADhkEz3X0kdyRz6
	ZPVgglSxoF7J9Q1uc9tFb40QC1KX/lUfmy6Rf4uMsp7L9DX+ei9S5L1MiqE1EwgOAJSN8JpmvHz
	Q1nhkdd
X-Google-Smtp-Source: AGHT+IFIkic7VQeFkO+cxnCkWqNMeyV+EPEh3o+DVB54sudGxTRKxvw80/DAtEKXY550Y9Oqwc+PI45Z9IPOC/KAAVU=
X-Received: by 2002:a05:690c:9a0c:b0:71c:1de5:5d9f with SMTP id
 00721157ae682-71e6de4edb9mr140911667b3.41.1755514525210; Mon, 18 Aug 2025
 03:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731065752.450231-1-victorshihgli@gmail.com> <CAK00qKBzeXJMkYsz7zZTkLDgQ=EAoHvOzPrzmAbJeyUsMZZq0g@mail.gmail.com>
In-Reply-To: <CAK00qKBzeXJMkYsz7zZTkLDgQ=EAoHvOzPrzmAbJeyUsMZZq0g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:49 +0200
X-Gm-Features: Ac12FXzg7qrQCxBT_ZKH9q0IQdGRfAERuYgkqmKFbh45UhoXCJmL4J54ucRZJyo
Message-ID: <CAPDyKFoiq2YPZ0Ka8v_of_rPwPf3pU96kiK+_Nf=uwKixobppA@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Mask the replay timer timeout of AER for GL9763e
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 at 16:11, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf
>
> I'm embarrassed to bother you, but could you help to  please review
> this series of patches?
> If there are any parts that need to be modified, please let me know.

No worries for pinging me, I have been off for a while and catching up
on everything.

The series looks great and I have applied it for fixes, thanks!

Kind regards
Uffe


>
> Thanks, Victor Shih
>
>
> On Thu, Jul 31, 2025 at 2:57=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > These patches add a sdhci_gli_mask_replay_timer_timeout() function
> > to simplify some of the code and mask the replay timer timeout of AER
> > for the GL9763e chipset.
> >
> > Changes in v4 (July. 31, 2025)
> > * Rebase on latest mmc/next.
> > * Patch#2: Add new message to the commit message to explain
> >            why it has a stable tag.
> >
> > ----------------- original cover letter from v3 -----------------
> > These patches add a sdhci_gli_mask_replay_timer_timeout() function
> > to simplify some of the code and mask the replay timer timeout of AER
> > for the GL9763e chipset.
> >
> > Changes in v3 (July. 29, 2025)
> > * Rebase on latest mmc/next.
> > * Split patch#2 in V2 into patch#2 and patch#3.
> > * Patch#1: Correct the wrong parameters in the
> >            sdhci_gli_mask_replay_timer_timeout() function.
> >            Add new message to the commit message to explain
> >            why it has a stable tag.
> >            Add fixes tag to the commit message.
> > * Patch#2: Add fixes tag to the commit message.
> > * Patch#3: Add fixes tag to the commit message.
> >
> > ----------------- original cover letter from v2 -----------------
> > These patches add a sdhci_gli_mask_replay_timer_timeout() function
> > to simplify some of the code and mask the replay timer timeout of AER
> > for the GL9763e chipset.
> >
> > Changes in v2 (July. 25, 2025)
> > * Rebase on latest mmc/next.
> > * Patch#1: Add a sdhci_gli_mask_replay_timer_timeout() function
> >            to simplify some of the code.
> > * Patch#2: Mask replay timer timeout of AER for the GL9763e.
> > * Patch#2: Rename the gli_set_gl9763e() to gl9763e_hw_setting()
> >            for consistency.
> >
> > ----------------- original cover letter from v1 -----------------
> > Due to a flaw in the hardware design, the GL9763e replay timer frequent=
ly
> > times out when ASPM is enabled. As a result, the warning messages will
> > often appear in the system log when the system accesses the GL9763e
> > PCI config. Therefore, the replay timer timeout must be masked.
> >
> > Changes in v1 (July. 16, 2025)
> > * Rebase on latest mmc/next.
> > * Mask replay timer timeout of AER for the GL9763e.
> >
> > Victor Shih (3):
> >   mmc: sdhci-pci-gli: Add a new function to simplify the code
> >   mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for
> >     consistency
> >   mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
> >
> >  drivers/mmc/host/sdhci-pci-gli.c | 37 ++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 16 deletions(-)
> >
> > --
> > 2.43.0
> >

