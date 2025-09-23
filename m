Return-Path: <linux-kernel+bounces-829322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16800B96CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D80189EA74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C138B32144D;
	Tue, 23 Sep 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NQ5Biita"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08943321F3B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644504; cv=none; b=j0vXRUQgQE1AzoFeQmJSBQyzaAcOa0C0O5j7+kn8PmSXM38BLQrca9RGb22MRXNHP4E5LDX1Pxo5CuTcHncEkPizuVYH6xgJqF9CKJ4ImF+oPbclgh1C8zK9DpwzEX4A8oXUvt50sDJAk9wtLtPZGw04NTaURiO+KNGdU8cAfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644504; c=relaxed/simple;
	bh=IYKsjA2lVzqlmST6yIaoy5ZiKBNubcdQiY7wDAQazvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA8VEGc46ErdYF9T/o4IT+tc3UOzBjAk4SDe/mYSVI4BsFiAZYU1/pKD/g6J1yLq3f3qFe4UGx1aNEaDOjj8t9e1VdYCoo0zpVBWV0z2FrRx5UWCO3DcavPNt/qBQ0pCmvMG3qSitaYRBVU4z5kR9boMLwQ92w6jpF7fh3bALss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NQ5Biita; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-84a91cfc7f0so4857685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758644501; x=1759249301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAF1ZqvUCq+DYRKtNmDJLT3lAtr/qrJIjSppUMh/0OY=;
        b=NQ5BiitavknQtMTIHry7kXzwAhCnm7ekaEDkBQOfkzdWU2FazwN2WwicMzfKjL147F
         zAtg6XJ4RjqdiucR5HR3qSAcd2JxGMZMBgSG6d/wKRbW04OCsOTYn6qM2o1wcU9MOmHX
         AFvekpOTqH/fhgCMk4p+xPDh2JqFQa65h4FZ9oep6oXITiku4hdLJc5a/JABRW2Cpla5
         1ZkmiGe5LWRNsAVxrFhtLvcAOgxbLd0mjHsGROY0CDJbvOoeUSollE/0h1KEvQURMw6V
         ghPgfMXGFWzWfr83Pi0qY0MwRmfIiE0VDcLY1rAnap/lzRBhVqP8aaVBIHPIinJsGCYF
         Dqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644501; x=1759249301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAF1ZqvUCq+DYRKtNmDJLT3lAtr/qrJIjSppUMh/0OY=;
        b=rdZYZg/YtFw31peeEI6aH84cPWCUxZdoC8VkR4PdILMtsj4mAo1kXPbbXj3Cp/Ta9F
         HgzLSCX1GWhMp8hSrKbq0glvldKoix+jRoHUHNmViuQjL0nqhPo72dlMe4L8eUMOC4GX
         rO6wyoFQh6bbeyjsfkUXGF1nQmswEuAtPHEr9WyvRehNrxh+zwY7NrRryb0q+8SOTtXo
         lRkGcV84K21IvrYlOUYWDcBLx0kLBtcJi1tYutbOhII6CBFONVRkxMCBLV5b8KT3wfud
         V3KET2gQoBlyLH12PQjdkQtL2IbqYChf76D40U+wKKb7cf+RBrQtGlaYnL3I6rbsaWMF
         2Wig==
X-Forwarded-Encrypted: i=1; AJvYcCVvODjldNxBIXrhad6RxDjIQKsjDzWy9qS//PcGum48KRLMN7P6k5djW2Ee1/MnD/3gph7zPkQLUWrMaEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGpH6OgetiNwtsOfKyO1Tm5rI/muCMbVsPGnkOwIJfxxuS05o
	2+1SQy6C7p6KsCGfaqMSxDEVR4mDU0Kuso4IitmuAn/OUPrZCPMGQ80Xo4vU9NpjRCA=
X-Gm-Gg: ASbGnctLhfDeoHgIBY5eYSoZaTd+WvKc18dyJTLRlzSz0idr8SGyhstp23p6PjNouWW
	P2g9uU5VkfcybeebDNIg6HAl658pEKCKIfydvKqtykWJSaYleapR9u8a2dj4hgdBGFKJ/4zJxCe
	jVusZyjKbP3zIholDz6Zov6EOWhBDTjwH0RtaatXF7vuBbZcK1Ixlm8UFeXTbE4MhsJvopW2fKE
	hhPIAGTYq5kdsPRqXGZ7B+z7VEYButdJHmo2CaZxZQ3G6GT7UHKOFzZl/mHcoP/+iE4atjAojIx
	6GyEr+nGead2FWNnYzn9zXXDRwaIyHWG5Z3yVAgMFLYoli0AP4I7oZtsvRk5fGSDmhlnCui4
X-Google-Smtp-Source: AGHT+IFYjLvlYVWkvRmfrd4O74XRQ2yOeConI9WiorD7CA02H/AscVNhWnASnvsfS0ugaprQj9f5qQ==
X-Received: by 2002:a05:620a:7088:b0:84f:e093:3949 with SMTP id af79cd13be357-851b8ba216bmr341372285a.36.1758644500700;
        Tue, 23 Sep 2025 09:21:40 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84cb88e6969sm318223985a.2.2025.09.23.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:21:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v15lr-0000000AxbL-2Bdg;
	Tue, 23 Sep 2025 13:21:39 -0300
Date: Tue, 23 Sep 2025 13:21:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <20250923162139.GC2547959@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
 <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>

On Tue, Sep 23, 2025 at 09:07:49PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Sep 18, 2025 at 11:11:02AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > This issue was already found and addressed with a quirk for a different device
> > > from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> > > Source Validation erratum")'. Apparently, this issue seems to be documented in
> > > the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.
> > 
> > This is a pretty broken device! I'm not sure this fix is good enough
> > though.
> > 
> > For instance if you reset a downstream device it should loose its RID
> > and then the config cycles waiting for reset to complete will trigger SV
> > and reset will fail?
> > 
> 
> No. Resetting the Ethernet controller connected to the switch downstream port
> doesn't fail and we could see that the reset succeeds.

Reset it by up/down the PCI link?

> Maybe the bus number was still captured by the device.

Maybe, but I don't think that is spec conformat behavior.

Jason

