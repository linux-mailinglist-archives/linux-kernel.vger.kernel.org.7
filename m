Return-Path: <linux-kernel+bounces-873005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE8C12D18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 786AD4F948D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4006288C3D;
	Tue, 28 Oct 2025 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oif/PkD3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AB2882B7;
	Tue, 28 Oct 2025 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623840; cv=none; b=BsJ50gjoxMtgLGl2lLTInG1EK6+Aa547KZkNpvj242sDs7hVskh8FiD2RYjp4hHeVNf8Zxh9Nsk8WWlx3F3KSV684Df0fOEkXa6+pUyjF5sqhL9U2o6sL7W9xL6bPXYz0Eubx9gA/lKR6sLmActJWWbOT+dK0tsVBeXT2CGYiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623840; c=relaxed/simple;
	bh=E/V2G9/zyjIrU1Yw2R5c9sWezrJUVjL8R1ze99nRLz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+f0MRIEhIz+8cQ6LVgiSf5zldEbJEJJxukbYsldjP8N+NIgFhEcm+BAkzc9JWyV6ah/qnvIfRsOgPTTMA8sXADRSbWu5+IcjZBWOGLGA34tcXVgzfzqqtvF3TdAISXrC8NZ9wJ7/f5nP46UTtTx6LlOPej6BtMSt6cljzK9PFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oif/PkD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98800C116B1;
	Tue, 28 Oct 2025 03:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761623839;
	bh=E/V2G9/zyjIrU1Yw2R5c9sWezrJUVjL8R1ze99nRLz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oif/PkD35wqGCyy0HXx9X0nYNWJqGyuHD9l6H1swXx4xMexQLrfEWzYI3uRA5X8XO
	 zdG+P5FvOGe0/dilKGs9Fzv7pMiv5E8ogmzuq46/n7AbnH45W3Ur4pnRGxs8/F/rUi
	 KCN/Z1O63FNrovo05jH3zqo2rgDmTel0ZpVO3qD80lcbA3ofrFNHZSktNLezPPPDfU
	 JAgoCwHwrN+4DCu6CuTxiq8P8VKij5Zkl7+/CsZPawh/yWXsE/9cu9MoLE+7fQoSMU
	 eo1g8aDRG4iKKDXU2spIoV74D2z4OiThtrXKYvkKlbEgyfWa4q+FeeXnVZGfHdFuzF
	 9US3IL3NY+s1A==
Message-ID: <9f63d117-2bb2-453f-8c93-0cc3ea5c90ca@kernel.org>
Date: Tue, 28 Oct 2025 12:53:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] scsi: sd: Add manage_restart device attribute to
 scsi_disk
To: Markus Probst <markus.probst@posteo.de>, Niklas Cassel
 <cassel@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251027202339.1043723-1-markus.probst@posteo.de>
 <20251027202339.1043723-2-markus.probst@posteo.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251027202339.1043723-2-markus.probst@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 5:23 AM, Markus Probst wrote:
> In addition to the already existing manage_shutdown,
> manage_system_start_stop and manage_runtime_start_stop device
> scsi_disk attributes, add manage_restart, which allows the high-level
> device driver (sd) to manage the device power state for SYSTEM_RESTART if
> set to 1.
> 
> This attribute is necessary for the following commit "ata: stop disk on
> restart if ACPI power resources are found" to avoid a potential disk power
> failure in the case the SATA power connector does not retain the power
> state after a restart.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

One nit below.

With that fixed, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +static ssize_t manage_restart_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct scsi_disk *sdkp = to_scsi_disk(dev);
> +	struct scsi_device *sdp = sdkp->device;
> +
> +	return sysfs_emit(buf, "%u\n", sdp->manage_restart);
> +}
> +
> +

One extra blank line not needed here.

> +static ssize_t manage_restart_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct scsi_disk *sdkp = to_scsi_disk(dev);
> +	struct scsi_device *sdp = sdkp->device;
> +	bool v;

-- 
Damien Le Moal
Western Digital Research

