Return-Path: <linux-kernel+bounces-871656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384DFC0DFC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4193A4184
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B522286D4D;
	Mon, 27 Oct 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nV6DbO+3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8D299ABF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571302; cv=none; b=k4BZlRBJbYenZWyAWYRa3h8iYH97GgvTvcNAN1Y5hjjGVU4J6iMj3WZ9RghBfSwDVJrO3tz1XSAxfXfbH4S2KWigiJpsjM56mKc0Y4Y/cSQim23cnwYIDxavHVupddmhNB6aJNHkrav+m8xXoywiKQAC5XQ/wlmMOqy0OQOVSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571302; c=relaxed/simple;
	bh=Uva773iEdDpkBIyZYVwtiOdB8QTio/mSXTL2xqDIo3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbiwXx8bu5OFgw948oIQT78PZO0WZeayNn3NaDkHV21neAY0Iffp8V92UWSRtygf6C3heeGKPBX6QnFXNxhcTeob86oqR7UjXXJ/BmmoFxr2VJKDHVpM4e2+6N70WiO/VpytAwOMS4BZctrNX1A15FbmacVq9gYOCGdzCNsbwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nV6DbO+3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8OW9a814958
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rIQxrF/LR8wD4VYuDzgo4pyg
	T4/SDSgx44EBgWbrJxA=; b=nV6DbO+3V3TP7iJifABgm+p0yKf+ze7sCSnR8z4W
	+BN6EBSgDdRRkclO2PDXuygXbH34Dx4lSu/beNQirSR6yoZEvRyAsqYcaqq0PiYJ
	6KRhqhsLBQZ8h+GRrkVCFqaAWkbBc7CMiV4dPrW5U490eESJjA0/qwb2TsMGivG6
	oQxqneDieGlsqKFKokuWXfaAEaRNV1glaMSgYMV6SQJp1r+N+IBZ+VSZKXReNZNp
	rW//c0Hs7YSQz7bClrlydJx8F9Yhglv5+zMQrdHE+QZZ2uyZorQGBQs5a6zT15Lx
	MhfdyTCU3WC4zdn7UWwMjnm6RLEbYFJgwfpSWmFEgWog6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0ps14mnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:21:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eb9e480c15so46325061cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571300; x=1762176100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIQxrF/LR8wD4VYuDzgo4pygT4/SDSgx44EBgWbrJxA=;
        b=ndqDbmmGvmnTP2MX0H5kN4uP9RL/p8B1Oeqd06MVFee+8qn+wod8QROEUpgX6FekH5
         1N8hVd08FwoDwMllrsZzUHxTMCx42Wql75WNXC2B4KZtp7I+ujKTdUz8/fgGJMZGiP4v
         ef6J/+n7vQP71W22v6GK3Z6DAc0K+iXhmMu5OonbTvyJqZJ5BJ43Gth+qU9hiAAywJ7w
         loKgBOagCJuBI2v+O5M3TcIa30moFfWhSXMpBrU5oAXHHI5ASMuqRyo0btEAj63sXyg/
         U1+Y2YuAnUuOAeaeLhaPF4o/27seZI+JxWzqT9Uv/CgCn+ZXuGJpeWw3hd2NC/OoILrB
         DqDg==
X-Forwarded-Encrypted: i=1; AJvYcCXNo2iqkGM5UEU3T8yhOrQGx3YjcPziodoRorMrAKzNxA49ckAZKXzKn1htKkS420eE37QxmiA7zu55pYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETNWZs/hV78Fyps2EttwSATS0GggbUAtKmnqvOGH/1bKVy+HG
	vnRIyzZ4QGALq8R4YIAMytPize4ligU96kk9WHPUoTC4tCJDMsNOomdPc/txLtxeNlhUySubNUk
	g2w1KC9WQ7Mds4tw+bffm/ECI0n5DyhppwckJP84pr0OrVrdcRuLjexf3P7kf0QVRXfk=
X-Gm-Gg: ASbGncsPfjUTkYgBcpVbMU3zVVPTUEejs6R1V3oeoVUzznKbc260R/ohsYZkXUMYCz2
	0wj2N7qYwfW+ZBbLfs4nW2+/3qKn0IB9KHRf8UsirB4/WI/yI2h93i17FKiBl2B71Q5L2jvSpYI
	gN3dG269uWvSIB5hzkPcm71dgga1oujTqYzKtPES7kJcMrgGs4tNsEQTkOukdOYP+Yn+RJF68vp
	Dsm9I7EdYEathyKUU5v7B7KLe8Ma+Afsvz3AvFWBNkRYyBfAqzTLeFQiH7h5R/6Mab6jAatmgFq
	31daOSXebkCLz2rkUnpKg6knMzT6hp5dppGqmtHjVxVu5m3oFJFweZbGU260iCp0VaB6BTd5XKr
	La18sz093ZEhst6jj0CHlFE2p0l4oaSG3DTzXMlXdcidt7S5XBUY5jQfKMN348QTjb7YXwUEUQR
	SnTWSbg27CYZ1C
X-Received: by 2002:a05:622a:4c12:b0:4ec:f035:d60 with SMTP id d75a77b69052e-4ecf0351008mr67145991cf.5.1761571298243;
        Mon, 27 Oct 2025 06:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHsY3iHzVCLpUn7wkz6y9duilAb8cRKkxlio5523RK3buC8sPqKlAaBcxT2E6xXHVj0E4Anw==
X-Received: by 2002:a05:622a:4c12:b0:4ec:f035:d60 with SMTP id d75a77b69052e-4ecf0351008mr67143811cf.5.1761571296230;
        Mon, 27 Oct 2025 06:21:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41bf3sm2291171e87.20.2025.10.27.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:21:35 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:21:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 03/12] drm/msm/dpu: Compatible with Kaanapali interrupt
 register
Message-ID: <st53uwtdow2rl6bvmfitro2dmodxtzfnhyzon4xeeetkkwekxh@ewlzkelq25wm>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-4-yuanjie.yang@oss.qualcomm.com>
 <nfekr4vi34ftxzyyf5xv4tsb5cr3tokiyfkerypqjf26dos3uq@42wcn6ji7nnb>
 <aPrre+WXogSZIE7L@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPrre+WXogSZIE7L@yuanjiey.ap.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ju78bc4C c=1 sm=1 tr=0 ts=68ff71e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=uwcRXY6SZ9cHZavlex4A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: z--PnRdxYBSWcDdT5kcZp8fhLeNnqGmE
X-Proofpoint-GUID: z--PnRdxYBSWcDdT5kcZp8fhLeNnqGmE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNCBTYWx0ZWRfX9L6nZdtMc1bs
 DgLByltNPrfoUI1hnI8pZsSQ78r2IPptxv4GhzsGesPXyUdLDAlCK6yvBSfNc8poW5M+X/IS7/v
 v3EMJqlUuINueNP2W1JDuyevR4mzXfnsBQVe4+y1mH6XsHvGyhOwArTXxPDTrGSWy3xcgVwxYZQ
 BZm2n1duxmCHdMMRxea32jhvjkeMFFzxYWOHW5pw3TpvN/bLOz0w+PT5p3A/XpHo6LESKX1C9u+
 njk7h/t8gA3AZpgNsEtqUvyuPSQo1kPdrCOVR8L9L1RDThI5VjY9kItOGCkkt/VBQjbBiZKggEo
 oZYjOzRGGH7BQcx90k9KKsnGEaST3gN6DHz50Otjm03e33Vx+UX1hsLxwmlXLshNu32+2Y7hidW
 MhH8I1hr5osfWA8z75ctu8K4cvxdsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270124

On Fri, Oct 24, 2025 at 10:59:07AM +0800, yuanjiey wrote:
> On Thu, Oct 23, 2025 at 02:59:12PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Oct 23, 2025 at 03:53:52PM +0800, yuanjie yang wrote:
> > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > 
> > > DPU version 13 introduces changes to the interrupt register
> > > layout. Update the driver to support these modifications for
> > > proper interrupt handling.
> > 
> > So... Previous patch enabled support for the platform and it has been
> > using wrong registers for interrupts? I think that's broken.
> 
> I want to express DPU 13 has different INTF register address, so need to add new
> interrupt array to let DPU 13 interrupt work fine. Maybe I should optimize my commit msg.

Make sure that patches are structured logically. You can not enable
support for the hardware if the interrupts are not (yet) handled.


-- 
With best wishes
Dmitry

