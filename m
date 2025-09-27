Return-Path: <linux-kernel+bounces-834967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F73BA5ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3666A189FDA0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5C17E4;
	Sat, 27 Sep 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLhee7PG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3236146A66
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975705; cv=none; b=dcGLf5X+CO0AaoNfUFzoacnDlLadQSYU1z0UI6nBy30dAoQnr2Cj6gmYwhnNPypPi7GIXbXOGUR92w9tfjTZ6yegykSLKYteeT0ZAHwWXr96U9o46qcCLJabOtiEYUEFyfzstza5h4dahsDOfWh0v/rnPCOGix3oZuSbzlFkZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975705; c=relaxed/simple;
	bh=qnNDCbMI32av29tRnaF3im4PUYnDi6Fg6B8QmcqH+K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmOpEzdrxCEP7GV201sOjGOG7tlGqLNpHH9eAtcq5xGEUnGgHUlpaZpwAAUxCTttcxjZlwsdZNd3NJk+hM0p0cfe7zOTwNH3P7+irpbEQTnsPHKlceRt84bIwyIKNZaCDir8f9sLUq3uYHCyEY/vQZ24N2C72WDSbQ6hB/wgmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLhee7PG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58R7vv7o003318
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xro+e+2dn97miI0U2SXZbX47C9NAolNE135GXXYJKfo=; b=NLhee7PGJLZB5Fnn
	vFbygERstPkTv8KGfyCLPxbaV7yvjOfeJ1btIaJZmBCw5CVuaPGi6Sr3dgvg066v
	xu2i0joxVOdaiTagRby45JldGWu8zuRdWPXINGNbJYOxGnG+ik2jt5rocnqGqko6
	vpyvk1X4Zv5d/t3aY088M0EFBsE4XCY50j/gEESA2g3QUlL62e7YR9+8JzAeNtqY
	o4hN/lTrqusbWij6yZbufRNtSXGxwHLokgOTZCAAaT9o7QhExkwML1l+pL9vXrch
	qqWWIoAHRE5PGA06dkbZFSCFWaCR7NqDp2He+F1L7kw6nbY1RctmIMTVKLVYKuaE
	B82hhQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93h8kyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:21:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8649a8dbff8so18000385a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975701; x=1759580501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xro+e+2dn97miI0U2SXZbX47C9NAolNE135GXXYJKfo=;
        b=arARQfIEsm0okMsYVwy50u3yoyx/eivpmTAd5m5nQxZqj8UgrHiF6IwCEYA0CwOnIX
         4re8YZQkQXygcbclfNWLx3m1yHlcZSupJWhOHxugOzKPDGwOsUBrMzuRS/j2VmXD80gy
         qZmvCijEQ592ghOwi9SasGKXeWL1NJjaX26I8LjbjsFmDAsSIdLnEGdEgzKypETiHYuV
         qTz9V24ukjwsyZ2iuGEY3BWZz8lvSOf67GZwVA+A6Y2T1VA6kKr/5JtsbV5olcss/zB3
         PcWgOZVtS81IioNq+yv3No+Oi6cHamPUMp7K0PtyyHY3OM69VOijC+HYAGN7nuoKYBwM
         cfJg==
X-Forwarded-Encrypted: i=1; AJvYcCUwRPes+6Xg+AdW5373NrvnODNf35mB0vPk3IF7WXci8EIupXsgCFGGDQr0s5FCWuZtepMw+NN2RlyNSDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7d72SR2O8LXlXsfiEPb5v5II16Etd/i3uAInxQCjHJjWKt7w8
	ZkCxhKHhTx1z2/qR4p4Te3CSjwAMEnqblsQgXEGEK8/GmYpvtIw9FiySMPFr6dnhIuM6vNYMb1E
	ICTMr2rpVAnDZb0G9IzxXHbnOlDQlBpuUxLlyOXhZSZtWXNaHFW8r0jmybMZ1haTIp1Hj1o/ENp
	o=
X-Gm-Gg: ASbGncubO5FYuMX/407RgUyGlI+StgjCqKu3RUMxSQYatkLB3GdrI/Of5uN4WFfEKGW
	7OUpBEVOh9m/4eZBnwAwVgr8foOkjDOVFwoHDKDXPHjDFRXaQQraCOaCrzJN9exR3dKBYpu30AK
	E/sriKtTmd9/ZlQ4nMuwjYJuzG69puDg1SbwMyIAfkHpakMepONnx83XUYEX0eg8ItyJI4BBTi2
	K0K0oSHosV3xxlYI9bTwpZYZUHUaiZsjRIVy7OBD17lJEcKGq692bgS/6bb4YPjRRCwcZQt5Fzp
	jGi6tvgWqJjvklj+N4+aYylp5aQJJKn7csmJtVyocHtEvS5/LC6ckUXki3pcDC5CynEFxvkz9kD
	xufnt1a2gU3CV2PjcnJu1Fg==
X-Received: by 2002:a05:620a:25d0:b0:829:9017:82b6 with SMTP id af79cd13be357-85ae6d8219dmr883816985a.8.1758975701564;
        Sat, 27 Sep 2025 05:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/XBV6tFVH7HzwL1SHOVi3TU/smws27aZNO1x1ZV5OkS2elqGSSNvmTbLL3DS1Bk2Bf/mvlw==
X-Received: by 2002:a05:620a:25d0:b0:829:9017:82b6 with SMTP id af79cd13be357-85ae6d8219dmr883814785a.8.1758975701006;
        Sat, 27 Sep 2025 05:21:41 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d0526sm548975366b.12.2025.09.27.05.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 05:21:40 -0700 (PDT)
Message-ID: <656173d1-b739-4f39-8e33-9c5af657825a@oss.qualcomm.com>
Date: Sat, 27 Sep 2025 14:21:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Rework X1-based Asus Zenbook
 A14's displays
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
References: <20250926-zenbook-improvements-v2-0-c0b512ab6b57@vinarskis.com>
 <20250926-zenbook-improvements-v2-2-c0b512ab6b57@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926-zenbook-improvements-v2-2-c0b512ab6b57@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX6qfo6sUNrpWb
 dx3JGTZRj3SJK3k7ly7VtJKr7NV9Xu3Z0KpPJ6NGXLUwSDLOEV8Yj2iZ6NZKpoBqyQqrNsll09H
 Vb5pNfiSUhDXtwUoF3mENgQ4oEM0xHW6Q5karpBBOq23XGbfKeBYEHr/8GWprwPsYf42uaVK4GS
 jtnsoB8dcssF/JHil/vQMiBMkkp4BmPBDaVx5Gul2pQEcgzZ5s0v+hIWP8IExGazH/fGSiZ8UpL
 qYUqpKzAcwE+lXwsJXpcLigiO6Ml/69c27PPkVNDvCoG52e7VciY2Rtxq317uLX+BHVfJolxtsg
 fBh7Bq3nXAt4+8YJoOo0E8Y9en14VxsKdJIXzqJS/7I9h/SfAut0Zkjs7eoXPvOCTIyqMjDvVi+
 DlQYLT5hUcyy+9LZmFAnYLr/fU3cQw==
X-Proofpoint-GUID: Mo-6VSvofbV7w76HyWFEqqQMzhLpeCF-
X-Proofpoint-ORIG-GUID: Mo-6VSvofbV7w76HyWFEqqQMzhLpeCF-
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68d7d6d7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=I76Qk8w-AAAA:8 a=gxl3bz0cAAAA:8
 a=EUspDBNiAAAA:8 a=KT6dqS1snKeT78_s1OIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=vUPM0Wvl0xcrLs4nqPIT:22 a=kiRiLd-pWN9FGgpmzFdl:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=UDnyf2zBuKT2w-IlGP_r:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On 9/26/25 9:08 AM, Aleksandrs Vinarskis wrote:
> The laptop comes in two variants:
> 
> * UX3407RA, higher end, FHD+ OLED or WOXGA+ OLED panels
> * UX3407QA, lower end, FHD+ OLED or FHD+ LCD panels
> 
> Even though all three panels work with "edp-panel", unfortunately the
> brightness adjustmenet of LCD panel is PWM based, requiring a dedicated
> device-tree. Convert "x1p42100-asus-zenbook-a14.dts" into ".dtsi" to
> allow for this split, introduce new LCD variant. Leave current variant
> without postfix and with the unchanged model name, as some distros
> (eg. Ubuntu) rely on this for automatic device-tree detection during
> kernel installation/upgrade.
> 
> As dedicated device-tree is required, update compatibles of OLED
> variants to correct ones. Keep "edp-panel" as fallback, since it is
> enough to make the panels work.
> 
> While at it moving .dts, .dtsi around, drop 'model' from the top level
> x1-asus-zenbook-a14.dtsi as well.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> Co-developed-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

