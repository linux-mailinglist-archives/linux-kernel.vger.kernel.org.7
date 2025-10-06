Return-Path: <linux-kernel+bounces-842739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B61DBBD6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37EC94E9942
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B71D264F81;
	Mon,  6 Oct 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OP8VYXp1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B328262FE9
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742729; cv=none; b=itomBHsRPQ5k7UHvtZd9WgiuUnPPV9MHeIdx7mHI4N1vNr9AqrGMgwFcU4uacO4qtigBHUa4u43/4ctHeVCH56YsL5IRJweDhYOOKUmBSxhZSB912LgLf2xUUpmWq1dpnmS/7NOPHJEPodZCcsXIClgR87cGJncRemYwtekwoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742729; c=relaxed/simple;
	bh=Edw6e0og8KO+pLnhJlzP7tQrwfS/fTioEQtVFejS+5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6EjjWMM4IpVyNq3+zTHzV+TmynD+HzPlhTXuYL1u66BEcTDowMa6cQhPonu5vmvJagFrDItXtBrNDLbSv35QcPdNGxAPldDmBkWD1dQEylCJ4/uO27I2eXqpkNjts3BVPRTX2YooypZzGvgK0ipGydUSAh1JOk1vdd5Rr8oaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OP8VYXp1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5961EIlr028800
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 09:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPnKDCAknnlQ5K1Y7MBqxGeVWc0/KKrFnvmpGWEd/iE=; b=OP8VYXp1NPHQZ1DC
	PZwp1qm8s20FDro5w/TnwQ6vniSCPH1P1DeqqkSveXDbexOPAHUnEFxByrU1F+qL
	VFsInYZ4ZXn9ARWgs9bCB4/o9A78k9jNzDliUyoAhBl+4wVusNHD/R4bNjbqmp2O
	Z8jsHX/SvhbfBX3hZkJ+zndpwEfCFhrVi7ldLJz7RgQRqOYHtymYe8fja64allX2
	0WXsZO1S9HRy1RvJ0HTqfWLDdaOmK3IVchBYc75kSW0CS6SN3sVzauuNrilh1lC+
	C9w3hwv945uGMvLrJqPXXAIbUFHz1cZiFfG4kSzdkbeES1UNycF+aB6Z/slejDo3
	dAQNPg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ju5xbey3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:25:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85e23ce41bdso97786085a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742725; x=1760347525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPnKDCAknnlQ5K1Y7MBqxGeVWc0/KKrFnvmpGWEd/iE=;
        b=dZES8InYB+HLgqiyrMSi/8U84URTsqMaROABzw1t9HiMTSCnEdiW47R378LPPgK1f/
         ef0WIvO4eGiq2w8GaZ58Jce1aLRVqAC+Oym2I6GosqMVDNEs4hYCZPK3Jbpi8fz32ILm
         pE0h9d9ayvnVQTLiIyFLdpcARzUQBmDs0JZnsOmG/gAGEj1mhmFBDqFQd4E4SDl5aVOp
         UAWgQBCwTL2i4d9NfQDmHWfQx9v6mJ50uN8sSEgFiVjxov4DgIUq5QTummrWt3fSEmUq
         nH0e5CmIFeYohwzdKltOtdCi8dwY5kPLQyanWbdSU68dcaLQ/DSZmaftsvmfYrfg8bXK
         2Scg==
X-Forwarded-Encrypted: i=1; AJvYcCUx2hgwCqmq+nmLgBIPojJereMEI8CgeHqmn+QTo/W7ZNXD+e1/QtiJMyYsr8i9/htsPoNDBldTM+HPN1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgFZ+90tTz+Tx85y+ig8xKSB8IIf2nrB/55UQFaCiyDH7JwHR
	OJ681W5vtRwzNnPTPqzUVBeQ04A8xnYjLjwEUYwUEkiKhCJ6a1VyGid6p2vhUtnTuCzh7RNDcBG
	Uylv5qFO/TuZN6WifJBd4uNJIhkcFzeqAy4pTtzgCb66PS6dGesaSveZ6RdZWzfU/9vw=
X-Gm-Gg: ASbGnctem7GmRzxYGe96FN2w9xHDxoXDAIXvOGYe9Sab41NXL0lQlnbQHNceHzPyeA1
	W3m9DWFRHTxV0Lk0tCLP+IBZyUzbOyUUZNhZV0bcG3XPVgH4rlfUuQeAQvHjYEyTnN9lftPjeUX
	b0nMlUgjJs7lMYnTRxoOt97tAEIzpLc5nq+HII7xhyio/yyJU7VuIPAK+LQx9FJ9zsFKu4Ydkqm
	kNpYGy02rBsn6lZICfEH0BSycmbk3nDEGnmMe6Kq1Fd6Z90Hsg45yUqT/KnzhnLgJWwUsQzrMe1
	1f4Zmon0CtN9eVvVMGBgtmcS+sswoVZL/unhnv/xEHIMPELTapvpJYNFS7BzrC3iZ5VJSyCl5k7
	cF5MMzgV4SWTcpnlMOQrSJLAhsJI=
X-Received: by 2002:a05:620a:2808:b0:878:7b3e:7bbf with SMTP id af79cd13be357-87a35ce66c1mr1023296685a.3.1759742725314;
        Mon, 06 Oct 2025 02:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvRfoZ03L6zTgPa9LKXYBO9blV6+FdfAe7dQyAmQoPVuIdAmyD2DdczNNxPH7bp8ruibwQLA==
X-Received: by 2002:a05:620a:2808:b0:878:7b3e:7bbf with SMTP id af79cd13be357-87a35ce66c1mr1023293885a.3.1759742724700;
        Mon, 06 Oct 2025 02:25:24 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b422sm1113154466b.54.2025.10.06.02.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:25:24 -0700 (PDT)
Message-ID: <fde00935-6475-470d-bfde-4341d15c8441@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:25:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] interconnect: qcom: msm8996: add missing link to
 SLAVE_USB_HS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana
 <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-1-a36a05d1f869@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-1-a36a05d1f869@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=68e38b06 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=WPDsOxgxYxYm0iCLz50A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 1AtVY-7_IUYJEeG7wdTKYEMD1XRPIUir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX+Onyf4eFinbp
 IgqLWmPZ3v6WJrLIzR/zT0N/jR7iobNd3cdo7qfLl2mIvo9zF0aObRQC2KoRA3uuPrbrTbqHWQ/
 J4Ri7AAnctT3QHY8C4iOXiFHgls5B255Vetwgou0G0qb6jabJ8xKjht6KbtL0mHimwQeYXiPL05
 kFGr65spG7L261+E6fxDjFxo/zjwcTCnN8RMDjm11+WjEQJ2vKIG87MBCjMtVYTXEOUAgNJHckc
 zUlbZxy6SeRHaoXfPP2BEzVflYAyJuuxx6sSwMdr24g3aHNolGRhQ7NwGZWZXv0u+XerL3QSjCS
 kY0jhRPrCnPGFc5uoSaxbbCzyQOc3QK3Ucn8oXfW0oGl5oPOOxuloWy9vlYDC8nQf0CiocoGeqp
 c+yzMxx5nQLY2P7Ho0+VPYb6VWljEQ==
X-Proofpoint-GUID: 1AtVY-7_IUYJEeG7wdTKYEMD1XRPIUir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> From the initial submission the interconnect driver missed the link from
> SNOC_PNOC to the USB 2 configuration space. Add missing link in order to
> let the platform configure and utilize this path.
> 
> Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


