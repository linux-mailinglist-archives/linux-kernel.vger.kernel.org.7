Return-Path: <linux-kernel+bounces-756392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD8B1B370
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742D1188C4AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29423FC52;
	Tue,  5 Aug 2025 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSvRNnnw"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9D374C4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397028; cv=none; b=ralXhXnGqGsGw5EjyyqTXbsevZ4yFCovrvNTyiV5ecE7cJdPajHMfHSu0Ljm3PO1WwUKaMsw0ANKjOls7dqmyRKgWSk1qw1xBCWK0N5d+7SVrUbzyr4p2L5iRXtIS+SZXGhKIok9+XkpRD286YV2HLb4Riv1dXOiTLebpkdWgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397028; c=relaxed/simple;
	bh=ZJz0tNNkvUF1Vc8YVUZwxnG597hpAdWW2evUVrgmEWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWuHUMHtPvE+sZdE7giTJG5PTFji+JWn1czmgXS3615EdW2ZMklEqE0vfaqigYIOvVJJzxh6p4dStMAlx/9pUKUckzzBvXSJ2suBZ9n9Fqnfygnobaz4UWrFpKbSxrAZIfhl/4IXjclMK+RP4Z989Kri1pBN6ypy7GnI273FFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zSvRNnnw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bd050184bso6248869b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754397026; x=1755001826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2ob3i08zLMGbbPJV+x4UsT8JaLRG3gVzUr6pbYBjtM=;
        b=zSvRNnnwWllQWS2mkVmWd1qKs2o6dBrLEmnVDS4Bua7Gq9vU2pfgh3kZsHotKVbHs2
         sPEsXxtj2U0mANUQFrSNmuPzNgrM3GgmG1A634YQWELuPH96lCBXbMwoNEWu0USV9U8n
         x+KtyIHbviQjV+Z7RfH7PaNroPs+O/pIHEiBSXD0yT6e5K3vMESptleGPV5ix9shG2Nk
         siFCOWPR2zVgVAV+45hiz8BAEZ1N1Q2jmUW0mKj3LCzQwy5yP6FtrodAmsGrqYV7OJHB
         iMMNxA+dmo68QHO29SW9RR7jR/8C7RlpIjsaT38sszlqmAEm/12yQUyKMhPm61yO0RCe
         4ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397026; x=1755001826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2ob3i08zLMGbbPJV+x4UsT8JaLRG3gVzUr6pbYBjtM=;
        b=ERRQCk7UYzlE/UQXtnR4GXpMCDCeTQaRBt14d102OnR4Sik8MnYR0LrQvU90fHbUyY
         kXvE7gAsf5QQ1pLShG74/a6N0d0Dr/pMHt3gbNvcrcRgRtSSP12+XVrdUomcDzfimt/E
         tZKh/7ZQIFvyZH419Z23DSS3gtQvHho2lShhvSLAepXy/LlDkOZCP47NcavJAT6Wl53z
         9UP3GuRX6zpLdZkUG7pVApR/j5v+I5HU0xAkCIMAHCfpDmThVhIFvSej0mpPdW2cWcTT
         VcDzd5MDLswZVhg+wFfhMzmQBkqdXcueRTvFJsmu98EaVOheIcvnxZZ/oIAKjVyB6knp
         1XSg==
X-Forwarded-Encrypted: i=1; AJvYcCUvXMIlLUe7IuVHT1IbT8sFet0NC67d8jDukJX1Lhi6Xw6HHOERBoXHW2g0uHZlFVo60CLFhqkwpmMA3Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Pb/aJgTZ/apWYiObN7e4uiJp3t+b8ozu5DBVXaPcqKjPasO+
	E2gE+hUIP87ohbzuHvSkI64eoSwkUpIHj+6Jdg7KucftZ/s+c5FCa4Rwme4ap2sgnlrFhxaSQn6
	U2N+MIyYPbBmTGEyvEAsVJQNNo5CkMM6MS4DTZpWrlA==
X-Gm-Gg: ASbGnctUtmk7/hJ1FB8lnUw1IS6+uq8oOJ+6Uy9rsAXs7Y6dOYJf0AaZxS49O7emaLB
	Efs3K9Yekuf29f6BJcQBU9We9i9eg9BvY1AlspUPEIOU6ZvfnG3ppyxUz319rACwZPCeBr6+scn
	Q0n4QgSO/ZiRq18jo+Mfu4xCWqlMDdz12notGDB6Y7l2i6594Di8mX4tI7hmEHC5HSUR7VDsAUG
	Cjg/A==
X-Google-Smtp-Source: AGHT+IG07ByK7vPtNDPAezjfjStcLbJ8lUJFVAVvDENQfYbYAPX0NPP/UC9e1+u8wnpzRfxKRdU83UiM5oeocg1jgoA=
X-Received: by 2002:a05:6a00:ace:b0:76b:e868:eedd with SMTP id
 d2e1a72fcca58-76bec4fc0bfmr16869805b3a.24.1754397025608; Tue, 05 Aug 2025
 05:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com> <20250725100806.1157-9-jie.gan@oss.qualcomm.com>
In-Reply-To: <20250725100806.1157-9-jie.gan@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 5 Aug 2025 13:30:14 +0100
X-Gm-Features: Ac12FXzhAbwcmWH8YH5Gri0KwxI-ciY9ES_IFaBVtdo9nO4aocbHgsFn_WqCcjQ
Message-ID: <CAJ9a7Vi8qpHH2SjmKNjgeY4gdRXY9wnQXhkjN71EcbYSKqayuw@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] coresight: add a new function in helper_ops
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>, Jinlong Mao <jinlong.mao@oss.qualcomm.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, Jie Gan <quic_jiegan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, 25 Jul 2025 at 11:08, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>
> Add a new function to identifiy whether the byte-cntr function is
> enabled or not in helper_ops.
>
> The byte-cntr's read_ops is expected if the byte-cntr is enabled when
> the user try to read trace data via sysfs node.
>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>  .../hwtracing/coresight/coresight-ctcu-core.c | 35 +++++++++++++++++++
>  include/linux/coresight.h                     |  3 ++
>  2 files changed, 38 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> index 8fc08e42187e..dec911980939 100644
> --- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
> +++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> @@ -234,9 +234,44 @@ static int ctcu_disable(struct coresight_device *csdev, void *data)
>         return ctcu_set_etr_traceid(csdev, path, false);
>  }
>
> +static bool ctcu_qcom_byte_cntr_in_use(struct coresight_device *csdev,
> +                                      void **data)
> +{
> +       struct ctcu_byte_cntr *byte_cntr_data;
> +       struct coresight_device *helper;
> +       struct ctcu_drvdata *drvdata;
> +       int port;
> +
> +       if (!csdev)
> +               return false;
> +
> +       helper = coresight_get_helper(csdev, CORESIGHT_DEV_SUBTYPE_HELPER_CTCU);
> +       if (!helper)
> +               return false;
> +
> +       port = coresight_get_in_port_dest(csdev, helper);
> +       if (port < 0)
> +               return false;
> +
> +       drvdata = dev_get_drvdata(helper->dev.parent);
> +       /* Something wrong when initialize byte_cntr_read_ops */
> +       if (!drvdata->byte_cntr_read_ops)
> +               return false;
> +
> +       byte_cntr_data = &drvdata->byte_cntr_data[port];
> +       /* Return the pointer of the ctcu_drvdata if byte-cntr has enabled */
> +       if (byte_cntr_data && byte_cntr_data->thresh_val) {
> +               *data = (void *)drvdata->byte_cntr_read_ops;
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  static const struct coresight_ops_helper ctcu_helper_ops = {
>         .enable = ctcu_enable,
>         .disable = ctcu_disable,
> +       .qcom_byte_cntr_in_use = ctcu_qcom_byte_cntr_in_use,

These ops structures are for generic functions used throughout the
devices. Do not put this function here.

This is a specific ctcu helper. Make it external to the file and
declare it in coresight-ctcu.h

Mike

>  };
>
>  static const struct coresight_ops ctcu_ops = {
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 4ac65c68bbf4..b5f052854b08 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -419,11 +419,14 @@ struct coresight_ops_source {
>   *
>   * @enable     : Enable the device
>   * @disable    : Disable the device
> + * @qcom_byte_cntr_in_use:     check whether the byte-cntr is enabled.
>   */
>  struct coresight_ops_helper {
>         int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
>                       void *data);
>         int (*disable)(struct coresight_device *csdev, void *data);
> +       bool (*qcom_byte_cntr_in_use)(struct coresight_device *csdev,
> +                                     void **data);
>  };
>
>
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

