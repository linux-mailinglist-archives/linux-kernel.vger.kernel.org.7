Return-Path: <linux-kernel+bounces-673095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E8ACDC25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E761675C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12428CF58;
	Wed,  4 Jun 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="mGygoU4J"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758D28C5B6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034241; cv=none; b=uXNxqONYjjZ4C7A3gj0oxPUY/YDUcoFoTN8b/sss13313M1sNnUerPdvHtEp3xJewxi5Dz+bgaCX0zqnX060Ypr/XZg/I2Qe/bc3jUVoRcHJ/bXpEHkcF1VFsSpQ04ZFTTBgSL7VRW8AoZoMmQiaD7JjAw9a8SidekpTMlx00ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034241; c=relaxed/simple;
	bh=jn4nygRnTKj9fV+Xag4PqoajhS/sLBPzpXAKdRZIkSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS6GDgXyNNrDcBwfmArYC/3DGn6pDFECOHGBnwxcVFDLExIn/XqwhJGqep2+m15bAsT4X2KJFx4xcb7r+bmS0otxH2Ssh8xyhtwUyG3e1dUoatIApqv9vwjLEnKnOKCLhr8NI+93YQ2vax436cr17WwqUs9yRa3WVexLfry+lVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=mGygoU4J; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8134dee405so3717805276.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1749034238; x=1749639038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMikC/irEVPa0Hohnvi6eoO332ZgA2v4xeO8L+pg4Ds=;
        b=mGygoU4JVXevxiAZITgyyF3XVDdbmuu3iDvu+ng24VEOTIbFQOCregMuKzvG8Fw/qU
         VaF4JzxnOKhKmN2rVrln9q0/8+RiNJyXvzt1KDqOtM3eK/+/DgGWAju6WLKie7o5Kfv/
         ROt/aa8DoQRA8EQYhWNp079emtGlEqqy7VRps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749034238; x=1749639038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMikC/irEVPa0Hohnvi6eoO332ZgA2v4xeO8L+pg4Ds=;
        b=pAhPG32AXFYxxCYOrmVis0b1ptcdQ9o296Sxriuk1uhHqMCFXqb6w6U7xxd67kPjNt
         HTM0Iw59qpMFisMTPWYUGiO6JYCQTbCipdPpANalEhKeyiosV9rTaoqMxRAf3/IRKJxs
         T2a8xRI/CmnC8yhYwa0phYQM7Vja5YXLdw9/k7e9u4HkNER6OnX9aIHlLdmN9LnXAhX6
         fpLZIWY9cHLMbtjnU31C8L03npKfUDi07SkHY8WLPQG5LqYT0zW71BNT+Ol3zoxF58SP
         KP6Vjc/ZV7vEULO5kHlvvIOLVagTr6UyDwteiQ6G6wGsqFzCdmULsB/SdvGcjbSTXeyX
         1otQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGElHWnfdNbUNIWFN8snrglpeMpYcOpFl9aWmunB/9F3xeEljckRrmUodvdajQnGFEHpJPqaej40A9ISQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NEy7jtOa5bMlpJfwLijQguyKS5fTzE6zICYCmC/5w/xZ55ua
	rXp7IGV/I6GLMDGu0+X0dyx7Z9r2waf5kTsptEjZuvzmBWE+p1BAuzV2NK47Bj+uvLl4FtTyS/4
	dnOa+mZiqCeWwH4WfM5gWrlv0LQKBXYAR3UVlYpLg/Q==
X-Gm-Gg: ASbGncuXqKQdKs4E4wnKecJDfKiy2HY/gPhtTaY6BDXh6sB9+LnPIzhDPPib4yaZIuG
	8ErnUoRGT1FcSgKuEBCXCsm4Cs0sQrQyc4PGjJAAa+GvmALkW4EX+Ok7QqUJxJ3X11HJUtVKd88
	3HxX+o442hWfxW03o2F1g3IMzy3ZnDxErnVi2pERD15VBJ
X-Google-Smtp-Source: AGHT+IFWlEF6Prrn96FnW4kqan/Qb0noChaG+ccVxhKjIFms+WNmINJx1a1EqZrB7XhYaXDlzutOFigrnkk7T1KJs8o=
X-Received: by 2002:a05:6902:18d0:b0:e7d:c87a:6249 with SMTP id
 3f1490d57ef6-e8179dbababmr3083480276.36.1749034238352; Wed, 04 Jun 2025
 03:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602053231.403143-1-pavitrakumarm@vayavyalabs.com>
 <20250602053231.403143-3-pavitrakumarm@vayavyalabs.com> <9f6b4442-1fb0-479d-9514-410d4d8bfd98@kernel.org>
 <CALxtO0kitR0MnjzPwVT8nsuYThTRX+fbyOH9i2z1KKnCPg1dqg@mail.gmail.com> <ba13c2f1-9b08-4ba7-8093-d55c16143cb2@kernel.org>
In-Reply-To: <ba13c2f1-9b08-4ba7-8093-d55c16143cb2@kernel.org>
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Date: Wed, 4 Jun 2025 16:20:27 +0530
X-Gm-Features: AX0GCFvr1jBPQKug_8tsk9gqR4GmtY_mFZiWF1BuLivnsEZbP1Uhfaym79oBKSI
Message-ID: <CALxtO0nVngMjC4cg+d==p7XktnYJ9EgP_cXgwaJ1NOizPCJqZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] Add SPAcc Skcipher support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, herbert@gondor.apana.org.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Ruud.Derwig@synopsys.com, 
	manjunath.hadli@vayavyalabs.com, adityak@vayavyalabs.com, 
	Shweta Raikar <shwetar@vayavyalabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,
   Yes, I do understand the use of static tools and the W=3D1 warning
checks on gcc/clang. Anything missed here is not intentional and I am
ready to add more tests and checks before posting patches.

I use Sparse, which did not show any errors or warnings in the code.
  make C=3D1 CHECK=3D"sparse" M=3Ddrivers/crypto/dwc-spacc/
  make C=3D2 CHECK=3D"sparse" M=3Ddrivers/crypto/dwc-spacc/

I missed Coccinelle, because I had installation problems on my Ubuntu
20.04 workstation, which has the build setup and my cross compilers. I
installed and checked SPAcc code with Coccinelle on another
workstation and I do see errors/warnings in the code.
I will fix all these and any new ones going forward.

   cocci.log:25:./spacc_device.c:132:2-9: line 132 is redundant
because platform_get_irq() already prints an error
   cocci.log:27:./spacc_device.c:301:3-8: No need to set .owner here.
The core will do it.
   cocci.log:50:./spacc_aead.c:575:8-15: ERROR: iterator variable
bound on line 572 cannot be NULL
   cocci.log:51:./spacc_skcipher.c:202:8-15: ERROR: iterator variable
bound on line 199 cannot be NULL
   cocci.log:52:./spacc_ahash.c:288:8-15: ERROR: iterator variable
bound on line 285 cannot be NULL
   cocci.log:59:./spacc_interrupt.c:117:1-7: preceding lock on line 97
(false positive)


Also I do the W=3D1 warning checks with my .config on gcc and clang

COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-13.2.0
~/lkp-tests/kbuild/make.cross W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix
-D__CHECK_ENDIAN__ -fmax-errors=3Dunlimited -fmax-warnings=3Dunlimited'
O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash drivers/crypto/dwc-spacc/

COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-14.1.0
~/lkp-tests/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Darm64
SHELL=3D/bin/bash drivers/crypto/

COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-17
~/lkp-tests/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Darm64
drivers/crypto/dwc-spacc

Warm regards,
PK




On Tue, Jun 3, 2025 at 5:37=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/06/2025 14:02, Pavitrakumar Managutte wrote:
>
> >> Please run standard kernel tools for static analysis, like coccinelle,
> >> smatch and sparse, and fix reported warnings. Also please check for
> >> warnings when building with W=3D1 for gcc and clang. Most of these
> >> commands (checks or W=3D1 build) can build specific targets, like some
> >> directory, to narrow the scope to only your code. The code here looks
> >> like it needs a fix. Feel free to get in touch if the warning is not c=
lear.
> >>
> Confirm that you understood this. You sent us code with obvious flaws
> which would be found with tools. It's a proof you did not run these
> static tools. It's not the job of community reviewers to replace the
> tools. Using us instead of tools is... well, a mistake but if you think
> about our limited time then kind of close to inappropriate request. So
> did you understand the need of using tools BEFORE you post it?
>
> Best regards,
> Krzysztof

