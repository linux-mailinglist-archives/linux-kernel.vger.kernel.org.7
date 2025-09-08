Return-Path: <linux-kernel+bounces-806035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C33B49118
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07061B23DCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20D3305073;
	Mon,  8 Sep 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iubh/eA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13A1A2387;
	Mon,  8 Sep 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341146; cv=none; b=k6QAJVR1F4pURbayuZr04R9C5C5JbW2eawSWsxPJ2H2ygZc7VfGu2J2DJC2mvo2SCWift9LSoZxI/+VnivPwZY7iC8ujIgcMAh/zoDi4YnQ0EB8B4J/96O+H7fw0Nz4fSxVmRh+S4so3MLrbluainASdmI+XkOKboZ+mDL6aD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341146; c=relaxed/simple;
	bh=yiJn6yvEIzXcaVGJDrahppkN2NuhubqGe8lDQpynQCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwMFNqJLiK/72nWUguHe3+mn6pkiKOpmSvfLx3AuUnQ9PtGeM8GbBX6MuFDM7H3CDYHS/ypIYqtJ8h/ZeXMhawAyFHnZNW+fV57ozPGxmS5mj6hEVHbkpbbqci5XIL32sOjgoqPbWC18QAOAeOxZHeOLL5SXOAR7wDp2uq5sPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iubh/eA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEA8C4CEF1;
	Mon,  8 Sep 2025 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757341145;
	bh=yiJn6yvEIzXcaVGJDrahppkN2NuhubqGe8lDQpynQCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iubh/eA1nyg+Vit19I/0vMWi+wjsMmtMa/qL9jI6QjHzaoAuTHU3LiSSGvHn6ktvR
	 t9upV2MtJmetCjNvpwCFVrewdRWDQA8fieLrAGQaFcmEaFA1DEBR8S1VGMftYIjgZH
	 QPl/FB2GkpUT3OELCHZ/GL1s72wb49qgXR8KeinGluMaoKjq3KSkQGYqYovQnwhygD
	 JBKZNB/0Zp7v/pw9uQHdv+atGXR/v/PcadSA0QRKk5q70+9qUT2yEQ8plupNlMoJFK
	 QnZYC5Wk+Lz3oGhZAoH+CpbDZAIsMkgFkAuDNDcB40X8smUjSPuy73rRMAklqv7wxb
	 tzefnLAttKAJw==
Date: Mon, 8 Sep 2025 15:19:00 +0100
From: Will Deacon <will@kernel.org>
To: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Sebastian Ene <sebastianene@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] KVM: arm64: ptdump: Don't test PTE_VALID alongside
 other attributes
Message-ID: <aL7l1NImpMfwTVfu@willie-the-truck>
References: <20250809135356.1003520-1-r09922117@csie.ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809135356.1003520-1-r09922117@csie.ntu.edu.tw>

On Sat, Aug 09, 2025 at 09:53:56PM +0800, Wei-Lin Chang wrote:
> The attribute masks and test values in the ptdump code are meant for
> individual attributes, however for stage-2 ptdump we included PTE_VALID
> while testing for R, W, X, and AF. This led to some confusion and the
> flipped output for the executable attribute.
> 
> Remove PTE_VALID from all attribute masks and values so that each test
> matches only the relevant bits.
> 
> Additionally, the executable attribute printing is updated to align with
> stage-1 ptdump, printing "NX" for non-executable regions and "x " for
> executable ones.
> 
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Sebastian Ene <sebastianene@google.com>
> Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> ---
> Tested on QEMU.
> 
> Changes in v2, thanks to those listed in the Suggested-by tags:
>   - remove PTE_VALID from .mask and .val
>   - make executable attribute output format identical to stage-1 ptdump
>   - Link to v1: https://lore.kernel.org/kvmarm/20250802104021.3076621-1-r09922117@csie.ntu.edu.tw/
> ---
>  arch/arm64/kvm/ptdump.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

I assume Oliver or Marc will pick this up via the kvmarm tree.

Cheers,

Will

