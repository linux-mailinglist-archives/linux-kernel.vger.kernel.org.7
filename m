Return-Path: <linux-kernel+bounces-857628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D9BE74AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 959BF562ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557A2D4B4B;
	Fri, 17 Oct 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dV32Q4aY"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A22D1901
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691015; cv=none; b=p4zvqWAR0Pyy1iwQMsY/jKQ21frnoqxj0643PgEtRv4UuvOZMGSWjF18VgUmRHbxO69LNEgM3SLSteftLRf5CUtfkibU9oVueA7yx5T5tneuRlv8uZKofA16JlqtmKWCnkEtGcwkysYP4ENgDLjDIdYyICslZpWANjz0X/9iEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691015; c=relaxed/simple;
	bh=s1Yo82IJv4nrT4EzmA6HcScsGLMa+FQA2rYZSctawl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WApfEbWZWQUKy8E2mR/uN+U0R/HSOBCNMOqxAvNPgYIMSGmQFuRyiORXPwzSogfynrjCd9/k2f5r+fmAiW38K8b30FdD8uObg9SrZA9x3esl18nLR7kak8axp6N4Pox8hEh9pvgbJ31lRNBQyYiWUXYqRVqpZ8yUq0TSLStZ1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dV32Q4aY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B25344E4111B;
	Fri, 17 Oct 2025 08:50:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76AD3606DB;
	Fri, 17 Oct 2025 08:50:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95D3A102F233E;
	Fri, 17 Oct 2025 10:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760691009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=43pG8BQLKj+x3xmj3cNlrBF7tFn/hLhmRKzHB/XG16o=;
	b=dV32Q4aYnMf7iwy92cdrKVRoRlNzzYyDMW8PGFHNKguzEYPlmdJ4wxctojfIzdG/3HSggI
	SSIuEA8H2QRtIwZqkJSyHCF0z4ziL4gJmftYdkUZTJb9LcOBKy+PUK8keG5FDPxLN6LkC1
	933cQ1f2+ZxbsTwR+iek6cIGQkxlfa4V0ja7IYMe/uzcMfvCWyfutl2bReCpNd7nx2OoNo
	PZ7RVCB6bSs9JwX6LSf/7RVW+qvg31R5S+CyVE5fQQqpt4gxpQ557bDKNdysakHT5clII0
	51mHTxh1OqIBr6XBziRyGw6yrMOOvWt85XaE4TKl1CqqusrxTjGbC2iAGoPsAQ==
Message-ID: <1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com>
Date: Fri, 17 Oct 2025 10:50:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in
 ACPI
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, regressions@lists.linux.dev, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 apatel@ventanamicro.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Daniele Cleri <DanieleCleri@aaeon.eu>
References: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
 <aPFwPR2A0CN6k1Vl@sunil-laptop>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <aPFwPR2A0CN6k1Vl@sunil-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/17/25 12:22 AM, Sunil V L wrote:
> On Thu, Oct 16, 2025 at 02:47:40PM +0200, Thomas Richard wrote:
>> Hello,
>>
>> While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
>> noticed a regression. The driver does not probe anymore and I get the
>> following error:
>>
>> [    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
>> initialize FPGA common GPIOs
>> [    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
>> failed with error -2
>>
>> The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].
>>
>> I did a bisect and I found the commit which introduced the regression:
>> e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
>> to support nargs_prop")
>>
> Hi Thomas,
> 
> Could you please try with below change and see if it resolves the issue?
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 1b997a5497e7..43d5e457814e 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>                                        size_t num_args,
>                                        struct fwnode_reference_args *args)
>  {
> -       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
> +       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
>  }
> 

Hi Sunil,

Yes your change fixes the issue !!

Thanks,

Thomas


