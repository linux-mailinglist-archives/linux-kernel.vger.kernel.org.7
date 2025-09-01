Return-Path: <linux-kernel+bounces-794068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA06FB3DC5F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF56189851E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6A2F39B3;
	Mon,  1 Sep 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrBsvSuG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDE1E98E6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715457; cv=none; b=aTP5rvAdUWLZDweylJBdloc8qZGtD6MiPN5OL/6AwfuM1PJsOfJigcLlKoqFXYq9Rr1eirVVFAL60hEKv53CT9njs1+Ayvb7ypZLj84j0uLOHYQiEu1b7L/tDr2gXe9N9CIdpxYV9HHAHdt0Y0END9UozcJKEmY8AQ5DcoNVBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715457; c=relaxed/simple;
	bh=75HRYRuu0ytPjpHHK4y4NaBYsbl3ct2Mtmj6P6gyI7c=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Y/tVKyVe3p3ClmERZ2l8uVh7eHGbHsRvrn1K+QQRwcYe9WozG1GcLPUmCJ6d9q5HZATKbvbyecYiG42I1qnpeZoagSu10zRYlipXtw5ZZhlvkHwtshdepGoP7xPibuO8SHNPkoKi0N7WA3Fg6v416iA8RGMQ1N6NdIqlkd9Tgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VrBsvSuG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VNwMTa031143
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 08:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PAlnvbMmNT7cy5qH7wwaB4n/
	geslp9PTYb6i4MqxfhM=; b=VrBsvSuGp6hTuyiIvvci/n39wJlnQdFV8TWfsgRi
	KzqlDuhayFXbALYDzBkYwapUATBzgQs2DzFdB9im+gk/RyzeBPrhtlZ/N/dKVkEK
	5r5ez0Z4HgumEWbAJHU2pocxZj557+x1yFDtLQMmGKDisMUxSKLFKTgS8JOr1xq2
	h+G0IC7Or2h+LlfOIQoz34rpxS4s819dUqTBKVo34HahfsOGV/kAi1DyDethwxmu
	MQC3kzJH9AEjzyx2ZXu8uVFk3Cn9UjsesRygI5qBUp4EmNBNe89xUYWouSy9w4zB
	Er0RngvAy3pSprCskz1DRKgAhK2Dls5g1LutrZ5jpsUiqg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjbyh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:30:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32801263789so2795675a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715454; x=1757320254;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PAlnvbMmNT7cy5qH7wwaB4n/geslp9PTYb6i4MqxfhM=;
        b=YvOmYhywAZGotH62ReCwmBMTjYOG2f14teG7bhZN0+E65NRhOnNNflBk3Ude3whJhL
         J4KTg8p7+xAOT1lRtq6ZkQ2C9zBtvM39D4XlV0B3UBxZi6irIR8cd/sKWv4nicz2v6GQ
         J3Gy/Cpab5SlVP9KH7OPzDKF7kvZpiNxWYbm3vuxrLn4ndG91rBAtkdd88ItmkcbfTkF
         HSIpQYpSJ2jfD4sPaxiWbvV7YBgvuPpmOFGTyyZZcw1aWo0Q2vLjmsiIosNgzicb784Y
         P3LPKxl/1dSWYDPkG0CmM2t/rJQZu1+/JjhgepillTZ0yIPKwZpMTmqoMnceEXgoInAE
         DC8A==
X-Forwarded-Encrypted: i=1; AJvYcCWMLa/a45LAoDiudA/RWbaNmsowaKAICtNTdHu1HeUHCgKzb0LkJ0V3mBgGe/kZVxr6PgZlDJ6U2apxxBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5ZYtBvy38EFBd7FHW6/aE/0xsON7XheGKbz7+jfIo2iOWaN7
	tMYhOJaug6q3GUcLRv/2IOXIG9AvehhsrrdUAs1FTnhSH0B4G9PvKM4wk162G3rTsNoiXo7eL7L
	dElO8AO5ZZbCTAcrXv5Y87rjyrtBgjGE2QSnqxjwJE6z42wKDeyTfY+fmRGPlmgdkzI0=
X-Gm-Gg: ASbGncvYSdqgjz6oBr7cvIw+Whf+35G+sf9ZyT9uo7r5nQtBu7PMjDWE72Mj/CRtOk5
	qvH4StZf1rMXkz4faV6yWhWfmpV8LJemKeCzCk3NwiZvzrRraESE1LI4zaSE9JfXy5mLCEBrhqL
	UDBqHbR8uzcSMOdpc7o6Cb+hn0qZ/wbPT2LIVGd6OWcslVcpu8hmuBnecL6sc9Rz2sAlecXt+9m
	dRz64lx5WSHF7OmbRwjLwZN3b6F/ZDnuRjSLAQT/VtSWUuAJA+J3kTAY2NiPEqXB4Fvov+HM63w
	XGtbLJL8ZovITg5JXFSddxHX65LoyOsfq96dpl85bjSZ0lOjJUbZlvZTiAu5dlg0hpNZ2pzgAd9
	nwANDHhydf/ePtb/Y24HKn/xVkBSJX82+HA==
X-Received: by 2002:a17:90b:3b46:b0:31f:2bbb:e6a8 with SMTP id 98e67ed59e1d1-3280d34bedfmr9411700a91.12.1756715453469;
        Mon, 01 Sep 2025 01:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEFLIh6cXUMrhl0nWYZjIF+ftbFIXMfmYoczlM+ivv4wmziz6mmeKwe5E6V4o0QqOwRn+XyQ==
X-Received: by 2002:a17:90b:3b46:b0:31f:2bbb:e6a8 with SMTP id 98e67ed59e1d1-3280d34bedfmr9411659a91.12.1756715452874;
        Mon, 01 Sep 2025 01:30:52 -0700 (PDT)
Received: from [10.133.33.247] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3296f871acbsm5626087a91.5.2025.09.01.01.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:30:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Y1gY7oQI0ggObi7uDTnXfL60"
Message-ID: <b608b4b2-f850-4b49-be65-b2f4e3784dd5@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 16:30:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] coresight-tnoc: Add runtime PM support for
 Interconnect TNOC
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com>
 <20250831-itnoc-v4-3-f0fb0ef822a5@oss.qualcomm.com>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <20250831-itnoc-v4-3-f0fb0ef822a5@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b559be cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=2_w7q_4OogOuaEAj4c4A:9 a=QEXdDO2ut3YA:10 a=pD-t-wKbIgpBmJTf4s8A:9
 a=Gcllsu8IzuiZ4xof:21 a=_W_S_7VecoQA:10 a=L03L2QfmqWoA:10 a=1WNtSb5ECZgA:10
 a=82JZpTc5bpwA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Ctj37sTPHyU-C8DVI6M74NNjpjnTQraX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX6m9Eu2fH64C5
 72TvCy/URNX9cQnvg0TKu2mGrMNOVa5T8VAS1e/htro71lHinsGYxUZ7hIrcNDG3f1fzqqOxp4v
 DrzWdwEm70iGMBU3D9yyk4EirhPKM7Kd9YAe5vdV5oN3jy1I/ekvn5IyuP6kKlCSeIP5M3kplQl
 oHfE4YdqBH9g3+C8814sc+VQ4WEKLCmgWUq9SYbYkazG5DD7IU41thiboIcueCKqSL15Mjqb92b
 s6Sqjx1wERN++acT51epSFyH9NbqxE1KwPrSKL87y9+skH4r9GSwoDV+zoTedioe/xE+09/t1np
 yG42d0E1uf4fApULrUHn4MFIfnIr4jJ/MCF5KPEsRs0YNKOQuXEKFrDiWFDZO/J8Kal1s1DSXE3
 L9fwfpXQ
X-Proofpoint-ORIG-GUID: Ctj37sTPHyU-C8DVI6M74NNjpjnTQraX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

This is a multi-part message in MIME format.
--------------Y1gY7oQI0ggObi7uDTnXfL60
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/2025 2:58 PM, Yuanfang Zhang wrote:
> This patch adds runtime power management support for platform-based
> CoreSight Interconnect TNOC (ITNOC) devices. It introduces suspend and
> resume callbacks to manage the APB clock (`pclk`) during device runtime
> transitions.
> 
> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tnoc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
> index 5be882300d79bc0173aa6a19d7da1d48c4aaca9c..2c5370497076536bfa868f0d80db775ef242968b 100644
> --- a/drivers/hwtracing/coresight/coresight-tnoc.c
> +++ b/drivers/hwtracing/coresight/coresight-tnoc.c
> @@ -301,6 +301,28 @@ static void itnoc_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>  
> +#ifdef CONFIG_PM
> +static int itnoc_runtime_suspend(struct device *dev)
> +{
> +	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(drvdata->pclk);
> +
> +	return 0;
> +}
> +
> +static int itnoc_runtime_resume(struct device *dev)
> +{
> +	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(drvdata->pclk);
> +}
> +#endif
> +
> +static const struct dev_pm_ops itnoc_dev_pm_ops = {
> +	SET_RUNTIME_PM_OPS(itnoc_runtime_suspend, itnoc_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id itnoc_of_match[] = {
>  	{ .compatible = "qcom,coresight-itnoc" },
>  	{}
> @@ -314,6 +336,7 @@ static struct platform_driver itnoc_driver = {
>  		.name = "coresight-itnoc",
>  		.of_match_table = itnoc_of_match,
>  		.suppress_bind_attrs = true,
> +		.pm = &itnoc_dev_pm_ops,
>  	},
>  };
>  
> 

missed Reviewed-by: Leo Yan <leo.yan@arm.com> tag.

thanks,
yuanfang.
--------------Y1gY7oQI0ggObi7uDTnXfL60
Content-Type: text/html; charset=UTF-8;
 name="https://lore.kernel.org/linux-arm-kernel/20250829084118.GG745921@e132581.arm.com/"
Content-Disposition: attachment;
 filename*0="https://lore.kernel.org/linux-arm-kernel/20250829084118.GG74";
 filename*1="5921@e132581.arm.com/"
Content-Location: https://lore.kernel.org/linux-arm-kernel/20250829084118.GG745921@e132581.arm.com/
Content-Transfer-Encoding: base64

PCFkb2N0eXBlIGh0bWw+PGh0bWwgbGFuZz0iZW4iPjxoZWFkPjx0aXRsZT5NYWtpbmcgc3Vy
ZSB5b3UmIzM5O3JlIG5vdCBhIGJvdCE8L3RpdGxlPjxsaW5rIHJlbD0ic3R5bGVzaGVldCIg
aHJlZj0iLy53aXRoaW4ud2Vic2l0ZS94L3hlc3MveGVzcy5taW4uY3NzP2NhY2hlYnVzdGVy
PTEuMjEuMyI+PG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13
aWR0aCwgaW5pdGlhbC1zY2FsZT0xLjAiPjxtZXRhIG5hbWU9InJvYm90cyIgY29udGVudD0i
bm9pbmRleCxub2ZvbGxvdyI+PHN0eWxlPgogICAgICAgIGJvZHksCiAgICAgICAgaHRtbCB7
CiAgICAgICAgICAgIGhlaWdodDogMTAwJTsKICAgICAgICAgICAgZGlzcGxheTogZmxleDsK
ICAgICAgICAgICAganVzdGlmeS1jb250ZW50OiBjZW50ZXI7CiAgICAgICAgICAgIGFsaWdu
LWl0ZW1zOiBjZW50ZXI7CiAgICAgICAgICAgIG1hcmdpbi1sZWZ0OiBhdXRvOwogICAgICAg
ICAgICBtYXJnaW4tcmlnaHQ6IGF1dG87CiAgICAgICAgfQoKICAgICAgICAuY2VudGVyZWQt
ZGl2IHsKICAgICAgICAgICAgdGV4dC1hbGlnbjogY2VudGVyOwogICAgICAgIH0KCiAgICAg
ICAgI3N0YXR1cyB7CiAgICAgICAgICAgIGZvbnQtdmFyaWFudC1udW1lcmljOiB0YWJ1bGFy
LW51bXM7CiAgICAgICAgfQoKICAgICAgICAjcHJvZ3Jlc3MgewogICAgICAgICAgZGlzcGxh
eTogbm9uZTsKICAgICAgICAgIHdpZHRoOiA5MCU7CiAgICAgICAgICB3aWR0aDogbWluKDIw
cmVtLCA5MCUpOwogICAgICAgICAgaGVpZ2h0OiAycmVtOwogICAgICAgICAgYm9yZGVyLXJh
ZGl1czogMXJlbTsKICAgICAgICAgIG92ZXJmbG93OiBoaWRkZW47CiAgICAgICAgICBtYXJn
aW46IDFyZW0gMCAycmVtOwoJCQkJCW91dGxpbmUtb2Zmc2V0OiAycHg7CgkJCQkJb3V0bGlu
ZTogI2IxNjI4NiBzb2xpZCA0cHg7CgkJCQl9CgogICAgICAgIC5iYXItaW5uZXIgewogICAg
ICAgICAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjYjE2Mjg2OwogICAgICAgICAgICBoZWlnaHQ6
IDEwMCU7CiAgICAgICAgICAgIHdpZHRoOiAwOwogICAgICAgICAgICB0cmFuc2l0aW9uOiB3
aWR0aCAwLjI1cyBlYXNlLWluOwogICAgICAgIH0KICAgIAk8L3N0eWxlPjxzY3JpcHQgaWQ9
ImFudWJpc192ZXJzaW9uIiB0eXBlPSJhcHBsaWNhdGlvbi9qc29uIj4iMS4yMS4zIgo8L3Nj
cmlwdD48c2NyaXB0IGlkPSJhbnViaXNfY2hhbGxlbmdlIiB0eXBlPSJhcHBsaWNhdGlvbi9q
c29uIj57InJ1bGVzIjp7ImFsZ29yaXRobSI6ImZhc3QiLCJkaWZmaWN1bHR5Ijo0LCJyZXBv
cnRfYXMiOjR9LCJjaGFsbGVuZ2UiOiJjY2VhN2Y3YzA0MmVkZjYzMmZjYzc1ZjFlNTMyYWNm
MGU3OGMxNTA5ODExYzM0YTA0ZjA3YzgwMTc4YmVjMjE4YmI4YWY4ZmI4NDk5OTU5MWE0ZWFh
MmEzOWI2YWIzZmE4NzQxMzEzNTRhZTIxNjNkZDBkY2ExMDA2ZmEzYTBlZWMxMjNkYWIzMWE3
NWY0YTc3ZTJlMzFjNmVjOTk5Yzg0MGE5NjMwZTcwYzM4OGJmMjM5NGQ2MjFmZjdlNmQ0ODZk
NTRmZjlkY2I2MjEzNmU1Y2U3ZmIxYzBjZGY2Mjk2OWVmM2E5Njg2MDAwZWEyZGUyY2YxNTI1
YTQ1ZGY1Mzg3OTVmOWQ5Y2E3YzU0NGM0NWViMGYxNzgzZDk5ZDk2Y2FiNzg0MGJlOTM4NmYx
YjM4Nzc5YmJjMWU2YzhhOGJjMzA1OTE1MzUxYWQxOTQ0MDdlNzBkOTZiYTExMzAyZTI2ZWVi
ZWQ0NmJiYzY4ZjEwOGI5NmY0YzFkNTg1MzI2ZWZmODYyMTc1N2U1NzJkMjhkZDBlOTczNmYz
NjkyZTA5M2NjNWNiZTk1ZDhiMGYzOWZlYmM1MjdmZTY1MTNhMmFjZGYzMGNhZGY2NWIzNjk0
ODE3MmVkMDAzZjJhNmQ1ZDVhNGQ4ZGQwYzFkNWRkYmExNTRmOTdhYmE2ODU1N2NmNCJ9Cjwv
c2NyaXB0PjxzY3JpcHQgaWQ9ImFudWJpc19iYXNlX3ByZWZpeCIgdHlwZT0iYXBwbGljYXRp
b24vanNvbiI+IiIKPC9zY3JpcHQ+PC9oZWFkPjxib2R5IGlkPSJ0b3AiPjxtYWluPjxoMSBp
ZD0idGl0bGUiIGNsYXNzPSJjZW50ZXJlZC1kaXYiPk1ha2luZyBzdXJlIHlvdSYjMzk7cmUg
bm90IGEgYm90ITwvaDE+PGRpdiBjbGFzcz0iY2VudGVyZWQtZGl2Ij48aW1nIGlkPSJpbWFn
ZSIgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjI1NnB4OyIgc3JjPSIvLndpdGhpbi53
ZWJzaXRlL3gvY21kL2FudWJpcy9zdGF0aWMvaW1nL3BlbnNpdmUud2VicD9jYWNoZUJ1c3Rl
cj0xLjIxLjMiPiA8aW1nIHN0eWxlPSJkaXNwbGF5Om5vbmU7IiBzdHlsZT0id2lkdGg6MTAw
JTttYXgtd2lkdGg6MjU2cHg7IiBzcmM9Ii8ud2l0aGluLndlYnNpdGUveC9jbWQvYW51Ymlz
L3N0YXRpYy9pbWcvaGFwcHkud2VicD9jYWNoZUJ1c3Rlcj0xLjIxLjMiPjxwIGlkPSJzdGF0
dXMiPkxvYWRpbmcuLi48L3A+PHNjcmlwdCBhc3luYyB0eXBlPSJtb2R1bGUiIHNyYz0iLy53
aXRoaW4ud2Vic2l0ZS94L2NtZC9hbnViaXMvc3RhdGljL2pzL21haW4ubWpzP2NhY2hlQnVz
dGVyPTEuMjEuMyI+PC9zY3JpcHQ+PGRpdiBpZD0icHJvZ3Jlc3MiIHJvbGU9InByb2dyZXNz
YmFyIiBhcmlhLWxhYmVsbGVkYnk9InN0YXR1cyI+PGRpdiBjbGFzcz0iYmFyLWlubmVyIj48
L2Rpdj48L2Rpdj48ZGV0YWlscz48c3VtbWFyeT5XaHkgYW0gSSBzZWVpbmcgdGhpcz88L3N1
bW1hcnk+PHA+WW91IGFyZSBzZWVpbmcgdGhpcyBiZWNhdXNlIHRoZSBhZG1pbmlzdHJhdG9y
IG9mIHRoaXMgd2Vic2l0ZSBoYXMgc2V0IHVwIEFudWJpcyB0byBwcm90ZWN0IHRoZSBzZXJ2
ZXIgYWdhaW5zdCB0aGUgc2NvdXJnZSBvZiBBSSBjb21wYW5pZXMgYWdncmVzc2l2ZWx5IHNj
cmFwaW5nIHdlYnNpdGVzLiBUaGlzIGNhbiBhbmQgZG9lcyBjYXVzZSBkb3dudGltZSBmb3Ig
dGhlIHdlYnNpdGVzLCB3aGljaCBtYWtlcyB0aGVpciByZXNvdXJjZXMgaW5hY2Nlc3NpYmxl
IGZvciBldmVyeW9uZS48L3A+PHA+QW51YmlzIGlzIGEgY29tcHJvbWlzZS4gQW51YmlzIHVz
ZXMgYSBQcm9vZi1vZi1Xb3JrIHNjaGVtZSBpbiB0aGUgdmVpbiBvZiBIYXNoY2FzaCwgYSBw
cm9wb3NlZCBwcm9vZi1vZi13b3JrIHNjaGVtZSBmb3IgcmVkdWNpbmcgZW1haWwgc3BhbS4g
VGhlIGlkZWEgaXMgdGhhdCBhdCBpbmRpdmlkdWFsIHNjYWxlcyB0aGUgYWRkaXRpb25hbCBs
b2FkIGlzIGlnbm9yYWJsZSwgYnV0IGF0IG1hc3Mgc2NyYXBlciBsZXZlbHMgaXQgYWRkcyB1
cCBhbmQgbWFrZXMgc2NyYXBpbmcgbXVjaCBtb3JlIGV4cGVuc2l2ZS48L3A+PHA+VWx0aW1h
dGVseSwgdGhpcyBpcyBhIGhhY2sgd2hvc2UgcmVhbCBwdXJwb3NlIGlzIHRvIGdpdmUgYSAm
IzM0O2dvb2QgZW5vdWdoJiMzNDsgcGxhY2Vob2xkZXIgc29sdXRpb24gc28gdGhhdCBtb3Jl
IHRpbWUgY2FuIGJlIHNwZW50IG9uIGZpbmdlcnByaW50aW5nIGFuZCBpZGVudGlmeWluZyBo
ZWFkbGVzcyBicm93c2VycyAoRUc6IHZpYSBob3cgdGhleSBkbyBmb250IHJlbmRlcmluZykg
c28gdGhhdCB0aGUgY2hhbGxlbmdlIHByb29mIG9mIHdvcmsgcGFnZSBkb2VzbiYjMzk7dCBu
ZWVkIHRvIGJlIHByZXNlbnRlZCB0byB1c2VycyB0aGF0IGFyZSBtdWNoIG1vcmUgbGlrZWx5
IHRvIGJlIGxlZ2l0aW1hdGUuPC9wPjxwPlBsZWFzZSBub3RlIHRoYXQgQW51YmlzIHJlcXVp
cmVzIHRoZSB1c2Ugb2YgbW9kZXJuIEphdmFTY3JpcHQgZmVhdHVyZXMgdGhhdCBwbHVnaW5z
IGxpa2UgSlNoZWx0ZXIgd2lsbCBkaXNhYmxlLiBQbGVhc2UgZGlzYWJsZSBKU2hlbHRlciBv
ciBvdGhlciBzdWNoIHBsdWdpbnMgZm9yIHRoaXMgZG9tYWluLjwvcD48cD5UaGlzIHdlYnNp
dGUgaXMgcnVubmluZyBBbnViaXMgdmVyc2lvbiA8Y29kZT4xLjIxLjM8L2NvZGU+LjwvcD48
L2RldGFpbHM+PG5vc2NyaXB0PjxwPlNhZGx5LCB5b3UgbXVzdCBlbmFibGUgSmF2YVNjcmlw
dCB0byBnZXQgcGFzdCB0aGlzIGNoYWxsZW5nZS4gVGhpcyBpcyByZXF1aXJlZCBiZWNhdXNl
IEFJIGNvbXBhbmllcyBoYXZlIGNoYW5nZWQgdGhlIHNvY2lhbCBjb250cmFjdCBhcm91bmQg
aG93IHdlYnNpdGUgaG9zdGluZyB3b3Jrcy4gQSBuby1KUyBzb2x1dGlvbiBpcyBhIHdvcmst
aW4tcHJvZ3Jlc3MuPC9wPjwvbm9zY3JpcHQ+PGRpdiBpZD0idGVzdGFyZWEiPjwvZGl2Pjwv
ZGl2Pjxmb290ZXI+PGRpdiBjbGFzcz0iY2VudGVyZWQtZGl2Ij48cD5Qcm90ZWN0ZWQgYnkg
PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL1RlY2hhcm9IUS9hbnViaXMiPkFudWJpczwv
YT4gRnJvbSA8YSBocmVmPSJodHRwczovL3RlY2hhcm8ubG9sIj5UZWNoYXJvPC9hPi4gTWFk
ZSB3aXRoIOKdpO+4jyBpbiDwn4eo8J+Hpi48L3A+PHA+TWFzY290IGRlc2lnbiBieSA8YSBo
cmVmPSJodHRwczovL2Jza3kuYXBwL3Byb2ZpbGUvY2VscGhhc2UuYnNreS5zb2NpYWwiPkNF
TFBIQVNFPC9hPi48L3A+PC9kaXY+PC9mb290ZXI+PC9tYWluPjwvYm9keT48L2h0bWw+

--------------Y1gY7oQI0ggObi7uDTnXfL60--

