Return-Path: <linux-kernel+bounces-851262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1BBD5F72
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8CFA4F396D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE8A2DAFBB;
	Mon, 13 Oct 2025 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8yXFpBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099F25783C;
	Mon, 13 Oct 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384225; cv=none; b=AqqcQCanq/fqpGwHsZxpkD8tnuxgRCya3+I1rpXnbh9xq2JtH3PByrDivurTAMgHBWSY/sOtIbnhDC/xNJ5IaOVRU3ig6nnjfGbjTgewTxvsfr44nt9QVXUfp5gqnFe+prYlDWqtvb3MxJAnddO1/aPiSor3G868VvpSFyJfv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384225; c=relaxed/simple;
	bh=d2FeOCGFcYp/WZ02FyUpwo54JCrSqQCIqyxAnJFUwAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw5Fi8ImysIEmPhA2JwNRwt8kpEBk6p0fUh5BSlxITX3zvwExyKCXMv+/nmbWVqhV0xTh1W3oN2NFvDai8wgEHgVdsPj91sYHjPW8m1o+0A2Dcxr2QNqN8oN74iikAE+KKIvTU/rfHI4azPUr7m4f/0qbevgKyTGPxo8o4jfppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8yXFpBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B56C4CEE7;
	Mon, 13 Oct 2025 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384224;
	bh=d2FeOCGFcYp/WZ02FyUpwo54JCrSqQCIqyxAnJFUwAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C8yXFpBk0SHc/UDWzeUo2f/D4+pRv7TAB8iuvTy6os876kcwA5RU1Sl2VbfmRAvH8
	 ubu45mgrAFGtVqxH0DcOC9ITHDWfhPZptMBqALLRQHHe3OmgZvwwimdqIBN2X5AkCu
	 yiZRhGd1juoBIuuXrATxDbFRbZNqphJllApdS9OTdAMHO7jtBwF1AVUL1VxBOGUa3V
	 BhJmKV8OLAJ/ib/6I5EyHjlvkS2+a30tHdXBC1tgXXq/EoivPMAiTGiLj9C1IZFk8L
	 jGbT3YVVz10uD/HUaUC7erkGTdImc/6XFJVf0qKAd8r5QtqEkfII87ZDpett/lpVsZ
	 3S/HOwIqoH8Dw==
Message-ID: <f3a3f734-e75a-4d93-9a89-988417d5008c@kernel.org>
Date: Mon, 13 Oct 2025 15:37:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Eric Biggers <ebiggers@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>
References: <20251006135010.2165-1-cel@kernel.org>
 <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
 <20251013192103.GA61714@google.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20251013192103.GA61714@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 3:21 PM, Eric Biggers wrote:
> On Mon, Oct 13, 2025 at 12:15:52PM +0200, Geert Uytterhoeven wrote:
>> Hi Chuck, Eric,
>>
>> On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org> wrote:
>>> Eric Biggers (4):
>>>       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it
>>
>> This is now commit d8e97cc476e33037 ("SUNRPC: Make RPCSEC_GSS_KRB5
>> select CRYPTO instead of depending on it") in v6.18-rc1.
>> As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-enabled in
>> defconfigs that didn't enable it before.
>>
>> Gr{oetje,eeting}s,
>>
> 
> Now the config is:
> 
>     config RPCSEC_GSS_KRB5
>         tristate "Secure RPC: Kerberos V mechanism"
>         depends on SUNRPC
>         default y
>         select SUNRPC_GSS
>         select CRYPTO
>         select CRYPTO_SKCIPHER
>         select CRYPTO_HASH
> 
> Perhaps the 'default y' should be removed?
> 
> Chuck, do you know why it's there?
The "default y" was added by 2010 commit df486a25900f ("NFS: Fix the
selection of security flavours in Kconfig"), then modified again by
commit e3b2854faabd ("SUNRPC: Fix the SUNRPC Kerberos V RPCSEC_GSS
module dependencies") in 2011.

Copying Trond, the author of both of those patches.


-- 
Chuck Lever

