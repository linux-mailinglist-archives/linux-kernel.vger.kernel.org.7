Return-Path: <linux-kernel+bounces-756567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13417B1B621
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53A81883982
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8197A24168D;
	Tue,  5 Aug 2025 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jW8FNLd2"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCB45C14
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403094; cv=none; b=LKgPjJerXB8N9xOBVNK5E6hqR/kzKPdl4IAS93Zke77CRcNRXE+NcrsjQePbzF704zrRAXaKsBu8I/g43Zf5lWlv3/vEYB/Yw/AG3hp9ooiJ8dyOXd1oM57UwbAjWPJswKMYEYpFUcJDJFMqz46na0BvBkF7zwy4ek2JhW8aR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403094; c=relaxed/simple;
	bh=IYgEcpFeO8meMYKSnmukPEFgtI0jqdznv33bvgoSyVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nu4axXoS6/MWXHh0p7Hu5fPgLibQdFmDK2lCZ61qe0HjFvXYSKci2kEe6qcPTIGZ0HHY9sF0RHdEpex6D1DEqbuXZ0mjKzrWpCLxMr/DQZKySBXt8R+jAzZwabU1JHhXP+OXBGGLIotRtP8NzvsSylySNqDhxk3bBfYxhOxmBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jW8FNLd2; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYQMa015353
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=0EgadbzFWFn1SADX7rxPyTXaH9CqFEpnv7iy2CV3JvQ=; b=jW8FNLd2g9yg
	KQHSje+hlknuFCtr2M9hO/QmqocrqlLmB375QV+vBqkSldSTAeuyMs0d2IPfoRsT
	QTFZ8/2H/f3BviO7y2EU61mN2jYm+1hxZnxG3Y62x/I3K/zPna2bPmAl7Ake1chS
	ZIUCLyM5kJG/kbp2D/DU8nOqSX/9mqficB6zOdA3752WZAO2GXcs65Me24hMGbg2
	3k3TLP9O6SqGlnJWmXwK4peuIW+ioIqTIszEBj6YLQTiYkBwFnztwU3QjR0NNM7n
	66WV27itfPzETe533LzI5RY3A29SeHXFJiKy6JdP70zUB+N1N2lS5uE5O/T497WZ
	ElEnwKJ0nA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bdg9aay0-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:31 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9BF1B4FDD4C; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv2 1/7] block: check for valid bio while splitting
Date: Tue, 5 Aug 2025 07:11:17 -0700
Message-ID: <20250805141123.332298-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com>
References: <20250805141123.332298-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dLymmPZb c=1 sm=1 tr=0 ts=68921113 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pNr_mRkOCfeHtIxF0oQA:9
X-Proofpoint-ORIG-GUID: EEqsb0VV0Q79iCQCViRyrf4T8AImb3R7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX0gLwBJZVdtEG gAfGDGxmX5DQ1JKfZiqLwm0SpB+O2p0RmczpsRtVs+OTU477+SxsY52Z5Dz2XLP2VSHzdFOXcoM gjl2jJia8uOct0dfeJ1ucUfwrd5mNEFIm1+iDxdF0wiYp4oQWGPm/2gnfOY6yBnS2tmdsPKKT+P
 7L2r08hTiM/kXPorKMKNIKuVP0OIxYxHfzWbcn5fIsU6u2gweb6mh4y9NP/9+iSwrfYR6CrzWkE crGnfqUnsMoOH63hDrFgqwaO4pHXTbdREjqeji0HYvC8f4wlCQpA3J6zFR+nwmQdWAhp7qUUWsV 38kT7NCL6z0gUz6Sdd2qfjN+AtDTQ4g2NNZSC0caZIFD0p521roimS4DlzmWBcpurgWAcffHe+9
 YW7jsgh4/32LHu7PSDBx+p2Yg60R+u+By7coulfFnUT/r8Qhz/ZuTirARSRHc25UT9HLNHVl
X-Proofpoint-GUID: EEqsb0VV0Q79iCQCViRyrf4T8AImb3R7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're already iterating every segment, so check these for a valid IO at
the same time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-merge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be52..81bdad915699a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -298,6 +298,9 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
+		if (bv.bv_offset & lim->dma_alignment)
+			return -EINVAL;
+
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
@@ -341,6 +344,8 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	 * we do not use the full hardware limits.
 	 */
 	bytes =3D ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
+	if (!bytes)
+		return -EINVAL;
=20
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
--=20
2.47.3


