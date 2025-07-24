Return-Path: <linux-kernel+bounces-743524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1112CB0FFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532FE4E5AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9DB1EA7DF;
	Thu, 24 Jul 2025 04:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLvLmlUp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA81FE44B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753332936; cv=none; b=OvDA1zljgZjrPq/gEkLxlbKzxgGOSorKN3Gt5UW+atjuvVo5w1lbvnPbOEvw0dGlN6cnWlZXu4FCA4Afeh9jSOWLy3Kpkk0owhaOTYWPNKRbLsLVpU3YDujoSZt4iQMQ6TiOlPEChnwpBMK8QV84hwI59B5oycjli+kpP8XV8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753332936; c=relaxed/simple;
	bh=WBrmB23zqf17QstavV6HWjSUrFh/p2tqMwe3/b9u46A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJBoRpWaLb5LsGSDNmoCh1jP5epz+BbnN3ZU1zNgzXiGUjR8gGfhH7ctvTxQR00HpF9JPy34HL+JelOiI7s+3iHaTl/lkMrLjPb7xjk4RJvuVxmC6JMpwGfn3nXwy9dMMrzLeEDlQwtsRQ9EPiatjXWbHLRPNIv4o+opkKNw7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLvLmlUp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753332934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6aGM+vPHWZhwm3WRlGCSLPtcgnNJ0f9Z26DvH8FdAxc=;
	b=bLvLmlUp2Yee5SHtVXoHP2D6TkP2umnZdSca1USRls3+tY+zjFG2rW+AYcBOcAnsaVeUoc
	2fAOlgtu041zKAF8H08qUEf2lxniueUXtFLBUG6Tq/nruxXBpa+a4A0aQRKXai/8Yqr4dy
	z9GsJRyionzUvztdQYCNNC05Wlacrww=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-m-jDCLADNiOYw7AmlQbZkA-1; Thu,
 24 Jul 2025 00:55:27 -0400
X-MC-Unique: m-jDCLADNiOYw7AmlQbZkA-1
X-Mimecast-MFC-AGG-ID: m-jDCLADNiOYw7AmlQbZkA_1753332926
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97F4319560B0;
	Thu, 24 Jul 2025 04:55:25 +0000 (UTC)
Received: from xmu-thinkpadx1carbon3rd.raycom.csb (unknown [10.72.120.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA41218002AF;
	Thu, 24 Jul 2025 04:55:19 +0000 (UTC)
From: Xiumei Mu <xmu@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Xin <lxin@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net] selftests: rtnetlink.sh: remove esp4_offload after test
Date: Thu, 24 Jul 2025 12:55:02 +0800
Message-ID: <238b803af900dfc5f87f6ddc03805cc42da2ca35.1753332902.git.xmu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The esp4_offload module, loaded during IPsec offload tests, should
be reset to its default settings after testing.
Otherwise, leaving it enabled could unintentionally affect subsequence
test cases by keeping offload active.

Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test")
Signed-off-by: Xiumei Mu <xmu@redhat.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 2e8243a65b50..5cc1b5340a1a 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -673,6 +673,11 @@ kci_test_ipsec_offload()
 	sysfsf=$sysfsd/ipsec
 	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
 	probed=false
+	esp4_offload_probed_default=false
+
+	if lsmod | grep -q esp4_offload; then
+		esp4_offload_probed_default=true
+	fi
 
 	if ! mount | grep -q debugfs; then
 		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
@@ -766,6 +771,7 @@ EOF
 	fi
 
 	# clean up any leftovers
+	[ $esp4_offload_probed_default == false ] && rmmod esp4_offload
 	echo 0 > /sys/bus/netdevsim/del_device
 	$probed && rmmod netdevsim
 
-- 
2.50.1


