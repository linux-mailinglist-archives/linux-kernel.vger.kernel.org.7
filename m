Return-Path: <linux-kernel+bounces-838913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC1CBB0698
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C93774E1081
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C48221DB9;
	Wed,  1 Oct 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se7Sz0lV"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD2203706
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323932; cv=none; b=DkSNY13Oq8GSxZkXj93n40ZCKpwjC5nWY8NYueDmyWQ5OIX2W8tk27+pOi8af6qOh2m7+XgzTy6ZiqotRh66xoSniv8jDE54W80r+NhpCfvtYRjdNEj2kVKLjJuh3VZaPcR+kVocB+gJGpf9dRGDJhk5DQWNUhikREoDMhschb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323932; c=relaxed/simple;
	bh=jBmuWH0YUH02uvaUnpyESyNBWMLetO9tuvs3IcDBVZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5J71BwfPZN2is5hdvy835WtQ0lUqaYFMJWAjC1YNEgyoLJ3pUJ+8oAbF7O3C42oCAq+oK0mcACZS1CPSL6GzCKBv7NCNXznKDIokhce6yh1lWP0acWdNLL4iXROLFNsrS/xY4zXVraOIH72kDlwFShb6qSIf5F1XdYl3r9RPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se7Sz0lV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b550db23c9eso828063a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759323930; x=1759928730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OW6l6wKrmChiKbh7o74M96nQdgGsULiYNKDhud2+Lm0=;
        b=Se7Sz0lVmzUHFL7SsLjlQGxP0QJykPNzaNC0heYDRZkQHijNIQeJm8ud/pKzvfPwvy
         s6HOgrWLdXNNJmEjRTrA8cbq0eMzo9kXgmye38cuuxlEtpzulRQGZflPMn3dXl8KEyb/
         w5RzSPChuKTODquLAL6bAXpm433q6Ffi/X5v8czctQ7TjgLTr54mrlWNQ/DLJKmI9Y0k
         ogxI2rlwLCyshPXOHrP/I8wPezbT2E+okvex62ukiYTqb20lrnLcVPJroRox8T8nDO3Q
         2cbKRBF/mpBdpGOBxMWqLBf6feE7iJ0lJg1lQcUEBqNS4r5q4eqzdNcUe2e69BSlNj69
         n6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759323930; x=1759928730;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OW6l6wKrmChiKbh7o74M96nQdgGsULiYNKDhud2+Lm0=;
        b=s1wT8oqq+Rv2pZyyuqrd92GB6o8YTRTCPAiWTTZZAPtImoIgjzMO8NbndjPicpRkn7
         DcEMrmjWjWs6aa+6aV2PhvN3YAw/ek8eEebQ5F/BonwIt4925nvsL43sip1CwhPv/Fd7
         8hZ9TQyU4JH2D4jjFwATh15Bc8PtIK6tj7X97Cbmz0fr2Ig8jNa6qg6sKkjhpg4WN+78
         vkgW33l1jLK6AhpcqkkzEq2Om9o+dzcreFy/SBsuUuK95+/Bv2oi/sbuZJbqraY9tp9f
         cYcD0NWlPT25VGn3lNnjckRZzqllSIZiQmS+mCtU4zGdKLzXBfXM1KlvQ+dXTeov4cCc
         UCdw==
X-Forwarded-Encrypted: i=1; AJvYcCVpA8DUXRffHjnbH5vjauoIYx1+2Cv+gCqV/slsVKRNqiTwo4Qr8SR59nsoegVDJnLYA95Xt6Fia+aLo9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuhE2SeNzxRS9eTgi2Atn1WrJ4QUlAtzDvvM9+3Jp5G4nwq+1
	SvnGXl+9CWyQFGyk7s35LU4fSUeb/YONxfSPqF1g5PVsf35SXx+uxpsv
X-Gm-Gg: ASbGncsLmK1GoCUyGAKIVqVQXHfJLFSy2FknJ/iQ3sHb4H9WNuK6scsWQYR1One9oDc
	w4AQgMu5ujYgWLf/Xy/bHHZNvyjPSBb73hM2HxmtlXqmNgJW1YP+HhiHncdc0dkyHrnBPRKuoDj
	8Hyj8mXcCq5b0lehHq4x3ab7/LxrcX8xekLw6vn7cOLXNgE4gik6Shw0nUCKrpsXEDAR6+dxsTs
	RG30EDwC9n/SCjEF54+mOeFrOzjTFBJqYmmw7FTiEZYcsBPvc7BiSyqmA4TuDhtbL7lSfrLKai5
	nR4YfWPdTDPj4J0PvO+1hwVjJmrAMTZ7OO9FH57yKyhs7+QAAR3MkzRXV4Tif87A2p5eTNAbQrc
	QRyHbWFp2Sf69UBFZ67gGbnHCGTC+hjN+yOMsnc7udEssFUZ2GfdaZMuj4wAqvkDAUEfSPc0qBP
	DKbqW8ewDw/EJVorHNKKY=
X-Google-Smtp-Source: AGHT+IHoa5xa4f1XTAIYI78HgS2grI+zOJxKw/L/F6af+N9ErpstXh/VbzIlNsFq6puzwXgpQewq9A==
X-Received: by 2002:a05:6a21:32a0:b0:2e3:a914:aabe with SMTP id adf61e73a8af0-321d882a178mr2574832637.2.1759323929715;
        Wed, 01 Oct 2025 06:05:29 -0700 (PDT)
Received: from [172.20.45.103] (S0106a85e45f3df00.vc.shawcable.net. [174.7.235.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c557500dsm16012934a12.34.2025.10.01.06.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:05:29 -0700 (PDT)
Message-ID: <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
Date: Wed, 1 Oct 2025 06:05:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
From: Kyle Sanderson <kyle.leet@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, axboe@kernel.dk
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com,
 gjoyce@ibm.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
Content-Language: en-CA
In-Reply-To: <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/2025 10:20 PM, Kyle Sanderson wrote:
> On 7/30/2025 12:46 AM, Nilay Shroff wrote:
>> To address this, move all sched_tags allocations and deallocations 
>> outside
>> of both the ->elevator_lock and the ->freeze_lock.
> 
> Hi Nilay,
> 
> I am coming off of a 36 hour travel stint, and 6.16.7 (I do not have 
> that log, and it mightily messed up my xfs root requiring offline 
> repair), 6.16.9, and 6.17.0 simply do not boot on my system. After 
> unlocking with LUKS I get this panic consistently and immediately, and I 
> believe this is the problematic commit which was unfortunately carried 
> to the previous and current stable. I am using this udev rule: 
> `ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", ATTR{queue/ 
> scheduler}="bfq"`

Hi Greg,

Slept for a couple hours. This appears to be well known in block (the 
fix is in the 6.18 pull) that it is causing panics on stable, and didn't 
make it back to 6.17 past the initial merge window (as well as 6.16).

Presumably adjusting the request depth isn't common (if this is indeed 
the problem)?

I also have ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", 
ATTR{queue/nr_requests}="1024" as a udev rule.

Jens, is this the only patch from August that is needed to fix this panic?

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409

Kyle.

https://lore.kernel.org/all/37087b24-24f7-46a9-95c4-2a2f3dced09b@niklasfi.de/

https://lore.kernel.org/all/175710207227.395498.3249940818566938241.b4-ty@kernel.dk/


