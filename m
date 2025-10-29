Return-Path: <linux-kernel+bounces-875698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EF9C19A06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DEB1C82393
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABF2E7BCA;
	Wed, 29 Oct 2025 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hLfIpyua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pmrly7Q0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hLfIpyua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pmrly7Q0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDC2E7645
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732871; cv=none; b=FOvR2buDod/xSMiUuIITg4ZikfQZcJT0oCJdX0t0zR205XQIH/6twaqksJybqdo4ZQRDsiYo9MDZcrYCS6SoH/jV5rxm3mjffnZWv5B5b4mONoxez9PYXXGGM9BVihb3Bno2Pg5O712dY3aQq8tnNMvrnjFyUmUxBElDYaTwLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732871; c=relaxed/simple;
	bh=wZtKaeOnqZfzbIUmQ2P++a6ch4mvgSxnroV/Y0PF8r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU8kli+uk1+GsWAAhLX5LH02KwESDMcNDmxYop/y/5aPs2FRyh+j8YuNzbT5iM+7m+oqSeqWTiczRXm81TT8QJ8QzhiRMgHnyKrU4Q5hWZT51BH/M39JksrwWQyjx3/4LzJFk1ws+G30Bv+Hn62endWhva01HwmDwk9abMxy0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hLfIpyua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pmrly7Q0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hLfIpyua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pmrly7Q0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD2D9205F2;
	Wed, 29 Oct 2025 10:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761732867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByaaBTe6Ov9hqnGgVWt1TD7UBaQWSeTyJszuF/BP9k8=;
	b=hLfIpyua7CIR+3uM7bihv7xV9R6rnQG7uHb4XHdbhzA/UkK4eEYaF+8qA4nkez85HK4U81
	B8UDdIr/yXkSNdMY81qDsTU1UqiQhPhEeVnT6ms0CM1Ff77M7B8+h81dVMeSQhh7l9O3Ae
	D/fdk67J/4wal/ufzZd7JSGAxDG8+lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761732867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByaaBTe6Ov9hqnGgVWt1TD7UBaQWSeTyJszuF/BP9k8=;
	b=Pmrly7Q0jt2j51z84RE/ISayj/c+Nlrnma0s66SUsJAxkwawLkfsr4jGS1tgpCMpmqb3Gz
	Ih3lrEs2PNmaZfBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761732867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByaaBTe6Ov9hqnGgVWt1TD7UBaQWSeTyJszuF/BP9k8=;
	b=hLfIpyua7CIR+3uM7bihv7xV9R6rnQG7uHb4XHdbhzA/UkK4eEYaF+8qA4nkez85HK4U81
	B8UDdIr/yXkSNdMY81qDsTU1UqiQhPhEeVnT6ms0CM1Ff77M7B8+h81dVMeSQhh7l9O3Ae
	D/fdk67J/4wal/ufzZd7JSGAxDG8+lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761732867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByaaBTe6Ov9hqnGgVWt1TD7UBaQWSeTyJszuF/BP9k8=;
	b=Pmrly7Q0jt2j51z84RE/ISayj/c+Nlrnma0s66SUsJAxkwawLkfsr4jGS1tgpCMpmqb3Gz
	Ih3lrEs2PNmaZfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E9151396A;
	Wed, 29 Oct 2025 10:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DwHcJQPpAWk1LwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 29 Oct 2025 10:14:27 +0000
Date: Wed, 29 Oct 2025 11:14:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Message-ID: <831d8af6-5bb0-4869-b9a5-6a4442ec8d67@flourine.local>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
 <20251029074403.GA30412@lst.de>
 <bd91a6c1-cefc-43e2-8dd8-48b7ea241ded@flourine.local>
 <20251029095907.GA1652@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029095907.GA1652@lst.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, Oct 29, 2025 at 10:59:07AM +0100, Christoph Hellwig wrote:
> The problem is that there is no such thing as a sanity check.  Otherwise
> life would be easy.  But I really can't believe that Dell is incompetent
> enough to not leave a mark of their OEM Firmware version anywhere.

Got it. Sure, there are version strings though not really 'stable' as
Hannes told me. Maybe there is a way to filter these out. But isn't this
what the command line idea overwrite feature is?

John, did you have some progress with this?

The sad thing is that the Intel device needs the quirk. If the Dell
device just would use it's own IDs...

