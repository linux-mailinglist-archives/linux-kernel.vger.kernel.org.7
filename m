Return-Path: <linux-kernel+bounces-608789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8695BA917FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAB43B35B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E511CB9E2;
	Thu, 17 Apr 2025 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJdVEW74"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB858224AED
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882405; cv=none; b=oUQ2tme+Td6Tf+zxN6HJ8Fx/Q0hRk22G+mcbqxBSncVFuXQiA4w8KBWRgLE+vUew3KBosV5kMDXkwkkxDwLV1XbThOHBnyF7t21zjam47O7LZwKyeVVUCh+URhKc4C7iwEP4fc8oogF7P4HRG2ILzveKW7+W6sZzTvlVCQ06uAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882405; c=relaxed/simple;
	bh=4N3XYkDst3rYfH4PF/bcxk8Q9dUYBcytZTx+T0TxXHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocrsQpxMhv4jkhjShjaGGclsAPklsyE5NU2pl1B14DilhLEIrWaSVEqECGi3cPqgKtkcgve4yKQipX4P1sTpkRUifI+lDQ5SrrFgCg8Uq0BmfqmS7/SeoDyyNhoWLTALuUBVUiz11v3jb0kvelFa6cKKjnueS862V4L6/sAwxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YJdVEW74; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so407194b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744882403; x=1745487203; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9N0xhgZNCRJbzkyeaB5Kdu2W0GpuGNyTH2hczyIgWGQ=;
        b=YJdVEW74OjnjGoPgoX6jkhhvbJMQnF5I6yh04Zo79Rp5HU4gKzh5j8U20iOQ9M5stU
         sfzg6KIU1yBv4IVWarEpB+Y0M6p+NyiiA7h/mBBLSLEFSHNcdwEj/cWotoXXzmB22wQE
         GyOIFqN7JcLEL8bWgg9ALeHALewW/7PeiRaeCdB8EndFvxyqfE7JzTBBjBVniMNi6/pg
         2Ro/miY2nB4OEnZkpK+sQvUtluxpOIsuGcSnskXMhf1QNgDjgr+7bFbBTx+3JZcoy76W
         akjqWHe70/Xlyxw7XTfCOOgWUp4iS4dyfRsAC1LbFhsdDHOxy0/Pu4Zvr0se72ykSh2v
         pKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744882403; x=1745487203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9N0xhgZNCRJbzkyeaB5Kdu2W0GpuGNyTH2hczyIgWGQ=;
        b=datmiTKNSIXkDROTb7Sd91x5hyCLF7cpAwDPl+4Jd9Z8SDioBMzsu/KfQOVM2gx1IV
         b9Lc4DAgzENDfGFh5VNvFTAdibiWXDqJg6ODO2wCUDWJxh6bUy2/W8zOPnIgaKW+3WBL
         BzcC33T/icba8PU+a4Mqha4TvfiawK4sS2Ilm1VPP5rBwXxNajEg0vg6562AHZVxevWE
         WVC4NKbqkgy8RV4DplTrCOZWYmpnxRLGTsL71wF+GVF58ttKxaS2jYheoSEY4NGr9RC1
         fUeeRDjKCpQMXeDM+906jW4HConMlGX6Mbdl90GtGoM6lMqtk9AEvR1MsbQ9o6Yqy0Ip
         GzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Fv5H6DqXHr0oDdPqYyaNZPjsAhEAwI9xlN0raE08y9UMiZZkrQCdqtQ6a12Qovq6ZH3NX056mVvE2pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywDvsF1paN4e9ybJ0bHev8TYK92B2PpAfwgnhjPQ9DQma/SIvU
	zHGLsU1DbpBlByvP99kPz53lcroTuzunZ8btN5fw+jgBh7CSWjIz352fyS9EYA==
X-Gm-Gg: ASbGncty94YTbK71keIMXxEg49M2Brxvwb9UwJU9PyEIzvCvPOZ89C7A4iuyifnIbmO
	AD8Qhj1vpmCOedPPIYixqF8oNM6I5pvJVwNdKkH1qQ4KXYph7Y9S7bg3kx69c4pGpv8MnHcholM
	LbQRJybu2WAJhl7Yk+m84t/kpkcnVZFbERyM4G1xoaUGHBy7cgLbnNbiLFuDZjUZsUDRfVL8RC9
	o+CER/02mHRuWN+H9qSGONAAlJnJxyPjN0bnkorwtPgWfukYTIPIcuWKsLR7PmsCwKf/2Kug7o+
	hrE/eFlniUf2Hf5FecXq/U8myCDIPiTWNGicbxUcBcYg5UDm
X-Google-Smtp-Source: AGHT+IEDIoppzt9Qk8ptm5Tvdr9bMM0BM2cyotG2JtwFXQXfEIWSI1eGvMWwitL7P6ll2IgmvhRvXA==
X-Received: by 2002:a05:6a00:2e24:b0:736:8c0f:774f with SMTP id d2e1a72fcca58-73c267ee1bbmr7570930b3a.22.1744882402798;
        Thu, 17 Apr 2025 02:33:22 -0700 (PDT)
Received: from thinkpad ([120.60.54.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198d95sm12277569b3a.17.2025.04.17.02.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 02:33:22 -0700 (PDT)
Date: Thu, 17 Apr 2025 15:03:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, dingwei@marvell.com, cassel@kernel.org, 
	Lukas Wunner <lukas@wunner.de>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: Add link down handling for host bridges
Message-ID: <hcjqtycb3dpauylwx726f3kb722dinuxootjswitchmh6cymlc@d4gzshhlfodh>
References: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
 <20250416-pcie-reset-slot-v2-3-efe76b278c10@linaro.org>
 <26b70e1b-861f-4c94-47a7-a267c41cadbb@oss.qualcomm.com>
 <lsehjhqicvit32jcsjkfqemgypnpim6zbxwapzdrncm3hwrp44@bvwg2acyyvle>
 <2c0b0929-0610-3e99-03be-a50e9f5f323b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c0b0929-0610-3e99-03be-a50e9f5f323b@oss.qualcomm.com>

On Thu, Apr 17, 2025 at 02:41:55PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/17/2025 1:24 PM, Manivannan Sadhasivam wrote:
> > On Wed, Apr 16, 2025 at 11:21:49PM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 4/16/2025 9:59 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > The PCI link, when down, needs to be recovered to bring it back. But that
> > > > cannot be done in a generic way as link recovery procedure is specific to
> > > > host bridges. So add a new API pci_host_handle_link_down() that could be
> > > > called by the host bridge drivers when the link goes down.
> > > > 
> > > > The API will iterate through all the slots and calls the pcie_do_recovery()
> > > > function with 'pci_channel_io_frozen' as the state. This will result in the
> > > > execution of the AER Fatal error handling code. Since the link down
> > > > recovery is pretty much the same as AER Fatal error handling,
> > > > pcie_do_recovery() helper is reused here. First the AER error_detected
> > > > callback will be triggered for the bridge and the downstream devices. Then,
> > > > pcie_do_slot_reset() will be called for each slots, which will reset the
> > > > slots using 'reset_slot' callback to recover the link. Once that's done,
> > > > resume message will be broadcasted to the bridge and the downstream devices
> > > > indicating successful link recovery.
> > > > 
> > > > In case if the AER support is not enabled in the kernel, only
> > > > pci_bus_error_reset() will be called for each slots as there is no way we
> > > > could inform the drivers about link recovery.
> > > > 
> > > The PCIe endpoint drivers are registering with err_handlers and they
> > > will be invoked only from pcie_do_recovery, but there are getting built
> > > by default irrespective of AER is enabled or not.
> > > 
> > 
> > AER is *one* of the functionalities of an endpoint. And the endpoint could
> > mostly work without AER reporting (except for AER fatal/non-fatal where recovery
> > need to be performed by the host). So it wouldn't make sense to add AER
> > dependency for them.
> > 
> > > Does it make sense to built err.c irrespective of AER is enabled or not
> > > to use common logic without the need of having dependency on AER.
> > > 
> > 
> > Well, yes and no. Right now, only DPC reuses the err handlers except AER. But
> > DPC driver itself is functional dependent on AER. So I don't think it is really
> > required to build err.c independent of AER. But I will try to rework the code in
> > the future for fixing things like 'AER' prefix added to logs and such.
> > 
> Right now we have DPC & AER to use this pcie_do_recovery(), now we are
> adding supporting for controller reported error (Link down) not sure if
> there will be newer ways to report errors in future.
> 
> May be not in this series, in future better to de-couple err.c from
> AER as err.c. As the sources of error reporting is not limited to AER
> or DPC alone now.
> 

Yes, that's part of my plan.

> > > Also since err.c is tied with AER, DPC also had a hard requirement
> > > to enable AER which is not needed technically.
> > > 
> > 
> > DPC driver is functional dependent on AER.
> I got a impression by seeing below statement that DPC can work
> independently.
> As per spec 6 sec 6.2.11.2, DPC error signaling "A DPC-capable
> Downstream Port must support ERR_COR signaling, independent of whether
> it supports Advanced Error Reporting (AER) or not".
> 

That's why I intentionally said 'DPC driver' not 'DPC'. The driver has the
dependency, not the feature.

> In fact it can work if AER is not enabled also, but will not have full
> functionality of DPC.
> 

Right. That's why I said functionally dependent.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

