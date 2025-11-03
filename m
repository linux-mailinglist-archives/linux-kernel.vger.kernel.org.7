Return-Path: <linux-kernel+bounces-882151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B3C29C24
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9006F3AC69C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF7F2652A6;
	Mon,  3 Nov 2025 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NMP2C1gC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454C469D;
	Mon,  3 Nov 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131971; cv=none; b=C8rCIlX2YsWMVgxIZw7aCF6mEo7I1CpLs5rGBlbcQSwDiwlDZXN8EnlFFYDg9If8KMpcm/1nm+7StMuHPLM64B0uF1X1kbxi4SxCjEPAAsqep6Gnw/f+3QKCkJIBrHZuyQf+3FQB6TPLLbUlYsbfHXOSRB3xuirVLAtEwMJdr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131971; c=relaxed/simple;
	bh=pq9XYg7ZzklhQuFvWF8rStUN/jnF9XAaSO0rWhh/SH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiHWJ1xA3BDGK8oL9SAzQmHcfQCX7bpeHKE+lbIDHqV51HLgnLmN4x/Lnvdi4nb9WX1DpmD/rv7KqG9IYlmYauzwmdFlM+kTompZ3DGTzIfovV3ldsBs8zZB9zyO2bn8aylnqK/FKSTL0SfJwr25a0/Bm9Jyiq1qC3czYDdPs2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NMP2C1gC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75347C4CEF7;
	Mon,  3 Nov 2025 01:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131970;
	bh=pq9XYg7ZzklhQuFvWF8rStUN/jnF9XAaSO0rWhh/SH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMP2C1gCMFDnWrBng+EJyj8LSpUNopkvjo1NS68jhWKfWQENYxgP+PAR36nVmSyL0
	 ReOvE4R8phSp6P7XMCQFoPwvbJyYYWZhESnPwUUz1+hPjNP/mp/dQyufaf4+j9P2Rc
	 2WfRt/rPShxfpuPhG7fdIW4pmvT8tpBsl4HUR2FE=
Date: Mon, 3 Nov 2025 10:06:08 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] misc: rp1: Fix a reference leak
Message-ID: <2025110353-whoops-concert-5d18@gregkh>
References: <8f55f8866a6680830c9d318201a29293ac50a591.1761334487.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f55f8866a6680830c9d318201a29293ac50a591.1761334487.git.christophe.jaillet@wanadoo.fr>

On Fri, Oct 24, 2025 at 09:36:11PM +0200, Christophe JAILLET wrote:
> The reference taken by of_find_node_by_name() in the probe is not released
> in the remove function.
> 
> In order to avoid a reference leak, use cleanup.h to automatically
> release the reference at the end of the probe when it is not needed
> anymore.
> 
> In order to do so, a reference also needs to be taken when DT is not used.
> 
> This simplifies the error handling path and makes direct returns possible
> in several places.
> 
> While at it, also add a missing \n at the end of an error message.

This means this should be 2 different patches :)

thanks,

greg k-h

