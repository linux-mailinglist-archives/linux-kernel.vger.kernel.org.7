Return-Path: <linux-kernel+bounces-885740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09666C33CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 491954EAF99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F6252912;
	Wed,  5 Nov 2025 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HoSWexWG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ToFShUS2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC70221290
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310992; cv=none; b=Wg2f7tSVCFkETQRdUg2zWkWjVbodmbS9l/yzqv9+24PUHpBaUeYu66tTs1UGsFAsyWgll2cDuzYPt6hHFQhYBsm3dkJAudzKCP8gJ+3ffD2Q6OrFuqiFhqijRpmFMVUn0qzW5neaUuN59n8tPukAHtR1YuZ4OqxkkGIadkA5m6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310992; c=relaxed/simple;
	bh=bdA5YaMWZUGOajbWkqFMXdVrbQu94SDAD8I7zKtcZ/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/MwkgoFCShWu779QuH9EUKB03z+MQNnBXKHkTKtURqLLC0kAUXe541IZEGEmWol1oRnv89TCeoTCTG8WfaBG0Lfw/dXbjq2UXYeGpZu1eJ+jzNbaeXeHpajOWvMn5U326BOHgUz/zO4AAPCvfwTVj0r8Z+hnACXsdghsQJwPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HoSWexWG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ToFShUS2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KgFd32928474
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 02:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z6fE25BWx2cqViq02OoeLjnc0qT5FrD3WFYx473CdTs=; b=HoSWexWGizap5AgJ
	FqZzHP/6i/annH3353tKGyBFj4mEZrJd9lUr/AXkC7ejnKlYtxBBWno+96D862ES
	onQVPEOM1Dp9QQqnzCFiKH4IA53nR4BUOyf6iqfF+hynL5IkmOIyXM1wEhgAqW54
	JNHiy5HW5+OPFudGFs9G2xOe1VYy9Jqf5ogvlesvqIBOFGKmWyaml9BVdigGw97g
	E8DmIHGCXRTlhETVaicc7fDCCbrjvLjRsfHhCDU6uIAQn8K74atfo/1lGCuLQyzJ
	g0+5rk6HG+VvJAjr6xnw/tHCj5kgPcBwVerFmKaINmBnT2mL4p5mfxNX5Flx+Fy3
	k8gzvw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7me5sscm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:49:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-294df925293so67713105ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 18:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762310989; x=1762915789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6fE25BWx2cqViq02OoeLjnc0qT5FrD3WFYx473CdTs=;
        b=ToFShUS2DOBqSV6cfNrKgK2W0EPV2tgz7fe3HLZamtktkzjy4Ryhh8P4jukxLIFm8W
         4JE4t+qHtxr5BFDY8XH++0mYrGG5AANM69knoDoEG4iKY2/+n2p3PoICKumtoHP1Kyla
         xaa6QDH5PK06ARrIFlTwy53QfgHn3k37s+Y2PXiqnaWRLIeN8lxvdj3IlC2fA22tfkxz
         s5GFbwTav3Y/kSk6OB19YhCPEoM83cDwoy6/yWJtBcyZITEr3qMSsCMqYIcEgULdbvyg
         nA9REXMaCJeA+yhJUE4HRrYFEyeyXn3sDPekKS9vllwHc2LwZrQiUsHboxS+M9kSXyjU
         HK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310989; x=1762915789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6fE25BWx2cqViq02OoeLjnc0qT5FrD3WFYx473CdTs=;
        b=va+5XLE+YhUzIutqnCqMn1HegCIhqq8cg52os25ywvnrYeX4TZ1Ao2/ePiYPfuvGWV
         aSxDB4PJAj+awR6Jzh4+91cvqbczgSk42SSWSGHBsClUnyUsVXqZqp0AayxdFCmiTwIZ
         uaqrrl8+NypoLRK7tAdJoKYCGfSN8J5tCfafnkiNGIoXxxx1ex4vCwFp8kMlBG6+meDz
         qlDgsxBe5EluFBPM1KJe2FZnSQFEWJmmaiDfVU0WYG3T6AQm4MbiHyIr/4LX0ykxOKrA
         vCZHz7eJtJ937mX+QoGm2QqwKfTdCpAjc0zwgKlBCaY/Z5p85K89fu6EfNUQOXIWasw6
         Lfng==
X-Gm-Message-State: AOJu0Yw5C717wPJYrP5auFA0yaY21VGQ538/+NKTYHCsi7mSB5swRQv+
	NZcpxBuEIoM0oo1VFdFVNtl1W0DqQQS+wWnGzOgHnrr8JQ3KQehlURX/VUVZ6YSmWHwGfdIiaKs
	Y2M1O056dLejUfqtnHh31CQDpuOV0t59+Z6yfSJ3kbDuWx6NkFp4X/oxcUanvbqrWVd4=
X-Gm-Gg: ASbGncvajc+AHBQHjkbukYprWExg30SUWgoNW9i/7olBl+q5eSj0FLctWagrPPRd7aO
	l3rPiPaqSOj6QQSG6qeVwULUDQg+oolu3ScGPm5spdwLwd+dx6nnTtn9ejrwKPYmIvj1NVd+7gJ
	l3V3t+9+t6smW6W1488GlYbLtTYi3HOja2jfC2Z+cgYWA+B3PpuXWRc2Scx1zycWEgJmRx+BXKu
	8RpQDEaZbRwydeQMlhp8pp3FYyUMyaiSnlbg5LaejqS7bmpxyXVdqoOZvROdzcfkueiQt/viTmc
	MsmCy9gJAlHGY0xMEeVlFkVq1fPLnvZbZ7u5Um7v6FK5wUjso5pNBwC+DUvWpuXBOtbuSRQPDpv
	FcM7H03DqeJsGdeiIc9qRBhEyKofrSLDZSQWjCxxrGJYiJcggr3KZNM8e5nwPvnPWgDdVvaA=
X-Received: by 2002:a17:903:4b4c:b0:295:275d:21d8 with SMTP id d9443c01a7336-2962abeccd8mr23192655ad.0.1762310989536;
        Tue, 04 Nov 2025 18:49:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGasOAVoajsPy00I58jgS6ERqSmLZ5TtcB7lxyBLTzzfW7p5HgyQ6OUNo/j9HPzCCXDdgYuVA==
X-Received: by 2002:a17:903:4b4c:b0:295:275d:21d8 with SMTP id d9443c01a7336-2962abeccd8mr23192405ad.0.1762310988979;
        Tue, 04 Nov 2025 18:49:48 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998da3sm42602315ad.27.2025.11.04.18.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:49:48 -0800 (PST)
Message-ID: <52b34262-ed22-43a1-b6dd-cea37c33d627@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:49:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 6/6] wifi: ath11k: Register handler for CFR
 capture event
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
 <20251104162633.3007874-7-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251104162633.3007874-7-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: K3Fbxdw_Q6KnaJgXxRtk1eaS9i7dZwX3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxNiBTYWx0ZWRfX9mv2P0knU59H
 dIls4kV+XUYEAMf5VwIFhvgMlnQ0Z2M0btpwcDo5h0WNlAfncgrWmG1B4PNRRiMQyN8etLgU2ve
 pTilTkqh/+t1+VshVJ4sgbEV7NNc1WHd+2eJlb6+NJxyVH7KsDm+iqEKLJcFtXVL9rS4Q1nbMGC
 4WTOvJOncC5d0E7XTAu9hJptgeQyjomyBiaCK4fw9qq7n9/bPSOlDMx+Cpl2gG4Mm1P6XNQRgaA
 YNo8qJsnLuO/iRBjGhtNya6vV352d0QmjHCq3z0m22iW8b7LpfbwNO2HnohauTt1AhqqJDq2VvL
 lGys27VkbvxqNtuWVHatb91QgH9BBFYABIGMlSQ3Y6Y3sQMvxewio4BdByNWcDL4SCO4xcAFTZ6
 g2yKzj4FQbxp5VDRjMKvjZnEI1iEFg==
X-Proofpoint-ORIG-GUID: K3Fbxdw_Q6KnaJgXxRtk1eaS9i7dZwX3
X-Authority-Analysis: v=2.4 cv=IpsTsb/g c=1 sm=1 tr=0 ts=690abb4e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xBSK4iqqMxX8BZ_fnuAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
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

> +static void ath11k_cfr_fill_hdr_info(struct ath11k *ar,
> +				     struct ath11k_csi_cfr_header *header,
> +				     struct ath11k_cfr_peer_tx_param *params)
> +{
> +	header->cfr_metadata_version = ATH11K_CFR_META_VERSION_4;
> +	header->cfr_data_version = ATH11K_CFR_DATA_VERSION_1;
> +	header->cfr_metadata_len = sizeof(struct cfr_metadata);
> +	header->chip_type = ar->ab->hw_rev;
> +	header->meta_data.status = FIELD_GET(WMI_CFR_PEER_CAPTURE_STATUS,
> +					     params->status);
> +	header->meta_data.capture_bw = params->bandwidth;
> +	header->meta_data.phy_mode = params->phy_mode;
> +	header->meta_data.prim20_chan = params->primary_20mhz_chan;
> +	header->meta_data.center_freq1 = params->band_center_freq1;
> +	header->meta_data.center_freq2 = params->band_center_freq2;
> +
> +	/* CFR capture is triggered by the ACK of a QoS Null frame:
> +	 * - 20 MHz: Legacy ACK
> +	 * - 40/80/160 MHz: DUP Legacy ACK
> +	 */

same comment as in path 5/6

> +	header->meta_data.capture_mode = params->bandwidth ?
> +		ATH11K_CFR_CAPTURE_DUP_LEGACY_ACK : ATH11K_CFR_CAPTURE_LEGACY_ACK;
> +	header->meta_data.capture_type = params->capture_method;
> +	header->meta_data.num_rx_chain = ar->num_rx_chains;
> +	header->meta_data.sts_count = params->spatial_streams;
> +	header->meta_data.timestamp = params->timestamp_us;
> +	ether_addr_copy(header->meta_data.peer_addr, params->peer_mac_addr);
> +	memcpy(header->meta_data.chain_rssi, params->chain_rssi,
> +	       sizeof(params->chain_rssi));
> +	memcpy(header->meta_data.chain_phase, params->chain_phase,
> +	       sizeof(params->chain_phase));
> +	memcpy(header->meta_data.agc_gain, params->agc_gain,
> +	       sizeof(params->agc_gain));
> +}
> +

