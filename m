Return-Path: <linux-kernel+bounces-850119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7B7BD1ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86D8E4EBF33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138742EBDE6;
	Mon, 13 Oct 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zr3D/VXT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wx9/QFhS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vYqgbwpw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l48zKrz4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3702EB849
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342828; cv=none; b=P9MG7NTIF4DGMUym/Vad/PF4wR4YN2grXd995aNlnuwoY4aMuaO5PwfhqJfJbly+ytuwShC4bCAlak6X9xxSTUEb2fZDxgNKdmnHQWz90VyWo/GwNKQvYpnvmcQlVB1NYmA2EuevJ9GpWiZUBpGa8mu+0uJ051DVx3szWpRgQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342828; c=relaxed/simple;
	bh=00N2Yt9xFc8fExhwJ3GUOrKWTbVGU/GTPaOuuMd8ob4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3WP7lK9SKS3TD7Ruz4U6iy3Mk/vqKgG5ZTldp65ApZ/dKAfNXlMmGSdcTDAlaiVCk0DT9idzHWHP4jylit7qxNgbqMxf5TnCIACWW0sxi6x7yihCxMgsMos3JvZQGzUrVtqAN/Af49pphaVWnraRIKwKr1v+sAZsPCASYe0nOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zr3D/VXT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wx9/QFhS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vYqgbwpw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l48zKrz4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 287B0211CC;
	Mon, 13 Oct 2025 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6w01YLeD8Y7xeK5Gmx9nkKpU4qtns8801YbVOhrxlRw=;
	b=Zr3D/VXT+EBv3Vsijzg8uCr2TS86lZAtrDAHB+XWEuDaW8b/UXvDIoVYd6fmqdiSMZC3Qi
	LmUsIH7wgtra1qQKefS87CMjZ0RXqO71fNGQt+RdlHGilg3vL2CcWPZabieZEXU9B2g489
	zsxF8vLXqiaIYiyQkItPBhyHxkOSN+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6w01YLeD8Y7xeK5Gmx9nkKpU4qtns8801YbVOhrxlRw=;
	b=Wx9/QFhSLQ15pl9GXGO9Xd7GUKxZPcbXLMvPCBEqy4C237hdEGoXmfNwcoRLhoFBquVTtj
	x9Qp1fNKFj8m84Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vYqgbwpw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l48zKrz4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6w01YLeD8Y7xeK5Gmx9nkKpU4qtns8801YbVOhrxlRw=;
	b=vYqgbwpw/BLdRfvuqgxFwOaFJsnscL8yRzrKIbzFO0ft3vQC6f/ciCgk1VD7H/khkUPZXe
	I0CQOCkwTutAQZrBlQoG7MOvS5pY6rZ9zpJkasTgRTQb/Wr1TRrNKZnG6tKYt1ezZTGZ/E
	3Rbla2zD3Uv4Y3eky86ahqOUjCbVaKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6w01YLeD8Y7xeK5Gmx9nkKpU4qtns8801YbVOhrxlRw=;
	b=l48zKrz4/O7RBu10ddw+yNKgWIp7Da6Mta/5wf9kqqL2FwkVuabbvGXY5Jrfa1A7UW0n50
	M/XMFo4RQD4gK4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEEBD13874;
	Mon, 13 Oct 2025 08:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EvnaKx2z7Gh3GQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 13 Oct 2025 08:06:53 +0000
Date: Mon, 13 Oct 2025 10:06:52 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, david@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hugetlb.h: flatten logic in
 arch_hugetlb_migration_supported
Message-ID: <aOyzHMRf_eI3FiqK@localhost.localdomain>
References: <20251008212614.86495-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008212614.86495-1-gourry@gourry.net>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 287B0211CC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[gourry.net:server fail];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On Wed, Oct 08, 2025 at 05:26:13PM -0400, Gregory Price wrote:
> Simplify if-true-return-true-else-false logic.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

