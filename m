Return-Path: <linux-kernel+bounces-888894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1DC3C3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0919422AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61634A77C;
	Thu,  6 Nov 2025 15:57:03 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F6347FE1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444622; cv=none; b=gBTBGnzVQEnsq7XcS2nf5JUaOeQbYsuzVJfiQtwMXY6ohOplZhf94PwCtzTKfG2NEkQonTyplAicxclmLKZV/YDt3esJHBMrEc5CNwILNCLzpxmz5p8d2wyoeLhbatwE5glNs0sRSCtc6kXe4aeavZ8qMf6KpN3YDl89cbgumVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444622; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJVlcEhwQPOB0Getm4pB9O3/9ilmjlXaeHpBn1chq8yeEi+bNfEIKMJ6p1DSbdvbst5HPbq5kbYm7+Jpw9TUk44Qn0v+T7NooEoaI5vRGrEgHxq1ur3eNIh4QzI1vlGIqwDi5z89MghsMwC+sCW53hKtTZ5npYWU8O0QMpR7tDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5942a631c2dso1075543e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444619; x=1763049419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=ZK3yCvAwXzA9r43JDet5leT25Ckq4jUxy/pArt/SfEpI7iqHm3O2hYMCkMLS44PURJ
         ByoXZ7Vl5f4Nm++36yTkcIh44v6/3h7HKnhYnZB2DgWWXFAuuxRZ5Pj5zuIIvvGrjK59
         mTBhlTDtbOIAQSfuzQOXWI8TaBy6gwJqL0xZQw2jeXdDA7Q8LRoVVuICUm1IncDPoIqP
         z4Ta52FL2PxaJEipaAeBw7waF0WlEOTiVe57XOhnqOQZMd4FD/YwNBc2JfEqIn5hHy4Y
         GnYSNDhUKBA0mTJ23Isp2yr0VmraYkA110BMckXGR/GnA7BMAmY89B3VyJ0fJuY2GReH
         uNYw==
X-Gm-Message-State: AOJu0YxTRqcotKRw1rk8O1p6XF7oqBIK16/KOUumzeiaaz6RUZFM5EE0
	liV5jI+aliCSx3kFem89UTBzEt7ReGBxmecF2sHFYOTFiqNUexiFeY/8
X-Gm-Gg: ASbGncveqYPSPGv1qR+iPOJD3EFLKFV4Xgx3AkI1kKGzl2AKMxdSv315bA8b/cyx1Q2
	7aOqZPl3XhwzrPS3lzUKocAyfICaF1c+rktEHcQRwbLJCDTr1MCrXqt9AC24ApxgZh/xVSlNp7a
	HbxORIHdk3PFhvPx37Hm+X3vdtvdRc7Ue9zZxGrHYLgs5gnC/1/yOaj9Y7hVn03/3hG/5kEX4M0
	VoSPBNwwJc2uGxfFjGGItXEqsOdaXAcLe2qGHv0kkotGyEzX87xFPLjuRTbu/LO/7IpPIlIdvwt
	T1wkXLOXD+0Y1e7EMcw8lsr6HDYmQ0owNleRIiB+6yYhm6Ul6QXC7+IY+zwpd53+Ru1filMUf3l
	JTaEvNh75oMw7AC7I2/G8seLyifXBTd6p+Trl2yeVSeg2ZGlip2BdmuQ5vyC80rbFbWo=
X-Google-Smtp-Source: AGHT+IGDdzVlfGHG+gjJo6cKPMlpMJ1QYh9sBUqB7vzk7C8ccCORsGYwXnCa2OgNkGSYTk97jL4WSA==
X-Received: by 2002:a05:6512:3b89:b0:594:2d8d:96d0 with SMTP id 2adb3069b0e04-5943d753f59mr2172947e87.15.1762444618841;
        Thu, 06 Nov 2025 07:56:58 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013af4sm819942e87.3.2025.11.06.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:56:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Nov 2025 07:56:48 -0800
Subject: [PATCH net v9 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-netconsole_torture-v9-2-f73cd147c13c@debian.org>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
In-Reply-To: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDMVGKjU4mF7SehuwG2/2BkvWMPlfMIMcjPYYC
 VlUgkAxUmqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQzFRgAKCRA1o5Of/Hh3
 bcBcD/9pqAJ8YiEHBvh7fDBNGanf0hoX/xrVBl6Ns/ujJUEVA+37c8XdLbS2EcpvWB9bSpT/yxm
 KvcYgXbcKCBQbbFINhL8hY5IOjPS4YvEyhc8bQ2uChIe7Ib9knZ7mVO2rZCR/KlgCXpV/XkV/MX
 cDpECoGz2ZspQyK52jXFo6edgwzT/xRzhlJco/N4mu4gA5ht3waJktbN9DkumDvN6NOJh3hLpcy
 w59ZJt6n9akf1MP1WGcgoqm2+6mkvI/3PSzXC0lbX9rhP4muFu694U372Nmui1KlRvU0kbHeIXg
 ScIKE6o18/3Ws/kxSX6cl0+06yPPULhswkBauHfLMEy4ApAdqOGUFnCEIQHb68iqeYOFHXMVMQX
 hEgqyu4PPIJPHQFfaZXb8NGvC+Q8f7qlJld32Pe1cZ9nDOxhQp67pm3qsgD1Hdw36n30CXCrXOf
 WJdCPGg6+mN2zCgDNKLhCgulk8usSqWHuUVZxjyI9Z2egITnXHnniH9slAoOnz/7TtLF2wjhnbg
 Z0isi1X5ku8AncaQdzV7GUtm9Ec7WHr4sejZWxGYm+l66AFo90wRO6wjC9qXc7NGriEtIRE4xn+
 9nie+KJXx2c/4vLmqtgPh+XHMymsDiCOt7WZWdjj0kFMjbnRaLTRuLT/0C9MDj5Wy2Z2ejsJtpF
 IU2jieFRMzDe95g==
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


