Return-Path: <linux-kernel+bounces-832563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A03B9FAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6848F1C23638
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3797E285C81;
	Thu, 25 Sep 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="YX1qmtg/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TE4pco7y"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666042857EF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808435; cv=none; b=brzD8dHBFQPrbKDysSgmMO1lmtSqXM24jWuOpRG3sXNcublTYajHPJTej8xGZ2+63gig1ZUbP27lpesE1R1+Cqz6qDzkMbYRnWUdFEcHlNRTVSnucLshJYHcDP4fjjSH1Hxp9u2EvbU8DUCWadFMtzsc3CxXP/+uxBSrC+oZVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808435; c=relaxed/simple;
	bh=8LmXZYY9H0C7YgNc+hA3aoQj5E1DlCbVyuK047EghYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfkyPBqvQzYFeRNownhJUGy1cSX/0a/WfQVqBYYIGUvvjp3w9rFceXv2Hlbka5cW/mLmqPwzvt5qzppyAKy7Ci3l8ttf48cDbZyS9aDBh9gLHtdNh/5ngA2ClEQohVaQy2bTcapvZ/XP7MHCEArbBdSG25NWhaawfF2OKi3pL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=YX1qmtg/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TE4pco7y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8ECE2EC0216;
	Thu, 25 Sep 2025 09:53:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 09:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758808432; x=
	1758894832; bh=AiRHqq7wL/NJSbdSEbfd7e9YXRXtuAk83mydyQfwhT4=; b=Y
	X1qmtg/R+7Q3U/12dID8sAW/ycgODBw8/OM1ERAzFt32ABBdFd4EINx1uZ1zlooY
	O6HIAgCDRkpN+eLvie1HMrFd4iClAX4pe6408RPosi2wGdnTWV/jGoBz8E6YknLk
	wZ8XV2v/S3a0TEmD+Xhq4T6uGh3htalgtleV8ZgWuV0b6OCoVr8nCFYg2Jt9fJDu
	XOwwQKcSYChMjAMuiUPrg3xtqxn7vaatLDq4BmmjDVwy+RfiSCWEqQoKbVv2iM3C
	tUJXGyqzsrso7eOPUgGIWgI0vBoMYIYSdW8vieYIRYSJDv/BHwf1hFC6met+rKAt
	+I76lqun65CUiJwdVBOPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758808432; x=1758894832; bh=AiRHqq7wL/NJSbdSEbfd7e9YXRXtuAk83my
	dyQfwhT4=; b=TE4pco7y/1NeyYOsXLY4dSTFn7auzq+mKeDx884sby6XgftsuB/
	MjgeOSk76lxnjl9GOdvlqmuqe3AeZU+WSoxyAsdFhMgpmqXMas50Ane3tKTagZ5K
	tuHM4GElwv3SmliRdFF4KLaiDNVcnyz7bgFM24Au9oavM1igr22E+S2CDQgkj7ES
	PXIl1a6L2iPYWktGWhPCwSdhcqN2b0kXYaRi/hkSdbgHtynVrfgR+lFAajLcBawm
	Y2LFu5kKBMT+bQB7JVVx/YB95shJdoX7OW62HOkLvpZd2NrVp27sG+PUHw/aJ1xl
	YOqt334g7DVXN74hTQJ76gaLdqvf+mHPaqQ==
X-ME-Sender: <xms:cEnVaKMpRkndViu3-fKQpSsG7PWJTI_QCGZoWwfweBLMttIFjL2KPA>
    <xme:cEnVaG51ZiAj5yKQVAW6nDtA_Zw9s1XnCcuRwNBIFphXtazsKtnl2fHEfbZIctC3G
    Dksn8SD0UA3MyAObUn74KZrxsjiDA_sGFNKD8Kw13rNXw8Xw638i8do>
X-ME-Received: <xmr:cEnVaI1RT2gpYS0UIF71X7bwNnf6tFH3AijBmk3skh5RvZSozBXtxlrRwEvruFlkpZpTxFjWs4FsdmTwpzEuW6k7GzHh9K5NDNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhudekff
    ehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefle
    egqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cEnVaHZSnr5smPm7vezn-IrOlndJe1tNWO3zOvBZGRBIYGCVRnnsbA>
    <xmx:cEnVaADT25uaRImMgeNRKsQxTJKj0Q88Z2SYYArkJPLLgvE_pK8xPA>
    <xmx:cEnVaJ_O_BGSlDM1T1FWsgI5jsE-sSFMd6t93QSympC-HGgY4hT5Dw>
    <xmx:cEnVaA_cWFsUIK2oSWpuCgHs3YahbjQD9aZOnCKPYW-77jWzRtT-iw>
    <xmx:cEnVaJivElb0FhmgCYiQkA1Xd8NARUHhh1g4Si8JCL5z_1a_u0kWMmhQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 09:53:51 -0400 (EDT)
Date: Thu, 25 Sep 2025 22:53:49 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] firewire: core: revert "serialize topology
 building and bus manager work"
Message-ID: <20250925135349.GB329042@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250924124212.231080-1-o-takashi@sakamocchi.jp>
 <20250924131823.262136-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924131823.262136-1-o-takashi@sakamocchi.jp>

On Wed, Sep 24, 2025 at 10:18:21PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> The patchset that serialized bm_work() and fw_core_handle_bus_reset()
> was merged without sufficient consideration of the race condition during
> fw_card removal.
> 
> This patchset reverts some commits and restores the acquisition of the
> fw_card spin lock.
> 
> [1] https://lore.kernel.org/lkml/20250917000347.52369-1-o-takashi@sakamocchi.jp/
> 
> Changes from v1:
> * Fulfill cover-letter title
> 
> Takashi Sakamoto (2):
>   Revert "firewire: core: shrink critical section of fw_card spinlock in
>     bm_work"
>   Revert "firewire: core: disable bus management work temporarily during
>     updating topology"
> 
>  drivers/firewire/core-card.c     | 38 +++++++++++++++++++++++++-------
>  drivers/firewire/core-topology.c |  8 -------
>  2 files changed, 30 insertions(+), 16 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

