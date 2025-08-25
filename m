Return-Path: <linux-kernel+bounces-784763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CADB340C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBFD1706CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE7727380A;
	Mon, 25 Aug 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2RrX9yL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702A1A83FB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128731; cv=none; b=F8i1QA079iHmnuULkdp6GJeJvf1NaYosRCfl1dVjDxCRmKU2G5NcKkfVqmpDAOmswlm4K2nO6qEEIEHknR5AnUmtYMu/WAvRWNJZisaAZ08X7CLG/br1yQB76salIjYNpa+v7phxJBsvB6jurgeGZzgN8gPTcOciIxZhogbYwII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128731; c=relaxed/simple;
	bh=jqq45E3cx3rUgAVpwRx7RAAXFOhHUbO3uAuW67XvdVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDCQjMD7NatcDdGrIUr44NIMrLLjYH1MEUZePXY9J7AWpj4nUeZxisteLpe839ocjBIdcUhNUNoYq+dkeucYutkJ3EuReXf48cIp8HGQV3y964bFzXbuLWDM8HwcSlRPmjPMtl8lmGkxZt++rOKSlDbYwX/jhd0Un4KYG62gFJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2RrX9yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E758EC4CEED;
	Mon, 25 Aug 2025 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128731;
	bh=jqq45E3cx3rUgAVpwRx7RAAXFOhHUbO3uAuW67XvdVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2RrX9yLPYWt/6DJVKLYiwNS0CihvUQIZejVeQcxvR3jxo7+GHDdlJpxIMRkGmrQL
	 hFVTe86jVKtgVtrymzKjDHUFEQXms6zVScoMf49JSSljf7Rg45zMJcHTdrdHUpUr+F
	 6n2NQc+MNcs/mSwsN4I0E1Ao7M8zJpnCj6JsLAhVLBD9KqWT6zfEZ5IV0epxQz53Xz
	 EfvUBFE8vGmwRhrKh17VEFwywUOAjW4S6t0P9XxW49EoxcVa33bBQJUbY8a2QvqK+r
	 fSbllZMgDFd48F1XnHcL9jhalhRJsCGuUP1KR1+J3mPo1OzSrfTIGDWwXK52djdFCp
	 DF8jeuNXWB3+Q==
From: Kees Cook <kees@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: fortify: Fix potential NULL dereference on kmalloc failure
Date: Mon, 25 Aug 2025 06:32:08 -0700
Message-Id: <175612872734.1493840.9696239897709581215.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814060605.5264-1-junjie.cao@intel.com>
References: <20250814060605.5264-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 14:06:05 +0800, Junjie Cao wrote:
> Add missing NULL pointer checks after kmalloc() calls in
> lkdtm_FORTIFY_STR_MEMBER() and lkdtm_FORTIFY_MEM_MEMBER() functions.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] lkdtm: fortify: Fix potential NULL dereference on kmalloc failure
      https://git.kernel.org/kees/c/a3db14be3e90

Take care,

-- 
Kees Cook


