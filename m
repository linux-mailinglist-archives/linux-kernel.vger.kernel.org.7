Return-Path: <linux-kernel+bounces-841959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149BBB89E8
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 08:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9BF4E86BC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 06:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A88A21A459;
	Sat,  4 Oct 2025 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aaUBB99v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3201EF0B9
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759558711; cv=none; b=fkgrFf0Ugy1XXsVV56D52IjIQWhUG6v1Du23aZeJIVgHP5nqT7wCGlyHM1t4ROPQ0XO+7NiA2cbMn/8VJU83yzL9ek96SqurpO9I0p780Fgi1nM3na87vU6JyFATFAbLO8XflnIxjYFetiTzB7SrNv8/8uwvmbSopYN/W5+zPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759558711; c=relaxed/simple;
	bh=Xb7GbdUMgeFO6hGVfbM8PH1E1ogGhUzLWkc4jXBM0Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKKaCVnS3Oyzl/7N83+IQ/ylnRtZoJxZjExir6LPNYZEcPMpyQiRqM/UvrGzv4S48StuDq7egLQ+HFSnp8RooBd/LbaZElqdxfqMONqaB9AaT8DrTAO2O3DCr7iK2Zig90Kl9LwWy5d2ZWfCQoEgQHbgTm+A7HL1KZBFID1D0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aaUBB99v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59428tft005112
	for <linux-kernel@vger.kernel.org>; Sat, 4 Oct 2025 06:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tREHhzBNqaNszskLCqYldCZ0
	jlzI/Dwijuz01+c/GDg=; b=aaUBB99v3DLAUpvqqGdBj9Me9Nnweq28bOfRNTBU
	TmjVXBCeiP5z1vUs2/yZNjXSXXa4PEv9P7QBrcyxba4ef2KcT46Bxo1ge09Ni8ms
	OiP8im9zc6swVzUcRS/Lg/Y5RpRJH3yEo+nJ1ikmrghWzNzve7WLjGaiMbqsgpc4
	H9dfjdCSueIR8lFTmrBm4Pr1wH2bPUVbBGpcgCFu1UVUBk6kMNIGTeZ0MGojfPzy
	LoIS5IBmiaXh3gMIo8KouP/LKXvz7Id3retugloLEllY8pj+nyqdV3CtvK+W1py2
	4WqAA8j7fXXi5iAQs8+SmV7i/vGp1AWZicG7pp/zcXGhnA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthprb0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 06:18:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e576157d54so40947341cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 23:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759558708; x=1760163508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tREHhzBNqaNszskLCqYldCZ0jlzI/Dwijuz01+c/GDg=;
        b=b6wcgCfLzNp61YgwSnk3rhovk1Da4fQMHWupcdz3Pi96h5+/H+at0JJSra6jeVdN9B
         y/rGFktPDZPE/Nv33ZXMkhCVIgBQyZkOkGN+7Q7t33IF4S/8yF6rnlA676s7G0ToBswM
         0ltyhp/Z8VqKPXUqEUPkj/Ug5y8PhFgGYd1RSCvXbtbq+AfH5rjWbnCrEUefW1KfDsZv
         wAuQkMBcwDsNNd0rv+k7Apt8DaIJnrVbGh4AHL3Yc30baXBun4YriO3UU+R5SLlvufZb
         b1fazIagiARnsWVbrrBkn2fwuvFddRBH+jK2ROlOPHZBFkr7tatQmr4oT4QE8HRk8dsE
         r1yg==
X-Forwarded-Encrypted: i=1; AJvYcCWOC4acWzda/7Fkgt5dwFZ+RxTmCeL2fX2u3S52OAXgIQVTPP7oCA9FkIHoB8bR5DDxHiWjn1x8jSrc07c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmb+CMadDVeeXIeHApcRG00M4GapOlSmNU69gmAe+fJm4rG6ey
	atXA6FjHmwpbu1TbHI2q5KXiqo1UVjLs7qid645GZlWetLdN0r+023oBjjHUh5JM5l6nhmnFnyj
	Sgvf59EshzGgQD0d9BKnacA9pRFiIxFo87eEat5y9oQK0gGGdGhwphWhMxEdFEW41Wf4=
X-Gm-Gg: ASbGncsuSVdb3o9C4TR2mEt5L5c/iHXB+C791kJiuVK1GjoC1+QFd1w+o6LwXPEyyU/
	vnDy9+Ov3sZi+pqHjqBzD40UFPPXbEzj0oUq3r69t5thMFDP0zh5xMCmJVYy+eEX/xP8e9kK7Ai
	pV03fevjYXTQy5B3v1X4G+1+9ugXn9w2zl8rvCKkkkC869rpI/E6LVT2UTV25q8Vn5jJd2Qqvgr
	cfUsV+Mr0b6fZbTrTW46+IKLEmba4lAhY8xZJPIR5IeyvSr0BZdobFlmABbfU1QPb8+JOh+ncan
	70U7lWGzgF+rnmeyJnBere2wd0TzZ1jdCI8KNhro3PrxY6/zZc+y/XKhiL78yWiN4CuxgflTRm0
	+zec9WoEPtBCDbemnIbUTfIa7yzQk4KKUHag5O/FYjfC2LHUk48YOF4Yh5A==
X-Received: by 2002:a05:622a:4d07:b0:4b7:9b53:4931 with SMTP id d75a77b69052e-4e576ab85e9mr66481071cf.40.1759558707852;
        Fri, 03 Oct 2025 23:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB/luGgFeuFq2gc8pMMZHls+pk4ugbASEUaLSkySS7at3hllWxZalz4bhSCVqzUh5bustxSg==
X-Received: by 2002:a05:622a:4d07:b0:4b7:9b53:4931 with SMTP id d75a77b69052e-4e576ab85e9mr66480941cf.40.1759558707438;
        Fri, 03 Oct 2025 23:18:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011a9154sm2520945e87.115.2025.10.03.23.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 23:18:25 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:18:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm7325-nothing-spacewar: Use
 correct compatible for audiocc
Message-ID: <hnphyvnervdsivywj5x3hgyuy6lhtnls2k3djd4i3z6jid5yjt@y7nja2ga3cqo>
References: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
 <20250930-sc7280-dts-misc-v1-5-5a45923ef705@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-sc7280-dts-misc-v1-5-5a45923ef705@fairphone.com>
X-Proofpoint-GUID: 76p49SWV9-1pTQMnERthsjzWGRqrsYku
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e0bc35 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=ZWl6vx9Q9smWLlo6MzwA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfX43smeU+Cpfzh
 JwPzloHmfkKg2KLr1nAAnb6rGraa34tBh32tYY+pvhIIkRf21LXD9ibYOkBgGbyEqn/EviU1JCc
 KZWrBxjdCpVfpWpBEiwGnpn3/CWh5fVmLlj5h5vNHr4iMdtlmlIayhJqZnJ3Uf8cksaGC9soIyu
 MsN0pGcK6a9gWbtlAruEYuZbFvLFHq6DUNsjE3gl+WSz44AuWH8cgDsu4jsP9o9sknwletDSeX8
 o+u99IMGLE+RlWzJfmTf/LXc7OFXj1cKvIJrwfEVHBlPcF/EGBzpdSDDFouplG6cDXzsBzAuTZr
 kPIWCJoopBp6WrcuPLvg0UgTyz+ZFOSQiRlqDMkusu1c4rtq2gyd3BwMeKkKpUBbASaiZJAPJcW
 1DfoaT/gaZSNWo1ohi6pzANRdzZ6lA==
X-Proofpoint-ORIG-GUID: 76p49SWV9-1pTQMnERthsjzWGRqrsYku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016

On Tue, Sep 30, 2025 at 03:57:05PM +0200, Luca Weiss wrote:
> Use the correct compatible for this phone with standard Qualcomm
> firmware and remove references to power-domains from a 'reserved' node.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

