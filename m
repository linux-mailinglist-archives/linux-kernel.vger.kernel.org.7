Return-Path: <linux-kernel+bounces-742392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F0B0F121
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A187A6B38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5F2C1581;
	Wed, 23 Jul 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nqbvgm4z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E4279DDF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270013; cv=none; b=tRVh9xuBR6kVS+rIcu433P/0fLDMPCG7/o+7bPUKz0JPYFi8BjhSv1ZLcdOfhUt1LJmcx1L6tf6VpklaKPug3gCquNh8bfuZbWFRBqdFdwZw6gBRakg4Kx53asmVtlfFgsXYyoTinKso+jXi0wCJnDOcy7YnxcDSGbaV/zl9oJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270013; c=relaxed/simple;
	bh=DVfLmPAW/+LES4M6qfek/cSAyxf+7zdrYqLo2qRajDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pApppowQ/NF+em9CpjFgWiFZO8P2yokYRRSaeHbN2V1a6Nir+a1EqeyqO3u0YoPXTY3rdImN7UdL/J6xzrBHoMJ94Kq702MOVMw/ihAPug/uraPp6rp7X+nmd024gZ98JGZaANdH6aYvxWIBzQL9Fhcy8q8pYKOfxd+QFhSIqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nqbvgm4z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9K2Of024755
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qjEm6Yo2vInyDtUzOUPiHjkggFV+IfkNgBwObWNLpNA=; b=nqbvgm4zYdqaje1L
	dGb0gBUarxAyxSdWc5FcOT3gjjhsomAOcMoYEC2I826g+eQtidVcKfzNG4sgdK7V
	xMoXVQwPTy5tnPAhzcuulBDrLeMb9LlozghHM4BD7D1FOVJN1IfN49tgX/83z8hg
	7SAgn3wO4WLQNnYeEG/b4lb6MaJUKChAf/s8udJd/6nQIHW/wdM/o6JQrthrevcJ
	9Wadp6UUL6SJOtQc92j5DSv0v8YLV7UkpTZ22PsqI2C2GBFkvQwGrzDph3ukdYni
	aCspHXki0oRxkmrH7dQfanhfbXRuNBkb/koHoV/a1mXwKWL9VDJukwRWFQm9wH/7
	rBVaVw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dmsh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:26:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fad9167e4cso136847736d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270008; x=1753874808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjEm6Yo2vInyDtUzOUPiHjkggFV+IfkNgBwObWNLpNA=;
        b=wBpEfj/LNP7DBqYcYDgpXdtTfFO7Jy87qQfgQ3/vdYFLr+rUSXqVbKBLawd8MA8kot
         vvQCRtRbzZbbe40G4aRnN8Pqc0fBgKEGwwf1s/qmv6HUSIhg19aPz8cWE4IETKjmBd9Z
         xRJ2ltHx/oHFunqJM1YtEcJrCDL7bETAS+HNhe8PZiwADfRxIvJLUGWeA+yT3/9SP3G6
         idrxn3BkFHPGIKmpBZ3ULyBkI0b/n7151fu+4iLvxjU/YMEin6kslGNtu9S/gwDU2NE4
         wsv17ZYaX/euG1v5KnQ/pIkQWA1yeFoS7UM1OaXy75H2XuuokbhIwrvjnUe5Z9PUc5MB
         TeUA==
X-Forwarded-Encrypted: i=1; AJvYcCVmIuN2qlRuiy0QHq5bc1ga1YOXm+ilaZ3TCdBDoHKcU+O/azAaZOJvtjbOaaRy6V/22kuUEd4bFjt1x0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnx9/rZK/LoXUP6m89lEiWJG/yygJ/ySV/UHn9XZWowN8f8p+
	QpuHSkf0M9CkA0SKMww9tQssJOfuJJdg9HbfhhcMh4Nhy3TGrVu2o0CGAlI5EfY8QXHpzUD94w3
	Hn2Ksfy/0QXiTY6jJMqNLJkQS1c3saUmapyRFotqKVKsBEgUwzMWSiydyxLdGv2RVe24=
X-Gm-Gg: ASbGncubpRhpov1cCoHCtfecOWY7FBGXu6JLvqgEwfiLiJEEp+6KWUJ8RjDIz6GClq9
	Li5z4F/RZxsbAhW+Xr7l5w7CUUThH2T25gjklbym3bgxKCNtMgNPD8PmLAJxhDVlMkMpiFuRCuZ
	omaxO6pKLPdipFeVOtYTou4yF66+dN8MahQjjeMXaUNBFQf4LAaVFyxnyVmfBo7dRX1kFAv/Rqw
	QoSvffBD33wR/gE5zWvGfcEUNvWAhYpqUVvZauYsjnvrzskBucza0O4r2U/wd/AGlTxufj3joJJ
	vZ2DjpnhkUkZK0MOttFeiZhVKXk4do4I6hZb8oF+S/G4Otz88sYnbADcCKpMxz0E+IAcsbSTbCB
	cyoIaE6HEAtDGZu4WQoXjBbiJg4R+iYEtaKHn0cQ5HRmInI3pKzBF
X-Received: by 2002:a05:6214:2623:b0:704:9b5d:ef4b with SMTP id 6a1803df08f44-70700644a0cmr37371936d6.26.1753270008106;
        Wed, 23 Jul 2025 04:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC9uMg2OkvtHo4eZpZkc4XSkLC06Egfy/kS8G4tkWNRgwyZcA3jTH31NhXhbsVPCWqL9XHfw==
X-Received: by 2002:a05:6214:2623:b0:704:9b5d:ef4b with SMTP id 6a1803df08f44-70700644a0cmr37371506d6.26.1753270007671;
        Wed, 23 Jul 2025 04:26:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4be6fc33sm487064e87.209.2025.07.23.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:26:46 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:26:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <miiod6ft7iavg64q4f3uwcnztamgvt46gcguean5atsqi5d5us@xrwlzznsgx2z>
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
 <0f9eebfe-21f8-48b8-9b49-a35126aa6dd1@kernel.org>
 <67ca3b6f-3cd3-430e-886a-0443f6d630dc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67ca3b6f-3cd3-430e-886a-0443f6d630dc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=6880c6f9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KIACOVvSgbhCfpt34z0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: LIooF-TU38X0r-jGMxB1Qydpzf3QThyh
X-Proofpoint-ORIG-GUID: LIooF-TU38X0r-jGMxB1Qydpzf3QThyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NyBTYWx0ZWRfX9bOnl0iqYDtE
 eObfB+XlsXJQ7kBeTgd0ZOn1AtPh2irO0mLumqinP1sVeOW+Fzu/zR6IMNfW5LGtUiVtmikGf2j
 xAoZfKQdk+E6XO59lLnMAV1CERCNOhenshSUG/KGBqUw7tsm9i8is++2MfldAKRoCLxzDQ9C/Xf
 v/nueCEmd3zZmhUv/1eGM0c4JSeqCa64XdtpEoLOSmBDbTKCEGn7MoJVK8opoYSstp3MjLhTQwH
 FLruUMTXePPsz5+Sm0obVAl8FSEvDPYNqZg+jnxigwO4YZjPP0pvFKZ9ZzG4pTHzN1UUdU2Zyha
 VbFV52v2r3ENqQzSLq9kfol12CVmzmxrsqLrPiyV51GtzYCi8U5CsHEMf/MUB6K0BnX63ZYBnkD
 Uoek9ug0Iz0o4rZgdhUSu5k5aUJS8F0Vha06Yr/8wC/qjwfyINRzUDxpcVpaWZZUDdvoGsky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230097

On Wed, Jul 23, 2025 at 02:44:14PM +0800, Yijie Yang wrote:
> 
> 
> On 2025-07-23 14:28, Krzysztof Kozlowski wrote:
> > On 16/07/2025 11:08, Yijie Yang wrote:
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
> > 
> > As pointed out by "arm64: dts: qcom: hamoa-iot-evk: Enable display
> > support" this is incomplete. Adding new SoM or board is one commit. Not
> > two. Don't split board DTS, which is already prepared/ready, into
> > multiple fake commits. This is not a release early approach. This is
> > opposite!
> 
> The inclusion of display support was not intended in the initial patch, and
> it was not ready at the time this series was submitted. Since the display
> patch set was not submitted by me, its timing could not be controlled. If
> preferred, the display-related changes can be merged into this patch in the
> next revision to maintain consistency.

This is neither merged nor accepted. Please squash display (and any
other possible forthcoming changes) into this patchset before reposting

-- 
With best wishes
Dmitry

