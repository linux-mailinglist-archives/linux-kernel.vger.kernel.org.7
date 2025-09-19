Return-Path: <linux-kernel+bounces-825078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793EFB8AE7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3508F16850A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7D1D8DE1;
	Fri, 19 Sep 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBI8VajJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DA254AF5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306207; cv=none; b=XEuBPhJVi9oqq6/3u4Z/UM+xI0Fg1jrEdju9/Zmkzddtypb+mP5o4PMq5JnBRJ92h1mUUMpaaUmVe5FSJVaxC6OlkHHByQmSWbiGqSXOTxaHROrgO8+pAS+1sGQR0VjzYOaQTYJmm4inI2MMCBoOh6jMPRrvadyeuG9wst2j28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306207; c=relaxed/simple;
	bh=ZMlanAxFKexgGCKXayKLLyUygjm2ZbznDAdzTjViEy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HC8NTrioa5pd2oVvf1O/127RX/u6DY5n55nAP4dhhcLLJHop+1yOyEv36TsjRQOVlcyROtob/qt+gSMnyv3OxXaza136MBWZ7QjjZBc491ik2GtQ/Uzw26PVjguki8sdVAGm0nRAZf4jMBfae9wpPDvmzk4ikiDpHSEXobwPpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBI8VajJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JGdnOU027113
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t2Rn0Zhk2qgPlF/bJPji0KgeEB74Opf+t5Tm2Q0n1/w=; b=pBI8VajJQpCv0y8r
	ng1nup7uOt4/HbABfBpalOq8BFXke5Ysktwl/FHNyGRG/Mf/iTOp0/1iiHaKGNQh
	LRsu1C1aAtFw9Rba6HMies2sVcZMWncqB8+e60FXeJ1ykTe2ySTyjDSUA7nHwPrc
	tq0zluMNISUwnlPQGMkj7E9uBPXucO0Z6C0AJebUlTAiUFExLfouX4C7sO9kwFsX
	uqIqMi4u94DgvzCHlz5dcbYvwsva3JB5Gw8Ey2awCbDfDJpN8Qoq82ae/OS0wzCM
	HC9HrMUKY+F/Ccg1AhmPBiCCT5PiEIHhbLgMzEDu5GT/grIqNBVVxHv0d2pvlX6A
	hYx56A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jher6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:23:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3305c08d975so2363490a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306203; x=1758911003;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2Rn0Zhk2qgPlF/bJPji0KgeEB74Opf+t5Tm2Q0n1/w=;
        b=WcWFk/jD2LbPABpDjiBMfsCbUzXOIhT3A1wvyjZ8dhsCmoy4uZ+FP0vPcPXJ2kt7rK
         uyIKORNQkk/2h4rFyyAX7xcPBSEDCqbOiwHkycIKBPUds9XxIJFU+isJw/p+HPjqcE5P
         Pv5r0niyV3X0x8Q7KKABYPYSERANlfpjq3oSaJTVezPybU8etEDbQIxgzgKa7JhQJUnW
         IupvHgjZZ7SaxiIMpb9YRKD62XVG1VQU4PcVVXpQbzcIAbuU6FEkHjXZNBZu7F9zNdC9
         E9uDA4okYKyg0f0uHMLHew/025bnc4N51XDd+1dAACQp067lIk7rH8DRJhfeVzdZdKcX
         FHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFnE8jHb4j/WBJqss3Q5eXJie5+ePl564IniHDXCajLszcECdMj0xZYmgC0+ibIR72hXBDSF9ry2Ydo18=@vger.kernel.org
X-Gm-Message-State: AOJu0YygSkmgj0/1P/CPLDuldQ3R3JFZpdrfQC8EZO+do/6D9k/D6hcY
	ztboWfkWYOsAApdU8uu6GVXNFp5CL5VREURpgKYivbYQmw7tCc5eR20fTBwpOj2Jcy0QatO4eRD
	VjxUSb7eLELVa9Ajodsht0EszUaPAK9WGevGOEJ2a3JKqFw63b9WTWFw/XO697mIrXDI=
X-Gm-Gg: ASbGncudSW5jLGBi2pV01xz3YXw6MI/o7UyHMfceq5wKPvERmBvAbME/h+vFAiuyMfi
	kU/+zRL8FSk4fq9XmsEB6YWciW9GznS3hDfDwaLowjzLuyaQ8jfyL0nAcvSrjf0rSuC/H5f7Gfi
	XerjC9Y4PWPlzb3znqCT+b7gtvPydY9eyU5y6RixNmGWVIUWgSZmUCZcFaDec3VxBhRy8aH4pfH
	X3qkVWFSMqPHEbg1ZipRIkcPi1d/NgCYzMG4yLQT/cm3BGVcKk2oJDjiF+v7LRePCvE5vT6G2A1
	schkMOenRdgt4MvPMIAxS36Kpl14E2NY7HTJRA4yvLJqU5jtU+vwmoiCGg1+N4K1ZPIduhm1IvI
	rDkdKlyNIuSIe9xMcEMUW6gCv0c/Tj8ejLw9z
X-Received: by 2002:a17:90b:3c85:b0:32e:a54a:be5d with SMTP id 98e67ed59e1d1-33097fd51bemr4758852a91.2.1758306203188;
        Fri, 19 Sep 2025 11:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrPPr/A79RaXqsrPS/Xqqb+C4t+vc2ZLNFhqzMrVIkwPB4cvK1/aMVX2xJwlhu213uyd53HQ==
X-Received: by 2002:a17:90b:3c85:b0:32e:a54a:be5d with SMTP id 98e67ed59e1d1-33097fd51bemr4758834a91.2.1758306202765;
        Fri, 19 Sep 2025 11:23:22 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551c279cd5sm2292066a12.3.2025.09.19.11.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 11:23:22 -0700 (PDT)
Message-ID: <dd5add54-c121-49dd-a3bd-0acc51fc3a33@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 11:23:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: ath12k: enforce CPU-endian format for all
 QMI
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
 <20250918085406.2049559-5-alexander.wilhelm@westermo.com>
 <e8d283aa-fb73-45d6-a89a-54ff31f205c8@oss.qualcomm.com>
 <aM0BRto3lYNJdBYz@FUE-ALEWI-WINX>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aM0BRto3lYNJdBYz@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S_MDTAs7ZnSD8a6WHMvFX8UUOo501SSY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX7V29ztZ9Fkvt
 R1fZJGhZFnIi62WvNzbuV1DLxZFCfXScwIP7exwvzy9vCc43GFcHB2Xujwo4zm01BSA/F0ven33
 3nQHsTSB3FQYTjq0285EB2EM+RPtV/qwCxjdT+Zi59oOtEg8YD4nn05YgsOWXvB+eEiYFsfhqPg
 1N4RiEzZ6bmdYQ65LbVJZ/sd1VoY2qFo+C9KT/yhJcfAiCLTY/LqKEhVUiCSsVVTQq20RF89Hj3
 qR6OrTvdZoSJTkUz9nah4zNxkU11dkvD8s+AgEMARcN+9l1/z9eaNKD8wDBYGhEHmd0tdiw7LcY
 adX7Kg+oe/IZT12n37BYjbzj4Qcdnes47QykjeHzgRmvy65YBTDIXRLy4K/6amAux0TW7oaaFsR
 XO0+C47C
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cd9f9c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GsdoeonjsfuC13c6vpsA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: S_MDTAs7ZnSD8a6WHMvFX8UUOo501SSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

On 9/19/2025 12:07 AM, Alexander Wilhelm wrote:
> On Thu, Sep 18, 2025 at 09:31:18AM -0700, Jeff Johnson wrote:
>> On 9/18/2025 1:53 AM, Alexander Wilhelm wrote:
>>> Due to internal endianness handling within the QMI subsystem, all QMI
>>> requests and responses must now be provided in CPU byte order. Replace all
>>> QMI-related data types with CPU-endian types and add the necessary
>>> conversions to ensure correct interpretation across architectures.
>>
>> I think you can break this out into a separate patch, but reword in a manner
>> that doesn't indicate any dependency upon your series (it can be a predecessor)
> 
> Sure, I will do that. I have only two questions:
> * If I split this patch series, should I start on each one with v1 again, right?

for the qmi series use v2 and in the rev history note you dropped the ath12k
patch. for the ath12k singleton use v1

> * When I mention that BE support will only work on future kernel version, should
>   I better avoid the "Fixed:" tag or not?

i'd avoid the Fixes tag.
If you eventually need this series backported, you can do it yourself rather
than have the stable team unnecessarily backport it.

/jeff

