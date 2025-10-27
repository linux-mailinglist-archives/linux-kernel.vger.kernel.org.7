Return-Path: <linux-kernel+bounces-872230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D8C0FA21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7487419C67D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA63164B8;
	Mon, 27 Oct 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3RNxoTo"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887A2DA777
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586124; cv=none; b=enZA38hZfV3FTAN9FDVDwxOJ3/y24M5l0iAf32Tugo8nj1Ru9El9f2pWy0LP3lYvgS7aJUpDwcyfZzi2/EryQsI7W59zW9iP1HvEttrX4n0wQcLGFSPaDUFmKuMWQpQn0oKtla4VvNJAK/9nPHq8YZudkPGNXQT2QaZEHWy5Qq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586124; c=relaxed/simple;
	bh=n15GkVGRlM82y8bsXWGWKv4Ru0ouDE1mhKQda2Lxd3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZND0E3wzzEfaL73kx45GIrbbM6f4yYBLPKFp7ZQUb+ktEZ1Kf0cUw7iXkUfJ+Fdls8ApTohcSXxXW0NjK4aBup2Pt/bjn8KloSqkzEyGYrl8ynlfM3Y4PRiOvT2EKxcmRvy84NiXMVl+YO1EUoOBCmz3Z7npoaDZXO51zCDw+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3RNxoTo; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-783fa3aa582so56073257b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761586122; x=1762190922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKbTf0ElmduUelZrYEJiaRrNvJO3TsTMSPfSoF30NGQ=;
        b=W3RNxoToAcmeXPfx5Lef5kG3LqvhP2a+x4eCRJPsXpSfbugs5gw9pvySwndsflcKcg
         /SrF0fVltryWnZcR6D4Bs4EWseD+5ykSuK/w6UAdRfwPZXWIOGzB3i7AmttfXfPdQeGH
         ku9Gv0V3No0+pBOG6Tya++NPkhOG+m5zS+31mU4GPUR09KPCnJgiqfLnddZQdia1KPU2
         +GxBaZ+qiLqBpvxfhw9YsvfIxsp637zlJnMfCL/jOUW9HrjKU1BqOFjvifVX7YmipqRM
         E3aDLz5nLDvmsLKLY2Jx3XItKcViG+Q6SnACPK+9QWTvXChaG91Ae6Raq40cafssBS7s
         q+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761586122; x=1762190922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKbTf0ElmduUelZrYEJiaRrNvJO3TsTMSPfSoF30NGQ=;
        b=WEyZWKOfHu+/+z7kt/p/fkk9N12OfE8iRH0UGO68yayj9cEGPLaOspqOp6ag24Yowb
         Y2pmvuz2NqKqFFSu/qDuo8segqCkl5w4wjPaRjqclIPXYHH2TQeV9Qhf7ehy/vBaDtF6
         c9p1+seKwidmOAXl3aUFpXI1ZDCJ+aeX7CcbXFy30LABaoTlxNaE8gUtXpPFq3Xaol/u
         NluPx2tj5b50jtoVk0ge03vFcAQAmQ3AOW4eQdZdxkvjD24P/jm9k7atZAtQ5RZyu2O2
         9J8pGwNolaRAd/j9YmhwwV4LVNXvV8EqotGsVO9kIB4LQ+N/VEUMvyD/WOFjs8fmtonP
         fmig==
X-Forwarded-Encrypted: i=1; AJvYcCV7NeQwI9xsyaZedWgyTENpz11Bn4tq1jTNJ5dr0VsX+gQIczmlB2T2F8+xkj70euULgV4zX1J+xR1Y5bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBZIpDhTU8oCcsL3tBV7Ic4W0cpattF/6sVBlR/IWiMExNnpV
	Z1VY0HDoOYK1wfIp7dDHdNN5lZdM8EwiN76dk065QgBYzIN/eC3m/Byk
X-Gm-Gg: ASbGncv6oCChmmVNu5mt5cspL62uM+nmviNZxbYd/br5PmRX4rsnYcBytiQ26lT7vjb
	pV7RXtnkkUiHiczBB1YVRFIC8CwtHCfKTxiaTvmTtTxnlRbTAVrGwSxDe8hjOE2sDNb7g8ZYxUT
	9YMlg1UOITKRIC12QqQpugzeI5hXXGq8ZoJ8T5UJES7YVOtOtcZyGNyC824rxtDmMFvb4oUGH3+
	EP5revBX3m11LcRFlGXlaLuXCNCGC7S5v1p6ARzLoYnSoxjedpT6QBEQsnYhRqdn2LMd8R4IL5x
	ULubRMbl57ZSro/i1lLEMRrZAaxdrvWv6EncOsUQFVem2Kjbv6iPnzKTb6xiV9TOGL0lHdO7+fg
	ulp6o1dhRnzJaUl41fUdTf/tEujotn4tgKQ86AenB8okdzFsx9bB4UPDCv3TFCDFhSqOWyzVfAS
	+B57nPt6kU0wo4ONgnA0VLLWWFTaT9LUPW94WWvi6UKTOiBnU=
X-Google-Smtp-Source: AGHT+IHM1NI9jlgl7YyHEw6xfZ2NvWKARzYo9jjqycdlEoc48MLVHrBBixAozXkHMEqVBYRHZIgJww==
X-Received: by 2002:a05:690c:9312:b0:785:eb11:647b with SMTP id 00721157ae682-78618357840mr4674427b3.33.1761586122152;
        Mon, 27 Oct 2025 10:28:42 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1a4391sm20417647b3.33.2025.10.27.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:28:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:28:40 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 01/12] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aP+ryNxS2A45WT7f@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-1-edeb179d6463@meta.com>
 <aP-hpxMgB5tN7KJ3@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hpxMgB5tN7KJ3@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:45:27PM +0000, Simon Horman wrote:
> >  log() {
> > -	local prefix="$1"
> > +	local redirect
> > +	local prefix
> >  
> > -	shift
> > -	local redirect=
> >  	if [[ ${VERBOSE} -eq 0 ]]; then
> >  		redirect=/dev/null
> >  	else
> >  		redirect=/dev/stdout
> >  	fi
> >  
> > +	prefix="${LOG_PREFIX:-}"
> > +
> >  	if [[ "$#" -eq 0 ]]; then
> > -		__log_stdin | tee -a "${LOG}" > ${redirect}
> > +		if [[ -n "${prefix}" ]]; then
> > +			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
> 
> FIWIIW, I would drop cat from this line.
> 

sgtm!

> > +		else
> > +			cat
> > +		fi
> >  	else
> > -		__log_args "$@" | tee -a "${LOG}" > ${redirect}
> > -	fi
> > -}
> > -
> > -log_setup() {
> > -	log "setup" "$@"
> > +		if [[ -n "${prefix}" ]]; then
> > +			echo "${prefix}: " "$@"
> > +		else
> > +			echo "$@"
> > +		fi
> > +	fi | tee -a "${LOG}" > ${redirect}
> >  }
> >  
> >  log_host() {
> > -	local testname=$1
> > -
> > -	shift
> > -	log "test:${testname}:host" "$@"
> > +	LOG_PREFIX=host log $@
> 
> shellcheck suggests keeping the quoting of $@.
> This seems reasonable to me. Although in practice I don't think
> it will change the behaviour of this script.
> 

Ah right, makes sense to me.

> >  }
> >  log_host
> >  log_guest() {
> > -	local testname=$1
> > -
> > -	shift
> > -	log "test:${testname}:guest" "$@"
> > +	LOG_PREFIX=guest log $@
> 
> shellcheck also points out that log_guest is never passed
> arguments, so $@ can be dropped. If you prefer to keep
> it then, as per log_host, it seems reasonable for it to be quoted.
> 

Quoting it sounds best to me, in keeping with log_host().


Thanks,
Bobby

