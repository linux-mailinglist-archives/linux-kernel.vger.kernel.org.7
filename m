Return-Path: <linux-kernel+bounces-877546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7E2C1E661
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA91F4E3729
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6930CD8D;
	Thu, 30 Oct 2025 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGFn7QQS"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BEB3081CB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801257; cv=none; b=gHkppJ1EqxatrPelKLTMP9AmyEz/4XLFd++/WJWGNs5b8D4rXPg697fQxH/YCwMzKscE5cRUamF3NdELdpH7D61RjPdoCyxY+38nSZGy1g05PpIHnXQzZVJitpySJxGUBNh9zwvYzuETxLHXP2WMZdHSRt8p0Zn085RYpwaZ8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801257; c=relaxed/simple;
	bh=T9QHSB+KZkLl9uHgRXc5ETf3HFmGTKOuyoZXK7i7tR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSonxRJy6sGRNrSoB0+42oefAvq5Q4+V+P8d7PkTcEvfc3GdZQlVX1DMwPmK5XXjkTnyyRsP48iKRKKzRGraUbgtm66prWXDQhVdPh44PSr/7F+Ck3aoalPOjQylQNPhrFUkvX9hH/vNTuwxDI+jHIlwubxjSzetKDcaMzm7Sjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGFn7QQS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so1225131a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761801254; x=1762406054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tq0yxGv6yRvwde5HLaH1HkY7PXCLMaOxQayqcCSGMU=;
        b=eGFn7QQSkw44XxcgW/Ly0VCFciycqennQ+atdW4fBXjZ1cZ9cdRDeY7Oz/Gn4gp8v3
         /vRAqqxqyiNmzyjDhwAkW4C92sd7ykz/+f32KhZipOM3HATm2jUIFj7ejVYnkmDvmc80
         l+A4Af+xRkIFg8nAFh46Ql1ZwWvmU++Szxnioa6fChxC5UvsonCd5+45dVuE3lwpNFFs
         goW3UrOAKf1Zrv/21FjXX4QWMuOsYe9PK1lGzb3B1NVo0yXklwkg/Q1wTHSjMEDKAUcn
         L/jqp7Gy0/aKe3GBuoTpDYPs5zOo8ZIUqOQdTXy6eXSbuA22XmgqG3Z4paE5Upg95KHT
         3x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761801254; x=1762406054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tq0yxGv6yRvwde5HLaH1HkY7PXCLMaOxQayqcCSGMU=;
        b=taKESEBkVvqkKXBAr7zmsICf3o1hvQ/6jjt+eISOXT8XlYH8ojn6TvpfCt3UJg/G64
         TtnbiXDpHntU9y0Mxc1egOrJW+KcBlKrfY9cJ6TvDtxGeZzanwP3IbvL1AUXKBHWAyzA
         lJRJjVW56uDqkLMoMqMg2uPcUbQQ23m0F2B5NQjMUoLAnkGOGnRDIQGXt5qnEyeLxlb1
         CCixNYnd4zsGXhyamwkKSa6V6TOjBCpTl+tNZicoXDghRoimVqIzAKerz/BdoJ+OKjxt
         k5E35TndAyUuMFdfhOfpE9TMExc8WuBuueDaTAlipOOyEEg8zFBmwrZpes6qNid8nblA
         mNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8l0v1VbVvmowNLgTyi/I+8PnJCrG8o+1ohNiTTun0VcD5iSE7bZM1h8BdaMWD+OJXPBLfMhxQDCR6vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Cq4OJzDt0Lnuac87ghNsIa6LmmgoZWTGJ2Ul0JN2sOQUJoGT
	U6n1J2mzjkeuq0CHy8JmgCr1Pz+hZwp5a2g2kDgE7V5uKyISbCcy/R++/2qha+XNyNM9xuFvNeQ
	4Cvcw/afNMsb1jaP3lxGtlR9alNbBLTE=
X-Gm-Gg: ASbGncvHdVSpJTpPLaf77dcZSz+RPSyKErBhUMAEyWqOrqcHZHiighOt3zANp7YioIz
	tR3sj5jKzxTZldsEWGIy2xDdd5Yl9Pyp/wJpBFJ4lFNjE85OgADy5h4J3Ym51Bmvi5G9Nfy3lU3
	HMjXhVj16QQBksE5Bglr2QmASwKQgouhPKPBer2/cUYjDE0oHIjE6ZyBbq8gQL7MIXMsnjxrdx8
	6bKQh/rAyTTnCyo+jhvn66D2XM9CBKFLD1+R9JZNgSU36aHcSnulGvpnr4=
X-Google-Smtp-Source: AGHT+IFDCMfSXrIL3bjIKZw2IhpHFG1U5RsQXDbZl1lPFfpuAvA594DxUOaln1JvXCqNQSfMK0dolS63NIEWPJif8rE=
X-Received: by 2002:a05:6402:50c8:b0:63b:f3a9:f5f1 with SMTP id
 4fb4d7f45d1cf-640441c2092mr4444447a12.14.1761801254315; Wed, 29 Oct 2025
 22:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028154229.6774-1-linux.amoon@gmail.com> <24319a9a-ccf8-48a9-8b5d-3a846976afcd@web.de>
In-Reply-To: <24319a9a-ccf8-48a9-8b5d-3a846976afcd@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 30 Oct 2025 10:43:56 +0530
X-Gm-Features: AWmQ_bl9cBL27Bidm95xNfiwXFieCJ3byhHw0tTbL2X_4Wmj8VImOI2xhqIIeMc
Message-ID: <CANAwSgTO2s8LA=e5CVYnpJ95_DLdkiot5Zbz1hFaejV=kTK2_w@mail.gmail.com>
Subject: Re: [PATCH v? 0/2] PCI: j721e: A couple of cleanups
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,


On Wed, 29 Oct 2025 at 01:21, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> =E2=80=A6> Changes
> > v4  : Improve the commit message.
>
> Would an other version number be more appropriate for the subject prefixe=
s
> of this patch series?
>
Yes, if there are some more review comments on these patches,
Or they get lost in emails.
>
> =E2=80=A6> v1:
> =E2=80=A6>    dropped unsesary clk_disable_unprepare as its handle by
> =E2=80=A6
>
>              unnecessary?
>
> Regards,
> Markus
>
Thanks
-Anand

