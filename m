Return-Path: <linux-kernel+bounces-762629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46733B2091E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170901887CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9223E23C;
	Mon, 11 Aug 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iuih7vAG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E88635B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916344; cv=none; b=EtnzY7rmIcLyr5ui6oa9XCx7qg41VZghCBBuxw9LcpucUTxJnVU29fSkzKlWqV9PKJVNdh0+b54WJwusfwuYIIYWMxX0BLYLrkbngsF0HW12+YmGudekRlFsBbJDpGtie5P5gYkflZZEJdFaKPU7T9PbZGUck2E361gQgu7vmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916344; c=relaxed/simple;
	bh=jW5Qvse2VjAQgBMlkx0ghwxP6d3zSzl6DpklQz/HXq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhoqCx6kopYQqzD7UG2k0+g6Cv1/uliywdwG7pmqXBSfVrTkZ9a/rNYetay2UeHlVZ3ueEkdDaQPjRs51PC1OPCTn7YErEhK7qituuATab1qImxftvlyqLWJKhaDO65bpHZZjedrlouqVbRjX+IJoNwn3XIEMk+7ihB5DMY8U3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iuih7vAG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dAES028829
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pT9ohewNtPwm8XYt5Nk3ZAoe
	mGBHmM5ljwEdjo4ftDE=; b=Iuih7vAGr956+NyImXauom3d6ITOXc7qap30yyTV
	R7D6/c4BW+X1ZD5N2PjbcrbD580GzH3J456uyczrNYnapSnpkD4fAIE1ntNnl5C+
	GJoGyErafNsaL2E6NNJLMdJ8jsAiKIaGQFoD/HXfiuzF4kRh2GEDqwkod4yQOiXl
	CWyBeDcTWxJsSAnaIBAHkwK8ihB6jtjR9pbIn1R+8dIr6FIwLfOXiUayoWyWOe+F
	Jh6A2rBhyVGVComgkXwRGhQqYLljZtNkEDbe3ysJB67SYjcjE5dygDYDD3k+CAwa
	LkO/gksYsx0r5dpP5WD5O8SINn7ge7W/qBh5jOozmKievw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9smjmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:45:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-707453b0307so98012916d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916340; x=1755521140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT9ohewNtPwm8XYt5Nk3ZAoemGBHmM5ljwEdjo4ftDE=;
        b=qGRwflB9xHj92jnPpkTGVntHmBiCnK7+RtukLxwOfyGeFcT6PfAV983mVqpWKdczqp
         wJeJE90uuSJtwpaM4orduli8/2+jR2exdc6ojNeBtQsWSGqqvzXZ+D7jSelZJQC/RTlW
         eGQQ7Npjv4oDpcp7Z3CH0LYZvsOhRs3n3IL2ZYKTcg9/L1BBk+ontd+IFd5zkqEy0txN
         mCrK2f2XHZuNvrVh7JKpTpnPfbZWdWW98lGpHjRzgCIJFz79qCg//liDlNro0t7fwkC8
         tiEYf4djlVAqBl1z/F3bC+41nabTFVx3jiIgLQ5H1YyXpvB+pyTc8uz91dAuef67ldkv
         PN0w==
X-Forwarded-Encrypted: i=1; AJvYcCVOBy9MDWYIuVSw1Rs+g9K65NHGNz5NXIfSNC19pmJ4i/Wl52jayIE346ZLzG/jnazvQbuWgPn5rAkCzn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdjJC29OQT3nh8nxWLg4MSmpmtYOMkJ52j1QfmZfL0c7brbMO
	YgztzFi/fSWzV4qREQO8ZyfqG7EjdWM619qrQC4ojFhLShuNDHWO4iS3O9qpljdC25/tgOoDYmV
	P+8uKH5PM6K7Hz1eR4ldqDLRKQGnvfaKk/dVTdovUquP3CAiRvP3g+NrYVBoMimZdYsk=
X-Gm-Gg: ASbGncvZ2ND0VqpxOGRzXGpyqYLZUSdl42MpdUNPKZDpPI6M3j9u2/CONDV3NoS8LIj
	xiZOZK6fovF4DyWY15GuhxzCAMx2ruabpg8cKc74I8a4Ucp8GC6kRrq5+hpYbA1rm63EQq4rqU/
	mSivMaWonE5MiR6k8d7dQHtWNidWWBVa4C0WROTlkg8iedtpaqPXlJE1Cf9EVxSryBe+98RTYWm
	Qvr/3lcYRZK6TIa55Aqmh1XJCyBbOCyQUldaFCvNnowG9uS885lwhZH8SFS1iazLKT+JSEL8y/H
	pFPzcTs82byAcM4TqglgYptvIsianjiA8Gh5IqcUPDMvt4e7ZwW1YkSfit+TLQeGEbOBGRk8snf
	K72dV0tyacrcVi6c0/BkyybUAtOaIa+vZO5pvwwGZsrU4q+ZQPf/R
X-Received: by 2002:a05:6214:2626:b0:707:1b24:f305 with SMTP id 6a1803df08f44-7099a1fcfb3mr151745136d6.18.1754916340031;
        Mon, 11 Aug 2025 05:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNeqcsczlEMfgPrp2sE30gPgQQo08+/icjLACF9Uyg6u4HdWc5u3IL4q586h1hVCxd/FxkBw==
X-Received: by 2002:a05:6214:2626:b0:707:1b24:f305 with SMTP id 6a1803df08f44-7099a1fcfb3mr151744486d6.18.1754916339187;
        Mon, 11 Aug 2025 05:45:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c0e9sm4233296e87.13.2025.08.11.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:45:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:45:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: chris.ruehl@gtsys.com.hk
Cc: sre@kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ruehlchr@gmail.com
Subject: Re: [PATCH] msm: arm: qcom battery manager add OOI chemistry
Message-ID: <tvdv6755c57x5b4yjtqopshxtdjl7eoor5mxqh62k47o6dtcdh@znug23oizqbw>
References: <20250811111026.24292-1-chris.ruehl@gtsys.com.hk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811111026.24292-1-chris.ruehl@gtsys.com.hk>
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=6899e5f5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=O7zmUmNSAAAA:8 a=EUspDBNiAAAA:8 a=XW9AV8nKKixspLQJyWAA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=IJxu9zi5bFdC9NS7oKyv:22
X-Proofpoint-ORIG-GUID: N3Ip2zYH5nAN2lYK0Qkb3-2DifCVF-KW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXxffxTK9Edqm3
 eB1jeF7LFqsIlomuswWhg8zB2I5K0CLQHDgTzW0gnN8Q+yhHDMqLv8j1iekJ/4s3IALM9tYOEMc
 s1/2qSONrSE4cV7VR/lR4IPyBbfvjA722cSPrpffxZxNn9foMbaUa3hIaNFZm4coHhpvy1b3vw/
 4/hOWoC1bNFviKoRrUWM+Q6IQWVrHGlXvgmhKFAOdoI7qL7bSa9MKy4Kxd63FHp/Gl6tc2CxUUy
 oilpfLKvCWdf3FNHUrI9AhbUGqXjo0HsRSCjeY0KYaFym0xZyp8m7i2edYeRjHkMaBFILVvKnuf
 gU/J5r44VZF9pFCsjSdAF7/lRoCr08XWtrg+mVZLLYm86rlE3nVoJ9WofZv+1Np6itrUZkZPZat
 VSVsDirU
X-Proofpoint-GUID: N3Ip2zYH5nAN2lYK0Qkb3-2DifCVF-KW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

On Mon, Aug 11, 2025 at 01:10:26PM +0200, chris.ruehl@gtsys.com.hk wrote:
> From: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> 
> The ASUS S15 xElite model report the Li-ion battery with an OOI, hence this
> update the detection and return the appropriate type.
> 
> Signed-off-by: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/power/supply/qcom_battmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

