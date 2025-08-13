Return-Path: <linux-kernel+bounces-767692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF9B257BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374617AD796
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498942FC86A;
	Wed, 13 Aug 2025 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKYntVaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A462BD5B0;
	Wed, 13 Aug 2025 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128923; cv=none; b=fkWXZkhEBb5LdytDTzlxb4DVmWjPmFMFEjqwxlHLso5rahwrkz5XSPENhZKUy8+FHYTDt4UoEctQV8oULUo5gJqjve99Ip/dWY6zxocbgM0ju3rgUj01tWrRklpO+mcgGaoRC0O0UudThJIxvgpFdn4jATk/RMKyqDVgbqm+w10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128923; c=relaxed/simple;
	bh=PK4dNDWStNwetNV4Eyluf2wjd12AUIdIRPnaHwPMuxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PP4JilowOs4BUo7nERNXX8FccqA2H0UajsF0CnirdEsxzT08Zf9eIbP+5W3yKD2i5Q1HsO4LHLFB0Ms3OPyNMcurzH4GNXmNN/137m5w5GL85BgqksZiR6an7xw85NHDipELbRe/jiX6JlP6YvWI9NclTkVyEORIT/Dx5D7YHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKYntVaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA077C4CEEB;
	Wed, 13 Aug 2025 23:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128923;
	bh=PK4dNDWStNwetNV4Eyluf2wjd12AUIdIRPnaHwPMuxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hKYntVaZEqEX4yx4OPxFgn2qg/Ho89AjGDC93H31TKAwfejxbZGmzyDsh/uDs33X9
	 Kq1yqZpdBxLTicLReUANHlWwVFIxobYoeuw4LCv/t5qO04HxjWG+9NBwGWlsHByhcU
	 u2QZFo535HFaqcsLu9JAJRCZ2ychgHwSzDSUp3rpRQAO7s7MruPIUZsu/T+LsO3YIF
	 QZGAfAJFR1qZyJ2MGcPa+FyOnyZ+Yb/vUl3y+sHG3pwKVzeoUhrMZIgr4U+ecpZQ+Z
	 HpRv8Q8gbXiBXvqmi93X6ZC3YdxsFahfnjuZyGF/xJ/a9hqoOTlXFc1u1eCWYFz09P
	 alk97gd1x72tw==
Date: Thu, 14 Aug 2025 01:48:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 10/13] docs: move kernel-doc to tools/doc
Message-ID: <20250814014839.465f0d1f@foz.lan>
In-Reply-To: <20250813213218.198582-11-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-11-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 15:32:09 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> deleted file mode 120000
> index 3b6ef807791a..000000000000
> --- a/scripts/kernel-doc
> +++ /dev/null
> @@ -1 +0,0 @@
> -kernel-doc.py
> \ No newline at end of file
> diff --git a/scripts/kernel-doc.py b/tools/doc/kernel-doc
> similarity index 100%
> rename from scripts/kernel-doc.py
> rename to tools/doc/kernel-doc

Heh, this is not right: you forgot to update LIB_DIR. if you do that,
you'll break the script. See my comments to get_abi.py.

Thanks,
Mauro

