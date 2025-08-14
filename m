Return-Path: <linux-kernel+bounces-768384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F106B26099
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489013A2F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733762F1FCF;
	Thu, 14 Aug 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="InC+QDjJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB32E7659
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162648; cv=none; b=msqNDE3YXlQOd758f5ttt/hvHNXrgF3brqJdzuKM4gykyltu4zXMQb/3hE/u/DsRoWYhkn4VoxRFcwdqFVDt3jISdXwRTul8jnEqEZ6HL/r/JSiNFrYiijTQMwmALiyzXSEc3nrn2+w7Y+hf4E5mdb9NKFSbo8s+uokTy2z7Rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162648; c=relaxed/simple;
	bh=tAda8lFFp65pOgTZMvtNSBa945TWBHuTFcLf76W4S4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTm6iwIdmnJ20wNZl3BI1qMWxE7FjS9oLcZBIe3VbkO3vOmbfMqaMpDPNnHPKBSq3Urc0CNsFqclYjaKeKMgGZVfni484jEsyos7mhxjEleEipubL2I+kdS9k2t9K3Tsji15my53JBJ7U/WUvegy1n0vqPkUU25gUJF6ExaAkqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=InC+QDjJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8ohXY020590
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t+CK8QBatZxbpeMJRWD+G2VTJdLA1+wNankRYjHTL/I=; b=InC+QDjJwbq+Uy/4
	UEqPy0MgK7Cjtba+GEAfNXm2UHs8WsqsqFBVRuHFCp6OXdtx97zPfLMygvGH11aP
	Hgh28fm0zus87L22fzYY2r+mwmFHbazdcmNKD93LgQGzZ4k/+eaJQsO4JZB2aNpt
	VQykQTySf8sfy4F+ZwBdC2ekeFP9fEJAAcMLzw8FLfUW6CeOqZzSRQVXVp7Mz+ES
	TU+KW83IsJXBKV8y7f96fY2k18yd0oyNMfcoT5VT1D+fA1+mDWVVjEHkh9nnG2j9
	LrQgkL4FWx3LKfTzDzeYGngigfLomrmSXNEqCuBuxJ/Zf71T5t+/gU2K/8M700MN
	stUbNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmf26g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:10:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e87031ebf0so19760185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162645; x=1755767445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+CK8QBatZxbpeMJRWD+G2VTJdLA1+wNankRYjHTL/I=;
        b=AKVVFpZ3oQQ0qxU1oBlMArHOz6SmQy7EGX9cra+EPNIT4KmYzGl6lnqbfaQByTY9LK
         mNGv66td9BgPoq59zjj+8q35XaoAxw+HAMYdVy6y5KpsLI6faE6ZkPs9X2t6+hinNIlC
         Sw1QS5MHWZUMJXqIornxydxPcW4/gG9vdtYG5fE+LehSMFqi+z5o9m9E5RThns4POSmI
         JGnmO2tFihFfkeaX3q0Y2KHMnEGs5nPaTCS1kAYJU8WQ2dm+PMbJ9G/cvALtB1adeBlq
         W3NZ46t1bDR89XyTlZrR74xnET7nKqqIfJFPtlLWYpiUp0kwNyelmRpZmR+gJmVZ3Eh1
         XOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzexE02AnkXHUdZ8m+Tw1RXuzuo4yZOLuwm4sWoTUSXAMZyoKlHzcQd7+Z7oQUK5CinbBr7p8WswA5O14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYq1gEVE1/h62If3SOGLOn5eNxdTZ7dIjreMRJZz6STPrnfyJ
	0cg05XfFHkE3OdrYcAKDZgpo5fJXoraB9WKLSfZMc/28dpwJPEFFqGz3B3YlqbWzhenQZvtDbXO
	vz3mfJx7VEgRRM/y6HcXVHr3azV0N13N6OA6Ei3Zwn8HwmJ781PaQbBJgkR/HOGx2PWk=
X-Gm-Gg: ASbGncvL4q51ZXQyTS6KENI8UzCOTucuwmSAFPV/aN1oRga6A2Y4qoPt/biex4Me4TO
	VESbCbFIyudm/klMGLOqFHzR3wtWs0gXVIpohoswR0Lg9lPXyn/rcIF7NNyNP8In0+oPU8Zdv9I
	sEP3Wu41WpESfRgTyT/fEstr7DKggFB7+jyU2nb9a6BBHvJHF6txXeUONOvfV3iT+BCTs+mCpxq
	bjOM/siqTLVtchIMF3iN72Cu5SIOlWVC28ASHIDNnvhnA8GJg24tU6DWnpRHGmCRpSQH5QqQfHE
	wJ3jy+CMFQRrDvJNMzKSiaAsVH2mVWWC37uoTumRe8u5jWtOFkzozE+91tjLGdteneHW0CxinrG
	TOlXuQExAE2XAM9uBOw==
X-Received: by 2002:a05:620a:17a7:b0:7e6:3c4f:fff with SMTP id af79cd13be357-7e8702ff7d0mr181122285a.3.1755162645190;
        Thu, 14 Aug 2025 02:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn35nVFpbW4SQ7GGUjk0NbSwr7QNZskeA5TBdBYhzOrCzf4UEpISooyNIg4+oLGOSan0/jPw==
X-Received: by 2002:a05:620a:17a7:b0:7e6:3c4f:fff with SMTP id af79cd13be357-7e8702ff7d0mr181121085a.3.1755162644705;
        Thu, 14 Aug 2025 02:10:44 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df2e4sm2547262966b.62.2025.08.14.02.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:10:44 -0700 (PDT)
Message-ID: <330ba090-8036-4451-a74a-9055a811b2c4@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 11:10:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v4] ufs: ufs-qcom: Align programming sequence of Shared
 ICE for UFS controller v5
To: Palash Kambar <quic_pkambar@quicinc.com>, mani@kernel.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com
References: <20250814065830.3393237-1-quic_pkambar@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250814065830.3393237-1-quic_pkambar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX0kBrKuiP2WFL
 aUK6krVahsc+yektCgH+csPAXhiVHPxsqRJVPhCGZa9hFOrHQmv6AWYOKg5HeD7t+AYc6ch7MME
 twWIflcIXSHVz8Dfy61CPZUIDdVS9iQhXU8A2+yn2Yh2S/lFwGyuSWu9JwIQip63TI/Lb1yTkS4
 BWB4XvL4h6vSxIfELxo8xn9FsZ9G2odHSMKi8cWU35FXPSSeaW5+PMTI+3Y2xTOf/aAdtS69vo/
 8ZZpODmVlaCI0CY/1IAHn2Zu+n+D2dwp35QweSmScauTwML/AEG/uGqkIU+z3W9Cx57gB+epPXv
 6XEUufFaydBUdZCdEEHohqMU+72/egkA9R9Pmc0b0S5rDsL7z6u/9resfhhK4FuEVsErt9zKE+1
 hhLmIShl
X-Proofpoint-GUID: TSQz9vu10TwyPCDiJFRr6_JSj19b4fqJ
X-Proofpoint-ORIG-GUID: TSQz9vu10TwyPCDiJFRr6_JSj19b4fqJ
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689da816 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Nfjzny0KhGhuxlGztiQA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

On 8/14/25 8:58 AM, Palash Kambar wrote:
> Disabling the AES core in Shared ICE is not supported during power
> collapse for UFS Host Controller v5.0, which may lead to data errors
> after Hibern8 exit. To comply with hardware programming guidelines
> and avoid this issue, issue a sync reset to ICE upon power collapse
> exit.
> 
> Hence follow below steps to reset the ICE upon exiting power collapse
> and align with Hw programming guide.
> 
> a. Assert the ICE sync reset by setting both SYNC_RST_SEL and
>    SYNC_RST_SW bits in UFS_MEM_ICE_CFG
> b. Deassert the reset by clearing SYNC_RST_SW in  UFS_MEM_ICE_CFG
> 
> Signed-off-by: Palash Kambar <quic_pkambar@quicinc.com>
> 
> ---
> changes from V1:
> 1) Incorporated feedback from Konrad and Manivannan by adding a delay
>    between ICE reset assertion and deassertion.
> 2) Removed magic numbers and replaced them with meaningful constants.
> 
> changes from V2:
> 1) Addressed Manivannan's comment and moved change to ufs_qcom_resume.
> 
> changes from V3:
> 1) Addressed Manivannan's comments and added bit field values and
>    updated patch description.
> ---
>  drivers/ufs/host/ufs-qcom.c | 19 +++++++++++++++++++
>  drivers/ufs/host/ufs-qcom.h |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 444a09265ded..9195a5c695a5 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -38,6 +38,9 @@
>  #define DEEMPHASIS_3_5_dB	0x04
>  #define NO_DEEMPHASIS		0x0
>  
> +#define UFS_ICE_SYNC_RST_SEL	BIT(3)
> +#define UFS_ICE_SYNC_RST_SW	BIT(4)
> +
>  enum {
>  	TSTBUS_UAWM,
>  	TSTBUS_UARM,
> @@ -756,6 +759,22 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  	if (err)
>  		return err;
>  
> +	if ((!ufs_qcom_is_link_active(hba)) &&
> +	    host->hw_ver.major == 5 &&
> +	    host->hw_ver.minor == 0 &&
> +	    host->hw_ver.step == 0) {
> +		ufshcd_writel(hba, UFS_ICE_SYNC_RST_SEL | UFS_ICE_SYNC_RST_SW, UFS_MEM_ICE_CFG);
> +		ufshcd_readl(hba, UFS_MEM_ICE_CFG);
> +		/*
> +		 * HW documentation doesn't recommend any delay between the
> +		 * reset set and clear. But we are enforcing an arbitrary delay
> +		 * to give flops enough time to settle in.
> +		 */
> +		usleep_range(50, 100);
> +		ufshcd_writel(hba, UFS_ICE_SYNC_RST_SEL, UFS_MEM_ICE_CFG);

This was supposed to be '0', IIRC

Konrad

