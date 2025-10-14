Return-Path: <linux-kernel+bounces-852101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF6BD82A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BF518A33D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E738130F55C;
	Tue, 14 Oct 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OMxMHk67"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E530F808
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430342; cv=none; b=UkIUXKRZMOrHcINURWngbq5qP2Dt5opTq6K8jcXgp0WozbYfuNQtajgdm85pMjjqcodEO/CtqRe7KhLAxeZBN2fhX72hmhYwgElaXtt1EFVQcP9IgHgdMw9qHXq4d2bDHV3JwjiWaWzI3gZbSpk/Xk0kRiQ1fvoVpOPGv1A3O5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430342; c=relaxed/simple;
	bh=bqbERKIw/xSy0mRLmRp7Ht1mMntEfecsoPf4+hpZs28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKuSts0xlT+uiiW53dCrtkewmPQN/GtYkdeuyR6wME0GdsRAzxR25rxX+qz5iBtL7i7D/WlcNa1HH9aLtESRMoPIYqkVmH9rNbVQu0IRiWxA3kpvNEcTqNH6Wa9fuiFGq+orFxO7yQ/NfEIrHp3GgAdJY+eHzvtJXyV8YK63hOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OMxMHk67; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87HkH009005
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gSJMVS9Iibrg0L/GDCLFrpAEBfnCWQ9ZrgtUzwHovaY=; b=OMxMHk67D3m9lmG5
	Qf8GII7VbXgpfaWizxdDv01iXoR/6+gFo+ZR7tOvAdYpVhvP/y69DhXEP9IhtuJh
	uay55rqs0XUa6dSTTbSZA5DmpkLt/c5lQciICJuD8Fv2B1LgFJQ3URN3XldN4oYA
	mWZVFkSXy3DrTGuk/8/Z16ap/OnZI56kpxmn3T5txDeWolz124EvxYAHDfaxzeA0
	Ot5720xnQxuMpu7xB9HqylYC7Gqm3pDr5q9d9HnQzsOf3bXGiUXs9L1Epe9oF2CB
	0/J6i4i8y+kfJ2hxTuC7lCWASo3AOrK4ug1d/MvM7YenVeaggNqRc2G581Gptv/R
	yxxcSA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5frk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:25:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so8514538a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430338; x=1761035138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSJMVS9Iibrg0L/GDCLFrpAEBfnCWQ9ZrgtUzwHovaY=;
        b=mLElEwgChkaB7nn/ZCnHQ8cYvaZwqpDkHDRYfimVDzSyEQjNvQkLed0WIDm23MUvZF
         tw0xwlcsMIG81SDBDupHTAgpHeRBOM2E07j9hG4p7dH2HMddme3uQw3vb2c0vgYoHRQX
         QGj4IgYoza6ZxQo95qmOy7UtU23SrNHPhceyHIWARXk2z9+u+N2gl0jVHaW7sxm7GXa+
         qAOQALlKYTO0k6Zj1WGyGp24vHj0xY5tW2X0GSo6buTFJKbTM7XeZ4P4TVHJf7hmezMj
         1bkbLUOxSpRxtSw10FxNbE2TspBR5M6OlclGjrNAECgIyjUFpR6FLQ2X5WCYB34DRYXv
         01zg==
X-Forwarded-Encrypted: i=1; AJvYcCXmMMLWtREKzS0RwQVei5kJdpL5S+n+97lE0YjwFRgaxIIc6zwgGKDQwrm8+Bx1uhJfQm64gLGuwjRzETk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJ9dS3Tki6dwt80XFHTdChcN8qJqwpYzoPYWl24zl+qoLY5Y3
	Vf30Oqifwr+lu+0xNeADXMxDHv2lH0uP1fnLGe2Gf2Vb2uCL9Yq5yDF0uRpAs95EW4f7sNsD2Pf
	5iXNv1hh8ZBQK4EcrPe/MK4lEwo62kqmNpJihy8d7hOvJEnoeP7GmsevkGi0WsVbUpIY=
X-Gm-Gg: ASbGncthcLu4AS2+zrPMUSpNLxyRVugygmDbUxzPRnicwBPXQ1YEgKVHzdNK++cTMsv
	cqOcnQQXyhQLvA0VGUOW/f1uBFEdSN8gs8tfqkeAkHfvASZaJ5+KP34kSX6hVLpRVjJVpmqm7TL
	zSETGERw7gn3rzg8DAk/h/dwIo4yUizOvrmnBLpZ/C5xYGFNJYWG3dhW5r+2rnoeadiZPMAYdn2
	7NAEKnYU19OotPLpy4D8RRu+vcKMFxAUDKScFGl8nCOQyQcDvanQT3gt4VLjKAR8+17E47JJveW
	I6E8qstX3Bl/OK2nY1E9H9+CL8whuDh/9Bd2oKsrgL37JPZhA846lTHT8zjcd3o4e/8eu85s
X-Received: by 2002:a17:90b:2889:b0:33b:6e60:b846 with SMTP id 98e67ed59e1d1-33b6e60b8d1mr14896204a91.11.1760430338202;
        Tue, 14 Oct 2025 01:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx77WB8/5wRwZJxz+GXjiMEsSbHz+VvV1kplZrzsrb2qudf5GAaryBEY0nknZndSGOnrfo7Q==
X-Received: by 2002:a17:90b:2889:b0:33b:6e60:b846 with SMTP id 98e67ed59e1d1-33b6e60b8d1mr14896178a91.11.1760430337709;
        Tue, 14 Oct 2025 01:25:37 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61aab514sm15042035a91.16.2025.10.14.01.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:25:37 -0700 (PDT)
Message-ID: <d8d26b77-ef20-7c09-147b-5b8f54f50483@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 13:55:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 6/8] media: iris: rename sm8250 platform file to gen1
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com>
 <20251013-iris-sc7280-v3-6-f3bceb77a250@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251013-iris-sc7280-v3-6-f3bceb77a250@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ajqiBCF5G5jqmEaCOG0QqvpsGpVIuAIp
X-Proofpoint-ORIG-GUID: ajqiBCF5G5jqmEaCOG0QqvpsGpVIuAIp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX+H3XetrttSNN
 fslghYdj9qCs6/qVoJIquV3l/RYgUKiHvHBLjMngbyhpmcgg36c8s4Qxz9h00N/vtWrAtsHPaOU
 0MgaCM4vOszcAf1WqVvgMrWNL+VbIe7GX7urWisbRdSh4a7eTLFgTOpF9w1eIjdbNwS+fYuqNNT
 nbTdOkgY8J09RELVv0X0jk6qZkMdhFQ1Bhl0onHvJ0HAlX+fv1tsEpkzOAgBkQfJd5JtMtYpABy
 RoP4WtwRebtnPHv0CrlsuCByaTF4hDmpJQJbr8Rq48GFGQ2phceQkEcxVNXnxSZrNiHWqFv61ot
 j+eIxMtPc3h9I2L8zofMc9c+Lc0ymj3QKisQSFvO98J585rBSKh4Yf7mCfSAnRTvRk6oD2c2mUS
 PlPSgMhl2PG7En8H+exhKaTklMdh8Q==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ee0903 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tkggsdbV04ru4vqEU2sA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020


On 10/13/2025 7:39 AM, Dmitry Baryshkov wrote:
> In preparation to adding more Gen1 platforms, which will share a
> significant amount of data, rename the SM8250 platform file to
> iris_platform_gen1.c.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Makefile                               | 2 +-
>  .../platform/qcom/iris/{iris_platform_sm8250.c => iris_platform_gen1.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

