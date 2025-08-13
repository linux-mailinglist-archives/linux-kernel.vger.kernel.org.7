Return-Path: <linux-kernel+bounces-767553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93160B255DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DCD3ABD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4C2D1931;
	Wed, 13 Aug 2025 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LCJShcCJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D8286D45
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121648; cv=none; b=itTJHL6iUBXrrj0BTYapnFVJTmL9FquM8/LY+LRt6qcIQZnLTGEME4rcon9myAF2cIYxLrZ6jTQGYWAMvGflm6iK60axUxjYM5H8Pommo+5WIBMxselo+8o4RCSo4sYWjzUs+/xjA7Ld59SxamcwnjrOEcBgRN5sySxRvDKLX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121648; c=relaxed/simple;
	bh=3WEil0ehY5vXWc5kCGbGh1iNwldSAw0zKkcaT1ugWPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHH5fFQ4mvSIPVln80jzegkUOveWqRDB4uhGN5MaN68F0v3hLBurJP1VbpFdo1Bwq6p0Ry0HYZiqdLbqSJYHAhqU78+Zo5vGi6aczVYL/T5Sxbrh3eMx+9mJcpYhQ/NnwGDL0rtNk3i/QM7hq2PWa0x++qI9rxIDdDu3cxUVzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCJShcCJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLkdv031982
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PoxP7tG7pCID580yMt9K2LXcQBndbjiv/lE6hcV18C4=; b=LCJShcCJqrQ7J/v4
	GUKejkcaQxV4s9YPZgV8B6+bo/RivOwQyJyJEdjsoQF0qnCkgT7sy1D6zqHnV1vO
	s48+BESFy59JftqMeDl8n2SDCymjYh5aSnCrr1TbCWVG7Kb8IsVjxSZcByDlSHAN
	8IrmNbu000mwJy7GjCPp4kET5WaJXICZmjJntGnTE0eEMzog/jpTZ5T/46QLADsE
	i+pm0N50cbRTQcgWZjzDqVKjtbuQQq4wnqRI9wswOhQOehQ0zOZXm+n7HzJlHfhZ
	1MBWBsL0LP9EGj1Y6HMPq1rsJoFE8RUKzy8jCWnsHUV/YTgwCMYi2dS0hOqO/jCB
	TFDVQQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4hb0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:47:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174b1ae5so147167a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121644; x=1755726444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoxP7tG7pCID580yMt9K2LXcQBndbjiv/lE6hcV18C4=;
        b=NCG1GAt2iYECEjwccgHbbqkbSGUfpiYiMevVIzpKq3CbM0H4AmqvMqChUZIDaDGuiZ
         baH+NsECMdggpqvZza9AoqXvf60vam1dkRQB34cS4J+T70brhvby8tTumkBPV8OnkDzJ
         rsyPUkt1J8TbrPmHHoRiV8Svt3DX+zxsCxmdoqLHONUNK25It7k03F+MFYt7VuZPAbnS
         0YfI73ILBPTXoVUm9ei3KSnDmXQtaKC8RLPnpkrguPAMzJzTepAYE3hl/i6Qnifjkr/9
         nPNXPPkDGx/sN0eD5m/jEIQaeZt7EWzGWydq0R82u010gWEt9dlodV/z6i+jR1PDeDg8
         1dfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBamezjJyCBJ05jdS+gOCI+qcWucE3yJgAqa0YE8IC/XZsEtkGQ6zprEo+vtF/BuuPD3IMUzpTLSywjo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3Dyigp2a+lROH9ZfsE4/+CODYjxC/XCYe9j+hTK6WY3n13Zo
	9Bw8b/rfY1XENn5I7tIjXeqk8yW5eyn2ftQu4rkFG3dEUTjQN5UVhseJ5J3vQPC1OGsPVecBYnr
	arGiwTnQW/NKPWwdifXplvJUEI2ifezEcSW13qgeNXMA09a4dHXJ7YV8GLg8dSf57eQ==
X-Gm-Gg: ASbGncvcrBFgoCMV8pyNNltmBX3v6Y2DbmNd7jnuYsop+1TKvlmKaX+HWuorhrOfDPL
	9F6xH/20L9PjpbNj5T5F+M5h4SNIQ0wJ5qAoQkoYEo3hT8rXcclUOBHm4ClWfBmmctbwYDdZRcU
	diTTQs+NsZUsky0E8KskyWz7ez8G3DbDqXiBVPizJkbASQMMbPErOmwszWQICuZNtwhFVq7cap+
	Rsbt8tNzCX9rG9F8t77IED8OlMDtG4fc44Y+eW8r47baKp8Nz1P8MwSq3vOgXIwEQCX5N+ZikNG
	+s219WeYYsggtP2pmzq5rmg3wppTMOo2wldaCu48Jv+n8hleiC8eqQtIO1RkSu6JrCl6OgnYLyo
	sR8m4F5JF3ce1hzBg4dtDhtWBv4+Au5hs3YYEQQ==
X-Received: by 2002:a17:902:d482:b0:242:9bc4:f1c8 with SMTP id d9443c01a7336-244586e1b69mr7940605ad.55.1755121644287;
        Wed, 13 Aug 2025 14:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgjyhLi16jIYpZ8EHZqnYQaA0dKD8mdlmwaED7WOs0d7tmfiyJiuh/7q2M1HKFCS2ese9Jpw==
X-Received: by 2002:a17:902:d482:b0:242:9bc4:f1c8 with SMTP id d9443c01a7336-244586e1b69mr7940215ad.55.1755121643848;
        Wed, 13 Aug 2025 14:47:23 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323257aa89esm1010760a91.23.2025.08.13.14.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:47:23 -0700 (PDT)
Message-ID: <0af9ac59-9b91-4a0b-92fb-b44e0e008431@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 07:47:14 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
 <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KFpDGaOz0HmfUrk20SZ4YN3CJGBPUYIw
X-Proofpoint-ORIG-GUID: KFpDGaOz0HmfUrk20SZ4YN3CJGBPUYIw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX8fdudlFEt3Fs
 XSe/3gir13bPDdCSxndFeKJG0BrsCXgfAOrXjAGJraumjBzFSRANiPrjzsBt/aadi17keU1VYPV
 5MlEnulry27bazTNgZVcRDkJcUSCeQEFJigy0IecYFyqox0qHl8+LFuhBGlIngGLLex/DgEJbkr
 tjUfxZ4H+nizirHkPKHWwoZtveH7utpCfvgBbnKLiMJTTUTMgmuzpF2rsbnlK61XbD7gRBYtC2a
 +DQf70WAvXi63XT2xJd0ZJCuGJ1aCX0MMaW+uqcaR8IlSegPm5GY34h0X7JxtwZbePb6H1p5h4F
 eZ7SXBs91qI4xiHUdp4KknP6lxs17XqieWQdculgUFkcYBGi9e8scwYsK1GcHgt+2I1czL+O5sJ
 fNkgsqFv
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689d07ed cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dTt1GwfqUVNo7j6m3doA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068



On 8/13/2025 8:06 PM, Konrad Dybcio wrote:
> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>> Anyone with access to contiguous physical memory should be able to
>> share memory with QTEE using shm_bridge.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
> 
> Hm, I thought the idea for the tzmem allocator was to abstract
> these operations to prevent users from shooting themselves in
> the foot, and this seems to be circumventing that..
> 

Yes and no. The TEE subsystem has its own memory management code, and
the qcomtee backed driver will utilize it. In other words, qcomtee will
manage its own memory, and tzmem will only be used for drivers that
communicate with QTEE without involving the TEE subsystem.

This aligns with future extensions for FFA memory sharing.

Regards,
Amir

> Konrad


