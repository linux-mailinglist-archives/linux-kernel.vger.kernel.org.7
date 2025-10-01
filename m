Return-Path: <linux-kernel+bounces-839435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50FBB19BC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9877A2A7A05
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDA024EF76;
	Wed,  1 Oct 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpqMHRpQ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AB175A5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347212; cv=none; b=tshYCYOOAJDlIiOsKbrrbk7GzgEqtVNsUhfMPMiTLABQAwkJRWngEGiUOF3O/fRnPSv2zWsDmDU5QRyNVgOrXb5ueCKYuJbvZQIjDOa4xjOg5WLP/CvsgCazobLaJBxhUt7OXfP2HvjOcYBtFzNPzPstpIb07mrPAacVfoT30JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347212; c=relaxed/simple;
	bh=zadHb21ZcDce9xGE0wPsjzXCX3vyDskokv3dltsRNIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHlly23YN0B3+tF1eEiB90IfLC5KV8d2k5URAquhm1q2esGdanV86WYE/B3t37ARHHRS2xi/xyKDzVzZ9GyOB3XB91VuPRKQOBDy/J9xMDAHzGg3PEK+sarHA3K0pS0arZ0Mmc2JEmLZrbKQ25zd+B35JSWSVT1LDDy5V+MjOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpqMHRpQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so309952a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759347210; x=1759952010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zadHb21ZcDce9xGE0wPsjzXCX3vyDskokv3dltsRNIg=;
        b=cpqMHRpQp8qI98EjSgSqjL6D9P/xTXUasKSvjmv7IM1JHtgb6Mwh3v75/EGgjdEyER
         FKozlgPn1sjFxen/U48y6X9u7cU8ih+I4eQFMELHv6fHP7F5I4oqvZpQoWE5pY1h+VAY
         E40K5zdmfGOHDy7N0+Zt4pFz5VOlPz21EVz+12Xp6oQpcuidjy24vSr4U7I8BaQ780OB
         1j5cuImELiRU8IWqd/2T9LaKBaQVuYWKXN3or1W22DajRu4j5xlqfzcIfj5f/uKINFlf
         PJRX/N5trxqpxDAMRYnzZ3uZ/Zlnn6VYuIS154CsUpFcJYWGXAJ6ACLM0RUAp6ZAp0Vy
         SMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347210; x=1759952010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zadHb21ZcDce9xGE0wPsjzXCX3vyDskokv3dltsRNIg=;
        b=DmnEi38Di45EP3vM0np412o/sTRabtAyl3b62pnm1CT4BbiTqjFpJlx/YAVtPAwj7K
         udW0bbESFOdve/+tuTZJygytRaGfd4s0QOgesiUgbXgZFiS0ceEJIUMxXIpVWXGbgKWu
         Njeqnv+d25ijp7zjItFG0Mshk23oI6S7kZ4MXgTpjh6bSBa3j4wKoiq0z2TYIXecjOkV
         2UdN8LD2kDeH9zinF8VwnU5ZjX7bhUVD7E0oefaOpX+22wfnYGtLnVXgFxV4wwLtz9NK
         f7XI4tyNf9KWvkUaUkwqH3g7iOe899AQe2pJHchmvgxdDL5PDbXG7e+wzOUc23b/ydTg
         MVoA==
X-Forwarded-Encrypted: i=1; AJvYcCU6TtQSeyrQ8jy8J/sJpt/tmP2fcmz9FcSYep3aigYO0d5nkI3R0vb13GJqR+niAJBPW0kQOZdVixFfiWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61VAfjic7oAmHLYOuIQZFMfSqKKRsXjYjabk/9DRrMEdiPrty
	kAiMdITzZXV3llVMBYIJp2TgQ1TB0s6+gE6KGYpNGbh6/Nea8mXpBUzx
X-Gm-Gg: ASbGnctVyYI4v3lRB57eq4fm+gwhX6zQ9tHItdZxYuib9+35LcZIXYdUcFrCSZNjTW8
	+aU6KfKo3bD0GwWfj9W3MRIUmX7IF+HxEEXQusIsy1zV94kbixaIFviq1N6rhJCp5Ylz6vqUbA/
	NMaHWOac5YYEl2fPkTYG+WbthGHwl/GbQQLDhZN2jMRVM7r5L46C91Vqf2RsRUoeYCfOzF1AKhG
	/D46TKv+novdWZjvr8wNbHeJtXbvuMvGHTSGa8UmjcJ0V1YSLpTIQ5eI4pzIkFwp8rU9Yt/KGU2
	/MVaea8Gc3d/HjHiTfpBKiOJEmbKA/M9juDpruPYyhwY+JIh0nF08Fyy08oopiXet3Rw7WfC23a
	8klj8IY8LpnesLomNcYovSxQ1dlKLqress9Gh/lxb6Da5+GzTGlc1Ateb3o6gYjC4Pdgu46tv/b
	gKgnMuyw==
X-Google-Smtp-Source: AGHT+IGW1s1nX4XZtXh3VMWVQiZ66bwBTZg0K8xNP35DfDfQbjhhuXZa6BE+hp6HT4WQWLtr+GfrWQ==
X-Received: by 2002:a17:90b:3b90:b0:330:604a:1009 with SMTP id 98e67ed59e1d1-339a6f38562mr5471335a91.23.1759347210327;
        Wed, 01 Oct 2025 12:33:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399ce47d7csm2255668a91.10.2025.10.01.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:33:29 -0700 (PDT)
Message-ID: <a9bfe698df684f2a78e49913a0e39b02fa52088d.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/bpf: Add test for BPF_NEG alu on
 CONST_PTR_TO_MAP
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, KaFai Wan	
 <kafai.wan@linux.dev>
Date: Wed, 01 Oct 2025 12:33:27 -0700
In-Reply-To: <20251001191739.2323644-3-listout@listout.xyz>
References: <20250923164144.1573636-1-listout@listout.xyz>
	 <20251001191739.2323644-1-listout@listout.xyz>
	 <20251001191739.2323644-3-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 00:47 +0530, Brahmajit Das wrote:
> From: KaFai Wan <kafai.wan@linux.dev>
>=20
> Add a test case for BPF_NEG operation on CONST_PTR_TO_MAP. Tests if
> BPF_NEG operation on map_ptr is rejected in unprivileged mode and is a
> scalar value and do not trigger Oops in privileged mode.
>=20
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(in the future, once you have an Ack, please copy it to the next
 revision, unless there are some dramatic changes to the code).

