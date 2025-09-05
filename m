Return-Path: <linux-kernel+bounces-803390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F329BB45E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58622A055BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C12309F1B;
	Fri,  5 Sep 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWdAgCuI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297E306B3D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090730; cv=none; b=txs/9jjx8OyqDrYDtYwRBHPOUt+rADYsDK/WfqCLUm5TJRBp8hUOSUUx7cHM0DFwk32q6EPtIKRuRP0ehWvmQRDL+OpHXIt9sV2Pw2ETW7azTC1G5xF/b5SOnG+MBOS7PTNAvbrZpSjzHm9LhW+hZ2aF2N7frYlWxlzZrb2+LMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090730; c=relaxed/simple;
	bh=4ndmFMUbOTTdZbdHfbff2gdinb3ORcxCtOb4ojVQ+GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkvxYJ6V++4C0qKYZubKIHlvv/sB9L0RjpwXEGrmrJfa4/BU/aAGkyZvGuMBJo1BC725wFBq9fdc0xLsTFciJFO7lWL6+ahIE036YXes1Ey6uHKX79bla30n/EekTEZrLBWtrOwY1ICiEfhgKzzR9NUJl/kOPNIBx7ZHuZkfTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWdAgCuI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GVEWn031019
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PY3+Jawa4aCuOeTafCiAiCV8
	LrCyuUCU77yZ0e5sHFM=; b=PWdAgCuIQXlQNWNX2cVccUhP+v5vZZ8aI1e4NbWs
	oP3pUbr+rnpZKOf1wRRe4rBcPVtqjdRyTdY6qwLOC7o1zNVXNnUyAJ3yQsGKwFaC
	M6qBhrAyXZUP1NK6qCMuMcbb05fzmI0WhXwGkONqfxIZP5p+hTBYlDqey+xdSAk1
	QjN2cYLHStD3nZKctEcLd9VIwY8u/Nitity2RaV5H9eX6wax4xufOuKzophrCQym
	riLqwHGPCfMkDkcxKVevEvemK/NoBm+HPrrQXfDsaaI0VIJdEPUOy7yq0OT8WMpN
	1H/XdTYC0SGMxUuDM/VB4l1hm6B6Pn9/NI9eeSBNgNG2Iw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4903ev01nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:45:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7224cb09e84so44782856d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090727; x=1757695527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY3+Jawa4aCuOeTafCiAiCV8LrCyuUCU77yZ0e5sHFM=;
        b=Tprx2LKG3ujKchcLK7NboQ55L4AKw81yPaxegTQeRhW7MOSQIWbj3NspkWm6XbQdsZ
         fXQmFBmSDUTcG+wRHok2/6SJbVUT9K/WRfO24WbaUnE1tQvk7jdy60f75U8HV8NKJxD3
         D3jpMnOMB0zvv94fpXKkBm0+A6xMS0owMRVWPaSzuEXNl8r9J57wnoG5d+xeSvq7DSRr
         l8+iLB3F+D6S+kLBVGV3Lh9GZ93aJ1mBTB+gpUH6UpDVGV96UNCplYDK/qf0PBtvBE9p
         ZBvEAl4v4Vml1B0uaLfgSNtr+7sGjYF8R57fTU1VbhqYk/VpnVOYDnZzbg55fc7MSCr8
         f7IA==
X-Forwarded-Encrypted: i=1; AJvYcCVrgM3d6K1vhwbZQYQz8naeGXPpcoKp/1cT71YIQYJ44ScHoB/iFauuTKeJATRXJ35PX24jTajHc3cysd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8v/ZMY/SRVEvTxsLiB6rL+FON3Zpk8yCF6+SUhB8tBbXdPnl5
	s4kUO5wKj1k7Tj24MqIkxTTkH4ly4oHqJJKOSh7+KFAMAalzLUg9pACwC6a/0w58CPO86qGM4Ub
	mY4dwOQ8lLGFUjWOPiFdzIhBh3RaWjmmFDhPyeV1U/Nl6TyKCbTFvayKmcCuaMPZiyUg=
X-Gm-Gg: ASbGncuBgC5Mrnet7vHKLj15U34jICXfZaiL1cAzykwnGR5sJtDobK1CfuiL3+YXVLK
	5fAot8uJ08kidXpvK5OOdP9m3RR00zT2Rvrbd/0Xm+FH8WP5ZDJpRTxk2VH2qE8gXaIXrCjM/A8
	kfpZNTEFUwk61vR2OBj46VVgaNVfhBjMnk+bNgVhRtdoQtrGdouCsIHGuzcsX8DfAM6y5iKCt2c
	jXhrh7NjTWxJljnsda351BKYq/saUAcCYn9PfzbRlXwKxj+m7sTHRgOkkQ4+J/GUG5cxe/r1zow
	CMZMJ6tJawpB7iXygYmulAaKRE6T6yoPN8+eM9sDRs/w+wZYWhjiB0jO/Shd4uFbcTEq7VzrqjC
	jU1twZaDGGvq/CiheXPV7wvmn51nMtHGRU3I5DQpgAU2GgrI80bHH
X-Received: by 2002:a05:6214:dad:b0:728:c849:6dee with SMTP id 6a1803df08f44-72bbdfc9005mr43147896d6.5.1757090726940;
        Fri, 05 Sep 2025 09:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZtIjm7lssml3KCe/y4SRR3EJkskoy992JWsv0TItb9NXhJIJLjjguyWB09LWjXMqF3P/SNw==
X-Received: by 2002:a05:6214:dad:b0:728:c849:6dee with SMTP id 6a1803df08f44-72bbdfc9005mr43147466d6.5.1757090726359;
        Fri, 05 Sep 2025 09:45:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5c174sm1911595e87.11.2025.09.05.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:25 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:45:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 12/12] ASoC: codecs: wcd937x: get regmap directly
Message-ID: <wml7b2iv66lyoozc2jypuf5xhkg6me4cdxac2chtrpmjubfago@qqvxiymn47sr>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-13-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905154430.12268-13-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE2MiBTYWx0ZWRfX4PfwLRYL/Axp
 Lbot1AlIe/X/c6nXNLoPWyn3JMAlBHEq7BDNgFSnpb8uubl/CJTY4/7Fz+w/B0YT7myisfwrwNI
 FgGYx6PfPJCxdrLkrsC5lam8PEJ6QonNBsU8ubhTYXQLllJ+y8JSMnTaHYnjJbo6iC7RkqWOYGz
 R+vZeM44gcpHWDhZT9fFhPjiixn39bFj30FX4cYw1d16kqEM9TsyBCC0Ymia14nuwMG2MnoLWR6
 6CDjI5pOGoMFtqgza8I7OEJIhsSRD0VJYI7z1XwlKJY20/59mcknRkAE8xncYumqsmHuflOjEOJ
 1yK852+rrfchRE/1nd4iRydeVUDrv6R3TCltibxv6GXvH3oBaujM2YGGg4QtQCfU2w9UYhNETJi
 wTK3ANtj
X-Proofpoint-GUID: LtmY_7viDX5Nghl2vtfTD1ahLu-m8TL1
X-Proofpoint-ORIG-GUID: LtmY_7viDX5Nghl2vtfTD1ahLu-m8TL1
X-Authority-Analysis: v=2.4 cv=drbbC0g4 c=1 sm=1 tr=0 ts=68bb13a7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=azzZ5_6gx0kgBHoxRwcA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509050162

On Fri, Sep 05, 2025 at 04:44:30PM +0100, Srinivas Kandagatla wrote:
> Remove usage of dev_get_regmap, as this its more efficient to directly
> reference the pointer.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd937x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

