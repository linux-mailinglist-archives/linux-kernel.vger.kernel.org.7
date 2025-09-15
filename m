Return-Path: <linux-kernel+bounces-816418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C709AB573A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6153BF195
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233752D3ECC;
	Mon, 15 Sep 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACmnaZLe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E162F39D0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926347; cv=none; b=cUz2f3QYmWwvr+7UDJTZ8ghpYRLzk0di7OrkvaSNKPipusVAwtMBNv817+CZh22f6GkQB46JL4ehrDV7MEboI7UIis8dvRIPMDBPINeMAZ8J4AqjYpSzkZWaNqeM8Pp7ZS4dB5EK5nQKrEEh48IjIhDqn+6eKXQfqwF2NUvx+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926347; c=relaxed/simple;
	bh=JOtrS9+M4CQeumFyospkbCpibbdi2oOVAl3i+k7+ezs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0m18czNZsisHmRLnmj2cKs0uCfh2jfeBGNZp/TeaRU/CyIZYmfioEVRGR14NV5eXSH+Xz4KYPjwHn8ey2dUovothLq099BqLgaDNNDT8JqFizMcMGYcef+rP76+FNvEsF15JZWF02+aAYzYpCcFW3Lm8y/TvAnM8DwTJwg8Kxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ACmnaZLe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8Fi1v031763
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZoOP1y6kv2Q1qrI74LMh14wnvJCBrS7R1fHqNXnvWAU=; b=ACmnaZLeO5cK9+7g
	bp8Dtv7rpwucslWmRvTKrPbKGWlSmK3QzLpjk+tp4pF75cEbSiw+ohESc5C3v5Tw
	TD8TJXSqyUybIpwjhY27xuLSWClTRUugnVAH1RXxU8fAYUNR+Uzm+Pe12pJ/fogo
	dz2UOHiyloYr7xKb5Ta171sEmO4/KixhpOaHJDyF8GRQsYxj6JUscIyvd66VU/uu
	PVu9nChcDkqoSlj2aDO4elbvIX4ZlHh2ZzUu/OrDej1HoX5TFlXKRf82ujp1Q4sg
	6tjY+FpY5x1d3bGaiCDGyhFjH4U2QWo9LTIWlpXqTveuLeUZS112HfKqOaOfW4MX
	Xqv3Yw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma46e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:52:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329b750757aso3319834a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926342; x=1758531142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoOP1y6kv2Q1qrI74LMh14wnvJCBrS7R1fHqNXnvWAU=;
        b=B8BS+++Rj7Sis6QvwTt6wfOuD5J/qePJTvwa1d99bSF1jEK7+CBQ4BgKrjil7cdTkw
         hrec6PlAa4bJ9HUUFDYehyvSxhPu4v3s0GydF3qVbwuqbfneHfFlbcew+9yW3coiFxMS
         ZlGZbwXIQl22VcnojUavmryLjKt4LTRMjNVT0FiMCRX7gUiDtjr5UprEpnvqy4W2iDj0
         nw6gnmtS1bB4qWJvFYlbxPztENcKdQy42reagTMhFoxrkYenhVYnf2wubnGFnPZ9OICY
         rWZ3BrfBmFeKJVanlfi4gt+Wy1WYQzVo56pvC+WL5rlAmqeVK7rzKEfK4U/gFEeL+gAJ
         pahQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxM44tp7wPcji+NYcm5MDh9RQqTH76YHuH9WXnkWplQeMpNdLJs1miJBKclRw3trjqBsmwjp0FAlxnxEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUCAk3Qh5kCE4aqktyskC+flRnRUCB8jQvXqQRzbl7CoTqFOo
	YHC9HbA5RuYJRNO3VbuG13Ku6opF7zs5Oi3E8Sxh8pehKzY9D/Ql/L99jCPx79aqU9RpGuqFyjD
	5nOLRbcHUZf1noWJMCae2gAoGBCcGj1yOKxCX/zj4eVL0r61U5iy059+WmJRYQxuWAoLhnZkRgy
	8=
X-Gm-Gg: ASbGnctB1ptdX+TlQHr6bCXu8kAWAXQ7KH9Q4H9TIxrXkHuC52m0clYb0vHts70pYQ0
	7BSVatcDQkyRp1ZYRXwm+OuNYEKPuSVR++kotuDZQ+E+XbQGyzcSKCZJe48lxruqDq+ElwqZbyf
	tAA1lGM7mirvpAik0L5i9AAhzKozkCLlp05HLywBOhHDIOwGGcWzbnyDZHjnNpYPyof6x8HEauT
	s71OKI/7I0EyN3YQ1faw9QnPmDPchxE1WWpNJPAMFYiKay4rDpIL8MyuGqCfRjnA3tpfXGUbK25
	lOLilAf/5YSCyrGaMOY7R8sepcoAJA2SnP0Op/BpbtHd6RHf503dX/GeYSZg3AXbzf6E7MWzvQ=
	=
X-Received: by 2002:a17:90b:39c5:b0:32e:6019:5d19 with SMTP id 98e67ed59e1d1-32e60195de3mr3234361a91.34.1757926342434;
        Mon, 15 Sep 2025 01:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHDHxY7PMZiwj9+qa9gWiHA+FHIEA6+jXuVLrMiGIMq3qikMHGq/3peLPb9JO2Yw5ntBoNvQ==
X-Received: by 2002:a17:90b:39c5:b0:32e:6019:5d19 with SMTP id 98e67ed59e1d1-32e60195de3mr3234341a91.34.1757926341964;
        Mon, 15 Sep 2025 01:52:21 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ac02de2bsm8708849a12.17.2025.09.15.01.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:52:21 -0700 (PDT)
Message-ID: <65df50b9-0bdf-4a62-ae1f-d0bb550ff406@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 14:22:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] bus: mhi: host: pci_generic: Read
 SUBSYSTEM_VENDOR_ID for VF's to check status
To: Vivek.Pernamitta@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Pernamitta <quic_vpernami@quicinc.com>
References: <20250912-uevent_vdev_next-20250911-v4-0-fa2f6ccd301b@quicinc.com>
 <20250912-uevent_vdev_next-20250911-v4-2-fa2f6ccd301b@quicinc.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250912-uevent_vdev_next-20250911-v4-2-fa2f6ccd301b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX802tRFDjSWaB
 Om3DpXnjEkFdvAUAfUFU0CCw8492I5G8WyUI22iwqu2RBIxLuWnVmY26zqRmHzcgj6rEMiE1CvI
 fqw90mTzg59bENS+P5j/z+022vF5MAlH6hDBNrTiB5lE8/DTZNyGueCj9Uq+hVhj5+rDWh4ySKM
 OqPmcz3/+GjmggjXmaj3+p2taIxqSwYI7e9xtWMTjEY9KwCHPtBtVANzWN+/M2hhpX49dqvcPdu
 +pEz9fDU03S9eRk0F93Jdbuacm10fl1AdcqClqlSemc1XnYEEEcJJSK0pFlaltDP0ZsaUTNqO1P
 8mWwPLBwVFo/blFa3ILOm1tzG9J9lZCzXXPFXxEcH2ZTK1d6kChvczWlJACZikWmwKCzhwZN7HR
 mQF76V8J
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c7d3c8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HFCjbP5WYD9W18CjRUkA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rVOtEBhPqq5eU9f4jIIPIzXVHxssMapq
X-Proofpoint-GUID: rVOtEBhPqq5eU9f4jIIPIzXVHxssMapq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019



On 9/12/2025 6:18 PM, Vivek.Pernamitta@quicinc.com wrote:
> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> In SR-IOV enabled devices, reading the VF DEVICE/VENDOR ID register
> returns `FFFFh`, as specified in section 3.4.1.1 of the PCIe SR-IOV spec.
> To accurately determine device activity, read the PCIe VENDOR_ID of
> the Physical Function (PF) insteadcommit text and subject needs to be modified to reflect new changes

> Health check monitoring for Virtual Functions (VFs) has been disabled,
> since VFs are not physical functions and lack direct hardware control.
> This change prevents unnecessary CPU cycles from being consumed by VF
> health checks, which are both unintended and non-functional.
> 
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/host/pci_generic.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 8a605cb3b8e1e54ef4e699700f3f2660ad5cb093..6fa16975e320212a50e0b68ddb34db5ce711589c 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1082,7 +1082,7 @@ static bool mhi_pci_is_alive(struct mhi_controller *mhi_cntrl)
>   	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
>   	u16 vendor = 0;
>   
> -	if (pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor))
> +	if (pci_read_config_word(pci_physfn(pdev), PCI_VENDOR_ID, &vendor))
As you are invoking only for physical functions pci_physfn is not needed.

- Krishna Chaitanya
>   		return false;
>   
>   	if (vendor == (u16) ~0 || vendor == 0)
> @@ -1193,7 +1193,9 @@ static void mhi_pci_recovery_work(struct work_struct *work)
>   
>   	dev_warn(&pdev->dev, "device recovery started\n");
>   
> -	timer_delete(&mhi_pdev->health_check_timer);
> +	if (pdev->is_physfn)
> +		timer_delete(&mhi_pdev->health_check_timer);
> +
>   	pm_runtime_forbid(&pdev->dev);
>   
>   	/* Clean up MHI state */
> @@ -1220,7 +1222,10 @@ static void mhi_pci_recovery_work(struct work_struct *work)
>   	dev_dbg(&pdev->dev, "Recovery completed\n");
>   
>   	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
> -	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
> +
> +	if (pdev->is_physfn)
> +		mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
> +
>   	return;
>   
>   err_unprepare:
> @@ -1307,7 +1312,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	else
>   		mhi_cntrl_config = info->config;
>   
> -	timer_setup(&mhi_pdev->health_check_timer, health_check, 0);
> +	/* Initialize health check monitor only for Physical functions */
> +	if (pdev->is_physfn)
> +		timer_setup(&mhi_pdev->health_check_timer, health_check, 0);
>   
>   	mhi_cntrl = &mhi_pdev->mhi_cntrl;
>   
> @@ -1371,7 +1378,8 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
>   
>   	/* start health check */
> -	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
> +	if (pdev->is_physfn)
> +		mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
>   
>   	/* Allow runtime suspend only if both PME from D3Hot and M3 are supported */
>   	if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
> @@ -1396,7 +1404,8 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>   	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
>   	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
>   
> -	timer_delete_sync(&mhi_pdev->health_check_timer);
> +	if (pdev->is_physfn)
> +		timer_delete_sync(&mhi_pdev->health_check_timer);
>   	cancel_work_sync(&mhi_pdev->recovery_work);
>   
>   	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
> @@ -1424,7 +1433,8 @@ static void mhi_pci_reset_prepare(struct pci_dev *pdev)
>   
>   	dev_info(&pdev->dev, "reset\n");
>   
> -	timer_delete(&mhi_pdev->health_check_timer);
> +	if (pdev->is_physfn)
> +		timer_delete(&mhi_pdev->health_check_timer);
>   
>   	/* Clean up MHI state */
>   	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
> @@ -1469,7 +1479,8 @@ static void mhi_pci_reset_done(struct pci_dev *pdev)
>   	}
>   
>   	set_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status);
> -	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
> +	if (pdev->is_physfn)
> +		mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
>   }
>   
>   static pci_ers_result_t mhi_pci_error_detected(struct pci_dev *pdev,
> @@ -1534,7 +1545,9 @@ static int  __maybe_unused mhi_pci_runtime_suspend(struct device *dev)
>   	if (test_and_set_bit(MHI_PCI_DEV_SUSPENDED, &mhi_pdev->status))
>   		return 0;
>   
> -	timer_delete(&mhi_pdev->health_check_timer);
> +	if (pdev->is_physfn)
> +		timer_delete(&mhi_pdev->health_check_timer);
> +
>   	cancel_work_sync(&mhi_pdev->recovery_work);
>   
>   	if (!test_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status) ||
> @@ -1585,7 +1598,8 @@ static int __maybe_unused mhi_pci_runtime_resume(struct device *dev)
>   	}
>   
>   	/* Resume health check */
> -	mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
> +	if (pdev->is_physfn)
> +		mod_timer(&mhi_pdev->health_check_timer, jiffies + HEALTH_CHECK_PERIOD);
>   
>   	/* It can be a remote wakeup (no mhi runtime_get), update access time */
>   	pm_runtime_mark_last_busy(dev);
> 

