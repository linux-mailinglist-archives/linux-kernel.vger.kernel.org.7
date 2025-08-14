Return-Path: <linux-kernel+bounces-769595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F0B270C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228D51BC6159
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC831277C8B;
	Thu, 14 Aug 2025 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXaYUGrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F609274FC1;
	Thu, 14 Aug 2025 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206588; cv=none; b=aqo2dykRD0XwMSZKmJwWDO/50D2NKImXYUMwViGLlTBIGZDRoCf/8NlhLMegmGp3rS3FReqXFCkx5hF2eb1C7bYYj/hWi2KMB/t8o31bZNEQ1zfUC6Vcp/E4xMCVRxJZGPdtYYdvk8fOYVjxlnWWUKHs4q13O+dBu8IGve6D5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206588; c=relaxed/simple;
	bh=/YAyEnoGHWHrKqtA+8YNSP65tR8gj7nVsgFL4uhZG1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8Clk8vHplH9n445gPADWq7Szg5C1nUwxoramqbGEcObXSWZkHctvt8MUZTY3Gi2SyEIJIqwB52Bexz6YxWqfcBRTqi54d9HXc8DdmPdfh2aXb36Jt/Tf2wDS76YkxYDSQpo3uW2JyGO3RwAf7fAgTqDuYgC6e2PlL3tovNX0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXaYUGrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF232C4CEED;
	Thu, 14 Aug 2025 21:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755206588;
	bh=/YAyEnoGHWHrKqtA+8YNSP65tR8gj7nVsgFL4uhZG1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXaYUGrz7ZUTKUBbTqVxRaieG799w5nY2hwtnP+l2RGjKaUmH0q04jxrSMfRIS6hG
	 AY08D8WVyH9aGfZWyYiz79Htg9JIbfVbklXRpWVgn/JEOzynqt1xxwVjVe2ENVUNiL
	 PJx+nYzgZFYRjQeFTypcMPiw2zwc5tnz4+SE6ZM+eS/Vox91y/1RBoUZiwsNW94OBd
	 VycoZeecS7nkl/1eRj0BOCrNUI+JOhZvREIFe+byExgnG1f2LoFOTnQD8hN5Nepl4L
	 mttJuYcXQl8SCYVzK3vnD82sDCc3nk/O2VcEhvSol+MvC0pu5GYAJg9Cy2cEdT5wJI
	 hLYDsLbStOVIA==
Date: Thu, 14 Aug 2025 14:23:07 -0700
From: Kees Cook <kees@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Jonathan Corbet <corbet@lwn.net>, security@kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] Documentation: smooth the text flow in the security
 bug reporting process
Message-ID: <202508141423.55DECF0601@keescook>
References: <20250814192730.19252-1-w@1wt.eu>
 <20250814192730.19252-2-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814192730.19252-2-w@1wt.eu>

On Thu, Aug 14, 2025 at 09:27:30PM +0200, Willy Tarreau wrote:
> The text was presenting the team, the the e-mail address, then some of
> the expectations, then what form of e-mail is expected. By switching
> the e-mail paragraph two paragraphs later and dropping the "Contact"
> sub-section, we can have a more natural flow that presents the team,
> then its expectation, then how to best contribute, then where to send.
> 
> And more importantly, it increases the chances that reporters have read
> the prerequisites before finding the e-mail address.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

