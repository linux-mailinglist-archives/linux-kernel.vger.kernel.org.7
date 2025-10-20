Return-Path: <linux-kernel+bounces-860255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C76BEFB00
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E5384ECA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989762DEA8F;
	Mon, 20 Oct 2025 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drXT9rVh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDC2D77F7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945787; cv=none; b=i9S0U3fuX1Fzktza51+AJxwi1AKwiHWTiB5OzzPJQAAI/5wf/4Rd0A+3p+YWHu2auHgC7TFU2G6LlnvGPSDshRc/pM3JMC6JHYqgjuORHXltiM3ZsFF2/i8jd081AUgmqAP2WiJg3tPCeX+0hhjLn6/oapyD0NELhi0LUKyqtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945787; c=relaxed/simple;
	bh=Qy1G+EoRAXMHmUHIgMwmRFAQ0JRvR1cM9i4cWeDZdqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jr4owcu/VYYoXQyQax4hmN1E/dclff6K5cHJyThvP3WfMZcyn7UDgLrs+m68HZ/IZuRUVTQHsTF27CoPVhdshOwl/x1pJARm6IM78I3pqHngKkPlHjEY3LgvwNpIASdBO7ya66sUR2KpMux2s5PpDYv+pKGBmMgRlrIWw87EMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drXT9rVh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JFvPUI015676
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N054C2w59vHr48/aMRyFcCjv0bDt+WkljDcX19Q73Nw=; b=drXT9rVhle0ylq11
	xwdFLr8UXRZII2v9blwBsUMCSbzPOjniZ5Szn0Gu3hgUwXPjw1WE1ZlK2Vgz0LJh
	T0GdJiPRVEuYF6MpliZ3Dy0ePaXIFtn3UJDHbxJAN5vF46SgqE9K1/gxnWJE7Upo
	qMtsYCO8Sw6x+vxSSgNW0u5QC3bMcc+h9qzmqt2C6UGfh6KXt8tSx4DejUABHXLq
	fSr4frdouj3b6keRCY99PwgHVb8h+T3hjqSLtY9Y7VbtjedgtqSPcmm/WeGyBszp
	Cpzrp7feKUjD6ClT+sqDv0viKHnHxfFrsRSEGFiTatbkvGmQC+0YZmGVspjkyMvi
	N0kiMw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfc7s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:36:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88e452b04d5so137484685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945784; x=1761550584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N054C2w59vHr48/aMRyFcCjv0bDt+WkljDcX19Q73Nw=;
        b=ok4y86KeoQZ8oBMytZaT7wSbqCQ4M3O3qnpOtfrc7DmJXBVNsSyMeJSF9pyPS6rs74
         AXcpNSAtcRLP14/ML8jr2vNqZBv6aqsDSpWx4/2MuTggRtX0vmfs9w6eIOKOP/nKNoxG
         df+n4sz+89WYqwgPox8N3rLVRMgKxAv9lLJnAQQK/eWVpVS6YmVr1h3B9yfM+HI+OQo2
         OUHyLYkXbozRR0rPEMdidIjUoLa1GFkJGsEbFsquuIZoRVmdLtGLDPb6KveQkYNIS+XW
         SZ8oAqExvfkqUR44WsCssbNB/zmd1ruuGIjkBuR6O6COawpzcVJ4+ZeZ86vI7PYhVv0J
         Av1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf5Kj+AMCQmE3nlOV7gkRjtkIjQVdQjk/CSkpmxIZJOff5jL7TtqST9IDt0+8pR8kYsotEwgFYHFH1Enk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuZ8er6lbbknd8t+cPX0doyUun8qIjRJwdhhC0shAqGOAsCDR
	PEAtFNSL3ydPfPN03NypBui9gy8GN37/ELpZRI3BUzS3rmY3dIX2RTFxuJZN0qIOtEFMqgEkHRU
	C7ARD2lxRmONiGi+QVcRLWDhAM0Cy1OruPirkzXjUjgCy6UHNFETLpcW8lsaHsC296Dg=
X-Gm-Gg: ASbGncvHy/tKa0nHH0f/rVUYbjMfrtoQOAxldfrJe6uTWluKYQ8bYV51S7m7YT+HlVt
	r8yEJdoI0XQL/IzxRKPerNmpEn5Y/h7R7K0ChxP9r08eHAECR4TEhVMyul+oSQvlxT4NiRjjtyn
	UuokUKpzm0KIkyaC+YfCJVgW0E8WOwCCNwh2NsOoxxXc63HyflGiv8LuTmAylcMwTmf2nb2H0hE
	9m/PT1rqT7nCcUNkM9a1gOHyPE67QEujJ/dCjtcp2HNkQg4WKGqKCutZG7tZ2w1kD7XFfQPzlQM
	7Kse6zdxBkUs/26INSoLTKkE5ed9jB/RLgextNmlt69lrazMmgDMcshA+cybTZqLroQ4KzovHbG
	nR38cV3jo+CjjUK/hiWBXeV8f5Rob9FZYC27YNuzWqNDSSP/eaWx3eND1
X-Received: by 2002:a05:622a:189e:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4e89d207c42mr118106631cf.3.1760945783849;
        Mon, 20 Oct 2025 00:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9uBljlSH/Wv6NYpLzdajo1XNL7fsX3OsNCz/tXB8dlR9uxsqAlRBW0Renn1fwMMuIYevFBA==
X-Received: by 2002:a05:622a:189e:b0:4d7:e0ed:421f with SMTP id d75a77b69052e-4e89d207c42mr118106521cf.3.1760945783434;
        Mon, 20 Oct 2025 00:36:23 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526464sm705231766b.64.2025.10.20.00.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 00:36:22 -0700 (PDT)
Message-ID: <f725dff2-df3f-440e-bf26-6f828bf0486f@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 09:36:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Fix compile warnings for
 USB HS controller
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251019115630.2222720-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251019115630.2222720-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f5e679 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=PrRowSUOeYNWhlAafI0A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: xFIP5bbUCwNVzHU8eFPCqiUjZ6GTSKBO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX9HDOBygGnc2I
 RerOhl7bDiXk1Ea6eLIPSSXmDHUtrlFbmuJvlleiJxIhoAhmhiSRBJtGtDfxc8HTelpqTdZwIxQ
 ASNH6Z7GedAQ42bH8Sc2j5ugfiRn+g4+b78+wX/bwJrkK1CF/YN95eZOt7nv130UHf6ywGF92Py
 /q0Ylck9cN3rD1w/uvBsV4RRmQCw5Wos9M5zg5C6yhgefnkPkbCzXqOXfuNws4VIOFkF/ufy/Nx
 Z4OBJ6wz90ZjDThvt7CcC3B8cZGkZOWuBh/mF7IiEvYHD89lFN3EoV1NcZLHkdrvIWOGvkkR2KX
 ES3dzpBA2uLfrRPTJj89TD9tkO57ArXEq+AFaqJ1McaRXz/3Xj7vRjVO8iuTrn6v3QKxSd8bDpf
 1lahqDP0s/Uhz848Kf4ffqPrx3tIeQ==
X-Proofpoint-GUID: xFIP5bbUCwNVzHU8eFPCqiUjZ6GTSKBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

On 10/19/25 1:56 PM, Krishna Kurapati wrote:
> With W=1, the following error comes up:
> 
> Warning (graph_child_address): /soc@0/usb@a2f8800/usb@a200000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> 
> This could be since the controller is only HS capable and only one port
> node is added.
> 
> Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

