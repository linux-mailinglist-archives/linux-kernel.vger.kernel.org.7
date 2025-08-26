Return-Path: <linux-kernel+bounces-786934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE51B36F02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE8F8E5CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660736C06C;
	Tue, 26 Aug 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5G1vIfB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B078350857
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223334; cv=none; b=VSV/40w/ehAeB0DbGX61UdWR0bRruS1WvvH+W8sw9SuyRdjw4CsEzKZk2NJ8a5toeMFPMKpkSRiJOjbdcJazHphRZkp644BwnX45BQcxyjmUf+xniRLY3jctvNj4gEINnE8xU4cwFH1j1Wn9SaAFLIXvb/KlD/Vzn3PHzD8Kcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223334; c=relaxed/simple;
	bh=Y0eks1YaOqbzuug07KZLAOR4Y6H+hh0TiHWBe8OcU2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHw/+u5/WfiJN18KlyWi7BErOlxO9k6ytrK+mpMFy3lL9Y/5b80iE+QwQJS8n5CDWTjvfhjTil5MlsVCyrE8Lqhctkf77PHICJl8jKIrgg7B1GqOdaGHIIk42MGGhDqd5Hqeza9/rFtQD9vr7tJWG+zjetKX0lMjTbKBnlHgddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5G1vIfB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756223332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHNXd9VyNqrFX2UZhtEPC0je8otxXnW6I6u8evl0zzQ=;
	b=g5G1vIfBQ8O825IYKAjaDcje7CwwxWSwfWQH8/4xa7qHx4IkOK4lHOenQ86n2S2cXgVBJp
	RNTKJgU39BMhPWugigjzoGlIMYJXxWMFbF4z04tF2KVB2GGi8O4QM90veqFd1EQ7agiVN6
	LpTHE/B8kS7BzBB2DJVHqYIuCv5z2c0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-bqHvPYqsNtqQtVjx2rgdzg-1; Tue, 26 Aug 2025 11:48:50 -0400
X-MC-Unique: bqHvPYqsNtqQtVjx2rgdzg-1
X-Mimecast-MFC-AGG-ID: bqHvPYqsNtqQtVjx2rgdzg_1756223330
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ee5c3c9938so1999735ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756223329; x=1756828129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHNXd9VyNqrFX2UZhtEPC0je8otxXnW6I6u8evl0zzQ=;
        b=Tac7iJp8ZIj5mC+jFwzrmh7Nmxsg7EcJNysgCmgLI6NeUkpx+gkn6zbXKl6BrNNU+i
         pi0aDbT20URF/HDhEeGdgw542FKZoCEjq3yckTJz+LZLlHrnDkulBJGaa+/xa/t5AYuL
         xgfio+/bSnBQjxlhXh1p69CG9EitGnuTvmsXqp7FjViF4G+EQ+/nwREw0U+oZgthYuEQ
         PwQ4cLRM8yyHDXOOu4TYEbRbh2fFWmEy2YlDm9N8i1udYnuA7AuHj4STQYCaao68TakW
         +Ay5d5g+5Coy+xtVj5dsgD1Utbs6c5wBxJOnS/44hHXmXV9+tU4NJ6cUygVgrMeuRiDH
         kv+g==
X-Forwarded-Encrypted: i=1; AJvYcCXry6N/cKBf6Vt2CwNjoPucYg4GN8DXfEGCJss3XV1sIDL+uo5xERoe/a9DpIrABaYKCD3l9Hfp1k2iEp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLRQoFZPR2PpqSzZR9a8KXbVztWpjFfgD3D1YUeyyNibwV2Cc
	iViMKy504yzWa7jYbpEv7yxYcorXMLzACQPiE0i1GeFjiog+xeT2rzDbdptr/7mz8LIK14XCTfo
	GbnEOk4Sra5SPX1butmf3KU3IU+9bo93kb/IEc5brILD1JABtm95XICVAcYPyKQwXo9m9btCHcA
	==
X-Gm-Gg: ASbGnctuqOIYc9U/Nef5lEWV40ICCfq2hIOB5FD8qG/gPMA6ivHmEZ7MU91VbAx+2AI
	xriD1iOEUuhmY3aoA/O/DN0uYZoK/ujsl9KAsWCbiHuMwBvmCfFciIOcjrmLNIJUPFpiDdsa53e
	M7r/0AxGyDBh+ilF4Dq+Uz9yA0R5MdLfrwY+ifRGKYMBEiTFZ3qifcpRbDEWY5V6QA28VpU3EOB
	RwsVGjnDtYnaoH6RGvYUNV/6EKIH/Q67b1cqcgSUOvMZXit8KiZ0ClPYUqA+ZMXxLM1GbgH15Xg
	3xXFp8uxDvD9ukkA43D0xvxE1zYaq/QvGqbZwlpDvGk=
X-Received: by 2002:a05:6e02:1a48:b0:3e6:67f9:2061 with SMTP id e9e14a558f8ab-3e91cfae117mr88824205ab.0.1756223329376;
        Tue, 26 Aug 2025 08:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41ooOBFFuOfcZRxU06TfSGWwzTnjM8fsjevvJOvWhDhebSC+xJEVzKrEMkNTbsTkk0XUw5w==
X-Received: by 2002:a05:6e02:1a48:b0:3e6:67f9:2061 with SMTP id e9e14a558f8ab-3e91cfae117mr88824085ab.0.1756223328938;
        Tue, 26 Aug 2025 08:48:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4ec1f6d0sm68656065ab.40.2025.08.26.08.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:48:47 -0700 (PDT)
Date: Tue, 26 Aug 2025 09:48:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v2 1/9] PCI: Avoid restoring error values in config
 space
Message-ID: <20250826094845.517e0fa7.alex.williamson@redhat.com>
In-Reply-To: <eb6d05d0-b448-4f4e-a734-50c56078dd9b@linux.ibm.com>
References: <20250825171226.1602-1-alifm@linux.ibm.com>
	<20250825171226.1602-2-alifm@linux.ibm.com>
	<20250825153501.3a1d0f0c.alex.williamson@redhat.com>
	<eb6d05d0-b448-4f4e-a734-50c56078dd9b@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 15:13:00 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 8/25/2025 2:35 PM, Alex Williamson wrote:
> > On Mon, 25 Aug 2025 10:12:18 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> The current reset process saves the device's config space state before
> >> reset and restores it afterward. However, when a device is in an error
> >> state before reset, config space reads may return error values instead of
> >> valid data. This results in saving corrupted values that get written back
> >> to the device during state restoration. Add validation to prevent writing
> >> error values to the device when restoring the config space state after
> >> reset.
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   drivers/pci/pci.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index b0f4d98036cd..0dd95d782022 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -1825,6 +1825,9 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
> >>   	if (!force && val == saved_val)
> >>   		return;
> >>   
> >> +	if (PCI_POSSIBLE_ERROR(saved_val))
> >> +		return;
> >> +
> >>   	for (;;) {
> >>   		pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
> >>   			offset, val, saved_val);  
> >
> > The commit log makes this sound like more than it is.  We're really
> > only error checking the first 64 bytes of config space before restore,
> > the capabilities are not checked.  I suppose skipping the BARs and
> > whatnot is no worse than writing -1 to them, but this is only a
> > complete solution in the narrow case where we're relying on vfio-pci to
> > come in and restore the pre-open device state.
> >
> > I had imagined that pci_save_state() might detect the error state of
> > the device, avoid setting state_saved, but we'd still perform the
> > restore callouts that only rely on internal kernel state, maybe adding a
> > fallback to restore the BARs from resource information.  
> 
> I initially started with pci_save_state(), and avoid saving the state 
> altogether. But that would mean we don't go restore the msix state and 
> for s390 don't call arch_restore_msi_irqs(). Do you prefer to avoid 
> saving the state at all? This change was small and sufficient enough to 
> avoid breaking the device in my testing.

If we're only reading -1 from the device anyway, I'm not sure what
value we're adding to continue to save bogus data from the device.
There are also various restore sub-functions that don't need that saved
state, ex. PASID, PRI, ATS, REBAR, AER, MSI, MSIX, ACS, VF REBAR,
SRIOV.  We could push the state_saved check down into the functions
that do need the prior device state, add warnings and let the remaining
function proceed.  We really need to at least pull BAR values from
resources information for there to be a chance of a functional device
without relying on vfio-pci to restore that though.  Thanks,

Alex


