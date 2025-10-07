Return-Path: <linux-kernel+bounces-844596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886FBC2510
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17DA14E2FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0FB20C461;
	Tue,  7 Oct 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDGW7iSt"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880301662E7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860233; cv=none; b=dSRVfaf3i+OpV1ATReHxEz+jEQFpiQPDm298PqVL0HGP20v7OZWasjMn755T//4vZijyR0q+YVIJibKwiu3LGf0NJDCfPvYg+0/vhSpP1qAmCVCBlFJorNcwScTpxi9UfbDUSfBVoghen9Ip+096qC+RfHvbBJo6NMQWDWlvtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860233; c=relaxed/simple;
	bh=NHEmrtJIgEleCWQcevq6nqZY7xNB77jO7eLNYiB6sEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MS8F59hhKw8VVq/Vos9MANexBoO8NN1eJp+96KPtNDeWOfezYPRkdRoLBZ81Ca3NRdQZNlulvjq/EW3gf7YB0m9w5x/DKzlR9Xql7PJPCTDQtFw9EWHRugIcqZbt7eRcqJoZttdpK1I0jxlUonM4ZJsp90heibQ8INHeKfpMJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDGW7iSt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so6167964b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759860232; x=1760465032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoeUTdyH6Ho2hK/WV0Pq7ReoILwQzxKPA2QdB9ZFVa0=;
        b=YDGW7iStLghTCfJ7+MCFpdhgAbzOjwWdGzzI4+L/86ppjDjIEg1yv6gMYK7LVKlQyQ
         A62FUxwi7lyqLo86FJjSoCt4Cxl4tlO0fCBif7yXNu8b81yfL6+NpNlMBvDELrOz4KVD
         Mp4yh4bsPfcGIXLH+lA7B/v9L+KcJsb0YxXnrsQuPpXPe7MF7chjW77QqwsBWQENainV
         SJ7yKYtzDCRymEeRt44ed1JSClqUNeFjqaFZkerPO885JnyLV+4lo/2X9BHI3g2q8V4F
         wm5F1GT8MSgfQGG8KePscMiHadq35L2g5kGW3vkcIM9+NuZVdcIgraWFc+UXAqJzXYQe
         4OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860232; x=1760465032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoeUTdyH6Ho2hK/WV0Pq7ReoILwQzxKPA2QdB9ZFVa0=;
        b=lpiITWsHI0fKQZJAbIk3IxFdUqnEy6lwwyjPy5iOoukTLGGtp9z8Hr0Woj9uGRdouJ
         XiauXSSf69fO2qrFx6SiZ3lqLnUmcK9+eUIEt8lqNfXoVMOYgMqIpNQPHsB49aLgQeSW
         FpmwT49PGRCe/TuKym/wlu9La48PfOrZpx/ryV7de13c6M1buSPTBw5duVnos5f94VTn
         rQZC3udkUBoTiGaWXVIQ4xlHZuEoeA8KySUHRSclxibb2gfiOBJapEPfb7tXxGSXcjbZ
         NLg4LMPVMCdzlNwU2lubU6txBRUVSUKt3bKHa9ONKcn0n9WaPnhL5boRNVQZgUDZof/R
         57cg==
X-Forwarded-Encrypted: i=1; AJvYcCVEm8ZH6K5lM2fHR5LcOUVEwM/wvIV4hwagHE8R6+Zew3S1Q/RD9v2Dnf0N5G+GShfNAk8MyhB3MNZmoME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71vgtl2XwP2HFMmKDTLSzz+6PtI3w8EjXBzm2yOMtpWm+laBV
	T37mo0CgN/NfxCVU4WifpD2aO/uwi3aK68Vse0z3ObHWc7KgtrN3ujWi+Dq6td2SD+juVZCxTj3
	l4NrEdn/T+LNido80ltrU9gqrwNfpF6JAOmpdZjjg
X-Gm-Gg: ASbGncvsKJA7xzYHHf6jGjbx0G0ZvqnYZVzrDkV3ndck1NY0oMRMR5ynsUcegWeXxgX
	C18mEpszehT2N++VR2Ryf7rbMq0QVcx4JBl77bQD0vdY/M5j8Jsde3bHPGathFqv0jZgdnrSPpR
	Ca4UNt2q2fyTm5wcHrhFUZAX6QXNywnp35TAoirPNkKNUbxR7CsFm46Tn1r+ICa6ckmAeaceFRB
	CnX43nNzwkSv+W2Cptv17y/y3J/jipf2sTDuXk1cmx52iFCRNEJnl2WsbYYkI0Ga0CwOF9g6N7o
	KQb9zOm2pfdE7A==
X-Google-Smtp-Source: AGHT+IErqs+kJVv5rsWGTN2Z0xZ0ickiFqF1IQ4SpRF/lYWHEWgJPEacLea7fTefk87mdvoXJ1AdDn7lRgB9V20xPD0=
X-Received: by 2002:a17:902:d58d:b0:266:cb8c:523 with SMTP id
 d9443c01a7336-290273ffe89mr5647285ad.48.1759860231518; Tue, 07 Oct 2025
 11:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006232125.1833979-1-royluo@google.com> <36068ca3-912e-4e71-b688-8689ead8194b@kernel.org>
In-Reply-To: <36068ca3-912e-4e71-b688-8689ead8194b@kernel.org>
From: Roy Luo <royluo@google.com>
Date: Tue, 7 Oct 2025 11:03:15 -0700
X-Gm-Features: AS18NWA8U90B63ffP5jXdkUD5e6eOAqItmxz5SXEaQputDmKkvJD4mEmS6I0ARg
Message-ID: <CA+zupgyLx8q23b-ecrLhYAU27HV_ZFMiH9XR81Q2MKRmMwpcNw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Add Google Tensor SoC USB support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 6:06=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 07/10/2025 08:21, Roy Luo wrote:
> > This series introduces support for the USB controller and PHY found on
> > Google Tensor SoCs (G5 and newer). This includes:
> >
> > 1.  DWC3 Glue Driver: A new glue layer for the Synopsys DesignWare USB =
3.0
> >     controller (DWC3) as integrated into Google Tensor SoCs, including
> >     hibernation support.
> > 2.  DWC3 DT Bindings: Device Tree binding documentation for the Google
> >     Tensor SoC DWC3 controller.
> > 3.  USB PHY Driver: A new driver for the Google Tensor SoC USB PHY,
> >     initially supporting high-speed operations.
> > 4.  USB PHY DT Bindings: Device Tree binding documentation for the Goog=
le
> >     Tensor SoC USB PHY.
>
> This is useless message in the cover letter. We see what patches do from
> the patches.
>
> What you are supposed to explain here and in the bindings patches, is
> why we want this driver and what is Tensor SoC, considering we already
> have one Tensor SoC... IOW, explain everything which is not obvious -
> and duplicating SoCs with some generic name is for sure not obvious.
>
> Best regards,
> Krzysztof

Thanks for the review. Will remove the redundant info and ensure the next
cover letter provides the necessary context on the Google Tensor G5 SoC
this series intends to support.

Regards,
Roy Luo

