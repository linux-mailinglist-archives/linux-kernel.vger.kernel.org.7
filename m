Return-Path: <linux-kernel+bounces-843429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43ABBF2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE3E64F069F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE592D77FA;
	Mon,  6 Oct 2025 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q4eG8C5D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BCB244685
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781684; cv=none; b=h7pJzLUEfkyYk2yGSbu9jegEupmZtXegoCDC+qWQNY6A2jr5Q8kmjl8M5Zys7DgsRi+uN4Qrbot5oeF/iZtXZggQVJHhhAeVIj1wwDXwVLSRqh2D5ttYJvBIidYWSEDvYD1DJsz/Pc1/MUWZyCikls2rxbHsexDx4WukxZLW8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781684; c=relaxed/simple;
	bh=unEZd46w6pcU6IX3VINjSAYlvXxSw16jXnA2/y2+cMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpCr6TNfCisMfTHG6lvS9hT+WTXGS8lfR1Kf7h5vuERLOF5Dx3JsEaJwPDPNWAKuQc3TXNNYQ95+Tffj+qWMxL83ukK1M7tNgbnGMk25Ofb4hsxOTqZpyABdA2kpwh8BrEOcPtPBFHxxfhwvB/hDddEV7K6rZ8cnBz+z8EeWa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q4eG8C5D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596F7Ddi031103
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 20:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YafftRWByjLDaFGPU4UHzyU88JZd5Y6+rQcB/WOpZU4=; b=Q4eG8C5DypE2DTt7
	Bc4GnsGjFuklJUwlxMUDbeuWMYMlJg8+s1LJnwyqKp0gLPWbt9IULqaZJC3A75BD
	/jds4cD8tOoIM+Dc66lAQrXBvPGrT4q9flm1Y4rLKE6GoLfV6Yq45XW7x1MOKjFb
	nZ1qfVQrLXubjFna6WJYDI2rPFFofAxLN8Bngmisu2ayOk3mM/m6jaBhItNAunQW
	+XxwYHUypw1vK1Hvn0cjDgNosTp26QrVh2CwFBcPg9v0PM/Ix4ZFd2YxDxXUOTnA
	Ln32E/o006on6A0+uiw1GyIX+epNUrlMBAMka43Xt92DBoZ/LV5zxNV4gpTBMbuN
	nrGcqA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgn3xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:14:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5509ed1854so3205653a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781680; x=1760386480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YafftRWByjLDaFGPU4UHzyU88JZd5Y6+rQcB/WOpZU4=;
        b=fOW3BhQGx+g3l+5PJ/RrWqta9JRpfFYU50bg8qq3GaTBQy0tFfB2L2yWENmheaMFGD
         2utdB7FzD7pWXWUvo+EoDrXD0UA0fBCqWvswRG4ONlY+vvcPoWEASx13+sWdJDsLui8q
         x22Ibs/A4qidn0SJnz/Ec/JwKrUSSYGKLxznUjQuU8tOCVIKertqC3x7l/qIzHWvklkA
         HmHtTpvPIXnZBHzup5wZu2DpBV8uerwiJV7wQJKqKpDzL9xBAn312CzorKRkxghxJ7fE
         FjdLSnGXORy+K9C+ru2PyiXt2AUxisT/PUqyJZp9hdoSXQyJH1rmuBKAS6VhPgLlALME
         XI5g==
X-Forwarded-Encrypted: i=1; AJvYcCWftPgEv4HnozZk8RIZoi3rzrdBruUgMmJLcWS5uUe4KGaSDqM9V926IjSnNfdSIlQa63N9Id1SRLJ7w6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVruUKCspvSnNJC9ZYaDGZLprvnJopiLOQWO+VXnT878SjXW+
	2k11xnWvzFFWcCOKRufJTxeVnVr/LPLkUhzNC9GiGd1wpUcowzCykXuGAHMIZUeF5oOS2jtgU98
	43mAZcT5jRLvJ/xrdQYXiquuUlGY93E8Jv87u4xiOgFuuDAHDyi8W8NvAPSNvNanAtIE=
X-Gm-Gg: ASbGncuoueXGNipzMXw4hRf5Y9k4RfoZQz3j2RZOIrSNfjFACTLbitH66KsPbteLsnF
	C/MzPwpnBXr+YAjP4VqoHXlMRvcUKkRVm+QcgDkIMih833MV55gCTvZ9zitWmMEhkP4xtGfvg2z
	HT5/RBdZV2lb1mASUjpDn4TEsUJ8u4Kv+yxm59V38zR1zW2yhes//YtNLubtPpVWvPuJ1O2A58C
	lZkR26Z1KmTE0ItY0UPaPOpNb9IroKW/K90L4CJ0TKSdrsednwfL8pvfgMa2A3iI1c7gMKaP5u5
	sp0Irw/ox5MtANYNgWr5puwAty3KGpbvx0O6bw6kuGDfcj4uBq5KMK7JDNMSXiMnT3lc010v+Qd
	h1fBo/IJaLW8pcLhEggU=
X-Received: by 2002:a17:903:3c25:b0:28e:9427:68f6 with SMTP id d9443c01a7336-28e9a593d32mr160462385ad.27.1759781680557;
        Mon, 06 Oct 2025 13:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMy6IH1KAtr1j9MdJ9iYW2madM3BGB3q4dXxdL4hFhciKoi1zB57zp/KlO68jvuc7tMpkzXQ==
X-Received: by 2002:a17:903:3c25:b0:28e:9427:68f6 with SMTP id d9443c01a7336-28e9a593d32mr160462145ad.27.1759781680134;
        Mon, 06 Oct 2025 13:14:40 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d11080csm141732895ad.1.2025.10.06.13.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:14:39 -0700 (PDT)
Message-ID: <1d46a5a2-3495-4111-97c2-b726452d239e@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 14:14:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/qaic: Replace kzalloc + copy_from_user with
 memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250917124805.90395-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250917124805.90395-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX9TXIircr/4zL
 mr03j65n+JibZk234cSBSD9Cgxk/mYBYwFDq5Xlyfei4tJIXhrbqWQYirIfhdLk/vIHyI961U2v
 98LyzYplgzfMZbKsWjIKlpEsKMR0n/TZyuDQteHsBQuAfzsm+Kd7C/nPc+/s5oCfD+vE7yNT1B/
 Alr4gYPYiw2jh4zq6dN8GjLEedxSEl6tLV/7UgSWH5PzeyQ+dBySKjDfqRFtsGkYpnqEfc/e+aL
 Z20IhApNiz4vjjtTBQFjJHWKRj4+tGpmAlSGB+TDbEQtJxEbX4zqczHF5sAXt0lj2M2j/YiK77p
 8LDrSm/6sB9WMOGBa5eP6e8Dm+NWsCh8t5G3dUhR7tYDU5WIVy7dE7jcpMXvLHZYy3++trd7Y05
 vRx0G9ymWJf4YK6BEUD8VS7VImiUjg==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e42332 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=mx5ec8yL7mgqVsH1_UkA:9
 a=QEXdDO2ut3YA:10 a=vyftHvtinYYA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: UPON6CtiG8vwb_-i-pk220fe7pYXdi8c
X-Proofpoint-ORIG-GUID: UPON6CtiG8vwb_-i-pk220fe7pYXdi8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 9/17/2025 6:48 AM, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify qaic_attach_slice_bo_ioctl().
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied to drm-misc-next.

-Jeff

