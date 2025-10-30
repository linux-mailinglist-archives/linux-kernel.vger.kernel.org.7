Return-Path: <linux-kernel+bounces-878481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8711AC20CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7822F1885BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C327FD4F;
	Thu, 30 Oct 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UYpe+p0y"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68A27F195
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836010; cv=none; b=ZV4EU5PGoLw0UX3vEwKmJcTG7fDA6uUZUXyWvvx5KRdSXojEjvaqrhR5fZb65ST/V8t0BToB7QQKoSkauHUgOv9rBnapK2tTfZyGh9wp49XzwHgRtq3i/48oOsj/0Yewe+3V7TurnWdF+zY6vlLNfYFiFcmqZhZu7BKeNWPlIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836010; c=relaxed/simple;
	bh=8t7GM5tM+1DuMZsn4o+XNbjnRhGNosioKoCdQWVqFxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TaT+69haOVMQPtvCvnQlZFy3db3LM328nkPewp+Vds6m4A/XhRF4/l052YnSLCnhCVO+j1wug/xBc8uxh1a10ZBPIiLySDqEYMXKtN/pco4xcH1VS2VcBodIicBDPmX+g0fgIaLsxpPxmEA9UiZ9QPdOwgLKRYOir5psWQF1hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UYpe+p0y; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso111642539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761836007; x=1762440807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhFqOAu+SptPiMypMtMUC7gxnfIXkWmUDgfnsfiJeSo=;
        b=UYpe+p0ylvNG+Zx636OTZaqc8wwZ54gKyozmaiporS2ndMwP1LKBhQ954CC9BW0Ue/
         XgTBbZkjsRMvuJzDbotcMrZTQqCsAOv9bMV8YFSLqaat9bNnBz0lA0DaxMF6e25Y9esR
         pgZgzrDXRNJ8Ab0D0EsozzISxnjhjjSfTr8zQdq2u1HbUrkiEGJPH+wci1gMdjdGQB6i
         3atsjxA3vxTLxywzrJa55ErsBN6sFgNlVZksNEfyu6itXGNC8EZHVN3lQ5jnfPTyisPC
         +jdti6uW+tmgIUVn9EhY7hdyl0aXmOwYYeR0oodMFOnVxTJlE3VXxu42whCQIBsLax1H
         1HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836007; x=1762440807;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhFqOAu+SptPiMypMtMUC7gxnfIXkWmUDgfnsfiJeSo=;
        b=dvzpUOkfedhH98xAoyoLKhvD8U5oEZ2wGI5bPWrGur8kwi7n9gmG0FDIKESkUgAKHT
         hgEs97mfUTP4cjZaDiOt58V/vY8RbiAwqoSvcegzWBuhJWwb3xQ9EwS8ERPpqwaQqbqr
         SkCY/rHllNob04IfNM2oyn6SOHVvqQF0vIy6iuQQm6iJl9oAk1bpDJiv/4/uqu4arGIY
         YAafipBWBzz9bEXEJ2tGGcRMSBKTXWwDeJhoklHgL76C5jqMZBBGpLXy4nyO0pEmoni2
         GxAVorGQe924OdRMyN9joYXoNwRkzrmw+Ji00X+M2nIQwp/R1JVM2gehs/ZzeMLG+f+b
         5XQA==
X-Forwarded-Encrypted: i=1; AJvYcCVTs/6YlxK1spmXvCB9PLp8ZdqT8q19lRQt4LAtFd+Dismri/oQF5TEPh9GFgmaQjIp/+d2q5QYCRnBcJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxvCecCGil+iwzAUWImjMr+NwwSrOG30tPZtZl1SC674xYaL2
	bKfQU4fBUgPzl1Md6HlY+MVRu1lw25tfOUaK/8g3BfgWdwS/F8/rvSVGc4GzKkFP/QI=
X-Gm-Gg: ASbGncuyY/eiKgyljQ8RuQaGHkaIQowrLlGDzMAP+klhAN5tTXRTNWTX6ggqqBzrFF1
	cl4a45nBfMPk7/nw61H1XWgZJMXO41naBP5OaywH7Fi7ShMrd0A118QiBW4kcJoXCkWtkCE1bwN
	WpeWYI2I49TAFDwf2IS2/sMyoj2lQvrmLPCNIv55seSbNIqUaCEfWiLE/WshmDmexQAFYyZe5vu
	oXlLuXbV86CAhjmXrkbSSmFOfiuT8XmOXiDBXXJOMuSF2nkxx6bMzzcqkvpBoHeY23EZrDFoKYu
	GgnTdinNJnqr2tqqDw5WE6dUCFxeH0Box1D8qtYfoSonPypgQAqsgGwIYkGuuY+pVesmFlfwWZ1
	bMiFkFAe3+8iR3PqbaJbGFn3p0elZu1H5EZstEgwRrw9I7Y/5w2n3Hrr61HUa8AzkNuo=
X-Google-Smtp-Source: AGHT+IHNlKNMhCpyTtQzUmP3QP/dmhwiVONok4m+6Q2KyoJswy7Kr43AbKYD7+R+w2StW/PfKdt63A==
X-Received: by 2002:a05:6602:6b81:b0:887:6bcd:7471 with SMTP id ca18e2360f4ac-948229f0c6amr10820539f.11.1761836006910;
        Thu, 30 Oct 2025 07:53:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea946dcefsm6758554173.33.2025.10.30.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:53:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
 Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
In-Reply-To: <20251030043919.2787231-1-cmllamas@google.com>
References: <20251030043919.2787231-1-cmllamas@google.com>
Subject: Re: [PATCH] blk-crypto: use BLK_STS_INVAL for alignment errors
Message-Id: <176183600614.453980.5145160114396578208.b4-ty@kernel.dk>
Date: Thu, 30 Oct 2025 08:53:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 30 Oct 2025 04:39:18 +0000, Carlos Llamas wrote:
> Make __blk_crypto_bio_prep() propagate BLK_STS_INVAL when IO segments
> fail the data unit alignment check.
> 
> This was flagged by an LTP test that expects EINVAL when performing an
> O_DIRECT read with a misaligned buffer [1].
> 
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: use BLK_STS_INVAL for alignment errors
      commit: 0b39ca457241aeca07a613002512573e8804f93a

Best regards,
-- 
Jens Axboe




