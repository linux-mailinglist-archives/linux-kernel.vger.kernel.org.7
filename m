Return-Path: <linux-kernel+bounces-889532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F435C3DD8E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F62818874BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E12EFDA2;
	Thu,  6 Nov 2025 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="atOYOHK1"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11E2EC080
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471817; cv=none; b=kRqtAz2KyzdldyVNaecSfBbV9xTU54PdCoaS8szFXH60D+bT1D9v20eyY8jDiu0krr8neNcUdjVcz01uNIj5yLLbmJZNMN0MFSrEeYOaVn9PXahKvOYU321+iIsAi/or5GZCa+iFaIY/9elcbaDbcZGjrGBT8h1/fb0zHUjSd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471817; c=relaxed/simple;
	bh=7sP9JRn/UDyFaH9N5MSFB17+Bj8xtMARWOWMifHGasc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i3qKt5PdvSNJAQ9/l5f+/2Y2PU0ioZyINTSlnc8TH9QTfBswJwnjOX1IoCTxbsoueFVxvGtIY2FbG1D2yv4lB96SZ1WfJUbxEvIw9TyHu8n6SJPaVoVij5XWVbA4a/VJxwfcxHNtJ4F5oicYzHDvUMCE/eiRgquox69OXDjxHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=atOYOHK1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87a092251eeso2223866d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762471812; x=1763076612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqSPWGiycvFbLPjchihb1T2SvIrY502knNF2q5NwttU=;
        b=atOYOHK1Zt+t/rSFEEbupy4StowH0zes9B6KPi6G3KC1Kw4VUP0Krc+RngQG5YVYQZ
         RkySCrSF5vXiVw4iGd7pnzSyYYdL0Q3Wn7OtmZLp4qTQkt+u3GyCgcGwAKN88RveNYYZ
         ch9HSNSHmEQcvqHGXEqNkCpaCLPSqOSdgvw1bdtV36s2pXFTqBv9O+E8ZHuJ0CNvMP2e
         ykqB+FXXkmECImMuG2FFMWeVaoQ3We/Gl1n46v4A45xTDv6FKwIM50oniuGs/6RX3lZy
         S5aTemSUqQAHfFXjK+znuFCRf71FSv+UJ9hhsM4ZEZQaJozcEO13tZeGncScmnS9+ZRl
         26lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471812; x=1763076612;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqSPWGiycvFbLPjchihb1T2SvIrY502knNF2q5NwttU=;
        b=KrtvX3b1kpjZDOUK1h5ZTEk3QtZ+y9xqTHL43YQvbo5djgL6cGatVT3UHTPki/tovA
         TB2V0tFtRI3howN254Sfywh8RV/qFbkXq3DGCOyCoPg9WA9qwCKvvhkHNBz1tMIB7Wf2
         ZVtHkXEfhBZWIUST0UXRKwi1k7bzdnq6LmqCU8jPcb+dnXky4arP70OAiBYfiY3O9DkY
         pl3V9XLNPnUAxYDfpcWSVWJyk1ui3iwSiBzU9v7uYThmXuLTF1q3pvy8vzy8LaykVtyv
         puO/7MM33GXsjtjrksIuEuXFbn7wbIQCyAX+oz3MQGuvdP/AG6IY1HWIAqxsBZJwskjb
         atVA==
X-Forwarded-Encrypted: i=1; AJvYcCWX07yFJH/TBwT8cGQvtmc4tgoZKI0Y0/4sYTUfuF98OGgYszYf6SSBSY4RubZewU6ewk8zcNZgIiCJj08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+9+JSppAhkO8OUkFCIzvQkRq30kb1prcT2s6vv2kdazkjQ8x
	0OiWXodSqa2zZPHto/+t0VrY5PthgPZqrIWK4O63HoLr2Uo2HSCw7Lvs0bigLCXjfMd3uhdjP88
	UVJVA
X-Gm-Gg: ASbGnctTobfDEd5oMF6Rq6iAWl3MCn/WnTCuEpoPkNocBexEWoMA+FP5eSlYmF9l8Du
	Vw+IxYMarw6J9LU1HLnwCXRsMutvYJ3/vhT5ehkUZvPD8JP8nvx1jM2mf/6KPijJRlA9uJRdpM8
	jMwwvDRPdYr+BCaIVnx8AUYNTHFjg9oXUxVSuSduqPx8NTCBVNbIjHluUGc9zHCd43B4t4PAC68
	fRYn1P+67byhCCyX6Wxj52wbpo0gB/B3Ld/SGSPzEU+PbK3HWhQTRtNcAAYgNBOAUmGtnHoVnAN
	8iWET5/I8r1W9c03S25pa29YNXcFu41MlK5aRutGs2ZOlI82Er9M+YP+RvYSCa/XE5V6ctikLBW
	yzPRosxgyot9e+HE3xxyUHMfyd4qwt4oaNZ7PIXYynarElUs54WzBlLPNCaXOZ9szzwK+Lmk=
X-Google-Smtp-Source: AGHT+IGDmBlkb9ElT4lc2YxQEJ4N5SdFXffADKJ69IM6oZ7HbmZNu+yoOhdj/jeCzkya+TTr6qi/4Q==
X-Received: by 2002:a05:6214:19e7:b0:775:6a7c:dbd5 with SMTP id 6a1803df08f44-8815d22a969mr20183576d6.33.1762471811920;
        Thu, 06 Nov 2025 15:30:11 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a37f10sm27786316d6.54.2025.11.06.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:30:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251106171647.2590074-1-csander@purestorage.com>
References: <20251106171647.2590074-1-csander@purestorage.com>
Subject: Re: [PATCH v3 0/2] ublk: simplify user copy
Message-Id: <176247181033.292880.16085659049514901290.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 16:30:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 06 Nov 2025 10:16:45 -0700, Caleb Sander Mateos wrote:
> Use copy_page_{to,from}_user() and rq_for_each_segment() to simplify the
> implementation of ublk_copy_user_pages(). Avoiding the page pinning and
> unpinning saves expensive atomic increments and decrements of the page
> reference counts. And copying via user virtual addresses avoids needing
> to split the copy at user page boundaries. Ming reports a 40% throughput
> improvement when issuing I/O to the selftests null ublk server with
> zero-copy disabled.
> 
> [...]

Applied, thanks!

[1/2] ublk: use copy_{to,from}_iter() for user copy
      commit: 2299ceec364eecdc0a5b4ec80c757551d130389c
[2/2] ublk: use rq_for_each_segment() for user copy
      commit: e87d66ab27ac89494b75ddc3fed697b5aa8417f1

Best regards,
-- 
Jens Axboe




