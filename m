Return-Path: <linux-kernel+bounces-772540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F127B293E3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559D117998F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472511AA786;
	Sun, 17 Aug 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOW9gNSA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1583176EB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444876; cv=none; b=f3CzOu6rXcoZqg0iC4MeCkQt8ob28zUPlnqTJ+9432pJB/KR3lTB/Zk86rvRIyNOM6xktn8b9zH1DYo2EOa3Q/mervtQH1J/qi12TVq8y1ijkxsfjsIEcC6PhSSPBdBaFupJuFgwCqoM23Txqp5KHYK+Ihk86fQ68rqR6A9g7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444876; c=relaxed/simple;
	bh=bwWPCylTzJogg8flaphebRbKWZ1+3cWlxrf5Ib4Dy8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A5+u14lfkl/8C25t8uQu8W1n+oBLhifFfo9oj8Qk6cKri9VY0jCifkP5Ou7AvRcSl6ePCidEqNwuyPis1TcW6tPoxnE9B/XvmmZpuPFaV9inAWoAOKgcVM3s6aLCpfXQ/A8fmGvDsrPkmCQnwjUDcISaFyBLqg0UFHTe6iEU0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOW9gNSA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57H8U6o6013434
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TO0/YJoNOZ0X3VO5pGcZPZKoqxbNNDXnuoQuNXNkCrw=; b=dOW9gNSAayFW0TSl
	XrP1MUnPjiW1rkD0Yujn+2wf1rWZyKKkrJ5Cl3jq/6rTHHGjGsfS8pqQqihFHakC
	epni+JCmrdWzHM5u24yLLQeFYehF7RnejHjZL5tcFy4ZbtXe1RB13HyKrDsMuxdC
	TwJlsr8jKY6iq8K7jfdgUoUi+8xqC6hMzdxmw3hKXAuQN46xR+rkmHPVpGeDVrI8
	7P4ktoz7D0U1P6jwFcllc9LtsDyodjjwLgaPQUEveRSulP20/acJG0AfWsB65qsN
	6ybSu9DNyU+gqTLaFkXwPEWs64NeHeEoJ/JWR/RZs7l9Sexftf7pjpaxQlcfh35U
	Tne2tw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jfbnag9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:34:33 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88dbf013so82059246d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755444871; x=1756049671;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO0/YJoNOZ0X3VO5pGcZPZKoqxbNNDXnuoQuNXNkCrw=;
        b=U18OYy34g7hbce/1VVPHl9Y25u3ezaBEnjrJdHKKBRpUCYC8Kw+GcYtG1mBn0w3li1
         MrbhQyQLOlnFNl8bfvEIWQ6pxj8Mi0AUBngcv5BT3nnB83jORc9dBvIpJRjIAcAVaKj7
         /Axwyf/t1J5iypvIYPXMVIpPkq3xQ+S/TyizFKnBjYL8BVJ0OENTob85qJERqTlWMmdm
         ITbjZaA1x8n/G4DE83GGEauTxKZ3Gl1Zq1PtDEGm6MObx/lzwfoHbHKHSUl61fT5gTnc
         xz1Ge2zt5wjpPS3phgbq+KdgkJzmxEiJRfb7sk80NnvHiPbl9I4AGxQrdpULA10w0Lja
         lfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9jv2/LDKk9pdwbmFy6dSx7etLlSSM5kxgiD+SMPJLN9dTt58zphG7bLWbkGwTk7otmV0vBD0tDU2U/8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKDVi/ABIL+2klczPsYOVzatcW8K7mUEugHdmA8cJRfLgPuOS
	1ucaT/gyoidx4wkVWNeJS4m7I/q/ubwFcu0TiuMQQ5D1A2TpjaQkxL03Th2iU0QtQNKUiGUGJ9y
	MIJmuLQXHqASwP+U6GJ2RWHFl7hks4xc6QTgHnpVXNrJ0tpdlTdIFHf5i3TwVuwuE7cY=
X-Gm-Gg: ASbGncvKFm0w2+PvLczXI3jyMHNa1lxr2AsDwntEgARpWPLjReQBQoxnm6M7Ild9G28
	iNx2zAWsPEQPbh05TaP5T4XRlXC6WlSAfmJV70QrbEba8fuIaQUI24lRquIExf95EToFMWuVUOb
	UKCQmMKn/dpNAs8DvPW8PPn3NNPZs/uOvajiyXBLcjAKRKyftOmu6G0pdjuwgsr3mTXduWtkNiR
	HdyWsVveH297ciLNak5+PAgrCOVSlmKxKITLsGzj/Gk5Puzyn+sLMTCNAuFMSLY0pjkcEGhF/Ql
	Ou9Fy5HYx5cqIkO8QTlYJ7vfEHr+BjUe/Wz2rqNW8CfUX1+cgA4v5R4YW9vh5kg+h3gwA+k503n
	1+aOxdzRd2kecO/gGgw6VwWUAaLyaREoN1Av6vD3GJpMiJF/mF99N
X-Received: by 2002:a05:6214:19e1:b0:709:e661:287f with SMTP id 6a1803df08f44-70ba7be5a8bmr99692166d6.24.1755444871347;
        Sun, 17 Aug 2025 08:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyZL/O5yPOrl1HoYJyd0mthD1IYRGusl1A9M4p5zCOGyzvj3Oy3RHwfMGZaaasdsp+jP+aWQ==
X-Received: by 2002:a05:6214:19e1:b0:709:e661:287f with SMTP id 6a1803df08f44-70ba7be5a8bmr99691946d6.24.1755444870856;
        Sun, 17 Aug 2025 08:34:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41d565sm14571571fa.1.2025.08.17.08.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 08:34:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, kong.kongxinwei@hisilicon.com,
        Simona Vetter <simona.vetter@ffwll.ch>,
        Yongbang Shi <shiyongbang@huawei.com>
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
        libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250813094238.3722345-1-shiyongbang@huawei.com>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
Subject: Re: (subset) [PATCH v4 drm-dp 00/11] Fix hibmc driver bugs
Message-Id: <175544486847.2020385.3415657683583939368.b4-ty@oss.qualcomm.com>
Date: Sun, 17 Aug 2025 18:34:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX0CUg6Va56i2A
 To/TsLSQFsHcry7s/SsvkLjq6Jf5SKZS/HP1GxQeUry5CtDLCSbMgbhQPkd0Ntl01Pqo0vkEveK
 I91EbfrSl09B6mBlKBxVcWeZMYJjKlNxfAb3FrBnWvidvD3YBSGJvznxWMlA2uxN6onCiqHwiAG
 4XhfEhMFPdRWScYY4cuVnUACewvnKyQcFzVl4aqwQGDeZtCe4k4OTV3tFzrxBfM/eZXhWDB/fYa
 kWDpgrfhN8o12FL4eIa/d826mrvtS1KHzmavpLxUZJmGM2Fkwp5Qz+itmrxqGcq4ID0fZwNzdo3
 qHNiJHX9qqXfvRhNp25EoUhrUvQznLtqp1Ys7mQO63e+ZO7/wlbH+YFT2R++dSH0SOU9n1qPxX8
 pGbda5Yv
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=68a1f689 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=UoQGjLeWWrEyGxXzEkcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: BKK8LKc2I5uCKLWt2RC71xZX2dLLLVz6
X-Proofpoint-ORIG-GUID: BKK8LKc2I5uCKLWt2RC71xZX2dLLLVz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160001

On Wed, 13 Aug 2025 17:42:27 +0800, Yongbang Shi wrote:
> There are some bugfix for hibmc-drm driver.
> 

Applied to drm-misc-fixes, thanks!

[01/11] drm/hisilicon/hibmc: fix the i2c device resource leak when vdac init failed
        commit: e5f48bfa2ae0806d5f51fb8061afc619a73599a7
[03/11] drm/hisilicon/hibmc: fix irq_request()'s irq name variable is local
        commit: 8bed4ec42a4e0dc8113172696ff076d1eb6d8bcb
[04/11] drm/hisilicon/hibmc: fix the hibmc loaded failed bug
        commit: 93a08f856fcc5aaeeecad01f71bef3088588216a
[05/11] drm/hisilicon/hibmc: fix rare monitors cannot display problem
        commit: 9f98b429ba67d430b873e06bcfb90afa22888978
[06/11] drm/hisilicon/hibmc: add dp mode valid check
        (no commit info)
[07/11] drm/hisilicon/hibmc: fix dp and vga cannot show together
        commit: 3271faf42d135bcf569c3ff6af55c21858eec212

Best regards,
-- 
With best wishes
Dmitry



