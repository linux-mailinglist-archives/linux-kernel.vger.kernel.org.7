Return-Path: <linux-kernel+bounces-890762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D0C40DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F20854F7A29
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3E273D81;
	Fri,  7 Nov 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZuT0C31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640B247287
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532556; cv=none; b=mBlLeq/OB98GJ6mcqCIu/jnm+lLoZ+yZ8JKuIjIeCzWVg+5eWYjmu10AZtwHEgco2LIRuGmP1wWoz8XJqYN5/Vvp7pTtnEtbSn/0EijubNUR/HHap2DMKTqfzA2WyNQxzLm4f9W3NQzcRRzQQ8giEhqJJ3/S5qGxLiurdfdgBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532556; c=relaxed/simple;
	bh=mN4YUzu8lM3c3oVyGIeWOoW3AKov+Tq1pJETgzitr7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oxafukI4F3OnyGr0ClaebqWIIQMM8n5j8Y2D9dnLe1EAZZDggQvp1YvnIuVxPXysdcNkqrYYesnzY8nPv78mLLwAaQKnSvIKzAh1u5ornDHzVMTh2Tj2tORJ8INp3eVK+MlWu4fQk8XMsD2ZgpV0BNeLsdaBA91CimU/7NrOaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZuT0C31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6561C4CEF5;
	Fri,  7 Nov 2025 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762532556;
	bh=mN4YUzu8lM3c3oVyGIeWOoW3AKov+Tq1pJETgzitr7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GZuT0C31+QDQpp0rorfqPSiUK3Bx4b91ve41PHeDgnivD25omRRwmyd6aPRja4ZbQ
	 /to9fB8phW7MZ4f3A4InHqBCpwBRCQcEqcftAtJHHuMVD1x+48vTPCOsbuVL6TPIKC
	 5h9Nff8reoEXB0FvomgWz9I9SkReJS+NerutF7xo3cQza+0xJ6uuGdh7QiV6h+A+sH
	 pkppptHDUAQ87a9aAsW5koS3PVSKvk0l6YbyY94pO/rRG6EpKftLfjwO4n+q6t/BsT
	 xHOCRmmAh3uFCG1XUSr5OYdWKNZchCMBQXLyLDiSMXiqr8nA+G3veo4sKA+cFX9bK4
	 T2hLnqEYtfhVg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Takahiro Kuwano <tkuw584924@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 0/3] mtd: spi-nor: spansion: Add SMPT fixup for S25FS-S
In-Reply-To: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
	(Takahiro Kuwano's message of "Wed, 05 Nov 2025 16:47:57 +0900")
References: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
Date: Fri, 07 Nov 2025 17:22:33 +0100
Message-ID: <mafs04ir5bynq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Takahiro,

On Wed, Nov 05 2025, Takahiro Kuwano wrote:

> Suggest new series as the result of discussion in the thread:
> https://patchwork.ozlabs.org/project/linux-mtd/patch/20240914220859.128540-1-marek.vasut+renesas@mailbox.org/
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Checkpatch complains on all 3 patches:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Takahiro Kuwano <tkuw584924@gmail.com>' != 'Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>'

Take a look at why your git-send-email didn't add the extra "From:" in the patch?

For this patch series, is it okay if I change the author name to
Takahiro Kuwano <Takahiro.Kuwano@infineon.com> on all patches?

[...]

-- 
Regards,
Pratyush Yadav

