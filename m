Return-Path: <linux-kernel+bounces-825491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8BB8BF1C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 06:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEC41BC2E15
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2531B7F4;
	Sat, 20 Sep 2025 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLuGppCK"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F819D093
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758342689; cv=none; b=mywVSxrDq1TWqVxFucsqebnQjUfUBIR1KqTLU1SHRj+/HxhrHZ+OSdPlW/w90uao4B7sJbIovLOYsAhrYWjZiMqHwcIbEv1KKPVaLYlhTQG5H7I4uZu9c6H6n9yBErEuyWuzSfL2GxqdAEoBbjVDPGsIDFtGQRFI93X1bxR15Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758342689; c=relaxed/simple;
	bh=kAny4aRymFDIo+7FPT/ml2qL4nKq50MkuxSYtUo1xdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rg22D1iwgULKE7/zrT7Cva6jlGvJfiK6gpSnCRpw8bVQSL4vYa/FFEBJiU8vL5z+W4kMwNNg35+0QQxJy00UFla2A5dUj+0aNxH5p1bRg2Fq9EEOnXPJIaBX9rdFHMqlYe5OPeaFwRmKae2lKeMsxgYZMZP/gycviaGCS8h+0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLuGppCK; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42487ec747eso10717595ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758342686; x=1758947486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAMf/yo/OOBBY5X1PTbs08x/sucOGtYlA3nCLcNTs+g=;
        b=fLuGppCK4DAjqW2augM3XZ8Si1RMcFrTAkhTtUvRhH0k/DXAIsFNsnQe33qYOjkDng
         nNwrfJWpcAk++ei1tdRu0b/xa/dqgXyvawOXT8SsK/3ZzsRHv1grK/yp2oAR8fVcAXwR
         aPLMAYcsE04tGb7zBj/O6Qr417zM0P4kI/UM02G3avJZ5HQDfbHVXmexAcnnqoce6IS2
         9FBhY/pEVVjVVg5xdbQ9mKV3F8F4pQOU6bNtMts9IsOZfNrtNgB2MR2fO9OUWzHlSwGv
         rXbKeVem2CeEgaM0ME0xcM9hP7hYEEqA6iIC8ZpUfEdjXSYAS+7rUZe5/gatEBHDMS+Y
         mUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758342686; x=1758947486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAMf/yo/OOBBY5X1PTbs08x/sucOGtYlA3nCLcNTs+g=;
        b=h8h433tyc7TYjBulZF80Wi0wm0rF2dxy+4G5eRX71JzEA1gs6cUPXi2z4T7K2huUuV
         XBMQsMNjXkQln8jrYweKblpEILMe9D5kisC54wd3GYvzNwtEWJMMUEo9jFnI4gjbVf8c
         8gF72pUTJJSL7WiJoGAtbud/mliPihm+pzSC6iddFjwR2p0vG6KLuU3rD90oLRPg2NKs
         0v9jmPlkWOrXloAMEMZaZEk4J5QaL09/IvBH0tZ+5FB4cUllSy6me/8eMYpzfvO+7qYa
         nRl01a470Oj87de+l1ykdNnvYwTkV96rXbHCpfd6b7MaBAYQJ6SA7CBZKoXjN6BFKsTn
         Hhhg==
X-Forwarded-Encrypted: i=1; AJvYcCWEEKzCcmPNiY0vVbhlm04bb32ZmusVU13eqzJv+32O9xTyF+FXxUtlCVVIDQB8PueMxXGp+CZgvyWnw8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mU8i+tLDnqfeqCG4Z2Ji7q1PERSfrqmOT2i28DW/DlVt73iw
	6uCmnKYVse3zcJ95qoY4BpfXxe5aU1v+ctDVdnou4VTuTVbDduq6CoE6
X-Gm-Gg: ASbGncsmwOhrR4TwMI8ADtWb3xxSrv6y3lFTeFDPh8DvE7pBvalpISuWUS499nptV9B
	VFLYXfd3TrGL+dZ0vV2yWKcTYEFmGlrkgrrTtIQMPA9bakch+/MS7lcqBaVg/EhUQ069Ruip/Ni
	8ZH9DPn83wPjy2yO8RvSPMxtRuFzJAgDEiwfzbWtNiqAVcsi2pQ528gpHBgOcb/YDHTAuXKdYk9
	Jmnq29FJOshxe3LUbTQ0yP8HJNUaEKVhyzgUjaQfGnL7oNhBNhUX8krJmDdqj2VwjvNQsXyvdKe
	ab4tlQeKW9IlqgbG3VkuLvZOJdJmyONBvt0Sp4Dufzkv7pw7U3wh3D4+6s89MSePaurBvUkcKV0
	xqgO3ARMCRqnscr17co7a2ocfbRVHhKsm3TKFYA==
X-Google-Smtp-Source: AGHT+IFcG4QqJ4nlgO3oq0I1YnwOZ/K7SIrMHUnkDcvBmlrkEhfFU8B8mZqzq5hu5cnZ8bWVDrbaVA==
X-Received: by 2002:a05:6e02:156b:b0:424:30f:8e7c with SMTP id e9e14a558f8ab-42481909f5emr98881625ab.10.1758342686244;
        Fri, 19 Sep 2025 21:31:26 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-53d56e429f3sm2997444173.74.2025.09.19.21.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 21:31:24 -0700 (PDT)
Message-ID: <73885a08-f255-4638-8a53-f136537f4b4c@gmail.com>
Date: Fri, 19 Sep 2025 23:31:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] hide ->i_state behind accessors
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com,
 amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-unionfs@vger.kernel.org
References: <20250919154905.2592318-1-mjguzik@gmail.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20250919154905.2592318-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 10:49 AM, Mateusz Guzik wrote:
> This is generated against:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries
> 
> First commit message quoted verbatim with rationable + API:
> 
> [quote]
> Open-coded accesses prevent asserting they are done correctly. One
> obvious aspect is locking, but significantly more can checked. For
> example it can be detected when the code is clearing flags which are
> already missing, or is setting flags when it is illegal (e.g., I_FREEING
> when ->i_count > 0).
> 
> Given the late stage of the release cycle this patchset only aims to
> hide access, it does not provide any of the checks.
> 
> Consumers can be trivially converted. Suppose flags I_A and I_B are to
> be handled, then:
> 
> state = inode->i_state  	=> state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B) 	=> inode_state_add(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B) 	=> inode_state_del(inode, I_A | I_B)
> inode->i_state = I_A | I_B	=> inode_state_set(inode, I_A | I_B)
> [/quote]

Drive-by bikeshedding: s/set/replace/g

"replace" removes ambiguity with the concept of setting a bit ( |= ). An
alternative would be "set_only".


