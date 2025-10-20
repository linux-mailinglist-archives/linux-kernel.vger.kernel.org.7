Return-Path: <linux-kernel+bounces-860293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E14BEFC29
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A119189BB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D72E2DD4;
	Mon, 20 Oct 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K1ZNNLQ6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067EB2E2EEE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947041; cv=none; b=Ea92lcv5aNEfBIJjb47BU/0pqbAibTJsxSxf9ijlxCcBdx3JvJdRzuQLKGeGJb1I0vEqV9kQkyechqi6Wi9R3KMw7E1t0KHy1w8RrZAXzEGNxu6clVGySREt2Yu0VhciBK+YeBZ+8/UyOqDyepbEaJeN1DqhpyMZ6CiHRa8CvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947041; c=relaxed/simple;
	bh=gJnVeTLhVTmho589boVCAJSxWIEgmPLZUR5r3i0UnO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAqGUnnUMwz39B0r9EPTyfe//U8c0oABtD9loSnzhqVoxGYcA8f4K6JSBN9EJ3YGtP0ipRTrw9I5g13DWs1c/LReyg3p06MsfztKwgJvLcOaFHMYAUccId853mXHyc6vh8gba+T2jyp6OYiTpaZzQNYvEWVGaiYXjG3zrwA5yfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K1ZNNLQ6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNusbg020299
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ic5bNXxreVSIVO1Go5QvhyrCQOLU1BzWAxz5v8DrSQ=; b=K1ZNNLQ6LVjaczUZ
	hs26L1lDBuSAPCx4tS9XllytcsdrALVP+Rhehfantj4NkrUOBxN7D5LFY4xAD4vB
	fzXJBiKbhBt9fgpx4HcTgBhC4mVZCEhzjJ4ClCmO32M4RoBkfJjIQcuPQIEzn+/M
	z31PlbMDLbhe3qeRnxFYhMrz6Rtp3C3AxBMGPqGLb5xY45g6ZzVsbN0bHYMj1Ggd
	eAiY7tye26dhNSGIBS52flSj0YJBnabov0R5Mfq130uw8rM6gqh/SblhAzS5VyFz
	AGBp7q8va2IeLp1+hO69MQtMQU271el/UIye/ZKdvPhRYp5kfzp0oGEocYfHgIXq
	U4Y0tw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469bxdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:57:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88e452b04d5so137806185a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760947038; x=1761551838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ic5bNXxreVSIVO1Go5QvhyrCQOLU1BzWAxz5v8DrSQ=;
        b=ZaMPB43x8ADwlYLGRpKForBNhBgjC8mjRGP2WZyfDO8M0TGiu3gHYqLdm//JmKU+vT
         y5LBED+WmujZZ6OTFg4rbNh1acWl6QY4nGfCCmq54bFxTF9M9cx85FLJNYRZECFGVI4y
         xntYNTZolaoqZp4uA/mD5oE5FswyPdiZm25E2Gus5rLEcIptFUXOY1Jy1QIusgxcj2xN
         nV0tCU9V8FkIMjRn66NCVZrawwBMEcHBaWzn4r9W1nhaGszNX2WK4FopcygcDPW9GrFv
         6GM5kEeEby50xaHExxw4xKxek6/osHSA31a2q06MmofAyeFKZQ2BiYeB5PZYWq0EkfBN
         iQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXCiHBcQ1MLNJs+DsdF5lIbn69A28ZZOX7hrEGzXaGUOY93oReb8Ohadb5iAaovlzlkF1ogz8gjCmaIMBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwByVfkbXkpgtpPKC99pXrLT6DCSkYiLdj2Dcmv5SBLj3uIk6sh
	q8tdsuDtgqplRLeSI/2PB6dHLCO7NN53XygMSCFwI8bMPfdS9dUt/cQ5tOH22HcxNe/5pVoLbUl
	DmEzoF+DcQjArY9Y1OmmeQOBMaYFFnu9TTOpjwNVak7SyrZoqZD6Zlxthgot4sQ9ta4A=
X-Gm-Gg: ASbGncuzjKlMLRr3MbwpdvC7Yqg7LRZMXm1OTZq8L6DAlMXCBhrBVo+ge0S0tmW8rL6
	0nGtozosvKKlqRo6jWDgBDcDoJGOHMhF7Xz8SlUdJWLeX5vBYJ4Dkw32ZqbULuqDqAQ3HCv+dhz
	lA0MXWqxnFRNCkAOuvdv+piRu3IHID2aoPDM0iaaJQqD8VkNJduBm5Kt4R1HtD5cR73YZkmet0z
	aW0SIWtSc7lHmzGjVpKf4hEIEVmEec1ToNSHoNVnYxf/qTafkdOFh20XvBtr+4ti5e3vpfqlSuD
	O+/6TfUEqVd7yK+Z6RBJGHEMcJXDw2BSr3nVSpwjy58fdZfkuJKHa6ZO7h1tiv8tM1/MMD/5LYo
	KcaBN95eiur9TgO0dNCslzsXzCc7fHIijItURyBxr2R/TO6xQgw9//hmP
X-Received: by 2002:ac8:7f45:0:b0:4e8:9af1:366c with SMTP id d75a77b69052e-4e89d362902mr105943511cf.9.1760947037891;
        Mon, 20 Oct 2025 00:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBnWJcnNlKu9/v8lp9BtHCdJ5pN1JcnYbdJjV94hLdxAt6+Sr2jW+D0brGc3dRHU+JONj8xg==
X-Received: by 2002:ac8:7f45:0:b0:4e8:9af1:366c with SMTP id d75a77b69052e-4e89d362902mr105943331cf.9.1760947037470;
        Mon, 20 Oct 2025 00:57:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949998csm5964950a12.38.2025.10.20.00.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 00:57:16 -0700 (PDT)
Message-ID: <e3547ed7-9fc6-4521-a9c8-6318dcd76324@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 09:57:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: qcs615-ride: Enable Adreno 612 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-6-0baa44f80905@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017-qcs615-spin-2-v1-6-0baa44f80905@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: h624EHQfQ6sXPzbDYaXrrHlkY19fd9E0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX78RbxEwnRjNw
 FIzVVrgxzB0C+2YwPq2dCXjWCYog25dDYj6OUzo9uZqdW9jm76Kp9ifYv0pms8JYUksdpXBtnCx
 E4FF0SsErSprM7imovuCwaujOzkRS9lgpyfIMsVdvVefMU8lGZRCEGCFpQ5/QZrgyI/VLO/QqlJ
 zTmR+3cw/LreRVv97M/UDUQ2h1QA74rqN9DslgvwBbDqOeDR0WF540TMJZfVAADQjv9B0Mtfmc0
 UDPiKvIdNKuDnhobOM5WtdSaO/gZNDX2Uiqa31LJd7tl7+JVXHkV5bTalEb8jkQ3h0tStgV2nXN
 ZXwZpgOFKmZdT+Dbu8sko8UnLevMsc1zZiF47Ur+5sSqjvXnhNF8DrKEdDUUgk9jMW16lurL8Ch
 yVkZYCLDD8z/imUr+o0nJxIOu818Rw==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f5eb5f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=iJWliPolnP7GhHh1kxwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: h624EHQfQ6sXPzbDYaXrrHlkY19fd9E0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On 10/17/25 7:08 PM, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Enable GPU for qcs615-ride platform and provide path for zap
> shader.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

