Return-Path: <linux-kernel+bounces-781640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD12B314E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F58E17E708
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5512D7DC4;
	Fri, 22 Aug 2025 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5OH58iB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137D2C0288
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857659; cv=none; b=akwr7NeeCID3tfBqlIuyoSJLJfcaYrXnp3jW9pu6Po06C1OMHnZkxg0xb95h7hxzIk93x5n5diiQ7FA2dEX7tIIuvoh2CslQ7DoLcW9iCN2gwHYAhBE009ZOPhO1p+Jv6ycem9hd9fBUSTzKu2USJKRH6gniQxztWMoGQ4wnpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857659; c=relaxed/simple;
	bh=n4XlHGSeVV4u/xbLlWPIf9uljQMpisW4a0en2tZ2Heo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7OzyWuHSXZWDXWRwfTU8KI1spuUUb2TWZsUFTlv+86Cb2exbs0SwFhzXvWWYQl9bBhZ275jVr56FkFBIVbBIQpmSYxI3L7EXuiJmUrkdgFPyYv7BQDz1X8kLoWVmFtcVHG+h0XCugSjerZa+l8pgAUVpzN6o+XvaTzOisGnH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5OH58iB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UQOF028662
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nJJ4C4c1AFbf34ScS1nOa6Ac
	tdPWOXGtr4HiQq9bwqc=; b=R5OH58iBcrn9G871ea30573DuAaYzeeW6CpwHJtB
	8iWmxl0RNsJSom9nWbNnAGviY7GKRT0MyAPZACJkRZtwokhI3047U0Vx3tGXrn5X
	oo5OvjLmF6ABdb8Trf7Xgi4v1VBSTD/liJfoCzQOvaaO+NJGu9YmdsSF6FIXQfPh
	t6cqfxbf10MY72cTI0C24GbvNG7xPaRraeXS37cKezv2gyLg5RIPRGW6DfK8ttLG
	8iJ+SK034B7fMcCzO9EvzEOV20Lk+FSeades/CpmjJ+1q1fxspLO32I07GZPaZyf
	PckGKMZZroSnwWenGoq1M5plGvnrrgLfTAHZkDD/K8fqJw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cruex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:14:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d9eb2eb9bso5061056d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857656; x=1756462456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJJ4C4c1AFbf34ScS1nOa6ActdPWOXGtr4HiQq9bwqc=;
        b=QVULaMVD686kRINUgp62uDhBfi7Mvk7R34b01c6Qw1xTqfVClLv+PAyuLAuVVUoSKU
         vRQSlWMaeXB/UcWPXXOpdLiHCmtc6d3NoBvAkUCWvb1jSuiQKtowYvZFS1kXt8P6RJrP
         gEFG9z5zRbTe/3SRXA8DpEVCH2ayhbZ0bYPhmIs5F8jG7e5haPvkp6X6QqOJr29aIkFV
         SWW/FOeG5MSZffHdhE8iMXGmS+PinyKKLJQvWKUl/WyTdHc08dOWh1s7KDdKCkG2QXsP
         NvpVemAhD4/jx4Ialvky51nYhErvZ4Jpkze9MaIPr/fP3SqMFdQhY6tgEMT5NtobZE5B
         ag9g==
X-Forwarded-Encrypted: i=1; AJvYcCXArAGkZ+xVmGU55YySmJvIhq13lBwemrJZCol0G+FMTvdYN/nQ+QOXhiIDDN5Ox4d/s8g6yjul1mBxGVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpATkmq+ajaKhcn+Vozdf66i37EMavnpUSxEfeRXMk7RSShIjF
	SfUawsZtVHizwL5YSUhjDkSf1hPy/LziumHCuE/PEZuA2DU5/QN6BcrXlLdWyTOHw3Vx6bIStH8
	qbLOyhUuoaQThxDn1bgq6TcUPllNgLrcoJAY2CweeZF7Lali4U+SH4seW9fMy4lEiUZc=
X-Gm-Gg: ASbGnctwwrVJVEzFtuE8w+nV3DEluVoEuFDTbRV2nFX0bxBYM3xjRUm/Gl0j/tVfgYm
	UmL4IYbjGZtWUndNgZmbDRzk/mgBHSu/ntLwM6SlFiz8iypHKyy25zXWf4Lpw4pAn4M4cT1MaQI
	hfC4Zeq3oUE6MY8c+TzMujBcRKvDvEzDDTPhw4vyu1OZys1jjGynRjJEU7HfHAXbX0+GaVwdJjI
	hYtlFuUnNNbkyVzYba81Syrxv9y6MFpDAuQDrntb/q7v/1cnEEMxfK3TqK6uALWH2WZStO60E3f
	11WnyT4fT6hJl1ncXcEvsZfrBcrsMory5H/+a3vYtxI9x9pgxCPS7AlGrsJtJs3v8JYBMW0fOPo
	9NU65fDxjFW76+N81hc7wflpxEKO1POApUqRKIfhcWaofGW1q8XPg
X-Received: by 2002:a05:6214:411c:b0:70d:8aef:8d0a with SMTP id 6a1803df08f44-70d9723d63dmr28732176d6.59.1755857656257;
        Fri, 22 Aug 2025 03:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvj+OJvL4U4ICh4U+njjBOvCBqdT8JPERhEDd9yPBFxhlUitzuVfVPcNlnrlKx+hna3vy4zQ==
X-Received: by 2002:a05:6214:411c:b0:70d:8aef:8d0a with SMTP id 6a1803df08f44-70d9723d63dmr28731856d6.59.1755857655703;
        Fri, 22 Aug 2025 03:14:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a604776sm35600511fa.47.2025.08.22.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:14:14 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:14:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rpmsg: glink_native: remove duplicate code for rpmsg
 device remove
Message-ID: <54moh5c4s4hssl47tabtlqm5mu33frf3x4k3fdhsrlc6abfltg@n6igz6vf5yd4>
References: <20250822100043.2604794-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822100043.2604794-3-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822100043.2604794-3-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-GUID: QnJKrzwm2st2dlpjGsdblP8fo3HwWLmM
X-Proofpoint-ORIG-GUID: QnJKrzwm2st2dlpjGsdblP8fo3HwWLmM
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a842f9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=iW8-pYDVSSCBICfSpsoA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6eFCCdXQTb/5
 tQvo/zaoC3a31sRTs0tUMXw0HWTFgRHmwzbA8lBzxgYqBGpXNGaJ0aP0Pp7Hz/rmdnUkY8ZfpZT
 W/KJFcvifr1dsDOYH/K0uWfWFXJj8aZAC1hKiS1UdNJ2CBowxRZwzQB3eCSTue6WgzXLfBp5MUd
 b7swpYql9HgTtkP59K4XoUKygBg2Vb74CHyjd+5fu2mMapI9fq0FLWApbAHxMC6tvlXH8iU3bYF
 PH+lT4/vBfRtt1kqvB5ch+COOjfL4JxMOpXrhz3peCIgQkwQKiDwZFE36agVH2Vd3gODBMt7YkV
 tvkb+7/HaDheEPzcQypBzKQyD2ihn0bmNI7PQZtgpFdnIRjlQbPqW0/QinzzrhqR7NOfVjVQL07
 6sZm3S4n0WmEa21nErXC0CLAUH8h6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:00:43AM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> rpmsg device remove code is duplicated in at-least 2-3 places, add a
> helper function to remove this duplicated code.

I think it's better to sqiash this into the previous patch. Otherwise
you are fixing the code that you've just added.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 43 ++++++++++++-------------------
>  1 file changed, 16 insertions(+), 27 deletions(-)
> 
-- 
With best wishes
Dmitry

