Return-Path: <linux-kernel+bounces-762141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D28B20294
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266EA189E3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB5C2727F0;
	Mon, 11 Aug 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hb2FPgmT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9415ADB4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903153; cv=none; b=MfaIZTtFPOiiqg2p7JDEofn+dHr8/UWnWntwuRXd0D2Ct0SF6zov1jQ4jxklzUuYPMZSwalJM+fx2ZiuQmekgkdSTzZ5Sp9cfmQqMX8zirRDaiYsvfnxlCT3ELlsEJsi2AoaW3fl+qEgGgddZHeYyd41X7lL++ZadHyHeF/3TtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903153; c=relaxed/simple;
	bh=vpIKH7BpI7ZVVQc9GMdOtRicLQakqd+yc952PgKRFmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS56BBLh8fju9MKGMrzDRIG78AUaAsOzlVBRrrMR2OUv5W38kJKBUa2jQRQ/eYCVbKB5QRDX8TVAuqMoEYmRxbnAzhHhMgrXgLdawDW6mbXn99ZLLrouMIaqS+yZEsffxtaYzE70LCQMEVj0V/1SfZkT/Hmdtn2GPj7WBVkzv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hb2FPgmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAD0C4CEED;
	Mon, 11 Aug 2025 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754903152;
	bh=vpIKH7BpI7ZVVQc9GMdOtRicLQakqd+yc952PgKRFmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hb2FPgmT8kkGJceimLFCt+3tPKFEDtXN7nfiEQROBcZcuMgGNC2WJhELf0+wRwb6O
	 9c2UEtuUOdYcatH2nOTX7uw+qJ7HcN3HrT8vt0FQ+IoN12G3HUlP6DezVaTzR0eCmJ
	 YPjQyVMYPqhFDCWCWVwFWsJnQWB0bJ5D4aP+iCTI=
Date: Mon, 11 Aug 2025 11:05:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/1] checkpatch: Deprecate container_of() in favour of
 container_of_const()
Message-ID: <2025081142-setup-underuse-5611@gregkh>
References: <20250811085731.2117377-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811085731.2117377-1-sakari.ailus@linux.intel.com>

On Mon, Aug 11, 2025 at 11:57:31AM +0300, Sakari Ailus wrote:
> container_of() discards constness of its first argument and thus its use
> may result in inadvertly unconstifying an object that is const. While
> container_of_const() addresses this problem, the vast majority of new uses
> of the two use the container_of() variant lacking the check.
> 
> Stem the flow of new container_of() use by adding it to the list of
> deprecated functions in scripts/checkpatch.pl. Once all existing
> container_of() users have been fixed to respect the constness attribute,
> the check can be added to container_of() and we can switch back to
> container_of() again.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 664f7b7a622c..32edebfc1935 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -859,6 +859,7 @@ our %deprecated_apis = (
>  	"kunmap_atomic"				=> "kunmap_local",
>  	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
>  	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
> +	"container_of"				=> "container_of_const",
>  );
>  
>  #Create a search pattern for all these strings to speed up a loop below
> -- 
> 2.39.5
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

