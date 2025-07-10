Return-Path: <linux-kernel+bounces-726112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F92B00848
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B1B1C46191
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4A2EFDBD;
	Thu, 10 Jul 2025 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmTGLJWI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC02EF2A5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163754; cv=none; b=iNueWCQJY2Uauj3+OPmskfGK81PVTkjA5+xYifokGfb46dG2JPDd2O6KfSfpwWUiaxyLU4j7GIAzpBideiCQHef+1NhOncm28J7OEtZAc00b9BDl3C9FxRU/8r+hVHqc/nHRKS2EBTo6NErXE+hYUA2n7Ss8/qDOAKRYCyOmdmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163754; c=relaxed/simple;
	bh=N/aXBvT4CRm/+YYruIbNGAgz2RyYehB6jiUrVJyElIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW2wvwu2MqH01LspD+82c2cp0ZyIS1gSoYWAvP4yey3qYw8Vl+SDFjDw0hjqgwZonLrJN7breWowygTt/1ICYttrTqxraokUPo5WrPwYhbAptp1zLGWM2Sb+egX+b9Qk6oPigjcWuWCrS5eKSAuRid4SujF/kf5L1ryx9/jstWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CmTGLJWI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8NhXJ016793
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vQ+6ordS2MREHUlH+sOv1F4IpVKnvygDpjQPI9SC08=; b=CmTGLJWINImAHKoL
	C3DmEyyOHxwXFEHYDYwh9nNs9+qHt9oDnwlEHteC1OnCI6yisLYB4/ucmnYvvLrj
	9Gnq6RF4WjuDnhLew1VVzZh/snqX6sLbsFTDtDT88C0KSOr4Jr9wcZPL9Eg85AL0
	Kx45dAtjgRyOnaoGdJSd7P5kZQCjABqt56jZujpaGtfIVeGs0RuMBAUfcJSAXwyS
	vz75sSrZHISd4DCZLQUP/EVxIiXZYB3tRoFHAQTFkBZMnonxyXEwXKUUMo0Yke+A
	gy9X7lG2p3TUYGL40TOiN0KoHtT2U+B6nJ8XwMK+HwSgGGmHgEC7eAMpNCw7vVSq
	VAOVAA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbnwkhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:09:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d21080c26fso18554685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163751; x=1752768551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vQ+6ordS2MREHUlH+sOv1F4IpVKnvygDpjQPI9SC08=;
        b=PQ886uQEapkFloWzSmaS+a8a5YUCUVDmgpo8x3RtRCn7axsketiP+R1+ib7S4f//ZH
         APLzf1CtkjWwrgzIA2bocC6pxsoUx4L6rMmMPJw6SNBuKsRAn1pw0InFzuWPi/HAcARp
         Qw9Dsnt+ywb+RFs3ltmxEIua00xqASHfhb00K90s1YwZHOBZDMnr2DIwvQU8RlQKEMcx
         /GRS3gRluTKwYjqTvq/w0YI0eMKEdd7lYi9A/xY5ZroNdBQ0r2r7wVkYrDlwIR7+h7D1
         PjuMoCc/d2jugs5ePaUQgKl0VpvVFoxWSOPI0I1nIa1x6lPYa5A0RgA7Q4oSz+8S4718
         /ePQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdUICI8IleWGQ2e68BMr1N93z0uo2+TBME4a9z9VySmjZVufZkFlsai97/1kMiAdDNuYICTCuHYxUTP5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5B0e8RsthxF9HzLncgUHcKOmNafhGM1WxfPZuzl1TJfnJgmap
	y954Goam9EMnQzng/e4ktFvO+WAQpiQonj6LCrM57LV3WkjpxfsbPdO3iVRvYn2ty1s/Lqu5QKy
	Z4ZczIOeCfEWvuU6ZemjyoUiPSys2lUWM9hFekzOCzvB+srBNEJBgKR8KTKao4wzfOQQ=
X-Gm-Gg: ASbGncuS7q+qh5ko4clOzCXfz8MbGQCaI1ymx8LQM73uhTnKsvMQYIZkv0SOAs4nizq
	pQUBVqYbZZGS3f9vR1qvvug4z1qADuQJV1PSNKSbqKvsZ2BkJY+IYvrQbyUucNLiWubH6aBbqvO
	YjEq1RDXZfIiyUGuIkPp/RD4K04Jy4ItwmxwF4oWdXnukr1wMt+SppJt6TCemwsjabjzBkQvNV+
	Jga648Zy9TSzVafaum68/fnl78oo8qdY5Ps9MhkFSSvFzRrNwka3t6c8eMelAFap2+Yf2AHdg4C
	3u1PBLxl288ePeha1H7vzLKijjhCmjpejHy5PK1qORdGuvXDW4DXL9zBLgzj36qUUj03hxHiUni
	iPUs=
X-Received: by 2002:a05:620a:4726:b0:7d9:d722:7678 with SMTP id af79cd13be357-7dde82dd8e5mr7281685a.0.1752163750859;
        Thu, 10 Jul 2025 09:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAeeRzlvLfbUeyU2SSOBFEfwuLO+KS9f2E54G98Fl8PmYU4woiYSJtTIHX8QfSQxlGnb4YxQ==
X-Received: by 2002:a05:620a:4726:b0:7d9:d722:7678 with SMTP id af79cd13be357-7dde82dd8e5mr7279685a.0.1752163750275;
        Thu, 10 Jul 2025 09:09:10 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91d10sm153830666b.5.2025.07.10.09.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 09:09:09 -0700 (PDT)
Message-ID: <c321ed9f-7906-4a92-9202-efb46343ee91@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 18:09:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] sound: soc: qcom: qdsp6: q6dsp-lpass-clocks: convert
 from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20250710-sound-clk-round-rate-v1-0-4a9c3bb6ff3a@redhat.com>
 <20250710-sound-clk-round-rate-v1-4-4a9c3bb6ff3a@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-sound-clk-round-rate-v1-4-4a9c3bb6ff3a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNyBTYWx0ZWRfX/AVtVkOHdao3
 0bou0I02VGRvNCufRe/wGaK0PszwqED5isoL9Xrb9NUUSy1eZbF17865R6/+XdSDBoBmj/vlAnJ
 fECPN2ForgvmWvFuSdn6davV8Qh7LVBiVAJG0Fxx9mvKWw1YDEN1a7wNo8PcSnfYe64VQfZ1tMd
 jaBKtWIvANngRiRPD8tIv+FYoLuNGdIjOc4sOLGpyYyOdZTc4T0uNyz3W0K+01ls99LMoSoRW6J
 uksYG2PkxwaZWgVS367oqqpTdHRlrRwFzuP/xOhxdThyIyBkbvftiHdb8GduiQaG3PNOy3VOt7b
 xJ5dfBuMtGAdI3glIEDg/xpHyr+yjzjZFqseRWOFDX+tm5Aw9LSWfwAX4tf2strrjc5Wdm8x3AI
 5ZjFtNPfIDZ3MWEn0MHHyX9du0Jg9RziKwzi6ZnedQu8Xenf4n8Y1K4R+0kQ9iT+vBA10AFe
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=686fe5a8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=RGHBBWgGYxkf0F71jXEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 4EvX3cBGuVR_MV7NXerc8pLj43VW6VCg
X-Proofpoint-GUID: 4EvX3cBGuVR_MV7NXerc8pLj43VW6VCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=840 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100137

On 7/10/25 5:51 PM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

come to think of it, there are a lot of drivers that can not
do any rate rounding - perhaps we could introduce a NOP implementation
in the clk core that we could reference, instead of copypasting
int foo(...) { "return 0" }?

Konrad

