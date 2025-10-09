Return-Path: <linux-kernel+bounces-847187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C066CBCA342
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEF594E3B2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587FF223DD6;
	Thu,  9 Oct 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S0q/obrw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FB1C3306
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027829; cv=none; b=aBr0q2DCqUdCXF6paWfvBPUL0lmk8djMLVegK8Jhw8pzEpJ+w4Pwrom5dy+utJ0F1I93q2ml+jzeFPeoDXRfEepf9di/FCDFwq8dQYQ0gXb/fl8+cV51oQtIEzRcRP1g3z/V+WmNDbOlMzOUCZuw5ByFK78KB7NjWy3mff4t7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027829; c=relaxed/simple;
	bh=mQR4LmdMJ5AWH2DdIwZDV3SNM0G1QHD2IJtbbw11glg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEzC6Ec1/Ax5iMBAUv4lZ9rovqm2lITjUTiuIOASB4FXYp8mQgq/78Mx7FoaL48mr0OJPJRY2NEDv4GWU4EQ6yHsXJpogTr/ROXXVhyxi6M3tTe7LOixm5oEMbW5b+PUdS1J16LAaXWlhQ6uIwl7BIygjzixIlDdChlOnG0qUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S0q/obrw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599F0Du7019192
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 16:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/Z8+8ah7UIIcQ95bFrXq1GGw
	0EurOZzHp3ra6wU06h0=; b=S0q/obrwySqTy9LHyEK1stX8/lrdENdq/lMW2Pm3
	ZVwaeauTThZWRCFkJ4e4WpUAe8QAZUtU4xnoNbpPLhb5y05BLdr+9zRyIy1q7kRK
	utKaOMeiOCtFo+eyCYftTBCQ4DSNdGG807Zq4xxa80C9RspH1HcgcOdAgjE8mEyQ
	UxSo+UxRbg5+0s/8uqojx1GXRJlYTPNr2kCogM7nAgxvkwqWXEc5Y6LYje2kRs04
	7FDDMqQNSnYSk7DechME5GJ0HGM+JQM9I6GTv8pXST4uelAvUFMb9PZSkTvAY0mg
	2CWe8KQ1d8oCwh1aiBvjYVYrhrnkEB6Dh+af8s7XSDbjBQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nukvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:37:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4df7cdf22cbso92590611cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027822; x=1760632622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z8+8ah7UIIcQ95bFrXq1GGw0EurOZzHp3ra6wU06h0=;
        b=aOdwSbNFr5HiN4FYNVQnUs2Vr0YyK8Tl4+udBQlkHkTWNpXR1LhAIqXk8xUy879AGl
         94cRJf/ejjSGacn8tFHH1KU3NHO0A5/dys33BqoXRRT2IVkMvV1zfDqJ99TO8PrQnpLM
         e5unRnpJdG9Y0+A5xugXo6lvKjYN+B7QIFTERAV+Gw2c/SjiuV+ocOm5SFM0Jt1wAhhH
         iGIoBz6aVXhCuYaOjk4ufgnpWSSP94D/cZ1QgdeQnco7fRKeaIrgu7KZZACrapLKtN5U
         FpNm7FWrqBZFcXLv9ib2/TUwkNqkwBSKMeRCirjhcvaFUu265mMmqw/ZMcFEPNHbXK0v
         hwVA==
X-Forwarded-Encrypted: i=1; AJvYcCWWPfJFZH/lY5PX1+rBVIg3shoGsaJtud0qys+AX3PN4a8ifbqsDS6qolM+sgiTZMH6Z6BjGifut22Lhe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydUzZmZnqeRFrK5Xdj/MUBQHIIK9vcDI0Q9bMpvecQd1gUrL/5
	aXjyP9mqxeMjSleveUetLYk0h39A6k0ROUFF0gbGPdS+mZI0IbueYPO0epA0hInFF8qqg67mpHd
	cWgtxurqA2rsgf8gObUxLpnGfCHt02weraHqhTicrU7/jQGw6uJicGtT4WJGMYgFSIYI=
X-Gm-Gg: ASbGncsUJsg0M78mxxWavbSBPbplS1vHLRN97YhGkge8SQZTWe+fGZ1FXMlgyPXqPix
	FfIgU3y/n0Eny+paaM2y8v9dO6CRcW0vQY+3dKIXF0ObS2uH1YtAzB24Y6oWVOnaPS/8wp4dMM1
	kWgxfH1xfG+ucEjzNVpESt88IYRTb4VpmVWLEiSBBRN3caS+MZQH3Atjx8nbWs6c++Os4NF44OE
	KxNWpgBJ5TKvqkCfh8bR6U9QPcHI+n2i65W6Wbq3hcpbKmo2zcIAElE5Km9RUlc7FEd+8mmq2bm
	PvC5hzxhySmqi5jw5R9ZDeS/rtAg8lfh4GGut69u61NevsoaU+KmkNZ6FWmEMBEf05vPh2HuLrt
	Q7A/l1XfjGrJIFvh5/YqgCipmsmVFhaXdWyKs3XogsyNW8Z6bZaZ1vvkFwg==
X-Received: by 2002:a05:622a:1188:b0:4b7:8a96:a623 with SMTP id d75a77b69052e-4e6de869e47mr157030251cf.19.1760027822110;
        Thu, 09 Oct 2025 09:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUNPLQ4id7eCj32iE5wNgvbzm87fPLzOkBCehs/USBPXUezx40RFlM9A3N33fdQkoKVSrimA==
X-Received: by 2002:a05:622a:1188:b0:4b7:8a96:a623 with SMTP id d75a77b69052e-4e6de869e47mr157029731cf.19.1760027821629;
        Thu, 09 Oct 2025 09:37:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac1f34asm1179006e87.43.2025.10.09.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:37:00 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:36:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@lucaweiss.eu>
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: qcm6490-shift-otter: Enable RGB
 LED
Message-ID: <z4gga2ewuhbu7djvlj5xbxyxbxuqzsfrr37im7ffrkah7lw7lc@v4masjarc5fi>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-5-5bb2f4a02cea@fairphone.com>
 <rnlkxpm6crulpvfleclkszio2fms7t3ulc3rpsdozteml2bak2@zvfuyc33ohez>
 <045401ef-3a39-4b65-9874-0a0086e72325@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <045401ef-3a39-4b65-9874-0a0086e72325@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 6Phpt1J62j0VB2-IS6dpfF2GQRN9zvxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8HuTLNBJ4dge
 3cNy0zNGfn+7DxMdvLde/59glX92+AqaoioK1SJTMQ/K4o+3nYHKlAvXUmTTLBsnZVVSy5wS7UR
 Yvqtn9nQcKGzL9I2Z9FnkSRRv8gvK9GC+XVCE9kzeaFxwdLA/UttWtrMKWokCG1c+5Hc5+/7xml
 DO6jPdxHVnhvS61udm7WDwEgaeLPh+sNibDqDXU9u5DFWYpVxXoGozsWr4Z2R2W9OiCBMmY27ae
 FLWIh07WRuS4HECfObgk8ntmrLNNN9EmJtml+S93N+WxuPURjoXXJ3nEOuHQqC+JzX5Myjq592N
 21mt51Sxj7kdB3qO70gGcci1VDknGmXOwKXjdNF3/+I3xjUYS02j6vgJVL8WKVU6i8X0/D+06hr
 2KIPeuIEqxNBfG6BHULQ2jP87U7lYA==
X-Proofpoint-GUID: 6Phpt1J62j0VB2-IS6dpfF2GQRN9zvxE
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e7e4af cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=dlmhaOwlAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8
 a=kLI_U5V5mifkfa6Jic0A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=y4cfut4LVr_MrANMpYTh:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 04:46:24PM +0200, Konrad Dybcio wrote:
> On 10/9/25 4:42 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 09, 2025 at 11:06:35AM +0200, Luca Weiss wrote:
> >> From: Luca Weiss <luca@lucaweiss.eu>
> >>
> >> Enable the RGB LED connected to the PM7350C (PM8350C).
> >>
> >> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> >> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >> ---
> 
> (you sent an empty email, Dmitry)

Ouch


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

