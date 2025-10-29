Return-Path: <linux-kernel+bounces-876282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E51C1B1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD46F1B22BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27134886F;
	Wed, 29 Oct 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VRSn6uFW"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64233F38B;
	Wed, 29 Oct 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745976; cv=none; b=XRhGKX9b8BUkHLoMFT1XLx54yQqZWOeCgvMiCEaOXFZ4wrLzDX3R1vS2gcyg6YNh0qwLEm8GAppsMNBW46nYX2+vK11SAJz0h/iQYpQXaGVUOPcF6E1noYjMtFJatRXNYnYbjXEKqwdwsUDDiUoYLTyIGbBS8PvgFvzQQDGQmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745976; c=relaxed/simple;
	bh=cDq9NFxMdJ1KoM2cm0BBx/55+lB4JI39tEo11K8xsCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMHcCzwWq3Eg+XdC33mNRGyNVsV71ApVddKAsM+ZNmo05yewoVdZfhqR6c13bXXJifvgG/8fmO1/Pl8uDkUfdwNVdSvYa4u9iTb67mhhDi/iaFkvka6Jb5S6SLO/ZqxoZlqmWNLFwugWpOP1+C5cbugsFIEcsKmPF9P+HnlG5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VRSn6uFW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 91F9D1A174A;
	Wed, 29 Oct 2025 13:52:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 66D9F606E8;
	Wed, 29 Oct 2025 13:52:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAB63117F80F2;
	Wed, 29 Oct 2025 14:52:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761745970; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V902gLTJ1tGfAR8hmV6KKVBGzcuYROlev8W1RLscgLg=;
	b=VRSn6uFWtPDafjLBqDhTnWhG+YSmPPNgUEXN4qBiwS6fn5Qt/oeSkT6O8arlOpCAVDkLin
	Ss38gIc/Sc0qV0q0ydotyBcneC3NG+o2HMrS23gxonkPxf2miRJk64zZgUbT4G6Vfe010K
	Bqw0OgBMMUKwbWEWQfwDMi/rzZPC7ncSIrbiGS9+2ZYggP7rMp1MYfD5LHQMKLo8fHPH/6
	MprSduMgifm8LyFvEU9TfSoJR5eOjtj59QxfpcJ47VRFuxAAJ7qlPvbd4mpgLBo0yf+/dT
	rCXzjj0h5BJeOO8CtFa6shqJZfRrnqrLXV0MGQLUz24cmBYHSpdsxWsuhPY8nw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 29 Oct 2025 14:52:27 +0100
Subject: [PATCH bpf-next v6 06/15] selftests/bpf: test_xsk: Wrap test
 clean-up in functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-xsk-v6-6-5a63a64dff98@bootlin.com>
References: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
In-Reply-To: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The clean-up done at the end of a test in __testapp_validate_traffic()
isn't wrapped in a function. It isn't convenient if we want to use it
somewhere else in the code.

Wrap the clean-up in two new functions : the first deletes the sockets,
the second releases the umem.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 36 ++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index d7cb2821469c62abd0d532821e836336a2177eb5..84b724731e26d0c7e67131ec1bd562e223d3d09d 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1679,6 +1679,27 @@ static void xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_
 		xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
 }
 
+static void clean_sockets(struct test_spec *test, struct ifobject *ifobj)
+{
+	u32 i;
+
+	if (!ifobj || !test)
+		return;
+
+	for (i = 0; i < test->nb_sockets; i++)
+		xsk_socket__delete(ifobj->xsk_arr[i].xsk);
+}
+
+static void clean_umem(struct test_spec *test, struct ifobject *ifobj1, struct ifobject *ifobj2)
+{
+	if (!ifobj1)
+		return;
+
+	testapp_clean_xsk_umem(ifobj1);
+	if (ifobj2 && !ifobj2->shared_umem)
+		testapp_clean_xsk_umem(ifobj2);
+}
+
 static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *ifobj1,
 				      struct ifobject *ifobj2)
 {
@@ -1734,18 +1755,9 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 		pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
-		u32 i;
-
-		if (ifobj2)
-			for (i = 0; i < test->nb_sockets; i++)
-				xsk_socket__delete(ifobj2->xsk_arr[i].xsk);
-
-		for (i = 0; i < test->nb_sockets; i++)
-			xsk_socket__delete(ifobj1->xsk_arr[i].xsk);
-
-		testapp_clean_xsk_umem(ifobj1);
-		if (ifobj2 && !ifobj2->shared_umem)
-			testapp_clean_xsk_umem(ifobj2);
+		clean_sockets(test, ifobj1);
+		clean_sockets(test, ifobj2);
+		clean_umem(test, ifobj1, ifobj2);
 	}
 
 	if (test->fail)

-- 
2.51.0


