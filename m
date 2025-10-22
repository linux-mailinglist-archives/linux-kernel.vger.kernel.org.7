Return-Path: <linux-kernel+bounces-865592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF3CBFD843
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A88304F99E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893327FB32;
	Wed, 22 Oct 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yYhkhmFO"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DE272813
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153270; cv=none; b=mhEMtYqcBVuAVLIPdhcfRC+nhQhjtL1tzTWAqEKXWgDLBCQVzou1I4CNUbnx/j57Y5tosZd3hBdYvTou/8dFyFdXh4hBHgPEmWySVe2N0q6wc6Qs9nO3pD75yl0cm9CzlU42x9GMKXXg4MUZNL8D2CM4pYNQk4EA+TaWht6osL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153270; c=relaxed/simple;
	bh=alRvOln8Nm7xlD06ADuHu4fWBMIFmyhc0+nC9Kjtgz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u092sajrctMJ5Lt13sPNq5N1M+Wj3buVwmBg6lvHx7yzWaJM5oYFZYrTWoGppzMDz4YNvgbHI+GWkl4sywxmbjoQL6c0bisg0znlZs+kmLlHNMGZZdov7y0p2BpN/rSTI9tjjkIx52l+XDEm/o05aymzmFsTGSD3yV64QzOiX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yYhkhmFO; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93e8d7d177aso161748639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761153268; x=1761758068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02MaJ5QNPtaAAnY4QmtoKQvBiiM3OxRwrbvkWHDbg0A=;
        b=yYhkhmFOGHZ79ceAeRzsTTx0uIufp2jrNynNpQGjS7S+3KCfVr2bpmUpwJYH/OkF+1
         b9mIzOGpiNrIrauCc69AFuJoYt3+qRbNIDK8l/4rRoFv6Cw2ac1uqGl5MnnGe09P1vES
         qv2URYzJ5eGZAYcdCZ65BvMGL1rjbFXYFFKOXkToGWXhxLTr5UoPZAH1+0cQuiacRG60
         tuTcGb5GLXAAeOY2pikrwWIS8Ci5qQOt39KHYEsmsRNtXwZEVoBPhLkvlSgnITJMv7Cy
         58Ai49HfLjqrdEd54yvYAU1xC5SThHzljHjD3mvlCyer8zmZ1zWm+tnAWBVII86K4Ets
         7f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153268; x=1761758068;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02MaJ5QNPtaAAnY4QmtoKQvBiiM3OxRwrbvkWHDbg0A=;
        b=tCBnDxela1O0ljhNU7hKrHHQULCbP/mmbGi1tETHPu1TaBsrCkhMuRr6xNN8D6V35G
         ayQwEnQtYAW5uqWpQk2njAdv4GzBpOkw8OK0WAO9UNrNKEyfqSgzXe9MQeC/UvNoy1BL
         Z6Tjjwgn9TQCqL9E5Fdf2+FrP3Ex9y0ynQlAsk8sK36dEIaKirbDStWH8FnqWOqxkR8c
         /xGmROFjRqsLd2WO306Ree1KzGP720jVTcKJ4UJftN8DUyKS8zW2mjGT9mjBufyd2VVP
         IVFP2zOLu5BqRETz0MfkS3cPtgRredNRTOENi94lbluJFGHVhbV7SGRwkBVYKUAA+xE4
         qLeA==
X-Forwarded-Encrypted: i=1; AJvYcCUTHPAkEFN+rDxC5IyIAByiLyK5VI8CRgQAcpUjo5PSM3m8Cv4WNhZCBaZAlFvTWlRwYSDqXax3vKR64MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUfUyP3NFUVMVrpcwNKIcKVD7HlQ2FRRO9ixO0jjm6cJIV9iW
	hK6qIKZ85vaYDPWaY1k672xr1FM7HPtgaXXeKPZR2zbrtpWbq8W8bLGpaHYFPEPqJPw=
X-Gm-Gg: ASbGnctmM+X/YAnPWQT44z4U3TIxZ8aWGWVo4WT7Ah9E8Hekdy/mN0Ma5yBIBp3w+Zb
	wvguynOD5aA1eoMW0k3vmKgDdMxtha+5g0U1go4M4tQw5gLUUjtN3IXQRKYx1U5/agp1fOWrb3f
	y+UeGYeGOEf7bNFhQmRB3V9bdpYnFNAdKMTXQGil5H2BPB9sfkPC9dl6gwGfNDjyF3FpyTZUjgB
	a/BqrDwBcm1DzmHXTKJPj1zx3LpQyEr+OaSidLp+zg0RKXUyDMONq2R7FxFpIC+3aaN98+19r1j
	VhPyIHcPPGmaXJPgnTxpiIWvSDjUXzqT2RdOKvlPCsTbAqEhd0Z/++QuDDSMrRtM0DPVUVrf5lI
	EAprXyWw0vkC9wMFsjysRL4ySt56WKuesw8xBNMJ52gmrZrUu2VCSrnnf7solrDpnogwxcFfGFW
	EQbw==
X-Google-Smtp-Source: AGHT+IHTj61GCU43Ny9CqJZTcArqcqLG4N55exTJ/CO6XywRSm8cR6B046X/oK+en5lUBxrNojHA2Q==
X-Received: by 2002:a05:6e02:1a66:b0:426:c373:25f5 with SMTP id e9e14a558f8ab-430c527dc0bmr294941715ab.17.1761153267700;
        Wed, 22 Oct 2025 10:14:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07a82ebsm58994535ab.22.2025.10.22.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:14:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: chaitanyak@nvidia.com, dlemoal@kernel.org, hare@suse.de, hch@lst.de, 
 john.g.garry@oracle.com, linux-block@vger.kernel.org, 
 linux-btrace@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, martin.petersen@oracle.com, 
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, naohiro.aota@wdc.com, 
 rostedt@goodmis.org, shinichiro.kawasaki@wdc.com
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v5 00/16] block: add blktrace support for zoned block
 devies
Message-Id: <176115326663.119946.495631617143867642.b4-ty@kernel.dk>
Date: Wed, 22 Oct 2025 11:14:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 22 Oct 2025 13:40:59 +0200, Johannes Thumshirn wrote:
> This patch series extends the kernel blktrace infrastructure to support
> tracing zoned block device commands. Zoned block devices (e.g., ZAC/ZBC and
> ZNS) introduce command types such as zone open, close, reset, finish, and zone
> append. These are currently not visible in blktrace, making it difficult to
> debug and analyze I/O workloads on zoned devices.
> 
> The patches in this series utilize the new trace points for these zone
> management operations, and propagate the necessary context to the blktrace
> logging path. These additions are designed to be backward-compatible, and are
> only active when zoned devices are in use.
> 
> [...]

Applied, thanks!

[01/16] blktrace: only calculate trace length once
        commit: a65988a0ad047dbdb8a1eb6f07540b980858b522
[02/16] blktrace: factor out recording a blktrace event
        commit: 472eca538358fc8a56884a8adb0cc6047bf05cf3
[03/16] blktrace: split out relaying a blktrace event
        commit: 04678e72e95f4165d58442b3ed108e06605984df
[04/16] blktrace: untangle if/else sequence in __blk_add_trace
        commit: 70e3c62b891281b94b9d449a381e033ce592acc8
[05/16] blktrace: change the internal action to 64bit
        commit: 370cd70a402f972f6d7a7e54ba5a82d1a72c762f
[06/16] blktrace: split do_blk_trace_setup into two functions
        commit: 42da88a724d8a3b92ade35ae2ef4d5e5a491df2d
[07/16] blktrace: add definitions for blk_user_trace_setup2
        commit: 0d8627cc936de8ea04f3cc1e6921c63fb72cc199
[08/16] blktrace: pass blk_user_trace2 to setup functions
        commit: 113cbd62824afdf62d2f3f092809cf37cc7f1dd8
[09/16] blktrace: add definitions for struct blk_io_trace2
        commit: c44347d606260f36a81f6d8415a5af33cb3015fa
[10/16] blktrace: differentiate between blk_io_trace versions
        commit: 915bb53860c3a6cc3dd2c9a5e0d1988ada0e377d
[11/16] blktrace: move trace_note to blk_io_trace2
        commit: 67bfa74d81bae9271f6ec72d2058d081732949cb
[12/16] blktrace: move ftrace blk_io_tracer to blk_io_trace2
        commit: 4d8bc7bd4f73c6b34ba29d3e8277864c6e0a44a7
[13/16] blktrace: add block trace commands for zone operations
        commit: f9ee38bbf70fb20584625849a253c8652176fa66
[14/16] blktrace: expose ZONE APPEND completions to blktrace
        commit: 1c164fcc1b08e75f1cad1532718f09cddc0ddebe
[15/16] blktrace: trace zone write plugging operations
        commit: 3f6722816a73e2017599d965683dbe71833afd7a
[16/16] blktrace: handle BLKTRACESETUP2 ioctl
        commit: 4ae8efb4f907383a16abf3c59b353763e31ae106

Best regards,
-- 
Jens Axboe




