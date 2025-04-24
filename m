Return-Path: <linux-kernel+bounces-618082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C9A9A9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 12:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3D174F82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 10:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE221D584;
	Thu, 24 Apr 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I20tKXm2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a+YYAgpi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bh3MHHFI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dQop6UZW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24141C7019
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490118; cv=none; b=qnR0wGBIYb+yYvdBHdH3DLDa0vUNsfjKKKsPi4vp5XTcodXiF1RpDXyXrmfXKeIjhlHhfYEkvwasTAxsVnTsKc2Vt1jxQSH9viCz+6IEL7GWG+v8q0JXdZFRgyLDIt/Tdo/xH1Zx3WkZWABxrbOhuTuMxqKHB0JK5EMJZ3QWjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490118; c=relaxed/simple;
	bh=sWo5LIWFPuhzSDzXq1fh6zVESHzdt37u4Vur4twefNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtvwuXA9AAbzo7LKZ9rguPbuhLBO7rYHN+bqCiJ+c3u/ndiX4tEAI1QXhpm4D7PMP8Qt+GyiFc9Xx8auLALy1ReQxFk9VHWam0B2K3kehsFloOhwtkWtnXa61j7pZ6V0inwCX7P3VDiWvt/BNuID1PiCb/rbek1rrx6wSYe7grU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I20tKXm2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a+YYAgpi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bh3MHHFI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dQop6UZW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D462A1F399;
	Thu, 24 Apr 2025 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745490115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=;
	b=I20tKXm2vPnHFEh+CF7xorhhFOp6h6i/43X/EeKNYhMmqwalpmHe3Mz+rdPQcQdcPcfs/G
	hs1RgJZrqi2K/AIdQBp+cHDVFnopPaVnnuiD+7g+i6KNpTF5ICQG4RF0hB3WWm2ERXSz3T
	/aDzLAVd84atp/AMCOto1PmsIWkFgNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745490115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=;
	b=a+YYAgpixgeRV+bm/N29cvn2BpJP8llXfjt2lk2YeP+60EKYbmEK8+ez+Qxg/BPJS2LZ6a
	THcBtMWl3RjuthCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bh3MHHFI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dQop6UZW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745490114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=;
	b=bh3MHHFIC62dDpLaM5nOwpPj+aPB7F1dyEoA+H8aJRUdWSBN+5K6A3DQpZWKq9Vo6pBjJP
	tZXNvGA/PMrXUW8q/wkeB9qBV0S5k/BjSUBNvZ1f4xnrzu7xuYjq01RbazW6Aqk3Ao6Ts3
	yQUmfV7JqT7hrK5BZklTWSZpx/PYuKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745490114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=;
	b=dQop6UZWOo9+HwTQYn86FOZkMvDevC4lhLCgK9eR3dEVsQVqMGQ4gPiy45b4wSp5faszcn
	hL/Pu7Vly1q0bcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC415139D0;
	Thu, 24 Apr 2025 10:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f39QLcIQCmgVKQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 10:21:54 +0000
Message-ID: <c966329a-3979-4eca-adcc-4832ffb2b35e@suse.de>
Date: Thu, 24 Apr 2025 12:21:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/14] nvmet-fcloop: drop response if targetport is
 gone
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-11-3d7f968728a5@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250423-nvmet-fcloop-v5-11-3d7f968728a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D462A1F399
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/23/25 15:21, Daniel Wagner wrote:
> When the target port is gone, the lsrsp pointer is invalid. Thus don't
> call the done function anymore instead just drop the response.
> 
> This happens when the target sends a disconnect association. After this
> the target starts tearing down all resources and doesn't expect any
> response.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

