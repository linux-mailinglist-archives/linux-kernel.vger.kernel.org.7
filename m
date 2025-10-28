Return-Path: <linux-kernel+bounces-873153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A35C133EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1B424F9D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08592BE652;
	Tue, 28 Oct 2025 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzwFJfSV"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8592C08A8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635220; cv=none; b=A2rEGNpYgWYQvpob6yrsHiQQJ1QoXinFpqdxjWn47JRBLRuuHjZU1EsX4aPu2mufH581X0A8mzBZnGqbIO8bYQgQc1pbJh498G3MmhcfFeIpaJZ8EKe/cKQaehEBkgfVdJ/ndUn6rjS32rZ9hcZTC7/jrWITlKX3kFXECjf0b7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635220; c=relaxed/simple;
	bh=R5PmlZtWzHHZKGgXjshm44Mpf/Tt3lSzAseSYL5jpRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLFOIRWw4bPyEQbSZUE+wdzW/+BIOsY/4v4Oy+E8gcXW/q13C1roRHcc3YwvADUXRWhjczNnRWvMM1qhqRRlyrALwg13lZI/j7k2MFvSNwM/eo7h4h9HVXzmF1AeYs7MQOFOSEnlk05iufBdxeKGAZk5pVovkFEqaYrDDufNhrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzwFJfSV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso8561166a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761635217; x=1762240017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R5PmlZtWzHHZKGgXjshm44Mpf/Tt3lSzAseSYL5jpRs=;
        b=kzwFJfSVlUIRSBkvPFV9cszKPEb5MmzumJf8w0+XB3pXNnxZv/a41B52lnt0FtfbyN
         F0jiWYoilHFD+EALeQxuTk9V1f8EpBHo0zbFKa4wuhUJ7sBjffc5ifCcXzuAq7K+eBlL
         CSjIQD+pKxpQimtjkX6h76APknIU7CohXlMemLCNc589+VSIAigrnVCtfRWopcSvSwBK
         skiPnUu5I+OvjuRuc4jNBjIWraXPw6UNpSnAXjpH+ze4mWrGFMP1F2wAWpGonz31Xhv8
         lGtwpyiBo63SfG5W2QAKj388T5jKkfbnqSXlIemloVX/us5My5X5u4+vFw7kwhYMNJMa
         BzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761635217; x=1762240017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5PmlZtWzHHZKGgXjshm44Mpf/Tt3lSzAseSYL5jpRs=;
        b=PRXs+s9rajo58Y0GbADpmRtKVp/GwAZko0HDsh/VXvNuKXJ6dK+kYFOxvwMgXexoOO
         6OPgAggPjlgf4URSvdNS9UACyTlyGDLi23BidMBkjyGPoemaTAjoTMyVoQdPC9FL4zt6
         NoQLjWkhel3X9oNi0ZGcpG+KTUo0J+IqyzfRadJa0fyI6+7UqKKIx2fvxQJ6WKG2DSO7
         k2UkYOFCRt0JhmPLMbzW7xKywNv3HTJMG5xCpeSFMY6WZvSAA+ue/fCLCx7fu4WU/a3y
         zHiNuJSLnCvCSH3sohhjWbRgO8qwWwk3a6BSTVF9uo2EwLcFb/qykrY0q3mS+hx9Lbra
         NBaA==
X-Forwarded-Encrypted: i=1; AJvYcCVVYP0nSY8Pq2jh1bfjTKVMyG9rdzOmrwRLdnq23LiBoDJlhNBC1WHOK1mXl5N4RYGpCDP5mN0R6Hi26Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdpX1mUN+NBUq9KJ3Keul/AdRvck6MN6WR2Eo6hpc0KERZih8
	bZAZbiQdkPBic4vougV9kGJpju8pgGYCSL0tlctT5PmTgqjdLIJngRhQ9o2RUvHcG557f9dhzUb
	0s7VcSiqwT8Nn1/YFcCidPybiBOIHWQWWWF4r
X-Gm-Gg: ASbGnctz/l+nZozR4yPT91jzM673YeMEiSayAEp4Q54fJ6IlIPe5AQK6b6eTUWNziIU
	+cCJk+y67O9uZqtuJgP01FWl3LOEIoc5s9QyHkYc0J2lURy4uEQUbpkSisTZC3TPbtA//BIx34g
	mm/Q8jb/IIR3XC84uxLl6g2xeC3xaucfkYyld85P7I77zZKSA96Er1NY45KPDdOTz3FOWBp4Jl0
	nc70YnPGNOoVuh7Nm8mYdjAf99G0uHJE16FINz4naTmacf7HGGxzVRLFo8=
X-Google-Smtp-Source: AGHT+IFqdZ7449/+gCSESKkn4OY2k6KiWRXks4E+V02E2uPaH6yPU4wF8iJFvFXAm8oiIsJdQKeuKoRJ7jR1cSg+eCI=
X-Received: by 2002:a05:6402:5208:b0:63c:45da:2878 with SMTP id
 4fb4d7f45d1cf-63ed8262ceemr2111325a12.25.1761635216475; Tue, 28 Oct 2025
 00:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027090310.38999-1-linux.amoon@gmail.com> <20251027090310.38999-3-linux.amoon@gmail.com>
 <f36a77b1-79ce-4bd4-ba4a-b9260bae7f11@web.de>
In-Reply-To: <f36a77b1-79ce-4bd4-ba4a-b9260bae7f11@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 28 Oct 2025 12:36:39 +0530
X-Gm-Features: AWmQ_bnM6F6BzTGQqX_h0Uqm5Thyd0JbiSKKhO1nlm1lVvxcnt-IMVp2PL8CDLw
Message-ID: <CANAwSgT43rsi+DxaMF3T-gsVoAAGSSDEL6s+TE2yZ+q+W3bRsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: j721e: Use inline reset GPIO assignment and
 drop local variable
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

Thanks for your review comments.

On Mon, 27 Oct 2025 at 19:13, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > The result of devm_gpiod_get_optional() is now assigned directly
> > assigned to pcie->reset_gpio. This removes a superfluous local gpiod
> > variable, improving code readability and compactness. The functionality
> > remains unchanged, but the code is now more streamlined
>
> Would a corresponding imperative wording become helpful for an improved change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc3#n94
>
Assign the result of devm_gpiod_get_optional() directly to pcie->reset_gpio.
This removes a superfluous local variable, improving code clarity without
altering the driver's behavior.

Is this ok with you?
> Regards,
> Markus
Thanks
-Anand

