Return-Path: <linux-kernel+bounces-835567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5518BA7792
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A23CA4E05FA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F827F4CE;
	Sun, 28 Sep 2025 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+2t5RUg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAA27EFE7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759091034; cv=none; b=pipkesVlchL3NLYqYSfjvIuEK7WCuDSA6JFRFicWBcDa+cPHZzCABP47+Ws9Z6UDVgkrGl14QVMy2sydFTI2Xh7e5sV3hNVUtnR5y2LXw55+TGJSxKD1//1hQWMMI5ODEEEDA/lcsdhczdHyX5OX0SQLITBojMZnU72bQrUs2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759091034; c=relaxed/simple;
	bh=f0KbGPF00kZzNzX882R/gqRn05yNZLkgA/Ha1ipTTiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RArH6Cgt7YT/nuy1hoW7tBfKFXu7dtvryD2dbNazIb8zDGnQLbjI01gpDS7E1NJ/hXNCREyqFKlHtTd9PeVQi7yHzRdpUPVBz5+SGIdJVLuBIFTzSYyxMtzkkymuYry+wsyOYhwLtNDJ5PL3xPpwT/0KoLuwPNZ1B8XYnrBVdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+2t5RUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D289C19425
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759091034;
	bh=f0KbGPF00kZzNzX882R/gqRn05yNZLkgA/Ha1ipTTiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R+2t5RUgotK+O5B/9A9YIogztwNESvf0W363S+UgXHbDl1ck0fvV3GcsLQ8gtsuIw
	 aS4AngeHx6FSaxB3OPOKXhFu2RCJag9jvS/ThypK3OXnDw5UohS6Iqrp0DqKHrHDZm
	 0rwAH2WWsEfuersMEGVi1mcvu8XJ63L2Q/jcpnuiSEDA3lAXDPrsfYKLeYyYdW+g5v
	 TZ8U0YBwYN1Ai3SAnBTTKqgwpV2NTuSRTulONTcQ2QLRV+vbvSOXzk/M9V04bx5SGD
	 rqOXZPfneL3+33RDBwg+stRErELMlXUHLQgVRV5AX1Y7C/3sYu2O/qdbiochfGQbvZ
	 ieY6Mkw7IDEiA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e25a4bfd5so82231466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:23:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlqlWM0t9qUaKAmqAh1MfjY2cUDgCsU2vg9e47eo2Kib60z1H6+P8iwZHVi+sJTZAHaA3ha1uLTmefncA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVK/W1W4LOVFUqmLUH7X8Xn08kc4QA8YgGKqsBr7PIeE0wuI0r
	mwX0DjQgLX+00xgUwz98wW+Lj6A0e+DmPXTxxww8604gykauVpSn8iCMTGcfF56t/B4/pdaE/Vq
	klQnnesrn6jzWlzqf/MonNKlj6B5ZHA==
X-Google-Smtp-Source: AGHT+IGljkA1Fha+nY81qrIVwl5aGRrhj/Ww61c1Va1R3cSc0Qwgx1hOVjVnCVYAJOUI9Ne0SY3WAcvwrWIE4YCtKW4=
X-Received: by 2002:a17:907:97c7:b0:b3d:e9be:7ac2 with SMTP id
 a640c23a62f3a-b3de9be7bf9mr214954366b.5.1759091032783; Sun, 28 Sep 2025
 13:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928171718.436440-1-charan.kalla@oss.qualcomm.com>
In-Reply-To: <20250928171718.436440-1-charan.kalla@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Sun, 28 Sep 2025 15:23:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK9waZK=i+ov0jV-PonWSfddwHvE94Q+pks4zAEtKc+yg@mail.gmail.com>
X-Gm-Features: AS18NWB9iYb53BkxRxGbaDbf_ZYxtXe5ZBA-hIIueyfkPaVxGM2QNyJN-EWNlNw
Message-ID: <CAL_JsqK9waZK=i+ov0jV-PonWSfddwHvE94Q+pks4zAEtKc+yg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	saravanak@google.com, conor+dt@kernel.org, mchehab@kernel.org, bod@kernel.org, 
	krzk+dt@kernel.org, abhinav.kumar@linux.dev, vikash.garodia@oss.qualcomm.com, 
	dikshita.agarwal@oss.qualcomm.com, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 12:17=E2=80=AFPM Charan Teja Kalla
<charan.kalla@oss.qualcomm.com> wrote:
>
> This series introduces a new iommu property called iommu-map-masked(may
> be there is a better name), which is used to represent the IOMMU
> specifier pairs for each function of a __multi-functional platform
> device__, where each function can emit unique master id(s) that can be
> associated with individual translation context.
>
> Currently, the iommu configuration - at least for arm architecture-
> requires all the functions of a platform device will be represented
> under single dt node thus endup in using only a single translation
> context.
>
> A simple solution to associate individual translation context for each
> function of a device can be through creating per function child nodes in
> the device tree, but dt is only to just represent the soc layout to
> linux kernel.
>
> Supporting such cases requires a new iommu property called,
> iommu-map-masked(taking cue from iommu-map for pci devices) and syntax
> is:
>    iommu-map-masked =3D <FUNCTION_ID1 &iommu ID1 MASK1>,
>                       <FUNCTION_ID2 &iommu ID2 MASK2>;
> NOTE: As an RFC, it is considered that this property always expects 4
> cells.
>
> During the probe phase of the driver for a multi-functional device
> behind an IOMMU, a child device is instantiated for each FUNCTION_ID.
> The call to of_dma_configure_id() on each child sets up the IOMMU
> configuration, ensuring that each function of the device is associated
> with a distinct translation context.
>
> This property can also be used in association with 'iommus=3D' when dt
> bindings requires the presence of 'iommus=3D', example[2]. For these
> cases, representation will be(on arm64):
>    iommus =3D <&iommu sid mask>; //for default function.
>    iommu-map-masked =3D <FUNCTION_ID &iommu sid mask>;//additional
> function.

Where does the FUNCTION_ID value come from?

Why can't you just have multiple "iommus" entries where the index
defines the default and any FUNCTION_ID entries? What's in each index
is specific to the device.

Rob

