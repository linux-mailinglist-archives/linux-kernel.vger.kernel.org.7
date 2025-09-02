Return-Path: <linux-kernel+bounces-797170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37043B40CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E10207FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADC334AAE1;
	Tue,  2 Sep 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1x6xb2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34D34A30D;
	Tue,  2 Sep 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836605; cv=none; b=OFPwTbhBbg2HvBLit9jnIKLLPGHlX0V9pRueMv8drt/qE5FqrO1f9SwMfkZmMduPFZrJ0dfPxJFFD/fVh3qw9qNMfpLRWs6DvO7CHYvcq4TZZ4SJcyP1raLTAvH5hxYfzDnCEUPLoRjCwx4tG0JjxjhHEU24eGPYhJXfUZhOrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836605; c=relaxed/simple;
	bh=G2Fg0D8oE/Vf7CDjk6O7tHlWOoLEPrOOvpmf7d0Nu9g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VMcmCzZ/5QIWQi2TffddVj5Hj2HN+PO1ik3+iMyDMlQfiugWO6qdVmMhcIq3C9sRyxrpN5PcN/8TH4oAsu5p54oskth9h86csb6Qd6nfm3SHd8Ho0iWCaihoWcAhm0f+Bt3Sj59oiVC+wmKqaD+bF+cOsA+r47Qn/EyQtFifJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1x6xb2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382DFC4CEED;
	Tue,  2 Sep 2025 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756836604;
	bh=G2Fg0D8oE/Vf7CDjk6O7tHlWOoLEPrOOvpmf7d0Nu9g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=U1x6xb2X9OFMav2UKTzNN0yo9iE0Bsmu5l6CnzFus5X04+c0XGUBYz+Hfjdwx4POs
	 44XmAKa74122cdN50jLkZsv7uh3fWcpkucwPMh7yQqcmFEUOquwa6uMSkBkcQsi7ou
	 u+OcWSO/MfC8EYvDXrI62ycPlXTORmPrbB8NN+GwrVJy/W9lEWsYa5KTovJsnQfplX
	 uveiPI+D1SJF2EphOx7a/5IS4iuw0F/PGrgcenmcP1yEcJ1Byn7xPQaDcDnGGvF+MA
	 VtLKzbZDm6e84mVYhof4owThD1izEXXUm/t4GPgr0sBv7b7yu/ic1eyATPd8AEWqSF
	 bxon9jn4wOMLg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 20:09:54 +0200
Message-Id: <DCIILHRHQ2SP.3MYD6KEP72GV9@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250901202850.208116-1-dakr@kernel.org>
 <humoafx7njwhvdwarelew2bwyl34q3ls5vbrkj6psfukoroni5@z7ap6mc4lj3k>
 <DCII677CICRL.2OCMSV7ESGTQ5@kernel.org>
 <enuksb2qk5wyrilz3l2vnog45lghgmplrav5to6pd5k5owi36h@pxdq6y5dpgpt>
In-Reply-To: <enuksb2qk5wyrilz3l2vnog45lghgmplrav5to6pd5k5owi36h@pxdq6y5dpgpt>

On Tue Sep 2, 2025 at 7:57 PM CEST, Maxime Ripard wrote:
> On Tue, Sep 02, 2025 at 07:49:56PM +0200, Danilo Krummrich wrote:
>> On Tue Sep 2, 2025 at 7:40 PM CEST, Maxime Ripard wrote:
>> > Would it make sense to add the drm-misc maintainers as reviewers for t=
he
>> > bindings?
>>=20
>> This will get you all the driver patches in your inbox as well, maybe
>> discarding the following hunk is what we want instead?
>
> I guess we would receive just as many patches as we do today :)
>
>> 	@@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
>> 	 F:	Documentation/gpu/
>> 	 F:	drivers/gpu/drm/
>> 	 F:	drivers/gpu/vga/
>> 	-F:	rust/kernel/drm/
>> 	 F:	include/drm/drm
>> 	 F:	include/linux/vga*
>> 	 F:	include/uapi/drm/
>
> That's not really what I meant, what I meant was that rust/kernel/drm/
> is the only thing I'm really interested on, but we don't need to
> maintain it if it makes more sense to do so separately.

Yeah, the idea was to discard the hunk above and still keep rust/kernel/drm=
/ on
this new entry, so you get *only* that, but not all the driver patches.

As far as file maintainership is concerned, we have group maintainership on=
 the
commmon infrastructure anyways.

Your call, happy to add you as reviewers to the new entry too. :)

> BTW, we should probably add to drm-misc
>
> X: drivers/gpu/drm/nova

Makes sense.

> because we have a catch-all at the moment.
>
> Maxime


