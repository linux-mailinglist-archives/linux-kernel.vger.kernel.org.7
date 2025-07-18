Return-Path: <linux-kernel+bounces-737274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1F0B0AA33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A75A25C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAE2E7F35;
	Fri, 18 Jul 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qw6MQ+yq"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD792E7F08
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863791; cv=none; b=PG8Ah74SlLxOy9lt9iVk2/pbvMupM6sfasMSSkYeEscM1REPRCzNV/CdPgsnyU8/pni4VKTuKHOiC+3BDNYNCT8zNrKYYoql1pigkKDcHTnqVjJKBWKAWeMvDyT0r2xY9FaoqcXiNCZRpcvhzY+uLFCMe3g+ONeM+7S+edQKeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863791; c=relaxed/simple;
	bh=HmaDJ6KK/j+23WfgCx9P6RwpeK3ivPr/AAAIqHCjyXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CZgTgHfKQxwlb0TIxR+kUbpUs/Oy5lq04lYLFjsbjvxnmuAGgHNenx1ek449RGUOHFJDQGbDJ00x0sOnPqUbYcgEw3DLzpGD3fOV0CWy+/9mZ1PmppnR0WrT/VjVDvnqlJiPiguU6OlHVM1kebkB62synB+MaXpfEb9iC0yWR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qw6MQ+yq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso1959006a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752863790; x=1753468590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypu6ZHCyCszmGrmZOwZT0mlh993mGs8sK1TJDH55uDw=;
        b=qw6MQ+yqr6YxfiGojuoH29i7u/r/IjCUaJNQ+lekfuOy+6dH8EdG8hdOgfe3s6NyJ7
         gCP9UF43bjRL74cYb4eRUEBuWdPBLwTQzE1j0yd24BI1pmugxjlN68KUQCWO5VVAm1Ir
         jtnqHwsi2lwMznm1G+5mKQdaYDdcN5vsRwqIDjmjPGE+TgQY5iZrK2bs5d6PzNPEg8dr
         6NJJApLyTaWMhGL1JAlDKUU2Uz8X9gO70ki7O9SLaNOck75R+I7BoYLH33/txV6jsj/F
         R61UFXxizZrBH/F37DHl7nHAb39uRP7WSxYqM161f36k48MtajFykwviJOGe7Jw/3j2+
         lgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863790; x=1753468590;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ypu6ZHCyCszmGrmZOwZT0mlh993mGs8sK1TJDH55uDw=;
        b=eOuyUkS+UWHxBp+8+oQscmVT45d2a/8ZqXlNrTH3whRJKNxvUpmU58CTzM0PbJ76N/
         x2/dgWunsAiNgjJ9KH6+rgdMzeWsH8Ce0uu+KS/EUTzlyBm7Gy+8nC3MkQ5sfxjK6/zy
         AtebmbiCTooMYt//W3xFHkPlxnSH1h/zRUs6iD6UbKXepnr1vlYz1WahvzCD68WuvHsW
         e9Ub+MZwaff6JOCqafvpZwrZFOPe3b9O5LvYQ/De3Z7+nceHVFL6ncamjDvSykh5DolJ
         xnUWwsRJPa0RJrJecU0CizPXF2ufSPG4PSmEmfUCt0lcbMkxg5ce17R1r0RbJ9FOE7au
         doxA==
X-Forwarded-Encrypted: i=1; AJvYcCV+wj7qjb7v8cKzjykpI/GsE+ZuZ0kWDdVI0sulMjG9vIBmjiYFs6wwOKmFtljmJ0EvAhDn9ftrMIMjrhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyo2o8TWEXPH0IkNkSeT2ZhWrCfQ5cMKD9KvC+b/PzcwhjClGw
	M82aviQFRdEq3U3/Gb8MHvYPB8QyMTDLlsELKp8iyG7LXSI70v1um28xXpFOtmuroIc=
X-Gm-Gg: ASbGncv6b6X2ibd6WLMEwcwFkwrqLgTcnMZlJtnlgYDPFtyzsVlxUDkzg6LwSy6hLqV
	bNqa2NnAMq2rRDLlFMYp4b/5NMpzAmgUIlDGfjT4KYP5nOcI2RfFyMPk+HildmjuKrmN+fFKqrp
	8kJl3Res+Sc9nQx9KRJKqe706nUoa1KDnm/GvOWWYjGQen7A3rNefB/SJA0CI+Lfp/s1c9bT9Sn
	fO3iHRCocQamz7lT4QGJhiqV/K3B19f1GOFYODSGZQOoNG4VHzGEXaCD2Ze1/tKj1S2J1pPk+Rm
	w0HKDB7joC9DvoS5uhmiZ2NpT86lxCpyxyAYSoM2BdyXRJ/A0xtHVn9QcrCQz+lgkpWh8g/Ocac
	ZWKjLeHhSbmMCWB8DxoBJjYowi8t4n35VBeOiAzcQkmWJjTyi/s0Mdss=
X-Google-Smtp-Source: AGHT+IGlsDntYJxObfrXYgVH/QPpuidAJOMArNU0943U5rKRF8s3x8qPhf9Yje8PPd+9AhltaJnSPQ==
X-Received: by 2002:a17:90b:254d:b0:313:352f:6620 with SMTP id 98e67ed59e1d1-31c9f435558mr16657207a91.4.1752863789743;
        Fri, 18 Jul 2025 11:36:29 -0700 (PDT)
Received: from [127.0.0.1] (syn-071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e6a68sm5636796a91.19.2025.07.18.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:36:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250708202212.2851548-1-csander@purestorage.com>
References: <20250708202212.2851548-1-csander@purestorage.com>
Subject: Re: (subset) [PATCH v2 0/4] io_uring/btrfs: remove struct
 io_uring_cmd_data
Message-Id: <175286378826.415706.5386510015448817454.b4-ty@kernel.dk>
Date: Fri, 18 Jul 2025 12:36:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 08 Jul 2025 14:22:08 -0600, Caleb Sander Mateos wrote:
> btrfs's ->uring_cmd() implementations are the only ones using io_uring_cmd_data
> to store data that lasts for the lifetime of the uring_cmd. But all uring_cmds
> have to pay the memory and CPU cost of initializing this field and freeing the
> pointer if necessary when the uring_cmd ends. There is already a pdu field in
> struct io_uring_cmd that ->uring_cmd() implementations can use for storage. The
> only benefit of op_data seems to be that io_uring initializes it, so
> ->uring_cmd() can read it to tell if there was a previous call to ->uring_cmd().
> 
> [...]

Applied, thanks!

[2/4] io_uring/cmd: introduce IORING_URING_CMD_REISSUE flag
      commit: 733c43f1df34f9185b945e6f12ac00c8556c6dfe
[3/4] btrfs/ioctl: store btrfs_uring_encoded_data in io_btrfs_cmd
      commit: 9aad72b4e3f0233e747bb6b1ec05ea71365f4246
[4/4] io_uring/cmd: remove struct io_uring_cmd_data
      commit: 2e6dbb25ea15844c8b617260d635731c37c85ac9

Best regards,
-- 
Jens Axboe




