Return-Path: <linux-kernel+bounces-796430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D3B40098
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A773189469A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8711F582F;
	Tue,  2 Sep 2025 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X2pz/o2K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7D1F4C96
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816256; cv=none; b=qVtCJnX1BG/tLmgKHOHYpUWfUg2RTgywjG7tCos/ApbIWCKDcCZK9i8L9K2IL9z/rqgFvMOgypcJTd3rgKArT0wLrxcCD/THYrcj6QlHbpJnaCLtOL1+EiNyZxZit4bBgZUbm4iBJ2BuSJ9/IgpztT857+7eJEoPButCZQa/UDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816256; c=relaxed/simple;
	bh=BNWoXsVDFnok4UFE+T0JM3TKXHmHj1QrThTVFrNIAkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLI0yLKP4dMfKcc5I/qFiaEc8dfRr/DV/Tanirb4ujqPZs5MDcJnTLAFbQVGOLGmZ7FESbTWRQtlYXjhZZC1Iipw9+rWNjCdyCPJN82zvDv6Rmx0C+TPm8v8nNIpCz6P/1EwFm9eEWV/TkwVP1h3IkclOnvpobKJDeYTxK/EQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X2pz/o2K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AeGOj024999
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BNWoXsVDFnok4UFE+T0JM3TKXHmHj1QrThTVFrNIAkA=; b=X2pz/o2KGIh9+Ffk
	JkvjpBU4/98fgg347M2ChiWgeISMl1m7Z6VQoXYRnp2Ktj3oG8Ci/KOXqrs7bXqp
	kOkwdFX90MjzqHGFGfn7M+Nn00zesmVj1qNejtLuZFoadckRsurdpS4xTcEbadsJ
	JSkokdDfOhK6CRYNVRo4Khygg8EuZ1eztFrGLGthoipZPEAhvyN2awLdSoqD668b
	hiCV06UNzrzajK6Quj2iMaV+c5n0dkdJgm118ZHQsrGQpr1VaMB+F4tyippbwuCG
	thHJcTcB/vS8rMzMZWerk2aWCXgbfEyoILbK6mPqsIw9i1vlbxQ4pIXNFA+eqZKJ
	vI4EnQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuyt48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:30:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b3d3fc4657so95711cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816252; x=1757421052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNWoXsVDFnok4UFE+T0JM3TKXHmHj1QrThTVFrNIAkA=;
        b=hJyaRq4Pk2PHwxq9BGw9IHUwzg08UzjzrjbGlb/LakhUHcTSjtEJXbKDLyDxqyjG4X
         sQE2SCqS4HBXcWSZKp7wiG0+gJxlh+qemrgPzLqtA1Qt+sUgOPFS1Jr/LrvTgmWMf2rk
         rmEyrfkFY8vWC9jekdPTQYwMJJ142Ldw6YG5p/X2xWzGuYUzvEKFyrpSWKdvL2fPzVOF
         /NR5qRBkhVMXFGf2tiT2bjA5aZdMg/Afl6TnJJKGZ2rB7tn1fiKAnaL+oNgh62QVS8Mz
         tN4dhOo2oTC00UE+D8iA7it0or1ndCHsa926vQ7jClm3HFraFEq+b3WlrQMdz0P6S0hg
         qnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaq8FeEWLSLneh2+GxgGfFTPpkFLP7EqpnX5jRLnSN9zcEjAxYPjxhqTNrkM9SG+5/Go8Ob6atFoNwWps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWSRTJ3ScRd+J3JFdbG3nOXf69oqrhkLkBs+egKlA6TdiXcA8
	iOJzp9yI1+VaKEidbqT5bk2xWgNJ9Joifl7qS01uAaL/KyyTjh6bfokjiTzXLvLqEeUw9XM6KmG
	Yc38D4ucF/NKSXKUEiNgTI5RsRs8AhK+MH5Lp5JSc71LufaGJVASrSVUK8B1vEmRJu6U=
X-Gm-Gg: ASbGncvQXm7423LPZRL7KqA6aQU4yM+Y/+pxZagmIRWXi0qIOr9cfrOHz5/Ng10Ro2C
	QvULAu5hxbvM0r0PQe6u/HvsfVOqqO1snIm29mLvcb+GoxIPOpvOnE0db/0bEpVA367LSYiUaKk
	VYjcRDC9asOnvO4t4TXkkhlxxx4/rbEQ78JvbBQCvhC4AC7jiy38QLK5LPRL1Q5c4dEtNMv1yat
	t2kI639P7KdWgjV+zlncERa6QyGojUfTqoE+jXhHx6WskncVXhZaRA9f3wJnWTnn2ANrK9TzkY+
	Z4L3KfjI70OhOY73mYRwkzgkDsirvJQpMFWNz+xBEmm/pAF/SjemR9MsxlNxsggcmTZ1G5GzQ16
	TuvE8KxDl3d5TKf3cjboD+g==
X-Received: by 2002:a05:622a:54b:b0:4b3:45a:2b3d with SMTP id d75a77b69052e-4b30e9a845dmr104245331cf.12.1756816252048;
        Tue, 02 Sep 2025 05:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlVMbYgx8dc1lkUCensrY9s8XZ1S7XpWw87suZcVbaJfnjs0OW6CdvMWyEtq87QwjeBLmlGg==
X-Received: by 2002:a05:622a:54b:b0:4b3:45a:2b3d with SMTP id d75a77b69052e-4b30e9a845dmr104244851cf.12.1756816251241;
        Tue, 02 Sep 2025 05:30:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0424cc1698sm544146166b.21.2025.09.02.05.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:30:50 -0700 (PDT)
Message-ID: <a701e4f9-57b7-46cc-b42f-f1a4a902fbbb@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:30:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/msm/adreno: Add a modparam to skip GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-3-f3ec9baed513@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250902-assorted-sept-1-v1-3-f3ec9baed513@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX0YwTes0j4zQ6
 8aucguf+Hm1ZHvFpsVjKqFPd1Edl9nRmkWtbvPQs88Bg3xqlmNSAHPcU26k8F6QU7UNHJwJtlv6
 5YPEhflPggUbr55Cd8bXR43TKRKn9RUPG3aQZLtbzy9RR8UAqKVFRkLk5KT8gHDgXrqLqSwdt77
 ZSUjFc3YVLhx5j+Xyey/Dgh6Kn4uaq7Eg5iqJBQyhvpyn8LfSGUNhARE8rgZZjgledbNtJIVW3P
 lS75j8FvIzJGVfwEIS9sjFs4y1xhXr3dLIujEQOo//Z5QDHGJSzxTG9eg2/pYE5pC4I1Xlb14Fs
 G2us13n5nKRIorlMNFCzqiJn7yVVuDWTEVt6+04AMfEY46ZKkjys54rvqhV4zIyhlxVx5GMsKhL
 zL6uHwJI
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6e37d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=kokVE_FroeQZl1yzAO8A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: pVdPMw1S0AWzu6YCLESlDfYvSpCHGV07
X-Proofpoint-GUID: pVdPMw1S0AWzu6YCLESlDfYvSpCHGV07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 9/2/25 1:50 PM, Akhil P Oommen wrote:
> During bringup of a new GPU support, it is convenient to have knob to
> quickly disable GPU, but keep the display support. This helps to
> fallback to 'kms_swrast' in case of bootup issues due to GPU. Add a
> modparam to support this.

I'm not entirely opposed, but slapping a // in front of the compatible
in the dt works just as well

Konrad

