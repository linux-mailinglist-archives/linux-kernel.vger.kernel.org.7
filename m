Return-Path: <linux-kernel+bounces-782501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BFAB32153
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E370B1D62B36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5DE321431;
	Fri, 22 Aug 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LNTyIhAz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08027702B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882905; cv=none; b=Xd9094YSx5sEPdzYNbMSfqbZP301FZVm3MYHubvtdn5CGJHubPvjuaqg/ufjxeRkqaIbvN5o8ZKNUXHBG9/6Qd89oK/0C/hmyxBYzxke3GwBW2CTJ2u3E78xtm+i0npWuW5DX6AWrSf3KH+MVXPloX1Oe2NoFUFd1D5nxkTR6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882905; c=relaxed/simple;
	bh=N2Nzu38480ZY9bDOWfT3LEIg5OyITg4DXgjnMztcw44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KiPKL7s/0yRfOw3+ZNGwY4x7jZf30p8goNeFvt5u84835PKnTG9iAFE+CfjeLdUMAuTddIMZoRzdnjq9UCk0mi2n5cjgqMe84uD48sxhoyURWuiQ4f672ijY9C2Kh0hdgBiEy63rxDm0IK079BOZvYaLlLPlroLYL0ooajfJQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LNTyIhAz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MGRbv6030407
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=y1e6gV5g3kH7KN1Jrp5tcsFg+d8ORPB9zZ6
	0/NMHJ78=; b=LNTyIhAzcZfPVre0304ILSXkXOGN4F2JrDnli1AQdk/snrpQZ1Q
	pECCwsE/mU81PFc24YeJU9LlWTI2gZAj+2f4OhR1AuLsZDbw7uSs4lmwnNzbLaIL
	KYuUt13EPhZ97TdFvIvEmeaXrqYsiwMWBwKNVGwg4FuzOCQC+XggfeW96BRZMKMn
	7cZkYhQdvEaI3wfaseci/WzJ3Xl6AHjnmQ4Mfn2wskAyJ0CwPmOkssgQN2zF6EU2
	m8lsTLYLZm3GQG8Zseh9vvqzbs2Axui21IWc69LWYIPN4JOT0Y9DB5bK6Pnv0Q6V
	MiYmEM+jJLE/TLpfltDH0AQ1zsdV4p7ia3g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdqu5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:15:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e8e28e1so5631634b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755882902; x=1756487702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1e6gV5g3kH7KN1Jrp5tcsFg+d8ORPB9zZ60/NMHJ78=;
        b=Ygk6MLifd8ma+XksJcLaeKfVHlPZl2+eFyh5sl66YBT8oirrNNjmWz63kCjvtbcWrP
         lJ9YTJ0PFMOyYo3P+ftD6HH4xt4B+bB9M/YDQ3gbi9xXgkt5Uo0VPm6FSEgSoxIn67H+
         FMtCl5l7xgGQlCJnM9/sVsQu4alOKdwHWYdHLhOhX+E7lwuuAbDnanWw90ikNMX6sbP6
         tUS6IfXpeYOqjiQ6OLi20S5b6/UZGO7tCIJjb+iBy0m7ICwmKSnd2oF9GUJvF7D/ijqQ
         f3Yl0jnEPH4xkiPsEr20qhP5Q1Ep94ne6+MdSA32AnkT5T1VwAWuo+nfu7QImM9Y5iQh
         yAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXd09cx24rOhuZ67VhGHNLxHzjcwGQQelfS75HVIFIMX6yx+SbBGXa0oqMO3x5g+cNYjQDysbxeCSvJELw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOplLZ4Pgc7MI7+fRuwjh+mQ85Pj8w9lWVqcavcpoQh+MBV80
	KYfpFDg5Rx+sZVT1OYSGuofE8gNF1cH6rEqHUaO2xj35Ocig3JIvCkZSi0+7rkSocup1ELH2Wx8
	vwVF5ecIFHRdPhQrbnyULJztnaBVjVhUcT1K0hE+2sEQpvqmucKM9TiaEXaxuL+fX1Nw=
X-Gm-Gg: ASbGncuNo0bztNf+lvwQmrm9jHQME96TxyjvQrjABGVXnp8Wk/eaX5wh/Sq+Ebiw2HS
	/lCcrNbYFPOrHk0ZQYFhOhTHV1JZf9PDE29V8tvNiQs/nvEm4bcMmMOXUUJiEVq9nn0Gd6MGs6H
	NIRDPK9Om7KYutl/53Qa47++qpSdhJaefYhVRavdQwF4dIKQihV/BN7zwdLVJnJGp8kji3vp0D5
	FxWo68EXCQU/te2xWNJEixCJIoXgZy0O1Qbx/1U3GhJWJXmw0+1nH9tgxyle8p4DgpmbRPLJphI
	PkUwl06yNPtfWLf5qQAvUzwiAnf7kWJXY+NMKtoGIsIJhNqNFehobMYqthyd+yMRQturOt18gB3
	8
X-Received: by 2002:a05:6a21:9994:b0:238:351a:6437 with SMTP id adf61e73a8af0-24340d1d2e0mr6022883637.43.1755882902089;
        Fri, 22 Aug 2025 10:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ2zJtVjuqIcQWtyOtIV1CzUmatZvFMwyY8CPoIo5NARmcWXDhSRRl2SCw/GI820eaq/xb4w==
X-Received: by 2002:a05:6a21:9994:b0:238:351a:6437 with SMTP id adf61e73a8af0-24340d1d2e0mr6022812637.43.1755882901649;
        Fri, 22 Aug 2025 10:15:01 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afc56sm309995a12.15.2025.08.22.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:15:01 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
Subject: [PATCH v1 0/2] ASoC: qcom: audioreach: Fix lpaif_type and WS source configuration for I2S interface
Date: Fri, 22 Aug 2025 22:44:38 +0530
Message-Id: <20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a8a597 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=ZqeqJFRRshZrXyHQ3DYA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: hpkYjgMsIYC9CRPaefG9mKUioKi36TyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfXwJ3/70tZBQ0x
 ileGQefw4u4raA6C1RDTLE0xy4yGW4hxEZWjkA76QIw750FTsWAb9Tw79pxJZisdzEoV8Fy0LkB
 4Fxc4ntswMOrcOwxgR81N87EjcNl+xOnGmvjk9FIQ/qLPdBOE421fzsu6BUxEPuWOy7tYbHQOrG
 pJDK42YdVjtt2i5v2mdmmuMdlKYMsnfLMSNwByiBvLLwmbLGCgcNF5zb8fCYW6lUSb8Ogc815WL
 cTKQkAg6nGYwVqvNePgDv2+mdtaoQ6ekJs23AelnPcBVeCnc6EB1IIgsG8Jb9jdgS574MV39IXA
 kVgZL2z/qLwgZNcts1KkGX+OIuMlYXgq4ULRIXQ2F1aSWLFbwh0Vkia7diquH60rkT4zwYjTtWy
 oRYduBZDU5/578mnVmBsZbk+HM3jNA==
X-Proofpoint-ORIG-GUID: hpkYjgMsIYC9CRPaefG9mKUioKi36TyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

Fix the lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface.

Resolve an issue where the I2S Word Select (WS) source might
remain unset, which leading to misconfiguration. To ensure proper
I2S interface setup, a default WS source is now assigned when not
explicitly configured by the AudioReach module.

For HS MI2S interface, the DSP need proper lpaif_type and WS settings
to appropriate I2S configuration.

Mohammad Rafi Shaik (2):
  ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S
    interface
  ASoC: qcom: audioreach: Fix default WS source assignment for I2S
    interface

 sound/soc/qcom/qdsp6/audioreach.c | 7 +++++++
 1 file changed, 7 insertions(+)


base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
-- 
2.34.1


