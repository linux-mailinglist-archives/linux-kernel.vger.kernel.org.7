Return-Path: <linux-kernel+bounces-886863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E860C36AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A14B2501F38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2651334C3F;
	Wed,  5 Nov 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHbDbLIt"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5887322A3E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359095; cv=none; b=ZIx7AXs/ypAzCQSyC715ULTE92rbR+CymPJhKRXmYPfLL6EH0xOikwt57n6OvOhS5C6mlvyHMXMghYpt7LJ0piWhV5ERJPDycj6ThyIdP8n0DjlkevC9RkIorcCKz654Ej7xqxDq+8wkloYHGvSdxYY8eLI8Qq/pMu3VDCIU2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359095; c=relaxed/simple;
	bh=W3rIEqDAjFHWAwm+pwB74Wz+AVL3IfQgKO4Y4lo7W2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6NB33njjTku9B9LCI+A86fJIVhlr25Zo1sJc7A03a6hAFt6BJnIM9BIMoNj4He9Opts4lrvbH6+8JYs7Hq1EYoKH8EPd4BVHTnY44/SKqgE4nKqZHTlL/73rrJvJnmXK1/+Z+fjB5mYMzkUb7JToxETx/MS68tkjU1DmceL0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHbDbLIt; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e1e1bf882so9783d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762359093; x=1762963893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymZ6xdXrqo7vWAgf0QChueJMpmkC1T045PA4GVzRwIo=;
        b=YHbDbLItjw4+eMXKEAHsY2z6+TDNrzIu7JCue8TYKGBW5rNDBDA4JyyM/UgPjyAf4M
         5MqkGFSQxKclN7aJD+qGLJCYV8vCTg6YPemfsPJrI3AV/XQJqcMzkaKNo0t8msTKlFda
         e0pVYvImharsbSWHL60w2PP/PvzOKgwAoZzx3jTNCWMoPWQBzVE8Htct92I7j5p4HMZE
         BhFEFcR3GXgmVF4F6OGJ1AgDCO4C0Dk3QKjpQlQJvUykVFNLhQIEiM9DB7tiQ78fkYeL
         41nBDihiXKZ3pD+aMvDrHd4Kdyc90F8YhaprnNZCz7GEXfN1+UFPvh2qp+b46wLn+QxX
         /s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359093; x=1762963893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymZ6xdXrqo7vWAgf0QChueJMpmkC1T045PA4GVzRwIo=;
        b=t4zsI4TBhdSjeF+8MmLsuaGJZSjA2ii3rZzRH2WYZdR0S/sm6jeVbLeMrorrpaw5Ex
         IrG5f7AFNT4B6U3yJqkFjyVf91CMfWcBoLpMX15D7XXi1oQp0Z0tkk6XA3DYsDdLUp4E
         PgdHvC3pm7123QA+KZ4PdUKYDPtsgC0d5NZvxOcDniIuoQ2f2tIgpov6ezL+fuQI4Vlv
         OgrdOQKHOKG9YkdPFOw3n5IIc861ykDBl2D2XJwQjYEHTjk8aCNvVEPqgwiBIJ4VjFkK
         hfdN0t6TC2R7wYinvp/uqubG9YAAIbGhqNe20wz7FRwhflBwR8Tb2CBeSTbSo5eHD8yD
         DGzw==
X-Forwarded-Encrypted: i=1; AJvYcCVdj/oRsqdZ87iTcv8xe2q/z2o0Vvd3B83vR7sVUZ7ciDfaW0sbf9GlDx3PFVlcSYKtn5gDotg3WPqPu3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbW59xghXfO0KgDTAvZiIYc6MUTVH0HOt6QLni6jtyX7hn2VN
	1wl+bJ2c2hael1zGSE+188UdNmrtfpSbRVMoy4K9ddwz3Rx9ilbOP2Kw
X-Gm-Gg: ASbGnct3oXK+j6UUmq++jVRgfSRIc/xU8uTzrc/UAoD9LnOHqIChDhIzc9qkbyTe6NL
	soSuIEiCdIlWni/sDLpzcSGRFtGUu4Hn5kLwnwNWmgTDMwKShSLZpnHpYgV4Z/zxA9anSuNUkdg
	ETcZn2mdErNu87mvpI3PO+XaYcBsFOMzEvO0AMvxCJkk0c4/UT5NAv6FDg5TZkDPWcCbGFXBdB+
	rDNKpxdE0DW8H/+w+tzoUiqYBLd9c4g6I5n/iSFzFbN1FQcJWewZbYQNuq46NTg/gp8JWDvbizI
	ev4CzYIlaI0e830BNwCMluN9Pld0XmL2NQf96AFiVndhG6Elf3SpuD85oijqzyoQqh03ldE1y6m
	9uiYUpN5K/hstkFaYHdRsJOo3EB6tSWAQkkFqhQeVgMKa7I3PwqUhiCb4KbZp1T6VAuwhL3Lj2J
	YodnbI11epueV1GvyAyNRLkbPHcpt+vYE5Zz4=
X-Google-Smtp-Source: AGHT+IFO1Aj58ygyCOlI2zA+lUSTMddFikFOwBkJL3a+he6zkxfPMBnlF0h5B3IACmlOERHv2GNjEQ==
X-Received: by 2002:a05:690c:9a0a:b0:786:581d:f24b with SMTP id 00721157ae682-786a41e29cemr57871067b3.47.1762359092678;
        Wed, 05 Nov 2025 08:11:32 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691d8f0b4sm20313777b3.4.2025.11.05.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:11:32 -0800 (PST)
Date: Wed, 5 Nov 2025 08:11:26 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] selftests/vsock: avoid false-positives when checking
 dmesg
Message-ID: <aQt3LitYPBcD0MM+@devvm11784.nha0.facebook.com>
References: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
 <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>

On Wed, Nov 05, 2025 at 12:16:42PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 01:50:50PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Sometimes VMs will have some intermittent dmesg warnings that are
> > unrelated to vsock. Change the dmesg parsing to filter on strings
> > containing 'vsock' to avoid false positive failures that are unrelated
> > to vsock. The downside is that it is possible for some vsock related
> > warnings to not contain the substring 'vsock', so those will be missed.
> > 
> > Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Previously was part of the series:
> > https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
> > ---
> > tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index edacebfc1632..e1732f236d14 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -389,9 +389,9 @@ run_test() {
> > 	local rc
> > 
> > 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
> > -	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
> > +	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
> > 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
> > -	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
> > +	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> > 
> > 	name=$(echo "${1}" | awk '{ print $1 }')
> > 	eval test_"${name}"
> > @@ -403,7 +403,7 @@ run_test() {
> > 		rc=$KSFT_FAIL
> > 	fi
> > 
> > -	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
> > +	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
> 
> In the previous hunk we quoted 'vsock', but here and in the next we did
> not. Can we be consistent at least in the same patch ?
> 
> The rest LGTM.
> 
> Stefano

Just sent the update, sorry for the oversight.

Best,
Bobby

