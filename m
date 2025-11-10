Return-Path: <linux-kernel+bounces-893935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E95C48D79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEC0A4EF5FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8CC32D42F;
	Mon, 10 Nov 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eQ8ANLLy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aSYW0Wsv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4A32ABC5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800610; cv=none; b=g0SI2wOockFev45s5UNXVafzDkQNL6S8JweLc4Phbvcnig9MFnzSYD+iRqEaQkrpbRm9mrIwH7kj6c+Nn1tcMU7Hkiem773nolHR4qaMChA9/Bb8b75LmCf4D37dtQVgENuWUr/LKrO2j8fH63F9Ugycf9uPlaeIxrpDkUJboA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800610; c=relaxed/simple;
	bh=wWAAHsBo5eGVreWpDIGPuNgkq+S79c815li9vXHQXAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbJbFqc28dOl6mwnrr8ZJOECiYc5CGUhfS0yrt9ZAbiyu5tNjtF2G4xzJ9oh+D3eAGSjDjadDo6O5CzEq9Xmb2wcctVEO7xQT5G5e8bQXFI2//ukgu1/bSOseOJ4l0r/ZHP7hfOvxUiFZbjSbMPe9u6a6iYDqEBEvJl0ZrHMTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eQ8ANLLy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aSYW0Wsv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAGnmsS4073880
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RrsqLNacV7Ae9T939lkJ95hgRyBZA3cSW6oQvnilp7Q=; b=eQ8ANLLysglmEV88
	MDw9r2QGq2ZNgu8euJvumCzNGM2H3URrC7z4D0VUTCGKH/ruVgQRn4xq7vI8rNsO
	Cjbmw77aXsU65D4WnMnI+8cvbdQtk2oHe1tr9g2YVOZcQnLZ6GJiwmBk7EfEewzR
	WsVmfKBTbozctStCa3UBE3tDRu9akIOj6xTkvAlBzboIO3Ue9A6weUdcZKF3Hkz9
	VjmsOR680noAqDgJklluR6qBErWEV8I8CVaWYSre3ewEAYgjthVBsYjCK6rnV3rq
	WoyymRA2zJRjs4FdGhF/oYObuIL52z0J8++J+FPomv7NvBkBG0E5SrBx0YRWQ0Gr
	DCMcyw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abkws8bp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:50:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso3918114a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762800607; x=1763405407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrsqLNacV7Ae9T939lkJ95hgRyBZA3cSW6oQvnilp7Q=;
        b=aSYW0WsvszyD93irLh90OOLm03E1safSfPmmYFfgNPoBF3HsbdoyqM9fkDNpJK/4jC
         3PayEF6qNII6Dk1DVSghGFZG1tlL78nK6wlpyNGEqJ2+ooF6ye0036xOZZYDE+QiHBms
         wGd4jd6FQDtRJ0ijAUf6po1AMP2lkXWCd6oybxA0o3/aAo1/bDLpY9KCX63gduQsjP//
         ZzXkbimDOscjDB/w4MU+0rJdh1BvvHgEYiapnsJCkKqbktGNQtHHYlWS25ErXwsqNT04
         YgQOw7ePNjA9C/rOdT/UuQ/XZUBgTV2jw2Z77lem14et7MsVmx25Tds+6lbYKFEHdo9b
         ofAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762800607; x=1763405407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrsqLNacV7Ae9T939lkJ95hgRyBZA3cSW6oQvnilp7Q=;
        b=gGh4quGpnKGjWT0MwLZLSyStOQXOfRPjKlJ/U3V9f3tLs+Q+Txbp0I2M0AS8BP77yX
         VORkDtX65tlcyPaxxFuBzPoz12AXH4LuOEtBvdzUpjkXOGbWHYccU4VGZd8Okg+XBVtd
         6Bl1TmcSDnMRaVnYpoC04QEnWtwRqTzKCptiI0LMRI8nujUc1388SbE4CCN4kR5K72Pd
         KAb88c6c5IBYEviVs5dEbH1VeDTxAhXRt7uxY5YuScrGhHXQpADzId6OjC/RYaguB31B
         yvv/mRwljeGOlZd5JkesrGXLeg8wfQJUxsLBgVoPYglWbV6ypeNrfk/Y0yG4d3Iq2oGG
         oFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTRLFXrnM88BOpROMzV1cSO+b+2RG61dNkjEIuep30ZRVurzexe91IV5UtzdMjTDW2AYSZNP6Hu/jBYtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzocqi/To4eWqonI1O8C7Y8+cuB8RfTafW+ccZlxOJDQopDr6Zg
	hscK2Wrx4ikdeGVRtxLbBkqEBplVGofFnIgTE9GpDJGxIhEWYFJXkLDj2MKfho1SaAK0QDiaCqi
	o7+z0ai+Gf/o+CPITj8hOgNat3jKEbvea8I70235s9Havcyq1GhJqO0plw/8ZcPeZTbk=
X-Gm-Gg: ASbGnctO2ea/0cd5o4Ufj7Lt7J9ueZ3gO41mVTHs1Bo8eSA3Nj69Uv0sp+onWeQcO+G
	y8NSnPdYz458KYLbKVzHBeDvtLmQ9UVO94OdYLHFLnvssWNm1hPZ/LxS3D+SNL3kbyapj/FCDpM
	BJXzIGkEwUYUCqOPblYqxIlZ5ZGN6vSmXckTjrYpRgySwykPrroAXhRq7OHZ1VBTi2oJZa1mXPW
	RKzdt/j+VwN+6SxhV9GgXA1BelkxBpU5+fzkGnsmIj1ilq+cTNnFo24+flZMdJk67BosNKKN/Vo
	CKO/NDxiMTdgz5mifF/yA61ztDZaZuEdRhjJeF1ICsxY/pLYr0F+alCC9w++Ca+84xtiH8yr1Ha
	74un+8R1fqsKu4+ZO6owZq6j7/66KW62zfllWQFoS/7eg70BmIsNm
X-Received: by 2002:a17:90b:264a:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-3436cb73f0fmr10032680a91.1.1762800607075;
        Mon, 10 Nov 2025 10:50:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2ixeW1TzGwl+WOFs/7oSmDpLI/67kOgWoub7CURXWxtpro6vNnQTPq5GNpFvY22qB8U2+fQ==
X-Received: by 2002:a17:90b:264a:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-3436cb73f0fmr10032634a91.1.1762800606409;
        Mon, 10 Nov 2025 10:50:06 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343bfef789esm48975a91.1.2025.11.10.10.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 10:50:05 -0800 (PST)
Message-ID: <8f1028f5-039e-4040-a7f9-58ddb3b06cf4@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 11:50:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/qaic: Format DBC states table in sysfs ABI
 documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ARM MSM <linux-arm-msm@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
        Aswin Venkatesan <aswivenk@qti.qualcomm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251110035952.25778-2-bagasdotme@gmail.com>
 <20251110035952.25778-4-bagasdotme@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251110035952.25778-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE1OSBTYWx0ZWRfXxolKpCe9MqP4
 n6Y/WbwMjRYaeGQ/pLfZd1+4wh8K48HXgqjeTaRG//79CFyYOCSfyuQ/K00eCDJ/01FVXIB4WUx
 vfNkK3qmPYW+wWBPqc+NPAMyJdcb9AM7aqaMOoKAkgyRhybbwOHi7plC5yGT48pLCFUNwwsQx2N
 d2drISDdnR9ULjwrNx7pAmOnPjP/02lA99bsN9cnEF0EpBXA2NaFmPVoRSRsmMMrEGc4UefLEr9
 cHVbExhwk8JGsSSXz0rpCpA0Y8pucmQf31/Cn0gh1UVHJrdogCsUjnRYPWNudU1nxxpzpALxsMF
 7cCBc9cd67PmZzOlHC82QcMwdsRrly6IiUHZ6kBUfYPmPgpOaqfaQ+d4CU2KxP1OWLDO3dJlEMM
 k6hlOYKcaJjhc8YSRiqSnwp7l3jbHg==
X-Authority-Analysis: v=2.4 cv=Vosuwu2n c=1 sm=1 tr=0 ts=691233e0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=p_F4U7gO7gGRQ7AvxbEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-GUID: rRAvKKzkvxLy58AcjwlxDN7ryYR1uEYC
X-Proofpoint-ORIG-GUID: rRAvKKzkvxLy58AcjwlxDN7ryYR1uEYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100159

On 11/9/2025 8:59 PM, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warnings when merging drm-misc tree:
> 
> Documentation/ABI/stable/sysfs-driver-qaic:1: ERROR: Unexpected indentation. [docutils]
> Documentation/ABI/stable/sysfs-driver-qaic:1: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> Documentation/ABI/stable/sysfs-driver-qaic:1: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> 
> These are caused by DMA Bridge channel (DBC) states list in sysfs ABI
> docs. Format it as a table to fix them.
> 
> Fixes: f286066ed9df38 ("accel/qaic: Add DMA Bridge Channel(DBC) sysfs and uevents")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20251110135038.29e96051@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

