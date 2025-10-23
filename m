Return-Path: <linux-kernel+bounces-867524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC8C02D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 004524FB863
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948334B431;
	Thu, 23 Oct 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cPOD1Keg"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104A184
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242501; cv=none; b=CeR3jTuZDtZUP8IZTlqvLpk+WBu/6pib8dubmDL+3Lo6+honwqXzmy4JjNXWGehc8bXEyAPmyrwZVGmm9ChEwWDiY4PtwKgkfTYaRA0NSDp5gEuPh5KUNaLIs6ZGzwe6ljEsInDxaou0RlMyNI/HQ88MPvR2EBgP/fCkLk1muzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242501; c=relaxed/simple;
	bh=+11krxrYSQBIL8PS8v62mSeTP8oZ51XSj0cM3YuN+vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNvBH7h0TkBSI/Oto2qVSTG1IryLPZxWGa7BU2HI1TDAJqgiNxjV7tPSZXHwI+fCqtNMisgJPHlOXDewmfALMtK5wJaKS+fy5C2Q8Mk28H9USGJEKBYEPz4HEqw2WWoWgTt97vAYOxigymCXnE7jtEoypzlkzF830lmU3R7uoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cPOD1Keg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so979121a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761242498; x=1761847298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fVJOJqOl/DPUXtsK6eZUYyA/D6xvUpAsP3hFipiCWw=;
        b=cPOD1KegM61aTrEPJxaRI9ZtHfLplA8R4BbE7ei2hOB1ghzLSxecOR2ToC6QybmS00
         jhai4f6HXSEgAXDL/RKFnn1BuAJ5CYtepJFfA8Haw+z31+yKJmDB4kdFxbX4cVNAIlSc
         HB1zQo4eQaf4mb41PEQTLRldGNzOFUcCkjne0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242498; x=1761847298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fVJOJqOl/DPUXtsK6eZUYyA/D6xvUpAsP3hFipiCWw=;
        b=UMtqvwG1+UJqYM7c0GZfX8/GOaR6dkAiohFUE1ZbBVL46XyaiU26Acr26WWymsq2uJ
         nqR7jVSdwc2ryPc15T0r4YR2BGH6TfQVBhGX9Wm+aKRYPXxZdqK/LLRojty3hylDb5A9
         uxec+3spbc62mgVuIcJogiX0N+FGcS1vhNFl0TbjzC3cWHL1YGREXJoUWachXE67QgWY
         KRPXbyki/g+yfk2HW8chzQKpviLRFl86/jsBmi6v6zaSKRNYVgGKy2bDhWO8Ob7be0ot
         0HLaerGfCy04wF4dwsXeXldAbxuKC76qr2/lNm31iHq8tUH1iGu1qslsLQ7bV6RlLR1z
         4cNA==
X-Forwarded-Encrypted: i=1; AJvYcCXY0wg6AVKsXr9H4YsAf/ij+cIF0G4ennLZSBtG17RTofdQjprI3KCVsKj5NqBGOxfIct5YJPo4fnyhYEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/s7EsaWAppGXlW/3gfr8O2emE8S4v70wwkELBeIpRF9wQs9DB
	GBpTKUghbmxHD3buLj8ul8xak3vmQQuharWi/VO4GF87XerkQTm132DYdQ+izbIPYgf7yb6b5Do
	ZuNs=
X-Gm-Gg: ASbGncv2oUOTuPwJrn27jQX9wOE95aG0/wgkcXduiWZadVkYdSBOf3VxvFYEM65fvUb
	ecQ7T/qUSydtUCyn9VZPF0EbtTxjB4a0FeyYgrO+n5IfxEX8aACv5mYHn8nszFnZ6d3IDLtfhks
	dT5ZB4UfUlBefNIoKWbBTVJW0FNgcTyMnMkh/mC1l13ojrnvoklg232CvrCoq5TF8JPaWtrKB9U
	szduSlAf43VK5i2OWX1akeRX6yESTShIV/UjTTXRDXysSrfkgDOIKiuob+43Mdl8z3fWVqQujah
	YLYwmzNWeAbTKMyhbmQ/QtY5sZrIs9q2FYQMxsO3lXTUawXuBW+27j6oAc+RsZjV921QwaHnj3Z
	kcuWKQasntRu75xhYJNxpPpRZCpJPymV4diny2Jly8dUA8FawpNXxTDNGD/qwYmPaoBzCCN6yb5
	DTuNAZtIwDQUDkro3aPf3qpT2jo+jUD8LPELjicHP7fWu/bsdw
X-Google-Smtp-Source: AGHT+IHMEl1/yOcEnK1WSum08iBEotApLa8nOZXGnnHDG0khuXHK2NNe5VrwxePf061sm8+ZE7PtOQ==
X-Received: by 2002:a17:90b:1b4a:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-33bcf8f7cd5mr35772646a91.26.1761242498180;
        Thu, 23 Oct 2025 11:01:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:839c:d3ee:bea4:1b90])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33faff37afesm3047298a91.1.2025.10.23.11.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 11:01:37 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:01:35 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PCI/PM: Ensure power-up succeeded before restoring MMIO
 state
Message-ID: <aPptf2gLpoWL3Ics@google.com>
References: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>
 <20251023172547.GA1301778@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023172547.GA1301778@bhelgaas>

Hi Bjorn,

On Thu, Oct 23, 2025 at 12:25:47PM -0500, Bjorn Helgaas wrote:
> [+cc Mario, Rafael]
> 
> On Thu, Aug 21, 2025 at 07:58:12AM -0700, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > As the comments in pci_pm_thaw_noirq() suggest, pci_restore_state() may
> > need to restore MSI-X state in MMIO space. This is only possible if we
> > reach D0; if we failed to power up, this might produce a fatal error
> > when touching memory space.
> > 
> > Check for errors (as the "verify" in "pci_pm_power_up_and_verify_state"
> > implies), and skip restoring if it fails.
> > 
> > This mitigates errors seen during resume_noirq, for example, when the
> > platform did not resume the link properly.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Brian Norris <briannorris@google.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >  drivers/pci/pci-driver.c | 12 +++++++++---
> >  drivers/pci/pci.c        | 13 +++++++++++--
> >  drivers/pci/pci.h        |  2 +-
> >  3 files changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 302d61783f6c..d66d95bd0ca2 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -557,7 +557,13 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
> >  
> >  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
> >  {
> > -	pci_pm_power_up_and_verify_state(pci_dev);
> > +	/*
> > +	 * If we failed to reach D0, we'd better not touch MSI-X state in MMIO
> > +	 * space.
> > +	 */
> > +	if (pci_pm_power_up_and_verify_state(pci_dev))
> > +		return;
> 
> The MSI-X comment here seems oddly specific.

It's just as "oddly specific" as the existing comment in
pci_pm_thaw_noirq(), as mentioned in the commit message :)

The key point for MSI-X is that unlike the rest of pci_restore_state(),
it requires touching memory space. While config registers are OK to
touch in D3, memory space is not.

> On most platforms, config/mem/io accesses to a device not in D0 result
> in an error being logged, writes being dropped, and reads returning ~0
> data.

On my arm64 / pcie-designware-based platforms, that is mostly similar,
but there are some cases that are different. See below:

> I don't know the details, but I assume the fatal error is a problem
> specific to arm64.

Maybe. See my response here also:

  Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
  https://lore.kernel.org/all/aNMoMY17CTR2_jQz@google.com/

In particular, when resuming the system in a case where the link was in
L2 and failed to resume properly, the PCIe controller may not be alive
enough even to emit completion timeouts. So it might hit case (a):

  "PCIe HW is not powered [...] and this tends to be SError, and a
  crash."

Memory space is unique, because while config accesses can be
intercepted/avoided by driver software, memory accesses cannot.

> If the device is not in D0, we can avoid the problem here, but it
> seems like we're just leaving a landmine for somebody else to hit
> later.  The driver will surely access the device after resume, won't
> it?

It's a possible landmine, yes. Although in my case, the link can go
through error recovery and restore itself later in the resume process.

> Is it better to wait for a fatal error there?
> 
> Even if we avoid errors here, aren't we effectively claiming to have
> restored the device state, which is now a lie?

I'm not sure we claim that. The device will stay in PCI_D3cold, and
pdev->state_saved will remain true.

But yes, it's a tricky situation to decide what to do next. My basic
assertion is that it's not OK to continue to restore state though.

Alternatives: pci_dev_set_disconnected()? pcie_do_recovery() /
pci_channel_io_frozen?

> Even on other platforms, if the writes that are supposed to restore
> the state are dropped because the device isn't in D0, the result is
> also not what we expect, and something is probably broken.

Sure. IMO, that's even more reason not to run pci_restore_state(),
because that will erroneously drop the state, and we'll have zero chance
of restoring it later.

Brian

