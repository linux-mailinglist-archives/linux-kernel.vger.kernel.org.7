Return-Path: <linux-kernel+bounces-819096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BDFB59B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94631C04C85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0429ACEE;
	Tue, 16 Sep 2025 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5jmmFXE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3E2D73A6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034917; cv=none; b=gVqAYZMmRsZKB5UXTwav/j7gM+mhvStgq3MYTN72bE973DgeaxU2Jv1YPZB2PdGH0xm8kGn0uXtz+6dPzci/8gM5F6D/RjeQZq3Ii5plA973MRkPfDuziJDbuO2Hnjh/kPgY09R407NcPDgHZDEuIR3qxkSCK7PBJL/bNE6NVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034917; c=relaxed/simple;
	bh=V6mHa38mysjYNRJUEikUz02oIziJBYgb5Fn53aeXasQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH8tuZDXIeExxtk6ku0G6fsmobcjIM77ndT24Q3LLAcGoMpbBiwnYK1AvGERotPNZJYGeVroSrPVdr20Uc6Z0yuGsM+vWhOk+iwBkj+3/tLHInZkdZiAEmc03kN8TdkhFYYDbNEeVE3GxfWpPYJG0et81D6uU+SfwfoDDTsKI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S5jmmFXE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA9hCD004797
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=of1NnpvC4m4tAzpcErPDN2SR
	dIgBrxNnPJCO+YtJdQA=; b=S5jmmFXEAGqIf5L0QoMesRIqTnoVPzOsRe2iJitg
	5eIr79BJhftgy4zM8bnRENnZseeoTmdcZ4huluSUi9LESv4Q/gQSeCkwZcktAdko
	Rj2hR68MotuHGXkp+fCaRf+EHLx0LzZ8ryWBQWfokNfmdr4mjwA8yZVTCuRMSOd5
	E+OmWZjiobz4pvdvMEI3S99mKivdIvVZZwa9vFxiK6+YMLICUZEfJ1c8pkzaHqZK
	wOSF2wl76YEob1iD/VGbgrS+UVciQ3C4O7Drrvr+69Ez5OSNV7Gwhff+McETG6s6
	BNUBUZ2AKBEjE6n8aQO1PJO/aXz6ssLlvZtipNbWnhu5BA==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr9j43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:01:53 +0000 (GMT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8877131dec5so666984239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034913; x=1758639713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of1NnpvC4m4tAzpcErPDN2SRdIgBrxNnPJCO+YtJdQA=;
        b=Xv3ZsJmieTdkRhpZb9lHuazUEjNx5DmE5eD5dxfgtDmQACtnS0YATO96a7peDKQW+3
         Q7DPQK14A2I32qvr7Rdjpq78NEWtSnTNeYpuf/4vQf0e7S0TJ3NTYxdqmPV9wE7JaH4r
         2isKdMC3HtHQkl1/TQOLnppPenDRCx3oEmSjfjs0KgjV0Xa4fSXHJBAO6ZUwiDveEIlX
         NRn2v3G+qFY7hKMP0JnQd650HSCFyKsnI3lyta40c6RXz3+Q9KtHaAoe+4zTty4iSEhf
         qjBgMYdWrULaOrtItxFmXV1aWDQ9LqA7TE26yUWy02Ht7dYj8RVE+FZbqamj4xKm79Cy
         J9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFz9yJkuoNbSzH+iaLkeXAtAieQpL70IfyUkjicSG01seENLbtp+dL1ILxhniUPCBxn7PHGlySwkvoKKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwwN/18McGjk7Wk72Zc9oU2e9vBj7KuwV27TjbaoRcQXXfb1P
	2mpDUNyDHx6EFgPtUXVZdAnYXyneHdHl4J+yEfN3916ZNCYEANSx3DLhSiPQuUCtxbTSJj50AIg
	FUW50hcDn4cE4otOA6oQ05gZWcxFrnQNLAZzl5abtlQRBt2steXenz09cm1xThffVgYU=
X-Gm-Gg: ASbGnct+1wejSXh9HqeWhaVUFpxsFDT27aPBqRdyo16U8w0pJm50yd2Qlot28TjKn8A
	RHASeYmx9n98TFiFQX0ncivQVpJK5EeoL9o8miw0tFdKrAYZcO0jk1mxFIrXcfxK822KYRL4RHC
	UfAR5ySPHhVEN5Ad2U2LANiWLvut46XSIsvUDOfjNmvOUjk7cmmiBpHr5VhU1g+f8pMIQHimV5F
	PpSC2nXOXlPCme8bd/fPvz47vieT7FLOBYF9LkeKwvSXD4/hfwrg3bJ8F9VZWzX1Bm2bpjgjPGU
	wyzXCuYdTXs0Wl51hl5VetJ8TtEHpTnybEOitXoFFT6jiv45Rsl4vHRqRVWMMjMxGi50xEwYAlB
	Nln/p3iDp+SIotrdesLxyv3DgE6CreivxZ/RSEzRF4JfOMW6ein6e
X-Received: by 2002:a05:6e02:198d:b0:423:fcd6:5487 with SMTP id e9e14a558f8ab-423fcd6574fmr107539435ab.14.1758034912425;
        Tue, 16 Sep 2025 08:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNVfwi9Bmg9i65JLMcvGviSI5VrkiLbBHhSFRGqNxTjXkVrJjQuB13UCEP8RrnMUXYQhCfcw==
X-Received: by 2002:a05:6e02:198d:b0:423:fcd6:5487 with SMTP id e9e14a558f8ab-423fcd6574fmr107538745ab.14.1758034911743;
        Tue, 16 Sep 2025 08:01:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-350c15a7382sm30545931fa.16.2025.09.16.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:01:49 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:01:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v12] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <vipw44g3fmaf7yhv5xtaf74zbgbkwhjgyjtguwdxgkkk7pimy6@eauo3cuq3bgi>
References: <20250916140259.400285-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916140259.400285-1-quic_shuaz@quicinc.com>
X-Proofpoint-ORIG-GUID: CsLCQKetCalnJvEBmVUS8Ag0ZOJW1dPF
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c97be1 cx=c_pps
 a=uNfGY+tMOExK0qre0aeUgg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=H90gdJbu_grP5bgN1gsA:9
 a=CjuIK1q_8ugA:10 a=61Ooq9ZcVZHF1UnRMGoz:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfXw3qhxBPFOe20
 YLI/q84nsyq3sGsVbvbPDbX/Sn6XR/+nUZ4ZV3H3fU36OQZ3beIGmXnCQdl3rIi/h46FILcw22v
 /ejGKLIfNeuDRmhagFufLqzyZO9vc00eUnW1lEQlEO5wRYUmblu26cqueH/tt0otammcTQz4KRx
 beUaZnSwkGKRr041767+vUOOLQL7KTAbQ+4QB5ikU+p3vnHQPpYdBrSDdu6Ld9UUMzBP/kLNS/n
 DSCoFTrt3vmUWm9od3VyxjSTjod8WeUYQ5fhq1eiV5QbAQjEXRCjJ5+YOasdX/YxZb4Z3M51BYR
 u3Sxsqaox5qTXqhmPfIOCleur8fyHhIMVRckjv+ufHOaX/VlRKy/sC4UDTxCVq+60y++sK1+Z6F
 VOTJf9d2
X-Proofpoint-GUID: CsLCQKetCalnJvEBmVUS8Ag0ZOJW1dPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On Tue, Sep 16, 2025 at 10:02:59PM +0800, Shuai Zhang wrote:
> On QCS9075 and QCA8275 platforms, the BT_EN pin is always pulled up by hw
> and cannot be controlled by the host. As a result, in case of a firmware
> crash, the host cannot trigger a cold reset. Instead, the BT controller
> performs a warm restart on its own, without reloading the firmware.
> 
> This leads to the controller remaining in IBS_WAKE state, while the host
> expects it to be in sleep mode. The mismatch causes HCI reset commands
> to time out. Additionally, the driver does not clear internal flags
> QCA_SSR_TRIGGERED and QCA_IBS_DISABLED, which blocks the reset sequence.
> If the SSR duration exceeds 2 seconds, the host may enter TX sleep mode
> due to tx_idle_timeout, further preventing recovery. Also, memcoredump_flag
> is not cleared, so only the first SSR generates a coredump.
> 
> Tell driver that BT controller has undergone a proper restart sequence:
> 
> - Clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED flags after SSR.
> - Add a 50ms delay to allow the controller to complete its warm reset.
> - Reset tx_idle_timer to prevent the host from entering TX sleep mode.
> - Clear memcoredump_flag to allow multiple coredump captures.
> 
> Apply these steps only when HCI_QUIRK_NON_PERSISTENT_SETUP is not set,
> which indicates that BT_EN is defined in DTS and cannot be toggled.
> 
> Refer to the comment in include/net/bluetooth/hci.h for details on
> HCI_QUIRK_NON_PERSISTENT_SETUP.
> 
> Changes in v12:
> - Rewrote commit to clarify the actual issue and affected platforms.
> - Used imperative language to describe the fix.
> - Explained the role of HCI_QUIRK_NON_PERSISTENT_SETUP.

I'll leave having the changelog inside the commit message to the
maintainer's discretion.

Otherwise:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

-- 
With best wishes
Dmitry

