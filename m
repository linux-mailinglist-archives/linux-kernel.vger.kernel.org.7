Return-Path: <linux-kernel+bounces-884765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E1C310C2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8489F4E63E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6852D2387;
	Tue,  4 Nov 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="EHj9GJ82"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609C20C461;
	Tue,  4 Nov 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260491; cv=none; b=PxmJdVygn90bwY6qa7MNGrK671kFjOfZrx/iGcAwqWFU3/OEDmiqGt31XZiEwG0M7R7hDUtuViPTcSNpRjJfXzrKyhz0zxFUX7Yi/slq7zlucFUCSNM/jZXoh824zzxco7I13JE29ybCsRYGetrzZlZLLG0LLonhT7TrcR9jYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260491; c=relaxed/simple;
	bh=uc/8ejcoZDbUpl2EHW+DLjiUTeMFiOZ/Hs8Q/6/p07E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/rzd5y0VaxthQHk2tyweimoMy/TG6LQNY+rXTT7kTqw8OamoVbmIEISjzeOGOclkz6tJZ0jJeKHMIX1iKQIrIcuOidDm8sHMQIOjEJWmE7AwlQJpLi6KIvk+saf/Q5R5kDKLQsSnr1VsJxpKjwrqucG9rckd9/h0M60rjVN9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=EHj9GJ82; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=XroWTFaHaLjzCBD3qe5otExhpbBe+lCTCNNOrDe9uSo=; t=1762260488;
	x=1762865288; b=EHj9GJ82tvolPNvcmlOvJOVQqLhh0B0fjUrFVSn792lDviEHa5FTIxrlM7f6G
	MKE6QHKPeCJSxKKfkFOmIVFsWXy7cT+VbygEKnaGGwoi3S0BQVbK9aqMED3l8xmI9kuBmQDMLgWZI
	uWOW9nyVWW6l4vsKnsGSof9vI2bsAnhUa0RuYdCmG0L4dp1fyQD7fNEE3gAvqxOar+qGDaaHlDkcH
	rwMobfVBkEx0kIm+wxN3LQ7RUq57Sn7SdEDFfoE7Rp3WL/DZ3wTv83HuATJrk72N6rCKYB9YRgx0W
	TuCP9F93YuB9mlU26S3UqX2meINW4tz/3BX43q4pwIouJ7wNkA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vGGSB-00000002wGc-1zcs; Tue, 04 Nov 2025 13:48:03 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vGGSB-00000003jSw-1600; Tue, 04 Nov 2025 13:48:03 +0100
Message-ID: <431acc7729d58ad3381efc89a877610d33c07e22.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] Add Magnus Lindholm to MAINTAINERS (Alpha port)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Nov 2025 13:48:02 +0100
In-Reply-To: <20251104103525.26410-1-linmag7@gmail.com>
References: <20251104103525.26410-1-linmag7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Tue, 2025-11-04 at 11:33 +0100, Magnus Lindholm wrote:
> Add Magnus Lindholm as maintainer for alpha port
>=20
> Changes since v1:
> - Rephrase commit message and email subject
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46bd8e033042..49ada25357e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -915,6 +915,7 @@ F:	drivers/staging/media/sunxi/cedrus/
>  ALPHA PORT
>  M:	Richard Henderson <richard.henderson@linaro.org>
>  M:	Matt Turner <mattst88@gmail.com>
> +M:	Magnus Lindholm <linmag7@gmail.com>
>  L:	linux-alpha@vger.kernel.org
>  S:	Odd Fixes
>  F:	arch/alpha/

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

