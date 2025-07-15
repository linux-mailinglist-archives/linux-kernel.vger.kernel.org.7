Return-Path: <linux-kernel+bounces-732370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76073B065CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6897A5047A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613E029B213;
	Tue, 15 Jul 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p726jWpe"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC529A9E4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603185; cv=none; b=RRpcQZRbm2rsfS1hnbAEPjq5HyrivusjOVHw3ks22kHIOaHdLwj/5wT3uENYT6VJM7gOdS1o6EOveNcEFWaLSthtrLxrA+9K0fRZt7aW8y1aZEfwLZITyBNaptwuvOFsSHtY73D89ngogs6mMz9nJF3gyfJ95ibi/sTb3kIcG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603185; c=relaxed/simple;
	bh=EX9IJIBE07MrxbjNekDEu4Bys7YOOtxBGSxYZ5KqQ6g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W2z2vYlmUOb5798m3iNkW0XySAWoBxUdh/YKra5LNN4G1US6lEfKHVvyOM72YIvbiAmm+qI+X95B+TjQupZZmaKQ+J6fXqzn6sWkwVJVJ/KWpfo7KuDDxssBj+WB4rFkBesnvBVjnUAMiiTUYAcr09OItEwp03A0Lucssinn3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p726jWpe; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86cfc1b6dcaso198439039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752603183; x=1753207983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD0vJ10NkjciUlBMfv/7NTn82Nio+gQ7e7sXbXu83co=;
        b=p726jWpe5VN5//j8xoDpI8DqEmjurbXosNFytWunlBovxFmm47TgX+8/WStOMS6mlv
         v8sLWU8E3r4NraMW8c7prvso8UucLrTrLVeaXUaJ9REBmRwfmgFSpo92qyeFReEMWi8v
         6EP0Su7ijnQMn+L0a/DzO7cy+qwwjiZCRY4EYmFq9kC+1tHXqKiH9IMig8mXwyMRvOC1
         VYs6IhdvUgeo2stGRBLzue9G+TfciZoPtfdzqmm6wd0q9a6Dem9vvaQshAY8ekoJ4/xk
         aVITGImBGCfSJN/Ta0eQdGoLFlf3X0HogiQbIdh2mtGQrNkWsCTolFSbG52RWbY4NPXR
         m7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752603183; x=1753207983;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD0vJ10NkjciUlBMfv/7NTn82Nio+gQ7e7sXbXu83co=;
        b=T/F8NcnVyYPcsCF4Y46vB0yi0zpSaFpKA7216AEqwPPCBnhEbmix9BYrzs1Op+4tL6
         Q87ILDCNEsVkZ52blJosEOLX0gG8Yf/8ICzz2vW7+nm5W2Rst/PSeyPTpprccm/ZPmnl
         i0mKc4vnXhimC1xw/8LRJYnLD+hEyWvEZ0WcWRihWB07VdF5Rua2/OYj3iu2nG46Pau6
         ilf+bUqzFgRBqvYpkF/mvi6BxdXZIPO/mNTklEnUIM8U7YVPiXQ7c4D4Lzj1LIZP2kRq
         l5OiBOWz+xf0Ih21GnXvtJqSckhQL6K/bcaPklE2PjdKjOxIUSQlnqfd+rY8L531QU8I
         pcAg==
X-Forwarded-Encrypted: i=1; AJvYcCXH2WGye7RJN9T47GkIsLdpXLLRCZzZDaqE7WkxkC58yneGuVMzwStgCpmHUJeHqJg55/tIT/VVoaWwq7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3JLa1alJmnAIi5qUoZsm0bECWj+vpyWefV/nHzOUodxKC5xT
	3MSPF703MK8zvAfvEm7tZZCxgL11TyqSOs61qVcYK84Sk0xgpjwioY89WmR5XeTkIVcxUHieV35
	jmFDM
X-Gm-Gg: ASbGncsjp2DB0Vf/gFI1qvUdR7r7ihEnmzf++wIgQNWEPWKTEqZPxxI9E+7IOek08oj
	gdwBjPXI0yoP7bU9kKTsJgGcI1CWbxXMSEvb7KCGgfK5bq9wwH2jl6+XQDZnkbWdneXpAo60/LZ
	RhmewpoQ7A6EAYE8GGq+/N9V4aoaJBktPDWeg4EfZUzFHxgPxjQiDv2I9EqS+A9jtz9XrEGVCdr
	zC5/W4bNbBYIGRK4ixGCfKIjZ/PzYlWkiZxD4SCMYywbbA77SODBmSvuP4daZrbQNn0qehRGUEs
	xer6BcY2qO1XNZYpYDHjgLbzlm4V5xGu7oTXPpo77qFHzTzqBoPCSzv/wizPuVQZMNsdyKkWmR/
	EYu3TDruatOnq
X-Google-Smtp-Source: AGHT+IG552JG7n4td8lyOkEY2AdLnq++1FllxqUqpHx566DhENpB4MIn3derfPlgLwY/V4STyhuYIw==
X-Received: by 2002:a05:6602:14c5:b0:879:66fe:8d1e with SMTP id ca18e2360f4ac-879c088b6d9mr51206239f.8.1752603182765;
        Tue, 15 Jul 2025 11:13:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796bc1313asm318097639f.28.2025.07.15.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:13:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250715154244.1626810-1-csander@purestorage.com>
References: <20250715154244.1626810-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: remove unused req argument from
 ublk_sub_req_ref()
Message-Id: <175260318198.192467.13750945616516417106.b4-ty@kernel.dk>
Date: Tue, 15 Jul 2025 12:13:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 15 Jul 2025 09:42:43 -0600, Caleb Sander Mateos wrote:
> Since commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()"),
> ublk_sub_req_ref() no longer uses its struct request *req argument.
> So drop the argument from ublk_sub_req_ref(), and from
> ublk_need_complete_req(), which only passes it to ublk_sub_req_ref().
> 
> 

Applied, thanks!

[1/1] ublk: remove unused req argument from ublk_sub_req_ref()
      commit: 01ceec076ba10cb6c9f5642f996203170412cd78

Best regards,
-- 
Jens Axboe




