Return-Path: <linux-kernel+bounces-887809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C794C39233
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A62B334E902
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3832D73A1;
	Thu,  6 Nov 2025 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lVuEwHUU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M7cJNA1d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648862D238A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405727; cv=none; b=st8oDeYqo/LOJ3CXRO018MX4XGaGSjr9uaXMPmI1luZszky7HNZDi8mKsqFjZ8CAYVwXG4LuJjS2iTYyXgqOBAKVmCbZ76Bpwr+l7g3QXSBbTTaCIIPQUkxoNqcICLvCQA0MOvSM1gYbAkH4RmCYGP349gsXiVg/qBhtpTtEZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405727; c=relaxed/simple;
	bh=kAMlOZNIa69+aYnHk+Llog19LDYIyNmwTm4M8yFItxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZZflmdxYbn19STBgMhHPN4zkd6dcLPqoRjTgsM6VuP2tfRHU4GFi9jqusCiXRLBWERXcdPe6ILVJum9bVf8HB8pmqwWcPXLkzZq8h8+CAX7bZv+SjKzgQ3nlefVZd+o/stNGtg+aRX9zE2g+xxD+QyOkZc76+jUE6b1Lw0pw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lVuEwHUU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M7cJNA1d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A60IJtn2326929
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 05:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=r8L+4z8APhk7U2v3WAHFQD2xA6qb4gja/TO
	OH3ihkxg=; b=lVuEwHUUTQ7RPaToFb7JlKKPvAR74HZAzJw60/9R+9b6+huNx2F
	YM+FKckiFOAHyrhsdywwvuJQ9muXCCUX84NF3AmrZZQ96a8QvqbwwlKh5BRxiQH5
	TgSslpmbAER3NKcp7BljLHlumdjW0G2S7LzqMhS81i7CCz8Dkx/OFxb0j94DJ6rZ
	n9C0wxOmtISuM7jZIy6/8EOAa/1cAFp/l9JEcUVSNWaViP98KitgUckb+qNBYTuJ
	WMjeXZONHmoeXJExP2iHvSmHM/7XN+io5CAHmJKR+ZtvwgBZ3aOJUfHG7GRYNUFc
	ISFi+eR+WrfCvP9SW5trjQ9dyFQdvoa4oLQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h0v0p8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:08:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290e4fade70so8832665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762405724; x=1763010524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8L+4z8APhk7U2v3WAHFQD2xA6qb4gja/TOOH3ihkxg=;
        b=M7cJNA1dJL+530Vv/03hjS8G3RBqQl7qqwMjEOK/2cx8dyv7rtbl4KYlbewYgylC1i
         A2xqSRQ9H9wmcZ4kgvYMOUkdox/Yrg1qqOqr9j50GS21KbTlY+KJMxgyOZJdUW+eRHWK
         phlaYW8bHCVr1edCn+GY9CP0UBTquXvLzzczDBhJDUAPUNMAChGuLLS/YDbnWJj29FiT
         tP7UaVLmbzIQRGNVSin6RbTxllP8u8dKqtDaHk4WgetaP6jCgA0wg6J+R+zlS5alwggA
         vfXN9gS9SccamMli92c30qieURlwKp8/RzbmzoaIPAG/nuxzTxxgYD3usxfqfZ62v2H6
         ic1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762405724; x=1763010524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8L+4z8APhk7U2v3WAHFQD2xA6qb4gja/TOOH3ihkxg=;
        b=OmCqgvPr00nS2g75M4QcmDqwiFdrhztXPEBkMJpylCfdVFYvf7l1kj3XvWhxXfflvA
         kBVQdgx8KzSTo0COwRlcoo4op103VjVjifbRe4BxTD7B/Lf8SHbz7IXJbvdzVTBbDgC5
         fKOGMR07Rfo/aTQvvz6j8WdXL3vWIwSaPCWH6LylQK1sKCFuId7WpuNzfP1aClPMPLvo
         hhLR6ASclFuWO+MpnGQa5IoCz4XNjLahgi50M/bTcsyE9MInYGYFhW7QHEj4i6KDXXE/
         E/4tmPHsZRn4qU03JUjIHuxXITNYYEuEnk5gpfEiBxEMIXo3aJKXlRvBCiWCnWFBIjud
         yq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVodp4kr0vXCk9wWaVeJjoGP+xzlO2+35JNwrXk6OEWZD0ESXP2bWIwpgX9VUUq6k0NYZmVCEYZK8alT8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaFegJi+1OFH+AcK9nqoVwC2ilvIeJ0i/xWOzz1pfiaTEDduW
	DjeP+Kz4R8rS5GDbHcd54IyCbWmltbW72Ay2MrShQ4iKOD8Rwqfl+OGxnzp3mxj8Q59CyzNtC9c
	jIAU1dBFQNbW9b/BeJoxiSeIKlWIvt8shzOBTpYrUdGtKQo3KTajHvjbzxc107mhEghY=
X-Gm-Gg: ASbGncvRG7cKcIwfNKtcxKxGJmQIuDMrhG96nAC6F+OffHH6dVlg/skbgXq2vLacNQv
	4AxaV8qeGk3BQrH/+X54Zp9jTrsbdC4pmw7VXznS+kJAnWmH9o9Nlb6iiqmniIxmSxwzGGbzt3h
	vZjrd0baN50EzOc2oBWg/gEMuNcUYl4cfbB0DXon9hYAokZxAC+bALZjHD676Ll8+pVfLotoFYL
	038wLsbO+DULDVUrUJnVx48kdVkjsufFcwYaBZASMDy5kSa+zNQtokOecf0OoMc5rZaie+2mW+b
	AbVLGiMXWmOelHrUMqDNDKEJoTgATgnviqhhovjxPY522WUzBU7Kycdzb/QGrBL5WOzIeeduObv
	NFzf8z1SWSKBe4qXtmkHlaIar13RnUjg=
X-Received: by 2002:a17:903:32ce:b0:295:8a2a:9595 with SMTP id d9443c01a7336-2962ad88c0emr76617605ad.39.1762405724033;
        Wed, 05 Nov 2025 21:08:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH2W7Ox4LBdRQy7Jqcvx8fvhElVG278cxX9vJxU+qzFQyiFeoBJXgP1NGiLANNDtXNF5uegQ==
X-Received: by 2002:a17:903:32ce:b0:295:8a2a:9595 with SMTP id d9443c01a7336-2962ad88c0emr76617305ad.39.1762405723578;
        Wed, 05 Nov 2025 21:08:43 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd5238csm1185862b3a.17.2025.11.05.21.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 21:08:43 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v2 0/3] misc: fastrpc: Add polling mode support
Date: Thu,  6 Nov 2025 10:38:36 +0530
Message-Id: <20251106050839.3091707-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LlPEXmsX68jj-HZHvtlWMi_u-uQI1Dzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAzOSBTYWx0ZWRfX0F3bAVBG4BaM
 o0G4gS0MS6j51SkqVykz8lUFj8iEfWe5x6dbcbuk2jp5k2hPnvJOOPXHPUFBbeBgIOaJZ1rWqBW
 i/vtR5SPCTzSlEdFPsKcqMk55aYigB8uhgdbQC71S5RODT010cayghLozndbtuZIf5m+ydQMtZ5
 xxGOXiZ/RKQM1LVuA2T5XOGv9OlFL1nWSNPpArh7VxQyF2UlGdygd8JMJGhvoGlDdwB/XWT7cQl
 e65dzIYEhrPKhGi4d4snN4DuBikxcOXqBmTLNaZkXhYVxGPEzYvf9KmGkUdD1IV6T3lnJFSuvHe
 EQ3EtDopA6j0baoWRj9P+kHv9j8dBIKbXJc4giDJ6WPEKCsGqJyBLPvCeVZRLnjn+bEyp/aVu/U
 dy/sUDE1kG56/bxbWCziIPN9/kNI4g==
X-Proofpoint-GUID: LlPEXmsX68jj-HZHvtlWMi_u-uQI1Dzg
X-Authority-Analysis: v=2.4 cv=PoyergM3 c=1 sm=1 tr=0 ts=690c2d5d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dFrkBzGdCdqBpI6tlPwA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060039

This patch series adds polling mode feature that have been missing in
upstream FastRPC driver.

- Add changes to move fdlist to ctx structure to avoid code duplicacy.
- Update context mask to support polling mode.
- Add changes to support polling feature.

Userspace change: https://github.com/qualcomm/fastrpc/pull/258
Patch [v1]: https://lore.kernel.org/all/20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com/

Changes in v2:
  - Added comments and fixed commit text.
  - Defined context id position as a macro.
  - Added new IOCTL to control polling mode as always enabling
    it might cause excess power consumption.
  - Cleaned up polling mode implementation.

Ekansh Gupta (3):
  misc: fastrpc: Move fdlist to invoke context structure
  misc: fastrpc: Update context ID mask for polling mode support
  misc: fastrpc: Add polling mode support for fastRPC driver

 drivers/misc/fastrpc.c      | 163 +++++++++++++++++++++++++++++++-----
 include/uapi/misc/fastrpc.h |   9 ++
 2 files changed, 150 insertions(+), 22 deletions(-)

-- 
2.34.1


