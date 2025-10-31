Return-Path: <linux-kernel+bounces-879558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CA1C236CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC63B348B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B42D7386;
	Fri, 31 Oct 2025 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lfv11ZxU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWTbR1TN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503B6134AB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893154; cv=none; b=OCohBMWkEXAoIbSY9nWhNRAFP6hNOe5R/fnp2m5r0QmVLFHU2AUTLWqkQBjam4fULm8Dige0oRUF8tFkrRDvp98YtYrrVFSokuwk/tfleFgQHVLCELQRrze4yfOxX5A9EvGdpvoQ8Ng/q99JsJNRd73vtaGrr95zpDtDCgRhF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893154; c=relaxed/simple;
	bh=4mDKPiwijcCUcLECjmk1k70WoDUtyStMf561zAWJbWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KInM0NZjFhQKSvJKVh5uCqT3yeGmL2uwCtC2/5IqSJe9c+CyT9jDCB/Zwb0EVUzYC8TQcJExPGXQdGnFsD9PevITGKRGdXT1NhzdrnBCzRMGFD3NwWkoLB4cMw+2yU8oNxBSHTz+5Q2FhUpBSPm4ZXnZ9ItGfMbLbhrTcDd+2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lfv11ZxU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWTbR1TN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V1ncKD1573206
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+POVQ2MjdX0Ko68NYFwX8sDHAhvCK/iScwO3CN7WR8=; b=lfv11ZxUfBeydLcS
	h0WgM4WqU59FWCjRTe3Nv7rjtVSFSHuLDlP7OD/tsb/d8OKy+VWb8gofKoxtzXLm
	tc5oLjLJbXg5EWVQF+hOf3bmVtnrgFSAbab264RkB9eyOj/eqK+1ulnQ6Ep4W3LN
	rfIQ8nc3xXtBr2EusjfAhE0HscsP4ZtKI+YVU1EEiocRK+xqNF4gaOlyyN0G1Z6E
	layTY9gIGj4fWCjKGu0ArXJ7+aBUZvM21PDZAjtSdUzZ8Vvl7nG6ajoBYQAYwmAb
	HriSPHBPdfGbynzxtwspfLjhsuRti9HVH9ZBhFC/wlcpTYV4nqXQ01xX5U9eaBVn
	v3rL1w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc0mnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:45:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810912fc31so1964182b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761893151; x=1762497951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+POVQ2MjdX0Ko68NYFwX8sDHAhvCK/iScwO3CN7WR8=;
        b=fWTbR1TNL68tYgcg1GYPi4S1Qxo1xrMCUTlspxngsN9ybZL5X8wfxZR62N30NLbosa
         Kc5OL7FZC08cHME/7i0u4eMAvNegmCSekhYp55M4D1XjN1PqExl0YvqlOkRAIfyzqs76
         30eHPvpuhS9c3EmaDl0dHxJddoan+TaKyixCd3OHs7lRBGe44oU2q9RH4scoIEbHEcOl
         fqyjT1JY2wDq6RsxXdWOJSGiOqGp3WXtUH5+E7o9YR4rHIjiZ9wrMqvUC07mFA0NIm8c
         ye5+9HPa/cHgp6FspjHdWZCqVsHTKVX0u3nD9qEZqdN/pHHaA7aFXGESUcfA/mhtm3Ca
         Z++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761893151; x=1762497951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+POVQ2MjdX0Ko68NYFwX8sDHAhvCK/iScwO3CN7WR8=;
        b=kZ7RcVIPXgseYs+zHOc5KqezjcAiLPf6h9VSn6tapaRp1h2PGY4aOSj48xHGogocSd
         rMrp8Tc9wXrAOGoQCd4V+EWmipk8HGV1laBE/oNFQQU8YB1VDbwCJfFTweVNZgb1Io2P
         pckYvgbHEKpPP4WvF89r0zlKoAbYSZVD0/ZbJHGDni8e250LKlmhGOdEls/J79b8MEtg
         RDwgEHG2zRpjOJcd9DlzyTmdl/CASNmDmjGqDPl768Y3U3kSm94FcW+Z6Mb1DopV+mFG
         nvrJtPpuX4/3uf19ZpBa62pgBiUWrdXCM16gL/U3acWXAGJ45X1Lb4zXcZDTh9V6T8Bj
         n5uw==
X-Forwarded-Encrypted: i=1; AJvYcCXVuwut6sc6W6nM+1Q/wX8xgrW59CtFnAaZje/Ty+hToCapEqkPYDZrD1BoYGHoF4/N5cCawz78ocK5YAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygbCKuRQmOLCjdHaOwQLSIYB89h4wK3WMQ/yPEhpF82iCi+OCm
	ggJOkLYxTD+0nj2YHBscJbkyEvelNSEynS0Iw+wgWYbCuTsPT9skhIl6xtw8VedwN0kO7BI4qTZ
	Hl/pkgOKre+ZPArg1ONVSGpMqWRJxBAMlC7nqDIKe3pXVUfdqOQVsAq6FXEqiPkBCLI4=
X-Gm-Gg: ASbGncsL2WJBbnIJx2YxakqOuwPMCPXA0JgKnpNu6gtYH1Y7a0Sm2bJIO4SooSrWTMA
	Sbo/WgXrP/KAjSuNa929joIVfPMwBtdjoYkN5z4bCL7r+h6ld3Op4zt94g1fEkkk49xHqryj/WP
	kFZMADS5KFw6TFP+ltCJFGNACbyyCBfEXCLzTMI4OPfIHSbfHzGspYxfWudhK56BQioUbZVKwJD
	Vz3hpPVleJFfBAqISnd+kRI47y71pavGCnTxWxAu83yl/8ifaIePZpCrveI0kV/Fq3hpMnZesOi
	caPC/L/H38v+0EjBZHuFVy4kvoSBfoh01M++3CTALXQHKpBvzMxbq7mXfkk098ndE4t8ZNCm9ez
	XW6ONaOQn0SB4/pqo5lPZ6Yuw+7yhhPQ4Cw==
X-Received: by 2002:a05:6a00:4b4c:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7a779eefde4mr3424209b3a.32.1761893151058;
        Thu, 30 Oct 2025 23:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF73VoIykEZxaNOFz9IRm7VMZZgIVQu6YxsNUcvXtPMIg+/AsyYNHrOPS/22IPBLWrpXB6VFQ==
X-Received: by 2002:a05:6a00:4b4c:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7a779eefde4mr3424172b3a.32.1761893150519;
        Thu, 30 Oct 2025 23:45:50 -0700 (PDT)
Received: from [192.168.1.3] ([122.178.56.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d72733sm1012662b3a.21.2025.10.30.23.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 23:45:50 -0700 (PDT)
Message-ID: <243611cf-5083-40d0-a52a-02ab068aa942@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 12:15:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-3-krishna.kurapati@oss.qualcomm.com>
 <aP8_oZlJ4466BEf0@kuha.fi.intel.com>
 <34atfkavrxtv5xdekrlhhkxx4rxs3ueclxrmou5pquym5fsycv@i7mv7ssdlm2v>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <34atfkavrxtv5xdekrlhhkxx4rxs3ueclxrmou5pquym5fsycv@i7mv7ssdlm2v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA2MCBTYWx0ZWRfX7ldGgcf2rUco
 QydY1wJDpM0oNEW035EhuB8y/bLLV7AVS10jrPyGAw8zh4+p0yVzUIFGE54mDlbDXLdtsXSU9XY
 ktPE6FTgG9U/O1ns3aGMPJNqToI/7wUrmLckq3GJIMN9sF4fNMCdT2wfYu1ZMxh1d7hSEyAiqPr
 pQp5gub9UDj0FgYOwMBfvFQ+Wx2wDYT723gp0jXtbnyIGn/yv/N/f8W40Lv5BxDp4JVkWqQmyxx
 7a0xXk33EfUO6KioNMbg81ctByRBtckDwET6B0JxcnK0PAtKV3YAVaYPyeJ8vNz/32rRt1sdCWW
 7JhtHxFNAJ639Yuwx1VOjmousWkI21gIPKyVV69othh/wYp3ND/Le/sDPOEkiJ8a3r2B2C/psHY
 L0iE8pwOEM6L+OAuwWn1xlYHg3tTqw==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=69045b20 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nBTQbq2h+7tEuhtSPO5ERQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EwX5Vcz9EM-XOFURiZgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: kbbuyR1DiEAyp7_KANpxM9JjGfF5u5Ga
X-Proofpoint-GUID: kbbuyR1DiEAyp7_KANpxM9JjGfF5u5Ga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310060



On 10/27/2025 6:49 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 27, 2025 at 11:47:13AM +0200, Heikki Krogerus wrote:
>> Hi Krishna,
>>
>>> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
>>> +{
>>> +	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
>>> +	struct device_node *np;
>>> +
>>> +	np = of_graph_get_remote_node(hd3ss3220_node, 0, 0);
>>> +	if (!np) {
>>> +		dev_err(hd3ss3220->dev, "failed to get device node");
>>> +		return -ENODEV;
>>> +	}
>>
>> So I guess that's the connector node. Why can't you just place the
>> regulator reference to the hd3ss3220 controller node instead of the
>> connector like the port controllers do?
>>
>> That would allow us to do a simple devm_regulator_get_optional() call
>> that's not tied to DT only.
> 
> But we have devm_of_regulator_get_optional(), it was mentioned in the
> previous email if I'm not mistaken. If we need, we should add
> devm_fwnode_regulator_get(_optional).
> 
> vbus supply is described as a part of the usb-c-connector schema, so
> it is not that logical to describe it as a part of the Type-C
> controller.
> 
> 

I tried the following as suggested:

hd3ss3220->vbus =  devm_of_regulator_get_optional(hd3ss3220->dev, 
to_of_node(connector),
if (IS_ERR(hd3ss3220->vbus))
   hd3ss3220->vbus = NULL;

If there is a vbus supply I see its returning proper handle pointer.
Else it returned ENODEV. (which is fine for our case as there is no vbus 
in DT).

Can I mark the function as a void one. Instead of returning any int 
value, would it be fine if to just mark vbus as NULL and proceed ?

Regards,
Krishna,

