Return-Path: <linux-kernel+bounces-838718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCEBB000D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4570189D945
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08582BE7D5;
	Wed,  1 Oct 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFYnG04l"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD429D289
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314400; cv=none; b=ByhfdKqI6N4tqfg1foD1kI1PzIgRazRWWM9ivLcFk1YdNt0uH7dv1lsZc22V7iK//LrBDOVQt1p7l7/O/RJ5Pu4AjwCBmskm/EYkgsPl9vj/ZWSvc2ZA2qEGtFIyRD7SfCJKdGZCzgivttejd/72X8AvvbCLXSqfaZcUDCR1NPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314400; c=relaxed/simple;
	bh=P9Fi1ljGmUThr+8jSoJFfTtVJvJR05niVpmpkyA/Ack=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF8M+/MZzOA5L6VLxSueuK8n9ahU5dkxKD1WaJWwXzw4wPRpVIgV95MQ+F0QFRfUKrTwe5fAyywomTTfven2svWL5a2CbtFBejrLwCFTdtro+TaFVDz2ila4czONDXOYVEbYSDCsmFYKOAMaAyyTb8cT1+wax1etbLW/co+7CyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFYnG04l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5919FKr5018092
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 10:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DoYbUoPn5h4PTq/YMlb34TeBwVEHQG0ctNULUvqXlU4=; b=dFYnG04lUAn1n3pJ
	kr8Lw2MzF2HEuD3idQKToqoMGycgOC0qh/5s8xl8OtIEISCDnkGm5VF++zLZ9hCq
	TmOTmb9jZOg2qg9DVoxZG+CDxF9EnH/ZET9FKO3TMFUP6xYq7a/3TarviUNU+oaw
	DnPWz432ZOZ4haFZnglikO17pBSZIuGh3x7UHckGZ5jLjbJUc95au523eiaRJZFM
	/zelny9foSERCefZ98ZWPJjLqiLuS1j6Zv43G4QfA8uFZSmefmn5K7aD1Gsz+f8p
	KhgTiIEnvKCQD2D1BHyHEgPeDb+3ErQqinndDsPyAgFw0+n0FGzk3iag+k4HYXYE
	DVPc6w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hkvtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 10:26:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78106e63bc9so6299056b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759314397; x=1759919197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoYbUoPn5h4PTq/YMlb34TeBwVEHQG0ctNULUvqXlU4=;
        b=O0DSyIgb3sBwVtEBa9tw415BVhrT5SGAQtgSnBu6CxKURY7lEBovBLMdFzcBr8c1/+
         DoL9WH6HjMx+9kUfPcGvM4spq76J37zist+kn1CET13YDIME/5rIamG09N9XUxUIisKl
         V/b3g/Fm72pMpsXSgLecUuPYT/DG7mwSEO/giRZhy9PfTaV6WvwHxa3prSiraYNr8xBM
         FXQ8+6jzQxIC7PwYVilBvjejNsvSzuLAmSBxU9N19NvWPUgTOE9dB74eGyZTsFmzY56u
         YzhUGeJQ6gGOn1fmRxnQ/jO7QsCgsmj+/lZTZu0ajr50H38NtOn4vm47Q/tmdaAjfMpa
         dmLw==
X-Forwarded-Encrypted: i=1; AJvYcCV3A2JXy3mQZWW9GUDBruY9bz6OR35bSYHKLC/+aynsj3uHyKUmrzHfNBA0C2+RdBaoP0CRwMKo8G0f6qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1S1G/uUEvBaS+xGnlGXBFIRp3z6TfPswu1KY76Yh3lh6DXYsp
	Krt/hYAipHpNppwcxJuCrsdecVfI6qg50XBCrT2zpZh8+rAU9ZPgaQapEqz8DuZjoeuBLDcLm6X
	2gkIQvPpnXL/Lz3KbcAc5AkeDGsuPszOECOex1cteSdVF0fLD4csjr6a3r5+J/vaKj60=
X-Gm-Gg: ASbGncvnIxaQPD8pN2X7/Qq452GqVY9rQHm4UQBLic0P79gIfj8QH7Dw575htOhmOSG
	VQu4VGinTAq++m6GkbPDOc01fjkH7Zw95R+cJtToJV1HuoPM0YDvOUEu/J64hCsJjb52RuCcqzL
	WzPPPyQiI4wjLIAVpUoWuGWp0/7O81okY0dtNRM0orDXXJKk4h24ydQ0cdWPRS8Gx6OGbpYl9nU
	OF6lvNHLllTgTNKjTkImcaGDO1X2sJEE76I0xj24+E0hXQm19Wys0/ujf/pR3AkoxoKKr5RItME
	+IVZSsPw4l2B324iypOt7rUn5io8g9KkRFCVfdv4Yebk6FppR9GxFJ4xREeJmrkff6faP5T248o
	zDot3
X-Received: by 2002:a05:6a20:3946:b0:319:fc6f:8afd with SMTP id adf61e73a8af0-321d8b06ce0mr4302622637.6.1759314397533;
        Wed, 01 Oct 2025 03:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2JF9jYAQs7P21pVRc4kQw9xYk9dAr+RziIcU6cRwEF5tEhV4BHPHR4FxDdHvAHzFGnPlBNQ==
X-Received: by 2002:a05:6a20:3946:b0:319:fc6f:8afd with SMTP id adf61e73a8af0-321d8b06ce0mr4302582637.6.1759314397056;
        Wed, 01 Oct 2025 03:26:37 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c057ecsm15876881b3a.80.2025.10.01.03.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 03:26:36 -0700 (PDT)
Message-ID: <671c517f-c04c-4f07-aa65-a93e1e1dbce3@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 15:56:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] i2c: i2c-qcom-geni: Add Block event interrupt
 support
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
References: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
 <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX40Xjvb8s80n4
 CbvvyhzcwRw7L+SD0trvSBt/8orG1ZLsPL/hrSmXjxeNkZ31S1sAiQaaA7f2brrpzCmi/yYIK6R
 P+dtkTdqVohawxd37Y6woWFUGXjPWbm+7po5M8oWgP2+shVRJTwFoeT/pwM+ChSr4x7TWUq5Ubr
 MGTTwNbrpWEX93AoS+1HbIZwqj0g6zb0A2kv3XPZ8EoVx+mgzH6Yo32vQCLs0ImvxezlVNV5Fbk
 FI1hg6kegEUznjIu+VXPcxXSBLSNYoHcY2NZZBGwOWDUR/wqcj9iiiG4Q2jwFPxaZigoktfoki1
 byk/XMIPtGus2UVbYZc/POJqJL6XYLosxSsemPxt7KzUc74UDcpQgBuUI10bEUtgmONiQsHPKBn
 G4cS+q+E4K8R+u2j8432j+pCZlBMnw==
X-Proofpoint-GUID: Wp5NAogHQXi130xX1FYu0lBwJYT3TJlF
X-Proofpoint-ORIG-GUID: Wp5NAogHQXi130xX1FYu0lBwJYT3TJlF
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dd01de cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=fvgdV2PV7z-sFcuOFeoA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041


On 9/25/2025 5:30 PM, Jyothi Kumar Seerapu wrote:
> From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> 
> The I2C driver gets an interrupt upon transfer completion.
> When handling multiple messages in a single transfer, this
> results in N interrupts for N messages, leading to significant
> software interrupt latency.
> 
> To mitigate this latency, utilize Block Event Interrupt (BEI)
> mechanism. Enabling BEI instructs the hardware to prevent interrupt
> generation and BEI is disabled when an interrupt is necessary.
> 
> Large I2C transfer can be divided into chunks of messages internally.
> Interrupts are not expected for the messages for which BEI bit set,
> only the last message triggers an interrupt, indicating the completion of
> N messages. This BEI mechanism enhances overall transfer efficiency.
> 
> BEI optimizations are currently implemented for I2C write transfers only,
> as there is no use case for multiple I2C read messages in a single transfer
> at this time.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 
Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>


