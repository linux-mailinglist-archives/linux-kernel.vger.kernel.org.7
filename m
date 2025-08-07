Return-Path: <linux-kernel+bounces-759060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1CB1D7DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17F03B2A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D501E48A;
	Thu,  7 Aug 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nr415/Cj"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246226290
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569833; cv=none; b=GTd0AHbJ1Fejkv64BIcpWAwHPbqy8WcnQlzQl3jlRrOzNAoyEk3fltufAOm/IcOi3faLq33Q5mIPcQYcd9LCr7IFd34BlK44vTginrg/DkkLrDzVXZpORcNf5p25EpRd/XPLo4ecZCQu7fb0lZiepWLyf5wXz+XFkyHXhw4BZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569833; c=relaxed/simple;
	bh=4DvpSd4yVqHzHkwCXz3p0CQpoTy6HFJdk6xU1V+cQ/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qZhlLIVv0rckKDjajbjMxrAkiVxaPxos86b8NQZW0WfUzxZkiFiTtC9GuYaqaYoXqqjRPniWc3yCqPG7tZ7bWxusaSqHzPaCzDn8+WD3Y5umduhZ1IdgxlqnegyIQX9KN91kSKeelkjuATjOEGrw4pD0VdS2+JhNQSBoTWA89h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nr415/Cj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23dc5bcf49eso9967985ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754569831; x=1755174631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovNXJZdNjCqbBc/USCjaRDfQSVeVkoTTcWW5YVZuA4w=;
        b=Nr415/CjjA+wLNX5sPmQKACatXYXHhmze2+qS+GL3BQBqWtD66jev3FQ6836Uerb3K
         Mm8kJq/dTTgQrosWItRd10EYFOR6v6oxy5uv/C31/aV4BBwN9xetC4Jni2pMY7ojF66d
         QmmW7ZOnJYZvbIpl1SMpfZiTfxS2Gsf8kVw8UY/fuZassHqRp8NGz+IYZ8PRT+KBddPH
         oK3VgIWbABvL7HJi//QFsbejVrH5NTtU4c6QmquUP8mLOyiPOgvvYWskkaAagwOO0Szg
         TOuoRNscY45QqOUB2E9hHTvvaXvjMmG0zTLRCXeQmi/ymmtbzK4k2DnX7jlMZ6JX3SMJ
         Gqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754569831; x=1755174631;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovNXJZdNjCqbBc/USCjaRDfQSVeVkoTTcWW5YVZuA4w=;
        b=wcjTpjvmDo69rV97DI4PEDnPvQermv838wLy2zaM3SMuXKfZA4HV83JNv4wayLVsEx
         O3VUfrAdRC1K64r1BDdzC85FnhFKf24cSA7gDzwU9EJRsAmWvUuLb754myorrODsjKb9
         kolzpzkdul4M2Pwoj2FoZN6sC+/E11JF5QY5GHrXa7c7we9qcHrRSKwDGvYizAJhVNJ0
         ZtSD03MpPOYsDJfbXu/eOnxkg29LjNeqQdW/jYmC/sSdgC7fOlmIIWGiSD3WgfIb2fLX
         myLP8V/+K8URFkIT7bqf8Be5IDI2qd6LUjQCpoS9hYibiPtSSxN+r+zTsR5HE2apcFLt
         6iIA==
X-Forwarded-Encrypted: i=1; AJvYcCWcCPwlt4g5Xcx3cdv5OV5XS3wQ0xvFGY+UyqfZLAmLPL8GcCUxr1+krk1G9v+reCOFpI46RaXIqKpB/n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiI6pNoHy1tWhojrO3wvPwyxKT49sscRVAoi//XLdO0/ypgw8U
	F/vIX5mgF+R5hBcvHtNToGcPcNh8TJ1PWMKziWaCuBxd8fpXLp2SdDIuTo01lwkEgqA=
X-Gm-Gg: ASbGnctWKebqEGDAADu6Cy+hwwYcd1TMphohcLzEB4q97CyyNtF9GOpuZyLAdqoeeOA
	zfA3ZBwlzoKBLeTj6BaKf6F5JdCmEI6Rgyr7VUrFsbeHXJpM6an4aQp/k4gAOgQFiljk/36YqhF
	wCv7VN9GgpxcQ+I1ziYfsWK2efalPco4P7ol+1fTZ4pd0dA1U4xmKTwdNwMmt+Zi7gCH3oPhc+j
	uaPLNmBWELjE3qeuaLNho4Sal9D38A1+g0pfH0WBIKKWA+viNkUhHW6futrOX+61Xtv+E5sSfgA
	eiKfMvUjS0QaN0UlhW74wvRbi19JjHV6cKhh2KAtAbl4nFkAL3t4fzytE1P/6J1+FTwx3uY9W8q
	1GRBn8PINF5chc24=
X-Google-Smtp-Source: AGHT+IHUR1uGhPGD/KFM4lnMJmJdwThick9UHisL5mR7cOdeMkJI+5hsCEoLqQMvzDZh6FSLvmhIWQ==
X-Received: by 2002:a17:902:f543:b0:242:5f6c:6b4c with SMTP id d9443c01a7336-2429f32c718mr89263325ad.18.1754569831498;
        Thu, 07 Aug 2025 05:30:31 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976ca5sm184428645ad.100.2025.08.07.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:30:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: akpm@linux-foundation.org, jack@suse.cz, bvanassche@acm.org, 
 yang.yang@vivo.com, dlemoal@kernel.org, ming.lei@redhat.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250807032413.1469456-1-yukuai1@huaweicloud.com>
References: <20250807032413.1469456-1-yukuai1@huaweicloud.com>
Subject: Re: [patch v4 0/2] lib/sbitmap: convert shallow_depth from one
 word to the whole sbitmap
Message-Id: <175456983026.306211.17359385146553083669.b4-ty@kernel.dk>
Date: Thu, 07 Aug 2025 06:30:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 07 Aug 2025 11:24:11 +0800, Yu Kuai wrote:
> Changes from v3:
>  - fix do_div() compile error in patch 1;
>  - add review tag by Bart in patch 2;
> Changes from v2:
>  - split shallow_depth to each word in patch 1, suggested by Jan;
>  - add review tag by Jan in patch 2
> Changes from v1:
>  - fix some wording in patch 2
>  - add review tag by Damien in patch 2
> 
> [...]

Applied, thanks!

[1/2] lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
      commit: 42e6c6ce03fd3e41e39a0f93f9b1a1d9fa664338
[2/2] lib/sbitmap: make sbitmap_get_shallow() internal
      commit: 45fa9f97e65231a9fd4f9429489cb74c10ccd0fd

Best regards,
-- 
Jens Axboe




