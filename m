Return-Path: <linux-kernel+bounces-765213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55312B22CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEE57BB90B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC062F90FC;
	Tue, 12 Aug 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4KJ88+4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB62F90ED
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014338; cv=none; b=faQvuBQlTfQ32uKhVaWtlgKOGa/IcGzreIdqz0PimsbUSiPX+hLLhCfkLtMY+D6gcvnP8YrjWli02fIDnqFpz6G5rAE0A0sp66AtTseJOBLTPdy8mphQaXcupx6zwDCabehJiQixsPpscsPseB1kahjaqL5LNPSqrPupplK1sNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014338; c=relaxed/simple;
	bh=Bwoe2afa48ujS5/V/Htdz14/LSDLiFIiSlrAiWittNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIoGuKHPuDMRqziWZdF1ATmVH2TVLdwlzKs71DQwsdQsRg4mhFv/Eu0fZZqO0GIgkwS2aD9af0y7nnJQu4v3cCbrPkKkJe+N3xygVf4yOn5Vqz5UA+nDfSpTC1JJxZBBa5TUivz1h0Xa5rfbO9F+/P/pbfeLf8O0dUYV7p9AMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a4KJ88+4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvapc017547
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bwoe2afa48ujS5/V/Htdz14/LSDLiFIiSlrAiWittNg=; b=a4KJ88+4gzUNJG6o
	oVPZB7Mv8DydBsggqv1HnHpLVZwq4/ImiQALVaVDqhmZV/c8du/lvC6OkCiR2LJF
	X2QM7Pq5x9J2IESwh6oa/vuA+g2x3zrHNLMxvJkNnDwJ/vpRgIoZHH8+rMSeNWWV
	5enbPcX1umKliXnfHDKUUXijpOAm0SLWy3iKn29zQjPuRBMgpk6g667gg4kFs9yF
	igG0+AUtVBmdwzPAWf6aIJF9rJRl471nu04QcSHxCGaszkf2k3g7TM5+tZa/cEwP
	DKEz4CsGfSsUuaUFA8cNKYWdIClI68A+/5RIQFvOfGyrCePRYyu2rVZpcrW3t6Ts
	tQmSzw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4cq7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:58:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b429e665c7dso7491285a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755014335; x=1755619135;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bwoe2afa48ujS5/V/Htdz14/LSDLiFIiSlrAiWittNg=;
        b=Q5d1lZNz69TSCGEhyJhgSiLGq7067dFX8VxNvX25nGI6nX5SA4uNZ+iEOhVISUKrQ7
         2TnNJuijW4Inr6zcviih6k0tEHIU+MaGdsGMQO/fDm72cKdQKcHfqtnz/2L9bLwz6H9j
         gaTGQZ6mr9VIayWPb54a9zPaP7ROCgONYOrUuISMVkTvUDoRAzUaU0cVKIZaxGfHREq+
         anFqro2tfHxFm4Jwd2NPxJwdRbOPmoCJNhUsal/YyRo7laEp1A3vXWJ+frMOeeZD0wmE
         TN9niELL3XQivwsZWoxdL5FhSoT51qzs+dgoCNLen7vaUwUZEOq7i+Fo/20M2xqTbLFH
         cAhg==
X-Forwarded-Encrypted: i=1; AJvYcCVoqxqSjeFdG+Chcddg6kAKPkTB1GOG9cK/yr4JqsqFhVWhw2qUvsBthH+iKiGxgn4gXqRn2W1bFXrsPLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoQWP5vU98GNMXzJ0sUYbBKwelcrAxdyW3CCzSJ5pEdrpZHgw
	eitrOhfEettJwQLC1lBOKmWKnbnT5r5nj1xK3eeSjpPqtSKW2fjUuoh7daWW5axuhNKUg7fbIlF
	4doWlop3TeV7kZ+STbWlam0M/wOQbPASiK0ZwTSB/TxVnhWeXW3bgrsEoHv+Kpk/JNRA=
X-Gm-Gg: ASbGncsTkVMRHKUZpXdaaYRJuTXxIRIM6mnsuB2ErCJ65Nz3rUS9R0IlNnS7e+LDkdD
	OM6HI4CdCclv7InptqLy2GjQgCsoRW364A4I0kH0bAtxtdYHyVoiJCqo5fxgJj/9sZMmbxRuG96
	eDOlg0oSXXO/emyTQzhOcEkvT1B3oa7ZN8R5NyOW+HkETnThz2yQABbO+g2+6cMZaX+Zet6EH8M
	kbp22HesOjpkYuFGZmcQY2rVpHgsYmZ5MMC451p+D9NMsbz2Xup261mC1Qfn2GrBjSL4GYXf+D+
	vdOZr6Mh8OXWzwOioY5vpX/HrnIGqtxWESCB3xAAf2R9ec7SE5lA0iEIAacA+LPWaKCeoKU26jM
	LDiyyY/PKNURlk98YxKAfQ392VifWN83v
X-Received: by 2002:a17:902:e889:b0:243:47:f61b with SMTP id d9443c01a7336-2430c11e1fcmr2768105ad.45.1755014334689;
        Tue, 12 Aug 2025 08:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiaUWFnVGiPrNJ582E5fBjuSnhYrZtVZiz62WpdkRWMNIBQq9NnLaAArmOWl8WWLjz946MSw==
X-Received: by 2002:a17:902:e889:b0:243:47:f61b with SMTP id d9443c01a7336-2430c11e1fcmr2767685ad.45.1755014334227;
        Tue, 12 Aug 2025 08:58:54 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm23976159a12.33.2025.08.12.08.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:58:53 -0700 (PDT)
Message-ID: <053a7887-c08d-4272-8ada-cf4a008894f9@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 08:58:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Stable Request: wifi: ath12k: install pairwise key first
To: stable@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gregoire <gregoire.s93@live.fr>, Sebastian Reichel <sre@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
 <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
 <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kbXv6_B79mA_FWfbukHk4YF2iPttmBOU
X-Proofpoint-ORIG-GUID: kbXv6_B79mA_FWfbukHk4YF2iPttmBOU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXzQWMWHjBJ4iS
 uuxXWjfOWcPsKfj1LRjPfiyQWQhjB2Y8L296jnpLPUhM6rnalgjlHkW3iSE0TFu0+Unw3DpCiVP
 BPwSL4W0ESFS0CHzDM9EB3mX6EJev9lJG2+5BImeaNvhWEJApln1YnlWuIUf4NJh5v+fV4p3HeJ
 bQkiPiISyXlAJj5Rd6teAZ+B6fgIlMYTyoZZxV/GGagMOJF4A4t72LqOke5BoxARA1vmeOwLhMD
 zzjc/SVHHleM5Y+Az9ESLeTBR3Vu+fcML7kMRyG14Nm2LMKyqCfhN3tcrVc+OtNP8Xh7xRtSq4E
 OlHvm7LqhZYS41rZXSa3FBWQf37MpDMqPq3xPuM7vZ3kxJdVDera/6eyUeqA94Kdcx/lcWpjKX9
 9+r5u32L
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689b64c0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=mWBu8RyEdIvK9AmNwbcA:9
 a=QEXdDO2ut3YA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

Stable team,

Per https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
Option 2 (since the patch was merged before being identified for -stable)
Please consider the following for -stable

subject of the patch:
wifi: ath12k: install pairwise key first

commit ID:
66e865f9dc78d00e6d1c8c6624cb0c9004e5aafb

why you think it should be applied:
This issue impacts all products that use iwd (instead of wpa_supplicant) for
WLAN driver management

what kernel versions you wish it to be applied to:
All LTS kernels from 6.6+

Thanks!
/jeff

