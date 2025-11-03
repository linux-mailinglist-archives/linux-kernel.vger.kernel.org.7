Return-Path: <linux-kernel+bounces-883189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA4C2CB34
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4314B4F2A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF59320394;
	Mon,  3 Nov 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCB2kS2U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C651D320CB1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182730; cv=none; b=MGd7iS2nSW/FnSjTxZzpkS3VYZzZE9AMp3jzOtSq2rPI9vCiwy1oq0ktAd3jLKDPILnbAOyFAI4bhClWbMGoWlgI9Xlr/frSF7jr9M53c6V07PZPpcq/hG6JnYaPeEW46Ik4XEN+THb19C0OQD+IbLf3VyH+dVSTvdfloPY4Sd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182730; c=relaxed/simple;
	bh=WvJxrEvmom0/RF7FARGCTnTIixEzgawwliy15cUaIDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShE/byBaxcwHegFf5s/UVfJPhnXvUl8XFfPjs2uoXQpkniW+0qjP52THYB0hxXORYPVDlytjjVY9/JbrvxnefITLXQCnnvTOs1eSqsx5qQG9VtC1T58Ef/QOGOVeKHbweq0JeD1eeYR7opeI2esgLX9nZx0RQ6+0303uA6vb0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCB2kS2U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762182724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Yt98eTgh7ujwhrMznpREfl7FHJAib+MMNEzhXKLoVQ=;
	b=JCB2kS2Uxv/JjSUuKE2HnmIKPSf0natvHyHKS/8y5wUM2gc4iUNjyj1+Ao0nNDwi/0xU6g
	GSIAkkroCdfweYMOnhbFRLrDNV9EVQLwzV07TKHbEAEGPwrBxDPzfOP/M5aF2LVzC17FD1
	WYPBZ/X7hUWGb4ipDzhn0PSC1bLwuuE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-cQAgqfdLP7e7W68Y-JjM4w-1; Mon,
 03 Nov 2025 10:12:03 -0500
X-MC-Unique: cQAgqfdLP7e7W68Y-JjM4w-1
X-Mimecast-MFC-AGG-ID: cQAgqfdLP7e7W68Y-JjM4w_1762182722
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C41811955F44;
	Mon,  3 Nov 2025 15:12:01 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8730F180044F;
	Mon,  3 Nov 2025 15:11:56 +0000 (UTC)
Date: Mon, 3 Nov 2025 12:11:54 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 5/7] rtla/tests: Run Test::Harness in verbose mode
Message-ID: <fp7k3ib3zsdleiv4fal6daiaz24xxr2ern7tdooeazsngbmpil@qx52c62l2fnm>
References: <20251027153401.1039217-1-tglozar@redhat.com>
 <20251027153401.1039217-6-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027153401.1039217-6-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Oct 27, 2025 at 04:33:59PM +0100, Tomas Glozar wrote:
> Add -v flag to prove command to also print the names of tests that
> succeeded, not only those that failed, to allow easier debugging of the
> test suite.
> 
> Also, drop printing the option and value to stdout in
> check_with_osnoise_options, which was a debugging print that was
> accidentally left in the final commit, and which would be otherwise now
> visible in make check output, as stdout is no longer suppressed.
> 
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/Makefile        | 2 +-
>  tools/tracing/rtla/tests/engine.sh | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index aef814b639b7..2701256abaf3 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -110,6 +110,6 @@ clean: doc_clean fixdep-clean
>  	$(Q)rm -rf feature
>  	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
>  check: $(RTLA) tests/bpf/bpf_action_map.o
> -	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f tests/
> +	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f -v tests/
>  examples: example/timerlat_bpf_action.o
>  .PHONY: FORCE clean check
> diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
> index c7de3d6ed6a8..ed261e07c6d9 100644
> --- a/tools/tracing/rtla/tests/engine.sh
> +++ b/tools/tracing/rtla/tests/engine.sh
> @@ -105,7 +105,6 @@ check_with_osnoise_options() {
>  			[ "$1" == "" ] && continue
>  			option=$(echo $1 | cut -d '=' -f 1)
>  			value=$(echo $1 | cut -d '=' -f 2)
> -			echo "option: $option, value: $value"
>  			echo "$value" > "/sys/kernel/tracing/osnoise/$option" || return 1
>  		done
>  	fi
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>


