Return-Path: <linux-kernel+bounces-757848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80529B1C762
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B00179B28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551C28CF64;
	Wed,  6 Aug 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ITE5Y9ZX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668428C03B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489413; cv=none; b=JAhA46efipTuqceL9YRKYqsSv5Q0D9OcVbOBPBlV8vnKLWxLL+qO6/gfArRdgZQ5pvXIw+Ro2VAOpZbByndzvjFGDGPZojzT6ctX06rGSC2Gs+EiIA0fiwSbRMZvpOwfQQyrSEclJfIC+xfIrcugzzxqh51uz0osiPwL/9PPTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489413; c=relaxed/simple;
	bh=aUyjuZGcXY0dNHHGX8KYxpO6gAvcnqjyCMaMOwvMQ54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUsJi4y3oBzu57dQW4oGzFrO68rjbOyRD35fZi2ewq6HHZ0hiX2pWKUYl+bpCchcdV1AXEnfVfYMzbCAYQeMDP1W1bkWeoMyI7EMy26hEqFaKyDMyPL1mKbqTX6IMSc6DZHRpT2W/6SQqe62mqfkde850wN6imeJbUNcoj6bknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ITE5Y9ZX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5769enml032281
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 14:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ldco9VGV9/AxZ9ihFqepHt5ZP+skAMv8MaOKmwqgkMY=; b=ITE5Y9ZXXc/DJ76K
	3Rp5c0p0XYo+oAMvxIZY/+eSbFr+jtrMEtov+lLHTI5qhBOssoRTHcl1airMQ82R
	pIdDtsaljKPwe1ng7qLZah1sKjBcFXMfL22PzATs09vG4B+LEkvoRN1TrBSU8+Pd
	rZfnQI5auazkvN96ABL8lrOkdTpbFlle1IdvLt+TolHMIPG/5Pd3fAzEhcd3Ts/f
	KToCEYAb6pYslMzfwUzRzSZAP6DlGggazwy+5YEULtWchNxSq1oVPoFMMzrJBQ0x
	14f795WBQW//Q0PPWM28+I1+clbuUoajU8k3d4AWxGrA6rm0YaijfAC5Am18QH4T
	geKVoQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2u0ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 14:10:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bfab12672so7490817b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754489410; x=1755094210;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ldco9VGV9/AxZ9ihFqepHt5ZP+skAMv8MaOKmwqgkMY=;
        b=jUhx/ZF4BezF3iscvQUoiK/ATiaAwsxUlrn1QqCxQFeoutw2NjpdnBC3CLI+Anziah
         yw5O3+Ax3h5AYPpuxa5yv2f/6MduFO+Y/8L2YJ11jWyksnNyLBVUnKU8HdQ2LPhuuhrI
         NHJh0K8iTAlVsegPcYM7ESQM53j9f/VrXgwROXfX0ROGo1FcSeML1vuH49ZbO4+/GAdo
         sFLfjMqusmHaFeO27aPCtEqqlH813burB5P3qUETynwNDf5urCd9vWiiBv4y4F598zi2
         bnMIeswcJGKRULQsWp5WrnOrqHWfacBvL13cU8A03Knu1PPfVF+W5z4F+AlSJ6wDz0r9
         VAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlnu8TeTgc3Xj4IPeHn0ZCEONE6HbQu9HXRCs0XdAHXHBqrz+4g8neOEOfQwdZd6j0CgDYxTAf8tXP9UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMsto3YYdJpsfPxjif/wZby4gGStspodB972eQQxpbhkZWHDE
	zGwtELQY/qMmco5pSAKUqDwMnRtjYeSzXVd5m/frKXCbYkI+WemsEYFpbcTuLHjxO5zEhl84SPC
	oRdmWoPpaZ8CUlJoPSJxrzsqnvkJmQoGUD2lgWtOBxO7bCqFjNiWf04yMywc3+oHZUfY=
X-Gm-Gg: ASbGncuiQC0nxDkhliW6f7vwQyg2GhvMQ7yP5UtvQv0hjqHMs5RTKvlLs/wv/D21eSP
	w0TAHeuHz3qRgC/SJaWZrd4NkcxrGJ1BxNLFYZtZPbO5J3KL9DnwgvI6ObucGD1zx3alMwM/mrF
	eZQc74nBMhI29PjBexL+NYolEoe2oj7/HoQ3vpe8y4dP0A1mQv4KzrKfMvFBrpNMu6CkWAAsevE
	UXaZOhTic+5GSZWxhhBeGcv2o9EOrQVAo2MNAZyHuIGMVdhZ25XpvwSnV6dYOEu6iCq/84uY6eR
	wOoBXPZk5mQRcMMqgFIkV44j3j2Tq2mb9iBkKXDCQoh+iALfg4y6oORf+MsjZ9+SWV7exXj/xn3
	26HSYDONt2uUZiGpvtMI=
X-Received: by 2002:a05:6a00:1817:b0:76b:d8f7:d30b with SMTP id d2e1a72fcca58-76c2af7aa3cmr3017997b3a.10.1754489409748;
        Wed, 06 Aug 2025 07:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzNrhBL2zIZz8t0xkLTHT+9snFgYHpKK06KmLuKGgNauWXMLuf5Ab8TLJ1Q2uACzyQ4tSNSg==
X-Received: by 2002:a05:6a00:1817:b0:76b:d8f7:d30b with SMTP id d2e1a72fcca58-76c2af7aa3cmr3017955b3a.10.1754489409247;
        Wed, 06 Aug 2025 07:10:09 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd05dsm15434414b3a.81.2025.08.06.07.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:10:08 -0700 (PDT)
Message-ID: <81440d36-9729-4eb5-aa30-d94d0f85b7a1@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 07:10:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix 2 instances of Smatch
 warnings
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250804-ath12k-fix-smatch-warning-on-6g-vlp-v1-0-56f1e54152ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=68936243 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=BoDogKCtvrOBLCu30DUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 82dkHf0nMwSxqmcvfDcoLgDmsIoSuj-E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX37ojltjTFohb
 zMMWxECTxulTvZ1RFYmvnvhTJFfp6NdJjW3oS+KtAWIBbdXMmcoI1+JRpx5D1f6L6o7CHaKFvI2
 GR5LVNQObEOwovtILtrn9vQyyRlCowj/MwoVq82qxL2+r0DZUINAl5GUDj4jdeMQAsU3YrW2FdF
 lfhrgOi8fSPpa1CVA5DpE2GrTPPncPAw6t7HOX1Ns+iZOtHXs2DevmHpeaT2O2nhLfqgE+K6fEh
 z0vI5tATMih/4EW9w3bJV/ZrnW87xnvbq+kOtNXopPWpsUa4PP/5UsSwwRpZdaGmaBA9JG2ewG2
 gdIL6n9FT2nGHL0ntb823ckKsW72QFvvPyXDHDuK+NkwFzDSPGrOZ7Q05A59CJRtd2kQ8EheRVs
 Eswfq/0m
X-Proofpoint-GUID: 82dkHf0nMwSxqmcvfDcoLgDmsIoSuj-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On 8/3/2025 8:03 PM, Baochen Qiang wrote:
> Fix below two Smatch warnings:
> 
> 1#
> drivers/net/wireless/ath/ath12k/mac.c:10069
> ath12k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
> 
> 2#
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'local_non_psd->power' 5 <= 15
> drivers/net/wireless/ath/ath12k/mac.c:9812
> ath12k_mac_parse_tx_pwr_env() error: buffer overflow 'reg_non_psd->power' 5 <= 15
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (2):
>       wifi: ath12k: initialize eirp_power before use
>       wifi: ath12k: fix overflow warning on num_pwr_levels
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Since this is fixing smatch issues I plan on taking this through ath-current
instead of ath-next.

/jeff

