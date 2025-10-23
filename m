Return-Path: <linux-kernel+bounces-866110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281FBFEE5E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266C6188DEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539FE212572;
	Thu, 23 Oct 2025 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JeOKP1jW"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610C20296C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186067; cv=none; b=k7ISD+v66PE4j08JL0IEmtDch3BVMyL4QaFsskpnwMF5dik0LZn/BBifFHmJroVsxvPLh8FziyP9+eAq660QGUE3wAXgyBBG7HyEhlYGkB7kXZHfWp75YvA9+E33yo689EKKhfw5WXYRL/SAydUK0ACQFpcpxUMrkuOk8D++3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186067; c=relaxed/simple;
	bh=R427Dmu3YODNR2POQX9bpNnQmIqw5THl/CmnS0STWbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPtNqGI/cXI9yL0oJZMV2CImJzD43xhf+7i1Ll3EHNsg9bvq2lgf4Pcmhr364Ma5wvjBOG9lqrsJQaiyRV1gT+19EV1JKYJV23mi08Ze0mmA2cHZTayL8jtEKyAtlvEX+PjvBcNiVb1eWUcR8QnFFTiLlOjKHVPEZGDSHDNS3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=JeOKP1jW; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3c9a2fa38c1so111149fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761186064; x=1761790864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R427Dmu3YODNR2POQX9bpNnQmIqw5THl/CmnS0STWbw=;
        b=JeOKP1jWkH3Q5sVlxkuytJ1976e3xdzNC7Buj5tcUiBp57HIu2pKPbyzNRpNpxglyt
         Xqt5s1ManbIWm75OI6p2fElNN9SjRuDsA8PklE6icmGCympivWXgtiX68QTSjuUQBY+t
         mpJrH54gY5c2NF8ieLSBXGedp8LqLDra2QQ87+VUm7G6IJcSeiAZiiM2kcdtbybXYovQ
         5ZGLAJzudMdyDsoi3dDZwHzG1OcqQyMv68sABuW1JwFz6h7PtEtexNH5q3xO2ja+KC4R
         TKhm2dSA/hIS1O5rH5Pzitn4ZwUvJUAr9Q9XEFhV+oNCF+q3lAOQTA32E1c7pGM2Mt7a
         zoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761186064; x=1761790864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R427Dmu3YODNR2POQX9bpNnQmIqw5THl/CmnS0STWbw=;
        b=um4DdyBne31g8a398Kc38BBqIY0edqHoVGwTQfMOs0S4ahSl1+DfzMHY9hd4ckcZlw
         MoXGsMuyBasaDmZv20L1Q4RGV8Vh6UbE5vKGMMdFAcXXzVW85VJeND/VtVJGxp+whey2
         v8qbVZ/xpJ0eTX8AQaf0wo4rVbDw+ijRve2bzuW+/ibgDHXEwMRWQl/WXt52ZZ+GMX8A
         ZOE50vD/XFhQ5LliXTAWvCfx8TVg/Fjeap6CYt8QSChZ5FPl0imMfN8HIyFHqHB4gQNr
         /lSBRtKnnMwz9hk+XkIs696+eCKfg+NomQ3LUA2dT1wM4taet6JsphzNTf0L253GPRJi
         lUtg==
X-Forwarded-Encrypted: i=1; AJvYcCXeHQV7Oot9T+lCl0nhrT0B+LWitaMwi8s0jfsKi0CmuwA+mpBjBJxuStHZyH4JeqyhZ5JZrvUpwHGXeWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzulWRuLbDsi/BlVpBwkIUlGsxfgr5fvvV/MYmV0ZrwElfL39wG
	lSrVNRbIbOhX8a9hqPjzCjtPa+D0QYuZjWfpv5rQw2AcPAZMAMp50XM7d3z/aZ0VlLl9e6Qr0b9
	14lUMXBmOHSBxAmvihtIP/hC2BcJUvpmvcLkWm6RB
X-Gm-Gg: ASbGncv6kgULPBAgrxEV1is5RhpfEYjRUJ1pfABetIHHhFDu58i9HaveMBtkqhS1Jcq
	obT4LaHymRl4Fu4H11Krav4N/S5BoQiFk6wHxHcd7wYcFEMyw7/3gOe4+YaTuK8LcAmcve78LgO
	TKFra6rgvWtMlJYegcrlgEd9hv1EckOkjoYb86tPz/0RSLkniPqpj7y1EHDp0ODgbPdf4W3wBk3
	TIeHFC97y54V+GGBnLtYAjIJqvJeyzJzVfTBVCWc3IFvy0e0GRzAQ7dq4bo8A3Ifq+OIl4RwIZz
	tfo8QOQCncUqLcvvkIfnlH859JcHFw==
X-Google-Smtp-Source: AGHT+IHmRLKymahTzphWXAcebUY/vioCOyMVmnPrpkx+yuxscWkWBl0sW3ZAInJO76yoYP2ATwjD1Umq93FfkvRAowM=
X-Received: by 2002:a05:6870:648f:b0:341:33fb:81fe with SMTP id
 586e51a60fabf-3cd88b3151emr2212186fac.4.1761186064007; Wed, 22 Oct 2025
 19:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com> <20251022201953.GA206947-robh@kernel.org>
In-Reply-To: <20251022201953.GA206947-robh@kernel.org>
From: Adriana Nicolae <adriana@arista.com>
Date: Thu, 23 Oct 2025 05:20:53 +0300
X-Gm-Features: AS18NWAnX3tdmQK4mY34lhn-vtbSOeSxTP9A7wJ8Ju2u0pZ_JzhEiwf9-6ikOXI
Message-ID: <CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
To: Rob Herring <robh@kernel.org>
Cc: krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:19=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> > Some bootloaders like U-boot, particularly for the ARM architecture,
> > provide SMBIOS/DMI tables at a specific memory address. However, these
> > systems often do not boot using a full UEFI environment, which means th=
e
> > kernel's standard EFI DMI scanner cannot find these tables.
>
> I thought u-boot is a pretty complete UEFI implementation now. If
> there's standard way for UEFI to provide this, then that's what we
> should be using. I know supporting this has been discussed in context of
> EBBR spec, but no one involved in that has been CC'ed here.

Regarding the use of UEFI, the non UEFI boot is used on Broadcom iProc whic=
h
boots initially into a Hardware Security Module which validates U-boot and =
then
loads it. This specific path does not utilize U-Boot's UEFI
implementation or the
standard UEFI boot services to pass tables like SMBIOS.

Because there's no UEFI configuration table available in this boot mode, we=
 need
an alternative mechanism to pass the SMBIOS table address to the kernel. Th=
e
/chosen node seemed like the most straightforward way for the bootloader to
communicate this non-discoverable information.

I wasn't aware of the EBBR discussions covering this. I've added the
boot-architecture and arm.ebbr-discuss lists to the Cc. If there's a prefer=
red
EBBR-compliant way to handle this for non-UEFI boots, I'm happy to adapt
the approach.

>
> > This series adds support for the kernel to find these tables by
> > reading properties from the Device Tree /chosen node. The bootloader
> > can specify the physical addresses using "linux,smbios-table" and
> > "linux,smbios3-table".
>
> /chosen node entries go in chosen.yaml schema in dtschema repository.
> But first, I need to see some agreement this is how we want to support
> this.
>
> Rob

Adriana

