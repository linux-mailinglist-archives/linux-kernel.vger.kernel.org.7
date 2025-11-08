Return-Path: <linux-kernel+bounces-891688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D76C43411
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 693F64E6217
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922425291B;
	Sat,  8 Nov 2025 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pIEl9Zrd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DokuCfRp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBA25486D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631173; cv=none; b=B+5vewr5yQWCWWzet5jfj/fh9Md6NbTexHXLKgRBJ/ljxiSuB7fujfURWBXSo1MX9mboMxtY/blDsmSsYk4egcHMupWPSajufKmnIvZk2Nqs8BhPpuHMWQQjb1LuQ1YYpoQLkHmAIBIUM/C1CTlAHoEo3+mbKpUJ+3p3/NmxiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631173; c=relaxed/simple;
	bh=+Hoil888rGf7WfZpji4y4VNmOyUwaxNOhwYYWlexOJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drry+tgmWJOjdbFwMwy1LWmIOKMmE4kMd4cnI1llUzihC0ub2kEvyiC3v2CNOFr0gpEVloWdSJPonb02bU7Q3RCeL3GKbSC3MdB6f+GMxITiAIkYE/q8gZXfZuQMOYvWQl+YjkEv23S9ApKUPtO74wJwRa5iBTRl78PVSwRsKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pIEl9Zrd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DokuCfRp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8JBwI22417102
	for <linux-kernel@vger.kernel.org>; Sat, 8 Nov 2025 19:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N5kLP8hDSeanKiERqglKodoR
	Cnx8rVn5yjp6JtXx5aQ=; b=pIEl9Zrd6spWFEWF0oEEF6TNGZQW0DzqEgEONpBZ
	0AhHTZBrEOrCanWbOIRRceZHDYSDpxUzTlMpU1tQ1nExMM83HVfkxCegwwjS8dh1
	1ArQelJGO6WJbYqvWVTWBd/AO4yniwG9LIQCdUet8a8luT8wwdq+6dTxRUtmXKRl
	3iWhjTZ/d0Zo+jbP8F61yRSJ2kEgP8TwNrva3LEKPfETvH7vYBt3HkVsTsmGil16
	HHKWeviIjiod0t5o54aWRjHJC8FiZnZ0FFm2LGMVPQY7SS45Pxgu1Q7V5/azEIX6
	4pZZNRnF/CkyG+Vyu8hV03U+YCo0EfzYMKhngr5xSB0Hkw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9y1h12x1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 19:46:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b22d590227so197912885a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762631170; x=1763235970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5kLP8hDSeanKiERqglKodoRCnx8rVn5yjp6JtXx5aQ=;
        b=DokuCfRplZI83PeUymA+yDI5Q7ALquN8kEtXcdFHD+uDEE46kD3Kkb8m4PYj0hDZLy
         K+4XqmQ3CxQpl7r4trF9yAfxTHQIumnvS/97OLpW3KM6PepfxkMyqNo3Ez/Tg3hy8DsK
         8cqp8mKm2dlzxzOKfl+pMsBDvBgsCwqm14nvTeKHHwGeFcU+UoaXOwdhxFHiO0OWVWG1
         J2J3bI14sBjspLVkCKGCU9nRNoSpN23ykIRl3ZYjRh7xyRQKuWzG8ArtWt6+pxZ1WBG3
         wALIfZwpMHeW8B3z1YSkg+sOWarlUBQkJei7nU+3D1jPWq7hepkSKroyDtqzJkoT/EQv
         DKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762631170; x=1763235970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5kLP8hDSeanKiERqglKodoRCnx8rVn5yjp6JtXx5aQ=;
        b=D0E6xc4DgObUVBlkpNw4aQN1n8Dob+ZSULzZu0Ka6btSVu4l37ZQqCos0WvZiUJg2i
         KwgEEpGFrS9YTTCdaLw42EtBXHLgHwuRigMxJlJKD6+5WKiNRu5BexV9auelL92eCN31
         wV3LNJeUSuDmL3hJe+4uqY+Bw9B1qaSry4bUMs6w896QjdmtNfWfQMkYnvRhN6tjcgBS
         jARFrV20nowHiRDvZLgBO6PrJEM8YbV3qgIub8q9sqr3qawdBcS6Feznuo9RymoeH6cx
         5N0Z+Q0dgTQlXu1Cq3a4aWUprUaxc+KSlEvCWfhC7neeNPXaQV0PhVtxrFoElmBhz7Di
         E4XA==
X-Forwarded-Encrypted: i=1; AJvYcCVKYH+JMntOd83nqXPfl2RuDBeQ7Cdj7k/l22vHBl0CJ0KYrfjNboMxn/aNFBH13p+H57EwluuznXaJNxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwujF8dNTRAMoc3VlMFVk2yfFdGgBbWtlpPgdi94+66k9Ucr8z
	b38hhWxafGz5pIWWeDVkH+QKCTF+W7KfgnIOPHYsPiREjI98UUlpYgBJxfgvrM3VkxhsF2uRZtK
	/Ae4tl4k/m0Q70a3k3sF5subVyDZbQyQBGsS8pD4MDdQ9Ew5gKcuyDytmcN0i0y4I5Uk=
X-Gm-Gg: ASbGncvV8hdg9FAXg0VJM3UumtVF6LU88sDhMQ50ze1On0fe6GF+F/6PXMOgM6bgl5E
	ZXESamRPmOTL72ien5XsZGNTgZd90yCzIG5WzZfCQ/jtE6L7sboqlwdrpa5D9PYGuZiqiOvGs/o
	hWsStBsoRkss9reD4iZGfVb6NBnKVkmxn1R33wUzWPqZuulyXNXaMv4OqoxQWmjug48msQZmZgl
	Do+2iTdr66huOHKjgCpcYwqMUBRS7sBjseEYcuhM+rtRe/oG26ikJbhE1Z45qzFGZyl6me5RSsg
	3cXX1FcitU/CiFqdK5EirSXdoK59hkn3E24HK/Y1aYvl4elSk7e9jU6ZU9jZRsKUR6sYWZ3U9XA
	xmT3trTenU81VMxKvIFWEZ3/cPxPHwwALI7ITzukZv6/ljWs+SyXSfcfmCuzNtZuoL6Jfd1yZZI
	8Vpw7QuVzcdfZq
X-Received: by 2002:a05:622a:286:b0:4c0:5e82:86d3 with SMTP id d75a77b69052e-4eda4e6ec21mr42626921cf.1.1762631170011;
        Sat, 08 Nov 2025 11:46:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxWcQNlieXpFs0/FgNMHfMIB0ifmLg8ipoQ00ZlH0+sZ5XazDWrKkbEsLsyh7hlUoYpPIS3g==
X-Received: by 2002:a05:622a:286:b0:4c0:5e82:86d3 with SMTP id d75a77b69052e-4eda4e6ec21mr42626511cf.1.1762631169567;
        Sat, 08 Nov 2025 11:46:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a840e20sm2422937e87.60.2025.11.08.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:46:08 -0800 (PST)
Date: Sat, 8 Nov 2025 21:46:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v14 5/5] arm64: dts: qcom: qcs8300-ride: enable pcie1
 interface
Message-ID: <3ero2b5vzlyncubdbiknkimytvuelashqn62x5bg2x2kx66ml4@hmmzxt5eiip6>
References: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>
 <20251024095609.48096-6-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024095609.48096-6-ziyue.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: TT-n9PnSL1KVvy2M0frjwXgt-JIxwe6V
X-Proofpoint-GUID: TT-n9PnSL1KVvy2M0frjwXgt-JIxwe6V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE2MSBTYWx0ZWRfX3n3a8UM5E3vq
 TZ1vV4lDJZ/3I477sqKtjL/iKJvY4gL0TtogCr9dJmqatX/a7Z7B9ZDAIO8Q2/Id+o25bF9q5W0
 JK21eLRZp6zHAvSU8MhVgfcOfrkLEiYQBNeEvsBVDR1KnYF4L7WZ0JzfdhRCL0cXPF6akhfdhwy
 N4QD/LUzbUel+HT0/WIeT8jb6F62MYu1yUUER1Zp8VZWvTa4Zo+ZNlUORYG6C5fUdCB8EvJx9Qa
 SwJouTAMXxn6ECZyvEVefQFtKpBD46uKDvpIBXKtngYAMk1YyFlYrkw2e/w1cjgBYbgBJ7oCkhB
 GnFDtLqk9Q8jzV+FvBWIgTYYUuYOzbPxIkbazPXfe7JY53WnWAot0+iixEcKgZUYTBQ/2EnQ/Wl
 rZyo0PXpwbUUxN43/6Twg3X449HMGw==
X-Authority-Analysis: v=2.4 cv=Xuj3+FF9 c=1 sm=1 tr=0 ts=690f9e03 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wKY8r5YjdiK6585sAzsA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511080161

On Fri, Oct 24, 2025 at 05:56:09PM +0800, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe1, board related gpios,
> PMIC regulators, etc for qcs8300-ride platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 42 +++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> +
> +   pcie1_default_state: pcie1-default-state {

Incorrect indentation. Otherwise, looks good to me.

With this fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

