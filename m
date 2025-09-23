Return-Path: <linux-kernel+bounces-829718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A663B97B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE564E1121
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673F2E718B;
	Tue, 23 Sep 2025 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtocxwQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82674A48
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666210; cv=none; b=gin1+C7b+1a5oEW44cxWqHFkQ4TvGAyHFEw0qBDauacht4n3x3TLIxdAdL47tvPC5Md+AB8nPsiHN2PeRo9buYHW26NnYTsL9FsynBFJZOv16XvS4pKehEOrCh++JX78q4v8uC7LX4ZsH2Q31o0vki/0gMoQw6BN1vQr46FVypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666210; c=relaxed/simple;
	bh=er6I1BrUNc+QN/OSVIWmwzddLo7Ydss8hB8iYeCOu7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkPR7BZ7Lv/Wq6xb2tcU/+DGlcIA6vOyt/zRv9K1bz7DW4FwnPiEkSyfGAmumBh7sirx7EauQKvjc7Kh6MRD68uWwlL77J8SXfDsV49pPztVKiR804oKE7zDD0PXOPZt7krdCNv42qwWAGa6X+B25UkUed80JD5jA1t/sYqgOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtocxwQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD16C4CEF5;
	Tue, 23 Sep 2025 22:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666210;
	bh=er6I1BrUNc+QN/OSVIWmwzddLo7Ydss8hB8iYeCOu7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtocxwQZSEngLAGzsX7ztp9NxfTRjFCj8viHHYJQMo8s8rT1o1qG8tbwcwiGZ/zVd
	 PasOcRph0L8DGJohycDsXwkQw+/qGGAWbMXUqF5BLPlDGz8KZrXz1DrE9bWStwgwJG
	 ZjtccPjLSDAJKmadABfqi2dV6sjTBHKOTX7wHo+2wgKWdBK7KfZ1M+eRJV1+bjJnyn
	 FI1PgkdqrH/ZxwKKCk6vG8+0/w/2ukaGi3bxpSB8zpId+UBQRGGzcFqHLJbWN4dkYF
	 3CFePI050ZgNE8TwMHgXHHI6jjaqE+R6OQaBi+P/1S6ccDkfM1XW5BPu9tjUnPwPn/
	 01nAave7M7dfQ==
Date: Tue, 23 Sep 2025 15:23:28 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH v2 06/17] objtool: Improve offstr() output
Message-ID: <ksgftd2cyrimrsk4dgey7zhdc3dvkh54wuvu5w2sv5wddw44sj@4f3f2xcxzfaj>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250619145659.1377970-7-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619145659.1377970-7-alexandre.chartre@oracle.com>

On Thu, Jun 19, 2025 at 04:56:48PM +0200, Alexandre Chartre wrote:
> offset() formats a section offset into a "<symbol>+<offset>" string.
> Improve the output to just "<symbol>" when the offset is zero.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>  tools/objtool/include/objtool/warn.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
> index 125093d568be..d89e6ae69143 100644
> --- a/tools/objtool/include/objtool/warn.h
> +++ b/tools/objtool/include/objtool/warn.h
> @@ -43,12 +43,12 @@ static inline char *offstr(struct section *sec, unsigned long offset)
>  
>  	if (sym) {
>  		str = malloc(strlen(sym->name) + strlen(sec->name) + 40);
> -		len = sprintf(str, "%s+0x%lx", sym->name, offset - sym->offset);
> +		len = sprint_name(str, sym->name, offset - sym->offset);
>  		if (opts.sec_address)
>  			sprintf(str+len, " (%s+0x%lx)", sec->name, offset);
>  	} else {
>  		str = malloc(strlen(sec->name) + 20);
> -		sprintf(str, "%s+0x%lx", sec->name, offset);
> +		sprint_name(str, sec->name, offset);

Maybe this makes sense for the disassembler, but I'm not sure we want to
remove the zero for the more general warning case, as the intent is
usually to point to a specific instruction.

-- 
Josh

