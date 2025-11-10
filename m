Return-Path: <linux-kernel+bounces-893006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C05C46534
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C36A4E974A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF223081C5;
	Mon, 10 Nov 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK4xGvDu"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEA308F0B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774677; cv=none; b=Y8bazVamYHdNpJZe6g4KPUbfL/PT9Ay5wK5Ck+90XPWrpvwNpAM6jujbg9KDUn0R/7K8rrX5cD3k957/zx5fxPjBQQ2MNFpIuTZD4S305M4O1R3bv3w7g7Z8xj60Giygsc0xnXyi0HYCSGY1+8A42C7PR4d5AQJQ/ElODvYgQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774677; c=relaxed/simple;
	bh=bYvCRDJ8Gv1dOfdRqfRo9yHHV4IK3gLVIJ6PseVpKNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7iNLLWPdr1mlzVNPoh0FaUHTm507GaYcO1GJisAxIoTozyN9YY4WV1tAEnZPbhZ4eURmmLSl+hgCLvSeZqz4rlRFmledK9JovtR5gDWZIbrawPJtFSIYFBxj20+KR/AoLzPwLhjuYnBESHC7LeZkOc3glvZH0orq1YTp3x1uJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GK4xGvDu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so22447535e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762774674; x=1763379474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbIPi1f3TQjYD0qdQrLeTSWV5sgjs9x+ZurWSxF6us4=;
        b=GK4xGvDuKd3J3N0sFhw+qRe8dRFQj5wcWAsGkekk3jTlXEPJBJCtpwGfDw61uAmiTJ
         TJqDU7HOfO+3wwsSW/zBox6lNgj++WhnkbuVx+kbIpPH5aFq/PyjZmG9OcgHmPw6DPHQ
         taa8VW8ykh0uk9ehI4Uu/NThH21j5xy94btfr8F/IMC/mCNzwNsNJ88Svspja7jzgGkp
         0Y5UOXzBYVEPmrMOF2Z1lux9cQ1xmp1QglCEnaLnl67dm5bP9AOuu1lxqJv0nQ60Sn3J
         pa9VC0QTkqrDzgjJjX8UpN+nrMivCynm72+Y9wCFdbdKiE1JyHwXS16I/VEIAx1zJKlb
         sq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774674; x=1763379474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbIPi1f3TQjYD0qdQrLeTSWV5sgjs9x+ZurWSxF6us4=;
        b=pLIjWY2u3f9gMRsCsXdGpqnGQHlOex2Pex/ETRqq3zQCus9VrfTtL+r6xY+IR6EkNT
         3895b5uG3VZAo4+YSya9YMnsXZI1UBlpvQqWt7YQLVZLncXKq+RbRuTzPjj3FmgzmKiv
         PlQ8fJJ6dIaX5MdQA4iZUKwurK+xEpZS1Nv554aLfHrDGQJxdw5FJkTdLiylNAo/sSKK
         9NODmKCkhQigYV/x5RIFrJyuHaGSUdpfS+wRHTeO7c3af8FJo2V72SPxFEkSP22GU2RB
         PagZS+1mRJg039S1fNJ19WgzfR8OnuiWIk76owQ+pwRujuyoUtwrgh0WBdTqLua7lEhI
         UaBw==
X-Forwarded-Encrypted: i=1; AJvYcCUnGwDhW4QcQInVQi1uneJcoswBQCugqsjgvqcOpSexBEPsyPIV6gKy/xeUk412/eS7+wI+jO4acz9CsWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGn79TaZnBWftuBB0r0EYUms1oU9onGw37qaKa9U2qGx6bO9V
	xVhU56v+r8zqu0FsKX8f+PLoTDMYFOZe7o/Ql+XuY8KC5NygPp/FZ0ghgtqwRinnwIg=
X-Gm-Gg: ASbGncvGzC9fzl6cZByr24ph9/5dV5VaGUgaFoXX8dplukKIn+dn2L4JW9mGNmd1Enb
	cNMEDZ3O/y0uRyBMTMDifTh3dGb5d7hAF1Hc1KxWzwc6kpkU+lcEghnwjSnf1j8Rivo9Zq9srUm
	/avP4j7pK11UVtnYJsNPf6NnthylsDXHC9BVmntVW/M2O4SzJmc8z5XkvGSKbXvmA/fahF4LmzW
	QLNj1ZS1Y7Vh5iu5luwNjND5xSe9AUOubKBSTZniZSZqi3CqxECexrvu9djoHraH6Q0Er7JxOp0
	9J3Flp/AKg1gqMnNjo/Gt3trR1abqVBHDkNYo+EOeVuxXHXFSXVqKzEySmi6EbZeeDk+EYSnqSI
	MItmH6htso0lvFxV12Mcjdyhi3MgirC6Dc9KvoMeQ9Q49Ar4txIbROqCW5nWsOPsVMJqdNsrfbv
	DYV9ezt4Cp0sORw1aL9nktPYDIq5qFbMfwfhlnbSMFEZrdxThk4Sba
X-Google-Smtp-Source: AGHT+IHA0EBLJZJ+ndV4OQ/knM5PV3CmaEKbnGaPdN8RNMmCv96/hD4FMnZxtX3a7xuoueGlr3MwOg==
X-Received: by 2002:a05:6000:613:b0:42b:39d0:638d with SMTP id ffacd0b85a97d-42b39d06632mr2610262f8f.28.1762774674004;
        Mon, 10 Nov 2025 03:37:54 -0800 (PST)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677abeasm22015186f8f.33.2025.11.10.03.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:37:53 -0800 (PST)
Message-ID: <c65411c8-fe15-4cc4-9236-2232c55e4b86@linaro.org>
Date: Mon, 10 Nov 2025 11:37:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/8] media: qcom: camss: Prepare CSID for C-PHY
 support
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-4-165f7e79b0e1@ixit.cz>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251109-qcom-cphy-v1-4-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/11/2025 09:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Inherit C-PHY information from CSIPHY, so we can configure CSID
> properly.
> 
> CSI2_RX_CFG0_PHY_TYPE_SEL must be set to 1, when C-PHY mode is used.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csid-gen2.c | 1 +
>   drivers/media/platform/qcom/camss/camss-csid.c      | 1 +
>   drivers/media/platform/qcom/camss/camss-csid.h      | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> index 2a1746dcc1c5b..033036ae28a4f 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> @@ -183,6 +183,7 @@ static void __csid_configure_rx(struct csid_device *csid,
>   	val = (lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
>   	val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
>   	val |= phy->csiphy_id << CSI2_RX_CFG0_PHY_NUM_SEL;
> +	val |= csid->phy.cphy << CSI2_RX_CFG0_PHY_TYPE_SEL;
>   	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
>   
>   	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index 5284b5857368c..68adea33cc719 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -1287,6 +1287,7 @@ static int csid_link_setup(struct media_entity *entity,
>   		csid->phy.csiphy_id = csiphy->id;
>   
>   		lane_cfg = &csiphy->cfg.csi2->lane_cfg;
> +		csid->phy.cphy = lane_cfg->cphy;
>   		csid->phy.lane_cnt = lane_cfg->num_data;
>   		csid->phy.lane_assign = csid_get_lane_assign(lane_cfg);
>   	}
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
> index aedc96ed84b2f..a82db31bd2335 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.h
> +++ b/drivers/media/platform/qcom/camss/camss-csid.h
> @@ -70,6 +70,7 @@ struct csid_phy_config {
>   	u32 lane_assign;
>   	u32 en_vc;
>   	u8 need_vc_update;
> +	bool cphy;
>   };
>   
>   struct csid_device;
> 

I'm not convinced you need another flag for this. It should be possible 
for the CSID to get a pointer to the PHY and interrogate the encoded mode.

---
bod

