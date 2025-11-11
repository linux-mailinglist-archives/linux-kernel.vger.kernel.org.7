Return-Path: <linux-kernel+bounces-895091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83453C4CF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511524A3337
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777D732C336;
	Tue, 11 Nov 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="l/oJIHkn"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C232B998
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855205; cv=none; b=TldJ7FWjz+QecW1J0XuYV4JaKM8x8LoIK975rSa9vcQ8MZFmTIcg3KrDDNWV6W3XHa7ZUCXLxVQVSoLxwmLE7wH/qRGm/vCQfX68K9D7FQF/vI9E7D4FILEFaVVES2fnyQVsOVn0PWTnYTc0nR8U4tayOqlcOP89wlcpWke2HbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855205; c=relaxed/simple;
	bh=+UuqxSlUB8jmloPHAb0dqkzDuBDKGq9ZA1IjhGxjbM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5p9hUKtuskJ0RPhjzougI4rQIpfMw9uRAwHMTf74dQ3REe8du+6lKDB/2M2emdKkCKgt85+GjLS/tZkh4XfEfDfkw7WKXCD7JQrlYH/UIyD8e0aJ+DeReXucxfd/UarZ2YdmiN/1sVpjLdyGE3jqDNbGP48i0NlpfzHI12Di28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=l/oJIHkn; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id IlAHvWHdhUOYJIlAHvMunr; Tue, 11 Nov 2025 10:59:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762855196;
	bh=rFk/u5DUIUOnbpwpW5YN8Igu4wBiIQtesflrYhSz5qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=l/oJIHknGgHm9tLXVlQVKfbV2ktA1ZUuWCay6cnp9XlDj6BimiqzCReBk8nQksH8V
	 quW0bxax5WHxVRkSJ8aknh1ZPBQLEdRmC5G48SylytGo+XXPsHj78d7WQYOCiIVfuS
	 mrEULjQAOEjcBTZ+ZCPC9N696K7e+4f6MvpDqxOVAhSV4v5Prti0HOyTlJxCK9Axw5
	 TUDC2YABvIA22HIiS2b+oBtzcGPNLx+smfdJiPuHUF8vj/49c3JFGPO6oN2MyvFT9+
	 Nqmx0va8PQGtcIOluIanisna36z0WVpKdVT6S7OvaaU7nMelwITmt45UwbCZTo3d9e
	 aNN03tCE11WEw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 11 Nov 2025 10:59:56 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <2c0da6a9-e766-49be-a679-9d19e5d14992@wanadoo.fr>
Date: Tue, 11 Nov 2025 10:59:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 5/5] accel/amd_vpci: Add communication channel service
To: David Zhang <yidong.zhang@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, maciej.falkowski@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com,
 mario.limonciello@amd.com, lizhi.hou@amd.com, Nishad Saraf <nishads@amd.com>
References: <20251111011550.439157-1-yidong.zhang@amd.com>
 <20251111011550.439157-6-yidong.zhang@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251111011550.439157-6-yidong.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/11/2025 à 02:15, David Zhang a écrit :
> This patch introduces the communication channel (comm_chan) service, which
> enables communication between the management PF driver and the user PF
> driver.
> 
> The comm_chan service provides a shared-memory-based command channel
> located in a BAR-mapped region. The user PF driver issues requests by
> writing command messages into this region. The management PF driver
> periodically polls the region and process any pending requests.
> 
> Supported operations include firmware (xclbin) reloads, where the
> management PF invokes 'versal_pci_load_xclbin' to reprogram the embedded
> firmware through the remote management queue service.
> 
> This service provides the foundation for dynamic firmware updates and other
> management requests from the user PFs.
> 
> Co-developed-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>

...

> @@ -160,10 +222,13 @@ static const struct config_item_type versal_pci_cfs_table = {
>   static int versal_pci_cfs_init(struct versal_pci_device *vdev)
>   {
>   	struct configfs_subsystem *subsys = &vdev->cfs_subsys;
> +	char dev_name[64] = "";

No need to init I think.

> +
> +	snprintf(dev_name, sizeof(dev_name), "%s%x", DRV_NAME, versal_pci_devid(vdev));

This hunk could already be in patch 1. This would make this patch smaller.

>   
>   	snprintf(subsys->su_group.cg_item.ci_namebuf,
>   		 sizeof(subsys->su_group.cg_item.ci_namebuf),
> -		 "%s%x", DRV_NAME, versal_pci_devid(vdev));
> +		 "%s", dev_name);
>   
>   	subsys->su_group.cg_item.ci_type = &versal_pci_cfs_table;
>   

...

