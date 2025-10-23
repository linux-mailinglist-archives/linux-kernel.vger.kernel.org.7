Return-Path: <linux-kernel+bounces-867146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A249C01A84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CD19A0382
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038EE31BCB8;
	Thu, 23 Oct 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WYt0E/IB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1E3161AF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228635; cv=none; b=Ip4pC619eYRafNXm7YaCl2a+3R6x8FODlk6BiduM1mbK/xEOwpBySbwH9WvI5nPtHCTJ/tS40nSyCa8w0awqJsNgzpqIaM7TrM6ftustcRKVRqRkzn7MfJ5urSwxwefKwpPpw94EE0E5Ni7SpWJr2fOa5RoMsAt/m4WIkjqO5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228635; c=relaxed/simple;
	bh=E8DHiUHBc+Kx0BkbHinW3qjbtm95S9kjEJyXbNNuC9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq0flzD7ztAvxq1CUlS3TfjLUXuVPphT1QfDqDxwwH1H6fg8fxegrPM8ooLhKQXTn4EAe2iqFDFfjLevM1Mf3QZWbfQ864UHeZjIKWiXwHLYKdzCesJmWBdz9LdxhwAuB1Uxb1WI3CiyGOQWCiJQjKzuHcHQaHxZRoNS9YihlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WYt0E/IB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6vYTY005702
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3qgygDtk8UlAl4nQQF1ZdnPG
	AZqeQV2IEszwXskS6lQ=; b=WYt0E/IBt9ppMUHlSsxRFF3CxRwo7LvEHOvGHxg4
	mn8uS4aB4CpJ6L+1eeDeK413LF/ZIRiyjmVF+jXhXVNxEb9yOCijgfBlhSMi+/cW
	eT1JmaajhcDJzZSo6DVJ5O40zTPR7D3VlKVYZxQObsNvJcfvfqhau/E1kQgq0FP/
	ntZHLrHxY3tQ4Bx4blGWdsW1qxoSOy25rE1fSNK281affFKboVAy0Mt/auEH47sk
	qY/wiLG1LuLSRLZL5VkfJIFai9jAHMf4iwIrBBFFC6Xyfw8/aPXKmy9SJfIQqptU
	AUjQbcNd9DxIqexSpVX/DeKT7flEJ/9Wlsl8WbBIi4q1nA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j8k6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:10:32 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-556a4b34c25so1954727e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228632; x=1761833432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qgygDtk8UlAl4nQQF1ZdnPGAZqeQV2IEszwXskS6lQ=;
        b=HAxkL9cuxTedxY50xdPg57A4/JjTAreAFMMBbwU3aTnWgOfrDELQmNeEnkFPAN6/mW
         Mf2A6cfFXnAInQnHoVTvD6Jizp7+H8hsytBaQ256xYlyr214sAYCpb555lX/xt7TwD2B
         aXM8NB1zO5j9+kdDsUSoP47MaTEtu4Kv7UJ+whVwX3Qj7l43xp5CMBNbZq/mzv4XXs4H
         2r2i0n2SndrltSbchNasjyZRHmylJ537cXHDsBH1bEgSFClwIxw/do9UK7xAHWjs2uCm
         xsNua14v5/k5bfEM+w7iQXM//S9xlePssreSaKR/jAWc7cHHm4jPJZIsMWpr1t7tDZz2
         hVog==
X-Forwarded-Encrypted: i=1; AJvYcCV+5FEjTX4WlwzUw2bBckVWTHLWs33njEEOb/hEh24HQiyxodVS8PNUFmmhVxy5Awo7Ck/6Z65rFnewU5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsh8Wokl4a4adknXtalSKe545e+5Nds9vN/8iS7gbgrB5Xm7b
	cgq01RjNiOngPByu65YJXDLn7IHZ4k4jVAqcaCmNOczofz79yKm4cnLv+h8Q4m7AeUeChLvvhoC
	+AMxW71sXx8Hz0Mq8GEMn07bFAmCDns7QLMBSjWFa6bq/SNOetNeUtXoWCkQbzO1hQkI=
X-Gm-Gg: ASbGncvZKRJ2/aWGICmrkV1kC68aQoxr20nGdZPu6gH0ndCUOVGB3skGCfe05pNK9aq
	R9RqsyWxRsngYEtdwyAnT9AZ0fvxviZByRmSsmtGnGQ/TWE68oEDGCdZSYNKf26x41z9wFM7pfB
	QUZhhYTM02aAjzLoevap/IchpG98c40Bttn9KIZ6FWgAk+hbDQRAF10UzmNMMG9JWCTD7tMB3gy
	r3X4GzG83YK4mje6pozSsNiw+odFXMZOtZ1PPIKL9b1RBoNjVio53Whsg7ga6romXsm04+ahT1A
	lXJ3LO2pTuHNfiwlWkMIGpqQcrtmyX/Qk53E8k02li7oIQwYKRk0YN8wp3DUTXP00lVKR5WRYvp
	WnADLCE5B+YuyaZKjDCb37G6OO+sRI2qozmhqJP0UjUFWsEKPWgT9NqI8aCni5ZmtSei9YrXXdt
	V4CuUySZG0x89u
X-Received: by 2002:a05:6122:3183:b0:54b:bc2a:f58d with SMTP id 71dfb90a1353d-5564ee320c0mr8061752e0c.3.1761228631772;
        Thu, 23 Oct 2025 07:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9z2egEYQC6wwFdktlSuOrxdZPE4UHlcQ1aU42vJECIx4nLyzy1YbsX5qcp845m7FqT76pbg==
X-Received: by 2002:a05:6122:3183:b0:54b:bc2a:f58d with SMTP id 71dfb90a1353d-5564ee320c0mr8061712e0c.3.1761228631186;
        Thu, 23 Oct 2025 07:10:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4aded7esm778459e87.6.2025.10.23.07.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:10:28 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:10:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: add Kaanapali interconnect
 provider driver
Message-ID: <2dbbwcrfqvnd5efrmqku4x3rtsjalk2mjezdufef3hdnjclqpj@bcauquyryh7v>
References: <20251023-knp-interconnect-v1-0-df13182aceac@oss.qualcomm.com>
 <20251023-knp-interconnect-v1-2-df13182aceac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-knp-interconnect-v1-2-df13182aceac@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXwrvSBxeoMOkp
 +SrZn4UAc2wx81ip+5CzaPeYQY9HAzWN/1q8viuioZuJ0gMtFvWWlrW4Htl0Jcjei+/t7jISPG7
 bdJ9QkVNM6hmGSkuFa2bVBFwSolFem/2VmwVZYJNJLzqzOTRiS5hRU+c7GAvzyZyAcVn6gXUYSe
 6Gd++mZVCsstokCra2dbSSA7OGocxlPQ8My/ZY4O9B+fHs2oaRlCP26V4R0XwqE7zRsP+oTErIv
 rqdrc4dRyqqK7EANKc7NXPRHHLGaMSKzniARTp0lTOHlfalGF2i/LDJymVuc3GauAEtsZwBgjOw
 T2XruWSMzqdnANgfa98bnt+NRs7YiUOxxwPVvNYHXUIYX/ZqfpWbuYmvivNM0n1yuFUzj+KnobS
 OyTDCNDI+HPYNIgZ1dnCe3eXs7lrEA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fa3758 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=9fVyOH5KxkoKYaOAqNYA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: FAbufnN6wpP5hHYFSN_MOZY4Y0VJApam
X-Proofpoint-ORIG-GUID: FAbufnN6wpP5hHYFSN_MOZY4Y0VJApam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Thu, Oct 23, 2025 at 04:39:33AM +0000, Raviteja Laggyshetty wrote:
> Add driver for the Qualcomm interconnect buses found in Kaanapali
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig     |    9 +
>  drivers/interconnect/qcom/Makefile    |    2 +
>  drivers/interconnect/qcom/kaanapali.c | 1868 +++++++++++++++++++++++++++++++++
>  3 files changed, 1879 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

