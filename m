Return-Path: <linux-kernel+bounces-736615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE461B09F87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CED1C46522
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971F29827E;
	Fri, 18 Jul 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yryr+SyN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A04298987
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830793; cv=none; b=UvSu+IQrdMZHZU6CQ534aYAa3nTlAuaKta2MjM028yPO2ZXqxdckLf4ZqpFl7orzLJ1df4/rM8s4V8H6wyoqCvqzg+PpIdUC3wUzYP/mlPTceuPNqCSLk7LoPpcJmVqKte5F8xTPIu41J3yzxeiOpn3TxZlLW2pI0i+hKhsW6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830793; c=relaxed/simple;
	bh=smS1OUgSzyUIU0rtJExIYiq4cV0O0jPRf2zTTzbUCgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAXJR9E78yq/bvzvMbpNZdjmr1txiqjERJsfvm1rMciKkIbBbyN6dZf997GdaNWt3tM6Uzi2AyZ5HT/uQZEkfzTD8iRCLmTVoe5ljGdAMgT62xFpON9QuH4DclwRJ4eQatcTO53rt4FOyMpKAEMfpmAWjVdDCIqD5CJkoOZuR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yryr+SyN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I89OHC020662
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	COoiyLtsPRDlOGmj2f0fDl3bkCfHbow0lzqZhkT/2HI=; b=Yryr+SyNF7Y/9D6S
	6gMKQsrrWdxVdG9IfnBC90Cuhc4tplEXzE2U5NoRa0Q0bKVYrwTFjJsemNOwpOxv
	pepm0F9PyOfLeyd0ROf5CQtFNKgbiLQ9i3R5DmkW4buhAVgaa/jK/SYVtSImjvUi
	cavRR87EQ5uM8Ib1y/uZrTsWbHyF5ZJiqDoaIi4ABya6ABVNF8FNCXoTqhQDSkpY
	3/3S+7nLe004t5+MsDz1y5ES+5cLJ700NOjTPKJhTeM78YJl9xFNt3i7oCEjMT8i
	zvKrlmzfod5L+8ieBSd+XP4GGWf215q2MhtcFdmwgABlji77IcT80Uw85A1dtRlb
	05akZg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpp116-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:26:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c955be751aso254680985a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830785; x=1753435585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COoiyLtsPRDlOGmj2f0fDl3bkCfHbow0lzqZhkT/2HI=;
        b=DOxHSBkdAH9CWF/cq3uJ1RdZ0a6Q8jQObRNQbMpFe01xX5buYriwReCb+JcGGCwW+/
         WozR70O6QQ2AMsR7IwhmE9JDVyWzkvxNPyQ76BEbnOCmec8mJnPwYyMUkjrV8uInMmwY
         x44vrsjRMS8Z7MCi9u+aG/9+uJkUD3xbQOTVHZInARtrSkn7tfo+ApMbkoaLB8Ia7oc6
         fUlOTq3s7ZulPapbRlFYvIae8hgpQ5iFUqrxcpHOPkntpusnIKqG7XIuH451S7r63IL5
         9d1CPDTrgjyvHpEXL2aVgN4Sw/xPNvRVGRjcBuRXN5+fPVVs4NYCRgUcss3d3DYtoN7O
         BmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/8+VFg9ALbc0MspDYOu7tumGjzJavQzJnIYxw+F2Dg3XeEk15XONoibrytn53DxYDN6rAIOJtbRHW86I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFu6+6eG6T4WsQB1rd1mbJ8dWS29fc0/48BK55brXvZlGp+cXa
	uEO16duu1OTL8ioGK1RycQY5S3YdZq2LPhy1PqPjOksHpGoAmPxF0FhJY7q6Pqb3OwEBHO/kNpm
	2uyWstrdgHEf4HmDU5vybl2hT936BLPQ0oygFeJo4zeIEN9IXo9MySllLrBYSPxmNcdk=
X-Gm-Gg: ASbGncsix5Lu3HMebApRVEZpEosjlQc7+Q0mBu7EtSfM86LPWVf7cGw9MY07vCch07B
	zsK8vp+6WJRDbs2uB2jKJ0UfkMdOa/GI80U9Y3vAjqegs4/oMnMsTutbPOqAW3ubEsvjFT4eaK+
	lNtAm6I1+A7j6826gdqU4GuuHhjFpMJIz59U+lczDDWzkk8nHkDC2y17BapJVo5ozisXfhLZ53V
	1rD8JYI59/yuWb+K3bB+9zjC0gtC+idV7Em8st+VfXNij00UxoeiuJOMqodjvK+o2mk1BLIEQ2G
	54AcyuMk88UK9zE/21tDqRXkOYKGnTaz0MTVNzIGqpwE0jME2N+P0b4rnZVuJx3sysU7jueZbs4
	kuc13oh8O7dBi2oAVfALQ569ck6T9oYyVBssTcW6cWlTcdsjjL/+q
X-Received: by 2002:a05:620a:6904:b0:7e3:430c:5e0e with SMTP id af79cd13be357-7e3430c62femr877497585a.18.1752830784297;
        Fri, 18 Jul 2025 02:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0ULvdLv8+JBhbfjsjnyFteMc4V0YqUWrlV8q9vEs/1OYuftM9PI5a+ZhXXON7UyumHdQcLQ==
X-Received: by 2002:a05:620a:6904:b0:7e3:430c:5e0e with SMTP id af79cd13be357-7e3430c62femr877495585a.18.1752830783799;
        Fri, 18 Jul 2025 02:26:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9bb43sm186031e87.32.2025.07.18.02.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:26:22 -0700 (PDT)
Date: Fri, 18 Jul 2025 12:26:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <rsybfhs6bb46putaytvp4tikauvhynhsam6aufxaflo6vkvzwh@qrh7sm3g7i73>
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
 <b4nxjsx4fu4xmookpxukumw36wlcpzelh6axjucqe4lyswptm4@kczsldalq53n>
 <822af9fe-5db0-4620-8f08-9232c608d443@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <822af9fe-5db0-4620-8f08-9232c608d443@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3NCBTYWx0ZWRfX67LDJ1EqyUSY
 w8/DOY1S4lVjhL1qZEdmYcumLZLMfGQpYf2MgZmSq5MwesncMSh7fSAMVP0L2KWCqHTTo+HSXYx
 d15TeELKe136Aep5R5sQRZXcm1kWavRFmZaqlgBW8toOY+0yIH0yOX2XIWTT8+ueCx7TdTo0hao
 lJso1r++km+XnIvr0bpKe8eWde4HtU49m/kr4VjzxcH4HaiPA8aiGT2BTMMNAIgyzRdMzm8sq5q
 bg4YIbF30XnSj40iz7Ja+zdoBEWRjmuah0/zrw6SJioETJUIV8hLsl6umoIUVx22hR63ALpoNv6
 d1cKvqasiDrGzJDmzreYUBsiyTECZo6MdIbICE4LynJWbQn/KqnW359I+8BfGC1i0eJ8gQ6mtXc
 UxY8hrYDEZwqRFa/5REjV2D/mzAfbuzbx7lxTjQjXPR3JOOmQWnE2gLlw5T8po8erGDl8ETo
X-Proofpoint-GUID: V32yV0WprM73pqXWY6NC_ahLPkhsuAOG
X-Proofpoint-ORIG-GUID: V32yV0WprM73pqXWY6NC_ahLPkhsuAOG
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a1342 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=H507J6Sm5dMqOWlkyu0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180074

On Fri, Jul 18, 2025 at 02:33:50PM +0800, Yijie Yang wrote:
> 
> 
> On 2025-07-18 02:52, Dmitry Baryshkov wrote:
> > On Wed, Jul 16, 2025 at 05:08:41PM +0800, Yijie Yang wrote:
> > > The HAMOA-IOT-SOM is a compact computing module that integrates a System
> > > on Chip (SoC) — specifically the x1e80100 — along with essential
> > > components optimized for IoT applications. It is designed to be mounted on
> > > carrier boards, enabling the development of complete embedded systems.
> > > 
> > > This change enables and overlays the following components:
> > > - Regulators on the SOM
> > > - Reserved memory regions
> > > - PCIe6a and its PHY
> > > - PCIe4 and its PHY
> > > - USB0 through USB6 and their PHYs
> > > - ADSP, CDSP
> > > - WLAN, Bluetooth (M.2 interface)
> > > 
> > > Written with contributions from Yingying Tang (added PCIe4 and its PHY to
> > > enable WLAN).
> > > 
> > > Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 607 ++++++++++++++++++++++++++++
> > >   1 file changed, 607 insertions(+)
> > > 
> > 
> > > +&remoteproc_adsp {
> > > +	firmware-name = "qcom/hamoa-iot/adsp.mbn",
> > > +			"qcom/hamoa-iot/adsp_dtb.mbn";
> > 
> > Is there a significant difference qcom/x1e80100/adsp.mbn ? If not, can
> > we use that firmware?
> 
> I believe there are differences in firmware between it and the EVK, even if
> they’re minor. Therefore, it's better to maintain a dedicated folder for
> each board and move the code to the carrier board.

Then it's not a 'hamoa-iot'. It should be 'qcom/hamoa/iot-board-name'.
Please submit the firmware to linux-firmware and also move existing
x1e80100 firmware to the 'hamoa' subdir, maintaining the compatibility
x1e80100 -> hamoa symlink.

> 
> > 
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > > +&remoteproc_cdsp {
> > > +	firmware-name = "qcom/hamoa-iot/cdsp.mbn",
> > > +			"qcom/hamoa-iot/cdsp_dtb.mbn";
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > 
> 
> -- 
> Best Regards,
> Yijie
> 

-- 
With best wishes
Dmitry

