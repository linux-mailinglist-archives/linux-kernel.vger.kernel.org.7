Return-Path: <linux-kernel+bounces-730409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949CDB0445B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912E27BB0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C125A655;
	Mon, 14 Jul 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UTpC8asi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32581FF1BF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506989; cv=none; b=QoJAscGtVSV/F3xZRgvQYSnaiXJdOmH6l41QSweSjNC++3lepNNJyk2ZM+4qbtXIB7GNwSL5v+prHFNwVmWSvRsWMDxDuR2rkF30E1cnHpTNJeQQdi+g8teJLicn9A2Fj+ujNIIJRZvpCKuRln633A0I/27qtwnjGwMvg9OTveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506989; c=relaxed/simple;
	bh=T1Mdsc4JM5JmPEJvdOVLsOzT/sLrlOvVRrsYyOrni7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmO3nHx7gPvoDwKrB7GyDIALmFHMja8uhnxLYEGUGUabopaFrfTIEMMlRi0i1IN6CzehLeD+O89EEyW3Q9DLvx5grOSCLCQxR1P3JXz2eOMiX/504/U7Fkz0Y30diRscxT1krc+JPcLEYlDZ4qEjhSb+ZcM8YDJoSgCKhtL+txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UTpC8asi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EA07nn000413
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sc20yyLx6uwEm8iOhcdE1IlDb1WrP1gxUU+Y/eFAixM=; b=UTpC8asiIgxLFMet
	+KDFAGYeTfn8cJfBibG4IAf+5V3smzKmnyVl4Jn3ZwBbBRQ/YRodNoigqAmm/mVb
	BDhL7VIJCGP3SzSMxVpkqKKoQcajLrD1ADtYzEk33cZcKl7uju/wD6DY4EwojqJp
	mwPZHMEZhcqQGqDccfE2h5Bv/+8xOGFJB1ogdRcNxMzSP2qYE7e/pTsZRWjJ5wIl
	emCsXrKaa3dJmNA/UAJN/FbleWAYfVuGOYK9R3ezfksLQpBoKsfwwwzO1UySvPbf
	uNhEFp+Pf4afqHQW+VICCZ0Z0yejGN/j2ivyfQe7RUqH2PWYFMmzxLeI50q4wXEA
	S4aa7A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufvbd1m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:29:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so3803698a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506985; x=1753111785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sc20yyLx6uwEm8iOhcdE1IlDb1WrP1gxUU+Y/eFAixM=;
        b=kt8otCHHQJQ+vwT9nePsoTxbpgEo6C4BHTeuhl05xZy3OGALuIHlFm+RZp0mxtVzgf
         ApHBXAOr8c2oxsRC7aRnEe+ki2FJ3DBZBXtEDEhUjNCWGcoHjzr2ehsTTCS4apH22VCH
         hqcpm6QM/IwutleM5EZyj29S+VFCMal40GVQ+Qo0VZyOqak9mbZugsbjQonn5d3iQZ+t
         BYsqg/6LT4C8QF4VFPzn0pmIEERye37OvlnND6tPSKY0PVvMKsAQIF8pXjCYMklhBFnO
         oKxzZ7SYduaG3kpBbbddoIoGyAEhCEugsxgQWQznJRguuaa+ExFN8uEQ0d3QplIXa/nB
         TDyA==
X-Forwarded-Encrypted: i=1; AJvYcCUbPGqjEyxV6ogFKBX8JSHUCMobvO9Lil5btlGdAsDHUkY5MEgnATwbXFjjCmeSQ9ncgteMOtJScH1Kyi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIV2CrM7wuV9C2ztw+rZlu22+v5ZqmJdG7R8Pm5A5SL/KNf3R
	WIRfSKkZtaRTgiuguogCbczCRYU8fOXdLwHH6DQrSX1LjtxpSRuCYTCUk9V1mKl7bR/4YblZbqr
	/qjrb0QlhGi+vR2xiNPFnI3hIbG6RLkO9rHbnvkifbz58lnhpFrvbb2MhczH2vLwJs44=
X-Gm-Gg: ASbGnctd+eqws6KKDuhNRJ3PXYNtR/L5KjaKS0/kIfy7DhrA7zRpCk4IkKFdzAe3eRx
	+S4zNiTlsxMPYYiJmjjcmYIFQ7KVIEq/zc6i0QKKLZDbbfk96OCZS2oHQxmhaX7aUealMAN0pU5
	bAwltlsFC8gNxiAE9PN/uAgFfw/rX3ZI0vwA378zqg9Ha6tRcHuou+AEFo3oxIiEiuv2k0lyIDR
	wA0YnzE8rjASMnsjeohUOMZEtsDN/q0/d1Fy+pYCafd+jlkrESB2APTrWbby7/Bgc0OpT4pKmWC
	a/oKQj9IwM1WNTZ1vdPBDAwvtMENvOeab9K8zt/o2TblRWrpCmKd5j60pEG9UjcAx9U4T9c=
X-Received: by 2002:a17:903:7c7:b0:231:9817:6ec1 with SMTP id d9443c01a7336-23e1a47c514mr62845ad.17.1752506984853;
        Mon, 14 Jul 2025 08:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGES5Y2dRxhfcCMM+wJvXYd9ZZrcxo8M21VCbQ4zrhDX3UO9/CvLZWBR+xQ8CwxnG8n1ulaaA==
X-Received: by 2002:a17:903:7c7:b0:231:9817:6ec1 with SMTP id d9443c01a7336-23e1a47c514mr62395ad.17.1752506984223;
        Mon, 14 Jul 2025 08:29:44 -0700 (PDT)
Received: from [192.168.1.36] ([202.164.130.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435bbc1sm94750925ad.228.2025.07.14.08.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:29:43 -0700 (PDT)
Message-ID: <b3767f6b-9793-47bc-9b09-70fc931ce8f3@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 20:59:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: qcom: Remove extcon functionality from glue
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250714044703.2091075-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <20250714044703.2091075-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MiBTYWx0ZWRfXz6ijjcboDgAD
 JTiKijMmq/n/Bm6mjP6Kd72ybfjGtW6VYmyPa/IHdtRVFr8Ke09Q9jt+BVfPGMpmy1DkxuK6G3H
 xmLO2f4+q+DtQGUvnaTJlVYvJRPB+JCuMh9NafXDMb2l9SbFlFr/67YtBWlsPa3oyA1R/J3ezEp
 kExHc7RXyRQaE+wFj/ZVmMm0QJFZtQUmu2iSSxS1dIKGxVLau6FThGd20kavZ0meK8QtJG2Hfjl
 BY8hswS3Cexa5miVfF0stkNKCbe2KSx6scdQbt+0jNV3Cl2XZkNCwWUb8F8qr33cw+bWd0AUxpm
 86Zixu89WfhRY3ThbWhkqEA4sg39bMuqmSsVswYekblrfQqHRJVkkw0Bi7IIAH0BrMJyCFBkDP4
 XYkbDEgYTvzzYjuTVJy5ABh1VvfiH5awm4KdryrCSCx7FftWEqMxODLtEKXm5r7Al4j3DP0Z
X-Proofpoint-GUID: qdqWLgZjC9i5EkP8nIqSKob54DHKruBh
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=6875226a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=5MqDkbE+qPoSl7Gb0QG4vw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2Tj7kaNsuKJ3Ycti4bYA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: qdqWLgZjC9i5EkP8nIqSKob54DHKruBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140092



On 7/14/2025 10:17 AM, Krishna Kurapati wrote:
> Deprecate usage of extcon functionality from the glue driver. Now
> that the glue driver is a flattened implementation, all existing
> DTs would eventually move to new bindings. While doing so let them
> make use of role-switch/ typec frameworks to provide role data
> rather than using extcon.
> 
> On upstream, summary of targets/platforms using extcon is as follows:
> 
> 1. MSM8916 and MSM8939 use Chipidea controller, hence the changes have no
> effect on them.
> 
> 2. Of the other extcon users, most of them use "linux,extcon-usb-gpio"
> driver which relies on id/vbus gpios to inform role changes. This can be
> transitioned to role switch based driver (usb-conn-gpio) while flattening
> those platforms to move away from extcon and rely on role
> switching.
> 
> 3. The one target that uses dwc3 controller and extcon and is not based
> on reading gpios is "arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi".
> This platform uses TI chip to provide extcon. If usb on this platform is
> being flattneed, then effort should be put in to define a usb-c-connector
> device in DT and make use of role switch functionality in TUSB320L driver.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Changes in v3:
> This change was 4rth patch in [1]. It was suggested to make this as the
> first patch of the series. Since this is independent of role switch
> patches, sending this out separately. Removed RB Tag of Dmitry since the
> patch has been changed.
> 
> [1]: https://lore.kernel.org/all/20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com/
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 90 +-----------------------------------
>  1 file changed, 1 insertion(+), 89 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index ca7e1c02773a..a7eaefaeec4d 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -11,7 +11,6 @@
>  #include <linux/of_clk.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> -#include <linux/extcon.h>
>  #include <linux/interconnect.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> @@ -79,11 +78,6 @@ struct dwc3_qcom {
>  	struct dwc3_qcom_port	ports[DWC3_QCOM_MAX_PORTS];
>  	u8			num_ports;
>  
> -	struct extcon_dev	*edev;
> -	struct extcon_dev	*host_edev;
> -	struct notifier_block	vbus_nb;
> -	struct notifier_block	host_nb;
> -
>  	enum usb_dr_mode	mode;
>  	bool			is_suspended;
>  	bool			pm_suspended;
> @@ -119,8 +113,7 @@ static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
>  
>  /*
>   * TODO: Make the in-core role switching code invoke dwc3_qcom_vbus_override_enable(),
> - * validate that the in-core extcon support is functional, and drop extcon
> - * handling from the glue
> + * validate that the in-core extcon support is functional
>   */
>  static void dwc3_qcom_vbus_override_enable(struct dwc3_qcom *qcom, bool enable)
>  {
> @@ -137,80 +130,6 @@ static void dwc3_qcom_vbus_override_enable(struct dwc3_qcom *qcom, bool enable)
>  	}
>  }
>  
> -static int dwc3_qcom_vbus_notifier(struct notifier_block *nb,
> -				   unsigned long event, void *ptr)
> -{
> -	struct dwc3_qcom *qcom = container_of(nb, struct dwc3_qcom, vbus_nb);
> -
> -	/* enable vbus override for device mode */
> -	dwc3_qcom_vbus_override_enable(qcom, event);
> -	qcom->mode = event ? USB_DR_MODE_PERIPHERAL : USB_DR_MODE_HOST;
> -
> -	return NOTIFY_DONE;
> -}
> -
> -static int dwc3_qcom_host_notifier(struct notifier_block *nb,
> -				   unsigned long event, void *ptr)
> -{
> -	struct dwc3_qcom *qcom = container_of(nb, struct dwc3_qcom, host_nb);
> -
> -	/* disable vbus override in host mode */
> -	dwc3_qcom_vbus_override_enable(qcom, !event);
> -	qcom->mode = event ? USB_DR_MODE_HOST : USB_DR_MODE_PERIPHERAL;
> -
> -	return NOTIFY_DONE;
> -}
> -
> -static int dwc3_qcom_register_extcon(struct dwc3_qcom *qcom)
> -{
> -	struct device		*dev = qcom->dev;
> -	struct extcon_dev	*host_edev;
> -	int			ret;
> -
> -	if (!of_property_present(dev->of_node, "extcon"))
> -		return 0;
> -
> -	qcom->edev = extcon_get_edev_by_phandle(dev, 0);
> -	if (IS_ERR(qcom->edev))
> -		return dev_err_probe(dev, PTR_ERR(qcom->edev),
> -				     "Failed to get extcon\n");
> -
> -	qcom->vbus_nb.notifier_call = dwc3_qcom_vbus_notifier;
> -
> -	qcom->host_edev = extcon_get_edev_by_phandle(dev, 1);
> -	if (IS_ERR(qcom->host_edev))
> -		qcom->host_edev = NULL;
> -
> -	ret = devm_extcon_register_notifier(dev, qcom->edev, EXTCON_USB,
> -					    &qcom->vbus_nb);
> -	if (ret < 0) {
> -		dev_err(dev, "VBUS notifier register failed\n");
> -		return ret;
> -	}
> -
> -	if (qcom->host_edev)
> -		host_edev = qcom->host_edev;
> -	else
> -		host_edev = qcom->edev;
> -
> -	qcom->host_nb.notifier_call = dwc3_qcom_host_notifier;
> -	ret = devm_extcon_register_notifier(dev, host_edev, EXTCON_USB_HOST,
> -					    &qcom->host_nb);
> -	if (ret < 0) {
> -		dev_err(dev, "Host notifier register failed\n");
> -		return ret;
> -	}
> -
> -	/* Update initial VBUS override based on extcon state */
> -	if (extcon_get_state(qcom->edev, EXTCON_USB) ||
> -	    !extcon_get_state(host_edev, EXTCON_USB_HOST))
> -		dwc3_qcom_vbus_notifier(&qcom->vbus_nb, true, qcom->edev);
> -	else
> -		dwc3_qcom_vbus_notifier(&qcom->vbus_nb, false, qcom->edev);
> -
> -	return 0;
> -}
> -
>  static int dwc3_qcom_interconnect_enable(struct dwc3_qcom *qcom)
>  {
>  	int ret;
> @@ -737,11 +656,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (qcom->mode != USB_DR_MODE_HOST)
>  		dwc3_qcom_vbus_override_enable(qcom, true);
>  
> -	/* register extcon to override sw_vbus on Vbus change later */
> -	ret = dwc3_qcom_register_extcon(qcom);
> -	if (ret)
> -		goto interconnect_exit;
> -
>  	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
>  	device_init_wakeup(&pdev->dev, wakeup_source);
>  
> @@ -749,8 +663,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -interconnect_exit:
> -	dwc3_qcom_interconnect_exit(qcom);
>  remove_core:
>  	dwc3_core_remove(&qcom->dwc);
>  clk_disable:

Shouldn't we cleanup the Kconfig also? Anyways it's not critical, so it
can be handled in a follow-up patch if preferred.

config USB_DWC3_QCOM
		tristate "Qualcomm Platform"
		depends on ARCH_QCOM || COMPILE_TEST
-		depends on EXTCON || !EXTCON
		depends on OF

Regards,
Prashanth K

