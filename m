Return-Path: <linux-kernel+bounces-845170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B716ABC3C23
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D4189F85E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB834BA3C;
	Wed,  8 Oct 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+2oxcFl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681E2F0C6A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910889; cv=none; b=iKllgUa04wyOxSmgL0Mmuy2jGlKoJiqEodDUeu3frsH7+lz/LMeJY4LEL3D6HkQHrlP2VI6poGZquvFXU5ugbiDt7QbiPX3LHxB+mXuTtktMeyTtKZcLJ4AuDNbzKZwGLBNZgREMLH3k6zI+TCHYW7RaCSnMTcmkGPcifQFvG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910889; c=relaxed/simple;
	bh=VdZzByrGm9DNfUL78lrekrQ7xUzYKB0wMwu8ejZF1Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLWZ9eYpk/x8qfSZMi7HVGLr5fLrDsIHDMFoQeh4dxRs9J2ZZHhH5bq/BDjkHAb9J6DIPR54IAGX3Q89r8CJyHUmX2QjJQpytXGDHCNRMDI8A6Qiqr1RffNKFIakKfeWv0fRfxul4hcavD1rU8G1VR12qZA8ub2xJeElQ+go2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q+2oxcFl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987aXZZ002367
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 08:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jnMEMnaUqNraMukID0i6yy+MPFFPKz7o4wOoLN4ozFI=; b=Q+2oxcFlWtwnvkJR
	YA9/+F3BkFJW0U0+VSERXQxFok8TL859aIPcz1V2YhogjTt8kCE9lwU2olbtuYOF
	erNZ7Rn/C8LqKH54HzAwDW90congUTHn/nHDTxkey4cfzfdmwXdUrth2VNwUhVfZ
	Pg0aeQId58XwfmDsuk7MXJLVoAMZEwpw/Q0cgo9fTAnDsANfP3GLDJWcEtEqyI6j
	l7pkklMDafRmrG3U+nmekkt0AX+RZQ/JPSQT2cMhEQ88z5I20tT9Zv4yttn/O4Yg
	jL/EY7/FL0vkGY1U7IxQoFGERTL06A1O4t1/S5iF73P9o1/WFo8nrQdd8g9bG45z
	C3aS6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxna2d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:08:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85a8ff42553so124904785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910886; x=1760515686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnMEMnaUqNraMukID0i6yy+MPFFPKz7o4wOoLN4ozFI=;
        b=sp3Vk2WQ0u8KlMpcBTlZQ3IcvDJ74BpQ8BCZbhpJFzb8NMW7Xjzt0okAtrQXwB7ODG
         At6TRsmUXMLzPgnEDbDt2qqteEc3hrvMX1EtLHb7ml0humULuNweBGyfzARDgI1vxSbT
         VHWE6u88t/UP21OqxavqTAv7mzgcGSknKi+HQPa3dughPLo2JRIX/pa083HlpPer6H+j
         9AVgQf5mVylYs2vAIZw5G6RCLXj5IREu45/2Yb+tWOqcrHAAfZz02YkyIZH9l1S9B7wn
         61MxbWvTE+tWlFOiBWAGUikCnFLFCGA9mXF0dwmArYoltQchKr/8cuZf1z4kj1CcVSZK
         bxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCViHSOn8me06WAtgewAY2imTQHK8BA0wbHzKtuXdyhm2pWu680vkj47Yt8y7RrELdKceIeDKpqcrHEb/b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAiUDpXMgVmHssdK+QTnSh0hxGRrdx/y1PuSFIr/q1UBgKNQiY
	LtQ2onqr542Aoow0rVH5kbC86cCBUGXnqCVW2n9DQfNZPZYdndD5nP2jM6hHJqtaKiioSyynvcd
	kasad+IaeACCcqLIVxBTkaCcswXnEAKtirJaofNBhChHpnMjVYn4QpCFZenOqt09LV9o=
X-Gm-Gg: ASbGncvKbHW13U77YrASoa7C/PvwrJwJRL7xIxHbJdDRzQqCsZzGBH/jp2zEFA35285
	t8sDc56jFjZayKkEiZOkuVTmnXvr5ro3TCwUMjZxcw9tbo0CaQWqVRRftjCKPJAO59x0MNOgCP3
	Ri3npG84uVM1JmE2WFbbriy/zy57nJaLIM0GI4lgzeA1fAKR9w+sxxMtOfXSZ8wSUv01tYNohkl
	WZxchRSfofREKZVWipDr4C/7X1J+iOTzINPGJkQLAXUnLMf/6FYC2cv/0o/SkDdWqAEPuR3vV22
	j3uiAotVbk4KEkdPGh9CsfSzwjguKWV8+VDFp2WR4Q+7OQevnI1zMyyafE+MXk0r0KyVx7JBR6I
	uwGFpWi3vrzhBwnGBGJDdlfj60GE=
X-Received: by 2002:a05:620a:199b:b0:85e:3ab2:960e with SMTP id af79cd13be357-88354ac50bcmr223784685a.11.1759910886376;
        Wed, 08 Oct 2025 01:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/zf47wSrjlqtPLG8ILcAawn5rD+RpQ+0R7AZyfqB1Y4zsUZzl2+3Yu9BwkSfmCvg9QGzqlA==
X-Received: by 2002:a05:620a:199b:b0:85e:3ab2:960e with SMTP id af79cd13be357-88354ac50bcmr223782685a.11.1759910885805;
        Wed, 08 Oct 2025 01:08:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a177c62sm1568922766b.91.2025.10.08.01.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:08:05 -0700 (PDT)
Message-ID: <9278d526-4759-41ba-8c06-da909479c3c0@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:08:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] media: iris: rename sm8250 platform file to gen1
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-6-def050ba5e1f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-6-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX2XT38VNdph+Y
 E++RPw2e3HPreoLlj01hQ71Petz85ahzCydbv5z5mxruc/vg/EW3piEKB9f2xk2u/M8Zc0acx0O
 hq85CDoLVulFTjoBOwucImN5YbAgRuCSKJf+l8sC7zin21Dx2PCG0oTIzHbTlFOFq/3Tdnnpsy4
 0FEjy+b/QkHdA5Y42fAplTZL30i2Vz5YvdEnGOMLOIRUOTMsv9IhUfCwJw6pHaSLG8MhRQgUetK
 b1nqjIMx//9/eexglvfZSgRil8LkS29o9BXirNOuY0DWM6e/rtMj9YyVGhRSSfjmLg7ixR1D4mQ
 GDnu0A4alIHzZnk5pb4ICHtcwnJSOYsRt76qTCr+R8Rk7fQSIpIjMwWVw3YLGjzr8RtANnvvG7P
 jsl3KnlJzEQdo+89+npRB8AV1Wcz6Q==
X-Proofpoint-GUID: i7lcyBc931v-cmAw_gBYQwJIfelqFdDk
X-Proofpoint-ORIG-GUID: i7lcyBc931v-cmAw_gBYQwJIfelqFdDk
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e61be7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=tkggsdbV04ru4vqEU2sA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
> In preparation to adding more Gen1 platforms, which will share a
> significant amount of data, rename the SM8250 platform file to
> iris_platform_gen1.c.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

