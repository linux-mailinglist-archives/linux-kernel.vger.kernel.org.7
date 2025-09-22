Return-Path: <linux-kernel+bounces-827015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B832EB8FE42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC818A17FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B92C2349;
	Mon, 22 Sep 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7Yzv5JW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3E246763
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535313; cv=none; b=TA6hg6ifW8AWusa9Z/WuSsjv6ChFFQ06B8IVxqKutfi8uLzz1VlKSl8ybcd51EWUlclqnxis2eWtr3Ldcskg5rPzJc/1Agrm9FEtwWGvH1z4ND7PHlyyt+YJ07hSbG46S14i8qH/3/T67DQoE/FQzAKyA7oWiDdMiPjJgetE++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535313; c=relaxed/simple;
	bh=kmtBnFX9cPzIhV8jePoZbgCrPoLPtjXSYEzZso3twiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIWxGKOWNCxLMY3eI/5YK6NJ3ZvgYwwb/ydadgXTR1ZLT+FV54oKAH0bjm/Y/QcNZh5ExueGjx3KK03y5YbQVhD+Y9ewMe/Vzd7FBlSMCVm2cGkkyXbSt8z6fcmSZmt+bHYrVsBnBGFo5CMKvoD1OwwkJ82S1Awj95t6kIhD4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M7Yzv5JW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M91mV3005834
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XiYvYz09Ku6t3DKDC+/4pI6q
	fS4bj3bJjEj9wOzslhA=; b=M7Yzv5JW0kzo5jqhfuTrRAr2NwtyCdfXVTLVHncP
	tYI97i8LcDHQB5HgXes9kVdNM0fTPrfKEikVW5TvqhegrojVEAyu1/H2qs8MNc1Q
	VoGZZ2bvd/2C2225s7s7U2IXWuu/zxXLD83t1PfAVQ3Ex8YzYzw0wNK9XuifolUL
	qqRXE5YC0eTFuK2tGjUDYH6nA6ORf7KuA9VYoRVFUXn0VWb7pzvJvozCpd3h5gtV
	/REIvnhJ0oIMAcL7e/3p4yZFYBjUDllStnUmYL2t9DGEVn5PNJv3j6oZfV4pORIB
	3OJcgmPs9kjwgyNQzEhh7tJjyNTuVaYGLy7e3Tuz6HfQTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0vaqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:01:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-84e6256b06dso20750185a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535309; x=1759140109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiYvYz09Ku6t3DKDC+/4pI6qfS4bj3bJjEj9wOzslhA=;
        b=dzllVxw4AtFco5rzLReraZs8G9sxXknlVAo2XE71PnA3UR9w4mvjxj70L4KjcYQyUa
         eBiXeqYvIleWEuwnASJzAhq739TcStDhJEDPyKu3Ha/DOPYL6tFDkcRQ/2lBuIuAV6gE
         0xviXDnav++mCD/oC7ntJnmyeCk/nF1s9P1AA59P9llc6LMSXH3W7lPHzvKeAZGQ7e6R
         K2rUw1HjRmsTtALINrq4hzk+q81L80EcZmnty3qOj/yaO/f92M9YEkes+VxKKOuJ3eTQ
         dx8OAVi3twZo+1k41oUG5TIObrdhcJv3m3B3p0BJ1CvUzLFgtScxnmrWVmTFR34ViN9B
         ymRw==
X-Forwarded-Encrypted: i=1; AJvYcCVnriyFknTH1OyGhP6Jeb7tnWrcbdOfGdplSP1uBAJrLD2/+KXxmBHYyv4sGhUKKKz+dL0egPQkgt6CiGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeoLSGSqBwW4S+BjN2pGT86pb8YdaiOJc8NqW8f4W9102Aanv
	O+tr7CW94C5ua8QI5AmIMIwdh9yBCBaQ5gUKwm5hr/8t/akynostT8wbOjTGZdcac3fFPZI8juP
	mpjdqUoGABnNxY5kO/MYgW7tMzVvwpOjrEVqTLGApvN89Jbv1JiTUe04pgWVFFAc+gi8=
X-Gm-Gg: ASbGncvU6XYoSEGa8gUdAX03nRpyATPdyc8J346hCv4cPw7ur7n5TVnMD4YplQUiQ9R
	tcyxVDDLOC1ioxk5IQ6a5lKSKGzaG3YzaW2YTShzkkcKr/CkwKmzBdQjShyDKWGAa57mRqtm7sb
	ewqhzfMBFyY08If8SDdxfo8E1TGeSn761utsQI+32+rVfcDod8PSvLUJNFyinztYimoZeMNxkhY
	VGeT/kDTjVoSKbjC3cttfK+TNIcIuG2nwddNBaCEqqpzIFNIDHaYy8f7n5XxWhz3htxfpWLyhDk
	RHvDh3lGRhRAeWbt5fyVg2ouFWUddV3L6xtS6p4SLU87KIuGguAmH+1/ImjkSplgf0yIgLjYx1f
	6h982YO2oengHxnXnQtOJEK1ZY5x/5wwa9UM+cJmRScZDq4hzTEXg
X-Received: by 2002:a05:6214:2129:b0:77e:dd3e:a0c9 with SMTP id 6a1803df08f44-79911fe849emr152956646d6.14.1758535309161;
        Mon, 22 Sep 2025 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3dwdmnAT8Ej8kna6zU+1gThqQvOHecwhWI8VJSZtuu94b0HchIuEq9o+Du143hQaVFqG97w==
X-Received: by 2002:a05:6214:2129:b0:77e:dd3e:a0c9 with SMTP id 6a1803df08f44-79911fe849emr152956006d6.14.1758535308504;
        Mon, 22 Sep 2025 03:01:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a1e077d0sm29027191fa.9.2025.09.22.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:01:47 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:01:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 4/7] drm/rockchip: cdn-dp: Support handle lane info
 without extcon
Message-ID: <gcgiszrrpqkoi3mhajn4i72awbffqv6mayahmnyswoitxxmrgd@nr2z4cpurbwq>
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-5-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922012039.323-5-kernel@airkyi.com>
X-Proofpoint-GUID: GqbOU3yRda9Bzzpkyfv0mhWXIKqc03w6
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d11e8e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=k09sBhBf5rVv_DnywOQA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX/4svO3aomFI9
 8tEBsoR/lmDC8HYmL9/o7Okxe1oop+y6VsmxwTny6GvIrx64wELr1WhocZUv5M0I23r9pvUrirJ
 oU4zbzbvma/6VOPCpwT7pA89w55SU0kaS8r2TYRHrHaETBqyul9XdyDS40o9eGEYvTSuaKI9T1m
 sR4Dn27jE/rw3CRBwvflXbNcw4iYDmeRlbpjxvIPUxfjIxg9QC7/2+QEzwQngDb+oHsTAU+X7CK
 y0/9GGe5DKjD01AyWlg0Q3BuS2gwZIZWpx/H1p+rSuJ/SoS5REObst1D6SXATxmcGLg+6sDDbyf
 ejY8NHmbdHj0C2yuEb3zeqXfDJDm0yD05K5L1iNS2LisqfRS3EoGjY8fYswFhShuRbj4ZOmD+3R
 kLxK9N8y
X-Proofpoint-ORIG-GUID: GqbOU3yRda9Bzzpkyfv0mhWXIKqc03w6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On Mon, Sep 22, 2025 at 09:20:36AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> This patch add support for get PHY lane info without help of extcon.
> 
> There is no extcon needed if the Type-C controller is present. In this
> case, the lane info can be get from PHY instead of extcon.
> 
> The extcon device should still be supported if Type-C controller is
> not present.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v4:
> - Remove cdn_dp_hpd_notify().
> 
> (no changes since v3)
> 
> Changes in v2:
> - Ignore duplicate HPD events.
> 
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> @@ -1120,14 +1129,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
>  		    PTR_ERR(phy) == -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
>  
> -		if (IS_ERR(extcon) || IS_ERR(phy))
> +		if (IS_ERR(phy) || PTR_ERR(extcon) != -ENODEV)
>  			continue;

This will break the case when the extcon is present. It should be
(IS_ERR(extcon) && PTR_ERR(extcon) != -ENODEV)

>  
>  		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  		if (!port)
>  			return -ENOMEM;
>  
> -		port->extcon = extcon;
> +		port->extcon = IS_ERR(extcon) ? NULL : extcon;
>  		port->phy = phy;
>  		port->dp = dp;
>  		port->id = i;
> -- 
> 2.49.0
> 

-- 
With best wishes
Dmitry

