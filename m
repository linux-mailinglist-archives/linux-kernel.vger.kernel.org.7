Return-Path: <linux-kernel+bounces-747373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D4B13317
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A647188923F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5361F2B8D;
	Mon, 28 Jul 2025 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyd0E5b4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B62111A8;
	Mon, 28 Jul 2025 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753670439; cv=none; b=AVVy8IKBdj5TboLID0KkbyVEAs6D6pVv9bMZJsSeRRORjIKNnDGFsZkcHqrtjSrTFhJTBvom8N8bpNkMIkRk/6Q3bAzYFBtIqAsreslg9su6uDhuL3HYcj/mfoTvFJuff1AeShLjv+zvx9VzB2Pgbv3veasUyZQd1Vk347ixA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753670439; c=relaxed/simple;
	bh=i6+ML5W5kVTFWibxcd3Cgc9dad/0Q1oDR4om9+5KkAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESBQeRPwEBRIcK+ojdkAi7ZGdBCwkJVmneVneMKuSiZ/mHLwDXZ78LjFtmbG9JkTNejw+2LPAJ/3oUqkXOIWSQ4MQORswLiFHk9VtInbT0+H8lkQtcLbLLKkr+YBi9yJJTpspBB+okewLby3Aw6N9YLk1/EC1FeLaFfB2BaVndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wyd0E5b4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1207C4CEEB;
	Mon, 28 Jul 2025 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753670436;
	bh=i6+ML5W5kVTFWibxcd3Cgc9dad/0Q1oDR4om9+5KkAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wyd0E5b43yvCrBytp8SZkndpkUriwWz2/CC13eBLrd1dwO4Oa0BuPH7gOWQkqlOBd
	 F4ZiUsOiII4FUNaQhtcQxEQ+8QPoz7+jRLxYO0U8BY5qOI9YoWHBwjEVqVZGW1b4Ly
	 a/moaTBIjJ9DsUJcPknt5+7W/hvKOlDOiIuSMn/jDcOcwTF4HcoXTLf212Fh4pm4+g
	 fJJ52jlHifhiZ3iIpAohQ0TPznarr9Ej67SJ48e+So0hfgCOhyhD/jDWuRW/HRB+Am
	 mJ6KTT6t5t5B9WvhWnS/nzCx39etfj9Udwv5eI+Ncxl/zcucgy7Dv9AFfMa33jPsf+
	 wksNYJEfY+UzA==
Date: Sun, 27 Jul 2025 19:40:36 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 3/4] agents: add coding style documentation and rules
Message-ID: <202507271939.D78EC559@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727195802.2222764-4-sashal@kernel.org>

On Sun, Jul 27, 2025 at 03:58:01PM -0400, Sasha Levin wrote:
> +++ b/Documentation/agents/coding-style.rst

All of this is redundant.

> +**No trailing whitespaces**
> +  Never leave whitespace at the end of lines. Git will warn about patches that introduce trailing whitespace.

If this isn't covered elsewhere in Documentation/, it should be. :)
Also, "all files end with a newline"

> +**80 character line limit**
> +  The preferred limit on the length of a single line is 80 columns. Statements longer than 80 columns should be broken into sensible chunks, unless exceeding 80 columns significantly increases readability and does not hide information.

And this is why redundancy is bad: our line limit is 100, not 80.

-- 
Kees Cook

