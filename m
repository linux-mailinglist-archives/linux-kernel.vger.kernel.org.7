Return-Path: <linux-kernel+bounces-790640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AA6B3AB38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B2734E499D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486627CCE0;
	Thu, 28 Aug 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aj/zIdXi"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9ED11187
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411318; cv=none; b=UV8CQf4nDxKF1pwyBoqUxlpmCQH7dSBZ+fzYk0XWkI3teaKarxM+yGWKbGSAQHfymuSTuDcUhjlaw1NnI2dkGhhEiACnDfoWyHgDPE7KK5OOIfC8L2zPXd8Maw6TzpBV1VQGWX3Ken2oHiHDfjPs9nHGoDUWo5FM30VV/THvToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411318; c=relaxed/simple;
	bh=oFN7wNXWLeYqEKNIevToJQ/RzV8ZlgtiskiMxC59NR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY0Fl7v6AstCsVY2s/30TBy12zGZHpU2FRFLuafVVvlKg0pe3qhyKPXo5OJdIgsXZXgU+9mYpmLAyt05a+c4YQOWE4fa5c5koLb8z3ZXVxFFdq9rtJyYkwytaw78WHxC7HEsifRNgerW1fJwu9FR2iVGN+JAFVpmYOz5tArsa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Aj/zIdXi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4717543ed9so973325a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756411315; x=1757016115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phR9doI5X4q1LR98gybIzZyU1kdJD+t4ijHV2CMLbUI=;
        b=Aj/zIdXinEHD9VWJVQyaxdHA1AEVnfZS1PfPz/Bbe3byufLPQKQVtJY1hsM5+Ej1l0
         rJwsOfAEqa0ZiOu7oiXbjDVsdsO1dyzJ1XccuIIYxiFhFNf/YYCcwAr8PHOCPeyf8E3e
         2WdUI50wmVl8zyun3MvRq8VyfzLu76yke29ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411315; x=1757016115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phR9doI5X4q1LR98gybIzZyU1kdJD+t4ijHV2CMLbUI=;
        b=vK/2kKVR/KIXLTDJDFU2kpDAkEcBkwlFjO3FjWZ0ZNFLxmOVjkKMRMcl35g3+I1W7L
         j8gW4waZGGbY8Nfo59y9hPTYFiOqBZk5ArFZuIOUzC9OaOVQTsBuyZ7dLC56DvvY587u
         UOzDcdCrtXqhFxZDMAJfSIWEnJ9zqu8P/5vrWBJRVJNKW4GkzsELg51MrSGiinrt7VH0
         tzNtQb24FVOoaWzmSY+XQQEJabfJGxxiqH2+1fkC8WmasoHb8tR6aic7GN0WzFHoGYuK
         Y3u8SWw/WjlfoPEYoh+sNVxWeA1LLxEbhi13J1vTZgjYiGW0o1Thffz0yaVIBL/NRS6x
         OXTg==
X-Forwarded-Encrypted: i=1; AJvYcCWzEeoSyQNGuJoK1kdFs7E55uxgSlZ00YdFiN+Uv8ZnhlAjiaLqxXVcBQQhRyUmvjllZjF60FcqnyvCoWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/8ML3NMkvOhU7Z1LXoMaiEG5aY3cutcq16I09H/b7eyZQKa5
	mHQ/4nGi6momhe/TGvqkclDtGCEhuccO5sxx7aUNSeubjDDJ8IYPc3+oLtvOvS5cBQblrVIj4Hw
	cuqQ=
X-Gm-Gg: ASbGnctsV6sPx51t+OQXrwguG6QjlDPnf/c7qa7OgliFQNf93IK8Ena63XqOcgHGTzn
	rrzN3dbtzfQ3oTEA7WEaO4SLOLVlv0e3rMxDE9TJfZ0YLy0D/3vsnaJvfM8UCuyakN4W63YJ3DL
	17U+N5RnsRwThauFdShurfhGnCzmamxJ2Jz7v8/gb27vozS01KHvfE/Qw6+XfqXgODPZehsd1nO
	zAnlHQKdjWFg1Su8yH6pg3i5F4m+hgpVeQsfkbu1U19/HeE1ejGWEWnbVT/Ki8eXjZJ6EVGoB2z
	1If2Q6ctmKWC9Uz+5ojOtcTmWEI2r71Gasw0FfK1HZJtwN2mQZzbaDhW3pNDb/mI7yWE+9EUSJs
	PaYIGP3O5pVbPur6vb1NAkK3Se0tsAMVrhs6NkX7eImAjiK3KhsfG909Xeo0FBe0H9ZFm56k=
X-Google-Smtp-Source: AGHT+IGRMI2y6ukLzuxA0A2Y52962J0xzxUUU/p9/lxC5pAaBaeFe2iw+3odm0xYYkw4AIuMGBT6Hw==
X-Received: by 2002:a17:903:13c8:b0:248:6d1a:430f with SMTP id d9443c01a7336-2486d1a46b2mr149396845ad.25.1756411314801;
        Thu, 28 Aug 2025 13:01:54 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2893:df0f:26ec:df00])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24905da3be1sm3479885ad.69.2025.08.28.13.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:01:53 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:01:51 -0700
From: Brian Norris <briannorris@chromium.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <aLC1rzdTVoN56Phc@google.com>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>

On Tue, Jul 15, 2025 at 07:51:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> Currently, in the event of AER/DPC, PCI core will try to reset the slot (Root
> Port) and its subordinate devices by invoking bridge control reset and FLR. But
> in some cases like AER Fatal error, it might be necessary to reset the Root
> Ports using the PCI host bridge drivers in a platform specific way (as indicated
> by the TODO in the pcie_do_recovery() function in drivers/pci/pcie/err.c).
> Otherwise, the PCI link won't be recovered successfully.
> 
> So this series adds a new callback 'pci_host_bridge::reset_root_port' for the
> host bridge drivers to reset the Root Port when a fatal error happens.
> 
> Also, this series allows the host bridge drivers to handle PCI link down event
> by resetting the Root Ports and recovering the bus. This is accomplished by the
> help of the new 'pci_host_handle_link_down()' API. Host bridge drivers are
> expected to call this API (preferrably from a threaded IRQ handler) with
> relevant Root Port 'pci_dev' when a link down event is detected for the port.
> The API will reuse the pcie_do_recovery() function to recover the link if AER
> support is enabled, otherwise it will directly call the reset_root_port()
> callback of the host bridge driver (if exists).
> 
> For reference, I've modified the pcie-qcom driver to call
> pci_host_handle_link_down() API with Root Port 'pci_dev' after receiving the
> LINK_DOWN global_irq event and populated 'pci_host_bridge::reset_root_port()'
> callback to reset the Root Port. Since the Qcom PCIe controllers support only
> a single Root Port (slot) per controller instance, the API is going to be
> invoked only once. For multi Root Port controllers, the controller driver is
> expected to detect the Root Port that received the link down event and call
> the pci_host_handle_link_down() API with 'pci_dev' of that Root Port.
> 
> Testing
> -------
> 
> I've lost access to my test setup now. So Krishna (Cced) will help with testing
> on the Qcom platform and Wilfred or Niklas should be able to test it on Rockchip
> platform. For the moment, this series is compile tested only.

For the series:

Tested-by: Brian Norris <briannorris@chromium.org>

I've tested the whole thing on Qualcomm SC7280 Herobrine systems with
NVMe. After adding a debugfs node to control toggling PERST, I can force
the link to reset, and see it recover and resume NVMe traffic.

I've tested the first two on Pixel phones, using a non-upstream
DWC-based driver that I'm working on getting in better shape. (We've
previously supported a custom link-error API setup instead.) I'd love to
see this available upstream.

Regards,
Brian

