Return-Path: <linux-kernel+bounces-805851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12155B48E54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933261B25081
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D63054DC;
	Mon,  8 Sep 2025 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rM4AQx3/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7hGoekqL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rM4AQx3/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7hGoekqL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D52FF641
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336201; cv=none; b=YMOrRgHiHKPs3p/l+PBm9gOlJ6SASwHMo4DHanHtHmpUTr/HZPZfhTmhdpiAwLym6ZyV2WJKSGk6FRLCLZ7jeZOzOwN6xqrpoj8GC3J85KJmu0xnydpPxliG+Y5NMsY+cHe2bguVhZpvqg4kPThk5LIJwgjvEbeZbLve4yx+mJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336201; c=relaxed/simple;
	bh=4pn6cIaFYpnVMRRM5cg0gQRWUHqa+HnDs8UBg8KDm2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcnZc6q+6VZIrEtHYIM7lB9yw+yADzg4S6d6ycYfCQowe2Gpb7S5AKLW/tuOykBwbxcwkIFOlBC4f9uRQsuBY22nXAYv/OJeh7geDihoi3Lo9oXr6J3lkJaeciGh37YXaq+8utwu9a9TQkctUkFum5nj9c/99FiT4Vz2CFy34T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rM4AQx3/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7hGoekqL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rM4AQx3/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7hGoekqL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D4E026E17;
	Mon,  8 Sep 2025 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5DI4EFHhD7SQLTKxj3PbnpEEu/u/xnl/Hk37oUehD8=;
	b=rM4AQx3/42qlv/+kAjl6snYRMqkDr3OemZ0QB6/AE8NiKeFBaCXAo14GX9y5Ixt8yo45B2
	cSn78gTD5mtefPIdpvhMmbuU0c/nPrKoeTkCB99DLuS/HC7Ss1GzLiAh3azFSGPtA9pD+o
	JLvc8PYCprhWeYaCQmeGRTBmNPn5QVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5DI4EFHhD7SQLTKxj3PbnpEEu/u/xnl/Hk37oUehD8=;
	b=7hGoekqLwnUhbmB5IaQ8kKCOlSquHZ9IJS1o+tZGHtynxOof92hzRjBvHId4oLpVv4wK7z
	FUxD3s+CjshmrwAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5DI4EFHhD7SQLTKxj3PbnpEEu/u/xnl/Hk37oUehD8=;
	b=rM4AQx3/42qlv/+kAjl6snYRMqkDr3OemZ0QB6/AE8NiKeFBaCXAo14GX9y5Ixt8yo45B2
	cSn78gTD5mtefPIdpvhMmbuU0c/nPrKoeTkCB99DLuS/HC7Ss1GzLiAh3azFSGPtA9pD+o
	JLvc8PYCprhWeYaCQmeGRTBmNPn5QVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5DI4EFHhD7SQLTKxj3PbnpEEu/u/xnl/Hk37oUehD8=;
	b=7hGoekqLwnUhbmB5IaQ8kKCOlSquHZ9IJS1o+tZGHtynxOof92hzRjBvHId4oLpVv4wK7z
	FUxD3s+CjshmrwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF2CE13946;
	Mon,  8 Sep 2025 12:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MqEiMYPSvmhDLQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Sep 2025 12:56:35 +0000
Message-ID: <d1db6858-75e7-4853-a5e8-d0f1f02fb389@suse.de>
Date: Mon, 8 Sep 2025 14:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvme-core: add method to check for an I/O
 controller
To: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
 <20250905232550.1950307-2-kamaljit.singh@opensource.wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250905232550.1950307-2-kamaljit.singh@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 9/6/25 01:25, Kamaljit Singh wrote:
> Add nvme_is_io_ctrl() to check if the controller is of type I/O
> controller. Uses negative logic by excluding an administrative
> controller and a discovery controller.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> ---
>   drivers/nvme/host/core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

