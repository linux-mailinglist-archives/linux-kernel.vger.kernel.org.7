Return-Path: <linux-kernel+bounces-874691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95FC16DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC5B188B080
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1E427464F;
	Tue, 28 Oct 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3zMR63R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gnl1H8RR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B7221721
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685579; cv=none; b=dxiI1VRvyvZTOwtuty/EKq97M8u4jrx3bYbCiqtW6ASitDNE/0o7lzhjgraASuqCvC+zLUdQcz9PIDZAi+QEDz9ntuVT7nKLDsexlt8ZZO7InT2eo3CZivGwgPTjujEH6FSvaKKqPhRw6zLLkLrPdjD7QDd+F6xHWy2Qw6j+mCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685579; c=relaxed/simple;
	bh=9j5W6JKT8ymsBvgv3BwD7jABuN8F2x1UYrjiLwb7/UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNaIcuPVxcsQbFb2+fOiXMAIcvzd/ad2MFoKcbPLbjcP2OR7H2F8eTwyEtG5ynRcUa8bHyqhf+g9xeSF3cy3D0rDvz9BHCJijnVUdMv5BE1HPGMSUFXBjOeuob4B+z79FMz14sB5ghlIVnDPpxYxy1vl4WcCBX2SUrfRibyvxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3zMR63R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gnl1H8RR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlWm32503342
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3LuDd6Mqkc5UQN+6Kj33eDjK
	A0G6b3Ct+WK02iCqVko=; b=U3zMR63Rc8+9bWu7MD990IAbZnQc1JmD0cYakHK3
	ElAuoxoNkhHenZM520RRB0hRAO+XuMPW+hty4VztogTFWdpp+3NWvTUAPao/3gQi
	Us87yalsSQ2t0GiioPBTs8QMiNm9MsUNi64FBKtSmZyFbABrZn8OS0Is2QHTP9xR
	/n0RRi25EfQNP1JoNN2qzMBz0gUtoPXgwK52tJ05ndOpF54VXzcC4k7fUcorKkpZ
	+6Rgu2EZ0wX2OL73JIUJLqC2DkplXTY0iNhiNqbX0wK3N6hdN/f+k89M1/w6CPYj
	yrQ7eCziIoSOu9QVufu3/pZ1llklvO6qqgOTwZHUAcR9wQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1g5we-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:06:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf9548410so88164771cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761685576; x=1762290376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LuDd6Mqkc5UQN+6Kj33eDjKA0G6b3Ct+WK02iCqVko=;
        b=Gnl1H8RRDtPlLZS9NGO2SndnSw0SxPtKMZfAZAqjVCYtKwDtfXKzaAzvwsUDFkPWyn
         eseV3UIUhLwxTxBpEjKmjDMsYqH5pev3myMMfB5Kc16G5/RfylTT7EHLMHuzcAeSzu8g
         Ufp6/T7ZZZys4MbkBfWYNn/4H26LQJ01+LZ3AuMrvz9ya8AZTHQXsHkUpB37xkhLKBr/
         1yEI7OMYoC16ZnBw+82dwedjFY4KA5iL97SY/ihnN8i/aYmBLPhXnj39ZbgGMYhyBJdn
         Q1fVwnFQtMMgb+LVEhj8Ob5kpcqLDxI2dqa0kL3lGpr5dARrD4hAO4fhfCnue38GrOWw
         yYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685576; x=1762290376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LuDd6Mqkc5UQN+6Kj33eDjKA0G6b3Ct+WK02iCqVko=;
        b=DKFpnC6Tn0MmhSYzP6nvv2yxn+3MSw8LuDJMq/BjnFm06bjuU+sZ6/vqJU5yxDriDt
         Ay77PjYMzAdonTJmk2Ew5mh6Ka1kimfb3BOSe5AW8J+bWLeV9tkuLJN2mpzOrApEQdhs
         Cja1EO2VYENcYuxcMtp8G1pGy3gHetljLQPnwVNds1cJKmz5Z020d3f+iCc64V0YgKso
         nfh/gG8Xu4wp1gut2npTIf8khhlzjmR0XiCveIhsSuVy6xR2GFEZBKQ98ymIV7Jf/JnS
         Q6YdI/hSvvooW+ExSGc0RA3jGnd12nFQbIYKuPsn1/lJNyflRVZ7PhkZha4679NXhwdA
         Topg==
X-Forwarded-Encrypted: i=1; AJvYcCUoMz6w66+XORtjaLV4Xz1EvNxuBZYROM2humcGyTLRJx4u9bQ1B8PfDuYWh+HBQHq87EBLm4gbbF+R+NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaLxdAp5s19nl0dvJNR77QYQareI/ca2L6wbzjOA45KvTUel9
	6EU7zuhqftuWvoIhcJrOVsdH3fwONS1z/J7LEgIHaU1vko6OxQN33ChsMLKXDV+KOtogw7uc/df
	dYrnkdWqCg4gvnvHjZh+HMdIPI9sqmDeu3vHCXfiORp8lhbotcdHDVfGvANmBf80/8Zk=
X-Gm-Gg: ASbGncvuuN1m5ohKKgaLULrOm8GUdQgrnST2tpdridf5E9c6xw9HuMa2xtdpFQ0sNtQ
	21tzcAKKJ0TGESJSjwZ4NJ3tyu6JecaAnrj3OlLZBPTz9cxNZQOCl18ZvVd6xBQYwFbx1halyEs
	XVnawjsf9xDgAC2HI1oIT8cJ72N57m3Jle13pI0lQZ/EY9d98Lyy9nmgKbTv+uoSLC3+0I/JXZa
	/vLv2S5wbLyF1YTrtPHaGMKzqTT2791PigvXI99wJTjBSIhLczbaUthxI+p4tt+37Ew0jv79iAy
	fHpZ69GS9IFO8oofiSoOttKSvpwxJywmNmxAvcQZugHTKgXm1wWuZQugKDiQ2XhLNEuMx7jqLOf
	V4APciwhtgeG+eHWbd0ffqzpqdOPthShFCxgDX/eqvH3TidizqB0K/1daUg5SmZpyZ0MfEAxwtB
	3X5i/UGk10Ncur
X-Received: by 2002:a05:622a:2b4f:b0:4eb:a216:c070 with SMTP id d75a77b69052e-4ed15cc0fd8mr9754271cf.84.1761685576507;
        Tue, 28 Oct 2025 14:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsAXdNpraFNqns3dJFErOHHCkGYA7vRGOdqLB7Vapn2gKMaCa6HiAkrwDzj46FFPulHQDr+A==
X-Received: by 2002:a05:622a:2b4f:b0:4eb:a216:c070 with SMTP id d75a77b69052e-4ed15cc0fd8mr9753721cf.84.1761685575889;
        Tue, 28 Oct 2025 14:06:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09d2e5sm28860611fa.17.2025.10.28.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:06:15 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:06:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] soc: qcom: ubwc: Add configuration Glymur platform
Message-ID: <k5aszduqmczeuxpwzuq7wvkotvnqdnkhn4kdnmc6mjvzyxw6r6@kfa3cnb5qwnc>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
 <20251014-glymur-display-v2-7-ff935e2f88c5@linaro.org>
 <7dxq62ltoeerb4g2fgchb2hd7eomvlexfgyvamxsuuirblavtn@4bg3dy2bukdq>
 <ump2gq7hta5dzul7bwjmb45dtrxezkbticdwis7opl2drmnuyz@wwlanncd6xlb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ump2gq7hta5dzul7bwjmb45dtrxezkbticdwis7opl2drmnuyz@wwlanncd6xlb>
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=69013049 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=JArj1d4ql11fNzbR7T4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: IHkostrCVXIr9JpYBQ9gol4IOpdcCXtj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3NyBTYWx0ZWRfXzHUYfHczI9pR
 hcxF/tIiYr+YnArrsXm7c8fmwgWinO+5utQZCNcsKyO1sIhDIfZpi5/WlnDTi+MH4ThkRdoBhxQ
 +qaIQ8DtCg6LrL06pgGGT9Cuff+ZefEzWzXSbRYk9J9ZWQse0aaeHvvmDt+oGFD/pkUtftbjcMZ
 7cn34wDzEglIo8CXJ7NWTsoXZiyWhDThGywZLwYBXijMySn3+zJwkV7u9nh9w+U1rTMhBdAeHCN
 RJR+zVob3dCQeWtK19xRW97xmwofMnZKUKLtKX9VjNbJy4L69uE3an1H1//WpoMMiPsE9ci/Hz9
 56HKGRJ9mEweHrJvk1GvBg+4wKwfxL/Ex12MZyF6ih+0ZJMjmfG+5Qk/E9uy7txsgobyXV5ajgg
 +YJENVIpMcksVY/gz1vTV+jt+UM/Ng==
X-Proofpoint-GUID: IHkostrCVXIr9JpYBQ9gol4IOpdcCXtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280177

On Mon, Oct 27, 2025 at 12:17:13PM -0500, Bjorn Andersson wrote:
> On Mon, Oct 27, 2025 at 02:29:01PM +0200, Dmitry Baryshkov wrote:
> > On Tue, Oct 14, 2025 at 03:38:32PM +0300, Abel Vesa wrote:
> > > Describe the Universal Bandwidth Compression (UBWC) configuration
> > > for the new Glymur platform.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/soc/qcom/ubwc_config.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > 
> > Bjorn, do you indent to pick up this patch on your own or would you ack
> > merging it through the drm/msm tree?
> > 
> 
> As there's no dependencies between the trees, I can pick these through
> the qcom tree now.

Thanks, SGTM.

-- 
With best wishes
Dmitry

