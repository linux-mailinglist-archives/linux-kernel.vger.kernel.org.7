Return-Path: <linux-kernel+bounces-844286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C3BC1745
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE113C50AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD82E0934;
	Tue,  7 Oct 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItS18Olb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895A52E0914
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842969; cv=none; b=NHVF6zS243d670GH5AjL4/9WhBdzk+49jde4IWPdC5s9NQT2EJ6r1ldf1Ii+dMEW4KNGiQJ+alS2qCXuCbSYS7aT6ITkkEPjfMVN/lGrZuZtNrtnqI4BekVFC0EYmAByrai3r6l18WtPEjrw/ddbjkVNkBpne5joCTSZMyoHrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842969; c=relaxed/simple;
	bh=D3vC0/amDTtK5+1RhDAP72M4Lfvxbv46RZauQGSK73g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwN/ny0Yy+SP1HrTGQSAuFJ8BsICnG9kdHJ6wl6T0M/Mj42VUy4GMiGYsVY8+OB51NRZOJjC+BlNXRnCx1bBnZGMcOBIEqIKs5UWcEYBsdvXSHTv4SltchTNrHApxUwAKix2xjFWyfuANRNENX6N1guGeQwjiESN3qAEyMzvDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ItS18Olb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597C0TaT003197
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 13:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9lQxVJqZ76V3LXvoCzGS4pSFF/q525kWkrJKuP9Z+Zk=; b=ItS18OlbznN65fqq
	cfEQQlOWFMoXdHypqQLJAEqB0qBtnYAfmguzpdCH4mcp0jWhDGjQOXHQPHwF4nU+
	OXiGpoCRkRiTCKsf01oXGvHkpEit9QMqtlkvutraRCM4CgulpAbHM0mw4VjbNHOu
	xARhJdOK6FkcdtfgeZC5ieGhVYZ1D9rbrr2vVrKDaiDKUEmB10AGk38q6UFOWTzy
	nS37JXHARkg/HceTCQc7t0cUohsapG6LlEgYzpFZcTEyEd1oVyDVfIKHFtYsH0R8
	KpvMqyo2b09tnudgilE1qCNUMKeUSRXg3EIgEfDSzz8q2ZN7O52a3UhySaQO3EI/
	iLC8/w==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6ybe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:16:06 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54aa2355459so639922e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759842965; x=1760447765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lQxVJqZ76V3LXvoCzGS4pSFF/q525kWkrJKuP9Z+Zk=;
        b=hDLs1XFZRc6TkA6sVhA/DAIWJsplNQxhMbj091PKsu7r/qbC6wKvGMY6cyjiIL07St
         nJawhS4dr7fDkdYlzJD8WiPcIksfUTjAYYXFbInHo1Hn9HXm7yOSG+jIdorAAePqtwgz
         8Y9R6KYho4lPO49KYMcjqj11hyXSYK+a9qIIAJVkEzsN5s7Rzl3XDJr76Lj/LQKsGvDm
         1Ey0Sd4hKIHhO/3dLt3QRwjmWWZkViYlwD+Eatl8vpVvEcWKVbrydJzVSswsyGgK1cql
         IILZjEDw9kFZGYnETB62XmGoWT1aVqP7dwmMtRKRG/USk9D2gpgr9s8RpZgeEF4Ar35s
         3v3w==
X-Forwarded-Encrypted: i=1; AJvYcCUUEWoe4pyTUk8BNFOm/jwl4ZKTo1wxphKKA98/W34TVvnupXUo0OasFggDzQLqQ4fBXTzYyOQJ71ULFyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEwSk77wIX6tB/JmjlHy8d8NgUbrtgaCil5QRKDd0FFQJ+A5x
	VmNDF12oeBCfgux4k1cDOpXFDEq2ur0yj8ZxEqDSmn6dApNy2zTUIpjTZu7eu4kIvKfw93rZHJ3
	rVPcH4Fpuh0KcUeWs7+88p2k5NM0eRwFV4UyniNuvtZdJSF81KEqJXaC83HmbwGl2wCxp+yBPvF
	I=
X-Gm-Gg: ASbGncvFjIn/QZt7nhyA5DtmsCrHdjIMGkpgo7SgPgHKDGwWJh0hZOFq93PrlVlEJDc
	ZJ9va+/19xZtISdbjh9bpRsHjKF3m04NEi3FLhRYw5ZqoVZUn9lzPpT45ocrMa259ZCakdm2r95
	Aga5DPhR8YuiyaKv6yyDhZEOw9CC+Ie2FubMrrh8e8xZulZqGRl7MdIPhlgqN2QBN+84+kQqrs0
	w92gT3Ha5OKd0Ju1q9ify31nvbHjiYpET0tmqk0v4iCVlPRDLvZn/QU7MPTXsxtCRZ9fBhuXsDl
	QPAn6JYV59TYDahdt5KEnEHh1/oIyUHLO/QW0I5DYKBIHPR6hCXa2hojX5ASaOv9c4TlvioX2y3
	k9+5IT+gFBuZrHFmeEd/NavLSUr4=
X-Received: by 2002:ac5:c0d0:0:b0:54a:9952:5572 with SMTP id 71dfb90a1353d-5524ea1456cmr1667126e0c.2.1759842965314;
        Tue, 07 Oct 2025 06:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCc0SPWEj1jSNBeOVABr/xb0UslG0Djb3P/yBaYz0NGqCuIh1r1LTgML2OmBHUgAZiBZDsQA==
X-Received: by 2002:ac5:c0d0:0:b0:54a:9952:5572 with SMTP id 71dfb90a1353d-5524ea1456cmr1667091e0c.2.1759842964699;
        Tue, 07 Oct 2025 06:16:04 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b30asm1435265166b.59.2025.10.07.06.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:16:03 -0700 (PDT)
Message-ID: <335be224-88b9-4241-9e82-d7c03a4a0ed4@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 15:16:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: pmi8950: Add missing VADC channels
To: Antony Kurniawan Soemardi <linux@smankusors.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251004-fix-pmi8950-vadc-v1-0-3143ecab99e9@smankusors.com>
 <20251004-fix-pmi8950-vadc-v1-1-3143ecab99e9@smankusors.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251004-fix-pmi8950-vadc-v1-1-3143ecab99e9@smankusors.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX+kz+PB1khD85
 EduawM4Y2AtI8l1pECOon9KvhAG87ad2xs0eu2Nxtvj5Nn0W9f2biPAXCD2fMYhW9srJQXrR3cs
 ITEY0748HJobzSsL2RSksZc67HUMxHzzDKn8GajXeRcjRTKgIrgLLsBz9/kFwjrZwhds7ygdQTu
 G0BLSXEHm1GcyXrTsIbF490TLKjGgXoRE+5wWeR2KT6tQw5qeOaRxWeEQurecuwarbnfqaV0AX/
 TqzHSDwIY196fgZy0sTmFj13lca7u1JGjAzwwtNdzD5n8ehvGJ8ji/0L5G/b+yhvgW3itnLu30p
 fjCDKJPrL0kBm/x6ePr/taX914L7/nfNjFRf3hYM7ODMSMkXwpVomC+71ZWEtFqcOVK/zbRV0vC
 LeBJ4jzyCkNhW6vJwsKuPqUoOSvECQ==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e51296 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8
 a=-KJxd_0Hb4jBXpvf9vEA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-GUID: Ai_CtpsXB9wbRIXAclGmMi8YJVZLt_-z
X-Proofpoint-ORIG-GUID: Ai_CtpsXB9wbRIXAclGmMi8YJVZLt_-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 10/4/25 3:12 PM, Antony Kurniawan Soemardi wrote:
> When booting msm8953-based devices, the following kernel message
> appears:
> [ 13.090800] qcom-spmi-vadc 200f000.spmi:pmic@2:adc@3100: Please define VDD channel
> 
> It turns out the pmi8950 uses same VDD and GND channels as other
> Qualcomm's PMICs, so we can simply copy the channel definition from
> the other Qualcomm's PMIC dtsi.
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

