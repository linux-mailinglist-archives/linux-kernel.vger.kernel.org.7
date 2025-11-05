Return-Path: <linux-kernel+bounces-885744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AAC33D11
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FD4189C599
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41F25C70D;
	Wed,  5 Nov 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESaHGw9t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Up8JH04v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E382566E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311430; cv=none; b=aZPQRsDSbGY+4wD6OyL9M+8HBu823fJGZek3+9ctYnjviPBTiUxnjXfnewGJvI6xNjoeUJINQwPWgXATvNghzThIz7uKmRWazULnBAjZG8d42JQ1slRFhUSfzrqnFUelW7hX0Lg1so1AvHstnWabeytFuFgGvjTMGgwDMmxd+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311430; c=relaxed/simple;
	bh=/xGLt1M8kqid+LM9NaX2QqSx9NUMXvIrQuDmRDm8RG4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f9+ZS5PoambfN4Ee9Y8ahgWwGOSUrbjtc6mvUuE3ef/fHNef70LIxsnEgVYS7OIOh9nvNG6o9AyW+29GsSCkWC9OFkC7+oYpytaK8XxIN+HG2/aUYem1Jp4MQb8VQ+e5yp83/k0zZ1JDMoSYROsgdlL1CyrhVn2I1wu9iEBBVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESaHGw9t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Up8JH04v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Kh6aa3044682
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 02:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Id0Enz3QtMwKYEBuECkWjlnGm5hIArkDcvoo96ONleE=; b=ESaHGw9tgpqQKC9T
	hkzvwioH4rQ0+QPyzXOTEoFQc7WStD3ljw99GW1+/MsdH8Rke6z0RysIqPh0G8GB
	/RqmXHcAW5j+IASLUa4Q8/EjkPZ+TP7gs/fVxuy4yYSAGkx3/r4b6KIjWPgiBnnS
	fyfDwJ8j3Nm7Mow06sg/AcHAynTL2nmb3+L4eF5zZGRBUH2hCepl6sDzLO/YOGa8
	GRiUsIUFZeycx6/C+5lg+vq1+zePMc3vT9DSnRWpErbSjfi7PKENhsvwYbpz6zSM
	Kbidsril2EdpEaIS+EUCxe5R1M3tS8Sdbh5Zyh35ZXZ3iRJnkT2dTNrxBNUxL7ll
	FOeoRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a78equxdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:57:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-294a938fa37so125422165ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 18:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762311426; x=1762916226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Id0Enz3QtMwKYEBuECkWjlnGm5hIArkDcvoo96ONleE=;
        b=Up8JH04vyydkI51ocr1zFJfA/kfleMULrla98Ay/a/FOFnH6gbIQjo24TTHVLEA7/j
         +wpQkygM57gaiiE7llxi9XkwLNnveJzn0MnhmVPeOcM13FU7jlrgwSQct+FaDAROmMYi
         p6PY77JN+rjdcuNc55JXiDeWQ3bEDJgjmjyTB1X1SpO4CX/hqT/pl3RmvLUZ9Be+FgqW
         6g9IKAMHCIvjyMkIcP0cetwSeUkFxvNkiuDfQMWRV3zbsJpGNC7V7P5hpLm7JH67pUl8
         jHM7kmNF6JWZVuhQpVbiQLOgjdeKjDHgcma659ub55i4RZs6FloDzvF2KDWqz76HGJcU
         oE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762311426; x=1762916226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Id0Enz3QtMwKYEBuECkWjlnGm5hIArkDcvoo96ONleE=;
        b=PwvPoC7UdMXuBtc3uXj4k5OgmRIog1pHCC4u2EJtPHibmvC86omAYwB/HYY9AS8dxZ
         AHUX/GasbzEEh6FZMeHHccM0TaDvwKjVDbFinr8AgRUZ8wSiYH3FHWJcwhkf4pOLZ7U6
         qjZjMPHCK/LgILETNUtqahMjjBbbLgr3pBrvE3lxA5hqVvpLxI+Tl/ZxVEeebEWowLWQ
         nvtKiydalOrvNf7NsPkkJDGtjI/gM+CZfXQLI8mhb7NjUUyF1sUXGtxgLNOPXXpYnMTt
         bD06kCHxDt7/7FlRLHPH8zYniV1cNkzJ9Op8PWzfpy66EaNHp4zSkWAQDK1c2rLBpmsn
         sjdg==
X-Forwarded-Encrypted: i=1; AJvYcCW7mjttCNSmZOW3cg0Ijds5tfXkHHN8a2eHyRm0w3liQZ4FN/u852pXMu0cGSBuMs2exhtCGR0kKrW7O5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSJewQ5KebFaFMUgTS1x9wR08wwijcb5TsZBbOMhiR5BLsfi6
	yvOajqOulem9QVm7TC3z5LQYGBUipZuOvS0ff5BnBnkhwFp/i+PeD/3ODkVEcOv/zMTe6vfjlU+
	HPsfBzySjd1pKMo4N7QtyTG54BHggZetcxkUYDzScKyTLK7EJ73gW8OCiqueIWuukC5Y=
X-Gm-Gg: ASbGnctpBxCUjtapXLMm9IGVacPdj3LDlsIht03V9ClHoU7hWLvLqwJPO5yfxXi973w
	Rctx2dvNNPbTlfXp8Dl40EiBKufZN/n4kTQp6mCZDU81j7XdivpPnUyGQ3oD+2iVuRFPvqN0gbX
	L/OGcdk1JtzBNsx2Sp7fythe+nL7FZlMe9Izs9i5zGROlU2LFotFtV8ww8ZCjKi36rzxsHLrXq+
	59m9GMdzzq1knXmmXZWr1IZ3Xfs+mbfJlgCZjYwG6SNmF5rhpxzJ0eir7NtLN/USfbiBq2gQ0WP
	JT3y4+FfceX5mnP6T2Znx/XqDFJkJdsYzPS5D95dy4zrPUKpS1UMWP2zld3nmK5Bdg/qtAnH62s
	uHkftITKwpAFgJYpeI6OeoMFNR6bC8nVQND9wBPXksRvyb8tNsdfh2SCDITOosMzzfxiwHA==
X-Received: by 2002:a17:903:15cf:b0:288:e46d:b32b with SMTP id d9443c01a7336-2962ad1ef65mr22622075ad.17.1762311425606;
        Tue, 04 Nov 2025 18:57:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmn8PlqOZibBgWAikhbFKXMfNC3CBi1fZULnHntTnSKn2o8RRQsfXr3d5z9bpodnixlYrrcA==
X-Received: by 2002:a17:903:15cf:b0:288:e46d:b32b with SMTP id d9443c01a7336-2962ad1ef65mr22621835ad.17.1762311425118;
        Tue, 04 Nov 2025 18:57:05 -0800 (PST)
Received: from [10.249.21.117] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a381edsm43541075ad.71.2025.11.04.18.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:57:04 -0800 (PST)
Message-ID: <e924f9f9-88b3-4c0f-a326-80cd80abc765@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:57:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wangao.wang@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
Subject: Re: [PATCH v3 1/5] media: qcom: iris: Improve format alignment for
 encoder
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com>
 <k3umzf0z69-Hbh7jbT-Gjp4pyquNAYVC3VfIXQcdVZstI5FTtcGU_NEgb8l796Z3Cr6Dz0DQ0BoVQQPd4fr6sQ==@protonmail.internalid>
 <20251104-iris_encoder_enhancements-v3-1-63b0c431b4d0@oss.qualcomm.com>
 <0735f540-8085-440c-9c0f-7ac23b52b838@kernel.org>
Content-Language: en-US
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <0735f540-8085-440c-9c0f-7ac23b52b838@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxOCBTYWx0ZWRfX14Xa61wWS1wa
 yMXyiAKL/PPu5nBwfk3gon0QJtNQWg0ZkQaQkjxOs43x2xzIZWTXpxssGE4kYsSBxyKh1+toqy6
 T9gRX3zJBDWgFG5tYgxHkO+MfmJAzAl4fTTpM0lA9SoXNr+JpW+KEVdbkI+I77ObYE7h4I9Hcs+
 OrKdtk3pnadja3wIznmV1m5ZM1z1DORJcR6MglVo6V01b8r1px2SRX2jtGxkCAYYax1r+DcmZDU
 uknl0l8Yd5xsdWgqSoSuUstNPX6HraS5Nxs0VVAvL1Yy986BI1DWduGMcdBI3GRceYN5RkrGM5d
 kcQmth2b1dy39EBy9Bh7utlWY7vGm4LuiuT6FESdjDMiBRC57VN0zoRnlqV6aa5KLr/TeTcAlZt
 35trOwwI7Yisnx0Z2/T7K51YO/Jxog==
X-Authority-Analysis: v=2.4 cv=fofRpV4f c=1 sm=1 tr=0 ts=690abd02 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ozsb_Tqo4S_mXzr4DdMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 7A4vxOiSoR1jlQNKprVtn5-Xzrwq-_KH
X-Proofpoint-GUID: 7A4vxOiSoR1jlQNKprVtn5-Xzrwq-_KH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050018

On 2025/11/4 18:39, Bryan O'Donoghue wrote:
> 
> To me reading this patch you seem to have three or four different 
> alignment changed bunched into one.
> 
> I would prefer to see more granular and specific patches for each change.
> 
> Please break this up into more bite size chunks.
> 
> ---
> bod

Yes, this patch does two things: first, it uses the actual YUV 
resolution for raw resolution instead of the aligned one; second, it 
improves the handling of crop_offset.

I will split it into two patches in v4.

-- 
Best Regards,
Wangao


