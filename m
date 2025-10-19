Return-Path: <linux-kernel+bounces-859684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E84BEE459
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6F394E4A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D7258EE9;
	Sun, 19 Oct 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eRrX5daR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5BB23EA8F
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875439; cv=none; b=Qx/k6gudV5TNw9RGKpRJSe/aQ79RhSm4YzHn2TN93BNKUHd+ZN56BN6370+ayvq3Kt9tWaVOAHWx4lWZFlH93LrtfNy/BJb3p+RPdH+zm3VgqIDN19k4/hfTNTnbf3hhaAvQ49NXEgSvZCB6/lxJAB2GursGoWnI0A9geHuxnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875439; c=relaxed/simple;
	bh=Qg9Jakmj2wrfEWqOOAXYT4NC0atdVGNBm+BDuQv+rh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI3647+8P0PodlhqG0BCaHJlMt2XhxzJVhH6dseI3ioQ0xyZn6wVQfZHTVsQT/Ojk47GRB/BdcRfZ3fck0xBb9/CnruvecZRbeIOJfbt0ZjPHSzvh7Bl9mRPNMlr+Hqc3Aj7gcbGOL6RBSjrn6TOUU/5frmr30uAuzaa0eTS2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eRrX5daR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J8LmvO025649
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rHQ6RkjDOWBOO411/db20Oqp
	CATz3k2XC2e0IIRMfAQ=; b=eRrX5daRv5A7SC02IR9azn6JYWZCuWjZi5Japp+/
	G4AhWU9C/ly3OAymkO/iUuwrvPc+VCXUAEYeXurobFKl/qQVkTwea7/njCrmAiLM
	WiYyyk0FqdihB0VWNu5Ms/I7Su7T1PwVbvjZ1oHY1th/arubqDmNaEw/4mfYs3iO
	h5OrFjqzNKfv5jLbK1EaKECv/rKmFXBWZF5aMFRU2DaAtxymz4N5h1VhmtSmYdza
	/RJQYLp4X7FLJD4LX1wwtqH3d97neThBqUfXQULEb0WJDYF6tAtI5Hq5yjMB6s2X
	tPVk3r+rAgw7vH22s1jPOCRDAqTWlphhQhm6vC0N4Q7RmQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w7tdcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:03:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c14264340so61128996d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760875436; x=1761480236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHQ6RkjDOWBOO411/db20OqpCATz3k2XC2e0IIRMfAQ=;
        b=P8+pzQKBCW93VAXC3fEhb+91khEnM0wV9u6ZXElZKUE7G/IN/twI1rVofSeYZZtU1N
         u/hVHZ3oqoDYobWG9H6zVrl/O6HBOQ80d9x3LlsiaSb5MRPVfkPwpHNyhBI7KbxifeVS
         sVPN3D46rbkneWkmUF0G4ZpIv9PgAN/6LxXxnu4DQzdO3Yc1jIkxTMBSSxR6xj6FDnPM
         qIVtQ0Yv+SaZHBcxow94H2wpr69Rdx7gCZlmuxAKdEMvtzeaayrOe42mlYRrnp0zJ5tK
         AUYmJWAV087zqRJpDu2jQiKfbjq0PS136TzqjnFXjW5DEvxwErc3zTkd1r0oWXfjsAuX
         6nKA==
X-Forwarded-Encrypted: i=1; AJvYcCVrgSznlEr6zz6ucrM/xpQDOXab+OrXvletSHViqiC2prn+B3RCyuK4iq8v9GsOEgeCirL62Ob+7GyyfDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztTlMDtIspcjrWkP1DQwC8dW0NwIXzKRQF3zGJ0dcTMF200Fme
	zMhz5vMwqpCfHSfVVY3FFTSrnQH8n0Igr6Xq/ibpzH5KzTfL5Q8xg4YrOPKwVmCc/tWBoCvwSBq
	rZeFbmXuhBuAyDL90T9D5wltV9F17Hw31TBfIl1y+9eyXCA2Dk/yPiOnIIO3oU/7GA4w=
X-Gm-Gg: ASbGncsYTgX43Zs8BKCJGDetYw4peN8rhZdLtkg4DL6lYaAoFHLO4znhnO85Rtu5lG4
	oq7Rroi6y5a5ApPfzR2/v9WV5kkP8LOjTwNHXoqAGPlD4KgIGEjdx9BQeMArmcQQ5zYcXbtkBHt
	DpJe/+t78f9KwdfArE/nXi/rUq0OjpaCTrY6/gJYk5bkgZZFproLlpAmlZGV0os3VfBUvzXIHEv
	gVy+rr4EwLlsQqFHp9Czjs+Z6BmPM7yUf61yFbdKqVQaa3ZcT2mOtsuzCeSdUZZEJ79VcYOtetW
	xPtH6BzqcMQoZrQGf4yoegUPBTELS07sHGIXbtfNJpLMnBlUGQPQ5C69EcgX7J4VuEQ52QLb8L/
	Vn8qbsX4LnmkaB0qzwkv1Cu8RrAsP6G6xaMf5w6RyKKSh6wwkI8qZqi3uqDHcx7OwrzHGRSVMWY
	LLbUtd8vYMuGY=
X-Received: by 2002:ac8:7a81:0:b0:4e8:9f2e:cfde with SMTP id d75a77b69052e-4e89f2ed07emr81140211cf.52.1760875436047;
        Sun, 19 Oct 2025 05:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQE/U+IAcFRlbU1w7kkdBgNBXK8ro+879blxloHJggQ8FibXewvOY9PfKm8v2vZST/38nEgQ==
X-Received: by 2002:ac8:7a81:0:b0:4e8:9f2e:cfde with SMTP id d75a77b69052e-4e89f2ed07emr81139731cf.52.1760875435424;
        Sun, 19 Oct 2025 05:03:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deea869dsm1520352e87.9.2025.10.19.05.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:03:54 -0700 (PDT)
Date: Sun, 19 Oct 2025 15:03:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Fix compile warnings for
 USB HS controller
Message-ID: <xdweqthugsdgbpu2s65lgv6urdoqbyiblrt346y6jt5lw4bmyj@xk5fp5xxqbzn>
References: <20251019115630.2222720-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019115630.2222720-1-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfXy5H2OYwHtuAw
 hEWr7kKlwhwZ14zfMy2xFJztuDryiwa8cQUpevb1pQmXTrmpnR+gbA65eSpvmsxFZLqrpSObKAy
 vVKty/zgCy7XI0nJcmlM/LTWfYIhFdcvUONCLEbMUQpuD1zlORFEvzg84/SIw+1TIHq1zFbCXKr
 EZreRpbpR/hTWzTHJ1Y2X2lN/RL1DN+I38kpFOgR/MW26+m9MubtNzNS06DEXAmt4njEMyYgJvu
 0dwa7vpkxIMR1pUsJ7Ru4Tb+5imWpSff1m1+/CckstKPaXZcdXUQ79xLZZT9y4hsBC8F2V3eJMz
 +obw3tDV0eP1zic1TDUtlty/vUWN3VseBc659NUv6o8pfBJ7fWLNOMZYn3Uck1moZdrAezGjr1M
 pEc5aRSVprxC9uvIzmXrMRtaqdvyog==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f4d3ac cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=atfiVmPxWXv956OfMsIA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: wPhpevI8s_j62hPNmQkhF5OgGDmFE9X6
X-Proofpoint-ORIG-GUID: wPhpevI8s_j62hPNmQkhF5OgGDmFE9X6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On Sun, Oct 19, 2025 at 05:26:30PM +0530, Krishna Kurapati wrote:
> With W=1, the following error comes up:
> 
> Warning (graph_child_address): /soc@0/usb@a2f8800/usb@a200000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> 
> This could be since the controller is only HS capable and only one port
> node is added.
> 
> Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Note:
> This patch has only been compile tested.
> 
> Link to v1:
> https://lore.kernel.org/all/20251014022121.1850871-3-krishna.kurapati@oss.qualcomm.com/
> 
> Changes in v2:
> In v1, the fix was done after flattening the USB controller nodes [1].
> Since there is a system suspend issue reported on that patch, the
> flattening patch will be sent later after its fixed. For now, sending the
> fix for the compile warning.
> 
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

