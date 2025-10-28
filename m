Return-Path: <linux-kernel+bounces-874087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66885C157BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C4D464D47
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024ED342173;
	Tue, 28 Oct 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h06qaQll"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC35F13B58B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665446; cv=none; b=hb/zcBCv14ycP7U8EMHAdH/O2saxf9eijXTDjkiAtJ4vJkL+LatFBFrh5ci2YQgIFBJLTJRLb7bWmO6fNZ+pnaKHQgkyIn6gV7XiSzPSVOFndAVbIhLvlGPlTHjuQM92+8WMX3RsJLAI5qR0cL5eosJbgemuA7LTvCZ25GPMGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665446; c=relaxed/simple;
	bh=6UdoDHAGiXRiJ17qlm2HrguwWfFedEm2pbn/57l6ZMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UENAMuAheqpLxXN/gVsUYlyhG9xEnBox86u2F3xWFvLGOzG1cVI/2u5NjeH36BkAmHpck+7YxaJWVVdWc6EUX+EV4r8LTIQNQDXsWEoBPbWfvqrd5aeYUI+Te2KBZCXsOgjly61X44eyoJ4UfRKJFgE7CmutxkzQWsRXCCQirYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h06qaQll; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEnkK01936754
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pG8GKW3HfZTiiq9kKHjMnUDi
	5ZdEQ727ySpcizk4eG0=; b=h06qaQllr4bKn546rCuCVciUE5BKlH7U4SHq+A9H
	uDKhP81sgOm+G7hiMkdB5bvQore9MHc8tH75UZ5ipbXZIaTnSb/UkqV5gjXKccLh
	qS7oOYiaLAnswuhhFItjDKps7r8uEx1TDdlfiDtfVjndK1C6iRnLVbs3hVSJCf1k
	7ISiekn/Hqge6ZqWlt8jOI2Hc14QusNYBnDKzJ8Lwqn7bitdFCCjramSye9avwcI
	yLsRwkspyNYeO8eY08dnwlykWdv3I6tsVGW8xrxmUsUU+pldTH1z3RV9xBqMW51c
	9+8lhxF9kNkKMejRRqSR1OJbJw+gf3ZO6jgaZk5qn8W31w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2pjf9xku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:30:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eba1cea10dso188589081cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665443; x=1762270243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG8GKW3HfZTiiq9kKHjMnUDi5ZdEQ727ySpcizk4eG0=;
        b=kx69FNbVWr4gWRZ2UjcC2eE1letxK6qRuN0cp8D0B+ERmtQVlV8j1FdIz81GPlfcG7
         HECbFAPl2GTiG64sUhWf7h8f9nIuCrRaFegrQk5hngBpccHJGhsKjIZgNDq/nsn4LaMc
         BWJuksbklMWzq6GtzcOlG4LnWy/hWpRdCbYL332RDBtzqUCRxIy37UrBvBVmwLPuV89z
         EKf5THwbBndSO/TL9i5CEXnr0tnFUxy2BMRmhCg67O1hxFdnSQ9wmuEp8lCdZsN6Cy4Q
         WPbn84qVH3/o3PiGKCxc+OpbDXMCQoRAjZ8EwYLD0PT6BheMebJ2aOBIUiQ0d25xYKyP
         AiRg==
X-Forwarded-Encrypted: i=1; AJvYcCWy00DkQuBUHx8uflS2TezS2gHM9c7UgeDns6CRibl5uKNyN9C8+mouGREJa/lk+CtTuiE7aYzVDHBbx+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI1mEfsmJSnApfoq+hPJZrsg4vgUQFNh7+G2PDqw2OWWkTCIRf
	o6bofaCX0alO95YqjffUGXNNUkyapglcg2NPUh+CrEkrlTl+Kk4o7dXbTdKKQt6agvT/3u+DZXw
	rYkQzxyStT7AHx2l6dQaflg+AMEH+c5E6wX9EsWdegFAcr4v+Ds0WFIcvXsXx10/O908=
X-Gm-Gg: ASbGnctJ7QvEZG1T+9pb/P05Vmyj/qzClZKrnxThOA9ruqYVitqbqV9LrTCONwRhA5F
	lgsQ9AJJVttQlq/wRbgZYCIUZpRpqPF7E+Hh+3ZMK8N/PuYIZjbyNLcFT8s5dm0huJT/Ie99p6f
	H03GZcuhoVhzzkawreqSrZAKicGx9EOwfSqPF1001Y1zfn4DWXS2GqeuNWJXpUKfv61nUoTZTmN
	6sJ2su+TGQVm1TWLm9l39XY/rjPUHzEo0DefF6p9hCtuOrtiWleDV5iqcftcQpFRaUtvPp/PsQu
	talsJi3qyazNFX5UE2Fl4zXs0300szTst4YvuSnfnwa8AHExFf3Q6F58sSvcOzAnRat8/Q5+Dwa
	atmQ2Vf6iYyxR/zUzFOYKLpdVXJp0hbCXnbfkYstCReEehFSArkW9FYtjFe622mldpdkMYk8Fqa
	rrE8tvZR+hw+uf
X-Received: by 2002:a05:622a:40a:b0:4eb:779d:e8a6 with SMTP id d75a77b69052e-4ed07675524mr59981311cf.77.1761665443231;
        Tue, 28 Oct 2025 08:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe3rwV3Bj/ayumOhQ55IcihIE7syNSfSWRZZUZGLZY8iz/NY9dnGezaGOf1Kquhk/VAmsHrA==
X-Received: by 2002:a05:622a:40a:b0:4eb:779d:e8a6 with SMTP id d75a77b69052e-4ed07675524mr59980681cf.77.1761665442708;
        Tue, 28 Oct 2025 08:30:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f68e9fsm3155404e87.71.2025.10.28.08.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:30:42 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:30:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Skip setting orientation for UCSI
 version 2.0 and above
Message-ID: <xboq73zw752odclybviqnl75pp2nl2eamdvcdv2idqljck7qvu@zdh6ny7nja3w>
References: <20251028-ucsi-glink-skip-orientation-for-ucsi-v2-v1-1-93e936ac59b4@linaro.org>
 <a4f3yhhz5sntno6gnfbjnjjsbtyo2e4y3da2aywsg36gvxkaxg@vw2vryukrepl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f3yhhz5sntno6gnfbjnjjsbtyo2e4y3da2aywsg36gvxkaxg@vw2vryukrepl>
X-Authority-Analysis: v=2.4 cv=Ut9u9uwB c=1 sm=1 tr=0 ts=6900e1a4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=ba_8BwYL3biiwLG8ZYsA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEzMCBTYWx0ZWRfX6ky2f3occexx
 o44obiO5cWyuCRU3Jq6JvfTMHUSOZpEqaPIfbA70x/yF55DqQOKRXPD0xRSDea0zybRU+imCB9w
 JcwD4WZHfH1KaLX0hnYsdKU++WUr/cC08jTYxPGic+qb0CHj01gV8NayvPPnvtzJBVTe8hWF5fF
 b3mtHaaYHc8qPWcnbFKx4ONl25Q92+v75CyD5mFQXxiZJOLwD9G1ZQvY0c+hquhfOhFflpzG4Av
 FWLFs+hlP/s0rfqeu2GkF9R4EvLouxInz8tTO+YUW7ECsp6JDH163n1lC1P90Xy0Twqot8Y1Acv
 ltsdPqEh5m4xynPLUey/MoEgDP2tpsqYk3H0WHiw7vcStvmqRF8bVwgNTauVRE+KX3emHcyN4J0
 gwk4MzkNFJP7tQZNwLczWOrj3bYXvw==
X-Proofpoint-GUID: zzDj9VFQ38E9y2zfM3z5dMP-isemTvwd
X-Proofpoint-ORIG-GUID: zzDj9VFQ38E9y2zfM3z5dMP-isemTvwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280130

On Tue, Oct 28, 2025 at 05:19:58PM +0200, Abel Vesa wrote:
> On 25-10-28 16:39:19, Abel Vesa wrote:
> > In case of UCSI version 2.0 and above, if the orientation is set from
> > glink as well, it will trigger the consumers along the graph (PHYs,
> > repeaters and so on) to reconfigure a second time. This might break
> > the consumer drivers which aren't currently implemented to drop the
> > second request of setting the same orientation.
> > 
> > So lets leave the orientation setting to the UCSI generic implementation
> > for all platform that implement UCSI spec 2.0 and above.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> Ignore this one please, as it is incomplete.
> 
> We need to also set the orientation_aware in pmic_glink_ucsi_update_connector()
> if the ucsi version is at least 2.0.

Note, I think it should be set in the core rather than setting it in the
driver.

> 
> Will do and respin.

-- 
With best wishes
Dmitry

