Return-Path: <linux-kernel+bounces-852098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708BBD828F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52E718A2D84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02430FC09;
	Tue, 14 Oct 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+j30v6r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21130F942
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430289; cv=none; b=ugDHrctlFKpFo3pHKYcksh4Zpi+93XsAjSiMnBlzzpUCkGN4esv9JFKuDTbBVeij4cv32FgWWnApa+EzpaVrnUxxeKFGaJDyL3sK+X4JvmIjxdzXTqyE1IYnFW4+WqmFt8y1dz0UQo+FAZNFXG+vEVL4bfN8MhExsQsD+YMNHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430289; c=relaxed/simple;
	bh=so8XcI+x/03oOtuo3rwz6tNXONPvNos8iThU9PotsiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReA0DkLzxWSTpMozgKOwWFIFMaSs6dadSK8YtY9RZVxNgZW/qaawA++9i/Dta1Lmf08ZS9c9y09CqgRGiZbwG1086PqgUo/h7mi3iJZbjTxAY4yYCZiZLYfq25EQe4ASDJel65KKtlGgUKayJrKs1nMpL3sjKJbCZCnUdd9/yIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+j30v6r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87I37017781
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A+TNAe6m1YYxDo2xBlAV76VGS3L4AttFzxuFepNbuK8=; b=C+j30v6rfPat1IL5
	3z1D7ebXOYADCHhLer5cpNDyuehp/1YD+UkSgy7FbM2+VnyBq956jgaShJvwrAD8
	fOqf0zjs66vUSCwGfFylXNmN1XJO3WNhW0AFqQ/TL7B6VAWma92TiXxYlDeGh6If
	AtgHJsThhBIkX30cnex3VdDaZGFkFIBpq0JVAg0OEGymPaVGoQOfNdDEpciLNopJ
	tx1nhjokl/NrEt6KFmOK1c33v3Bt3zPpdC+acAtkKzwyv9afLQv6mXg2NUFw9fMc
	vh1WW29dyqWEnt55eYJV6MRbAyOXH4NV9L7Sl9bQb9BH642BCo6VB2OtkbD90a9b
	5utnvw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1ac1vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:24:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso14668373a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430286; x=1761035086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+TNAe6m1YYxDo2xBlAV76VGS3L4AttFzxuFepNbuK8=;
        b=MSpu3/7EBTG0Zx7aANyy/ZomTWkff0Gfjh6ShgCA3HkiaBuWJx0Fe4/bkRRZUlf+Qp
         Tkk78sk62npopt4Pl1h99e82ol6ex18fR/Qv8sNNM6o6sFB7Dims19q5zZ64WWfrVJ0X
         RJfxFVd0mugI1rDosY2P9Oq7TII129f0S4TrGANeLPPkyDA3HI0mc1OAE06pNq5mz6ye
         aO5h/wz818g/eV0/Etvfa7uL2Y6vbfmKD0jYpAu00YjYxKmJg597/uum+ehXXtZoq3Xe
         0QyLmQh4lRKunDNnQ+oRh1sTVzrUYVKQwRmILcW3xF+nwjH8zFUcvx9VXN1D+GH8bloQ
         w+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5zzzHCNwTZszDojsJD9JnI3P9siZh6yGD4Z2rYjy8AchV3VNYCo7kWdD0VRaQe/0t92tg4JCn+rWLHrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtbhrx5qp2juz9wEPMI1MICgEEEZDnIYv2KdfVFyhHVueasTqC
	tgTjV6zXo6w93N07ETXxxTkgedOYbUOMVNsD/lvXgEN+ITE5PFKc3Vk/W25MNSxg8CYsJiera/5
	tmhvariyMELexk2r1u+1BcGEbPlO+4lsOAfiieYG2j/tGTmsqQ84L7Tzs2Bc4+V8bOcg=
X-Gm-Gg: ASbGnctdEC1NmyaISIBfkelQ1npyTD8/+drCruLQgxVh6u0LFQTX2kl5cWoSp1rFnsg
	DB/9OY2Sfda4cz2ED4RVyVE2NhfyPa+FcON0H7Brc5RVqToCyPZJMZJ3xM4T3bZqaa4fd90f/jx
	lmb4nXbhZdRLO+GdKl3Bydbsm0/zfxPkJGflv2iKKkMcvzSMp3zVOITVqCXXq/ueSGILjBd3HZy
	UM5C10b5XllBARCMw0vP2OYk1+e0Hm9RI6mmVAiqNOQj4V7V0i5K4b3yds3Te6ShDWHpm0dzWqK
	dBFwdek0y1oWVGuACqDP4wnZggO+g8HyahUgzi1iHEVBZESGt/nr3D/1IJrEWedw1kSX9LE4
X-Received: by 2002:a17:90b:2f04:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-33b5139a385mr36822414a91.33.1760430285695;
        Tue, 14 Oct 2025 01:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG37bvu8zyNqsfUaQaEJ2zLoNqZQDq93XUmQoaKSFp/oMQ0do/nAne528GPIdA76MJk8wYZuA==
X-Received: by 2002:a17:90b:2f04:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-33b5139a385mr36822375a91.33.1760430285266;
        Tue, 14 Oct 2025 01:24:45 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61ac7cc0sm14775018a91.19.2025.10.14.01.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:24:44 -0700 (PDT)
Message-ID: <7c65a460-005a-3620-d263-53b6c184491c@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 13:54:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/8] media: iris: remove duplicateion between generic
 gen2 data and qcs8300
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com>
 <20251013-iris-sc7280-v3-5-f3bceb77a250@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251013-iris-sc7280-v3-5-f3bceb77a250@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ee08ce cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-8pfya1JHn5qUPT2TrgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: XDULna98JgWPOR0VWAzeZ5C-qxVeeAps
X-Proofpoint-ORIG-GUID: XDULna98JgWPOR0VWAzeZ5C-qxVeeAps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfXxLQk0iPwQlCO
 toXW2GaIT9tMKF9S98GfW5KytRj3KF7xRVdNEbr84KFRyhAk/uab75ryFp1bVuIELvnJtapW9ya
 wRqEnPm+hV7ePZ0YfCQL3Sn+ynk0rzW34Tr9FuJJoL6OQy6LyvI/f+UCg8FGj1poH6yYI5VNb+W
 c0UM4AROPBvFoIAVx3I4gqxibWE2971sn+EOlVKlNhc3LkuEXJI54hmZ2rmkxwTDQK1EWY0OCiA
 dqLZc825Q+H5uCvLACNTjRe+3dWXtqaH/hmxnrv6oMI5ekMUBzRt9qs1eaQGYkLH7AyXwF92YmO
 28AaE+6SlICnQhc4XhEU1pzDPlMyqrhVBMaDWayV/VFqbpk+/KRCUIRTiLtYJmfYZvviSO1ZQFY
 uhmP6nDBSyQyN81IwOscknxKH/RBIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035


On 10/13/2025 7:38 AM, Dmitry Baryshkov wrote:
> Now as we have removed PIPE value from inst_fw_caps_dec there should be
> no difference between inst_fw_caps of QCS8300 and SM8550+. Drop the
> QCS8300-specific tables and use generic one instead.
> 
> The differences between QCS8300 and SM8550 data comes from a
> non-conflict merge of commit d22037f3fd33 ("media: iris: Set platform
> capabilities to firmware for encoder video device") (which added .set
> callbacks), and commit 6bdfa3f947a7 ("media: iris: Add platform-specific
> capabilities for encoder video device") (which added QCS8300 data, but
> not the callbacks).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../media/platform/qcom/iris/iris_platform_gen2.c  |   9 +-
>  .../platform/qcom/iris/iris_platform_qcs8300.h     | 534 +--------------------
>  2 files changed, 8 insertions(+), 535 deletions(-)


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

