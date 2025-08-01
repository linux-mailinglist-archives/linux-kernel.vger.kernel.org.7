Return-Path: <linux-kernel+bounces-753892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15CB18991
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDDEAA652B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7DD23A993;
	Fri,  1 Aug 2025 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FD+ChOYW"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B002367A3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092071; cv=none; b=lwo5NZj5+5OProVEg4TvKMmZTZW47MzwRIuGnIEQBctREVMa42xoQd0yx7ecMdvMuC5hc0gef9dCNM4kyWF+VMLWHBHwkyKmiYIZO75WzG16yhFyQ9femd7TK+ODMfTw/zE5WTiihTFDeV6W937e7EDtg6cIuw2ph2y7xLT1Zmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092071; c=relaxed/simple;
	bh=yawt4GLbtfkvbaUJZ5kOUtqrePnmOrCGb6Kso3LofT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ahv9CEAzK062io8GOyxK8tyXFh1rB1p2bIFtFMPn+FgWh9ik2FwOFLbWQK/JSsPZ5dIo29lCrcuIAkfpufGyFGWxmPXNe7/T2hCDqUdSGPNRsWqhsHrtQR/aGrwGIg7XRZlFpfAxj/onIyvAV0rtGb3ysfcblMs2cwueBVAKd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FD+ChOYW; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571MmwJA011331
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=G6dqwmMmZJ1kXj+Rc/
	2AKaMeSpGPdARz82Yt30s8+pQ=; b=FD+ChOYWqEK2YBnwRv07tSwOyB6n8eQqYY
	9Zox2wW1TdtC8sJ4BKDNjHMzybYm1PhkjQfMfH/YF8NCGhS5WxjSKyex3TnKV5Go
	7gbty3fLw4n1n2umEItsaGeEANZ5dszsFEh5KyTzZMQPISIto6ef3GjITGn0cZh6
	uhjMRxLM3iL/jNcJNPEy4j8z3qfs4iZyIMPNm6fVucHeAaHLoZV4ycBg/53CSRRN
	GWadbufG8EBo+Fb9MBn82PcqZMtu+XfGVxq8qN4WEaxGjHuYIgbJHh/YIdMUOTjv
	+yRal2IqRTw0zAYJScpWu317u8IVXATxbc1CVQNzBIlPXIvfwMoA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4896dc8ap0-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:48 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:45 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9C2BA3105E8; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/7] direct-io: even more flexible io vectors
Date: Fri, 1 Aug 2025 16:47:29 -0700
Message-ID: <20250801234736.1913170-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yTYAiu8RgjQD8zpFR2BvuVeOmbniPXam
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX79D2/VneR3LI nAPzEiEjwywKH/o6IfBjoRwvByiX6A5mha6HymGJopsd94bhxBPo4408Q2bK0P8UVANOg9yKe9D znABfsac8enFN3UOgNdP6BIHa2ilvLDvAc+jiFt2FNCtAEsEsPHXGXpdpTCjtjkm1tqqZfxNbXM
 ISPZhRWlzzclMJjUe9NzNLIaBQbV/cqyUPDzImihmkkB/TmdmWo23X1UR84RJAxNGoeWkVm2CE3 LZHaekNIlbdu1F5XS3+veffO5BtANU8kgvtP+k7h0cp6455q333GOyMJXelexWN1mJNhH0DFSsY ecfyZeQk2jLCiU7nwP6ADndFYT5CAOUtUwO94FxWrMAHcKpJ2YkoGqhjdzaKJjXxjzUKUrfjIZY
 JjJeb/HOP+UHh2zMmx41WrjTcfokIlmlILodcHCHusOaBZN1jINl5tsYALFUUyTbomv01VR5
X-Authority-Analysis: v=2.4 cv=Ndzm13D4 c=1 sm=1 tr=0 ts=688d5224 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=TzghJXyiTW9mTth-5jUA:9
X-Proofpoint-ORIG-GUID: yTYAiu8RgjQD8zpFR2BvuVeOmbniPXam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In furthering direct IO use from user space buffers without bouncing to
align to unnecessary kernel software constraints, this series removes
the requirement that io vector lengths align to the logical block size.
The downside (if want to call it that) is that mis-aligned io vectors
are caught further down the block stack rather than closer to the
syscall.

This change also removes one walking of the io vector, so that's nice
too.

Keith Busch (7):
  block: check for valid bio while splitting
  block: align the bio after building it
  block: simplify direct io validity check
  iomap: simplify direct io validity check
  block: remove bdev_iter_is_aligned
  blk-integrity: use simpler alignment check
  iov_iter: remove iov_iter_is_aligned

 block/bio-integrity.c  |  4 +-
 block/bio.c            | 58 +++++++++++++++++---------
 block/blk-merge.c      |  5 +++
 block/fops.c           |  4 +-
 fs/iomap/direct-io.c   |  3 +-
 include/linux/blkdev.h |  7 ----
 include/linux/uio.h    |  2 -
 lib/iov_iter.c         | 95 ------------------------------------------
 8 files changed, 49 insertions(+), 129 deletions(-)

--=20
2.47.3


