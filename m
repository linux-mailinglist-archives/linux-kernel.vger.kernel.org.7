Return-Path: <linux-kernel+bounces-825077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33515B8AE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AE81C840BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73164258ECE;
	Fri, 19 Sep 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7/D//+A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104451FAC37
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305868; cv=none; b=gkq3NdUPEU839qo4tZxfGNIBw3gqQbYk+4Zs9r4emzPEoZeO7wNhzz8Mo2Xuo0NE/cj4b1wQuW6RTFhA5HQAKIdCIAkoML3aVD+9x1ZoVJPX42Ly8bmcAX4K8oSPdh75shpoXa1eXNX1CJhIoz36hGWrG6nlyJPLLeioBoMEMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305868; c=relaxed/simple;
	bh=UYQ/heBMSwesBf4ndeJdw8Tnd7iUiwyxPBtUng/3UNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn/rM3RqeJqvNdZ/ALVVTs7e2vQgP57dKljxvWbN+1+4hhZjSx8D2SKIDXNP78zUDRTl7+oxrRaHvpizGPjdw/E9HPutfzENU1bzqmXaahfSvUdKhkAAoISAlZg8YJ1Urf8wYvElWDGbfmv3UqilZAzMAJs3V3ELE8SxjCsvbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7/D//+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758305865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tP8qgX24boDvqrfxOc41UrXAFnZAOnA7a7ICmrly80=;
	b=W7/D//+AAzrsFhfJuBmqimxbi0nbNwlKgLoRfiNJffPU+JGqnKy8qUWgQig8ERxyML3+QC
	jI0pUeEH4DVtMyISqyAk0abURfRAAjw71SXVdShZagJXxSV7vVovFVkJ0swSlhEAPqR+bg
	TN9kAvqcc02B7E2eaZWl27UGoZ71rWI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-1ThQ9K-aObOb782zq_Acow-1; Fri, 19 Sep 2025 14:17:44 -0400
X-MC-Unique: 1ThQ9K-aObOb782zq_Acow-1
X-Mimecast-MFC-AGG-ID: 1ThQ9K-aObOb782zq_Acow_1758305863
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-40b911746f0so5637365ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305863; x=1758910663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tP8qgX24boDvqrfxOc41UrXAFnZAOnA7a7ICmrly80=;
        b=jY0hc5xOT4QyQuUu3ELQoH7THym26D2POqxT0hJbRHmTskkyb/6g6sS4X7uelj2TIx
         BJ6pKuaETgmcjbwVu/KfrYiTAn3UENtImy91je7f24egF9us7Xt5Bdk82hpiOhLY/thH
         ZtDECAOT8DfzfkIjPqpYseNT7tztfywTvCXX2f1CatlXzPM2qmZnVu3heRiTbRoeHbCY
         70m/UAjhGaq3PueR4hFKojEL7ouhWTQy9nBtglF8v0xdcHZQuvRvS8bMl4YEWgrQFVbE
         mXskH23ZgV6+4HvwuszAp3Z3L3yjHMh2FMgWkHmcHjbMDMaVp4VmpO8oZcxKUWwRq6Vf
         +KXw==
X-Forwarded-Encrypted: i=1; AJvYcCUFCgljRJcLu/cK4cVF/IXlkPRF5MjBbjW1SOQ6kF1NVLUzb8/+rCu/5xpkYy2VpSlgk94VM666BZdsFac=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe6RIY1vCN/lHY5oaPrpJxjVK9zrZWH7D8QHxKdyGKfw9wuse5
	mUTxowyByjnnxSkOLH/8UK1xcy9EiE0xYnNCKKAsy9aEeWfe8LZl+EEc93xeX4bXw6b4QETwVYS
	VG32cpkXS+aUm92GACkL31aqyCBSMxybYsqbDZmeXhLeO3C5GP7HI5OgKTidXOmAtqw==
X-Gm-Gg: ASbGnctb5yFxXXKaCUIkxB0nlMPSFap63yagQO5oOcLFFTSRekrqtLn569pwQZsjXQX
	uEtxhiUUCh3iiG9kp4j1Iil424hthhUC6Q+HDBXhFc/3+qUWUbp9Z3J81Jf+tzlaRUjhInlrVBZ
	G4fZuM1d1aRVCsenTf2X9+jhVcyn9nhr96Mcz1FGYZZe2/+WcBBMCricOMRkeJot69Jyj3+ve4F
	lMpMDKEJOGpPDCC25JFbhd6gwQ3Iz6iLGcVmFIJ+ZgMaE+EXrc2c/C3Oa04I4vHs0bZecPDDUL/
	IFt5TWSX1qfpqINEIg87vfI1mFdOEzJL1YBeN44mL6Y=
X-Received: by 2002:a05:6e02:1d9d:b0:424:69b:e8d0 with SMTP id e9e14a558f8ab-4248190395emr19310635ab.1.1758305863179;
        Fri, 19 Sep 2025 11:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb10MnB7zhkH1dVW9AEzJVk+z8ybEB8AlSck6uXI8Tp5xc6aeeZCL649awhtncJC1hXa8bVg==
X-Received: by 2002:a05:6e02:1d9d:b0:424:69b:e8d0 with SMTP id e9e14a558f8ab-4248190395emr19310505ab.1.1758305862772;
        Fri, 19 Sep 2025 11:17:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm24280945ab.22.2025.09.19.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:17:42 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:17:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3 01/10] PCI: Avoid saving error values for config
 space
Message-ID: <20250919121739.53f79518.alex.williamson@redhat.com>
In-Reply-To: <d6655c44-ca97-4527-8788-94be2644c049@linux.ibm.com>
References: <20250916180958.GA1797871@bhelgaas>
	<d6655c44-ca97-4527-8788-94be2644c049@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 13:00:30 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 9/16/2025 11:09 AM, Bjorn Helgaas wrote:
> > On Thu, Sep 11, 2025 at 11:32:58AM -0700, Farhan Ali wrote:  
> >> The current reset process saves the device's config space state before
> >> reset and restores it afterward. However, when a device is in an error
> >> state before reset, config space reads may return error values instead of
> >> valid data. This results in saving corrupted values that get written back
> >> to the device during state restoration.
> >>
> >> Avoid saving the state of the config space when the device is in error.
> >> While restoring we only restorei the state that can be restored through
> >> kernel data such as BARs or doesn't depend on the saved state.
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   drivers/pci/pci.c      | 29 ++++++++++++++++++++++++++---
> >>   drivers/pci/pcie/aer.c |  5 +++++
> >>   drivers/pci/pcie/dpc.c |  5 +++++
> >>   drivers/pci/pcie/ptm.c |  5 +++++
> >>   drivers/pci/tph.c      |  5 +++++
> >>   drivers/pci/vc.c       |  5 +++++
> >>   6 files changed, 51 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index b0f4d98036cd..4b67d22faf0a 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -1720,6 +1720,11 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
> >>   	struct pci_cap_saved_state *save_state;
> >>   	u16 *cap;
> >>   
> >> +	if (!dev->state_saved) {
> >> +		pci_warn(dev, "Not restoring pcie state, no saved state");
> >> +		return;  
> Hi Bjorn
> 
> Thanks for taking a look.
> 
> > Seems like a lot of messages.  If we want to warn about this, why
> > don't we do it once in pci_restore_state()?  
> 
> I thought providing messages about which state is not restored would be 
> better and meaningful as we try to restore some of the state. But if the 
> preference is to just have a single warn message in pci_restore_state 
> then I can update it. (would also like to hear if Alex has any 
> objections to that)

I thought it got a bit verbose as well.

> > I guess you're making some judgment about what things can be restored
> > even when !dev->state_saved.  That seems kind of hard to maintain in
> > the future as other capabilities are added.
> >
> > Also seems sort of questionable if we restore partial state and keep
> > using the device as if all is well.  Won't the device be in some kind
> > of inconsistent, unpredictable state then?

To an extent that's always true.  Reset is a lossy process, we're
intentionally throwing away the internal state of the device and
attempting to restore the architected config space as best as we can.
It's hard to guarantee it's complete though.

In this case we're largely just trying to determine whether the
pre-reset config space is already broken, which would mean that some
forms of reset are unavailable and our restore data is bogus.  In
addition to the s390x specific scenario resolved here, I hope this
might eliminate some of the "device stuck in D3" or "device stuck with
pending transaction" errors we currently see trying to do PM or FLR
resets on broken devices.  Failing to actually reset the device in any
way, then trying to write back -1 for restore data is what we'd see
today, which also isn't what we intend.

It probably doesn't make sense to note the specific capabilities that
aren't being restored.  Probably a single pci_warn indicating the
device config space is inaccessible prior to reset and will only be
partially restored is probably sufficient.  Thanks,

Alex


