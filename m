Return-Path: <linux-kernel+bounces-868652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0087FC05BED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362AC1B847D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9C319867;
	Fri, 24 Oct 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="punztuo6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h2I/49gu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oMttgZbw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KkRLmoUy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B2319612
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303237; cv=none; b=XgchqZShDCFsEugkRrBuqOfIC5DnSFhCDxjWwnPIu2ulZuf6cokhMLN5blho6F0sIx3AjrzK8D6oyjNtjkIcjjn0zfEt7slWG425jYS5embTE4KOTkbyHZ3Z5RTfGB25nVSiFQp0PAQCEtysDHkViMkZf9PYa9IWCqGdDRUHLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303237; c=relaxed/simple;
	bh=373bn+ShfYcEHNa0mqCDHwdvs6aidNMl7+nO7IxphvA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mC6sBdu6aIIqDkmmKjPQjMQMSnywLelRYZhH5eJtqxnueLUQVEEpPM9ccqueEtHBQNqm0CPwKPJbgE3h5skeuc8ejkqsToFk+RkJGaMX543Cq3fzLkFAKTj2lCvkVIKrs+Le8s9JmtLUbMmej1qv3KvgMp+x3+xI6RNTs8LU0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=punztuo6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h2I/49gu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oMttgZbw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KkRLmoUy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B79881F441;
	Fri, 24 Oct 2025 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761303229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHproW064/cQsrAvcneFDyvLUlQ+uWAIIu/ECDFOabk=;
	b=punztuo6MxaVQQWWGIR4+L2viFFil6cMK8AWJhL7TYNWQv9MDZ3FP4/9pUFcM9kxbbaytb
	5BAiFBdMhPrhCNs6azx4QX1DJL/5HQZ51onpRCMrIm4vC9z+qNIIl42owCLm/KZFECLuPU
	JmdBRbadbuiButVq4ktMXkp8gH2qlEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761303229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHproW064/cQsrAvcneFDyvLUlQ+uWAIIu/ECDFOabk=;
	b=h2I/49gu2SITzlZPJaoI0cwCaSBla3lPfOxKQ2RoWLm2DqyUhdKcC/LJnCyoih/rLBhr2O
	JBWoEcxQLWAfRQBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oMttgZbw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KkRLmoUy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761303225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHproW064/cQsrAvcneFDyvLUlQ+uWAIIu/ECDFOabk=;
	b=oMttgZbwzE2oSrCDPGCAAWMQOI0/DHWCMtmYVLDjEhww7cDJNbGkNTUz4vLL6ZwLPVpGIv
	TvdV8TyMScfstVK3x+2Sil3+i3Q8dYqRwJBlNI94VObv+3BXTKSirVLDB5Wy9Ja5L4aCYj
	CTm1dPPRAzMA7WOZJEBONSY+JOBUDqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761303225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHproW064/cQsrAvcneFDyvLUlQ+uWAIIu/ECDFOabk=;
	b=KkRLmoUysHAfYmka1NAARfJNaCvDPmjWKBHqzc7RAsLNxPQC2/hnsTr1RcJK5N0R42RIwB
	/6VWQU7aC/0Gp9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1666A13693;
	Fri, 24 Oct 2025 10:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ol+Arla+2hKaQAAD6G6ig
	(envelope-from <sjaeckel@suse.de>); Fri, 24 Oct 2025 10:53:45 +0000
Message-ID: <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
Date: Fri, 24 Oct 2025 12:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steffen Jaeckel <sjaeckel@suse.de>
Subject: Re: CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@kernel.org>, anthony.l.nguyen@intel.com,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, dima.ruinskiy@intel.com,
 Mikael Wessel <post@mikaelkw.online>,
 Mor Bar-Gabay <morx.bar.gabay@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch
References: <2025100116-CVE-2025-39898-d844@gregkh>
Content-Language: en-US
In-Reply-To: <2025100116-CVE-2025-39898-d844@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B79881F441
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

Hi Greg,

On 2025-10-01 09:43, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@kernel.org>
> 
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> e1000e: fix heap overflow in e1000_set_eeprom
> 
> Fix a possible heap overflow in e1000_set_eeprom function by adding
> input validation for the requested length of the change in the EEPROM.
> In addition, change the variable type from int to size_t for better
> code practices and rearrange declarations to RCT.
> 
> The Linux kernel CVE team has assigned CVE-2025-39898 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.4.299 with commit ea832ec0583e2398ea0c5ed8d902c923e16f53c4
> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.10.243 with commit ce8829d3d44b8622741bccca9f4408bc3da30b2b
> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.15.192 with commit 99a8772611e2d7ec318be7f0f072037914a1f509
> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.1.151 with commit b48adcacc34fbbc49046a7ee8a97839bef369c85
> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.6.105 with commit 50a84d5c814039ad2abe2748aec3e89324a548a7
> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.12.46 with commit b370f7b1f470a8d5485cc1e40e8ff663bb55d712
> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.16.6 with commit 0aec3211283482cfcdd606d1345e1f9acbcabd31
> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.17 with commit 90fb7db49c6dbac961c6b8ebfd741141ffbc8545
> 
> [...]

we believe that this CVE is invalid since the sole caller is 
`net/ethtool/ioctl.c:ethtool_set_eeprom()`, which already does all the 
necessary checks before invoking a driver specific implementation.


Cheers
Steffen
-- 
Steffen Jaeckel                       Kernel Network Engineer
sjaeckel@suse.de
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

