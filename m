Return-Path: <linux-kernel+bounces-807437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B0B4A459
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6778F161145
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E713623E330;
	Tue,  9 Sep 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E8q8FRDV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF423D28F;
	Tue,  9 Sep 2025 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404658; cv=none; b=E0FUXYTP2hoRgRmkN7sZVg/UoEwUXKphDnuvlBn/58tp5/JV+/M3xwjw2rPbESeY5nc0tZKeDRRQR4HMJLTITHqJjzpbP+9PY83QZcFATvRbbuVvyX8iYMKWfLOPs4qCNKcOLvF+xl2d6ZueQ1ce2xbNrJuHY9OqDCQ9b6gaoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404658; c=relaxed/simple;
	bh=qm3LS10YHRxt9quI/Qo6hL5jG84UNY+SDIgxgVif46g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MP+Rg1YvqkwRkMN8k324Hu6Wr8AQJqEkYOv/fzDG9EcGoVwDR4TmchvE3DTyYFNrkj/3VWy5EoKEOSvvRy+uSHmTBdPuxZ0bBnv1LBx4heUmP9Znpk73qlZsiAxZGBOIYJYt6ntXsHb0htTxC4B/Fpjo/pehnmhDJvSSljTRD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E8q8FRDV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757404657; x=1788940657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qm3LS10YHRxt9quI/Qo6hL5jG84UNY+SDIgxgVif46g=;
  b=E8q8FRDVUHU12TeLjC1qNf/Wd5SG7AwuT0aKxqg3hsBI3RSJwisCgeWv
   BjSWJgXZgTtgrPyWll2zROsfejqezqyNVnNyalw9oAFebXwkK0SEmidxh
   YZDj7I9yaDfAp3L6NrfGwbw5CTqaxUWftUPPkaktxqhenYjG8nJPHBQOI
   mjYb9+CmrhKGa95rchEkSCsGh+jKcZ6Yc2roAgRAOnZxiv0LrhYap/UbE
   W8XtNy0MJfEyZa99ZPk+LOn4tIuzlJYBBQgA+AuhhU4CTcN6YGovauEsG
   g918Sn9ikMqPzN/Tj6jeGeASFbmAxdgdEjEW98kpwXQ+w3V65f8EEh6kR
   g==;
X-CSE-ConnectionGUID: f8P1Im/fRVySCUAONR6ZKw==
X-CSE-MsgGUID: T2hDNvzEScuV+KHAEOG2ug==
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="277623849"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 00:57:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 00:57:19 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 9 Sep 2025 00:57:18 -0700
Message-ID: <1882cb12-cb65-423a-bacb-3965ba845ab3@microchip.com>
Date: Tue, 9 Sep 2025 09:57:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: at91: clk-master: Add check for divide by 3
To: <Ryan.Wanner@microchip.com>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250908200725.75364-1-Ryan.Wanner@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250908200725.75364-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2025 at 22:07, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> A potential divider for the master clock is div/3. The register
> configuration for div/3 is MASTER_PRES_MAX. The current bit shifting
> method does not work for this case. Checking for MASTER_PRES_MAX will
> ensure the correct decimal value is stored in the system.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Ryan, regards,
   Nicolas

> ---
>   drivers/clk/at91/clk-master.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index 7a544e429d34..d5ea2069ec83 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -580,6 +580,9 @@ clk_sama7g5_master_recalc_rate(struct clk_hw *hw,
>   {
>   	struct clk_master *master = to_clk_master(hw);
>   
> +	if (master->div == MASTER_PRES_MAX)
> +		return DIV_ROUND_CLOSEST_ULL(parent_rate, 3);
> +
>   	return DIV_ROUND_CLOSEST_ULL(parent_rate, (1 << master->div));
>   }
>   


