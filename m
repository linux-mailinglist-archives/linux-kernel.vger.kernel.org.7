Return-Path: <linux-kernel+bounces-751421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC012B16973
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843A118C2FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243522424C;
	Wed, 30 Jul 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLERgBYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BC226CF7;
	Wed, 30 Jul 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919249; cv=none; b=cT1XkiobIcC2+XkhCCD5CeJf6o7VO/f2gw0+WpZCQNcv6//WD3vPmmtCk+Ko4aZonVGli2FcjarlpCRLBH+EwbQescUXO9UzRfxIyq64PYignqk8cZKu8f1cr//HApM/ADOC2Z/NFFVvJU51v/07e5VsHl1YKmAzL2z8Msate5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919249; c=relaxed/simple;
	bh=jkplsAJvrHZCm51qfVVagrWCEZfsD1vjjwDQnIJR5Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exr2l+zRe5f3GtGCGspOcQVejFORNd+Exu+mTKLhYu4ryxo7cvWukaviZ+Dmbz2iV/JHZ2Aw990Ns23JTT0TXqnMhVKude1jnLbmzo0M7StjnSYy9ks1a8hbU1xppGqStp+i65qxGTHv4MGY8H5b8Nq+ZlbmDG8WV0YDfIYPZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLERgBYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57710C4CEE3;
	Wed, 30 Jul 2025 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753919248;
	bh=jkplsAJvrHZCm51qfVVagrWCEZfsD1vjjwDQnIJR5Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLERgBYfXvr/7hwSRbc8ZGl4JG7Zxuavt2MdfyyqgKciQq4YZhKfymiETVMukL5l2
	 DSxv8oxegsEYYUayYbQxr3wLSHnzsLgBSv5R6n7QxNT9hmGXfz1aVOsjp3hYS2mL7C
	 UosYx+XsbJVPFIxvwILqWg1p/wFPrKaaEj9dOo+JBgiBvembZKlkxiuxObNGCpM4Ww
	 VBKD0TO5tVgeIbc+FvZNGh8Fbg6B9xERsCATgYjdxCBa43YyAMQZUTUnx3I2rHuJOy
	 PASylq5m63QmVCQNObNO/CBsf2yRkDCd7QehpXWNswYWr1Ct1yDN+x1/KhvQEBSPr2
	 70PibdNI1P0EA==
Date: Wed, 30 Jul 2025 19:47:26 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kevin Hilman <khilman@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 1/4] agents: add unified agent coding assistant
 configuration
Message-ID: <aIqvDjzAGgN3fITo@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-2-sashal@kernel.org>
 <7h1ppxcp0d.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7h1ppxcp0d.fsf@baylibre.com>

On Wed, Jul 30, 2025 at 03:06:26PM -0700, Kevin Hilman wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> Create a single source of truth for agent instructions in
>> Documentation/AI/main.md with symlinks for all major coding
>> agents:
>> - CLAUDE.md (Claude Code)
>> - .github/copilot-instructions.md (GitHub Copilot)
>> - .cursorrules (Cursor)
>> - .codeium/instructions.md (Codeium)
>> - .continue/context.md (Continue)
>> - .windsurfrules (Windsurf)
>> - .aider.conf.yml (Aider)
>
>This doesn't work for aider, probably because the .md it links to is not
>YAML.  When I start aider with this, I get:
>
>  aider: error: Couldn't parse config file: while scanning a simple key
>    in "/work/kernel/linux/.aider.conf.yml", line 3, column 1
>  could not find expected ':'
>    in "/work/kernel/linux/.aider.conf.yml", line 4, column 1

Thanks! I'll drop aider.

-- 
Thanks,
Sasha

