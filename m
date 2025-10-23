Return-Path: <linux-kernel+bounces-866482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D524FBFFE41
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEEC1A606DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97C2F5A3F;
	Thu, 23 Oct 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3D/dYor"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31022FBE08
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207747; cv=none; b=F5jqGMkjQbj9EO3ys8GQEIOTP/Y2zMm2gIX/qYHAmLjr0rUA4PIWCSl30dx9hW74/6/jK7EzIZm2PJG7+uMCRmtwcX+PhgXNN7i2BQ3mLJvjlXXyxfUdj/ZUxaqoAAgAQ884IxsllirikINlrgaMdMBXEa9JaF5fJP33md6l4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207747; c=relaxed/simple;
	bh=S4vW/Rc/0VyuVVLJvAg90iQZN++icVTdUocdP09y+/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARgB/M5diqu0+KHDMCl3aC2qXoXUvuJW56tBbEpfDEZTPPy4iHwUiw6G3BwNK52VFyKpbDRr3H140hn09XSgPfPHQJ9dZSwqW7/6h3ps7HdEuoIHb7qsnuRJtdFgr2e9fGjxrTXnVZLpKaOaEizi+wzVO45oRLM8l7tGN12MLvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3D/dYor; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6tagN019818
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8FruMMDEn1euhlML1huGGXWeCVKOxK18le6bqpoMasM=; b=M3D/dYorK3RcIt7H
	jJ55aYz/7RKPCryvULpMhjyJ9CHcFylvfk/9r8H9Tn2J8jtVr2TgatzdVW5ocAzz
	KlFXjdcFtGC3bI4brJU+UxlgCUrsy5NCxQB6AFvK423OOVRf7+11JVVAhbuDANhJ
	L2L0yPns8sRASb9lkySjZ9xkYdGQ37kadKwbrS0+vxDvNpJXaJq93zyvQhvMMlV2
	Bzktpfq7R8KJtQyDbqDVqOjpjPsKyx+65fIbayk+NxEHOc+CbVMUjr0YnSCjgUfY
	y/2yIXnKfwTbicUp8R09X6pNgtrzl6ZCx+riHFJkKiF4FLWyXcaqCqisfooJCSrT
	FXqyfg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsd7ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:22:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87dfd456d01so1848226d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207738; x=1761812538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FruMMDEn1euhlML1huGGXWeCVKOxK18le6bqpoMasM=;
        b=YYYKcHX12bRlmfFBUSgmm9nWKHnoTWmjkNlxnL0GP8BUx+v4zMl40F9JbhDLUjN5To
         8r+3QZL6zm6CFSW2aLB8c3v1NlsFNUZECq8Ry7/tEFMD+ZVBRYYCvQy/DKIa2SYfohXi
         X3ID7DuYOYSilPhYVAxaV27Rrtyo/xoYC4aLLtB/ltAg8ujGh8xoZYCRcnqVonvkaWCH
         nLjzKvKpqomYBrpvUtZ2B0N99RtRjDQaGEo3VOWjTI/La7JINJnqGemXUtywe5mZgGLr
         X7lDEv3iNTDKslv0+yLx/zOXZp5MEUVHOoEcbJK6ahM8MF/Jx1LPM8is4gcApaJ2yNXY
         bABw==
X-Forwarded-Encrypted: i=1; AJvYcCXPFVpJGBktZLt22+EZLv9gO07tlYuz2SrF1YpPVc8l/egvqLuFE7SfG0R9tl/+5YyLfIjURPEqiSPe544=@vger.kernel.org
X-Gm-Message-State: AOJu0YzARi2tUJLc6eku1nCD86nKLBLzngFiIYFxMZuvQYeMFHKBEoTH
	lLme2eBQIwUXvH/0eLL+NjQszcC+C9LP/uCRMNNBI38kFBx0VGeDuAb81Fd8O78i/2h7AaMFgM1
	Kfh7R9FfYz9GcQwgbDA08v0Ll94SR52vXeWvE7C7c4f2Qcz4e6ARGZG7uNZHo1GWY7WE=
X-Gm-Gg: ASbGncs2ZhpnIsmWD+CxHR+I+97xqZE29RuAgTE1IeGnATeQ4mw0y+y6IBgfzASj2DF
	ouFuCsp9hJkVlPO9x6PA3p0ldcogTDQ9h6NrK/4vB3H+En/aT88XAnKxaAKXW/j3SQ0KRRhT//f
	yuuKceqJoLqXzFINTPXjyC3NhnEnethkzIJ/8K39h4NePEb8XWr1/KM76VzwJSn6rCm2ZD92617
	fNyclGk2iDIeZ33ekTmXmxWpQYLmr/KOzBk2550XYIsSYyFYr2bgKaO44kw35RvgVqLaCbfWv08
	G+ZEzvLzIMOvvXHRNTxPyapo9skjBQc+Xox6vIOHAtGWAlnYjJhmKKz0E2Vw7TEfhMf8Ejii9xE
	iV2X6iPml3vehJMTifLGh7QWkpEkzUsnEMt92bG27NJvp573BEMUt6ede
X-Received: by 2002:a05:622a:20a:b0:4e8:9ed2:78fa with SMTP id d75a77b69052e-4ea116a2337mr82965451cf.1.1761207737721;
        Thu, 23 Oct 2025 01:22:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2XIoSLrV1GTocr6bbATcJdQVR3JTJAVs0QtA04SjsNS+0NDII1q5KQNFmWxX0Qxq+jTp1XQ==
X-Received: by 2002:a05:622a:20a:b0:4e8:9ed2:78fa with SMTP id d75a77b69052e-4ea116a2337mr82965141cf.1.1761207737193;
        Thu, 23 Oct 2025 01:22:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51471c24sm157607666b.75.2025.10.23.01.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:22:16 -0700 (PDT)
Message-ID: <4f9573d3-41a4-4478-8c19-39716b29f587@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>, robin.clark@oss.qualcomm.com,
        lumag@kernel.org, abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX3ePcvfLs15e5
 VW5xbMc5IwRq5Jv8+LRUjmoLsYvyL7qYAzpRSJxadC38AKAL7iCCKKvC9dMVRjtZy0gXIJ7jtOE
 ZFIpSQvUp9RorrnivCcw//fX2gQZvKpyWnYr5kj9SlF0p4ehdNKJOZc6bz1MI6pwHqsosePuixm
 xspd7ur0w9ToJvjzfi3wgJi6uAoF2yaAGZFSvYWnD4FhhV63kKv+GsWa6ilU+YJgG1tdcW6kYv/
 0OfnAE+WizOfDgCN4GTJucfgy8Oe0qP6X1aWMaFsAwJuoESPdTCS4aX7ePsmjN0DtuiTJYGxVPN
 8FusjBoPW2CJaIjIst7jqM0hPYBFUREpQWO2PzvKzEndC0k9oGmbAmLU1bUM0NlBIVRIRG3hNUG
 AuM9x+ipXEVYIuFj3lkP/yQsKa0lmw==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f9e5bb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=91DCyrf_GaaWAzlYtecA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: MOMSnsmasSRrKaykezBqitsR1hy2uuBY
X-Proofpoint-ORIG-GUID: MOMSnsmasSRrKaykezBqitsR1hy2uuBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On 10/23/25 10:06 AM, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
> VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---

This patch should have been sent separately as it's not at all
related to extending the msm display driver to support Kaanapali
*and* it goes through a different maintainer

Konrad

