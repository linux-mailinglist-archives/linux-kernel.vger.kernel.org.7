Return-Path: <linux-kernel+bounces-843427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1148BBF28D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9099A4F120A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22102D7DFF;
	Mon,  6 Oct 2025 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Roau5oA/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF216A395
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781538; cv=none; b=YXCWoeqg+jSWBoE8j7hNJbGM19lE6fgYup8p21lNCcPBLC7vBnqUUANlB5kRhSzwhotv7kwCba/aV+r16WxFQ84o13gexew5R6OKImvxF882I5k976i7Bbd0CDBu2psz3UxYze9g0skz++0wEbZ3p1P41SWKmf0QLc41yk97IZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781538; c=relaxed/simple;
	bh=fbWv9VHGBvoHkljFwepv3LgJ3nAI0qpJCHi2CcaVi4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IT6jD5f+rfXJIx0RiHKk1p2hzZdMQAA0qkS5U+OTezNE+j87xbVKn0L7dQIUhWdzdny//D61sX+9/wGMWjut1aRxNarmXT7sEDa+BEyJQKp4oik1GT03FIPHCJ4CPPCF/9NPnntN9Emk5yWp6oUr4MQy3Irz5Kixacyliups1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Roau5oA/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FmYZ1016586
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 20:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kzzfGKAthQsK32eoN+vctDu8EkjUGMKdzeqRRipQt8E=; b=Roau5oA/f0BJNXOr
	awk9V0RkOdRYyBe1J1CGjENsMDsihPoqtkgqE2o4RVm+JIZ1bJ9ldraBXh0/M8kl
	Xl6z9I4RmamqqMZuH9eQ9MHjDhWMbMYWjCnfnpE79rv0gv1X3vVb107ls6Q8qztD
	5/2ydVwNIV7uhLxQ7sLLxpp1mkwBmhpS5wK/QuYeRIzr6eiHl4rDizC+xVKSey4K
	cCKZ8e1DNRXLdXdwaRe8Jckq/pK93bhdA/e/1u9gunIGh2JLU4tANiD6xF2PZC5i
	SjQgI5wl+u81Uk3nUPB9/vu8BynD1H9/+YF6NyT9+0j6Zp8Ty5BIMHa2HdYox3cr
	zlS1QQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthpw5s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:12:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78117b8e49fso8781952b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781535; x=1760386335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzzfGKAthQsK32eoN+vctDu8EkjUGMKdzeqRRipQt8E=;
        b=CmJcuuh4jlgNJL1LQtfr5aru2+uJrug1sz4m6VjapfXDYn4f3OW2+ywt2igybeMOTz
         3J2i1EbR3mIOOdo9KB7fUa8xDGssWR00FyZ6YWZHcI3PqfLcGiDOOJAAfwFwRejx99uC
         7VAk4UhdvpZLuu7Se/rsmNljTIr2xEGN7eMrEpLiWB+URJDRQshFTmV5s/goSPwx3ANs
         x2FIEbg3wpSgXJE3FDNKbiZB1P91IpYw92IO+yNHNhB61htSpkhAWn7FsUk9zXLLr6hA
         GWyNbpo7b5nlDUCARI6LG+Xh2fzndHoTgmlQPIEfEkWYY04R5ItIez8joO/rwuS1tw8o
         DlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqlB4lbCpMknqUE50xl680s+nMxKGdZnU53ZS8WRiqwrGdb5Q9Ft/Yjmxc+jqx8+vKwSNo7cBJnRXEVPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKgelTirevxak7tX299lJUiY1MaTcAEwudxgV0O+6hqWonS8g
	8s/+e18sqJ0kLejOwuDZzLgZ1oiK/FD6cvrIHeQ+07Z8esuoKzWaCWu/q+9+cCAeuAkFyIfqLev
	lxk8rpNSocNscHlzu1kuO2s2lT3t6DY1yUVVSZG0VhL14dpoct9GhKIT9GIyBqijnfYs=
X-Gm-Gg: ASbGncs9emZm66GggTfdgnJiAS39ol6dPEQLDALO/aw3wFPvnUOUGwOkCaJy37KtmJJ
	CCojmuowdwCpAcabxubLsDHQnpwENQv8G7yLlCjkDybcinp0coaW/bjaMqoC9W0/TOLtXTxnMYh
	OBGWjmm5nW+RKb+rcf2Wz/T3CraKMUtF22sKfD/pQRSKWha31N2XbKxLsc3EUiWGC2HHrjdrMob
	zKr/MeB6QuXJJv/sevwhmK3uHr4wlEPZNV4LEZicbXNvupix1FXKJmQGStXLNG0BDNMUh9JYbPt
	IBZsDsvYm+E72+AvV36nnQPbwqmD/YFTxijWJ6rk8Tv73Kd4S9pR8iyuptv1FVmo3uGkSEA/JK+
	B/xAcrKKCXEb403ekJEo=
X-Received: by 2002:a05:6a00:1746:b0:781:17ee:610 with SMTP id d2e1a72fcca58-78c98dd9621mr19310700b3a.17.1759781535067;
        Mon, 06 Oct 2025 13:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAZFG8hgyCdPxR6zWs2eZUlAvUOkgVWHAtpD5hAmxgbNzV4Q7WaKJn+d5pIr25u8O4YLH65Q==
X-Received: by 2002:a05:6a00:1746:b0:781:17ee:610 with SMTP id d2e1a72fcca58-78c98dd9621mr19310669b3a.17.1759781534579;
        Mon, 06 Oct 2025 13:12:14 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e50esm13321566b3a.62.2025.10.06.13.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:12:14 -0700 (PDT)
Message-ID: <ee526600-05cd-4ead-88cd-ceca776ade80@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 14:12:12 -0600
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
X-Proofpoint-GUID: WytMzkx0_AZMYnsFlPCj5aYgvzZ1IWFX
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e4229f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=MFX6GGzU5ss6K9bJXPMA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfXzWssolSxERPa
 YiO+9jBChA4zlmHCxRSgisLoU07W5r/C8qyfB/Jn+H+ecz2LyjDx/YDpPODOPUUjzlFCqXtzO1A
 SqjhFICFr3vnkH2X52pE4wD3RiJELoLSdUee8VVOhgGhk3nJrjIthsOjxbuAKJuuteNZHUOd6Mw
 Jv+iB8yC1lsf0rHiZPFozIGcov8BWhhsA1Z0XVyYzDSDbUoqGpx/oY3I4iU1HL/eaSWUjGUBBop
 hV8ACBrJ09GS0Fd7Sujd39osIsOy5dOp9aaOv2MkVoVx3rhogS1QWlErbySp7rnFLz6WqaVickj
 jSY4g6KE6AcSSSKzviaYH/vV/M74ejaMV8J1ZThxt4Ly5mbEx2dtrtax07HrQYPP1A+2mTqmn3Z
 /O27dtJJCZfM3ANTurHx9mm49vuoBg==
X-Proofpoint-ORIG-GUID: WytMzkx0_AZMYnsFlPCj5aYgvzZ1IWFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1011 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016

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

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

