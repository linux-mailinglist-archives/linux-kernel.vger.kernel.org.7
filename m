Return-Path: <linux-kernel+bounces-727415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFCB019E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E14A27A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864AE286439;
	Fri, 11 Jul 2025 10:38:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6827A927
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230304; cv=none; b=DA3uefEPQMZlrDhr4HRZMM8OgkNkD8HQ8UvOwrB/qu8vOWE2n4fQo8FL0rHQQpp316eFGj/+1P/SSwA+XZRz8PU43nRJrZcTEa+06rgsomT2ijwcJn4UUCL91bwjw3SlpLztqA90SUMPD6is9ivoPAPaUXu/njHepWPVAlr6Dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230304; c=relaxed/simple;
	bh=cWHhjzKt4qPvWLnl8XQxbqaHPtDVx0LEvjOCFDqQxhU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZhfdJbXJ5Vr4bxE88qxhUUWdAqlkzNQt4aVYxbNd+dyDbzsaEsW8fmkfJeDFLcvejIudoNBWx+R+2gJFMNYeGa6etqDrLqIDFumWguUNZgGIISsDEFzN3SGslIingAENmhfJor4kTzDRnsiphoMsVNmZb7am5j8+eMF3OL1hmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdp7R62yrz6GC7K;
	Fri, 11 Jul 2025 18:37:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C31F1402EF;
	Fri, 11 Jul 2025 18:38:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 12:38:18 +0200
Date: Fri, 11 Jul 2025 11:38:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Huisong Li <lihuisong@huawei.com>, <linuxarm@huawei.com>
CC: <xuwei5@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>
Subject: Re: [PATCH] soc: hisilicon: kunpeng_hccs: Fix incorrect log
 information
Message-ID: <20250711113816.00003403@huawei.com>
In-Reply-To: <20250711063706.3121253-1-lihuisong@huawei.com>
References: <20250711063706.3121253-1-lihuisong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 14:37:06 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> The hccs_get_all_spec_port_idle_sta() will tell user which port
> is busy when firmware doesn't allow to decrease HCCS lane number.
> However, the current log prints the index of die and port instead
> of the hardware ID user perceived.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Maybe adding an example of a wrong print and how it is fixed to this
patch description would make the problem even more obvious?
Not worth respin for that though!

> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index 7fc353732d55..65ff45fdcac7 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -1295,11 +1295,11 @@ static int hccs_get_all_spec_port_idle_sta(struct hccs_dev *hdev, u8 port_type,
>  				if (ret) {
>  					dev_err(hdev->dev,
>  						"hccs%u on chip%u/die%u get idle status failed, ret = %d.\n",
> -						k, i, j, ret);
> +						port->port_id, chip->chip_id, die->die_id, ret);
>  					return ret;
>  				} else if (idle == 0) {
>  					dev_info(hdev->dev, "hccs%u on chip%u/die%u is busy.\n",
> -						k, i, j);
> +						 port->port_id, chip->chip_id, die->die_id);
>  					return 0;
>  				}
>  			}


