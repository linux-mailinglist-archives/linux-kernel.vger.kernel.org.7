Return-Path: <linux-kernel+bounces-805334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FAB4873F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1E4189ADB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A79B1F8EEC;
	Mon,  8 Sep 2025 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DcIYfEGv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7491EC018
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320243; cv=none; b=YCL6rPqx5VfChV1Nt8UfC889FDe0icrNQqSnd4rrYL0Aa4VSdHkwLY4cUIO7kqqsjFSo625PVTDXkAGO7XtjXLhJiEAs4V2LO5QZq8y6MhKF0PdU8cUUbLjGrwh5XVthbF9xJOk7hyM7/nJwKu/iI5Oz4CQtlfIvWmWTirTM3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320243; c=relaxed/simple;
	bh=LdQy1ux3TFO97L9j7KgRura8OaIrmueztuYraK4RdZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKe7lMZbPDsUCR6CaDhCuuMnkDTefGTWt0ZD159/WL+gi/JwcX2gQnr3CujVuJd28XTnn6jM0pTw/D+iVW0CFFV/r2B491/SY0+staZ5ajNvNYxOpeZKJPuTpRa04eKxAY8IZTr8tGhjFeSLe3BZRc4CdDsKc8fKV4nRSEnItVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DcIYfEGv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MvCic011099
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LdQy1ux3TFO97L9j7KgRura8OaIrmueztuYraK4RdZg=; b=DcIYfEGvJkjyPGUN
	6yXK+IF3fZma6Z2PNyYwCP3RHdPQK2122r2h6WfYbvsKOtCqUZjJ5LanVcy2xZXW
	HGZTLARLbBnYaMbynExoWJykpucwLJ8rKVgpiJeI43869toRDKDCmfEB3ysNHJxG
	jRoaEmP4LOmC2E+JEkwTrI3cDLd0DsiWPSai3ujCa+yx3a3nb4HIp0hUme+V5nTd
	0eEa+zvZR+T8K3dSFxH/PwHGTu+NivZgqIZGpiT6Q/P8MfNmueOxv9v3xfskoO51
	E5tJ/Dl2HEaUE0nPzhY9NiVQ1gN5KHB8FFXROPfnn7ExXcSO5oS+LBl8bCpspgbj
	vdYBeQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws3vus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:30:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f76fe6f6so6084281cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320239; x=1757925039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdQy1ux3TFO97L9j7KgRura8OaIrmueztuYraK4RdZg=;
        b=prajCb00cmIWaknCrZJMS4LJNfW5qeTjWIN+DpFrN2VTfqVEGfCny1VIYWdFZmQuUr
         pSgjpo0cICM8WbKHRdjuguaqeqe8j9tE4y7NuTPOg9nf3/dIctgJb1bkkURbLTHarWAj
         lnlakqOMdVLcHz3/fZHUqs2FI8FI9gwRwGLvH9YTvP2fEJps+M1wpmjhP3EibiMl9wB5
         2O3H/iIjl86DtisriHweNuagQr2NzOFC2yVY/efem/hC6ZmmTTqOdvo4gSpNICBZKQv/
         Q/pi9S54CJog9KULyiE8AZySFRxwEm3zCqitjouQRmFVw9Ofp19GuO3z41b9D6DhpWaa
         9clA==
X-Forwarded-Encrypted: i=1; AJvYcCXoHzsa/Z5DhkSEH6u/zz65HRuaRepQ2/dwqP/he7+pLN5qPyKcWtHzb0YfDHcP7i4YTT+6p01xEywHb2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyir47ge2aHgwtyeT45z0Mci/n3+gtUXNPPzKb4HFXonJftSHDt
	X/prJUj2ADEkL+Lf3icolud7LCjBLMNCZXNZpDkqIxNz/ZgqH0O+pfuGkCpPzy+chC0r/0NTUT2
	GJEJ7rFVPkmAfzkR2sipsaY4hhJo7VWLPJJON7AK3j7Mze/YbVK5RkXZWZOJaXexpGc0oElw+Ii
	U=
X-Gm-Gg: ASbGncu32/p9NH7Wv1MvIteu0rD0/0vtgHmUdRIK+YmVWe9q6XyybBhzcsyHlQUizAh
	tDM9CrylJHrlh2I0SMPFHAcjLBpEGGyWvajURfWoJ99O2k+pXQmIjRH7OlZz6VM06qib/xBvbsn
	oNWCklj3A6hroeAO2UVApJRDZnmFbYBknkqZXHvFfxBrYCQYaOaueW/l/aPpvjpBhjaMPnMzqQ7
	ElGRVlQH2OCKAzGOEqIEydquLcShKv/VSfAr+pk7TPTnR4WYu8ZgJJRyeJNk6oWbwVo/LZiF6Uz
	/V2FkAGrOOuaE0HvjJk+QptePWLPOtcG5NRNy7h/eJDwvOSGxDaYYEki1boOpDEPdoWJcrJGF9/
	Ss74ptgHc+3cU7k61ljgG6Q==
X-Received: by 2002:ac8:578d:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4b5f8463068mr51892541cf.4.1757320238789;
        Mon, 08 Sep 2025 01:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERSTWm/T+KcYLEj3pcPTCBa07ap2kgef8Psp3x8RFVl4n8Hlu2Zf+x4N7m35PGQLHBEUM5VA==
X-Received: by 2002:ac8:578d:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4b5f8463068mr51892411cf.4.1757320238295;
        Mon, 08 Sep 2025 01:30:38 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04c69545fesm388450266b.73.2025.09.08.01.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:30:37 -0700 (PDT)
Message-ID: <b9678e6b-fb8d-4379-8ed6-4de19b9989f8@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 10:30:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] phy: qcom: qmp: extract common PIPE clock helpers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250907-qcom-dp-phy-v1-0-46634a6a980b@oss.qualcomm.com>
 <20250907-qcom-dp-phy-v1-2-46634a6a980b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250907-qcom-dp-phy-v1-2-46634a6a980b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ge5bTmVYFiprO4cqCx3281cmmHYhgxCJ
X-Proofpoint-GUID: ge5bTmVYFiprO4cqCx3281cmmHYhgxCJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX0EOnOcos47Ab
 UOjv/hA+lQYojIktOo9jmiT33Y7+cVe70oDZmX5Xn2/UN0eff37TtpM01ZYvohQwSmkBT9/KN8M
 FvRrcl3kgh66oEq6RItn6/j7yfl4HCw/akJDPX3fv2bAuHQ9dxDMxJXwMdTF+iFLfQicA+b818H
 Z2QQNzHAeBqPY6Ua3aV8MkCiHPaSiUDOeTRC87SdEElAXWSA8KnoBRZoFdngwD9Fbu4h3MjUEQu
 aeKl1sWZgYsswx1tdozaFi67yTBEt+Kk9NsMF7nqLrHZ0FvGjMxyOawNDUtVReDmtct78jFcgSy
 1aApFh/uukvaOAoJxwyWZix+/JNuB/aS52TKW+f+A9UnkbKQDAVvw+YMxfB4Lactjm99nzUt3Bz
 BjvenPyP
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68be9430 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=fziS89exnlNdC9XCmC0A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/7/25 4:52 PM, Dmitry Baryshkov wrote:
> Extract the code common to (almost) all QMP PHY drivers, which handles
> the 125 MHz PIPE clock.

The rate is a little more in depth, but:

a) it doesn't matter because Linux currently only prints it in debugfs
b) your new wrappers can be trivially expanded which I suppose I'll do in
some follow-up when that'll be useful

Thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


