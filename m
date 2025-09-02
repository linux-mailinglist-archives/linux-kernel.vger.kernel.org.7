Return-Path: <linux-kernel+bounces-797147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFFB40C70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BAF200B25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83D307482;
	Tue,  2 Sep 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/wtsvXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891932F761;
	Tue,  2 Sep 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835400; cv=none; b=NA0Z0C0BXmgFyUIO1zKZan2bqjnhDuDzz0+bEL/5yhExuOsAtL58J7KQwhT7VUEI8VGctDNtXs3f2smNsswr1Q6+jeJ8jn3h920g0XxF9DjLW6G6GtHoccvbbTKwWJK2SBL48SvFbtA5Mt3WFZKHuh2TeS/eRZBZe/PxGudalm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835400; c=relaxed/simple;
	bh=dILSe0oG4b7dsyoFhCAS4TLkKoUcoG2soSMyV+7jgSI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=al3Omq84YSGobbVZ6H8H8MNbIGDOEht52LyrMMT+1sSguZ0FcFPx87zDVkUAAyspPtIv0Goi+Y9nzMqqWKU5H7bfJPZApS0Q72CPB8r5JrmbSEl2p3CsYdI7GYCFUzV0LqhRLH25IlHUxANUeIENYAmBc0qdSJXYYpGb5WR6gjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/wtsvXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF05C4CEED;
	Tue,  2 Sep 2025 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756835400;
	bh=dILSe0oG4b7dsyoFhCAS4TLkKoUcoG2soSMyV+7jgSI=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=T/wtsvXof13m40ZAKK1s6dMis9lttTpbbPrxxkiOTDm54FQXz1yNUG/jyYnthxjU3
	 qd3IwEJ90agvm9TfmOzHAkGGZerlaasbt9k9eTqWgB8+Q+jbqGvllpCu3u15WqS0n/
	 8o9WoWRP3tcGMnQVIobClGpB7pVphwwfcFgjw7e7thYcDIMelxlRvutkxuGK/ukBSQ
	 qFoRFe5xBLdNKN9RrKk7cyqmHyD4uoxW6mXAqOrxu2rUuepXxbWCe0eCKR2tEMOtia
	 vbmSZ0r3X/It/kFv8DtW1Itq5WcHWvcKLeiRWtRgJWPyl2bFxHE+UBPoCvEjzuQgwP
	 CbIPAfpUsUT7Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 19:49:56 +0200
Message-Id: <DCII677CICRL.2OCMSV7ESGTQ5@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>
References: <20250901202850.208116-1-dakr@kernel.org>
 <humoafx7njwhvdwarelew2bwyl34q3ls5vbrkj6psfukoroni5@z7ap6mc4lj3k>
In-Reply-To: <humoafx7njwhvdwarelew2bwyl34q3ls5vbrkj6psfukoroni5@z7ap6mc4lj3k>

On Tue Sep 2, 2025 at 7:40 PM CEST, Maxime Ripard wrote:
> On Mon, Sep 01, 2025 at 10:26:39PM +0200, Danilo Krummrich wrote:
>> Multiple DRM Rust drivers (e.g. nova-core, nova-drm, Tyr, rvkms) are in
>> development, with at least Nova and (soon) Tyr already upstream. Having =
a
>> shared tree will ease and accelerate development, since all drivers can
>> consume new infrastructure in the same release cycle.
>>=20
>> This includes infrastructure shared with other subsystem trees (e.g. Rus=
t
>> or driver-core). By consolidating in drm-rust, we avoid adding extra
>> burden to drm-misc maintainers, e.g. dealing with cross-tree topic
>> branches.
>>=20
>> The drm-misc tree is not a good fit for this stage of development, since
>> its documented scope is small drivers with occasional large series.
>>=20
>> Rust drivers in development upstream, however, regularly involve large
>> patch series, new infrastructure, and shared topic branches, which may
>> not align well with drm-misc at this stage.
>>=20
>> The drm-rust tree may not be a permanent solution. Once the core Rust,
>> DRM, and KMS infrastructure have stabilized, drivers and infrastructure
>> changes are expected to transition into drm-misc or standalone driver
>> trees respectively. Until then, drm-rust provides a dedicated place to
>> coordinate development without disrupting existing workflows too much.
>>=20
>> Cc: Alice Ryhl <aliceryhl@google.com>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  MAINTAINERS | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fe168477caa4..1cd6597c7f1d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
>>  F:	Documentation/gpu/
>>  F:	drivers/gpu/drm/
>>  F:	drivers/gpu/vga/
>> -F:	rust/kernel/drm/
>>  F:	include/drm/drm
>>  F:	include/linux/vga*
>>  F:	include/uapi/drm/
>> @@ -8096,6 +8095,16 @@ X:	drivers/gpu/drm/radeon/
>>  X:	drivers/gpu/drm/tegra/
>>  X:	drivers/gpu/drm/xe/
>> =20
>> +DRM DRIVERS AND COMMON INFRASTRUCTURE [RUST]
>> +M:	Danilo Krummrich <dakr@kernel.org>
>> +M:	Alice Ryhl <aliceryhl@google.com>
>> +S:	Supported
>> +W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-rust.html
>> +T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
>> +F:	drivers/gpu/drm/nova/
>> +F:	drivers/gpu/nova-core/
>> +F:	rust/kernel/drm/
>> +
>
> Would it make sense to add the drm-misc maintainers as reviewers for the
> bindings?

This will get you all the driver patches in your inbox as well, maybe
discarding the following hunk is what we want instead?

	@@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
	 F:	Documentation/gpu/
	 F:	drivers/gpu/drm/
	 F:	drivers/gpu/vga/
	-F:	rust/kernel/drm/
	 F:	include/drm/drm
	 F:	include/linux/vga*
	 F:	include/uapi/drm/

> Either way,
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
>
> Maxime

