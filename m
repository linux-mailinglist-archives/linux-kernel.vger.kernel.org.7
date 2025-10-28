Return-Path: <linux-kernel+bounces-874295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74763C15F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE94F604A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FED347FE9;
	Tue, 28 Oct 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PF7nbTOx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e/6hl608"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8FC34679C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670312; cv=none; b=ePLb40H214P8cEtxNOKr6psm19PZnLEw3rOKyNqBx4RlnLm7+k3Yatj+wvz/MmuQuyIAO0dRV59OlMNREQEeRKYtV9eMHcjZjK0MqcdKcywz/FVuzKseRAuIwluBS189iNaYWG6TJqc6+hjKh6f6pG95lmCBk8vlDmWe9f2Syvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670312; c=relaxed/simple;
	bh=RapU0c9b1iHJl9YbwoTmwcITqxMavrj3HpztlsX+eWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZgEM7smKx8kjgPQfRahIPjLKpnpmPrkI6PSq3LjdLoe5YUStFOk2KUVSJtkyjvs0LM6K0qrgUu1imAVkW04wAFQo8gnLC4qRvV8fdfHjIkXHLyZtNNtlyc/eWWnnvivn59FBTbLsoIpk1svgGjZLo7W9NH/0A6/Egmw9y3iP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PF7nbTOx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e/6hl608; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEoHTh1916328
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i9C4HsulAXnn2OnJrBxI/dWINcjpzXYPZD87sN+8Dek=; b=PF7nbTOxluk1bO5V
	3owJoXs6AoHbEix3yQp52rP5kEU53F20nn6o3WI+lIJYd1JRhHqOajCNevku2+zx
	WQ3xKVVvDy+SBZQmbyINL1m3vbk0zJkeM8iokiK3N1Gk77i+hehqtjnx+aACkPqc
	lJWgIEQJO5CKiYaBrBmVgk5FmlMtHOP6UyqGiORyeBwlAbu0PA9pXEnpONZ4zZQP
	4nikLz/y4ns22KlIGgF4mOwObEki5ivFeGq7H8MDsdr9EXop3v4tue1YZbZ1JKrB
	Qtdw4KpJygQNhXJBusOGh9blrVYk8gGnZK5jE49BnSNhCQuWsVdx1adSQcphtfw+
	E05AIA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2g2fu7hk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecf77618a5so79689771cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761670308; x=1762275108; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i9C4HsulAXnn2OnJrBxI/dWINcjpzXYPZD87sN+8Dek=;
        b=e/6hl608J+7Vc/1DWK9hjyyh0kqh8w6Yn3aRo/1UqlAqXbvIX8wC/ripvmdxhvpqZ/
         f8kWFOI86yPz4uWkm3CqytGuyUjRsZPTrk7f5GYNqixJTSFvdd7HggpjSU7RP9L/HVOP
         XVARnbhhvsPKMC73HAvBknC4qBpDpbHb4iICGOuXNTd92xiAtIpUNmHunGpFwFtOIeC2
         t86mfB+nD3PxJAO8w0WNjXxqhibDuCfrpnxwVLvE4evKCkD8mOiBRqqSK5Qdc9g/VBag
         u6dhXTjvOZ08Lsq0Yw8OBCpieG03Auya1bfNNMOwjU3TiDPUH4TuSxRCN0tOuHiJyl73
         ldFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670308; x=1762275108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9C4HsulAXnn2OnJrBxI/dWINcjpzXYPZD87sN+8Dek=;
        b=YCLaL8fes0zOreNGykP77g0nAAq6qWUB1g6RQrOADDxBocCUOykmd7Sxv42tBovNAL
         yPRg0K8vguloNdkqVXlziiJb3VzHD2VHk6/Ymu6/PrXGXMa+pQlGDmJCCmoxn5dHvqlz
         yOACpLNbKW69MHSsJeyefVNee9ULP5xmpBt8TOxTrf59dnJfkeIRZlAPCHMSZ8pIiRQ8
         2+8AvD3+SpC3gTAraZfzU9TOjgrK2v7E3VD3x+FvT2O/rwfHLHcvIdL0ms9XBNQZVOGc
         UZqMJCZkuXVJb6dK/jpGB7A+qAaqMfCiRGDZpxKZ1JixalI9GgoA51+fCzEIpwBy8r8L
         ZTBA==
X-Forwarded-Encrypted: i=1; AJvYcCVobWRWv7Zo4Uv46woNan15z4XRFeJStKEmC1NabtN2oY+a1HrQ+N0RAEB+CQ/aSxxSmSEwgJbNfTwJZwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQQAymfSbQyf/A0xYXFHwv6Im1s4uAv5iVnOte8sPsgMo1YcJ
	RAqZWGJrCSDPX7wKXUvKa/F8409OOJVqYEENfSsnImIU7FTt3aJCsUSKq9EG4ZrPgI4HpTiNWZL
	1u89OwFpd70zS6D3Rvmf2HIqeMMHccFF/0HmpQELuYpJnsKFusoH7UylDd2AnGx0H5ow=
X-Gm-Gg: ASbGncvI8gi2HDKYvcY+J/TmDIY70RYj/PPjfTpF3UnwyRS2x7ix+mELdAs0QICXIui
	vfGWZrM7TowA9p7ujc1skBB6+gXQBw+aXjsW055AbUsJ7UDCIM9CFr5AaksSFno5Ho5DeOAkBLO
	PGWv8PmNd1BaZmoqWJoKfsyWZNYYKmJTQFQwAbea+PNSDNCr5zQ/Yd/NgtqZLSl06LBb6ia3a96
	KqaRYrHfM/s0l1YzMF5msV40uzaSczlWOl9Qnt+vk5joLBrWhlkHUsSpuGzc+v6RlXI4GZaHk3/
	oor+lP2+y/MR7E7jxTxmgx59wIxxrJPIz2KHHhc495VgQ3+8FbMtdli95JfAFuhpnehH2xbRAQC
	XkV59zl3KcBxg+aXKs51QJfYM+3uzqS8a57SycO/KTgpNhDHrC9GDTYBKUlRL2F1lrob66vKdmv
	YyA+s7IAbeRPCK
X-Received: by 2002:a05:622a:4a84:b0:4ed:542:bb38 with SMTP id d75a77b69052e-4ed150a9941mr5038991cf.74.1761670308005;
        Tue, 28 Oct 2025 09:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgQCsxZo2vWoOXautQIdSCHoqffWuFP7rAIohci6FYFBPiN70FLhSUPjD1x5V/JFyrFw8llA==
X-Received: by 2002:a05:622a:4a84:b0:4ed:542:bb38 with SMTP id d75a77b69052e-4ed150a9941mr5038651cf.74.1761670307501;
        Tue, 28 Oct 2025 09:51:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09204esm29835191fa.8.2025.10.28.09.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:51:46 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:51:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] watchdog: Add driver for Gunyah Watchdog
Message-ID: <jaj5oxqcgckndtp7wwe6ukqbh4z5phe3pw3hnhp2hatgqffjzr@y7qevil4o3yr>
References: <20251028-gunyah_watchdog-v3-1-e6d1ea438b1d@oss.qualcomm.com>
 <25f7ff09-08ea-4969-9184-9fd01b097558@kernel.org>
 <76479593-c47b-41a7-8349-5d7c1403f7c0@oss.qualcomm.com>
 <73955d58-544c-4299-a099-bfd9e5912a40@kernel.org>
 <636a1f99-acd4-4904-8fae-f159646cc1a0@kernel.org>
 <f4d80be9-986f-4d37-9c25-725eff7bb653@quicinc.com>
 <e03373d9-e2dd-48b6-93a6-554fcd623718@kernel.org>
 <59a00934-cb42-43de-ac5b-a9292b08301d@quicinc.com>
 <aa4faa81-6e9d-41c2-85f0-32045a8f9f51@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa4faa81-6e9d-41c2-85f0-32045a8f9f51@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0MiBTYWx0ZWRfXxMqnIoqBcCmv
 I49zY05uO2KnsTQ3x3cWn0h8267eBkNH2sm0ifu1+tNLwRCjAqJg0KyLgXfAEWKacEqenwgnY2J
 RhevOO6vwobNeAMcatK3SmxKTUsQ5rJGVnmrIiM7LTu/gW9C8dKdmPt6REByCs0Tb7QTbBFxx5q
 0YZISSZ8qdm2KRKBld4ELlCGosSJ92s+8xi//FJUv9tgeRVg3tJJAWJEyoL1zXBdA+EY8ZnNcua
 1FCxkOc321bJtQcDpVOX/G7wuKVcwI40F6mc2uTZUtrtfHq1jd1wVXe+bYZDUVywfho+DlKL3PR
 3E2T8jOy1hnWB4whGivGqYU+4/Or5tH7VkHOMS+9Aebvy2RkpiIgYsXW5VAZrXsrmHwIDn6/f8w
 730LsYvU6h9DmlXd5cIl4ANU7fv42w==
X-Proofpoint-ORIG-GUID: h04CKxMJk6biMpstDE-5HNxK7zbFs-cQ
X-Proofpoint-GUID: h04CKxMJk6biMpstDE-5HNxK7zbFs-cQ
X-Authority-Analysis: v=2.4 cv=FIMWBuos c=1 sm=1 tr=0 ts=6900f4a5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=qhxFKX_6QV7TjQX2OZUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280142

On Tue, Oct 28, 2025 at 05:40:33PM +0100, Krzysztof Kozlowski wrote:
> On 28/10/2025 17:33, Pavan Kondeti wrote:
> > On Tue, Oct 28, 2025 at 05:17:44PM +0100, Krzysztof Kozlowski wrote:
> >> On 28/10/2025 13:27, Pavan Kondeti wrote:
> >>> On Tue, Oct 28, 2025 at 12:07:40PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 28/10/2025 12:04, Krzysztof Kozlowski wrote:
> >>>>> On 28/10/2025 11:58, Hrishabh Rajput wrote:
> >>>>>>
> >>>>>> On 10/28/2025 3:10 PM, Krzysztof Kozlowski wrote:
> >>>>>>> On 28/10/2025 10:35, Hrishabh Rajput via B4 Relay wrote:
> >>>>>>>> +
> >>>>>>>> +static int __init gunyah_wdt_init(void)
> >>>>>>>> +{
> >>>>>>>> +	struct arm_smccc_res res;
> >>>>>>>> +	struct device_node *np;
> >>>>>>>> +	int ret;
> >>>>>>>> +
> >>>>>>>> +	/* Check if we're running on a Qualcomm device */
> >>>>>>>> +	np = of_find_compatible_node(NULL, NULL, "qcom,smem");
> >>>>>>> I don't think you implemented my feedback. This again is executed on
> >>>>>>> every platform, e.g. on Samsung, pointlessly.
> >>>>>>>
> >>>>>>> Implement previous feedback.
> >>>>>>
> >>>>>> Do you want us to add platform device from another driver which is 
> >>>>>> probed only on Qualcomm devices (like socinfo from previous discussion) 
> >>>>>> and get rid of the module init function entirely? As keeping anything in 
> >>>>>> the module init will get it executed on all platforms.
> >>>>>
> >>>>> Instead of asking the same can you read previous discussion? What is
> >>>>> unclear here:
> >>>>> https://lore.kernel.org/all/3b901f9d-dbfa-4f93-a8d2-3e89bd9783c9@kernel.org/
> >>>>> ?
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>> With this patch version, we have tried to reduce the code execution on 
> >>>>>> non-Qualcomm devices (also tried the alternative as mentioned in the 
> >>>>>> cover letter). Adding platform device from another driver as described 
> >>>>>> above would eliminate it entirely, please let us know if you want us to 
> >>>>>> do that.
> >>>>>
> >>>>> Why do I need to repeat the same as last time?
> >>>>
> >>>>
> >>>> Now I see that you completely ignored previous discussion and sent THE
> >>>> SAME approach.
> >>>
> >>> Our intention is not to waste reviewers time at all. It is just a
> >>> misunderstanding on what your comment is about. Let me elaborate further
> >>> not to defend our approach here but to get a clarity so that we don't
> >>> end up in the same situation when v4 is posted.
> >>>
> >>> https://lore.kernel.org/all/b94d8ca3-af58-4a78-9a5a-12e3db0bf75f@kernel.org/ 
> >>>
> >>> You mentioned here
> >>>
> >>> ```
> >>> To me socinfo feels even better. That way only, really only qcom devices
> >>> will execute this SMC.
> >>> ```
> >>>
> >>> We interpreted this comment as `avoid executing this SMC on non qcom
> >>> devices`. That is exactly what we have done in the current patch. since
> >>
> >>
> >> So where did you use socinfo? Point me to the code.
> >>
> > 
> > Okay, lets go a bit deep into the socinfo part. we have used
> > `soc_device_match()` API to detect if the device is qcom (`family =
> > Snapdragon`). It works. However, when we built both `socinfo` and
> 
> socinfo driver. Read my first feedback:
> 
> 
> "No, your hypervisor driver (which you have) should start the module via
> adding platform/aux/something devices."
> 
> And then I agreed if you start it from the socinfo driver.

I'd rather not tie this to socinfo. The socinfo is an optional driver,
which is mainly used to provide debugfs entries. Watchdog is much more
important. It should not be tied to debugfs-only entry.

-- 
With best wishes
Dmitry

