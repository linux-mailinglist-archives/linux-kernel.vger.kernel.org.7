Return-Path: <linux-kernel+bounces-825687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AFAB8C859
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF04172E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5432F3C21;
	Sat, 20 Sep 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vZtgJ8hv"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935651DA3D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758371949; cv=none; b=StKKXRAKxz5mit+VTzXAloTTLPeaJOid77nlARh2oaSG5DWLIi9G6GKmG+tvF42t4nLNsIIWgexyEA9pQxBvfVSKfq+rbEqXFMdAmQPQZWJ+NpPa9L0K5gXiu8DWiV2qfDw0S6NvRlI+QaIq+MD19Ex3d3NKK5WrLXerf+P4vc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758371949; c=relaxed/simple;
	bh=OW0k8XHKzs0YOClfaUoGemzLpvEeKaPrwZecN04dhCI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e/UotD5Qn/vakRPxZelyQwPJmdueRcOVHzH6y3r86iT3gqA6hJf6CdIu+2Y1KL2+BVPtQXeRdF9bLWjZ2DjNFvXCQZoWQwNtSfKRkq2p4UtQc2CLjMwRYid3dE1/Y6Cc5aEWqWoYrsgGJz2Pju3L6TLR6GkNHmbNzGW1FPDzPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vZtgJ8hv; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4103fb72537so25982215ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758371947; x=1758976747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bidAfQtOZtQGsoz4PFVd7iuyWT5Lp9jrMKoC1aMEMZQ=;
        b=vZtgJ8hvhqlt45ljhArvvPSiC/usrc4U9x+uNHMYKBSlYjoBZkJnJ3mqRJGFLr+Knv
         7qWdFS46M0TrUZ+QsetIC5HaoRjuZkM59dBNUc66w7US1bSts0nEIY6N7UiUf4BSg1jQ
         5sntb+jcHNCT0FerVQF4zkXbIXEz17mk21jEMfhqQfcY9bI/2hXN3FWXwRI8Pg1ADIha
         HnJJuZ5JjWJnREbtnS3mktTNQQtL0lumR4ulcfPPefjhSvpBuDY4zSoV32/FjheoJ1iY
         kHfpuGnqFB7pLbmrzg8OyoC29jj2ihUg5lUltxeLnD3mMDoNEsZHAXrnX//InuGnQu3F
         Sqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758371947; x=1758976747;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bidAfQtOZtQGsoz4PFVd7iuyWT5Lp9jrMKoC1aMEMZQ=;
        b=f8hL0ujDO66DebGzm9kjJJbEpWeSIIeSGAGHk+TwOYfgfAn3xIItCfoZqc85gU/M6m
         KGBA9JveRsIjYdmPm48E19Is0dPNovHkGl6delbtHKOB56zFskTKr+tAV7ePwoD3C7by
         oasbyDBjPhif2mbyRUk4UmZYU+7PpKoS1FEPlQ+M9eTizbzLIWrpXA3tNQcuiKQ7+M2G
         fItusi/LKV+suG5KywbbxjeV3Z6i27Mb/5JJheelSYbAd8YDCbFr5T/3O0+yGjz0f/A6
         vrEIKCFPMRZeDTROphS/5QUMUE+62MD/lEqc5ZB4e32e1pbNckjWAOfZgl7d3Dp3bv3k
         HJuA==
X-Forwarded-Encrypted: i=1; AJvYcCUKo0FOuXQjK8ISQSYPncj/289Q59/jefYOO+P1fZkQyf6IrUJDJ0b0mvGk8CD3THNJshxFicJmV4Dii4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgAfR2EzDCocDvIynghlmIHsAASw4GKZrDuu7+n8mIvK0dIie
	XKiyddaMjub5jRFNOS3+974wuFUJZkrPK7vzU586/wsXD3xG+8XuusVX4F7o5A7Mo8A=
X-Gm-Gg: ASbGncvXwJ4nxVm1XnHtBdhU2ZFV8Fsic2ickyjAa9ZkA1Z13LTbFR7koagbN7C7rfQ
	H9nTQz4BRTIur+YI4T/D6z4M+aQZOSQLoccf0NVQxAUj+PkOka8kbrzBkZ2ivQvH6oDzNGmBPhD
	IychLjkKH+o5ChKJMQ+C0BPvyLhkwHFyBjqd/cOO/7eT8lspJm4W4Vku4Rgw2IRoYgdKOwLQ4Jt
	+lrq6GgGr1KgYsP5NUZxR5YqcFh6NW7Qh/A76tnSM6PK/r9GT+qAxUloxO4VspAM8qdPDbCgyMu
	GIwLrM74KydPNm5LEg9+OfBw09vo9PeRZ2kn+DhwVMA/3+OT0qnuFEzzFZHkd/DFaBMWzQgbKe9
	h7TiTrYt5U/ot9/Q=
X-Google-Smtp-Source: AGHT+IE/+QZvkh9DD/VJGNui9T9jMzfZLSYXQF3kQevUwzqzqn3Ub0plUjMrGl4uSfVSnH7oenyL/w==
X-Received: by 2002:a05:6e02:b26:b0:424:30f:8e7f with SMTP id e9e14a558f8ab-4248199c513mr99405665ab.17.1758371946653;
        Sat, 20 Sep 2025 05:39:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42482668b67sm22689055ab.21.2025.09.20.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 05:39:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Subject: Re: [PATCH 00/17] ublk: avoid accessing ublk_queue to handle
 ublksrv_io_cmd
Message-Id: <175837194548.917590.3460504068129272434.b4-ty@kernel.dk>
Date: Sat, 20 Sep 2025 06:39:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 17 Sep 2025 19:49:36 -0600, Caleb Sander Mateos wrote:
> For ublk servers with many ublk queues, accessing the ublk_queue in
> ublk_ch_uring_cmd_local() and the functions it calls is a frequent cache miss.
> The ublk_queue is only accessed for its q_depth and flags, which are also
> available on ublk_device. And ublk_device is already accessed for nr_hw_queues,
> so it will already be cached. Unfortunately, the UBLK_IO_NEED_GET_DATA path
> still needs to access the ublk_queue for io_cmd_buf, so it's not possible to
> avoid accessing the ublk_queue there. (Allocating a single io_cmd_buf for all of
> a ublk_device's I/Os could be done in the future.) At least we can optimize
> UBLK_IO_FETCH_REQ, UBLK_IO_COMMIT_AND_FETCH_REQ, UBLK_IO_REGISTER_IO_BUF, and
> UBLK_IO_UNREGISTER_IO_BUF.
> Using only the ublk_device and not the ublk_queue in ublk_dispatch_req() is also
> possible, but left for a future change.
> 
> [...]

Applied, thanks!

[01/17] ublk: remove ubq check in ublk_check_and_get_req()
        commit: 163f80dabf4f0c4d9e6c39e0dba474814dac78f8
[02/17] ublk: don't pass q_id to ublk_queue_cmd_buf_size()
        commit: b7e255b0340b5319fca4fe076119d0f929a24305
[03/17] ublk: don't pass ublk_queue to __ublk_fail_req()
        commit: 0265595002b989db8e0c32dc33624fa61a974b20
[04/17] ublk: add helpers to check ublk_device flags
        commit: d74a383ec70de33ae6577af889556747d6693269
[05/17] ublk: don't dereference ublk_queue in ublk_ch_uring_cmd_local()
        commit: 5125535f90564117506d926d0de92c4c2622b720
[06/17] ublk: don't dereference ublk_queue in ublk_check_and_get_req()
        commit: b40dcdf8235d536072b9f61eb6d291f0f3720768
[07/17] ublk: pass ublk_device to ublk_register_io_buf()
        commit: 8a81926e45670c6d9b6e73e0482485d5c9a627e6
[08/17] ublk: don't access ublk_queue in ublk_register_io_buf()
        commit: 692cf47e1af39f86f28069db5ca6b00a7d2daddc
[09/17] ublk: don't access ublk_queue in ublk_daemon_register_io_buf()
        commit: ce88e3ef33d35c740d26342be5d8f65972fd5597
[10/17] ublk: pass q_id and tag to __ublk_check_and_get_req()
        commit: 25c028aa791503fe0876c20bfd67b2676e6e24d0
[11/17] ublk: don't access ublk_queue in ublk_check_fetch_buf()
        commit: a689efd5fde7b39cfbcf43267bccf0e56295cc16
[12/17] ublk: don't access ublk_queue in ublk_config_io_buf()
        commit: 23c014448e97d4b59c54816f545ab963bf8dd644
[13/17] ublk: don't pass ublk_queue to ublk_fetch()
        commit: 3576e60a33c7f6be024b80f8c87312032fd27892
[14/17] ublk: don't access ublk_queue in ublk_check_commit_and_fetch()
        commit: be7962d7e3d9dd9ff5b6bcd3faccb3b0f76a9734
[15/17] ublk: don't access ublk_queue in ublk_need_complete_req()
        commit: 122f6387e845dfbfcf1ed795734a1ec779e987f0
[16/17] ublk: pass ublk_io to __ublk_complete_rq()
        commit: 97a02be6303646e19e9092042928b0e13543305c
[17/17] ublk: don't access ublk_queue in ublk_unmap_io()
        commit: 755a18469ca4eca3b5bb4f52704b7708a9106db9

Best regards,
-- 
Jens Axboe




