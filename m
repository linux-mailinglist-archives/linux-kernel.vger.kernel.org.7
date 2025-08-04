Return-Path: <linux-kernel+bounces-754755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE33AB19BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1613A5203
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81316235044;
	Mon,  4 Aug 2025 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1OeUnbRP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RX7Q2XWP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1OeUnbRP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RX7Q2XWP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82620233722
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290727; cv=none; b=LednpQe9+OeEqroF2QukQyHWp19/CQniwG2dMqz/BKRJPBiOdY6paklT+5LRvifa3YI5XuwkQaC8iOb8XHIHHr37OKRs+6B8mZ0JzzEjY9uZi1sXi7SfKa6QdlYeRP4npiq+nLLAluLhcZ9O6ExztDHS5gKWCAIQa4E8oKn+Ktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290727; c=relaxed/simple;
	bh=5y1x2aDUNvECnPaxmPB++TOu3OVNzGY4Qh51g26l6VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2DKLCsV6fEpmSdNgOSF1I/3I3gAjJYSz97IWFhIGudP0UQ6AHCgB0OgS1qPyRUQkmCuW95cflFvS5dME+lVqN1v6RPm7H4RQCDt407j4AKZ768RDMDqeovywiXz5/qc8wuYPUmqAacawHERCwSDWN0jTQXjr5ZQ2SctwlWXrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1OeUnbRP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RX7Q2XWP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1OeUnbRP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RX7Q2XWP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C66801F387;
	Mon,  4 Aug 2025 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VdSXN5CTvWh9eCYxYGq6Le8A7T8+jX+UqzQdoGN3wQ=;
	b=1OeUnbRPitk8hO9Iy5Axk0JyzcyUfERooiMg8lg5MhISSPROXhOVCifDKtnhP3Gh9yb/3B
	GPgsYxlnM0qeEAlnh5X7BslBTrn4GeVaORYsKVLql8GeJ4sAGew6MvrP1/p59HhRRYGBhs
	yNhlrluEtn3a7e4GFoPiYleGfyBSjG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VdSXN5CTvWh9eCYxYGq6Le8A7T8+jX+UqzQdoGN3wQ=;
	b=RX7Q2XWPSlhiFRsA0jMlPweDbTLEDdsJRlOPDyKhGsoS1GiQvkMicLXEFX73KiAofXFxHp
	rXa5T8OpH8xKlUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VdSXN5CTvWh9eCYxYGq6Le8A7T8+jX+UqzQdoGN3wQ=;
	b=1OeUnbRPitk8hO9Iy5Axk0JyzcyUfERooiMg8lg5MhISSPROXhOVCifDKtnhP3Gh9yb/3B
	GPgsYxlnM0qeEAlnh5X7BslBTrn4GeVaORYsKVLql8GeJ4sAGew6MvrP1/p59HhRRYGBhs
	yNhlrluEtn3a7e4GFoPiYleGfyBSjG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VdSXN5CTvWh9eCYxYGq6Le8A7T8+jX+UqzQdoGN3wQ=;
	b=RX7Q2XWPSlhiFRsA0jMlPweDbTLEDdsJRlOPDyKhGsoS1GiQvkMicLXEFX73KiAofXFxHp
	rXa5T8OpH8xKlUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62FF0133D1;
	Mon,  4 Aug 2025 06:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NkkgFiRakGj9UAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 06:58:44 +0000
Message-ID: <857e1e8f-99c9-4780-96c5-68cdfbdcd310@suse.de>
Date: Mon, 4 Aug 2025 08:58:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] blk-integrity: use simpler alignment check
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-7-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801234736.1913170-7-kbusch@meta.com>
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/2/25 01:47, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We're checking length and addresses against the same alignment value, so
> use the more simple iterator check.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio-integrity.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

