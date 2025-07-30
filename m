Return-Path: <linux-kernel+bounces-750942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD92B16319
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B31E1AA3A72
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E12D9EE4;
	Wed, 30 Jul 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjxGXWJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9A1A5B92;
	Wed, 30 Jul 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886892; cv=none; b=bXmoarP+o6eKmo1K/PoCx2W03fLij9POTr0kjn6He0HMZeQ5JKJVS9L+JLXOMImagbX0o95q3hpSiS0OLdXCeWCAxTeJLo6AGGvt+lY83dvU6zik0hKPfl6B2hmxubB1FnIoOQVIX95ro1zyvkqXQyX9DM72aM57W+Kep2bdCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886892; c=relaxed/simple;
	bh=/SjoFkfipdmgynoG35oex7cC6gjWWw2A9RkPHcYCH+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kus2Ed0tqDAW5F6fOeKjpk8SJ7bqPIFZ5WV9XMiQ1ET0Km14/55rpUpOr+OShpLUUcUdxrnWKt0CRpqg46iwtBdOmdOmPfmozFXF3687MhfMw3QNOzzPR4NnnIJHz5aFZsbTqLIXSj2CxCzZlBHJIgmvyEEA4yAGJNp3t3YZGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjxGXWJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9282C4CEE3;
	Wed, 30 Jul 2025 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753886892;
	bh=/SjoFkfipdmgynoG35oex7cC6gjWWw2A9RkPHcYCH+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QjxGXWJM9NN5QcBd8jOToTN/R6LqYbAkmYRKhQF2cgKcPaqLVn5M0+VwVCGKbGtHD
	 bakM7Y1FcwmQe2IpbAGQ9gM2Y3yp7HaEJR+jyOkA0orizUT1otpLtYtq2xZ6wrY6lc
	 uiNQjiEAOijCAB1EgTruk0alAk+aRm6gklfk+SFwh8NIIPEfeEN7F50QbPzMY2c/ir
	 azu98xWuX2IkKWcQH1SAucDx5gQU03lkxepwXMB6THaXIE9TmENnza3Gh7UibqUBhr
	 hfbUBJjIw0kqlmXqpA+34BdKHlowpD3bAnbLNHCO4J35Q8xFjaqVtSQCmTls5dbvUf
	 PqXAk25EZgNtw==
Date: Wed, 30 Jul 2025 07:48:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 3/4] agents: add coding style documentation and rules
Message-ID: <20250730074810.01903973@kernel.org>
In-Reply-To: <6a2312d3-286e-49f2-aedf-b0e41b48ba14@kernel.org>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<20250727195802.2222764-4-sashal@kernel.org>
	<202507271939.D78EC559@keescook>
	<aIcGQR8tjmjr8dlb@lappy>
	<202507272219.4BF02B6@keescook>
	<aIcSu3LidOqoaVOS@lappy>
	<6a2312d3-286e-49f2-aedf-b0e41b48ba14@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 11:31:35 +0200 Krzysztof Kozlowski wrote:
> I pop up there a lot, but there is no confusion. I am (and maybe we are
> all?) well aware that checkpatch hard limit is 100 as explained also here:
> https://lore.kernel.org/all/df2e466a-cdaa-4263-ae16-7bf56c0edf21@kernel.org/
> 
> But the coding style still says that preferred length limit is 80.
> Checkpatch is not a coding style. Coding style document is describing
> the coding style...
> 
> People trust checkpatch way too much, thus its hard limit was raised.
> Some maintainers also agree with that, yet it does not invalidate what
> coding style document says.

Hear, hear!

