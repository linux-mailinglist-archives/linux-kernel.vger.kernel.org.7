Return-Path: <linux-kernel+bounces-899955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52FC5931A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828CE426A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87F35A14B;
	Thu, 13 Nov 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1mRz2N9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EC35A12B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053765; cv=none; b=MyDhWKSpW23Lktc99jUlkSeFYpGEU4epEMPQ5OtJv09VgjKLgOzA4cYf64V3j5H+Sgc2Oz3yAPj+2l7OZmN+hc77BLXgtgdpkkgPiruy25SqNWSd8XFGwhB2Iy75jqMufLpthfpkQYO9v4jhfRoAKICMky+aeIVWT5DNAcGpe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053765; c=relaxed/simple;
	bh=62vwBOP9yKsaKuZOOstUW2+mwhy4EqYVKW6wWSai3WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsJRQCpvTXv/wBYVbkjd+Xw/sPc+ZXmf0BQBdqpADIyIxiV9DkM7gXjzTypXxo2fjCCevg2tIucUCC+uN9/xYKkLgzQikc4F5hN6dgqp7SoK9aAZUJUskD5z0567WBLL0dHze/qniS1hmWr12zSy9mXruxxcCalwOgJfbY9Px3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1mRz2N9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763053762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7WJhtLVedGmTm5Wrszczo4emoT5IEM0tAgaV+QfK+0=;
	b=D1mRz2N9nL3UGQ9c3YTMYRoIGyA4hgMNM9gRa4OtJsIUrArPWLmdE7MP3Ey/tkcxUQqq0t
	HZs39CNijMngUle4yYQfTcc6GcFwHE9xj0fMSyG2Y4QFnTtf1b3cSygJWw41v8X+1EUfjx
	2cIfvOeOAzp7EQgr6ow9mtIwFvR6zFI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-g_Qt6dFGNnSiilkrFUvtVA-1; Thu,
 13 Nov 2025 12:09:17 -0500
X-MC-Unique: g_Qt6dFGNnSiilkrFUvtVA-1
X-Mimecast-MFC-AGG-ID: g_Qt6dFGNnSiilkrFUvtVA_1763053755
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62C7D18002D7;
	Thu, 13 Nov 2025 17:09:15 +0000 (UTC)
Received: from [10.44.32.61] (unknown [10.44.32.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D179C180049F;
	Thu, 13 Nov 2025 17:09:10 +0000 (UTC)
Message-ID: <018e3129-e367-4637-8892-7eb83dcae40f@redhat.com>
Date: Thu, 13 Nov 2025 18:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dpll: zl3073x: fix kernel-doc name and missing
 parameter in fw.c
To: Kriish Sharma <kriish.sharma2006@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112055642.2597450-1-kriish.sharma2006@gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251112055642.2597450-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/12/25 6:56 AM, Kriish Sharma wrote:
> Documentation build reported:
> 
>    Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
>    Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead
>    Warning: drivers/dpll/zl3073x/fw.c:365 No description found for return value of 'zl3073x_fw_component_flash'
> 
> The kernel-doc comment above `zl3073x_fw_component_flash()` used the wrong
> function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` parameter.
> This patch updates the comment to correctly document the
> `zl3073x_fw_component_flash()` function and its arguments.
> 
> Fixes: ca017409da69 ("dpll: zl3073x: Add firmware loading functionality")
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
> v2:
>   - Added colon to fix kernel-doc warning for `Return:` line.
> 
> v1: https://lore.kernel.org/all/20251110195030.2248235-1-kriish.sharma2006@gmail.com
> 
>   drivers/dpll/zl3073x/fw.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
> index def37fe8d9b0..55b638247f4b 100644
> --- a/drivers/dpll/zl3073x/fw.c
> +++ b/drivers/dpll/zl3073x/fw.c
> @@ -352,12 +352,12 @@ struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
>   }
>   
>   /**
> - * zl3073x_flash_bundle_flash - Flash all components
> + * zl3073x_fw_component_flash - Flash all components
>    * @zldev: zl3073x device structure
> - * @components: pointer to components array
> + * @comp: pointer to components array
>    * @extack: netlink extack pointer to report errors
>    *
> - * Returns 0 in case of success or negative number otherwise.
> + * Return: 0 in case of success or negative number otherwise.
>    */

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


