Return-Path: <linux-kernel+bounces-781142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F727B30DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D905189A534
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDF231832;
	Fri, 22 Aug 2025 05:24:45 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFA212563
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840285; cv=none; b=kCAfZpzJqvVbIUuq+HutHYtazYWRgN0wHNCI7X07SFF8OL07xhsSsVqnxSHoTj4pAAzbelPrv2WCw1/xfutuoqshp2aEYS8AZ7GlUV8+wuS5ibclRWgnORAV3j6LNqnjTprhSlP5IWTU1l1BXSQSviaLO7tLDtZ165Kic+vNhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840285; c=relaxed/simple;
	bh=vqrYwUwAVs5X2DPvqk2UlNCPO6LGG4MO76/HcDklnnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfsp9q5ac2HBvL6BFlxsmb/ufot8ukNnNhwAQiNAWBL4XnEl4r9HJ06CuKUB9TVWyG6cnmQSebvOh0U185Chvsr2wnkIiPt0ypGqmfSmZNWpPzPFTbYJXhPeFxX37rC+E5TdBLeeaKznO8wLIvHRK7PMBPdr/e/PoHzOfjZ/B6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz3t1755840193tae549ba7
X-QQ-Originating-IP: 5NgYGNwVjuXw11VeCT6N7t3/42rH5L5UVcwCtVF/r0o=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 13:23:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3820646082963758569
Date: Fri, 22 Aug 2025 13:23:12 +0800
From: Yibo Dong <dong100@mucse.com>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <4DDD62E86FE72117+20250822052312.GA1931582@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-2-dong100@mucse.com>
 <f66e4b61-c547-428c-a947-57ea2a71c1ea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66e4b61-c547-428c-a947-57ea2a71c1ea@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OXhWvHhbOVwtis9ps2diS86gnIj1fYXjMFzVWLYJwBGs5xJECb75HaJz
	GND/0SPCia6LZvCPmC6gO2a2M61udq03fa2XcPiAFMQ/QnhiQ/VmxYEpjjaSVoRQiQeC5B2
	wjFJRfYmgYQFrVXdaIWvg1UXDIS333nshYZlsz78xEyf3mObY2cqoiJfisyyeINRBq/DjwK
	z/uduTdJ5DAroW+1Y7v/UBn6uHEjYFvb0od+ZFjkFd5EuKqxHYNq+IlD2zVd4dw9tj7r0rL
	1I7+INsOg5m6EEGXgWl/OteLPFxXIGfGK5mCbdmaY0mayK2JtlqwMurykaz+Z78tJH63aii
	+3s7P6eetBOYhOBeeZqvSw9XpfVuw4Bby+LO7pLFrFp7dDia51/y8bbExBRZSF0KXYtO+dZ
	m6U7koaKZOskkeTsXoy5VemlNpZQdeBUXlKK75jD4CPTGY28a2izSCBtCxKnbGGiCzfIHt8
	6PX1clan8dsXbB3w3ZcfpaZ7aexPAW3xrfYCaOjaVPqdW/meTbSSHwx2wkgGKPk8nq13Brt
	xK4cv8mkItf6IBcRzKALSjqtQduwRA5FNQzM/uKsO1Yuj/WUwOhyPEkcnVyaUibnCNqcc2X
	V3h4BX1uFyzSD3enHTZ1zGmVwJhEV0s6FIuxKg3sMH5xDkVPstVJPjzCza6Lz169vRfZaDH
	nXkDRa6H6wPDoAMe1bAV8Bsf4VM4gIIarKhpGOHMnSYtLSZ75J5W/fuJalJDSK8szAMmZlj
	IHkA+ibAqafta5QIvcvytjRIT9jKaD92F5W5twpZrw+8134Ysf0D61eNSzZKQ7PwxxrfHkm
	09suaTAQrI7GZQwrQoC/6z/6YKUNfItNCGo1x5pkw7DwABVhmeZKj+1hcPoZdPqH4ODigaC
	9HG2IsdwozmWn5B+eIf6w2IVjIjCu7QOI8c49wCEAKYdpXVMTbK1oB0Q03fAQK/5cOcFt7B
	IXeY1IH+F34Jctn3EtsVV6yHaESsSzqb6YpExA0kq1OuaNIF6rKh7LZ6bxtPrR/Ts+X8=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 04:32:06AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> > +
> > +/**
> > + * rnpgbe_probe - Device initialization routine
> > + * @pdev: PCI device information struct
> > + * @id: entry in rnpgbe_pci_tbl
> > + *
> > + * rnpgbe_probe initializes a PF adapter identified by a pci_dev
> > + * structure.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +       int err;
> > +
> > +       err = pci_enable_device_mem(pdev);
> > +       if (err)
> > +               return err;
> > +
> > +       err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> > +       if (err) {
> > +               dev_err(&pdev->dev,
> > +                       "No usable DMA configuration, aborting %d\n", err);
> > +               goto err_dma;
> > +       }
> > +
> > +       err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
> > +       if (err) {
> > +               dev_err(&pdev->dev,
> > +                       "pci_request_selected_regions failed 0x%x\n", err);
> > +               goto err_dma;
> > +       }
> > +
> > +       pci_set_master(pdev);
> > +       pci_save_state(pdev);
> Don't you need to check the return value of this?
> 
> Best regards,
> Parthiban V

Ok, I will add the check.

Thanks for your feedback.


