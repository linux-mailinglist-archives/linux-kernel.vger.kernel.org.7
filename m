Return-Path: <linux-kernel+bounces-786094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03926B354F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41783A974E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D534D3596D;
	Tue, 26 Aug 2025 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k6MUGUlN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612F280A3B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191720; cv=none; b=NxdTT4wOClfKI0kaDeOchOK11E2fMR3EoHnpwcj5EZey1u1yiqyYg9bk3ZGK7e/afyb7mtdpDJF7/DaOUmsq4uXJjHOjhyDptkocyuDLq0MV3htfcNILiPbIUrq53wK+wwE19Epgr9iJwGl8ovPplqockl3v9+OpLPXdqNcWsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191720; c=relaxed/simple;
	bh=IxbGNRJh6QVdCb092qdVbg5xwq8zrZfDy6At55ft/KI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NrhUoL1GPMrdvM56iDLeLQp+aLMHXNFhCLGshSXlj7S/9uRP8uv3D1dlqsrakqLM/Qr5wyT+ARYOvFmuEOE7uj5AIFElaj9Dj6mvgXWmSnkHjkiH4/nadMx5Z/GmRJBc5AgCqsXNdEdfOsC7WkQAtKDGpvpDorIZmvwzXNvheGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k6MUGUlN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4HnC8028623
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=o/PAU65y+x4pXgWv5a2hPhaymtjDm7AI43/
	Wgvmb97w=; b=k6MUGUlNzMScGMv7Mn+SeG16LjB2/zI5yNnpTkoQXCQrdzT8aqi
	b4emxyvi4RDp74rkg0In1cyD3L+3mpfJaJ1Fva7vj+dnFuDUS2hTukO4HG+A5d3l
	GpVHoKR4XI3Gn+TFp4FaQSdi66SmPoQ2pEocvJ1+r3QyGEaUJv4RX9GAuObcqZCB
	uPnqEW+POyXQ8TvGSQtDi/sngfGhstkZBZ/nJdF6iysPsWDgQF2UCq9k+mMgDBRr
	r2UVsrz/g6qMeJ2MsHWCJk7AA9Gm398+pUpNPDhqGU0MhZj6CIAQyuqkXcf1x3w3
	3AB23yyBDAWgeyd+E8t0Fo1CGQqFW6oWR7w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615fnwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:01:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4c1aefa8b7so1452211a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756191716; x=1756796516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/PAU65y+x4pXgWv5a2hPhaymtjDm7AI43/Wgvmb97w=;
        b=EtRgiSyCi4TGnNFchOgLcR8jWU+5Sor7HOY+0lTa8he7WPwuUpMguUwUZryEcxEBRe
         N3iA5ThUgLj25D3nJdSItI2zPhE8JnhDI1O6O8wNud196q6OMcFe+OO59toj/rXcbjvh
         qf6zIVojaCwMc7hCHLWUfsCZ3n18luL3XxckmxNn/JMeAX7wvUDbCkiXReAeydXRmzgr
         I5KeDQwAOTxQDf1ISK6MKr4meEsyUQZ1GrdGVWAPSFm2sH0UjzNS/Ye80hlcyRvgtpjj
         M14G2uZy6R4aRHNlMaxPNaLj2HfVo23YuIYSKbpR1yrKATYKl+1oOryMaJgeg4PKjaHC
         KQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCW4xugT0MYYYdfwqWswg8o2UFTe+Fxt4dNJ0vA0G6aFCOMEhOtRdxCxWpWSS/etocnmg5DS0M18t4GH9zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4N8CFct0buLiFE/qIysQPm8QXTKZk7JD+BUNsL6KKFOuO+VHr
	mSz73fWBxZD3P2vesS8C4ysjxJBRfsPPGwqJf1nszOMrqAuoNLbEpZHqCbajjQG2Ji1oq8s6kna
	veXcya9Ojj9NiLT0hsIoXCmfIw1qgXAI+B/TMVrbSmty+87KwUfyja5aWJkj+JztAr4s=
X-Gm-Gg: ASbGncsYNkIWjIjqFneJXSjehfnPxnmbOOb/WAdNZkPev9hmso64eH9ayv1X+q45vDo
	SEPeXQJmqKB0jlcdY/CQudJOYMd8sLORQ3aTfbzYc+0GHDmgC0yAIViFLRdfnuVPL+6hxL/GO28
	SM66qWWFWqCy9vdlrD3E0JzADtjDltJuKOAwTvLAlg7gzbz3iHM20Cc2TJNAscVNqbheVykhcFK
	ioQ7K5aeNQ+qDgueQoOgYcvqtRXKKkAcBu8312qZbNGgBbEtMjuQsxsXhTOthaDm2ZIPtPsNvJa
	WmTo13LX+EZfl4DTRPuJ9EEEMuW+qkr+TSus8xWebMksqEpfSzBSCeUxhCnc6v00+I+Tot6BcPd
	QuMTAOqdjhcgV4wIZOtM9
X-Received: by 2002:a05:6a20:a122:b0:23d:4777:49ca with SMTP id adf61e73a8af0-24340db08c3mr20573606637.34.1756191716245;
        Tue, 26 Aug 2025 00:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa1tnLz9RnVmTqVK1eB+6nF3z2owo3uluL6pLja7TFL9iYo1XEunkDWrl2sU66obDXiJuEmw==
X-Received: by 2002:a05:6a20:a122:b0:23d:4777:49ca with SMTP id adf61e73a8af0-24340db08c3mr20573552637.34.1756191715792;
        Tue, 26 Aug 2025 00:01:55 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770b5bed428sm5628582b3a.16.2025.08.26.00.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:01:55 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 0/3] add sysfs nodes to configure TPDA's registers
Date: Tue, 26 Aug 2025 15:01:47 +0800
Message-Id: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX5Nz1tqljTbhv
 WO5oWyDijIjd/VGGlSjt5fZsAB+rmxVqRBAWk0RA4J5pPhJuw1ErQ2hKzPWnEZmuIcdjUSOJK0g
 hVB8/zfdOsOP0tGF1UmfCON/McIZiOAcqNHVwKIZCwHR0DBIsTfERVYX42+2SNWs9ZQ6GGTDtm9
 ZsDGPoNmIIU7jRPzYvEB8jrP2Ublp1t4vpPGyDMucQAedF68Xk1l9lCc3gXQnWH1d2ZtyD68Em+
 HT4pPPZTW3jliCQLsF1A6Fz+RiJ8lkDQiGuM5ZBYx+6+tPc6mF+m5LBdWXvoczwH2qBOiqvlTs9
 Y+yjqPko0wxC8gyeDaOu3QvMFjv4vPbbUv01s7OrdxgB3tb3acdUeZqHiUrq2q7oo7KTIaAWRzR
 U3jjXGXj
X-Proofpoint-GUID: E4QpYZIoDUI12MyE6fmWeMpImdBhpMrT
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ad5be5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=JXyblE0GroTofN6fZGsA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: E4QpYZIoDUI12MyE6fmWeMpImdBhpMrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Patchset 1 introduces configuration of the cross-trigger registers with
appropriate values to enable proper generation of cross-trigger packets.

Patchset 2 introduces a function to configure the TPDA_SYNCR register,
which determines the frequency of ASYNC packet generation. These packets
assist userspace tools in accurately identifying each valid packet.

Patchset 3 introduces a sysfs node to initiate a flush request for the
specific port, forcing the data to synchronize and be transmitted to the
sink device.

Tao Zhang (3):
  coresight: tpda: Add sysfs node for tpda cross-trigger configuration
  coresight: tpda: add function to configure TPDA_SYNCR register
  coresight: tpda: add sysfs node to flush specific port

 .../testing/sysfs-bus-coresight-devices-tpda  |  50 +++
 drivers/hwtracing/coresight/coresight-tpda.c  | 301 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  29 ++
 3 files changed, 380 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda

-- 
2.34.1


