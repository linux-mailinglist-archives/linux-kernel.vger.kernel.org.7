Return-Path: <linux-kernel+bounces-659098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BFAC0B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5634E53FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0573BE571;
	Thu, 22 May 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYukeLYT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB51EF387
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747916042; cv=none; b=VQHWK5OIT9S159QhSiK8hi+FRT0clPpQsSRpxXWezqnDR1OQDVDdVYyViSDqrpo4O8N2CM+ukmcoze3Z2V7PPaRpprjQ+l2n8A6PP1J11w8wVuojvuo1i7MSi54L8+zuYSv+33TE+GBBt2rJG8QJ0DPuZkbNEggyZZuBDh1VK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747916042; c=relaxed/simple;
	bh=s/P0VUHg69bQtnPWt2qfePIP7AEdB5qdnUIHt98wVBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch/Z/lQ1PcNFV97B0n2Z6f7suNWL+KmY81dE3WfJd+u4xdleQ8vOCDIxAnzMMin+D8zVFicvKX7c7OHuYUedaJ9qFsZ8fgLnokucRNvks/vsJfKfScro/wSXv0sEMTrzLspyehy4hYInOJb4bcMxie7+4FJeX5f6M87kQjhuSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYukeLYT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7UACL000720
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 12:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5E1zkxcDnkBmMlF1lOS5cPZi
	XEh90TLOJgiaJfuSCt4=; b=GYukeLYTJ867gY27ytWcZZqWKLcsz8BQoYjfO6dY
	2WI52UWqH6Xvpdjgj7ux30GLpNwxdQHSi6Wyw3wvaqzk5N6oFfji7IpI97uCxboN
	LtrabJn8UQPZmMCJtlcob5/KBO2lWjwazzKvl8St4Y/RZYSuu1kuDdL8qdLXHBx5
	iOpRwmHL+EL2taXN/57sxsHTOMzpNl+MPaYSDKG4jJ8nq3txWGPgAt9xdKZ45XW4
	Kl1AL98Rt/x4TFhEwN2HfTXDbUG44OmAXZFwYVpUOS0+pChz121DZ0MyZBo7edfG
	suqbyRIVSrPYTeJMFyxdzYmMG1+Va4ZA6uQVygveqLJViQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s95tmm2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 12:13:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2321207ff20so74528185ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 05:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747916038; x=1748520838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5E1zkxcDnkBmMlF1lOS5cPZiXEh90TLOJgiaJfuSCt4=;
        b=XAkKEUaT/GvBvuu3Zy+KaPyUhS0rLT/d40p61CnXqg4Ds6AVssGFInxsx9mUs1j3KE
         a8RTItVSNGqhwtGCoWSpiBsmkbegX39UnzCXwh0bJxlN7cWCuD1Qll7e6vewMmSMBMMa
         VemxYFYMmDEHFeyaHFnCybpSpdq0n6GqNBsdpvi+lkCjK6sFLJoF809on/hYBbcFe9J6
         0B14XdaeuGWr2oauku9OFtENg/uZrXEkf0+59QBeMjX0CCV0PEspKVqNUKZUSBOEwlN0
         4zFdPaexQPJjr3JfDZNbjTPSQgrdZjDxN26mdqIgeUVsdhIasXPpp6Hs4ULHhPVrVBQ7
         yGog==
X-Forwarded-Encrypted: i=1; AJvYcCUf6n9VSzyopkW5A24ISxcxpV7RZ0AHF5gYQFke/h/LKDsXFD+Mw3bz1GjBFfEXIp6MIy5czuL/hkWdnVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6kbnNircVLcAHhN2mPZI8tL+7eY8T1MWmu1o/kh68lg2TVcW
	suSueVBIDQr62O5wx245D/1nh0aF9yG7eNImfDhp62wgUALOrkrVnvMtorWIkm4QwjcgSq8wHo7
	v8x/yFy4Kx4Cx5viTrdRd/YRhGJl7OY4nUE6RsDoR0YKoJY6/SsxzJXUC5buIuB4e1EqhxyR6Cm
	wkJRcOt9asU2xT1PPJaN7iGdBEsQqAKiatgZicS0rbDQ==
X-Gm-Gg: ASbGncv2yXRSHKYgQMhWDhQWiKWKb4fdpl9Al/3gQOFax3U/b/pS1iUnvOJCcSI8vGt
	lUmu9M9PjaM43i153xbq3bBCeNl++jPv9IYVS3NFBqWhCU1zKJAddvu0vsVX0S1kDL0B3nEbQgb
	RbFpx+FjQ=
X-Received: by 2002:a17:903:3d07:b0:224:a96:e39 with SMTP id d9443c01a7336-231d438b420mr365147265ad.9.1747916038402;
        Thu, 22 May 2025 05:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ5VEoVz3hCcxXDIMg7e7/ldmBcjWGXTHC2i7Ve7pS+CwS16G0aa/76B8J7xj+tTqcxPyl5jGE/2dZG9ipeR8=
X-Received: by 2002:a17:903:3d07:b0:224:a96:e39 with SMTP id
 d9443c01a7336-231d438b420mr365146915ad.9.1747916038028; Thu, 22 May 2025
 05:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513042825.2147985-1-ekansh.gupta@oss.qualcomm.com>
 <20250513042825.2147985-6-ekansh.gupta@oss.qualcomm.com> <22uccyp5m2szry7bpitqcav5nlvwch5eqh4mdacfedidgrnyhx@vsjobngwdkmb>
 <dc67df54-2a19-4318-acd4-b96b8549b64d@oss.qualcomm.com> <7ogkoxsowpd2x5qmjog4qx5eu4eiinvtnyjz5hfufgna2hz7na@oxzmowlnelxb>
 <61dd2c3f-20ac-484e-8a45-f42fd5f42b86@oss.qualcomm.com>
In-Reply-To: <61dd2c3f-20ac-484e-8a45-f42fd5f42b86@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 22 May 2025 15:13:45 +0300
X-Gm-Features: AX0GCFtWixz9LfvZ3e0FxkpEf3O0Wt5ZYxeW1nkn2H642fUOmtSlAQNXYBwPcWM
Message-ID: <CAO9ioeX1uE3ty5oSezYOLJKqf8G5dLYAS5nRiNvryWTk0RPdEQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] misc: fastrpc: Add missing unmapping
 user-requested remote heap
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srinivas.kandagatla@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=QKBoRhLL c=1 sm=1 tr=0 ts=682f1507 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=EUspDBNiAAAA:8 a=kP8C-QOurGtaE5Th5NMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: O4OGR-hQbqdEAiCJ7d4zV44rq3flgnip
X-Proofpoint-GUID: O4OGR-hQbqdEAiCJ7d4zV44rq3flgnip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEyNCBTYWx0ZWRfX1+zPHAn3ZLv3
 K/d7/3exCcOKco8oRuY2kt7EmG8y3Oh4Il0mad3AOqwHbKmlSRqR2N+tNLJOsM0QXmdWXQZpcyx
 Mv7otL8xT4m+kbtm4MaQukuIXOjhRlQ08AcqwlOEZCs4cLySS/Rj40wg4YYo55/71ksxr7x/s7k
 gPOZU+HSRtJ2eUoTKdAtb77SBSGevMbW1tZP0nHKg8nVLwtqGaRJ8e+N65fv7XLqsgTuNnF6u4k
 2Rr+x1Ip+3TQv+Z9sX1Pne+KtTUz3/zQEevN4sYl6U9jA7KEUcGOnKATimEGbu6BaSKFQBVmkQj
 UNhVySuQ0Q1EZzqVrvs9mIIjOCuUdX6WXJbisE8UOk5UHwGtheOPG3ODpZy1wcnqe7a6XgJMsX1
 kMC83CBKTvIhmYta75XyCPkBT49qq8RbPmrMBWLZONgFr337VaMmN1NZf/VoL0mS5v1Vai98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220124

On Thu, 22 May 2025 at 08:01, Ekansh Gupta
<ekansh.gupta@oss.qualcomm.com> wrote:
>
>
>
> On 5/19/2025 7:04 PM, Dmitry Baryshkov wrote:
> > On Mon, May 19, 2025 at 04:28:34PM +0530, Ekansh Gupta wrote:
> >>
> >> On 5/19/2025 4:22 PM, Dmitry Baryshkov wrote:
> >>> On Tue, May 13, 2025 at 09:58:25AM +0530, Ekansh Gupta wrote:
> >>>> User request for remote heap allocation is supported using ioctl
> >>>> interface but support for unmap is missing. This could result in
> >>>> memory leak issues. Add unmap user request support for remote heap.
> >>> Can this memory be in use by the remote proc?
> >> Remote heap allocation request is only intended for audioPD. Other PDs
> >> running on DSP are not intended to use this request.
> > 'Intended'. That's fine. I asked a different question: _can_ it be in
> > use? What happens if userspace by mistake tries to unmap memory too
> > early? Or if it happens intentionally, at some specific time during
> > work.
>
> If the unmap is restricted to audio daemon, then the unmap will only
> happen if the remoteproc is no longer using this memory.
>
> But without this restriction, yes it possible that some userspace process
> calls unmap which tries to move the ownership back to HLOS which the
> remoteproc is still using the memory. This might lead to memory access
> problems.

This needs to be fixed in the driver. We need to track which memory is
being used by the remoteproc and unmap it once remoteproc stops using
it, without additional userspace intervention.

-- 
With best wishes
Dmitry

