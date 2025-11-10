Return-Path: <linux-kernel+bounces-892743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4BBC45B90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2816318905FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAAA30149E;
	Mon, 10 Nov 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V81ddc2q"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874453002DE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768134; cv=none; b=AcTLaD5LIBnM/WWIq+eoK7729Fk7fOWopcGcd4jGTFb3lJWk5L2qYxmYeEmFBVtyIZVRe1awWnGe/QvEvb4tdQ8NuqApbDyXYU4T+QddX1eu4+aM7qqDa7dMITTTOfVIv8XODUY5aQGmoaxqBTEt3cqBZTN2p74OGJoKbEUyQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768134; c=relaxed/simple;
	bh=bw6QasuA8KeZgfQP2n/F9NjjLOI9T9u407i64LyA4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xigh1dAdDdWj8s5fM7ykUATd7hbiVEvclUXU7IBTqZVFP5daJqTknOWmDPWblMHNd9gpD8KbWjrOBChL1/HsIK3YJ84h9/28RQ+eVrM6EQs/iO0sVANqgCFS+HWSvJ1LSrDTTIwOblQfGYjMToEoObs/Ynl3ci4KsZlkOSPpOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V81ddc2q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso1936941a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762768131; x=1763372931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhIrfg+ZeGmHHXgRYjIXkWVaO+GMicaDEEBop0R1M78=;
        b=V81ddc2qxiRyTqCzgFZIZ8VateSKEepBtEeHhkhJRYWMIbeNYZtFKGbBfmQ+kNJ0pI
         vfNoGO48VVKoZ5p+wto6BQkLMwI2mTUSN8T7kxqunTPoqV/HC0Hx++AKHY0IH8ZVfl4F
         3awoP5efGFN3YTdaHQqNUWIOJmOWKOSzxOxdc8RTRLl1/77eBYm6ABRef9wt5wLEAsYw
         jjV1sGafv1NRMsjYslQd7nNppLaKavP+rmQuOzOLXsLkh3kVhWVB+xV1HUEi5DEcqg3O
         EJ9I1bsTi3H7OXjiVoB/7rEdyRqdI8zCFB3DIuwY18qR4tGbNPvNeaCxxg9he4UZFy56
         Enfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768131; x=1763372931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhIrfg+ZeGmHHXgRYjIXkWVaO+GMicaDEEBop0R1M78=;
        b=KG7eI1+jukbv9JFx9boj8bydoQgj74nu/Dc0G2XMuws5TUOj+r1faHukc1raxVYmEB
         coCjSy8GHuCR7pYIoU/UL44xtbxLrHEUQmEWGT+GvEOP+V90o0yzTBqfcSOn1ZlyyPef
         julrWFla6iRuvGBwcTwtEaSrT5g5YDZiPMmcLO0fUwzvsCGVwaW4+k9TqdfFojXAr4db
         XoWlLo6q9n2IHKVHWEbDhbEnlmHw7vm5yoCD9Bm0dizlUGGC2efJMrH/RcrlZQB0fBy1
         buV3imB7Lcpu/tm0ShEnjhQtPyi+jybX2WbTYFZbQbFAHEIisuKh9Galmi+yih+8lsG/
         jsDw==
X-Forwarded-Encrypted: i=1; AJvYcCVkm5Ajy8AjH1HZr5cwlqhVcPREonxAp/xsNnFgqBHWICyswYsRPX9dp3CaNr8phPWHCdDpYH6aMvrPFT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6rY1dyLRmMY8OUzARxPxo5NfVnWz1LUITyqgf6Y1zeeNZbBa
	iiokZLf4nrxk+3kuyEKS2UJmmR+DhMFHPNObcb8nIKQ9aIPbF+LIarhrb3M66fVvpJ4=
X-Gm-Gg: ASbGnct0RgIHIY2PkVeJeVxSQnK9W5Z/gXGM8kYf35oo8IsAta0+07BWTh7+fGq9ZDl
	RVVyRIezpB71QQ3HyezbKpgh7wvQHUR+ni3H5O6unZaPntfS0SF0K5CoKJX9g/0s76KeVmDkhHQ
	K0UwA3BRFSAll7zDNgn2kLX9OmBXEIS3362lnvJjsZKWrGdcFyt3hzpBsWDGDNS8qVa54d7jazG
	swJFrc8/4E3cMH+XmiJpUBjt/zgNlXDOSiKIU6Sahw8Ss59w7zzmP1looQ/G7meihz87h19x0QB
	uE28Zc8dYT+v/p6ylfXab8e7MmHmS7vAZ6/KvGiBIVAB/meQhgYmfqrTp3Myacya0A1Dl1BYoM9
	qe6E1RpN36AmuhXprpjS8eX61Q3KwtIvGs4HI560nhajiSSUWVcW0vDRCgN7dmTZOHJ8rWn6sk2
	OHsARwk5V1xtl83XJ561RTplbD
X-Google-Smtp-Source: AGHT+IFxQkylFq2Crr8V5DsL5/o3I3bsVnjZJeM/h5I99Cls23cajzpMg5CawHlhDUEoe8P5BasDOg==
X-Received: by 2002:a05:6402:50cf:b0:640:da69:334c with SMTP id 4fb4d7f45d1cf-6415e80fc71mr5848770a12.35.1762768130923;
        Mon, 10 Nov 2025 01:48:50 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm10864916a12.14.2025.11.10.01.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:48:50 -0800 (PST)
Date: Mon, 10 Nov 2025 10:48:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
Message-ID: <aRG1AX0tQjAJU6lT@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-13-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-13-roman.gushchin@linux.dev>

On Mon 27-10-25 16:22:06, Roman Gushchin wrote:
> Add a PSI struct ops test.
> 
> The test creates a cgroup with two child sub-cgroups, sets up
> memory.high for one of those and puts there a memory hungry
> process (initially frozen).
> 
> Then it creates 2 PSI triggers from within a init() BPF callback and
> attaches them to these cgroups.  Then it deletes the first cgroup,
> creates another one and runs the memory hungry task. From the cgroup
> creation callback the test is creating another trigger.
> 
> The memory hungry task is creating a high memory pressure in one
> memory cgroup, which triggers a PSI event. The PSI BPF handler
> declares a memcg oom in the corresponding cgroup. Finally the checks
> that both handle_cgroup_free() and handle_psi_event() handlers were
> executed, the correct process was killed and oom counters were
> updated.

I might be just dense but what is behind that deleted cgroup
(deleted_cgroup_id etc) dance?

-- 
Michal Hocko
SUSE Labs

