Return-Path: <linux-kernel+bounces-853506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9ABDBDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5C2192843F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B703347DD;
	Wed, 15 Oct 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVdbzEPf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08944A08
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486732; cv=none; b=Lc7HSFbuw19SzSL6/qVL6F+S3wGN9A/4r1SSmae8KjyzUabgQmWWtu2RLegDxprkskEeEKTOBUobPTtmcdYimpZqyzddyWb0Qt+kAzlTQ6h0CMk+jE6x1NU/+W7Q/V5JcTSeFtxlDeFIzMC8RWb1KHXFrHJQR6RJqy4MP1JTY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486732; c=relaxed/simple;
	bh=bhnzTueuY9Gq7RbeymuowpcCUw7aDx4IVKdkM/S0EJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jz9+e6i+cqeSVs7ftfQdsfWmn/gy6Ul3InT1DCIKJ+o3tZWxmBrvClP7lAajs6dGMnH4VZoQJXNJQWHPVDJqk+SyojbyQTkS5Rrqxcrhd5e5QroYSJmW5LARBhTWgiEf67ER/n7hFuNiD6BOD9DjyoqQYp9L3rMLQ+5IT08kBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVdbzEPf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26c209802c0so58751595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760486730; x=1761091530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLMiaX+vGO2HaVidLde0Mqzeld2XbAlMOu6TCSUhVYg=;
        b=DVdbzEPfR8oPa8wp19Vt55fFpqpHac2QakEIjwKe+Q8Lh9lPo+k9e6du8vrsB5Btx+
         Zai7dz4U+wGfjMkzXHM+HFPDv0rd4D2S4a1vX/VDfay+eXiV0mVi0sj78vRtO4PQLqdB
         skiVzI7wwBqJ5f4CVVrI9NT2XhZM66X/cOYPXWp6R8+kzR89/eUABhZjklr3XFjvbiA9
         521F2LdCkhdmpmuRskSbSMTlveIeVf94kiMncJOnq3lhpkkmK3twiTIj5r1sMM+4ZwZS
         7/noZVrXEo5x6CcI69mrDqOxEOU/pxWmqIjhBF0Uf/R8XUVBObN2c2MTuYwgroFQZl53
         yN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486730; x=1761091530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLMiaX+vGO2HaVidLde0Mqzeld2XbAlMOu6TCSUhVYg=;
        b=m0recxk4ylRpqFNK9t5tf3Ufmzzr6MA2fyRXi0Jka3EcaV5/WVmHeC6Fm1PafF1rJW
         FWmm6c1tSs3P4I3tV5KNFooWUfwYNd0ZJDLRra3fIoszNoe7zGY72ISL7TXLwNguIHKO
         Ztm0SlIfdClsBN3l1cADRvO/g/Z2zUD7vQhx6xv2N2evbihE5Us1vB8VS2yeBO4qXpdn
         eWf0oAlBAVedVGDQ8FQt1baE5SUljaDKudvLigiXL7KijccrEMyFVO2r8W6Bjw1vQCmo
         5St6q03KOOBwLvvCGpc5PuywAmIS8KTYcbDjFWcYh0fz3KPlXqz7/3DnpYbBFjds9srk
         IrzQ==
X-Gm-Message-State: AOJu0YxTNoFcRq8fByBPDm04Jk44Vy7fO9iz+Qw2jm0XXwsOX7PImt2X
	eXFoh0HCwuAPj3+7ogDQSGTfpvQmykvCxU+5EuRI8u3X3XIpROcDF9GC
X-Gm-Gg: ASbGncvKbhWijjHlDdCAi5QRZKJP/KJgJ/2JZDc3h5ND1qZspvjbIl4R7yCJvlYIyab
	/A0ceBD9/W7+wqpIsTktNSRp+VfpL5J6HH37zhnEyB0L+LlM1sCSSZl1lPhTwFI3+M6bz38QSYZ
	pT4C9tcuNKRtLfgugAEeoCP90Al7d+yj4fsWlhYB4k1z2EWnwBqu0haAjuFSF3syK75y4HjiA4+
	keX/kFWIjPhcGUOsMTlyvHy8RXzLdCeB81RMxR8fNV8zVq66poS+gn16b6YMWTqZ3v156jpFuL4
	f3pEpWuIcMXkiQKWGG49nXKfK5o+M7Woupvst9D5IDPGLhem8apVCebyBK2QO9KJp+7IvKlTSQT
	ZNvesApraLNkB8ZPOxTDeQ/8biLGautcRA0/KZ9lIlEywGMPFxRGcSzisWWoYAhODOTkR9Q7zl6
	kppefl7yjOltr1mU+graoTeQ==
X-Google-Smtp-Source: AGHT+IEmH0JRxtSGkPWZTbk0rg2sw6ciOa1Kwmx4Jh+5sWSakKPuSbl1aN4xzbqjjVDaexMRPuJucg==
X-Received: by 2002:a17:903:fa7:b0:275:f156:965c with SMTP id d9443c01a7336-2902741e441mr320016835ad.52.1760486730094;
        Tue, 14 Oct 2025 17:05:30 -0700 (PDT)
Received: from [10.130.1.37] ([118.200.221.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290766cc2a1sm42161035ad.95.2025.10.14.17.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 17:05:29 -0700 (PDT)
Message-ID: <0791edfb-6985-45d7-bb3e-08ab7a341dab@gmail.com>
Date: Wed, 15 Oct 2025 08:05:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, dsterba@suse.cz,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014182414.GD13776@twin.jikos.cz>
 <6982bc0a-bb12-458a-bb8c-890c363ba807@suse.com>
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <6982bc0a-bb12-458a-bb8c-890c363ba807@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15-Oct-25 5:08 AM, Qu Wenruo wrote:
> 
> 
> 在 2025/10/15 04:54, David Sterba 写道:
>> On Mon, Oct 13, 2025 at 10:57:06PM -0300, André Almeida wrote:
>>> Hi everyone,
>>>
>>> When using overlayfs with the mount option index=on, the first time a 
>>> directory is
>>> used as upper dir, overlayfs stores in a xattr "overlay.origin" the 
>>> UUID of the
>>> filesystem being used in the layers. If the upper dir is reused, 
>>> overlayfs
>>> refuses to mount for a different filesystem, by comparing the UUID 
>>> with what's
>>> stored at overlay.origin, and it fails with "failed to verify upper 
>>> root origin"
>>> on dmesg. Remounting with the very same fs is supported and works fine.
>>>
>>> However, btrfs mounts may have volatiles UUIDs. When mounting the 
>>> exact same
>>> disk image with btrfs, a random UUID is assigned for the following 
>>> disks each
>>> time they are mounted, stored at temp_fsid and used across the kernel 
>>> as the
>>> disk UUID. `btrfs filesystem show` presents that. Calling statfs() 
>>> however shows
>>> the original (and duplicated) UUID for all disks.
>>>
>>> This feature doesn't work well with overlayfs with index=on, as when 
>>> the image
>>> is mounted a second time, will get a different UUID and ovl will 
>>> refuse to
>>> mount, breaking the user expectation that using the same image should 
>>> work. A
>>> small script can be find in the end of this cover letter that 
>>> illustrates this.
>>>
>>> >From this, I can think of some options:
>>>
>>> - Use statfs() internally to always get the fsid, that is persistent. 
>>> The patch
>>> here illustrates that approach, but doesn't fully implement it.
>>> - Create a new sb op, called get_uuid() so the filesystem returns what's
>>> appropriated.
>>> - Have a workaround in ovl for btrfs.
>>> - Document this as unsupported, and userland needs to erase 
>>> overlay.origin each
>>> time it wants to remount.
>>> - If ovl detects that temp_fsid and index are being used at the same 
>>> time,
>>> refuses to mount.
>>>
>>> I'm not sure which one would be better here, so I would like to hear 
>>> some ideas
>>> on this.
>>
>> I haven't looked deeper if there's a workable solution, but the feature
>> combination should be refused. I don't think this will affect many
>> users.
>>
> 
> I believe the root problem is that we're not fully implementing the 
> proper handling just like other single-device fses.
> 
> We do not use on-disk flags which means at least one fsid is registered 
> into btrfs, thus we have to use different temp-fsid.
> 
> If fully single-device feature flag is properly implemented, we should 
> be able to return the same uuid without extra hacks thus solve the problem.

I had looked into this some time ago. Some libs, like libblkid,
don't handle multi-device filesystems or cloned devices with
temp FSIDs very well. I'm aware of it.

I've been making some progress on fixing those cases, but it's
a bit extensive since we first need enough test coverage,
and recent reappear-device inline with that.

Let's see how we can support use cases with identical devices
(where changing the UUID isn't an option) and keep things
compatible with systemd and library tools.


