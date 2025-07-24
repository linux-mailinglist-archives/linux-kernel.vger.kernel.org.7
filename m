Return-Path: <linux-kernel+bounces-744515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B73B10DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5845A10B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BC02E54B4;
	Thu, 24 Jul 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="m+jt14ln"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A92E5407;
	Thu, 24 Jul 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368026; cv=none; b=A/xRDYWj96inTXQpHisOsIJ5pL1JyVDV0+q9FD6lMviWOLOSPWuDR7a3JnwVu4eaCkIQnsA9WBZ0M6A2ZHENkLjZ2g+yW3bdmV6NcpaxZf0jodhSw6z8ijRopiYe06GDct1Z9lwDVjcUm06Pd02aJLEZeFx1NoDIsVMdynfkaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368026; c=relaxed/simple;
	bh=ZrIDXZN4Ude9qm+64/fqR7Czwe9P160iQT2jxQem3H0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLW1/fFilL/iWBKBZegnpNofKRjODLaNMydtCDrDbLNrkU+8M8pH/DJ3YWAoJNckRf8LMU5XdIQB/LMqCinGA7LKiYq4ViegnDK5vj+a50aE3nl1mtaGXslqxZoCJ6y3RLTWfBo/rL2LVnt/qQnWm9zYC27Hb46BYlEyYHjNjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=m+jt14ln; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E12ED40AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753368024; bh=lWnVtqjyg7h+NvEXwPQ7inlN3CEUVmi4sKfntgVUcAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m+jt14lnAbL1u0tismNpXDPhBzxJept4Z3jkMipaQCxP7PWxoL+ligiXqAKafW60w
	 mAffkKSrYYXxDGU8LoB/96BDAzRENq0uo5mWOOo18UsF4voNTadVRtgpXQdQbB6eLg
	 xDg/U9GmCNhkXiZgtlpndtHAgbXQDXlPwHBgvnNakyGAZ7O2MqXYweGaVONv/NtwDJ
	 BViY1qrkf2P1XQPPhcqhgy056wP3xl+9UPMGZSZIVAJqCNs7RQQ5wcwqLTYlYXArLB
	 mivMU7lF0fA4PvOMqbSRa2J9LtCLvu3kWA/QuJyzwi3eqcr83G2Hfkp2fX3F0uIjZc
	 5HDYv3b10+9Cw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E12ED40AA9;
	Thu, 24 Jul 2025 14:40:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Kees Cook <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2] sphinx: kernel_abi: fix performance regression with
 O=<dir>
In-Reply-To: <e25673d87357457bc54ee863e97ff8f75956580d.1752752211.git.mchehab+huawei@kernel.org>
References: <e25673d87357457bc54ee863e97ff8f75956580d.1752752211.git.mchehab+huawei@kernel.org>
Date: Thu, 24 Jul 2025 08:40:23 -0600
Message-ID: <87ecu5abzc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The logic there which adds a dependency note to Sphinx cache
> is not taking into account that the build dir may not be
> the source dir. This causes a performance regression:
>
> $ time make O=/tmp/foo SPHINXDIRS=admin-guide htmldocs
>
> 	[OUTDATED]
> 	Added: set()
> 	Changed: {'abi-obsolete', 'abi-removed', 'abi-stable-files', 'abi-obsolete-files', 'abi-stable', 'abi', 'abi-removed-files', 'abi-testing-files', 'abi-testing', 'gpio/index', 'gpio/obsolete'}
> 	Removed: set()
> 	All docs count: 385
> 	Found docs count: 385
>
> 	real    0m11,324s
> 	user    0m15,783s
> 	sys     0m1,164s
>
> To get the root cause of the problem (ABI files reported as changed),
> I used this changeset:
>
> 	diff --git a/Documentation/conf.py b/Documentation/conf.py
> 	index e8766e689c1b..ab486623bd8b 100644
> 	--- a/Documentation/conf.py
> 	+++ b/Documentation/conf.py
> 	@@ -571,3 +571,16 @@ def setup(app):
> 	     """Patterns need to be updated at init time on older Sphinx versions"""
>
> 	     app.connect('config-inited', update_patterns)
> 	+    app.connect('env-get-outdated', on_outdated)
> 	+
> 	+def on_outdated(app, env, added, changed, removed):
> 	+    """Track cache outdated due to added/changed/removed files"""
> 	+    print("\n[OUTDATED]")
> 	+    print(f"Added: {added}")
> 	+    print(f"Changed: {changed}")
> 	+    print(f"Removed: {removed}")
> 	+    print(f"All docs count: {len(env.all_docs)}")
> 	+    print(f"Found docs count: {len(env.found_docs)}")
> 	+
> 	+    # Just return what we have
> 	+    return added | changed | removed
>
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Closes: https://lore.kernel.org/linux-doc/c174f7c5-ec21-4eae-b1c3-f643cca90d9d@gmail.com/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> v2: updated description. No changes at the diff itself
>
>  Documentation/sphinx/kernel_abi.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
> index db6f0380de94..4c4375201b9e 100644
> --- a/Documentation/sphinx/kernel_abi.py
> +++ b/Documentation/sphinx/kernel_abi.py
> @@ -146,8 +146,10 @@ class KernelCmd(Directive):
>                  n += 1
>  
>              if f != old_f:
> -                # Add the file to Sphinx build dependencies
> -                env.note_dependency(os.path.abspath(f))
> +                # Add the file to Sphinx build dependencies if the file exists
> +                fname = os.path.join(srctree, f)
> +                if os.path.isfile(fname):
> +                    env.note_dependency(fname)
>  

Applied, thanks.

jon

