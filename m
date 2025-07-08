Return-Path: <linux-kernel+bounces-722262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABBEAFD71D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A1D4E0E63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A42E5B08;
	Tue,  8 Jul 2025 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="SUF7aykw";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="f/aBV9BJ";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="AUnVZ3PL"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406872E613A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002994; cv=none; b=H5GHGTMd8ZKUUHMQJ5kw0m3uXWRpfGx7ntI+L6agKjUBHjmIUPrwGcGT+W/Wt0LYEA95B7A68SliUkmy4UGowrPPMw7QZGPLRlKt2vv5Wu1h2iUhcuDp6bUhmBuK6Jdh1uvlbrOgNyrOYBszCHZEl5cgiRqFerMy0DH21YIflZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002994; c=relaxed/simple;
	bh=RwK6tgIFPH8HSYPA5RLI9kPCl0+y/45IOf5J0y/qaE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyTaIQATace+n5nVFsT1ElHq7jnhzwxK3fZ2TwHlzX5g1fOeSm4/Uw5N0AHUSF3vimq65vEgVFaLpLTSNfGScuYdFMtz+6RayhLQC/V4HfO/iyhLI6tbhQgTK2SE+Api3Z3vHZLKJucoh6KQx9UT20hC8f3cLVoLSgivit5adl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=SUF7aykw reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=f/aBV9BJ; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=AUnVZ3PL; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1752003888; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=vow2LS2yIOmbNmmVTiqKXSu2tQNynqPkCNf2Wz6HwfU=; b=SUF7aykwpsgpTrqhf89Yv07pbv
	5r2Zzr+m7eVU+sQ++s/fl77vyx65MfBTEDojkvNRSSVoRzwd99kDZ1FtvTVhyHh0LGk0o+cOS6qyp
	abW+QKJcBWfQp+85JdQvFeIC6i2K8X/qxioAE7j1xT2MV4Tt72G68xhV/OgQpQS5HuNNgM1NHvHRZ
	GSwZ1Qe9SWSX0HPm9HQwnO7hCMu0yicFOeCCCw/vFOA3bPEigrEKS25aQ4LABLhoi1/lHF5M8Zlzz
	7Qx3RZpPY/LKJgXZkqHgUEA6CPgyY+0pTy5znV4Kxw3Imu1uNAHX821SuJ8bUyA503PGJHkRuAs7y
	bk7X2AOg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1752002988; h=from : subject :
 to : message-id : date;
 bh=vow2LS2yIOmbNmmVTiqKXSu2tQNynqPkCNf2Wz6HwfU=;
 b=f/aBV9BJ6O27J2myqfge/mr7bPLekeKcU8WAB87j5/oiCHwd/gg/Y2YgzWoglDjxjmOEW
 I6DRwGwlyh7xPVOT9mjAHc6l1OHMKUx5xwFLjdmtipPPsmRVPq0cvxAZ3ZeIA9nbmwgLs1g
 luwDS8wqFpvnK/VakJvN+I/qwuJlWwDMHJGisdop+ZsysgyFC5uH4HcxjHzoy36hOykejBc
 Rp03vX+vRLbVHK1y6fpMI+tg6BC5HFl5hjQAAdsQx4Wt+eNUwlwbJny6atDED5CM6prIDED
 WS+hRSAGwToLgfsVsJQkiUjiLGAjcZVjiVv5LtkU0RWS6AxrURSkXG2iII2A==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1uZDtV-TRk4fw-Oj; Tue, 08 Jul 2025 19:22:21 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1uZDtV-AIkwcC8pbj3-HrOb; Tue, 08 Jul 2025 19:22:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1752002535; bh=RwK6tgIFPH8HSYPA5RLI9kPCl0+y/45IOf5J0y/qaE0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AUnVZ3PLysOpgJ+O8nXLpyp7L2FFmrtLXoWI62GfnvwC/PalgKc1I43LPpH/vnDe/
 ifG0VOUDSoZqhBoPTcumAdCLwj4RYYkDN3WxQ7dYFghaQrRspuLXd2tLysOIQt2EJ3
 6YMoxi8AKL8SaSVWfGfNYALjBRiGuWcEGJFZ0juM=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id BE4773E698; Tue,  8 Jul 2025 21:22:14 +0200 (CEST)
Date: Tue, 8 Jul 2025 21:22:14 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: Restrict module namespace access to in-tree
 modules
Message-ID: <aG1v5v0cIy5X70UD@fjasle.eu>
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
 <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
X-Smtpcorp-Track: s0BGd2XEeW6Z.FVw7lfdiuIlm.s4CXSgLiHvo
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sW3z-ZDckN
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Tue, Jul 08, 2025 at 09:28:57AM +0200 Vlastimil Babka wrote:
> The module namespace support has been introduced to allow restricting
> exports to specific modules only, and intended for in-tree modules such
> as kvm. Make this intention explicit by disallowing out of tree modules
> both for the module loader and modpost.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  Documentation/core-api/symbol-namespaces.rst | 5 +++--
>  kernel/module/main.c                         | 3 ++-
>  scripts/mod/modpost.c                        | 6 +++++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
> index 32fc73dc5529e8844c2ce2580987155bcd13cd09..dc228ac738a5cdc49cc736c29170ca96df6a28dc 100644
> --- a/Documentation/core-api/symbol-namespaces.rst
> +++ b/Documentation/core-api/symbol-namespaces.rst
> @@ -83,13 +83,14 @@ Symbols exported using this macro are put into a module namespace. This
>  namespace cannot be imported.
>  
>  The macro takes a comma separated list of module names, allowing only those
> -modules to access this symbol. Simple tail-globs are supported.
> +modules to access this symbol. The access is restricted to in-tree modules.
> +Simple tail-globs are supported.
>  
>  For example::
>  
>    EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
>  
> -will limit usage of this symbol to modules whoes name matches the given
> +will limit usage of this symbol to in-tree modules whoes name matches the given

If you keep touching this line, might you fix the typo?

s/whoes/whose/

Kind regards,
Nicolas

