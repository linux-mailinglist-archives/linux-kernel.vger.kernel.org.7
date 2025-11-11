Return-Path: <linux-kernel+bounces-895692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71452C4EAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FB504FBC46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42040357715;
	Tue, 11 Nov 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M4yTZ2ks"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85E31283C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873150; cv=none; b=ZKVa5tXJQaSQ7c8ZsF5obpHgcjboUvykfW3/sIjbPcu7iQ7G4qmbj2lyZroCbdABcH0nnFYcfibfqiLn/o3tfD4UJT4fBgyqrJ5iQ4yOpMlcthk9TZwQodn2oEDDGG2Z20dllqHhItfGNDPoK+vATCeaKvXvzTN0rSDL90Qlucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873150; c=relaxed/simple;
	bh=qEaGkMfx5VUeXh74134wsNL1eqERWxMH65ur1KtXx+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YDBktqyzkCZnWyEWgsHfBX5nCZWVco0ADvaXtEzxDX6AIBhXJ0U93bTK/QeRP76jMw954HtG324GZqQoAIwciEZgtTcZLta1pqhaIhc8V98gINGXYCcOfGyla8iczr37FwZTflus5RgirqAocdCS7P3GWkWBmAs6SiyI8tnUJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M4yTZ2ks; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-9482931b14bso403604339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762873148; x=1763477948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94xYHXLcLodrN9S6cw7XBT6pZAO9PlVXvEyYIw4z5vE=;
        b=M4yTZ2ksXbafiSQZUxcns1spl3p2ZU47JyGD3Z9O7EjoM8nsugdCECSrKy2ARpWQD8
         0WdeslHlSoM4NMebpyUCf/Owmue5ITLnFyEDt314PZ/kj7ax+BEtyxoEmp5C/sUXu96T
         KBWjCKZIkDM5x1xPeoqWazPwdzGYcg/i3ZsexPYTLrwbifTZSssdG6l/20AJKWnoXCgR
         /1ay04JVHzRCXY3/fKIbsZSJNYhcSHyEL0Wj/vVAKEFEtwIr2jZ0UPzSKK+wd47XdGiJ
         qfhf9LUBvRKJKOdvmfzDkykQK9ICO6jvZqu7TjKkkLdb1Xu5ixQKgYL4oCbzXe7B1Hj6
         hY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873148; x=1763477948;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=94xYHXLcLodrN9S6cw7XBT6pZAO9PlVXvEyYIw4z5vE=;
        b=Z9ggjc6/iTKz1u534DMg4hUaaFa2Ng9k4fquOczx8LgE7AyyWF7JojdC1oHIMIZL14
         5JGCV0yyIrJRdKo0jJlNpBHjgSs1tPi7QJvZNgrCjLrz50sObuYyG0XIDDopEi0Cp9Jh
         zLMI1dm1+oZVJexTApm8GfN2iM2mgnPLP+6j2whXlscpTIj+OWnwTttbS8XqTvr1uJ/D
         Aq/PupeHBUZlMCo4hLNwKM33CluYq7TuctEzbpPUTAfkJtuVzGKFkXkatHRe/v/+uNPh
         arxVeXtC1h2gUtgzlTm/mTaXZdZK26NfxgKMF3s2YaBykdgbtshnRZiJtE+oSvzuL64d
         VoPA==
X-Forwarded-Encrypted: i=1; AJvYcCXtfcYXtDkxrT7JsVSOVPtEoer7PRDS/3qvY1FYa0Zk0WmlRZEfMtyLMVFHgBfGFGwGJvutmKQG76Hr198=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyN3WkUNrkTYCm28GcD2jWudZUvN7/5f0euvv0O8Dz2gCMwL1
	Str2P7U/mucWI7uYGxQicgo5bBskzIeTAk0butR/FsCBFn9xjq9Ui48p0IcmwB2Lmx5OKZm6eRc
	8Pe/w
X-Gm-Gg: ASbGncvSJ7j9yS6Kxps/v72q0VVH0En1JGPj2pctijxfOxa4DZx3P35+mg4pFzUV1oy
	hGXH0+rT97PQS6D50878GiVf+NNkGFsT+IpOWmjaZ0LPF6MQiyy2Ul9feRB4JE9yXNU3A0fGt/k
	fzZBdBELI/KxVjnmEywNXIpF6QJh2R/cMOiAgh5B8NSQt4eqOf/1+JaQuWiBvcmmyLPQA/uxkZs
	q1pepsHtAn6elmDSBneArSa3Nvue0OzPHQZQcT5I/2t8u9ultIoqZuD+odNYmEcnL4xYjgRwxjX
	LMIsnb5cV72IjBft/Ctlmg/IMg8epaN3GfMjzJ1U9e1uxQfNBQmQkJhHipxUOQcSzyFZdxIIiwa
	ffJgeu+7lsAN3yzy3PMWYZTQ0uzEUSorDw/zbqUnW9Dt06GqecNpX3VAxix8BJF5aN1Y4
X-Google-Smtp-Source: AGHT+IEFxXJKTMjulTBKec6Xg/99gfA1xveksPSnu8gO/2YQsLRPJr1wAxMDhBajjcAMNaF4ebrURA==
X-Received: by 2002:a05:6602:164a:b0:948:7ba6:345d with SMTP id ca18e2360f4ac-9489601ce74mr1756377939f.15.1762873147984;
        Tue, 11 Nov 2025 06:59:07 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74695d420sm6036612173.46.2025.11.11.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:59:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251108042317.3569682-1-csander@purestorage.com>
References: <20251108042317.3569682-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: return unsigned from ublk_{,un}map_io()
Message-Id: <176287314689.174455.14830424717777782580.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 07:59:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 07 Nov 2025 21:23:16 -0700, Caleb Sander Mateos wrote:
> ublk_map_io() and ublk_unmap_io() never return negative values, and
> their return values are stored in variables of type unsigned. Clarify
> that they can't fail by making their return types unsigned.
> 
> 

Applied, thanks!

[1/1] ublk: return unsigned from ublk_{,un}map_io()
      commit: 727a44027815aea13d34c28254d386562efc3bab

Best regards,
-- 
Jens Axboe




