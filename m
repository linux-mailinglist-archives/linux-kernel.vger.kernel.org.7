Return-Path: <linux-kernel+bounces-843430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0171BBF2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B7FC4E443F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22962DCC01;
	Mon,  6 Oct 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/+Njtc2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89752D6E66
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781696; cv=none; b=VaLdSWhWb2+ZaeJftBRyiuFYPoatb06xLeQfftKxC7u9SZl/R3DumwNcCn0lne2k2h70pe39DleP6Ax9AR997MoSLNFPKqzwRbx290+2kUkE6dJYHFQB5gXYZ15zhlcZfAK0vdHZ3GkJPo061pFpu8FKosblrVhWKRmo4x5oVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781696; c=relaxed/simple;
	bh=ltxPp9xcXdRhEJeCrKgU/q/mw7FGYyItT0yneJkV/XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl9cPBTIzDrVkay5waYZmoMU/g9FF7lE9ObmM3KqI8m3sEDadId/YNpAvpEMYXre9fmzKJYiRczegF7geywk1EbkP/vbvdxIJQ9kv1HigzLlSL1GvNMIvc81cy533mR8xhKJRKQcHWZMinsnOR9GeWGiG7bXSHYsq2LfEdmlZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/+Njtc2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FVtkD029492
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 20:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vEyKAN1vZzuHQohePa8sXUurcflNDuWo3yDRiLif28w=; b=O/+Njtc2P3rF6Ro1
	O406W+XGTHFJwHmHdNpSGhjKBHf1frLRiPyMtceZ+TeIhiDbjbHd2rQYs3daCyb7
	VOcF4McaQLwak02K05GWj/tZGA5fqvTBSxGZP2c+pE/pjaqSVG2ZDJYBXETN9wGC
	sK3765dpMRvPmTJDiN7XsJ52juo7pK7jg+tnv6V5CaeunaAM2x3vlVcZ4xEeJ8Mp
	lA5XNpN+kC8HIufn8PdnZ09pWqEp23zxv8cnMiGcgCSYDssZdZcWhVZKpk8385KM
	OJLG9zPtrbeOP0VyUfFnmuwPLA5pry0iYeHAkDCO3DEFWUHNjcq9C9sTUlKLQePl
	nb5ttw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgn3y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:14:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28bd8b3fa67so46785755ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781692; x=1760386492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEyKAN1vZzuHQohePa8sXUurcflNDuWo3yDRiLif28w=;
        b=dbfjEnozGghezbgo9hM4QO1zAKYLelhTeL3Y+KLikQwvqYhmXddHq5RuVdkb2CBJ2T
         5cHKJUWv/1XI9TUluY27Hel/mq0cbcNsCFgfis+vUhTlouV++/W1/2M54Y4zddWdrjSZ
         IuuJrbWSKIfs38/Yy96sH1Dl4Wc0GmGxTx2vr6kE/zZ3eFdBCR9D6irTlaCs5zG4JSd7
         94vcry9qNgg2w30FiBjtSLNefV5285M+vaBAWhqUd7MCTSsRSie19fAHgDidr9vM0gMb
         DbiYcsTchsts731/9k61UwWB31XRmsIsa8BqtasfYFHBs+IhL6tobhDwl7LAodG03Ilt
         cgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL+pUrhG139hryUtWLB3ySWBYkeTf1L5aSWVuNTDjMSl34YiZEdCGCIp705zwv3m2Q4wkf+c9UNYNdtV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvd68U/ayGrszheVQo6WAvVfMXi7xkh/pQmKoPJvRWWBsHgkfh
	h94oRe1vh2v22GCz9pJC1ZZu8g76enaXJd1MjHVJvYrz3StOZhpPhKsfThmkQPij7kuO0v5F4tq
	ayWMAaf8ZigfznU+v26pm/ZDVln7IxYPs8YmQ7jFFYzw7ZzfgcnA36jW/K2b+5WQ19GzKQAJL+5
	A=
X-Gm-Gg: ASbGnctrDGN5Ov5NQmSQrIPQAmSa2oaq7yMy4q1ErcOf7YKF33aSfk36OHDXQxJKIwU
	+JxkmoEaMYrN5ql2ZidyU94HNgBp8FV00m+k+d8GncZavLHc8+Wq3V6e9zXch0hiBenqk7tZx6F
	SlZJafCN0994/qW3z5GbTawp75i8+b9GVNBrn527f0kUzoXJz3XcgmGrEKBLtTuzLKynlzkV6g+
	2M4gc+TNPrZwATwMXqx+yH77fnjkZCeWuScfO6DpHKSHIHZVW6S6lWGyYfWALTnCLw+pxJKg8CX
	eQAb1UqutVc1eTklT376y6lVsJIZsjnwAx+Bn1Mst4oC7Dz6ywellbTZUSKNRwDhBIPkXxmfUn6
	ADo8XQeJvmvdrYMHhALY=
X-Received: by 2002:a17:902:e785:b0:24c:cc32:788b with SMTP id d9443c01a7336-28e9a5462aemr167629585ad.3.1759781692096;
        Mon, 06 Oct 2025 13:14:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyuhuX8XSBXFG1NNSSZ4gnA7eVmFPYvb/qOVtcgIaGnkKWe/CMWBH2rUUBP8WFesCSxm/CbQ==
X-Received: by 2002:a17:902:e785:b0:24c:cc32:788b with SMTP id d9443c01a7336-28e9a5462aemr167629375ad.3.1759781691660;
        Mon, 06 Oct 2025 13:14:51 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b9e4fsm141410375ad.73.2025.10.06.13.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:14:51 -0700 (PDT)
Message-ID: <6b91d49a-37ee-4847-81af-a1e5b0b0d4f4@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 14:14:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/qaic: Replace kcalloc + copy_from_user with
 memdup_array_user
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250917124805.90395-2-thorsten.blum@linux.dev>
 <20250917124805.90395-4-thorsten.blum@linux.dev>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250917124805.90395-4-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX33bqHUpYXKXq
 bdQ5D0Hr0ueGJUTRRaB3L2ikxapwhaHaWXhQchD1D8W9/CTwx1HVzYFbuqspqhpA1cT5wOAsEib
 MvoT/KH/JEX5P7WwZNUwTabRaiFP+9sGhJYaM9yXvWX+gKEOD8rs3W/BV73chDo8zuxPtl+FRVR
 vqEvZ7J0jf6zVS1KORlQBJKlDAXn0mYW5qT3q3oDIzsLoxqGt6zvu4q0oIO9Jk4jhR56PV9j55S
 nPwnEo+oTC4/AIr6fEOkI45Us9IxAD+5dJeVdrD+VfJIWXSkVPYG7CO0fcL6b56zaYdWBJXBhdz
 gzdlaa9cpVo4nrmVn7+Z3OeeAu7Qaj0p6ch3CfiNYiaJ7QmQk23Tz4h0HQ2gbftbZAk7qJ9m9PT
 KHt/o2pE1QJALhsRnEBnTyx+EnCJJA==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e4233d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=MFX6GGzU5ss6K9bJXPMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 2H08_5KCm2rjSWhp8rg2PWjT1ldr6dsK
X-Proofpoint-ORIG-GUID: 2H08_5KCm2rjSWhp8rg2PWjT1ldr6dsK
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
> Replace kcalloc() followed by copy_from_user() with memdup_array_user()
> to improve and simplify both __qaic_execute_bo_ioctl() and
> qaic_perf_stats_bo_ioctl().
> 
> In __qaic_execute_bo_ioctl(), return early if an error occurs and remove
> the obsolete 'free_exec' label.
> 
> Since memdup_array_user() already checks for multiplication overflow,
> remove the manual check in __qaic_execute_bo_ioctl(). Remove any unused
> local variables accordingly.
> 
> Since 'ret = copy_from_user()' has been removed, initialize 'ret = 0' to
> preserve the same return value on success.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied to drm-misc-next.

-Jeff

