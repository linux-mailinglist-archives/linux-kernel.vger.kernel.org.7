Return-Path: <linux-kernel+bounces-772992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A603B29A40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11EE189682E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D9278173;
	Mon, 18 Aug 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SzMQDmWq"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C41487E9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500097; cv=none; b=fefoEf9LBgvoE2jGyQFWU4W29BHGpBrSrIlDe/s1zHIlO88+2V7iHXauev8Kdx48K0lCjQjfCy1lDCBBbWteZKtFg5AMplsiG9dX2+2QznT5RuU8la1C8qUSWXRBmUBpejMrEnzK63zE8eaKA5dmlntWA33ts4PU2Ts1c3nYcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500097; c=relaxed/simple;
	bh=PiRdQi2DNTOyWPjbp/n22ix0QwyXtFNXOR21zOCXrsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvawUvu/fbasW0N1PGmJBBVEuNtDAjI3YExm5zJMfthakZ5XgHTcdVrdopDrEk/jSm0R2LbLJ1RDmsVbuAMc2watkIapCZKImXwP8kJok3ues4C3PO+H4nXLz6d7FBmUSNQ+k6szUFe+HUFbzSaUtW8l2o4FTXupXXQY0tIOcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SzMQDmWq; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id ntkVuLsjrZ80pntkVuQAKL; Mon, 18 Aug 2025 08:53:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1755500025;
	bh=y1i4Ok6MNpfH7xDFQ14ItWKQD+IgHVNXWLSdzG0AENQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SzMQDmWq1fMPidsfbky5r+WvlhNQxqXcXBUcrWn8deWX3BhFCI6r7xpGV0KMnxIo6
	 IMEJyjzzb3aP6fVaNdgltHtCAe5snaN7OOQoIl7leo8UE/Jzf371UtU/0QKbTRR2k0
	 Piv+KxtZAK3r6Nn3IcZPCX20q8AP6GNZkZqc2JGQZTk0w1W0Xgh8lqUCtTsgY6OEhk
	 2Oks+MJVRi9RaRY4oR+wvcnc73XHCng/QhoRiO889PiUv7rQJdzexF8eUiBvxHOsDq
	 ml7q8LYN+6oAYmbG/wG2pfQ6JvCFoK1tvU4Gwht7Ro53MIYHevsC+lFnELP2kCkLH3
	 GrfuRO4pYVtrQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 18 Aug 2025 08:53:45 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <37faa705-4ea0-4dc8-a0d4-c26acf743c6b@wanadoo.fr>
Date: Mon, 18 Aug 2025 08:53:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: use str_plural() to simplify the code
To: Xichao Zhao <zhao.xichao@vivo.com>, joro@8bytes.org, will@kernel.org
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250818035331.393560-1-zhao.xichao@vivo.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250818035331.393560-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/08/2025 à 05:53, Xichao Zhao a écrit :
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Hi,

> ---
>   drivers/iommu/amd/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index eb348c63a8d0..b5c829f89544 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -265,7 +265,7 @@ static inline int get_acpihid_device_id(struct device *dev,
>   		return -EINVAL;
>   	if (fw_bug)
>   		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
> -			     hid_count, hid_count > 1 ? "s" : "");
> +			     hid_count,  str_plural(hid_count));

Nitpick: There is a double space after the comma.

>   	if (hid_count > 1)
>   		return -EINVAL;
>   	if (entry)

You should also include <linux/string_choices.h> I think.

CJ

