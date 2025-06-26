Return-Path: <linux-kernel+bounces-704452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08EAAE9DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 14:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61A45A0C83
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8552E4273;
	Thu, 26 Jun 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bu2rOC2B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0D2E426C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941391; cv=none; b=HTyhdq/UIjCrQabDkcMlUHtYedYDrPdQDc2JiqbbT8/sHSqPVWmTN6J1cWwjREw1zQHAhXWvW+D+AotrYmsPeIjOxsyYiv7Ksi+iFtGSQ90MoE7qurs6rBAgnmf+CYA2fAugucNbLIQ4Y0gyi3XwBm95IJoR0Jc/WEk6D35zX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941391; c=relaxed/simple;
	bh=khl73MPmUq799HOT+UF9QQ+r9png3+sHIge1qd1A1WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9+bOk/I3B+h3AO4bdW06nJIO2H802sfoPkCrqxCRV+bxboLspNB5iISjRUD1ZKbGDEReijLiF+fO6P6NGaLVdvYb2CMGGTyMBefe9faCejAgwwjRdHoVbTdT1aZkjgCUZvnYgrOlPvVweROB/OtG7Fk7Stk/EcwqorZh6CQcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bu2rOC2B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEiqq7isWZiK/FNjFSdCqNp6cYFEr/QW0LyfClcFOf0=;
	b=Bu2rOC2BwlP79hlfQszcUEFqIiKcz9qsUfBTy42ZDnalz4G2SsfChs0XhYaM0BNLnYVUPz
	NkpYerYAYvW4vCoe4a4fyE/Lb2KrHdFDhiIdGBDH2j8PIZ58gQevkR4mEwYwDDYFvw7Ufa
	QoBtujMnjVJ30M5XYyrrj+H3XJ5dm60=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-v82t7H5_NreYnjcK-hxVxA-1; Thu,
 26 Jun 2025 08:36:27 -0400
X-MC-Unique: v82t7H5_NreYnjcK-hxVxA-1
X-Mimecast-MFC-AGG-ID: v82t7H5_NreYnjcK-hxVxA_1750941386
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96C761800289;
	Thu, 26 Jun 2025 12:36:26 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.241])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B48E918003FC;
	Thu, 26 Jun 2025 12:36:23 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 6/9] rtla/tests: Check rtla output with grep
Date: Thu, 26 Jun 2025 14:34:02 +0200
Message-ID: <20250626123405.1496931-7-tglozar@redhat.com>
In-Reply-To: <20250626123405.1496931-1-tglozar@redhat.com>
References: <20250626123405.1496931-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add argument to the check command in the test suite that takes a regular
expression that the output of rtla command is checked against. This
allows testing for specific information in rtla output in addition
to checking the return value.

Two minor improvements are included: running rtla with "eval" so that
arguments with spaces can be passed to it via shell quotations, and
the stdout of pushd and popd is suppressed to clean up the test output.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index f2616a8e4179..64c5be4313de 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -11,7 +11,7 @@ test_begin() {
 reset_osnoise() {
 	# Reset osnoise options to default and remove any dangling instances created
 	# by improperly exited rtla runs.
-	pushd /sys/kernel/tracing || return 1
+	pushd /sys/kernel/tracing >/dev/null || return 1
 
 	# Remove dangling instances created by previous rtla run
 	echo 0 > tracing_thresh
@@ -35,11 +35,14 @@ reset_osnoise() {
 	echo 0 > stop_tracing_us
 	echo 1000 > timerlat_period_us
 
-	popd
+	popd >/dev/null
 }
 
 check() {
+	test_name=$0
+	tested_command=$1
 	expected_exitcode=${3:-0}
+	expected_output=$4
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
@@ -49,8 +52,16 @@ check() {
 		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
-		result=$(stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
-		if [ $exitcode -eq $expected_exitcode ]
+		result=$(eval stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
+		# Test if the results matches if requested
+		if [ -n "$expected_output" ]
+		then
+			grep -E "$expected_output" <<< "$result" > /dev/null; grep_result=$?
+		else
+			grep_result=0
+		fi
+
+		if [ $exitcode -eq $expected_exitcode ] && [ $grep_result -eq 0 ]
 		then
 			echo "ok $ctr - $1"
 		else
@@ -58,6 +69,8 @@ check() {
 			# Add rtla output and exit code as comments in case of failure
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
+			[ -n "$expected_output" ] && \
+				printf "# Output match failed: \"%s\"\n" "$expected_output"
 		fi
 	fi
 }
-- 
2.49.0


