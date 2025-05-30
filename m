Return-Path: <linux-kernel+bounces-667507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7244DAC862E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 04:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7211BC0463
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 02:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C02155C87;
	Fri, 30 May 2025 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hn8xqC8U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC017A305
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748571205; cv=none; b=VghEDXaNjHkZGm5WEoRjbcY12NgAqAslad6zYVyQWeH3GWh+3jnHLprIk+MMiHqnlajM+rTSX8LcBNOoRr9FzDoNNZPY+TAiKta3bCS2SMSn1Yez0zE4pFDevkbMmUuwfEqqGtOixYLfqReOnMN5+EmrCJCLZIkIwMZhohgLXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748571205; c=relaxed/simple;
	bh=wap4tC67QkTxarLmJrcG2So2hb8DBHqqnT0nUw4uwP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+35DJIJDh6OWt2B6hgYjD9WAMk4NSqdv5/nU+/60WHWmGJxY85DsZwDjO8oRHRNqeHsAQNLALgG04MSVQArDZ541B4FzlfEEjkZoI67GwPQ9W2yQDib9HumZcfEy9QlNZJWk07sf2YrS1gY8Nt2RKIilq7jtJGUklZ51pwQ+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hn8xqC8U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748571201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l31e+xj+b8/YAIp7qmIPHsvaoZ+t/aWIeSplxyrBR0s=;
	b=hn8xqC8U/K2dADzGJfSGiC2KQq0p56pmP8Yrju3zbL5YPQdrH20jNm1rFwdW+awH/2UL2B
	MsNvb292JLVc67DsPzR6zA9fzbj5uP831y903IrXdabbAI5li8zNZ/UUIbFl3k9MMs8cmm
	jT9uzaVW7gJ1cdK8d/Kky22kFjFvh2Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-1UTFMNcMMMie1Fs1PzqLxA-1; Thu,
 29 May 2025 22:13:15 -0400
X-MC-Unique: 1UTFMNcMMMie1Fs1PzqLxA-1
X-Mimecast-MFC-AGG-ID: 1UTFMNcMMMie1Fs1PzqLxA_1748571193
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07D921800446;
	Fri, 30 May 2025 02:13:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7051919560B0;
	Fri, 30 May 2025 02:13:06 +0000 (UTC)
Date: Fri, 30 May 2025 10:13:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 8/9] selftests: ublk: add stress test for per io
 daemons
Message-ID: <aDkULJG9zwqCWqTk@fedora>
References: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
 <20250529-ublk_task_per_io-v8-8-e9d3b119336a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529-ublk_task_per_io-v8-8-e9d3b119336a@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, May 29, 2025 at 05:47:17PM -0600, Uday Shankar wrote:
> Add a new test_stress_06 for the per io daemons feature. This is just a
> copy of test_stress_01 with the per_io_tasks flag added, with varying
> amounts of nthreads. This test is able to reproduce a panic which was
> caught manually during development [1]; in the current version of this
> patch set, it passes.
> 
> Note that this commit also makes all stress tests using the
> run_io_and_remove helper more stressful by additionally exercising the
> batch submit (queue_rqs) path.
> 
> [1] https://lore.kernel.org/linux-block/aDgwGoGCEpwd1mFY@fedora/
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile          |  1 +
>  tools/testing/selftests/ublk/test_common.sh    |  5 ++++
>  tools/testing/selftests/ublk/test_stress_06.sh | 36 ++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index 5d7f4ecfb81612f919a89eb442f948d6bfafe225..1fb1a95d452c2e9a7ed78cb8b12be2b759074e11 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -38,6 +38,7 @@ TEST_PROGS += test_stress_02.sh
>  TEST_PROGS += test_stress_03.sh
>  TEST_PROGS += test_stress_04.sh
>  TEST_PROGS += test_stress_05.sh
> +TEST_PROGS += test_stress_06.sh
>  
>  TEST_GEN_PROGS_EXTENDED = kublk
>  
> diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
> index 0145569ee7e9a45b41898c2c789842b4c8380f18..8a4dbd09feb0a885ec7539f1a285ed6f437fe3ab 100755
> --- a/tools/testing/selftests/ublk/test_common.sh
> +++ b/tools/testing/selftests/ublk/test_common.sh
> @@ -278,6 +278,11 @@ __run_io_and_remove()
>  	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
>  		--rw=randrw --norandommap --iodepth=256 --size="${size}" --numjobs="$(nproc)" \
>  		--runtime=20 --time_based > /dev/null 2>&1 &
> +	fio --name=batchjob --filename=/dev/ublkb"${dev_id}" --ioengine=io_uring \
> +		--rw=randrw --norandommap --iodepth=256 --size="${size}" \
> +		--numjobs="$(nproc)" --runtime=20 --time_based \
> +		--iodepth_batch_submit=32 --iodepth_batch_complete_min=32 \
> +		--force_async=7 > /dev/null 2>&1 &

I think we can replace job1 with the batchjob simply.

>  	sleep 2
>  	if [ "${kill_server}" = "yes" ]; then
>  		local state
> diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..3aee8521032e3962b8b070cda8eb295b01e7b124
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_stress_06.sh
> @@ -0,0 +1,36 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +TID="stress_06"
> +ERR_CODE=0
> +
> +ublk_io_and_remove()
> +{
> +	run_io_and_remove "$@"
> +	ERR_CODE=$?
> +	if [ ${ERR_CODE} -ne 0 ]; then
> +		echo "$TID failure: $*"
> +		_show_result $TID $ERR_CODE
> +	fi
> +}
> +
> +if ! _have_program fio; then
> +	exit "$UBLK_SKIP_CODE"
> +fi
> +
> +_prep_test "stress" "run IO and remove device with per_io_tasks"
> +
> +_create_backfile 0 256M
> +_create_backfile 1 128M
> +_create_backfile 2 128M
> +
> +ublk_io_and_remove 8G -t null -q 4 --nthreads 5 --per_io_tasks &
> +ublk_io_and_remove 256M -t loop -q 4 --nthreads 3 --per_io_tasks \
> +        "${UBLK_BACKFILES[0]}" &
> +ublk_io_and_remove 256M -t stripe -q 4 --nthreads 4 --per_io_tasks \
> +        "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> +wait

We plan to reuse the test for blktest or liburing test, so feature check
is needed.

But this patch shouldn't be a blocker, and it can be one follow-up with
something like the following with above batchjob change, then generic
feature can be covered completely wrt. stress test.


diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index 7d728ce50774..f5908c1357d2 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -41,5 +41,13 @@ if _have_feature "AUTO_BUF_REG"; then
 fi
 wait
 
+if _have_feature "PER_IO_DAEMON"; then
+	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+	ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_remove 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_remove 8G -t null -q 4 -z --nthreads 8 --per_io_tasks &
+fi
+wait
+
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 9bcfa64ea1f0..be3ecdbe9bb4 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -38,6 +38,13 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
+
+if _have_feature "PER_IO_DAEMON"; then
+	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 8G -t null -q 4 -z --nthreads 8 --per_io_tasks &
+fi
 wait
 
 _cleanup_test "stress"
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index bcfc904cefc6..5634b1db1ded 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -69,5 +69,12 @@ if _have_feature "AUTO_BUF_REG"; then
 	done
 fi
 
+if _have_feature "PER_IO_DAEMON"; then
+	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" &
+	ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_remove 8G -t null -q 4 -z --nthreads 8 --per_io_tasks -r 1 -i "$reissue"  &
+fi
+wait
+
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE


Thanks,
Ming


