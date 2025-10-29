Return-Path: <linux-kernel+bounces-876097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F3C1B0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA388627D80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA332721F;
	Wed, 29 Oct 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/99CiHZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HIy6A+b5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53F327207
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743219; cv=none; b=ZGCpex+lJTxZEQ2N7a8nmv8PpbwaENZ205SpNGXnpM/vQkdFavi/sUtOuwZo8rc7XOFSuS55YJyU2cDCTy1wgnFH4RMXlgTN9kMIhVKxpf3WUIKBcHqejxopcoti+o4FFwkDhoSCI2wh5zWNv73b9a4JnPPGiYzq5b257NreW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743219; c=relaxed/simple;
	bh=G//h+JjOXBDPT5UZpxOqOPfoMhpBdWmJggK6qZRESB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2cgDJkNFyU60gykdOmc4j0b8/95v2C33IUF8q7Ap200O5dMjQOLJc71y8R/FKdPNxWIUraSqU54tBJktwBlfKA0HAipr+MXYYPLuUxw2GG1Hs6KPyc3L5grnEQbXBd9RUe2l4iPgtTUS6gUne+kLmoQ2yHZJQGcJVqjVQKXdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/99CiHZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HIy6A+b5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T933XC4155211
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iCehFCqTIsIPhD3IbEV/5mwJ
	SLhbZk/VK6KiIILlFKM=; b=O/99CiHZToq9A8GaTx5rpvHl5uiaOJpNfXrYuwkb
	8EsJL45BChxcUNb9gfGGA3gFguuyAhAJu7whI6JdLV2JcyIvyJrRcUUUKXYRzz5u
	PeHMgKUPV4rvA9+5BCXTs6lGND6g5SiEAXaYJih/sC+Ul0DZMFGiiy04Lh899Ad1
	rzleRFjm/grGZ/0JW2JJpZlA035Kok0CoUBhMtrygIr4DTiIArmgaSgvRrzUzLqh
	hqI4pbzeSD2AmYDZA1UbWlD4vQ/OlauYlu1oLwJQVVxZ+9Wk93B+c1b6COWGYB9l
	jUo8NnOJOFCUfoWvGLjXMT5DUdT+KGE16F1xPFvPsQlSsQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3fy0rq3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:06:55 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5d7e04f9f20so15219111137.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761743215; x=1762348015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCehFCqTIsIPhD3IbEV/5mwJSLhbZk/VK6KiIILlFKM=;
        b=HIy6A+b5TBs0n/R9PDqigkb9/vhw+Vfwnfv7tHyrS1zfK16RSnNlXcNEdPgUxFQd0m
         /kzQxg/yGdKcU1Gd4b9c23zLLBwWYSqwdNl8nP+Pdq1nxYHOO6LONXsb+jiDsNya8ONM
         g60P8RjjL5f71fO54qXhzQ0qTNeqrUijZdyfsHS3P1srIra6LPYJMknhZjfTUBZ4/hnN
         jd0g1uH76+QEsKxMGJBEuWQMCTaxyFybmHOIE8cMledoHKl6MPtJdI2XGfPzn1nXAe/s
         tLQLN/dZtTofpbLSwkIrhIHlxV00qdoP88Rn1kGI/T7HxB7Xky18WY8dhgMEwIwi50nO
         ra5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743215; x=1762348015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCehFCqTIsIPhD3IbEV/5mwJSLhbZk/VK6KiIILlFKM=;
        b=JzMWkeMvzyj33wIQ52T92WdjSiwPDgXSvhyA+AkOfRNyO6ZNz3Wnsia+D1Y/grsdnZ
         gKaPuGcV4ZReBosRvhq4xJ7h8JuslZlnziHT7qCw00r54l8rpPlQWNMHj05oMqV6pbbB
         DHFUSrRzUYFA+w5i2xsN4sLCaoMD/FuvAuEPiHUMmK5iXW7grfcXY80BuXh7fYPnXIaA
         VO4P378vsnnJfS6XokfPkrO/Br7rvz4OwrkLkVyllFDlAK8VWQqM1JhkgVbZpuM/4a6q
         0zwOPhLO5AtsfjInFloDH9KWg7VZeyYwcL6AaefK70kFNMcyUdpI/7kOdX5IksR3eGQS
         sDRg==
X-Forwarded-Encrypted: i=1; AJvYcCV/NrwEs3t7RNfXgdqx7ZmJvByOKrIaRlIkKWRNBXDtxuklE0HgDFPLf3NcgbKwh7jfdSXjMCXS8LlPPxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURYzrhaAbd1/p+mLSxkFlvZguJYn5/i5Wnde2Z8Z6XSbH8Q4Z
	8JcC5xCZg0ExBJnwRm+7iIreM+eWT9h3lSk6Q0+tjPaGxqQgjlFumGQXVh3bXSftx/F/CkoN2ua
	nAmOXQ4m6/Ia66oHmO3diucTFlwRN3LYkrCUmM7Dw9KRO2Chezdu5N6fnhZthSN6Upx8=
X-Gm-Gg: ASbGnctaBv20ERdgXd/1ljp26NHj83C6CHkdypwAnSkoKv7lX97ZQLliUpTWmAryf6Y
	7GFXhmCBmCZpQqFSnouVo3oJJeY3Z0hwGvpXrSOPQErxPvNejzjWU8Gf8otLfkmgnPVGFEZIMEO
	uOxxqtQfjhiprNhIXrTD8BupzDjPkslzp6fW2R6u7n0jxUB1IuTNO8j7HyoqmoiwZiuq58jTU0C
	bj1DQQvixoIAPvQf9RhZUuFSOApI3+4mdwSfUuoBlKGqUxAnhSuHPgnZqz/ZC4Fx4mlMxdkiQJF
	P9l3VB8R5HAI3apul2NNgNKyahGjkAFIYWCB1AMuCl3WG0WRN4gVSsZK6WDLem/5jn2TkQ2fYBC
	qckaPtqtpSgEpHPGiheq7xjYpm0UC51KaEbCSAAAsCilSDaaXvb5GsTHNIbwlCK8Cv7AaC/q2rq
	w6IpdhwKuE31EP
X-Received: by 2002:a05:6102:6315:10b0:5db:25b5:9b5e with SMTP id ada2fe7eead31-5db90651ff4mr665145137.22.1761743214714;
        Wed, 29 Oct 2025 06:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdpALPUD0OqVxQMF25Rb+voJd2VsiumSgtzAYDG3V+e6BVqlwJIJDOYxukZatQ/uJkULtLkg==
X-Received: by 2002:a05:6102:6315:10b0:5db:25b5:9b5e with SMTP id ada2fe7eead31-5db90651ff4mr665076137.22.1761743213883;
        Wed, 29 Oct 2025 06:06:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f48bc5sm3818784e87.30.2025.10.29.06.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:06:52 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:06:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: Re: [PATCH v9 3/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 QRD platform
Message-ID: <bgnu7pvxxmcucip4ytfxii3f73vhc4zw3yxobpc6d4s5enc7lj@nrpmu3f3tgxh>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-4-krishna.kurapati@oss.qualcomm.com>
 <a117b105-a734-4f67-9bb2-c06728e79083@kernel.org>
 <6297468b-77d0-4202-8ec1-3e731acc43de@oss.qualcomm.com>
 <6234e22a-c119-419c-83b7-2a53467951da@kernel.org>
 <a8046f0d-ee74-457a-aafa-6473c67c6ab8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8046f0d-ee74-457a-aafa-6473c67c6ab8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VJLQXtPX c=1 sm=1 tr=0 ts=6902116f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=89R4fWTxfaoZnEkOi0QA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: oVxmTkHa0aPV3P-5O6CEZi4yk7CIrXk4
X-Proofpoint-ORIG-GUID: oVxmTkHa0aPV3P-5O6CEZi4yk7CIrXk4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEwMCBTYWx0ZWRfXzFTVTmp6UPBn
 pocLQtWxoGuHxdbtBoduxgX1Ne2FPGY7zrtayhtBGzCEF5ionDH46nA8+nxXDrLOlCuZiyEHPRv
 RFpm58gz9GWmHr5ppc19YTEKiguKLqbCzLgx8/t/tMRM+W6zHccE9oLCVBa9eiVafuFd+4Qcyzk
 7V42Extk0/TphCEo6V0dHLs2tVvi23FURsDODD9K5oSIjDIwuJt54Cag0Mg2y6JZzeJIUXw03pZ
 n+zbzZUM7tfD9bwAFdGRQATl8CgoOF7wpTfdnHkBeKmMCDWp2sHw7iHStPX6o2S2ASH7mgtQNa9
 lSHS+mBDPkr8KZSHhBeNSvVO0LqYSJM/89o9oCoY6afXjSWVSSvWmdp3fEN/i7XJ3IShgZvci45
 4UQZEZqvFgG3tBcjTNb1skyecsWUVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290100

On Wed, Oct 29, 2025 at 06:00:02PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/29/2025 5:35 PM, Krzysztof Kozlowski wrote:
> > On 29/10/2025 12:42, Krishna Kurapati PSSNV wrote:
> > > 
> > > 
> > > On 10/29/2025 1:37 PM, Krzysztof Kozlowski wrote:
> > > > On 24/10/2025 17:15, Krishna Kurapati wrote:
> > > > > From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> > > > > 
> > > > > Enable USB support on SM8750 QRD variant.  The current definition
> > > > > will start the USB controller in peripheral mode by default until
> > > > > dependencies are added, such as USB role detection.
> > > > > 
> > > > > Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> > > > > [Krishna: Flattened usb node QRD DTS]
> > > > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > 
> > > > NAK.
> > > > 
> > > > You ignored every previous tag - multiple reviews and tests, and then...
> > > > 
> > > > > ---
> > > > >    arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 22 ++++++++++++++++++++++
> > > > >    1 file changed, 22 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> > > > > index 13c7b9664c89..fc5d12bb41a5 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> > > > > +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> > > > > @@ -1054,3 +1054,25 @@ &ufs_mem_hc {
> > > > >    	status = "okay";
> > > > >    };
> > > > > +
> > > > > +&usb_1 {
> > > > > +	dr_mode = "peripheral";
> > > > 
> > > > You sent something different with issues.
> > > > 
> > > > Really, this was a correct patch. Was reviewed. Why you decided to drop
> > > > all this, drop everything which was correct?
> > > > 
> > > > Your explanation:
> > > > "- Removed obtained RB tags since the code has changed significantly."
> > > > is just wrong. Almost NOTHING changed, except completely unimportant two
> > > > node merging.
> > > > 
> > > > NAK
> > > > 
> > > 
> > > 
> > > Apologies Krzysztof,
> > > 
> > > On first patch that adds changes to base DTSI, there were changes moving
> > > to newer bindings and merging child node and parent node. I should've
> > > removed RB tags received on that patch only. But I was over cautious and
> > > misinterpreted the rules and removed them on the other patches as well.
> > > Will be careful the next time.
> > > 
> > > Also is there any issue with marking dr_mode as peripheral here in usb_1
> > > node ?
> > 
> > No, I think I looked at your other patch. Tthis was reviewed at v4 and
> > v5, which then it was changed breaking sorting order. This one looks
> > correct.
> > 
> 
> Ok.
> 
> I will send v10 tomorrow. Can I add yours and Dmitry's RB tag on the MTP and
> QRD patches and then send it ? I will implement feedback from Dmitry on SOC
> dtsi patch in v10.

Could you please answer the questions that I asked for this series?

Also, why is there no link to v8 in your cover letter?

-- 
With best wishes
Dmitry

