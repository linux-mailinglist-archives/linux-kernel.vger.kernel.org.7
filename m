Return-Path: <linux-kernel+bounces-729433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B2B0368E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DC7174769
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC172218599;
	Mon, 14 Jul 2025 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvFCJCVp"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5545212B0A;
	Mon, 14 Jul 2025 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473442; cv=none; b=D+MRytEGYuws9f6JyAXzOB0BXrD8mVZvS513HOhaXGan95G+xp34MTpHXCS8UdDnyC24srgdF7HLuT068EsGPpZAi7OUqAlff6Fep0bQ0q5vUsE8Vm/F92WUjFqhS64rXu1NrwR22ygZ0hskrTqW70Kn49s2tAKKt6b0TN3ldHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473442; c=relaxed/simple;
	bh=OxdfKegVxkDsCSJxuxqy9dy98Eh56G3Q3AdnXUMLvkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfYknJBgvfr9TYt2zUTmUu/XJNUeHdor30pnZZMFgba6E/C1aibgJJmvdL+gfp04Wg3d3mbvT6JvlCkgBzIielFb25UmcySMu9FEx4NnH+/C9KBJaZd5OrqozVsuJGkVPX5a5CuXcaM/Fm8wDw7x01GkkBGwNjSZ393YiWEoLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvFCJCVp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c703c471dso40723115ad.0;
        Sun, 13 Jul 2025 23:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752473439; x=1753078239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfFqMeZyU9HS+WHoyGh+rEgFUDR1EqSVoqNyn1ejI2E=;
        b=KvFCJCVpXccq+jTr0ZW/6vJbJqehv3ThnJtnC8B1HOl3qD68m0tHJNyakooVOQMxzb
         kCd8s0EJ6+MV2d/ObGwLzA1OP1z3Neb1xmbMWech9dfxx3cuy6FzPt6z8crBmpovD8/V
         JSlW4CWQwU69cc7YQCDml3p5UCSbTivtizosvtxmLDfAaX7iIQIE6DTyQCzkLE1HBxdd
         MPfNXn+jrj+EEXD867wPzdI3PaEczzjydM1XFUtV7Ybdp170xsRUQHKlUHr9+fCFAp9z
         DWF4838wxF0Q52j+g/sbDweF38c7uyn6I0sS7f9GbhjlEsEwzS01lja8w9J/sNkF9Vig
         l72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473439; x=1753078239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfFqMeZyU9HS+WHoyGh+rEgFUDR1EqSVoqNyn1ejI2E=;
        b=a0qvym/Px9gExm68AdnOmZqP6NUjXEbwL4m/g96SQcwZTruleRR8t2uA41g7QYfGxE
         qqfgviByHogjIeTBAUYg5XB+cC75rSuLHTR1BixkDcZGUVtzhBwbM5h0XGXe7mUEKMlJ
         myqP0kju43DOAzd36wJ3FTlsMr5EahGnsMxccmSVQ8ACCjAp80ePTr13IgwIdRdOHTTD
         8XhAGKjwyiMaCmSPsD2tVf7i+gypOTGWWunywXffbE+vmZkz+Nxx7p0778TRQeezQ9kh
         c7bJy5AfIyxBbcY35eh+Dn+vVDjRMCB4II0fa/lzSbLisMKfRWxnC7u0K6LBrAu/vLHp
         VmDw==
X-Forwarded-Encrypted: i=1; AJvYcCX5I3nEzzQoYWiqTbToGObJULaoxafqoQXT/wXXk/rB52JI1dz9AaMBRjAEx9wZaGTItGfLtWtXkxNrpiY=@vger.kernel.org, AJvYcCXQrqHkMXpyMbnRAwZ+qKHOw9yjFLaMKYn379jk3Aj9r82Z1FDUH/P10CIihBOwg+bw04cW3M6BV1nKQOJ3bmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBtqUkeF3Zrx1s1rMBkdGl7hnzkyLhizgYT6z6i1K/n2JtSp3
	0A5DROooNH/egZmsEd2y3VZxt6XDg+n+CROpPuhKJ4VVYHS7HzEWNNXu
X-Gm-Gg: ASbGncus04rFPYnTfQ7odOIsjRb5V9e7ZyWUO+vpklDdpHgPn9Bk4+q3AgvxvSMoof0
	aG+5D3ZS9I2m3p3CbXIQelq2BV6elboNZNX3DzRM5CVrmb3X8YQwBLPSJ6Nc/apfXkF0keZ8pyt
	/iWt8cCAEzplKdyfc/rlqcWQDCeNAGp8JzhwB5j1s4jHWTdJ/zoH10y+l2gUPo56oDKM4smu++Q
	ZTYc0OGnL5uQyzN/vOxNq1i4uTcTzuhQHXmneiOKgZztmoxx1bJx+68t3MgLK+ApobhUWe7wfv5
	3bEZ5LMneSwLuvnjhCTt36YERHKh3ucnILx5fRU2p0lHM/x+e3pChCunNQdrkmLpyXqiD9gEuj+
	MHYruYu6wbQrOsR37Mwc4QB91xr4vGiHtriMGz1EppYmnowGA6urJcJ5Bx2pOxQ8ppHJV
X-Google-Smtp-Source: AGHT+IEh5rmOi9OTdgxMZ+ZYCCwxnVNNOCtSZ7HLSFh73cHwYUInliH9Wmy7ojp7o6gQDl2FOpbi5w==
X-Received: by 2002:a17:902:f606:b0:23c:6d5e:db4e with SMTP id d9443c01a7336-23de2f47919mr267449435ad.8.1752473438744;
        Sun, 13 Jul 2025 23:10:38 -0700 (PDT)
Received: from ?IPV6:2001:569:514a:9100:3f23:7b0f:f6a2:1ebd? ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43655fbsm83226305ad.239.2025.07.13.23.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 23:10:38 -0700 (PDT)
Message-ID: <cda61d51-ad85-4464-a637-426b960a83c6@gmail.com>
Date: Sun, 13 Jul 2025 23:10:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: define named constants for magic numbers
To: Alexandre Courbot <acourbot@nvidia.com>, dakr@kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250713025108.9364-2-krakow20@gmail.com>
 <20250713025108.9364-4-krakow20@gmail.com>
 <DBBG6Q86XAAQ.43DPC0D210TI@nvidia.com>
Content-Language: en-US
From: Rhys Lloyd <krakow20@gmail.com>
In-Reply-To: <DBBG6Q86XAAQ.43DPC0D210TI@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/25 8:11 PM, Alexandre Courbot wrote:
> On Sun Jul 13, 2025 at 11:51 AM JST, Rhys Lloyd wrote:
>> Introduce an associated constant `MIN_LEN` for each struct that checks
>> the length of the input data in its constructor against a magic number.
>>
>> Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
> As I mentioned in [1], I think this would be better addressed by working
> in terms of `sizeof` upon the relevant structures, after making them
> `#[repr(C)]`. It might require splitting them a bit since some contain
> other data (or we can maybe turn them into DSTs).
>
> [1] https://lore.kernel.org/rust-for-linux/DB97X8JAJFI4.3G1I8ZPC1MWLS@nvidia.com/

As far as I can tell, only one of the five structs with `MIN_LEN` have 
the same layout in-memory as they do in the `data` byte slice, that 
being `BitHeader`.  Perhaps `#[repr(packed)]` could be used for 
`PmuLookupTableEntry`, sacrificing alignment, but that is undesirable as 
it comes with its own footguns such as unaligned loads.  The other 
structs include optional values and vectors which do not have the same 
encoding when reading from the `data` byte slice as they do in memory.  
I have worked with DSTs before, but I don't recommend them for 
non-library code since they are not first-class citizens in Rust.  
Notably the fat pointer is not resized when taking a reference to the 
unsized struct field, and constructing such objects is cumbersome.  
Also, in the current version of Rust (1.88), DSTs cannot yet live 
comfortably on the stack.

This patch can be dropped if it's not valuable enough to warrant the 
change, I only made it because of your comment here: 
https://gitlab.freedesktop.org/drm/nova/-/merge_requests/4#note_2999761


