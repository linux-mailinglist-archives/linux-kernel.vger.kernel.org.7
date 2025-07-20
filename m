Return-Path: <linux-kernel+bounces-738236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5974B0B635
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3DC3BE245
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8112214A94;
	Sun, 20 Jul 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IMaWHWnB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8D20F098
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753017316; cv=none; b=ba/+5I6mFh3DPvGhET48nhpJH49UO9j2w1yDOWYK2f4Dfw384OpyYK2tJbHJ963nirVJBONZ0/ZG3mI96X56v9W51Z1hGazP1vmg4NHmUecbAsVkd20wfo91oHB+WemC80pdSj5ALZVACB7ww3K4mn1TnyIt6FPM7oie+cyVI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753017316; c=relaxed/simple;
	bh=a+/9yQt11K3VithUaPvA5gO2rBEnkjNtJ7gkK8eJqIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTFintury4Yl81WM7KIuZjTGV9yDEofGp0AyzIgHL+9J7mO/YgiPhtTCvNCXXA9LeFyWHdiLiaxSJsnoe0+M6xZzBT3+8oijsqevgjOwYcD9DIfvitre4WbIAZmHG7yCVmeuUHOy6v1DrxOUQZH2o0/na6OXmnDZr72myoOQPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IMaWHWnB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KCrUZP032333
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a+/9yQt11K3VithUaPvA5gO2rBEnkjNtJ7gkK8eJqIo=; b=IMaWHWnBCHMw9zSG
	jGCyqjPx0M+qhwMzCf1ACrW7t6ln3YmGSNhkpnA5aI6KPJK6QNpRU7ksWq+nabna
	cT1vUXXHhFqjyIEpyAfLruMADmFlAMjPE20xVIxuEQdlV+Y+EYBLnhxtvjJZksph
	0qhN+Zqq71W+nu8RXhRourKtYckgH29VsHnoFRFWPONKF7X9smcuQrIeppj+kS+G
	DTiKpMcRtoKGscoCYXxW+SlCfux9k1SNAt49kpMasOByQMju2Y4VGXBdt+LT905K
	avsuFDNLry6Evac5qIgK9svtcwHZvKtWS1f9vMsY/38LZQhN0de8bZ+ndP3GSwgj
	1fgvMg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vt7h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:15:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso4922296a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 06:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753017313; x=1753622113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+/9yQt11K3VithUaPvA5gO2rBEnkjNtJ7gkK8eJqIo=;
        b=O5o6hdIbbL8dMt70sYDH+yCUP3yZZUbjisjMTlXrG8bd2yD0/qeAEfbkQV5A8fptJp
         uzyG9PFT6TrFDj1CiyoHb9K+SRQMv+NDW/0ZFX/5+8EpeTlseynpoFapG0G+gOB2iv7a
         w1COzm8IJ9OQoLsA0lI5BVPERddVa1UbC+VtVnCvT6Hx8KoRkuf75JLFpK4JDZTCiTww
         Lbds3auGuTK/Ynydznz47WrW6F11ViAq44Lub7lbiuYFvLq4zXjojx6SCxl7yad2jIPS
         CzFZEDClq1H2ojtM/zgUwm+IftanotPGgvYFZ6NrQ7NhEezwXPmCaaQ3/PP31JTK7FAa
         rrdw==
X-Forwarded-Encrypted: i=1; AJvYcCUqj7Nwv1wCohKBZtX4lOBeg1QViWXHWwa5vO0mbEVAk03hSY15A1njJUGreBvf4AvA4+T/gWY7cORdMkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4wXl78qfW3v/CrVDC6z7W6RUPAGMPP+IKutixjadf3T1Wnmq
	oByAPllN3a0qfivPQZ3+Two6YJXwP0kPkBjbTFkXZjKVEPnUaiMr5N+I+kSbzUY2yf2BSZ4xT4l
	gpxbHaNFMFQxRtj2vWqcI8gIrXtz0MsjBxum+xdG3XsV+INIfjcy9D7HbA3D4n+zMgwE=
X-Gm-Gg: ASbGncufpNFgeK/nMPMWFV2PXOD2Y0S+pwJ0/evGgbKv9ECg32dQfrwd8HC0vtP6lV6
	GPnJYkRXKKrAIeDALLIIYYv9z0S9Wlc2RnA2FEJ+t9uPp2o7C3ksPhGqNWa6VulFmTjTpkAsuac
	Wa1SrDiFuh1JDf8mCUV1ILqj4Zoit7MeTuK7kAICSnQJ8mDOsdyE56k8bhXtJM8+anKYWklpDHt
	E5iuxyEunHrAbXCSuZOtmWwgL4/wD3EQHYBp1wAk41M/voVzz7xoHm2tvgJ3rkU4Uv/SsiR18M+
	76gw/rvZI+fuii1MhD7FY9GDMv5A9AMtcunvykb6myTAMDZb+mu2N5gzK/3zZPII/t4K/XpDLFR
	vy/yMBg==
X-Received: by 2002:a17:90b:3f84:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31caeb94318mr19574507a91.10.1753017312808;
        Sun, 20 Jul 2025 06:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAUVIdg3VfO/chezPNcdAQfGrPXF/HeTMrNxiX6naKgNf1iAKiYVgWsV5q5SnS7nUk8OkSQQ==
X-Received: by 2002:a17:90b:3f84:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31caeb94318mr19574324a91.10.1753017310705;
        Sun, 20 Jul 2025 06:15:10 -0700 (PDT)
Received: from [192.168.0.168] ([49.43.231.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc0be8707sm3942525a91.1.2025.07.20.06.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 06:15:10 -0700 (PDT)
Message-ID: <a4369d76-df44-4281-a2a0-cb6d32197302@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 18:45:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: qcs8300: Add EPSS l3
 interconnect provider node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250711102540.143-3-raviteja.laggyshetty@oss.qualcomm.com>
 <b5a1314e-6733-41e3-9258-c3a88b2c90e7@oss.qualcomm.com>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <b5a1314e-6733-41e3-9258-c3a88b2c90e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687cebe1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=zhpjAwSWsGC/MCksz6s7dw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=69bba5Txv9aQVdJV0a8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: sMe3VrRIuWGIA4_pSeNMcr8omjCPteKb
X-Proofpoint-ORIG-GUID: sMe3VrRIuWGIA4_pSeNMcr8omjCPteKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEyNyBTYWx0ZWRfX8B95fY0Dt+TG
 VSRuk0TESLHfiVH3uvIVanrL2Q6hnEhy2jXliQzp+39squMUk5wRIqFRkJZDl3jlUzDknFjIChc
 ll+IEy+pExrQdcwbitFBSHBfc4i3vhwSZW271bObErwHpyAC/lHbnrn7CK1Ibd/th7EOIm5R5JY
 1Q4c9uNWHNSG0rz1xzG7mmvwt0TYzv2ZIr5uYKOkbG32mEx2Abv77QmpKsn4dW3zGiWtEJhowvB
 nxYhQPkfHVJSwDIKflCB3nx9co4LioO4Vqk7FOXkT7yvkMGniatdTeJG3pxzKmuslR2DMwboi9m
 WNJvw/myku7pqb65ezyN0q1PBDlyfMASQRe6J5s7jiZp7xDvlcStIbY9XMNEYDMc3dkc7KjS4ms
 TQE9ULGmy/bqMvvDZAk3W9T4nzV6ht73U2PQjpiWDs2Meik6IBnvLr04SJYO4Gnju8aS4WZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=979 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200127


On 7/18/2025 2:36 AM, Konrad Dybcio wrote:
> On 7/11/25 12:25 PM, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider node for QCS8300 SoC.
>> As QCS8300 and SA8775P SoCs have same EPSS hardware, added SA8775P
>> compatible as fallback for QCS8300 EPSS device node.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> ---
> Squash patches 2 & 3 together (because otherwise you'll still be hitting
> the issue I described the last time)
> With that (modulo me trusting the numbers you put into the OPP table):
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
Sure, will merge them as single patch. Thanks!

