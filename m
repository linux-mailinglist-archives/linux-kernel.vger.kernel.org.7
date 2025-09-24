Return-Path: <linux-kernel+bounces-830338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB66B996E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704981894FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6392DEA94;
	Wed, 24 Sep 2025 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDs3QR4+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D091A23B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709757; cv=none; b=POstqtw32IG1ysADhtuW0cc3BxXzqnTcVlfsSsOptK3x+UG1JwAyVr6xzN8VNLxtaXt6RPdm3QSwF6IrOTmUTDyHL4/EraF50WziGCEWNGyJ86AdPaLUmart9jRsP+SIolT1aEWJolhRi4mOK0Ij1MggFL8ghgNMR9ZS0mQ5SQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709757; c=relaxed/simple;
	bh=/9hL9612Gn0CJSgidmnFRkESRP8UBsfv5LMScs4CM38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuAqfed5ZWcXF0MM0ED5fY7fQY3Zwo3VxHdC36Mow8uNFu/dr/Sq4r+lRd1XM56tRWf8l9gVrgcVT6FCcV5Q78XJ2gz489Tcv8Sx+a6bgR+1IJdEWT23Fuv619IxUr8/l8f1wvbfgb4aEL2WErh2YKFTXf6Mckt3wu2gFubwix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDs3QR4+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iLqd023773
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zjk1j5ULWEzsfJ1pudMsCTDGZ9oTBcQfVxDwzmzjuXI=; b=lDs3QR4+DKETWGb+
	Qf5XIKiPb7zV6rCF4dM9vt4xj8iNGH7wINBX+P/09KvG1bm124czm9571qRlr9Ih
	ueZfE6/WbZE1ldWRvafRBpExP1cTZSwlIJHsH8F9g60JsTUZqQhj2B69EC2JDcho
	He1T5vH4dpfxZ2pxE6s9KJPjvpXkP6SGGCYuNs0oL6JEvouD9nNy9UK3jZsz+6zT
	d2HPJGI18CVTFAofx3b+5R3iRza3HGK90RGM7kbV7iqMQDNIm7O38mZo43pS3il4
	0ps2uaawxqUT/4uYIXlEp2carI+LTFCaZUXkOHCnL04PzQy652nzhYoi8eRUx8Jo
	0C8+Cw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0ayrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:29:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-850dfe24644so68820685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709749; x=1759314549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjk1j5ULWEzsfJ1pudMsCTDGZ9oTBcQfVxDwzmzjuXI=;
        b=XUQJhB6DQlZA+pc3GiUNn+xtmGWTHlZy9P+PD7eDHfQ0kKjPAlc7B/sKxUJZKLNdMf
         LNMDOIWzF/aPRCktlgQ5Wx/LkNaUjhtvtZRGffBbu1xiChW3y8WtebdZ87DF2xJG+HE4
         PLULe36Q2lMpmpY7ucT0K56PJSACOZ3rBRH0sCmsTNDvANWSuTWN/tSwwt1Uo2qcmiix
         EcptMkDsJIhyfpJip1UiQUvB/pzbzWmGEOUrz5l9T84EQwkv9AJEl6n8C90Se6y3ckl7
         ru7Sti5U8utPfLKhygGQtuuSs+tfxbkcuoys3+V1fcxlPAHv0WXN+O8IvQqjZ8Lf2Y+V
         WNxg==
X-Forwarded-Encrypted: i=1; AJvYcCVktZToscDESuDenZhSLeo8ABlsChb3gzLtPMnFPX813uDPIutKUp4UYUH1rUPVLlXeCenmD7iQZiPk6Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aZOwOTLQH21LSCv/j67RhpL2H5OCCS1j6nQsktovxg8H0/NC
	gIc7FplpikjYEQIXAhqtwYrwbs0V72gQ4/OChwbLTG6cU4OujD36xu/2W4WbML16k4SNiYbTIzU
	7ZYWe6PYoS80llkM5e03WJSv3IepUMqNPVJxbCwLi2Lniuz7jhv93942r9CZcErYVJqo=
X-Gm-Gg: ASbGncuiQ/Octd2wSxO/2dAAc7XeD95zofw/euBL8fiuQ1LsKjzcV0hnNCfI1En12JC
	Py+pt3Z7QLBqMG2yczlrh8vP+V3Wpg9xYrm6F+Gfg3WHL5zsJjuCwxZn67pZpTgaE8k/kZfRUnf
	z91qMHJ4JmoLJwzHTe7n3ybI+P9ZGtgEEV9sfHXh0OIf7++1aaQOxJ8ZTdBqIljQYsuEeM1P/gm
	hDIj03b1J6EVQMJghBsBEdNgB51kPeLUMKVJAJTctVR8ksgZCDphn1Khfrsz3W9eFFO5F0j4SmB
	7IjgnXfykjiO5xijc8S63wmd+IMMpw97VL0ooz9jvJ5PvtumoK+FHsz0yTFxGZdGtTsOE0Vf0XL
	uPB91AVaY8w0O22Qx+dTthA==
X-Received: by 2002:a05:620a:9444:b0:851:b083:37e9 with SMTP id af79cd13be357-851b0833b27mr305213885a.7.1758709749062;
        Wed, 24 Sep 2025 03:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRzIWeKgyhxXr/t44Dh/z5B9dbWTC8JKuLuTfE3DKhzEiNCFnlBYfyCkI4J25I5SqB0lq0GQ==
X-Received: by 2002:a05:620a:9444:b0:851:b083:37e9 with SMTP id af79cd13be357-851b0833b27mr305212485a.7.1758709748562;
        Wed, 24 Sep 2025 03:29:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b290caba5a6sm935424766b.65.2025.09.24.03.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:29:08 -0700 (PDT)
Message-ID: <9edd7057-8330-4d1a-97c6-e9bf05dbb722@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 12:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: qcom: dispcc-sm6350: Add MDSS_CORE & MDSS_RSCC
 resets
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250919-sm6350-mdss-reset-v1-0-48dcac917c73@fairphone.com>
 <20250919-sm6350-mdss-reset-v1-2-48dcac917c73@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250919-sm6350-mdss-reset-v1-2-48dcac917c73@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d3c7f6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10 a=AYr37p2UDEkA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: 6A2ly8HP14_nBYRe8uFeOxwwcyzSQGQy
X-Proofpoint-ORIG-GUID: 6A2ly8HP14_nBYRe8uFeOxwwcyzSQGQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX6e34uQr3L6wH
 BuoDXk6X850VoA2pMbs2ii+Y0kA91OOCCowk3jBZaMEF+rxWtG+p2mj8kHHIwLSPaBmKn3k6FZk
 ts68Iw+2Pl9MNhwNBt/I+3/h4kSJo8NWVbdKki//AIdvZhoZ4gd5ZMxdZxFCQSSkqWObgnk8O5U
 HK0YI+3bLpFjtf3SdEYKFjuryVPe9Q6xZTMqF+EQE+usSf/bjZJpe59/WlH3//7Kvb86D3mKPPY
 rtn497IBN/8HZYsoFJOxN0JyjV3+meujJkjiAXxhh6x/C8Bxr/bNncfBMXnD3ipS63M8QTVvoqr
 dA62OYsMkwvUUxacJwTZ3rN3S68pBLWqCx4CvR3ra3NAhYsdKHS+XS7cRMvIhj7ssdXg5y5m4Ng
 2Dov02g+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On 9/19/25 11:57 AM, Luca Weiss wrote:
> Add the offsets for two resets inside the dispcc on SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

