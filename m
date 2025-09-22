Return-Path: <linux-kernel+bounces-827529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4FB91FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBEB16A5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21202EA729;
	Mon, 22 Sep 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvLf5DtC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BCF2EA17A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555485; cv=none; b=X0vZr0k/N6RbP43NflivXHvMtIAKCBzxfBKZoCUV1kO6iismEz2CkaJ9Kt+1pwTTf6WY3UcSuCvgyO4fRRpgnklKy716AwyBkO08yCwijc+FGrGIBZtyiL4Ce+7w4j+5KwiRxMy+p2qbKTE7UlSgLtbxeuP/YUXToTskoYC8iyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555485; c=relaxed/simple;
	bh=6qXMFTjeenM7lbv9neNwIL/A85+7oDWHhK6UIL3O5/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz2j8u7pyjYgoWxBwJsqCNuK48gx+1nKUP024sqkcod4VLYxlbEZdmOpejFawD0rIlcGbLGfMNQpfQSLa9LAXhKEohZyQNsio7yBhxTuRY9wPxw22cwNY02zSN7vReuHk28l6SPEryfl9fkfT5IrjPVyv9bd3jV18KyC+5EJTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvLf5DtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF69FC4CEF0;
	Mon, 22 Sep 2025 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555484;
	bh=6qXMFTjeenM7lbv9neNwIL/A85+7oDWHhK6UIL3O5/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvLf5DtC7G5QoZpgM9NX7sEc2cL/taMUA3t9PSQN/f0raTGXV7Iv/q4gbtgEU0dQG
	 BHGn9Hq5vgQEQiyQcPkjVbAt+lGOso3D0OZwBoovE7p5JE0Yvkm8K6U1RA+luwWOSO
	 noXO/zkx9SOmLS+GWBneBl8w5ieJp6IghdDtvo8QDSkt8OVZ9nECLFTEL+Kbx2kOZC
	 iIZ99vJzhkVu7il+bYg9aE4tsMgvfgEjNXwiV/JPtED5OaAeeYVvkn1WTDr5vN9w/S
	 YhMdr3ZmvTAViMpuZCaMfYAoZWLXcMxiPGU0JlUGH5WvuCgTMGaIaLRcAOxdQ43WHs
	 oC4/k6RaeWdqA==
Date: Mon, 22 Sep 2025 05:38:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix texinfodocs warning for WQ_* flags
 reference
Message-ID: <aNFtWz8vi6aDtyZB@slm.duckdns.org>
References: <20250922122606.418533-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922122606.418533-1-kriish.sharma2006@gmail.com>

On Mon, Sep 22, 2025 at 12:26:06PM +0000, Kriish Sharma wrote:
> Sphinx emitted a warning during make texinfodocs:
> 
>   WARNING: Inline literal start-string without end-string.
> 
> This was caused by the trailing '*' in "%WQ_*" being parsed as
> reStructuredText markup in the kernel-doc comment.
> 
> Escape the '*' in the comment so that Sphinx treats it as a literal
> character, resolving the warning.
> 
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Applied to wq/for-6.18.

Thanks.

-- 
tejun

