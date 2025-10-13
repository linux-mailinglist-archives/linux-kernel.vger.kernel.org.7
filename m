Return-Path: <linux-kernel+bounces-851022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC984BD5603
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48F84500863
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1961219309C;
	Mon, 13 Oct 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Px9nbS/p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2020E03F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373106; cv=none; b=W+qHhrqU4fgUTvD9ttTJHJACoOiQKLyngZXpclV1yOs+g7fFfkBaTecyBcNUIyLt0VaYqU1x2jax5DKR7MFuHpfdPheGxDtIm5eG5pFqxaNjx+PWx8aYc15MF22C55LONnqlfjQuDzedfwum5rG58DFWdbj92rBFdq4HilZeVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373106; c=relaxed/simple;
	bh=kurJp8JCs3541IcWv9yKM97FEyktgGNpVUnrbeMqMmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8WXDeyc106N9lS0Uiqs/2pbvGkd9TCntTYOBo0n8RKkl36IUadaVf69Obo5f4F3JtLfGib/wFKE2K0+v9/IcNAQHCg6DXoLx1OI6/R8mbTTh5ZNm+Ubn4I6EMLFozv4CRL6FaR8vcXR62XJJUiEqmm/y/jSCo61vLMM+aaG+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Px9nbS/p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAgJDO024739
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M+J5ukcMVl37T/9FWTJUvNGf
	Dr2aFnYEvXR1o2qyJEI=; b=Px9nbS/pmxQ1JmNLhVKQyzag9h7IMdeF/kr1sF63
	aqfu9t3xqG55T2XZqLsitCTd7MQxMH1xQF2ouu7vGlQmig+I02C2NoJSSu9DM0ih
	BBfJPoQMOwVV7k5RJNKOBPMEY5zqPelxlkMbBRSaZvCe+9nngn/Prb5KvfnZ1v4f
	21lbWSfAL/03H+rxYSX3Lf5E0xnFG2efLxbvuWxqsa9bDH4l/pPSNDWs2WHG9Pw7
	2WM7ZwJ6uH+NcxCLQxN2ZWuLKCzlhCk1tDkZEpd3ryTx6hbUPqm5yUXDBaV+64Jp
	MOaTEuuW9oePd1bBjzMWoEWWQiIGMNzTBroS2rRBzu3ELw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa85css-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:31:37 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-54aa5401327so3128826e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760373097; x=1760977897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+J5ukcMVl37T/9FWTJUvNGfDr2aFnYEvXR1o2qyJEI=;
        b=RZMisiaTpwPZjrXWzfZ8YLtTJO5efP4hF3kTImbmM7mBrFqP0/kPOugksaGJTYR/R9
         oe5AMYt2dcsY57qcEyYq+k7l0bHSYEVYHX9JFT1LKziGOnxAINvuxZE+mREFf+/MDnNM
         PNkQ0pfXDs8qVk8Ox0OU2ifxH3MhR0vYcWlyfLr47k2W8UFTC8WzBr4ZwhUdwzfII1aR
         GT58W6Tb4pxAlA34fthHI4AcKrRcWSt4tYgd7Z8WhM3PNTcu9T4294rrXMQKUgWQniQN
         UbeFkzR0u8+1T0H9WyvavwqIc81gKaryud9EoH85TkuJ11g0kyNTc9YsN181T8jeTN/f
         HaEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9xudsXnSUc3Hwln7yKpSAb6A4JRn6SD4fHOdWbE6Z6JJYkMPtuN9qDZ/JcrWKxvzwCmYHl8EhvwJUdFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJq+0neivrvFqS7rm40AQdWMVXM25ZwEIAyfLNQC+t4ZL0vbtj
	YRF/xOXKu/5jDiR37qh2+F2zvbm9ySFnsLtJvPcyB9/YWSdK2OoIpqTmqGPfxVSWnuyaNIcpuSX
	lerr39Ru79P1MdG+r/eBTSD4c8pjIRFba9GXRKGXigVZqj0SBZQTBg5Yqt7O5F03dVcA=
X-Gm-Gg: ASbGncuQ9Rtmzf3XJ38ba2In0wR4SML8BOvHI6GuO9CCwspw1xq0B5TfpCub0X/w++l
	hpDSTp3mKKR3H8+wXmj3C4GMV/c3ni98cdhAu0ZaO3Xb9EVBz0INXur8Zp9cYIDBs99STh1rzqu
	BV425MdVb63+Jp9rutlWY5qg30JGcnY8/5NY/q1OnFUiZozeTDYsBR/QKjh1tPRJQtBl8GetrNQ
	OvLEVmIExkibPY7Q5P3gfik7S7ZElnQyQO6KIuH7Ayl9Jh2z94fFt9nOWMhYgFrh/bJUyk5ipH9
	4gVC/PSyCNSUMVlB+W/fIIIDsrl2CfpxR6BABfJ8uLDtTqBfPP0gbdyUjzrxa1Dxp3zSCTZ5u/e
	x6r8fIsuG9L8A8lAibX1rWekQotzEGaa7voludcklsL7PDRUaXqxv
X-Received: by 2002:a05:6122:2a0d:b0:554:afe3:1fb1 with SMTP id 71dfb90a1353d-554b8cf023dmr7813080e0c.14.1760373096827;
        Mon, 13 Oct 2025 09:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGHELLnZD5uUDdYZlyXcDIBhlCnjKA0/abnMG6vLUVDWQv5vJoNIMTw3EueGnWuERzBnCkHQ==
X-Received: by 2002:a05:6122:2a0d:b0:554:afe3:1fb1 with SMTP id 71dfb90a1353d-554b8cf023dmr7813011e0c.14.1760373096190;
        Mon, 13 Oct 2025 09:31:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590885638fesm4274022e87.81.2025.10.13.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 09:31:35 -0700 (PDT)
Date: Mon, 13 Oct 2025 19:31:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: lemans: Add resin key code and RTC
 node for PMM8654AU
Message-ID: <rddqbzh5f4evwsabl5wvpsaxnbq2ndmedwplsi5wstpqxib6kv@lx3lutmsvxgj>
References: <20251013-add_pon_resin-v1-1-62c1be897906@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-add_pon_resin-v1-1-62c1be897906@oss.qualcomm.com>
X-Proofpoint-GUID: j1Phf7OYO87_lzz0zAxV_ji9tMxddRui
X-Proofpoint-ORIG-GUID: j1Phf7OYO87_lzz0zAxV_ji9tMxddRui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX/ZU+V+32713u
 JieZT76Ln131oCId2Pv6eqr99mF/XOUqBzrPyWYb/I1+vyCef2RAl08keSLSaAYo8hZ71D+uyMG
 fJp3TxjYqLO2n3Vzc0J4GmSEatmZLFLuMypP8xMklU/S+QQ5Om1rnY0vASfw/yqbt9wyhGk9Azo
 3SBXdbGTk9Mvo76fxcbtJOd5xAC8rkSgYCODH9RRoxbM2/q/7vwB76a1K3CxTsV6wku8qjXfk38
 Wk/9VuDBZqLpFZ+KMdEHKUz9E6Fg5C+NnewQLfKEo4ujErPBOKIylW/PI4ty/FeK6vTvQCLxXMe
 TNqRTth00pLo2Jkp8v6oBwSd6AMuKi0XUT7CspMlbPojcEHCTdUXe989fLxazlyH80ALcF3gs+S
 bwPU8mMjEwYleUfYBpjzpjSnudsDZw==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ed2969 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=o6lFeYHLYNB40Li515AA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On Mon, Oct 13, 2025 at 08:15:23PM +0530, Rakesh Kota wrote:
> Update the PMM8654AU resin input code to KEY_VOLUMEDOWN and
> enable it. Also, add the RTC node for PMM8654AU.

Two independent changes. Two separate commits.

> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts    | 5 +++++
>  arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 7 +++++++
>  2 files changed, 12 insertions(+)
> 

-- 
With best wishes
Dmitry

