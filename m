Return-Path: <linux-kernel+bounces-897103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80120C520FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C26064FA41D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878AD30C34E;
	Wed, 12 Nov 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAs6Fmxc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8DPV1Tw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4E2FE06F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946842; cv=none; b=TxRS6gxoRr30cnucBMVmn66HKu3YF4iYwJ2y3n2SkedKjIQjKpOd4MoX/6aPWpUWtch07U+7UpXA9UcZVMekWwrrU0R6dAcpUvgxjeygvbhfhSiM9mOcSkFkbVAXjp4jseLCaUGiyZPW0xgAopFeXcdnARQVNf0/EdEKrrXEF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946842; c=relaxed/simple;
	bh=4GFpYouVGxOOz3psCxGWSSpIfASjL19wnjG0Y6Ssa1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRI9LlpSIR9nyl7FW1EkrYK0glRItZ+attFmV0ZPH+TnyXzeBYkOF7677UlPYb+5HPzNpKei26b35EjKvFNHIJyhvx5YUBQqZoDCvv+D10oHGN2glhyxSkoiTB7RwhQYVil7+A/UCM965+CmcSggsrxZcrfXO8gGqOjO6P9V46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAs6Fmxc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8DPV1Tw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
	b=JAs6FmxczLOe9kGN/JS3KoHxZ3f59VGcHRYA6KFvO1zDf9+CXkjL40/1ueaehjmsgjM5Dr
	owTCm20AhsBDT/XplV5jpoImydfWz8TLceQyoHthjnNgEOLu7FGrdeVuetNxPQuqtlHRtw
	BVQMByBgrLpDkLeslQ0q7hqCAX8TpVA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-seZ5iKdaPcORo8AuvFewIA-1; Wed, 12 Nov 2025 06:27:19 -0500
X-MC-Unique: seZ5iKdaPcORo8AuvFewIA-1
X-Mimecast-MFC-AGG-ID: seZ5iKdaPcORo8AuvFewIA_1762946839
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b23a64f334so217023985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946839; x=1763551639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
        b=a8DPV1TwbETOlFj8Yc3dn6zgh35lxxw0bxA/TL9apt+2as+kVxGHnjbEKejLfjx0pc
         jbYrUKujYNJXUZ4snxdXs80almFhIqId3+W5wwY4W7yTejMnAyhGPqw6XLIMTEj3vsAo
         gIlmf3/4KwZ32hxa6m+fqrOG0I8Ngi0CVRZ4dHA4E3GG9AEBzAlW+a8iCgRpiKsAhsOg
         jmWN8RNpw72wQnP0WaPOkhgLMq2a0/xryL6X4eteJruqmzT2zIq3tOWt65hzO1j9SybX
         yvsw4ynAbnxMaMuR6XWbvKPRHXMTJw3XlqJvi5Sswo0dBBdGCr9gxXDYBZr+j5UqlbRa
         19YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946839; x=1763551639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVtwZ9kMXMWaALslBegZBLpPlSTJZmxBrzThhFU7zE4=;
        b=MoGUIEFibOiY/OeZuEpQibFH9KUUPAN4SHkTZ5GsUwZjosI8jUujeopFyx2vHDTZlG
         5+mOhjjne4/fpuPkEhIDFsBWVUT7lhRk85Q0S8gHEHOgwQclNH0Faw3zWYhkB5nfus4Z
         BfQPx/kLEcfdZNMkSxFhWHeuywnu9uKraSCbapgOGf66qaRUcyWhYRQzb8ZGZTWGEdNE
         Gqw9x4xx4Gud0o5SVoO5ciHFgU6heNRKNf1CowHtalJzCpJ5JIRmrP7ptqS5idziIqmi
         9nvGAE9+vqHQquhtjlzXul+fC69JBix+9T2zxzoIRN6AvMRY0cnPavdZ8iuJETRPcAmR
         rjUw==
X-Forwarded-Encrypted: i=1; AJvYcCWV/aP3MOK3Chv+sdxRjgbTMNd76oPs3smocBye9wBR0GXCd4KzGLvAveH1NHngQl8EI9+lbN1xhmMjgpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/hZdgOdg/6MMZeRetd96umuats/dT5r6UPwHFhQNkRB73EFu
	LgaUYX2hY5bMjPPvEAfXOa7lTtsspTz4z7uzzIRZGJMdjIt/JwBWcHwvENyMIGaAYrCw/SUMYRI
	eYk67/wbgaHwe7oGHClpvI8EVVqK7Crm4s0Z/dQ1bznHrxSrmoq2LGDRTnAG1YYt6Jw==
X-Gm-Gg: ASbGncsLNmsF8lYGdlZFr2sdpWR7yE+GgbhUnW82nmsCq4LjCyUCvKhtMnBFFgiozot
	GhmdMrWJ5cMWwIyGAnkVsKEUzPFixmfJu3G5Ok9Y/hBj3RH9XTfya27H9ALytMj1VBkafm4jAY2
	XgxoRDAKM8/bFSqU6D6A3FP9gDXT5T6O9zNiwBlKmB/kehgoczuIV5y8bOhz3OLBhmCQ3J0ISHg
	bZHKFpxvin5vAXgZCs1NfsL2iD6x0tOOKFjL8vnIW5ip3a9/YW4bTj7xduJG6Vq6BFvIUo82YaR
	q1ik0XF8TNxrBR0Ew8MLd8F/T8zUA9579GWDN1JZK63xMSPnU+9a9ibFrTLA903UTIbzqpxTVSR
	2lzAUQ7xbHBzYCqbBityzbEvwUzuHF341kX3k205/1YpQQ4J4Bs4=
X-Received: by 2002:a05:620a:7107:b0:8a7:2373:1c75 with SMTP id af79cd13be357-8b29b7cd25amr301639385a.49.1762946838663;
        Wed, 12 Nov 2025 03:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiq2o9VPSKEA3WnYmptOCbMHYXZ1Xc1tiIgbtvh2JnbBd2gww/tn2z5FSFACTcc8Z6rSWeNw==
X-Received: by 2002:a05:620a:7107:b0:8a7:2373:1c75 with SMTP id af79cd13be357-8b29b7cd25amr301636985a.49.1762946838217;
        Wed, 12 Nov 2025 03:27:18 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84b075sm176497985a.7.2025.11.12.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:27:17 -0800 (PST)
Date: Wed, 12 Nov 2025 12:27:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Message-ID: <z2lxg6zlt5l3f2fhx6lwfeiu2tclm4o4et5wykraonyfjlayos@oatpvj3hk6om>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:59AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>In preparation for future patches that introduce tests that cannot
>re-use the same VM, add functions to identify those that *can* re-use a
>VM.
>
>By continuing to re-use the same VM for these tests we can save time by
>avoiding the delay of booting a VM for every test.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- fix botched rebase
>---
> tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
> 1 file changed, 50 insertions(+), 13 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 2dd9bbb8c4a9..a1c2969c44b6 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+
> VERBOSE=0
>
> usage() {
>@@ -461,7 +463,44 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>-run_test() {
>+shared_vm_test() {
>+	local tname
>+
>+	tname="${1}"
>+
>+	for testname in "${USE_SHARED_VM[@]}"; do
>+		if [[ "${tname}" == "${testname}" ]]; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+shared_vm_tests_requested() {
>+	for arg in "$@"; do
>+		if shared_vm_test "${arg}"; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+run_shared_vm_tests() {
>+	local arg
>+
>+	for arg in "$@"; do
>+		if ! shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		run_shared_vm_test "${arg}"
>+		check_result "$?" "${arg}"
>+	done
>+}
>+
>+run_shared_vm_test() {
> 	local host_oops_cnt_before
> 	local host_warn_cnt_before
> 	local vm_oops_cnt_before
>@@ -537,23 +576,21 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_host "Booting up VM"
>-pidfile="$(create_pidfile)"
>-vm_start "${pidfile}"
>-vm_wait_for_ssh
>-log_host "VM booted up"
>-
> cnt_pass=0
> cnt_fail=0
> cnt_skip=0
> cnt_total=0
>-for arg in "${ARGS[@]}"; do
>-	run_test "${arg}"
>-	rc=$?
>-	check_result "${rc}" "${arg}"
>-done
>
>-terminate_pidfiles "${pidfile}"
>+if shared_vm_tests_requested "${ARGS[@]}"; then
>+	log_host "Booting up VM"
>+	pidfile="$(create_pidfile)"
>+	vm_start "${pidfile}"
>+	vm_wait_for_ssh
>+	log_host "VM booted up"
>+
>+	run_shared_vm_tests "${ARGS[@]}"
>+	terminate_pidfiles "${pidfile}"
>+fi

I was expecting something in case the VM couldn't be shared, but I think 
we'll add that later. It's fine for now.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>-- 
>2.47.3
>


