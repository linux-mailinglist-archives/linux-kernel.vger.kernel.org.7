Return-Path: <linux-kernel+bounces-852677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE0BD9A34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EBD1890F71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D63191AD;
	Tue, 14 Oct 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YZlnoWAg"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E283176FD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447272; cv=none; b=ZinCEACmuD7CBg18sRYMSsa2w+TlSC6m8ds71bqh9o9tm2nWwDB/xK+xyi0e7Vne2cmmtp3EjIhL4GFA1zQH3InzsImflMs+/iVYJipi6gBRh8002ehTd+YvvbBBxPB6yn9yHfVfBlFrFg9LbWqS3s2cgxwfsELYc6zenM2hyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447272; c=relaxed/simple;
	bh=8MG0fyuQaJ7aWVW9DaXZAee8BoE863Remofz4M+YYM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRcjqLohUnrv6gkeUiiaoG0TrrScvLOxkZr2nq9E5cGKkUDDfP8PyX85q3alQqJfMdNwdhvjOkGBf2CF/LHAUAY1gHxYfBynFu1KqlgUivOCM9zEdRUBOE8eVVBQJfx7O2Wzku0jVvQuwLE47Zk+l1VSoq0pszMGO5avkDOj3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YZlnoWAg; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e2d26fc82so325706039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760447269; x=1761052069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtUOBA02vnRbubidZ3Mq6jULmhFQWs/Je7/vpnoal3k=;
        b=YZlnoWAgFB3mpEPBmyq7XwSKVfh+7XpuiHxMmLRJjfGZY7DuPeNgLtyBJPUtcf+PAf
         M8nQa9lCHYyrtjARPdZJ7muQN5qhgyQVMT9oCIVAopdJ8w4DNrrtBCL/YuG3NCIB8xVQ
         6Z0JAaLZms+0eIcppwDE9Jj0M/lkwmKrRPwf+TsMf4L5RqFSLhWJ5jZWoza76CqC8L/8
         jhMxbt4DfiLbegSfTSkzq2UAMjtURE/ib8RKr9o5xZPpsFzwc84pK4Rj+tBbrsJhf6eC
         aObOCTSwHpGBdd4XVvSH+n+vpmKRiDWRM3q7MxOM2BXtH9eGdGDnDE+D+UioJYSzR7Lc
         f9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447269; x=1761052069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtUOBA02vnRbubidZ3Mq6jULmhFQWs/Je7/vpnoal3k=;
        b=iUwW9j+HZDVuOq6Isq8yfdFSP2mhLBRLznD1f7HBAVg4cuDLN/eetYZaD+oiwAy5KM
         O1+YfcMaXwMNZ3B2imf4MVUXDHW9Xv7mhyKH+ulrWl+bxU0+oNr2giSsY51ZIKd3ktuk
         DtPMvL2N6p8bcijXCvNBInhhsOfc/i54S6fnysP4QvabTJf63zo+gvRaYcrKYx6T1BPW
         eEiCoIGh8WGiMHG5SSweYbi1W6olEdcwUix7pJDlcqTnD9gjSLtnH3gz6gTEsZFOmk/4
         ZYiJ3aYNWsub0/VTbzDmLuS5PtbQ4qx6z1WINAeQPvFPWV9dGOpZh4paLoCBSSq2eg/G
         d+IA==
X-Forwarded-Encrypted: i=1; AJvYcCW29WGGLC5HTNs9+F6I7sz5E8BpvOp8dFl3XxFyn/7+QIIQQ0sw8YfNkt53Ib4eIHfg8lB9E9bsCZn4paE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26xXuS1sxUThtDZb8o9dwpnGcEzeleJivH6tgroG/nuvVXPRq
	1l5qEvjUt7AGi+J2UWdSCYOQYvPpnxRzUnL6cEI8YlbE+3W7NKkeSyP8SqMhnsz+8AA=
X-Gm-Gg: ASbGncsptkbE1rcjqsps9Czg6Aeo6mm2k9J/h4ib9WZAkSh+nzY+zBOejmUcHY0IlPl
	zSv/0VgiehEOSRvdoHD+96z63nOrR8IK+6QM2tCi3i+RgtZuERm1bATzfw/4L1eCHFEPH1dAAjd
	mWcCLzTkcre3ZUO4RNA1wljvm+Jd89jbzQk/wBQDnH6VpKPRvpMuBfStPlsicu90KurE3Ej4HI/
	tmqugjABhsygK8+Ga82X52QvBILaKo5N93HVjnUKsRBSr6TnRc7m0rAZZg4tzr+UuIq4iW6FVfu
	+pfAVu6M0QQi7JThBS/+RUh75dP0bPnfzJNOj4cXpnYCyM8K6TwR3u552yEA6R5WfQZuNaixFoG
	chteI6TmK9Gfnq7e0b4657jPp+En42eHmGQN/C34=
X-Google-Smtp-Source: AGHT+IGh+/cXW5eXefvfc/8019u8t+Wip4UewYdAOiTu7XDHpy98OIT7QQFCjFM4MijZt4pR5t5BaA==
X-Received: by 2002:a05:6e02:1562:b0:42e:2c30:285d with SMTP id e9e14a558f8ab-430a43ca194mr21969905ab.6.1760447264888;
        Tue, 14 Oct 2025 06:07:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6cd58e48sm4796689173.17.2025.10.14.06.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 06:07:44 -0700 (PDT)
Message-ID: <c775db95-ccff-46e8-9e3c-5cd784618f04@kernel.dk>
Date: Tue, 14 Oct 2025 07:07:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove the BOUNCE config option
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-kernel@vger.kernel.org
References: <20251013095620.1111061-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251013095620.1111061-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 3:56 AM, Huacai Chen wrote:
> Commit eeadd68e2a5f6bfe0bf10 ("block: remove bounce buffering support")
> remove block/bounce.c but left the BOUNCE config option. Now this option
> has no users, so remove it.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


