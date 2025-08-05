Return-Path: <linux-kernel+bounces-756573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6DB1B611
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE07623CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7227B4E5;
	Tue,  5 Aug 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RDeEiszB"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2127A455
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403107; cv=none; b=MG6bOeBcjn8sstt5pkYeZDjvsa6p1cTs0XX6YO87aFsA10pkH1Mpk9MwSLhA2AHgH+rWn2vnwDMLs5KuK+uoPSmml//qUjX0oDWos6AjWU0j3CbdkyAUD9p1SR7XGcppfBfAeef1EOoRcL2AfOnpzPjCYbfZI+7DFMO4Zz96M1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403107; c=relaxed/simple;
	bh=Kdc9xGN9AcSWoWHghDPfa3FV5WggL3IWn9sG9vpZcFk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nKA12RigBby5LIhbstNgHtuDkUfAaec8CPUvhtA6bdqEFXm84AFHOrOxYP8k2NKV82gGCkDclSeUuULRAHBG3YDiABT6L8v/1oHm3Wu41l1Sk6WehCjmPVoPEbwxAu/SSKV6b5uMrcc5XhZHVxB3Fzdi6utI9M6EnRztOupmD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RDeEiszB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYGGq013135
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=nxCXPs3DLBfSPrI4Om
	DSE09/Da+yCPHrQnIW6i4cpmU=; b=RDeEiszBLEs3Ehvfc4KicGGhML4FbIPXDK
	LOWg5iXH5rK/eAe2cyJGbfTynbFAj+th7jBJwnM+c4pQjTwU4DY2jZtBLE+0Axnf
	TE+APCs6zbGjqna2vYbyxB+KqVjj6pTGzu28guYQZNGChfgMnOUCt4SQnXkVE/iN
	iTTwzorfVJxOwNPoUdTBQB4AE6trJq787T14A3FddPnYGp/qGGDforTrp5+oiKii
	yugagW9621qwurYuQja0rlWYpGgGIY9MKa5hhCSAfC+c18IX6gIgcrgHv6d/Upiu
	gVi0o/ZmqSpQWKp4MzpmQ7DOOiEd5wvb3Z+2tLKJY6xT85DVnjMg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48b5tacuc3-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:45 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:37 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9AB254FDD4A; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/7] direct-io: even more flexible io vectors
Date: Tue, 5 Aug 2025 07:11:16 -0700
Message-ID: <20250805141123.332298-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: OjQgrvRzW_EMtPtuPHyMVwHiX4OW5Sia
X-Authority-Analysis: v=2.4 cv=RJOzH5i+ c=1 sm=1 tr=0 ts=68921121 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=5bCI7YQ4g9DT-SdEb_oA:9
X-Proofpoint-GUID: OjQgrvRzW_EMtPtuPHyMVwHiX4OW5Sia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfXzkSd3I6BNdS5 hZYYgJ9h00xS9J25+ojT6HSEuAwsfOfQaeFjU08VlNblorRvqoJDfzYIvyPUvD4pIGyDxTbKtIv qLfKV9HCvk2EZmJLNxEwzhRsJSTu6zokhqCHg4E/V+gXxc/eeiH3HrasU3jKnWBPXQT/+yPs9p2
 3zIotr+F41a7Drt/Tblr7m3lF8nNHohschpuGT/Qla8mbz1U7Sok5sVGJ/6alox97VIQmirk6Dg JW+xsVR/kxAOzjGWHLtqSiJSAfyVKGxBhG29JBBKGwIa11GZqh81SEVAmEosHz+9VyRFqgp3c5s K1fKdHjuMfGn29a6vo+N0ZNYy5bTVJnW1k3RYz/pRdw+BLI5HZ/qUp8PiAv4whT0wc+/bMCYWT6
 nBIxJy0iTr4MjY12sU5WQhPkF9V0yRa15fbwLvUmVf0HauHCbcGdnSSlNW5Pzx2uX4tiBPNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This series removes the direct io requirement that io vector lengths
align to the logical block size.

Changes from v1:

 - Fixed the return value when attempting to align a built bio to a
   block size multiple.

 - Added reviews

Keith Busch (7):
  block: check for valid bio while splitting
  block: align the bio after building it
  block: simplify direct io validity check
  iomap: simplify direct io validity check
  block: remove bdev_iter_is_aligned
  blk-integrity: use simpler alignment check
  iov_iter: remove iov_iter_is_aligned

 block/bio-integrity.c  |  4 +-
 block/bio.c            | 60 +++++++++++++++++---------
 block/blk-merge.c      |  5 +++
 block/fops.c           |  4 +-
 fs/iomap/direct-io.c   |  3 +-
 include/linux/blkdev.h |  7 ----
 include/linux/uio.h    |  2 -
 lib/iov_iter.c         | 95 ------------------------------------------
 8 files changed, 50 insertions(+), 130 deletions(-)

--=20
2.47.3


