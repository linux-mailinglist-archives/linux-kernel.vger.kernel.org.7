Return-Path: <linux-kernel+bounces-788481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5659B3852B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A5217A191
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADFA2139C9;
	Wed, 27 Aug 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Yb3eA3nL"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BD21E51E1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305661; cv=none; b=Suvcx8YFYuQI205NPI+WxEy9kSbWNWiMznxJpVXlXXdTumXcBA6UhbsO+Xl1MlTsoLntAGqwhOpnqAxF+Y2zXxzqls9EXvtzIuO1DK7gEKG8C9yEgZAuvY5YHi/wsvQzedPP9wcVullZm5lzUxx+2H0SKlFsNC5DSG3U8DtF1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305661; c=relaxed/simple;
	bh=VcCyV0h99WUADxaBXjHoNSU1j+lFTssXyePUgVwi0NY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F79OuVTKLmQcL8pxLdnQrXtvufZ+b0TiM0IcvscnM33amJ1qAajLYlPpcSefpz4xcWBB+KR3YI7dtfsIQu0+9UvRRoU5BjoP9lSZPr7BK+FxhdDGwUXNv8KxVLDYfsLZaGC/PPIIZukC3owz8VPjTp9kYpDWeFLei+j5DFZ0X10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Yb3eA3nL; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88432e29adcso175682539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756305658; x=1756910458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6jss1HK22eg3m+MD1IuP2xt6eQ1mCmZ4ofGe3ejiHs=;
        b=Yb3eA3nLo+gRCdhrzCWhAyFxt43p9EsWDgpHtRFmd8L4JG1NnYIfFUfKvr3b0qhm4l
         cdep6+0H1UM81J65+4c+1A8S1TElNIVR7fDVuRbuubx7rMKiGskPX1VZusUXOPJdjczJ
         i86YazY0TLq/uj+kDqhsIK/uFPeKV5uFOHjPGqEqT+OhiJ3RnUF6jRaKPqB0chCt5r12
         84kjg8RoKA1WZ1M778Ez0sowXyebOj4DqHj9qW6z0dMHNM0lVzaiEiWauxbIuJ/UBoJf
         RLhPPkW0WnP6VWFmOw9lOU+ITQNzln3zzuODlSi7bGzoKjlVDHiGIOR/flh9n602TXuH
         nTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305658; x=1756910458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6jss1HK22eg3m+MD1IuP2xt6eQ1mCmZ4ofGe3ejiHs=;
        b=C9n00WDu7cl3EVyX/l+rxafLKJnIZ31HxprBaa/j63W3EKWHwXz26gAoHUF7SEzR3/
         2xonPHPQDRtpuwxX7PwqO9Ezm2XPSBULEVAKtdbDLpwVNiB61Q4qjx//2++LjhdtPt2r
         l7PUEIJp49rkL7iG4pvxMSH/BJDah9CkmK4WyIO3TNN31hNM9HieyJ6Jy+4OXPnA6eHY
         f0mO5azxGFSoZv2DlHxmB91bsRlCK2m40AZkxcCI2VUk0Iu+SxMZ8z5+H5CN7Knv2xdU
         JC0lbxVxSOfsf9GKScbYxQ32V+PpBJdBlNfpwD7zKTtvt1p9Qt7Q9zqaRF0tZUUQBhM6
         dBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwgLAH+mDLs9halXyTAm/ZqAfbX0G11XEKZ78t7QzyJhhy3o2pESS1NrfTAI50AscGAY+ot+ES4RaoD74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC20g31Q0Kr3b8HrLPYwZ4pWbIb20/6pucNOchCxnCCOG5oXhL
	w7qpwhvP3BW2PQ8GOPoG7vDqF6lRiPcZzwl1CaMTbbkdjjKAZyhWia0imWJodzjsiwA=
X-Gm-Gg: ASbGncuQZwF3pEinzq+8XlRvngMkckA7nqt9scNMrfh7UU7e976bv6pnzrLHk4xgljp
	lWo0EIwIpkOiuv9E4QrJ0pjRfmF6ob5QtHt3I1mE1AMRvPRpM7DxYK2ArIHP+Uv9L+162lzk3yM
	tJ0tUDYIz9loEFXeXtUBiy1qn92fsl1LTchB744N1sJF9rCdfyrYc8mnMXs8XpEdwe1fHg09FpD
	+60LP2NMk+ePlKOO6vCIG2gflJ8Xmv4lyo/cGvHHxuKZR01c+8ltqWiq8Mpk9ljh3aQ0ehkGrkS
	Hs1HGDJSqLlYu1liVHCZZFtQvA3ap1pZUU3zmdd0l2WP9Ew1yXsTmnSzQHdap03vR5KtpLHMoB2
	e1JeljX4tiQclMcFCdI9hxdRh
X-Google-Smtp-Source: AGHT+IG4Xk4If6wny0cArzGMonADC9U9f3BTYeY/auZoT4YbfvzU+lW//x1d+jW8i+og7Gf8TGIcyA==
X-Received: by 2002:a6b:784a:0:b0:87c:a4e:fc7d with SMTP id ca18e2360f4ac-886bd2047cdmr2208034939f.14.1756305658194;
        Wed, 27 Aug 2025 07:40:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886fc6cd75csm76142139f.6.2025.08.27.07.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:40:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Qingyue Zhang <chunzhennn@qq.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Suoxing Zhang <aftern00n@qq.com>
In-Reply-To: <tencent_4DBB3674C0419BEC2C0C525949DA410CA307@qq.com>
References: <tencent_4DBB3674C0419BEC2C0C525949DA410CA307@qq.com>
Subject: Re: [PATCH 1/2] io_uring/kbuf: fix signedness in this_len
 calculation
Message-Id: <175630565742.226956.8766758074257445746.b4-ty@kernel.dk>
Date: Wed, 27 Aug 2025 08:40:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 27 Aug 2025 19:43:39 +0800, Qingyue Zhang wrote:
> When importing and using buffers, buf->len is considered unsigned.
> However, buf->len is converted to signed int when committing. This
> can lead to unexpected behavior if buffer is large enough to be
> interpreted as a negative value. Make min_t calculation unsigned.
> 
> 

Applied, thanks!

[1/2] io_uring/kbuf: fix signedness in this_len calculation
      commit: c64eff368ac676e8540344d27a3de47e0ad90d21

Best regards,
-- 
Jens Axboe




