Return-Path: <linux-kernel+bounces-842789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F2CBBD9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7587B4EA83E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556C7223DE5;
	Mon,  6 Oct 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LbYuWolJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C17221721
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745221; cv=none; b=SocPKZRhVzyOTqPmLzIL6bau+OmR416nqES5CvhzythqBFRFLwrO9MYaDI/fTSj0ARiolIHeLm5JdyRLRkmFXb/r5S4VajOfUJ3mGt8Tzrvjz9p7H6fZL/D4NjthPz/9EDMslUPTKuYnEmrNpCN97eyOoc9PO1pNwxDtBVPzI84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745221; c=relaxed/simple;
	bh=CvVyk63FV1Hh/uDxoHt5oihoELVg2e/crLKj5/XJtR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLNQwGXEdCcEFk2F80G0+GhhrOJwHNrWRL68FfXx7336fhLNZb3ZTMqMwN+ZpCWj+C+uzAmzs9H6+CkYpCEy5hJe0tLyvEhoV6cKiioCBuiRlBDiaCfKsLH48+dXP1EtMr2pgYzFOK20KQCHBUQAe2t/6HNUIucC1ozMQ3WZdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LbYuWolJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595LNTmn022342
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HGxB3VffzX2B3tPfiQDIObxF
	W8b4BEQXi9X0DSTOgU0=; b=LbYuWolJXZ4Ea3840k5mXG1qEJ9tIBuApey331ZV
	v82jAjeZc/kdYJEoSAh5qLtrTMNRFa+APHDIvSP5n5GUUYOaKm4c6LMMz5m+auAV
	rHihvfPlyZkShciUFF/GF1Xpen2Am7YoI5vZJ0ekcJDlg/BSDaFG1RHKm6P0fBbT
	aqelUg2VxeRUmrmu73xUYW5taPIgmdUqXr64ylGv4W6e78dk2DmQmM1w1u+BuTpp
	CtrSG9u+kmgI2xBtrI0Qeqjo+eWfuLd2fDAWl3CX2KOSqUd1t8oejrIMTnp69wsM
	nRcOpe5VcL/BBozf3oqgQ/phngsh+0aJX0rj+2l0i3PUUA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthpun9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:06:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de801c1446so103754001cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745213; x=1760350013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGxB3VffzX2B3tPfiQDIObxFW8b4BEQXi9X0DSTOgU0=;
        b=S8IicztPP8DBG6WNVWpoQ4T0Oh0ZLAXZ+58Dqxdto1NR6wqxar/LpORClMhri3kQaz
         9viP0/XtthvTC4xLArb2KFLbEpuX2iKplnjASR5BJQ+fdvvlaqer/uHqfwJhN91KfJWa
         ZwqcyEDVJBJ9JjLFzb2BA9D+oV/S2j1znf6Op0gNHE5GdG7hONXuZxR7ZEXzxTDIzlpv
         XlFLkyhPXhb6UvTcFigeziuOdjXC5N9esFiwVp55+y70sl4eGz2+pkRxC0SdJsTZqHkH
         03dLuLZ214CP7QDMXx8GEops9CXfjYaOC04MJa4PZ0HSiSBCpFyXb9A6PwbNzk4zr3Xh
         2gzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk8qNTsTYms/31D5zk0biihXG1O2+PESwRrm17Vwx38qmgeLdVKZZmbV7qLvb3L10qTJxzYup5JZhOktw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GVXG/YGwI5z0l4axZWAw+nPPw0A2Wb0s7D4C+Pmm9sLk2Jlh
	eYMzR1eSKEdzN7z9PLQnF2zaWnJMtG4lMnT+O05LNUegXclcosvHfAwXrwIetHgM3I+04GAkSYH
	TsnMGQfQUCNm65njYk/qLdIRh5UvmUW9uv7ex+WPlm/5P7usNuUQHpGOM7j8wQ3Q5ERo=
X-Gm-Gg: ASbGncsJxZtuTaO6Obw309rAw6A5a/2E7Qm726g4bLhpZGBPGNaH5KgUSWtxBXC671A
	NYurYlHO8CviPWTvaAIyUJneFrgc+sGJl3KCoH2YqdMeXE1Lj7XtF8kXdNXoLY8dAKsf4mBNdyz
	HWGij5Ca26AsN9u3xId4APVueaAcewYuMpt1No1grXQAhlUNl0fCSM//u1cAxHIK7qRes2qYauo
	e0SLRMmVZAu3Khpr4MbdkMjc3Ypaei2fT2jfKX9oOEvZrekE4FiF5aDMB8T+Ek3kxgGyMi+i1cr
	6A7Mbnmvd1wM4eA6dlAPga4W6vw6gSMK2oKQ++uT/oKT5agBylsP35/mOBBxSjs5TinKTuF/hn6
	C91cirQhbQ1a+PXex0QHnR2ERryDrbD5fEZMrZHmamvgpVLq82joH1eIGxA==
X-Received: by 2002:ac8:5f4d:0:b0:4de:c683:441a with SMTP id d75a77b69052e-4e576b079c0mr176285491cf.58.1759745213369;
        Mon, 06 Oct 2025 03:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8lMXLpbpaW8qgeVwOmhaoJD2KaGNc3MogkehGsf1brzqQQ416JOW9/yzxpzpBq/+gSe98Zg==
X-Received: by 2002:ac8:5f4d:0:b0:4de:c683:441a with SMTP id d75a77b69052e-4e576b079c0mr176284821cf.58.1759745212680;
        Mon, 06 Oct 2025 03:06:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119ee99sm4898508e87.106.2025.10.06.03.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:06:51 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:06:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
Message-ID: <jaepvhr3zwgiaievndntfpcopzinfp3psktd6anl5ovzxl7ekd@enamcy4e6puy>
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
 <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
X-Proofpoint-GUID: jIPBfm5o3UxwHu4LJtYxoXMNKfMxe1hc
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e394be cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nBxtwQxsS3NGOZXr17YA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfX19fIZ7iIw/xA
 QjJ15CmD4CPnN4Rhyd537LZbpgaXVSSaLSTXBoDbzvso7rrVToX3tpFjPZCs8EM2ft6CXY58uo+
 BN9/ETSXuCOq9mc6Hp/T9DaTKVc2Z1xJsjmUsJVZt1T5bNmJcQ3mOEyK8HKVxw4rP0iTeuHPCCN
 uGXDadg5E3SRW9Pmjk86K4rSaIuFCKIAoj0sAlwE4cvMT74lionUAa6L7C6WAU7/ELutobq6f6y
 80cOt8FM77qsE4hQ0LbRG+RsuiyGrO6ObyktjlrYDgI7wwL4lJXGYlCXfmXRB33O5rZOVwv4O/F
 G+Mt+td0UNIj+stKAtlwUKvhtwDPu+6cpjxK2rMHDQnZclM35Sp0QUspIpGOWv/qwrzXNRMrq+C
 93fw4GUxA3yq0d3IdjrvFFCe2jEzEw==
X-Proofpoint-ORIG-GUID: jIPBfm5o3UxwHu4LJtYxoXMNKfMxe1hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016

On Mon, Oct 06, 2025 at 11:30:52AM +0200, Konrad Dybcio wrote:
> On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> > Add the missing interconnects to the USB2 host. The Fixes tag points to
> > the commit which broke probing of the USB host on that platform.
> > 
> > Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > ---
> > Note: without the previous patch applying this one can result in the
> > kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
> > applying them through the same tree in order to make sure that the tree
> > is not broken (or using an immutable tag for the icc commit).
> > ---
> 
> There seems to be syntax for this, at least for stable patches
> (which we should probably either use or add +noautosel):

This syntax is for stable trees. At this point I'm more worried about
those patches being picked up correctly. If the patches are picked up in
a correct order, they can be a subject to autosel (provided that it
maintains the order).

> 
> * Specify any additional patch prerequisites for cherry picking::
> 
>     xCxc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
>     xCxc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>     xCxc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
>     xCxc: <stable@vger.kernel.org> # 3.3.x
>     xSxixgxxnxexd-oxfxf-xbxy: Ingo Molnar <mingo@elte.hu>
> 
> (deliberatelly added a bunch of 'x'-es to not interrupt the maintainers'
> b4 workflow)
> 
> (via https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst)
> 
> Konrad

-- 
With best wishes
Dmitry

