Return-Path: <linux-kernel+bounces-816519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFC1B574E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A74E071D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F02F5320;
	Mon, 15 Sep 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lIKdpMeq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UZT093DL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lIKdpMeq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UZT093DL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5902EFDBD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928523; cv=none; b=gIozK2V0zz310VHmM3miKCH/p7EbwnUTQarm2MoAQ0ZEeQ9FZKwVfwVB6sPAuWtvmfzVup1YOgCocIyEIIyi4wvgz60+LLB4JnR+LCyEK1gbgm7VbsdmxI33i21hMSTeVO3dirO4hfIa0e9oTL8/CCY9k1gDQqw9BWNVgFmu9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928523; c=relaxed/simple;
	bh=9MR7FLgXLVQ+MB4yQ9yHtOeZYU404hPXVwh107qUBQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KlBR1dx8x8LekvMcaqHYNG3+9RWe8mqUz+XvigfPgkIAB/EJbdRCGhen2wOKortTRMnwq/ZbCf7WrWcVBPIqOsY5c/khwO53pdjcYcxxG9vxDrg2ZGtA0D5F0+9Ph6bFB5kd8qylJOryuMo0DzLAzPrOFKMggSlW5KVz2sx12yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lIKdpMeq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UZT093DL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lIKdpMeq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UZT093DL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD16F1FB3B;
	Mon, 15 Sep 2025 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757928519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kNwwDp8mALhOAtfiUXhiR7naALvUZns+yvApsad2Qlw=;
	b=lIKdpMeqJSqLQE6BLT6EW5iowNkNOwXhcG6CMp9Bohwoznok1zoiY4yjQCzwRca1zOzibn
	3b/JHmKHa8Sq6rvZmDyqxs2vTNjxSDCQkhrJVTvBbJZAHYgvJgv4kFsJcU+CU7pX84BTHD
	cTwbV1LZKtpme+4aqQKQW33ViJTQofI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757928519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kNwwDp8mALhOAtfiUXhiR7naALvUZns+yvApsad2Qlw=;
	b=UZT093DLmE+Gwma0pHIQizCJXisE23Pipl2wBY+34hCIHfXw+QYmCsmw6DFT+TREXpN05R
	r0IFIFLoAmb5HPDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lIKdpMeq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UZT093DL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757928519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kNwwDp8mALhOAtfiUXhiR7naALvUZns+yvApsad2Qlw=;
	b=lIKdpMeqJSqLQE6BLT6EW5iowNkNOwXhcG6CMp9Bohwoznok1zoiY4yjQCzwRca1zOzibn
	3b/JHmKHa8Sq6rvZmDyqxs2vTNjxSDCQkhrJVTvBbJZAHYgvJgv4kFsJcU+CU7pX84BTHD
	cTwbV1LZKtpme+4aqQKQW33ViJTQofI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757928519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kNwwDp8mALhOAtfiUXhiR7naALvUZns+yvApsad2Qlw=;
	b=UZT093DLmE+Gwma0pHIQizCJXisE23Pipl2wBY+34hCIHfXw+QYmCsmw6DFT+TREXpN05R
	r0IFIFLoAmb5HPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74A971372E;
	Mon, 15 Sep 2025 09:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mj9/Gkfcx2hmfAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 15 Sep 2025 09:28:39 +0000
Date: Mon, 15 Sep 2025 11:28:34 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Naveen Krishna Chatradhi
 <naveenkrishna.chatradhi@amd.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Target architecture of amd-sbi driver
Message-ID: <20250915112834.1d566970@endymion>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BD16F1FB3B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

Hi Akshay,

The amd-sbi Linux driver (sbrmi-i2c kernel module) can currently be
selected on all architectures. Is this driver intended to be used on
the host, or on the BMC, or both?

If it's an host-side driver, it should not be proposed on non-x86
architectures by default and we should add a hardware dependency to it
(or'd with COMPILE_TEST to preserve build testing coverage). What do
you think?

Thanks,
-- 
Jean Delvare
SUSE L3 Support

