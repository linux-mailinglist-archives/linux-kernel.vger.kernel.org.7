Return-Path: <linux-kernel+bounces-846515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3633BC837F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21462189072A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450AA2D876A;
	Thu,  9 Oct 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4WQfNsp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A292D77FF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001021; cv=none; b=ceqtOpF+0FPt9IT5ikgu4SaioJM3kM2ru0peR0fnHAyCVYKJKfMtXUBWI/HgQHrywd803aftNLYRyoSKdeCDcN2VHsltSpadobhiqvMAuszY+duTug1t5RUhTRK+/Q2g19V3XZ1m0TtBIT5eJ2zGaIm4+kMaljol/aDusZx3k04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001021; c=relaxed/simple;
	bh=1gLto9BCDROKFQE4dD3C8sxYVc2P8E3H62tB0Tiz5aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oa8sUJM/9ygecndgi5I5wRRnqKGRRMYpO0pBGfHAsEYcrsjwK/UU9HRCX4CQ5512ZaRIx7VCA82bOMxz697Bg2dzE758yVJDUW9VFar+J1xl2XoLdoFSsTGlkoMNelF1G57bn99VSHg1XzgRzi1a2XY9m1AVOZR2p21PXavDKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X4WQfNsp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996ELTR019212
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 09:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1gLto9BCDROKFQE4dD3C8sxYVc2P8E3H62tB0Tiz5aY=; b=X4WQfNspdGcNJbZr
	DSXD7I7PL3YF1t3vwZYpAGpfgw+Mu1lbIA7nVDCrIFIm1E4oZLZ+1Iz4gfCl6qwR
	+XQQ2B+EuWj3+o4fEwHRRPKu3D5zusxKR8IeO3tyCmtcXBqKKNK4gWlxi1hNM5dl
	kD5fI0QVZxVlTpS6c8Oog0RfYtCkyqwImFsxGlnDBWumvZLtuPVJS4SItj1n//qL
	2ShnL2sun68DlebdMrRZLQw76EnwyaIhpKMdaVT5kQEeSfJpvJ2A26uEDxxi9iKp
	NMBmzzkvbl3d85tcfXYgNPsvk3nf6hOZrSqwgZ7ue+MConDu1ULj1wLbk8J0QUle
	RP9v5A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nt5m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:10:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85bb4e88394so23183685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760001018; x=1760605818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gLto9BCDROKFQE4dD3C8sxYVc2P8E3H62tB0Tiz5aY=;
        b=st+Fj9TfgL6VMFrV3UBYgMuj7Gsl55znbNEI+jAdM/5L3aqNbUxrOWUNCeiG9YLnGh
         DoBtCGW3NtfbI0kxAIHZAMFc8r0J9SW7yFLkg/SFkL36IrgYSSh96ynVI3uw8yAx3W9r
         5C7NWKlvvUj20ysIn4OKFLPaZ5P0jTgPz9RG2h5PXwBJvD/5xaMhbkhhHEb/4VOEcjEv
         Uyeho1Src1Tjaf8lAcTCNIK6H9cR55dWAvoqa1Lwq3zkIVEdvTbLPMzFbGOMAOaOvWRb
         E4BMiDsttiN4TW45qhWhwnuTDQc2aRF3RAXxDcJrA/wwYMT9v87QsKl/5Cq+TJ2DNRjD
         w4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU51K4+RwJhUiklE6F34zB5dUOqoCmJxfzjzesRFRjicmG39fmSaWxX8oNmiGxZ4KXxQXfiLTn3IrO6OVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eQgM74wX/n/aIDyDWQPlYfGLiZKyUXGsQKh/5kC5/MjOaTp+
	u3BSQDMyUGxHByw5PaJSrmFaN74AEt8DZAoi3imTwwBYgFYtauQFb9mGwY49v4lXr6dGHlSXGR2
	YJMqN1pR8wrqKIIFwLDxM7R/g6r2PlCSsS1ILT8+5AYxU+oWNAuft0ICgXH7fq7mGOg0=
X-Gm-Gg: ASbGncuVinc4X58CCcRMXrw+6GtuvQd8oXGIJs5UtPpIG8k/EgtE5wK7l58JCD0sME2
	Duz/kI9QnJv5dIVNAdtBtlcx4H8dd5RXREFLdcU4uLfcFN+9oMEuX0xqAGtBk8NeKOpZk3Cd4r1
	Zci1wELD6mtB/2qA2Lq1DbpQc0eeCoCy3UZHRtiPK8DwBnqu+cIQmQU8bRrmuXXr+scUhNT5qel
	KW+DwT8F3dOnc1ku2U46eIqSLIza9klAMpviDivZiHLo9g93iKCyJ4XH7im7QxglF1pJviXeK81
	QLMSqASMJk3gVttVIKljsxx/Xd1MNeZkYJUb1mlv6gZKrm9OM7a9tdvod0y/Eve5vF8fclhkA4Q
	Ya2YWKAOQlRp270crHzeUmJ2qlX0=
X-Received: by 2002:a05:620a:7104:b0:835:e76b:ba25 with SMTP id af79cd13be357-88353e1a4e2mr585136585a.9.1760001018084;
        Thu, 09 Oct 2025 02:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6MZb6QOnbhBTE/91nRDArgRgqRLTEI+IVWFn1NxgCnvCATzVRomE0Pl/cQ96//aeLXvp+jA==
X-Received: by 2002:a05:620a:7104:b0:835:e76b:ba25 with SMTP id af79cd13be357-88353e1a4e2mr585131285a.9.1760001017473;
        Thu, 09 Oct 2025 02:10:17 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4c83adec08sm1153029466b.56.2025.10.09.02.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:10:16 -0700 (PDT)
Message-ID: <597ae997-37a4-447b-967c-8fd362098265@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 11:10:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add eDP reference clock voting support
To: Ritesh Kumar <quic_riteshk@quicinc.com>, robin.clark@oss.qualcomm.com,
        lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mahap@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, mani@kernel.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        vkoul@kernel.org, kishon@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, quic_vproddut@quicinc.com
References: <20251009071127.26026-1-quic_riteshk@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009071127.26026-1-quic_riteshk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1bCxYV52ob339roh8F3nG9XmGC6AP9AN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4j+jArscxEPT
 KfRs1R3AR+1TDLORB83yNZkcYOPFOc2YSBvaw/GSxcmS2jcmbzbx0LifOwYvwzauuga2CAMANSa
 Te2O+JAVZZXEmyzJ3Lz/vMGGGsiakmDTj7IxPvpCRvRXygtmC2gIa2rvDNrF5NTka5ZW1i3pUsu
 HiFRi8IC4jgPCPdj6dw9q1zXUV7gDN1Jdkw8L91IqhpFmJTE982A/NlUBlN7e3CknpFCx+ot4gn
 f73X3RHVFDxUaEOKmWbwVROdtEVl9okmkj8p+/Q+ms69H/FtdCJsLb2gwSzW8J6ieyiCquItYXx
 ip3HJQw3u6DXZrVFyqGh6cc8tQAV49kpO9K3zNObgpoPxb0gEiidUZ6Ti1ZQptZkyzMk/VCAlxh
 kxIH4Mk3/d+wygte7wqfNxX7b0CxvQ==
X-Proofpoint-GUID: 1bCxYV52ob339roh8F3nG9XmGC6AP9AN
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e77bfa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=rf8yBW790zp7CXIHNmUA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 9:11 AM, Ritesh Kumar wrote:
> eDP reference clock is required to be enabled before eDP PHY
> initialization. On lemans chipset it is being voted from
> qmp ufs phy driver.

?????????????????????????????????????????????????????????

Konrad

