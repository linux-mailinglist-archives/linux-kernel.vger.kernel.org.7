Return-Path: <linux-kernel+bounces-803015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44053B45976
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E88484D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B47350D56;
	Fri,  5 Sep 2025 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SXENI+dQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BF145329
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080001; cv=none; b=EccfsBZ8k6k8H2pWco6w0p9d13Hx8u6LnXNrx+OCKgirptOc7O4IIGb2kTVZOqEF0iWDsMK6OkqxLKOG2qYP9voDcc4uAt2ILnUtd/KETHqBDOnEVVKniigORtnOJehtQw751yMC7YuPCN8V4iC46Zt/spIMBGur+W/Ow2Oq6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080001; c=relaxed/simple;
	bh=rDwUf94pWrtY4v9/Yowz7CgUxlVbI7YWAum7k9Hw0bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CunGz4g4IZJgd2WVafLuyCmvya0+/NE+U7/P4CkOHMQc8k6pUBmiV2RxKiSQbl0Oh50RmTW8m1gflfZP63bxlpUvxcB4gqTnKK2cJY5c8Gx3BOJSHPDdzTg2Mw1VWITSFQKpEMXjv55/gVjdoGLNrG8hYlKFQRY0MkbrVUxlyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SXENI+dQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5858WYxl018519
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3wQB5Afi4Fdw9xsNR7jXT3pZ
	/Wg7hEvuCNLqqtAm4js=; b=SXENI+dQMtOeTueVqf9WdnSGWzjCsGQStpytdnB0
	o6mCnrhrDPwXbi9h6jPFz7jdYvOxVwWwqFSF3oG24Ib1mopaFzQh4YUa602ji4v6
	/ooWz3aZKls8RQU4n0kdEBhe3P4b9esSoI922Aq0TWRNWtGO6TUfekljdNGjR3v2
	4dpXsBG5c3Lnv70p/HJc0ckXedvoKbxV5oyI4KOhwjdHssqFOqrDE3I5BUvkaxDR
	UniKF3u3/oMoJqUXz/MEsEytmtkxYdzwrFUmJ/2JQNsQ3qvtXOupnRND++iPrGR5
	VffTqF8UYS7N8sx7ZaAreNaKMrrjWcwUXeklaeV4NMWniQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpkekb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:46:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-71ff3e1256cso43851916d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079998; x=1757684798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wQB5Afi4Fdw9xsNR7jXT3pZ/Wg7hEvuCNLqqtAm4js=;
        b=a6Spv41iB4invpAqN/P43uFlyzsg55Hqlxo3wjPajJPl2h8lktV5u5gQN6yDBXevD6
         WVUz6YDNvco/8gq5cJZ0K5kUVjUZWgLWMQPWNogVQBd0c3ytWw8BS353v/F4lImunNBg
         nIOCqGeeSVdzW8kMKx5YFQeuY0oycuT7px0RbWoLQK0VTIx4umfjqooG+BMkmeMKPc4I
         vyIiBgN0imFPkcgbYnUn/bfkpcXOs9vwrAbjQhR7X9sV4KoJDG/BgmLNl53BUrGShsF9
         pBXFMzXrbmKAXNmJIOvg3LvwlkhB64AvG6C5sNBmzZX3Ro3uUNL4fKW9kFRid0jcWXbN
         Il4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxqmre7TFScW90WnWkTbNLZki598jrN+vknl1pidO4JHecplEjCZRauyZfYwIELwvMQBqGuMAWnS3g+bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QTxW2LfodAzC7u2XHUx4gf27IcaaLcurgpmd/Reh2NQ1bNFv
	c5Hi3HZT/vsrvJnX2pT8S34uREid9kaO3Wo4sDODsx8jWZfAO2P81VMaxjfx6XAK8a70yH7Vlgy
	AF80dKkjFjKvHGn4rzREA7+tKWlxMRNOi9zwati0hzRycG8RaUdBlK8ssV6EOkIspvh3+XzDkhX
	c=
X-Gm-Gg: ASbGncsCoyxGx3itjxn4iVcjmmsmM81AElVEn5bFWTZwwzFLVP8Y40As9rglDZ4rpUj
	RA/HafDv6DFDYDvBpv2B8yHbC8JafA1+RLusLxfq6xDtPqjtFLBsWDJdjioAyReDibxP5XqvgZP
	D8/qJeqlYOEstX3cT64J22mco0pcxAGKT//a2zLdVL74LWrFo23y0Yx37vBGGnG8bpBU6Su80aY
	neA+fs0Zv/DuT3ylXMepZAr523QWJq47TGpdfoIn7rmPhozgzbCMfg9OMG93XPHEx1DMHsfOy16
	sSPjHHOHcyeFxHxxrTXi79nvROTIHiHsWjE9Hi9xbyRkrw+aKOrY9PIK5LBxFqgTiw+nQffsWvt
	ptTOFLHKJavY0RmWDnXQz6Pv5SDwsDkWHIS+J4F50/QvARQgo6x6M
X-Received: by 2002:a05:6214:3308:b0:726:32d9:db64 with SMTP id 6a1803df08f44-72632d9e19cmr98143316d6.59.1757079997462;
        Fri, 05 Sep 2025 06:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyLPSqn/5cyLU/ufeZ0J1VNb94Xf/Kcme1ni+D63yeD+5Me3DlASVIJOBnDX/9AWOyyQgd0Q==
X-Received: by 2002:a05:6214:3308:b0:726:32d9:db64 with SMTP id 6a1803df08f44-72632d9e19cmr98142896d6.59.1757079996852;
        Fri, 05 Sep 2025 06:46:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad52b4dsm1763359e87.152.2025.09.05.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:46:36 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:46:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Chenyuan Yang <chenyuan0y@gmail.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-qmp-usb: Set regulator load before enabling
Message-ID: <vda7dcqqfudhoiwbe45irfab62vbn45crfsc7smenskebuteon@rcutjxrfbwrm>
References: <20250905101243.14815-1-faisal.hassan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905101243.14815-1-faisal.hassan@oss.qualcomm.com>
X-Proofpoint-GUID: 8rmu4JhSm14hNdF9Iss9erBB31-b1npn
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68bae9be cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wC53ndoxZnronpF1UXEA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 8rmu4JhSm14hNdF9Iss9erBB31-b1npn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX2Lt9Nf6ZSxzy
 Dph5IUFe68ewKsfjF1Ror3+uBPWxebmDjPmeqt3IxUkPayfPW2gWAOIMJKhNjiMp6RVvNE5swW4
 5pFgjSU2BMXaN7GzeRwDZkjvHlCkh8AoRlHZn3qSUoPhN4uFogvZZCMK7GWtSxDYIWPaKUYg4Kh
 fH4WvWO7W45dviYQN8CNB86fcBkGX1eS6kidgO4UJ3Q2dQWbw+JO/tJUuqqavHs7FZ3onvw1uFC
 kzgsgsyKPngCZ2jjF5yFUOGolebguVb+iugIcAGV2OQdTbquSpWwbAGy0exhta0YbwL9THUfE6z
 /6gbtF907fUO8uBrk1RKDkKbA9y8AsqtgoTGZ7kFirgp4s80TLZJd4U/eH1F1r7/XSGTugXWYXu
 NnJENdPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Fri, Sep 05, 2025 at 03:42:43PM +0530, Faisal Hassan wrote:
> Set the regulator load before enabling the regulators to ensure stable
> operation and proper power management on platforms where regulators are
> shared between the QMP USB PHY and other IP blocks.
> 
> Introduce a regulator data structure with explicit enable load values and
> use the regulator framework's `init_load_uA` field along with
> `devm_regulator_bulk_get_const()` to ensure that `regulator_set_load()` is
> applied automatically before the first enable, providing consistent power
> management behavior across platforms.
> 
> Signed-off-by: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 27 ++++++-------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

