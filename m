Return-Path: <linux-kernel+bounces-749026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8729B14909
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092193BF89A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9528262FC5;
	Tue, 29 Jul 2025 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZmDj/T3w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hcu72KCv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEqIEK0S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nczYPxox"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7CF22E004
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773898; cv=none; b=eh13PbXzmg1oHzM7bbXryxw/laLNm2v6sdT4OH5qo/7R1oeUJzXNgAyebRdq9dtfcjdAzyq0VW2VP+XbqYdVbDwh1MzPG0cpmehLN7ab9dr3/GppJvThiHvNQH+m+toaliwBlgE6cdMoDC/K5Y4obu0235IuUFrtpl3fZvk33pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773898; c=relaxed/simple;
	bh=BUq8qJ21ygblkG2kS/i7Ou8XmO/FRgigoQqbiZQwkLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9ma55Zs4tGZoffSYDebEHIV5yD+im+8Hr8cSNJ3KomfHIKnjc9fwNu2pLTdJ3ZLNcT7Uk6uhJfCQh4ZlT5nuBGnfVRcd2XWlgSyUVpgY5cYdeurjFpxFePfY9ZzSCJdwIGsOJU9VuCka6x4ftsqgPLQ55+zUwqBx9gw0Uwdqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZmDj/T3w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hcu72KCv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEqIEK0S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nczYPxox; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4992321285;
	Tue, 29 Jul 2025 07:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753773894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dT6lTHeMKW/RxZFzXwAmbYK87ulRH345lFXil9hMwPs=;
	b=ZmDj/T3w5fu1uvVG0If94NFuWGew6Z/BtlQ5WOVYk09zQeURHVTEAbXaHw2Lg1dpfPs5WW
	pSqy1IJBnGzGuvPu181vyaTTwgcfqd4O2flETqzZgSIby4jvvmJRkUvgh3paWS2bGZcHNo
	JT80PubdDOV1gz68cBjB/bMGuCmYYeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753773894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dT6lTHeMKW/RxZFzXwAmbYK87ulRH345lFXil9hMwPs=;
	b=hcu72KCv8QVlQp3ahmymucprjUBg23AoHKHT8dK7SUZ2pMIeklMs2tJu0olO/Zy32bprap
	immtHdnPc/ALgFDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lEqIEK0S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nczYPxox
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753773893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dT6lTHeMKW/RxZFzXwAmbYK87ulRH345lFXil9hMwPs=;
	b=lEqIEK0SsBC4FL/bS9UEmO25RxehlTJnFcrNBy2chhjuMcaFIQh9xhtp/q/2lgthBqKVCe
	A4EgMOI1TFxR2p2vvN8xgMotgiQUhW6d1qKCAMjCjoCsZZHvrXtaT8eZER+9DectEPyOlP
	M+UCAk2c1YFpDRLPiFlSom3kb5cdgzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753773893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dT6lTHeMKW/RxZFzXwAmbYK87ulRH345lFXil9hMwPs=;
	b=nczYPxoxzi0hAmzMiR+bk6f5atECXXJNTW1eOl5RdcH9gwddSmgwhJu4/zFpwUll+sZkds
	1eFZrvdvAuHEr/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B47213A73;
	Tue, 29 Jul 2025 07:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dzncAEV3iGitJQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 07:24:53 +0000
Message-ID: <ac7add36-808d-4883-a09e-ef1bf6fd6834@suse.de>
Date: Tue, 29 Jul 2025 09:24:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de> <aId16W4EaqjANtKR@tiehlicka>
 <3e88642f-3914-42b0-b864-4ad374b659b5@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3e88642f-3914-42b0-b864-4ad374b659b5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4992321285
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 7/28/25 15:08, David Hildenbrand wrote:
> On 28.07.25 15:06, Michal Hocko wrote:
>> On Mon 28-07-25 11:37:46, Hannes Reinecke wrote:
>>> On 7/28/25 11:10, David Hildenbrand wrote:
>>> And to make matters worse, we have two competing user-space programs:
>>> - udev
>>> - daxctl
>>> neither of which is (or can be made) aware of each other.
>>> This leads to races and/or inconsistencies.
>>
>> Would it help if generic udev memory hotplug rule exclude anything that
>> is dax backed? Is there a way to check for that? Sorry if this is a
>> stupid question.
> Parsing /proc/iomem, it's indicated as "System RAM (kmem)".
> 
I would rather do it the other way round, and make daxctl aware of
udev. In the end, even 'daxctl' uses the sysfs interface to online
memory, which really is the territory of udev and can easily be
done via udev rules (for static configuration).

Note, we do a similar thing on s/390; the configuration tool there
just spits out udev rules.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

