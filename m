Return-Path: <linux-kernel+bounces-852286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCA0BD89D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F64423B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A752ECD1B;
	Tue, 14 Oct 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcBtrU98"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509A72E5D2A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435933; cv=none; b=VsfamnMs7aWVO3E63MvkwgLfNB8mQUL5Qr2L2o69vDE47hn7flS2tpxqjPIW64onWSCYyjk1cr6mAh9rqOx42diekGTf5RisE4W6gsUDGw/kOFJEwwwkK1R8Z+vdvLx8VfU1pTDMuSRuesG2UiWGXg2NHfKfce6tPR9y85F/LhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435933; c=relaxed/simple;
	bh=io6QOTrYaDE9s028FeLKTAMlnHfbHghqFVrGpVGtXBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVHwnl00yUEggP+ufdTlRsbD7M3dMHAnVHZCIyDJcpb34kEycnk+blk9MCvPl0OKrKekUi4lb9vqjL3jSESqzgn2TAy3DBGfe0E6MN1/EJp/DH+u9lqWlgWyp8QOD54S0iuUPey5LU1wqRFPFZZAytWbnfj/gmevDbZwLeReWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gcBtrU98; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JSC025684
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DSMjHDTClxj+PalxEbTH9ZRHAQzCK5GT1sDSL01c+XQ=; b=gcBtrU98KIZEpLYh
	ajS7NMK8LRgG2D3spy3qGrrfnkkdBYIZaAY7ZXf/4p9xO+iwPdYfho5g9lGnf+0m
	2PNHN9hKwSOo5WbbPBEqNNiTmhrjNmMrrsUNogN8xwe8jkrf031Dde1xt9xcE25V
	k5thqj+03KxurUwL+ALqPlQTD4tvmNs+PLvWilI14lcRE1bPR3Sx6QfBQ+Q7Tp2v
	bJauW+nyoYomBwYxqq9XNWlXA6PqSAdhy5b+QC6ochfNjmtB3CW4qSAhLLT9CdtE
	33v//0+v9u4MVjS+CHR7RQdaL0QL1bRQD9RiNV0VlBcSDu81z0ZGFPwyvMj14McY
	VTUsCg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdfyvfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:58:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-886eaf88e01so257492385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435930; x=1761040730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSMjHDTClxj+PalxEbTH9ZRHAQzCK5GT1sDSL01c+XQ=;
        b=GBdmuIB2epXL3kKvWvNhJa1eqwA+QMcLDcmllPu4djzuWh+fF0Avr6CbpcMKpuhQNv
         hJZWezSCQYFc37uLF2+Ox2sXlPAyGv2sL3eRlfmZDSRxO3YWaezMPhdsXazya2i6o2Bv
         8STGevm3xbzYEqTgFCq9RoqKHeRdgmnA+WeNLxIFyYxZEvAtpY164JETal0i4eIDifPg
         YSaNdX5JaZ0Pc1+/aWRmlSyFEFyXTakVmQ52PSG7AbozxgI3MnJ+wEExc8/CUTS1MAvv
         c9JWehYf5oTcDUZElyOBUnhPjWXeuW0+L+m3ARiKTFXgT4l9DRaoT8m1f6w/8VKZt/dk
         ekdg==
X-Forwarded-Encrypted: i=1; AJvYcCXQqAYhQSfd6atEVaq/m9E+HpGKJS+vNw/YQvxmE50ALevaACWS+pL7h8zzCxzn3bzGBTsaKFSwskddPN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32H4pTNTyEzh5rdT7opcJ7hQ5Lj/LeH3oCws5b4nmrHQ5qJ51
	L6Y963rOaG4XeRvy1um63hvgj9TDZwWakLIMHgVxwI+80j85689FT2jTEsz8ScbLc4+xMdBFQGp
	gL39G70cK1bwxCFGPcSfxxlI4HCDOl+PpSlbOv5NzjUBXhod50TmaP0EnWfZe6Z9MKBA=
X-Gm-Gg: ASbGnculOG6nmtcH8nlmGP4YjlYgFPsQiEw63dFyOc1919OAy2pr5dByBggLeTzUj0b
	SP708Ol7VHyZKNW28dm4pbJk+tv+zJDJ3WFNeHpUdHukcwdjTfUzcg7L2g55+/dSxyS8d+dHHOj
	NMQqtf/TEggKRjcK9H/T9PLUTuJBlLqRnUudjZGncA4SejlXdgahrvGX+y31s+ip4MdKq7VsvPY
	NZYpTW3NhEzJTRPLa8uNxhw2BjPYkmXZqhCAhK4vKKuUaqFmT/Vn1s4nBJ1N/ahR/Nqg2DwCkGe
	2GzR9liDKoglplOO96nKfzFi6HA5/caBIswfkq+XAA4kWvW4YKum17dmfkkZi268iYkaHlF9D9j
	MPyKRk+b0dcFmRBm3hvd++w==
X-Received: by 2002:a05:620a:17a7:b0:812:81c6:266c with SMTP id af79cd13be357-8835420965cmr1951153785a.9.1760435930133;
        Tue, 14 Oct 2025 02:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7NHtM1Gsh82E8FOY9EtkI41PKGeex0f4/Fw4cwVtCr7GMZQ8YGlpxMTjOqOvo/5wbIBEfeA==
X-Received: by 2002:a05:620a:17a7:b0:812:81c6:266c with SMTP id af79cd13be357-8835420965cmr1951152485a.9.1760435929662;
        Tue, 14 Oct 2025 02:58:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c133feasm11078988a12.35.2025.10.14.02.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:58:49 -0700 (PDT)
Message-ID: <91113d48-a8ef-4a24-a73f-6d32ac271a00@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 11:58:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] arm64: dts: qcom: r0q: enable more peripherals
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251014044135.177210-1-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014044135.177210-1-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX7VbswA8IEhdk
 EEF481gWyxEBQYp2mwX7rZEpTTo5OQavQkOoLvr9rSEYry/JxlTNG9k1VOdiZlqD2dV/Qv7t6wf
 2MXSGmxZlsdCmqSMVneytS/x1DG22SgQ3JwIF+IMqnSkIN3KyasKno/u0An/xpWCLh4MZtOIzDE
 2KyRDlL9QdNiXIjG9V5mFOQsSOV3wMEW2ry/F4ix0WKkUBvQsXq41PmWR7V+Q8m/otkVcwEwgrh
 G9dJ6HBdWcMlZOkQefY/zEncAaq3GGxgdJAqMbjCZZ+1ZhNqWsAwYoS9ifcyJ6SdzJVZavWQMsr
 LQG1F4TaAyFybj4QHJ+G7dbe3PL6b9vvtPYjnqmun0D1a4CIVa2A+glwhp9OhYKCYTLb7eFwYKp
 GnGUBv7qmT4ZqJmEGTR9e7R8bAeznA==
X-Proofpoint-GUID: X7nyl7agva81xvcT_989al3DFxols-j7
X-Proofpoint-ORIG-GUID: X7nyl7agva81xvcT_989al3DFxols-j7
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ee1edb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=Ar6MW_cJkJo_tvb_ExEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

On 10/14/25 6:41 AM, Eric Gonçalves wrote:
> This patchset adds support for multiple devices found on the Galaxy S22,
> side buttons, touchscreen, max77705 charger/fuelgauge, RTC and UFS. It
> depends on "Input: add support for the STM FTS2BA61Y touchscreen" for
> TS to be enabled - and for the fuelgauge/charger to work,
> "mfd: max77705: support revision 0x2" is needed too.
> 
> Thanks!
> 
> Changes in v2:
> - split the gpio keys patch into 2 for small refactor
> - rename spi-gpio: spi-gpio@0 to spi8
> - use tabs instead of spaces on max77705 nodes
> - added new patch that fixes adsp_mem and video_mem memory regions
> I couldn't find the clock-frequency for i2c5 bus :(

You can boot downstram and run debugcc to dump the current state
(incl. rates) of all clocks

https://github.com/linux-msm/debugcc

Or /sys/kernel/debug/clk/gcc_name_of_the_clock/clk_rate

may also give you a good result, although YMMV

Konrad

