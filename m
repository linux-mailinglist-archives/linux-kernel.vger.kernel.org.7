Return-Path: <linux-kernel+bounces-890165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16694C3F5E3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3865B3B30F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8B3009EE;
	Fri,  7 Nov 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mwaRH2oD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="csrlCJx8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828427E04C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510579; cv=none; b=Zhd7UNKkGys9q70S/kG/ck6BUHdF74JLrG1p2datLz90zGAmBwHfY8HF4nWpWeeDzkfx4iVu/b3Q7Gu3Iry7WMog27Bxk0za/yqx5lbRZWhtpL6Sgxld3vcfhsmu2nBT3O31T6KI9TYMiCb8I9dS/iSwmXNmtuUnHmCJ/lEnoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510579; c=relaxed/simple;
	bh=oih8H5ITFiYWo3oxH32M04ZFkQkCCAn+ReSdhjKM8Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnLclzLMhklhWAL3WLtgQRnqJrBUNEg19Mxjxe922Hd76Xmq43oHkRoZboqDjhOK9xqya6PSeLbJX7iUbw8BNEex0squU9j9VOHVmTGPgchxqIvWj0JmST1kYNhV2YzUhYRipEULNms7R5F98SyEd65Rih1Ps6O3eARd2tQErgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mwaRH2oD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=csrlCJx8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A78LNEC4131391
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 10:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oih8H5ITFiYWo3oxH32M04ZFkQkCCAn+ReSdhjKM8Cg=; b=mwaRH2oDv2CcoJMc
	NA2l5w35BKpHWBS13QukdhhKCcWkgVLHD42tTS65+/EBE5Z3E+Shhze9iEIg4+Gh
	lcSZYR1fEjaA55cbTt7py5LqjmoK3F23eruCUGy8o+1zSuHHYRH9pfOW8Gvlzo5V
	X/TJthDRC+KfBygFe4dP9veAzKqFb6M58JjxPAkZDor+uz7JBu8C3wc7ugAeQ8/3
	G7HNgCLseSmTyrwba2fTrI0YO0fDk30J5muTHQO/cW/0BLHlR2SU4zksoQNIbxJv
	6SlUZhiNonu0OEpOFRzYbHZLTiHkKfwwje7DDHG1eyD2XG8cmw89beupGeps1C4D
	Xe0BgA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u3x3nt3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:16:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b227a71fc6so18552185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762510576; x=1763115376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oih8H5ITFiYWo3oxH32M04ZFkQkCCAn+ReSdhjKM8Cg=;
        b=csrlCJx89eid+UjDO/NS81c8lxbFLTX+iwX0gc8UO7jMnSzWH+y3HhVzbD+nNz60z8
         RnhZTDusmET46k90ifBJKzJBYgw2gjM334aglp0XenahoAZ/skyskhaf2vA6Tze6AUUa
         w2nK4MicKpyd9o6nX5DSrb19lBhiKJlQptMyXHeox0YW9jeGa1w7KANXAPTbgdHbNqKv
         yMzcGCyOp7SuUgVC9XVHJOmJ9w7kusdq3FhLTKonLx4wX8300SVSuaUyv1H4YSWCe2me
         UyS4NqriBWyr0HWil5lxoenXRVaxvkYA6SWB72Rhwzbr2/AhgiWk85xaNRpqeuKtUEUl
         ZCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510576; x=1763115376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oih8H5ITFiYWo3oxH32M04ZFkQkCCAn+ReSdhjKM8Cg=;
        b=SaQ8//okx8qOspROAOwhPOcoD9ip7Q674X4y6Gf+macFDs/N7Pe0e62ucyhS69mJ5a
         bYbYnbL3Csc2bvwKSDYl0YmYo7J93zljAka+9qCBmp7nERPkXbRg7t4g2n5EBgPdgVgq
         FdJjNFxbqqdID5u9gbMdR2Z9Jj6QzWlOn3A/qTjry9bSPBBX582rbsjLTk3tY2Qj8T9C
         ZgWjJZ/6E1CRTdPnKu2Qv4l92uGuXv/DRDKiE85+l7n+X6G3qOmmPyaENHw7o6m07z7Y
         2nvBLtUcoK5xiTkRtqFrtz7wYyZ6//+KGY0wZ5AbtEWbUiG9RNcDcXTy8d7nYkd7MCfG
         HDXg==
X-Forwarded-Encrypted: i=1; AJvYcCURR+uOgrB5ndJHr3E9qcy2WmfKshiVXMqyEkw/vOIMoGe3pK//X7LeEuA+LL1XFUDcsYgrwa/8mbEhNNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ugVy6ISzNrfVv9NhVGk0dFqSuYtgxK+mJzMo1V4tVHwqMCtY
	BcUPZjxm9lxTXeGs6zt0aUbFt3l9Jx07jFzHEs+YiX6pk2XWPa7GqRIXWHQg7WAhxbMTt9TQG7K
	XUs35tXKlSzx8PM9J4xyzAmGqeNOHVEtJtVy+EevzTkskOowvUHcPnPNnMOxawO6rSlw=
X-Gm-Gg: ASbGncvrc4p00iud7GMdjz/KDDclKksWXqzlESPMFFKP7UnhTHwKT31n6o35xgLT1UM
	n7kx4ANo0wWxzPtf3MB9NIYi4gsKwOl2lqW70cNC5vuvXuLLfabqX7VwLOUE3EI1pGEKmQgaekt
	X3WS8+ZqLXfhH70uC94Iag5DxiYxPlguKxn8aMaMsjSRMKmx456PwWXLsUc0E6tUJrOThmTykKD
	pZekNkfGXOyKZAQ4csUszyssJ/gxFrxLYlis+raXg1fthH2sq7hGMkDdPhSoH45ILM+WBt2EecX
	5gA7t6lhLWiCoLgkKS9D8Efnw4lBGeqr3ONqfrb2yuBYVItku/eAGt/lQTFoQ7Un1Cly1pW97Mr
	JJ+eV6oZL2RRbH+tGguzBFJIyZPgKfy+wD0nJuixqp7jVsOlei3CGDmkF
X-Received: by 2002:a05:622a:134a:b0:4ed:2f2b:aadb with SMTP id d75a77b69052e-4ed94a844f6mr20123371cf.12.1762510576478;
        Fri, 07 Nov 2025 02:16:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd62pbSfANF4jkGmXNMcRw44lphW1MAMAqba3HPT3RotQ8f1uUGg+2M6h0caCYjIIGfmBDzQ==
X-Received: by 2002:a05:622a:134a:b0:4ed:2f2b:aadb with SMTP id d75a77b69052e-4ed94a844f6mr20123041cf.12.1762510575918;
        Fri, 07 Nov 2025 02:16:15 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e808sm3677971a12.35.2025.11.07.02.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:16:15 -0800 (PST)
Message-ID: <5041ed01-c0a1-4c43-803a-9b2f7bf1f56b@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 11:16:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] firmware: qcom_scm: Simplify
 qcom_scm_pas_init_image()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
 <20251104-kvm_rproc_v6-v6-9-7017b0adc24e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-9-7017b0adc24e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4MiBTYWx0ZWRfX/ArTHmcKjibo
 sRkRmEIukG4OHNBa9uRLSedOuTM54mnl1vaDtfwtV9l+8VqwuCJC3FGjjeflt0K20nFKrQ+Slkq
 buGMFe+Vu+alaRWlW7tDSef/iS6Emn9OmOBUWuBPCVbaGVnTkN2gcJN+v890xxcenxdow1aagCL
 s/Je+ouslwWB6oW7gbN9pmlTnllaPTWIcoNzQiRqAslJa9WdVZtfkhMDlk/oH+vue9RbWfvwBGk
 IBlnpYXxtjhfq4DDcOuuxE7oebhbHpYoHWn++3st/ahdAhxiHbeSgwplZ7X04d2sh++cbl5FT+J
 gGsNZgeQKwW6Epv+t97NcdJM3C6jVMFwoBOd1Xisa4SDK2WZjkQaserraXwKoOHr2uDKRsyOuim
 XLAXsce1gDOGPdpVQ5p7QBYx4Baseg==
X-Proofpoint-ORIG-GUID: nfR7D5PAAWPMQzK4VcsywyZUN2FeefqW
X-Proofpoint-GUID: nfR7D5PAAWPMQzK4VcsywyZUN2FeefqW
X-Authority-Analysis: v=2.4 cv=BrKQAIX5 c=1 sm=1 tr=0 ts=690dc6f1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JpbW_vvhGqlY3ahWJhAA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070082

On 11/4/25 8:35 AM, Mukesh Ojha wrote:
> Simplify qcom_scm_pas_init_image() by making the memory allocation,
> copy and free operations done in a separate function than the actual
> SMC call.

This would be better supported by saying "this is prepwork for the next
patch"

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad



