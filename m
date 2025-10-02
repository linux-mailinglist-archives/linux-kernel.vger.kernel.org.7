Return-Path: <linux-kernel+bounces-840408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AB8BB451F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C11325149
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC0B1DC994;
	Thu,  2 Oct 2025 15:26:44 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B51A9FB5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418804; cv=none; b=UG44DJFBr6Nm+zhQ2n8UUCvfhb2vUs2m0MLnQ2ac0t3t3OKwFT6kWSf8h2VbNhmegnTDxVq0XcnUdCURiaQ2/s3sQqRlbQPDID/dS6M/Z24z+D4UA07qVqmPHasBREPzIcHJ9w5LF2lTNiCVvwJz0OXYfnC7pYgrgc6VXDn/Mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418804; c=relaxed/simple;
	bh=Z86lLnI5Tm3fzb69918VDPeWt3usJ2k/s66dsD2rV1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMwziS+9Y0+GzWO32qwikzjT9pg1/tePEagng/nofdtT6w6i2DW1Oxry4gQFrWcKbq2hvw1v7/b4c/BE5a3mDyCwrkuLdZBc67ou6Zy7JOJq965xlwF9XcOMfjAk/RhSYqxPH/YnwWmDZbnAQ61aW2xuAqzThlZKRCVW0gFmj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso2674339a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418801; x=1760023601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV7gueGwrkVggKjpKT46wk+Vba2utbQt9f8Z8d2dnHs=;
        b=htAoYs6BDGfjOH0WBQ+/Ae/cBri9SkKpnGzXd0v/hWzHXQRoEWPw4IP8UwaS2Yd3EL
         wa4bRfvZZ0V9Yu+RkrimqZmzI2SdK2zNYBx8OPk8s42CV2t6ZxBIqeUIhmvkwPfBNNCa
         BFBy9GpW4gjvk4OHoAUF/A6wdqItzolCuSn1FnkV5pO5XYzEyAt+ahvFhAvvUovcGAE+
         ZZW45gd2FUpZGSmw0xcBc9f+uDEkGo0MI4+yDo4jAF3NmiCnAN8/pHHfjJFCctx/Rhso
         a1RxaqkVbl9fIlkTphvenvcqMSOXH0kaFwDgMVAS8wRinMhWb+lx/0XhK0ry1F1WKgMV
         CjPg==
X-Gm-Message-State: AOJu0Yx3nL9yjm6XC0zvwJ0SQrhq+tIXHxFLQXSSRe2afBN++4L72KzZ
	uojDT68T0p41Kysrjgt2QBTlNfNbtEMG/pLvNN0TeG0JB8iD9huLDzpO
X-Gm-Gg: ASbGncvGu9bA3dexRSYawvn2gi76nw3ub0OUzxPbrY0ZIzjxAtFBQw9BXG1uU1My8W0
	0YwDafYOPs4bmRV8inIhGhzxkC3CY5X0xEPhrj1bDzUyeKD/1wjMt9B8Pqz0/vfpgW+lLJCSSsh
	efg2t9CskKoHjCMJdngqM5e7bVtKt+khsS/KVYxs6YUvPtOQ7IQuKzdxdJS6mzauszaQIszh9OL
	vSK3w8GSYxhL3tyROuWlVPKGjkuqvSVRjcJ9IeSxwSgcDCwlvIXbVB2IPFkaApB/O1NjZncIr5l
	rT87H35TATAiRvhW3t3MZ8VlZK2squ4DEZFLc5UNkKwBMMXJMR5p7R8LqLMURD0mrr0hsRb+zSf
	l0w+Ak2s6DiPJvAPJd+DJ6U+OUknWpThkknASCA==
X-Google-Smtp-Source: AGHT+IHu4WE80t/90uYDNyDhdDM+IRvgxuoF7rHrcmkwwOikdOlCR5zfrTQPjaAV6zMrz5FIvlZlJA==
X-Received: by 2002:a17:907:728e:b0:b3d:73e1:d809 with SMTP id a640c23a62f3a-b46ea414aefmr989484766b.48.1759418800558;
        Thu, 02 Oct 2025 08:26:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4e613sm217854966b.81.2025.10.02.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 08:26:26 -0700
Subject: [PATCH net v6 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-netconsole_torture-v6-2-543bf52f6b46@debian.org>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=leitao@debian.org;
 h=from:subject:message-id; bh=Z86lLnI5Tm3fzb69918VDPeWt3usJ2k/s66dsD2rV1E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3pmspZB8YD2VU7zArjltNHoR3Lv5JL4ulcLK/
 0QwucYTe+CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN6ZrAAKCRA1o5Of/Hh3
 bQu3EACLUz67wGRPN9BfvCvd4welZkaPX5R64wU0e0JPLIx8IybZT4DThQgjZo+SHbCPnOyyPev
 ci4ZZlxLvQY4DX3zszY5Hj9mgzp87uLLiP3U76hnN8sKyVemm4b/JOmIxlYBkHmRzBozg/3BIdf
 M/zs9uXms2MrN5+lkmoN9+d6hyA/fmULTbHc2nH3ZRI2VJsembz116cS2ncRS1Df00uSRZrvt0d
 XCrlOLp/Rj3oUD8wDWzBE6ou7D8RLTS5TKLlZh+GxiRiBnUk4ycTfVu7tenhr/16hseDacUDnr8
 +eyro2kmx3Ipi5gdesBRat4P7xzhiIuIkNYvNPUc0bnUiD75e2XSdBOk9kNofP4i1oisZcU8pMX
 QaQVX0mVWr4URMEkJTgOSU6it8h2vsVmQCZgKdnJAHZ5s293JNNuzjGHXuLsmvg5mJDRP/lp2jQ
 rmSrW4caPmcJpPSFFTBkkKF/1dFHCfBx5gX3Z/9Dvv/xdGJx/kB1CBLG+JfQybzTuKzZom7g2xV
 UjxMbgw9yk/XNOKu+02TMxwBhdZeQwEgf5xefelb5sMfUAE/0dQUUE6SoL+LgDLxZuAfkGerS7i
 +xnCrjc34r35cViwnYkLXkMwz7VhF82gBaoTm+n6I8zi+pakdwjeBX+lACJc+LFmVMxMP3DNmci
 1+VcNwkEQj2XmLw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the netconsole target creation from create_dynamic_target(), by
moving it from create_dynamic_target() into a new helper function. This
enables other tests to use the creation of netconsole targets with
arbitrary parameters and no sleep.

The new helper will be utilized by forthcoming torture-type selftests
that require dynamic target management.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 8e1085e896472..9b5ef8074440c 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -113,31 +113,39 @@ function set_network() {
 	configure_ip
 }
 
-function create_dynamic_target() {
-	local FORMAT=${1:-"extended"}
+function _create_dynamic_target() {
+	local FORMAT="${1:?FORMAT parameter required}"
+	local NCPATH="${2:?NCPATH parameter required}"
 
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 
 	# Create a dynamic target
-	mkdir "${NETCONS_PATH}"
+	mkdir "${NCPATH}"
 
-	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
-	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
-	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
-	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
+	echo "${DSTIP}" > "${NCPATH}"/remote_ip
+	echo "${SRCIP}" > "${NCPATH}"/local_ip
+	echo "${DSTMAC}" > "${NCPATH}"/remote_mac
+	echo "${SRCIF}" > "${NCPATH}"/dev_name
 
 	if [ "${FORMAT}" == "basic" ]
 	then
 		# Basic target does not support release
-		echo 0 > "${NETCONS_PATH}"/release
-		echo 0 > "${NETCONS_PATH}"/extended
+		echo 0 > "${NCPATH}"/release
+		echo 0 > "${NCPATH}"/extended
 	elif [ "${FORMAT}" == "extended" ]
 	then
-		echo 1 > "${NETCONS_PATH}"/extended
+		echo 1 > "${NCPATH}"/extended
 	fi
 
-	echo 1 > "${NETCONS_PATH}"/enabled
+	echo 1 > "${NCPATH}"/enabled
+
+}
+
+function create_dynamic_target() {
+	local FORMAT=${1:-"extended"}
+	local NCPATH=${2:-"$NETCONS_PATH"}
+	_create_dynamic_target "${FORMAT}" "${NCPATH}"
 
 	# This will make sure that the kernel was able to
 	# load the netconsole driver configuration. The console message

-- 
2.47.3


