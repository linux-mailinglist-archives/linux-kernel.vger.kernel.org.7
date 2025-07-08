Return-Path: <linux-kernel+bounces-722066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A4AFD4CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D5E166050
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA94A2E5B09;
	Tue,  8 Jul 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHzQc6mj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5A2DCF7B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994526; cv=none; b=LUKnuHUIUvj9oZTQrFQlws97Nn5fTlbAxjB/e0Rk4uV3SXz6Y0KoUcc8EM2kO0koL5R0CLNVrWRlf0V6tIw8g/18MTTv7tH50bm4rLBcdRFwjJ5imjHgn4LqAoDJdZ4glXcHpv6psGd8H4VNxVlwQfkRFWkbaBTfvFmsc8VomMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994526; c=relaxed/simple;
	bh=GHglzFE+Ixz0smICAMlxbuuSv/s54zBE6ok15ILfLDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJk8Lz6k0IOEmuCM6aoyfF76TuNVFvSLmfXbADVa0gsERoOu1V8kBxn5AU8ATXDDO/ftYMf9DRjlWvl25RUzdb2rlyDYRnMwfmlRPtxdeJXjaFjCrAJDPSFq9sre+7v/X0cgo1tRbDsSGrqO7BJ5UlYAbIUfEICvuSXyL5kLH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHzQc6mj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAFxc008265
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 17:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mEXFn1f7VxEWXKlywCXNbVNhNpXfn1kydvwqsDgBq34=; b=XHzQc6mjJOMn4raw
	kilbJTRZcvdtnowryALQXdGWloE5cDEA3tAd5F3Th/SFXV7ZCOyhvEQWHz7F4vWV
	4XGKr5EGrsiaBu0ZhEUJXDen8SRR9U0KWINBlMe7HBNlDbLJ/A1/9pbZsPVp2OVp
	3iDaFcdFWk0wr0MXHJncwbCoN/jN2bl4tPP+JJDZemuFpt5Ti8zbFIt2VP0qRPTP
	e6zN3lVkpC2WrdPpwBvwrz5dB+oZnCmgZ7i2+bFuPnsxQpFaDFadrXFanPD7JlBg
	BXuGr/h3XdqgPB8KD0d0wU0EtOCTKWXrZ4ZlImHmg4t4T3QQ4Lje1pAOuNApcDTJ
	kb1G5g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn0kvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 17:08:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d09b74dc4bso48063885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751994523; x=1752599323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEXFn1f7VxEWXKlywCXNbVNhNpXfn1kydvwqsDgBq34=;
        b=Of9VWJPzmwgp451W+uYXXI0U2+vDvLz1AVfF7Ie9UIEYYgXH65QGa/NF1zo/59mNem
         HaV+bakC+yX2ieo+8rl6M0ihluBB2jJl5pbURe0yhZaYqs9k6RRLgMFRP0kwpETHLvG+
         LLnojUiqIg2Yf8/VbF7QGz+1ry8bELqzTKM2q/+vjn4UmbBu/uD7icgw03Q+/CwfeAxO
         5YhjZ7T0ZjVPLv8F3W73wTqEeBH7rbEVeaU76iSiaAw86sD+PnQjVXBl81zRL4Q1g5I8
         BiMF5xC0tRiXwVmS4S8X4udwspOzKOzEBAwgjShm0rL1tqvT9A6cYybgp8MsjDd0qaDc
         aNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOPrKgVr5cSGhcJsGx2K/pP6FB5w1csz0Kwhuwo+mGgd2o8MHBsiBuPPN5OQPm15hWokuboEJbOx2saXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPxuixgKvZI+7AsJ+H994+EEWFO3JaxMkE1HmdzxLxjXKkRXI
	BqSvuCt8qbn6J27q2dEP5ERFcWvRZs0NmgH3Bq1dpSB0xwrBY/FJkUrYHI5NCWTrdyv0rOCjUlh
	Hop/i0mP84MMAufqJntwOlX+eL6S84m/++Q6Dpn9dYE49QtUb14jbqaxtZlyjWu3gRnY=
X-Gm-Gg: ASbGncsN5JfDjiaunxzrw3+oBk+g/z2aUGyh0ps3LFVhd4gXvWX/TCou7kOELntPOSg
	+62+mweeTEgIthn6YspXABjvn7/zDdIQMdmKzBKjqN0ZEbpkuQi/8yLxRw8vPxWcxi42za3CyrI
	QBazBlyj2F5fN4exPY6cWZud9K1Zmh27DOfVHEAVW+iOPMhkRHvfX5yBBlXt1Eaf2zW3WBS5/j3
	Kr7LuNMNLk+6eE2TzSepUGI/lclaj9Mch5xGRBpza8piol/vC/9xZluotRUValJqYe/PKEFBZEr
	Uy2g2V/9ky1O4UrGAX94Vl9B4XA/J3qo6JWpAP6yhYxk7WjaBDu3u6esWEsw8dPH71/jJIoipLF
	lt5o=
X-Received: by 2002:a05:620a:440b:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7d5ddc9bdd4mr870235585a.13.1751994522848;
        Tue, 08 Jul 2025 10:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcNZy9pWSVwJg7fRmgzuM3id/0/CdApeVMj/tklF5yeHuIPH6i7ffymVFB2QsY1SEGTt8uiA==
X-Received: by 2002:a05:620a:440b:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7d5ddc9bdd4mr870211885a.13.1751994516343;
        Tue, 08 Jul 2025 10:08:36 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d1c37sm928144366b.35.2025.07.08.10.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 10:08:35 -0700 (PDT)
Message-ID: <e50c332c-eabf-4615-87ac-2d371f8ea640@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 19:08:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] arm64: dts: qcom: Add eMMC support for qcs8300
To: Sayali Lokhande <quic_sayalil@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc-owner@vger.kernel.org
References: <20250702085927.10370-1-quic_sayalil@quicinc.com>
 <20250702085927.10370-3-quic_sayalil@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250702085927.10370-3-quic_sayalil@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686d509b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=sXtFBv1i6a_ckmA1iBkA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dHf8gaUZ1bBk6CN9RsgVUQ4H9cDAZqZq
X-Proofpoint-ORIG-GUID: dHf8gaUZ1bBk6CN9RsgVUQ4H9cDAZqZq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0NSBTYWx0ZWRfXxyB3RuOeaU5n
 uNCyJon2UqqZU4co1vIUXA2QAYtNBbWv4Ep/BUDrYhvdHXXXxdSm9RODkQTRkbDcpcBDATHHM/L
 N/cjvTCPIXNF2Iab1Jo8xQNSDoSJ/Mz9ubWFLx5VcmNR6wMrDz0ZJBjq5c5bLnfZlFqaUsM/JRu
 vmGOybDm9gR7LeGbsv1wJjaS6wM9e74zwy9Sl3IrUrjVlpoaXzJJFZzukyDobuj1g/JqptAPOMp
 SEvNK/cdkWkFCbzxe10RpWlfGcipyYfupJCDdhuQRzzba8VLtwPL0G0LPnsmkeqAAdgdy3pQ4dH
 nc9O3rV3GN7eDluyuw7cDtkcVkYo6zPWBwr5AySlmhGTCWJbRIoRx5u4rWEIZGGolnhQJ3XChQp
 h2/4Iek1Gkg3QcFpM0tTI2Svm8XYS5+h+cw+4232JbZyJ3brC3gDtxxvk7FsIXzbcULcGNz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080145

On 7/2/25 10:59 AM, Sayali Lokhande wrote:
> Add eMMC support for qcs8300 board.
> 
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> ---

[...]

> +			interconnects = <&aggre1_noc MASTER_SDC QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_SDCC_1 QCOM_ICC_TAG_ACTIVE_ONLY>;

SLAVE_SDC1, see include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h

Konrad

