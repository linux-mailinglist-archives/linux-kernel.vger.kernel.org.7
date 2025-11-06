Return-Path: <linux-kernel+bounces-888532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1ABC3B26B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4493842534B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C232D0D4;
	Thu,  6 Nov 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaScKkTT"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC432C322
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433657; cv=none; b=ckN6FCqr/5oYMB0ynLFTxsNrb0MvMwqGpfvBFCCTJs0GYvH8QwwvFWPVUto2les4IqTh3uzpjJQp4AZE7VZQpt/jrr9wL2AOf9oSQcEQCxftkFLQSVjEOY9n5zuBDN0B4/PXrbg+sg4sQY+0ElBuzxzKMLyt5GephSbzq6cCqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433657; c=relaxed/simple;
	bh=r4G+/NqwXRYp6+/iF2HXJWBdXLrxBGyUghIqyfJxe6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGi/VBbHAIRfbUEYYK3yz46p0mYaDIWJ9dPnfHbduAe8Rl4FHbvEzK42cAPoR8Pdfa9lDoI+aG9HKjUJacsVYM+NrJlaQfxPnXh1Dgoc2Ou2Qu3v9VLSUKTv1mgVMcmd3IG/RbLV5a5cn3VtNodT9+J2pAdVRHUz4Qa702TppN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaScKkTT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b22319db92so101432885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762433653; x=1763038453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/LVRGbg/R0cjzjNFLUaSneDEebgcwM8tmDj+wYNpmo=;
        b=zaScKkTTsyn7ETemYGv2U0E+e7pV9rwtdcQse8gT3sNdvdqC5vlbZGV7ZZcV8z5jH0
         6khGB7QqLj0wJXfURdNXL3fHO13sQcrhyfOxB9D1ivrqxR9UAa3iqYh8gD2Sw0rJ0oQE
         9m2KkYfJtJUqWEuGz/Y5taOyQLtBgB1rjvp6OnHZIIObNiljesvfVv/d4ePQFiBktXyv
         yfjZpg5XWdaghurrzoaZ9/viYqAR1ACg7tDwcu0MY/QpAeQoJqT1hyNYX6uwn2/SASwU
         EhBrTFHKZv9ZfnyFEogzRmsDmspX+jDnf0Uv01S3lI/w1PExreSjLbLZhrf7uemPBOh0
         9HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433653; x=1763038453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/LVRGbg/R0cjzjNFLUaSneDEebgcwM8tmDj+wYNpmo=;
        b=JsU5B/3MK8Lsg8GphVO0Kv6vF6DvU/Bcq8vmbCzGmQMvH83GD+hJHvL8J6hBG+04hl
         uJg2hMyKdpdcUydvslXSXSsViMPU06QM7t8dCQJOLngWR9V/PXfcTleIcybyRUOKExbF
         ZlDgPiVByLO84GKo5ZL5q+s0Hzuw0TqD8BUN8niW4tcGEKsWmkJWfUh6u4UkNHBWdRV7
         jCVryoKMoKnLX4VezZVh6/yaUMlxvGsVom+kDvfHMd21oXkGRmx4bYZX24clGjUyb874
         ArnTrrxFFxgIlbTovWTDeGn5Yii7UHEai0AQ/1Nbt6rrvtMbOIlh9bcoBptPrdPAK2AE
         4Glw==
X-Forwarded-Encrypted: i=1; AJvYcCXACTJropUyF+K9NME10a2A5jkidjugA2iXBKiObRFK2guIxyTpuYhLTglMtQpAHG6Mal6FuuZ1nB+TPgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4ON19vUuABmfofQaBK23TqXgvkZcs8VlxhsJMlRhNHSQtpzR
	9srGvxb+mu0bSXsaewkC/TWgvVtzZwliV0rAJqXPQ8L82tBGncAp47k3MLtRGCib4y54Y2C5g/1
	tXJj0NfuzvKK8Tv7dB2JBxak2bQf2mJdh+WbNR7IyCw==
X-Gm-Gg: ASbGncvmBwf0DLAJjMiFm2HYMQ2u6wNZF298z6TSGOlb6bYBz0A9QlA7w5OaQI6LIGU
	UbMRj7+zbenidISb1cjh+T+TcA4QGl22fmoK5BL9vkZKeAO4Tx/3G9S9rDpujjbuJuwKguxqU88
	rpE4U4gAGXMb/ImaGrdqsPAmAv9CNPEWG5ANqJZv62F8FBmwIvHcxlW8nmcAYr8o/inhhDWnBBX
	o3WBmMrNB/WOWsKnKge7dpKfc9Z5YKMjse9RcPzPg320s8gcidHxrCdQuk8Qg4vPbyW3N0Gl41v
	DPM1fvildDMczciPPQ==
X-Google-Smtp-Source: AGHT+IEpN34zsZ5wwP2Owr6OUUnpRIoC3kvxluiNbq9Twjvdxl3iJYLPHL5b6ByEpptX+tubFgXzvxv/TWtG9ClhlUI=
X-Received: by 2002:a05:620a:4548:b0:88e:1123:ec9 with SMTP id
 af79cd13be357-8b2353258bamr344615485a.36.1762433653176; Thu, 06 Nov 2025
 04:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ9a7VjTqBczkdMYXqb1WmDRUYhC--dY6Ky5R=NfUZaYkiWmVw@mail.gmail.com>
 <20251103084615.3666468-1-yingchao.deng@oss.qualcomm.com>
In-Reply-To: <20251103084615.3666468-1-yingchao.deng@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 6 Nov 2025 12:54:01 +0000
X-Gm-Features: AWmQ_bnQTEL57TvE0l2_raUBvNJd91O5zIwL8GGfWa4dYKgD0z8HrW_TTtLT6k8
Message-ID: <CAJ9a7Viir9Eows=Lphw_W9qVGDoHRd3uzMxXbwEPMcjXvPth2w@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add Qualcomm extended CTI support
To: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Cc: alexander.shishkin@linux.intel.com, coresight@lists.linaro.org, 
	james.clark@linaro.org, jinlong.mao@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_yingdeng@quicinc.com, 
	suzuki.poulose@arm.com, tingwei.zhang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 3 Nov 2025 at 08:46, Yingchao Deng
<yingchao.deng@oss.qualcomm.com> wrote:
>
> >Hi,
> >
> >This set is looking good now and appears to be getting close to being re=
ady.
> >
> >There are a few minor issues in the second patch and a few items that
> >need to be confirmed.
> >1) I note that you removed the code to prevent calling claim/disclaim.
> >Does this mean that you confirm that you have tested the patch update
> >for claim tags I posted works on your system?
>
> I just tested this patch, the default value of qcom_cti's CLAIMSET regist=
er is 0xf,
> and unlike the standard CTI (write 0 is no effect), it can be written wit=
h 0.
> So, is it acceptable to write 0 to the claimset register of qcom_cti afte=
r reading the
> devarch register during the probe phase?
>
>         devarch =3D readl_relaxed(drvdata->base + CORESIGHT_DEVARCH);
>         if (CTI_DEVARCH_ARCHITECT(devarch) =3D=3D ARCHITECT_QCOM) {
>                 drvdata->subtype =3D QCOM_CTI;
>                 drvdata->offsets =3D cti_extended_offset;
>                 writel_relaxed(0, drvdata->base + CORESIGHT_CLAIMSET);
>         } else {
>                 drvdata->subtype =3D ARM_STD_CTI;
>                 drvdata->offsets =3D cti_normal_offset;
>         }
>

OK - if you look at v2 of the cliam tag set you will see we introduce
a "claim_tag_info" attribute to the coresight_device structure. This
is initially set to CS_CLAIM_TAG_UNKNOWN, and on the first
claim/disclaim API call the claim tags validity will be tested and a
value of  CS_CLAIM_TAG_STD_PROTOCOL or  CS_CLAIM_TAG_NOT_IMPL set,
skipping the test on all subsequent claim calls.

if you set this  in the probe function i.e.  csdev->claim_tag_info =3D
CS_CLAIM_TAG_NOT_IMPL, then the claim tags will not be used.


whichever method you use, please ensure a comment appears in the code
describing why the workaround is necessary.

Regards

Mike


> >2) In patch 2 I made some comments in regard to ARCH values - please
> >confirm that these are accurate and have been tested as working on
> >your system
>
> Yes, the bits 31:20 in qcom_cti's DEVARCH register are 0x8EF.
>
> >3) As mentioned in the comments to patch 2 - you need to update the
> >docs for the new sysfs selection file you have added
>
> Will update in v6.
>
> Thanks
> Yingchao
>
> >
> >Thanks and Regards
> >
> >Mike
> >
> >On Mon, 20 Oct 2025 at 08:12, Yingchao Deng
> ><yingchao.deng@oss.qualcomm.com> wrote:
> >>
> >> The QCOM extended CTI is a heavily parameterized version of ARM=E2=80=
=99s CSCTI.
> >> It allows a debugger to send to trigger events to a processor or to se=
nd
> >> a trigger event to one or more processors when a trigger event occurs =
on
> >> another processor on the same SoC, or even between SoCs.
> >>
> >> QCOM extended CTI supports up to 128 triggers. And some of the registe=
r
> >> offsets are changed.
> >>
> >> The commands to configure CTI triggers are the same as ARM's CTI.
> >>
> >> Changes in v5:
> >> 1. Move common part in qcom-cti.h to coresight-cti.h.
> >> 2. Convert trigger usage fields to dynamic bitmaps and arrays.
> >> 3. Fix holes in struct cti_config to save some space.
> >> 4. Revert the previous changes related to the claim tag in
> >>    cti_enable/disable_hw.
> >> Link to v4 - https://lore.kernel.org/linux-arm-msm/20250902-extended_c=
ti-v4-1-7677de04b416@oss.qualcomm.com/
> >>
> >> Changes in v4:
> >> 1. Read the DEVARCH registers to identify Qualcomm CTI.
> >> 2. Add a reg_idx node, and refactor the coresight_cti_reg_show() and
> >> coresight_cti_reg_store() functions accordingly.
> >> 3. The register offsets specific to Qualcomm CTI are moved to qcom_cti=
.h.
> >> Link to v3 - https://lore.kernel.org/linux-arm-msm/20250722081405.2947=
294-1-quic_jinlmao@quicinc.com/
> >>
> >> Changes in v3:
> >> 1. Rename is_extended_cti() to of_is_extended_cti().
> >> 2. Add the missing 'i' when write the CTI trigger registers.
> >> 3. Convert the multi-line output in sysfs to single line.
> >> 4. Initialize offset arrays using designated initializer.
> >> Link to V2 - https://lore.kernel.org/all/20250429071841.1158315-3-quic=
_jinlmao@quicinc.com/
> >>
> >> Changes in V2:
> >> 1. Add enum for compatible items.
> >> 2. Move offset arrays to coresight-cti-core
> >>
> >> Signed-off-by: Jinlong Mao <jinlong.mao@oss.qualcomm.com>
> >> Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
> >> ---
> >> Yingchao Deng (2):
> >>       coresight: cti: Convert trigger usage fields to dynamic bitmaps =
and arrays
> >>       coresight: cti: Add Qualcomm extended CTI support
> >>
> >>  drivers/hwtracing/coresight/coresight-cti-core.c   | 144 ++++++++++++=
+---
> >>  .../hwtracing/coresight/coresight-cti-platform.c   |  16 +-
> >>  drivers/hwtracing/coresight/coresight-cti-sysfs.c  | 184 ++++++++++++=
+++------
> >>  drivers/hwtracing/coresight/coresight-cti.h        |  60 ++++++-
> >>  drivers/hwtracing/coresight/qcom-cti.h             |  29 ++++
> >>  5 files changed, 346 insertions(+), 87 deletions(-)
> >> ---
> >> base-commit: 1fdbb3ff1233e204e26f9f6821ae9c125a055229
> >> change-id: 20251016-extended_cti-2a426c8894b1
> >>
> >> Best regards,
> >> --
> >> Yingchao Deng <yingchao.deng@oss.qualcomm.com>
> >>



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

