Return-Path: <linux-kernel+bounces-879952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D1C24781
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5A03B8626
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266791F5423;
	Fri, 31 Oct 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXQPnFrJ"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F52E8DF0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906731; cv=none; b=UIjOLUBzz8atJoks1PodoieGnQ02e4tzDsup8KMX/+Z5WNQHMiVbuDVK0AhmKh7qC+t8QUZzjcEDivsUdOkKaRKKYWCEdkM7+PsVr/ta6nVnJb67CMMq6heNAGI/MWXRpiGcyGUZ4LrGjiOYYM3bGzk2jWQ2hPFAb1V603YCtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906731; c=relaxed/simple;
	bh=gy+saDTlQayoKwFwRxm0cXA75jFfEVhJH4p23EiPWsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8wXmsALsAkPioQmgqe5lroTPWhwVsaoPeDlYLMAXkdRJXtChUPI9vJDCGOxU6sjXNZcL6kJHNxfIdzRy8wnjudSXrE24Ivzdhw/IU6+EAvgjnvioN9sYNd/9SJ6VGrdTcfNRGFefr1hwx0tM6c05Tl6ZX4r+n3KtJFuvaPFHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xXQPnFrJ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8906eb94264so251011985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761906728; x=1762511528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBHO5DkgwwLeTufaaCOE3ZnuCbkH/gU+aNGIgHEYT4A=;
        b=xXQPnFrJKX3JYrzixK3Zva1j/f+uATHF+16yeKKpyhSk+F39KipRmKlz4WmKzQqiu7
         H+m2joQsVVeAD/N87Z0KjTDv0ruw7+bhSNILbe3/x1f7s36Vv5faiUiLitaX6BPikgRO
         SKcBI0gJZYyKBFbfHqaYrFNoh5kTy3RN6T3HfSC5SMer0dIWxShQD2qVsecu34vPwMG5
         IINE/iKVOSij9RKYfyf91OszzKEveiwfjoTQy50Ik7agoxFdW6uN0GIJKd2OMGrMymDC
         yA02PtxmSjlmZj9PKPMR9NImqkEfUNLeA3ajm1TnTl4wKoDWoQ/KKDvRDtpZaoVOQtZP
         MnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906728; x=1762511528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBHO5DkgwwLeTufaaCOE3ZnuCbkH/gU+aNGIgHEYT4A=;
        b=p5MmeJRd9JsFHL0/Wx7cQAxV5jBE6EHKtoNWnfGN53kV4jsCl+J+KnDeR+wYTYq0/4
         eVSOkwS+xxWQlA7YrDsdPSEygPiS/69dBx1LQHi4yeRVmGQx7Xe1AK4rraRlVhEFFlX1
         n/t5IJgc2DX9CCaGavsV0H9CfOYyYqeQ0d6IyqXUnooUHScmeVZCmqUzR7vqLulL1QrB
         8MuMAJsA58WAzVFWGcbMlbBCMZZv1Xp8+zgkZ6NkgLm5dfeSB8SN6xdjCLKcJ+XSZxkS
         ae12uKp+5XKc/twZx0HcXvirIGmLEf2iCVZKnX9nuqHA1S+isPsNkSMCnoIj0CQ49LMe
         qLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg9NQZM3hNH9WLgSi5dGlBeuq2hHtK/M2sD9dz/wbh+LfKJqiI858t62OxGoMvDw0X2w6JpHH7Jhrd3LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyngEHiZL6IiAHzL4uGztj33MwuBjcm4mbbJ/65zdKyEZFI5TBH
	hSJrGJPRmBZh01jCcHMAdK7cSEd9yzDTWIbtMhli8g5XMR3fWB3rLHkUJuQR5A39Qr+b3OKfFXS
	wzp/kjTAdTK22RzjvfJjWO2IN6ZAPVL/ANF+GejQfVA==
X-Gm-Gg: ASbGncvGDLd1Pp8eu38xLA9IAe7TC6fJupduBzvvjW/hBU7TeKw/5T52EDqvQ20Nwhu
	imtIiekM4ePv6kj++ffiJCQKrvg/lrmnB1WCJvGw9pvFp4JelAIBqNWQlPBQ1onNoi36QSLW2Rh
	lr4ADc84cz0HseF8iivBZZU6mfpV5xPNDKepbGbYL67XZjkPl2LgRNkyOARcKyt19TfIwuIreEQ
	PbtNxpt1eFVcHzJoOw+NQXo7BdiM2JMCQtggSS38KaepEuSEuyKoPJbaw2WkrdnlGh/c4pAx/Rr
	PEoV+zMzFarVBNgVHg==
X-Google-Smtp-Source: AGHT+IHu+NHlSWMWZgBbLXx+pIUFMav8YMQmxFZfBPTCoDQCkEpCLEoQ8xm5xc5cOQvFGZ4xecaH79wXPEyhGj06zgA=
X-Received: by 2002:a05:620a:4590:b0:8a5:4246:686b with SMTP id
 af79cd13be357-8ab998806ffmr315842185a.36.1761906728163; Fri, 31 Oct 2025
 03:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-extended_cti-v5-0-6f193da2d467@oss.qualcomm.com>
In-Reply-To: <20251020-extended_cti-v5-0-6f193da2d467@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 31 Oct 2025 10:31:57 +0000
X-Gm-Features: AWmQ_bnPKuVtHaksPvutzIO9xzBxS0KRp3OKWBqD3D-KPtG6AzFEkqk1d4z4hs0
Message-ID: <CAJ9a7VjTqBczkdMYXqb1WmDRUYhC--dY6Ky5R=NfUZaYkiWmVw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add Qualcomm extended CTI support
To: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>, 
	quic_yingdeng@quicinc.com, Jinlong Mao <jinlong.mao@oss.qualcomm.com>, 
	Jinlong Mao <jinglong.mao@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This set is looking good now and appears to be getting close to being ready=
.

There are a few minor issues in the second patch and a few items that
need to be confirmed.
1) I note that you removed the code to prevent calling claim/disclaim.
Does this mean that you confirm that you have tested the patch update
for claim tags I posted works on your system?
2) In patch 2 I made some comments in regard to ARCH values - please
confirm that these are accurate and have been tested as working on
your system
3) As mentioned in the comments to patch 2 - you need to update the
docs for the new sysfs selection file you have added

Thanks and Regards

Mike

On Mon, 20 Oct 2025 at 08:12, Yingchao Deng
<yingchao.deng@oss.qualcomm.com> wrote:
>
> The QCOM extended CTI is a heavily parameterized version of ARM=E2=80=99s=
 CSCTI.
> It allows a debugger to send to trigger events to a processor or to send
> a trigger event to one or more processors when a trigger event occurs on
> another processor on the same SoC, or even between SoCs.
>
> QCOM extended CTI supports up to 128 triggers. And some of the register
> offsets are changed.
>
> The commands to configure CTI triggers are the same as ARM's CTI.
>
> Changes in v5:
> 1. Move common part in qcom-cti.h to coresight-cti.h.
> 2. Convert trigger usage fields to dynamic bitmaps and arrays.
> 3. Fix holes in struct cti_config to save some space.
> 4. Revert the previous changes related to the claim tag in
>    cti_enable/disable_hw.
> Link to v4 - https://lore.kernel.org/linux-arm-msm/20250902-extended_cti-=
v4-1-7677de04b416@oss.qualcomm.com/
>
> Changes in v4:
> 1. Read the DEVARCH registers to identify Qualcomm CTI.
> 2. Add a reg_idx node, and refactor the coresight_cti_reg_show() and
> coresight_cti_reg_store() functions accordingly.
> 3. The register offsets specific to Qualcomm CTI are moved to qcom_cti.h.
> Link to v3 - https://lore.kernel.org/linux-arm-msm/20250722081405.2947294=
-1-quic_jinlmao@quicinc.com/
>
> Changes in v3:
> 1. Rename is_extended_cti() to of_is_extended_cti().
> 2. Add the missing 'i' when write the CTI trigger registers.
> 3. Convert the multi-line output in sysfs to single line.
> 4. Initialize offset arrays using designated initializer.
> Link to V2 - https://lore.kernel.org/all/20250429071841.1158315-3-quic_ji=
nlmao@quicinc.com/
>
> Changes in V2:
> 1. Add enum for compatible items.
> 2. Move offset arrays to coresight-cti-core
>
> Signed-off-by: Jinlong Mao <jinlong.mao@oss.qualcomm.com>
> Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
> ---
> Yingchao Deng (2):
>       coresight: cti: Convert trigger usage fields to dynamic bitmaps and=
 arrays
>       coresight: cti: Add Qualcomm extended CTI support
>
>  drivers/hwtracing/coresight/coresight-cti-core.c   | 144 +++++++++++++--=
-
>  .../hwtracing/coresight/coresight-cti-platform.c   |  16 +-
>  drivers/hwtracing/coresight/coresight-cti-sysfs.c  | 184 +++++++++++++++=
------
>  drivers/hwtracing/coresight/coresight-cti.h        |  60 ++++++-
>  drivers/hwtracing/coresight/qcom-cti.h             |  29 ++++
>  5 files changed, 346 insertions(+), 87 deletions(-)
> ---
> base-commit: 1fdbb3ff1233e204e26f9f6821ae9c125a055229
> change-id: 20251016-extended_cti-2a426c8894b1
>
> Best regards,
> --
> Yingchao Deng <yingchao.deng@oss.qualcomm.com>
>


--=20
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

