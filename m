Return-Path: <linux-kernel+bounces-762364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675E3B2058F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146FC422EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBAD22A4F8;
	Mon, 11 Aug 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z5kDu+Wc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6C26B95B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908433; cv=none; b=a7hZ8DLHpAkA8YJt98dVi4y19khegOcmw1SGG6QeIGdMwUOoYdXQLphZ+4pO3UeFIUlVUCPa/9BY8AcMYiqkZfDpALtEwSdYvzKK8gJ7xpAsO/GNxw/6AyX+py1ViMW9GEu+8o2cVOXHkBRrtP/23usA2amw534MfIvm2gWkmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908433; c=relaxed/simple;
	bh=n6bYWBbuvYgd7Of4AkNGNr2HVdrMAtKaVoR0TN1D2LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tl8C8N5gyca9qRy0CQfe08H7vE5XLvi7ady0zw3hZ33DSqxkZxn2FsTY0vfUeyLpJAUo9/SJzL710gruVAWiBeOF8KMGcaZMS+Qy+ylQOegW7ahFP4pKG/4QxXdGconeohEbH8WDWIuj1HGoZEp5F4t/BYejmnhLD5LdW3ZeycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z5kDu+Wc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dK4e018320
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=; b=Z5kDu+WcZfL2dd11
	PgqCrzZRc4uUMFixmVOpyzB3rAo0AkBV8WuLjnKlPJy/gRNVEoQFZuhdGi5cBPIc
	jmQL+384QDMrL7SA+FGHcUcJSd/pZRzHRDNIHKmgI0fUFVcczcs4jx7YCpJu1N0B
	/nocx6w+j9ptPWlOoHymd9PO6JGV97I5wJh099Xrxuq+YQGFCaDJzx5NX+Xwe5eq
	aLUCr5fHKszEnTHK/Y6/2c5KnMFBSPCAeDlMleneI7jJWg+TgicWGfY3+qgRAh4i
	O8UNg6AEEmkV4R6U7nj7wdwB9QABdVDbeMNSI4Ox7JdcpCRhJCrHkeeDf5zB4M36
	Tm4qfQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g405p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073674bc2aso16586626d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908430; x=1755513230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=;
        b=gYvFyeWaV4Qt2D+JJM5tl13DVrAjMpe4K94N9wgCQHxDY+7vcO+6scVHZj6Sw1AaIB
         kqrlZhADu1LzJIcnU0tNilyJFWCnSBqnBp8sQpqA/iay7eggxb3wz7xag2uouL/ub/tY
         r1vik+tND+tC/Q7C+hcL3B1xrn6yGIgcFLpmOTAUvljDLYRJ1HLQXkT5YSAgfsTvXSAW
         QGQi+rt5VLKKOViD0dwH5f4hYCwwzLrE5AnYs1RoQW9hIbQkgRAAeSaVGXO9RFOjfDkw
         nu/3I76tpZTjvUJMpRdoxppYqW5JjQfEon621XuyMqKvjtMOqx3UlwZ+arrMFXorclDy
         fN4g==
X-Forwarded-Encrypted: i=1; AJvYcCW+BPJCctypNE1piturcqwIGpLJNlNPlGo/PPCcGFRVX3onpg3XMfnpN+y5sjV8+8uhZue4X58NiFlaNRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQ8+OW/cLzLbwgjFAZXYz2aR+DTeVMBNiikpkEHK+ROiltOjm
	FdEMJGaT0hp5y63b92KLsElg5C3MtFQAR1NM6Wlfhv+o+jfyg8QU6PHl723cfrpyg4TWN3kS8II
	iYV6cnL6Z4KMY18Bm6wnl3AbHZJSh3T8i8rAnKss5dEJEjktybQKskB3PNTHWXMY+ILU=
X-Gm-Gg: ASbGncs21fVd87aVXydwnIdVcQlCbgHOBZgkLyoXaOrlgmJOX/S8koj9bl7sUxee+C6
	SA2LFjnGUDFnylssNf8Yo+sLD0ahXeClKcHhlj6h43isnzBAnzNDpUtGLkem01YS5IOQbnaqFrb
	K6DFZzIzfJDPd8rCGVqpH21Rk/w/+ke77umIxTz2RUFoO/ty8nN/u4KmdBv8Bf8NQAB8fJ8YGUg
	enNR4lh19d4XvFW8iAkZvxDA68RIf5SERpZsOv971FhDlGnDOZeDUOFm0NjorEOl6U/HX7WlZB8
	dbtUv/aCjUQrmnXuMFnDXTh6nHzGHxTlxa7XA3lteT/QBID8vCEhnTloi7hz+jIkLCmhm8wWOvI
	LvJB415uDVKULpxOKBw==
X-Received: by 2002:a05:6214:2128:b0:709:2279:ae38 with SMTP id 6a1803df08f44-709ac13197emr60600356d6.4.1754908429958;
        Mon, 11 Aug 2025 03:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtwOzDhGMWLmN2i3FgRqYSnMd1Y5AQG8+nCHVP+BeNYZ6Jxlh5UsiiwFp8nO+Ut0MqRtRL5Q==
X-Received: by 2002:a05:6214:2128:b0:709:2279:ae38 with SMTP id 6a1803df08f44-709ac13197emr60600116d6.4.1754908429253;
        Mon, 11 Aug 2025 03:33:49 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff60esm18546387a12.13.2025.08.11.03.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:33:48 -0700 (PDT)
Message-ID: <caf2cfb3-0076-47d3-b663-ca2c1bd21c44@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/msm/dsi_phy_28nm: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-4-0fd1f7979c83@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-4-0fd1f7979c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6899c70f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=aS93HcZ8ji4XsMPHnqgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX1jEgbGdUSu0+
 kcjA0E8X+PizKtSpPJiUuGuX+uBYnJ4d0mfjN2NyW3VasDBQyVr6HOl1cdSRziEeuoMPCPNA4FD
 EsCvJ2Y+LWnTKQgmFLqwRWUistUvNgHLQWDbTJ4njKvJ33bAsDPlnSssAsA6nJ4lH2F6dc6WFhQ
 rTqVeXy+hqj/vXv+sz328LkOEYANRKZA23qbLhEYCCR5JRyyyQZ+fQu/JrFqBUykmSBapV/v8Vj
 yQaYyy5U5ywI+loc3Brj97rWCJgZPtD+3CPvtfOM6qIuNypjJn6ebPFuUmXOWdhGapYxacyZToW
 pZWwGLxkr24244zuqI14zJ3AJ6zFVvXHQQ/RtHdgele2bp7tFbkA5Rww2BwLoTErDmq2wK+qeon
 yqSr5KqL
X-Proofpoint-GUID: bJ54spCxP1o7e2vWA1583c-8Ma9LHiji
X-Proofpoint-ORIG-GUID: bJ54spCxP1o7e2vWA1583c-8Ma9LHiji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 8/11/25 12:57 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

