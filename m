Return-Path: <linux-kernel+bounces-740422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1DB0D3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC64161C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0A293B48;
	Tue, 22 Jul 2025 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7E8Ostb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04013289340
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170942; cv=none; b=hMYTA/wccskhOZOIECsxx2oOa4FzWMd/VcG2YdW61gJaKJOrNeXynpcggV9dz7AUVcsSvNPM0uoj0JKkO6cjsUiEgSLFvMbJcI+lwB/EoqZoJjpVUMyLvxgKDxR0pBMiKn9a2HGPI7rXIckpozVZ+rNsUHTpfimOsFjLT52A1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170942; c=relaxed/simple;
	bh=538BX0oOECz/l/2l9Mo1894gIcR3ZyqW32EhlafprQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NoRkDYrpHAijKaOmI0S/DKFdHVm0yeEf6v6zS1kqnZqemmOsEkK0gOyK99aq1mW+HppPF7JT6gqBhto6Qop+USzc7Ah59VfaNb4gwj5Xr6Gicdgi20NyJSsZzvPI0oo/3NlMZeZieIONSeL8lo9+EaPOBDU8mEUjabCEQVqAiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7E8Ostb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753170941; x=1784706941;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=538BX0oOECz/l/2l9Mo1894gIcR3ZyqW32EhlafprQA=;
  b=Z7E8OstbUsnbyCdUyYXHPq1jsElXtLOllfMTNZglL4wEWYbM8/q7EA0u
   XuKlaviB+uuyaGMbgVk9DwHHds9dI9D3LNxRWNBAXVaOiNwI0YKk5XVhV
   P9xISfEjiW+MCrx99DGVAHhlRgbtg1zqdLCOmOj+oG+R+0WaNMU+rR87d
   A3Mp9uDT5TNtSn9sKk9HxVdUpG05hzB/UZMGcmwVHDPgNh3PkDKCnIsIf
   aohyrTIbfOuskacQYMMKrUgd+0cyV92Q8CucBpuH+evihuHtfTFaOTsYj
   Wg4rwthPP6BbeOMpvjcmo/VsNB3z9X4iCWfR8vterekplDZZ8Ub4sk03g
   Q==;
X-CSE-ConnectionGUID: F/NcocXYQtyJyCrOuprb7w==
X-CSE-MsgGUID: feOVxQ5QQYipJuIGkhx60Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="77947062"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="77947062"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 00:55:40 -0700
X-CSE-ConnectionGUID: tGbBdjeuRN2HT1zmZaohPw==
X-CSE-MsgGUID: /aq+xyXuS/26s2GRvXURew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="158373034"
Received: from wdziedzi-mobl.ger.corp.intel.com (HELO [10.245.113.213]) ([10.245.113.213])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 00:55:39 -0700
Message-ID: <fc12ee3d-1b76-43e1-98a6-b5b647fbb603@linux.intel.com>
Date: Tue, 22 Jul 2025 09:55:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Delete pci_free_irq_vectors()
To: Salah Triki <salah.triki@gmail.com>, Min Ma <min.ma@amd.com>,
 Lizhi Hou <lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <aHs8QAfUlFeNp7qL@pc>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <aHs8QAfUlFeNp7qL@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

On 7/19/2025 8:33 AM, Salah Triki wrote:
> The device is managed so pci_free_irq_vectors() is called automatically
> no need to do it manually.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/accel/amdxdna/aie2_pci.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index c6cf7068d23c..3474a8d4e560 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -520,14 +520,14 @@ static int aie2_init(struct amdxdna_dev *xdna)
>  	if (!ndev->psp_hdl) {
>  		XDNA_ERR(xdna, "failed to create psp");
>  		ret = -ENOMEM;
> -		goto free_irq;
> +		goto release_fw;
>  	}
>  	xdna->dev_handle = ndev;
>  
>  	ret = aie2_hw_start(xdna);
>  	if (ret) {
>  		XDNA_ERR(xdna, "start npu failed, ret %d", ret);
> -		goto free_irq;
> +		goto release_fw;
>  	}
>  
>  	ret = aie2_mgmt_fw_query(ndev);
> @@ -578,8 +578,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
>  	aie2_error_async_events_free(ndev);
>  stop_hw:
>  	aie2_hw_stop(xdna);
> -free_irq:
> -	pci_free_irq_vectors(pdev);
>  release_fw:
>  	release_firmware(fw);
>  
> @@ -588,12 +586,10 @@ static int aie2_init(struct amdxdna_dev *xdna)
>  
>  static void aie2_fini(struct amdxdna_dev *xdna)
>  {
> -	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>  	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>  
>  	aie2_hw_stop(xdna);
>  	aie2_error_async_events_free(ndev);
> -	pci_free_irq_vectors(pdev);
>  }
>  
>  static int aie2_get_aie_status(struct amdxdna_client *client,


