Return-Path: <linux-kernel+bounces-820851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37AB7F7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE855189839A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F65714BFA2;
	Wed, 17 Sep 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l7KlTeAw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EF1448E3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116287; cv=none; b=c9PyYOD8fregiVgb/9HDYFe8M+WpMgM/LWoM7B/ggxNehBWlKQnIirhy0BDESPqWCkhDtfO5QVkcdJVp7OFMU80zfHZyBmdZofSuTV9UZvBZf1BQkvttaRQw74VoZG9vb4rCAjKprb2DekYDqe9UjM7b569swg28tHAbjmNSIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116287; c=relaxed/simple;
	bh=PPJ625NvM7eluHFld7PJ5RUi59lKn3TMrbeTuUnNf8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niOnuU8DeJfAyCM6U+n4T5Qy8B3hpGFFBsDwBad8kZr7rcVSENiU55YZUhXfoDQj8d3AFlAzUYZ3U5eErk2MACR6RtOsFyU7ROIyjnnPFODW1rZEeUlrNn6H5qHAtk+wBTDcJXUR/u/OKyCm8FWEW9nuxpD1BBGAqE+0V0VU510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l7KlTeAw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XZab032419
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w7GTRhgq5rEoNKib7SIm646B
	tucURKVp2xtEeVTevNk=; b=l7KlTeAwE8ujFDO5CgxNkSl5pqOaQBM0QX+JDmXZ
	+rloiPMN9fsw5H37KWm9XNUV4foPoiKU4RXP5gnlEBKnY+f+UTxUt8jKup6SFOk9
	loEZAwRLCdBIjsPHjBGavUgzYfSrnDg3l4s5CSJcfPScp+XBQXcTEuJOykZF/vPM
	lIgcbhEY3JsHlqhjnGTPV79sJ1OxUWNfZ24QzXdEUA9erLTRNhEqH+H3iLUZJgRA
	r2Gq3nqMvcUXBlXTXDYFotYnu8wjFNRM6xuZ+hsih7hCsrtbexf/0XTewlAusX9S
	VjEbdV//vHJrTuQgyfHZ4EsrOdzqVgdQwU4zNJNSvu9ahg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyjhmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7916b05b94bso497046d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116284; x=1758721084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7GTRhgq5rEoNKib7SIm646BtucURKVp2xtEeVTevNk=;
        b=FfWcYjX+NQPqW2ABETfKSwhv8v0r9RZxIMTwcFIa/WNuCVJNydSgjy69EvmMHi581A
         jIF8XmNihYEHuvd/i/sbl72uyNuuBrUNqFCP3vqlPro89q30SVwJ3IwJjeDMmT4fOFvL
         03FjRwYaHN7z/jSBkxWGF7nLLqA6pUzZb3HfECLBbppyLsbwBhuUpj0lIGBzeiQ3Mb+d
         ZR0tlC/KqNyU6l+pfgKpufd60ZLBFjFzF9fP28DJOVSE9qS/YrPKibnsrblY5GGIyYXX
         ahEsJf7cA2EecFv6RUfJVsSSCFDUjdAK6yBaqH63sU44TkLVmf1igRUlwTUYT7rFcX10
         sJNg==
X-Forwarded-Encrypted: i=1; AJvYcCXUM/I0Z4iPglrsqJj4Fdc9oCYcmPO4eJCzL3A0ihDpMabZ+70KEv3hbrYvricNdsvEIT0twKUJiX+Fz7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGKs93vDDDkOa0PtRA7ss6ipjPeyZ4dnhUrIsxLiSb2Gq3WCh
	qoUiqN7a80TW4xhMoDxKc7xzRQ69hdV3g/O2Hkkitj3hmt/uk3Xz6kOfUV21nfclKSSZiDhT+F9
	VcnMEnpujBarq2oPyup5qMx+FL+wrjNE0ZgGXl+vgIxi3BZpNFv2m4ybEw0IndidGLcY=
X-Gm-Gg: ASbGncvuVaBusH9IRK2az1nvUNqeTqIB0e6/KFu8DrTHsDhASFUopoDC6q5ETRYD8CI
	PUCyez+mlFpl2hm7E3GBn+tUPcAwpWTmxV3RCqvV0z9p0l8ooxF/R6EnRsxtQnED9weqbuBuhIf
	5934PQ74krDgfBJR1FGQ6MfnqFOVRdiDUL3A5plB7DHLuTSubCOEwRVmzlicqTTFDXWwKroQrno
	R1pHEi2Sl+8GGuHdu/vlyHy3urw9qQyGTzdlnYwqcnOVExMBSQkT4VPKy0ku7U+9coogz1fbL6f
	W/bJo9ZZgnXCTPdgL6FlB+5+SfQ+CVLWRtsOsy9HUbTYD1k9W+wbMMvrgls0JamL/AQd+F5W5V8
	sQt6bAoSCXGVUoa69iGnWC7og1a1qVGXdn5wwprBzFKViHyf5Ia+H
X-Received: by 2002:a05:6214:411a:b0:780:247c:4b1e with SMTP id 6a1803df08f44-78ecf4f6ae0mr18960756d6.60.1758116283726;
        Wed, 17 Sep 2025 06:38:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLCBopqInSMbBFKEwP1RvqvH8otaHG8H1R8WN+gvIViYqCYgDcJp7lOy8hiGDIKsQjsbUB/g==
X-Received: by 2002:a05:6214:411a:b0:780:247c:4b1e with SMTP id 6a1803df08f44-78ecf4f6ae0mr18960226d6.60.1758116282976;
        Wed, 17 Sep 2025 06:38:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-570340058c8sm4822487e87.62.2025.09.17.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:38:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:38:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/2] arm64: dts: qcom: qcs8300: add display dt nodes
 for MDSS, DPU, DisplayPort and eDP PHY
Message-ID: <suwpswv3jqes2mj5rilhqv55e72bgipqqq5rvhx3thhtnwhz3f@5hbktxchoqta>
References: <20250917-dts_qcs8300-v6-0-5c862aa80f64@oss.qualcomm.com>
 <20250917-dts_qcs8300-v6-1-5c862aa80f64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-dts_qcs8300-v6-1-5c862aa80f64@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cab9bd cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ggSMAipNaOlLgWN-UjYA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: NaCtpuIzkaNa2teYyNsWwQ_TibpPTI7-
X-Proofpoint-ORIG-GUID: NaCtpuIzkaNa2teYyNsWwQ_TibpPTI7-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzLTusDec385d
 Gp4IoKWK0TnCmC63hGZZSo5Tbg3sC6ijQyXJaAcj93Kzx528P7WtAled4/11mUDjvZQ3VQs+n7U
 e9+uzfYaCACLyVoPNV7TWgdwEHNUF6VPOevgnRsofu8Xpjc7xEELZDz7+VmOh2GvKFjAPPEWeFO
 ZzVRX1viQjfOsBZLqf1xg0ZlNrQBjKCf2EAIl6HYk1Zo2+BeAYMmi1zjx/jqaaPiyfiXlfeOPcY
 AJzAbhdsbMPFgkOTHoek6Z835BWEJNUf+gxTcgjxd+fw3K+VQM7pHFtll6+L5KMkYVhS/3r0NSi
 GMZu4gpeROviAfU/aWEyJHodmXVTQSp857Az+uit5bFw61qWxGnPkhFbxxijKxFcW2C8eF7pME+
 9QgOAFha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Wed, Sep 17, 2025 at 02:09:47PM +0800, Yongxing Mou wrote:
> Add devicetree changes to enable MDSS display-subsystem,
> display-controller(DPU), DisplayPort controller and eDP PHY for
> Qualcomm QCS8300 platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 220 +++++++++++++++++++++++++++++++++-
>  1 file changed, 219 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

