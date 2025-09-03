Return-Path: <linux-kernel+bounces-799010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2013B425CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F403BD168
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA352286416;
	Wed,  3 Sep 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MoqhkWoK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410028469D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914469; cv=none; b=lhKOr7z4dyZU0Xelg8my7y4ddYK1z4wtH8zqa3AqPJujHg0GMBVbLh6P/uI4T9EG3liELuuEL/R86eYAK+Mz51IxAyRj8Ue3DWoSPBsKf6zPuFGaVyIawdmrMPQAwdpa4T4fulEmw3dvp91Php+5vnDNQCckHpMUyx6PwWCzUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914469; c=relaxed/simple;
	bh=XInwh7iVomsQx5qogF3hzih+Y3WyM16GQrfW14cftWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBZiJS/kEk02IC56y8QEy3uAGdzxeqIDGttlaL4fL7zLi1ovUNNkTwXLelPvYrzAlBuuBatg7p1KLEf7UyIGre5FmHqKxfDZpT4pVqsHla1dIsP5isB/l6rp1It+LS3nyzWrfAKlT6zibbQUBsamlHq4ZXAYVygoWkY9h+Y70Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MoqhkWoK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx5VS008926
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oU9zNSZ+JNQecUFr9QN7ywvBOG1sjWRxRq01g9yamiI=; b=MoqhkWoKRseuQIXB
	zhRJ6euWY97pDSUuhd3mKCZpuIgDFvV/gqKtF8qamruclyNzXc6uR+s/w1GXm5wl
	mOHlceyHakYFsQU2zLvvRoZF1urhyT0xldpqnRx/iZnPzn4thFCjDJ80HDATBZ80
	+Bkg9dZmYVh8WKf7PenuHvVjizd43iSjFLxK9Cqp/M3+EsOMA6jz1w2DLotpCoS5
	uCqGKy1LarQoximJsUB9CeBPnzw2viL3VacWZA0IUK7veCA2hDogndrU+gagpO+c
	3BTzR43Th+S5McMANst+BNgapNJBsojjIsnK2OpJazJ+vxAxm/PUsgKqYWuHZ1Iy
	AJd+lA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy84r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:47:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4fb59a89acso425595a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914465; x=1757519265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oU9zNSZ+JNQecUFr9QN7ywvBOG1sjWRxRq01g9yamiI=;
        b=A5DYsvfpSlEPBY5ASnNBE+0Wgn2vrP7Lp6QJdCufUme6oHpRzv15sJCZVmDWWAfjvA
         PBMl+QyXTIVcsPw4rO6NczD1oIiwiQypqhTVAJIU2x5HUO0KfTzt3lv4O6QqKytr1uN4
         aX/CBhPxFFxhRFbQu7XOir0SC65NOKUXwFpjdW7GMaw69IN8fsYpdHQ+RBau4CsCSt2o
         /swTF02qtAgeX45ta+xZSRs/f+W+QG14TlBJ1NuOUHUhsADOvsBqexXmNUwVYNGVdnCX
         QUOHElO42yYkA5RsteF4nJZT4o7/GCPztZDvAuGX2E7uvqYnHtx1eyCT8OVCmF+yEj0Z
         SHcg==
X-Forwarded-Encrypted: i=1; AJvYcCWDaFc2B05vBoySf/KE5F+T3ntIPzbRFiDurSnu4A40f95c4H9vuPUL9KoyI2mgqBiw1vWfXkuD9AL38Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77Ldv/Se/8PO1KiQPeI48SFgYAyLh9KEwtt8y76ZknYoOLq8s
	uwhQ7n6s2XtpgY6xKaNr9wDSSDWxRoMx/qy3Geesi70zUYoDmp6NlFE0qZzxFevcnkIXNNmsLgb
	hcpu+flwR/wQ7M6I7GK1OWC6+kKksAV5AJjYHgWNP3MUEn3JQvGoXprYFSxDJFRMLZDQ=
X-Gm-Gg: ASbGncuI2U76v068eshH67EjyrgQNUjT/RkzHzYu65rny9QtAwjlTTbNKCsIzo//Yad
	ZtFswCtTh8aLpyHnsCTaEQaepFTqlr4krps+T+VAnjykmaUCdF1l2iU64M3OaAmbct0p3PEMnpO
	f2zZ6vFWIXV5/y30vF5LtKRxLlhCkO9v2WAkzFLwnU2K32jaizrAdQWa2ycHxN9+CELgE6upgjf
	ZXOsS6bilwBW425xUXgAgQbUFgfRRSUsnmJ5Tvm3ltXs1Km5klZtfTiRnNJafwg9pMzRN9vcCdv
	J9qBkdqMRi0XUm5gei5/slFgrwq3pLn7iH2MnE8JD3pC/N3PDEjT60DnioqfO2COvOF9
X-Received: by 2002:a17:902:c950:b0:24b:1585:6363 with SMTP id d9443c01a7336-24b158565c2mr73678155ad.8.1756914465241;
        Wed, 03 Sep 2025 08:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4YwLQKquajxMk71cIseTHOUFmzvVFh27auBfgVNaa4odZqX0nZOQA82oA2Q+AJfG8X0fGzA==
X-Received: by 2002:a17:902:c950:b0:24b:1585:6363 with SMTP id d9443c01a7336-24b158565c2mr73677845ad.8.1756914464769;
        Wed, 03 Sep 2025 08:47:44 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705b91sm166483095ad.12.2025.09.03.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:47:44 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:17:38 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
Message-ID: <aLhjGuaAybp2CeIg@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
 <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
 <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
 <aLhZ8VpI4/fzo9h8@hu-wasimn-hyd.qualcomm.com>
 <c7b87a26-2529-4306-86b3-0b62805f0a2a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7b87a26-2529-4306-86b3-0b62805f0a2a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b86322 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=QqZMUp9YY9ei_m5RKlQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QFp2OkoESQZ3S5Rwyzm5dey2ktPqUxuU
X-Proofpoint-ORIG-GUID: QFp2OkoESQZ3S5Rwyzm5dey2ktPqUxuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX+YdGuIk8t6N2
 2ERzvPq/7dUgQvrxKEZYKzY+953Y8zAB2L7KeX00rT25u0nkoB/VskQU9DLNUTTEiJzS2OALX5g
 EVDv4cyBwDchNeQl5ZKBKEaqiQb1NPZSuDDInBcx4hiRA27LSme7eLVaHm1BFe6/Xq5HN8hbY7E
 AGv/P8slYmJP2b2OFGMpVCmrq973AFydDJ1XlgZdq/i5lpo0Gq8ww7NhVs99IymkHNw8TtBT/w7
 kDOWtJL7D7R31tnpVmfJBBKmmy2ijQhRv5Lf3o9WujodJM3IH3xCJz93KuliEgKAVmxdyZeZSb0
 jFyD0hlmIaM8F+pPS//gA9+bRQBmit1T6N5CfNnI0B6BWGG6d3sRbsDw+K+m7zDZ110sge+tcMO
 xOL2jeIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Wed, Sep 03, 2025 at 05:12:44PM +0200, Konrad Dybcio wrote:
> On 9/3/25 5:08 PM, Wasim Nazir wrote:
> > On Wed, Sep 03, 2025 at 07:41:30PM +0530, Wasim Nazir wrote:
> >> On Wed, Sep 03, 2025 at 02:29:11PM +0200, Konrad Dybcio wrote:
> >>> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> >>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>
> >>>> Define the nvmem layout on the EEPROM connected via I2C to enable
> >>>> structured storage and access to board-specific configuration data,
> >>>> such as MAC addresses for Ethernet.
> >>>
> >>> The commit subject should emphasize the introduction of the EEPROM
> >>> itself, with the layout being a minor detail, yet the description of
> >>> its use which you provided is important and welcome
> >>>
> >>
> >> Thanks, Konrad, for pointing this out. I’ll update it in the next
> >> series.
> > 
> > Moreover, I notice that compatible definition is missing for this
> > EEPROM. I will add it in next series.
> 
> I think the pattern match in at24.yaml should catch it
> 

The EEPROM used on this platform is from Giantec, which requires a
dedicated compatible string.
While the generic "atmel,24c256" compatible is already supported in
at24.yaml.

-- 
Regards,
Wasim

