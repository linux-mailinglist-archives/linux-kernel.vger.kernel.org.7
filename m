Return-Path: <linux-kernel+bounces-748558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E5B142A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A77A5D72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD22222CB;
	Mon, 28 Jul 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra2Jz8h5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E51FC0E2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732420; cv=none; b=D2s6H0GoKl/tZU7QDlyCTWCfPWDZN/JrcHU3n2Ldl8eh06eSCOBAl4sexfgJ2rbvKeSq92wA595oOFZKKqwrHCclKUB8Mq9Rke7j7n3tLQgPCxX50vEwhoh2VVYgRksZpzyFvzcplbgEpYTwXNv8dPjfL5h2/zPy5AsxitWXdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732420; c=relaxed/simple;
	bh=iv7gVpQcHrEXtlmF36wPqtBB2W2XMVx0c4GQZtQzJPA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HEAx7hk5fTntIlzhF2ssGvYHCRYTsOtV/nBJgQ5hcodgGPkXrAdc4VJcrzyiQRw1GdEjaSJmANnQEA2d26Z6fuYZclfKZxOgRTTKMaz8658dSCA9quB3qy0A0LwrhBBx8p8dmKWDh6PuPwf0F59jl51t5L+ZkaIy3WU5/hJR5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra2Jz8h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D1AC4CEE7;
	Mon, 28 Jul 2025 19:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753732419;
	bh=iv7gVpQcHrEXtlmF36wPqtBB2W2XMVx0c4GQZtQzJPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ra2Jz8h5JHr2rL3+N1cnOSMvOsEy+v6yGFAZNbGtKzLr+QNexdKIYIRDV0eLPLFeB
	 ntadcDqbHe0xpCXBl5wRnSLyv9pfwqgOlSgDxle+q4Nn0vGC64cRQsHtHbMn7UXtwY
	 xqcSBYj6RJlLWeW11p8WJTyGFZEjvs9JuyrWjuDHT67tPaDz1HIFLk9hC35IG4qCEq
	 iTFehxS1UEue/TI9oCxjnSWLQ9u8PObhRq8cMrG+TG3bJShKfsJBOAt1DqjcyAox4R
	 hDB3Ahd01sdS/jFI6kbxVML2mWH77fcixf1IOsWFcT8YoNqyuk2/8K1wvTXOGoOzAc
	 fPxlcYbWkOBZw==
Date: Mon, 28 Jul 2025 14:53:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] drivers/gpu: Fix typos
Message-ID: <20250728195338.GA3244723@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Mvhc-w6nUi6WmpL3Czp+0kqsFaZa6bgVqodps=8F1t=A@mail.gmail.com>

On Mon, Jul 28, 2025 at 03:16:32PM -0400, Alex Deucher wrote:
> On Wed, Jul 23, 2025 at 4:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Fix typos, most reported by "codespell drivers/gpu".  Only touches
> > comments, no code changes.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Any chance you could split this up per driver?

Sure.  What's the appropriate granularity?  This?

  drivers/gpu/drm/amd
  drivers/gpu/drm/i915
  drivers/gpu/drm/nouveau
  drivers/gpu/drm/radeon
  drivers/gpu/drm/vmwgfx
  ...

Or I guess I could dig through MAINTAINERS and find the most-specific
entries?

What's your preferred base and timeline?  This was based on v6.16-rc1.
I can rebase to v6.17-rc1 and post early in the next cycle, or late
next cycle, or whatever you prefer.

Bjorn

