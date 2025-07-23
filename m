Return-Path: <linux-kernel+bounces-743116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA060B0FAC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C59566946
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE4022D786;
	Wed, 23 Jul 2025 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Om/d6bmD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C567226D00
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297757; cv=none; b=JbH1xE3RvahzBnTjbmYAQkMC8xavVLfJDmxyp+/MJ6CptJWQ+9nXkyAdRtdsWBTmgFbShiDWUfxcXRbQEbyB529mzT5CW3brNu0Pg1EUNB+icS6sGf7iAxR8SVgFPsaujyCZvNcwy+2oATZIb4H1VJeK8SwrN/5/E6223u6DaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297757; c=relaxed/simple;
	bh=3B7KaJqSrv2chwlSfqXIDfQzdlTLnHpAn7BnAunObZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hug+MacEVTcVAhTnXqJBO2S0OgG8lcwEaxJzO+9AIZbfUTblcaHpsyAdQI2jIuAef843PYvbQt2XuhtdJ1XInBCbR68G/PV6Pprmn9Xi4AYL0zfMqM8m1kiMMcC+9v+RSFlHdtB6BgdOZGsa5KtcZkHmON5WTIjqynb9AMVXe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Om/d6bmD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NIFl5D020008
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=j1sHXonKOMWdbcMuR27sQzHS
	dCXJJsBCxb0JuCOVz3o=; b=Om/d6bmDKaNbevN24EC86atL7mu2tvXwDS/c2Zq3
	5aWI3lsp27s5UKzZawXDa5Z4ZGpSeYCnthFY99g/FyWpqwYweXMETvuuw17fv0ni
	G0UbGcnROMQZueOOMhuJQTgqeo4vaZFPBWvhNuoIupjBT0I9AV5mJwidbU67rrad
	7fWfo1FiQD1tHsPuK9tJzdGdUe8eBuX+gSXcjxYS/JZpNPX5C2ZK66KuwfLGlmcX
	jIFaEgg2y9x6r8iLK88pt8to0+fG4zrPYbAfrw66OuHbr+RhL+LpegSWO4SJzWuX
	GptxFiWB+41KPfYlpg7R3b22sQuCekLX6J3+AT7RnsBEmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3es46n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:09:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33d32c501so52263085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297753; x=1753902553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1sHXonKOMWdbcMuR27sQzHSdCXJJsBCxb0JuCOVz3o=;
        b=kh7TLvZWtEdtBiDs7kTSiDmxdKW/gosEDch2OlS1w3WuTdfil5PB8etAc8lL3kj6y1
         f3yvmYpQbk6h975CdgrIYd8anZwFk4afxIMCpzizgf/TcyF9VJamr6+W1EgkoWww/0Rz
         FgHkCKB84lOIutr8fxOtHvj0Jt0V5GnpemUh6pM5f8ZFQKPBWOKJI56Fb+355HtiLJAt
         tDcRhMfPvgdSGChcfqB9pwZ/IFycnzuPRzTYg8HVbpseSpDWliHUdiE0Jc/UnMcmgMhM
         biZmQevQEwgdhAi5cZtSpDH6lkxbl0mMDrRLa8LVeUeUEHYTOOKu8BGlfolldR+vi3AD
         oJBw==
X-Forwarded-Encrypted: i=1; AJvYcCX8t5aFZuNjJxm8CCuCCW7/LWypECJJHAYQw/DRFSolCqAePSkwt4+aAzy0EQ009OkazYJHbBlJ8M+uiDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1i6ApNXDAUgYDu2w01Is+wGnVk7O7nCg7I0opmss5opA/2YLq
	gPaZ2ETspzwpKjVog3IOf5Zv0Q7FyWwHLcQs5C8KCUYQgNrKb/U6MPskv4k7ZMuirki7mysuDdZ
	pbwsn0GjcrTjZky2hzGJHR7nWoVuvq0HGRnLydbNT0I08m7peoFGFZOZiaMT1xS14Y06Y1ZU6i7
	U=
X-Gm-Gg: ASbGnctIgqcWUPYkS+wTak5n1/uR3SCkQjq99eh0Q+DiMgs7ridr5TNTZfkVLhzr2p9
	BOc1VtUxnuqLjCHfXd4LzECZZ0CL+1OqPWuuTbHMsBoci//lhasU0lvDx3ozXXsb6Y0Z8TsQDRa
	AyCWCJed4c5f40XNb6vWJKvPpf9zJ9R7VjAQnHv+Q+CSI2zXBu3tCDLgtlJs+eFboGxq6bSgOC/
	R5/1/Vn/h0v0oT95+L4yALab+6SIu4gXoqtjbAs6lANhFnYVpuru9sur4Ma8v6l0Zahdtx/njpe
	QjZU1hYJg3YI8PPeadgaUKqmBLOcZVeQauYocTXcSkvZej6w4hm5BAbNxy7AJ5HJ65Mf9cbtCYc
	durnFpwEbayqEyw/Hdy15HiaJ5haZpz95PVeYdCj6gZOi261QQrEJ
X-Received: by 2002:a05:6214:762:b0:706:c9e5:c97c with SMTP id 6a1803df08f44-707005453a5mr66358156d6.19.1753297753266;
        Wed, 23 Jul 2025 12:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0aluluxVX5KIz2Yfb88Pr9rAwoRTR4Vc9qZoIaEKErrjlJf7+1PA2sa8Ohif0ct8DwkgssQ==
X-Received: by 2002:a05:6214:762:b0:706:c9e5:c97c with SMTP id 6a1803df08f44-707005453a5mr66357546d6.19.1753297752657;
        Wed, 23 Jul 2025 12:09:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4be6fc33sm621403e87.209.2025.07.23.12.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:09:11 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:09:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -resend] gpu: ipu-v3: Use dev_fwnode()
Message-ID: <vfruvb3z4i2daywolh42nyqkgnoxu2shminslq2rshtkhrlnud@ggjdp7z2r4pv>
References: <20250723062737.1831015-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723062737.1831015-1-jirislaby@kernel.org>
X-Proofpoint-ORIG-GUID: EJRudzpMbLdQrPD0_4g3Lzvlgjlsz2ss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MiBTYWx0ZWRfX2mSftyv5JGqD
 hMthEeacXgxqSl02wT5zKEUPGGfDBp2NiOoQZG0nxlUKnfk1sywh6Gg4Z8jcaNE7Mu47f1aHRCS
 z7ZZOtzM7pDgcIyshBYYvLNAjFjgeT/4YrVwI48UkMNzYzzrP1ZQF3otc64g5xg65WrbFODOsks
 Flr1SI6xcFSW29FSVtljI9CQl/mzGWHCPLF65hGD6YwrX7ZVYbNyaqAvBUYoSRWNAZUiDf31XAL
 hMsc7RPfdKhqtNgLtafuMZUYo0kKOg7w+fc6FhWiTK6KrJGZatpYy9lZ5upmCFpgvUkS+Y4O6fo
 NvJij28wLn6bx+mERPd02zrPhLF7BE19sXfHfcN9Tx/nCr36uQlv8udpA1IbcjEISzuUl5xw9b3
 D0HljuqXAeZJZXh5GQIRe6KzkoSvZ7zPQrcHPeEqanl92uwASCyVSiJY4cmySTlD5GcyDrLu
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=6881335b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=ElOPiJf0bgOxSbpTRk8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: EJRudzpMbLdQrPD0_4g3Lzvlgjlsz2ss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=516 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230162

On Wed, Jul 23, 2025 at 08:27:37AM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Link: https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/
> ---
>  drivers/gpu/ipu-v3/ipu-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

