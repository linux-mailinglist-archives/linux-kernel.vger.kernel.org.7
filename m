Return-Path: <linux-kernel+bounces-757407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D3B1C1CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56368188C3B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F69220F3F;
	Wed,  6 Aug 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EQoR+Q5j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z6cLcPD0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EQoR+Q5j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z6cLcPD0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5EA22068D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467704; cv=none; b=uxc949eD6qP9AfXWlSQqH/y8HuHMaZUl+/s/okS8UfW94fnX46nGrnf+VgSBNcL8lDDef1mXCi22WMA9zJDGuFk1RqboQnGgJFwxg9dVhsc3kYe/CcE3iGOqCRaacUoYTbPDQp3YTo0Bue16ww0I8I7x0lKPiSkTOmBsDenIl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467704; c=relaxed/simple;
	bh=Lmqmw5FWaLtR3SxkQpIuvJunPCUj/DUVSI3Q/0mGpDU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lXaJHkfyGbc8LxYIn7apArutC7LNIaLvkF7Al8o+m9mPCoFYyuEesGB1toHHDNBHw8O2RTcSBqQWScPvCgYCmj5c9tjDMJ6xUvopjKtrzEZmWx1WwdpEs1IquOJSthJIdqze6lxmiD0TTTY7UVf5wqyiZIQnqeqnhC0vtJaIDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EQoR+Q5j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z6cLcPD0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EQoR+Q5j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z6cLcPD0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 923B621744;
	Wed,  6 Aug 2025 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754467700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vfa8JIicem/4yRlMM9YoM8phNgRBkXiHyLqwlpPMG6M=;
	b=EQoR+Q5joYedumVFSqyS7oIiKTHKJCtk3Wmw76w/vc6B8VPbCBnsU9FHZpfNlZmTDif8v5
	RjoHrTlxZ0NaB9awPBie7Pficxqx1r7ce2rchaJ/YiHHc50rVh16Fif8++cHHVkhE2pAve
	vquH3OmrnmnWE+oQqVTYd9LhIt3SWQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754467700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vfa8JIicem/4yRlMM9YoM8phNgRBkXiHyLqwlpPMG6M=;
	b=z6cLcPD0WuRk+ILs2Pmwsiq68CMkOAL2jR0Ydg1kYbZbwUa45bz6XDeKAMhZxXYJj/P7FL
	2ytkpHFrDwAe/vBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754467700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vfa8JIicem/4yRlMM9YoM8phNgRBkXiHyLqwlpPMG6M=;
	b=EQoR+Q5joYedumVFSqyS7oIiKTHKJCtk3Wmw76w/vc6B8VPbCBnsU9FHZpfNlZmTDif8v5
	RjoHrTlxZ0NaB9awPBie7Pficxqx1r7ce2rchaJ/YiHHc50rVh16Fif8++cHHVkhE2pAve
	vquH3OmrnmnWE+oQqVTYd9LhIt3SWQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754467700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vfa8JIicem/4yRlMM9YoM8phNgRBkXiHyLqwlpPMG6M=;
	b=z6cLcPD0WuRk+ILs2Pmwsiq68CMkOAL2jR0Ydg1kYbZbwUa45bz6XDeKAMhZxXYJj/P7FL
	2ytkpHFrDwAe/vBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4892513AB5;
	Wed,  6 Aug 2025 08:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CACqD3QNk2h2BQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 06 Aug 2025 08:08:20 +0000
Date: Wed, 6 Aug 2025 10:07:48 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Minchan Kim <minchan@kernel.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Default value of CMA_SYSFS
Message-ID: <20250806100748.21620372@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

Hi all,

CMA_SYSFS looks like a generally useful and low footprint option. Is
there any reason why it isn't enabled by default when its dependencies
are met?

I was wondering if it would make sense to add "default y" to this
option. What do you think?

Thanks,
-- 
Jean Delvare
SUSE L3 Support

