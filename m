Return-Path: <linux-kernel+bounces-735957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE3B095DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F95A1B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DFA2264C5;
	Thu, 17 Jul 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FhQhQ2ET"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829B223DF9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784929; cv=none; b=VYHpFbpNTynzcZbkcaIjIhmGyEYw2lVx6mc1TNZ1ujUCNUf2J/Qx2gXoHF1tqJUYE8vBb8+IPEyeTei7pjMFXB/s+4tzFpkq9oz5ZgBCgRsHFJxPJHkyF9CFsX6/rYtc2JidJ6pXNFfP0BTngpbrFn3ODnq2TGTG1IGYVagvW8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784929; c=relaxed/simple;
	bh=rNJhrVaOXBgN447nIGb70CYE7BeWUHH6Lro6HxrOsrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSql7fBpmGsO88+Pn51OJK390UODrlAmSaAwq0L4+NGFnM2kXDAENcinf7GOLhnfU5B3L+dvO83CO+nBPG8cAjIIhMwNc8Mrh5831aNbwG0RGYm3MFFH0n/D18avhlZx3GPBZ00fGRl6znLaJUFrHZ+9rD/oHnOQep0CnbR8djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FhQhQ2ET; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCcrtM021792
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TmpfxjkNhdt9dhUb9Z4sklqbRlDt+2S3rq7vCoARvZI=; b=FhQhQ2ETqrCc2+y4
	HFVwT1131Db7D+9s4XwC3oIlNrsScBTDWs9VTASF3EX4t8uZ/yISjsuRGBcRa6zs
	qy+oi3CA1Zwn23UH1vLa5d05L56n8CaVyfCMD3kLvjnVJErJSBm5RiislTStFI8M
	7Vph2rnsQTY8rU1WGJ6uY4zUNnBFZqf/brojlUeokI7DuPmEi9S+xR5ETye+2F/D
	ZbvqLezI2i+Yfld1A5Qwh45Osx5U3+wKekfrnR3kgA7L8UbvYxTirWo19hrWXIAB
	ZW0Uf2kPXZck9qz4j/rdpS+s2XL/alH5pw2VDRAU82BsZcE2mBR+VawUaxsvhbrW
	8VRfRQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8gy3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:42:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a9bcdc73c0so3543561cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784926; x=1753389726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmpfxjkNhdt9dhUb9Z4sklqbRlDt+2S3rq7vCoARvZI=;
        b=teGDm4xm4CW9mp/JxcHm6KRuqdHmuvAX3dp+HNRo86PtzYtB0Sbz42bY1LwvWVgs+4
         BEKwhqG2ulX6QpBMBDmQB+FncC+QaRBixPbSfhCDXZVMfIOPBLZkdBtxOxWv4QWfRCNA
         w1dY+YFuviQjSQ/VcQNHY6ocJjG6tfSF1M9esAPB8f6bZWuJ6AezMs2LPvGiaGqOJMpb
         YZ+NAFFsmG8EsrjHIOU2xZT6NQXADZFFpg85XFAvX/jEBCZUJnQ8DUhMKv665yadfyMI
         I7EBWj67bnrfqIsM+W8iy30B6qsulSQGIXF3Pk8pgL2NRWW2mnANHq+CFwyapwztP14P
         BzJA==
X-Forwarded-Encrypted: i=1; AJvYcCWxQdUg3rv6EnM9l2duBSYa2LTBoY7YVmEsUk3SOO+NrCBEFLvdYz4yhH+E9GSNAB9Ctd1fyks478GUm4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ1lMRu1BaF/4u5/Ba1Eah34XIK3zaCCHG6zE8oQJpL9ftaOL
	SWJGMQ8zDMtm7twwH5D/Dovza9u1pbiF74Yi1JShsifOtNPTDgaqZNO8RbEWr9VXPMrDOyqxVng
	QzZIQ5Tv4syNtkYoSqSSNT+ss1iFL9Uk9gS9cHlUMHN3iWojEB5a1UYJHK6niiVuiSpY=
X-Gm-Gg: ASbGncuEVXjN8DHqohtGC/4ZJjRVwItKLBTqc0q0OOZxcbWXUMGsn3C+Ne7dlkBJaBo
	vFSeaex+RgMqqKHqBLWNRK6j2gmMXe51KPgMPwZUiZxtV6fpOEP3MEqHBdSc6ddcdVg77GuWK8a
	jKRcpLpMrosMSWIFqy24WYYfVbEhbJhgd1LvGGKEeRbvaW/OuGHHaRP1JTXSlmDOzG1NsChp2Yg
	JEmSk+FovmGN/ubAAnbxcchRShoYd+jR5O48WCXfti/NEHnlEQMZsyIDIjO6Msqq0Vn2EbsWCop
	tDf8ZQhxMBikPCwsNlAFJQgCWWMEjOcmlAxTGSekpsnDFiycWLAx1vUD31c6PPfBznk7tv3Z8/G
	VRFG0OeCiUOmgJ6bzZaZ3
X-Received: by 2002:a05:622a:1a98:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-4ab90a82a28mr55030301cf.7.1752784926071;
        Thu, 17 Jul 2025 13:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRWAhwxvL0YQ5lOLx3J9S62rBalvJHOr8MWbHqXNprUdHSqk24MYX4tdyqOdn3P7ha6yUnvQ==
X-Received: by 2002:a05:622a:1a98:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-4ab90a82a28mr55029901cf.7.1752784925586;
        Thu, 17 Jul 2025 13:42:05 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611d04d8347sm10357916a12.42.2025.07.17.13.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:42:04 -0700 (PDT)
Message-ID: <193de865-980d-4fd7-9c43-39ae387a5d0b@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:41:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] clock: qcom: gcc-ipq5424: Add gpll0_out_aux
 clock
To: Luo Jie <quic_luoj@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_pavir@quicinc.com, quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-4-f149dc461212@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-4-f149dc461212@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MyBTYWx0ZWRfX1BOD6MHWOQAO
 SNhdog3ZPhVH9f9KFdkXfVYFHmR3H75To5hlPyGNzFnmxAGU0+NFP58u08PnzSFPAevRioDqnUA
 GANK13/cJ9gxhqHY9vIX/W/lWd4Rqs/M9d+0Y07ezeTTIwQYMu6Ve5mbn8K0CbxZBLc0q/dCXiA
 wDUaTTpGaT1J5+UGg4VynFLmsrLXDx3uLrKJ2/TEW+ieWp6J3j54bMf36ai0Sl1naf5M/9QTEYd
 3/1UCu+gPgueAuyEJap72PDLQkb6fKogeQPffBtN0dxea82efJLlOt2WIwByDmQgDvXhVTI51ql
 ggAu+kfiWJ+zWgtt6R4Pj3M2Nour+e68cLYJRCnLBl+mc8AxXH1NHv5f+6RERl6CB9yivp0+X1r
 az0rf78XFO9ktZjMv0RHDiO48YS54mjsJSl9X9aqNCoQI1It4HF6phnHNviIyfdWxt+IDcXn
X-Proofpoint-ORIG-GUID: bOwuE7jjIJoXH8HtYGB0tnZv_vx4j68D
X-Proofpoint-GUID: bOwuE7jjIJoXH8HtYGB0tnZv_vx4j68D
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6879601f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=qx8TOUd7-QwhcYYS848A:9
 a=QEXdDO2ut3YA:10 a=jh1YyD438LUA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=941 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170183

On 7/10/25 2:28 PM, Luo Jie wrote:
> The clock gpll0_out_aux acts as the parent clock for some of the NSS
> (Network Subsystem) clocks.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

nit: subject: "clock:" -> "clk:" to match the other commits to this
subsystem

Konrad

