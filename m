Return-Path: <linux-kernel+bounces-767684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D5BB257A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898E91C27317
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC921E9B31;
	Wed, 13 Aug 2025 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti4SdPLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECEF2F60A8;
	Wed, 13 Aug 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128190; cv=none; b=r/xJUMVi1O1s5+fRTzeFApuUtB6EX+5p7LmXBsUIvN8ah7HsixG7Ei/yl6tp3VNatDmAhv5qJKeyYTG03l4F3qIQzgIWP5m7HEA3IjODo4oSUBSl8i1NazPoE3BEA4I96qdPCp4Y84SCzx0KDWtnpao+c5h8ejPqXsmmpoPleRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128190; c=relaxed/simple;
	bh=GrowyMOTf2eo7vZG6Va45vgPnVSXwtAWz0NkFipeego=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5E7LKCLw1Qj67Ng5b9xD0KOuAtCipnBN9fQ6V4O3U7Ix1b4uGq5lD5sGLLEDinLl71SfW0Gaurs0XPcu2KBNcJ6VbpA1AUPVBT2MTbCyaOlJEkcBwJLopwky6KeQwpTgXqDg1KD+D2n4Ljsm9JPsinA0WeIkbuzdD9CkGfpdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti4SdPLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E0EC4CEEB;
	Wed, 13 Aug 2025 23:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128190;
	bh=GrowyMOTf2eo7vZG6Va45vgPnVSXwtAWz0NkFipeego=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ti4SdPLVzuJ9g2Pb44vD9IdqtgN3pqO/bX9jayF7aVea78DhhhEpXdlhVO5rLnfEV
	 sI5X8WdZ8/u79fjQgvoeaoJrH9zEoHYXLmFaacHy/4gd3rtZzT9qNOV9oidhWUWf2Q
	 xkWsmApacZB/uYdOaxOHxbuYVhbUq7Qt8j6xD5lYbBoMZvgXPxPC9kvyDUTYfaEF4s
	 Wus8EQND3O0MvOPMEiO+q+W+y4uiGU6Qme0dy8sjtokxRrIRIoR08BsH7nxGKMSI6C
	 cv5o+GRP+ojmytfO4TWCtHW5+sr5XHYJPX1ZOUZb6lgK/kRw+HwybV6VFH7rhDOASO
	 3sP4EndLknvcw==
Date: Thu, 14 Aug 2025 01:36:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 08/13] docs: move test_doc_build.py to tools/doc
Message-ID: <20250814013626.508ad36f@foz.lan>
In-Reply-To: <20250813213218.198582-9-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-9-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 15:32:07 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Add this tool to tools/doc.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/doc-guide/sphinx.rst       | 2 +-
>  {scripts => tools/doc}/test_doc_build.py | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename {scripts => tools/doc}/test_doc_build.py (100%)
> 
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 2a0fc6c39cf4..d874dd0ed7d0 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -149,7 +149,7 @@ a venv with it with, and install minimal requirements with::
>  
>  A more comprehensive test can be done by using:
>  
> -	scripts/test_doc_build.py
> +	tools/doc/test_doc_build.py
>  
>  Such script create one Python venv per supported version,
>  optionally building documentation for a range of Sphinx versions.
> diff --git a/scripts/test_doc_build.py b/tools/doc/test_doc_build.py
> similarity index 100%
> rename from scripts/test_doc_build.py
> rename to tools/doc/test_doc_build.py



Thanks,
Mauro

