Return-Path: <linux-kernel+bounces-793821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D460B3D8CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F2B3A8D21
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C521F37C5;
	Mon,  1 Sep 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UNSYt1eM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97B84A2D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704825; cv=none; b=RqJd+mQtcPoMaS2SxiRs3wCEGv5PGW3MNdeREE87TJIpbXJuY3RAPZOESGL72WKzwkPz2z2IGZz9N+nrNGTAD/SK4CAR5I5El+0SxqO3ymrMkdUM8ruxbgY4kq3NdPTDzuIo6QpMR0MVW6DZ5AtCgTFMCyI/Eq5T8PdKxcw0kRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704825; c=relaxed/simple;
	bh=pN/xGrUePnKxy/4KHL+rTPjWD8KshGCJTqUvJaoyIm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AQMarZVpJUIga97xDMbMHvVOTttwPBVVS+PnNOCfzsxSALK/nMo+yeu+n1Tf51tW1Jufu2F3U8qdmCrzasr57BNqstaDuJtSzmWjYBQn6TeHNGX/7KfgZ8UkpPGWMSJJmi7nfnpoC+hSoNQnkYcr2uocqcokUivPmhgYsIcE6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UNSYt1eM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5810nj0w029671
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 05:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5Gj2fHHRocveNDazOUaXByhIdsQ04V2LnYy
	pYBX7Xjo=; b=UNSYt1eMUffl5Je3IUB9dBx76rP80PA92HfPuqDlXM6uDgiLRLa
	5x5KfUiCzlzBLMciXwynnq97r0hmx8ZKBkcp/b5Z0iiVf6SrxXP0hg0MCnH58dt7
	aTNOPtKA0aXqE96x+OmxgbArAkeTd0FzZQLRbj+VTT7ST9BPquydqM+urEShdfXJ
	BRSbYTQfCbmREhohkJ3KSsNTM7u2Ir+744cyJRW5T/yQ9B0xHZF0P6skiA2J+CTw
	kBMb1IQ2blZnvnQl3bgOif54UvwPG6DMVgho/PYT5XxJ+d9oS/aJo6+Y/uMMZ/Rj
	Kvuk9AL9fAlztZ9GwxCX5UYj1l/1SzyK4Qg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp3hxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:33:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24aa3cf81a8so14235915ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756704821; x=1757309621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Gj2fHHRocveNDazOUaXByhIdsQ04V2LnYypYBX7Xjo=;
        b=oYmJPDQneq0HuyfUD2VNbfNtqvz+P3hjm4qZhLnO5PxFIGXw9FIJRabnSSNzzn+06B
         zwBoXL0C6bfaMovVQuzZRuop9nf6+jPISiOgQ3mjuFsJoBy89iXQ+XP4MVAsT65GdVj7
         wvqPiMbqKKv9akQIrtnYUeY8eqt4fB/syopUicmvdbfSPV8ZISvxbG39v7jJXfacsMbN
         UnBtjkmFt68jpTWs+++8af3ZMJg/vkPSAxIxumWN6qnAdu8O0UP3LP1ZIE0GTDq2cOnF
         yls1AfeMoYs2GgEMVh2XKCDBPJc0jqrr6EysGsSvnQKhY9evV6JPHQE/K6qgZKp3uIbv
         umlg==
X-Forwarded-Encrypted: i=1; AJvYcCVDhV9TPuB64dhDxxaoFOxorX6UwIyE6pT5rqPEEdOlfk9ZY5P30UNTFU4NkALJuRLpY+JkII8nGzs3vgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+lk6K/Htrf6VCPd4AIDIJsMVnN/tp9R9hX2EupS/ziA0iEn0V
	42QUS5LpRBeFzJs+9An53jSZ2bOeUSDHNlgytPVWZSenYNFGZzoRaEBy/Ym7Wkyu/xVayIXKxV6
	UdbsTy8+Lxjlvc4EoaiJeb8+2xTMbopy2CiuGp353cbqgTibJ84ffR6rhiBV0g0JpV/w=
X-Gm-Gg: ASbGncujTNd3NehUt30bpOm+IkBIpW0b/8LHYj8lGgHgNl20UxOLZCjJnlI0MLUAVbI
	ajI3HFXfcpqEXDN1THSIdqNfREW1zG3eWH7+z1XS+mXg9JNkpHqjTkTaDsdUw8tD+BvMXTHqx1j
	Ispt90hRdyy9Cxn0ntWs3WMc0Ts/qAOsrG+86jCnkxRjX/WzXdz4u9KOBF84CzdSQORjSBpjI3T
	aR5h3LIoQdAXk7r9bGAmxJfuxY/oBprEepalyWdtEExDvpgURa9tAdAr6YTk3eFD4UL+OMFcJ2p
	0RSLpSsReisXQdvMgHoLode9+gq776OAPHe6CEtf3rvIiTXYYPFaw+zY6SUCuWDp+MITxwcK
X-Received: by 2002:a17:902:d2c7:b0:249:d3f:d238 with SMTP id d9443c01a7336-24944a1b54fmr104707355ad.27.1756704821456;
        Sun, 31 Aug 2025 22:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT0lCSPA0prHCF1BZxoGfFc43i8lpaZz8hGnkqmiBs1T6OVS1NVSTdRMrSKkgif461D57Law==
X-Received: by 2002:a17:902:d2c7:b0:249:d3f:d238 with SMTP id d9443c01a7336-24944a1b54fmr104707015ad.27.1756704820968;
        Sun, 31 Aug 2025 22:33:40 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906589986sm90575215ad.111.2025.08.31.22.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 22:33:40 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v1 0/3] misc: fastrpc: Add polling mode support
Date: Mon,  1 Sep 2025 11:03:33 +0530
Message-Id: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xMNyRGNNenKjR1XO8xBXkh7E_QKtqBR0
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b53036 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=qQG2SJLAMOdS_Cv4HkgA:9 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: xMNyRGNNenKjR1XO8xBXkh7E_QKtqBR0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX23jn4lr6pDWH
 OWIarbBahOgSsCQZ/CMxA52PDwMAme4Al2JaTnDfwTLeYzOUe9v7ZyCU1ZwPCUnGttOLoWso4Lh
 aytFt2qAwqYoOCefgGWvwiTJUdXPKiK73uW5jjWGS0OFYwO5OAJn3cQw6Ach3MmnmZEYUUi2sCV
 SBTaI3ufzBVy1wvtD/SJZqRrRZwcJQ1sDIUaTYUNasCyERu7lBo71SeiPPZpwqUe2NNOgWcC5LN
 RpfoLDmEsfE1eyWIJTSsQcgGA0194YmALCJBkzVOemNwwiMDbAAQodF0y+sWV2wiBxgfGvHmK2W
 D22N6vWNQwVq7ivQ/8tLu0hOjNcgBYqYmNuq2pkexPBPZNh5lnEzVYMA7WlwMHz+89oRNwKRYST
 75Ysd8f9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

This patch series adds polling mode feature that have been missing in
upstream FastRPC driver.

- Add changes to move fdlist to ctx structure to avoid code duplicacy.
- Update context mask to support polling mode.
- Add changes to support polling feature.

Ekansh Gupta (3):
  misc: fastrpc: Move fdlist to invoke context structure
  misc: fastrpc: Update context ID mask for polling mode support
  misc: fastrpc: Add polling mode support for fastRPC driver

 drivers/misc/fastrpc.c | 145 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 123 insertions(+), 22 deletions(-)

-- 
2.34.1


