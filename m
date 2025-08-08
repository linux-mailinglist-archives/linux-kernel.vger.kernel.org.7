Return-Path: <linux-kernel+bounces-760123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F88B1E6CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7F21897C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2D22A4D6;
	Fri,  8 Aug 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="FTuz+NJi"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED56227E95
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650242; cv=none; b=EHL4EGvHw0M+OUjhUhRW56eTUgwzmHfNG3ICqpXcizpPrI0HP1ELNJauWmsfAJS7PphjU1tqOhWJBiLrSxlvs8BygUHLE7Y7w6tx32IQ1CktoN+mZs9U/dvX8jLpqBSwAwZ6fwdExdy2nzQg2XQeBPioeNZLbLd9Y0K+DCQl+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650242; c=relaxed/simple;
	bh=YIm88aacknXO7rjNdWah9pe3ap55dGpndwEra1Jh9L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0OOxGQqfjhqqXoxRpQlsNKVmsP9q/9pxayoGMdIjqljjtGYhkvD/GWt4Wj6zwbZpxbABH7D/vaPYkw/odnjb17Pd+8HPd+c84ChpEfW4lZPAJf7LGFImWvuTUIQs+ZCEKxsMrn1SLcTJiuVl7tnzhuwYmEoTurzVMLrvwhf3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=FTuz+NJi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e7fb58425cso296457385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1754650239; x=1755255039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2t4Nqy8A7Pvum+ZPz/AX/HM66sDG0qhG/ulIAizon6g=;
        b=FTuz+NJiNuG6LsFMvFakWij9D4j9e84OBUF97BT8Upzna92nnw1QItLpxZAlsBOVDg
         666dhbO4mVZSklQBzWWlq36VPwof/MGcokZu0hzP+JzzSssBjsQHbiLGKHbaVguFhCm8
         nIWyy2FXrZboF7hNG7GgSAIi3UAQOqkguQAu8PL8XRfdZgITOlKMaMGHQC7iZciIsVjV
         2f4SrBFwZxGSAs4nkTaAI7/kFm9AppPa7Ed9u45qfThU/4dpGL2aCnhu6kXvBq0Xa0vD
         nt1ye2I/MAaBy5ohSIzc25/SwjI6RxKSUnMJNUHHZEDK60VCryiazPTh36fg/ACmXd3I
         obmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754650239; x=1755255039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2t4Nqy8A7Pvum+ZPz/AX/HM66sDG0qhG/ulIAizon6g=;
        b=ohDG9rc/Zonkp+XzAW2oguDtkeRdHjapdUDWww5bkn0lOhF8/wRtK/kHtHH2DLv5q5
         cPdAS1cTeyeTisoyG+hbARv030rqtzeVrm6a1W0ydcoYs8N2LYuCccRvEvJiG8WQI0/Y
         m1xvIPwweK4x1kqJI2b9+TLLLrnkQMGU3fgv2qF+b1AVPYThJISKWNiJNJAbXPf+6+Es
         zvAMmeeICLNuu3pJGWIqCF8IfKaodaak2VZ1nO4tnhKZUjxPUpk2Lpha4+BMjqaZxA9R
         ZMODWwgqPSxXXRcWdZ6yq4nl1WTmcmfOew2aZNAEGc31yC3pQqtFnZZpFctqzGWp7wNs
         +Vhg==
X-Forwarded-Encrypted: i=1; AJvYcCW/i3Dvp3IeFS783y4qYvSW9TP6K6LbRHIjh8qWGnmM9OW8+ZhmKpXVnX0nglJT8VxKic5oBWKz16nQ3Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEWLKymVWv8yoofkld4Qag8ll4Kz7tAOvz/fz0OQfaSEzS3p6
	8wv+wL5GD2b1sokunTXN5et0cb3WNMSSTXQvx5rWWIgWD3DbxzjdtdP+FoWK06JiyISIfSR4vNj
	Aq5/bG4E+8pDDD7fGBa9C5u7uTpFp/xpx9OERxngygw==
X-Gm-Gg: ASbGncvgGm7+DJ8WHeqBvx9vPNCFdTbU5lMyd+8cY33Yd9peTdvpzal3MhlJ/Qsi1s2
	IThc07D6n2+aTWlERY2RiDZUXLtSLkD9/4EwPIvoTalmGKbsoAyyiDMBqLJKTCZHhXmU5i8HVyG
	A8ECkg3k8Mgy8dSo00Es14GJb6zbJxeEY5xPP2FC7sr8waMvytkpsGOqAMUta4dyNvQD49CaMFD
	l+g/Oc=
X-Google-Smtp-Source: AGHT+IHKj7FBhJn4YvEWoDBBXtBvizyBf1uRp80BqxN8hVamn27Zko572Q6nuzWyGRHZWX8N75KkGWA1ysouHf3eFnM=
X-Received: by 2002:a05:620a:1587:b0:7e7:fdd2:cc58 with SMTP id
 af79cd13be357-7e82c684a08mr275759485a.15.1754650238850; Fri, 08 Aug 2025
 03:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807162633.3666310-1-karunika.choo@arm.com> <20250807162633.3666310-7-karunika.choo@arm.com>
In-Reply-To: <20250807162633.3666310-7-karunika.choo@arm.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 8 Aug 2025 11:50:27 +0100
X-Gm-Features: Ac12FXwZubGjX-KjBWAWJ55zqwf6_QveUqVQsmAMnzOas61qm-AzifcTiF3DvrM
Message-ID: <CAPj87rP9pETnxr_mVJ4OAwj_Vhh2yS75iQ5LDT7ddC5=a-kXkA@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] drm/panthor: Make MMU cache maintenance use
 FLUSH_CACHES command
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	Chia-I Wu <olvaffe@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Karunika,


On Thu, 7 Aug 2025 at 17:27, Karunika Choo <karunika.choo@arm.com> wrote:
> @@ -585,6 +615,9 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
>         if (op != AS_COMMAND_UNLOCK)
>                 lock_region(ptdev, as_nr, iova, size);
>
> +       if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
> +               return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);

Given that FLUSH_MEM and FLUSH_PT are the only ops which are ever
used, the below becomes dead code. Could you please just inline these,
so it's more clear what's actually going on? The (op !=
AS_COMMAND_UNLOCK) branch can also become unconditional, perhaps with
a WARN_ON() around unknown ops.

Cheers,
Daniel

