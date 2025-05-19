Return-Path: <linux-kernel+bounces-653800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A1ABBEC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 15:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4104517A62C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9EE2797AD;
	Mon, 19 May 2025 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9PAN4aX"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF71F4717
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660310; cv=none; b=omK2Ks1z2pYRHVv10+Kx4WzLZ0Bm9WIwXizeyrdmhN8Oks4j+lJRKAeCBg10kC3nYMbbR94vYa2Im9H49RPUkBgaQ5KWUAPFGxHM7uyMH+q8w7Expx6dcjI+z0J/p4/puL0NKOCE/ugXC2EJiqlomXKcCkLWrJvKmS6mlL0aGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660310; c=relaxed/simple;
	bh=PWalQ5m0kWKDJOtkC62jBvhCS3QqmgQNXR3Tw2vSN6s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=plhXpVv5uy8+q3ndhDEe4ASkJAZLrRrmtFyaIJn1TLemAjv9/fxX4/dLljFYRIpr88do85fLJGGQ3jtI53UjLfTF231bzNpY6/UkHluMMQDHTQ+dY8Bm63ikF/bquGMqx3RL7u/Dr0bf6fJjAiXoEgJH8yr57B+nd3Jn2//HmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9PAN4aX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a376da332aso230664f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747660307; x=1748265107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUn7TYIvH1lNPHVa4Z6ARWyUBajP1au4eKLX4WJWde8=;
        b=H9PAN4aXVv7n9pOc+qlu2sj1Wv6PR8KO2xh9qs7NkJB0z2Mgnn8dci7SEAG4d1DGEW
         GiJxyZ1+Ak8o9ifU5n/IzLxSTsRrjelAY4INa/mFYCdYUSqHN/WKZkCbSRYRcWDcG6Tz
         7KqqPxF3cS0F0+1UGB9m4h88llH69gxNq1gtDXCUZP9Z16DzJXBSNkYkDw3HQN9Wr2jq
         mNLO8pcowjQr2jAfAzK0x+AySlVRmnSBIyjGPgmuNEAuPhR+Qdd5w0Elz+BL6+WntDob
         5PhDUY7cif5LSuqA3wCjigUWTjmQ8AA+T7hGHH3z2UMKl65G2gq8l5GHhiXA+PZcl65S
         QopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747660307; x=1748265107;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUn7TYIvH1lNPHVa4Z6ARWyUBajP1au4eKLX4WJWde8=;
        b=r7Tups2Xan1aDUDQaaBSbhb1GMtaEyVVcO40HVD83n4rwn46pqLjjSeq2acVMUOcdU
         E7p0cQqBaN7ezmJhk4WA5KuZGImIuyH10B+WaX0o7x2THoPf0dqks+xCKShz5shubyzV
         HGyogg4KIl77L762V+ECxIVXHRPaFS6TZ/UJqoVpZ3KViGmRNkuo8maIXEF4TvfNRarB
         CajgTwD0eAugF2KAV/VxSC9DfUkhIxvFTcFwtkve8vqh8jfu38SdAGg24W5aLRcci2lk
         pFK0aCuGnaiTkIqfGihnv5GFe9cvsfRJCf87pFa967aTJbDB7scz3ka4I/qMwcnibIb/
         O35g==
X-Forwarded-Encrypted: i=1; AJvYcCVyov6HkxEc9iiXgxCT72ryIjOBQTZ0cLT7ch3Uu3pCVYdMyhjViik+AYgvn1GU8WREHy6ZVPeQpY5XTDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XkdSvrAk/qkvtUciZLVyZe/gkV7XJAVtwCK3w5A2g3AYDuxY
	UA9DYxgT9Xev5ZETYbehY1GpbOalYkQTrPmXWWAIp0GeTmoFzFc/RJAqT0R/c/q/f5Q=
X-Gm-Gg: ASbGncuzNBBhlrfmEWTzG5TtWjD+Oq0/WK/Qnd9+BVNU1/rHVBIssP5hcl5dnD74f7O
	RbWQZWnvGzNFjrl27zrX1Xj6yyuG+e6VydVAJEclnrSc3NOQAzE7kAJ44go8ER6yh3vbgsQ756B
	FsZedvSyaLcwbpSBkjEm9M/yaJ9n2NZWAiB4CBP2l8OEwyD75yJReoYhTEjAgqraTN2Vqz9CMpt
	R1zZ09Bgi2FPhD6AY8DPEsW7+9gVA2riKeYlpp20XRiNg8ziGvm6trO48grSnLGWdFydqFDXQf9
	+PfmHDNhKnKLSeefsyIoWWG8WCfedDNLDh/fqbIbv2I9h3Tz62q/dgbYrRbifhhEc8p7J8bKoQP
	maJD3kxzrrvV6XfPTEK++vYl4Gnc1
X-Google-Smtp-Source: AGHT+IE4enXPGAfVME6j5Ko4Zoits4KNwPjaTWmXOl8ZpSPczuQ/y48tyuM3P1pXZElfrIkB2Hl4dg==
X-Received: by 2002:a05:6000:420d:b0:3a3:779b:5b41 with SMTP id ffacd0b85a97d-3a3779b5b4fmr35519f8f.28.1747660307120;
        Mon, 19 May 2025 06:11:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:ce80:58bb:54b7:ad18? ([2a01:e0a:3d9:2080:ce80:58bb:54b7:ad18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88978sm13067516f8f.65.2025.05.19.06.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 06:11:46 -0700 (PDT)
Message-ID: <87a7a21e-a2c1-40d1-bc53-c55db8380973@linaro.org>
Date: Mon, 19 May 2025 15:11:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH V5 06/11] phy: qcom-qmp-ufs: Rename qmp_ufs_power_off
To: Nitin Rawat <quic_nitirawa@quicinc.com>, vkoul@kernel.org,
 kishon@kernel.org, manivannan.sadhasivam@linaro.org,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 bvanassche@acm.org, andersson@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konrad.dybcio@oss.qualcomm.com
Cc: quic_rdwivedi@quicinc.com, quic_cang@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20250515162722.6933-1-quic_nitirawa@quicinc.com>
 <20250515162722.6933-7-quic_nitirawa@quicinc.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250515162722.6933-7-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2025 18:27, Nitin Rawat wrote:
> Rename qmp_ufs_disable to qmp_ufs_power_off to better represent its
> functionality. Additionally, inline qmp_ufs_exit into qmp_ufs_power_off
> function to preserve the functionality of .power_off.
> 
> There is no functional change.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index d3f9ee490a32..a5974a1fb5bb 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -1851,28 +1851,11 @@ static int qmp_ufs_power_off(struct phy *phy)
>   	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
>   			SW_PWRDN);
> 
> -	return 0;
> -}
> -
> -static int qmp_ufs_exit(struct phy *phy)
> -{
> -	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> -
>   	qmp_ufs_com_exit(qmp);
> 
>   	return 0;
>   }
> 
> -static int qmp_ufs_disable(struct phy *phy)
> -{
> -	int ret;
> -
> -	ret = qmp_ufs_power_off(phy);
> -	if (ret)
> -		return ret;
> -	return qmp_ufs_exit(phy);
> -}
> -
>   static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>   {
>   	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> @@ -1921,7 +1904,7 @@ static int qmp_ufs_phy_init(struct phy *phy)
>   static const struct phy_ops qcom_qmp_ufs_phy_ops = {
>   	.init		= qmp_ufs_phy_init,
>   	.power_on	= qmp_ufs_power_on,
> -	.power_off	= qmp_ufs_disable,
> +	.power_off	= qmp_ufs_power_off,
>   	.calibrate	= qmp_ufs_phy_calibrate,
>   	.set_mode	= qmp_ufs_set_mode,
>   	.owner		= THIS_MODULE,
> --
> 2.48.1
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

