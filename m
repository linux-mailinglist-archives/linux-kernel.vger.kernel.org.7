Return-Path: <linux-kernel+bounces-735612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C422B0918E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440F14E0FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFE2FA64A;
	Thu, 17 Jul 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WyRmi23Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC4C2C9;
	Thu, 17 Jul 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769103; cv=none; b=KM76sGsRCSGYtuHxzm7Yqo1YDB9LhYD90xlmilBgwXa65Z9SG+9hCO1OIf5DfQT4qk6Xq7fCPobF6aAl8XJwL8qcsh5/NLaKvb4LPfXAmKjgESmD8NTlWAg41W8uQsc1x6Jo45rxxNzAkh7aPE3KzpYczhiThCT/FWG0bvH7Vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769103; c=relaxed/simple;
	bh=2mONxxf4bZlpqNMEIRVWPmmLAYBJE6GT8WdPlxpmbJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxcxeSJg31AKzsimM5h3bCS4ZhngM84PumJxu5vSAjgreUb/fjWtIRQSSfdYaDcxu39+HdS0rIXRmrrRFLhh6IQciovKyZt7u7A72XAx4nhq/g+82ISA+ySbGjIrRaf5HBd0JiDVww34/iQ2wTgAQoVLun4eFjkYhIG7O33wRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WyRmi23Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CCDC4CEE3;
	Thu, 17 Jul 2025 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752769102;
	bh=2mONxxf4bZlpqNMEIRVWPmmLAYBJE6GT8WdPlxpmbJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyRmi23YeuEt+JrDn/vsgS0tQxYmNHp17/MWjSVEkfnO2aSevSQE4wbb9uj1QBsLw
	 CTUiPdUsMwDXme55oNwINIl6kZ4pCZS9ADa01vY7lMBozxRFYboaQYgf7e0tVzjlQL
	 pyWC/t0fM9L5/Kd1mFvPo8B/niogJZwr2SYEw0rk=
Date: Thu, 17 Jul 2025 18:18:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] usb: vhci-hcd: Fix space, brace, alignment and line
 length issues
Message-ID: <2025071706-overarch-flaky-035b@gregkh>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-2-2b000cd05952@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-2-2b000cd05952@collabora.com>

On Thu, Jul 17, 2025 at 06:54:51PM +0300, Cristian Ciocaltea wrote:
> Perform a first round of coding style cleanup:
> 
> * Add new lines after several statement blocks
> * Avoid line wrapping when 100-column width is not exceeded and it helps
>   improve code readability
> * Ensure lines do not end with '('
> * Drop superfluous spaces or empty lines
> * Add spaces where necessary, e.g. around operators
> * Add braces for single if-statements when at least one branch of the
>   conditional requires them
> 
> This helps getting rid of the following checkpatch complaints:
> 
>   CHECK: Lines should not end with a '('
>   CHECK: braces {} should be used on all arms of this statement
>   CHECK: Unbalanced braces around else statement
>   CHECK: Blank lines aren't necessary before a close brace '}'
>   CHECK: Unnecessary parentheses around
>   CHECK: Alignment should match open parenthesis
>   CHECK: No space is necessary after a cast
>   CHECK: spaces preferred around that '-' (ctx:VxV)
>   CHECK: spaces preferred around that '+' (ctx:VxV)
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Coding style cleanups need to be "one patch per logical change", not
"fix them all in one patch!" type of thing.

Sorry, but can you break this out better?

thanks,

greg k-h

