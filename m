Return-Path: <linux-kernel+bounces-782569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66DB3223C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3A062853B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB52BE62E;
	Fri, 22 Aug 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WsHZD8bU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1942BEC28
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886914; cv=none; b=NhtlRrfkJ6z/S/KswY2QnO3wt9d/Bfou9X13OXfRkEiexMZgP52XbksJeZvKZMiN+Hf1nj+OWyXPpGKAioqGxiGMhj77T9g6DTC16J7ZkYeo2sfmRoo12Cy64q+nvjUbQWQvV0s2qQuI6m7Zr3IFumvobR+vf57Ejl3m7p+N11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886914; c=relaxed/simple;
	bh=XnfyyBM6Pz+Nxj3ytKVde+CXgWpxq6tYu+r2xS+ravM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj5hJ53QQ9sxjAMJK7zCa3+eVAUxo8gVjPmCvd0zzkRHffjApuxyR8zNS8rCdXpiXvVujmwHxKBI5jdgq4lX15EiqjaBWLQ5CoxOxKfROYvTXXnu9pIJFqdEFMNY9g4zhvqFaTEsGSLJEDoZQH2PmFcxY69w7cAFUgydTt0syvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WsHZD8bU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHVD4i021095
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=z3XjF/GiPBvLacOcQzaE00w+
	swQurw1OEiUWR3vIT3E=; b=WsHZD8bUiNGS77HfTwzv0EQtuW6ifmDmqfUy3Eiv
	rObPs+LQFsS77HSBCwTVpwLLjBDlC1G9zS8Q/JgXbd/tO+5aOp5X0qgAJKubzx59
	mNA4sM36AcPMyeAnAsGfsxBALIYYuDSTnsWdQJ8TonyZXQ/D0sVRsVrh8lPY7dcR
	T/FJrvhC2dlna2o/DNS42kftjrksAu+hPlB6W4JXr2ErCJyh4eV4Ej9T5pSfrdMZ
	BJhJ3tOFe5xG4fu5EbJnMMkgmk617Zk/d0CHRV1UisvpHNmWW+rDGcwsLZjzUV49
	xU30ssrrS7zUbFFuESZjv3yRwR7T2u/UlhpPVlTVTSLbrA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw13g4xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:21:52 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d9a65c324so19422236d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886910; x=1756491710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3XjF/GiPBvLacOcQzaE00w+swQurw1OEiUWR3vIT3E=;
        b=b+wo+9gbmCSPtny32OPp13GyZiE37iL1VMsFR6043stRQbmE5AaoeFnUrrdMu/qYlu
         wvo8SWbnUssT8AlGptwpFvN4uOZbogXxD3r9Y0SSND+wgH3oyrh4tcVcedU0niCuKAOa
         mt8RNF0btcXmI/co9p0oGxQLF40OXArv07717Y0DcVC5QBr9MTsnH1wxHQlgZoNTQwqO
         Uyb+N4Y9lJ8SuzUHMAdDdYalSY4ZPfDJ4s+sNeAW4LC57P54Q3tH6OJkFMLADltoYAtg
         PcUUbXlDzog5yJdc1O3KVq6VAyQyeGFWsXgvmXc6un3lHgh5ud6Jh2RxXHr8b1bGRbo2
         EMYg==
X-Forwarded-Encrypted: i=1; AJvYcCUxebCtmIop2Q1ttsuu2UiuiTwOIN88jSxjTLL9tFMl3RraX26UcAIdjknl5wHdly0+HB3yrbqdoUPRNK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+imhFBKLTLqskzb6/TTipHMVbBRozk7/U5jrA9ldjVSaZ9pdM
	za5iGEIQ20+eiXTQyjwucO9Bg/S/IAKONje7HHkOIAgyUanoEEGXfclaQQveyo8r333on+tR5i4
	fZmb+3yrYDBB1qnMsdYfVMiSK4xmSXN1f0zjG81YESUxJ8wxaLM7W/5YVEJS0BLiU2iPtI3ur3B
	E=
X-Gm-Gg: ASbGncvRZTzhoqIjNBeHILoF1nSjtPoJY3GN4OgnvOWh2F9XEYMb8e2Jw9dkPLDFY+w
	smrvqrZtXUXtlFFx/B82i6P3rZ00GdkFQ5hXBgLGf6+upadX+T/CtMmLIRXHmvInKwxh+DSzyPI
	fdkUUsPbT/9bujQm5XriIpifauch2iLFtQaiX8LpBnLU+ZlOfhjBgjRrwh+ER2FilEh01X9tzOu
	6iiM/vcFSdSQy/q+DPwuiC4bvkMZpDakI86Hf+KUmH+tZOPxad2or5rK1JZHXv9b5xIpx7d9n0u
	Ag0wfeBmLKLYQaMNIFp2jkHJ9WNmNqboKgyhhjIkjcFenZoVyfN+0CxLqXlZBsveYiMrN7Wu0an
	8iCgR4uHAblTsZ+sIzBj7BK8e0ckhpGRdq/egSgPmxhaJobtoWJP3
X-Received: by 2002:a05:6214:2a4d:b0:707:4229:6e8c with SMTP id 6a1803df08f44-70d971f5efemr56637086d6.12.1755886910423;
        Fri, 22 Aug 2025 11:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXxaLnv1Y9uAXo5cfUz4pwJXUczPdAECaz58MIxnRLI3/YKXEsleDUu2qANw4OMZIlzAK5zA==
X-Received: by 2002:a05:6214:2a4d:b0:707:4229:6e8c with SMTP id 6a1803df08f44-70d971f5efemr56636626d6.12.1755886909861;
        Fri, 22 Aug 2025 11:21:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8ba22sm86692e87.100.2025.08.22.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:21:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:21:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v8] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <eg6hush5t5r2seelkolmb3hqjlmh7w3yzekb3lnn4sm3qxufee@e3eberzr4izp>
References: <20250822123605.757306-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822123605.757306-1-quic_shuaz@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfXyrqQCbxOJPPR
 rqUky5z+gGn8dDipR2zww4355DxDL45dcnskZyQyYPyfaW9med/0kSFwzmMgKn5hqIUJohQomG3
 f9yQAd228QJH4X1i+qiaXWnymUy/EiTPOiPtcgweAZFr0n6EaaqW3REBeo5pp4pmwMbTVoABwSu
 S6SXghBywWIidSwCdLwZhsYAkBxz4+klR9D+CcjOFHhv6Q8YCTzf8/2sIqw9XncWhto8B90sq0q
 8U0lHfxnaXeu2RCZzuFL9fOVLGg6axXG19VhadaVCn8jzWyT9x5n+QyI4ocpWZ36sQihb8oHYYb
 P9ClXtTiksqMpAq/sBOR2+TnEJ/w+LD5Mz79hKxVouo5ZGXlUSECGHERmdFeGZoAsQCdC522u2x
 nregdL4M
X-Proofpoint-ORIG-GUID: Ftw8bsmpMXUwRWtJL0zrHjNFBZOGAODY
X-Authority-Analysis: v=2.4 cv=F6NXdrhN c=1 sm=1 tr=0 ts=68a8b540 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Xgb9nbmtQSVvgoRKimMA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Ftw8bsmpMXUwRWtJL0zrHjNFBZOGAODY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508220160

On Fri, Aug 22, 2025 at 08:36:05PM +0800, Shuai Zhang wrote:
> When the host actively triggers SSR and collects coredump data,
> the Bluetooth stack sends a reset command to the controller. However, due
> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> the reset command times out.
> 
> To address this, this patch clears the QCA_SSR_TRIGGERED and
> QCA_IBS_DISABLED flags and adds a 50ms delay after SSR, but only when
> HCI_QUIRK_NON_PERSISTENT_SETUP is not set. This ensures the controller
> completes the SSR process when BT_EN is always high due to hardware.
> 
> For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
> the comment in `include/net/bluetooth/hci.h`.
> 
> The HCI_QUIRK_NON_PERSISTENT_SETUP quirk is associated with BT_EN,
> and its presence can be used to determine whether BT_EN is defined in DTS.
> 
> After SSR, host will not download the firmware, causing
> controller to remain in the IBS_WAKE state. Host needs
> to synchronize with the controller to maintain proper operation.
> 
> Multiple triggers of SSR only first generate coredump file,
> due to memcoredump_flag no clear.
> 
> add clear coredump flag when ssr completed.
> 
> When the SSR duration exceeds 2 seconds, it triggers
> host tx_idle_timeout, which sets host TX state to sleep. due to the
> hardware pulling up bt_en, the firmware is not downloaded after the SSR.
> As a result, the controller does not enter sleep mode. Consequently,
> when the host sends a command afterward, it sends 0xFD to the controller,
> but the controller does not respond, leading to a command timeout.
> 
> So reset tx_idle_timer after SSR to prevent host enter TX IBS_Sleep mode.
> 
> Changes since v6-7:
> - Merge the changes into a single patch.
> - Update commit.
> 
> Changes since v1-5:
> - Add an explanation for HCI_QUIRK_NON_PERSISTENT_SETUP.
> - Add commments for msleep(50).
> - Update format and commit.

Changelog doesn't belong to the commit message. It should be placed
under tripple-dash.

> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..9dc59b002 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,39 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  		skb_queue_purge(&qca->rx_memdump_q);
>  	}
>  
> +	/*
> +	 * If the BT chip's bt_en pin is connected to a 3.3V power supply via
> +	 * hardware and always stays high, driver cannot control the bt_en pin.
> +	 * As a result, during SSR (SubSystem Restart), QCA_SSR_TRIGGERED and
> +	 * QCA_IBS_DISABLED flags cannot be cleared, which leads to a reset
> +	 * command timeout.
> +	 * Add an msleep delay to ensure controller completes the SSR process.
> +	 *
> +	 * Host will not download the firmware after SSR, controller to remain
> +	 * in the IBS_WAKE state, and the host needs to synchronize with it
> +	 *
> +	 * Since the bluetooth chip has been reset, clear the memdump state.
> +	 */
> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {

Still based on some old tree. Could you please stop doing that?


-- 
With best wishes
Dmitry

