Return-Path: <linux-kernel+bounces-762815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2F1B20B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 359954E3114
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA821A435;
	Mon, 11 Aug 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YTv4Z/bn"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40D1AA7A6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920909; cv=none; b=oJYzKmf2iZ/8cH+TZCBx9cmdvspIPUj+5xL8ADYt/dzvf88c7qy2ViZLMswQRS4eyjf5AxhMtlXdv1JBq0wzFZUgvf7dtBU47l0bl4PkwR7BQxFgZVEs33248W3aaiCCS00giWksWxPW5DR23B/lawzzbR1xWe5iV5/Y0PP6Lho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920909; c=relaxed/simple;
	bh=STsPUsLHRGaJhQCS21q0YWuD/BlvmNCkJ7wEGDFgCZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nvGkXfnMULI+jQPEEvJWCBElPTlFXzH3ApUFf1aUPk571iQbwBrzhg1wZc7CXiFXeQFzIO3JEhSj44iyfeau/Z2HAJicfOINrZlOfAlvQ94xIT90uw8NVk01vtftTYTMdyBK2nRYjHD4VDPfvoLKZLotc6Guz4ZX2vXok8/Vlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YTv4Z/bn; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4281fabee0so2940830a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920907; x=1755525707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrjwnJSZ+wZDyD5fuZ203u2zL3TESbG9zGrsZ7kj2OQ=;
        b=YTv4Z/bnPFYjEv9hnkCGK9OYnIcSH7+EkDOatkI7fJaUpTNI0n7o/d/aznfSRVL42T
         ZAEhK2GhhkfmjR1KtCbf3yLR1FhlNs+Mxa3HeX6SiEWmveCeP7x1OnZu++5uNzAYTTaP
         X/ge2FvutLyubZ5QZEotNemuwDMt21l0cvrXZls7zivrcTk+faqAdT0N42BIJol7C9gX
         INzdN3JrRY8F4EJMkNv9zdeaiDLjE9QxWt1B4UVA4JBngJqa3IPxT7oexcJ7hRWnwGsH
         DVkwktnbikFamYBuNu7TSc6s0nv50iLnzEyZEu1KHcVTmkfpLIPG1i8nPTi0FAzRTv8Q
         VHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920907; x=1755525707;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrjwnJSZ+wZDyD5fuZ203u2zL3TESbG9zGrsZ7kj2OQ=;
        b=CJZonYt3IoH54vR3TGeAPc+KYRCYdiWG04ia6qWyUVsyQZWf3SBy3FjcWAcBlasMl/
         W+1GOwP/z1zXqzXIcDeZlVgZKTypCpgBb4zwosdHHHI+GmWfFuy72xGjgjK9JHu1IGVJ
         o4/VOxJWk6AcwAS7uEjpV2hBZVF2fsvHadPSqE246Yy5OmT0VQZDUoQocyiD6wrt622M
         Qy5qTBpRo4QSZr2ZPRmjljFBLsxDN10DGtO/aHdjDimvcPAXRKWBuCzBdjIP7zphhm5U
         hlkCQZlVnutsN7Fy8TiTeJir2GvmshNUg7B+kHi4htlqDYTaewiGhrc04XxNYdGHV+NF
         oDow==
X-Forwarded-Encrypted: i=1; AJvYcCWBfVcfjmjKxMq6WxIN/21geuLf9GHc4rr7Mj8rAUAwVGO1trmAefFMJNKVso238wQazNZlw2o/Q1g2Txg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHb1K7qAzdq2OlgIs39JvAcHOxzS1zXFnklmD49rRkr/1Gl8gQ
	aBCsdi5s3XWWN4j5lcduBtrWlxDl0jVZe7+FALeswN+s5YZGPUNV5ci/HVTEFQTOn3k=
X-Gm-Gg: ASbGncsp3I6NtSPa2SZ28CjvzcrUvzPJfVKvMQ2AiHgddHyUvdAMl548sNJvJxfIOCT
	T9P/zQs6K7AoSQd79DOzJA2olwXeQYV1BncuE51smgqfeT+R/dbBLuWJrawqbwaSWtfjd7ZrGUk
	3mujH4RuC3wC5piSDfwmuxhuXJ/IS5xHOHqxcwVSOtUV02APall/g+CmReaOxgUMDWOFcis4Jzk
	omagcebX10Ci73LbvzMB3TXjw0Eur6Jua27A0Nzni27+Zs9os2/6oE+Cw11JOkslgWkWzmc0cNl
	e+8N4ALS8hD27Kc3lSx52IIw0C4WrxlrivZVw3QPdbo2uM6CMgsaah1BFqWzGThp6lty4R5iOdS
	X7AA20MHEkf7aX2o=
X-Google-Smtp-Source: AGHT+IHm/xVWlPxViXI93wkDfzFjJJiH4VpSC5GMZ8J/p8uaeD+8Ug6hnGkIQbUPnhMoWBj+pSIc5Q==
X-Received: by 2002:a17:90b:4f47:b0:31e:f351:bfec with SMTP id 98e67ed59e1d1-321838a61fdmr20966406a91.0.1754920905096;
        Mon, 11 Aug 2025 07:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808-ublk_quiesce2-v1-1-f87ade33fa3d@purestorage.com>
References: <20250808-ublk_quiesce2-v1-1-f87ade33fa3d@purestorage.com>
Subject: Re: [PATCH] ublk: don't quiesce in ublk_ch_release
Message-Id: <175492090390.697940.8796642091342962699.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 08 Aug 2025 15:44:43 -0600, Uday Shankar wrote:
> ublk_ch_release currently quiesces the device's request_queue while
> setting force_abort/fail_io.  This avoids data races by preventing
> concurrent reads from the I/O path, but is not strictly needed - at this
> point, canceling is already set and guaranteed to be observed by any
> concurrently executing I/Os, so they will be handled properly even if
> the changes to force_abort/fail_io propagate to the I/O path later.
> Remove the quiesce/unquiesce calls from ublk_ch_release. This makes the
> writes to force_abort/fail_io concurrent with the reads in the I/O path,
> so make the accesses atomic.
> 
> [...]

Applied, thanks!

[1/1] ublk: don't quiesce in ublk_ch_release
      commit: 212c928d01e9ea1d1c46a114650b551da8ca823e

Best regards,
-- 
Jens Axboe




