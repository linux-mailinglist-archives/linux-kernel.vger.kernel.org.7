Return-Path: <linux-kernel+bounces-814015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255EAB54E49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96980188B9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E82F39CD;
	Fri, 12 Sep 2025 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UdLbu8ZQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501D2EC0B9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680851; cv=none; b=FXdztRZNZFy5tm0cM4tPbQNMGkjbzf1M1H0kFIsltpLijxUoric8I5+BolG8+/Cdz9o8IXWv/VY4BHnNfx0VvNCfAENcVdHuB1UqUW8Dbx7PBeJ81r7iz9Rr4tC3F14wMq0Hq/I5h331ovFIB/UYMTk98MeP1O4Ioq7ZssC5O6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680851; c=relaxed/simple;
	bh=zuHcVRs/P6kJCSUNiitH1eNg46GUfx056dIirib4Gb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poWNzY0BMv+masoji8mycQuPjxJ7X5BW23NsLa5qoinLALokyjvDO3UljHBE7vEj9tZ9DiKw7LAi4nbguB2i/iAXIFUhpshQKTWjdCR/VgisjJSEsdhttgeiIxs5YDc4jq8UcM4/TMcm/QqaMGf7O+OKt29EnUqvUuRMmq0jMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UdLbu8ZQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fJlM014005
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lck0ubW29GTUmJ4yHo3n97jc1CGQR/8xVg8aTbAeFj8=; b=UdLbu8ZQ6J4UEA0L
	y2kLUExUGGRGmeuwnYa2xXBQ6fqhD/Vkzd9GY8vl/d/u1RzJ/Md+n0NskL8eP5T0
	03bOX39b/gRl0pt0WyC3ScvW093pGL1zmgaRYPYKhRGjpbmTPqTTVVSjPuu+D/t7
	KxJa3uRkANs8uS7g1Q+6FRNmVDh80kVwaC07GrklWtV28nY/Ps4+hZXcegP0Aabr
	4ssNQn8T8Uaq3RZX01rjRfO7Kaxr36qyShPsU8YhnD364xojCLEJ496S6rFhu1Mr
	UQ1WPPJ0RzkKAnvRF+vPMdlqNp8NLuITOW4XnlSaIjfcbp/oIZbDtH9G6nbliWJ3
	LvI+ZA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphwc76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:40:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-74910ab069bso3213556d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680848; x=1758285648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lck0ubW29GTUmJ4yHo3n97jc1CGQR/8xVg8aTbAeFj8=;
        b=lnCCSQQ96c8WrBkbWD4h0Ls65M8+tUdb/6FlXF+SgdFvl4Wq9Es/zPMcU5AKp+MJ+F
         wzFtcn5h8M+zAZvzIjewUDjaeIwi/5XPUSFk5sYnjG5EwC6ol7liLLCoAdrG4Uf5beU1
         nTwp+/W88CI4WbBejlqkeFyyqBOfjGN0w99PkVeCFaeYkYPkHDKku6hVU9lgQWiKYoOI
         P0q+qRBX/F3SlC9AHtmCN9IJnPmWNyQbSAvxaNH6s4B3P4So8CqQ2+Jg/IOkbck+JV6N
         7I5iSyAUcOo72Y9egB5uhpkoFe8TWFECPURdHLpSTLvCdskNrtZ4qbzrflHR/CtMLhFg
         /HhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTrgUf3OmsgbF7ZnGiQSfXi2XHhp9SqYjPlLV+31iKt7YtY+BFNVdHXNVJOsWAQhCevD9Gvt2cPdtMudQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfUZGglYUMifNg9GyQ2fdAVH20BbDobJ4dwui55I4FVzoOCn0
	giypdpwK0oSy26XxuTfTr4WWUER4wziccPyQlrAJSvGte9opwogSPfCz/nLMt+i/ToL/i7KuHP5
	z4xTrzhi16BqHPe6i8UPAzSgCBGHW4i8peW9EFDeqBKoomiz+t1GwF+pnqO3DrqdK1Vg=
X-Gm-Gg: ASbGncsrY9TFTAk+pYXqLfBYwN1YiNHvLzWuccK8/9l6sR7/sP/6UH2qGikclAAoj/u
	G2jQM0pPSSkjgt8+p591W/1q3pl7vexZmWRUyn/QkT+691e83FMZGWvm3O9omNT0BDZKNZu2y2S
	AesG4hjukh5iZZVByrVXHzPKXhNQrAkeOgUdQSTjCWm+YWWt9E+xv2eXryfzOCUxA+tOdaToiTF
	viu8Um8uDiiW/8EjycvK0i0pDfyRvDOqMwVnc9zueB/NeRjDaFPFU3qOQm7vN/YEcqDvkpUaVs2
	2KfBsAvm6dw9EY48Qr3OpGxOT9O89OK2v7Tkm3DBjiVXrCYAxF5FjN6WrBYSfuQNtge1iiXRKUB
	ISwUzxCCvHoe+Gbn3CZpUew==
X-Received: by 2002:a05:6214:27e7:b0:70d:e276:efd3 with SMTP id 6a1803df08f44-767bc025260mr23384086d6.1.1757680847526;
        Fri, 12 Sep 2025 05:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBBLxtMxPZfLylJXd171i5aVZ91RwAFkVf95DRlbwCzPJuiY8Ut+YWJNPZGJ8wj/hfASSNlg==
X-Received: by 2002:a05:6214:27e7:b0:70d:e276:efd3 with SMTP id 6a1803df08f44-767bc025260mr23383616d6.1.1757680846902;
        Fri, 12 Sep 2025 05:40:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec6b6cec5sm3015885a12.1.2025.09.12.05.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:40:46 -0700 (PDT)
Message-ID: <f610e2d3-cc8b-4a79-8c28-4be11dbbe38b@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 14:40:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/msm/a6xx: Fix GMU firmware parser
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek
 <jonathan@marek.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
 <20250911-assorted-sept-1-v2-2-a8bf1ee20792@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250911-assorted-sept-1-v2-2-a8bf1ee20792@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c414d0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1NxERlzXQmXK-yb5iVsA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: kJNzIt5zSywWy8lGj-QrqWcavUDWamK7
X-Proofpoint-ORIG-GUID: kJNzIt5zSywWy8lGj-QrqWcavUDWamK7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfX+gFdY2qrnX+P
 IiCSzcOTOOFz/UekWn73+RsB3JQeB93/cO7OuyV2GgmbnMgNw95jWPfpBuVXRuPc/zYlMNNO5D6
 5iGsI2Oszn5wpSNFJbRu8dyQK++LQ2/zKL0IqQFTw7A/za0xwHzKIfqfJXCGlWLpva1Wt423pSC
 nGiFsQK6I4Gp30p+qtVa7GTTQTd/RYZcxSrU1w216XTlAwYVp/jOwEohpeoAoWtdHy5XSNCKKye
 6tnmBCRDj8S+b3SzKLu09JhcYP4FrnKtEpg67JRHl3Voal9X6i1KM0YIqwC/hta/MReoa4OV56o
 JBqT2iCbRBO4Ab4RDs4mBZpBgmPFWijJS7t6KVF3mIhtLCEAHGsPf/yqMLuuvHR0dv+D5aRUdNA
 oSbAMGk/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On 9/10/25 10:44 PM, Akhil P Oommen wrote:
> Current parser logic for GMU firmware assumes a dword aligned payload
> size for every block. This is not true for all GMU firmwares. So, fix
> this by using correct 'size' value in the calculation for the offset
> for the next block's header.
> 
> Fixes: c6ed04f856a4 ("drm/msm/a6xx: A640/A650 GMU firmware path")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

I'm not sure what memcpy translates into for unaligned addresses,
but I'm going to assume it's handled properly..

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


