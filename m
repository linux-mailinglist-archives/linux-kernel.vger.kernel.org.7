Return-Path: <linux-kernel+bounces-873765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D53DC14A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A559B19C3EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF79A32E159;
	Tue, 28 Oct 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B4kv3vN2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393C32B982
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654886; cv=none; b=XdUnFNzHBGdZ2TYWJVM8EYvUuLkH7S2oVe0BAKqsD1jabkr7lZwYXUPvwmJ3WWCB/trUuCQY/rFdsclAujWGCw4amduuDbXe55XXwptRELefJmVwKbuckEjxxDnlEHLYdAMdvhfuccrkIaqrl81N15KNxVTv6xrvDb52DTRJWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654886; c=relaxed/simple;
	bh=KyBNCgzXGkyMfGBWB7EOwo8zzP48TIxps6ZrPhg/LD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPlfqS2nel17PHIDHMaGUCfcvM3Opo46tRrP1QjMbQH5e21t10wVROn6DWAJ8N6P4gdXn9hvwDWjeGclfWl1zTL/yD/d8+K+zXCcTjUCdihXlRm6AoijPq0CYw37kWSciMYbrWkZBJx9q90AB7KKMriYJ3vqEQBrkRyDwlTWJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B4kv3vN2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7HP5E3813040
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M95gJXcFdZpIJCFc0EnHtF25lf7trZtvDZHldkLO1f0=; b=B4kv3vN2EwmWINN9
	sZs9ldxIb139BIykET7LxTnr+S3DFN+TiahNLuZnetvaShrB+1nweAbWDRlmGUlh
	FFygzEccaAa6mpG+ifBID/vXi41nt1FV4iGloT16EP6X1ldhBeOF0EREEfA4RgzJ
	tlugQ2aqUlA5uMj7SvQ6Z1FyybpzDhQYUiGu4xfxOdmRTsJ0HS330u6a1u2rW4R+
	MGTRKeL6VR2ld2Qkk54922zb1swUTy5/O/pnpI2YWaR1CQZND4htsgqtr+Rfg8PO
	31Mv5OoQGpxwxZp7gIGNELqdtHGciBJAz2dNH73aROCPkvduq0bDIGaORAUeldwH
	2UgjzQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2g2ftd5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:34:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a2743995b2so9769553b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761654883; x=1762259683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M95gJXcFdZpIJCFc0EnHtF25lf7trZtvDZHldkLO1f0=;
        b=jwIwo4LWD5XqQpdIa3YDh0mqTFv0YrYHNjY4S6g6/TI0RUc3w5J2HV2l2YSr8oLVzg
         h0mSOJTaYjkr78pilLt/Y9+Iwwr8GkX4qYiVAYbPbeDUWBIzlHgF0RjHBgICQUhSLckv
         VMw+P5XN9Y3rkoKe+1jhNH9dQicdwkOBkY+UzQG3igWpTxE/88moFPr/t5b8D91iH8Tt
         YKYpX7wtPh6LXK2EjYrVfXW4tdmn+pjZiGXn+88oLQdu5+LbuLFkPZmk86ZTuurkGcJs
         VnbZl/oH99xxAtcb1b+y5KRd4UVgEUIR+8xj9oDhhXU4PYFjouDDO7lCiQh2CZvwgoyj
         3ujA==
X-Forwarded-Encrypted: i=1; AJvYcCVVYDfdiafllk6lSOtxDOYy0Xh4f+f2U4w8RXTcTLd9r/C9sjILeYI5LUCJbY9enisUYM+khpC01xRVCXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzcAcirT3yVETyZfGIy81RjVOEwUXNOQdG5D/vFr7AJ6TQUBJN
	YrLyuiCRwC2jfuispFY3n7K9UVIJZrtLjsv2kEntec7B2uL6sKFHLRa9duHOP7J4wwojmn6rjve
	7rDFrys8FijXbNmCHLLEhB7JE9bRbTmzwU8S87vcJl8U8gebX3tzsvQ1RwDcInEL7TwI=
X-Gm-Gg: ASbGnctdLCju0jUyK+8iwdNUKgOY40R9AREiguReDcNCsk+YARk+GAOxqqN5PTuD9lo
	eKANKeYpFyhOdf0XS4jpJrDrSlnr50nYU7QZTnBKGY9ZlyivVRxva5QgZ4zfBYZ9Ro8U4tpahZV
	DJZY9v4McJh3SEK6fWgSQBdIEaVBxyeL2sxrvCTLWJAfG7Yh2F3d2FpY7IPE/DFGgn1rE2DZ/O1
	EiRSkstWhL6LQ14N7xQoV/jhnGrutHqFaiP4UMyfOvF28nwKS99RWQWvYP8FdNIweSIeyxeurEh
	QiUt5KtqBOU+ABPHXt06PXX81mTQKjjjX9cx0nKfL63UWPlsNvudISLg2frbQ0d3Af119yQveJa
	/54uyGU+ZuVmDUsahnOAgT8H+55WlYbES
X-Received: by 2002:a05:6a00:14c4:b0:7a2:7833:8b5d with SMTP id d2e1a72fcca58-7a441c36fd9mr4823916b3a.17.1761654882461;
        Tue, 28 Oct 2025 05:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDZgEIJrt0gDk5O/GM4oOTTTrpxlFBa6bU7qOKpY2eoQVr68fPqZaq01zJuj3yQEKGsGh9lQ==
X-Received: by 2002:a05:6a00:14c4:b0:7a2:7833:8b5d with SMTP id d2e1a72fcca58-7a441c36fd9mr4823878b3a.17.1761654881999;
        Tue, 28 Oct 2025 05:34:41 -0700 (PDT)
Received: from [10.204.100.217] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a427684bddsm8298102b3a.31.2025.10.28.05.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:34:41 -0700 (PDT)
Message-ID: <bb39b556-dd70-ad95-3d29-1e2bf7f45380@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 18:04:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 6/6] media: iris: enable support for SC7280 platform
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
 <20251028-iris-sc7280-v6-6-48b1ea9169f6@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251028-iris-sc7280-v6-6-48b1ea9169f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEwNSBTYWx0ZWRfX6obLcNd3f9F9
 nPkQF77Ssfq9tuFU7f6VF/s5L77TGSqTNsIPFdL6EE1pe8ouIRWNpFAOt+xUGjfMYmTOhHxLmTC
 F2D58oshOla6zNuV3nBGuILZgo9TwAUxVvMnYMbGeJklWDg7uT73Z1rYiXq7dVP+KZd/+lcQ192
 cbxdfpriojVU4LTLfk5sD/4zI+X0XPuvRx2pWP3PPRcc7y7MxvDptKWAwwmmJYT62t63rw0EE7k
 O6YIFwrZXWe1bVxDtKVWXKkeltcLffs2t/rXVGEpxurS2hl7v9hTTe4ThOFS3gKOnLQIp/yDe/p
 x009HC5JfFf8gmVC/hR1FrdLC+yCAWTUG6YxuKe2vbZSbSw6lHBzQikzrY7YuHDL/TMEeT9NmG3
 kuH14HYL7R8zubCeGWxwAFuJ1UTz0g==
X-Proofpoint-ORIG-GUID: UJvODDvRpxoMnb0Pb_JtPEfIyMd4zlyl
X-Proofpoint-GUID: UJvODDvRpxoMnb0Pb_JtPEfIyMd4zlyl
X-Authority-Analysis: v=2.4 cv=FIMWBuos c=1 sm=1 tr=0 ts=6900b864 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fr3eplbp6RILtt3BeFwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280105


On 10/28/2025 5:16 PM, Dmitry Baryshkov wrote:
> As a part of migrating code from the old Venus driver to the new Iris
> one, add support for the SC7280 platform. It is very similar to SM8250,
> but it (currently) uses no reset controls (there is an optional
> GCC-generated reset, it will be added later) and no AON registers
> region. Extend the VPU ops to support optional clocks and skip the AON
> shutdown for this platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

