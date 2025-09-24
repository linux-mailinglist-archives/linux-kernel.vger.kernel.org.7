Return-Path: <linux-kernel+bounces-830027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4087FB9880A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5BE2E3835
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC82226FA4B;
	Wed, 24 Sep 2025 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DstiAYUX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8225783F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698572; cv=none; b=luskY6PJvTyoY8R6tPwFypQvELIAsA3lw4s/n1gfua0Aptg3JX4t8cHa1tS7M4u/A3hvk4OJASFbIy1Rg/qS7rFHEG9Gr/jDPQJ9jaukd8/cHLSYblUAsmurBJwaKhop7MQAUUHQMVVkjKA3a3zplUEbvH4aBNWbeOXuq7xyS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698572; c=relaxed/simple;
	bh=s5wukc8WZZ54O4OO+xy9C2hqGJfv6hhog5dDVRtqM9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXMyqfo4klwjcHHLoQ0PJPytrKVXIt//gg16x49iuLb2DENnOJZ/V6iyRjd44E7gmVSgmjyhfjaPb39klA5OAj9UykqFEFkxL0DzYjIDPOuznx5d6O+WdegcSpOYYKZFFkahf39SWSgyeXbDMf4kz0YFZY7USFQ0N5DZZVGYKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DstiAYUX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4ilJb018678
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jkzla9yPfs+xt2uBZdioDrNai0dbYaoeRm+eR3334YM=; b=DstiAYUX4LGXQ9ym
	al+FNc7GS9eTBZ17eGB1jyIxxvi5FJGHWhrawca9qhzTlOYtAxJTV/9lx+JLfXnM
	SYfPaTlEvQxrYkv7XD3B5UY5eV1+/4yqfd7X/eJGvovKdIe/k6GTmt9CUEQyHdnE
	G+WuoC8guI/xwSW0koZbT+a2y88V+gQ2MWWvOhsGIdC8WIKgZhapQS1kG0a8ikXx
	LIXNux8Q+rILaWtHf8IHTMifvz6sGj96giM0ZQH9Jc7YmcF8u7ewtqfTlg7XMBrf
	srE7CQxjeIS4YqyC+lHIT7cL3INT/rxYdGrGh6tjW9DiKkitPogDymrK/slma2nN
	fssRsA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk7bnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:22:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso6140195a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698568; x=1759303368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jkzla9yPfs+xt2uBZdioDrNai0dbYaoeRm+eR3334YM=;
        b=OBMT24ISqwLspxVwn9d3UP5Sm+bInBw9a+ZvfmoL91rb+SdhGA2K4juZkteOriy/Xy
         keqlS580gtR5OxujSGQjViJ1utiA7NM7jXqJN/65vqTVZQ+K+PhZB4aALCmvlyREN7MK
         OgxH1ItV3DH7LWtYlk+WljDWuU2tEaiW8ZOjhJQRXxDttUDPSxYIjQikkaPoplYbfJCw
         jjKl+qTheSE0JCaH6QdvpS7QOFsdBpAvlsn55OwVb6ug6/8rzKJmkBKmh3vDdJTZfCa5
         jOH7RLgY9jP68Ygex2ZIydOa64VdsVlqAdX3wsPS0OgzLl8cEsQW14B78NQi+RyS5MeX
         aJfg==
X-Forwarded-Encrypted: i=1; AJvYcCVET3ZWMwYi2JW7gAH8GLMZts47IooWjIhWIU2xlvsavYZDn0JK4YMq/jM7mspaeLEng8FKAR50Hrvk1lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMAAkzT1LzXhdnacf7PZW198FeY6rrzewbNM13vXui3Vk0Uy2
	cqKOLBw9KlgKpVJR4ZVr+lvgpLUh9VgLOhqhLW3uKNYl9PNbB1hi7SOKttv4V9S1DDIiom6VyL6
	oCT18E4bUWA8gOD5gyGIoUVhSu7x0podh5aw2qS+1a3CvKOX4b7gsEdH0693XWXYL64r0+8ce6N
	s=
X-Gm-Gg: ASbGnctt7DBUPVrfvv1nou2FujkOqLyBg6fdhlSz6jMdcYiAedMbuWpWPY30U4tw/Wi
	mWnJt8P8gXwFQOhUh/OnkX2uOUqHeQUehnWOXfT8l/PfpLG5WRKkYIfowh8EeJonQ5iPPeUO05R
	G8Rs0v6gwbkG6TcQINBqkb+Sm/KFuS/pWiXeBNWJQPZUdR33TqgB84UgOZqeMEFsT4Fjd4KQ/py
	kV6ZZx9u/m40CtSBWnNae99JnF29Pu8bTE/3mlk5RSvNML6J+kI+8BfhitGtGcF/QD0qPC2vwHq
	0gBygKglFhCs1ffiGb2oQrzR9hbSvbU+ST/Fzc/poGczHjTGlWYzHoXuJr/u+v/B24sg0uJLPT0
	=
X-Received: by 2002:a17:90b:5103:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-332a92d32cdmr5768284a91.4.1758698567975;
        Wed, 24 Sep 2025 00:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH0+pP82pDEIE+FvE4uDjG/rW9TenUB12/4rmERSL5RIhaLFJBaQpN6XvDtOvUl0ui8dZnFA==
X-Received: by 2002:a17:90b:5103:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-332a92d32cdmr5768264a91.4.1758698567496;
        Wed, 24 Sep 2025 00:22:47 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd8fa0asm1377128a91.3.2025.09.24.00.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:22:47 -0700 (PDT)
Message-ID: <ce1e5c0a-46e9-432b-b2ac-44abba85c7f0@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 12:52:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: lemans-evk: Add firmware-name to
 QUPv3 nodes
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20250924035409.3976652-1-viken.dadhaniya@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20250924035409.3976652-1-viken.dadhaniya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t_FrSptt9ST8FdFGT9LRtB85Nh9m4Rmt
X-Proofpoint-ORIG-GUID: t_FrSptt9ST8FdFGT9LRtB85Nh9m4Rmt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX3MN+LNxLdS8T
 YCLhwZKcmR/IJNkULQKPUfRq9FvTmHuF+Q4BdXeMU+0ioH6ptvurI6SvgthAfU6NKsBSt0UR5yt
 zRu7Ptwe3idh7I+GCBjGsIbaZZSPLbZbe3xwL7CZOO4KrLlhFgkskG5BW3KNXurg2XAdn1Iayte
 zdAw8rJqmGdCnCeTvXPEAEv+7VAe1Ksq3LAAHpRd6A7stckH8JgenKxnfcRSf14HOxzQAereV7s
 YboaJYQbMuWvplKNEYgd9SnO73unCrIwl1hKEdLn20H6oJJYPXq3MSb0SZ35PY+Da1o2dtsqtwE
 P+LPz3rpqHp3HGIVTxDwiFbcJ+W3LH1ojvv9clwRNg4DKu+6x5nL4kP5/W8/0y5kAyClZFR1+r3
 7Gw2M311
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d39c49 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B4HikTB3W-0rk1GVoTwA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089



On 9/24/2025 9:24 AM, Viken Dadhaniya wrote:
> Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
> of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
> ensures secure SE assignment and access control, it limits flexibility for
> developers who need to enable various protocols on different SEs.
> 
> Add the firmware-name property to QUPv3 nodes in the device tree to enable
> firmware loading from the Linux environment. Handle SE assignments and
> access control permissions directly within Linux, removing the dependency
> on TrustZone.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/lemans-evk.dts | 3 +++
>   1 file changed, 3 insertions(+)

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>


