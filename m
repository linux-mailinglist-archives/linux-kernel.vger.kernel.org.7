Return-Path: <linux-kernel+bounces-719786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A3AFB295
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4F81AA17D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B97B2980B2;
	Mon,  7 Jul 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W3gY9Br6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FD2980AC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889025; cv=none; b=umeZ9jS0E68bO/qO5FdQGZJ96qYHYgrGp2sby0zAF0eTvMjoCOPE0d5vBcCXz2in+aFks6PYH7+4ikRNgEB0lBhnpGrL92rqBkF8plJMS8MeRtfgSFMIIHZHszQJwZ3KlampgGmil+j8q7ya79KXQeVXLcasLzFmCR7g27ZBNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889025; c=relaxed/simple;
	bh=BgUK26apviIxGTvkhHUvUb5n67RTDT72hzLQIWUGjn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERoQUod5of2lcVNCUaBiwXTTLC/mZfY0BQlu+T2/AH8DR01bqQWnNZAf4KevAhpB4IMjD50quftT1VAgptbRQiwGhk5ITNG6A580bK0mei3tIWLynOfNKuwtS3kTPglsg9DHR0Wb+ajtVKKwH1bNkxg2yizFx2HKFhPo894mQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W3gY9Br6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5679kQfY014843
	for <linux-kernel@vger.kernel.org>; Mon, 7 Jul 2025 11:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BtKyfxTPk8AIeJsvPWCjewsjZ38SDSGkBHzkUynmy8s=; b=W3gY9Br6OL0Xdp8v
	BwGPVagXKkoR+Yv5cIBk5G+LVYbTgh3WyQuNmP0wDi/vavTGxHdQp3K5MJ/3wcgG
	dAR4WxmP7a6jcNrmPvoYf1BlGS4T9guKIxdNXSpoPGEy1JA9LY/1p5h55u7du1xn
	uha5WNKCXSuWYoKT8ocO0BHbs3Ji3qZQGUx4KKRyjofWiFz6PcLRgPrGs69Q1/Sf
	TiY9gMMx6vWqt6Gu5LzZ2raA8mWtfC/D+w2JLPffHqPYi5Rzp6QWlhRH1nqLIGRw
	5wYKuDH4SeZluji2cX/M20fJccpbE5hC2TJHkEZOPZlxkqwAkd3eB+p7D02MYwYp
	i9pP8Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkcqqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:50:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb030f541bso12585546d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 04:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751889010; x=1752493810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtKyfxTPk8AIeJsvPWCjewsjZ38SDSGkBHzkUynmy8s=;
        b=GEa6jWhNbV9Ilb6bS9XKGly7uuZ/cPCVFAlx7JUdipRb+1UHcJipetzeyA0LgAymDw
         SDhkMOI+rx2GS5OllIYWAfD/SHaGwco6x9c3hEtlky0cXFRTZddnGSxmWCKcnkKkT1J3
         b00fgUMrJVw0hOVfsXv7l2ED7lfeMUGjC/8z3VRsFtDxBHb6h+LAeblBNTeoHXWYQOEs
         J3JaERYD7eqo0W51YxxVU4kBGImPAVWp6XqcYpUWY7aO8XCFohy/isurQJNE8ZQR6er3
         5wBNmmXVqP3Ijk94pYLOKR2ynwAo8cka/a1SVJrufG3BP32RGYg3tf4a7BaUUhIb3l7f
         fwWw==
X-Forwarded-Encrypted: i=1; AJvYcCWNrq3PHHG9KI8FSlyvVQyT6/PngiUMoqIM8if/tpNc+88NyaW1qSg4KAiDTagUZAl+IDZ0swsea7fmBJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWi6RxauLy5G9rsj1/w+ZabniDjdUf1cHWy5GEHkbL6Cy9wsXr
	iz+sYsifXE+2kzt67mmgUPF2LaAYjP+d3TOW3pEBtQbPEf/CTrrEi48Jo3x6fG/g55cKCgJjxOp
	HbCIt9dEpreivX989NbJ6oj9K7nVQjid4KmvSRzuEaMLXuRCXeiepoiOyDgS9Z76oFjg=
X-Gm-Gg: ASbGncsVXPX/22ZeJz+A1LkLuAPQQconZBj+O/8xnNdinARTPgvQQvMsAX88aYuCkas
	7/ACbIfrxOkaW3rWJkkgjiwnbKBKTM+lZmPLAvPchjdnVsnhikKRgSPVKpn6bPHpG3cz5GCYF8H
	grE+AgP/aL1k/G9cq7C7uCJrgme7/xtHhW/Y/Kv3LQZUYcEC2Y4xQPXVsCtbk/Ri3LB5KnDM389
	ehbsil/c8Ia29T4xFjTwMkRZDbxxGGY5FIgvW/2BDevwcu4zWtWtGVewEsvKhpaav/IDjO4gPJu
	jISzGBg+wa2jedbIoYV7ca4Bn/oMTBOGtNRUoYkbjiiACttrpSIPbjMOWktDTB9HqRvI4COlyLb
	8B3s=
X-Received: by 2002:a05:620a:8086:b0:7d3:8e88:dc0a with SMTP id af79cd13be357-7d5ddc7186fmr516220885a.11.1751889009843;
        Mon, 07 Jul 2025 04:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJC3Fqsx6CpDLKzAOaBps+irlPhHcFg2khR3/yaBWnK8u7z2vqoG9wXzHo+FYxm5ySpxgERA==
X-Received: by 2002:a05:620a:8086:b0:7d3:8e88:dc0a with SMTP id af79cd13be357-7d5ddc7186fmr516218385a.11.1751889009295;
        Mon, 07 Jul 2025 04:50:09 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696480sm5522871a12.27.2025.07.07.04.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 04:50:08 -0700 (PDT)
Message-ID: <20c4a464-699e-4266-92f5-f23f1024e277@oss.qualcomm.com>
Date: Mon, 7 Jul 2025 13:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom-qmp-ufs: Fix HS-G4 PHY init table for sc7280
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Xilin Wu <sophon@radxa.com>, can.guo@oss.qualcomm.com
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Manish Pandey <quic_mapa@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250613-sc7280-ufsphy-g4-fix-v1-1-1bf60744f5ac@radxa.com>
 <o2chuy22dls3y3bsjke34z7pnyzap6m4m34tjxswueshulii4d@d5lbcragrbjb>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <o2chuy22dls3y3bsjke34z7pnyzap6m4m34tjxswueshulii4d@d5lbcragrbjb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eO91LtOhWD5TSJHHB0EVzs3ydai7KvuA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA2OSBTYWx0ZWRfX81wKuvrznziR
 eD3BTyhAPcbg0YpyljGVH6yffpzSdPgHMHDteW7gG/DYHHq+F+aKFCRPUkhka/7Ai/rr9yC/pxn
 Nf3yqG68Tz3rZeqbOWJgnmG9AWU5b3g5ru4vj5wRivlvOKB4Mt9CXMmEg7WL0jVxPFl/9VQypgn
 r7y7XPnxRWd8+2docrHaa/GUmKaN4bCqQLBaPm8pYRPxcPZWJ96HzsD+g8Bs9kAzOevnizTzmTS
 STKiNnRIcNQ2rcmMKdGDFwc4nFiwzp4aAiiHlr2DXaOFu8CpbLb7J2SZpi5PGVERjBMh/L84eRh
 fz5dxdNIXprwGfphx5b9kaKXD2/GkiSjWUVxojLqMCyJz704hX3B4oa8SCkkGFnGs5+NpyoIa3Q
 NoZmG6fEgI3Keh7Ei6JRvE9kDEeV/bOoRYEZxOU4SqsIbiJ8gDHsEI6tIhzpG0RkwNJlLtF+
X-Proofpoint-GUID: eO91LtOhWD5TSJHHB0EVzs3ydai7KvuA
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686bb47f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=FoyzFE0DsDRb6SHPX1sA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=736 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507070069

On 7/5/25 3:06 PM, Dmitry Baryshkov wrote:
> On Fri, Jun 13, 2025 at 10:41:48PM +0800, Xilin Wu wrote:
>> The PHY is limited to operating in HS-G3 mode during the initial PCS
>> registers initialization. Extra PHY init sequence is required to allow
>> HS-G4 mode to work when needed.
> 
> I can't find corresponding settings in either of HPGs.

Yeah I don't see 7280 accounted for in the usual places either..

Maybe + Can knows where to look?

Konrad

