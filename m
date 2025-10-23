Return-Path: <linux-kernel+bounces-866216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE81BFF331
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375243A8AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46526056A;
	Thu, 23 Oct 2025 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iQ+U1uLq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2C254864
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195559; cv=none; b=FK3/Q9JOUf1NuWRhrfhDK2XG+OfuxdLWHE429kpI3fhdFMDTxFdDBZkxHlYRIDtgflKVVfoRmilbs6NXJ3qRmrjLVR2AFs4nzgxl40BJ7w8FXI4a+dkifOYz6SYK54YWzdVMsOeJy4kM9tUaqxn5ihbo5xfW3YjtPs6qwVO2/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195559; c=relaxed/simple;
	bh=SM9h3kuaENDN0+ivfV00f10xi80DzahDlkVNF7DAdBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4Ha4+rPLZJs1NBoQnRYFLmcZ04VHnKmIHYr6sW+OEo9wrD4vPAipG/jDTl4ZqRfKQEdeeC+59Kgon2s8fvpD8dgu2cvZlUOCMWfArGuWBXo4eEhjFa2Zwvnr5KRhzRSlRxfVsOoj9jaYJNwxH4vlzClOWu8zrqMIT51eNN5uno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iQ+U1uLq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIenVW025832
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQsBupsL/ZgYfSlapLK2m++RVhSfbnhRHhab9RRBi8E=; b=iQ+U1uLqYOp4Bu3s
	lJccRpzeSSbEFGG6YjQMr+6EpMj1ndegmHpI0LwFtUrfekBMj67QnC2Cxrx6Sf5P
	Zwcdh3t9u0VSQOtJ4m2X3uaRSJNTnUdITfFio2yrsFmgwpuIIxHzpaAED/sb33+V
	ehSlkH/g5RYfprMSNWkz9ay2vH4j5TjY52+2AISQgpZMeYrl1hP8HBgXcwNVKTuc
	yycoCkoYUJrYy78SBFaif0NsAfEJlcDE4XiqXugLxcigqX9iuD74uGbZauoW6GfY
	zVzQ3hDCWx7Pm1RFQxS+PfycskCOtZViHPHI/b915dJVrWtY9mJ9FyR/sIFtIZ/a
	Ry5Qbg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kevkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:59:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290950e7b1bso834805ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761195557; x=1761800357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XQsBupsL/ZgYfSlapLK2m++RVhSfbnhRHhab9RRBi8E=;
        b=foOqDg3e6g6IEbZ77v2SxMi9JEKLDwJu02TtuIEkXandKV72vMfZVRaSCbHMJRVKEF
         cSwZt/qnmfyttX3HmFtAT6mRUU/WCKIg+Pvkw6Y85rFRNtT7ex20VCOew1FX5YZDiTk8
         r2GY2WhjVFX97Ykfut71EkdrlYcbLahi3IrHQqPlfXb+MTZ2SkcGUcsbrvsqwSILp5kc
         cXIGmLZLGi4S93SoUI768AoqWU8Cva/F3YZfROLWSk6W0bi3j+Wdrj/c9u7BypHawuBE
         /WFhg8+D27hG9Yp2ixJu2CQe5gBwcyV7Sgrj7L2Aq2ZThPM919zqJKdyFI1FNcVgJbPz
         XKVg==
X-Forwarded-Encrypted: i=1; AJvYcCW17cxjI9DxP5WOZ4E+leb2KsZDTmAw+Yo16ZFOQzMucoo+Srd6SmQvMNHOMq25DXY1Onjj35BI3IVIGgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPgTJq1H0Sr7e1DRXqCLX5ChsYGF8+RSKx3D54Dkm3wptfELUb
	PVOIE7cjypgFsiVll7s1JwpIXo8vUc4GqwGL44m37QJucGAk3Ir12kJ+D23vpQYAVj74rMXQNzV
	TEjoJROC2pS/1VSTAjIqF9HWllTAeb0l2+5h6JLnvhbtQnB35DLqbVUWJygLZYFzy1e8=
X-Gm-Gg: ASbGncvCAT5abvI6s7laRKnPpm4IIlGvQ2HChlznSjkSpL+bQ69e4gQJ2WVr2hBeaT5
	vDurEq6QeEcPd6wxrX52dhv0UmZ6Al/DE8sopwCgkCEEn4JnqehBg6sEmz9TJWgvsV/yY7sjHWW
	32NuetSzPHqNe2oT9AtVMHKwty9pmV68HJbUqc+9ePuLVjWXcF5+Ax9y2XuzyL8at1dWRZ24Ha+
	idn4MrHmOV6oJI33xpLCDkKCTP7RcogtWfl9AAsOdsZpohV2ta6vBZjl2wSdxSR/Y1iuPXgHjbX
	6V7o1RBknrrJnJcoSk44A5omM4/8zv5buhprlhqEdzUTqRSb7TPFHJe6Noq7sGs3obzoc94Hsnr
	TeZ+C/yXJQQ48CH733UGTrBhQEtt6ST5uGjWNcK/mk9q+HFrvXaF054KmgyGDhdkdrZF1RA==
X-Received: by 2002:a17:903:907:b0:26c:3c15:f780 with SMTP id d9443c01a7336-292d3fcc93amr66496535ad.8.1761195556917;
        Wed, 22 Oct 2025 21:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUEUehRXXgzmp6ooEZeaoA5HTI7QxvGAGO0q2zfheB5V5ozk+j8iZVJGdKIenvQrC3QbtL8w==
X-Received: by 2002:a17:903:907:b0:26c:3c15:f780 with SMTP id d9443c01a7336-292d3fcc93amr66496355ad.8.1761195556486;
        Wed, 22 Oct 2025 21:59:16 -0700 (PDT)
Received: from [10.133.33.163] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f4283sm9389085ad.85.2025.10.22.21.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 21:59:16 -0700 (PDT)
Message-ID: <3050390c-3407-457f-b62c-7adee759a61f@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 12:59:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: Add DisplayPort and QMP USB3DP
 PHY for SM6150
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251021-add-displayport-support-to-qcs615-devicetree-v5-0-92f0f3bf469f@oss.qualcomm.com>
 <20251021-add-displayport-support-to-qcs615-devicetree-v5-2-92f0f3bf469f@oss.qualcomm.com>
 <59592a3d-447a-4c99-8654-d3cb9b9f9a58@oss.qualcomm.com>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <59592a3d-447a-4c99-8654-d3cb9b9f9a58@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Edvhi4XbBn7lg-F4A8Gr0EZ8YOOV06ut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX4/mKjCN9osKa
 tXPaoCT/w/5/k4kpbu7Ib8GIXDxhu7JaknGe6mK/a026nAb5XdK5RB6v2eCqBkPRWpiqvI7UOok
 YQalRVkW2Cp/6a/Mk/LY7LWxbzOpLOj4y6lBNWGArYv7X88JJipiOWY6zDVM84scF7Ka7mfeR8I
 rkwD50SvxFlBg8Ve2c/ukv3QRxAnWja5DyxBkiY9MPNnvuMbIv1nJqH+H5iD0R+diCMFUixJdEr
 BWXetjZnuetPjQjt7gr5i22yCLlO8BJv3hqgyh6RzsNnWIziCJu7z4rgLypOy25jLVTpzjd+fiI
 7TzxwEskn0uBaY5l66zv8VesPfwdwWz3OVjaRF1KeHyLtElStvMhC8B4Qq4KmRwx0mdfFCJlKuy
 orXDHcfFu7EhWOYU1lvU8WA6bEZ/5w==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f9b625 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Y0hPKdM277UiO7HlCU4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Edvhi4XbBn7lg-F4A8Gr0EZ8YOOV06ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031


On 10/22/2025 10:53 PM, Konrad Dybcio wrote:
> On 10/21/25 5:18 AM, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> Introduce DisplayPort controller node and associated QMP USB3-DP PHY
>> for SM6150 SoC. Add data-lanes property to the DP endpoint and update
>> clock assignments for proper DP integration.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
> [...]
>
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						mdss_dp0_in: endpoint {
>> +							remote-endpoint = <&dpu_intf0_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						mdss_dp0_out: endpoint {
> Ideally there should be a \n between the last property and
> the following subnode


Ok, will update.


> other than that
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad

