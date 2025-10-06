Return-Path: <linux-kernel+bounces-843086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6825ABBE61F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0D33BC51F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3D92D63E2;
	Mon,  6 Oct 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eh+3WwLh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2367427AC35
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761878; cv=none; b=RmsaakpOLeNG9Oh1GT0UeV0kmJ017vABAV0V5+dO2pDXihFjpwk1O0MfTBCkhOrUO+XjwMFkD1hQQy8jTv4FbWGoyhV0H9VS8rbo3e+utUD/aFc/Alxa+L5ruFwx6KHYd9InzqePwC14OA7eZws8ZAIpSYpgxZj7e/FKAVHTKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761878; c=relaxed/simple;
	bh=SKl03veh+h4x/nhNErowzWbSc7V4lSAyCOpcHFIf2BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjKx+2DylZkDFPAagEz3rMOTORguAId2jHUEcqSh22Ym6BNjx6/2RGkgNrrVKkHQhegrSSYfiSTHDYDQeUYTF/ulgXHRZWBg0y440vCcGtrmn53ZeccWtPpksnABY1r2XL36fDBbIG1Eoz4lk+dHJ4QDUyAZJ3H2ERrYoHZnaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eh+3WwLh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596ET6Tm010297
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 14:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	af46UksIWGum3ORUH4u56jYFag0zhbbImyMfhQfQfn0=; b=eh+3WwLhY2CHftTc
	aG2usgRhgy2Qc4ycS6zqMTZH1UII+aUxtnWcrR76qbOhuEXufH1+DXG7Rc0dX2XQ
	DetGR5mRT1BxgOsPrh5yDWwS0fJDb+lBIq6+swaSqVvcRBFIEKJiD+ehuvL2Qw4g
	iem0bCPJFYrWe2zTXVRb2FqoFH/9Lv1R1iE+N5WAd75beCxxnMRHuKyhstlunj+T
	fJTmIkZqt+mVe0aLMpI/EvmUO+7xSKkQsP6Zly38tlLqF1df04/3w3KcPtFrTEs0
	JO2KgGYx2Axlzrxuqqj8RxqYh4ItC3RwORPg9v2wxd0w8X81RKS8WXwGeDLC9Fcg
	4EuZCg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1m3kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:44:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7cc365ab519so14081876d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761875; x=1760366675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=af46UksIWGum3ORUH4u56jYFag0zhbbImyMfhQfQfn0=;
        b=E7RyYd96XFGItIRSBQUR2kx3s+OOrdZjGN5VtxaaeyOk617yr1sja7wkdy4QYK0OoN
         eUK8qSb04sLxxeZDlPt1gvzD2+u4dWY/d+d6z3n3LCasxQX1duvcc583kKQnODbGwx/q
         dGkykTGvs9XQ0BUBZs2i4AC3Na5SwEVzsCg2NmGodJiZaDuizJ0gbVnWIptjI5/Hr3zU
         9m8yD1eYGLaxLLPQY7bYjZS0yQdfXAf1RW+lFnrFaf/fKjt5SKw4RUukdGZ3JqCA+sG0
         htAGPzB3SeI2syGOFvpp/ExobNgfXWaCQzDnbV+KqQefXP20iy0IG+kK/tM+6hmKM6so
         divA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJEx/2JqCEuJMEgD8Qn7d4P1JnuUq8AgH3tuDeDrYlk5MRc1qFrQirPmpjwxr0dwgc5omlcba1bzI7IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj99MZHqG6v0nFBeTSLc0LGGBw1rNDpeduqLFldkHZMGV1jDDC
	AT63gS9zuMNq4dSaKPlkvxWEJBrtMow4QV81jeC2vSHhXt68wyN+V2GxoKlww4EPpUJZ4tb7aJ9
	bq7I+avZEFq8Ei2bYvZ8vZ6/u6Qm7ykjP7EPtCSzUqAF15KDshxAR8+ieu6W1QbScXsQ=
X-Gm-Gg: ASbGncswrH2+doVyymk2du1U1TX+jOICkxc899TcbK9AodjSV/T8gBKyqnPa/8F7qQd
	wYmPTWhTSzCw7thu7IMjIKQcF3eklEnlrdfvOmjR3e4bpNX4MhwgY8YbiI5Kyy5ndA2IY2BJQD7
	gKJVyd74jXJDYtlwos65RBKX5ctdkXbiBZ6WvQtctIRuPRwkjPsLKXdrUjQJ7IBHzv5+n5qFI6D
	k864PYIYE6YPEmTES47WWPoEKwXVbBeM5pz++7CoE1dqzdEfFvw6H1juplENU6OXMUQSVHc/yq+
	i0JuNKp1tLav9eiahNrV/YZhDRQMiMO+hoE5ptUCrdxsQMuwHO8hv8SErqU4KMdPjiS1Fr9Ai2U
	K8+LHs2/SoGPt2UyIQqvnMBsrLKE=
X-Received: by 2002:ac8:7f41:0:b0:4d7:6c8a:4792 with SMTP id d75a77b69052e-4e57695639emr106250691cf.0.1759761874554;
        Mon, 06 Oct 2025 07:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+aHHsdEeKXmX68xZhFRxeaNnJWO4fGCZPoBoUF9e7Uq2Xf/6cWij6SLqxtr+sHppcoZftXQ==
X-Received: by 2002:ac8:7f41:0:b0:4d7:6c8a:4792 with SMTP id d75a77b69052e-4e57695639emr106250271cf.0.1759761873728;
        Mon, 06 Oct 2025 07:44:33 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7e8d8sm1169370166b.41.2025.10.06.07.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:44:32 -0700 (PDT)
Message-ID: <e6754738-76c9-4080-bbed-17f02e6535bf@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 16:44:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom: qmp-combo: Move pipe_clk on/off to common
To: Val Packett <val@packett.cool>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250927093915.45124-2-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250927093915.45124-2-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GU5OUBUbRKTZcqveO1Oe6F3ExRNSRDmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX8X+AHnDCDL58
 Py7qg/IA97TEgNBWLTQDt4fOtoOZ1VRjLywD1mQyGHW9NjyZKywtAAlKp4cdlC+5RS+WjaELMxM
 grHJT8BsTBz2QIfq1uj2u/NCFd1cqWeETJ7y2cctLfWUB+t8GfMMx+YJTZ9Dlz9nuI6FK+aeRVp
 FIXvO8XA4wkYtKXKh6L8QoJvlK4F2Qiilt8ovwqP/nIRY2SLKGzOWcPr2l+p4Qv7GMenOlLpDc5
 LwVc9YVw3M41o9xjd8Bk+/EWoFYpV0GVGamwWG79PRw6NJItNGcaaGj6kwAEhvQYV6U5was54DN
 dVpY3/famQPrVljr6MhrrA9NWANdfw1Tf+3kKs2ggMYPbplQGy5850gfU9U1c+WtUcdXbAc9+H3
 C1N6YzDSq1tFK9KhfeNpwFI6P6rk4g==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e3d5d4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=N_By_h1aGXBmJSDtN4kA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: GU5OUBUbRKTZcqveO1Oe6F3ExRNSRDmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On 9/27/25 11:17 AM, Val Packett wrote:
> Keep the USB pipe clock working when the phy is in DP-only mode, because
> the dwc controller still needs it for USB 2.0 over the same Type-C port.
> 
> Tested with the BenQ RD280UA monitor which has a downstream-facing port
> for data passthrough that's manually switchable between USB 2 and 3,
> corresponding to 4-lane and 2-lane DP respectively.
> 
> Note: the suspend/resume callbacks were already gating the enable/disable
> of this clock only on init_count and not usb_init_count!
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
> o/
> 
> Just got my hands on a perfect test device for DP alt mode: a monitor with an
> on-demand toggle between 2 and 4 lanes. (Started digging because I thought
> I needed 4 lanes to use its full resolution and refresh rate, even though
> it turned out to be the dpu adjusted mode clock check rejecting the modes,
> patches for which are already posted.)
> 
> In [1] Konrad mentioned that "the hardware disagrees" with keeping the USB
> PLL always on. I'm not sure what exactly was meant by disagreement there,
> and I didn't find any specific code that touches that PLL in the driver,
> so I decided to just try it anyway.

So what I did was playing around with the RESET_OVRD settings, which
dictate what parts of the PHY (and their associated PLLs) are kept online..
but I totally forgot that there is a branch/gate clock in GCC that sits
inbetween!

> Before the changes, 4-lane mode would actually kill the USB 2.0 functionality
> on the port, no recovery until reboot.
> 
> With this patch, I can switch the monitor between 4-lane and 2-lane modes
> (with an unplug-replug cycle..) and the USB 2.0 devices attached through
> the monitor keep working! (I verified the number of lanes used via dp_debug).
> 
> I'm sure it might not be that simple but from my limited and uninformed
> understanding without any internal knowledge, the "sneaky workaround"
> might actually be the intended way to do things?

Normally the clock which you're enabling is sourced from the QMPPHY.
The other option (bar some debug outputs) is for it to be driven by
the 19.2 MHz always-on crystal (instead of $lots_of_mhz from the PHY).

For USB hosts without a USB3 phy connected to them, there's an option
to mux the controller's PIPE clock to be sourced from the UTMI clock
input. In those cases, the UTMI (and therefore PIPE) clock runs at..
well, 19.2 MHz!

(you can actually do that on USB3-phy-connected hosts too, at the cost
of.. USB3, probably)

So I'm not sure how much of that is well thought-out design and how
much is luck, but this ends up working for us anyway, with seemingly
no downsides.

At least that's my understanding of the situation.

> 
> Thanks,
> ~val
> 
> P.S. if I'm actually wrong and this is not acceptable for $reasons, the suspend
> and resume callbacks would need to be changed to match the logic of having the
> clk on depending on usb_init_count, not just the overall init_count.

The suspend logic is broken and unused anyway, but that's a nice catch,
the PIPE clock in question is even conveniently called "usb3_pipe" in DT

> 
> [1]: https://lore.kernel.org/all/f21b7d52-4c3f-4e5b-bee7-f8b2945b5b02@oss.qualcomm.com/
> 
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 7b5af30f1d02..c4bbd738eba1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -3035,6 +3035,13 @@ static int qmp_combo_com_init(struct qmp_combo *qmp, bool force)
>  	if (ret)
>  		goto err_assert_reset;
>  
> +	/* In DP-only mode, the pipe clk is still required for USB2 */
> +	ret = clk_prepare_enable(qmp->pipe_clk);
> +	if (ret) {
> +		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> +		return ret;
> +	}
> +
>  	qphy_setbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
>  
>  	/* override hardware control for reset of qmp phy */
> @@ -3103,6 +3110,7 @@ static int qmp_combo_com_exit(struct qmp_combo *qmp, bool force)
>  	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>  
>  	clk_bulk_disable_unprepare(qmp->num_clks, qmp->clks);
> +	clk_disable_unprepare(qmp->pipe_clk);

Let's disable this one first, to preserve existing behavior (and it
makes sense logically - if the PHY doesn't have its clocks, it can't
really generate one either)

Great job finding this!

Konrad

