Return-Path: <linux-kernel+bounces-799770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8CB43011
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD33B7A4D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C557E1FDE09;
	Thu,  4 Sep 2025 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IpsrypyU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594678F51
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954415; cv=none; b=PaUQBmMnQDp6JR0Tnj8gl/+/UicXadJLrwL084HLxoT6nh+SxuTOndMVF9Q8hBeqJkFH+oSzxQXWUCGPSNOnd3NCz6EexPbzywcNayD+kQV8fTd9ktZg1uPSJmHlmXh8pGxNnituz1xN6yh3SwvxbPRwC+nRjd3UM3p6a60pcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954415; c=relaxed/simple;
	bh=te97+qFSTve2463U2foW3Pt27YcC1EC4UCUVuaOmqQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca7FDFZMRmgFMS6YqarJeCZfGsMq/Pg0DPMgZPu3nirFAL8KMj9QWDMAGZBlYSySTpnk26ZxufBiSqkkVhd8+FxGOy1PyGfvpTYbiXqn9qfuVXCxifvEIL6irqRpi9xXvJ5mmRfEn9ZPl5V1R8DpJQNro4BFJTL1R4j/l/BpgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IpsrypyU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840XLn7019411
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 02:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kz2067FEvooqYvy9DSICdzYN
	TfnwpZYpelzCotnzoz8=; b=IpsrypyUlNRH7nXE944fUy03canvDd/KcmnUss2X
	E+C5hF93+o3GGb2xXk9SVJmOHTJ0WEs6tjrryViKh8F9lYpHwE4OogXxjc2i1qDW
	PWruF+7BUPT6/q9MttQaNEt75woWC7SqCz9OsA+YbNbEXn5In/4Jkn/PTjPhL/k9
	HOYZo35OSna008awsXsdKoDVt5JD2LqwN3+WZZ+XiyZWDgYP1OO0O1CPjKlKBjNa
	uDpRpuZOuai+M5989NdjoNye3LVW5zJxQ3bSydq8Xqh7no0PKM8CgA0IVAC63+sd
	He8SkR0sZEWTStJ1D4x3ESzfZ5AgkOZsD5Ui6z+u2vwnLw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk95r8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:53:33 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7296c012f86so1861536d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954412; x=1757559212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz2067FEvooqYvy9DSICdzYNTfnwpZYpelzCotnzoz8=;
        b=l1N0KgW12ipcAP8UCJDmiwqSrLlAxgfJbD8S5p/zdn9z6+kzrJLDM/4Bh6FV5WW4cg
         sTcEp7dTF9KQcefYDKJb8rNtwZ1MlSwmQ4fDFPii1AVgcl70hMG/Nc3aM+A3w5oarqdr
         xE4FV4aOvrsrtCJICt1wylZtWvY+4l1x5YGy9nqNVhQEwGNDJiMFt8gXVGIpNo6dLlZJ
         wCcLAYJxooC3Y7aqcCeZ0xnaIvAW97mOIiGatE1Ct2kOretK/+HeNGzCXi0T4l216X+V
         lDWPKN5cSr35hlpNQPpstG3yRMnPUoTJroSkSwBKPJ5Lb9heq6tUeCBXOZJU/eA/RtqY
         TrwA==
X-Forwarded-Encrypted: i=1; AJvYcCXRRhQpaGTzdzcAyHDEALj+I+ETP41z/kkF2OiD/G1LyBor+1HqIHYpQb86VNFnj/kjlN01FxDVB9Ighlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbQc0KNa+a6TbDQCYVAUg/hAfNDDoS/k7IqrOos0l8q8+9el2
	qsBLmgAWikz4glYEjID3tdrS4cOV6HMgANQKe7vwpt+3Yp0AKpoBIavc8eRMeTfZVZxC651iUGn
	EU3DVWD8ENID/sPzZQGqiT0wYCMNjU07hs0ZLkmA3UKUeMilfUQ12TCFCYE101onaZoM=
X-Gm-Gg: ASbGncva+HTeoRY4yTzF9nxEe4mVZSDSLrzU6GVOtBFG22r/G2tpwieiTqwH10iKW3G
	itYF1Om5QdiHFncV21SvEonz7VbTilc8Rc+h0oRn1ErunJBCKD9MQEUg7lVBQoch4fKiTbN6BVK
	7JLMkrfNdjizzKC8wZotUOhiXgr1SqB+tKuUyBX51UKCCusgQ/emC2qHmz1og85JNb2kYDMbTI0
	rlkm/xaKq7t+sDxgNd8oz4Nkhvhrb0htS28dkIgvCakQIpHnuEPAqjjhjqIYFgXVQQyZr5ek+T3
	HGgSHUDPF18tdJPY5dJr2a5CUiIGR3+Y1JZ1/i5BKBFWyWttx18NRyxuA3zG2UXH+rnmzZljUJj
	F+/DqTDd9/m/KgEW2i0UBw8Cd0SjfaVTc10SfYhgqXE14HD25Mcs5
X-Received: by 2002:a05:6214:493:b0:70f:a42b:1b57 with SMTP id 6a1803df08f44-70fac966ba0mr176699186d6.66.1756954411828;
        Wed, 03 Sep 2025 19:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErmfuA4/8yRamEwLKE6ZwFL2tSW6JHiK7PGA76/AjLA3gD6SEd/CJbWJkPBSrDcwZ6CONrSw==
X-Received: by 2002:a05:6214:493:b0:70f:a42b:1b57 with SMTP id 6a1803df08f44-70fac966ba0mr176698946d6.66.1756954411361;
        Wed, 03 Sep 2025 19:53:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab90ce8sm888972e87.35.2025.09.03.19.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:53:30 -0700 (PDT)
Date: Thu, 4 Sep 2025 05:53:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: syyang <syyang@lontium.com>
Cc: robh@kernel.org, Laurent.pinchart@ideasonboard.com,
        andrzej.hajda@intel.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, krzk+dt@kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        rfoss@kernel.org, yangsunyun1993@gmail.com
Subject: Re: [PATCH v2 1/2] This patch adds a new device tree binding
 documentation.
Message-ID: <hgesm7qvkwutv46jqhulua2oycgeiwgvpnrqsynxm67zk5qjcc@bemou6qybefi>
References: <175691717884.2393851.6340903042726389490.robh@kernel.org>
 <20250904022524.1748587-1-syyang@lontium.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904022524.1748587-1-syyang@lontium.com>
X-Proofpoint-GUID: pw0Y1lVffWlDWJnuj0wt0vq8Sbd8-2KH
X-Proofpoint-ORIG-GUID: pw0Y1lVffWlDWJnuj0wt0vq8Sbd8-2KH
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b8ff2d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Kz8-B0t5AAAA:8 a=YfVmvpBeDdD2EIU_UzEA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX4WAyAibSqnGQ
 WWjwQACFmIyy0c8B/kcDe0pr6gVgkJIDYfqHgyExfgwQBKE2PFEoajV0L6h67Esyw9IiyzdwQlF
 Z/pQii1G6tBOSPTBHycLzQZ581R6dTxUSaZRNf8iJYnhbpjnCPECI54TPJUpaa1sIVlIVG44dT4
 0j1zm/SmYh+YGIjgHUuzgSNZ0O2mezkbTHJ1U7lf1ZfHI/i0lLHVJcDfQ/NcXK2FFpKXkGP0aL3
 bh4tXI5/HjqQdh22hEdymble7Zeiu5lZX+V13uMCk1Nz+Q3kXa1SDhUsOMmttLX1jx1cZIl+BZ/
 O4HTiWdh3beuqd0/toukY/5/8bK/okyRbPGQJThTnbabMFt4GfEdwsCXA88gwVhSrbqiUwRf0Ol
 1ZMETRrP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On Wed, Sep 03, 2025 at 07:25:24PM -0700, syyang wrote:
> Fix device tree binding validation errors reported by Rob Herring.
> 
> v2:
> - Fixed $id field to match actual filename (lontium,lt9611c.yaml)
> - build pass
> 
> Thanks to Rob Herring for the review and feedback.

Read Documentation/process/submitting-patches.rst

> 
> Signed-off-by: syyang <syyang@lontium.com>
> ---
>  .../display/bridge/lontium,lt9611c.yaml       | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
> 

-- 
With best wishes
Dmitry

