Return-Path: <linux-kernel+bounces-874319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74819C16048
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 137DC4EB7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E828FFFB;
	Tue, 28 Oct 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQADYmtS"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E06276038
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670849; cv=none; b=k7ZmT/b0rhfwHV5fHE6GSOEjONImEBonBBEryVogy/skBgAueiO1czRK8dhEcTB5KmtoFL8agYHdFFWDzKoVnwdUnj1JxXSTLaQe0baWLSZr3o9HOzRnAPDcZm5LoagPEZaSdW4IeLSs5w6PyUgplm0V/mnWU29vrgaOjtFTFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670849; c=relaxed/simple;
	bh=bpUk9F39KUAATEaB039lzBYbcAFRUIrSvmGDpez1vQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5iVOADYcOCFLndVX6QAdcK8C5KXtvsCl0QEhcAdRXeVBe4m3bUVEc2nbi5Xd4hGlzbPZzkClcSbN+ZdF+xH/6el90m8+wfQJqA+hCWqp8+xv6TrN2zApItWC994K7M5qyd7pNqSasNOHI8HdY3mTp7saqP4mvXwDbtB9zXLJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQADYmtS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so11804048a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670846; x=1762275646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOzc7xIWO2p+WR3VIGi7nTgvTnzL1L1uYDvVNto7C1I=;
        b=AQADYmtSjOCbALT9FWQo3AUc55GYkNyiv8gNnTqbnlJOGhO+biyimzpgceekt2XZ9T
         JOOxA+nNQwFK/wRLMOgxMUh3qy+u1s2PWwSW5ATMi3e9WhZpD/obEgpcRvO1Uk+9lQKW
         XyNVhbIxNCANLSzILBhBD08XOYDi7IaO1TxJpjxgeVaiuydqTVSxhmZaeVgqVDVRengq
         wJLDMIlvp2S0dw8Bt8sjUV192kUfbItj4Ui5ASvStmJ3WsXkSnCn8q1lOlmeGPGfhKp8
         hASj/jyv1BobiKyUp9mJJEy2krpX04FAI/YHbxwgSFKXo+cYabHylqTfWnPdz7rueP9w
         /rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670846; x=1762275646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOzc7xIWO2p+WR3VIGi7nTgvTnzL1L1uYDvVNto7C1I=;
        b=RyIJRKANfM1sujwFTf7kOH8w8mFNL0UVD3sOQ05kAShlEUvypc4YNQBTJSOoHLHfGt
         amI3beLuA1ylePrnE7ZEJExPEL1mGWqORkcoPJshITXCteMfjn1bQIfumKiLkcDQSe41
         uRW9wFm1YDSP7fiqb+qNMU5s9+xRpgpmiAblCPCp94ZidjvRmc8lLLex2Mnkz2ji8HZY
         g1GfCb2hLanMjDvvPENhi0xoj1GwpjqvmC6J8KvMkuq6321N99229wAFi0HJb3wDKqwO
         exu+0oI2uUK6ePd3hvRYUJoH7JyU32XhTQOBHOudMyQKXF+ktfWxFvTU1KnHkRo/onmC
         1OrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGujj1ROlP91PAWgy0pnDzCMZdDyHsolKiWLbJUNm641NxDr5Q7hSUbbZ+q8gqwQpd1idrBNPbu5gdyvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VdEkTWxZFAeK4pY42DjF2BB2e62/mYCF5PNvZCQXyxHw7KqF
	NrdxaXiRZLgmvlQzIpdjuI/ovq00TIxFFaCDhjvgnM43xyAVWBycNRQwT4H/9vsB2pCK6Z17WUs
	EA/K8SbCEoBOVvMhU9Y0icKn0GrG6buk=
X-Gm-Gg: ASbGncu+Y22hMWEjRPhtaCt4o1JpFrgafs7kF5RFSEdMuN/qI/O6xgSttSjc5+OwF0L
	olCFwYtqpBTBEE+3d/jfPbRnD6y/fup7veeiftdvqmHLI/GkaEtxfv0+dhcT82SEMH9yfUlkuWv
	h8/gUmjwJq2bqeGvfAtY1TMcNsghzTDjmpgvXHk+in/WiYbMiPr8cpsd9YZh44vQdP2QLGZHJUZ
	NRGwiERBj99tRV5n6aHHwSLd/2IG9VxbP9MeVekps5y7nKDK9jQWx6AlK12pHJ87r8V5Q==
X-Google-Smtp-Source: AGHT+IG4YfmqHGe2pINyHg2K6LgJOKPpNmL7zajrt/SLmYhcYlyZRe1+iAEJYBHgTq7bsXU1Dyysoqylc7EnkaBl0VA=
X-Received: by 2002:a05:6402:d0b:b0:62f:337b:beed with SMTP id
 4fb4d7f45d1cf-63ed84b5cd2mr3624305a12.30.1761670845665; Tue, 28 Oct 2025
 10:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028154229.6774-1-linux.amoon@gmail.com>
In-Reply-To: <20251028154229.6774-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 28 Oct 2025 22:30:28 +0530
X-Gm-Features: AWmQ_bnnegLAH410rfGGE5Iq-GfVFIwFAd46rVhhltc96obVUpLwKbSOptU59bY
Message-ID: <CANAwSgTZOK9tdfQgVn6kZsxd6KdEuPn8ZH5-yrLqS4Np295dXw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] PCI: j721e: A couple of cleanups
To: Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Tue, 28 Oct 2025 at 21:12, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Refactor the J721e probe function to use devres helpers for resource
> management. This replaces manual clock handling with
> devm_clk_get_optional_enabled() and assigns the reset GPIO directly
> to the struct members, eliminating unnecessary local variables.
>
> These patches have been compile-tested only, as I do not have access
> to the hardware for runtime verification.
>
These changes are v4 revision. This got messed up in the format output folder
Sorry for the inconvenience.

Thanks
-Anand
> v3  : https://lore.kernel.org/all/20251027090310.38999-1-linux.amoon@gmail.com/
> v2  : https://lore.kernel.org/all/20251025074336.26743-1-linux.amoon@gmail.com/
> v1  : https://lore.kernel.org/all/20251014113234.44418-1-linux.amoon@gmail.com/
> RFC : https://lore.kernel.org/all/20251013101727.129260-1-linux.amoon@gmail.com/
>
> Changes
> v4  : Improve the commit message.
>
> v2  Drop the dev_err_probe return patch.
>     Fix small issue address issue by Dan and Markus.
> v1:
>    Add new patch for dev_err_probe return.
>    dropped unsesary clk_disable_unprepare as its handle by
>    devm_clk_get_optional_enabled.
>
> Thanks
> -Anand
>
> Anand Moon (2):
>   PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
>   PCI: j721e: Use inline reset GPIO assignment and drop local variable
>
>  drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++--------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
>
>
> base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
> --
> 2.50.1
>

