Return-Path: <linux-kernel+bounces-808511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE1B500B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D09A360DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13352350842;
	Tue,  9 Sep 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zZuzExnM"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB46256C6D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430731; cv=none; b=A3o+11JBVbBuIZrNoIXq4tCoJI75Ow5lLIcAVnqkdT5QNkPBKsfcHBcnRUcXiG3yGrYxMa7UuCGwkqnYtHDp3isCIW/G5E1AmjeSnAjc8tzI0UAb35Inwn0Pix4pyCFq4pCvYZm3MHCQs2EhFWybnLYhrmc24L9YkKyFyUTsN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430731; c=relaxed/simple;
	bh=101D41jmWYkV+zFsW3b7QLgwgu/houCEVy2LvkK9l8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lcbO2kXM8qMjsOd26JAp7G6lZfz7yZXyV9IVdOUY2xg8SMTgE7hKWHzdZhijXSioQkJdRPtFkuSoLKly9kB/S1a194L+C6VPo0GSWmUvKGHpFr/+QO6IshdMKarUBKXoKqJSSjbNlUUbfiuJ+EH9JxOIh+OFEVg2uMi+piZ+TUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zZuzExnM; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-40ab48f3924so16778335ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757430729; x=1758035529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFJzjlzQQCyCcPFb5G6GjNX4A5H/YmeDr19NbkN72Dg=;
        b=zZuzExnMVl77VNm0dx0EDb5HfbKbSqCjwuneFTOHv5V6Fu45ylzw1SOFNAqHQXN5zD
         i5pd2DIGvSyoTQAl9GObJUFjJptI3OJ9peiduRf7WRL2DRWypxpoBZlP7Ulsm0Ii/Ugh
         dpUlIYNGG5rq8oGu3eeWMjVkkw+H3jdfNHbh9HLUHmxd0fdghsp88Sgzxz6uN3yMnHHh
         pb0DBcmFUgN6CN8FzCe8Bo3h2DKN5rtJsc15UvBePAB59wU//5BRZWE2STtWtrkDsxk5
         HsJcaDLxummjrp9iihMA7PFKLIEuQVGfu526aItdFAaQ0VIdSiJMLJn8s7ojB1SjDd9P
         hTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430729; x=1758035529;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFJzjlzQQCyCcPFb5G6GjNX4A5H/YmeDr19NbkN72Dg=;
        b=D4Zqd1BT3F7yfJ2Z1UQ4qdFeP27RjHBkZ+hRDDFZ1mERlP40nmCcRgyUcsFFSBTGD7
         yBT0Yw8Rca2dtagI+0cRIQ1g+ZVFlwGiEcTjibM4pjuP+qv5Y986yS0hzPGqWoDVDGWw
         IDfEKxjxvGBAEvU2x0Xal/KMmG0AGSJufWlai+hiUhqwjl9emtAK2LwiUQaOo54vq1lY
         U4ldWOzCd1n8BRMVZaAF3468Uf6fLbHnJuKaafwAAt8nBYY8F+btx62lyeJXq8oXwJqD
         BTmX15A01wCD9solZ8GW/QpLdT9QGqR+/v4dByUd70gLqPBBirb2zVs4oJMVu2DKEQ5b
         c37A==
X-Gm-Message-State: AOJu0YzpsIPpX3Cu8UpD4P7o8wVCMZ0LYkOU1DwgUOX6yZYldF4bLMbc
	c8WGi1QirdvA6ctBcz8n6eXPufYbzs4TgfrBJFoj/hJx7BopvY/Zu1HwXWhP+K3is9o=
X-Gm-Gg: ASbGncvLI4BOxyLFeycCjyriCI9pA6zpxuGYYBhdXguxC3ihVffXdduF4Y6E3a//wHc
	amszlExO7frTQ6t0HBDLmowWszz4/5veDbNYehThtuU0381qwCeD1o03EBhyfewVKVRvmXN5Eye
	ASOkKK9+H3mgHcrCFrkyImNbIk9OHrRuosL+Q11fbR/Io8O9sDPKoP+wvgdHBFxy6UvZerKkgEC
	8hTkPgADuzFUbO00CfhYw8ljNNjFc2gtH1uyFviwENLCB8Bppxa5ClhBRqlzWhPWNVzx2jd8xvN
	wJzToMbhRt4yZ/Y+vK0xPLWx5pHmpu+gXL1LYLzH2coCGSQ5+PRH2vITxhnQATvmajLtCoD9+WZ
	Cr+Oqy08VDWH1Gw==
X-Google-Smtp-Source: AGHT+IFgqzt/9I3VONQyoxVxbosvYBwChRjjNvp98cCppEYVcKSCDkzbvqVGEoph44lNL5D4uJ8LAQ==
X-Received: by 2002:a05:6e02:1fe2:b0:411:2f0a:edfc with SMTP id e9e14a558f8ab-4112f0af257mr31296945ab.6.1757430729112;
        Tue, 09 Sep 2025 08:12:09 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-51020b6d937sm7590679173.80.2025.09.09.08.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:12:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>
In-Reply-To: <20250905085141.93357-1-marco.crivellari@suse.com>
References: <20250905085141.93357-1-marco.crivellari@suse.com>
Subject: Re: [PATCH 0/3] block: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
Message-Id: <175743072839.109608.9014903338772554601.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 09:12:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 05 Sep 2025 10:51:38 +0200, Marco Crivellari wrote:
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> [...]

Applied, thanks!

[1/3] drivers/block: replace use of system_wq with system_percpu_wq
      commit: 51723bf92679427bba09a76fc13e1b0a93b680bc
[2/3] drivers/block: replace use of system_unbound_wq with system_dfl_wq
      commit: 456cefcb312d90d12dbcf7eaf6b3f7cfae6f622b
[3/3] drivers/block: WQ_PERCPU added to alloc_workqueue users
      commit: d7b1cdc9108f46f47a0899597d6fa270f64dd98c

Best regards,
-- 
Jens Axboe




