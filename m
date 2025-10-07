Return-Path: <linux-kernel+bounces-844672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC2BC2767
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B407C4E1C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B091A2EA168;
	Tue,  7 Oct 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xou55lvU"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716802E9EA9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863515; cv=none; b=Yyr8v9XYzbtT321HmnaKegTK9EuSIYA2exFFU8XU6RdSpz0LZ0ElBfZbZIr9Ip3GNed7jd+Cx5bNahqt0SgBJ87Iqf9Yrriufp83MD1Sc9hDjXF91//f3uZDsJAnmH/Qf1i1YsPfRVf7Ueh2p2kd1L3Qq7rj8hzSfZzbBKQ3T+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863515; c=relaxed/simple;
	bh=ahcETK3NScioEM1VPhg+9e8EKulpHqG+JDuHQMq1GKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPDI23IjpNVH27AfX1SOb0O650O3jlilZYLyUdeOjVluA9LpoI+2B55Iub1WD+LTplEhjw4ZPaCnOzculvrsT9i4lUsnV1TLEWsKh6NbHCstv3iGrKwFCQc8XGs6p4j61kcoLaE/ez/hqP/QWkh+eQwMKxqC19bYNXSiRnZTGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xou55lvU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78f30dac856so62432826d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759863512; x=1760468312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE/QqWs7NstXUoklYPWJg7vwj5OuQDSlnmUz+8GLmcA=;
        b=Xou55lvU7yKg6wYp1HLs0ETTJHGKfErOS4umkH05nUe+M5vSARPFzx2SLSmXaoRJWf
         f3MFDmKi8wTSSP85kwf4/i+HCcp5o6c97lNRrbrgHqGkj7IOi/Ce5gXgN4II6goyuWTY
         mbKkW1z7RxG9EmMv/glL89PBYuqOvo8WlIGGupMOqVMpwEaGX4m80XSXIXOA+i5IUpue
         CVi0LhCeSBVU3gFD4/hBmqId6rv1tod8U7loXa72p6qIMgwvyjOptj3B0K5DrpOlk3Uw
         QKQt4ErH256tdzBWpNCdQ7QlDLyRs9G0RijO6hH+XmRoDnVJYxSdMM6oQbIYFiABauj+
         mnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863512; x=1760468312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE/QqWs7NstXUoklYPWJg7vwj5OuQDSlnmUz+8GLmcA=;
        b=H47Owbw8nenW+akXSEDzLA6rGm+yocOkxg7oTEp44itXqU5NmTHJkwqyXcWJ48I49Y
         ei1B68WOpHzsxFllAW8rgzIA80HkZX9OAXljQPiDb1WG5X30qyY9ft5JiXEOPW8VSnjz
         iPC1k65QsUe8JEqD9hm2kh1+pQG09i8clY7P8t/Z0720RQGpujOszbjMNQ52FfVTNJOH
         Vb+eWa/pmEql+DzyD5KjudxilzsH4d6pTNsrn9YKCF44z6fmFNRX6eTciCrRh7UeYhOw
         WQKmdDMPMlvwTbVXRiVGnhkJCj5laQxiUpXj5t2EHylZf6JXr/W2/F7u4pyAcRqiL52M
         i2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/n2IYlWFnD7xR+etK8jjHfd6nQ59DXD37fkqHJYCUkjM4aJM+EsQIV3F60rtZDyZPpkXGqmNGok8YORo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapWF8u9hwS1Db2bKLEbW6SG2P9eXHmbbbtLTHX/5pwlaebKM5
	mPL5hEzkUg3aQ04mr3SodwJAl8kDLBst4r4Tk4iXBfHJq3csOSZJU3XjC53VtU+U9ywhzFNtkAi
	5jbaiR6CQ0bWCGGY+g0Qbde+kLjZF6lOw7VInHOkw
X-Gm-Gg: ASbGncsVMzIiGFC48s3wBT/7AJILfRKI1ZtAYXLmxqMOBqy+rYX3nftl2R4tg4SnU9I
	k2Hnbj8KX7ubx38jA66waJbWBsT1wmKQrvGzoqnYyVBP6SshHHQM5n96b05VnFluwCcJiFJyhaU
	vPUGUkcWuiTt6+CMILTamCs2vLQgnLW0IoE9+Wi1fPsN1RH35vsStnyD1zV6oEb6RdRiTohSgqT
	6DS3MFO+1b/nfLd56YMHegWAszefiIuAWF1hmBibx2GrFjMMb1xC5MAeF67hYJJivusGMK1+zbJ
	Mvc=
X-Google-Smtp-Source: AGHT+IFJCSvibVVpHo9SVA1MQuL2njqF7Hz3TZEHv6SusAWE3ZVPz/ickNfrrHhzv+YbaQGGtkgTfVD3qAa0FKJd9d4=
X-Received: by 2002:a05:6214:21a1:b0:786:5ae7:7846 with SMTP id
 6a1803df08f44-87b2efb9e09mr7131866d6.32.1759863511911; Tue, 07 Oct 2025
 11:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006232125.1833979-1-royluo@google.com> <20251006232125.1833979-4-royluo@google.com>
 <2025100735-gulf-error-2ce2@gregkh>
In-Reply-To: <2025100735-gulf-error-2ce2@gregkh>
From: Roy Luo <royluo@google.com>
Date: Tue, 7 Oct 2025 11:57:55 -0700
X-Gm-Features: AS18NWCmw4sozhJ6PiheC0IEychcx5yjcq3OEgXWnrhYT0U6wZ0e0y1txxXckvE
Message-ID: <CA+zupgz-RQ=vNCBTy5yaaP9xJFpeFw+xLJYuvtjct6iuh6zD2g@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] usb: dwc3: Add Google SoC USB PHY driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:51=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 06, 2025 at 11:21:24PM +0000, Roy Luo wrote:
> > Support the USB PHY found on Google Tensor SoCs.
>
> That's great, but that's not what your subject line says (it says "usb:
> dwc3")

Will change the title prefix to phy in the next patchset.

>
> > This particular USB PHY supports both high-speed and super-speed
> > operations, and is paired with the SNPS DWC3 controller that's also
> > integrated on the SoCs.
> > This initial patch specifically adds functionality for high-speed.
> >
> > Co-developed-by: Joy Chakraborty <joychakr@google.com>
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > Co-developed-by: Naveen Kumar <mnkumar@google.com>
> > Signed-off-by: Naveen Kumar <mnkumar@google.com>
> > Signed-off-by: Roy Luo <royluo@google.com>
> > ---
> >  drivers/phy/Kconfig                 |   1 +
> >  drivers/phy/Makefile                |   1 +
> >  drivers/phy/google/Kconfig          |  15 ++
> >  drivers/phy/google/Makefile         |   2 +
> >  drivers/phy/google/phy-google-usb.c | 286 ++++++++++++++++++++++++++++
>
> And as others said, you don't need a whole new directory for one single
> .c file.
>
> thanks,
>
> greg k-h

The USB phy on Google Tensor G5 is no longer based on Samsung/Exynos
IP, hence we need a new driver for it.
Acknowledge that we don't need a new directory just for one file, will move
it to the drivers/phy directory in the next patchset.

Thanks,
Roy Luo

