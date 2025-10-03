Return-Path: <linux-kernel+bounces-840923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8BCBB5BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF94C3C5D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71807278165;
	Fri,  3 Oct 2025 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwkrTOKw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA72773D1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454854; cv=none; b=bNtz4CmkTYf8qnjYlA9I7Yo2U6oJRWJviw6y1LaXl10XRm0HBSekGLksklEz8YeN1SuX1Z3rODHYAUbN+IlSuPvDZ+gVMfzAfsUzt+hW/EA62Wstjb85JkYDlG10dh86fu1UbJnFYedw0fP1zSzspAvZI+g9WhUHMu4NCq16vrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454854; c=relaxed/simple;
	bh=7VsGLTYzGHWM+abr1cFG7wV/s7mUQcTViJnAxj7363c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=inpAwngzJv6z3a3RqQM8GRUz+7R4Kniid8HsuX7ZfRK9/evp/pLqhTua1SjPDjUgzEco7bYEUyccyJT7p2ts4yqzi80CxofIBgA4LbPtd8gFPxdkfCMs/F3lOZAYINIwiqYL79pWPIKgsSIDOhUzGrrZg3IiZXjEsfzhOo4PnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwkrTOKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B4FC4CEF4;
	Fri,  3 Oct 2025 01:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759454854;
	bh=7VsGLTYzGHWM+abr1cFG7wV/s7mUQcTViJnAxj7363c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZwkrTOKw55Oiv0Pct7iJyoxUY+J+zrCh2ofOK23EiZP9OB4VM+9OkmTh3sFodue1k
	 rU2XIXgX+P8W6GDYh6FN/QRBgyAO9AzrBZ6QlQp0+Q78LiejQ5tdJRdhvyn7LFZU5h
	 NbQ2Xs6w9VttAhLQPlo/OuY9B7QThsqIVQMROWqgoii5YibKNsnC/N67JcBuyfk37s
	 Sy5L0O9sdBexVz5aYIUeZrmhmjEAWmoVIrKyPYFXO9zBwW9iPtlVpwxx66HdruSiBY
	 u6ddSMMJ7EVoQOa1a3qsWDO/0JziSWru6tw8pAEmiklQphxoHrCEQnbxAlnuvo7UzM
	 Ut4nkQ+PJxQ9A==
Message-ID: <cca96baf-6e97-473b-b77a-9ddc28060f4a@kernel.org>
Date: Fri, 3 Oct 2025 09:27:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: add missing dput() when printing the
 donation list
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20251002015645.3588322-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251002015645.3588322-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/10/2 09:56, Jaegeuk Kim via Linux-f2fs-devel wrote:
> We missed to call dput() on the grabbed dentry.
> 
> Fixes: f1a49c1b112b ("f2fs: show the list of donation files")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

