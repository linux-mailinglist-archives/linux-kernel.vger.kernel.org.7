Return-Path: <linux-kernel+bounces-751861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D28B16E72
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1CF7A7A02
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFC29DB81;
	Thu, 31 Jul 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9/WzznN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD129E0EF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953691; cv=none; b=sBa4pafwgJQOvrmQ/L0Tf40SEqrOWgcz99FRABrKozNVRUUWiRr/2EeS20EuCKHFB1tP7SeMuImF6QMZWZo+KYB9SmJMiQb0mr89Udz1VY5+OVtQnXZAYWbAYK6b3oSabtmnSUAY3gV55yOl4NoE6WE6FHSM4TTPFhwUfYRuLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953691; c=relaxed/simple;
	bh=xpQ/EETidjPmojALdAWFIu2//pYT8zpUgRj3ZDR0V2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=razXs2m8jM30UMdCkhigb6Bv/fvd+IleqIN1EByeRn+NH/B5fTGKEtTbp5O5xN/na6CBPGzZvZitn2USUeU4Zr2czz5gRd98epTz1PqG34ba3xR124zPADF2clFsnavpnwTEfDgw3wtnsqhP1NweVZl7X2KKwCum1/Mimh1znP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9/WzznN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fOjP020374
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YKaZRpzTXWacG09Osv90jCxKbdHhzZHJjXyXniyeau8=; b=W9/WzznNX7wf3bVn
	78X4fDfQWP+G4fVjX5RCjLLMJDMwYF4oThT6Dw1aFomF3a4dw96Dw0bhCC1qWO7d
	4ZRyIkPpan7q654q4SyCbxCzfrRUUYLH0BVjKGuFoh6JVMZSeFC9YleYNCEEHb3/
	W6xjDHor/kEBI7SeO+m/ch4PzErSvcaq4xhg1EzYvFhz76odXn9nadDYjcW0H66F
	GFKLMett4EVPpMiLM6M3abB5/7VK/LvvizszwxxNJz+yw4R0tmhNvyZlAVw8vMcH
	psHHoLtx+gdjjdp1nZ1+FZBTFMyf4/IV5PDzK1ElfU44LBg4N5gvPdh3e/JtvhSV
	WJWocw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1aq1jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:21:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e344f333beso13665485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953687; x=1754558487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKaZRpzTXWacG09Osv90jCxKbdHhzZHJjXyXniyeau8=;
        b=Hqqh0CN5AnngKzCFrYSg1L2Zu8YWAUoOEDwZPA0hjZrk0mUElzT1CQVGqrPJ9WaUKK
         kH/81RHI/8A2vQrXevKvA/6p5Oyzx+8BDCYWG4Vitqc7EO6LMXT/5KRbdIzhshZzOZIP
         MzA2WGEoFqMvFE/p3e1c1LrpwK4N1yUZrqc+FwJOXVcOZDy+8+YqjFjhsYRYTIjt8hWd
         gZwkikWo6P2YiADjWNFm5mVsaAir/iFsHCfXI42UzY7jg7aLI5APVQRKEUaL88S8LIkR
         Z25aFELQY/VOybB8dSdQkUXkRee0d5cIloQcAD7UaH4vBIcSwEVg1LecujGrpaMVyGzf
         SMkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOdxJoPltfQWMfqu3RpRBJ+87KeMBdgpcCpAK0Hqzq+Px0y4i8hftTNG/5/oxTQRyQK49HJZSORiLiJ8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjI4OjRURQveshg8fxnFdJcI8LnKRHybDp/dBnIqQRexoNsuXG
	2pbY9zE1qAaYOgl0od4bI9IHXsXhcf4KyZPYP//cRM3Mm4e6ztPrf7KnCnYxF98OV+Mu3skaZdA
	gM7WalGHYau+sxN8mZ4JEoCimpyCy7Sa+7DOUWzLeAd+doi1et53RWZoHXeToxEjK4sM=
X-Gm-Gg: ASbGncsyvec6XEkg8uEmptpiFOQWJtuToOXwhIYtPDBDMGR9+TqJAYBiGzYZEjeM4lT
	hDAN65JfgPS0l5WLnZcqP0X0kIJUuK4ACj8P4OUny7hgLcvMNGNy3pQQ6rfEZEToaEwn6tKEY1W
	WjRJJzt1wAkJfmE5V2uosS1VyEzVkEuY5b6Xk0g0pjK10VdKKCRS7sL5wyMBeTe2IDNxql3U8vD
	E4yFQlERtPw9+5vA20RkayMXZimCYkji5pzs6XYeN3bPKTvjG8cpGM26JUdcCB7tWIv1xBXVEet
	tNP178OXmyEkGSSjtThZP+7/DTZGz9lDO7IlOujH7I3ha2X9IGdUZwXKxeM68U/9eVxN55yj/B3
	K+muzdR4HFq0zzkSimQ==
X-Received: by 2002:a05:620a:2546:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e66ef831b1mr477643685a.1.1753953687505;
        Thu, 31 Jul 2025 02:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEalnbAwcLIJLmez0p2ygenNgK4rxww+Q/pnP8/kWW85eDmOZo38Kalj+JOb4MmxyAgyaqYWA==
X-Received: by 2002:a05:620a:2546:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e66ef831b1mr477642985a.1.1753953687115;
        Thu, 31 Jul 2025 02:21:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a14a0sm79370966b.33.2025.07.31.02.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:21:26 -0700 (PDT)
Message-ID: <b34ae465-c227-41eb-8492-4a2e761cb3f3@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 11:21:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] drm/msm: replace minor->dev->dev with dev->dev
To: Colin Ian King <colin.i.king@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731081854.2120404-1-colin.i.king@gmail.com>
 <20250731081854.2120404-3-colin.i.king@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250731081854.2120404-3-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NbNcUOS62wJqSBhehpxWqJQUc2DyK7f3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2NCBTYWx0ZWRfX5pYMUwAztEGg
 pf3MJ3dInDKxPfRgS1INuVdzjE2imKJT91YP57wighJdJsvDJHR9Diiuo1FEKA064FdYz8abN6c
 SziM15t9Kf2Jm6luTYUwrm3hlYFOQZtxLR82HvwDTnbbHDJ1g5nYcp1o4+9sD8s3JEHETCZSaka
 tZyjw8A+SuGsOs/AG1KdN1QF2w6jO16nr6Xn/4wd9RaM/flvxQEFFf7Jj/A88GTH9V8m6/qMBSr
 Juy6fzc3hlWpmqVzFF98O3AAzoB9LXdZrYEpLO+1Xmr2Nym1R2MghJ/+gy8j+7ZnWk9l5UV21vF
 x71Yocmg7S8OQCLyk7hPtRBh8k4FWdWwp73eu4CLofcA2FcNLDPRB5/Jx5afLcg5fQLsLLuQVkn
 DABBqZT9DnLsc88u09ch3qbHbbuXCOLCmhTPjDk5+FLAnKNb6Wi/wzQJ/s8sQOz2b+qTAzCk
X-Proofpoint-GUID: NbNcUOS62wJqSBhehpxWqJQUc2DyK7f3
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688b3598 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=fM4dGe8XGJNefiYG4oUA:9 a=QEXdDO2ut3YA:10 a=LXDWoPVop_EA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=674 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310064

On 7/31/25 10:18 AM, Colin Ian King wrote:
> The pointer dev has been set to minor->dev, so replace minor->dev->dev
> with dev->dev in the DRM_DEV_ERROR messages.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

