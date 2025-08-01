Return-Path: <linux-kernel+bounces-752917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B291B17C59
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491924E0E41
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337611F4199;
	Fri,  1 Aug 2025 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC1HNMJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845851F3BBB;
	Fri,  1 Aug 2025 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754026204; cv=none; b=dkqmBn+vLXdLhAz3tpOMxypOOHKYzWD65t3ghI8jvJ9mHyg+cshVjZRWTkZQ9l40y547wIT/YEvnXnKjx+r7X2KahMK91aikRC5Dvri4vJ9WRzJF9tFLw6lR7FJIx/vN502EGM3i32iXuKUw6SyDIbw6Dqbbzs5twFcbZn6PAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754026204; c=relaxed/simple;
	bh=7MtmqtxN1aDsOmOwDn6qhwili5ZD3s7bOzbnICCfPSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PY/y0EWiObBzbXLddT1YFkqeDWHTq7WlQUzFHzGjuJc7UziH8t96OO/41nnGeSvt6DM1ql2KHxBsQXcD3bno5K8Uvvq5QifyPPu226Y78KNuGmi06N9kpvozzyPimZ6gSLjc35axN76d+Dc/T6XFB55ZYdZYyaNJPNS29Runifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC1HNMJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029AFC4CEE7;
	Fri,  1 Aug 2025 05:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754026204;
	bh=7MtmqtxN1aDsOmOwDn6qhwili5ZD3s7bOzbnICCfPSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uC1HNMJU3MlylwvHvdHOZwHQmbdVIiy4riJZay+4jt69huP4xINUTodmBPWAFGnU6
	 VHJZ+G38GezFNeNXBURPWgsz4hszwiCO2EBVlD77Ja+hsexVcwTZC8wbE6m9GUpjzu
	 I2Gwt03mmxp5ZOtGKRiD1kXDFcOIND+HZxM0HBvoQksK5kRO03eFgqQIfX+CIYhLOp
	 F54oc73pp6nZUJcEBVV1Srtu30MQtLZva9Hd0vLaxcTAjNsxdeUHB3ArtbiPZX5oIp
	 msXx8s+bL4X7+uRGBbbWtljbhQXl8srdpPFcfjGiBMpg9eQKUH1lZsJTs+cdLGQlg2
	 ZXQsFZIp7WidA==
Date: Fri, 1 Aug 2025 07:29:59 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 02/12] docs: kdoc: Move a regex line in dump_struct()
Message-ID: <20250801072959.519460bd@foz.lan>
In-Reply-To: <20250801001326.924276-3-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-3-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:16 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> The complex struct_members regex was defined far from its use; bring the
> two together.  Remove some extraneous backslashes while making the move.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 93fcd8807aa8..9948ede739a5 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -551,7 +551,6 @@ class KernelDoc:
>          ]
>  
>          definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
> -        struct_members = KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\}\;]*)(\;)')
>  
>          # Extract struct/union definition
>          members = None
> @@ -683,6 +682,7 @@ class KernelDoc:
>          # So, we need to have an extra loop on Python to override such
>          # re limitation.
>  
> +        struct_members = KernRe(type_pattern + r'([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
>          while True:
>              tuples = struct_members.findall(members)
>              if not tuples:



Thanks,
Mauro

