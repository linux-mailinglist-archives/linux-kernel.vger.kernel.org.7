Return-Path: <linux-kernel+bounces-886641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE7C3624D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A52B74F951B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165723BCFD;
	Wed,  5 Nov 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBAAXVfd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFXgyRZN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B121D3DC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353918; cv=none; b=aijPNAsjdQilKdJcJEHABSjblHVyEi7xT5Otowvz1eUArDhrprxE6O7JAynR+wFM4AHfKaaluOfLOfIMyy9gULL2kCEoRv5VSzDcIGsJdfUZ59zA+Bo4qEZ36QUOye9yYDF+F/UHCU4zcGyggysITyy8I/LAZNg0YcfAS2/ZkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353918; c=relaxed/simple;
	bh=P/3UCIyRDs5TY+J7sM5xjumdLDz5BUHqvdnv6ttKM/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss6yxIwU1i2osVtN0thttNiWmxGKvSVQgiaErA8MPG066iwIQ/hYCRpWgBaBsNxo/3bd4I0NN2wr91v4RTn518tMcdU4KTTGASoXSwqVs1+BPpVipCo7Zd38eD9g+oQdNcjUIzUVjggKnhRV3ro1pP+yGe3HRWS+KyejRDVPnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBAAXVfd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFXgyRZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762353915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOr/G235OdnGiS3F/X+GMIZ4jLjPZ308LjzapW+sWDY=;
	b=dBAAXVfdqucE9FZBjgOrqFAJ56IB233nPnlW0Kp8eKXbElRtwlerhZtU4ES/qTSzVsDFRw
	UO7wtg5mAbf1VdR3ZG5fwjw2HOi8twWYBoN1HXJkmdK3u0Qp7F/jjFjmOlhNCATu2VlAva
	ILL1U+aVqenSV4V1qibHDZ/Kv9TI69o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-s6TpSIjyNDin08crS8Ff-g-1; Wed, 05 Nov 2025 09:45:14 -0500
X-MC-Unique: s6TpSIjyNDin08crS8Ff-g-1
X-Mimecast-MFC-AGG-ID: s6TpSIjyNDin08crS8Ff-g_1762353913
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c7b0ae36so931410f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762353913; x=1762958713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOr/G235OdnGiS3F/X+GMIZ4jLjPZ308LjzapW+sWDY=;
        b=hFXgyRZNzBesEhpnkl4cIiAr9E+WjDzTpuwqkQMqT3SasMtqhV9WVpqfyn5nuO4iNW
         gac3sldQWp+7X3c8Au+8FEi8zsWh4gdFf2TL5dAfSFWiU7r9FfKjFaseqw9cFcMl3hvR
         xU+ZsBGnatI9aK2YgMRCcT1MMZX4EawIvJZMc7d9V9zX1GJDQz7SvrE9AITFzWGSPlIg
         ZN9qHprWuCQKO5H1rSzTaOAgkLhY36kD2Y3LyY0F9sQQ9xASUpoSpoRpVCk/t7FTx2u2
         q527r1g8TNjhH4cJGIe30W+QvPlcCEqAABL6fW/8VeOdtuckYcg9AKzpON6xwPo3QcUR
         47PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353913; x=1762958713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOr/G235OdnGiS3F/X+GMIZ4jLjPZ308LjzapW+sWDY=;
        b=VYDVrz086Mxux/Aquv9ufJdESfw3g92Q0I39E78NpOvb4GxvS61hEtXsHRTgHZy46R
         VB8c9BOQc1qRkhFQv2tHbtfefLiATtm6EhL1SvULA/nEeYrwqGmNB4ufdsjn+dj+SBEv
         O+/qU4t77SSvVc2TM1x3/98rnjjn1nk2QonW4d1J8Su83m9r2sx7I7EUMY9erxji74bT
         7RO6OpJNeQavmZeP9onhrmIAzONJ6PJ0fDPmbAe/3mhU1iiLL6B1oEmNXgaUj4lLyt0U
         QxmARqTIJRGIaMhTw8VXzzLt8MojX0tS4izuYT9RWr2cL+NSKiOpZGPkmnLS5c9RtKeo
         J2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU92qNh8oG4L1TFD05q+wc0N3KrIOBbhn/pm0K/3BMo+p87GldkHMyTGbmBLam8Y8y3Nt+PkN+f9wr1xLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCVD5aleFMakqds7wngyUPl60IKwhBqeD0Vh2r+jzbsyMMb0l
	jF4djmAmxjVwXmVhhGNgZwM4JQNOdUDBdhelCvlUqBbmESUx9DVywutpDEUyOIQMFLucmGPJHwm
	trr5UPStEe/NM8MEv6UosRzSs/HoCj4qzOo6cT0bDSQH8cx8wRSOlIPT8ZayVYhY1GQ==
X-Gm-Gg: ASbGncsEvEuaLdF3qGlF/w5m3HvDgg0YLKGrgGphvy1F8+lHmlnAPPgT5Cs8gjyyAGd
	8la9YNX0Hkm7bg7+Oo+Ni0eLCQmkHaCbwSxw4cExPAOCxQv5/Mp1DszP5aGxeGL86Cma+WLk0hN
	1oJVBFWjEdD4q9lw+Vz0gr5EawCc+Jji4bYE0LUV7yEJ2+ICO99sf9nSfZjxBgAshnt63SEIoKc
	sgubJolTfocONfYgY5NBnpEqCEPlyLC5nH2u5tKfcyVBCDy6eNBMNBzGhhWbydPKLYtHPly4tCV
	idhYDQBIUAtMMYIi8i8DtBV1j9vuLG9HGbJvTgrZte6WAwJyltQy4APlowIVjZA6sCUIv4y0CeY
	=
X-Received: by 2002:a05:6000:2883:b0:429:d3b8:7375 with SMTP id ffacd0b85a97d-429dbcc5d94mr6660630f8f.2.1762353912875;
        Wed, 05 Nov 2025 06:45:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5LAfcIKI+UGb+/zhR4tf/kpuE1QbENGNGMuBGWjUYd5tgElIuXzgUwRSVpo80Ale29EF9cg==
X-Received: by 2002:a05:6000:2883:b0:429:d3b8:7375 with SMTP id ffacd0b85a97d-429dbcc5d94mr6660597f8f.2.1762353912389;
        Wed, 05 Nov 2025 06:45:12 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbd1csm10956989f8f.38.2025.11.05.06.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:45:09 -0800 (PST)
Date: Wed, 5 Nov 2025 15:45:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Message-ID: <ohe42glr4yn26ql5fdvrwrhawfqo2vy72i4zofjqwyqba7wwdj@5usmy5fczxhe>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:38:58PM -0800, Bobby Eshleman wrote:
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
> tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
> 1 file changed, 50 insertions(+), 13 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 4ce93cef32e9..678c19e089a2 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -45,6 +45,8 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+
> VERBOSE=0
>
> usage() {
>@@ -443,7 +445,44 @@ test_vm_loopback() {
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
>+		check_result $?
>+	done
>+}
>+
>+run_shared_vm_test() {
> 	local host_oops_cnt_before
> 	local host_warn_cnt_before
> 	local vm_oops_cnt_before
>@@ -517,23 +556,21 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_host "Booting up VM"
>-pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"

Why here we used `mktemp -u` ...

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
>-	check_result ${rc}
>-done
>
>-terminate_pidfiles "${pidfile}"
>+if shared_vm_tests_requested "${ARGS[@]}"; then
>+	log_host "Booting up VM"
>+	pidfile=$(mktemp $PIDFILE_TEMPLATE)

... and here we are removing `-u` ?

If we don't need the dry-run, I'd suggest to remove it also from the
patch that introduced it in this series.

Also, maybe we need to quote $PIDFILE_TEMPLATE


Stefano

>+	vm_start "${pidfile}"
>+	vm_wait_for_ssh
>+	log_host "VM booted up"
>+
>+	run_shared_vm_tests "${ARGS[@]}"
>+	terminate_pidfiles "${pidfile}"
>+fi
>
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>-- 
>2.47.3
>


