Return-Path: <linux-kernel+bounces-890663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C172C409BD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F11A4F1521
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38FD32B9BA;
	Fri,  7 Nov 2025 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBjXHOYy"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7810E3081B5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529714; cv=none; b=lLKZAcaV9RZXIy7w6VDGfbL6nPllr9UH/W/MehjG8mOI2K2GGGvQNQZAuYxZaV4xBiPKa3nTejr0cV+OdOq8T53otxjSLgcxhosZ5gH8yWzznmd5acDxoPOhjBMo5ea0XooU1h4Fmq5bt8faqRe7RD8bOcQMIhYjjdDUyS/rJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529714; c=relaxed/simple;
	bh=7m90U4fRlmTtbaduAz/n40bucosBtxg2Nlzb525AIWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aySE8UQABkqY8Re4WtmwwXc28Sava8dq0m0dl8bRYmTOq/E2NBu4BK47oOgzqmXzohN9te8Yl01lMmEX22pX7zOFCqNMAmC2NDWPxK55Eu7OpNi6q/gIOUW7vvPgh/eJ09mG47Qj9oD/4vvTKofCwJ9gaqN5Xr7NxwEphaR7Aaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBjXHOYy; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcac45so8457537b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529711; x=1763134511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg5UfzPKclS12jZ/MM0cVARNy4+o8xhJZIOiFJg4L64=;
        b=CBjXHOYykeExWbAdUzaTfxbv+hYeDnJ4OE6LMEsIQ+j1HllMQbTwIrF1ZEDn7jXbaG
         lDM2Uj71u4sDtbD+vGnxUFHY34GPfx3h1iW1JsUxF8CYD3oxAyQxZbZplmBquMOloTwP
         oRPywO8QmaIR6yh3L4Hcuck/OkBnD05U+hfOWzV/GEhqkGUyL0NYgE2trQfhP5MA7DoZ
         LQpahZrpYOlvRREH+zpYiz2WBgdGz4j+YhGxFHwBjcPyqqb7GU/IMiM7XEpmL1F9pPbk
         H1bgVT9cQsFpWEguqlEo19mGxZbreY0161jBsEn/zIuo0yFqfn26o9DZH7p0Aat4utdn
         RyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529711; x=1763134511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg5UfzPKclS12jZ/MM0cVARNy4+o8xhJZIOiFJg4L64=;
        b=HtLGkqxnvV/cTJxt2l5uiHBjFKxuNxlXk1yyvy5UI46y8qng+DzZ091rn++wqCSTBL
         7okGVtmxFuxk7pmrpoPpkF6+Z8jEAqcvQtZoIUNk5cWBWSqT0RmMsRcD1aHsv4WKdg94
         Ll29wsyE+pol1eiK05QqoPz1NulRGBwboid8CT2gCAze0dZGb1/id6B1eF7LW8qLa+mf
         SkgywTDQ1QuvfF+Fb6ojZHXlxBo9wyph2dc6WYIJwDIwCBo3Fjj29hXBlM6yLtfyrxSL
         OnDHAWn9QFt4p/EPye15W0b7UmFgLLvUCvDW9w1p5Quvxv3oS6NZQdJb+U6OLAv0+zd5
         Y3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXfgbqmAhmwV5jkPzxyxMERUm7AfPwKmMcwsWO+/dh+37mMsLAU8oT8AaI5w34DfLuli3i55sWqyUPPrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDgERnhXY63kaTy8mluZH6Y+Esg/3BDAaZHmUUil7MvGI36kzN
	8SR33j2mrQWHmK/il9+Dtf5LRunWgXj12bPwYeUvLkb/TN078cYMDNti
X-Gm-Gg: ASbGnctJ/EBL09qGiskct+bbw3FWFS0FRm+heLdHMqsIiPxxrSE8/4VFozT8qvrBg7O
	No6zeeLzBtYoa2ID86Jhs99OnB4CjawO25RfpmRzjxQtCx4M+mbyqCKTm9IKeP7GJbcdAusM4/s
	d29H0kVX3GjOIVryC8GEaTX9NSMO9xdNUslCRgFpTQjKcq5zDEjjqWl+p0yWPTfgozLksgQ5FyP
	ACc4idrNkgmU1sOcdgtfWngZqpqTNqkQcicGDRTe7oDOOGNvf98plQf6aZ3Bp5MCNAOLb+I8W4j
	c3+A/8hEVmALTeIHogG1NbYKJ2rYADgFp7/mfFN9nQHT6qQKDORuYBsOWtTdsxi7/kUuSA8cM4S
	6C5RKI5VLWdwtk/MhzRsAqtJxHfp5+oXFGdHxyGXRUkeCA+T6zBeknUUjibjVLwEc7omrWavnEl
	fhL9GrDpcqexhdFcz2E2i6SzizXOEXL7SZVGUZ
X-Google-Smtp-Source: AGHT+IFwUXomSgFrXOP5T+Zd2zXzyVOrxyGJXDnXPE08lhO8nln1/YwLRBm5iwzEweMUqR/HaaHj6g==
X-Received: by 2002:a05:690c:360e:b0:786:a984:c064 with SMTP id 00721157ae682-787c53f0603mr27190947b3.35.1762529711161;
        Fri, 07 Nov 2025 07:35:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787cb4db618sm4770327b3.32.2025.11.07.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:35:10 -0800 (PST)
Date: Fri, 7 Nov 2025 07:35:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 04/11] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQ4RrcB0tzMWch1S@devvm11784.nha0.facebook.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-4-519372e8a07b@meta.com>
 <aQ4LaUi9wTnEN8KA@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4LaUi9wTnEN8KA@horms.kernel.org>

On Fri, Nov 07, 2025 at 03:08:25PM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 04:49:48PM -0800, Bobby Eshleman wrote:
> 
> ...
> 
> > @@ -90,15 +85,19 @@ vm_ssh() {
> >  }
> >  
> >  cleanup() {
> > -	if [[ -s "${QEMU_PIDFILE}" ]]; then
> > -		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
> > -	fi
> > +	local pidfile
> >  
> > -	# If failure occurred during or before qemu start up, then we need
> > -	# to clean this up ourselves.
> > -	if [[ -e "${QEMU_PIDFILE}" ]]; then
> > -		rm "${QEMU_PIDFILE}"
> > -	fi
> > +	for pidfile in "${PIDFILES[@]}"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> > +		fi
> > +
> > +		# If failure occurred during or before qemu start up, then we need
> > +		# to clean this up ourselves.
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm "${pidfile}"
> > +		fi
> > +	done
> >  }
> 
> Hi Bobby,
> 
> This is completely untested, but it looks to me
> like cleanup() could be implemented more succinctly like this.
> 
> cleanup() {
> 	terminate_pidfiles "${PIDFILES[@]}"
> }
> 

Oh right! I reverted the deletion and completely forgot about
terminate_pidfiles().

> >  
> >  check_args() {
> > @@ -188,10 +187,35 @@ handle_build() {
> >  	popd &>/dev/null
> >  }
> >  
> > +create_pidfile() {
> > +	local pidfile
> > +
> > +	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
> > +	PIDFILES+=("${pidfile}")
> > +
> > +	echo "${pidfile}"
> > +}
> > +
> > +terminate_pidfiles() {
> > +	local pidfile
> > +
> > +	for pidfile in "$@"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> > +		fi
> > +
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm -f "${pidfile}"
> > +		fi
> > +	done
> 
> I think it would be useful to remove $pidfile from $PIDFILES.
> This might be easier to implement if PIDFILES was an associative array.
> 

Using an associative makes sense, this way we can trim the set.

> > +}
> > +
> 
> ...
> 
> > @@ -498,7 +529,8 @@ handle_build
> >  echo "1..${#ARGS[@]}"
> >  
> >  log_host "Booting up VM"
> > -vm_start
> > +pidfile="$(create_pidfile)"
> > +vm_start "${pidfile}"
> >  vm_wait_for_ssh
> >  log_host "VM booted up"
> >  
> 
> > @@ -522,6 +554,8 @@ for arg in "${ARGS[@]}"; do
> >  	cnt_total=$(( cnt_total + 1 ))
> >  done
> >  
> > +terminate_pidfiles "${pidfile}"
> 
> I am assuming that there will be more calls to terminate_pidfiles
> in subsequent patch-sets.
> 
> Else I think terminate_pidfiles can be removed
> and instead we can rely on cleanup().
> 

Indeed, later patches will use terminate_pidfiles() in between spin up /
shut down of multiple VMs.


Thanks again, will incorporate your feedback in the next!

Best,
Bobby

