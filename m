Return-Path: <linux-kernel+bounces-897089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD18C51FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91ED04FDF62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B330BBB9;
	Wed, 12 Nov 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMO8Lprp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oUWVdXcu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957292EC547
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946396; cv=none; b=Ilo0uiOf/uj0oa3vxKpfMiSIx8UZWxaU1oeIlSkEMbkVZc9trcl7Wi6SjETLvdg8fB69kKXolfbkd8BJC0Gd0SH3gjxP0r3GwdtlNTp2XQaG0dLGc9IKw/VbePo1qMp8s1EVMIeh2bzwtMQWwMEULUBE8wi0d4zKVH08ZPv3UG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946396; c=relaxed/simple;
	bh=OKClyKv8Ey4yyuKqx+8b/7B4wt73VZkmnz6uZGpZgUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBIqS+gra4KIJtKaPYuHPmWc7rBIabjV3EFdfrEtBxT38XwRLLu3W3XGMkDFLDchBScsOgLfDntu1uXeiq8box4cFd+6vg/x8aiQCandL9XNVmLXKuHBcU2SiI1Xnf/zwk2DxR6otOhxGXlod51l5CITO3ni/hx+7Ke3efdp96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMO8Lprp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oUWVdXcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FDYwKVcD0dlATlv10YwLZFZcLbAZEaa4NsDrv83O14=;
	b=DMO8LprpeCMvGkiN1r2bMLNGq4XPClpPe1sKWaXDoTh+SeS096bb9V8UhnKS4i510hSXUT
	z35WTYT0vv+iLm5rRR2hg1QC/IUp2NMTpqZXtLviB9E/cy0LIdxyuM+onKozulBZaU6BvP
	I8/z31aEvgo2AdguN1ZFQHks3R7QmCE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-wduTQeYfM5mUBtUcIIeejA-1; Wed, 12 Nov 2025 06:19:52 -0500
X-MC-Unique: wduTQeYfM5mUBtUcIIeejA-1
X-Mimecast-MFC-AGG-ID: wduTQeYfM5mUBtUcIIeejA_1762946392
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b24b811fb1so169470185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946392; x=1763551192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FDYwKVcD0dlATlv10YwLZFZcLbAZEaa4NsDrv83O14=;
        b=oUWVdXcuWlLdzSqM9bBs5gBvaZTB4jI8NQYQ7uwfDWEMuSVP8cQuE6OvPFne3IJYxH
         T2GNbC0iy7uXB2IpFxfxAh/dDxyh85SlEhBHGT9RoHsrR0b7BvLMwbE85+lYgzNvPfx2
         bbF/CIq0pvXXqzzIJmszgUNsB0MJj/VnnaxPIJFZM64lYBpt7p9dW25rnvQF4edmEm3Y
         bLTBYHRkOhEtGj4GV9CGNV+yQl4gwRca8yXIzMHW2jx8A7T9sHByWP3y+D1/k4xwb4RY
         UIQ/5S1x0eBsn8BnwSoNWIHa6l/w7QE2ckyjNU9qHVLv7aUV6fqGd9wgjt9/8sawTCcV
         4a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946392; x=1763551192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FDYwKVcD0dlATlv10YwLZFZcLbAZEaa4NsDrv83O14=;
        b=gzJkbbsfvQvcgQNa9ZbLRMVLTWhIisyUA+2Tp7o7mcqKPqhQUxcy90GzK5PA5aiTUr
         +v9Gq3jwYeXOig2778LTtIBky+qaJI56mc8+KycKf1JIFDcX83SL+CISgOsuanvuHQ36
         CSrIP/wSyrE/4T8md9Fv9E7X/xs7N26OgjA2kc7XgIQxiIzeQmLpE0yFLGMAjxf2HNln
         bvGbSZQLvINDvJvLVOP0w2PduP5eIOFM3ZQyqonQtrCA5ff8hWi1vIgJny8VROSJKRjK
         EmFXxmZClvY/wCwj9+GNA5lDEWqBZfgQ7PRMpZQVS/cbuZC6lFoLbdrFSqbOo4fi3RNE
         yreQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTO82JU3DhL9hg4SEQcEZPAAlOef+5J9+K5eHr0wvA0nGcCM1NR4d1xeBrJxXXJkqdk6ACnBf2MLVv+70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96S+WQYdklbaZkxGH3S39QS8GG9WS4jvPQgRkbe0gyd46hLqf
	JTkahocmrePPpmEXRarWi2+VmXP2nG2jdu3+AhPKr679o4VpWD67MUr9ov7/ixouPveRk/0W+uB
	7HhGyfkW4OgQT2KD+PjIV6yf10VAJf7PdpI9jxMhSrqsEEYkm8nsf4EEz4KiSavwVXQ==
X-Gm-Gg: ASbGncvJfGURXFKzBTBFoq890nnhxZVyA0IBgvH5p4TVcvpoCo2AETVP8KZsz7VXe4p
	aIrsppUJp/Q4FO+IYNSQl3K6JivX+Uv71BhksX4k38nKIl2V7nErYmsRbOB7NKuFDFS2u+b9SP7
	hC57wIaZaNZeaCAKuwrxO2bk+nifvm8c/kgXMg+i2qXzvLOHd2rAivuQ+AlKTdxiOthn+9FhdFB
	sABd03G4W3rlLsr3aggDqDx4cemndNMt8nloU9PQIPMNQdp4Al4nEs67OIh9KEaYg3DReZsoj9I
	X2bjYl6SWT/v3IC9wn1AA4IRTU0dmwtp6MKPYPvMFIMzOXThRl412Vx5dBdm4Hgkh/d8/Bgr7sR
	HSSpNKdw7mqQqK4GOqCJTwNz9ehYRdCoWhW8rW+f4PWRKL6hPbnA=
X-Received: by 2002:a05:620a:199f:b0:8b2:1fa8:4684 with SMTP id af79cd13be357-8b29b567d9dmr336593985a.2.1762946392093;
        Wed, 12 Nov 2025 03:19:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJO/67hI3KgrbQB/aVYyZeSEB0IiwCxk5hDgSYA6vjxGWk6oN9tzaQ+qo21OHmRNB+WCUySA==
X-Received: by 2002:a05:620a:199f:b0:8b2:1fa8:4684 with SMTP id af79cd13be357-8b29b567d9dmr336591285a.2.1762946391690;
        Wed, 12 Nov 2025 03:19:51 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6f2fsm171012785a.33.2025.11.12.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:19:50 -0800 (PST)
Date: Wed, 12 Nov 2025 12:19:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <ydpi67iu224lkrmwzq7ibpupnllvwhsdp4nxtmdjsoyvotsdug@p3rtp4f4fulg>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-3-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-3-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:54AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
>the vsock_test binary. This encapsulates several items of repeat logic,
>such as waiting for the server to reach listening state and
>enabling/disabling the bash option pipefail to avoid pipe-style logging
>from hiding failures.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- remember to disable pipefail before returning from host_vsock_test()
>
>Changes in v3:
>- Add port input parameter to host_wait_for_listener() to accept port
>  from host_vsock_test() (Stefano)
>- Change host_wait_for_listener() call-site to pass in parameter
>---
> tools/testing/selftests/vsock/vmtest.sh | 135 ++++++++++++++++++++++----------
> 1 file changed, 95 insertions(+), 40 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 01ce16523afb..3bccd9b84e4a 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -272,8 +272,81 @@ EOF
> }
>
> host_wait_for_listener() {
>-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+	local port=$1
>
>+	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+}
>+
>+vm_vsock_test() {
>+	local host=$1
>+	local cid=$2
>+	local port=$3
>+	local rc
>+
>+	# log output and use pipefail to respect vsock_test errors
>+	set -o pipefail
>+	if [[ "${host}" != server ]]; then
>+		vm_ssh -- "${VSOCK_TEST}" \
>+			--mode=client \
>+			--control-host="${host}" \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest
>+		rc=$?
>+	else
>+		vm_ssh -- "${VSOCK_TEST}" \
>+			--mode=server \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" \
>+			2>&1 | log_guest &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			set +o pipefail
>+			return $rc
>+		fi
>+
>+		vm_wait_for_listener "${port}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
>+}
>+
>+host_vsock_test() {
>+	local host=$1
>+	local cid=$2
>+	local port=$3
>+	local rc
>+
>+	# log output and use pipefail to respect vsock_test errors
>+	set -o pipefail
>+	if [[ "${host}" != server ]]; then
>+		${VSOCK_TEST} \
>+			--mode=client \
>+			--peer-cid="${cid}" \
>+			--control-host="${host}" \
>+			--control-port="${port}" 2>&1 | log_host
>+		rc=$?
>+	else
>+		${VSOCK_TEST} \
>+			--mode=server \
>+			--peer-cid="${cid}" \
>+			--control-port="${port}" 2>&1 | log_host &
>+		rc=$?
>+
>+		if [[ $rc -ne 0 ]]; then
>+			set +o pipefail
>+			return $rc
>+		fi
>+
>+		host_wait_for_listener "${port}"
>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
> }
>
> log() {
>@@ -312,59 +385,41 @@ log_guest() {
> }
>
> test_vm_server_host_client() {
>+	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${TEST_GUEST_PORT}" \
>-		--peer-cid=2 \
>-		2>&1 | log_guest &
>-
>-	vm_wait_for_listener "${TEST_GUEST_PORT}"
>-
>-	${VSOCK_TEST} \
>-		--mode=client \
>-		--control-host=127.0.0.1 \
>-		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>+	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> test_vm_client_host_server() {
>+	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	${VSOCK_TEST} \
>-		--mode "server" \
>-		--control-port "${TEST_HOST_PORT_LISTENER}" \
>-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
>-
>-	host_wait_for_listener
>-
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=client \
>-		--control-host=10.0.2.2 \
>-		--peer-cid=2 \
>-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
>+	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> test_vm_loopback() {
> 	local port=60000 # non-forwarded local port
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=server \
>-		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest &
>-
>-	vm_wait_for_listener "${port}"
>+	if ! vm_vsock_test "server" 1 "${port}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	vm_ssh -- "${VSOCK_TEST}" \
>-		--mode=client \
>-		--control-host="127.0.0.1" \
>-		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest
>+	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
>+		return "${KSFT_FAIL}"
>+	fi
>
>-	return $?
>+	return "${KSFT_PASS}"
> }
>
> run_test() {
>
>-- 
>2.47.3
>


