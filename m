Return-Path: <linux-kernel+bounces-816973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D316DB57BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BD6205077
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1230E0CD;
	Mon, 15 Sep 2025 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cl97wmfU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50215307AF4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940357; cv=none; b=rVM+TKLavewyW9X2BvQ0Xxop5Nq0MLcqlwZRX73dVj6MuOM0X5fN0m5PlFre8S8WLkm6XC9CzI8W9aJTQONNGU6yu7M+jFgRNCRYlL76xxthg6Zv3yQL5W8ubCaN6n1SZFGfP0gUmfxS2RbinbrkU4N9MRsyfLo1GUh0xlXOhuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940357; c=relaxed/simple;
	bh=eI4P548ke3QeFrEKW69MNINL0DS0oOJlV7sl3nEUHq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYeRspy69UyVcXjg/qyel/d5zHYXh5VCuQOl0zVfRs7+3U1wpUFzCfdlzl/UQyYATVX/lHcyW5EzrOGERTDVSXc9+xb/3I5BaVMz6DZySbpPkeoh+n7CDl80awHmJEWqubuaC0fQONYpXmSvSA6o/AtgjUOLE4zMBYM1xxs0dMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cl97wmfU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FkjH005778
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AaEipnFHhzf85OZKccvKdPva
	wLU9TWagjnPpkSlojAs=; b=Cl97wmfUQmILWoI5UlbIpIcqgjCV4gb+/X32szo9
	F66pmsD9BJa1+OH6f01t4olQ23I0dTBlzrfa8VWnOmycGjx7Fm4CuQarjLJR6gxg
	GrCZqcg0HNaGpgaDcPgWdmbpn6TZGwbXNR2qRHnmnfXeDkDnEY501Mhs5MJGtjXz
	EYUcNCk0KVsRwJN+9gltu8HYeUzdbSf4IOtiBn+FwCTUd1gFRmVu9ua3g9qe/V3L
	iCHg6P3sIPxj8mqNLS6rXwKFFrRBwrdb/CuJq0PaygbSSeGIKWnQGZnR0fFQm7WX
	hXkpRIgmHIQ1pF51Edj2hmi7TyNuAihPl5CPlDmAs6dQpA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snmr2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:45:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f6eeb20eso162657631cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757940354; x=1758545154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaEipnFHhzf85OZKccvKdPvawLU9TWagjnPpkSlojAs=;
        b=tG8TBMteLvfA+mVZxqH+62GRlYE/+04DNaJ0FsN2HNNHzAomxGM5d3/vGAJM81Jcs3
         Ne2RKX1Fu30O1OuoTAH7YKt7lnplQiIJP6o0AUVWQyYL/oYXt8KuzWePIayR0xNd+kWD
         Bb62x266s4NpGd92qVrUS6s3NmACTmdihK3s9MYG9aF9YIHhKwMct4c0NhdR4Jzg5EmG
         mSdfIOoLtI1DE5hBnXnBKas3/UwxM/O7sd7Cbi6xzeU5Kdrc95b7x5jjy0b2TXlF7bym
         tSnbMn6W6FLt1MN5aM3BHTa47b/dJsQ0jxKsLA5pAg9YxPCSMMGPlBcp0lyKTHU272uf
         Mhkg==
X-Forwarded-Encrypted: i=1; AJvYcCX6KuWzVftTfmqDquACVLs7vz/+ssH5CzKvFxavKV1Bx72ts3ydPKVz1TrDPLrv/VLXx9mGWLhwzhFpcWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvgytqrzNISiwEV5dnVkc+um6ynvAj6c5/hMAQORnbEqWtzeJ
	WlClRhR0CnEi1LFwy10TnLt2WVqIt18StvF6GqZDghNnnH76Rejfk22WNWSY+E8YZoZ9dRNN0S3
	P+ZP+BH/t0KQU7q1r0bRVO1Rmt3lqKk6n2TJyAT1j6NREMsEYLUDnueiWPZDJGAxvrUY=
X-Gm-Gg: ASbGncvspF1ybq0G3zis0tIblr9aAFM79+Yklc0zkUSBHgk/OlcXyjj+ByFbQ3YleAW
	lhHTh/R/cRUIhbe9+rCSl7Wf/dF+sL0jFlyfsuLChtpR3Y9hsLZ9tHKlvZuHRJpYGf0giIYZACy
	uoBvn5PY/oCmKD+ZtzR/lfeFAnKSvkKrWk2seSsO4kLXtjjr1Zx15vpnOdbt9IS1dYp3TqpgAnx
	d21aBnuCh+XceUmcxcooWBphzebU3gDRUxFjToI10+/gXVd68EV2DH6zFgfDGdk5p9YaflMmmx4
	dqWaIHeKxAonXxrTnK46slD7xNnxExFFZyyesaLWJyOLdM1pdIsAc6y9iVgmJumCxbrcbMZ0+ZS
	5bORKhJVYPiG3erL1c6WRCU7lv81RzkGYpU7iu3jftrT+LDRu7pN8
X-Received: by 2002:ac8:5914:0:b0:4b4:8f6b:d243 with SMTP id d75a77b69052e-4b77cf9fbeemr160255241cf.7.1757940353799;
        Mon, 15 Sep 2025 05:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG41a2TkFk5ym1ZrQRNSb4lWvtFZsvmMn4u1jpHI4CBoULtQJbND19JSKtPPciMsBOW+4wvvA==
X-Received: by 2002:ac8:5914:0:b0:4b4:8f6b:d243 with SMTP id d75a77b69052e-4b77cf9fbeemr160254331cf.7.1757940352627;
        Mon, 15 Sep 2025 05:45:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8211besm26346801fa.40.2025.09.15.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:45:51 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:45:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v11] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <5kjgeb2a2sugm34io7ikws7xy4jroc7g2jxlrydfc4ipvdpl5z@ckbdxxnjoh2d>
References: <20250827102519.195439-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827102519.195439-1-quic_shuaz@quicinc.com>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c80a83 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=dMowEvKKoQjkIwZx51sA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Mt6ckE_6xs-DLhguz6bB8TclyPCPnoTn
X-Proofpoint-GUID: Mt6ckE_6xs-DLhguz6bB8TclyPCPnoTn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX0sp9NxHAS3Tp
 tVGyqpOOmficPGbpyiCYKBbbVKcN+9DIq2muo6/xdaRTDpTpsabfm9dwD3EHR7XUnF6KfgGyOto
 t+bg0j9ypj1n6M0tFQebfQsZSHfJhzkJ22Q6Pm7n3usBLGw8oowsBlYpL3RlzcaQeOK8m9YtbEh
 yt71FchelrODkfETBowfRLyCXJWzEZMtzM28o8RPO8iLN0EN9Up05q9mQdfv9KqQpT+KcKni99s
 yDVhTAJhZ2/xlidgnOPxZJPHSORV+gLjD+cKjBJtHQUBVLpxFCIj4F18sI3iGhpHjeRZgOzii42
 d17LOxa8lW7J0LnKeH7/030xjKhiyOqXZXF0hk0H93NB0ELo9lMdwhofPNryI9JbWSxBIenw+LG
 /Yjw3cVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Wed, Aug 27, 2025 at 06:25:19PM +0800, Shuai Zhang wrote:
> When the host actively triggers SSR and collects coredump data,
> the Bluetooth stack sends a reset command to the controller. However, due
> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> the reset command times out.

Why? Does it apply to all platforms (as it seems from your text)?

Please write the commit message in the form that is easy to
udnerstand for somebody who doesn't know Qualcomm _specifics_.

- Decribe the issue first. The actual issue, not just the symtoms.
  Provide enough details to understand whether the issue applies to one
  platform, to a set of platforms or to all platforms.

- Describe what needs to be done. Use imperative language (see
  Documentation/process/submitting-patches.rst). Don't use phrases like
  'This patch does' or 'This change does'.

> 
> To address this, this patch clears the QCA_SSR_TRIGGERED and
> QCA_IBS_DISABLED flags and adds a 50ms delay after SSR, but only when
> HCI_QUIRK_NON_PERSISTENT_SETUP is not set. This ensures the controller
> completes the SSR process when BT_EN is always high due to hardware.
> 
> For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
> the comment in `include/net/bluetooth/hci.h`.

Which comment?

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

The whole commit message can be formulated as:

On XYZ there is no way to control BT_EN pin and as such trigger a cold
reset in case of firmware crash. The BT chip performs a warm restart on
its own (without reloading the firmware, foo, bar baz). This triggers
bar baz foo in the driver. Tell the driver that the BT controller has
undergone a proper restart sequence:

- Foo

- Bar

- Baz

-- 
With best wishes
Dmitry

