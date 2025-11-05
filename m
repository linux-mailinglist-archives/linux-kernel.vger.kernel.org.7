Return-Path: <linux-kernel+bounces-886181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738BC34EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16008189DA44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A390E1EA7FF;
	Wed,  5 Nov 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPcNwgIi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039573009C7;
	Wed,  5 Nov 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335868; cv=none; b=juW2BG/cecPrBnHyX6CjIqbBJ1JenR2YS5H4vM8MuSYrtpGkJDkJmURQo9OPjo6JOjUw/WHrk/L+2Un3qfOzL9q/AOha+cCJZx/28NOLmd36iDN9WUm6kt4ob/CBS8BZ6A20Vvxb5vzfJElg1fFlg3Rj7L35ammbw9pM1CZssIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335868; c=relaxed/simple;
	bh=f3wFnyn7p1ibiWpNXb4gDEfB5F9l6iHTRscnD2GSoXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PbLLuCWeDCWabPZcbzQDuIJBCOZX1qWVXdDghfj+cpraHpplytWcyW7YAhaGjAhsIa3dAN2m0NbAsEoQCmqt1VIYP8eKkSW/oEqFWdWcAxQyHxPXhK3wJr3Pe1VcNeD5NawgjIlTNAh4vtslamFFc7CTe0AgN1nmPW0v+jpMgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPcNwgIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12BFC4CEF8;
	Wed,  5 Nov 2025 09:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762335867;
	bh=f3wFnyn7p1ibiWpNXb4gDEfB5F9l6iHTRscnD2GSoXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sPcNwgIiiVHovHHsqHZmZAIiEIWadNXqW6T9n9yqfpChf6SOVyUkgo7HYHSyxc5XK
	 e8HkW+LZT1vumMdFE2XHx4eJi+BZFM855xUeVfMIKfHpIc83km7fyBsVz2TOBVYHiU
	 4tofgurwBmk0+3xxiVWrfFQoNDTXYvV7C3I9vz3zMGgssfMUSs0cHKyVNJ4NaUV3cy
	 8sb1DJJ0IPdIe4cAgKNPLsqczRGm0rkgm71t3HnD61LO2UVbqDnbJiPvMmoxkVuX4H
	 YUMH208nwqYPuo6tSUy3abEdcIFsQUbEFUzzJgT2EPKTPqvJrRxVahDt6HK2xoFWiW
	 p1TJe/OZD4NzA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Changyuan Lyu <changyuanl@google.com>,  Jonathan Corbet <corbet@lwn.net>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  kernel-janitors@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: extend file entry in KHO to include
 subdirectories
In-Reply-To: <20251104143238.119803-1-lukas.bulwahn@redhat.com> (Lukas
	Bulwahn's message of "Tue, 4 Nov 2025 15:32:38 +0100")
References: <20251104143238.119803-1-lukas.bulwahn@redhat.com>
Date: Wed, 05 Nov 2025 10:44:24 +0100
Message-ID: <mafs0y0okbypz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 04 2025, Lukas Bulwahn wrote:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 3498209ff64e ("Documentation: add documentation for KHO") adds the
> file entry for 'Documentation/core-api/kho/*'. The asterisk in the end
> means that all files in kho are included, but not files in its
> subdirectories below.
> Hence, the files under Documentation/core-api/kho/bindings/ are not
> considered part of KHO, and get_maintainers.pl does not necessarily add the
> KHO maintainers to the recipients of patches to those files. Probably, this
> is not intended, though, and it was simply an oversight of the detailed
> semantics of such file entries.
>
> Make the file entry to include the subdirectories of
> Documentation/core-api/kho/.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

