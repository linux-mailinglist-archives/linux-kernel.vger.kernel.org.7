Return-Path: <linux-kernel+bounces-865433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA10BFD141
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18AC134FCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F07355808;
	Wed, 22 Oct 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PwJOtivQ"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50CA355033
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149284; cv=none; b=uOhjvqPODCKnz9dS6eamR6rgq+6PxuvOqqanByQSAWPpQ0A6gdofS/PakP/YRODa0Nv73DxshMY90vFR3arXcwv6EyqUFE6n8I6uDysvYp2hC19H67g79Vd/1HrDBgmTso6ab/TWYq4pi3qje1QxYSbu2mMNLowqNOXelLPaGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149284; c=relaxed/simple;
	bh=TsD+grCOxlzH/k/6mHFonzAdSvAJLYW4bNco7+io1IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Df3bX4xSNWs2vUDttWD8HvV6YePeP9+6oRxQJxljTljS4g7DZdNbgUVZnxk4g/DKMx+6Ch29NingJFscf5W5HqybyZiKPVhVSv4yWRZ8NflbInbFYZem1AtBYc8o+d9FZMOwyAaFrEBYIgpyG3WPlnEXIBrQJbL2opL5SHq9+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PwJOtivQ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MG80Fe1444623;
	Wed, 22 Oct 2025 11:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761149280;
	bh=GCnA1PbWHQAnShdd75Du7TUN5nyvHfWj64Wobh7RZvY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PwJOtivQxakWmuY9a++1cNcAA+VIHnLfjy0qV5On/7i/VlE4Q0cFGji6LBzebTWRx
	 EEdBcy2J3M9+xo8TIWircNTkH14y6CNOuU+eyu2iFOxoeQXZwufIGp80puJ9m337Ng
	 H0PP20vByw53qVrqbFiTnKzk24hw3BkhpPYVf3HI=
Received: from DLEE201.ent.ti.com (dlee201.ent.ti.com [157.170.170.76])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MG80lL2047432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 11:08:00 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 11:07:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 11:07:59 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MG7x1u1476165;
	Wed, 22 Oct 2025 11:07:59 -0500
Message-ID: <40726a57-35a9-450d-ba0f-879313f60732@ti.com>
Date: Wed, 22 Oct 2025 11:07:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before
 entering suspend
To: Beleswar Padhi <b-padhi@ti.com>, <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC: <hiagofranco@gmail.com>, <hnagalla@ti.com>, <u-kumar1@ti.com>
References: <20251022102015.1345696-1-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251022102015.1345696-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/22/25 5:20 AM, Beleswar Padhi wrote:
> There may be pending messages in the mailbox FIFO that are not consumed
> by the remote processor for various reasons; the remote processor may
> already be powered off or may be in a bad state. Instead of aborting
> suspend because of these pending messages, flush the FIFOs and proceed
> with suspend. Pending messages could also be restored in the resume
> context, but since remote processors are typically rebooted during
> suspend/resume today, there is no point in restoring stale messages.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   drivers/mailbox/omap-mailbox.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
> index 680243751d62..5e6373911630 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -341,13 +341,10 @@ static int omap_mbox_suspend(struct device *dev)
>   	if (pm_runtime_status_suspended(dev))
>   		return 0;
>   
> -	for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
> -		if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
> -			dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
> -				fifo);
> -			return -EBUSY;
> -		}
> -	}
> +	/* Flush out pending mbox messages before entering suspend */
> +	for (fifo = 0; fifo < mdev->num_fifos; fifo++)
> +		while (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo)) != 0)
> +			mbox_read_reg(mdev, MAILBOX_MESSAGE(fifo));

I'm still not convinced just throwing out messages is the correct thing
to do here, but for now at very least let's print some warning here when
messages get zapped.

Andrew

>   
>   	for (usr = 0; usr < mdev->num_users; usr++) {
>   		reg = MAILBOX_IRQENABLE(mdev->intr_type, usr);


