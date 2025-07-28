Return-Path: <linux-kernel+bounces-747375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86095B1331B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5C5188D387
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660F1F5847;
	Mon, 28 Jul 2025 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeWcY8GD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC328F1;
	Mon, 28 Jul 2025 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753670613; cv=none; b=stNwvWxrjkavE3mzIFi3/ES3yV1bqD79z0vcGeQQc96VmHvbQwAGkW6rBOLZGFpVkGtMs8MelAEz9CJsZmIzAUlWEv41o3KQPKgt1ZFdrsplx0L0dsCrmngxiNl7+NKZkKfaRApMTUkUXvb6nuLJ4wT1YTvF17VVMoECvoCbbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753670613; c=relaxed/simple;
	bh=wPCRh84URnm5Khcxtue6Vk8f5gPlQczxtLDvFPHTc/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/ZCcL3eUAdlWemBhXFYmUP1/Fvi+cFwm5E158fOR73wy0k9FMhpM57iBGZZjemtPcRxnyhAFCaw8DwmAwcZrZ1MKMFTurSQaZSBoLqzAQ450V8LuK43Z7c5Srvk15QykZrgYAUTtPm0eKJCiPIEAbYArdoRg7/XWGv/n6enAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeWcY8GD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB648C4CEEB;
	Mon, 28 Jul 2025 02:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753670612;
	bh=wPCRh84URnm5Khcxtue6Vk8f5gPlQczxtLDvFPHTc/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AeWcY8GDtJTZhYHHIrXEkxdKxxEsoBtzTlm7rtyjwLQNMGcTzxI3pd0dN29AEEb/k
	 9JX5YXI5GESib8miDB+hDeQ9gst/sqg29/0FmCZGeL/VnM/SiAl+LzDMnqKTZY4Tks
	 0uKGQU45GlHOeXSNJQDTDfPjDgKQDWY76XTejc976pPjza9V2l+Ponn+PUyMoCXUbp
	 wQzEG6mrtHh2PMEQJmzita/Z24Q4sBiNkkl6aCyvhPSeAZf9Q78L4DXQov/waQHVIT
	 7L8BmJkdmI/2kZj2If8XZbv04UzjBufVQ2ZdhiE6a4EaJtSU94vVOGZnFZrOJJkMn4
	 3RfjJmaiOUEmQ==
Date: Sun, 27 Jul 2025 19:43:32 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 4/4] agents: add legal requirements and agent attribution
 guidelines
Message-ID: <202507271940.F70685B2A9@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727195802.2222764-5-sashal@kernel.org>

On Sun, Jul 27, 2025 at 03:58:02PM -0400, Sasha Levin wrote:
> +Licensing Requirements
> +----------------------
> +
> +**GPL-2.0 License**
> +  The Linux kernel is licensed under GPL-2.0 only with a syscall exception. Coding agents MUST follow this licensing rule with no exceptions. Any code contributed must be compatible with this license.
> +
> +**SPDX License Identifiers**
> +  All files must have proper SPDX license identifiers. For most kernel source files, this should be the first line of the file in the appropriate comment format:
> +
> +  - For C source/header files: ``// SPDX-License-Identifier: GPL-2.0``
> +  - For scripts: ``# SPDX-License-Identifier: GPL-2.0``
> +  - For documentation: ``.. SPDX-License-Identifier: GPL-2.0``

Again, all of this is redundant. And if the SPDX stuff *isn't*
redundant, it needs to be listed somewhere else for humans.

> +Signed-off-by Restriction
> +-------------------------
> +
> +Coding assistants **MUST NOT** add a ``Signed-off-by`` tag pointing to themselves. The ``Signed-off-by`` tag represents a legal certification by a human developer that they have the right to submit the code under the open source license.
> +
> +Only the human user running the coding assistant should add their ``Signed-off-by`` tag to commits. The agent's contribution is acknowledged through the ``Co-developed-by`` tag as described below.

This is unique to Agents. Yes, this is fine.

> +Agent Attribution Requirement
> +-----------------------------
> +
> +When creating commits, coding agents **MUST** identify themselves by including the following tag in the commit message::
> +
> +    Co-developed-by: $AGENT_NAME $AGENT_MODEL $AGENT_VERSION
> +
> +Examples:
> +
> +- ``Co-developed-by: Claude claude-3-opus-20240229``
> +- ``Co-developed-by: GitHub-Copilot GPT-4 v1.0.0``
> +- ``Co-developed-by: Cursor gpt-4-turbo-2024-04-09``
> +
> +This transparency helps maintainers and reviewers understand that a coding agent was involved in the development process.

This is fine too.

But like I said before, you must update checkpatch.pl to not complain
about Co-developed-by missing S-o-b when C-d-b lacks email address,
and it should be part of this series.

-Kees

-- 
Kees Cook

