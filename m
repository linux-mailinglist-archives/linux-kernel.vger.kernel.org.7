Return-Path: <linux-kernel+bounces-844342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DFDBC1A15
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FD134F6F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4CB2DC337;
	Tue,  7 Oct 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CVmTL9Tp"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9A157480
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845890; cv=none; b=EaO3gKz5pE8vF01ZXCUZQ/cEtqlYXKEQwfd0WYktg6lx7bJec8NigINtxcPrxyUs5lk2EmBBlw7mDoY9bjafox7YQ+EmqA9YAW5iSkRjGr/dIuXMUHTzYeE56TiM/OmohxUsCyTUFOKo4R6UMuyGruCUb4S8tHXBpjIZNwC2Mvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845890; c=relaxed/simple;
	bh=ijLAN0exJCji6rgx+CHni2NaV0Mf3H8FK7MowTwd4KA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f7lchIsDtPfk6PUumlHN/gJPnudo8s+DIZ3Bn2I9/Oq7WIT6C2eB71D9JaQUJjf3E7wrNv7HQWzlpUwrhj6QcZOHbw6a4zqWw4CQaT0htp4Fhb9Vhm96dKzTtiqzqdWYwwRl4ZUGOUoA/QKhlaxgyR2bAjZh9wxTEwjtDsdbA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CVmTL9Tp; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43f88d33872so2443247b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759845887; x=1760450687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErqCQuWU4GRUllCeMfERo8Njpa/eKfO7vvWJYYk50gk=;
        b=CVmTL9Tpc4TsIDQt3KI9LQVxJv2SkbJwmDKh4afYjFDIyzrtGcGyTtuQikIYDLPQfS
         15GdFM0vKXybJpzOhEpPSxgzOyCeCFO/ZGexrDVcSGNiY2veiXMxtlh2aFbxbHdL6ODK
         rOFshyTGhYu5Obs/iU0624jGErK5k9ZBNO9RogwlBcwDkvohg9pAlzYDn4knB34qd3iF
         HeTlZRW0/cl6Q43eaM9rJbG/s2f3gcjTfLhBs+dcp8AIk1N8I9L9r5U36tqblp0skeDm
         JXmJv3LTWyZ1Pm0mbkpfDukMGoUGpEO8/A1DJb9c8BZkC8aO21K16QPdINtE3jOpoKRO
         wrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845887; x=1760450687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErqCQuWU4GRUllCeMfERo8Njpa/eKfO7vvWJYYk50gk=;
        b=K0SXTGR2YwEPxZSyJ4D5AfSeQcHH+L9l/Y3YQZQUZfkt0Mr4Ag6S6RYWbV8VbFUSIZ
         6u/1JE0S/0SXFLsp8Im7lTjyrT6ZK4P90xNjzbKCyu1kqQXa9AbURvFleGlCXQR0hiuk
         fBH+cmPIExXeyE5BvZkFHzuVXKdhv3f0+oPVZOh9scYcdUVDAdGLOKOdHKDmf28F6jFV
         9j31eZXZs9+NfYgZP7gdyhJWICxwKQlYm1amcl/cxEkp8+ZSD/H+gxQPoVTw7tgHhnQF
         a5phdRSAgbI27TZtW/+H5x9a1svBs+L1N2+es/Rb0FszbHE1pFg6hGUdCUPwQRJx6hFG
         e/rA==
X-Gm-Message-State: AOJu0YwETInR74Cs0djpAAqb2HvbTOhHLJZXgRpgKcY3SSP+CLdKKTHS
	Xubu+pkqGWX31hzN+JdvkNBIXNqZelUWdKYOHTjW26kgibQXB7z91NlddYjGS9boJN7ig1P7lEG
	uZSOuN7c=
X-Gm-Gg: ASbGnct4tDJ28fZT9SQI7mOyjlxRooL4wP6puhTqREDd6XEvse3Fs1zsj0gbOtCLKiS
	JzmpGVY+F4gvsUq4i38+A/+LkSsFQQlF0DmNwM3ow26CH3ImmKZnFKJA5/I0gLV/x2mEcfaJZkY
	akaTDlO5btAH/GskBVDK/ccYRdvSErhBtuJ8WBv0ktnfVDIFtFArHuvJ/+VI45nXBKMnxFtNbqO
	9O4XuNUoQPcShRtmE5HhV4FPUM0R4FlHCmubwfibCqQZ2FleEx8MRoVMD+08WkAkN3SHcpkvJ0b
	7oLil5A1tbAxL2Go6fmwQ19yIDIlzOEFprVHeGOsiqsQ85wDhOEas+YB9BJ6ux0gUhn3246Xz5Z
	yRGTXOycSTfKudTxuRRfwYe5bewU5zmK+OOKaXsc=
X-Google-Smtp-Source: AGHT+IFSCjmQBh9z5IS27ZLrcF5NLDUQRLu/27nCbuXAxqTDL0C5q+k2u9OUG1h2/kpqOvFVSSlxPQ==
X-Received: by 2002:a05:6808:250e:b0:43b:8cf4:9284 with SMTP id 5614622812f47-43fc17ad13dmr7686074b6e.14.1759845886612;
        Tue, 07 Oct 2025 07:04:46 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec4aa7dsm6045985173.65.2025.10.07.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:04:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Haiyue Wang <haiyuewa@163.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20251007061822.21220-1-haiyuewa@163.com>
References: <20251007061822.21220-1-haiyuewa@163.com>
Subject: Re: [PATCH v1] io_uring: use tab indentation for
 IORING_SEND_VECTORIZED comment
Message-Id: <175984588596.1934259.1809567091954753640.b4-ty@kernel.dk>
Date: Tue, 07 Oct 2025 08:04:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 07 Oct 2025 14:18:18 +0800, Haiyue Wang wrote:
> Be consistent with tab style of "liburing/src/include/liburing/io_uring.h".
> 
> 

Applied, thanks!

[1/1] io_uring: use tab indentation for IORING_SEND_VECTORIZED comment
      commit: beb97995b97532e1f215e3295e6843e59862f94b

Best regards,
-- 
Jens Axboe




