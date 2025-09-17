Return-Path: <linux-kernel+bounces-820920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF0B7FA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E69586F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1AB316193;
	Wed, 17 Sep 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qu1omjiP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AA316197
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117512; cv=none; b=NrZctgjcTXBbPnD5ugAe8eon/8KJtn02OWrkGvpOCvjJKKFrtmXfbVE9BVGsEO4uO+JA+n/nrYeBWd4oAyNErnxRyqF4B2Rh5u0CY5f327g6x4lnGc1F7WzA9i4wNwnsVN8UTrK8Du4pC/ZdrGX5TwlR+vpH2nFmIl9jb0X5Z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117512; c=relaxed/simple;
	bh=Bap29ptjcsZrGpm6RgpSfT7sjPHuC/ajbiIsZlpP9qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avMvtSzKRoWoHFW8DpD5utQpyd8Aw9s3BRiWQvDXQVVtsdkt34YJsA9JKt3Frg4s/VMWXJ7wTUqZPMcb+v8kcIAtV90fooOeeZvbllLcoudTfCgq4Wgf38ztdw54nbIoNG5/5+TObwxBljVIMeMXmCw+6b3UKYGBmQfFDeK8/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qu1omjiP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XkGX018318
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bap29ptjcsZrGpm6RgpSfT7sjPHuC/ajbiIsZlpP9qA=; b=Qu1omjiPBZMPK5BM
	2mIaADHfORtt8Ze1D5YDpMg1rFc1sxF2l7DUQQKzXNtyNtH6MokS9k7Xw9nrjIqt
	tWQ1sDJF/pX3kPA+DyqmS4yzz5PGKhoZqW5blyvHTJRrZQWqio+YoaKaj/vX2LOl
	ZvG8HpBF4aGVOd1z8LQlHkfnvGFmVkQ5EeblCw9i+EV9MQA2sNSU1fWJUqhM1K+z
	YQCk706dKfrI1lunxDa9YmV1AXIMKT7+tlhmbO4H+NkZKy1hxzwIR9kaAQ6loEiY
	CqAnbJsyQ4l6RhTVTppRwNI/X9UvppfqG75yiDG2APjg3AcB88suAMes3p7ZUufI
	MzBt7Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwajkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:58:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b79d4154c9so14500801cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117508; x=1758722308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bap29ptjcsZrGpm6RgpSfT7sjPHuC/ajbiIsZlpP9qA=;
        b=tL230IwI0EieJStahP/DRQqyPBacn48ypjFXaSxDRK3WzrC8mIFMLnu9elKuhRrL0b
         1A5f1USKSa+Wo1P2M6ViJYKsb9FnszG77ODO1P2m8j9tS/qfgs95EGsx54xYxz04Gygh
         63kaI36mhrb1HioNLfZ89qDncs/j24CwHtdV7d1mk2NgZExmJp12H5zO4twP84hBLPyB
         EUWEEA8S8VhODdhrx/hgIgwbCcIZ0hf5sDivMKVURPrGm1Ch4qWsnU2J1FXXdb1EOj4B
         853Pp6yNvyeBQaei1gxbC9t+AZaRitSEwISObDeSI9FUqmeDi2c6F6KCkuXxF6aDQhBb
         4kcA==
X-Forwarded-Encrypted: i=1; AJvYcCUBOvchMHzlBGzyedaxuJutHnZpd4dbMiFEBBfVCVDIPE5nkwvj1bRf4ITirx1j87wiEnj5n9XVvxRR40Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8KhCS/Agvlfeo5/qrq3kStgmNbLp3OHg4lCSDMmKwHdWDKUR
	XTH8kI46/AvrjI/mDoZ0W8Vdfl06oV7ivzZLtVGtR7E9qh4GBbC3vWH0AJ0RDyJR/x1mHd0HSyR
	mvPAZ7D+Q+JfGMrrSj97PNYO5lTm5ekmyZgEfKCHOXC/MPbXF/tmCnCD1Ys7ZAYe5oSPZNjupZq
	4=
X-Gm-Gg: ASbGncsxlwfBw/3r7VyT0DxM8jsKudaitknoNHW98wCtjxySDoBvHDzivNhF8fGkoPQ
	6/wMrkWodn1fKhR1vvEfb5AEMSNch1+D8I216+WMRoThZqzTlibTvI4DzwNQmt41e+EmvaFdW7x
	YigZdums2WPLmTfY5Jk3e/L/5Ye4imeSBr01K+0f6Cl1ZpRnWbsRkY2pS0gKi0MLbJT6Q5vH0lq
	NQAaANabRr5AMLbz1R/rfbJbAHH3u4ObwHCKrq8q+4R+YgODUQUSGdJpsfDlkitRuVRWRFSRTJ5
	7UjgCvPPMo4QLFusYYJRTFitHV8wseaTjNxsz5NfjRehdZFL8TvL9bPrdsLfaq5PKAvtff1mp/v
	GwfVMGXJ/uT20joEI6IwCPw==
X-Received: by 2002:ac8:57d2:0:b0:4b4:9d38:b93e with SMTP id d75a77b69052e-4ba67f63fcbmr15850351cf.4.1758117507657;
        Wed, 17 Sep 2025 06:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzl8qZRgKO760HE5SG604Jpiu8qKnn+9Xk5rimSB3ai8LQP+dMPXzzzD0y5Mr3IYRJFxpE3g==
X-Received: by 2002:ac8:57d2:0:b0:4b4:9d38:b93e with SMTP id d75a77b69052e-4ba67f63fcbmr15850081cf.4.1758117506982;
        Wed, 17 Sep 2025 06:58:26 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f9a7d8793sm308788a12.38.2025.09.17.06.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:58:26 -0700 (PDT)
Message-ID: <56d34704-aed2-4c61-b5ba-3cf3c91b2806@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:58:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] arm64: dts: qcom: sdm845-judyln-common: Remove
 framebuffer reserved-mem
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-12-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-12-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cabe85 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=lLqmTuED0iPNNbIZDJgA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX//JAQL4S0Ihg
 LvldbqSdc0Ky1rg9ILiAfFf6BCSDmdOVCVwvgOH5CqKogC8CSsDQhq4PXPO9yMxBAIIGGkFJ/ia
 9Y+mOafXwF1T9EFPKFWD9+4tQIij2aIXiFO+UyB68VX9bT0LnAO0kF6rhtpjnQP3wEj04i1RKpc
 tTI1ufl+/qFjXGpxjJ4Smu72kBbuNrdyptjkmm51myO6StXy9oNE/x/axSj4q9Ox9YxmRJk9aTU
 8Qb5jYAa6SPAyKEjbomn1uDZV0jUUgkvjvpcwJ0RYNPA/WtTAQ0yxLaGa+34MtBJJiCkacxDLA9
 euB73ctA24DdR8Z/qQYYwqUlaTXEbcCk3K4SczuMb1FQvsobrta4SuYSjny+aUqKaepmbXJHdyr
 VFZx/bSx
X-Proofpoint-GUID: nt9BA-J7vyWPLouEhwr78dvNDPf7UBot
X-Proofpoint-ORIG-GUID: nt9BA-J7vyWPLouEhwr78dvNDPf7UBot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> It causes a conflict with simple-framebuffer

Huh?

simple-framebuffer even takes a memory-region reference nowadays

Konrad

