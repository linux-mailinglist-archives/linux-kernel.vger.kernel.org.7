Return-Path: <linux-kernel+bounces-832549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFCAB9FA46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6387A6713
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C66274FC2;
	Thu, 25 Sep 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GzwyHzTU"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12911272E4E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807886; cv=none; b=QftBQWjl4yJMs26CoKCboumxxe9uMvcUy5sVBB7K8fAl9dBi4y31g+BQ+dCRzVwi4FyI3N9Vt0TmlPAAZzYo4ks4ZVNPSCppt19UNtLwEvjQrxUVhLrBE+9TXRVbP/J4pcRm/k0rnZb2cKyRve+Q1LqCBf+qNU1c9Y44BjzcJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807886; c=relaxed/simple;
	bh=gRLtCn/9YLyB0zWqN8PZsgBFqGS4K+6T6CbzUaBFmU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rz8yieEYyNIdK2YDe6eSyiqRzpowflYio2I8LHJ/kMOE3+f/E1v4t5A9CRVLy69UCiN5kpMyijLfpComjqOznCYFG9PHaGLBWG0ywpiGx0hkLsU0eMEFyBk7z9lH7r6uuGm6OF/s0/L6LUbeh1v97gT44r4Jqhra/OctiNuAX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GzwyHzTU; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <977f1b63-1617-447a-8ef8-775662ad0827@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758807872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzbRKSk93f9Ztt0ubkW/2QbayTmgWgmgzFIGYPs3WjU=;
	b=GzwyHzTUM/8PxdEVH2O9dMuKgdnSm+lJ2RwLNb7nrKPh2uLFR17k3nizaOhBcYtWoQJb0v
	WhUpfEF2kku+dEyhgYUdx1ap358cUvkIQBOXzedxKbc9ImbAwszumhhYyXUTorFUYrwU6k
	ev5wyE/T8vn5kmN3PRJInKZTiPAL300=
Date: Thu, 25 Sep 2025 14:44:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
To: Dan Carpenter <dan.carpenter@linaro.org>, Ivan Vecera <ivecera@redhat.com>
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aNVDbcIQq4RmU_fl@stanley.mountain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aNVDbcIQq4RmU_fl@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/09/2025 14:28, Dan Carpenter wrote:
> The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free() and
> the caller, zl3073x_devlink_flash_update(), also calls that same free
> function so it leads to a double free.  Delete the extra free.
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

