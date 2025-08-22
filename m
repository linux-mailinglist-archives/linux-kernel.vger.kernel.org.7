Return-Path: <linux-kernel+bounces-781621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6338DB3149F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495E8B62C68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4B296BD3;
	Fri, 22 Aug 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFTWwsQZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19252D662E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856854; cv=none; b=THqbDghHd3AU4m1HvHTPTd0OXU0ZYB23Ym7VZ9ZVerDdVGx9eXfC+msq3YRxz2s7IcAg8QNQMpeyXh9JoLnBELi6fi7dWghWepVLVkXakZkr3TKDvfqR1Kppkdy9JMYnUpMKVab/cHDb65uuwfhzJTekcwTyUlEIdemHjl1KpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856854; c=relaxed/simple;
	bh=IN/9k5eKqvtwYiC4dwIMx/h9QOJQd7wmJS/BI8UgYf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdn0X6xP6hEJUJai8nLchmQtW3AYMw0kJxigsmxaAF7UaL5+1hBg8Wc4NDru/b+cip0FWkCUAoZhwVMDGmm14I5uAD4FfrA1jbl8LJNAkx1F55BNGPKYM4C/TYAPFgl21E22Q4wzRcb8BQEx0JPqAanDFsZ32gtH4XXWKlfPxxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFTWwsQZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8URHV003755
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BiZ7xasJHYty7KtFQNXG24FyU2/Y4YICeik
	S15YW1Ns=; b=dFTWwsQZE33huhNM22tYIR9hkj3HW2rY6o8hm00mkFWtEL8D6B3
	Y8uYQ5vgraV4gu74rdNUN8J9AXYrVktpEm3nldFHgTD4573R3qp0HackjJ3B2ag2
	HZRnDi3EaDUC0UNDL0U43Vy9B+bPBZ1daMUaFV5qIv8wUUkqEbrfxQj4diTWmWT0
	MUuAZJYbKicQRW5H75fkdEYRluMU74NOoPJInXzFTMiP+A4oDwCagOzYhZtBnBtK
	HlZ6sGzw3tGDukNst8JJDM6536f4737iW1QpyALaV2nxdYeGRg7nITkgTy9GPoQ0
	oMxUOin9VqPkG0BdbVK38QxroFI1De/Fh/A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298r9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:00:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2b3cd4d00so5248641cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856851; x=1756461651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiZ7xasJHYty7KtFQNXG24FyU2/Y4YICeikS15YW1Ns=;
        b=Bm0v7Ms3eRODi1/GKW5sQq3Q1qDJ0fEOJegsGxu3aLl/bHm/p4kA4pS+GQseGCPy/0
         aFtBHBEdlbSmVxJKudh2YyIMpVsDM3sIidac0yHyGoqkgoYJfTiMLK5YL3eejpCmKo8G
         FIHNauSBavNDHPchpaLIQqI43yvHl2Gfrf7Q0w216LXZuZGn69qf/xFPzi61i7qhlynZ
         3KL9C4hK6PbqOkC1a2wkXSEN9Xk9c2PChy56M/AfZbK1/lAH+EizTW5JqlQLhut9B0C1
         qypKyc0h5rZooeCudp2VS2QEf6AEDMMWSnTkPEyALbig5G71HhuJ8qvZSwe4s4IvhtM1
         c+VA==
X-Forwarded-Encrypted: i=1; AJvYcCUplZ1Ex1bgi9+FklEfCVUGCKMsDOhfleYpH0joIj+fCUqDymq14KWTVFTg+hx9c8o8GrfCqEWV+ucxnWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyEpc9sESsoGt8RP/VhSH507/fPckWurvU93dk9RKV9lzj9RG
	P4yihR2oMTlmuyON8K+ofxFJa0Yz5pDPP3Q19GM6nbHTSCSpgtzhQ3BgNGWw2zGAtbPd8JPrHOJ
	iXTxR/TDeFMVgBRLO4RWr3gq/DeY34/LR975E9cV1LWrxBI2RSabWmyLrkvWoVimCbr4=
X-Gm-Gg: ASbGncs/TRcnvAjklMCsK8Zi0lgybWJNVrfhV36y4M16y0d/7wXhmVG6tJ7Oa/jAxyE
	q9dCswO2+jMKgwy84VO8pOBHcsnkjpGvVg63OFyBSh8Q6+E9kUrJD111V4ISZAVwXMlLqhyZbNd
	8TDc0Zb11hkaHyqOtJSEFurQILoyvpwSlolm/XPF7Zy/FirKtd8IfP1FcELYOzHLdbrdfDaodtR
	epumAYKxiJ3r0VX2ARpeAqN4OIBXlblhofOPFGXevrhivDDpraQ/fpTLPiBhJPXWkGZEDwdssF0
	Kg0ezSEhv2eq5uekVMMohBxAKVareggr45IxWhdRj24HsljT+WIsbA==
X-Received: by 2002:a05:622a:15c1:b0:4b0:7575:7de9 with SMTP id d75a77b69052e-4b2aaa8127fmr25925481cf.29.1755856850154;
        Fri, 22 Aug 2025 03:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHlmImglh7kCWwqglLr0kKxfa+uA2dLapDHNyAD+y71j9BoiZKNNUVT2fntTr5vj1sI7+2Jw==
X-Received: by 2002:a05:622a:15c1:b0:4b0:7575:7de9 with SMTP id d75a77b69052e-4b2aaa8127fmr25924861cf.29.1755856849508;
        Fri, 22 Aug 2025 03:00:49 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0748797a1sm14184608f8f.5.2025.08.22.03.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:00:48 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org
Cc: mathieu.poirier@linaro.org, srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/2] rpmsg: glink_native: fix leak and cleanup
Date: Fri, 22 Aug 2025 11:00:41 +0100
Message-ID: <20250822100043.2604794-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a83fd3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=nIwsDuCTDOBSikEnyD4A:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 8TM3hv-UbjslIs-GKv0Iq9DDjACBBBkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX442hifQW/fLK
 0pXs1qd24DC5InXTgwwYctaTHhicEDH9GseqHFZnPSBva4ZZh6tpNeCT/PY/G5osGi+N/SmSa/+
 b/jcbLpE7/qqZuImnZKIZitk4+AZSbVHv8pE8uBuFUHqXC4Qxbaqq3H4S8LRyAG/vVq3bMZxES+
 LkmnUnwT+BkrxHLCnfYYye/3L1gSMs6dHiuPoFIi+CM2OltTsIq6bckvWH4Bd3ZjCxXP0ZcaWlZ
 ggEyjXlb8/QEE/YRZU/Hmv23fAnCXc4TlGz1dfIlBCMRFnYBU0ptXWFcNztbg0oNLqbhD1pE58q
 5q6iQfh+yHDKb+dOJiYVEkcRrATKXIeS6SJnOZ0hAIDfFbLnlLAoYEFNRzEwqRqO9ueKM4I734N
 T9zXy23+F24i2XiAVWAhNhIWxCuEpg==
X-Proofpoint-GUID: 8TM3hv-UbjslIs-GKv0Iq9DDjACBBBkl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

This series fixes a rpmsg_device leak in glink_native, and also adds
helper function to remove some code duplication.

Am not 100% sure if this behaviour was intentional and not allow
rpmsg-char interface to work from glink_native, but by the looks
of the code it looks buggy, which is why am sending this series for
discussion.

Srinivas Kandagatla (2):
  rpmsg: glink_native: fix rpmsg device leak
  rpmsg: glink_native: remove duplicate code for rpmsg device remove

 drivers/rpmsg/qcom_glink_native.c | 35 ++++++++++++++-----------------
 1 file changed, 16 insertions(+), 19 deletions(-)

-- 
2.50.0


