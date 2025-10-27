Return-Path: <linux-kernel+bounces-870922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBDDC0BFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878583B876B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1942BE7D2;
	Mon, 27 Oct 2025 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nfd413Fe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7221CC44;
	Mon, 27 Oct 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547517; cv=none; b=eBZtoWjopEdEfowAI4Vrltuv+k1L6ZzXlvtPXRsTY7XDAN9WDDEuHPnAK4uynqMpzuB+Wxl341tJtSfkk96YGMe0wav45Bp+6DaTjDOgomarZcUh/cx9WHGjWeVZAAuotynPtang5sxzyauGQV7kKg4ih1nECjyjpgyIleoymwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547517; c=relaxed/simple;
	bh=OzLMeTaq+DRNfW8WOBypVoKSFC/FRHIk1riY1tSJOuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFoFJk9isJekyNDIjRVYtuc/v+bFACCLO4gzDqBRL5W725PlAmL4YzNL2Vj0ndTMzeoO9LH/eZEMeLN4jHKKkf9O98TQ2L2oTR1teoZh+H0seUlIq3gwm+A53dZX1AzeTlM8mpvh0lJYiPsVRyuMYJLQ4XrV2WpNd80gwbFOpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nfd413Fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2A3C4CEF1;
	Mon, 27 Oct 2025 06:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761547517;
	bh=OzLMeTaq+DRNfW8WOBypVoKSFC/FRHIk1riY1tSJOuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfd413FeFBKRmS17CZB1DqcUhVPeC+IOZj4PW7XCOl1e55iLmz6MqOZQWYYeVLnNn
	 z1/QKFSBL+X+88h3+xjeOsCdrfEqOhx9JHupOK7rvLBlwo6U0XGY6QY/DBRABFfJg+
	 SOZcHmzAgi5ByzVMtlLTFV0zB7MAZfya8ChVL3VU=
Date: Mon, 27 Oct 2025 07:45:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heyi Guo <guoheyi@linux.alibaba.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: Why hasn't the patch "r8152: Fix a deadlock by doubly PM resume"
 back ported to stable branches?
Message-ID: <2025102742-mumbling-starlit-c651@gregkh>
References: <5e065a78-b371-4ef7-8ce6-a902f80e2b02@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e065a78-b371-4ef7-8ce6-a902f80e2b02@linux.alibaba.com>

On Mon, Oct 27, 2025 at 02:04:09PM +0800, Heyi Guo wrote:
> Hi all,
> 
> We found that below bug fix patch had not been back ported to stable
> branches, like linux-5.10.y. Is there any special reason?
> 
> commit 776ac63a986d211286230c4fd70f85390eabedcd
> Author:     Takashi Iwai <tiwai@suse.de>
> AuthorDate: Wed Jul 14 19:00:22 2021 +0200
> Commit:     David S. Miller <davem@davemloft.net>
> CommitDate: Wed Jul 14 14:57:55 2021 -0700
> 
>     r8152: Fix a deadlock by doubly PM resume
> 
>     r8152 driver sets up the MAC address at reset-resume, while
>     rtl8152_set_mac_address() has the temporary autopm get/put. This may
>     lead to a deadlock as the PM lock has been already taken for the
>     execution of the runtime PM callback.
> 
>     This patch adds the workaround to avoid the superfluous autpm when
>     called from rtl8152_reset_resume().
> 
>     Link: https://bugzilla.suse.com/show_bug.cgi?id=1186194
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: David S. Miller <davem@davemloft.net>

Because it was not marked to be backported at all.  If you feel it
should be, please send a tested version to stable@vger.kernel.org for
inclusion.

thanks,

greg k-h

