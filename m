Return-Path: <linux-kernel+bounces-858290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3FBE9B14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A631189F0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F974335070;
	Fri, 17 Oct 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx8+0FZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE27332ECA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714202; cv=none; b=YktNkxcD25z27n7Dolcb7+EGUK43rUaWD7jsDxfnS0Ny5CQAr7sPJOQjSQoCUVtlwSnNfiDQ960BdSsP2YBxxPcUn4E+elBc9eCuxmBm7aJMSTHuB+HEJ6SKyTYngMABn+mNUIZ8EnnlNI88FOLQ0Q3S9lcxo/0yw1YlkU7+2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714202; c=relaxed/simple;
	bh=BrsRDjcmoWCSQvpw1Aps90xkpDYir/1QNNyQGvoUQzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5McfqlJQPE8+M+Y0jzQhfD2RxySHKtXSJ7X2DpNIYwVHSKDsR69kKvdbKj3giZdW/NO6LB7QvNls55SK++gEhJxvxDmj5WrNckaMHp8f8McWvBn85FdfNajzChD4tg7u8/WDRnUcYEnAH3Adcq7pqoWTzEXnI6oVGyaEysUay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx8+0FZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939E5C4CEF9;
	Fri, 17 Oct 2025 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760714201;
	bh=BrsRDjcmoWCSQvpw1Aps90xkpDYir/1QNNyQGvoUQzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sx8+0FZzzCu1IKlxJg2GUrZjXtDFxXlz3BSD87Xznon2tpXl+vhate7L4AHBLgtJr
	 sn88ilitiGDJocFb5MOMCnyJW5ipYANdaAXMLtELewLyDt4nLqpoz+0M5aXU58wSuk
	 C+XofRMUBOFKYSqDqSDP65578rWJy4Renr0gAhMjPLuxnpLKLKkQEAwnp/yByhadXx
	 6SF5FcikdV212pdhwqoroKU69NT1M3OQQpc54TSxcVDEDTvt47PGMPEQF8ukVGGvv9
	 Akk5xLZZVA1jFZ3YsdQDI9LOkoM48hsr/azoog9mkC5f0Yb7pAJFtJXmuEnndUuEoR
	 WH7UNqwNu4JdQ==
Date: Fri, 17 Oct 2025 05:16:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Support RT workqueue
Message-ID: <aPJd2PggjJwMUs4Q@slm.duckdns.org>
References: <aPEQAqGOWOzzZl4Y@slm.duckdns.org>
 <20251017091041.3026848-1-jackzxcui1989@163.com>
 <aPJdrqSiuijOcaPE@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJdrqSiuijOcaPE@slm.duckdns.org>

On Fri, Oct 17, 2025 at 05:15:58AM -1000, Tejun Heo wrote:
> There are a couple reasons why I don't think we don't want to go this way:

Sorry about the double negative. Drop one of them.

Thanks.

-- 
tejun

