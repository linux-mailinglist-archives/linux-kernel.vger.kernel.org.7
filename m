Return-Path: <linux-kernel+bounces-886606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC76C360EE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1671C1A22BE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE6332C33A;
	Wed,  5 Nov 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBjFk+zP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nZD7MODi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41253176F4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352761; cv=none; b=hwGjIo6d6Sal1g01pwlKpi01brJMmam8F/hLxAbRLl5nwmytRdT8q+ZernFNj1RELSORsSImKk07TSpj6n08JDcYJR5MXzrD3DcXwcPU1pj0vfaVovU65Xt8qlIBOrvBaXwarnNUMFJucAC0HQPnD8VEfVyonKsT0HFMkhbLSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352761; c=relaxed/simple;
	bh=N+EK1Kxp8qxWEiuKYA9xEBkqzBsi1k8ar4ofTabGyVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rICmrvkGeVfFwoAElmjdIB3X3aZA1FjZ7y/cdlm48nMYl8ul8ZQd11gxKmbgpv5qo2rOsJUHRcjA2SBExmu9mQaJa+m9xeVzLGuTq9rlBP/ZQr8ovR7UIUgITFLaEm7fhGY9FGfRoIowdRUJCMwMqcFral9yOhX8XOvPW43XVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBjFk+zP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nZD7MODi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762352758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Haea4m2+uFf7hS1qpomFR5hmGiTU6exHIPsfHUZpCc=;
	b=OBjFk+zPD55jWgWWRQilLghbPsg8CcQG9w6OujDjGIPPvqmKrkBi4+1rouacFOFESgYDyU
	rEk4mNPiOEtoF3aIwuKFxtgxp4JO5kASh7+eJ1Bt9QpYSyTuNJsIHyKFNYBAeocsskpeXC
	5Nhxs1ISbGB6eurPjudGFjqJNYeMAms=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-9ppaQVuqOlS3hXSHLUx9bw-1; Wed, 05 Nov 2025 09:25:57 -0500
X-MC-Unique: 9ppaQVuqOlS3hXSHLUx9bw-1
X-Mimecast-MFC-AGG-ID: 9ppaQVuqOlS3hXSHLUx9bw_1762352756
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429ce8ac89bso2939994f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762352756; x=1762957556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Haea4m2+uFf7hS1qpomFR5hmGiTU6exHIPsfHUZpCc=;
        b=nZD7MODiR7PEoyl0xE+E7GzTQDbHsIPZXYgjMhphS5ciuwvbGP8KZ6jiBLfZbfc5L9
         D2Wsmao3dnrm3y/4WezUDOoXATfLUeFyOuXHU2cVyl1+ch2Z69iBEEAtufEdDmM4o1oi
         yYJAUr2F31G5hmvEhG/EFWKde8uCrR8QPPyECY2QKtIWsDMPUzAYlDml6FysL97zcI4t
         DSME7lOKR31VKT+WQbQKHESSeDBXsd8iCHj6iJyu00+sNNiJsu0hu9R3eFYyDotZaL93
         uEVE8FbodTLVsuox8GCzeqLnj0R7Ri7O+xxy5JUx+EFIuu0lx57wZAXqyhamXmBaWtms
         vLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352756; x=1762957556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Haea4m2+uFf7hS1qpomFR5hmGiTU6exHIPsfHUZpCc=;
        b=XoHzO72cNFaHnxvBzh7tldv2NEd5ly8Tjxdg6czG0Ken7lshIRjXIsg+noILVbVfG2
         10K2eHQ6LcrRpKDlYsR1L5illwam95Fnm0P+dO0HcZth5Ei9BVz/a8yaRt0DWf0X+12M
         fA2AwkQF4orWINKmuL+8SHmntnTEVJfW/ByBI4HPMKvd2FJameAc3DQpsCZ3t0rUo5lI
         PEODiXU7Q3ZHi8GfH3JLK9/vlNFb4RueHsmaAv098rNmU15fw2UEwn/LS+dCCm5jKp6A
         2B/oj52642/ipDFzQmq4nP5v5zEhU9jajPe/wVjcrsX50zn5oXNFyXcNQ/PSSAOOwpd6
         gI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNIKcFO87wLTFWyFpI5w+vmsS0yafcN8BKhaj5viJcTNkRPITQTs1eYEm+/P+nVmw/CnEG09WdTKFxdWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7K8BSFF4UaU7iTwD9GEn8vjXMkKvJxhbvisdAP2HaMQExO/vl
	ThOIz36Kmsu1/mdiIb/wxpP6+Zj+bdmzmIalFckH/rYdEJraqYzLg31DeJgwZCATFKq8MIOTPbG
	cyOyPfwoFISkJQk7Yfdi2OwriHohOmy07kl8Uu95+k3zRRcTs29cppTjabK9WgyHHGg==
X-Gm-Gg: ASbGncu4hnh53Nta7q8SCo0EpePOokTzaVv0ZoWta5SQn7PSengVOMjYYYD4i/llGSV
	4achM7nvtLCG5JnV8FZ9jEdVNJiWiVOaePc6cDrFqPckr38byDAIY2hblDvq+/nR4X8fIHPSdax
	9yyNklJ0gA7Qt8pqcMtf9oGY1JUnZXrx2VyVr6uGRHhlIMXeMR6qkWpYMEbfzu1hmx7cWM6l2NJ
	UNAY6w4bflMtZwkOomMs3bWve+NSKYBaaQ98hjCR4rdvnHWTt1hkQmnRAcwlTJgRKYH3bBtltkR
	rCl5/3haKp+24JoB2OcOGX0UwIyhOiHsIibaoKt+H7Zxtup8gG+BVg2aTaavq4KSgaulkjIMKPc
	=
X-Received: by 2002:a05:6000:40da:b0:429:ce02:c895 with SMTP id ffacd0b85a97d-429e330c220mr2577746f8f.50.1762352756187;
        Wed, 05 Nov 2025 06:25:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4x/Sllh30KcFpre6XL8hFdFV5BshGdQVTU/zf2P/M8C1K9+V8heW7EYih3ymwmEoRBZPFvA==
X-Received: by 2002:a05:6000:40da:b0:429:ce02:c895 with SMTP id ffacd0b85a97d-429e330c220mr2577713f8f.50.1762352755717;
        Wed, 05 Nov 2025 06:25:55 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm11067852f8f.44.2025.11.05.06.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:25:55 -0800 (PST)
Date: Wed, 5 Nov 2025 15:25:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <bvzstd363kuvzfnxg6r3dfxtkqswcdz677rpvutgugfep5ecsx@6rlyaud34g7e>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:38:53PM -0800, Bobby Eshleman wrote:
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
> tools/testing/selftests/vsock/vmtest.sh | 130 ++++++++++++++++++++++----------
> 1 file changed, 91 insertions(+), 39 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index da0408ca6895..03dc4717ac3b 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -273,7 +273,77 @@ EOF
>
> host_wait_for_listener() {
> 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
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
>
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
>+			return $rc
>+		fi
>+
>+		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"

IIUC host_wait_for_listener() doesn't have any input parameter, should 
we add them if we need to call in this way?

Stefano

>+		rc=$?
>+	fi
>+	set +o pipefail
>+
>+	return $rc
> }
>
> log() {
>@@ -312,59 +382,41 @@ log_guest() {
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


