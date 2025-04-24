Return-Path: <linux-kernel+bounces-618408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A376A9AE24
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F1A3AEC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1D27BF79;
	Thu, 24 Apr 2025 12:59:07 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5D27BF8A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499547; cv=none; b=VJjd8NdlLNWAEyg+htTQJDChcZxsINQBz1h1Dd61l0Bp4WQNniUR7vtuzSV9kBv0nM0D3m0AgYXJi51aMIyzA/2yl0IU5poUCXHABYcw78PeZSBAQzFoVXzwqWLsSoE1u1AhlWK0eDb/vq6z6QzK0WVJzi4Rdf1dhENuHl1Lcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499547; c=relaxed/simple;
	bh=tJdKg0AM7bnavIX4fjpcO9tgoXWYFgs3Zwbw1mNNCAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4hMp2u9fTxypqVEvaSV4s9z+/pmI4CPhVm+eHprvQIBtpHCXEGh3FfFl+IC0PZ7AKnBe78tx06t34eEn/dGipWwSHpBRo7OaWiYoj58hIMXkpapcdqXJoR+mczuu5Bn4q2JcWOCWLJ24jUiEp/ge7lA6oTnle3QBm+sIw7S1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A859A1F445;
	Thu, 24 Apr 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BEB2139D0;
	Thu, 24 Apr 2025 12:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 65bLH5c1Cmg+VgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Apr 2025 12:59:03 +0000
Date: Thu, 24 Apr 2025 14:58:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/14] nvmet-fcloop: don't wait for lport cleanup
Message-ID: <11c9e291-b7dd-453c-82d8-09d068b6b69c@flourine.local>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-10-3d7f968728a5@kernel.org>
 <05ac9a81-66a9-4bbc-92e0-6ff47a6dc7ad@suse.de>
 <c1f207f3-6657-4803-90df-a059353ba6da@flourine.local>
 <8a3093b6-d5b2-496d-828a-0667abbf1670@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a3093b6-d5b2-496d-828a-0667abbf1670@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A859A1F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Thu, Apr 24, 2025 at 02:10:20PM +0200, Hannes Reinecke wrote:
> My point was more: you call kmem_cache_destroy() unconditionally upon
> exit. But the boilerplate says that you have to free all allocations
> from the kmem_cache before that call.
> Yet the exit function doesn't do that.
> Question is: what are the guarantees that the cache is empty upon exit?

The first loop will only terminate when all request have been freed,
thus it is safe to destroy the cache afterwards.

