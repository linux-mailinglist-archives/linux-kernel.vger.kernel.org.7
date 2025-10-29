Return-Path: <linux-kernel+bounces-874936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC963C178C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC39D4E7F58
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029DD2C1583;
	Wed, 29 Oct 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b60cyLLn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bj8s3Iot"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674B2C0F9A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697850; cv=none; b=tNspEbh9sNrnreT2AVsYWyf8zSFFnQBUpkuChdUz4AsuvFRaEHywttf/yxn5oCuJCcZTZmIiZ+PSJ+KjYh3fUjcaLDhncHZuGj3/opkkY7Tz4PGQhWS1peQRf1C31gR9zPCoUbYIBwbAINgQvtylkoCftf5LL1eWZq6bHTI1vIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697850; c=relaxed/simple;
	bh=HEea6GKuDLgBltpRPJ3awQJ7bFld00ZKLZWALJGqglg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hchzArKgRJdBcmYv54XCcpjrosX2l8xVcawghLFRXnxYncb1ZJooRh/7kYP+reDghAwiGdMFtYmZKMipqYblkxEI/F+XawmFKkXk0oIBaqNRuvqOd8T9N7cSvQ+v+Z2iaavbUXtlV9bjvpJqzTDuSp6RIbkEdXD0vt0h3pKINRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b60cyLLn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bj8s3Iot; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJls1W2553759
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VyEOF+aXLbKYv3f4NZ9fETHTP8oPsdMhgn4tmd3+uZs=; b=b60cyLLnGPIYVqY1
	y1eCbNRllbHQeqtZHhtrK38EbhJym4H3A2ltPD2NfqkktHucHZNlxli8Yo6YJZiG
	7z8vGY8DT7uwZdv9ejfy/B+ng13/Fw4XwVHq3RLhoZL1AKaipqzHWICk5ZoWLFt9
	17Ylf+gC3xnu5DPPTCEBj5XgNtORiUaiq5vDTzUWUlniATBjR7nwZolJ1Xu0oSGb
	yOqCnlxjzZL7hdge4liWmflOYiCtAypGzspZyTGYgw62oBQJ3nFjq1Eq3NgHWHRT
	pquXlVLSLDxNrv2yaxBIJ7VmiKCqDvAoDrC+r4wbX+3iTPf6mHi/Bsoj9FfD68zT
	UPBkXQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2gmqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c1cc5a75dso267485646d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761697847; x=1762302647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyEOF+aXLbKYv3f4NZ9fETHTP8oPsdMhgn4tmd3+uZs=;
        b=Bj8s3IotmFSlzlIhxgvH4z8c1cLLzr1UxGnWUwgQNYDaiqlJwN9jhuX2nRkTIl+n/J
         TbC1a+zUwpr4tHkMEtlHbqrmYl04EwV8gIaVQazZD30+FZFY6yGKoHlx7h+L4RZspxK5
         VH1K+pMzS9Zp2+4LP6NVuUEzSAjlGkLcuJfiSZdDGakhT93DbugUKfeUGC9LgWEaywFC
         9MroLWryPoW2zccula/+xmJPBDu81hdMUt6JlJw4rzkn1L2dZF8D31/7hio+5WY1sMOA
         ZnvcE3lgUwes302ooqHD893n+yiMwjhldu1GUDJH9/OzZzOUz05aMQYltTNusyV+kdcy
         /Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761697847; x=1762302647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyEOF+aXLbKYv3f4NZ9fETHTP8oPsdMhgn4tmd3+uZs=;
        b=odZVHL8k2t86CTPPR+A6rU9B1gKB8fqAPW33ebsjoqtNrx1XaRu/3dCCpxJNCYoREh
         vfCqXei9FqRNB+dSGjjO+meigsYTsd/QSbf2eiup8gx82AoBtYK22SkBpFjLi8KuqGHU
         CDn8B+mpdIbKsJuGk4dM4wsOlSXv/nF9dhLNxs38su/CJ4S9aalWcFAB2jyaxmpeHIDb
         2qanwhKGAORwkonlrjMJK8hj3AoAKSAFd97faJT+/VUtfHLKafBPwBIZmFbacHIRHUt7
         jrMvy1lJXCKAI+geBsLfj8FNYLymxpi2VJivCmKns/s8hbDb9vQ8JBIddZQ9OPWLeamF
         EBFw==
X-Forwarded-Encrypted: i=1; AJvYcCXiGiobQgAN8YBRoJy/nrEAfGS4+gY0Ud1pjhsnASYJ0IC0mUedDK9ZlsmTYJhTllIO5QwqUBUpQoZH2mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKCy0an10PuSgzz96BXUGevlnRPCUoz+qzEBdNm0zrexMD7EWq
	uCyQZst7AXi1Y3F4jnTMYSLCT4ZjjXROS5awpjVWIa6tV0gK/C1kXqMj5GaSpPe4oFqytMI+CmA
	cGRE5OU+m31z78uY7hH8ELTDZKN+GFyYDQPAUipgfPYLytl8K3eh1EmSqRBFfy0+q94A=
X-Gm-Gg: ASbGncuJ5bvs89q2SZq6G11pOa99+81VyY/Y0QANqu93XLot8G8WToepGQa6yNd37ut
	P0GPCmBI2nPYjj94YK2eXK6XT1DNUy2fHjEvFgzHnhJGV8PMH8BFdJv9KRyWJ4IWV6WpcZVyqD/
	Q6ENOyUIB6AlclmNegv1k02MYnbIkOzwp/VExD1e6GGgJ/O12tlJvsgVH38jEcJyWvAaTrKo7Bx
	nkGJX7BhbDqrfGYg0bUoIMXLM7dvbmMNv6AoiEO0altPcGOGlzKUT5fJ64/hZv6GQJs5WNULZnO
	qRMc0jzUGv6Y6F74DXBYgteIVstifMjy2Bhh8iMNmQ2F2MPpZ/39ry4/ULqtT6sX5hspr/RbcOp
	9CoaFrUFqTB33djj0TwxjAryzvdOZyuLsXRhcUFjjFlSvpmVIixgEu22/K5oPA7/q6wBU0TD6r/
	oW/b6i5YMQcqn1
X-Received: by 2002:a05:6214:acc:b0:87c:1e27:f7b4 with SMTP id 6a1803df08f44-88009c3fb27mr16408786d6.67.1761697846829;
        Tue, 28 Oct 2025 17:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsBFnqbz/J7aBH99rrrrpjG36zD/8B0hEGORviQ9ZerRyWHsasvUR2RCXFVhnR2eDLiEUJxw==
X-Received: by 2002:a05:6214:acc:b0:87c:1e27:f7b4 with SMTP id 6a1803df08f44-88009c3fb27mr16408416d6.67.1761697846330;
        Tue, 28 Oct 2025 17:30:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee092042sm32141621fa.6.2025.10.28.17.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 17:30:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d merge
Date: Wed, 29 Oct 2025 02:30:41 +0200
Message-ID: <176169780818.3761968.15179413078088034823.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>
References: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b7Y4O6Pt64MhgjkWabgKWxB6ey3jaqvz
X-Proofpoint-ORIG-GUID: b7Y4O6Pt64MhgjkWabgKWxB6ey3jaqvz
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=69016037 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=1bp3yVi2_WrJ7BMISZwA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAwMSBTYWx0ZWRfX1LzLszgv133t
 FTzrc1kxrqHKsjBUzAck2NHTVfrIgw2YD9iH1R5ARPoY2y3RR/XwBK5IHAGSur5AEhojMQ4Z0ON
 O79luVC91fRyQjAQIgOXLgI4GgkErOlVXtiDk4tgZVviqEGCMuzrsYT8cXe05j/1HJUFBL1Lypf
 E8aJ5NAZMEin28LWsJl3Ha4p8yKjC29r5PH8uB3XaNRpstvBtK2eblnO/h1GnJgy+GwJxfKZooV
 KXFitb5Sz6VJ7EgpgYubLJwXAmAxU1/a37H7tQi1HIGgFdgSU4e5g5Q5T5ygqfqAdehLYoymt3h
 ybLtUHy8yjtjEw6W65yBJ8+eaN5TEtRErCj+MhVekqnh4LPfMjfM3JdY1emre2IdHzA/oWx87Vp
 RUbK314i+HfWZg7D6GmMclBR3G090A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290001


On Tue, 23 Sep 2025 16:03:50 -0700, Jessica Zhang wrote:
> Since 3D merge allows for larger modes to be supported across 2 layer
> mixers, filter modes based on adjusted mode clock / 2 when 3d merge is
> supported.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Fix adjusted mode clock check for 3d merge
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f5d079564c44

Best regards,
-- 
With best wishes
Dmitry


