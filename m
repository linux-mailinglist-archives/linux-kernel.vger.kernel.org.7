Return-Path: <linux-kernel+bounces-832562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E02B9FAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EAD1C23673
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6E28726C;
	Thu, 25 Sep 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ET1k/Pud";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4pYieGS"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D22857F1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808408; cv=none; b=EiGbMYCjugEmjyOldN3Oz7N7H9+FmdLQ7Cd3O3rxPneYgOcFR/b4D1vNPHiclQE1oO7HoTHcZnYSPK0lyouN8c22PUE/5QjmRsqWluDaYbq9LLVnFmmm2BeDgMB0DIoEIG4YFoE4J5UU1ibzuxenFs8vfnnBOxdl/tcwR2LEnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808408; c=relaxed/simple;
	bh=xTBK7dUb5kmaHMlvfQnaGNqVqOP+cx+e9lSwk9PUkys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X89kSZc+LtPWNfSL79WSLFNTZi2uWTklFqG0I2ciUURMtdISMFRcWbc+r+9tQQUzmCE4HKs+UfyGxXFjKF1EWoSF2EXOLRc8CiePxgpPv9AH54rmfy6joC7BJJjFQZiMjKN6VddsX57K+eplNpzjOeINVWW9PoQzLvNGHMmuKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ET1k/Pud; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4pYieGS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1C12140008A;
	Thu, 25 Sep 2025 09:53:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 09:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758808404; x=
	1758894804; bh=nbtXT8zEFemx2Nk5Z8fbjoImx297rkcdm6/1JnClD8I=; b=E
	T1k/PudVKc94Q7EuCxtPy5vjaLIZ9BKHoMrMgvTPVb8VeGFlNShex481xoRF6LSg
	QjizZRKeogddqOCmgeR838snoRo5BR2nPnkBlZxqsIMdPT1g5QjIKt1YAGxdtGol
	sxQKP0x2plUVEFZlZtxTFRB42oSAU7U61u+BBNMmcZhUCHTaMxxrQPp+SVDaRKfL
	xoKY1COh33dIz1bOQAvcsfDIUdraj6g6Vj2RUd+OwcrPQ72OFO867FnRGunGpFgm
	s+acjW/0mp6/5Nn2Aygyb0w64QF6jaauvPtIJwGhbOhnc5SbPySpDzOlOxyk5ta5
	bT/E+ZTIYJagQpES0PP5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758808404; x=1758894804; bh=nbtXT8zEFemx2Nk5Z8fbjoImx297rkcdm6/
	1JnClD8I=; b=g4pYieGSEhYYtRZ5lhCpgSXgDdkbzxrXZNxuQC/7TyYfbMQzj67
	aN+zSy3rN3OOlJtloklaEG3xwvuG2RF2W5CyFySuPVAtIupsX6cPDUfMGhDrwmLi
	sCWlf36BAacsgKFxFBDxArvE3A4V+8ydkAbV9oz/OhoWM1vhLncHJ36J1VXO5kJO
	ZWr/HbjVjTJl5kwj8eXZSB6ino0S7O6M9GaDXwPDSmYXay7gY8bJdbFFaHCVV/rH
	t0HFFzgneUp+KOKs+gIQgiBEOsCctGU2kyZLBB3mz06UYdI8MV8k/INjo+3bMkBv
	h92KcGqtqwACTin7wVlLdpM+Qr1Mchyq95Q==
X-ME-Sender: <xms:VEnVaCvqsYhjmne3CwTFsWbd2l7L8-0EJmWD0m3rZRVgG27Zb95OYQ>
    <xme:VEnVaPPZkR5IpusbkkCfvCTOXFbJkeCgqfMfU1LGFb-v6LMddtxA3efm8I2iHrJPz
    H8378eE5UafyPjmS0-PI7acWnBsXOTnFG2tFYIDnJZ5umDNHBl6uw>
X-ME-Received: <xmr:VEnVaA2aTx6GehIM8pFtXgx_RThllIHAVMdLU2hOscK5LZKyKqnqvBXb24RMm9RWzlp23TJJl12MH8cgLBZQPAu8i4MUn6Idi6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhudekff
    ehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefle
    egqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhkphesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:VEnVaLPG2cAne7lMYYPEu-JP2YT2i9ht8WxyIq-AdUD5MzWyc8vBkw>
    <xmx:VEnVaA12FZqJE0oXD_vm_nvRB8zN4pgG8jk4eWP_68Q_5edwea9f9g>
    <xmx:VEnVaCGyXWDAr4WCS8aLbVqFcegmiCtL8UjqkcLQnH03yOFv80YfoA>
    <xmx:VEnVaN6LRHhwJQDjNMPTK5Uu3iRkkRhQ6xH4DUtU1P0ICx2SX8BHlg>
    <xmx:VEnVaHE9iwTenuhlKMIAuh-sLldKP3gRi28wLZJ6YYsKY82zu33T8-gH>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 09:53:23 -0400 (EDT)
Date: Thu, 25 Sep 2025 22:53:21 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firewire: core: suppress overflow warning when computing
 jiffies from isochronous cycle
Message-ID: <20250925135321.GA329042@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250924131140.261686-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924131140.261686-1-o-takashi@sakamocchi.jp>

On Wed, Sep 24, 2025 at 10:11:40PM +0900, Takashi Sakamoto wrote:
> The multiplication by USEC_PER_SEC (=1000000L) may trigger an overflow
> warning with 32 bit storage. In the case of the subsystem the input value
> ranges between 800 and 16000, thus the result always fits within 32 bit
> storage.
> 
> This commit suppresses the warning by using widening conversion to 64 bit
> storage before multiplication, then using narrowing conversion to 32 bit
> storage.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509170136.b5ZHaNAV-lkp@intel.com/
> Fixes: 379b870c28c6 ("firewire: core: use helper macros instead of direct access to HZ")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

