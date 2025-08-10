Return-Path: <linux-kernel+bounces-761441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BDDB1FA1B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B603B93CC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70E24C66F;
	Sun, 10 Aug 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql9uUJPV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FA22F77B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754832194; cv=none; b=o03Qvo+Zi8LDCE1mbw3kbHdHMEqZllMDD5sPwe/x6+b5GMaVqSq+8GeXw6MmOTIn2O17aFmgs5J8QY2o4Upan8bK8hsOajdP2ywTJHYBhOJq8Q0D423YzbSlB6Xito+bK2FcF4LEAD3gC4UFIs21rSwSKXRP6Qg6k7iOFwF6t4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754832194; c=relaxed/simple;
	bh=f4ZCGbsp9dW4/nJuX1ITskGOz3OSKVrV5h0qYspY0vQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZdHwIAj5ORNkNpNr8FhHFcFHXRa6xr69wYe5caCoynwzb0nZn87W+Cgv8s+cxwoqjQzFzn20G5VE95+nHRxS0cPLEhX5GYZEAm7UskQnijIC5GiIQrS1JK7az8I/qjLV5dTeDSR1wg+5aduohoLW9SXpdDH/rGaNI0smKY0T7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql9uUJPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4795C4CEEB;
	Sun, 10 Aug 2025 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754832194;
	bh=f4ZCGbsp9dW4/nJuX1ITskGOz3OSKVrV5h0qYspY0vQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ql9uUJPVslclFCjeShevsloAkjL+4CtfehIpFz3EnnTp4kFmS3+4fjErzyOHhOyFB
	 ASDhTmO0Cq9DkO8O915x/jab2SXZiJ+vvDnw2ve+F9c/Z6XlzI/dFQ253nMZR/v31S
	 fTt6N9jjwhZNzYp9NTWKenTak0PnUZ7Al+/OeNAW7SgAK7mOPn1tcLlPsY2oGWW5jA
	 lSdo92JMVxK7og8/xG5Vvf8ibAYs2mme7lIcoxQueApxGXC6TIDaBTFJiVbMvATp6x
	 1RIQ5o5iv1hHPP/HQB3SxaBtLXH1EtQpSe3A1Tfm3Q4kYBEzcwcEs6lS0y3LjIoyl2
	 KjipdItcdH06Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 10 Aug 2025 15:23:10 +0200
Message-Id: <DBYS3FAEVMHC.178SXO45NIBI8@kernel.org>
Subject: Re: [PATCH v2] drm: Add directive to format code in comment
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robin.clark@oss.qualcomm.com>, <antomani103@gmail.com>,
 <dmitry.baryshkov@oss.qualcomm.com>, <me@brighamcampbell.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Javier Garcia" <rampxxxx@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg> <20250810112218.293272-1-rampxxxx@gmail.com>
In-Reply-To: <20250810112218.293272-1-rampxxxx@gmail.com>

Hi Javier,

On Sun Aug 10, 2025 at 1:22 PM CEST, Javier Garcia wrote:

Thanks for the patch.

> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")

The Fixes: tag belongs at the end of the commit message, like all other tag=
s.

>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2444: Unexpected indentation.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2446: Block quote ends without a=
 blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2450: Definition list ends witho=
ut a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2451: Definition list ends witho=
ut a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2455: Unexpected indentation.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2456: Definition list ends witho=
ut a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2457: Definition list ends witho=
ut a blank line; unexpected unindent.
>   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2458: Definition list ends witho=
ut a blank line; unexpected unindent.

Even though it's rather obvious in this case, the commit message should con=
tain
the motivation of the patch and how it addresses the issue in imperative mo=
od,
see also [1].

[1] https://docs.kernel.org/process/submitting-patches.html#describe-your-c=
hanges

>
>
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
> v1 -> v2:
>       * Added the proper Fixes tag.
>       * v1 https://lore.kernel.org/lkml/20250804212902.22554-1-rampxxxx@g=
mail.com
>
>  drivers/gpu/drm/drm_gpuvm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index bbc7fecb6f4a..74d949995a72 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -2432,6 +2432,8 @@ static const struct drm_gpuvm_ops lock_ops =3D {
>   *
>   * The expected usage is:
>   *
> + * .. code-block:: c
> + *
>   *    vm_bind {
>   *        struct drm_exec exec;
>   *
> --=20
> 2.50.1


