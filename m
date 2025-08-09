Return-Path: <linux-kernel+bounces-761103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B77B1F46D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D014624E6C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF3274B34;
	Sat,  9 Aug 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgsZwyc1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3071C8612
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754740117; cv=none; b=ftk/f/lvVxiPYkHLK3HKL52eAnHvVKYgUv6XUmJyLZz9lvSrur2dpao1PZzgJ9MRyK6pZs1RQDypD/IoSGjti5Pbgxa0ryskXfNh16pIWqyxL8iI97GCShX8ugnCELkZsnLMxbTmnjvpfLLN13fGqitXqYSo1bsD7RP5m50CmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754740117; c=relaxed/simple;
	bh=PX9MZaAM0+QR0JVll5Mbb3uPaWv1GoJ4uUmIN6eLKo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V03EM/bKuya/NjpLkFPbG0yvqR3kMAk91+c6SOj8jdkBvYzBhi48+MKoRCprtCWzZ+ZTDo6Fj+kyGfwKLa71zt3KJz/whUClial1E3cYCumcngCv9iF6yCv6IBj2nREbtyYYj7dQeiNAMd7nb5DPdMErLXA3fMv8MdlQmQrMruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgsZwyc1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754740114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EDDZnuKj0755GogAhCpvIsf+rm8EiRfLgn4JfYrMsU=;
	b=QgsZwyc1x7RjR1kDIQbGh0yKPNp7cjZpzW1Is3DN2T1Lh16qG2/dpbqdrTheFd719Lj6B0
	Lwnwlvgko9cqBqf+JaVQj6/T70Z2nqnCSruBlDx0HM9w9MTNuq/o2hYghK21vH6fwXwjxx
	TtcvfG9ZDB20XGI9UlMlmlfsxMilo1w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Zi6aipnNP0Cq5ZAGRWQv2A-1; Sat, 09 Aug 2025 07:48:33 -0400
X-MC-Unique: Zi6aipnNP0Cq5ZAGRWQv2A-1
X-Mimecast-MFC-AGG-ID: Zi6aipnNP0Cq5ZAGRWQv2A_1754740112
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-af911fc1751so189780866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 04:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754740112; x=1755344912;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EDDZnuKj0755GogAhCpvIsf+rm8EiRfLgn4JfYrMsU=;
        b=AWbBR/0yD1BhOzzksaPvPTbBPH/7/PR7PYwPYjG2/zK/aKobAR/YjrCLelIIQUho5Z
         5Zqk9I8mfUxkLGuXtRndXfEYmSwt7lkbbgp8RfmUaghx3jFI+5+/Hkg5UvkxRVps1UZV
         80OWXmbcQmqE2CP6df9HfEsOwE7vfCpSlZt11idKkNkpf5O8++e1zU1CPpIVbIep/N8I
         nVC5CMVT4PJLEJUUHt3qcr3yK98wjs4q9V2Kc/arpVlLlksVkosXwt+GO5pbNfOnlfZD
         CeCQjt176sr1UeygXvTMS59GEyUIBOdCSzhaXNJ0AEW6xKWGGlG5WSx6WxWVjUaxm0SH
         3DfA==
X-Forwarded-Encrypted: i=1; AJvYcCVLq16yr5ixjUcu93v62xx3Lj1s+natH++jzytu/w6dyBcoDxvpsF1senLHM1LK3Ti19kVgO7xkhlx/EPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwT0aaE0kVwX20X5VpZBWOwksGiJckHnJK3ESJ+YlKp2Ca2dnk
	zx5fEXyKDRBNHUpgo1bTiuH2ikgmbdt8Igd7WqZOb5jZypJq2ttBFfdh8ZkCJld07QvnhAX19T3
	ciQ/mvwQv0v47rq24vGNdFpP3cBn4iom24G0oC2N7uTV9/VxcYjqruL+9OPVMDbzeLg==
X-Gm-Gg: ASbGncuIAUSyYgIF9rmiBGAOATbtkjjEZ6ZgeV/1gGmgqvfuIHQyxe4WYmC7uBgdtC7
	vbO61XGEwaee2aEvHH6ecC/yM/y4k1AvCKkGS0fiblBG20rQbWiOop4Oh6l1Wh4bwPojIE0rMlO
	ZhW2ZGU6M2NMhRv+dKSLwNnR5oo92t+r4lkw5gOy/VWD/GMQf2DLHnRBIv4wX8Pd7wO+lt9Ydbt
	UmIKljGWigHk4W8R+lKsUsprPp/mB8zPoxA6eCtWVYJVKF1ek5bvNgbegPyBJ5aeE1Y25AbKcPg
	1/2wvjQ6/5pSdevKkxkL4MRW1gFynYmeM8inwW0YWZnIB3udT54qn6TdFPHBfYzBN+NCB1OeeGf
	pxci1ULkKO/OQUsWkOjShoJIvBi4iZV08fOtZSDbVCdF/52mrdYNd1FJsHa9OPXaXmR/Xukt3Fn
	RIJ7OBnSuPvgXH1oc=
X-Received: by 2002:a17:907:6d26:b0:ae3:60fb:1b3b with SMTP id a640c23a62f3a-af9c654451dmr618309566b.58.1754740111843;
        Sat, 09 Aug 2025 04:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcHoDyu59LmIlTnUYKnF1WKU80auy3Frrs4e9ro0Ni0EFHEbUF/59qTRw5C4WvAJV2ELm1aw==
X-Received: by 2002:a17:907:6d26:b0:ae3:60fb:1b3b with SMTP id a640c23a62f3a-af9c654451dmr618308666b.58.1754740111408;
        Sat, 09 Aug 2025 04:48:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ecfsm1646962966b.94.2025.08.09.04.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Aug 2025 04:48:30 -0700 (PDT)
Message-ID: <8da2d4b5-4e53-4c0c-84e2-16b5aee6d757@redhat.com>
Date: Sat, 9 Aug 2025 13:48:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: panel-orientation-quirks: Add Chuwi MiniBook X
 quirk
To: Ibrahim Burak Yorulmaz <iburaky.dev@gmail.com>,
 maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250809111200.10086-1-iburaky.dev@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <20250809111200.10086-1-iburaky.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ibrahim,

On 9-Aug-25 1:12 PM, Ibrahim Burak Yorulmaz wrote:
> v2:
> - Changed subject prefix to drm: panel-orientation-quirks
> 
> The Chuwi MiniBook X (CWI558) uses a tablet screen which is oriented
> incorrectly by default. This adds a DMI quirk to rotate the panel into
> the correct orientation.
> 
> Signed-off-by: Ibrahim Burak Yorulmaz <iburaky.dev@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans


> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index c554ad8f246b..c85f63c42bbe 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -282,6 +282,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Hi10 pro tablet"),
>  		},
>  		.driver_data = (void *)&lcd1200x1920_rightside_up,
> +	}, {	/* Chuwi MiniBook X (CWI558) */
> +		.matches = {
> +		  DMI_MATCH(DMI_SYS_VENDOR, "CHUWI"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MiniBook X"),
> +		},
> +		.driver_data = (void *)&lcd1200x1920_rightside_up,
>  	}, {	/* Dynabook K50 */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),


