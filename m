Return-Path: <linux-kernel+bounces-864518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45DBFAF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FADA486D30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1916321ADB7;
	Wed, 22 Oct 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7QmJsfz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B25305076
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122631; cv=none; b=Q+4OyVxISt0j8aYdRCs3QEPTFg6kMXVVCT9JMsiEgROQ8wAvBeCejkkwL4GNq8hmUM1NwHsqEJShHWh89qIiPsRWrPSofaKoUHsLjxUPyKibe5falCcYLFEx1uFOJk0GvuCgy0CIGvjsTQayjZgL+x55O47ZmdsIEXPNpEkaTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122631; c=relaxed/simple;
	bh=95X/T8myk6J+MDEI2g0wqpKy45lHreCZ51REnMDK5jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeU20THo2M0jyMDSp3fMq0NRTNr9lxBSCwuCdMekpYqsadUp/0AehPD57xKdCBcpEVg3e0M6ElFUevY+dB8FIj8oFOIx/G/feh2T9BSQe1GiOgUJIElV4sVDYd9mW6yp4H4wp8lOCs8k8LNMtZjXKVP5YJcTBQSE59UheN5+l0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R7QmJsfz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7Z6fY012419
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Pw2eszeyI4E2g9fNh11Af8v0
	fw4TBgeSBIbUc22YGDs=; b=R7QmJsfzRmjsLtNK7vCgFmgRfW4nUfyasMuJDsbV
	8WiyTgikJ1YeJokhfiIX2umndMmsahWwSoaEkkeSVl8M9esAOGyy1+GJQxZQlkaE
	Em2uEF1Ooueb8kSXxbMv0jUWd3/Zeuvr04cXEQOq2i5akFtJfeBfKg9reQm2ci6/
	AwcOjVN5Gaa0d76HAgCxDIaGWBuXI3agWkhsOHAIdJuuX0eNWCWtub4GXMTJ5wcu
	bCFr1JWz2+zndccB/0ZA+AAn7xXRkjREf80c0rTE49m6Z9hPzGute+TDIio2hOC+
	0Lwjyoi4xqVyNaVg917peQcuY1+IZG3qhqHzc0ispN88Hg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0hs25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:43:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a89c9750so27598471cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122627; x=1761727427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw2eszeyI4E2g9fNh11Af8v0fw4TBgeSBIbUc22YGDs=;
        b=rEtxqwnimBnKZ+wkOmSsMQlcWCZY12s+IkYPo+zbnydDH4AuSwZFyi0L5frgA64eSG
         R5pYw4wQz4TGRulV9qupL5/b92Wvh2jj8JrFDrhsyNFG6yBiFDdcG8/qkhv8CeVbn/sS
         Q8YpJlDWOI/va21Nq7wu3fBnr/buVPvegHemMtzuxRKcXC6XGS3K7D92xXnbJCX3s0Cd
         tBOtJASTnaBNPUo8qYWRTh8fPt0F4ymqtP73G7bc6fbi13nb0xTGXviJlaTZ6g6aKfu3
         8UrTRL1DpMuV5ic4G/UBJiUw9+8ePXVlHrEYzO42bHq/VuE8GyMkvcTt3MJ2TmSXyT3p
         WY4g==
X-Forwarded-Encrypted: i=1; AJvYcCX8At3GI87agjG09hn0qubxBWOrgitNMZcGmgmu32xVoEa+AoMjNys//PNIP/3EWVszlHZzuqfKk3s6zc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvPvv2/r7GnAc6gP9OEdKH2euzAI5mQ72UfKrgKGJjwYnArPc
	A6u9pOed90+N4LjGL+EvPmGn9jvLz8DkfKWrJjgNIOAzKd55AEKnY6SSm/bzc2VdS3GN8x6sVgp
	KlOE6noB1LATcAbjbX0Cu5j0tL88eS7Gd2KxtPjCq3WnmTP5qRYawmcLfBayGz9FHJyg=
X-Gm-Gg: ASbGncvYnC5fzHsHi/Lk2XCHnhseKR9T6GODQ5u+bWriFNpKU3uxM5zmwlpVT9Rtp2a
	+00HfiYXWypg/TzjxfG4Qa4bNTX4gR5hn1QoxDkot9T6Rh+6mL6Hl2imPiv6B9l8mwNr9S1cbiV
	o1KOmuoj61Sc+Z8p/Q4imfBjzdicoSe29tSUCKBRixWKrCqvGddvhiSdri2+boHI1n0Kt2f8iOn
	mgzIQhlqgMoHuKpfCc2rgqVgRVZ1Wp7uyqSeuWOe2SgnHNRALD06w7nFQJ1U5UWu+oeXuUEcFx4
	0Scox8tx8oDPGBI8lGwz1Anu5rEMqQrrKF6wRsyD0XZWyQjoj9g3YEqIDJQOZiTZ0LtQCFbt6BS
	rMPaPRLvoagqvuieWjucDLocHZYW5jp79N6RHidH5bw60rc8jQZwOgl75UBEPBA8p3El3ECmWMQ
	kZUY0AUsTVpzI=
X-Received: by 2002:a05:622a:138e:b0:4e8:a9f6:355 with SMTP id d75a77b69052e-4e8a9f605c3mr185216571cf.72.1761122627303;
        Wed, 22 Oct 2025 01:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm2S3Op4PtcrMBr+kAUyT/N44aR82rygJS0QbHjpaU09zah5kiqqevUYTKogwavMnGC9i5xg==
X-Received: by 2002:a05:622a:138e:b0:4e8:a9f6:355 with SMTP id d75a77b69052e-4e8a9f605c3mr185216411cf.72.1761122626797;
        Wed, 22 Oct 2025 01:43:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592cd1b9587sm768111e87.19.2025.10.22.01.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:43:46 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:43:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <david.collins@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/4] regulator: qcom-rpmh: Add support to read
 regulator settings
Message-ID: <4w77t2j65453arqgrtqyuv3bmgelgmecvf26yj7idfwqfumizj@q3dhohaiyaes>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-3-5c7a8e4df601@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-add-rpmh-read-support-v2-3-5c7a8e4df601@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX2eq0ZO7rnTn6
 1FrH9088bqmMqB55TppTEyidJWCYrkURW1jXJgmlTfgMaqpSh9DIjGeWjf4wiyOOJgKvhq5Qfop
 K5BPae0ifX2ozi0/WROO3MTAeY4sPlc7ZsS5v3gcyWNxklPVo8BsPj+gHDQnk+B7USsqdY6f0a9
 hsWV8SRfPTo43hLsE0Eii7y0/8tqbuKtgzPwTMdqBXJud59JihUn7nGptCoHx6x747ox8+oK9W4
 IJsgmjbuMd87RRxMhjdQRRaDZvBp3o/f3Sx6hGVJn1U91iDxu9kca8xnAHtxSq8RLz8b+vK9pLw
 sa4yd4bu2Ssg6T2gXdFhC+kXHUKH2n9u+FlG+N4IJdWPyzOjn1d6pgws76Vc9dzvSkzsP10Zzon
 K0+q2lwUI6r5foHrTRAbdflLq04NLg==
X-Proofpoint-ORIG-GUID: UQgtybkZ9dBV2YO0AHs3hWfKyRsFtuIa
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f89944 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=90_3qHN6q6IeklrumdwA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: UQgtybkZ9dBV2YO0AHs3hWfKyRsFtuIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On Wed, Oct 22, 2025 at 02:38:55AM +0530, Kamal Wadhwa wrote:
> Currently, the RPMH regulator's `get_voltage_sel()` function only
> returns cached values from the last `set_voltage_sel()` operation.
> This limitation prevents the regulator framework from accurately
> reflecting the regulator configurations set during the bootloader
> stage. As a result, the regulator framework may trigger an
> unnecessary `set_voltage_sel()` call with the `min_uV` value

unnecessary or incorrect?

> specified in the regulator's device tree settings, which can
> cause issues for consumers like the display and UFS that require
> a consistent voltage setting from the bootloader state until
> their drivers are probed.

It sounds like this should be handled through the .sync_state rather
than just reading the voltage. Please correct me if I'm wrong, even with
the .get_voltage_sel() in place the regulator framework still can lower
the vote.

> 
> To address this issue, enhance the `get_voltage_sel()`, and also
> add new `get_status()` callbacks to read the regulator settings
> directly from the RPMH hardware using the `rpmh_read()`function.
> This change ensures that the regulator framework accurately
> reflects the actual state of the regulators, avoiding unnecessary
> voltage adjustments and maintaining consistent power settings
> across the transition from bootloader to kernel.
> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20250623-add-rpmh-read-support-v1-2-ae583d260195@oss.qualcomm.com
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 164 ++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 947fb5241233c92eaeda974b1b64d227d5946a59..9f693043cb87aa77a7a529b5b973323450db80be 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -61,8 +61,13 @@ static const struct resource_name_formats vreg_rsc_name_lookup[NUM_REGULATOR_TYP
>  };
>  
>  #define RPMH_REGULATOR_REG_VRM_VOLTAGE		0x0
> +#define RPMH_REGULATOR_VOLTAGE_MASK		0x1FFF
> +
>  #define RPMH_REGULATOR_REG_ENABLE		0x4
> +#define RPMH_REGULATOR_ENABLE_MASK		0x1
> +
>  #define RPMH_REGULATOR_REG_VRM_MODE		0x8
> +#define RPMH_REGULATOR_MODE_MASK		0x7
>  
>  #define PMIC4_LDO_MODE_RETENTION		4
>  #define PMIC4_LDO_MODE_LPM			5
> @@ -169,6 +174,7 @@ struct rpmh_vreg {
>  	bool				bypassed;
>  	int				voltage_selector;
>  	unsigned int			mode;
> +	unsigned int			status;
>  };
>  
>  /**
> @@ -213,6 +219,36 @@ static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
>  	return ret;
>  }
>  
> +static int rpmh_regulator_read_data(struct rpmh_vreg *vreg, struct tcs_cmd *cmd)
> +{
> +	return rpmh_read(vreg->dev, cmd);
> +}
> +
> +static int _rpmh_regulator_vrm_get_voltage(struct regulator_dev *rdev, int *uV)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
> +	};
> +	int min_uV = rdev->constraints->min_uV;
> +	int max_uV = rdev->constraints->max_uV;
> +	int ret, _uV = 0;
> +
> +	ret = rpmh_regulator_read_data(vreg, &cmd);
> +	if (!ret)
> +		_uV = (cmd.data & RPMH_REGULATOR_VOLTAGE_MASK) * 1000;
> +	else
> +		dev_err(vreg->dev, "failed to read VOLTAGE ret = %d\n", ret);
> +
> +	if (!_uV || (_uV >= min_uV && _uV <= max_uV))
> +		*uV = _uV;
> +	else
> +		dev_dbg(vreg->dev, "read voltage %d is out-of-range[%d:%d]\n",
> +						_uV, min_uV, max_uV);
> +
> +	return ret;
> +}
> +
>  static int _rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
>  				unsigned int selector, bool wait_for_ack)
>  {
> @@ -254,10 +290,36 @@ static int rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
>  static int rpmh_regulator_vrm_get_voltage_sel(struct regulator_dev *rdev)
>  {
>  	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	int ret, uV = 0;
> +
> +	if (vreg->voltage_selector < 0) {

Why do we return the cached value instead of always reading it from the
hardware?

> +		ret = _rpmh_regulator_vrm_get_voltage(rdev, &uV);
> +		if (!ret && uV != 0)
> +			vreg->voltage_selector = regulator_map_voltage_linear_range(rdev,
> +							uV, INT_MAX);
> +	}
>  
>  	return vreg->voltage_selector;
>  }
>  
> +static enum regulator_status convert_mode_to_status(int mode)
> +{
> +	switch (mode) {
> +	case REGULATOR_MODE_FAST:
> +		return REGULATOR_STATUS_FAST;
> +	case REGULATOR_MODE_NORMAL:
> +		return REGULATOR_STATUS_NORMAL;
> +	case REGULATOR_MODE_IDLE:
> +		return REGULATOR_STATUS_IDLE;
> +	case REGULATOR_MODE_STANDBY:
> +		return REGULATOR_STATUS_STANDBY;
> +	case REGULATOR_MODE_INVALID:
> +		return REGULATOR_STATUS_ERROR;
> +	default:
> +		return REGULATOR_STATUS_UNDEFINED;
> +	};
> +}
> +
>  static int rpmh_regulator_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> @@ -287,6 +349,15 @@ static int rpmh_regulator_set_enable_state(struct regulator_dev *rdev,
>  	if (!ret)
>  		vreg->enabled = enable;
>  
> +	if (vreg->enabled) {
> +		if (vreg->bypassed)
> +			vreg->status = REGULATOR_STATUS_BYPASS;
> +		else
> +			vreg->status = convert_mode_to_status(vreg->mode);
> +	} else {
> +		vreg->status = REGULATOR_STATUS_OFF;
> +	}
> +
>  	return ret;
>  }
>  
> @@ -323,6 +394,15 @@ static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
>  		cmd.data = pmic_mode;
>  	}
>  
> +	if (vreg->enabled) {
> +		if (bypassed)
> +			vreg->status = REGULATOR_STATUS_BYPASS;
> +		else
> +			vreg->status = convert_mode_to_status(mode);
> +	} else {
> +		vreg->status = REGULATOR_STATUS_OFF;
> +	}
> +
>  	return rpmh_regulator_send_request(vreg, &cmd, true);
>  }
>  
> @@ -342,6 +422,22 @@ static int rpmh_regulator_vrm_set_mode(struct regulator_dev *rdev,
>  	return ret;
>  }
>  
> +static int rpmh_regulator_vrm_get_pmic_mode(struct rpmh_vreg *vreg, int *pmic_mode)
> +{
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
> +	};
> +	int ret;
> +
> +	ret = rpmh_regulator_read_data(vreg, &cmd);
> +	if (!ret)
> +		*pmic_mode = cmd.data & RPMH_REGULATOR_MODE_MASK;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
>  {
>  	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> @@ -349,6 +445,13 @@ static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
>  	return vreg->mode;
>  }
>  
> +static int rpmh_regulator_vrm_get_status(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +	return vreg->status;
> +}
> +
>  /**
>   * rpmh_regulator_vrm_get_optimum_mode() - get the mode based on the  load
>   * @rdev:		Regulator device pointer for the rpmh-regulator
> @@ -407,6 +510,7 @@ static const struct regulator_ops rpmh_regulator_vrm_ops = {
>  	.list_voltage		= regulator_list_voltage_linear_range,
>  	.set_mode		= rpmh_regulator_vrm_set_mode,
>  	.get_mode		= rpmh_regulator_vrm_get_mode,
> +	.get_status		= rpmh_regulator_vrm_get_status,
>  };
>  
>  static const struct regulator_ops rpmh_regulator_vrm_drms_ops = {
> @@ -418,6 +522,7 @@ static const struct regulator_ops rpmh_regulator_vrm_drms_ops = {
>  	.list_voltage		= regulator_list_voltage_linear_range,
>  	.set_mode		= rpmh_regulator_vrm_set_mode,
>  	.get_mode		= rpmh_regulator_vrm_get_mode,
> +	.get_status		= rpmh_regulator_vrm_get_status,
>  	.get_optimum_mode	= rpmh_regulator_vrm_get_optimum_mode,
>  };
>  
> @@ -430,6 +535,7 @@ static const struct regulator_ops rpmh_regulator_vrm_bypass_ops = {
>  	.list_voltage		= regulator_list_voltage_linear_range,
>  	.set_mode		= rpmh_regulator_vrm_set_mode,
>  	.get_mode		= rpmh_regulator_vrm_get_mode,
> +	.get_status		= rpmh_regulator_vrm_get_status,
>  	.set_bypass		= rpmh_regulator_vrm_set_bypass,
>  	.get_bypass		= rpmh_regulator_vrm_get_bypass,
>  };
> @@ -438,6 +544,7 @@ static const struct regulator_ops rpmh_regulator_xob_ops = {
>  	.enable			= rpmh_regulator_enable,
>  	.disable		= rpmh_regulator_disable,
>  	.is_enabled		= rpmh_regulator_is_enabled,
> +	.get_status		= rpmh_regulator_vrm_get_status,
>  };
>  
>  /**
> @@ -546,6 +653,58 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
>  	return 0;
>  }
>  
> +static int rpmh_regulator_determine_initial_status(struct rpmh_vreg *vreg)
> +{
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +	};
> +	int ret, pmic_mode, mode;
> +	int sts = 0;
> +
> +	ret = rpmh_regulator_read_data(vreg, &cmd);
> +	if (ret) {
> +		dev_dbg(vreg->dev, "failed to read ENABLE status ret = %d\n", ret);
> +		vreg->status = REGULATOR_STATUS_UNDEFINED;
> +		return ret;
> +	}
> +
> +	sts = cmd.data & RPMH_REGULATOR_ENABLE_MASK;
> +	if (!sts) {
> +		vreg->status = REGULATOR_STATUS_OFF;
> +		return 0;
> +	}
> +
> +	if (vreg->hw_data->regulator_type == XOB) {
> +		vreg->status = sts ? REGULATOR_STATUS_ON : REGULATOR_STATUS_OFF;
> +		return 0;
> +	}
> +
> +	ret = rpmh_regulator_vrm_get_pmic_mode(vreg, &pmic_mode);
> +	if (ret < 0) {
> +		dev_dbg(vreg->dev, "failed to read pmic_mode ret = %d\n", ret);
> +		vreg->mode = REGULATOR_MODE_INVALID;
> +		vreg->status = REGULATOR_STATUS_UNDEFINED;
> +		return ret;
> +	}
> +
> +	if (vreg->hw_data->bypass_supported &&
> +			vreg->hw_data->pmic_bypass_mode == pmic_mode) {

Wrong indentation

> +		vreg->bypassed = true;
> +		vreg->status = REGULATOR_STATUS_BYPASS;
> +		return 0;
> +	}
> +
> +	for (mode = 0; mode <= REGULATOR_MODE_STANDBY; mode++) {
> +		if (pmic_mode == vreg->hw_data->pmic_mode_map[mode]) {
> +			vreg->mode = mode;
> +			break;
> +		}
> +	}
> +
> +	vreg->status = convert_mode_to_status(vreg->mode);
> +	return 0;
> +}
> +
>  static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
>  	[REGULATOR_MODE_INVALID] = -EINVAL,
>  	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
> @@ -1820,6 +1979,11 @@ static int rpmh_regulator_probe(struct platform_device *pdev)
>  						vreg_data);
>  		if (ret < 0)
>  			return ret;
> +
> +		ret = rpmh_regulator_determine_initial_status(vreg);
> +		if (ret < 0)
> +			dev_err(dev, "failed to read initial status for %s\n",
> +					vreg->rdesc.name);
>  	}
>  
>  	return 0;
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

