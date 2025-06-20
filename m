Return-Path: <linux-kernel+bounces-695419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C0AE1997
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8B0189E635
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42FE289370;
	Fri, 20 Jun 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="pCk3JC2i"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FF289353
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417674; cv=none; b=MzKgAjbGmjVX3R3AOe7AjSWbj2E2N7u5ltPwgbgjaE5GKPI2rMT8B08VbdnCSIPzoQztbBsEf9KzyYyFx2M85Y001uo+MqJVzBlDceIObuJK9o6i29DFjxIV81GjIFLvidyHNBXii2CGQiMuVi7vjvcWj/XnwHQcKIL4GrO9UFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417674; c=relaxed/simple;
	bh=5HesFEa+oG4aphhrLr+nJlzSqRvni+h3KcLsQ1xkANk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SXmouawLZxLVRWy6jklhyV1iSO+tVnkS4s98RI5d1TdejLWYENloj7bQLN2IH8DhpotAedQddLbHrsx2kMi+oxg49HASFU/BCvrEqfFBmEGUeL1QmHRCMYfkv7aagBsazzFb7k1zlIP65PWVtyKmdhHNG8K6Dk+nTMF6Wdh7XWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=pCk3JC2i; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adfb562266cso313938466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750417670; x=1751022470; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j56NnU+C4rZ3igsVwK0poqCyRvUi8MRY+wsVdUJRvmo=;
        b=pCk3JC2itRdrtMHpyl/KtfjpWU4/ubo3IODY1ZqbHYJub+ClHinzIsX3uYkPTr+Wkv
         HKO2JsK4TAtsFdWcVXv3OHo9ufi+3URf7L+R/Ssym+7xES/KvVRriZ+Zk+D3Ep5Q/5/4
         4jnfOjKDrCRQ8q9nDp82slDwXOixhgwOKXdgvgtc1etb+I85yn/uq2EK9vZGtVX2nuBU
         95wQxRuOJh0LRvU7e4dc2atXOAJAySSbqWrQXQX/ib23dH9+BH+rsCrNiJTljXt610VW
         HVmuHHppIuwAPJMX5aB2PE8mW1ztCMXNafL5JOc8rwzwlJBK5dujv7P2nqIgf1PuZgjc
         zoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750417670; x=1751022470;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j56NnU+C4rZ3igsVwK0poqCyRvUi8MRY+wsVdUJRvmo=;
        b=kq18itsUNh5RJ8a7A+C+sNvNX1chnq7l0hoALays9NCsA/J6RgcQ/yLyw0MWoqLzhE
         unBV1MEXUx5Yd5UZra6YyLxRyKPZnXgZaF7qW1/5VtwFJ5EYI1JwyOWGesTg2ydqhVhV
         pdrvI8/pEn9GV5B3VN+IqhrK8XV/QeciUHpF68F5s0FaerxMM/ArKzmMUM8XBL2+qirx
         4cQvWJdsA+etcenDx8bF5CJlouzATmhsvWHCX6u0b1G8Kpen/zUtAUZUr4OXB5udogHg
         IXZeNsdF2SO9+aV0BL3mwImh+laki+ENbseQRZq6U2CDPMR5TzUApWv/L8OitHWTVzR8
         59BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv+S3WCXuFKV+1My2AzNAOvnIrJzsstd8Ul72EFRD992Bz3h/VK8GIj6YCCeeHHUW98RivtVtRRyccVyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtgSkdu+o+QzJccIBK6yVBvoU5HjyCX7nrwskiyZcJNsTEH+n
	l9VtV8HMb/dm4zAY8KTOcVel11r9f46ng5RBY46a2BZ8mgC8jzcjkIaHYMjUh0Zbqxk=
X-Gm-Gg: ASbGncsT+7Zadm+ldm21Gy254QN37S9XRhyMb1qVv1ulDuSNVSMVTUgZPcBYjEV4UUC
	AEHNggnDTMBmYPWQOi4tfL7K/kcMMGrl9L+xIfqmTwb+jRGfYM+38bzZbr4UQ7yF7R9mgzGDDlH
	hBDVluC16PKIWluzTPmAc6Hq4QWpRA4y45BW7oEpnu/P84Eu9UMHR5OrGpg7kpuzXK3/37tQfhD
	CHi4rcBeg3+erge4qsr6MxiMeE8IxAKifs5VIi5bqVkexZEVaqdcAzGT/BWkC+I7YLBs6hjdbCA
	QkHpHxYc6Z1i49hsKfiDpO8vlhhsMZkB+FsQl3ZToFWEIX+62bZFbSyZS88pSKFBeayPXzPPewy
	5DTpauSdiK9BlgC9Gt26XZp2/g0M2RCU=
X-Google-Smtp-Source: AGHT+IHi2VbmsYUmEDnp9Sif2RGnVt1dOueBmIGckoT6F8WA4k68tCAYn7k5QT+Eg9xqzhehbqW5mA==
X-Received: by 2002:a17:906:6a03:b0:ad8:8621:9241 with SMTP id a640c23a62f3a-ae057c7eef2mr239743066b.54.1750417670525;
        Fri, 20 Jun 2025 04:07:50 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4c90sm147879866b.62.2025.06.20.04.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 04:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 13:07:49 +0200
Message-Id: <DARBA03BEQA1.3KLHCBFNTVXKJ@fairphone.com>
Cc: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] fbdev/simplefb: Add support for interconnect paths
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>, "Hans de Goede"
 <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Javier Martinez Canillas"
 <javierm@redhat.com>, "Helge Deller" <deller@gmx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250620-simple-drm-fb-icc-v1-0-d92142e8f74f@fairphone.com>
 <20250620-simple-drm-fb-icc-v1-3-d92142e8f74f@fairphone.com>
 <cf29862b-496b-4825-aa0f-493eb44838a5@suse.de>
In-Reply-To: <cf29862b-496b-4825-aa0f-493eb44838a5@suse.de>

Hi Thomas,

On Fri Jun 20, 2025 at 1:02 PM CEST, Thomas Zimmermann wrote:
> Hi
>
> Am 20.06.25 um 12:31 schrieb Luca Weiss:
>> Some devices might require keeping an interconnect path alive so that
>> the framebuffer continues working. Add support for that by setting the
>> bandwidth requirements appropriately for all provided interconnect
>> paths.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   drivers/video/fbdev/simplefb.c | 83 ++++++++++++++++++++++++++++++++++=
++++++++
>>   1 file changed, 83 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simple=
fb.c
>> index be95fcddce4c8ca794826b805cd7dad2985bd637..ca73e079fd13550ddc779e84=
db80f7f9b743d074 100644
>> --- a/drivers/video/fbdev/simplefb.c
>> +++ b/drivers/video/fbdev/simplefb.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/parser.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/regulator/consumer.h>
>> +#include <linux/interconnect.h>
>
> With alphabetical sorting:
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for the reviews!

For both simpledrm.c and simplefb.c, the includes are not strictly
alphabetically sorted (1 mis-sort in simpledrm, 3 in simplefb), shall I
just try and slot it into the best fitting place, or make them sorted in
my patch? Or I can add a separate commit for each driver before to sort
them.

Let me know!

Regards
Luca


>
> Best regards
> Thomas
>
>
>>  =20
>>   static const struct fb_fix_screeninfo simplefb_fix =3D {
>>   	.id		=3D "simple",
>> @@ -89,6 +90,10 @@ struct simplefb_par {
>>   	u32 regulator_count;
>>   	struct regulator **regulators;
>>   #endif
>> +#if defined CONFIG_OF && defined CONFIG_INTERCONNECT
>> +	unsigned int icc_count;
>> +	struct icc_path **icc_paths;
>> +#endif
>>   };
>>  =20
>>   static void simplefb_clocks_destroy(struct simplefb_par *par);
>> @@ -525,6 +530,80 @@ static int simplefb_attach_genpds(struct simplefb_p=
ar *par,
>>   }
>>   #endif
>>  =20
>> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
>> +/*
>> + * Generic interconnect path handling code.
>> + */
>> +static void simplefb_detach_icc(void *res)
>> +{
>> +	struct simplefb_par *par =3D res;
>> +	int i;
>> +
>> +	for (i =3D par->icc_count - 1; i >=3D 0; i--) {
>> +		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
>> +			icc_put(par->icc_paths[i]);
>> +	}
>> +}
>> +
>> +static int simplefb_attach_icc(struct simplefb_par *par,
>> +			       struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	int ret, count, i;
>> +
>> +	count =3D of_count_phandle_with_args(dev->of_node, "interconnects",
>> +							 "#interconnect-cells");
>> +	if (count < 0)
>> +		return 0;
>> +
>> +	/* An interconnect path consists of two elements */
>> +	if (count % 2) {
>> +		dev_err(dev, "invalid interconnects value\n");
>> +		return -EINVAL;
>> +	}
>> +	par->icc_count =3D count / 2;
>> +
>> +	par->icc_paths =3D devm_kcalloc(dev, par->icc_count,
>> +				      sizeof(*par->icc_paths),
>> +				      GFP_KERNEL);
>> +	if (!par->icc_paths)
>> +		return -ENOMEM;
>> +
>> +	for (i =3D 0; i < par->icc_count; i++) {
>> +		par->icc_paths[i] =3D of_icc_get_by_index(dev, i);
>> +		if (IS_ERR_OR_NULL(par->icc_paths[i])) {
>> +			ret =3D PTR_ERR(par->icc_paths[i]);
>> +			if (ret =3D=3D -EPROBE_DEFER)
>> +				goto err;
>> +			dev_err(dev, "failed to get interconnect path %u: %d\n", i, ret);
>> +			continue;
>> +		}
>> +
>> +		ret =3D icc_set_bw(par->icc_paths[i], 0, UINT_MAX);
>> +		if (ret) {
>> +			dev_err(dev, "failed to set interconnect bandwidth %u: %d\n", i, ret=
);
>> +			continue;
>> +		}
>> +	}
>> +
>> +	return devm_add_action_or_reset(dev, simplefb_detach_icc, par);
>> +
>> +err:
>> +	while (i) {
>> +		--i;
>> +		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
>> +			icc_put(par->icc_paths[i]);
>> +	}
>> +	return ret;
>> +}
>> +#else
>> +static int simplefb_attach_icc(struct simplefb_par *par,
>> +			       struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>>   static int simplefb_probe(struct platform_device *pdev)
>>   {
>>   	int ret;
>> @@ -615,6 +694,10 @@ static int simplefb_probe(struct platform_device *p=
dev)
>>   	if (ret < 0)
>>   		goto error_regulators;
>>  =20
>> +	ret =3D simplefb_attach_icc(par, pdev);
>> +	if (ret < 0)
>> +		goto error_regulators;
>> +
>>   	simplefb_clocks_enable(par, pdev);
>>   	simplefb_regulators_enable(par, pdev);
>>  =20
>>


