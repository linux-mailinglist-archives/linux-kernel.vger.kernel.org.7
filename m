Return-Path: <linux-kernel+bounces-762366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F3B20593
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C889717FA45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549227702A;
	Mon, 11 Aug 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pc1LXYLl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF77275AF9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908438; cv=none; b=M5D3zp77zuhsAErfuPgjwg2mKiQ7mgwvlqFwP1kf2XlcdYN5JPaTIZkAbcAcZegvxnYmYpX6ydKaDJBPJ/eNhQR2zYg06cJ/yoDXwyeudzu8ksE7ra6CmJlbvUiKjtalfxdiCwpnD/rmuqhNycR2HgQnW+Y0BRME9xtw4X9iknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908438; c=relaxed/simple;
	bh=n6bYWBbuvYgd7Of4AkNGNr2HVdrMAtKaVoR0TN1D2LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJjiX9vwL6hqlvuw59LSnI72WPNb1kssR/J1LXy5pwOAupVfhV8SHb5yfOPbYoDFJXmeoq/VgpSkh3Ekw62HS1HRD0ysmCIBmu3LWtqX2uAv5RyCiTflKfh0h3cU22U4P/kVhkLQOlajZMAVTFmP03tzGeh6T0KHE9ZN4ag0948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pc1LXYLl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dAaw000658
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=; b=pc1LXYLl7ATW5RR/
	kv8JpWpVMMWw6zDJPpFQHQ7cxCdNIoJw23Y6C7KZquAnSB8OpJRQyTNuUJmSS2P8
	OshHPidOWm4CVWrVdmth4VW0r4vZPE55OsDDgssvmsUTt/BdbJ31BFlZgtSgKw6u
	E5FvUgMV20hUv8uySTQi+0+JWH6RpvQtQ7NoBGZErnvXEUYUFo47K2YZFiQxtGKy
	O8OpMdA7wDrjvoHYcdH2V/PTSigHqq6CGLD6XUhkV1u1O6BR68MvKKcxgpf5IP4F
	W1/hcINTOUS+nKozwZdV4icJmqr/nJyWezckGN2Zs8kVO1JGkW/50a5rEpNKXsX8
	CvANDw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dym9kyjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e802190d0dso121462185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908435; x=1755513235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=;
        b=iSorY02wjVzIQ6odUTylrEowuZeAZ902MXM4LHgSGSNGop5X5YwklD+o/Zr/inmYN1
         hD/Wg+GuFpbJ/9yPWhrDz9a+WNR6viaLnAQcSUS2aU5c+cIQneTlzVB1Gn04DMpy2w8v
         MtdKGsn21vCMSUrA6pzeXRNWyDV1OwgayHtQtD2erBMkteM7TIxAsDapvs/vqq/SrH+P
         rLVAMDo04Pk2/cViHmetPm9zMhnAOQ9rzUdfi1ASjVb/lVccMd/X5MlXA5P3y7X9dHJP
         u2T6bAXhE/5ndcjEgGImlRlhDBtPEKM2b4Oqqe2ZVdvjjBHdDOLxZM0lO/9fHpRT8QzV
         IdPA==
X-Forwarded-Encrypted: i=1; AJvYcCVj4CsEItlxGcz1/lgAXi/ngoj+gGhOnnK9cm4hHvQAD0VS79b+/qPnvi3dKN12G/LDZxa3EDWSMFDeVIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2af5FojeenHiC9dwZuAf7ifLFPhljJQnMJ0nwUnRyVdmxcUIN
	+IU4XHerKSN/JXJ6LNC9+ag45j3T+Q+nlzBG3Q78BcRVNFpLSqTYqebLpV68aboG+39Ewhu7AuT
	66d6V5tNgm4TkXlJVHCuOubrD+eSNATGN88JP+2SWhD8qOMMtOUGU+2w/6GhiV6oFr60=
X-Gm-Gg: ASbGncu82t2TZ3Ofsfxjjxy4+U9kn3u0W5yOXbC/Wc3bosQeMwep9J2aqaOKyiObst/
	+rC9tSVlqF1TLvIBUWe5+44ARCcVnEu55kDgR4IlKLTggTQz6PaaSy34NODNKSzzKU8aIqTx+qn
	axUuvErqqDL5WzaD7bcwE8r+CeZO6w7vG7SkSUsvLNjZqEyZJOVTqMahx2HqTuVzfhQ5jVnNxR4
	dRiljN9BryiJF+8RVuDYKd94kntIvS3YGqLXBYylsLK19wFBc5Q90MveQrNYt3hSrSN8syRZPuj
	A+q2FCtdK4I3kC4bdxTQW5m5OQ+gqVh7gcndfavcc6SGhCX/qDOfgXJ0a2nlbgw0lbYUSi3MD3C
	T/0VpMBX698UQWsP/Rg==
X-Received: by 2002:a05:620a:29c9:b0:7e6:9e1a:19 with SMTP id af79cd13be357-7e83b93732bmr541386485a.13.1754908435006;
        Mon, 11 Aug 2025 03:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbXlR521bZxyPm/3VZyKzhpc/wr/UGlYqSFDZBHoNqcD9JWEIFdYtyNL9kNg45d9xLhLh1XQ==
X-Received: by 2002:a05:620a:29c9:b0:7e6:9e1a:19 with SMTP id af79cd13be357-7e83b93732bmr541385685a.13.1754908434580;
        Mon, 11 Aug 2025 03:33:54 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff60esm18546387a12.13.2025.08.11.03.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:33:53 -0700 (PDT)
Message-ID: <09144409-48ea-4b74-aac1-32000424a46b@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:33:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/msm/dsi_phy_7nm: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-5-0fd1f7979c83@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-5-0fd1f7979c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1_kEIgswSD9V7z-_FWVh4c6SvN-abmJW
X-Proofpoint-ORIG-GUID: 1_kEIgswSD9V7z-_FWVh4c6SvN-abmJW
X-Authority-Analysis: v=2.4 cv=YZ+95xRf c=1 sm=1 tr=0 ts=6899c714 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=aS93HcZ8ji4XsMPHnqgA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNiBTYWx0ZWRfX3eLowGJwmWxI
 uVorJr8f0HUPajJXg00rgIFelfaebtQyhrYmwdPBnzafCkznpVAlyRZkRiq0ZmJXvWDzlxs+qNM
 aSGdOnEnW4XhxjMAIjxs7tsjXzL9jIHVLzDvN6BaXNu+D2Vh0wqKs5eziw9n8oOEuJpcu9WHLzh
 AdPIAdIDgAOjf4VQMsHEmMnYOtlYO+1owI94WeXZAJEoX2VJUCQbqx24zOawDIDYplrCHZ6hZC8
 6GS9q8VB+UFVqi7H2sHUw5MB5bK8qJwuHGJ1oXuEUOfe1wZ3Bq/nDqYVvVYzs4toWcL1kEtsIlI
 rMSOPMSRkMG8fOJWGXApyM2nZMveBVMdlCqcv61NTYa2EZouysFkDlakS8SzQu1QlWQ+QalRtut
 FNkdf12C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090036

On 8/11/25 12:57 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

