Return-Path: <linux-kernel+bounces-774308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD319B2B107
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505EE7AD0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F32737EF;
	Mon, 18 Aug 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmjKFCdx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F8273D8C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543508; cv=none; b=VwWBk44xM1SKQkeQnFTPfvnRy4Aitcbmoqx6TbCgenB+CRXi2gyuiUz5A+dSsqcB72kb3npjhWpf1FL+Z9PdHrWJVXvTtTnib/RXCSNrLPOGK2oOsCSfINjRgflzvXwMOT0Me71wTJ0puwiikWkcmEi49vHeivj1sN0by4aVQMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543508; c=relaxed/simple;
	bh=MPaIFepjtKBrXc6mf7qbOE8EkzC+VzXEcskg14nM3Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6piT2sasmX4xLF36TLTscCP+eVT8KZz1RQ8KpEiOr6R2l1KRIP9ZzVjDllmEpJwhpAUFJi/nkb6zWL2KVWZPCTVqd4+NOHdNQaBj4kNBzzYkFE0C7Iab4fKfCqIJFzLuUnG9pLBgpMr5QnFsCL3i6Cw4NGa7GRpqAtWmRtCfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmjKFCdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A74BC4CEEB;
	Mon, 18 Aug 2025 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755543507;
	bh=MPaIFepjtKBrXc6mf7qbOE8EkzC+VzXEcskg14nM3Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmjKFCdx9HlvrOsi89BI1UyUSpDJ8INJ1uewRBINLS50kXwyxt+HsVgCPWri6mdHe
	 f+54Wuq2j2q6HbBTRhmNbMnkllqX74QUBCEaZpcbcKuWOMeXsnBlfPgbnT46YWnmAw
	 K394B3fN4SHNRRaKkY6g28wKrK04Gb6yHpoOddSHRrb7Wy3tz0KRGTMDuXKZ2UC6TR
	 L6un5qNJI+0B6UPw/pi4Gh588lKO9WtPqp5McI2whIWTAmdbmKK9RiWvzapuHjdaaT
	 b6DvrhG9JYEf3VSZiit0iUzUkuMvfHSnr6dvJqyleszeJMXIRJI9cig8SFZi0p71Q4
	 jb/hkRggNiU2Q==
Date: Mon, 18 Aug 2025 12:58:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
Message-ID: <aKN30RVeM3p5NJm1@kbusch-mbp>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
 <aKCFjzai3Y0RcGHP@kbusch-mbp>
 <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>

On Sat, Aug 16, 2025 at 04:11:00PM +0200, Diederik de Haas wrote:
> On Sat Aug 16, 2025 at 3:20 PM CEST, Keith Busch wrote:
> 
> > If you want to see what the driver is reacting to, you can check the
> > subnqn from command line:
> >
> >   # nvme id-ctrl /dev/nvme0 | grep subnqn
> >
> > It'll probably be all zeros. The field has been required by spec, but
> > the driver tolerates ones that don't implement it.
> 
> root@nanopi-r5s:~# nvme id-ctrl /dev/nvme0 | grep subnqn
> subnqn    :
> 
> So it seems to be just empty?

They, it's interpreted as a string. All 0's would be an empty string.
 
> > It's just a message that the device isn't spec compliant, but
> > otherwise perfectly operational.
> 
> But still worthy of a warning (instead of info) msg?
> 
> The other kernel warning is this:
> 
>   nvme nvme0: using unchecked data buffer
> 
> The SUBNQN message appears every time, this one appears often, but not
> always.

That one means you've sent a user space passthrough command to a device
that doesn't support SGL DMA. Without that, the nvme protocol uses
implicitly sized DMA that the driver can't be sure is accurate. The user
could theoretically provide a short buffer that can corrupt memory if
done by accident, or be used as an attack vector if done by malicious
software.

This is also not something to worry about unless you run malicious or
buggy software.
 
> When researching this/these issues, I discovered the nvme-cli package
> (with the nvme command) and via its manpage I found this command:
> 
>   nvme get-feature /dev/nvme0 -f 3
> 
> I didn't even know NVMe's had namespaces, but this didn't look good:
> 
>   The namespace or the format of that namespace is invalid(0x200b)
> 
> ... without actually understanding what it means and/or what its
> consequences are. It could be harmless and/or normal though.

The feature you're requesting is the LBA range, which is namespace
scoped. You need to specify a namespace id, either by opening the
namespace's block device (/dev/nvme0n1) instead of the admin handle
(/dev/nvme0), or you can manually specify the namespace with paramters
"--namespace-id=1" or just "-n1".

