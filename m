Return-Path: <linux-kernel+bounces-832072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DDB9E462
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624663B5341
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF632D9EF5;
	Thu, 25 Sep 2025 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="owxgzDMu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AA1552FD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792051; cv=none; b=HYhkhVtXnVT1h1T5h9PhbV1fs0HolbVAzGFC9WHx2coRJdnV0VJea8T99Uf49RzIdM+B6mZyn/2gY/qMd9kCmyqippnIyqfBTGxC8NoCYUlBQSa9g2mXrJSNYyiXy6//Mk0KisovMf+SIegZfzz96poWuoeKTGSgGy70b01oJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792051; c=relaxed/simple;
	bh=rRSNO0HrYXDp9U7u3xqD9uyslqRK9KBJ8DGC+QY73uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJZWaWgJQm9fHMTgrTOR8ON/G713nKXvwPXRqqhwnCFLHDAbqNtKFgvdvwhpNFutaFuj0TAjxZx2BfJ2NgFwOLB6Y8iU7IIYHO8p2Ptp4iq4ypuh0bEeLfEGvp/RpxQdYWPkyzeY0tnUKs40CzYUsqMAsh+vjw2/B7ESvyXo/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=owxgzDMu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0VeGM025075
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J03QPepsogPpGOX5Hp1cEWYgqtb4aYw0wehT27zRwhc=; b=owxgzDMu2Fk3akuO
	VePtbRXRjuHYx2ZWq/g6KNqV8mw7XOy+F2Q1I9PSKa9njAGhk3dyhLcO9/GlR6Aw
	fj69wBCMRkyajcj6HJrInkarA9M0wKRSSpwU0dAVkXlymSVvzd6ReYrM9YJ0ePKa
	EcF4DuFYcLcQniD5DhSjB34AnRsnXa3s3GXM0OpcQ/oxRczgzjrSWqiBMpqlTlXN
	ePkl2Kvkp82f5ZcZnAkhc8LDNlhAuQoZhKO2eHWWjZT2MrxFHDyX/0zGhb54QmlZ
	hrM3xM1q0MHlSmdWKo6nSJSqzEHD+pbCAN2xOAapiB93m2P9fAtEzqIBjL0UJqVN
	E7QGEQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeyvb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:20:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85db8cb38ccso5978285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792048; x=1759396848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J03QPepsogPpGOX5Hp1cEWYgqtb4aYw0wehT27zRwhc=;
        b=pc32eQaGGqIuyWpS6Gyby7GYnk2kVnS6LnauZHKofcFtfv86pJ0qB1OIPwdNfhpDFC
         0PFPGPpWwrcQolljRL2adOksg4wajqwcFINY+tNf9AjDyNKCLdjieGq6MXLvzVeGfol8
         ONV3SkjCRcbYSlKdb85jirHp+WCkHEfIPz6z2CcXUorDuv33Mr+/x5DuTp9qy86A923Y
         dPCK376clEUtaXjuJr0CGQepMjRNi4Xg5oUR27+xRTb3BiPGUXAbF88fsJGlgn032bf+
         B5De+fh/kfsHBx/GeFWycVKWblDPjwvPtLOP6rqtC+88eX+Dxxes4ohxxQLd+6xmwMaX
         8ybw==
X-Forwarded-Encrypted: i=1; AJvYcCVedybIRVw+q7i0SXy3nxdUmi84H4HipRGjYU6KiWBX6lUZK7i+db+ILSW6vZ4q0hKobW6UdgM44hJbS+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQG6wO0ipcT8bnHFhJF1tzw9yqzKvEMBPBcFNDgG/4OyTD+MM
	BbmzDOgKzhAKu1pSdy2+GU3diFisKnXCV1pTRZ4pMFLYTR71OVhnkJFXDZqb43Z7nggomOI6iTO
	J2Wb33zXeoGS9S9QZmYMIpoqg7fQd+2i9TdOlogal5zDbcrlstfniwZA/9VRsAkcYKuc=
X-Gm-Gg: ASbGnctnkOdzwzOAZbFnUSKEDGIlgTQH2x7qANwJ/cjupNyKal22jYQmQRt7sUG/IHT
	pQKJzK5zmiL6RkkPihPM/7fSUglT0jC+f1HVI1NLFeRaM1wkIY0aJIm/OK5qEij88sbmSUfiCiJ
	yzWBTwakNoQPOWTnRuR5WHvX3jCrEjxtkszLdS00U1q5Ek7kuOMhwisI8LZSRYy50OwkqPjS+nm
	c4YE0+euKfr4MiXh3+VX5PAXGeZVQM88LF0E7/xpDE9+uYIEs+ZJkhbcJLI0aeAPDR3lyVzUIOn
	RYYxYiMB7n9BgI7hdsJ7aq+3CNvulXLGzgwHe2ckRjcezVOKYkZcMX6MMNyovj0MF6hRntLm+57
	+q6FiyjZ9buWnN7hgpeQRcw==
X-Received: by 2002:a05:620a:2954:b0:80b:2e03:dc88 with SMTP id af79cd13be357-85adeb4da48mr256639385a.3.1758792048233;
        Thu, 25 Sep 2025 02:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxlKFEMgfLPnWUY+9AW+CoP7+beslOB5aFZUiExK3V8Ym0wfYrxR4gKAsXlJWjx7TSAIaVSg==
X-Received: by 2002:a05:620a:2954:b0:80b:2e03:dc88 with SMTP id af79cd13be357-85adeb4da48mr256636285a.3.1758792047678;
        Thu, 25 Sep 2025 02:20:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fcddf1sm129596366b.77.2025.09.25.02.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:20:47 -0700 (PDT)
Message-ID: <55ca6423-a27b-4ac0-9c36-ba20bf8172ee@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:20:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: qcom: sdm845-oneplus: Describe panel vci
 and poc supplies
To: david@ixit.cz, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding
 <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20250925-s6e3fc2x01-v1-0-9293016768f7@ixit.cz>
 <20250925-s6e3fc2x01-v1-3-9293016768f7@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-s6e3fc2x01-v1-3-9293016768f7@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Tlh3if6-SuwLpu9SPhxAXR9NZqQ7HONi
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d50971 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=CJSKMeR5ttdQttduZpoA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX23NyERspr2jl
 WhdoBM1ThQ54h2Qmpa/rzhbuDy3ID9fCWpev+EOT2DmdW8EhJihAvfBEbX4RMrr7eka90MNf0B0
 FBdODJLnaCcZW35jHx1z9g4qKB8EL7/aS+TQfqoV6rlpMGxKhV/6S02Sxz3ausV6l0VClFFHoIP
 N9ANTtpSbm6QSqfwyK0LNGWdg9GFoXrivml8yjcIHmdChp2lLbvIVgk74gA2mVfAyjJombW5zUr
 xhQfTR+CjqcMat8tF1uDzN5t04BPDqsW7Y9Nuo0iczqucVQrXir2WAoR0jt2+h16tOmzDWj/cbp
 NTKRs2UIDkxiTaBJuDOPETZh8dAITAuQB7HMcegPHwLnIjPa83Vk+Ki/ZoyO+MNTTt/BT7pJSoc
 7yJ9IcKK
X-Proofpoint-ORIG-GUID: Tlh3if6-SuwLpu9SPhxAXR9NZqQ7HONi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On 9/25/25 11:12 AM, David Heidelberg via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> There are two additional supplies used by the panel, both are GPIO
> controlled and are left enabled by the bootloader for continuous splash.
> 
> Previously these were (incorrectly) modelled as pinctrl. Describe them
> properly so that the panel can control them.
> 
> Fixes: 288ef8a42612 ("arm64: dts: sdm845: add oneplus6/6t devices")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

You may want to add a pinctrl config for them, to ensure the
GPIOs are not in a funky state

Konrad

