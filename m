Return-Path: <linux-kernel+bounces-748494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C677B141D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6646189928D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD78275AE9;
	Mon, 28 Jul 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EeflzKPA"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F458275845
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726801; cv=none; b=V3ih5xUCfqqBSLpsvEy8qv0J0LhyvUA59Wpa7zLdiFn78VnLu7hi9hoElWHYCLZbdt6dxqp6ykcGQmj+vc4/3/xuKSvZxBxKRIiSdlmkt4NiaROTULbZ+z/dMvviIglUgkRzhp7Xp7IWoyuvWm/gVfbebMYhvkbqOp+u0x0ckwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726801; c=relaxed/simple;
	bh=il/QhipfBEq4/cqv82Ja6TDfBmoKE+cAq3Yb1Np2SQg=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn4VrSWEPIAiYmyoDXqakf70dg565dWbRB+pLmdTFitdQpoiO31D786u4HXcA43CJ6gMiO0Ixao0qmA9RgR5uKnUqoAsxbNchHz7MU1dpT9Vblho4Xl7EYNvgNsD1k0sw+3668Qy+ImFcjB65Ul5CuO8bNztq0iv5ijN1hyAVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EeflzKPA; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8e0762f77dso1641560276.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753726798; x=1754331598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8mJu2jBxqHi2fp95J81Eq/pXT5MvZnjDzoISuAoq5s8=;
        b=EeflzKPAF8qdd2rPudxoCk8tCS7qUj/kGvKmkp6JvMk/rk8ey8lrIS7RtmW5oqSGS5
         8FH8DfxkqDLMDun7wuOKM5KRtp/4sLHQsCytfmwINm/P2+zdlYsq5omUFpQrThb9cggN
         KY10Z9JKqx0bcyTseykrg/iv3e8PNq+nOpGv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726798; x=1754331598;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mJu2jBxqHi2fp95J81Eq/pXT5MvZnjDzoISuAoq5s8=;
        b=FNxoeF6VB4OtmsHuOSr0QkzA+SVhACyw+prG0ai+L0RkiVSIHgiRCdFzGHmgeOqphm
         8bdVK6oJgN7LLlA1ZbEN0KpmtBeeJkNvf90PcDI/WmFthX25i5+TWoXDwr9Cccry6aHj
         bg+Qnf7laJt3j/+rD0WLSejckqI4g7moUrOqd7VC/P32vM/Gc61DY3MOwdaK+ppx+pRZ
         qjjPyxlLHNYeOqe/iE1HOnD663hZh66T6Wgg1kAQ10/oUmM5HwpbNL8C8De6KV/9TfCA
         jAUTEab6xvU7fj0hWv3oX07vN/Fg/8pxWFIrZ3r0wP5Wh8nXwkvk88onPI1Xp1CuIOKN
         ONVA==
X-Forwarded-Encrypted: i=1; AJvYcCVDy5OQ7sn2RMeAhK5rdsF5bepST+KxL1qmx7S50sba38y0D9mViMWM9LjK8MCuq+elFlBZ9SU53D/RM1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0OAtt2jyr70uR0Tn95PKpUrupaRW2dQ4wj54HES+nX4zIszB
	0PjokluZ/qtTeP0FX50M8JZD5pOBz+fPIHktoqvLUnHmgTyVR9IVFQZmGJv8/zjSw1vDiK6Z4gx
	YC8qwcoPcwuk35R5EUr/sNMhh5UGQGojeAU7MgnUe
X-Gm-Gg: ASbGncvWStbGOYpucU6y1H8ufBWeVktYqneVmFIkFbJgHUKiVLL8MhDe8mWyA5Rl5Si
	gohngjr8xg5hwwy9Ot29hz8I7EjyZFkikMdh/x7gOL1t2UBStfWSGQ991piQACPIsNKsTeJiYxW
	MTNd9dFMrnL4ZSTvYriUVqtyxzMzx56Xahlz7zIc27PFWOLGuMUQP5kVhN3mvm41qlNy0T4LLpu
	uU2K5Cy
X-Google-Smtp-Source: AGHT+IE2c0jhpDuNUKfxsmeJAy2r+RNxQT+0tmJ08L8Z9ckA8VdP350Tpwcc4r/OO86nCwuJWgZjz72PhP1KrVRKg9U=
X-Received: by 2002:a05:6902:2302:b0:e89:86e1:ffbc with SMTP id
 3f1490d57ef6-e8df1233c23mr14317831276.24.1753726798104; Mon, 28 Jul 2025
 11:19:58 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20250718234504.2702128-1-oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <20250718234504.2702128-1-oreoluwa.babatunde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHaaC3+8dss2V7QO4GBdf8o1CwMhLRLBUkQ
Date: Mon, 28 Jul 2025 11:19:56 -0700
X-Gm-Features: Ac12FXyEMNUjpTsIjMVOLQB7ZpjEo5kL3JkRapfFIvnqbZF_n5dy7it1h3Sm2A0
Message-ID: <cacb181aa4bb6d181c2808d7e082319c@mail.gmail.com>
Subject: RE: [PATCH v2] of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>, robh@kernel.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, kernel@oss.qualcomm.com, will@kernel.org, 
	djakov@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dfdd1c063b015682"

--000000000000dfdd1c063b015682
Content-Type: text/plain; charset="UTF-8"

> -----Original Message-----
> From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
> Sent: Friday, July 18, 2025 4:45 PM
> To: robh@kernel.org; m.szyprowski@samsung.com; robin.murphy@arm.com
> Cc: saravanak@google.com; quic_obabatun@quicinc.com;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux.dev; william.zhang@broadcom.com;
> kernel@oss.qualcomm.com; will@kernel.org; djakov@kernel.org; Oreoluwa
> Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
> Subject: [PATCH v2] of: reserved_mem: Restructure call site for
> dma_contiguous_early_fixup()
>
> Restructure the call site for dma_contiguous_early_fixup() to
> where the reserved_mem nodes are being parsed from the DT so that
> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>
> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved
> memory regions are processed")
> Signed-off-by: Oreoluwa Babatunde
> <oreoluwa.babatunde@oss.qualcomm.com>
> ---
> v2: Add a check for the "reusable" property to narrow things down to
>     only cma regions.
>     Also add __weak function definition for dma_contiguous_early_fixup()
>     to avoid compile errors on architectures that do not define the
>     function.
>
>  drivers/of/of_reserved_mem.c | 21 ++++++++++++++++++---
>  kernel/dma/contiguous.c      |  2 --
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 77016c0cc296..eee96172883a 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -25,6 +25,7 @@
>  #include <linux/memblock.h>
>  #include <linux/kmemleak.h>
>  #include <linux/cma.h>
> +#include <linux/dma-map-ops.h>
>
>  #include "of_private.h"
>
> @@ -147,6 +148,11 @@ static int __init
> early_init_dt_reserve_memory(phys_addr_t base,
>  	return memblock_reserve(base, size);
>  }
>
> +void __weak
> +dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
> +{
> +}
> +
>  /*
>   * __reserved_mem_reserve_reg() - reserve all memory described in 'reg'
> property
>   */
> @@ -175,13 +181,18 @@ static int __init
> __reserved_mem_reserve_reg(unsigned long node,
>  		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>  		size = dt_mem_next_cell(dt_root_size_cells, &prop);
>
> -		if (size &&
> -		    early_init_dt_reserve_memory(base, size, nomap) == 0)
> +		if (size && early_init_dt_reserve_memory(base, size,
nomap)
> == 0) {
> +			/* Architecture specific contiguous memory fixup.
*/
> +			if (of_flat_dt_is_compatible(node,
"shared-dma-pool")
> &&
> +			    of_get_flat_dt_prop(node, "reusable", NULL))
> +				dma_contiguous_early_fixup(base, size);
> +
>  			pr_debug("Reserved memory: reserved region for
node
> '%s': base %pa, size %lu MiB\n",
>  				uname, &base, (unsigned long)(size /
SZ_1M));
> -		else
> +		} else {
>  			pr_err("Reserved memory: failed to reserve memory
> for node '%s': base %pa, size %lu MiB\n",
>  			       uname, &base, (unsigned long)(size /
SZ_1M));
> +		}
>
>  		len -= t_len;
>  	}
> @@ -472,6 +483,10 @@ static int __init
> __reserved_mem_alloc_size(unsigned long node, const char *unam
>  		       uname, (unsigned long)(size / SZ_1M));
>  		return -ENOMEM;
>  	}
> +	/* Architecture specific contiguous memory fixup. */
> +	if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
> +	    of_get_flat_dt_prop(node, "reusable", NULL))
> +		dma_contiguous_early_fixup(base, size);
>
>  	/* Save region in the reserved_mem array */
>  	fdt_reserved_mem_save_node(node, uname, base, size);
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 67af8a55185d..d9b9dcba6ff7 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -483,8 +483,6 @@ static int __init rmem_cma_setup(struct
> reserved_mem *rmem)
>  		pr_err("Reserved memory: unable to setup CMA region\n");
>  		return err;
>  	}
> -	/* Architecture specific contiguous memory fixup. */
> -	dma_contiguous_early_fixup(rmem->base, rmem->size);
>
>  	if (default_cma)
>  		dma_contiguous_default_area = cma;
> --
> 2.34.1

Tested-by: William Zhang <william.zhang@broadcom.com>

--000000000000dfdd1c063b015682
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJg
MIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIN1OLQS9ur2EF0qdfokZGKH9DPuO
bRMQ4sKKi3QS80gjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDcyODE4MTk1OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAE/QD8/K4fj6DLt9wIc9FWkrGFN5TE4iximlt1a61oDPLDC6Jpy9OgsAAqYRsl9g
LWO0+OnPp5Iql7hwXrdmIn1eq6kwmC7IAGYaqQQNJ5lZtu41813DE5lNvAWnQOLxyNLOT/vaNjmQ
F/pL20r7vVQzIZfYf6ZRNr8vV0uVud111KICNQl0pD9mF7U+knTbi2LpSRPWhltvxd5+cERNshIp
x4VD8iTwnrb9WdSlQ5LxI3/CoEe148ucXH+/DgX8qJE2e9hY+xZXHgEFgSf0Z0SZfH1j1J89Jhfa
3BvuCjGFbSl8BbHx1lya5FseUe7iR4T2HXjyYQBg0HgGATgJoDE=
--000000000000dfdd1c063b015682--

