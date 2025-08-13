Return-Path: <linux-kernel+bounces-766843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB2B24BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64903882BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77A22EE29F;
	Wed, 13 Aug 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2SDdAPG"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB8267387;
	Wed, 13 Aug 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095306; cv=none; b=RNGcmEg2yP7E6dChvyAUpLhORbLVbQWrhqKPWa8DHXHOcVQy829dOJCp0S0mQ3lxUnz5C83l5i6AoC7POMchtvg7KeLYVwqQcQZ2cSkKSPz/dI4gJX/RwlOUDXXmkNF9KL7zqAVA/Dy9rQhi2SqYoPzV5VojyjEstIQToNmH4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095306; c=relaxed/simple;
	bh=+hrwah2koSijMxK7A23KsW+tCH7oSWvX4SZy4rTbW3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOscO4QYUL8oXVoo7kpoqn8FFqojMe6K4OTXtHQISW9Ed8OL+qOWyGJab3rncneZd+3uivsPaatsBFDxAK39dIh/Zv/WFfQ3A2eOtEALhjHmZyznN1XMZEDVxmMULVamQmBb/DVeOyyfT0aJhALhct775NmcxQ1i2mvEWje0Tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2SDdAPG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4281fabee0so4562736a12.2;
        Wed, 13 Aug 2025 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755095304; x=1755700104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8OCBCOSdTM6nPxr/1xQ+IM9nUoC1yJQfOXszuMrd8o=;
        b=E2SDdAPGu/Kz1622F/8FSULyTD1AzEYUCdDabcB6GoVS8HPE5iXZ9PiQXrz6Y85Jtj
         4Gy6YhGnC2R5okzV2aN68Sb2I6nR1tXyWbl47BVYnsA9NWdWSytG9np64Ltv1ydJaDx2
         6jzg+rPTCrua6Mv9j0gvdcCODoLB9F08MmounbxCzvUGtoCljg0gkLVmZhykC99ZFc1e
         yEdOtQdu/fSuNT4yILJJPAphObgfqU0GK8tB4jA9Pm8jkIf4H0aYZFGg0dYmreOJO8A2
         G7VgQSH0vg/eujjGYNTCb5Iv/HEwqvqceJ/jF3Y0KWi9AUVrnjPwwCdAuk7fLF3x7q94
         v3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755095304; x=1755700104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8OCBCOSdTM6nPxr/1xQ+IM9nUoC1yJQfOXszuMrd8o=;
        b=UOX6yoCQWzh2I/dMYG3wfA8QnwRqKElh5TQdTcyBVsma/a3nMr4bt+6OOSBAs5+gtU
         xOXgqRT7rV3nIzV3hovFdJn/orQGl4ZapJmBTcQgzSnZeBT11HHVSWwtVngfpZSXN+Rw
         AZ0JrnYF4qrkLvvnfrbBWKabqPk8QU8jC1vi8zIoHp0ybyCwX6xn4enrIP8Bf2WB9rQq
         xasxI0MmNKNPdm7V5LbCqI1dG1RY8DynAjQDpvWNXFcsU7zwfrSDMwBVL96SZQnTRzjU
         iRc3V1Sa6MYxM+6s3osPlKZrWTrVxOQ3mzKTEtXJ8ebK6MZ8kyE4Nub3D+Q6/V5MnZqJ
         zR+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIYaOM1RtU706sNO0Zk0htlbo5+cGuniNo38VM+OrE1IhnflU3BuZi9NgOPi3pi3vtvKb68SULroVV3YQ=@vger.kernel.org, AJvYcCX0ApUUG2qJQlA1ADRKc4Eeuvzmebo817GuEZ8ATbVbaYchQvzDAgdCjAbjoLPp1oa68GUQttK30EQfnNEIZYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GcJQaZ3zG4xeb21i8BbNSPG5Ou2X2Qd2hppsNKdGhd5P/T7/
	lHycabuyKo5kJCSe4LZ2XjYE8CgSd5GbjwjGzkKPhdc9mGaaPia49+Ul
X-Gm-Gg: ASbGncsyiwR3r+UHlXNHJA8qTng0FRqdEVreaUGjzH7X0GS3q+Dl9cQUr4Kr/KL8fHF
	6DSr+ormaofbXluPGRy3F5LrLJAAbsBeviFHIdBmORjHbDM6lhXottIa5zbE1kOpVa3m3ZJj287
	NlsJsbJOlLzkvRihVnkmMjmkHtmNtpUjfopV4fp9TRDaBZnJVFwFR03TpEKw3rEsQ4pXOKeRHqQ
	Xb/MHM0UXp7Z7qwIXTLVbiRuH6KVYa04v0wI+KBFV7dsSVgJQXMOSjSt9iFqeHBFTGh+grBweuj
	8c7xBRY/L1vmQMI6c+kzm0EiNOIXdNoKMcPg+rhiUMlUPDqeZPKw64hGsA1r/K2YrxcfF0d3E/W
	5fkaSbVl9Tis87wltVtuDK1SnGOHlU097g8MC
X-Google-Smtp-Source: AGHT+IFLnhYEYjvYY5xaSYqxSIj2JAff4lg0qD0lDx3t6AS77VhOR/Af+7QYYgBRbL9Xu1znVmDDgA==
X-Received: by 2002:a17:902:e88d:b0:242:8a45:a95e with SMTP id d9443c01a7336-2430d10cecemr53119865ad.15.1755095304128;
        Wed, 13 Aug 2025 07:28:24 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1ececsm326580165ad.68.2025.08.13.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:28:23 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: "Re: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted imports from sync::aref"
Date: Wed, 13 Aug 2025 19:58:14 +0530
Message-Id: <20250813142814.31576-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DBQYD7G5SOZA.2MSKKQWXTPCBB@kernel.org>
References: <DBQYD7G5SOZA.2MSKKQWXTPCBB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Aug 01, 2025 at 10:36:44AM +0200, Danilo Krummrich wrote:
> >
> >> NIT: Please don't top post. [1]
> >
> >> [1] https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions
> >
> > Apologies, I’ll make sure to follow the interleaved style.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> > [2] https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> > [3] https://lore.kernel.org/rust-for-linux/20250716090712.809750-1-shankari.ak0208@gmail.com/
> > [4] https://lore.kernel.org/rust-for-linux/20250716091158.812860-1-shankari.ak0208@gmail.com/
> > [5] https://lore.kernel.org/rust-for-linux/20250716091827.816971-1-shankari.ak0208@gmail.com/
> > [6] https://lore.kernel.org/rust-for-linux/20250717072724.14602-1-shankari.ak0208@gmail.com/
> > [7] https://lore.kernel.org/rust-for-linux/20250717073108.14943-1-shankari.ak0208@gmail.com/
> 
> Ok, I see what happened. :)
> 
> I think you may have misunderstood the suggested of splitting things "by
> subsystem". Let's take [7] and [8] for instance.
> 
> In [7] you update all the samples, regardless of their subsystem affinity and
> [8] updates everything under rust/kernel/.
> 
> However, the idea was to send a separate patch per maintainers entry / tree,
> such that all patches can be picked in the corresponding tree.
> 
 I understood my mistake now. Thanks for clarifying!
 I'll split it out correctly and resend them.

> For instance, one patch should be everything that goes through driver-core:
> auxiliary, PCI (incl. sample), platform (incl. sample), device, devres.
> 
> Then you have another patch for only DMA (incl. sample), etc.
> 
 This particular patch in the series is restricted to inclusion of only gpu driver files.
 Can this be picked up separately or should I be merging it with any other driver?

> Can you please resend accordingly? Ideally, wait for -rc1 to be out, or base
> your changes on -next.
> 
> [8] https://lore.kernel.org/lkml/20250717073450.15090-1-shankari.ak0208@gmail.com/

Thanks and regards,
Shankari

