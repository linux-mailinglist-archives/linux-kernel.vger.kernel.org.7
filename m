Return-Path: <linux-kernel+bounces-878066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8504BC1FB46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4DD18910F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304B28C849;
	Thu, 30 Oct 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hckJrWJC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JsZqO4UA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE872135AD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822195; cv=none; b=To++MxBLIS4wtl3S09kfolVKuLN6i3/BywXosZhacMKXtzz649lFfXH2j6NuosgRQ0j1RBdXKnq6ViOp1IBEME3k+niUER4TT5r4MsvvmyslDWrNlhRt2wjlJ6nActQ0PRgj2J+pMHeTVF/nNag4KHOU3XATd+cb9LrI9Ircz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822195; c=relaxed/simple;
	bh=K3tS3ToI3HJBfPETrHR5PnpCoFB1dZJ4Sgka7xCNViU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNW1Fk3bL4XXpccZUhC/dl7LUKgKkfy8PQd7URaWqKsGSi+9VMgaKPkCov79g6tyCuFAGJpVK505ffXQ2E4bbXKiHt2B1Q9VX94rhD9FHaeiShIJGUlsWdaCZt3Ju5Df04h/UwsVYSDK+ydAigwaz6c9NA82KIK64bppqd3mO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hckJrWJC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JsZqO4UA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9MhcY3115819
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	28+IQvDYGWe7uO9MMcaeS+ckpIgwiovtSbo5x8ovGBU=; b=hckJrWJC6+evXCtI
	wIwAcFdYDliS058A5GQllOxEZ+M2Q1eqHE3gkrU+JrfvXVyVOqmENzX2LQBfn5SL
	WlJ6usgpLceU4ET7ouww3+tmyczAaVg+uszu8T+hVqR1Z1afxbgjJDSHOuT9maWG
	23IZRbN0IqcdyqGMBnabVn4n8j7FPMZKwylUtfHWAtOelW5UGsRcsNYDjok/7PEJ
	NshZ02vS+Rz5Ei7o5h+Jvbc87QaKQv2muZnkgcEy/zP1NiqD2ZRpZcj4tku59mko
	B05fwWzPigwj5pOopg6GQjWREJLMb7hEsOw5ip8MYs1rouORS1BLHz8OZr35mYiH
	t8ryIw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b409vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:03:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87dfd456d01so2930986d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822193; x=1762426993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28+IQvDYGWe7uO9MMcaeS+ckpIgwiovtSbo5x8ovGBU=;
        b=JsZqO4UA6Iyef64GfgqRzXkT9IJTJLqXq9wzjzigrsuS4C3TplNpsuR9fnsUcyuk0t
         AvLPhjEsVW/3glT7Mho9KzD3lj4JDX82m/fOsbUoyBSqTfKLmEwkVb+jyK/wKupYBSk8
         bUWR3ipXI6QzycjqWTh/K+mWKDgCx1iTBaLit5o5jnOTqVnNH0LEaLNmtOZyh7F7b16/
         VHJ7h0/Pk/7YIlbi1gT14qVT1DRivtiTaO3VyKCMeZYO4RNmWnLJX3Zqnw8v7HyS+pJZ
         W3Bx/lf71f15mphO8keSjV54heeAmEdseXP2t/GiYgDl0dETQ4dEnWnE+8uPxzOyYxgH
         j1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822193; x=1762426993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28+IQvDYGWe7uO9MMcaeS+ckpIgwiovtSbo5x8ovGBU=;
        b=FJUX2n3Y+YXqynWNMfA1j394sFSpNcCd6vLYrIqTju580FBFQnPCSJSSzSKVfELldy
         YZvzbXyIuBbv8HauRofGaNUd1Aq5AymJWDB5IG0x5+Ff2x+I6ORAU2PTLfCCilXGKndq
         REJKU/BY+HucJzJ/3wNK9/NkBV+FMyHNmvNGCf0wKwB96BYpjehLO1D0EI10XjwNxOAD
         i5+L/yW36vh9MjYl1byj0wjwfLgRdq6cKl8Z0SH72JRSvboxpTr11UZSZUVgdimjJ4lD
         dHfykAREW8rJuM/xvxJVVU0lzmuf6dIirY/GX9vTm91a5Girh/0WzwTbd3/+fhktvvMN
         vJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWQHXy8FGatS80E5uOIaK72LG0NwS3my/N43JGdMF6AZpoZVSLuagK2dpYEBBqTRuIBZju1p24fGczZu+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1H4B2Qk10v7zeN09NfZihRbs6YSSNGKzkY3bL8lpsUcZaQUeC
	kmr35q4bFDQJ1AMlXSs81beUUyygPeVbAH6uDjd9Zed9YgjN5DSwq5+oPiy0UAZyg11jsdkduD2
	UhkwiLwqQ+qkvDMdFaYsorpCCbe86Hm7H5QEFNUH8tMTGyLvUe7Mqmn2+xA0IGXMK0eE=
X-Gm-Gg: ASbGncsJgU7F5cpa/ofRk79UcTXsJJmGkrHdEp8+2Rvcj9C/U7bw1yppNeA0zDP2IqW
	C1DiGwmemyjxLjInpaES9Vaw6EOAQ5VQxtTQPTdyXwN+6pcSIyyF5kdHSjn09kFmp+ZimveWDHV
	VabMPEqSJgI3QVi67ztFDUZQKE9gzXL6i/vTztt7VR0wbCPFsVqp4AdQpcUMtiYujxs36n+iKk6
	nX6b9DfGnfxDYRU6WZn0CNXuVrjgiIhhNuKG04Fp7EaHkcdWRS4VeucwypgMM90pO29XKiMUi3O
	nMbkVpUCSwm9QhfVXQxFiE/vKmtm1OKe0zAkVOcKCRTgEJWkKlcWnvsf/Nor7aQYQQHExrtDzwV
	e0uPO4xZiQO/carFA5MfTaw4e5+fg34fULrVx3bubz4ZA5tU73imk5i6I
X-Received: by 2002:a05:622a:19a3:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ed15b933ecmr53084491cf.4.1761822192793;
        Thu, 30 Oct 2025 04:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNX3boM5mT3X7eOEVt8aKTIGuYo3kAnc3hoxOLBCXwFtnDsZZ7KW5N5jYdMviOa/O52vGgTg==
X-Received: by 2002:a05:622a:19a3:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ed15b933ecmr53083931cf.4.1761822192071;
        Thu, 30 Oct 2025 04:03:12 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm1693589866b.55.2025.10.30.04.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:03:11 -0700 (PDT)
Message-ID: <9706f744-1cce-4a17-8e99-c29182f3bcb9@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 12:03:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sc7180: add gpu_zap_shader label
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <20251028-dt-zap-shader-v1-6-7eccb823b986@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-6-7eccb823b986@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX2WmUtKH/eOPd
 b6KM2+VTGIo2LSwCxbuLSARtaEt4cXTm2HuCvb8MGe3+SinWLi+7WijNUvJJdBWOlTIYCq+9hwU
 V7HqDXXV+MxorpTINYNEacDu0d/UfFIkJUeltEEOqdWM3kRTJHNzRInbGgCP+iVy7nCKu8CXXgU
 60U0yhN8SxNLLLvWo9YVtAbDzFJFuoKpBpmp+r2ShOFuN/faJWgQcbD2LI3xOKljmhuuLQBJPdc
 Kv+dftAU9LYZOSSuIXfesHmzWDjLESJZ6XgHPj8HU41i27JInHpE0AHWZjyDij9dncq9aMSoayR
 qBGhIUxKs6pSwF0rybv39crs/FlV+/xAhwpAjyeCjfsv52oFsp79EbrIXwB0p80flQDbtTIaKI4
 /92eToGBIn4IPZqY8Dqqt2zGvFnBZw==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=690345f1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=S6OGlrJxYZSBbBCeTXAA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: 7XMDCuwA6XLyDwYOn8JTYcxwA96bLhKV
X-Proofpoint-GUID: 7XMDCuwA6XLyDwYOn8JTYcxwA96bLhKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300090

On 10/28/25 10:00 PM, Dmitry Baryshkov wrote:
> Patching existing DT nodes based on full path is error prone and

this is not a full path reference, although DT unfortunately supports it:

&{/soc@0/foo@cafe/bar@dead/path@1234/pleasedontusethis@321} {}

> generally not recommended. Add a generic zap-shader subnode to the GPU
> node on SC7180, delete it on trogdor and IDP, two platforms which don't
> use ZAP and patch it with the firmware-name on all other platforms by
> using the label.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

