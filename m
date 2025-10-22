Return-Path: <linux-kernel+bounces-865328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A80BFCD36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FC93AD87B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551222FD1B1;
	Wed, 22 Oct 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PucaDMBY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E934B681
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146136; cv=none; b=MBs50HuW0aGO6hWuFkJ1CpBSbl3Hx7UyNlbA4TpHdaZDoKE85rlk+0jeRfvAAnarXeJaVUwvwCp+7hBOjxiHL2RSo89rqZs3qjgXehMnK4Egu8CHTbZR32gUuzVA7CQiEJ7hQcAG/MBQcP+TsutOVk0ONdZbCHiOxWeoo24dKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146136; c=relaxed/simple;
	bh=WMIMwGu7v18FDKKJiIcw68EOolnjXiaG0jHWCuQ5J18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jltIBNLSMVO3Vtzp47ATMS7BQB6mR7eAAdEAyJjDgfSux/jFiMdaobgu/AEy28DtwDJwqhUgeFmo/mQpVE9AmAEp3IsWm3cvVC+ibTUltWrZiqoOuIa7ml1UvfO+MKu0qk1K9ORmb1CXN5F+wdhV5be/iSj/VGtndKjB7bku6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PucaDMBY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAQNCQ005281
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OdkI0P3aHIPeVo9m2/RE25vv
	O4vI7yj29ODppPkFbYw=; b=PucaDMBYv1WK0qPWpZF2Va/3Q8GuClfUVNvyCe53
	LpBRo8eaLnoTy5QP6Exyow+c2KjQR9xooGIIYxHbZqlubcJNQPv1fjjz5q4AAy1D
	Y519D9hwHpMZNafATAmPUBw4xHcAarkkZDy6rga/c4+U3Q07hiOM1YCuVCX19kFj
	/Onty8pKYGqa2/lOdSSTITDNEes4Gc/12DXwncaq+LXkOs7n74o4TyJWDv0I8Nde
	ekb6BcK88JJx6Congmc9y5HsA9F62IRoFHEK4YVYLBwSfKspLFIqtWkJfvIiJQlL
	X72I0OIDhq2phzCU6LajcodLH3qfqF+QOlX15sOIWa9HYg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfn37a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:15:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8a9ec4746so68242041cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146133; x=1761750933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdkI0P3aHIPeVo9m2/RE25vvO4vI7yj29ODppPkFbYw=;
        b=XZSLKZxpTv4nbbYEa6PlSXhZ8PTaQCTrpAnZ8AaPdZOCtz9z4/uoaHgJt3AQHzz+lM
         VPh8ZQ7oV4xmd8RNOE18geGJ3WQtTGh7DBdAAySsMMTmJBgQ6F3YJy5hGW/tRqlHpJfo
         3tOwsCktzgfPWZeZkwfWDhIVgSOpTYxFKPhnfsZWP62+752wxtXzn3CUR0eXoBsmd8yX
         T4XGZlGXsYIO0teQBDiWmLY8ei9MLmoOx0KaZK5ujWIBD4w5O8effji9SfnlB9r8XPif
         /ZjPvTFkzmC0du37Wo8hBJLGNjTFrOBiF0/pIJ2ZMGp2toP5/XUqRLRkxVHI4TodjHam
         xkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKb762mG35ajiNMT0BBJ3JtOInPAKTWHKkCH4R1k4W0ayTu/xKOXC6ZNJZVF2gz/nemVk3bukPXT2Z+3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYx9zqkMH6IR4bnCv8RUSc+1B8cHDCDTFm0ELaAX6jSmvLW1p
	p5f6cEdVHtBhEh1fXCURhlqJMCwVGFmFYYEJQ0KadMj6Y4EHt2Qo/oB83c9Owp7UhuWljwupGJg
	My3ozJtTr8sn2mZwiDqEzAbfFTyWt6u3eOviO/q/hFIXEDKNYp6BsMvvVYkpc54GhrFJJ5tOoXy
	w=
X-Gm-Gg: ASbGncurEX1N9/8C/Poc0azCJtTbuYzY99K2M43/DWFif9wtPstbzUwCMPLqMQTmR4W
	IALtdu5yFCNK1zMVIUpKtEMCLb2AxTnCgqpYe3fDEtXAGwdvE6kb81seZYjUfQfj1K5PhoJiRwh
	46qdIk2nYlwU4YgJCjG9tqgEBiRX+cYXfZDOKC0cQ935US2zcCqPYn2fq2NnMkKZ8KOBj/UDKa+
	Mr6bCKf1e7eZXmFoEHfNdgaOSpSoQo689N2rlt1Nh3XsNvKainVROjTuBeNKRn69aHEHhMH755J
	aOL7EZVVVM9i0x/hcrYxr6zNAHHCLwJKi+h4C77qSVAeLkdAhZ8nO7OSOa1I9Cp7YWr2v9KR29o
	All+kGqGhelgGQcW8dZ3Fzk4vFZ1Uyt6nBVAvqxJb4gmy5RcGTJyO3L3MA/7v6BTuMJVCsWzB63
	YH1fBR+R9Llbg=
X-Received: by 2002:a05:6122:459a:b0:54a:a048:45ae with SMTP id 71dfb90a1353d-5564edeeb7dmr6086304e0c.1.1761145769059;
        Wed, 22 Oct 2025 08:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTW7Za3xYid8rhr6v4z3vSiXm/haXNAQidSfHTGA4CeMN+hQb2XyvJwGutTkYmU9r6673nbw==
X-Received: by 2002:a05:6122:459a:b0:54a:a048:45ae with SMTP id 71dfb90a1353d-5564edeeb7dmr6086265e0c.1.1761145768577;
        Wed, 22 Oct 2025 08:09:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1ecb3sm4735512e87.95.2025.10.22.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:09:26 -0700 (PDT)
Date: Wed, 22 Oct 2025 18:09:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: camcc-sm6350: Fix PLL config of PLL2
Message-ID: <qanawqrk6izypwmmuvezzff37k66ptv2vlbdwxs62dqx7igop4@wzkz76376jli>
References: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
 <20251021-agera-pll-fixups-v1-1-8c1d8aff4afc@fairphone.com>
 <06aec134-4795-4111-801a-469afdd8977d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06aec134-4795-4111-801a-469afdd8977d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SemoTN_1-imm-3T_3IThuSigX3jD5Vav
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXwRIzcDpKjH7m
 Eg1YATWm+rZVjoegIt7ycpJFBPvysQ12he7czAM70u2TxxFo8nrNPBOE9dcH3OEwUJ8NSAmaj7b
 3dXk8xzrwl37MJGXHFWlx+mhOBl6vimPuMqXbDbNECediTrj15OwTNsQVeSj775TrEYd4BARvaw
 TZE7agG5jVqhO458vAYipcxbkubydvIqZAgZM0e4POpK9UU2n00IOGzhxJiRlQJOmY/CDPY5eFB
 IY5Vgxvqo5H1wGDw5kKWoRR+O4UVyG7A0rB6BcBA4GPWbt6fB0bNoBiAX+PfqnIWyRPHOtAeAlm
 CGAnHyD4VO1EhXv+0R74+cQBUJxKrfQI37161JFD9LtVZlvWYiNhKI1KcpT3g0+EB+dXaRoWnFK
 myxpYzVRMmgAJHd5prJWchu08CzwFw==
X-Proofpoint-GUID: SemoTN_1-imm-3T_3IThuSigX3jD5Vav
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f8f516 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VhJX9ptpD_-VFgrJVx0A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On Wed, Oct 22, 2025 at 01:19:16PM +0200, Konrad Dybcio wrote:
> On 10/21/25 8:08 PM, Luca Weiss wrote:
> > The 'Agera' PLLs (with clk_agera_pll_configure) do not take some of the
> > parameters that are provided in the vendor driver. Instead the upstream
> > configuration should provide the final user_ctl value that is written to
> > the USER_CTL register.
> 
> This is perhaps wishful thinking due to potential complexity, but maybe
> we could add some sanity checks to make sure that putting things in
> unused fields doesn't happen

Should we just drop those fields and always write the register value?

-- 
With best wishes
Dmitry

