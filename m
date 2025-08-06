Return-Path: <linux-kernel+bounces-757853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837A6B1C76E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B40C17F3F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1028CF70;
	Wed,  6 Aug 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1fGSZkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F628D823;
	Wed,  6 Aug 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489581; cv=none; b=P5M7d5wjeqJpviUVaSVg2LDFr29yR7ni8F0bOgPa6Ub7lsRcP8d2zj+JOlwSH15YozZ5T1qiV7jPDLFKOTIyedZAtneSC+YBonSX5uHjyanY6Uk2ppOV/+zUQjudcP/6e1a1VgCSwt29LtDeExEJeVe3LU7FBPyF6LZ49jq7MbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489581; c=relaxed/simple;
	bh=8MVy6EylKNibNveZN4B5Hj6JDT+ojFqfW1JhErGuHZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9LaKOrvJkdUb/R5EJddvUNAcBgK0+pqNhYv9lgbfCNqqhJ4A27Dcu0bZCATVO3OgUIiA6ZhxRmFJui2NH5CDJ1WLxypYEtfUWTmrpLbJ2eHS51yXW8IYzcZXFjJyxC29eFTQHsBKKlXDcllJJmLP7Af5rwwq5bSR6PtJybn1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w1fGSZkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901CAC4CEED;
	Wed,  6 Aug 2025 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754489580;
	bh=8MVy6EylKNibNveZN4B5Hj6JDT+ojFqfW1JhErGuHZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w1fGSZkXqkwAcXnMRt6k9AhE3oKMp38J7v+GiP9Pme/bvynHtUDGOIAsulZzZW5K/
	 s4xXZR1UbVLV98HQKKr/N9MKiF7Wsqtau+9efDoP2Uy4pFkeRhxAUmchYWlovav/Zz
	 LL0IIaD7mOJr3A1Umpuh/7F5CE+SKzhTNrmg2Wrk=
Date: Wed, 6 Aug 2025 10:12:59 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
	josh@joshtriplett.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	rostedt@goodmis.org
Subject: Re: [PATCH 4/4] agents: add legal requirements and agent attribution
 guidelines
Message-ID: <20250806-impetuous-rainbow-octopus-2dcaab@lemur>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250727195802.2222764-5-sashal@kernel.org>

On Sun, Jul 27, 2025 at 03:58:02PM -0400, Sasha Levin wrote:
> +- ``Co-developed-by: Claude claude-3-opus-20240229``
> +- ``Co-developed-by: GitHub-Copilot GPT-4 v1.0.0``
> +- ``Co-developed-by: Cursor gpt-4-turbo-2024-04-09``

FYI, this will break tools that expect Co-developed-by: to be in the address
header format. I will add exceptions in b4, but it *is* going to be annoying
that this trailer can be in both formats and I expect other tooling will also
have similar problems.

If it's not too late, I recommend picking a wholly new trailer instead of
overloading Co-developed-by. Examples:

    | Assisted-by: Claude claude-3-opus-20240229
    | Auxiliary-tooling: GitHub-Copilot GPT-4 v1.0.0

I like the latter, because this also allows listing multiple tools.

-K

