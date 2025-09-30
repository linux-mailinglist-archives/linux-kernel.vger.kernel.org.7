Return-Path: <linux-kernel+bounces-837797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D1BAD350
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D301896B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F42238C1A;
	Tue, 30 Sep 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZRWsRcZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92F1487F4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243006; cv=none; b=C8LXQ5ReAShkJGZqb5y74S6EIhmnlu9rY1SbNAeuq34jgaKZJnrF4o+0CXE+On9b7RbIsPUChtLV/N5DJqrJzFE6qWg3ru55aD2ogXp/A3JK6ciSaPTVhu6AoCXP/FNytqIPjjbumvI+oQ2N5QOoxb1JVOCjyLKJRo7VYmt8ZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243006; c=relaxed/simple;
	bh=tV33L99xw6/TvXmi7EZc6ye0VJ+OHNK5NyqMDPGYKAw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=steT2j328e/Jg/k4Dy4SWQfeBNqpCRl5WcC3YshbvVJ+IF7KJRCeGt1+s2LkgQj27Q72wNw4XF/y0UxGyQsM9seXxiBcPYPKQ8hIeXZj3hCHCp4TuD+3yyMrapik/Xi/gb6pmoC/FfJsGSHTRk2tkGvU3hJb21CZpVrKDdRB/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZRWsRcZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759243003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74Glzuj3wnB2CGzzEQelfyusRjYkf3VQU1WVVRXDhWQ=;
	b=eZRWsRcZRvKtDe60desovm3Q9BMi+MMjGlvoennKu6uzq8YPzOrJl1ufo9eCeISeLGAdRt
	0uinfjKssaDrg2BsBpk5/AJKp7OGBZ2Q2bXfEWgwMhOp8QZAVaN4VXFcAi+jBhamcDcgH6
	XI+TBucUTtwJ5aQW8Oh2hadD38u+C9k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-SOWoC53-MYWiZdJVMscozA-1; Tue, 30 Sep 2025 10:36:41 -0400
X-MC-Unique: SOWoC53-MYWiZdJVMscozA-1
X-Mimecast-MFC-AGG-ID: SOWoC53-MYWiZdJVMscozA_1759243001
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dd932741cfso111076261cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243001; x=1759847801;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74Glzuj3wnB2CGzzEQelfyusRjYkf3VQU1WVVRXDhWQ=;
        b=H26qqlKiA/bbWUVA2tVlrE9055kA6gJO3E1b3CSV6DS7qH345ueDEffGTxWNGFaEhh
         CHc1S/y1SOu7lqZ4Y1hPF4rdI20bqiZvCyKLA8TYMOaVuSgNSigCe3+wjlLwahh2kEWx
         JXhXbNImCyz277CDgO4cH2iKuuzLeCflrv+qiSCrFsOV1KCTk4HGRRWzmnozE77uJoJM
         H3O2BmKCSz5n5H30X1SO7G0xJMmsHmn+MhG7HzU1GM2O+ffa7gHePCyZuKGP4Gxuj55Y
         QCK+RpYDu8k3/eFyrVtQ7Q0TsVXzDSti3nTYZMDv6wKFGZGmEr15CbTKAMURAjFab9tt
         FJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/W4ZtBrkC8Nga4eqHJrf1IlJ2njv27uQxcwB0SCEDLZhh2mBDRLmqhdXkHjVmtzMmtAJcaqkQFhiDFkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0hmw1vi2LI79ofM9vEsSedPdBtmmmpsl3kM19WiwGl5XkWaH
	IXxik8/eS6uQ2A+p/srdpgre7UVwUTOrx4t02q/46mISjsu2amvDkmDhAxv78+tlX6Jo9/DdKdw
	DNlkJQHggg4MxoRI9q8xCf/+/sA4fsIp9zWznF4ndm1NzmHnffFEPHLZ4qKw8HRjGyw==
X-Gm-Gg: ASbGncsBUDbnEMnzCtvuTckesrX3CePWfZ7GUsl1rLM+wJm7woj16hkAaei/oe/Mu8k
	VfNhLeJy0m0dkjhxMTnqzN87BaCvP0n7Iq88KJFAgKFe3b5NHS0OnzqnFIg3DIExxgMpKhzo6BW
	toIrI3G0i53BJsjOlXxnR7RTHCE/OuBezyM9TW5zkI5cKjnXjohP63eUkCXDN8Z0qMKbg1YYPKX
	KeB3h8gbCc+d3I/xKbl/Md/5Flac6xo5YzG+8z74djfFhK4j33xYXYhS/a3YSTXIKsZSrFJ8rwC
	b5/7HqopJfE0xAsBlLc2km57GoP/m3XTOB4dI9dobeGdzoWncQj/Cxl/4Y6U12SpHBKmsR6v8yS
	RqotmFFcpqtwprbho
X-Received: by 2002:ac8:5f53:0:b0:4b7:9b53:4931 with SMTP id d75a77b69052e-4da4b42c77dmr220795691cf.40.1759243001231;
        Tue, 30 Sep 2025 07:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM0vgoTnLhRpxOEKoXFVfsprgquFOpGga8O3KsL/+evBSXx/IdsnaEdR/tQZ5+L7k5PWaxjw==
X-Received: by 2002:ac8:5f53:0:b0:4b7:9b53:4931 with SMTP id d75a77b69052e-4da4b42c77dmr220795071cf.40.1759243000630;
        Tue, 30 Sep 2025 07:36:40 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db09f1d09dsm97885031cf.10.2025.09.30.07.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:36:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1461507e-2b8b-451b-903b-b3f9ee8dbbdd@redhat.com>
Date: Tue, 30 Sep 2025 10:36:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] locking/rwsem: add DEBUG_RWSEMS_WARN_ON to warn
 invalid rwsem
To: "buckzhang1212@yeah.net" <buckzhang1212@yeah.net>,
 llong <llong@redhat.com>
Cc: peterz <peterz@infradead.org>, mingo <mingo@redhat.com>,
 will <will@kernel.org>, "boqun.feng" <boqun.feng@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20250929144812.2211-1-buckzhang1212@yeah.net>
 <b315b9e6-4373-4891-ac94-48da275f9909@redhat.com>
 <78363f7b.34166.19998b29e71.Coremail.buckzhang1212@yeah.net>
Content-Language: en-US
In-Reply-To: <78363f7b.34166.19998b29e71.Coremail.buckzhang1212@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/25 11:37 PM, buckzhang1212@yeah.net wrote:
> Hey Long
> Yes. I tested it yesterday. patch can provide  the  needed warning 
>  for my test case when enable CONFIG_DEBUG_RESEMES
>
>
Thanks for the confirmation.

Cheers,
Longman


