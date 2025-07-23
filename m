Return-Path: <linux-kernel+bounces-742321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3513AB0EFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592021798CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4927EC78;
	Wed, 23 Jul 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="juEiVFsh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9D282F5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266781; cv=none; b=ZzfyIH4PSbm9H5+bkOKz7nWujJzHdCKwxf9yMEoJqZuGj8wM1KHw8KKCs4ZipQ3KkQeGHtkxEl/YLLEJDgE1w7oNycs9hj52IkwV5cLxfMM+gWXuMP9E8lOb03EFH/pfL8N7d1qvsUH9G6uqWspFJDRf5FbU43h6G0cXptXvpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266781; c=relaxed/simple;
	bh=KEVvEIciVzyfDH3nnB3ARh5WWrs5PJ2Px3PB8wL8BgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRGfGaKyVmzrvnPUhZ+hqYzXVSpPgRQKzb4BOzY/sN2V3LBwHM91lbRi6nhwMvJzt+oQ++K0Tuk/FADjgDFqenRm1kPoXtWJRlAvZadfZFOkt84ccRlo4Ym8SU/hiJtM42HBuH0YuZ1r2flC1cIhMiJkLl0MXmZcQl4Ug5j7G3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=juEiVFsh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N90FFB024516
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yoxWGvrI/DM0finhf+96x7egX4yJi8CUjAClFYKbmTk=; b=juEiVFshXtr5alAh
	zEPAuqMhwz6Gx+8/Jp6UxcR7ECKkzgj0/RkRb+2vu9dVetupFS5goFH6k79/7h4K
	rOHHbOVQOU0g4w6NNzqzvOPB8hUqOXrAOo1vjpBGi+nr5//v85r687se7u59aCWn
	E5AP7tc98QrK/9Uem5hA0WIbbnsQergWSsAamRdQ8Y6rP1LaJ44oB00HQIgtgRcK
	JpWR3dIfBsrIMgNwMJmjJj1jjp54fQ3ZVjcN3A6Sh56hJp8aUwIek3apFEW4jeh3
	Tv9DE0YOyGeMFerDSUVeWqUEpFT9PwdGgxDzRO7hmWjK3K8gMp7NqIowiWDlwe0J
	AGUB5g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ubbnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:32:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7de3c682919so95344285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266761; x=1753871561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoxWGvrI/DM0finhf+96x7egX4yJi8CUjAClFYKbmTk=;
        b=fFjmjPLK7eRJFpq/3gxvCB9dkiRX8Exia/mZWsIsfaf3RPU7bYiFfD6lm2OaXyqG2o
         7vvCPykGPO2u58hiHi38ktrM+uCeWMVc4nCtZTXHxX3nDi4l3SwW/pS5WYFAiEspaMWA
         ekoe2paiBN/Jb8gxIYp0HJbT+v71319EOGeF04b2CUvoeTUuree6XcZjaQWJzxR7Bnmu
         hFkUm3VEjvbEEiq5IcSTI3BtohVn3OEOt4h+zg/+t+gMGlmqNRqqPGQ7dq/je7MR+H8c
         nqVcomae0MkVFHlzbDmMWstEUH8swCU6CAxYH40t9LWQ0vnO+yHnsmp1KxsW6aU6zW+Q
         ljbw==
X-Forwarded-Encrypted: i=1; AJvYcCVkRBlGnibpXr1lfxmtZulgZrEi7+QdKFqr426P5/FpOd2lhJkqdHKf6pi+hV86+Q0lGZustgNTlh1P3yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWeCmHDjjZRkYXw2pCR2m3zW6lrxSjwvtMZIxA5aVUBrK3dZe
	9H0LMEvuZFmsEEVGE6RbAhxY4xwaXVQa83diWOXqYBruxHVmpPvOjiHLap1ixMoQoe/cbeQ2Opq
	grslwQF1ywaNOFLrH57wGho285iYK0j6DXrxxvfOEPiBnRweuyK9dm38ssmlxjkoplDQ=
X-Gm-Gg: ASbGncvsPiCqqV4mfI9c3PQhqGy1zZ22Irp5KWfI4IExN8xOqIeBoJBglFJLpPAwGEr
	33TbX9A14U/fKreFqMORiMLiE1Eo+pdn65GW6P3RSXxerb2uA8xJ5biEKSuhaer+N5xsaDSQv+9
	Lzka5jWaQg5UrsukPkE1ovLfCP2wxoAxaW9Aavmyb5YPg2XcQF6ozWmZFx1nPQYkW/fzTl5/D/U
	WMT2ObNdPlFKJn9ad1dsSpLdiNQRLljkJQe2VrZwpIF1zGA0gNJRDpJWQ8F3fhJDS8eTp6/2ZAV
	I1YGidusQZ8OzwCFGLF8b7FF4cxs+KMtU0GyTBdV9dJXouvQBj5325lxdjl0NrraHl9P/1624em
	HRTj1Ze8ReCXT7iBdZQ==
X-Received: by 2002:a05:620a:4107:b0:7e3:715f:8757 with SMTP id af79cd13be357-7e62a0c1597mr117640785a.5.1753266761457;
        Wed, 23 Jul 2025 03:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMGR1PY3KATLtDKkVwck4PFmLv2ujqFi2Asp89UsFHT9277js6Trob/xsUiROpYbvGow0BQA==
X-Received: by 2002:a05:620a:4107:b0:7e3:715f:8757 with SMTP id af79cd13be357-7e62a0c1597mr117639285a.5.1753266760933;
        Wed, 23 Jul 2025 03:32:40 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af3758ec76asm57350966b.121.2025.07.23.03.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:32:40 -0700 (PDT)
Message-ID: <d50f9a01-ba8f-44ec-9206-fcef641333aa@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:32:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] drm/msm/a6xx: Make crashstate capture IFPC safe
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-15-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-15-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6880ba5b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=rrcyIi5yJUK-87isN-sA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4OSBTYWx0ZWRfX4khHbSKj8zku
 +VgXXiEICgoxTPHet34z+SuOirebjeiezPm/ZZOV6t1V1ibT/xlYxy8OJXY6X6V9wuoRDouZ+Qz
 vDMApp1nkQ27V1NMaIRqRqyvl15OdYLMuzqwzeGrD+Db+4c1iuvRUWnRImP3FUqVkDsifTT/nCU
 z7zPGh/uzeV8XtTo47n6oNilexxGxtr0rIfxpOE9IekDQX5hICooZymSbAX5uI9TlVLlGRbPQ2/
 O5J7+BmXfJG4MpzZWto/mU0551a9iMT4Hid+482DBz3J3n9cLy0l70Fcs0cTietfTKmOhC//yIe
 MVGJ9t154xnOhF8NAyBRAkPrMCQzXqcWQMpMz0rmakOfKgD8qLolCVHZNYX/vKy5Ase0352SYHM
 KYzDPudn6u7dqZkGnCj5pznIFSxj1qCrS+OW4FyVSUJMxb3uJ5uduaseEIbj3H+z3r7OTwjm
X-Proofpoint-ORIG-GUID: vZCrpvedOLbjFK25COeXjSlTlE2jmxUX
X-Proofpoint-GUID: vZCrpvedOLbjFK25COeXjSlTlE2jmxUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=598 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230089

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> Now with IFPC, GX domain can collapse as soon as GPU becomes IDLE. So
> add gx_is_on check before accessing any GX registers during crashstate
> capture and recovery.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +	/*
> +	 * This is true only on an A6XX_GEN1 with GMU, has IFPC enabled and a super old SQE firmware
> +	 * without 'whereami' support
> +	 */

Firmware that old won't even be accepted by the driver, see the slightly
confusing logic in a6xx_ucode_check_version()

Konrad

