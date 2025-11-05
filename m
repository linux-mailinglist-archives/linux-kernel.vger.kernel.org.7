Return-Path: <linux-kernel+bounces-885738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04323C33CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859DF3AE3B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6E254B03;
	Wed,  5 Nov 2025 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6Irj+iW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wtbe4q4+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451121D3E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310825; cv=none; b=Rad2vJTLaoUh6dEATNH7hnzY+WuNWRX3bGvau/nWvGmpQIH2F3YzQUJ0uGc5EvEqGUZK0hwjFjtjrZfkv29crl/GUQcgi8v497uu+Uf36hoCmsw/XqPS1xwp+PrPX8Cjb6ieiSJiOgurk8whAfT3FQGl4Q7L+D1AI7x8znlulDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310825; c=relaxed/simple;
	bh=dkLYJehyR9lg3oijQsJr+ApeZ1eMMGVXQWsn/CtkOAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K05QyjdHH8Fu95qTvdEORKPTD7bgt8BYlCjENjTGHT0I/GJjqtLopg12cIVJj/71D2KZhpZ0Qzs75sJbGBHtqhXQqurihkfQ66I3Yb8LkNETrvP1nStPSjhY3fTNMvb4aOK8BTX/AAWbzEy4auqcDr7Aq78J1mqIbVumyLeWQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6Irj+iW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wtbe4q4+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KfeXe2927473
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 02:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xEgKxTzFP5wtiwCINthvDjzT8DEp1xPRg4SO6G8xn2c=; b=Y6Irj+iWoATxQYrG
	5Z+y9o7SE6YyPNcWVGkCzJQ0hlISPUcVdUzTQYQEQfv68RRYHxq5XC+ELN5HUZ2z
	4RToSObOufxg52mH4xH8HvoXQ6Z/Vsvd09WiPazfe+jE1/T1uHQnCcnudBnNu2kn
	9LTM6BNf1FUQ2Rk21Rg0z7WkDvxvq4b+Lt2myXhsOiCfRErf6Gknc+wGmx7HuSCw
	IIoX9LLxKfdbw8tf2avcC9EqYCg0zF0RUn6kPEV1pONE1XPfEy6hB2VBUEIaBh1J
	XEqKP1NiNgC5EbpeNf3PnNCIbjzE/gray0HDbVwQw20HyCti4z08R/FML6oMBpvq
	gYwSWQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7me5ss5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:47:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3408686190eso11120684a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 18:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762310822; x=1762915622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEgKxTzFP5wtiwCINthvDjzT8DEp1xPRg4SO6G8xn2c=;
        b=Wtbe4q4+wuNJPIGCmAQiI7Hkh36EqUgqf2Dyl3WudzK4DWditiG1YHajr4ACNId+e8
         U/l6n/mm6Zdzf9s3OHCIJvCvRktVRQ+Fu5Fe/kLCEbuhvouzFokltdqgd63ebmiEK7fz
         fBrdCL3A83fyDc6nlixL/pCWiQue+ojKhsbEGesUbhHAW2E8B0yLUscwb7pmMtAX1S0f
         u1lMA9iY6vv84J84wLLt9rwU+x00O8e2d7+jniKirjz0qk1YClwHm3CJP98VWuyNJaXQ
         mNzKlkK3dJTh8xmEETvrqDS6/cRid6vpZWbts87On5Sr8rqlPxSFXQyJ19unQBxkmSXh
         mMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310822; x=1762915622;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEgKxTzFP5wtiwCINthvDjzT8DEp1xPRg4SO6G8xn2c=;
        b=CfhChQVQ/23AS7Vg5IdHKDc3ozeOA1f/FLdkZ2iy2VE9ibzYn0o2xZdLEjREdve22X
         ajAuHgJFcWFj8JBUcDqedXmG+AMvrwG28jiEBkoKbSAkvcZEpgUT70vERkkUBh1TJssE
         6k62oDwM1DIlbps/ALk7t6Vjl1Him54VD4VNvAn51pXV4o+0jSZIcZMsUYRBdXJ2KZVD
         IL+/1Zy+2zgaYeDGGjPg0vKN2GOsaculJJ3cZgqavVuAClL1eWzlpxKolUuzJJRIJe5S
         Let8fFcsoq9fiLvXlml1x/gQCtpKGRQBryTQFWgya4dJjPkh9DbdyHYXTDfK/JBgY0O8
         TSiA==
X-Gm-Message-State: AOJu0YyNGU3tED9fIqrSKm7Q6+d8RPcDikbocUW0lmEF3gztkawbnV9v
	hrZjBvRsaVhRxzEI0mXGzkQWcZZKQoosZBjKmdIZVSkYYzKYVBeRuAWJmcaOf/6TbzX+76t3aNK
	pi2uKAWoS00NDoZbHL54+h7nPizwbFv4eQqIVJ84rhWRVOP1k3SvKBznOHc7UGd3G4O+qkckuGp
	Q=
X-Gm-Gg: ASbGncvIYBBYHBSngWqpACrNXMz7VyQPrQGpxgXCoC5XfjLbbw1z13ZhGPPtijwpkuD
	Or0HH60s9DEkoiaUCQT89anYT1aMN3WSf7+4YYDGMr0WIHV3g2ikhc7oaaxPrVIv5QoY9/oxrIJ
	/uah/5UF2v+Mdp1/OCr89U+zuNTxHO38kEEjlyNz6tgCKdV3sqvBjZEcltOcqvR2WXywfm10tSZ
	xJv1nEYmyB170G2UEYwDYHpJu/+pvbs2TLJ2YSjUMwHrLgaJ1PXbwljdmdUOw9ZBGEOyp3w684v
	g7bF7Rz7IWNOhxsKiKId8j0ZYQtCXJ7gYzPDuGH1J7Xt7Ilkwtly/oXyX62BAPdptbieGaODocb
	SGojYTTdEzZq4FC8vKN7Ygn/JbbQZnNxjCrLk7xHH466kkxoNYgo6V3p7OeQ3H7ZME0/i28A=
X-Received: by 2002:a17:90b:5350:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-341a6de83a1mr1783542a91.26.1762310821993;
        Tue, 04 Nov 2025 18:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuwMno/jN7iUuFKpQ58L3wuOLckMwb2hS/UjoC4WxCpQxVIypLOXTOb+caLCW75bcojVp0Yg==
X-Received: by 2002:a17:90b:5350:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-341a6de83a1mr1783499a91.26.1762310821509;
        Tue, 04 Nov 2025 18:47:01 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f942a9d9sm3829624a12.33.2025.11.04.18.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:47:01 -0800 (PST)
Message-ID: <9830e3fb-3f08-4343-bae8-07d446f86173@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:46:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 5/6] wifi: ath11k: Register DBR event handler
 for CFR data
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
 <20251104162633.3007874-6-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251104162633.3007874-6-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mL6smPerQLKqjjf8xQHYLc48sfMcwQGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxNiBTYWx0ZWRfXxg3/FYV2y4vc
 Xs1qUs2l0ubZ0qgbRQxztHJkop4/jwOO7MZgjNcrLrZ7EqyoJDEguU7nfXYo97ubKksa0cpfVyt
 SMWSorsa/AHYSJPsOIL5rCKAHs3W8Jrd1iBIaiK0NI6FJKoOwIg0E1MzCST5AhD51NJ22BjKz9e
 YGjsHkukx1g+cawEkTDLOhpzOwcHi9XevhPGgVoBkY4+NLGvIHXNe/nGBGQbKXpQA7Ponev1ykN
 mPCNMCnish+8o/vXJDRY0Lgp1uLc0++fnUnqYGEW9sJ3kxECP9RV/hrgcOSR760rpH0NKUl56wn
 KpkIU3jOghOyL7+2LtADatLZx4V5t+1BWmQyVsblO5o3lKRrxh2Xgoi7ZvMzzRDsBdc3Dn92tLO
 vCcF02b+moDtuDQxTXSOz/dF4ck9DQ==
X-Proofpoint-ORIG-GUID: mL6smPerQLKqjjf8xQHYLc48sfMcwQGE
X-Authority-Analysis: v=2.4 cv=IpsTsb/g c=1 sm=1 tr=0 ts=690abaa6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wcWF3zN8gqulG0AiaMQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050016



On 11/5/2025 12:26 AM, Yu Zhang(Yuriy) wrote:

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
> +			/* 64-bit counters make wraparound highly improbable,
> +			 * wraparound handling is omitted.
> +			 */

I was meaning that we need to change to the common Linux comment style which starts with
an empty line:

	/*
	 * your comments start here
	 */

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
> +			/* Discard TXRX event on PPDU ID mismatch because multiple PPDUs
> +			 * may share the same DMA address due to ucode aborts.
> +			 */
> +

same here

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

