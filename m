Return-Path: <linux-kernel+bounces-800598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6DB439AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711BA483287
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385932E6CB0;
	Thu,  4 Sep 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S//mWkFt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0B2DECB4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984530; cv=none; b=eflARoteSPfpq+LSe+AZU2KwUCe2Z5UTZI/hsakVDX96KRxIAG7IplNpgU5MJBNfBCF5HtmGl8Vp2sP7vkrJ7z8DVrgPAKsWoIoAGxrAZnGyyUAE94mkB9jMJj+QEjIe9zRQ6XBlzHrQY2Q+tIXM/2bWNhdUGjhhw8HkVeFXBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984530; c=relaxed/simple;
	bh=CEbnxEFLxlJ6hHhNZQ/AMp/Mbj4cpgb9+IbAllToY1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXTvqxIr+j4eaAtzz71/DDrpO8vcL672brPICm/EH3OuW9nvxzJtyCW70SHmVn+Wh5Y0l9u2NTDYctNbfCL9e+QQ7FZdB5Pua2y5q074cXW2Na2oZqrcPqAgVECEJAnqieumcSdWd4pGlCKI11FJmXanRX/BQH7fyImGbln432k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S//mWkFt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X91d022174
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 11:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OOKtLhZE/W1bfuEuReYiTjW5qnUa6W0YPOAnKvpNQs8=; b=S//mWkFtDYgDqEHX
	AfSFCDuBgkj4G8y80FCF13N4WmTzvWhpTTvChmkG1RqDVxyKFY7RkR5weSUq9Tzh
	5E0w9RSp8Oas3srE/vw4BrRGnvjZgpEokod86vB4cA6Z/hf+8XIqwle1sOQroOaL
	EjevRNBO4EUVCHkT/Ef/i55BhHQohHW5Qlhb3Y6qv0H1lA5DvohfENNs3uZgPhrv
	VTiH02P3BB4ugz1a+PtgzK3sojB2sYuTwXh9iQWTlpFyqMqzJRlGLJ24BKQX+qP6
	uu6Zru1CJoqDs4iROEkKIvwpICJJ5uczS9OHecwOnUMX25s+SvGlkWx0EesuVe7X
	76fTGg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk97427-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:15:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b307e1bef2so2223581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756984527; x=1757589327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOKtLhZE/W1bfuEuReYiTjW5qnUa6W0YPOAnKvpNQs8=;
        b=SUwR9EGSq5OjF4g536OqIgi9+1jR5RSZJtgrGvEwTpREWBHXqwpTsUp6iN/pM9HgFW
         BmTyKmwPETI0omsXgKvm287k1I2o4wTOThEVU6Nr4vc9hgMMU1D4OkLYAOicJsf5QXx5
         P8L3e25yOntnCIRd9LcVYxBkgynH/EKqpckz0swPfswSwYdd0/0w82pfcMTheDcANCP2
         5vsdSBuuiTJr6hAEZhWxcl0DjA8uXJ1GUo+jH6ohGPsj9ki14ZAdp34ep4WZMs7c6Xt5
         gCgaSoIAHm/cqpEBDxE59RZIZfWDTRzaYnEWXd8xmY58RV0IZhvcgvsliO2X2qVxfu2t
         yaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuXwCS69nVmyeSurA8jN1qcXmVCE2TarP0K2wIopHGS18oizZXCOad96TQrfa7PhhG1Pqu9dt7fusrYCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQc7EksnXtVql8j73PyEFUEPbtTypYQ2iP/vu3tGpnBBzuKtZx
	eIFR9lTfSDe7kk6FaToloI2CKIJno1BtMJgFHdJSPyJC3yX0Au9hGKRe+IXsHfTIG6k/TAIame2
	Hp8X36y+PHM2Y2ZfllB4qqZMUvSoafH3k17Hdh1s5Z+5FrJrsM1C+njo2KrDxU6DUOiw=
X-Gm-Gg: ASbGncvLcRSxl9q+vY9XNIy/k1TGn+REhcWGW8eqPcRIYRz0xg9eDWb6MYf07BVD6mW
	v5lpiy/4FeabXSbhXJXWM71GpmCqdcuGhtn93hmbTWeJEzFaeat5U+uAlnggPubLci+90x5oNA6
	bpvuV5HtzuZuIkNX/t6nkHJeOWrlwNrl8uG0AP7+UHshQ5SWkT5t/QxhOhuEFg0IrAQdbfA0ucH
	hLVwzY5ohqU7VubGjuUBi19BTOCakumB09NVKDENv2+hS/UuPdAhGyo2Xyy9CG51IZ3Q+lkBX2K
	pplCN26r7gvvEEKYrMarBykTUBq5QBkhpD3od17wDCKjyT/wXTZ6JCUkFurmb87ieEamWP6Rjvz
	qXH7Bgextl+30H7FecVWrrA==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr179595031cf.7.1756984526902;
        Thu, 04 Sep 2025 04:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7j0pS6IjjhSGlZj35O8i4kEMXE/eC6FnHTO0eI5oav2a4taNUJNhPrFFvhieF/D0b0vfiCQ==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr179594751cf.7.1756984526426;
        Thu, 04 Sep 2025 04:15:26 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04110b94cbsm1185570066b.93.2025.09.04.04.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:15:25 -0700 (PDT)
Message-ID: <46ea9ff9-f119-472c-ac5a-b91e36fcb226@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 13:15:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] phy: qcom-qmp: qserdes-com: Add some more v8 register
 offsets
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-phy-qcom-edp-add-glymur-support-v1-0-e83c6b9a145b@linaro.org>
 <20250904-phy-qcom-edp-add-glymur-support-v1-2-e83c6b9a145b@linaro.org>
 <bf5e7ea2-9f0f-4d83-a567-028ffbe184bf@oss.qualcomm.com>
 <6nhnerb5yooodw73ku6yxtp7ud3irwhfwd5zxjwcwbws2q5y4x@7fj7dck2cv3a>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6nhnerb5yooodw73ku6yxtp7ud3irwhfwd5zxjwcwbws2q5y4x@7fj7dck2cv3a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7cjNeXnAOZigYcZ5x7Qk9_wmYDjLAaeu
X-Proofpoint-ORIG-GUID: 7cjNeXnAOZigYcZ5x7Qk9_wmYDjLAaeu
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b974d0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=zjWQaSZ_NnQgvzHGnUkA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX/KFWra/qwm+D
 X54DVQSxvMtLl0+9qAclmdBYOnopU3oT3aZBoAy0jvnKN6/Wvt8x+0E2IEU/cuGXVPj1Fd0rzKI
 VI/fFxQhFAcpPkrulonNWTjPN5A96mIU9JBWP3HMRQ68ThbFpkVMIDxSLF97wgfsY5dJvF2SGeF
 WjeWF7F0LY5h1Fa7sFse12JNQiMIMXkBQTpnHpZLsUT4UUsdoJX5SD8wPlZFj9KtqE9rGVSML9G
 aGBd2buBfdoHS0RKiW3DxCyGXelBtkSRZAPbpE364t+SKm8hX3xJNQm17UKAzm+d1vNZiuBR4qj
 72GB/Lkl+m83y+4q8r1Jt/b+tL72h4/SVqq9KNdk9MOFybzhnjVSgEBwMO+trvuyrfx7pKKyOJM
 8I9AVEvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/4/25 1:13 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 12:47:43PM +0200, Konrad Dybcio wrote:
>> On 9/4/25 8:55 AM, Abel Vesa wrote:
>>> Add the missing v8 register offsets needed by the eDP/DP PHY driver.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>
>> + a couple folks that I talked to about this lately
>>
>> Please create a separate header for this, Glymur contains multiple
>> "v8"/"v8.x" PHYs that are not identical to one another (or vs ones
>> present on different SoCs), even if advertising that revision
> 
> Is it about v8 vs v8.xx ?

No

Two (different protocol) PHYs with the same revision data (rev_id
register) may have completely different register maps (even in the
COM region), both across SoCs and in (at least) Glymur's case, on
the same die

Two instances of the same PHY (e.g. 2 usb combo PHYs) will not have
such differences, just to make it clear

Konrad

