Return-Path: <linux-kernel+bounces-899011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13097C5692E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D2AF4E5409
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5E27E040;
	Thu, 13 Nov 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pVc8iiB2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AiiVvW4I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9A277C9E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025443; cv=none; b=T7+I+EX5xkzvOYnclWsqVtz1jO8+qt4kThWJ2C2V1R2rMZKvghFLEOPU2nbTJmzxk7Ogs11k4QmjgBRNywj4BsO+YhbMv0AwL10Oo9twNou8xa/r2KS2FRCaP1BrTdMcXiNwbZzX3OQoN9dBU+SCMTa9dvY8OK+2JpyaZzflagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025443; c=relaxed/simple;
	bh=1iCBhg4O/Sp62AdZbo2crxvnsklRRrz+t1qwwdctpZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQj57JW/WmM08Y/5rWkjoZ7oQBWBTQcfjV6ImgyiMzT5BF4emyhbdni6sQYcZ8OpQsDTbwM5ez8LhM0JTdQ55CQ2ITWHO5SF7RxI12ezThexaCXlHNi8xI+1I7PfOR/nQsAETvOJ/7C7CQZI3miEnz7MTmziBNZcbA9fKS4Xx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pVc8iiB2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AiiVvW4I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD5qV2S3768305
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1iCBhg4O/Sp62AdZbo2crxvnsklRRrz+t1qwwdctpZw=; b=pVc8iiB2zloY/84g
	xmKeS9HNW+6RQGIxxXt165t6CvqF+8/QwPcUNflbNta7ak7yORfu/wE67UtQAAs7
	9DlrebKDe8B3Hrp4cU772hZBkuJzHgXZXM3EWZ28raEnEOAdlAOXC1lSvGVLQLfz
	IlA3ms8/wJBCmWRTuCNx9n69Hbn7ivR5rVIXwUGwGH2ZLhO9tHGwklX0unTFeyHd
	sIa6c1ru546IHJbzvIH3KWQoHKKZl+URNDbCmbP8KvGCAaGLZXceK2yAyyw3IO4J
	uQyj4b8I6Ld2Wt4Pzj/5cshMEz0Y3gJvkS1BuE8YVL+2A3x7kXKS/mPz5C8jrPz+
	9nJYgw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad9jn0m11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:17:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b1be0fdfe1so25790585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763025440; x=1763630240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1iCBhg4O/Sp62AdZbo2crxvnsklRRrz+t1qwwdctpZw=;
        b=AiiVvW4IKfgt9x5U1UQ3exCEOcA5Vc4n2KYV7bYupjjEjFsWs63bYeMPx0HAGcFLSM
         T+oMCZV887azAsLho+E4FisoN8bG3V/LfSrZA72VTiXImpl2Ya95P538MFzKiCO2niTw
         6NzBRcyfSIllx0L9L/MZ+nIyEIMYqcf+AqiNYrwEqpEK0aLQYUaXwW5AXtqLuur1mxV6
         hW1gqQNbpInIDrpPJ2VVvVxvK5gwsQwHtTaH8TStxYDGlB/7c++ciIXX6dV2+aQmSnIb
         +5Fn6v4xoU4wCcgmtGrveDZFCwyJhX6yF+6hMUu/qhx88LywsJSHWRqbrxQGeVVJ29rK
         zAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763025440; x=1763630240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iCBhg4O/Sp62AdZbo2crxvnsklRRrz+t1qwwdctpZw=;
        b=ejjvReBXsawcIvfhkIY1Ysmg0zUdrI5m75JKcyxm0IP/KE5zP9tI1yDFCQmiMOCwZ4
         3QW40eGO+eJ66Mr9GP/MxAp+uOQLIIz9iJz4meQ/QwviUQ5PrcmwsV+kHtTuzNQNbHVd
         wXkpMudzUGqg3auh3F2lsBxDdHTahxockMQE+7tOhptJYVwHgXyhIBoKsRIlRQbuXDIP
         FNshPWBEdVLL/wVt231Aw1aXjNbeQO7/QLhvjHCCpXwcIP4O5DK+iJukWnczwUQ9Ud5O
         xoHT5ZgAxsdr3yelASN/eMpTqTVGT/x/sZPebFnO/pjHEQL5eMvfeCXXAd3mzxA/vI6P
         hK8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNT/hxhtZq3dvIqdEJgaz7eFUJ17LM1obbANhwWwI0qfWge2Chkf/HTxqkxGTA7K958gj0E3I8q8QscVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyraoFRmSdoRFteWuedeoBACop35wnot5+PL/Q2TX2IzLAMklsu
	BRxtYs2wZOkHWewVKgqn4b3EJMeFo93GQxlr71X4cC/m0sYI3jFir0A3AcHo0DJ7M+WquHiu38g
	xJsslHq/AunUsACwkmkf4K81+Bu9n9uzRWbjfa9QcsK1WAXzdB/ajK+o6Ymipv5hsUIDm9KfchO
	4=
X-Gm-Gg: ASbGnctE3x8oby8vFHj3nXP5aAHPXIK3oTu6gHCGciS3hIN07iGVVq/EDx7rmb9B8Z0
	ye0OUIsDL3f2gI6AVP/lZ4qrnRXRzvhVDN3yR3nH2FWRGJmMcjjXTExxDnOcsKc1k/3O4ccqu9h
	8oEsc6enyK/wV7b+PuS4urvpJb+V+3HdW1yrmF0e1ZtC6o1DvEFlrd0JTitSaaBWg3nWFSWr2Qx
	45XGr23/cCWSdt7cAZONlDo4x/OQtg6blIV81QhZGXQQIZ4wcptr4ZmQHrwyTKJ0QiYGJPOKMf6
	R0qBZ7BPUYFRHGVdQ6XbUWR9wioKzWZevAGRYGyTjDJSk99gQvL4d+XYzYp0wE/ArzISkJvwC8w
	Q5dh3OCi2Cdtf3MARJxBzSzpHlVpGFKuIf9v+e5JQCxlioSMDsest9LPF
X-Received: by 2002:a05:622a:82:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4eddbc80e92mr63371131cf.3.1763025439764;
        Thu, 13 Nov 2025 01:17:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgwH1tbq62hIav4asgnzpyDg+E3ChjsI55cXS382HDS6o/A/DfHR748c6Kzs9DrBEDcRAluQ==
X-Received: by 2002:a05:622a:82:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4eddbc80e92mr63370981cf.3.1763025439215;
        Thu, 13 Nov 2025 01:17:19 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b19dcsm990156a12.27.2025.11.13.01.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:17:18 -0800 (PST)
Message-ID: <29278020-7fe2-4d5e-9de6-e32f9d7173e9@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:17:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdx75: Flatten usb controller node
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251113084608.3837064-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251113084608.3837064-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BvmQAIX5 c=1 sm=1 tr=0 ts=6915a220 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=4zhbYuK-2X_BnS2RGrIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: HRcSCIGLxP16sCgN-5aa-t4kCAw5g0Pr
X-Proofpoint-GUID: HRcSCIGLxP16sCgN-5aa-t4kCAw5g0Pr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2NyBTYWx0ZWRfX28WRg6F5VqRQ
 73WIN+uoMRY7jxqJxD+ine52ccm6aZvUAcd/Rfeckl4DzSkhvBal7OqpMuDd6nLHzyBofCINPEE
 i8ocjipINLsPpU5RIS3C3d63LGsKs9khb1VJoXFO5z1fYtnsG4Le7lYKBLi85u7FuF/G3Z9yHnD
 ggqxCY33qtiJNvU9ag3u5KgwwcLZ1Ppu2nbmzbJ6bl9iWZFXN4DaCr1gMwHD0x4+4Vlu0XNUtz4
 BJb2JhvISXL0COGYYvaC0elX/2TY33rRkiO8OFNxp8mu9AW6Ueo031xfklzRv0B0R65wJ29XJpe
 4x8nfOBR1q5dMimOLFGzABHRpTHnNhrqjNrAY/ZZ0kpzYfiv4wYS+z7tCN4aB7Iy7m3PBJsnYQa
 4edj32gAJEiLkXUdLgNmTyc/jGRLPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130067

On 11/13/25 9:46 AM, Krishna Kurapati wrote:
> Flatten usb controller node and update to using latest bindings
> and flattened driver approach.
> Also add the missing usb-role-switch property in base dt node.

This is wholly separate

Konrad

