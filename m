Return-Path: <linux-kernel+bounces-748711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43300B14509
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB091AA0B38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B842192FC;
	Mon, 28 Jul 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J2j1TmvL"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD84237A4F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746638; cv=none; b=slKDZh7tDokMMHR72GOblVjTI7maS/ktkWUsih1h9BQ2c42PMDAoXlbaiE2TcqBC6X8HQGq5x1iN/yaYy6sT1tUvLGik6F77E1s7aRj7weRrIFosm9z0kNMi9n/PU3I13WtcsCQemKVw1hVcFKaI5KhYEDw09AJkr4cjy6GGL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746638; c=relaxed/simple;
	bh=bqbmIx4Du4hIR7pgkpCEuX8kp0ClRuQ21aSOgiCJ+GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfcDkjBVO0QryRD5CykY2UQQ014Pk7AsInNi4+fbLKBSBPELfU8TWEPZupe3FAirPZ+igY3SC0t68tYh49T3SkrUaK9cg6TkoUQ58fpZYPx3kcaktesgz3+9yxobH9L6Ncj+KndD+391KVColbX8LvUobIVwF1v7zVZfAN9+Pwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J2j1TmvL; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fafb6899c2so5928406d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753746634; x=1754351434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iueJ8Cgzeh/WMUBkqRkXiA9X4V1jFkOTholgp1vPz/A=;
        b=J2j1TmvLn5McGs2lOjm+xMI+J1qdaUAm2G++Ks0G5loe6mSckRKMEh42O051SFZ0hz
         O2IK+9byyPUO5iPuih9fN6TkASTQr/bP6sPivIYvwkpK/wyFGLGAd6+8mwd5T7G43iUx
         y8i2OVtQKFJ0nTJUdpKeiYEBNI+2gi0yHoZuSLgeHIX3Xb6X04T5LJdfQxiHviwlZFv2
         oXVCx9xHmxTt0mn7r51Gwz8F1Th/WBnK0Yg2Gu88TIJ/+8P/j6E2wtPmitxpXj6DUnzq
         H2/u+A7B71knNv3RSmdM/Skf3x2h/3tx2AVdA5FB4cte92EfrCCW/ryNoNYIYy49beL7
         /H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753746634; x=1754351434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iueJ8Cgzeh/WMUBkqRkXiA9X4V1jFkOTholgp1vPz/A=;
        b=gmYNzamii7aexlcF5vMRDNKdEaVNChm1LUj+xt1wANaxuIE2Jbn9zyv1kiVa1tRkho
         /wUe5d4apT9wVjhMX95W94J+kwd2LIsM1RcUYrzknXyRrltEky95MO51WXWTx1rbndwD
         9LdYVxhrFmcRhRX52igikIHlVeJTYn0uFw2VglOZOvd7F4TsLi1oR2AJu1DZQ2U1fPw5
         D2kOypRHrkCpWlA2Wikgr2XUXJo9juoLFwCACEGlsufyFfSZyaT7C8LOwUAMIaPb2TB5
         vFVoDbKhum0+6Zf2089xx858OIEbSQtFrrVUX4G1wPRffEs2KZ3y2kwXfF7XhBHrO0c8
         KOag==
X-Forwarded-Encrypted: i=1; AJvYcCUkc6duAyPf9CNV/UZesYkaHfRVAHwQNzEcsMKTBM+cvCpgQUzxhp4OWE3KDLiMm9Cx8oqXbayq8sVWJTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbrg2N1Pzj3teCK16w58otUCGwhLnIPZ7Wf68h50NNxBsqgmOP
	WJyqIDAiT29WF+8tAyUrjDPc55Ttmib6n//mE+q5EnVgfPhbMQZIrXxT5hK/y3v2adg=
X-Gm-Gg: ASbGncss9x1KQQyVj44lhBbWDhKKQs3gtcGgVhwse3kWssXkHURs6H7q/i+3jPfW3bE
	yLOmIDs7OXStiBE/7i+RuGkgDWN6DQ4gfUmCWchrXpBokvXBt6ReJed/qxjx9R6XzHqDzQ5VyXH
	HeCAdF+PBSDZLRSNo2ikXNJYpVBlTaUN8QxQlTFVe2FDU0ZRYBEl3JR9Dm2SR7czALj3svBLYWA
	3uSDvsFIwNvACSC8w9c9yTnqPIYgxZ66W3GW8n4Is7Ze7T6ssA5fpNn0FcNQzPYzvH/Jgjwb+Um
	mDCvujcmHV4LAuahv6MDBjF5P43yxYpTVpkyaIoeeFJWCCs9tPTtqs9YjUcMuAkxLJ/uQBEery8
	027vUVaiurMPSErcX06mEgiYiL4J9mZj4Ubui58h9APR9C3G8yMKNp7zz7UVHMD2gOmAdMMyEfF
	n6gIo=
X-Google-Smtp-Source: AGHT+IEVaheib8zj47fKcSWQJltZlk4J0oGiuI5fe3RI2VMlrZImtfSO5GomGgwyvIbxd+4KYaZHHg==
X-Received: by 2002:a05:6214:3107:b0:707:4aae:9a06 with SMTP id 6a1803df08f44-70757bdd975mr26289916d6.19.1753746633936;
        Mon, 28 Jul 2025 16:50:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7074bacaa25sm14883496d6.0.2025.07.28.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 16:50:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugXc0-00000000Fiu-3dXC;
	Mon, 28 Jul 2025 20:50:32 -0300
Date: Mon, 28 Jul 2025 20:50:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at
 boot
Message-ID: <20250728235032.GE26511@ziepe.ca>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org>
 <87zfconsaw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfconsaw.ffs@tglx>

On Mon, Jul 28, 2025 at 07:23:03PM +0200, Thomas Gleixner wrote:
> On Mon, Jul 28 2025 at 01:24, Chris Li wrote:
> > The liveupdate devices are already initialized by the kernel before the
> > kexec. During the kexec the device is still running. Avoid write to the
> > liveupdate devices during the new kernel boot up.
> 
> This change log is way too meager for this kind of change.
> 
>  1) You want to explain in detail how this works.
> 
>     "initialized by the kernel before the kexec" is as vague as it gets.
> 
>  2) Avoid write ....
> 
>     Again this lacks any information how this is supposed to work correctly.
> 
> >  drivers/pci/ats.c            |  7 ++--
> >  drivers/pci/iov.c            | 58 ++++++++++++++++++------------
> >  drivers/pci/msi/msi.c        | 32 ++++++++++++-----
> >  drivers/pci/msi/pcidev_msi.c |  4 +--
> >  drivers/pci/pci-acpi.c       |  3 ++
> >  drivers/pci/pci.c            | 85 +++++++++++++++++++++++++++++---------------
> >  drivers/pci/pci.h            |  9 ++++-
> >  drivers/pci/pcie/aspm.c      |  7 ++--
> >  drivers/pci/pcie/pme.c       | 11 ++++--
> >  drivers/pci/probe.c          | 43 +++++++++++++++-------
> >  drivers/pci/setup-bus.c      | 10 +++++-
> 
> Then you sprinkle this stuff into files, which have completely different
> purposes, without any explanation for the particular instances why they
> are supposed to be correct and how this works.

Yeah, everyting needs to be very carefully explained.

For instance I'm not sure we should be doing *anything* to the
MSI. Why did you think so?

MSI should be fully cleared by the new kernel and the new VFIO should
re-establish all the MSI routing from scratch as part of adopting the
device. We already accept that any interrupts are lost during the
kexec process so what reason is there to do anything except start up the
new kernel with a fully disabled MSI and cleared MSI?

If otherwise it should be explained why we can't work this way - and
then explain how the new kernel will adopt the inherited operating MSI
(hint: I doubt it can) without disrupting it.

Same remark for everything. Explain in the commits and perhaps a well
placed comment why anything needs to be done and why exactly we can't
use the cold boot flow for each item.

eg "we can't use the cold boot flow for BAR sizing because BAR sizing
requires changing the BAR register and that will break ongoing P2P
DMAs"

"we can't use the cold boot flow for bridge windows because changing
the bridge windows in any way will break ongoing P2P DMAs" (though you
also need to explain why the cold boot flow would change the bridge
windows)

etc etc.

There is also some complication here as the iommu driver technically
owns some of the PCI state, and we really don't want the PCI Core to
change it, but we do need theiommu driver to affirm what the in-use
state should be because it is responsible to clean it up.

This may actually require some restructing of the iommu driver/pci
core interfaces to switch from an enable/disbale language to a 'target
state' language. Ie "ATS shall be on and ATS page size shall be X".

This series is very big, so I would probably try to break it up into
smaller chunks. Like you don't need to preserve bridge windows and
BARs if you don't support P2P. You don't need to worry about ATS and
PASID if you don't support those, etc, etc.

Yes, in the end all needs to be supported, but going bit by bit will
be easier for people to understand. Basic VFIO support with a basic
IOMMU using basic PCI with no P2P is the simplest thing you can do,
and I think it needs surprisingly little preservation.

Jason

