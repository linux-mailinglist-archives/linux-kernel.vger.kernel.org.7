Return-Path: <linux-kernel+bounces-899747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FCFC58AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0E4635B720
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559D35A120;
	Thu, 13 Nov 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F34EFOJo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053A3570CA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049840; cv=none; b=TnljMXP0DipQAvxJ2DXX+atyd6Uj9S9r5/pKanX8Q+WQ62T3uOf/Yggrg0tAzjZ1DuUfp73ttCZFYKPY1kH8iORIdQ6IE4WKTS0j8T8pe9ko3/hd6XDOfum9Knu5dIwB0qcuXCZjTbnxaln/6k9KWXGXR1UNSFaFcJWPBbhjI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049840; c=relaxed/simple;
	bh=QYMLZLa57DsA3oH9ggb5b2PWktdx3uDRLUyqm4pJcmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZg+f9nEXm/oCQq5Ryk2WFuKBEM/tLp8/8FRvhdpBDe8T+PrJycCOZJ75BPpjAPH6gKM6YhRRgUK0RRn3/5TdlNTl//qz+/RFTKMCrn25rwMWi82wjEM5mSEQDJAPxUbs7smVmXpTAdeMrTssuqh6tA75WrMDUHjqtGHvIKJyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F34EFOJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F51BC116D0;
	Thu, 13 Nov 2025 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763049839;
	bh=QYMLZLa57DsA3oH9ggb5b2PWktdx3uDRLUyqm4pJcmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F34EFOJodSNkdDeCQDbX66r2XCXrMm1a6kzxtOej8ZvKeMBTxWjY/AClDZAuGHovg
	 KgLWxhbboL2CGf5pnM82R4g670qHeR972yRTo6qtoifOwSr24qR54TWVz2hsugm3Pj
	 lqnoHsLaCBv48YhLGMzp+VkN7VaUkX2J2hqwh3Eb0IBcBzOMUiEhf9V0C58QN4RLOL
	 Ldc4vxHoW2KWjVEn8PFk50NPcLBt8n+4pfs96yi+XiS7qjU4DH8yt87x9CYBuSMNNd
	 OaW1Vda5pZAW23c19IWNPMNjwj1rHsx0TCgP05ZFbfoovNdXc1xTpBi3Dh8YMyJj7h
	 OdSvJMsk/M0Lw==
Date: Thu, 13 Nov 2025 16:03:56 +0000
From: Lee Jones <lee@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mfd: qnap-mcu: Add proper error handling for
 command errors
Message-ID: <20251113160356.GN1949330@google.com>
References: <20251105234704.159381-1-heiko@sntech.de>
 <20251105234704.159381-5-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105234704.159381-5-heiko@sntech.de>

On Thu, 06 Nov 2025, Heiko Stuebner wrote:

> Further investigation revealed that the MCU in QNAP devices may return
> two error states. One "@8" for a checksum error in the submitted command
> and one "@9" for any generic (and sadly unspecified) error.
> 
> These error codes with 2 data character can of course also be shorter
> then the expected reply length for the submitted command, so we'll
> need to check the received data for error codes and exit the receive
> portion early in that case.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mfd/qnap-mcu.c | 65 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
> index cd836bdd44a8..8c5eb4a72829 100644
> --- a/drivers/mfd/qnap-mcu.c
> +++ b/drivers/mfd/qnap-mcu.c
> @@ -19,6 +19,7 @@
>  /* The longest command found so far is 5 bytes long */
>  #define QNAP_MCU_MAX_CMD_SIZE		5
>  #define QNAP_MCU_MAX_DATA_SIZE		36
> +#define QNAP_MCU_ERROR_SIZE		2
>  #define QNAP_MCU_CHECKSUM_SIZE		1
>  
>  #define QNAP_MCU_RX_BUFFER_SIZE		\
> @@ -103,6 +104,47 @@ static int qnap_mcu_write(struct qnap_mcu *mcu, const u8 *data, u8 data_size)
>  	return serdev_device_write(mcu->serdev, tx, length, HZ);
>  }
>  
> +static bool qnap_mcu_is_error_msg(size_t size) {

Looks like you forgot to run checkpatch.pl.

> +	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE);
> +}

[...]

-- 
Lee Jones [李琼斯]

