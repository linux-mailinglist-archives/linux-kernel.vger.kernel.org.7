Return-Path: <linux-kernel+bounces-740613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E497B0D6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0171C27981
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE72E11AB;
	Tue, 22 Jul 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AK7xyzVG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1212BEFFA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178426; cv=none; b=GuklnOuiJLxYFoYsJMxqF8wTUZC78uhFzDCXCEL6bNkDqSUTctXIImykhlnSl98UmA9bK9+2q6z0TxkW0+va4SKCYryydMa4ugjg0H11CQ9nvuldlyr6w0Tmlx1zKWGWuHdViEa87W77cufe52fVmuw8ffCHE6N4gtc6VQFOo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178426; c=relaxed/simple;
	bh=ZFUos+Yvil8dSKOPIWe/qIIyl/GJfQwWc76Kh9pE+Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXd1Hw7xLw1/gYMo/numqjbD6ze3NYllidkAITMaAR7wygNt1QssLLWrtME8lpiXdKE1PQ+eWBno5onoSLb5554COD/yH+69JcZm2mvdSuvHsbfn76kh0I6V0aX4Y/b7/Fuchcd+XNW8mqTwVHr6yz9VUzrdgMRDFkb05/AHgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AK7xyzVG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M83wnM010598
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZFUos+Yvil8dSKOPIWe/qIIyl/GJfQwWc76Kh9pE+Uc=; b=AK7xyzVGs/M75xcM
	7HScBwdSKjWDXCteKO3Qijnnm6X5oKWJGNH6gmYAzu/OHpaxpgs5UeuuMFCbEKux
	dIAWqIdMH3rb6IOSjOr09BtaCZI6bxnoWDsO8ki9M6nTdxOPVUsiNzzBlqF9Dzss
	LSQZNJijCVFtLfJa0ODUa6LMN6/DSU12JlhUsnKZBxpjYqdG/RNPOU+g5YsNN3G4
	/s14+QMbGb/rhg3sMCviiq0rpBkm0jMcZ+6r0Db9zaM1az0c+2p/sdQRCaw119b3
	JYuqY9/6xKkV3+Lpt4FktOqkxO7HfzBqzl3oR2FoAulf20zfsNGGtWHTCdttq66n
	KlTKWA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t18c2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:00:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb3466271fso79998706d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178423; x=1753783223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFUos+Yvil8dSKOPIWe/qIIyl/GJfQwWc76Kh9pE+Uc=;
        b=naMkkDpqVJzaFB1Z/GZLdp8yv9y/Mhdlq0gnXUVEH1Q/aVK0q6Wki+kkDA6urlLz1x
         kH9GPdUIJ9xoTZ7Q6f9B79XV+V69Nxsx5BqVkTsrPu7z9t8XbuPr0+coFg3PQfCu66u2
         YZzgNoIiVW3SsTCKUvbVcr33XcpFrW92om+FtNxFGjTO0t7JSvt4JQ1dP29qU1tWCoA/
         zTrFIxj1QACJNk7bdEDF93ErzAEwyZkTois9bZaNK3phf4rJK6Xly0kZC8zc8suy3+Lu
         1sc7q5+W2467Ny+jJ4GNore9wL0uF4O1cttfkTq1+Os4BrYsEgCxOOI4lL1kxC1Rr0Wz
         Wddw==
X-Forwarded-Encrypted: i=1; AJvYcCWlgw3qpOx7dBUuYcibppg88QOBqDhJTkxqsWsuugK2EMo+pPQVIrazkJ/uP9MrtxL++roKU+VAyR2EL8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzwEO0x38eS2Sww/CU07+EO649e8O/wYvlgW1qdJpbXdiVNcP
	NBL1/E0HPZ1/2CW4JBmh8BxXXfkeM6el3oBmIge0I0kSqdfvL7HjnMXfA85tibGMFYh38mrJWzk
	Mxh6kCeCGRpIOpigC6mJOvYJHtVD+q+RZN+vxHIvHbHgRH+zAterDVTDwqp4mJIVMvK0LS8CN/3
	alLs81YEw2n1ysVQ4d0Jmzmp8wvVysNC/WZWRg6sQ7iA==
X-Gm-Gg: ASbGnct3NpFSOlqYEEkxq7Wbsq6tBnI53AqmE2Q8eKJhshouN+4ObvGzZtR2zKyfhps
	OCNzx0dsv55lq7svVOu2iop0H1HNugLe4sM3sikDoXJGE8jwofkZWFRAPLOsjktu7kDg2kTzCRm
	MP73tEIh9w+dMMOhHvln2Phg==
X-Received: by 2002:a05:6214:d8d:b0:704:f7d8:efe9 with SMTP id 6a1803df08f44-706eb97e401mr41624636d6.24.1753178422891;
        Tue, 22 Jul 2025 03:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnslX1INMW1ZcfY8C65651NT2OJbOZR/zoQ6vqkmc1Rh6IlkIlO7GZRBmqwzeh82/rHsXodp0l07CU5wDGjxc=
X-Received: by 2002:a05:6214:d8d:b0:704:f7d8:efe9 with SMTP id
 6a1803df08f44-706eb97e401mr41624056d6.24.1753178422401; Tue, 22 Jul 2025
 03:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-eud_mode_manager_secure_access-v6-1-fe603325ac04@oss.qualcomm.com>
 <2025072141-anointer-venus-d99f@gregkh>
In-Reply-To: <2025072141-anointer-venus-d99f@gregkh>
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 15:30:11 +0530
X-Gm-Features: Ac12FXyseMee9ZgXxpNxNQGaZuoVfGDn4Cm07lYWSuBy4v2nvFb9hxkyxtZvFQw
Message-ID: <CAPHGfUOsk4BjhvGiN-b0UP-JZ48UvGeKFU=dhb=KOAvo8NCPZQ@mail.gmail.com>
Subject: Re: [PATCH v6] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: wy1wJnmSdcuGQPdNUOuTzj8gMptRqIbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4MiBTYWx0ZWRfX1UaDiQVrIXPJ
 cqC4GTXhB+wAn/BkeP0kVe0zUR5qFiX+fcumoGwzUUZNNLYL/AxWmRT0/PyDR5EwzBEIQCD4oR1
 ouxKkF5PkDBG8hzC000zKxec4yZfY7ZVAoiRLNBcTBYaU38SjlBvg/kugT8acNacqXp3WsDs+W7
 Wu8K2fbMyZHm3lYPWxM4jn39ynBLcKCvVOlcwK3bOfzwhoF4cY8rAbA9AefcURGo651JEtMqhlU
 u6zli9u3cmkTaDu9uAlmQcSsw02vFjSjo8RwapxDjION1u82BZf+O1nhHgGRCXcVkMxUHKbTjG5
 1e6ywkQ4P2MTzH20GyTag5Vmd5XAvWr9vCPsHT4dUjFx2TWCMTXxvmX1NpvqZkz85h2FO0No6YQ
 SvIwIFNZky8/anfQrvB4jaEGF2eL6rvyPCrMqiaNNAmpzphxtNRZVuvktrOYFRk6kdOV1kGI
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687f6137 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=ag1SF4gXAAAA:8 a=HSf_CmxJb-FKQ9LhJsQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: wy1wJnmSdcuGQPdNUOuTzj8gMptRqIbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=775 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220082

On Mon, Jul 21, 2025 at 12:23=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 21, 2025 at 12:08:41PM +0530, Komal Bajaj wrote:
> > EUD_MODE_MANAGER2 register is mapped to a memory region that is marked
> > as read-only for HLOS, enforcing access restrictions that prohibit
> > direct memory-mapped writes via writel().
>
> What is "HLOS"?
>

By HLOS, I meant operating system running at EL1. Do you want me to
change this in the patch?

