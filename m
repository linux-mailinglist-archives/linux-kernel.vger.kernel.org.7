Return-Path: <linux-kernel+bounces-758456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF9B1CF6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164E9627C07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A793D21C179;
	Wed,  6 Aug 2025 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hc7JZeXO"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D34B230BCC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523459; cv=none; b=FwPonaQAhO67xpLTOXJQRhqUmrjQUBTI9OzqE2HO9w6ADZoXns+OrF/MNjxzi7+Jr9bg2LA+1NSWFJay+kuG2eAUJtanThPm16kkbEq7GyjvDzO2zhjKixbAjh9utNRQkCx+XZQbeV5DDviCN8bwkGV4L0HLH/BKMWNjNu53ocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523459; c=relaxed/simple;
	bh=Uf9dtk59gFzJjlH8ShXanMDOj+0+ZVxzHKwT8GoMWBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0uoofSovdAKkbDmjDSpGsh5wNX0JrCtckT0/JhoJLVjZ84G/9dt9Kex1I9FPfj+ujYVA3yQGQ82HwbQ46mBdY/zHwrJF0wxTOgyw8NX4WbYhk6L9A4OnP0mTa8SNzFIM84CEF/5F6k2MUYtcaC6rMcrqOqnmYOb8uQjuS4d1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hc7JZeXO; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e3ea9e8154so1731305ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754523456; x=1755128256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uw+3hQa1gfaYBGKUs7YEQ5o4Ob+RRHGwFhvrqOMiO6I=;
        b=hc7JZeXOMuwSTkXWpfDbfnEeLmiZCuCGH0yqIUjOnukaYjVUka1zWX8zv8tNFqkkyN
         25l8hWYsBHEmNiyFfntj1MGlDLUGu1z+gpD0h+PxvdqhzPMRNzqdtDKTV7sLEd86jYgT
         2xSjrI3J3wnulQWwzse5X4KV4gysAnWA4kQ8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754523456; x=1755128256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uw+3hQa1gfaYBGKUs7YEQ5o4Ob+RRHGwFhvrqOMiO6I=;
        b=YYeYAWw0odBf4RveFzDuhEpSgGw3doaE2J/sv50SRVksTEl7mV0pHX+IoHgLF80qP8
         xIPFad3+zF0Yp2fM+CJz2crD+KVI0a3QDhqgRvzxN9FPobhudPXLGv4+EW6kd553g35w
         F6uIqdW9U/ftK03HklOYo0AN3NYMgho08w9Rmtl9SOIEPmjdJv0gbacYUa5u7r1FKwhB
         OgHo0qcu2aIBuqpqyjBjH3uu1I4VUs2Ls7AXZsUh7zU0gR+r20Ywv8rsAhAYuc6Aq7qe
         wZfB0m8kiBkPZKCG1z3am1pOzHR3m/zYRLy66ey+0aG2//2XUveOC3htt7j8QTQa55qG
         Y9pA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ai5GZUtQ6ITQKA8aPO8q4KyE3zXiCMZcglCu2vkk/JNWjFZyML3xsE2CSt+v3yLbmAN8NEbrDpYNQo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwdpfvIXgloz8QdSUuilNCN8vLjVWGLQzeukrloSCHA9XLiRT
	+ibzkwPR6EzTmrgnyDc3KxGs6I2YYaVKjv63LmMKo/NDEarB3eeIMkft3RONa5mjMnEetwBc9ye
	Y2qLt
X-Gm-Gg: ASbGncsLUIFgUmnsezO2iJ8w0b2BjRfkEvAdH/FsRE0acRViMNFHNsQqrGpH1Reicnp
	OAY81JPL8T4IeoTDqP7gHcDKAbKZEvq1sZnhxxH7f5ntr+HqATkQH2QEEgxfvxipFO6/FWQRXeV
	EkaOVe974Lvn2HVHcFFiH1N5AZwxB/LhcSGfOQiCu/I1xVZ7XI7syxNjAW5SX4ezn82IlA/jPsB
	3mIci62srcbv4AK7lAJLNGwyhpTC2u0mvQw/mXiIl7NqOC3mSAjLE4KXpZQHlLR/b3WCCuFekps
	3gDsDdWOivKgGF3o2VBRAgS7IqFKFZHtnS5DN+evopMetLAKE1iCuWxvt1PijYiBtcPCN53TiAc
	5Dx1G1rsUiRky7ye9fHxFM9AGmF7JDVuDdMhkVN7k1bwExlfQM3CV8EU=
X-Google-Smtp-Source: AGHT+IGqqJVTA2htapTaUHkMpzxdklgfTGVquWo2AJSzNnJfbuGn+Zh7vo/Di0EaQuQx1JtIkMQcKQ==
X-Received: by 2002:a92:cdac:0:b0:3e3:f67a:7dfb with SMTP id e9e14a558f8ab-3e51b882074mr75481485ab.4.1754523456246;
        Wed, 06 Aug 2025 16:37:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e4029a1553sm66302015ab.14.2025.08.06.16.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 16:37:35 -0700 (PDT)
Message-ID: <b89a0377-2a1c-418f-a897-966cf1cd4789@linuxfoundation.org>
Date: Wed, 6 Aug 2025 17:37:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: repair mangled powercap comment
To: cryolitia@uniontech.com, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wangyuli@uniontech.com, Guanwentao@uniontech.com, Zhanjun@uniontech.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250806-mangled_cpupower-v1-1-1a559130326b@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250806-mangled_cpupower-v1-1-1a559130326b@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 01:08, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> The current comment exhibits clear patch application artifacts:
> 1. A stray '-' prefix indicating failed line removal
> 2. Broken sentence structure from improper context patching
> 
> What appears to be version control residue has persisted since its
> initial introduction and through the 2022 kernel submission[1]. While
> my archaeological efforts only trace back to the 2017 openSUSE patch[2],
> the corrupted syntax suggests even older origins that remain elusive -
> perhaps maintainers with longer institutional memory could shed light
> on its provenance.
> 
> Restore grammatical sanity by:
> - Removing the redundant second line with its leading '-'
> - Preserving only the primary statement about RAPL hardcoding
> - Eliminating the fragmented "should show up" clause
> 
> The result reflects reality without speculative future-proofing.
> 
> 1. https://lore.kernel.org/all/20221123111810.16017-2-trenn@suse.de/
> 2. https://build.opensuse.org/request/show/535512

Lots of information for a simple comment spacing change.
What are we fixing here? What happens if we don't fix it?

thanks,
-- Shuah

