Return-Path: <linux-kernel+bounces-862870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393FBF66EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA4F405284
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B748932ED2A;
	Tue, 21 Oct 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kx4/jx/g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9F355034
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049056; cv=none; b=gMU1plUCq8PlgaBGGVJessVVzjz6h1zaTNtgW+L1Wo2A3YWQZqYAu9Z+KBmd373PaoeFxkBM1XDAGn+8LH0K0+qzYVSFoSzejVAsbMKWVR9rXcWTwKJMsYXoEvyJ8mivK4Nc283GxBio+BRgUrWKgNfJnNGGu+x1QjWa/9wydwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049056; c=relaxed/simple;
	bh=Ik8YTK9+li2kctsxdsSAX5UkwYsN4owKy1yNpUgTOtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8YQEG55mEvOOe0pZzygiwfmteaKR6fXQNsAsg93C5gZZE8/zZKI1WLjMZrVtniDAxHB9j5l0SLep3/SKZyQ0rwubRGDGG+3Q4WV47Mhg76+cYtgHXmxF4m7OtkmhpbsX+Y3X+pR6lJxM5YpiVTG8TE3it89R2bE9ovr37WBlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kx4/jx/g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8MQ9X005407
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	62ij7qlH0jAbXbq+caCTrSlt+OeWrvirXMKUpKG5id8=; b=kx4/jx/gddJzriWr
	YETzYOVX786PvozAsP/T4Wz0FOx8akCyXqVgh5Q7dVI9f9K2ulbuUv4FKE3xhdHS
	cWXt/zrzBUWrlcTK0NHwzyeIYFcV8HPjrV+R/ojxtCu3MiFTFV8VS/aQT0FBfY8p
	UfeYLQZQ1kplAWEuGdy0ptYjmERUddoV2/kXuh4cJwCXlC4RsyBT2bR68L/Z9HET
	K6H89njqOkq7x+GQMrSxPN9JoCCiiqGvWscljfeGp009COA5zMeF/gtmbfAH7tFK
	MJX7SAEZ8AFP3tOAf3KgrHvAEwgGGMi1FwrDkkpQBmGOsW3e5oMKwonatNsWa+XJ
	6U7FSw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfgjxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:17:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88f3a065311so204925385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049050; x=1761653850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62ij7qlH0jAbXbq+caCTrSlt+OeWrvirXMKUpKG5id8=;
        b=HRthaAg2sYVphLdg9KD8fx+CYMvwoixOy70pUuXTcoqBkybFpWfsEUWqLZ4NlfKmlJ
         JJuDakgwQkJGjFOyek0RydSpdGn6hqsQA1SwgO+uejT2uCQtJJpyVSqZdxPwm3retAbY
         kxJiwcN5JYGncVZUsOkgzNEal5JAeoDzh9pJNEVW8Hez+KlpVL7U8FNf+mnOaFkUCGj4
         Zoz5yl44yYB/FYQRHO/EXmCh4Q/j5aEP7TqXhoXZd2nGmmATrSVM+hKs5JcSS+MRqb0c
         BVm9+DNKmr5kYWDAn6po2j8wqvb+A4jebv9m/ly+0YZZ0Pg/2jolLHiregx4W86PVk+Q
         RRSA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ji7AwjdUJTTqRc3VI3TffHH6jwse6WDTTesRy+vbcWvbc1CEgHxS1qQf3j8VGXRAkDME5NZO5j/do6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmpOJZXaYkFK4Q6DwFJ6NvBZYrucg5cPbLiDIsfH4iQEa79JdU
	rv2dkS0ZWAaFUYLBKSDs7F8oXgwhQKgkUIgCdi3gu5tnD6Bfke84V9lr1N8Y17xHCBc5YlK/NfK
	FB9HYdvm2bThKNubKp4vObMOJ8StpilGSHVjOJ4e8Fis++VeJQlZMjLSAZ7lbzn0CkDM=
X-Gm-Gg: ASbGncv7eQPWCYHDCy81P0utpO42bI4nrIfCmvkQYCZbiq74OU/aZkHBd2TL32+bRSj
	Um9rHIBciZtHinS5suxr81HsaS6vdChXC3y/+XLFOzzu0b14+DwfMLyuX/arG+9EYZDDza4zlSt
	56YAPjKC+X0ayTo6hF+l3fUBqOcrYyBK0uDo3nKLD+iTsnvbnaVcY2ngiXFQ/vS1g+q0vk8TLzv
	zHyYiS+wvZv02NgANFQrKRivusWOGjSdIbLc1W4U7SwAsu3B4+kC0FCUyFue30zhb5KySIPaFcd
	UzbZd7qKPDIg9aPFmnb6bBG967IYa+43fZGRbzQeKnUgSSB0jeumdi6yO1RPKwG3dgV18mRCNX3
	bd2Tx0dNOeRtKMqRQlbIOvjOTWMfHaGdpuxvgjyrOa109ULzibeL6dWz7
X-Received: by 2002:a05:622a:180f:b0:4e8:b138:2a0d with SMTP id d75a77b69052e-4e8b1382c71mr98419671cf.12.1761049049790;
        Tue, 21 Oct 2025 05:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9wVa62A9QqlswXTFOtj5hMm5dxSnWe0OKPK/itVnOD6rHNI29MyrzCPqYx7/z+6jDyT0yqg==
X-Received: by 2002:a05:622a:180f:b0:4e8:b138:2a0d with SMTP id d75a77b69052e-4e8b1382c71mr98419361cf.12.1761049049358;
        Tue, 21 Oct 2025 05:17:29 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c49430145sm9225871a12.19.2025.10.21.05.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:17:28 -0700 (PDT)
Message-ID: <e63dc4ce-8461-41f7-8dfc-3fe531d69f4e@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 14:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] dt-bindings: display: panel-simple-dsi: Remove
 Samsung S6E3FC2 compatible
To: david@ixit.cz, Neil Armstrong <neil.armstrong@linaro.org>,
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
        Casey Connolly <casey.connolly@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20251021-s6e3fc2x01-v4-0-5e3ee21c688a@ixit.cz>
 <20251021-s6e3fc2x01-v4-7-5e3ee21c688a@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021-s6e3fc2x01-v4-7-5e3ee21c688a@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: utn002dJBmJ9lcNghaPvBl3mBPrir5js
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXx3akaa0ojMOM
 jnvVjuLshvZVFlRZzR+Y1Umb7nPqVclGg52LHfeArVEQnLdBi9Q5jNRsGYUrMTR58vqzgvRkffr
 MVZAbq6gWCwswrMt9ZXc1fuV/Sd2JGZWcCexasSqeigFd8g2mfexnNVLE7tlRCNVRAXDZgRtqnA
 dnqW9r5JJr3+9L8mBE9s50mfxUjHoQv23GVir/kmrU3xR0auYdlPDYEnunIdkLIJiMXVqGQkD4I
 OMHqNmiZfyPdh0VTtgorODSgo3q2mDUocgGjsFVxgZTaLmXvoZu6GqR6ITgaKDFzcyTNQIQwk5G
 9WmRRaqzybzJEs8nuYTcIMM+GVIX+5AE434dE+MN7z429T5ZyAQjNBbfTs9fd+pIWYNN3WXVc8h
 /FY284XJe0aOfYAoWdjW3vpTgQ9QFA==
X-Proofpoint-GUID: utn002dJBmJ9lcNghaPvBl3mBPrir5js
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f779db cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BITFXGdF7uWLIDnxD84A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On 10/21/25 1:53 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Samsung S6E3FC2X01 DDIC isn't Simple DSI panel.
> 
> This panel has three supplies, while panel-simple-dsi is limited to one.
> There is no user of this compatible, nor the compatible make sense.
> Remove it.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

I think you should squash this with patch 1, doesn't dt_bindings_check
error out when a compatible is matched twice?

Konrad

