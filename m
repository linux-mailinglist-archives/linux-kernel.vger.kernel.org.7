Return-Path: <linux-kernel+bounces-879432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235EBC2316E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160053B122F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A13311967;
	Fri, 31 Oct 2025 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWpKRBBS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IBa5aZVY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F042155C97
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879562; cv=none; b=PlOuwYnqxwsUCFI9Gg7bagPDl4p3nfEl9CbuKa0pw6TuADpQDLzJiMmM4QGfvqyrHYi/M3UpG8nj3d/l+/a8/Pz4m4FIjOac4lHAfQwLPWvq8MmKKQ4hxy/YpCBsM+Z12gObuZJqXcaDBKA9t2T4cLEcu9n/gARLJoX7MtLHDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879562; c=relaxed/simple;
	bh=oLLHQAU2YEzNQABmjELIaj3tCmU7i1oXTOuB6R2iSqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndSJNKHgt5CsppfPk+UalBxFriW1L8hM2qRWbaU4td00urzq8ouymF1JuK4pfNP9Iw4HA4BJoQ/xxjC5mEnXxQFZK9T8bln7DZeb8gzyFIPkL4eoc6F3L0hEIxAlVH4Rpb/rzyNHGCgf38IVQXMXmqS21dV2ax3kfYBl6+WMowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWpKRBBS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IBa5aZVY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULsgLJ3808875
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	up7h5Rt3oEtrg2OPL4ITn4omkUSMHi23cUrvc/cU9zc=; b=AWpKRBBSfB8DS77P
	sKLF2ZXMWnIUYveMCqeKjWe+OSOH4BxMGvQKUGPpKiiNluwu6a5mIUl491twU6k9
	DGOXDVgtJH1VAVqA47j36Et6RDxDIrLuOwwh+Hmg++y65+pgplezZ3bBtVU90khx
	Ra3S3Rk7QcslNaKbQ22Ep1zoPcyOzBpbNLmi7+2jhh/3jcnJ9+kNw78eu9a/HXe8
	dGFZ7F1z0a5qHUFiayDaqoi8TXfr6gc03iEoV34I/aCAwF+CL/K+QaL99Z2gZCL9
	+3m59HMSNbHlHjASiWmNY2dDnP5MRsJD5G15EzkV69WTZiG7jdgQz6/YUrz6yWNb
	mTTnYw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a46vvadjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:59:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33dadf7c5c0so1893410a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761879560; x=1762484360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=up7h5Rt3oEtrg2OPL4ITn4omkUSMHi23cUrvc/cU9zc=;
        b=IBa5aZVYdSMG3puaFRKQVk3uZ+i5OY2DrF9djcIO+GgotfBoxzX2WiobmtOtJ7/INU
         xQp8CVekZs+ISM0Wc4ruSlskORQ00XbengipgyyEKuGXThNOK9t9JdjQDXmrWl/ZsAJp
         Fm9tUHbyxUcVuL7iuPii0wyyc2+SX4XoMs1uWDOtJe/eKah5HiVfV9ADV6zKtftr4Fc4
         LaWUHJic3hsIuZgWiL702yumuKNa6X6C1hK6R+mSodvkBmvBbN4uWBY5xQKiSIrTG8wj
         SLqReGwxiNAbbQ5/+VHpIWFTS9tKdp5ZSySLcVpaxmxVaM3KxUuKmybHHbjPHcFyIATM
         QT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879560; x=1762484360;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up7h5Rt3oEtrg2OPL4ITn4omkUSMHi23cUrvc/cU9zc=;
        b=clmp4g7HRas+p0WYKLHj8iAEYwteRDlnZB4YAbkmgJqmIFUaObYG0gSwRZHPUFGhL6
         OJv36CS8Ty+olbwMF69WH/1jQf5QqDpvtHAjpTL0PciYgg3Ri9nPtg7vjTSOpNJPLQlH
         kJhpOUx0NHyL7jQAsyc47IL2pQAvXoH+4khiVe+ewf6YDzTGXinMj5eFdFLjM6OzWbTV
         oe2z5TO+UcGYMLXtq9bkgG4bqqkHdq80A9JKOE6ctUnLYfisAeTR7pzChGMuYq9vF+7p
         TlFY6o+l00uVTGQGbch9ha1ILhALYhETXs/ddXLtsCc958QVTt/xfoLFh4AVfBRmlFC8
         SWJA==
X-Gm-Message-State: AOJu0YyABbVO8+A8mQUIdzaBFij4v+TTHaNwx8qBAdEx2/hLlDz+Ujla
	UjdwtC4Bw6unLnF2fyOKqFqk3Hildd1PWD5BiwlYBNSizIQOfs7iS1lRZ1a/8+mPwMYHRedTh36
	7MQ3CfkYrwvwr8/Rnw6t1i3yzwRJx1nKS2VjHVwigwbTwx1G/Ab6BA6fsCNozy/EXb94=
X-Gm-Gg: ASbGncuJV4F10bU6+GK3Ruwtki4IVPzwPdGIAE+jdykg9CPfZmbAm2usrcTZRBaB8PT
	ygi8uYwiZkmvRzGLsZYynyv7KBl9q9xSlbF01yoC63sAvgk86i4P1chbrvXWlp2r4h9bAcZpDrp
	StLrNiL5fdrxrIWBdZ6/TraMCMFAp/c199RS1KDWEg7Y/Ub2X6Zy5V4zL65XB/rW44tVZxHNFgP
	FB/f6JQN3tLgMTjjV5YBm4lrLNedoqKhuIQwEJ+gi79OyVhLxvBwtpkV2OOer2dPhMrBHnWYm+S
	O5Sg5nrzKaEW6Vh2hfo0LF2jcHcXs4eLvKGyT1lrqtsxD/IqrHjCthDSdoEnMywGRzwcdoCn4PB
	oAisQM3UT6AvJkpqrnGv9xdX9LBkNI1ilfMHSX60KC0TKfWO9tELH6FE8248J32KvOo8uZnA=
X-Received: by 2002:a17:90b:2247:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-340813cec4fmr2682140a91.13.1761879559939;
        Thu, 30 Oct 2025 19:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8UZxZTzI4+McEAYXu1qgEJFOfy6TCm9B//jkN8UZOlDMEj9SKaRXt8i5G8maNfGXC5APFPw==
X-Received: by 2002:a17:90b:2247:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-340813cec4fmr2682106a91.13.1761879559465;
        Thu, 30 Oct 2025 19:59:19 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f24ef0asm590142a91.11.2025.10.30.19.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 19:59:19 -0700 (PDT)
Message-ID: <0d7e89b1-b676-434c-bea3-fbf6f5788448@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:59:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 5/6] wifi: ath11k: Register DBR event handler for
 CFR data
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-6-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030043150.3905086-6-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LFJZPJ8e8XMIZujhAiASAZv4Ima_Mp2X
X-Authority-Analysis: v=2.4 cv=dK6rWeZb c=1 sm=1 tr=0 ts=69042608 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=73josGCDwRHW2riM0nMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: LFJZPJ8e8XMIZujhAiASAZv4Ima_Mp2X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyNSBTYWx0ZWRfX++OUdQ9ReWSa
 kh3QSLaIV18jvOkW6OXAfaFUOsLpcddl7g0UAcAAb2mrfVpJDTblTm+kv0A7HQpoUc9ApbfS/L6
 mTdV+D7ysFgICvxbuFXPZdImlYqApLfQwE7tKFqAuYjBgxddhsrGasccyTzROIkBEAJRx43kJ8D
 OsxuHJ8v/ZPMe9L1+p27lXnGjW3TpRu48BPuonc11BfNqeEczx6E8gBQ6sgcT8XmEbYjMR94FYY
 SWXjmLGTfy96+sdNgpH7//yOHvGIzykuyG+FnoWc612y9A0BbDlkYC2Snu2M9QAfFYTqAPmZn5b
 f7KfL7/yjSJ2kfTnxGpUQxa2o3uHAqmRXeKGdOhbfLFzDxU5bZrU5+M1lfeFBccB8WDs7vo3OkR
 JhhYAM/LVNorRQzFU+iSNNlbSPIkhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310025



On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:

> +
> +/* Correlate and relay: This function correlate the data coming from
> + * WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT(DBR event) and
> + * WMI_PEER_CFR_CAPTURE_EVENT(Tx capture event).
> + * If both the events are received and PPDU id matches from both the
> + * events, return CORRELATE_STATUS_RELEASE which means relay the
> + * correlated data to user space. Otherwise return CORRELATE_STATUS_HOLD
> + * which means wait for the second event to come.
> + *
> + * It also check for the pending DBR events and clear those events
> + * in case of corresponding TX capture event is not received for
> + * the PPDU.
> + */

please check comment style

> +
> +static enum ath11k_cfr_correlate_status
> +ath11k_cfr_correlate_and_relay(struct ath11k *ar,
> +			       struct ath11k_look_up_table *lut,
> +			       u8 event_type)
> +{
> +	enum ath11k_cfr_correlate_status status;
> +	struct ath11k_cfr *cfr = &ar->cfr;
> +	u64 diff;
> +
> +	if (event_type == ATH11K_CORRELATE_TX_EVENT) {
> +		if (lut->tx_recv)
> +			cfr->cfr_dma_aborts++;
> +		cfr->tx_evt_cnt++;
> +		lut->tx_recv = true;
> +	} else if (event_type == ATH11K_CORRELATE_DBR_EVENT) {
> +		cfr->dbr_evt_cnt++;
> +		lut->dbr_recv = true;
> +	}
> +
> +	if (lut->dbr_recv && lut->tx_recv) {
> +		if (lut->dbr_ppdu_id == lut->tx_ppdu_id) {
> +			/* We are using 64-bit counters here. So, it may take
> +			 * several year to hit wraparound. Hence, not handling
> +			 * the wraparound condition.
> +			 */

and here

> +			cfr->last_success_tstamp = lut->dbr_tstamp;
> +			if (lut->dbr_tstamp > lut->txrx_tstamp) {
> +				diff = lut->dbr_tstamp - lut->txrx_tstamp;
> +				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +					   "txrx event -> dbr event delay = %u ms",
> +					   jiffies_to_msecs(diff));
> +			} else if (lut->txrx_tstamp > lut->dbr_tstamp) {
> +				diff = lut->txrx_tstamp - lut->dbr_tstamp;
> +				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +					   "dbr event -> txrx event delay = %u ms",
> +					   jiffies_to_msecs(diff));
> +			}
> +
> +			ath11k_cfr_free_pending_dbr_events(ar);
> +
> +			cfr->release_cnt++;
> +			status = ATH11K_CORRELATE_STATUS_RELEASE;
> +		} else {
> +			/* When there is a ppdu id mismatch, discard the TXRX
> +			 * event since multiple PPDUs are likely to have same
> +			 * dma addr, due to ucode aborts.
> +			 */

and here

> +
> +			ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +				   "Received dbr event twice for the same lut entry");
> +			lut->tx_recv = false;
> +			lut->tx_ppdu_id = 0;
> +			cfr->clear_txrx_event++;
> +			cfr->cfr_dma_aborts++;
> +			status = ATH11K_CORRELATE_STATUS_HOLD;
> +		}
> +	} else {
> +		status = ATH11K_CORRELATE_STATUS_HOLD;
> +	}
> +
> +	return status;
> +}
> +


