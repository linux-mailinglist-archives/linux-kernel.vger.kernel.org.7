Return-Path: <linux-kernel+bounces-727094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7112AB014EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FA71C245E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DCC1F30B2;
	Fri, 11 Jul 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nYaYZVfm"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA11EFFBB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219830; cv=none; b=SjCGH/Ku6oPWQGJ7SKt86eIHMOzmcxddZJIkEC9B/QyldaBuuPhqqKLKOB4mQiHnaClRc93PH2T4Zn1/DTxgowE9gURfbbo87DYorHGEFUBD98kMjuxQaeZ/vtRESW0t+3SThs9bPCKooPSNe5J+FwFCBkF5a0makCBGudskf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219830; c=relaxed/simple;
	bh=CeWd6R0BO1sCTLl4uPfwyEIiA1cWcbzfMdI5RwEd9jE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WpfVrLz3bISLTREjq4GXefvmlC6ILSAkiGplYseTUeq1pV+n/f7nroScZ1+zseXlQd0HfLXqGtpi+TnLVTjzk0EeLLQAbXA89K7B3VSIlw49ID1QjwDvnWDplqjEYEXpnXiMzEDkji6qgtBno4oO2RHdufCCE7KpTWISZulooQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=nYaYZVfm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae36e88a5daso356373466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752219827; x=1752824627; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IIaUlC/iOoJ+QVPC0O3jLr9bGCpNKQPquWiGz3IsOM=;
        b=nYaYZVfmbWx9dQNXbLHrnfVH1lfkbxH2xTDw/rgUr9U9x5DmgidnNP1BuwkoCURpyP
         jcomr4Vt0lNWCC1i4lJvns4c2eES1+5CLloGzKYhzM+3Qm/no+NUqfRxV1jWDK8T3l5K
         mubRBba+O7sZ+3cErT5Z2iktaePg6wswX0OLyuD1OcIY5Gc8wnlbYdFAYt8TpbvsAZha
         d55IH+dS1BiaoZCw8W0OpIwRPg56I8i5vZ2v7Lo4MORSbQ7hCtkE1bIAsordtv8Kq3Kj
         Dfvc4RGAyGs2VWersRxTzcWIjXIn9JptF6DH0dzxQ/OvW3nl6y9rdteSNZWV1LlP5CY0
         nrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752219827; x=1752824627;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3IIaUlC/iOoJ+QVPC0O3jLr9bGCpNKQPquWiGz3IsOM=;
        b=qXvdVteuiK9UW6KiNRcPRZtGrgHTE9YoDRFNxhukQwtm2PCqEy91NcnjqEhLIsh9eX
         J8e7EY+TSYXEurCDomIRFq7MjJBOFNogve5rY413Vpo7REWiMEVi1G+ytH136PQwItFU
         ZndD52bHwqBxX46zw0aLjNqcCNbBI2zarcA+K3c5BXoZ3s/53ehLPOBfUb+/zMERIe0F
         +7gaThUzmu1tiXXTG8HcVZ6G6rKpkVWHrFmW2vW5Wi5WwX8eNIOR/1eKdehLnyYIeZEA
         RiXsVIWD9qbwIE2E/Q77FeHsWmdajCmBxHRLxV+fS9atqhK0osmp4EKFQ02GJEm1BGeu
         X+hA==
X-Forwarded-Encrypted: i=1; AJvYcCVIICrF6K/42tK9qypolHu33bg/WxcerAdqJ16/hIGDYVJ67+w0w4dQ5j55bsXLglQgrT1rJAhX5tT9zyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF45bf8VMVqlkhr/I+ekaCD0h+LRRM1m/RUzWwwb+QC+jBe9/2
	a2gsQP9MJ8Ns7tvLawayojGzsEQ7hw3fyM9kMlPU6TR8JibQ7ZsR0JC9ydyH+H/hbKM=
X-Gm-Gg: ASbGncvRdnHqMuL5F0Uwc+vbs7Q2EhXcaIad3u9OnaYnKpMqHphMyH0zAKAU4PfwLKx
	UAgWmYrK0qOaTooIP/h8gwMkzoEVe7kiLWw1d5JCBZY+iu7UIXIcf9v9iOOWhZbm1EYvXvggYS8
	4ScD52Sq9KxgfZ4KqNbl+mTWobkko25z/3XJK7zU/RMNv8/jMYs9HEpJ1FBcjyvHE4ROMlqYXZO
	a30GZyyA2bPufcI5l9ZhG8mwopNH3rIYIOefsWk+OFKBTYdR75HE2Ojk2AvVCfkjjdNfwKGhAoZ
	tUrYJjqUVxLWo0DsTITyCX+VIODw9amBf0PeBrTKd8i8E81kqTFk4Sc16lt5H8/kGCd85KKZTuh
	ZHwouGVTNzzWSBDthtwDWH8yXx2rOs/Ld7zyfUlpFpatbZ5JXr+foyvNyGiHR1+0iXe8=
X-Google-Smtp-Source: AGHT+IFTYupbQy72RBvYwBS8ueAvzrjXrAehsUXPExTpFAM8Ni+N0B33aqtgCjScHufwI8X0ZAMX1g==
X-Received: by 2002:a17:906:fe0c:b0:ae3:5212:c906 with SMTP id a640c23a62f3a-ae6fbe13960mr253963566b.10.1752219827399;
        Fri, 11 Jul 2025 00:43:47 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c70sm259816466b.13.2025.07.11.00.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 00:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 09:43:46 +0200
Message-Id: <DB9237QHOXRU.JRJB8SPUX8RO@fairphone.com>
Cc: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for
 interconnect paths
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Hans de Goede"
 <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Helge Deller" <deller@gmx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
 <87qzz5d3le.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87qzz5d3le.fsf@minerva.mail-host-address-is-not-set>

Hi Javier,

On Fri Jun 27, 2025 at 9:51 AM CEST, Javier Martinez Canillas wrote:
> Luca Weiss <luca.weiss@fairphone.com> writes:
>
>> Some devices might require keeping an interconnect path alive so that
>> the framebuffer continues working. Add support for that by setting the
>> bandwidth requirements appropriately for all provided interconnect
>> paths.
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  drivers/gpu/drm/sysfb/simpledrm.c | 83 ++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 83 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/s=
impledrm.c
>> index 349219330314e3421a6bb26ad5cf39a679a5cb7a..47d213e20cab1dd1e1952867=
4a95edea00f4bb30 100644
>> --- a/drivers/gpu/drm/sysfb/simpledrm.c
>> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
>> @@ -2,6 +2,7 @@
>> =20
>>  #include <linux/aperture.h>
>>  #include <linux/clk.h>
>> +#include <linux/interconnect.h>
>>  #include <linux/minmax.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_clk.h>
>> @@ -225,6 +226,10 @@ struct simpledrm_device {
>>  	struct device **pwr_dom_devs;
>>  	struct device_link **pwr_dom_links;
>>  #endif
>
> Can you add a /* interconnects */ comment here? Similarly how there is on=
e
> for clocks, regulators, power domains, etc.

Sure!

>
>> +#if defined CONFIG_OF && defined CONFIG_INTERCONNECT
>> +	unsigned int icc_count;
>> +	struct icc_path **icc_paths;
>> +#endif
>> =20
>
> ...
>
>> +static int simpledrm_device_attach_icc(struct simpledrm_device *sdev)
>> +{
>> +	struct device *dev =3D sdev->sysfb.dev.dev;
>> +	int ret, count, i;
>> +
>> +	count =3D of_count_phandle_with_args(dev->of_node, "interconnects",
>> +							 "#interconnect-cells");
>> +	if (count < 0)
>> +		return 0;
>> +
>> +	/* An interconnect path consists of two elements */
>> +	if (count % 2) {
>> +		drm_err(&sdev->sysfb.dev,
>> +			"invalid interconnects value\n");
>> +		return -EINVAL;
>> +	}
>> +	sdev->icc_count =3D count / 2;
>> +
>> +	sdev->icc_paths =3D devm_kcalloc(dev, sdev->icc_count,
>> +					       sizeof(*sdev->icc_paths),
>> +					       GFP_KERNEL);
>> +	if (!sdev->icc_paths)
>> +		return -ENOMEM;
>> +
>> +	for (i =3D 0; i < sdev->icc_count; i++) {
>> +		sdev->icc_paths[i] =3D of_icc_get_by_index(dev, i);
>> +		if (IS_ERR_OR_NULL(sdev->icc_paths[i])) {
>> +			ret =3D PTR_ERR(sdev->icc_paths[i]);
>> +			if (ret =3D=3D -EPROBE_DEFER)
>> +				goto err;
>> +			drm_err(&sdev->sysfb.dev, "failed to get interconnect path %u: %d\n"=
,
>> +				i, ret);
>
> You could use dev_err_probe() instead that already handles the -EPROBE_DE=
FER
> case and also will get this message in the /sys/kernel/debug/devices_defe=
rred
> debugfs entry, as the reason why the probe deferral happened.

Not quite sure how to implement dev_err_probe, but I think this should
be quite okay?

		if (IS_ERR_OR_NULL(sdev->icc_paths[i])) {
			ret =3D dev_err_probe(dev, PTR_ERR(sdev->icc_paths[i]),
				      "failed to get interconnect path %u\n", i);
			if (ret =3D=3D -EPROBE_DEFER)
				goto err;
			continue;
		}

That would still keep the current behavior for defer vs permanent error
while printing when necessary and having it for devices_deferred for the
defer case.

Not sure what the difference between drm_err and dev_err are, but I
trust you on that.

Let me know.

Regards
Luca

>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>


