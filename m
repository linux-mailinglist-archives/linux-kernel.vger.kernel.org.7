Return-Path: <linux-kernel+bounces-852434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD350BD8F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ED8034C940
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7FC30B50B;
	Tue, 14 Oct 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/G6qLDF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01F3090D0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440816; cv=none; b=mUFgGx/FQR7oFTyrSUyeGNF3sGYmG4gbYJeIcw4ZjDpAETxVB8v2hBTvI7vBXuaOoAkk3UBwrCFoiecWQkmZKub2ImAXLTmC1XIhIuhkRXxghfTAmabDbewrm3siGrbNco3Zrv96GJ04nOYr//Jz/nA5RX+UxFdxgSpXIB23wWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440816; c=relaxed/simple;
	bh=9c4sEBdDNCuyNGgDOg6MiHVAziL4QP9mRC3r8B4XAso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQWktuFqTO1/JJHHD0HTcdntfrTRAmjqw74/IjAdGzNV4bw6Pp/Mjl6oJocVFs69giPvLloq4wwUqhRjtmU9EXvZsdeHfES32GgbR3aau4Jn32d0/roiE/8wBuDeCNxIulF1gbmJxEksEPGSMD6VS33Ipb0YtEcPKZLbwPk0Duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N/G6qLDF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87HIX005372
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q3zlQTUnJaQdMxPkf1IdgDBVPpkVTRW0DJoAFXU8XFM=; b=N/G6qLDFP+eAensO
	6eJghkWxbPoGOUd1xGV+yHwmCKe3JpeAqcXYFA8HtMsXmz/YHRi/g9YjJuXuQyPQ
	wi9dftRStvS0xDAuhIwkep+OsKngSKqgjVw1IBKcBaUG5cLXl1XaYyT6hGaKJy2Q
	8YWFDDq2JLAgtVT1xb+MvSXYrmlJrFCIdP37chmhvMqqzVXp3KmEawV5zw7/Njqj
	JanWyrxGInVCRuEL6rgC5BWc8tCHkTlz0g0wEajws0ShTgctgtE1a/ofEiwP6hta
	MQVfMDSG4GIERAiCXD7GvYagQs1Aq+F+KjZITK4WX01EcPUEf10FdGFrVnal+7of
	9hHnkw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj07nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:20:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3306bae2119so2481705a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440812; x=1761045612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q3zlQTUnJaQdMxPkf1IdgDBVPpkVTRW0DJoAFXU8XFM=;
        b=D3SHcLzUXwAmYbJrilwLZSA2R4/UmrsYozLUuDtngdn4472kyCHAzp8lm7/Hz1frE4
         fxBu8PPp8VoVftIQlkqA/MePZYu7MrYTDHvsdC8IMiRP/aRxSeHRsssfno9nlts/szKS
         AbxOKVtlmtrR5A8QbjcNFuUQL8+DV9BPWBGpifnhOnee3twkQuym/x6nGrY6cXw+z+oq
         47Q72M5kfj8YK6rjD2i7gC4pfmo9wj/u0ktxe4p6C6KPWvI8aoED87AVK9DmFTCUGgZm
         MWfOoxyGcuRHViH/U8F0boQ8kyKxWZ4tZdsiWq7gIFja5yFouAgruJfzU3DYbfEHxItX
         54BA==
X-Forwarded-Encrypted: i=1; AJvYcCXUXm6O+XuFh+N4pD+NcgBxC4YgZi30x7Q0UVyICodzQQXQnCKuglEbcfaw20hTTaIEAdTanbGZ1PzDufM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJ1/Quexcv/JrL/a9gKH3Rgt/9fdrHJRUR4iVAHKz5bH91Kjb
	mGrSdMOdsZTS402tj7ntOXx1gUQW8WK4tqfq3NOWCl4Fn5udowu+vrWkYNhDly3UAN+yGOjv9Dt
	y5boRzGcMkeuxq22PdDE1tw17xKqJ6MrZSFNPObD8FEwhpDHUC7KCeFmdu1hyZey35bQ=
X-Gm-Gg: ASbGncseR0OIBy2YrXQYOmBAnVFOZJzhSu23hGpxOKHmXtuaw7yhO+yI6jCma1UazQY
	YnQ5iw+yYouL6KXQeMj4RlcKR6+n2V4BCjUaqfnXe2cgHsVW8imFEg4DgNqbw9t9oQm7MgTCAkB
	PFrEsdP0zqRTViot9mc8olWxLR9QETslXwbIheIjICDIiMlqCJ7mbSRtOnj7bArhgNGxlXw44Vn
	7AH3z59qUP7oZl3t022KiMej5RIcltP3MvwI2qb8zbFHA1oj2ZaDuK8/JlXL3AlQxkLM4E23Sll
	hN5f6a7Pk0XdjngSZHRI9lv/nNaMMBDZjdX6WmC6KtDLxqf1X8AYuIlQbBla7lcEiL0gnMxTkBh
	bGK/tbNz4QN1TLc2wOylW03O2rWmsePGL+hw=
X-Received: by 2002:a17:90b:17cb:b0:32e:74b6:4ef9 with SMTP id 98e67ed59e1d1-33b50f297f8mr16955290a91.0.1760440812089;
        Tue, 14 Oct 2025 04:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ccPgYpBB44vAXWCOVRI1VlGEHsze44hC1G2/E237fphW4r1GMjOiSsLUZtF1AZ5xwCYD2w==
X-Received: by 2002:a17:90b:17cb:b0:32e:74b6:4ef9 with SMTP id 98e67ed59e1d1-33b50f297f8mr16955273a91.0.1760440811521;
        Tue, 14 Oct 2025 04:20:11 -0700 (PDT)
Received: from [10.133.33.159] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cbf2sm15693949a91.8.2025.10.14.04.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 04:20:10 -0700 (PDT)
Message-ID: <47e72a8c-0dc9-4c87-9e1d-b4c60a178a94@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 19:20:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Enable DisplayPort on QCS615
 Ride platform
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
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
        yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com
References: <20251014-add-displayport-support-to-qcs615-devicetree-v2-0-1209df74d410@oss.qualcomm.com>
 <20251014-add-displayport-support-to-qcs615-devicetree-v2-3-1209df74d410@oss.qualcomm.com>
 <509e9902-2f74-484f-b5ca-e1605a221004@oss.qualcomm.com>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <509e9902-2f74-484f-b5ca-e1605a221004@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX9TxKDDJ+wl9p
 ajBWQ6WY252YX6PCYUBW0JhEIc3YYiU+QFrLFxUBO36UGno2hRjmjiDvMOoBD6pxi4RruXzJJiY
 pacjj0P3JH4pGR/mrdnXRXurNtq0duSHYjo/5H79i0I6b6Yyi98xEmq4ZEptjJorVmZyW5jaza4
 0A6dNtlU6HVArqY3caA0PiFeXCobmGIgPvvK9m4Mb1ZR++Y+7Kwq+ciuBHDSo+sEIwCtyXPXJEo
 KomLz4rzzjig9xRyzyafeuo82NtCtkaxXwYMoQstVJqf4uFS0/fB21Cex1dXT9gCkCKAH3YWiti
 Q9d8kiZI+yEuJgeNFcOZDtbTJJeZTTha/rOzjwi+X5JHMKMzXRxiv+MnWCBPNoZM1bPjF6XCGAg
 UNQbFSrssGaz77xOLr6/1WWdE7Hv1A==
X-Proofpoint-ORIG-GUID: vsfXoi40a5vUnghSkmdKbDqMojWQMOSH
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ee31ed cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=iK4FTFApuVx0pu7eI5wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: vsfXoi40a5vUnghSkmdKbDqMojWQMOSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018


On 10/14/2025 5:52 PM, Konrad Dybcio wrote:
> On 10/14/25 11:42 AM, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> Add DP connector node and configure MDSS DisplayPort controller for
>> QCS615 Ride platform. Include lane mapping and PHY supply settings
>> to support DP output.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
> subject: "qcom:" -> "qcom: qcs615-ride:"


Ok, will update subject.


>
> [...]
>
>> +&mdss_dp0_out {
>> +	data-lanes = <3 2 0 1>;
>> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;
> No 8100?


Yes, according to the HPG description, this PHY only supports up to 5.4 GHz.


> Konrad

