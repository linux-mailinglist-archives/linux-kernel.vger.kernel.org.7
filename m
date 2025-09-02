Return-Path: <linux-kernel+bounces-795523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C8B3F3D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CB917F5AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDAE2D594E;
	Tue,  2 Sep 2025 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dIYO+Gc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822A253359
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788589; cv=none; b=M0f5yQ5gwxYfwi2V3SnrqoTC4HyygCO8MFU/8acRxqog7jOv3JPShCUrDxoxrluktCYA2EOdGQ+dHMPqlrOL36xO4Zliv8tnz7h3nXBBqgZF2k3v6A8eKsVkn8PAp4QoKm/+b7B32VcwyITNRK+E/7DFP+qfZvNvEpVedFlfGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788589; c=relaxed/simple;
	bh=JdbI9aDNXEDZVPGEZv+pByx8hHx3yUXm3BlvcdFBDRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNOr93N3qQm4SDy2qddz1HzKUtPfe/tPsGlCVOn5BlJ0QicCgbAA0z90LZ40Lub1MxL7Gdb+Hy5pzo762BfkUIlCUelVcVyM3QcUYIRITBNZ+OLfvH31EGp0WQKIv4Xb4+S+po2Dat1RZM2QHsJRmqjohAJBbXJ2/O3KMQF/Nu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dIYO+Gc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1542C4CEED;
	Tue,  2 Sep 2025 04:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756788589;
	bh=JdbI9aDNXEDZVPGEZv+pByx8hHx3yUXm3BlvcdFBDRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIYO+Gc4sWILncYjnQ/1DCT2h85291mceZrPlzocTzq0jfv34Fi2hmVV/iff7XBoM
	 yJh7zg09yyPsW92viukWPRMfcxlWS1tQVHvdCIfTxZv7XUeN7KQs8/mX8QIQoPTIv+
	 in+AytZ1YGT7A3w7OUaohdtEsbf3jLnQZ9O1ym0o=
Date: Tue, 2 Sep 2025 06:49:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandr Shabelnikov <mistermidi@gmail.com>
Cc: o-takashi@sakamocchi.jp, linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: bound traversal stack in
 read_config_rom()
Message-ID: <2025090237-undocked-reopen-7ce6@gregkh>
References: <20250901171547.47065-1-mistermidi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901171547.47065-1-mistermidi@gmail.com>

On Mon, Sep 01, 2025 at 07:15:47PM +0200, Aleksandr Shabelnikov wrote:
> read_config_rom() walks Configuration ROM directories using an explicit
> stack but pushes new entries without a bound check:
> 
>     stack[sp++] = i + rom[i];
> 
> A malicious or malformed Configuration ROM can construct in-range cyclic
> directory references so that the traversal keeps enqueueing, growing the
> stack past its allocated depth. rom[] and stack[] are allocated adjacent
> in a single kmalloc() block, so this leads to a heap out-of-bounds write.
> 
> Add a hard bound check before every push. While this does not itself
> implement cycle detection, it prevents memory corruption and limits the
> impact to a clean failure (-EOVERFLOW).
> 
> Reported-by: Aleksandr Shabelnikov <mistermidi@gmail.com>
> Suggested-by: Aleksandr Shabelnikov <mistermidi@gmail.com>
> 
> Signed-off-by: Aleksandr Shabelnikov <mistermidi@gmail.com>

Nit, you only need the last one "reported-by" and "suggested-by" don't
mean anything when it is you as the author and signed-off-by line :)

thanks,

greg k-h

