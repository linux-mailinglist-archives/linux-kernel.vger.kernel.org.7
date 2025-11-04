Return-Path: <linux-kernel+bounces-885252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0848EC32613
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 813913497D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276CE33DED2;
	Tue,  4 Nov 2025 17:37:21 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9176320CC2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277840; cv=none; b=EU73dwiXVx39vHBDSG9rKPBREioUVlWvgTIOrs0x/Meh/uZKMN7pffQhly80FHFM8S3jBoOhacalbkSdwFovDe5yeva2P3+IrrfMCEi/cxCnd+itNyaGqsGjKjb6BcO/GW8ysckzi8Llhqx6+31s6yXzmVRXu7BkQLOEt6xCJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277840; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrO7pVdOpFgC8t4yaRbifDRkb9YJde2MUKlHRMSEvjqP4D+RsZG/hkqQ4ZkKm+Qg87tfFQRR8Cpx6BEmBYcXapU1hTVqK65Q2zGXZmr16zvHkmKxDDYU/x2pkgSBeYOnXNgeYNUH64scSc5HKGx6tZW31bO9xiZ6iCOsqbzmKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b714b1290aeso351209466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277836; x=1762882636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=DKZgp6mzz13dvcEl9SPfbthQXfywK9qY5aHD5+/qQaMLAJuAbiRRtg3fb8C6+pzaEw
         fjMqXOWa4/i4ChllviozaMiDY5VdHDtM3tf0yrR5arJXvd6GVd07+ILS3F9sn+Q4H/Rh
         ugMSSBwUW7lYZrmzd0VNFZUxoLB/ARecTdlcUiO93D0qSERoRcjFdF5uT0Vg0YrwH4P7
         s1scuPpmlEeq1rofv86ci/owuRFh3tDUIdCw/Hcix+FgSX5H+PUA3Uy6isSjrIfy8IyK
         W+Yx9AHR/PL9UqV8cZ+HnucmthueU80au/BoP0NVTkPU3CZEMKVHEDzC+6h0lO192/JP
         5MUw==
X-Gm-Message-State: AOJu0YxffLb17+BSWyOUr0FJR9Hrduyh56VGJLV02XwCcRq26Yd/GGHA
	bvxQf+1vsgH4YStyC94Cp8zg8tYzooOMnnIX1vL4AQDYcLnfdoJIs0SL
X-Gm-Gg: ASbGncuf1oJBS/C8tE+vW8oCuWeEiGBMs8XgnSBuejXlICK23Q7i0Jye5s5khsfJtbb
	ohSAYy1vICZ56hmYka0BJ+rZ9X9snLbfeP17FQ15hjbpBwRNTAzrJNIUfaqDLoF608LCfuwhVc6
	f94V6uqxkXjiKgYYbQ4gWoBELLn8b+RsVxE9cre7oxhSp3XW1HcoTOmrIu3K+pZLKw7SzhUHTiZ
	anNrhYzgRm4/y30KYSOF3qIZFIMqs29X/kq+x7U3NVN4yYUQsqquBCD+PpgPvRo5miT3Q95xREs
	UvQOj+WsXbeuCm2fAWZVHhtWBi5RgyJbA1D5QvbAuU+sufSEMi4rB6HM5LruTRqymYXSl/Oss4k
	BIbYr3TIYgEhx4Hq4fq4O6WTXLKUqpo7qPZHXbWMQuPWyz6Zi4Ua3Kg71NzFfNRxS2Ik=
X-Google-Smtp-Source: AGHT+IGyqhZnPAZs8wxqb5/9hR5rKWOTvfq4hgPumR/rNm1+T6y5YCKwl9LV+ZDez9YBKZSISt4tMg==
X-Received: by 2002:a17:907:7252:b0:b46:8bad:6981 with SMTP id a640c23a62f3a-b70701917e6mr1925813566b.20.1762277835835;
        Tue, 04 Nov 2025 09:37:15 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26adsm268280966b.43.2025.11.04.09.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:37:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Nov 2025 09:37:02 -0800
Subject: [PATCH net v8 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-netconsole_torture-v8-2-5288440e2fa0@debian.org>
References: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
In-Reply-To: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpCjnHqDT6qXEqLTxwAX8xhl0e4iNRPUYiU746K
 xwQEgHvTCyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQo5xwAKCRA1o5Of/Hh3
 bVVLD/4hCI+77faS9q0HAjPcQ/c1iOqdLf4T98DLu6d3jyv+H3KLWbcLaB5urIs+V6mx72wMVKV
 xRvDqClh+6jVZd+01BWUnTTp4fUwq/Wb4BfRwxi2HfjcVCO1sV5zHhhBOO51qMXRmr6RVq/x4BX
 bGlw4ppnB15MPAQmHLc4COxXoN6JEpR3J9x6pL/KYthdKi07KT2viOYHOlUY+OVL4lhRwbPyntn
 3C4+H4i6tl2e7ifs2M2N/9PTZjhxxi1ITxrWRTXb5pa98P6my4fsouuQH2UdEEPSyZiUEbhz+Zu
 O91j3JnyypRnFnvJB/Sgncc6YXoFor3EvRuGg5BWapj/2LCEQnI5asxTcFQEvfXF0WPaZQhL5fq
 E4Rb6ypVwBR3AFzmY8WlqGqkkrTXDORcGfdfDsqCB4QlGgmA7wCZMrYsPm4Itb4IY0jvFtSED4V
 +MSS0dDheLI0iknsSc4NoW2uvju/3t77qsuqtSafwddrIedqb+ZtDmNJSUOQ0noDZBo740HbkWV
 qtILFVRhTFjExNPjxUzNdqc4qVxrNJ6rDNbF1VoeV4UjfH4mMkZZ2JHowrlLKki1cmJg9GJauWU
 ra9AzMGslC6yYw8QfAOeOszm3yvLhRWh730l7pIO80FJhA35MV82A7qeusfvJbdN+x/D/V7UZ7m
 cjiQ25budDdnXCg==
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


