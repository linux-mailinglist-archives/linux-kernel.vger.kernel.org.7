Return-Path: <linux-kernel+bounces-842488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F4BBCD54
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 00:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CD2E4E4E52
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2128E9;
	Sun,  5 Oct 2025 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GSyeppwx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B53FC7
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703010; cv=none; b=YlNDFROwLHwpcW4eFilaA4zg36PCt7GkMwF58D3CWYweOKcSfsMBD0nmsXIrZcUqk4zOwHqSClX0Y3Vm0gjzGzCNWVANLe9485Fs424jxkelak7sk5CWY4tNYJQOb4vdtdPyyIYOaaXHKaspKZm2qwdqyu9CONumpRR8Qd3E7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703010; c=relaxed/simple;
	bh=Z/d1cmHnIpZcYmrdaRS5TreRCAVULFhW1i/E94Fp3Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPOuck7xf49OUWaLrhgfrGs4dug/hAVKg5tcUadzyJ4PVAf+sdiIuJX1QYG+rykK7aMIU7dbVR+5utlAYBEO+dBAXtQiCKwFL28G/LzuhIsdUo3BN02IZpBw/tH/rKcl9WIYHtguMRHES27tCov7R+68rvUhiKyTDrJtNgD6RYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GSyeppwx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595IJm11013480
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 22:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HkavZTNmerI5o65w8ncgVohP
	1tuZa7qLx/+DCZ97ays=; b=GSyeppwxYtkpNvEB9CXu7VHD8FyexvjJz09BThVA
	5MPxqhXZyJSts66XXHTAxIR1bFnuhC9DZxsASNgp66jNYt0kM6qL/Gy6SQKvEEEo
	IagmU8JAAN0dm9q940Icup3xpYtcRaW72MRXDOLf/wW2l0Ejo3v3RL90taL3/BFO
	UIC5+m1OO2oec3Ed5BxYdFO02cLR/WApAA+MVl8jKA5PR+iweERhqBIos9th3Drr
	ZlOyJGcpArwWipc/xO53vlvDiZ02uxsfClYVmhkCRigoAvrGYsVy9e5LHy5EwoLp
	Xes3IC5K/wDYnhj9azlBhgUkRU7gTaggao9l9ZcX0hj3xQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1jghf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 22:23:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e574e01ed8so95541301cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 15:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759703006; x=1760307806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkavZTNmerI5o65w8ncgVohP1tuZa7qLx/+DCZ97ays=;
        b=M5ul4dTa2RQv9ClwsYiLruw/jVRcY2u+bDLG+ZW1xkUtm4ln1qvUCwumroS85ZGUlf
         ITlGOFI1T2egaNp2gt8SPGMyFHruefIIq3eC+8eAzkKcgHROy+xEzWcAz1hBIUGJiH4y
         uPzNY1Uu1aXFr9mw63dZzw3BNKEEK+5aiEzpcCUiJsA2Xaj32FPHxa56jz2k8YWSSETU
         dXjygCmTv7DlJSdHcmQ57jW0mqIU4hd4F1MoS1KzzdTnw9ugwVmY8KyYpSNO88nO20az
         vYtPlRG+yQDbYluZ7XTq5sd1jPZzagI7uAsNpQQ16edkC6Rk0vgRThEKS0TZNxg0pS+B
         /HMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvjcClDkhFABt2OVo6ZcHqycwq4FsEVSosZ5u1yOJuAOhUwBcqr9d4xcIruXGa31RwjFQG9ySh0LIq51Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUgl1+bfA+tq9zja8dDjqAvFZt+uubldue7SLsrE4LKPG+l2/
	0krMtUmFEOCtixZGUOpWNSVPMxwva7zxL9Sm0grIesQfExA9vjZV2j++0Fjddy8LiBqV9rVLpUV
	i4bUlSTEU1mB4eXe1ffqsN0dz3Nn80N72IwYm3+55q7tSvJqavb6Az3t9UZwmhDdRrV8=
X-Gm-Gg: ASbGncu067ifS5EIQEvSQwMJ6RsEeikzUBebCt+Bc66wFA4Lzdm1A7LzxeCTaK4/RXS
	WCh9u6UnMeKbjQvK0xEUo73tRa3M4KSo/C9pXKHwV3/jKr5aBKdqoAtK0uLYkG9i5p5ouIF8QrD
	+LCZiCVoT2BOlx9doLYAY5pnmIXFbfdihgcQ69uLJnDnlbD79zCxmIs6FQBj3FH/U1jr8pfS32f
	pnxlj8YlCElxSLT+jwqQ/f335wWcz4uRMqg0QFxgQLQK4wTSbBLeN7PzRbxupue6TNzAJttP7XT
	wUHuBLXdd3cky7pgcATyRgpufDpP9qJwHgIk8YQr6dRGw3EfmgfD4yhGkB6mYIuPO6pA/XqOIXV
	I3sbTr6BLfrkzOf/ym8z9ydrAgX5+VCTobhEfrBLuqvDwx6WwcSJRTi6Suw==
X-Received: by 2002:ac8:6f19:0:b0:4b5:781c:8841 with SMTP id d75a77b69052e-4e576ab89d5mr143936801cf.42.1759703006376;
        Sun, 05 Oct 2025 15:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHusGPKlhdeM3kKfumOVt6gnrGqSczS5SCraNaBCAp+0/JuOqrHjGq6QZKCt6SI0m+MD3AuKQ==
X-Received: by 2002:ac8:6f19:0:b0:4b5:781c:8841 with SMTP id d75a77b69052e-4e576ab89d5mr143936711cf.42.1759703005960;
        Sun, 05 Oct 2025 15:23:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm37937761fa.30.2025.10.05.15.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 15:23:24 -0700 (PDT)
Date: Mon, 6 Oct 2025 01:23:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chris Brown <crispybrown@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>
Subject: Re: [PATCH v3 09/11] arm64: dts: qcom: sdm845-lg-common: Add camera
 flash
Message-ID: <gk4dxz4wavdc66xr76bwiwu6o4f2d3iyxxwnyr3onmkwhlgk4k@tlvnmzbfbzbl>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-9-b14cf9e9a928@postmarketos.org>
 <42463474-7fba-4df3-9dbb-24140581690f@oss.qualcomm.com>
 <CABN5=wEpekmKxFCr7nBcYGSt6ZH-g+bx7Y5Nmoo=tMrorz2XBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABN5=wEpekmKxFCr7nBcYGSt6ZH-g+bx7Y5Nmoo=tMrorz2XBg@mail.gmail.com>
X-Proofpoint-GUID: zP74OPLscnuFc52QnS18AeMo4UcSv4Y9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX4kZmH6obns7f
 43poVjD9pMwfI6VNDlTJCgXiaTNBAQ00OSAIymgYVham/u6MfHFDFDAgPf6KBnTFOYk18LmPC+K
 2e40iFyUFU+w4cdvgNAcAyyiQOtCbi7heI9pdKucnJfd8qFLNnNf3fYBvTzy48AYJudGc9jUQQi
 4LAPgA+a5GAUzvPao8RU1V357y+xsPsW3wk3+zzhCkQpYwlALxxJczF6cKHR6QFttF6pJ77O9JL
 bfeUk14WY4fRuSYzt749uSM2JBesUQWQNijnRs4zkELNAsn3QAcwANJxqLYANWlXkDTUnO7OP1P
 jv/x0sIe8vA0E/tHcgW0V0e0tW3DgpST7AMBCDtTrBuXtXP3wKDvLBK3C1Mk6qOWEpeYQQR+yrG
 yUlAjsm+GHrwonGvVX9TGRrx5KDh1A==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e2efdf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=4fvD49LNPrp0q1SnXk4A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: zP74OPLscnuFc52QnS18AeMo4UcSv4Y9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On Sun, Oct 05, 2025 at 03:35:56PM -0400, Chris Brown wrote:
> 850mA looks correct for the flash, whereas the flashlight/torch should
> be 100mA based on
> https://github.com/EmanuelCN/android_kernel_lge_sdm845/blob/U/arch/arm64/boot/dts/lge/sdm845-judy/sdm845-camera/sdm845-judy-camera.dtsi
> i.e. led-max-microamp = <100000>;

Please post your answers before the question rather than at the top of
the email.

> On Wed, 1 Oct 2025 at 05:04, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
> >
> > On 9/29/25 7:05 AM, Paul Sajna wrote:
> > > So it can be used as a flashlight
> > >
> > > +             led-max-microamp = <850000>;
> > > +             flash-max-microamp = <850000>;
> >
> > Allowing the same current for flash (brief on/off for night photos)
> > and LED (flashlight which you normally toggle through quick settings)
> > sounds no less than suspicious
> >
> > > +             flash-max-timeout-us = <500000>;

-- 
With best wishes
Dmitry

