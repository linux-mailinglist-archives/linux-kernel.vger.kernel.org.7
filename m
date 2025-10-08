Return-Path: <linux-kernel+bounces-845679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F05BC5D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE3118878CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F925EFB6;
	Wed,  8 Oct 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geQ2wtZ8"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5517A30A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938399; cv=none; b=I1Hv+xX08xdWOToa3OZ7KPdHAsOUTr2b9E4ymbfuCnz+4WvksAyhlh8j32DtHGddOGS20KL0V1Ah60uMUoCOLt9T/z4NezQ+C4Elmy1WqHR78bh1HvKn7Msl25n09XTD6IVZ73nQi6E73O0Pkwbw8cS4OLjgo9Qf7/b5mHGSRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938399; c=relaxed/simple;
	bh=uALLMCIlyUutYsvNGQy4FW1LpvrsNjRGPi60Z2f5MyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/lXDJkGNuoZaNPaxeD/885C5sYU95Eek30pIPD9skwIAGGPfIlDVUX7QOCRvNoQeLkJ+mB4TgoTy+rhtaaOTqdSAQeRz5vbmGgqgw41zE/LpPu08VoUwFZjU06zVUWLzv5HTkIh9oApwkilhi31QCPlvTDGB1zF+jjzJbxNyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geQ2wtZ8; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-9379a062ca8so277189639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938397; x=1760543197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uALLMCIlyUutYsvNGQy4FW1LpvrsNjRGPi60Z2f5MyY=;
        b=geQ2wtZ8KJ9YITT/cEuGV+iC6GYlyag18v1TitMfkDN6Vaubsqrt64/zOOh3J0QzJJ
         byOT0AYzdXsWOPkrjbiHLSq/1WYwJrRPjMtNiAlDdmQsNOlklt3ib8w3vUPpsrjaYC9L
         c1yhqCLy+da15g4SnNAheHs0+L9zov4yK/g5cZpbiK4xulcqi5xwKAIq9Kc+FWXKzGri
         ZIerPtpEt4Mrj1yIj1MpDjbt3P3bDmd6drVktxd9vG551XznbAKtanafEy7YzdajiI3T
         kC3Oi7cKz5MUx4tDv99y1Dw14i7JJkcEQ3cp+sbeUDth5fmW8R4hA6qJtHwr+OIP+1V+
         ybyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938397; x=1760543197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uALLMCIlyUutYsvNGQy4FW1LpvrsNjRGPi60Z2f5MyY=;
        b=w955YAHxAscysXUBoG5fmOq1D4cH+hH+PcLIgBhp/pqF2DYgKDtRi+WAFccRHhIafA
         TOsJJSuiUfWvEHtrjTOh0uN2vkZTBTt2C22uJSrqH8aK8Mnk0xofZS8V4DoFJJFv9205
         Drl5pY1X9NYm346eA6dkrUOi/DptK9HjOz8Lw5AFRvUruoFTmSwVHtBmRSETZ9ITbZt/
         57eNnwfrbYMo2nWTZ9h7mhtncLKPFwss3cRRYdTo1ILR7fwCWV0RYES8vtaXeLlMeHau
         r0eSlPTG7ohjZ6yY4Xl1ywA9d59FSsD7kif3RHcpuldLgwOI4afgBOcoXg7OReeKdxrl
         shSA==
X-Forwarded-Encrypted: i=1; AJvYcCWVCiES2jqDrET22Abq3hpYjLBvxoAncMYIdNBevFQrEi74uZb+XpOQMSKTqFPAzsB6NWNDZ8igYJXx/qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjO85bZz+S1g8o04ga7b9U+48h21vEnTdEBj6TyTu1YM8HCJuV
	uef3ucwYIPGsDOCTRwjc1k0N8Y2YFSc5TbPR2wWG+X7BAMatCudl5Z8tabSBJxqutCggwPagoZy
	UjCKD4Ki2p34nVpRaBlNPoqOcJMa9m1DjLQvdMho=
X-Gm-Gg: ASbGnct7o+YKSrq/UQNA9dasg3PbB2MkJHh0Nx6GK67WL++88s6XYLv0/XtSUeu3xdW
	R3jyaSh7SUNyZL6XBlRy1mAZepbL5hwX4nl/ZoH0CKIr8ILgYyJEuiG9GUMPkcGfhKSFfyayAbS
	A9UHhWBuOaSpMiE1andEBGs3/xd6spcFU51n8gCdKUKJObxgJYbtkCN3P9vZTfftK6FAFWex4GQ
	U3KdVxKMGnhJzIU33ATWfElm5DI
X-Google-Smtp-Source: AGHT+IGYka6zTA7SFt5YtxUw1vvapwQ7jyiIHuZuDS5NfBTlBB/gXvXX1CBMTIglIFvrBhIAspJhAwA0nexvYHYEYgI=
X-Received: by 2002:a05:6602:26c3:b0:92d:99d5:6a00 with SMTP id
 ca18e2360f4ac-93bd1960533mr454130339f.9.1759938396522; Wed, 08 Oct 2025
 08:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003203851.43128-1-sj@kernel.org> <20251003203851.43128-3-sj@kernel.org>
In-Reply-To: <20251003203851.43128-3-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Oct 2025 08:46:25 -0700
X-Gm-Features: AS18NWB7B1gBQLMeSyYiISK3rWj8HDsB0McGNEALt0lUkrKO71NOSeQ_6dlZKw8
Message-ID: <CAKEwX=Pbg=O5MpZk9s8pCZo807ZmGn8N3WoALykbz68=ggb1mw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/zswap: fix typos: s/zwap/zswap/
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, cgroups@vger.kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> As the subject says.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>

