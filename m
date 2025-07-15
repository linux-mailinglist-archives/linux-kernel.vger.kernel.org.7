Return-Path: <linux-kernel+bounces-731036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7186B04DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F093AC3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BC12C3277;
	Tue, 15 Jul 2025 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dMIilexW"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211C1A3BD7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546114; cv=none; b=jYY+4PP092cIIKVq8ztbk7BmD0iOVqDNpP1crE/CBYQ2dRIp4OJnfi3R7LeUHZRrcg+hGlI/Nx6RqmlJzl96cX2nmNGDH8qUki75x8uhb2xav0/6bZxyJK6R7oS3H8r7VqHkVQQo/jrzPGcoOWkUsOD5r1rNiLlBge4fseEh+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546114; c=relaxed/simple;
	bh=Bt4Lg6fkQ1I3lRJ6fSVH9O3myzqEgcL4Tzt9IlewX6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0diq0kphF3FUotU3meLSnXX+Z1zF/Rek1F0FgWdmv33KpSFhEmnt4yyEm5J50DEFNOSB3bIYNc4huZjoL/trZ9sIuuhEPFYjxZV4YFcEEw7F8gT6MNyB0SlgfP+u0zmtlZIic4abGG6kSG6RKlCyvow6Rn6PQiZgEVJe2Ubiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dMIilexW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b7ce379-3a03-4e6c-976f-8ea93abe7129@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752546109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm3Q+NNgGjYFRJRzRUfBNBDTKxjdEwDdWv+PaxWBpa4=;
	b=dMIilexWBrJj+fPZZ+mKeApg8DoIwlBSKs2NhvbWg12jbVKJPvG2PxEm7jBVC0lwBXdf3A
	e/JBgrU8u7/QjQYhd120HgJOd8DWylD9CoyJHVR7pFNldAoSdWWg89h1Fw3WmRF7aMR2IO
	2Z7CJs3MErvxSQzYrxjNpQ9f5bNJtyY=
Date: Tue, 15 Jul 2025 10:21:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add struct bpf_token_info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711094517.931999-1-chen.dylane@linux.dev>
 <CAEf4BzZzsqu1=Q-3+6uJvgvKd52o+FR=DFp28w+vT5knP9NyCQ@mail.gmail.com>
 <f580b139-a08b-4705-addd-31f104fd570c@linux.dev>
 <CAEf4BzbwRj7XC0rvWDzJX+v3QweYBh=dT6H17piyD=v1QLbi7w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbwRj7XC0rvWDzJX+v3QweYBh=dT6H17piyD=v1QLbi7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/15 05:06, Andrii Nakryiko 写道:
> I think it makes sense overall, so I
> don't really have objections to adding the API.

Yes, it is. Thank you for your patiently reply, and there was
some compilation warning from kernel test，i will fix it in v2.

-- 
Best Regards
Tao Chen

