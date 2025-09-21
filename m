Return-Path: <linux-kernel+bounces-826122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09E7B8D96D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800FB189F080
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B2B25394A;
	Sun, 21 Sep 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="NkL1W8Ri"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595CA4315A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758450691; cv=none; b=UE7zJM242PfTTZbdFCHepNH59wVW0xkjHnr+7KLylxcmx/gPj0dA+yJkUFRkWeuo8JRiD0LyB8M9ASkisXye3BPGv+O/3cGXM0hQpP46x5j6nzDWyQHkY1WqECjKsusicHk+zZbrN2SFFt0Q3vBkMZofdMCZ9ELbEfg656668YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758450691; c=relaxed/simple;
	bh=UhzBOIAcRT3DtWbXX7SG+/Cq59SACa4Yp8xsjuPyop0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeD09ZZ1/QqCqor+U7JY/ystHXDexq2Tam7aLLXqeCpOr1GuPnnWFjS/1U0o2HLDRiDM9ScRSK6ijVHIzKQZirpFCg1H+9gtwcfF4exgAIcVO1VN2yWiKHvHfJO7qv+9FHvo2jbkz2StwGzN8uGOOQsODb2G6uUldVyBJJ61f+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=NkL1W8Ri; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B72D9240103
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1758450681; bh=ZscFgxaOdMe9Fpbe+Rp7hnlp06VZswaAdymqLttHLhE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=NkL1W8RiTiZl08x88D4b9irNhv9y1E0474eP+AsNO8+V/IoNX33D55e5l8pu+HKJf
	 ISOb4JItPSgl4TgQe0n/n8QLDTjauR6IPDn1yRzAt0gmM62BrVoTbJsg/1NEz2hHpN
	 HGlUl9uwvMcJZrXrlINEGvg99o3Muno0VbwdbNUCQhaf+KIbNRxPOHBGa91wjsz+Sz
	 Fwzu533dfsIZ/O1PyEZbIbtQg0NRU2XLJKKXSCuRdW1prpkf16pp3tKq0Gw0WYqhQu
	 DJ0nJ91KTF9uj29qDY8sXd8eX/DjpH4F7sfVyYWgbqlzqkGBeiuxCGP0JkbotL3fAL
	 x9AxKA3oy3Fow==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cV2bC1lTqz6tm8;
	Sun, 21 Sep 2025 12:31:19 +0200 (CEST)
Date: Sun, 21 Sep 2025 10:31:21 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, Tom Rini <trini@konsulko.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	J =?utf-8?Q?=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] scripts/make_fit: Speed up operation
Message-ID: <aM_T9mtmEdAGNpLi@probook>
References: <20250919224639.1122848-1-sjg@chromium.org>
 <20250919224639.1122848-2-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919224639.1122848-2-sjg@chromium.org>

On Fri, Sep 19, 2025 at 04:46:25PM -0600, Simon Glass wrote:
> The kernel is likely at least 16MB so we may as well use that as a step
> size when reallocating space for the FIT in memory. Pack the FIT at the
> end, so there is no wasted space.
> 
> This reduces the time to pack by an order of magnitude, or so.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> 
> ---
> 
> (no changes since v1)
> 
>  scripts/make_fit.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> index b4caa127d2c3..904f45088978 100755
> --- a/scripts/make_fit.py
> +++ b/scripts/make_fit.py
> @@ -100,7 +100,7 @@ def setup_fit(fsw, name):
>          fsw (libfdt.FdtSw): Object to use for writing
>          name (str): Name of kernel image
>      """
> -    fsw.INC_SIZE = 65536
> +    fsw.INC_SIZE = 16 << 20
>      fsw.finish_reservemap()
>      fsw.begin_node('')
>      fsw.property_string('description', f'{name} with devicetree set')
> @@ -330,10 +330,12 @@ def build_fit(args):
>  
>          entries.append([model, compat, files_seq])
> 

> -    finish_fit(fsw, entries)
> +    finish_fit(fsw, entries, bool(args.ramdisk))

It seems like this line should rather go into the previous patch.

>  
>      # Include the kernel itself in the returned file count
> -    return fsw.as_fdt().as_bytearray(), seq + 1, size
> +    fdt = fsw.as_fdt()
> +    fdt.pack()
> +    return fdt.as_bytearray(), seq + 1, size

The rest looks good to me. Easy optimization, big win :)


Best regards,
J. Neuschäfer

