Return-Path: <linux-kernel+bounces-828392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3166EB9486E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3BA18A7B03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52130F546;
	Tue, 23 Sep 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pQNuksgV"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123530E0F2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608168; cv=none; b=MRANyOHvWqHZIqZ9SVunPQxnn1+YdkrMYxJd663m86RhMs7XCmtRoi7xk7w7Dsay3YbdvfF2je+WJl7YR7XJeRJoQKwIkyIP6BbJ1lvdCHNy1rV4PFi32nNPcRcwslwTL++o0SfKw/7XGmF18T6CTdWnwuOlV9mQo+YNgfhbOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608168; c=relaxed/simple;
	bh=hD3OyQ5pf25nKvDX44eZPgzgzaCMLNBDyqZl+ZVGAdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hI8TJqUZsUINinJwPtkkgAKfXPIbTQwkdOvGDQ+d+0nenAIm5His+V9ttpZPPtwVEpcOsgvByadEoYhIV8rxWV3YaamJ9xnGXLj3us0bfTHSPcM2cr08Fs+aurffwt9iOJ6cqQl/FH2ffZxIHIGP1x+9Ndk0hUBLD65qH+ED8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pQNuksgV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f2a62e44dso2991176b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758608165; x=1759212965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqB+MBmWbGWhXPKkNDOEdyh6sNxW8IJTQY+jeJPWHj8=;
        b=pQNuksgV6XfvkPUrE68/laDXSvCRDVjQznG/iTdXDBXW3S7Xrj/2y16BfBMTSQx1pn
         bpKUEMbiebfFjhRo5j8VGy9vzfiJshHArWmV5/ESISGfTYDQu9ZSMz7NKg3vn9DSAuRE
         0WjV7EVgCvMeRT0CSla5eBAGrhEh9/StXm0+T9r3IIJJ9dIoffMduRGBLyeqULEuVtal
         WP0zUUABx6UeTAuxU5eMEZj9IxsWvrJrSDUKr93k3fogPGcopdMDaaTFozwE2ZrjBKmD
         9Yhq6ac61RWCylPbdyS/iRwhq+0mIKQfCzj0B2De49Oa0pe2dMVMr/6UUgVjnKW4cfOh
         fDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608165; x=1759212965;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqB+MBmWbGWhXPKkNDOEdyh6sNxW8IJTQY+jeJPWHj8=;
        b=Ikzv6toZ/wbBk1ioKZfaA/E/QSeUbaa3zhQIwLmXe+tazZea/sQvINLrBhO0JxA6VJ
         y/mqWth2Y4T1EpqD0WEPb+XJIbegKVkG7IwcfIS7lkaxcwJkiXWQwSIxnQuH/06hqKxx
         BH6nIX3nc7EpisuVB4qWiyaTTU1yKc1+MaahNTc2glwoQ2rUiI0KfQJt2WWZlKjVcdrB
         apWbMYUdiizrncnVXWIyt2p3nchCuRTLlA4fzoLk54R9IZK3u79sVJjELRVQbTz58s0c
         xMp0y7X0b+A7dtZ4n36W7KbOUglxayxb4koA/SvTS5CvLjqgpeUN4do4JMREZ8nmmt0P
         WOVg==
X-Forwarded-Encrypted: i=1; AJvYcCUhkCd+4KxJNgNkLXQJQYlmFLsRMFOiDZaQbxU1NQKASMdOB8ZFR6suIElGDJ3r7XBCxofdcRNMK0ArGlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgu0EURXXiNPwSo5j1wbHcTePjh9KkFC8fhoE1txTZyE37bg/C
	NUuoFnwMVRUtnoJcgP4XDHNzvdAbWNJq1dE3futDC3yOyW/Qg3YAwWjYT51jUqZajJvSvO8/V3s
	NoeZtTIc=
X-Gm-Gg: ASbGncvBBGfLCyLR6Jq5scUjhbQFIyJ+YJatfMzmKhPaSxEfhplDGr1S1f/WrXDsA1W
	u+l9IMAtErbKTE71jXoNgGFGaaLa9y5z2c7oYBYonoOYfOnJZvrAIbEjBuFWUFVtFu9L7dMqRW9
	MJggJf9VOfa9FgzveEOF+nXz+3MF7FfPIFOLP5dfcW5Q63dnZ1AfiOPJUCTW+b4Iy1U0tvZz7Wm
	4J2uT9Je+iRZlBodq8s1HxF42qr48FPgAAlIPsbNQCWFYyVovaQDTDUqjjAwsfLRHGloktcq1o8
	l8KhIbgegy/KLZ7wePgOnvpZir5qleB/tkshv7csvkZyy1K+pHQFBexijSbxw5di2XlG6agtMHq
	5ezvc1XCiUp8bhOtHGg==
X-Google-Smtp-Source: AGHT+IHuGnb8PBfUENdPuGyGvLbbla7V1vgnkQ+GzlyH7sUUWYMzzRFQlMWMmSJwfIFZawKhZl2ScQ==
X-Received: by 2002:a05:6a00:4fd4:b0:77f:169d:7f62 with SMTP id d2e1a72fcca58-77f538ea09bmr2180704b3a.14.1758608165503;
        Mon, 22 Sep 2025 23:16:05 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24739fsm14285188b3a.28.2025.09.22.23.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:16:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
In-Reply-To: <20250922170234.2269956-1-csander@purestorage.com>
References: <20250922170234.2269956-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/cmd: drop unused res2 param from
 io_uring_cmd_done()
Message-Id: <175860816137.146699.7149828855280856823.b4-ty@kernel.dk>
Date: Tue, 23 Sep 2025 00:16:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 22 Sep 2025 11:02:31 -0600, Caleb Sander Mateos wrote:
> Commit 79525b51acc1 ("io_uring: fix nvme's 32b cqes on mixed cq") split
> out a separate io_uring_cmd_done32() helper for ->uring_cmd()
> implementations that return 32-byte CQEs. The res2 value passed to
> io_uring_cmd_done() is now unused because __io_uring_cmd_done() ignores
> it when is_cqe32 is passed as false. So drop the parameter from
> io_uring_cmd_done() to simplify the callers and clarify that it's not
> possible to return an extra value beyond the 32-bit CQE result.
> 
> [...]

Applied, thanks!

[1/1] io_uring/cmd: drop unused res2 param from io_uring_cmd_done()
      commit: ef9f603fd3d4b7937f2cdbce40e47df0a54b2a55

Best regards,
-- 
Jens Axboe




