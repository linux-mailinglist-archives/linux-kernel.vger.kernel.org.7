Return-Path: <linux-kernel+bounces-793517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC510B3D493
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492CE18977C1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96B2273D6D;
	Sun, 31 Aug 2025 17:15:07 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA21891A9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756660507; cv=none; b=HrX4wCAfZShejQ76uZSYh2W3dDb60KOiOQtOE59Bvqfh1iC23EdfGhuF+S7k4+KpomAAfBFn8t/IdEYDKWNmnM7o4czXRiaKFA3OOhLunXqbGvpX2alZNWeg0fHYV2LBtoM9h2ZPzGCCawohzMF0NChiAbqb+yoSo/Xog8d6qBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756660507; c=relaxed/simple;
	bh=txmcu7EzJIFWz+MxSovn4sCaBTDylBG9PZqS0NmcgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn1KE1luSVj+4qT5HnGMp8Q+o6FLYkkoVpDmtqQ28gAE6JIeeWXoSGerRL2O6SlX5cIkGmrFwofydxFUrK3Joueht3wsPAV74j0rUX9/OQLzFUH3EaDWCUc+fYu+IHNYPZ/GZWwOC3oIcMajQ3NGJvcs/BELvqkIDoBXKofCzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usldj-000000003Qc-1n39;
	Sun, 31 Aug 2025 17:14:51 +0000
Date: Sun, 31 Aug 2025 18:14:47 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
Message-ID: <aLSDB5ySaZv8yfHg@pidgin.makrotopia.org>
References: <20250831-mtd-validate-ooboffs-v1-1-d3fdce7a8698@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831-mtd-validate-ooboffs-v1-1-d3fdce7a8698@gmail.com>

On Sun, Aug 31, 2025 at 04:40:10PM +0200, Gabor Juhos wrote:
> Using an OOB offset past end of the available OOB data is invalid,
> irregardless of whether the 'ooblen' is set in the ops or not. Move
> the relevant check out from the if statement to always verify that.
> 
> The 'oobtest' module executes four tests to verify how reading/writing
> OOB data past end of the devices is handled. It expects errors in case
> of these tests, but this expectation fails in the last two tests on
> MTD devices, which have no OOB bytes available.
> 
> This is indicated in the test output like the following:
> 
>     [  212.059416] mtd_oobtest: attempting to write past end of device
>     [  212.060379] mtd_oobtest: an error is expected...
>     [  212.066353] mtd_oobtest: error: wrote past end of device
>     [  212.071142] mtd_oobtest: attempting to read past end of device
>     [  212.076507] mtd_oobtest: an error is expected...
>     [  212.082080] mtd_oobtest: error: read past end of device
>     ...
>     [  212.330508] mtd_oobtest: finished with 2 errors
> 
> For reference, here is the corresponding code from the oobtest module:
> 
>     /* Attempt to write off end of device */
>     ops.mode      = MTD_OPS_AUTO_OOB;
>     ops.len       = 0;
>     ops.retlen    = 0;
>     ops.ooblen    = mtd->oobavail;
>     ops.oobretlen = 0;
>     ops.ooboffs   = 1;
>     ops.datbuf    = NULL;
>     ops.oobbuf    = writebuf;
>     pr_info("attempting to write past end of device\n");
>     pr_info("an error is expected...\n");
>     err = mtd_write_oob(mtd, mtd->size - mtd->writesize, &ops);
>     if (err) {
>             pr_info("error occurred as expected\n");
>     } else {
>             pr_err("error: wrote past end of device\n");
>             errcnt += 1;
>     }
> 
> As it can be seen, the code sets 'ooboffs' to 1, and 'ooblen' to
> mtd->oobavail which is zero in our case.
> 
> Since the mtd_check_oob_ops() function only verifies 'ooboffs' if 'ooblen'
> is not zero, the 'ooboffs' value does not gets validated and the function
> returns success whereas it should fail.
> 
> After the change, the oobtest module will bail out early with an error if
> there are no OOB bytes available on the MDT device under test:
> 
>     # cat /sys/class/mtd/mtd0/oobavail
>     0
>     # insmod mtd_test; insmod mtd_oobtest dev=0
>     [  943.606228]
>     [  943.606259] =================================================
>     [  943.606784] mtd_oobtest: MTD device: 0
>     [  943.612660] mtd_oobtest: MTD device size 524288, eraseblock size 131072, page size 2048, count of eraseblocks 4, pages per eraseblock 64, OOB size 128
>     [  943.616091] mtd_test: scanning for bad eraseblocks
>     [  943.629571] mtd_test: scanned 4 eraseblocks, 0 are bad
>     [  943.634313] mtd_oobtest: test 1 of 5
>     [  943.653402] mtd_oobtest: writing OOBs of whole device
>     [  943.653424] mtd_oobtest: error: writeoob failed at 0x0
>     [  943.657419] mtd_oobtest: error: use_len 0, use_offset 0
>     [  943.662493] mtd_oobtest: error -22 occurred
>     [  943.667574] =================================================
> 
> This behaviour is more accurate than the current one where most tests
> are indicating successful writing of OOB data even that in fact nothing
> gets written into the device, which is quite misleading.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>


> ---
>  drivers/mtd/mtdcore.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5ba9a741f5ac3c297ae21329c2827baf5dc471f0..9a3c9f163219bcb9fde66839f228fd8d38310f2d 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1590,12 +1590,12 @@ static int mtd_check_oob_ops(struct mtd_info *mtd, loff_t offs,
>  	if (offs < 0 || offs + ops->len > mtd->size)
>  		return -EINVAL;
>  
> +	if (ops->ooboffs >= mtd_oobavail(mtd, ops))
> +		return -EINVAL;
> +
>  	if (ops->ooblen) {
>  		size_t maxooblen;
>  
> -		if (ops->ooboffs >= mtd_oobavail(mtd, ops))
> -			return -EINVAL;
> -
>  		maxooblen = ((size_t)(mtd_div_by_ws(mtd->size, mtd) -
>  				      mtd_div_by_ws(offs, mtd)) *
>  			     mtd_oobavail(mtd, ops)) - ops->ooboffs;
> 
> ---
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> change-id: 20250831-mtd-validate-ooboffs-e35c796540fe
> 
> Best regards,
> -- 
> Gabor Juhos <j4g8y7@gmail.com>
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

