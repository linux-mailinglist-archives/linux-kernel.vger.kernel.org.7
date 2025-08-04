Return-Path: <linux-kernel+bounces-755211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D673EB1A311
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C143B09F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276402609FD;
	Mon,  4 Aug 2025 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFFm/K5l"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154E1DF256
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313429; cv=none; b=cpfZ9u5dxBH5oDJG4jYbfeGpTPK1zdk5IO3U6X0TO89z0CLI2XAecy2CiJlFiQKQeZiDnanHRYicQbds15y6x1RBMvcWC+hnUv6YCd2zs1THSWc+fl7WGEcV/mtuJjBLAoAnDH2JJlyPebL3q+Um8Y6MLT+C4Jn9Eca6Dh9KoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313429; c=relaxed/simple;
	bh=LGF57M35rgadv8iq9N20lyYQI6dPzqa4pdKZimyhlbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DO/et3uJbBRkoxCdrBbSMksEQo4hFdLPQzux6E/kWn96+H+IlIgjC1OD9SLej3329EMAYP8IxUUdnd6lURYAXTPGSSSA2NqmK+tOcIEmeamELnqEEMgrSdsY4C5cyaNeeK0mr8srJVuonGbEsg4256sKdxcqxlEnjl84XoUNoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bFFm/K5l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748Wjgg018005
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 13:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wgXRWKdb8/uIkJlxKRlTEuKqEVXG1EaXlBO5d+CRj9c=; b=bFFm/K5lguhDneyS
	WrB0qC9uZnJMCyoyyTzA6D60uGTmBFWV6+ajaDsBYc1M+qeI0hVynRSaVyh8d0HP
	vwUnwNppc377sTEXgSpfUHt03B8qogqY6JbmEouNYZ7fHWrEBd0/gfNw8xSD/prH
	fWYh3kkIGXJxh4p0najhgLrQ/FqojwQwsRctULet+Dj22D296Hxn2OC3IurXQxWr
	yJL/48cqWZoEUdKxG93HmQv9sUkTj8/LIA9wJqBtIHt6TYLpEiZYUT1oNkGz8Zgq
	5IiC9Po82NlTrbgZdOvfdi1ahcQYSoQC0njdkx/BQgF3u/mzPzx22uEuXmiJYxSq
	pgMJMA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek51ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 13:16:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b07b805068so602251cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313400; x=1754918200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgXRWKdb8/uIkJlxKRlTEuKqEVXG1EaXlBO5d+CRj9c=;
        b=l5LZlnwZP9lxKjXFlyc2Khx/lYDRKWhZkZnc/6oKWT5ByqxNM0U7OPt0iAzVlI3eDJ
         1UpBi/IeQ7Dm8vSGqqNyU64qLN144VwIV+GaRkfzm1b8oT8szadOH7/5zI3rG4Ds9RLi
         ZVTinfKRWJiviPocaoEpRred8B12kPekxZWp3eA67I+Y0dTK9qniAWo5jY6BhWM5lk2U
         nVAjzjJg5IsnN85x/7VFbfke+NXxKoHjsxyODMlNOsW9AaVZqiyDevvREBg+ZZa//v+W
         PdRSPNtHmuTABOme16t9G88rcNsOSKf4mb81vpazDKpI+vU4RD9HNsiR9iyaZaQBwqKe
         xzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKd9uWwJZ32XHTVLUmwL1mmxzZeOwS4HbEIjsXtVFcheh6osD65YHrW+QI4LWE2DbVyWIG/y65TWFo6DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBCTGSbyzyWvweZW2jxD0rQKjiOK3SS/qly+F3tR1yF5WQBCMD
	j71rFgMs6UWLCLPmSGBxnMrW3qfSpnioTTBWbRPT/vJB2vvU3G8k0ulwoMIGGbk8VqX/aKuRqHr
	HEh9xHGszSM4MQcKLhk5EgQ6+mxlSf+59PUtDWltZ2zNFxiGIldVqtW8WfXiuUqeEumE=
X-Gm-Gg: ASbGncsQzfR84ZtHQJ2yVzBGhtseHXnu32/cyAUT+hCyITaZE3PBTXb1Y58N3j0rGf2
	D45GDhCBkDjPcZS2ZrnOH1NupVA+/9pjE2DgzmLY57NBijtS1UgPuOnIDWPoQo8zr9+4ZNpNQyb
	0EqgxI8wqNfofnWAqWG1hmGjX5O92HvY9zjjunCVQl01O2GrhVkGyeSZLkHbYRGUpnh8W2CoM2J
	KaEc0/C46uw+LFGjmYZYz670/z+/5bpylHsRFd+awhG0MWoxIFC/kqeaY9ib57UaQZk0/IOtawD
	KQeTaLMUCKxrWeQQhqTwbkS4ufYeIuf7pCwKBHgt+kuiw5xPghAMrRUdQiCFFY2iZJuj9hjmijC
	3d6FM2X6iKVHb9E/gQw==
X-Received: by 2002:a05:622a:1211:b0:475:1c59:1748 with SMTP id d75a77b69052e-4af10aa56d2mr63735481cf.11.1754313399513;
        Mon, 04 Aug 2025 06:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf7yZ8n4Kn22sR5Uevb5Blz+Ts3PocLhzk4Ya+jFjCOhrB42Tx4xCPXD1tnN8w3MczWz9xng==
X-Received: by 2002:a05:622a:1211:b0:475:1c59:1748 with SMTP id d75a77b69052e-4af10aa56d2mr63734971cf.11.1754313398788;
        Mon, 04 Aug 2025 06:16:38 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe82a7sm6859797a12.30.2025.08.04.06.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:16:38 -0700 (PDT)
Message-ID: <095ab6dd-9b0d-4f58-872a-852c5f19818c@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 15:16:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=6890b2d3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IDvrs2r2PCma8_SM7s4A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3MyBTYWx0ZWRfX8dckmw/+POV4
 mevBFAo5ONwjEVOC1zJ83Z1scJf06ymExuUC63ZTBfX3eIyAPfcOFz0bwT5ssjQLIuBECg+9ScK
 ZwKaijuNHABhwLZ5G+WqkQ2xcCABvRiLTTA+y/iuQQzZoVXU3krJHrFz1z5e573ktNPsuCREEQJ
 015lQWxr7ggWhCLFPJhUSqz1lS4IX8BnsjoBpijo0iB9f15gJas6l0prheOqyf2sS2l+7LGB3I5
 pGhtv8l0uGElNkRbKhcQ0bWQM5y7Nils4qDcrrK/sMcT9juFZ8cpS83gfLG3BdYuWpUBchdzDW6
 xMpMZ+YSVhwRdbtuz0sTFz0di+ovLIdqd1e7j0aJ6RvdrI/yj81AGghq4qvPe1VoKDAsmqYUZMu
 PpT2Nzd8tP3Dd8PFVu5JwJJcPhJIpDyaK6ByOLLRwfy9l/yM2OHGqSd+ERg8NO68dyBgHcJG
X-Proofpoint-ORIG-GUID: mPe9Yaasje4G2w3bD_kTwXEAztnErYdy
X-Proofpoint-GUID: mPe9Yaasje4G2w3bD_kTwXEAztnErYdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040073

On 8/4/25 2:41 PM, Mukesh Ojha wrote:
> pas id is not used in qcom_mdt_load_no_init() and it should not
> be used as it is non-PAS specific function and has no relation
> to PAS specific mechanism.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

[...]

> -static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
> +static bool qcom_mdt_bins_are_split(const struct firmware *fw)

This seems unrelated (or at least unmentioned)

Konrad

