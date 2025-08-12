Return-Path: <linux-kernel+bounces-765653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B8AB23BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1438627599
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A4B2D839E;
	Tue, 12 Aug 2025 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDcyhXgo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A427604E;
	Tue, 12 Aug 2025 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755038598; cv=none; b=p78Q/aHKabldr0/fFNJ+bRE0iznTC0UJCxW60RojffnWdsuuD/+g1Kjh6SQytLruvOeYTDsxwvyRjfiabjbSjM7s/kHCkHrtWn74N2vXGkkL1f1LQO/duu4tCQAVj+5aRrE+olydYELRxPRdxEGCxLOzh1jpP8179bKPQrOU87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755038598; c=relaxed/simple;
	bh=UxzWheqWoiB+m/TkMADcd0R6gmi2dNNc+ZH7D6ARViY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esrfCGRmbdUDCyLnZvQ3lKl3x2T0+j3NDoe0KiE0HIOEeSLAsdP8cFKgmZhti1tF6WyXYDAm8DDBsx88OXLhhl3STy5YKHtKTbkyKlFLACaULwmiQ7xwr1X5GhlZsGWl0rQJTNUrxuM4mOugTORGQBQp6lCpMOcimlqt6yxzSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDcyhXgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEA6C4CEF0;
	Tue, 12 Aug 2025 22:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755038597;
	bh=UxzWheqWoiB+m/TkMADcd0R6gmi2dNNc+ZH7D6ARViY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nDcyhXgoFjHxd5pitaBoHCKDwZuarm5cP7U/XkQqWX1p9am1/XfUAHqDpnV7rr8Si
	 Y2KIJZx95qT94vo+/Wc38sVJldrDP7V6VGeugaPMS2uxOpLVZj/jtYF7wMmj3MvbKK
	 ta3Dxt3QtfyAZDCtkQizElgPtS9gTYQCu7wLgv3Ojkh/0UOwQm6ZMNJ8RyHMrsdbRt
	 15pEgAYdslqI8ZExSIdQsQEBqlKP9KCUrIPG7aQ82bY6s7j0VI7trFfka2GV4Eh5rA
	 hybeMzSO2d2w2x75lT5gw5xSwFaMK0bSg1y6GutLXTIBETo/sv/URfhBGwfZE5WUuZ
	 hpPvEHyOI2hjg==
Date: Wed, 13 Aug 2025 00:43:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 1/7] docs: kdoc: remove dead code
Message-ID: <20250813004313.5b014127@foz.lan>
In-Reply-To: <20250812195748.124402-2-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
	<20250812195748.124402-2-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:57:42 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> create_parameter_list() tests an argument against the same regex twice, in
> two different locations; remove the pointless extra tests and the
> never-executed error cases that go with them.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 9e65948f8254..96e3fe4ec431 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -564,28 +564,18 @@ class KernelDoc:
>                  args.insert(0, first_arg.pop())
>                  dtype = ' '.join(first_arg)
>  
> +                bitfield_re = KernRe(r'(.*?):(\w+)')
>                  for param in args:
> -                    if KernRe(r'^(\*+)\s*(.*)').match(param):
> -                        r = KernRe(r'^(\*+)\s*(.*)')
> -                        if not r.match(param):
> -                            self.emit_msg(ln, f"Invalid param: {param}")
> -                            continue
> -
> -                        param = r.group(1)
> -
> +                    r = KernRe(r'^(\*+)\s*(.*)')
> +                    if r.match(param):
>                          self.push_parameter(ln, decl_type, r.group(2),
>                                              f"{dtype} {r.group(1)}",
>                                              arg, declaration_name)
>  
> -                    elif KernRe(r'(.*?):(\w+)').search(param):
> -                        r = KernRe(r'(.*?):(\w+)')
> -                        if not r.match(param):
> -                            self.emit_msg(ln, f"Invalid param: {param}")
> -                            continue
> -
> +                    elif bitfield_re.search(param):
>                          if dtype != "":  # Skip unnamed bit-fields
> -                            self.push_parameter(ln, decl_type, r.group(1),
> -                                                f"{dtype}:{r.group(2)}",
> +                            self.push_parameter(ln, decl_type, bitfield_re.group(1),
> +                                                f"{dtype}:{bitfield_re.group(2)}",
>                                                  arg, declaration_name)
>                      else:
>                          self.push_parameter(ln, decl_type, param, dtype,



Thanks,
Mauro

