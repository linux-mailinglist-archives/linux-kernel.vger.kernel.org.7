Return-Path: <linux-kernel+bounces-896168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D6C4FCAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AF818C0D20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886691DF736;
	Tue, 11 Nov 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMZ27BoX"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE3352FA7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894916; cv=none; b=dUArpHdy9Gnc+ePkCVDom7PD6p1Q6khcDdEjuLyEyMQJC3oJ1ixZ03AgZOhCsJzko3q4w4WB/PSzI4iFXiRurjy9FJbybrjJ+s5wm1cWuqjCbzfrzTN99+gg3n0y5ATWb/Zf/40iUz0jwqCuMjDZ/xmTz9hNAhK9v54r6uteiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894916; c=relaxed/simple;
	bh=m2/ll1uTQe3vdYyhgsBOhN/isiT4ncOezX9iuBFvWf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N248vKB36KCxRKj1xL9VXxXHySH0B/U0CGc0rNNmUupJKS5Z3EDzHtE6+cV/9+Io9g9dQMWiFHLxEQU8bOeandet9co0CImRxFDCykj6G8W/6rdQQQsVFbUogQ0Xh4trYWF81QWqVX7A4gLeO3E1PGuSunHVeA6C4Zfrv50dtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMZ27BoX; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63f97c4eccaso175562d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762894911; x=1763499711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDPq8KvClJvWwDQMfmOhMgSMTNNkWL2W9UB4UAss5Bg=;
        b=EMZ27BoXyrccnWk6j0fZzJXConxIlnb+YJyxYnU4pvHMuVIow6oNh0p44L4eeNPAlb
         EuU22N0Cu3NLv75bupq/7aQaIC76fv8insPYQvRVpLLgtxNnYfaxq1leWkBbQwLqpal1
         dN2H45GfOTIZMIalPt3j+RAvbeKU5LUk5X4jrrgVx77EbEaniLj25o8hJrBzM2OzXDLb
         6EjMCrvHtPJKTl0XLha4W+sb/tyBJSEidqBbro/8EAwK29bMgtOQYDZxKcG0Ho3RXKmv
         B9Z4B6oHilKtSi+F0GDPzi4IS6pGJKPuoMNThYrWpESSL160+clnPrk3ZeGhyMlHRBO2
         OiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894911; x=1763499711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDPq8KvClJvWwDQMfmOhMgSMTNNkWL2W9UB4UAss5Bg=;
        b=ng6RkEN3ZKBBbYB9W6l/YWGlWGPUhGihb+DM8kvZqxPXvqjz+dwQqY92iV4EZpMwu9
         iiD7aCY+XQHdw44My3I/Xlj4E/UYsC+NeHAaXVMqzGLzT2uYT2GAAKGsINuqgJzul0KN
         JcldMMRKrITsw2OB7fKczHiDVpoAzWvHo8PvFoDz7feTy0MZPzqr5GgJQxjjb7g334dm
         sGcJmsx8riiMVEancid9BO8qo/A40aCArOvGOXgOVLrOO1Qq4jt6GU67d68Sb0E18eFR
         vqcLlqcccSwQl8dNJv7sXFHAQJvneGxn2TaWWSxXJMgJcLOwsyyEtQmu4o6wUiq9YzXR
         4hRw==
X-Forwarded-Encrypted: i=1; AJvYcCUvzIOtahmTXTqBgaRySlIe0OFQSlS4kJU+lGvLjxNP+kWDjeY0cGFNqpn8o57Iw1ZwQcrmtqO4OBAMsQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYz3z7qWep/Om8DOfeZZ3lqysrQRMpVwQAcVyL9T1fOWmsVtK
	KgKZrRtRR2RK9SHKttEqX3MC/KajSiJWsvm4fQyyUJmfaXgzr+UbZxYF
X-Gm-Gg: ASbGncuO7X9OBmbd/0vA7O7f68ZYBeAwupFFTe/1K7tpu39Q0Y4lxX9Yo26mE9+/48o
	cv5i9RMjSm6l7xe975MHQouEf8yKvTz1g0Q2letCQ81YzuHffa708sJ19Cn/hNjbcQcLMs3pOOf
	Me1SR8whh/RnggKVD3bts9Kngf+1NGfzPnM08LZ27cVr0G4lcW8kiRilRJRaVvLcLfx3lca6+o0
	MrYQSu/LyIkFy585VQaPy+jxYLEBLtiskpsn6zzJsdAtTi6IGErBcHJiMrEAZK2Tyvv8kUUUN6f
	TGTmO7AjOetSFwnquOEN+YOBStVpoGCMYsuUOJwQsPYW/ZpsxwB4HzVG3Pl8msCE4G+t21HR46Y
	qnBlofdNn0Po+UItOQPc8u2UCY8gSMuc0IPNOvEzWYUO4gs45GoAAwknTJE60d9QUleNteQeXOC
	H7UqY4cdk3b+ymu7m9eYeGophd077x0On4LM6gDVyWtKpkvg==
X-Google-Smtp-Source: AGHT+IG5pLwkGsZ+eCK296l8q5rg85wfM1wAQ8NbbJwGyjxk6/mldP/Q7Z6BLYOivEyqJVyS1VY/EA==
X-Received: by 2002:a53:c048:0:20b0:63f:a165:b9ed with SMTP id 956f58d0204a3-64101a0ab45mr674439d50.6.1762894911625;
        Tue, 11 Nov 2025 13:01:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d684218dsm36167807b3.21.2025.11.11.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:01:49 -0800 (PST)
Date: Tue, 11 Nov 2025 13:01:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 07/11] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <aROkPIIeGq3Tb0I6@devvm11784.nha0.facebook.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-7-519372e8a07b@meta.com>
 <aRMjeZVqsnc1BNr-@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMjeZVqsnc1BNr-@horms.kernel.org>

On Tue, Nov 11, 2025 at 11:52:25AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 04:49:51PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add check_result() function to reuse logic for incrementing the
> > pass/fail counters. This function will get used by different callers as
> > we add different types of tests in future patches (namely, namespace and
> > non-namespace tests will be called at different places, and re-use this
> > function).
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v3:
> > - increment cnt_total directly (no intermediary var) (Stefano)
> > - pass arg to check_result() from caller, dont incidentally rely on
> >   global (Stefano)
> > - use new create_pidfile() introduce in v3 of earlier patch
> > - continue with more disciplined variable quoting style
> > ---
> >  tools/testing/selftests/vsock/vmtest.sh | 95 +++++++++++++++++++++++++--------
> >  1 file changed, 72 insertions(+), 23 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 557f9a99a306..05cf370a3db4 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -46,6 +46,8 @@ readonly TEST_DESCS=(
> >  	"Run vsock_test using the loopback transport in the VM."
> >  )
> >  
> > +readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
> > +
> >  VERBOSE=0
> >  
> >  usage() {
> > @@ -79,6 +81,28 @@ die() {
> >  	exit "${KSFT_FAIL}"
> >  }
> >  
> > +check_result() {
> > +	local rc arg
> > +
> > +	rc=$1
> > +	arg=$2
> > +
> > +	cnt_total=$(( cnt_total + 1 ))
> > +
> > +	if [[ ${rc} -eq $KSFT_PASS ]]; then
> > +		cnt_pass=$(( cnt_pass + 1 ))
> > +		echo "ok ${num} ${arg}"
> > +	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
> > +		cnt_skip=$(( cnt_skip + 1 ))
> > +		echo "ok ${num} ${arg} # SKIP"
> > +	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
> > +		cnt_fail=$(( cnt_fail + 1 ))
> > +		echo "not ok ${num} ${arg} # exit=$rc"
> 
> Hi Bobby,
> 
> Should num be cnt_total above?
> 
> > +	fi
> > +
> > +	cnt_total=$(( cnt_total + 1 ))
> 
> It seems that cnt_total is being incremented twice.
> Once seems like it ought to be enough.
> 

Indeed. FWIW, this was fixed in the newest (v4). I messed up a rebase,
and my eye didn't catch it before sending out.

> > +}
> > +
> >  vm_ssh() {
> >  	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> >  	return $?
> 
> I'll confess that I didn't notice these myself, but
> Claude Code with https://github.com/masoncl/review-prompts/ did.

Thanks for the note, I'll give it a try. I'm trying to build out my
pre-send workflow atm, and this looks pretty useful.

Best,
Bobby

