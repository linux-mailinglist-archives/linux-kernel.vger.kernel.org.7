Return-Path: <linux-kernel+bounces-599019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E8A84DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 22:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7940C7B3ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883742900A3;
	Thu, 10 Apr 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HDQ17p6d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5751F1510
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315711; cv=none; b=kQfPncUx2vSnSfH0rO9vhmtPxICxej5nWo1RHsNVGRcsdVh+hXBOwzo+P60RypbFm+mI1Q7N/Lv016jyDsqly8iaRwNI6K6a9GWGc9+O0RA867OsNQeEyLFzvVTY3bN4RFT0i74QqkhOhXVlCWh+aXRyRNfh4qv+jYvp3y5ZqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315711; c=relaxed/simple;
	bh=z+2H0fLYSNNQx5CwPDTUTE2xlFfXKUpOhR5z/ZpzANM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaRMrmYcTUhfDhWxxoCvf39hK2vQeOpKvc3ToeJfT4+tZjCMmeqNN8YYm7UX0mh20YpB4L7z1d68oRAkZkWuQLYsNIDICJWqaMqG9pDGQqT2zZ7+K8DUe1xe0fGJ1WM1ZwXoPyITk9OIQ2CAigE8XuGNRkH+ABqZrkgkFx7hHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HDQ17p6d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGM1D0017273
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 20:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rnGlStlfXd8+F8N9n11TDxWz
	pGUxxvJfzZwKuHYkqC4=; b=HDQ17p6dPh+RGUJog5z2ezlPMw3e6dQX/ufTuDhK
	iT6eM+mz/c3wtHRFZmR8nOw0F7oz7BivV5y5fQRcafPQvh14/rbilU03x/4o+l6s
	1UTGV3Tz3kzJeHCkv2vfcLKDVh4K2EQtaV2aLIkzkXUOqoRY32ebJZ2jZofIvDW3
	7BiqYlyXFHqPbjYluTH8rZkV/xgQGdgKYmGihFef3nwGWM+RQY3KheXsmlsImXmj
	53GEvqKUCwQISMtW5sthrqgLU2A3SI42IoKVidXRy8E6fJwh1QarQv4z1czP/xRe
	MNLbPLAvIxlpNL6oD5YBLXc/Om0Txl5rw+onAWqg3+f5lQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1r1gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 20:08:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c760637fe5so250736085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744315708; x=1744920508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnGlStlfXd8+F8N9n11TDxWzpGUxxvJfzZwKuHYkqC4=;
        b=FtPNul+Apu/ZAc/YsqSM12FS1wZ/PosiGXiRtPfRGt0myMYAQk9XUNIN09AggMJGGw
         EuT9/Jze7FR2Vy3uL4PQ4vhYP7MylufrnoYtkhZo+i0TwP83BS/U1Ek5r/LgqR9vtOJ4
         CIOYQMwukNbfWTCCgqGQ60hn/kjS3gmoXIqOrH5OB1sdT7pjBMJclWvwycQS4D6yL3wy
         7FXJefE7yA2mUSwMrH11rL7G3T8Dk4QA2Py4OIdJsdZTahtIhWBEG03/tEI7epavj6BL
         eIIHRBtdrh4f6HAvXEBVK3PjzQ4B3yK3cMTQ9qMosmkLryCZUdkeatmkhNU+qrVoYS6N
         10jg==
X-Forwarded-Encrypted: i=1; AJvYcCXuH2pIPrK+SKuLwntkq8a4WhicXeW3A+NgtfyVwqIvPrzwC9MEK+r92GEzBrGLxbsjIRbTCy0MUlSLv3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWE/7BKCr583PwdojthzEiMPr86tlcQoO6zpOKgadhixmMbDw
	PM8gDh1py69SbeAkzhwz3vp57ZpyJh8A/iV548T+mmwOqBlVhSYdhzZ9w0eYFel5pMZsArnj/zb
	LAVFpxf9BekcsyXEziLNTyJvk9yqv7lhl/mo4cXKvNUe+fRsjO2vJuKHSFf+6kAc=
X-Gm-Gg: ASbGncsvNMDQZ6o/xJ+KvRMsS9D0nJd9ikac7SUGiooB2+pTmKKhsroZvyk4/O2+BLG
	Pixo2Zu9PMnbhSJChHaHdfk4XBTDmsSWhvRT/4e1l1WtLlML7+pb9xQaTxt8XciOi4YLyUz5Q6e
	48jJXlZ/WZaPxlECLNOWgOQ8YdpmqsW6o16VjTaL8k+D4rH/KNhdwx5V5sTl3DcToGby0JXLoSf
	IYvlz9wDo9LRypi0pnRuI8G8i05rerG6RpjMaW4YWbZbrxGoFOVzOj0bsQdZfdU2Per7XjwcHJh
	TybBn1c1IuE6euf39ShTomIRSA6TI7HUjqB/4GOC3JghvW+I0zEMLezkTU2ESTO4oHAqIe7+HPI
	=
X-Received: by 2002:a05:620a:f15:b0:7c5:a5e9:63ee with SMTP id af79cd13be357-7c7af14de9bmr41797085a.31.1744315708169;
        Thu, 10 Apr 2025 13:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEogGejWVoedJ9yFHidpv0nMlyCBe0gS1l1J0WLSKR9V4AItbcj45d1D87AUWKvzSSlKxT6fg==
X-Received: by 2002:a05:620a:f15:b0:7c5:a5e9:63ee with SMTP id af79cd13be357-7c7af14de9bmr41794385a.31.1744315707854;
        Thu, 10 Apr 2025 13:08:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d239866sm234239e87.83.2025.04.10.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 13:08:27 -0700 (PDT)
Date: Thu, 10 Apr 2025 23:08:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, manivannan.sadhasivam@linaro.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        bvanassche@acm.org, bjorande@quicinc.com, neil.armstrong@linaro.org,
        konrad.dybcio@oss.qualcomm.com, quic_rdwivedi@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH V3 4/9] phy: qcom-qmp-ufs: Refactor UFS PHY reset
Message-ID: <pur4y63xhfmqlyymg4pehk37ry4gg22h24zceoqjbsxp3hj4yf@4kptase3c4qp>
References: <20250410090102.20781-1-quic_nitirawa@quicinc.com>
 <20250410090102.20781-5-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410090102.20781-5-quic_nitirawa@quicinc.com>
X-Proofpoint-ORIG-GUID: MPXDiazOiFlcregGr-PTuhHXIrVVp9hD
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f8253c cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=Y7cAtwDMOKh--fb0GM0A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MPXDiazOiFlcregGr-PTuhHXIrVVp9hD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100146

On Thu, Apr 10, 2025 at 02:30:57PM +0530, Nitin Rawat wrote:
> Refactor the UFS PHY reset handling to parse the reset logic only once
> during probe, instead of every resume.
> 
> Move the UFS PHY reset parsing logic from qmp_phy_power_on to
> qmp_ufs_probe to avoid unnecessary parsing during resume.

How did you solve the circular dependency issue being noted below?

> 
> Co-developed-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 61 +++++++++++++------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 636dc3dc3ea8..12dad28cc1bd 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -1799,38 +1799,11 @@ static int qmp_ufs_com_exit(struct qmp_ufs *qmp)
>  static int qmp_ufs_power_on(struct phy *phy)
>  {
>  	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> -	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	int ret;
>  	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> 
> -	if (cfg->no_pcs_sw_reset) {
> -		/*
> -		 * Get UFS reset, which is delayed until now to avoid a
> -		 * circular dependency where UFS needs its PHY, but the PHY
> -		 * needs this UFS reset.
> -		 */
> -		if (!qmp->ufs_reset) {
> -			qmp->ufs_reset =
> -				devm_reset_control_get_exclusive(qmp->dev,
> -								 "ufsphy");
> -
> -			if (IS_ERR(qmp->ufs_reset)) {
> -				ret = PTR_ERR(qmp->ufs_reset);
> -				dev_err(qmp->dev,
> -					"failed to get UFS reset: %d\n",
> -					ret);
> -
> -				qmp->ufs_reset = NULL;
> -				return ret;
> -			}
> -		}
> -	}
> -
>  	ret = qmp_ufs_com_init(qmp);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return ret;
>  }
> 
>  static int qmp_ufs_phy_calibrate(struct phy *phy)
> @@ -2088,6 +2061,34 @@ static int qmp_ufs_parse_dt(struct qmp_ufs *qmp)
>  	return 0;
>  }
> 
> +static int qmp_ufs_get_phy_reset(struct qmp_ufs *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	int ret;
> +
> +	if (!cfg->no_pcs_sw_reset)
> +		return 0;
> +
> +	/*
> +	 * Get UFS reset, which is delayed until now to avoid a
> +	 * circular dependency where UFS needs its PHY, but the PHY
> +	 * needs this UFS reset.
> +	 */
> +	if (!qmp->ufs_reset) {
> +		qmp->ufs_reset =
> +		devm_reset_control_get_exclusive(qmp->dev, "ufsphy");

Strange indentation.

> +
> +		if (IS_ERR(qmp->ufs_reset)) {
> +			ret = PTR_ERR(qmp->ufs_reset);
> +			dev_err(qmp->dev, "failed to get PHY reset: %d\n", ret);
> +			qmp->ufs_reset = NULL;
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int qmp_ufs_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -2114,6 +2115,10 @@ static int qmp_ufs_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
> 
> +	ret = qmp_ufs_get_phy_reset(qmp);
> +	if (ret)
> +		return ret;
> +
>  	/* Check for legacy binding with child node. */
>  	np = of_get_next_available_child(dev->of_node, NULL);
>  	if (np) {
> --
> 2.48.1
> 

-- 
With best wishes
Dmitry

