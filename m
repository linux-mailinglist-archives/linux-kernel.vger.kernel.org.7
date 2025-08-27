Return-Path: <linux-kernel+bounces-787523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAFEB37775
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3054716BAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2491EB193;
	Wed, 27 Aug 2025 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hU/G9xpm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7635166F1A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259841; cv=none; b=m62lUCyJmCNyDiKUb0Z2sOnn6p385m/DsOWGwT8er0saBvn7j/rLIqFZhgwRp/AUv2Pkk0713apFsSiymQPioeKJVrk64qU+5TulbQEIYO6sfduAT2yBBR0hD6nzFxZYpt1L4ANScsqafskVCi/W10bPE0DZ9yXDaNZHaCoDCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259841; c=relaxed/simple;
	bh=r+1XfEORO59jMquhV9Pm2QNKKblDliJN3+Zs8N+eN+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqe+/w8453sAW/NAD8d5SAMpxE0z/owAQDQsuuftNVvqNm19tie+GZLNsBDpByVj3Gae1njdmd5A30s+mYOjJOZzGdh0vxtXXlJQSsKsjuLdWpic3jasQB0jlYd7HlRopeb42p1Q0ett7hTJQiD61rwupl2BSpHAypRFVJINmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hU/G9xpm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QMX3l0008821
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tjs/w6Rugmz9OyiMttcxwIC9
	NEhSLG+c8hsBrGYuSRo=; b=hU/G9xpmmMKa/B7l1dbuor9QatKTA7g51k3EsaGY
	AndFvgdieGPhb2vHNvPjh87GOPcBfTr5eea5I7OL/jhJimUKGRbpFeld5Nj1MnSw
	VQphoYgkUBsx8L6+FDsIYSw+Mxq7nxvNvt9R7bODrALivkX9tVkRNFYQfCNAvDO0
	mGObapZUutJj4B558yEu9/kZcicrDscnO60arU4mTL7JsUIDYoupqxN5OuopbpOx
	UA0xJB3zqiZK890Mi7abQPI/3gEvkb8HTjFR/nW3wjRdCCuPab4Dtx9pPGRS/tI5
	pTP0j2fCze8MarAuet2OCgGXyz3bmkg2r8WXfDnnSyt8KA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2u407-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:57:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109be41a1so243209061cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259838; x=1756864638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjs/w6Rugmz9OyiMttcxwIC9NEhSLG+c8hsBrGYuSRo=;
        b=UT8LE0dlW0ASII/eX11U+BRsfxvNzCl7zgPX3dUgqWRUtRkVrEjfayzpfYVEcDwLLI
         eWTdVhpwgGvjRIt2/qsyJc7JH7Y+O2ErbKyTWxV3cM8MFpfERpRYHlOvkidcCj6BjTCM
         5lUf+2LXFlS8ZA8H0pxENPhIiQEazvQKUkuw7hBBbXK062RbjdPISa/KsuySCqWrTZg3
         mIh/m0pH3CO88PTh2D80R400X+AuLRJcPgHrLm+rLFAnnIvyxae7lrZeum6gfZyLvJmN
         5LlidyKR35HeFjUkYsuFjyCLfPMF66l7SfiW0DwWjybK1wLaO8xR5/DUyrTCqTQ3zXC8
         CKIA==
X-Forwarded-Encrypted: i=1; AJvYcCVXbVoEw3XTl7ub9z24v6oHCIG77rT3ZO6Jbtu/PN5QBnc+D85q81Xh1BZrFdQUt/xvo5QnF8Gw1aUaPZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjV+Dz6uZrb8aRKd6xeaA22X9/hybOfkbD3Dw+lvrjwMFQP8me
	0W2G0IhS7sHwndHupsQ654IMKQ+Y7AFTbkRuL/fSep+m547dZ6r1v4X87qyafeiIMwaJfYIQjwF
	sl1lcE2fc4ErzTctPBtUyMm7pjI6b5u3R6JAPag7FDhmSidGO4N2Hpxa5buPftjUiKVs=
X-Gm-Gg: ASbGnctHy+xBTszSkMCf22PtANAqzb22EZ/gPUKbmSlwZwULjOcMd7HulH7sBlaQfl9
	71C4rdbbKSWOgIrK9DH60f56EjLyOWSXxiObHNHacQEGR4Yk/lxYFVJtmsNPwHrf2bOMOzrw7LV
	dwcAROEb3GTG7tucYyHMTtGhuN5vl0kLQmwP/zLI8yNC/eYNvtxg04MzLuNJGwKZ4vKv2VwU4c/
	NE1I96U0DV1fBnFNycH/IJX2Qyip0XaPdBLF2TX/czYI48GIDwpI16nAy7y8ekEzmMiZYE0mF9m
	DFJZ845D5x1JDsyqs8DsZbTncpjfRdnoXQsmwKTd0n6Zsk9pPn88sd8lsnMk9ODiwBGnfaE+8qI
	XMzaefGd/3PFr+IxzCdYsLtuR5qwOgoMhw527cSVkVzR6CZAVQsMb
X-Received: by 2002:a05:622a:5485:b0:4b0:e93d:8752 with SMTP id d75a77b69052e-4b2aaa6e4eemr227657041cf.37.1756259837760;
        Tue, 26 Aug 2025 18:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNcffuYMtkF0UrerifJit2fOix76wByWZmgmXEEbQpG6a1LmiRtbpsz46LSTWotCAlBbM17A==
X-Received: by 2002:a05:622a:5485:b0:4b0:e93d:8752 with SMTP id d75a77b69052e-4b2aaa6e4eemr227656911cf.37.1756259837245;
        Tue, 26 Aug 2025 18:57:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f52453de2sm296165e87.100.2025.08.26.18.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:57:16 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:57:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v10] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <lpndrvnjklmqglg22y7fnfeeyrp6odoedixosjc4n2jygeq4ve@ootpynfw5zvs>
References: <20250825113858.4017780-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825113858.4017780-1-quic_shuaz@quicinc.com>
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ae65ff cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=Xgb9nbmtQSVvgoRKimMA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4aFSA/jQdp6H
 u2F9M72+y9RAsFAMdsivyB6OCz4T/Hbt+sVTsjXwUnESqkqaNLWItsKsTLWkeKm1qncW6Zw23bY
 tDAAuNmbJCGvbTEyQFI3mwZybB9UZjANjX3qIKEwGjbIsOTFNQs/az6YiXk3c1i33WXwbwQCO73
 IbTHFmR1qrRfP05TS7LjF2OyWlk2VIdvQdetoTSUHxYRWjl9bvxDtaIu5lkWxFuTjSX23uhFVoj
 qWhHzIPXT8aIhhks8zEfsnkoPQ7Mey8SMcjbW00CsOeCP8gRm2h4rjBy1JhAhTw+H8A1F6nk4Vw
 b9a7RyUerBwy5D9QwQUmmeoL4xWeu2EkZrRII8aSdVR0T51bwjpO21om7Hid/JXNNaWDFQyA6p7
 F6UU+yMG
X-Proofpoint-GUID: 8AMgQAX9hP9a3HTe7qKc71ePwdxGIlUV
X-Proofpoint-ORIG-GUID: 8AMgQAX9hP9a3HTe7qKc71ePwdxGIlUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 07:38:58PM +0800, Shuai Zhang wrote:
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
> ---
> Changs since v8-v9:
> -- Update base patch to latest patch.
> -- add Cc stable@vger.kernel.org on signed-of.
> 
> Changes since v6-7:
> - Merge the changes into a single patch.
> - Update commit.
> 
> Changes since v1-5:
> - Add an explanation for HCI_QUIRK_NON_PERSISTENT_SETUP.
> - Add commments for msleep(50).
> - Update format and commit.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {

Please. Stop. I've asked several times to make sure that your patch
builds. It still doesn't. You are still using some older kernel version
as your baseline. This patch won't build even on released 6.16 (which is
already too old for development).`

So... Please find somebody next to you who can do that.

> +		/*
> +		 * When the SSR (SubSystem Restart) duration exceeds 2 seconds,
> +		 * it triggers host tx_idle_delay, which sets host TX state
> +		 * to sleep. Reset tx_idle_timer after SSR to prevent
> +		 * host enter TX IBS_Sleep mode.
> +		 */
> +		mod_timer(&qca->tx_idle_timer, jiffies +
> +				  msecs_to_jiffies(qca->tx_idle_delay));
> +
> +		/* Controller reset completion time is 50ms */
> +		msleep(50);
> +
> +		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +
> +		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
> +		qca->memdump_state = QCA_MEMDUMP_IDLE;
> +	}
> +
>  	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>  }
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

