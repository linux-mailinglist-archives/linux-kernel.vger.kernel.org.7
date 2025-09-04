Return-Path: <linux-kernel+bounces-800937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC6B43DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9CF7A10A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F13064A8;
	Thu,  4 Sep 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CQOpSyAM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2E304971
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994326; cv=none; b=BPu1hbqHDzIKbmpsRRkJ/qXminS+PwXdK4mL6FA5qk3gBMOvLMjc/Hy9k6hYOcGshb9ffLO8M2Jnykfs5lW3I2geBJQiRVYsw9/rPny9wSmnccRjByef9Ph2oJPka/tGVAO3dlCUSxlMFbptW7mevEqoRRjfECzHDZtljXvue3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994326; c=relaxed/simple;
	bh=zqDYEE7xs6zmmqkVqfGgw4oWt6zqxepm82BdlY1K7Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shcQ0UUH1Lh7CWWl5/t7OesZYcHiSPJHt/2cQDNRCL29+jWJVQfSEa1O+gDs55ZIKaD+eaYnN5fqiVn+8nIxbNozvYuk72ZUaEiPb9leH/XekqNB67xEaNaFFwSR5Ei5diUi7Tup9hf+9AKRd7myTWUt5MCfixxx5ZpKlb3Kv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CQOpSyAM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XEKv012208
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 13:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3li4coGXy5SzIXwPhJBRO2Cvjfz46MuwcOqco3dfBhk=; b=CQOpSyAMqzzF6mB1
	xtL5lv9x3eFcuhoNPJeo8E+ozULx6kQJm6A1QkOSBofEX50Eh22LaMjtvIG1tYsh
	KG6/knPAQWI4yy7nm/cLKltq2sPRULkBmC9/XJJC7mfM5+aEFrb2C9hhWTVozaz1
	jna/14s5If4JLxElki283cPlH6nlJDMyZU/vNSiar79CQhobeys1OErC2r1MLumE
	o7uQeXVhVH7YLxEIGw6klLl9gREJdavJEQvSkqrRXN9V1SRsBeQukvmbz3+f5lEY
	05MwS2R+v/DA3pX5vIDQpTTXU2vzSL9PfgRngqujVhFxa4nPXfCgyEh4bii1lH99
	Z+8ldQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj461s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 13:58:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b34c87dad0so20899241cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756994323; x=1757599123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3li4coGXy5SzIXwPhJBRO2Cvjfz46MuwcOqco3dfBhk=;
        b=LRFxtu99TP7MgBuDLDwIp3HO4C5R1iTXCl2R619YKLuEcyBLkrEDEo2b6xrS84m1JV
         PYg4vQ95KvCFZ14zDcGR3x67S+d+iWy3IcAMzXOln7cqyoLCjcVaMdW/9RpdNf+B/gAk
         utpPa6E0Usoa3cWE/sAuuP43V7USNRBdeEjQqLHNg2F/Pp0Ah6E0V+9qswskpeKuBa1D
         H6bYAqJ4/VVVtgi6EXzEWRp8TlueE8LXbNjJ89SO8uSQpj+H17dTWELcniJTKeOrCNm8
         z8N4hTiItFFhFrOLDcsMPcRNM4K2ihe01RrHEDd9s5sHaDgij0slt3z+8FOq40W5pxSr
         VRaA==
X-Forwarded-Encrypted: i=1; AJvYcCXimPjz3CZi/yDDpX3OSLRxFzBc+1ccZp9sW0z8DUfTIdp33D8YljALcjiisZXg9TfNBUik4z+sf0zYeJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXUFvVjmq2yLrCdArXzQMVOIKzQb+Qh+CG/P8sm8UXXTlrGpe
	BgAhsFDOQJxZy7EfI4g4vuSP1txBWoiKfh88/5XX7mq341qLCv9R4pdt1JVzUbfh0QmKJDoEDkD
	sM6j1PDy5QrRQBqbdR/Kgde8c8ppHauE9Yk7fbSq9op1M9Re0Oii34dr0hppBBKEbam0=
X-Gm-Gg: ASbGncv9wYgi0l43pZc/7CtCz4VGNSQpFDhdysDgBUUcBLVK48Imf+dfqqZmSwTni0v
	kqrycqsjP3MLVwpR+1L4w8D4g9QLqAiPLMSmWszmMfp67gxJBNY+XuUIIdrQXLufc13hBOvtRUn
	ENiaDI4YK4u9GF4owkfDq/jZYAs58pf0H8ZqeXvB8GH2OaksChxxnBGUg4Kk8xWxg02CV80zuVq
	NcmTD8Vl4dqil3vye3XPEJ1uUiBjOinz6vUn5p3+MFYOfSQbGSlkUnsAxvKLvf+CXbjm3qoDugH
	XxJ6fE9Ne9d+Fp+NuEhLBwILkqphAkuVXDpV2lTomnFfMf5wxv7YS6irKZznCXQFxxrx9GowUbO
	I3HJuAik6rVQ9DD5AfxTArj0QfVLU1VZn3qHD3ZJWBzTS1VjPAswI
X-Received: by 2002:a05:622a:5445:b0:4b5:4874:4f8a with SMTP id d75a77b69052e-4b548745167mr35483361cf.28.1756994322692;
        Thu, 04 Sep 2025 06:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBzxCSGcfklAF0/xmKGaR2pwlAaKBc2NDu1+M7YnxZA2yQtM1955eKA9b9YXi8tVVvEeD19Q==
X-Received: by 2002:a05:622a:5445:b0:4b5:4874:4f8a with SMTP id d75a77b69052e-4b548745167mr35482961cf.28.1756994321879;
        Thu, 04 Sep 2025 06:58:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc152sm1250300e87.101.2025.09.04.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:58:40 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:58:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/3] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <wturd73lfutj4njzrmatzli356cfyehbtr45fjcttmbo2pieu5@he3fnsqzumfv>
References: <20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com>
 <20250904-hamoa_initial-v9-2-d73213fa7542@oss.qualcomm.com>
 <2o2ypmxo6wbohrb5edkj27ueqpgbqhsnqu4ofzfubtfwg7vyri@mdsu4ca63fr5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2o2ypmxo6wbohrb5edkj27ueqpgbqhsnqu4ofzfubtfwg7vyri@mdsu4ca63fr5>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXyvuVySzEasH0
 /zEOFEaAYoUxL/x48Ewxva/Snq7dOImqvnMKgloUJozcVJCBhSJ9gpbRV8JtVX9SiX4HtFZDilV
 OU5oyQUU32/miMYDDpAHcVGyOY+GR8xQ66paZYUNfT5cfZ+3ytzWiS5Re0teE79v1WlawKwnbLN
 r15bD4679K4ZAoJ6qKRWNC+p/0xlHoUIzCfQPvoFREw/S0xaR9cVbDPM88Fox2JOO0OYYR9U2pt
 35cNN7bGHE8qQvPfrqJnB39oaMN8CSSuI3GWYS6YCsKwDv29y5+tDVaiHI5dUJmm1D+VZXWg53y
 X5VICNpPGkvqFX9rb4PXC2Kw9eFVnGGp9LelnEL3htqXev/xwi+CmGPKtHbuasunn7bfphBKfYG
 Bs4Aw/PF
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b99b14 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=g8UA7gJT8kHEbcL_ufAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qCcGqaRLmeUc0qbbMA6LCpzwJyGJJW05
X-Proofpoint-ORIG-GUID: qCcGqaRLmeUc0qbbMA6LCpzwJyGJJW05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On Thu, Sep 04, 2025 at 04:52:26PM +0300, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 03:48:33PM +0800, Yijie Yang wrote:
> > The HAMOA-IOT-SOM is a compact computing module that integrates a System
> > on Chip (SoC) — specifically the x1e80100 — along with essential
> > components optimized for IoT applications. It is designed to be mounted on
> > carrier boards, enabling the development of complete embedded systems.
> > 
> > This change enables the following components:
> 
> Documentation/process/submitting-patches.rst, "[This patch] makes xyzzy
> do frot".
> 
> > - Regulators on the SOM
> > - Reserved memory regions
> > - PCIe6a and its PHY
> > - PCIe4 and its PHY
> > - USB0 through USB6 and their PHYs
> > - ADSP, CDSP
> > - WLAN, Bluetooth (M.2 interface)
> 
> No, you don't. WiFi and BT are not present on the SoM.
> 
> > 
> > Written in collaboration with Yingying Tang (PCIe4 and WLAN)
> > <quic_yintang@quicinc.com>.
> 
> Co-developed-by, Signed-off-by.

After checking old thread, you can ignore this comment.

-- 
With best wishes
Dmitry

