Return-Path: <linux-kernel+bounces-885967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF551C34669
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6896742704C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20112C3262;
	Wed,  5 Nov 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VgCh0f4D"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106902BFC8F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330119; cv=pass; b=frldsi0cv1EodCZrrpLT5NDuQTffpJ5QmoUKueVLZ/+cGvJXiKqtZsI0CknklWSbVbiq8Ek9Bi2JledHr8yLoT457ouhelH1A1vgufru763LYtpfDZ6dIdIisbax9G1r48ztktDGOF71p7OC1UmlBQkVAT08K49eEW619cXxOcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330119; c=relaxed/simple;
	bh=gcCxGNTB7O0giDx+Tn1z8P+KyVM7YYlFACpj7BpEwi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miHUS7aSb80vmOzQOlKl8iExna0kvpxeQ/lsogG6q6G1EStJg3zoHNOVAELRVMG7QJ7JkbWqvObsMXTMp0mEuG6rQCGqPEncT51XmIYnpFQ0TjF9qWuugIs8yiumOQrx9UkBfuIYs2VI/JvA/7RNUCtH+ei931/L92nEX5XcRds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VgCh0f4D; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (91-158-51-183.elisa-laajakaista.fi [91.158.51.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d1dHV4mkRz49PsJ;
	Wed,  5 Nov 2025 10:08:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1762330103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz8mST+BzV8qktaiwVOqFiVO+wPsshoQdHQlIUxq9Y8=;
	b=VgCh0f4Dndel5M6BlU6lE5TkGQSzEoUvqNxSBOFfLoqXx/6oCSC2rJdi15W445Vz5c2xcE
	TUJTsB2dkrHut2oJe2X7MCLXrFjJpZLJO39y+68w7CAVfG7NJhmPdukIhdS2U8grRc4act
	044cs3N3TCEHCRTKNeoSttVi9PpUcV0FbadeclyBhZrGeZOuePy9TVDu9ZfePYjhc7bkcN
	0/vRZFcI4I8uPtCiWwzPbH9VrfiRve9EX/PfvH2QAwXWsn/phITXSNvaxvv6wc5Nsv2PAm
	AxYAR+G6pIbsWbGCgXzEBGdLnmbYLRXzG7hhV5VPf5DBcUxOFkpfkkeVES722Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1762330103; a=rsa-sha256;
	cv=none;
	b=YLhLd98gg1dlagOhTIAzOeZLpggf5cp5IgkzT5PJv2ANBnC/kcrdqDnoV+X8vbs14YPy3U
	cfj6gkRJruJa4Dh9P2hJ8mIRtmYTCqyosQSwxKllXfOjkzqVi3oFpouapl+rMiz7qkkmPS
	hxlMUeiy7bedxHXBK5tnyiUrdQxbieTqjkZ9YdrqtO1jLJRgipWNoFbWtxu1zIsGvS8mqW
	3rvgh0Vy+T9ujAKJUwAPHrk5VMxjNeZsnApkMkxBGkl4HeLiHclLh+2EE7jEVB8fUFkJ4g
	NPTk6xgR5i77G7Hub6Ukn36+/lpLMSJH9sw/AVwb/8L8sfHue7DsHGpvu7pxXg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1762330103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz8mST+BzV8qktaiwVOqFiVO+wPsshoQdHQlIUxq9Y8=;
	b=sWS2MsmLmQl81tO1gsuzLb2Ud0UHvEdJ2aUJ+GZA9HDW3MF/CD9xTiaXu7Ja6LXFJLlAgX
	0Pma8Mb+0SNGxvLG8byzR31yFasuIjKrQbUC3s7MoQWa+f9EiMthcJwN4jyOUpitGuZlo7
	JV/pF9mwrBsQK2pnvvbjJG6tzkJt4Gq0bFH2Vc+47EV4/cd2p66ELxqni+eDWCzbMPk2Rk
	mfPcoBfLt9pEuVPRyvFNofvDSplqopAXolvFUwrXWNFW4t6ylR0XZV2ehaVEDEbYpjlfgU
	3lZZNWkZ2eYRThVr95QxgMN4jV8HvNvtMuGJgn2Kq5Ub9A2tms/wjUR8YpjNnA==
Received: from valkosipuli.retiisi.eu (valkosipuli.local [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 3E66C634C50;
	Wed, 05 Nov 2025 10:08:22 +0200 (EET)
Date: Wed, 5 Nov 2025 10:08:22 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Joe Perches <joe@perches.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Whitcroft <apw@canonical.com>
Cc: linux-kernel@vger.kernel.org, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] checkpatch: Deprecate container_of() in favour of
 container_of_const()
Message-ID: <aQsF9tuTWRn3tfS_@valkosipuli.retiisi.eu>
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

Ping.

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
> 

-- 
Sakari Ailus

