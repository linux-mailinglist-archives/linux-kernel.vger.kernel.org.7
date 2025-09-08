Return-Path: <linux-kernel+bounces-806787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5949B49BF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C03F3BEB98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C682DECCC;
	Mon,  8 Sep 2025 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8yC9GTP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2C2DCF58
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366933; cv=none; b=Yvy7w5UQTXDf0PfyclMDxyKHc0FrA2c96ZgOOrlL1+HALwY6Y28mmkgCKJoJ7EyzGyVm1z13n3SfAgVAI6y6hh9Q3FMgTUmJOaQjS4vGx8nxrTHe+qm+G7+duNKogXVCreF+3wGCrufzi43c4p/LGFHTv87KCtVV8addwon68AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366933; c=relaxed/simple;
	bh=+ZoPjLjiNsqFmJXpuAMJ4g8JISQ38PkgMF8oH8CfkM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpQUD5Ric8+KURuxUBhEdJP4URnsrbT+yCn10lYCoK4rEaHZ8BSn8yx4T+Q8mM6u77UDd2C/jxR7y2D/dj00XUftllTNbA3vVkDC17EOa5qKXxJIpApaJosWxjNls7nUzngKTidQlUy6oBavjCdAF+veJYxqr3+v2xeocHbkl5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g8yC9GTP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588G6hUl006860
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 21:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ScGHARm0oECuOzEJcN01KKnFkQXnrnAhZVDiz2pnvYA=; b=g8yC9GTPjmhJQMGT
	uUOy5evnTxnRCeX/AW3qA+wqtjLA3UcDTti6WGQhYyYVP3SjtYwOjdbw/jNwvRc8
	z4J4KyuCwIf+ecjX4/jgHzZ8rq6hQi58KAhCGOACxwphsb9IpPX5J/ZG2QUGcwyZ
	ejnw2RjRXmK5PKolDX7IPGKCx8+vip63cL1N6NVPi7Wceh10oGuFGWOptdX0NYmZ
	lq3CXecrNQqcfhnrT3Dzoo5Stzy9IYRxSzbF4ZMR6tYANZ3q800QqFUX9KL+9YvG
	pjiEl1FXmL8v5UG3vosFRGGazLaW+0Vx/vF7/iyW50dUTE9QyM2BJ6VeeozwF/kP
	ZKTqNg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8e0q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:28:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70edbfb260fso104477346d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 14:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757366930; x=1757971730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScGHARm0oECuOzEJcN01KKnFkQXnrnAhZVDiz2pnvYA=;
        b=xBZgGMq9KY/lW+1fTBiPPbnOAklTq5OY3wmxsNqxzGFh4divM1X3KacuQczE8SQO06
         glKslniPWItiBkVO+Ui4y4qLi3jDJG28T5v1fJNxISfqY1eRlxf53H0v+QhqxogDRELo
         lhXN+qWMY39+wyBJk4m/uzBsgHV8IBQWOcw5VFxfQ11PQ9xXKfiMCRVKnGGqr8RGbMCz
         zmoTidOYb66Gn8HtCcPA/1Bmxj3zSAh9beCshkoS2Akd1a9GBdRNZZiLispbvOPjE5DG
         XViVjYstp1aKAgfAyqVBxoM5gxffkbHmAiU0NCA0WdLpVogcFYFrnOgTUUvvK+IvouIg
         d27g==
X-Forwarded-Encrypted: i=1; AJvYcCViAWwBsmEa8eD9kjGf+y10yqx1slneev6NHy+TLZ/GYy3ZMOs4tDRfF2lIqW0RdgE3JxeNtOAiK91o0SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdiXxYZQ67HwWO0fFhkaNdKaXk21qXkhWOc95/RS1x2uCpUyX
	ebVkmVbPQBPXYJL3EV5J+GqLpPi087l4phz2CQ5KdF6pq86t1Uwit50qCx38ZgRq0srw+kWnvdo
	yYtyLZoVceRCVh1UVKwGKC+vnFElQJhyyt4TqwBqZjd0I/X0/I/ts0E8IrhpTs++07NOGnHHaMb
	E=
X-Gm-Gg: ASbGncudIaxx8yqBvCnK+h5cSBdH8eXG9NOziAbHDo1Bst7Jm5PnpqtPmjG5wX+bsxK
	sqBr6LDXEmUAcymM7UjD3R8g5YCZOwgRbcDqj7Vv8CFwIBlf9vNMT5caSGIBeLhzUiA7Lmi5OVR
	KbrkGUhVyQTMCsvHBx2CedpRAXQbTRLgzDN2oqYXhIrR8mcK7MbsH51pFdm8w4edAEnMnW4DlYW
	d9rMMJWQ6UneIsHXotynSJlkTgxzGJg79IKZVT3SsWwHKyq9B2eio6BwKgJpumqhaSW60G3y0qi
	PsHuYOqoVYx3+ynoHkU5blFD3nRYanVapTsSNyxVETziMp1N0TcOst4TvBYng2fqD0UuNRCknxy
	HdN2f6ykYCmjzl7CR/PbkdIC9qrIfMJf+Kcm81U6zKkOZ+cPPEgUg
X-Received: by 2002:a05:6214:496:b0:70d:fec6:494a with SMTP id 6a1803df08f44-739258aab01mr109442116d6.17.1757366929632;
        Mon, 08 Sep 2025 14:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFvWg9eRYub8/7m0Za7JpIIl4RD41FM6MBXJkA7gLyefolZO08FSmz7yplGf9/6bML7UCQDw==
X-Received: by 2002:a05:6214:496:b0:70d:fec6:494a with SMTP id 6a1803df08f44-739258aab01mr109441656d6.17.1757366929103;
        Mon, 08 Sep 2025 14:28:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d445sm31486e87.71.2025.09.08.14.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 14:28:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 0/5] arm64: qcom: x1e78100-lenovo-thinkpad-t14s: add support for HDMI output
Date: Tue,  9 Sep 2025 00:28:46 +0300
Message-ID: <175736691957.998930.6661595469735181143.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX0EGgQJ/r3Bw6
 5iXlPg/m1rSaNmox33RtGiAb1SK0kw3XmYf7Db4nXhKugqMWc1vHE62r4TernHGMthde70PcQN3
 FSd4GImY5gSGngxjdN125JLHD8LvRISs4yLTNwAmgxU6XhSyXH9rFobT2YJ5CvgvmP9ljAP+mMX
 uENBS7k8ohiHXJ4QmQRLRwyc0aylUoYiZuIXdiLTvQRneO74B3cMV1R1NxyaldNKWolZroYBM1j
 l3orWapjUO4By1GXFrQOSKHtFmI/ozMaNqmPpyK9VL27bujX/ynPt8hT8Exz9JgLh7qErcKpLWn
 oT2iAFRvVAY97VRGw45slWgZK+6QwMkv9hvIMa6IgRnzKJ3O5nE1x4BWEloSdyBYRa1hfi0PDPB
 8qQkMnmT
X-Proofpoint-ORIG-GUID: GfhiY3krCp6olfu9Sr4jqAwCgoxIX0Sg
X-Proofpoint-GUID: GfhiY3krCp6olfu9Sr4jqAwCgoxIX0Sg
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bf4a92 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=mli57nIQh2RWQkMICy8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Mon, 08 Sep 2025 15:04:17 +0200, Neil Armstrong wrote:
> The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
> connected to the third QMP Combo PHY 4 lanes.
> 
> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> of a combo glue to route either lanes to the 4 shared physical lanes.
> 
> The routing of the lanes can be:
> - 2 DP + 2 USB3
> - 4 DP
> - 2 USB3
> 
> [...]

Applied to drm-misc-next, thanks!

[1/5] dt-bindings: display: bridge: simple: document the Realtek RTD2171 DP-to-HDMI bridge
      commit: 2c4f536c75217476baabbd557a44e8d4c3a2a23a
[2/5] drm/bridge: simple: add Realtek RTD2171 DP-to-HDMI bridge
      commit: 7156602d56e5ad689ae11e03680ab6326238b5e3

Best regards,
-- 
With best wishes
Dmitry


