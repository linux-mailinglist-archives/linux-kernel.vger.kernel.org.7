Return-Path: <linux-kernel+bounces-859256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F26BED263
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 230124E536B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8321B87C0;
	Sat, 18 Oct 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QWkqATuf"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4C225390
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800685; cv=none; b=O+q3ASPwzEHiGNXOhH6w4InQ32Rx9cm+jBa+P3dkv8vqFGNYkJM+MvMVgnkxQ4uSKE1YBvFeESpZ9QhOZyV63Cocf2+wkgEfFNDBZCQSQ0sELwuWJI/c7LmjJCSJySiJHF3UeWctVMYFb8nPWd0qXbZT2qzn8ENMaaBOZDUZFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800685; c=relaxed/simple;
	bh=UeRLzxSTtKouZ2KsT3hkb4b+OwXStm7lt7fTIc9MGFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uETr1nrVXGcuZjnHcPoRljbHQIejF+33ZRtvlhirSzGri+8KJz+34DdLs9f56PlP8U3eF9fhd5uRKtmjbCL6WOa0sU0cEQszuUzIMfS3fulojQhY57kRy1Go80uHV4Lmy7w5XD7uibPen3VnHB3IjIO9ivEzPiGtNXeg6FxCw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QWkqATuf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b457d93c155so421749666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760800681; x=1761405481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrN3fMwOLPZu29auA7WsZPkfHarxsXcDGhOuMV9Gxus=;
        b=QWkqATufxIHXa1hbeOx6EwVjxa0ilIhis5E5PNAANAIImKTQ3orQy2RLBKaoqYqPcq
         mpMEMvrUWlnNNKAmb5wETkGfhZ230Zu8/6Yzl3fmhDZEXW6wAvzXLWOC6kFs6Or2OF53
         iDKIhkAbvROwYWBdLRr8rJoxFsz7NiCTzy4x3yHD/TGCieCjmvCh6N84/HGcp2NFFxKT
         QK9ZcZPH400TjZSNZEkcLRUuQL+ydM2vfQYghummz6EbNO473f1jCl+5PNOS4/xWuGxO
         5Uzc1UXJe7AGhUg6oDws3cEoAH6dO80jjS3rsH84gMoqqaNWHaLDpHbrBjw4tZUIi1to
         ltYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800681; x=1761405481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrN3fMwOLPZu29auA7WsZPkfHarxsXcDGhOuMV9Gxus=;
        b=dwu9plTdf4KOeZ35qPdySgxCl4mJRNGkrHKQs01ulo1D2QyIZcUvlYgLdF4BYsLa4C
         1TJVzCFMsFkPHTxcjBMDM+slemkpV3yMl9CNsujya7pv4WqvBPoEkKXmdwogXrqb2mUv
         9YyyKmAqQsrYhAoXkJKaDL6vXfDMJRhWsIBk10YQ+5x+7MPm8lXFVRGRCE4FN187kG99
         tHQT4fKST2qfvo3y49R06Pm+6YpqQxCrQ8DBx/1xxraGtbqHdRjTXEeZXsbGbVMJ1ZGf
         rA+k3/9s8iYfMg0PEGtxSDpPP/9qT2vc/N08C0S75grsV5t9LxUcfuc4olIyLLjJ42hA
         lOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeTLELqq79IKK8lSYS1+gNfvO6KKoWdQc8a6RYlJmzeuwMCkeeQGj1LJ59MS+2FXAAsiqSwF+KTQVqyO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxobRdi6YHYClpeWxIQDw+U1PTM1bVXQIEQvVwnM3QPJcu/2i63
	FuHBAzsw2XWxMdFUwJQBYKuFGQYIoOL6iEYil+dusDZRz0bnBPzkbLui
X-Gm-Gg: ASbGncsGIfsgD2ZujKbW/IZNNJBWdKKEpZADeOOeg6VG5SVoUE/xPOAzGxjLMRiu8Wm
	K2UqbDIMB35wJmisWitl0B1sAFROQe6TbsWaVeqcFFWkgeBFNgHZPC9Capd8GTEAXn9dtZ4X7FS
	/TTMGzJSEGL7czGEOWlQqDUYB/PzJ8KWxodJy9k+6/QOpNmiJNF4ze75vNYqtRHiRReC2sT3E/4
	tRAXq4hYJRPPvAPnoVm/+VW/RkPacseGkps4JuGtxseAUbvaHlhHHo8EVoEYRgFsVggv9atn0UK
	EVMCt3fVwbhmJLhjZgsXYDDxLzwoNjk6olNqkEhBznLNJrIrFWrmOdqYAEFrwYKGKK1VgmH4WpU
	tfaey9AOuKaiUF5JXI6SU8THF0TdCM/j8s5LFbs6Xl7U8CHgYa3v5qo/J3gtLkEFpC0RLyOEr9+
	M0ULi+0sqMich8mnZIgF++xLNHPDhwl+xtKAD66M1ngmERsPN276ATkFBHKgwVRY8NWtfF3k5mD
	g==
X-Google-Smtp-Source: AGHT+IE0GjjqomwD9ou8fGZFtmJFWtZFMZxl/gZzYCOgNQM91Qb7zfcpfiyOckxUCtZmVWiY1V/tyw==
X-Received: by 2002:a17:907:1c85:b0:b3e:5f20:888d with SMTP id a640c23a62f3a-b647304516amr947340466b.27.1760800680470;
        Sat, 18 Oct 2025 08:18:00 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm259983366b.54.2025.10.18.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:18:00 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH 1/4] ynl: samples: add tc filter add example
Date: Sat, 18 Oct 2025 17:17:34 +0200
Message-ID: <20251018151737.365485-2-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018151737.365485-1-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple tool that demonstrates adding a flower filter with two
VLAN push actions. This example can be invoked as:

  # ./tools/samples/tc-filter-add p2

  # tc -j -p filter show dev p2 ingress pref 2211

	[ {
		"protocol": "802.1Q",
		"kind": "flower",
		"chain": 0
	    },{
		"protocol": "802.1Q",
		"kind": "flower",
		"chain": 0,
		"options": {
		    "handle": 1,
		    "keys": {
			"num_of_vlans": 3,
			"vlan_id": 255,
			"vlan_prio": 5
		    },
		    "not_in_hw": true,
		    "actions": [ {
			    "order": 1,
			    "kind": "vlan",
			    "vlan_action": "push",
			    "id": 255,
			    "control_action": {
				"type": "pass"
			    },
			    "index": 5,
			    "ref": 1,
			    "bind": 1
			},{
			    "order": 2,
			    "kind": "vlan",
			    "vlan_action": "push",
			    "id": 555,
			    "control_action": {
				"type": "pass"
			    },
			    "index": 6,
			    "ref": 1,
			    "bind": 1
			} ]
		}
	    } ]

This shows the filter with two VLAN push actions, verifying that tc action
attributes are handled correctly.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 tools/net/ynl/Makefile.deps           |  1 +
 tools/net/ynl/samples/.gitignore      |  1 +
 tools/net/ynl/samples/tc-filter-add.c | 92 +++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 865fd2e8519e..96c390af060e 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -47,4 +47,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_MIRRED_H,tc_act/tc_mirred.h) \
 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
+CFLAGS_tc-filter-add:=$(CFLAGS_tc)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/samples/.gitignore
index 7f5fca7682d7..05087ee323ba 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -7,3 +7,4 @@ rt-addr
 rt-link
 rt-route
 tc
+tc-filter-add
diff --git a/tools/net/ynl/samples/tc-filter-add.c b/tools/net/ynl/samples/tc-filter-add.c
new file mode 100644
index 000000000000..b9c6f30f2a30
--- /dev/null
+++ b/tools/net/ynl/samples/tc-filter-add.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <arpa/inet.h>
+#include <linux/pkt_sched.h>
+#include <linux/tc_act/tc_vlan.h>
+#include <linux/tc_act/tc_gact.h>
+#include <net/if.h>
+
+#include <ynl.h>
+
+#include "tc-user.h"
+
+int main(int argc, char **argv)
+{
+	struct tc_newtfilter_req *req;
+	struct tc_act_attrs *acts;
+	struct tc_vlan p = {
+		.v_action = TCA_VLAN_ACT_PUSH
+	};
+	__u16 flags = NLM_F_EXCL | NLM_F_CREATE;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ifi;
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: %s <interface_name>\n", argv[0]);
+		return 1;
+	}
+	ifi = if_nametoindex(argv[1]);
+	if (!ifi) {
+		perror("if_nametoindex");
+		return 1;
+	}
+
+	ys = ynl_sock_create(&ynl_tc_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 1;
+	}
+
+	req = tc_newtfilter_req_alloc();
+	if (!req) {
+		fprintf(stderr, "tc_newtfilter_req_alloc failed\n");
+		goto err_destroy;
+	}
+	memset(req, 0, sizeof(*req));
+
+	acts = tc_act_attrs_alloc(2);
+	if (!acts) {
+		fprintf(stderr, "tc_act_attrs_alloc\n");
+		goto err_act;
+	}
+	memset(acts, 0, sizeof(*acts));
+
+	req->_hdr.tcm_ifindex = ifi;
+	req->_hdr.tcm_parent = TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS);
+	req->_hdr.tcm_info = TC_H_MAKE((2211 << 16), htons(0x8100));
+	req->chain = 0;
+
+	tc_newtfilter_req_set_nlflags(req, flags);
+	tc_newtfilter_req_set_kind(req, "flower");
+	tc_newtfilter_req_set_options_flower_key_vlan_id(req, 255);
+	tc_newtfilter_req_set_options_flower_key_vlan_prio(req, 5);
+	tc_newtfilter_req_set_options_flower_key_num_of_vlans(req, 3);
+
+	__tc_newtfilter_req_set_options_flower_act(req, acts, 2);
+
+	tc_act_attrs_set_kind(&acts[0], "vlan");
+	tc_act_attrs_set_options_vlan_parms(&acts[0], &p, sizeof(p));
+	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[0], 255);
+	tc_act_attrs_set_kind(&acts[1], "vlan");
+	tc_act_attrs_set_options_vlan_parms(&acts[1], &p, sizeof(p));
+	tc_act_attrs_set_options_vlan_push_vlan_id(&acts[1], 555);
+
+	tc_newtfilter_req_set_options_flower_flags(req, 0);
+	tc_newtfilter_req_set_options_flower_key_eth_type(req, htons(0x8100));
+
+	if (tc_newtfilter(ys, req))
+		fprintf(stderr, "YNL: %s\n", ys->err.msg);
+
+	tc_newtfilter_req_free(req);
+	ynl_sock_destroy(ys);
+	return 0;
+
+err_act:
+	tc_newtfilter_req_free(req);
+err_destroy:
+	ynl_sock_destroy(ys);
+	return 2;
+}
-- 
2.51.0


