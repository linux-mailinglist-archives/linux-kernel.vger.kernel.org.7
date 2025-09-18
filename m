Return-Path: <linux-kernel+bounces-808128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE884B4FA0C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB1674E2CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7220733472E;
	Tue,  9 Sep 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuzrSo2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9825257829;
	Tue,  9 Sep 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420041; cv=none; b=Nkq8/L+ZqScZGINtyxzyGTg3KP1kXmA0tLeM0YnUbpRAhC/rFVORNFatzxFua5nGaCUHd5iwrkA+IWijT77QgJFZxWdq5Rreevys9dfP7cp9leywnDFykec+hjIxNsCEGOrQWMAR7gGp/bKPGonLFlbUE0S0qsxGrJdXuj6JrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420041; c=relaxed/simple;
	bh=tMruF9j+G2L1N4zuR4KW/thijoi3DgRD3fEIsvtunMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcel+fWKGyLEj9r0S5xh1xd9KzoM+d0GlME+5Pf9P2cEI71S2IgfOQVGsiHBhtMaLl16W1W6RppW+kl0YVoKWM8H8I1/o/eX9qFrTvPLthFveOB/ajIeyhzcIArMG8IoZjZYO7PwbE+XCdIgGn5Ryn3TsXhdRWbUBH5lIVeujKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuzrSo2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F938C4CEF4;
	Tue,  9 Sep 2025 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757420041;
	bh=tMruF9j+G2L1N4zuR4KW/thijoi3DgRD3fEIsvtunMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CuzrSo2wC8/+3xPSVkuL28/fLvs9z4VJpLDFlrUXZ9QxiUGZDvez1QEhrB8XqYimj
	 fKwvYQVXCm9wRitIRSPiL/qlnuM7XUwUnU4c/0qtwyqJOfv2HKela5PjaLj6vZQ9NO
	 iAFuNP2nZ+O8FTxe3FH2XmZGMJED34JrwSPdAMQDeQ6/Lil+VBaI8Bd9U44Pkysx+A
	 Ib6wrhmrBV1nEtPBDWRL8WlJP18Z4x0QyfHsHTEvgiQgITLatG+f31/iTaMSKMOluJ
	 KF+40oysRCqEyp2iNF1E4WvSlF21xGRkW/L7Rm0ZCdf1+vBw7KShria3xnXpbaPKz+
	 ki1J91Mqyr//w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  <kexec@lists.infradead.org>,  <linux-mm@kvack.org>,
  <linux-efi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <nh-open-source@amazon.com>
Subject: Re: [PATCH v3 1/2] kexec: introduce is_kho_boot()
In-Reply-To: <7dc6674a76bf6e68cca0222ccff32427699cc02e.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
	<7dc6674a76bf6e68cca0222ccff32427699cc02e.1755721529.git.epetron@amazon.de>
Date: Tue, 09 Sep 2025 14:13:58 +0200
Message-ID: <mafs0wm67lt6h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 21 2025, Evangelos Petrongonas wrote:

> During early initialisation, after a kexec, other components, like EFI
> need to know if a KHO enabled kexec is performed. The `kho_is_enabled`
> function is not enough as in the early stages, it only reflects
> whether the cmdline has KHO enabled, not if an actual KHO FDT exists.
>
> Extend the KHO API with `is_kho_boot()` to provide a way for components
> to check if a KHO enabled kexec is performed.

Neat! I have always found doing if (kho_get_fdt()) a bit awkward.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

