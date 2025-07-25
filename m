Return-Path: <linux-kernel+bounces-746520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696BB127A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824B21CE2556
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFDF26056C;
	Fri, 25 Jul 2025 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hu5O37cK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16125A645
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487213; cv=none; b=hgpBn6gwhOkjfF9mWbwzSAYZ2e4360fBMfgAE7OJL6hO5mP9wlxSfGbxB33nOTVx+ua5TopHSsSN43gIdBs+UfBoIY93hZ+JMau+on8S2yppTnyXVNyqESkt+SRdJiHHffSxkmkqL9PioVIjoItA9k7vwDyzlqvYyBz2zk5542I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487213; c=relaxed/simple;
	bh=3F6Vnf9P/zJNqVgu5yO6jMHWPUhKAVvQ7z//vRLRnSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HISiEXfv96XTa1YhNES12WG23RuIVcsZG6/S66FbmLq0g+GFQArvVPoTMsbCi6peU5MBBzGzk5oaslmVNXtwosdLJZl/kftIREIvgLt0jMurT99p+g0Xm2ChS8pyUO4bARGSg1hzTUlm0EH0MX8SI739hi5fc54rC8Z848KInhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hu5O37cK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PJHRvP015901
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 23:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qXBSNgzMClCengYCrY3ivBRG
	Uf8cHDHLLWL7h/aBi7U=; b=Hu5O37cKi+LOw4ou7TZht2o5Iti4N/xAEKBfdnri
	rPJ0pSuvxhfWnZzJhgd8+BsqVUCmPp5FIo4HkakQ7uvvVy8QgTc3NC2eDCGbfTkT
	OL2YhsX6sVT7pnuMTNIHT/qzvk5+vZCvWWeCiINhxYPOXHbFcplIT7T+wO9hRQG5
	GfCHWtfw6H/EMYm7ZDrOiWaLut5DhotLT/hiHUO0h153pKmRzvP/Otr/h6uIWNdS
	PPhUVTR4m9tlJPXCkv8+9x6fyyaL6ut1w7yKuN2byo/itXCPNxVK1fRfi+jkcPUC
	1pc/lZRdOcyfLERglKA3u2n5TpXCOAIw7VpHy9uVC2vnPA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w503r92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 23:46:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-706f8cac6edso42414626d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753487209; x=1754092009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXBSNgzMClCengYCrY3ivBRGUf8cHDHLLWL7h/aBi7U=;
        b=cqR7mJEADldDiL0zmCrqd31GQ9lEuBlXW/jVqE63gVnzJPdPXk+duAgqpnZ5XFddhZ
         eZ/8VYsLkC83V0/Q5nOYumYPGTuAd0mYnUsazlhDhHK1qLl51YjdV2ck61YCGiWlaBX2
         riuIab26/1NhRHzcF5vMk/hKeaoJ2gwFGP9bthExejEWsqbuvJjdRy5Gykl6DnYcDWgW
         fJOV1WOqjH7PWeapsI+JDYErMHheb0rfkcQ05EGdr7D5PTBxY5eNy3Xlr9NUZiVjtEQr
         VZ1BiH/L8AsabrZLsmaJS5epwt94dd67jqwNvNjBIX0fZiTxS2YmRXMx4hCVUe7GQshf
         Xw+w==
X-Forwarded-Encrypted: i=1; AJvYcCUk1qUr+d2NLMQDPJzQ0A99FDXq5KO+5xQSMpZAs2YDgUl3YedwDJDLkBgLO3JPdD2Id6XBDhK9FypSpG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYD9Zmx7/O1vlf6r9pnA0VFfn3vcFstN+IfVtiKu78pdBz64Av
	VSqL2YaKoYDKdIVq7hqqIE7rwLrGb65drutWuHeItQ3D4JbLTJc8DZoLzBYYXulBzajdfoaNlNJ
	UkBsajGmEdWqpNE9vnTwVmIZD+IRYWSlW95SHJB/+lYg1PrXTtB71ZZL796ijyXeQ0OQ=
X-Gm-Gg: ASbGncuDStRXi8T9NcmQOlqplEOMiypUfkO9VO226jpoBnRmApNRvTkHViP1sHmQ52Z
	PnQar98HAtFg7FVMg+Px0E88Gk0rn/67UpjDvPKMetNiD3Nl2EsVU6Q0cA8FBhGL7DsflW5A/Sa
	elWAX5eCmCqud0aclaYdWU+GCiZGff5vGlm2iUA/ODC974UMSksjbViSafIICaX4IYYZXNBo2eh
	AYjvpzvI6XUzwJGMILExfmqQvAxpyLXhvZEjZlfHK/fvyuZFOAiFq9D5vqmUrAX6OQ4yjljUcHF
	HS6vgVLhHoYnt9rXMWFfH+5SjA2f4DeW3GN1P/NN9O3QS2OFdk2NH4t8lFTVGD2yAY6ok9VvFCH
	VFMoRGyzw9UQGgcHftg1val0oPk8Y1hd0JNkh2d7soOqHM6HCY7Zi
X-Received: by 2002:ad4:5963:0:b0:702:d60b:c048 with SMTP id 6a1803df08f44-7071ff0f2cbmr58647206d6.19.1753487209089;
        Fri, 25 Jul 2025 16:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1NIdFUiy+LkfIlb0Nij2OXe6qkzDF3xYJLssxlfhKaFVl8cSqppGR61z2kIummysPqIbXA==
X-Received: by 2002:ad4:5963:0:b0:702:d60b:c048 with SMTP id 6a1803df08f44-7071ff0f2cbmr58646876d6.19.1753487208652;
        Fri, 25 Jul 2025 16:46:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f40b5323sm2034501fa.37.2025.07.25.16.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 16:46:46 -0700 (PDT)
Date: Sat, 26 Jul 2025 02:46:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, mripard@kernel.org, naoki@radxa.com,
        stephen@radxa.com, cristian.ciocaltea@collabora.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        yubing.zhang@rock-chips.com, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh@kernel.org,
        sebastian.reichel@collabora.com, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v5 10/10] arm64: dts: rockchip: Enable DP2HDMI for ROCK 5
 ITX
Message-ID: <vncck2eqkvfr7tbnuffopc5pysdct3az744lnc4xesyublfwyr@jz3hyvz3kg7g>
References: <20250716100440.816351-1-andyshrk@163.com>
 <20250716100440.816351-11-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716100440.816351-11-andyshrk@163.com>
X-Proofpoint-GUID: E4jGeY4pTsXSA9Ym6J5KkU0KG0ll3Sd1
X-Proofpoint-ORIG-GUID: E4jGeY4pTsXSA9Ym6J5KkU0KG0ll3Sd1
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=6884176a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=mMkY4CccI6nGLkDSWykA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDIwNCBTYWx0ZWRfX9E1Uolyyr6Op
 7oA6jTRBqYYuTCZY1REJSe5qUhipJ+TwoKiCZOhesIpCqhDa/ojJV3eyvRHlqjlVgmXeq6IQjzX
 GpNwa3+ACGNMo7cWsGVXgF6TfhC/PZH55bqNgyptHKjmz+/8txdE0g4Uy7uGdQheIof1Y3CE9Xx
 d58IypcqTd47LRGDZl4qBthuRBVjFfofK1oxRWrbxa9+s/WntEMiEo10rhT9Eq2U5SusoFJMeTJ
 iF+vVOTgs4sOURFvyZiGYiiNeWhdQaK5NdkRMq8TIJGOJDa1p9k+HWs61pjjBkxw2v1Syh1vBOZ
 T4B1ZMy58NYG5RqE03BeQEoieKUh5mwTpt4Xw/qGHVSUH7nDPpyXgkJCxR3fM6lFJnCAEmB38Td
 HU0JcxYyhxRdtnH5dIVixKnagQvdAImt0ZjhDw8cCRnv39r987HhaIwW5PcYMy9MW+banuQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=699 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250204

On Wed, Jul 16, 2025 at 06:04:37PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The HDMI0(Port next to Headphone Jack) is drived by DP1 on rk3588
> via RA620(a dp2hdmi converter).
> 
> Add related dt nodes to enable it.
> 
> Note: ROCKCHIP_VOP2_EP_DP1 is defined as 11 in dt-binding header,
> but it will trigger a dtc warning like "graph node unit address
> error, expected "b"" if we use it directly after endpoint, so we
> use "b" instead here.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> (no changes since v3)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

