Return-Path: <linux-kernel+bounces-888971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4DBC3C638
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A556A3AC885
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E1B34CFC6;
	Thu,  6 Nov 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="l7erD0tX"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDD1E51E0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445598; cv=none; b=OCbUmD65TOf0+FqbLcCTWRAMiG4RljtI6uXc/bdHh5eBiQZzR7DXaJdVtAmxupd61UW17O53YVQcb1xnTW55XPI4cft/Xp8RdVpAy19k+FwCM7aSQ8qhKphLNHD68nN3Zm+MkMdNXbLtWt4hzuuPzLSXzUZLjslTk64TnaOLCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445598; c=relaxed/simple;
	bh=y7vFDbq+p9hSXegJt4sq8fTKw5ztR1lLNQq9McecPT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKByYZSD2VrAMYrNpF0NTp7TkvncEff4OWmEbDhHL9tVBHEZlsR+N3Xfs+moeoXC9w/MP2CQa9Z/uZD8lkxF8SgH500gsf6YaiQPGO/yCmoWijQQeUKXFlhq7SMNutUToLkPsEXqcCS/xh2ZjfE/8v8XTDV2jr5/3ngxuOZKsbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=l7erD0tX; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251106161306c54ac8135800020773
        for <linux-kernel@vger.kernel.org>;
        Thu, 06 Nov 2025 17:13:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Gy0ftG97+mstgfIA9joFhRdJ0+nhWeUJZKFkRz4J5Uc=;
 b=l7erD0tXFMESYDV30nQ2D/mJik3/+xfJPC+drtKKbGRA8r4APcB11Jeg2qhGVKderhhuDt
 h2wrp0HxZYTzHp5byjdmzeTiC0FQcqfXhXH5qEV6zmyNQW77UZs6zfqs3LZuPXIz6knTU37Y
 qTA6npBlIsZ7GPeKPMD0sG5EZ+VcjvOFcMoIwd8YD/3KAna0JR4eOcsF/Pu6JwozhpC1cyVP
 qSIoO55PdSSk1LQkz7pfCbqGZ/7Yhd7PgXQ8j6Xm3SLyNpuGo6crfMo0ZPKi7/GfvChyTkX7
 dimrwzGGBPKDRc+8wtfxtR8OLKrBLHEU68B7lCU4OUnJZpHkuD+M1QTA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] selftests: net: local_termination: Wait for interfaces to come up
Date: Thu,  6 Nov 2025 17:12:09 +0100
Message-ID: <20251106161213.459501-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

It seems that most of the tests prepare the interfaces once before the test
run (setup_prepare()), rely on setup_wait() to wait for link and only then
run the test(s).

local_termination brings the physical interfaces down and up during test
run but never wait for them to come up. If the auto-negotiation takes
some seconds, first test packets are being lost, which leads to
false-negative test results.

Use setup_wait() in run_test() to make sure auto-negotiation has been
completed after all simple_if_init() calls on physical interfaces and test
packets will not be lost because of the race against link establishment.

Fixes: 90b9566aa5cd3f ("selftests: forwarding: add a test for local_termination.sh")
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- moved setup_wait() from individual test groups into run_test()
v2:
- replaced "setup_wait_dev $h1; setup_wait_dev $h2" with setup_wait()
 tools/testing/selftests/net/forwarding/local_termination.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index ecd34f364125c..892895659c7e4 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -176,6 +176,8 @@ run_test()
 	local rcv_dmac=$(mac_get $rcv_if_name)
 	local should_receive
 
+	setup_wait
+
 	tcpdump_start $rcv_if_name
 
 	mc_route_prepare $send_if_name
-- 
2.51.1


