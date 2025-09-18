Return-Path: <linux-kernel+bounces-822581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A0B8432B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8B7C0348
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849E2727EB;
	Thu, 18 Sep 2025 10:42:21 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8F2E040C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192141; cv=none; b=flk2OU01XMfjRfRseDjQZeoD0E/tRKXzADVOZ2UBfeVfKChJP/7WSz0RwBy3DwvQxVp7xidSTVI+zkvA4GaCHWvMR14/fhmpvCwlPGhbP4oD7RKcJme/ffNQvQiOEk6b+gsaFyYaZhaSgjbrRpUUvzBdArUYliUIQrRjjqwX2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192141; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=geOl2G0IySXY7nUuZ9P0qXvrhG7OLmT2jmX+fKymo4TfoCB7m2qJ9EAY+Gz7ad5WxdVpCuttP7dBZBwzcS9IF6jI8wnywjMEup+XQh8WYlg4XOCQTJJLTWj7yc7khnv1XJCNN+j2J64lRsw0UrwG/T0yxJ8ceAlNZLNLkiCAzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc3954fso154284966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192137; x=1758796937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=bVPpqU3mAKh+ApZV4B7TUIvCgGGLdtB0trtTvb8Ryoy8n7BQcRPfk3+xPSzrE1zw24
         SLYhB3s7wnSpGdHX5dthUO7MPX6fX/IwhOmjIvgJvqx3dA544vUZTuEUSTtmuoxg4NZv
         vYD1VGoP3AIoTYe9e3eJp945Op2cAMAXNvJro8SoUwJUwjHsd8PzY8BrzVn77sxSRgJe
         M2n+QoDy7ko+bTBumb4ExfPF6gEbGJqPZxEBA+tWK+MO65P306+zNl53BsJFdjtopwXx
         w9Ge7LP78S9VGk3G4Jzdk2rNpCmcXbhaAFaQvputuzp73lIdgmNnLhoUT9uNaZY5kyYA
         B4tQ==
X-Gm-Message-State: AOJu0YyMgLT3T5QP8nD/Ub5smBqdi13BuKf8nF1mEkMPwDYROwmeZHYw
	2mbuJa9mZ7S1vcuLYxoA/geZOzKFJtcEQHBJP3xyGopdy4ToAfx4GQjF
X-Gm-Gg: ASbGncuHcFWa4yO2jw6zJe2D8HH/sFs/tItf1t6ev6yk1k0Ex4YqGBQSkoX6I39ce+y
	r/mb9vbUY0kMEK293FK2NlYH1E2CeXksNlm3GBgMQ3cFKvZ0+bQIaAIupmiq2cC5rkGI2U+/HiP
	kh+NE/qFPT2UHeAsQWn/4eamLe8jMJFvAjkF4QIsRCru7+eFXcCzMx59rFh29ebmEzTva0UzCM1
	cUAE6578AgilyFxN0+meSkuRs+TL7pPemVlVYl8RN85iX4sR+dQmkfSzJCb68n6jUZijXft5gBy
	cs/Y/sR3qPkroxx+sfpd6dvgNQ3PQn82ML9ptJwt9WjPwaUBUFBkOyeQflSDcM8mcCQ9wXcOzO0
	nk3MwpglNCqJAqjDi7wpbmzbTJTBXXajQi+5YZaFGOFY=
X-Google-Smtp-Source: AGHT+IHZ76Ty7W0omcpdo3n5MkN3sf6Q4OcP/Bdw9ZDtOAwYzRo7981Z0ymOu7nfRAbVU1mgwU++uQ==
X-Received: by 2002:a17:907:3f92:b0:b07:c1d1:4b66 with SMTP id a640c23a62f3a-b1bb0a58881mr566493066b.14.1758192136915;
        Thu, 18 Sep 2025 03:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f43879sm173383366b.7.2025.09.18.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:42:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 03:42:06 -0700
Subject: [PATCH net v5 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netconsole_torture-v5-2-77e25e0a4eb6@debian.org>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
In-Reply-To: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=leitao@debian.org;
 h=from:subject:message-id; bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy+IEgwKHhN8NHKFIUq0Vt3srwkf2ttcLoURlY
 hzNAvymcd6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMviBAAKCRA1o5Of/Hh3
 bbMuD/9ibiWGvzvApY+fBVKhaZM0LGqn9Oip3ni+snNHPdKRVDyLJYlTgNXb9V8vR6ip/8XAKKO
 D5uOPpwPkJyt3WMpHIPyWeQudIgJv/8b4id7rKfTuxsclBKj7N5UI8wjcOa2rrf3Pv6S7UeHN4i
 kgsfcHQX53pFlNwCxwgBLRYRKcgxiLKAg6fDPpoAMLQOqigGqBYNqMmVEAqygaxf2yEYxlI+17i
 kK94C+s4mf94LOER7dFm1XOGCXRPMhltb33JaTSWDY4XI2OjEqKYBKYscaEzTLurVY+g0/4YkF6
 4YeD1VanH3qOqcDy+we+OVWpAOzNPPQOwZxOZVWKBl0iyaylbvKSKxAizn064Z5kMam4/2RMD+x
 5K5jGiawNdojFfxsooK7EFnU/zyuT1GBHWiyCCGRn+cnS4WTP3V763y+z4177HWjd+uLFPvzGbb
 3O1rnUR8yWWlz2suewde6z+rlAP/jNqEmtxSbVYcI/1Kx8mzRfbmnfWuDpmMwvYHCFnwLYkbG1a
 wCaE7EHZorMM8sEvNxQec8y3q4xhA5++EIyTjw6LNLbojYMKhryi5Hg8XVb2P+eqrKvLIXa3PiN
 AkYP1DT0t3kdEHxxPZ1UYaVYpLlkUbIQcZ/gdcKsHnJglQYyTaHOM7TYxdGQ3Hh4QerpCPsDmxz
 P3bTQgr+qMJ6wCg==
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
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++++++++++--------
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


