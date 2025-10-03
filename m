Return-Path: <linux-kernel+bounces-841406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E5FBB7380
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4CD84ED289
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5426E6E8;
	Fri,  3 Oct 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ELUZIbGD"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CC26E70B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502548; cv=none; b=RwPT7L0TCig2PL2lkstdxRh8sBlfpJywL6NYYqJdfODCo2p1ZAPDrgZLSHTqKmFTUw/2be0ijMhnYM51wkZyJrWB0pxfl+S+BGM9VbRByK9Re+1CQ95hVJS9OL54msmDYIFicdnoh6UFtTuV5t94BWEZWF+DPh8B/jXtfaOD7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502548; c=relaxed/simple;
	bh=WDzKhE28QuNRrlKua1JVDlDrpNBg4/HmEpjD9pTj6Wo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=skLiGF2AD4O4SMUX6ovTnUgYK0R7mh2ujeB29fHPh0Us4/Vg+27J+D9WJu6HQwaEcl2S3cOvaLAD6sX4nGc0BE9ngHGa01H2BzNr9gmWdFrsU+Om/vms/sr1IZnHQ7u3lbOidcCQxXmYhRV4sT/m7Ek8PJQOr4lIAw986tW1QBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ELUZIbGD; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759502534; x=1760107334; i=markus.elfring@web.de;
	bh=A41BSUqR2Q7Gz9/FMHcdj/oye62an2xQtKyuzIgBSdw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ELUZIbGDcdonUPsBfd3SwTYGyrecUFXSI4kB+c+fuYQ7aC5JyFUJNQGOUFBuxIM7
	 qA9GFG/KT9DDAP3RgMSLMilNu46pAKHZs8GZ3Qazar7cj9JBJ7T8B9d7XT+GvvX0Z
	 1ESfHCNkBD8GBfyNrNJLn2COcDaaLo7MvBmsvBHJQxC/yTm7Gd7V+GkOEj49tsdhJ
	 4nZQUP+q4I+cjvlVsUqHNMMcY15vor5Ug+qL0UqE62fUDTFCF8DlqSPN77lE4397o
	 A6D8L3hA1CL2Oykpzi0hC2C+kYed+ei7pLklyzjWeeN1oH57pG2UxkgLtpubxlGRE
	 OZAg5OmCLGbbUbxirA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.196]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6y1-1uUXDi3SXj-00mi24; Fri, 03
 Oct 2025 16:42:13 +0200
Message-ID: <1afdfccc-04f1-4f82-a1bf-bf93df42af29@web.de>
Date: Fri, 3 Oct 2025 16:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexandr Sapozhnikov <alsp705@gmail.com>,
 dri-devel@lists.freedesktop.org, lvc-project@linuxtesting.org
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20251002091844.11-1-alsp705@gmail.com>
Subject: Re: [PATCH v2] vgem: fix error return in vgem_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251002091844.11-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wb7aLHu6Ld4wqeXMWjvakHs10JDB59OOT8ILe0sKaXNhTCg+Q7V
 S565W3FL8583SnRoH7MZyQnfsFZu9Vo3MrjVZDMWeXXM7mS5Rcqo+B6K8g7MErXqh9cUMgb
 EyJANmLjahq+g+NKb8XYe85Y1ksttusYSDeqi3T4X3e9e0u6ZSaxkSk+DIw0fQnZLIj+jIZ
 724iD+oFcBUntRYSgNU8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YlayCNwK+zA=;3KFmwMJJREKX/xh8F3X889TPe8p
 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
 RkNqQ==

> The dma_coerce_mask_and_coherent function may=20
> fail to apply a mask due to incorrectly passed parameters.=20
=E2=80=A6

* You may occasionally put more than 61 characters into text lines
  of such a change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.17#n658

* Would you like to choose another imperative wording?

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?


=E2=80=A6
> ---
>  drivers/gpu/drm/vgem/vgem_drv.c | 4 +++-
=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22


=E2=80=A6
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -140,8 +140,10 @@ static int __init vgem_init(void)
>  		goto out_unregister;
>  	}
> =20
> -	dma_coerce_mask_and_coherent(&pdev->dev,
> +	ret =3D dma_coerce_mask_and_coherent(&pdev->dev,
>  				     DMA_BIT_MASK(64));
> +	if (ret)
> +		goto out_unregister;
=E2=80=A6

I suggest to keep the passed parameters in the same line for this function=
 call.

Regards,
Markus

