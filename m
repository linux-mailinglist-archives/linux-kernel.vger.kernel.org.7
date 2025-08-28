Return-Path: <linux-kernel+bounces-790377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE6B3A643
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417347B3BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C2322C60;
	Thu, 28 Aug 2025 16:29:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF630DD30
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398563; cv=none; b=XlO+S2n0Sri6Hi3ig+6LuD4twBQq3A8n8EcCpi6T5Z1i1AJFuEEF91J7ADKwyiax8FxEvRYC1ti3bxwx0OpJH56CFGtCI+Ej+GiFzg4heJpUftJC8m+yngJoIe6ILgCDSSvsEemGfNDx2AFzOSq7cWJ0SAGnecQvO9wvDxuWYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398563; c=relaxed/simple;
	bh=zMmrkFBMly2o0U/nRsUJWAEgWjMcra8WH7lN3+9c1t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urAuh1ZXoRON61UQY6E80PPA+HJ7BqAf6alYYQMqT9hPkff0ODBdCpBx7oMloCoTpY2FKuRipMn7j0XvdJZsDltE7J70OS0TM4e5yuP/Pzqb0JOYQN0bVmufjIfEkIT4v45xCIGdzaEsehxkfqJ8MSHvWlYUj1tiQ+7zq8/MX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC55C4CEEB;
	Thu, 28 Aug 2025 16:29:21 +0000 (UTC)
Date: Thu, 28 Aug 2025 17:29:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
	dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 2/4] arm64: cpufeature: add AmpereOne to BBML2
 allow list
Message-ID: <aLCD35VIvfJ8UeSA@arm.com>
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805081350.3854670-3-ryan.roberts@arm.com>

On Tue, Aug 05, 2025 at 09:13:47AM +0100, Ryan Roberts wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
> 
> AmpereOne supports BBML2 without conflict abort, add to the allow list.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

