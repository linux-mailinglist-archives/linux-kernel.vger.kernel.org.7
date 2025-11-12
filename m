Return-Path: <linux-kernel+bounces-897071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA92C51EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE043B538C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3C2BDC2A;
	Wed, 12 Nov 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tyzvjtvl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="COdfgtHA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33524BBE4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946138; cv=none; b=CALIpQ1KWBSiHCtQaRy04lGdDJSgm2mxmC7oJdlHFxteISTDL+z51N86U2DhH42ijGXew1B1qcnfhkLDtE840k7XjjLh2Y+hK6VjL+mcMzD3TVKguhAV4bT76tmja48Pjzp+ziRMnsDRXVzNUgjYReanyijT3a0XgbccpEyACsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946138; c=relaxed/simple;
	bh=KV9j6tjQ5QXn5f8pxeC8kmzLrI6wkQRac7WkDx7/HyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ9wqnnT/EMYb5Iuf958mQFL5bQsbkHw7soIygUsbjyHPm7JDBJl6bYk3yInrcCLX/32o2cDfC6ApL+oV6bHKi7Dk+cava54IXHSOgs6ZYnGl8zFMNFeSCvFmy9WI7Zd7YkXozNTAoYezkWxmGvw0+VR3vl/a6o0z8AvKCRAnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tyzvjtvl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=COdfgtHA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VmL1OVkwxFNMuOuahfScs6JqfQbzrAAR04/d20fU04=;
	b=Tyzvjtvl0U8n1hqfpCtfGSo1X8+DqHppuDbUPwgKRisSL9ul4NrPgdZRWqxablkUWyF2t4
	JYfCUIibOw4oG1WApbg8qc3ZXi6Gr0gR0DDgm3ZYAdb7kTK9e5ys9jjQS4Wk3WOTNggj5b
	TEKVmgsIq1UHYSgvPMWo134ClaeaNhY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-xWtZez17NZ2Lhexv5f6p4Q-1; Wed, 12 Nov 2025 06:15:34 -0500
X-MC-Unique: xWtZez17NZ2Lhexv5f6p4Q-1
X-Mimecast-MFC-AGG-ID: xWtZez17NZ2Lhexv5f6p4Q_1762946134
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edaf9e48ecso26030561cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946134; x=1763550934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VmL1OVkwxFNMuOuahfScs6JqfQbzrAAR04/d20fU04=;
        b=COdfgtHAszEd5Dj1x/EbjnDEZFSAzdwvZ0DtOrep6HOyGys8ISoSJyZB1z8lmeGgt3
         nOQFQAzXGEj8/J0LrjwTcB1VBCxrgKobr9exmijFRTW6Ei17vzhq45HeKbrVo2AoLN5e
         az7ZYMrQ/kn9ac4+TSj1LB9jGYlVz20rbmfymjJ4QEdmi9RuKdTlFtJdqThBVS0o10fD
         kxEgetbwsbRY/6Z6GmPVGiQKIcegyB/0YU6yVtDJdsptKMq17Q95zREIHt+barJrfgof
         FRnvmrzelMEwlwY0SfakHCR7Um9iHagm6pFFgqF8au6dj1yvLDUr1GX7XwPD/fBOQGWd
         eyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946134; x=1763550934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VmL1OVkwxFNMuOuahfScs6JqfQbzrAAR04/d20fU04=;
        b=rlNF3VHkvRYRFDOEmpNLkLQU0vrzJ29khWfTeH23fyr1IyypVnU6YELZRBcXUvLXHg
         FnJolEvE44ccgLjVlCz2ZlAQaijDfiGnC9M0z7eDcv8VUMEEV7s7AiggqDLjkXoxPNuh
         QOx43fA925Sg7zqvl6GXhsQV0JneEfec8VDJiP8mMlrNnBeBhMKi0V06ZfkklV6orvHS
         HCNzfnbr+fy9qIjBo3E3C23MVYAAfMAFyU0Eb+ROlyA10Q20SrJnbGyBqYe5IQLGNpEm
         UiIZUNcf0mUKPkvmUYW6m0dGFd3bhks2ftOftV/86YTwNlIUmodYoUgOKf/TZMKMkZc5
         FPrA==
X-Forwarded-Encrypted: i=1; AJvYcCUm43dEu0/5ozPUISRaZjZU+JGDJ+JmWKmeCk6/oxjcSi3Qru510vK2WjyPgr1Zl5vGe4GpGo/9KqLRalg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWqDesmElmBEMGQMLQ0MVgwaQIvpDFDS5sueG5BYEeAGtz6y/
	FSEzkF6d1NQ9XEMJB08bLcvfPk20pBx2Gy4iaasjQk/VBYi8p7mVuS9XkZdz+c/0dKXUV6DxlP9
	Y2pu7vbYYzk2AoUlngDuw4fIn10n/5MQ53brNMo6HZiHbKY4fbFzOg4z1XVj08+FILg==
X-Gm-Gg: ASbGncsWIh8Bptxpgi48iNFo8QbtweMYavkYIh8hjXZHR3t2FXNk/vHBXW3t4w0XSFa
	sTMax+byd8KDFOHO1cB+H1F9q8AkmOdl/mPPafaw50OmSivj+pwJ505yfEImlumdZbDELnv+PAk
	9+iEnaaO+XBM+OeQHzQXfik7pSmNGjKO953HEBPA3fIvghE4Zcywqll/kXrxWIN4A0yrJeF3stx
	7z9Jj+cG1Poh0g2bmeDOILcLjAgqzvHxNEHwHYvMIwFSsZkVJ0ix/ceAkF7ZZh0TFQ+b7eL3tmh
	9gOeQukQN8dAzLA3FjDiDsrgqfDZ3j/q627ZyNKDtRy9rCLnCpR0lNjCANWGFCVwQU1fqt42jMf
	UgF3aHM/NeD5CXRgi+rEYeGm6hhyvwkfF/8ifsoDzX/irNNI02k8=
X-Received: by 2002:a05:622a:54:b0:4ed:69c2:3b13 with SMTP id d75a77b69052e-4eddbc6a48bmr30774411cf.9.1762946134040;
        Wed, 12 Nov 2025 03:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzBmGdmGhOlYiVIRlWZU30TyBg9MVhguagEmUrNtm3qfqZ/uALNevR67J4XeGgywzJuDlfEw==
X-Received: by 2002:a05:622a:54:b0:4ed:69c2:3b13 with SMTP id d75a77b69052e-4eddbc6a48bmr30774101cf.9.1762946133569;
        Wed, 12 Nov 2025 03:15:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede379ef71sm2086971cf.0.2025.11.12.03.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:15:32 -0800 (PST)
Date: Wed, 12 Nov 2025 12:15:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Message-ID: <wlflavm4wt3focsl6w4ylu2p2itwz7jl3hbcnczuyi5mfew7nu@rd6wflle5gjt>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:00:53AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Rewrite wait_for_listener()'s pattern matching to avoid tripping the
>if-condition when pipefail is on.
>
>awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
>exiting upon finding a match causes false-positives when the pipefail
>option is used (grep exits, SIGPIPE emits, and awk complains with a
>non-zero exit code). Instead, move all of the pattern matching into awk
>so that SIGPIPE cannot happen and the correct exit code is returned.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v2:
>- use awk-only tcp port lookup
>- remove fixes tag because this problem is only introduced when a later
>  patch enables pipefail for other reasons (not yet in tree)
>---
> tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index bc16b13cdbe3..01ce16523afb 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -251,9 +251,11 @@ wait_for_listener()
>
> 	# for tcp protocol additionally check the socket state
> 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
>+
> 	for i in $(seq "${max_intervals}"); do
>-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
>-		   grep -q "${pattern}"; then
>+		if awk -v pattern="${pattern}" \
>+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
>+			/proc/net/"${protocol}"*; then
> 			break
> 		fi
> 		sleep "${interval}"
>
>-- 
>2.47.3
>


