Return-Path: <linux-kernel+bounces-882996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09634C2C3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55D714F0A75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B7330DD14;
	Mon,  3 Nov 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="az87ODKd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D1220F5D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177275; cv=none; b=SrZVnRn0QaeD56ncGI6RgCgWd+CNV9b8TKc0IaBL+NzSm6oif/Q8kt2E1zPiLHlWy5gxTkyVZaXBqvhXWupvY49/jCf+GnuHyCD7UVXZI8gbGqlvkZkPPiNdIvS6XC4W3e/UlYULHD15B7rNP+5y3VEhWyXa95nwEzqEDskur/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177275; c=relaxed/simple;
	bh=PL5RlMkmVPmk8pKLO9PSfL1cPZTP9SlsAypQzCaWjyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltTMw1rsfh/Zb9mOPAuEe3X91ZEbNdM4z2dyHku7I1Dn9i03JbtDmGzSMtUSLMCGO6+7KvkHnUo4tzOwSvejX9S949Or0RAU6bCJ4DIPZnri/ujs73PMgmAzAYGwHQ/MU0vGwTDl6VcDgvPKb8TXF+SDl6sF4wHpgtVRU3tTwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=az87ODKd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762177272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1WpvrFRebBCZEATWkdnBi6tVWX1C17mtnJJUUIn6xQ=;
	b=az87ODKdq101hHuENS94/WQZWOfEqCwOa42OJgrJSIHSsIdWIOfxcEaktbIrdZ8WKmeWcP
	35OY91J+LbSr+ORZMU5kNsG5mkHHJjK1NzJN8ho2WC1bEmkpnSv1Hf/5bjYPjlHSJ/US3t
	hTV+dwt4PMfkgeKLkYIEul+aXhEV1AM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-IlfE6v5vMyiOqv8jqKf02w-1; Mon,
 03 Nov 2025 08:41:09 -0500
X-MC-Unique: IlfE6v5vMyiOqv8jqKf02w-1
X-Mimecast-MFC-AGG-ID: IlfE6v5vMyiOqv8jqKf02w_1762177268
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD3A1809A04;
	Mon,  3 Nov 2025 13:41:08 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 05714180045B;
	Mon,  3 Nov 2025 13:41:03 +0000 (UTC)
Date: Mon, 3 Nov 2025 10:41:02 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 6/7] Documentation/rtla: Rename sample/ to example/
Message-ID: <cydxc2a2oqb2gzkhzuvda476eirhw4gunrfrhs3apz26ua5q2i@7yomccokjozw>
References: <20251027153401.1039217-1-tglozar@redhat.com>
 <20251027153401.1039217-7-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027153401.1039217-7-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Oct 27, 2025 at 04:34:00PM +0100, Tomas Glozar wrote:
> The sample/ directory in tools/tracing/rtla was renamed to example/ in
> an earlier commit.
> 
> Rename it also in the documentation.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  Documentation/tools/rtla/common_timerlat_options.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
> index 1f5d024b53aa..c6046fcf52dc 100644
> --- a/Documentation/tools/rtla/common_timerlat_options.rst
> +++ b/Documentation/tools/rtla/common_timerlat_options.rst
> @@ -64,4 +64,4 @@
>  
>          Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
>          task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
> -        See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
> +        See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>


