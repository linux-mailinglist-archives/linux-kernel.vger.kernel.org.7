Return-Path: <linux-kernel+bounces-871425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DDCC0D368
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CF0188B6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D102FB635;
	Mon, 27 Oct 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFco7s/6"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2A2F49E4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565333; cv=none; b=SyjKYgwEipkz3EKCDZgp4ozIJN5lBfCvcmsphUxcaO3ws2vghYLUqt21kE4rg9tHp1DNZqTlPmSNBT9uS+BiR2+c2kJM4PsTywNy9O/7hpYuYvFCAzVvBpezMOSiVPhCuFyqkAEuYnSdI7jrwstK/rc25p74Tn1aR73brVRPvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565333; c=relaxed/simple;
	bh=Cy6xgG22ImoRvVsfhnOrYcTI3bpmgDKeqoQ9Mmj1Tn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBQvVuIL0HfV2UvwebTQs3kezxvNIcnWuB6j83FFI34R5zZ+JxyldyYigxty7Py5wtYh4fdXbfUu/mI99gc5nKi1lwED32h4QyQxGUigrhoErJuYewWeS5TTWGAyDqL3cySqMpG2Exb0WCXdWN/aT5PT4z5IjkvAFtaE07BWSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFco7s/6; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e0c6f0adfso4556238d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565331; x=1762170131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy6xgG22ImoRvVsfhnOrYcTI3bpmgDKeqoQ9Mmj1Tn0=;
        b=KFco7s/6bF1+NOhO/3JjVOlHq/obbVjQmiKvtrJDVRHAntr8mjWcdJwYyFXNt9re0D
         4nAjZ3bmr7/vTpDNYM5bSH4sMioXbOlSFfu9idV9paqEs4dlypOtbaoZzi73bjZ0vZ1/
         9GBZvvBTkmTYy7WlOq7aVfnFmlQMRIruBqIrZ7jeTUa9J2NJh2QI7sZodUp+vkYZWpf6
         KOJ6HtPwEgIX5yWfqpsvKvcuFpbZO06JXCSddtfeEvjNrJkL3em3sv66fQlZ1r6x7oHi
         cKvz1YiQbgLPE3P1C3zRQ0a0SUE9WKKXOndujYGuplRXXWZiocfR5l7ERmF7KYNPWHEe
         LNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565331; x=1762170131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cy6xgG22ImoRvVsfhnOrYcTI3bpmgDKeqoQ9Mmj1Tn0=;
        b=qqN3o/E0KvUWoG55WoPucsJ6gsOZFeokJRb9480QFjLptYjLxNmn3VJ/NqnPg10j47
         Bj/aXh23I/4vF4Vu6FWakOYER7mniyFxxU0TJcJYpwwDAmFremyVFvDh37+OUVlmmo2Q
         4SQXGljFooZjVOIvZnMfNCHELK6hQDbdFQPi6H/1FnmK/Jri3n7W9XRyFKkzXHNDEsaC
         J4uA7wOQJDkLWa4vp9krXk4ztZ/Q0/rPYQljtGaHM7t5csL2Litxwf8LRFj5hXoudTzR
         BGhMqbz10y4NNpNpPW9YtKXthRpYgU9WFd+oL684CSn9Lhkq+CKc7MHaAgP0BpPDFWKf
         EFmw==
X-Forwarded-Encrypted: i=1; AJvYcCV74mLkLbP1YqkJ+PQbCFdzU1Sp2K6TNLt7dMCSlfNq/EsChRBNLqgJqimSZTlIGogmR4lzzqFP0cVrxGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBO567n7G9McyoTPkiQOWUDHArOXFdaeVmmg+dLQW5COJerxP/
	RqV9CrTZ5LMNISLwvdN4mylX4VZAz/SMrFe7cP9oXuaQm6lLqQPrKeJuJS9nX4ZJmvmGHd6Xmq3
	4XuuGdPKQTHY0tWCx5TMwGatofi7ui+AaLe7u
X-Gm-Gg: ASbGncs/X5INiKk8Y5phzInz0sa7zhhFMVNK2/BdSkLDKgpuNdM0sI7DEW+1IxdZCcd
	PZfeeEqE5r5VL58Briabwmj3w3eXMjdKB5y1IGiUar64RW2WrdSwuFnHRYMiKXcuWieQSMDJHUj
	IYvu3SGlCn8+L5w01RKzyrTNRMiiaPULWsvumGP9Su5ebwOoG65bs0flHlYmF2nrazzEf5K9hnn
	UE35FuwtXLWmCxE7ZkOC6aKZ9nm/D9n5ibGhNTvbQveZz1XWmAaSxYr23T7YKSy5lFJvqjfBKqo
	ROuYCpoBWCXkhx5aaQ==
X-Google-Smtp-Source: AGHT+IFFVIyBUciJhEdrSmCPXcpTypjEGn4Qgj9ViJLBr7VlEM5XbX9uzWCnWbhO+Qg4BOHaVGtJp0XNrYmMyPBe+Zg=
X-Received: by 2002:a05:690e:4101:b0:63e:1e98:fb2e with SMTP id
 956f58d0204a3-63f43560880mr7895415d50.42.1761565331007; Mon, 27 Oct 2025
 04:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026132625.12348-1-kartikey406@gmail.com> <0b618470-a8ad-4045-86a0-a8327d613a28@linux.alibaba.com>
In-Reply-To: <0b618470-a8ad-4045-86a0-a8327d613a28@linux.alibaba.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 27 Oct 2025 17:11:57 +0530
X-Gm-Features: AWmQ_bm_gC3kt4j_m4yQOfoKPEMD8eeEZQLpZWn_tCxtmxS3RW6T-Wh2QP2BUEc
Message-ID: <CADhLXY7_NT4e8jV=CV0nA6wLFJcrokGV2dRfp_cUJmX7=UY5RA@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: validate cl_bpc in ocfs2_block_group_alloc to
 prevent divide-by-zero
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, Heming Zhao <heming.zhao@suse.com>, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Joseph,

Thank you for the review and suggestion!

You're absolutely right that moving the validation to
ocfs2_validate_inode_block()
would be cleaner and benefit all code paths. I'll revise the patch to add the
validation there, checking for OCFS2_CHAIN_FL before validating cl_bpc.

I'll send v2 shortly.

Thanks,
Deepanshu

