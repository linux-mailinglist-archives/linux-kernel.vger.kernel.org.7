Return-Path: <linux-kernel+bounces-866538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC87C000B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D33CB4FCEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4EB3043D2;
	Thu, 23 Oct 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hmWBgYYP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF27303A2C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209837; cv=none; b=fA3RIblA5CVF+TVUpB+JrnX06TaCb44l5rkyE7g75VxoPnWhpicDgURhBfSdP/QS8FK1zmw3AnZRnHnXHEtJr2KC9KuHKQhr90+dUCh0lXx7VwootQx3YoAhyuNLd0PcLapBNm4RHmkypLYIve8JdJR1qGAIvWb7Y57fI8tFnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209837; c=relaxed/simple;
	bh=6CnqC37eTbY5VuH8kxQHnEiVd9ZxJjZ6l7vkM9Xeaxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImNSY4aKj8zit3d19KgVGmoU+Kx/12stQCDm+JPH8Rr/KWfINc7Ua9SQYQ0VsiGOQnqToMQtnBOGu3wLzGTFD2gsYf/9qihNMwlh+Yx9flj/brSRaixmKZ89QqL52gaVHA5uA3f6S9gQgERMFT5RfQO1Az3cs4/yhxKGLmpEWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hmWBgYYP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7AinP011700
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lNE18kBABKPwFEGxjEK15XM1
	n6QIS5Dy2gILjWbl5oI=; b=hmWBgYYPMNr0aXe4kDE73cLq6UrT7cQfheOL3949
	tL/IbSt+IPPQvIwMYJRpZllCA5YrsJF3jIz2SwKesiyC7fTRP7czgo3Y0wUmfKmI
	B0w6nCA9eQIqnkqbdk17wmgQlfaTg4zosMnHNDzhstqxqpuQ4OeSxk85bvibYdoC
	9BI5LkVGlmWTIpgP41oqKERoL5ZP8edJv65j0WOtMwxT7jkfIE5F5VLtcCjmGyCy
	ypLbvbd16ESkz/huYlwTDaZzTj9pGJBBbbM1OrYpFHcqgYewp8b0u361Yh1eIhap
	ozvQ40VMKVGmyVjdu73MaUZxdCFbtFNpQvj2UQHFO2VO1A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5249w9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:57:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso601686b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209833; x=1761814633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNE18kBABKPwFEGxjEK15XM1n6QIS5Dy2gILjWbl5oI=;
        b=nxdA3THdzUI2gXV8JUsVJZ17rQLVPfQ0/DtCo6LSbcpR04CuMsRyi81YRd0X0s6/57
         kIBzDBqg/qYD71fhlNveZj94yjaVlO8xOQ8AXx+4AXlIo35L8tm7OcgJ+qzuQXrkoJ/I
         4b8dOx9qbXQM9WlCg3gWGlNsVd/12R1/Y0Knvp2W6LZaXdxG+pj4KSdJQeRwby36lT/M
         3KH0Qh4XNKgfQMx/u8PZayGd6PNxyxan7d/BNwCbnmhCxrV2oKKEB1Ndt7crXVyGrnE5
         9/yL2qzfc1Aa6UE9HAM9yeoNVYmdhBR9F6+i6I0B876ckZY+a76bXMrDFpuqWeUZjvhZ
         /XbA==
X-Forwarded-Encrypted: i=1; AJvYcCWpRdFkUGWFRuw2lp1wSe7JVbBkKmdBGC9ZojM8gN03s/RPDdhgrY5pkKfduVDY8KtcAKoWlNfZDpMR/ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95tazeEp7LAxVayzMmaEJhnFrkVHP2Q4ssqsPKxHaFcpMw3k6
	GxYW99RWe8WuEkj69z/KGnN1F0SHPKWfSLxrxzcVjN20kP+BQCfjQKzgn8DEd7GzHT9m6uJ4cSS
	sgwwXHuHhdPhoKpjCZ9RlGwOP9RoJgbmjorQ2Ox7QM3+4dJQaX6mmcgOIKOD4FXs/R8k=
X-Gm-Gg: ASbGncuomUPOhW9E/wwY7hZWhCFnSfy3Y9NwVeyt0oHFm03hx+yTCO64oMXQNk4gjbK
	yGvzCrfT3d4qOB6cY+9GA0GAtMHZmsc+2Eokls88Trc9nxsvwFbywYryS5Meib95flhzitniEQ/
	VQCCUoZvRUO7F6jkXAmO6y5On0xqtPNkkq7DBfkFFqgWPTdhIWs78A4fZ70ejY8VjlaBuLK1SG8
	+gernNTrYPHcTecLbZhlESZdNAggfgdSMNbDZI7k3bA/RA7AXgAH+lFY8iMAH7kuV0JU1T0/Hxw
	bpMPTiL/mmpg2x3eusMEuMlGi/iXE+oZq3Ydli6NXhxPbtUe73Y6YblpPYUe2y+lNkV8FVISLEg
	3mYyfRNNYY4cKEVM9VXle2r3dw+hUxmpchOB8fnqSW9Y8iS9UxUKe2g==
X-Received: by 2002:a05:6a00:21c9:b0:781:1a9f:aee7 with SMTP id d2e1a72fcca58-7a220a5e607mr31700890b3a.2.1761209833347;
        Thu, 23 Oct 2025 01:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTrMxusQO9d3YWrx7AOvOf5y+PUG892+AnS4bSXJmEY45o17kf1UUxWKAK1eYBqr8xrk+JcQ==
X-Received: by 2002:a05:6a00:21c9:b0:781:1a9f:aee7 with SMTP id d2e1a72fcca58-7a220a5e607mr31700874b3a.2.1761209832869;
        Thu, 23 Oct 2025 01:57:12 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8add8sm1795740b3a.41.2025.10.23.01.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:57:12 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:57:02 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Subject: Re: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
Message-ID: <aPnt3quCWKLh0bcp@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
 <4f9573d3-41a4-4478-8c19-39716b29f587@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9573d3-41a4-4478-8c19-39716b29f587@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfXwJRrqwQb8Y8y
 nPgXTQA0LB32yWSLNuFS6d8kdQnogflobS8/KCKyYLhi+4JMBDKVzpfOaA49TYa5RtM9IJFmtb4
 q89L10DvAVTPfpiHyB1VGHGgUHD5MN1leXVBEKps1EpMhhG7fd/9/GMoUj3hAx0m0Z1LjEOY6vU
 SQ2jKSUULXm+wk06zlsl3L0lRbVsYYDmROICgsA4omLi/f3ug+KQ1JeSJCUSrvGo/xlKSYL/R1k
 V+pKu2YTzN+CKqomSw+Q75kI76+BEdb0g2escvtXcobL28CICKIV8Zvqtv8iPghogGfdeEB8jb1
 YAEpFNg1bUjs2/ydKczlfXTLknNYQ/KL2cRHuiMza70qWPOCzTuCxh7rwRox0hDq3hLy2FaOTpk
 A9YPGIV339/QhOR6zwRQ5K/JmzwAjw==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68f9edea cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=C7owiK3y1AEyg5OQH4AA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: VoYS6X4h0RUE4ojX6FmDlXDcBWX9mMBF
X-Proofpoint-ORIG-GUID: VoYS6X4h0RUE4ojX6FmDlXDcBWX9mMBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On Thu, Oct 23, 2025 at 10:22:12AM +0200, Konrad Dybcio wrote:
> On 10/23/25 10:06 AM, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
> > VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> 
> This patch should have been sent separately as it's not at all
> related to extending the msm display driver to support Kaanapali
> *and* it goes through a different maintainer

OK, get it, will split panel patch.

Thanks,
Yuanjie
 
> Konrad

