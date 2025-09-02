Return-Path: <linux-kernel+bounces-797372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD79BB40F87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A92544E64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DDC35AAB0;
	Tue,  2 Sep 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfxI5OsW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B767E573;
	Tue,  2 Sep 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849041; cv=none; b=ZqAVN5u9XviMITwDXo9SrqbSiW+cG1R1+1HEvj2oD3bZZ7eYovpFHkVT693zZrcNK61CJ9BKe3Zk8t5Sx+U5MQVD+zywABW7PiuveOek+dbkZeF5xdTCRMvCgZbxpsvpr5h9gRHijggKDJix03iRu6vwREPQdYinguLtschk2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849041; c=relaxed/simple;
	bh=RVA8Zol8YLnsvT7j8Slk7mGfA8HvZ8cskcbwDsr+mU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd6TnYf4cHm9/UcbJdqJVMzFUwz7PU0eknjtHDE2ykZJIpRU/fC2WaaUeLRelrkHUtRlg53YpKmqcZSgRqlQQY6Em1TYZB3XgLRgKb33n4I6efBZWgTWFTB2WsTzx+ilnYJi+1G2vdR/4wbGXN5DUkwNRub1juPQH4wzh44854c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfxI5OsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F8CC4CEED;
	Tue,  2 Sep 2025 21:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756849040;
	bh=RVA8Zol8YLnsvT7j8Slk7mGfA8HvZ8cskcbwDsr+mU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfxI5OsWolGgWagxuL0U7GajhlBQOcB6r+/LAkAHK0YjmDFP0ZGt/Y9LiqDp+c1K+
	 KTUMF5BJUS3boQIuG4aGMsg9pTDMdAtErvIZhrWkuAcR4JPV3XMOATaxBSkLTkKYEk
	 ZKjhWhzRt4Jk7FjJU7zLhK5RrsCfuS5MpHhxmgrLk6W0mj6bjAwypjxQYeZzR9qJ65
	 qNE0wghwfYHzI9V0ZXVKl09VI6tZUWR8urtmSYuA68BozNlcrQGc8rV5QRaSuivI9l
	 nlBLYX0VHdPyFbIr1S72cKLZ11yA4b1ICFAjmMUp86d2tGPU08EqMTLWIY/7UGXiia
	 StkAK2B66LiLQ==
Date: Tue, 2 Sep 2025 16:37:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Masaharu Noguchi <nogunix@gmail.com>
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix typo 'Andorid' -> 'Android' in
 goldfish pipe binding
Message-ID: <175684894151.1209606.5416542002221924875.robh@kernel.org>
References: <20250901154812.570319-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901154812.570319-1-nogunix@gmail.com>


On Tue, 02 Sep 2025 00:48:12 +0900, Masaharu Noguchi wrote:
>  This patch fixes a small typo in the goldfish pipe binding documentation:
> 'Andorid' -> 'Android'.
> 
> Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
> ---
>  Documentation/devicetree/bindings/goldfish/pipe.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, but really we don't want any fixes for .txt bindings. Convert 
them to schema instead. I wonder if some of these goldfish bindings are 
obsolete...


