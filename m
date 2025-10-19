Return-Path: <linux-kernel+bounces-859499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE67BEDD7E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 03:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48D8189C722
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 01:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889F199FB0;
	Sun, 19 Oct 2025 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfEqW8p4"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C143595D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760835910; cv=none; b=PaVYFU8iRPpJ+v0qBZ/dP0HISH6OH0NfEUj4dX9hnrrqv+kGVYDx1hSnro7XSjn8dqv6x1OXm5jY6rgVDv+woDfgvjN7ChiMKc9PatJIY+eZkk4FVd1ztmersmnzobXclPLMur4jGMszQNYuR1fkMpTrFcE0ZV+oFILYXJghj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760835910; c=relaxed/simple;
	bh=slM9aoKA3Xp62bTaKHhzG0+cP/ySgGia8B2eX4rEERk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HljegtrsSh2h5GnT1WkqEA3+5majY8HFRUI/J8jLpUbmN1qLrUV/sKyMfSX0CAM0LHhTvfS8GZR6i9bZJeGuU58XENJAgXpfPXVKL1W8QiouAQkBeMhm6Frc0MHL/F+gAMzKjr8w83dGMdFgxI2I7o1WIc8T00xILlbZ/5t6xuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfEqW8p4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78488cdc20aso6745857b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 18:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760835907; x=1761440707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=slM9aoKA3Xp62bTaKHhzG0+cP/ySgGia8B2eX4rEERk=;
        b=IfEqW8p4kkGTgdB8pwj9FRHJOa3k5c4LzI6Sfnq6kdHZhxqSzDw+bz8tzKqboJeKf8
         pImBEcJRWMj7YC/xt0N9uL1ipSSflSx7CXpPMCeK1oFMnShPgbovTKKc/cKkwrwqmBNF
         S53Y2XAKwfpJ4jjPBYDTWywV+STn++CDb6n6ZZ14X9Tf5clJfyUt5CqtSFEHN/VLXIYC
         fA1HTyKHWnrC4BSqZhQma6W9VH65YgSpon3beY6ROGoSFoRMU/8x7Ur8UXaHRlAHMaLx
         riwrAzikUz65I9WyPE07+trwu//6RayQDyIOUnQyCY7bwQKzJC52fnIbiffFLDm5zOPA
         FU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760835907; x=1761440707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slM9aoKA3Xp62bTaKHhzG0+cP/ySgGia8B2eX4rEERk=;
        b=Cq3B8jfEcA1sC5y5/j6vhJsebbc7jwB5T7qqW9CVih0sX7Y2TzBevksgd6dbI3+826
         mbdSMJwbuNHVCtMHo9mcIbVz7vE1kRHEgOTzLSgZFUvae7uHKMmsyxIUMeCsKZe48zEa
         A1pceBClif/LD/TBovYvpe2Eh6T3p9631nWxeUYpFqNZzLq6ZwEx3qVminVd7ONmrfOH
         S/AmWtWRFxkMXG/KGeE5b6/hlxRm7zeYwhqJzqTyzWonhASMHQITTh2gUjRV/7vPAc0l
         YZjk78Dwi1NOeZbrT2wCk/NkkOLGtLG+NAyFhOYmR/Bw4nOwRMyX+Ce6TNS4FBOouGih
         dnIw==
X-Forwarded-Encrypted: i=1; AJvYcCUVke+4wogVdDvEEcQmNiN739QvvZhU/K3LwB94inhftyRVM5xX+ybqej2ke5UQ1+tTLfxQnUlEKEH33u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6g4KYKi4y1ZzarpBG63hpcrePl10iSKahZoB3l04JnhsIU5i
	oqJR2jRMIkDukSxpzi2Y6nnhO8PtNVQQS2XlIQvom4O6a8bbcWsFO+zISw2CCOw4H2LiAIWECBM
	DieMr1CK0OOgEk7y4dmL6/t33Pa9HQKI=
X-Gm-Gg: ASbGncsaa7AZxjwAR37gUfKisnG+zC47z/v9DGItod9GHL3e4J3kj42Cnbtl0+bnmz4
	ayMaEdUrUWIYfNoB+FVI1NROP/Qpff3oFJI2LTDfNqZ2L6RmKbpPwhwFwqyTfx1jaaf5uYtS0/X
	cTMPCX9DmzknJ9JcnCLSkdaZn6U7HzuQI2LkkF3R/lUl77Cw+qydoMoONniTW6i08b9rMCcUxfr
	i4YM90LciOkwaZ0Tiv3f1bp1dRL21upwnXmP5U3TS7gK6BbGY6VWOHAvzRuThjbTR6W10cqRQ57
	lJAWa86X3d4rEBv3S2GM9JCwjyO/2Lh1a63cXKrSxgpdQAXnxF5OOdUWxjR3
X-Google-Smtp-Source: AGHT+IGQUGouugSUTq3kUUp3fedwi54W7X2mGDpIFyPj7e34E6vkmlTZ2jjANkKLxtGL8Q0Ilaq1xyJ5JaLL6xK2XlE=
X-Received: by 2002:a05:690e:118d:b0:63e:3011:58dc with SMTP id
 956f58d0204a3-63e301159c2mr2061231d50.20.1760835907439; Sat, 18 Oct 2025
 18:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018161606.412713-1-kartikey406@gmail.com>
In-Reply-To: <20251018161606.412713-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 19 Oct 2025 06:34:55 +0530
X-Gm-Features: AS18NWBmQggENSF5mjmhuiaDooacbBWEcJg1eA64gNZsVLF-505iPGKUY7QFZkw
Message-ID: <CADhLXY6Wpq_7R_prPYkiY4z2=VoU7=EX=8oofRiBRCUktSUVkg@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix inline data overflow when xattr value is empty
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch. This patch is still producing an error. I
am fixing it. Will send the new patch shortly.

Thanks

Deepanshu

