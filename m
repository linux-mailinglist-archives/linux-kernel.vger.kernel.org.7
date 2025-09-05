Return-Path: <linux-kernel+bounces-802302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC4B450C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245901C865D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01072FD7A5;
	Fri,  5 Sep 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPP79ayH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD62FA0F5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059262; cv=none; b=GJIbRy0IZcDPh7ER6AaoaIevwVg0psxz647z9m20N8HWXdHzrqhCEynCM/pjHWmjV6/FGTSfyqIFj344DACXjjCymQ04KlUTgaKTwg9Q31nju1Zl5/0RU6qCcWBsbvN1MmtIIB+P35WVxK6JUU6vfCRZj+FmyM3Nf2xVIRipCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059262; c=relaxed/simple;
	bh=x1Sq0Ob26LdMRXj2JcZzPqzEsUDByjP1rR4VD9pX0ik=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V9Pcive/LDyMcFXxMnn9d8WN5pHHZkoEYKCt8W6TQJJ/SFzv/sWJP951pcKArXLTB1GTtnJXC7chMhAY5uuEK0U2jdEyNvd9OSLEHHwQ+D8A1PGxwC6Tr82p1qJf1SVoq9WMkSt8DswgtmGETOUV08hcDXPJ1xv6IaSEy8x1RJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPP79ayH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F11C4CEF1;
	Fri,  5 Sep 2025 08:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757059260;
	bh=x1Sq0Ob26LdMRXj2JcZzPqzEsUDByjP1rR4VD9pX0ik=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GPP79ayHyRytP94uYTcubBpluRkKQUd/kFRKLbktf+irCrguiYt6YT1MQGDdrHuWU
	 iyyE3CQzBXA1xv7QZVsDgZO7tCTsiLjqlyJSb8dUvsoBGPnERTwOOmlJLS/iGPcbzw
	 dersXA01LxWmW7aJrIBhy0grs9P9AiV2upnUAE4+PkICgZRLqz4bdU4igOIuj9tQsU
	 c4WrqN/YWLw9gUJB+Te0h+tXe8CxnfOz/0x5aCKEQ9wshZPMn+g2bQ1AppNvzrQT7b
	 tXkfachKLDHsdmyA1OukVohLjDeKYj1aPIXKFLv29PqTHshi7VYDTtLqxWp+IeJKWL
	 OM2H3e28rW4kA==
Message-ID: <b8fd703c-f320-45c2-bd2c-d5ff5ca637ad@kernel.org>
Date: Fri, 5 Sep 2025 16:00:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: merge FUA command with the existing
 writes
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250904181642.3879283-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250904181642.3879283-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/2025 2:16 AM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> FUA writes can be merged to the existing write IOs.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

