Return-Path: <linux-kernel+bounces-797490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA98B4110F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399DC170258
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A32EAB83;
	Tue,  2 Sep 2025 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QzJhC7Sd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BCF277CB6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857442; cv=none; b=a8xpR4c7t2TjGkpO6Vm6Qa5sl6vDbhOaGVc8VcCpHaBA6Jvlucgb91FqC+hpkHbT6EbTG+GVQubBDC//UnZu9MdszVZWa8hA4+k5s+KGtM+GdLdVG5B4SHCb013s+jyGXyZJI0QzIWEP1tPoGVFOran6RfKSNXt9GJL51W1D3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857442; c=relaxed/simple;
	bh=gETSOdxDaneanGSTTziHgj/jVUZ4c5aCkbSgMS7rH5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF7gT2WuwhiruwyWk8uMRDBEyLRzLj4RyADhHh+acNGoKhFnhygpUcCkycj9DK066Pj5jUcMMiRfWsd5o8xpeW8x1GAUveRP+8f4hNMpkTIukG9JmrA9xoPk67uRYkXUd6/CgYaMcdA8+DOIueJ9i5tqvg/KbZyCDO+G3uqyNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QzJhC7Sd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqCIP021299
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 23:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FJahCfpQzpwcoT/wvUIgWgO9
	zWdNgWGPkcaTdp3j1Jg=; b=QzJhC7SdG96bGXTxfltmk479dNYus7iAX66MfKce
	4FLK1DhyJ5SIQfmZdrkBYAxhICTmMU+2xhp3RVRY10o3kL1nFE3y7o/iBI+HgfMi
	UBhWtWeUgKGJ3rzhRCWvp2liXj585YOzTarprwKQ1bYpPPbRYXU/mQ2mrzGecGeC
	/3SvN1spdOVglM7MGfMEc9U5P14Nhwc85ZIDLRnSLLaR4b6oHQs9pQdRILY4WVF6
	ms0xICbVjbVZsuT0EgRCoCPG5fCXZQy3utodYNYaJxiCyv2QiThrm17TOZRzbO4+
	KaSqVS2NTJnAltiMPTTAxvpf3GWfTJb0xS/iyXaVzT0OyQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s1nfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:57:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b340f94860so35875661cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756857439; x=1757462239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJahCfpQzpwcoT/wvUIgWgO9zWdNgWGPkcaTdp3j1Jg=;
        b=bRT9TpfKz6keZ227IlopaJFWHRSQ+J0Lc40HpjTfv9kqVNzaLv4jB+zSx4WaDs2eJQ
         k+AHS+dRGNCdEQxevxIsusabvViKKz3vE0FoLb9+I9c/sKOrzNNqQ509G9kpF+OQX6cU
         7s+KKHQzyexzAaprTJJ7p0NyhG+PjiR7F+JWjrtIo0NRHD3hzNubepQkFNgbZwpaogLy
         tquV4Am7vdMGqdUtQkb7oewJrYEYk/f+0kkVzgIAQpOMxdVrpNkNuSKF2eekROn8BKwl
         hReRvCAp0xY5m5yjSH742Cs/0Rwtx9rAf92Msr4YDkT2nk2T4hPmoQ4FmJeULJdQTL8U
         0n6w==
X-Forwarded-Encrypted: i=1; AJvYcCWnr2QmoCAuCULrjIcF6RA4DrrF8VSLG7iUnmDmKEqu8RM4z87+4dKtCO1tcyf3Euv0GxpaGQuM98BySIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzisVpJOzgSZQaRKT8CvbUfY6BGSGs2vuqY3vB8/MMFe/lDsF26
	7w7KFUpNmUe4yz6JoKYMbFpisp67Cw+52FjDTRTzkInGHzsAC32gIEKdIaTafPOCs9L0THVGvfU
	HSOMY1oWCkZI6Y//1127y0D9V6/L6toPUN7YdSc/4B8Wp2fulyGmhbUeNTVxb4uITFBnUrrga3C
	Q=
X-Gm-Gg: ASbGnctemmUD1AVi6/MI9gH84AFp4nnjGLluDRXKOkPtkbaiP+XEJDT0TA7ijVBIpQd
	di8cTYlU00FmOUKeuT4oKo5JSSTGdW4yKv5+n5QMa6SGBU4nNULlsQgxE8pOGp7tvVYiuASyXG4
	a7s0MOOnyrp08C6eSUIGCC6ouqFZBeQo+CN6w36RoCvridOT25aV2QhKxCdTMPanZQ8duZf5uHP
	yHWWSAARj7C91JtpY1DJT8vhWmgNMejSrmEGdDQbpVHqDzAaihdtypQbbL4tMMlVhJK9PbfB7Es
	HI23cQxRNA/C+F3oGo76l+KrcBXmnDIiwUboQyYeL/YX0jDrJ/eN8gGHszQU5b/7JT5SCWK4bUq
	zmXhHudVSpzVwyZN6DxvSMeSnDW723B3U2rVXjbVTK4n1HHoJr6l7
X-Received: by 2002:ac8:5aca:0:b0:4b3:4f82:2b2a with SMTP id d75a77b69052e-4b34f822fa7mr38111821cf.4.1756857438810;
        Tue, 02 Sep 2025 16:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOaiCCaWtZm9xStda9EaWMEdWmAvouU1sGlNqhUDoH/fH6WNsH3tfraC7AYXeHUAkWxsau0Q==
X-Received: by 2002:ac8:5aca:0:b0:4b3:4f82:2b2a with SMTP id d75a77b69052e-4b34f822fa7mr38111511cf.4.1756857438254;
        Tue, 02 Sep 2025 16:57:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad121acsm113221e87.118.2025.09.02.16.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:57:17 -0700 (PDT)
Date: Wed, 3 Sep 2025 02:57:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: Add support for SOCCP remoteproc
 channels
Message-ID: <ds6sirdrarxropjbf4h32lv3gjmmq6rprhzg2unijmsiozetzt@uukv6wckb7ko>
References: <20250902214544.543038-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902214544.543038-1-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX/Lvob1+8ObGp
 QeIX0tfGQIaVn7Q8JiPE5jos3TCklcdWtrvrQovsDVV+TijyaU+huVsdvXwVwT3wy7OKWE1jKkB
 ksgq+LBxe/zzY6W4aQH8uQNt8p78WWpX+dtVa2rho9haFCk5Pk9D0qdkowPtsTnZyoFxJWu2S2C
 zPDBjBJE9Zh4Y4PWBaBwVv7RvOXKW24xTk2S2oQ2BB0AUr7RR5Pxr3x9ux0450GCyJbYpitLu7h
 HDW+s0CjWbbtpPce3bO2cz1H0VjFxe28qA8linATwobSx0JQyOcHbj4gOJ7Qw6qpjgypCQYsCat
 qH/2jVn5BwZOqEXUKcgaRWhWEFIUaAj7KTZubY0u7YnnYHNqtDYhfrM0vt66zPh/Y1YrZ6nx1cw
 hNCHt+gF
X-Proofpoint-GUID: xTyFzU_keYNVRB2A9laqh8jtYW5qg2Ns
X-Proofpoint-ORIG-GUID: xTyFzU_keYNVRB2A9laqh8jtYW5qg2Ns
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b78460 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eD0BHP9R7wE6S2m1gD8A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Tue, Sep 02, 2025 at 02:45:44PM -0700, Anjelique Melendez wrote:
> Add support for charger FW running on SOCCP by adding the
> "PMIC_RTR_SOCCP_APPS" channel name to the rpmsg_match list and
> updating notify_clients logic.
> 
> SOCCP does not have multiple PDs and hence PDR is not supported. So, if
> the subsystem comes up/down, rpmsg driver would be probed or removed.
> Use that for notifiying clients of pmic_glink for PDR events.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/pmic_glink.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index c0a4be5df926..bcd17fc05544 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -17,6 +17,11 @@
>  
>  #define PMIC_GLINK_SEND_TIMEOUT (5 * HZ)
>  
> +enum {
> +	PMIC_GLINK_PDR_UNAVAIL = 0,
> +	PMIC_GLINK_PDR_AVAIL,

No need for this, just use boolean instead.

> +};
> +
>  enum {
>  	PMIC_GLINK_CLIENT_BATT = 0,
>  	PMIC_GLINK_CLIENT_ALTMODE,
> @@ -39,6 +44,7 @@ struct pmic_glink {
>  	struct mutex state_lock;
>  	unsigned int client_state;
>  	unsigned int pdr_state;
> +	bool pdr_available;
>  
>  	/* serializing clients list updates */
>  	spinlock_t client_lock;
> @@ -203,17 +209,17 @@ static void pmic_glink_del_aux_device(struct pmic_glink *pg,
>  	auxiliary_device_uninit(aux);
>  }
>  
> -static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
> +static void pmic_glink_state_notify_clients(struct pmic_glink *pg, unsigned int state)
>  {
>  	struct pmic_glink_client *client;
>  	unsigned int new_state = pg->client_state;
>  	unsigned long flags;
>  
>  	if (pg->client_state != SERVREG_SERVICE_STATE_UP) {
> -		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
> +		if (state == SERVREG_SERVICE_STATE_UP && pg->ept)
>  			new_state = SERVREG_SERVICE_STATE_UP;
>  	} else {
> -		if (pg->pdr_state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
> +		if (state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
>  			new_state = SERVREG_SERVICE_STATE_DOWN;
>  	}
>  
> @@ -233,7 +239,7 @@ static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
>  	guard(mutex)(&pg->state_lock);
>  	pg->pdr_state = state;
>  
> -	pmic_glink_state_notify_clients(pg);
> +	pmic_glink_state_notify_clients(pg, state);
>  }
>  
>  static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
> @@ -246,10 +252,14 @@ static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
>  		return dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
>  
>  	dev_set_drvdata(&rpdev->dev, pg);
> +	pg->pdr_available = rpdev->id.driver_data;
>  
>  	guard(mutex)(&pg->state_lock);
>  	pg->ept = rpdev->ept;
> -	pmic_glink_state_notify_clients(pg);
> +	if (pg->pdr_available)

I think it would be easier to do:

	if (!pg->pdr_available)
		pg->pdr_state = SERVREG_SERVICE_STATE_UP;

	pmic_glink_state_notify_clients(pg, pg->pdr_state);

> +		pmic_glink_state_notify_clients(pg, pg->pdr_state);
> +	else
> +		pmic_glink_state_notify_clients(pg, SERVREG_SERVICE_STATE_UP);
>  
>  	return 0;
>  }
> @@ -265,11 +275,15 @@ static void pmic_glink_rpmsg_remove(struct rpmsg_device *rpdev)
>  
>  	guard(mutex)(&pg->state_lock);
>  	pg->ept = NULL;
> -	pmic_glink_state_notify_clients(pg);
> +	if (pg->pdr_available)
> +		pmic_glink_state_notify_clients(pg, pg->pdr_state);
> +	else
> +		pmic_glink_state_notify_clients(pg, SERVREG_SERVICE_STATE_DOWN);

likewise

>  }
>  
>  static const struct rpmsg_device_id pmic_glink_rpmsg_id_match[] = {
> -	{ "PMIC_RTR_ADSP_APPS" },
> +	{.name = "PMIC_RTR_ADSP_APPS", .driver_data = PMIC_GLINK_PDR_AVAIL },
> +	{.name = "PMIC_RTR_SOCCP_APPS", .driver_data = PMIC_GLINK_PDR_UNAVAIL },
>  	{}
>  };
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

