Return-Path: <linux-kernel+bounces-867862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17168C03AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A64A3B6CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252123C8CD;
	Thu, 23 Oct 2025 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M6Pzk/1a"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C4274B37
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258271; cv=none; b=IUISt/HJq5L/uXahGjjBr9+XigfoptajujF/U32OSefwlykb7XwnBgKdUMW5wICD51M0X4QrvQTPS8W93Mu4zn6GggqZsID3K0A2ONhltzvg8Wk8lellASvVS6LJY5z2dHONFSESeEKGhe4R/+ZwDZEhB22P5pkXsUsWp3dQ/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258271; c=relaxed/simple;
	bh=tQUHVxMwXzLpv0w082mzRfb3N1f6TYLa9SBugRmql/k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=UF1BAJM6mlqa+y4QZgasICdAk0U2p7zkn416m5XbYS4qxtS/DW8VMSwb5kR3CvIa1Tohkv6S6lT1njYzRdVLztPb+jOKko5U7YmZQ1vxJofGWtWmMF94K0rX0mlF0GFF+bQyue+DuK28qR8K/qvNmGaKYSbraaUWF3/MrJJ+jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M6Pzk/1a; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e89e689ec7so8661371cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761258267; x=1761863067; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtxaoQ9Z3EpBGRZ2g5cKDxZnBVsB91/aTgSB/xLsQVQ=;
        b=M6Pzk/1a3HBQYYG4ABm8oGfuNzMcRcBziaJymp3XtGeQ/3siFdxDr30GG4ac5BNEPa
         bKNatwLYlQhNkJ6OAMfka8qlHPlPds+SKiySkAoWNQVL/uIR71cl0bi+e9pdPmTcrp8q
         PnkcZDYUV3RhZNRBnp6g4AfJIQxE6KPAMVNXS72VC15Tj45ybAMQaIZJZEipHK7hsLH2
         YmGZrTFPputoL+6TUqrFvhHntnRmWOjwmtA5BiJBIVuvA79BWEOlmX/z2jQ5gFzi/FRL
         DtJ8UuXk7fq+IEggpgJFPM5E29JZT41Wy1j/xjtMrNYZLFdNDaucYG2YQ+LUmLXT097u
         ySIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761258267; x=1761863067;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vtxaoQ9Z3EpBGRZ2g5cKDxZnBVsB91/aTgSB/xLsQVQ=;
        b=HMXZWaQGNpsM4yLJ3pE8Yw+xvPQS7/1RJnGXkFkZQ4qRFrpB3zb0y7Ilz/ND3QhRye
         TQsU0LtwvlfHJGdjUTtAKFZCijDc+4bK4iKfsSz/uVYVhC4/n9TTqMgPj76301bE8udK
         NMiTmC6T6/rO+nt7LV7+gEGSep6T7HFQHViRFfBZ493uTWhliG1rRsH8RS8NbYpqzo/1
         kZfD1gyYY3FBQ7CQOMPgfWh1z+0mUmJNAVk2g8yja60LvMcZqwe6U/2Et8mmpJLUhjO3
         /1tgchlg0uwc3b/nnn0lpHTQsZN1ZD5TMd0NHZMdFJgS9X58+sl9DOs0/E5L0BTQcOvO
         pR6Q==
X-Gm-Message-State: AOJu0YzXN+/nGny0L1L+ig1ITiMm8UrKKHtRbg3IgaSe8lXjhLGkd4/A
	EWlMG7pnQ99nfldXY7GsENZt8AV1qyIYNHNPKBpkFKi5dZI2QMK94wVjVpy2Q9zW/g==
X-Gm-Gg: ASbGncs2Te7Bro8bPQfuksqHgQAcv8etjJAJL0XdphMhgvQEX1DxvAXPV5UtOmxpS5B
	VflwS9boKM+6swtwlaf6UiqxkcbtMkVNEU+2LVfJ0fHiGKhdzx7WMk6PpO5NF6LXGEc8ZiAtPBD
	o4V/R3Y7Iq/vjiXZc4CT6hHYTzLo5eFeraFQClDBRJOGpX0ReaClN7iYFWCSMWr2HmxWHk0IRTF
	Z4ZlU5yCNiRTkNVLcRRhG3KwgxesCo4Nn+CEdYA5MBWDvlK74Byw29v78KOHIIcp6IoEkmBrlu9
	xu7yGKyDTZNzRN0UysfHT6YBKJHpsIOR7sAD7MRisFL7gNV2DZnG+hzGt6WmdGo4NBtAMFXe1lS
	ob2ebQki1aTtYvQJ7GeWVC/dsrIaIQY+eqkBxyq+/3JNBKpnJeBtUDqv9vunTTaHeXQWdfZ/A+5
	RKtbWDv8+ywpsgt2lLKCCLkvclc05T8ITnZ927+ASS6JBIUg==
X-Google-Smtp-Source: AGHT+IF8p9h39szTOQkqhtXLji1wf/d6knDKyufDRGAAT1jl+xN4lNrSho8hIqCX+Yo8MxHz2my0fQ==
X-Received: by 2002:ac8:598b:0:b0:4e8:96ed:2e65 with SMTP id d75a77b69052e-4e89d28eecamr308215931cf.22.1761258267424;
        Thu, 23 Oct 2025 15:24:27 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0e48fc92sm251416485a.16.2025.10.23.15.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 15:24:26 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:24:25 -0400
Message-ID: <20c1a5de781c4013cec218b4d74aee9a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251022_1923/pstg-lib:20251023_1801/pstg-pwork:20251022_1923
From: Paul Moore <paul@paul-moore.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Subject: Re: [PATCH v4 2/3] selinux: Move avtab_hash() to a shared location for  future reuse
References: <a878f27f8148bb4cc662755f6e69400632183477.1761217900.git.zhanghongru@xiaomi.com>
In-Reply-To: <a878f27f8148bb4cc662755f6e69400632183477.1761217900.git.zhanghongru@xiaomi.com>

On Oct 23, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> 
> This is a preparation patch, no functional change.
> 
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> ---
>  security/selinux/include/hash.h | 46 +++++++++++++++++++++++++++++++++
>  security/selinux/ss/avtab.c     | 41 +----------------------------
>  2 files changed, 47 insertions(+), 40 deletions(-)
>  create mode 100644 security/selinux/include/hash.h

Merged into selinux/dev, thanks.

--
paul-moore.com

