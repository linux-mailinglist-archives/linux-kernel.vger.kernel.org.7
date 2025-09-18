Return-Path: <linux-kernel+bounces-822868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567BFB84D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA539585654
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507030DD14;
	Thu, 18 Sep 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BYa5AdAp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SLbnRiPI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QBV22+Jf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A0e1aUmn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9030CD89
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202201; cv=none; b=eEW1ZUB5hIFqG5smYXnBdydXfgVMyIMI1K992ZB2T58c3599oytSGkpalg6CF2Tyac8iWu4o0jLSMOZfiJqHHI0Oa5bVWz1DcWjXw63QFjZcDwH/3Asrcom4AgxPCbmIr3Cz5FC2Uf9fpyFhH69QLptJYA+gdFsIjDAtKfk8gm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202201; c=relaxed/simple;
	bh=mbvQzVH2zh/rAJBl7rwAb555V1/lYHTZKrOFE48mL4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beOaIS5e3L2iTvndVaO3QntDz9oh7f4Fw/67aB/EQ10Q8jxYF+rJOeo/nhKEUmxRJf2p7mmyW4uh/i+P4rK/uIYcU3/hmqwwXTz/767NfcGrk873EnYRfDo+La9QRlYkrF3G5dZPPLrF5Kn425hJnLoIjGFfRlCEh2p4FJF6VYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BYa5AdAp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SLbnRiPI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QBV22+Jf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A0e1aUmn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D655B1F810;
	Thu, 18 Sep 2025 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758202198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fTYoCWRW+L4YjxiFOSgMgnFo1xCFk5eZgY4MSn+A3o=;
	b=BYa5AdApOCI9L1qon3mTcKg6c6/zqqdouNc5pLRjR/723HJIRedILVA15XeArV6WqJv5HK
	Q0c21RDeh+nMpNPqye9R2c1GakMpZdcrgMtnR3Sy9Bieqa+fsP+hmCfE5bbMyuiLK7LGLc
	+5nbbBtIMHQITDT4CvfTAnGasfyM9Yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758202198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fTYoCWRW+L4YjxiFOSgMgnFo1xCFk5eZgY4MSn+A3o=;
	b=SLbnRiPI4rjvDB4k8gKO1CE2cb56BnEKSUmYKPD7QOuTSz4K2qnIjVS83bdzaC9PtlxzrR
	swpdMXmOEZKNLlDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QBV22+Jf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A0e1aUmn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758202197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fTYoCWRW+L4YjxiFOSgMgnFo1xCFk5eZgY4MSn+A3o=;
	b=QBV22+Jf+VAK8o4k5MJWCbw32X9qS3KoZ7Yk6VwdJFK92dL2N9rVjLF8tmhsSMxTnFl40b
	NsNB2qZEZvqeyzig5sXgk+gHKGikyMvlmG2Q9FMZTWDgp4UvXFbWBYxI+eIQtv2Io5WnV0
	UYImvCSLChK0El7KCq0col1hlfeaUUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758202197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fTYoCWRW+L4YjxiFOSgMgnFo1xCFk5eZgY4MSn+A3o=;
	b=A0e1aUmnAjElGy89nAtCMSe6k/opsvZtDzVKmSGxIdqpnq5exiF91nlmIl6ZmcHOB4ZJIK
	pImNVl2THuH7SYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0457D13A51;
	Thu, 18 Sep 2025 13:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 73azOVQJzGg3MAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Sep 2025 13:29:56 +0000
Date: Thu, 18 Sep 2025 15:29:55 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Donet Tom <donettom@linux.ibm.com>
Cc: akpm@linux-foundation.org, clm@meta.com, Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com, dakr@kernel.org, dave.jiang@intel.com,
	david@redhat.com, gregkh@linuxfoundation.org,
	kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rafael@kernel.org, ritesh.list@gmail.com,
	yury.norov@gmail.com, ziy@nvidia.com
Subject: Re: [PATCH] drivers/base/node: Fix double free in register_one_node()
Message-ID: <aMwJU37LhxCUO6pZ@localhost.localdomain>
References: <20250918054144.58980-1-donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918054144.58980-1-donettom@linux.ibm.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D655B1F810
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,meta.com,huawei.com,intel.com,kernel.org,redhat.com,linuxfoundation.org,jp.fujitsu.com,vger.kernel.org,kvack.org,gmail.com,nvidia.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid,suse.de:dkim,suse.de:email]
X-Spam-Score: -3.01

On Thu, Sep 18, 2025 at 11:11:44AM +0530, Donet Tom wrote:
> When device_register() fails in register_node(), it calls
> put_device(&node->dev). This triggers node_device_release(),
> which calls kfree(to_node(dev)), thereby freeing the entire
> node structure.
> 
> As a result, when register_node() returns an error, the node
> memory has already been freed. Calling kfree(node) again in
> register_one_node() leads to a double free.
> 
> This patch removes the redundant kfree(node) from
> register_one_node() to prevent the double free.
> 
> Fixes: 786eb990cfb7 ("drivers/base/node: handle error properly in register_one_node()")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

