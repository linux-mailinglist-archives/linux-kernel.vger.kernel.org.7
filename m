Return-Path: <linux-kernel+bounces-755376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6BB1A5A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10DF620A98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFDA19ABC3;
	Mon,  4 Aug 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJPF9qoH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A131FDD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320593; cv=none; b=G6oZ+L/b0knDHmVAsWfReIfKTOKAHUWuchWxNSulKcFpTReCk5uH/sjcQCK0DDZhYtr7ph7bOKGkUFvFVoywDRWEDGms6Nj9wrYjdFCCXez/5xZMatWXn4oymtHRLHnY4quywp2mqvqItGdqVkPkovddrifeXI1M6wJuXN0ZooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320593; c=relaxed/simple;
	bh=b1eLgh7yG4oMhzhvJuweuxrjqjtqiYIHIQQU+AnX09M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9C8PM0lh9FODx82fMLcsBMSBXc/rZBR947VR6Zk75kJYpKup2AvcN1Qhi+xaY0Y4HHuMAk0+U1lfM2vhzTHpiG3k9t2UG4RvKMxrTmE2msVcw7rrjDbWLWHbok15rrQ36MsMxAqBIcTx3sogEk6FJjPm32tnqHf30T73Q41LSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJPF9qoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9703C4CEE7;
	Mon,  4 Aug 2025 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754320592;
	bh=b1eLgh7yG4oMhzhvJuweuxrjqjtqiYIHIQQU+AnX09M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJPF9qoHMciO8J+woCu5kQC/XU2/L0sXv4oXO0o2gv4j+l8oJTZqfdYqwo76XwGhL
	 ubM4ydhODKhBsGVcvuJWx9lPLyvx/mmfpaNiB3XVjWhEvZnpqGHUnIVvGIpeX/KCpc
	 lByJSWA07tze2ckaSOBdwG/QLSp4653dZMz1MDrtzGZY3PotzsESF+M6Ons2IjUGNx
	 NcEPR8nfHWLCg5dO4LcHrp15Xi00fokWmVIR63Bny2h3ndjvmE9UdR+iL6xahkcYfZ
	 NaMPXz5d7JHK6S/ynZbe7EYCC3/vlK5xIR4V3JBR4t4ZPvzUugp8SJrHRJXWfouWdC
	 kTFE/opuVTJ1A==
Date: Mon, 4 Aug 2025 08:16:32 -0700
From: Kees Cook <kees@kernel.org>
To: Yin Fengwei <nh26223@aliyun.com>
Cc: Ismael Luceno <ismael@iodev.co.uk>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	zhourundong.zrd@linux.alibaba.com
Subject: Re: [PATCH] binfmt_elf: remove the 4k limitation of program header
 size
Message-ID: <202508040815.0BB8B41AD@keescook>
References: <xd6zp5ytq6iakxkqoqqtseomgu5oohau4ynj3xbo7ejohpv7dv@skp2v7awzab4>
 <aI2KQaWpPLSAqdXg@pirotess>
 <202508021029.7CC8B334@keescook>
 <aI7zDXb2VpuaHHYi@pirotess>
 <6653242a-5b08-48ff-a126-9e9367633420@linux.alibaba.com>
 <aJBfDKr1-7L7GGgH@pirotess>
 <b98058f0-79fd-4dc5-af7f-d37941eb5707@aliyun.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b98058f0-79fd-4dc5-af7f-d37941eb5707@aliyun.com>

On Mon, Aug 04, 2025 at 10:00:41PM +0800, Yin Fengwei wrote:
> If this is really a concern, we can add 4K restriction only for
> noMMU. Thanks.

My point is that the headers are loaded via elf_read()/kernel_read().
There is no direct mapping, etc, that would result in some single page;
it's already bounds checked, loaded into a distinct memory area, etc.

-- 
Kees Cook

