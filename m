Return-Path: <linux-kernel+bounces-870621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E10CC0B4C7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91853B822C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB592F83BC;
	Sun, 26 Oct 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jd2Vc9iC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12E2DA760;
	Sun, 26 Oct 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761515076; cv=none; b=VFSHOgG+pBwn3Tm/H88vFHL8hf3RQNqVdDNfbo4Y8+L0kq3GKDZc0BhPelc5Y9rjrhOwuV8G8fkaMUQMLSNz4hdiJL1aGLefZ6uETahMNVIkLeRdel9Mo/z0tlSn40mv2k9Bc4x3/ToIySYRb8XBAHDT3T9DYcDcxJEATXCkhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761515076; c=relaxed/simple;
	bh=vXbSbnOjYRZqzne9Rsm7iv5shX4kPK2FDFgOzWLRR9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omXS8AH/jS5voWCVxpKYjFJ5iqAivEpaePCRoyR7+kOxG1eDGCpA2wBv23VossUX2jO0RqJkhn/y6j7xuTd5FgLJMzohCNp3AX52UFO8ZAqnzh+tVJGSydcmpkwkFnrDYjrpwURyPjAmp21aNqt5ipMCx/mTjgRDtGqpUBRHrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jd2Vc9iC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=AisfXWItUiP+YCt6QRi/uofiXwhLt5T+U2Q8Ip1ol8Q=; b=jd2Vc9iCUYPARRnVvYGMuyJHUG
	Rm98d1vW1kME7anCxQ1VGQlyMLsfMicrlFq17Ts+UOBH2tlBeSiJGIZiN5LFBjoWfsiuuYTHJzJCs
	b4ImDKBPCJ33TO02d1b4yQo6f9AggzKiKcRoUNmSbCjq7jjLfx4ZDNiNB6vWw1wSwSoPgREHuQkWD
	YwgY55q91aFrpsaGaxeHqc4GKoVHpJOEl1soKjMD7ibL4qa8RIsT+936ekjxLaPCTRQbFw6ln3EMF
	3Jw+HYTCh0AjXjbgq44hOKdD4kopIpAEGdIGBjmGWu5cydr0iRFtSiox5ZvfU5Dd021mcyvmtHmD+
	mRjjL1yQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vD8XR-0000000CmMx-0zxN;
	Sun, 26 Oct 2025 21:44:33 +0000
Message-ID: <bfb5a59b-40de-4d24-b49d-4683b40e5395@infradead.org>
Date: Sun, 26 Oct 2025 14:44:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Collect documentation-related tools under
 /tools/docs
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>
References: <20251024200834.20644-1-corbet@lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251024200834.20644-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/25 1:08 PM, Jonathan Corbet wrote:
> The big elephant lurking in this small room is the home for Python modules;
> I left them under scripts/lib, but that is an even less appropriate place
> than it was before.  I would propose either tools/python or lib/python;
> thoughts on that matter welcome.

I agree with Jani-- not lib/.
if that helps.

-- 
~Randy


