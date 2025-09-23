Return-Path: <linux-kernel+bounces-828025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FDCB93C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B979A7A4264
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961B18FC97;
	Tue, 23 Sep 2025 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZ3nCz3l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFB1A23A6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588938; cv=none; b=d4oAAuJ3HXLNk4E1uAnnZQSArUEOUJ1/m0YkQRKGC+hZZ65GDl7+KhL+paT/xqg5QRIOjfcKgcTEDuBCckCMCzrCoHICrh16C54kVtILWEKmX+RPkqTGmgSDDpBuTubwNBFhCELsWNX2CxqTd4NUHT4OqroRasU2ym4sqLgXFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588938; c=relaxed/simple;
	bh=r3XfxCtze3N6fvQmIZENh4/4/Is2JvXIHoPY2CVVME0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E0gWoGsC/IJlWAetN28rOEWH8p5UAHx/DamdMR/JVBuQuZXf7P4CvHQokCZ365JJtKfraufcrlCkXjEBcwvae1fv+9XCqEMJW/C6yU/WOqzw/+D6nHqPa5+QTw4l+I4j/J3Zpy/wOLNjx1UfXdmS9vBRALGMMNGp4jSL+bsMuk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZ3nCz3l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MIDK9U029098
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NOb1UnHXBdMvECMo2QSGZH2wkRTlB3W1x0spXCNEWg=; b=pZ3nCz3lXzeRJLMp
	6plYcsHUyHfYocf5enSbYSuwcmM3ReJTcpMhk8VkHtfCCPOlYBMSGmagC0QgzrBO
	p19aB+hsdHgSKb1ZpYu24dYu6xdGs2+oXpM2NhShBpKlUOeRAWSz7dytaRnoBxDl
	QCbqzl4xjqnC1oxxWRcgwj/HtcBaGWy84TXDFMXLzWib6hv4rIgWqh7ZGrqT1i9r
	9LY3i75SwnaFLS1ZpQv4PzSY0CgMhpC2TZKKltMHk5Jq2Yu4E6b4tl2JLnp+yzUf
	+Y6nr8TYN+HBZM5y/Id2eCCOUbBY4BIcaNFzNk7yV+wy5rUbYL8iqCGf5jbhRbWp
	flvabg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk2gm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:55:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268149e1c28so58169775ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588935; x=1759193735;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NOb1UnHXBdMvECMo2QSGZH2wkRTlB3W1x0spXCNEWg=;
        b=KONJRINpEMwjvP/w8C76aSCYmub7GfpjKtDwgu3LAjruVQDRVDKGzNYsV0J1iVmUqe
         Tk0fWnoCUttsXCkGJ7H7R1CnXNZrFMZ9/s07CYOS1+Vu7XrONoHDw9hgjSPELrnjPPAH
         xNqefIoCDtKpeTYuIHL7kiX27ET431JwLb+ilICGyhH/p+Pnk0f13nNbKPI0YHQyTQiZ
         t7FOQvb3v3+iIh/Syg+Z7S5AUUG9vi/qKuP98icl2O2NF7VyYLkSLT/i/zeyIS50HbQA
         rdtDZmH2IWcXDzWil0NiSIdhnHZiAWH7QTdRmS/Um9DSq1cN2kmDYRZ3olWCS/3xxZro
         OIcg==
X-Forwarded-Encrypted: i=1; AJvYcCWdesU0MCgzpzsrzMYTHOyYKcN5FqfN3YvKwWvvnjVCa1A6PNtms8JMw+FjLkfImA8NYiG1CwZ5ByU1Qsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpctPRMCD2abH7G7yXwHj2L87EhW+43I4KsoH9x+dU6XaHmgy
	M3o+1V1MYsanNIHVm62XEQfvjn18yF5C+P+QIWoVS2ue+ckzvaUWfd7qMUwGRUf30QvKQR75UIM
	WlB425sFkoFeg+ryn61SR1FWc+/SpcGd+CRXY8rUahwCfMRS2e6N4XLnJppYxBdzuZ8M=
X-Gm-Gg: ASbGncvbmiVFEViUN95tlKsaSzJU0qkvfdOSf39jVVyf+pZ/6k8YbkvbfaE7kXy3zel
	ls0PMYkNtgsCMtc4aHQSZMKL19UpByeMOX7X742KDksfzVCuf0MS3Hpe87VLnp/gCb2Jg4IDm8z
	v7QSj5Hwp32cUsAVPTBfDVOAQCepEWB5MriBXCHx0vfuHDMHGaT/qSs52tl78fZdlvDLsQN5Vmv
	G/123XQWnGoyyhkXN0l9osUD3F+S/xG3oznnYjgJIYu/6Fz+msOT/xk56kpkWVrGdvpnk6vRqVg
	u48Xpz3dEvQ2fbnmluYCqi0S5ngpnOAngUvF5RUs/nXxjlDNsIxUCrn19+1BC1761hj5lT/UoMV
	K
X-Received: by 2002:a17:902:d504:b0:246:de71:1839 with SMTP id d9443c01a7336-27cc696e83amr9635765ad.50.1758588935168;
        Mon, 22 Sep 2025 17:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgkK9eoU6vOWVlLO/FmLK8aalMDc859rdHBZhi4f6aTg1dHIeLHmkfnD2xmV3V5/OgUWynjw==
X-Received: by 2002:a17:902:d504:b0:246:de71:1839 with SMTP id d9443c01a7336-27cc696e83amr9635475ad.50.1758588934766;
        Mon, 22 Sep 2025 17:55:34 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm145381435ad.15.2025.09.22.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:55:34 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        kbuild test robot <lkp@intel.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Sven Eckelmann <sven@narfation.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Miles Hu <milehu@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250722053121.1145001-1-usama.anjum@collabora.com>
References: <20250722053121.1145001-1-usama.anjum@collabora.com>
Subject: Re: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
Message-Id: <175858893357.360026.14313486300585429827.b4-ty@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 17:55:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: TmGdmRHMbkO7NlzazmIlBePI8v81odJ0
X-Proofpoint-ORIG-GUID: TmGdmRHMbkO7NlzazmIlBePI8v81odJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfXx2DitXdvaLzc
 tBBgEUk2voAWoxO9yA0DSdK+vlSG6ScLoe/RAUcok2fLIz1/oqVZ11wMrilXcekZ+3+ucs38zvZ
 2crAI2CxXbSegXcudzAz2PzDJkqI9XCYqJJNRCdSeB9JFhktqd6X/h4n9iXsTeOWOn0KRV6WxzD
 Wmrpwe27e+c9aT9SZxX+Xtf3EYyjHcfseHZ4E4rTyKWG3xAtvshzRd12rl0VwU8xPGwM/bhD6pk
 rbD+6t/bEFBmjfrT8+7HuRGoa1XDzMahVhw0NhiIF23uZxgd53YUvvTYv092bqaMFRjSo95DBaM
 uPMaAEJFKdW9k2gR1S1lXvLhslLxmwMKRgv2ZrzXgmEFSYNpAOYPPC2ebSymjJWaNEn2fRw4cl+
 CyRb6rPr
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d1f008 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=AgmplPYfmL6CJUdp4g8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089


On Tue, 22 Jul 2025 10:31:21 +0500, Muhammad Usama Anjum wrote:
> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again
      commit: 32be3ca4cf78b309dfe7ba52fe2d7cc3c23c5634

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


