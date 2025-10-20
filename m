Return-Path: <linux-kernel+bounces-861204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA5BF20E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D4942371F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A9229B38;
	Mon, 20 Oct 2025 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5s+UHdn"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9741D6187
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973523; cv=none; b=fJJFptoo190Db2v47/uWabo+5gKPwAMTCHrUQAhalkDPisWwDcas3giQ9o9wiVV5PywqVTSaV0Jc4b3P4u8/FAxeaka1He3VutRsRTcFuVZdBmQ/JIQcB1pLuw/rye+YUXAqntisME+viXAs18VUJsn5mL48thcDHM3V472g87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973523; c=relaxed/simple;
	bh=sBOyJqsB1c2Ss9f9FD0cz64gIKVi5nYXlDfO/vGVdoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwlE06bwL5Ol/x7X9auam0rhJJfRjTdvNAr/x9vfqyxGufYo0hj6IeErksuujmQl+a3gAZXxmPcMDc6dDe0+soywVqGFXOmvPElyTMoe2E8wZscvHlHn3f5BaVu6npfezLuzxXIpBM8NBE6hbSkCBdXOnA6jpWAsmwazc06IU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p5s+UHdn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781251eec51so3525941b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760973521; x=1761578321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGiTe4HXDqqZ4iZipJXi8jfv7cy2lBX3+OM+ZyQ6XbI=;
        b=p5s+UHdnEm3t3i5zgQBncLoQw+Ieh39QL587NYXN31Ydywm0pvDO3Cq5aWAZ44+ZPM
         2FAVhxo1pJeJj2HzyKFsTbq8FQCcR4mJl+JI8EYX7CPZwbVa3BSGjzTGyOk50OsJpZ17
         Mwt17GT09n1LO7l1dujIcc5V7R1T4cgRqswovLRIs4icgx8J/Lk4MFB1QZyvsMurFENe
         h6tKykmUoqsAW+UiO0lt+ZSMDN+voyIMWMb+Bl3PsDPwSPVrn5hXbPR2irz3XHWq/EUJ
         YeOCkfN6c2NupjODG5H0wBoFSxSmadFU68+ghy3j70EoFdnBJhCz7MQFxZSGxewcIY6L
         rWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973521; x=1761578321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGiTe4HXDqqZ4iZipJXi8jfv7cy2lBX3+OM+ZyQ6XbI=;
        b=EOQpjulYrTu/rtMpYRd+W2ClywQHp7dHnOvMRqLnWLci8vvJBjiakGaij+nzSwrbRI
         yEG51CVw2I7eL92dP+28z83fNHEmHzsIquMlGvVoerQLqw/OIZ8RqJaqrYmyCIorvf0J
         Jd4jcTW7I2B32cwAmzom4AkPr35MjZA6ROM4LyspkO9AxnQy7KvJKtMVNsJq3n66Hbiw
         pq/htTLlDbLfMKjmIki9a1Q8GuZaOHxXsvanCeE3N/YTN00wHJTg7sCiNOLplVt08R2y
         rt7fiETLQ5uZfOfqNroRxM66vOfVMlQEgrH2+IWaGXdFOHMbppNcTNk90T38f4sDBtHG
         bPmA==
X-Forwarded-Encrypted: i=1; AJvYcCXNldIymAR1T4T5bPU8ZFNHnOYUVyTaLNWim/LJ0SB4gX2ZHv+KQbekk/lDjpsT+gpTYoeP8vnX63YSCWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34Lmt5+0MKYkAkiCUCGqYsiWdvgvYSF+fUhsAOlgmlhWrSaRC
	3n0UOMuFSjkYXGnxp9on5IwInTLUpqV/EA5i5xCgVg6IB138kucZTHTUEY3vDytcmTM=
X-Gm-Gg: ASbGnctFFcD3T1pDcw8Nc4RX+pnThT5mWaUxbxaiDBejg8BKhkJTYXIO7+iIJvAcbzU
	XLSu7q1/2FodMyUGd04iDEDQnJHgoQA29va/2nYtp4MiQdNsmxE7IUQpQm6iL5CKOiIXJM3eEKX
	UP1LL+duXyzaDxqZ7QXTYHIgbrMhhySQo9I4R14ZgyGu3BERO7hpnbB466QpjsrVmj4cve46FxP
	Q9JZ0p9AVMngTXN6M0bmvILWeD3WKeC+BuurqfVepEZbe5TgRHoaXCZnAuX+/TrkdaBkejjj6gx
	LPU+X/PYJ3TnSfK1CtG6YZVnUxuuGMP8uIaFLH/ixUPl8UKGVzKAEpzqaQb8Q/JwoJFO3jwOqO5
	s/2xB9HGAOq91c0Q2ojfE2i+0fYlp60yeLTvthahtUtisJhCvS8QCoaAGt9/2tdtivOyL2HuTFY
	NESZWz36IxKDCO3A==
X-Google-Smtp-Source: AGHT+IEZsyy7VgeyAy3dmy4J3fXKkw3RgKJZWu4jhzJnxWQDZQ+Dq+bopDMB+jrQP+4jBD/v93m2gA==
X-Received: by 2002:a17:903:35c6:b0:276:76e1:2e87 with SMTP id d9443c01a7336-290cb46c267mr168729135ad.44.1760973520734;
        Mon, 20 Oct 2025 08:18:40 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2360:6c8a:189d:ae5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5612sm82189935ad.65.2025.10.20.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:18:40 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:18:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-remoteproc@vger.kernel.org, arnd@arndb.de, andersson@kernel.org,
	matthias.bgg@gmail.com, wenst@chromium.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2] remoteproc: mtk_scp: Construct FW path if
 firmware-name not present
Message-ID: <aPZSzbXDBar3_X9O@p14s>
References: <20251015084103.10737-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015084103.10737-1-angelogioacchino.delregno@collabora.com>

On Wed, Oct 15, 2025 at 10:41:03AM +0200, AngeloGioacchino Del Regno wrote:
> After a reply on the mailing lists [1] it emerged that the DT
> property "firmware-name" should not be relied on because of
> possible issues with firmware versions.
> For MediaTek SCP, there has never been any firmware version vs
> driver version desync issue but, regardless, the firmwares are
> always using the same name and they're always located in a path
> with a specific pattern.
> 
> Instead of unconditionally always relying on the firmware-name
> devicetree property to get a path to the SCP FW file, drivers
> should construct a name based on what firmware it knows and
> what hardware it is running on.
> 
> In order to do that, add a `scp_get_default_fw_path()` function
> that constructs the path and filename based on two of the infos
> that the driver can get:
>  1. The compatible string with the highest priority (so, the
>     first one at index 0); and
>  2. The type of SCP HW - single-core or multi-core.
> 
> This means that the default firmware path is generated as:
>  - Single core SCP: mediatek/(soc_model)/scp.img
>    for example:     mediatek/mt8183/scp.img;
> 
>  - Multi core SCP:  mediatek/(soc_model)/scp_c(core_number).img
>    for example:     mediatek/mt8188/scp_c0.img for Core 0, and
>                     mediatek/mt8188/scp_c1.img for Core 1.
> 
> Note that the generated firmware path is being used only if the
> "firmware-name" devicetree property is not present in the SCP
> node or in the SCP Core node(s).
> 
> [1 - Reply regarding firmware-name property]
> Link: https://lore.kernel.org/all/7e8718b0-df78-44a6-a102-89529d6abcce@app.fastmail.com/
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Changes in v2:
>  - Removed initialization of scp_fw_file[7] char array (or string if you prefer)
> 
>  drivers/remoteproc/mtk_scp.c | 65 ++++++++++++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 6 deletions(-)
>

Applied.

Thanks,
Mathieu
 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 8206a1766481..10e3f9eb8cd2 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -16,6 +16,7 @@
>  #include <linux/remoteproc.h>
>  #include <linux/remoteproc/mtk_scp.h>
>  #include <linux/rpmsg/mtk_rpmsg.h>
> +#include <linux/string.h>
>  
>  #include "mtk_common.h"
>  #include "remoteproc_internal.h"
> @@ -1093,22 +1094,74 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>  	}
>  }
>  
> +/**
> + * scp_get_default_fw_path() - Get default SCP firmware path
> + * @dev:     SCP Device
> + * @core_id: SCP Core number
> + *
> + * This function generates a path based on the following format:
> + *     mediatek/(soc_model)/scp(_cX).img; for multi-core or
> + *     mediatek/(soc_model)/scp.img for single core SCP HW
> + *
> + * Return: A devm allocated string containing the full path to
> + *         a SCP firmware or an error pointer
> + */
> +static const char *scp_get_default_fw_path(struct device *dev, int core_id)
> +{
> +	struct device_node *np = core_id < 0 ? dev->of_node : dev->parent->of_node;
> +	const char *compatible, *soc;
> +	char scp_fw_file[7];
> +	int ret;
> +
> +	/* Use only the first compatible string */
> +	ret = of_property_read_string_index(np, "compatible", 0, &compatible);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/* If the compatible string's length is implausible bail out early */
> +	if (strlen(compatible) < strlen("mediatek,mtXXXX-scp"))
> +		return ERR_PTR(-EINVAL);
> +
> +	/* If the compatible string starts with "mediatek,mt" assume that it's ok */
> +	if (!str_has_prefix(compatible, "mediatek,mt"))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (core_id >= 0)
> +		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp_c%1d", core_id);
> +	else
> +		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp");
> +	if (ret <= 0)
> +		return ERR_PTR(ret);
> +
> +	/* Not using strchr here, as strlen of a const gets optimized by compiler */
> +	soc = &compatible[strlen("mediatek,")];
> +
> +	return devm_kasprintf(dev, GFP_KERNEL, "mediatek/%.*s/%s.img",
> +			      (int)strlen("mtXXXX"), soc, scp_fw_file);
> +}
> +
>  static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  				      struct mtk_scp_of_cluster *scp_cluster,
> -				      const struct mtk_scp_of_data *of_data)
> +				      const struct mtk_scp_of_data *of_data,
> +				      int core_id)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct mtk_scp *scp;
>  	struct rproc *rproc;
>  	struct resource *res;
> -	const char *fw_name = "scp.img";
> +	const char *fw_name;
>  	int ret, i;
>  	const struct mtk_scp_sizes_data *scp_sizes;
>  
>  	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> -	if (ret < 0 && ret != -EINVAL)
> -		return ERR_PTR(ret);
> +	if (ret) {
> +		fw_name = scp_get_default_fw_path(dev, core_id);
> +		if (IS_ERR(fw_name)) {
> +			dev_err(dev, "Cannot get firmware path: %ld\n", PTR_ERR(fw_name));
> +			return ERR_CAST(fw_name);
> +		}
> +	}
>  
>  	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
>  	if (!rproc) {
> @@ -1212,7 +1265,7 @@ static int scp_add_single_core(struct platform_device *pdev,
>  	struct mtk_scp *scp;
>  	int ret;
>  
> -	scp = scp_rproc_init(pdev, scp_cluster, of_device_get_match_data(dev));
> +	scp = scp_rproc_init(pdev, scp_cluster, of_device_get_match_data(dev), -1);
>  	if (IS_ERR(scp))
>  		return PTR_ERR(scp);
>  
> @@ -1259,7 +1312,7 @@ static int scp_add_multi_core(struct platform_device *pdev,
>  			goto init_fail;
>  		}
>  
> -		scp = scp_rproc_init(cpdev, scp_cluster, cluster_of_data[core_id]);
> +		scp = scp_rproc_init(cpdev, scp_cluster, cluster_of_data[core_id], core_id);
>  		put_device(&cpdev->dev);
>  		if (IS_ERR(scp)) {
>  			ret = PTR_ERR(scp);
> -- 
> 2.51.0
> 

