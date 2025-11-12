Return-Path: <linux-kernel+bounces-897070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D6C51F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07ED04FBD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF527299957;
	Wed, 12 Nov 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXZv+oCI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2iZv6jk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387312857EF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946115; cv=none; b=e3PBsX05kCOODSL/LsWA85JsG1kA0iJYpGaUKOGFQsN9BUgscRrBaDqru8zL53DkSrq+4JGt1Z43Zmqqphf2XolTQ0qIayTTKD2E8dX6CALIJzmYThTS09jhE24guj7K6QDchJwJyPA0BqBA0MNuD5EtZA1cpAZGly6NzFwElxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946115; c=relaxed/simple;
	bh=QJ7RsItWW94sQLYSWk24Ndul83P/s6M1Pj6x+zsl1P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU+hPbVRurigqM7tSkcTr+NWHxWlhFhA+zaFIryXi7Fdm5hy8JSfGK/V+SWoIewY3p8bsOOeOMQWX503Pu1mlHYbktMYcgMa5ERhwwRgmDWHMFH7UteYCKBa1iNo+8zAsiLa0mnrcmM658+Btj6cxx9Ll8emUChh3dxr3imMy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXZv+oCI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2iZv6jk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkPHyOZo9yzOxxQpkBZ/awKCWdH75xgCHLmw72fGjXc=;
	b=ZXZv+oCIIO5Kkt3mn6nRV6yk1WtRYRKBxuwP+MoNP3mw9pXtJWF4UtV9/Y/6ppmnS7YVj/
	MEj+pDIPA8deSkdtuVhIbcRHxU1noiG9RE3P0pqB6lReMYWwntxScFjjQ6LMtWKeaocpcq
	YOCgsJWXPeBOTfxzOIqL8KTw4swC4bg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-MVrqCFfrMlqoSPH_okGZEg-1; Wed, 12 Nov 2025 06:15:10 -0500
X-MC-Unique: MVrqCFfrMlqoSPH_okGZEg-1
X-Mimecast-MFC-AGG-ID: MVrqCFfrMlqoSPH_okGZEg_1762946110
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b17194d321so79362185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946110; x=1763550910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkPHyOZo9yzOxxQpkBZ/awKCWdH75xgCHLmw72fGjXc=;
        b=B2iZv6jkd/5HO4LZRYErbuKpHm1UwabumFpGY9l5LNAUnm3EIVRPwlgEpK+8oaTtpo
         tyi0By9GTba40ichXEcMm+GvefbGaGVgPtMNG8ZjCci79IBeyoKedmai0COaJ6F1GNnb
         Vkkd1pKzem1btV/d0HkGiiRBKIP8AFq/gvQ3WdCdQb9nKPYf4WN4rZplnhDYC85+EPcT
         9iR7Y6AmXjgqVyHRysMOlu8Gj12HEPz6g/JDrYNHhzI0maiI8QDN1MmAhV8qgY7prkzS
         Rny1FXTURllBsW7RtCaTF/WLWXoOr/sCJIrs36onezB4S/r9BuMoudBpPfBHFV+Eae5m
         toLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946110; x=1763550910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkPHyOZo9yzOxxQpkBZ/awKCWdH75xgCHLmw72fGjXc=;
        b=utucT0SJuqTj/IodUUsX2uAXshdVCDQuoSl15fP5OccuHtasBzHOAXZjs+19QbUHC6
         D8PNCmatdO319tsFthtJrmg19Fo9xExAryy/egsIJdeXBJXcsd3pMH2/Aa8iRh5BFudF
         wjST7t8lDF+jcM4Arx+9iAzpW8GvhxMpOJ8mrHTJnXD2pAoxSXhb+AC4XzQ7OXuMUpZG
         ArU+yV+Y/DF86ou8zH4PviNPZilCYh1xcgy6pmR5nyhptUYfdUCuwnA6MxpGHjM+8d4p
         sTbpf9cmXIsPlt7mJIOfK5DSPidb8r5bM4UpxazazfbhB4kcMiy6wqJc8PwYGU4Q5mrB
         tLjg==
X-Forwarded-Encrypted: i=1; AJvYcCWfdz72FVcYFRaxYCuAdJCiKjzkDE/n9jH/qJH+51XL6GIM2ps8E6kE50gW/spK0Fw0REb5vmH/lZYI86w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydho246h/SE02qaHpMGHJ74frR3xkXDgwJErLvcmrI8/dq+xSV
	60EJHQNAn6oWDxONeYhml/jkPWzsktnZfAbGu7QXbKU4uStt92av+QN+OdR9XmEIju6dCx71YBe
	Lu9uGwUYeFvWrZVWBMocTFHzztPyagECGq+90iMd2OW9ocvy8nM6jXz4kKshlgL5o9A==
X-Gm-Gg: ASbGncv5pYg4GKdO8XPEqF0fOoX7n8oWKQIauChjQ+oDZ5JAX9XogYQtw+Or+HTIS5j
	3APubBoEKFq6gRjMBLqA650rE1vKodfFG1ve0vy6/1GYmsRJO89/Tng6Up0KFc3a6dJejpkQQO3
	JYSveDIPffWMq+n6akVNQT7G2y/EEa89NtRPxj+o5F6aTqC8oDn0cJP0hZR1L02fqX/rlxJFZdN
	A/p9vnRemnOo+e5G6nTnTAHlhkrczzS676tfPLEfwv8YM9mWHXYKne8oFRkA0r4vqiV14FuuUxq
	UuKo6drxlckqsLy4jNeGTu/mL3wVAwxqELgU+eCEnsokEVnrFrXD/+DeHbhDBxTvHf6pvZb6PTs
	WKeJ67UCRjZwwWcu8EGlO3bE6fPwdwvUz0VKpJ3m2HkIcNUF1jfA=
X-Received: by 2002:a05:620a:44ca:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b29b78a980mr307073785a.37.1762946109820;
        Wed, 12 Nov 2025 03:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtAKTvMbP3cFM+QNIMi0izCHSApoyYNJQFMwUCPX7a0E+uO7ILp2ns+ST+uoNT4M7IO7oCPw==
X-Received: by 2002:a05:620a:44ca:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b29b78a980mr307070285a.37.1762946109277;
        Wed, 12 Nov 2025 03:15:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa277ecsm170269385a.58.2025.11.12.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:15:08 -0800 (PST)
Date: Wed, 12 Nov 2025 12:15:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 01/12] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <kitbuqe5a2tyjbtjcyijcpqioidmrxa4b3iq7kulmbngofyt4l@d73gmgipbiid>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-1-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:52AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Improve usability of logging functions. Remove the test name prefix from
>logging functions so that logging calls can be made deeper into the call
>stack without passing down the test name or setting some global. Teach
>log function to accept a LOG_PREFIX variable to avoid unnecessary
>argument shifting.
>
>Remove log_setup() and instead use log_host(). The host/guest prefixes
>are useful to show whether a failure happened on the guest or host side,
>but "setup" doesn't really give additional useful information. Since all
>log_setup() calls happen on the host, lets just use log_host() instead.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- add quotes to "${redirect}" for consistency
>
>Changes in v2:
>- add quotes around $@ in log_{host,guest} (Simon)
>- remove unnecessary cat for piping into awk (Simon)
>
>Changes from previous series:
>- do not use log levels, keep as on/off switch, after revising the other
>  patch series the levels became unnecessary.
>---
> tools/testing/selftests/vsock/vmtest.sh | 69 ++++++++++++++-------------------
> 1 file changed, 29 insertions(+), 40 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 8ceeb8a7894f..bc16b13cdbe3 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -271,60 +271,51 @@ EOF
>
> host_wait_for_listener() {
> 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>-}
>-
>-__log_stdin() {
>-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
>-}
>
>-__log_args() {
>-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
> }
>
> log() {
>-	local prefix="$1"
>+	local redirect
>+	local prefix
>
>-	shift
>-	local redirect=
> 	if [[ ${VERBOSE} -eq 0 ]]; then
> 		redirect=/dev/null
> 	else
> 		redirect=/dev/stdout
> 	fi
>
>+	prefix="${LOG_PREFIX:-}"
>+
> 	if [[ "$#" -eq 0 ]]; then
>-		__log_stdin | tee -a "${LOG}" > ${redirect}
>+		if [[ -n "${prefix}" ]]; then
>+			awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
>+		else
>+			cat
>+		fi
> 	else
>-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
>-	fi
>-}
>-
>-log_setup() {
>-	log "setup" "$@"
>+		if [[ -n "${prefix}" ]]; then
>+			echo "${prefix}: " "$@"
>+		else
>+			echo "$@"
>+		fi
>+	fi | tee -a "${LOG}" > "${redirect}"
> }
>
> log_host() {
>-	local testname=$1
>-
>-	shift
>-	log "test:${testname}:host" "$@"
>+	LOG_PREFIX=host log "$@"
> }
>
> log_guest() {
>-	local testname=$1
>-
>-	shift
>-	log "test:${testname}:guest" "$@"
>+	LOG_PREFIX=guest log "$@"
> }
>
> test_vm_server_host_client() {
>-	local testname="${FUNCNAME[0]#test_}"
>
> 	vm_ssh -- "${VSOCK_TEST}" \
> 		--mode=server \
> 		--control-port="${TEST_GUEST_PORT}" \
> 		--peer-cid=2 \
>-		2>&1 | log_guest "${testname}" &
>+		2>&1 | log_guest &
>
> 	vm_wait_for_listener "${TEST_GUEST_PORT}"
>
>@@ -332,18 +323,17 @@ test_vm_server_host_client() {
> 		--mode=client \
> 		--control-host=127.0.0.1 \
> 		--peer-cid="${VSOCK_CID}" \
>-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
>+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
>
> 	return $?
> }
>
> test_vm_client_host_server() {
>-	local testname="${FUNCNAME[0]#test_}"
>
> 	${VSOCK_TEST} \
> 		--mode "server" \
> 		--control-port "${TEST_HOST_PORT_LISTENER}" \
>-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
>+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
>
> 	host_wait_for_listener
>
>@@ -351,19 +341,18 @@ test_vm_client_host_server() {
> 		--mode=client \
> 		--control-host=10.0.2.2 \
> 		--peer-cid=2 \
>-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
>+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
>
> 	return $?
> }
>
> test_vm_loopback() {
>-	local testname="${FUNCNAME[0]#test_}"
> 	local port=60000 # non-forwarded local port
>
> 	vm_ssh -- "${VSOCK_TEST}" \
> 		--mode=server \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}" &
>+		--peer-cid=1 2>&1 | log_guest &
>
> 	vm_wait_for_listener "${port}"
>
>@@ -371,7 +360,7 @@ test_vm_loopback() {
> 		--mode=client \
> 		--control-host="127.0.0.1" \
> 		--control-port="${port}" \
>-		--peer-cid=1 2>&1 | log_guest "${testname}"
>+		--peer-cid=1 2>&1 | log_guest
>
> 	return $?
> }
>@@ -399,25 +388,25 @@ run_test() {
>
> 	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
> 	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
>-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
>+		echo "FAIL: kernel oops detected on host" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
>-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
>+		echo "FAIL: kernel warning detected on host" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
> 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
>-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
>+		echo "FAIL: kernel oops detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
> 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
>-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
>+		echo "FAIL: kernel warning detected on vm" | log_host
> 		rc=$KSFT_FAIL
> 	fi
>
>@@ -452,10 +441,10 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_setup "Booting up VM"
>+log_host "Booting up VM"
> vm_start
> vm_wait_for_ssh
>-log_setup "VM booted up"
>+log_host "VM booted up"
>
> cnt_pass=0
> cnt_fail=0
>
>-- 
>2.47.3
>


