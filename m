Return-Path: <linux-kernel+bounces-724914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F48AFF876
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08844E060E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE8723DE;
	Thu, 10 Jul 2025 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULc8iQ6I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5C280CC1;
	Thu, 10 Jul 2025 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125403; cv=none; b=CpupjPtOVDQnUfO3i61zxfvInfmM/LG3XbnowTawYIU38PztiMWU0VulDzZbN17Qo5JYlm5bOtVXaP5tt4LOyRNIlahp74KTRT5QVu9+jPmuFYpmwHAJNq7puExGQFciFdjmeuMJYl14ELg7USu/Ofe51M0iz2Z0hhKgLqSjTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125403; c=relaxed/simple;
	bh=b3zPIn9e970yn+Xqul44sW2gA5PAFIrHLi0wSGvkaQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oe33rJJ5qV54y2GoQlDkyZq9bTOuvLwkN2/tuwtS+GJAH/H4NnXL5UOTciHx/L38iEFiFaGHdL9ownTmE4AXYTPyomxLkY1CROGTJKozzQmt9Yj6PrI1ZCA5+k3TMpip9Ui/qQMIzYkCBiSxq+y9Gbb+VSd0eLFM9v6PYejnO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULc8iQ6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA16C4CEE3;
	Thu, 10 Jul 2025 05:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752125403;
	bh=b3zPIn9e970yn+Xqul44sW2gA5PAFIrHLi0wSGvkaQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ULc8iQ6IK0dMXwQw1y/L4K9yfHf+CcH0yL+6REtt5CRfV10uDKureh+P+LvcIIB5j
	 oWPGvvirDPVc1VY5GnrA7C1LUihujHQn14q+bLcadPqQsX5Z6P110eQl6RQzlYV+2b
	 jMWLtKZQD8DmMEq3QHICqjE5HgtEBs7axP1543T2xCYsi3WHcXhqfAWFlYio/CjEWT
	 l0S3l4eCAnk0uZel4McQFPtbmJTCsG2jjMNsnlY4YBwgxFFqSRv93foQqa/uJSu+h+
	 tdfQsgUaKMDgD3b2YRhQiFMgEQyp/0pxxLER0qpzRHE41eKYP/ULeXUCJmQeGpIVtw
	 9dx3mZVc9g+uQ==
Date: Thu, 10 Jul 2025 07:29:57 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 02/12] docs: kdoc: simplify the output-item passing
Message-ID: <20250710072957.04ccb5f0@foz.lan>
In-Reply-To: <20250702223524.231794-3-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-3-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:14 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Since our output items contain their name, we don't need to pass it
> separately.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_files.py  | 4 ++--
>  scripts/lib/kdoc/kdoc_parser.py | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
> index 9be4a64df71d..9e09b45b02fa 100644
> --- a/scripts/lib/kdoc/kdoc_files.py
> +++ b/scripts/lib/kdoc/kdoc_files.py
> @@ -275,8 +275,8 @@ class KernelFiles():
>                  self.config.log.warning("No kernel-doc for file %s", fname)
>                  continue
>  
> -            for name, arg in self.results[fname]:
> -                m = self.out_msg(fname, name, arg)
> +            for arg in self.results[fname]:
> +                m = self.out_msg(fname, arg.name, arg)
>  
>                  if m is None:
>                      ln = arg.get("ln", 0)
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index a5a59b97a444..97380ff30a0d 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -284,7 +284,7 @@ class KernelDoc:
>                  del sections[section]
>                  sectionlist.remove(section)
>  
> -        self.entries.append((name, item))
> +        self.entries.append(item)
>  
>          self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
>  



Thanks,
Mauro

