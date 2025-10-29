Return-Path: <linux-kernel+bounces-875312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BFC18AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BD604F47D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC903128A6;
	Wed, 29 Oct 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmMDe7Go"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A56221FBB;
	Wed, 29 Oct 2025 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722329; cv=none; b=Rz+pYFTbjsZ0dZgmqiZnnZtvWLltNr372X/OcPMgZ223Od975+/ab71JsXyOzBchBnmGM0wxmgvcScSx1IIXJxsPVnapKxNGJjpPxY9K9/FCLzXWEdmkfk2hMd08h098ZkrIr9NzNvQdR2beZ7exCurzCWyM23fAMVJuI+JdKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722329; c=relaxed/simple;
	bh=FJSeg9NWSrXlgJg/dtFtHD0kQGEHqs6tkqE4WKN1qhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uiDnbr5UX3Db/VaC6ZbVETiKLnofCeiI7VYHq14Dk3nulq0MudsEFWKOtCD43BcVN1qtwY+IGzR06DcxuoClJnjHDZoVckzlF7IUkPmcmccQ7AA67lp9GAoD4JfOaHiPEBI59cNeM7FKIO8bSuP0SUqlygf4Ynm9jQhrCYQE244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmMDe7Go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B01C4CEF7;
	Wed, 29 Oct 2025 07:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761722327;
	bh=FJSeg9NWSrXlgJg/dtFtHD0kQGEHqs6tkqE4WKN1qhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YmMDe7GoTsFnhLY3ZArePhLORRu4cw8jbvcKEmnQu1p+/jDKAGuaWMAuv6kd/AOf9
	 AzrYLx+iMEIzVHKn0LT8Ln0TvQEtc1ruawfnEV30s+WHPfHkCUkj4YpvrgCMn5zxx5
	 n22Ibdej6s0VuKWlR08WiztjGsqIMs3eRQLSiVlWG9414iwOsIoIXGdXqilDvE/b2C
	 WU7cLtd+QSgxDt13y9OvfuvIkhuG65QNrd0IIF75MQrnY8v1qiWyScaf9cdtWi0BvW
	 y6TPxPbv2zCpZNVRIYxywh/6utXxPxFROrFELIrE5WPsFhLB6jp1Ci2RRlo+CM7mws
	 zBxCbw9qf8kRA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, leitao@debian.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/2] configfs: Constify some fileds in struct
 config_item_type
In-Reply-To: <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
References: <UMPsw5UqjtBaIrv5LPKiow0sOdVevbuvSx39jhXV_gtjHReEeeqGpgijGJj5OoJjMJA3mDIeSyzR9lffgIOr6g==@protonmail.internalid>
 <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
Date: Wed, 29 Oct 2025 08:18:34 +0100
Message-ID: <87sef2fa5x.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Christophe JAILLET" <christophe.jaillet@wanadoo.fr> writes:

> These 2 patches constify ct_item_ops and ct_group_ops in struct
> config_item_type.
>
> When/if they are applied, I'll send some patchess in each subsystem to
> constify the corresponding structures.
>
> This 2 steps approach is IMHO easier way to make these changes.
> This avoids long series and cover-letter/first patches sent to many
> maintainers and lists.
>
> However, if you prefer things to be done in the same serie, I can do
> that as well.

Looks good to me. Please also include a patch to fix up the rust
bindings in the 2nd step:

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 318a2f073d1c7..468c8c4170d5e 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -755,8 +755,8 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
                         ct_owner: owner.as_ptr(),
-                        ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr().cast_mut(),
-                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
+                        ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr(),
+                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
                         ct_bin_attrs: core::ptr::null_mut(),
                     }),
@@ -773,7 +773,7 @@ pub const fn new<const N: usize>(
                     item_type: Opaque::new(bindings::config_item_type {
                         ct_owner: owner.as_ptr(),
                         ct_group_ops: core::ptr::null_mut(),
-                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
+                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
                         ct_bin_attrs: core::ptr::null_mut(),
                     }),



Best regards,
Andreas Hindborg



