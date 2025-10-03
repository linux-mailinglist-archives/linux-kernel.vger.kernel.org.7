Return-Path: <linux-kernel+bounces-841770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3281DBB8329
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA9BC348533
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1628030E;
	Fri,  3 Oct 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFQqKnzp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A327703C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527078; cv=none; b=C9LAZHcgjBfBgO5rLu59o1fgfDkNJdoTUm6fo8k9F/UO3uDysnlF1JBPZ2qZE5UJOPJXoTauP77Ht1vcmzSRXE5Ku9vQ4TJz+QaNR7XICk93kIDC8pfWn1A+GpQU//fg64d6SjBtLI7z147MII5p4FS4REfZBmpEORpyo/C7oYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527078; c=relaxed/simple;
	bh=SBy6k5wn7OOCnn1aCmALHU0oQquC4fvA6Tw45eKJThg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eP7XVejXqx7TdheipIXekSuntyyu33jylVRbU4hEfwXv5IBtN0EuC4RyotMdn8bVK491raBRhYg5XfzS9mcf3KTcjM+jazHA+Cwtwn4gWwmTXsEfXL0wOY5P6uDKhHGSH/grT8priGpznPhk4+3mJ6vUaHNHP3cQOCyQeNL0exA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFQqKnzp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593D7NiU027601
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 21:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XlsGbOm2FDLEFD7aIg4S0aSC
	svAffT34aitDj5CRKdA=; b=KFQqKnzpWU9gwC9tSWH+wVcwRskn1tYwm2z6wd8I
	mpA8EGyplL7SNfkgA4qW9tOCChfC5MRFo1QwHUK9iRrYi/2nykfZuqQW7qbRE/Ak
	Not1y19Fo1J1PSycHwMcTedCXCbxBO/tTpvpsBI0jzS+Urt7jTkveFOdGBHy5tmI
	pM8wTv5y+QRqMjfm2teUdrjVd+1ZWMKCGaKBxIddAWwYftaL9gkAtXvQrekEwmJC
	tpYU3yG6G3hMElZhWCoXksObUfoHGAp4kjSChOlm1pvdCmlhD4TWol+Va/dpZNzR
	900wkqQ1G+WzA0ONyG3RcTtApHpykvNXRiFz4fwpyLOdXA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851v1mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:31:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e57359997aso28047031cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527075; x=1760131875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlsGbOm2FDLEFD7aIg4S0aSCsvAffT34aitDj5CRKdA=;
        b=kwVUX74ykqZaEioNiNFowDYtkceH/sAK9pJZgiukMKylfYRpt9cNaqR9+vLn4P5bGg
         uKJMm/yYIAmhia9UQkNx3AIeQbij5vE5MASjFvrXi3IC70fMLjbAgdg6KZMxkt0JrcT4
         g18PX41yKPvCEHNSR7UURSPnx8ztX+34I37xMHup9rxZtwmNsj+opJhXBJK7mZfCckMn
         +i4DEJjXBeD2EK2hSpMhep5ZcEp6xwxc5nQJ5itSQcCCZsb6tNEa+demezxpNkry4Kix
         OaO02TS3hZXErPixIjZPwUFHVl5S+O2mk3V/XMj+OhxYxB3qD6HYbg/ATB945/J9zjqu
         iMJA==
X-Forwarded-Encrypted: i=1; AJvYcCX3lX5MiOpwVBmaj1yXLfVNYo3dguG7y5FN1Wbev+QNqfQSKKQZFuF+pTDEj/UZ6SPYRiW4/4Gayiby1bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTm7MI7hirjM6edT1LASJE60xES2TGtYIvXggy2occHiF8f7h1
	mYhtIDD5EXy8mZlU63yAAN4FDTMdhczoVIwDzKkl5ttI0CVzMxQdpnUz/L982tkMQ23PIiHiAu8
	gZJy/1+G53gpVfxA77ywImSixD3Nzh3LwTACpVowaYIt1Xed3nseziLoXvD2MuUElF/k=
X-Gm-Gg: ASbGnctLV+Xf5jAREO61sEGr6R2yVHTNuCH1FwXdfyIQxdrJPK66CCEeWmOChLBISJD
	/CE1GDdiXfMHDPuR7984zx3XSAPz+1pQ4NPToQJw3SgNg5cpqqC6Si4qeLxa66qM9maGiHyEo+P
	udDHSYAfeMtI+02Nne/4cIBSvDvaQnfe8UcYoV9vUb/0uMpchIuU14ekxrr9Uv+58/THq8inuI8
	JMTZo3h/3BSSxP5BOtJVXNGyZMTP8iu3UmBZu0faBYhmMtKGKJOirZ9m8YVWqTthtyEZ5N4j8Qn
	+eVQ9Uep0/cZNhzELiReIUEzg5S1eJ0W2fkqDVuHcnVFhd1fTJ7CO09SFyUtvsnYoFyugEBXXr4
	6ssVi4kxMrf2tdzzHfKTQQgzPAcUbCGfpRICioam5AHz3alHSkx6lGHTTSQ==
X-Received: by 2002:a05:622a:411b:b0:4b7:9c98:aed6 with SMTP id d75a77b69052e-4e576ada47bmr67589871cf.41.1759527074548;
        Fri, 03 Oct 2025 14:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2/BooBrQE17txVLgWwDz4q7+nVZv+viuExfysHyo4YY5i2nM1gor8h+dIlgtCUXqJYtQPAQ==
X-Received: by 2002:a05:622a:411b:b0:4b7:9c98:aed6 with SMTP id d75a77b69052e-4e576ada47bmr67589351cf.41.1759527073911;
        Fri, 03 Oct 2025 14:31:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141752sm2190199e87.58.2025.10.03.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:31:10 -0700 (PDT)
Date: Sat, 4 Oct 2025 00:31:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 01/11] arm64: dts: qcom: sdm845-lg-common: Sort nodes
 and properties
Message-ID: <e5ye5qenwdvbwihqlywgs7kxx22y42vvq2li7gqvr7vqoqsxu4@nnizx2q33s3w>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-1-b14cf9e9a928@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-judyln-dts-v3-1-b14cf9e9a928@postmarketos.org>
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68e040a4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8
 a=JkoFm2tBDPzt1COVDkcA:9 a=CjuIK1q_8ugA:10 a=5XHQ0vS7sDUA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX0y/bbs/LAxCh
 KNa/G+1iOLhPL9V8HkNPAHzXZ26nLm4IqrCG6IgFFKbyFQeb9pAiYIBVmoaHF03DbjlxPPYLLRM
 BnhmWVGSOS4noEvr5zcj3pEDr8lqLbrUxUO8DOc0qKKaBoUW49y1i/oG2siz2IfIc4GdMR5QHLN
 CYYcUcwTqHFeO9PH6JzhsWsSxevaaxiJQsmvwVObGE+mgsgoMnZb69UUgxIhAXsti5mBMaNv5rq
 z8sEodF4QLNh8V3JmcNLaJJSdGCrnpnTutBAtu6O6+Pz4lJwPjREWKuUhFkg8JKtgviWN6Xuv5b
 MX1k137XY2NnzwxBZj9TvR++Ef8GDthWkMWkuUnMTl0wRypv9HgHXd5vVLMjrBTvrZz+hx033u/
 +437ihmMIKjMDaYMtk3jHAgQyPA/ig==
X-Proofpoint-ORIG-GUID: XMiQ0Jqk2QbRkU6FQlm-jAftMA3uLu5f
X-Proofpoint-GUID: XMiQ0Jqk2QbRkU6FQlm-jAftMA3uLu5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Sun, Sep 28, 2025 at 10:05:24PM -0700, Paul Sajna wrote:
> Improve adherance to style guidelines below:
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 124 ++++++++++++-------------
>  1 file changed, 62 insertions(+), 62 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

