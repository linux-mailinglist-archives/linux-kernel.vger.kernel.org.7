Return-Path: <linux-kernel+bounces-831565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FB8B9D074
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DDD175BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490422DE1F0;
	Thu, 25 Sep 2025 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSAtxuGL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E61C8631
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764006; cv=none; b=hG8SWLkUeyHGuyy6n1FfumLHRKMXn8q6ldKElkzVl18CaIEmMruxGft92mndNZB76nnROr5xpBDr1qZVQjvNUeXZ2ss5knlVUwPst2T+9f7vAU3OgMtrYgI7lTts3nh9kucCkvNaBXvdlUFaEd9EYaqxy98c3oaPb/neidjU030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764006; c=relaxed/simple;
	bh=zrfzjVYTZ8zVuUra+29CM12pAOhebaaVlpFBa7gsymU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iROIHraJ9IJUX4Y6PdvieMtP4+pj59QUEWjuljzEZpCxn0Y9lFSYnIDHYdhRBtoLxSwIWTdIMR4p3K+3e8XjWt4KB6wMbEv+r/azZkgi1NXLn01X+xrQAZNifh1h3AAIN6J69qIQGpYMFwbeIg9bLDHQDNm3W+w56atY4OF0B1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSAtxuGL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P17fCB023441
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MAYOf+6wYe+77ArDzx9rSs0N
	PotguJku+fDW8OMKmmk=; b=aSAtxuGLrpxX4/FkwXLjKtpeP6nxmRmZjYqlLCEQ
	DEWF2ykZsnrp3lqedxOXHet9wjFmLvQsNsyHtctKafMTDlab7bTd47JFlZ2IKnFZ
	4sjaU9AjuxLFtylpwKhUFskjzR57jyJC+3vc6exiUhNua6D/6YfFLxhTIF3jb450
	zY0SX2MDFlSrXYVJq+hqnfHctr7wpk46b27P6qVkHqejZDorOoaXaJnZaV+lhUIp
	a871jpI1IpoNXW9LVF1GlKGn8Umtr3gSJiG+MAmg2rOjeLHW1XA7KPwAtgZciEWE
	Foc+gef2tYqIgGHrFGaMhsVich91UyfDByKbjUSdZul1LA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budaduyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:33:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d6a82099cfso10649701cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758764003; x=1759368803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAYOf+6wYe+77ArDzx9rSs0NPotguJku+fDW8OMKmmk=;
        b=X89ppicNuEXzxJZ/kxhVdiVo2O7qgUNhh65PXGWoQIs70yBvyJc0I3N/A/tu5LUx1Y
         0ZHaGFuPe7VT/8pO80HbvKA6OUWlwD1mo20RwFdjw1bsJv6/WjMX1Jh6UgS+K0Mwz23G
         qWW+EkbDB+VV6MC66g9KlYpMMs5C0iIFKCUCOwhTXm73INI6ZOsAfDOU5Am1JTH5j8qt
         gEpglDmDU7ikfVelsWTVMSyIauw4INQtEAOw9Jtam9L30BRfB7l8rLs3+kiWhuiL+aL2
         gp8eY6Jda2NVGsPC47AlHnLpW+yhBaJDRAdxbxuVeqy+zsX4jWffmiuXo/uc4H1sQz6D
         oY6w==
X-Forwarded-Encrypted: i=1; AJvYcCWWr+EIFNZp/3rSyx/oZf9PaCBk7RDuQzuhHnLs78Xu3aajHz/IrESunZJ85VLoXQDmiabd8sUnUvm93so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DwkDj/Pps8SLxgzxuGuHykhHBLZA1jYQE2S77fgupgIVgwga
	yvI/+Dqi9mkTj2rYB1b7cGlvxdefC0ovqkwEDeOh/Z6CeJroG7u2hwfYZkv0SM4I0WmmH6mIu5z
	5kkWNW6i8ZBd+MbpoJdwePOL22D9Egiry7Nf3XCtAvuUfxKeqp3f4vzH9/GXsO3S29U4=
X-Gm-Gg: ASbGncsF84rBHF7pKMVaA3ApYoGCGTT5ZECFs9Chjcs4QAOAhKu/wNcFpgLdvNGGiHY
	76+uIkVV1Zj9EZdRoY3mdbLUQLEzPeUMXcsyfvmST/oAfQFX+Jhu5w7YDUvrMG/T2rpzmaXG993
	FWe9dWtaSkNqLGk8Tp34zKI0uJ/AA5XhkpGQQVo+w8RrhAEAVVGmg3zvxtS/vkdN0pgGfWn84CR
	YQWMA4VYSCgwW7eaB0mADsdDHxoeMIpCWdj7w5/QSoO9NQrzUmPym7Baa5IlzXU/6O4ic6uXxwt
	ltA02lGtPn0YV31a2D77nACIBz9Av9XjLY8MY0Gomw/mjir7WPZHDLSc0oleoWVGW4vU77oAeT/
	PzPWPbVII7UqJmZFi8yC4hkqVBr+jVyZtYJ1VTA3KJNm0zlT/Yn+J
X-Received: by 2002:a05:622a:5a92:b0:4d9:6e55:5e3 with SMTP id d75a77b69052e-4da4c58ce0fmr26416411cf.54.1758764003203;
        Wed, 24 Sep 2025 18:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs/buRc3wA7t9IKg8r3YHQpd1WKRsDmuKuJqSv26mWEzgo1bfg3M6RxBFT657MdZqpPgLz6g==
X-Received: by 2002:a05:622a:5a92:b0:4d9:6e55:5e3 with SMTP id d75a77b69052e-4da4c58ce0fmr26416231cf.54.1758764002749;
        Wed, 24 Sep 2025 18:33:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316ff59basm199254e87.130.2025.09.24.18.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:33:20 -0700 (PDT)
Date: Thu, 25 Sep 2025 04:33:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] phy: qualcomm: eusb2-repeater: Add SMB2370
 eUSB2 repeater support
Message-ID: <tij2dtgkb67f7b4nvyirnvocu6yqlityooatg3prxbqhfoagog@5r7izeeaid75>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
 <20250925005228.4035927-11-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925005228.4035927-11-wesley.cheng@oss.qualcomm.com>
X-Proofpoint-GUID: 32iKlLP7XfgMiohBhTVdqKMC1obPhsed
X-Proofpoint-ORIG-GUID: 32iKlLP7XfgMiohBhTVdqKMC1obPhsed
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d49be4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=E9wxpCBlzucncV4SwdQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX62pfkYm3q1Cs
 eAUC3Dt/4PBunKzVw4hNYQApz8okyJdf0bU53rdzJCPJTvsNPuO9ODj6uZgdp/lA7tLdtvQaKqh
 CQ1GmDagd7FjD0mF4tCr8AdC6fmk+FScRDhVH8okqeFniLISVl9pWiJ4EXOrpfFN6LT+TAuVxEp
 ajegojb2wSfP5AJJQ/xYZYXJJ3Mca8MyxHzhY4HaZK3YQ1NNhppNPkBUQ+S+8yxnvmutiYChpYD
 bKAOQxy5SMkoQYyN22GXETae1tp5o97qZIxrxvzMbTmO/lam7KAQcp7USb0tUxBwgheG4enZDgn
 beno0gsNPJRiC17uDBOtC53zs2Nc2g9WLjhJhQGA5hIcK9gQo/QE5riqWFpTzf09IpjZNm608PZ
 r984h3ed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

On Wed, Sep 24, 2025 at 05:52:28PM -0700, Wesley Cheng wrote:
> Introduce support for the SMB2370 based eUSB2 repeater.  Configure the
> proper repeater tuning settings, as if this is not done correctly, it
> can lead to instability on the USB2 link, which leads to USB2
> enumeration failures, or random disconnects.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

