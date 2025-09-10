Return-Path: <linux-kernel+bounces-810087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F48B515AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515753A97ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1B314B88;
	Wed, 10 Sep 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ppKmTRep"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE827E7EB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503803; cv=none; b=C66S4M63714/tO8h01tLZIXN8S6TmLzBe2RAVeUqgoBzzN+hYZ7/N1Fkda8Z7s9tddr8mofok77KnLdGHaAv5chMi7AZqKQeVddvR01EF6SKKrrORWhvnKs2ZXlSzu2Z+QnPscMiCl5u5ZfapUtmhDJfuZSnHEVGMp5QDhAjmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503803; c=relaxed/simple;
	bh=r7oyqM25Rv6UNG3H4S4h/UY1G2EHf11AKE/M9IriSVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nMU84IR+49dd1WeP0JMUOXU7t8SyBq3EWJtgcxkjmwkjeBucPMjjxOXBAKv0oyyn+TqdsDL07TVWZ7IjW/8gztdHbnPVaoqATsBfJAAXNY8b7tBg5WALgzxswL3mx8UkTm3URIJZahxxzpO0oehFeb+62F8P4+URnTZ2TRZpAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ppKmTRep; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77256200f1bso5834566b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757503801; x=1758108601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdgr8V+lWooEJEpjFk6RgEs1J8LDzR0QLCG3DojQRoI=;
        b=ppKmTRepcjyb/FsTrK1LSO/XsShRhrc7zXUptHFERoz0mmjrDfR9RJDzjN5X7AHOCv
         mS/janrXyKZ2+GXrDEpyuT4ObzEgq4STmyLjHTWT+JQDyAKK87EufCwHf+BCKfWS+Qkt
         uJLHYoltjWseaF2t87a6OL3/CjIigw6grkoek89DxJmI5LiGOUMkxHNwYWUcP8fnCEF9
         YVMyz74S/haE3DxLHZBVC5Tc6SGYw3EHuX3wVObKEwMcFovqtsyTcQTpb3GkHpW5iLeA
         ExP5AEMKhk48EBETU6mtasqad9p8JAU5+ANppQNJ0r3KbCb9+PTRKIJixKro+L1B/xDT
         f0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503801; x=1758108601;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdgr8V+lWooEJEpjFk6RgEs1J8LDzR0QLCG3DojQRoI=;
        b=wSKInWfMzjzTOqJHo1MsDZ9+JtO9pW/nlB5Ty48n5Jqk/s5NBjvzvj1vlHL1fElXsB
         xvjlJrHKtMt0sjoZk3+UYJZN9bMEyDEkJObr7wWGH5J9zFssC0d5YgptPXIQ8dPSLS2T
         vrBw8EHFqGE/MKmdGNx9OY/E+lGuHVNm28JL0k9kuCYpmYeFdu10t5czh/DoKoxABItb
         dqLccE+AKwfOTPkf9r60eNBFVe6RI2yMJ/7jjvMPv9bQS1dIlzTm2v2dIwqaNyi+JQ4j
         sDCO4n1Pgl7rqUuNhXMiNpCYkm5DbCes2zjGJZAldJdGf4B5EYO8AWQhTFeX5T7f3fnR
         Uv5w==
X-Forwarded-Encrypted: i=1; AJvYcCU8Aw+clfYs4RHHv7tXwDAQwBPuJLpm7oHMf1h4CrqVOl4wqIY8lVpDVc9oXZepWIxuLosQuLDfAw47Rlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMROj/1OW5SWNdbeleFRZkoiZhrE2DF4DAplyYdu+WmqWkWCsD
	wBf9EMgLqXLL7ANc4Se1jyC4vmitXiQBpckulUSpOwEbbryeF1Ky/k15p5PpSXXKVXo=
X-Gm-Gg: ASbGncsjlVYG/Cmu592T6nEgFHWbO2eSJ/8kJTUKagpvC/u/Ygw5TrxOkC0bfvWDgFz
	VyuwKWuWFS/0T4mGDDUB8R/VssIUQ8ZN+uJb1eiwQEU7ttjDtqnmaSs25uwEuOTdyaLmqTLC55o
	ysOk2QsfNpOXN2/r+SARz8Opgea3XiWmiliQqQN0DV2cM7p+bl7Sn5DM+PDgWkWGmeGpqulhopR
	+WrdpFomi3yBQgJ9bGDZS2rEW5juXEOvMCdoHmI3FaawKlah3niqYcNzxHpjrTIni948Ol1B3CT
	QvsH1s3qUYFwQedXJEO5l1za9FraViNv2wMWmizSzrj8TT591XvpwnAGYBomRRTnhEhEgzojDGY
	HAFIOA2W2RfzO5IQod5eMTyuGBA==
X-Google-Smtp-Source: AGHT+IHqJjR620pJipMMNQmLWBVZ/pTemczUKvgbeUD9ETTgnx52MIwaJYp9qC76TJj/X/N799m5Rw==
X-Received: by 2002:a05:6a00:4fc3:b0:772:5487:c37d with SMTP id d2e1a72fcca58-7742decfc03mr18272135b3a.23.1757503801207;
        Wed, 10 Sep 2025 04:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662920b1sm4964965b3a.52.2025.09.10.04.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:30:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908184542.472230-1-csander@purestorage.com>
References: <20250908184542.472230-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: consolidate nr_io_ready and nr_queues_ready
Message-Id: <175750380033.204398.14564992598850434752.b4-ty@kernel.dk>
Date: Wed, 10 Sep 2025 05:30:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 08 Sep 2025 12:45:41 -0600, Caleb Sander Mateos wrote:
> ublk_mark_io_ready() tracks whether all the ublk_device's I/Os have been
> fetched by incrementing ublk_queue's nr_io_ready count and incrementing
> ublk_device's nr_queues_ready count if the whole queue is ready.
> Simplify the logic by just tracking the total number of fetched I/Os on
> each ublk_device. When this count reaches nr_hw_queues * queue_depth,
> the ublk_device is ready to receive I/O.
> 
> [...]

Applied, thanks!

[1/1] ublk: consolidate nr_io_ready and nr_queues_ready
      commit: 97e8ba31b8f1b743c918bf31586cdc272376226b

Best regards,
-- 
Jens Axboe




