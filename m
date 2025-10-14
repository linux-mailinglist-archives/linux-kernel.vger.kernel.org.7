Return-Path: <linux-kernel+bounces-853281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800EBDB192
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D72424497
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703F2D2383;
	Tue, 14 Oct 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyR9iHL1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B92C0F7F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470961; cv=none; b=bV2T5Vc/yjNuRLLnArizV76AJYtAIMXd4oCNszn0z9lcL0CvJolTmIYJFKiQjm3AZzxZ/Z6X08KQZ4y6MW8Wkf99PZsQwo99P2+3VeGMxZDDAnm7zxbW+nrvA4TdlEm1Lo9E5jNBDkUlgNB4ZNuOeGHr8ocS+Uh6E2xUu9AfPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470961; c=relaxed/simple;
	bh=2w0OhVkvnqpMVxyWLgeAGvU/GU1+uEwxJVS3uCjOURM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDahu0QcEcx20z+2E8EzL97dT+WqfsYKrgWA9p2ulafG/kbhEp5lQH315OsFREbbDkQJ3CBJdkweucQyP00gku/NzpoBHqyMkgpJ0rFYCpMdcMX517T8SIXX90+qZhuFMDNDlfuQJdWiyBEtoSOqJIpo9yxPS2/2ZlzV8KV1rBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyR9iHL1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFI66M001615
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2w0OhVkvnqpMVxyWLgeAGvU/GU1+uEwxJVS3uCjOURM=; b=SyR9iHL1pvupWiM5
	+q7vsipHk80xBqckt3H1wwpuByrGKvH5B5wkWw3zJ/Z869cdcwC3PCos3tujb3IT
	nv9KUclG30dG6MkgwUlLDhHyUm1clnL3gUbPTgKpr7u3dm6I9YMgX1bT6GpAsIMa
	NyDRfdZo5Cwm2srC6OQ+UtIWeTICXCHBd6RTH96ctmgUS2bEuRqL2wqEmITG4VF9
	uDfY+woTlRxJuP7TsnYvjq2KJ91dhu4a4uHuxr6q6rGqlZLfS+zLjeeQGyu0cKIy
	QdgOU+XnoVvtviq8Yt6xOR5qiRsHIBg47PuLGK2PMdMCh5UKnpF650LKLlzL4e4R
	MFcZMw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk9s3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:42:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-859df490f9dso1303625685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760470957; x=1761075757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w0OhVkvnqpMVxyWLgeAGvU/GU1+uEwxJVS3uCjOURM=;
        b=qLkm7x3eU8vMFzs6khOypwDzlD+g1YzxfkjCYIKLeDA17kW2zPD8qYeiNFoNDmel4i
         wrROis5acJmFLBLSKVp3XQG+/d3xAdN/rw7JmkFXaKS5xJghBXo8IGCPxexPLnTz2bcu
         wf2lkIPMLkDsi39lKkvBTQWhMpkOReaHRoYs9kbMyKlKBvmOmdAKHefNGH8GZ+rIi/h5
         Z1qsnW/8M/Kofw35w2uFhcy68YHVaNZM/+gNAIfjSFoutz+PWbNYwdpDfJW6VWQjJqDg
         ICCqPm/AuThzAQWjF7tCPQkI291sCZHavf6MFD3PtL5T2ErNnBmFdCZgTJeaY5GwSFiu
         BU0w==
X-Forwarded-Encrypted: i=1; AJvYcCV2Wm8tRtlCWzbbu1sbnWMBlgW2jKtrNPqotXHV1jInErM+rWXfBO2Vz079KDuFgw30+zk+FOEYfu5aXBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsdtM5lo7O4nwS7Cm748HJv3pI2xJiK65SqcghIfWv0/P4pOy
	bWGQ87+dgNGpo2dGvomF/2YLg5Go7BQuqzNjTomej5qPqZozEZKgihlnSSHgjQ23tWKJwrmyNJ6
	Vk/vC4u2dqekxyXbrZKuDqcP7x1PgL/H+DXvPNtgxKvGJ8gYbGFkuJCwQYQ7M3ynxfXpo1uP/Ux
	yvk7zKY0rK4j0LbnQvcxNxEUcCH5O+xJkNce75sE12Lg==
X-Gm-Gg: ASbGncusz7j4F40LSFGWmtFsNEKqN2jk+ye/GU/FRa7tEkX1/kzjbB5Muc+aIQjWynv
	Qq3tEK3ayc0g9ciIk79rwiIiSWHQY4kaTZ04FhhT8PKoh0CkDdfAh9FpD5SLPtN03PBWSJkB8aF
	J2QfDp3VBImkcfCXhapfxdmCfYCW2pZ2qDh89x3ZOAErdMDf5fb5FtPQ==
X-Received: by 2002:a05:620a:2a0b:b0:827:b6d0:3896 with SMTP id af79cd13be357-8835069a1damr3630596585a.0.1760470957567;
        Tue, 14 Oct 2025 12:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy3sTRoJsTak90pgrQQ8wD0f2bthSMA/ymChE+mOsrkVzDaV2i1I2/Kh6A+2MXfghhSWBFEQg/Rjz1F8Lf84Q=
X-Received: by 2002:a05:620a:2a0b:b0:827:b6d0:3896 with SMTP id
 af79cd13be357-8835069a1damr3630593685a.0.1760470957071; Tue, 14 Oct 2025
 12:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011001038.352393-1-linux@treblig.org>
In-Reply-To: <20251011001038.352393-1-linux@treblig.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 21:42:26 +0200
X-Gm-Features: AS18NWCzGHahCTCoi4NKzxpX1pOXRnYv-7AhbWeCyZ6P7MJDMKYseIP7279m4TM
Message-ID: <CAFEp6-030D5f1NMasJ8=PPqgRpY9aNZqxXjrXLHa8gfaYcKj5g@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params
To: linux@treblig.org
Cc: jeff.johnson@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: dbUstg6Rdj2mO1BxXO1iTIjCUjIxCUHV
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68eea7ae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3WJfbomfAAAA:8 a=EUspDBNiAAAA:8
 a=dNIyxH4hxPn-D1A5x2sA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-GUID: dbUstg6Rdj2mO1BxXO1iTIjCUjIxCUHV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/YN5BVvAVTeo
 ARY4RfsDQtibTT+hLOyV9GLkyDCY+TKVYuJvBvzlY9CH9nq0aPaH+FUi8ng6ybQhTO5JBMcu7Z7
 u1xHcxofME/kn3fD3q+1u9KxYczDkwowsllhrO39rQvPgsQb0GvWB8qcKDSuEhFCB5FpI+2hyLX
 Z/RwaVJVFQWOyPhm3vb4FlWOP0FcRS5ISOWDoHOFSSIgyUUiJrRCzUCDxv0v0VR41hH/gHATFUK
 i8eNv5QduY9f3k0I89RdMQq8nAHJbn6rSafoMmpDOah0Ej7T96d9psPHcbNbT6y+CHG0Yfq55dk
 zJdiDtHFnoqnfE+oKlEuaqH0e3dXu+t2BAmsvXrLi3EVZieMRZwV65fp5z7iFBHJeJtj/WB2I/1
 xJr+xc21RHx5yY8tPfY7FQT6TuG7NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Sat, Oct 11, 2025 at 2:10=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
>
> Remove it.
>
> This leaves the wcn36xx_hal_update_scan_params_req_ex and
> wcn36xx_hal_update_scan_params_resp structs unused.
>
> Remove them, together with the unused
> wcn36xx_hal_update_scan_params_req.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

