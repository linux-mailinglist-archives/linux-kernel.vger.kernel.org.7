Return-Path: <linux-kernel+bounces-897099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0AC51FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53593B3ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39E3054E1;
	Wed, 12 Nov 2025 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic1Pjo9L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS6O0bCC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F589309F08
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946703; cv=none; b=tE7CdoKuTx2kWJiiX8mGpbtpVj0B6Dxwh3qoH7kdR+b75xcaT+wkUVZ+sKIp+rR9uiG4X4/GDZjSvuLXOobsZSc0xk/LXWRJOpuUHLGBHz0kO30rvB2D3FnCPOFt3UZ15G+HJGHmso2BSU+kJv8dW0kehJ4t+CNGngJP4b0dkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946703; c=relaxed/simple;
	bh=7Pu0o2x/O51dsOpfT3kiDBb6OdNE43A6rRDatL6h080=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT6+rIR8x+9f2Q3B5tT74VkWtEWbqTCM46GOn5YVPlHRDwmzI7XLynnTc3afsEDErVqw/ZfLw3x2rKX58qj/CrZAEcdypWlI1Bfpv2Gcdn79yRCQHCQTtobe+Twew+nYgSMJV6s4VhBxu8qzLg6IwJF01FDwhC08DmH8d0g2Bio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ic1Pjo9L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS6O0bCC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
	b=ic1Pjo9L3JFoaJs8/10KGQpDqw/H8OewVv93cdueooWGMuvqJ60VZyNFjXMVr8bnQqisPk
	y4o6dsyj/GAHObhbJJ3QzK9M341X0zq6KR7a6skhk86hCITho5I9g9MR6t/5eo1nq4t63D
	xOi6rFnGuRdsife97CbxxIAMxuTpMqo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-sS113mSrPDaR5R4Z8n11rA-1; Wed, 12 Nov 2025 06:24:59 -0500
X-MC-Unique: sS113mSrPDaR5R4Z8n11rA-1
X-Mimecast-MFC-AGG-ID: sS113mSrPDaR5R4Z8n11rA_1762946698
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-882376d91beso21253666d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946698; x=1763551498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
        b=CS6O0bCCGIyzstZHWQso3CaY2SZlNzvT12Csfr2FoQLqb8UNiEYCgEgFff2Xfd2ak4
         LF6nwUvq7TZfqEP6TU3MvLmPuBLI5+HPbaE1qGO6ZbxpixjO2GQLEMQ6XSzAk2Kkj8a6
         cSnblLmWyxj2eXY7Nn+o4OAvIhzsMWLj8RgsXh8sykPYzioLl3VBYw2cSZNwlOedsZ/U
         1xaDJ7cT/gLPb2CYmo+0rw1hE+v65Wds34wF1NCIqsMKHJ7zEDDJt/+FOhPb6m3c4cDE
         ubsazwaK8EQAzRpab9VBSKdMI/Ax09U+jh+pTvp7r1SEtBomx2pmpSuK2USsvQqjAg9q
         SlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946698; x=1763551498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+7K4dIhyJN2R790pmm2/Yh3kYrLGArEUHflkSvPh5s=;
        b=W9dVCOUbYIDWGLISFa5DGLLpG63lKuZqdt1HRrZk3r0tj8mmOmWPTrQ4V0EkhG4sV4
         aXU8TDtf48ufgo45DgGxbAANefzi37bEtl3nfBE/J1cfSA68iWkJY3acHmZPWZbB0I6E
         lU1so4+cqJZEctsnEEvWI2LBnwXDAP9hDt7mJxTTnMZBGf/3LRuUBfZce+WixtnpFOL8
         aPlZQkKCiQI7ZHzUkI5T6M3o7ZSjrtS5WxVPkk9NaIuIensDxzyeS4JrobdRejCZDjsv
         DCfxhLVI4EOTdHZ0Jn0H8xZi93mjhCf2plVO0tVcBKQ9VnGeKDUbbupgYlXXq757lQ9F
         KLng==
X-Forwarded-Encrypted: i=1; AJvYcCW6DvjdvGDeD7OVcPBJMFTBF4MEgSzT05/qqJHZe2isbpJDBG21TqnRuL3VutcX9RpZ8a6osbdaHlu7Fhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkrm0dNWbxKd2Ufo/S+DVb0WMbxVN09F8KTf5gV2NQmVx8psD
	G+lwaaY7mrYRkBJMaWmaT2dFP5zpXpFv/RmEZPWTaIqHMgITGWUSYxGYMnGjMJRRN1pTBkmvGDU
	c+e/EJ/w76CfHXZKhD2+K7a4LeVq9AVWcF/oLqsGNBYmRCN7HeE5Dpw5sfiTC9SHAAA==
X-Gm-Gg: ASbGncvb/YQq6QHgnVzlM9yZKJkw+VJr/yoOPc2fVBDKSqoVwkLZqsxFH3VIIylCRhx
	Z6neLovsk6laB7YarVUacXbQ0YtbLnU2x8LROmgKY4c7FDkAYjqPhwd1RwKKHhdXE1Qk5uxm25W
	1dauaxnhTu0WctljOXHjO25DdwqSYg5Y5xqAgpp2yVSDCJeUfnfbBDIp6Zc1cGkYz1Y6k9jfNzU
	9ZcsoeHDSGz/mj6w2HNxbbzPTGmrMXVwvQLy0eH+ZO7E6FVs/aWLzV+MNPUG8/sfeUnpBltpyu7
	RKAc1JT0N+XEKGTOGoMe6JoPpYEteC6RFAPFgxCs9xF9Sh28I0fkEalhP8qsGS1tdvgVgtnbboE
	S/SRA2ehB9EXDK3UtjY/Ylwe+wvQiDgnFRcPNEEHuxhspTGRhwWE=
X-Received: by 2002:ad4:5f07:0:b0:814:2a4e:efbb with SMTP id 6a1803df08f44-88271a3ca3emr36868246d6.53.1762946698649;
        Wed, 12 Nov 2025 03:24:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg23TSNoDmt+ZtfObVKbv3IEADZ/iTaXYGqZ7/Rp75tiUGAUlZRDyDCgloNS0C23doS3gbzg==
X-Received: by 2002:ad4:5f07:0:b0:814:2a4e:efbb with SMTP id 6a1803df08f44-88271a3ca3emr36868006d6.53.1762946698263;
        Wed, 12 Nov 2025 03:24:58 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm90041186d6.53.2025.11.12.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:24:57 -0800 (PST)
Date: Wed, 12 Nov 2025 12:24:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 07/12] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <2ujds4l5ji7pdm7lczttukisjdoo5z5ufufw4kd3qyls26o64o@43yt3nkohsm6>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:58AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add check_result() function to reuse logic for incrementing the
>pass/fail counters. This function will get used by different callers as
>we add different types of tests in future patches (namely, namespace and
>non-namespace tests will be called at different places, and re-use this
>function).
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- fix botched rebase
>- use more consistent ${VAR} style
>
>Changes in v3:
>- increment cnt_total directly (no intermediary var) (Stefano)
>- pass arg to check_result() from caller, dont incidentally rely on
>  global (Stefano)
>- use new create_pidfile() introduce in v3 of earlier patch
>- continue with more disciplined variable quoting style
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index bd231467c66b..2dd9bbb8c4a9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -79,6 +79,26 @@ die() {
> 	exit "${KSFT_FAIL}"
> }
>
>+check_result() {
>+	local rc arg
>+
>+	rc=$1
>+	arg=$2
>+
>+	cnt_total=$(( cnt_total + 1 ))
>+
>+	if [[ ${rc} -eq ${KSFT_PASS} ]]; then
>+		cnt_pass=$(( cnt_pass + 1 ))
>+		echo "ok ${cnt_total} ${arg}"
>+	elif [[ ${rc} -eq ${KSFT_SKIP} ]]; then
>+		cnt_skip=$(( cnt_skip + 1 ))
>+		echo "ok ${cnt_total} ${arg} # SKIP"
>+	elif [[ ${rc} -eq ${KSFT_FAIL} ]]; then
>+		cnt_fail=$(( cnt_fail + 1 ))
>+		echo "not ok ${cnt_total} ${arg} # exit=${rc}"
>+	fi
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -530,17 +550,7 @@ cnt_total=0
> for arg in "${ARGS[@]}"; do
> 	run_test "${arg}"
> 	rc=$?
>-	if [[ ${rc} -eq $KSFT_PASS ]]; then
>-		cnt_pass=$(( cnt_pass + 1 ))
>-		echo "ok ${cnt_total} ${arg}"
>-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
>-		cnt_skip=$(( cnt_skip + 1 ))
>-		echo "ok ${cnt_total} ${arg} # SKIP"
>-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
>-		cnt_fail=$(( cnt_fail + 1 ))
>-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
>-	fi
>-	cnt_total=$(( cnt_total + 1 ))
>+	check_result "${rc}" "${arg}"
> done
>
> terminate_pidfiles "${pidfile}"
>
>-- 
>2.47.3
>


