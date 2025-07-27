Return-Path: <linux-kernel+bounces-747053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B0B12F27
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CC13B7344
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530E020110B;
	Sun, 27 Jul 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="pfd32wS8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD819D09C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753611083; cv=none; b=KHwtIAj1GHgJGWrMEkYJBOyhtYj12e+msLK48kiZBskMP7DRtaLTYqoV5otBjUbrZPKia9KmB4Lq1uXzbep7ukm8OlDBPq5CHjumKjOKyZGBmz5iL2//zINRZvUPHFjMv3iTsZdOfNvlfkq6trsdz2mwSQMfkLjADjqLHg+jtu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753611083; c=relaxed/simple;
	bh=vDoZh9aovUBA3yV07jWNh7cQHnw5T5pbReZnHv7y1BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7sGf5BbDq3xgtfymNem8ZsA6qtiJ2fingHQKxYshrkYFBPpndmJSdCL/ufCEk8RTJdStRS+kVXQceo0bFQdHL6GA9R+LifVWj+iPolR2/gVpDjZ3r6bGFFTwW119p1G/Z04cVdRrVe15KknV5sT54+kRQ7xcbdZmvRiuIznJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=pfd32wS8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1753611078; x=1754215878; i=len.bao@gmx.us;
	bh=B0lNLS7zepxoxJcxEo9OOZzCjav4Zs2gfiYailXBRpw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pfd32wS8RmTTN/plbsrb4W+Zvr2RDVEcvs7cEY5oNEUsyH83sdGdx/qoxXBRDflr
	 +86waqWVbAKouZrmLzpp/lfB0jM/N8/L9IG/hcGlCkAa9OOEGhP//EwrSMW6Dj9Wn
	 YZRC76RVead/Us5NAU1ka1exTD+MP4jG5k+IAdSHXht7uuBM4NN6w3TatxFZrqn8t
	 533sOsPZNBAcXfdEwQD9OXuDVJjIxdh0E0zT6VkftWQD/+Z7JpGYwmIPGZnz+QZUV
	 j9EJpones/mYMPOYl9HMDAE8jGDHdh0/Qeg7EL3LTDPmChxKYTI5CDSEtDoV6+98i
	 o+Pr7i8sy8g/3VwnoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ubuntu ([79.159.189.119]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1vD74Y3Dch-00TMiP; Sun, 27
 Jul 2025 12:11:17 +0200
From: Len Bao <len.bao@gmx.us>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Bao <len.bao@gmx.us>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: Use 'u64' instead of 'uint64_t' in union cvmx_pip_wqe_word2
Date: Sun, 27 Jul 2025 10:10:47 +0000
Message-ID: <20250727101052.41181-1-len.bao@gmx.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O7Vk1PgHqgQu/irvoYno1BgA0o7Tp1YKt/OBmxE8ezxey5iJno2
 jQhKlxxbxJ82IjAiqoRFSxdlaeCT77/8CVvGGZ/VEnYz+3wcPrRu7b6Dya1WzjQN/0PvlSt
 zYYqGJ5eHtrbotfKrTqPhruFXchjQ0mk2Lta6+b3u5+6MTSCB1N4Xri2rACpNnnOUGpFJWh
 PwWq1Wpr2e19fWEW5gTtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RQVmAK8kSv0=;jELbfd89062WtnvV8kyCYrqCL/4
 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
 lkovnlkNZ8Q==

In the kernel type 'u64' is preferred over type 'uint64_t'. So, refactor
the 'union cvmx_pip_wqe_word2' to use the former. At the same time, take
advantage of this to align the bits quantity to improve readability.
Also, separate the structs with blank lines to gain readability.

Signed-off-by: Len Bao <len.bao@gmx.us>
=2D--
 drivers/staging/octeon/octeon-stubs.h | 134 +++++++++++++-------------
 1 file changed, 68 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeo=
n/octeon-stubs.h
index 44cced319..35b5078ba 100644
=2D-- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -43,81 +43,83 @@
 #define CVMX_POW_WQ_INT_PC		0
=20
 union cvmx_pip_wqe_word2 {
-	uint64_t u64;
+	u64 u64;
+
 	struct {
-		uint64_t bufs:8;
-		uint64_t ip_offset:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t pr:4;
-		uint64_t unassigned2:8;
-		uint64_t dec_ipcomp:1;
-		uint64_t tcp_or_udp:1;
-		uint64_t dec_ipsec:1;
-		uint64_t is_v6:1;
-		uint64_t software:1;
-		uint64_t L4_error:1;
-		uint64_t is_frag:1;
-		uint64_t IP_exc:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs         : 8;
+		u64 ip_offset    : 8;
+		u64 vlan_valid   : 1;
+		u64 vlan_stacked : 1;
+		u64 unassigned   : 1;
+		u64 vlan_cfi     : 1;
+		u64 vlan_id      : 12;
+		u64 pr           : 4;
+		u64 unassigned2  : 8;
+		u64 dec_ipcomp   : 1;
+		u64 tcp_or_udp   : 1;
+		u64 dec_ipsec    : 1;
+		u64 is_v6        : 1;
+		u64 software     : 1;
+		u64 L4_error     : 1;
+		u64 is_frag      : 1;
+		u64 IP_exc       : 1;
+		u64 is_bcast     : 1;
+		u64 is_mcast     : 1;
+		u64 not_IP       : 1;
+		u64 rcv_error    : 1;
+		u64 err_code     : 8;
 	} s;
+
 	struct {
-		uint64_t bufs:8;
-		uint64_t ip_offset:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t port:12;
-		uint64_t dec_ipcomp:1;
-		uint64_t tcp_or_udp:1;
-		uint64_t dec_ipsec:1;
-		uint64_t is_v6:1;
-		uint64_t software:1;
-		uint64_t L4_error:1;
-		uint64_t is_frag:1;
-		uint64_t IP_exc:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs         : 8;
+		u64 ip_offset    : 8;
+		u64 vlan_valid   : 1;
+		u64 vlan_stacked : 1;
+		u64 unassigned   : 1;
+		u64 vlan_cfi     : 1;
+		u64 vlan_id      : 12;
+		u64 port         : 12;
+		u64 dec_ipcomp   : 1;
+		u64 tcp_or_udp   : 1;
+		u64 dec_ipsec    : 1;
+		u64 is_v6        : 1;
+		u64 software     : 1;
+		u64 L4_error     : 1;
+		u64 is_frag      : 1;
+		u64 IP_exc       : 1;
+		u64 is_bcast     : 1;
+		u64 is_mcast     : 1;
+		u64 not_IP       : 1;
+		u64 rcv_error    : 1;
+		u64 err_code     : 8;
 	} s_cn68xx;
=20
 	struct {
-		uint64_t unused1:16;
-		uint64_t vlan:16;
-		uint64_t unused2:32;
+		u64 unused1 : 16;
+		u64 vlan    : 16;
+		u64 unused2 : 32;
 	} svlan;
+
 	struct {
-		uint64_t bufs:8;
-		uint64_t unused:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t pr:4;
-		uint64_t unassigned2:12;
-		uint64_t software:1;
-		uint64_t unassigned3:1;
-		uint64_t is_rarp:1;
-		uint64_t is_arp:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs         : 8;
+		u64 unused       : 8;
+		u64 vlan_valid   : 1;
+		u64 vlan_stacked : 1;
+		u64 unassigned   : 1;
+		u64 vlan_cfi     : 1;
+		u64 vlan_id      : 12;
+		u64 pr           : 4;
+		u64 unassigned2  : 12;
+		u64 software     : 1;
+		u64 unassigned3  : 1;
+		u64 is_rarp      : 1;
+		u64 is_arp       : 1;
+		u64 is_bcast     : 1;
+		u64 is_mcast     : 1;
+		u64 not_IP       : 1;
+		u64 rcv_error    : 1;
+		u64 err_code     : 8;
 	} snoip;
-
 };
=20
 union cvmx_pip_wqe_word0 {
=2D-=20
2.43.0


