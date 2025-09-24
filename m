Return-Path: <linux-kernel+bounces-830316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437CB9962A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B50322713
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3D2DCBFB;
	Wed, 24 Sep 2025 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ik7+eRtf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C02DC764
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708797; cv=none; b=A9r81iksKY5mA+WfX00m4cRwd95JrqRrZzPWmZvnMP4C2IFHmS8L5LMsLS0oCGgazXbQRlnlmyL8r0NVvK6BwPn2/yVds6fO8mBMLBPGNqinZuAYr9ZXmlFuU1xLTTmUwMtiR3IJAZIt6FK7eGPeMCChXp3v/SqvzMnS2A323tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708797; c=relaxed/simple;
	bh=RHKw7hwZP6Z9wppb8gbhEeW4NZ05XGx/+pJlAcbcLC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLscTS/3cL18p2S+vaIm5w3EY7j7WAx/waaTfYxxTgLf50nrWvWRzvqHv6toT0JwysCk/4eQ14/cenFQGNidW+kel8vPae7C0t7b58javC1rafcOsvxkFUGnJlLzDwexUqbUbFaUEk6poFDDd7yprHwmOy481GkcO2mTD2oW/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ik7+eRtf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iWSf029979
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RHKw7hwZP6Z9wppb8gbhEeW4NZ05XGx/+pJlAcbcLC0=; b=Ik7+eRtffwR2dGrd
	hJVkbe63YQXTXWhUHgWYOrzbfBsqaG3v2PnBonrdAv/K21tPYCBTNkNIYs1BTFEe
	Dil8JJGHNNc+p/3yUKIU9+qMgOTMw10Q/iWmy5xVECttrXIir4JSuv4W+0hulbw1
	bufd908OnVKBLJviHm/yWqkpEnjxw0N2ZhgiV004JXDT3lp5rf34n7FigEgEKSJB
	7RGwQUQTcOK4adV4n0eUE8PgwUpwBzjOv0dBuYsnFLNOcJfc5CIRoVe4BypY58wW
	uFsnzk9+oSk9qbQEcDkOcunCYjQiRP/8JdnIFzPj9sl0LPTI80BFjDpGCw83QSqe
	xRNjfA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fktmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:13:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d42703f043so3376671cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708790; x=1759313590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHKw7hwZP6Z9wppb8gbhEeW4NZ05XGx/+pJlAcbcLC0=;
        b=qczANhgGG0dt3gHwcGl52pDeBduyjI+c8bVjkBZnf9cQpy3eIEqT9fKvuBjVQ1Mgo4
         BlUWHK/WrBLYtItZ3MbJ71PU+uQY9K18oIzt3z12HtIrkTq0Rg0E5Z3nA3W7BzoKc+Xe
         PW+mj86FCxZLPo2Hk60kWK8Ng3cErA4hBotSOxKKEvZL4ClqJ96MWx3nrciocueKX2HU
         ForsBgVhnxS1v79rh0uUE6eu6ROHQVyNI+Q6Iadn0v0GEyDVdTyhwllynorjHUyLKzd+
         IFK6RNHo3DvQcSgk/gYht7hGMl4UB7r16jqnqKSdZ3CIPRPuJbeajZ+5+6PcYOLWjWlo
         KxWA==
X-Forwarded-Encrypted: i=1; AJvYcCUggakrhY6s3HLfgVTQ/ZzJ+S9R7LOrgaY9Z/UAh7NEPWE7gU2Rvo3QY9L+iD6OZUOhUkhfz0u6M8Of5yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHvMrQlAzr/EpKac3phsTGmxdPfXmzZanJanUacxZqBAB+6XGL
	nsNACrw4pYomXcMSxZ2pi+guCBlW6FIf7BQ41qUB5L9VGazu/A55TETLObNOfDOT4ZpLxhkpu54
	OzKdA993b8M20a8Cd/rnJ/U9PJdQ4g3U+Q6axLUorRrms5781mejMJFg623K//osEtDIKE00UcI
	I=
X-Gm-Gg: ASbGncuXOcWnuwffXGhXT9AvWhdLX9l+JMb02bMdEGOibcGcfaJbv0lCxHh6wNwGLJ6
	bkfzr3bXkS4gzEl1n7nC2AqfEVayU63J2Nl8ZuyDkFNwB6TKcQl+gi8C3tJw+R4NWGMGX2rPJGW
	pynJB1aW0XNu+/ASwx9PmlUcV9PsIQ+kHBAFrQYkEaqAcmJZAOuUxuXftzAyJL5d94J3zff6bJM
	tl0dKes4iTq37qJv8ZOdLKDsKvNVv6mEBjz7dhXQulWkuRffg3mIYGH5c5jNBxbIjSdaTYuvtBJ
	jR5spwz4cS7cCaPU145Ei38G1KBsq1oKAwPBSjJT/ePg/qVSsVsWkDD5BkLLiHxHGz9ll3zq7TJ
	2NyGGS9A/TXAbkM2q4XCCdQ==
X-Received: by 2002:a05:622a:311:b0:4b5:e9b6:c9f with SMTP id d75a77b69052e-4d36707e56emr45779821cf.2.1758708789870;
        Wed, 24 Sep 2025 03:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxNbIitUioSByGSWKh6lMxGWBmIBLxO74ISC6F3r77DignRoR0BJnLESfJ919H1NZIvhRzAA==
X-Received: by 2002:a05:622a:311:b0:4b5:e9b6:c9f with SMTP id d75a77b69052e-4d36707e56emr45779681cf.2.1758708789442;
        Wed, 24 Sep 2025 03:13:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd1102d7asm1538328866b.76.2025.09.24.03.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:13:08 -0700 (PDT)
Message-ID: <eec9a046-2742-4b7f-86ac-ef11dae19aee@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 12:13:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] arm64: dts: qcom: add refgen regulators where
 applicable
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hPEqny_GVgd8MaxIPyJSXXTwuZ0VFwio
X-Proofpoint-GUID: hPEqny_GVgd8MaxIPyJSXXTwuZ0VFwio
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d3c437 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=G1tMXRxE98s01vP6SloA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX3xsmxFIWUmsY
 ON+mSc6NeaClPiPS+HbQxbNHvbMXCGXrZQU31AnlTt0DM1IURcfH1seVNvw1Gizk8GpFxrMSfmJ
 bpd/IoU8hToJuWQxE7RDQ9S2/d0CEfr35NKKpw5VtsVIx5pyyufU/f4fmdPx49mBHRZQ7IeYsPU
 1zMWoUIuFYKHOjkn4HtyPg8jSuT3l1ArbKjBcNIw8gbSkS/tbRw6YxT8Ke/udJbr5Av9DB7DEA5
 bf+7EgD6rzJhj7/Oqgu+CDr4ugK912rXr24GOtDdiXUpupNs2gRZV2shusMyg2X6J/xD5GO6SZ6
 V72EmrvOzUk2lyb6E9SUv84aXn0FBGWHoBblFCn30ZPz6rgtAo9R0RdhspU8B47yKhrenDgy281
 qltjKK8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On 9/21/25 9:09 AM, Dmitry Baryshkov wrote:
> On several Qualcomm platforms the DSI internally is using the refgen
> regulator. Document the regulator for the SDM670, Lemans and QCS8300
> platforms. Add corresponding device nodes and link them as a supply to
> the DSI node.

It's likely that all PHY-ish hardware uses REFGEN, so please make
extra sure your patches won't kill DP/USB/camera

Konrad

